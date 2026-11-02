local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService       = game:GetService("HttpService")

local EggCityEvent = {}


local isActive       = false
local tasks          = { wanderLoop = nil, attackLoop = nil }
local spawnedEntities = {}
local lockedTargets  = {}


local Net   = require(ReplicatedStorage.Packages.Net)
local Burst = Net:RemoteEvent("EggCity/EggBurst")
local Trove = require(ReplicatedStorage.Packages.Trove)
local serverTrove = Trove.new()

local TAG_NAME     = "EggCityEgg"

local WANDER_FOLDER = workspace:FindFirstChild("Events")
	and workspace.Events:FindFirstChild("Wander")

local TOTAL_EGGS  = math.random(6, 10)
local EGG_SPEED   = 16
local EGG_SCALE   = 1

local VARIANT_DATA = {
	{ variant = 1, trait = "Orange Egg", weight = 50 },
	{ variant = 2, trait = "Green Egg",  weight = 30 },
	{ variant = 3, trait = "Blue Egg",   weight = 15 },
	{ variant = 4, trait = "Pink Egg",   weight = 5  },
}

local TOTAL_VARIANT_WEIGHT = 0
local VARIANT_TRAITS       = {}
local EGG_TRAIT_SET        = {}

for _, entry in ipairs(VARIANT_DATA) do
	TOTAL_VARIANT_WEIGHT          += entry.weight
	VARIANT_TRAITS[entry.variant]  = entry.trait
	EGG_TRAIT_SET[entry.trait]     = true
end

local function rollVariant()
	local roll       = math.random(1, TOTAL_VARIANT_WEIGHT)
	local cumulative = 0
	for _, entry in ipairs(VARIANT_DATA) do
		cumulative += entry.weight
		if roll <= cumulative then
			return entry.variant
		end
	end
	return 1
end


local function stickToGround(position)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = {
		workspace:FindFirstChild("Map") or workspace,
		workspace.Terrain,
	}
	local result = workspace:Raycast(
		position + Vector3.new(0, 10, 0),
		Vector3.new(0, -20, 0),
		params
	)
	return result and result.Position + Vector3.new(0, 1, 0) or position
end

local function getRandomWanderPart()
	if not WANDER_FOLDER then return nil end
	local parts = WANDER_FOLDER:GetChildren()
	return #parts > 0 and parts[math.random(1, #parts)] or nil
end

local function getTraits(animal)
	local json    = animal:GetAttribute("Traits")
	local list    = {}
	local set     = {}
	if json then
		local ok, decoded = pcall(HttpService.JSONDecode, HttpService, json)
		if ok and type(decoded) == "table" then
			list = decoded
			for _, t in ipairs(decoded) do
				set[t] = true
			end
		end
	end
	return list, set
end

local function animalHasEggTrait(animal)
	local _, set = getTraits(animal)
	for trait in pairs(EGG_TRAIT_SET) do
		if set[trait] then return true end
	end
	return false
end

local function giveTrait(animal, traitName)
	local list, set = getTraits(animal)
	if set[traitName] then return end
	table.insert(list, traitName)
	animal:SetAttribute("Traits", HttpService:JSONEncode(list))
end


local function createEgg(position, variant)
	local model = Instance.new("Model")
	model.Name  = "EggCityEgg"

	model:SetAttribute("Variant", variant)
	model:SetAttribute("Scale",   EGG_SCALE)
	model:SetAttribute("Moving",  false)

	local anchor = Instance.new("Part")
	anchor.Name        = "AnchorPart"
	anchor.Size        = Vector3.new(1, 1, 1)
	anchor.Transparency = 1
	anchor.CanCollide  = false
	anchor.Massless    = true
	anchor.CanQuery = false
	anchor.CanTouch = false
	anchor.Anchored    = true
	anchor.CFrame      = CFrame.new(position)
	anchor.Parent      = model

	model.PrimaryPart = anchor

	CollectionService:AddTag(anchor, TAG_NAME)

	model.Parent = workspace
	return model
end


