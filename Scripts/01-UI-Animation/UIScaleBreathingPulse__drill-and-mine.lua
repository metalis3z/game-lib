-- Reference copy for study. Game: +1 Drill & Mine (drill-and-mine)
-- Original: StarterGui/GUI/HUD/X2DrillPanel/X2Drill/MusclePulse.client.lua  (client, 17 lines)
-- Categories: n/a
-- What it does: Minimal infinite "breathing" pulse: UIScale tween 1 -> 1.10, Sine InOut, repeat -1, reverses. Comment explains why UIScale beats Size tweening.

-- Gentle zoom pulse on the background muscle. Anchored center + parent
-- ClipsDescendants means it can never draw outside the button frame.
local TweenService = game:GetService("TweenService")
local mus = script.Parent:WaitForChild("Muscle")
-- Pulse via a UIScale (one smooth scalar) instead of a 2-axis Size tween --
-- the UIAspectRatioConstraint was re-clamping the Size every frame, which read
-- as jitter. Base size stays fixed; the UIScale does the breathing.
mus.Size = UDim2.new(1.45, 0, 1.45, 0)
local scale = mus:FindFirstChildOfClass("UIScale")
if not scale then
	scale = Instance.new("UIScale")
	scale.Parent = mus
end
scale.Scale = 1
local INFO = TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
TweenService:Create(scale, INFO, { Scale = 1.10 }):Play()
