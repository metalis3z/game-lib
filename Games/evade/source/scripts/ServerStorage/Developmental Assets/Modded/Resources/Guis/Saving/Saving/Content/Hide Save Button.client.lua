local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Net = require(ReplicatedStorage.Packages.Net)

local AlertsFrame = script.Parent.Hide
local Button: ImageButton = script.Parent.Parent.Parent.Parent.LeftCenter.LeftCenter.Buttons:WaitForChild("Saves")

local function setState(state: boolean)
	if state then
		AlertsFrame.ImageColor3 = Color3.fromRGB(255, 255, 255)
		Button.Visible = false
	else
		AlertsFrame.ImageColor3 = Color3.fromRGB(255, 0, 0)
		Button.Visible = true
	end
end

local isOn = false

local Toggle = AnimatedButton.new(AlertsFrame)
Toggle:Animate()
Toggle.OnActivated:Connect(function()
	isOn = not isOn
	
	setState(isOn)
end)

TextChatService:WaitForChild("KiwiGames"):WaitForChild("Saves").Triggered:Connect(function()
	isOn = false
	setState(isOn)
end)