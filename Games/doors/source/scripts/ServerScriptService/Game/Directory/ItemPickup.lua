local item = {}

-- Created and Fixed by BUILDG Studios

function item.HealItem(v)
	local Prompt = v:FindFirstChild("ModulePrompt")

	Prompt.Triggered:Connect(function(player)
        if player.Character.Humanoid.Health < 100 then
			player.Character.Humanoid.Health = player.Character.Humanoid.Health + math.random(15, 20)
			v:Destroy()
		end
	end)
end

function item.ItemAdd(v, item)
	local Prompt = v:FindFirstChild("ModulePrompt")
	
	Prompt.Triggered:Connect(function(player)
		if not player.Backpack:FindFirstChild(item) and not player.Character:FindFirstChild(item) then
			local itemItem = game:GetService("ServerStorage"):FindFirstChild(item):Clone()
			
			itemItem.Parent = player.Backpack
			wait()
			v:Destroy()
			-- If not in backpack
			
		else
			if item == "Lighter" then
				game.ReplicatedStorage.Bricks.KeyFull:FireClient(player, "Lighter", "x1")
			end
			if item == "Crucifix" then
				game.ReplicatedStorage.Bricks.KeyFull:FireClient(player, "Crucifix", "x1")
			end
			-- If in backpack
		end
	end)
end

function item:DurabilityAdd(v, item)
	local Prompt = v:FindFirstChild("ModulePrompt")
	
	Prompt.Triggered:Connect(function(player)

		if not player.Backpack:FindFirstChild(item) and not player.Character:FindFirstChild(item) then
			local itemInStorage = game.ServerStorage:FindFirstChild(item)
			if itemInStorage then
				local ItemInc = itemInStorage:Clone()
				ItemInc.Parent = player.Backpack
				if ItemInc.Name == "Lighter" then
					local d = math.random(20, 50)
					ItemInc.Durability.Value = d
				else
					ItemInc.Durability.Value = 20
				end
				v:Destroy()
			end
		else
			if item == item then
					local backpackItem = player.Backpack:FindFirstChild(item)
					local characterItem = player.Character:FindFirstChild(item)

					if backpackItem and backpackItem:FindFirstChild("Durability").Value == 60 or characterItem and characterItem:FindFirstChild("Durability").Value == 60 then
						game.ReplicatedStorage.Bricks:FindFirstChild("KeyFull"):FireClient(player, item, "x3")
					elseif backpackItem and backpackItem:FindFirstChild("Durability").Value == 40 then
						backpackItem:FindFirstChild("Durability").Value += 20
						v:Destroy()
					elseif characterItem and characterItem:FindFirstChild("Durability").Value == 40 then
						characterItem:FindFirstChild("Durability").Value += 20
						v:Destroy()
					elseif backpackItem and backpackItem:FindFirstChild("Durability").Value == 20 then
						backpackItem:FindFirstChild("Durability").Value += 20
						v:Destroy()
					elseif characterItem and characterItem:FindFirstChild("Durability").Value == 20 then
						characterItem:FindFirstChild("Durability").Value += 20
						v:Destroy()
					end
				end
			end
	end)
end

return item
