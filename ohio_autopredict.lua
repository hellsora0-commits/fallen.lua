--[[
  Ohio AUTO-PREDICT — Project Vector
  Custom UI ported from Infernal patterns:
    draw.rect_filled(x,y,w,h,col,rounding)
    draw.text(x,y,str,col,size)
    utility.get_mouse_pos / input.get_mouse_position
    input.is_key_down(0x01) + edge click
    panel drag on title bar only
  Toggle: F8
]]

--------------------------------------------------------------------------------
-- CONFIG
--------------------------------------------------------------------------------
local CFG = {
    aim_on = false,
    aim_vk = 0x02,
    fov = 200,
    smooth = 0.55,
    range = 1200,
    bone = 0,
    sticky = true,
    pred_on = true,
    pred_strength = 0.75,
    ping_ms = 40,
    drop_on = false,
    drop_strength = 0.25,
    speed_override = 0,
    draw_fov = true,
    draw_pred = true,
}

local UI = {
    open = true,
    x = 60, y = 60, w = 320, h = 420,
    dragging = false,
    off_x = 0, off_y = 0,
    tab = 1,
    waiting_key = false,
    wait_lmb_up = false,
}

local hist, sticky_id = {}, nil
local prev_lmb, prev_f8 = false, false
local mx, my, lmb, lmb_click = 0, 0, false, false

--------------------------------------------------------------------------------
-- INPUT (Infernal-style)
--------------------------------------------------------------------------------
local function update_input()
    mx, my = 0, 0
    local util_mouse = utility and (utility.get_mouse_pos or utility.GetMousePos)
    local input_mouse = input and (input.get_mouse_pos or input.get_mouse_position or input.GetMousePosition)
    if util_mouse then
        local a, b = util_mouse()
        mx, my = tonumber(a) or 0, tonumber(b) or 0
    elseif input_mouse then
        local a, b = input_mouse()
        mx, my = tonumber(a) or 0, tonumber(b) or 0
    end

    local key_fn = input and (input.is_key_down or input.IsKeyDown)
    lmb = key_fn and key_fn(0x01) == true or false
    lmb_click = lmb and not prev_lmb
    prev_lmb = lmb
end

local function key_down(vk)
    if not vk then return false end
    local fn = input and (input.is_key_down or input.IsKeyDown)
    return fn and fn(vk) == true or false
end

local function hover(x, y, w, h)
    return mx >= x and my >= y and mx <= x + w and my <= y + h
end

local function clicked(x, y, w, h)
    return lmb_click and hover(x, y, w, h)
end

--------------------------------------------------------------------------------
-- DRAW (Infernal signatures)
--------------------------------------------------------------------------------
local function rect_filled(x, y, w, h, col, rounding)
    if not draw then return end
    rounding = rounding or 0
    local fn = draw.rect_filled or draw.RectFilled or draw.filled_rect
    if fn then
        pcall(fn, x, y, w, h, col, rounding)
        return
    end
    if draw.box then pcall(draw.box, x, y, w, h, col) end
end

local function rect_outline(x, y, w, h, col, rounding)
    if not draw then return end
    local fn = draw.rect or draw.Rect
    if fn then pcall(fn, x, y, w, h, col, rounding or 0, 1) end
end

local function text(x, y, str, col, size)
    if not draw then return end
    size = size or 13
    local fn = draw.text or draw.Text
    if fn then pcall(fn, x, y, tostring(str), col, size) end
end

local function circle(x, y, r, col, filled)
    if not draw then return end
    if filled then
        local fn = draw.circle_filled or draw.CircleFilled
        if fn then pcall(fn, x, y, r, col, 20) return end
    end
    local fn = draw.circle or draw.Circle
    if fn then pcall(fn, x, y, r, col, 24, 1) end
end

