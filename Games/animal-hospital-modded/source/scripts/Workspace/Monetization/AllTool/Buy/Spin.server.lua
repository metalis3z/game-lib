--[[ Gira el Buy solo en el eje Y del MUNDO (vertical), sin moverse ni tumbarse. ]]
local RunService = game:GetService("RunService")
local part = script.Parent
local SPEED = math.rad(70)            -- grados/seg
local pos = part.Position
local baseRot = part.CFrame - pos     -- orientación base (preserva inclinación)
local yaw = 0
RunService.Heartbeat:Connect(function(dt)
	yaw = yaw + SPEED * dt
	part.CFrame = CFrame.new(pos) * CFrame.Angles(0, yaw, 0) * baseRot
end)
