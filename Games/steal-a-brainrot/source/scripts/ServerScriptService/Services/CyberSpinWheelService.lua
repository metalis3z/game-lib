local CyberSpinWheelService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local AnimalService = require(ServerScriptService.Services.AnimalService)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local CyberSpinWheel = require(ReplicatedStorage.Datas.CyberSpinWheel)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local LuckService = require(ServerScriptService.Services.LuckService)

local Spin = Net:RemoteEvent("CyberEventService/Spin")
local RequestBuy = Net:RemoteFunction("CyberEventService/RequestBuy")

local LastActionTime = {}
local ACTION_COOLDOWN = 0.5

local rng = Random.new()

local function isOnCooldown(player)
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


return CyberSpinWheelService