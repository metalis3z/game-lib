local gradient = script.Parent:WaitForChild("UIGradient")
local runService = game:GetService("RunService")

local segments = 7 -- number of color keypoints
local speed = 0.2 -- animation speed
local offset = 0

runService.RenderStepped:Connect(function(deltaTime)
	offset = (offset + deltaTime * speed) % 1

	local keypoints = {}
	for i = 0, segments do
		local position = i / segments
		local hue = (position + offset) % 1
		local color = Color3.fromHSV(hue, 1, 1)
		table.insert(keypoints, ColorSequenceKeypoint.new(position, color))
	end

	gradient.Color = ColorSequence.new(keypoints)
end)
