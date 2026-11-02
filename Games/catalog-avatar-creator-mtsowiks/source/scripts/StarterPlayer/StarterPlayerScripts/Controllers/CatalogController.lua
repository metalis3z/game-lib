-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local AvatarEditorService = game:GetService("AvatarEditorService");
game:GetService("GuiService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("Debris");
game:GetService("MarketplaceService");
local Modules = require(script.Parent.Parent.Modules);
require(Modules.Controllers.ThemeController);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Parent:WaitForChild("Events");

local function getSetting(p1) -- Line: 19
    -- upvalues: Events (copy)
    if not Events.GetSetting:GetAttribute("bound") then
        Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
    end;

    return Events.GetSetting:Invoke(p1);
end;

local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local DropdownController = require(Modules.Elements.DropdownController);
local InventoryService = require(Modules.Services.InventoryService);
local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
require(Modules.Services.ItemPreviewService);
local ItemButton = require(Modules.Elements.ItemButton);
local ScrollingFrameCustomScrollSpeed = require(Modules.Elements.ScrollingFrameCustomScrollSpeed);
local ScrollFade = require(Modules.Elements.ScrollFade);
local FavoriteController = require(Modules.Controllers.FavoriteController);
require(Modules.Elements.DraggableList);
local Cache = require(Modules.Services.Cache);
require(Modules.Controllers.LoadingController);
local ShoppingCartController = require(Modules.Controllers.ShoppingCartController);
require(Modules.Controllers.SettingsController);
local Options = require(script:WaitForChild("Options"));
local ClothingAdjustment = require(script:WaitForChild("ClothingAdjustment"));
local BodyAdjustment = require(script:WaitForChild("BodyAdjustment"));
local ItemFade = require(script:WaitForChild("ItemFade"));
local EquippedController = require(script:WaitForChild("EquippedController"));
local SearchController = require(script:WaitForChild("SearchController"));
local CategoryController = require(script:WaitForChild("CategoryController"));
local SortingSchema = require(Modules.Shared.SortingSchema);
local u2 = false;
local Quad = Enum.EasingStyle.Quad;
local Out = Enum.EasingDirection.Out;

local function dprint(...) -- Line: 57
end;

local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local reference = PlayerGui:WaitForChild("Viewport"):WaitForChild("reference");
local Catalog = PlayerGui:WaitForChild("Catalog");
local container = Catalog:WaitForChild("container");
local avatarSection = container:WaitForChild("avatarSection");
local preview = avatarSection:WaitForChild("preview");
local viewport = preview:WaitForChild("viewport");
local noEquippedItems = avatarSection:WaitForChild("noEquippedItems");
local equippedItemsContainer = avatarSection:WaitForChild("equippedItemsContainer");
local catalogSection = container:WaitForChild("catalogSection");
local topBar = catalogSection:WaitForChild("topBar");
local bottomBar = catalogSection:WaitForChild("bottomBar");
local layeredClothingSortContainer = bottomBar.left:WaitForChild("layeredClothingSortContainer");
local button = layeredClothingSortContainer:WaitForChild("button");
local cartContainer = bottomBar.right:WaitForChild("cartContainer");
local button2 = cartContainer:WaitForChild("button");
local bodyAdjustContainer = bottomBar.left:WaitForChild("bodyAdjustContainer");
local button3 = bodyAdjustContainer:WaitForChild("button");
local returnButton = topBar:FindFirstChild("returnButton");
local frontPage = catalogSection:FindFirstChild("frontPage");
local searchContainer = topBar:FindFirstChild("searchContainer");
local searchInput = searchContainer:FindFirstChild("wrapper"):FindFirstChild("searchInput");
local clear = searchContainer:FindFirstChild("clear");
local activeFilters = catalogSection:FindFirstChild("activeFilters");
local closeButton = topBar:FindFirstChild("closeButton");
local itemsSection = catalogSection:FindFirstChild("itemsSection");
local itemsWrapper = itemsSection:FindFirstChild("itemsWrapper");
local container2 = itemsWrapper:FindFirstChild("container");
local divider = script:FindFirstChild("divider");
local topFade = itemsSection:FindFirstChild("topFade");
local bottomBuffer = itemsSection:FindFirstChild("bottomBuffer");
local categoryDropdown = topBar:FindFirstChild("categoryDropdown");
local subcategoryDropdown = topBar:FindFirstChild("subcategoryDropdown");
local typeDropdown = topBar:FindFirstChild("typeDropdown");
local v3;

if categoryDropdown then
    v3 = categoryDropdown:FindFirstChild("button");
else
    v3 = categoryDropdown;
end;

local u4;

if categoryDropdown then
    u4 = categoryDropdown:FindFirstChild("label");
else
    u4 = categoryDropdown;
end;

if categoryDropdown then
    categoryDropdown = categoryDropdown:FindFirstChild("dropdown");
end;

local v5;

if categoryDropdown then
    v5 = categoryDropdown:FindFirstChild("choice");
else
    v5 = categoryDropdown;
end;

local v6;

if subcategoryDropdown then
    v6 = subcategoryDropdown:FindFirstChild("button");
else
    v6 = subcategoryDropdown;
end;

local u7;

if subcategoryDropdown then
    u7 = subcategoryDropdown:FindFirstChild("label");
else
    u7 = subcategoryDropdown;
end;

local v8;

if subcategoryDropdown then
    v8 = subcategoryDropdown:FindFirstChild("dropdown");
else
    v8 = subcategoryDropdown;
end;

local v9;

if v8 then
    v9 = v8:FindFirstChild("choice");
else
    v9 = v8;
end;

local v10;

if typeDropdown then
    v10 = typeDropdown:FindFirstChild("button");
else
    v10 = typeDropdown;
end;

local u11;

if typeDropdown then
    u11 = typeDropdown:FindFirstChild("label");
else
    u11 = typeDropdown;
end;

local v12;

if typeDropdown then
    v12 = typeDropdown:FindFirstChild("dropdown");
else
    v12 = typeDropdown;
end;

local v13;

if v12 then
    v13 = v12:FindFirstChild("choice");
else
    v13 = v12;
end;

local optionsContainer = bottomBar.right:FindFirstChild("optionsContainer");
local u14 = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
require(Modules.Utilities.Readable);
local u15;

if subcategoryDropdown then
    u15 = subcategoryDropdown:GetAttribute("Visible") == true;
else
    u15 = false;
end;

local u16 = nil;
local u17 = nil;
local u18 = {
    IsOpen = false,
    Category = nil,
    CategoryData = nil,
    Subcategory = nil,
    SubcategoryData = nil,
    Type = nil,
    TypeData = nil,
    OnOpenListeners = {},
    OnCloseListeners = {},
    CurrentCategorySelectionMode = "Dropdowns",
    Connections = {},
    FrontPageVisible = true
};
local u19;

if returnButton then
    u19 = returnButton.Size;
else
    u19 = nil;
end;

local u20 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u21 = nil;
local u22 = {
    Items = nil,
    SearchParams = nil,
    LoadingThread = nil,
    LoadGeneration = 0,
    Connections = {},
    Objects = {},
    Categories = { "featured", "accessories", "hair", "clothing", "emotes" }
};

local function getFrontPageItems(u23, u24) -- Line: 182
    -- upvalues: u22 (copy), SortingSchema (copy), AvatarEditorService (copy)
    local v25 = u22;
    v25.LoadGeneration = v25.LoadGeneration + 1;
    local LoadGeneration = u22.LoadGeneration;

    if u22.SearchParams == nil then
        local v26 = {};

        for _, v in u22.Categories do
            local v27 = CatalogSearchParams.new();
            v27.Limit = 10;
            v27.SortType = Enum.CatalogSortType.Relevance;

            if v == "featured" then
                v27.CategoryFilter = Enum.CatalogCategoryFilter.Featured;
            elseif v == "accessories" then
                v27.AssetTypes = SortingSchema.Accessories.Subcategories.All.AssetTypes;
            elseif v == "hair" then
                v27.AssetTypes = SortingSchema.Accessories.Subcategories.Hair.AssetTypes;
            elseif v == "clothing" then
                v27.AssetTypes = SortingSchema.Clothing.Subcategories.All.AssetTypes;
            elseif v == "emotes" then
                v27.AssetTypes = SortingSchema.Animations.Subcategories.Emotes.AssetTypes;
            end;

            v26[v] = v27;
        end;

        u22.SearchParams = v26;
    end;

    if u22.LoadingThread then
        task.cancel(u22.LoadingThread);
        u22.LoadingThread = nil;
    end;

    if u22.Items == nil then
        u22.Items = {};
    end;

    for _, v in u22.Categories do
        if u22.Items[v] then
            u24(v, u22.Items[v]);
        end;
    end;

    local u28 = {};

    for _, v in u22.Categories do
        if not u22.Items[v] then
            table.insert(u28, v);
        end;
    end;

    if #u28 == 0 then
        return;
    end;

    local function loadCategory(p29) -- Line: 238
        -- upvalues: AvatarEditorService (ref), u22 (ref), LoadGeneration (copy), u24 (copy)
        local v30;

        while true do
            local v31;
            v31, v30 = pcall(AvatarEditorService.SearchCatalogAsync, AvatarEditorService, u22.SearchParams[p29]);

            if v31 then
                break;
            end;

            task.wait(1);
        end;

        local v32 = v30:GetCurrentPage();
        u22.Items[p29] = v32;

        if LoadGeneration == u22.LoadGeneration then
            u24(p29, v32);
        end;
    end;

    u22.LoadingThread = task.spawn(function() -- Line: 255
        -- upvalues: u23 (copy), u28 (copy), loadCategory (copy), u22 (ref)
        if u23 then
            for _, v in u28 do
                task.spawn(loadCategory, v);
            end;
        else
            for i, v in u28 do
                loadCategory(v);

                if i < #u28 then
                    task.wait(0.5);
                end;
            end;
        end;

        u22.LoadingThread = nil;
    end);
end;

local function setReturnButtonChildrenAlpha(p33) -- Line: 272
    -- upvalues: TweenService (copy), returnButton (copy), u14 (copy)
    TweenService:Create(returnButton, u14, {
        BackgroundTransparency = p33
    }):Play();
    returnButton.BackgroundTransparency = p33;

    for _, descendant in returnButton:GetDescendants() do
        if descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") then
            TweenService:Create(descendant, u14, {
                ImageTransparency = p33
            }):Play();
        elseif descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
            TweenService:Create(descendant, u14, {
                TextTransparency = p33
            }):Play();
        end;
    end;
end;

local function animateReturnButton(p34) -- Line: 287
    -- upvalues: returnButton (copy), u19 (copy), Events (copy), u21 (ref), setReturnButtonChildrenAlpha (copy), TweenService (copy), u20 (copy)
    if not (returnButton and u19) then
        return;
    end;

    if p34 then
        local v35 = { "Interface", "ShowCatalogFrontPage" };

        if not Events.GetSetting:GetAttribute("bound") then
            Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
        end;

        if Events.GetSetting:Invoke(v35) == false then
            p34 = false;
        end;
    end;

    if u21 then
        u21:Cancel();
        u21 = nil;
    end;

    if not p34 then
        setReturnButtonChildrenAlpha(1);
        local u36 = TweenService:Create(returnButton, u20, {
            Size = UDim2.new(0, 0, 0, 0)
        });
        u21 = u36;
        u36:Play();
        u36.Completed:Once(function() -- Line: 320
            -- upvalues: u21 (ref), u36 (copy), returnButton (ref), u19 (ref)
            if u21 == u36 then
                u21 = nil;
            end;

            returnButton.Visible = false;
            returnButton.Size = u19;
        end);

        return;
    end;

    setReturnButtonChildrenAlpha(1);
    returnButton.Size = UDim2.new(0, 0, 0, 0);
    returnButton.Visible = true;
    local u37 = TweenService:Create(returnButton, u20, {
        Size = u19
    });
    u21 = u37;
    u37:Play();
    u37.Completed:Once(function() -- Line: 307
        -- upvalues: u21 (ref), u37 (copy), setReturnButtonChildrenAlpha (ref)
        if u21 == u37 then
            u21 = nil;
        end;

        setReturnButtonChildrenAlpha(0);
    end);
end;

local function setFrontPageVisible(p38) -- Line: 330
    -- upvalues: Events (copy), u18 (copy), frontPage (copy), itemsSection (copy), u22 (copy), TweenService (copy), u14 (copy), SortingSchema (copy), getFrontPageItems (copy), RunService (copy), AvatarPreviewController (copy), LocalPlayer (copy), Remotes (copy), Cache (copy), animateReturnButton (copy), activeFilters (copy), Options (copy)
    if p38 then
        local v39 = { "Interface", "ShowCatalogFrontPage" };

        if not Events.GetSetting:GetAttribute("bound") then
            Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
        end;

        if Events.GetSetting:Invoke(v39) == false then
            p38 = false;
        end;
    end;

    u18.FrontPageVisible = p38;

    if frontPage then
        frontPage.Visible = p38;
    end;

    if itemsSection then
        itemsSection.Visible = not p38;
    end;

    for _, v in u22.Objects do
        pcall(v.Destroy, v);
    end;

    table.clear(u22.Objects);

    for _, v in u22.Connections do
        v:Disconnect();
    end;

    table.clear(u22.Connections);

    for _, child in frontPage:GetChildren() do
        if child:IsA("TextButton") then
            local v40 = child:FindFirstChild("itemsWrapper") and child.itemsWrapper:FindFirstChild("items");

            if v40 then
                v40.Position = UDim2.new(0, 0, v40.Position.Y.Scale, v40.Position.Y.Offset);
            end;
        end;
    end;

    if p38 then
        local v41 = { "Interface", "ReduceFrontPageVibrancy" };

        if not Events.GetSetting:GetAttribute("bound") then
            Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
        end;

        local v42 = Events.GetSetting:Invoke(v41) == true;
        local u43 = v42 and 0.6 or 0.1;
        local u44 = v42 and 0.5 or 0;

        for _, child in frontPage:GetChildren() do
            if child:IsA("TextButton") then
                child.BackgroundTransparency = u43;
                table.insert(u22.Connections, child.MouseEnter:Connect(function() -- Line: 370
                    -- upvalues: TweenService (ref), child (copy), u14 (ref), u44 (copy)
                    TweenService:Create(child, u14, {
                        BackgroundTransparency = u44
                    }):Play();
                end));
                table.insert(u22.Connections, child.MouseLeave:Connect(function() -- Line: 375
                    -- upvalues: TweenService (ref), child (copy), u14 (ref), u43 (copy)
                    TweenService:Create(child, u14, {
                        BackgroundTransparency = u43
                    }):Play();
                end));
                table.insert(u22.Connections, child.MouseButton1Click:Connect(function() -- Line: 381
                    -- upvalues: child (copy), u18 (ref), SortingSchema (ref)
                    if child.Name == "emotes" then
                        u18.UpdateSelectionState("Category", "Animations", SortingSchema.Animations);
                        u18.UpdateSelectionState("Subcategory", "Emotes", SortingSchema.Animations.Subcategories.Emotes);

                        return;
                    end;

                    local v45 = child.Name:sub(1, 1):upper() .. child.Name:sub(2);
                    u18.UpdateSelectionState("Category", v45, SortingSchema[v45]);
                end));
            end;
        end;

        getFrontPageItems(true, function(p46, u47) -- Line: 393
            -- upvalues: frontPage (ref), Events (ref), TweenService (ref), u22 (ref), RunService (ref), AvatarPreviewController (ref), LocalPlayer (ref), Remotes (ref), Cache (ref)
            local v48 = frontPage:FindFirstChild(p46);

            if not v48 then
                return;
            end;

            if p46 == "emotes" then
                local u49 = AvatarPreviewController.new(v48.viewport, nil, {
                    UpdateOnDescriptionApplied = true,
                    Distance = 1.5,
                    Target = LocalPlayer,
                    RigType = Enum.HumanoidRigType.R15
                });
                local GetEmote = Remotes:WaitForChild("GetEmote");
                local u59 = task.spawn(function() -- Line: 488
                    -- upvalues: u49 (copy), u47 (copy), Cache (ref), GetEmote (copy)
                    local v50 = u49:GetRig();
                    local v51 = v50 and v50:FindFirstChild("Humanoid") and v50.Humanoid:FindFirstChildOfClass("Animator");

                    if not v51 then
                        return;
                    end;

                    local v52 = 0;
                    local u53 = nil;

                    while true do
                        local v54;

                        while true do
                            local v55 = v52 + 1;
                            v52 = #u47 < v55 and 1 or v55;
                            local Id = u47[v52].Id;
                            v54 = Cache.GetOrFetch("EmoteData", Id, nil, function() -- Line: 503
                                -- upvalues: GetEmote (ref), Id (copy)
                                local v56, v57 = GetEmote:InvokeServer(Id);

                                return v56 and v57 and v57 or nil;
                            end);

                            if v54 then
                                break;
                            end;

                            task.wait(1);
                        end;

                        local Animation = Instance.new("Animation");
                        Animation.Name = v54.EmoteName;
                        Animation.AnimationId = v54.EmoteId;
                        local v58 = v51:LoadAnimation(Animation);
                        v58.Priority = Enum.AnimationPriority.Action;
                        v58.Looped = true;
                        v58:Play(0.3);
                        Animation:Destroy();

                        if u53 then
                            u53:Stop(0.3);
                            task.delay(0.3, function() -- Line: 524
                                -- upvalues: u53 (copy)
                                u53:Destroy();
                            end);
                        end;

                        task.wait(4);
                        u53 = v58;
                    end;
                end);
                table.insert(u22.Objects, u49);
                table.insert(u22.Connections, {
                    Disconnect = function() -- Line: 538, Name: Disconnect
                        -- upvalues: u59 (copy)
                        task.cancel(u59);
                    end
                });

                return;
            end;

            if not v48.itemsWrapper.items:FindFirstChildOfClass("ImageLabel") then
                for i, v in u47 do
                    local v60 = script.showcaseItem:Clone();

                    if v.ItemType == "Asset" then
                        v60.Image = `rbxthumb://type=Asset&id={v.Id}&w=420&h=420`;
                    elseif v.ItemType == "Bundle" then
                        v60.Image = `rbxthumb://type=BundleThumbnail&id={v.Id}&w=420&h=420`;
                    end;

                    v60.LayoutOrder = i;
                    v60.Parent = v48.itemsWrapper.items;
                    local v61 = v60:Clone();
                    v61.LayoutOrder = #u47 + i;
                    v61.Parent = v48.itemsWrapper.items;
                end;
            end;

            local items = v48.itemsWrapper.items;
            local v62 = { "Interface", "FrontPageScrollStyle" };

            if not Events.GetSetting:GetAttribute("bound") then
                Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
            end;

            if (Events.GetSetting:Invoke(v62) or "Continuous") ~= "Step" then
                local u63 = 0;
                table.insert(u22.Connections, RunService.Heartbeat:Connect(function(p64) -- Line: 466
                    -- upvalues: items (copy), u63 (ref)
                    local X = items.AbsoluteSize.X;

                    if X <= 0 then
                        return;
                    end;

                    local v65 = X / 2;
                    u63 = u63 + 0.015 * workspace.CurrentCamera.ViewportSize.X * p64;

                    if v65 <= u63 then
                        u63 = u63 - v65;
                    end;

                    items.Position = UDim2.new(0, -u63, items.Position.Y.Scale, items.Position.Y.Offset);
                end));

                return;
            end;

            local X = v48.itemsWrapper.AbsoluteSize.X;
            local Y = v48.itemsWrapper.AbsoluteSize.Y;

            if X > 0 and Y > 0 then
                local v66 = math.floor(X / Y);

                if v66 > 0 then
                    local _ = 1 / v66;

                    for _, child in items:GetChildren() do
                        if child:IsA("ImageLabel") then
                            local v67 = child:FindFirstChildOfClass("UIAspectRatioConstraint");

                            if v67 then
                                v67:Destroy();
                            end;

                            child.Size = UDim2.new(0, X / v66, 1, 0);
                            child.ScaleType = Enum.ScaleType.Fit;
                        end;
                    end;
                end;
            end;

            local u73 = task.spawn(function() -- Line: 438
                -- upvalues: items (copy), TweenService (ref)
                local v68 = 0;

                while true do
                    local v69;

                    repeat
                        task.wait(4);
                        v69 = items.AbsoluteSize.X;
                    until v69 > 0;

                    local v70 = v69 / 2;
                    local v71 = items:FindFirstChildOfClass("ImageLabel");

                    if v71 then
                        v68 = v68 + v71.AbsoluteSize.X;
                        local v72 = TweenService:Create(items, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                            Position = UDim2.new(0, -v68, items.Position.Y.Scale, items.Position.Y.Offset)
                        });
                        v72:Play();
                        v72.Completed:Wait();

                        if v70 <= v68 then
                            v68 = v68 - v70;
                            items.Position = UDim2.new(0, -v68, items.Position.Y.Scale, items.Position.Y.Offset);
                        end;
                    end;
                end;
            end);
            table.insert(u22.Connections, {
                Disconnect = function() -- Line: 462, Name: Disconnect
                    -- upvalues: u73 (copy)
                    task.cancel(u73);
                end
            });
        end);
    end;

    animateReturnButton(not p38);

    if activeFilters then
        local v74 = not p38;

        if v74 then
            if next(Options.ActiveFilters or {}) == nil then
                v74 = false;
            else
                v74 = u18.CanSetActiveFiltersToVisible ~= false;
            end;
        end;

        activeFilters.Visible = v74;
    end;
