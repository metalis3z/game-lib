-- By Mr_Wyzoxx
local RNGMachineService = {DebugStatus = "NotStarted"}
local started = false

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService = game:GetService("CollectionService")

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local ReplicatorServer = require(ReplicatedStorage.Packages.ReplicatorServer)
local Animals = require(ReplicatedStorage.Datas.Animals)
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)
local NotificationService: any
local AnimalService: any
local PlotService: any
local getModelSource: (string) -> Instance?

local BuyRemote = Net:RemoteFunction("RNGMachineService/Buy")
local BuySkillRemote = Net:RemoteFunction("RNGMachineService/BuySkill")
local SpinStageRemote = Net:RemoteEvent("RNGMachineService/SpinStage")
local LuckExplosionRemote = Net:RemoteEvent("RNGMachineService/LuckExplosion")

local SPIN_COSTS = {172500, 350000, 750000, 1500000, 4000000, 10000000, 25000000}
local SPEED_COST_MULTIPLIER = 1.18
local OFFER_DURATION = 60
local ENTRY_COUNT = 8
local LUCK_RESULT_CHANCE = 0.15
local LUCK_RESULT_HOLD = 1

-- Chance-based luck drop table. When a spin lands on a luck result, a multiplier
-- is rolled from this weighted table. Higher multipliers are far rarer.
local LUCK_DROPS = {
	{Multiplier = 2, Weight = 800},
	{Multiplier = 4, Weight = 350},
	{Multiplier = 6, Weight = 180},
	{Multiplier = 8, Weight = 90},
	{Multiplier = 10, Weight = 45},
	{Multiplier = 12, Weight = 22},
	{Multiplier = 15, Weight = 11},
	{Multiplier = 20, Weight = 5},
	{Multiplier = 25, Weight = 2},
	{Multiplier = 30, Weight = 1},
}

local SKILL_TREE = {
	Luck = {
		{Multiplier = 2, Cost = 500000, RequiredRebirths = 0},
		{Multiplier = 4, Cost = 2500000, RequiredRebirths = 1},
		{Multiplier = 6, Cost = 12500000, RequiredRebirths = 3},
		{Multiplier = 8, Cost = 60000000, RequiredRebirths = 5},
		{Multiplier = 10, Cost = 250000000, RequiredRebirths = 8},
		{Multiplier = 12, Cost = 1000000000, RequiredRebirths = 12},
	},
	Speed = {
		{Cost = 350000, RequiredRebirths = 0},
		{Cost = 1500000, RequiredRebirths = 1},
		{Cost = 7500000, RequiredRebirths = 2},
		{Cost = 30000000, RequiredRebirths = 4},
		{Cost = 125000000, RequiredRebirths = 7},
		{Cost = 500000000, RequiredRebirths = 10},
	},
	GoldMutation = {
		{Mutation = "Gold", Cost = 1000000, RequiredRebirths = 0},
		{Mutation = "Gold", Cost = 10000000, RequiredRebirths = 3},
		{Mutation = "Gold", Cost = 100000000, RequiredRebirths = 7},
	},
	DiamondMutation = {
		{Mutation = "Diamond", Cost = 5000000, RequiredRebirths = 1},
		{Mutation = "Diamond", Cost = 50000000, RequiredRebirths = 5},
		{Mutation = "Diamond", Cost = 500000000, RequiredRebirths = 10},
	},
	RainbowMutation = {
		{Mutation = "Rainbow", Cost = 25000000, RequiredRebirths = 3},
		{Mutation = "Rainbow", Cost = 250000000, RequiredRebirths = 8},
		{Mutation = "Rainbow", Cost = 2500000000, RequiredRebirths = 14},
	},
	EventMutation = {
		{Mutation = "Candy", Cost = 100000000, RequiredRebirths = 5},
		{Mutation = "Lava", Cost = 300000000, RequiredRebirths = 7},
		{Mutation = "Galaxy", Cost = 1000000000, RequiredRebirths = 10},
		{Mutation = "YinYang", Cost = 3000000000, RequiredRebirths = 13},
		{Mutation = "Radioactive", Cost = 10000000000, RequiredRebirths = 16},
		{Mutation = "Cursed", Cost = 30000000000, RequiredRebirths = 20},
	},
}

