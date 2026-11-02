local RunService = game:GetService("RunService")
local gradient = script.Parent
local baseColors = {
	Color3.fromRGB(255, 0, 0),
	Color3.fromRGB(255, 165, 0), 
	Color3.fromRGB(255, 255, 0), 
	Color3.fromRGB(0, 255, 0), 
	Color3.fromRGB(0, 127, 255),
	Color3.fromRGB(139, 0, 255),
}
local colorCount = #baseColors
local segmentCount = 15
local speed = 0.5
local offset = 0
local function generateGradient(offset)
	local keypoints = {}
	for i = 0, segmentCount do
		local t = (i / segmentCount + offset) % 1
		local colorIndex = t * colorCount
		local i0 = math.floor(colorIndex) % colorCount + 1
		local i1 = (i0) % colorCount + 1
		local alpha = colorIndex % 1
		local color0 = baseColors[i0]
		local color1 = baseColors[i1]
		local lerped = Color3.new(
			color0.R + (color1.R - color0.R) * alpha,
			color0.G + (color1.G - color0.G) * alpha,
			color0.B + (color1.B - color0.B) * alpha
		)
		table.insert(keypoints, ColorSequenceKeypoint.new(i / segmentCount, lerped))
	end
	return ColorSequence.new(keypoints)
end
RunService.Heartbeat:Connect(function(dt)
	offset = (offset + dt * speed) % 1
	gradient.Color = generateGradient(offset)
end)
