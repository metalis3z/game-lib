local lootBagModel = game.ServerStorage.Baggy

local noLoot = {"MO Ak-47","Fist","LocalFootsteps","Phone","Building Tools","GunPermit", 'ArrestTool', 'GrabTool','TB StabVest', 'MH StabVest', '4M StabVest', 'EOK StabVest', 'GM StabVest', 'DD StabVest', 'RVNG StabVest', 'STB StabVest', 'NR4 StabVest', 'KTA StabVest', 'RED StabVest', 'FNO StabVest', '600 StabVest'}
local despawnTime = 30	

function createBag(player,position)
	if player and position then

		local inventoryContents = {}

		for i,v in pairs(player.Backpack:GetChildren()) do
			if v:IsA("Tool") and not table.find(noLoot,v.Name) and not v:FindFirstChild("Rank") and not v:FindFirstChild('POLICE') then
				table.insert(inventoryContents,v.Name)
			end
		end

		for i,v in pairs(player.Character:GetChildren()) do
			if v:IsA("Tool") and not table.find(noLoot,v.Name) and not v:FindFirstChild("Rank") and not v:FindFirstChild('POLICE') then
				table.insert(inventoryContents,v.Name)
			end
		end

		if #inventoryContents == 0 then return end

		local lbm = lootBagModel:Clone()
		lbm.CFrame = position
		lbm.Anchored = true
		lbm.CanCollide = false
		lbm.Parent = game.Workspace.Storage

		local prompt = lbm.stealprompt
		prompt.ObjectText = player.Name
		lbm.PlayerName.Value = player.Name
		prompt.ActionText = "LOOT"
		lbm.Tag.TextLabel.Text = player.Name .. "'s Loot"
		prompt.LootScript.Enabled = true

		for i,v in pairs(inventoryContents) do		
			local itemName = Instance.new("NumberValue",lbm.Container)
			itemName.Name = v
		end

		game.Debris:AddItem(lbm,despawnTime)

	end
end

game.Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function(c)

		if game.PrivateServerOwnerId == 0 then
			local hum = c:WaitForChild("Humanoid")
			wait()
			hum.Died:Connect(function()
				if c:FindFirstChild('RightLowerLeg') then
					createBag(p,c.RightLowerLeg.CFrame)
				elseif c:FindFirstChild('UpperTorso') then
					createBag(p,c.UpperTorso.CFrame)	
				end
			end)
		end

	end)
end)