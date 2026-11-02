local module = function(Conch, Config)
	Conch.register("resetdata", {
		permissions = { Config.RequiredRole or "CustomAdmin" },

		arguments = function()
			return {
				kind = "argument",
				type = "players",
				name = "players",
				description = "The player or players whose data will be wiped and regenerated"
			}
		end,

		callback = function(players)
			if not players or #players == 0 then
				return false, "❌ You must specify at least one player."
			end
			local DataService
			local success, err = pcall(function()
				DataService = require(game.ServerScriptService.Services.DataService)
			end)

			if not success or not DataService then
				return false, "❌ DataService not found: " .. tostring(err)
			end
			local processed = {}
			for _, player in ipairs(players) do
				if not player or not player.Parent then
					table.insert(processed, "❌ " .. (player and player.Name or "<unknown>") .. " not in server")
					continue
				end

				local resetSuccess = DataService:ResetData(player)

				if resetSuccess then
					table.insert(processed, "✅ " .. player.Name)
					local ReplicatedStorage = game:GetService("ReplicatedStorage")
					local Net = require(ReplicatedStorage.Packages.Net)
					local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

					if NotificationEvent then
						local msg = "<font color='#FF0000'>Your data has been reset by an admin. You will be kicked and your data will regenerate.</font>"
						NotificationEvent:FireClient(player, msg, 10, "Sounds.Sfx.Warn")
					end
					task.delay(1, function()
						if player and player.Parent then
							player:Kick("Your data has been reset. Please rejoin to regenerate your data.")
						end
					end)
				else
					table.insert(processed, "❌ " .. player.Name .. " (Failed to reset data)")
				end
			end

			return table.concat(processed, "\n")
		end
	})
	Conch.register("resetplayerdata", {
		alias = "resetdata"
	})
	Conch.register("datareset", {
		alias = "resetdata"
	})
	Conch.register("wipeplayer", {
		alias = "resetdata"
	})
end
return module