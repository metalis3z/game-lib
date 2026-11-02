local module = {}

function audioPlay(p1, p2, p3, p4, p5, p6, p7)
	local Sound = Instance.new("Sound")
	Sound.SoundId = p1
	Sound.Parent = p2

	Sound.MinDistance = p5
	Sound.MaxDistance = p6
	Sound.Volume = p4

	Sound.PlaybackSpeed = p7

	Sound.TimePosition = p3

	task.wait()

	Sound:Play()

	Sound.Ended:Connect(function()
		Sound:Destroy()
	end)
end

function module:StarVialSmall(v)

	v.ModulePrompt.Triggered:Connect(function(Player)
		if not Player.Character:FindFirstChild("StarVial") and not Player.Backpack:FindFirstChild("StarVial") then
			local itemCloned = game.ServerStorage.StarVial:Clone()
			itemCloned:SetAttribute("Durability", 1)

			itemCloned.Parent = Player.Character
			v:Destroy()
			return
		end

		if Player.Character:FindFirstChild("StarVial") then
			local Item = Player.Character:FindFirstChild("StarVial")

			if Item:GetAttribute("Durability") < 3 then
				Item:SetAttribute("Durability", Item:GetAttribute("Durability") + 1)
				--game.ReplicatedStorage.Bricks.FlashSpecify_Amount:FireClient(Player, Item.TextureId, Item:GetAttribute("Durability") + 1, Item:GetAttribute("DurabilityMax"))
				v:Destroy()
			else
				game.ReplicatedStorage.Bricks.FlashSpecify_ChargeMax:FireClient(Player, Item)
			end
		end

		if Player.Backpack:FindFirstChild("StarVial") then
			local Item = Player.Backpack:FindFirstChild("StarVial")

			if Item:GetAttribute("Durability") < 3 then
				Item:SetAttribute("Durability", Item:GetAttribute("Durability") + 1)
				--game.ReplicatedStorage.Bricks.FlashSpecify_Amount:FireClient(Player, Item.TextureId, Item:GetAttribute("Durability") + 1, Item:GetAttribute("DurabilityMax"))
				v:Destroy()
			else
				game.ReplicatedStorage.Bricks.FlashSpecify_ChargeMax:FireClient(Player, Item)
			end
		end
	end)

end

function module:BuyableItem(v)
	local Prompt = v:FindFirstChild("ModulePrompt")
	
	if game.Workspace.Game.Modifiers:FindFirstChild("Discount") then
		if game.Workspace.Game.Modifiers:FindFirstChild("Discount").Value == true then
			v:SetAttribute("Price", v:GetAttribute("Price") * 0.5)
		end
	end
	
	Prompt.Triggered:Connect(function(Player)
		
		local item = v
		
		if Player.Character:FindFirstChild(item.Name) or Player.Backpack:FindFirstChild(item.Name) then
			game.ReplicatedStorage.EntityInfo.FlashSpecify:FireClient(Player, "Cannot")
			return
		end
		
		if Player.Stats.Gold.Value >= item:GetAttribute("Price") then
			
			local module = require(game.ReplicatedStorage.ClientModules.Module_AdminPanel)

			if game.MarketplaceService:PlayerOwnsAsset(Player, module.gamepass_id) and Player.PlayerStats.AdminPanel.Value == true then
				
			else
				local ach = "JeffShop"
				local p1_player = Player

				if game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach) then
					local achive = game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach)
					local req = require(game.ReplicatedStorage.Achievements)[ach]

					if achive.Value == false then
						achive.Value = true
						if not game:GetService("BadgeService"):UserHasBadgeAsync(p1_player.UserId, req.BadgeId) then
							game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(p1_player, ach)
							game:GetService("BadgeService"):AwardBadge(p1_player.UserId, req.BadgeId)
						end
					end

				end
			end
			
			Player.Stats.Gold.Value -= item:GetAttribute("Price")
			local NewItem = game.ServerStorage:FindFirstChild(item.Name):Clone()
			NewItem.Parent = Player.Character
			
			if item:GetAttribute("Durability") then
				NewItem:SetAttribute("Durability", item:GetAttribute("Durability"))
			end
			
			audioPlay("rbxassetid://6102638180", item, 0, 0.45, 1, 15, 1.05)
			task.wait()
			item:Destroy()
		else
			game.ReplicatedStorage.EntityInfo.FlashSpecify:FireClient(Player, "Cannot")
		end
	end)
end

