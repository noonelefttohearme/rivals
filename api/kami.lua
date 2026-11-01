--[[

    Milenium Library
    -> Made by @finobe 
    -> Kind of got bored idk what to do with life
    -> Idk who or why this got leaked, ui was VERY popular and high in demand with customers
]]

-- Variables 
    local uis = game:GetService("UserInputService") 
    local players = game:GetService("Players") 
    local ws = game:GetService("Workspace")
    local rs = game:GetService("ReplicatedStorage")
    local http_service = game:GetService("HttpService")
    local gui_service = game:GetService("GuiService")
    local lighting = game:GetService("Lighting")
    local run = game:GetService("RunService")
    local stats = game:GetService("Stats")
    local coregui = game:GetService("CoreGui")
    local debris = game:GetService("Debris")
    local tween_service = game:GetService("TweenService")
    local sound_service = game:GetService("SoundService")

    local vec2 = Vector2.new
    local vec3 = Vector3.new
    local dim2 = UDim2.new
    local dim = UDim.new 
    local rect = Rect.new
    local cfr = CFrame.new
    local empty_cfr = cfr()
    local point_object_space = empty_cfr.PointToObjectSpace
    local angle = CFrame.Angles
    local dim_offset = UDim2.fromOffset

    local color = Color3.new
    local rgb = Color3.fromRGB
    local hex = Color3.fromHex
    local hsv = Color3.fromHSV
    local rgbseq = ColorSequence.new
    local rgbkey = ColorSequenceKeypoint.new
    local numseq = NumberSequence.new
    local numkey = NumberSequenceKeypoint.new

    local camera = ws.CurrentCamera
    local lp = players.LocalPlayer 
    local mouse = lp:GetMouse() 
    local gui_offset = gui_service:GetGuiInset().Y

    local max = math.max 
    local floor = math.floor 
    local min = math.min 
    local abs = math.abs 
    local noise = math.noise
    local rad = math.rad 
    local random = math.random 
    local pow = math.pow 
    local sin = math.sin 
    local pi = math.pi 
    local tan = math.tan 
    local atan2 = math.atan2 
    local clamp = math.clamp 

    local insert = table.insert 
    local find = table.find 
    local remove = table.remove
    local concat = table.concat
-- 

