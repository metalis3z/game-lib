local EventBoardService = {}

local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EventService = require(game.ServerScriptService.Services.EventService)
local TimeUtils = require(ReplicatedStorage:WaitForChild("Utils"):WaitForChild("TimeUtils"))

local Store = DataStoreService:GetDataStore("GlobalEventTimer")
local STATE_KEY = "GlobalEventState"

local DURATION = 60 * 60
local SYNC_INTERVAL = 30

local Events = {
	{
		Name = "Winter Hour",
		Image = "rbxassetid://88375043733582",
		Action = function()
			EventService:ExecuteEvent("Winter Hour", 180)
		end
	},
	{
		Name = "Gingerbread Town",
		Image = "rbxassetid://70894779883038",
		Action = function()
			EventService:ExecuteEvent("Gingerbread Town", 180)
		end
	}
}

local running = false
local startEpoch = os.time()
local currentEvent = Events[1]

local Board
local Gui
local TimerLabel
local EventNameLabel
local EventImage

local function formatTime(seconds)
	local m = math.floor(seconds / 60)
	local s = math.floor(seconds % 60)
	if s == 0 then
		return string.format("%dm", m)
	end
	return string.format("%dm %ds", m, s)
end

local function pickRandomEvent()
	return Events[math.random(1, #Events)]
end

local function applyState(state)
	if typeof(state) ~= "table" then return end
	if type(state.startEpoch) ~= "number" then return end
	if type(state.eventName) ~= "string" then return end

	startEpoch = state.startEpoch

	for _, ev in ipairs(Events) do
		if ev.Name == state.eventName then
			currentEvent = ev
			return
		end
	end

	currentEvent = pickRandomEvent()
	startEpoch = os.time()
end

local function remainingTime()
	return math.max(0, DURATION - (os.time() - startEpoch))
end

local function updateBoard()
	if not Gui then return end
	EventNameLabel.Text = currentEvent.Name
	EventImage.Image = currentEvent.Image
end

local function tryRotateEvent()
	local executed = false

	pcall(function()
		Store:UpdateAsync(STATE_KEY, function(old)
			if typeof(old) ~= "table" then
				return {
					startEpoch = os.time(),
					eventName = pickRandomEvent().Name
				}
			end

			if os.time() - old.startEpoch < DURATION then
				return old
			end

			executed = true
			local nextEvent = pickRandomEvent()

			return {
				startEpoch = os.time(),
				eventName = nextEvent.Name
			}
		end)
	end)

	if executed then
		currentEvent.Action()
	end
end

local function syncFromStore()
	local ok, state = pcall(function()
		return Store:GetAsync(STATE_KEY)
	end)

	if ok and state then
		applyState(state)
		updateBoard()
	end
end

local function tryInitBoard()
	local board = ReplicatedStorage:FindFirstChild("EventBoard")
	if not board then return false end
	if board:GetAttribute("Hidden") then return false end

	local gui = board:FindFirstChild("SurfaceGui", true)
	if not gui then return false end

	local frame = gui:FindFirstChild("Frame", true)
	if not frame then return false end

	Board = board
	Gui = frame
	TimerLabel = frame:FindFirstChild("Timer", true)
	EventNameLabel = frame:FindFirstChild("Title", true)
	EventImage = frame:FindFirstChild("Vector", true)

	updateBoard()
	return true
end

function EventBoardService.Start()
	if running then return end
	running = true

	math.randomseed(os.time() + #game.JobId)

	task.spawn(function()
		while running do
			if not Board then
				if not tryInitBoard() then
					task.wait(1)
					continue
				end
				syncFromStore()
			end

			local remaining = remainingTime()
			if TimerLabel then
				TimerLabel.Text = formatTime(remaining)
			end

			if remaining <= 0 then
				tryRotateEvent()
				syncFromStore()
			end

			task.wait(1)
		end
	end)

	task.spawn(function()
		while running do
			syncFromStore()
			task.wait(SYNC_INTERVAL)
		end
	end)
end

function EventBoardService.Stop()
	running = false
end

return EventBoardService