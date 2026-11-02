local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)

local SaveRemote = Net:RemoteFunction("SavingService/Save")
local RestoreRemote = Net:RemoteFunction("SavingService/Restore")

local Save = AnimatedButton.new(script.Parent.Save)
Save:Animate()
Save.OnActivated:Connect(function()
	local success, message = SaveRemote:InvokeServer()
	if success then
		NotificationController:Success(message)
	else
		NotificationController:Error(message)
	end
end)

local Restore = AnimatedButton.new(script.Parent.Restore)
Restore:Animate()
Restore.OnActivated:Connect(function()
	local success, message = RestoreRemote:InvokeServer()
	if success then
		NotificationController:Success(message)
	else
		NotificationController:Error(message)
	end
end)