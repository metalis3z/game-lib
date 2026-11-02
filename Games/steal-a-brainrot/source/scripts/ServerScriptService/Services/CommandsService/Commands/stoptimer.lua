local module = function(Conch, Config)
	local MessagingService = game:GetService("MessagingService")
	local MemoryStoreService = game:GetService("MemoryStoreService")

	local TOPIC = "GlobalTimerUpdate_v1"
	local MAP_NAME = "GlobalTimerState_v1"
	local map = MemoryStoreService:GetSortedMap(MAP_NAME)

	Conch.register("stoptimer", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
		end,

		callback = function()
			local data = {
				running = false,
				title = "",
				endTime = 0,
			}

			pcall(function()
				map:SetAsync("Current", data, 120)
			end)

			local ok, err = pcall(function()
				MessagingService:PublishAsync(TOPIC, data)
			end)

			if not ok then
				return false, "MessagingService error: " .. tostring(err)
			end

			return "Timer stopped everywhere"
		end,
	})
end

return module