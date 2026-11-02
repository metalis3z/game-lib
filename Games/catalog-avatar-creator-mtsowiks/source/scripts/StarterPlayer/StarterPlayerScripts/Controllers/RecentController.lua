-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local TrackRecentItem = Remotes:WaitForChild("TrackRecentItem");
local GetRecentItems = Remotes:WaitForChild("GetRecentItems");
local u1 = {
    Loaded = false,
    ItemsCache = {}
};
local u2 = {};

local function deduplicateAndInsert(p3, p4) -- Line: 16
    for i = #p3, 1, -1 do
        local v5 = p3[i];

        if v5.Id == p4.Id and v5.ItemType == p4.ItemType then
            table.remove(p3, i);
            break;
        end;
    end;

    table.insert(p3, 1, p4);

    while #p3 > 200 do
        table.remove(p3, #p3);
    end;
end;

local function buildDisplayItem(p6) -- Line: 32
    local Id = p6.Id;
    local v7 = p6.ItemType or "Asset";
    local AssetType = p6.AssetType;
    local v8 = p6.Name or (AssetType or v7);
    local v9 = p6.CreatorDisplay or "someone";
    local Price = p6.Price;
    local v10 = "rbxthumb://type=" .. (v7 == "Bundle" and "BundleThumbnail" or "Asset") .. "&id=" .. tostring(Id) .. "&w=420&h=420";
    local v11 = {
        IsRecentItem = true,
        Id = Id,
        Name = v8,
        ItemType = v7,
        AssetType = AssetType
    };

    if v7 ~= "Bundle" then
        AssetType = nil;
    end;

    v11.BundleType = AssetType;
    v11.Thumbnail = v10;
    v11.CreatorName = v9;
    v11.CreatorDisplay = v9;
    v11.Price = Price;

    return v11;
end;

local function ensureLoaded() -- Line: 57
    -- upvalues: u1 (copy), GetRecentItems (copy), u2 (copy), deduplicateAndInsert (copy)
    if u1.Loaded then
        return;
    end;

    local success, result = pcall(function() -- Line: 60
        -- upvalues: GetRecentItems (ref)
        return GetRecentItems:InvokeServer();
    end);

    if success and typeof(result) == "table" then
        u1.ItemsCache = result;
    else
        u1.ItemsCache = {};
        warn("[RecentController] Failed to fetch recent items:", result);
    end;

    u1.Loaded = true;

    if #u2 > 0 then
        for _, v in u2 do
            deduplicateAndInsert(u1.ItemsCache, v);
        end;

        table.clear(u2);
    end;
end;

function u1.TrackItem(p12) -- Line: 82
    -- upvalues: TrackRecentItem (copy), u1 (copy), deduplicateAndInsert (copy), u2 (copy)
    if not (p12 and (p12.Id and p12.ItemType)) then
        return;
    end;

    local u13 = {
        Id = p12.Id,
        ItemType = p12.ItemType,
        AssetType = p12.AssetType,
        Name = p12.Name,
        Price = p12.Price,
        CreatorDisplay = p12.CreatorDisplay,
        Timestamp = os.time()
    };
    pcall(function() -- Line: 96
        -- upvalues: TrackRecentItem (ref), u13 (copy)
        TrackRecentItem:FireServer(u13);
    end);

    if u1.Loaded then
        deduplicateAndInsert(u1.ItemsCache, u13);

        return;
    end;

    deduplicateAndInsert(u2, u13);
end;

function u1.GetRecentItemsPaged(p14) -- Line: 108
    -- upvalues: ensureLoaded (copy), u1 (copy), buildDisplayItem (copy)
    ensureLoaded();
    local v15 = {};

    for _, v in u1.ItemsCache do
        local v16 = buildDisplayItem(v);
        table.insert(v15, v16);
    end;

    if typeof(p14) == "string" and p14 ~= "" then
        local v17 = string.lower(p14);
        local filtered = {};

        for _, v in v15 do
            local v18 = tostring(v.Name or "");

            if v18 ~= "" and string.find(string.lower(v18), v17, 1, true) then
                table.insert(filtered, v);
            end;
        end;

        v15 = filtered;
    end;

    return {
        CurrentIndex = 0,
        Items = v15,
        IsFinished = #v15 == 0,

        GetCurrentPage = function(p19) -- Line: 139, Name: GetCurrentPage
            local v20 = {};

            if p19.IsFinished then
                return v20;
            end;

            for i = 1, 60 do
                local v21 = p19.Items[p19.CurrentIndex + i];

                if not v21 then
                    p19.IsFinished = true;

                    return v20;
                end;

                v20[i] = v21;
            end;

            return v20;
        end,

        AdvanceToNextPageAsync = function(p22) -- Line: 158, Name: AdvanceToNextPageAsync
            if p22.IsFinished then
                error("No more pages to advance to");
            end;

            p22.CurrentIndex = p22.CurrentIndex + 60;

            if p22.CurrentIndex >= #p22.Items then
                p22.IsFinished = true;
            end;
        end
    };
end;

return u1;