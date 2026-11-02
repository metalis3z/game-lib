local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local AdventShared = require(ReplicatedStorage.Shared.AdventCalendar)

local AnimalService = require(ServerScriptService.Services.AnimalService)
local LuckService = require(ServerScriptService.Services.LuckService)

local ClaimRewardFn = Net:RemoteFunction("AdventService/ClaimReward")
local RecoverEvent = Net:RemoteEvent("AdventService/Recover")
local NotifyEvent = Net:RemoteEvent("NotificationService/Notify")

local MAX_RECOVERS = math.huge

local function getChannel(player)
	local channel
	repeat
		channel = Synchronizer:Get(player)
		if channel then break end
		task.wait()
	until channel
	return channel
end

local function ensureAdvent(channel)
	local advent = channel:Get("AdventCalendar") or {}
	advent.CalendarRewards = advent.CalendarRewards or {}
	advent.StreakRewards = advent.StreakRewards or {}
	advent.LastLoginDay = advent.LastLoginDay or 0
	advent.Recovers = advent.Recovers or 0
	channel:Set("AdventCalendar", advent)
	return advent
end

local function giveReward(player, rewardDef)
	if not rewardDef then return end

	NotifyEvent:FireClient(player, "Reward Claimed!", 5, "Sounds.Sfx.AdventSuccess")

	if rewardDef.type == "brainrot" then
		AnimalService.spawnAnimalInBase(player, rewardDef.name, nil, nil)
	elseif rewardDef.type == "luck" then
		local multiplier = (rewardDef.multiplier == "4x") and 2 or 1
		local endTime = LuckService:GetEndTime()
		if endTime == 0 then
			endTime = workspace:GetServerTimeNow() + 900
		else
			endTime += 900
		end
		LuckService:StartLuck(multiplier, endTime)
	elseif rewardDef.type == "candyCane" then
		-- Add candy cane logic here if needed
	end
end

local function refreshAvailability(channel)
	local advent = ensureAdvent(channel)
	local calendar = advent.CalendarRewards
	local currentDay = AdventShared.getCurrentDay()

	if currentDay < 1 then return end -- Prevent errors if date hasn't started

	if (advent.LastLoginDay or 0) < currentDay then
		if calendar[tostring(currentDay)] ~= "Claimed" then
			calendar[tostring(currentDay)] = "Available"
		end
		advent.LastLoginDay = currentDay
	end

	local streakCount = AdventShared.getStreak(calendar, currentDay)
	for days, _ in pairs(AdventShared.Rewards.Streak or {}) do
		local key = tostring(days)
		if streakCount >= days and advent.StreakRewards[key] ~= "Claimed" then
			advent.StreakRewards[key] = "Available"
		end
	end

	channel:Set("AdventCalendar", advent)
end

ClaimRewardFn.OnServerInvoke = function(player, rewardType, index)
	local channel = getChannel(player)
	local advent = ensureAdvent(channel)
	local currentDay = AdventShared.getCurrentDay()

	if rewardType == "Calendar" then
		local day = tonumber(index)
		local key = tostring(day)

		if not day or day > currentDay then 
			return { ok = false, message = "Day not reached" } 
		end
		if advent.CalendarRewards[key] == "Claimed" then 
			return { ok = false, message = "Already claimed" } 
		end

		advent.CalendarRewards[key] = "Claimed"
		channel:Set("AdventCalendar", advent)

		giveReward(player, AdventShared.getCalendarReward(day))
		refreshAvailability(channel) -- Update streaks after claiming
		return { ok = true }

	elseif rewardType == "Streak" then
		local days = tonumber(index)
		local key = tostring(days)

		if advent.StreakRewards[key] ~= "Available" then
			return { ok = false, message = "Streak not available" }
		end

		advent.StreakRewards[key] = "Claimed"
		channel:Set("AdventCalendar", advent)

		giveReward(player, AdventShared.getStreakReward(days))
		return { ok = true }
	end
end

RecoverEvent.OnServerEvent:Connect(function(player)
	local channel = getChannel(player)
	local advent = ensureAdvent(channel)
	local currentDay = AdventShared.getCurrentDay()

	local lastFailed = AdventShared.getLastFailedDay(advent.CalendarRewards, currentDay)

	if lastFailed and lastFailed < currentDay and (advent.Recovers or 0) < MAX_RECOVERS then
		advent.CalendarRewards[tostring(lastFailed)] = "Available"
		advent.Recovers = (advent.Recovers or 0) + 1
		channel:Set("AdventCalendar", advent)
	end
end)

Players.PlayerAdded:Connect(function(player)
	local channel = getChannel(player)
	refreshAvailability(channel)
end)