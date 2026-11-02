--!native

local EventService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)

local ListEvents = Net:RemoteFunction("EventService/ListEvents")
local Kiwi = Net:RemoteFunction("EventService/Kiwi")

EventService.Channels = {}
EventService.EventConfigs = {}
EventService.ActiveEvents = {}
EventService.Events = {}
EventService.RegisteredEvents = {}
EventService.KiwiEvents = {}


Kiwi.OnServerInvoke = function()
	local list = {}
	for name, data in pairs(EventService.KiwiEvents) do
		table.insert(list, data)
	end
	return list
end

ListEvents.OnServerInvoke = function()
	return EventService.Events
end

function EventService:GetRegisteredEvents()
	return self.RegisteredEvents
end

function EventService:GetActiveEvent(eventName)
	local Channels = Synchronizer:Get("Events")
	if not Channels then return nil end
	local ActiveEvents = Channels:Get("ActiveEvents")
	if not ActiveEvents then return nil end
	if eventName then
		for _, data in ipairs(ActiveEvents) do
			if data.eventName == eventName then
				return data
			end
		end
		return nil
	else
		return ActiveEvents
	end
end

function EventService:RegisterEvent(eventName, eventConfig)
	if type(eventConfig) ~= "table" or not eventConfig.Duration then return end
	self.EventConfigs[eventName] = eventConfig
	EventService.KiwiEvents[eventName] = {Name = eventName}
	table.insert(EventService.Events, eventName)
	table.insert(EventService.RegisteredEvents, {Name = eventName, Icon = eventConfig.Icon or "rbxassetid://17451423471"}) 
end

function EventService:ExecuteEvent(eventName, duration)
	local config = self.EventConfigs[eventName]

	-- *** DEBUGGING CHECK ***
	if not config then
		warn(string.format("[EventService] Failed to execute event '%s'. Event is not registered. Check naming!", eventName))
		return 
	end
	-- ***********************

	if self.ActiveEvents[eventName] then return end
	local dur = duration or config.Duration
	local now = os.time()
	local eventData = {eventName = eventName, startedAt = now, endsAt = now + dur}
	self.ActiveEvents[eventName] = eventData
	if self.Channels.Events then self.Channels.Events:InsertOnArray("ActiveEvents", eventData) end
	if config.OnStart then task.spawn(function() pcall(config.OnStart, eventData) end) end
	task.delay(dur, function() if self.ActiveEvents[eventName] then self:CancelEvent(eventName) end end)
end

function EventService:CancelEvent(eventName)
	local eventData = self.ActiveEvents[eventName]
	if not eventData then return end
	local config = self.EventConfigs[eventName]
	if config and config.OnStop then task.spawn(function() pcall(config.OnStop, eventData) end) end
	if self.Channels.Events then
		local arr = self.Channels.Events:Get("ActiveEvents")
		for i, data in ipairs(arr) do
			if data.eventName == eventName then
				self.Channels.Events:RemoveFromArray("ActiveEvents", i)
				break
			end
		end
	end
	self.ActiveEvents[eventName] = nil
end

function EventService:GetActiveEvents()
	return self.ActiveEvents
end

function EventService:IsEventActive(eventName)
	return self.ActiveEvents[eventName] ~= nil
end

function EventService:GetEndTime(eventName)
	local event = self.ActiveEvents[eventName]
	if event then
		return event.endsAt
	end
	return nil
end

function EventService:Start()
	self.Channels.Events = Synchronizer:Create("Events", {ActiveEvents = {}})
	for _, p in ipairs(Players:GetPlayers()) do self.Channels.Events:AddListener(p) end
	Players.PlayerAdded:Connect(function(p)
		if self.Channels.Events then self.Channels.Events:AddListener(p) end
	end)

	local DurationMap = {
		["Bubblegum"] = 900,
		["6x Server Luck"] = 600, 
		["Indonesia"] = 180,
		["FatSammy"] = 4200,
	}

	local IconMap = {
		["Bubblegum"] = "rbxassetid://123456789",
		["6x Server Luck"] = "rbxassetid://987654321",
	}

	for _, v in script.Events:GetChildren() do
		if v:IsA("ModuleScript") then
			local moduleName = v.Name
			local modulePath = script.Events:WaitForChild(moduleName)
			self:RegisterEvent(moduleName, {
				-- Access the maps using the moduleName as the key
				Duration = DurationMap[moduleName] or 300,
				Icon = IconMap[moduleName],
				OnStart = function() require(modulePath).OnStart() end,
				OnStop = function() require(modulePath).OnStop() end
			})
		end
	end
	ReplicatedStorage:SetAttribute("EventsLoaded", true)
end

return EventService