local function screen_size()
    local fn = (draw and (draw.get_screen_size or draw.GetScreenSize))
            or (utility and (utility.get_screen_size or utility.GetScreenSize))
    if fn then
        local w, h = fn()
        if w then return w, h end
    end
    return 1920, 1080
end

local function screen_center()
    local fn = input and (input.get_screen_center or input.GetScreenCenter)
    if fn then
        local x, y = fn()
        if x then return x, y end
    end
    local w, h = screen_size()
    return w * 0.5, h * 0.5
end

local function w2s(x, y, z)
    local fn = (draw and (draw.world_to_screen or draw.WorldToScreen))
            or (utility and (utility.world_to_screen or utility.WorldToScreen))
    if not fn then return nil, nil end
    local sx, sy, ok = fn(x, y, z)
    if type(sx) == "number" and ok ~= false then return sx, sy end
    return nil, nil
end

local function move_mouse(dx, dy)
    if math.abs(dx) < 0.05 and math.abs(dy) < 0.05 then return end
    local fn = (input and (input.move_mouse or input.MoveMouse))
            or (utility and (utility.mouse_move or utility.MouseMove))
    if fn then pcall(fn, dx, dy) end
end

--------------------------------------------------------------------------------
-- UI WIDGETS
--------------------------------------------------------------------------------
local ACCENT = { 0.25, 0.75, 1.0, 1 }
local BG = { 0.07, 0.07, 0.09, 0.96 }
local BG2 = { 0.12, 0.12, 0.15, 1 }
local TEXT = { 0.92, 0.92, 0.95, 1 }
local MUTED = { 0.55, 0.58, 0.62, 1 }

local function ui_checkbox(x, y, label, key)
    local on = CFG[key]
    rect_filled(x, y, 16, 16, BG2, 3)
    rect_outline(x, y, 16, 16, { 0.4, 0.4, 0.45, 1 }, 3)
    if on then rect_filled(x + 3, y + 3, 10, 10, ACCENT, 2) end
    text(x + 24, y + 1, label, TEXT, 13)
    if clicked(x, y, 240, 18) then
        CFG[key] = not CFG[key]
    end
    return y + 26
end

local function ui_slider(x, y, w, label, key, mn, mx, is_float)
    local val = CFG[key]
    if type(val) ~= "number" then val = mn end
    local t = (val - mn) / (mx - mn)
    if t < 0 then t = 0 elseif t > 1 then t = 1 end
    local disp = is_float and string.format("%s  %.2f", label, val)
                          or string.format("%s  %d", label, math.floor(val + 0.5))
    text(x, y, disp, TEXT, 13)
    local sy = y + 17
    rect_filled(x, sy, w, 12, BG2, 3)
    rect_filled(x, sy, math.max(2, w * t), 12, ACCENT, 3)
    rect_outline(x, sy, w, 12, { 0.35, 0.35, 0.4, 1 }, 3)
    if lmb and hover(x, sy - 2, w, 16) then
        local nt = (mx - x) / w
        if nt < 0 then nt = 0 elseif nt > 1 then nt = 1 end
        local nv = mn + nt * (mx - mn)
        -- fix: use mxv not mx
        nv = mn + nt * (mx - mn)
    end
    -- CORRECT max is parameter mx - shadowing mouse mx! fix below in call site
    return y + 40, sy, w, mn, mx, is_float, key
end

-- fixed slider without variable shadow
local function ui_slider2(x, y, width, label, key, mn, mxv, is_float)
    local val = CFG[key]
    if type(val) ~= "number" then val = mn end
    local t = (val - mn) / (mxv - mn)
    if t < 0 then t = 0 elseif t > 1 then t = 1 end
    local disp = is_float and string.format("%s  %.2f", label, val)
                          or string.format("%s  %d", label, math.floor(val + 0.5))
    text(x, y, disp, TEXT, 13)
    local sy = y + 17
    rect_filled(x, sy, width, 12, BG2, 3)
    rect_filled(x, sy, math.max(2, width * t), 12, ACCENT, 3)
    rect_outline(x, sy, width, 12, { 0.35, 0.35, 0.4, 1 }, 3)
    if lmb and hover(x, sy - 2, width, 16) then
        local nt = (mx - x) / width
        if nt < 0 then nt = 0 elseif nt > 1 then nt = 1 end
        local nv = mn + nt * (mxv - mn)
        CFG[key] = is_float and nv or math.floor(nv + 0.5)
    end
    return y + 40
