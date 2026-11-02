local ReplicatedStorage = game:GetService("ReplicatedStorage")

local module = function(Conch, Config)
	Conch.register("setgoldcoins", {
		permissions = { Config.RequiredRole or "super-user" },
		
		arguments = function()
			return {
				kind = "argument",
				type = "player",
				name = "Player",
			},
			{
				kind = "argument",
				type = "number",
				name = "Gold Coins",
			}
		end,
		
		callback = function(player, coins)
			coins = coins or 10
			local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
			Synchronizer:Get(player):Set("StPatricksEvent.GoldCoins", coins)	
			return "set"
		end,
	})
end

return module