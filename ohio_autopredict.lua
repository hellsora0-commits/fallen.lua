--[[
  Ohio AUTO-PREDICT — Project Vector
  UI toggle: F8
  Watermark always on so you know script is alive
]]

local CFG = {
    aim_on = false,
    aim_vk = 0x02,
    fov = 220,
    smooth = 0.30,
    range = 1200,
    bone = 0,
    sticky = true,
    pred_on = true,
    pred_strength = 1.15,
    ping_ms = 55,
    drop_on = true,
    drop_strength = 0.80,
    speed_override = 0,
    draw_fov = true,
    draw_pred = true,
    waiting_key = false,
}

local UI = {
    open = true, -- start OPEN
    x = 40, y = 40, w = 340, h = 500,
    drag = false, dx = 0, dy = 0,
    tab = 1,
}

local hist, sticky_id = {}, nil
local prev = {}

--------------------------------------------------------------------------------
local function try(fn, ...)
    if type(fn) ~= "function" then return nil end
    local ok, a, b, c, d = pcall(fn, ...)
    if ok then return a, b, c, d end
    return nil
end

local function is_key(vk)
    if not vk then return false end
    if input and input.IsKeyDown then
        local r = try(input.IsKeyDown, vk)
        if r == true then return true end
    end
    if input and input.is_key_down then
        local r = try(input.is_key_down, vk)
        if r == true then return true end
    end
    return false
end

local function edge(name, vk)
    local now = is_key(vk)
    local was = prev[name]
    prev[name] = now
    return now and not was
end

local function mouse_pos()
    if input and input.GetMousePosition then
        local x, y = try(input.GetMousePosition)
        if type(x) == "number" then return x, y end
    end
    if utility and utility.GetMousePos then
        local x, y = try(utility.GetMousePos)
        if type(x) == "number" then return x, y end
    end
    return 0, 0
end

local function screen_size()
    if draw and draw.GetScreenSize then
        local w, h = try(draw.GetScreenSize)
        if w then return w, h end
    end
    if utility and utility.GetScreenSize then
        local w, h = try(utility.GetScreenSize)
        if w then return w, h end
    end
    if utility and utility.get_screen_size then
        local w, h = try(utility.get_screen_size)
        if w then return w, h end
    end
    return 1920, 1080
end

local function screen_center()
    if input and input.GetScreenCenter then
        local x, y = try(input.GetScreenCenter)
        if x then return x, y end
    end
    local w, h = screen_size()
    return w * 0.5, h * 0.5
end

local function w2s(x, y, z)
    if draw and draw.WorldToScreen then
        local sx, sy, ok = try(draw.WorldToScreen, x, y, z)
        if type(sx) == "number" and ok ~= false then return sx, sy end
    end
    if draw and draw.world_to_screen then
        local sx, sy, ok = try(draw.world_to_screen, x, y, z)
        if type(sx) == "number" and ok ~= false then return sx, sy end
    end
    if utility and utility.WorldToScreen then
        local sx, sy, ok = try(utility.WorldToScreen, x, y, z)
        if type(sx) == "number" and ok ~= false then return sx, sy end
    end
    return nil, nil
end

local function move_mouse(dx, dy)
    if math.abs(dx) < 0.05 and math.abs(dy) < 0.05 then return end
    if input and input.MoveMouse then try(input.MoveMouse, dx, dy) return end
    if utility and utility.MouseMove then try(utility.MouseMove, dx, dy) return end
    if utility and utility.mouse_move then try(utility.mouse_move, dx, dy) end
end

local function v3(v)
    if not v then return nil end
    local x = v.X or v.x
    local y = v.Y or v.y
    local z = v.Z or v.z
    if type(x) ~= "number" then return nil end
    return x, y, z
end

local function len3(x, y, z) return math.sqrt(x*x + y*y + z*z) end

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

local function pid(p)
    return p.Address or p.UserId or p.Name or p.name or tostring(p)
end

local function is_enemy(p)
    if p.IsLocal or p.is_local then return false end
    if p.IsAlive == false or p.is_alive == false then return false end
    return true