end

local function ui_bone(x, y)
    text(x, y, "Bone", TEXT, 13)
    local names = { "Head", "Torso", "Closest" }
    local bx = x
    for i, n in ipairs(names) do
        local sel = CFG.bone == (i - 1)
        rect_filled(bx, y + 16, 78, 22, sel and { 0.15, 0.45, 0.75, 1 } or BG2, 4)
        rect_outline(bx, y + 16, 78, 22, { 0.4, 0.4, 0.45, 1 }, 4)
        text(bx + 14, y + 20, n, TEXT, 12)
        if clicked(bx, y + 16, 78, 22) then CFG.bone = i - 1 end
        bx = bx + 84
    end
    return y + 48
end

local VKN = {
    [0x01] = "LMB", [0x02] = "RMB", [0x04] = "MMB",
    [0x05] = "M4", [0x06] = "M5",
    [0x10] = "SHIFT", [0x11] = "CTRL", [0x12] = "ALT",
    [0x20] = "SPACE", [0x09] = "TAB",
}
for i = 0x30, 0x39 do VKN[i] = string.char(i) end
for i = 0x41, 0x5A do VKN[i] = string.char(i) end

local function ui_keybind(x, y)
    text(x, y, "Aim Key", TEXT, 13)
    local lab = UI.waiting_key and "PRESS KEY..." or (VKN[CFG.aim_vk] or string.format("%X", CFG.aim_vk))
    local bx, by, bw, bh = x + 90, y - 2, 140, 22
    rect_filled(bx, by, bw, bh, UI.waiting_key and { 0.55, 0.25, 0.1, 1 } or BG2, 4)
    rect_outline(bx, by, bw, bh, { 0.4, 0.4, 0.45, 1 }, 4)
    text(bx + 12, by + 4, lab, TEXT, 12)

    if clicked(bx, by, bw, bh) then
        UI.waiting_key = true
        UI.wait_lmb_up = true  -- Infernal: ignore until LMB released
    end

    if UI.waiting_key then
        if UI.wait_lmb_up then
            if not lmb then UI.wait_lmb_up = false end
        else
            local scan = { 0x02, 0x04, 0x05, 0x06, 0x10, 0x11, 0x12, 0x20, 0x09 }
            for i = 0x30, 0x39 do scan[#scan + 1] = i end
            for i = 0x41, 0x5A do scan[#scan + 1] = i end
            -- also allow LMB as bind after release
            scan[#scan + 1] = 0x01
            for _, vk in ipairs(scan) do
                if key_down(vk) then
                    CFG.aim_vk = vk
                    UI.waiting_key = false
                    break
                end
            end
        end
    end
    return y + 30
end

local function ui_tab(x, y, idx, name)
    local sel = UI.tab == idx
    rect_filled(x, y, 92, 24, sel and { 0.14, 0.4, 0.7, 1 } or BG2, 4)
    rect_outline(x, y, 92, 24, { 0.35, 0.35, 0.4, 1 }, 4)
    text(x + 26, y + 5, name, TEXT, 12)
    if clicked(x, y, 92, 24) then UI.tab = idx end
end

local function draw_ui()
    -- watermark
    text(10, 10, "Ohio AP | F8 menu | AIM:" .. (CFG.aim_on and "ON" or "off"), { 0.3, 1, 0.55, 1 }, 13)

    if not UI.open then return end

    local x, y, w, h = UI.x, UI.y, UI.w, UI.h
    local title_h = 30

    -- DRAG title bar only (Infernal panel_drag)
    if lmb_click and hover(x, y, w, title_h) and not UI.waiting_key then
        UI.dragging = true
        UI.off_x = mx - x
        UI.off_y = my - y
    end
    if UI.dragging then
        if lmb then
            local sw, sh = screen_size()
            UI.x = math.max(0, math.min(sw - w, math.floor(mx - UI.off_x)))
            UI.y = math.max(0, math.min(sh - h, math.floor(my - UI.off_y)))
            x, y = UI.x, UI.y
        else
            UI.dragging = false
        end
    end

    -- panel
    rect_filled(x, y, w, h, BG, 6)
    rect_outline(x, y, w, h, ACCENT, 6)
    rect_filled(x, y, w, title_h, { 0.09, 0.18, 0.32, 1 }, 6)
    text(x + 12, y + 7, "OHIO AUTO-PREDICT", TEXT, 14)
    text(x + w - 70, y + 8, "F8", MUTED, 12)

    local ty = y + 40
    ui_tab(x + 12, ty, 1, "Aim")
    ui_tab(x + 110, ty, 2, "Predict")
    ui_tab(x + 208, ty, 3, "Visual")

    local cy = ty + 36
    local lx, sw = x + 14, w - 28

    if UI.tab == 1 then
        cy = ui_checkbox(lx, cy, "Enable Aimbot", "aim_on")
        cy = ui_keybind(lx, cy)
        cy = ui_slider2(lx, cy, sw, "FOV", "fov", 20, 800, false)
        cy = ui_slider2(lx, cy, sw, "Smooth", "smooth", 0.05, 1.0, true)
        cy = ui_slider2(lx, cy, sw, "Range", "range", 50, 2000, false)
        cy = ui_bone(lx, cy)
        cy = ui_checkbox(lx, cy, "Sticky Aim", "sticky")
    elseif UI.tab == 2 then
        cy = ui_checkbox(lx, cy, "Auto Predict", "pred_on")
        cy = ui_slider2(lx, cy, sw, "Predict Strength", "pred_strength", 0.5, 2.5, true)
        cy = ui_slider2(lx, cy, sw, "Ping ms", "ping_ms", 0, 250, false)
        cy = ui_checkbox(lx, cy, "Bullet Drop", "drop_on")
        cy = ui_slider2(lx, cy, sw, "Drop Strength", "drop_strength", 0.0, 2.5, true)
        cy = ui_slider2(lx, cy, sw, "Bullet Speed (0=AUTO)", "speed_override", 0, 3500, false)
    else
        cy = ui_checkbox(lx, cy, "Draw FOV", "draw_fov")
        cy = ui_checkbox(lx, cy, "Show Predict Point", "draw_pred")
        text(lx, cy + 6, "Drag window by title bar", MUTED, 12)
    end
end

--------------------------------------------------------------------------------
-- AIM / PREDICT
--------------------------------------------------------------------------------
local function v3(v)
    if not v then return nil end
    local a, b, c = v.X or v.x, v.Y or v.y, v.Z or v.z
    if type(a) ~= "number" then return nil end
    return a, b, c
end

local function len3(x, y, z) return math.sqrt(x * x + y * y + z * z) end

local function now()
    if type(tick) == "function" then return tick() end
    return os.clock()
end

local function get_players()
    if entity and entity.GetPlayers then return entity.GetPlayers() or {} end
    if entity and entity.get_players then return entity.get_players() or {} end
    return {}
end

local function get_local()
    if entity and entity.GetLocalPlayer then return entity.GetLocalPlayer() end
    if entity and entity.get_local_player then return entity.get_local_player() end
    return nil
end

local function pid(p) return p.Address or p.UserId or p.Name or p.name or tostring(p) end

local function is_enemy(p)
    if p.IsLocal or p.is_local then return false end
    if p.IsAlive == false or p.is_alive == false then return false end
    return true
end

local function auto_speed(dist)
    -- Ohio projectiles are relatively fast; underestimating speed = overlead = miss
    if CFG.speed_override and CFG.speed_override > 0 then return CFG.speed_override end
    if dist < 60 then return 1800
    elseif dist < 150 then return 2000
    elseif dist < 300 then return 2200
    elseif dist < 500 then return 2400
    else return 2600 end
end

local function velocity_of(p, id, x, y, z)
    local t = now()
    local lvx, lvy, lvz, live = 0, 0, 0, false
    local a, b, c = v3(p.Velocity)
    if a then
        lvx, lvy, lvz, live = a, b, c, true
        local sp = len3(lvx, lvy, lvz)
        if sp > 220 then local s = 220 / sp; lvx, lvy, lvz = lvx * s, lvy * s, lvz * s end
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
    end
    hist[id] = { x = x, y = y, z = z, t = t, dvx = dvx, dvy = dvy, dvz = dvz }
    if live then return lvx * 0.72 + dvx * 0.28, lvy * 0.72 + dvy * 0.28, lvz * 0.72 + dvz * 0.28 end
    return dvx, dvy, dvz
end

local function intercept_t(ox, oy, oz, px, py, pz, vx, vy, vz, speed)
    local dx, dy, dz = px - ox, py - oy, pz - oz
    local a = vx * vx + vy * vy + vz * vz - speed * speed
    local b = 2 * (dx * vx + dy * vy + dz * vz)
    local c = dx * dx + dy * dy + dz * dz
    local t
    if math.abs(a) < 1e-5 then
        t = (math.abs(b) > 1e-6) and (-c / b) or (len3(dx, dy, dz) / math.max(speed, 1))
    else
        local disc = b * b - 4 * a * c
        if disc < 0 then
            t = len3(dx, dy, dz) / math.max(speed, 1)
        else
            local s = math.sqrt(disc)
            local t1, t2 = (-b - s) / (2 * a), (-b + s) / (2 * a)
            if t1 > 0.001 and t2 > 0.001 then t = math.min(t1, t2)
            elseif t1 > 0.001 then t = t1
            elseif t2 > 0.001 then t = t2
            else t = len3(dx, dy, dz) / math.max(speed, 1) end
        end
    end
    if not t or t ~= t or t < 0.001 then t = len3(dx, dy, dz) / math.max(speed, 1) end
    if t > 1.6 then t = 1.6 end
    return t
end

local function predict_point(p, id, hx, hy, hz, lx, ly, lz)
    if not CFG.pred_on then return hx, hy, hz end

    local vx, vy, vz = velocity_of(p, id, hx, hy, hz)
    local dist = len3(hx - lx, hy - ly, hz - lz)
    if dist < 1 then return hx, hy, hz end

    -- horizontal speed only (ignore vertical jitter)
    local hspd = math.sqrt(vx * vx + vz * vz)

    -- standing / slow walk: aim head, no lead
    if hspd < 4 then
        return hx, hy, hz
    end

    local move_scale = 1.0
    if hspd < 14 then
        move_scale = (hspd - 4) / 10
        if move_scale > 1 then move_scale = 1 end
    end

    local speed = auto_speed(dist)
    local str = (CFG.pred_strength or 0.75) * move_scale
    local ping = (CFG.ping_ms or 40) / 1000

    -- time of flight (simple + reliable for Ohio)
    local t = dist / speed + ping
    if t > 0.55 then t = 0.55 end

    -- ONLY XZ lead — keep head height (red dot was going into the ground)
    local lx_ = vx * str * t
    local lz_ = vz * str * t

    -- hard cap lead distance in studs (main fix for "runs ahead but never hits")
    local lead = math.sqrt(lx_ * lx_ + lz_ * lz_)
    local MAX_LEAD = 7.5
    if lead > MAX_LEAD then
        local s = MAX_LEAD / lead
        lx_, lz_ = lx_ * s, lz_ * s
    end

    local px = hx + lx_
    local py = hy          -- never leave head height from velocity
    local pz = hz + lz_

    if CFG.drop_on and dist > 180 then
        local g = 70
        py = py + 0.5 * g * t * t * (CFG.drop_strength or 0.25)
    end
    return px, py, pz
end

local function bone_world(p)
    local hx, hy, hz = v3(p.HeadPosition)
    local rx, ry, rz = v3(p.Position)
    if not hx and rx then hx, hy, hz = rx, ry + 1.55, rz end
    if not hx then return nil end
    local mode = CFG.bone or 0
    if mode == 1 then
        if rx then return rx, ry + 0.55, rz end
        return hx, hy - 0.55, hz
    end
    if mode == 2 then
        local cx, cy = screen_center()
        local pts = {
            { hx, hy, hz },
            { rx or hx, (ry or hy) + 0.55, rz or hz },
            { rx or hx, (ry or hy) - 0.65, rz or hz },
        }
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
        local x, y, z = v3(lp.HeadPosition)
        if x then return x, y, z end
        x, y, z = v3(lp.Position)
        if x then return x, y, z end
    end
    return nil
end

local function pick_target(lx, ly, lz)
    local fov, maxr = CFG.fov or 200, CFG.range or 1200
    local cx, cy = screen_center()
    local list = get_players()

    if CFG.sticky and sticky_id then
        for _, p in ipairs(list) do
            if is_enemy(p) and pid(p) == sticky_id then
                local x, y, z = bone_world(p)
                if x and len3(x - lx, y - ly, z - lz) <= maxr * 1.35 then
                    local sx, sy = w2s(x, y, z)
                    if sx then
                        local fd = math.sqrt((sx - cx) ^ 2 + (sy - cy) ^ 2)
                        if fd <= fov * 1.7 then return p, x, y, z end
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
        if len3(x - lx, y - ly, z - lz) > maxr then goto cont end
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
function OnFrame()
    update_input()

    -- F8 toggle
    local f8 = key_down(0x77)
    if f8 and not prev_f8 then
        UI.open = not UI.open
    end
    prev_f8 = f8

    draw_ui()

    if not CFG.aim_on then
        sticky_id = nil
        return
    end

    local cx, cy = screen_center()
    if CFG.draw_fov then
        circle(cx, cy, CFG.fov or 200, { 1, 1, 1, 0.35 }, false)
    end

    if not key_down(CFG.aim_vk) then
        sticky_id = nil
        return
    end

    -- don't aim while using UI
    if UI.open and hover(UI.x, UI.y, UI.w, UI.h) then return end
    if UI.waiting_key or UI.dragging then return end

    local lx, ly, lz = local_pos()
    if not lx then return end

    local p, hx, hy, hz = pick_target(lx, ly, lz)
    if not p or not hx then return end

    local px, py, pz = predict_point(p, pid(p), hx, hy, hz, lx, ly, lz)
    local sx, sy = w2s(px, py, pz)
    if not sx then return end

    if CFG.draw_pred then
        circle(sx, sy, 4, { 1, 0.2, 0.2, 0.95 }, true)
    end

    local sm = CFG.smooth or 0.45
    if sm < 0.05 then sm = 0.05 end
    -- when close to crosshair, snap harder so pred point is actually reached
    local dx, dy = sx - mx, sy - my
    local pix = math.sqrt(dx * dx + dy * dy)
    if pix < 25 then sm = math.min(1, sm + 0.35)
    elseif pix < 60 then sm = math.min(1, sm + 0.15) end
    move_mouse(dx * sm, dy * sm)
end

on_frame = OnFrame
onFrame = OnFrame

print("[Ohio] Infernal-style UI | F8 toggle | drag title bar")
