local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local NotificationService = require(ServerScriptService.Services.NotificationService)

return function(context, players, amount)
	if not amount or amount <= 0 then
		return "❌ Amount must be a positive number!"
	end

	local successCount = 0
	local failedPlayers = {}

	for _, player in pairs(players) do
		local playerChannel = Synchronizer:Get(player)
		if playerChannel then
			playerChannel:Increase("RadioactiveSpinWheel.Spins", amount)
			NotificationService.Notify(
				player,
				context.Executor.Name .. ' got a <font color="#91001b">' .. amount .. '</font> free spin(s) in the <font color="#91001b">Christmas</font>',
				10,
				"Sounds.Sfx.Success"
			)
			successCount += 1
		else
			table.insert(failedPlayers, player.Name .. " (data not loaded)")
		end
	end

	return string.format("✅ Added %d spins to %d player(s)!", amount, successCount)
end