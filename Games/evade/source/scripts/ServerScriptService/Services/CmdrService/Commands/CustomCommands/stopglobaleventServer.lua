local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local EventService = require(game:GetService("ServerScriptService").Services.EventService)
local EventsFolder = ReplicatedStorage.Controllers.EventController.Events
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

MessagingService:SubscribeAsync("GlobalStopEvent", function(message)
	local data = message.Data
	if data.FromServer == game.JobId then return end

	local eventName = data.EventName
	local eventObj = EventsFolder:FindFirstChild(eventName)
	if not eventObj then
		warn("⚠️ Tried to stop non-existent event '" .. eventName .. "' on this server.")
		return
	end

	local success, err = pcall(function()
		EventService:CancelEvent(eventName)
	end)

	if not success then
		warn("❌ Failed to stop global event:", err)
		return
	end

	
end)

return function(context, eventName)
	local eventObj = EventsFolder:FindFirstChild(eventName)
	if not eventObj then
		return "❌ Event '" .. eventName .. "' does not exist."
	end

	local success, err = pcall(function()
		EventService:CancelEvent(eventName)
	end)

	if not success then
		return "❌ Failed to stop event locally: " .. tostring(err)
	end

	local publishSuccess, publishErr = pcall(function()
		MessagingService:PublishAsync("GlobalStopEvent", {
			EventName = eventName,
			FromServer = game.JobId,
			Executor = context.Executor.Name
		})
	end)

	if not publishSuccess then
		warn("⚠️ Event stopped locally but failed to broadcast:", publishErr)
		return string.format("✅ Stopped '%s' locally, but global broadcast failed.", eventName)
	end

	return "✅ Stopped event '" .. eventName .. "' globally!"
end
