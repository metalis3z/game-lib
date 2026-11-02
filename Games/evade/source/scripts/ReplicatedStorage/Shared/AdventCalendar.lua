local START_TIMESTAMP = DateTime.fromUniversalTime(2025, 12, 1, 0, 0, 0).UnixTimestamp
local SECONDS_IN_DAY = 86400

local CalendarRewards = {
	{ ["type"] = "brainrot", ["name"] = "Admin Lucky Block" },
	{ ["type"] = "luck", ["multiplier"] = "2x" },
	{ ["type"] = "brainrot", ["name"] = "Los Lucky Blocks" },
	{ ["type"] = "luck", ["multiplier"] = "2x" },
	{ ["type"] = "brainrot", ["name"] = "Ballerina Peppermintina" },
	{ ["type"] = "luck", ["multiplier"] = "2x" },
	{ ["type"] = "skipfuse" },
	{ ["type"] = "brainrot", ["name"] = "Admin Lucky Block", ["quantity"] = 2 },
	{ ["type"] = "luck", ["multiplier"] = "2x" },
	{ ["type"] = "brainrot", ["name"] = "Please my Present" },
	{ ["type"] = "luck", ["multiplier"] = "2x" },
	{ ["type"] = "brainrot", ["name"] = "Los Lucky Blocks", ["quantity"] = 2 },
	{ ["type"] = "skipfuse" },
	{ ["type"] = "luck", ["multiplier"] = "2x" },
	{ ["type"] = "candyCane", ["quantity"] = 50 },
	{ ["type"] = "skipfuse" },
	{ ["type"] = "luck", ["multiplier"] = "2x" },
	{ ["type"] = "candyCane", ["quantity"] = 50 },
	{ ["type"] = "skipfuse" },
	{ ["type"] = "brainrot", ["name"] = "Festive Lucky Block", ["quantity"] = 1 },
	{ ["type"] = "candyCane", ["quantity"] = 50 },
	{ ["type"] = "skipfuse" },
	{ ["type"] = "candyCane", ["quantity"] = 50 },
	{ ["type"] = "brainrot", ["name"] = "Bunnyman", ["quantity"] = 1 },
	{ ["type"] = "brainrot", ["name"] = "Festive Lucky Block", ["quantity"] = 1 }
}

local StreakRewards = {
	[3] = { ["type"] = "brainrot", ["name"] = "Admin Lucky Block", ["quantity"] = 3 },
	[7] = { ["type"] = "brainrot", ["name"] = "Los Lucky Blocks", ["quantity"] = 1 },
	[14] = { ["type"] = "brainrot", ["name"] = "Festive Lucky Block", ["quantity"] = 3 },
	[25] = { ["type"] = "brainrot", ["name"] = "25" }
}

local RewardModule = {}

RewardModule.Rewards = {
	Calendar = CalendarRewards,
	Streak = StreakRewards
}

RewardModule.TotalDays = 25

RewardModule.getCurrentDay = function(p1)
	local v1 = p1 or os.time()
	return math.floor((v1 - START_TIMESTAMP) / SECONDS_IN_DAY) + 1
end

RewardModule.timeToReward = function(p2)
	if CalendarRewards[p2] then
		return START_TIMESTAMP + (p2 - 1) * SECONDS_IN_DAY
	else
		return nil
	end
end

RewardModule.getNextRewardTimestamp = function(p3)
	local v2 = RewardModule.getCurrentDay(p3)
	return RewardModule.timeToReward(v2 + 1)
end

RewardModule.getCalendarReward = function(p4)
	return CalendarRewards[p4]
end

RewardModule.getStreakReward = function(p5)
	return StreakRewards[p5]
end

RewardModule.getStreak = function(p6, p7, p8)
	local v3 = 0
	local v4 = p7 or RewardModule.getCurrentDay(p8)
	for i = 1, v4 do
		if p6[tostring(i)] == nil then
			v3 = 0
		else
			v3 = v3 + 1
		end
	end
	return v3
end

RewardModule.getLastFailedDay = function(p9, p10, p11)
	local v5 = p10 or RewardModule.getCurrentDay(p11)
	for i = v5 - 1, 1, -1 do
		if p9[tostring(i)] == nil then
			return i
		end
	end
	return nil
end

return RewardModule