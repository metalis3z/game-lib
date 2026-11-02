local module = function(Conch, Config)
	Conch.register("setglobalspin", {
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
			if amount < 0 then
				return false, "Amount must be 0 or positive"
			end
			local Synchronizer = require(game:GetService("ReplicatedStorage").Packages.Synchronizer)
			local NotificationService = require(game:GetService("ServerScriptService").Services.NotificationService)
			local Players = game:GetService("Players")
			for _, player in Players:GetPlayers() do
				local Data = Synchronizer:Get(player)
				if Data then
					Data:Set("RadioactiveSpinWheel.Spins", amount)
					NotificationService.Notify(
						player,
						string.format('Sammy set your Radioactive spins </font></stroke> to <stroke color="#fff"><font color="#43eb34">%d</font></stroke>', amount),
						15,
						"Sounds.Sfx.Success"
					)
				end
			end
			return true, string.format("Set %d spins to all players", amount)
		end,
	})
end
return module