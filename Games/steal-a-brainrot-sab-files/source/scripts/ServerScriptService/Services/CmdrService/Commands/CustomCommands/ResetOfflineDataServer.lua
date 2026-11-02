local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local DATASTORES = {
	"DATA-FOR-EVERYONE",
	"Data",
	"DataTest123"
}

return function(context, userId, confirmation)
	if confirmation ~= "CONFIRM" then
		return "❌ Type 'CONFIRM' to reset data."
	end

	local playerName = "[Unknown]"
	pcall(function()
		playerName = Players:GetNameFromUserIdAsync(userId)
	end)

	local onlinePlayer = Players:GetPlayerByUserId(userId)
	if onlinePlayer then
		return string.format(
			"⚠️ %s is currently ONLINE. Use '!resetdata %s CONFIRM' instead.",
			playerName,
			onlinePlayer.Name
		)
	end

	local results = {}
	local successCount = 0
	local failCount = 0

	for _, storeName in ipairs(DATASTORES) do
		local success, err = pcall(function()
			local dataStore = DataStoreService:GetDataStore(storeName)
			dataStore:RemoveAsync(userId)
		end)

		if success then
			table.insert(results, string.format("✅ %s: Cleared", storeName))
			successCount = successCount + 1
		else
			table.insert(results, string.format("❌ %s: %s", storeName, tostring(err)))
			failCount = failCount + 1
		end

		task.wait(0.2)
	end

	local finalMessage = string.format(
		"🔄 Offline Data Reset\nTarget: %s (ID: %d)\nExecutor: %s\n✅ Success: %d | ❌ Failed: %d\n\n%s",
		playerName,
		userId,
		context.Executor.Name,
		successCount,
		failCount,
		table.concat(results, "\n")
	)

	print(finalMessage)
	return finalMessage
end