local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local EventService = require(game.ServerScriptService.Services.EventService)
local EventsFolder = ReplicatedStorage.Controllers.EventController.Events
local HttpService = game:GetService("HttpService")
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local StartGlobalEvent = Net:RemoteFunction("StartGlobalEvent")
local StopGlobalEvent = Net:RemoteFunction("StopGlobalEvent")
local StartServerEvent = Net:RemoteFunction("StartServerEvent")
local StopServerEvent = Net:RemoteFunction("StopServerEvent")

MessagingService:SubscribeAsync("GlobalStartEvent", function(message)
	local data = message.Data
	if data.FromServer == game.JobId then return end
	local eventName = data.EventName
	local duration = data.Duration or 300
	local eventObj = EventsFolder:FindFirstChild(eventName)
	if not eventObj then
		warn("Event not found on this server.")
		return
	end
	EventService:ExecuteEvent(eventName, duration)
	local msg = string.format("%s started the '%s' event!", data.Executor or "Someone", eventName)
	for _, player in ipairs(Players:GetPlayers()) do
		NotificationEvent:FireClient(player, msg, 5, nil, "Top")
	end
end)

MessagingService:SubscribeAsync("GlobalStopEvent", function(message)
	local data = message.Data
	if data.FromServer == game.JobId then return end

	local eventName = data.EventName
	local eventObj = EventsFolder:FindFirstChild(eventName)
	if not eventObj then
		warn("Tried to stop non-existent event '" .. eventName .. "' on this server.")
		return
	end

	local success, err = pcall(function()
		EventService:CancelEvent(eventName)
	end)
	if not success then
		warn("Failed to stop global event:", err)
		return
	end

	local msg = string.format("%s stopped the '%s' event!", data.Executor or "Someone", eventName)
	for _, player in ipairs(Players:GetPlayers()) do
		NotificationEvent:FireClient(player, msg, 5, nil, "Top")
	end
end)

StartGlobalEvent.OnServerInvoke = function(player, eventName, duration)
	duration = duration or 300
	if eventName == "random" then
		local children = EventsFolder:GetChildren()
		if #children == 0 then
			return "No events available to start."
		end
		eventName = children[math.random(1, #children)].Name
	end
	if eventName == "All" then
		for i, children in pairs(EventsFolder:GetChildren()) do
			if children:IsA("ModuleScript") then
				eventName = children.Name
			end
		end
	end
	local eventObj = EventsFolder:FindFirstChild(eventName)  
	if not eventObj then
		return "Event does not exist."
	end
	local success, err = pcall(function()
		EventService:ExecuteEvent(eventName, duration)
	end)
	if not success then
		return "Failed to start event: " .. tostring(err)
	end
	local ok, publishErr = pcall(function()
		MessagingService:PublishAsync("GlobalStartEvent", {
			EventName = eventName,
			Duration = duration,
			FromServer = game.JobId,
			Executor = player.Name
		})
	end)
	if not ok then
		warn("Failed to broadcast global event:", publishErr)
	end
	return string.format("Started event '%s' for %d seconds globally!", eventName, duration)
end

StopGlobalEvent.OnServerInvoke = function(player, eventName)
	local eventObj = EventsFolder:FindFirstChild(eventName)
	if not eventObj then
		return "Event '" .. eventName .. "' does not exist."
	end

	local success, err = pcall(function()
		EventService:CancelEvent(eventName)
	end)

	if not success then
		return "Failed to stop event locally: " .. tostring(err)
	end

	local publishSuccess, publishErr = pcall(function()
		MessagingService:PublishAsync("GlobalStopEvent", {
			EventName = eventName,
			FromServer = game.JobId,
			Executor = player.Name
		})
	end)

	if not publishSuccess then
		warn("Event stopped locally but failed to broadcast:", publishErr)
		return string.format("Stopped '%s' locally, but global broadcast failed.", eventName)
	end

	return "Stopped event '" .. eventName .. "' globally!"
end

StartServerEvent.OnServerInvoke = function(player, eventName, duration)
	duration = duration or 300
	local MainEvent = game.ReplicatedStorage.Controllers.EventController.Events:FindFirstChild(eventName)
	if not MainEvent then
		return "This event does not exist."
	end

	local success, err = pcall(function()
		EventService:ExecuteEvent(eventName, duration)
	end)
	if not success then
		return "Failed to start event: " .. tostring(err)
	end

	return "Event '" .. eventName .. "' started for " .. tostring(duration) .. " seconds!"
end

StopServerEvent.OnServerInvoke = function(player, eventName)
	local eventObj = EventsFolder:FindFirstChild(eventName)
	if not eventObj then
		return "Event '" .. eventName .. "' does not exist."
	end

	local success, err = pcall(function()
		EventService:CancelEvent(eventName)
	end)

	if not success then
		return "Failed to stop event: " .. tostring(err)
	end

	return "Stopped event '" .. eventName .. "' locally!"
end
