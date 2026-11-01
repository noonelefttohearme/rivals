-- kami rivals — mirrors Unnamed Enhancements feature set

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
-- RAGEBOT
-----------------------------------------------------------------------
local rb_main, rb_settings = window:tab({
    name = "Ragebot", icon = ICO.aim, tabs = { "Main", "Settings" },
})

do
    local col = rb_main:column({})
    local sec = col:section({ name = "Ragebot", size = 1, icon = ICO.aim, default = true })
    sec:toggle({  name = "Enabled",                   flag = "ragebot_enabled",              default = false })
    sec:keybind({ name = "Keybind",                   flag = "ragebot_keybind",              key = nil, mode = "Toggle" })
    sec:dropdown({name = "Mode",                      flag = "ragebot_mode",                 items = { "gun", "melee" }, default = "gun" })
    sec:toggle({  name = "Priority",                  flag = "ragebot_priority",             default = false })
    sec:toggle({  name = "Priority Notification",     flag = "ragebot_priority_notification",default = false })
    sec:slider({  name = "Shoot Attempts",            flag = "ragebot_shoot_attempts",       min = 1, max = 20, default = 1, interval = 1 })
    sec:toggle({  name = "Void Spam",                 flag = "ragebot_void_spam",            default = false })
    sec:slider({  name = "Void Spam Attack",          flag = "ragebot_void_spam_attack",     min = 0, max = 1, default = 0.1, interval = 0.01 })
    sec:slider({  name = "Void Spam Hide",            flag = "ragebot_void_spam_hide",       min = 0, max = 1, default = 0.2, interval = 0.01 })
    sec:toggle({  name = "Bait",                      flag = "ragebot_bait",                 default = false })
end

do
    local col = rb_settings:column({})
    local sec = col:section({ name = "Targeting", size = 1, icon = ICO.aim, default = true })
    sec:dropdown({name = "Priority Targets",          flag = "ragebot_priority_targets",     items = { "Closest to Crosshair", "Lowest HP", "Nearest" }, default = "Closest to Crosshair" })
    sec:toggle({  name = "Visible Only",              flag = "targeting_visibleonly",        default = false })
    sec:toggle({  name = "Limit Distance",            flag = "targeting_limitdistance",      default = false })
    sec:slider({  name = "Max Distance",              flag = "targeting_maxdistance",        min = 0, max = 1000, default = 500, interval = 1 })
    sec:dropdown({name = "Target Part",               flag = "targeting_part",               items = { "Head", "Torso", "HumanoidRootPart", "Nearest" }, default = "Head" })
    sec:toggle({  name = "Disable Flash",             flag = "targeting_disableflash",       default = false })
    sec:toggle({  name = "Ignore Protected",          flag = "targeting_ignore_protected",   default = false })
    sec:toggle({  name = "No Delay Between Targets",  flag = "no delay between targets",     default = false })
    sec:toggle({  name = "Prefer Projectile Weapon",  flag = "prefer projectile weapon",     default = false })
    sec:dropdown({name = "Part Blacklist",            flag = "targeting_closest_part_blacklist", items = { "None", "Arms", "Legs" }, default = "None" })

    local sec2 = col:section({ name = "Target Highlight", size = 1, icon = ICO.aim, default = false })
    sec2:toggle({ name = "Enabled",                   flag = "target_highlight",             default = false })
    sec2:toggle({ name = "Fill",                      flag = "target_highlight_fill",        default = false })
    sec2:toggle({ name = "Outline",                   flag = "target_highlight_outline",     default = true  })
    sec2:dropdown({name = "Type",                     flag = "target_highlight_type",        items = { "Box", "Circle", "Highlight" }, default = "Box" })

    local sec3 = col:section({ name = "Hit Notify", size = 1, icon = ICO.aim, default = false })
    sec3:toggle({ name = "Enabled",                   flag = "target_hit_notify",            default = false })
    sec3:slider({ name = "Duration",                  flag = "target_hit_notify_duration",   min = 0.5, max = 5, default = 1, interval = 0.5, suffix = "s" })
    sec3:dropdown({name = "Text",                     flag = "target_hit_notify_text",       items = { "Hit!", "damage ratio", "fortnite damage" }, default = "Hit!" })
end

-----------------------------------------------------------------------
-- SILENT AIM
-----------------------------------------------------------------------
local sa_main = window:tab({
    name = "Silent Aim", icon = ICO.aim, tabs = { "Main" },
})

do
    local col = sa_main:column({})
    local sec = col:section({ name = "Silent Aim", size = 1, icon = ICO.aim, default = true })
    sec:toggle({  name = "Enabled",                   flag = "silent_toggle",                default = false })
    sec:keybind({ name = "Keybind",                   flag = "silent_keybind",               key = nil, mode = "Toggle" })
    sec:slider({  name = "Hitchance",                 flag = "silent_hitchance",             min = 1, max = 100, default = 100, interval = 1, suffix = "%" })
    sec:toggle({  name = "Manipulation",              flag = "silent_manipulation",          default = false })
    sec:toggle({  name = "Visualize FOV",             flag = "silent_visualize",             default = false })
    sec:toggle({  name = "Show FOV",                  flag = "silent_showfov",               default = false })
    sec:slider({  name = "FOV",                       flag = "silent_radius",                min = 0, max = 360, default = 180, interval = 1, suffix = "°" })
    sec:dropdown({name = "Closest Part",              flag = "silent_closest_part",          items = { "Head", "Torso", "Nearest" }, default = "Head" })
    sec:toggle({  name = "FOV Fill",                  flag = "silent_fov_fill",              default = false })
    sec:toggle({  name = "FOV Moving",                flag = "silent_fov_moving",            default = false })
    sec:toggle({  name = "FOV Outline",               flag = "silent_fov_outline",           default = true  })
    sec:toggle({  name = "FOV Lerp",                  flag = "silent_fov_lerp",              default = true  })
    sec:slider({  name = "FOV Rotation Speed",        flag = "silent_fov_rotation_speed",    min = 0, max = 10, default = 0, interval = 0.1 })
end

-----------------------------------------------------------------------
-- AIMBOT
-----------------------------------------------------------------------
local ab_main = window:tab({
    name = "Aimbot", icon = ICO.aim, tabs = { "Main" },
})

do
    local col = ab_main:column({})
    local sec = col:section({ name = "Aimbot", size = 1, icon = ICO.aim, default = true })
    sec:toggle({  name = "Enabled",                   flag = "aimbot_toggle",                default = false })
    sec:keybind({ name = "Keybind",                   flag = "aimbot_keybind",               key = nil, mode = "Hold" })
    sec:slider({  name = "FOV",                       flag = "aimbot_radius",                min = 0, max = 360, default = 90, interval = 1, suffix = "°" })
    sec:slider({  name = "Smoothing X",               flag = "aimbot_delay_smooth_x",        min = 0, max = 1, default = 0.1, interval = 0.01 })
    sec:slider({  name = "Smoothing Y",               flag = "aimbot_delay_smooth_y",        min = 0, max = 1, default = 0.1, interval = 0.01 })
    sec:toggle({  name = "Smoothing",                 flag = "aimbot_smoothing",             default = true  })
    sec:toggle({  name = "Show FOV",                  flag = "aimbot_showfov",               default = false })
    sec:toggle({  name = "Match Axis",                flag = "aimbot_match_axis",            default = false })
    sec:dropdown({name = "Closest Part",              flag = "aimbot_closest_part",          items = { "Head", "Torso", "Nearest" }, default = "Head" })
    sec:toggle({  name = "Delay Position",            flag = "aimbot_delay_position",        default = false })
    sec:toggle({  name = "Delay Smooth Jump",         flag = "aimbot_delay_smooth_jump",     default = false })
    sec:toggle({  name = "FOV Fill",                  flag = "aimbot_fov_fill",              default = false })
    sec:toggle({  name = "FOV Moving",                flag = "aimbot_fov_moving",            default = false })
    sec:toggle({  name = "FOV Outline",               flag = "aimbot_fov_outline",           default = true  })
    sec:toggle({  name = "FOV Lerp",                  flag = "aimbot_fov_lerp",              default = true  })
    sec:slider({  name = "FOV Rotation Speed",        flag = "aimbot_fov_rotation_speed",    min = 0, max = 10, default = 0, interval = 0.1 })
