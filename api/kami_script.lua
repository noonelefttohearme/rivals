-- kami rivals — full build

local library = getgenv().library
if not library then return end

library.cache = Instance.new("Frame")
library.cache.BackgroundTransparency = 1
library.cache.Size = UDim2.new(1, 0, 1, 0)
library.cache.Name = "\0"
library.cache.Visible = false
library.cache.Parent = library["items"]

local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS        = game:GetService("UserInputService")
local TweenSvc   = game:GetService("TweenService")
local Lighting   = game:GetService("Lighting")
local Camera     = workspace.CurrentCamera
local LP         = Players.LocalPlayer

local ICO = {
    rage    = "rbxassetid://10723405507",
    legit   = "rbxassetid://10723413765",
    visuals = "rbxassetid://10723407963",
    movement= "rbxassetid://10723407090",
    exploit = "rbxassetid://10723405507",
    misc    = "rbxassetid://10723407090",
    config  = "rbxassetid://10723407963",
}

local window = library:window({
    name      = "kami",
    suffix    = "dere",
    game_info = "Rivals",
    size      = UDim2.new(0, 750, 0, 580),
})

-----------------------------------------------------------------------
-- RAGEBOT
-----------------------------------------------------------------------
local rb_main, rb_target, rb_antiaim = window:tab({
    name = "Ragebot", icon = ICO.rage, tabs = { "Main", "Target", "Anti-Aim" },
})

do -- Ragebot / Main
    local col = rb_main:column({})
    local sec = col:section({ name = "Ragebot", size = 1, icon = ICO.rage, default = true })
    sec:toggle({  name = "Enabled",               flag = "rb_on",           default = false })
    sec:keybind({ name = "Keybind",               flag = "rb_key",          key = nil, mode = "Toggle" })
    sec:dropdown({name = "Fire Mode",             flag = "rb_fire_mode",    items = { "Auto", "Semi", "Burst" }, default = "Auto" })
    sec:dropdown({name = "Hitbox",                flag = "rb_hitbox",       items = { "Head", "Torso", "Nearest", "Random" }, default = "Head" })
    sec:slider({  name = "Shoot Attempts",        flag = "rb_attempts",     min = 1,   max = 30,  default = 1,   interval = 1    })
    sec:slider({  name = "Burst Count",           flag = "rb_burst",        min = 1,   max = 10,  default = 3,   interval = 1    })
    sec:slider({  name = "Shoot Delay (ms)",      flag = "rb_delay",        min = 0,   max = 500, default = 0,   interval = 1    })
    sec:toggle({  name = "Silent Aim",            flag = "rb_silent",       default = false })
    sec:toggle({  name = "Auto Shoot",            flag = "rb_auto_shoot",   default = true  })
    sec:toggle({  name = "Prediction",            flag = "rb_predict",      default = false })
    sec:slider({  name = "Prediction Velocity",   flag = "rb_predict_vel",  min = 0,   max = 1,   default = 0.1, interval = 0.01 })
    sec:toggle({  name = "Void Spam",             flag = "rb_voidspam",     default = false })
    sec:slider({  name = "Void Attack Delay",     flag = "rb_vs_attack",    min = 0,   max = 1,   default = 0.1, interval = 0.01 })
    sec:slider({  name = "Void Hide Delay",       flag = "rb_vs_hide",      min = 0,   max = 1,   default = 0.2, interval = 0.01 })
    sec:toggle({  name = "Priority Notification", flag = "rb_notif",        default = false })

    local sec2 = col:section({ name = "Aimlock", size = 1, icon = ICO.rage, default = true })
    sec2:toggle({ name = "Aimlock",               flag = "rb_aimlock",      default = false })
    sec2:keybind({name = "Aimlock Key",           flag = "rb_aimlock_key",  key = nil, mode = "Hold" })
    sec2:slider({ name = "Smooth",                flag = "rb_smooth",       min = 1,   max = 50,  default = 1,   interval = 1    })
    sec2:toggle({ name = "Lock While Shooting",   flag = "rb_lock_shoot",   default = true  })
end

do -- Ragebot / Target
    local col = rb_target:column({})
    local sec = col:section({ name = "Target Selection", size = 1, icon = ICO.rage, default = true })
    sec:toggle({  name = "Ignore Team",           flag = "rb_ignore_team",  default = true  })
    sec:toggle({  name = "Ignore Self",           flag = "rb_ignore_self",  default = true  })
    sec:toggle({  name = "Visible Only",          flag = "rb_vis_only",     default = false })
    sec:toggle({  name = "Priority Mode",         flag = "rb_priority",     default = false })
    sec:dropdown({name = "Priority Target",       flag = "rb_priority_mode",items = { "Closest to Crosshair", "Lowest HP", "Nearest Player", "First Hit" }, default = "Closest to Crosshair" })
    sec:slider({  name = "FOV",                   flag = "rb_fov",          min = 0, max = 360, default = 180, interval = 1, suffix = "°" })
    sec:slider({  name = "Max Distance",          flag = "rb_max_dist",     min = 0, max = 1000, default = 500, interval = 1 })
    sec:toggle({  name = "Draw FOV Circle",       flag = "rb_draw_fov",     default = false })
    sec:slider({  name = "FOV Circle Thickness",  flag = "rb_fov_thick",    min = 1, max = 5, default = 1, interval = 1 })
end

do -- Ragebot / Anti-Aim
    local col = rb_antiaim:column({})
    local sec = col:section({ name = "Anti-Aim", size = 1, icon = ICO.rage, default = true })
    sec:toggle({  name = "Enabled",               flag = "aa_on",           default = false })
    sec:keybind({ name = "Keybind",               flag = "aa_key",          key = nil, mode = "Toggle" })
    sec:dropdown({name = "Pitch",                 flag = "aa_pitch",        items = { "None", "Down", "Up", "Zero" }, default = "None" })
    sec:dropdown({name = "Yaw",                   flag = "aa_yaw",          items = { "None", "Spin", "Jitter", "Backwards", "Side" }, default = "None" })
    sec:slider({  name = "Spin Speed",            flag = "aa_spin_speed",   min = 1, max = 30, default = 10, interval = 1 })
    sec:slider({  name = "Jitter Range",          flag = "aa_jitter",       min = 0, max = 180, default = 35, interval = 1, suffix = "°" })
    sec:toggle({  name = "Fake Duck",             flag = "aa_fakeduck",     default = false })
    sec:keybind({ name = "Fake Duck Key",         flag = "aa_fd_key",       key = nil, mode = "Hold" })
    sec:toggle({  name = "At Targets",            flag = "aa_at_target",    default = false })
end

-----------------------------------------------------------------------
-- LEGIT / AIMBOT
-----------------------------------------------------------------------
local lb_aimbot, lb_trigger, lb_backtrack = window:tab({
    name = "Legit", icon = ICO.legit, tabs = { "Aimbot", "Triggerbot", "Backtrack" },
})

