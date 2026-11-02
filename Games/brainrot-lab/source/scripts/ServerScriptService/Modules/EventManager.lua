--!strict
-- LOCATION: ServerScriptService/Modules/EventManager
-- Gerencia o ciclo de eventos e atualiza o painel Placar NextEvent

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local EventConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("EventConfig"))
local Eventos = ReplicatedStorage:WaitForChild("Eventos")
local BaseFolder = Workspace:WaitForChild("Base")

local EventManager = {}

-- State
local isRunning = false
local activeEvents = {} -- [eventKey] = { module, config, endTime, isAdmin }
local nextEventKey = nil
local adminEventActive = false

-- UI references
local placarFrame
local titleLabel
local subTitleLabel
local iconLabel

-- Helper: format time as "Xm Ys"
local function formatTime(seconds: number): string
	seconds = math.max(0, math.floor(seconds))
	local mins = math.floor(seconds / 60)
	local secs = seconds % 60
	return string.format("%dm %ds", mins, secs)
end

-- Helper: find the Placar NextEvent UI
local function getPlacarUI()
	if placarFrame then return placarFrame end

	local maquinas = Workspace:FindFirstChild("Maquinas/Interação")
	if not maquinas then return nil end

	local placar = maquinas:FindFirstChild("Placar NextEvent")
	if not placar then return nil end

	local ui = placar:FindFirstChild("UI")
	if not ui then return nil end

	local frame = ui:FindFirstChild("Frame")
	if not frame then return nil end

	placarFrame = frame
	titleLabel = frame:FindFirstChild("Title")
	subTitleLabel = frame:FindFirstChild("SubTitle")
	iconLabel = frame:FindFirstChild("Icon")

	return placarFrame
end

-- Helper: update the Placar UI
local function updatePlacar(title: string, subTitle: string, iconImage: string?)
	local frame = getPlacarUI()
	if not frame then return end

	if titleLabel then titleLabel.Text = title end
	if subTitleLabel then subTitleLabel.Text = subTitle end
	if iconLabel and iconImage then iconLabel.Image = iconImage end
end

-- Helper: find event module by key
local function findEventModule(eventKey: string, moduleName: string): ModuleScript?
	local eventFolder = Eventos:FindFirstChild(eventKey)
	if not eventFolder then return nil end

	-- Search for ModuleScript with the given name recursively
	local module = eventFolder:FindFirstChild(moduleName, true)
	if module and module:IsA("ModuleScript") then
		return module
	end

	-- Fallback: search for any ModuleScript in the folder
	for _, descendant in ipairs(eventFolder:GetDescendants()) do
		if descendant:IsA("ModuleScript") then
			return descendant
		end
	end

	return nil
end

