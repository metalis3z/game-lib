--!native

local EventService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local Mutations = require(ReplicatedStorage.Datas.Mutations) :: SharedTable
local ListEvents = Net:RemoteFunction("EventService/ListEvents")
local Kiwi = Net:RemoteFunction("EventService/Kiwi")
local soundcontroller = require(ReplicatedStorage.Controllers.SoundController)
local CraftingMachineService = nil
local ServerScriptService = game:GetService("ServerScriptService")
local function GetCraftingService()
	if not CraftingMachineService then
		local ok, result = pcall(function()
			return require(ServerScriptService.Services.CraftingMachineService)
		end)
		if ok then CraftingMachineService = result end
	end
	return CraftingMachineService
end

local FuseMachineService = nil
local function GetFuseService()
	if not FuseMachineService then
		local ok, result = pcall(function()
			return require(ServerScriptService.Services.FuseMachineService)
		end)
		if ok then FuseMachineService = result end
	end
	return FuseMachineService
end
EventService.Channels = {}
EventService.EventConfigs = {}
EventService.ActiveEvents = {}
EventService.Events = {}
EventService.RegisteredEvents = {}
EventService.KiwiEvents = {}

EventService.EventDurations = {
	["Bubblegum"] = 600,
	["North Pole"] = 600,
	["3 Roads"] = 900,
	["Rainbow"] = 900,
	["Snow"] = 300,
	["Bombardiro Crocodilo"] = 120,
	["Glitch"] = 180,
	["Solar Flare"] = 120,
	["Raining Tacos"] = 180,
	["Raining Burgers"] = 180,
	["Meowl"] = 180,
	["Strawberry"] = 180,
	["Skibidi"] = 180,
	["John Pork"] = 180,
	["Nyan Cats"] = 133,
	["Crab Rave"] = 160,
	["Concert"]= 130, 
	["Brazil"]= 121,  
	["Rap Concert"]= 90,
	["Mexico"] = 195,
	["Laser City"] = 180,
	["Caylus Base"] = 180,
	["Skip Craft"] = 1,
	["Indonesia"] = 180,
	["Winter Hour"]= 153,
	["Sammyni Spyderini"] = 180,
	["Summer Hour"] = 180,
	["Graipuss Medussi"] = 180,
	["Lance"] = 451,
	["Tung Tung Attack"] = 300,
	["UFO"] = 300,
	["Chicleteira Bicicleteira"] = 180,
	["La Vacca Saturno Saturnita"] = 300,
	["Los Matteos"] = 300,
	["Water"] = 305,
	["Dul Dul Dul"] = 180,
	["Fuse Machine Luck"] = 900,
	["Backrooms"] = 900,
	["2026"] = 180,
	["Ay Mi Gatito"] = 226,
	["1x1x1x1"] = 300,
	["Cursed"] = 900,
	["Candy"] = 900,
	["YinYang"] = 900,
	["Skip Fuse"] = 1,
	["Rip My Granny"] = 180,
	["Eid"] = 180,
	["Easter"] = 180,
	["April Fools"] = 300,
	["Sammy's Base"] = 120,
	["Starfall"] = 180,
	["Sammy Snap"] = 180,
	["Egg City"] = 180,
	["Eggrot Hunt"] = 900,
	["2x Server Luck"] = 900,
	["4x Server Luck"] = 900,
	["6x Server Luck"] = 600,
	["8x Server Luck"] = 300,
	["10x Server Luck"] = 300,
	["12x Server Luck"] = 300,
	["15x Server Luck"] = 180,
	["20x Server Luck"] = 180,
	["25x Server Luck"] = 180,
	["30x Server Luck"] = 180,
	["Starfall"] = 180,
	["Bloodmoon"] = 900,
	["Molten"] = 900,
	["Radioactive"] = 900,
	["Divine"] = 900,
	["Galaxy"] = 900,
	["Cyber"] = 900,
	["1 Year"] = 241
} 

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

