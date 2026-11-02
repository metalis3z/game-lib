local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ButtonFX = require(script.Parent.ButtonFX)
local GradientScroll = require(script.Parent.GradientScroll)
local AutomaticCanvasSize = require(script.Parent.AutomaticCanvasSizeModule)
local EasyVisuals = require(ReplicatedStorage.Packages.EasyVisuals)
local AnimalsModule = require(ReplicatedStorage.Shared.Animals)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local SizeRemote = Net:RemoteFunction("Size")
local SpawnBrainrot = script.Parent.PlayerSize.Frame
local mainNameLabel = SpawnBrainrot.mainName
local Start = AnimatedButton.new(SpawnBrainrot.Start)
Start:Animate()
Start.OnActivated:Connect(function()
	local success, message = SizeRemote:InvokeServer(mainNameLabel.Text)
	if not success then
		NotificationController:Error(message)
	end
end)