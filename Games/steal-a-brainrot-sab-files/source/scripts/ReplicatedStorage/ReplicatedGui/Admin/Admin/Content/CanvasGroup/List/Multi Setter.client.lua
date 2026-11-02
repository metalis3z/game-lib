local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game.Players.LocalPlayer

local Net = require(ReplicatedStorage.Packages.Net)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)

local GiveMultiRemote = Net:RemoteFunction("AdminService/GiveMulti")
local SaveKeyRemote = Net:RemoteEvent("AdminService/SaveKey")

local MultiFrame = script.Parent.Multi.Frame
local MultiInput = MultiFrame.mainMutation

local PlayerData = Synchronizer:Wait(Players)
assert(PlayerData)

local function PerformSetMulti()
	local amount = tonumber(MultiInput.Text)
	if not amount then return end

	local success, errorMessage = GiveMultiRemote:InvokeServer(amount)
	if not success then
		NotificationController:Error(errorMessage)
	end
end

local function PerformAddMulti()
	local amount = tonumber(MultiInput.Text)
	if not amount then return end

	local success, errorMessage = GiveMultiRemote:InvokeServer(amount, true)
	if not success then
		NotificationController:Error(errorMessage)
	end
end

local SetBtn = AnimatedButton.new(MultiFrame.Set)
SetBtn:Animate()
SetBtn.OnActivated:Connect(PerformSetMulti)

local AddBtn = AnimatedButton.new(MultiFrame.Add)
AddBtn:Animate()
AddBtn.OnActivated:Connect(PerformAddMulti)

local kb = KeybindManager.new(SaveKeyRemote, PlayerData)

kb:RegisterButton(script.Name .. "_SetMulti", MultiFrame.Set, PerformSetMulti)
kb:RegisterButton(script.Name .. "_AddMulti", MultiFrame.Add, PerformAddMulti)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()