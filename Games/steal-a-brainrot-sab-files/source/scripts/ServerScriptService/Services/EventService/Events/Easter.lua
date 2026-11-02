local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Trove = require(ReplicatedStorage.Packages.Trove)

local EasterEvent = {}

local isActive = false
local mainTrove = nil
local spawnedEntities = {}

local Net = require(ReplicatedStorage.Packages.Net)
local Burst          = Net:RemoteEvent("EventService/Easter/Burst")
local SpawnBunnyCoin = Net:RemoteEvent("EventService/EggrotHunt/SpawnBunnyCoin")
local ClaimBunnyCoin = Net:RemoteEvent("EventService/EggrotHunt/ClaimBunnyCoin")
local DestroyBunnyCoin = Net:RemoteEvent("EventService/EggrotHunt/DestroyBunnyCoin")

local BunnyCoinsService = require(game.ServerScriptService.Services.BunnyCoinsService)

local TAG_NAME = "EasterEventBunny"
local TRAIT_NAME = "Bunny Ears"
local WANDER_FOLDER = workspace:FindFirstChild("Events") and workspace.Events:FindFirstChild("Wander")
local TOTAL_BUNNIES = math.random(6, 10)
local HOP_SPEED = 18
local BUNNY_SCALE = 1

local COIN_REWARD_BASE  = 1
local COIN_REWARD_RANGE = 3
local COIN_LIFETIME     = 30
local COIN_FLIGHT_TIME  = 1.2
local COIN_WAVE_MIN     = 3
local COIN_WAVE_MAX     = 6
local COIN_LOOP_MIN     = 5
local COIN_LOOP_MAX     = 9
local COIN_INITIAL_DELAY = 5

local activeCoins = {}
local coinCounter = 0


local function stickToGround(position)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = {
		workspace:FindFirstChild("Map") or workspace,
		workspace.Terrain,
	}
	local result = workspace:Raycast(position + Vector3.new(0, 10, 0), Vector3.new(0, -20, 0), params)
	return result and result.Position + Vector3.new(0, 1, 0) or position
end

local function getRandomWanderPart()
	if not WANDER_FOLDER then return nil end
	local parts = WANDER_FOLDER:GetChildren()
	return #parts > 0 and parts[math.random(1, #parts)] or nil
end

local function animalHasTrait(animal)
	local json = animal:GetAttribute("Traits")
	if not json then return false end
	local ok, decoded = pcall(HttpService.JSONDecode, HttpService, json)
	if not ok or type(decoded) ~= "table" then return false end
	for _, t in ipairs(decoded) do
		if t == TRAIT_NAME then return true end
	end
	return false
end

local function giveTrait(animal)
	local json = animal:GetAttribute("Traits")
	local traits = {}
	if json then
		local ok, decoded = pcall(HttpService.JSONDecode, HttpService, json)
		if ok and type(decoded) == "table" then
			traits = decoded
		end
	end
	for _, t in ipairs(traits) do
		if t == TRAIT_NAME then return end
	end
	table.insert(traits, TRAIT_NAME)
	animal:SetAttribute("Traits", HttpService:JSONEncode(traits))
end


local function newCoinId()
	coinCounter += 1
	return ("bunnycoin_%d_%d"):format(os.time(), coinCounter)
end

