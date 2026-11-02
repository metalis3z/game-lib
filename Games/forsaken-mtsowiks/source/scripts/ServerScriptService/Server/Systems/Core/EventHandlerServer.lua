local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")

local Network = require(ReplicatedStorage.Modules.Network)
local Signal = require(ReplicatedStorage.Modules.Misc.Signal)

local IS_SERVER = RunService:IsServer()

local ENABLED_EVENTS = {
	["2025_MASQUERADE_Server"] = true,
}

local function safeCall(eventTable, method, ...)
	assert(typeof(eventTable) == "table", "bad eventFile")
	assert(typeof(method) == "string", "bad method")

	local ok, result = pcall(eventTable[method], eventTable, ...)
	if not ok then
		warn(("[%s]: Failed to call method %s due to: %s")
			:format(script:GetFullName(), method, result))
	end
	return result
end

local EventHandlerServer = {
	onEventsLoaded = Signal.new(),
	onEventStarted = Signal.new(),
	onEventStopped = Signal.new(),

	RunningEvents = {},
	ServerEvents = {},
	EnabledEvents = ENABLED_EVENTS,
}

function EventHandlerServer:Init()
	if not IS_SERVER then
		return
	end

	self:LoadEvents()
	self:SetupNetworkCallbacks()
end

function EventHandlerServer:LoadEvents()
	local eventInfoTable = {}

	for _, moduleScript in ipairs(ReplicatedStorage.Events:GetChildren()) do
		if moduleScript:IsA("ModuleScript") and moduleScript.Name:match("Server$") then
			local ok, eventModule = pcall(require, moduleScript)

			if not ok then
				warn(("[%s]: Failed to require server event file %s")
					:format(script:GetFullName(), moduleScript.Name))
				continue
			end

			self.ServerEvents[moduleScript.Name] = eventModule

			if self.EnabledEvents[moduleScript.Name] then
				safeCall(eventModule, "Init")
				eventInfoTable[moduleScript.Name] = {
					Enabled = true,
					Running = true,
					Name = moduleScript.Name
				}
			else
				eventInfoTable[moduleScript.Name] = {
					Enabled = false,
					Running = false,
					Name = moduleScript.Name
				}
			end
		end
	end

	self.RunningEvents = eventInfoTable
	self.onEventsLoaded:Fire(eventInfoTable)
end

function EventHandlerServer:SetupNetworkCallbacks()
	Network:BindServerFunction("RequestEventInfoAsync", function(player)
		return self.RunningEvents
	end)

	Network:BindServerFunction("ToggleEventAsync", function(player, eventName, enabled)
		if not self:IsAdmin(player) then
			return false
		end

		return self:ToggleEvent(eventName, enabled)
	end)
end

function EventHandlerServer:IsAdmin(player)
	return player.UserId == game.CreatorId or player:GetRankInGroup(0) >= 255
end

function EventHandlerServer:ToggleEvent(eventName, enabled)
	local eventModule = self.ServerEvents[eventName]
	if not eventModule then
		warn(("[%s]: Event %s does not exist")
			:format(script:GetFullName(), eventName))
		return false
	end

	local eventInfo = self.RunningEvents[eventName]
	if not eventInfo then
		return false
	end

	if enabled and not eventInfo.Running then
		safeCall(eventModule, "Start")
		eventInfo.Enabled = true
		eventInfo.Running = true
		self.EnabledEvents[eventName] = true
		self.onEventStarted:Fire(eventName)

	elseif not enabled and eventInfo.Running then
		safeCall(eventModule, "Stop")
		eventInfo.Enabled = false
		eventInfo.Running = false
		self.EnabledEvents[eventName] = false
		self.onEventStopped:Fire(eventName)
	end

	return true
end

function EventHandlerServer:StartEvent(eventName)
	return self:ToggleEvent(eventName, true)
end

function EventHandlerServer:StopEvent(eventName)
	return self:ToggleEvent(eventName, false)
end

function EventHandlerServer:GetEvent(eventName)
	return self.ServerEvents[eventName]
end

function EventHandlerServer:IsEventRunning(eventName)
	local eventInfo = self.RunningEvents[eventName]
	return eventInfo and eventInfo.Running or false
end

function EventHandlerServer:GetInfo()
	return self.RunningEvents
end

function EventHandlerServer:GetEnabledEvents()
	local enabled = {}
	for eventName, eventInfo in pairs(self.RunningEvents) do
		if eventInfo.Running then
			table.insert(enabled, eventName)
		end
	end
	return enabled
end

function EventHandlerServer:StopAllEvents()
	for eventName, eventInfo in pairs(self.RunningEvents) do
		if eventInfo.Running then
			self:StopEvent(eventName)
		end
	end
end

return EventHandlerServer