end;

u18.SetFrontPageVisible = setFrontPageVisible;

local function tryOpenRobloxLink(p75) -- Line: 555
    -- upvalues: dprint (copy), AvatarEditorService (copy), Cache (copy), CatalogUtilities (copy), Events (copy)
    if not p75 then
        return false;
    end;

    local v76 = p75:match("^%s*(.-)%s*$");
    local v77 = v76:match("roblox%.com/catalog/(%d+)");
    local u78, u79;

    if v77 then
        u78 = tonumber(v77);
        u79 = "Asset";
    else
        u78 = nil;
        u79 = nil;
    end;

    if not u78 then
        local v80 = v76:match("roblox%.com/bundles/(%d+)");

        if v80 then
            u78 = tonumber(v80);
            u79 = "Bundle";
        end;
    end;

    if not u78 then
        local v81 = v76:match("^(%d+)$");

        if v81 and #v81 >= 4 then
            u78 = tonumber(v81);
            u79 = "Asset";
        end;
    end;

    if not u78 then
        return false;
    end;

    dprint("Detected Roblox link/ID:", u78, u79);
    local success, result = pcall(function() -- Line: 591
        -- upvalues: AvatarEditorService (ref), u78 (ref), u79 (ref)
        return AvatarEditorService:GetItemDetailsAsync(u78, Enum.AvatarItemType:FromName(u79));
    end);

    if not success or (typeof(result) ~= "table" or result.Id == nil) then
        return false;
    end;

    Cache.Set("ItemDetails", tostring(result.Id), result, 3600);
    local v82 = CatalogUtilities.GetItemData(result);
    Events.DisplayContentPage:Fire({
        Type = "ItemDetails",
        Item = v82
    });

    return true;
