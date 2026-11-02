-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local Modules = require(script.Parent.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local SoundController = require(Modules.Controllers.SoundController);
local ToggleSwitchController = require(Modules.Elements.ToggleSwitchController);
local SliderController = require(Modules.Elements.SliderController);
local DropdownController = require(Modules.Elements.DropdownController);
local ParseTextToColor = require(Modules.Utilities.ParseTextToColor);
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local Parent = script.Parent;
local Elements = script.Parent.Parent.Parent:WaitForChild("Elements");
local u2 = {
    toggle = Elements:WaitForChild("ToggleSwitchController"):WaitForChild("toggleTemplate"),
    slider = Elements:WaitForChild("SliderController"):WaitForChild("sliderTemplate"),
    dropdown = Elements:WaitForChild("DropdownController"):WaitForChild("dropdownTemplate"),
    divider = Parent:WaitForChild("dividerTemplate"),
    input = Parent:WaitForChild("inputTemplate"),
    customChat = Parent:WaitForChild("customChatTemplate"),
    grid = Parent:WaitForChild("gridContainer")
};
local v3 = {};

local function buildUpdateTable(p4, p5) -- Line: 49
    local v6 = {};
    local v7 = v6;

    for i = 1, #p4 - 1 do
        v6[p4[i]] = {};
        v6 = v6[p4[i]];
    end;

    v6[p4[#p4]] = p5;

    return v7;
end;

local function getStoredValue(p8, p9) -- Line: 60
    if p8.path then
        return p9.GetSetting(p8.path);
    end;

    if p8.key then
        return p9.LocalValues[p8.key];
    end;

    return nil;
end;

local function storeLocalValue(p10, p11, p12) -- Line: 70
    if not p10.path and p10.key then
        p11.LocalValues[p10.key] = p12;
    end;
end;

local function tagLabel(p13) -- Line: 78
    -- upvalues: CollectionService (copy)
    CollectionService:AddTag(p13, "ScaledTextSizeAutomaticSizeFix");
end;

local function anchorResetToLabel(u14, u15, p16) -- Line: 82
    local function reposition() -- Line: 83
        -- upvalues: u14 (copy), u15 (copy)
        local X = u14.TextBounds.X;

        if X == 0 then
            return;
        end;

        local X2 = u14.Parent.AbsoluteSize.X;

        if X2 == 0 then
            return;
        end;

        u15.Position = UDim2.new(u14.Position.X.Scale + u14.Position.X.Offset / X2 + X / X2, 4, u15.Position.Y.Scale, u15.Position.Y.Offset);
    end;

    reposition();
    local connections = p16.connections;
    local v17 = u14:GetPropertyChangedSignal("TextBounds");
    table.insert(connections, v17:Connect(reposition));
end;

local function setupResetButton(u18, u19, u20, p21) -- Line: 99
    -- upvalues: SoundController (copy), TweenService (copy), u1 (copy)
    p21.events.AddTooltipToObject:Fire(u18, "Reset to " .. tostring(u20));
    table.insert(p21.connections, u18.Activated:Connect(function() -- Line: 101
        -- upvalues: SoundController (ref), u19 (copy), u20 (copy)
        SoundController.PlaySound("CLICK");
        u19:SetValue(u20);
    end));
    table.insert(p21.connections, u18.MouseEnter:Connect(function() -- Line: 105
        -- upvalues: SoundController (ref), TweenService (ref), u18 (copy), u1 (ref)
        SoundController.PlaySound("HOVER");
        TweenService:Create(u18.image, u1, {
            ImageTransparency = 0
        }):Play();
    end));
    table.insert(p21.connections, u18.MouseLeave:Connect(function() -- Line: 109
        -- upvalues: TweenService (ref), u18 (copy), u1 (ref)
        TweenService:Create(u18.image, u1, {
            ImageTransparency = 0.6
        }):Play();
    end));
end;

local function cloneTemplate(p22) -- Line: 116
    -- upvalues: u2 (copy)
    if p22.type == "buffer" then
        local Frame = Instance.new("Frame");
        Frame.Name = "topBuffer";
        Frame.Size = UDim2.new(1, 0, 0.02, 0);
        Frame.BackgroundTransparency = 1;
        Frame.SizeConstraint = Enum.SizeConstraint.RelativeXX;

        if p22.layoutOrder then
            Frame.LayoutOrder = p22.layoutOrder;
        end;

        return Frame;
    end;

    local v23 = u2[p22.type];

    if not v23 then
        warn("[Helpers] No template for type:", p22.type);

        return nil;
    end;

    local v24 = v23:Clone();
    v24.Visible = true;

    if p22.type ~= "divider" then
        v24.Name = p22.key or p22.type;
    end;

    if p22.layoutOrder then
        v24.LayoutOrder = p22.layoutOrder;
    end;

    if p22.label then
        local v25 = v24:FindFirstChild("label") or v24:FindFirstChild("title");

        if v25 and (v25:IsA("TextLabel") or v25:IsA("TextButton")) then
            v25.Text = p22.label;
        end;
    end;

    return v24;
end;

local function wireToggle(u26, u27, u28) -- Line: 159
    -- upvalues: ToggleSwitchController (copy), buildUpdateTable (copy)
    local switch = u26:FindFirstChild("switch");

    if not switch then
        warn("[Helpers] Toggle missing \'switch\' in", u26:GetFullName());

        return;
    end;

    local controller = u28.controller;
    local v29;

    if u27.path then
        v29 = controller.GetSetting(u27.path);
    elseif u27.key then
        v29 = controller.LocalValues[u27.key];
    else
        v29 = nil;
    end;

    local new = ToggleSwitchController.new;
    local v30 = {
        Button = switch
    };

    if v29 == nil then
        v29 = u27.default or false;
    end;

    v30.State = v29;
    local v31 = new(v30);
    table.insert(u28.objects, v31);
    u26:SetAttribute("SettingValue", v31.State);
    table.insert(u28.connections, v31.OnStateUpdated:Connect(function(p32) -- Line: 175
        -- upvalues: u27 (copy), u28 (copy), u26 (copy), buildUpdateTable (ref)
        local v33 = u27;
        local controller2 = u28.controller;

        if not v33.path and v33.key then
            controller2.LocalValues[v33.key] = p32;
        end;

        u26:SetAttribute("SettingValue", p32);

        if u27.path then
            u28.controller.UpdateSettings((buildUpdateTable(u27.path, p32)));
        end;

        if u27.onChange then
            u27.onChange(p32, u28.controller);
        end;
    end));
end;

local function wireSlider(u34, u35, u36) -- Line: 189
    -- upvalues: SliderController (copy), buildUpdateTable (copy), setupResetButton (copy)
    local slider = u34:FindFirstChild("slider");
    local value = u34:FindFirstChild("value");
    local v37;

    if value then
        v37 = value:FindFirstChild("input");
    else
        v37 = nil;
    end;

    if not slider then
        warn("[Helpers] Slider missing \'slider\' in", u34:GetFullName());

        return;
    end;

    local controller = u36.controller;
    local v38;

    if u35.path then
        v38 = controller.GetSetting(u35.path);
    elseif u35.key then
        v38 = controller.LocalValues[u35.key];
    else
        v38 = nil;
    end;

    if u35.getInitialValue then
        v38 = u35.getInitialValue(v38, u36.controller);
    end;

    local u39 = SliderController.new({
        MaxValue = u35.max or 100,
        MinValue = u35.min or 0,
        Increment = u35.increment or 1,
        NoPercentageSign = u35.showPercent ~= true,
        Value = v38 == nil and (u35.default or (u35.min or 0)) or v38,
        SliderButton = slider,
        ValueBox = v37
    });
    table.insert(u36.objects, u39);

    if u35.key then
        u34:SetAttribute("SettingValue", u39.Value);
        local connections = u36.connections;
        local v40 = u34:GetAttributeChangedSignal("ExternalValue");
        table.insert(connections, v40:Connect(function() -- Line: 222
            -- upvalues: u34 (copy), u39 (copy)
            local v41 = u34:GetAttribute("ExternalValue");

            if v41 then
                u39:SetValue(v41, nil, true);
            end;
        end));
    end;

    table.insert(u36.connections, u39.OnValueUpdated:Connect(function(p42) -- Line: 232
        -- upvalues: u34 (copy), u35 (copy), u36 (copy), buildUpdateTable (ref)
        u34:SetAttribute("SettingValue", p42);
        local v43 = u35;
        local controller2 = u36.controller;

        if not v43.path and v43.key then
            controller2.LocalValues[v43.key] = p42;
        end;

        if u35.path then
            u36.controller.UpdateSettings((buildUpdateTable(u35.path, p42)));
        end;

        if u35.onChange then
            u35.onChange(p42, u36.controller);
        end;
    end));
    local reset = u34:FindFirstChild("reset");

    if reset and u35.default ~= nil then
        setupResetButton(reset, u39, u35.default, u36);
        local title = u34:FindFirstChild("title");

        if title then
            local function v44() -- Line: 83
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

            v44();
            local connections = u36.connections;
            local v45 = title:GetPropertyChangedSignal("TextBounds");
            table.insert(connections, v45:Connect(v44));
        end;
    end;
end;

local function wireDropdown(u46, u47, u48) -- Line: 257
    -- upvalues: DropdownController (copy), buildUpdateTable (copy)
    local dropdown = u46:FindFirstChild("dropdown");

    if not dropdown then
        warn("[Helpers] Dropdown missing \'dropdown\' in", u46:GetFullName());

        return;
    end;

    local button = dropdown:FindFirstChild("button");
    local dropdown2 = dropdown:FindFirstChild("dropdown");
    local v49;

    if dropdown2 then
        v49 = dropdown2:FindFirstChild("choice");
    else
        v49 = nil;
    end;

    local label = dropdown:FindFirstChild("label");

    if not (dropdown2 and v49) then
        warn("[Helpers] Dropdown missing structure in", u46:GetFullName());

        return;
    end;

    local u50 = true;
    local v54 = DropdownController.new({
        reflectSelectionOnLabel = true,
        toggleButton = button,
        dropFrame = dropdown2,
        choiceTemplate = v49,
        label = label,
        getChoices = u47.choices,

        onSelect = function(p51, p52) -- Line: 282, Name: onSelect
            -- upvalues: u50 (ref), u47 (copy), u48 (copy), buildUpdateTable (ref)
            if u50 then
                u50 = false;

                return;
            end;

            local v53 = u47;
            local controller = u48.controller;

            if not v53.path and v53.key then
                controller.LocalValues[v53.key] = p51;
            end;

            if u47.path then
                u48.controller.UpdateSettings((buildUpdateTable(u47.path, p51)));
            end;

            if u47.onChange then
                u47.onChange(p51, u48.controller);
            end;
        end
    });
    table.insert(u48.objects, v54);
    local controller = u48.controller;
    local v55;

    if u47.path then
        v55 = controller.GetSetting(u47.path);
    elseif u47.key then
        v55 = controller.LocalValues[u47.key];
    else
        v55 = nil;
    end;

    if v55 then
        v54:SetCurrentChoice(v55);
    elseif u47.default then
        v54:SetCurrentChoice(u47.default);
    end;

    v54:SetVisibleCallback(function(p56) -- Line: 307
        -- upvalues: u46 (copy)
        u46.ZIndex = p56 and 10 or 1;
    end);
end;

local function wireInput(p57, u58, u59) -- Line: 314
    -- upvalues: buildUpdateTable (copy)
    local value = p57:FindFirstChild("value");
    local u60;

    if value then
        u60 = value:FindFirstChild("input");
    else
        u60 = nil;
    end;

    if not u60 then
        warn("[Helpers] Input missing \'value.input\' in", p57:GetFullName());

        return;
    end;

    if u58.inputSize then
        value.Size = u58.inputSize;
    end;

    if u58.placeholder then
        u60.PlaceholderText = u58.placeholder;
    end;

    local controller = u59.controller;
    local v61;

    if u58.path then
        v61 = controller.GetSetting(u58.path);
    elseif u58.key then
        v61 = controller.LocalValues[u58.key];
    else
        v61 = nil;
    end;

    local u62 = v61 == nil and (u58.default or 0) or v61;

    local function applyDisplay(u63) -- Line: 337
        -- upvalues: u60 (copy), u58 (copy)
        u60.Text = tostring(u63);

        if u58.displayTransform then
            task.spawn(function() -- Line: 340
                -- upvalues: u58 (ref), u63 (copy), u60 (ref)
                local v64 = u58.displayTransform(u63);

                if v64 and (u60.Text == tostring(u63) and not u60:IsFocused()) then
                    u60.Text = v64;
                end;
            end);
        end;
    end;

    local u65 = u62;
    u60.Text = tostring(u65);

    if u58.displayTransform then
        task.spawn(function() -- Line: 340
            -- upvalues: u58 (copy), u65 (copy), u60 (copy)
            local v66 = u58.displayTransform(u65);

            if v66 and (u60.Text == tostring(u65) and not u60:IsFocused()) then
                u60.Text = v66;
            end;
        end);
    end;

    table.insert(u59.connections, u60.FocusLost:Connect(function() -- Line: 350
        -- upvalues: u58 (copy), u60 (copy), u62 (ref), u59 (copy), buildUpdateTable (ref)
        task.spawn(function() -- Line: 351
            -- upvalues: u58 (ref), u60 (ref), u62 (ref), u59 (ref), buildUpdateTable (ref)
            local v67;

            if u58.inputType == "string" then
                v67 = u60.Text;
            else
                v67 = tonumber(u60.Text);

                if v67 == nil then
                    local u68 = u62;
                    u60.Text = tostring(u68);

                    if u58.displayTransform then
                        task.spawn(function() -- Line: 340
                            -- upvalues: u58 (ref), u68 (copy), u60 (ref)
                            local v69 = u58.displayTransform(u68);

                            if v69 and (u60.Text == tostring(u68) and not u60:IsFocused()) then
                                u60.Text = v69;
                            end;
                        end);
                    end;

                    return;
                end;

                if u58.min then
                    v67 = math.max(u58.min, v67);
                end;

                if u58.max then
                    v67 = math.min(u58.max, v67);
                end;
            end;

            if u58.validate then
                local v70, v71 = u58.validate(v67);

                if not v70 then
                    local u72 = u62;
                    u60.Text = tostring(u72);

                    if u58.displayTransform then
                        task.spawn(function() -- Line: 340
                            -- upvalues: u58 (ref), u72 (copy), u60 (ref)
                            local v73 = u58.displayTransform(u72);

                            if v73 and (u60.Text == tostring(u72) and not u60:IsFocused()) then
                                u60.Text = v73;
                            end;
                        end);
                    end;

                    if v71 then
                        u59.events.Notify:Fire(v71);
                    end;

                    return;
                end;
            end;

            local u74;

            if u58.path then
                local v75;
                v75, u74 = u59.controller.UpdateSettings((buildUpdateTable(u58.path, v67)));

                if v75 == false then
                    local u76 = u62;
                    u60.Text = tostring(u76);

                    if u58.displayTransform then
                        task.spawn(function() -- Line: 340
                            -- upvalues: u58 (ref), u76 (copy), u60 (ref)
                            local v77 = u58.displayTransform(u76);

                            if v77 and (u60.Text == tostring(u76) and not u60:IsFocused()) then
                                u60.Text = v77;
                            end;
                        end);
                    end;

                    return;
                end;

                if u74 and u58.path then
                    for _, v in u58.path do
                        if typeof(u74) ~= "table" then
                            u74 = nil;
                            break;
                        end;

                        u74 = u74[v];
                    end;

                    if u74 == nil then
                        u74 = v67;
                    end;
                else
                    u74 = v67;
                end;
            else
                u74 = v67;
            end;

            u62 = u74;
            u60.Text = tostring(u74);

            if u58.displayTransform then
                task.spawn(function() -- Line: 340
                    -- upvalues: u58 (ref), u74 (copy), u60 (ref)
                    local v78 = u58.displayTransform(u74);

                    if v78 and (u60.Text == tostring(u74) and not u60:IsFocused()) then
                        u60.Text = v78;
                    end;
                end);
            end;

            local v79 = u58;
            local controller2 = u59.controller;

            if not v79.path and v79.key then
                controller2.LocalValues[v79.key] = u74;
            end;

            if u58.onSaveNotify then
                u59.events.Notify:Fire(u58.onSaveNotify(u74));
            end;

            if u58.onChange then
                u58.onChange(u74, u59.controller);
            end;
        end);
    end));
end;

local function wireColorPicker(p80, u81, u82) -- Line: 411
    -- upvalues: Modules (copy), buildUpdateTable (copy), SliderController (copy), ParseTextToColor (copy), SoundController (copy), ThemeController (copy), TweenService (copy), u1 (copy)
    local wrapper = p80:FindFirstChild("wrapper");
    local cover = p80:FindFirstChild("cover");
    local u83 = wrapper or p80;
    local GroupMembershipController = require(Modules.Controllers.GroupMembershipController);
    local v84 = GroupMembershipController.IsJoined();

    if cover then
        cover.Visible = not v84;
    end;

    if not v84 then
        table.insert(u82.connections, GroupMembershipController.PlayerJoinedGroup:Connect(function() -- Line: 422
            -- upvalues: cover (copy), u83 (copy), u82 (copy)
            if cover then
                cover.Visible = false;
            end;

            local v85 = u83:FindFirstChild("label") and u83.label:FindFirstChild("reset");

            if v85 then
                u82.events.AddTooltipToObject:Fire(v85, "Reset all custom chat colors");
            end;

            local applyButtons = u83:FindFirstChild("applyButtons");

            if applyButtons then
                for i, v in {
                    tag = "Apply color to chat tag",
                    name = "Apply color to chat name",
                    chats = "Apply color to chat text"
                } do
                    local v86 = applyButtons:FindFirstChild(i);

                    if v86 then
                        u82.events.AddTooltipToObject:Fire(v86, v);
                    end;
                end;
            end;
        end));

        if cover then
            cover = cover:FindFirstChild("join");
        end;

        if cover then
            table.insert(u82.connections, cover.Activated:Connect(function() -- Line: 438
                -- upvalues: GroupMembershipController (copy)
                GroupMembershipController.PromptJoin();
            end));
        end;
    end;

    local hue = u83:FindFirstChild("hue");
    local saturationAndValue = u83:FindFirstChild("saturationAndValue");
    local currentColor = u83:FindFirstChild("currentColor");

    if not (hue and (saturationAndValue and currentColor)) then
        return;
    end;

    local circle = saturationAndValue.slider.circle;
    local circle2 = hue.slider.circle;
    local u87 = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 1, 1)),
        ColorSequenceKeypoint.new(0.167, Color3.fromHSV(0.167, 1, 1)),
        ColorSequenceKeypoint.new(0.333, Color3.fromHSV(0.333, 1, 1)),
        ColorSequenceKeypoint.new(0.5, Color3.fromHSV(0.5, 1, 1)),
        ColorSequenceKeypoint.new(0.667, Color3.fromHSV(0.667, 1, 1)),
        ColorSequenceKeypoint.new(0.833, Color3.fromHSV(0.833, 1, 1)),
        ColorSequenceKeypoint.new(1, Color3.fromHSV(1, 1, 1))
    });

    local function getSampledColor(p88, p89) -- Line: 462
        local Keypoints = p89.Keypoints;

        if p88 <= 0 then
            return Keypoints[1].Value;
        end;

        if p88 >= 1 then
            return Keypoints[#Keypoints].Value;
        end;

        for i = 1, #Keypoints - 1 do
            if Keypoints[i].Time <= p88 and p88 <= Keypoints[i + 1].Time then
                return Keypoints[i].Value:Lerp(Keypoints[i + 1].Value, (p88 - Keypoints[i].Time) / (Keypoints[i + 1].Time - Keypoints[i].Time));
            end;
        end;

        return Keypoints[1].Value;
    end;

    local function getSaturationAndValuePositionFromColor(p90, p91) -- Line: 475
        if p91 <= p90 then
            return 1 - p91 / 2;
        end;

        return p90 / 2;
    end;

    local u92 = nil;
    local u93 = nil;

    local function updateColor(p94, p95) -- Line: 484
        -- upvalues: u92 (ref), u93 (ref), getSampledColor (copy), u87 (copy), currentColor (copy), circle2 (copy), circle (copy), u81 (copy), u82 (copy), buildUpdateTable (ref)
        if u92 == nil or u93 == nil then
            return;
        end;

        local v96 = getSampledColor(u93.Value / 100, u87);

        if p94 == nil then
            local v97 = u92.Value / 100;

            if v97 <= 0.5 then
                p94 = Color3.new(1, 1, 1):Lerp(v96, v97 * 2);
            else
                p94 = v96:Lerp(Color3.new(0, 0, 0), (v97 - 0.5) * 2);
            end;
        else
            local v98, v99, v100 = p94:ToHSV();
            u93:SetValue(v98 * 100, true, true);
            local v101;

            if v100 <= v99 then
                v101 = 1 - v100 / 2;
            else
                v101 = v99 / 2;
            end;

            u92:SetValue(v101 * 100, true, true);
            v96 = getSampledColor(u93.Value / 100, u87);
        end;

        currentColor.color.BackgroundColor3 = p94;
        currentColor.value.input.Text = "#" .. string.upper(p94:ToHex());
        circle2.BackgroundColor3 = v96;
        circle.BackgroundColor3 = p94;
        u92.Line.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(0.5, v96), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)) });

        if not p95 and u81.path then
            local v102 = "#" .. string.upper(p94:ToHex());
            local v103 = u81;
            local controller = u82.controller;

            if not v103.path and v103.key then
                controller.LocalValues[v103.key] = v102;
            end;

            u82.controller.UpdateSettings((buildUpdateTable(u81.path, v102)));
        end;

        if u81.onChange then
            u81.onChange(p94);
        end;
    end;

    u92 = SliderController.new({
        MaxValue = 100,
        MinValue = 0,
        Instant = true,
        Increment = 0.1,
        SliderButton = saturationAndValue.slider,

        OnThumbUpdated = function(p104, p105) -- Line: 530, Name: OnThumbUpdated
            -- upvalues: getSampledColor (copy), u93 (ref), u87 (copy), circle (copy), updateColor (copy)
            local v106 = p104 / 100;
            local v107 = getSampledColor((not u93 and 0 or u93.Value) / 100, u87);
            local v108;

            if v106 <= 0.5 then
                v108 = Color3.new(1, 1, 1):Lerp(v107, v106 * 2);
            else
                v108 = v107:Lerp(Color3.new(0, 0, 0), (v106 - 0.5) * 2);
            end;

            circle.BackgroundColor3 = v108;

            if p105 then
                return;
            end;

            updateColor(nil, true);
        end
    });
    u93 = SliderController.new({
        MaxValue = 100,
        MinValue = 0,
        Instant = true,
        Increment = 0.1,
        SliderButton = hue.slider,

        OnThumbUpdated = function(p109, p110) -- Line: 551, Name: OnThumbUpdated
            -- upvalues: getSampledColor (copy), u87 (copy), circle2 (copy), u92 (ref), circle (copy), updateColor (copy)
            local v111 = getSampledColor(p109 / 100, u87);
            circle2.BackgroundColor3 = v111;
            u92.Line.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(0.5, v111), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)) });
            local v112 = u92.Value / 100;
            local v113;

            if v112 <= 0.5 then
                v113 = Color3.new(1, 1, 1):Lerp(v111, v112 * 2);
            else
                v113 = v111:Lerp(Color3.new(0, 0, 0), (v112 - 0.5) * 2);
            end;

            circle.BackgroundColor3 = v113;

            if p110 then
                return;
            end;

            updateColor(nil, true);
        end
    });
    u93.Line.UIGradient.Color = u87;
    table.insert(u82.connections, u93.OnInputEnded:Connect(function() -- Line: 574
        -- upvalues: updateColor (copy)
        updateColor(nil, false);
    end));
    table.insert(u82.connections, u92.OnInputEnded:Connect(function() -- Line: 578
        -- upvalues: updateColor (copy)
        updateColor(nil, false);
    end));
    currentColor.value.input.FocusLost:Connect(function() -- Line: 582
        -- upvalues: currentColor (copy), ParseTextToColor (ref), updateColor (copy)
        local v114, _ = ParseTextToColor(currentColor.value.input.Text);

        if v114 then
            updateColor(v114, false);

            return;
        end;

        currentColor.value.input.Text = "#" .. string.upper(currentColor.color.BackgroundColor3:ToHex());
    end);
    local controller = u82.controller;
    local v115;

    if u81.path then
        v115 = controller.GetSetting(u81.path);
    elseif u81.key then
        v115 = controller.LocalValues[u81.key];
    else
        v115 = nil;
    end;

    local v116 = v115 or u81.default;
    local v117;

    if type(v116) == "string" and v116 ~= "" then
        v117 = ParseTextToColor(v116) ~= nil;
    else
        v117 = false;
    end;

    if v117 then
        updateColor(ParseTextToColor(v116), true);
    else
        u93:SetValue(0, true, true, true);
        u92:SetValue(50, true, true, true);
        updateColor(nil, true);
    end;

    local label = u83:FindFirstChild("label");
    local u118;

    if label then
        u118 = label:FindFirstChild("reset");
    else
        u118 = label;
    end;

    if u118 and label then
        local function repositionReset() -- Line: 609
            -- upvalues: label (copy), u118 (copy)
            local X = label.TextBounds.X;

            if X == 0 then
                return;
            end;

            u118.Position = UDim2.new(0, X + 4, 0.5, 0);
        end;

        local X = label.TextBounds.X;

        if X ~= 0 then
            u118.Position = UDim2.new(0, X + 4, 0.5, 0);
        end;

        local connections = u82.connections;
        local v119 = label:GetPropertyChangedSignal("TextBounds");
        table.insert(connections, v119:Connect(repositionReset));

        if v84 then
            u82.events.AddTooltipToObject:Fire(u118, "Reset all custom chat colors");
        end;

        table.insert(u82.connections, u118.Activated:Connect(function() -- Line: 619
            -- upvalues: SoundController (ref), u82 (copy), u83 (copy), ThemeController (ref)
            SoundController.PlaySound("CLICK");

            if u82.controller.UpdateSettings({
                Profile = {
                    ChatTagColor = "",
                    ChatNameColor = "",
                    ChatTextColor = "",
                    ChatTagText = ""
                }
            }) == false then
                return;
            end;

            local applyButtons = u83:FindFirstChild("applyButtons");

            if applyButtons then
                for _, child in applyButtons:GetChildren() do
                    local color = child:FindFirstChild("color");

                    if color then
                        color.BackgroundColor3 = ThemeController.GetColor(Color3.new(1, 1, 1));
                    end;
                end;
            end;

            u82.events.Notify:Fire("✅ Custom chat settings reset.");
        end));
        table.insert(u82.connections, u118.MouseEnter:Connect(function() -- Line: 632
            -- upvalues: SoundController (ref), TweenService (ref), u118 (copy), u1 (ref)
            SoundController.PlaySound("HOVER");
            TweenService:Create(u118.image, u1, {
                ImageTransparency = 0
            }):Play();
        end));
        table.insert(u82.connections, u118.MouseLeave:Connect(function() -- Line: 636
            -- upvalues: TweenService (ref), u118 (copy), u1 (ref)
            TweenService:Create(u118.image, u1, {
                ImageTransparency = 0.6
            }):Play();
        end));
    end;

    local applyButtons = u83:FindFirstChild("applyButtons");

    if applyButtons then
        for i, v in {
            tag = {
                tooltip = "Apply color to chat tag",
                path = { "Profile", "ChatTagColor" }
            },
            name = {
                tooltip = "Apply color to chat name",
                path = { "Profile", "ChatNameColor" }
            },
            chats = {
                tooltip = "Apply color to chat text",
                path = { "Profile", "ChatTextColor" }
            }
        } do
            local u120 = applyButtons:FindFirstChild(i);

            if u120 then
                local color = u120:FindFirstChild("color");
                local path = v.path;

                if v84 then
                    u82.events.AddTooltipToObject:Fire(u120, v.tooltip);
                end;

                local v121 = u82.controller.GetSetting(path);
                local v122 = v121 and (v121 ~= "" and color) and ParseTextToColor(v121);

                if v122 then
                    color.BackgroundColor3 = v122;
                end;

                table.insert(u82.connections, u120.MouseEnter:Connect(function() -- Line: 667
                    -- upvalues: SoundController (ref), TweenService (ref), u120 (copy)
                    SoundController.PlaySound("HOVER");
                    TweenService:Create(u120, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 0.875
                    }):Play();
                end));
                table.insert(u82.connections, u120.MouseLeave:Connect(function() -- Line: 671
                    -- upvalues: TweenService (ref), u120 (copy)
                    TweenService:Create(u120, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 0.95
                    }):Play();
                end));
                table.insert(u82.connections, u120.Activated:Connect(function() -- Line: 674
                    -- upvalues: SoundController (ref), currentColor (copy), u82 (copy), buildUpdateTable (ref), path (copy), color (copy), v (copy)
                    SoundController.PlaySound("CLICK");
                    local BackgroundColor3 = currentColor.color.BackgroundColor3;
                    local v123 = "#" .. string.upper(BackgroundColor3:ToHex());

                    if u82.controller.UpdateSettings((buildUpdateTable(path, v123))) == false then
                        return;
                    end;

                    if color then
                        color.BackgroundColor3 = BackgroundColor3;
                    end;

                    u82.events.Notify:Fire("✅ Successfully set " .. v.tooltip:gsub("Apply color to ", "") .. " color to <font color=\"" .. v123 .. "\">■</font>");
                end));
            end;
        end;
    end;
