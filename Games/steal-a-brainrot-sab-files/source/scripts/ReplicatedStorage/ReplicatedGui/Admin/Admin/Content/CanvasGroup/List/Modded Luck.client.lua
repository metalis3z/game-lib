local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local updateremote = Net:RemoteEvent("AdminService/UpdateModdedButton")
local luckRemote = Net:RemoteEvent("AdminService/ModdedLuck")
local saveKeyRemote = Net:RemoteEvent("AdminService/SaveKey")

local player = Players.LocalPlayer
local containerFrame = script.Parent.Misc.Frame
local luckButtonUI = containerFrame.Luck


for _, frame in pairs(script.Parent:GetDescendants()) do
	if frame:IsA("Frame") and frame.Name == "Key" then
		frame.Visible = not UserInputService.TouchEnabled
	end
end


local isLuckActive = true

local animatedLuckButton = AnimatedButton.new(luckButtonUI)
animatedLuckButton:Animate()

luckButtonUI.BackgroundColor3 = Color3.fromRGB(81, 158, 86)

local function doLuck()
	isLuckActive = not isLuckActive

	if isLuckActive then
		luckButtonUI.BackgroundColor3 = Color3.fromRGB(81, 158, 86)
	else
		luckButtonUI.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
	end

	luckRemote:FireServer(isLuckActive)
end

animatedLuckButton.OnActivated:Connect(doLuck)

updateremote.OnClientEvent:Connect(function(value)
	isLuckActive = value

	if isLuckActive then
		luckButtonUI.BackgroundColor3 = Color3.fromRGB(81, 158, 86)
	else
		luckButtonUI.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
	end
end)

local playerSync = Synchronizer:Wait(player)
local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name .. "_LuckToggle", luckButtonUI, doLuck)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()