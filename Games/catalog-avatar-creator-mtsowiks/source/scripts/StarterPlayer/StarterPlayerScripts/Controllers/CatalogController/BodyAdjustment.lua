-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = require(script.Parent.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local catalogSection = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Catalog").container:WaitForChild("catalogSection");
local itemsSection = catalogSection:WaitForChild("itemsSection");
local bodyAdjustmentSection = catalogSection:WaitForChild("bodyAdjustmentSection");
local skinTonesSection = catalogSection:WaitForChild("skinTonesSection");
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
script.Parent.Parent.Parent:WaitForChild("Events");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
local SliderController = require(Modules.Elements.SliderController);
local ParseTextToColor = require(Modules.Utilities.ParseTextToColor);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local SkinTonePresetColors = CatalogUtilities.SkinTonePresetColors;
local u2 = {
    Current = {},
    SkinToneSettings = {
        ShowAdvanced = false,
        SelectedAllParts = true,
        CustomColor = Color3.new(1, 1, 1),
        SelectedParts = {
            Head = true,
            LeftArm = true,
            RightArm = true,
            LeftLeg = true,
            RightLeg = true,
            Torso = true
        },
        BodyColors = {}
    }
};
bodyAdjustmentSection.Visible = false;

local function addRobloxAllowedToLine(p3, p4, p5, p6) -- Line: 53
    -- upvalues: CatalogUtilities (copy), ThemeController (copy)
    local v7 = CatalogUtilities.AvatarRules.Scales[p4] or (p4 == "Depth" and {
        Min = 0.85,
        Max = 1
    } or {
        Min = 0,
        Max = 1
    });
    local v8 = p5 / 100;
    local v9 = p6 / 100;
    local v10 = (v7.Max - v8) / (v9 - v8);
    local v11 = math.clamp((v7.Min - v8) / (v9 - v8), 0, 1);
    local v12 = math.clamp(v10, 0, 1) - v11;
    local Frame = Instance.new("Frame");
    Frame.Name = "robloxAllowed";
    Frame.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(51, 95, 255));
    Frame.Position = UDim2.fromScale(v11, 0);
    Frame.Size = UDim2.fromScale(v12, 1);
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 0;
    Frame.Parent = p3;

    return Frame;
end;

local function setupMultiToggle(p13, p14, u15) -- Line: 82
    -- upvalues: TweenService (copy), u1 (copy), ThemeController (copy)
    local u17 = {
        Connections = {},

        SetChosenButton = function(p16) -- Line: 85, Name: SetChosenButton
            -- upvalues: u15 (copy)
            for i, v in u15 do
                if p16 == i then
                    for _, v2 in v.FadeInTweens do
                        v2:Play();
                    end;
                else
                    for _, v2 in v.FadeOutTweens do
                        v2:Play();
                    end;
                end;
            end;
        end
    };

    for i, v in u15 do
        v.FadeInTweens = { TweenService:Create(v.Button, u1, {
                BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(33, 34, 39))
            }), TweenService:Create(v.Button.fill, u1, {
                BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(33, 34, 39))
            }) };
        v.FadeOutTweens = { TweenService:Create(v.Button, u1, {
                BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(18, 18, 21))
            }), TweenService:Create(v.Button.fill, u1, {
                BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(18, 18, 21))
            }) };
        table.insert(u17.Connections, v.Button.Activated:Connect(function() -- Line: 109
            -- upvalues: u17 (copy), i (copy), v (copy)
            u17.SetChosenButton(i);
            v.OnSelect();
        end));
        v.Button.AutoButtonColor = false;
    end;

    if p14 then
        u17.SetChosenButton(p14);
    end;

    return u17;
end;

