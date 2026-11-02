-- radioactive spinwheel service
-- delicious
-- kiwi's brother made this
local RadioactiveEventService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local AnimalService = require(ServerScriptService.Services.AnimalService)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local RadioactiveSpinWheel = require(ReplicatedStorage.Datas.RadioactiveSpinWheel)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local EventService = require(ServerScriptService.Services.EventService)
local LuckService = require(ServerScriptService.Services.LuckService)

local Spin = Net:RemoteEvent("RadioactiveEventService/Spin")
local RequestBuy = Net:RemoteFunction("RadioactiveEventService/RequestBuy")

local CONSTANTS = {
	ACTION_COOLDOWN = 0.5,
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

	NOTIFICATION_COLOR = "#68f500",
	NOTIFICATION_SOUND = "Sounds.Sfx.Success",

	ITEMS = {
		SECRET_LUCKY_BLOCK = "Secret Lucky Block",
		RADIOACTIVE_SLAP = "Radioactive Slap",
		RADIOACTIVE_AIRSTRIKE = "Radioactive Airstrike"
	},

	CASH_AMOUNTS = {
		PACK_2 = 425000,
		PACK_3 = 1700000,
		PACK_5 = 17000000
	}
}

local LastActionTime: {[Player]: number} = {}

local RewardHandlers = {}

local function isOnCooldown(player: Player): boolean
	local now = os.clock()
	if LastActionTime[player] and now - LastActionTime[player] < CONSTANTS.ACTION_COOLDOWN then
		return true
	end
	LastActionTime[player] = now
	return false
end

local function givePlayerItem(player: Player, itemName: string)
	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then return end

	if not playerChannel:Get("Items." .. itemName) then
		playerChannel:InsertOnDictionary("Items", itemName, true)
	end
end

local function getWeightedReward(): (number, any)
	local rewards = RadioactiveSpinWheel.Rewards
	local totalWeight = 0

	for _, reward in ipairs(rewards) do
		totalWeight += reward.Weight
	end

	local randomWeight = math.random() * totalWeight
	local cumulative = 0

	for index, reward in ipairs(rewards) do
		cumulative += reward.Weight
		if randomWeight <= cumulative then
			if RadioactiveSpinWheel.AltRewards[index] and 
				math.random() < RadioactiveSpinWheel.AltRewards[index].Weight then
				return index, RadioactiveSpinWheel.AltRewards[index]
			end
			return index, reward
		end
	end

	return 1, rewards[1]
end

RewardHandlers["Secret Lucky Block"] = function(player: Player)
	AnimalService.spawnAnimalInBase(player, CONSTANTS.ITEMS.SECRET_LUCKY_BLOCK, "Radioactive")
end

RewardHandlers["Cash Pack #2"] = function(player: Player)
	MoneyService:Add(player, CONSTANTS.CASH_AMOUNTS.PACK_2)
end

RewardHandlers["Cash Pack #3"] = function(player: Player)
	MoneyService:Add(player, CONSTANTS.CASH_AMOUNTS.PACK_3)
end

RewardHandlers["Cash Pack #5"] = function(player: Player)
	MoneyService:Add(player, CONSTANTS.CASH_AMOUNTS.PACK_5)
end

RewardHandlers["Radioactive Slap"] = function(player: Player)
	givePlayerItem(player, CONSTANTS.ITEMS.RADIOACTIVE_SLAP)
end

RewardHandlers["Radioactive Airstrike"] = function(player: Player)
	givePlayerItem(player, CONSTANTS.ITEMS.RADIOACTIVE_AIRSTRIKE)
end

RewardHandlers["Server-Luck"] = function(_player: Player)
	local endTime = LuckService:GetEndTime()
	if endTime ~= 0 then
		endTime += CONSTANTS.LUCK_DURATION
	else
		endTime = workspace:GetServerTimeNow() + CONSTANTS.LUCK_DURATION
	end
	LuckService:StartLuck(1, endTime)
end

local function processReward(player: Player, reward: any)
	local handler = nil

	if reward.Index then
		handler = RewardHandlers[reward.Index]
	end

	if not handler and reward.Display then
		handler = RewardHandlers[reward.Display]
	end

	if not handler and reward.Type then
		handler = RewardHandlers[reward.Type]
	end

	if handler then
		handler(player)
	end
end

local function hasRadioactiveSlap(player: Player): boolean
	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then return false end
	return playerChannel:Get("Items." .. CONSTANTS.ITEMS.RADIOACTIVE_SLAP) == true
end

local function getSpinInterval(): number
	local serverTime = workspace:GetServerTimeNow()
	local wday = os.date("!*t", serverTime).wday
	return CONSTANTS.WEEKEND_DAYS[wday] and CONSTANTS.INTERVALS.WEEKEND or CONSTANTS.INTERVALS.WEEKDAY
end

local function notifyFreeSpinAvailable(player: Player)
	NotificationService.Notify(
		player,
		string.format(
			'The <font color="%s">Radioactive</font> Event is here! You got a <font color="%s">free spin</font>',
			CONSTANTS.NOTIFICATION_COLOR,
			CONSTANTS.NOTIFICATION_COLOR
		),
		CONSTANTS.NOTIFICATION_DURATION,
		CONSTANTS.NOTIFICATION_SOUND
	)
end

local function grantFreeSpinToAllPlayers()
	for _, player in pairs(Players:GetPlayers()) do
		local playerChannel = Synchronizer:Get(player)
		if playerChannel then
			notifyFreeSpinAvailable(player)
			playerChannel:Increase("RadioactiveSpinWheel.Spins", 1)
		end
	end

	EventService:ExecuteEvent("Radioactive", CONSTANTS.EVENT_DURATION)
end

local function startFreeSpinLoop()
	task.spawn(function()
		while true do
			local serverTime = workspace:GetServerTimeNow()
			local interval = getSpinInterval()
			local waitTime = interval - (serverTime % interval)

			task.wait(waitTime)
			grantFreeSpinToAllPlayers()
		end
	end)
end

Spin.OnServerEvent:Connect(function(player: Player)
	if isOnCooldown(player) then
		return
	end

	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then return end

	local spins = playerChannel:Get("RadioactiveSpinWheel.Spins") or 0

	if spins == 0 then
		NotificationService.Error(player, "You don't have any spins to spin the wheel!")
		return
	end

	playerChannel:Increase("RadioactiveSpinWheel.Spins", -1)

	local rewardIndex, reward = getWeightedReward()

	processReward(player, reward)

	Spin:FireClient(player, rewardIndex, hasRadioactiveSlap(player))
end)

RequestBuy.OnServerInvoke = function(_player: Player, _item: string): (boolean, string?)
	return false, "Hacking?"
end

function RadioactiveEventService:Start()
	startFreeSpinLoop()
end

Players.PlayerRemoving:Connect(function(player)
	LastActionTime[player] = nil
end)

return RadioactiveEventService