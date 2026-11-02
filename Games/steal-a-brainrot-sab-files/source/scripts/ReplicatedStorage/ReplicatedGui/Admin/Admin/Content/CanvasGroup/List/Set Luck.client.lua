local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game.Players.LocalPlayer

local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local LuckIcons = require(ReplicatedStorage.Datas.LuckIcons)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local SetLuckRemote = Net:RemoteFunction("AdminService/SetLuck")
local SaveKeyRemote = Net:RemoteEvent("AdminService/SaveKey")

local LuckFrame = script.Parent.Luck.Frame
local InputDuration = LuckFrame.mainMutation
local InputMultiplier = LuckFrame.mainName

local PlayerData = Synchronizer:Wait(Players)
assert(PlayerData)
Synchronizer:Wait("Events")

local function PerformSetLuck()
	local multiplier = InputMultiplier.Text:gsub("x", "")
	local duration = InputDuration.Text

	local success, message = SetLuckRemote:InvokeServer(multiplier, duration)
	if not success then
		NotificationController:Error(message)
	end
end

local function PerformResetLuck()
	local success, message = SetLuckRemote:InvokeServer(nil, nil, true)
	if not success then
		NotificationController:Error(message)
	end
end

local SetBtn = AnimatedButton.new(LuckFrame.Set)
SetBtn:Animate()
SetBtn.OnActivated:Connect(PerformSetLuck)

local ResetBtn = AnimatedButton.new(LuckFrame.Reset)
ResetBtn:Animate()
ResetBtn.OnActivated:Connect(PerformResetLuck)

local LuckSelectionTable = {}

local TierColors = {
	["2x"]  = Color3.fromRGB(70, 145, 255),
	["4x"]  = Color3.fromRGB(110, 200, 110),
	["6x"]  = Color3.fromRGB(255, 204, 92),
	["8x"]  = Color3.fromRGB(255, 120, 120),
	["10x"] = Color3.fromRGB(189, 189, 189),
	["12x"] = Color3.fromRGB(255, 255, 0),
	["15x"] = Color3.fromRGB(0, 255, 0),
	["20x"] = Color3.fromRGB(255, 115, 223),
	["25x"] = Color3.fromRGB(142, 227, 63),
	["30x"] = Color3.fromRGB(43, 76, 115),
}

for displayName, iconId in pairs(LuckIcons) do
	table.insert(LuckSelectionTable, {
		["DisplayName"] = displayName,
		["Icon"] = iconId,
		["Color"] = TierColors[displayName] or Color3.fromRGB(255, 255, 255)
	})
end

table.sort(LuckSelectionTable, function(a, b)
	local numA = tonumber(a.DisplayName:match("%d+")) or 0
	local numB = tonumber(b.DisplayName:match("%d+")) or 0
	return numA < numB
end)

LuckFrame.nametext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(LuckSelectionTable, function(selectedValue)
		InputMultiplier.Text = selectedValue
	end)
end)

local kb = KeybindManager.new(SaveKeyRemote, PlayerData)

kb:RegisterButton(script.Name .. "_SetLuck", LuckFrame.Set, PerformSetLuck)
kb:RegisterButton(script.Name .. "_ResetLuck", LuckFrame.Reset, PerformResetLuck)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()