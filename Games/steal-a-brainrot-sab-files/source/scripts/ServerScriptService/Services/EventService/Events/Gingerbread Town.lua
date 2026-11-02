
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService   = game:GetService("CollectionService")
local HttpService         = game:GetService("HttpService")

local Net            = require(ReplicatedStorage.Packages.Net)
local Trove          = require(ReplicatedStorage.Packages.Trove)
local NpcPathfinding = require(ServerScriptService.Components.NpcPathfinding)

local Burst = Net:RemoteEvent("EventService/Gingerbread Town/Burst")

local GingerbreadEvent = {}

local TAG_NAME       = "GingerbreadTownEventReindeer"
local TRAIT_NAME     = "Reindeer Pet"
local WALK_SPEED     = 22
local TOTAL_ENTITIES = 15

local GROUND_Y_OFFSET = -0.25

local STOP_DISTANCE   = 5
local CHASE_MAX_TIME  = 10
local WANDER_MAX_TIME = 15
local WANDER_CHANCE   = 0.6
local RESPAWN_DELAY   = 2

local WANDER_FOLDER = workspace:FindFirstChild("Events") and workspace.Events:FindFirstChild("Wander")

local isActive = false
local eventTrove = nil
local spawnedEntities = {}

local spawnGingerbread


local function randomPointInPart(part)
	local size = part.Size
	return part.Position + Vector3.new(
		(math.random() - 0.5) * size.X,
		0,
		(math.random() - 0.5) * size.Z
	)
end

