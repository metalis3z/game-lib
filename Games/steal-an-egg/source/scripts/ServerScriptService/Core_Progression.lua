--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Network = require(script.Parent.Core_Network)
local Rebirths = require(ReplicatedStorage.Directory.Rebirths)

local Progression = {}
local Data

local function copy(value)
	if typeof(value) ~= "table" then
		return value
	end
	local result = {}
	for key, child in pairs(value) do
		result[key] = copy(child)
	end
	return result
end

local function normalizeTutorial(value)
	if typeof(value) ~= "table" then
		return {Completed = false, CurrentStepId = nil}
	end
	return {
		Completed = value.Completed == true,
		CurrentStepId = if typeof(value.CurrentStepId) == "string" then value.CurrentStepId else nil,
	}
end

function Progression.Init(dataService)
	Data = dataService

	Network.BindFunction("Settings: Request Update", function(player, key, value)
		if typeof(key) ~= "string" or typeof(value) ~= "boolean" then
			return false
		end
		local profile = Data.Get(player)
		if not profile then
			return false
		end
		local settings = copy(profile.Settings or {})
		settings[key] = value
		Data.Update(player, {Settings = settings})
		Network.FireClient("Setting Changed", player, key, value)
		return true, settings
	end)

	Network.BindFunction("GuardTutorial: RequestSyncProgress", function(player, requested)
		local profile = Data.Get(player)
		if not profile then
			return false, nil
		end
		local progress = normalizeTutorial(requested or profile.GuardTutorialProgress)
		Data.Update(player, {GuardTutorialProgress = progress})
		return true, progress
	end)

	Network.BindFunction("Rebirth: RequestRebirth", function(player)
		local profile = Data.Get(player)
		if not profile then
			return false, "Your data is still loading."
		end
		local nextConfig = Rebirths[(tonumber(profile.Rebirth) or 0) + 1]
		if not nextConfig then
			return false, "You have reached the maximum rebirth."
		end
		local required = nextConfig.Requirements.RequiredSpeedPower
		return (tonumber(profile.SpeedPower) or 0) >= required, nextConfig
	end)

	Network.BindFunction("Rebirth: RequestRebirthCommit", function(player)
		local profile = Data.Get(player)
		if not profile then
			return false, "Your data is still loading."
		end
		local nextRebirth = (tonumber(profile.Rebirth) or 0) + 1
		local nextConfig = Rebirths[nextRebirth]
		if not nextConfig then
			return false, "You have reached the maximum rebirth."
		end
		if (tonumber(profile.SpeedPower) or 0) < nextConfig.Requirements.RequiredSpeedPower then
			return false, "You need more speed power."
		end
		Data.Update(player, {
			Rebirth = nextRebirth,
			SpeedPower = 10,
			Money = 0,
			BaseUpgradeLevel = 0,
			TreadmillUpgradeLevel = 1,
		})
		return true, nextRebirth
	end)
end

return Progression
