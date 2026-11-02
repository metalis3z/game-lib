local Mode = {}
Mode.__index = Mode

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Network = require(ReplicatedStorage.Modules.Network)
local ActorModule = require(ReplicatedStorage.Modules.Actors)
local StatsModule = require(ReplicatedStorage.Modules.Stats)

local IsServer = RunService:IsServer()
local IsClient = RunService:IsClient()

Mode.Name = "One Bounce"
Mode.Descriptions = {
	Survivors = "Survive all of the killers until the time runs out to win.", 
	Killers = "Kill the survivor to win."
}
Mode.PlayerRequirement = 4
Mode.DisableEmotionalThemes = true
Mode.LMSTheme = {
	ThemeID = "rbxassetid://119666410555742",
	RoundTime = 76
}
Mode.DisableOnLMS = true
Mode.LMSRevealTime = 17
Mode.AddMalice = false

Mode.Init = function(currentSession)

	local self = {
		Connections = {}
	}
	setmetatable(self, Mode)

	if IsServer then
		local Util = require(game.ReplicatedStorage.Modules.Util)
		
		local survivors = {}
		local killers = {}
		
		-- not using selectrandomkillers because i dont want anyone's malice to change
		local selectedSurvivorIndex = math.random(1, #currentSession.Players)
		local selectedSurvivor = currentSession.Players[selectedSurvivorIndex]
		survivors[1] = selectedSurvivor
		for _, plr in pairs(currentSession.Players) do
			if plr ~= selectedSurvivor then
				table.insert(killers, plr)
			end
		end

		for _, survivorInstance in pairs(survivors) do
			local index = table.find(currentSession.Players, survivorInstance)
			local playerData = currentSession.Players[index]
			if playerData and playerData.Instance then
				ActorModule:CreateActor(playerData.Instance, "Survivor")
				playerData.Team = "Survivors"
				playerData.Character = playerData.Instance.Character
				StatsModule:UpdatePlayerStat(playerData.Instance, "Objectives Completed", "Set", 0)
			end
		end

		for _, killerInstance in pairs(killers) do
			local index = table.find(currentSession.Players, killerInstance)
			local playerData = currentSession.Players[index]
			if playerData and playerData.Instance then
				ActorModule:CreateActor(playerData.Instance, "Killer")
				playerData.Team = "Killers"
				playerData.Character = playerData.Instance.Character
				StatsModule:UpdatePlayerStat(playerData.Instance, "Kills", "Set", 0)
			end
		end
		
		for _, actor in pairs(ActorModule.CurrentActors) do
			if typeof(actor) == "table" and actor.ActorType and actor.ActorType == "Survivor" then
				local hum : Humanoid = actor.Rig:FindFirstChildOfClass("Humanoid")
				if not hum then return end
				hum.MaxHealth += 60 * #killers
				hum.Health = hum.MaxHealth
			end
		end
		
		return self
	else
		if IsClient then
			if game.Players.LocalPlayer.Character.Parent == workspace.Players.Survivors then
				require(game.ReplicatedStorage.Systems.Character.Game.Sprinting).MaxStamina = 225
			end
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