function u2.DisplayPage(p18) -- Line: 124
    -- upvalues: u2 (copy), itemsSection (copy), HumanoidDescriptionController (copy), bodyAdjustmentSection (copy), SliderController (copy), AvatarPreviewController (copy), Remotes (copy), TweenService (copy), u1 (copy), CatalogUtilities (copy), addRobloxAllowedToLine (copy), setupMultiToggle (copy), skinTonesSection (copy), SkinTonePresetColors (copy), ParseTextToColor (copy)
    u2.RemoveCurrentPage();
    u2.Current = {
        Connections = {},
        Sliders = {}
    };
    itemsSection.Visible = false;
    local u19 = HumanoidDescriptionController.GetCurrentDescription();
    local v20 = HumanoidDescriptionController.GetHumanoid();
    local Type = p18.Type;

    if Type ~= "BodyAdjustment" then
        if Type == "SkinTones" then
            u2.Current.Page = skinTonesSection;
            skinTonesSection.Visible = true;
            local SkinToneSettings = u2.SkinToneSettings;
            local palette = skinTonesSection.colors.palette;
            local bodyPartSelection = skinTonesSection.bodyPartSelection;

            local function updateCatalogPreview(p21) -- Line: 365
                -- upvalues: AvatarPreviewController (ref)
                local CurrentCatalogPreviewObject = AvatarPreviewController.CurrentCatalogPreviewObject;

                if CurrentCatalogPreviewObject then
                    local AppliedDescription = CurrentCatalogPreviewObject.AppliedDescription;
                    local v22 = CurrentCatalogPreviewObject.Rig:WaitForChild("Body Colors");

                    if AppliedDescription and v22 then
                        for i, v in p21 do
                            AppliedDescription[i .. "Color"] = v;
                            v22[i .. "Color3"] = v;
                        end;
                    end;
                end;
            end;

            local function updateBodyPartColors() -- Line: 381
                -- upvalues: bodyPartSelection (copy), SkinToneSettings (copy)
                for _, child in bodyPartSelection.body:GetChildren() do
                    if child:IsA("Frame") == true then
                        child.BackgroundColor3 = SkinToneSettings.BodyColors[child.Name] or Color3.fromRGB(255, 255, 255);
                    end;
                end;
            end;

            local function clearPalette() -- Line: 389
                -- upvalues: palette (copy)
                for _, child in palette.container:GetChildren() do
                    if child:IsA("TextButton") then
                        child:Destroy();
                    end;
                end;
            end;

            local function createPaletteColorButton(u23) -- Line: 397
                -- upvalues: palette (copy), u2 (ref), TweenService (ref), u1 (ref), SkinToneSettings (copy), AvatarPreviewController (ref), updateBodyPartColors (copy), Remotes (ref)
                local u24 = script.colorPaletteButton:Clone();
                u24.BackgroundColor3 = u23;
                u24.Parent = palette.container;
                table.insert(u2.Current.Connections, u24.Activated:Connect(function() -- Line: 401
                    -- upvalues: u24 (copy), TweenService (ref), u1 (ref), SkinToneSettings (ref), u23 (copy), AvatarPreviewController (ref), updateBodyPartColors (ref), Remotes (ref)
                    local colorPaletteHover = u24:FindFirstChild("colorPaletteHover");

                    if colorPaletteHover then
                        TweenService:Create(colorPaletteHover, u1, {
                            Transparency = 1
                        }):Play();
                    end;

                    for i, v in SkinToneSettings.SelectedParts do
                        if v == true then
                            SkinToneSettings.BodyColors[i] = u23;
                        end;
                    end;

                    local BodyColors = SkinToneSettings.BodyColors;
                    local CurrentCatalogPreviewObject = AvatarPreviewController.CurrentCatalogPreviewObject;

                    if CurrentCatalogPreviewObject then
                        local AppliedDescription = CurrentCatalogPreviewObject.AppliedDescription;
                        local v25 = CurrentCatalogPreviewObject.Rig:WaitForChild("Body Colors");

                        if AppliedDescription and v25 then
                            for i, v in BodyColors do
                                AppliedDescription[i .. "Color"] = v;
                                v25[i .. "Color3"] = v;
                            end;
                        end;
                    end;

                    updateBodyPartColors();
                    Remotes.SetSkinTones:FireServer(SkinToneSettings.BodyColors);
                end));
                table.insert(u2.Current.Connections, u24.MouseEnter:Connect(function() -- Line: 417
                    -- upvalues: u24 (copy), TweenService (ref), u1 (ref)
                    local v26 = script.colorPaletteHover:Clone();
                    local Transparency = v26.Transparency;
                    v26.Transparency = 1;
                    v26.Parent = u24;
                    TweenService:Create(v26, u1, {
                        Transparency = Transparency
                    }):Play();
                end));
                table.insert(u2.Current.Connections, u24.MouseLeave:Connect(function() -- Line: 426
                    -- upvalues: u24 (copy)
                    if u24:FindFirstChild("colorPaletteHover") then
                        u24.colorPaletteHover:Destroy();
                    end;
                end));
            end;

            local function updatePalette() -- Line: 433
                -- upvalues: clearPalette (copy), SkinToneSettings (copy), SkinTonePresetColors (ref), createPaletteColorButton (copy)
                clearPalette();
                local v27;

                if SkinToneSettings.ShowAdvanced == true then
                    v27 = SkinTonePresetColors.Advanced;
                else
                    v27 = SkinTonePresetColors.Basic;
                end;

                for _, v in v27 do
                    createPaletteColorButton(Color3.fromHex(v));
                end;
            end;

            local function setCheckboxChecked(p28, p29) -- Line: 441
                -- upvalues: TweenService (ref), u1 (ref)
                TweenService:Create(p28.checked, u1, {
                    ImageTransparency = p29 and 0 or 1
                }):Play();
            end;

            local function fadeBodyPartSelected(p30, p31) -- Line: 445
                -- upvalues: bodyPartSelection (copy), TweenService (ref), u1 (ref)
                local u32 = bodyPartSelection.body:FindFirstChild(p30);

                if u32 then
                    if p31 then
                        u32.selected.Enabled = true;
                        TweenService:Create(u32.selected, u1, {
                            Transparency = 0
                        }):Play();

                        return;
                    end;

                    local v33 = TweenService:Create(u32.selected, u1, {
                        Transparency = 1
                    });
                    v33:Play();
                    v33.Completed:Once(function() -- Line: 454
                        -- upvalues: u32 (copy)
                        if u32.Transparency ~= 1 then
                            return;
                        end;

                        u32.selected.Enabled = false;
                    end);
                end;
            end;

            local function updateSelectedParts() -- Line: 462
                -- upvalues: SkinToneSettings (copy), bodyPartSelection (copy), TweenService (ref), u1 (ref), fadeBodyPartSelected (copy)
                local v34 = false;

                for i, v in SkinToneSettings.SelectedParts do
                    v34 = v == false and true or v34;
                    local v35 = bodyPartSelection.list:FindFirstChild(i);

                    if v35 then
                        TweenService:Create(v35.checkbox.checked, u1, {
                            ImageTransparency = v and 0 or 1
                        }):Play();
                    end;

                    fadeBodyPartSelected(i, v);
                end;

                TweenService:Create(bodyPartSelection.list.All.checkbox.checked, u1, {
                    ImageTransparency = v34 and 1 or 0
                }):Play();
                SkinToneSettings.SelectedAllParts = not v34;
            end;

            local function setupBodyPartSelectButton(u36) -- Line: 482
                -- upvalues: u2 (ref), SkinToneSettings (copy), updateSelectedParts (copy)
                table.insert(u2.Current.Connections, u36.Activated:Connect(function() -- Line: 483
                    -- upvalues: SkinToneSettings (ref), u36 (copy), updateSelectedParts (ref)
                    SkinToneSettings.SelectedParts[u36.Name] = not SkinToneSettings.SelectedParts[u36.Name];
                    updateSelectedParts();
                end));
            end;

            local function updateBodyPartColorsFromDescription(p37) -- Line: 489
                -- upvalues: SkinToneSettings (copy), updateBodyPartColors (copy)
                for i, _ in SkinToneSettings.SelectedParts do
                    print(i, p37[i .. "Color"]);
                    SkinToneSettings.BodyColors[i] = p37[i .. "Color"];
                end;

                if p37.HeadColor then
                    SkinToneSettings.CustomColor = p37.HeadColor;
                end;

                updateBodyPartColors();
            end;

            for _, child in bodyPartSelection.list:GetChildren() do
                if child:IsA("TextButton") and SkinToneSettings.SelectedParts[child.Name] ~= nil then
                    table.insert(u2.Current.Connections, child.Activated:Connect(function() -- Line: 483
                        -- upvalues: SkinToneSettings (copy), child (copy), updateSelectedParts (copy)
                        SkinToneSettings.SelectedParts[child.Name] = not SkinToneSettings.SelectedParts[child.Name];
                        updateSelectedParts();
                    end));
                elseif child.Name == "All" then
                    table.insert(u2.Current.Connections, child.Activated:Connect(function() -- Line: 504
                        -- upvalues: SkinToneSettings (copy), updateSelectedParts (copy)
                        SkinToneSettings.SelectedAllParts = not SkinToneSettings.SelectedAllParts;

                        for i, _ in SkinToneSettings.SelectedParts do
                            SkinToneSettings.SelectedParts[i] = SkinToneSettings.SelectedAllParts;
                        end;

                        updateSelectedParts();
                    end));
                end;
            end;

            for _, child in bodyPartSelection.body:GetChildren() do
                if child:IsA("Frame") == true then
                    local TextButton = Instance.new("TextButton");
                    TextButton.Text = "";
                    TextButton.Size = UDim2.fromScale(1, 1);
                    TextButton.BackgroundTransparency = 1;
                    TextButton.Parent = child;
                    table.insert(u2.Current.Connections, TextButton.Activated:Connect(function() -- Line: 522
                        -- upvalues: SkinToneSettings (copy), child (copy), updateSelectedParts (copy)
                        SkinToneSettings.SelectedParts[child.Name] = not SkinToneSettings.SelectedParts[child.Name];
                        updateSelectedParts();
                    end));
                end;
            end;

            table.insert(u2.Current.Connections, palette.advancedToggle.Activated:Connect(function() -- Line: 535
                -- upvalues: SkinToneSettings (copy), palette (copy), updatePalette (copy)
                SkinToneSettings.ShowAdvanced = not SkinToneSettings.ShowAdvanced;
                palette.advancedToggle.Text = SkinToneSettings.ShowAdvanced and "Show Basic" or "Show Advanced";
                updatePalette();
            end));
            table.insert(u2.Current.Connections, palette.advancedToggle.MouseEnter:Connect(function() -- Line: 541
                -- upvalues: palette (copy), SkinToneSettings (copy)
                palette.advancedToggle.Text = SkinToneSettings.ShowAdvanced and "<u>Show Basic</u>" or "<u>Show Advanced</u>";
            end));
            table.insert(u2.Current.Connections, palette.advancedToggle.MouseLeave:Connect(function() -- Line: 545
                -- upvalues: palette (copy), SkinToneSettings (copy)
                palette.advancedToggle.Text = SkinToneSettings.ShowAdvanced and "Show Basic" or "Show Advanced";
            end));
            local sliders = skinTonesSection.colors.sliders;
            local currentColor = skinTonesSection.colors.currentColor;
            local u38 = nil;
            local u39 = nil;

            local function getSaturationAndValuePositionFromColor(p40, p41) -- Line: 554
                if p41 <= p40 then
                    return 1 - p41 / 2;
                end;

                return p40 / 2;
            end;

            local function getSampledColor(p42, p43) -- Line: 562
                local Keypoints = p43.Keypoints;

                if p42 <= 0 then
                    return Keypoints[1].Value;
                end;

                if p42 >= 1 then
                    return Keypoints[#Keypoints].Value;
                end;

                for i = 1, #Keypoints - 1 do
                    if Keypoints[i].Time <= p42 and p42 <= Keypoints[i + 1].Time then
                        return Keypoints[i].Value:Lerp(Keypoints[i + 1].Value, (p42 - Keypoints[i].Time) / (Keypoints[i + 1].Time - Keypoints[i].Time));
                    end;
                end;

                return Keypoints[1].Value;
            end;

            local u44 = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.04, Color3.fromRGB(251, 212, 211)),
                ColorSequenceKeypoint.new(0.08, Color3.fromRGB(255, 219, 172)),
                ColorSequenceKeypoint.new(0.12, Color3.fromRGB(255, 205, 143)),
                ColorSequenceKeypoint.new(0.17, Color3.fromRGB(241, 163, 95)),
                ColorSequenceKeypoint.new(0.22, Color3.fromRGB(234, 161, 89)),
                ColorSequenceKeypoint.new(0.26, Color3.fromRGB(93, 57, 34)),
                ColorSequenceKeypoint.new(0.3, Color3.fromRGB(42, 21, 16)),
                ColorSequenceKeypoint.new(0.44, Color3.fromHSV(0, 1, 1)),
                ColorSequenceKeypoint.new(0.58, Color3.fromHSV(0.16, 1, 1)),
                ColorSequenceKeypoint.new(0.72, Color3.fromHSV(0.33, 1, 1)),
                ColorSequenceKeypoint.new(0.79, Color3.fromRGB(0, 255, 221)),
                ColorSequenceKeypoint.new(0.86, Color3.fromHSV(0.66, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromHSV(0.83, 1, 1))
            });
            local circle = sliders.saturationAndValue.slider.circle;
            local circle2 = sliders.hue.slider.circle;

            local function updateCustomColor(p45, p46, p47) -- Line: 595
                -- upvalues: u38 (ref), u39 (ref), getSampledColor (copy), u44 (copy), currentColor (copy), SkinToneSettings (copy), circle2 (copy), circle (copy), AvatarPreviewController (ref), updateBodyPartColors (copy), Remotes (ref)
                if u38 == nil or u39 == nil then
                    return;
                end;

                local v48 = getSampledColor(u39.Value / 100, u44);

                if p45 == nil then
                    local v49 = u38.Value / 100;

                    if v49 <= 0.5 then
                        p45 = Color3.new(1, 1, 1):Lerp(v48, v49 * 2);
                    else
                        p45 = v48:Lerp(Color3.new(0, 0, 0), (v49 - 0.5) * 2);
                    end;
                else
                    local v50, v51, v52 = p45:ToHSV();
                    u39:SetValue(v50 * 100, true, true);
                    local v53;

                    if v52 <= v51 then
                        v53 = 1 - v52 / 2;
                    else
                        v53 = v51 / 2;
                    end;

                    u38:SetValue(v53 * 100, true, true);
                    v48 = getSampledColor(u39.Value / 100, u44);
                end;

                currentColor.color.BackgroundColor3 = p45;
                currentColor.value.input.Text = "#" .. string.upper(p45:ToHex());
                SkinToneSettings.CustomColor = p45;
                circle2.BackgroundColor3 = v48;
                circle.BackgroundColor3 = p45;
                u38.Line.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(0.5, v48), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)) });

                if p46 then
                    for i, v in SkinToneSettings.SelectedParts do
                        if v then
                            SkinToneSettings.BodyColors[i] = p45;
                        end;
                    end;

                    local BodyColors = SkinToneSettings.BodyColors;
                    local CurrentCatalogPreviewObject = AvatarPreviewController.CurrentCatalogPreviewObject;

                    if CurrentCatalogPreviewObject then
                        local AppliedDescription = CurrentCatalogPreviewObject.AppliedDescription;
                        local v54 = CurrentCatalogPreviewObject.Rig:WaitForChild("Body Colors");

                        if AppliedDescription and v54 then
                            for i, v in BodyColors do
                                AppliedDescription[i .. "Color"] = v;
                                v54[i .. "Color3"] = v;
                            end;
                        end;
                    end;

                    updateBodyPartColors();

                    if p47 then
                        Remotes.SetSkinTones:FireServer(SkinToneSettings.BodyColors);
                    end;
                end;
            end;

            u38 = SliderController.new({
                MaxValue = 100,
                MinValue = 0,
                Instant = true,
                Increment = 0.1,
                SliderButton = sliders.saturationAndValue.slider,

                OnThumbUpdated = function(p55, p56) -- Line: 648, Name: OnThumbUpdated
                    -- upvalues: getSampledColor (copy), u39 (ref), u44 (copy), circle (copy), updateCustomColor (copy)
                    local v57 = p55 / 100;
                    local v58 = getSampledColor((not u39 and 0 or u39.Value) / 100, u44);
                    local v59;

                    if v57 <= 0.5 then
                        v59 = Color3.new(1, 1, 1):Lerp(v58, v57 * 2);
                    else
                        v59 = v58:Lerp(Color3.new(0, 0, 0), (v57 - 0.5) * 2);
                    end;

                    circle.BackgroundColor3 = v59;

                    if p56 then
                        return;
                    end;

                    updateCustomColor(nil, true, false);
                end
            });
            u39 = SliderController.new({
                MaxValue = 100,
                MinValue = 0,
                Instant = true,
                Increment = 0.1,
                SliderButton = sliders.hue.slider,

                OnThumbUpdated = function(p60, p61) -- Line: 670, Name: OnThumbUpdated
                    -- upvalues: getSampledColor (copy), u44 (copy), circle2 (copy), u38 (ref), circle (copy), updateCustomColor (copy)
                    local v62 = getSampledColor(p60 / 100, u44);
                    circle2.BackgroundColor3 = v62;
                    u38.Line.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(0.5, v62), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)) });
                    local v63 = u38.Value / 100;
                    local v64;

                    if v63 <= 0.5 then
                        v64 = Color3.new(1, 1, 1):Lerp(v62, v63 * 2);
                    else
                        v64 = v62:Lerp(Color3.new(0, 0, 0), (v63 - 0.5) * 2);
                    end;

                    circle.BackgroundColor3 = v64;

                    if p61 then
                        return;
                    end;

                    updateCustomColor(nil, true, false);
                end
            });
            u39.Line.UIGradient.Color = u44;
            table.insert(u2.Current.Connections, u38.OnInputEnded:Connect(function() -- Line: 696
                -- upvalues: updateCustomColor (copy)
                updateCustomColor(nil, true, true);
            end));
            table.insert(u2.Current.Connections, u39.OnInputEnded:Connect(function() -- Line: 700
                -- upvalues: updateCustomColor (copy)
                updateCustomColor(nil, true, true);
            end));
            table.insert(u2.Current.Connections, HumanoidDescriptionController.OnHumanoidDescriptionUpdated:Connect(updateBodyPartColorsFromDescription));
            currentColor.value.input.FocusLost:Connect(function() -- Line: 706
                -- upvalues: currentColor (copy), ParseTextToColor (ref), updateCustomColor (copy), SkinToneSettings (copy)
                local v65, v66 = ParseTextToColor(currentColor.value.input.Text);

                if v65 then
                    updateCustomColor(v65, true, true);

                    return;
                end;

                if v66 then
                    print("response:", v66);
                end;

                currentColor.value.input.Text = "#" .. string.upper(SkinToneSettings.CustomColor:ToHex());
            end);
            updatePalette();
            updateSelectedParts();
            updateBodyPartColorsFromDescription(HumanoidDescriptionController.GetCurrentDescription());
            u39:SetValue(0, true, true, true);
            u38:SetValue(50, true, true, true);
            updateCustomColor(nil, false, false);
        end;

        return;
    end;

    u2.Current.Page = bodyAdjustmentSection;
    bodyAdjustmentSection.Visible = true;
    local v67 = SliderController.new({
        MaxValue = 130,
        MinValue = 60,
        Increment = 5,
        SliderButton = bodyAdjustmentSection.height.slider,
        ValueBox = bodyAdjustmentSection.height.value.input
    });
    local v68 = SliderController.new({
        MaxValue = 130,
        MinValue = 60,
        Increment = 5,
        SliderButton = bodyAdjustmentSection.width.slider,
        ValueBox = bodyAdjustmentSection.width.value.input
    });
    local v69 = SliderController.new({
        MaxValue = 120,
        MinValue = 60,
        Increment = 5,
        SliderButton = bodyAdjustmentSection.depth.slider,
        ValueBox = bodyAdjustmentSection.depth.value.input
    });
    local v70 = SliderController.new({
        MaxValue = 100,
        MinValue = 0,
        Increment = 5,
        SliderButton = bodyAdjustmentSection.proportions.slider,
        ValueBox = bodyAdjustmentSection.proportions.value.input
    });
    local v71 = SliderController.new({
        MaxValue = 100,
        MinValue = 0,
        Increment = 5,
        SliderButton = bodyAdjustmentSection.bodyType.slider,
        ValueBox = bodyAdjustmentSection.bodyType.value.input
    });
    local v72 = SliderController.new({
        MaxValue = 110,
        MinValue = 80,
        Increment = 5,
        SliderButton = bodyAdjustmentSection.head.slider,
        ValueBox = bodyAdjustmentSection.head.value.input
    });

    local function u74(p73) -- Line: 186
        -- upvalues: AvatarPreviewController (ref)
        local CurrentCatalogPreviewObject = AvatarPreviewController.CurrentCatalogPreviewObject;

        if CurrentCatalogPreviewObject then
            print("got catalog preview:", CurrentCatalogPreviewObject);
            local AppliedDescription = CurrentCatalogPreviewObject.AppliedDescription;

            if AppliedDescription then
                for i, v in p73.Properties do
                    AppliedDescription[i] = v;
                end;

                print("updating with new description");
                CurrentCatalogPreviewObject.AppliedDescription = AppliedDescription;
                CurrentCatalogPreviewObject:Update(AppliedDescription, {
                    BypassIsApplied = true,
                    Quick = true
                });
            end;
        end;
    end;

    local function updateProperty(p75, p76) -- Line: 206
        -- upvalues: u74 (copy)
        local v77 = {};

        if typeof(p76) == "number" then
            p76 = p76 / 100;
        end;

        v77[p75] = p76;
        u74({
            Properties = v77
        });
    end;

    local function setupSliderEvents(u78, u79) -- Line: 215
        -- upvalues: u2 (ref), updateProperty (copy), Remotes (ref), TweenService (ref), u1 (ref), u19 (copy), CatalogUtilities (ref), addRobloxAllowedToLine (ref)
        table.insert(u2.Current.Connections, u78.OnValueUpdated:Connect(function(p80) -- Line: 216
            -- upvalues: updateProperty (ref), u79 (copy)
            updateProperty(u79, p80);
        end));
        table.insert(u2.Current.Connections, u78.OnInputEnded:Connect(function() -- Line: 221
            -- upvalues: u79 (copy), u78 (copy), Remotes (ref)
            local _, _ = Remotes.SetBodyAdjustment:InvokeServer({
                Type = "BodyScale",
                Properties = {
                    [u79] = u78.Value / 100
                }
            });
        end));
        local u81 = nil;
        table.insert(u2.Current.Connections, u78.SliderButton.MouseEnter:Connect(function() -- Line: 234
            -- upvalues: u81 (ref), u78 (copy), TweenService (ref), u1 (ref)
            if u81 then
                u81:Destroy();
            end;

            u81 = Instance.new("Frame");
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(1, 0);
            UICorner.Parent = u81;
            u81.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            u81.Size = UDim2.fromScale(1, 1);
            u81.Position = UDim2.fromScale(0.5, 0.5);
            u81.AnchorPoint = Vector2.new(0.5, 0.5);
            u81.BackgroundTransparency = 1;
            u81.Name = "hoverCircle";
            u81.Parent = u78.Circle;
            TweenService:Create(u81, u1, {
                BackgroundTransparency = 0.8,
                Size = UDim2.fromScale(2, 2)
            }):Play();
        end));
        table.insert(u2.Current.Connections, u78.SliderButton.MouseLeave:Connect(function() -- Line: 250
            -- upvalues: u81 (ref), TweenService (ref), u1 (ref)
            if u81 then
                TweenService:Create(u81, u1, {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1)
                }):Play();
                game.Debris:AddItem(u81, u1.Time);
            end;
        end));
        table.insert(u2.Current.Connections, u78.SliderButton.MouseButton1Down:Connect(function() -- Line: 258
            -- upvalues: u81 (ref), TweenService (ref), u1 (ref)
            if u81 then
                TweenService:Create(u81, u1, {
                    Size = UDim2.fromScale(2.5, 2.5)
                }):Play();
            end;
        end));
        table.insert(u2.Current.Connections, u78.SliderButton.MouseButton1Up:Connect(function() -- Line: 264
            -- upvalues: u81 (ref), TweenService (ref), u1 (ref)
            if u81 then
                TweenService:Create(u81, u1, {
                    Size = UDim2.fromScale(2, 2)
                }):Play();
            end;
        end));
        table.insert(u2.Current.Sliders, u78);

        if u19 then
            u78:SetValue(u19[u79] * 100, true, true);
        end;

        local Current = u2.Current;
        task.spawn(function() -- Line: 277
            -- upvalues: CatalogUtilities (ref), u2 (ref), Current (copy), addRobloxAllowedToLine (ref), u78 (copy), u79 (copy)
            while not CatalogUtilities.AvatarRules do
                task.wait(0.1);
            end;

            if u2.Current ~= Current then
                return;
            end;

            local Sliders = Current.Sliders;
            local v82 = addRobloxAllowedToLine(u78.Line, string.gsub(u79, "Scale", ""), u78.MinValue, u78.MaxValue);
            table.insert(Sliders, v82);
        end);
    end;

    local multiToggle = bodyAdjustmentSection.rigType.multiToggle;
    local u83 = false;

    local function setRigType(p84, p85) -- Line: 286
        -- upvalues: u83 (ref), Remotes (ref), HumanoidDescriptionController (ref)
        if u83 then
            return;
        end;

        u83 = true;
        print("new rig type:", p84);
        local _, _ = Remotes.SetBodyAdjustment:InvokeServer({
            Type = "RigType",
            RigType = p84
        });
        local v86 = HumanoidDescriptionController.GetHumanoid();

        if v86 then
            p85.SetChosenButton(v86.RigType.Name);
        end;

        u83 = false;
    end;

    local u87 = nil;
    u87 = setupMultiToggle(multiToggle, v20 and v20.RigType.Name or "R15", {
        R6 = {
            Button = multiToggle.R6,

            OnSelect = function() -- Line: 309, Name: OnSelect
                -- upvalues: setRigType (copy), u87 (ref)
                setRigType(Enum.HumanoidRigType.R6, u87);
            end
        },
        R15 = {
            Button = multiToggle.R15,

            OnSelect = function() -- Line: 315, Name: OnSelect
                -- upvalues: setRigType (copy), u87 (ref)
                setRigType(Enum.HumanoidRigType.R15, u87);
            end
        }
    });
    table.insert(u2.Current.Connections, HumanoidDescriptionController.OnHumanoidDescriptionUpdated:Connect(function() -- Line: 321
        -- upvalues: HumanoidDescriptionController (ref), u87 (ref)
        local v88 = HumanoidDescriptionController.GetHumanoid();

        if v88 then
            u87.SetChosenButton(v88.RigType.Name);
        end;
    end));
    setupSliderEvents(v67, "HeightScale");
    setupSliderEvents(v68, "WidthScale");
    setupSliderEvents(v69, "DepthScale");
    setupSliderEvents(v70, "ProportionScale");
    setupSliderEvents(v71, "BodyTypeScale");
    setupSliderEvents(v72, "HeadScale");
    table.insert(u2.Current.Connections, u87.Connections);
    local staticFacialAnimation = bodyAdjustmentSection:FindFirstChild("staticFacialAnimation");

    if staticFacialAnimation then
        local checked = staticFacialAnimation.checkbox.checked;
        local u89 = u19 and u19.StaticFacialAnimation or false;
        checked.ImageTransparency = u89 and 0 or 1;
        table.insert(u2.Current.Connections, staticFacialAnimation.checkbox.button.Activated:Connect(function() -- Line: 345
            -- upvalues: u89 (ref), TweenService (ref), checked (copy), u1 (ref), u74 (copy), Remotes (ref)
            u89 = not u89;
            TweenService:Create(checked, u1, {
                ImageTransparency = u89 and 0 or 1
            }):Play();
            u74({
                Properties = {
                    StaticFacialAnimation = u89
                }
            });
            Remotes.SetBodyAdjustment:InvokeServer({
                Type = "StaticFacialAnimation",
                Value = u89
            });
        end));
    end;