local function getCoinSpawnData()
	local originPos = Vector3.new(0, 5, 0)
	local wanderParts = {}

	if WANDER_FOLDER then
		for _, child in ipairs(WANDER_FOLDER:GetDescendants()) do
			if child:IsA("BasePart") then
				table.insert(wanderParts, child)
			end
		end
		for _, child in ipairs(WANDER_FOLDER:GetChildren()) do
			if child:IsA("BasePart") then
				local already = false
				for _, p in ipairs(wanderParts) do
					if p == child then already = true; break end
				end
				if not already then
					table.insert(wanderParts, child)
				end
			end
		end
	end

	local landPos

	if #wanderParts > 0 then
		local part = wanderParts[math.random(1, #wanderParts)]
		local cf   = part.CFrame
		local size = part.Size
		local randX = (math.random() - 0.5) * size.X
		local randZ = (math.random() - 0.5) * size.Z
		local topFace = cf:PointToWorldSpace(Vector3.new(randX, size.Y / 2, randZ))

		local ray = workspace:Raycast(
			topFace + Vector3.new(0, 10, 0),
			Vector3.new(0, -30, 0),
			RaycastParams.new()
		)
		landPos  = ray and ray.Position or topFace
		originPos = part.Position + Vector3.new(0, 4, 0)
	else
		warn("EasterEvent getCoinSpawnData: workspace.Events.Wander has no BaseParts — falling back to radius spawn.")
		local angle   = math.random() * math.pi * 2
		local radius  = math.random(15, 40)
		local scatter = Vector3.new(
			originPos.X + math.cos(angle) * radius,
			originPos.Y + 20,
			originPos.Z + math.sin(angle) * radius
		)
		local ray = workspace:Raycast(scatter, Vector3.new(0, -40, 0), RaycastParams.new())
		landPos   = ray and ray.Position or (scatter - Vector3.new(0, 20, 0))
	end

	return landPos, originPos
end

local function destroyCoin(coinId)
	local coin = activeCoins[coinId]
	if coin then
		if coin.trove then
			coin.trove:Destroy()
		end
		activeCoins[coinId] = nil
	end
	DestroyBunnyCoin:FireAllClients(coinId)
end

local function spawnCoinWave(count)
	for _ = 1, count do
		local coinId           = newCoinId()
		local landPos, origin  = getCoinSpawnData()
		local spawnTime        = workspace:GetServerTimeNow()

		local coinTrove = Trove.new()

		activeCoins[coinId] = {
			owner     = nil,
			position  = landPos,
			spawnTime = spawnTime,
			trove     = coinTrove,
		}

		SpawnBunnyCoin:FireAllClients(coinId, origin, landPos, spawnTime, COIN_FLIGHT_TIME)

		coinTrove:Add(task.delay(COIN_LIFETIME, function()
			if activeCoins[coinId] then
				destroyCoin(coinId)
			end
		end))
	end
end


local function onClaimBunnyCoin(player, coinId)
	if not isActive then return end

	local coin = activeCoins[coinId]
	if not coin or coin.owner then return end

	coin.owner = player
	local reward = COIN_REWARD_BASE + math.random(0, COIN_REWARD_RANGE)

	task.delay(0.4, function()
		BunnyCoinsService:Add(player, reward)
	end)

	ClaimBunnyCoin:FireAllClients(coinId, player, reward)
	destroyCoin(coinId)
end


local function createBunny(position)
	local model = Instance.new("Model")
	model.Name = "EasterBunny"
	model:SetAttribute("Scale", BUNNY_SCALE)
	model:SetAttribute("Moving", false)
	model:SetAttribute("Jumping", false)

	local anchor = Instance.new("Part")
	anchor.Name = "AnchorPart"
	anchor.Size = Vector3.new(1, 1, 1)
	anchor.Transparency = 1
	anchor.CanCollide = false
	anchor.Anchored = true
	anchor.CFrame = CFrame.new(position)
	anchor.Parent = model

	model.PrimaryPart = anchor
	CollectionService:AddTag(anchor, TAG_NAME)
	model.Parent = workspace
	return model
end


local function wander(entityData)
	local model = entityData.Model
	if not model or not model.Parent or entityData.IsBusy then return end

	local homePart = entityData.Home
	local size = homePart.Size
	local offset = Vector3.new(
		math.random(-size.X / 2, size.X / 2),
		0,
		math.random(-size.Z / 2, size.Z / 2)
	)

	local targetPos = stickToGround(homePart.Position + offset)
	local startPos  = model:GetPivot().Position
	local diff      = targetPos - startPos
	local distance  = diff.Magnitude

	if distance < 1 then return end

	local direction = diff.Unit
	local duration  = distance / HOP_SPEED

	entityData.wanderGen = (entityData.wanderGen or 0) + 1
	local myGen = entityData.wanderGen

	model:SetAttribute("Moving", true)

	entityData.trove:Add(task.spawn(function()
		local elapsed = 0
		while elapsed < duration and not entityData.IsBusy and isActive and model.Parent do
			local dt = task.wait()
			elapsed += dt
			local alpha = math.clamp(elapsed / duration, 0, 1)
			local pos = stickToGround(startPos:Lerp(targetPos, alpha))
			model:PivotTo(CFrame.new(pos, pos + direction))
		end

		if model and model.Parent
			and entityData.wanderGen == myGen
			and not entityData.IsBusy
		then
			model:SetAttribute("Moving", false)
		end
	end))
end


local function jumpAndGiveTrait(entityData, targetAnimal)
	local model = entityData.Model
	if not model or not model.Parent or entityData.IsBusy then return end

	entityData.IsBusy = true
	entityData.wanderGen = (entityData.wanderGen or 0) + 1
	model:SetAttribute("Moving", false)

	entityData.trove:Add(task.spawn(function()
		local chaseTimeout = 12
		local chaseStart   = os.clock()
		local reached      = false

		model:SetAttribute("Moving", true)

		while isActive and model.Parent and targetAnimal and targetAnimal.Parent and targetAnimal.PrimaryPart do
			if os.clock() - chaseStart > chaseTimeout then break end

			local myPos  = model:GetPivot().Position
			local tgtPos = targetAnimal.PrimaryPart.Position
			local dist   = (tgtPos - myPos).Magnitude

			if dist < 10 then
				reached = true
				break
			end

			local dt     = task.wait()
			local dir    = (tgtPos - myPos).Unit
			local newPos = stickToGround(myPos + dir * math.min(HOP_SPEED * dt, dist))
			model:PivotTo(CFrame.new(newPos, newPos + dir))
		end

		model:SetAttribute("Moving", false)

		if not reached or not (targetAnimal and targetAnimal.Parent) then
			entityData.IsBusy = false
			return
		end

		model:SetAttribute("JumpTarget", targetAnimal.Name)
		model:SetAttribute("Jumping", true)
		task.wait(1.4)

		giveTrait(targetAnimal)
		Burst:FireAllClients(targetAnimal.Name)

		if model and model.Parent then
			model:SetAttribute("Jumping", false)
			model:SetAttribute("JumpTarget", nil)
		end

		entityData.IsBusy = false
		task.wait(1)

		if model and model.Parent then
			local idx = table.find(spawnedEntities, entityData)
			if idx then table.remove(spawnedEntities, idx) end

			entityData.trove:Destroy()

			task.wait(2)
			if isActive then
				local homePart = getRandomWanderPart()
				if homePart then
					local s      = homePart.Size
					local off    = Vector3.new(math.random(-s.X/2, s.X/2), 0, math.random(-s.Z/2, s.Z/2))
					local pos    = stickToGround(homePart.Position + off)
					local newModel = createBunny(pos)

					local newTrove = Trove.new()
					newTrove:Add(newModel)

					table.insert(spawnedEntities, { 
						Model = newModel, 
						Home = homePart, 
						IsBusy = false, 
						wanderGen = 0,
						trove = newTrove
					})
				end
			end
		end
	end))
end


function EasterEvent.OnStart()
	if isActive then return end
	isActive = true
	mainTrove = Trove.new()

	ReplicatedStorage:SetAttribute("EasterEvent", true)

	local easterModel = workspace:FindFirstChild("Events")
		and workspace.Events:FindFirstChild("Easter")
		and workspace.Events.Easter:FindFirstChild("Model")
	if easterModel then
		easterModel:PivotTo(CFrame.new(-381.109, -9.5, -17.394))
	end

	spawnedEntities = {}
	activeCoins     = {}
	coinCounter     = 0

	local Animals = require(ReplicatedStorage.Datas.Animals)
	local AnimalService = require(game.ServerScriptService.Services.AnimalService)
	local SAHUR_SPAWN_TABLE = {
		{name = "Bunny Bunny Bunny Sahur", weight = 70},
		{name = "Noo my Eggs",            weight = 25},
		{name = "Buntteo",                weight = 5},
	}

	local totalWeight = 0
	for _, entry in ipairs(SAHUR_SPAWN_TABLE) do
		totalWeight += entry.weight
	end

	local roll = math.random(1, totalWeight)
	local currentSum = 0
	local selectedName = nil

	for _, entry in ipairs(SAHUR_SPAWN_TABLE) do
		currentSum += entry.weight
		if roll <= currentSum then
			selectedName = entry.name
			break
		end
	end

	if selectedName then
		local targetData = Animals[selectedName]
		if targetData then
			local newAnimal = AnimalService.spawnAnimalCustom(targetData, nil, {}, nil, nil, nil)
			if newAnimal then
				table.insert(spawnedEntities, newAnimal)
			end
		else
			warn("EasterEvent Error: " .. selectedName .. " not found in Animals data.")
		end
	end

	for _ = 1, TOTAL_BUNNIES do
		local homePart = getRandomWanderPart()
		if homePart then
			local size   = homePart.Size
			local offset = Vector3.new(math.random(-size.X/2, size.X/2), 0, math.random(-size.Z/2, size.Z/2))
			local pos    = stickToGround(homePart.Position + offset)
			local model  = createBunny(pos)

			local entityTrove = Trove.new()
			entityTrove:Add(model)

			table.insert(spawnedEntities, { 
				Model = model, 
				Home = homePart, 
				IsBusy = false, 
				wanderGen = 0,
				trove = entityTrove
			})
		end
	end

	mainTrove:Connect(ClaimBunnyCoin.OnServerEvent, onClaimBunnyCoin)

	mainTrove:Add(task.spawn(function()
		while isActive do
			for _, data in ipairs(spawnedEntities) do
				if data.Model and data.Model.Parent
					and not data.IsBusy
					and not data.Model:GetAttribute("Moving")
					and math.random() > 0.35
				then
					wander(data)
				end
			end
			task.wait(2.5)
		end
	end))

	mainTrove:Add(task.spawn(function()
		while isActive do
			task.wait(math.random(6, 10))
			if not isActive or #spawnedEntities == 0 then break end

			local candidates = {}
			for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
				if animal.PrimaryPart and not animalHasTrait(animal) then
					table.insert(candidates, animal)
				end
			end
			if #candidates == 0 then continue end

			local free = {}
			for _, data in ipairs(spawnedEntities) do
				if not data.IsBusy and data.Model and data.Model.Parent then
					table.insert(free, data)
				end
			end
			if #free == 0 then continue end

			jumpAndGiveTrait(free[math.random(1, #free)], candidates[math.random(1, #candidates)])
		end
	end))

	mainTrove:Add(task.spawn(function()
		task.wait(COIN_INITIAL_DELAY)
		while isActive do
			spawnCoinWave(math.random(COIN_WAVE_MIN, COIN_WAVE_MAX))
			task.wait(math.random(COIN_LOOP_MIN * 100, COIN_LOOP_MAX * 100) / 100)
		end
	end))
end

function EasterEvent.OnStop()
	isActive = false
	ReplicatedStorage:SetAttribute("EasterEvent", false)

	local easterModel = workspace:FindFirstChild("Events")
		and workspace.Events:FindFirstChild("Easter")
		and workspace.Events.Easter:FindFirstChild("Model")
	if easterModel then
		easterModel:PivotTo(CFrame.new(0, -500, 0))
	end

	for coinId in pairs(activeCoins) do
		destroyCoin(coinId)
	end
	activeCoins = {}

	for _, data in ipairs(spawnedEntities) do
		if data.trove then
			data.trove:Destroy()
		end
	end
	spawnedEntities = {}

	if mainTrove then
		mainTrove:Destroy()
		mainTrove = nil
	end
end

return EasterEvent