local ReplicatedStorage = game:GetService("ReplicatedStorage")

local gui = script.Parent
local topText = gui:WaitForChild("TopText")
local timeText = gui:WaitForChild("TimeText")

local currentRun = 0

local function formatTime(remaining)
	remaining = math.max(0, math.floor(remaining))

	local hours = math.floor(remaining / 3600)
	local minutes = math.floor((remaining % 3600) / 60)
	local seconds = remaining % 60

	if hours > 0 then
		return string.format("%dh %dm %ds", hours, minutes, seconds)
	elseif minutes > 0 then
		return string.format("%dm %02ds", minutes, seconds)
	else
		return string.format("%ds", seconds)
	end
end

local function stopTimer()
	currentRun += 1
	gui.Enabled = false
end

local function startTimer()
	currentRun += 1
	local run = currentRun

	local running = ReplicatedStorage:GetAttribute("GlobalTimerRunning")
	local title = ReplicatedStorage:GetAttribute("GlobalTimerTitle")
	local endTime = ReplicatedStorage:GetAttribute("GlobalTimerEndTime")

	if not running or not endTime or endTime <= 0 then
		gui.Enabled = false
		return
	end

	title = tostring(title or "UPDATE IN")
	topText.Text = title .. ":"
	gui.Enabled = true

	while run == currentRun do
		local stillRunning = ReplicatedStorage:GetAttribute("GlobalTimerRunning")
		local currentEndTime = ReplicatedStorage:GetAttribute("GlobalTimerEndTime")
		local currentTitle = ReplicatedStorage:GetAttribute("GlobalTimerTitle")

		if not stillRunning or not currentEndTime or currentEndTime <= 0 then
			gui.Enabled = false
			return
		end

		topText.Text = tostring(currentTitle or "UPDATE IN") .. ":"

		local remaining = math.max(0, math.floor(currentEndTime - workspace:GetServerTimeNow()))
		timeText.Text = formatTime(remaining)

		if remaining <= 0 then
			timeText.Text = "NOW!"
			return
		end

		task.wait(0.2)
	end
end

ReplicatedStorage:GetAttributeChangedSignal("GlobalTimerRunning"):Connect(function()
	local running = ReplicatedStorage:GetAttribute("GlobalTimerRunning")
	if running then
		startTimer()
	else
		stopTimer()
	end
end)

ReplicatedStorage:GetAttributeChangedSignal("GlobalTimerEndTime"):Connect(function()
	local running = ReplicatedStorage:GetAttribute("GlobalTimerRunning")
	if running then
		startTimer()
	end
end)

ReplicatedStorage:GetAttributeChangedSignal("GlobalTimerTitle"):Connect(function()
	local running = ReplicatedStorage:GetAttribute("GlobalTimerRunning")
	if running then
		startTimer()
	end
end)

task.defer(function()
	local running = ReplicatedStorage:GetAttribute("GlobalTimerRunning")
	if running then
		startTimer()
	else
		gui.Enabled = false
	end
end)