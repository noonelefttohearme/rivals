-- kami rivals — full build

local library = getgenv().library
if not library then return end

library.cache = Instance.new("Frame")
library.cache.BackgroundTransparency = 1
library.cache.Size   = UDim2.new(1, 0, 1, 0)
library.cache.Name   = "\0"
library.cache.Visible = false
library.cache.Parent  = library["items"]

local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS        = game:GetService("UserInputService")
local TweenSvc   = game:GetService("TweenService")
local Debris     = game:GetService("Debris")
local Lighting   = game:GetService("Lighting")
local Camera     = workspace.CurrentCamera
local LP         = Players.LocalPlayer

local ICO = {
    aim      = "rbxassetid://10723405507",
    esp      = "rbxassetid://10723407963",
    movement = "rbxassetid://10723407090",
    misc     = "rbxassetid://10723413765",
    visuals  = "rbxassetid://10723407963",
    config   = "rbxassetid://10723407090",
}

local window = library:window({
    name      = "kami",
    suffix    = "dere",
    game_info = "Rivals",
    size      = UDim2.new(0, 750, 0, 580),
})

-----------------------------------------------------------------------
-- AIM  (Ragebot / Silent Aim / Aimbot / Triggerbot)
-----------------------------------------------------------------------
local rb_p, sa_p, ab_p, trig_p = window:tab({ name = "Aim", icon = ICO.aim, tabs = { "Ragebot", "Silent Aim", "Aimbot", "Triggerbot" } })

-- RAGEBOT
do
    local col = rb_p:column({})
    local sec = col:section({ name = "Ragebot", size = 1, icon = ICO.aim, default = true })
    sec:toggle({  name = "Enabled",                   flag = "ragebot_enabled",               default = false })
    sec:keybind({ name = "Keybind",                   flag = "ragebot_keybind",               key = nil, mode = "Toggle" })
    sec:dropdown({name = "Mode",                      flag = "ragebot_mode",                  items = { "gun", "melee" }, default = "gun" })
    sec:dropdown({name = "Shooting Method",           flag = "shooting method",               items = { "Auto", "Semi", "Burst" }, default = "Auto" })
    sec:toggle({  name = "Priority",                  flag = "ragebot_priority",              default = false })
    sec:toggle({  name = "Priority Notification",     flag = "ragebot_priority_notification", default = false })
    sec:slider({  name = "Shoot Attempts",            flag = "ragebot_shoot_attempts",        min = 1, max = 20, default = 1, interval = 1 })
    sec:toggle({  name = "Void Spam",                 flag = "ragebot_void_spam",             default = false })
    sec:dropdown({name = "Void Spam Method",          flag = "void spam method",              items = { "Standard", "Desync", "Aggressive" }, default = "Standard" })
    sec:slider({  name = "Void Spam Attack",          flag = "ragebot_void_spam_attack",      min = 0, max = 1, default = 0.1, interval = 0.01 })
    sec:slider({  name = "Void Spam Hide",            flag = "ragebot_void_spam_hide",        min = 0, max = 1, default = 0.2, interval = 0.01 })
    sec:toggle({  name = "Bait",                      flag = "ragebot_bait",                  default = false })
    sec:toggle({  name = "Add to Ragebot Priority",   flag = "ragebot_add_priority",          default = false })
    sec:toggle({  name = "Auto Handoff On Shoot",     flag = "Auto Handoff On Shoot",         default = false })

    local sec2 = col:section({ name = "Desync", size = 1, icon = ICO.aim, default = false })
    sec2:dropdown({name = "Desync Mode",              flag = "Desync Mode",                   items = { "Disabled", "Lite Desync", "Voidspam Desync", "AA_Modified" }, default = "Disabled" })
    sec2:toggle({  name = "Fake Position Engine",     flag = "Fake Position Engine",          default = false })
    sec2:slider({  name = "Camera Elevation",         flag = "FakePosCameraElevation",        min = -20, max = 20, default = 0, interval = 0.5 })
    sec2:dropdown({name = "Hitbox Orientation",       flag = "Hitbox Orientation Desync",     items = { "None", "Jitter", "Spin", "Backwards" }, default = "None" })

    local sec3 = col:section({ name = "Targeting", size = 1, icon = ICO.aim, default = false })
    sec3:dropdown({name = "Priority Targets",         flag = "ragebot_priority_targets",      items = { "Closest to Crosshair", "Lowest HP", "Smart Lowest HP", "Nearest" }, default = "Closest to Crosshair" })
    sec3:toggle({  name = "Visible Only",             flag = "targeting_visibleonly",         default = false })
    sec3:toggle({  name = "Limit Distance",           flag = "targeting_limitdistance",       default = false })
    sec3:slider({  name = "Max Distance",             flag = "targeting_maxdistance",         min = 0, max = 1000, default = 500, interval = 1 })
    sec3:dropdown({name = "Target Part",              flag = "targeting_part",                items = { "Head", "Torso", "HumanoidRootPart", "Nearest" }, default = "Head" })
    sec3:dropdown({name = "Target Method",            flag = "target method",                 items = { "Camera", "Crosshair" }, default = "Camera" })
    sec3:toggle({  name = "Disable Flash",            flag = "targeting_disableflash",        default = false })
    sec3:toggle({  name = "Ignore Protected",         flag = "targeting_ignore_protected",    default = false })
    sec3:toggle({  name = "No Delay Between Targets", flag = "no delay between targets",      default = false })
    sec3:toggle({  name = "Prefer Projectile Weapon", flag = "prefer projectile weapon",      default = false })
    sec3:dropdown({name = "Part Blacklist",           flag = "targeting_closest_part_blacklist", items = { "None", "Arms", "Legs" }, default = "None" })
    sec3:toggle({  name = "Wall Check",               flag = "Wall Check",                    default = false })

    local sec4 = col:section({ name = "Target Highlight", size = 1, icon = ICO.aim, default = false })
    sec4:toggle({ name = "Enabled",                   flag = "target_highlight",              default = false })
    sec4:toggle({ name = "Fill",                      flag = "target_highlight_fill",         default = false })
    sec4:toggle({ name = "Outline",                   flag = "target_highlight_outline",      default = true })
    sec4:dropdown({name = "Type",                     flag = "target_highlight_type",         items = { "Box", "Circle", "Highlight" }, default = "Box" })

    local sec5 = col:section({ name = "Hit Notify", size = 1, icon = ICO.aim, default = false })
    sec5:toggle({ name = "Enabled",                   flag = "target_hit_notify",             default = false })
    sec5:slider({ name = "Duration",                  flag = "target_hit_notify_duration",    min = 0.5, max = 5, default = 1, interval = 0.5, suffix = "s" })
    sec5:dropdown({name = "Text",                     flag = "target_hit_notify_text",        items = { "Hit!", "damage ratio", "fortnite damage" }, default = "Hit!" })
end

-- SILENT AIM
do
    local col = sa_p:column({})
    local sec = col:section({ name = "Silent Aim", size = 1, icon = ICO.aim, default = true })
    sec:toggle({  name = "Enabled",                   flag = "silent_toggle",                 default = false })
    sec:keybind({ name = "Keybind",                   flag = "silent_keybind",                key = nil, mode = "Toggle" })
    sec:slider({  name = "Hitchance",                 flag = "silent_hitchance",              min = 1, max = 100, default = 100, interval = 1, suffix = "%" })
    sec:toggle({  name = "Silent Hook",               flag = "Silent Hook",                   default = false })
    sec:toggle({  name = "Manipulation",              flag = "silent_manipulation",           default = false })
    sec:toggle({  name = "Visualise FOV",             flag = "silent_visualize",              default = false })
    sec:toggle({  name = "Show FOV",                  flag = "silent_showfov",                default = false })
    sec:slider({  name = "FOV",                       flag = "silent_radius",                 min = 0, max = 360, default = 180, interval = 1, suffix = "°" })
    sec:dropdown({name = "Closest Part",              flag = "silent_closest_part",           items = { "Head", "Torso", "Nearest" }, default = "Head" })
    sec:toggle({  name = "FOV Fill",                  flag = "silent_fov_fill",               default = false })
    sec:toggle({  name = "FOV Moving",                flag = "silent_fov_moving",             default = false })
    sec:toggle({  name = "FOV Outline",               flag = "silent_fov_outline",            default = true })
    sec:toggle({  name = "FOV Lerp",                  flag = "silent_fov_lerp",               default = true })
    sec:slider({  name = "FOV Rotation Speed",        flag = "silent_fov_rotation_speed",     min = 0, max = 10, default = 0, interval = 0.1 })
end

-- AIMBOT
do
    local col = ab_p:column({})
    local sec = col:section({ name = "Legit Aimbot", size = 1, icon = ICO.aim, default = true })
    sec:toggle({  name = "Enable Aimbot",             flag = "aimbot_toggle",                 default = false })
    sec:keybind({ name = "Aim Keybind",               flag = "aimbot_keybind",                key = nil, mode = "Hold" })
    sec:slider({  name = "Aimbot FOV",                flag = "aimbot_radius",                 min = 0, max = 360, default = 90, interval = 1, suffix = "°" })
    sec:toggle({  name = "Visualise FOV",             flag = "aimbot_showfov",                default = false })
    sec:slider({  name = "Smoothness",                flag = "aimbot_delay_smooth_x",         min = 0, max = 1, default = 0.1, interval = 0.01 })
    sec:slider({  name = "Smoothness Y",              flag = "aimbot_delay_smooth_y",         min = 0, max = 1, default = 0.1, interval = 0.01 })
    sec:toggle({  name = "Smoothing",                 flag = "aimbot_smoothing",              default = true })
    sec:toggle({  name = "Match Axis",                flag = "aimbot_match_axis",             default = false })
    sec:dropdown({name = "Closest Part",              flag = "aimbot_closest_part",           items = { "Head", "Torso", "Nearest" }, default = "Head" })
    sec:toggle({  name = "Delay Position",            flag = "aimbot_delay_position",         default = false })
    sec:toggle({  name = "Delay Smooth Jump",         flag = "aimbot_delay_smooth_jump",      default = false })
    sec:toggle({  name = "FOV Fill",                  flag = "aimbot_fov_fill",               default = false })
    sec:toggle({  name = "FOV Moving",                flag = "aimbot_fov_moving",             default = false })
    sec:toggle({  name = "FOV Outline",               flag = "aimbot_fov_outline",            default = true })
    sec:toggle({  name = "FOV Lerp",                  flag = "aimbot_fov_lerp",               default = true })
    sec:slider({  name = "FOV Rotation Speed",        flag = "aimbot_fov_rotation_speed",     min = 0, max = 10, default = 0, interval = 0.1 })
    sec:slider({  name = "Recoil Percent",            flag = "recoil percent",                min = 0, max = 100, default = 0, interval = 1, suffix = "%" })
