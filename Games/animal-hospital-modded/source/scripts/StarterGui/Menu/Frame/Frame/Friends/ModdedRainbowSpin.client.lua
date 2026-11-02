local stroke = script.Parent:FindFirstChild("UIStroke") or script.Parent:FindFirstChild("ModdedOuterStroke")
local gradient = stroke and stroke:FindFirstChild("ModdedRainbow") or stroke and stroke:FindFirstChildOfClass("UIGradient")
if gradient then
    local RunService = game:GetService("RunService")
    local rotation = gradient.Rotation
    RunService.RenderStepped:Connect(function(dt)
        rotation = (rotation + dt * 90) % 360
        gradient.Rotation = rotation
    end)
end
