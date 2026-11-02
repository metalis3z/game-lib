local OutfitsDB = game.ReplicatedStorage.GetSyncDataServer:Invoke("Outfits")
local OutfitEvents = game.ReplicatedStorage.OutfitEvents
local GetPD = OutfitEvents.GetPD_REMOTE
local PlayerService = game:GetService("Players")
--print(OutfitsDB)
OutfitEvents.SetAvatars.Event:Connect(function(Player)
	local Character = Player.Character
	if not Character then return end
	local Human = Character:FindFirstChild("Humanoid")
	if not Human then return end
	local PData = GetPD:Invoke(Player)
	if not PData then return end
	--print(PData)
	local UserId = Player.UserId
	local EquippedOutfit = PData.Outfits.Equipped[1]
	local OutfitData = OutfitsDB[EquippedOutfit]
	--print(OutfitData)
	if EquippedOutfit == nil or EquippedOutfit == {} then
		
		Human:ApplyDescription(PlayerService:GetHumanoidDescriptionFromUserId(UserId))
	else
		Human:ApplyDescription(PlayerService:GetHumanoidDescriptionFromUserId(OutfitData.UserId))
	end
	_G.GivePet(Player)
	_G.WeldRadio(Player)
	_G.WeldWeapons(Player)
	if Character:FindFirstChild("Sound") then Character.Sound:Destroy() end
	for _,Obj in pairs(game.StarterPlayer.StarterCharacterScripts:GetChildren()) do
		if Obj.Name == "LoadOutfit" then return end
		if Character:FindFirstChild(Obj.Name) then return end
		Obj:Clone().Parent = Character
	end
	
end)

OutfitEvents.SetAvatarClient.OnServerEvent:Connect(function(Player)
	OutfitEvents.SetAvatars:Fire(Player)
end)