end

-----------------------------------------------------------------------
-- TRIGGERBOT
-----------------------------------------------------------------------
local tb_tab, tb_settings_tab = window:tab({
    name = "Triggerbot", icon = ICO.aim, tabs = { "Main", "Settings" },
})

do
    local col = tb_tab:column({})
    local sec = col:section({ name = "Triggerbot", size = 1, icon = ICO.aim, default = true })
    sec:toggle({  name = "Enabled",                   flag = "triggerbot_enabled",           default = false })
    sec:keybind({ name = "Keybind",                   flag = "triggerbot_keybind",           key = nil, mode = "Toggle" })
    sec:slider({  name = "Forget Time",               flag = "triggerbot_forget_time",       min = 0, max = 3, default = 0.5, interval = 0.01, suffix = "s" })
    sec:slider({  name = "Max Distance",              flag = "triggerbot_max_distance",      min = 0, max = 500, default = 100, interval = 1 })
    sec:slider({  name = "Reaction Time",             flag = "triggerbot_reaction_time",     min = 0, max = 500, default = 100, interval = 1, suffix = "ms" })
    sec:slider({  name = "Reaction Time Offset",      flag = "triggerbot_reaction_time_offset", min = 0, max = 200, default = 0, interval = 1, suffix = "ms" })
    sec:slider({  name = "Shoot Delay",               flag = "triggerbot_shoot_delay",       min = 0, max = 500, default = 0, interval = 1, suffix = "ms" })
    sec:toggle({  name = "Scoped Only",               flag = "triggerbot_scoped",            default = false })
    sec:dropdown({name = "Part Blacklist",            flag = "triggerbot_part_blacklist",    items = { "None", "Legs", "Arms" }, default = "None" })
end

do
    local col = tb_settings_tab:column({})
    local sec = col:section({ name = "Targeting", size = 1, icon = ICO.aim, default = true })
    sec:toggle({  name = "Visible Only",              flag = "tb_visibleonly",               default = false })
    sec:toggle({  name = "Ignore Protected",          flag = "tb_ignore_protected",          default = false })
end

-----------------------------------------------------------------------
-- ESP  (Player · World · Chams · Effects)
-----------------------------------------------------------------------
local esp_player, esp_world, esp_chams, esp_effects = window:tab({
    name = "ESP", icon = ICO.esp,
    tabs = { "Player", "World", "Chams", "Effects" },
})

-- Player ESP
do
    local col = esp_player:column({})
    local sec = col:section({ name = "Player ESP", size = 1, icon = ICO.esp, default = true })
    sec:toggle({ name = "Box",                        flag = "esp_box",                      default = false })
    sec:toggle({ name = "Box Moving",                 flag = "esp_box_moving",               default = false })
    sec:toggle({ name = "Fill",                       flag = "esp_fill",                     default = false })
    sec:toggle({ name = "Fill Moving",                flag = "esp_fill_moving",              default = false })
    sec:toggle({ name = "Name",                       flag = "esp_name",                     default = false })
    sec:dropdown({name = "Name Type",                 flag = "esp_name_type",                items = { "Username", "Display Name", "Both" }, default = "Username" })
    sec:toggle({ name = "Distance",                   flag = "esp_distance",                 default = false })
    sec:toggle({ name = "Weapon",                     flag = "esp_weapon",                   default = false })
    sec:toggle({ name = "Health Bar",                 flag = "esp_healthbar",                default = false })
    sec:toggle({ name = "Health Lerp",                flag = "esp_healthbar_health_lerp",    default = true  })
    sec:dropdown({name = "Health Bar Type",           flag = "esp_healthbar_type",           items = { "Vertical Left", "Vertical Right", "Horizontal Top", "Horizontal Bottom" }, default = "Vertical Left" })
    sec:slider({ name = "Health Bar Slices",          flag = "esp_healthbar_slices",         min = 1, max = 20, default = 1, interval = 1 })
    sec:toggle({ name = "Skeleton",                   flag = "esp_skeleton",                 default = false })
    sec:slider({ name = "Skeleton Thickness",         flag = "esp_skeleton_thickness",       min = 1, max = 5, default = 1, interval = 1 })
    sec:toggle({ name = "Skeleton Outline",           flag = "esp_skeleton_outline",         default = false })
    sec:toggle({ name = "Show Team",                  flag = "esp_show_team",                default = false })
    sec:dropdown({name = "Font",                      flag = "esp_font",                     items = { "Default", "Monospace", "Proggy Tiny" }, default = "Default" })
    sec:dropdown({name = "Bounds Type",               flag = "esp_bounds_type",              items = { "Box", "Body" }, default = "Box" })
    sec:toggle({ name = "Override Appearance",        flag = "esp_override_appearance",      default = false })
    sec:dropdown({name = "Material",                  flag = "esp_material_value",           items = { "Neon", "Plastic", "SmoothPlastic", "ForceField" }, default = "Neon" })
    sec:toggle({ name = "Body Color",                 flag = "esp_body_color",               default = false })
    sec:slider({ name = "Body Transparency",          flag = "esp_body_transparency",        min = 0, max = 1, default = 0.5, interval = 0.01 })
end

-- World ESP
do
    local col = esp_world:column({})
    local sec = col:section({ name = "World ESP", size = 1, icon = ICO.esp, default = true })
    sec:toggle({ name = "Name",                       flag = "esp_world_name",               default = false })
    sec:toggle({ name = "Distance",                   flag = "esp_world_distance",           default = false })
    sec:toggle({ name = "Image",                      flag = "esp_world_image",              default = false })
    sec:slider({ name = "Object Scale",               flag = "esp_world_object_scale",       min = 0.1, max = 5, default = 1, interval = 0.1 })
    sec:slider({ name = "Lerp Speed",                 flag = "esp_world_lerp_speed",         min = 0, max = 1, default = 0.1, interval = 0.01 })
    sec:dropdown({name = "Font",                      flag = "esp_world_font",               items = { "Default", "Monospace" }, default = "Default" })
    sec:dropdown({name = "Whitelist",                 flag = "esp_world_whitelist",          items = { "All", "Enemies", "Team" }, default = "All" })

    local sec2 = col:section({ name = "Target Tracer", size = 1, icon = ICO.esp, default = false })
    sec2:toggle({ name = "Enabled",                   flag = "target_tracer",                default = false })
    sec2:toggle({ name = "Customization",             flag = "target_tracer_customization",  default = false })

    local sec3 = col:section({ name = "Target UI", size = 1, icon = ICO.esp, default = false })
    sec3:toggle({ name = "Enabled",                   flag = "target_ui_enabled",            default = false })
    sec3:toggle({ name = "Show Targets",              flag = "target_ui_show_targets",       default = true  })
    sec3:slider({ name = "Item Scale",                flag = "target_ui_item_scale",         min = 0.5, max = 3, default = 1, interval = 0.1 })
    sec3:slider({ name = "Position X",               flag = "target_ui_position_x",         min = 0, max = 1, default = 0.5, interval = 0.01 })
    sec3:slider({ name = "Position Y",               flag = "target_ui_position_y",         min = 0, max = 1, default = 0.5, interval = 0.01 })
