local module = function(Conch, Config)
	local ServerScriptService = game:GetService("ServerScriptService")
	local Players = game:GetService("Players")

	local CupidsMachineService = require(ServerScriptService.Services.CupidsMachineService)
	local NotificationService = require(ServerScriptService.Services.NotificationService)

	Conch.register("newmatch", {
		permissions = { Config.RequiredRole or "admin" },

		arguments = function()
			return {} 
		end,

		callback = function()
			-- This now triggers the reset and cleans everyone's machine
			CupidsMachineService:ForceRefresh()

			-- Pink name, white text
			local msg = 'Admin has set a new <font color="#FF69B4">Cupid\'s Machine</font> craft'

			for _, player in ipairs(Players:GetPlayers()) do
				NotificationService.Notify(player, msg, 5, "Sounds.Sfx.Success")
			end

			return "Success: Match forced and machines cleared."
		end,
	})
end

return module