end

-- TRIGGERBOT
do
    local col = trig_p:column({})
    local sec = col:section({ name = "Triggerbot", size = 1, icon = ICO.aim, default = true })
    sec:toggle({  name = "Enable Triggerbot",         flag = "triggerbot_enabled",            default = false })
    sec:keybind({ name = "Keybind",                   flag = "triggerbot_keybind",            key = nil, mode = "Toggle" })
    sec:slider({  name = "Forget Time",               flag = "triggerbot_forget_time",        min = 0, max = 3, default = 0.5, interval = 0.01, suffix = "s" })
    sec:slider({  name = "Max Distance",              flag = "triggerbot_max_distance",       min = 0, max = 500, default = 100, interval = 1 })
    sec:slider({  name = "Reaction Time",             flag = "triggerbot_reaction_time",      min = 0, max = 500, default = 100, interval = 1, suffix = "ms" })
    sec:slider({  name = "Reaction Time Offset",      flag = "triggerbot_reaction_time_offset", min = 0, max = 200, default = 0, interval = 1, suffix = "ms" })
    sec:slider({  name = "Shoot Delay",               flag = "triggerbot_shoot_delay",        min = 0, max = 500, default = 0, interval = 1, suffix = "ms" })
    sec:toggle({  name = "Scoped Only",               flag = "triggerbot_scoped",             default = false })
    sec:toggle({  name = "Hide Between Targets",      flag = "hide between targets",          default = false })
    sec:toggle({  name = "Auto Handoff On Shoot",     flag = "tb_auto_handoff",               default = false })
    sec:dropdown({name = "Part Blacklist",            flag = "triggerbot_part_blacklist",     items = { "None", "Legs", "Arms" }, default = "None" })

    local sec2 = col:section({ name = "Targeting", size = 1, icon = ICO.aim, default = false })
    sec2:toggle({ name = "Visible Only",              flag = "tb_visibleonly",                default = false })
    sec2:toggle({ name = "Wall Check",                flag = "tb_wall_check",                 default = false })
    sec2:toggle({ name = "Ignore Protected",          flag = "tb_ignore_protected",           default = false })
end

-----------------------------------------------------------------------
-- ESP  (Player / Tracers / World / Chams)
-----------------------------------------------------------------------
local esp_player, esp_tracers, esp_world, esp_chams = window:tab({ name = "ESP", icon = ICO.esp, tabs = { "Player", "Tracers", "World", "Chams" } })

do
    local col = esp_player:column({})
    local sec = col:section({ name = "Enemy ESP", size = 1, icon = ICO.esp, default = true })
    sec:toggle({ name = "Enable Enemy ESP",           flag = "esp_on",                        default = false })
    sec:toggle({ name = "Bounding Box",               flag = "esp_box",                       default = false })
    sec:dropdown({name = "Box Style",                 flag = "esp_box_style",                 items = { "Default", "Corner", "Diamond" }, default = "Default" })
    sec:dropdown({name = "Box Fit",                   flag = "esp_box_fit",                   items = { "Body", "Full" }, default = "Body" })
    sec:toggle({ name = "Filled Box",                 flag = "esp_fill",                      default = false })
    sec:toggle({ name = "Name",                       flag = "esp_name",                      default = false })
    sec:toggle({ name = "Use Display Names",          flag = "Use Display Names",             default = false })
    sec:toggle({ name = "Distance",                   flag = "esp_distance",                  default = false })
    sec:toggle({ name = "Weapon",                     flag = "esp_weapon",                    default = false })
    sec:toggle({ name = "Health Bar",                 flag = "esp_healthbar",                 default = false })
    sec:dropdown({name = "Health Color Mode",         flag = "Health Color Mode",             items = { "Gradient", "Static", "Team" }, default = "Gradient" })
    sec:toggle({ name = "Health Number",              flag = "esp_hp_num",                    default = false })
    sec:toggle({ name = "Skeleton ESP",               flag = "esp_skeleton",                  default = false })
    sec:slider({ name = "Skeleton Thickness",         flag = "esp_skeleton_thickness",        min = 1, max = 5, default = 1, interval = 1 })
    sec:toggle({ name = "Head Marker",                flag = "Head Marker",                   default = false })
    sec:toggle({ name = "Head Marker Filled",         flag = "Head Marker Filled",            default = false })
    sec:toggle({ name = "Head Marker Outline",        flag = "Head Marker Outline",           default = false })
    sec:dropdown({name = "Head Marker Shape",         flag = "Head Marker Shape",             items = { "Circle", "Square", "Diamond" }, default = "Circle" })
    sec:toggle({ name = "Win Streak",                 flag = "Win Streak",                    default = false })
    sec:toggle({ name = "Arrow (Off-Screen)",         flag = "esp_arrow",                     default = false })
    sec:slider({ name = "Arrow Radius",               flag = "Arrow Radius",                  min = 50, max = 400, default = 200, interval = 5 })
    sec:slider({ name = "Max Render Distance",        flag = "Max Render Distance",           min = 100, max = 10000, default = 5000, interval = 100 })
    sec:dropdown({name = "ESP Font",                  flag = "ESP Font",                      items = { "Default", "Monospace", "Gotham", "Tahoma", "Arial" }, default = "Default" })
    sec:slider({ name = "ESP Font Size",              flag = "ESP Font Size",                 min = 8, max = 24, default = 13, interval = 1 })

    local sec2 = col:section({ name = "Teammates ESP", size = 1, icon = ICO.esp, default = false })
    sec2:toggle({ name = "Enable Teammates ESP",      flag = "Enable Teammates ESP",          default = false })
    sec2:toggle({ name = "Teammate Box",              flag = "Teammate Box",                  default = false })
    sec2:toggle({ name = "Teammate Health Bar",       flag = "Teammate Health Bar",           default = false })
    sec2:toggle({ name = "Teammate Name",             flag = "Teammate Name",                 default = false })
    sec2:toggle({ name = "Show Team Colors",          flag = "esp_show_team",                 default = false })
end

do
    local col = esp_tracers:column({})
    local sec = col:section({ name = "Tracers", size = 1, icon = ICO.esp, default = true })
    sec:toggle({ name = "Enable Tracer",              flag = "Enable Tracer",                 default = false })
    sec:dropdown({name = "Tracer Origin",             flag = "esp_tracer_origin",             items = { "Bottom", "Center", "Top", "Mouse" }, default = "Bottom" })
    sec:slider({ name = "Tracer Thickness",           flag = "Tracer Thickness",              min = 1, max = 5, default = 1, interval = 1 })
    sec:toggle({ name = "Tracer Outline",             flag = "Tracer Outline",                default = false })
    sec:toggle({ name = "Show Team Tracers",          flag = "esp_tracer_team",               default = false })

    local sec2 = col:section({ name = "Local Bullet Beams", size = 1, icon = ICO.esp, default = false })
    sec2:toggle({ name = "Local Bullet Beams",        flag = "Local Bullet Beams",            default = false })
    sec2:slider({ name = "Beam Width",                flag = "Beam Width",                    min = 0.01, max = 1, default = 0.05, interval = 0.01 })
    sec2:slider({ name = "Beam Lifetime",             flag = "Beam Lifetime",                 min = 0.1, max = 5, default = 0.5, interval = 0.1, suffix = "s" })

    local sec3 = col:section({ name = "Target Tracer", size = 1, icon = ICO.esp, default = false })
    sec3:toggle({ name = "Enable Target Tracer",      flag = "target_tracer",                 default = false })
    sec3:toggle({ name = "Customization",             flag = "target_tracer_customization",   default = false })
end

do
    local col = esp_world:column({})
    local sec = col:section({ name = "World ESP", size = 1, icon = ICO.esp, default = true })
    sec:toggle({ name = "Name",                       flag = "esp_world_name",                default = false })
    sec:toggle({ name = "Distance",                   flag = "esp_world_distance",            default = false })
    sec:toggle({ name = "Image",                      flag = "esp_world_image",               default = false })
    sec:slider({ name = "Object Scale",               flag = "esp_world_object_scale",        min = 0.1, max = 5, default = 1, interval = 0.1 })
    sec:slider({ name = "Lerp Speed",                 flag = "esp_world_lerp_speed",          min = 0, max = 1, default = 0.1, interval = 0.01 })
    sec:dropdown({name = "Whitelist",                 flag = "esp_world_whitelist",           items = { "All", "Enemies", "Team" }, default = "All" })

    local sec2 = col:section({ name = "Target Info HUD", size = 1, icon = ICO.esp, default = false })
    sec2:toggle({ name = "Enable Target Info HUD",    flag = "Enable Target Info HUD",        default = false })
    sec2:toggle({ name = "Show Targets",              flag = "target_ui_show_targets",        default = true })
    sec2:slider({ name = "Item Scale",                flag = "target_ui_item_scale",          min = 0.5, max = 3, default = 1, interval = 0.1 })
    sec2:slider({ name = "Position X",               flag = "target_ui_position_x",          min = 0, max = 1, default = 0.5, interval = 0.01 })
    sec2:slider({ name = "Position Y",               flag = "target_ui_position_y",          min = 0, max = 1, default = 0.5, interval = 0.01 })
    sec2:slider({ name = "HUD Scale Multiplier",      flag = "HUD Scale Multiplier",          min = 0.5, max = 3, default = 1, interval = 0.1 })
end

