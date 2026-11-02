--!strict
local TutorialService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local StartTutorial = Net:RemoteEvent("TutorialService/StartTutorial")
local FinishTutorial = Net:RemoteEvent("TutorialService/FinishTutorial")

function TutorialService:Start()
	task.spawn(function()
		StartTutorial.OnServerEvent:Connect(function(Player: Player)
			return
		end)

		FinishTutorial.OnServerEvent:Connect(function(Player: Player)
			local PlayerChannel = Synchronizer:Get(Player)

			PlayerChannel:Set("TutorialFinished", true)
			PlayerChannel:Set("SeenTutorial", true)
		end)
	end)
end

return TutorialService
