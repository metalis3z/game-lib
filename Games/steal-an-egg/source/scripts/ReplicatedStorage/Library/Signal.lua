local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local SIGNALS_MAP = require(ReplicatedStorage.Library.Globals.Constants).SIGNALS_MAP

local SIGNAL_TYPES = { "BindableEvent", "BindableFunction" }
local signalCache = {
	[1] = {}, -- BindableEvents
	[2] = {}, -- BindableFunctions
}

local signalsFolder
if RunService:IsServer() then
	signalsFolder = game:GetService("ServerScriptService"):WaitForChild("Signals", 10)
	if not signalsFolder then
		warn("[Signal] ServerScriptService.Signals did not exist after 10s — creating fallback folder")
		signalsFolder = Instance.new("Folder")
		signalsFolder.Name = "Signals"
		signalsFolder.Parent = game:GetService("ServerScriptService")
	end
else
	signalsFolder = script
end

local Signal = {
	MAP = SIGNALS_MAP,
}

--==============================--
-- Helper Functions
--==============================--

local function getOrCreateSignal(signalTypeIndex, signalName)
	local typeCache = signalCache[signalTypeIndex]
	local signalInstance = typeCache[signalName]

	if not signalInstance then
		signalInstance = Instance.new(SIGNAL_TYPES[signalTypeIndex])
		signalInstance.Name = signalName
		signalInstance.Parent = signalsFolder
		typeCache[signalName] = signalInstance
	end

	return signalInstance
end

local function getEvent(signalName)
	return getOrCreateSignal(1, signalName)
end

local function getFunction(signalName)
	return getOrCreateSignal(2, signalName)
end

--==============================--
-- Module Methods
--==============================--

function Signal.Fire(signalName, ...)
	getEvent(signalName):Fire(...)
end

function Signal.FireAsync(signalName, ...)
	local event = getEvent(signalName)
	task.spawn(event.Fire, event, ...)
end

function Signal.Fired(signalName)
	return getEvent(signalName).Event
end

function Signal.Invoke(signalName, ...)
	return getFunction(signalName):Invoke(...)
end

function Signal.Invoked(signalName)
	return getFunction(signalName)
end

return Signal