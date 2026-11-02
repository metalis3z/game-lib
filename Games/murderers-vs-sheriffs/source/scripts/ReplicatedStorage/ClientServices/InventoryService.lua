-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local _ = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local l_ClientServices_0 = game:GetService("ReplicatedStorage"):WaitForChild("ClientServices");
local _ = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local l_ItemService_0 = require(l_ClientServices_0:WaitForChild("ItemService"));
local l_BaseItemFrame_0 = l_ItemService_0.BaseItemFrame;
local function v18(v8, v9) --[[ Line: 38 ]] --[[ Name: ApplyFilter ]]
    local v10 = v8.Filters.Search or "";
    local _ = v8.Filters.ClassFilter or nil;
    local l_Frame_0 = v8.Frames[v9].Frame;
    local v13 = false;
    if v10 ~= "" then
        v13 = v10 ~= nil;
    end;
    local v14 = false;
    if v13 then
        local v15 = l_Sync_0[v8.ItemType][v9];
        local v16 = string.lower(v15.Name or v15.DisplayName or v15.ItemName);
        v14 = string.find(v16, v10) ~= nil;
    end;
    local v17 = true;
    if v8.Frames[v9].ItemClass ~= v8.Filters.ClassFilter then
        v17 = v8.Filters.ClassFilter == nil;
    end;
    l_Frame_0.Visible = v17 and not v13 or v13 and v14;
end;
v0.CreateItemFrame = function(_, v20, v21, v22) --[[ Line: 55 ]] --[[ Name: CreateItemFrame ]]
    local v23 = l_BaseItemFrame_0:Clone();
    local l_l_ItemService_0_ItemInfo_0 = l_ItemService_0:GetItemInfo(v20, v21);
    if not l_l_ItemService_0_ItemInfo_0 then
        warn("InventoryService: No info found for item:" .. tostring(v21) .. ", " .. tostring(v20));
        return nil;
    else
        l_ItemService_0:ApplyItemToFrame(v23, l_l_ItemService_0_ItemInfo_0, v22);
        l_ItemService_0:ApplyTags(v23, l_l_ItemService_0_ItemInfo_0);
        v23.LayoutOrder = l_ItemService_0:GetLayoutOrder(v20, v21);
        local v25 = nil;
        if v20 == "Weapons" then
            v25 = l_l_ItemService_0_ItemInfo_0.Event ~= nil and "Event" or l_l_ItemService_0_ItemInfo_0.Season == nil and "Classic" or "Current";
        end;
        return {
            ItemType = v20, 
            Frame = v23, 
            ItemClass = v25
        };
    end;
end;
v0.AddItem = function(_, v27, v28, v29) --[[ Line: 85 ]] --[[ Name: AddItem ]]
    local l_v0_ItemFrame_0 = v0:CreateItemFrame(v27.ItemType, v28, v29);
    if l_v0_ItemFrame_0 then
        table.insert(v27.SortedIDs, v28);
        v27.Frames[v28] = l_v0_ItemFrame_0;
        v18(v27, v28);
        if v27.ListFrame then
            l_v0_ItemFrame_0.Frame.Parent = v27.ListFrame;
        end;
    end;
    return l_v0_ItemFrame_0;
end;
v0.GenerateInventoryInfo = function(_, v32, v33, v34) --[[ Line: 98 ]] --[[ Name: GenerateInventoryInfo ]]
    local v35 = {
        ItemType = v32, 
        Frames = {}, 
        Filters = {
            ClassFilter = nil, 
            Search = ""
        }, 
        SortedIDs = {}, 
        ListFrame = v34
    };
    for v36, v37 in v33 do
        local v38 = nil;
        local v39 = nil;
        if tonumber(v36) then
            v38 = v37;
            v39 = 1;
        else
            v38 = v36;
            v39 = v37;
        end;
        v0:AddItem(v35, v38, v39);
    end;
    return v35;
end;
v0.UpdateFilter = function(_, v41) --[[ Line: 124 ]] --[[ Name: UpdateFilter ]]
    for v42, _ in v41.Frames do
        v18(v41, v42);
    end;
end;
v0.ForEachFrame = function(_, v45, v46) --[[ Line: 130 ]] --[[ Name: ForEachFrame ]]
    for v47, v48 in v45.Frames do
        v46(v47, v48.Frame);
    end;
end;
v0.ApplyChangesToInventoryInfo = function(_, v50, v51, v52) --[[ Line: 136 ]] --[[ Name: ApplyChangesToInventoryInfo ]]
    if v52 ~= nil and v52 > 0 then
        if not v50.Frames[v51] then
            v0:AddItem(v50, v51, v52);
            return;
        else
            v50.Frames[v51].Frame.Container.Amount.Text = l_ItemService_0:GetAmountText(v52);
            return;
        end;
    else
        v0:RemoveItem(v50, v51);
        return;
    end;
end;
v0.ConnectSearchBox = function(_, v54, v55)
    v55:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 150 ]]
        v54.Filters.Search = string.lower(v55.Text);
        v0:UpdateFilter(v54);
    end);
end;
v0.AutoUpdate = function(_, v57) --[[ Line: 156 ]] --[[ Name: AutoUpdate ]]
    v57.UpdateConnection = l_Remotes_0:WaitForChild("Inventory"):WaitForChild("InventoryDataChanged").Event:Connect(function(v58, v59, v60) --[[ Line: 157 ]]
        if v58 ~= v57.ItemType then
            return;
        else
            if v58 == "Toys" then
                v58 = "Emotes";
            end;
            v0:ApplyChangesToInventoryInfo(v57, v59, v60);
            return;
        end;
    end);
end;
v0.RemoveItem = function(_, v62, v63) --[[ Line: 168 ]] --[[ Name: RemoveItem ]]
    v62.Frames[v63].Frame:Destroy();
    v62.Frames[v63] = nil;
    table.remove(v62.SortedIDs, table.find(v62.SortedIDs, v63));
end;
v0.ClearInventory = function(_, v65) --[[ Line: 175 ]] --[[ Name: ClearInventory ]]
    for _, v67 in v65.Frames do
        v67.Frame:Destroy();
    end;
    v65.Frames = {};
    if v65.UpdateConnection then
        v65.UpdateConnection:Disconnect();
    end;
end;
return v0;