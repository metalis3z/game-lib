-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AvatarEditorService = game:GetService("AvatarEditorService");
local Modules = require(script.Parent.Parent.Modules);
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Parent:WaitForChild("Events");
local favoritesImportBanner = script:FindFirstChild("favoritesImportBanner");
local import = ReplicatedStorage.UI.Buttons.import;
local SortingSchema = require(Modules.Shared.SortingSchema);
local Cache = require(Modules.Services.Cache);

local function debugPrint(...) -- Line: 16
    print("[FavoriteController]", ...);
end;

local u1 = {
    Loaded = false,
    Favorites = {},
    FavoritesUpdatedListeners = {},
    ItemsCache = {},
    ClosedRobloxImportBanner = false,
    RefreshCatalogOnUpdate = false,
    DetailsCache = {},
    CurrentImportButton = nil,
    CurrentImportBanner = nil
};
local Favorites = SortingSchema.Favorites;

local function getFavoritesCount() -- Line: 38
    -- upvalues: u1 (copy)
    local v2 = 0;

    for _ in u1.Favorites or {} do
        v2 = v2 + 1;
    end;

    return v2;
end;

local function getDetailsCacheCount() -- Line: 46
    -- upvalues: u1 (copy)
    local v3 = 0;

    for _ in u1.DetailsCache or {} do
        v3 = v3 + 1;
    end;

    return v3;
end;

local function isLeafCategory(p4) -- Line: 54
    return p4.NoSubcategories or (p4.Subcategories == nil and true or next(p4.Subcategories) == nil);
end;

local u5 = nil;

local function addTypeTargets(p6, u7, u8) -- Line: 67
    -- upvalues: u5 (ref)
    local function addList(p9, p10) -- Line: 68
        -- upvalues: u5 (ref), u7 (copy), u8 (copy)
        if p10 == nil then
            return;
        end;

        for _, v in p10 do
            local v11 = p9 .. "|" .. v.Name;
            local v12 = u5[v11];

            if not v12 then
                v12 = {};
                u5[v11] = v12;
            end;

            local v13 = false;

            for _, v2 in v12 do
                if v2.Category == u7 and v2.Subcategory == u8 then
                    v13 = true;
                    break;
                end;
            end;

            if not v13 then
                table.insert(v12, {
                    Category = u7,
                    Subcategory = u8
                });
            end;
        end;
    end;

    addList("Asset", p6.AssetTypes);
    addList("Bundle", p6.BundleTypes);
end;

local function getTypeTargets(p14, p15) -- Line: 94
    -- upvalues: u5 (ref), Favorites (copy)
    if u5 == nil then
        u5 = {};

        for i, v in Favorites.Subcategories do
            if v.NoSubcategories or (v.Subcategories == nil and true or next(v.Subcategories) == nil) then
                local u16 = nil;

                local function v22(p17, p18) -- Line: 68
                    -- upvalues: u5 (ref), i (copy), u16 (copy)
                    if p18 == nil then
                        return;
                    end;

                    for _, v2 in p18 do
                        local v19 = p17 .. "|" .. v2.Name;
                        local v20 = u5[v19];

                        if not v20 then
                            v20 = {};
                            u5[v19] = v20;
                        end;

                        local v21 = false;

                        for _, v3 in v20 do
                            if v3.Category == i and v3.Subcategory == u16 then
                                v21 = true;
                                break;
                            end;
                        end;

                        if not v21 then
                            table.insert(v20, {
                                Category = i,
                                Subcategory = u16
                            });
                        end;
                    end;
                end;

                v22("Asset", v.AssetTypes);
                v22("Bundle", v.BundleTypes);
            else
                for i2, v2 in v.Subcategories do
                    local function v28(p23, p24) -- Line: 68
                        -- upvalues: u5 (ref), i (copy), i2 (copy)
                        if p24 == nil then
                            return;
                        end;

                        for _, v3 in p24 do
                            local v25 = p23 .. "|" .. v3.Name;
                            local v26 = u5[v25];

                            if not v26 then
                                v26 = {};
                                u5[v25] = v26;
                            end;

                            local v27 = false;

                            for _, v4 in v26 do
                                if v4.Category == i and v4.Subcategory == i2 then
                                    v27 = true;
                                    break;
                                end;
                            end;

                            if not v27 then
                                table.insert(v26, {
                                    Category = i,
                                    Subcategory = i2
                                });
                            end;
                        end;
                    end;

                    v28("Asset", v2.AssetTypes);
                    v28("Bundle", v2.BundleTypes);
                end;
            end;
        end;
    end;

    local v29;

    if typeof(p15) == "EnumItem" then
        v29 = p15.Name;
    else
        v29 = tostring(p15);
    end;

    return u5[p14 .. "|" .. v29];
