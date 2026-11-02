local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

	Conch.register("setelves", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "number",
				name = "Elves",
			}
		end,

		callback = function(player, amount)
			amount = tonumber(amount)

			if not player or not player:IsA("Player") then
				return false, "Invalid player."
			end

			if not amount then
				return false, "Invalid amount."
			end

			if amount < 0 then
				return false, "Amount cannot be negative."
			end

			local channel = Synchronizer:Get(player)
			if not channel then
				return false, "No data channel for " .. player.Name
			end

			channel:Set("ChristmasEvent.GoldElves", amount)

			return "set"
		end
	})
end

return module