do
    local col = esp_chams:column({})
    local sec = col:section({ name = "Enemy Chams", size = 1, icon = ICO.esp, default = true })
    sec:toggle({ name = "Enable Enemy Chams",         flag = "esp_chams",                     default = false })
    sec:dropdown({name = "Chams Kind",                flag = "Chams Kind",                    items = { "Flat", "Neon", "Glass", "Wireframe", "ForceField" }, default = "Flat" })
    sec:slider({ name = "Chams Fill",                 flag = "esp_chams_alpha_fill",          min = 0, max = 1, default = 0.5, interval = 0.01 })
    sec:slider({ name = "Chams Outline",              flag = "esp_chams_alpha_outline",       min = 0, max = 1, default = 1, interval = 0.01 })
    sec:toggle({ name = "Chams Glow",                 flag = "Chams Glow",                    default = false })
    sec:toggle({ name = "Chams 1 (Visible)",          flag = "esp_chams_visible",             default = false })
    sec:toggle({ name = "Chams 2 (Through Wall)",     flag = "esp_chams_xray",                default = false })

    local sec2 = col:section({ name = "Viewmodel / Gun", size = 1, icon = ICO.esp, default = false })
    sec2:toggle({ name = "Viewmodel Chams",           flag = "viewmodel_chams",               default = false })
    sec2:slider({ name = "Fill Alpha",                flag = "viewmodel_chams_alpha_fill",    min = 0, max = 1, default = 0.5, interval = 0.01 })
    sec2:slider({ name = "Outline Alpha",             flag = "viewmodel_chams_alpha_outline", min = 0, max = 1, default = 1, interval = 0.01 })
    sec2:toggle({ name = "Gun Wireframe",             flag = "gun wireframe",                 default = false })
    sec2:toggle({ name = "Disable Textures",          flag = "viewmodel_disable_textures",    default = false })
    sec2:toggle({ name = "Recoil",                    flag = "viewmodel_recoil",              default = false })
    sec2:dropdown({name = "Material",                 flag = "viewmodel_material_value",      items = { "Neon", "Plastic", "SmoothPlastic", "ForceField" }, default = "Neon" })
    sec2:slider({ name = "Offset X",                  flag = "viewmodel_offset_x",            min = -2, max = 2, default = 0, interval = 0.01 })
    sec2:slider({ name = "Offset Y",                  flag = "viewmodel_offset_y",            min = -2, max = 2, default = 0, interval = 0.01 })
    sec2:slider({ name = "Offset Z",                  flag = "viewmodel_offset_z",            min = -2, max = 2, default = 0, interval = 0.01 })
end

-----------------------------------------------------------------------
-- MOVEMENT  (Main / Teleport / Exploits / Melee / Hitbox)
-----------------------------------------------------------------------
local mv_main, mv_tp, mv_ex, mv_melee, mv_hitbox = window:tab({ name = "Movement", icon = ICO.movement, tabs = { "Main", "Teleport", "Exploits", "Melee", "Hitbox" } })

do
    local col = mv_main:column({})
    local sec = col:section({ name = "Movement", size = 1, icon = ICO.movement, default = true })
    sec:toggle({  name = "Fly",                       flag = "movement_fly",                  default = false })
    sec:keybind({ name = "Fly Keybind",               flag = "movement_flykeybind",           key = nil, mode = "Toggle" })
    sec:slider({  name = "Flight Speed",              flag = "movement_flyvalue",             min = 1, max = 200, default = 30, interval = 1 })
    sec:toggle({  name = "Noclip",                    flag = "movement_noclip",               default = false })
    sec:keybind({ name = "Noclip Keybind",            flag = "movement_noclipkeybind",        key = nil, mode = "Toggle" })
    sec:toggle({  name = "Auto Noclip Underground",   flag = "Auto Noclip Underground",       default = false })
    sec:toggle({  name = "Velocity",                  flag = "movement_velocity",             default = false })
    sec:keybind({ name = "Velocity Keybind",          flag = "movement_velocitykeybind",      key = nil, mode = "Toggle" })
    sec:slider({  name = "Walk Speed Multiplier",     flag = "movement_velocityvalue",        min = 1, max = 200, default = 50, interval = 1 })
    sec:toggle({  name = "Enable WalkSpeed Multiplier", flag = "Enable WalkSpeed Multiplier", default = false })
    sec:toggle({  name = "Slide Boost",               flag = "movement_slideboost",           default = false })
    sec:slider({  name = "Slide Boost Value",         flag = "movement_slideboostvalue",      min = 1, max = 100, default = 30, interval = 1 })
    sec:toggle({  name = "Infinite Double Jumps",     flag = "movement_infinite_double_jump", default = false })
    sec:slider({  name = "Double Jump Height",        flag = "movement_double_jump_height",   min = 1, max = 10, default = 1, interval = 0.1 })
    sec:toggle({  name = "Jump Pads",                 flag = "Jump Pads",                     default = false })
    sec:toggle({  name = "Zero Assembly Velocity",    flag = "Zero Assembly Velocity",        default = false })
    sec:toggle({  name = "Camera Replication Decouple", flag = "Camera Replication Decouple", default = false })
    sec:slider({  name = "Surface Camera Elevation",  flag = "Surface Camera Elevation",      min = -20, max = 20, default = 0, interval = 0.5 })

    local sec2 = col:section({ name = "Anti-Aim", size = 1, icon = ICO.movement, default = false })
    sec2:toggle({  name = "Enabled",                  flag = "anti_aim_enabled",              default = false })
    sec2:dropdown({name = "Pitch",                    flag = "anti_aim_pitch",                items = { "None", "Down", "Up", "Zero Pitch" }, default = "None" })
    sec2:dropdown({name = "Yaw",                      flag = "anti_aim_yaw",                  items = { "None", "Spin", "Jitter", "Jitter Fast", "Jitter Slow", "Backwards", "Side", "Sway HvH" }, default = "None" })
    sec2:slider({  name = "Custom Pitch Angle",       flag = "anti_aim_custom_pitch",         min = -90, max = 90, default = 0, interval = 1, suffix = "°" })
    sec2:slider({  name = "Custom Yaw Angle",         flag = "anti_aim_custom_yaw",           min = -180, max = 180, default = 0, interval = 1, suffix = "°" })
    sec2:toggle({  name = "Spinbot",                  flag = "spinbot",                       default = false })
    sec2:slider({  name = "Spinbot Yaw Speed",        flag = "Spinbot Yaw Speed",             min = 1, max = 50, default = 10, interval = 1 })
    sec2:toggle({  name = "Floor Hide",               flag = "anti_aim_floor_hide",           default = false })
    sec2:keybind({ name = "Floor Hide Keybind",       flag = "anti_aim_floor_hide_keybind",   key = nil, mode = "Hold" })
end

do
    local col = mv_tp:column({})
    local sec = col:section({ name = "Teleport V2", size = 1, icon = ICO.movement, default = true })
    sec:toggle({  name = "Enabled",                   flag = "tp_v2",                         default = false })
    sec:keybind({ name = "Teleport Key",              flag = "tp_v2_key",                     key = nil, mode = "Hold" })
    sec:slider({  name = "Teleport Offset X",         flag = "Teleport Offset X",             min = -50, max = 50, default = 0, interval = 1 })
    sec:slider({  name = "Teleport Offset Z",         flag = "Teleport Offset Z",             min = -50, max = 50, default = 0, interval = 1 })
    sec:dropdown({name = "Teleport V2 Origin",        flag = "Teleport V2 Origin",            items = { "Camera", "Crosshair", "Mouse" }, default = "Camera" })

    local sec2 = col:section({ name = "Void Teleport", size = 1, icon = ICO.movement, default = false })
    sec2:toggle({ name = "Enabled",                   flag = "Void Teleport",                 default = false })
    sec2:keybind({name = "Keybind",                   flag = "void_tp_key",                   key = nil, mode = "Hold" })

    local sec3 = col:section({ name = "Underground", size = 1, icon = ICO.movement, default = false })
    sec3:toggle({ name = "Underground V2",            flag = "Underground V2",                default = false })
    sec3:slider({ name = "Underground Depth",         flag = "Underground Depth",             min = -50, max = 0, default = -5, interval = 0.5 })
    sec3:toggle({ name = "Melee Underground Strike",  flag = "Melee Underground Strike",      default = false })
end

do
    local col = mv_ex:column({})
    local sec = col:section({ name = "Exploits", size = 1, icon = ICO.misc, default = true })
    sec:toggle({ name = "Full Auto",                  flag = "exploits_full_auto",            default = false })
    sec:slider({ name = "Fire Rate",                  flag = "exploits_firerate",             min = 1, max = 20, default = 5, interval = 1 })
    sec:toggle({ name = "No Spread",                  flag = "exploits_no_spread",            default = false })
    sec:toggle({ name = "Choke Limit",                flag = "Choke Limit",                   default = false })
    sec:toggle({ name = "Auto Buy Ammunition",        flag = "Auto Buy Ammunition",           default = false })
    sec:toggle({ name = "Auto Weapon Swap When Empty", flag = "Auto Weapon Swap When Empty",  default = false })
    sec:toggle({ name = "Wallbang V2 Solver",         flag = "Wallbang V2 Solver",            default = false })
    sec:toggle({ name = "Always Backstab",            flag = "exploits_always_backstab",      default = false })
    sec:toggle({ name = "FireHitbox",                 flag = "FireHitbox",                    default = false })
    sec:dropdown({name = "Hitbox Preset",             flag = "Hitbox Preset",                 items = { "Default", "Head", "Torso", "Full Body", "Rapid Body" }, default = "Default" })

    local sec2 = col:section({ name = "Game Utilities", size = 1, icon = ICO.misc, default = false })
    sec2:toggle({ name = "Arcade Auto Respawn",       flag = "arcade_auto_respawn",           default = false })
    sec2:toggle({ name = "Enable Auto Loadout",       flag = "Enable Auto Loadout",           default = false })
    sec2:dropdown({name = "Preferred Weapon",         flag = "preferred weapon",              items = { "None", "Assault Rifle", "Sniper", "Bow", "Crossbow", "Shotgun", "Minigun", "Burst Rifle", "Uzi", "Vandal" }, default = "None" })
end