do -- Legit / Aimbot
    local col = lb_aimbot:column({})
    local sec = col:section({ name = "Smooth Aimbot", size = 1, icon = ICO.legit, default = true })
    sec:toggle({  name = "Enabled",               flag = "la_on",           default = false })
    sec:keybind({ name = "Keybind",               flag = "la_key",          key = nil, mode = "Hold" })
    sec:dropdown({name = "Hitbox",                flag = "la_hitbox",       items = { "Head", "Torso", "Nearest" }, default = "Head" })
    sec:slider({  name = "Smooth",                flag = "la_smooth",       min = 1,   max = 100, default = 20,  interval = 1    })
    sec:slider({  name = "FOV",                   flag = "la_fov",          min = 0,   max = 180, default = 30,  interval = 1, suffix = "°" })
    sec:toggle({  name = "Draw FOV",              flag = "la_draw_fov",     default = false })
    sec:toggle({  name = "Humanization",          flag = "la_human",        default = true  })
    sec:slider({  name = "Humanization Offset",   flag = "la_human_off",    min = 0, max = 20, default = 5, interval = 1 })
    sec:toggle({  name = "Ignore Team",           flag = "la_ignore_team",  default = true  })
    sec:toggle({  name = "Visible Only",          flag = "la_vis_only",     default = false })
    sec:toggle({  name = "Recoil Control",        flag = "la_rcs",          default = false })
    sec:slider({  name = "RCS X",                 flag = "la_rcs_x",        min = 0, max = 100, default = 50, interval = 1, suffix = "%" })
    sec:slider({  name = "RCS Y",                 flag = "la_rcs_y",        min = 0, max = 100, default = 50, interval = 1, suffix = "%" })
end

do -- Legit / Triggerbot
    local col = lb_trigger:column({})
    local sec = col:section({ name = "Triggerbot", size = 1, icon = ICO.legit, default = true })
    sec:toggle({  name = "Enabled",               flag = "tb_on",           default = false })
    sec:keybind({ name = "Keybind",               flag = "tb_key",          key = nil, mode = "Toggle" })
    sec:toggle({  name = "Ignore Team",           flag = "tb_ignore_team",  default = true  })
    sec:slider({  name = "Reaction Time (ms)",    flag = "tb_reaction",     min = 0, max = 500, default = 100, interval = 1 })
    sec:slider({  name = "Reaction Offset (ms)",  flag = "tb_react_off",    min = 0, max = 200, default = 0,   interval = 1 })
    sec:slider({  name = "Shoot Delay (ms)",      flag = "tb_shoot_delay",  min = 0, max = 500, default = 0,   interval = 1 })
    sec:slider({  name = "Forget Time (s)",       flag = "tb_forget",       min = 0, max = 3,   default = 0.5, interval = 0.01 })
    sec:slider({  name = "Max Distance",          flag = "tb_max_dist",     min = 0, max = 500, default = 100, interval = 1 })
    sec:slider({  name = "Max Shots",             flag = "tb_max_shots",    min = 0, max = 20,  default = 0,   interval = 1 })
    sec:toggle({  name = "Burst Fire",            flag = "tb_burst",        default = false })
    sec:slider({  name = "Burst Count",           flag = "tb_burst_count",  min = 2, max = 10,  default = 3,   interval = 1 })
end

do -- Legit / Backtrack
    local col = lb_backtrack:column({})
    local sec = col:section({ name = "Backtrack", size = 1, icon = ICO.legit, default = true })
    sec:toggle({ name = "Enabled",                flag = "bt_on",           default = false })
    sec:slider({ name = "Tick Delay",             flag = "bt_ticks",        min = 1, max = 12, default = 6, interval = 1 })
    sec:toggle({ name = "Draw History",           flag = "bt_draw",         default = false })
    sec:slider({ name = "Max Lag (ms)",           flag = "bt_lag",          min = 0, max = 200, default = 100, interval = 1 })
end

-----------------------------------------------------------------------
-- VISUALS
-----------------------------------------------------------------------
local vs_esp, vs_chams, vs_world, vs_hud = window:tab({
    name = "Visuals", icon = ICO.visuals, tabs = { "ESP", "Chams", "World", "HUD" },
})

do -- Visuals / ESP
    local col = vs_esp:column({})
    local sec = col:section({ name = "Player ESP", size = 1, icon = ICO.visuals, default = true })
    sec:toggle({ name = "Enabled",                flag = "esp_on",          default = false })
    sec:toggle({ name = "Box",                    flag = "esp_box",         default = false })
    sec:toggle({ name = "Filled Box",             flag = "esp_fill",        default = false })
    sec:slider({ name = "Box Opacity",            flag = "esp_fill_alpha",  min = 0, max = 100, default = 30, interval = 1, suffix = "%" })
    sec:toggle({ name = "Name",                   flag = "esp_name",        default = false })
    sec:toggle({ name = "Distance",               flag = "esp_distance",    default = false })
    sec:toggle({ name = "Weapon",                 flag = "esp_weapon",      default = false })
    sec:toggle({ name = "Health Bar",             flag = "esp_healthbar",   default = false })
    sec:toggle({ name = "Health Number",          flag = "esp_hp_num",      default = false })
    sec:toggle({ name = "Skeleton",               flag = "esp_skeleton",    default = false })
    sec:toggle({ name = "Head Circle",            flag = "esp_headcircle",  default = false })
    sec:toggle({ name = "Tracer",                 flag = "esp_tracer",      default = false })
    sec:dropdown({name = "Tracer Origin",         flag = "esp_tracer_orig", items = { "Bottom", "Center", "Top", "Mouse" }, default = "Bottom" })
    sec:toggle({ name = "Glow",                   flag = "esp_glow",        default = false })
    sec:toggle({ name = "Show Team",              flag = "esp_show_team",   default = false })
    sec:toggle({ name = "Show Downed",            flag = "esp_downed",      default = true  })

    local sec2 = col:section({ name = "Items / Other", size = 1, icon = ICO.visuals, default = false })
    sec2:toggle({ name = "Item ESP",              flag = "esp_items",       default = false })
    sec2:toggle({ name = "Dropped Weapons",       flag = "esp_weapons",     default = false })
end

do -- Visuals / Chams
    local col = vs_chams:column({})
    local sec = col:section({ name = "Chams", size = 1, icon = ICO.visuals, default = true })
    sec:toggle({  name = "Enabled",               flag = "chams_on",        default = false })
    sec:dropdown({name = "Material",              flag = "chams_mat",       items = { "Flat", "Neon", "Glass", "Plastic" }, default = "Flat" })
    sec:toggle({  name = "Visible Only",          flag = "chams_vis",       default = false })
    sec:toggle({  name = "XRay (Through Walls)",  flag = "chams_xray",      default = false })
    sec:toggle({  name = "Show Team",             flag = "chams_team",      default = false })
end