-- Library init
    getgenv().library = {
        directory = "milenium",
        folders = {
            "/fonts",
            "/configs",
        },
        flags = {},
        config_flags = {},
        connections = {},   
        notifications = {notifs = {}},
        current_open; 
    }

    local themes = {
        preset = {
            accent = rgb(155, 150, 219),
        }, 

        utility = {
            accent = {
                BackgroundColor3 = {}, 	
                TextColor3 = {}, 
                ImageColor3 = {}, 
                ScrollBarImageColor3 = {} 
            },
        }
    }

    local keys = {
        [Enum.KeyCode.LeftShift] = "LS",
        [Enum.KeyCode.RightShift] = "RS",
        [Enum.KeyCode.LeftControl] = "LC",
        [Enum.KeyCode.RightControl] = "RC",
        [Enum.KeyCode.Insert] = "INS",
        [Enum.KeyCode.Backspace] = "BS",
        [Enum.KeyCode.Return] = "Ent",
        [Enum.KeyCode.LeftAlt] = "LA",
        [Enum.KeyCode.RightAlt] = "RA",
        [Enum.KeyCode.CapsLock] = "CAPS",
        [Enum.KeyCode.One] = "1",
        [Enum.KeyCode.Two] = "2",
        [Enum.KeyCode.Three] = "3",
        [Enum.KeyCode.Four] = "4",
        [Enum.KeyCode.Five] = "5",
        [Enum.KeyCode.Six] = "6",
        [Enum.KeyCode.Seven] = "7",
        [Enum.KeyCode.Eight] = "8",
        [Enum.KeyCode.Nine] = "9",
        [Enum.KeyCode.Zero] = "0",
        [Enum.KeyCode.KeypadOne] = "Num1",
        [Enum.KeyCode.KeypadTwo] = "Num2",
        [Enum.KeyCode.KeypadThree] = "Num3",
        [Enum.KeyCode.KeypadFour] = "Num4",
        [Enum.KeyCode.KeypadFive] = "Num5",
        [Enum.KeyCode.KeypadSix] = "Num6",
        [Enum.KeyCode.KeypadSeven] = "Num7",
        [Enum.KeyCode.KeypadEight] = "Num8",
        [Enum.KeyCode.KeypadNine] = "Num9",
        [Enum.KeyCode.KeypadZero] = "Num0",
        [Enum.KeyCode.Minus] = "-",
        [Enum.KeyCode.Equals] = "=",
        [Enum.KeyCode.Tilde] = "~",
        [Enum.KeyCode.LeftBracket] = "[",
        [Enum.KeyCode.RightBracket] = "]",
        [Enum.KeyCode.RightParenthesis] = ")",
        [Enum.KeyCode.LeftParenthesis] = "(",
        [Enum.KeyCode.Semicolon] = ",",
        [Enum.KeyCode.Quote] = "'",
        [Enum.KeyCode.BackSlash] = "\\",
        [Enum.KeyCode.Comma] = ",",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Slash] = "/",
        [Enum.KeyCode.Asterisk] = "*",
        [Enum.KeyCode.Plus] = "+",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Backquote] = "`",
        [Enum.UserInputType.MouseButton1] = "MB1",
        [Enum.UserInputType.MouseButton2] = "MB2",
        [Enum.UserInputType.MouseButton3] = "MB3",
        [Enum.KeyCode.Escape] = "ESC",
        [Enum.KeyCode.Space] = "SPC",
    }
        
    library.__index = library

    for _, path in next, library.folders do 
        makefolder(library.directory .. path)
    end

    local flags = library.flags 
    local config_flags = library.config_flags
    local notifications = library.notifications 

    local fonts = {}; do
        function Register_Font(Name, Weight, Style, Asset)
            if not isfile(Asset.Id) then
                writefile(Asset.Id, Asset.Font)
            end

            if isfile(Name .. ".font") then
                delfile(Name .. ".font")
            end

            local Data = {
                name = Name,
                faces = {
                    {
                        name = "Normal",
                        weight = Weight,
                        style = Style,
                        assetId = getcustomasset(Asset.Id),
                    },
                },
            }

            writefile(Name .. ".font", http_service:JSONEncode(Data))

            return getcustomasset(Name .. ".font");
        end
        
        local Medium = Register_Font("Medium", 200, "Normal", {
            Id = "Medium.ttf",
            Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/Inter_28pt-Medium.ttf"),
        })

        local SemiBold = Register_Font("SemiBold", 200, "Normal", {
            Id = "SemiBold.ttf",
            Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/Inter_28pt-SemiBold.ttf"),
        })

        fonts = {
            small = Font.new(Medium, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
            font = Font.new(SemiBold, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
        }
    end
--

-- Library functions 
    -- Misc functions
        function library:tween(obj, properties, easing_style, time) 
            local tween = tween_service:Create(obj, TweenInfo.new(time or 0.25, easing_style or Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false, 0), properties):Play()
                
            return tween
        end

        function library:resizify(frame) 
            local Frame = Instance.new("TextButton")
            Frame.Position = dim2(1, -10, 1, -10)
            Frame.BorderColor3 = rgb(0, 0, 0)
            Frame.Size = dim2(0, 10, 0, 10)
            Frame.BorderSizePixel = 0
            Frame.BackgroundColor3 = rgb(255, 255, 255)
            Frame.Parent = frame
            Frame.BackgroundTransparency = 1 
            Frame.Text = ""

            local resizing = false 
            local start_size 
            local start 
            local og_size = frame.Size  

            Frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    resizing = true
                    start = input.Position
                    start_size = frame.Size
                end
            end)

            Frame.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    resizing = false
                end
            end)

            library:connection(uis.InputChanged, function(input, game_event) 
                if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local viewport_x = camera.ViewportSize.X
                    local viewport_y = camera.ViewportSize.Y

                    local current_size = dim2(
                        start_size.X.Scale,
                        math.clamp(
                            start_size.X.Offset + (input.Position.X - start.X),
                            og_size.X.Offset,
                            viewport_x
                        ),
                        start_size.Y.Scale,
                        math.clamp(
                            start_size.Y.Offset + (input.Position.Y - start.Y),
                            og_size.Y.Offset,
                            viewport_y
                        )
                    )

                    library:tween(frame, {Size = current_size}, Enum.EasingStyle.Linear, 0.05)
                end
            end)
        end 

        function fag(tbl)
            local Size = 0
            
            for _ in tbl do
                Size = Size + 1
            end
        
            return Size
        end
        
        function library:next_flag()
            local index = fag(library.flags) + 1;
            local str = string.format("flagnumber%s", index)
            
            return str;
        end 

        function library:mouse_in_frame(uiobject)
            local y_cond = uiobject.AbsolutePosition.Y <= mouse.Y and mouse.Y <= uiobject.AbsolutePosition.Y + uiobject.AbsoluteSize.Y
            local x_cond = uiobject.AbsolutePosition.X <= mouse.X and mouse.X <= uiobject.AbsolutePosition.X + uiobject.AbsoluteSize.X

            return (y_cond and x_cond)
        end

        function library:draggify(frame)
            local dragging = false 
            local start_size = frame.Position
            local start 

            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    start = input.Position
                    start_size = frame.Position
                end
            end)

            frame.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)

            library:connection(uis.InputChanged, function(input, game_event) 
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local viewport_x = camera.ViewportSize.X
                    local viewport_y = camera.ViewportSize.Y

                    local current_position = dim2(
                        0,
                        clamp(
                            start_size.X.Offset + (input.Position.X - start.X),
                            0,
                            viewport_x - frame.Size.X.Offset
                        ),
                        0,
                        math.clamp(
                            start_size.Y.Offset + (input.Position.Y - start.Y),
                            0,
                            viewport_y - frame.Size.Y.Offset
                        )
                    )

                    library:tween(frame, {Position = current_position}, Enum.EasingStyle.Linear, 0.05)
                    library:close_element()
                end
            end)
        end 

        function library:convert(str)
            local values = {}

            for value in string.gmatch(str, "[^,]+") do
                insert(values, tonumber(value))
            end
            
            if #values == 4 then              
                return unpack(values)
            else 
                return
            end
        end
        
        function library:convert_enum(enum)
            local enum_parts = {}
        
            for part in string.gmatch(enum, "[%w_]+") do
                insert(enum_parts, part)
            end
        
            local enum_table = Enum
            for i = 2, #enum_parts do
                local enum_item = enum_table[enum_parts[i]]
        
                enum_table = enum_item
            end
        
            return enum_table
        end

        local config_holder;
        function library:update_config_list() 
            if not config_holder then 
                return 
            end
            
            local list = {}
            
            for idx, file in listfiles(library.directory .. "/configs") do
                local name = file:gsub(library.directory .. "/configs\\", ""):gsub(".cfg", ""):gsub(library.directory .. "\\configs\\", "")
                list[#list + 1] = name
            end

            config_holder.refresh_options(list)
        end 

        function library:get_config()
            local Config = {}
            
            for _, v in next, flags do
                if type(v) == "table" and v.key then
                    Config[_] = {active = v.active, mode = v.mode, key = tostring(v.key)}
                elseif type(v) == "table" and v["Transparency"] and v["Color"] then
                    Config[_] = {Transparency = v["Transparency"], Color = v["Color"]:ToHex()}
                else
                    Config[_] = v
                end
            end 
            
            return http_service:JSONEncode(Config)
        end

        function library:load_config(config_json) 
            local config = http_service:JSONDecode(config_json)
            
            for _, v in config do 
                local function_set = library.config_flags[_]
                
                if _ == "config_name_list" then 
                    continue 
                end

                if function_set then 
                    if type(v) == "table" and v["Transparency"] and v["Color"] then
                        function_set(hex(v["Color"]), v["Transparency"])
                    elseif type(v) == "table" and v["active"] then 
                        function_set(v)
                    else
                        function_set(v)
                    end
                end 
            end 
        end 
        
        function library:round(number, float) 
            local multiplier = 1 / (float or 1)

            return floor(number * multiplier + 0.5) / multiplier
        end 

        function library:apply_theme(instance, theme, property) 
            insert(themes.utility[theme][property], instance)
        end

        function library:update_theme(theme, color)
            for _, property in themes.utility[theme] do 

                for m, object in property do 
                    if object[_] == themes.preset[theme] then 
                        object[_] = color 
                    end 
                end 
            end 

            themes.preset[theme] = color 
        end 

        function library:connection(signal, callback)
            local connection = signal:Connect(callback)
            
            insert(library.connections, connection)

            return connection 
        end

        function library:close_element(new_path) 
            local open_element = library.current_open

            if open_element and new_path ~= open_element then
                open_element.set_visible(false)
                open_element.open = false;
            end 

            if new_path ~= open_element then 
                library.current_open = new_path or nil;
            end
        end 

        function library:create(instance, options)
            local ins = Instance.new(instance) 
            
            for prop, value in options do 
                ins[prop] = value
            end
            
            return ins 
        end

        function library:unload_menu() 
            if library[ "items" ] then 
                library[ "items" ]:Destroy()
            end

            if library[ "other" ] then 
                library[ "other" ]:Destroy()
            end 
            
            for index, connection in library.connections do 
                connection:Disconnect() 
                connection = nil 
            end
            
            library = nil 
        end 
    --
    
    -- Library element functions
        function library:window(properties)
            local cfg = { 
                suffix = properties.suffix or properties.Suffix or "tech";
                name = properties.name or properties.Name or "nebula";
                game_name = properties.gameInfo or properties.game_info or properties.GameInfo or "Milenium for Counter-Strike: Global Offensive";
                size = properties.size or properties.Size or dim2(0, 700, 0, 565);
                selected_tab;
                items = {};

                tween;
            }
            
            library[ "items" ] = library:create( "ScreenGui" , {
                Parent = coregui;
                Name = "\0";
                Enabled = true;
                ZIndexBehavior = Enum.ZIndexBehavior.Global;
                IgnoreGuiInset = true;
            });
            
            library[ "other" ] = library:create( "ScreenGui" , {
                Parent = coregui;
                Name = "\0";
                Enabled = false;
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                IgnoreGuiInset = true;
            }); 

            local items = cfg.items; do
                items[ "main" ] = library:create( "Frame" , {
                    Parent = library[ "items" ];
                    Size = cfg.size;
                    Name = "\0";
                    Position = dim2(0.5, -cfg.size.X.Offset / 2, 0.5, -cfg.size.Y.Offset / 2);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(14, 14, 16)
                }); items[ "main" ].Position = dim2(0, items[ "main" ].AbsolutePosition.X, 0, items[ "main" ].AbsolutePosition.Y)
                
                library:create( "UICorner" , {
                    Parent = items[ "main" ];
                    CornerRadius = dim(0, 10)
                });
                
                library:create( "UIStroke" , {
                    Color = rgb(23, 23, 29);
                    Parent = items[ "main" ];
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                });
                
                items[ "side_frame" ] = library:create( "Frame" , {
                    Parent = items[ "main" ];
                    BackgroundTransparency = 1;
                    Name = "\0";
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 196, 1, -25);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(14, 14, 16)
                });
                
                library:create( "Frame" , {
                    AnchorPoint = vec2(1, 0);
                    Parent = items[ "side_frame" ];
                    Position = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 1, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(21, 21, 23)
                });
                
                items[ "button_holder" ] = library:create( "Frame" , {
                    Parent = items[ "side_frame" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 0, 0, 60);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 1, -60);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); cfg.button_holder = items[ "button_holder" ];
                
                library:create( "UIListLayout" , {
                    Parent = items[ "button_holder" ];
                    Padding = dim(0, 5);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UIPadding" , {
                    PaddingTop = dim(0, 16);
                    PaddingBottom = dim(0, 36);
                    Parent = items[ "button_holder" ];
                    PaddingRight = dim(0, 11);
                    PaddingLeft = dim(0, 10)
                });

                local accent = themes.preset.accent
                items[ "title" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = name;
                    Parent = items[ "side_frame" ];
                    Name = "\0";
                    Text = string.format('<u>%s</u><font color = "rgb(255, 255, 255)">%s</font>', cfg.name, cfg.suffix);
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 70);
                    TextColor3 = themes.preset.accent;
                    BorderSizePixel = 0;
                    RichText = true;
                    TextSize = 30;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:apply_theme(items[ "title" ], "accent", "TextColor3");
                
                items[ "multi_holder" ] = library:create( "Frame" , {
                    Parent = items[ "main" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 196, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -196, 0, 56);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); cfg.multi_holder = items[ "multi_holder" ];
                
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = items[ "multi_holder" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(21, 21, 23)
                });
                
                items[ "shadow" ] = library:create( "ImageLabel" , {
                    ImageColor3 = rgb(0, 0, 0);
                    ScaleType = Enum.ScaleType.Slice;
                    Parent = items[ "main" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Name = "\0";
                    BackgroundColor3 = rgb(255, 255, 255);
                    Size = dim2(1, 75, 1, 75);
                    AnchorPoint = vec2(0.5, 0.5);
                    Image = "rbxassetid://112971167999062";
                    BackgroundTransparency = 1;
                    Position = dim2(0.5, 0, 0.5, 0);
                    SliceScale = 0.75;
                    ZIndex = -100;
                    BorderSizePixel = 0;
                    SliceCenter = rect(vec2(112, 112), vec2(147, 147))
                });
                
                items[ "global_fade" ] = library:create( "Frame" , {
                    Parent = items[ "main" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 196, 0, 56);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -196, 1, -81);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(14, 14, 16);
                    ZIndex = 2;
                });                

                library:create( "UICorner" , {
                    Parent = items[ "shadow" ];
                    CornerRadius = dim(0, 5)
                });
                
                items[ "info" ] = library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = items[ "main" ];
                    Name = "\0";
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 25);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(23, 23, 25)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "info" ];
                    CornerRadius = dim(0, 10)
                });
                
                items[ "grey_fill" ] = library:create( "Frame" , {
                    Name = "\0";
                    Parent = items[ "info" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 6);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(23, 23, 25)
                });
                
                items[ "game" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    Parent = items[ "info" ];
                    TextColor3 = rgb(72, 72, 73);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.game_name;
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    AnchorPoint = vec2(0, 0.5);
                    Position = dim2(0, 10, 0.5, -1);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); 
                
                items[ "other_info" ] = library:create( "TextLabel" , {
                    Parent = items[ "info" ];
                    RichText = true;
                    Name = "\0";
                    TextColor3 = themes.preset.accent;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = '<font color="rgb(72, 72, 73)">32 days left, </font>' .. cfg.name .. cfg.suffix;
                    Size = dim2(1, 0, 0, 0);
                    Position = dim2(0, -10, 0.5, -1);
                    AnchorPoint = vec2(0, 0.5);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Right;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    FontFace = fonts.font;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:apply_theme(items[ "other_info" ], "accent", "TextColor3");        
            end 

            do -- Other
                library:draggify(items[ "main" ])
                library:resizify(items[ "main" ])
            end 

            function cfg.toggle_menu(bool) 
                -- WIP 
                -- if cfg.tween then 
                --     cfg.tween:Cancel()
                -- end 

                -- items[ "main" ].Size = dim2(items[ "main" ].Size.Scale.X, items[ "main" ].Size.Offset.X - 20, items[ "main" ].Size.Scale.Y, items[ "main" ].Size.Offset.Y - 20)
                -- library:tween(items[ "tab_holder" ], {Size = dim2(1, -196, 1, -81)}, Enum.EasingStyle.Quad, 0.4)
                -- cfg.tween = 
                
                library[ "items" ].Enabled = bool
            end 
                
            return setmetatable(cfg, library)
        end 

        function library:tab(properties)
            local cfg = {
                name = properties.name or properties.Name or "visuals"; 
                icon = properties.icon or properties.Icon or "http://www.roblox.com/asset/?id=6034767608";
                
                -- multi 
                tabs = properties.tabs or properties.Tabs or {"Main", "Misc.", "Settings"};
                pages = {}; -- data store for multi sections
                current_multi; 
                
                items = {};
            } 

            local items = cfg.items; do 
                items[ "tab_holder" ] = library:create( "Frame" , {
                    Parent = library.cache;
                    Name = "\0";
                    Visible = false;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 196, 0, 56);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -216, 1, -101);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                -- Tab buttons 
                    items[ "button" ] = library:create( "TextButton" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = self.items[ "button_holder" ];
                        AutoButtonColor = false;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Size = dim2(1, 0, 0, 35);
                        BorderSizePixel = 0;
                        TextSize = 16;
                        BackgroundColor3 = rgb(29, 29, 29)
                    });
                    
                    items[ "icon" ] = library:create( "ImageLabel" , {
                        ImageColor3 = rgb(72, 72, 73);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = items[ "button" ];
                        AnchorPoint = vec2(0, 0.5);
                        Image = "http://www.roblox.com/asset/?id=6034767608";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 10, 0.5, 0);
                        Name = "\0";
                        Size = dim2(0, 22, 0, 22);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    }); library:apply_theme(items[ "icon" ], "accent", "ImageColor3");
                    
                    items[ "name" ] = library:create( "TextLabel" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(72, 72, 73);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = cfg.name;
                        Parent = items[ "button" ];
                        Name = "\0";
                        Size = dim2(0, 0, 1, 0);
                        Position = dim2(0, 40, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "name" ];
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "button" ];
                        CornerRadius = dim(0, 7)
                    });
                    
                    library:create( "UIStroke" , {
                        Color = rgb(23, 23, 29);
                        Parent = items[ "button" ];
                        Enabled = false;
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    });
                -- 

                -- Multi Sections
                    items[ "multi_section_button_holder" ] = library:create( "Frame" , {
                        Parent = library.cache;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Visible = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "multi_section_button_holder" ];
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        FillDirection = Enum.FillDirection.Horizontal
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingTop = dim(0, 8);
                        PaddingBottom = dim(0, 7);
                        Parent = items[ "multi_section_button_holder" ];
                        PaddingRight = dim(0, 7);
                        PaddingLeft = dim(0, 7)
                    });                        

                    for _, section in cfg.tabs do
                        local data = {items = {}} 

                        local multi_items = data.items; do 
                            -- Button
                                multi_items[ "button" ] = library:create( "TextButton" , {
                                    FontFace = fonts.font;
                                    TextColor3 = rgb(255, 255, 255);
                                    BorderColor3 = rgb(0, 0, 0);
                                    AutoButtonColor = false;
                                    Text = "";
                                    Parent = items[ "multi_section_button_holder" ];
                                    Name = "\0";
                                    Size = dim2(0, 0, 0, 39);
                                    BackgroundTransparency = 1;
                                    ClipsDescendants = true;
                                    BorderSizePixel = 0;
                                    AutomaticSize = Enum.AutomaticSize.X;
                                    TextSize = 16;
                                    BackgroundColor3 = rgb(25, 25, 29)
                                });
                                
                                multi_items[ "name" ] = library:create( "TextLabel" , {
                                    FontFace = fonts.font;
                                    TextColor3 = rgb(62, 62, 63);
                                    BorderColor3 = rgb(0, 0, 0);
                                    Text = section;
                                    Parent = multi_items[ "button" ];
                                    Name = "\0";
                                    Size = dim2(0, 0, 1, 0);
                                    BackgroundTransparency = 1;
                                    TextXAlignment = Enum.TextXAlignment.Left;
                                    BorderSizePixel = 0;
                                    AutomaticSize = Enum.AutomaticSize.XY;
                                    TextSize = 16;
                                    BackgroundColor3 = rgb(255, 255, 255)
                                });
                                
                                library:create( "UIPadding" , {
                                    Parent = multi_items[ "name" ];
                                    PaddingRight = dim(0, 5);
                                    PaddingLeft = dim(0, 5)
                                });
                                
                                multi_items[ "accent" ] = library:create( "Frame" , {
                                    BorderColor3 = rgb(0, 0, 0);
                                    AnchorPoint = vec2(0, 1);
                                    Parent = multi_items[ "button" ];
                                    BackgroundTransparency = 1;
                                    Position = dim2(0, 10, 1, 4);
                                    Name = "\0";
                                    Size = dim2(1, -20, 0, 6);
                                    BorderSizePixel = 0;
                                    BackgroundColor3 = themes.preset.accent
                                }); library:apply_theme(multi_items[ "accent" ], "accent", "BackgroundColor3");
                                
                                library:create( "UICorner" , {
                                    Parent = multi_items[ "accent" ];
                                    CornerRadius = dim(0, 999)
                                });
                                
                                library:create( "UIPadding" , {
                                    Parent = multi_items[ "button" ];
                                    PaddingRight = dim(0, 10);
                                    PaddingLeft = dim(0, 10)
                                });
                                
                                library:create( "UICorner" , {
                                    Parent = multi_items[ "button" ];
                                    CornerRadius = dim(0, 7)
                                }); 
                            --

                            -- Tab 
                                multi_items[ "tab" ] = library:create( "Frame" , {
                                    Parent = library.cache;
                                    BackgroundTransparency = 1;
                                    Name = "\0";
                                    BorderColor3 = rgb(0, 0, 0);
                                    Size = dim2(1, -20, 1, -20);
                                    BorderSizePixel = 0;
                                    Visible = false;
                                    BackgroundColor3 = rgb(255, 255, 255)
                                });
                                
                                library:create( "UIListLayout" , {
                                    FillDirection = Enum.FillDirection.Vertical;
                                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                                    Parent = multi_items[ "tab" ];
                                    Padding = dim(0, 7);
                                    SortOrder = Enum.SortOrder.LayoutOrder;
                                    VerticalFlex = Enum.UIFlexAlignment.Fill
                                });
                                
                                library:create( "UIPadding" , {
                                    PaddingTop = dim(0, 7);
                                    PaddingBottom = dim(0, 7);
                                    Parent = multi_items[ "tab" ];
                                    PaddingRight = dim(0, 7);
                                    PaddingLeft = dim(0, 7)
                                });
                            --
                        end

                        data.text = multi_items[ "name" ]
                        data.accent = multi_items[ "accent" ]
                        data.button = multi_items[ "button" ]
                        data.page = multi_items[ "tab" ]
                        data.parent = setmetatable(data, library):sub_tab({}).items[ "tab_parent" ]
                        
                        -- Old column code
                        -- data.left = multi_items[ "left" ]
                        -- data.right = multi_items[ "right" ]

						function data.open_page()
							local page = cfg.current_multi; 
                            
                            if page and page.text ~= data.text then 
                                self.items[ "global_fade" ].BackgroundTransparency = 0
                                library:tween(self.items[ "global_fade" ], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
                                
                                local old_size = page.page.Size
                                page.page.Size = dim2(1, -20, 1, -20)
                            end

                            if page then
                                library:tween(page.text, {TextColor3 = rgb(62, 62, 63)})
                                library:tween(page.accent, {BackgroundTransparency = 1})
                                library:tween(page.button, {BackgroundTransparency = 1})

                                page.page.Visible = false
                                page.page.Parent = library[ "cache" ] 
                            end 
                            
                            library:tween(data.text, {TextColor3 = rgb(255, 255, 255)})
                            library:tween(data.accent, {BackgroundTransparency = 0})
                            library:tween(data.button, {BackgroundTransparency = 0})
                            library:tween(data.page, {Size = dim2(1, 0, 1, 0)}, Enum.EasingStyle.Quad, 0.4)

                            data.page.Visible = true
                            data.page.Parent = items["tab_holder"]

                            cfg.current_multi = data

                            library:close_element()
						end

						multi_items[ "button" ].MouseButton1Down:Connect(function()
							data.open_page() 
						end)

						cfg.pages[#cfg.pages + 1] = setmetatable(data, library)
                    end 

                    cfg.pages[1].open_page()
                --
            end 

            function cfg.open_tab() 
                local selected_tab = self.selected_tab
                
                if selected_tab then 
                    if selected_tab[ 4 ] ~= items[ "tab_holder" ] then 
                        self.items[ "global_fade" ].BackgroundTransparency = 0
                        
                        library:tween(self.items[ "global_fade" ], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
                        selected_tab[ 4 ].Size = dim2(1, -216, 1, -101)
                    end

                    library:tween(selected_tab[ 1 ], {BackgroundTransparency = 1})
                    library:tween(selected_tab[ 2 ], {ImageColor3 = rgb(72, 72, 73)})
                    library:tween(selected_tab[ 3 ], {TextColor3 = rgb(72, 72, 73)})

                    selected_tab[ 4 ].Visible = false
                    selected_tab[ 4 ].Parent = library[ "cache" ]
                    selected_tab[ 5 ].Visible = false
                    selected_tab[ 5 ].Parent = library[ "cache" ]
                end

                library:tween(items[ "button" ], {BackgroundTransparency = 0})
                library:tween(items[ "icon" ], {ImageColor3 = themes.preset.accent})
                library:tween(items[ "name" ], {TextColor3 = rgb(255, 255, 255)})
                library:tween(items[ "tab_holder" ], {Size = dim2(1, -196, 1, -81)}, Enum.EasingStyle.Quad, 0.4)
                
                items[ "tab_holder" ].Visible = true 
                items[ "tab_holder" ].Parent = self.items[ "main" ]
                items[ "multi_section_button_holder" ].Visible = true 
                items[ "multi_section_button_holder" ].Parent = self.items[ "multi_holder" ]

                self.selected_tab = {
                    items[ "button" ];
                    items[ "icon" ];
                    items[ "name" ];
                    items[ "tab_holder" ];
                    items[ "multi_section_button_holder" ];
                }

                library:close_element()
            end

            items[ "button" ].MouseButton1Down:Connect(function()
                cfg.open_tab()
            end)
            
            if not self.selected_tab then 
                cfg.open_tab(true) 
            end

            return unpack(cfg.pages)
        end

        function library:seperator(properties)
            local cfg = {items = {}, name = properties.Name or properties.name or "General"}

            local items = cfg.items do 
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(72, 72, 73);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = self.items[ "button_holder" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    Position = dim2(0, 40, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0; 
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });                
            end;    

            return setmetatable(cfg, library)
        end 

        -- Miscellaneous 
            function library:column(properties) 
                local cfg = {items = {}, size = properties.size or 1}

                local items = cfg.items; do     
                    items[ "column" ] = library:create( "Frame" , {
                        Parent = self[ "parent" ] or self.items["tab_parent"];
                        BackgroundTransparency = 1;
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 0, cfg.size, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingBottom = dim(0, 10);
                        Parent = items[ "column" ]
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "column" ];
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        Padding = dim(0, 10);
                        FillDirection = Enum.FillDirection.Vertical;
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                end 

                return setmetatable(cfg, library)
            end 

            function library:sub_tab(properties) 
                local cfg = {items = {}, order = properties.order or 0; size = properties.size or 1}

                local items = cfg.items; do 
                    items[ "tab_parent" ] = library:create( "Frame" , {
                        Parent = self.items[ "tab" ];
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Size = dim2(0,0,cfg.size,0);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        Visible = true;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        VerticalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = items[ "tab_parent" ];
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                    });
                end

                return setmetatable(cfg, library)
            end 
        --

        function library:section(properties)
            local cfg = {
                name = properties.name or properties.Name or "section"; 
                side = properties.side or properties.Side or "left";
                default = properties.default or properties.Default or false;
                size = properties.size or properties.Size or self.size or 0.5; 
                icon = properties.icon or properties.Icon or "http://www.roblox.com/asset/?id=6022668898";
                fading_toggle = properties.fading or properties.Fading or false;
                items = {};
            };
            
            local items = cfg.items; do 
                items[ "outline" ] = library:create( "Frame" , {
                    Name = "\0";
                    Parent = self.items[ "column" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, cfg.size, -3);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(25, 25, 29)
                });

                library:create( "UICorner" , {
                    Parent = items[ "outline" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "inline" ] = library:create( "Frame" , {
                    Parent = items[ "outline" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(22, 22, 24)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "inline" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "scrolling" ] = library:create( "ScrollingFrame" , {
                    ScrollBarImageColor3 = rgb(44, 44, 46);
                    Active = true;
                    AutomaticCanvasSize = Enum.AutomaticSize.Y;
                    ScrollBarThickness = 2;
                    Parent = items[ "inline" ];
                    Name = "\0";
                    Size = dim2(1, 0, 1, -40);
                    BackgroundTransparency = 1;
                    Position = dim2(0, 0, 0, 35);
                    BackgroundColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    CanvasSize = dim2(0, 0, 0, 0)
                });
                
                items[ "elements" ] = library:create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = items[ "scrolling" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 10, 0, 10);
                    Size = dim2(1, -20, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "elements" ];
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UIPadding" , {
                    PaddingBottom = dim(0, 15);
                    Parent = items[ "elements" ]
                });
                
                items[ "button" ] = library:create( "TextButton" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    AutoButtonColor = false;
                    Parent = items[ "outline" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    Size = dim2(1, -2, 0, 35);
                    BorderSizePixel = 0;
                    TextSize = 16;
                    BackgroundColor3 = rgb(19, 19, 21)
                });
                
                library:create( "UIStroke" , {
                    Color = rgb(23, 23, 29);
                    Parent = items[ "button" ];
                    Enabled = false;
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "button" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "Icon" ] = library:create( "ImageLabel" , {
                    ImageColor3 = themes.preset.accent;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = items[ "button" ];
                    AnchorPoint = vec2(0, 0.5);
                    Image = cfg.icon;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 10, 0.5, 0);
                    Name = "\0";
                    Size = dim2(0, 22, 0, 22);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:apply_theme(items[ "Icon" ], "accent", "ImageColor3");
                
                items[ "section_title" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "button" ];
                    Name = "\0";
                    Size = dim2(0, 0, 1, 0);
                    Position = dim2(0, 40, 0, -1);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = items[ "button" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
                
                if cfg.fading_toggle then 
                    items[ "toggle" ] = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        AutoButtonColor = false;
                        Text = "";
                        AnchorPoint = vec2(1, 0.5);
                        Parent = items[ "button" ];
                        Name = "\0";
                        Position = dim2(1, -9, 0.5, 0);
                        Size = dim2(0, 36, 0, 18);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(58, 58, 62)
                    });  library:apply_theme(items[ "toggle" ], "accent", "BackgroundColor3");
                    
                    library:create( "UICorner" , {
                        Parent = items[ "toggle" ];
                        CornerRadius = dim(0, 999)
                    });
                    
                    items[ "toggle_outline" ] = library:create( "Frame" , {
                        Parent = items[ "toggle" ];
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        BorderMode = Enum.BorderMode.Inset;
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(0, 1, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(50, 50, 50)
                    });  library:apply_theme(items[ "toggle_outline" ], "accent", "BackgroundColor3");
                    
                    library:create( "UICorner" , {
                        Parent = items[ "toggle_outline" ];
                        CornerRadius = dim(0, 999)
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))};
                        Parent = items[ "toggle_outline" ]
                    });
                    
                    items[ "toggle_circle" ] = library:create( "Frame" , {
                        Parent = items[ "toggle_outline" ];
                        Name = "\0";
                        Position = dim2(0, 2, 0, 2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 12, 0, 12);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(86, 86, 88)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "toggle_circle" ];
                        CornerRadius = dim(0, 999)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "outline" ];
                        CornerRadius = dim(0, 7)
                    });
                
                    items[ "fade" ] = library:create( "Frame" , {
                        Parent = items[ "outline" ];
                        BackgroundTransparency = 0.800000011920929;
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "fade" ];
                        CornerRadius = dim(0, 7)
                    });
                end 
            end;

            if cfg.fading_toggle then
                items[ "button" ].MouseButton1Click:Connect(function()
                    cfg.default = not cfg.default 
                    cfg.toggle_section(cfg.default) 
                end)

                function cfg.toggle_section(bool)
                    library:tween(items[ "toggle" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(58, 58, 62)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "toggle_outline" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(50, 50, 50)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "toggle_circle" ], {BackgroundColor3 = bool and rgb(255, 255, 255) or rgb(86, 86, 88), Position = bool and dim2(1, -14, 0, 2) or dim2(0, 2, 0, 2)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "fade" ], {BackgroundTransparency = bool and 1 or 0.8}, Enum.EasingStyle.Quad)
                end 
            end 

            return setmetatable(cfg, library)
        end  

        function library:toggle(options) 
            local rand = math.random(1, 2) 
            local cfg = {
                enabled = options.enabled or nil,
                name = options.name or "Toggle",
                info = options.info or nil,
                flag = options.flag or library:next_flag(),
                
                type = options.type and string.lower(options.type) or rand == 1 and "toggle" or "checkbox"; -- "toggle", "checkbox"

                default = options.default or false,
                folding = options.folding or false, 
                callback = options.callback or function() end,

                items = {};
                seperator = options.seperator or options.Seperator or false;
            }

            flags[cfg.flag] = cfg.default

            local items = cfg.items; do
                items[ "toggle" ] = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "toggle" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                if cfg.info then 
                    items[ "info" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(130, 130, 130);
                        BorderColor3 = rgb(0, 0, 0);
                        TextWrapped = true;
                        Text = cfg.info;
                        Parent = items[ "toggle" ];
                        Name = "\0";
                        Position = dim2(0, 5, 0, 17);
                        Size = dim2(1, -10, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                end 
                
                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                items[ "right_components" ] = library:create( "Frame" , {
                    Parent = items[ "toggle" ];
                    Name = "\0";
                    Position = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    Parent = items[ "right_components" ];
                    Padding = dim(0, 9);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                -- Toggle
                    if cfg.type == "checkbox" then 
                        items[ "toggle_button" ] = library:create( "TextButton" , {
                            FontFace = fonts.small;
                            TextColor3 = rgb(0, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = "";
                            LayoutOrder = 2;
                            AutoButtonColor = false;
                            AnchorPoint = vec2(1, 0);
                            Parent = items[ "right_components" ];
                            Name = "\0";
                            Position = dim2(1, 0, 0, 0);
                            Size = dim2(0, 16, 0, 16);
                            BorderSizePixel = 0;
                            TextSize = 14;
                            BackgroundColor3 = rgb(67, 67, 68)
                        }); library:apply_theme(items[ "toggle_button" ], "accent", "BackgroundColor3");
                        
                        library:create( "UICorner" , {
                            Parent = items[ "toggle_button" ];
                            CornerRadius = dim(0, 4)
                        });
                        
                        items[ "outline" ] = library:create( "Frame" , {
                            Parent = items[ "toggle_button" ];
                            Size = dim2(1, -2, 1, -2);
                            Name = "\0";
                            BorderMode = Enum.BorderMode.Inset;
                            BorderColor3 = rgb(0, 0, 0);
                            Position = dim2(0, 1, 0, 1);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(22, 22, 24)
                        }); library:apply_theme(items[ "outline" ], "accent", "BackgroundColor3");
                        
                        items[ "tick" ] = library:create( "ImageLabel" , {
                            ImageTransparency = 1;
                            BorderColor3 = rgb(0, 0, 0);
                            Image = "rbxassetid://111862698467575";
                            BackgroundTransparency = 1;
                            Position = dim2(0, -1, 0, 0);
                            Parent = items[ "outline" ];
                            Size = dim2(1, 2, 1, 2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255);
                            ZIndex = 1;
                        });

                        library:create( "UICorner" , {
                            Parent = items[ "outline" ];
                            CornerRadius = dim(0, 4)
                        });
                        
                        library:create( "UIGradient" , {
                            Enabled = false;
                            Parent = items[ "outline" ];
                            Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))}
                        });  
                    else 
                        items[ "toggle_button" ] = library:create( "TextButton" , {
                            FontFace = fonts.font;
                            TextColor3 = rgb(0, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = "";
                            LayoutOrder = 2;
                            AnchorPoint = vec2(1, 0.5);
                            Parent = items[ "right_components" ];
                            Name = "\0";
                            Position = dim2(1, -9, 0.5, 0);
                            Size = dim2(0, 36, 0, 18);
                            BorderSizePixel = 0;
                            TextSize = 14;
                            BackgroundColor3 = themes.preset.accent
                        }); library:apply_theme(items[ "toggle_button" ], "accent", "BackgroundColor3");
                        
                        library:create( "UICorner" , {
                            Parent = items[ "toggle_button" ];
                            CornerRadius = dim(0, 999)
                        });
                        
                        items[ "inline" ] = library:create( "Frame" , {
                            Parent = items[ "toggle_button" ];
                            Size = dim2(1, -2, 1, -2);
                            Name = "\0";
                            BorderMode = Enum.BorderMode.Inset;
                            BorderColor3 = rgb(0, 0, 0);
                            Position = dim2(0, 1, 0, 1);
                            BorderSizePixel = 0;
                            BackgroundColor3 = themes.preset.accent
                        }); library:apply_theme(items[ "inline" ], "accent", "BackgroundColor3");
                        
                        library:create( "UICorner" , {
                            Parent = items[ "inline" ];
                            CornerRadius = dim(0, 999)
                        });
                        
                        library:create( "UIGradient" , {
                            Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))};
                            Parent = items[ "inline" ]
                        });
                        
                        items[ "circle" ] = library:create( "Frame" , {
                            Parent = items[ "inline" ];
                            Name = "\0";
                            Position = dim2(1, -14, 0, 2);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(0, 12, 0, 12);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        library:create( "UICorner" , {
                            Parent = items[ "circle" ];
                            CornerRadius = dim(0, 999)
                        });                        
                    end 
                --                
            end;
            
            function cfg.set(bool)
                if cfg.type == "checkbox" then 
                    library:tween(items[ "tick" ], {Rotation = bool and 0 or 45, ImageTransparency = bool and 0 or 1})
                    library:tween(items[ "toggle_button" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(67, 67, 68)})
                    library:tween(items[ "outline" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(22, 22, 24)})
                else
                    library:tween(items[ "toggle_button" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(58, 58, 62)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "inline" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(50, 50, 50)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "circle" ], {BackgroundColor3 = bool and rgb(255, 255, 255) or rgb(86, 86, 88), Position = bool and dim2(1, -14, 0, 2) or dim2(0, 2, 0, 2)}, Enum.EasingStyle.Quad)
                end

                cfg.callback(bool)

                if cfg.folding then 
                    elements.Visible = bool
                end

                flags[cfg.flag] = bool
            end 
            
            items[ "toggle" ].MouseButton1Click:Connect(function()
                cfg.enabled = not cfg.enabled 
                cfg.set(cfg.enabled)
            end)

            items[ "toggle_button" ].MouseButton1Click:Connect(function()
                cfg.enabled = not cfg.enabled 
                cfg.set(cfg.enabled)
            end)
            
            if cfg.seperator then -- ok bro my lua either sucks or this was a pain in the ass to make (simple if statement aswell 💔)
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = self.items[ "elements" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
            end

            cfg.set(cfg.default)

            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end 
        
        function library:slider(options) 
            local cfg = {
                name = options.name or nil,
                suffix = options.suffix or "",
                flag = options.flag or library:next_flag(),
                callback = options.callback or function() end, 
                info = options.info or nil; 

                -- value settings
                min = options.min or options.minimum or 0,
                max = options.max or options.maximum or 100,
                intervals = options.interval or options.decimal or 1,
                default = options.default or 10,
                value = options.default or 10, 
                seperator = options.seperator or options.Seperator or true;

                dragging = false,
                items = {}
            } 

            flags[cfg.flag] = cfg.default

            local items = cfg.items; do
                items[ "slider_object" ] = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "slider_object" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                if cfg.info then 
                    items[ "info" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(130, 130, 130);
                        BorderColor3 = rgb(0, 0, 0);
                        TextWrapped = true;
                        Text = cfg.info;
                        Parent = items[ "slider_object" ];
                        Name = "\0";
                        Position = dim2(0, 5, 0, 37);
                        Size = dim2(1, -10, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                end 

                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                items[ "right_components" ] = library:create( "Frame" , {
                    Parent = items[ "slider_object" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 4, 0, 23);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 12);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "right_components" ];
                    Padding = dim(0, 7);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Horizontal
                });
                
                items[ "slider" ] = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    AutoButtonColor = false;
                    AnchorPoint = vec2(1, 0);
                    Parent = items[ "right_components" ];
                    Name = "\0";
                    Position = dim2(1, 0, 0, 0);
                    Size = dim2(1, -4, 0, 4);
                    BorderSizePixel = 0;
                    TextSize = 14;
                    BackgroundColor3 = rgb(33, 33, 35)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "slider" ];
                    CornerRadius = dim(0, 999)
                });
                
                items[ "fill" ] = library:create( "Frame" , {
                    Name = "\0";
                    Parent = items[ "slider" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0.5, 0, 0, 4);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                });  library:apply_theme(items[ "fill" ], "accent", "BackgroundColor3");
                
                library:create( "UICorner" , {
                    Parent = items[ "fill" ];
                    CornerRadius = dim(0, 999)
                });
                
                items[ "circle" ] = library:create( "Frame" , {
                    AnchorPoint = vec2(0.5, 0.5);
                    Parent = items[ "fill" ];
                    Name = "\0";
                    Position = dim2(1, 0, 0.5, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 12, 0, 12);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(244, 244, 244)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "circle" ];
                    CornerRadius = dim(0, 999)
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "right_components" ];
                    PaddingTop = dim(0, 4)
                });
                
                items[ "value" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(72, 72, 73);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "50%";
                    Parent = items[ "slider_object" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    Position = dim2(0, 6, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Right;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "value" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });                
            end 

            function cfg.set(value)
                cfg.value = clamp(library:round(value, cfg.intervals), cfg.min, cfg.max)

                library:tween(items[ "fill" ], {Size = dim2((cfg.value - cfg.min) / (cfg.max - cfg.min), cfg.value == cfg.min and 0 or -4, 0, 2)}, Enum.EasingStyle.Linear, 0.05)
                items[ "value" ].Text = tostring(cfg.value) .. cfg.suffix

                flags[cfg.flag] = cfg.value
                cfg.callback(flags[cfg.flag])
            end

            items[ "slider" ].MouseButton1Down:Connect(function()
                cfg.dragging = true 
                library:tween(items[ "value" ], {TextColor3 = rgb(255, 255, 255)}, Enum.EasingStyle.Quad, 0.2)
            end)

            library:connection(uis.InputChanged, function(input)
                if cfg.dragging and input.UserInputType == Enum.UserInputType.MouseMovement then 
                    local size_x = (input.Position.X - items[ "slider" ].AbsolutePosition.X) / items[ "slider" ].AbsoluteSize.X
                    local value = ((cfg.max - cfg.min) * size_x) + cfg.min
                    cfg.set(value)
                end
            end)

            library:connection(uis.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    cfg.dragging = false
                    library:tween(items[ "value" ], {TextColor3 = rgb(72, 72, 73)}, Enum.EasingStyle.Quad, 0.2) 
                end 
            end)

            if cfg.seperator then 
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = self.items[ "elements" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
            end 

            cfg.set(cfg.default)
            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end 

        function library:dropdown(options) 
            local cfg = {
                name = options.name or nil;
                info = options.info or nil;
                flag = options.flag or library:next_flag();
                options = options.items or {""};
                callback = options.callback or function() end;
                multi = options.multi or false;
                scrolling = options.scrolling or false;

                width = options.width or 130;

                -- Ignore these 
                open = false;
                option_instances = {};
                multi_items = {};
                ignore = options.ignore or false;
                items = {};
                y_size;
                seperator = options.seperator or options.Seperator or true;
            }   

            cfg.default = options.default or (cfg.multi and {cfg.items[1]}) or cfg.items[1] or "None"
            flags[cfg.flag] = cfg.default

            local items = cfg.items; do 
                -- Element
                    items[ "dropdown_object" ] = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = self.items[ "elements" ];
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    items[ "name" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(245, 245, 245);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "Dropdown";
                        Parent = items[ "dropdown_object" ];
                        Name = "\0";
                        Size = dim2(1, 0, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    if cfg.info then 
                        items[ "info" ] = library:create( "TextLabel" , {
                            FontFace = fonts.small;
                            TextColor3 = rgb(130, 130, 130);
                            BorderColor3 = rgb(0, 0, 0);
                            TextWrapped = true;
                            Text = cfg.info;
                            Parent = items[ "dropdown_object" ];
                            Name = "\0";
                            Position = dim2(0, 5, 0, 17);
                            Size = dim2(1, -10, 0, 0);
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            TextSize = 16;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                    end 

                    library:create( "UIPadding" , {
                        Parent = items[ "name" ];
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    items[ "right_components" ] = library:create( "Frame" , {
                        Parent = items[ "dropdown_object" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalAlignment = Enum.HorizontalAlignment.Right;
                        Parent = items[ "right_components" ];
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    items[ "dropdown" ] = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 0);
                        Parent = items[ "right_components" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        Size = dim2(0, cfg.width, 0, 16);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(33, 33, 35)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "dropdown" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    items[ "sub_text" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(86, 86, 87);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "awdawdawdawdawdawdawdaw";
                        Parent = items[ "dropdown" ];
                        Name = "\0";
                        Size = dim2(1, -12, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        TextTruncate = Enum.TextTruncate.AtEnd;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "sub_text" ];
                        PaddingTop = dim(0, 1);
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    items[ "indicator" ] = library:create( "ImageLabel" , {
                        ImageColor3 = rgb(86, 86, 87);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = items[ "dropdown" ];
                        AnchorPoint = vec2(1, 0.5);
                        Image = "rbxassetid://101025591575185";
                        BackgroundTransparency = 1;
                        Position = dim2(1, -5, 0.5, 0);
                        Name = "\0";
                        Size = dim2(0, 12, 0, 12);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                -- 

                -- Element Holder
                    items[ "dropdown_holder" ] = library:create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = library[ "items" ];
                        Name = "\0";
                        Visible = true;
                        BackgroundTransparency = 1;
                        Size = dim2(0, 0, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0);
                        ZIndex = 10;
                    });
                    
                    items[ "outline" ] = library:create( "Frame" , {
                        Parent = items[ "dropdown_holder" ];
                        Size = dim2(1, 0, 1, 0);
                        ClipsDescendants = true;
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(33, 33, 35);
                        ZIndex = 10;
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingBottom = dim(0, 6);
                        PaddingTop = dim(0, 3);
                        PaddingLeft = dim(0, 3);
                        Parent = items[ "outline" ]
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "outline" ];
                        Padding = dim(0, 5);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "outline" ];
                        CornerRadius = dim(0, 4)
                    });
                -- 
            end 

            function cfg.render_option(text)
                local button = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(72, 72, 73);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = text;
                    Parent = items[ "outline" ];
                    Name = "\0";
                    Size = dim2(1, -12, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255);
                    ZIndex = 10;
                }); library:apply_theme(button, "accent", "TextColor3");
                
                library:create( "UIPadding" , {
                    Parent = button;
                    PaddingTop = dim(0, 1);
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                return button
            end
            
            function cfg.set_visible(bool)
                local a = bool and cfg.y_size or 0
                library:tween(items[ "dropdown_holder" ], {Size = dim_offset(items[ "dropdown" ].AbsoluteSize.X, a)})

                items[ "dropdown_holder" ].Position = dim2(0, items[ "dropdown" ].AbsolutePosition.X, 0, items[ "dropdown" ].AbsolutePosition.Y + 80)
                if not (self.sanity and library.current_open == self) then 
                    library:close_element(cfg)
                end
            end
            
            function cfg.set(value)
                local selected = {}
                local isTable = type(value) == "table"

                for _, option in cfg.option_instances do 
                    if option.Text == value or (isTable and find(value, option.Text)) then 
                        insert(selected, option.Text)
                        cfg.multi_items = selected
                        option.TextColor3 = themes.preset.accent
                    else
                        option.TextColor3 = rgb(72, 72, 73)
                    end
                end

                items[ "sub_text" ].Text = isTable and concat(selected, ", ") or selected[1] or ""
                flags[cfg.flag] = isTable and selected or selected[1]
                
                cfg.callback(flags[cfg.flag]) 
            end
            
            function cfg.refresh_options(list) 
                cfg.y_size = 0

                for _, option in cfg.option_instances do 
                    option:Destroy() 
                end
                
                cfg.option_instances = {} 

                for _, option in list do 
                    local button = cfg.render_option(option)
                    cfg.y_size += button.AbsoluteSize.Y + 6 -- super annoying manual sizing but oh well
                    insert(cfg.option_instances, button)
                    
                    button.MouseButton1Down:Connect(function()
                        if cfg.multi then 
                            local selected_index = find(cfg.multi_items, button.Text)
                            
                            if selected_index then 
                                remove(cfg.multi_items, selected_index)
                            else
                                insert(cfg.multi_items, button.Text)
                            end
                            
                            cfg.set(cfg.multi_items) 				
                        else 
                            cfg.set_visible(false)
                            cfg.open = false 
                            
                            cfg.set(button.Text)
                        end
                    end)
                end
            end

            items[ "dropdown" ].MouseButton1Click:Connect(function()
                cfg.open = not cfg.open 
                
                cfg.set_visible(cfg.open)
            end)

            if cfg.seperator then 
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = self.items[ "elements" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
            end 

            flags[cfg.flag] = {} 
            config_flags[cfg.flag] = cfg.set
            
            cfg.refresh_options(cfg.options)
            cfg.set(cfg.default)
                
            return setmetatable(cfg, library)
        end

        function library:label(options)
            local cfg = {
                enabled = options.enabled or nil,
                name = options.name or "Toggle",
                seperator = options.seperator or options.Seperator or false;
                info = options.info or nil; 

                items = {};
            }

            local items = cfg.items; do 
                items[ "label" ] = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "label" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                if cfg.info then 
                    items[ "info" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(130, 130, 130);
                        BorderColor3 = rgb(0, 0, 0);
                        TextWrapped = true;
                        Text = cfg.info;
                        Parent = items[ "label" ];
                        Name = "\0";
                        Position = dim2(0, 5, 0, 17);
                        Size = dim2(1, -10, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                end 
                
                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                items[ "right_components" ] = library:create( "Frame" , {
                    Parent = items[ "label" ];
                    Name = "\0";
                    Position = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    Parent = items[ "right_components" ];
                    Padding = dim(0, 9);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });                
            end 

            if cfg.seperator then 
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = self.items[ "elements" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
            end 

            return setmetatable(cfg, library)
        end 
        
        function library:colorpicker(options) 
            local cfg = {
                name = options.name or "Color", 
                flag = options.flag or library:next_flag(),

                color = options.color or color(1, 1, 1), -- Default to white color if not provided
                alpha = options.alpha and 1 - options.alpha or 0,
                
                open = false, 
                callback = options.callback or function() end,
                items = {};

                seperator = options.seperator or options.Seperator or false;
            }

            local dragging_sat = false 
            local dragging_hue = false 
            local dragging_alpha = false 

            local h, s, v = cfg.color:ToHSV() 
            local a = cfg.alpha 

            flags[cfg.flag] = {Color = cfg.color, Transparency = cfg.alpha}

            local label; 
            if not self.items.right_components then 
                label = self:label({name = cfg.name, seperator = cfg.seperator})
            end

            local items = cfg.items; do 
                -- Component
                    items[ "colorpicker" ] = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 0);
                        Parent = label and label.items.right_components or self.items[ "right_components" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        Size = dim2(0, 16, 0, 16);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(54, 31, 184)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "colorpicker" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    items[ "colorpicker_inline" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker" ];
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        BorderMode = Enum.BorderMode.Inset;
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(0, 1, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(54, 31, 184)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "colorpicker_inline" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))};
                        Parent = items[ "colorpicker_inline" ]
                    });         
                --
                
                -- Colorpicker
                    items[ "colorpicker_holder" ] = library:create( "Frame" , {
                        Parent = library[ "other" ];
                        Name = "\0";
                        Position = dim2(0.20000000298023224, 20, 0.296999990940094, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 166, 0, 197);
                        BorderSizePixel = 0;
                        Visible = true;
                        BackgroundColor3 = rgb(25, 25, 29)
                    });

                    items[ "colorpicker_fade" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker_holder" ];
                        Name = "\0";
                        BackgroundTransparency = 0;
                        Position = dim2(0, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        ZIndex = 100;
                        BackgroundColor3 = rgb(25, 25, 29)
                    });
                    
                    items[ "colorpicker_components" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker_holder" ];
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(22, 22, 24)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "colorpicker_components" ];
                        CornerRadius = dim(0, 6)
                    });
                    
                    items[ "saturation_holder" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker_components" ];
                        Name = "\0";
                        Position = dim2(0, 7, 0, 7);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -14, 1, -80);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 39, 39)
                    });
                    
                    items[ "sat" ] = library:create( "TextButton" , {
                        Parent = items[ "saturation_holder" ];
                        Name = "\0";
                        Size = dim2(1, 0, 1, 0);
                        Text = "";
                        AutoButtonColor = false;
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "sat" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    library:create( "UIGradient" , {
                        Rotation = 270;
                        Transparency = numseq{numkey(0, 0), numkey(1, 1)};
                        Parent = items[ "sat" ];
                        Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(0, 0, 0))}
                    });
                    
                    items[ "val" ] = library:create( "Frame" , {
                        Name = "\0";
                        Parent = items[ "saturation_holder" ];
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIGradient" , {
                        Parent = items[ "val" ];
                        Transparency = numseq{numkey(0, 0), numkey(1, 1)}
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "val" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "saturation_holder" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    items[ "satvalpicker" ] = library:create( "TextButton" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AutoButtonColor = false;
                        Text = "";
                        AnchorPoint = vec2(0, 1);
                        Parent = items[ "saturation_holder" ];
                        Name = "\0";
                        Position = dim2(0, 0, 4, 0);
                        Size = dim2(0, 8, 0, 8);
                        ZIndex = 5;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 0, 0)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "satvalpicker" ];
                        CornerRadius = dim(0, 9999)
                    });
                    
                    library:create( "UIStroke" , {
                        Color = rgb(255, 255, 255);
                        Parent = items[ "satvalpicker" ];
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    });
                    
                    items[ "hue_gradient" ] = library:create( "TextButton" , {
                        Parent = items[ "colorpicker_components" ];
                        Name = "\0";
                        Position = dim2(0, 10, 1, -64);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -20, 0, 8);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255);
                        AutoButtonColor = false;
                        Text = "";
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(255, 0, 0)), rgbkey(0.17, rgb(255, 255, 0)), rgbkey(0.33, rgb(0, 255, 0)), rgbkey(0.5, rgb(0, 255, 255)), rgbkey(0.67, rgb(0, 0, 255)), rgbkey(0.83, rgb(255, 0, 255)), rgbkey(1, rgb(255, 0, 0))};
                        Parent = items[ "hue_gradient" ]
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "hue_gradient" ];
                        CornerRadius = dim(0, 6)
                    });
                    
                    items[ "hue_picker" ] = library:create( "TextButton" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AutoButtonColor = false;
                        Text = "";
                        AnchorPoint = vec2(0, 0.5);
                        Parent = items[ "hue_gradient" ];
                        Name = "\0";
                        Position = dim2(0, 0, 0.5, 0);
                        Size = dim2(0, 8, 0, 8);
                        ZIndex = 5;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 0, 0)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "hue_picker" ];
                        CornerRadius = dim(0, 9999)
                    });
                    
                    library:create( "UIStroke" , {
                        Color = rgb(255, 255, 255);
                        Parent = items[ "hue_picker" ];
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    });
                    
                    items[ "alpha_gradient" ] = library:create( "TextButton" , {
                        Parent = items[ "colorpicker_components" ];
                        Name = "\0";
                        Position = dim2(0, 10, 1, -46);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -20, 0, 8);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(25, 25, 29);
                        AutoButtonColor = false;
                        Text = "";
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "alpha_gradient" ];
                        CornerRadius = dim(0, 6)
                    });
                    
                    items[ "alpha_picker" ] = library:create( "TextButton" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AutoButtonColor = false;
                        Text = "";
                        AnchorPoint = vec2(0, 0.5);
                        Parent = items[ "alpha_gradient" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0.5, 0);
                        Size = dim2(0, 8, 0, 8);
                        ZIndex = 5;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 0, 0)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "alpha_picker" ];
                        CornerRadius = dim(0, 9999)
                    });
                    
                    library:create( "UIStroke" , {
                        Color = rgb(255, 255, 255);
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                        Parent = items[ "alpha_picker" ]
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(255, 255, 255))};
                        Parent = items[ "alpha_gradient" ]
                    });
                    
                    items[ "alpha_indicator" ] = library:create( "ImageLabel" , {
                        ScaleType = Enum.ScaleType.Tile;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = items[ "alpha_gradient" ];
                        Image = "rbxassetid://18274452449";
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Size = dim2(1, 0, 1, 0);
                        TileSize = dim2(0, 6, 0, 6);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(112, 112, 112)), rgbkey(1, rgb(255, 0, 0))};
                        Transparency = numseq{numkey(0, 0.8062499761581421), numkey(1, 0)};
                        Parent = items[ "alpha_indicator" ]
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "alpha_indicator" ];
                        CornerRadius = dim(0, 6)
                    });
                    
                    library:create( "UIGradient" , {
                        Rotation = 90;
                        Parent = items[ "colorpicker_components" ];
                        Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(66, 66, 66))}
                    });

                    items[ "input" ] = library:create( "TextBox" , {
                        FontFace = fonts.font;
                        AnchorPoint = vec2(1, 1);
                        Text = "";
                        Parent = items[ "colorpicker_components" ];
                        Name = "\0";
                        TextTruncate = Enum.TextTruncate.AtEnd;
                        BorderSizePixel = 0;
                        PlaceholderColor3 = rgb(255, 255, 255);
                        CursorPosition = -1;
                        ClearTextOnFocus = false;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255);
                        TextColor3 = rgb(72, 72, 72);
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(1, -8, 1, -11);
                        Size = dim2(1, -16, 0, 18);
                        BackgroundColor3 = rgb(33, 33, 35)
                    }); 
                    
                    library:create( "UICorner" , {
                        Parent = items[ "input" ];
                        CornerRadius = dim(0, 3)
                    });
                    
                    items[ "UICorenr" ] = library:create( "UICorner" , { -- fire misstypo (im not fixing this RAWR)
                        Parent = items[ "colorpicker_holder" ];
                        Name = "\0";
                        CornerRadius = dim(0, 4)
                    });
                --                  
            end;

            function cfg.set_visible(bool)
                items[ "colorpicker_fade" ].BackgroundTransparency = 0
                items[ "colorpicker_holder" ].Parent = bool and library[ "items" ] or library[ "other" ]
                items[ "colorpicker_holder" ].Position = dim_offset(items[ "colorpicker" ].AbsolutePosition.X, items[ "colorpicker" ].AbsolutePosition.Y + items[ "colorpicker" ].AbsoluteSize.Y + 45)

                library:tween(items[ "colorpicker_fade" ], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
                library:tween(items[ "colorpicker_holder" ], {Position = items[ "colorpicker_holder" ].Position + dim_offset(0, 20)}) -- p100 check
                
                if not (self.sanity and library.current_open == self and self.open) then 
                    library:close_element(cfg)
                end
            end

            function cfg.set(color, alpha)
                if type(color) == "boolean" then 
                    return
                end 

                if color then 
                    h, s, v = color:ToHSV()
                end
                
                if alpha then 
                    a = alpha
                end 
                
                local Color = hsv(h, s, v)

                -- Ok so quick story, should I cache any of this? no...?? anyways I know this code is very bad but its your fault for buying a ui with animations (on a serious note im too lazy to make this look nice)
                -- Also further note, yeah I kind of did this scale_factor * size-valuesize.plane because then I would have to do tomfoolery to make it clip properly.
                library:tween(items[ "hue_picker" ], {Position = dim2(0, (items[ "hue_gradient" ].AbsoluteSize.X - items[ "hue_picker" ].AbsoluteSize.X) * h, 0.5, 0)}, Enum.EasingStyle.Linear, 0.05)
                library:tween(items[ "alpha_picker" ], {Position = dim2(0, (items[ "alpha_gradient" ].AbsoluteSize.X - items[ "alpha_picker" ].AbsoluteSize.X) * (1 - a), 0.5, 0)}, Enum.EasingStyle.Linear, 0.05)
                library:tween(items[ "satvalpicker" ], {Position = dim2(0, s * (items[ "saturation_holder" ].AbsoluteSize.X - items[ "satvalpicker" ].AbsoluteSize.X), 1, 1 - v * (items[ "saturation_holder" ].AbsoluteSize.Y - items[ "satvalpicker" ].AbsoluteSize.Y))}, Enum.EasingStyle.Linear, 0.05)

                items[ "alpha_indicator" ]:FindFirstChildOfClass("UIGradient").Color = rgbseq{rgbkey(0, rgb(112, 112, 112)), rgbkey(1, hsv(h, 1, 1))}; -- shit code
                
                items[ "colorpicker" ].BackgroundColor3 = Color
                items[ "colorpicker_inline" ].BackgroundColor3 = Color
                items[ "saturation_holder" ].BackgroundColor3 = hsv(h, 1, 1)

                items[ "hue_picker" ].BackgroundColor3 = hsv(h, 1, 1)
                items[ "alpha_picker" ].BackgroundColor3 = hsv(h, 1, 1 - a)
                items[ "satvalpicker" ].BackgroundColor3 = hsv(h, s, v)

                flags[cfg.flag] = {
                    Color = Color;
                    Transparency = a 
                }
                
                local color = items[ "colorpicker" ].BackgroundColor3
                items[ "input" ].Text = string.format("%s, %s, %s, ", library:round(color.R * 255), library:round(color.G * 255), library:round(color.B * 255))
                items[ "input" ].Text ..= library:round(1 - a, 0.01)
                
                cfg.callback(Color, a)
            end
            
            function cfg.update_color() 
                local mouse = uis:GetMouseLocation() 
                local offset = vec2(mouse.X, mouse.Y - gui_offset) 

                if dragging_sat then	
                    s = math.clamp((offset - items["sat"].AbsolutePosition).X / items["sat"].AbsoluteSize.X, 0, 1)
                    v = 1 - math.clamp((offset - items["sat"].AbsolutePosition).Y / items["sat"].AbsoluteSize.Y, 0, 1)
                elseif dragging_hue then
                    h = math.clamp((offset - items[ "hue_gradient" ].AbsolutePosition).X / items[ "hue_gradient" ].AbsoluteSize.X, 0, 1)
                elseif dragging_alpha then
                    a = 1 - math.clamp((offset - items[ "alpha_gradient" ].AbsolutePosition).X / items[ "alpha_gradient" ].AbsoluteSize.X, 0, 1)
                end

                cfg.set()
            end

            items[ "colorpicker" ].MouseButton1Click:Connect(function()
                cfg.open = not cfg.open 

                cfg.set_visible(cfg.open)            
            end)

            uis.InputChanged:Connect(function(input)
                if (dragging_sat or dragging_hue or dragging_alpha) and input.UserInputType == Enum.UserInputType.MouseMovement then
                    cfg.update_color() 
                end
            end)

            library:connection(uis.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging_sat = false
                    dragging_hue = false
                    dragging_alpha = false
                end
            end)    

            items[ "alpha_gradient" ].MouseButton1Down:Connect(function()
                dragging_alpha = true 
            end)
            
            items[ "hue_gradient" ].MouseButton1Down:Connect(function()
                dragging_hue = true 
            end)
            
            items[ "sat" ].MouseButton1Down:Connect(function()
                dragging_sat = true  
            end)

            items[ "input" ].FocusLost:Connect(function()
                local text = items[ "input" ].Text
                local r, g, b, a = library:convert(text)
                
                if r and g and b and a then 
                    cfg.set(rgb(r, g, b), 1 - a)
                end 
            end)

            items[ "input" ].Focused:Connect(function()
                library:tween(items[ "input" ], {TextColor3 = rgb(245, 245, 245)})
            end)

            items[ "input" ].FocusLost:Connect(function()
                library:tween(items[ "input" ], {TextColor3 = rgb(72, 72, 72)})
            end)
            
            cfg.set(cfg.color, cfg.alpha)
            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end 

        function library:textbox(options) 
            local cfg = {
                name = options.name or "TextBox",
                placeholder = options.placeholder or options.placeholdertext or options.holder or options.holdertext or "type here...",
                default = options.default or "",
                flag = options.flag or library:next_flag(),
                callback = options.callback or function() end,
                visible = options.visible or true,
                items = {};
            }

            flags[cfg.flag] = cfg.default

            local items = cfg.items; do 
                items[ "textbox" ] = library:create( "TextButton" , {
                    LayoutOrder = -1;
                    FontFace = fonts.font;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "textbox" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                items[ "right_components" ] = library:create( "Frame" , {
                    Parent = items[ "textbox" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 4, 0, 19);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 12);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "right_components" ];
                    Padding = dim(0, 7);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Horizontal
                });
                
                items[ "input" ] = library:create( "TextBox" , {
                    FontFace = fonts.font;
                    Text = "";
                    Parent = items[ "right_components" ];
                    Name = "\0";
                    TextTruncate = Enum.TextTruncate.AtEnd;
                    BorderSizePixel = 0;
                    PlaceholderColor3 = rgb(255, 255, 255);
                    CursorPosition = -1;
                    ClearTextOnFocus = false;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255);
                    TextColor3 = rgb(72, 72, 72);
                    BorderColor3 = rgb(0, 0, 0);
                    Position = dim2(1, 0, 0, 0);
                    Size = dim2(1, -4, 0, 30);
                    BackgroundColor3 = rgb(33, 33, 35)
                }); 

                library:create( "UICorner" , {
                    Parent = items[ "input" ];
                    CornerRadius = dim(0, 3)
                });                
                
                library:create( "UIPadding" , {
                    Parent = items[ "right_components" ];
                    PaddingTop = dim(0, 4);
                    PaddingRight = dim(0, 4)
                });
            end 
            
            function cfg.set(text) 
                flags[cfg.flag] = text

                items[ "input" ].Text = text

                cfg.callback(text)
            end 
            
            items[ "input" ]:GetPropertyChangedSignal("Text"):Connect(function()
                cfg.set(items[ "input" ].Text) 
            end)

            items[ "input" ].Focused:Connect(function()
                library:tween(items[ "input" ], {TextColor3 = rgb(245, 245, 245)})
            end)

            items[ "input" ].FocusLost:Connect(function()
                library:tween(items[ "input" ], {TextColor3 = rgb(72, 72, 72)})
            end)
                
            if cfg.default then 
                cfg.set(cfg.default) 
            end

            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end

        function library:keybind(options) 
            local cfg = {
                flag = options.flag or library:next_flag(),
                callback = options.callback or function() end,
                name = options.name or nil, 
                ignore_key = options.ignore or false, 

                key = options.key or nil, 
                mode = options.mode or "Toggle",
                active = options.default or false, 

                open = false,
                binding = nil, 

                hold_instances = {},
                items = {};
            }

            flags[cfg.flag] = {
                mode = cfg.mode,
                key = cfg.key, 
                active = cfg.active
            }

            local items = cfg.items; do 
                -- Component
                    items[ "keybind_element" ] = library:create( "TextButton" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = self.items[ "elements" ];
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    items[ "name" ] = library:create( "TextLabel" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(245, 245, 245);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = cfg.name;
                        Parent = items[ "keybind_element" ];
                        Name = "\0";
                        Size = dim2(1, 0, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "name" ];
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    items[ "right_components" ] = library:create( "Frame" , {
                        Parent = items[ "keybind_element" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalAlignment = Enum.HorizontalAlignment.Right;
                        Parent = items[ "right_components" ];
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    items[ "keybind_holder" ] = library:create( "TextButton" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = items[ "right_components" ];
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 0);
                        Size = dim2(0, 0, 0, 16);
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        TextSize = 14;
                        BackgroundColor3 = rgb(33, 33, 35)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "keybind_holder" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    items[ "key" ] = library:create( "TextLabel" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(86, 86, 87);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "LSHIFT";
                        Parent = items[ "keybind_holder" ];
                        Name = "\0";
                        Size = dim2(1, -12, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "key" ];
                        PaddingTop = dim(0, 1);
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });                                  
                -- 
                
                -- Mode Holder
                    items[ "dropdown" ] = library:create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = library.items;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 0, 0);
                        Size = dim2(0, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    items[ "inline" ] = library:create( "Frame" , {
                        Parent = items[ "dropdown" ];
                        Size = dim2(1, 0, 1, 0);
                        Name = "\0";
                        ClipsDescendants = true;
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(22, 22, 24)
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingBottom = dim(0, 6);
                        PaddingTop = dim(0, 3);
                        PaddingLeft = dim(0, 3);
                        Parent = items[ "inline" ]
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "inline" ];
                        Padding = dim(0, 5);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "inline" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    local options = {"Hold", "Toggle", "Always"}
                    
                    cfg.y_size = 20
                    for _, option in options do                        
                        local name = library:create( "TextButton" , {
                            FontFace = fonts.font;
                            TextColor3 = rgb(72, 72, 73);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = option;
                            Parent = items[ "inline" ];
                            Name = "\0";
                            Size = dim2(0, 0, 0, 0);
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            TextSize = 14;
                            BackgroundColor3 = rgb(255, 255, 255)
                        }); cfg.hold_instances[option] = name
                        library:apply_theme(name, "accent", "TextColor3")
                        
                        cfg.y_size += name.AbsoluteSize.Y

                        library:create( "UIPadding" , {
                            Parent = name;
                            PaddingTop = dim(0, 1);
                            PaddingRight = dim(0, 5);
                            PaddingLeft = dim(0, 5)
                        });

                        name.MouseButton1Click:Connect(function()
                            cfg.set(option)

                            cfg.set_visible(false)

                            cfg.open = false
                        end)
                    end
                -- 
            end 
            
            function cfg.modify_mode_color(path) -- ts so frikin tuff 💀
                for _, v in cfg.hold_instances do 
                    v.TextColor3 = rgb(72, 72, 72)
                end 

                cfg.hold_instances[path].TextColor3 = themes.preset.accent
            end

            function cfg.set_mode(mode) 
                cfg.mode = mode 

                if mode == "Always" then
                    cfg.set(true)
                elseif mode == "Hold" then
                    cfg.set(false)
                end

                flags[cfg.flag]["mode"] = mode
                cfg.modify_mode_color(mode)
            end 

            function cfg.set(input)
                if type(input) == "boolean" then 
                    cfg.active = input

                    if cfg.mode == "Always" then 
                        cfg.active = true
                    end
                elseif tostring(input):find("Enum") then 
                    input = input.Name == "Escape" and "NONE" or input
                    
                    cfg.key = input or "NONE"	
                elseif find({"Toggle", "Hold", "Always"}, input) then 
                    if input == "Always" then 
                        cfg.active = true 
                    end 

                    cfg.mode = input
                    cfg.set_mode(cfg.mode) 
                elseif type(input) == "table" then 
                    input.key = type(input.key) == "string" and input.key ~= "NONE" and library:convert_enum(input.key) or input.key
                    input.key = input.key == Enum.KeyCode.Escape and "NONE" or input.key

                    cfg.key = input.key or "NONE"
                    cfg.mode = input.mode or "Toggle"

                    if input.active then
                        cfg.active = input.active
                    end

                    cfg.set_mode(cfg.mode) 
                end 

                cfg.callback(cfg.active)

                local text = tostring(cfg.key) ~= "Enums" and (keys[cfg.key] or tostring(cfg.key):gsub("Enum.", "")) or nil
                local __text = text and (tostring(text):gsub("KeyCode.", ""):gsub("UserInputType.", ""))
                
                items[ "key" ].Text = __text

                flags[cfg.flag] = {
                    mode = cfg.mode,
                    key = cfg.key, 
                    active = cfg.active
                }
            end

            function cfg.set_visible(bool)
                local size = bool and cfg.y_size or 0
                library:tween(items[ "dropdown" ], {Size = dim_offset(items[ "keybind_holder" ].AbsoluteSize.X, size)})

                items[ "dropdown" ].Position = dim_offset(items[ "keybind_holder" ].AbsolutePosition.X, items[ "keybind_holder" ].AbsolutePosition.Y + items[ "keybind_holder" ].AbsoluteSize.Y + 60)
            end
        
            items[ "keybind_holder" ].MouseButton1Down:Connect(function()
                task.wait()
                items[ "key" ].Text = "..."	

                cfg.binding = library:connection(uis.InputBegan, function(keycode, game_event)  
                    cfg.set(keycode.KeyCode ~= Enum.KeyCode.Unknown and keycode.KeyCode or keycode.UserInputType)
                    
                    cfg.binding:Disconnect() 
                    cfg.binding = nil
                end)
            end)

            items[ "keybind_holder" ].MouseButton2Down:Connect(function()
                cfg.open = not cfg.open 

                cfg.set_visible(cfg.open)
            end)

            library:connection(uis.InputBegan, function(input, game_event) 
                if not game_event then
                    local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType

                    if selected_key == cfg.key then 
                        if cfg.mode == "Toggle" then 
                            cfg.active = not cfg.active
                            cfg.set(cfg.active)
                        elseif cfg.mode == "Hold" then 
                            cfg.set(true)
                        end
                    end
                end
            end)    

            library:connection(uis.InputEnded, function(input, game_event) 
                if game_event then 
                    return 
                end 

                local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType
    
                if selected_key == cfg.key then
                    if cfg.mode == "Hold" then 
                        cfg.set(false)
                    end
                end
            end)
            
            cfg.set({mode = cfg.mode, active = cfg.active, key = cfg.key})           
            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end

        function library:button(options) 
            local cfg = {
                name = options.name or "TextBox",
                callback = options.callback or function() end,
                items = {};
            }
            
            local items = cfg.items; do 
                items[ "button_element" ] = library:create( "Frame" , {
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "button" ] = library:create( "TextButton" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    AutoButtonColor = false;
                    AnchorPoint = vec2(1, 0);
                    Parent = items[ "button_element" ];
                    Name = "\0";
                    Position = dim2(1, -4, 0, 0);
                    Size = dim2(1, -8, 0, 30);
                    BorderSizePixel = 0;
                    TextSize = 14;
                    BackgroundColor3 = rgb(33, 33, 35)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "button" ];
                    CornerRadius = dim(0, 3)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "button" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:apply_theme(items[ "name" ], "accent", "BackgroundColor3");                            
            end 

            items[ "button" ].MouseButton1Click:Connect(function()
                cfg.callback()

                items[ "name" ].TextColor3 = themes.preset.accent 
                library:tween(items[ "name" ], {TextColor3 = rgb(245, 245, 245)})
            end)
            
            return setmetatable(cfg, library)
        end 

        function library:settings(options)  
            local cfg = {
                open = false; 
                items = {}; 
                sanity = true; -- made this for my own sanity.
            }

            local items = cfg.items; do 
                items[ "outline" ] = library:create( "Frame" , {
                    Name = "\0";
                    Visible = true;
                    Parent = library[ "items" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 0, 0);
                    ClipsDescendants = true;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(25, 25, 29)
                });
                
                items[ "inline" ] = library:create( "Frame" , {
                    Parent = items[ "outline" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(22, 22, 24)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "inline" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "elements" ] = library:create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = items[ "inline" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 10, 0, 10);
                    Size = dim2(1, -20, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "elements" ];
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UIPadding" , {
                    PaddingBottom = dim(0, 15);
                    Parent = items[ "elements" ]
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "outline" ];
                    CornerRadius = dim(0, 7)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "fade" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "tick" ] = library:create( "ImageButton" , {
                    Image = "rbxassetid://128797200442698";
                    Name = "\0";
                    AutoButtonColor = false;
                    Parent = self.items[ "right_components" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 16, 0, 16);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });                
            end 

            function cfg.set_visible(bool)                 
                library:tween(items[ "outline" ], {Size = dim_offset(bool and 240 or 0, 0)})
                items[ "outline" ].Position = dim_offset(items[ "tick" ].AbsolutePosition.X, items[ "tick" ].AbsolutePosition.Y + 90)
                library:close_element(cfg)
            end
            
            items[ "tick" ].MouseButton1Click:Connect(function()
                cfg.open = not cfg.open

                cfg.set_visible(cfg.open)
            end)

            return setmetatable(cfg, library)
        end 

        function library:list(properties) 
            local cfg = {
                items = {};
                options = properties.options or {"1", "2", "3"};
                flag = properties.flag or library:next_flag();    
                callback = properties.callback or function() end;
                data_store = {};        
                current_element;
            }

            local items = cfg.items; do
                items[ "list" ] = library:create( "Frame" , {
                    Parent = self.items[ "elements" ];
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "list" ];
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "list" ];
                    PaddingRight = dim(0, 4);
                    PaddingLeft = dim(0, 4)
                });
            end 

            function cfg.refresh_options(options_to_refresh) -- ignore goofy parameter
                for _,option in cfg.data_store do 
                    option:Destroy()
                end

                for _, option_data in options_to_refresh do -- haha u skids no next >_<
                    local button = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 0);
                        Parent = items[ "list" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        Size = dim2(1, 0, 0, 30);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(33, 33, 35)
                    }); cfg.data_store[#cfg.data_store + 1] = button;

                    local name = library:create( "TextLabel" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(72, 72, 73);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = option_data;
                        Parent = button;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = button;
                        CornerRadius = dim(0, 3)
                    });     

                    button.MouseButton1Click:Connect(function()
                        local current = cfg.current_element 
                        if current and current ~= name then 
                            library:tween(current, {TextColor3 = rgb(72, 72, 72)})
                        end

                        flags[cfg.flag] = option_data
                        cfg.callback(option_data)
                        library:tween(name, {TextColor3 = rgb(245, 245, 245)})
                        cfg.current_element = name
                    end)

                    name.MouseEnter:Connect(function()
                        if cfg.current_element == name then 
                            return 
                        end 

                        library:tween(name, {TextColor3 = rgb(140, 140, 140)})
                    end)

                    name.MouseLeave:Connect(function()
                        if cfg.current_element == name then 
                            return 
                        end 

                        library:tween(name, {TextColor3 = rgb(72, 72, 72)})
                    end)
                end
            end

            cfg.refresh_options(cfg.options)

            return setmetatable(cfg, library)
        end 

        function library:init_config(window) 
            window:seperator({name = "Settings"})
            local main = window:tab({name = "Configs", tabs = {"Main"}})
            
            local column = main:column({})
            local section = column:section({name = "Configs", size = 1, default = true, icon = "rbxassetid://139628202576511"})
            config_holder = section:list({options = {"Report", "This", "Error", "To", "Finobe"}, callback = function(option) end, flag = "config_name_list"}); library:update_config_list()
            
            local column = main:column({})
            local section = column:section({name = "Settings", side = "right", size = 1, default = true, icon = "rbxassetid://129380150574313"})
            section:textbox({name = "Config name:", flag = "config_name_text"})
            section:button({name = "Save", callback = function() writefile(library.directory .. "/configs/" .. flags["config_name_text"] or flags["config_name_list"] .. ".cfg", library:get_config()) library:update_config_list() notifications:create_notification({name = "Configs", info = "Saved config to:\n" .. flags["config_name_list"] or flags["config_name_text"]}) end}) 
            section:button({name = "Load", callback = function() library:load_config(readfile(library.directory .. "/configs/" .. flags["config_name_list"] .. ".cfg"))  library:update_config_list() notifications:create_notification({name = "Configs", info = "Loaded config:\n" .. flags["config_name_list"]}) end})
            section:button({name = "Delete", callback = function() delfile(library.directory .. "/configs/" .. flags["config_name_list"] .. ".cfg")  library:update_config_list() notifications:create_notification({name = "Configs", info = "Deleted config:\n" .. flags["config_name_list"]}) end})
            section:colorpicker({name = "Menu Accent", callback = function(color, alpha) library:update_theme("accent", color) end, color = themes.preset.accent})
            section:keybind({name = "Menu Bind", callback = function(bool) window.toggle_menu(bool) end, default = true})
        end
    --

    -- Notification Library
        function notifications:refresh_notifs() 
            local offset = 50

            for i, v in notifications.notifs do
                local Position = vec2(20, offset)
                library:tween(v, {Position = dim_offset(Position.X, Position.Y)}, Enum.EasingStyle.Quad, 0.4)
                offset += (v.AbsoluteSize.Y + 10)
            end

            return offset
        end
        
        function notifications:fade(path, is_fading)
            local fading = is_fading and 1 or 0 
            
            library:tween(path, {BackgroundTransparency = fading}, Enum.EasingStyle.Quad, 1)

            for _, instance in path:GetDescendants() do 
                if not instance:IsA("GuiObject") then 
                    if instance:IsA("UIStroke") then
                        library:tween(instance, {Transparency = fading}, Enum.EasingStyle.Quad, 1)
                    end
        
                    continue
                end 
        
                if instance:IsA("TextLabel") then
                    library:tween(instance, {TextTransparency = fading})
                elseif instance:IsA("Frame") then
                    library:tween(instance, {BackgroundTransparency = instance.Transparency and 0.6 and is_fading and 1 or 0.6}, Enum.EasingStyle.Quad, 1)
                end
            end
        end 
        
        function notifications:create_notification(options)
            local cfg = {
                name = options.name or "This is a title!";
                info = options.info or "This is extra info!";
                lifetime = options.lifetime or 3;
                items = {};
                outline;
            }

            local items = cfg.items; do 
                items[ "notification" ] = library:create( "Frame" , {
                    Parent = library[ "items" ];
                    Size = dim2(0, 210, 0, 53);
                    Name = "\0";
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    AnchorPoint = vec2(1, 0);
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(14, 14, 16)
                });
                
                library:create( "UIStroke" , {
                    Color = rgb(23, 23, 29);
                    Parent = items[ "notification" ];
                    Transparency = 1;
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                });
                
                items[ "title" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "notification" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 7, 0, 6);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "notification" ];
                    CornerRadius = dim(0, 3)
                });
                
                items[ "info" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(145, 145, 145);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.info;
                    Parent = items[ "notification" ];
                    Name = "\0";
                    Position = dim2(0, 9, 0, 22);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    TextWrapped = true;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , {
                    PaddingBottom = dim(0, 17);
                    PaddingRight = dim(0, 8);
                    Parent = items[ "info" ]
                });
                
                items[ "bar" ] = library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = items[ "notification" ];
                    Name = "\0";
                    Position = dim2(0, 8, 1, -6);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 0, 5);
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "bar" ];
                    CornerRadius = dim(0, 999)
                });
                
                library:create( "UIPadding" , {
                    PaddingRight = dim(0, 8);
                    Parent = items[ "notification" ]
                });
            end
            
            local index = #notifications.notifs + 1
            notifications.notifs[index] = items[ "notification" ]

            notifications:fade(items[ "notification" ], false)
            
            local offset = notifications:refresh_notifs()

            items[ "notification" ].Position = dim_offset(20, offset)

            library:tween(items[ "notification" ], {AnchorPoint = vec2(0, 0)}, Enum.EasingStyle.Quad, 1)
            library:tween(items[ "bar" ], {Size = dim2(1, -8, 0, 5)}, Enum.EasingStyle.Quad, cfg.lifetime)

            task.spawn(function()
                task.wait(cfg.lifetime)
                
                notifications.notifs[index] = nil
                
                notifications:fade(items[ "notification" ], true)
                
                library:tween(items[ "notification" ], {AnchorPoint = vec2(1, 0)}, Enum.EasingStyle.Quad, 1)

                task.wait(1)
        
                items[ "notification" ]:Destroy() 
            end)
        end
    --
