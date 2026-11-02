--Hi! , This Code Was Made by FaypleStudios , by owner @fayple1
--pls do not steal my code , good luck with using it
--pushserverluck script was obsusfucated bc this script is so op
--dm me to buy this command script [200-250 robux , if im in a good mood 100-150]

local module = function(Conch, Config)
	local Players = game:GetService("Players")

	Conch.register("kick", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "players",
				name = "Players",
				description = "The players to kick",
			}
		end,
		callback = function(players)
			for _, player in pairs(players) do
				player:Kick("Kicked by admin.")
			end
			return true, string.format("Kicked %d player(s).", #players)
		end,
	})
end

return module