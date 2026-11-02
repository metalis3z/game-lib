-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EstimateClockSpeed = require(ReplicatedStorage.Library.Functions.EstimateClockSpeed)
local Map = require(ReplicatedStorage.Library.Functions.Map)
local Variables = require(ReplicatedStorage.Library.Variables)
local v1 = UserInputService.TouchEnabled and not UserInputService.MouseEnabled or (UserInputService.GyroscopeEnabled or UserInputService.AccelerometerEnabled)

local function estimateQuality() --[[ estimateQuality | Line: 10 | Upvalues: EstimateClockSpeed (copy), Map (copy) ]]
	local v1 = EstimateClockSpeed()

	if v1 then
		return math.clamp(math.round((Map(v1, 2, 5, 1, 10))), 1, 10)
	end

	return nil
end

local v2 = nil

return function() --[[ Line: 20 | Upvalues: Variables (copy), v2 (ref), EstimateClockSpeed (copy), Map (copy), v1 (copy) ]]
	if Variables.PotatoMode then
		return 1
	end

	local SavedQualityLevel = UserSettings().GameSettings.SavedQualityLevel.Value

	if SavedQualityLevel == 0 then
		if not v2 then
			local v12 = EstimateClockSpeed()

			v2 = if v12 then math.clamp(math.round((Map(v12, 2, 5, 1, 10))), 1, 10) else nil
		end

		SavedQualityLevel = v2 or 5
	end

	if v1 then
		SavedQualityLevel = math.clamp(math.round((Map(SavedQualityLevel, 1, 10, 1, 5))), 1, 10)
	end

	return SavedQualityLevel
end