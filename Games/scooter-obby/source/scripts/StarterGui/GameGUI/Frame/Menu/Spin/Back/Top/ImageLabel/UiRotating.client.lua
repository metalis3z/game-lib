local TweenService = game:GetService("TweenService")
local Spinny = script.Parent -- The object you want to tween.

local tweenInfo = TweenInfo.new(
	5, -- The time the tween takes to complete
	Enum.EasingStyle.Linear, -- The tween style.
	Enum.EasingDirection.Out, -- EasingDirection
	-1, -- How many times you want the tween to repeat. If you make it less than 0 it will repeat forever.
	false, -- Reverse?
	0 -- Delay
)

local Tween = TweenService:Create(Spinny, tweenInfo, {Rotation = 360}) -- Creates the tween with the TweenInfo and what properties you want to change
Tween:Play() -- Plays the tween