function EventService:ExecuteEvent(eventName, duration, startTimeOffset, extrainfo)
	local config = self.EventConfigs[eventName]

	if not config then
		warn(string.format("[EventService] Failed to execute event '%s'. Event is not registered. Check naming!", eventName))
		return 
	end

	if string.find(eventName, "Luck") then
		for activeName, _ in pairs(self.ActiveEvents) do
			if string.find(activeName, "Luck") and activeName ~= eventName and activeName ~= "Fuse Machine Luck" then
				self:CancelEvent(activeName)
			end
		end
	end
	if self.ActiveEvents[eventName] then
		self:CancelEvent(eventName)
	end

	local dur = duration or config.Duration
	local offset = startTimeOffset or 0
	if eventName == "Skip Fuse" and dur ~= 1 then
		dur = 1
	end

	local now = workspace:GetServerTimeNow()
	local adjustedStart = now - offset

	local adjustedEnd
	if dur == math.huge then
		adjustedEnd = math.huge
	else
		adjustedEnd = adjustedStart + dur
	end

	local remainingTime = adjustedEnd - now

	if remainingTime <= 0 then
		return
	end

	local eventData = {
		eventName = eventName, 
		startedAt = adjustedStart, 
		endsAt = adjustedEnd,
		arguments = extrainfo
	}

	self.ActiveEvents[eventName] = eventData

	if self.Channels.Events then 
		self.Channels.Events:InsertOnArray("ActiveEvents", eventData) 
	end

	if config.OnStart then 
		task.spawn(function() pcall(config.OnStart, eventData, extrainfo) end)
	end

	if dur ~= math.huge then
		task.delay(remainingTime, function() 
			local currentEvent = self.ActiveEvents[eventName]
			if currentEvent and currentEvent.endsAt == adjustedEnd then 
				self:CancelEvent(eventName) 
			end 
		end)
	else
		print(string.format("[EventService] '%s' started indefinitely. No end timer scheduled.", eventName))
	end

	local Mutations = require(ReplicatedStorage.Datas.Mutations)
	if Mutations[eventName] then
		local craftingService = GetCraftingService()
		if craftingService then
			craftingService:SetMutationEvent(eventName, true)
		end
		local fuseService = GetFuseService()
		if fuseService then
			fuseService:SetMutationEvent(eventName, true)
		end
	end
end

function EventService:CancelEvent(eventName, extrainfo)
	local eventData = self.ActiveEvents[eventName]
	if not eventData then return end
	local config = self.EventConfigs[eventName]
	if config and config.OnStop then task.spawn(function() pcall(config.OnStop, eventData, extrainfo) end) end
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
	local Mutations = require(ReplicatedStorage.Datas.Mutations)
	if Mutations[eventName] then
		local craftingService = GetCraftingService()
		if craftingService then
			craftingService:SetMutationEvent(eventName, false)
		end
		local fuseService = GetFuseService()
		if fuseService then
			fuseService:SetMutationEvent(eventName, false)
		end
	end
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

EventService:RegisterEvent("Phase 5: Sammy Snap", {
	Duration = 21.5,
	OnStart = function(data)
		require(script.Events["Phase 5: Sammy Snap"]).OnStart(data)
	end,
	OnStop = function(data)
		require(script.Events["Phase 5: Sammy Snap"]).OnStop(data)
	end,
	OnLoad = function()
		require(script.Events["Phase 5: Sammy Snap"]).OnLoad()
	end
})

function EventService:Start()
	self.Channels.Events = Synchronizer:Create("Events", {ActiveEvents = {}})
	for _, p in ipairs(Players:GetPlayers()) do self.Channels.Events:AddListener(p) end
	Players.PlayerAdded:Connect(function(p)
		if self.Channels.Events then self.Channels.Events:AddListener(p) end
	end)

	task.spawn(function()
		while true do
			task.wait(60)
			local now = workspace:GetServerTimeNow()
			for eventName, eventData in pairs(self.ActiveEvents) do
				if eventData.endsAt and eventData.endsAt < now then
					self:CancelEvent(eventName)
				end
			end
		end
	end)

	local DurationMap = {
		["Bubblegum"] = 900,
		["2x Server Luck"] = 900,
		["4x Server Luck"] = 900,
		["6x Server Luck"] = 900,
		["8x Server Luck"] = 900,
		["10x Server Luck"] = 900,
		["12x Server Luck"] = 900,
		["15x Server Luck"] = 900,
		["20x Server Luck"] = 900,
		["25x Server Luck"] = 900,
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
				Duration = DurationMap[moduleName] or 300,
				Icon = IconMap[moduleName],
				OnStart = function(data) 
					require(modulePath).OnStart(data) 
				end,
				OnStop = function(data) 
					require(modulePath).OnStop(data) 
				end,
				OnLoad = function()
					local m = require(modulePath)
					if m.OnLoad then m.OnLoad() end
				end
			})
		end
	end

	for eventName, config in pairs(self.EventConfigs) do
		if config.OnLoad then
			task.spawn(function()
				pcall(config.OnLoad)
			end)
		end
	end

	ReplicatedStorage:SetAttribute("EventsLoaded", true)

	local luckTiers = {"2x", "4x", "6x", "8x", "10x", "12x", "15x", "20x", "25x", "30x"}
	for _, tier in ipairs(luckTiers) do
		local eventName = tier .. " Server Luck"
		if not self.EventConfigs[eventName] then
			self:RegisterEvent(eventName, {
				Duration = 900,
				OnStart = function() end,
				OnStop = function() end,
			})
		end
	end
end



return EventService