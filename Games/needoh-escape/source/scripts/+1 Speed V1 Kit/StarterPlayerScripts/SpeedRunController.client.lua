--!strict
-- LOCATION: StarterPlayerScripts/SpeedRunClient
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local TOGGLE_ON_IMAGE  = "rbxassetid://138835265990110"
local TOGGLE_OFF_IMAGE = "rbxassetid://110859788740064"

local events = ReplicatedStorage:WaitForChild("Events")
local SpeedRunStart  = events:WaitForChild("SpeedRunStart") :: RemoteEvent
local SpeedRunEnd    = events:WaitForChild("SpeedRunEnd") :: RemoteEvent
local SpeedRunReset  = events:WaitForChild("SpeedRunReset") :: RemoteEvent
local SpeedRunToggle = events:WaitForChild("SpeedRunToggle") :: RemoteEvent
local SpeedRunInit   = events:WaitForChild("SpeedRunInit") :: RemoteEvent

local gui            = playerGui:WaitForChild("GUI")
local hud            = gui:WaitForChild("HUD")
local top            = hud:WaitForChild("Top")
local mainTop        = top:WaitForChild("Main")
local timerLabel     = mainTop:WaitForChild("Timer") :: TextLabel
local right          = hud:WaitForChild("Right")
local speedRunButton = right:WaitForChild("SpeedRun") :: TextButton
local texture        = speedRunButton:WaitForChild("Texture") :: ImageLabel

-- Store the original text color so we can restore it on reset
local DEFAULT_TEXT_COLOR = timerLabel.TextColor3

local isToggledOn = false
local isRunning   = false
local startTime   = 0
local heartbeatConn: RBXScriptConnection? = nil

local function formatTime(seconds: number): string
	local minutes = math.floor(seconds / 60)
	local secs    = math.floor(seconds % 60)
	local millis  = math.floor((seconds % 1) * 1000)
	return string.format("%02d:%02d.%03d", minutes, secs, millis)
end

local function updateTextureImage()
	texture.Image = isToggledOn and TOGGLE_ON_IMAGE or TOGGLE_OFF_IMAGE
end

local function stopHeartbeat()
	if heartbeatConn then
		heartbeatConn:Disconnect()
		heartbeatConn = nil
	end
end

local function resetTimer()
	isRunning = false
	stopHeartbeat()
	timerLabel.TextColor3 = DEFAULT_TEXT_COLOR
	timerLabel.Visible = false
	timerLabel.Text = "00:00.000"
end

local function startTimer()
	isRunning = true
	startTime = os.clock()
	timerLabel.TextColor3 = DEFAULT_TEXT_COLOR
	timerLabel.Visible = true
	timerLabel.Text = "00:00.000"
	stopHeartbeat()
	heartbeatConn = RunService.Heartbeat:Connect(function()
		if not isRunning then return end
		timerLabel.Text = formatTime(os.clock() - startTime)
	end)
end

local function stopTimer(finalTime: number)
	isRunning = false
	stopHeartbeat()
	timerLabel.Text = formatTime(finalTime)

	-- Flash green then fade out
	timerLabel.TextColor3 = Color3.fromRGB(80, 200, 80)
	task.delay(2, function()
		if not isRunning then
			timerLabel.TextColor3 = DEFAULT_TEXT_COLOR
			timerLabel.Visible = false
		end
	end)
end

speedRunButton.MouseButton1Click:Connect(function()
	isToggledOn = not isToggledOn
	updateTextureImage()
	SpeedRunToggle:FireServer(isToggledOn)
	if not isToggledOn then
		resetTimer()
	end
end)

SpeedRunStart.OnClientEvent:Connect(function(elapsed: number?)
	if elapsed and elapsed > 0 then
		isRunning = true
		startTime = os.clock() - elapsed
		timerLabel.TextColor3 = DEFAULT_TEXT_COLOR
		timerLabel.Visible = true
		timerLabel.Text = formatTime(elapsed)
		stopHeartbeat()
		heartbeatConn = RunService.Heartbeat:Connect(function()
			if not isRunning then return end
			timerLabel.Text = formatTime(os.clock() - startTime)
		end)
	else
		startTimer()
	end
end)

SpeedRunEnd.OnClientEvent:Connect(function(finalTime: number)
	stopTimer(finalTime)
end)

SpeedRunReset.OnClientEvent:Connect(function()
	resetTimer()
end)

SpeedRunInit.OnClientEvent:Connect(function(savedToggle: boolean, bestTime: string)
	isToggledOn = savedToggle
	updateTextureImage()
end)

updateTextureImage()
timerLabel.Visible = false
timerLabel.Text = "00:00.000"