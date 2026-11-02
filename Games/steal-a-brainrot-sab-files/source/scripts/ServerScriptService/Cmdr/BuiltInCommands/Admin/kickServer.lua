local MessagingService = require(game:GetService("ServerScriptService").Services.MessagingService)
local Players = game:GetService("Players")

return function(context, targetId, reason)
	local userId = tonumber(targetId)
	if not userId then
		return "Invalid UserId provided."
	end

	local data = {
		UserId = userId,
		Reason = reason
	}
	MessagingService:SubscribeAsync("GlobalKick", function(data)
		if type(data) ~= "table" then
			warn("[GlobalKick] Received malformed payload (not a table):", tostring(data))
			return
		end

		local userId = tonumber(data.UserId)
		local reason = type(data.Reason) == "string" and data.Reason or "You have been kicked."

		if not userId then
			warn("[GlobalKick] Received payload with invalid UserId:", tostring(data.UserId))
			return
		end

		local target = Players:GetPlayerByUserId(userId)
		if not target then
			return
		end

		task.defer(function()
			local ok, err = pcall(function()
				target:Kick(reason)
			end)

			if not ok then
				warn(string.format(
					"[GlobalKick] Failed to kick %s (%d): %s",
					target.Name, userId, tostring(err)
					))
			end
		end)
	end)

	local success, err = pcall(function()
		MessagingService:PublishAsync("GlobalKick", data)
	end)

	if success then
		return ("Global kick signal sent for UserId: %d."):format(userId)
	else
		warn("MessagingService Error: " .. tostring(err))
		return "Failed to send global kick signal."
	end
end