end;

local function addItemToCache(p30, p31, p32, p33, p34) -- Line: 111
    local v35;

    if p32 == nil then
        p30[p31] = p30[p31] or {};
        v35 = p30[p31];
    else
        p30[p31] = p30[p31] or {};
        p30[p31][p32] = p30[p31][p32] or {};
        v35 = p30[p31][p32];
    end;

    if p34 then
        local v36 = p33.AssetId or p33.Id;
        local ItemType = p33.ItemType;

        for _, v in v35 do
            if (v.AssetId or v.Id) == v36 and v.ItemType == ItemType then
                return;
            end;
        end;
    end;

    table.insert(v35, p33);
end;

local function normalizeFavoriteEntry(p37, p38) -- Line: 142
    if typeof(p38) ~= "table" then
        return nil;
    end;

    local ItemType = p38.ItemType;
    local AssetType = p38.AssetType;

    if ItemType ~= "Asset" and ItemType ~= "Bundle" or AssetType == nil then
        return nil;
    end;

    local v39 = tonumber(p37);
    local v40 = {
        Id = v39 or p37,
        AssetId = v39 or p37,
        ItemType = ItemType,
        FavoritedAt = p38.FavoritedAt or 0,
        Raw = p38
    };

    if ItemType == "Asset" then
        v40.AssetType = AssetType;

        return v40;
    end;

    v40.BundleType = AssetType;

    return v40;
end;

local function rebuildItemsCache() -- Line: 167
    -- upvalues: u1 (copy), Favorites (copy), normalizeFavoriteEntry (copy), getTypeTargets (copy), addItemToCache (copy)
    local v41 = u1.Favorites or {};
    local v42 = {};

    for i, v in Favorites.Subcategories do
        if v.NoSubcategories or (v.Subcategories == nil and true or next(v.Subcategories) == nil) then
            v42[i] = v42[i] or {};
        else
            v42[i] = v42[i] or {};

            for i2, _ in v.Subcategories do
                v42[i][i2] = v42[i][i2] or {};
            end;
        end;
    end;

    for i, v in v41 do
        local v43 = normalizeFavoriteEntry(i, v);

        if v43 then
            local v44 = getTypeTargets(v43.ItemType, v.AssetType);

            if v44 then
                for _, v2 in v44 do
                    addItemToCache(v42, v2.Category, v2.Subcategory, v43, false);
                end;
            end;
        end;
    end;

    u1.ItemsCache = v42;
end;

