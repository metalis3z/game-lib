local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EventService = require(game:GetService("ServerScriptService").Services.EventService)
local EventsFolder = ReplicatedStorage.Controllers.EventController.Events

local net = require(ReplicatedStorage.Packages.Net)
local stopeventremote = net:RemoteFunction("StopServerEvent")

local function stopevent(player, eventName)
	local eventObj = EventsFolder:FindFirstChild(eventName)
	if not eventObj then
		return "❌ Event '" .. eventName .. "' does not exist."
	end

	local success, err = pcall(function()
		EventService:CancelEvent(eventName)
	end)

	if not success then
		return "❌ Failed to stop event: " .. tostring(err)
	end

	return "✅ Stopped event '" .. eventName .. "' locally!"
end

stopeventremote.OnServerInvoke = stopevent

return function(context, eventName)
	local eventObj = EventsFolder:FindFirstChild(eventName)
	if not eventObj then
		return "❌ Event '" .. eventName .. "' does not exist."
	end

	local success, err = pcall(function()
		EventService:CancelEvent(eventName)
	end)

	if not success then
		return "❌ Failed to stop event: " .. tostring(err)
	end

	return "✅ Stopped event '" .. eventName .. "' locally!"
end
