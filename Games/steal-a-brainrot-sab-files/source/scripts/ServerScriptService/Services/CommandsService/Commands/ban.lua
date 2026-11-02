local module = function(Conch, Config)
	local Players = game:GetService("Players")
	local DataStoreService = game:GetService("DataStoreService")
	local HttpService = game:GetService("HttpService")

	local BanStore = DataStoreService:GetDataStore("BansV2")

	local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/REDACTED"

	local function sendWebhook(title, description)
		if DISCORD_WEBHOOK == "" then return end

		local payload = {
			embeds = {{
				title = title,
				description = description,
				color = 16711680,
				timestamp = DateTime.now():ToIsoDate()
			}}
		}

		pcall(function()
			HttpService:PostAsync(
				DISCORD_WEBHOOK,
				HttpService:JSONEncode(payload),
				Enum.HttpContentType.ApplicationJson
			)
		end)
	end

	Conch.register("ban", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "string",
					name = "Player",
				},
			{
				kind = "argument",
				type = "string",
				name = "Reason",
			}
		end,

		callback = function(targetName, reason)
			local userId
			local success, err = pcall(function()
				userId = Players:GetUserIdFromNameAsync(targetName)
			end)

			if not success or not userId then
				return false, ("player '%s' not found."):format(targetName)
			end

			local banData = {
				Reason = reason,
				Time = os.time(),
			}

			local ok, storeErr = pcall(function()
				BanStore:SetAsync(userId, banData)
			end)

			if not ok then
				return false, storeErr
			end

			local onlinePlayer = Players:GetPlayerByUserId(userId)
			if onlinePlayer then
				onlinePlayer:Kick(("you are banned.\nReason: %s"):format(reason))
			end

			sendWebhook(
				"Player banned",
				("**Player:** %s\n**UserId:** %d\n**Reason:** %s")
					:format(targetName, userId, reason)
			)

			return ("banned %s: %s"):format(targetName, reason)
		end,
	})

	Conch.register("unban", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "string",
					name = "Player",
				}
		end,

		callback = function(targetName)
			local userId
			local success, err = pcall(function()
				userId = Players:GetUserIdFromNameAsync(targetName)
			end)

			if not success or not userId then
				return false, ("Player '%s' not found."):format(targetName)
			end

			local ok, storeErr = pcall(function()
				BanStore:RemoveAsync(userId)
			end)

			if not ok then
				return false, storeErr
			end

			sendWebhook(
				"Player unbanned",
				("**Player:** %s\n**UserId:** %d")
					:format(targetName, userId)
			)

			return ("unbanned %s"):format(targetName)
		end,
	})
end

return module