-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
local StarterGui = game:GetService("StarterGui");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local Modules = require(script.Parent.Parent.Modules);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local ColorPicker = require(Modules.Elements.ColorPicker);
local OutsideClickDetector = require(Modules.Utilities.OutsideClickDetector);
local ToggleSwitchController = require(Modules.Elements.ToggleSwitchController);
local SliderController = require(Modules.Elements.SliderController);
local Events = script.Parent.Parent.Events;
local Photobooth = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Photobooth");
local container = Photobooth:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local toggleConfigure = Photobooth:WaitForChild("toggleConfigure");
local exit = Photobooth:WaitForChild("exit");
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
Photobooth.Enabled = false;
local u2 = {
    Yaw = 3.141592653589793,
    Pitch = 0,
    Distance = 9,
    PanOffset = Vector2.new(0, 0)
};
local u3 = {
    IsOpen = false
};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = {};
local u12 = nil;
local u13 = nil;
local u14 = false;
local u15 = false;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = {};
local u21 = 0;
local u22 = 0;
local u23 = false;
local u24 = nil;
local u25 = nil;
local colorPickerTemplate = Modules.Elements:WaitForChild("ColorPicker"):WaitForChild("colorPickerTemplate");

local function applyLighting() -- Line: 71
    -- upvalues: u7 (ref), Lighting (copy), u11 (copy), u12 (ref), u13 (ref)
    if not u7 then
        return;
    end;

    local LightingObjects = u7:FindFirstChild("LightingObjects");

    if not LightingObjects then
        return;
    end;

    for _, child in Lighting:GetChildren() do
        if child:IsA("PostEffect") or (child:IsA("Atmosphere") or child:IsA("Sky")) then
            child.Parent = nil;
            table.insert(u11, child);
        end;
    end;

    for _, child in LightingObjects:GetChildren() do
        local v26 = child:Clone();
        v26:SetAttribute("PhotoboothEffect", true);
        v26.Parent = Lighting;
    end;

    u12 = Lighting.GlobalShadows;
    Lighting.GlobalShadows = false;
    u13 = Lighting.ClockTime;
    Lighting.ClockTime = 0;
end;

local function restoreLighting() -- Line: 98
    -- upvalues: Lighting (copy), u11 (copy), u12 (ref), u13 (ref)
    for _, child in Lighting:GetChildren() do
        if child:GetAttribute("PhotoboothEffect") then
            child:Destroy();
        end;
    end;

    for _, v in u11 do
        if v then
            v.Parent = Lighting;
        end;
    end;

    table.clear(u11);

    if u12 ~= nil then
        Lighting.GlobalShadows = u12;
        u12 = nil;
    end;

    if u13 ~= nil then
        Lighting.ClockTime = u13;
        u13 = nil;
    end;
end;

local function cleanup() -- Line: 125
    -- upvalues: u4 (copy), u5 (copy), u6 (copy), u18 (ref), u21 (ref), u22 (ref), u23 (ref), u24 (ref), u25 (ref), wrapper (copy), u20 (copy)
    for _, v in u4 do
        if typeof(v) == "RBXScriptConnection" then
            v:Disconnect();
        elseif type(v) == "table" and v.Disconnect then
            v:Disconnect();
        end;
    end;

    table.clear(u4);

    for _, v in u5 do
        if typeof(v) == "Instance" then
            pcall(v.Destroy, v);
        elseif type(v) == "table" and v.Cleanup then
            pcall(v.Cleanup, v);
        elseif type(v) == "table" and v.Destroy then
            pcall(v.Destroy, v);
        end;
    end;

    table.clear(u5);

    for _, v in u6 do
        pcall(task.cancel, v);
    end;

    table.clear(u6);

    if u18 then
        u18:Disconnect();
        u18 = nil;
    end;

    u21 = 0;
    u22 = 0;
    u23 = false;
    u24 = nil;
    u25 = nil;
    wrapper.AutomaticCanvasSize = Enum.AutomaticSize.None;
    wrapper.CanvasSize = UDim2.new(0, 0, 0, 0);
    wrapper.CanvasPosition = Vector2.new(0, 0);
    wrapper.Size = UDim2.new(wrapper.Size.X.Scale, wrapper.Size.X.Offset, 0, 0);
    game:GetService("CollectionService"):RemoveTag(wrapper, "AutomaticSizeFix");
    game:GetService("CollectionService"):RemoveTag(wrapper, "ScrollingFrameAutomaticSizeFix");
    wrapper.ClipsDescendants = false;
    wrapper.ScrollingEnabled = false;
    table.clear(u20);

    for _, child in wrapper.options:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;
