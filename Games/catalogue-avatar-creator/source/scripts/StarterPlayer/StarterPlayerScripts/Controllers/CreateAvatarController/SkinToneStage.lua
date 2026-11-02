-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local Modules = require(script.Parent.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local ParseTextToColor = require(Modules.Utilities.ParseTextToColor);
local SliderController = require(Modules.Elements.SliderController);
local ScrollFade = require(Modules.Elements.ScrollFade);
local SurfaceBackground = ThemeController.BasePalette.SurfaceBackground;
local SectionBackground = ThemeController.BasePalette.SectionBackground;
local PanelBackground = ThemeController.BasePalette.PanelBackground;
local SubtleStroke = ThemeController.BasePalette.SubtleStroke;
local ToggleBlue = ThemeController.BasePalette.ToggleBlue;
local TextPrimary = ThemeController.BasePalette.TextPrimary;
local Placeholder = ThemeController.BasePalette.Placeholder;
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u2 = { "HeadColor", "TorsoColor", "LeftArmColor", "RightArmColor", "LeftLegColor", "RightLegColor" };

local function normalizeHex(p3) -- Line: 30
    return string.lower((string.gsub(p3, "#", "")));
end;

local u4 = ColorSequence.new({
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

local function getSampledColor(p5, p6) -- Line: 55
    local Keypoints = p6.Keypoints;

    if p5 <= 0 then
        return Keypoints[1].Value;
    end;

    if p5 >= 1 then
        return Keypoints[#Keypoints].Value;
    end;

    for i = 1, #Keypoints - 1 do
        if Keypoints[i].Time <= p5 and p5 <= Keypoints[i + 1].Time then
            return Keypoints[i].Value:Lerp(Keypoints[i + 1].Value, (p5 - Keypoints[i].Time) / (Keypoints[i + 1].Time - Keypoints[i].Time));
        end;
    end;

    return Keypoints[1].Value;
end;

local function satValuePosFromColor(p7, p8) -- Line: 69
    if p8 <= p7 then
        return 1 - p8 / 2;
    end;

    return p7 / 2;
end;

local v9 = {};

local function ensureTemplate() -- Line: 81
    -- upvalues: SurfaceBackground (copy), ToggleBlue (copy), CollectionService (copy)
    local swatch = script:FindFirstChild("swatch");

    if swatch then
        return swatch;
    end;

    local TextButton = Instance.new("TextButton");
    TextButton.Name = "swatch";
    TextButton.Text = "";
    TextButton.AutoButtonColor = false;
    TextButton.Style = Enum.ButtonStyle.Custom;
    TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    TextButton.BorderSizePixel = 0;
    TextButton.AutoLocalize = false;
    TextButton:SetAttribute("SkipTheme", true);
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.AspectRatio = 1;
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width;
    UIAspectRatioConstraint.Parent = TextButton;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = TextButton;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "border";
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.BorderStrokePosition = Enum.BorderStrokePosition.Inner;
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
    UIStroke.Color = SurfaceBackground;
    UIStroke.Thickness = 0.035;
    UIStroke.Transparency = 0;
    UIStroke.ZIndex = 1;
    UIStroke.Parent = TextButton;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Name = "selected";
    UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke2.BorderStrokePosition = Enum.BorderStrokePosition.Inner;
    UIStroke2.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke2.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
    UIStroke2.Color = ToggleBlue;
    UIStroke2.Thickness = 0.12;
    UIStroke2.Transparency = 0;
    UIStroke2.ZIndex = 3;
    UIStroke2.Enabled = false;
    UIStroke2.Parent = TextButton;
    CollectionService:AddTag(TextButton, "UIEffectSoundOnly");
    TextButton.Parent = script;

    return TextButton;
end;

local function setSwatchSelected(p10, p11) -- Line: 139
    local selected = p10:FindFirstChild("selected");

    if selected then
        selected.Enabled = p11;
    end;
end;

local function addHover(p12) -- Line: 145
    -- upvalues: TweenService (copy), u1 (copy)
    if p12:FindFirstChild("hover") then
        return;
    end;

    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "hover";
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.BorderStrokePosition = Enum.BorderStrokePosition.Inner;
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
    UIStroke.Color = Color3.fromRGB(0, 0, 0);
    UIStroke.Thickness = 0.1;
    UIStroke.Transparency = 1;
    UIStroke.ZIndex = 2;
    UIStroke.Parent = p12;
    TweenService:Create(UIStroke, u1, {
        Transparency = 0.75
    }):Play();
end;

local function removeHover(p13) -- Line: 161
    local hover = p13:FindFirstChild("hover");

    if hover then
        hover:Destroy();
    end;
end;

local function zeroBorders(p14) -- Line: 166
    if p14:IsA("GuiObject") then
        p14.BorderSizePixel = 0;
    end;

    for _, descendant in p14:GetDescendants() do
        if descendant:IsA("GuiObject") then
            descendant.BorderSizePixel = 0;
        end;
    end;
end;

function v9.Open(p15, u16, u17, p18, u19, u20) -- Line: 173
    -- upvalues: ensureTemplate (copy), SurfaceBackground (copy), SubtleStroke (copy), ToggleBlue (copy), TextPrimary (copy), CollectionService (copy), PanelBackground (copy), Placeholder (copy), u4 (copy), zeroBorders (copy), SectionBackground (copy), ScrollFade (copy), u2 (copy), getSampledColor (copy), SliderController (copy), CatalogUtilities (copy), addHover (copy), ParseTextToColor (copy)
    local u21 = ensureTemplate();
    local u22 = {};
    local u23 = nil;
    local u24 = {};
    local u25 = nil;
    local u26 = nil;
    local u27 = true;
    local u28 = Color3.new(1, 1, 1);
    local u29 = Color3.new(0, 0, 0);
    local Frame = Instance.new("Frame");
    Frame.Name = "controls";
    Frame.AnchorPoint = Vector2.new(0, 0);
    Frame.Position = UDim2.fromScale(0, 0);
    Frame.Size = UDim2.fromScale(1, 0.1);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.Parent = p15;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "toggle";
    Frame2.AnchorPoint = Vector2.new(0, 0.5);
    Frame2.Position = UDim2.fromScale(0, 0.5);
    Frame2.Size = UDim2.fromScale(0.46, 0.82);
    Frame2.BackgroundColor3 = SurfaceBackground;
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = Frame2;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.BorderStrokePosition = Enum.BorderStrokePosition.Outer;
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize;
    UIStroke.Color = SubtleStroke;
    UIStroke.Thickness = 1.5;
    UIStroke.Parent = Frame2;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout.Parent = Frame2;

    local function makeSegment(p30, p31) -- Line: 219
        -- upvalues: ToggleBlue (ref), TextPrimary (ref), Frame2 (copy)
        local TextButton = Instance.new("TextButton");
        TextButton.Name = p30;
        TextButton.LayoutOrder = p31;
        TextButton.Size = UDim2.fromScale(0.5, 1);
        TextButton.BackgroundColor3 = ToggleBlue;
        TextButton.BackgroundTransparency = 1;
        TextButton.AutoButtonColor = false;
        TextButton.Style = Enum.ButtonStyle.Custom;
        TextButton.Text = p30;
        TextButton.FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold);
        TextButton.TextColor3 = TextPrimary;
        TextButton.TextScaled = true;
        TextButton.BorderSizePixel = 0;
        local UICorner2 = Instance.new("UICorner");
        UICorner2.CornerRadius = UDim.new(1, 0);
        UICorner2.Parent = TextButton;
        local UIPadding = Instance.new("UIPadding");
        UIPadding.PaddingTop = UDim.new(0.18, 0);
        UIPadding.PaddingBottom = UDim.new(0.18, 0);
        UIPadding.Parent = TextButton;
        TextButton.Parent = Frame2;

        return TextButton;
    end;

    local u32 = makeSegment("Basic", 1);
    local u33 = makeSegment("Advanced", 2);
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "scroll";
    ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0);
    ScrollingFrame.Position = UDim2.fromScale(0.5, 0.115);
    ScrollingFrame.Size = UDim2.fromScale(1, 0.6394);
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.ClipsDescendants = true;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.CanvasSize = UDim2.new();
    ScrollingFrame.ScrollBarThickness = 3;
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255);
    ScrollingFrame.ScrollBarImageTransparency = 0;
    ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right;
    ScrollingFrame.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable;
    ScrollingFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
    ScrollingFrame.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
    ScrollingFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
    ScrollingFrame.Parent = p15;
    CollectionService:AddTag(ScrollingFrame, "ScrollingFrameAutomaticSizeFix");
    local UIGridLayout = Instance.new("UIGridLayout");
    UIGridLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIGridLayout.StartCorner = Enum.StartCorner.TopLeft;
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    UIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Top;
    UIGridLayout.FillDirectionMaxCells = 8;
    UIGridLayout.CellSize = UDim2.new(0.125, -7, 1, 0);
    UIGridLayout.CellPadding = UDim2.new(0, 8, 0, 8);
    UIGridLayout.Parent = ScrollingFrame;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.AspectRatio = 1;
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width;
    UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize;
    UIAspectRatioConstraint.Parent = UIGridLayout;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingTop = UDim.new(0, 4);
    UIPadding.PaddingBottom = UDim.new(0, 4);
    UIPadding.PaddingLeft = UDim.new(0, 4);
    UIPadding.PaddingRight = UDim.new(0, 4);
    UIPadding.Parent = ScrollingFrame;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "sliderStrip";
    Frame3.AnchorPoint = Vector2.new(0.5, 1);
    Frame3.Position = UDim2.fromScale(0.5, 1);
    Frame3.Size = UDim2.fromScale(1, 0.24);
    Frame3.BackgroundTransparency = 1;
    Frame3.BorderSizePixel = 0;
    Frame3.Parent = p15;
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "currentColor";
    Frame4.AnchorPoint = Vector2.new(0, 0.5);
    Frame4.Position = UDim2.fromScale(0.02, 0.5);
    Frame4.Size = UDim2.fromScale(0.66, 0.66);
    Frame4.BackgroundColor3 = u28;
    Frame4.BorderSizePixel = 0;
    Frame4:SetAttribute("SkipTheme", true);
    Frame4.Parent = Frame3;
    local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint2.AspectRatio = 1;
    UIAspectRatioConstraint2.DominantAxis = Enum.DominantAxis.Height;
    UIAspectRatioConstraint2.AspectType = Enum.AspectType.FitWithinMaxSize;
    UIAspectRatioConstraint2.Parent = Frame4;
    local UICorner2 = Instance.new("UICorner");
    UICorner2.CornerRadius = UDim.new(0.24, 0);
    UICorner2.Parent = Frame4;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.BorderStrokePosition = Enum.BorderStrokePosition.Inner;
    UIStroke2.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke2.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
    UIStroke2.Color = SurfaceBackground;
    UIStroke2.Thickness = 0.065;
    UIStroke2.Parent = Frame4;
    local UIStroke3 = Instance.new("UIStroke");
    UIStroke3.BorderStrokePosition = Enum.BorderStrokePosition.Inner;
    UIStroke3.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke3.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
    UIStroke3.Color = PanelBackground;
    UIStroke3.Thickness = 0.06;
    UIStroke3.Parent = Frame4;
    local v34 = script.hexBox:Clone();
    v34.Name = "hexInput";
    v34.AnchorPoint = Vector2.new(0, 0.5);
    v34.Position = UDim2.fromScale(0.14, 0.5);
    v34.Size = UDim2.fromScale(0.22, 0.46);
    v34.Parent = Frame3;
    local input = v34:FindFirstChild("input");

    if input then
        input.ClearTextOnFocus = false;
        input.TextColor3 = TextPrimary;
        input.PlaceholderColor3 = Placeholder;
        input.PlaceholderText = "Enter HEX";
    end;

    local v35 = script.colorSliders:Clone();
    v35.Name = "colorSliders";
    v35.AnchorPoint = Vector2.new(1, 0.5);
    v35.Position = UDim2.fromScale(1, 0.5);
    v35.Size = UDim2.fromScale(0.58, 0.86);
    v35.Parent = Frame3;
    local slider = v35.hue.slider;
    local slider2 = v35.saturationAndValue.slider;
    local circle = slider.circle;
    local circle2 = slider2.circle;
    local line = slider2.line;
    slider.line.UIGradient.Color = u4;
    zeroBorders(v34);
    zeroBorders(v35);
    zeroBorders(Frame4);
    local Frame5 = Instance.new("Frame");
    Frame5.Name = "bottomFade";
    Frame5.AnchorPoint = Vector2.new(0.5, 1);
    Frame5.Position = UDim2.fromScale(0.5, ScrollingFrame.Position.Y.Scale + ScrollingFrame.Size.Y.Scale);
    Frame5.Size = UDim2.fromScale(1, 0.035);
    Frame5.BackgroundColor3 = SectionBackground;
    Frame5.BorderSizePixel = 0;
    Frame5.ZIndex = 5;
    Frame5.Active = false;
    Frame5.Parent = p15;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Rotation = -90;
    UIGradient.Color = ColorSequence.new(u28, u28);
    UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) });
    UIGradient.Parent = Frame5;
    local u36 = ScrollFade.new(ScrollingFrame, nil, Frame5);

    local function applyToAvatar(u37) -- Line: 373
        -- upvalues: u17 (copy), u16 (copy), u2 (ref), u20 (copy)
        u17.SkinColor = u37;

        if u16 then
            for _, v in u2 do
                pcall(function() -- Line: 377
                    -- upvalues: u16 (ref), v (copy), u37 (copy)
                    u16[v] = u37;
                end);
            end;

            u20();
        end;
    end;

    local function ringSwatch(p38) -- Line: 383
        -- upvalues: u23 (ref)
        local v39 = u23 and u23 ~= p38 and u23:FindFirstChild("selected");

        if v39 then
            v39.Enabled = false;
        end;

        u23 = p38;
        local v40 = p38 and p38:FindFirstChild("selected");

        if v40 then
            v40.Enabled = true;
        end;
    end;

    local function showCustom(p41) -- Line: 390
        -- upvalues: u19 (copy), Frame4 (copy), input (copy)
        u19.customHex = p41:ToHex();
        Frame4.BackgroundColor3 = p41;

        if input then
            input.Text = "#" .. string.upper(p41:ToHex());
        end;
    end;

    local function applyCustom(p42) -- Line: 398
        -- upvalues: applyToAvatar (copy), u19 (copy), u23 (ref), u25 (ref), u26 (ref), Frame4 (copy), input (copy)
        applyToAvatar(p42);
        u19.selectedSwatchHex = nil;
        local v43 = u23 and u23 ~= nil and u23:FindFirstChild("selected");

        if v43 then
            v43.Enabled = false;
        end;

        u23 = nil;

        if u25 then
            u19.hueValue = u25.Value;
        end;

        if u26 then
            u19.satValValue = u26.Value;
        end;

        u19.customHex = p42:ToHex();
        Frame4.BackgroundColor3 = p42;

        if input then
            input.Text = "#" .. string.upper(p42:ToHex());
        end;
    end;

    local function colorFromSliders() -- Line: 407
        -- upvalues: getSampledColor (ref), u25 (ref), u4 (ref), u26 (ref), u28 (copy), u29 (copy)
        local v44 = getSampledColor(u25.Value / 100, u4);
        local v45 = u26.Value / 100;

        if v45 <= 0.5 then
            return u28:Lerp(v44, v45 * 2);
        end;

        return v44:Lerp(u29, (v45 - 0.5) * 2);
    end;

    local function refreshSatValueVisual() -- Line: 417
        -- upvalues: u25 (ref), getSampledColor (ref), u4 (ref), circle (copy), line (copy), u28 (copy), u29 (copy), u26 (ref), circle2 (copy)
        if not u25 then
            return;
        end;

        local v46 = getSampledColor(u25.Value / 100, u4);
        circle.BackgroundColor3 = v46;
        line.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, u28), ColorSequenceKeypoint.new(0.5, v46), ColorSequenceKeypoint.new(1, u29) });
        local v47 = (u26 and u26.Value or 0) / 100;
        local v48;

        if v47 <= 0.5 then
            v48 = u28:Lerp(v46, v47 * 2);
        else
            v48 = v46:Lerp(u29, (v47 - 0.5) * 2);
        end;

        circle2.BackgroundColor3 = v48;
    end;

    u25 = SliderController.new({
        MaxValue = 100,
        MinValue = 0,
        Instant = true,
        Increment = 0.1,
        SliderButton = slider,

        OnThumbUpdated = function(p49, p50) -- Line: 432, Name: OnThumbUpdated
            -- upvalues: u26 (ref), refreshSatValueVisual (copy), u27 (ref), getSampledColor (ref), u25 (ref), u4 (ref), u28 (copy), u29 (copy), applyToAvatar (copy), u19 (copy), u23 (ref), Frame4 (copy), input (copy)
            if u26 then
                refreshSatValueVisual();
            end;

            if not (p50 or u27) then
                local v51 = getSampledColor(u25.Value / 100, u4);
                local v52 = u26.Value / 100;
                local v53;

                if v52 <= 0.5 then
                    v53 = u28:Lerp(v51, v52 * 2);
                else
                    v53 = v51:Lerp(u29, (v52 - 0.5) * 2);
                end;

                applyToAvatar(v53);
                u19.selectedSwatchHex = nil;
                local v54 = u23 and u23 ~= nil and u23:FindFirstChild("selected");

                if v54 then
                    v54.Enabled = false;
                end;

                u23 = nil;

                if u25 then
                    u19.hueValue = u25.Value;
                end;

                if u26 then
                    u19.satValValue = u26.Value;
                end;

                u19.customHex = v53:ToHex();
                Frame4.BackgroundColor3 = v53;

                if input then
                    input.Text = "#" .. string.upper(v53:ToHex());
                end;
            end;
        end
    });
    u26 = SliderController.new({
        MaxValue = 100,
        MinValue = 0,
        Instant = true,
        Increment = 0.1,
        SliderButton = slider2,

        OnThumbUpdated = function(p55, p56) -- Line: 439, Name: OnThumbUpdated
            -- upvalues: refreshSatValueVisual (copy), u27 (ref), getSampledColor (ref), u25 (ref), u4 (ref), u26 (ref), u28 (copy), u29 (copy), applyToAvatar (copy), u19 (copy), u23 (ref), Frame4 (copy), input (copy)
            refreshSatValueVisual();

            if not (p56 or u27) then
                local v57 = getSampledColor(u25.Value / 100, u4);
                local v58 = u26.Value / 100;
                local v59;

                if v58 <= 0.5 then
                    v59 = u28:Lerp(v57, v58 * 2);
                else
                    v59 = v57:Lerp(u29, (v58 - 0.5) * 2);
                end;

                applyToAvatar(v59);
                u19.selectedSwatchHex = nil;
                local v60 = u23 and u23 ~= nil and u23:FindFirstChild("selected");

                if v60 then
                    v60.Enabled = false;
                end;

                u23 = nil;

                if u25 then
                    u19.hueValue = u25.Value;
                end;

                if u26 then
                    u19.satValValue = u26.Value;
                end;

                u19.customHex = v59:ToHex();
                Frame4.BackgroundColor3 = v59;

                if input then
                    input.Text = "#" .. string.upper(v59:ToHex());
                end;
            end;
        end
    });

    local function syncSlidersFromColor(p61) -- Line: 445
        -- upvalues: u25 (ref), u26 (ref), refreshSatValueVisual (copy)
        if not (u25 and u26) then
            return;
        end;

        local v62, v63, v64 = p61:ToHSV();
        u25:SetValue(v62 * 100, true, true, true);
        local v65;

        if v64 <= v63 then
            v65 = 1 - v64 / 2;
        else
            v65 = v63 / 2;
        end;

        u26:SetValue(math.clamp(v65 * 100, 0, 100), true, true, true);
        refreshSatValueVisual();
    end;

    local function clearSwatches() -- Line: 455
        -- upvalues: ScrollingFrame (copy), u24 (copy), u23 (ref)
        for _, child in ScrollingFrame:GetChildren() do
            if child:IsA("TextButton") then
                child:Destroy();
            end;
        end;

        table.clear(u24);
        u23 = nil;
    end;

    local function renderPalette(p66) -- Line: 463
        -- upvalues: clearSwatches (copy), CatalogUtilities (ref), u21 (copy), ScrollingFrame (copy), u24 (copy), u22 (copy), applyToAvatar (copy), u23 (ref), u19 (copy), addHover (ref)
        clearSwatches();
        local v67;

        if p66 then
            v67 = CatalogUtilities.SkinTonePresetColors.Advanced;
        else
            v67 = CatalogUtilities.SkinTonePresetColors.Basic;
        end;

        local v68 = 0;

        for _, v in v67 do
            v68 = v68 + 1;
            local u69 = Color3.fromHex(v);
            local u70 = string.lower((string.gsub(v, "#", "")));
            local u71 = u21:Clone();
            u71.Name = u70;
            u71.LayoutOrder = v68;
            u71.BackgroundColor3 = u69;
            u71.Parent = ScrollingFrame;
            u24[u70] = u71;
            table.insert(u22, u71.Activated:Connect(function() -- Line: 477
                -- upvalues: applyToAvatar (ref), u69 (copy), u71 (copy), u23 (ref), u19 (ref), u70 (copy)
                applyToAvatar(u69);
                local v72 = u71;
                local v73 = u23 and u23 ~= v72 and u23:FindFirstChild("selected");

                if v73 then
                    v73.Enabled = false;
                end;

                u23 = v72;
                local v74 = v72 and v72:FindFirstChild("selected");

                if v74 then
                    v74.Enabled = true;
                end;

                u19.selectedSwatchHex = u70;
            end));
            table.insert(u22, u71.MouseEnter:Connect(function() -- Line: 482
                -- upvalues: addHover (ref), u71 (copy)
                addHover(u71);
            end));
            table.insert(u22, u71.MouseLeave:Connect(function() -- Line: 483
                -- upvalues: u71 (copy)
                local hover = u71:FindFirstChild("hover");

                if hover then
                    hover:Destroy();
                end;
            end));
        end;

        local v75 = u19.selectedSwatchHex and u24[u19.selectedSwatchHex];

        if v75 then
            local selected = v75:FindFirstChild("selected");

            if selected then
                selected.Enabled = true;
            end;

            u23 = v75;
        end;
    end;

    local u76 = u19.showAdvanced == true;

    local function styleToggle() -- Line: 493
        -- upvalues: u32 (copy), u76 (ref), u33 (copy)
        u32.BackgroundTransparency = u76 and 1 or 0;
        u33.BackgroundTransparency = u76 and 0 or 1;
    end;

    table.insert(u22, u32.Activated:Connect(function() -- Line: 497
        -- upvalues: u76 (ref), u19 (copy), u32 (copy), u33 (copy), renderPalette (copy)
        if not u76 then
            return;
        end;

        u76 = false;
        u19.showAdvanced = false;
        u32.BackgroundTransparency = u76 and 1 or 0;
        u33.BackgroundTransparency = u76 and 0 or 1;
        renderPalette(false);
    end));
    table.insert(u22, u33.Activated:Connect(function() -- Line: 502
        -- upvalues: u76 (ref), u19 (copy), u32 (copy), u33 (copy), renderPalette (copy)
        if u76 then
            return;
        end;

        u76 = true;
        u19.showAdvanced = true;
        u32.BackgroundTransparency = u76 and 1 or 0;
        u33.BackgroundTransparency = u76 and 0 or 1;
        renderPalette(true);
    end));

    if input then
        table.insert(u22, input.FocusLost:Connect(function() -- Line: 510
            -- upvalues: ParseTextToColor (ref), input (copy), syncSlidersFromColor (ref), applyToAvatar (copy), u19 (copy), u23 (ref), u25 (ref), u26 (ref), Frame4 (copy)
            local v77 = ParseTextToColor(input.Text);

            if v77 then
                syncSlidersFromColor(v77);
                applyToAvatar(v77);
                u19.selectedSwatchHex = nil;
                local v78 = u23 and u23 ~= nil and u23:FindFirstChild("selected");

                if v78 then
                    v78.Enabled = false;
                end;

                u23 = nil;

                if u25 then
                    u19.hueValue = u25.Value;
                end;

                if u26 then
                    u19.satValValue = u26.Value;
                end;

                u19.customHex = v77:ToHex();
                Frame4.BackgroundColor3 = v77;

                if input then
                    input.Text = "#" .. string.upper(v77:ToHex());
                end;
            else
                input.Text = "#" .. string.upper(Frame4.BackgroundColor3:ToHex());
            end;
        end));
    end;

    u32.BackgroundTransparency = u76 and 1 or 0;
    u33.BackgroundTransparency = u76 and 0 or 1;
    renderPalette(u76);
    u27 = false;

    if u19.customHex then
        u25:SetValue(u19.hueValue or 0, true, true, true);
        u26:SetValue(u19.satValValue or 50, true, true, true);
        refreshSatValueVisual();
        local v79 = Color3.fromHex(u19.customHex);
        u19.customHex = v79:ToHex();
        Frame4.BackgroundColor3 = v79;

        if input then
            input.Text = "#" .. string.upper(v79:ToHex());
        end;
    else
        u25:SetValue(0, true, true, true);
        u26:SetValue(50, true, true, true);
        refreshSatValueVisual();
        local v80 = getSampledColor(u25.Value / 100, u4);
        local v81 = u26.Value / 100;
        local v82;

        if v81 <= 0.5 then
            v82 = u28:Lerp(v80, v81 * 2);
        else
            v82 = v80:Lerp(u29, (v81 - 0.5) * 2);
        end;

        applyToAvatar(v82);
        u19.selectedSwatchHex = nil;
        local v83 = u23 and u23 ~= nil and u23:FindFirstChild("selected");

        if v83 then
            v83.Enabled = false;
        end;

        u23 = nil;

        if u25 then
            u19.hueValue = u25.Value;
        end;

        if u26 then
            u19.satValValue = u26.Value;
        end;

        u19.customHex = v82:ToHex();
        Frame4.BackgroundColor3 = v82;

        if input then
            input.Text = "#" .. string.upper(v82:ToHex());
        end;
    end;

    return function() -- Line: 543
        -- upvalues: u36 (copy), u25 (ref), u26 (ref), u22 (copy)
        pcall(function() -- Line: 544
            -- upvalues: u36 (ref)
            u36:Destroy();
        end);

        if u25 then
            pcall(function() -- Line: 545
                -- upvalues: u25 (ref)
                u25:Cleanup();
            end);
        end;

        if u26 then
            pcall(function() -- Line: 546
                -- upvalues: u26 (ref)
                u26:Cleanup();
            end);
        end;

        for _, v in u22 do
            pcall(v.Disconnect, v);
        end;

        table.clear(u22);
    end;
end;

function v9.CanContinue(p84) -- Line: 552
    return true;
end;

return v9;