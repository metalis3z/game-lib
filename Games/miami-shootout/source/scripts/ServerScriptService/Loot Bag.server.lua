local lootBagModel = game.ServerStorage.Baggy

local noLoot = {"Admins","SupervisorsONLY","test5","Trophy","Medkit","Bandage","Stretcher","Flash","Smoke","AR-Rifle","G22Switch","Woods","GlockS","G19Switch","G26Switch","Remington","MP5","Shotgun","Fist","LocalFootsteps","Sponge","Baton","BatteringRam","RiotShield","Taser","Baton","Handcuffs","Package","BOX","Box","PrisonMop","Mop","Phone","Building Tools","M4A1","GunPermit"}
local despawnTime = 45

function createBag(player,position)
	if player and position then
		
		local inventoryContents = {}
		
		for i,v in pairs(player.Backpack:GetChildren()) do
			if v:IsA("Tool") and not table.find(noLoot,v.Name) and not v:FindFirstChild("Rank") then
				table.insert(inventoryContents,v.Name)
			end
		end
		
		for i,v in pairs(player.Character:GetChildren()) do
			if v:IsA("Tool") and not table.find(noLoot,v.Name) and not v:FindFirstChild("Rank") then
				table.insert(inventoryContents,v.Name)
			end
		end
		
		if #inventoryContents == 0 then return print("no lootable items") end
		
		local strin = "Item"
		if #inventoryContents ~= 1 then
			strin = "Items"
		end
		
		local lbm = lootBagModel:Clone()
		lbm.CFrame = position
		lbm.Anchored = true
		lbm.CanCollide = false
		lbm.Parent = game.Workspace.Storage
		
		local prompt = lbm.stealprompt
		prompt.ObjectText = player.Name
		lbm.PlayerName.Value = player.Name
		prompt.ActionText = "Loot "..#inventoryContents.." "..strin
		prompt.LootScript.Disabled = false
		
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
				createBag(p,c.PrimaryPart.CFrame)	
			end)
		end
		
	end)
end)