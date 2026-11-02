local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)
local NpcPathfinding = require(game:GetService("ServerScriptService").Components.NpcPathfinding)

local AyMiGatito = {}

local isActive = false
local eventTrove = nil
local spawnedEntities = {}
local lockedTargets = {}
local currentSession = 0

local Burst = Net:RemoteEvent("EventService/AyMiGatito/Burst")

local WANDER_FOLDER   = workspace.Events:FindFirstChild("Ay Mi Gatito")
local TAG_NAME        = "Gatito"
local VARIANTS        = {"Angry Gatito", "Crying Gatito"}
local variantIndex    = 1

local BLOCKING_TRAIT  = ":3"

local WANDER_SPEED        = 16
local CHASE_SPEED         = 20
local CHASE_REACH_DIST    = 5
local CHASE_STICK_DIST    = 0.5
local ATTACK_DURATION     = 0.5
local POST_ATTACK_WAIT    = 1.5
local WANDER_LOOP_RATE    = 2
local ATTACK_LOOP_MIN     = 5
local ATTACK_LOOP_MAX     = 10
local GATITOS_PER_WANDER  = 3

local function stickToGround(position)
	return NpcPathfinding.stickToGround(position)
end

local function getTraits(animal)
	local traitsJson = animal:GetAttribute("Traits")
	if not traitsJson then return {}, {} end

	local ok, decoded = pcall(HttpService.JSONDecode, HttpService, traitsJson)
	if not ok or type(decoded) ~= "table" then return {}, {} end

	local traitSet = {}
	for _, t in ipairs(decoded) do
		traitSet[t] = true
	end
	return decoded, traitSet
end

local function hasBlockingTrait(animal)
	local _, traitSet = getTraits(animal)
	return traitSet[BLOCKING_TRAIT] == true
end

local function createGatito(position)
	local model = Instance.new("Model")
	model.Name = "Gatito"

	local root = Instance.new("Part")
	root.Name        = "HumanoidRootPart"
	root.Size        = Vector3.new(2, 2, 2)
	root.Transparency = 1
	root.Anchored    = true
	root.CanCollide  = false
	root.CFrame      = CFrame.new(position)
	root.Parent      = model
	model.PrimaryPart = root

	local totalOptions  = #VARIANTS + 1
	local randomVariant = VARIANTS[variantIndex]

	if randomVariant then
		model:SetAttribute("Variant", randomVariant)
	end
	model:SetAttribute("Dance",     true)
	model:SetAttribute("IsRunning", false)
	model:SetAttribute("IsChasing", false)

	CollectionService:AddTag(model, TAG_NAME)

	variantIndex = (variantIndex % totalOptions) + 1

	return model
end

local rng = Random.new()

local function wander(hunterData)
	local entity   = hunterData.Model
	local homePart = hunterData.Home

	if not entity or not entity.PrimaryPart then return end
	if entity:GetAttribute("IsChasing") or entity:GetAttribute("IsRunning") then return end

	local size = homePart.Size
	local randomOffset = Vector3.new(
		rng:NextNumber(-size.X / 2, size.X / 2),
		0,
		rng:NextNumber(-size.Z / 2, size.Z / 2)
	)

	local targetPos = stickToGround(homePart.Position + randomOffset)
	local startPos  = entity:GetPivot().Position
	local distance  = (targetPos - startPos).Magnitude

	if distance < 1 then return end

	entity:SetAttribute("IsRunning", true)

	local wanderTrove = eventTrove:Extend()

	wanderTrove:Add(task.spawn(function()
		NpcPathfinding.moveTo(entity, targetPos, WANDER_SPEED, {
			maxTime = math.max(5, distance / WANDER_SPEED + 2),
			shouldStop = function()
				return (not isActive)
					or (not entity.Parent)
					or entity:GetAttribute("IsChasing")
			end,
		})

		if entity.Parent then
			entity:SetAttribute("IsRunning", false)
		end
		wanderTrove:Clean()
	end))

end

