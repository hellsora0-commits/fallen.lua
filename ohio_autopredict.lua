--[[
  Ohio AUTO-PREDICT Mouse Aimbot
  Project Vector — NATIVE menu only (menu.Add*)
  No custom draw UI — opens inside Vector menu
]]

--------------------------------------------------------------------------------
-- NATIVE MENU (Vector docs)
--------------------------------------------------------------------------------
local function mcall(pascal, snake, ...)
    if menu[pascal] then return menu[pascal](...) end
    if menu[snake] then return menu[snake](...) end
end

mcall("AddTab", "add_tab", "Ohio", "O")
mcall("AddGroup", "add_group", "Ohio", "Aimbot")
mcall("AddCheckbox", "add_checkbox", "Ohio", "Aimbot", "aim_on", "Enable Aimbot", false)
mcall("AddHotkey", "add_hotkey", "Ohio", "Aimbot", "aim_key", "Aim Key", 0x02)
mcall("AddSliderInt", "add_slider_int", "Ohio", "Aimbot", "fov", "FOV", 20, 800, 200)
mcall("AddSliderFloat", "add_slider_float", "Ohio", "Aimbot", "smooth", "Smooth", 0.05, 1.0, 0.30)
mcall("AddSliderInt", "add_slider_int", "Ohio", "Aimbot", "range", "Range", 50, 2000, 1200)
mcall("AddCombo", "add_combo", "Ohio", "Aimbot", "bone", "Bone", {"Head", "Torso", "Closest"}, 0)
mcall("AddCheckbox", "add_checkbox", "Ohio", "Aimbot", "sticky", "Sticky Aim", true)

mcall("AddGroup", "add_group", "Ohio", "Predict")
mcall("AddCheckbox", "add_checkbox", "Ohio", "Predict", "pred_on", "Auto Predict", true)
mcall("AddSliderFloat", "add_slider_float", "Ohio", "Predict", "pred_strength", "Strength", 0.5, 2.5, 1.15)
mcall("AddSliderInt", "add_slider_int", "Ohio", "Predict", "ping_ms", "Ping ms", 0, 250, 55)
mcall("AddCheckbox", "add_checkbox", "Ohio", "Predict", "drop_on", "Bullet Drop", true)
mcall("AddSliderFloat", "add_slider_float", "Ohio", "Predict", "drop_strength", "Drop Strength", 0.0, 2.5, 0.80)
mcall("AddSliderInt", "add_slider_int", "Ohio", "Predict", "speed_override", "Bullet Speed (0=AUTO)", 0, 3500, 0)

mcall("AddGroup", "add_group", "Ohio", "Visual")
mcall("AddCheckbox", "add_checkbox", "Ohio", "Visual", "draw_fov", "Draw FOV", true)
mcall("AddCheckbox", "add_checkbox", "Ohio", "Visual", "draw_pred", "Show Pred Point", true)

--------------------------------------------------------------------------------
local function mg(id, fb)
    local v
    if menu.Get then
        local ok, r = pcall(menu.Get, id)
        if ok and r ~= nil then return r end
    end
    if menu.get then
        local ok, r = pcall(menu.get, id)
        if ok and r ~= nil then return r end
    end
    return fb
end

local function try(fn, ...)
    if type(fn) ~= "function" then return nil end
    local ok, a, b, c = pcall(fn, ...)
    if ok then return a, b, c end
    return nil
end

local hist, sticky_id = {}, nil

local function is_key(vk)
    if not vk then return false end
    if input and input.IsKeyDown then
        local r = try(input.IsKeyDown, vk)
        if r == true then return true end
    end
    return false
end

local function aim_held()
    -- native hotkey
    if menu.IsHotkeyDown then
        local r = try(menu.IsHotkeyDown, "aim_key")
        if r == true then return true end
    end
    if menu.IsHotkeyActive then
        local r = try(menu.IsHotkeyActive, "aim_key")
        if r == true then return true end
    end
    local vk = 0x02
    if menu.GetKey then
        local k = try(menu.GetKey, "aim_key")
        if type(k) == "number" and k > 0 then vk = k end
    end
    return is_key(vk)
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
    return 960, 540
end

