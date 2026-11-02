local ds2 = require(game.ReplicatedStorage.ModuleScripts.DataStore2)
local ugcHandler = require(game.ServerScriptService.UGCHandler)
ds2.Combine("DATA", "inventory")
ds2.Combine("DATA", "equip")

local module = {}

function module.GetInventory(player)
	local inventoryStore = ds2("inventory", player)
	local inventory = inventoryStore:Get({"default"})

	return inventory
end

function module.AddItemToInventory(player, item)
	local inventoryStore = ds2("inventory", player)
	local inventory = inventoryStore:Get({"default"})
	if not table.find(inventory, item) then
		table.insert(inventory, item)
	end
	inventoryStore:Set(inventory)
	inventoryStore:Save()
	game:GetService("ReplicatedStorage").RemoteEvents.callForUpdate:FireClient(player)
	return inventory
end

function module.RemoveFromInventory(player, item)
	local inventoryStore = ds2("inventory", player)
	local inventory = inventoryStore:Get({"default"})
	if table.find(inventory, item) then
		local numberOf = table.find(inventory, item)
		table.remove(inventory, numberOf)
	end
	inventoryStore:Set(inventory)
	inventoryStore:Save()
	game:GetService("ReplicatedStorage").RemoteEvents.callForUpdate:FireClient(player)
	return inventory
end

function module.HasItem(player, item)
	local inventoryStore = ds2("inventory", player)
	local inventory = inventoryStore:Get({"default"})
	local equippedStore = ds2("equip", player)
	if table.find(inventory, item) then
		return true
	else
		return false
	end
end
function module.EquipItem(player, item)
	local inventoryStore = ds2("inventory", player)
	local inventory = inventoryStore:Get({"default"})
	local equippedStore = ds2("equip", player)
	if table.find(inventory, item) then
		equippedStore:Set(item)
		equippedStore:Save()
		workspace.Ignore:FindFirstChild(player.Name .. "Scooter"):Destroy()
		game.ServerScriptService.Server.ScooterEventServer2Server:Fire(player, item)
		game:GetService("ReplicatedStorage").RemoteEvents.updateEquip:FireClient(player, item)
	end
end

function module.GetEquippedItem(player)
	local equippedStore = ds2("equip", player)
	local equipped = equippedStore:Get("default")
	return equipped
end

function module.GetItemRarity(item)
	local commons = {"PastelPinkScooter", "PerfectPurpleScooter", "RagingRedScooter", "BlazingBlueScooter", "GrassGreenScooter", "default", "NeonOrange", "NeonRed", "NeonYellow"}
	local uncommons = {"WhiteoutScooter", "PitchBlackScooter", "GreyscaleScooter", "BasedBrownScooter", "NeonBlue", "NeonGreen"}
	local rares = {"BlindingBronzeScooter", "ShinySilverScooter", "GorgeousGoldScooter", "NeonPink", "NeonPurple"}
	local epics = {"ElectrifiedScooter", "InfernoScooter", "NeonCyan", "PlasmaIce"}
	local legendaries = {"ShockwaveScooter"}
	local mythics = {"ThrusterScooter", "ForestScooter"}
	local admins = {"ZxchDevSkin"}
	local rebirths = {}
	local ugcs = {"15408537325", "15435904810", "15507854541", "15549797700", "15549647158"}
	if table.find(commons, item) then
		return "Common"
	end
	if table.find(uncommons, item) then
		return "Uncommon"
	end
	if table.find(rares, item) then
		return "Rare"
	end
	if table.find(epics, item) then
		return "Epic"
	end
	if table.find(legendaries, item) then
		return "Legendary"
	end
	if table.find(mythics, item) then
		return "Mythic"
	end
	if table.find(admins, item) then
		return "Admin"
	end
	if table.find(rebirths, item) then
		return "Rebirth"
	end
	if table.find(ugcs, item) then
		return "UGC"
	end
	return nil
end

local playerCooldowns = {}

