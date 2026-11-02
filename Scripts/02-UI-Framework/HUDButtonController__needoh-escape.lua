-- Reference copy for study. Game: +1 NeeDoh Escape (needoh-escape)
-- Original: +1 Speed V1 Kit/StarterPlayerScripts/HUDButtonController.client.lua
-- What it does: HUD buttons that pop menu panels open/closed by tweening a UIScale (Back ease in, Quint out), with one-panel-at-a-time logic and reset on respawn.

--!strict
-- LOCATION: StarterPlayerScripts/HUDButtonController
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local gui = playerGui:WaitForChild("GUI")
local hud = gui:WaitForChild("HUD")
local frames = gui:WaitForChild("Frames")
local hudLeft = hud:WaitForChild("Left")
local rebirthHudButton = hudLeft:WaitForChild("Rebirth") :: ImageButton
local trailsHudButton = hudLeft:WaitForChild("Trails") :: ImageButton
local settingsHudButton = hudLeft:WaitForChild("Settings") :: ImageButton
local rebirthFrame = frames:WaitForChild("Rebirth")
local trailsFrame = frames:WaitForChild("Trails")
local settingsFrame = frames:WaitForChild("Settings")
local rebirthCloseButton = rebirthFrame:WaitForChild("Close", 10) :: ImageButton
local trailsCloseButton = trailsFrame:WaitForChild("Close", 10) :: ImageButton
local settingsCloseButton = settingsFrame:WaitForChild("Close", 10) :: ImageButton

local OPEN_INFO  = TweenInfo.new(0.35, Enum.EasingStyle.Back,  Enum.EasingDirection.Out)
local CLOSE_INFO = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In)

local currentOpenPanel: Frame? = nil
local closingPanels: {[Frame]: boolean} = {}

local function getOrCreateScale(frame: Frame): UIScale
	local s = frame:FindFirstChildOfClass("UIScale")
	if not s then
		s = Instance.new("UIScale")
		s.Parent = frame
	end
	return s
end

local function closeFrame(frame: Frame, onDone: (() -> ())?)
	if closingPanels[frame] then return end
	closingPanels[frame] = true
	local s = getOrCreateScale(frame)
	local t = TweenService:Create(s, CLOSE_INFO, {Scale = 0})
	t.Completed:Connect(function()
		closingPanels[frame] = nil
		frame.Visible = false
		if onDone then onDone() end
	end)
	t:Play()
end

local function openFrame(frame: Frame)
	if currentOpenPanel and currentOpenPanel ~= frame and currentOpenPanel.Visible then
		closeFrame(currentOpenPanel, function()
			if currentOpenPanel == currentOpenPanel then
				currentOpenPanel = nil
			end
		end)
	end
	currentOpenPanel = frame
	closingPanels[frame] = nil
	local s = getOrCreateScale(frame)
	s.Scale = 0
	frame.Visible = true
	TweenService:Create(s, OPEN_INFO, {Scale = 1}):Play()
end

local function toggleFrame(frame: Frame)
	if frame.Visible and not closingPanels[frame] then
		closeFrame(frame, function()
			if currentOpenPanel == frame then currentOpenPanel = nil end
		end)
	elseif not frame.Visible then
		openFrame(frame)
	end
end

-- HUD open buttons
rebirthHudButton.MouseButton1Click:Connect(function()
	toggleFrame(rebirthFrame)
end)
trailsHudButton.MouseButton1Click:Connect(function()
	toggleFrame(trailsFrame)
end)
settingsHudButton.MouseButton1Click:Connect(function()
	toggleFrame(settingsFrame)
end)

-- Close buttons inside each frame
rebirthCloseButton.MouseButton1Click:Connect(function()
	if rebirthFrame.Visible and not closingPanels[rebirthFrame] then
		closeFrame(rebirthFrame, function()
			if currentOpenPanel == rebirthFrame then currentOpenPanel = nil end
		end)
	end
end)
trailsCloseButton.MouseButton1Click:Connect(function()
	if trailsFrame.Visible and not closingPanels[trailsFrame] then
		closeFrame(trailsFrame, function()
			if currentOpenPanel == trailsFrame then currentOpenPanel = nil end
		end)
	end
end)
settingsCloseButton.MouseButton1Click:Connect(function()
	if settingsFrame.Visible and not closingPanels[settingsFrame] then
		closeFrame(settingsFrame, function()
			if currentOpenPanel == settingsFrame then currentOpenPanel = nil end
		end)
	end
end)

-- Close panels on respawn
player.CharacterAdded:Connect(function()
	for _, frame in {rebirthFrame, trailsFrame, settingsFrame} do
		if frame.Visible then
			frame.Visible = false
			local s = frame:FindFirstChildOfClass("UIScale")
			if s then s.Scale = 0 end
		end
		closingPanels[frame] = nil
	end
	currentOpenPanel = nil
end)

-- Init: all closed
for _, frame in {rebirthFrame, trailsFrame, settingsFrame} do
	frame.Visible = false
	getOrCreateScale(frame).Scale = 0
end