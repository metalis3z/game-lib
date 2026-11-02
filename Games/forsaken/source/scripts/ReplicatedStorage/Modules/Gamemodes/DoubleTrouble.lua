local Mode = {}
Mode.__index = Mode

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Network = require(ReplicatedStorage.Modules.Network)
local ActorModule = require(ReplicatedStorage.Modules.Actors)
local StatsModule = require(ReplicatedStorage.Modules.Stats)

local IsServer = RunService:IsServer()
local IsClient = RunService:IsClient()

Mode.Name = "Double Trouble"
Mode.Descriptions = {
	Survivors = "Survive the TWO KILLERS until the time runs out or complete all objectives to win.", 
	Killers = "Kill all of the survivors to win, alongside the other killer on your team."
}
Mode.PlayerRequirement = 2
Mode.TimeAddedOnKill = 17.5
Mode.Time = 120

Mode.Init = function(modeData)

	local self = {
		Connections = {}
	}
	setmetatable(self, Mode)

	if IsServer then
		local Util = require(game.ReplicatedStorage.Modules.Util)
		local maxKillers = tonumber(workspace:GetAttribute("MaxKillers")) or 2
		local killers, survivors = Util:SelectRandomKillers(modeData.Players, maxKillers)

		for _, survivorInstance in pairs(survivors) do
			local index = table.find(modeData.Players, survivorInstance)
			local playerData = modeData.Players[index]
			if playerData and playerData.Instance then
				ActorModule:CreateActor(playerData.Instance, "Survivor")
				playerData.Team = "Survivors"
				playerData.Character = playerData.Instance.Character
				StatsModule:UpdatePlayerStat(playerData.Instance, "Objectives Completed", "Set", 0)
			end
		end

		for _, killerInstance in pairs(killers) do
			local index = table.find(modeData.Players, killerInstance)
			local playerData = modeData.Players[index]
			if playerData and playerData.Instance then
				ActorModule:CreateActor(playerData.Instance, "Killer")
				playerData.Team = "Killers"
				playerData.Character = playerData.Instance.Character
				StatsModule:UpdatePlayerStat(playerData.Instance, "Kills", "Set", 0)
			end
		end
		
		for _, actor in pairs(ActorModule.CurrentActors) do
			if typeof(actor) == "table" and actor.ActorType and actor.ActorType == "Killer" then
				actor.EXPMultiplier = 0.5
				actor.MoneyMultiplier = 0.5
			end
		end
		
		return self
	else
		if IsClient then
		end
		return self
	end
end

Mode.WinCondition = function(self)
	if IsServer then
	end
end

Mode.Destroy = function(self)
	for _, connection in pairs(self.Connections) do
		connection:Disconnect()
		connection = nil
	end

	if IsServer or IsClient then
	end

	self = nil
end

return Mode