end;

function u18.TriggerSearch() -- Line: 610
    -- upvalues: tryOpenRobloxLink (copy), searchInput (copy), setFrontPageVisible (copy), SearchController (copy)
    task.spawn(function() -- Line: 611
        -- upvalues: tryOpenRobloxLink (ref), searchInput (ref), setFrontPageVisible (ref), SearchController (ref)
        if tryOpenRobloxLink(searchInput.Text) then
            return;
        end;

        setFrontPageVisible(false);
        SearchController.StartNewSearch(searchInput.Text or "");
    end);
end;

function u18.SearchFor(p83) -- Line: 618
    -- upvalues: tryOpenRobloxLink (copy), u18 (copy), searchInput (copy), setFrontPageVisible (copy), SearchController (copy)
    local u84 = p83 or "";
    task.spawn(function() -- Line: 620
        -- upvalues: tryOpenRobloxLink (ref), u84 (ref), u18 (ref), searchInput (ref), setFrontPageVisible (ref), SearchController (ref)
        if tryOpenRobloxLink(u84) then
            return;
        end;

        if not u18.IsOpen then
            u18.Open();
        end;

        searchInput.Text = u84;
        setFrontPageVisible(false);
        SearchController.StartNewSearch(u84);
    end);
end;

local u85 = TweenService:Create(container, u14, {
    GroupTransparency = 0
});
local u86 = TweenService:Create(container, u14, {
    GroupTransparency = 1
});

local function setupConnections() -- Line: 635
    -- upvalues: u18 (copy)
    u18.SetupQuickActions();
end;

function u18.Open(p87) -- Line: 639
    -- upvalues: u2 (ref), u18 (copy), Events (copy), container (copy), catalogSection (copy), Catalog (copy), u85 (copy), Remotes (copy), setFrontPageVisible (copy), animateReturnButton (copy), avatarSection (copy), container2 (copy), HumanoidDescriptionController (copy), AvatarPreviewController (copy)
    local v88 = 0;

    while not u2 do
        task.wait(0.1);
        v88 = v88 + 1;
        print("not ready yet");

        if v88 > 50 then
            warn("CategoryController:Open() yielding too long");
            break;
        end;

        if u2 == true then
            break;
        end;
    end;

    for _, v in u18.OnOpenListeners do
        task.spawn(v);
    end;

    Events.InterfaceAction:Fire("Add", script.Name, u18.Close);
    Events.SetButtonsVisible:Fire({ "Undo", "Redo" });
    u18.IsOpen = true;
    container.GroupTransparency = 1;
    catalogSection.Visible = true;
    Catalog.Enabled = true;
    u85:Play();
    pcall(Remotes.AnalyticsEvent.FireServer, Remotes.AnalyticsEvent, "CatalogOpened");
    local v89;

    if type(p87) == "table" then
        v89 = p87.SkipFrontPage;
    else
        v89 = false;
    end;

    if not u18._hasOpenedBefore then
        u18._hasOpenedBefore = true;

        if not v89 then
            local v90 = { "Interface", "ShowCatalogFrontPage" };

            if not Events.GetSetting:GetAttribute("bound") then
                Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
            end;

            v89 = Events.GetSetting:Invoke(v90) == false;
        end;
    end;

    if v89 then
        setFrontPageVisible(false);
        u18.UpdateSelectionState("Category", u18.Category or "Featured", nil);
    elseif u18.FrontPageVisible then
        setFrontPageVisible(true);

        if not u18.FrontPageVisible then
            u18.UpdateSelectionState("Category", u18.Category or "Featured", nil);
        end;
    else
        local v91 = { "Interface", "ShowCatalogFrontPage" };

        if not Events.GetSetting:GetAttribute("bound") then
            Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
        end;

        animateReturnButton(Events.GetSetting:Invoke(v91) ~= false);
    end;

    local v92 = { "Interface", "AvatarPreviewOnRight" };

    if not Events.GetSetting:GetAttribute("bound") then
        Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
    end;

    local v93 = Events.GetSetting:Invoke(v92) == true;
    local v94;

    if v93 then
        v94 = Vector2.new(1, 0);
    else
        v94 = Vector2.new(0, 0);
    end;

    avatarSection.AnchorPoint = v94;
    local v95;

    if v93 then
        v95 = UDim2.new(1, 0, 0, 0);
    else
        v95 = UDim2.new(0, 0, 0, 0);
    end;

    avatarSection.Position = v95;
    local v96;

    if v93 then
        v96 = Vector2.new(0, 0);
    else
        v96 = Vector2.new(1, 0);
    end;

    catalogSection.AnchorPoint = v96;
    local v97;

    if v93 then
        v97 = UDim2.new(0, 0, 0, 0);
    else
        v97 = UDim2.new(1, 0, 0, 0);
    end;

    catalogSection.Position = v97;
    local v98 = container2:FindFirstChildOfClass("UIGridLayout");

    if v98 then
        local v99 = { "Interface", "LargerCatalogItems" };

        if not Events.GetSetting:GetAttribute("bound") then
            Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
        end;

        if Events.GetSetting:Invoke(v99) == true then
            v98.CellSize = UDim2.new(0.25, -2, 0.6, 0);
            v98.FillDirectionMaxCells = 4;
        else
            v98.CellSize = UDim2.new(0.1665, -2, 0.6, 0);
            v98.FillDirectionMaxCells = 6;
        end;
    end;

    local bodyAdjustContainer2 = catalogSection.bottomBar.left:FindFirstChild("bodyAdjustContainer");

    if bodyAdjustContainer2 then
        local v100 = { "Interface", "ShowAdjustBodyButton" };

        if not Events.GetSetting:GetAttribute("bound") then
            Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
        end;

        bodyAdjustContainer2.Visible = Events.GetSetting:Invoke(v100) ~= false;
    end;

    u18.SetupQuickActions();
    u18.UpdateCategories();

    if HumanoidDescriptionController.HumanoidDescription then
        AvatarPreviewController.CurrentCatalogPreviewObject:Update(HumanoidDescriptionController.HumanoidDescription, {
            BypassIsApplied = true
        });
    end;

    AvatarPreviewController.CurrentCatalogPreviewObject:Redraw();
end;

function u18.Close(p101) -- Line: 727
    -- upvalues: u18 (copy), Events (copy), ItemButton (copy), u86 (copy), Remotes (copy), Catalog (copy)
    for _, v in u18.OnCloseListeners do
        task.spawn(v);
    end;

    Events.InterfaceAction:Fire("Remove", script.Name);
    ItemButton.CartPosition = nil;
    u18.IsOpen = false;
    u86:Play();
    pcall(Remotes.AnalyticsEvent.FireServer, Remotes.AnalyticsEvent, "CatalogClosed");
    u86.Completed:Once(function() -- Line: 740
        -- upvalues: Catalog (ref)
        Catalog.Enabled = false;
    end);
    u18.ClearConnections();

    if p101 ~= true then
        Events.SetButtonsVisible:Fire("All");
    end;
end;

function u18.ClearConnections() -- Line: 749
    -- upvalues: u18 (copy)
    for _, v in u18.Connections do
        v:Disconnect();
    end;

    table.clear(u18.Connections);
end;