end;

local function wireGrid(p124, u125, u126) -- Line: 690
    -- upvalues: TweenService (copy), u1 (copy), SoundController (copy), buildUpdateTable (copy)
    local grid = p124:FindFirstChild("grid");

    if not grid then
        warn("[Helpers] Grid missing \'grid\' in", p124:GetFullName());

        return;
    end;

    local label = p124:FindFirstChild("label");

    if label and u125.label then
        label.Text = u125.label;
    end;

    local v127 = nil;

    for _, child in grid:GetChildren() do
        if child:IsA("TextButton") then
            v127 = v127 or child:Clone();
            child:Destroy();
        end;
    end;

    if not v127 then
        warn("[Helpers] Grid has no TextButton template in", p124:GetFullName());

        return;
    end;

    local u128 = nil;

    local function selectButton(p129) -- Line: 720
        -- upvalues: u128 (ref), TweenService (ref), u1 (ref)
        if u128 then
            TweenService:Create(u128.UIStroke, u1, {
                Transparency = 0.9
            }):Play();
        end;

        u128 = p129;
        TweenService:Create(p129.UIStroke, u1, {
            Transparency = 0.1
        }):Play();
    end;

    for i, v in typeof(u125.getItems) ~= "function" and {} or u125.getItems() do
        local u130 = v127:Clone();
        u130.Name = i;
        local label2 = u130:FindFirstChild("label");

        if label2 then
            label2.Text = v.DisplayName or (v.Name or i);
        end;

        local image = u130:FindFirstChild("image");

        if image then
            if v.Color then
                image.ImageTransparency = 1;
                image.BackgroundTransparency = 0;
                image.BackgroundColor3 = v.Color;
            elseif v.Image and v.Image ~= "" then
                image.Image = v.Image;
            end;
        end;

        if v.LayoutOrder then
            u130.LayoutOrder = v.LayoutOrder;
        end;

        u130.Parent = grid;
        table.insert(u126.connections, u130.Activated:Connect(function() -- Line: 756
            -- upvalues: SoundController (ref), selectButton (copy), u130 (copy), u125 (copy), u126 (copy), i (copy), buildUpdateTable (ref), v (copy)
            SoundController.PlaySound("CLICK");
            selectButton(u130);
            local v131 = u125;
            local controller = u126.controller;
            local v132 = i;

            if not v131.path and v131.key then
                controller.LocalValues[v131.key] = v132;
            end;

            if u125.path then
                u126.controller.UpdateSettings((buildUpdateTable(u125.path, i)));
            end;

            if u125.onSelect then
                u125.onSelect(i, v, u126.controller);
            end;
        end));
        table.insert(u126.connections, u130.MouseEnter:Connect(function() -- Line: 768
            -- upvalues: SoundController (ref), u130 (copy), u128 (ref), TweenService (ref), u1 (ref)
            SoundController.PlaySound("HOVER");

            if u130 ~= u128 then
                TweenService:Create(u130.UIStroke, u1, {
                    Transparency = 0.5
                }):Play();
            end;
        end));
        table.insert(u126.connections, u130.MouseLeave:Connect(function() -- Line: 775
            -- upvalues: u130 (copy), u128 (ref), TweenService (ref), u1 (ref)
            if u130 ~= u128 then
                TweenService:Create(u130.UIStroke, u1, {
                    Transparency = 0.9
                }):Play();
            end;
        end));
        local controller = u126.controller;
        local v133;

        if u125.path then
            v133 = controller.GetSetting(u125.path);
        elseif u125.key then
            v133 = controller.LocalValues[u125.key];
        else
            v133 = nil;
        end;

        if v133 == nil then
            v133 = u125.default;
        end;

        if v133 == i then
            selectButton(u130);
        end;
    end;