do -- Visuals / World
    local col = vs_world:column({})
    local sec = col:section({ name = "World", size = 1, icon = ICO.visuals, default = true })
    sec:toggle({ name = "Fullbright",             flag = "world_fullbright", default = false, callback = function(v)
        if v then
            Lighting.Brightness = 2; Lighting.ClockTime = 14
            Lighting.FogEnd = 1e6; Lighting.GlobalShadows = false
            Lighting.Ambient = Color3.fromRGB(178,178,178)
        else
            Lighting.Brightness = 1; Lighting.GlobalShadows = true
            Lighting.Ambient = Color3.fromRGB(70,70,70)
        end
    end })
    sec:toggle({ name = "No Fog",                 flag = "world_no_fog",    default = false, callback = function(v)
        Lighting.FogEnd = v and 1e6 or 1000
    end })
    sec:toggle({ name = "Night Mode",             flag = "world_night",     default = false, callback = function(v)
        Lighting.ClockTime = v and 0 or 14
        Lighting.Brightness = v and 0 or 1
    end })
    sec:toggle({ name = "No Scope Overlay",       flag = "world_noscope",   default = false })
    sec:slider({ name = "FOV Changer",            flag = "world_fov",       min = 50, max = 130, default = 70, interval = 1, callback = function(v)
        Camera.FieldOfView = v
    end })
    sec:slider({ name = "Ambient Brightness",     flag = "world_ambient",   min = 0, max = 10, default = 1, interval = 0.1, callback = function(v)
        Lighting.Brightness = v
    end })

    local sec2 = col:section({ name = "Effects", size = 1, icon = ICO.visuals, default = false })
    sec2:toggle({ name = "Remove Post FX",        flag = "world_no_postfx", default = false })
    sec2:toggle({ name = "No Skybox",             flag = "world_no_skybox", default = false })
end

do -- Visuals / HUD
    local col = vs_hud:column({})
    local sec = col:section({ name = "HUD", size = 1, icon = ICO.visuals, default = true })
    sec:toggle({ name = "FPS Counter",            flag = "hud_fps",         default = false })
    sec:toggle({ name = "Ping Display",           flag = "hud_ping",        default = false })
    sec:toggle({ name = "Crosshair",              flag = "hud_crosshair",   default = false })
    sec:dropdown({name = "Crosshair Style",       flag = "hud_cross_style", items = { "Default", "Cross", "Dot", "Circle", "T-Shape" }, default = "Cross" })
    sec:slider({ name = "Crosshair Size",         flag = "hud_cross_size",  min = 1, max = 30, default = 8, interval = 1 })
    sec:slider({ name = "Crosshair Gap",          flag = "hud_cross_gap",   min = 0, max = 20, default = 4, interval = 1 })
    sec:slider({ name = "Crosshair Thickness",    flag = "hud_cross_thick", min = 1, max = 5,  default = 2, interval = 1 })
    sec:toggle({ name = "Hitmarker",              flag = "hud_hitmarker",   default = false })
    sec:slider({ name = "Hitmarker Lifetime (ms)",flag = "hud_hm_life",     min = 50, max = 1000, default = 200, interval = 10 })
    sec:toggle({ name = "Spectator List",         flag = "hud_speclist",    default = false })
    sec:toggle({ name = "Watermark",              flag = "hud_watermark",   default = true  })
end

-----------------------------------------------------------------------
-- MOVEMENT
-----------------------------------------------------------------------
local mv_main, mv_fly, mv_tp = window:tab({
    name = "Movement", icon = ICO.movement, tabs = { "Main", "Fly", "Teleport" },
})

do -- Movement / Main
    local col = mv_main:column({})
    local sec = col:section({ name = "Movement", size = 1, icon = ICO.movement, default = true })
    sec:toggle({ name = "Bunny Hop",              flag = "mv_bhop",         default = false })
    sec:slider({ name = "Bhop Chance (%)",        flag = "mv_bhop_chance",  min = 1, max = 100, default = 100, interval = 1, suffix = "%" })
    sec:toggle({ name = "Auto Sprint",            flag = "mv_sprint",       default = false })
    sec:toggle({ name = "Infinite Jump",          flag = "mv_infjump",      default = false })
    sec:slider({ name = "Jump Power",             flag = "mv_jumppower",    min = 50, max = 300, default = 50, interval = 1, callback = function(v)
        local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = v end
    end })
    sec:slider({ name = "Walk Speed",             flag = "mv_walkspeed",    min = 16, max = 200, default = 16, interval = 1, callback = function(v)
        local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = v end
    end })
    sec:toggle({ name = "No Clip",               flag = "mv_noclip",       default = false })
    sec:keybind({name = "No Clip Key",           flag = "mv_noclip_key",   key = nil, mode = "Toggle" })
    sec:toggle({ name = "Anti-AFK",              flag = "mv_antiafk",      default = false })
    sec:toggle({ name = "Long Jump",             flag = "mv_longjump",     default = false })
end

do -- Movement / Fly
    local col = mv_fly:column({})
    local sec = col:section({ name = "Fly", size = 1, icon = ICO.movement, default = true })
    sec:toggle({  name = "Enabled",              flag = "fly_on",          default = false })
    sec:keybind({ name = "Keybind",              flag = "fly_key",         key = nil, mode = "Toggle" })
    sec:slider({  name = "Fly Speed",            flag = "fly_speed",       min = 1,  max = 200, default = 30, interval = 1 })
    sec:slider({  name = "Vertical Speed",       flag = "fly_vspeed",      min = 1,  max = 100, default = 15, interval = 1 })
    sec:toggle({  name = "No Collision",         flag = "fly_nocol",       default = true  })
    sec:toggle({  name = "Smooth Fly",           flag = "fly_smooth",      default = true  })
end

do -- Movement / Teleport
    local col = mv_tp:column({})
    local sec = col:section({ name = "Teleport", size = 1, icon = ICO.movement, default = true })
    sec:toggle({  name = "Teleport to Player",   flag = "tp_player",       default = false })
    sec:keybind({ name = "Teleport Key",         flag = "tp_key",          key = nil, mode = "Hold" })
    sec:toggle({  name = "Bring Player",         flag = "tp_bring",        default = false })
    sec:keybind({ name = "Bring Key",            flag = "tp_bring_key",    key = nil, mode = "Hold" })
    sec:toggle({  name = "Teleport to Mouse",    flag = "tp_mouse",        default = false })
    sec:keybind({ name = "Mouse TP Key",         flag = "tp_mouse_key",    key = nil, mode = "Hold" })
    sec:slider({  name = "Mouse TP Distance",    flag = "tp_mouse_dist",   min = 1, max = 500, default = 50, interval = 1 })
end

-----------------------------------------------------------------------
-- EXPLOITS
-----------------------------------------------------------------------
local ex_main, ex_gun, ex_player = window:tab({
    name = "Exploits", icon = ICO.exploit, tabs = { "Main", "Weapon", "Player" },
})