do
    local col = mv_melee:column({})
    local sec = col:section({ name = "Melee", size = 1, icon = ICO.misc, default = true })
    sec:toggle({ name = "Avoid Katana Deflect",       flag = "Avoid Katana Deflect",          default = false })
    sec:slider({ name = "Melee Desync Reach",         flag = "Melee Desync Reach",            min = 1, max = 50, default = 5, interval = 0.5 })
    sec:slider({ name = "Melee Safe Reach",           flag = "Melee Safe Reach",              min = 1, max = 20, default = 5, interval = 0.5 })
    sec:toggle({ name = "Melee Underground Strike",   flag = "ex_melee_underground",          default = false })
    sec:toggle({ name = "Juggle",                     flag = "juggle",                        default = false })
    sec:toggle({ name = "Rapid Body",                 flag = "rapid body",                    default = false })
end

do
    local col = mv_hitbox:column({})
    local sec = col:section({ name = "Hitbox", size = 1, icon = ICO.misc, default = true })
    sec:toggle({ name = "FireHitboxes",               flag = "FireHitboxes",                  default = false })
    sec:dropdown({name = "Hitbox Preset",             flag = "hitbox_preset",                 items = { "Head", "Torso", "UpperTorso", "LowerTorso", "Full Body", "Rapid Body" }, default = "Head" })
    sec:toggle({ name = "Visible Depth Check",        flag = "Visible Depth Check",           default = false })
    sec:slider({ name = "Target Hitbox Size",         flag = "Target Hitbox",                 min = 1, max = 20, default = 3, interval = 0.5 })
end

-----------------------------------------------------------------------
-- MISC  (Main / Automate / Cosmetics / Server / Music)
-----------------------------------------------------------------------
local mc_main, mc_automate, mc_cosmetics, mc_server, mc_music = window:tab({ name = "Misc", icon = ICO.misc, tabs = { "Main", "Automate", "Cosmetics", "Server", "Music" } })

do
    local col = mc_main:column({})
    local sec = col:section({ name = "General", size = 1, icon = ICO.misc, default = true })
    sec:toggle({ name = "Name Spoofer",               flag = "name_spoofer",                  default = false })
    sec:toggle({ name = "Remove Vignette",            flag = "item_remove_vignette",          default = false })
    sec:toggle({ name = "Item Status",                flag = "item_status_enabled",           default = false })
    sec:toggle({ name = "Camera Blur",                flag = "camera_blur",                   default = false })
    sec:toggle({ name = "Camera Anti Flashbang",      flag = "camera_anti_flashbang",         default = false })
    sec:toggle({ name = "Camera Aspect Ratio",        flag = "camera_aspect_ratio",           default = false })
    sec:slider({ name = "Aspect Ratio X",             flag = "camera_aspect_ratio_x",         min = 1, max = 32, default = 16, interval = 1 })
    sec:slider({ name = "Aspect Ratio Y",             flag = "camera_aspect_ratio_y",         min = 1, max = 32, default = 9, interval = 1 })
    sec:toggle({ name = "Custom Camera FOV",          flag = "camera_fov_changer",            default = false })
    sec:slider({ name = "FOV Amount",                 flag = "camera_fov_changer_amount",     min = 50, max = 120, default = 70, interval = 1, callback = function(v)
        if library.flags.camera_fov_changer then Camera.FieldOfView = v end
    end })
    sec:toggle({ name = "Third Person POV",           flag = "third_person_enabled",          default = false })
    sec:keybind({name = "Third Person Keybind",       flag = "third_person_keybind",          key = nil, mode = "Toggle" })
    sec:toggle({ name = "Loadout",                    flag = "loadout",                       default = false })
    sec:toggle({ name = "Unrestricted Loadout",       flag = "loadout_unrestricted",          default = false })
    sec:toggle({ name = "Chat Spam",                  flag = "chat_spam_enabled",             default = false })
    sec:dropdown({name = "Spam Mode",                 flag = "chat_spam_mode",                items = { "Repeat", "Sequential", "Random" }, default = "Repeat" })
    sec:toggle({ name = "Show Keybinds Widget",       flag = "Show Keybinds Widget",          default = false })
    sec:toggle({ name = "Hide Character Meshes",      flag = "Hide Character Meshes",         default = false })
    sec:toggle({ name = "Hide Head",                  flag = "hide head",                     default = false })
    sec:slider({ name = "Hide Head Angle",            flag = "Hide Head Angle",               min = 0, max = 90, default = 45, interval = 1, suffix = "°" })
    sec:toggle({ name = "Unload Cheat",               flag = "unload_cheat",                  default = false, callback = function(v)
        if v then
            library.notifications:create_notification({ name = "kami", info = "Unloading...", lifetime = 1 })
            task.wait(1); if library.unload then library:unload() end
        end
    end })
end

do
    local col = mc_automate:column({})
    local sec = col:section({ name = "Auto Queue", size = 1, icon = ICO.misc, default = true })
    sec:toggle({ name = "Enabled",                    flag = "auto_queue_enabled",            default = false })
    sec:dropdown({name = "Mode",                      flag = "auto_queue_mode",               items = { "Any", "Competitive", "Casual", "Unranked" }, default = "Any" })
    sec:toggle({ name = "Auto Select Enabled",        flag = "auto_select_enabled",           default = false })
    sec:dropdown({name = "Primary",                   flag = "auto_select_Primary",           items = { "None", "Assault Rifle", "Sniper", "Bow", "Crossbow", "Shotgun", "Minigun", "Burst Rifle", "Uzi", "Vandal" }, default = "None" })
    sec:dropdown({name = "Secondary",                 flag = "auto_select_Secondary",         items = { "None", "Daggers", "Katana", "Fists", "Bat", "Scythe", "Spear" }, default = "None" })
    sec:dropdown({name = "Melee",                     flag = "auto_select_Melee",             items = { "None", "Katana", "Daggers", "Knife", "Bat", "Fists", "Scythe" }, default = "None" })
    sec:dropdown({name = "Utility",                   flag = "auto_select_Utility",           items = { "None", "Grenade", "Smoke Grenade", "Molotov", "Flashbang", "Satchel", "Subspace Tripmine" }, default = "None" })

    local sec2 = col:section({ name = "Auto Ban", size = 1, icon = ICO.misc, default = false })
    sec2:toggle({ name = "Enabled",                   flag = "autoban",                       default = false })
    sec2:toggle({ name = "First",                     flag = "autoban_first",                 default = false })
    sec2:slider({ name = "First Delay",               flag = "autoban_first_delay",           min = 0, max = 10, default = 0.5, interval = 0.1, suffix = "s" })
    sec2:toggle({ name = "Second",                    flag = "autoban_second",                default = false })
    sec2:slider({ name = "Second Delay",              flag = "autoban_second_delay",          min = 0, max = 10, default = 1, interval = 0.1, suffix = "s" })
    sec2:slider({ name = "Map Delay",                 flag = "autoban_map_delay",             min = 0, max = 30, default = 5, interval = 0.5, suffix = "s" })
end

do
    local col = mc_cosmetics:column({})
    local sec = col:section({ name = "Cosmetic Changer", size = 1, icon = ICO.misc, default = true })
    sec:toggle({ name = "Enabled",                    flag = "cosmetics_changer_save_data",   default = false })
    sec:button({ name = "Open Cosmetic Changer",      callback = function()
        library.notifications:create_notification({ name = "Cosmetics", info = "Opening changer...", lifetime = 1 })
    end })
    sec:dropdown({name = "Skybox Preset",             flag = "Skybox Preset",                 items = { "Default", "Galaxy2", "Galaxy3", "Deep Space", "FlamingSunset", "GreenHaze", "BetterNight3", "AestheticMountains", "Vaporwave", "Synthwave", "Subterranean", "Storm" }, default = "Default", callback = function(v)
        if v == "Default" then return end
        local sky = Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky", Lighting)
        local ids = {
            Galaxy2 = "rbxassetid://11563947029", Galaxy3 = "rbxassetid://11563950929",
            ["Deep Space"] = "rbxassetid://11563943229",
        }
        if ids[v] then
            for _, face in {"SkyboxBk","SkyboxDn","SkyboxFt","SkyboxLf","SkyboxRt","SkyboxUp"} do
                sky[face] = ids[v]
            end
        end
    end })
    sec:toggle({ name = "Enable Skybox Override",     flag = "Enable Skybox Override",        default = false })
    sec:slider({ name = "Sky Rotation Speed",         flag = "Sky Rotation Speed",            min = 0, max = 10, default = 0, interval = 0.1 })

    local sec2 = col:section({ name = "Arm Appearance", size = 1, icon = ICO.misc, default = false })
    sec2:toggle({ name = "Override Appearance",       flag = "arm_override_appearance",       default = false })
    sec2:toggle({ name = "Disable Textures",          flag = "arm_disable_textures",          default = false })
    sec2:toggle({ name = "Body Color",                flag = "arm_body_color",                default = false })
    sec2:slider({ name = "Body Transparency",         flag = "arm_body_transparency",         min = 0, max = 1, default = 0, interval = 0.01 })
    sec2:dropdown({name = "Material",                 flag = "arm_material_value",            items = { "Neon", "Plastic", "SmoothPlastic", "ForceField", "Glass" }, default = "Plastic" })
    sec2:toggle({ name = "Wrap Textures",             flag = "WrapTextures",                  default = false })
    sec2:toggle({ name = "Hide Character Meshes",     flag = "cosmetic_hide_meshes",          default = false })
end

do
    local col = mc_server:column({})
    local sec = col:section({ name = "Server", size = 1, icon = ICO.misc, default = true })
    sec:button({ name = "Server Hop",                 callback = function()
        library.notifications:create_notification({ name = "Server", info = "Hopping...", lifetime = 1 })
        pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LP) end)
    end })
    sec:button({ name = "Disconnect",                 callback = function()
        pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId, LP) end)
    end })
    sec:button({ name = "Copy Discord Invite",        callback = function()
        if setclipboard then setclipboard("discord.gg/kami") end
        library.notifications:create_notification({ name = "Misc", info = "Copied!", lifetime = 1 })
    end })
    sec:toggle({ name = "Staff Detection Action",     flag = "Staff Detection Action",        default = false })
    sec:dropdown({name = "Action",                    flag = "Staff Alert",                   items = { "Notify", "Disconnect", "Noclip" }, default = "Notify" })
