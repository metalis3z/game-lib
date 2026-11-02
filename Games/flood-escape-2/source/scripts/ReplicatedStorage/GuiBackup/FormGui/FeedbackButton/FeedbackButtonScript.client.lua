local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FormModules = ReplicatedStorage:WaitForChild("FormModules")
local Config = require(FormModules:WaitForChild("Config"))

local FeedbackButton = script.Parent
local Gradient = FeedbackButton.UIGradient
local Icon = FeedbackButton.FeedbackIcon
Icon.Image = Config.Icon

local FormGui = FeedbackButton.Parent
local ToggleForm = FormGui:WaitForChild("ToggleForm")  

local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In, 10)

FeedbackButton.Activated:Connect(function ()
	Gradient.Enabled = true
	
	local shimmer = TweenService:Create(Gradient, tweenInfo, { Offset = Vector2.new(1, 0) })
	shimmer:Play()
	
	ToggleForm:Invoke(Config.FormId)

	shimmer:Cancel()
	Gradient.Enabled = false
end)