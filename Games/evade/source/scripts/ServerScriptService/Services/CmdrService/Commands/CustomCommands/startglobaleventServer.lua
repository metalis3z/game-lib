local EventService = require(game.ServerScriptService.Services.EventService)
local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local EventService = require(game:GetService("ServerScriptService").Services.EventService)
local EventsFolder = ReplicatedStorage.Controllers.EventController.Events

MessagingService:SubscribeAsync("GlobalStartEvent", function(message)
	local data = message.Data
	if data.FromServer == game.JobId then return end

	local eventName = data.EventName
	local duration = data.Duration or 300

	local eventObj = EventsFolder:FindFirstChild(eventName)
	if not eventObj then
		warn("⚠️ Event '" .. eventName .. "' not found on this server.")
		return
	end

	EventService:ExecuteEvent(eventName, duration)

	
end)

return function(context, eventName, duration)
	local EventsFolder = ReplicatedStorage.Controllers.EventController.Events
	local EventService = require(game:GetService("ServerScriptService").Services.EventService)
	local MessagingService = game:GetService("MessagingService")

	duration = duration or 300

	if eventName == "random" then
		local children = EventsFolder:GetChildren()
		if #children == 0 then
			return "❌ No events available to start."
		end
		eventName = children[math.random(1, #children)].Name
	end

	local eventObj = EventsFolder:FindFirstChild(eventName)
	if not eventObj then
		return "❌ Event '" .. eventName .. "' does not exist."
	end

	local success, err = pcall(function()
		EventService:ExecuteEvent(eventName, duration)
	end)
	if not success then
		return "❌ Failed to start event: " .. tostring(err)
	end

	local ok, publishErr = pcall(function()
		MessagingService:PublishAsync("GlobalStartEvent", {
			EventName = eventName,
			Duration = duration,
			FromServer = game.JobId,
			Executor = context.Executor.Name
		})
	end)

	if not ok then
		warn("❌ Failed to broadcast global event:", publishErr)
	end

	return string.format("✅ Started event '%s' for %d seconds globally!", eventName, duration)
end