end

do
    local col = mc_music:column({})
    local sec = col:section({ name = "Music Player", size = 1, icon = ICO.misc, default = true })
    sec:toggle({  name = "Show Music Player",         flag = "Show Music Player",             default = false })
    sec:toggle({  name = "Load Community Songs",      flag = "Load Community Songs",          default = false })
    sec:toggle({  name = "Custom Audio Stream",       flag = "Custom Audio Stream",           default = false })
    sec:slider({  name = "Sound Volume",              flag = "music_volume",                  min = 0, max = 1, default = 0.5, interval = 0.05 })
    sec:toggle({  name = "Bass Boost",                flag = "bass boost",                    default = false })
    sec:dropdown({name = "Preset Track",             flag = "music_preset",                  items = {
        "None", "DVRST", "KSLV", "KSLV Noh", "Molchat Doma", "Crystal Castles",
        "M83", "INTERWORLD", "Snow Strippers", "Ari Abdul", "Teriyaki Boyz",
        "Basshunter", "Mareux", "Djo", "MoonDeity", "FrankJavCee",
        "Hensonn", "Jett", "King Nasir", "MC Orsen", "Keynais",
    }, default = "None" })
    sec:toggle({  name = "Shuffle",                   flag = "music_shuffle",                 default = false })
    sec:dropdown({name = "Repeat Mode",               flag = "music_repeat",                  items = { "None", "Repeat All", "Sped Up", "Slowed" }, default = "None" })
end

-----------------------------------------------------------------------
-- VISUALS  (Crosshair / HUD / Lighting / World)
-----------------------------------------------------------------------
local vis_crosshair, vis_hud, vis_lighting, vis_world = window:tab({ name = "Visuals", icon = ICO.visuals, tabs = { "Crosshair", "HUD", "Lighting", "World" } })

do
    local col = vis_crosshair:column({})
    local sec = col:section({ name = "Custom Crosshair", size = 1, icon = ICO.visuals, default = true })
    sec:toggle({ name = "Enabled",                    flag = "crosshair_enabled",             default = false })
    sec:toggle({ name = "Disable Game Crosshair",     flag = "crosshair_disable_game",        default = false })
    sec:dropdown({name = "Style",                     flag = "crosshair_style",               items = { "Cross", "T-Shape", "Dot", "Circle", "Square" }, default = "Cross" })
    sec:slider({ name = "Crosshair Length",           flag = "crosshair_length",              min = 1, max = 30, default = 8, interval = 1 })
    sec:slider({ name = "Crosshair Thickness",        flag = "crosshair_thickness",           min = 1, max = 5, default = 2, interval = 1 })
    sec:slider({ name = "Offset (Gap)",               flag = "crosshair_offset",              min = 0, max = 20, default = 4, interval = 1 })
    sec:toggle({ name = "Crosshair Outlines",         flag = "crosshair_outline",             default = false })
    sec:toggle({ name = "Center Dot",                 flag = "crosshair_center_dot",          default = false })
    sec:slider({ name = "Center Dot Size",            flag = "crosshair_dot_size",            min = 1, max = 10, default = 3, interval = 1 })
    sec:toggle({ name = "Bounce",                     flag = "crosshair_bounce",              default = false })
    sec:slider({ name = "Bounce Speed",               flag = "crosshair_bounce_speed",        min = 0.1, max = 5, default = 1, interval = 0.1 })
    sec:toggle({ name = "Lerp",                       flag = "crosshair_lerp",                default = true })
    sec:toggle({ name = "Rotation",                   flag = "crosshair_rotation",            default = false })
    sec:slider({ name = "Rotation Speed",             flag = "crosshair_rotation_speed",      min = 0.1, max = 10, default = 1, interval = 0.1 })

    local sec2 = col:section({ name = "FOV Circle", size = 1, icon = ICO.visuals, default = false })
    sec2:toggle({ name = "Filled FOV Circle",         flag = "crosshair_fov_filled",          default = false })
end

do
    local col = vis_hud:column({})
    local sec = col:section({ name = "HUD", size = 1, icon = ICO.visuals, default = true })
    sec:toggle({ name = "Ammo Bar",                   flag = "indicator_ammo",                default = false })
    sec:dropdown({name = "Ammo Bar Color",            flag = "indicator_ammo_style",          items = { "Static", "Gradient", "Dynamic" }, default = "Static" })
    sec:dropdown({name = "Ammo Color Mode",           flag = "Ammo Color Mode",               items = { "Static", "By Ammo", "By Health" }, default = "Static" })
    sec:toggle({ name = "Health Bar",                 flag = "hud_hp_bar",                    default = false })
    sec:toggle({ name = "Health Number",              flag = "hud_hp_num",                    default = false })
    sec:toggle({ name = "Win Streak",                 flag = "hud_winstreak",                 default = false })
    sec:toggle({ name = "Ragebot Indicator",          flag = "indicator_ragebot",             default = false })
    sec:dropdown({name = "Ragebot Style",             flag = "indicator_ragebot_style",       items = { "Text", "Icon", "Both" }, default = "Text" })
    sec:slider({ name = "HUD Scale Multiplier",       flag = "hud_scale",                     min = 0.5, max = 3, default = 1, interval = 0.1 })
    sec:slider({ name = "Indicator Offset X",         flag = "indicator_offset_x",            min = -200, max = 200, default = 0, interval = 1 })
    sec:slider({ name = "Indicator Offset Y",         flag = "indicator_offset_y",            min = -200, max = 200, default = 0, interval = 1 })
    sec:toggle({ name = "Watermark",                  flag = "hud_watermark",                 default = true })

    local sec2 = col:section({ name = "Hitmarker", size = 1, icon = ICO.visuals, default = false })
    sec2:toggle({ name = "Enabled",                   flag = "hud_hitmarker",                 default = false })
    sec2:toggle({ name = "Hitmarker Dynamic Pulse",   flag = "Hitmarker Dynamic Pulse",       default = false })
    sec2:slider({ name = "Lifetime (ms)",             flag = "hud_hm_life",                   min = 50, max = 1000, default = 200, interval = 10 })

    local sec3 = col:section({ name = "Kill / Hit Sounds", size = 1, icon = ICO.visuals, default = false })
    sec3:toggle({ name = "Kill Sound Enabled",        flag = "Kill Sound Enabled",            default = false })
    sec3:dropdown({name = "Kill Sound Preset",        flag = "Kill Sound Preset",             items = { "Default", "Skeet", "Bonk", "Bell", "Headshot" }, default = "Default" })
    sec3:toggle({ name = "Hit Sound Enabled",         flag = "Hit Sound Enabled",             default = false })
    sec3:dropdown({name = "Hit Sound Preset",         flag = "Hit Sound Preset",              items = { "Default", "Skeet", "Bonk", "Bell" }, default = "Default" })
    sec3:slider({ name = "Sound Volume",              flag = "Sound Volume",                  min = 0, max = 1, default = 0.5, interval = 0.05 })
end

do
    local col = vis_lighting:column({})
    local sec = col:section({ name = "Lighting", size = 1, icon = ICO.visuals, default = true })
    sec:dropdown({name = "Technology Mode",           flag = "lighting_technology",           items = { "Voxel", "ShadowMap", "Future", "Compatibility" }, default = "ShadowMap", callback = function(v)
        Lighting.Technology = Enum.Technology[v]
    end })
    sec:toggle({ name = "World Lighting Modulation",  flag = "lighting_toggle_Brightness",    default = false })
    sec:slider({ name = "Brightness Value",           flag = "lighting_number_Brightness",    min = 0, max = 10, default = 2, interval = 0.1, callback = function(v)
        if library.flags.lighting_toggle_Brightness then Lighting.Brightness = v end
    end })
    sec:toggle({ name = "Clock Time",                 flag = "lighting_toggle_ClockTime",     default = false })
    sec:slider({ name = "Time of Day",                flag = "lighting_number_ClockTime",     min = 0, max = 24, default = 14, interval = 0.1, callback = function(v)
        if library.flags.lighting_toggle_ClockTime then Lighting.ClockTime = v end
    end })
    sec:toggle({ name = "Global Shadows",             flag = "lighting_bool_GlobalShadows",   default = true })
    sec:slider({ name = "Shadow Softness",            flag = "Shadow Softness",               min = 0, max = 1, default = 0.2, interval = 0.01, callback = function(v)
        Lighting.ShadowSoftness = v
    end })

    local sec2 = col:section({ name = "Fog", size = 1, icon = ICO.visuals, default = false })
    sec2:toggle({ name = "Enabled",                   flag = "lighting_toggle_FogEnd",        default = false })
    sec2:slider({ name = "Fog End Distance",          flag = "lighting_number_FogEnd",        min = 0, max = 100000, default = 100000, interval = 100, callback = function(v)
        if library.flags.lighting_toggle_FogEnd then Lighting.FogEnd = v end
    end })
    sec2:slider({ name = "Fog Start Distance",        flag = "lighting_number_FogStart",      min = 0, max = 1000, default = 0, interval = 1, callback = function(v)
        if library.flags.lighting_toggle_FogEnd then Lighting.FogStart = v end
    end })

    local sec3 = col:section({ name = "Color Correction", size = 1, icon = ICO.visuals, default = false })
    sec3:toggle({ name = "Enabled",                   flag = "color_correction_enabled",      default = false })
    sec3:slider({ name = "Contrast",                  flag = "color_correction_contrast",     min = -1, max = 1, default = 0, interval = 0.01 })
    sec3:slider({ name = "Saturation",                flag = "color_correction_saturation",   min = -1, max = 1, default = 0, interval = 0.01 })
    sec3:slider({ name = "Brightness",                flag = "color_correction_brightness",   min = -1, max = 1, default = 0, interval = 0.01 })
    sec3:slider({ name = "Exposure",                  flag = "lighting_number_ExposureCompensation", min = -3, max = 3, default = 0, interval = 0.1, callback = function(v)
        if library.flags.color_correction_enabled then Lighting.ExposureCompensation = v end
    end })

    local sec4 = col:section({ name = "Bloom", size = 1, icon = ICO.visuals, default = false })
    sec4:toggle({ name = "Enabled",                   flag = "bloom_enabled",                 default = false })
    sec4:slider({ name = "Intensity",                 flag = "bloom_intensity",               min = 0, max = 10, default = 1, interval = 0.1 })
    sec4:slider({ name = "Size",                      flag = "bloom_size",                    min = 0, max = 56, default = 24, interval = 1 })
    sec4:slider({ name = "Threshold",                 flag = "bloom_threshold",               min = 0, max = 2, default = 1, interval = 0.01 })

    local sec5 = col:section({ name = "Atmosphere", size = 1, icon = ICO.visuals, default = false })
    sec5:toggle({ name = "Enabled",                   flag = "atmosphere_enabled",            default = false })
    sec5:slider({ name = "Density",                   flag = "atmosphere_density",            min = 0, max = 1, default = 0.3, interval = 0.01 })
    sec5:slider({ name = "Offset",                    flag = "atmosphere_offset",             min = 0, max = 1, default = 0, interval = 0.01 })
    sec5:slider({ name = "Haze",                      flag = "atmosphere_haze",               min = 0, max = 10, default = 0, interval = 0.1 })
    sec5:slider({ name = "Glare",                     flag = "atmosphere_glare",              min = 0, max = 1, default = 0, interval = 0.01 })
    sec5:slider({ name = "Decay",                     flag = "atmosphere_decay",              min = 0, max = 1, default = 0, interval = 0.01 })
