
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local l_GetCurrentPlayerData_0 = l_Remotes_0:WaitForChild("Gameplay"):WaitForChild("GetCurrentPlayerData");
local v2 = {
    PlayerData = {}, 
    PlayerDataChanged = script:WaitForChild("PlayerDataChanged")
};
local function v4(v3) --[[ Line: 8 ]] --[[ Name: onPlayerDataChanged ]]
    v2.PlayerData = v3;
	v2.PlayerDataChanged:Fire();	
	if not v3 or #v3 == 0 then
		_G.OutfitsDisabled = false
	end
end;
v2.GetLatestPlayerData = function() --[[ Line: 13 ]] --[[ Name: GetLatestPlayerData ]]
    return l_GetCurrentPlayerData_0:InvokeServer();
end;
v2.GetMurdererPerk = function() --[[ Line: 17 ]] --[[ Name: GetMurdererPerk ]]
    for _, v6 in v2.PlayerData do
        if v6.Role == "Murderer" then
            return v6.Perk;
        end;
    end;
    return nil;
end;
v2.PlayerData = l_GetCurrentPlayerData_0:InvokeServer() or {};
l_Remotes_0:WaitForChild("Gameplay"):WaitForChild("PlayerDataChanged").OnClientEvent:Connect(v4);

return v2;