end;

local function setupCharacter() -- Line: 181
    -- upvalues: HumanoidDescriptionController (copy), Players (copy), u8 (ref), u7 (ref), u5 (copy)
    local v27 = HumanoidDescriptionController.GetHumanoid();

    if not v27 then
        return;
    end;

    local RigType = v27.RigType;
    local u28 = HumanoidDescriptionController.GetCurrentDescription();
    local success, result = pcall(function() -- Line: 188
        -- upvalues: Players (ref), u28 (copy), RigType (copy)
        return Players:CreateHumanoidModelFromDescription(u28, RigType);
    end);

    if success and result then
        u8 = result;
        u8.Name = "PhotoboothCharacter";

        if u7 then
            local Value = u7.CFrames.Character.Value;
            local v29 = u8:FindFirstChildOfClass("Humanoid");
            local HumanoidRootPart = u8:FindFirstChild("HumanoidRootPart");

            if v29 and HumanoidRootPart then
                u8:PivotTo(Value * CFrame.new(0, HumanoidRootPart.Size.Y / 2 + (v29.RigType == Enum.HumanoidRigType.R6 and 3.5 or v29.HipHeight), 0));
            end;
        end;

        local HumanoidRootPart = u8:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart then
            HumanoidRootPart.Anchored = true;
        end;

        local Animate = u8:FindFirstChild("Animate");
        local v30 = Animate and script.Parent.AvatarAdjustmentController:FindFirstChild("AnimateIdleOnlyNPC");

        if v30 then
            Animate.Disabled = true;
            Animate.Name = "_OldAnimate";
            local v31 = v30:Clone();
            v31.Name = "Animate";

            for _, child in Animate:GetChildren() do
                child.Parent = v31;
            end;

            v31.Parent = script;
            v31.Enabled = true;
            v31.Character.Value = u8;
            table.insert(u5, v31);
        end;

        u8.Parent = workspace;

        return u8;
    end;

    warn("[PhotoboothController] Failed to create character model:", result);
end;

local u32 = nil;

local function setupCamera() -- Line: 250
    -- upvalues: u9 (ref), LocalPlayer (copy), u10 (ref), u32 (ref)
    u9 = Instance.new("Camera");
    u9.CameraType = Enum.CameraType.Scriptable;
    u9.Parent = workspace;
    workspace.CurrentCamera = u9;
    local PlayerModule = LocalPlayer.PlayerScripts:FindFirstChild("PlayerModule");

    if PlayerModule then
        u10 = require(PlayerModule):GetControls();
        u10:Disable();
    end;

    u32();
end;

u32 = function() -- Line: 267
    -- upvalues: u9 (ref), u20 (copy), u2 (copy), u8 (ref), u7 (ref)
    if not u9 then
        return;
    end;

    local v33 = u20.cameraDistance or u2.Distance;
    local v34 = math.rad(u20.cameraPitch or 0);
    local v35 = math.rad(u20.cameraYaw or 180);
    local v36 = math.rad(u20.cameraTilt or 0);
    local v37 = u20.cameraFOV or 70;
    local v38 = u20.cameraPanX or 0;
    local v39 = u20.cameraPanY or 0;
    local v40 = u8 and u8:FindFirstChild("HumanoidRootPart");
    local v41;

    if v40 then
        v41 = v40.Position + Vector3.new(0, v40.Size.Y / 2, 0);
    else
        if not (u7 and (u7:FindFirstChild("CFrames") and u7.CFrames:FindFirstChild("Character"))) then
            return;
        end;

        v41 = u7.CFrames.Character.Value.Position + Vector3.new(0, 3, 0);
    end;

    local v42 = v41 + Vector3.new(v38, v39, 0);
    u9.CFrame = CFrame.new(v42) * CFrame.Angles(0, v35, 0) * CFrame.Angles(v34, 0, 0) * CFrame.new(0, 0, v33) * CFrame.Angles(0, 0, v36);
    u9.FieldOfView = v37;
end;

