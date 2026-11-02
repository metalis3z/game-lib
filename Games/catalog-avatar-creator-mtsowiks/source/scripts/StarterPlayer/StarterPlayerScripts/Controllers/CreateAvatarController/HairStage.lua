-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local AvatarEditorService = game:GetService("AvatarEditorService");
local TweenService = game:GetService("TweenService");
local Modules = require(script.Parent.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local LoadingController = require(Modules.Controllers.LoadingController);
local Parent = require(script.Parent);
local Events = script.Parent.Parent.Parent:FindFirstChild("Events");

local function notify(p1) -- Line: 20
    -- upvalues: Events (copy)
    if Events and Events:FindFirstChild("Notify") then
        Events.Notify:Fire(p1);
    end;
end;

local _ = Players.LocalPlayer;
local CardBackground = ThemeController.BasePalette.CardBackground;
local SubtleStroke = ThemeController.BasePalette.SubtleStroke;
local ToggleBlue = ThemeController.BasePalette.ToggleBlue;
local TextHeading = ThemeController.BasePalette.TextHeading;
local DestructiveRed = ThemeController.BasePalette.DestructiveRed;
local u2 = {
    {
        name = "Black",
        keyword = "black hair",
        color = Color3.fromRGB(30, 30, 32)
    },
    {
        name = "Brown",
        keyword = "brown hair",
        color = Color3.fromRGB(92, 58, 34)
    },
    {
        name = "Blonde",
        keyword = "blonde hair",
        color = Color3.fromRGB(231, 198, 120)
    },
    {
        name = "Ginger",
        keyword = "ginger hair",
        color = Color3.fromRGB(201, 100, 41)
    },
    {
        name = "Red",
        keyword = "red hair",
        color = Color3.fromRGB(158, 42, 33)
    },
    {
        name = "White",
        keyword = "white hair",
        color = Color3.fromRGB(236, 236, 238)
    },
    {
        name = "Blue",
        keyword = "blue hair",
        color = Color3.fromRGB(46, 110, 222)
    },
    {
        name = "Pink",
        keyword = "pink hair",
        color = Color3.fromRGB(236, 120, 190)
    },
    {
        name = "Purple",
        keyword = "purple hair",
        color = Color3.fromRGB(140, 70, 200)
    },
    {
        name = "Green",
        keyword = "green hair",
        color = Color3.fromRGB(60, 170, 80)
    }
};
local v3 = {};

local function ensureTemplate() -- Line: 54
    -- upvalues: CardBackground (copy), TextHeading (copy), CollectionService (copy)
    local hairTile = script:FindFirstChild("hairTile");

    if hairTile then
        return hairTile;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "hairTile";
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.ClipsDescendants = false;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "preview";
    Frame2.AnchorPoint = Vector2.new(0.5, 0);
    Frame2.Position = UDim2.fromScale(0.5, 0);
    Frame2.Size = UDim2.fromScale(1, 0.88);
    Frame2.BackgroundColor3 = CardBackground;
    Frame2.BorderSizePixel = 0;
    Frame2.ClipsDescendants = true;
    Frame2.Parent = Frame;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0.05, 0);
    UICorner.Parent = Frame2;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "thumb";
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = "";
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.BorderSizePixel = 0;
    ImageLabel:SetAttribute("SkipThemeImage", true);
    ImageLabel.Parent = Frame2;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "name";
    TextLabel.AnchorPoint = Vector2.new(0, 1);
    TextLabel.Position = UDim2.fromScale(0.01, 1);
    TextLabel.Size = UDim2.new(0.95, 0, 0.1, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold);
    TextLabel.Text = "";
    TextLabel.TextColor3 = TextHeading;
    TextLabel.TextScaled = true;
    TextLabel.TextWrapped = true;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.TextYAlignment = Enum.TextYAlignment.Center;
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel.LineHeight = 1;
    TextLabel.BorderSizePixel = 0;
    TextLabel.Parent = Frame;
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "click";
    TextButton.Size = UDim2.fromScale(1, 1);
    TextButton.BackgroundTransparency = 1;
    TextButton.Text = "";
    TextButton.AutoButtonColor = false;
    TextButton.Style = Enum.ButtonStyle.Custom;
    TextButton.ZIndex = 10;
    TextButton.Parent = Frame;
    CollectionService:AddTag(TextButton, "UIEffectSoundOnly");
    Frame.Parent = script;

    return Frame;
