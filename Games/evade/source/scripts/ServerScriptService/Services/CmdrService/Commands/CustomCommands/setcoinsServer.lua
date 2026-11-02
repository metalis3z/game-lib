return function(context, player, num)
	local Synchronizer = require(game.ReplicatedStorage.Packages.Synchronizer)
	if type(num) ~= "number" or num <= 0 then
		return "❌ Amount must be a positive number."
	end

	local PlayerChannel = Synchronizer:Get(player)
	if not PlayerChannel then
		return "❌ Failed to get save for " .. player.Name
	end

	PlayerChannel:Set("Coins", num)

	return "✅ Set " .. player.Name .. "'s coins to " .. tostring(num) .. "!"
end