local function restoreCamera() -- Line: 298
    -- upvalues: u9 (ref), u10 (ref), LocalPlayer (copy)
    if u9 then
        u9:Destroy();
        u9 = nil;
    end;

    if u10 then
        u10:Enable();
        u10 = nil;
    end;

    local Camera = Instance.new("Camera");
    Camera.CameraType = Enum.CameraType.Custom;

    if LocalPlayer.Character then
        Camera.CameraSubject = LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
    end;

    Camera.Parent = workspace;
    workspace.CurrentCamera = Camera;
end;

local function setConfigureOpen(p43, p44) -- Line: 319
    -- upvalues: u15 (ref), container (copy), toggleConfigure (copy)
    if u15 == p43 and not p44 then
        return;
    end;

    u15 = p43;
    container.Visible = p43;
    toggleConfigure.Visible = not p43;
end;

local u45 = {
    colorPicker = colorPickerTemplate,
    toggle = Modules.Elements:WaitForChild("ToggleSwitchController"):WaitForChild("toggleTemplate"),
    slider = Modules.Elements:WaitForChild("SliderController"):WaitForChild("sliderTemplate")
};

local function dismissColorPicker() -- Line: 341
    -- upvalues: u17 (ref), u16 (ref)
    if u17 then
        u17:Disconnect();
        u17 = nil;
    end;

    if u16 then
        u16:Destroy();
        u16 = nil;
    end;
end;

