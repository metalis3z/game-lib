local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game.Players.LocalPlayer

local Net = require(ReplicatedStorage.Packages.Net)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)

local GiveRebirthRemote = Net:RemoteFunction("AdminService/GiveRebirth")
local SaveKeyRemote = Net:RemoteEvent("AdminService/SaveKey")

local RebirthFrame = script.Parent.Rebirth.Frame
local RebirthInput = RebirthFrame.mainMutation

local PlayerData = Synchronizer:Wait(Players)
assert(PlayerData)

local function PerformSetRebirth()
	local amount = tonumber(RebirthInput.Text)
	if not amount then return end

	local success, errorMessage = GiveRebirthRemote:InvokeServer(amount)
	if not success then
		NotificationController:Error(errorMessage)
	end
end

local function PerformAddRebirth()
	local amount = tonumber(RebirthInput.Text)
	if not amount then return end

	local success, errorMessage = GiveRebirthRemote:InvokeServer(amount, true)
	if not success then
		NotificationController:Error(errorMessage)
	end
end

local SetBtn = AnimatedButton.new(RebirthFrame.Set)
SetBtn:Animate()
SetBtn.OnActivated:Connect(PerformSetRebirth)

local AddBtn = AnimatedButton.new(RebirthFrame.Add)
AddBtn:Animate()
AddBtn.OnActivated:Connect(PerformAddRebirth)

local kb = KeybindManager.new(SaveKeyRemote, PlayerData)

kb:RegisterButton(script.Name .. "_SetRebirth", RebirthFrame.Set, PerformSetRebirth)
kb:RegisterButton(script.Name .. "_AddRebirth", RebirthFrame.Add, PerformAddRebirth)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()