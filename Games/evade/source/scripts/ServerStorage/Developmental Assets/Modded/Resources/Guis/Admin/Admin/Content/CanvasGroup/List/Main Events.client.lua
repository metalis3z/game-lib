--==>>| Made By The Crooked Man |<<==--

--=====================>>| Services |<<=====================--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--==========================================================--

--====================================>>| Requires |<<====================================--
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local Net = require(ReplicatedStorage.Packages.Net)
--========================================================================================--

--======================>>| Remotes |<<======================--
local StartGlobalEvent = Net:RemoteFunction("StartGlobalEvent")
local StopGlobalEvent = Net:RemoteFunction("StopGlobalEvent")
local StartServerEvent = Net:RemoteFunction("StartServerEvent")
local StopServerEvent = Net:RemoteFunction("StopServerEvent")
--===========================================================--

--===============>>| Frames |<<===============--
local SpawnBrainrot = script.Parent.Events.Frame
--============================================--

--=================>>| Labels |<<=================--
local mainNameLabel = SpawnBrainrot.mainName
local mainDurationLabel = SpawnBrainrot.mainDuration
--================================================--

--===========================>>| Buttons |<<===========================--
local GlobalStart = AnimatedButton.new(SpawnBrainrot.GlobalStart)
GlobalStart:Animate()
GlobalStart.OnActivated:Connect(function()
	local selectedEvent = mainNameLabel.Text
	local duration = tonumber(mainDurationLabel.Text) or 300
	if selectedEvent and selectedEvent ~= "" then
		local success, result = pcall(function()
			return StartGlobalEvent:InvokeServer(selectedEvent, duration)
		end)
		if not success then
			return false, "Failed to start global event:", result
		end
	end
end)

local GlobalStop = AnimatedButton.new(SpawnBrainrot.GlobalStop)
GlobalStop:Animate()
GlobalStop.OnActivated:Connect(function()
	local selectedEvent = mainNameLabel.Text
	if selectedEvent and selectedEvent ~= "" then
		local success, result = pcall(function()
			return StopGlobalEvent:InvokeServer(selectedEvent)
		end)
		if not success then
			return false, "Failed to stop global event:", result
		end
	end
end)

local ServerStart = AnimatedButton.new(SpawnBrainrot.ServerStart)
ServerStart:Animate()
ServerStart.OnActivated:Connect(function()
	local selectedEvent = mainNameLabel.Text
	local duration = tonumber(mainDurationLabel.Text) or 300
	if selectedEvent and selectedEvent ~= "" then
		local success, result = pcall(function()
			return StartServerEvent:InvokeServer(selectedEvent, duration)
		end)
		if not success then
			warn("Failed to start server event:", result)
		end
	end
end)

local ServerStop = AnimatedButton.new(SpawnBrainrot.ServerStop)
ServerStop:Animate()
ServerStop.OnActivated:Connect(function()
	local selectedEvent = mainNameLabel.Text
	if selectedEvent and selectedEvent ~= "" then
		local success, result = pcall(function()
			return StopServerEvent:InvokeServer(selectedEvent)
		end)
		if not success then
			warn("Failed to stop server event:", result)
		end
	end
end)
--=====================================================================--

--=====================================>>| I Am Unsure If This Is Used Or Not |<<=====================================--
local eventNameList = {}
local v23 = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ActiveEvents"):WaitForChild("ActiveEvents")
eventNameList.All = {
	["Icon"] = "http://www.roblox.com/asset/?id=11157772247",
	["DisplayName"] = "All",
	["Color"] = Color3.fromRGB(85, 170, 0)
}
for _, v24 in pairs(ReplicatedStorage.Controllers.EventController.Events:GetChildren()) do
	local v25 = v24.Name
	local v26 = ""
	local v27 = v23:FindFirstChild(v25)
	if v27 then
		local v28 = v27:FindFirstChild("Main")
		if v28 then
			v26 = v28.Image
		end
	end
	eventNameList[v25] = {
		["Icon"] = v26,
		["DisplayName"] = v25,
		["Color"] = Color3.fromHSV(math.random(), 0.9, 1)
	}
end

SpawnBrainrot.nametext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(eventNameList, function(selectedEventName)
		mainNameLabel.Text = selectedEventName
	end)
end)
--====================================================================================================================--

