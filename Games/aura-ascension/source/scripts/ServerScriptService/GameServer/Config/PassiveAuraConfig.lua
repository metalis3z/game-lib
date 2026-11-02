local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Ranked = require(ReplicatedStorage:WaitForChild("Ranked"))

local PassiveAuraConfig = {
	TickSeconds = 0.5,
	FastTickSeconds = 0.1,
	SkipWhileTraining = false,
	FallbackMultiplierScale = 0.625,
	RankRewards = {
		[1] = 1,
		[2] = 5,
		[3] = 18,
	},
	BoostDurations = {
		Rebirth = 3,
		GroupReward = 5,
	},
}

function PassiveAuraConfig.GetRewardForRank(rankIndex)
	local override = PassiveAuraConfig.RankRewards[rankIndex]
	if override ~= nil then
		return math.max(1, math.floor(override))
	end

	-- Only the first few original reward values are visible in the decompiled project.
	-- Later ranks fall back to the shared rank multiplier curve so balance stays easy to edit.
	local rank = Ranked.GetRank(rankIndex)
	local multiplier = rank and tonumber(rank.Multiplier) or 1
	return math.max(1, math.round(multiplier * PassiveAuraConfig.FallbackMultiplierScale))
end

function PassiveAuraConfig.GetBoostDuration(boostKind, fallbackDuration)
	if type(fallbackDuration) == "number" and fallbackDuration > 0 then
		return fallbackDuration
	end
	local configured = PassiveAuraConfig.BoostDurations[tostring(boostKind or "")]
	if type(configured) == "number" and configured > 0 then
		return configured
	end
	return PassiveAuraConfig.BoostDurations.Rebirth
end

return PassiveAuraConfig
