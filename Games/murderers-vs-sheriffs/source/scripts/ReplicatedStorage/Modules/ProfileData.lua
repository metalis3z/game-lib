local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Inventory_0 = l_ReplicatedStorage_0:WaitForChild("Remotes"):WaitForChild("Inventory");
local v2 = nil;
repeat
	v2 = l_Inventory_0:WaitForChild("GetProfileData"):InvokeServer();
	task.wait(0.1);
until v2 ~= nil;
local l_ProfileDataChanged_0 = l_Inventory_0:WaitForChild("ProfileDataChanged");
local l_InventoryDataChanged_0 = l_Inventory_0:WaitForChild("InventoryDataChanged");
local l_UpdateDataClient_0 = l_ReplicatedStorage_0:WaitForChild("UpdateDataClient");
local v6 = {
	Weapons = true, 
	Pets = true, 
	Materials = true
};
local function LegacyConvertToysToEmotes()
	for _, v8 in v2.Toys.Owned do
		if not table.find(v2.Emotes.Owned, v8) then
			table.insert(v2.Emotes.Owned, v8);
		end;
	end;
end;
local function onProfileDataChanged(v11, v12)
	v2[v11] = v12;
	l_ProfileDataChanged_0:Fire(v11, v12);
end;
local function onInventoryItemChanged(v14, v15, v16)
	if v6[v14] then
		v2[v14].Owned[v15] = v16;
		LegacyConvertToysToEmotes();
		l_InventoryDataChanged_0:Fire(v14, v15, v16);
	elseif v16 ~= nil and v16 > 0 then
		table.insert(v2[v14].Owned, v15);
		LegacyConvertToysToEmotes();
		l_InventoryDataChanged_0:Fire(v14, v15, 1);
	end;
	l_UpdateDataClient_0:Fire(false, v2);
end;
LegacyConvertToysToEmotes();
l_Inventory_0:WaitForChild("ChangeProfileData").OnClientEvent:Connect(onProfileDataChanged);
l_Inventory_0:WaitForChild("ChangeInventoryItem").OnClientEvent:Connect(onInventoryItemChanged);
_G.UpdateEmotes = LegacyConvertToysToEmotes;
return v2;