local ReplicatedStorage = game:GetService("ReplicatedStorage")
local fpsValue = ReplicatedStorage:WaitForChild("ServerFPS")
local textLabel = script.Parent

local function lerpColor(color1, color2, t)
	return Color3.new(
		color1.R + (color2.R - color1.R) * t,
		color1.G + (color2.G - color1.G) * t,
		color1.B + (color2.B - color1.B) * t
	)
end

local minFPS = 20
local maxFPS = 60
local minColor = Color3.fromRGB(255, 0, 0)
local maxColor = Color3.fromRGB(0, 255, 0)

local function updateLabel(fps)
	textLabel.Text = string.format("Server FPS: %d", fps)
	local t = math.clamp((fps - minFPS) / (maxFPS - minFPS), 0, 1)
	textLabel.TextColor3 = lerpColor(minColor, maxColor, t)
end

fpsValue:GetPropertyChangedSignal("Value"):Connect(function()
	updateLabel(fpsValue.Value)
end)

updateLabel(fpsValue.Value)
