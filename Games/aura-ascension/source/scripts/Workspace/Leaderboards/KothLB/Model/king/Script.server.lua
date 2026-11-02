local RunService = game:GetService("RunService")

local part = script.Parent
local cframe = part.CFrame
local eTime = 0

RunService.Heartbeat:Connect(function(deltaTime)
	eTime += deltaTime

	local bob = math.sin((eTime + 1) * 1.5) * 0.25
	local angle = math.rad((eTime * 60) % 360)
	part.CFrame = cframe * CFrame.new(0, bob, 0) * CFrame.Angles(0, angle, 0)
end)