end

-- Chams
do
    local col = esp_chams:column({})
    local sec = col:section({ name = "Player Chams", size = 1, icon = ICO.esp, default = true })
    sec:toggle({ name = "Enabled",                    flag = "esp_chams",                    default = false })
    sec:slider({ name = "Fill Alpha",                 flag = "esp_chams_alpha_fill",         min = 0, max = 1, default = 0.5, interval = 0.01 })
    sec:slider({ name = "Outline Alpha",              flag = "esp_chams_alpha_outline",      min = 0, max = 1, default = 1, interval = 0.01 })

    local sec2 = col:section({ name = "Viewmodel Chams", size = 1, icon = ICO.esp, default = false })
    sec2:toggle({ name = "Enabled",                   flag = "viewmodel_chams",              default = false })
    sec2:slider({ name = "Fill Alpha",                flag = "viewmodel_chams_alpha_fill",   min = 0, max = 1, default = 0.5, interval = 0.01 })
    sec2:slider({ name = "Outline Alpha",             flag = "viewmodel_chams_alpha_outline",min = 0, max = 1, default = 1, interval = 0.01 })
    sec2:toggle({ name = "Disable Textures",          flag = "viewmodel_disable_textures",   default = false })
    sec2:toggle({ name = "Recoil",                    flag = "viewmodel_recoil",             default = false })
    sec2:toggle({ name = "Wireframe",                 flag = "viewmodel_wireframe",          default = false })
    sec2:dropdown({name = "Material",                 flag = "viewmodel_material_value",     items = { "Neon", "Plastic", "SmoothPlastic", "ForceField" }, default = "Neon" })
    sec2:slider({ name = "Offset X",                  flag = "viewmodel_offset_x",           min = -2, max = 2, default = 0, interval = 0.01 })
    sec2:slider({ name = "Offset Y",                  flag = "viewmodel_offset_y",           min = -2, max = 2, default = 0, interval = 0.01 })
    sec2:slider({ name = "Offset Z",                  flag = "viewmodel_offset_z",           min = -2, max = 2, default = 0, interval = 0.01 })
end

-- Effects
do
    local col = esp_effects:column({})
    local sec = col:section({ name = "Aura", size = 1, icon = ICO.esp, default = false })
    sec:toggle({ name = "Enabled",                    flag = "esp_effects_aura",             default = false })
    sec:slider({ name = "Value",                      flag = "esp_effects_aura_value",       min = 0, max = 10, default = 1, interval = 0.1 })

    local sec2 = col:section({ name = "Particle", size = 1, icon = ICO.esp, default = false })
    sec2:toggle({ name = "Enabled",                   flag = "esp_effects_particle",         default = false })
    sec2:slider({ name = "Value",                     flag = "esp_effects_particle_value",   min = 0, max = 10, default = 1, interval = 0.1 })

    local sec3 = col:section({ name = "Hit Effects", size = 1, icon = ICO.esp, default = true })
    sec3:toggle({ name = "Enabled",                   flag = "hit_effects_enabled",          default = false })
    sec3:toggle({ name = "Disable Marker",            flag = "hit_effects_disable_marker",   default = false })
    sec3:toggle({ name = "Disable Numbers",           flag = "hit_effects_disable_numbers",  default = false })
    sec3:toggle({ name = "Weld",                      flag = "hit_effects_weld",             default = false })
    sec3:dropdown({name = "Selected",                 flag = "hit_effects_selected",         items = { "Default", "Spark", "Explosion", "Custom" }, default = "Default" })
    sec3:dropdown({name = "Material",                 flag = "hit_effects_material",         items = { "Neon", "Plastic", "SmoothPlastic" }, default = "Neon" })

    local sec4 = col:section({ name = "Hit Sounds", size = 1, icon = ICO.esp, default = false })
    sec4:toggle({ name = "Enabled",                   flag = "hit_sounds_enabled",           default = false })
    sec4:toggle({ name = "Disable Default",           flag = "hit_sounds_disable",           default = false })
    sec4:dropdown({name = "Selected",                 flag = "hit_sounds_selected",          items = { "Default", "Skeet", "Punch", "Custom" }, default = "Default" })
    sec4:slider({ name = "Volume",                    flag = "hit_sounds_volume",            min = 0, max = 1, default = 0.5, interval = 0.05 })
end

-----------------------------------------------------------------------
-- MOVEMENT
-----------------------------------------------------------------------
local mv_main, mv_advanced = window:tab({
    name = "Movement", icon = ICO.movement,
    tabs = { "Main", "Advanced" },
})

do
    local col = mv_main:column({})
    local sec = col:section({ name = "Movement", size = 1, icon = ICO.movement, default = true })
    sec:toggle({  name = "Fly",                       flag = "movement_fly",                 default = false })
    sec:keybind({ name = "Fly Keybind",               flag = "movement_flykeybind",          key = nil, mode = "Toggle" })
    sec:slider({  name = "Fly Speed",                 flag = "movement_flyvalue",            min = 1, max = 200, default = 30, interval = 1 })
    sec:toggle({  name = "Noclip",                    flag = "movement_noclip",              default = false })
    sec:keybind({ name = "Noclip Keybind",            flag = "movement_noclipkeybind",       key = nil, mode = "Toggle" })
    sec:toggle({  name = "Velocity",                  flag = "movement_velocity",            default = false })
    sec:keybind({ name = "Velocity Keybind",          flag = "movement_velocitykeybind",     key = nil, mode = "Toggle" })
    sec:slider({  name = "Velocity Value",            flag = "movement_velocityvalue",       min = 1, max = 200, default = 50, interval = 1 })
    sec:toggle({  name = "Slide Boost",               flag = "movement_slideboost",          default = false })
    sec:slider({  name = "Slide Boost Value",         flag = "movement_slideboostvalue",     min = 1, max = 100, default = 30, interval = 1 })
    sec:toggle({  name = "Infinite Double Jump",      flag = "movement_infinite_double_jump",default = false })
    sec:slider({  name = "Double Jump Height",        flag = "movement_double_jump_height",  min = 1, max = 10, default = 1, interval = 0.1 })
    sec:slider({  name = "Height Multiplier",         flag = "movement_double_jump_height_multiplier", min = 1, max = 5, default = 1, interval = 0.1 })
end

do
    local col = mv_advanced:column({})
    local sec = col:section({ name = "Anti-Aim", size = 1, icon = ICO.movement, default = true })
    sec:toggle({  name = "Enabled",                   flag = "anti_aim_enabled",             default = false })
    sec:dropdown({name = "Pitch",                     flag = "anti_aim_pitch",               items = { "None", "Down", "Up", "Zero", "Custom" }, default = "None" })
    sec:slider({  name = "Custom Pitch",              flag = "anti_aim_custom_pitch",        min = -90, max = 90, default = 0, interval = 1, suffix = "°" })
    sec:dropdown({name = "Yaw",                       flag = "anti_aim_yaw",                 items = { "None", "Spin", "Jitter", "Backwards", "Side", "Custom" }, default = "None" })
    sec:slider({  name = "Custom Yaw",                flag = "anti_aim_custom_yaw",          min = -180, max = 180, default = 0, interval = 1, suffix = "°" })
    sec:toggle({  name = "Floor Hide",                flag = "anti_aim_floor_hide",          default = false })
    sec:keybind({ name = "Floor Hide Keybind",        flag = "anti_aim_floor_hide_keybind",  key = nil, mode = "Hold" })
