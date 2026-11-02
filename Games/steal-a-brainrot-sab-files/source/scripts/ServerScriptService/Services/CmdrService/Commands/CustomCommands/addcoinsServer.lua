local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MoneyService = require(ServerScriptService.Services.MoneyService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

return function(context, players, amount, isAdd)

	local successCount = 0
	local failedPlayers = {}

	for _, player in pairs(players) do
		local playerSync = Synchronizer:Get(player)
		if not playerSync then
			table.insert(failedPlayers, player.Name .. " (data not ready)")
			continue
		end

		if isAdd == false then
			MoneyService:Set(player, amount)
		elseif isAdd == true then
			MoneyService:Add(player, amount)
		end

		successCount = successCount + 1
	end

	local actionText = (isAdd == false) and "set" or "added"
	local response = ""

	if successCount > 0 then
		response = string.format("✅ Successfully %s %d coins for %d player%s",
			actionText, amount, successCount, successCount == 1 and "" or "s")
	end

	if #failedPlayers > 0 then
		response = (response ~= "" and response .. "\n" or "") .. "❌ Failed for: " .. table.concat(failedPlayers, ", ")
	end

	return response == "" and "❌ No players were processed" or response
end
