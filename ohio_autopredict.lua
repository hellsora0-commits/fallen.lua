--[[
================================================================================
  Ohio AUTO-PREDICT Mouse Aimbot
  API: Project Vector (https://projectvector.cc/lua)
  Callback: OnFrame
  Mouse: input.MoveMouse / utility.MouseMove
  Entity: entity.GetPlayers, HeadPosition, Velocity, GetBoneScreen
  Draw: draw.WorldToScreen, draw.Circle, draw.RectFilled, draw.Text

  Auto-Predict (no wiki table):
    • live p.Velocity + position EMA
    • quadratic intercept for time-of-flight
    • distance-adaptive bullet speed
    • ping + gravity drop
================================================================================
]]

--------------------------------------------------------------------------------
-- SETTINGS (custom UI edits these)
--------------------------------------------------------------------------------
local CFG = {
    aim_on         = false,
    aim_vk         = 0x02,   -- RMB
    fov            = 220,
    smooth         = 0.30,
    range          = 1200,
    bone           = 0,      -- 0 Head, 1 Torso, 2 Closest
    sticky         = true,
    pred_on        = true,
    pred_strength  = 1.15,
    ping_ms        = 55,
    drop_on        = true,
    drop_strength  = 0.80,
    speed_override = 0,      -- 0 = AUTO by distance
    draw_fov       = true,
    draw_pred      = true,
    waiting_key    = false,
}

local UI = {
    open = true,
    x = 60, y = 60, w = 330, h = 480,
    drag = false, dx = 0, dy = 0,
    tab = 1,
}

local hist = {}
local sticky_id = nil
local prev_lmb, prev_ins = false, false

--------------------------------------------------------------------------------
-- SAFE API WRAPPERS (PascalCase + snake_case per Vector docs)
--------------------------------------------------------------------------------
local function try(fn, ...)
    if not fn then return nil end
    local ok, a, b, c, d = pcall(fn, ...)
    if ok then return a, b, c, d end
    return nil
end

local function get_players()
    if entity then
        if entity.GetPlayers then return entity.GetPlayers() or {} end
        if entity.get_players then return entity.get_players() or {} end
    end
    return {}
end

local function get_local()
    if entity then
        if entity.GetLocalPlayer then return entity.GetLocalPlayer() end
        if entity.get_local_player then return entity.get_local_player() end
    end
    return nil
end

local function is_key(vk)
    if not vk or vk == 0 then return false end
    if input and input.IsKeyDown then
        local r = try(input.IsKeyDown, vk)
        if r then return true end
    end
    if input and input.is_key_down then
        local r = try(input.is_key_down, vk)
        if r then return true end
    end
    return false
end

local function mouse_pos()
    if input and input.GetMousePosition then
        local x, y = try(input.GetMousePosition)
        if x then return x, y end
    end
    if utility and utility.GetMousePos then
        local x, y = try(utility.GetMousePos)
        if x then return x, y end
    end
    return 0, 0
end

local function screen_center()
    if input and input.GetScreenCenter then
        local x, y = try(input.GetScreenCenter)
        if x then return x, y end
    end
    if draw and draw.GetScreenSize then
        local w, h = try(draw.GetScreenSize)
        if w then return w * 0.5, h * 0.5 end
    end
    if utility and utility.GetScreenSize then
        local w, h = try(utility.GetScreenSize)
        if w then return w * 0.5, h * 0.5 end
    end
    if utility and utility.get_screen_size then
        local w, h = try(utility.get_screen_size)
        if w then return w * 0.5, h * 0.5 end
    end
    return 960, 540
end

local function w2s(x, y, z)
    -- draw.WorldToScreen → sx, sy, valid
    if draw then
        if draw.WorldToScreen then
            local sx, sy, ok = try(draw.WorldToScreen, x, y, z)
            if sx and ok ~= false then return sx, sy end
        end
        if draw.world_to_screen then
            local sx, sy, ok = try(draw.world_to_screen, x, y, z)
            if sx and ok ~= false then return sx, sy end
        end
    end
    if utility then
        if utility.WorldToScreen then
            local sx, sy, ok = try(utility.WorldToScreen, x, y, z)
            if sx and ok ~= false then return sx, sy end
        end
        if utility.world_to_screen then
            local sx, sy, ok = try(utility.world_to_screen, x, y, z)
            if sx and ok ~= false then return sx, sy end
        end
    end
    return nil, nil
end

local function move_mouse(dx, dy)
    if math.abs(dx) < 0.08 and math.abs(dy) < 0.08 then return end
    if input and input.MoveMouse then
        try(input.MoveMouse, dx, dy)
        return
    end
    if utility and utility.MouseMove then
        try(utility.MouseMove, dx, dy)
        return
    end
    if utility and utility.mouse_move then
        try(utility.mouse_move, dx, dy)
    end
end

local function v3(v)
    if not v then return nil end
    local x = v.X or v.x
    local y = v.Y or v.y
    local z = v.Z or v.z
    if type(x) ~= "number" then return nil end
    return x, y, z
end

local function len3(x, y, z)
    return math.sqrt(x * x + y * y + z * z)
end

local function now()
    if type(tick) == "function" then return tick() end
    if utility and utility.get_time then
        local t = try(utility.get_time)
        if t then return t end
    end
    return os.clock()
end

local function pid(p)
    return p.Address or p.UserId or p.Name or p.name or tostring(p)
end

local function is_enemy(p)
    if p.IsLocal or p.is_local then return false end
    if p.IsAlive == false or p.is_alive == false then return false end
    return true
end

--------------------------------------------------------------------------------
-- DRAW PRIMITIVES
--------------------------------------------------------------------------------
local function C(r, g, b, a) return { r, g, b, a or 1 } end

local function d_rect(x, y, w, h, c, fill)
    if not draw then return end
    if fill then
        if draw.RectFilled then try(draw.RectFilled, x, y, w, h, c)
        elseif draw.rect_filled then try(draw.rect_filled, x, y, w, h, c) end
    else
        if draw.Rect then try(draw.Rect, x, y, w, h, c)
        elseif draw.rect then try(draw.rect, x, y, w, h, c) end
    end
end

local function d_text(x, y, s, c)
    if not draw then return end
    if draw.Text then try(draw.Text, x, y, s, c)
    elseif draw.text then try(draw.text, x, y, s, c) end
end

local function d_circle(x, y, r, c, fill)
    if not draw then return end
    if fill then
        if draw.CircleFilled then try(draw.CircleFilled, x, y, r, c)
        elseif draw.circle_filled then try(draw.circle_filled, x, y, r, c)
        elseif draw.Circle then try(draw.Circle, x, y, r, c) end
    else
        if draw.Circle then try(draw.Circle, x, y, r, c)
        elseif draw.circle then try(draw.circle, x, y, r, c) end
    end
end

--------------------------------------------------------------------------------
-- CUSTOM UI
--------------------------------------------------------------------------------
local function inbox(mx, my, x, y, w, h)
    return mx >= x and mx <= x + w and my >= y and my <= y + h
end

local function edge_click()
    local down = is_key(0x01)
    local c = down and not prev_lmb
    prev_lmb = down
    return c
end

local function edge_ins()
    local down = is_key(0x2D)
    local c = down and not prev_ins
    prev_ins = down
    return c
end

local VKN = {
    [0x01] = "LMB", [0x02] = "RMB", [0x04] = "MMB",
    [0x05] = "Mouse4", [0x06] = "Mouse5",
    [0x10] = "SHIFT", [0x11] = "CTRL", [0x12] = "ALT",
    [0x20] = "SPACE", [0x09] = "TAB",
}
for i = 0x30, 0x39 do VKN[i] = string.char(i) end
for i = 0x41, 0x5A do VKN[i] = string.char(i) end

local function vkname(vk)
    return VKN[vk] or string.format("VK_%X", vk or 0)
end

local function ui_cb(x, y, label, key)
    local mx, my = mouse_pos()
    local on = CFG[key]
    d_rect(x, y, 16, 16, C(0.14, 0.14, 0.17), true)
    d_rect(x, y, 16, 16, C(0.45, 0.45, 0.5), false)
    if on then d_rect(x + 3, y + 3, 10, 10, C(0.25, 0.85, 1.0), true) end
    d_text(x + 24, y + 1, label, C(0.92, 0.92, 0.95))
    if edge_click() and inbox(mx, my, x, y, 220, 18) then
        CFG[key] = not CFG[key]
    end
    return y + 24
end

local function ui_sl(x, y, w, label, key, mn, mxv, flt)
    local mx, my = mouse_pos()
    local val = CFG[key]
    if type(val) ~= "number" then val = mn end
    local t = (val - mn) / (mxv - mn)
    if t < 0 then t = 0 elseif t > 1 then t = 1 end
    local s = flt and string.format("%s  %.2f", label, val)
                 or string.format("%s  %d", label, math.floor(val + 0.5))
    d_text(x, y, s, C(0.85, 0.85, 0.9))
    local sy = y + 16
    d_rect(x, sy, w, 10, C(0.11, 0.11, 0.13), true)
    d_rect(x, sy, w * t, 10, C(0.22, 0.68, 0.95), true)
    d_rect(x, sy, w, 10, C(0.4, 0.4, 0.45), false)
    if is_key(0x01) and inbox(mx, my, x, sy - 4, w, 18) then
        local nt = (mx - x) / w
        if nt < 0 then nt = 0 elseif nt > 1 then nt = 1 end
        local nv = mn + nt * (mxv - mn)
        CFG[key] = flt and nv or math.floor(nv + 0.5)
    end
    return y + 36
end

local function ui_bone(x, y)
    local mx, my = mouse_pos()
    d_text(x, y, "Bone", C(0.85, 0.85, 0.9))
    local names = { "Head", "Torso", "Closest" }
    local bx = x
    for i, n in ipairs(names) do
        local sel = CFG.bone == (i - 1)
        d_rect(bx, y + 16, 72, 20, sel and C(0.18, 0.5, 0.75) or C(0.13, 0.13, 0.15), true)
        d_rect(bx, y + 16, 72, 20, C(0.4, 0.4, 0.45), false)
        d_text(bx + 10, y + 18, n, C(1, 1, 1))
        if edge_click() and inbox(mx, my, bx, y + 16, 72, 20) then
            CFG.bone = i - 1
        end
        bx = bx + 78
    end
    return y + 44
end

local function ui_key(x, y)
    local mx, my = mouse_pos()
    d_text(x, y, "Aim Key", C(0.85, 0.85, 0.9))
    local lab = CFG.waiting_key and "[ press... ]" or vkname(CFG.aim_vk)
    d_rect(x + 90, y - 1, 130, 20, CFG.waiting_key and C(0.55, 0.25, 0.1) or C(0.13, 0.13, 0.15), true)
    d_rect(x + 90, y - 1, 130, 20, C(0.4, 0.4, 0.45), false)
    d_text(x + 98, y + 1, lab, C(1, 1, 1))
    if edge_click() and inbox(mx, my, x + 90, y - 1, 130, 20) then
        CFG.waiting_key = true
    end
    if CFG.waiting_key then
        local scan = { 0x01, 0x02, 0x04, 0x05, 0x06, 0x10, 0x11, 0x12, 0x20, 0x09 }
        for i = 0x30, 0x39 do scan[#scan + 1] = i end
        for i = 0x41, 0x5A do scan[#scan + 1] = i end
        for _, vk in ipairs(scan) do
            if is_key(vk) then
                CFG.aim_vk = vk
                CFG.waiting_key = false
                break
            end
        end
    end
    return y + 28
end

local function ui_tab(x, y, idx, name)
    local mx, my = mouse_pos()
    local sel = UI.tab == idx
    d_rect(x, y, 92, 22, sel and C(0.16, 0.42, 0.68) or C(0.11, 0.11, 0.13), true)
    d_rect(x, y, 92, 22, C(0.35, 0.35, 0.4), false)
    d_text(x + 22, y + 3, name, C(1, 1, 1))
    if edge_click() and inbox(mx, my, x, y, 92, 22) then
        UI.tab = idx
    end
end

local function draw_ui()
    if not UI.open then return end
    local mx, my = mouse_pos()
    local x, y, w, h = UI.x, UI.y, UI.w, UI.h

    -- drag
    if is_key(0x01) and inbox(mx, my, x, y, w, 28) then
        if not UI.drag then
            UI.drag = true
            UI.dx = mx - x
            UI.dy = my - y
        end
    end
    if UI.drag then
        if is_key(0x01) then
            UI.x = mx - UI.dx
            UI.y = my - UI.dy
            x, y = UI.x, UI.y
        else
            UI.drag = false
        end
    end

    d_rect(x, y, w, h, C(0.07, 0.07, 0.09, 0.95), true)
    d_rect(x, y, w, h, C(0.28, 0.55, 0.88), false)
    d_rect(x, y, w, 28, C(0.1, 0.2, 0.36), true)
    d_text(x + 10, y + 6, "Ohio Auto-Predict", C(1, 1, 1))
    d_text(x + w - 78, y + 6, "[INSERT]", C(0.55, 0.65, 0.75))

    local ty = y + 36
    ui_tab(x + 12, ty, 1, "Aim")
    ui_tab(x + 110, ty, 2, "Predict")
    ui_tab(x + 208, ty, 3, "Visual")

    local cy = ty + 34
    local lx, sw = x + 14, w - 28

    if UI.tab == 1 then
        cy = ui_cb(lx, cy, "Enable Aimbot", "aim_on")
        cy = ui_key(lx, cy)
        cy = ui_sl(lx, cy, sw, "FOV", "fov", 30, 700, false)
        cy = ui_sl(lx, cy, sw, "Smooth", "smooth", 0.08, 1.0, true)
        cy = ui_sl(lx, cy, sw, "Range", "range", 50, 2000, false)
        cy = ui_bone(lx, cy)
        cy = ui_cb(lx, cy, "Sticky Aim", "sticky")
    elseif UI.tab == 2 then
        cy = ui_cb(lx, cy, "Auto Predict", "pred_on")
        cy = ui_sl(lx, cy, sw, "Predict Strength", "pred_strength", 0.5, 2.5, true)
        cy = ui_sl(lx, cy, sw, "Ping (ms)", "ping_ms", 0, 250, false)
        cy = ui_cb(lx, cy, "Bullet Drop", "drop_on")
        cy = ui_sl(lx, cy, sw, "Drop Strength", "drop_strength", 0.0, 2.5, true)
        cy = ui_sl(lx, cy, sw, "Bullet Speed (0=AUTO)", "speed_override", 0, 3500, false)
        d_text(lx, cy + 6, "AUTO = speed by distance (no wiki)", C(0.5, 0.55, 0.6))
    else
        cy = ui_cb(lx, cy, "Draw FOV", "draw_fov")
        cy = ui_cb(lx, cy, "Show Predict Point", "draw_pred")
        d_text(lx, cy + 10, "INSERT toggles this menu", C(0.5, 0.55, 0.6))
    end
end

--------------------------------------------------------------------------------
-- AUTO PREDICT CORE
--------------------------------------------------------------------------------
local function auto_speed(dist)
    if CFG.speed_override and CFG.speed_override > 0 then
        return CFG.speed_override
    end
    -- Ohio-style bands
    if dist < 80 then return 1150
    elseif dist < 160 then return 1400
    elseif dist < 300 then return 1650
    elseif dist < 500 then return 1900
    elseif dist < 800 then return 2150
    else return 2400 end
end

local function velocity_of(p, id, x, y, z)
    local t = now()
    local lvx, lvy, lvz, live = 0, 0, 0, false

    -- official live property
    local a, b, c = v3(p.Velocity)
    if not a then a, b, c = v3(p.velocity) end
    if a then
        lvx, lvy, lvz, live = a, b, c, true
        -- clamp teleport spikes
        local sp = len3(lvx, lvy, lvz)
        if sp > 220 then
            local s = 220 / sp
            lvx, lvy, lvz = lvx * s, lvy * s, lvz * s
        end
    end

    local h = hist[id]
    local dvx, dvy, dvz = 0, 0, 0
    if h and h.t and (t - h.t) > 0.002 and (t - h.t) < 0.35 then
        local dt = t - h.t
        dvx = (x - h.x) / dt
        dvy = (y - h.y) / dt
        dvz = (z - h.z) / dt
        local k = 0.38
        dvx = (h.dvx or dvx) * (1 - k) + dvx * k
        dvy = (h.dvy or dvy) * (1 - k) + dvy * k
        dvz = (h.dvz or dvz) * (1 - k) + dvz * k
        local sp = len3(dvx, dvy, dvz)
        if sp > 220 then
            local s = 220 / sp
            dvx, dvy, dvz = dvx * s, dvy * s, dvz * s
        end
    end
    hist[id] = { x = x, y = y, z = z, t = t, dvx = dvx, dvy = dvy, dvz = dvz }

    if live then
        return lvx * 0.72 + dvx * 0.28,
               lvy * 0.72 + dvy * 0.28,
               lvz * 0.72 + dvz * 0.28
    end
    return dvx, dvy, dvz
end

-- |P + V*t - O| = speed * t  → quadratic
local function intercept_t(ox, oy, oz, px, py, pz, vx, vy, vz, speed)
    local dx, dy, dz = px - ox, py - oy, pz - oz
    local a = vx * vx + vy * vy + vz * vz - speed * speed
    local b = 2 * (dx * vx + dy * vy + dz * vz)
    local c = dx * dx + dy * dy + dz * dz
    local t

    if math.abs(a) < 1e-5 then
        if math.abs(b) > 1e-6 then
            t = -c / b
        else
            t = len3(dx, dy, dz) / math.max(speed, 1)
        end
    else
        local disc = b * b - 4 * a * c
        if disc < 0 then
            t = len3(dx, dy, dz) / math.max(speed, 1)
        else
            local s = math.sqrt(disc)
            local t1 = (-b - s) / (2 * a)
            local t2 = (-b + s) / (2 * a)
            if t1 > 0.001 and t2 > 0.001 then
                t = math.min(t1, t2)
            elseif t1 > 0.001 then
                t = t1
            elseif t2 > 0.001 then
                t = t2
            else
                t = len3(dx, dy, dz) / math.max(speed, 1)
            end
        end
    end

    if not t or t ~= t or t < 0.001 then -- NaN guard
        t = len3(dx, dy, dz) / math.max(speed, 1)
    end
    if t > 1.6 then t = 1.6 end
    return t
end

local function predict_point(p, id, hx, hy, hz, lx, ly, lz)
    if not CFG.pred_on then return hx, hy, hz end

    local vx, vy, vz = velocity_of(p, id, hx, hy, hz)
    local dist = len3(hx - lx, hy - ly, hz - lz)
    local speed = auto_speed(dist)
    local str = CFG.pred_strength or 1.15
    vx, vy, vz = vx * str, vy * str, vz * str

    local ping = (CFG.ping_ms or 55) / 1000
    local t = intercept_t(lx, ly, lz, hx, hy, hz, vx, vy, vz, speed) + ping

    local px = hx + vx * t
    local py = hy + vy * t
    local pz = hz + vz * t

    if CFG.drop_on then
        -- mild projectile arc (Ohio not full battlefield gravity)
        local g = 130
        py = py + 0.5 * g * t * t * (CFG.drop_strength or 0.80)
    end
    return px, py, pz
end

--------------------------------------------------------------------------------
-- TARGET SELECTION
--------------------------------------------------------------------------------
local function bone_world(p)
    local mode = CFG.bone or 0

    -- prefer official HeadPosition
    local hx, hy, hz = v3(p.HeadPosition)
    if not hx then hx, hy, hz = v3(p.head_position) end
    local rx, ry, rz = v3(p.Position)
    if not rx then rx, ry, rz = v3(p.position) end
    if not hx and rx then hx, hy, hz = rx, ry + 1.55, rz end
    if not hx then return nil end

    if mode == 1 then -- Torso
        if rx then return rx, ry + 0.55, rz end
        return hx, hy - 0.55, hz
    end

    if mode == 2 then -- Closest on screen
        local cx, cy = screen_center()
        local pts = {
            { hx, hy, hz },
            { rx or hx, (ry or hy) + 0.55, rz or hz },
            { rx or hx, (ry or hy) - 0.65, rz or hz },
        }
        -- also try GetBoneScreen if available
        local best, bd = pts[1], 1e18
        for _, c in ipairs(pts) do
            local sx, sy = w2s(c[1], c[2], c[3])
            if sx then
                local d = (sx - cx) ^ 2 + (sy - cy) ^ 2
                if d < bd then bd, best = d, c end
            end
        end
        return best[1], best[2], best[3]
    end

    return hx, hy, hz
end

local function local_pos()
    local lp = get_local()
    if lp then
        local x, y, z = v3(lp.HeadPosition or lp.head_position)
        if x then return x, y, z end
        x, y, z = v3(lp.Position or lp.position)
        if x then return x, y, z end
    end
    if camera and camera.GetPosition then
        local p = try(camera.GetPosition)
        if p then
            local x, y, z = v3(p)
            if x then return x, y, z end
        end
    end
    return nil
end

local function pick_target(lx, ly, lz)
    local fov = CFG.fov or 220
    local maxr = CFG.range or 1200
    local cx, cy = screen_center()
    local list = get_players()

    -- sticky
    if CFG.sticky and sticky_id then
        for _, p in ipairs(list) do
            if is_enemy(p) and pid(p) == sticky_id then
                local x, y, z = bone_world(p)
                if x and len3(x - lx, y - ly, z - lz) <= maxr * 1.35 then
                    local sx, sy = w2s(x, y, z)
                    if sx then
                        local fd = math.sqrt((sx - cx) ^ 2 + (sy - cy) ^ 2)
                        if fd <= fov * 1.7 then
                            return p, x, y, z
                        end
                    end
                end
            end
        end
        sticky_id = nil
    end

    local best, bx, by, bz, bfd = nil, nil, nil, nil, 1e18
    for _, p in ipairs(list) do
        if not is_enemy(p) then goto cont end
        local x, y, z = bone_world(p)
        if not x then goto cont end
        local d3 = len3(x - lx, y - ly, z - lz)
        if d3 > maxr then goto cont end
        local sx, sy = w2s(x, y, z)
        if not sx then goto cont end
        local fd = math.sqrt((sx - cx) ^ 2 + (sy - cy) ^ 2)
        if fd <= fov and fd < bfd then
            bfd, best, bx, by, bz = fd, p, x, y, z
        end
        ::cont::
    end

    if best then sticky_id = pid(best) end
    return best, bx, by, bz
end

--------------------------------------------------------------------------------
-- FRAME
--------------------------------------------------------------------------------
function OnFrame()
    -- toggle UI
    if edge_ins() then
        UI.open = not UI.open
    end
    draw_ui()

    if not CFG.aim_on then
        sticky_id = nil
        return
    end

    local cx, cy = screen_center()
    if CFG.draw_fov then
        d_circle(cx, cy, CFG.fov or 220, C(1, 1, 1, 0.38), false)
    end

    if not is_key(CFG.aim_vk) then
        sticky_id = nil
        return
    end

    -- don't fight UI clicks
    if UI.open then
        local mx, my = mouse_pos()
        if inbox(mx, my, UI.x, UI.y, UI.w, UI.h) then return end
    end

    local lx, ly, lz = local_pos()
    if not lx then return end

    local p, hx, hy, hz = pick_target(lx, ly, lz)
    if not p or not hx then return end

    local px, py, pz = predict_point(p, pid(p), hx, hy, hz, lx, ly, lz)
    local sx, sy = w2s(px, py, pz)
    if not sx then return end

    if CFG.draw_pred then
        d_circle(sx, sy, 4, C(1, 0.18, 0.18, 0.95), true)
    end

    local sm = CFG.smooth or 0.30
    if sm < 0.08 then sm = 0.08 end
    if sm > 1 then sm = 1 end

    local mx, my = mouse_pos()
    move_mouse((sx - mx) * sm, (sy - my) * sm)
end

on_frame = OnFrame
onFrame = OnFrame

print("[Ohio] Auto-Predict loaded | INSERT = UI | Vector API")
