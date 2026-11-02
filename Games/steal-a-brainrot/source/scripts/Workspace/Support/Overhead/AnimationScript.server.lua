local rootPart = script.Parent
local runService = game:GetService("RunService")

-- Save base CFrame once
local baseCFrame = rootPart.CFrame
local basePosition = baseCFrame.Position
local time = 0

-- Hover settings
local hoverAmplitude = 0.4
local hoverFrequency = 0.25

-- Drift settings
local tiltAmplitude = math.rad(1.5)     -- X/Z tilt
local yawDriftAmplitude = math.rad(2)   -- Y drift
local driftFrequency = 0.1              -- slow motion

runService.Heartbeat:Connect(function(dt)
	time += dt

	-- Vertical motion
	local verticalOffset = math.sin(time * hoverFrequency * 2 * math.pi) * hoverAmplitude

	-- Gentle rotation drift
	local driftX = math.sin(time * driftFrequency * 2 * math.pi) * tiltAmplitude
	local driftY = math.cos(time * driftFrequency * 2 * math.pi) * yawDriftAmplitude
	local driftZ = math.sin(time * driftFrequency * 2 * math.pi + math.pi / 3) * tiltAmplitude

	-- Final position and orientation
	local offsetPosition = basePosition + Vector3.new(0, verticalOffset, 0)
	local driftRotation = CFrame.Angles(driftX, driftY, driftZ)

	-- Combine base orientation with gentle drift
	rootPart.CFrame = CFrame.new(offsetPosition) * baseCFrame.Rotation * driftRotation
end)
