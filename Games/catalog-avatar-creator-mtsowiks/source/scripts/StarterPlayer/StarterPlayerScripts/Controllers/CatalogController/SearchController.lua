-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local AvatarEditorService = game:GetService("AvatarEditorService");
game:GetService("ReplicatedStorage");
local Modules = require(script.Parent.Parent.Parent.Modules);
local InventoryService = require(Modules.Services.InventoryService);
local FavoriteController = require(Modules.Controllers.FavoriteController);
local LoadingController = require(Modules.Controllers.LoadingController);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local RecentController = require(Modules.Controllers.RecentController);
local ItemButton = require(Modules.Elements.ItemButton);
local ItemTemplates = require(script.ItemTemplates);
local Events = script.Parent.Parent.Parent:WaitForChild("Events");

local function dprint(...) -- Line: 26
end;

local u1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = {
    pages = nil,
    loading = false,
    active = false,
    keyword = nil,
    reachedEnd = true,
    thread = nil,
    index = 0,
    connections = {}
};
local u15 = {};
local u16 = {};

function u1.Setup(p17) -- Line: 62
    -- upvalues: u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u1 (copy)
    u2 = p17.getSelectionData;
    u3 = p17.catalogController;
    u4 = p17.scrollFade;
    u5 = p17.itemFade;
    u6 = p17.equippedController;
    u7 = p17.bodyAdjustmentModule;
    u8 = p17.optionsModule;
    u9 = p17.itemsContainer;
    u10 = p17.itemsWrapper;
    u11 = p17.catalogSection;
    u12 = p17.bottomBar;
    u13 = p17.searchBox;
    u10:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 77
        -- upvalues: u1 (ref)
        u1.TryLoadingMoreItems();
    end);
end;

local function clearItems() -- Line: 82
    -- upvalues: u9 (ref)
    for _, child in u9:GetChildren() do
        if child:GetAttribute("isItem") == true or child.Name == "item" then
            child:Destroy();
        end;
    end;
end;

local function killSearch() -- Line: 90
    -- upvalues: u14 (copy), u5 (ref)
    local thread = u14.thread;

    if thread then
        pcall(task.cancel, thread);
    end;

    u14.thread = nil;
    u14.pages = nil;
    u14.keyword = nil;
    u14.loading = nil;
    u14.active = false;
    u14.reachedEnd = true;
    u5.Reset();
end;

local function getFilterOutSet() -- Line: 106
    -- upvalues: u2 (ref)
    local _, v18, _, v19, _, v20 = u2();
    local v21 = v20 or (v19 or v18);

    if not v21 then
        return nil;
    end;

    local FilterOutAfterResults = v21.FilterOutAfterResults;

    if FilterOutAfterResults then
        v18 = FilterOutAfterResults;
    elseif v18 then
        v18 = v18.FilterOutAfterResults;
    end;

    if type(v18) ~= "table" then
        return nil;
    end;

    local v22 = {};

    for _, v in v18 do
        if typeof(v) == "EnumItem" then
            v22[v.Name] = true;
        else
            v22[tostring(v)] = true;
        end;
    end;

    return v22;
end;

