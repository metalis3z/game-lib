local Events = game.ReplicatedStorage.Events

local function CreateChatMessage(Message,Color,font)
	for i,Player in pairs(game.Players:GetPlayers()) do
		Events.CreateChatMessage:FireClient(Player,"Server: ".. Message,Color,font)
	end
end

Events.ClaimTycoon.OnServerEvent:Connect(function(Player,Tycoon)
	if game.Workspace.Tycoons:FindFirstChild(Tycoon) then
		Tycoon = game.Workspace.Tycoons:FindFirstChild(Tycoon)
	else
		return
	end
	if Player.Data.TycoonOwned.Value == 0 then
		if Tycoon.Data.Owner.Value == "" then
			Tycoon.Data.Owner.Value = Player.Name
			Player.Data.TycoonOwned.Value = tonumber(Tycoon.Name)
			CreateChatMessage(Player.DisplayName.. " has claimed a tycoon!",Color3.fromRGB(99, 198, 0),Enum.Font.FredokaOne)
			
			Tycoon.Door.GUipart.BillboardGui.TextLabel.Text = "Owner: ".. Player.DisplayName
			for i,v in pairs(Tycoon.Droppers:FindFirstChild("1").Parts:GetChildren()) do
				v.Transparency = 0
				v.CanCollide = true
			end
		end
	end
end)

Events.ReadyUpForEvent.OnServerEvent:Connect(function(Player)
	Player.Data.ReadyForEvent.Value = true
end)

Events.BuyWeapon.OnServerEvent:Connect(function(Player,GunName)
	if Player.Data.Cash.Value >= game.ReplicatedStorage.GunShopWeaponData:FindFirstChild(GunName).Value then
		Player.Data.Cash.Value -= game.ReplicatedStorage.GunShopWeaponData:FindFirstChild(GunName).Value
		local Weapon = game.ReplicatedStorage.Weapons:FindFirstChild(GunName):Clone()
		Weapon.Parent = Player.Backpack
	end
end)