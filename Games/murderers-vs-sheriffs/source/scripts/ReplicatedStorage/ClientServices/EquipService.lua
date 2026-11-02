-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_EquipContainer_0 = script:WaitForChild("EquipContainer");
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local l_ClientServices_0 = game:GetService("ReplicatedStorage"):WaitForChild("ClientServices");
local l_ItemService_0 = require(l_ClientServices_0:WaitForChild("ItemService"));
local v6 = {
    Perks = true, 
    Knife = true, 
    Gun = true
};
local v7 = {};
v0.EquippedChanged = script:WaitForChild("EquippedChanged");
v0.EquipItem = function(_, v9, v10) --[[ Line: 23 ]] --[[ Name: EquipItem ]]
    local l_l_ItemService_0_ItemInfo_0 = l_ItemService_0:GetItemInfo(v9, v10);
    if v9 == "Weapons" then
        local l_ItemType_0 = l_l_ItemService_0_ItemInfo_0.ItemType;
        l_ProfileData_0.Weapons.Equipped[l_ItemType_0] = v10;
        v0.EquippedChanged:Fire(l_ItemType_0, v10);
    else
        l_ProfileData_0[v9].Equipped = {
            v10
        };
        v0.EquippedChanged:Fire(v9, v10);
    end;
    l_Remotes_0.Inventory.Equip:FireServer(v10, v9);
end;
v0.UnequipItem = function(_, v14) --[[ Line: 39 ]] --[[ Name: UnequipItem ]]
    if v14 == "Knife" then
        l_ProfileData_0.Weapons.Equipped.Knife = "DefaultKnife";
    elseif v14 == "Gun" then
        l_ProfileData_0.Weapons.Equipped.Gun = "DefaultGun";
    else
        l_ProfileData_0[v14].Equipped = {};
        l_Remotes_0.Inventory.Unequip:FireServer(1, v14);
    end;
    v0.EquippedChanged:Fire(v14, nil);
end;
v0.GetEquipped = function(_, v16) --[[ Line: 52 ]] --[[ Name: GetEquipped ]]
    if v16 == "Knife" then
        return l_ProfileData_0.Weapons.Equipped.Knife;
    elseif v16 == "Gun" then
        return l_ProfileData_0.Weapons.Equipped.Gun;
    else
        return l_ProfileData_0[v16].Equipped[1];
    end;
end;
v0.CreateEquipContainer = function(_, v18) --[[ Line: 63 ]] --[[ Name: CreateEquipContainer ]]
    local v19 = l_EquipContainer_0:Clone();
    v19.ItemFrame:Destroy();
    local v20 = l_ItemService_0.BaseItemFrame:Clone();
    v20.Parent = v19;
    if v6[v18] then
        v20.UIPadding:Destroy();
    end;
    v7[v18] = v19;
    return v19;
end;
local function v29(v21, v22) --[[ Line: 75 ]] --[[ Name: onEquippedChanged ]]
    local v23 = v7[v21];
    if not v23 then
        return;
    else
        local v24 = v21 == "Knife" and "Weapons" or v21 == "Gun" and "Weapons" or v21;
        local v25 = nil;
        if v22 then
            v25 = l_ItemService_0:GetItemInfo(v24, v22);
        end;
        local l_ItemFrame_0 = v23:WaitForChild("ItemFrame");
        l_ItemFrame_0.Visible = v22 ~= nil;
        local l_Unequip_0 = v23.Unequip;
        local v28 = false;
        if v22 ~= nil then
            v28 = false;
            if v24 ~= "Perks" then
                v28 = v24 ~= "Weapons";
            end;
        end;
        l_Unequip_0.Visible = v28;
        l_ItemService_0:ApplyItemToFrame(l_ItemFrame_0, v25);
        l_ItemService_0:UpdateTags(l_ItemFrame_0, v25);
        return;
    end;
end;
v0.BindEquipContainer = function(_, v31, v32) --[[ Line: 93 ]] --[[ Name: BindEquipContainer ]]
    v7[v31] = v32;
    v29(v31, v0:GetEquipped(v31));
end;
v0.EquippedChanged.Event:Connect(v29);
return v0;