do -- Exploits / Main
    local col = ex_main:column({})
    local sec = col:section({ name = "Kill Aura", size = 1, icon = ICO.exploit, default = true })
    sec:toggle({  name = "Enabled",               flag = "ka_on",           default = false })
    sec:keybind({ name = "Keybind",               flag = "ka_key",          key = nil, mode = "Toggle" })
    sec:slider({  name = "Radius",                flag = "ka_radius",       min = 1,  max = 100, default = 20, interval = 1 })
    sec:slider({  name = "Hit Delay (ms)",        flag = "ka_delay",        min = 0,  max = 500, default = 50, interval = 1 })
    sec:toggle({  name = "Ignore Team",           flag = "ka_ignore_team",  default = true  })
    sec:toggle({  name = "Closest First",         flag = "ka_closest",      default = true  })

    local sec2 = col:section({ name = "Other", size = 1, icon = ICO.exploit, default = true })
    sec2:toggle({ name = "Fake Lag",              flag = "ex_fakelag",      default = false })
    sec2:slider({ name = "Fake Lag Amount",       flag = "ex_fl_amount",    min = 1, max = 15, default = 5, interval = 1 })
    sec2:toggle({ name = "Crash Server",          flag = "ex_crashsrv",     default = false })
    sec2:button({ name = "Crash Now",             callback = function()
        if library.flags.ex_crashsrv then
            for i = 1, 1e4 do game:GetService("RunService").Stepped:Wait() end
        end
    end })
    sec2:toggle({ name = "Fly Hack",              flag = "ex_fly",          default = false })
end

do -- Exploits / Weapon
    local col = ex_gun:column({})
    local sec = col:section({ name = "Weapon", size = 1, icon = ICO.exploit, default = true })
    sec:toggle({ name = "Fast Fire",              flag = "ex_fastfire",     default = false })
    sec:slider({ name = "Fire Rate Multiplier",   flag = "ex_firerate",     min = 1,  max = 20, default = 5,  interval = 1 })
    sec:toggle({ name = "Infinite Ammo",          flag = "ex_infiammo",     default = false })
    sec:toggle({ name = "No Recoil",              flag = "ex_norecoil",     default = false })
    sec:toggle({ name = "No Spread",              flag = "ex_nospread",     default = false })
    sec:toggle({ name = "Auto Reload",            flag = "ex_autoreload",   default = false })
    sec:toggle({ name = "Instant Reload",         flag = "ex_instreload",   default = false })
    sec:toggle({ name = "Rapid Fire",             flag = "ex_rapidfire",    default = false })
end

do -- Exploits / Player
    local col = ex_player:column({})
    local sec = col:section({ name = "Player Exploit", size = 1, icon = ICO.exploit, default = true })
    sec:toggle({ name = "God Mode",               flag = "ex_godmode",      default = false })
    sec:toggle({ name = "Super Jump",             flag = "ex_superjump",    default = false })
    sec:slider({ name = "Super Jump Power",       flag = "ex_sj_power",     min = 100, max = 1000, default = 200, interval = 10 })
    sec:toggle({ name = "Low Gravity",            flag = "ex_lowgrav",      default = false })
    sec:slider({ name = "Gravity Scale",          flag = "ex_grav_scale",   min = 0.1, max = 1, default = 0.5, interval = 0.05, callback = function(v)
        workspace.Gravity = v * 196.2
    end })
    sec:toggle({ name = "Invisibility",           flag = "ex_invis",        default = false, callback = function(v)
        local char = LP.Character; if not char then return end
        for _, p in char:GetDescendants() do
            if p:IsA("BasePart") or p:IsA("Decal") then
                p.Transparency = v and 1 or 0
            end
        end
    end })
end

-----------------------------------------------------------------------
-- MISC
-----------------------------------------------------------------------
local mc_main, mc_chat, mc_game = window:tab({
    name = "Misc", icon = ICO.misc, tabs = { "Main", "Chat", "Game" },
})

do -- Misc / Main
    local col = mc_main:column({})
    local sec = col:section({ name = "Player", size = 1, icon = ICO.misc, default = true })
    sec:toggle({ name = "Auto Rejoin",            flag = "mc_rejoin",       default = false })
    sec:button({ name = "Rejoin Now",             callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
    end })
    sec:toggle({ name = "Unlock FPS",             flag = "mc_unlockfps",    default = false, callback = function(v)
        if setfpscap then setfpscap(v and 0 or 60) end
    end })
    sec:slider({ name = "FPS Cap",               flag = "mc_fpscap",       min = 30, max = 240, default = 60, interval = 1, callback = function(v)
        if setfpscap then setfpscap(v) end
    end })
    sec:toggle({ name = "Third Person",           flag = "mc_thirdperson",  default = false })
    sec:slider({ name = "Third Person Dist",      flag = "mc_tp_dist",      min = 5, max = 50, default = 15, interval = 1 })
    sec:toggle({ name = "Lag Switch",             flag = "mc_lagswitch",    default = false })
    sec:keybind({name = "Lag Switch Key",         flag = "mc_ls_key",       key = nil, mode = "Hold" })
    sec:toggle({ name = "Spin Bot",               flag = "mc_spinbot",      default = false })
    sec:slider({ name = "Spin Speed",             flag = "mc_spin_spd",     min = 1, max = 50, default = 15, interval = 1 })

    local sec2 = col:section({ name = "Server", size = 1, icon = ICO.misc, default = false })
    sec2:button({ name = "Copy Server ID",        callback = function()
        if setclipboard then setclipboard(game.JobId) end
        library.notifications:create_notification({ name = "Misc", info = "Server ID copied", lifetime = 2 })
    end })
    sec2:button({ name = "List Players",          callback = function()
        local names = {}
        for _, p in Players:GetPlayers() do table.insert(names, p.Name) end
        library.notifications:create_notification({ name = "Players", info = table.concat(names, ", "), lifetime = 4 })
    end })
end

do -- Misc / Chat
    local col = mc_chat:column({})
    local sec = col:section({ name = "Chat", size = 1, icon = ICO.misc, default = true })
    sec:toggle({  name = "Chat Spam",             flag = "mc_chatspam",     default = false })
    sec:slider({  name = "Spam Interval (s)",     flag = "mc_spam_int",     min = 0.5, max = 10, default = 2, interval = 0.5 })
    sec:dropdown({name = "Spam Message",          flag = "mc_spam_msg",     items = { "kami.dere", "gg ez", "you died :)", "aim diff", "skill issue" }, default = "kami.dere" })
    sec:toggle({  name = "Kill Say",              flag = "mc_killsay",      default = false })
    sec:dropdown({name = "Kill Message",          flag = "mc_kill_msg",     items = { "ez", "gg", "lol", "rip", "kami.dere" }, default = "ez" })
end

do -- Misc / Game
    local col = mc_game:column({})
    local sec = col:section({ name = "Game", size = 1, icon = ICO.misc, default = true })
    sec:toggle({ name = "Auto Win",               flag = "mc_autowin",      default = false })
    sec:toggle({ name = "No Death Screen",        flag = "mc_nodeath",      default = false })
    sec:toggle({ name = "Show Hitboxes",          flag = "mc_hitboxes",     default = false })
    sec:slider({ name = "Hitbox Expand",          flag = "mc_hb_expand",    min = 0, max = 10, default = 0, interval = 0.5 })
    sec:toggle({ name = "Disable Animations",     flag = "mc_no_anim",      default = false })
    sec:toggle({ name = "Zoom Hack",              flag = "mc_zoom",         default = false })
    sec:slider({ name = "Zoom FOV",               flag = "mc_zoom_fov",     min = 1, max = 60, default = 20, interval = 1 })
    sec:keybind({name = "Zoom Key",               flag = "mc_zoom_key",     key = nil, mode = "Hold" })
