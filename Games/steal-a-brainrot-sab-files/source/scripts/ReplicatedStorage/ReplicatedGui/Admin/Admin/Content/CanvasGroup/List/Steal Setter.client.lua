local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local GiveStealRemote = Net:RemoteFunction("AdminService/GiveSteal")
local StealFrame = script.Parent.Steal.Frame
local InputField = StealFrame.mainMutation

local SetButton = AnimatedButton.new(StealFrame.Set)
local AddButton = AnimatedButton.new(StealFrame.Add)

SetButton:Animate()
AddButton:Animate()

local function handleStealRequest(amount, isAdding)
	local numericAmount = tonumber(amount)

	if not numericAmount then
		NotificationController:Notify("<font color=\"#FA0103\">Please enter a valid number.</font>", 5, "Sounds.Sfx.Error")
		return
	end

	local success, response = GiveStealRemote:InvokeServer(numericAmount, isAdding)

	if success then
		NotificationController:Success("Steal update successful!")
	else
		NotificationController:Error(response or "Failed to update Steals.")
	end
end


local function onSetClicked()
	handleStealRequest(InputField.Text, false)
end
SetButton.OnActivated:Connect(onSetClicked)

local function onAddClicked()
	handleStealRequest(InputField.Text, true)
end

AddButton.OnActivated:Connect(onAddClicked)

local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local player = game.Players.LocalPlayer
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name.."_ServerStart",StealFrame.Set, onSetClicked)
kb:RegisterButton(script.Name.."_ServerStop",StealFrame.Add, onAddClicked)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()


