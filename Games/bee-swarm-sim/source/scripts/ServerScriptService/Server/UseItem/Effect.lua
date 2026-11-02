local Module = {}; do
	local TweenService = game:GetService("TweenService")
	local Data = require(script.Parent.Parent.Data)
	local DataModifier = require(game.ServerScriptService.Functions.DataModifier)
	local Remotes = game.ReplicatedStorage.Remotes
	
	function Module.Use(Player: Player, Item: string)
		local PlayerData = Data:Get(Player)
		
		if Item == "Instant Converter" then
			if PlayerData.IStats.Pollen > 0 then
				local Pollen = PlayerData.IStats.Pollen
				DataModifier.IStatsChange(Player, {"-", Pollen, "Pollen"})
				DataModifier.IStatsChange(Player, {"+", Pollen, "Honey", "Instant Converter", true})
			else
				return Remotes.AlertClient:FireClient(Player, {
					Msg = "You must have pollen in your bag!",
					Color = "Red"
				})
			end
		elseif Item == "Fertilizer" then
			if PlayerData.Vars.Field == "" then
				return Remotes.AlertClient:FireClient(Player, {
					Msg = "You must stay at the field!",
					Color = "Red"
				})
			else
				Remotes.Boost:Fire(Player, PlayerData.Vars.Field.." Field", 1)
				DataModifier.MakeCooldown(Player, {Item, 60*15})
			end
		elseif Item == "Caramel" then
			if PlayerData.Vars.Field == "" then
				return Remotes.AlertClient:FireClient(Player, {
					Msg = "You must stay at the field!",
					Color = "Red"
				})
			end
			local Times = math.random(4, 7)
			local Flowers = {}
			
			for i = 1, Times do
				local RandomFlower = nil
				repeat
					RandomFlower = workspace.Fields[PlayerData.Vars.Field]:GetChildren()[math.random(1, #workspace.Fields[PlayerData.Vars.Field]:GetChildren())]
					if (Player.Character:GetPivot().Position - RandomFlower.Position).Magnitude > 30 then
						RandomFlower = nil
					end
				until RandomFlower
				local NearestFlowers: {BasePart} = {RandomFlower}
				for _, Flower in workspace.Fields[PlayerData.Vars.Field]:GetChildren() do
					if Flower ~= RandomFlower and (Flower.Position - RandomFlower.Position).Magnitude <= 8 then
						table.insert(NearestFlowers, Flower)
					end
				end
				
				for _, Flower in NearestFlowers do
					local CaramelPart: BasePart = Flower:FindFirstChild("CaramelPart")
					local CreatedAt = os.time()
					if not CaramelPart then
						CaramelPart = Instance.new("Part")
						CaramelPart.Size = Vector3.new(3.5, 0.3, 3.5)
						CaramelPart.Position = Flower.Position + Vector3.new(0, Flower.Size.Y / 2 + CaramelPart.Size.Y / 2, 0)
						CaramelPart.Anchored = true
						CaramelPart.CanCollide = false
						CaramelPart.CanQuery = false
						CaramelPart.Name = "CaramelPart"
						CaramelPart.Color = Color3.fromRGB(255, 170, 65)
						CaramelPart.Transparency = 0.4
						CaramelPart.Material = Enum.Material.SmoothPlastic
						CaramelPart.Parent = Flower
						CaramelPart:SetAttribute("Spawned", CreatedAt)
					else
						CaramelPart:SetAttribute("Spawned", CreatedAt)
					end
					
					task.defer(function()
						task.wait(6)
						if CaramelPart and CaramelPart:GetAttribute("Spawned") == CreatedAt then
							local TweenTime = 3
							local Tween = TweenService:Create(CaramelPart, TweenInfo.new(TweenTime), {
								Transparency = 1
							})
							Tween:Play()
							local Connection = nil
							local Time = 0
							Connection = game["Run Service"].Heartbeat:Connect(function(deltaTime)
								Time += deltaTime
								if Time >= TweenTime then
									Connection:Disconnect()
								else
									if CaramelPart and CaramelPart:GetAttribute("Spawned") ~= CreatedAt then
										print("canceled")
										Tween:Cancel()
										CaramelPart.Transparency = 0.4
										Connection:Disconnect()
									end
								end
							end)
							task.wait(TweenTime)
							if CaramelPart and CaramelPart:GetAttribute("Spawned") == CreatedAt then 
								CaramelPart:Destroy()
							else
								CaramelPart.Transparency = 0.4
							end 
						end
					end)
				end
				
				table.insert(Flowers, {RandomFlower})
			end
			
		end
		
		DataModifier.InventoryChange(Player, {"-", 1, Item})
	end
end

return Module