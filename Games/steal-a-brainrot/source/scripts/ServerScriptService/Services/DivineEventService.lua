local DivineEventService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local AnimalService = require(ServerScriptService.Services.AnimalService)
local PlotService = require(ServerScriptService.Services.PlotService)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local LuckyBlocks = require(ReplicatedStorage.Datas.LuckyBlocks)
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local DivineSpinWheel = require(ReplicatedStorage.Datas.DivineSpinWheel)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local EventService = require(ServerScriptService.Services.EventService)
local LuckService = require(ServerScriptService.Services.LuckService)

local Spin = Net:RemoteEvent("DivineEventService/Spin")
local RequestBuy = Net:RemoteFunction("DivineEventService/RequestBuy")

local LastActionTime = {}
local ActionCooldown = 0.5

local LastEventAttribute = "DivineEventLastTime"

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
	local rewards = DivineSpinWheel.Rewards
	local totalWeight = 0

	for _, reward in ipairs(rewards) do
		totalWeight += reward.Weight
	end

	local randomWeight = rng:NextNumber() * totalWeight
	local cumulative = 0

	for index, reward in ipairs(rewards) do
		cumulative += reward.Weight
		if randomWeight <= cumulative then
			if DivineSpinWheel.AltRewards[index] then
				local alt = DivineSpinWheel.AltRewards[index]
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

task.spawn(function()
	while false do -- DÉSACTIVÉ
		local unixNow = os.time(os.date("!*t"))
		local nextUnix = computeNextEventTime(unixNow)

		ReplicatedStorage:SetAttribute("NextDivineEvent", nextUnix)

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
					'The <font color=\"#ffd13b\">Divine</font> Event is here! You got a <font color=\"#ffd13b\">free spin!</font>',
					15,
					"Sounds.Sfx.Success"
				)

				EventService:ExecuteEvent("Divine", 900)
				playerChannel:Increase("DivineSpinWheel.Spins", 1)
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

	if (playerChannel:Get("DivineSpinWheel.Spins") or 0) <= 0 then
		NotificationService.Error(player, "You don't have any spins!")
		return
	end

	playerChannel:Increase("DivineSpinWheel.Spins", -1)

	local rewardIndex, mainReward = getWeightedReward()

	task.delay(1, function()
		-- Utiliser mainReward.Type pour une logique robuste
		local rewardType = mainReward.Type

		if rewardType == "Animal" then
			local animalName = mainReward.Index
			local mutation = "Divine" -- Spin wheel donne toujours Divine

			-- Implémenter directement sans Synchronizer:Wait (déjà dans le bon contexte)
			local animalPlayerChannel = Synchronizer:Get(player)
			if animalPlayerChannel then
				local freePodium = PlotService.getFreePodium(player)
				if freePodium then
					local podiumIndex = tonumber(freePodium.Name)
					if podiumIndex then
						local AnimalPodiums = animalPlayerChannel:Get("AnimalPodiums") or {}
						local LuckyBlocksData = LuckyBlocks
						AnimalPodiums[podiumIndex] = {
							Index = animalName,
							LastCollect = os.time(),
							Mutation = mutation,
							Traits = nil,
							Timer = LuckyBlocksData[animalName] and 0 or nil,
						}
						animalPlayerChannel:Set("AnimalPodiums", AnimalPodiums)
						animalPlayerChannel:Set("AnimalAddedOrRemoved", true)
						NotificationService.Success(player,
							string.format("🎰 Tu as reçu <b>%s</b> !", animalName))
					end
				else
					-- Base pleine → mettre en file d'attente
					local pending = animalPlayerChannel:Get("PendingSpinRewards") or {}
					table.insert(pending, {
						Index    = animalName,
						Mutation = mutation,
						Timer    = LuckyBlocks[animalName] and 0 or nil,
					})
					animalPlayerChannel:Set("PendingSpinRewards", pending)
					NotificationService.Notify(player,
						"🎰 Base pleine ! <b>" .. animalName .. "</b> sera donné dès qu'un podium se libère.", 8)
				end
			end

		elseif rewardType == "Cash-Pack" then
			-- Montant selon le display
			local amount = 0
			local d = mainReward.Display or ""
			if d:find("Cash Pack #2") then amount = 25000
			elseif d:find("Cash Pack #3") then amount = 100000
			elseif d:find("Cash Pack #5") then amount = 1000000
			end
			if amount > 0 then MoneyService:Add(player, amount) end

		elseif rewardType == "Item" then
			-- Item (Divine Slap etc.)
			local itemName = mainReward.Index
			if itemName and itemName ~= "" then
				if not playerChannel:Get("Items." .. itemName) then
					playerChannel:InsertOnDictionary("Items", itemName, true)
					NotificationService.Success(player, "🌟 Tu as reçu <b>" .. itemName .. "</b> !")
				else
					-- Déjà possédé → consolation
					MoneyService:Add(player, 500000)
					NotificationService.Success(player, "💰 Item déjà possédé → +500,000 coins !")
				end
			end

		elseif rewardType == "Server-Luck" then
			local endTime = LuckService:GetEndTime()
			if endTime ~= 0 then
				endTime += 900
			else
				endTime = workspace:GetServerTimeNow() + 900
			end
			LuckService:StartLuck(mainReward.Index or 1, endTime)
		end
	end)

	Spin:FireClient(player, rewardIndex, playerChannel:Get("Items.Divine Slap") == true)
end)

RequestBuy.OnServerInvoke = function()
	return false, "nil"
end

return DivineEventService