end

-----------------------------------------------------------------------
-- MISC
-----------------------------------------------------------------------
local misc_main, misc_exploits, misc_automate, misc_cosmetics = window:tab({
    name = "Misc", icon = ICO.misc,
    tabs = { "Main", "Exploits", "Automate", "Cosmetics" },
})

do
    local col = misc_main:column({})
    local sec = col:section({ name = "Player", size = 1, icon = ICO.misc, default = true })
    sec:toggle({ name = "Name Spoofer",               flag = "name_spoofer",                 default = false })
    sec:toggle({ name = "Remove Vignette",            flag = "item_remove_vignette",         default = false, callback = function(v)
        pcall(function()
            for _, g in LP.PlayerGui:GetDescendants() do
                if g:IsA("ImageLabel") and g.Image:find("vignette") then g.Visible = not v end
            end
        end)
    end })
    sec:toggle({ name = "Item Status",                flag = "item_status_enabled",          default = false })
    sec:toggle({ name = "Item Status Override",       flag = "item_status_override",         default = false })
    sec:toggle({ name = "Loadout",                    flag = "loadout",                      default = false })
    sec:toggle({ name = "Unrestricted Loadout",       flag = "loadout_unrestricted",         default = false })
    sec:toggle({ name = "Chat Spam",                  flag = "chat_spam_enabled",            default = false })
    sec:dropdown({name = "Spam Mode",                 flag = "chat_spam_mode",               items = { "Repeat", "Sequential", "Random" }, default = "Repeat" })
    sec:toggle({ name = "Anti-Katana",                flag = "anti katana",                  default = false })
    sec:toggle({ name = "Camera Anti Flashbang",      flag = "camera_anti_flashbang",        default = false })
    sec:toggle({ name = "Camera Blur",                flag = "camera_blur",                  default = false })
    sec:toggle({ name = "Camera Aspect Ratio",        flag = "camera_aspect_ratio",          default = false })
    sec:slider({ name = "Aspect Ratio X",             flag = "camera_aspect_ratio_x",        min = 1, max = 32, default = 16, interval = 1 })
    sec:slider({ name = "Aspect Ratio Y",             flag = "camera_aspect_ratio_y",        min = 1, max = 32, default = 9, interval = 1 })
    sec:toggle({ name = "FOV Changer",                flag = "camera_fov_changer",           default = false, callback = function(v)
        Camera.FieldOfView = v and (library.flags.camera_fov_changer_amount or 70) or 70
    end })
    sec:slider({ name = "FOV Amount",                 flag = "camera_fov_changer_amount",    min = 50, max = 120, default = 70, interval = 1, callback = function(v)
        if library.flags.camera_fov_changer then Camera.FieldOfView = v end
    end })

    local sec2 = col:section({ name = "Third Person", size = 1, icon = ICO.misc, default = false })
    sec2:toggle({ name = "Enabled",                   flag = "third_person_enabled",         default = false })
    sec2:keybind({name = "Keybind",                   flag = "third_person_keybind",         key = nil, mode = "Toggle" })
end

do
    local col = misc_exploits:column({})
    local sec = col:section({ name = "Exploits", size = 1, icon = ICO.misc, default = true })
    sec:toggle({ name = "Full Auto",                  flag = "exploits_full_auto",           default = false })
    sec:slider({ name = "Fire Rate",                  flag = "exploits_firerate",            min = 1, max = 20, default = 5, interval = 1 })
    sec:toggle({ name = "No Spread",                  flag = "exploits_no_spread",           default = false })
    sec:toggle({ name = "Always Backstab",            flag = "exploits_always_backstab",     default = false })

    local sec2 = col:section({ name = "Animation", size = 1, icon = ICO.misc, default = false })
    sec2:toggle({ name = "Animation Player",          flag = "animation_player_enabled",     default = false })
    sec2:keybind({name = "Keybind",                   flag = "animation_player_keybind",     key = nil, mode = "Hold" })
    sec2:slider({ name = "Speed",                     flag = "animation_player_speed",       min = 0.1, max = 5, default = 1, interval = 0.1 })
    sec2:slider({ name = "Start Position",            flag = "animation_player_start_position", min = 0, max = 1, default = 0, interval = 0.01 })
    sec2:slider({ name = "End Position",              flag = "animation_player_end_position",   min = 0, max = 1, default = 1, interval = 0.01 })

    local sec3 = col:section({ name = "Shoot Sound", size = 1, icon = ICO.misc, default = false })
    sec3:toggle({ name = "Change Shoot Sound",        flag = "shoot_sound_change",           default = false })
    sec3:slider({ name = "Speed",                     flag = "shoot_sound_speed",            min = 0.1, max = 5, default = 1, interval = 0.1 })
    sec3:slider({ name = "Start",                     flag = "shoot_sound_start",            min = 0, max = 10, default = 0, interval = 0.1, suffix = "s" })
    sec3:slider({ name = "Volume",                    flag = "shoot_sound_volume",           min = 0, max = 1, default = 0.5, interval = 0.05 })
end

do
    local col = misc_automate:column({})
    local sec = col:section({ name = "Auto Queue", size = 1, icon = ICO.misc, default = true })
    sec:toggle({ name = "Enabled",                    flag = "auto_queue_enabled",           default = false })
    sec:dropdown({name = "Mode",                      flag = "auto_queue_mode",              items = { "Any", "Competitive", "Casual" }, default = "Any" })
    sec:toggle({ name = "Auto Select Enabled",        flag = "auto_select_enabled",          default = false })
    sec:dropdown({name = "Primary",                   flag = "auto_select_Primary",          items = { "None", "Assault Rifle", "Sniper", "Bow", "Crossbow" }, default = "None" })
    sec:dropdown({name = "Secondary",                 flag = "auto_select_Secondary",        items = { "None", "Daggers", "Katana", "Riot Shield" }, default = "None" })
    sec:dropdown({name = "Melee",                     flag = "auto_select_Melee",            items = { "None", "Katana", "Daggers" }, default = "None" })
    sec:dropdown({name = "Utility",                   flag = "auto_select_Utility",          items = { "None", "Grenade", "Smoke Grenade", "Molotov", "Flashbang", "Satchel", "Subspace Tripmine" }, default = "None" })

    local sec2 = col:section({ name = "Auto Ban", size = 1, icon = ICO.misc, default = false })
    sec2:toggle({ name = "Enabled",                   flag = "autoban",                      default = false })
    sec2:toggle({ name = "First",                     flag = "autoban_first",                default = false })
    sec2:slider({ name = "First Delay",               flag = "autoban_first_delay",          min = 0, max = 10, default = 0.5, interval = 0.1, suffix = "s" })
    sec2:toggle({ name = "Second",                    flag = "autoban_second",               default = false })
    sec2:slider({ name = "Second Delay",              flag = "autoban_second_delay",         min = 0, max = 10, default = 1, interval = 0.1, suffix = "s" })
    sec2:slider({ name = "Map Delay",                 flag = "autoban_map_delay",            min = 0, max = 30, default = 5, interval = 0.5, suffix = "s" })
end