local u64 = {
    colorPicker = function(u46, u47) -- Line: 431, Name: wireColorPicker
        -- upvalues: u4 (copy), u16 (ref), u17 (ref), ColorPicker (copy), Photobooth (copy), u5 (copy), OutsideClickDetector (copy), dismissColorPicker (copy)
        u46.Size = UDim2.fromScale(0.95, u46.Size.Y.Scale * 1.4);
        u46.color.button.Size = UDim2.fromScale(1, 1);
        u46.color.BackgroundColor3 = u47.default or Color3.new(0, 0, 0);
        table.insert(u4, u46.color.button.Activated:Connect(function() -- Line: 437
            -- upvalues: u16 (ref), u17 (ref), u46 (copy), ColorPicker (ref), Photobooth (ref), u5 (ref), OutsideClickDetector (ref), u4 (ref), u47 (copy), dismissColorPicker (ref)
            if u16 then
                if u17 then
                    u17:Disconnect();
                    u17 = nil;
                end;

                if u16 then
                    u16:Destroy();
                    u16 = nil;
                end;

                return;
            end;

            local AbsolutePosition = u46.color.AbsolutePosition;
            local ViewportSize = workspace.CurrentCamera.ViewportSize;
            local X = AbsolutePosition.X;
            local v48 = AbsolutePosition.Y + u46.color.AbsoluteSize.Y + 4;
            local v49 = math.max(0, ViewportSize.X - 238);
            local v50 = math.clamp(X, 0, v49);
            local v51 = math.max(0, ViewportSize.Y - 334);
            local v52 = math.clamp(v48, 0, v51);
            local v53 = ColorPicker.new({
                Parent = Photobooth,
                Position = UDim2.fromOffset(v50, v52),
                PickerMode = ColorPicker.PICKER_MODE.SQUARE,
                ColorSpace = ColorPicker.COLOR_SPACE.HSV
            });
            u16 = v53;
            table.insert(u5, v53);
            u17 = OutsideClickDetector(v53.Instance, function() -- Line: 467
                -- upvalues: u17 (ref), u16 (ref)
                if u17 then
                    u17:Disconnect();
                    u17 = nil;
                end;

                if u16 then
                    u16:Destroy();
                    u16 = nil;
                end;
            end, {
                include = { u46.color }
            });
            table.insert(u4, u17);
            v53:SetColor(u46.color.BackgroundColor3);
            table.insert(u4, v53.ColorChanged:Connect(function(p54) -- Line: 474
                -- upvalues: u46 (ref), u47 (ref)
                u46.color.BackgroundColor3 = p54;

                if u47.onChange then
                    u47.onChange(p54);
                end;
            end));
            table.insert(u4, v53.WindowClosed:Connect(function() -- Line: 481
                -- upvalues: dismissColorPicker (ref)
                task.defer(dismissColorPicker);
            end));
        end));
    end,

    toggle = function(p55, u56) -- Line: 352, Name: wireToggle
        -- upvalues: ToggleSwitchController (copy), u5 (copy), u20 (copy), u4 (copy)
        p55.Size = UDim2.fromScale(0.95, p55.Size.Y.Scale * 1.4);
        local v57 = ToggleSwitchController.new({
            Button = p55.switch,
            State = u56.default or false
        });
        table.insert(u5, v57);
        u20[u56.key] = v57.State;
        table.insert(u4, v57.OnStateUpdated:Connect(function(p58) -- Line: 364
            -- upvalues: u20 (ref), u56 (copy)
            u20[u56.key] = p58;

            if u56.onChange then
                u56.onChange(p58);
            end;
        end));

        return v57;
    end,

    slider = function(p59, u60) -- Line: 374, Name: wireSlider
        -- upvalues: SliderController (copy), u5 (copy), u20 (copy), u4 (copy), TweenService (copy), u1 (copy)
        p59.Size = UDim2.fromScale(0.95, p59.Size.Y.Scale * 1.4);
        local input = p59.value:FindFirstChild("input");
        local u61 = SliderController.new({
            NoPercentageSign = true,
            SliderButton = p59.slider,
            ValueBox = input,
            MinValue = u60.min or 0,
            MaxValue = u60.max or 100,
            Increment = u60.increment or 1,
            Value = u60.default or 0
        });
        table.insert(u5, u61);
        u20[u60.key] = u61.Value;
        table.insert(u4, u61.OnValueUpdated:Connect(function(p62) -- Line: 392
            -- upvalues: u20 (ref), u60 (copy)
            u20[u60.key] = p62;

            if u60.onChange then
                u60.onChange(p62);
            end;
        end));
        local reset = p59:FindFirstChild("reset");

        if reset and u60.default ~= nil then
            local title = p59:FindFirstChild("title");

            if title then
                local function repositionReset() -- Line: 404
                    -- upvalues: title (copy), reset (copy)
                    local X = title.TextBounds.X;

                    if X == 0 then
                        return;
                    end;

                    local X2 = title.Parent.AbsoluteSize.X;

                    if X2 == 0 then
                        return;
                    end;

                    reset.Position = UDim2.new(title.Position.X.Scale + title.Position.X.Offset / X2 + X / X2, 4, reset.Position.Y.Scale, reset.Position.Y.Offset);
                end;

                repositionReset();
                local v63 = title:GetPropertyChangedSignal("TextBounds");
                table.insert(u4, v63:Connect(repositionReset));
            end;

            table.insert(u4, reset.Activated:Connect(function() -- Line: 417
                -- upvalues: u61 (copy), u60 (copy)
                u61:SetValue(u60.default);
            end));
            table.insert(u4, reset.MouseEnter:Connect(function() -- Line: 420
                -- upvalues: TweenService (ref), reset (copy), u1 (ref)
                TweenService:Create(reset.image, u1, {
                    ImageTransparency = 0
                }):Play();
            end));
            table.insert(u4, reset.MouseLeave:Connect(function() -- Line: 423
                -- upvalues: TweenService (ref), reset (copy), u1 (ref)
                TweenService:Create(reset.image, u1, {
                    ImageTransparency = 0.6
                }):Play();
            end));
        end;

        return u61;
    end
};
local u71 = {
    {
        label = "Environment",
        items = {
            {
                type = "colorPicker",
                label = "Color",
                default = Color3.fromRGB(64, 64, 64),

                onChange = function(p65) -- Line: 503, Name: onChange
                    -- upvalues: u7 (ref)
                    if not u7 then
                        return;
                    end;

                    for _, v in { "pPlane1", "BackGroundMesh_AbyssBlue_0723" } do
                        local v66 = u7:FindFirstChild(v);

                        if v66 then
                            local v67 = v66:FindFirstChildWhichIsA("SurfaceAppearance");

                            if v67 then
                                v67.Color = p65;
                            end;
                        end;
                    end;
                end
            }
        }
    },
    {
        label = "Effects",
        image = "rbxassetid://118232432119006",
        items = {
            {
                type = "toggle",
                key = "spin",
                label = "Spin",
                default = false,

                onChange = function(p68) -- Line: 528, Name: onChange
                    -- upvalues: u18 (ref), u8 (ref), u21 (ref), u22 (ref), u19 (ref), RunService (copy), u20 (copy)
                    if u18 then
                        u18:Disconnect();
                        u18 = nil;
                    end;

                    if p68 and u8 then
                        u21 = 0;
                        u22 = 0;
                        local HumanoidRootPart = u8:FindFirstChild("HumanoidRootPart");

                        if HumanoidRootPart then
                            u19 = HumanoidRootPart.CFrame;
                            u18 = RunService.RenderStepped:Connect(function(p69) -- Line: 539
                                -- upvalues: u20 (ref), HumanoidRootPart (copy)
                                HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(u20.spinSpeed or 40) * p69, 0);
                            end);
                        end;
                    else
                        if u8 and u19 then
                            local HumanoidRootPart = u8:FindFirstChild("HumanoidRootPart");

                            if HumanoidRootPart then
                                HumanoidRootPart.CFrame = u19;
                            end;

                            u19 = nil;
                        end;

                        u21 = 0;
                        u22 = 0;
                    end;
                end
            },
            {
                type = "slider",
                key = "spinSpeed",
                label = "Spin Speed",
                default = 40,
                min = -180,
                max = 180,
                increment = 1,
                visibleWhen = { "spin", true },

                onChange = function(p70) -- Line: 566, Name: onChange
                end
            }
        }
    },
    {
        label = "Camera",
        image = "rbxassetid://88262516578247",
        items = {
            {
                type = "slider",
                key = "cameraDistance",
                label = "Distance",
                default = 9,
                min = 3,
                max = 20,
                increment = 0.5,

                onChange = function() -- Line: 584, Name: onChange
                    -- upvalues: u32 (ref)
                    u32();
                end
            },
            {
                type = "slider",
                key = "cameraPitch",
                label = "Vertical Angle",
                default = 0,
                min = -30,
                max = 30,
                increment = 1,

                onChange = function() -- Line: 594, Name: onChange
                    -- upvalues: u32 (ref)
                    u32();
                end
            },
            {
                type = "slider",
                key = "cameraYaw",
                label = "Rotation",
                default = 180,
                min = 0,
                max = 360,
                increment = 1,

                onChange = function() -- Line: 604, Name: onChange
                    -- upvalues: u32 (ref)
                    u32();
                end
            },
            {
                type = "slider",
                key = "cameraFOV",
                label = "Field of View",
                default = 70,
                min = 20,
                max = 100,
                increment = 1,

                onChange = function() -- Line: 614, Name: onChange
                    -- upvalues: u32 (ref)
                    u32();
                end
            },
            {
                type = "slider",
                key = "cameraTilt",
                label = "Tilt",
                default = 0,
                min = -45,
                max = 45,
                increment = 1,

                onChange = function() -- Line: 624, Name: onChange
                    -- upvalues: u32 (ref)
                    u32();
                end
            },
            {
                type = "slider",
                key = "cameraPanX",
                label = "Pan X",
                default = 0,
                min = -5,
                max = 5,
                increment = 0.5,

                onChange = function() -- Line: 634, Name: onChange
                    -- upvalues: u32 (ref)
                    u32();
                end
            },
            {
                type = "slider",
                key = "cameraPanY",
                label = "Pan Y",
                default = 0,
                min = -5,
                max = 5,
                increment = 0.5,

                onChange = function() -- Line: 644, Name: onChange
                    -- upvalues: u32 (ref)
                    u32();
                end
            }
        }
    }
};

