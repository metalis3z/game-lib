local ServerScriptService = game:GetService("ServerScriptService")
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local DataService = require(ServerScriptService.Services.DataService)

return function(context, targetPlayers, confirmation)
	if confirmation ~= "CONFIRM" then
		return "❌ Type 'CONFIRM' to reset data. This wipes the player's data and is IRREVERSIBLE!"
	end

	local executor = context.Executor
	local results = {}

	for _, targetPlayer in ipairs(targetPlayers) do
		local userId = targetPlayer.UserId
		local playerName = targetPlayer.Name
		local storeResults = {}
		local successCount = 0
		local failCount = 0

		local dsSuccess, dsErr = pcall(function()
			DataService:ResetData(targetPlayer)
		end)

		if dsSuccess then
			table.insert(storeResults, "✅ DataService (DataTest123): Success")
			successCount = successCount + 1
		else
			table.insert(storeResults, "❌ DataService: " .. tostring(dsErr))
			failCount = failCount + 1
		end

		task.wait(0.5)

		for _, storeName in ipairs({"DATA-FOR-EVERYONE"}) do
			local success, err = pcall(function()
				local dataStore = DataStoreService:GetDataStore(storeName)
				dataStore:RemoveAsync(userId)
			end)

			if success then
				table.insert(storeResults, string.format("✅ %s: Cleared", storeName))
				successCount = successCount + 1
			else
				table.insert(storeResults, string.format("❌ %s: %s", storeName, tostring(err)))
				failCount = failCount + 1
			end

			task.wait(0.2)
		end

		if targetPlayer.Parent then
			targetPlayer:Kick("Your data has been reset by an administrator. Please rejoin.")
		end

		table.insert(results, string.format(
			"📊 %s (ID: %d)\n✅ Success: %d | ❌ Failed: %d\n%s",
			playerName,
			userId,
			successCount,
			failCount,
			table.concat(storeResults, "\n")
			))
	end

	local finalMessage = string.format(
		"🔄 Data Reset Executed by %s\n\n%s",
		executor.Name,
		table.concat(results, "\n\n")
	)

	print(finalMessage)
	return finalMessage
end
