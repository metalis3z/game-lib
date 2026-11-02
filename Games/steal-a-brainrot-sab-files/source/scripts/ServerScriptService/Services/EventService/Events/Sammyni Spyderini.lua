
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService   = game:GetService("CollectionService")

local AnimalService  = require(ServerScriptService.Services.AnimalService)
local Net            = require(ReplicatedStorage.Packages.Net)
local Trove          = require(ReplicatedStorage.Packages.Trove)
local NpcPathfinding = require(ServerScriptService.Components.NpcPathfinding)

local Burst = Net:RemoteEvent("EventService/Sammyni Spyderini/Burst")

local SammyniSpyderini = {}

local TAG_NAME      = "SammyniSpyderini"
local WALK_SPEED    = 20
local TOTAL_SPIDERS = 10

local MAX_SIMULTANEOUS_ATTACKS = 2
local RECENT_TARGET_COOLDOWN   = 30
local MIN_SPAWN_DISTANCE       = 10
local MAX_SPAWN_DISTANCE       = 30
local ATTACK_DISTANCE          = 6
local CHASE_MAX_TIME           = 20
local WANDER_MAX_TIME          = 15
local ATTACK_COOLDOWN_MIN      = 12
local ATTACK_COOLDOWN_MAX      = 15
local ACTIVATION_DELAY         = 7

local GROUND_Y_OFFSET = 0.9

local EMERGENCE_DELAY = 0.2
local EMERGENCE_HOLD  = 1.0
local HOLE_EXIT_WAIT  = 2.0

local MIN_IDLE_THRESHOLD = 0.5
local MAX_IDLE_THRESHOLD = 3.0
local MIN_WANDERS        = 3
local MAX_WANDERS        = 5

local WANDER_FOLDER = workspace:FindFirstChild("Events")
	and workspace.Events:FindFirstChild("Wander")

local isActive          = false
local eventTrove        = nil
local spawnedSpiders    = {}
local recentlyTargeted  = {}
local activeAttackCount = 0

local spawnAndEmergeSpider
local retireSpider
local doWander
local doAttack


local function randomPointInPart(part)
	local size = part.Size
	return part.Position + Vector3.new(
		(math.random() - 0.5) * size.X,
		0,
		(math.random() - 0.5) * size.Z
	)
end

local function getWanderParts()
	if not WANDER_FOLDER then return {} end
	local parts = {}
	for _, p in ipairs(WANDER_FOLDER:GetChildren()) do
		if p:IsA("BasePart") then
			table.insert(parts, p)
		end
	end
	return parts
end