end;

local _ = {
    toggle = wireToggle,
    slider = wireSlider,
    dropdown = wireDropdown,

    divider = function() -- Line: 796, Name: divider
    end,

    input = wireInput,
    customChat = wireColorPicker,
    grid = wireGrid
};
local u134 = {
    toggle = wireToggle,
    slider = wireSlider,
    dropdown = wireDropdown,

    divider = function() -- Line: 807, Name: divider
    end,

    input = wireInput,
    customChat = wireColorPicker,
    grid = wireGrid
};

function v3.Build(p135, u136, p137) -- Line: 815
    -- upvalues: ThemeController (copy), cloneTemplate (copy), Modules (copy), u134 (copy)
    if not u136 or #u136 == 0 then
        return nil;
    end;

    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = p135;
    ScrollingFrame.Size = UDim2.fromScale(1, 1);
    ScrollingFrame.CanvasSize = UDim2.fromScale(0, 0);
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.ScrollBarThickness = 3;
    ScrollingFrame.ScrollBarImageColor3 = ThemeController.GetColor(Color3.new(1, 1, 1));
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.ClipsDescendants = true;
    ScrollingFrame:AddTag("ScrollingFrameAutomaticSizeFix");
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Padding = UDim.new(0, 4);
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout.Parent = ScrollingFrame;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingLeft = UDim.new(0.025, 0);
    UIPadding.PaddingRight = UDim.new(0.022, 0);
    UIPadding.Parent = ScrollingFrame;
    local v138 = {};

    for _, v in u136 do
        local u139 = cloneTemplate(v);

        if u139 then
            u139.Parent = ScrollingFrame;

            if v.requiresGroup then
                local GroupMembershipController = require(Modules.Controllers.GroupMembershipController);
                u139.Visible = GroupMembershipController.IsJoined();

                if not u139.Visible then
                    table.insert(p137.connections, GroupMembershipController.PlayerJoinedGroup:Connect(function() -- Line: 855
                        -- upvalues: u139 (copy)
                        u139.Visible = true;
                    end));
                end;
            end;

            if v.key then
                v138[v.key] = u139;
            end;

            local v140 = u134[v.type];

            if v140 then
                v140(u139, v, p137);
            end;
        end;
    end;

    for _, v in u136 do
        if v.visibleWhen and v.key then
            local u141 = v138[v.key];

            if u141 then
                local u142 = v.visibleWhen[1];
                local u143 = v.visibleWhen[2];
                local u144 = v138[u142];

                local function updateVisibility() -- Line: 883
                    -- upvalues: u144 (copy), u136 (copy), u142 (copy), u141 (copy), u143 (copy)
                    local v145;

                    if u144 then
                        v145 = u144:GetAttribute("SettingValue");
                    else
                        v145 = nil;
                    end;

                    if v145 == nil then
                        for _, v2 in u136 do
                            if v2.key == u142 then
                                v145 = v2.default;
                                break;
                            end;
                        end;
                    end;

                    u141.Visible = v145 == u143;
                end;

                updateVisibility();

                if u144 then
                    local connections = p137.connections;
                    local v146 = u144:GetAttributeChangedSignal("SettingValue");
                    table.insert(connections, v146:Connect(updateVisibility));
                end;
            end;
        end;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "bottomBuffer";
    Frame.Size = UDim2.new(1, 0, 0.25, 0);
    Frame.BackgroundTransparency = 1;
    Frame.LayoutOrder = 999;
    Frame.Parent = ScrollingFrame;

    return ScrollingFrame;
end;

return v3;