end

do
    local col = vis_world:column({})
    local sec = col:section({ name = "Sunrays", size = 1, icon = ICO.visuals, default = false })
    sec:toggle({ name = "Enabled",                    flag = "sunrays_enabled",               default = false })
    sec:slider({ name = "Intensity",                  flag = "sunrays_intensity",             min = 0, max = 1, default = 0.5, interval = 0.01 })
    sec:slider({ name = "Spread",                     flag = "sunrays_spread",                min = 0, max = 1, default = 0.5, interval = 0.01 })

    local sec2 = col:section({ name = "Skybox", size = 1, icon = ICO.visuals, default = false })
    sec2:toggle({ name = "Enable Skybox Override",    flag = "skybox_enabled",                default = false })
    sec2:dropdown({name = "Skybox Preset",            flag = "skybox_preset_vis",             items = { "Default", "Galaxy2", "Galaxy3", "Deep Space", "FlamingSunset", "GreenHaze", "BetterNight3", "Vaporwave", "Synthwave", "Subterranean", "Storm", "Winter", "Valentines" }, default = "Default" })

    local sec3 = col:section({ name = "Weather", size = 1, icon = ICO.visuals, default = false })
    sec3:toggle({ name = "Enabled",                   flag = "weather_enabled",               default = false })
    sec3:dropdown({name = "Type",                     flag = "weather_value",                 items = { "Rain", "Snow", "Lightning", "Blizzard", "Storm", "Stars", "Moon", "Solar System", "Sparkle" }, default = "Rain" })
    sec3:slider({ name = "Rate Multiplier",           flag = "weather_rate_multiplier",       min = 0.1, max = 5, default = 1, interval = 0.1 })
    sec3:slider({ name = "Lifetime Multiplier",       flag = "weather_lifetime_multiplier",   min = 0.1, max = 5, default = 1, interval = 0.1 })
end

-----------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------
local cfg_main = window:tab({ name = "Config", icon = ICO.config, tabs = { "Main" } })

do
    local col = cfg_main:column({})
    local sec = col:section({ name = "Config Actions", size = 1, icon = ICO.config, default = true })
    sec:button({ name = "Load Config",                callback = function()
        if readfile and isfile and isfile("kamidere/settings/default.json") then
            local ok, data = pcall(function()
                return game:GetService("HttpService"):JSONDecode(readfile("kamidere/settings/default.json"))
            end)
            if ok and type(data) == "table" then
                for k, v in data do library.flags[k] = v end
                library.notifications:create_notification({ name = "Config", info = "Loaded!", lifetime = 2 })
            end
        end
    end })
    sec:button({ name = "Save",                       callback = function()
        if writefile then
            if makefolder and not isfolder("kamidere/settings") then
                makefolder("kamidere"); makefolder("kamidere/settings")
            end
            local ok = pcall(writefile, "kamidere/settings/default.json",
                game:GetService("HttpService"):JSONEncode(library.flags))
            library.notifications:create_notification({ name = "Config", info = ok and "Saved!" or "Error", lifetime = 2 })
        end
    end })
    sec:button({ name = "Export to Clipboard",        callback = function()
        if setclipboard then
            setclipboard(game:GetService("HttpService"):JSONEncode(library.flags))
            library.notifications:create_notification({ name = "Config", info = "Exported!", lifetime = 2 })
        end
    end })
    sec:button({ name = "Import from Clipboard",      callback = function()
        if getclipboard then
            local ok, data = pcall(function()
                return game:GetService("HttpService"):JSONDecode(getclipboard())
            end)
            if ok and type(data) == "table" then
                for k, v in data do library.flags[k] = v end
                library.notifications:create_notification({ name = "Config", info = "Imported!", lifetime = 2 })
            end
        end
    end })
    sec:button({ name = "Delete Config",              callback = function()
        if delfile and isfile and isfile("kamidere/settings/default.json") then
            pcall(delfile, "kamidere/settings/default.json")
            library.notifications:create_notification({ name = "Config", info = "Deleted", lifetime = 2 })
        end
    end })
    sec:button({ name = "Reset to Defaults",          callback = function()
        for k in library.flags do library.flags[k] = nil end
        library.notifications:create_notification({ name = "Config", info = "Reset!", lifetime = 2 })
    end })
    sec:toggle({ name = "Auto Load",                  flag = "auto_load_enabled",             default = false })
    sec:toggle({ name = "Auto Load Silent",           flag = "auto_load_silent",              default = false })

    local sec2 = col:section({ name = "Configs", size = 1, icon = ICO.config, default = false })
    sec2:button({ name = "Refresh",                   callback = function()
        library.notifications:create_notification({ name = "Config", info = "Refreshed", lifetime = 1 })
    end })
end

-----------------------------------------------------------------------
-- RUNTIME FLAGS
-----------------------------------------------------------------------
local flags = library.flags

-----------------------------------------------------------------------
-- UTILITY
-----------------------------------------------------------------------
local function getChar(p)  return p and p.Character end
local function getHum(c)   return c and c:FindFirstChildOfClass("Humanoid") end
local function isAlive(p)  local h = getHum(getChar(p)); return h and h.Health > 0 end

local function getPart(char, name)
    if name == "Nearest" then
        local best, bd = nil, math.huge
        for _, p in char:GetDescendants() do
            if p:IsA("BasePart") then
                local _, d = Camera:WorldToViewportPoint(p.Position)
                if d < bd then bd = d; best = p end
            end
        end
        return best
    end
    return char:FindFirstChild(name) or char:FindFirstChild("Head")
end

local function getTarget(fov, prioMode, visOnly, limitDist, maxDist)
    local vpC = Camera.ViewportSize / 2
    local best, bestVal = nil, math.huge
    for _, p in Players:GetPlayers() do
        if p == LP then continue end
        if not isAlive(p) then continue end
        local char = getChar(p); if not char then continue end
        local head = char:FindFirstChild("Head"); if not head then continue end
        if visOnly then
            local rcp = RaycastParams.new()
            rcp.FilterDescendantsInstances = { char, getChar(LP) }
            rcp.FilterType = Enum.RaycastFilterType.Exclude
            local res = workspace:Raycast(Camera.CFrame.Position, (head.Position - Camera.CFrame.Position), rcp)
            if res then continue end
        end
        local sp, onScreen = Camera:WorldToViewportPoint(head.Position)
        if not onScreen then continue end
        local dist2d = (Vector2.new(sp.X, sp.Y) - vpC).Magnitude
        if fov and dist2d > fov then continue end
        if limitDist then
            local root = getChar(LP) and getChar(LP):FindFirstChild("HumanoidRootPart")
            local d3 = root and (root.Position - head.Position).Magnitude or math.huge
            if d3 > (maxDist or 500) then continue end
        end
        local val = dist2d
        if prioMode == "Lowest HP" or prioMode == "Smart Lowest HP" then
            local hum = getHum(char); val = hum and hum.Health or math.huge
        elseif prioMode == "Nearest" then
            local root = getChar(LP) and getChar(LP):FindFirstChild("HumanoidRootPart")
            val = root and (root.Position - head.Position).Magnitude or math.huge
        end
        if val < bestVal then bestVal = val; best = { player = p, char = char, dist2d = dist2d, worldPos = head.Position } end
    end
    return best
end

local function fire() if mouse1click then mouse1click() end end

-----------------------------------------------------------------------
-- ESP OBJECTS
-----------------------------------------------------------------------
local espObjects = {}