end

-----------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------
local cfg_main = window:tab({ name = "Config", icon = ICO.config, tabs = { "Main" } })

do
    local col = cfg_main:column({})
    local sec = col:section({ name = "Configuration", size = 1, icon = ICO.config, default = true })
    sec:button({ name = "Save Config",            callback = function()
        if writefile and library.flags then
            local ok, err = pcall(writefile, "kami_config.json", game:GetService("HttpService"):JSONEncode(library.flags))
            library.notifications:create_notification({ name = "Config", info = ok and "Saved!" or ("Error: " .. tostring(err)), lifetime = 2 })
        end
    end })
    sec:button({ name = "Load Config",            callback = function()
        if readfile and isfile and isfile("kami_config.json") then
            local ok, data = pcall(function()
                return game:GetService("HttpService"):JSONDecode(readfile("kami_config.json"))
            end)
            if ok and type(data) == "table" then
                for k, v in data do library.flags[k] = v end
                library.notifications:create_notification({ name = "Config", info = "Loaded!", lifetime = 2 })
            end
        end
    end })
    sec:button({ name = "Reset Config",           callback = function()
        if writefile then writefile("kami_config.json", "{}") end
        library.notifications:create_notification({ name = "Config", info = "Reset to defaults", lifetime = 2 })
    end })

    local sec2 = col:section({ name = "Script", size = 1, icon = ICO.config, default = true })
    sec2:toggle({ name = "Panic Key",             flag = "cfg_panic",       default = false })
    sec2:keybind({name = "Panic Keybind",         flag = "cfg_panic_key",   key = Enum.KeyCode.Delete, mode = "Toggle" })
    sec2:button({ name = "Unload Script",         callback = function()
        library.notifications:create_notification({ name = "kami", info = "Unloading...", lifetime = 1 })
        task.wait(1)
        if library.unload then library:unload() end
    end })
    sec2:toggle({ name = "Allow Crash Recovery",  flag = "cfg_recovery",    default = true  })
    sec2:toggle({ name = "Debug Mode",            flag = "cfg_debug",       default = false })
end

-----------------------------------------------------------------------
-- FLAGS REFERENCE
-----------------------------------------------------------------------
local flags = library.flags

-----------------------------------------------------------------------
-- UTILITY
-----------------------------------------------------------------------
local function getChar(p) return p and p.Character end
local function getHum(c) return c and c:FindFirstChildOfClass("Humanoid") end
local function isAlive(p)
    local h = getHum(getChar(p)); return h and h.Health > 0
end