end

--------------------------------------------------------------------------------
-- DRAW — try multiple signatures (x,y,w,h AND x1,y1,x2,y2)
--------------------------------------------------------------------------------
local function C(r, g, b, a)
    return { r, g, b, a or 1 }
end

local function d_fill(x, y, w, h, c)
    if not draw then return end
    -- signature A: x, y, w, h
    if draw.RectFilled then
        local ok = pcall(draw.RectFilled, x, y, w, h, c)
        if ok then return end
        -- signature B: x1, y1, x2, y2
        pcall(draw.RectFilled, x, y, x + w, y + h, c)
        return
    end
    if draw.rect_filled then
        local ok = pcall(draw.rect_filled, x, y, w, h, c)
        if ok then return end
        pcall(draw.rect_filled, x, y, x + w, y + h, c)
        return
    end
    if draw.FilledRect then
        pcall(draw.FilledRect, x, y, x + w, y + h, c)
        return
    end
    if draw.box then
        pcall(draw.box, x, y, w, h, c)
    end
end

local function d_outline(x, y, w, h, c)
    if not draw then return end
    if draw.Rect then
        local ok = pcall(draw.Rect, x, y, w, h, c)
        if ok then return end
        pcall(draw.Rect, x, y, x + w, y + h, c)
        return
    end
    if draw.rect then
        local ok = pcall(draw.rect, x, y, w, h, c)
        if not ok then pcall(draw.rect, x, y, x + w, y + h, c) end
    end
end

local function d_text(x, y, s, c)
    if not draw then return end
    if draw.Text then pcall(draw.Text, x, y, tostring(s), c) return end
    if draw.text then pcall(draw.text, x, y, tostring(s), c) return end
    if draw.TextShadow then pcall(draw.TextShadow, x, y, tostring(s), c) end
end

local function d_circle(x, y, r, c, fill)
    if not draw then return end
    if fill then
        if draw.CircleFilled then pcall(draw.CircleFilled, x, y, r, c) return end
        if draw.circle_filled then pcall(draw.circle_filled, x, y, r, c) return end
    end
    if draw.Circle then pcall(draw.Circle, x, y, r, c)
    elseif draw.circle then pcall(draw.circle, x, y, r, c) end
end

--------------------------------------------------------------------------------
-- UI
--------------------------------------------------------------------------------
local function inbox(mx, my, x, y, w, h)
    return mx >= x and my >= y and mx <= x + w and my <= y + h
end

local VKN = {
    [0x01]="LMB",[0x02]="RMB",[0x04]="MMB",[0x05]="M4",[0x06]="M5",
    [0x10]="SHIFT",[0x11]="CTRL",[0x12]="ALT",[0x20]="SPACE",[0x09]="TAB",
}
for i=0x30,0x39 do VKN[i]=string.char(i) end
for i=0x41,0x5A do VKN[i]=string.char(i) end
local function vkname(vk) return VKN[vk] or string.format("%X", vk or 0) end

local function ui_cb(x, y, label, key)
    local mx, my = mouse_pos()
    local on = CFG[key]
    d_fill(x, y, 16, 16, C(0.15, 0.15, 0.18))
    d_outline(x, y, 16, 16, C(0.5, 0.5, 0.55))
    if on then d_fill(x + 3, y + 3, 10, 10, C(0.2, 0.9, 1)) end
    d_text(x + 24, y + 1, label, C(0.95, 0.95, 0.97))
    if edge("lmb", 0x01) and inbox(mx, my, x, y, 230, 18) then
        CFG[key] = not CFG[key]
    end
    return y + 26
end

