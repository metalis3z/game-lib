local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local Conch = require(ReplicatedStorage.Packages.Conch)

local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local module = function(_, Config)

	Conch.register("playerannounce", {
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
				type = "string",
				name = "text",
			}
		end,

		callback = function(player, text)
			if not player then
				return "Player not found"
			end

			if not text or text == "" then
				return "You must provide announcement text"
			end

			require(ServerScriptService.Services.NotificationService).Notify(
				player,
				text,
				5,
				"Sounds.Sfx.Blop",
				"Top"
			)

			return "announced to player"
		end,
	})

end

return module