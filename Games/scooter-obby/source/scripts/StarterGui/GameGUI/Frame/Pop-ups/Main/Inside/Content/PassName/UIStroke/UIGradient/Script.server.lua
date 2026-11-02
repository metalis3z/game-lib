local runService = game:GetService("RunService")

runService.RenderStepped:Connect(function(dt)
	local fpsEven = dt * 60
	script.Parent.Rotation += .2 * fpsEven
end)