local function setupConfigurationSection(p72) -- Line: 653
    -- upvalues: wrapper (copy), u4 (copy), TweenService (copy), u1 (copy), u20 (copy), u45 (copy), u64 (copy)
    local u73 = script.section:Clone();
    u73.Parent = wrapper.options;
    u73.LayoutOrder = #wrapper.options:GetChildren() + 1;
    u73:SetAttribute("isOpen", false);
    local u74 = u73:FindFirstChildWhichIsA("UICorner");

    if u74 then
        local u75 = nil;

        local function updateSectionCorner() -- Line: 663
            -- upvalues: u73 (copy), u75 (ref), u74 (copy)
            local AbsoluteSize = u73.AbsoluteSize;
            local v76 = math.min(AbsoluteSize.X, AbsoluteSize.Y);

            if v76 <= 0 then
                return;
            end;

            if not u75 then
                local CornerRadius = u74.CornerRadius;
                u75 = CornerRadius.Scale * v76 + CornerRadius.Offset;
            end;

            u74.CornerRadius = UDim.new(u75 / v76, 0);
        end;

        local v77 = u73:GetPropertyChangedSignal("AbsoluteSize");
        table.insert(u4, v77:Connect(updateSectionCorner));
        local AbsoluteSize = u73.AbsoluteSize;
        local v78 = math.min(AbsoluteSize.X, AbsoluteSize.Y);

        if v78 > 0 then
            if not u75 then
                local CornerRadius = u74.CornerRadius;
                u75 = CornerRadius.Scale * v78 + CornerRadius.Offset;
            end;

            u74.CornerRadius = UDim.new(u75 / v78, 0);
        end;
    end;

    u73.toggle.label.Text = p72.label;
    local v79 = p72.image and u73.toggle:FindFirstChild("image");

    if v79 then
        v79.Image = p72.image;
    end;

    u73.toggle.BackgroundTransparency = 1;
    table.insert(u4, u73.toggle.MouseEnter:Connect(function() -- Line: 688
        -- upvalues: TweenService (ref), u73 (copy), u1 (ref)
        TweenService:Create(u73.toggle, u1, {
            BackgroundTransparency = 0.95
        }):Play();
    end));
    table.insert(u4, u73.toggle.MouseLeave:Connect(function() -- Line: 691
        -- upvalues: TweenService (ref), u73 (copy), u1 (ref)
        TweenService:Create(u73.toggle, u1, {
            BackgroundTransparency = 1
        }):Play();
    end));
    u73.toggle.Activated:Connect(function() -- Line: 695
        -- upvalues: u73 (copy), TweenService (ref), u1 (ref), u20 (ref)
        local v80 = not u73:GetAttribute("isOpen");
        u73:SetAttribute("isOpen", v80);
        TweenService:Create(u73.toggle.arrow, u1, {
            Rotation = v80 and 0 or 180
        }):Play();

        for _, child in u73:GetChildren() do
            if child:IsA("GuiObject") and child.Name ~= "toggle" then
                local v81 = child:GetAttribute("_visibleWhenKey");

                if v81 then
                    local v82;

                    if v80 then
                        v82 = u20[v81] == child:GetAttribute("_visibleWhenValue");
                    else
                        v82 = v80;
                    end;

                    child.Visible = v82;
                else
                    child.Visible = v80;
                end;
            end;
        end;
    end);
    local v83 = {};
    local v84 = {};

    for i, v in p72.items do
        local v85 = u45[v.type];

        if v85 then
            local v86 = v85:Clone();
            v86.LayoutOrder = i;
            v86.Visible = false;
            v86.Parent = u73;
            local v87 = v86:FindFirstChild("label") or v86:FindFirstChild("title");

            if v87 and v.label then
                v87.Text = v.label;
            end;

            local v88 = u64[v.type];
            local v89;

            if v88 then
                v89 = v88(v86, v);
            else
                v89 = nil;
            end;

            if v.key then
                v83[v.key] = v86;

                if v89 then
                    v84[v.key] = v89;
                end;
            end;
        else
            warn("[PhotoboothController] No template for type:", v.type);
        end;
    end;

    for _, v in p72.items do
        if v.visibleWhen and v.key then
            local v90 = v.visibleWhen[1];
            local u91 = v.visibleWhen[2];
            local u92 = v83[v.key];

            if u92 then
                u92:SetAttribute("_visibleWhenKey", v90);
                u92:SetAttribute("_visibleWhenValue", u91);
                u92.Visible = false;
                local v93 = v84[v90];

                if v93 and v93.OnStateUpdated then
                    table.insert(u4, v93.OnStateUpdated:Connect(function(p94) -- Line: 767
                        -- upvalues: u73 (copy), u92 (copy), u91 (copy)
                        local v95 = u73:GetAttribute("isOpen");

                        if v95 then
                            v95 = p94 == u91;
                        end;

                        u92.Visible = v95;
                    end));
                end;
            end;
        end;
    end;

    return u73;