-- Helper: pick a random event key (excludes admin-only / NoModule events)
local function pickRandomEvent(): string?
	local keys = {}
	for key, config in pairs(EventConfig.Events) do
		if config.Cycle ~= false then
			table.insert(keys, key)
		end
	end

	if #keys == 0 then return nil end
	return keys[math.random(1, #keys)]
end

-- Helper: notify clients that an event started/ended
local function notifyEventStart(eventKey: string, endTime: number)
	local remotes = ReplicatedStorage:FindFirstChild("EventRemotes")
	if not remotes then return end
	local startRemote = remotes:FindFirstChild("StartEvent")
	if startRemote then
		startRemote:FireAllClients(eventKey, endTime)
	end
end

local function notifyEventEnd(eventKey: string)
	local remotes = ReplicatedStorage:FindFirstChild("EventRemotes")
	if not remotes then return end
	local endRemote = remotes:FindFirstChild("EndEvent")
	if endRemote then
		endRemote:FireAllClients(eventKey)
	end
end

-- Helper: play event sounds for all clients (start or end phase)
local function playEventSounds(eventKey: string, phase: string)
	local remotes = ReplicatedStorage:FindFirstChild("EventRemotes")
	if not remotes then return end
	local soundRemote = remotes:FindFirstChild("PlayEventSounds")
	if soundRemote then
		soundRemote:FireAllClients(eventKey, phase)
	end
end

-- Helper: calculate duration before the event should start
-- Waits for the intro sound + 1 second into Estalo before starting the event
local function getStartSoundDuration(eventKey: string): number
	local soundsFolder = ReplicatedStorage:FindFirstChild("Eventos Sounds")
	if not soundsFolder then return 0 end

	local firstName
	if eventKey == "Aura Infinita" then
		firstName = "Evento Aura Infinita"
	else
		firstName = "Todos eventos"
	end

	local sound = soundsFolder:FindFirstChild(firstName)
	if sound and sound:IsA("Sound") then
		-- Wait for the intro sound to finish + 1 second into Estalo
		return sound.TimeLength + 1
	end

	return 0
end

-- Helper: move BasePLayer out of the base (once)
local function moveBasePlayerOut()
	local basePlayer = BaseFolder:FindFirstChild("BasePLayer")
	if basePlayer then
		basePlayer.Parent = ReplicatedStorage
		print("[EventManager] Moved BasePLayer to ReplicatedStorage")
	end
end

-- Helper: move BasePLayer back to the base
local function moveBasePlayerBack()
	local basePlayer = ReplicatedStorage:FindFirstChild("BasePLayer")
	if basePlayer then
		basePlayer.Parent = BaseFolder
		print("[EventManager] Moved BasePLayer back to Workspace.Base")
	end
end

-- Helper: check if any admin event is still active
local function hasAdminEvents(): boolean
	for _, entry in pairs(activeEvents) do
		if entry.isAdmin then return true end
	end
	return false
end

-- Helper: start an event (supports multiple concurrent events)
local function startEvent(eventKey: string, isAdmin: boolean?): boolean
	local config = EventConfig.Events[eventKey]
	if not config then return false end
	if activeEvents[eventKey] then return true end

	-- Play event sounds BEFORE the event starts
	-- The event will only appear after the sound sequence (including Estalo) finishes
	playEventSounds(eventKey, "start")
	local soundDuration = getStartSoundDuration(eventKey)
	if soundDuration > 0 then
		print("[EventManager] Playing event sounds for " .. tostring(soundDuration) .. "s before starting: " .. eventKey)
		task.wait(soundDuration)
	end

	local module = nil
	if not config.NoModule then
		local moduleScript = findEventModule(eventKey, config.ModuleName)
		if not moduleScript then
			warn("[EventManager] Could not find event module for: " .. eventKey)
			return false
		end

		local ok, mod = pcall(require, moduleScript)
		if not ok or not mod then
			warn("[EventManager] Could not load event module for: " .. eventKey, mod)
			return false
		end
		module = mod

		-- Move o modelo do evento de ReplicatedStorage.Eventos para Workspace.Base
		local eventModel = Eventos:FindFirstChild(eventKey)
		if eventModel then
			eventModel.Parent = BaseFolder
			print("[EventManager] Moved event model '" .. eventKey .. "' to Workspace.Base")
		end

		moveBasePlayerOut()

		if module.Start then
			module.Start()
		end
	end

	-- os.time() (relogio real, sincronizado) em vez de os.clock() (tempo de processo,
	-- que difere entre servidor e cada cliente) para o countdown replicar certo pra todos.
	local endTime = os.time() + (config.Duration or 120)
	activeEvents[eventKey] = {
		module = module,
		config = config,
		endTime = endTime,
		isAdmin = isAdmin == true,
	}

	notifyEventStart(eventKey, endTime)

	print("[EventManager] Started event: " .. config.DisplayName)
	return true
end

-- Helper: stop a specific event
local function stopEvent(eventKey: string)
	local entry = activeEvents[eventKey]
	if not entry then return end

	if entry.module and entry.module.Stop then
		entry.module.Stop()
	end

	local config = entry.config
	print("[EventManager] Stopped event: " .. (config and config.DisplayName or eventKey))

	-- Move o modelo do evento de volta para ReplicatedStorage.Eventos (only for module events)
	if not (config and config.NoModule) then
		local eventModel = BaseFolder:FindFirstChild(eventKey)
		if eventModel then
			eventModel.Parent = Eventos
			print("[EventManager] Moved event model '" .. eventKey .. "' back to ReplicatedStorage.Eventos")
		end
	end

	activeEvents[eventKey] = nil

	-- Se não houver mais eventos ativos, move BasePLayer de volta
	if next(activeEvents) == nil then
		moveBasePlayerBack()
	end

	notifyEventEnd(eventKey)
	playEventSounds(eventKey, "end")
end

-- Init
function EventManager:Init(controllers)
	print("[EventManager] Initialized")
end

-- Start
function EventManager:Start()
	if isRunning then return end
	isRunning = true

	-- Expose active events to clients (for late joiners)
	local remotes = ReplicatedStorage:FindFirstChild("EventRemotes")
	if remotes then
		local getActive = remotes:FindFirstChild("GetActiveEvents")
		if getActive and getActive:IsA("RemoteFunction") then
			getActive.OnServerInvoke = function()
				local result = {}
				for key, entry in pairs(activeEvents) do
					result[key] = entry.endTime
				end
				return result
			end
		end
	end

	-- Watcher: expire events when their duration ends
	task.spawn(function()
		while isRunning do
			task.wait(0.5)
			local now = os.time()
			for key, entry in pairs(activeEvents) do
				if now >= entry.endTime then
					stopEvent(key)
				end
			end
			-- Resume the normal cycle once no admin events remain
			if adminEventActive and not hasAdminEvents() then
				adminEventActive = false
			end
		end
	end)

	task.spawn(function()
		local isFirst = true

		while isRunning do
			-- If an admin-triggered event is active, wait for it to finish
			if adminEventActive then
				task.wait(1)
				continue
			end

			-- Pick next event
			nextEventKey = pickRandomEvent()
			local nextConfig = nextEventKey and EventConfig.Events[nextEventKey]

			if not nextConfig then
				warn("[EventManager] No events configured!")
				task.wait(10)
				continue
			end

			-- Determine wait time before event starts
			local waitTime = isFirst and EventConfig.InitialDelay or math.random(EventConfig.MinTimeBetweenEvents, EventConfig.MaxTimeBetweenEvents)
			isFirst = false

			-- Countdown to event start
			for remaining = waitTime, 0, -1 do
				if not isRunning then break end
				updatePlacar(
					nextConfig.DisplayName .. " Event",
					"Next Event In: " .. formatTime(remaining),
					nextConfig.Image
				)
				task.wait(1)
			end

			if not isRunning then break end

			-- Start the event
			local started = startEvent(nextEventKey)

			if started then
				-- Event active countdown (the watcher expires it when duration ends)
				local duration = nextConfig.Duration or 120
				for remaining = duration, 0, -1 do
					if not isRunning then break end
					updatePlacar(
						nextConfig.DisplayName .. " Event Active!",
						"Time Remaining: " .. formatTime(remaining),
						nextConfig.Image
					)
					task.wait(1)
				end

				-- Ensure the event is stopped
				stopEvent(nextEventKey)
			else
				-- Event failed to start, wait a bit and try again
				warn("[EventManager] Failed to start event: " .. nextEventKey)
				task.wait(30)
			end
		end

		-- Cleanup on stop
		for key in pairs(activeEvents) do
			stopEvent(key)
		end
	end)

	print("[EventManager] Started - Event cycle running")
end

function EventManager.GetCurrentEvent()
	for key in pairs(activeEvents) do
		return key
	end
	return nil
end

-- Admin: start an event immediately (bypasses the normal cycle)
-- Only one event can be active at a time. Returns (success, errorMessage)
function EventManager.AdminStartEvent(eventKey: string): (boolean, string?)
	local config = EventConfig.Events[eventKey]
	if not config then
		warn("[EventManager] AdminStartEvent: unknown event key: " .. tostring(eventKey))
		return false, "Unknown event"
	end

	-- Check if there is already an active event
	for activeKey, entry in pairs(activeEvents) do
		local activeConfig = entry.config
		local activeName = activeConfig and activeConfig.DisplayName or activeKey
		return false, "Voce precisa desativar o evento atual (" .. activeName .. ") para ativar outro!"
	end

	adminEventActive = true
	local started = startEvent(eventKey, true)
	if not started then
		adminEventActive = false
		return false
	end

	-- Update Placar to show the admin-started event with its icon and countdown
	task.spawn(function()
		while isRunning and activeEvents[eventKey] do
			local entry = activeEvents[eventKey]
			if not entry then break end
			local remaining = entry.endTime - os.time()
			if remaining <= 0 then break end
			updatePlacar(
				config.DisplayName .. " Event Active!",
				"Time Remaining: " .. formatTime(remaining),
				config.Image
			)
			task.wait(1)
		end
	end)

	print("[EventManager] Admin started event: " .. eventKey)
	return true
end

-- Admin: stop an admin-started event and resume the normal cycle
function EventManager.AdminStopEvent(eventKey: string?): boolean
	if eventKey then
		stopEvent(eventKey)
	else
		for key in pairs(activeEvents) do
			stopEvent(key)
		end
	end
	if not hasAdminEvents() then
		adminEventActive = false
	end
	print("[EventManager] Admin stopped event, resuming normal cycle")
	return true
end

-- Admin: check if an admin event is currently active
function EventManager.IsAdminEventActive(): boolean
	return adminEventActive
end

return EventManager