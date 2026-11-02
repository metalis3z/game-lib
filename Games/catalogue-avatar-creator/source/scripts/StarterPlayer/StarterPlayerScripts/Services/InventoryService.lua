-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local AvatarEditorService = game:GetService("AvatarEditorService");
local HttpService = game:GetService("HttpService");
local Modules = require(script.Parent.Parent.Modules);
local SortingSchema = require(Modules.Shared.SortingSchema);
require(Modules.Services.Cache);
local Events = script.Parent.Parent.Events;
local u1 = {
    ItemsCache = {},
    HasAccess = false,
    ItemsLoaded = false
};
local BindableEvent = Instance.new("BindableEvent");
BindableEvent.Parent = script;
u1.FinishedLoading = BindableEvent;
local u2 = {};
local u3 = false;
local u4 = false;
local u5 = {};

local function dprint(...) -- Line: 27
end;

local function addToAllCache(p6) -- Line: 33
    -- upvalues: u5 (ref), u1 (copy)
    if not p6 then
        return;
    end;

    local v7 = p6.AssetId or p6.Id;

    if not v7 then
        return;
    end;

    if u5[v7] then
        return;
    end;

    u5[v7] = true;
    u1.ItemsCache.All = u1.ItemsCache.All or {};
    table.insert(u1.ItemsCache.All, p6);
end;

