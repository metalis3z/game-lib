-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local AvatarEditorService = game:GetService("AvatarEditorService");
local TweenService = game:GetService("TweenService");
local Modules = require(script.Parent.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local LoadingController = require(Modules.Controllers.LoadingController);
local Cache = require(Modules.Services.Cache);
local GetBatchItemDetails = require(Modules.Utilities.GetBatchItemDetails);
local SortingSchema = require(ReplicatedStorage:WaitForChild("SortingSchema"));
require(Modules.Shared.CatalogUtilities);
local GetBundleDetailsBatch = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("GetBundleDetailsBatch");
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local v2 = SortingSchema.BodyAdjustment and SortingSchema.BodyAdjustment.Subcategories and SortingSchema.BodyAdjustment.Subcategories.HeadShapes;

if v2 and v2.Shapes then
    for _, v in v2.Shapes do
        table.insert(u1, v);
    end;

    table.sort(u1, function(p3, p4) -- Line: 37
        return (p3.LayoutOrder or 0) < (p4.LayoutOrder or 0);
    end);
end;

local CardBackground = ThemeController.BasePalette.CardBackground;
local SurfaceBackground = ThemeController.BasePalette.SurfaceBackground;
local SubtleStroke = ThemeController.BasePalette.SubtleStroke;
local ToggleBlue = ThemeController.BasePalette.ToggleBlue;
local TextHeading = ThemeController.BasePalette.TextHeading;
local TextMuted = ThemeController.BasePalette.TextMuted;
local v5 = {};

local function ensureTemplate() -- Line: 58
    -- upvalues: CardBackground (copy), TextHeading (copy), CollectionService (copy)
    local headTile = script:FindFirstChild("headTile");

    if headTile then
        return headTile;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "headTile";
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

local function setTileSelected(p6, p7) -- Line: 127
    -- upvalues: ToggleBlue (copy)
    local preview = p6:FindFirstChild("preview");

    if not preview then
        return;
    end;

    local v8 = preview:FindFirstChildWhichIsA("UIStroke");

    if not p7 then
        if v8 then
            v8:Destroy();
        end;

        return;
    end;

    if not v8 then
        v8 = Instance.new("UIStroke");
        v8.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        v8.BorderStrokePosition = Enum.BorderStrokePosition.Outer;
        v8.LineJoinMode = Enum.LineJoinMode.Round;
        v8.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize;
        v8.Parent = preview;
    end;

    v8.Color = ToggleBlue;
    v8.Thickness = 2.5;
    v8.Transparency = 0;
end;

local function showNotice(p9, p10) -- Line: 148
    -- upvalues: TextMuted (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "notice";
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = UDim2.fromScale(0.5, 0.5);
    TextLabel.Size = UDim2.fromScale(0.8, 0.16);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium);
    TextLabel.Text = p10;
    TextLabel.TextColor3 = TextMuted;
    TextLabel.TextScaled = true;
    TextLabel.TextWrapped = true;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center;
    TextLabel.TextYAlignment = Enum.TextYAlignment.Center;
    TextLabel.LineHeight = 1;
    TextLabel.BorderSizePixel = 0;
    TextLabel.Parent = p9;
end;

local function getHeadBPD(p11) -- Line: 167
    for _, child in p11:GetChildren() do
        if child:IsA("BodyPartDescription") and child.BodyPart == Enum.BodyPart.Head then
            return child;
        end;
    end;

    return nil;
end;

local function setDraftHeadShape(u12, u13) -- Line: 177
    -- upvalues: getHeadBPD (copy)
    local v14 = {};

    for _, v in { "HeadColor", "TorsoColor", "LeftArmColor", "RightArmColor", "LeftLegColor", "RightLegColor" } do
        v14[v] = u12[v];
    end;

    local u15 = getHeadBPD(u12);

    if u13 or u15 then
        if not u15 then
            u15 = Instance.new("BodyPartDescription");
            u15.BodyPart = Enum.BodyPart.Head;
            u15.Parent = u12;
        end;

        pcall(function() -- Line: 187
            -- upvalues: u15 (ref), u12 (copy), u13 (copy)
            u15.AssetId = u12.Head;
            u15.HeadShape = u13 or "";
        end);
    end;

    for i, v in v14 do
        pcall(function() -- Line: 192
            -- upvalues: u12 (copy), i (copy), v (copy)
            u12[i] = v;
        end);
    end;
end;

local function headSupportsShapes(u16) -- Line: 199
    -- upvalues: Cache (copy), GetBatchItemDetails (copy)
    if not u16 or u16 == 0 then
        return false;
    end;

    local v17 = Cache.Get("ItemDetails", (tostring(u16)));

    if v17 == nil then
        pcall(function() -- Line: 203
            -- upvalues: GetBatchItemDetails (ref), u16 (copy)
            GetBatchItemDetails({
                [u16] = {
                    ItemType = "Asset"
                }
            });
        end);
        v17 = Cache.Get("ItemDetails", (tostring(u16)));
    end;

    local v18;

    if v17 == nil then
        v18 = false;
    else
        v18 = v17.SupportsHeadShapes == true;
    end;

    return v18;
end;

function v5.Open(u19, u20, u21, p22, u23, u24) -- Line: 209
    -- upvalues: ensureTemplate (copy), LoadingController (copy), headSupportsShapes (copy), setDraftHeadShape (copy), CollectionService (copy), setTileSelected (copy), GetBundleDetailsBatch (copy), LocalPlayer (copy), AvatarEditorService (copy), SurfaceBackground (copy), SubtleStroke (copy), ToggleBlue (copy), TextHeading (copy), TweenService (copy), u1 (copy)
    local u25 = ensureTemplate();
    local u26 = {};
    local u27 = {};
    local u28 = true;

    local function cleanup() -- Line: 215
        -- upvalues: u28 (ref), LoadingController (ref), u26 (copy), u27 (copy)
        u28 = false;
        LoadingController.RemoveLoading();

        for _, v in u26 do
            pcall(v.Disconnect, v);
        end;

        for _, v in u27 do
            pcall(task.cancel, v);
        end;
    end;

    local u29 = u21.BodyHeadId or (u20.Head or 0);
    local u30 = u29;

    local function applyHead(u31, p32) -- Line: 235
        -- upvalues: u20 (copy), u21 (copy), u24 (copy)
        pcall(function() -- Line: 236
            -- upvalues: u20 (ref), u31 (copy)
            u20.Head = u31;
        end);
        u21.HeadAssetId = u31;
        pcall(u24, {
            Reset = true,
            Silent = not p32
        });
    end;

    local u33 = nil;

    local function scheduleSupport(u34) -- Line: 246
        -- upvalues: u33 (ref), u27 (copy), headSupportsShapes (ref), u28 (ref), u20 (copy)
        u33 = nil;
        table.insert(u27, task.spawn(function() -- Line: 249
            -- upvalues: headSupportsShapes (ref), u34 (copy), u28 (ref), u20 (ref), u34 (copy), u33 (ref)
            local v35 = headSupportsShapes(u34);

            if u28 and u20.Head == u34 then
                u33 = v35;
            end;
        end));
    end;

    local function applyShapeToDraft(p36) -- Line: 258
        -- upvalues: u20 (copy), u30 (ref), setDraftHeadShape (ref)
        pcall(function() -- Line: 259
            -- upvalues: u20 (ref), u30 (ref)
            u20.Head = u30;
        end);
        setDraftHeadShape(u20, p36);
    end;

    local u37 = u21.HeadlessHead == true;
    local Catalog = game:GetService("StarterGui"):FindFirstChild("Catalog");
    local u38 = nil;
    local u39 = nil;

    for _, v in { "container", "catalogSection", "topBar", "searchContainer" } do
        if Catalog then
            Catalog = Catalog:FindFirstChild(v);
        end;
    end;

    if Catalog then
        u38 = Catalog:Clone();
    end;

    local u40;

    if u38 then
        u38.Name = "searchContainer";
        u38.AnchorPoint = Vector2.new(0.5, 0);
        u38.Position = UDim2.fromScale(0.5, 0);
        u38.Size = UDim2.fromScale(1, 0.085);
        u38.Parent = u19;
        u40 = u38:FindFirstChild("wrapper");

        if u40 then
            u40 = u40:FindFirstChild("searchInput");
        end;

        if u40 then
            u40.PlaceholderText = "Search Heads";
            u40.ClearTextOnFocus = false;
            u40.Text = u23.lastKeyword or "";
        end;
    else
        u40 = nil;
    end;

    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "scroll";
    ScrollingFrame.AnchorPoint = Vector2.new(0.5, 1);
    ScrollingFrame.Position = UDim2.fromScale(0.5, 1);
    ScrollingFrame.Size = UDim2.fromScale(1, u38 and 0.9 or 1);
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
    ScrollingFrame.Parent = u19;
    CollectionService:AddTag(ScrollingFrame, "ScrollingFrameAutomaticSizeFix");
    local UIGridLayout = Instance.new("UIGridLayout");
    UIGridLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIGridLayout.StartCorner = Enum.StartCorner.TopLeft;
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    UIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Top;
    UIGridLayout.FillDirectionMaxCells = 5;
    UIGridLayout.CellSize = UDim2.new(0.2, -8, 1, 0);
    UIGridLayout.CellPadding = UDim2.new(0, 8, 0, 12);
    UIGridLayout.Parent = ScrollingFrame;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.AspectRatio = 0.9;
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width;
    UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize;
    UIAspectRatioConstraint.Parent = UIGridLayout;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingTop = UDim.new(0, 4);
    UIPadding.PaddingBottom = UDim.new(0.14, 0);
    UIPadding.PaddingLeft = UDim.new(0, 4);
    UIPadding.PaddingRight = UDim.new(0, 4);
    UIPadding.Parent = ScrollingFrame;
    local u41 = nil;

    local function selectTileVisual(p42) -- Line: 342
        -- upvalues: u41 (ref), setTileSelected (ref)
        if u41 == p42 then
            return;
        end;

        if u41 then
            local preview = u41:FindFirstChild("preview");
            local v43 = preview and preview:FindFirstChildWhichIsA("UIStroke");

            if v43 then
                v43:Destroy();
            end;
        end;

        setTileSelected(p42, true);
        u41 = p42;
    end;

    local function resolveBundleHead(u44, u45) -- Line: 350
        -- upvalues: u23 (copy), u27 (copy), GetBundleDetailsBatch (ref), u28 (ref)
        u23.bundleHeadById = u23.bundleHeadById or {};
        local v46 = u23.bundleHeadById[u44];

        if v46 then
            u45(v46);

            return;
        end;

        table.insert(u27, task.spawn(function() -- Line: 354
            -- upvalues: GetBundleDetailsBatch (ref), u44 (copy), u28 (ref), u23 (ref), u45 (copy)
            local v47, v48, v49 = pcall(function() -- Line: 355
                -- upvalues: GetBundleDetailsBatch (ref), u44 (ref)
                return GetBundleDetailsBatch:InvokeServer({ u44 });
            end);

            if not u28 then
                return;
            end;

            if v47 and (v48 and typeof(v49) == "table") then
                for _, v in v49 do
                    if v.Id == u44 and v.Items then
                        for _, v3 in v.Items do
                            if (v3.AssetTypeName == "DynamicHead" or v3.AssetTypeName == "Head") and typeof(v3.AssetId) == "number" then
                                u23.bundleHeadById[u44] = v3.AssetId;
                                u45(v3.AssetId);

                                return;
                            end;
                        end;
                    end;
                end;
            end;
        end));
    end;

    local function chooseHead(p50, u51) -- Line: 378
        -- upvalues: u37 (ref), u39 (ref), u41 (ref), setTileSelected (ref), u21 (copy), setDraftHeadShape (ref), u20 (copy), u23 (copy), u30 (ref), u29 (copy), applyHead (copy), u33 (ref), u27 (copy), headSupportsShapes (ref), u28 (ref), resolveBundleHead (copy)
        if u37 and u39 then
            u39();
        end;

        if u41 ~= p50 then
            if u41 then
                local preview = u41:FindFirstChild("preview");
                local v52 = preview and preview:FindFirstChildWhichIsA("UIStroke");

                if v52 then
                    v52:Destroy();
                end;
            end;

            setTileSelected(p50, true);
            u41 = p50;
        end;

        u21.HeadShape = nil;
        setDraftHeadShape(u20, nil);

        if u51 == nil then
            u21.HeadId = nil;
            u21.HeadIsBundle = nil;
            u23.selectedHeadId = nil;
            u30 = u29;
            applyHead(u29, true);
            local u53 = u29;
            u33 = nil;
            table.insert(u27, task.spawn(function() -- Line: 249
                -- upvalues: headSupportsShapes (ref), u53 (copy), u28 (ref), u20 (ref), u53 (copy), u33 (ref)
                local v54 = headSupportsShapes(u53);

                if u28 and u20.Head == u53 then
                    u33 = v54;
                end;
            end));

            return;
        end;

        u21.HeadId = u51.Id;
        u21.HeadIsBundle = u51.ItemType == "Bundle";
        u23.selectedHeadId = u51.Id;

        if u51.ItemType == "Bundle" then
            resolveBundleHead(u51.Id, function(u55) -- Line: 395
                -- upvalues: u21 (ref), u51 (copy), u30 (ref), applyHead (ref), u33 (ref), u27 (ref), headSupportsShapes (ref), u28 (ref), u20 (ref)
                if u21.HeadId == u51.Id then
                    u30 = u55;
                    applyHead(u55, true);
                    u33 = nil;
                    table.insert(u27, task.spawn(function() -- Line: 249
                        -- upvalues: headSupportsShapes (ref), u55 (copy), u28 (ref), u20 (ref), u55 (copy), u33 (ref)
                        local v56 = headSupportsShapes(u55);

                        if u28 and u20.Head == u55 then
                            u33 = v56;
                        end;
                    end));
                end;
            end);

            return;
        end;

        u30 = u51.Id;
        applyHead(u51.Id, true);
        local Id = u51.Id;
        u33 = nil;
        table.insert(u27, task.spawn(function() -- Line: 249
            -- upvalues: headSupportsShapes (ref), Id (copy), u28 (ref), u20 (ref), Id (copy), u33 (ref)
            local v57 = headSupportsShapes(Id);

            if u28 and u20.Head == Id then
                u33 = v57;
            end;
        end));
    end;

    local u58 = u25:Clone();
    u58.Name = "keepCurrent";
    u58.LayoutOrder = -1;
    u58.name.Text = "Keep Current";
    u58.preview.thumb.Image = u29 > 0 and "rbxthumb://type=Asset&id=" .. u29 .. "&w=420&h=420" or "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=420&h=420";
    u58.Parent = ScrollingFrame;
    table.insert(u26, u58.click.Activated:Connect(function() -- Line: 419
        -- upvalues: u58 (copy), u37 (ref), u39 (ref), u41 (ref), setTileSelected (ref), u21 (copy), setDraftHeadShape (ref), u20 (copy), u23 (copy), u30 (ref), u29 (copy), applyHead (copy), u33 (ref), u27 (copy), headSupportsShapes (ref), u28 (ref)
        local v59 = u58;

        if u37 and u39 then
            u39();
        end;

        if u41 ~= v59 then
            if u41 then
                local preview = u41:FindFirstChild("preview");
                local v60 = preview and preview:FindFirstChildWhichIsA("UIStroke");

                if v60 then
                    v60:Destroy();
                end;
            end;

            setTileSelected(v59, true);
            u41 = v59;
        end;

        u21.HeadShape = nil;
        setDraftHeadShape(u20, nil);
        u21.HeadId = nil;
        u21.HeadIsBundle = nil;
        u23.selectedHeadId = nil;
        u30 = u29;
        applyHead(u29, true);
        local u61 = u29;
        u33 = nil;
        table.insert(u27, task.spawn(function() -- Line: 249
            -- upvalues: headSupportsShapes (ref), u61 (copy), u28 (ref), u20 (ref), u61 (copy), u33 (ref)
            local v62 = headSupportsShapes(u61);

            if u28 and u20.Head == u61 then
                u33 = v62;
            end;
        end));
    end));

    if u23.selectedHeadId == nil then
        setTileSelected(u58, true);
        u41 = u58;
    end;

    local u63 = {};
    local u64 = 0;

    local function renderItem(u65) -- Line: 428
        -- upvalues: u28 (ref), u63 (ref), u64 (ref), u25 (copy), ScrollingFrame (copy), u23 (copy), u41 (ref), setTileSelected (ref), u26 (copy), chooseHead (copy)
        if not u28 or (not u65.Id or u63[u65.Id]) then
            return;
        end;

        u63[u65.Id] = true;
        u64 = u64 + 1;
        local u66 = u25:Clone();
        u66.Name = tostring(u65.Id);
        u66.LayoutOrder = u64;
        u66.name.Text = u65.Name or "";
        u66.preview.thumb.Image = u65.ItemType == "Bundle" and "rbxthumb://type=BundleThumbnail&id=" .. u65.Id .. "&w=420&h=420" or "rbxthumb://type=Asset&id=" .. u65.Id .. "&w=420&h=420";
        u66.Parent = ScrollingFrame;

        if u23.selectedHeadId == u65.Id and u41 ~= u66 then
            if u41 then
                local preview = u41:FindFirstChild("preview");
                local v67 = preview and preview:FindFirstChildWhichIsA("UIStroke");

                if v67 then
                    v67:Destroy();
                end;
            end;

            setTileSelected(u66, true);
            u41 = u66;
        end;

        table.insert(u26, u66.click.Activated:Connect(function() -- Line: 441
            -- upvalues: chooseHead (ref), u66 (copy), u65 (copy)
            chooseHead(u66, u65);
        end));
    end;

    local function renderItems(p68) -- Line: 443
        -- upvalues: renderItem (copy)
        for _, v in p68 do
            renderItem(v);
        end;
    end;

    u23.searchCache = u23.searchCache or {};
    local u69 = nil;

    local function startSearch(p70) -- Line: 448
        -- upvalues: u23 (copy), LoadingController (ref), ScrollingFrame (copy), u58 (copy), u41 (ref), u63 (ref), u64 (ref), u69 (ref), renderItem (copy), u19 (copy), u27 (copy), AvatarEditorService (ref), u28 (ref)
        local u71 = p70 or "";
        u23.lastKeyword = u71;
        LoadingController.RemoveLoading();
        LoadingController.ClearGraphics("createAvatar");

        for _, child in ScrollingFrame:GetChildren() do
            if child:IsA("Frame") and child ~= u58 then
                child:Destroy();
            end;
        end;

        if u41 ~= u58 then
            u41 = nil;
        end;

        u63 = {};
        u64 = 0;
        u69 = nil;
        local v72 = u23.searchCache[u71];

        if v72 then
            u69 = v72.pages;

            for _, v in v72.items do
                renderItem(v);
            end;

            return;
        end;

        LoadingController.DisplayLoading(u19, "overlay");
        table.insert(u27, task.spawn(function() -- Line: 471
            -- upvalues: u71 (ref), AvatarEditorService (ref), u28 (ref), LoadingController (ref), u19 (ref), u69 (ref), u23 (ref), renderItem (ref)
            local u73 = CatalogSearchParams.new();
            u73.AssetTypes = { Enum.AvatarAssetType.Head };
            u73.BundleTypes = { Enum.BundleType.DynamicHead };
            u73.SortType = Enum.CatalogSortType.Relevance;
            u73.SalesTypeFilter = Enum.SalesTypeFilter.All;
            u73.Limit = 60;

            if u71 and u71 ~= "" then
                u73.SearchKeyword = u71;
                u73.IncludeOffSale = true;
            else
                u73.IncludeOffSale = false;
            end;

            local success, result = pcall(function() -- Line: 488
                -- upvalues: AvatarEditorService (ref), u73 (copy)
                return AvatarEditorService:SearchCatalog(u73);
            end);

            if not u28 then
                LoadingController.RemoveLoading();

                return;
            end;

            if not success or typeof(result) ~= "Instance" then
                LoadingController.RemoveLoading();
                LoadingController.DisplayGraphic(u19, "createAvatar", "noResults");

                return;
            end;

            u69 = result;
            local success2, result2 = pcall(function() -- Line: 496
                -- upvalues: u69 (ref)
                return u69:GetCurrentPage();
            end);
            LoadingController.RemoveLoading();

            if not u28 then
                return;
            end;

            if not success2 or typeof(result2) ~= "table" then
                LoadingController.DisplayGraphic(u19, "createAvatar", "noResults");

                return;
            end;

            u23.searchCache[u71] = {
                items = table.clone(result2),
                pages = u69
            };

            for _, v in result2 do
                renderItem(v);
            end;
        end));
    end;

    local u74 = false;

    local function loadMore() -- Line: 510
        -- upvalues: u74 (ref), u28 (ref), u69 (ref), LoadingController (ref), ScrollingFrame (copy), u27 (copy), renderItem (copy), u23 (copy)
        if u74 or (not u28 or (not u69 or u69.IsFinished)) then
            return;
        end;

        u74 = true;
        LoadingController.DisplayLoading(ScrollingFrame, "foot");
        table.insert(u27, task.spawn(function() -- Line: 514
            -- upvalues: u69 (ref), LoadingController (ref), u28 (ref), renderItem (ref), u23 (ref), u74 (ref)
            local success = pcall(function() -- Line: 515
                -- upvalues: u69 (ref)
                u69:AdvanceToNextPageAsync();
            end);
            local success2, result = pcall(function() -- Line: 516
                -- upvalues: u69 (ref)
                return u69:GetCurrentPage();
            end);
            LoadingController.RemoveLoading();

            if not u28 then
                return;
            end;

            if success and (success2 and typeof(result) == "table") then
                for _, v in result do
                    renderItem(v);
                end;

                local v75 = u23.searchCache[u23.lastKeyword];

                if v75 then
                    for _, v in result do
                        table.insert(v75.items, v);
                    end;
                end;
            end;

            u74 = false;
        end));
    end;

    local v76 = ScrollingFrame:GetPropertyChangedSignal("CanvasPosition");
    table.insert(u26, v76:Connect(function() -- Line: 528
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

    if u40 then
        table.insert(u26, u40.FocusLost:Connect(function(p77) -- Line: 537
            -- upvalues: startSearch (copy), u40 (ref)
            if p77 then
                startSearch(u40.Text);
            end;
        end));
    end;

    if u38 then
        local clear = u38:FindFirstChild("clear");

        if clear and u40 then
            clear.Visible = u40.Text ~= "";
            local v78 = u40:GetPropertyChangedSignal("Text");
            table.insert(u26, v78:Connect(function() -- Line: 547
                -- upvalues: clear (copy), u40 (ref)
                clear.Visible = u40.Text ~= "";
            end));
            table.insert(u26, clear.Activated:Connect(function() -- Line: 550
                -- upvalues: u40 (ref), startSearch (copy)
                u40.Text = "";
                u40:CaptureFocus();
                startSearch("");
            end));
        end;
    end;

    local function restoreShape() -- Line: 559
        -- upvalues: u21 (copy), u20 (copy), u30 (ref), setDraftHeadShape (ref), u24 (copy)
        if typeof(u21.HeadShape) == "string" and u21.HeadShape ~= "" then
            local HeadShape = u21.HeadShape;
            pcall(function() -- Line: 259
                -- upvalues: u20 (ref), u30 (ref)
                u20.Head = u30;
            end);
            setDraftHeadShape(u20, HeadShape);
            pcall(u24, {
                Reset = true,
                Silent = true
            });
        end;
    end;

    if u21.HeadId == nil then
        u30 = u29;

        if not u37 then
            if u20.Head ~= u29 then
                applyHead(u29, false);
            end;

            u33 = nil;
            table.insert(u27, task.spawn(function() -- Line: 249
                -- upvalues: headSupportsShapes (ref), u29 (copy), u28 (ref), u20 (copy), u29 (copy), u33 (ref)
                local v79 = headSupportsShapes(u29);

                if u28 and u20.Head == u29 then
                    u33 = v79;
                end;
            end));
            restoreShape();
        end;
    elseif u21.HeadIsBundle == true then
        local HeadId = u21.HeadId;
        resolveBundleHead(HeadId, function(u80) -- Line: 572
            -- upvalues: u21 (copy), HeadId (copy), u30 (ref), u37 (ref), u20 (copy), applyHead (copy), u33 (ref), u27 (copy), headSupportsShapes (ref), u28 (ref), restoreShape (copy)
            if u21.HeadId ~= HeadId then
                return;
            end;

            u30 = u80;

            if not u37 then
                if u20.Head ~= u80 then
                    applyHead(u80, false);
                end;

                u33 = nil;
                table.insert(u27, task.spawn(function() -- Line: 249
                    -- upvalues: headSupportsShapes (ref), u80 (copy), u28 (ref), u20 (ref), u80 (copy), u33 (ref)
                    local v81 = headSupportsShapes(u80);

                    if u28 and u20.Head == u80 then
                        u33 = v81;
                    end;
                end));
                restoreShape();
            end;
        end);
    else
        u30 = u21.HeadId;

        if not u37 then
            if u20.Head ~= u21.HeadId then
                applyHead(u21.HeadId, false);
            end;

            local HeadId = u21.HeadId;
            u33 = nil;
            table.insert(u27, task.spawn(function() -- Line: 249
                -- upvalues: headSupportsShapes (ref), HeadId (copy), u28 (ref), u20 (copy), HeadId (copy), u33 (ref)
                local v82 = headSupportsShapes(HeadId);

                if u28 and u20.Head == HeadId then
                    u33 = v82;
                end;
            end));
            restoreShape();
        end;
    end;

    startSearch(u23.lastKeyword or "");
    local u83 = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);

    local function setHeadlessPreview(p84) -- Line: 607
        -- upvalues: u20 (copy), u24 (copy), applyHead (copy), u30 (ref), u33 (ref), u27 (copy), headSupportsShapes (ref), u28 (ref), restoreShape (copy)
        if p84 then
            pcall(function() -- Line: 609
                -- upvalues: u20 (ref)
                u20.Head = 15093053680;
            end);
            pcall(u24, {
                Reset = true
            });

            return;
        end;

        applyHead(u30, true);
        local u85 = u30;
        u33 = nil;
        table.insert(u27, task.spawn(function() -- Line: 249
            -- upvalues: headSupportsShapes (ref), u85 (copy), u28 (ref), u20 (ref), u85 (copy), u33 (ref)
            local v86 = headSupportsShapes(u85);

            if u28 and u20.Head == u85 then
                u33 = v86;
            end;
        end));
        restoreShape();
    end;

    local TextButton = Instance.new("TextButton");
    TextButton.Name = "headlessPill";
    TextButton.AnchorPoint = Vector2.new(0, 1);
    TextButton.Position = UDim2.fromScale(0.012, 0.985);
    TextButton.Size = UDim2.fromScale(0.29, 0.11);
    TextButton.BackgroundColor3 = SurfaceBackground;
    TextButton.AutoButtonColor = false;
    TextButton.Style = Enum.ButtonStyle.Custom;
    TextButton.Text = "";
    TextButton.BorderSizePixel = 0;
    TextButton.ZIndex = 10;
    TextButton.Parent = u19;
    CollectionService:AddTag(TextButton, "UIEffectSoundOnly");
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = TextButton;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.BorderStrokePosition = Enum.BorderStrokePosition.Outer;
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize;
    UIStroke.Color = SubtleStroke;
    UIStroke.Thickness = 1.5;
    UIStroke.Parent = TextButton;
    local Frame = Instance.new("Frame");
    Frame.Name = "checkbox";
    Frame.ZIndex = 10;
    Frame.BackgroundTransparency = 1;
    Frame.AnchorPoint = Vector2.new(0, 0.5);
    Frame.Position = UDim2.fromScale(0.065, 0.5);
    Frame.Size = UDim2.fromScale(0.4, 0.5);
    local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint2.AspectRatio = 1;
    UIAspectRatioConstraint2.DominantAxis = Enum.DominantAxis.Height;
    UIAspectRatioConstraint2.AspectType = Enum.AspectType.FitWithinMaxSize;
    UIAspectRatioConstraint2.Parent = Frame;
    Frame.Parent = TextButton;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = "rbxassetid://108840008135273";
    ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255);
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.ZIndex = 10;
    ImageLabel.Parent = Frame;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Name = "checked";
    ImageLabel2.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel2.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel2.Size = UDim2.fromScale(1, 1);
    ImageLabel2.BackgroundTransparency = 1;
    ImageLabel2.Image = "rbxassetid://71418101941296";
    ImageLabel2.ImageColor3 = ToggleBlue;
    ImageLabel2.ImageTransparency = u37 and 0 or 1;
    ImageLabel2.ScaleType = Enum.ScaleType.Fit;
    ImageLabel2.ZIndex = 10;
    ImageLabel2.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "label";
    TextLabel.ZIndex = 10;
    TextLabel.AnchorPoint = Vector2.new(0, 0.5);
    TextLabel.Position = UDim2.fromScale(0.25, 0.5);
    TextLabel.Size = UDim2.fromScale(0.7, 0.5);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "Headless Head";
    TextLabel.FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold);
    TextLabel.TextColor3 = TextHeading;
    TextLabel.TextScaled = true;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.TextYAlignment = Enum.TextYAlignment.Center;
    TextLabel.BorderSizePixel = 0;
    TextLabel.Parent = TextButton;

    u39 = function() -- Line: 644
        -- upvalues: u37 (ref), u21 (copy), TweenService (ref), ImageLabel2 (ref), u83 (copy)
        u37 = false;
        u21.HeadlessHead = nil;
        TweenService:Create(ImageLabel2, u83, {
            ImageTransparency = 1
        }):Play();
    end;

    table.insert(u26, TextButton.Activated:Connect(function() -- Line: 649
        -- upvalues: u37 (ref), u21 (copy), TweenService (ref), ImageLabel2 (ref), u83 (copy), setHeadlessPreview (copy)
        u37 = not u37;
        u21.HeadlessHead = u37 or nil;
        TweenService:Create(ImageLabel2, u83, {
            ImageTransparency = u37 and 0 or 1
        }):Play();
        setHeadlessPreview(u37);
    end));

    if u37 then
        pcall(function() -- Line: 609
            -- upvalues: u20 (copy)
            u20.Head = 15093053680;
        end);
        pcall(u24, {
            Reset = true
        });
    end;

    local u87 = nil;
    local u88 = nil;

    local function selectShapeTile(p89) -- Line: 662
        -- upvalues: u88 (ref), setTileSelected (ref)
        if u88 == p89 then
            return;
        end;

        if u88 then
            local preview = u88:FindFirstChild("preview");
            local v90 = preview and preview:FindFirstChildWhichIsA("UIStroke");

            if v90 then
                v90:Destroy();
            end;
        end;

        setTileSelected(p89, true);
        u88 = p89;
    end;

    local function chooseShape(p91, p92) -- Line: 668
        -- upvalues: u88 (ref), setTileSelected (ref), u21 (copy), u20 (copy), u30 (ref), setDraftHeadShape (ref), u24 (copy)
        if u88 ~= p91 then
            if u88 then
                local preview = u88:FindFirstChild("preview");
                local v93 = preview and preview:FindFirstChildWhichIsA("UIStroke");

                if v93 then
                    v93:Destroy();
                end;
            end;

            setTileSelected(p91, true);
            u88 = p91;
        end;

        u21.HeadShape = p92;
        pcall(function() -- Line: 259
            -- upvalues: u20 (ref), u30 (ref)
            u20.Head = u30;
        end);
        setDraftHeadShape(u20, p92);
        pcall(u24, {
            Reset = true
        });
    end;

    local function buildShapePicker() -- Line: 674
        -- upvalues: u87 (ref), u19 (copy), TextHeading (ref), CollectionService (ref), u21 (copy), u25 (copy), u20 (copy), LocalPlayer (ref), u26 (copy), u88 (ref), setTileSelected (ref), u30 (ref), setDraftHeadShape (ref), u24 (copy), u1 (ref)
        u87 = Instance.new("Frame");
        u87.Name = "shapePicker";
        u87.Size = UDim2.fromScale(1, 1);
        u87.BackgroundTransparency = 1;
        u87.BorderSizePixel = 0;
        u87.Parent = u19;
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.Name = "title";
        TextLabel2.AnchorPoint = Vector2.new(0.5, 0);
        TextLabel2.Position = UDim2.fromScale(0.5, 0);
        TextLabel2.Size = UDim2.fromScale(1, 0.06);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold);
        TextLabel2.Text = "Pick a head shape";
        TextLabel2.TextColor3 = TextHeading;
        TextLabel2.TextScaled = true;
        TextLabel2.TextWrapped = true;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.TextYAlignment = Enum.TextYAlignment.Center;
        TextLabel2.BorderSizePixel = 0;
        TextLabel2.Parent = u87;
        local ScrollingFrame2 = Instance.new("ScrollingFrame");
        ScrollingFrame2.Name = "scroll";
        ScrollingFrame2.AnchorPoint = Vector2.new(0.5, 1);
        ScrollingFrame2.Position = UDim2.fromScale(0.5, 1);
        ScrollingFrame2.Size = UDim2.fromScale(1, 0.92);
        ScrollingFrame2.BackgroundTransparency = 1;
        ScrollingFrame2.BorderSizePixel = 0;
        ScrollingFrame2.ClipsDescendants = true;
        ScrollingFrame2.ScrollingDirection = Enum.ScrollingDirection.Y;
        ScrollingFrame2.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        ScrollingFrame2.CanvasSize = UDim2.new();
        ScrollingFrame2.ScrollBarThickness = 3;
        ScrollingFrame2.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255);
        ScrollingFrame2.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right;
        ScrollingFrame2.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable;
        ScrollingFrame2.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
        ScrollingFrame2.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
        ScrollingFrame2.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
        ScrollingFrame2.Parent = u87;
        CollectionService:AddTag(ScrollingFrame2, "ScrollingFrameAutomaticSizeFix");
        local UIGridLayout2 = Instance.new("UIGridLayout");
        UIGridLayout2.FillDirection = Enum.FillDirection.Horizontal;
        UIGridLayout2.StartCorner = Enum.StartCorner.TopLeft;
        UIGridLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
        UIGridLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Left;
        UIGridLayout2.VerticalAlignment = Enum.VerticalAlignment.Top;
        UIGridLayout2.FillDirectionMaxCells = 5;
        UIGridLayout2.CellSize = UDim2.new(0.2, -8, 1, 0);
        UIGridLayout2.CellPadding = UDim2.new(0, 8, 0, 12);
        UIGridLayout2.Parent = ScrollingFrame2;
        local UIAspectRatioConstraint3 = Instance.new("UIAspectRatioConstraint");
        UIAspectRatioConstraint3.AspectRatio = 0.9;
        UIAspectRatioConstraint3.DominantAxis = Enum.DominantAxis.Width;
        UIAspectRatioConstraint3.AspectType = Enum.AspectType.ScaleWithParentSize;
        UIAspectRatioConstraint3.Parent = UIGridLayout2;
        local UIPadding2 = Instance.new("UIPadding");
        UIPadding2.PaddingTop = UDim.new(0, 4);
        UIPadding2.PaddingBottom = UDim.new(0, 4);
        UIPadding2.PaddingLeft = UDim.new(0, 4);
        UIPadding2.PaddingRight = UDim.new(0, 4);
        UIPadding2.Parent = ScrollingFrame2;
        local v94;

        if typeof(u21.HeadShape) == "string" and u21.HeadShape ~= "" then
            v94 = u21.HeadShape or nil;
        else
            v94 = nil;
        end;

        local u95 = u25:Clone();
        u95.Name = "none";
        u95.LayoutOrder = -1;
        u95.name.Text = "None";
        u95.preview.thumb.Image = u20.Head and (u20.Head > 0 and "rbxthumb://type=Asset&id=" .. u20.Head .. "&w=420&h=420") or "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=420&h=420";
        u95.Parent = ScrollingFrame2;
        table.insert(u26, u95.click.Activated:Connect(function() -- Line: 748
            -- upvalues: u95 (copy), u88 (ref), setTileSelected (ref), u21 (ref), u20 (ref), u30 (ref), setDraftHeadShape (ref), u24 (ref)
            local v96 = u95;

            if u88 ~= v96 then
                if u88 then
                    local preview = u88:FindFirstChild("preview");
                    local v97 = preview and preview:FindFirstChildWhichIsA("UIStroke");

                    if v97 then
                        v97:Destroy();
                    end;
                end;

                setTileSelected(v96, true);
                u88 = v96;
            end;

            u21.HeadShape = nil;
            pcall(function() -- Line: 259
                -- upvalues: u20 (ref), u30 (ref)
                u20.Head = u30;
            end);
            setDraftHeadShape(u20, nil);
            pcall(u24, {
                Reset = true
            });
        end));

        if v94 == nil then
            setTileSelected(u95, true);
            u88 = u95;
        end;

        for i, v in u1 do
            local u98 = u25:Clone();
            u98.Name = v.Key;
            u98.LayoutOrder = i;
            u98.name.Text = v.Name;
            u98.preview.thumb.Image = "rbxthumb://type=Asset&id=" .. v.AssetId .. "&w=420&h=420";
            u98.Parent = ScrollingFrame2;
            table.insert(u26, u98.click.Activated:Connect(function() -- Line: 758
                -- upvalues: u98 (copy), v (copy), u88 (ref), setTileSelected (ref), u21 (ref), u20 (ref), u30 (ref), setDraftHeadShape (ref), u24 (ref)
                local v99 = u98;
                local Key = v.Key;

                if u88 ~= v99 then
                    if u88 then
                        local preview = u88:FindFirstChild("preview");
                        local v100 = preview and preview:FindFirstChildWhichIsA("UIStroke");

                        if v100 then
                            v100:Destroy();
                        end;
                    end;

                    setTileSelected(v99, true);
                    u88 = v99;
                end;

                u21.HeadShape = Key;
                pcall(function() -- Line: 259
                    -- upvalues: u20 (ref), u30 (ref)
                    u20.Head = u30;
                end);
                setDraftHeadShape(u20, Key);
                pcall(u24, {
                    Reset = true
                });
            end));

            if v94 == v.Key then
                setTileSelected(u98, true);
                u88 = u98;
            end;
        end;
    end;

    local u101 = "browser";

    local function showBrowser() -- Line: 764
        -- upvalues: u101 (ref), u38 (ref), ScrollingFrame (copy), TextButton (copy), u87 (ref)
        u101 = "browser";

        if u38 then
            u38.Visible = true;
        end;

        ScrollingFrame.Visible = true;

        if TextButton then
            TextButton.Visible = true;
        end;

        if u87 then
            u87.Visible = false;
        end;
    end;

    local function showShapePicker() -- Line: 771
        -- upvalues: u101 (ref), u38 (ref), ScrollingFrame (copy), TextButton (copy), u87 (ref), u88 (ref), buildShapePicker (copy)
        u101 = "shape";

        if u38 then
            u38.Visible = false;
        end;

        ScrollingFrame.Visible = false;

        if TextButton then
            TextButton.Visible = false;
        end;

        if u87 then
            u87:Destroy();
            u87 = nil;
            u88 = nil;
        end;

        buildShapePicker();
    end;

    return {
        cleanup = cleanup,

        onContinue = function() -- Line: 782, Name: onContinue
            -- upvalues: u101 (ref), u37 (ref), u33 (ref), u38 (ref), ScrollingFrame (copy), TextButton (copy), u87 (ref), u88 (ref), buildShapePicker (copy)
            if u101 == "shape" then
                return false;
            end;

            if u37 then
                return false;
            end;

            if u33 ~= true then
                return false;
            end;

            u101 = "shape";

            if u38 then
                u38.Visible = false;
            end;

            ScrollingFrame.Visible = false;

            if TextButton then
                TextButton.Visible = false;
            end;

            if u87 then
                u87:Destroy();
                u87 = nil;
                u88 = nil;
            end;

            buildShapePicker();

            return true;
        end,

        onBack = function() -- Line: 791, Name: onBack
            -- upvalues: u101 (ref), u38 (ref), ScrollingFrame (copy), TextButton (copy), u87 (ref)
            if u101 ~= "shape" then
                return false;
            end;

            u101 = "browser";

            if u38 then
                u38.Visible = true;
            end;

            ScrollingFrame.Visible = true;

            if TextButton then
                TextButton.Visible = true;
            end;

            if u87 then
                u87.Visible = false;
            end;

            return true;
        end
    };
end;

function v5.CanContinue(p102) -- Line: 802
    return true;
end;

return v5;