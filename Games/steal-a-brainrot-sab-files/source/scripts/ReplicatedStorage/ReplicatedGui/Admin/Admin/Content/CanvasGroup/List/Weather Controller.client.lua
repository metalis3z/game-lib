local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Players = game.Players.LocalPlayer

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)

local SaveKeyRemote = Net:RemoteEvent("AdminService/SaveKey")

local TimeFrame = script.Parent.Time.Frame
local InputTime = TimeFrame.mainName

local TimeLockConnection = nil

local PlayerData = Synchronizer:Wait(Players)
assert(PlayerData)

local function PerformStartTime()
	local requestedTime = tonumber(InputTime.Text)

	if requestedTime then
		Lighting.ClockTime = requestedTime

		if TimeLockConnection then
			TimeLockConnection:Disconnect()
		end

		TimeLockConnection = Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
			local currentTimeInput = tonumber(InputTime.Text)
			if currentTimeInput then
				Lighting.ClockTime = currentTimeInput
			end
		end)
	else
		NotificationController:Error("Please input a valid time in numbers.")
	end
end

local function PerformStopTime()
	if TimeLockConnection then
		TimeLockConnection:Disconnect()
		TimeLockConnection = nil
	end
end

local StartBtn = AnimatedButton.new(TimeFrame.Start)
StartBtn:Animate()
StartBtn.OnActivated:Connect(PerformStartTime)

local StopBtn = AnimatedButton.new(TimeFrame.Stop)
StopBtn:Animate()
StopBtn.OnActivated:Connect(PerformStopTime)

local HourList = {}
for i = 0, 24 do
	HourList[i] = {
		["Color"] = Color3.fromRGB(85, 170, 255),
		["DisplayName"] = tostring(i),
		["Icon"] = "rbxassetid://96342315014653"
	}
end

TimeFrame.nametext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(HourList, function(selectedValue)
		InputTime.Text = selectedValue
	end)
end)

local kb = KeybindManager.new(SaveKeyRemote, PlayerData)

kb:RegisterButton(script.Name .. "_StartTime", TimeFrame.Start, PerformStartTime)
kb:RegisterButton(script.Name .. "_StopTime", TimeFrame.Stop, PerformStopTime)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()