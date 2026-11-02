if script.Parent.Parent:GetAttribute("isEvent") then
	local Module = require(script.Parent.Parent.Parent.DataModule)
	local EventInfoService = require(game.ReplicatedStorage.SharedServices.EventInfoService)
	local DataTable = Module.GetDataTable()
	local function CountCollectedRareEggs(player)
		local eggs = DataTable[player.Name]["Summer2024"].RareEggs2025 or {}
		local count = 0
		for _, has in pairs(eggs) do
			if has then count += 1 end
		end
		return count
	end
	local CurrentEvent = EventInfoService.GetCurrentEvent()
	CurrentEvent.Remotes.ClaimTrackReward.OnServerEvent:Connect(function(player: Player, index, trackKey) 
		local eventData = DataTable[player.Name]["Summer2024"]
		local rewardList = EventInfoService.GetCurrentEvent().RewardTracks[trackKey].Rewards
		local reward = rewardList[index]
		local key = reward.ItemName .. index
		if eventData.Claimed[key] then return end
		if trackKey == "RareEggs" then
			if CountCollectedRareEggs(player) < reward.Cost then return end
		else
			if eventData.Eggs2025 < reward.Cost then return end
		end
		eventData.Claimed[key] = true
		Module.GiveItem(player, reward.ItemName, 1, reward.Type)
		if reward.Type == "Weapon" or reward.Type == "Pets" then
			Module.GiveItem(player,reward.ItemName,1,reward.Type);
			game.ReplicatedStorage.ItemGift:FireClient(player,reward.ItemName,reward.Type);
		else
			Module.GiveOther(player,reward.ItemName,reward.Type);
		end;
		game.ReplicatedStorage.ItemGift:FireClient(player, reward.ItemName, reward.Type)
	end)
	--[[
	local Products = {};
	local Purchases = {};
	game:GetService("MarketplaceService").ProcessReceipt = function(ReceiptInfo)
		local Player = game.Players:GetPlayerByUserId(ReceiptInfo.PlayerId)
		local Key = ReceiptInfo.PlayerId .. ":" .. ReceiptInfo.PurchaseId
		if Purchases[Key] then
			return Enum.ProductPurchaseDecision.PurchaseGranted
		end
		if Player then
			if EventInfoService.GetCurrentEvent().Active then
				for Amount,ProductID in pairs(Products[EventInfoService.GetEventCurrency()]) do
					if ReceiptInfo.ProductId == ProductID then
						Purchases[Key] = true;
						Module.GiveItem(Player,EventInfoService.GetEventCurrency(),tonumber(Amount), "Materials");
						return Enum.ProductPurchaseDecision.PurchaseGranted	
					end
				end
			end
		end;
	end	
]]
else
	return
end