local function w2s(x, y, z)
    if draw and draw.WorldToScreen then
        local sx, sy, ok = try(draw.WorldToScreen, x, y, z)
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
end

local function v3(v)
    if not v then return nil end
    local x, y, z = v.X or v.x, v.Y or v.y, v.Z or v.z
    if type(x) ~= "number" then return nil end
    return x, y, z
end

local function len3(x, y, z)
    return math.sqrt(x * x + y * y + z * z)
end

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

local function d_circle(x, y, r, c, fill)
    if not draw then return end
    if fill and draw.CircleFilled then pcall(draw.CircleFilled, x, y, r, c) return end
    if draw.Circle then pcall(draw.Circle, x, y, r, c)
    elseif draw.circle then pcall(draw.circle, x, y, r, c) end
end

local function d_text(x, y, s, c)
    if not draw then return end
    if draw.Text then pcall(draw.Text, x, y, tostring(s), c)
    elseif draw.text then pcall(draw.text, x, y, tostring(s), c) end
end

--------------------------------------------------------------------------------
-- PREDICT
--------------------------------------------------------------------------------
local function auto_speed(dist)
    local ov = mg("speed_override", 0)
    if type(ov) == "number" and ov > 0 then return ov end
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
    if live then
        return lvx * 0.72 + dvx * 0.28, lvy * 0.72 + dvy * 0.28, lvz * 0.72 + dvz * 0.28
    end
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
    if not mg("pred_on", true) then return hx, hy, hz end
    local vx, vy, vz = velocity_of(p, id, hx, hy, hz)
    local dist = len3(hx - lx, hy - ly, hz - lz)
    local speed = auto_speed(dist)
    local str = mg("pred_strength", 1.15) or 1.15
    vx, vy, vz = vx * str, vy * str, vz * str
    local t = intercept_t(lx, ly, lz, hx, hy, hz, vx, vy, vz, speed) + (mg("ping_ms", 55) or 55) / 1000
    local px, py, pz = hx + vx * t, hy + vy * t, hz + vz * t
    if mg("drop_on", true) then
        py = py + 0.5 * 130 * t * t * (mg("drop_strength", 0.8) or 0.8)
    end
    return px, py, pz
end

local function bone_world(p)
    local mode = mg("bone", 0) or 0
    local hx, hy, hz = v3(p.HeadPosition)
    local rx, ry, rz = v3(p.Position)
    if not hx and rx then hx, hy, hz = rx, ry + 1.55, rz end
    if not hx then return nil end
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
    if camera and camera.GetPosition then
        local p = try(camera.GetPosition)
        if p then local x, y, z = v3(p); if x then return x, y, z end end
    end
    return nil
end

local function pick_target(lx, ly, lz)
    local fov = mg("fov", 200) or 200
    local maxr = mg("range", 1200) or 1200
    local cx, cy = screen_center()
    local list = get_players()

    if mg("sticky", true) and sticky_id then
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
    -- watermark so you know script runs
    d_text(10, 10, "Ohio AP | open Vector menu -> Ohio tab", { 0.3, 1, 0.5, 1 })

    if not mg("aim_on", false) then
        sticky_id = nil
        return
    end

    local cx, cy = screen_center()
    local fov = mg("fov", 200) or 200

    if mg("draw_fov", true) then
        d_circle(cx, cy, fov, { 1, 1, 1, 0.4 }, false)
    end

    if not aim_held() then
        sticky_id = nil
        return
    end

    local lx, ly, lz = local_pos()
    if not lx then return end

    local p, hx, hy, hz = pick_target(lx, ly, lz)
    if not p or not hx then return end

    local px, py, pz = predict_point(p, pid(p), hx, hy, hz, lx, ly, lz)
    local sx, sy = w2s(px, py, pz)
    if not sx then return end

    if mg("draw_pred", true) then
        d_circle(sx, sy, 4, { 1, 0.2, 0.2, 0.95 }, true)
    end

    local sm = mg("smooth", 0.30) or 0.30
    if sm < 0.05 then sm = 0.05 end
    local mx, my = mouse_pos()
    move_mouse((sx - mx) * sm, (sy - my) * sm)
end

on_frame = OnFrame
onFrame = OnFrame

print("[Ohio] Native menu loaded — open CHEAT MENU, tab: Ohio")
