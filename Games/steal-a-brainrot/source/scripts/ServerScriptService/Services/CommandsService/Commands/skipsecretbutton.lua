local MessagingService = game:GetService("MessagingService")
local DataStoreService = game:GetService("DataStoreService")

local ACTIVATE_CHANNEL = "SecretButtonActivate"
local DATASTORE_KEY = "SecretButton_GlobalState"

local module = function(Conch, Config)

	if not Conch or type(Conch.register) ~= "function" then
		warn("Conch missing or invalid")
		return
	end

	Conch.register("skipsecretbutton", {

		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {}
		end,

		callback = function()
			local sessionId = "global_" .. tostring(os.time())

			-- Save to DataStore so it persists across server restarts
			local dsOk, dsErr = pcall(function()
				local store = DataStoreService:GetDataStore(DATASTORE_KEY)
				store:SetAsync("ActiveSession", {
					SessionId = sessionId,
					ActivatedAt = os.time(),
				})
			end)

			if not dsOk then
				warn("[skipsecretbutton] DataStore save failed:", dsErr)
			end

			-- Broadcast to all live servers via MessagingService
			local ok, publishErr = pcall(function()
				MessagingService:PublishAsync(ACTIVATE_CHANNEL, {
					SessionId = sessionId
				})
			end)

			if not ok then
				return "❌ Failed to broadcast: " .. tostring(publishErr)
			end

			return "🔴 Secret Button activated globally (persisted)"
		end,
	})
end

return module