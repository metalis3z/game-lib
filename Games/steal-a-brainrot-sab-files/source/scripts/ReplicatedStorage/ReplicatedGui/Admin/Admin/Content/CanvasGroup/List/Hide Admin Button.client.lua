local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)

local player = Players.LocalPlayer
local containerFrame = script.Parent.Misc.Frame
local hideButtonUI = containerFrame.Hide
local adminButton = script.Parent.Parent.Parent.Parent.Parent.Parent.LeftCenter.LeftCenter.Buttons:WaitForChild("Admin")

local saveKeyRemote = Net:RemoteEvent("AdminService/SaveKey")
local playerSync = Synchronizer:Wait(player)

local isAdminHidden = false


local animatedHideButton = AnimatedButton.new(hideButtonUI)
animatedHideButton:Animate()

local function toggleAdminVisibility()
	isAdminHidden = not isAdminHidden

	if isAdminHidden then
		hideButtonUI.BackgroundColor3 = Color3.fromRGB(81, 158, 86)
		adminButton.Visible = false
	else
		hideButtonUI.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
		adminButton.Visible = true
	end
end

animatedHideButton.OnActivated:Connect(toggleAdminVisibility)


local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name .. "_ServerStart", hideButtonUI, toggleAdminVisibility)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()