function module:LighterDrop(v)
	local Durability_New = v:GetAttribute("Durability")
	
	v.ModulePrompt.Triggered:Connect(function(Player)
		if not Player.Character:FindFirstChild("Lighter") and not Player.Backpack:FindFirstChild("Lighter") then
			local itemCloned = game.ServerStorage.Lighter:Clone()
			itemCloned:SetAttribute("Durability", Durability_New)

			itemCloned.Parent = Player.Character
			v:Destroy()
			return
		end

		if Player.Character:FindFirstChild("Lighter") then
			local Item = Player.Character:FindFirstChild("Lighter")

			if Item:GetAttribute("Durability") > Durability_New then
				game.ReplicatedStorage.Bricks.FlashSpecify_BetterShape:FireClient(Player, Item, Item:GetAttribute("Durability"), Durability_New)
				return
			end

			local CurrentValue = Item:GetAttribute("Durability")

			if Item:GetAttribute("Durability") < Durability_New then
				game.ReplicatedStorage.Bricks.FlashSpecify_Swap:FireClient(Player, Item, Item:GetAttribute("Durability"), Durability_New)
				Item:SetAttribute("Durability", Durability_New)

				v:SetAttribute("Durability", CurrentValue)
				Durability_New = CurrentValue
			end
		end

		if Player.Backpack:FindFirstChild("Lighter") then
			local Item = Player.Backpack:FindFirstChild("Lighter")

			if Item:GetAttribute("Durability") > Durability_New then
				game.ReplicatedStorage.Bricks.FlashSpecify_BetterShape:FireClient(Player, Item, Item:GetAttribute("Durability"), Durability_New)
				return
			end

			local CurrentValue = Item:GetAttribute("Durability")

			if Item:GetAttribute("Durability") < Durability_New then
				game.ReplicatedStorage.Bricks.FlashSpecify_Swap:FireClient(Player, Item, Item:GetAttribute("Durability"), Durability_New)
				Item:SetAttribute("Durability", Durability_New)

				v:SetAttribute("Durability", CurrentValue)
				Durability_New = CurrentValue
			end
		end

	end)
end

function module:VitaminsAdd(v)
	
	v.ModulePrompt.Triggered:Connect(function(Player)
		
		v.ModulePrompt.Enabled = false
		
		if not Player.Character:FindFirstChild("Vitamins") and not Player.Backpack:FindFirstChild("Vitamins") then
			local itemCloned = game.ServerStorage.Vitamins:Clone()
            itemCloned:SetAttribute("Durability", 1)

			itemCloned.Parent = Player.Character
			v:Destroy()
			return
		end
		
		if Player.Character:FindFirstChild("Vitamins") then
			local Item = Player.Character:FindFirstChild("Vitamins")
			
			if Item:GetAttribute("Durability") < 3 then
				Item:SetAttribute("Durability", Item:GetAttribute("Durability") + 1)
				--game.ReplicatedStorage.Bricks.FlashSpecify_Amount:FireClient(Player, Item.TextureId, Item:GetAttribute("Durability") + 1, Item:GetAttribute("DurabilityMax"))
				v:Destroy()
			else
				game.ReplicatedStorage.Bricks.FlashSpecify_ChargeMax:FireClient(Player, Item)
			end
		end
		
		if Player.Backpack:FindFirstChild("Vitamins") then
			local Item = Player.Backpack:FindFirstChild("Vitamins")

			if Item:GetAttribute("Durability") < 3 then
				Item:SetAttribute("Durability", Item:GetAttribute("Durability") + 1)
				--game.ReplicatedStorage.Bricks.FlashSpecify_Amount:FireClient(Player, Item.TextureId, Item:GetAttribute("Durability") + 1, Item:GetAttribute("DurabilityMax"))
				v:Destroy()
			else
				game.ReplicatedStorage.Bricks.FlashSpecify_ChargeMax:FireClient(Player, Item)
			end
		end
		
		task.delay(1, function()
			if v then
				v.ModulePrompt.Enabled = true
			end
		end)
	end)
	
end

