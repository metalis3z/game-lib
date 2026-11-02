local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SparkleEffectGui"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui
screenGui.DisplayOrder = 99

local CIRCLE_COUNT = 8
local STREAK_COUNT = 8
local CIRCLE_SIZE_MIN = 4
local CIRCLE_SIZE_MAX = 10
local STREAK_LENGTH_MIN = 12
local STREAK_LENGTH_MAX = 28
local STREAK_WIDTH = 2
local SPREAD_RADIUS = 60
local LIFETIME = 0.5

local COLOR = Color3.fromRGB(255, 255, 255)

local function createCircle(clickPos, angle, distance)
	local size = math.random(CIRCLE_SIZE_MIN, CIRCLE_SIZE_MAX)

	local frame = Instance.new("Frame")
	frame.Name = "SparkleCircle"
	frame.Size = UDim2.fromOffset(size, size)
	frame.Position = UDim2.fromOffset(clickPos.X, clickPos.Y)
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.BackgroundColor3 = COLOR
	frame.BackgroundTransparency = 0
	frame.BorderSizePixel = 0
	frame.ZIndex = 100

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = frame

	frame.Parent = screenGui

	local targetX = clickPos.X + math.cos(angle) * distance
	local targetY = clickPos.Y + math.sin(angle) * distance

	local tween = TweenService:Create(frame, TweenInfo.new(
		LIFETIME,
		Enum.EasingStyle.Quad,
		Enum.EasingDirection.Out
		), {
			Position = UDim2.fromOffset(targetX, targetY),
			Size = UDim2.fromOffset(0, 0),
			BackgroundTransparency = 1,
		})

	tween:Play()
	tween.Completed:Connect(function()
		frame:Destroy()
	end)
end

local function createStreak(clickPos, angle, distance)
	local length = math.random(STREAK_LENGTH_MIN, STREAK_LENGTH_MAX)

	local frame = Instance.new("Frame")
	frame.Name = "SparkleStreak"
	frame.Size = UDim2.fromOffset(length, STREAK_WIDTH)
	frame.Position = UDim2.fromOffset(clickPos.X, clickPos.Y)
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.BackgroundColor3 = COLOR
	frame.BackgroundTransparency = 0
	frame.BorderSizePixel = 0
	frame.ZIndex = 100
	frame.Rotation = math.deg(angle)

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 1)
	corner.Parent = frame

	frame.Parent = screenGui

	local targetX = clickPos.X + math.cos(angle) * distance
	local targetY = clickPos.Y + math.sin(angle) * distance

	local tween = TweenService:Create(frame, TweenInfo.new(
		LIFETIME,
		Enum.EasingStyle.Quad,
		Enum.EasingDirection.Out
		), {
			Position = UDim2.fromOffset(targetX, targetY),
			Size = UDim2.fromOffset(0, 0),
			BackgroundTransparency = 1,
		})

	tween:Play()
	tween.Completed:Connect(function()
		frame:Destroy()
	end)
end

local function createSparkleBurst(clickPos)
	for i = 1, CIRCLE_COUNT do
		local angle = (math.pi * 2 / CIRCLE_COUNT) * i + math.rad(math.random(-15, 15))
		local dist = math.random(SPREAD_RADIUS * 0.5, SPREAD_RADIUS)
		createCircle(clickPos, angle, dist)
	end

	for i = 1, STREAK_COUNT do
		local angle = (math.pi * 2 / STREAK_COUNT) * i + math.rad(180 / STREAK_COUNT) + math.rad(math.random(-10, 10))
		local dist = math.random(SPREAD_RADIUS * 0.4, SPREAD_RADIUS * 0.9)
		createStreak(clickPos, angle, dist)
	end
end

local GuiService = game:GetService("GuiService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		local inset = GuiService:GetGuiInset()
		local pos = Vector2.new(input.Position.X, input.Position.Y + inset.Y)
		createSparkleBurst(pos)
	end
end)