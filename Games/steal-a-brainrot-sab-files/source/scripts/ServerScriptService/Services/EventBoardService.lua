local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Eventservice = require(ServerScriptService.Services.EventService)
local Timer = require(ReplicatedStorage.Packages.Timer)
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local IsBoardActive = false
local TOTAL_CYCLE = 3600

local eventboardservice = {}

function eventboardservice:Start()
	if not IsBoardActive then return  end
	local eventBoard = workspace:WaitForChild("EventBoard")
	local timerLabel = eventBoard:WaitForChild("SurfaceGui"):WaitForChild("Frame"):WaitForChild("Timer")

	local function getNextHourTime()
		local currentTime = os.time()
		local secondsIntoHour = currentTime % TOTAL_CYCLE
		return currentTime + (TOTAL_CYCLE - secondsIntoHour)
	end

	local nextEventTime = getNextHourTime()

	local countdownTimer = Timer.new(1)
	countdownTimer.Tick:Connect(function()
		local currentTime = os.time()
		local timeRemaining = nextEventTime - currentTime

		timerLabel.Text = TimeUtils:E(math.max(0, timeRemaining))

		if timeRemaining <= 0 then
			Eventservice:ExecuteEvent("Backrooms", 900)
			nextEventTime = getNextHourTime()
		end
	end)
	countdownTimer:Start()

	timerLabel.Text = TimeUtils:E(nextEventTime - os.time())
end

return eventboardservice