local function wander(entityData)
	local model = entityData.Model
	if not model or not model.Parent or entityData.IsBusy then return end

	local homePart = entityData.Home
	local size     = homePart.Size
	local offset   = Vector3.new(
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
	local duration  = distance / EGG_SPEED

	entityData.wanderGen = (entityData.wanderGen or 0) + 1
	local myGen = entityData.wanderGen

	model:SetAttribute("Moving", true)

	task.spawn(function()
		local elapsed = 0
		while elapsed < duration and not entityData.IsBusy and isActive and model.Parent do
			local dt = task.wait()
			elapsed += dt
			local alpha = math.clamp(elapsed / duration, 0, 1)
			local pos   = stickToGround(startPos:Lerp(targetPos, alpha))
			model:PivotTo(CFrame.new(pos, pos + direction))
		end

		if model and model.Parent
			and entityData.wanderGen == myGen
			and not entityData.IsBusy
		then
			model:SetAttribute("Moving", false)
		end
	end)
end


local function chaseAndCrack(entityData, targetAnimal)
	local model = entityData.Model
	if not model or not model.Parent or entityData.IsBusy then return end

	if lockedTargets[targetAnimal] then return end
	lockedTargets[targetAnimal] = true

	entityData.IsBusy    = true
	entityData.wanderGen = (entityData.wanderGen or 0) + 1

	model:SetAttribute("Moving", false)

	task.spawn(function()
		local chaseTimeout = 12
		local chaseStart   = os.clock()
		local reached      = false

		model:SetAttribute("Moving", true)

		while isActive and model.Parent and targetAnimal and targetAnimal.Parent and targetAnimal.PrimaryPart do
			if os.clock() - chaseStart > chaseTimeout then break end

			local myPos  = model:GetPivot().Position
			local tgtPos = targetAnimal.PrimaryPart.Position
			local dist   = (tgtPos - myPos).Magnitude

			if dist < 8 then
				reached = true
				break
			end

			local dt     = task.wait()
			local dir    = (tgtPos - myPos).Unit
			local flatDir = Vector3.new(dir.X, 0, dir.Z).Unit
			local newPos = stickToGround(myPos + dir * math.min(EGG_SPEED * dt, dist))
			model:PivotTo(CFrame.new(newPos, newPos + flatDir))
		end

		model:SetAttribute("Moving", false)

		if not reached or not (targetAnimal and targetAnimal.Parent) then
			lockedTargets[targetAnimal] = nil
			entityData.IsBusy           = false
			task.wait(1)
			if model and model.Parent then wander(entityData) end
			return
		end

		local windUpDuration = 0.6
		local elapsed        = 0
		local lastTime       = os.clock()

		while elapsed < windUpDuration
			and targetAnimal and targetAnimal.Parent and targetAnimal.PrimaryPart
		do
			local now = os.clock()
			local dt  = now - lastTime
			lastTime  = now
			elapsed  += dt

			local myPos  = model:GetPivot().Position
			local tgtPos = targetAnimal.PrimaryPart.Position
			local diff   = tgtPos - myPos

			if diff.Magnitude > 0.5 then
				local dir     = diff.Unit
				local flatDir = Vector3.new(dir.X, 0, dir.Z).Unit
				local newPos  = stickToGround(myPos + dir * math.min(EGG_SPEED * dt, diff.Magnitude))
				model:PivotTo(CFrame.new(newPos, newPos + flatDir))
			end

			task.wait()
		end

		if targetAnimal and targetAnimal.Parent then
			local traitName = VARIANT_TRAITS[entityData.Variant] or "Orange Egg"
			giveTrait(targetAnimal, traitName)
			Burst:FireAllClients(targetAnimal.Name)
		end

		lockedTargets[targetAnimal] = nil
		entityData.IsBusy           = false

		local idx = table.find(spawnedEntities, entityData)
		if idx then table.remove(spawnedEntities, idx) end
		if model and model.Parent then model:Destroy() end

		task.wait(1.5)
		if isActive then
			local homePart = getRandomWanderPart()
			if homePart then
				local s       = homePart.Size
				local off     = Vector3.new(math.random(-s.X/2, s.X/2), 0, math.random(-s.Z/2, s.Z/2))
				local pos     = stickToGround(homePart.Position + off)
				local variant = rollVariant()
				local newModel = createEgg(pos, variant)
				table.insert(spawnedEntities, {
					Model     = newModel,
					Home      = homePart,
					IsBusy    = false,
					wanderGen = 0,
					Variant   = variant,
				})
			end
		end
	end)
end

function EggCityEvent.OnStart()
	if isActive then return end
	isActive = true
	ReplicatedStorage:SetAttribute("EggCityEvent", true)

	spawnedEntities = {}
	lockedTargets   = {}

	local mapTemplate = script:FindFirstChild("MapServer")
	if mapTemplate then
		serverTrove:Clone(mapTemplate).Parent = workspace
	else
		warn("EggCityEvent: MapServer template not found in script.")
	end

	for i = 1, TOTAL_EGGS do
		local homePart = getRandomWanderPart()
		if homePart then
			local size    = homePart.Size
			local offset  = Vector3.new(math.random(-size.X/2, size.X/2), 0, math.random(-size.Z/2, size.Z/2))
			local pos     = stickToGround(homePart.Position + offset)
			local variant = rollVariant() 
			local model   = createEgg(pos, variant)
			table.insert(spawnedEntities, {
				Model     = model,
				Home      = homePart,
				IsBusy    = false,
				wanderGen = 0,
				Variant   = variant,
			})
		end
	end

	tasks.wanderLoop = task.spawn(function()
		while isActive do
			for _, data in ipairs(spawnedEntities) do
				if
					data.Model and data.Model.Parent
					and not data.IsBusy
					and not data.Model:GetAttribute("Moving")
					and math.random() > 0.35
				then
					wander(data)
				end
			end
			task.wait(2.5)
		end
	end)

	tasks.attackLoop = task.spawn(function()
		while isActive do
			task.wait(math.random(6, 10))
			if not isActive or #spawnedEntities == 0 then break end

			local candidates = {}
			for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
				if animal.PrimaryPart
					and not lockedTargets[animal]
					and not animalHasEggTrait(animal)
				then
					table.insert(candidates, animal)
				end
			end
			if #candidates == 0 then continue end

			local freeEggs = {}
			for _, data in ipairs(spawnedEntities) do
				if not data.IsBusy and data.Model and data.Model.Parent then
					table.insert(freeEggs, data)
				end
			end
			if #freeEggs == 0 then continue end

			local chosenAnimal = candidates[math.random(1, #candidates)]
			local chosenEgg    = freeEggs[math.random(1, #freeEggs)]
			chaseAndCrack(chosenEgg, chosenAnimal)
		end
	end)
end

function EggCityEvent.OnStop()
	isActive = false
	ReplicatedStorage:SetAttribute("EggCityEvent", nil)

	for _, t in pairs(tasks) do
		if t then task.cancel(t) end
	end
	tasks = { wanderLoop = nil, attackLoop = nil }

	for _, data in ipairs(spawnedEntities) do
		if data.Model then data.Model:Destroy() end
	end
	spawnedEntities = {}
	lockedTargets   = {}

	serverTrove:Destroy()
end

return EggCityEvent