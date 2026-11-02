local ih = require(game.ServerScriptService.InventoryHandler)
local skipsmanager = require(game:GetService("ServerScriptService").SkipHandler)
local ugcmanager = require(game:GetService("ServerScriptService").UGCHandler)
local rebirthmanager = require(game.ServerScriptService:WaitForChild("RebirthHandler"))
local rs = game:GetService("ReplicatedStorage")

local lastResponseTimes = {}

rs.RemoteEvents.clientTP.OnServerEvent:Connect(function(player)
	rs.RemoteEvents.clientTP:FireClient(player)
end)

rs.RemoteEvents.callForRebirth.OnServerEvent:Connect(function(player)
	rebirthmanager.Rebirth(player)
end)

rs.RemoteEvents.callForReset.OnServerEvent:Connect(function(player)
	rebirthmanager.Reset(player)
end)

rs.RemoteEvents.crateRequest.OnServerEvent:Connect(function(player)
	if player:WaitForChild("leaderstats").Coins.Value >= 3000 then
		local lastResponseTime = lastResponseTimes[player]
		local currentTime = tick()

		if not lastResponseTime or (currentTime - lastResponseTime >= 1) then
			local item, duplicate = ih.SpinZachsBox(player)
			local rarity = ih.GetItemRarity(item)
			if duplicate then
				--game.ServerScriptService.StageUpdater.CoinTake:Fire(player, 1500)
				--rs.RemoteEvents.cashNotification:FireClient(player, "1500")
			end
			rs.RemoteEvents.crateRequest:FireClient(player, item, rarity, duplicate)

			lastResponseTimes[player] = currentTime
		else
			rs.RemoteEvents.cooldownMessage:FireClient(player)
		end
	end
end)

rs.RemoteEvents.neonCrateRequest.OnServerEvent:Connect(function(player)
	if player:WaitForChild("leaderstats").Coins.Value >= 3500 then
		local lastResponseTime = lastResponseTimes[player]
		local currentTime = tick()

		if not lastResponseTime or (currentTime - lastResponseTime >= 1) then
			local item, duplicate = ih.SpinNeonBox(player)
			local rarity = ih.GetItemRarity(item)
			if duplicate then
				--game.ServerScriptService.StageUpdater.CoinTake:Fire(player, 1500)
				--rs.RemoteEvents.cashNotification:FireClient(player, "1500")
			end
			rs.RemoteEvents.crateRequest:FireClient(player, item, rarity, duplicate)

			lastResponseTimes[player] = currentTime
		else
			rs.RemoteEvents.cooldownMessage:FireClient(player)
		end
	end
end)

rs.RemoteEvents.ugcCrateRequest.Event:Connect(function(player)
		local lastResponseTime = lastResponseTimes[player]
		local currentTime = tick()

			local item, duplicate, typeOfItem = ih.SpinUGCBox(player)
			local rarity = ih.GetItemRarity(item)
			if duplicate then
				--game.ServerScriptService.StageUpdater.CoinTake:Fire(player, 1500)
				--rs.RemoteEvents.cashNotification:FireClient(player, "1500")
			end
			rs.RemoteEvents.crateRequest:FireClient(player, item, rarity, duplicate, typeOfItem)

			lastResponseTimes[player] = currentTime
end)

rs.RemoteFunctions.fetchInventory.OnServerInvoke = function(player)
	local inventory = ih.GetInventory(player)
	return inventory
end

rs.RemoteFunctions.fetchUGC.OnServerInvoke = function(player)
	local inventory = ugcmanager.GetUGC(player)
	return inventory
end

rs.RemoteEvents.buyUGC.OnServerEvent:Connect(function(player, ugcID)
	local ownedUGC = ugcmanager.GetUGC(player)
	print(ugcID)
	print((ownedUGC))
	print("recieved ugc request")
	if table.find(ownedUGC, ugcID) then
		pcall(function()
			game:GetService("MarketplaceService"):PromptPurchase(player, ugcID)
		end)
	else
		print("doesn't have perms")
	end
end)

rs.RemoteFunctions.fetchRarity.OnServerInvoke = function(player, item)
	local rarity = ih.GetItemRarity(item)
	return rarity
end

rs.RemoteFunctions.fetchEquipped.OnServerInvoke = function(player)
	local equipped = ih.GetEquippedItem(player)
	return equipped
end

rs.RemoteEvents.updateEquip.OnServerEvent:Connect(function(player, item)
	ih.EquipItem(player, item)
end)

rs.RemoteFunctions.fetchSkips.OnServerInvoke = function(player)
	local equipped = skipsmanager.GetSkips(player)
	return equipped
end

rs.RemoteEvents.skipStage.OnServerEvent:Connect(function(player)
	skipsmanager.SkipStage(player)
end)