local PhantomSpinWheelService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local AnimalService = require(ServerScriptService.Services.AnimalService)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local PhantomSpinWheel = require(ReplicatedStorage.Datas.PhantomSpinWheel)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local EventService = require(ServerScriptService.Services.EventService)
local LuckService = require(ServerScriptService.Services.LuckService)

local Spin = Net:RemoteEvent("PhantomEventService/Spin")
local RequestBuy = Net:RemoteFunction("PhantomEventService/RequestBuy")

local LastActionTime = {}
local ACTION_COOLDOWN = 0.5

local LAST_EVENT_ATTRIBUTE = "PhantomEventLastTime"

local rng = Random.new()

local function isOnCooldown(player)
	local now = os.clock()
	if LastActionTime[player] and now - LastActionTime[player] < ACTION_COOLDOWN then
		return true
	end
	LastActionTime[player] = now
	return false
end

local function getWeightedReward()
	local rewards = PhantomSpinWheel.Rewards
	local totalWeight = 0

	for _, reward in ipairs(rewards) do
		totalWeight += reward.Weight
	end

	local randomWeight = rng:NextNumber() * totalWeight
	local cumulative = 0

	for index, reward in ipairs(rewards) do
		cumulative += reward.Weight
		if randomWeight <= cumulative then
			if PhantomSpinWheel.AltRewards[index] then
				local alt = PhantomSpinWheel.AltRewards[index]
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

function PhantomSpinWheelService:Start()
	task.spawn(function()
		Players.PlayerRemoving:Connect(function(player)
			LastActionTime[player] = nil
		end)

		task.spawn(function()
			while true do
				local unixNow = os.time(os.date("!*t"))
				local nextUnix = computeNextEventTime(unixNow)

				ReplicatedStorage:SetAttribute("NextPhantomEvent", nextUnix)

				local waitSeconds = math.max(0, nextUnix - unixNow)
				task.wait(waitSeconds)

				if ReplicatedStorage:GetAttribute(LAST_EVENT_ATTRIBUTE) == nextUnix then
					task.wait(1)
					continue
				end

				ReplicatedStorage:SetAttribute(LAST_EVENT_ATTRIBUTE, nextUnix)

				for _, player in ipairs(Players:GetPlayers()) do
					local playerChannel = Synchronizer:Get(player)
					if playerChannel then
						NotificationService.Notify(
							player,
							'The <phantom><b>Phantom</b></phantom> Event is here! You got a Free Spin!',
							15,
							"Sounds.Sfx.Success"
						)

						EventService:ExecuteEvent("Phantom", 900)
						playerChannel:Increase("PhantomSpinWheel.Spins", 1)
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

			if (playerChannel:Get("PhantomSpinWheel.Spins") or 0) <= 0 then
				NotificationService.Error(player, "You don't have any spins!")
				return
			end

			playerChannel:Increase("PhantomSpinWheel.Spins", -1)

			local rewardIndex, mainReward = getWeightedReward()

			task.delay(1, function()
				if mainReward.Index == "Secret Lucky Block" then
					AnimalService.spawnAnimalInBase(player, "Secret Lucky Block", "Phantom")

				elseif mainReward.Display == "Cash Pack #2" then
					MoneyService:Add(player, 25000)

				elseif mainReward.Display == "Cash Pack #3" then
					MoneyService:Add(player, 100000)

				elseif mainReward.Display == "Cash Pack #5" then
					MoneyService:Add(player, 1000000)

				elseif mainReward.Display == "Phantom Slap" then
					if not playerChannel:Get("Items.Phantom Slap") then
						playerChannel:InsertOnDictionary("Items", "Phantom Slap", true)
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

			Spin:FireClient(player, rewardIndex, playerChannel:Get("Items.Phantom Slap") == true)
		end)

		RequestBuy.OnServerInvoke = function()
			return false, "haker"
		end
	end)
end

return PhantomSpinWheelService