local SecondsInDay = 86400
local EventStartTimestamp =
	DateTime.fromUniversalTime(2025, 12, 1, 0, 0, 0).UnixTimestamp

local CalendarRewards = {
	{ type = "brainrot", name = "Admin Lucky Block" },
	{ type = "luck", multiplier = "2x" },
	{ type = "brainrot", name = "Los Lucky Blocks" },
	{ type = "luck", multiplier = "2x" },
	{ type = "brainrot", name = "Ballerina Peppermintina" },
	{ type = "luck", multiplier = "2x" },
	{ type = "skipfuse" },
	{ type = "brainrot", name = "Admin Lucky Block", quantity = 2 },
	{ type = "luck", multiplier = "2x" },
	{ type = "brainrot", name = "Please my Present" },
	{ type = "luck", multiplier = "2x" },
	{ type = "brainrot", name = "Los Lucky Blocks", quantity = 2 },
	{ type = "skipfuse" },
	{ type = "luck", multiplier = "2x" },
	{ type = "candyCane", quantity = 50 },
	{ type = "skipfuse" },
	{ type = "luck", multiplier = "2x" },
	{ type = "candyCane", quantity = 50 },
	{ type = "skipfuse" },
	{ type = "brainrot", name = "Festive Lucky Block", quantity = 1 },
	{ type = "candyCane", quantity = 50 },
	{ type = "skipfuse" },
	{ type = "candyCane", quantity = 50 },
	{ type = "brainrot", name = "Bunnyman", quantity = 1 },
	{ type = "brainrot", name = "Festive Lucky Block", quantity = 1 },
}

local StreakRewards = {
	[3] = { type = "brainrot", name = "Admin Lucky Block", quantity = 3 },
	[7] = { type = "brainrot", name = "Los Lucky Blocks", quantity = 1 },
	[14] = { type = "brainrot", name = "Festive Lucky Block", quantity = 3 },
	[25] = { type = "brainrot", name = "25" },
}

local RewardsModule = {}

RewardsModule.TotalDays = 25
RewardsModule.Rewards = {
	Calendar = CalendarRewards,
	Streak = StreakRewards,
}

function RewardsModule.GetCurrentDay(CurrentTime)
	local Now = CurrentTime or math.floor(workspace:GetServerTimeNow())
	return math.floor((Now - EventStartTimestamp) / SecondsInDay) + 1
end

function RewardsModule.GetRewardUnlockTime(Day)
	if CalendarRewards[Day] then
		return EventStartTimestamp + (Day - 1) * SecondsInDay
	end
	return nil
end

function RewardsModule.GetNextRewardTimestamp(CurrentTime)
	local Today = RewardsModule.GetCurrentDay(CurrentTime)
	return RewardsModule.GetRewardUnlockTime(Today + 1)
end

function RewardsModule.GetCalendarReward(Day)
	return CalendarRewards[Day]
end

function RewardsModule.GetStreakReward(StreakDay)
	return StreakRewards[StreakDay]
end

function RewardsModule.GetStreak(ClaimedDays, UpToDay, CurrentTime)
	local LastDay = UpToDay or RewardsModule.GetCurrentDay(CurrentTime)
	local Streak = 0

	for Day = 1, LastDay do
		if not ClaimedDays[tostring(Day)] then
			Streak = 0
		else
			Streak += 1
		end
	end

	return Streak
end

function RewardsModule.GetLastFailedDay(ClaimedDays, UpToDay, CurrentTime)
	local LastDay = UpToDay or RewardsModule.GetCurrentDay(CurrentTime)

	for Day = LastDay - 1, 1, -1 do
		if not ClaimedDays[tostring(Day)] then
			return Day
		end
	end

	return nil
end

return RewardsModule