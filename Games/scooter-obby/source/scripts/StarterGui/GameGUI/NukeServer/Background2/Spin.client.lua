local speed = 20

local runService = game:GetService("RunService")

runService.RenderStepped:Connect(function(dt)
	script.Parent.Rotation += (speed * dt)
end)