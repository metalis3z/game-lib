
local v0 = {};
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_GetPack_0 = l_Remotes_0:WaitForChild("Shop"):WaitForChild("GetPack");
local l_PurchaseWeaponPack_0 = l_Remotes_0:WaitForChild("Shop"):WaitForChild("PurchaseWeaponPack");
local l_CurrentEvent_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild("EventInfoService")):GetCurrentEvent();
local v6 = {};
if l_CurrentEvent_0 and l_CurrentEvent_0.ItemPackItems then
    v6.Knife = l_CurrentEvent_0.ItemPackItems.Knife;
    v6.Gun = l_CurrentEvent_0.ItemPackItems.Gun;
    v6.Bundle = l_CurrentEvent_0.ItemPackItems.Bundle;
end;
v0.PromptBuyKnife = function(_) --[[ Line: 56 ]] --[[ Name: PromptBuyKnife ]]
    local l_ItemPacks_2 = l_ProfileData_0.ItemPacks;
    local l_Knife_0 = v6.Knife;
    if l_ItemPacks_2[tostring(l_Knife_0.GamePassID)] == true then
        l_PurchaseWeaponPack_0:FireServer(l_Knife_0.DevProductID);
        return;
    else
        l_GetPack_0:FireServer(l_Knife_0.GamePassID);
        return;
    end;
end;
v0.PromptBuyGun = function(_) --[[ Line: 60 ]] --[[ Name: PromptBuyGun ]]
    local l_ItemPacks_3 = l_ProfileData_0.ItemPacks;
    local l_Gun_0 = v6.Gun;
    if l_ItemPacks_3[tostring(l_Gun_0.GamePassID)] == true then
        l_PurchaseWeaponPack_0:FireServer(l_Gun_0.DevProductID);
        return;
    else
        l_GetPack_0:FireServer(l_Gun_0.GamePassID);
        return;
    end;
end;
v0.PromptBuyBundle = function(_) --[[ Line: 64 ]] --[[ Name: PromptBuyBundle ]]
    local l_ItemPacks_4 = l_ProfileData_0.ItemPacks;
    local l_Bundle_1 = v6.Bundle;
    if l_ItemPacks_4[tostring(l_Bundle_1.GamePassID)] == true then
        l_PurchaseWeaponPack_0:FireServer(l_Bundle_1.DevProductID);
        return;
    else
        l_GetPack_0:FireServer(l_Bundle_1.GamePassID);
        return;
    end;
end;
return v0;