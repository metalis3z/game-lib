local module = function(Conch, Config)
	Conch.register("adddivinespins", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "number",
				name = "Spins",
			}
		end,
		callback = function(amount)
			if amount < 1 then
				return "Amount must be positive"
			end
			local Synchronizer = require(game:GetService("ReplicatedStorage").Packages.Synchronizer)
			local NotificationService = require(game:GetService("ServerScriptService").Services.NotificationService)
			local Players = game:GetService("Players")

			for _, player in Players:GetPlayers() do
				local Data = Synchronizer:Get(player)
				if Data then
					Data:Increase("CursedSpinWheel.Spins", amount)
					NotificationService.Notify(
						player,
						'Admin gave you ' .. amount .. ' <font color=\"#f53838\">Cursed</font> Spins!',
						5,
						"Sounds.Sfx.Success"
					)
				end
			end
			return "added"
		end,
	})
end
return module