do
    local col = misc_cosmetics:column({})
    local sec = col:section({ name = "Arm Appearance", size = 1, icon = ICO.misc, default = true })
    sec:toggle({ name = "Override Appearance",        flag = "arm_override_appearance",      default = false })
    sec:toggle({ name = "Disable Textures",           flag = "arm_disable_textures",         default = false })
    sec:toggle({ name = "Body Color",                 flag = "arm_body_color",               default = false })
    sec:slider({ name = "Body Transparency",          flag = "arm_body_transparency",        min = 0, max = 1, default = 0, interval = 0.01 })
    sec:dropdown({name = "Material",                  flag = "arm_material_value",           items = { "Neon", "Plastic", "SmoothPlastic", "ForceField" }, default = "Plastic" })
end

-----------------------------------------------------------------------
-- VISUALS  (Crosshair · Indicator · Lighting · World)
-----------------------------------------------------------------------
local vis_crosshair, vis_indicator, vis_lighting, vis_world = window:tab({
    name = "Visuals", icon = ICO.visuals,
    tabs = { "Crosshair", "Indicator", "Lighting", "World" },
})

-- Crosshair
do
    local col = vis_crosshair:column({})
    local sec = col:section({ name = "Crosshair", size = 1, icon = ICO.visuals, default = true })
    sec:toggle({ name = "Enabled",                    flag = "crosshair_enabled",            default = false })
    sec:toggle({ name = "Disable Game Crosshair",     flag = "crosshair_disable_game",       default = false })
    sec:slider({ name = "Length",                     flag = "crosshair_length",             min = 1, max = 30, default = 8, interval = 1 })
    sec:slider({ name = "Thickness",                  flag = "crosshair_thickness",          min = 1, max = 5, default = 2, interval = 1 })
    sec:slider({ name = "Offset (Gap)",               flag = "crosshair_offset",             min = 0, max = 20, default = 4, interval = 1 })
    sec:toggle({ name = "Outline",                    flag = "crosshair_outline",            default = false })
    sec:toggle({ name = "Bounce",                     flag = "crosshair_bounce",             default = false })
    sec:slider({ name = "Bounce Speed",               flag = "crosshair_bounce_speed",       min = 0.1, max = 5, default = 1, interval = 0.1 })
    sec:toggle({ name = "Lerp",                       flag = "crosshair_lerp",               default = true  })
    sec:toggle({ name = "Rotation",                   flag = "crosshair_rotation",           default = false })
    sec:slider({ name = "Rotation Speed",             flag = "crosshair_rotation_speed",     min = 0.1, max = 10, default = 1, interval = 0.1 })
end

-- Indicator
do
    local col = vis_indicator:column({})
    local sec = col:section({ name = "Ammo Indicator", size = 1, icon = ICO.visuals, default = true })
    sec:toggle({ name = "Ammo",                       flag = "indicator_ammo",               default = false })
    sec:dropdown({name = "Ammo Style",                flag = "indicator_ammo_style",         items = { "Bar", "Number", "Both" }, default = "Bar" })
    sec:toggle({ name = "Lerp",                       flag = "indicator_lerp",               default = true  })
    sec:slider({ name = "Offset X",                   flag = "indicator_offset_x",           min = -200, max = 200, default = 0, interval = 1 })
    sec:slider({ name = "Offset Y",                   flag = "indicator_offset_y",           min = -200, max = 200, default = 0, interval = 1 })
    sec:dropdown({name = "Font",                      flag = "indicator_font",               items = { "Default", "Monospace", "Proggy Tiny" }, default = "Default" })
    sec:dropdown({name = "Text Style",                flag = "indicator_text_style",         items = { "Normal", "Bold", "Italic" }, default = "Normal" })

    local sec2 = col:section({ name = "Ragebot Indicator", size = 1, icon = ICO.visuals, default = false })
    sec2:toggle({ name = "Enabled",                   flag = "indicator_ragebot",            default = false })
    sec2:dropdown({name = "Style",                    flag = "indicator_ragebot_style",      items = { "Text", "Icon", "Both" }, default = "Text" })
    sec2:toggle({ name = "Manipulated",               flag = "indicator_manipulated",        default = false })
end

-- Lighting
do
    local col = vis_lighting:column({})
    local sec = col:section({ name = "Lighting", size = 1, icon = ICO.visuals, default = true })
    sec:toggle({ name = "Ambient",                    flag = "lighting_toggle_Ambient",      default = false })
    sec:toggle({ name = "Brightness",                 flag = "lighting_toggle_Brightness",   default = false, callback = function(v)
        if v then Lighting.Brightness = library.flags.lighting_number_Brightness or 2 end
    end })
    sec:slider({ name = "Brightness Value",           flag = "lighting_number_Brightness",   min = 0, max = 10, default = 2, interval = 0.1, callback = function(v)
        if library.flags.lighting_toggle_Brightness then Lighting.Brightness = v end
    end })
    sec:toggle({ name = "Clock Time",                 flag = "lighting_toggle_ClockTime",    default = false, callback = function(v)
        if v then Lighting.ClockTime = library.flags.lighting_number_ClockTime or 14 end
    end })
    sec:slider({ name = "Clock Time Value",           flag = "lighting_number_ClockTime",    min = 0, max = 24, default = 14, interval = 0.1, callback = function(v)
        if library.flags.lighting_toggle_ClockTime then Lighting.ClockTime = v end
    end })
    sec:toggle({ name = "Fog End",                    flag = "lighting_toggle_FogEnd",       default = false, callback = function(v)
        if v then Lighting.FogEnd = library.flags.lighting_number_FogEnd or 1e6 end
    end })
    sec:slider({ name = "Fog End Value",              flag = "lighting_number_FogEnd",       min = 0, max = 1000000, default = 1000000, interval = 1000, callback = function(v)
        if library.flags.lighting_toggle_FogEnd then Lighting.FogEnd = v end
    end })
    sec:toggle({ name = "Fog Start",                  flag = "lighting_toggle_FogStart",     default = false })
    sec:toggle({ name = "Global Shadows",             flag = "lighting_bool_GlobalShadows",  default = true  })
    sec:toggle({ name = "Exposure Compensation",      flag = "lighting_toggle_ExposureCompensation", default = false })
    sec:slider({ name = "Exposure Value",             flag = "lighting_number_ExposureCompensation", min = -3, max = 3, default = 0, interval = 0.1, callback = function(v)
        if library.flags.lighting_toggle_ExposureCompensation then Lighting.ExposureCompensation = v end
    end })

    local sec2 = col:section({ name = "Atmosphere", size = 1, icon = ICO.visuals, default = false })
    sec2:toggle({ name = "Enabled",                   flag = "atmosphere_enabled",           default = false })
    sec2:slider({ name = "Density",                   flag = "atmosphere_density",           min = 0, max = 1, default = 0.3, interval = 0.01 })
    sec2:slider({ name = "Offset",                    flag = "atmosphere_offset",            min = 0, max = 1, default = 0, interval = 0.01 })
    sec2:slider({ name = "Haze",                      flag = "atmosphere_haze",              min = 0, max = 10, default = 0, interval = 0.1 })
    sec2:slider({ name = "Glare",                     flag = "atmosphere_glare",             min = 0, max = 1, default = 0, interval = 0.01 })
    sec2:slider({ name = "Decay",                     flag = "atmosphere_decay",             min = 0, max = 1, default = 0, interval = 0.01 })

    local sec3 = col:section({ name = "Color Correction", size = 1, icon = ICO.visuals, default = false })
    sec3:toggle({ name = "Enabled",                   flag = "color_correction_enabled",     default = false })
    sec3:slider({ name = "Brightness",                flag = "color_correction_brightness",  min = -1, max = 1, default = 0, interval = 0.01 })
    sec3:slider({ name = "Contrast",                  flag = "color_correction_contrast",    min = -1, max = 1, default = 0, interval = 0.01 })
    sec3:slider({ name = "Saturation",                flag = "color_correction_saturation",  min = -1, max = 1, default = 0, interval = 0.01 })

    local sec4 = col:section({ name = "Bloom", size = 1, icon = ICO.visuals, default = false })
    sec4:toggle({ name = "Enabled",                   flag = "bloom_enabled",                default = false })
    sec4:slider({ name = "Intensity",                 flag = "bloom_intensity",              min = 0, max = 10, default = 1, interval = 0.1 })
    sec4:slider({ name = "Size",                      flag = "bloom_size",                   min = 0, max = 56, default = 24, interval = 1 })
    sec4:slider({ name = "Threshold",                 flag = "bloom_threshold",              min = 0, max = 2, default = 1, interval = 0.01 })
