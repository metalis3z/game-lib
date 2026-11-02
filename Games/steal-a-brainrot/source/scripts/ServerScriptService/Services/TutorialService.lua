local TutorialService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local StartTutorial = Net:RemoteEvent("TutorialService/StartTutorial")
local FinishTutorial = Net:RemoteEvent("TutorialService/FinishTutorial")

StartTutorial.OnServerEvent:Connect(function(Player: Player)	
	return
end)

FinishTutorial.OnServerEvent:Connect(function(Player: Player)	
	local PlayerChannel = Synchronizer:Get(Player)

	PlayerChannel:Set("TutorialFinished", true)
end)

return TutorialService