-- 


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
-- AIM BOT  (Ragebot · Silent Aim · Aimbot · Triggerbot · Settings)
-----------------------------------------------------------------------
local aim_rage, aim_silent, aim_legit, aim_trigger, aim_settings = window:tab({
    name = "Aim Bot", icon = ICO.aim,
    tabs = { "Ragebot", "Silent Aim", "Aimbot", "Triggerbot", "Settings" },
})

-- Ragebot
do
    local col = aim_rage:column({})
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

    local sec2 = col:section({ name = "Priority Targets", size = 1, icon = ICO.aim, default = false })
    sec2:dropdown({name = "Priority Targets",         flag = "ragebot_priority_targets",     items = { "Closest to Crosshair", "Lowest HP", "Nearest" }, default = "Closest to Crosshair" })
end

-- Silent Aim
do
    local col = aim_silent:column({})
    local sec = col:section({ name = "Silent Aim", size = 1, icon = ICO.aim, default = true })
    sec:toggle({  name = "Enabled",                   flag = "silent_toggle",                default = false })
    sec:keybind({ name = "Keybind",                   flag = "silent_keybind",               key = nil, mode = "Toggle" })
    sec:slider({  name = "Hitchance (%)",             flag = "silent_hitchance",             min = 1, max = 100, default = 100, interval = 1, suffix = "%" })
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

-- Aimbot (smooth/legit)
do
    local col = aim_legit:column({})
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

-- Triggerbot
do
    local col = aim_trigger:column({})
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

-- Aim Settings (shared targeting)
do
    local col = aim_settings:column({})
    local sec = col:section({ name = "Targeting", size = 1, icon = ICO.aim, default = true })
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