local function followAndAttackAnimal(gatitoData, targetAnimal)
	local gatito = gatitoData.Model
	if not gatito or not gatito.Parent then return end
	if gatito:GetAttribute("IsChasing") then return end
	if lockedTargets[targetAnimal] then return end

	lockedTargets[targetAnimal] = true
	gatito:SetAttribute("IsChasing", true)
	gatito:SetAttribute("IsRunning", true)

	local chaseTrove = eventTrove:Extend()

	chaseTrove:Add(task.spawn(function()
		local reachedTarget = NpcPathfinding.chase(
			gatito,
			function()
				if targetAnimal and targetAnimal.Parent and targetAnimal.PrimaryPart then
					return targetAnimal.PrimaryPart.Position
				end
				return nil
			end,
			CHASE_SPEED,
			CHASE_REACH_DIST,
			30,
			{
				shouldStop = function()
					return (not isActive) or (not gatito.Parent)
				end,
			}
		)

		gatito:SetAttribute("IsRunning", false)

		if reachedTarget and targetAnimal and targetAnimal.Parent then
			gatito:SetAttribute("AttackAnimation", true)

			local elapsed = 0
			local attackConn
			attackConn = chaseTrove:Add(RunService.Heartbeat:Connect(function(dt2)
				elapsed += dt2

				if elapsed >= ATTACK_DURATION
					or (not isActive)
					or (not targetAnimal) or (not targetAnimal.Parent) or (not targetAnimal.PrimaryPart) then
					chaseTrove:Remove(attackConn)
					attackConn:Disconnect()
					return
				end

				local tPos  = targetAnimal.PrimaryPart.Position
				local mPos  = gatito.PrimaryPart.Position
				local d2    = tPos - mPos
				local dist2 = d2.Magnitude

				if dist2 > CHASE_STICK_DIST then
					local dir2    = d2.Unit
					local flatDir = Vector3.new(dir2.X, 0, dir2.Z)
					if flatDir.Magnitude < 1e-4 then return end
					flatDir = flatDir.Unit

					local move2   = math.min(CHASE_SPEED * dt2, dist2)
					local newPos  = stickToGround(mPos + dir2 * move2)
					gatito:PivotTo(CFrame.new(newPos, newPos + flatDir))
				end
			end))

			while elapsed < ATTACK_DURATION and isActive do
				task.wait(ATTACK_DURATION - elapsed + 0.016)
			end

			Burst:FireAllClients(targetAnimal.PrimaryPart)
			gatito:SetAttribute("AttackAnimation", false)

			if targetAnimal and targetAnimal.Parent then
				local currentTraits, currentTraitSet = getTraits(targetAnimal)
				if not currentTraitSet[BLOCKING_TRAIT] then
					table.insert(currentTraits, BLOCKING_TRAIT)
					targetAnimal:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
				end
			end
		end

		lockedTargets[targetAnimal] = nil
		task.wait(POST_ATTACK_WAIT)

		if isActive and gatito and gatito.Parent then
			gatito:SetAttribute("IsChasing", false)
			wander(gatitoData)
		end

		chaseTrove:Clean()
	end))
end

function AyMiGatito.OnStart(stats)
	if isActive then return end
	isActive       = true
	currentSession += 1
	local mySession = currentSession
	eventTrove     = Trove.new()
	ReplicatedStorage:SetAttribute("AyMiGatitoEvent", true)

	local elapsed     = workspace:GetServerTimeNow() - stats.startedAt
	local remaining   = math.max(0, 7 - elapsed)
	if remaining > 0 then task.wait(remaining) end
	if not isActive or mySession ~= currentSession then return end

	if WANDER_FOLDER then
		for _, part in ipairs(WANDER_FOLDER:GetChildren()) do
			if part.Name == "Wander" then
				local size = part.Size
				for _ = 1, GATITOS_PER_WANDER do
					local offset   = Vector3.new(
						rng:NextNumber(-size.X / 2, size.X / 2),
						0,
						rng:NextNumber(-size.Z / 2, size.Z / 2)
					)
					local hunter = createGatito(stickToGround(part.Position + offset))
					eventTrove:Add(hunter)
					hunter.Parent = workspace
					table.insert(spawnedEntities, { Model = hunter, Home = part })
				end
			end
		end
	end

	eventTrove:Add(task.spawn(function()
		while isActive do
			for _, hunterData in ipairs(spawnedEntities) do
				local model = hunterData.Model
				if model.Parent
					and not model:GetAttribute("IsChasing")
					and not model:GetAttribute("IsRunning") then
					task.delay(rng:NextNumber(0, 2), function()
						if isActive and model.Parent
							and not model:GetAttribute("IsChasing")
							and not model:GetAttribute("IsRunning") then
							wander(hunterData)
						end
					end)
				end
			end
			task.wait(WANDER_LOOP_RATE)
		end
	end))

	local cachedAnimals = CollectionService:GetTagged("Animal")
	local tagConn1 = eventTrove:Add(CollectionService:GetInstanceAddedSignal("Animal"):Connect(function(inst)
		table.insert(cachedAnimals, inst)
	end))
	local tagConn2 = eventTrove:Add(CollectionService:GetInstanceRemovedSignal("Animal"):Connect(function(inst)
		for i = #cachedAnimals, 1, -1 do
			if cachedAnimals[i] == inst then
				table.remove(cachedAnimals, i)
				break
			end
		end
	end))

	eventTrove:Add(task.spawn(function()
		while isActive do
			task.wait(rng:NextNumber(ATTACK_LOOP_MIN, ATTACK_LOOP_MAX))
			if not isActive or #spawnedEntities == 0 then break end

			local candidates = {}
			for _, animal in ipairs(cachedAnimals) do
				if animal.PrimaryPart and not lockedTargets[animal] and not hasBlockingTrait(animal) then
					table.insert(candidates, animal)
				end
			end

			if #candidates > 0 then
				local selected   = candidates[rng:NextInteger(1, #candidates)]
				local gatitoData = spawnedEntities[rng:NextInteger(1, #spawnedEntities)]

				if gatitoData.Model and gatitoData.Model.Parent then
					followAndAttackAnimal(gatitoData, selected)
				end
			end
		end
	end))
end

function AyMiGatito.OnStop()
	if not isActive then return end

	isActive = false
	ReplicatedStorage:SetAttribute("AyMiGatitoEvent", false)

	if eventTrove then
		eventTrove:Clean()
		eventTrove = nil
	end

	table.clear(spawnedEntities)
	table.clear(lockedTargets)
end

return AyMiGatito