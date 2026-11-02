local module = function(Conch, Config)
	local TeleportService = game:GetService("TeleportService")
	local Players = game:GetService("Players")

	Conch.register("teleportalltotradingplaza", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return nil
		end,

		callback = function()
			local players = Players:GetPlayers()

			if #players == 0 then
				return false, "No players to teleport"
			end

			for _, player in ipairs(players) do
				TeleportService:Teleport(86027170414765, player)
			end

			return "teleported"
		end
	})
end

return module