local REWARD_WHITELIST = {
	"Los Noobinis",
	"Pi Pi Watermelon",
	"Bandito Axolito",
	"Matteo",
	"Pakrahmatmatina",
	"Urubini Flamenguini",
	"Brasilini Berimbini",
	"Brainrot God Lucky Block",
	"Pakrahmatmamat",
	"Magi Ribbitini",
	"Espresso Signora",
	"Toiletto Focaccino",
	"Gattatino Nyanino",
	"Tartaruga Cisterna",
	"Bombardini Tortinii",
}
local MUTATION_CHANCES = {
	GoldMutation = {0.03, 0.07, 0.14},
	DiamondMutation = {0.015, 0.04, 0.09},
	RainbowMutation = {0.006, 0.018, 0.05},
	EventMutation = {0.003, 0.006, 0.012, 0.02, 0.035, 0.06},
}

local rewardPool: {string} = {}
local boostedRewardPool: {string} = {}
local playerReplicators: {[Player]: any} = {}
local spinTokens: {[Player]: number} = {}
local reservedPodiums: {[Player]: {[number]: boolean}} = {}
local promptConnections: {[Instance]: RBXScriptConnection} = {}
local activityReplicator = ReplicatorServer.get("RNGMachineActivity", {Sessions = {}})
RNGMachineService.DebugActivity = activityReplicator
RNGMachineService.DebugPlayers = {}
RNGMachineService.DebugForceTwoX = false