local function ensureAccess() -- Line: 47
    -- upvalues: u1 (copy), u4 (ref), u3 (ref), dprint (copy), AvatarEditorService (copy), Events (copy), u5 (ref), SortingSchema (copy), HttpService (copy), u2 (copy), addToAllCache (copy)
    if u1.HasAccess and (u1.ItemsLoaded == true and u4 ~= true) then
        return true;
    end;

    if u3 then
        u1.FinishedLoading.Event:Wait();

        return u1.HasAccess;
    end;

    u3 = true;
    task.spawn(function() -- Line: 63
        -- upvalues: dprint (ref), AvatarEditorService (ref), u3 (ref), Events (ref), u1 (ref), u4 (ref), u5 (ref), SortingSchema (ref), HttpService (ref), u2 (ref), addToAllCache (ref)
        dprint("prompt");
        local u8 = nil;
        AvatarEditorService.PromptAllowInventoryReadAccessCompleted:Once(function(p9) -- Line: 66
            -- upvalues: u8 (ref)
            u8 = p9;
        end);
        AvatarEditorService:PromptAllowInventoryReadAccess();

        repeat
            task.wait();
        until u8 ~= nil;

        if u8 ~= Enum.AvatarPromptResult.Success then
            u3 = false;

            if u8.Name == "Failed" then
                Events.Notify:Fire("❌ Something went wrong. Please try again.");
            else
                Events.Notify:Fire("❌ You must allow inventory access to use this feature.");
            end;

            u1.FinishedLoading:Fire();

            return;
        end;

        u4 = true;
        u1.HasAccess = true;
        dprint("Loading inventory...");
        Events.Notify:Fire("Loading your inventory...");
        u1.ItemsCache = {};
        u5 = {};
        local Subcategories = SortingSchema.Inventory.Subcategories;
        local u10 = { {} };

        local function loadInventoryPages(u11, u12, u13) -- Line: 100
            -- upvalues: HttpService (ref), u2 (ref), dprint (ref), u1 (ref), AvatarEditorService (ref), Events (ref), u10 (copy), addToAllCache (ref), Subcategories (copy)
            task.spawn(function() -- Line: 101
                -- upvalues: HttpService (ref), u2 (ref), dprint (ref), u11 (copy), u12 (copy), u1 (ref), AvatarEditorService (ref), u13 (copy), Events (ref), u10 (ref), addToAllCache (ref), Subcategories (ref)
                local v14 = HttpService:GenerateGUID(false);
                table.insert(u2, v14);
                dprint("Begin loading process", v14, "category:", tostring(u11), "subcategory:", (tostring(u12)));
                u1.ItemsCache[u11] = u1.ItemsCache[u11] or {};

                if u12 then
                    u1.ItemsCache[u11][u12] = u1.ItemsCache[u11][u12] or {};
                end;

                local v15;

                if u12 == nil then
                    v15 = u1.ItemsCache[u11];
                else
                    v15 = u1.ItemsCache[u11][u12];
                end;

                local v16 = 0;
                local u17 = nil;

                repeat
                    if true then
                        local success, result = pcall(function() -- Line: 119
                            -- upvalues: AvatarEditorService (ref), u13 (ref)
                            return AvatarEditorService:GetInventory(u13);
                        end);

                        if success then
                            u17 = result;
                        else
                            if typeof(result) == "string" and string.find(result, "Permission must be obtained", 1, true) then
                                warn("[InventoryService] GetInventory denied by engine despite Success prompt result; bailing process", v14);
                                u1.HasAccess = false;
                                Events.Notify:Fire("❌ Inventory access not granted. Please re-allow.");
                                local v18 = table.find(u2, v14);

                                if v18 then
                                    table.remove(u2, v18);
                                end;

                                if #u2 == 0 then
                                    u1.FinishedLoading:Fire();
                                end;

                                return;
                            end;

                            v16 = v16 + 1;

                            if v16 >= 5 then
                                warn("[InventoryService] GetInventory failed permanently for", tostring(u11), tostring(u12), "- giving up:", result);
                                local v19 = table.find(u2, v14);

                                if v19 then
                                    table.remove(u2, v19);
                                end;

                                if #u2 == 0 then
                                    u1.FinishedLoading:Fire();
                                end;

                                return;
                            end;

                            task.wait(1);
                            warn("[InventoryService] GetInventory failed, retrying...", result);
                        end;
                    end;
                until u17 ~= nil;

                while true do
                    local success, result = pcall(function() -- Line: 156
                        -- upvalues: u17 (ref)
                        return u17:GetCurrentPage();
                    end);

                    if success then
                        for _, v in result do
                            local v20 = u10[#u10];

                            if #v20 >= 100 then
                                v20 = {};
                                table.insert(u10, v20);
                            end;

                            local v21 = false;

                            for _, v2 in u10 do
                                if table.find(v2, v.AssetId) then
                                    v21 = true;
                                    break;
                                end;
                            end;

                            if not v21 then
                                table.insert(v20, v.AssetId);
                            end;
                        end;

                        for _, v in result do
                            addToAllCache(v);
                        end;

                        if u12 == "All" then
                            local v22 = Subcategories[u11];

                            if v22 and v22.Subcategories then
                                for i, v in v22.Subcategories do
                                    if typeof(v) == "table" and v.AssetTypes then
                                        local AssetTypes = v.AssetTypes;

                                        for _, v2 in result do
                                            local AssetType = v2.AssetType;

                                            for _, v3 in AssetTypes do
                                                if AssetType == v3.Name or AssetType == v3 then
                                                    u1.ItemsCache[u11][i] = u1.ItemsCache[u11][i] or {};
                                                    table.insert(u1.ItemsCache[u11][i], v2);
                                                    break;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        else
                            for _, v in result do
                                table.insert(v15, v);
                            end;
                        end;

                        if u17.IsFinished == true then
                            break;
                        end;

                        local success2, result2 = pcall(function() -- Line: 227
                            -- upvalues: u17 (ref)
                            u17:AdvanceToNextPageAsync();
                        end);

                        if not success2 then
                            task.wait(1);
                            warn("[InventoryService] AdvanceToNextPageAsync failed, retrying...", result2);
                        end;
                    else
                        task.wait(1);
                        warn("[InventoryService] GetCurrentPage failed, retrying...", result);
                    end;

                    if u17.IsFinished == true then
                        break;
                    end;
                end;

                local v23 = table.find(u2, v14);

                if v23 then
                    table.remove(u2, v23);
                end;

                dprint("Process finished. Remaining:", #u2);

                if #u2 == 0 then
                    u1.FinishedLoading:Fire();
                end;
            end);
        end;

        for i, v in Subcategories do
            if i ~= "All" then
                if v.NoSubcategories == true then
                    local AssetTypes = v.AssetTypes;
                    local u24 = nil;
                    task.spawn(function() -- Line: 101
                        -- upvalues: HttpService (ref), u2 (ref), dprint (ref), i (copy), u24 (copy), u1 (ref), AvatarEditorService (ref), AssetTypes (copy), Events (ref), u10 (copy), addToAllCache (ref), Subcategories (copy)
                        local v25 = HttpService:GenerateGUID(false);
                        table.insert(u2, v25);
                        dprint("Begin loading process", v25, "category:", tostring(i), "subcategory:", (tostring(u24)));
                        u1.ItemsCache[i] = u1.ItemsCache[i] or {};

                        if u24 then
                            u1.ItemsCache[i][u24] = u1.ItemsCache[i][u24] or {};
                        end;

                        local v26;

                        if u24 == nil then
                            v26 = u1.ItemsCache[i];
                        else
                            v26 = u1.ItemsCache[i][u24];
                        end;

                        local v27 = 0;
                        local u28 = nil;

                        repeat
                            if true then
                                local success, result = pcall(function() -- Line: 119
                                    -- upvalues: AvatarEditorService (ref), AssetTypes (ref)
                                    return AvatarEditorService:GetInventory(AssetTypes);
                                end);

                                if success then
                                    u28 = result;
                                else
                                    if typeof(result) == "string" and string.find(result, "Permission must be obtained", 1, true) then
                                        warn("[InventoryService] GetInventory denied by engine despite Success prompt result; bailing process", v25);
                                        u1.HasAccess = false;
                                        Events.Notify:Fire("❌ Inventory access not granted. Please re-allow.");
                                        local v29 = table.find(u2, v25);

                                        if v29 then
                                            table.remove(u2, v29);
                                        end;

                                        if #u2 == 0 then
                                            u1.FinishedLoading:Fire();
                                        end;

                                        return;
                                    end;

                                    v27 = v27 + 1;

                                    if v27 >= 5 then
                                        warn("[InventoryService] GetInventory failed permanently for", tostring(i), tostring(u24), "- giving up:", result);
                                        local v30 = table.find(u2, v25);

                                        if v30 then
                                            table.remove(u2, v30);
                                        end;

                                        if #u2 == 0 then
                                            u1.FinishedLoading:Fire();
                                        end;

                                        return;
                                    end;

                                    task.wait(1);
                                    warn("[InventoryService] GetInventory failed, retrying...", result);
                                end;
                            end;
                        until u28 ~= nil;

                        while true do
                            local success, result = pcall(function() -- Line: 156
                                -- upvalues: u28 (ref)
                                return u28:GetCurrentPage();
                            end);

                            if success then
                                for _, v2 in result do
                                    local v31 = u10[#u10];

                                    if #v31 >= 100 then
                                        v31 = {};
                                        table.insert(u10, v31);
                                    end;

                                    local v32 = false;

                                    for _, v3 in u10 do
                                        if table.find(v3, v2.AssetId) then
                                            v32 = true;
                                            break;
                                        end;
                                    end;

                                    if not v32 then
                                        table.insert(v31, v2.AssetId);
                                    end;
                                end;

                                for _, v2 in result do
                                    addToAllCache(v2);
                                end;

                                if u24 == "All" then
                                    local v33 = Subcategories[i];

                                    if v33 and v33.Subcategories then
                                        for i2, v2 in v33.Subcategories do
                                            if typeof(v2) == "table" and v2.AssetTypes then
                                                local AssetTypes2 = v2.AssetTypes;

                                                for _, v3 in result do
                                                    local AssetType = v3.AssetType;

                                                    for _, v4 in AssetTypes2 do
                                                        if AssetType == v4.Name or AssetType == v4 then
                                                            u1.ItemsCache[i][i2] = u1.ItemsCache[i][i2] or {};
                                                            table.insert(u1.ItemsCache[i][i2], v3);
                                                            break;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                else
                                    for _, v2 in result do
                                        table.insert(v26, v2);
                                    end;
                                end;

                                if u28.IsFinished == true then
                                    break;
                                end;

                                local success2, result2 = pcall(function() -- Line: 227
                                    -- upvalues: u28 (ref)
                                    u28:AdvanceToNextPageAsync();
                                end);

                                if not success2 then
                                    task.wait(1);
                                    warn("[InventoryService] AdvanceToNextPageAsync failed, retrying...", result2);
                                end;
                            else
                                task.wait(1);
                                warn("[InventoryService] GetCurrentPage failed, retrying...", result);
                            end;

                            if u28.IsFinished == true then
                                break;
                            end;
                        end;

                        local v34 = table.find(u2, v25);

                        if v34 then
                            table.remove(u2, v34);
                        end;

                        dprint("Process finished. Remaining:", #u2);

                        if #u2 == 0 then
                            u1.FinishedLoading:Fire();
                        end;
                    end);
                else
                    local Subcategories2 = v.Subcategories;

                    if Subcategories2.All == nil then
                        for i2, v2 in Subcategories2 do
                            local AssetTypes = v2.AssetTypes;
                            task.spawn(function() -- Line: 101
                                -- upvalues: HttpService (ref), u2 (ref), dprint (ref), i (copy), i2 (copy), u1 (ref), AvatarEditorService (ref), AssetTypes (copy), Events (ref), u10 (copy), addToAllCache (ref), Subcategories (copy)
                                local v35 = HttpService:GenerateGUID(false);
                                table.insert(u2, v35);
                                dprint("Begin loading process", v35, "category:", tostring(i), "subcategory:", (tostring(i2)));
                                u1.ItemsCache[i] = u1.ItemsCache[i] or {};

                                if i2 then
                                    u1.ItemsCache[i][i2] = u1.ItemsCache[i][i2] or {};
                                end;

                                local v36;

                                if i2 == nil then
                                    v36 = u1.ItemsCache[i];
                                else
                                    v36 = u1.ItemsCache[i][i2];
                                end;

                                local v37 = 0;
                                local u38 = nil;

                                repeat
                                    if true then
                                        local success, result = pcall(function() -- Line: 119
                                            -- upvalues: AvatarEditorService (ref), AssetTypes (ref)
                                            return AvatarEditorService:GetInventory(AssetTypes);
                                        end);

                                        if success then
                                            u38 = result;
                                        else
                                            if typeof(result) == "string" and string.find(result, "Permission must be obtained", 1, true) then
                                                warn("[InventoryService] GetInventory denied by engine despite Success prompt result; bailing process", v35);
                                                u1.HasAccess = false;
                                                Events.Notify:Fire("❌ Inventory access not granted. Please re-allow.");
                                                local v39 = table.find(u2, v35);

                                                if v39 then
                                                    table.remove(u2, v39);
                                                end;

                                                if #u2 == 0 then
                                                    u1.FinishedLoading:Fire();
                                                end;

                                                return;
                                            end;

                                            v37 = v37 + 1;

                                            if v37 >= 5 then
                                                warn("[InventoryService] GetInventory failed permanently for", tostring(i), tostring(i2), "- giving up:", result);
                                                local v40 = table.find(u2, v35);

                                                if v40 then
                                                    table.remove(u2, v40);
                                                end;

                                                if #u2 == 0 then
                                                    u1.FinishedLoading:Fire();
                                                end;

                                                return;
                                            end;

                                            task.wait(1);
                                            warn("[InventoryService] GetInventory failed, retrying...", result);
                                        end;
                                    end;
                                until u38 ~= nil;

                                while true do
                                    local success, result = pcall(function() -- Line: 156
                                        -- upvalues: u38 (ref)
                                        return u38:GetCurrentPage();
                                    end);

                                    if success then
                                        for _, v3 in result do
                                            local v41 = u10[#u10];

                                            if #v41 >= 100 then
                                                v41 = {};
                                                table.insert(u10, v41);
                                            end;

                                            local v42 = false;

                                            for _, v4 in u10 do
                                                if table.find(v4, v3.AssetId) then
                                                    v42 = true;
                                                    break;
                                                end;
                                            end;

                                            if not v42 then
                                                table.insert(v41, v3.AssetId);
                                            end;
                                        end;

                                        for _, v3 in result do
                                            addToAllCache(v3);
                                        end;

                                        if i2 == "All" then
                                            local v43 = Subcategories[i];

                                            if v43 and v43.Subcategories then
                                                for i3, v3 in v43.Subcategories do
                                                    if typeof(v3) == "table" and v3.AssetTypes then
                                                        local AssetTypes2 = v3.AssetTypes;

                                                        for _, v4 in result do
                                                            local AssetType = v4.AssetType;

                                                            for _, v5 in AssetTypes2 do
                                                                if AssetType == v5.Name or AssetType == v5 then
                                                                    u1.ItemsCache[i][i3] = u1.ItemsCache[i][i3] or {};
                                                                    table.insert(u1.ItemsCache[i][i3], v4);
                                                                    break;
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        else
                                            for _, v3 in result do
                                                table.insert(v36, v3);
                                            end;
                                        end;

                                        if u38.IsFinished == true then
                                            break;
                                        end;

                                        local success2, result2 = pcall(function() -- Line: 227
                                            -- upvalues: u38 (ref)
                                            u38:AdvanceToNextPageAsync();
                                        end);

                                        if not success2 then
                                            task.wait(1);
                                            warn("[InventoryService] AdvanceToNextPageAsync failed, retrying...", result2);
                                        end;
                                    else
                                        task.wait(1);
                                        warn("[InventoryService] GetCurrentPage failed, retrying...", result);
                                    end;

                                    if u38.IsFinished == true then
                                        break;
                                    end;
                                end;

                                local v44 = table.find(u2, v35);

                                if v44 then
                                    table.remove(u2, v44);
                                end;

                                dprint("Process finished. Remaining:", #u2);

                                if #u2 == 0 then
                                    u1.FinishedLoading:Fire();
                                end;
                            end);
                        end;
                    else
                        for i2, v2 in Subcategories2 do
                            if i2 == "All" then
                                local AssetTypes = v2.AssetTypes;
                                local u45 = "All";
                                task.spawn(function() -- Line: 101
                                    -- upvalues: HttpService (ref), u2 (ref), dprint (ref), i (copy), u45 (copy), u1 (ref), AvatarEditorService (ref), AssetTypes (copy), Events (ref), u10 (copy), addToAllCache (ref), Subcategories (copy)
                                    local v46 = HttpService:GenerateGUID(false);
                                    table.insert(u2, v46);
                                    dprint("Begin loading process", v46, "category:", tostring(i), "subcategory:", (tostring(u45)));
                                    u1.ItemsCache[i] = u1.ItemsCache[i] or {};

                                    if u45 then
                                        u1.ItemsCache[i][u45] = u1.ItemsCache[i][u45] or {};
                                    end;

                                    local v47;

                                    if u45 == nil then
                                        v47 = u1.ItemsCache[i];
                                    else
                                        v47 = u1.ItemsCache[i][u45];
                                    end;

                                    local v48 = 0;
                                    local u49 = nil;

                                    repeat
                                        if true then
                                            local success, result = pcall(function() -- Line: 119
                                                -- upvalues: AvatarEditorService (ref), AssetTypes (ref)
                                                return AvatarEditorService:GetInventory(AssetTypes);
                                            end);

                                            if success then
                                                u49 = result;
                                            else
                                                if typeof(result) == "string" and string.find(result, "Permission must be obtained", 1, true) then
                                                    warn("[InventoryService] GetInventory denied by engine despite Success prompt result; bailing process", v46);
                                                    u1.HasAccess = false;
                                                    Events.Notify:Fire("❌ Inventory access not granted. Please re-allow.");
                                                    local v50 = table.find(u2, v46);

                                                    if v50 then
                                                        table.remove(u2, v50);
                                                    end;

                                                    if #u2 == 0 then
                                                        u1.FinishedLoading:Fire();
                                                    end;

                                                    return;
                                                end;

                                                v48 = v48 + 1;

                                                if v48 >= 5 then
                                                    warn("[InventoryService] GetInventory failed permanently for", tostring(i), tostring(u45), "- giving up:", result);
                                                    local v51 = table.find(u2, v46);

                                                    if v51 then
                                                        table.remove(u2, v51);
                                                    end;

                                                    if #u2 == 0 then
                                                        u1.FinishedLoading:Fire();
                                                    end;

                                                    return;
                                                end;

                                                task.wait(1);
                                                warn("[InventoryService] GetInventory failed, retrying...", result);
                                            end;
                                        end;
                                    until u49 ~= nil;

                                    while true do
                                        local success, result = pcall(function() -- Line: 156
                                            -- upvalues: u49 (ref)
                                            return u49:GetCurrentPage();
                                        end);

                                        if success then
                                            for _, v3 in result do
                                                local v52 = u10[#u10];

                                                if #v52 >= 100 then
                                                    v52 = {};
                                                    table.insert(u10, v52);
                                                end;

                                                local v53 = false;

                                                for _, v4 in u10 do
                                                    if table.find(v4, v3.AssetId) then
                                                        v53 = true;
                                                        break;
                                                    end;
                                                end;

                                                if not v53 then
                                                    table.insert(v52, v3.AssetId);
                                                end;
                                            end;

                                            for _, v3 in result do
                                                addToAllCache(v3);
                                            end;

                                            if u45 == "All" then
                                                local v54 = Subcategories[i];

                                                if v54 and v54.Subcategories then
                                                    for i3, v3 in v54.Subcategories do
                                                        if typeof(v3) == "table" and v3.AssetTypes then
                                                            local AssetTypes2 = v3.AssetTypes;

                                                            for _, v4 in result do
                                                                local AssetType = v4.AssetType;

                                                                for _, v5 in AssetTypes2 do
                                                                    if AssetType == v5.Name or AssetType == v5 then
                                                                        u1.ItemsCache[i][i3] = u1.ItemsCache[i][i3] or {};
                                                                        table.insert(u1.ItemsCache[i][i3], v4);
                                                                        break;
                                                                    end;
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            else
                                                for _, v3 in result do
                                                    table.insert(v47, v3);
                                                end;
                                            end;

                                            if u49.IsFinished == true then
                                                break;
                                            end;

                                            local success2, result2 = pcall(function() -- Line: 227
                                                -- upvalues: u49 (ref)
                                                u49:AdvanceToNextPageAsync();
                                            end);

                                            if not success2 then
                                                task.wait(1);
                                                warn("[InventoryService] AdvanceToNextPageAsync failed, retrying...", result2);
                                            end;
                                        else
                                            task.wait(1);
                                            warn("[InventoryService] GetCurrentPage failed, retrying...", result);
                                        end;

                                        if u49.IsFinished == true then
                                            break;
                                        end;
                                    end;

                                    local v55 = table.find(u2, v46);

                                    if v55 then
                                        table.remove(u2, v55);
                                    end;

                                    dprint("Process finished. Remaining:", #u2);

                                    if #u2 == 0 then
                                        u1.FinishedLoading:Fire();
                                    end;
                                end);
                            else
                                u1.ItemsCache[i] = u1.ItemsCache[i] or {};
                                u1.ItemsCache[i][i2] = u1.ItemsCache[i][i2] or {};
                            end;
                        end;
                    end;
                end;
            end;
        end;

        u1.FinishedLoading.Event:Wait();
        u4 = false;
        dprint("Inventory loaded successfully; All count =", u1.ItemsCache.All and #u1.ItemsCache.All or 0);
        Events.Notify:Fire("✅ Your inventory has finished loading!");
        Events.Notify:Fire("Item count: " .. tostring(u1.ItemsCache.All and #u1.ItemsCache.All or 0));
        u1.ItemsLoaded = true;
        u3 = false;
    end);
    u1.FinishedLoading.Event:Wait();

    return u1.HasAccess;
end;

function u1.RequestAccess() -- Line: 331
    -- upvalues: ensureAccess (copy)
    return ensureAccess();
end;

function u1.GetInventory(p56, p57, p58) -- Line: 339
    -- upvalues: ensureAccess (copy), SortingSchema (copy), AvatarEditorService (copy), u1 (copy), Events (copy)
    if not ensureAccess() then
        return false;
    end;

    local v59 = p56 or "All";
    local v60;

    if typeof(p58) == "string" and p58 ~= "" then
        v60 = string.lower(p58);
    else
        v60 = nil;
    end;

    if v59 ~= "All" then
        local v61 = u1.ItemsCache[v59];

        if p57 then
            if v61 then
                v61 = v61[p57];
            else
                v61 = nil;
            end;
        end;

        local v62 = v61 or {};

        if v60 then
            local sourceItems = v62;
            v62 = {};

            for _, v in sourceItems do
                local v63 = tostring(v.Name or "");

                if v63 ~= "" and string.find(string.lower(v63), v60, 1, true) then
                    table.insert(v62, v);
                end;
            end;
        end;

        return {
            index = 0,
            items = v62,
            IsFinished = #v62 == 0,

            GetCurrentPage = function(p64) -- Line: 457, Name: GetCurrentPage
                local v65 = {};

                if p64.IsFinished then
                    return v65;
                end;

                for i = 1, 60 do
                    local v66 = p64.items[p64.index + i];

                    if not v66 then
                        p64.IsFinished = true;

                        return v65;
                    end;

                    v65[i] = v66;
                end;

                return v65;
            end,

            AdvanceToNextPageAsync = function(p67) -- Line: 476, Name: AdvanceToNextPageAsync
                if p67.IsFinished then
                    error("No more pages to advance to");
                end;

                p67.index = p67.index + 60;

                if p67.index >= #p67.items then
                    p67.IsFinished = true;
                end;
            end
        };
    end;

    local AssetTypes = SortingSchema.Inventory.Subcategories.All.AssetTypes;

    if v60 then
        local v68 = {};

        for _, v in u1.ItemsCache.All or {} do
            local v69 = tostring(v.Name or "");

            if v69 ~= "" and string.find(string.lower(v69), v60, 1, true) then
                table.insert(v68, v);
            end;
        end;

        return {
            index = 0,
            items = v68,
            IsFinished = #v68 == 0,

            GetCurrentPage = function(p70) -- Line: 396, Name: GetCurrentPage
                local v71 = {};

                if p70.IsFinished then
                    return v71;
                end;

                for i = 1, 60 do
                    local v72 = p70.items[p70.index + i];

                    if not v72 then
                        p70.IsFinished = true;

                        return v71;
                    end;

                    v71[i] = v72;
                end;

                return v71;
            end,

            AdvanceToNextPageAsync = function(p73) -- Line: 415, Name: AdvanceToNextPageAsync
                if p73.IsFinished then
                    error("No more pages to advance to");
                end;

                p73.index = p73.index + 60;

                if p73.index >= #p73.items then
                    p73.IsFinished = true;
                end;
            end
        };
    end;

    local success, result = pcall(function() -- Line: 363
        -- upvalues: AvatarEditorService (ref), AssetTypes (copy)
        return AvatarEditorService:GetInventory(AssetTypes);
    end);

    if success then
        return result;
    end;

    if typeof(result) == "string" and string.find(result, "Permission must be obtained", 1, true) then
        u1.HasAccess = false;
        Events.Notify:Fire("❌ Inventory access not granted. Please re-allow.");
    else
        warn("[InventoryService] GetInventory (All, no search) failed:", result);
    end;

    return false;
end;

return u1;