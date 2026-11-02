local module = function(Conch, Config)

	local Players = game:GetService("Players")
	local DataStoreService = game:GetService("DataStoreService")
	local BanStore = DataStoreService:GetDataStore("TimeBans_v1")

	-- Helper to handle joining players
	Players.PlayerAdded:Connect(function(player)
		local success, banData = pcall(function()
			return BanStore:GetAsync(tostring(player.UserId))
		end)

		if success and banData then
			local currentTime = os.time()
			if currentTime < banData.EndTime then
				local remaining = math.ceil((banData.EndTime - currentTime) / 60)
				player:Kick("\nBanned for: " .. banData.Reason .. "\nRemaining: " .. remaining .. " minutes")
			else
				-- Ban expired, clean up
				pcall(function()
					BanStore:RemoveAsync(tostring(player.UserId))
				end)
			end
		end
	end)

	Conch.register("Timeban", {
		permissions = { Config.RequiredRole or "super-user" },
		description = "Bans a player from the server for a specific duration (in minutes).",
		hint = "Usage: timeban [Player] [Minutes] [Reason]",

		arguments = function()
			return 
				{
					kind = "argument",
					type = "player",
					name = "Target"
				},
			{
				kind = "argument",
				type = "number",
				name = "Minutes"
			},
			{
				kind = "argument",
				type = "string",
				name = "Reason"
			}
		end,

		callback = function(targetPlayer, minutes, reason)
			if not targetPlayer or typeof(targetPlayer) ~= "Instance" then
				return false, "Invalid player target."
			end

			reason = reason or "No reason provided"
			local durationSeconds = minutes * 60
			local endTime = os.time() + durationSeconds

			local banData = {
				EndTime = endTime,
				Reason = reason
			}

			local success, err = pcall(function()
				BanStore:SetAsync(tostring(targetPlayer.UserId), banData)
			end)

			if success then
				targetPlayer:Kick("\nYou have been banned for " .. minutes .. " minutes.\nReason: " .. reason)
				return "Successfully banned " .. targetPlayer.Name .. " for " .. minutes .. " minutes."
			else
				return false, "DataStore Error: " .. tostring(err)
			end
		end
	})

end

return module