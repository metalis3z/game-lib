-- not working yet
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Players")
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local AnnounceGlobal = Net:RemoteFunction("AnnounceGlobal")
local AnnounceServer = Net:RemoteFunction("AnnounceServer")
local SpawnBrainrot = script.Parent.Announcement.Frame
local Global = AnimatedButton.new(SpawnBrainrot.Global)
Global:Animate()
Global.OnActivated:Connect(function()
	local success, message = AnnounceGlobal:InvokeServer(SpawnBrainrot.main.Text)
	if not success then
		NotificationController:Error(message)
	end
end)
local Server = AnimatedButton.new(SpawnBrainrot.Server)
Server:Animate()
Server.OnActivated:Connect(function()
	local success, message = AnnounceServer:InvokeServer(SpawnBrainrot.main.Text)
	if not success then
		NotificationController:Error(message)
	end
end)