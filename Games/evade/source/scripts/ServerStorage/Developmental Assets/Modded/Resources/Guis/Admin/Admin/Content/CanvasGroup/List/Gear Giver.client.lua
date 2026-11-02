--==>>| Made By The Crooked Man |<<==--

--=====================>>| Services |<<=====================--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--==========================================================--

--====================================>>| Requires |<<====================================--
local Net = require(ReplicatedStorage.Packages.Net)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
--========================================================================================--

--=================>>| Remotes |<<=================--
local GiveGearRemote = Net:RemoteFunction("GiveGear")
--=================================================--

--==============>>| Frames |<<==============--
local SpawnBrainrot = script.Parent.Gear.Frame
--==========================================--

--=============>>| Labels |<<=============--
local mainNameLabel = SpawnBrainrot.mainName
--========================================--

--================================>>| Button |<<================================--
local GiveButton = AnimatedButton.new(SpawnBrainrot.Give)
GiveButton:Animate()
GiveButton.OnActivated:Connect(function()
	local success, message = GiveGearRemote:InvokeServer(mainNameLabel.Text)
	if not success then
		NotificationController:Error(message)
	end
end)
local TakeButton = AnimatedButton.new(SpawnBrainrot.Take)
TakeButton:Animate()
TakeButton.OnActivated:Connect(function()
	local success, message = GiveGearRemote:InvokeServer(mainNameLabel.Text, true)
	if not success then
		NotificationController:Error(message)
	end
end)
--==============================================================================--

