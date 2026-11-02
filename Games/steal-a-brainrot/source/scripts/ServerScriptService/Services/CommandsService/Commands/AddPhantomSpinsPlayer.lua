local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")
	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

	Conch.register("addPhantomSpinsPlayer", {
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
				name = "Spins",
			}
		end,

		callback = function(player, amount)
			amount = tonumber(amount)
			if not player or not player:IsA("Player") or not amount then
				return false, "Invalid player or amount"
			end

			local playerChannel = Synchronizer:Get(player)
			if not playerChannel then
				return false, "Player channel not found"
			end

			playerChannel:Increase("PhantomSpinWheel.Spins", amount)
			return "added"
		end
	})
end

return module