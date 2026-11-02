local module = function(Conch, Config)
	local MessagingService = game:GetService("MessagingService")
	local MemoryStoreService = game:GetService("MemoryStoreService")

	local TOPIC = "GlobalTimerUpdate_v1"
	local MAP_NAME = "GlobalTimerState_v1"
	local map = MemoryStoreService:GetSortedMap(MAP_NAME)

	Conch.register("updatetimer", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "string",
					name = "Title",
				},
			{
				kind = "argument",
				type = "number",
				name = "Hours",
			},
			{
				kind = "argument",
				type = "number",
				name = "Minutes",
				optional = true,
			},
			{
				kind = "argument",
				type = "number",
				name = "Seconds",
				optional = true,
			}
		end,

		callback = function(title, hours, minutes, seconds)
			title = tostring(title or "UPDATE IN")

			hours = tonumber(hours) or 0
			minutes = tonumber(minutes) or 0
			seconds = tonumber(seconds) or 0

			if hours < 0 or minutes < 0 or seconds < 0 then
				return false, "Time values cannot be negative"
			end

			if minutes > 59 then
				return false, "Minutes must be between 0 and 59"
			end

			if seconds > 59 then
				return false, "Seconds must be between 0 and 59"
			end

			local totalSeconds = (hours * 3600) + (minutes * 60) + seconds
			local endTime = workspace:GetServerTimeNow() + totalSeconds

			local data = {
				running = true,
				title = title,
				endTime = endTime,
			}

			local ok1, err1 = pcall(function()
				map:SetAsync("Current", data, math.max(totalSeconds + 60, 120))
			end)

			if not ok1 then
				return false, "MemoryStore error: " .. tostring(err1)
			end

			local ok2, err2 = pcall(function()
				MessagingService:PublishAsync(TOPIC, data)
			end)

			if not ok2 then
				return false, "MessagingService error: " .. tostring(err2)
			end

			return ("Started global timer: %s (%dh %dm %ds)"):format(title, hours, minutes, seconds)
		end,
	})
end

return module