local CyberEventService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local AnimalService = require(ServerScriptService.Services.AnimalService)
local PlotService = require(ServerScriptService.Services.PlotService)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local CyberSpinWheel = require(ReplicatedStorage.Datas.CyberSpinWheel)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local EventService = require(ServerScriptService.Services.EventService)
local LuckService = require(ServerScriptService.Services.LuckService)

local Spin = Net:RemoteEvent("CyberEventService/Spin")

local LastActionTime = {}
local ActionCooldown = 0.5

local LastEventAttribute = "CyberEventLastTime"

-- Migration: Fix old data with typo "CyberSpinWheelWheel" -> "CyberSpinWheel"
local function migrateOldData(player, playerChannel)
	-- Check if player has old data with typo key
	local oldData = playerChannel:Get("CyberSpinWheelWheel")
	if oldData and type(oldData) == "table" then
		-- Check if new data exists
		local newData = playerChannel:Get("CyberSpinWheel")
		if not newData then
			-- Migrate old data to new key
			playerChannel:Set("CyberSpinWheel", oldData)
			-- Clear old data
			playerChannel:Set("CyberSpinWheelWheel", nil)
			print("[CyberEventService] Migrated CyberSpinWheelWheel data for player:", player.Name)
		end
	end
end

local rng = Random.new()

local function isOnCooldown(player)
	local now = os.clock()
	if LastActionTime[player] and now - LastActionTime[player] < ActionCooldown then
		return true
	end
	LastActionTime[player] = now
	return false
end

Players.PlayerRemoving:Connect(function(player)
	LastActionTime[player] = nil
end)

local function getWeightedReward()
	local rewards = CyberSpinWheel.Rewards
	local totalWeight = 0

	for _, reward in ipairs(rewards) do
		totalWeight += reward.Weight
	end

	local randomWeight = rng:NextNumber() * totalWeight
	local cumulative = 0

	for index, reward in ipairs(rewards) do
		cumulative += reward.Weight
		if randomWeight <= cumulative then
			if CyberSpinWheel.AltRewards[index] then
				local alt = CyberSpinWheel.AltRewards[index]
				if rng:NextNumber() < alt.Weight then
					return index, alt
				end
			end
			return index, reward
		end
	end

	return 1, rewards[1]
end

local function computeInterval(unixNow)
	local wday = os.date("!*t", unixNow).wday
	return (wday == 1 or wday == 7) and 3600 or 10800
end

local function computeNextEventTime(unixNow)
	local interval = computeInterval(unixNow)
	return (unixNow - (unixNow % interval)) + interval
end

-- Migrate data for players already in the game
for _, player in ipairs(Players:GetPlayers()) do
	task.spawn(function()
		local playerChannel = Synchronizer:Get(player)
		if playerChannel then
			migrateOldData(player, playerChannel)
		end
	end)
end

-- Migrate data for new players
Players.PlayerAdded:Connect(function(player)
	task.spawn(function()
		local playerChannel = Synchronizer:Wait(player)
		if playerChannel then
			migrateOldData(player, playerChannel)
		end
	end)
end)

task.spawn(function()
	while true do
		local unixNow = os.time(os.date("!*t"))
		local nextUnix = computeNextEventTime(unixNow)

		ReplicatedStorage:SetAttribute("NextCyberEvent", nextUnix)

		local waitSeconds = math.max(0, nextUnix - unixNow)
		task.wait(waitSeconds)

		if ReplicatedStorage:GetAttribute(LastEventAttribute) == nextUnix then
			task.wait(1)
			continue
		end

		ReplicatedStorage:SetAttribute(LastEventAttribute, nextUnix)

		for _, player in ipairs(Players:GetPlayers()) do
			local playerChannel = Synchronizer:Get(player)
			if playerChannel then
				NotificationService.Notify(
					player,
					'The <font color="#79dbff">Cyber</font> Event is here! You got a <font color="#79dbff">free spin!</font>',
					15,
					"Sounds.Sfx.Success"
				)

				EventService:ExecuteEvent("Cyber", 900)
				playerChannel:Increase("CyberSpinWheel.Spins", 1)
			end
		end
	end
end)

Spin.OnServerEvent:Connect(function(player)
	if isOnCooldown(player) then
		return
	end

	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then return end

	local storedSpins = playerChannel:Get("CyberSpinWheel.Spins") or 0
	local lastFreeClaimed = playerChannel:Get("CyberSpinWheel.LastFreeClaimed") or 0
	local lastEventTime = ReplicatedStorage:GetAttribute(LastEventAttribute) or 0
	local cyberEventActive = ReplicatedStorage:GetAttribute("CyberEvent")

	-- Check if player has a free spin available
	local hasFreeSpin = cyberEventActive and lastFreeClaimed ~= lastEventTime

	if storedSpins <= 0 and not hasFreeSpin then
		NotificationService.Error(player, "You don't have any spins!")
		return
	end

	-- Deduct from stored spins first, or mark free spin as claimed
	if storedSpins > 0 then
		playerChannel:Increase("CyberSpinWheel.Spins", -1)
	else
		-- Claim the free spin
		playerChannel:Set("CyberSpinWheel.LastFreeClaimed", lastEventTime)
	end

	local rewardIndex, mainReward = getWeightedReward()

	task.delay(1, function()
		if mainReward.Index == "Secret Lucky Block" then
			PlotService.AddAnimalOnPlotOrQueue(player, "Secret Lucky Block", "Cyber")

		elseif mainReward.Display == "Cash Pack #2" then
			MoneyService:Add(player, 25000)

		elseif mainReward.Display == "Cash Pack #3" then
			MoneyService:Add(player, 100000)

		elseif mainReward.Display == "Cash Pack #5" then
			MoneyService:Add(player, 1000000)

		elseif mainReward.Display == "Cyber Slap" then
			if not playerChannel:Get("Items.Cyber Slap") then
				playerChannel:InsertOnDictionary("Items", "Cyber Slap", true)
			end

		elseif mainReward.Type == "Server-Luck" then
			local endTime = LuckService:GetEndTime()
			if endTime ~= 0 then
				endTime += 900
			else
				endTime = workspace:GetServerTimeNow() + 900
			end
			LuckService:StartLuck(1, endTime)
		end
	end)

	Spin:FireClient(player, rewardIndex, playerChannel:Get("Items.Cyber Slap") == true)
end)
return CyberEventService