local grad = script.Parent:FindFirstChild("ModdedRainbow") or script.Parent:FindFirstChildOfClass("UIGradient")
if not grad then return end
local RunService = game:GetService("RunService")
local rotation = grad.Rotation
RunService.RenderStepped:Connect(function(dt)
	rotation = (rotation + dt * 55) % 360
	grad.Rotation = rotation
end)