local function getHitbox(char, part)
    if part == "Head"    then return char:FindFirstChild("Head") end
    if part == "Torso"   then return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") end
    if part == "Nearest" then
        local best, bd = nil, math.huge
        for _, p in char:GetDescendants() do
            if p:IsA("BasePart") then
                local _, d = Camera:WorldToViewportPoint(p.Position)
                if d < bd then bd = d; best = p end
            end
        end
        return best
    end
    if part == "Random" then
        local parts = {}
        for _, p in char:GetDescendants() do if p:IsA("BasePart") then parts[#parts+1] = p end end
        return parts[math.random(1, #parts)]
    end
    return char:FindFirstChild("Head")
end

local function getTarget(fov, mode, ignoreTeam)
    local vpCenter = Camera.ViewportSize / 2
    local best, bestVal = nil, math.huge
    for _, p in Players:GetPlayers() do
        if p == LP then continue end
        if not isAlive(p) then continue end
        if ignoreTeam and p.Team == LP.Team and p.Team ~= nil then continue end
        local char = getChar(p); if not char then continue end
        local head = char:FindFirstChild("Head"); if not head then continue end
        local sp, onScreen = Camera:WorldToViewportPoint(head.Position)
        if not onScreen then continue end
        local dist2d = (Vector2.new(sp.X, sp.Y) - vpCenter).Magnitude
        if fov and dist2d > fov then continue end
        local val
        if mode == "Lowest HP" then
            local hum = getHum(char); val = hum and hum.Health or math.huge
        elseif mode == "Nearest Player" then
            local root = getChar(LP) and getChar(LP):FindFirstChild("HumanoidRootPart")
            val = root and (root.Position - head.Position).Magnitude or math.huge
        else
            val = dist2d
        end
        if val < bestVal then bestVal = val; best = { player = p, char = char, dist2d = dist2d, worldPos = head.Position } end
    end
    return best
end

local function fire()
    if mouse1click then mouse1click() end
end

-----------------------------------------------------------------------
-- ESP OBJECTS
-----------------------------------------------------------------------
local espObjects = {}

local function removeEspFor(p)
    local t = espObjects[p]; if not t then return end
    for _, d in t do pcall(function() d:Remove() end) end
    espObjects[p] = nil
end

local function createEspFor(p)
    local t = {}
    if flags.esp_box or flags.esp_fill then
        t.box = Drawing.new("Square"); t.box.Thickness = 1; t.box.Filled = flags.esp_fill
        t.box.Color = Color3.fromRGB(255,60,60); t.box.Visible = false
        if flags.esp_fill then t.box.Transparency = (flags.esp_fill_alpha or 30) / 100 end
    end
    if flags.esp_name then
        t.name = Drawing.new("Text"); t.name.Size = 13; t.name.Center = true
        t.name.Outline = true; t.name.Color = Color3.fromRGB(255,255,255)
        t.name.Text = p.Name; t.name.Visible = false
    end
    if flags.esp_healthbar then
        t.hpbg = Drawing.new("Square"); t.hpbg.Thickness = 1; t.hpbg.Filled = true
        t.hpbg.Color = Color3.fromRGB(0,0,0); t.hpbg.Visible = false
        t.hp = Drawing.new("Square"); t.hp.Thickness = 1; t.hp.Filled = true
        t.hp.Color = Color3.fromRGB(60,255,60); t.hp.Visible = false
    end
    if flags.esp_tracer then
        t.tracer = Drawing.new("Line"); t.tracer.Thickness = 1
        t.tracer.Color = Color3.fromRGB(255,60,60); t.tracer.Visible = false
    end
    if flags.esp_headcircle then
        t.headcirc = Drawing.new("Circle"); t.headcirc.Thickness = 1; t.headcirc.Filled = false
        t.headcirc.Color = Color3.fromRGB(255,200,60); t.headcirc.Visible = false
    end
    if flags.esp_skeleton then
        t.skeleton = {}
    end
    espObjects[p] = t
end

local SKELETON_PAIRS = {
    {"Head","UpperTorso"}, {"UpperTorso","LowerTorso"},
    {"UpperTorso","LeftUpperArm"}, {"LeftUpperArm","LeftLowerArm"}, {"LeftLowerArm","LeftHand"},
    {"UpperTorso","RightUpperArm"}, {"RightUpperArm","RightLowerArm"}, {"RightLowerArm","RightHand"},
    {"LowerTorso","LeftUpperLeg"}, {"LeftUpperLeg","LeftLowerLeg"}, {"LeftLowerLeg","LeftFoot"},
    {"LowerTorso","RightUpperLeg"}, {"RightUpperLeg","RightLowerLeg"}, {"RightLowerLeg","RightFoot"},
}

local function updateEsp()
    local anyEsp = flags.esp_on and (flags.esp_box or flags.esp_fill or flags.esp_name or flags.esp_healthbar or flags.esp_tracer or flags.esp_headcircle or flags.esp_skeleton)
    for _, p in Players:GetPlayers() do
        if p == LP then continue end
        local t = espObjects[p]
        if anyEsp and not t then createEspFor(p); t = espObjects[p]
        elseif not anyEsp and t then removeEspFor(p); continue end
        if not t then continue end

        local char = getChar(p); local hum = getHum(char)
        local function hide() for _, d in t do
            if type(d) == "table" then for _, s in d do pcall(function() s.Visible = false end) end
            else pcall(function() d.Visible = false end) end
        end end
        if not char or not hum or hum.Health <= 0 then hide(); continue end
        local root = char:FindFirstChild("HumanoidRootPart"); if not root then hide(); continue end

        local topPos    = root.Position + Vector3.new(0, 3.2, 0)
        local bottomPos = root.Position - Vector3.new(0, 3.2, 0)
        local topSc, topV    = Camera:WorldToViewportPoint(topPos)
        local bottomSc, botV = Camera:WorldToViewportPoint(bottomPos)
        if not topV or not botV then hide(); continue end

        local height = math.abs(topSc.Y - bottomSc.Y)
        local width  = height * 0.6
        local x      = topSc.X - width / 2
        local y      = topSc.Y

        if (flags.esp_box or flags.esp_fill) and t.box then
            t.box.Size     = Vector2.new(width, height)
            t.box.Position = Vector2.new(x, y)
            t.box.Filled   = flags.esp_fill or false
            if flags.esp_fill then t.box.Transparency = (flags.esp_fill_alpha or 30) / 100 end
            t.box.Visible  = true
        elseif t.box then t.box.Visible = false end

        if flags.esp_name and t.name then
            t.name.Position = Vector2.new(topSc.X, y - 16); t.name.Visible = true
        elseif t.name then t.name.Visible = false end

        if flags.esp_healthbar and t.hpbg and t.hp then
            local ratio = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
            t.hpbg.Size = Vector2.new(4, height); t.hpbg.Position = Vector2.new(x - 7, y); t.hpbg.Visible = true
            t.hp.Size = Vector2.new(4, height * ratio)
            t.hp.Position = Vector2.new(x - 7, y + height * (1 - ratio))
            t.hp.Color = Color3.fromRGB(255 * (1 - ratio), 255 * ratio, 0); t.hp.Visible = true
        elseif t.hpbg then t.hpbg.Visible = false; if t.hp then t.hp.Visible = false end end

        if flags.esp_tracer and t.tracer then
            local vp = Camera.ViewportSize
            local orig = flags.esp_tracer_orig or "Bottom"
            local from = orig == "Center" and Vector2.new(vp.X/2, vp.Y/2)
                      or orig == "Top"    and Vector2.new(vp.X/2, 0)
                      or orig == "Mouse"  and UIS:GetMouseLocation()
                      or Vector2.new(vp.X/2, vp.Y)
            t.tracer.From = from; t.tracer.To = Vector2.new(topSc.X, y + height); t.tracer.Visible = true
        elseif t.tracer then t.tracer.Visible = false end

        if flags.esp_headcircle and t.headcirc then
            local head = char:FindFirstChild("Head")
            if head then
                local hsc, hv = Camera:WorldToViewportPoint(head.Position)
                if hv then
                    local _, dist = Camera:WorldToViewportPoint(head.Position + Vector3.new(head.Size.X/2, 0, 0))
                    t.headcirc.Position = Vector2.new(hsc.X, hsc.Y)
                    t.headcirc.Radius = math.abs(hsc.X - dist) + 2
                    t.headcirc.Visible = true
                end
            end
        elseif t.headcirc then t.headcirc.Visible = false end

        if flags.esp_skeleton and t.skeleton then
            for i, pair in SKELETON_PAIRS do
                local a = char:FindFirstChild(pair[1]); local b = char:FindFirstChild(pair[2])
                if not t.skeleton[i] then
                    t.skeleton[i] = Drawing.new("Line"); t.skeleton[i].Thickness = 1
                    t.skeleton[i].Color = Color3.fromRGB(255,255,255); t.skeleton[i].Visible = false
                end
                if a and b then
                    local sa, oa = Camera:WorldToViewportPoint(a.Position)
                    local sb, ob = Camera:WorldToViewportPoint(b.Position)
                    if oa and ob then
                        t.skeleton[i].From = Vector2.new(sa.X, sa.Y)
                        t.skeleton[i].To   = Vector2.new(sb.X, sb.Y)
                        t.skeleton[i].Visible = true
                    else t.skeleton[i].Visible = false end
                else t.skeleton[i].Visible = false end
            end
        elseif t.skeleton then
            for _, l in t.skeleton do pcall(function() l.Visible = false end) end
        end
    end
end

-----------------------------------------------------------------------
-- HUD DRAWINGS
-----------------------------------------------------------------------
local hudDrawings = {
    fps     = Drawing.new("Text"), ping = Drawing.new("Text"),
    crossH  = Drawing.new("Line"), crossV = Drawing.new("Line"),
    crossDot= Drawing.new("Circle"),
    crossTL = Drawing.new("Line"), crossTR = Drawing.new("Line"),
    crossBL = Drawing.new("Line"), crossBR = Drawing.new("Line"),
    hitmarker = { Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line") },
    watermark = Drawing.new("Text"),
    specbg   = Drawing.new("Square"), speclist = Drawing.new("Text"),
}
for _, d in hudDrawings do
    if type(d) == "table" then for _, l in d do l.Visible = false end
    else d.Visible = false end
end
hudDrawings.fps.Size = 13;  hudDrawings.fps.Outline = true;  hudDrawings.fps.Color = Color3.fromRGB(255,255,255)
hudDrawings.ping.Size = 13; hudDrawings.ping.Outline = true; hudDrawings.ping.Color = Color3.fromRGB(255,255,255)
hudDrawings.watermark.Size = 14; hudDrawings.watermark.Outline = true; hudDrawings.watermark.Color = Color3.fromRGB(180,140,255)
hudDrawings.watermark.Text = "kami.dere | rivals"

local hitmarkerTimer = 0
local fpsCounter = 0; local fpsTimer = 0; local fpsSamples = 0

local function updateHud(dt)
    local vp = Camera.ViewportSize
    local cx, cy = vp.X / 2, vp.Y / 2

    fpsTimer = fpsTimer + dt; fpsSamples = fpsSamples + 1
    if fpsTimer >= 0.5 then
        fpsCounter = math.floor(fpsSamples / fpsTimer)
        fpsTimer = 0; fpsSamples = 0
    end

    if flags.hud_fps then
        hudDrawings.fps.Text = "FPS: " .. fpsCounter
        hudDrawings.fps.Position = Vector2.new(10, 10); hudDrawings.fps.Visible = true
    else hudDrawings.fps.Visible = false end

    if flags.hud_watermark then
        hudDrawings.watermark.Position = Vector2.new(vp.X - 150, 10); hudDrawings.watermark.Visible = true
    else hudDrawings.watermark.Visible = false end

    if flags.hud_crosshair then
        local sz    = flags.hud_cross_size or 8
        local gap   = flags.hud_cross_gap or 4
        local thick = flags.hud_cross_thick or 2
        local style = flags.hud_cross_style or "Cross"
        local col   = Color3.fromRGB(255, 255, 255)
        hudDrawings.crossH.Visible = false; hudDrawings.crossV.Visible = false
        hudDrawings.crossDot.Visible = false
        for _, l in {hudDrawings.crossTL, hudDrawings.crossTR, hudDrawings.crossBL, hudDrawings.crossBR} do l.Visible = false end
        if style == "Cross" then
            hudDrawings.crossH.From = Vector2.new(cx - sz - gap, cy); hudDrawings.crossH.To = Vector2.new(cx - gap, cy)
            hudDrawings.crossH.Thickness = thick; hudDrawings.crossH.Color = col; hudDrawings.crossH.Visible = true
            -- right
            local rh = Drawing.new("Line") -- inline for brevity; reuse crossV slot for right
            hudDrawings.crossV.From = Vector2.new(cx + gap, cy); hudDrawings.crossV.To = Vector2.new(cx + sz + gap, cy)
            hudDrawings.crossV.Thickness = thick; hudDrawings.crossV.Color = col; hudDrawings.crossV.Visible = true
            hudDrawings.crossTL.From = Vector2.new(cx, cy - sz - gap); hudDrawings.crossTL.To = Vector2.new(cx, cy - gap)
            hudDrawings.crossTL.Thickness = thick; hudDrawings.crossTL.Color = col; hudDrawings.crossTL.Visible = true
            hudDrawings.crossTR.From = Vector2.new(cx, cy + gap); hudDrawings.crossTR.To = Vector2.new(cx, cy + sz + gap)
            hudDrawings.crossTR.Thickness = thick; hudDrawings.crossTR.Color = col; hudDrawings.crossTR.Visible = true
        elseif style == "Dot" then
            hudDrawings.crossDot.Position = Vector2.new(cx, cy); hudDrawings.crossDot.Radius = thick + 1
            hudDrawings.crossDot.Color = col; hudDrawings.crossDot.Filled = true; hudDrawings.crossDot.Visible = true
        elseif style == "Circle" then
            hudDrawings.crossDot.Position = Vector2.new(cx, cy); hudDrawings.crossDot.Radius = sz
            hudDrawings.crossDot.Color = col; hudDrawings.crossDot.Filled = false
            hudDrawings.crossDot.Thickness = thick; hudDrawings.crossDot.Visible = true
        end
    else
        hudDrawings.crossH.Visible = false; hudDrawings.crossV.Visible = false; hudDrawings.crossDot.Visible = false
        for _, l in {hudDrawings.crossTL, hudDrawings.crossTR, hudDrawings.crossBL, hudDrawings.crossBR} do l.Visible = false end
    end

    if hitmarkerTimer > 0 then
        hitmarkerTimer = hitmarkerTimer - dt
        local hm = hudDrawings.hitmarker; local hs = 8
        hm[1].From = Vector2.new(cx-hs, cy-hs); hm[1].To = Vector2.new(cx+hs, cy+hs); hm[1].Thickness = 2; hm[1].Color = Color3.fromRGB(255,60,60); hm[1].Visible = true
        hm[2].From = Vector2.new(cx+hs, cy-hs); hm[2].To = Vector2.new(cx-hs, cy+hs); hm[2].Thickness = 2; hm[2].Color = Color3.fromRGB(255,60,60); hm[2].Visible = true
    else
        for _, l in hudDrawings.hitmarker do l.Visible = false end
    end

    if flags.hud_speclist then
        local specs = {}
        for _, p in Players:GetPlayers() do
            if p ~= LP and not p.Character then
                specs[#specs+1] = p.Name
            end
        end
        if #specs > 0 then
            hudDrawings.speclist.Text = "Spectators:\n" .. table.concat(specs, "\n")
            hudDrawings.speclist.Position = Vector2.new(vp.X - 150, 30)
            hudDrawings.speclist.Size = 12; hudDrawings.speclist.Outline = true
            hudDrawings.speclist.Color = Color3.fromRGB(255,200,60); hudDrawings.speclist.Visible = true
        else hudDrawings.speclist.Visible = false end
    else hudDrawings.speclist.Visible = false end
end

-----------------------------------------------------------------------
-- FOV CIRCLE
-----------------------------------------------------------------------
local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 1; fovCircle.Filled = false; fovCircle.Color = Color3.fromRGB(255,255,255)
fovCircle.Visible = false

-----------------------------------------------------------------------
-- SPIN / ANTI-AIM STATE
-----------------------------------------------------------------------
local aaYaw = 0

-----------------------------------------------------------------------
-- FLY LOGIC
-----------------------------------------------------------------------
local flyPart = nil
local function startFly()
    local char = LP.Character; if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
    local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
    hum.PlatformStand = true
    flyPart = Instance.new("Part")
    flyPart.Size = Vector3.new(1,1,1); flyPart.CFrame = root.CFrame
    flyPart.Transparency = 1; flyPart.Anchored = true; flyPart.CanCollide = false
    flyPart.Parent = workspace
    root.CFrame = flyPart.CFrame
end
local function stopFly()
    local char = LP.Character; local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand = false end
    if flyPart then flyPart:Destroy(); flyPart = nil end
end

-----------------------------------------------------------------------
-- CONNECTIONS
-----------------------------------------------------------------------
Players.PlayerRemoving:Connect(removeEspFor)

UIS.JumpRequest:Connect(function()
    if flags.mv_infjump then
        local hum = getHum(getChar(LP)); if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

local bJumping = false
UIS.InputBegan:Connect(function(inp, gp)
    if gp then return end
    if inp.KeyCode == Enum.KeyCode.Space and flags.mv_bhop then
        bJumping = true
    end
end)
UIS.InputEnded:Connect(function(inp)
    if inp.KeyCode == Enum.KeyCode.Space then bJumping = false end
end)

-----------------------------------------------------------------------
-- STEPPED (physics)
-----------------------------------------------------------------------
RunService.Stepped:Connect(function(_, dt)
    local char = getChar(LP)

    -- noclip
    if flags.mv_noclip and char then
        for _, p in char:GetDescendants() do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end

    -- bhop
    if flags.mv_bhop and bJumping and char then
        local hum = getHum(char)
        if hum and hum.FloorMaterial ~= Enum.Material.Air then
            if math.random(1, 100) <= (flags.mv_bhop_chance or 100) then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end

    -- god mode
    if flags.ex_godmode and char then
        local hum = getHum(char); if hum then hum.Health = hum.MaxHealth end
    end

    -- anti-aim
    if flags.aa_on and char then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            local yaw = flags.aa_yaw or "None"
            if yaw == "Spin" then
                aaYaw = (aaYaw + (flags.aa_spin_speed or 10)) % 360
                root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(flags.aa_spin_speed or 10), 0)
            elseif yaw == "Backwards" then
                root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.rad(180), 0)
            end
            if flags.aa_fakeduck then
                local hum = getHum(char)
                if hum then hum.CameraOffset = Vector3.new(0, -1.5, 0) end
            end
        end
    end

    -- fly
    if flags.fly_on then
        if not flyPart then startFly() end
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root and flyPart then
            local spd = flags.fly_speed or 30
            local vspd = flags.fly_vspeed or 15
            local cf = Camera.CFrame
            local dir = Vector3.new(0, 0, 0)
            if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + cf.LookVector * spd * dt end
            if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - cf.LookVector * spd * dt end
            if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - cf.RightVector * spd * dt end
            if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + cf.RightVector * spd * dt end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, vspd * dt, 0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0, vspd * dt, 0) end
            flyPart.CFrame = flyPart.CFrame + dir
            root.CFrame = flyPart.CFrame
        end
    else
        if flyPart then stopFly() end
    end
end)

-----------------------------------------------------------------------
-- RENDERSTEPPED (visuals + combat)
-----------------------------------------------------------------------
local tb_hold = 0; local tb_waiting = false; local tb_shots = 0

RunService.RenderStepped:Connect(function(dt)
    -- ragebot
    if flags.rb_on then
        local target = getTarget(flags.rb_fov, flags.rb_priority_mode or "Closest to Crosshair", flags.rb_ignore_team)
        if target then
            local part = getHitbox(target.char, flags.rb_hitbox or "Head")
            if part then
                local pos = part.Position
                if flags.rb_predict then
                    local root = part.Parent and part.Parent:FindFirstChild("HumanoidRootPart")
                    if root then pos = pos + root.AssemblyLinearVelocity * (flags.rb_predict_vel or 0.1) end
                end
                if not flags.rb_silent then
                    if flags.rb_smooth and flags.rb_smooth > 1 then
                        local targetCF = CFrame.lookAt(Camera.CFrame.Position, pos)
                        Camera.CFrame = Camera.CFrame:Lerp(targetCF, 1 / (flags.rb_smooth or 1))
                    else
                        Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, pos)
                    end
                end
                if flags.rb_auto_shoot then
                    for i = 1, math.floor(flags.rb_attempts or 1) do
                        if flags.rb_delay and flags.rb_delay > 0 then
                            task.spawn(function() task.wait(flags.rb_delay / 1000); fire() end)
                        else fire() end
                    end
                    if flags.hud_hitmarker then hitmarkerTimer = (flags.hud_hm_life or 200) / 1000 end
                end
                if flags.rb_notif then
                    library.notifications:create_notification({ name = "Ragebot", info = "Locking: " .. target.player.Name, lifetime = 1 })
                end
            end
        end
    end

    -- legit aimbot
    if flags.la_on then
        local target = getTarget(flags.la_fov or 30, "Closest to Crosshair", flags.la_ignore_team)
        if target then
            local part = getHitbox(target.char, flags.la_hitbox or "Head")
            if part then
                local pos = part.Position
                if flags.la_human then
                    local off = flags.la_human_off or 5
                    pos = pos + Vector3.new(math.random(-off, off) * 0.01, math.random(-off, off) * 0.01, 0)
                end
                local targetCF = CFrame.lookAt(Camera.CFrame.Position, pos)
                Camera.CFrame = Camera.CFrame:Lerp(targetCF, 1 / math.max(1, flags.la_smooth or 20))
            end
        end
    end

    -- triggerbot
    if flags.tb_on then
        local target = getTarget(50, "Closest to Crosshair", flags.tb_ignore_team)
        if target then
            local root = getChar(LP) and getChar(LP):FindFirstChild("HumanoidRootPart")
            local dist3d = root and (root.Position - target.worldPos).Magnitude or math.huge
            if dist3d <= (flags.tb_max_dist or 100) then
                tb_hold = tb_hold + dt
                local reaction = ((flags.tb_reaction or 100) + math.random(
                    -(flags.tb_react_off or 0), math.max(0, flags.tb_react_off or 0)
                )) / 1000
                if tb_hold >= reaction and not tb_waiting then
                    local maxShots = flags.tb_max_shots or 0
                    if maxShots == 0 or tb_shots < maxShots then
                        tb_waiting = true
                        task.spawn(function()
                            task.wait((flags.tb_shoot_delay or 0) / 1000)
                            if flags.tb_burst then
                                for i = 1, (flags.tb_burst_count or 3) do
                                    fire(); task.wait(0.05)
                                end
                            else fire() end
                            if flags.hud_hitmarker then hitmarkerTimer = (flags.hud_hm_life or 200) / 1000 end
                            tb_shots = tb_shots + 1; tb_waiting = false; tb_hold = 0
                        end)
                    end
                end
            else
                if tb_hold > (flags.tb_forget or 0.5) then tb_hold = 0; tb_shots = 0 end
            end
        else
            if tb_hold > (flags.tb_forget or 0.5) then tb_hold = 0; tb_shots = 0 end
        end
    end

    -- third person
    if flags.mc_thirdperson then
        local char = getChar(LP)
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                Camera.CFrame = CFrame.new(root.Position + Vector3.new(0, 0, -(flags.mc_tp_dist or 15)), root.Position)
            end
        end
    end

    -- spin bot
    if flags.mc_spinbot then
        local char = getChar(LP); local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(flags.mc_spin_spd or 15), 0)
        end
    end

    -- fov circles
    local showRbFov = flags.rb_draw_fov and flags.rb_on
    local showLaFov = flags.la_draw_fov and flags.la_on
    if showRbFov or showLaFov then
        local fov = showRbFov and (flags.rb_fov or 180) or (flags.la_fov or 30)
        fovCircle.Position = Camera.ViewportSize / 2; fovCircle.Radius = fov
        fovCircle.Thickness = flags.rb_fov_thick or 1; fovCircle.Visible = true
    else fovCircle.Visible = false end

    -- esp
    updateEsp()

    -- hud
    updateHud(dt)
end)

-----------------------------------------------------------------------
-- CHAT SPAM
-----------------------------------------------------------------------
local chatTimer = 0
RunService.Heartbeat:Connect(function(dt)
    if flags.mc_chatspam then
        chatTimer = chatTimer + dt
        local interval = flags.mc_spam_int or 2
        if chatTimer >= interval then
            chatTimer = 0
            local msg = flags.mc_spam_msg or "kami.dere"
            if game:GetService("Players").LocalPlayer then
                pcall(function() game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents") and
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All") end)
            end
        end
    end
end)
