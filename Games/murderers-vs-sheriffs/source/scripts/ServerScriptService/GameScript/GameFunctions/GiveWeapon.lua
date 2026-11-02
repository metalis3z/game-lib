local Module = {}

local Data = require(script.Parent.Parent.DataModule);
local Sync = require(game.ReplicatedStorage.Database.Sync)
local ItemsDB = Sync.Item

Module.Gun = function(Player,IsForce)
	local equippedWeapons = Data.Get(Player,"Weapons").Equipped
	local equippedGun = equippedWeapons.Gun
	local GunID = ItemsDB[equippedGun];
	local NewItem;
	NewItem = game.ServerStorage.Database.Default.Gun:Clone(); 
	if game.ServerStorage.Database.Item[equippedGun] then
		NewItem = game.ServerStorage.Database.Item[equippedGun]:Clone(); 
	end
	NewItem.Handle.CanCollide = false
	NewItem.Handle.Massless = true
	NewItem.TextureId = ItemsDB[equippedGun].Image;
	for i,Script in pairs(game.ServerStorage.Gameplay.GunScripts:GetChildren()) do
		local NewScript = Script:Clone()
		if NewScript:IsA("LocalScript") or NewScript:IsA("Script") then
			NewScript.Disabled = false
		end;
		NewScript.Parent = NewItem;
	end
	NewItem.Name = "Gun"
	NewItem.CanBeDropped = false;
	NewItem.Parent = Player.Backpack;
	NewItem:AddTag("Weapon_Gun")
	NewItem:AddTag("Weapon")
	game.ReplicatedStorage.Remotes.Gameplay.GiveWeapon:FireClient(Player, "Gun")
	local Folder = game.ServerStorage.Gameplay.GunScripts
	if Folder:FindFirstChildWhichIsA("Attachment") then
		for _, Attachments in ipairs(Folder:GetChildren()) do
			if Attachments:IsA("Attachment") then
				Attachments:Clone().Parent = Player.Character.HumanoidRootPart
			end
		end
	end
	return NewItem;
end

Module.Knife = function(Player,IsForce)
	local equippedWeapons = Data.Get(Player,"Weapons").Equipped
	local equippedKnife = equippedWeapons.Knife
	local KnifeID = ItemsDB[equippedKnife];
	local NewItem;
	NewItem = game.ServerStorage.Database.Default.Knife:Clone(); 
	if game.ServerStorage.Database.Item[equippedKnife] then
		NewItem = game.ServerStorage.Database.Item[equippedKnife]:Clone(); 
	end
	NewItem.TextureId = ItemsDB[equippedKnife].Image;
	NewItem:SetAttribute("ItemID", equippedKnife)
	NewItem:SetAttribute("OriginalItemID", equippedKnife)
	NewItem:SetAttribute("IsBanHammer", equippedKnife == "BanHammer")
	for i,Script in pairs(game.ServerStorage.Gameplay.KnifeScripts:GetChildren()) do
		local NewScript = Script:Clone()
		if NewScript:IsA("Script") or NewScript:IsA("LocalScript") then
			NewScript.Disabled = false
		end;
		NewScript.Parent = NewItem;
	end
	NewItem.Handle.CanCollide = false
	NewItem.Handle.Massless = true
	NewItem.Handle.CanTouch = true
	NewItem.Handle.CanQuery = true
	NewItem.CanBeDropped = false;
	NewItem.Name = "Knife"
	NewItem.Parent = Player.Backpack;
	NewItem:AddTag("Weapon_Knife")
	NewItem:AddTag("Weapon")
	game.ReplicatedStorage.Remotes.Gameplay.GiveWeapon:FireClient(Player, "Knife")
	return NewItem;
end


return Module;
