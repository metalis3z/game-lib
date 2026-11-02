local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)

local updateRemote    = Net:RemoteEvent("AdminService/UpdateEventsButton")
local eventsRemote    = Net:RemoteEvent("AdminService/ModdedEvents")
local saveKeyRemote   = Net:RemoteEvent("AdminService/SaveKey")

local player         = Players.LocalPlayer
local containerFrame = script.Parent.Misc.Frame
local eventsButtonUI = containerFrame.Events

for _, frame in pairs(script.Parent:GetDescendants()) do
	if frame:IsA("Frame") and frame.Name == "Key" then
		frame.Visible = not UserInputService.TouchEnabled
	end
end

local isEventsActive = true

local animatedEventsButton = AnimatedButton.new(eventsButtonUI)
animatedEventsButton:Animate()

eventsButtonUI.BackgroundColor3 = Color3.fromRGB(81, 158, 86)

local function doEvents()
	isEventsActive = not isEventsActive
	if isEventsActive then
		eventsButtonUI.BackgroundColor3 = Color3.fromRGB(81, 158, 86)
	else
		eventsButtonUI.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
	end
	eventsRemote:FireServer(isEventsActive)
end

animatedEventsButton.OnActivated:Connect(doEvents)

updateRemote.OnClientEvent:Connect(function(value)
	isEventsActive = value
	if isEventsActive then
		eventsButtonUI.BackgroundColor3 = Color3.fromRGB(81, 158, 86)
	else
		eventsButtonUI.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
	end
end)

local playerSync = Synchronizer:Wait(player)
local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name .. "_EventsToggle", eventsButtonUI, doEvents)
kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()