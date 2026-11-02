local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Net = require(ReplicatedStorage.Packages.Net)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Freecam = require(script.Freecam)
local ResetDataRemote = Net:RemoteEvent("AdminService/ResetData")
local ResetKeysRemote = Net:RemoteEvent("AdminService/ResetKeys")

local ResetDebounce = nil

script.Parent.Misc.Frame.Freecam.Visible = not UserInputService.TouchEnabled

for _, frame in pairs(script.Parent:GetDescendants()) do
	if frame:IsA("Frame") and frame.Name == "Key" then
		frame.Visible = not UserInputService.TouchEnabled
	end
end

local FreecamBtn = AnimatedButton.new(script.Parent.Misc.Frame.Freecam)
FreecamBtn:Animate()

local function DoFreecam()
	Freecam.Start()
end

FreecamBtn.OnActivated:Connect(DoFreecam)

local player = game.Players.LocalPlayer
local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name.."_ServerStart", script.Parent.Misc.Frame.Freecam, DoFreecam)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()