end

-- World
do
    local col = vis_world:column({})
    local sec = col:section({ name = "Skybox", size = 1, icon = ICO.visuals, default = false })
    sec:toggle({ name = "Enabled",                    flag = "skybox_enabled",               default = false })
    sec:toggle({ name = "Disable Default",            flag = "skybox_disable",               default = false })

    local sec2 = col:section({ name = "Ambience", size = 1, icon = ICO.visuals, default = false })
    sec2:toggle({ name = "Enabled",                   flag = "ambience_enabled",             default = false })
    sec2:slider({ name = "Volume",                    flag = "ambience_volume",              min = 0, max = 1, default = 0.5, interval = 0.05 })
    sec2:slider({ name = "Value",                     flag = "ambience_value",               min = 0, max = 1, default = 0, interval = 0.01 })

    local sec3 = col:section({ name = "Sunrays", size = 1, icon = ICO.visuals, default = false })
    sec3:toggle({ name = "Enabled",                   flag = "sunrays_enabled",              default = false })
    sec3:slider({ name = "Intensity",                 flag = "sunrays_intensity",            min = 0, max = 1, default = 0.5, interval = 0.01 })
    sec3:slider({ name = "Spread",                    flag = "sunrays_spread",               min = 0, max = 1, default = 0.5, interval = 0.01 })

    local sec4 = col:section({ name = "Weather", size = 1, icon = ICO.visuals, default = false })
    sec4:toggle({ name = "Enabled",                   flag = "weather_enabled",              default = false })
    sec4:dropdown({name = "Type",                     flag = "weather_value",                items = { "Rain", "Snow", "Lightning", "Stars", "Moon", "Solar System", "Sparkle" }, default = "Rain" })
    sec4:slider({ name = "Rate Multiplier",           flag = "weather_rate_multiplier",      min = 0.1, max = 5, default = 1, interval = 0.1 })
    sec4:slider({ name = "Lifetime Multiplier",       flag = "weather_lifetime_multiplier",  min = 0.1, max = 5, default = 1, interval = 0.1 })
    sec4:slider({ name = "Timescale Multiplier",      flag = "weather_timescale_multiplier", min = 0.1, max = 5, default = 1, interval = 0.1 })
end

-----------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------
local cfg_main = window:tab({ name = "Config", icon = ICO.config, tabs = { "Main" } })

