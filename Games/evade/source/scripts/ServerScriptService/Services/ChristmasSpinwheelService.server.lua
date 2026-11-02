local ChristmasEventService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local AnimalService = require(ServerScriptService.Services.AnimalService)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local ChristmasSpinWheel = require(ReplicatedStorage.Datas.ChristmasSpinWheel)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local EventService = require(ServerScriptService.Services.EventService)
local LuckService = require(ServerScriptService.Services.LuckService)
local ElfService = require(ServerScriptService.Services.ElfService)

local Spin = Net:RemoteEvent("ChristmasEventService/Spin")
local RequestBuy = Net:RemoteFunction("ChristmasEventService/RequestBuy")

local CONSTANTS = {
	ACTION_COOLDOWN = 0.5,
	SPIN_COST = 5,
	EVENT_DURATION = 900,
	LUCK_DURATION = 900,
	NOTIFICATION_DURATION = 15,
	INTERVALS = {
		WEEKEND = 3600,
		WEEKDAY = 10800
	},
	WEEKEND_DAYS = {
		[1] = true,
		[7] = true
	},
	NOTIFICATION_COLOR = "#ff4d4d",
	NOTIFICATION_SOUND = "Sounds.Sfx.Success"
}

local LastActionTime = {}
local RewardHandlers = {}

local function isOnCooldown(player)
	local now = os.clock()
	if LastActionTime[player] and now - LastActionTime[player] < CONSTANTS.ACTION_COOLDOWN then
		return true
	end
	LastActionTime[player] = now
	return false
end

local function getWeightedReward(player)
	local playerChannel = Synchronizer:Get(player)
	local rewards = ChristmasSpinWheel.Rewards
	local totalWeight = 0
	for _, reward in ipairs(rewards) do
		totalWeight += reward.Weight
	end
	local randomWeight = math.random() * totalWeight
	local cumulative = 0
	for index, reward in ipairs(rewards) do
		cumulative += reward.Weight
		if randomWeight <= cumulative then
			if reward.Type == "Item" and playerChannel:Get("Items." .. (reward.Index or "")) then
				if ChristmasSpinWheel.AltRewards[index] then
					return index, ChristmasSpinWheel.AltRewards[index]
				end
			end
			return index, reward
		end
	end
	return 1, rewards[1]
end

RewardHandlers["CandyCane"] = function(player, reward)
	local amount = reward.Amount or 0
	local playerChannel = Synchronizer:Get(player)
	if playerChannel then
		playerChannel:Increase("Currency.CandyCane", amount)
	end
end

RewardHandlers["Animal"] = function(player, reward)
	AnimalService.spawnAnimalInBase(player, reward.Index, "Christmas")
end

RewardHandlers["Item"] = function(player, reward)
	local playerChannel = Synchronizer:Get(player)
	if playerChannel and not playerChannel:Get("Items." .. reward.Index) then
		playerChannel:InsertOnDictionary("Items", reward.Index, true)
	end
end

RewardHandlers["Server-Luck"] = function(_)
	local endTime = LuckService:GetEndTime()
	if endTime ~= 0 then
		endTime += CONSTANTS.LUCK_DURATION
	else
		endTime = workspace:GetServerTimeNow() + CONSTANTS.LUCK_DURATION
	end
	LuckService:StartLuck(1, endTime)
end

local function processReward(player, reward)
	local handler = RewardHandlers[reward.Type]
	if handler then
		handler(player, reward)
	end
end

Spin.OnServerEvent:Connect(function(player)
	if isOnCooldown(player) then return end

	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then return end

	local canAfford, missing = ElfService:CanAfford(player, CONSTANTS.SPIN_COST)

	if not canAfford then
		NotificationService.Error(player, "You need 5 Gold Elves to spin!")
		return
	end

	ElfService:Add(player, -CONSTANTS.SPIN_COST)

	local rewardIndex, reward = getWeightedReward(player)
	processReward(player, reward)

	local hasCoils = playerChannel:Get("Items.Christmas Coils") == true
	Spin:FireClient(player, rewardIndex, hasCoils)
end)

RequestBuy.OnServerInvoke = function()
	return false, "Hacking?"
end

function ChristmasEventService:Start()
	task.spawn(function()
		while true do
			local serverTime = workspace:GetServerTimeNow()
			local wday = os.date("!*t", serverTime).wday
			local interval = CONSTANTS.WEEKEND_DAYS[wday] and CONSTANTS.INTERVALS.WEEKEND or CONSTANTS.INTERVALS.WEEKDAY
			task.wait(interval - (serverTime % interval))

			for _, player in pairs(Players:GetPlayers()) do
				local channel = Synchronizer:Get(player)
				if channel then
					ElfService:Add(player, CONSTANTS.SPIN_COST)
					NotificationService.Notify(player, 'The <font color="'..CONSTANTS.NOTIFICATION_COLOR..'">Christmas</font> Event is here! You got 5 <font color="#2ecc71">Gold Elves</font> for a spin! 🎄', CONSTANTS.NOTIFICATION_DURATION, CONSTANTS.NOTIFICATION_SOUND)
				end
			end
			EventService:ExecuteEvent("Christmas", CONSTANTS.EVENT_DURATION)
		end
	end)
end

Players.PlayerRemoving:Connect(function(player)
	LastActionTime[player] = nil
end)

return ChristmasEventService