end;

local u96 = wrapper:FindFirstChildWhichIsA("UIListLayout");

local function updateWrapperOverflow() -- Line: 780
    -- upvalues: u96 (copy), exit (copy), wrapper (copy)
    local Y = u96.AbsoluteContentSize.Y;
    local v97 = exit.AbsolutePosition.Y - wrapper.AbsolutePosition.Y - 8;

    if v97 <= 0 then
        return;
    end;

    if v97 < Y then
        wrapper.Size = UDim2.new(wrapper.Size.X.Scale, wrapper.Size.X.Offset, 0, v97);
        wrapper.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        wrapper.ScrollingDirection = Enum.ScrollingDirection.Y;
        wrapper.ClipsDescendants = true;
        wrapper.ScrollingEnabled = true;
        game:GetService("CollectionService"):RemoveTag(wrapper, "AutomaticSizeFix");
        game:GetService("CollectionService"):AddTag(wrapper, "ScrollingFrameAutomaticSizeFix");

        return;
    end;

    wrapper.Size = UDim2.new(wrapper.Size.X.Scale, wrapper.Size.X.Offset, 0, Y);
    wrapper.AutomaticCanvasSize = Enum.AutomaticSize.None;
    wrapper.CanvasSize = UDim2.new(0, 0, 0, 0);
    wrapper.ClipsDescendants = false;
    wrapper.ScrollingEnabled = false;
    wrapper.CanvasPosition = Vector2.new(0, 0);
    game:GetService("CollectionService"):RemoveTag(wrapper, "ScrollingFrameAutomaticSizeFix");
    game:GetService("CollectionService"):AddTag(wrapper, "AutomaticSizeFix");
