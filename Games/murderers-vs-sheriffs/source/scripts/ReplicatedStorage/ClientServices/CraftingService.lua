-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_ClientServices_0 = game:GetService("ReplicatedStorage"):WaitForChild("ClientServices");
local _ = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local _ = require(l_ClientServices_0:WaitForChild("InventoryService"));
local l_ItemService_0 = require(l_ClientServices_0:WaitForChild("ItemService"));
local l_RecipeService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild("RecipeService"));
v0.CurrentlyCrafting = {};
v0.IsMaterialCraftable = function(_, v9) --[[ Line: 24 ]] --[[ Name: IsMaterialCraftable ]]
    if v9 == nil then
        return false;
    else
        local v10 = l_Sync_0.Materials[v9];
        if v10 == nil then
            return false;
        elseif not v10.Craftable then
            return false;
        else
            return true;
        end;
    end;
end;
v0.GetWeaponSalvageRewards = function(_, v12) --[[ Line: 42 ]] --[[ Name: GetWeaponSalvageRewards ]]
    local l_Rarity_0 = l_Sync_0.Weapons[v12].Rarity;
    local v14 = l_Sync_0.SalvageRewards[v12] and l_Sync_0.SalvageRewards[v12].Rewards;
    local v15 = l_Sync_0.SalvageRewards[l_Rarity_0] and l_Sync_0.SalvageRewards[l_Rarity_0].Rewards;
    if v14 then
        return v14;
    elseif v15 then
        return v15;
    else
        return {};
    end;
end;
v0.GetSalvageInventory = function(_) --[[ Line: 57 ]] --[[ Name: GetSalvageInventory ]]
    local v17 = {};
    for v18, v19 in l_ProfileData_0.Weapons.Owned do
        if l_RecipeService_0:IsItemSalvageable(v18) then
            v17[v18] = v19;
        end;
    end;
    return v17;
end;
v0.GenerateMaterialInventory = function(_) --[[ Line: 67 ]] --[[ Name: GenerateMaterialInventory ]]
    local v21 = {};
    for v22, v23 in l_ProfileData_0.Materials.Owned do
        if v0:IsMaterialCraftable(v22) then
            v21[v22] = v23;
        end;
    end;
    return v21;
end;
v0.ClearMultipleContainer = function(_, v25) --[[ Line: 78 ]] --[[ Name: ClearMultipleContainer ]]
    for _, v27 in v25.MultipleContainer:GetChildren() do
        if v27:IsA("Frame") then
            l_ItemService_0:ApplyMiniItemFrame(v27, nil, 1);
        end;
    end;
end;
v0.ClearCrafting = function(_, v29, v30) --[[ Line: 87 ]] --[[ Name: ClearCrafting ]]
    v0.CurrentlyCrafting = {};
    v29.SingleContainer.Visible = false;
    v29.MultipleContainer.Visible = false;
    v30.SingleContainer.Visible = false;
    v30.MultipleContainer.Visible = false;
end;
v0.SelectItemForCrafting = function(_, v32, v33, v34, v35) --[[ Line: 96 ]] --[[ Name: SelectItemForCrafting ]]
    local v36 = l_Sync_0[v34][v35];
    if not v36 then
        return;
    elseif v34 == "Weapons" then
        l_ItemService_0:ApplyItemToFrame(v32.SingleContainer.NewItem, v36, 1);
        v32.SingleContainer.Visible = true;
        v32.MultipleContainer.Visible = false;
        v33.SingleContainer.Visible = false;
        v33.MultipleContainer.Visible = true;
        v0:ClearMultipleContainer(v33);
        local l_v0_WeaponSalvageRewards_0 = v0:GetWeaponSalvageRewards(v35);
        local v38 = 1;
        for v39, v40 in l_v0_WeaponSalvageRewards_0 do
            local v41 = v40.Amount[1];
            local l_l_ItemService_0_ItemInfo_0 = l_ItemService_0:GetItemInfo("Materials", v39);
            l_ItemService_0:ApplyMiniItemFrame(v33.MultipleContainer["Material" .. v38], l_l_ItemService_0_ItemInfo_0, v41);
            v38 = v38 + 1;
        end;
        v0.CurrentlyCrafting = {
            {
                itemType = "Weapons", 
                itemID = v35, 
                amount = 1
            }
        };
        return;
    else
        if v34 == "Materials" then
            for _, v44 in v0.CurrentlyCrafting do
                if v44.itemType == "Weapons" then
                    v0.CurrentlyCrafting = {};
                    break;
                end;
            end;
            local v45 = nil;
            for v46, v47 in v0.CurrentlyCrafting do
                if v47.itemID == v35 then
                    v45 = v46;
                    break;
                end;
            end;
            if v45 then
                if v0.CurrentlyCrafting[v45].amount < l_ProfileData_0.Materials.Owned[v35] then
                    local v48 = v0.CurrentlyCrafting[v45];
                    v48.amount = v48.amount + 1;
                end;
            elseif #v0.CurrentlyCrafting < 4 then
                table.insert(v0.CurrentlyCrafting, {
                    itemType = "Materials", 
                    itemID = v35, 
                    amount = 1
                });
            end;
            for v49 = 1, 4 do
                local v50 = v0.CurrentlyCrafting[v49];
                if v50 then
                    local l_l_ItemService_0_ItemInfo_1 = l_ItemService_0:GetItemInfo("Materials", v50.itemID);
                    l_ItemService_0:ApplyMiniItemFrame(v32.MultipleContainer["Material" .. v49], l_l_ItemService_0_ItemInfo_1, v50.amount);
                else
                    l_ItemService_0:ApplyMiniItemFrame(v32.MultipleContainer["Material" .. v49], nil, 0);
                end;
            end;
            local l_l_RecipeService_0_CraftingResult_0 = l_RecipeService_0:GetCraftingResult(v0.CurrentlyCrafting);
            if l_l_RecipeService_0_CraftingResult_0 then
                local l_l_ItemService_0_ItemInfo_2 = l_ItemService_0:GetItemInfo("Recipes", l_l_RecipeService_0_CraftingResult_0);
                l_ItemService_0:ApplyItemToFrame(v33.SingleContainer.NewItem, l_l_ItemService_0_ItemInfo_2, 1);
            else
                l_ItemService_0:ApplyItemToFrame(v33.SingleContainer.NewItem, nil, 1);
            end;
            v33.SingleContainer.Visible = l_l_RecipeService_0_CraftingResult_0 ~= nil;
            v33.MultipleContainer.Visible = false;
            v32.SingleContainer.Visible = false;
            v32.MultipleContainer.Visible = true;
        end;
        return;
    end;
end;
return v0;