do
    local col = cfg_main:column({})
    local sec = col:section({ name = "Config System", size = 1, icon = ICO.config, default = true })
    sec:button({ name = "Save",    callback = function()
        if writefile then
            local ok = pcall(writefile, "kamidere/settings/default.json",
                game:GetService("HttpService"):JSONEncode(library.flags))
            library.notifications:create_notification({ name = "Config", info = ok and "Saved!" or "Failed", lifetime = 2 })
        end
    end })
    sec:button({ name = "Load",    callback = function()
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
    sec:toggle({ name = "Auto Load",  flag = "auto_load_enabled",  default = false })
    sec:toggle({ name = "Auto Load Silent", flag = "auto_load_silent", default = false })

    local sec2 = col:section({ name = "Configs", size = 1, icon = ICO.config, default = false })
    sec2:button({ name = "Refresh", callback = function()
        if isfolder and isfolder("kamidere/settings") then
            library.notifications:create_notification({ name = "Config", info = "Refreshed", lifetime = 1 })
        end
    end })
end

-----------------------------------------------------------------------
-- FLAGS
-----------------------------------------------------------------------
local flags = library.flags

-----------------------------------------------------------------------
-- UTILITY
-----------------------------------------------------------------------
local function getChar(p)   return p and p.Character end
local function getHum(c)    return c and c:FindFirstChildOfClass("Humanoid") end
local function isAlive(p)   local h = getHum(getChar(p)); return h and h.Health > 0 end

local function getPart(char, partName)
    if partName == "Nearest" then
        local best, bd = nil, math.huge
        for _, p in char:GetDescendants() do
            if p:IsA("BasePart") then
                local _, d = Camera:WorldToViewportPoint(p.Position)
                if d < bd then bd = d; best = p end
            end
        end
        return best
    end
    if partName == "HumanoidRootPart" then return char:FindFirstChild("HumanoidRootPart") end
    return char:FindFirstChild(partName) or char:FindFirstChild("Head")
end

local function getTarget(fov, priorityMode, ignoreTeam, visOnly, limitDist, maxDist)
    local vpC = Camera.ViewportSize / 2
    local best, bestVal = nil, math.huge
    for _, p in Players:GetPlayers() do
        if p == LP then continue end
        if not isAlive(p) then continue end
        if ignoreTeam == false and p.Team == LP.Team and p.Team ~= nil then continue end
        local char = getChar(p); if not char then continue end
        local head = char:FindFirstChild("Head"); if not head then continue end
        if visOnly then
            local r = workspace:Raycast(Camera.CFrame.Position, head.Position - Camera.CFrame.Position,
                RaycastParams.new())
            if r and not r.Instance:IsDescendantOf(char) then continue end
        end
        local sp, onScreen = Camera:WorldToViewportPoint(head.Position)
        if not onScreen then continue end
        local dist2d = (Vector2.new(sp.X, sp.Y) - vpC).Magnitude
        if fov and dist2d > fov then continue end
        if limitDist and maxDist then
            local root = getChar(LP) and getChar(LP):FindFirstChild("HumanoidRootPart")
            local d3 = root and (root.Position - head.Position).Magnitude or math.huge
            if d3 > maxDist then continue end
        end
        local val = dist2d
        if priorityMode == "Lowest HP" then
            local hum = getHum(char); val = hum and hum.Health or math.huge
        elseif priorityMode == "Nearest" then
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

local function removeEspFor(p)
    local t = espObjects[p]; if not t then return end
    for _, d in t do
        if type(d) == "table" then for _, l in d do pcall(function() l:Remove() end) end
        else pcall(function() d:Remove() end) end
    end
    espObjects[p] = nil
end

local SKEL = {
    {"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
    {"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},
    {"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},
    {"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},
    {"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"},
}

local function createEspFor(p)
    local t = {}
    if flags.esp_box or flags.esp_fill then
        t.box = Drawing.new("Square"); t.box.Thickness = 1
        t.box.Color = Color3.fromRGB(255,60,60); t.box.Visible = false
    end
    if flags.esp_name then
        t.name = Drawing.new("Text"); t.name.Size = 13; t.name.Center = true
        t.name.Outline = true; t.name.Color = Color3.fromRGB(255,255,255); t.name.Visible = false
        t.name.Text = flags.esp_name_type == "Display Name" and p.DisplayName
                   or flags.esp_name_type == "Both" and (p.Name.." ("..p.DisplayName..")")
                   or p.Name
    end
    if flags.esp_distance then
        t.dist = Drawing.new("Text"); t.dist.Size = 11; t.dist.Center = true
        t.dist.Outline = true; t.dist.Color = Color3.fromRGB(200,200,200); t.dist.Visible = false
    end
    if flags.esp_healthbar then
        t.hpbg = Drawing.new("Square"); t.hpbg.Filled = true; t.hpbg.Color = Color3.fromRGB(0,0,0); t.hpbg.Visible = false
        t.hp   = Drawing.new("Square"); t.hp.Filled = true; t.hp.Color = Color3.fromRGB(60,255,60); t.hp.Visible = false
    end
    if flags.esp_skeleton then
        t.skel = {}
        for i = 1, #SKEL do
            t.skel[i] = Drawing.new("Line"); t.skel[i].Thickness = 1
            t.skel[i].Color = Color3.fromRGB(255,255,255); t.skel[i].Visible = false
        end
    end
    if flags.target_tracer then
        t.tracer = Drawing.new("Line"); t.tracer.Thickness = 1
        t.tracer.Color = Color3.fromRGB(255,60,60); t.tracer.Visible = false
    end
    espObjects[p] = t
end

local function updateEsp()
    local anyEsp = flags.esp_box or flags.esp_fill or flags.esp_name or flags.esp_distance
                or flags.esp_healthbar or flags.esp_skeleton or flags.target_tracer
    for _, p in Players:GetPlayers() do
        if p == LP then continue end
        local showTeam = flags.esp_show_team
        if not showTeam and p.Team == LP.Team and p.Team ~= nil then
            if espObjects[p] then removeEspFor(p) end
            continue
        end
        local t = espObjects[p]
        if anyEsp and not t then createEspFor(p); t = espObjects[p]
        elseif not anyEsp and t then removeEspFor(p); continue end
        if not t then continue end

        local char = getChar(p); local hum = getHum(char)
        local function hide()
            for _, d in t do
                if type(d) == "table" then for _, l in d do pcall(function() l.Visible = false end) end
                else pcall(function() d.Visible = false end) end
            end
        end
        if not char or not hum or hum.Health <= 0 then hide(); continue end
        local root = char:FindFirstChild("HumanoidRootPart"); if not root then hide(); continue end

        local topPos = root.Position + Vector3.new(0, 3.2, 0)
        local botPos = root.Position - Vector3.new(0, 3.2, 0)
        local topSc, topV = Camera:WorldToViewportPoint(topPos)
        local botSc, botV = Camera:WorldToViewportPoint(botPos)
        if not topV or not botV then hide(); continue end

        local height = math.abs(topSc.Y - botSc.Y)
        local width  = height * 0.6
        local x, y  = topSc.X - width / 2, topSc.Y

        if (flags.esp_box or flags.esp_fill) and t.box then
            t.box.Filled   = flags.esp_fill or false
            t.box.Size     = Vector2.new(width, height)
            t.box.Position = Vector2.new(x, y)
            t.box.Visible  = true
        elseif t.box then t.box.Visible = false end

        if flags.esp_name and t.name then
            t.name.Position = Vector2.new(topSc.X, y - 15); t.name.Visible = true
        elseif t.name then t.name.Visible = false end

        if flags.esp_distance and t.dist then
            local root2 = getChar(LP) and getChar(LP):FindFirstChild("HumanoidRootPart")
            local d = root2 and math.floor((root2.Position - root.Position).Magnitude) or 0
            t.dist.Text = d.."m"
            t.dist.Position = Vector2.new(topSc.X, y + height + 2); t.dist.Visible = true
        elseif t.dist then t.dist.Visible = false end

        if flags.esp_healthbar and t.hpbg and t.hp then
            local ratio = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
            t.hpbg.Size = Vector2.new(4, height); t.hpbg.Position = Vector2.new(x - 6, y); t.hpbg.Visible = true
            t.hp.Size = Vector2.new(4, height * ratio); t.hp.Position = Vector2.new(x - 6, y + height * (1 - ratio))
            t.hp.Color = Color3.fromRGB(255 * (1-ratio), 255 * ratio, 0); t.hp.Visible = true
        elseif t.hpbg then t.hpbg.Visible = false; if t.hp then t.hp.Visible = false end end

        if flags.esp_skeleton and t.skel then
            for i, pair in SKEL do
                local a = char:FindFirstChild(pair[1]); local b = char:FindFirstChild(pair[2])
                if not t.skel[i] then
                    t.skel[i] = Drawing.new("Line"); t.skel[i].Thickness = flags.esp_skeleton_thickness or 1
                    t.skel[i].Color = Color3.fromRGB(255,255,255)
                end
                if a and b then
                    local sa, oa = Camera:WorldToViewportPoint(a.Position)
                    local sb, ob = Camera:WorldToViewportPoint(b.Position)
                    if oa and ob then
                        t.skel[i].From = Vector2.new(sa.X, sa.Y)
                        t.skel[i].To   = Vector2.new(sb.X, sb.Y)
                        t.skel[i].Visible = true
                    else t.skel[i].Visible = false end
                else t.skel[i].Visible = false end
            end
        elseif t.skel then for _, l in t.skel do pcall(function() l.Visible = false end) end end

        if flags.target_tracer and t.tracer then
            local vp = Camera.ViewportSize
            t.tracer.From = Vector2.new(vp.X/2, vp.Y)
            t.tracer.To   = Vector2.new(topSc.X, y + height)
            t.tracer.Visible = true
        elseif t.tracer then t.tracer.Visible = false end
    end
end

-----------------------------------------------------------------------
-- CROSSHAIR DRAWING
-----------------------------------------------------------------------
local chLines = {
    Drawing.new("Line"), Drawing.new("Line"),
    Drawing.new("Line"), Drawing.new("Line"),
}
for _, l in chLines do l.Color = Color3.fromRGB(255,255,255); l.Visible = false end

local function updateCrosshair()
    if not flags.crosshair_enabled then
        for _, l in chLines do l.Visible = false end
        return
    end
    local vp = Camera.ViewportSize
    local cx, cy = vp.X/2, vp.Y/2
    local len  = flags.crosshair_length or 8
    local gap  = flags.crosshair_offset or 4
    local th   = flags.crosshair_thickness or 2
    local col  = Color3.fromRGB(255,255,255)
    -- left
    chLines[1].From = Vector2.new(cx-len-gap, cy); chLines[1].To = Vector2.new(cx-gap, cy)
    chLines[1].Thickness = th; chLines[1].Color = col; chLines[1].Visible = true
    -- right
    chLines[2].From = Vector2.new(cx+gap, cy); chLines[2].To = Vector2.new(cx+len+gap, cy)
    chLines[2].Thickness = th; chLines[2].Color = col; chLines[2].Visible = true
    -- up
    chLines[3].From = Vector2.new(cx, cy-len-gap); chLines[3].To = Vector2.new(cx, cy-gap)
    chLines[3].Thickness = th; chLines[3].Color = col; chLines[3].Visible = true
    -- down
    chLines[4].From = Vector2.new(cx, cy+gap); chLines[4].To = Vector2.new(cx, cy+len+gap)
    chLines[4].Thickness = th; chLines[4].Color = col; chLines[4].Visible = true
end

-----------------------------------------------------------------------
-- LIGHTING EFFECTS
-----------------------------------------------------------------------
local function applyLighting()
    if flags.lighting_toggle_Brightness then Lighting.Brightness = flags.lighting_number_Brightness or 2 end
    if flags.lighting_toggle_ClockTime  then Lighting.ClockTime  = flags.lighting_number_ClockTime  or 14 end
    if flags.lighting_toggle_FogEnd     then Lighting.FogEnd     = flags.lighting_number_FogEnd     or 1e6 end
    if flags.lighting_toggle_FogStart   then Lighting.FogStart   = 0 end
    if flags.lighting_bool_GlobalShadows ~= nil then Lighting.GlobalShadows = flags.lighting_bool_GlobalShadows end
    if flags.lighting_toggle_ExposureCompensation then
        Lighting.ExposureCompensation = flags.lighting_number_ExposureCompensation or 0
    end
    if flags.bloom_enabled then
        local bloom = Lighting:FindFirstChildOfClass("BloomEffect") or Instance.new("BloomEffect", Lighting)
        bloom.Intensity = flags.bloom_intensity or 1
        bloom.Size      = flags.bloom_size      or 24
        bloom.Threshold = flags.bloom_threshold or 1
    else
        local bloom = Lighting:FindFirstChildOfClass("BloomEffect")
        if bloom then bloom:Destroy() end
    end
    if flags.color_correction_enabled then
        local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
        cc.Brightness  = flags.color_correction_brightness  or 0
        cc.Contrast    = flags.color_correction_contrast    or 0
        cc.Saturation  = flags.color_correction_saturation  or 0
    else
        local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
        if cc then cc:Destroy() end
    end
    if flags.sunrays_enabled then
        local sr = Lighting:FindFirstChildOfClass("SunRaysEffect") or Instance.new("SunRaysEffect", Lighting)
        sr.Intensity = flags.sunrays_intensity or 0.5
        sr.Spread    = flags.sunrays_spread    or 0.5
    else
        local sr = Lighting:FindFirstChildOfClass("SunRaysEffect")
        if sr then sr:Destroy() end
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
    flyPart = Instance.new("Part")
    flyPart.Size = Vector3.new(1,1,1); flyPart.CFrame = root.CFrame
    flyPart.Transparency = 1; flyPart.Anchored = true; flyPart.CanCollide = false
    flyPart.Parent = workspace
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

    -- noclip
    if flags.movement_noclip and char then
        for _, p in char:GetDescendants() do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end

    -- fly
    if flags.movement_fly then
        if not flyPart then startFly() end
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root and flyPart then
            local spd = flags.movement_flyvalue or 30
            local cf  = Camera.CFrame; local dir = Vector3.new(0,0,0)
            if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + cf.LookVector  * spd * dt end
            if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - cf.LookVector  * spd * dt end
            if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - cf.RightVector * spd * dt end
            if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + cf.RightVector * spd * dt end
            if UIS:IsKeyDown(Enum.KeyCode.Space)      then dir = dir + Vector3.new(0, spd * dt * 0.5, 0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift)  then dir = dir - Vector3.new(0, spd * dt * 0.5, 0) end
            flyPart.CFrame = flyPart.CFrame + dir
            root.CFrame = flyPart.CFrame
        end
    else
        if flyPart then stopFly() end
    end

    -- velocity
    if flags.movement_velocity and char then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            local spd = flags.movement_velocityvalue or 50
            local cf  = Camera.CFrame
            if UIS:IsKeyDown(Enum.KeyCode.W) then root.Velocity = cf.LookVector  * spd end
            if UIS:IsKeyDown(Enum.KeyCode.S) then root.Velocity = -cf.LookVector * spd end
            if UIS:IsKeyDown(Enum.KeyCode.A) then root.Velocity = -cf.RightVector* spd end
            if UIS:IsKeyDown(Enum.KeyCode.D) then root.Velocity = cf.RightVector * spd end
        end
    end

    -- anti-aim
    if flags.anti_aim_enabled and char then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            if flags.anti_aim_yaw == "Spin" then
                root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(10), 0)
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
    local ignoreTeam = true
    local visOnly    = flags.targeting_visibleonly
    local limitDist  = flags.targeting_limitdistance
    local maxDist    = flags.targeting_maxdistance or 500
    local partName   = flags.targeting_part or "Head"
    local prioMode   = flags.ragebot_priority_targets or "Closest to Crosshair"

    -- ragebot
    if flags.ragebot_enabled then
        local target = getTarget(360, prioMode, ignoreTeam, visOnly, limitDist, maxDist)
        if target then
            local part = getPart(target.char, flags.targeting_part or "Head")
            if part then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, part.Position)
                for i = 1, math.floor(flags.ragebot_shoot_attempts or 1) do
                    fire()
                    if i < (flags.ragebot_shoot_attempts or 1) then task.wait(0.03) end
                end
                if flags.ragebot_priority_notification then
                    library.notifications:create_notification({ name = "Ragebot", info = "Locking: "..target.player.Name, lifetime = 1 })
                end
            end
        end
    end

    -- silent aim
    if flags.silent_toggle then
        local target = getTarget(flags.silent_radius or 180, prioMode, ignoreTeam, visOnly, limitDist, maxDist)
        if target then
            local part = getPart(target.char, flags.silent_closest_part or "Head")
            if part then
                if math.random(1, 100) <= (flags.silent_hitchance or 100) then
                    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, part.Position)
                end
            end
        end
    end

    -- aimbot (smooth legit)
    if flags.aimbot_toggle then
        local target = getTarget(flags.aimbot_radius or 90, "Closest to Crosshair", ignoreTeam, visOnly, limitDist, maxDist)
        if target then
            local part = getPart(target.char, flags.aimbot_closest_part or "Head")
            if part then
                local targetCF = CFrame.lookAt(Camera.CFrame.Position, part.Position)
                local sx = flags.aimbot_delay_smooth_x or 0.1
                local sy = flags.aimbot_delay_smooth_y or 0.1
                Camera.CFrame = Camera.CFrame:Lerp(targetCF, math.max(sx, sy))
            end
        end
    end

    -- triggerbot
    if flags.triggerbot_enabled then
        local target = getTarget(50, "Closest to Crosshair", ignoreTeam, visOnly, limitDist, flags.triggerbot_max_distance or 100)
        if target then
            tb_hold = tb_hold + dt
            local reaction = ((flags.triggerbot_reaction_time or 100)
                + math.random(-(flags.triggerbot_reaction_time_offset or 0), math.max(0, flags.triggerbot_reaction_time_offset or 0))
            ) / 1000
            if tb_hold >= reaction and not tb_waiting then
                tb_waiting = true
                task.spawn(function()
                    task.wait((flags.triggerbot_shoot_delay or 0) / 1000)
                    fire(); tb_waiting = false; tb_hold = 0
                end)
            end
        else
            if tb_hold > (flags.triggerbot_forget_time or 0.5) then tb_hold = 0 end
        end
    end

    -- third person
    if flags.third_person_enabled then
        local root = getChar(LP) and getChar(LP):FindFirstChild("HumanoidRootPart")
        if root then Camera.CFrame = CFrame.new(root.Position + Vector3.new(0,3,-15), root.Position) end
    end

    -- FOV changer live
    if flags.camera_fov_changer then Camera.FieldOfView = flags.camera_fov_changer_amount or 70 end

    updateEsp()
    updateCrosshair()
    applyLighting()
end)
