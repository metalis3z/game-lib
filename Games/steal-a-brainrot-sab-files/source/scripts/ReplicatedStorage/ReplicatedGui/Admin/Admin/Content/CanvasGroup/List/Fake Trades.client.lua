--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local AdminFakeRequests = Net:RemoteFunction("AdminPanel/FakeRequests")
local fakeRequestGui = script.Parent:WaitForChild("FakeRequest")
local frame = fakeRequestGui:WaitForChild("Frame")
local executeBtn = AnimatedButton.new(frame:WaitForChild("Execute"))
local tradeAmountBox = frame:WaitForChild("MainTrade")
local duelAmountBox = frame:WaitForChild("MainDuel")
local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local player = game.Players.LocalPlayer
local playerSync     = Synchronizer:Wait(player)
local kb = KeybindManager.new(saveKeyRemote, playerSync)

local busy = false

executeBtn:Animate()
local function onSetButtonClicked()
	if busy then return end

	local tradeAmount = tonumber(tradeAmountBox.Text) or 0
	local duelAmount = tonumber(duelAmountBox.Text) or 0

	busy = true

	local ok, result = pcall(function()
		return AdminFakeRequests:InvokeServer(tradeAmount, duelAmount)
	end)

	busy = false
end

executeBtn.OnActivated:Connect(onSetButtonClicked)

kb:RegisterButton(script.Name.."_ServerStart",frame.Execute, onSetButtonClicked)
kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()
