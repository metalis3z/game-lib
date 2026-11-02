local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)

local giveMoneyRemote = Net:RemoteFunction("AdminService/GiveMoney")
local saveKeyRemote = Net:RemoteEvent("AdminService/SaveKey")

local moneyFrame = script.Parent.Money.Frame
local inputField = moneyFrame.mainMutation
local setButtonUI = moneyFrame.Set
local addButtonUI = moneyFrame.Add

local player = Players.LocalPlayer
local playerSync = Synchronizer:Wait(player)


local setButton = AnimatedButton.new(setButtonUI)
setButton:Animate()

local function onSetMoneyClicked()
	local amount = tonumber(inputField.Text)
	local success, errorMessage = giveMoneyRemote:InvokeServer(amount, false)

	if not success then
		NotificationController:Error(errorMessage)
	end
end

setButton.OnActivated:Connect(onSetMoneyClicked)

local addButton = AnimatedButton.new(addButtonUI)
addButton:Animate()

local function onAddMoneyClicked()
	local amount = tonumber(inputField.Text)
	local success, errorMessage = giveMoneyRemote:InvokeServer(amount, true)

	if not success then
		NotificationController:Error(errorMessage)
	end
end

addButton.OnActivated:Connect(onAddMoneyClicked)


local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name .. "_ServerStart", addButtonUI, onAddMoneyClicked)
kb:RegisterButton(script.Name .. "_ServerStop", setButtonUI, onSetMoneyClicked)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()