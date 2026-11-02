local Part = script.Parent
Part.Parent:WaitForChild("Goal")
local ts = game:GetService("TweenService")
local ti = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true)

local tween = ts:Create(Part, ti, {Position = script.Parent.Parent.Goal.Position}):Play()