end;

local function buildConfiguration() -- Line: 810
    -- upvalues: u71 (copy), setupConfigurationSection (copy)
    for _, v in u71 do
        setupConfigurationSection(v);
    end;
end;

local function setupDragRotate() -- Line: 816
    -- upvalues: u4 (copy), UserInputService (copy), u20 (copy), u23 (ref), u24 (ref), u22 (ref), u25 (ref), RunService (copy), u8 (ref), u21 (ref)
    table.insert(u4, UserInputService.InputBegan:Connect(function(p98, p99) -- Line: 817
        -- upvalues: u20 (ref), u23 (ref), u24 (ref)
        if p99 then
            return;
        end;

        if u20.spin then
            return;
        end;

        if p98.UserInputType == Enum.UserInputType.MouseButton1 or p98.UserInputType == Enum.UserInputType.Touch then
            u23 = true;
            u24 = p98.Position.X;
        end;
    end));
    table.insert(u4, UserInputService.InputChanged:Connect(function(p100) -- Line: 827
        -- upvalues: u23 (ref), u24 (ref), u22 (ref)
        if not u23 then
            return;
        end;

        if p100.UserInputType == Enum.UserInputType.MouseMovement or p100.UserInputType == Enum.UserInputType.Touch then
            local v101 = p100.Position.X - u24;
            u24 = p100.Position.X;
            u22 = u22 + v101 * 0.5;
        end;
    end));
    table.insert(u4, UserInputService.InputEnded:Connect(function(p102) -- Line: 837
        -- upvalues: u23 (ref), u24 (ref)
        if p102.UserInputType == Enum.UserInputType.MouseButton1 or p102.UserInputType == Enum.UserInputType.Touch then
            u23 = false;
            u24 = nil;
        end;
    end));
    table.insert(u4, UserInputService.InputChanged:Connect(function(p103) -- Line: 846
        -- upvalues: u20 (ref), u22 (ref)
        if u20.spin then
            return;
        end;

        if p103.UserInputType == Enum.UserInputType.Gamepad1 and p103.KeyCode == Enum.KeyCode.Thumbstick2 then
            u22 = u22 + p103.Position.X * 2;
        end;
    end));
    u25 = RunService.RenderStepped:Connect(function(p104) -- Line: 854
        -- upvalues: u8 (ref), u20 (ref), u21 (ref), u22 (ref)
        if not u8 then
            return;
        end;

        if u20.spin then
            return;
        end;

        local HumanoidRootPart = u8:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return;
        end;

        local v105 = u21 + (u22 - u21) * math.min(1, 12 * p104);
        local v106 = v105 - u21;
        u21 = v105;

        if math.abs(v106) > 0.001 then
            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(v106), 0);
        end;
    end);
    table.insert(u4, u25);
end;

