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