function u18.SetupQuickActions(p102) -- Line: 756
    -- upvalues: preview (copy), u18 (copy), TweenService (copy), u14 (copy), Events (copy), Remotes (copy)
    local quickActions = preview.quickActions;
    local u103 = {};
    local u104 = {
        IsCatalogQuickAction = true,
        CustomCallback = p102 or u18.Open
    };

    local function enableQuickActions() -- Line: 762
        -- upvalues: quickActions (copy), TweenService (ref), u14 (ref), u18 (ref), u103 (copy), Events (ref), u104 (copy), Remotes (ref)
        for _, child in quickActions:GetChildren() do
            TweenService:Create(child, u14, {
                BackgroundTransparency = 0.8
            }):Play();

            for _, descendant in child:GetDescendants() do
                if descendant:IsA("ImageLabel") then
                    TweenService:Create(descendant, u14, {
                        ImageTransparency = 0.1
                    }):Play();
                elseif descendant:IsA("Frame") then
                    descendant.BackgroundTransparency = 1;
                elseif descendant:IsA("TextButton") then
                    local v105 = descendant.MouseEnter:Connect(function() -- Line: 771
                        -- upvalues: TweenService (ref), descendant (copy), u14 (ref)
                        TweenService:Create(descendant.back, u14, {
                            BackgroundTransparency = 0.85
                        }):Play();
                    end);
                    table.insert(u18.Connections, v105);
                    table.insert(u103, v105);
                    local v106 = descendant.MouseLeave:Connect(function() -- Line: 778
                        -- upvalues: TweenService (ref), descendant (copy), u14 (ref)
                        TweenService:Create(descendant.back, u14, {
                            BackgroundTransparency = 1
                        }):Play();
                    end);
                    table.insert(u18.Connections, v106);
                    table.insert(u103, v106);
                    local v109 = descendant.Activated:Connect(function() -- Line: 784
                        -- upvalues: descendant (copy), Events (ref), u104 (ref), Remotes (ref)
                        if descendant.Name == "reset" then
                            if Events.PromptResetAvatar:Invoke(u104) == true then
                                local v107, v108 = Remotes.ResetAvatar:InvokeServer();

                                if v107 == false then
                                    warn("error resetting avatar:", v108);
                                end;
                            end;
                        elseif descendant.Name == "save" then
                            Events.DisplaySaveOutfit:Fire(nil, nil, nil, u104);
                        end;
                    end);
                    table.insert(u18.Connections, v109);
                    table.insert(u103, v109);

                    if descendant.Name == "reset" then
                        Events.AddTooltipToObject:Fire(descendant, "Reset to your Roblox avatar");
                    elseif descendant.Name == "save" then
                        Events.AddTooltipToObject:Fire(descendant, "Save your outfit");
                    end;
                end;
            end;
        end;
    end;

    local function disableQuickActions() -- Line: 811
        -- upvalues: u103 (copy), quickActions (copy), TweenService (ref), u14 (ref)
        for _, v in u103 do
            v:Disconnect();
        end;

        table.clear(u103);

        for _, child in quickActions:GetChildren() do
            TweenService:Create(child, u14, {
                BackgroundTransparency = 1
            }):Play();

            for _, descendant in child:GetDescendants() do
                if descendant:IsA("ImageLabel") then
                    TweenService:Create(descendant, u14, {
                        ImageTransparency = 1
                    }):Play();
                elseif descendant:IsA("Frame") then
                    TweenService:Create(descendant, u14, {
                        BackgroundTransparency = 1
                    }):Play();
                end;
            end;
        end;
    end;

    quickActions.Visible = true;
    enableQuickActions();
end;

local function addSpaceBeforeCaps(p110) -- Line: 835
    local v111, _ = string.gsub(p110, "(%l)(%u)", "%1 %2");

    return v111;
end;

local function sortChoices(p112) -- Line: 841
    table.sort(p112, function(p113, p114) -- Line: 842
        if p113.key == "All" then
            return true;
        end;

        if p114.key == "All" then
            return false;
        end;

        if p113.layoutOrder == p114.layoutOrder then
            return p113.text < p114.text;
        end;

        return p113.layoutOrder < p114.layoutOrder;
    end);
end;

local function pickDefaultSubcategory(p115, p116) -- Line: 852
    if p115.DefaultSubcategory then
        return p115.DefaultSubcategory, p115.DefaultSubcategory;
    end;

    if not p116 then
        return nil, nil;
    end;

    if p116.All then
        return "All", p116.All.Readable or "All";
    end;

    for i, v in p116 do
        if type(v) == "table" then
            return i, v.Readable or i;
        end;
    end;

    return nil, nil;
end;

local function getCategoryByKey(p117) -- Line: 870
    -- upvalues: SortingSchema (copy)
    if p117 then
        return SortingSchema[p117];
    end;

    return nil;
end;

local function orderedCategories() -- Line: 875
    -- upvalues: SortingSchema (copy)
    local v118 = {};

    for i, v in SortingSchema do
        v118[#v118 + 1] = {
            key = i,
            data = v
        };
    end;

    table.sort(v118, function(p119, p120) -- Line: 880
        local v121 = tonumber(p119.data.LayoutOrder) or (1 / 0);
        local v122 = tonumber(p120.data.LayoutOrder) or (1 / 0);

        if v121 == v122 then
            return p119.key < p120.key;
        end;

        return v121 < v122;
    end);

    return v118;
end;

local function hasSubTypes(p123, p124) -- Line: 889
    if p124 then
        if p124.NoSubcategories == true or type(p124.Subcategories) ~= "table" then
            p124 = false;
        else
            p124 = next(p124.Subcategories) ~= nil;
        end;
    end;

    return p124;
end;

local function getSelectionData(p125) -- Line: 895
    -- upvalues: u18 (copy), SortingSchema (copy)
    if not p125 then
        return u18.Category, u18.CategoryData or SortingSchema[u18.Category], u18.Subcategory, u18.SubcategoryData or SortingSchema[u18.Subcategory], u18.Type, u18.TypeData or SortingSchema[u18.Type];
    end;

    local v126 = nil;
    local v127 = nil;

    if p125 == "Category" then
        local Category = u18.Category;

        return Category, u18.CategoryData or SortingSchema[Category];
    end;

    if p125 == "Subcategory" then
        local Subcategory = u18.Subcategory;

        return Subcategory, u18.SubcategoryData or SortingSchema[Subcategory];
    end;

    if p125 == "Type" then
        v126 = u18.Type;
        v127 = u18.TypeData or SortingSchema[v126];
    end;

    return v126, v127;
end;

local function setDropdownVisualAlpha(p128, p129) -- Line: 915
    if not p128 then
        return;
    end;

    for _, descendant in p128:GetDescendants() do
        if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
            descendant.TextTransparency = p129;
        elseif descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") then
            descendant.ImageTransparency = p129;
        elseif descendant:IsA("UIStroke") then
            descendant.Transparency = p129;
        elseif descendant.Name == "back" then
            descendant.BackgroundTransparency = p129;
        end;
    end;
end;

local function setDropdownVisible(p130, p131, p132, p133, p134, p135, p136) -- Line: 930
    -- upvalues: setDropdownVisualAlpha (copy), u18 (copy)
    if not p130 then
        return;
    end;

    p130:SetAttribute("Visible", p133);

    if p133 then
        if p136 == "type" then
            p130.Visible = true;
        end;

        setDropdownVisualAlpha(p130, 0);
    else
        setDropdownVisualAlpha(p130, 1);

        if p136 == "type" then
            p130.Visible = false;
        end;
    end;

    if not p131 then
        return;
    end;

    if p133 then
        p131:RebuildChoices();
        p131.currentChoice = p134;

        if p136 == "sub" then
            u18.UpdateSelectionState("Subcategory", p134, nil, true);
        elseif p136 == "type" then
            u18.UpdateSelectionState("Type", p134, nil, true);
        end;

        if p132 then
            p132.Text = p135 or (p134 or "");
        end;
    else
        p131.currentChoice = nil;

        if p136 == "sub" then
            u18.UpdateSelectionState("Subcategory", nil, nil, true);
        elseif p136 == "type" then
            u18.UpdateSelectionState("Type", nil, nil, true);
        end;

        if p132 then
            p132.Text = "";
        end;
    end;
end;

local u137 = ScrollFade.new(itemsWrapper, topFade, bottomBuffer);

local function fadeSubcat(p138) -- Line: 982
    -- upvalues: subcategoryDropdown (copy), Quad (copy), Out (copy), setDropdownVisualAlpha (copy), TweenService (copy)
    if not subcategoryDropdown then
        return;
    end;

    local v139 = TweenInfo.new(0.18, Quad, Out);
    subcategoryDropdown:SetAttribute("Visible", p138);

    if p138 then
        setDropdownVisualAlpha(subcategoryDropdown, 0);

        return;
    end;

    for _, descendant in subcategoryDropdown:GetDescendants() do
        if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
            TweenService:Create(descendant, v139, {
                TextTransparency = 1
            }):Play();
        elseif descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") then
            TweenService:Create(descendant, v139, {
                ImageTransparency = 1
            }):Play();
        elseif descendant:IsA("UIStroke") then
            TweenService:Create(descendant, v139, {
                Transparency = 1
            }):Play();
        elseif descendant.Name == "back" then
            TweenService:Create(descendant, v139, {
                BackgroundTransparency = 1
            }):Play();
        end;
    end;
end;

function refreshDropdowns(p140, p141)
    -- upvalues: getSelectionData (copy), subcategoryDropdown (copy), u15 (ref), Quad (copy), Out (copy), setDropdownVisualAlpha (copy), fadeSubcat (copy), u16 (ref), u18 (copy), u7 (copy), typeDropdown (copy), pickDefaultSubcategory (copy), setDropdownVisible (copy), u17 (ref), u11 (copy), DropdownController (copy)
    local _, v142, _, v143 = getSelectionData();

    for _, v in p140 do
        if v == "sub" and subcategoryDropdown then
            local v144 = v142 and not v142.NoSubcategories;

            if v144 then
                if type(v142.Subcategories) == "table" then
                    v144 = next(v142.Subcategories) ~= nil;
                else
                    v144 = false;
                end;
            end;

            if v144 and not u15 then
                subcategoryDropdown:SetAttribute("Visible", true);

                if subcategoryDropdown then
                    TweenInfo.new(0.18, Quad, Out);
                    subcategoryDropdown:SetAttribute("Visible", true);
                    setDropdownVisualAlpha(subcategoryDropdown, 0);
                end;
            elseif v144 or not u15 then
                subcategoryDropdown:SetAttribute("Visible", v144);

                if not v144 then
                    fadeSubcat(false);
                end;
            else
                subcategoryDropdown:SetAttribute("Visible", false);
                fadeSubcat(false);
            end;

            u15 = v144;

            if not v144 and u16 then
                u16.currentChoice = nil;
                u18.UpdateSelectionState("Subcategory", nil, nil, true);

                if u7 then
                    u7.Text = "";
                end;
            end;
        elseif v == "type" and typeDropdown then
            local v145;

            if v143 then
                if v143.NoSubcategories == true or type(v143.Subcategories) ~= "table" then
                    v145 = false;
                else
                    v145 = next(v143.Subcategories) ~= nil;
                end;
            else
                v145 = v143;
            end;

            local v146, v147;

            if v145 then
                v146, v147 = pickDefaultSubcategory(v143, v143.Subcategories);
            else
                v146 = nil;
                v147 = nil;
            end;

            setDropdownVisible(typeDropdown, u17, u11, v145, v146, v147, v);
        end;
    end;

    DropdownController.UpdateDropdowns();
