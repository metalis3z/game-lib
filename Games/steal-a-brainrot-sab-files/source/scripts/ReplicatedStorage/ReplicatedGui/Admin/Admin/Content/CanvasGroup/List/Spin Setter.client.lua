local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Notification = require(ReplicatedStorage.Controllers.NotificationController)
local AddCursedSpins = Net:RemoteFunction("AdminService/AddCyberSpins")

local frame = script.Parent.Spins.Frame
local inputField = frame.mainMutation
local setBtn = AnimatedButton.new(frame.Set)
local addBtn = AnimatedButton.new(frame.Add)

setBtn:Animate()
addBtn:Animate()


local function requestSpins(mode)
	local amount = tonumber(inputField.Text)

	if not amount then 
		Notification:Error("Please enter a valid number")
		return 
	end

	local status = AddCursedSpins:InvokeServer(amount, mode)

	if status == "added" or status == "set" or status == "success" then
		
	else
		Notification:Error(status or "Failed to process request")
	end
end



local function onSetClicked()
	requestSpins("Set")
end
setBtn.OnActivated:Connect(onSetClicked)


local function onAddClicked()
	requestSpins("Add")
end
addBtn.OnActivated:Connect(onAddClicked)

local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local player = game.Players.LocalPlayer
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name.."_ServerStart",frame.Add, onAddClicked)
kb:RegisterButton(script.Name.."_ServerStop",frame.Set, onSetClicked)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()
