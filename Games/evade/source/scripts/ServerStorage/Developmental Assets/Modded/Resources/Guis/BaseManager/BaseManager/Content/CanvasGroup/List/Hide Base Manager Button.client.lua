local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Net = require(ReplicatedStorage.Packages.Net)

local AlertsFrame = script.Parent.Hide.Frame

local Button: ImageButton = script.Parent.Parent.Parent.Parent.Parent.Parent.LeftCenter.LeftCenter.Buttons:WaitForChild("BaseManager")

local function setState(state: boolean)
	if state then
		AlertsFrame.Toggle.ImageColor3 = Color3.fromRGB(255, 255, 255)
		AlertsFrame.Toggle.Price.Text = "ON"
		Button.Visible = false
	else
		AlertsFrame.Toggle.ImageColor3 = Color3.fromRGB(255, 0, 0)
		AlertsFrame.Toggle.Price.Text = "OFF"
		Button.Visible = true
	end
end

local isOn = false

local Toggle = AnimatedButton.new(AlertsFrame.Toggle)
Toggle:Animate()
Toggle.OnActivated:Connect(function()
	isOn = not isOn
	
	setState(isOn)
end)

TextChatService:WaitForChild("KiwiGames"):WaitForChild("BaseManager").Triggered:Connect(function()
	isOn = false
	setState(isOn)
end)