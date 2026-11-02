local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local AdventCalendar = require(ReplicatedStorage.Shared.AdventCalendar)

local AnimalService = require(ServerScriptService.Services.AnimalService)
local PlotService = require(ServerScriptService.Services.PlotService)
local LuckService = require(ServerScriptService.Services.LuckService)

local ClaimRewardRemote = Net:RemoteFunction("AdventService/ClaimReward")
local RecoverRemote = Net:RemoteFunction("AdventService/Recover")

local AdventService = {}

local function GetPlayerData(player)
	if Synchronizer.Get then
		return Synchronizer:Get(player)
	elseif Synchronizer.GetData then
		return Synchronizer:GetData(player)
	end
	return nil
end

local function EnsureData(playerData)
	local root = playerData:Get("AdventCalendar")
	if type(root) ~= "table" then
		playerData:Set("AdventCalendar", {
			LastLoginDay = 0,
			Recovers = 3,
			CalendarRewards = {},
			StreakRewards = {}
		})
	end
end

local function GrantReward(player, reward)
	if not reward then
		return false
	end

	if reward.type == "brainrot" then
		if not PlotService.getFreePodium(player) then
			return false
		end

		local amount = reward.quantity or 1
		for _ = 1, amount do
			PlotService.AddAnimalOnPlotOrQueue(player, reward.name)
		end

	elseif reward.type == "luck" then
		local amount = tonumber(reward.multiplier:match("%d+")) or 2
		local duration = 1800

		if LuckService.AddLuck then
			LuckService.AddLuck(player, amount, duration)
		elseif LuckService.GiveLuck then
			LuckService.GiveLuck(player, amount, duration)
		elseif LuckService.Activate then
			LuckService.Activate(player, "Luck", amount, duration)
		end

	elseif reward.type == "skipfuse" then
		local data = GetPlayerData(player)
		if not data then
			return false
		end

		local current = data:Get("FuseMachine.InstantReveals") or 0
		data:Set("FuseMachine.InstantReveals", current + (reward.quantity or 1))
	end

	return true
end

local function UpdateStreakRewards(playerData)
	local calendarRewards = playerData:Get({ "AdventCalendar", "CalendarRewards" }) or {}

	local rawLastLogin = playerData:Get({ "AdventCalendar", "LastLoginDay" })
	local lastLogin = type(rawLastLogin) == "number" and rawLastLogin or 0

	local currentStreak = AdventCalendar.GetStreak(calendarRewards, lastLogin, os.time())

	for days in pairs(AdventCalendar.Rewards.Streak) do
		local path = { "AdventCalendar", "StreakRewards", tostring(days) }
		local state = playerData:Get(path)

		if currentStreak >= days and state ~= "Claimed" then
			playerData:Set(path, "Available")
		end
	end
end

local function UpdatePlayerSession(player)
	local playerData = GetPlayerData(player)
	if not playerData then
		return
	end

	EnsureData(playerData)

	local currentDay = AdventCalendar.GetCurrentDay(os.time())

	local rawLastLogin = playerData:Get({ "AdventCalendar", "LastLoginDay" })
	local lastLogin = type(rawLastLogin) == "number" and rawLastLogin or 0

	if currentDay > lastLogin then
		local path = {
			"AdventCalendar",
			"CalendarRewards",
			tostring(currentDay)
		}

		if playerData:Get(path) ~= "Claimed" then
			playerData:Set(path, "Available")
		end

		playerData:Set({ "AdventCalendar", "LastLoginDay" }, currentDay)
	end

	local rawRecovers = playerData:Get({ "AdventCalendar", "Recovers" })
	local recovers = type(rawRecovers) == "number" and rawRecovers or 0

	if recovers < 3 then
		playerData:Set({ "AdventCalendar", "Recovers" }, 3)
	end

	UpdateStreakRewards(playerData)
end

function AdventService.ClaimReward(player, rewardType, id)
	local playerData = GetPlayerData(player)
	if not playerData then
		return false
	end

	EnsureData(playerData)

	local reward
	local path

	if rewardType == "Calendar" then
		reward = AdventCalendar.Rewards.Calendar[tonumber(id)]
		path = { "AdventCalendar", "CalendarRewards", tostring(id) }
	elseif rewardType == "Streak" then
		reward = AdventCalendar.Rewards.Streak[tonumber(id)]
		path = { "AdventCalendar", "StreakRewards", tostring(id) }
	end

	if not reward then
		return false
	end

	if playerData:Get(path) ~= "Available" then
		return false
	end

	if GrantReward(player, reward) then
		playerData:Set(path, "Claimed")
		UpdateStreakRewards(playerData)
		return true
	end

	return false
end

function AdventService.Recover(player)
	local playerData = GetPlayerData(player)
	if not playerData then
		return false
	end

	local calendarRewards =
		playerData:Get({ "AdventCalendar", "CalendarRewards" }) or {}

	local rawLastLogin =
		playerData:Get({ "AdventCalendar", "LastLoginDay" })

	local lastLogin =
		type(rawLastLogin) == "number" and rawLastLogin or 0

	local rawRecovers =
		playerData:Get({ "AdventCalendar", "Recovers" })

	local recovers =
		type(rawRecovers) == "number" and rawRecovers or 0

	local failedDay = nil
	for day = lastLogin - 1, 1, -1 do
		if calendarRewards[tostring(day)] ~= "Claimed" then
			failedDay = day
			break
		end
	end

	if not failedDay then
		return false
	end

	playerData:Set(
		{ "AdventCalendar", "CalendarRewards", tostring(failedDay) },
		"Available"
	)

	if recovers > 0 then
		playerData:Set(
			{ "AdventCalendar", "Recovers" },
			recovers - 1
		)
	end

	UpdateStreakRewards(playerData)
	return true
end

ClaimRewardRemote.OnServerInvoke = AdventService.ClaimReward
RecoverRemote.OnServerInvoke = AdventService.Recover

Players.PlayerAdded:Connect(function(player)
	task.wait(2)
	UpdatePlayerSession(player)
end)

for _, player in ipairs(Players:GetPlayers()) do
	task.spawn(function()
		UpdatePlayerSession(player)
	end)
end

return AdventService