function module:LighterSwap(v)
	local Durability_New = math.random(40, 50)
	
	v.ModulePrompt.Triggered:Connect(function(Player)
		
		v.ModulePrompt.Enabled = false
		
		if not Player.Character:FindFirstChild("Lighter") and not Player.Backpack:FindFirstChild("Lighter") then
			local itemCloned = game.ServerStorage.Lighter:Clone()
			
			itemCloned.Parent = Player.Character
			v:Destroy()
			return
		end
		
		if Player.Character:FindFirstChild("Lighter") then
			local Item = Player.Character:FindFirstChild("Lighter")
			
			if Item:GetAttribute("Durability") > Durability_New then
				game.ReplicatedStorage.Bricks.FlashSpecify_BetterShape:FireClient(Player, Item, Item:GetAttribute("Durability"), Durability_New)
				return
			end
			
			local CurrentValue = Item:GetAttribute("Durability")
			
			if Item:GetAttribute("Durability") < Durability_New then
				game.ReplicatedStorage.Bricks.FlashSpecify_Swap:FireClient(Player, Item, Item:GetAttribute("Durability"), Durability_New)
				Item:SetAttribute("Durability", Durability_New)
				
				v:SetAttribute("Durability", CurrentValue)
				Durability_New = CurrentValue
			end
		end
		
		if Player.Backpack:FindFirstChild("Lighter") then
			local Item = Player.Backpack:FindFirstChild("Lighter")

			if Item:GetAttribute("Durability") > Durability_New then
				game.ReplicatedStorage.Bricks.FlashSpecify_BetterShape:FireClient(Player, Item, Item:GetAttribute("Durability"), Durability_New)
				return
			end

			local CurrentValue = Item:GetAttribute("Durability")

			if Item:GetAttribute("Durability") < Durability_New then
				game.ReplicatedStorage.Bricks.FlashSpecify_Swap:FireClient(Player, Item, Item:GetAttribute("Durability"), Durability_New)
				Item:SetAttribute("Durability", Durability_New)
                
				v:SetAttribute("Durability", CurrentValue)
				Durability_New = CurrentValue
			end
		end
		
		task.delay(1, function()
			if v then
				v.ModulePrompt.Enabled = true
			end
		end)
		
	end)
end

function module:BatteryAdd(v)
	v.ModulePrompt.Triggered:Connect(function(Player)
		print("Triggered")
		
		if Player.Character:FindFirstChild("Flashlight") then
			local Item = Player.Character:FindFirstChild("Flashlight")

			if Item:GetAttribute("Durability") == 90 or Item:GetAttribute("Durability") == 89 then
				game.ReplicatedStorage.Bricks.FlashSpecify_ChargeMax:FireClient(Player, Item)
				return
			end

			if Item:GetAttribute("Durability") > 60 then
				local number = Item:GetAttribute("DurabilityMax") - Item:GetAttribute("Durability")
				Item:SetAttribute("Durability", Item:GetAttribute("Durability") + number)
				wait()
				game.ReplicatedStorage.Bricks.FlashSpecify_Charge:FireClient(Player, Item, Item:GetAttribute("Durability") - number, Item:GetAttribute("Durability"))
				v:Destroy()
				return
			else
				if Item:GetAttribute("Durability") < 60 then
					Item:SetAttribute("Durability", Item:GetAttribute("Durability") + 30)
					wait()
					game.ReplicatedStorage.Bricks.FlashSpecify_Charge:FireClient(Player, Item, Item:GetAttribute("Durability") - 30, Item:GetAttribute("Durability"))
					v:Destroy()
					return
				end
			end
		end
		
		if Player.Backpack:FindFirstChild("Flashlight") then
			local Item = Player.Backpack:FindFirstChild("Flashlight")
			
			if Item:GetAttribute("Durability") == 90 or Item:GetAttribute("Durability") == 89 then
				game.ReplicatedStorage.Bricks.FlashSpecify_ChargeMax:FireClient(Player, Item)
				return
			end
			
			if Item:GetAttribute("Durability") > 60 then
				local number = Item:GetAttribute("DurabilityMax") - Item:GetAttribute("Durability")
				Item:SetAttribute("Durability", Item:GetAttribute("Durability") + number)
				wait()
				game.ReplicatedStorage.Bricks.FlashSpecify_Charge:FireClient(Player, Item, Item:GetAttribute("Durability") - number, Item:GetAttribute("Durability"))
				v:Destroy()
				return
			else
				if Item:GetAttribute("Durability") < 60 then
					Item:SetAttribute("Durability", Item:GetAttribute("Durability") + 30)
					wait()
					game.ReplicatedStorage.Bricks.FlashSpecify_Charge:FireClient(Player, Item, Item:GetAttribute("Durability") - 30, Item:GetAttribute("Durability"))
					v:Destroy()
					return
				end
			end
		end
		
		game.ReplicatedStorage.EntityInfo.Caption:FireClient(Player, "You have nothing to charge.")
		
	end)
end

return module
