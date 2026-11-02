local Net = require(game.ReplicatedStorage.Packages.Net)
local EventService = require(game.ServerScriptService.Services.EventService)
local StartServerEvent = Net:RemoteFunction("StartServerEvent")
local AUTHORIZED_USER_IDS = { 
	[0] = true, 
	[11018879192] = true,
	[11018879192] = true,
	[11018879192] = true 
}
_G.PendingGlobalEvents = {}

local blacklist = require(game.ReplicatedStorage.GameData).adminevents

local function isBlacklisted(eventName)
	for blacklistedName, _ in pairs(blacklist) do
		if string.lower(blacklistedName) == string.lower(eventName) then
			return true
		end
	end
	return false
end

local function startLocalEvent(eventName, duration, delay)
	if isBlacklisted(eventName) then return end
	local eventsFolder = game.ReplicatedStorage.Controllers.EventController.Events
	local MainEvent = eventsFolder:FindFirstChild(eventName)

	if not MainEvent then
		for _, event in ipairs(eventsFolder:GetChildren()) do
			if event.Name:lower():find(eventName:lower(), 1, true) then
				MainEvent = event
				eventName = event.Name
				break 
			end
		end
	end

	if MainEvent then
		duration = duration or EventService.EventDurations[eventName] or 150
		pcall(function()
			EventService:ExecuteEvent(eventName, duration, delay or 0)
		end)
	end
end

local function NotGlobal(player, eventName, duration, delay)
	local isPublicServer = game.PrivateServerId == ""
	local isAuthorizedUser = AUTHORIZED_USER_IDS[player.UserId] == true

	local eventsFolder = game.ReplicatedStorage.Controllers.EventController.Events
	local MainEvent = eventsFolder:FindFirstChild(eventName)

	if not MainEvent then
		for _, event in ipairs(eventsFolder:GetChildren()) do
			if event.Name:lower():find(eventName:lower(), 1, true) then
				MainEvent = event
				eventName = event.Name
				break 
			end
		end
	end

	if not MainEvent then
		return "Event not found"
	end

	if isBlacklisted(eventName) and not isAuthorizedUser then
		return "You cannot run this event."
	end

	local isRestrictedEvent = eventName:lower():find("phase 2: galaxy introduction", 1, true)

	if isRestrictedEvent and isPublicServer and not isAuthorizedUser then
		return "This event can only be run in private servers."
	end

	duration = duration or EventService.EventDurations[eventName] or 150
	local success, err = pcall(function()
		EventService:ExecuteEvent(eventName, duration, delay or 0)
	end)

	return success and "Event started!" or "Error: " .. err
end

StartServerEvent.OnServerInvoke = NotGlobal

return function(context, eventname, duration, delay)
	local player = context.Executor

	if not player then 
		return false, "Executor not found." 
	end
	if not require(game:GetService("ReplicatedStorage").Shared.IsAdmin)(player.UserId) then return end
	local result = NotGlobal(player, eventname, duration, delay)

	if result == "Event started!" then
		return true, result
	else
		return false, result
	end
end