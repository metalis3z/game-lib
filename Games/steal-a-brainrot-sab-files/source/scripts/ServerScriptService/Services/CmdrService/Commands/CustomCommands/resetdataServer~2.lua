local DataService = require(game.ServerScriptService.Services.DataService)
local Net = require(game.ReplicatedStorage.Packages.Net)
return function(context, players)
	local processed = {}

	for _, player in ipairs(players) do
		if not player or not player.Parent then
			table.insert(processed, "❌ " .. (player and player.Name or "<unknown>") .. " not in server")
			continue
		end

		local success = DataService:ResetData(player)

		if success then
			table.insert(processed, "✅ " .. player.Name)
		else
			table.insert(processed, "❌ " .. player.Name .. " (Failed to reset data)")
		end
	end

	return table.concat(processed, "\n")
end