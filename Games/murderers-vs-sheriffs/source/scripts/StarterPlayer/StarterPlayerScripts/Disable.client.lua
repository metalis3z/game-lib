local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local ControlModule = require(Player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
local ReplicatedStorage = game:GetService("ReplicatedStorage")

ReplicatedStorage.Remotes.Gameplay:WaitForChild("ControlToggle").OnClientEvent:Connect(function(Enable)
	if Enable then
		ControlModule:Enable()
	else
		ControlModule:Disable()
	end
end)
