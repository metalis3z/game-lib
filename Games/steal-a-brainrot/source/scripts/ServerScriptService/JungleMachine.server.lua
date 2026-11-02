local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local AnimalService = require(ServerScriptService.Services.AnimalService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Animals = require(ReplicatedStorage.Datas.Animals)

local proxi = workspace.JungleMachine:WaitForChild("Proxi")
local spinButton = proxi:WaitForChild("SpinButton")

local COOLDOWN = 7200

local REWARDS = {
	{ name = "Arcadopus",          chance = 30 },
	{ name = "Nuclearo Dinossauro",  chance = 25 },
	{ name = "Garama and Madundung", chance = 15 },
	{ name = "Dragon Cannelloni",      chance = 10 },
	{ name = "Dragon Gingerini",      chance = 5 },
}

local function pickReward()
	local roll = math.random() * 100
	local cumulative = 0
	for _, reward in ipairs(REWARDS) do
		cumulative += reward.chance
		if roll <= cumulative then
			return reward.name
		end
	end
	return REWARDS[#REWARDS].name
end

local function formatTime(seconds)
	local h = math.floor(seconds / 3600)
	local m = math.floor((seconds % 3600) / 60)
	local s = seconds % 60
	if h > 0 then
		return string.format("%dh %02dm %02ds", h, m, s)
	elseif m > 0 then
		return string.format("%dm %02ds", m, s)
	else
		return string.format("%ds", s)
	end
end

spinButton.Triggered:Connect(function(player)
	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then return end

	local lastSpin = playerChannel:Get("JungleMachineCooldown") or (os.time() - COOLDOWN)
	local timeLeft = math.max(0, COOLDOWN - (os.time() - lastSpin))

	if timeLeft > 0 then
		-- Vérifier si le joueur a des jetons pour bypass le cooldown
		local jetons = playerChannel:Get("JungleMachineJetons") or 0
		if jetons > 0 then
			playerChannel:Set("JungleMachineJetons", jetons - 1)
			NotificationService.Success(player, "🎰 Jeton utilisé ! Spin gratuit débloqué !")
		else
			NotificationService.Error(player, string.format(
				"You can spin again in %s", formatTime(timeLeft)
			))
			return
		end
	else
		playerChannel:Set("JungleMachineCooldown", os.time())
	end

	local reward = pickReward()
	local animalData = Animals[reward]

	if not animalData then
		warn("[JungleMachine] Animal introuvable : " .. reward)
		return
	end

	local success, err = pcall(function()
		AnimalService.spawnAnimalCustom(animalData, nil, nil, nil, {
			Owner = player
		}, nil)
	end)

	if success then
		NotificationService.Success(player, string.format(
			"Congratulations, you won %s !", reward
			))
	else
		warn("[JungleMachine] Erreur spawn: " .. tostring(err))
	end
end)