-- Reference copy for study. Game: +1 Drill & Mine (drill-and-mine)
-- Original: StarterGui/GUI/HUD/LeftSide/Left/Shop/RotateIcon/LocalScript.client.lua  (client, 32 lines)
-- Categories: n/a
-- What it does: Endless Sine InOut rotation rock (+10 / -20 degrees) for an idle shop icon.

local TweenService = game:GetService("TweenService")
local uiObject = script.Parent  -- the UI element this script is under

-- Settings
local angle = 10 -- how far it rotates (degrees)
local angle2 = 20
local tweenTime = 1 -- how long each side takes

-- Tween info (smooth in/out)
local tweenInfo = TweenInfo.new(
	tweenTime,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.InOut
)

-- Rotations
local goal1 = {Rotation = angle}
local goal2 = {Rotation = -angle2}

while true do
	-- Rotate right
	local tween1 = TweenService:Create(uiObject, tweenInfo, goal1)
	tween1:Play()
	tween1.Completed:Wait()

	-- Rotate left
	local tween2 = TweenService:Create(uiObject, tweenInfo, goal2)
	tween2:Play()
	tween2.Completed:Wait()
	
end
