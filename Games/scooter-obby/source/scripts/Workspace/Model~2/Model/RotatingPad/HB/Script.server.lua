local union = script.Parent
local runs = game:GetService("RunService")

runs.RenderStepped:Connect(function(dt)
	union.CFrame *= CFrame.Angles(0,math.rad(30 * dt),0)
end)