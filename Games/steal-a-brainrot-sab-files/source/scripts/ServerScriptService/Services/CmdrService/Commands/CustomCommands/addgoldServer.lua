local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GoldCoinService = require(ServerScriptService.Services.BunnyCoinsService) 

return function(context, players, amount, isAdd)

	local successCount = 0
	local failedPlayers = {}

	for _, player in pairs(players) do
		local previousBalance = GoldCoinService:Get(player)

		if isAdd == false then
			GoldCoinService:Set(player, amount)
		else
			GoldCoinService:Add(player, amount)
		end

		task.wait(0.1)

		local newCoins = GoldCoinService:Get(player)

		local success = false
		if isAdd == false then
			success = (newCoins == math.min(amount, 50000))
		else
			success = (amount == 0) or (newCoins ~= previousBalance)
		end

		if success then
			successCount = successCount + 1
		else
			table.insert(failedPlayers, player.Name .. " (Sync failure)")
		end
	end

	local actionText = (isAdd == false) and "set" or "added"
	local response = ""

	if successCount > 0 then
		response = string.format("💰 Successfully %s %d Gold Coins for %d player%s", 
			actionText, amount, successCount, successCount == 1 and "" or "s")
	end

	if #failedPlayers > 0 then
		local failList = table.concat(failedPlayers, ", ")
		response = (response ~= "" and response .. "\n" or "") .. "❌ Failed for: " .. failList
	end

	return response == "" and "❌ No players were processed" or response
end