end;

local function setTileSelected(p4, p5) -- Line: 120
    -- upvalues: ToggleBlue (copy)
    local preview = p4:FindFirstChild("preview");

    if not preview then
        return;
    end;

    local v6 = preview:FindFirstChildWhichIsA("UIStroke");

    if not p5 then
        if v6 then
            v6:Destroy();
        end;

        return;
    end;

    if not v6 then
        v6 = Instance.new("UIStroke");
        v6.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        v6.BorderStrokePosition = Enum.BorderStrokePosition.Outer;
        v6.LineJoinMode = Enum.LineJoinMode.Round;
        v6.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize;
        v6.Parent = preview;
    end;

    v6.Color = ToggleBlue;
    v6.Thickness = 2.5;
    v6.Transparency = 0;
end;

function v3.Open(u7, u8, u9, p10, u11, u12) -- Line: 141
    -- upvalues: ensureTemplate (copy), LoadingController (copy), ToggleBlue (copy), SubtleStroke (copy), u2 (copy), CollectionService (copy), TextHeading (copy), Parent (copy), CardBackground (copy), DestructiveRed (copy), TweenService (copy), Events (copy), setTileSelected (copy), AvatarEditorService (copy)
    local u13 = ensureTemplate();
    local u14 = {};
    local u15 = {};
    local u16 = true;
    local u17 = nil;

    local function cleanup() -- Line: 148
        -- upvalues: u16 (ref), LoadingController (ref), u17 (ref), u14 (copy), u15 (copy)
        u16 = false;
        LoadingController.RemoveLoading();

        if u17 then
            pcall(u17.Destroy, u17);
        end;

        for _, v in u14 do
            pcall(v.Disconnect, v);
        end;

        for _, v in u15 do
            pcall(task.cancel, v);
        end;
    end;

    u9.HairIds = u9.HairIds or {};

    local function indexOfHair(p18) -- Line: 159
        -- upvalues: u9 (copy)
        for i, v in u9.HairIds do
            if v == p18 then
                return i;
            end;
        end;

        return nil;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "swatches";
    Frame.AnchorPoint = Vector2.new(0, 0);
    Frame.Position = UDim2.fromScale(0, 0);
    Frame.Size = UDim2.fromScale(0.15, 1);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.Parent = u7;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Vertical;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top;
    UIListLayout.Padding = UDim.new(0.012, 0);
    UIListLayout.Parent = Frame;
    local u19 = {};

    local function ringSwatch(p20) -- Line: 199
        -- upvalues: u19 (copy), ToggleBlue (ref), SubtleStroke (ref)
        for i, v in u19 do
            local v21 = v:FindFirstChildWhichIsA("UIStroke");

            if v21 then
                v21.Color = i == p20 and ToggleBlue or SubtleStroke;
                v21.Thickness = i == p20 and 2.5 or 1.5;
            end;
        end;
    end;

    local u22 = nil;
    local u23 = nil;

    local function setDraftHairs() -- Line: 166
        -- upvalues: u8 (copy), u9 (copy)
        local u24 = {};
        local success, result = pcall(function() -- Line: 168
            -- upvalues: u8 (ref)
            return u8:GetAccessories(true);
        end);

        if success and typeof(result) == "table" then
            for _, v in result do
                if v.AccessoryType ~= Enum.AccessoryType.Hair then
                    table.insert(u24, v);
                end;
            end;
        end;

        for i, v in u9.HairIds do
            table.insert(u24, {
                IsLayered = true,
                Order = i,
                AccessoryType = Enum.AccessoryType.Hair,
                AssetId = v
            });
        end;

        pcall(function() -- Line: 177
            -- upvalues: u8 (ref), u24 (copy)
            u8:SetAccessories(u24, true);
        end);
    end;

    for i, v in u2 do
        local TextButton = Instance.new("TextButton");
        TextButton.Name = v.name;
        TextButton.LayoutOrder = i;
        TextButton.Size = UDim2.fromScale(1, 0.085);
        TextButton.BackgroundTransparency = 1;
        TextButton.AutoButtonColor = false;
        TextButton.Text = "";
        TextButton.Style = Enum.ButtonStyle.Custom;
        TextButton.Parent = Frame;
        CollectionService:AddTag(TextButton, "UIEffectSoundOnly");
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "circle";
        Frame2.AnchorPoint = Vector2.new(0, 0.5);
        Frame2.Position = UDim2.fromScale(0.04, 0.5);
        Frame2.Size = UDim2.fromScale(0, 0.74);
        Frame2.BackgroundColor3 = v.color;
        Frame2.BorderSizePixel = 0;
        Frame2:SetAttribute("SkipTheme", true);
        Frame2.Parent = TextButton;
        local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
        UIAspectRatioConstraint.AspectRatio = 1;
        UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height;
        UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize;
        UIAspectRatioConstraint.Parent = Frame2;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(1, 0);
        UICorner.Parent = Frame2;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
        UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize;
        UIStroke.Color = SubtleStroke;
        UIStroke.Thickness = 1.5;
        UIStroke.Parent = Frame2;
        u19[v] = Frame2;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "label";
        TextLabel.AnchorPoint = Vector2.new(0, 0.5);
        TextLabel.Position = UDim2.fromScale(0.42, 0.5);
        TextLabel.Size = UDim2.fromScale(0.56, 0.5);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium);
        TextLabel.Text = v.name;
        TextLabel.TextColor3 = TextHeading;
        TextLabel.TextScaled = true;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.TextYAlignment = Enum.TextYAlignment.Center;
        TextLabel.BorderSizePixel = 0;
        TextLabel.Parent = TextButton;
        table.insert(u14, TextButton.Activated:Connect(function() -- Line: 250
            -- upvalues: u23 (ref), v (copy), ringSwatch (copy), u11 (copy), u22 (ref)
            if u23 == v then
                u23 = nil;
            else
                u23 = v;
            end;

            ringSwatch(u23);
            u11.selectedSwatch = u23 and u23.name or nil;
            u22();
        end));
    end;

    local Frame2 = Instance.new("Frame");
    Frame2.Name = "right";
    Frame2.AnchorPoint = Vector2.new(1, 0);
    Frame2.Position = UDim2.fromScale(1, 0);
    Frame2.Size = UDim2.fromScale(0.83, 1);
    Frame2.BackgroundTransparency = 1;
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = u7;
    local Catalog = game:GetService("StarterGui"):FindFirstChild("Catalog");
    local v25 = nil;

    for _, v in { "container", "catalogSection", "topBar", "searchContainer" } do
        if Catalog then
            Catalog = Catalog:FindFirstChild(v);
        end;
    end;

    if Catalog then
        v25 = Catalog:Clone();
    end;

    local u26;

    if v25 then
        v25.Name = "searchContainer";
        v25.AnchorPoint = Vector2.new(0.5, 0);
        v25.Position = UDim2.fromScale(0.5, 0);
        v25.Size = UDim2.fromScale(1, 0.085);
        v25.Parent = Frame2;
        u26 = v25:FindFirstChild("wrapper");

        if u26 then
            u26 = u26:FindFirstChild("searchInput");
        end;

        if u26 then
            u26.PlaceholderText = "Search Hair";
            u26.ClearTextOnFocus = false;
            u26.Text = "";
        end;
    else
        u26 = nil;
    end;

    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "scroll";
    ScrollingFrame.AnchorPoint = Vector2.new(0.5, 1);
    ScrollingFrame.Position = UDim2.fromScale(0.5, 1);
    ScrollingFrame.Size = UDim2.fromScale(1, v25 and 0.9 or 1);
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.ClipsDescendants = true;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.CanvasSize = UDim2.new();
    ScrollingFrame.ScrollBarThickness = 3;
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255);
    ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right;
    ScrollingFrame.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable;
    ScrollingFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
    ScrollingFrame.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
    ScrollingFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
    ScrollingFrame.Parent = Frame2;
    CollectionService:AddTag(ScrollingFrame, "ScrollingFrameAutomaticSizeFix");
    local UIGridLayout = Instance.new("UIGridLayout");
    UIGridLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIGridLayout.StartCorner = Enum.StartCorner.TopLeft;
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    UIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Top;
    UIGridLayout.FillDirectionMaxCells = 4;
    UIGridLayout.CellSize = UDim2.new(0.25, -8, 1, 0);
    UIGridLayout.CellPadding = UDim2.new(0, 8, 0, 12);
    UIGridLayout.Parent = ScrollingFrame;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.AspectRatio = 0.9;
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width;
    UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize;
    UIAspectRatioConstraint.Parent = UIGridLayout;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingTop = UDim.new(0, 4);
    UIPadding.PaddingBottom = UDim.new(0, 4);
    UIPadding.PaddingLeft = UDim.new(0, 4);
    UIPadding.PaddingRight = UDim.new(0, 4);
    UIPadding.Parent = ScrollingFrame;

    local function updateContinueLabel() -- Line: 331
        -- upvalues: u9 (copy), Parent (ref)
        local v27 = #u9.HairIds > 0;
        Parent.SetContinueLabel(v27 and "Continue" or "Skip", not v27);
    end;

    local previewColumn = u7.Parent.Parent:FindFirstChild("previewColumn");

    if previewColumn then
        u17 = Instance.new("ScrollingFrame");
        u17.Name = "selectedHairs";
        u17.AnchorPoint = Vector2.new(0.5, 1);
        u17.Position = UDim2.fromScale(0.5, 1);
        u17.Size = UDim2.fromScale(1, 0.18);
        u17.BackgroundTransparency = 1;
        u17.BorderSizePixel = 0;
        u17.ZIndex = 5;
        u17.Visible = false;
        u17.ClipsDescendants = true;
        u17.ScrollingDirection = Enum.ScrollingDirection.X;
        u17.AutomaticCanvasSize = Enum.AutomaticSize.X;
        u17.CanvasSize = UDim2.new();
        u17.ScrollBarThickness = 0;
        u17.ScrollBarImageTransparency = 1;
        u17.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable;
        u17.Parent = previewColumn;
        local UIListLayout2 = Instance.new("UIListLayout");
        UIListLayout2.FillDirection = Enum.FillDirection.Horizontal;
        UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Left;
        UIListLayout2.VerticalAlignment = Enum.VerticalAlignment.Bottom;
        UIListLayout2.Padding = UDim.new(0.012, 0);
        UIListLayout2.Parent = u17;
        local UIPadding2 = Instance.new("UIPadding");
        UIPadding2.PaddingLeft = UDim.new(0, 6);
        UIPadding2.PaddingRight = UDim.new(0, 6);
        UIPadding2.PaddingBottom = UDim.new(0, 6);
        UIPadding2.PaddingTop = UDim.new(0, 0);
        UIPadding2.Parent = u17;
        CollectionService:AddTag(u17, "ScrollingFrameAutomaticSizeFix");
    end;

    local u28 = nil;
    local u29 = nil;

    local function findGridTile(p30) -- Line: 379
        -- upvalues: ScrollingFrame (copy)
        return ScrollingFrame:FindFirstChild((tostring(p30)));
    end;

    local function applyHairSelection() -- Line: 381
        -- upvalues: setDraftHairs (copy), u12 (copy), u9 (copy), Parent (ref), u28 (ref)
        setDraftHairs();
        pcall(u12);
        local v31 = #u9.HairIds > 0;
        Parent.SetContinueLabel(v31 and "Continue" or "Skip", not v31);
        u28();
    end;

    u28 = function() -- Line: 388, Name: refreshSelectedStrip
        -- upvalues: u17 (ref), u9 (copy), CardBackground (ref), DestructiveRed (ref), u14 (copy), TweenService (ref), CollectionService (ref), u29 (ref)
        if not u17 then
            return;
        end;

        for _, child in u17:GetChildren() do
            if child:IsA("GuiObject") then
                child:Destroy();
            end;
        end;

        local v32 = #u9.HairIds > 0;
        u17.Visible = v32;
        u17.CanvasPosition = Vector2.new(0, 0);

        if not v32 then
            return;
        end;

        for i, v in u9.HairIds do
            local TextButton = Instance.new("TextButton");
            TextButton.Name = "chip_" .. tostring(v);
            TextButton.LayoutOrder = i;
            TextButton.Size = UDim2.fromScale(0.23, 1);
            TextButton.BackgroundColor3 = CardBackground;
            TextButton.AutoButtonColor = false;
            TextButton.Text = "";
            TextButton.BorderSizePixel = 0;
            TextButton.ZIndex = 6;
            TextButton.Parent = u17;
            local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint");
            UIAspectRatioConstraint2.AspectRatio = 1;
            UIAspectRatioConstraint2.DominantAxis = Enum.DominantAxis.Width;
            UIAspectRatioConstraint2.AspectType = Enum.AspectType.FitWithinMaxSize;
            UIAspectRatioConstraint2.Parent = TextButton;
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(0.083, 0);
            UICorner.Parent = TextButton;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
            UIStroke.BorderStrokePosition = Enum.BorderStrokePosition.Inner;
            UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
            UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize;
            UIStroke.Color = DestructiveRed;
            UIStroke.Thickness = 2;
            UIStroke.Transparency = 1;
            UIStroke.Parent = TextButton;
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
            ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.Image = "rbxthumb://type=Asset&id=" .. v .. "&w=150&h=150";
            ImageLabel.ScaleType = Enum.ScaleType.Fit;
            ImageLabel.ZIndex = 6;
            ImageLabel:SetAttribute("SkipThemeImage", true);
            ImageLabel.Parent = TextButton;
            local UICorner2 = Instance.new("UICorner");
            UICorner2.CornerRadius = UDim.new(0.083, 0);
            UICorner2.Parent = ImageLabel;
            table.insert(u14, TextButton.MouseEnter:Connect(function() -- Line: 423
                -- upvalues: TweenService (ref), UIStroke (copy)
                TweenService:Create(UIStroke, TweenInfo.new(0.12), {
                    Transparency = 0
                }):Play();
            end));
            table.insert(u14, TextButton.MouseLeave:Connect(function() -- Line: 426
                -- upvalues: TweenService (ref), UIStroke (copy)
                TweenService:Create(UIStroke, TweenInfo.new(0.12), {
                    Transparency = 1
                }):Play();
            end));
            CollectionService:AddTag(TextButton, "UIEffectSoundOnly");
            table.insert(u14, TextButton.Activated:Connect(function() -- Line: 430
                -- upvalues: u29 (ref), v (copy)
                if u29 then
                    u29(v);
                end;
            end));
        end;
    end;

    local function addHair(p33) -- Line: 436
        -- upvalues: u9 (copy), Events (ref), ScrollingFrame (copy), setTileSelected (ref), setDraftHairs (copy), u12 (copy), Parent (ref), u28 (ref)
        for i, v in u9.HairIds do
            if v == p33 then
                break;
            end;
        end;

        if i then
            return;
        end;

        if #u9.HairIds >= 5 then
            local v34 = "⚠️ You can only pick up to " .. 5 .. " hairs";

            if Events and Events:FindFirstChild("Notify") then
                Events.Notify:Fire(v34);
            end;

            return;
        end;

        table.insert(u9.HairIds, p33);
        local v35 = ScrollingFrame:FindFirstChild((tostring(p33)));

        if v35 then
            setTileSelected(v35, true);
        end;

        setDraftHairs();
        pcall(u12);
        local v36 = #u9.HairIds > 0;
        Parent.SetContinueLabel(v36 and "Continue" or "Skip", not v36);
        u28();
    end;

    u29 = function(p37) -- Line: 447, Name: removeHair
        -- upvalues: u9 (copy), ScrollingFrame (copy), setDraftHairs (copy), u12 (copy), Parent (ref), u28 (ref)
        for i, v in u9.HairIds do
            if v == p37 then
                break;
            end;
        end;

        if not i then
            return;
        end;

        table.remove(u9.HairIds, i);
        local v38 = ScrollingFrame:FindFirstChild((tostring(p37)));

        if v38 then
            local preview = v38:FindFirstChild("preview");
            local v39 = preview and preview:FindFirstChildWhichIsA("UIStroke");

            if v39 then
                v39:Destroy();
            end;
        end;

        setDraftHairs();
        pcall(u12);
        local v40 = #u9.HairIds > 0;
        Parent.SetContinueLabel(v40 and "Continue" or "Skip", not v40);
        u28();
    end;

    local function chooseHair(p41, p42) -- Line: 457
        -- upvalues: u9 (copy), u29 (ref), addHair (ref)
        local Id = p42.Id;

        for i, v in u9.HairIds do
            if v == Id then
                break;
            end;
        end;

        if i then
            u29(p42.Id);

            return;
        end;

        addHair(p42.Id);
    end;

    local u43 = {};
    local u44 = 0;

    local function renderItem(u45) -- Line: 463
        -- upvalues: u16 (ref), u43 (ref), u44 (ref), u13 (copy), ScrollingFrame (copy), u9 (copy), setTileSelected (ref), u14 (copy), u29 (ref), addHair (ref)
        if not u16 or (not u45.Id or u43[u45.Id]) then
            return;
        end;

        u43[u45.Id] = true;
        u44 = u44 + 1;
        local u46 = u13:Clone();
        u46.Name = tostring(u45.Id);
        u46.LayoutOrder = u44;
        u46.name.Text = u45.Name or "";
        u46.preview.thumb.Image = "rbxthumb://type=Asset&id=" .. u45.Id .. "&w=420&h=420";
        u46.Parent = ScrollingFrame;
        local Id = u45.Id;

        for i, v in u9.HairIds do
            if v == Id then
                break;
            end;
        end;

        if i then
            setTileSelected(u46, true);
        end;

        table.insert(u14, u46.click.Activated:Connect(function() -- Line: 474
            -- upvalues: u46 (copy), u45 (copy), u9 (ref), u29 (ref), addHair (ref)
            local v47 = u45;
            local Id2 = v47.Id;

            for i, v in u9.HairIds do
                if v == Id2 then
                    break;
                end;
            end;

            if i then
                u29(v47.Id);

                return;
            end;

            addHair(v47.Id);
        end));
    end;

    local function renderItems(p48) -- Line: 476
        -- upvalues: renderItem (copy)
        for _, v in p48 do
            renderItem(v);
        end;
    end;

    u11.searchCache = u11.searchCache or {};
    local u49 = nil;

    local function startSearch(p50) -- Line: 480
        -- upvalues: u11 (copy), LoadingController (ref), ScrollingFrame (copy), u43 (ref), u44 (ref), u49 (ref), renderItem (copy), Frame2 (copy), u15 (copy), AvatarEditorService (ref), u16 (ref), u7 (copy)
        local u51 = p50 or "";
        u11.lastKeyword = u51;
        LoadingController.RemoveLoading();
        LoadingController.ClearGraphics("createAvatar");

        for _, child in ScrollingFrame:GetChildren() do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        u43 = {};
        u44 = 0;
        u49 = nil;
        local v52 = u11.searchCache[u51];

        if v52 then
            u49 = v52.pages;

            for _, v in v52.items do
                renderItem(v);
            end;

            return;
        end;

        LoadingController.DisplayLoading(Frame2, "overlay");
        table.insert(u15, task.spawn(function() -- Line: 502
            -- upvalues: u51 (ref), AvatarEditorService (ref), u16 (ref), LoadingController (ref), u7 (ref), u49 (ref), u11 (ref), renderItem (ref)
            local u53 = CatalogSearchParams.new();
            u53.AssetTypes = { Enum.AvatarAssetType.HairAccessory };
            u53.SortType = Enum.CatalogSortType.Relevance;
            u53.SalesTypeFilter = Enum.SalesTypeFilter.All;
            u53.Limit = 60;

            if u51 and u51 ~= "" then
                u53.SearchKeyword = u51;
                u53.IncludeOffSale = true;
            else
                u53.IncludeOffSale = false;
            end;

            local success, result = pcall(function() -- Line: 515
                -- upvalues: AvatarEditorService (ref), u53 (copy)
                return AvatarEditorService:SearchCatalog(u53);
            end);

            if not u16 then
                LoadingController.RemoveLoading();

                return;
            end;

            if not success or typeof(result) ~= "Instance" then
                LoadingController.RemoveLoading();
                LoadingController.DisplayGraphic(u7, "createAvatar", "noResults");

                return;
            end;

            u49 = result;
            local success2, result2 = pcall(function() -- Line: 523
                -- upvalues: u49 (ref)
                return u49:GetCurrentPage();
            end);
            LoadingController.RemoveLoading();

            if not u16 then
                return;
            end;

            if not success2 or typeof(result2) ~= "table" then
                LoadingController.DisplayGraphic(u7, "createAvatar", "noResults");

                return;
            end;

            u11.searchCache[u51] = {
                items = table.clone(result2),
                pages = u49
            };

            for _, v in result2 do
                renderItem(v);
            end;
        end));
    end;

    local function runSearch() -- Line: 536
        -- upvalues: u26 (ref), u23 (ref), startSearch (copy)
        startSearch(u26 and (u26.Text ~= "" and u26.Text) or (u23 and u23.keyword or ""));
    end;

    local u54 = false;

    local function loadMore() -- Line: 544
        -- upvalues: u54 (ref), u16 (ref), u49 (ref), LoadingController (ref), ScrollingFrame (copy), u15 (copy), renderItem (copy), u11 (copy)
        if u54 or (not u16 or (not u49 or u49.IsFinished)) then
            return;
        end;

        u54 = true;
        LoadingController.DisplayLoading(ScrollingFrame, "foot");
        table.insert(u15, task.spawn(function() -- Line: 548
            -- upvalues: u49 (ref), LoadingController (ref), u16 (ref), renderItem (ref), u11 (ref), u54 (ref)
            local success = pcall(function() -- Line: 549
                -- upvalues: u49 (ref)
                u49:AdvanceToNextPageAsync();
            end);
            local success2, result = pcall(function() -- Line: 550
                -- upvalues: u49 (ref)
                return u49:GetCurrentPage();
            end);
            LoadingController.RemoveLoading();

            if not u16 then
                return;
            end;

            if success and (success2 and typeof(result) == "table") then
                for _, v in result do
                    renderItem(v);
                end;

                local v55 = u11.searchCache[u11.lastKeyword];

                if v55 then
                    for _, v in result do
                        table.insert(v55.items, v);
                    end;
                end;
            end;

            u54 = false;
        end));
    end;

    local v56 = ScrollingFrame:GetPropertyChangedSignal("CanvasPosition");
    table.insert(u14, v56:Connect(function() -- Line: 562
        -- upvalues: ScrollingFrame (copy), loadMore (copy)
        local Y = ScrollingFrame.AbsoluteCanvasSize.Y;
        local Y2 = ScrollingFrame.AbsoluteWindowSize.Y;

        if Y <= Y2 then
            return;
        end;

        if ScrollingFrame.CanvasPosition.Y >= Y - Y2 - 80 then
            loadMore();
        end;
    end));

    if u26 then
        table.insert(u14, u26.FocusLost:Connect(function(p57) -- Line: 571
            -- upvalues: u26 (ref), u23 (ref), ringSwatch (copy), u11 (copy), runSearch (ref)
            if not p57 then
                return;
            end;

            if u26.Text ~= "" and u23 then
                u23 = nil;
                ringSwatch(nil);
                u11.selectedSwatch = nil;
            end;

            runSearch();
        end));
    end;

    if v25 then
        local clear = v25:FindFirstChild("clear");

        if clear and u26 then
            clear.Visible = u26.Text ~= "";
            local v58 = u26:GetPropertyChangedSignal("Text");
            table.insert(u14, v58:Connect(function() -- Line: 585
                -- upvalues: clear (copy), u26 (ref)
                clear.Visible = u26.Text ~= "";
            end));
            table.insert(u14, clear.Activated:Connect(function() -- Line: 588
                -- upvalues: u26 (ref), runSearch (ref)
                u26.Text = "";
                u26:CaptureFocus();
                runSearch();
            end));
        end;
    end;

    if u11.selectedSwatch then
        for _, v in u2 do
            if v.name == u11.selectedSwatch then
                u23 = v;
                break;
            end;
        end;
    end;

    ringSwatch(u23);
    runSearch();
    local v59 = #u9.HairIds > 0;
    Parent.SetContinueLabel(v59 and "Continue" or "Skip", not v59);
    u28();

    return cleanup;
end;

function v3.CanContinue(p60) -- Line: 611
    return true;
end;

return v3;