local function ui_sl(x, y, w, label, key, mn, mxv, flt)
    local mx, my = mouse_pos()
    local val = CFG[key]
    if type(val) ~= "number" then val = mn end
    local t = (val - mn) / (mxv - mn)
    if t < 0 then t = 0 elseif t > 1 then t = 1 end
    local s = flt and string.format("%s  %.2f", label, val)
                 or string.format("%s  %d", label, math.floor(val + 0.5))
    d_text(x, y, s, C(0.88, 0.88, 0.92))
    local sy = y + 16
    d_fill(x, sy, w, 12, C(0.12, 0.12, 0.14))
    d_fill(x, sy, w * t, 12, C(0.2, 0.65, 0.95))
    d_outline(x, sy, w, 12, C(0.4, 0.4, 0.45))
    if is_key(0x01) and inbox(mx, my, x, sy - 3, w, 18) then
        local nt = (mx - x) / w
        if nt < 0 then nt = 0 elseif nt > 1 then nt = 1 end
        local nv = mn + nt * (mxv - mn)
        CFG[key] = flt and nv or math.floor(nv + 0.5)
    end
    return y + 38
end

local function ui_bone(x, y)
    local mx, my = mouse_pos()
    d_text(x, y, "Bone", C(0.88, 0.88, 0.92))
    local names = {"Head", "Torso", "Closest"}
    local bx = x
    for i, n in ipairs(names) do
        local sel = CFG.bone == (i - 1)
        d_fill(bx, y + 16, 78, 22, sel and C(0.15, 0.5, 0.8) or C(0.14, 0.14, 0.16))
        d_outline(bx, y + 16, 78, 22, C(0.4, 0.4, 0.45))
        d_text(bx + 12, y + 19, n, C(1, 1, 1))
        if edge("lmb", 0x01) and inbox(mx, my, bx, y + 16, 78, 22) then
            CFG.bone = i - 1
        end
        bx = bx + 84
    end
    return y + 48
end

