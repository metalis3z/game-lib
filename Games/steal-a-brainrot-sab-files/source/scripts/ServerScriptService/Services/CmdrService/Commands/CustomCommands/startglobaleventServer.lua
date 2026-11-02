return function(context, eventName, duration, argumentsString)
	local Players             = game:GetService("Players")
	local ServerScriptService = game:GetService("ServerScriptService")
	local EventService        = require(ServerScriptService.Services.EventService)

	local player = Players:GetPlayerByUserId(context.Executor.UserId)
	if not player then
		return "❌ Could not find your player instance."
	end

	local IsAdmin = require(game:GetService("ReplicatedStorage").Shared.IsAdmin)
	if not IsAdmin(player.UserId) then
		return "❌ You are not authorized to use this command."
	end

	if not eventName or eventName == "" then
		return "❌ Event name cannot be empty."
	end

	duration = tonumber(duration) or EventService.EventDurations[eventName] or 180
	if duration <= 0 then
		return "❌ Duration must be greater than 0."
	end

	local parsedArguments = nil
	if argumentsString and argumentsString ~= "" then
		parsedArguments = {}
		for arg in argumentsString:gmatch("[^,]+") do
			local trimmed = arg:match("^%s*(.-)%s*$")
			if trimmed ~= "" then
				table.insert(parsedArguments, trimmed)
			end
		end
		if #parsedArguments == 0 then
			parsedArguments = nil
		end
	end

	local scheduledUnixTime = os.time()
	local payload = {
		senderName        = player.DisplayName,
		senderId          = player.UserId,
		eventName         = eventName,
		duration          = duration,
		delay             = 0,
		isSnap            = false,
		targetPlayerName  = nil,
		sourceJobId       = game.JobId,
		isScheduled       = true,
		scheduledUnixTime = scheduledUnixTime,
		arguments         = parsedArguments,
	}

	local scheduleId = string.format(
		"SCHED_%s_%d_%d",
		eventName,
		player.UserId,
		scheduledUnixTime
	)

	if not _G.ScheduledEvents then
		_G.ScheduledEvents = {}
	end
	if _G.ScheduledEvents[scheduleId] then
		return string.format("⚠️ Event '%s' is already scheduled for that time.", eventName)
	end

	local scheduleThread = task.spawn(function()
		_G.ScheduledEvents[scheduleId] = nil

		if _G.InternalExecuteGlobalEvent then
			task.spawn(_G.InternalExecuteGlobalEvent, payload)
		else
			warn(string.format(
				"[triggerglobalevent] InternalExecuteGlobalEvent not ready when '%s' fired.",
				eventName
				))
		end

		if _G.InternalBroadcastGlobalEvent then
			local ok, err = _G.InternalBroadcastGlobalEvent(payload)
			if not ok then
				warn(string.format(
					"[triggerglobalevent] Broadcast failed for '%s': %s",
					eventName, tostring(err)
					))
			end
		else
			warn(string.format(
				"[triggerglobalevent] InternalBroadcastGlobalEvent not available when '%s' fired.",
				eventName
				))
		end
	end)

	_G.ScheduledEvents[scheduleId] = {
		id                = scheduleId,
		eventName         = eventName,
		scheduledUnixTime = scheduledUnixTime,
		secondsUntilFire  = 0,
		duration          = duration,
		arguments         = parsedArguments,
		scheduledBy       = player.DisplayName,
		scheduledById     = player.UserId,
		thread            = scheduleThread,
		payload           = payload,
	}

	local argDisplay = parsedArguments and table.concat(parsedArguments, ", ") or "none"

	return string.format(
		"📅 Triggered global event '%s' for %ds with args [%s]. [ID: %s]",
		eventName,
		duration,
		argDisplay,
		scheduleId
	)
end