local function applyFilterOut(p23) -- Line: 123
    -- upvalues: getFilterOutSet (copy), dprint (copy)
    if type(p23) ~= "table" then
        return p23;
    end;

    local v24 = getFilterOutSet();

    if not v24 then
        return p23;
    end;

    local v25 = {};
    local v26 = 0;

    for _, v in p23 do
        if v and v.ItemType == "Asset" then
            local v27 = tostring(v.AssetType or "");

            if v27 == "" or not v24[v27] then
                v25[#v25 + 1] = v;
            else
                v26 = v26 + 1;
            end;
        else
            v25[#v25 + 1] = v;
        end;
    end;

    if v26 > 0 then
        dprint("FilterOutAfterResults:", v26, "removed of", #p23, "→", #v25, "kept");
    end;

    return v25;
end;

local function loadItems(p28) -- Line: 146
    -- upvalues: dprint (copy), u2 (ref), u9 (ref), ItemButton (copy), u5 (ref), u6 (ref), HumanoidDescriptionController (copy), u4 (ref)
    if not p28 or #p28 == 0 then
        dprint("loadItems: empty chunk");

        return;
    end;

    local _, v29 = u2("Category");
    local v30 = 0;

    for _, child in u9:GetChildren() do
        if child:GetAttribute("isItem") == true and (typeof(child.LayoutOrder) == "number" and v30 < child.LayoutOrder) then
            v30 = child.LayoutOrder;
        end;
    end;

    local v31 = v30 + 1;
    local v32 = v31;
    local v33 = 0;

    for _, v in p28 do
        v33 = v33 + 1;

        if v33 % 3 == 0 then
            task.wait();
        end;

        if v29 and v29.SpecialCase == "Inventory" then
            v.IsInventoryItem = true;
        end;

        local v34 = ItemButton.new({
            AvatarPreviewOnHover = true,
            IsCatalogItem = true,
            IsFavoriteAvailable = true,
            AddEquippedOverlay = true,
            ItemDetails = v
        });

        if v.Meta and v.Meta.Label then
            ItemButton.AddLabel(v34, v.Meta.Label);
            warn("Added label");
        end;

        v34.LayoutOrder = v31;
        v31 = v31 + 1;
        v34.Parent = u9;
    end;

    task.spawn(u5.FadeAllItems, v32);
    task.spawn(u6.UpdateEquipped, HumanoidDescriptionController.EquippedDict, true);
    task.spawn(u6.UpdateFavorited);
    u4:Update();
end;

local function sanitizeSearchKeyword(p35) -- Line: 201
    return tostring(p35 or ""):gsub("^%s+", ""):gsub("%s+$", "");
end;

local function createCatalogSearchParams(p36) -- Line: 205
    -- upvalues: u2 (ref), u8 (ref), dprint (copy), ItemTemplates (copy)
    local v37, v38, _, v39, _, v40 = u2();
    local v41 = u8.GetOptions();
    local v42 = tostring(p36 or ""):gsub("^%s+", ""):gsub("%s+$", "");
    local v43 = CatalogSearchParams.new();
    v43.Limit = 120;
    v43.SortType = v41.SortType;
    v43.SortAggregation = v41.SortAggregation;

    if v41.IncludeOffSale == true then
        local IgnorePersonalizedSearchResults = v38.IgnorePersonalizedSearchResults;

        if v39 then
            IgnorePersonalizedSearchResults = v39.IgnorePersonalizedSearchResults;
        end;

        if v41.PersonalizedSearchResults and (p36 == "" and not IgnorePersonalizedSearchResults) then
            v43.IncludeOffSale = false;
        else
            v43.IncludeOffSale = v41.IncludeOffSale;
        end;
    end;

    v43.CreatorType = v41.CreatorType;

    if v41.CreatorName ~= nil then
        v43.CreatorName = v41.CreatorName;
    end;

    v43.MinPrice = not v41.MinPrice and 0 or math.max(v41.MinPrice, 0);
    v43.MaxPrice = not v41.MaxPrice and 2147483647 or math.min(v41.MaxPrice, 2147483647);

    if not v38 then
        v43.SearchKeyword = v42;
        dprint("buildParams: no category; Limit=", v43.Limit, "SortType=", (tostring(v43.SortType)));

        return v43;
    end;

    local v44 = v40 or (v39 or v38);

    if type(v44.SearchKeyword) == "string" and v44.SearchKeyword ~= "" then
        if v42 == "" then
            v42 = v44.SearchKeyword;
        else
            v42 = v42 .. " " .. v44.SearchKeyword;
        end;
    end;

    v43.SearchKeyword = v42;

    if v39 and v39.IncludeOffSale ~= nil then
        v43.IncludeOffSale = v39.IncludeOffSale;
    end;

    if v39 and v39.SortType ~= nil then
        v43.SortType = v39.SortType;
    end;

    if v39 and v39.SortAggregation ~= nil then
        v43.SortAggregation = v39.SortAggregation;
    end;

    if v38.CategoryFilter ~= nil then
        v43.CategoryFilter = v38.CategoryFilter;
    end;

    if v38.SalesTypeFilter == nil then
        v43.SalesTypeFilter = Enum.SalesTypeFilter.All;
    else
        v43.SalesTypeFilter = v38.SalesTypeFilter;
    end;

    if v44.CreatorName ~= nil then
        v43.CreatorName = v44.CreatorName;
    end;

    local v45 = v44.AssetTypes or v38.AssetTypes;
    local v46 = v44.BundleTypes or v38.BundleTypes;
    local v47 = {};

    if v46 and (table.find(v46, Enum.BundleType.DynamicHead) and (v38.SpecialCase == nil or v38.SpecialCase == "BodyAdjustment")) and (string.match(string.lower(v42), "headless") or v38.SpecialCase == "BodyAdjustment" and v42 == "") then
        table.insert(v47, ItemTemplates.Headless);
    end;

    local v48;

    if v45 and v42 ~= "" then
        local FilterOutAfterResults = v44.FilterOutAfterResults;

        if FilterOutAfterResults then
            v38 = FilterOutAfterResults;
        elseif v38 then
            v38 = v38.FilterOutAfterResults;
        end;

        if v38 and type(v38) == "table" then
            local v49 = {};

            for _, v in v38 do
                v49[v] = true;
            end;

            v48 = {};

            for _, v in v45 do
                if not v49[v] then
                    table.insert(v48, v);
                end;
            end;

            if #v48 > 0 then
                dprint("Removed FilterOutAfterResults from AssetTypes for search:", #v38, "types excluded");
            else
                v48 = v45;
            end;
        else
            v48 = v45;
        end;
    else
        v48 = v45;
    end;

    if v48 then
        v43.AssetTypes = v48;
    end;

    if v46 then
        v43.BundleTypes = v46;
    end;

    dprint("buildParams", "Category=", v37 or "(none)", "Sub=", v39 and (v39.Readable or "(sub)") or "(none)", "Type=", v40 and (v40.Readable or "(type)") or "(none)", "Keyword=", v43.SearchKeyword == "" and "(empty)" or v43.SearchKeyword, "SalesTypeFilter", tostring(v43.SalesTypeFilter), "SortType=", tostring(v43.SortType), "Aggregation=", tostring(v43.SortAggregation), "IncludeOffSale=", tostring(v43.IncludeOffSale), "CreatorType=", tostring(v43.CreatorType), "CreatorName=", tostring(v43.CreatorName), "MinPrice=", tostring(v43.MinPrice), "MaxPrice=", tostring(v43.MaxPrice), "Limit=", v43.Limit, "AssetTypes=", v43.AssetTypes, "BundleTypes=", v43.BundleTypes);

    return v43, v47;
end;

local function getItemsFromPage(u50, p51, p52, p53, u54) -- Line: 314
    -- upvalues: u14 (copy), applyFilterOut (copy), dprint (copy), LoadingController (copy)
    local u55 = {};
    local u56 = false;
    u14.loading = true;

    local function loadAndFilterItems(p57) -- Line: 320
        -- upvalues: u54 (copy), u55 (copy), u14 (ref), applyFilterOut (ref), u56 (ref)
        if not p57 then
            return;
        end;

        if u54 and #u54 > 0 then
            table.insert(u55, table.unpack(u54));
        end;

        if u14.keyword and u14.keyword ~= "" then
            for _, v in p57 do
                table.insert(u55, v);
            end;

            return;
        end;

        local v58 = applyFilterOut(p57);

        if v58 and #v58 < #p57 then
            u56 = true;
        end;

        for _, v in v58 or p57 do
            table.insert(u55, v);
        end;
    end;

    loadAndFilterItems(p51);
    local v59 = false;

    while #u55 < p52 and (u50 and not u50.IsFinished) do
        local success, result = pcall(function() -- Line: 352
            -- upvalues: u50 (copy)
            u50:AdvanceToNextPageAsync();
        end);

        if not success then
            dprint("AdvanceToNextPageAsync FAILED during fill:", result);
            break;
        end;

        v59 = true;
        local success2, result2 = pcall(function() -- Line: 360
            -- upvalues: u50 (copy)
            return u50:GetCurrentPage();
        end);

        if not success2 then
            dprint("GetCurrentPage FAILED during fill:", result2);
            break;
        end;

        loadAndFilterItems(result2);

        if result2 and #result2 == 0 then
            break;
        end;
    end;

    u14.loading = false;
    LoadingController.RemoveLoading();
    local v60 = u56 and v59;
    local v61 = #u55;

    if v60 then
        dprint("Conditional streaming: ENABLED (sawFiltering && neededFill)");
        local v62 = 1;

        while v62 <= v61 do
            local v63 = math.min(v62 + 6 - 1, v61);
            local v64 = table.create(v63 - v62 + 1);
            table.move(u55, v62, v63, 1, v64);
            p53(v64);
            v62 = v63 + 1;
        end;
    else
        dprint("Conditional streaming: DISABLED (batch append)");

        if v61 > 0 then
            p53(u55);
        end;
    end;

    return v61, v60;
end;

local function handleSearchError(p65) -- Line: 399
    -- upvalues: Events (copy)
    if typeof(p65) == "string" then
        if p65:match("429") then
            Events.Notify:Fire("⚠️ Too many requests. Please slow down and try again.");

            return;
        end;

        if p65:match("403") then
            Events.Notify:Fire("🛠️ Roblox is currently having issues and are actively working on it.");
            Events.Notify:Fire("Thank you for your patience.");
            print("Roblox is currently having issues and are actively working on it.");
            print("Thank you for your patience.");

            return;
        end;

        if p65:match("NetFail") then
            Events.Notify:Fire("🛜 There seems to be issues with your internet. Please wait and try again.", 8);

            return;
        end;

        Events.Notify:Fire("⚠️ Something went wrong. Debug: " .. tostring(p65));
        warn("unknown error during search:", p65);
    end;
end;

local function loadChunk(p66, p67) -- Line: 417
    -- upvalues: u14 (copy), loadItems (copy)
    local keyword = u14.keyword;

    if not (keyword and p67) then
        loadItems(p66);

        return;
    end;

    local v68 = string.lower(keyword);
    local v69 = {};

    for _, v in p66 do
        local v70 = tostring(v.Name or "");

        if string.lower(v70):match(v68) then
            table.insert(v69, v);
        end;
    end;

    loadItems(v69);
end;

local function getReadable(p71, p72) -- Line: 437
    if not p71 then
        return nil;
    end;

    if p72 and p72.Readable then
        return p72.Readable;
    end;

    return p71;
end;

function u1.StartNewSearch(p73) -- Line: 442
    -- upvalues: u16 (ref), u15 (copy), LoadingController (copy), u11 (ref), u14 (copy), u5 (ref), clearItems (copy), u4 (ref), u2 (ref), u7 (ref), FavoriteController (copy), u12 (ref), u10 (ref), u3 (ref), InventoryService (copy), RecentController (copy), loadItems (copy), u9 (ref), ItemButton (copy), createCatalogSearchParams (copy), AvatarEditorService (copy), dprint (copy), handleSearchError (copy), getItemsFromPage (copy), loadChunk (copy)
    if u16 and next(u16) then
        table.insert(u15, u16);

        if #u15 > 3 then
            table.remove(u15, 1);
        end;
    end;

    LoadingController.DisplayLoading(u11, "overlay");
    local thread = u14.thread;

    if thread then
        pcall(task.cancel, thread);
    end;

    u14.thread = nil;
    u14.pages = nil;
    u14.keyword = nil;
    u14.loading = nil;
    u14.active = false;
    u14.reachedEnd = true;
    u5.Reset();
    clearItems();
    LoadingController.ClearGraphics("catalog");
    u4:ShowTopFade(false);
    u4:Update();
    u14.active = true;
    u14.reachedEnd = false;
    u14.loading = true;
    u14.keyword = nil;
    local v74 = u14;
    v74.index = v74.index + 1;
    local v75, u76, u77, u78, u79, u80 = u2();
    local u81;

    if p73 then
        u81 = tostring(p73 or ""):gsub("^%s+", ""):gsub("%s+$", "");
    else
        u81 = nil;
    end;

    local SpecialCase = u76.SpecialCase;

    if SpecialCase == "BodyAdjustment" then
        u16 = nil;
    else
        local v82 = {
            keyword = u81
        };
        local v83 = {
            Key = v75
        };

        if v75 then
            if u76 and u76.Readable then
                v75 = u76.Readable;
            end;
        else
            v75 = nil;
        end;

        v83.Readable = v75;
        v82.category = v83;
        local v84 = {
            Key = u77
        };
        local v85;

        if u77 then
            if u78 and u78.Readable then
                v85 = u78.Readable;
            else
                v85 = u77;
            end;
        else
            v85 = nil;
        end;

        v84.Readable = v85;
        v82.subcategory = v84;
        local v86 = {
            Key = u79
        };
        local v87;

        if u79 then
            if u80 and u80.Readable then
                v87 = u80.Readable;
            else
                v87 = u79;
            end;
        else
            v87 = nil;
        end;

        v86.Readable = v87;
        v82.type = v86;
        u16 = v82;
    end;

    u14.thread = task.spawn(function() -- Line: 479
        -- upvalues: u14 (ref), u81 (copy), u7 (ref), SpecialCase (copy), FavoriteController (ref), u12 (ref), u10 (ref), u77 (copy), u3 (ref), u80 (copy), InventoryService (ref), u79 (copy), RecentController (ref), LoadingController (ref), u78 (copy), loadItems (ref), u9 (ref), ItemButton (ref), createCatalogSearchParams (ref), AvatarEditorService (ref), dprint (ref), handleSearchError (ref), getItemsFromPage (ref), u76 (copy), loadChunk (ref), u4 (ref)
        local v88 = nil;
        local u89 = nil;
        local v90 = nil;
        u14.keyword = u81;
        u7.RemoveCurrentPage(true);
        u7.UpdateButtonColor(SpecialCase == "BodyAdjustment");

        if SpecialCase == "Favorites" then
            if FavoriteController.ClosedRobloxImportBanner == true then
                FavoriteController.AddImportButton(u12);
            else
                FavoriteController.AddImportBanner(u10, u12);
            end;
        else
            FavoriteController.RemoveImportBanner();
            FavoriteController.RemoveImportButton();
        end;

        if SpecialCase == "BodyAdjustment" and (u77 == "Body" or u77 == "SkinTones") then
            if u3.CanSetActiveFiltersToVisible ~= false then
                u3.CanSetActiveFiltersToVisible = false;
                u3.UpdateActiveFilters();
            end;
        elseif u3.CanSetActiveFiltersToVisible == false then
            u3.CanSetActiveFiltersToVisible = true;
            u3.UpdateActiveFilters();
        end;

        if SpecialCase == "Inventory" then
            local keyword = u14.keyword;

            if keyword and (u80 and (type(u80.SearchKeyword) == "string" and u80.SearchKeyword ~= "")) then
                if keyword == "" then
                    keyword = u80.SearchKeyword;
                else
                    keyword = keyword .. " " .. u80.SearchKeyword;
                end;
            end;

            u89 = InventoryService.GetInventory(u77, u79, keyword);
            v90 = true;
        elseif SpecialCase == "Favorites" then
            local keyword = u14.keyword;

            if keyword and (u80 and (type(u80.SearchKeyword) == "string" and u80.SearchKeyword ~= "")) then
                if keyword == "" then
                    keyword = u80.SearchKeyword;
                else
                    keyword = keyword .. " " .. u80.SearchKeyword;
                end;
            end;

            u89 = FavoriteController.GetFavoritesPaged(u77, u79, keyword);
            v90 = true;
        elseif SpecialCase == "Recent" then
            u89 = RecentController.GetRecentItemsPaged(u14.keyword);
            v90 = true;
        elseif SpecialCase == "BodyAdjustment" and (u77 == "Body" or u77 == "SkinTones") then
            if u77 == "Body" then
                u7.DisplayPage({
                    Type = "BodyAdjustment"
                });
            elseif u77 == "SkinTones" then
                u7.DisplayPage({
                    Type = "SkinTones"
                });
            end;

            LoadingController.RemoveLoading();
        elseif SpecialCase == "BodyAdjustment" and (u78 and u78.SpecialCase == "HeadShapes") then
            local Shapes = u78.Shapes;

            if Shapes then
                local v91 = {};

                for _, v in Shapes do
                    local v92 = {
                        ItemType = "Asset",
                        AssetType = "HeadShape",
                        CreatorName = "Roblox",
                        CreatorTargetId = 1,
                        CreatorType = "User",
                        CreatorHasVerifiedBadge = true,
                        IsOffSale = true,
                        IsPurchasable = false,
                        Id = v.AssetId,
                        Name = v.Name,
                        ItemRestrictions = {},
                        ItemStatus = {},
                        Thumbnail = "rbxthumb://type=Asset&id=" .. tostring(v.AssetId) .. "&w=420&h=420"
                    };
                    table.insert(v91, v92);
                end;

                local keyword = u14.keyword;

                if keyword and keyword ~= "" then
                    local v93 = string.lower(keyword);
                    local filtered = {};

                    for _, v in v91 do
                        if string.find(string.lower(v.Name), v93, 1, true) then
                            table.insert(filtered, v);
                        end;
                    end;

                    v91 = filtered;
                end;

                loadItems(v91);

                for _, child in u9:GetChildren() do
                    if child:GetAttribute("isItem") == true then
                        ItemButton.SetPriceLabel(child, "");
                    end;
                end;
            end;

            u14.reachedEnd = true;
            LoadingController.RemoveLoading();
        else
            local u94, v95 = createCatalogSearchParams(u14.keyword);
            v90, u89 = pcall(function() -- Line: 602
                -- upvalues: AvatarEditorService (ref), u94 (copy)
                return AvatarEditorService:SearchCatalog(u94);
            end);
            v88 = v95 or v88;
        end;

        if not v90 or typeof(u89) ~= "Instance" and typeof(u89) ~= "table" then
            dprint("SearchCatalog FAILED:", u89, (typeof(u89)));
            handleSearchError(u89);
            u14.reachedEnd = true;
            u14.active = false;

            return;
        end;

        u14.pages = u89;
        dprint("SearchCatalog OK. IsFinished=", (tostring(u89 and u89.IsFinished)));
        local success, result = pcall(function() -- Line: 619
            -- upvalues: u89 (ref)
            local v96 = u89 and u89:GetCurrentPage();

            return v96;
        end);

        if not success then
            dprint("GetCurrentPage FAILED:", result, (typeof(result)));
            handleSearchError(result);
            u14.reachedEnd = true;
            u14.active = false;

            return;
        end;

        local v97 = #(result or {});
        dprint("First page raw count=", #(result or {}));
        getItemsFromPage(u89, result or {}, 60, function(p98) -- Line: 637
            -- upvalues: u76 (ref), loadChunk (ref)
            loadChunk(p98, (u76.SpecialCase == "Inventory" or u76.SpecialCase == "Favorites") and true or u76.SpecialCase == "Recent");
        end, v88);
        local v99;

        if u89 then
            v99 = u89.IsFinished == true;
        else
            v99 = false;
        end;

        u14.reachedEnd = v99;

        if u14.reachedEnd == true then
            if v97 == 0 then
                LoadingController.DisplayGraphic(u10, "catalog", "noResults");
            else
                LoadingController.DisplayGraphic(u10, "catalog", "reachedEnd");
            end;
        end;

        u14.active = not u14.reachedEnd;
        u4:Update();
    end);
end;

local function isNearBottom() -- Line: 659
    -- upvalues: u10 (ref)
    local Y = u10.AbsoluteCanvasSize.Y;
    local Y2 = u10.AbsoluteWindowSize.Y;

    if Y <= Y2 then
        return false;
    end;

    return u10.CanvasPosition.Y >= Y - Y2 - 40;
end;

function u1.LoadNextPage() -- Line: 671
    -- upvalues: u14 (copy), LoadingController (copy), u10 (ref), u2 (ref), dprint (copy), getItemsFromPage (copy), loadChunk (copy), u4 (ref), u1 (copy)
    local pages = u14.pages;

    if not (u14.thread and pages) then
        return;
    end;

    if u14.reachedEnd or (u14.loading or pages and pages.IsFinished == true) then
        return;
    end;

    u14.loading = true;
    LoadingController.DisplayLoading(u10, "foot");
    u14.thread = task.spawn(function() -- Line: 679
        -- upvalues: u2 (ref), pages (copy), dprint (ref), u14 (ref), getItemsFromPage (ref), loadChunk (ref), LoadingController (ref), u10 (ref), u4 (ref), u1 (ref)
        local _, u100, _, _, _, _ = u2();
        local success, result = pcall(function() -- Line: 682
            -- upvalues: pages (ref)
            return pages:AdvanceToNextPageAsync();
        end);

        if not success then
            dprint("AdvanceToNextPageAsync FAILED:", result);
            u14.loading = false;

            return;
        end;

        local success2, result2 = pcall(function() -- Line: 691
            -- upvalues: pages (ref)
            local v101 = pages and pages:GetCurrentPage();

            return v101;
        end);

        if not success2 then
            dprint("GetCurrentPage FAILED after advance:", result2);
            u14.loading = false;

            return;
        end;

        local v102 = #(result2 or {});
        dprint("Next page raw count=", v102, "IsFinished=", (tostring(pages and pages.IsFinished)));
        getItemsFromPage(pages, result2 or {}, 60, function(p103) -- Line: 706
            -- upvalues: u100 (copy), loadChunk (ref)
            loadChunk(p103, (u100.SpecialCase == "Inventory" or u100.SpecialCase == "Favorites") and true or u100.SpecialCase == "Recent");
        end);
        local v104;

        if pages then
            v104 = pages.IsFinished == true;
        else
            v104 = false;
        end;

        u14.reachedEnd = v104;

        if u14.reachedEnd == true then
            LoadingController.DisplayGraphic(u10, "catalog", "reachedEnd");
        end;

        u14.loading = false;
        LoadingController.RemoveLoading();
        u4:Update();

        if not u14.reachedEnd then
            local Y = u10.AbsoluteCanvasSize.Y;
            local Y2 = u10.AbsoluteWindowSize.Y;
            local v105;

            if Y <= Y2 then
                v105 = false;
            else
                v105 = u10.CanvasPosition.Y >= Y - Y2 - 40;
            end;

            if v105 then
                dprint("chaining next page automatically (still near bottom)");
                u1.LoadNextPage();
            end;
        end;
    end);
end;

function u1.TryLoadingMoreItems() -- Line: 727
    -- upvalues: u14 (copy), u10 (ref), dprint (copy), u1 (copy)
    if not u14.active or (u14.reachedEnd or u14.loading) then
        return;
    end;

    local Y = u10.AbsoluteCanvasSize.Y;
    local Y2 = u10.AbsoluteWindowSize.Y;
    local v106;

    if Y <= Y2 then
        v106 = false;
    else
        v106 = u10.CanvasPosition.Y >= Y - Y2 - 40;
    end;

    if v106 then
        dprint("advancing to next page (scroll near bottom)");
        u1.LoadNextPage();
    end;
end;

function u1.GetSnapshots() -- Line: 735
    -- upvalues: u15 (copy)
    return u15;
end;

function u1.SetActiveState(p107) -- Line: 739
    -- upvalues: u14 (copy)
    u14.active = p107;
end;

function u1.KillSearch() -- Line: 743
    -- upvalues: u14 (copy), u5 (ref)
    local thread = u14.thread;

    if thread then
        pcall(task.cancel, thread);
    end;

    u14.thread = nil;
    u14.pages = nil;
    u14.keyword = nil;
    u14.loading = nil;
    u14.active = false;
    u14.reachedEnd = true;
    u5.Reset();
end;

return u1;