local function getRandomWanderPart()
	local parts = getWanderParts()
	if #parts == 0 then return nil end
	return parts[math.random(1, #parts)]
end

local function getRandomPositionNearTarget(targetAnimal)
	if not targetAnimal or not targetAnimal.PrimaryPart then return nil end

	local wanderParts = getWanderParts()
	if #wanderParts == 0 then return nil end

	local targetPos = targetAnimal.PrimaryPart.Position
	for _ = 1, 20 do
		local wp = wanderParts[math.random(1, #wanderParts)]
		local pos = NpcPathfinding.stickToGround(randomPointInPart(wp), GROUND_Y_OFFSET)
		local d = (pos - targetPos).Magnitude
		if d >= MIN_SPAWN_DISTANCE and d <= MAX_SPAWN_DISTANCE then
			return pos
		end
	end

	local angle = math.random() * math.pi * 2
	local d     = math.random(MIN_SPAWN_DISTANCE, MAX_SPAWN_DISTANCE)
	local fallback = targetPos + Vector3.new(math.cos(angle) * d, 0, math.sin(angle) * d)
	return NpcPathfinding.stickToGround(fallback, GROUND_Y_OFFSET)
end

local function createSpider(position)
	local model = Instance.new("Model")
	model.Name = "SammyniSpyderini"

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

	model:SetAttribute("IsRunning",       false)
	model:SetAttribute("Ground",          false)
	model:SetAttribute("InitialGround",   true)
	model:SetAttribute("AttackAnimation", false)

	CollectionService:AddTag(model, TAG_NAME)
	return model
end

local function removeFromList(spider)
	local idx = table.find(spawnedSpiders, spider)
	if idx then
		spawnedSpiders[idx] = spawnedSpiders[#spawnedSpiders]
		spawnedSpiders[#spawnedSpiders] = nil
	end
end


local function startBehavior(spider, stateName, behaviorFn)
	local model = spider.Model
	local root  = model and model.PrimaryPart
	if not root then return end

	spider.BehaviorTrove:Clean()
	root:SetAttribute("IsRunning", false)

	spider.State = stateName
	spider.BehaviorTrove:Add(task.spawn(function()
		local ok, err = pcall(behaviorFn, spider)
		if not ok then
			warn(("[Sammyni Spyderini] behavior '%s' errored: %s"):format(stateName, tostring(err)))
		end
		if spider.State == stateName then
			spider.State = "Idle"
			if model.Parent then
				model:SetAttribute("IsRunning", false)
			end
		end
	end))
end


retireSpider = function(spider)
	if spider.State == "Retiring" or spider.State == "Dead" then return end
	spider.State = "Retiring"

	spider.BehaviorTrove:Clean()

	local model = spider.Model
	if model and model.Parent then
		model:SetAttribute("IsRunning", false)
		model:SetAttribute("Ground",    true)
	end

	task.delay(HOLE_EXIT_WAIT, function()
		local wasAttack     = spider.IsAttack
		local wasWanderPart = spider.WanderPart

		removeFromList(spider)
		spider.State = "Dead"

		if eventTrove then
			eventTrove:Remove(spider.Trove)
		end

		if isActive and not wasAttack then
			local wp = (wasWanderPart and wasWanderPart.Parent) and wasWanderPart or getRandomWanderPart()
			if wp then
				spawnAndEmergeSpider(wp)
			end
		end
	end)
end


doWander = function(spider)
	local wp = spider.WanderPart
	if not wp or not wp.Parent then
		wp = getRandomWanderPart()
		spider.WanderPart = wp
	end
	if not wp then return end

	local targetPos = NpcPathfinding.stickToGround(randomPointInPart(wp), GROUND_Y_OFFSET)

	spider.Model:SetAttribute("IsRunning", true)
	NpcPathfinding.moveTo(spider.Model, targetPos, WALK_SPEED, {
		yOffset    = GROUND_Y_OFFSET,
		maxTime    = WANDER_MAX_TIME,
		shouldStop = function() return not isActive end,
	})

	spider.WanderCount = spider.WanderCount + 1
	spider.LastMoved   = os.clock()
end

local function targetGone(targetAnimal)
	if not targetAnimal or not targetAnimal.Parent or not targetAnimal.PrimaryPart then
		return true
	end
	if targetAnimal:GetAttribute("HasSpiderTrait") then
		return true
	end
	return false
end

doAttack = function(spider)
	local model        = spider.Model
	local targetAnimal = spider.Target
	if not model or not targetAnimal then return end

	model:SetAttribute("IsRunning", true)
	local reached = NpcPathfinding.chase(
		model,
		function()
			if targetGone(targetAnimal) then return nil end
			return targetAnimal.PrimaryPart.Position
		end,
		WALK_SPEED,
		ATTACK_DISTANCE,
		CHASE_MAX_TIME,
		{
			yOffset    = GROUND_Y_OFFSET,
			shouldStop = function() return not isActive end,
		}
	)

	if not reached or not isActive or targetGone(targetAnimal) then
		if isActive then retireSpider(spider) end
		return
	end

	model:SetAttribute("IsRunning", false)

	local myPos    = model.PrimaryPart.Position
	local toTarget = targetAnimal.PrimaryPart.Position - myPos
	local flat     = Vector3.new(toTarget.X, 0, toTarget.Z)
	if flat.Magnitude > 0.1 then
		model:PivotTo(CFrame.lookAt(myPos, myPos + flat.Unit))
	end
	task.wait(0.1)

	model:SetAttribute("AttackAnimation", true)
	task.wait(0.5)

	if isActive and not targetGone(targetAnimal) then
		Burst:FireAllClients(targetAnimal.Name)
		AnimalService:AddTraits(targetAnimal, {"Spider"})
		targetAnimal:SetAttribute("HasSpiderTrait", true)
	end

	task.wait(0.5)
	if model.Parent then
		model:SetAttribute("AttackAnimation", false)
	end

	task.wait(0.3)

	if isActive then
		retireSpider(spider)
	end
end


function spawnAndEmergeSpider(wanderPart)
	if not isActive or not eventTrove or not wanderPart then return nil end

	local spawnPos = NpcPathfinding.stickToGround(randomPointInPart(wanderPart), GROUND_Y_OFFSET)
	local model = createSpider(spawnPos)

	local spiderTrove = eventTrove:Extend()
	spiderTrove:Add(model)

	local spider = {
		Model         = model,
		WanderPart    = wanderPart,
		Trove         = spiderTrove,
		BehaviorTrove = spiderTrove:Extend(),
		State         = "Emerging",
		IsAttack      = false,
		WanderCount   = 0,
		MaxWanders    = math.random(MIN_WANDERS, MAX_WANDERS),
		LastMoved     = math.huge,
		IdleThreshold = MIN_IDLE_THRESHOLD + math.random() * (MAX_IDLE_THRESHOLD - MIN_IDLE_THRESHOLD),
	}

	model.Parent = workspace
	table.insert(spawnedSpiders, spider)

	spiderTrove:Add(task.spawn(function()
		task.wait(EMERGENCE_DELAY)
		if not isActive or not model.Parent then return end
		model:SetAttribute("InitialGround", false)

		task.wait(EMERGENCE_HOLD)
		if not isActive or not model.Parent then return end

		spider.State    = "Idle"
		spider.LastMoved = os.clock()
	end))

	return spider
end

local function spawnAttackSpider(targetAnimal)
	if activeAttackCount >= MAX_SIMULTANEOUS_ATTACKS then return end
	if not isActive or not eventTrove then return end
	if not targetAnimal or not targetAnimal.Parent or not targetAnimal.PrimaryPart then return end

	local spawnPos = getRandomPositionNearTarget(targetAnimal)
	if not spawnPos then
		warn("[Sammyni Spyderini] no valid spawn position near target")
		return
	end

	local model = createSpider(spawnPos)
	local spiderTrove = eventTrove:Extend()
	spiderTrove:Add(model)

	local spider = {
		Model         = model,
		WanderPart    = nil,
		Trove         = spiderTrove,
		BehaviorTrove = spiderTrove:Extend(),
		State         = "Emerging",
		IsAttack      = true,
		Target        = targetAnimal,
	}

	targetAnimal:SetAttribute("TargetedBy", model.Name)
	activeAttackCount = activeAttackCount + 1

	spiderTrove:Add(function()
		if targetAnimal and targetAnimal.Parent then
			targetAnimal:SetAttribute("TargetedBy", nil)
		end
		activeAttackCount = math.max(0, activeAttackCount - 1)
	end)

	model.Parent = workspace
	table.insert(spawnedSpiders, spider)

	spiderTrove:Add(task.spawn(function()
		task.wait(EMERGENCE_DELAY)
		if not isActive or not model.Parent then return end
		model:SetAttribute("InitialGround", false)

		task.wait(EMERGENCE_HOLD)
		if not isActive or not model.Parent then return end

		spider.State = "Idle"
		startBehavior(spider, "Attack", doAttack)
	end))

	return spider
end


function SammyniSpyderini.OnStart()
	if isActive then return end
	isActive = true
	eventTrove = Trove.new()
	ReplicatedStorage:SetAttribute("SammyniSpyderiniEvent", true)

	task.wait(ACTIVATION_DELAY)
	if not isActive then return end

	for _ = 1, TOTAL_SPIDERS do
		local wp = getRandomWanderPart()
		if wp then
			spawnAndEmergeSpider(wp)
		end
	end

	eventTrove:Add(task.spawn(function()
		while isActive do
			task.wait(0.25)
			local now = os.clock()

			for _, spider in ipairs(spawnedSpiders) do
				if spider.IsAttack then continue end
				if spider.State ~= "Idle" then continue end
				if not spider.Model or not spider.Model.Parent then continue end

				if spider.WanderCount >= spider.MaxWanders then
					retireSpider(spider)
					continue
				end

				if now - spider.LastMoved >= spider.IdleThreshold then
					spider.IdleThreshold = MIN_IDLE_THRESHOLD
						+ math.random() * (MAX_IDLE_THRESHOLD - MIN_IDLE_THRESHOLD)
					startBehavior(spider, "Wander", doWander)
				end
			end
		end
	end))

	eventTrove:Add(task.spawn(function()
		while isActive do
			task.wait(math.random(ATTACK_COOLDOWN_MIN, ATTACK_COOLDOWN_MAX))
			if not isActive then break end
			if activeAttackCount >= MAX_SIMULTANEOUS_ATTACKS then continue end

			local now = workspace:GetServerTimeNow()

			for name, last in pairs(recentlyTargeted) do
				if now - last > RECENT_TARGET_COOLDOWN then
					recentlyTargeted[name] = nil
				end
			end

			local candidates = {}
			for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
				if animal.PrimaryPart
					and not animal:GetAttribute("HasSpiderTrait")
					and animal:GetAttribute("TargetedBy") == nil
					and not recentlyTargeted[animal.Name]
				then
					table.insert(candidates, animal)
				end
			end

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				recentlyTargeted[selected.Name] = now
				spawnAttackSpider(selected)
			end
		end
	end))
end

function SammyniSpyderini.OnStop()
	if not isActive then return end
	isActive = false
	ReplicatedStorage:SetAttribute("SammyniSpyderiniEvent", false)

	if eventTrove then
		eventTrove:Destroy()
		eventTrove = nil
	end
	table.clear(spawnedSpiders)
	table.clear(recentlyTargeted)
	activeAttackCount = 0
end

return SammyniSpyderini