end;

function u2.RemoveCurrentPage(p90) -- Line: 729
    -- upvalues: u2 (copy), itemsSection (copy)
    if u2.Current.Page ~= nil then
        u2.Current.Page.Visible = false;

        if p90 then
            itemsSection.Visible = true;
        end;

        if u2.Current.Connections then
            for _, v in u2.Current.Connections do
                if typeof(v) == "table" then
                    for _, v2 in v do
                        pcall(function() -- Line: 741
                            -- upvalues: v2 (copy)
                            v2:Disconnect();
                        end);
                    end;
                else
                    v:Disconnect();
                end;
            end;
        end;

        if u2.Current.Sliders then
            for _, v in u2.Current.Sliders do
                if v.Destroy then
                    v:Destroy();
                else
                    v:Cleanup();
                end;
            end;
        end;

        u2.Current = {};
    end;
end;

local u91 = nil;

function u2.UpdateButtonColor(p92) -- Line: 765
    -- upvalues: TweenService (copy), u91 (ref), u1 (copy), ThemeController (copy)
    if p92 then
        TweenService:Create(u91.back.UIStroke, u1, {
            Transparency = 0
        }):Play();
        TweenService:Create(u91.back.WhiteRing, u1, {
            Transparency = 0
        }):Play();

        return;
    end;

    TweenService:Create(u91.back.UIStroke, u1, {
        Transparency = 1
    }):Play();
    TweenService:Create(u91.back.WhiteRing, u1, {
        Transparency = 1
    }):Play();
    TweenService:Create(u91.back, u1, {
        BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(229, 229, 229))
    }):Play();
    TweenService:Create(u91.label, u1, {
        TextColor3 = ThemeController.GetColor(Color3.fromRGB(33, 34, 39))
    }):Play();
    TweenService:Create(u91.image, u1, {
        ImageColor3 = ThemeController.GetColor(Color3.fromRGB(33, 34, 39))
    }):Play();
end;

function u2.Setup(p93, p94, u95, u96) -- Line: 778
    -- upvalues: u91 (ref), u2 (copy)
    u91 = p94;
    p93.Activated:Connect(function() -- Line: 780
        -- upvalues: u2 (ref), u96 (copy), u95 (copy)
        if u2.Current.Page == nil then
            u95();
        else
            u2.RemoveCurrentPage(true);

            if u96 then
                u96();
            end;
        end;
    end);
end;

return u2;