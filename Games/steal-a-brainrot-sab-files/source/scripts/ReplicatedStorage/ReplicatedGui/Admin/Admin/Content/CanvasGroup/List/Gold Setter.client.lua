local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)

local GiveMoneyRemote = Net:RemoteFunction("AdminService/GiveGold")

local MoneyFrame = script.Parent.Gold.Frame
local InputField = MoneyFrame.mainMutation

local SetButton = AnimatedButton.new(MoneyFrame.Set)
SetButton:Animate()

local function onSetButtonClicked()
	local amountText = InputField.Text
	local success, errorMessage = GiveMoneyRemote:InvokeServer(tonumber(amountText), false)

	if not success then
		NotificationController:Error(errorMessage)
	end
end

SetButton.OnActivated:Connect(onSetButtonClicked)


local AddButton = AnimatedButton.new(MoneyFrame.Add)
AddButton:Animate()

local function onAddButtonClicked()
	local amountText = InputField.Text
	local success, errorMessage = GiveMoneyRemote:InvokeServer(tonumber(amountText), true)

	if not success then
		NotificationController:Error(errorMessage)
	end
end

AddButton.OnActivated:Connect(onAddButtonClicked)

local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local player = game.Players.LocalPlayer
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name.."_ServerStart",MoneyFrame.Add, onAddButtonClicked)
kb:RegisterButton(script.Name.."_ServerStop",MoneyFrame.Set, onSetButtonClicked)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()