function module.SpinZachsBox(player)
	local choice
	local duplicate = false
	if playerCooldowns[player] and tick() - playerCooldowns[player] < 1 then
		print(player.Name .. " must wait before spinning again.")
		return
	end

	if player:WaitForChild("leaderstats").Coins.Value >= 3000 then
		game.ServerScriptService.StageUpdater.CoinTake:Fire(player, -3000)
		local random1 = math.random(1, 100)
		local rarity = "commons"
		if random1 <= 60 then
			rarity = "commons"
		elseif random1 <= 85 then
			rarity = "uncommons"
		elseif random1 <= 95 then
			rarity = "rares"
		elseif random1 <= 99 then
			rarity = "epics"
		elseif random1 <= 100 then
			rarity = "legendaries"
		end

		local commons = {"PastelPinkScooter", "PerfectPurpleScooter", "RagingRedScooter", "BlazingBlueScooter", "GrassGreenScooter"}
		local uncommons = {"WhiteoutScooter", "PitchBlackScooter", "GreyscaleScooter", "BasedBrownScooter"}
		local rares = {"BlindingBronzeScooter", "ShinySilverScooter", "GorgeousGoldScooter"}
		local epics = {"ElectrifiedScooter", "InfernoScooter"}
		local legendaries = {"ShockwaveScooter", "NeonPlasma"}

		if rarity == "commons" then
			choice = commons[math.random(1, #commons)]
		elseif rarity == "uncommons" then
			choice = uncommons[math.random(1, #uncommons)]
		elseif rarity == "rares" then
			choice = rares[math.random(1, #rares)]
		elseif rarity == "epics" then
			choice = epics[math.random(1, #epics)]
		elseif rarity == "legendaries" then
			choice = legendaries[math.random(1, #legendaries)]
		end
		if table.find(module.GetInventory(player), choice) then
			duplicate = true
		end
		module.AddItemToInventory(player, choice)
		print(player.Name .. " has unboxed a " .. choice .. " which is " .. rarity .. " rarity. The RNG for their rarity was " .. random1 .. " and it was a Zach's Box.")
		playerCooldowns[player] = tick()
	end
	return choice, duplicate
end

function module.SpinNeonBox(player)
	local choice
	local duplicate = false
	if playerCooldowns[player] and tick() - playerCooldowns[player] < 1 then
		print(player.Name .. " must wait before spinning again.")
		return
	end

	if player:WaitForChild("leaderstats").Coins.Value >= 3500 then
		game.ServerScriptService.StageUpdater.CoinTake:Fire(player, -3500)
		local random1 = math.random(1, 100)
		local rarity = "commons"
		if random1 <= 60 then
			rarity = "commons"
		elseif random1 <= 85 then
			rarity = "uncommons"
		elseif random1 <= 95 then
			rarity = "rares"
		elseif random1 <= 99 then
			rarity = "epics"
		elseif random1 <= 100 then
			rarity = "legendaries"
		end

		local commons = {"NeonOrange", "NeonRed", "NeonYellow"}
		local uncommons = {"NeonBlue", "NeonGreen"}
		local rares = {"NeonPink", "NeonPurple"}
		local epics = {"NeonCyan", "PlasmaIce"}
		local legendaries = {"NeonPlasma"}

		if rarity == "commons" then
			choice = commons[math.random(1, #commons)]
		elseif rarity == "uncommons" then
			choice = uncommons[math.random(1, #uncommons)]
		elseif rarity == "rares" then
			choice = rares[math.random(1, #rares)]
		elseif rarity == "epics" then
			choice = epics[math.random(1, #epics)]
		elseif rarity == "legendaries" then
			choice = legendaries[math.random(1, #legendaries)]
		end
		if table.find(module.GetInventory(player), choice) then
			duplicate = true
		end
		module.AddItemToInventory(player, choice)
		print(player.Name .. " has unboxed a " .. choice .. " which is " .. rarity .. " rarity. The RNG for their rarity was " .. random1 .. " and it was a Neon Box.")
		playerCooldowns[player] = tick()
	end
	return choice, duplicate
end

function module.SpinPremiumBox(player)
	local choice

	if playerCooldowns[player] and tick() - playerCooldowns[player] < 1 then
		print(player.Name .. " must wait before spinning again.")
		return
	end

		local random1 = math.random(1, 100)
		local rarity = "commons"
		if random1 <= 63 then
			rarity = "rares"
		elseif random1 <= 86 then
			rarity = "epics"
		elseif random1 <= 100 then
			rarity = "legendaries"
		end

		local commons = {"PastelPinkScooter", "PerfectPurpleScooter", "RagingRedScooter", "BlazingBlueScooter", "GrassGreenScooter"}
		local uncommons = {"WhiteoutScooter", "PitchBlackScooter", "GreyscaleScooter", "BasedBrownScooter"}
		local rares = {"BlindingBronzeScooter", "ShinySilverScooter", "GorgeousGoldScooter"}
		local epics = {"ElectrifiedScooter", "InfernoScooter"}
		local legendaries = {"ShockwaveScooter"}

		if rarity == "commons" then
			choice = commons[math.random(1, #commons)]
		elseif rarity == "uncommons" then
			choice = uncommons[math.random(1, #uncommons)]
		elseif rarity == "rares" then
			choice = rares[math.random(1, #rares)]
		elseif rarity == "epics" then
			choice = epics[math.random(1, #epics)]
		elseif rarity == "legendaries" then
			choice = legendaries[math.random(1, #legendaries)]
	end
	local duplicate = false
	if table.find(module.GetInventory(player), choice) then
		duplicate = true
	end
		module.AddItemToInventory(player, choice)
		print(player.Name .. " has unboxed a " .. choice .. " which is " .. rarity .. " rarity. The RNG for their rarity was " .. random1 .. " and it was a premium box.")
		playerCooldowns[player] = tick()
	return choice, duplicate
end

function module.SpinPremiumNeonBox(player)
	local choice

	if playerCooldowns[player] and tick() - playerCooldowns[player] < 1 then
		print(player.Name .. " must wait before spinning again.")
		return
	end

	local random1 = math.random(1, 100)
	local rarity = "commons"
	if random1 <= 63 then
		rarity = "rares"
	elseif random1 <= 86 then
		rarity = "epics"
	elseif random1 <= 100 then
		rarity = "legendaries"
	end

	local commons = {"NeonOrange", "NeonRed", "NeonYellow"}
	local uncommons = {"NeonBlue", "NeonGreen"}
	local rares = {"NeonPink", "NeonPurple"}
	local epics = {"NeonCyan", "PlasmaIce"}
	local legendaries = {"NeonPlasma"}

	if rarity == "commons" then
		choice = commons[math.random(1, #commons)]
	elseif rarity == "uncommons" then
		choice = uncommons[math.random(1, #uncommons)]
	elseif rarity == "rares" then
		choice = rares[math.random(1, #rares)]
	elseif rarity == "epics" then
		choice = epics[math.random(1, #epics)]
	elseif rarity == "legendaries" then
		choice = legendaries[math.random(1, #legendaries)]
	end
	local duplicate = false
	if table.find(module.GetInventory(player), choice) then
		duplicate = true
	end
	module.AddItemToInventory(player, choice)
	print(player.Name .. " has unboxed a " .. choice .. " which is " .. rarity .. " rarity. The RNG for their rarity was " .. random1 .. " and it was a premium box.")
	playerCooldowns[player] = tick()
	return choice, duplicate
end

function module.SpinUGCBox(player)
	local choice
	local duplicate = false
	local typeOfItem = "Scooter"
		local random1 = math.random(1, 100)
		local rarity = "commons"
		if random1 <= 15 then -- 35
			rarity = "epics"
		elseif random1 <= 50 then -- 50
			rarity = "legendaries"
		else
			rarity = "ugcs"
			typeOfItem = "UGC"
		end

		local epics = {"ElectrifiedScooter", "InfernoScooter"}
		local legendaries = {"ShockwaveScooter"}
		local ugcs = {"15435904810", "15507854541", "15549797700", "15549647158"}

		if rarity == "epics" then
			choice = epics[math.random(1, #epics)]
		elseif rarity == "legendaries" then
			choice = legendaries[math.random(1, #legendaries)]
		elseif rarity == "ugcs" then
			choice = ugcs[math.random(1, #ugcs)]
		end
		
		if table.find(module.GetInventory(player), choice) then
			duplicate = true
		end
		if rarity ~= "ugcs" then
			module.AddItemToInventory(player, choice)
			print(player.Name .. " has unboxed a " .. choice .. " which is " .. rarity .. " rarity. The RNG for their rarity was " .. random1 .. " and it was a UGC Box.")
		else
			ugcHandler.GiveUGC(player, choice)
			print(player.Name .. " has unboxed a UGC item. " .. " The RNG for their rarity was " .. random1 .. " and it was a UGC Box.")
		end
		playerCooldowns[player] = tick()
	return choice, duplicate, typeOfItem
end


return module