local function ui_key(x, y)
    local mx, my = mouse_pos()
    d_text(x, y, "Aim Key", C(0.88, 0.88, 0.92))
    local lab = CFG.waiting_key and "PRESS KEY..." or vkname(CFG.aim_vk)
    d_fill(x + 95, y - 2, 140, 22, CFG.waiting_key and C(0.6, 0.25, 0.1) or C(0.14, 0.14, 0.16))
    d_outline(x + 95, y - 2, 140, 22, C(0.4, 0.4, 0.45))
    d_text(x + 105, y + 2, lab, C(1, 1, 1))
    if edge("lmb", 0x01) and inbox(mx, my, x + 95, y - 2, 140, 22) then
        CFG.waiting_key = true
    end
    if CFG.waiting_key then
        local scan = {0x01,0x02,0x04,0x05,0x06,0x10,0x11,0x12,0x20,0x09}
        for i=0x30,0x39 do scan[#scan+1]=i end
        for i=0x41,0x5A do scan[#scan+1]=i end
        for _, vk in ipairs(scan) do
            if is_key(vk) then
                CFG.aim_vk = vk
                CFG.waiting_key = false
                break
            end
        end
    end
    return y + 30
end

local function ui_tab(x, y, idx, name)
    local mx, my = mouse_pos()
    local sel = UI.tab == idx
    d_fill(x, y, 95, 24, sel and C(0.15, 0.42, 0.7) or C(0.12, 0.12, 0.14))
    d_outline(x, y, 95, 24, C(0.35, 0.35, 0.4))
    d_text(x + 24, y + 4, name, C(1, 1, 1))
    if edge("lmb", 0x01) and inbox(mx, my, x, y, 95, 24) then
        UI.tab = idx
    end
end

local function draw_ui()
    -- ALWAYS draw watermark (proves OnFrame + draw work)
    d_fill(8, 8, 220, 22, C(0.05, 0.05, 0.08, 0.85))
    d_text(14, 12, "Ohio AP | F8=menu | AIM:" .. (CFG.aim_on and "ON" or "off"), C(0.3, 1, 0.6))

    if not UI.open then return end

    local mx, my = mouse_pos()
    local x, y, w, h = UI.x, UI.y, UI.w, UI.h

    if is_key(0x01) and inbox(mx, my, x, y, w, 30) then
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

    -- big solid panel
    d_fill(x, y, w, h, C(0.06, 0.06, 0.09, 0.97))
    d_outline(x, y, w, h, C(0.25, 0.7, 1.0))
    d_fill(x, y, w, 30, C(0.08, 0.18, 0.35))
    d_text(x + 12, y + 7, "OHIO AUTO-PREDICT", C(1, 1, 1))
    d_text(x + w - 100, y + 7, "F8 close", C(0.6, 0.75, 0.9))

    local ty = y + 40
    ui_tab(x + 12, ty, 1, "Aim")
    ui_tab(x + 114, ty, 2, "Predict")
    ui_tab(x + 216, ty, 3, "Visual")

    local cy = ty + 36
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
        cy = ui_sl(lx, cy, sw, "Ping ms", "ping_ms", 0, 250, false)
        cy = ui_cb(lx, cy, "Bullet Drop", "drop_on")
        cy = ui_sl(lx, cy, sw, "Drop Strength", "drop_strength", 0.0, 2.5, true)
        cy = ui_sl(lx, cy, sw, "Bullet Speed (0=AUTO)", "speed_override", 0, 3500, false)
    else
        cy = ui_cb(lx, cy, "Draw FOV", "draw_fov")
        cy = ui_cb(lx, cy, "Show Predict Point", "draw_pred")
        d_text(lx, cy + 8, "Toggle: F8", C(0.55, 0.6, 0.65))
    end
end

--------------------------------------------------------------------------------
-- PREDICT
--------------------------------------------------------------------------------
local function auto_speed(dist)
    if CFG.speed_override and CFG.speed_override > 0 then return CFG.speed_override end
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
    local a, b, c = v3(p.Velocity)
    if not a then a, b, c = v3(p.velocity) end
    if a then
        lvx, lvy, lvz, live = a, b, c, true
        local sp = len3(lvx, lvy, lvz)
        if sp > 220 then local s = 220/sp; lvx,lvy,lvz = lvx*s,lvy*s,lvz*s end
    end
    local h = hist[id]
    local dvx, dvy, dvz = 0, 0, 0
    if h and h.t and (t - h.t) > 0.002 and (t - h.t) < 0.35 then
        local dt = t - h.t
        dvx = (x - h.x) / dt
        dvy = (y - h.y) / dt
        dvz = (z - h.z) / dt
        local k = 0.38
        dvx = (h.dvx or dvx)*(1-k) + dvx*k
        dvy = (h.dvy or dvy)*(1-k) + dvy*k
        dvz = (h.dvz or dvz)*(1-k) + dvz*k
    end
    hist[id] = {x=x,y=y,z=z,t=t,dvx=dvx,dvy=dvy,dvz=dvz}
    if live then return lvx*0.72+dvx*0.28, lvy*0.72+dvy*0.28, lvz*0.72+dvz*0.28 end
    return dvx, dvy, dvz
end

local function intercept_t(ox,oy,oz, px,py,pz, vx,vy,vz, speed)
    local dx,dy,dz = px-ox, py-oy, pz-oz
    local a = vx*vx + vy*vy + vz*vz - speed*speed
    local b = 2*(dx*vx + dy*vy + dz*vz)
    local c = dx*dx + dy*dy + dz*dz
    local t
    if math.abs(a) < 1e-5 then
        t = (math.abs(b) > 1e-6) and (-c/b) or (len3(dx,dy,dz)/math.max(speed,1))
    else
        local disc = b*b - 4*a*c
        if disc < 0 then
            t = len3(dx,dy,dz)/math.max(speed,1)
        else
            local s = math.sqrt(disc)
            local t1, t2 = (-b-s)/(2*a), (-b+s)/(2*a)
            if t1 > 0.001 and t2 > 0.001 then t = math.min(t1,t2)
            elseif t1 > 0.001 then t = t1
            elseif t2 > 0.001 then t = t2
            else t = len3(dx,dy,dz)/math.max(speed,1) end
        end
    end
    if not t or t ~= t or t < 0.001 then t = len3(dx,dy,dz)/math.max(speed,1) end
    if t > 1.6 then t = 1.6 end
    return t
end

local function predict_point(p, id, hx, hy, hz, lx, ly, lz)
    if not CFG.pred_on then return hx, hy, hz end
    local vx, vy, vz = velocity_of(p, id, hx, hy, hz)
    local dist = len3(hx-lx, hy-ly, hz-lz)
    local speed = auto_speed(dist)
    local str = CFG.pred_strength or 1.15
    vx, vy, vz = vx*str, vy*str, vz*str
    local t = intercept_t(lx,ly,lz, hx,hy,hz, vx,vy,vz, speed) + (CFG.ping_ms or 55)/1000
    local px, py, pz = hx+vx*t, hy+vy*t, hz+vz*t
    if CFG.drop_on then
        py = py + 0.5 * 130 * t * t * (CFG.drop_strength or 0.8)
    end
    return px, py, pz
end

local function bone_world(p)
    local hx, hy, hz = v3(p.HeadPosition)
    if not hx then hx, hy, hz = v3(p.head_position) end
    local rx, ry, rz = v3(p.Position)
    if not rx then rx, ry, rz = v3(p.position) end
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
            {hx,hy,hz},
            {rx or hx, (ry or hy)+0.55, rz or hz},
            {rx or hx, (ry or hy)-0.65, rz or hz},
        }
        local best, bd = pts[1], 1e18
        for _, c in ipairs(pts) do
            local sx, sy = w2s(c[1],c[2],c[3])
            if sx then
                local d = (sx-cx)^2+(sy-cy)^2
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
        local x,y,z = v3(lp.HeadPosition or lp.head_position)
        if x then return x,y,z end
        x,y,z = v3(lp.Position or lp.position)
        if x then return x,y,z end
    end
    if camera and camera.GetPosition then
        local p = try(camera.GetPosition)
        if p then local x,y,z = v3(p); if x then return x,y,z end end
    end
    return nil
end

local function pick_target(lx, ly, lz)
    local fov, maxr = CFG.fov or 220, CFG.range or 1200
    local cx, cy = screen_center()
    local list = get_players()

    if CFG.sticky and sticky_id then
        for _, p in ipairs(list) do
            if is_enemy(p) and pid(p) == sticky_id then
                local x,y,z = bone_world(p)
                if x and len3(x-lx,y-ly,z-lz) <= maxr*1.35 then
                    local sx, sy = w2s(x,y,z)
                    if sx then
                        local fd = math.sqrt((sx-cx)^2+(sy-cy)^2)
                        if fd <= fov*1.7 then return p,x,y,z end
                    end
                end
            end
        end
        sticky_id = nil
    end

    local best, bx, by, bz, bfd = nil, nil, nil, nil, 1e18
    for _, p in ipairs(list) do
        if not is_enemy(p) then goto cont end
        local x,y,z = bone_world(p)
        if not x then goto cont end
        if len3(x-lx,y-ly,z-lz) > maxr then goto cont end
        local sx, sy = w2s(x,y,z)
        if not sx then goto cont end
        local fd = math.sqrt((sx-cx)^2+(sy-cy)^2)
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
    -- multi-key toggle (INSERT often stolen by cheat menu)
    -- F8 = 0x77
    if edge("f8", 0x77) then
        UI.open = not UI.open
        print("[Ohio] UI " .. (UI.open and "OPEN" or "closed"))
    end

    draw_ui()

    if not CFG.aim_on then
        sticky_id = nil
        return
    end

    local cx, cy = screen_center()
    if CFG.draw_fov then
        d_circle(cx, cy, CFG.fov or 220, C(1,1,1,0.35), false)
    end

    if not is_key(CFG.aim_vk) then
        sticky_id = nil
        return
    end

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
        d_circle(sx, sy, 4, C(1, 0.2, 0.2, 0.95), true)
    end

    local sm = CFG.smooth or 0.30
    if sm < 0.08 then sm = 0.08 end
    local mx, my = mouse_pos()
    move_mouse((sx - mx) * sm, (sy - my) * sm)
end

on_frame = OnFrame
onFrame = OnFrame

print("[Ohio] loaded — look top-left: 'Ohio AP | F8=menu'")
print("[Ohio] Toggle UI: F8")
