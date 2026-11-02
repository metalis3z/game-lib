--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local eventsFolder = ReplicatedStorage:WaitForChild("Events")
local ShowReviveEvent = eventsFolder:WaitForChild("ShowRevive") :: RemoteEvent
local HideReviveEvent = eventsFolder:WaitForChild("HideRevive") :: RemoteEvent
local RequestReviveEvent = eventsFolder:WaitForChild("RequestRevive") :: RemoteEvent

-- Path: GUI/HUD/Top/Main/Revive
local gui = playerGui:WaitForChild("GUI")
local hud = gui:WaitForChild("HUD")
local top = hud:WaitForChild("Top")
local main = top:WaitForChild("Main")
local reviveFrame = main:WaitForChild("Revive") :: GuiObject

local reviveButton = (reviveFrame:IsA("GuiButton") and reviveFrame)
	or reviveFrame:FindFirstChild("ReviveButton", true)
	or reviveFrame:FindFirstChildWhichIsA("ImageButton", true)
	or reviveFrame:FindFirstChildWhichIsA("TextButton", true)

if not reviveButton then
	warn("[ReviveClient] Could not find revive button under", reviveFrame:GetFullName())
end

-- Revive.TextLabel
local textLabel = (reviveButton and (reviveButton :: Instance):FindFirstChild("TextLabel")) :: TextLabel?
	or reviveFrame:FindFirstChild("TextLabel", true) :: TextLabel?

local DEFAULT_TEXT = "Revive"

local activeTimerThread: thread? = nil

local function stopTimer()
	if activeTimerThread then
		task.cancel(activeTimerThread)
		activeTimerThread = nil
	end
end

local function hideRevive()
	stopTimer()
	reviveFrame.Visible = false
	if textLabel then
		textLabel.Text = DEFAULT_TEXT
	end
end

local function showRevive(duration: number)
	stopTimer()
	reviveFrame.Visible = true

	local timeLeft = duration

	if textLabel then
		textLabel.Text = "Revive (" .. tostring(timeLeft) .. ")"
	end

	activeTimerThread = task.spawn(function()
		while timeLeft > 0 do
			task.wait(1)
			timeLeft -= 1
			if textLabel then
				if timeLeft > 0 then
					textLabel.Text = "Revive (" .. tostring(timeLeft) .. ")"
				else
					textLabel.Text = DEFAULT_TEXT
				end
			end
		end
		hideRevive()
	end)
end

ShowReviveEvent.OnClientEvent:Connect(function(duration: number)
	showRevive(duration)
end)

HideReviveEvent.OnClientEvent:Connect(function()
	hideRevive()
end)

if reviveButton then
	(reviveButton :: GuiButton).MouseButton1Click:Connect(function()
		RequestReviveEvent:FireServer()
	end)
end