function u3.Open() -- Line: 872
    -- upvalues: u3 (copy), Events (copy), StarterGui (copy), u14 (ref), u4 (copy), UserInputService (copy), Photobooth (copy), wrapper (copy), u15 (ref), container (copy), toggleConfigure (copy), u71 (copy), setupConfigurationSection (copy), updateWrapperOverflow (copy), u96 (copy), exit (copy), ReplicatedStorage (copy), u7 (ref), applyLighting (copy), setupCamera (copy), setupDragRotate (copy), u6 (copy), setupCharacter (copy), u32 (ref), HumanoidDescriptionController (copy), u8 (ref)
    if u3.IsOpen then
        return;
    end;

    u3.IsOpen = true;
    Events.InterfaceAction:Fire("Add", "PhotoboothController", u3.Close);
    Events.SetButtonsVisible:Fire({}, nil);
    pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.PlayerList, false);
    u14 = false;
    table.insert(u4, UserInputService.InputBegan:Connect(function(p107, p108) -- Line: 883
        -- upvalues: u14 (ref), StarterGui (ref)
        if p108 then
            return;
        end;

        if p107.KeyCode == Enum.KeyCode.Tab then
            u14 = not u14;
            pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.PlayerList, u14);
        end;
    end));
    Photobooth.Enabled = true;
    local Activated = Photobooth:WaitForChild("exit").Activated;
    table.insert(u4, Activated:Connect(function() -- Line: 893
        -- upvalues: u3 (ref)
        u3.Close();
    end));
    table.insert(u4, wrapper.header.closeButton.Activated:Connect(function() -- Line: 896
        -- upvalues: u15 (ref), container (ref), toggleConfigure (ref)
        if u15 == false then
            return;
        end;

        u15 = false;
        container.Visible = false;
        toggleConfigure.Visible = true;
    end));
    table.insert(u4, toggleConfigure.button.Activated:Connect(function() -- Line: 899
        -- upvalues: u15 (ref), container (ref), toggleConfigure (ref)
        if u15 == true then
            return;
        end;

        u15 = true;
        container.Visible = true;
        toggleConfigure.Visible = false;
    end));
    local _ = u15 == false;
    u15 = false;
    container.Visible = false;
    toggleConfigure.Visible = true;

    for _, v in u71 do
        setupConfigurationSection(v);
    end;

    updateWrapperOverflow();
    local v109 = u96:GetPropertyChangedSignal("AbsoluteContentSize");
    table.insert(u4, v109:Connect(updateWrapperOverflow));
    local v110 = exit:GetPropertyChangedSignal("AbsolutePosition");
    table.insert(u4, v110:Connect(updateWrapperOverflow));
    local PhotoboothMap = ReplicatedStorage:WaitForChild("Assets"):FindFirstChild("PhotoboothMap");

    if not PhotoboothMap then
        warn("[PhotoboothController] PhotoboothMap asset not found");
        u3.IsOpen = false;

        return;
    end;

    u7 = PhotoboothMap:Clone();
    u7.Parent = workspace;
    applyLighting();
    setupCamera();
    setupDragRotate();
    table.insert(u6, task.spawn(function() -- Line: 933
        -- upvalues: setupCharacter (ref), u32 (ref)
        setupCharacter();
        u32();
    end));
    table.insert(u4, HumanoidDescriptionController.OnHumanoidDescriptionUpdated:Connect(function(p111) -- Line: 939
        -- upvalues: u3 (ref), u8 (ref)
        if not (u3.IsOpen and u8) then
            return;
        end;

        local v112 = u8:FindFirstChildOfClass("Humanoid");

        if v112 then
            pcall(v112.ApplyDescription, v112, p111);
        end;
    end));
end;

function u3.Close() -- Line: 948
    -- upvalues: u3 (copy), Photobooth (copy), cleanup (copy), u16 (ref), u8 (ref), u7 (ref), restoreLighting (copy), restoreCamera (copy), Events (copy), StarterGui (copy)
    if not u3.IsOpen then
        return;
    end;

    u3.IsOpen = false;
    Photobooth.Enabled = false;
    cleanup();
    u16 = nil;

    if u8 then
        u8:Destroy();
        u8 = nil;
    end;

    if u7 then
        u7:Destroy();
        u7 = nil;
    end;

    restoreLighting();
    restoreCamera();
    Events.InterfaceAction:Fire("Remove", "PhotoboothController");
    Events.SetButtonsVisible:Fire({ "All" }, nil);
    pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.PlayerList, true);
end;

function u3.Toggle(p113) -- Line: 978
    -- upvalues: u3 (copy)
    if p113 then
        u3.Open();

        return;
    end;

    u3.Close();
end;

Events.DisplayBooth.Event:Connect(function() -- Line: 987
    -- upvalues: u3 (copy)
    if u3.IsOpen then
        u3.Close();

        return;
    end;

    u3.Open();
end);

return u3;