local SKEL = {
    {"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
    {"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},
    {"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},
    {"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},
    {"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"},
}

local function removeEspFor(p)
    local t = espObjects[p]; if not t then return end
    for _, d in t do
        if type(d) == "table" then for _, l in d do pcall(function() l:Remove() end) end
        else pcall(function() d:Remove() end) end
    end
    espObjects[p] = nil
end

local function createEspFor(p)
    local t = {}
    t.box     = Drawing.new("Square"); t.box.Thickness = 1; t.box.Color = Color3.fromRGB(255,60,60); t.box.Visible = false
    t.name    = Drawing.new("Text");   t.name.Size = 13; t.name.Center = true; t.name.Outline = true; t.name.Color = Color3.fromRGB(255,255,255); t.name.Visible = false
    t.name.Text = (flags["Use Display Names"] and p.DisplayName) or p.Name
    t.dist    = Drawing.new("Text");   t.dist.Size = 11; t.dist.Center = true; t.dist.Outline = true; t.dist.Color = Color3.fromRGB(200,200,200); t.dist.Visible = false
    t.hpbg    = Drawing.new("Square"); t.hpbg.Filled = true; t.hpbg.Color = Color3.fromRGB(0,0,0); t.hpbg.Visible = false
    t.hp      = Drawing.new("Square"); t.hp.Filled = true; t.hp.Color = Color3.fromRGB(60,255,60); t.hp.Visible = false
    t.hpnum   = Drawing.new("Text");   t.hpnum.Size = 10; t.hpnum.Center = true; t.hpnum.Outline = true; t.hpnum.Color = Color3.fromRGB(255,255,255); t.hpnum.Visible = false
    t.tracer  = Drawing.new("Line");   t.tracer.Thickness = 1; t.tracer.Color = Color3.fromRGB(255,60,60); t.tracer.Visible = false
    t.headcirc= Drawing.new("Circle"); t.headcirc.Thickness = 1; t.headcirc.Filled = false; t.headcirc.Color = Color3.fromRGB(255,200,60); t.headcirc.Visible = false
    t.arrow   = Drawing.new("Triangle"); t.arrow.Filled = true; t.arrow.Color = Color3.fromRGB(255,60,60); t.arrow.Visible = false
    t.skel    = {}
    for i = 1, #SKEL do
        t.skel[i] = Drawing.new("Line"); t.skel[i].Thickness = 1; t.skel[i].Color = Color3.fromRGB(255,255,255); t.skel[i].Visible = false
    end
    espObjects[p] = t
end

local function updateEsp()
    for _, p in Players:GetPlayers() do
        if p == LP then continue end
        local isTeam = p.Team == LP.Team and p.Team ~= nil
        local showEnemy = flags.esp_on and not isTeam
        local showTeam  = flags["Enable Teammates ESP"] and isTeam
        local show = showEnemy or showTeam

        local t = espObjects[p]
        if show and not t then createEspFor(p); t = espObjects[p]
        elseif not show and t then removeEspFor(p); continue end
        if not t then continue end

        local char = getChar(p); local hum = getHum(char)
        local function hide()
            for k, d in t do
                if k == "skel" then for _, l in d do pcall(function() l.Visible = false end) end
                else pcall(function() d.Visible = false end) end
            end
        end
        if not char or not hum or hum.Health <= 0 then hide(); continue end
        local root = char:FindFirstChild("HumanoidRootPart"); if not root then hide(); continue end

        local topPos = root.Position + Vector3.new(0, 3.2, 0)
        local botPos = root.Position - Vector3.new(0, 3.2, 0)
        local topSc, topV = Camera:WorldToViewportPoint(topPos)
        local botSc, botV = Camera:WorldToViewportPoint(botPos)
        local onScreen = topV and botV

        if flags.esp_arrow and t.arrow then
            if not onScreen then
                local vp = Camera.ViewportSize
                local dir = (Camera.CFrame:PointToObjectSpace(root.Position))
                local ang = math.atan2(dir.X, dir.Z)
                local r = flags["Arrow Radius"] or 200
                local cx, cy = vp.X/2, vp.Y/2
                local ax, ay = cx + r * math.sin(ang), cy - r * math.cos(ang)
                local sz = 8
                t.arrow.PointA = Vector2.new(ax, ay - sz)
                t.arrow.PointB = Vector2.new(ax - sz/2, ay + sz/2)
                t.arrow.PointC = Vector2.new(ax + sz/2, ay + sz/2)
                t.arrow.Visible = true
            else t.arrow.Visible = false end
        elseif t.arrow then t.arrow.Visible = false end

        if not onScreen then hide(); if t.arrow then t.arrow.Visible = flags.esp_arrow or false end; continue end

        local myRoot = getChar(LP) and getChar(LP):FindFirstChild("HumanoidRootPart")
        local dist3d = myRoot and math.floor((myRoot.Position - root.Position).Magnitude) or 0
        local maxR = flags["Max Render Distance"] or 5000
        if dist3d > maxR then hide(); continue end

        local height = math.abs(topSc.Y - botSc.Y)
        local width  = height * 0.6
        local x, y  = topSc.X - width / 2, topSc.Y

        local boxOn = (showEnemy and flags.esp_box) or (isTeam and flags["Teammate Box"])
        if boxOn and t.box then
            t.box.Filled = flags.esp_fill or false; t.box.Size = Vector2.new(width, height)
            t.box.Position = Vector2.new(x, y); t.box.Visible = true
        elseif t.box then t.box.Visible = false end

        local nameOn = (showEnemy and flags.esp_name) or (isTeam and flags["Teammate Name"])
        if nameOn and t.name then
            t.name.Position = Vector2.new(topSc.X, y - 15); t.name.Visible = true
        elseif t.name then t.name.Visible = false end

        if flags.esp_distance and t.dist then
            t.dist.Text = dist3d.."m"; t.dist.Position = Vector2.new(topSc.X, y + height + 2); t.dist.Visible = true
        elseif t.dist then t.dist.Visible = false end

        local hpOn = (showEnemy and flags.esp_healthbar) or (isTeam and flags["Teammate Health Bar"])
        if hpOn and t.hpbg and t.hp then
            local ratio = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
            t.hpbg.Size = Vector2.new(4, height); t.hpbg.Position = Vector2.new(x - 6, y); t.hpbg.Visible = true
            t.hp.Size = Vector2.new(4, height * ratio); t.hp.Position = Vector2.new(x - 6, y + height * (1 - ratio))
            t.hp.Color = Color3.fromRGB(255*(1-ratio), 255*ratio, 0); t.hp.Visible = true
        elseif t.hpbg then t.hpbg.Visible = false; if t.hp then t.hp.Visible = false end end

        if flags.esp_hp_num and t.hpnum then
            t.hpnum.Text = math.floor(hum.Health)
            t.hpnum.Position = Vector2.new(x - 14, y + height/2 - 5); t.hpnum.Visible = true
        elseif t.hpnum then t.hpnum.Visible = false end

        if flags.esp_skeleton and t.skel then
            for i, pair in SKEL do
                local a = char:FindFirstChild(pair[1]); local b = char:FindFirstChild(pair[2])
                if not t.skel[i] then t.skel[i] = Drawing.new("Line"); t.skel[i].Thickness = flags.esp_skeleton_thickness or 1; t.skel[i].Color = Color3.fromRGB(255,255,255) end
                if a and b then
                    local sa, oa = Camera:WorldToViewportPoint(a.Position)
                    local sb, ob = Camera:WorldToViewportPoint(b.Position)
                    if oa and ob then
                        t.skel[i].From = Vector2.new(sa.X, sa.Y); t.skel[i].To = Vector2.new(sb.X, sb.Y); t.skel[i].Visible = true
                    else t.skel[i].Visible = false end
                else t.skel[i].Visible = false end
            end
        elseif t.skel then for _, l in t.skel do pcall(function() l.Visible = false end) end end

        if flags["Head Marker"] and t.headcirc then
            local head = char:FindFirstChild("Head")
            if head then
                local hs, hv = Camera:WorldToViewportPoint(head.Position)
                if hv then
                    t.headcirc.Position = Vector2.new(hs.X, hs.Y); t.headcirc.Radius = head.Size.X * 1.5
                    t.headcirc.Filled = flags["Head Marker Filled"] or false; t.headcirc.Visible = true
                end
            end
        elseif t.headcirc then t.headcirc.Visible = false end

        if flags["Enable Tracer"] and t.tracer then
            local vp = Camera.ViewportSize
            local orig = flags.esp_tracer_origin or "Bottom"
            local from = orig == "Center" and Vector2.new(vp.X/2, vp.Y/2)
                      or orig == "Top"    and Vector2.new(vp.X/2, 0)
                      or orig == "Mouse"  and UIS:GetMouseLocation()
                      or Vector2.new(vp.X/2, vp.Y)
            t.tracer.From = from; t.tracer.To = Vector2.new(topSc.X, y + height/2)
            t.tracer.Thickness = flags["Tracer Thickness"] or 1; t.tracer.Visible = true
        elseif t.tracer then t.tracer.Visible = false end
    end
end

-----------------------------------------------------------------------
-- CROSSHAIR
-----------------------------------------------------------------------
local chLines = { Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line") }
local chDot   = Drawing.new("Circle")
for _, l in chLines do l.Color = Color3.fromRGB(255,255,255); l.Visible = false end
chDot.Color = Color3.fromRGB(255,255,255); chDot.Visible = false; chDot.Filled = true

local function updateCrosshair()
    if not flags.crosshair_enabled then
        for _, l in chLines do l.Visible = false end; chDot.Visible = false; return
    end
    local vp = Camera.ViewportSize; local cx, cy = vp.X/2, vp.Y/2
    local len = flags.crosshair_length or 8; local gap = flags.crosshair_offset or 4
    local th  = flags.crosshair_thickness or 2; local col = Color3.fromRGB(255,255,255)
    chLines[1].From = Vector2.new(cx-len-gap, cy); chLines[1].To = Vector2.new(cx-gap, cy); chLines[1].Thickness = th; chLines[1].Color = col; chLines[1].Visible = true
    chLines[2].From = Vector2.new(cx+gap, cy);     chLines[2].To = Vector2.new(cx+len+gap, cy); chLines[2].Thickness = th; chLines[2].Color = col; chLines[2].Visible = true
    chLines[3].From = Vector2.new(cx, cy-len-gap); chLines[3].To = Vector2.new(cx, cy-gap);     chLines[3].Thickness = th; chLines[3].Color = col; chLines[3].Visible = true
    chLines[4].From = Vector2.new(cx, cy+gap);     chLines[4].To = Vector2.new(cx, cy+len+gap); chLines[4].Thickness = th; chLines[4].Color = col; chLines[4].Visible = true
    chDot.Position = Vector2.new(cx, cy); chDot.Radius = flags.crosshair_dot_size or 3
    chDot.Visible = flags.crosshair_center_dot or false
end

-----------------------------------------------------------------------
-- WATERMARK
-----------------------------------------------------------------------
local wmDraw = Drawing.new("Text")
wmDraw.Size = 14; wmDraw.Outline = true; wmDraw.Color = Color3.fromRGB(180,140,255); wmDraw.Text = "kami.dere | rivals"; wmDraw.Visible = true

-----------------------------------------------------------------------
-- HIT MARKER
-----------------------------------------------------------------------
local hmLines = { Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line") }
for _, l in hmLines do l.Color = Color3.fromRGB(255,60,60); l.Thickness = 2; l.Visible = false end
local hmTimer = 0

local function triggerHitmarker()
    if not flags.hud_hitmarker then return end
    hmTimer = (flags.hud_hm_life or 200) / 1000
end

-----------------------------------------------------------------------
-- LIGHTING
-----------------------------------------------------------------------
local function applyLighting()
    if flags.lighting_toggle_Brightness then Lighting.Brightness = flags.lighting_number_Brightness or 2 end
    if flags.lighting_toggle_ClockTime  then Lighting.ClockTime  = flags.lighting_number_ClockTime  or 14 end
    if flags.lighting_toggle_FogEnd then
        Lighting.FogEnd   = flags.lighting_number_FogEnd   or 100000
        Lighting.FogStart = flags.lighting_number_FogStart or 0
    end
    if flags.lighting_bool_GlobalShadows ~= nil then Lighting.GlobalShadows = flags.lighting_bool_GlobalShadows end
    if flags.lighting_toggle_ExposureCompensation then Lighting.ExposureCompensation = flags.lighting_number_ExposureCompensation or 0 end

    local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
    if flags.color_correction_enabled then
        cc = cc or Instance.new("ColorCorrectionEffect", Lighting)
        cc.Brightness = flags.color_correction_brightness or 0
        cc.Contrast   = flags.color_correction_contrast   or 0
        cc.Saturation = flags.color_correction_saturation or 0
    elseif cc then cc:Destroy() end

    local bl = Lighting:FindFirstChildOfClass("BloomEffect")
    if flags.bloom_enabled then
        bl = bl or Instance.new("BloomEffect", Lighting)
        bl.Intensity = flags.bloom_intensity or 1; bl.Size = flags.bloom_size or 24; bl.Threshold = flags.bloom_threshold or 1
    elseif bl then bl:Destroy() end

    local sr = Lighting:FindFirstChildOfClass("SunRaysEffect")
    if flags.sunrays_enabled then
        sr = sr or Instance.new("SunRaysEffect", Lighting)
        sr.Intensity = flags.sunrays_intensity or 0.5; sr.Spread = flags.sunrays_spread or 0.5
    elseif sr then sr:Destroy() end

    local atm = workspace:FindFirstChildOfClass("Atmosphere") or Lighting:FindFirstChildOfClass("Atmosphere")
    if flags.atmosphere_enabled and atm then
        atm.Density = flags.atmosphere_density or 0.3
        atm.Offset  = flags.atmosphere_offset  or 0
        atm.Haze    = flags.atmosphere_haze    or 0
        atm.Glare   = flags.atmosphere_glare   or 0
        atm.Decay   = flags.atmosphere_decay   or 0
    end
end

-----------------------------------------------------------------------
-- FLY
-----------------------------------------------------------------------
local flyPart = nil
local function startFly()
    local char = LP.Character; if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
    local hum  = getHum(char); if not hum then return end
    hum.PlatformStand = true
    flyPart = Instance.new("Part"); flyPart.Size = Vector3.new(1,1,1); flyPart.CFrame = root.CFrame
    flyPart.Transparency = 1; flyPart.Anchored = true; flyPart.CanCollide = false; flyPart.Parent = workspace
    root.CFrame = flyPart.CFrame
end
local function stopFly()
    local char = LP.Character; local hum = char and getHum(char)
    if hum then hum.PlatformStand = false end
    if flyPart then flyPart:Destroy(); flyPart = nil end
end

-----------------------------------------------------------------------
-- CONNECTIONS
-----------------------------------------------------------------------
Players.PlayerRemoving:Connect(removeEspFor)

-----------------------------------------------------------------------
-- TRIGGERBOT STATE
-----------------------------------------------------------------------
local tb_hold = 0; local tb_waiting = false

-----------------------------------------------------------------------
-- STEPPED
-----------------------------------------------------------------------
RunService.Stepped:Connect(function(_, dt)
    local char = getChar(LP)

    if flags.movement_noclip and char then
        for _, p in char:GetDescendants() do if p:IsA("BasePart") then p.CanCollide = false end end
    end

    if flags.movement_fly then
        if not flyPart then startFly() end
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root and flyPart then
            local spd = flags.movement_flyvalue or 30; local cf = Camera.CFrame; local dir = Vector3.new(0,0,0)
            if UIS:IsKeyDown(Enum.KeyCode.W)         then dir = dir + cf.LookVector  * spd * dt end
            if UIS:IsKeyDown(Enum.KeyCode.S)         then dir = dir - cf.LookVector  * spd * dt end
            if UIS:IsKeyDown(Enum.KeyCode.A)         then dir = dir - cf.RightVector * spd * dt end
            if UIS:IsKeyDown(Enum.KeyCode.D)         then dir = dir + cf.RightVector * spd * dt end
            if UIS:IsKeyDown(Enum.KeyCode.Space)     then dir = dir + Vector3.new(0, spd * dt * 0.5, 0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0, spd * dt * 0.5, 0) end
            flyPart.CFrame = flyPart.CFrame + dir; root.CFrame = flyPart.CFrame
        end
    else
        if flyPart then stopFly() end
    end

    if flags.movement_velocity and flags["Enable WalkSpeed Multiplier"] and char then
        local hum = getHum(char); if hum then hum.WalkSpeed = flags.movement_velocityvalue or 50 end
    end

    if flags["Zero Assembly Velocity"] and char then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0) end
    end

    if flags.anti_aim_enabled and char then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            if flags.anti_aim_yaw == "Spin" or flags.spinbot then
                root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(flags["Spinbot Yaw Speed"] or 10), 0)
            elseif flags.anti_aim_yaw == "Backwards" then
                root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.rad(180), 0)
            elseif flags.anti_aim_yaw == "Custom" then
                root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.rad(flags.anti_aim_custom_yaw or 0), 0)
            end
        end
    end
end)

-----------------------------------------------------------------------
-- RENDERSTEPPED
-----------------------------------------------------------------------
RunService.RenderStepped:Connect(function(dt)
    local visOnly  = flags.targeting_visibleonly
    local limDist  = flags.targeting_limitdistance
    local maxDist  = flags.targeting_maxdistance or 500
    local partName = flags.targeting_part or "Head"
    local prioMode = flags.ragebot_priority_targets or "Closest to Crosshair"

    if flags.ragebot_enabled then
        local target = getTarget(360, prioMode, visOnly, limDist, maxDist)
        if target then
            local part = getPart(target.char, partName)
            if part then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, part.Position)
                for i = 1, math.floor(flags.ragebot_shoot_attempts or 1) do
                    fire(); if i < (flags.ragebot_shoot_attempts or 1) then task.wait(0.03) end
                end
                if flags.ragebot_priority_notification then
                    library.notifications:create_notification({ name = "Ragebot", info = "Locking: "..target.player.Name, lifetime = 1 })
                end
                triggerHitmarker()
            end
        end
    end

    if flags.silent_toggle then
        local target = getTarget(flags.silent_radius or 180, prioMode, visOnly, limDist, maxDist)
        if target then
            local part = getPart(target.char, flags.silent_closest_part or "Head")
            if part and math.random(1, 100) <= (flags.silent_hitchance or 100) then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, part.Position)
            end
        end
    end

    if flags.aimbot_toggle then
        local target = getTarget(flags.aimbot_radius or 90, "Closest to Crosshair", visOnly, limDist, maxDist)
        if target then
            local part = getPart(target.char, flags.aimbot_closest_part or "Head")
            if part then
                local targetCF = CFrame.lookAt(Camera.CFrame.Position, part.Position)
                Camera.CFrame = Camera.CFrame:Lerp(targetCF, math.max(flags.aimbot_delay_smooth_x or 0.1, flags.aimbot_delay_smooth_y or 0.1))
            end
        end
    end

    if flags.triggerbot_enabled then
        local target = getTarget(50, "Closest to Crosshair", flags.tb_visibleonly, limDist, flags.triggerbot_max_distance or 100)
        if target then
            tb_hold = tb_hold + dt
            local reaction = ((flags.triggerbot_reaction_time or 100) + math.random(
                -(flags.triggerbot_reaction_time_offset or 0), math.max(0, flags.triggerbot_reaction_time_offset or 0)
            )) / 1000
            if tb_hold >= reaction and not tb_waiting then
                tb_waiting = true
                task.spawn(function()
                    task.wait((flags.triggerbot_shoot_delay or 0) / 1000)
                    fire(); triggerHitmarker(); tb_waiting = false; tb_hold = 0
                end)
            end
        else
            if tb_hold > (flags.triggerbot_forget_time or 0.5) then tb_hold = 0 end
        end
    end

    if flags.third_person_enabled then
        local root = getChar(LP) and getChar(LP):FindFirstChild("HumanoidRootPart")
        if root then Camera.CFrame = CFrame.new(root.Position + Vector3.new(0,3,-15), root.Position) end
    end

    if flags.camera_fov_changer then Camera.FieldOfView = flags.camera_fov_changer_amount or 70 end

    if hmTimer > 0 then
        hmTimer = hmTimer - dt
        local vp = Camera.ViewportSize; local cx, cy = vp.X/2, vp.Y/2; local hs = 8
        hmLines[1].From = Vector2.new(cx-hs, cy-hs); hmLines[1].To = Vector2.new(cx+hs, cy+hs); hmLines[1].Visible = true
        hmLines[2].From = Vector2.new(cx+hs, cy-hs); hmLines[2].To = Vector2.new(cx-hs, cy+hs); hmLines[2].Visible = true
        hmLines[3].From = Vector2.new(cx-hs, cy);    hmLines[3].To = Vector2.new(cx+hs, cy);    hmLines[3].Visible = flags["Hitmarker Dynamic Pulse"] or false
        hmLines[4].From = Vector2.new(cx, cy-hs);    hmLines[4].To = Vector2.new(cx, cy+hs);    hmLines[4].Visible = flags["Hitmarker Dynamic Pulse"] or false
    else
        for _, l in hmLines do l.Visible = false end
    end

    if flags.hud_watermark then
        wmDraw.Position = Vector2.new(Camera.ViewportSize.X - 155, 8); wmDraw.Visible = true
    else wmDraw.Visible = false end

    updateEsp()
    updateCrosshair()
    applyLighting()
end)