local function getRandomWanderPart()
	if not WANDER_FOLDER then return nil end
	local parts = WANDER_FOLDER:GetChildren()
	if #parts == 0 then return nil end
	return parts[math.random(1, #parts)]
end

local function createGingerbread(position)
	local model = Instance.new("Model")
	model.Name = "GingerbreadReindeer"

	local root = Instance.new("Part")
	root.Name         = "HumanoidRootPart"
	root.Size         = Vector3.new(2, 2, 2)
	root.Transparency = 1
	root.Anchored     = true
	root.CanCollide   = false
	root.CanQuery     = false
	root.CanTouch     = false
	root.CFrame       = CFrame.new(position)
	root.Parent       = model

	model.PrimaryPart = root

	root:SetAttribute("Moving", false)
	CollectionService:AddTag(root, TAG_NAME)

	return model
end


local function getAnimalTraits(animal)
	local raw = animal:GetAttribute("Traits")
	if typeof(raw) ~= "string" then return {} end
	local ok, decoded = pcall(function()
		return HttpService:JSONDecode(raw)
	end)
	if ok and type(decoded) == "table" then
		return decoded
	end
	return {}
end

local function animalHasTrait(animal)
	return table.find(getAnimalTraits(animal), TRAIT_NAME) ~= nil
end

local function grantTrait(animal)
	local traits = getAnimalTraits(animal)
	if table.find(traits, TRAIT_NAME) then return end
	table.insert(traits, TRAIT_NAME)
	animal:SetAttribute("Traits", HttpService:JSONEncode(traits))
end


local function removeFromList(entity)
	local index = table.find(spawnedEntities, entity)
	if index then
		spawnedEntities[index] = spawnedEntities[#spawnedEntities]
		spawnedEntities[#spawnedEntities] = nil
	end
end

local function pickTargetAnimal()
	local candidates = {}
	for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
		if animal.PrimaryPart and not animalHasTrait(animal) then
			table.insert(candidates, animal)
		end
	end
	if #candidates == 0 then return nil end
	return candidates[math.random(1, #candidates)]
end

local function pickAvailableReindeer()
	local available = {}
	for _, entity in ipairs(spawnedEntities) do
		if entity.State ~= "Chase" and entity.State ~= "Dead"
			and entity.Model and entity.Model.Parent then
			table.insert(available, entity)
		end
	end
	if #available == 0 then return nil end
	return available[math.random(1, #available)]
end


local function startBehavior(entity, stateName, behavior)
	local root = entity.Model and entity.Model.PrimaryPart
	if not root then return end

	entity.BehaviorTrove:Clean()
	root:SetAttribute("Moving", false)

	entity.State = stateName
	entity.BehaviorTrove:Add(task.spawn(function()
		behavior(entity)

		if entity.State == stateName then
			entity.State = "Idle"
			if root.Parent then
				root:SetAttribute("Moving", false)
			end
		end
	end))
end

local function doWander(entity)
	local home = entity.Home
	if not home then return end

	local target = NpcPathfinding.stickToGround(randomPointInPart(home), GROUND_Y_OFFSET)

	entity.Model.PrimaryPart:SetAttribute("Moving", true)
	NpcPathfinding.moveTo(entity.Model, target, WALK_SPEED, {
		yOffset    = GROUND_Y_OFFSET,
		maxTime    = WANDER_MAX_TIME,
		shouldStop = function()
			return not isActive
		end,
	})
end

local function doChase(entity, animal)
	entity.Model.PrimaryPart:SetAttribute("Moving", true)

	local reached = NpcPathfinding.chase(
		entity.Model,
		function()
			if animal and animal.Parent and animal.PrimaryPart then
				return animal.PrimaryPart.Position
			end
			return nil
		end,
		WALK_SPEED,
		STOP_DISTANCE,
		CHASE_MAX_TIME,
		{
			yOffset    = GROUND_Y_OFFSET,
			shouldStop = function()
				return not isActive
			end,
		}
	)

	if not (reached and isActive) then
		return
	end

	grantTrait(animal)
	Burst:FireAllClients(animal.Name)

	removeFromList(entity)
	entity.State = "Dead"

	local entityTrove = entity.Trove
	task.defer(function()
		if eventTrove then
			eventTrove:Remove(entityTrove)
		end
	end)

	task.delay(RESPAWN_DELAY, function()
		if isActive then
			spawnGingerbread()
		end
	end)
end


function spawnGingerbread()
	if not isActive or not eventTrove then return end

	local home = getRandomWanderPart()
	if not home then return end

	local spawnPos = NpcPathfinding.stickToGround(randomPointInPart(home), GROUND_Y_OFFSET)
	local model = createGingerbread(spawnPos)

	local entityTrove = eventTrove:Extend()
	entityTrove:Add(model)

	local entity = {
		Model         = model,
		Home          = home,
		Trove         = entityTrove,
		BehaviorTrove = entityTrove:Extend(),
		State         = "Idle",
	}

	model.Parent = workspace
	table.insert(spawnedEntities, entity)
	return entity
end


function GingerbreadEvent.OnStart()
	if isActive then return end
	isActive = true
	ReplicatedStorage:SetAttribute("GingerbreadTownEvent", true)

	eventTrove = Trove.new()
	table.clear(spawnedEntities)

	for _ = 1, TOTAL_ENTITIES do
		spawnGingerbread()
	end

	eventTrove:Add(task.spawn(function()
		while isActive do
			for _, entity in ipairs(spawnedEntities) do
				if entity.State == "Idle" and entity.Model and entity.Model.Parent then
					if math.random() < WANDER_CHANCE then
						startBehavior(entity, "Wander", doWander)
					end
				end
			end
			task.wait(2)
		end
	end))

	eventTrove:Add(task.spawn(function()
		while isActive do
			task.wait(math.random(5, 8))
			if not isActive then break end

			local animal = pickTargetAnimal()
			if animal then
				local reindeer = pickAvailableReindeer()
				if reindeer then
					startBehavior(reindeer, "Chase", function(e)
						doChase(e, animal)
					end)
				end
			end
		end
	end))
end

function GingerbreadEvent.OnStop()
	isActive = false
	ReplicatedStorage:SetAttribute("GingerbreadTownEvent", false)

	if eventTrove then
		eventTrove:Destroy()
		eventTrove = nil
	end
	table.clear(spawnedEntities)
end

return GingerbreadEvent