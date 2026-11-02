local module = function(Conch, Config)
	local Players = game:GetService("Players")
	local TeleportService = game:GetService("TeleportService")
	local PlacesService = require(game.ServerScriptService.Services.PlacesService)

	Conch.register("teleportalltoprivateserver", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return nil
		end,

		callback = function()
			local players = Players:GetPlayers()
			local targetPlaceId = game.PlaceId 

			-- Replace with your actual Private Server Access Code
			local privateServerId = "YourPrivateServerId" 

			if #players == 0 then
				return false, "No players found to teleport"
			end

			local success, err = pcall(function()
				TeleportService:TeleportToPrivateServer(targetPlaceId, privateServerId, players)
			end)

			if success then
				return "Teleporting all players to the private server..."
			else
				warn("Teleport error: " .. tostring(err))
				return false, "Teleport failed: " .. tostring(err)
			end
		end
	})
end

return module