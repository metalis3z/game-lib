--!strict
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
local LastActionTime: { [Player]: number } = {}
local ACTION_COOLDOWN = 0.5

local function isOnCooldown(player: Player): boolean
	local now = os.clock()
	if LastActionTime[player] and now - LastActionTime[player] < ACTION_COOLDOWN then
		return true
	end
	LastActionTime[player] = now
	return false
end

Players.PlayerRemoving:Connect(function(player)
	LastActionTime[player] = nil
end)

local function getWeightedReward()
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
			if RadioactiveSpinWheel.AltRewards[index] and math.random() < RadioactiveSpinWheel.AltRewards[index].Weight then
				return index, RadioactiveSpinWheel.AltRewards[index]
			end
			return index, reward
		end
	end
	return 1, rewards[1]
end

task.spawn(function()
	while true do
		local ServerTimeNow = workspace:GetServerTimeNow()
		local wday = os.date("!*t", ServerTimeNow).wday
		local Interval = (wday == 1 or wday == 7) and 3600 or 10800
		task.wait(Interval - (ServerTimeNow % Interval))
		for _, player in pairs(Players:GetPlayers()) do
			local playerChannel = Synchronizer:Get(player)
			if playerChannel then
				NotificationService.Notify(
					player,
					'The <stroke color="#bbce00"><font color="#8fce00">Radioactive</font></stroke> Event is here! You got a <stroke color="#fff"><font color="#000">free spin</font></stroke>',
					15,
					"Sounds.Sfx.Success"
				)
				EventService:ExecuteEvent("Radioactive", 900)
				playerChannel:Increase("RadioactiveSpinWheel.Spins", 1)
			end
		end
	end
end)

Spin.OnServerEvent:Connect(function(player: Player)
	if isOnCooldown(player) then
		return
	end
	local playerChannel = Synchronizer:Get(player)
	assert(playerChannel)
	if playerChannel:Get("RadioactiveSpinWheel.Spins") - 1 < 0 then
		NotificationService.Error(player, "You don't have any spins to spin the wheel!")
		return
	end
	playerChannel:Increase("RadioactiveSpinWheel.Spins", -1)
	local rewardIndex, mainReward = getWeightedReward()
	task.delay(1, function()
		if mainReward.Index == "Secret Lucky Block" then
			AnimalService.spawnAnimalInBase(player, "Secret Lucky Block", "Radioactive")
		elseif mainReward.Display == "Cash Pack #2" then
			MoneyService:Add(player, 25000)
		elseif mainReward.Display == "Cash Pack #3" then
			MoneyService:Add(player, 100000)
		elseif mainReward.Display == "Radioactive Slap" then
			if not playerChannel:Get("Items.Radioactive Slap") then
				playerChannel:InsertOnDictionary("Items", "Radioactive Slap", true)
			end
		elseif mainReward.Display == "Cash Pack #5" then
			MoneyService:Add(player, 1000000)
		elseif mainReward.Display == "Radioactive Airstrike" then
			if not playerChannel:Get("Items.Radioactive Airstrike") then
				playerChannel:InsertOnDictionary("Items", "Radioactive Airstrike", true)
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
	if playerChannel:Get("Items.Radioactive Slap") then
		Spin:FireClient(player, rewardIndex, true)
	else
		Spin:FireClient(player, rewardIndex)
	end
end)

RequestBuy.OnServerInvoke = function(player: Player, item: string): (boolean, string?)
	return false, "haker"
end

return RadioactiveEventService