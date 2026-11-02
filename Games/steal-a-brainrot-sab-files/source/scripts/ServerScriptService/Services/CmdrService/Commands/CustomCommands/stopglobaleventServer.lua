return function(context, eventName)
	local Players             = game:GetService("Players")
	local ServerScriptService = game:GetService("ServerScriptService")
	local EventService        = require(ServerScriptService.Services.EventService)

	local player = Players:GetPlayerByUserId(context.Executor.UserId)
	if not player then
		return "❌ Could not find your player instance."
	end

	local activeEvent = EventService:GetActiveEvent(eventName)
	if not activeEvent then
		return string.format("❌ Event '%s' is not currently active.", eventName)
	end

	local payload = {
		senderName  = player.DisplayName,
		senderId    = player.UserId,
		eventName   = eventName,
		sourceJobId = game.JobId,
	}

	if _G.InternalExecuteGlobalEventStop then
		task.spawn(_G.InternalExecuteGlobalEventStop, payload)
	else
		return "❌ Internal event stop executor not ready. Check script load order."
	end

	local broadcastOk, broadcastErr
	if _G.InternalBroadcastGlobalEventStop then
		broadcastOk, broadcastErr = _G.InternalBroadcastGlobalEventStop(payload)
	else
		warn("[stopglobalevent] InternalBroadcastGlobalEventStop not available.")
		broadcastOk = false
		broadcastErr = "broadcaster not ready"
	end

	if broadcastOk then
		return string.format(
			"🛑 Globally stopped event '%s' successfully!",
			eventName
		)
	else
		return string.format(
			"⚠️ Event '%s' stopped locally but global broadcast failed: %s",
			eventName, tostring(broadcastErr)
		)
	end
end