local function removeItemFromList(p45, p46, p47) -- Line: 199
    for i, v in p45 do
        if tostring(v.AssetId or v.Id) == p46 and v.ItemType == p47 then
            p45[i] = p45[#p45];
            p45[#p45] = nil;

            return;
        end;
    end;
end;

local function removeFavoriteFromItemsCache(p48, p49) -- Line: 210
    -- upvalues: normalizeFavoriteEntry (copy), getTypeTargets (copy), u1 (copy), removeItemFromList (copy)
    local v50 = normalizeFavoriteEntry(p48, p49);

    if not v50 then
        return;
    end;

    local v51 = getTypeTargets(v50.ItemType, p49.AssetType);

    if not v51 then
        return;
    end;

    local ItemsCache = u1.ItemsCache;

    for _, v in v51 do
        local v52;

        if v.Subcategory == nil then
            v52 = ItemsCache[v.Category];
        else
            v52 = ItemsCache[v.Category] and ItemsCache[v.Category][v.Subcategory];
        end;

        if v52 then
            removeItemFromList(v52, p48, v50.ItemType);
        end;
    end;
end;

local function insertFavoriteIntoItemsCache(p53, p54) -- Line: 230
    -- upvalues: normalizeFavoriteEntry (copy), getTypeTargets (copy), addItemToCache (copy), u1 (copy)
    local v55 = normalizeFavoriteEntry(p53, p54);

    if not v55 then
        return;
    end;

    local v56 = getTypeTargets(v55.ItemType, p54.AssetType);

    if not v56 then
        return;
    end;

    for _, v in v56 do
        addItemToCache(u1.ItemsCache, v.Category, v.Subcategory, v55, true);
    end;
end;

local function applyFavoritesDelta(p57) -- Line: 244
    -- upvalues: u1 (copy), removeFavoriteFromItemsCache (copy), insertFavoriteIntoItemsCache (copy)
    for i, v in p57 do
        local v58 = u1.Favorites[i];

        if v58 ~= nil then
            removeFavoriteFromItemsCache(i, v58);
        end;

        if v == false then
            u1.Favorites[i] = nil;
        else
            u1.Favorites[i] = v;
            insertFavoriteIntoItemsCache(i, v);
        end;
    end;
end;

local function refreshItemDetailsForList(p59) -- Line: 260
    -- upvalues: u1 (copy), Cache (copy), AvatarEditorService (copy), debugPrint (copy)
    local v60 = {};
    local v61 = {};
    local u62 = false;

    for _, v in p59 do
        local v63 = tostring(v.AssetId or v.Id);

        if not u1.DetailsCache[v63] then
            local v64 = Cache.Get("ItemDetails", v63);

            if v64 then
                u1.DetailsCache[v63] = v64;
            elseif v.ItemType == "Asset" then
                v61[v63] = true;
            elseif v.ItemType == "Bundle" then
                v60[v63] = true;
            end;
        end;
    end;

    local v65 = {};

    for i in v61 do
        v65[#v65 + 1] = tonumber(i) or i;
    end;

    local v66 = {};

    for i in v60 do
        v66[#v66 + 1] = tonumber(i) or i;
    end;

    local function processBatch(p67, u68) -- Line: 295
        -- upvalues: u62 (ref), AvatarEditorService (ref), u1 (ref), Cache (ref)
        local v69 = 1;

        while v69 <= #p67 do
            local u70 = {};

            for i = v69, math.min(v69 + 100 - 1, #p67) do
                table.insert(u70, p67[i]);
            end;

            if #u70 > 0 then
                u62 = true;
                local success, result = pcall(function() -- Line: 305
                    -- upvalues: AvatarEditorService (ref), u70 (copy), u68 (copy)
                    return AvatarEditorService:GetBatchItemDetails(u70, u68);
                end);

                if success and type(result) == "table" then
                    for _, v in result do
                        if v and v.Id ~= nil then
                            local v71 = tostring(v.Id);
                            u1.DetailsCache[v71] = v;
                            Cache.Set("ItemDetails", v71, v, 3600);
                        end;
                    end;
                else
                    warn("[FavoriteController] GetBatchItemDetails failed for", tostring(u68), result);
                end;
            end;

            v69 = v69 + 100;
        end;
    end;

    if #v65 > 0 then
        processBatch(v65, Enum.AvatarItemType.Asset);
    end;

    if #v66 > 0 then
        processBatch(v66, Enum.AvatarItemType.Bundle);
    end;

    if not u62 and (#v65 > 0 or #v66 > 0) then
        debugPrint("All item details retrieved from cache. No API calls made.");
    end;
end;

local function attachDetailsToItems(p72) -- Line: 339
    -- upvalues: u1 (copy)
    if type(p72) ~= "table" then
        return;
    end;

    local DetailsCache = u1.DetailsCache;

    for _, v in p72 do
        local v73 = DetailsCache[tostring(v.AssetId or v.Id)];

        if v73 then
            if v.Name == nil then
                v.Name = v73.Name;
            end;

            for i, v2 in v73 do
                if v[i] == nil then
                    v[i] = v2;
                end;
            end;
        end;
    end;
end;

local u74 = 0;

local function startBackgroundDetailsFill(u75, u76) -- Line: 369
    -- upvalues: u74 (ref), refreshItemDetailsForList (copy), attachDetailsToItems (copy)
    u74 = u74 + 1;

    if #u75 < u76 then
        return;
    end;

    local u77 = u74;
    task.spawn(function() -- Line: 374
        -- upvalues: u76 (copy), u75 (copy), u77 (copy), u74 (ref), refreshItemDetailsForList (ref), attachDetailsToItems (ref)
        local v78 = u76;

        while v78 <= #u75 do
            if u77 ~= u74 then
                return;
            end;

            local v79 = table.move(u75, v78, math.min(v78 + 100 - 1, #u75), 1, {});
            refreshItemDetailsForList(v79);
            attachDetailsToItems(v79);
            v78 = v78 + 100;
            task.wait(0.1);
        end;
    end);
end;

function u1.SetFavorited(p80, p81) -- Line: 387
    -- upvalues: Remotes (copy)
    local v82, v83 = Remotes.SetFavorited:InvokeServer(p80.AssetId or p80.Id, p80.ItemType, p80.AssetType or p80.BundleType, p81);

    if v82 == false then
        warn("error while setfavorited:", v83);
    end;

    return v82;
end;

function u1.SetOutfitFavorited(p84, p85, p86) -- Line: 402
    -- upvalues: Remotes (copy), Events (copy)
    local v87 = nil;
    local v88 = nil;

    if p84 == "SavedOutfit" then
        v87, v88 = Remotes.SavedOutfitAction:InvokeServer({
            Action = "Favorite",
            Id = p85,
            IsFavorited = p86
        });
    elseif p84 == "CommunityOutfit" then
        v87, v88 = Remotes.CommunityOutfitsAction:InvokeServer("SetFavorited", p85, p86);
    end;

    if not v87 then
        warn("error while set favorited:", v88);

        if v88 and (typeof(v88) == "string" and v88 == "cooldown") then
            Events.Notify:Fire("⚠️ You are going too fast. Please slow down.");
        end;
    end;

    return v87;
end;

function u1.AreCommunityOutfitsFavorited(p89) -- Line: 426
    -- upvalues: Remotes (copy)
    local v90, v91 = Remotes.CommunityOutfitsAction:InvokeServer("AreOutfitsFavorited", p89);

    if not v90 then
        warn("error while AreCommunityOutfitsFavorited:", v91);
    end;

    return v90, v91;
end;

function u1.IsOutfitFavorited(p92, p93) -- Line: 434
    -- upvalues: Remotes (copy)
    local v94 = nil;
    local v95 = nil;

    if p92 == "SavedOutfit" then
        v94, v95 = Remotes.SavedOutfitAction:InvokeServer({
            Action = "IsFavorited",
            Id = p93
        });
    elseif p92 == "CommunityOutfit" then
        v95 = Remotes.CommunityOutfitsAction:InvokeServer("IsFavorited", p93);
        v94 = true;
    end;

    if not v94 then
        warn("error while is saved outfit favorited:", v95);
    end;

    return v95 == true;
end;

function u1.IsFavorited(p96) -- Line: 453
    -- upvalues: u1 (copy)
    if u1.Loaded ~= true then
        u1.UpdateFavorites();
    end;

    local u97 = u1.Favorites or {};

    local function isIdFavorited(p98) -- Line: 460
        -- upvalues: u97 (copy)
        if u97[p98] ~= nil then
            return true;
        end;

        if u97[tostring(p98)] ~= nil then
            return true;
        end;

        local v99 = tonumber(p98);

        return v99 and u97[v99] ~= nil and true or false;
    end;

    if typeof(p96) == "table" then
        local v100 = {};

        for _, v in p96 do
            local v101;

            if u97[v] == nil and u97[tostring(v)] == nil then
                local v102 = tonumber(v);
                v101 = v102 and u97[v102] ~= nil and true or false;
            else
                v101 = true;
            end;

            if v101 then
                v100[v] = true;
            end;
        end;

        return v100;
    end;

    if u97[p96] ~= nil then
        return true;
    end;

    if u97[tostring(p96)] ~= nil then
        return true;
    end;

    local v103 = tonumber(p96);

    return v103 and u97[v103] ~= nil and true or false;
end;

function u1.GetFavorites() -- Line: 489
    -- upvalues: u1 (copy)
    if u1.Loaded == false then
        u1.UpdateFavorites();
    end;

    return u1.Favorites ~= nil, u1.Favorites;
end;

function u1.GetFavoritesPaged(p104, p105, p106) -- Line: 497
    -- upvalues: u1 (copy), Favorites (copy), refreshItemDetailsForList (copy), attachDetailsToItems (copy), u74 (ref)
    if u1.Loaded ~= true then
        u1.UpdateFavorites();
    end;

    local v107 = u1.ItemsCache or {};
    local v108 = p104 or "All";
    local v109 = Favorites.Subcategories[v108];
    local u110;

    if v109 then
        if v109.NoSubcategories or (v109.Subcategories == nil and true or next(v109.Subcategories) == nil) then
            u110 = table.clone(v107[v108] or {});
        elseif p105 then
            u110 = table.clone(v107[v108] and v107[v108][p105] or {});
        else
            local v111 = {};
            u110 = {};

            for _, v in v107[v108] or {} do
                for _, v2 in v do
                    local v112 = v2.AssetId or v2.Id;
                    local v113 = tostring(v2.ItemType) .. ":" .. tostring(v112);

                    if not v111[v113] then
                        v111[v113] = true;
                        table.insert(u110, v2);
                    end;
                end;
            end;
        end;
    else
        u110 = {};
    end;

    table.sort(u110, function(p114, p115) -- Line: 540
        local v116 = p114.FavoritedAt or 0;
        local v117 = p115.FavoritedAt or 0;

        if v116 == v117 then
            return (p114.AssetId or (p114.Id or 0)) > (p115.AssetId or (p115.Id or 0));
        end;

        return v117 < v116;
    end);

    if typeof(p106) == "string" and p106 ~= "" then
        refreshItemDetailsForList(u110);
        attachDetailsToItems(u110);
        local v118 = string.lower(p106);
        local filtered = {};

        for _, v in u110 do
            local v119 = tostring(v.Name or "");

            if v119 ~= "" and string.find(string.lower(v119), v118, 1, true) then
                table.insert(filtered, v);
            end;
        end;

        u110 = filtered;
    else
        local v120 = table.move(u110, 1, math.min(100, #u110), 1, {});
        refreshItemDetailsForList(v120);
        attachDetailsToItems(v120);
        u74 = u74 + 1;

        if #u110 >= 101 then
            local u121 = u74;
            local u122 = 101;
            task.spawn(function() -- Line: 374
                -- upvalues: u122 (copy), u110 (copy), u121 (copy), u74 (ref), refreshItemDetailsForList (ref), attachDetailsToItems (ref)
                local v123 = u122;

                while v123 <= #u110 do
                    if u121 ~= u74 then
                        return;
                    end;

                    local v124 = table.move(u110, v123, math.min(v123 + 100 - 1, #u110), 1, {});
                    refreshItemDetailsForList(v124);
                    attachDetailsToItems(v124);
                    v123 = v123 + 100;
                    task.wait(0.1);
                end;
            end);
        end;
    end;

    return {
        CurrentIndex = 0,
        Items = u110,
        IsFinished = #u110 == 0,

        GetCurrentPage = function(p125) -- Line: 580, Name: GetCurrentPage
            -- upvalues: attachDetailsToItems (ref)
            local v126 = {};

            if p125.IsFinished then
                return v126;
            end;

            for i = 1, 60 do
                local v127 = p125.Items[p125.CurrentIndex + i];

                if not v127 then
                    p125.IsFinished = true;
                    break;
                end;

                v126[i] = v127;
            end;

            attachDetailsToItems(v126);

            return v126;
        end,

        AdvanceToNextPageAsync = function(p128) -- Line: 602, Name: AdvanceToNextPageAsync
            -- upvalues: refreshItemDetailsForList (ref), attachDetailsToItems (ref)
            if p128.IsFinished then
                error("No more pages to advance to");
            end;

            p128.CurrentIndex = p128.CurrentIndex + 60;

            if p128.CurrentIndex >= #p128.Items then
                p128.IsFinished = true;

                return;
            end;

            local v129 = table.move(p128.Items, p128.CurrentIndex + 1, math.min(p128.CurrentIndex + 60, #p128.Items), 1, {});
            refreshItemDetailsForList(v129);
            attachDetailsToItems(v129);
        end
    };
end;

function u1.AddImportButton(p130) -- Line: 623
    -- upvalues: u1 (copy), import (copy), Events (copy), Remotes (copy), debugPrint (copy)
    if not p130 then
        return warn("no parent container");
    end;

    if u1.CurrentImportButton ~= nil then
        return;
    end;

    local v131 = import:Clone();
    u1.CurrentImportButton = v131;
    v131.Activated:Connect(function() -- Line: 629
        -- upvalues: Events (ref), Remotes (ref), u1 (ref), debugPrint (ref)
        Events.Notify:Fire("Importing your Roblox favorites...");
        Events.Notify:Fire("Please wait. This can take some time.");
        local v132, v133 = Remotes.GetRobloxFavorites:InvokeServer();

        if v132 then
            Events.Notify:Fire("✅ Your Roblox favorites have been imported!");
            u1.RefreshCatalogOnUpdate = true;

            return;
        end;

        local v134 = {
            alreadyImported = "✅ You\'ve already imported your Roblox favorites. Find them under \'My Favorites\'!",
            currentlyImporting = "✅ Your Roblox favorites are currently being imported. Please wait a moment."
        };

        if v134[v133] then
            Events.Notify:Fire(v134[v133]);
            debugPrint("import error:", v134[v133]);
        end;
    end);
    v131.Parent = p130.right;
end;

function u1.RemoveImportButton() -- Line: 653
    -- upvalues: u1 (copy)
    local CurrentImportButton = u1.CurrentImportButton;

    if CurrentImportButton and CurrentImportButton.Parent ~= nil then
        CurrentImportButton:Destroy();
        u1.CurrentImportButton = nil;
    end;
end;

function u1.AddImportBanner(p135, u136) -- Line: 661
    -- upvalues: u1 (copy), favoritesImportBanner (copy), Events (copy), Remotes (copy), debugPrint (copy)
    if not p135 then
        return warn("no parent container while addimportbanner");
    end;

    if u1.CurrentImportBanner then
        return;
    end;

    if u1.ClosedRobloxImportBanner then
        return;
    end;

    local u137 = favoritesImportBanner:Clone();
    u1.CurrentImportBanner = u137;
    local import2 = u137.container:FindFirstChild("import");
    u137:FindFirstChild("close").Activated:Connect(function() -- Line: 675
        -- upvalues: u137 (copy), u1 (ref), u136 (copy)
        if u137.Parent then
            u137:Destroy();
        end;

        u1.ClosedRobloxImportBanner = true;
        u1.CurrentImportBanner = nil;

        if u136 then
            u1.AddImportButton(u136);
        end;
    end);
    import2.Activated:Connect(function() -- Line: 686
        -- upvalues: Events (ref), Remotes (ref), u137 (copy), u1 (ref), debugPrint (ref)
        Events.Notify:Fire("Importing your Roblox favorites...");
        Events.Notify:Fire("Please wait. This can take some time.");
        local v138, v139 = Remotes.GetRobloxFavorites:InvokeServer();

        if not v138 then
            local v140 = {
                alreadyImported = "✅ You\'ve already imported your Roblox favorites. Find them under \'My Favorites\'!",
                currentlyImporting = "✅ Your Roblox favorites are currently being imported. Please wait a moment."
            };

            if v140[v139] then
                Events.Notify:Fire(v140[v139]);
                debugPrint("import error:", v140[v139]);
            end;

            return;
        end;

        Events.Notify:Fire("✅ Your Roblox favorites have been imported!");

        if u137.Parent then
            u137:Destroy();
        end;

        u1.ClosedRobloxImportBanner = true;
        u1.CurrentImportBanner = nil;
        u1.RefreshCatalogOnUpdate = true;
    end);
    u137.Parent = p135;
end;

function u1.RemoveImportBanner() -- Line: 716
    -- upvalues: u1 (copy)
    local CurrentImportBanner = u1.CurrentImportBanner;

    if CurrentImportBanner and CurrentImportBanner.Parent ~= nil then
        CurrentImportBanner:Destroy();
    end;
end;

function u1.UpdateFavorites(p141, p142) -- Line: 723
    -- upvalues: u1 (copy), applyFavoritesDelta (copy), Remotes (copy), rebuildItemsCache (copy), Events (copy)
    if p142 then
        if u1.Loaded ~= true then
            return u1.UpdateFavorites();
        end;

        applyFavoritesDelta(p141);
    else
        if p141 == nil then
            local v143;
            v143, p141 = Remotes.GetFavorites:InvokeServer();

            if not v143 then
                warn("failed to fetch favorites:", p141);

                return;
            end;
        end;

        u1.Favorites = p141 or {};
        rebuildItemsCache();
    end;

    u1.Loaded = true;

    if u1.RefreshCatalogOnUpdate then
        u1.RefreshCatalogOnUpdate = false;
        Events.RefreshCatalog:Fire("FavoritesUpdated");
    end;

    for _, v in u1.FavoritesUpdatedListeners do
        task.spawn(pcall, v, u1.Favorites);
    end;
end;

function u1.AddFavoritesUpdatedListener(p144) -- Line: 762
    -- upvalues: u1 (copy)
    table.insert(u1.FavoritesUpdatedListeners, p144);
end;

Remotes.FavoritesUpdated.OnClientEvent:Connect(u1.UpdateFavorites);

return u1;