local function getLevels(channel: any): {[string]: number}
	local saved = channel:Get("RNGMachine")
	if type(saved) ~= "table" then
		saved = {}
	end
	local levels = {}
	for skillName, nodes in pairs(SKILL_TREE) do
		local value = saved[skillName .. "Level"]
		levels[skillName] = if type(value) == "number" then math.clamp(math.floor(value), 0, #nodes) else 0
	end
	return levels
end

local function findFreePodium(channel: any, player: Player?): number?
	local reserved = if player then reservedPodiums[player] else nil
	if player and PlotService then
		local ok, physicalPodium = pcall(PlotService.getFreePodium, player)
		if ok and physicalPodium then
			local physicalIndex = tonumber(physicalPodium.Name)
			if physicalIndex and not (reserved and reserved[physicalIndex]) then
				return physicalIndex
			end
		end
		return nil
	end

	local podiums = channel:Get("AnimalPodiums")
	if type(podiums) ~= "table" then
		return nil
	end
	local best: number? = nil
	for index, value in pairs(podiums) do
		if type(index) == "number" and (value == "Empty" or value == nil) and not (reserved and reserved[index]) and (best == nil or index < best) then
			best = index
		end
	end
	return best
end

local function grantAnimal(channel: any, animalName: string, mutation: string?, preferredPodiumIndex: number?): boolean
	local podiumIndex = preferredPodiumIndex or findFreePodium(channel)
	if not podiumIndex then
		return false
	end
	local podiums = channel:Get("AnimalPodiums")
	local indexData = channel:Get("Index")
	if type(podiums) ~= "table" then
		return false
	end
	podiums = table.clone(podiums)
	if type(indexData) ~= "table" then
		indexData = {}
	else
		indexData = table.clone(indexData)
	end
	local variants = indexData[animalName]
	if type(variants) ~= "table" then
		variants = {}
	else
		variants = table.clone(variants)
	end
	local variantName = mutation or "Default"
	variants[variantName] = (tonumber(variants[variantName]) or 0) + 1
	indexData[animalName] = variants
	podiums[podiumIndex] = {
		Index = animalName,
		LastCollect = workspace:GetServerTimeNow(),
		Mutation = mutation,
		Traits = {},
	}
	channel:Set("Index", indexData)
	channel:Set("AnimalPodiums", podiums)
	channel:Set("AnimalAddedOrRemoved", true)
	return true
end

local function getPlayerPlot(player: Player): Model?
	local plots = workspace:FindFirstChild("Plots")
	if not plots then return nil end
	for _, plot in ipairs(plots:GetChildren()) do
		if plot:IsA("Model") and (plot:GetAttribute("Player") == player.Name or plot:GetAttribute("Player") == player.UserId) then
			return plot
		end
	end
	return nil
end

local function playDeliveryAnimation(model: Model, animalName: string, animationName: string): AnimationTrack?
	local animations = ReplicatedStorage.Animations.Animals:FindFirstChild(animalName)
	local animation = animations and (animations:FindFirstChild(animationName) or animations:FindFirstChild("Idle") or animations:FindFirstChild("Walk"))
	if not animation or not animation:IsA("Animation") then return nil end
	local controller = model:FindFirstChildWhichIsA("AnimationController", true)
	if not controller then
		controller = Instance.new("AnimationController")
		controller.Parent = model
	end
	local animator = controller:FindFirstChildOfClass("Animator") or Instance.new("Animator")
	animator.Parent = controller
	local ok, track = pcall(animator.LoadAnimation, animator, animation)
	if ok and track then
		track.Looped = true
		track.Priority = if animationName == "Walk" then Enum.AnimationPriority.Movement else Enum.AnimationPriority.Idle
		track:Play(0.15)
		return track
	end
	return nil
end

local function pivotWithFeetOnGround(model: Model, x: number, z: number, groundY: number, lookAtPosition: Vector3)
	local position = Vector3.new(x, 0, z)
	local flatLookAt = Vector3.new(lookAtPosition.X, 0, lookAtPosition.Z)
	if (flatLookAt - position).Magnitude > 0.01 then
		model:PivotTo(CFrame.lookAt(position, flatLookAt))
	else
		model:PivotTo(CFrame.new(position))
	end
	local boundingBox, size = model:GetBoundingBox()
	local bottomY = boundingBox.Position.Y - size.Y * 0.5
	model:PivotTo(model:GetPivot() + Vector3.new(0, groundY - bottomY, 0))
end

local function deliverAnimal(player: Player, channel: any, animalName: string, mutation: string?, podiumIndex: number, deliveryOrigin: Vector3?)
	local plot = getPlayerPlot(player)
	local target = plot and plot:FindFirstChild("AnimalTarget")
	local center = CollectionService:GetTagged("RNGMachineCenter")[1]
	local modelSource = getModelSource(animalName)
	local visual = if modelSource and modelSource:IsA("Model") then modelSource:Clone() else nil

	if visual and target and target:IsA("BasePart") and (deliveryOrigin or (center and center:IsA("BasePart"))) then
		local primary = visual.PrimaryPart or visual:FindFirstChildWhichIsA("BasePart", true)
		if primary then
			visual.PrimaryPart = primary
			for _, descendant in ipairs(visual:GetDescendants()) do
				if descendant:IsA("BasePart") then
					descendant.CanCollide = false
					descendant.CanTouch = false
					descendant.CanQuery = false
					descendant.Massless = true
				end
			end
			primary.Anchored = true
			visual.Name = "RNG Delivery - " .. animalName
			visual:SetAttribute("Index", animalName)
			visual:SetAttribute("Mutation", mutation)
			visual.Parent = workspace
			if mutation then
				local mutationOk, mutationCleanup = pcall(SharedAnimals.ApplyMutation, SharedAnimals, visual, animalName, mutation)
				if not mutationOk then
					warn(("[RNGMachine] Failed to apply %s mutation to %s delivery: %s"):format(mutation, animalName, tostring(mutationCleanup)))
				elseif mutationCleanup then
					visual.Destroying:Once(mutationCleanup)
				end
			end
			local idleTrack = playDeliveryAnimation(visual, animalName, "Idle")

			local raycastParams = RaycastParams.new()
			raycastParams.FilterType = Enum.RaycastFilterType.Exclude
			local excluded = {visual}
			if center then
				table.insert(excluded, center)
			end
			raycastParams.FilterDescendantsInstances = excluded
			local spawnPoint = deliveryOrigin or center.Position
			local floorHit = if deliveryOrigin then nil else workspace:Raycast(spawnPoint, Vector3.new(0, -50, 0), raycastParams)
			local machineFloorY = if deliveryOrigin then deliveryOrigin.Y elseif floorHit then floorHit.Position.Y else spawnPoint.Y
			local targetFloorY = target.Position.Y + target.Size.Y * 0.5
			local destination = Vector3.new(target.Position.X, targetFloorY, target.Position.Z)

			if deliveryOrigin then
				-- Merchant deliveries appear facing away, visibly turn around, then walk to the buyer's base.
				local flatDirection = Vector3.new(destination.X - spawnPoint.X, 0, destination.Z - spawnPoint.Z)
				if flatDirection.Magnitude < 0.01 then
					flatDirection = Vector3.new(0, 0, -1)
				end
				local awayLookAt = spawnPoint - flatDirection.Unit * 10
				pivotWithFeetOnGround(visual, spawnPoint.X, spawnPoint.Z, machineFloorY, awayLookAt)
				task.wait(0.35)
				local startCFrame = visual:GetPivot()
				pivotWithFeetOnGround(visual, spawnPoint.X, spawnPoint.Z, machineFloorY, destination)
				local targetCFrame = visual:GetPivot()
				visual:PivotTo(startCFrame)
				local turnStartedAt = os.clock()
				local turnDuration = 0.55
				while visual.Parent and player.Parent do
					local alpha = math.clamp((os.clock() - turnStartedAt) / turnDuration, 0, 1)
					visual:PivotTo(startCFrame:Lerp(targetCFrame, alpha * alpha * (3 - 2 * alpha)))
					if alpha >= 1 then break end
					task.wait()
				end
			else
				local frontLookAt = spawnPoint - center.CFrame.RightVector * 10
				local dropStartedAt = os.clock()
				local dropDuration = math.clamp(math.abs(spawnPoint.Y - machineFloorY) / 8, 0.3, 1)
				while visual.Parent and player.Parent do
					local alpha = math.clamp((os.clock() - dropStartedAt) / dropDuration, 0, 1)
					local bottomY = spawnPoint.Y + (machineFloorY - spawnPoint.Y) * alpha
					pivotWithFeetOnGround(visual, spawnPoint.X, spawnPoint.Z, bottomY, frontLookAt)
					if alpha >= 1 then break end
					task.wait()
				end
				task.wait(1)
			end

			if idleTrack then
				idleTrack:Stop(0.15)
			end
			if visual.Parent and player.Parent then
				playDeliveryAnimation(visual, animalName, "Walk")
			end
			local startPosition = Vector3.new(spawnPoint.X, machineFloorY, spawnPoint.Z)
			local distance = (Vector3.new(destination.X, 0, destination.Z) - Vector3.new(startPosition.X, 0, startPosition.Z)).Magnitude
			local duration = math.clamp(distance / 12, 2, 9)
			local startedAt = os.clock()
			while visual.Parent and player.Parent do
				local alpha = math.clamp((os.clock() - startedAt) / duration, 0, 1)
				local position = startPosition:Lerp(destination, alpha)
				local expectedGroundY = machineFloorY + (targetFloorY - machineFloorY) * alpha
				local groundProbeOrigin = Vector3.new(position.X, expectedGroundY + 4, position.Z)
				local groundHit = workspace:Raycast(groundProbeOrigin, Vector3.new(0, -40, 0), raycastParams)
				local groundY = if groundHit then groundHit.Position.Y else expectedGroundY
				pivotWithFeetOnGround(visual, position.X, position.Z, groundY, destination)
				if alpha >= 1 then break end
				task.wait()
			end
			visual:Destroy()
		end
	end

	if player.Parent then
		local beforeCount = 0
		for _, podiumData in pairs(channel:Get("AnimalPodiums") or {}) do
			if type(podiumData) == "table" then
				beforeCount += 1
			end
		end
		local depositOk, deposited = pcall(AnimalService.spawnAnimalInBase, player, animalName, mutation, {}, false, podiumIndex)
		if not depositOk then
			warn(("[RNGMachine] Failed to deposit %s for %s: %s"):format(animalName, player.Name, tostring(deposited)))
		end
		local afterCount = 0
		for _, podiumData in pairs(channel:Get("AnimalPodiums") or {}) do
			if type(podiumData) == "table" then
				afterCount += 1
			end
		end
		if not (depositOk and deposited and afterCount > beforeCount) then
			NotificationService.Error(player, "The delivery could not find a free podium.")
		end
	end
	PlotService.RemoveFromQueue(player, podiumIndex)
	if reservedPodiums[player] then
		reservedPodiums[player][podiumIndex] = nil
	end
end

local function makePlayerState()
	return {
		Enabled = true,
		ShowResultOdds = false,
		State = "Idle",
		SpinCosts = SPIN_COSTS,
		SpeedSpinCostMultiplier = SPEED_COST_MULTIPLIER,
		SkillTree = SKILL_TREE,
		Offer = nil,
	}
end

local function setSession(player: Player, value: any?)
	activityReplicator:Set({"Sessions", tostring(player.UserId)}, value)
end

local function setPlayerState(player: Player, state: string, offer: any?)
	local rep = playerReplicators[player]
	if not rep then
		return
	end
	rep:SetKey("State", state)
	rep:SetKey("Offer", offer)
end

local function setupPlayer(player: Player)
	RNGMachineService.DebugPlayers[tostring(player.UserId)] = "Starting"
	if playerReplicators[player] then
		return
	end
	local rep = ReplicatorServer.get("RNGMachine_" .. player.UserId, makePlayerState())
	playerReplicators[player] = rep
	rep:SetData(makePlayerState())
	rep:AddSubscriber(player)
	activityReplicator:AddSubscriber(player)
	RNGMachineService.DebugPlayers[tostring(player.UserId)] = "Ready"
end

local function getLuckMultiplier(level: number): number
	if level <= 0 then
		return 1
	end
	return SKILL_TREE.Luck[level].Multiplier
end

local function getSpinCost(levels: {[string]: number}): number
	local baseCost = SPIN_COSTS[levels.Luck + 1] or SPIN_COSTS[#SPIN_COSTS]
	return math.round(baseCost * SPEED_COST_MULTIPLIER ^ levels.Speed)
end

local function getSpinDuration(_speedLevel: number): number
	return 5
end

getModelSource = function(name: string): Instance?
	local library = game:GetService("ServerStorage"):FindFirstChild("__AssetLibrary")
	local m = library and library:FindFirstChild("m")
	local model = m and m:FindFirstChild(name)
	if model then
		return model
	end
	-- The __AssetLibrary is only populated lazily at runtime; fall back to the
	-- source models in ReplicatedStorage so reward building never fails.
	local animals = ReplicatedStorage:FindFirstChild("Models") and ReplicatedStorage.Models:FindFirstChild("Animals")
	return animals and animals:FindFirstChild(name)
end

local function buildRewardBuckets()
	table.clear(rewardPool)
	table.clear(boostedRewardPool)
	local animations = ReplicatedStorage.Animations.Animals
	local models = ReplicatedStorage:FindFirstChild("Models") and ReplicatedStorage.Models:FindFirstChild("Animals")
	for _, name in ipairs(REWARD_WHITELIST) do
		local data = Animals[name]
		if type(data) == "table"
			and type(data.Price) == "number"
			and data.Price > 0
			and animations:FindFirstChild(name)
			and models
			and models:FindFirstChild(name)
		then
			table.insert(rewardPool, name)
		else
			warn(("[RNGMachine] Whitelisted reward is missing required assets: %s"):format(name))
		end
	end
	for name, data in pairs(Animals) do
		if type(data) == "table"
			and data.Rarity == "Secret"
			and type(data.Price) == "number"
			and data.Price > 0
			and animations:FindFirstChild(name)
			and models
			and models:FindFirstChild(name)
		then
			table.insert(boostedRewardPool, name)
		end
	end
	table.sort(boostedRewardPool)
	if #rewardPool == 0 then
		warn("[RNGMachine] Reward whitelist has no valid brainrots; RNG machine disabled")
	end
	if #boostedRewardPool == 0 then
		warn("[RNGMachine] The 2x Secret reward pool has no valid brainrots")
	end
end

local function getRewardWeight(name: string): number
	local data = Animals[name]
	local price = if type(data) == "table" then tonumber(data.Price) or 0 else 0
	if price < 50000000 then
		return 1
	elseif price < 100000000 then
		return 0.06
	elseif price < 250000000 then
		return 0.025
	elseif price < 1000000000 then
		return 0.008
	else
		return 0.002
	end
end

local function rollFromPool(pool: {string}): (string, number)
	local totalWeight = 0
	for _, name in ipairs(pool) do
		totalWeight += getRewardWeight(name)
	end

	local roll = math.random() * totalWeight
	local selectedName = pool[#pool]
	local selectedWeight = getRewardWeight(selectedName)
	for _, name in ipairs(pool) do
		local weight = getRewardWeight(name)
		roll -= weight
		if roll <= 0 then
			selectedName = name
			selectedWeight = weight
			break
		end
	end

	local approximateOdds = math.max(1, math.round(totalWeight / selectedWeight))
	return selectedName, approximateOdds
end

local function rollReward(_luckMultiplier: number): (string, number)
	return rollFromPool(rewardPool)
end

local function rollLuckMultiplier(): number?
	if math.random() >= LUCK_RESULT_CHANCE then
		return nil
	end
	local totalWeight = 0
	for _, drop in ipairs(LUCK_DROPS) do
		totalWeight += drop.Weight
	end
	local roll = math.random() * totalWeight
	for _, drop in ipairs(LUCK_DROPS) do
		roll -= drop.Weight
		if roll <= 0 then
			return drop.Multiplier
		end
	end
	return LUCK_DROPS[#LUCK_DROPS].Multiplier
end

local function createBrainrotStage(stageNumber: number, multiplier: number, duration: number, startedAt: number, pool: {string}, mutation: string?): (any, string, number, number)
	local resultName, resultOdds = rollFromPool(pool)
	local resultData = Animals[resultName]
	local buyPrice = if resultData and type(resultData.Price) == "number" then math.max(1, resultData.Price) else 1
	local resultIndex = math.random(1, ENTRY_COUNT)
	local entries = {}
	for index = 1, ENTRY_COUNT do
		local name, odds
		if index == resultIndex then
			name, odds = resultName, resultOdds
		else
			name, odds = rollFromPool(pool)
		end
		entries[index] = {Type = "Brainrot", Name = name, Odds = odds}
	end
	return {
		Stage = stageNumber,
		Duration = duration,
		ResultIndex = resultIndex,
		ResultType = "Brainrot",
		ResultName = resultName,
		Multiplier = multiplier,
		StartedAt = startedAt,
		Entries = entries,
		Mutation = mutation,
	}, resultName, resultOdds, buyPrice
end

local function rollMutation(levels: {[string]: number}): string?
	local eventLevel = levels.EventMutation
	if eventLevel > 0 and math.random() < MUTATION_CHANCES.EventMutation[eventLevel] then
		return SKILL_TREE.EventMutation[eventLevel].Mutation
	end
	for _, skillName in ipairs({"RainbowMutation", "DiamondMutation", "GoldMutation"}) do
		local level = levels[skillName]
		if level > 0 and math.random() < MUTATION_CHANCES[skillName][level] then
			return SKILL_TREE[skillName][level].Mutation
		end
	end
	return nil
end

local function clearExpiredOffer(player: Player, token: number)
	if spinTokens[player] ~= token then
		return
	end
	spinTokens[player] = token + 1
	setPlayerState(player, "Idle", nil)
	setSession(player, nil)
end

function RNGMachineService:Spin(player: Player): (boolean, string?)
	local rep = playerReplicators[player]
	local currentState = rep and rep:GetKey("State")
	if not rep or (currentState ~= "Idle" and currentState ~= "Offer") then
		return false, "The RNG machine is busy."
	end

	local channel = Synchronizer:Wait(player)
	if not channel then
		return false, "Your data is not ready."
	end
	local levels = getLevels(channel)
	local cost = getSpinCost(levels)
	local coins = channel:Get("Coins")
	if type(coins) ~= "number" or coins < cost then
		NotificationService.Error(player, ("You need $%s to spin."):format(tostring(cost)))
		return false, "Not enough cash."
	end
	channel:Set("Coins", coins - cost)

	local token = (spinTokens[player] or 0) + 1
	spinTokens[player] = token
	local luckMultiplier = getLuckMultiplier(levels.Luck)
	local duration = getSpinDuration(levels.Speed)
	local firstStartedAt = workspace:GetServerTimeNow()

	local function scheduleOffer(stage: any, resultName: string, resultOdds: number, mutation: string?, buyPrice: number, multiplier: number, delaySeconds: number)
		task.delay(delaySeconds, function()
			if not player.Parent or spinTokens[player] ~= token then
				return
			end
			local expiresAt = workspace:GetServerTimeNow() + OFFER_DURATION
			local offer = {
				Name = resultName,
				Multiplier = multiplier,
				Mutation = mutation,
				BuyPrice = buyPrice,
				Odds = resultOdds,
				ExpiresAt = expiresAt,
				ServerExpiresAt = expiresAt,
			}
			setPlayerState(player, "Offer", offer)
			setSession(player, {
				UserId = player.UserId,
				State = "Offer",
				Multiplier = multiplier,
				Stage = stage,
				Offer = offer,
			})
			task.delay(OFFER_DURATION, function()
				clearExpiredOffer(player, token)
			end)
		end)
	end

	setPlayerState(player, "Spinning", nil)
	local luckIcons = ReplicatedStorage:FindFirstChild("LuckIcons")
	local luckDropMultiplier = rollLuckMultiplier()
	if RNGMachineService.DebugForceTwoX then
		luckDropMultiplier = 2
	end
	RNGMachineService.DebugForceTwoX = false
	local luckName = luckDropMultiplier and (tostring(luckDropMultiplier) .. "x")
	local luckTemplate = luckDropMultiplier and luckIcons and luckIcons:FindFirstChild(tostring(luckDropMultiplier))
	local rolledLuck = luckDropMultiplier ~= nil
		and #boostedRewardPool > 0
		and luckTemplate ~= nil

	if rolledLuck then
		local resultIndex = math.random(1, ENTRY_COUNT)
		local entries = {}
		for index = 1, ENTRY_COUNT do
			if index == resultIndex then
				entries[index] = {Type = "Luck", Name = luckName, Odds = math.round(1 / LUCK_RESULT_CHANCE)}
			else
				local name, odds = rollReward(luckMultiplier)
				entries[index] = {Type = "Brainrot", Name = name, Odds = odds}
			end
		end
		local luckStage = {
			Stage = 1,
			Duration = duration,
			ResultIndex = resultIndex,
			ResultType = "Luck",
			ResultName = luckName,
			Multiplier = luckDropMultiplier,
			StartedAt = firstStartedAt,
			Entries = entries,
			Mutation = nil,
		}
		setSession(player, {
			UserId = player.UserId,
			State = "Spinning",
			SpinStartedAt = firstStartedAt,
			Multiplier = luckDropMultiplier,
			Stage = luckStage,
		})
		SpinStageRemote:FireClient(player, luckStage)

		-- Trigger the map-wide high-multiplier explosion for the top tiers.
		if luckDropMultiplier == 10 or luckDropMultiplier == 12 then
			LuckExplosionRemote:FireClient(player, luckDropMultiplier)
		end

		-- The client lands at 85% of the roll. Leave the luck multiplier visible for
		-- one full second, then begin a free second spin from the Secret-only pool.
		task.delay(duration * 0.85 + LUCK_RESULT_HOLD, function()
			if not player.Parent or spinTokens[player] ~= token then
				return
			end
			local mutation = rollMutation(levels)
			local secretStage, resultName, resultOdds, buyPrice = createBrainrotStage(
				2,
				luckDropMultiplier,
				duration,
				workspace:GetServerTimeNow(),
				boostedRewardPool,
				mutation
			)
			setSession(player, {
				UserId = player.UserId,
				State = "Spinning",
				SpinStartedAt = firstStartedAt,
				Multiplier = luckDropMultiplier,
				Stage = secretStage,
			})
			SpinStageRemote:FireClient(player, secretStage)
			scheduleOffer(secretStage, resultName, resultOdds, mutation, buyPrice, luckDropMultiplier, duration)
		end)
	else
		local mutation = rollMutation(levels)
		local stage, resultName, resultOdds, buyPrice = createBrainrotStage(
			1,
			1,
			duration,
			firstStartedAt,
			rewardPool,
			mutation
		)
		-- Keep 2x visible in every first-roll reel even when a brainrot wins.
		local twoXDisplayIndex = math.random(1, ENTRY_COUNT - 1)
		if twoXDisplayIndex >= stage.ResultIndex then
			twoXDisplayIndex += 1
		end
		stage.Entries[twoXDisplayIndex] = {
			Type = "Luck",
			Name = "2x",
			Odds = math.round(1 / LUCK_RESULT_CHANCE),
		}
		setSession(player, {
			UserId = player.UserId,
			State = "Spinning",
			SpinStartedAt = firstStartedAt,
			Multiplier = 1,
			Stage = stage,
		})
		SpinStageRemote:FireClient(player, stage)
		scheduleOffer(stage, resultName, resultOdds, mutation, buyPrice, 1, duration)
	end
	return true
end

local function connectPrompt(instance: Instance)
	if promptConnections[instance] or not instance:IsA("ProximityPrompt") then
		return
	end
	promptConnections[instance] = instance.Triggered:Connect(function(player)
		RNGMachineService:Spin(player)
	end)
	instance.Destroying:Once(function()
		local connection = promptConnections[instance]
		if connection then
			connection:Disconnect()
			promptConnections[instance] = nil
		end
	end)
end

function RNGMachineService:EnsurePlayer(player: Player)
	setupPlayer(player)
end

function RNGMachineService:QueuePurchasedDelivery(player: Player, animalName: string, mutation: string?, deliveryOrigin: Vector3): boolean
	if not AnimalService then
		AnimalService = require(ServerScriptService.Services.AnimalService)
	end
	if not PlotService then
		PlotService = require(ServerScriptService.Services.PlotService)
	end
	if not NotificationService then
		NotificationService = require(ServerScriptService.Services.NotificationService)
	end
	local channel = Synchronizer:Wait(player)
	local podiumIndex = channel and findFreePodium(channel, player)
	if not channel or not podiumIndex then
		return false
	end
	reservedPodiums[player] = reservedPodiums[player] or {}
	reservedPodiums[player][podiumIndex] = true
	PlotService.AddToQueue(player, podiumIndex)
	task.spawn(deliverAnimal, player, channel, animalName, mutation, podiumIndex, deliveryOrigin)
	return true
end

function RNGMachineService:Start()
	if started then
		return
	end
	started = true
	RNGMachineService.DebugStatus = "RequiringServices"
	NotificationService = require(ServerScriptService.Services.NotificationService)
	AnimalService = require(ServerScriptService.Services.AnimalService)
	PlotService = require(ServerScriptService.Services.PlotService)
	RNGMachineService.DebugStatus = "BuildingRewards"
	buildRewardBuckets()
	RNGMachineService.DebugStatus = "ConnectingPrompts"
	for _, prompt in ipairs(CollectionService:GetTagged("RNGMachineSpinPrompt")) do
		connectPrompt(prompt)
	end
	CollectionService:GetInstanceAddedSignal("RNGMachineSpinPrompt"):Connect(connectPrompt)

	BuyRemote.OnServerInvoke = function(player: Player)
		local rep = playerReplicators[player]
		local offer = rep and rep:GetKey("Offer")
		if not rep or rep:GetKey("State") ~= "Offer" or type(offer) ~= "table" then
			return false, "There is no reward to claim."
		end
		if workspace:GetServerTimeNow() >= (offer.ServerExpiresAt or offer.ExpiresAt or 0) then
			clearExpiredOffer(player, spinTokens[player] or 0)
			return false, "That reward expired."
		end
		local channel = Synchronizer:Wait(player)
		local podiumIndex = channel and findFreePodium(channel, player)
		if not channel or not podiumIndex then
			local noRoomMessage = "You need more room in your base to buy this brainrot"
			NotificationService.Error(player, noRoomMessage)
			return false, noRoomMessage
		end

		local buyPrice = tonumber(offer.BuyPrice) or 0
		local coins = channel:Get("Coins")
		if type(coins) ~= "number" or coins < buyPrice then
			NotificationService.Error(player, ("You need $%s to buy this brainrot."):format(tostring(buyPrice)))
			return false, "Not enough cash."
		end

		local animalData = Animals[offer.Name]
		local purchasedName = if animalData and type(animalData.DisplayName) == "string" then animalData.DisplayName else offer.Name
		reservedPodiums[player] = reservedPodiums[player] or {}
		reservedPodiums[player][podiumIndex] = true
		PlotService.AddToQueue(player, podiumIndex)
		spinTokens[player] = (spinTokens[player] or 0) + 1
		channel:Set("Coins", coins - buyPrice)
		NotificationService.Success(player, ("%s purchased."):format(purchasedName))
		setPlayerState(player, "Idle", nil)
		setSession(player, nil)
		task.spawn(deliverAnimal, player, channel, offer.Name, offer.Mutation, podiumIndex)
		return true
	end

	BuySkillRemote.OnServerInvoke = function(player: Player, skillName: string)
		local nodes = SKILL_TREE[skillName]
		if type(skillName) ~= "string" or not nodes then
			return false, "Invalid upgrade."
		end
		local channel = Synchronizer:Wait(player)
		if not channel then
			return false, "Your data is not ready."
		end
		local levels = getLevels(channel)
		local nextLevel = levels[skillName] + 1
		local node = nodes[nextLevel]
		if not node then
			return false, "That upgrade is already maxed."
		end
		local rebirths = channel:Get("Rebirth")
		if type(rebirths) ~= "number" or rebirths < node.RequiredRebirths then
			return false, ("Requires %d rebirths."):format(node.RequiredRebirths)
		end
		local coins = channel:Get("Coins")
		if type(coins) ~= "number" or coins < node.Cost then
			return false, "Not enough cash."
		end

		channel:Set("Coins", coins - node.Cost)
		local saved = channel:Get("RNGMachine")
		if type(saved) ~= "table" then
			saved = {}
		else
			saved = table.clone(saved)
		end
		saved[skillName .. "Level"] = nextLevel
		channel:Set("RNGMachine", saved)
		NotificationService.Success(player, ("%s upgraded to level %d!"):format(skillName, nextLevel))
		return true
	end

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(setupPlayer, player)
	end
	Players.PlayerAdded:Connect(setupPlayer)
	task.delay(1, function()
		for _, player in ipairs(Players:GetPlayers()) do
			setupPlayer(player)
		end
	end)
	RNGMachineService.DebugStatus = "Ready"
	Players.PlayerRemoving:Connect(function(player)
		spinTokens[player] = (spinTokens[player] or 0) + 1
		PlotService.RemoveFromQueue(player)
		reservedPodiums[player] = nil
		setSession(player, nil)
		local rep = playerReplicators[player]
		if rep then
			rep:RemoveSubscriber(player)
			rep:Destroy()
			playerReplicators[player] = nil
		end
		activityReplicator:RemoveSubscriber(player)
	end)
end

return RNGMachineService
