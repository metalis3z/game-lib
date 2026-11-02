local module = function(Conch, Config)
	Conch.register("addglobalspins", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				{
					kind = "argument",
					type = "number",
					name = "Amount",
				},
			}
		end,
		callback = function(amount)
			if amount < 1 then
				return false, "Amount must be positive"
			end
			local Synchronizer = require(game:GetService("ReplicatedStorage").Packages.Synchronizer)
			local NotificationService = require(game:GetService("ServerScriptService").Services.NotificationService)
			local Players = game:GetService("Players")

			for _, player in Players:GetPlayers() do
				local Data = Synchronizer:Get(player)
				if Data then
					Data:Increase("RadioactiveSpinWheel.Spins", amount)
					NotificationService.Notify(
						player,
						string.format('Sammy gave you <stroke color="#fff"><font color="#fff">%d</font></stroke> Radioacitve <stroke color="#43eb34"><font color="#fff">spins</font></stroke>', amount),
						15,
						"Sounds.Sfx.Success"
					)
				end
			end

			return true, string.format("Gave %d spins to all players", amount)
		end,
	})
end
return module