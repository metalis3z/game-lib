local events = {
	"",
	"Winter Hour",
	"Gingerbread Town"
}

local RunService = game:GetService("RunService")
local DataStoreService = game:GetService("DataStoreService")
local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local timeutils = require(ReplicatedStorage.Utils.TimeUtils)
local EventService = require(script.Parent.EventService)

local EventStore = DataStoreService:GetDataStore("GlobalEventTimestamp")

local WAIT_DURATION = 60 * 60
local EVENT_DURATION = 900

local nextEventTime = 0
local activeEvent = nil
local canActivate = true

local function pickRandomEvent()
	return events[math.random(1, #events)]
end

local function loadGlobalTime()
	local success, stored = pcall(function()
		return EventStore:GetAsync("NextEvent")
	end)

	local now = os.time()
	if not success or stored == nil or stored <= now then
		stored = now + WAIT_DURATION
		pcall(function()
			EventStore:SetAsync("NextEvent", stored)
		end)
	end

	nextEventTime = stored
	canActivate = true
end

local function updateGlobalTime()
	pcall(function()
		EventStore:SetAsync("NextEvent", nextEventTime)
		MessagingService:PublishAsync("EVENT_TIME_CHANGED", nextEventTime)
	end)
end

MessagingService:SubscribeAsync("EVENT_TIME_CHANGED", function(msg)
	nextEventTime = msg.Data
	canActivate = true
end)

local function updateBoard(isWaiting)
	local board = workspace:FindFirstChild("EventBoard")
	if not board then return end

	local gui = board:FindFirstChild("SurfaceGui")
	if not gui then return end

	local frame = gui.Frame

	if activeEvent then
		frame.Title.Text = activeEvent

		local folder = script:FindFirstChild(activeEvent)
		if folder and folder:FindFirstChild("Main") then
			frame.Vector.Image = folder.Main.Image
		end
	end

	if isWaiting then
		local remaining = math.max(0, nextEventTime - os.time())
		frame.Timer.Text = timeutils:D(remaining)
	else
		frame.Timer.Text = ""
	end
end

loadGlobalTime()
activeEvent = pickRandomEvent()
updateBoard(true)

RunService.Heartbeat:Connect(function()
	local now = os.time()
	local board = workspace:FindFirstChild("EventBoard")
	if not board then return end

	local frame = board.SurfaceGui.Frame

	if canActivate then
		local remaining = nextEventTime - now
		frame.Timer.Text = timeutils:D(math.max(0, remaining))

		if remaining <= 0 then
			canActivate = false


			activeEvent = pickRandomEvent()
			updateBoard(false)

			EventService:ExecuteEvent(activeEvent, EVENT_DURATION)
		end
	else
		local info = EventService.ActiveEvents[activeEvent]

		if not info or (info.endsAt - workspace:GetServerTimeNow()) <= 0 then
			canActivate = true
			nextEventTime = os.time() + WAIT_DURATION
			updateGlobalTime()
			updateBoard(true)
		else
			frame.Timer.Text = timeutils:D(
				math.max(0, info.endsAt - workspace:GetServerTimeNow())
			)
		end
	end
end)
