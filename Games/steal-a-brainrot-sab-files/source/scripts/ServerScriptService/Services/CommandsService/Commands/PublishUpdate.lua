local module = function(Conch, Config)
	local MessagingService = game:GetService("MessagingService")
	local DataStoreService = game:GetService("DataStoreService")
	local TeleportService = game:GetService("TeleportService")
	local Players = game:GetService("Players")

	local UPDATE_TOPIC = "GlobalUpdatePublish"
	local RESTART_TOPIC = "GlobalServerRestart"
	
	local PLACE_ID = game.PlaceId
	local updateStore = DataStoreService:GetGlobalDataStore("GameUpdates")

	Conch.register("publishupdate", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "Update",
				name = "update",
			}
		end,
		callback = function(update)
			local success, err = pcall(function()
				updateStore:SetAsync("LatestUpdate", {
					version = update,
					timestamp = os.time(),
				})
			end)

			if not success then
				return "Failed to publish update globally: " .. err
			end

			pcall(function()
				MessagingService:PublishAsync(UPDATE_TOPIC, update)
				MessagingService:PublishAsync(RESTART_TOPIC, update)
			end)

			return "Update '" .. update .. "' published globally and restart triggered on all servers."
		end,
	})

	MessagingService:SubscribeAsync(UPDATE_TOPIC, function(msg)
		pcall(function()
			updateStore:SetAsync("LatestUpdate", {
				version = msg.Data,
				timestamp = os.time(),
			})
		end)
	end)

	MessagingService:SubscribeAsync(RESTART_TOPIC, function(msg)
		local version = msg.Data

		if #Players:GetPlayers() > 0 then
			TeleportService:TeleportAsync(PLACE_ID, Players:GetPlayers())
		end
	end)

end

return module