end;

searchInput.FocusLost:Connect(function(p148) -- Line: 1054
    -- upvalues: dprint (copy), searchInput (copy), tryOpenRobloxLink (copy), setFrontPageVisible (copy), SearchController (copy)
    if p148 then
        dprint("Search submit (FocusLost w/ Enter):", searchInput.Text);

        if tryOpenRobloxLink(searchInput.Text) then
            return;
        end;

        setFrontPageVisible(false);
        SearchController.StartNewSearch(searchInput.Text);
    end;
end);
UserInputService.InputBegan:Connect(function(p149, p150) -- Line: 1062
    -- upvalues: searchInput (copy), dprint (copy), tryOpenRobloxLink (copy), setFrontPageVisible (copy), SearchController (copy)
    if p150 then
        return;
    end;

    if (p149.KeyCode == Enum.KeyCode.Return or p149.KeyCode == Enum.KeyCode.KeypadEnter) and (searchInput and searchInput:IsFocused()) then
        dprint("Search submit (KeyDown Return):", searchInput.Text);

        if tryOpenRobloxLink(searchInput.Text) then
            return;
        end;

        setFrontPageVisible(false);
        SearchController.StartNewSearch(searchInput.Text);
    end;
end);
searchInput.ClearTextOnFocus = false;
clear.Visible = false;
searchInput:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 1078
    -- upvalues: clear (copy), searchInput (copy)
    clear.Visible = searchInput.Text ~= "";
end);
clear.Activated:Connect(function() -- Line: 1082
    -- upvalues: searchInput (copy)
    searchInput.Text = "";
    searchInput:CaptureFocus();
end);

function u18.UpdateSelectionState(p151, p152, p153, p154) -- Line: 1088
    -- upvalues: u18 (copy), setFrontPageVisible (copy), Remotes (copy), SortingSchema (copy), pickDefaultSubcategory (copy), u7 (copy), u16 (ref), HumanoidDescriptionController (copy), SearchController (copy), searchInput (copy)
    if u18.FrontPageVisible and not (u18._skipFrontPageDismiss or p154) then
        setFrontPageVisible(false);
    end;

    if p151 == "Category" and u18.IsOpen then
        pcall(Remotes.AnalyticsEvent.FireServer, Remotes.AnalyticsEvent, "CatalogBrowsedCategory");
    end;

    local v155 = {};

    if p151 == "Category" then
        u18.Category = p152;

        if not p153 then
            if p152 then
                p153 = SortingSchema[p152];
            else
                p153 = nil;
            end;
        end;

        u18.CategoryData = p153;
        u18.Subcategory = nil;
        u18.SubcategoryData = nil;
        u18.Type = nil;
        u18.TypeData = nil;

        if u18.CategoryData and not u18.CategoryData.NoSubcategories then
            local v156, v157 = pickDefaultSubcategory(u18.CategoryData, u18.CategoryData.Subcategories);
            u18.Subcategory = v156;
            local v158;

            if v156 and u18.CategoryData.Subcategories then
                v158 = u18.CategoryData.Subcategories[v156];
            else
                v158 = nil;
            end;

            u18.SubcategoryData = v158;
            local v159;

            if v156 then
                v159 = u18.CategoryData.Subcategories[v156].AlignLeft;
            else
                v159 = nil;
            end;

            if v159 then
                v155.AlignSubcategoryLeft = v159;
            end;

            if u7 then
                u7.Text = v157 or "";
            end;

            if u18.CurrentCategorySelectionMode == "HorizontalScroll" then
                local _ = u18.CategoryData;
                local SubcategoryData = u18.SubcategoryData;

                if SubcategoryData then
                    if SubcategoryData.NoSubcategories == true or type(SubcategoryData.Subcategories) ~= "table" then
                        SubcategoryData = false;
                    else
                        SubcategoryData = next(SubcategoryData.Subcategories) ~= nil;
                    end;
                end;

                if SubcategoryData then
                    local v160, _ = pickDefaultSubcategory(u18.SubcategoryData, u18.SubcategoryData.Subcategories);

                    if v160 then
                        u18.Type = v160;
                        u18.TypeData = u18.SubcategoryData.Subcategories[v160];
                    end;
                end;
            end;
        end;

        if u16 then
            u16:RebuildChoices();
        end;

        if u18._refreshAdjustmentList and HumanoidDescriptionController.HumanoidDescription then
            u18._refreshAdjustmentList(HumanoidDescriptionController.HumanoidDescription);
        end;

        if p154 ~= true then
            refreshDropdowns({ "sub", "type" }, true);
        end;
    elseif p151 == "Subcategory" then
        u18.Subcategory = p152;

        if not p153 then
            if u18.CategoryData and u18.CategoryData.Subcategories then
                p153 = u18.CategoryData.Subcategories[p152];
            else
                p153 = nil;
            end;
        end;

        u18.SubcategoryData = p153;
        u18.Type = nil;
        u18.TypeData = nil;

        if u18.CurrentCategorySelectionMode == "HorizontalScroll" then
            local _ = u18.CategoryData;
            local SubcategoryData = u18.SubcategoryData;

            if SubcategoryData then
                if SubcategoryData.NoSubcategories == true or type(SubcategoryData.Subcategories) ~= "table" then
                    SubcategoryData = false;
                else
                    SubcategoryData = next(SubcategoryData.Subcategories) ~= nil;
                end;
            end;

            if SubcategoryData then
                local v161, _ = pickDefaultSubcategory(u18.SubcategoryData, u18.SubcategoryData.Subcategories);

                if v161 then
                    u18.Type = v161;
                    u18.TypeData = u18.SubcategoryData.Subcategories[v161];
                end;
            end;
        end;

        if p154 ~= true then
            refreshDropdowns({ "type" });
        end;

        if u18.Category == "Makeup" and (u18._refreshAdjustmentList and HumanoidDescriptionController.HumanoidDescription) then
            u18._refreshAdjustmentList(HumanoidDescriptionController.HumanoidDescription);
        end;
    elseif p151 == "Type" then
        u18.Type = p152;

        if not p153 then
            if u18.SubcategoryData and u18.SubcategoryData.Subcategories then
                p153 = u18.SubcategoryData.Subcategories[p152];
            else
                p153 = nil;
            end;
        end;

        u18.TypeData = p153;
    end;

    if p154 ~= true then
        u18.UpdateCategories(v155);

        if not u18.FrontPageVisible then
            task.spawn(function() -- Line: 1176
                -- upvalues: SearchController (ref), searchInput (ref)
                SearchController.StartNewSearch(searchInput.Text or "");
            end);
        end;
    end;
end;

local u168 = DropdownController.new({
    reflectSelectionOnLabel = true,
    toggleButton = v3,
    label = u4,
    dropFrame = categoryDropdown,
    choiceTemplate = v5,
    dividerTemplate = divider,

    getChoices = function() -- Line: 1192, Name: getChoices
        -- upvalues: orderedCategories (copy)
        local v162 = {};

        for _, v in orderedCategories() do
            local v163 = {
                key = v.key
            };
            local v164;

            if v.data and v.data.Readable ~= nil then
                v164 = v.data.Readable;
            else
                v164 = v.key;
            end;

            v163.text = v164;
            v163.layoutOrder = tonumber(v.data.LayoutOrder) or 9999;
            v163.addDividerAfter = v.data.AddDividerAfter == true;
            v162[#v162 + 1] = v163;
        end;

        return v162;
    end,

    onSelect = function(p165, p166) -- Line: 1204, Name: onSelect
        -- upvalues: SortingSchema (copy), InventoryService (copy), u18 (copy), setFrontPageVisible (copy)
        local v167;

        if p165 then
            v167 = SortingSchema[p165];
        else
            v167 = nil;
        end;

        if v167 and v167.SpecialCase == "Inventory" then
            if InventoryService.HasAccess == false then
                InventoryService.RequestAccess();

                return false;
            end;

            if InventoryService.ItemsLoaded ~= true then
                print("Busy loading inventory!");

                return false;
            end;
        end;

        if u18.FrontPageVisible then
            setFrontPageVisible(false);
        end;

        u18.UpdateSelectionState("Category", p165, v167);
    end
});
u168:SetVisibleCallback(function(p169, p170) -- Line: 1223
end);
u16 = DropdownController.new({
    reflectSelectionOnLabel = true,
    toggleButton = v6,
    label = u7,
    dropFrame = v8,
    choiceTemplate = v9,
    dividerTemplate = divider,

    getChoices = function() -- Line: 1232, Name: getChoices
        -- upvalues: u168 (ref), SortingSchema (copy)
        local currentChoice = u168.currentChoice;
        local v171;

        if currentChoice then
            v171 = SortingSchema[currentChoice];
        else
            v171 = nil;
        end;

        if not v171 or (v171.NoSubcategories or type(v171.Subcategories) ~= "table") then
            return {};
        end;

        local v172 = {};

        for i, v in v171.Subcategories do
            local v173 = {
                key = i
            };

            if v.Readable then
                local i = v.Readable;
            end;

            v173.text = i;
            v173.layoutOrder = tonumber(v.LayoutOrder) or 9999;
            v173.addDividerAfter = v.AddDividerAfter == true;
            v172[#v172 + 1] = v173;
        end;

        table.sort(v172, function(p174, p175) -- Line: 842
            if p174.key == "All" then
                return true;
            end;

            if p175.key == "All" then
                return false;
            end;

            if p174.layoutOrder == p175.layoutOrder then
                return p174.text < p175.text;
            end;

            return p174.layoutOrder < p175.layoutOrder;
        end);

        return v172;
    end,

    onSelect = function(p176, p177) -- Line: 1250, Name: onSelect
        -- upvalues: u18 (copy)
        u18.UpdateSelectionState("Subcategory", p176);
    end
});
u16:SetVisibleCallback(function(p178, p179) -- Line: 1254
end);
u17 = DropdownController.new({
    reflectSelectionOnLabel = true,
    toggleButton = v10,
    label = u11,
    dropFrame = v12,
    choiceTemplate = v13,
    dividerTemplate = divider,

    getChoices = function() -- Line: 1263, Name: getChoices
        -- upvalues: getSelectionData (copy)
        local _, _, _, v180 = getSelectionData();
        local v181;

        if v180 then
            if v180.NoSubcategories == true or type(v180.Subcategories) ~= "table" then
                v181 = false;
            else
                v181 = next(v180.Subcategories) ~= nil;
            end;
        else
            v181 = v180;
        end;

        if not v181 then
            return {};
        end;

        local v182 = {};

        for i, v in v180.Subcategories do
            local v183 = {
                key = i
            };

            if v.Readable then
                local i = v.Readable;
            end;

            v183.text = i;
            v183.layoutOrder = tonumber(v.LayoutOrder) or 9999;
            v183.addDividerAfter = v.AddDividerAfter == true;
            v182[#v182 + 1] = v183;
        end;

        table.sort(v182, function(p184, p185) -- Line: 842
            if p184.key == "All" then
                return true;
            end;

            if p185.key == "All" then
                return false;
            end;

            if p184.layoutOrder == p185.layoutOrder then
                return p184.text < p185.text;
            end;

            return p184.layoutOrder < p185.layoutOrder;
        end);

        return v182;
    end,

    onSelect = function(p186, p187) -- Line: 1280, Name: onSelect
        -- upvalues: u18 (copy)
        u18.UpdateSelectionState("Type", p186);
    end
});
u17:SetVisibleCallback(function(p188, p189) -- Line: 1284
end);

function u18.GetSnapshots() -- Line: 1286
    -- upvalues: SearchController (copy)
    return SearchController.GetSnapshots();
end;

function u18.RestoreSnapshot(p190) -- Line: 1290
    -- upvalues: SearchController (copy), searchInput (copy), u168 (ref), u16 (ref), u17 (ref), u18 (copy)
    local v191 = SearchController.GetSnapshots();
    local v192 = v191[p190 or #v191];

    if not v192 then
        return;
    end;

    SearchController.SetActiveState(false);

    if searchInput then
        searchInput.Text = v192.keyword or "";
    end;

    if u168 then
        u168:SetCurrentChoice(v192.category.Key, v192.category.Readable, true);
    end;

    if u16 then
        u16:SetCurrentChoice(v192.subcategory.Key, v192.subcategory.Readable, true);
    end;

    if u17 then
        u17:SetCurrentChoice(v192.type.Key, v192.type.Readable, true);
    end;

    local v193;

    if v192.category then
        v193 = v192.category.Key;
    else
        v193 = nil;
    end;

    u18.UpdateSelectionState("Category", v193, nil, true);
    local v194;

    if v192.subcategory then
        v194 = v192.subcategory.Key;
    else
        v194 = nil;
    end;

    u18.UpdateSelectionState("Subcategory", v194, nil, true);
    local v195;

    if v192.type then
        v195 = v192.type.Key;
    else
        v195 = nil;
    end;

    u18.UpdateSelectionState("Type", v195, nil, false);
    refreshDropdowns({ "sub", "type" });
end;

local function updateUIObjectToAspectRatio(p196, p197) -- Line: 1319
    p196.Size = UDim2.new(0, p196.AbsoluteSize.Y * p197, p196.Size.Y.Scale, 0);
end;

local function updateTopBarSize() -- Line: 1324
    -- upvalues: topBar (copy), activeFilters (copy), u18 (copy), itemsSection (copy), frontPage (copy)
    local Parent = topBar.Parent;
    local Scale = topBar.Size.Y.Scale;
    local v198 = not activeFilters.Visible and 0 or activeFilters.AbsoluteSize.Y;
    local v199 = Parent.AbsoluteSize.Y * Scale;
    local v200 = (u18.CurrentCategorySelectionMode == "Dropdowns" or topBar:FindFirstChild("bottomHalf") and not topBar.bottomHalf.Visible) and 31 or 50;
    local v201 = math.max(v200, v199) - v199;
    topBar.Size = UDim2.new(1, 0, Scale, v201);
    itemsSection.Size = UDim2.new(0.975, 0, 0.981 - Scale, -v201 - v198);
    local v202 = 0.904 - Scale;
    frontPage.Size = UDim2.new(frontPage.Size.X.Scale, 0, v202, -v201);
    frontPage.Position = UDim2.new(0.5, 0, Scale + v202 / 2, v201 / 2);
    activeFilters.Position = UDim2.new(0.5, 0, 0, (topBar.AbsolutePosition.Y + topBar.AbsoluteSize.Y + itemsSection.AbsolutePosition.Y) / 2 - Parent.AbsolutePosition.Y);
end;

local function updateShoppingCartCounter() -- Line: 1355
    -- upvalues: ShoppingCartController (copy), cartContainer (copy)
    if ShoppingCartController.TotalCount ~= nil then
        cartContainer.itemCount.Text = tostring(ShoppingCartController.TotalCount);
        cartContainer.itemCount.Visible = ShoppingCartController.TotalCount > 0;
    end;
end;

local function updateCartPosition() -- Line: 1362
    -- upvalues: u18 (copy), button2 (copy), ItemButton (copy)
    if not u18.IsOpen then
        return;
    end;

    local AbsolutePosition = button2.AbsolutePosition;
    local AbsoluteSize = button2.AbsoluteSize;
    ItemButton.CartPosition = Vector2.new(AbsolutePosition.X + AbsoluteSize.X / 2, AbsolutePosition.Y + AbsoluteSize.Y / 2);
end;

function u18.UpdateUI() -- Line: 1370
    -- upvalues: u18 (copy), button2 (copy), ItemButton (copy), updateTopBarSize (copy), DropdownController (copy), u137 (copy)
    if u18.IsOpen then
        local AbsolutePosition = button2.AbsolutePosition;
        local AbsoluteSize = button2.AbsoluteSize;
        ItemButton.CartPosition = Vector2.new(AbsolutePosition.X + AbsoluteSize.X / 2, AbsolutePosition.Y + AbsoluteSize.Y / 2);
    end;

    updateTopBarSize();
    DropdownController.UpdateDropdowns();
    u137:Update();
end;

function u18.SetCategorySelectionMode(p203) -- Line: 1379
    -- upvalues: u18 (copy), topBar (copy), SortingSchema (copy), u168 (ref), u16 (ref), u17 (ref), SearchController (copy), searchInput (copy)
    if p203 == u18.CurrentCategorySelectionMode then
        return;
    end;

    local v204 = script:FindFirstChild("CategorySelectionMode_" .. u18.CurrentCategorySelectionMode);
    local v205 = script:FindFirstChild("CategorySelectionMode_" .. p203);

    for _, descendant in topBar:GetDescendants() do
        if descendant:GetAttribute("isStatic") == true then
            descendant.Parent = topBar;
        end;
    end;

    for _, child in topBar:GetChildren() do
        if child:GetAttribute("isStatic") ~= true then
            child.Parent = v204;
        end;
    end;

    u18.CurrentCategorySelectionMode = p203;

    if p203 == "HorizontalScroll" then
        topBar.Size = UDim2.fromScale(1, 0.115);

        for _, child in v205:GetChildren() do
            child.Parent = topBar;
        end;

        local topHalf = topBar:WaitForChild("topHalf");

        for _, child in topBar:GetChildren() do
            if child:GetAttribute("isStatic") == true then
                child.Parent = topHalf;
            end;
        end;

        u18.UpdateCategories({
            SetupCategories = true
        });
    else
        topBar.Size = UDim2.new(1, 0, 0.0706, 0);

        for _, child in v205:GetChildren() do
            child.Parent = topBar;
        end;
    end;

    u18.UpdateSelectionState("Category", "Featured", SortingSchema.Featured, true);

    if u168 then
        u168:SetCurrentChoice("Featured", SortingSchema.Featured.Readable or "Featured", true);
    end;

    if u16 then
        u16:SetCurrentChoice(nil, "", true);
    end;

    if u17 then
        u17:SetCurrentChoice(nil, "", true);
    end;

    u18.UpdateUI();
    refreshDropdowns({ "sub", "type" });

    if not u18.FrontPageVisible then
        task.spawn(function() -- Line: 1444
            -- upvalues: SearchController (ref), searchInput (ref)
            SearchController.StartNewSearch(searchInput.Text or "");
        end);
    end;
end;

function u18.UpdateCategories(p206) -- Line: 1450
    -- upvalues: u18 (copy), CategoryController (copy)
    if u18.CurrentCategorySelectionMode == "HorizontalScroll" then
        CategoryController.UpdateCategories(p206);
    end;
end;

function u18.UpdateActiveFilters(p207) -- Line: 1456
    -- upvalues: u18 (copy), activeFilters (copy), Options (copy), CatalogUtilities (copy)
    if p207 == nil then
        if u18.CanSetActiveFiltersToVisible == false then
            activeFilters.Visible = false;

            return;
        end;

        p207 = Options.ActiveFilters or {};
    end;

    local v208 = table.clone(p207);
    v208.CreatorType = nil;
    v208.SortAggregation = nil;

    for _, child in activeFilters:GetChildren() do
        if child:IsA("TextButton") then
            local v209 = child:GetAttribute("filterType");
            local v210 = v208[v209];

            if v210 == nil then
                child:Destroy();
            elseif v210 ~= child:GetAttribute("filterValue") or v209:match("Price") then
                child:Destroy();
            end;
        end;
    end;

    for i, v in v208 do
        if not activeFilters:FindFirstChild(i) then
            local v211, v212;

            if i == "SortType" then
                local v213, _ = string.gsub(v.Name, "(%l)(%u)", "%1 %2");
                v211 = "Sorting by " .. v213;
                v212 = script.filter:Clone();
                v212.Name = i;
                v212:SetAttribute("filterType", i);
                v212:SetAttribute("filterValue", v);
                v212.label.Text = v211;
                v212.Activated:Connect(function() -- Line: 1522
                    -- upvalues: i (copy), Options (ref), u18 (ref)
                    if i:match("Price") then
                        print("reset price");
                        Options.ResetActiveFilter({ "MaxPrice", "MinPrice" });
                    elseif i:match("Creator") then
                        Options.ResetActiveFilter({ "CreatorName", "CreatorType" });
                    else
                        Options.ResetActiveFilter(i);
                    end;

                    u18.UpdateUI();
                end);
                v212.Parent = activeFilters;
            else
                if i == "IncludeOffSale" then
                    v211 = "Not including offsale items";
                    v212 = script.filter:Clone();
                    v212.Name = i;
                    v212:SetAttribute("filterType", i);
                    v212:SetAttribute("filterValue", v);
                    v212.label.Text = v211;
                    v212.Activated:Connect(function() -- Line: 1522
                        -- upvalues: i (copy), Options (ref), u18 (ref)
                        if i:match("Price") then
                            print("reset price");
                            Options.ResetActiveFilter({ "MaxPrice", "MinPrice" });
                        elseif i:match("Creator") then
                            Options.ResetActiveFilter({ "CreatorName", "CreatorType" });
                        else
                            Options.ResetActiveFilter(i);
                        end;

                        u18.UpdateUI();
                    end);
                    v212.Parent = activeFilters;
                end;

                if i == "CreatorName" then
                    v211 = "By " .. v;
                    v212 = script.filter:Clone();
                    v212.Name = i;
                    v212:SetAttribute("filterType", i);
                    v212:SetAttribute("filterValue", v);
                    v212.label.Text = v211;
                    v212.Activated:Connect(function() -- Line: 1522
                        -- upvalues: i (copy), Options (ref), u18 (ref)
                        if i:match("Price") then
                            print("reset price");
                            Options.ResetActiveFilter({ "MaxPrice", "MinPrice" });
                        elseif i:match("Creator") then
                            Options.ResetActiveFilter({ "CreatorName", "CreatorType" });
                        else
                            Options.ResetActiveFilter(i);
                        end;

                        u18.UpdateUI();
                    end);
                    v212.Parent = activeFilters;
                end;

                if i == "PersonalizedSearchResults" then
                    v211 = "No personalized results";
                    v212 = script.filter:Clone();
                    v212.Name = i;
                    v212:SetAttribute("filterType", i);
                    v212:SetAttribute("filterValue", v);
                    v212.label.Text = v211;
                    v212.Activated:Connect(function() -- Line: 1522
                        -- upvalues: i (copy), Options (ref), u18 (ref)
                        if i:match("Price") then
                            print("reset price");
                            Options.ResetActiveFilter({ "MaxPrice", "MinPrice" });
                        elseif i:match("Creator") then
                            Options.ResetActiveFilter({ "CreatorName", "CreatorType" });
                        else
                            Options.ResetActiveFilter(i);
                        end;

                        u18.UpdateUI();
                    end);
                    v212.Parent = activeFilters;
                end;

                if i == "MinPrice" or i == "MaxPrice" then
                    local MinPrice = activeFilters:FindFirstChild("MinPrice");
                    local MaxPrice = activeFilters:FindFirstChild("MaxPrice");

                    if MinPrice then
                        MinPrice:Destroy();
                    end;

                    if MaxPrice then
                        MaxPrice:Destroy();
                    end;

                    v211 = "Prices ranging from " .. (not v208.MinPrice and "0" or CatalogUtilities.FormatNumberDetailed(v208.MinPrice)) .. " to " .. (not v208.MaxPrice and "∞" or CatalogUtilities.FormatNumberDetailed(v208.MaxPrice));
                    v212 = script.filter:Clone();
                    v212.Name = i;
                    v212:SetAttribute("filterType", i);
                    v212:SetAttribute("filterValue", v);
                    v212.label.Text = v211;
                    v212.Activated:Connect(function() -- Line: 1522
                        -- upvalues: i (copy), Options (ref), u18 (ref)
                        if i:match("Price") then
                            print("reset price");
                            Options.ResetActiveFilter({ "MaxPrice", "MinPrice" });
                        elseif i:match("Creator") then
                            Options.ResetActiveFilter({ "CreatorName", "CreatorType" });
                        else
                            Options.ResetActiveFilter(i);
                        end;

                        u18.UpdateUI();
                    end);
                    v212.Parent = activeFilters;
                end;

                print("not displaying", i);
            end;
        end;
    end;

    local v214;

    if next(v208) == nil then
        v214 = false;
    else
        v214 = u18.CanSetActiveFiltersToVisible ~= false;
    end;

    activeFilters.Visible = v214;
    u18.UpdateUI();
end;

(function() -- Line: 1543, Name: setup
    -- upvalues: Catalog (copy), container (copy), ItemFade (copy), container2 (copy), EquippedController (copy), equippedItemsContainer (copy), noEquippedItems (copy), SearchController (copy), getSelectionData (copy), u18 (copy), u137 (copy), BodyAdjustment (copy), Options (copy), itemsWrapper (copy), catalogSection (copy), bottomBar (copy), searchInput (copy), CategoryController (copy), hasSubTypes (copy), pickDefaultSubcategory (copy), topBar (copy), orderedCategories (copy), u168 (ref), u4 (copy), button2 (copy), Events (copy), closeButton (copy), returnButton (copy), SortingSchema (copy), u16 (ref), u17 (ref), setFrontPageVisible (copy), dprint (copy), AvatarPreviewController (copy), viewport (copy), LocalPlayer (copy), reference (copy), optionsContainer (copy), ClothingAdjustment (copy), button (copy), layeredClothingSortContainer (copy), button3 (copy), bodyAdjustContainer (copy), ScrollingFrameCustomScrollSpeed (copy), CatalogUtilities (copy), HumanoidDescriptionController (copy), Remotes (copy), ShoppingCartController (copy), cartContainer (copy), FavoriteController (copy), getFrontPageItems (copy), u2 (ref)
    Catalog.Enabled = false;
    container.GroupTransparency = 1;
    ItemFade.Setup(container2);
    EquippedController.Setup(equippedItemsContainer, container2, noEquippedItems);
    SearchController.Setup({
        getSelectionData = getSelectionData,
        catalogController = u18,
        scrollFade = u137,
        itemFade = ItemFade,
        equippedController = EquippedController,
        bodyAdjustmentModule = BodyAdjustment,
        optionsModule = Options,
        itemsContainer = container2,
        itemsWrapper = itemsWrapper,
        catalogSection = catalogSection,
        bottomBar = bottomBar,
        searchBox = searchInput
    });
    CategoryController.Setup({
        catalogController = u18,
        getSelectionData = getSelectionData,
        hasSubTypes = hasSubTypes,
        pickDefaultSubcategory = pickDefaultSubcategory,
        topBar = topBar,
        searchBox = searchInput,
        templateButton = script.horizontalScrollCategoryButton,
        verticalDividerTemplate = script.verticalDivider
    });
    local v215 = orderedCategories()[1];

    if v215 then
        u18.UpdateSelectionState("Category", v215.key, v215.data, true);
        u168.currentChoice = v215.key;

        if u4 then
            local v216;

            if v215.data and v215.data.Readable ~= nil then
                v216 = v215.data.Readable;
            else
                v216 = v215.key;
            end;

            u4.Text = v216;
        end;
    end;

    button2.Activated:Connect(function() -- Line: 1584
        -- upvalues: Events (ref)
        Events.ToggleShoppingCart:Fire();
    end);
    closeButton.Activated:Connect(function() -- Line: 1588
        -- upvalues: u18 (ref)
        u18.Close();
    end);

    if returnButton then
        returnButton.Activated:Connect(function() -- Line: 1593
            -- upvalues: u18 (ref), SortingSchema (ref), u168 (ref), u16 (ref), u17 (ref), setFrontPageVisible (ref)
            u18._skipFrontPageDismiss = true;
            u18.UpdateSelectionState("Category", "Featured", SortingSchema.Featured, true);

            if u168 then
                u168:SetCurrentChoice("Featured", SortingSchema.Featured.Readable or "Featured", true);
            end;

            if u16 then
                u16:SetCurrentChoice(nil, "", true);
            end;

            if u17 then
                u17:SetCurrentChoice(nil, "", true);
            end;

            refreshDropdowns({ "sub", "type" });
            u18.UpdateCategories();
            u18.UpdateUI();
            u18._skipFrontPageDismiss = false;
            setFrontPageVisible(true);
        end);
    end;

    Events.RefreshCatalog.Event:Connect(function(p217) -- Line: 1615
        -- upvalues: u18 (ref), SortingSchema (ref), dprint (ref), SearchController (ref), searchInput (ref)
        if p217 == "FavoritesUpdated" then
            local Category = u18.Category;
            local _ = u18.CategoryData or SortingSchema[Category];

            if Category == "Favorites" then
                dprint("Refreshing catalog");
                SearchController.StartNewSearch(searchInput.Text or "");

                return;
            end;

            dprint("Not refreshing catalog as context is FavoritesUpdated but the selected category is no longer Favorites");
        end;
    end);
    Events.RevertToCatalogSearchSnapshot.Event:Connect(u18.RestoreSnapshot);
    AvatarPreviewController.new(viewport, nil, {
        UpdateOnDescriptionApplied = true,
        AllowCameraAdjustment = true,
        IsCatalogPreview = true,
        UseLiveAdjustments = true,
        Target = LocalPlayer
    });
    u18.UpdateUI();
    reference:GetPropertyChangedSignal("AbsoluteSize"):Connect(u18.UpdateUI);
    Options.Setup(optionsContainer);
    Options.OnOptionsApplied:Connect(function(p219, p220) -- Line: 1655
        -- upvalues: dprint (ref), u18 (ref), SearchController (ref), searchInput (ref)
        dprint("Options applied, re-searching with new options:", p219);
        dprint("Active filters:", p220);
        u18.UpdateActiveFilters(p220);
        SearchController.StartNewSearch(searchInput.Text or "");
    end);
    ClothingAdjustment.Setup(button, layeredClothingSortContainer, layeredClothingSortContainer.dropdown.wrapper);
    BodyAdjustment.Setup(button3, bodyAdjustContainer, function() -- Line: 1671
        -- upvalues: u168 (ref), u18 (ref), SortingSchema (ref)
        u168:SetCurrentChoice("BodyAdjustment", "Adjust Body");
        u18.UpdateSelectionState("Category", "BodyAdjustment", SortingSchema.BodyAdjustment);
    end, function() -- Line: 1675
        -- upvalues: SearchController (ref), u18 (ref), Events (ref), BodyAdjustment (ref), SortingSchema (ref), u168 (ref), u16 (ref), u17 (ref), setFrontPageVisible (ref), searchInput (ref)
        if #SearchController.GetSnapshots() > 0 then
            u18.RestoreSnapshot();

            return;
        end;

        local v221 = { "Interface", "ShowCatalogFrontPage" };

        if not Events.GetSetting:GetAttribute("bound") then
            Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
        end;

        local v222 = Events.GetSetting:Invoke(v221) ~= false;
        BodyAdjustment.UpdateButtonColor(false);
        u18.UpdateSelectionState("Category", "Featured", SortingSchema.Featured, true);

        if u168 then
            u168:SetCurrentChoice("Featured", SortingSchema.Featured.Readable or "Featured", true);
        end;

        if u16 then
            u16:SetCurrentChoice(nil, "", true);
        end;

        if u17 then
            u17:SetCurrentChoice(nil, "", true);
        end;

        refreshDropdowns({ "sub", "type" });
        u18.UpdateCategories();

        if v222 then
            setFrontPageVisible(true);

            return;
        end;

        task.spawn(function() -- Line: 1699
            -- upvalues: SearchController (ref), searchInput (ref)
            SearchController.StartNewSearch(searchInput.Text or "");
        end);
    end);
    ScrollingFrameCustomScrollSpeed.Attach(equippedItemsContainer, {
        Mode = "Relative",
        Percent = 33
    });

    local function isMakeupSubcategory() -- Line: 1712
        -- upvalues: u18 (ref), CatalogUtilities (ref)
        if u18.Category ~= "Makeup" then
            return false;
        end;

        local SubcategoryData = u18.SubcategoryData;

        if not (SubcategoryData and SubcategoryData.AssetTypes) then
            return false;
        end;

        for _, v in SubcategoryData.AssetTypes do
            if CatalogUtilities.MakeupAssetTypeToMakeupType[v.Name] then
                return true;
            end;
        end;

        return false;
    end;

    local function refreshAdjustmentList(p223) -- Line: 1724
        -- upvalues: u18 (ref), CatalogUtilities (ref), ClothingAdjustment (ref), LocalPlayer (ref)
        if not p223 then
            return;
        end;

        local v224;

        if u18.Category == "Makeup" then
            local SubcategoryData = u18.SubcategoryData;

            if SubcategoryData and SubcategoryData.AssetTypes then
                v224 = false;

                for _, v in SubcategoryData.AssetTypes do
                    if CatalogUtilities.MakeupAssetTypeToMakeupType[v.Name] then
                        v224 = true;
                        break;
                    end;
                end;
            else
                v224 = false;
            end;
        else
            v224 = false;
        end;

        if v224 then
            ClothingAdjustment.SetMode("makeup");
            local v225 = {};

            for _, child in p223:GetChildren() do
                if child:IsA("MakeupDescription") then
                    local v226 = {
                        AssetId = child.AssetId,
                        Order = child.Order,
                        AssetType = Enum.AvatarAssetType:FromName(CatalogUtilities.MakeupTypeToAssetTypeName[child.MakeupType.Name] or "FaceMakeup")
                    };
                    table.insert(v225, v226);
                end;
            end;

            ClothingAdjustment.UpdateList(v225);

            return;
        end;

        ClothingAdjustment.SetMode("clothing");
        local v227 = {};
        local Character = LocalPlayer.Character;

        if Character then
            local v228 = {};
            local v229 = false;

            for _, child in Character:GetChildren() do
                if child:IsA("Accessory") then
                    local v230 = v228[child.AccessoryType] or {};
                    v228[child.AccessoryType] = v230;
                    table.insert(v230, child);
                    v229 = true;
                end;
            end;

            if v229 then
                local v231 = {};

                for _, v in p223:GetAccessories(true) do
                    v231[v.AccessoryType] = (v231[v.AccessoryType] or 0) + 1;
                    local v232 = v231[v.AccessoryType];
                    local v233 = v228[v.AccessoryType];

                    if v233 then
                        v233 = v233[v232];
                    end;

                    if v233 then
                        local Handle = v233:FindFirstChild("Handle");

                        if Handle and Handle:FindFirstChildOfClass("WrapLayer") then
                            table.insert(v227, v);
                        end;
                    end;
                end;
            else
                v227 = p223:GetAccessories(false);
            end;
        else
            v227 = p223:GetAccessories(false);
        end;

        ClothingAdjustment.UpdateList(v227);
    end;

    u18._refreshAdjustmentList = refreshAdjustmentList;
    HumanoidDescriptionController.OnEquippedUpdated:Connect(function(p234) -- Line: 1789
        -- upvalues: dprint (ref), EquippedController (ref), refreshAdjustmentList (copy), LocalPlayer (ref), Remotes (ref)
        dprint("equipped updated fired");
        EquippedController.UpdateEquipped(p234);
        task.spawn(EquippedController.UpdateFavorited);
        refreshAdjustmentList(p234.Description);
        local Character = LocalPlayer.Character;

        if Character and p234.Description then
            local v235 = {};

            for _, child in Character:GetChildren() do
                if child:IsA("Accessory") then
                    local v236 = v235[child.AccessoryType] or {};
                    v235[child.AccessoryType] = v236;
                    table.insert(v236, child);
                end;
            end;

            local v237 = {};
            local v238 = {};

            for _, v in p234.Description:GetAccessories(true) do
                v237[v.AccessoryType] = (v237[v.AccessoryType] or 0) + 1;

                if v.AccessoryType == Enum.AccessoryType.Hair and v.Order == nil then
                    local v239 = v235[v.AccessoryType];

                    if v239 then
                        v239 = v239[v237[v.AccessoryType]];
                    end;

                    if v239 then
                        local Handle = v239:FindFirstChild("Handle");

                        if Handle and Handle:FindFirstChildOfClass("WrapLayer") then
                            v238[tostring(v.AssetId)] = 11;
                        end;
                    end;
                end;
            end;

            if next(v238) then
                Remotes:WaitForChild("SetLayeredClothingOrder"):FireServer(v238);
            end;
        end;
    end);
    local u240 = nil;

    local function scheduleAccessoryRefresh() -- Line: 1838
        -- upvalues: u240 (ref), HumanoidDescriptionController (ref), refreshAdjustmentList (copy)
        if u240 then
            task.cancel(u240);
        end;

        u240 = task.delay(0.5, function() -- Line: 1840
            -- upvalues: u240 (ref), HumanoidDescriptionController (ref), refreshAdjustmentList (ref)
            u240 = nil;

            if HumanoidDescriptionController.EquippedDict ~= nil then
                refreshAdjustmentList(HumanoidDescriptionController.EquippedDict.Description);
            end;
        end);
    end;

    local u241 = nil;

    local function bindAccessoryListener(p242) -- Line: 1849
        -- upvalues: u241 (ref), u240 (ref), HumanoidDescriptionController (ref), refreshAdjustmentList (copy)
        if u241 then
            u241:Disconnect();
        end;

        u241 = p242.ChildAdded:Connect(function(p243) -- Line: 1851
            -- upvalues: u240 (ref), HumanoidDescriptionController (ref), refreshAdjustmentList (ref)
            if p243:IsA("Accessory") then
                if u240 then
                    task.cancel(u240);
                end;

                u240 = task.delay(0.5, function() -- Line: 1840
                    -- upvalues: u240 (ref), HumanoidDescriptionController (ref), refreshAdjustmentList (ref)
                    u240 = nil;

                    if HumanoidDescriptionController.EquippedDict ~= nil then
                        refreshAdjustmentList(HumanoidDescriptionController.EquippedDict.Description);
                    end;
                end);
            end;
        end);
    end;

    if LocalPlayer.Character then
        local Character = LocalPlayer.Character;

        if u241 then
            u241:Disconnect();
        end;

        u241 = Character.ChildAdded:Connect(function(p244) -- Line: 1851
            -- upvalues: u240 (ref), HumanoidDescriptionController (ref), refreshAdjustmentList (copy)
            if p244:IsA("Accessory") then
                if u240 then
                    task.cancel(u240);
                end;

                u240 = task.delay(0.5, function() -- Line: 1840
                    -- upvalues: u240 (ref), HumanoidDescriptionController (ref), refreshAdjustmentList (ref)
                    u240 = nil;

                    if HumanoidDescriptionController.EquippedDict ~= nil then
                        refreshAdjustmentList(HumanoidDescriptionController.EquippedDict.Description);
                    end;
                end);
            end;
        end);
    end;

    LocalPlayer.CharacterAdded:Connect(bindAccessoryListener);
    ShoppingCartController.OnCartUpdated:Connect(function() -- Line: 1858
        -- upvalues: ShoppingCartController (ref), cartContainer (ref)
        if ShoppingCartController.TotalCount ~= nil then
            cartContainer.itemCount.Text = tostring(ShoppingCartController.TotalCount);
            cartContainer.itemCount.Visible = ShoppingCartController.TotalCount > 0;
        end;
    end);

    if ShoppingCartController.TotalCount ~= nil then
        cartContainer.itemCount.Text = tostring(ShoppingCartController.TotalCount);
        cartContainer.itemCount.Visible = ShoppingCartController.TotalCount > 0;
    end;

    FavoriteController.AddFavoritesUpdatedListener(EquippedController.UpdateFavorited);
    u18.UpdateUI();
    refreshDropdowns({ "sub", "type" });
    getFrontPageItems(false, function(p245, p246) -- Line: 1868
    end);

    if HumanoidDescriptionController.EquippedDict ~= nil then
        EquippedController.UpdateEquipped(HumanoidDescriptionController.EquippedDict);
        ClothingAdjustment.UpdateList(HumanoidDescriptionController.EquippedDict.Description:GetAccessories(false));
    end;

    Remotes.SettingsUpdated.OnClientEvent:Connect(function(p247) -- Line: 1877
        -- upvalues: u18 (ref)
        local v248;

        if p247.Catalog then
            v248 = p247.Catalog.CategorySelectionMode;
        else
            v248 = nil;
        end;

        if v248 then
            u18.SetCategorySelectionMode(v248);
        end;
    end);
    task.spawn(function() -- Line: 1884
        -- upvalues: u18 (ref), Events (ref), dprint (ref)
        u18.CurrentCategorySelectionMode = "Dropdowns";
        local v249 = { "Catalog", "CategorySelectionMode" };

        if not Events.GetSetting:GetAttribute("bound") then
            Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
        end;

        local v250 = Events.GetSetting:Invoke(v249);
        dprint("category selection mode:", v250);

        if v250 then
            u18.SetCategorySelectionMode(v250);
        end;
    end);
    u2 = true;
end)();

return u18;