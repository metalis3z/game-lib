
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local Net = require(ReplicatedStorage.Packages.Net)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local Animals = require(ReplicatedStorage.Datas.Animals)

local SpawnEvent = Net:RemoteEvent("ThanksgivingTurkeyService/Spawn")
local DespawnEvent = Net:RemoteEvent("ThanksgivingTurkeyService/Despawn")
local UpdateHealthBarEvent = Net:RemoteEvent("ThanksgivingTurkeyService/UpdateHealthBar")
local UpdateAnimationEvent = Net:RemoteEvent("ThanksgivingTurkeyService/UpdateAnimation")
local PlayAnimationEvent = Net:RemoteEvent("ThanksgivingTurkeyService/PlayAnimation")
local DamageEvent = Net:RemoteEvent("ThanksgivingTurkeyService/Damage")

local TurkeyService = {}
local activeTurkeys = {}
local turkeyModels = {}
local lastDamageTimestamps = {}

local Config = {
	IndexName = "Gobblino Uniciclino",
	DefaultHealth = 10,
	HealthFlagKey = "ThanksgivingTurkeyService/Health",
	DamageCooldown = 0.25,
	SpawnTimeout = 6,
	ModelSearchInterval = 0.12,
	AutoDespawnDefault = 300,
	WanderRadius = 50,
	WanderSpeed = 10,
	WanderInterval = 5,
	WanderReachThreshold = 2
}

local function safeGetFlag(key, default)
	if not FFlags then return default end
	local ok, result = pcall(function()
		if type(FFlags.GetInstant) == "function" then
			return FFlags:GetInstant(key, default)
		elseif type(FFlags.Get) == "function" then
			return FFlags:Get(key, default)
		else
			return default
		end
	end)
	if ok and result ~= nil then return result end
	return default
end

local function fireAllClients(event, ...)
	for _, p in pairs(Players:GetPlayers()) do
		event:FireClient(p, ...)
	end
end

local function disconnectConnection(conn)
	if conn and type(conn.Disconnect) == "function" then
		conn:Disconnect()
	end
end

local function registerModel(model, turkeyId)
	if not model or not model:IsA("Model") then return false end
	local modelName = model.Name
	if turkeyModels[modelName] then return false end
	turkeyModels[modelName] = turkeyId
	model:SetAttribute("TurkeyId", turkeyId)
	model:SetAttribute("UID", modelName)
	CollectionService:AddTag(model, "TurkeyModel")
	CollectionService:AddTag(model, "Animal")

	model.Destroying:Connect(function()
		turkeyModels[modelName] = nil
		local t = activeTurkeys[turkeyId]
		if t then
			t.model = nil
			t.modelName = nil
			for _, player in pairs(Players:GetPlayers()) do
				DespawnEvent:FireClient(player, modelName)
			end
		end
	end)
	return true
end

local function waitForAnimalModel(turkeyId, maxWait)
	local deadline = tick() + (maxWait or Config.SpawnTimeout)
	local found
	local function scanContainer(container)
		if not container then return false end
		for _, model in pairs(container:GetChildren()) do
			if model:IsA("Model") and tostring(model:GetAttribute("Index")) == Config.IndexName then
				if registerModel(model, turkeyId) then
					found = model
					return true
				end
			end
		end
		return false
	end

	if scanContainer(workspace:FindFirstChild("RenderedMovingAnimals")) then return found end
	if scanContainer(workspace) then return found end

	local conn
	conn = workspace.DescendantAdded:Connect(function(desc)
		if found then return end
		if desc and desc:IsA("Model") and tostring(desc:GetAttribute("Index")) == Config.IndexName then
			if registerModel(desc, turkeyId) then
				found = desc
			end
		end
	end)

	while tick() <= deadline and not found do
		task.wait(Config.ModelSearchInterval)
	end

	if conn then conn:Disconnect() end
	return found
end

function TurkeyService:SpawnTurkey(options)
	options = options or {}
	local turkeyId = HttpService:GenerateGUID(false)
	if activeTurkeys[turkeyId] then return false, "Turkey already exists" end
	local healthDefault = tonumber(safeGetFlag(Config.HealthFlagKey, Config.DefaultHealth)) or Config.DefaultHealth
	local health = tonumber(options.health) or healthDefault
	activeTurkeys[turkeyId] = {
		health = health,
		maxHealth = health,
		spawnTime = os.time(),
		animalId = turkeyId,
		model = nil,
		modelName = nil,
		movementConnection = nil,
		wanderConnection = nil,
		heartbeatConnection = nil,
		wanderData = nil
	}
	local animalData = Animals[Config.IndexName] or Animals[options.index or Config.IndexName]
	if not animalData then
		activeTurkeys[turkeyId] = nil
		return false, "Animal data not found"
	end
	local spawnLocation = workspace:FindFirstChild("spawn") or workspace:FindFirstChild("Spawn") or options.spawn
	if not spawnLocation then
		activeTurkeys[turkeyId] = nil
		return false, "Spawn location not found"
	end

	task.spawn(function()
		local ok, err = pcall(function()
			AnimalService.spawnAnimalCustom(animalData, nil, nil, 0, { Start = spawnLocation, End = spawnLocation }, 999999)
		end)
		if not ok then
			activeTurkeys[turkeyId] = nil
			return
		end

		task.wait(0.5)
		local model = waitForAnimalModel(turkeyId, options.spawnTimeout or Config.SpawnTimeout)
		if not model then
			activeTurkeys[turkeyId] = nil
			return
		end

		local record = activeTurkeys[turkeyId]
		if not record then
			if model.Parent then model:Destroy() end
			return
		end

		record.model = model
		record.modelName = model.Name
		record.animalId = model.Name
		lastDamageTimestamps[turkeyId] = {}

		fireAllClients(SpawnEvent, model.Name)

		task.wait(1)

		local wanderRadius = options.wanderRadius or Config.WanderRadius
		local wanderSpeed = options.wanderSpeed or Config.WanderSpeed
		self:StartWandering(turkeyId, spawnLocation.Position, wanderRadius, wanderSpeed)
	end)

	return true, turkeyId
end

function TurkeyService:DamageTurkey(modelName, damage, playerWhoHit)
	if type(modelName) ~= "string" then return false, "Invalid model name" end
	local turkeyId = turkeyModels[modelName]
	if not turkeyId then return false, "Turkey not found" end
	local turkey = activeTurkeys[turkeyId]
	if not turkey then return false, "Turkey data not found" end
	damage = math.max(1, tonumber(damage) or 0)
	local now = tick()
	local playerId = (playerWhoHit and playerWhoHit.UserId) or 0
	local perPlayer = lastDamageTimestamps[turkeyId] or {}
	local last = perPlayer[playerId] or 0
	if now - last < Config.DamageCooldown then return false, "Damage on cooldown" end
	perPlayer[playerId] = now
	lastDamageTimestamps[turkeyId] = perPlayer

	local prevHealth = turkey.health
	turkey.health = math.max(0, turkey.health - math.floor(damage))

	if turkey.health ~= prevHealth then
		fireAllClients(UpdateHealthBarEvent, modelName, turkey.health, turkey.maxHealth)
	end

	self:PlayAnimation(modelName, "Hit", false)

	if turkey.health <= 0 then
		self:DespawnTurkey(turkeyId)
	end

	return true
end

function TurkeyService:DespawnTurkey(turkeyId)
	local turkey = activeTurkeys[turkeyId]
	if not turkey then return false, "Turkey not found" end

	if turkey.wanderConnection then
		disconnectConnection(turkey.wanderConnection)
		turkey.wanderConnection = nil
	end
	if turkey.movementConnection then
		disconnectConnection(turkey.movementConnection)
		turkey.movementConnection = nil
	end
	if turkey.heartbeatConnection then
		disconnectConnection(turkey.heartbeatConnection)
		turkey.heartbeatConnection = nil
	end

	local modelName = turkey.modelName
	if turkey.model and turkey.model.Parent then
		turkey.model:Destroy()
	end

	activeTurkeys[turkeyId] = nil
	lastDamageTimestamps[turkeyId] = nil

	if modelName then
		turkeyModels[modelName] = nil
		fireAllClients(DespawnEvent, modelName)
	end

	return true
end

function TurkeyService:PlayAnimation(modelName, animationName, looped)
	if type(modelName) ~= "string" or type(animationName) ~= "string" then return false, "Invalid arguments" end
	local turkeyId = turkeyModels[modelName]
	if not turkeyId or not activeTurkeys[turkeyId] then return false, "Turkey not found" end
	local eventToUse = looped and UpdateAnimationEvent or PlayAnimationEvent
	fireAllClients(eventToUse, modelName, animationName)
	return true
end

function TurkeyService:StartCircleMovement(turkeyId, centerPos, radius, speed)
	local turkey = activeTurkeys[turkeyId]
	if not turkey or not turkey.model then return false end
	local model = turkey.model
	local primaryPart = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
	if not primaryPart then return false end

	local angle = 0
	local angularSpeed = (radius > 0) and (speed / radius) or speed
	if angularSpeed == 0 then angularSpeed = 1 end

	if turkey.movementConnection then disconnectConnection(turkey.movementConnection) end

	turkey.movementConnection = RunService.Heartbeat:Connect(function(dt)
		if not activeTurkeys[turkeyId] or not model or not model.Parent or not primaryPart or not primaryPart.Parent then
			disconnectConnection(turkey.movementConnection)
			turkey.movementConnection = nil
			return
		end

		angle = (angle + angularSpeed * dt) % (math.pi * 2)

		local x = centerPos.X + math.cos(angle) * radius
		local z = centerPos.Z + math.sin(angle) * radius
		local y = centerPos.Y

		local targetPos = Vector3.new(x, y, z)
		local currentPos = primaryPart.Position
		local step = speed * dt
		local toTarget = targetPos - currentPos
		local dist = toTarget.Magnitude

		local moveVec = (dist > step) and toTarget.Unit * step or toTarget
		local newPos = currentPos + Vector3.new(moveVec.X, 0, moveVec.Z)

		local lookAt = newPos + Vector3.new(toTarget.X, 0, toTarget.Z)
		primaryPart.CFrame = CFrame.new(newPos, lookAt)
	end)

	return true
end

function TurkeyService:StopCircleMovement(turkeyId)
	local turkey = activeTurkeys[turkeyId]
	if turkey and turkey.movementConnection then
		disconnectConnection(turkey.movementConnection)
		turkey.movementConnection = nil
	end
end

function TurkeyService:StartWandering(turkeyId, centerPos, radius, speed)
	local turkey = activeTurkeys[turkeyId]
	if not turkey or not turkey.model then return false end
	local model = turkey.model
	local primaryPart = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
	if not primaryPart then return false end

	if turkey.wanderConnection then
		disconnectConnection(turkey.wanderConnection)
		turkey.wanderConnection = nil
	end
	if turkey.heartbeatConnection then
		disconnectConnection(turkey.heartbeatConnection)
		turkey.heartbeatConnection = nil
	end

	turkey.wanderData = {
		centerPos = centerPos,
		radius = radius,
		speed = speed,
		target = nil,
		reached = true
	}

	local function pickTarget()
		local angle = math.random() * math.pi * 2
		local dist = math.random() * radius
		local x = centerPos.X + math.cos(angle) * dist
		local z = centerPos.Z + math.sin(angle) * dist
		return Vector3.new(x, centerPos.Y, z)
	end

	local function goTo(target)
		turkey.wanderData.target = target
		turkey.wanderData.reached = false

		if turkey.heartbeatConnection then disconnectConnection(turkey.heartbeatConnection) end

		turkey.heartbeatConnection = RunService.Heartbeat:Connect(function(dt)
			if not activeTurkeys[turkeyId] or not model or not model.Parent or not primaryPart or not primaryPart.Parent then
				disconnectConnection(turkey.heartbeatConnection)
				turkey.heartbeatConnection = nil
				return
			end

			local currentPos = primaryPart.Position
			local toTarget = target - currentPos
			local horizontal = Vector3.new(toTarget.X, 0, toTarget.Z)
			local dist = horizontal.Magnitude

			if dist <= Config.WanderReachThreshold then
				turkey.wanderData.reached = true
				disconnectConnection(turkey.heartbeatConnection)
				turkey.heartbeatConnection = nil
				return
			end

			local moveStep = math.min(speed * dt, dist)
			local moveVec = horizontal.Unit * moveStep
			local newPos = currentPos + Vector3.new(moveVec.X, 0, moveVec.Z)
			local lookAt = newPos + Vector3.new(horizontal.X, 0, horizontal.Z)
			primaryPart.CFrame = CFrame.new(newPos, lookAt)
		end)
	end

	turkey.wanderConnection = RunService.Heartbeat:Connect(function()
		if not activeTurkeys[turkeyId] or not turkey.wanderData then
			disconnectConnection(turkey.wanderConnection)
			turkey.wanderConnection = nil
			return
		end

		if turkey.wanderData.reached then
			turkey.wanderData.reached = false
			local t = pickTarget()
			goTo(t)
			task.delay(Config.WanderInterval, function() end)
		end
	end)

	return true
end

function TurkeyService:StopWandering(turkeyId)
	local turkey = activeTurkeys[turkeyId]
	if not turkey then return end
	if turkey.wanderConnection then disconnectConnection(turkey.wanderConnection) turkey.wanderConnection = nil end
	if turkey.heartbeatConnection then disconnectConnection(turkey.heartbeatConnection) turkey.heartbeatConnection = nil end
	turkey.wanderData = nil
end

function TurkeyService:GetActiveTurkeys()
	local copy = {}
	for id, data in pairs(activeTurkeys) do
		copy[id] = {
			health = data.health,
			maxHealth = data.maxHealth,
			spawnTime = data.spawnTime,
			modelName = data.modelName
		}
	end
	return copy
end

function TurkeyService:GetTurkeyByModelName(modelName)
	if type(modelName) ~= "string" then return nil end
	local id = turkeyModels[modelName]
	if not id then return nil end
	return activeTurkeys[id]
end

function TurkeyService:StartTurkeyEvent(duration)
	duration = tonumber(duration) or Config.AutoDespawnDefault
	local ok, result = self:SpawnTurkey()
	if not ok then return "❌ Failed to spawn Turkey: " .. tostring(result) end
	local turkeyId = result
	task.delay(2, function()
		local t = activeTurkeys[turkeyId]
		if t and t.modelName then
			self:PlayAnimation(t.modelName, "Idle", true)
		end
	end)
	task.delay(duration, function()
		if activeTurkeys[turkeyId] then
			self:DespawnTurkey(turkeyId)
		end
	end)
	return "✅ Turkey spawned for " .. tostring(duration) .. " seconds! 🦃", turkeyId
end

function TurkeyService:Start()
	DamageEvent.OnServerEvent:Connect(function(player, modelName, damage)
		if not player or not player:IsA("Player") then return end
		if type(modelName) ~= "string" then return end
		local turkeyId = turkeyModels[modelName]
		if not turkeyId or not activeTurkeys[turkeyId] then return end
		self:DamageTurkey(modelName, damage or 1, player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		for id, tbl in pairs(lastDamageTimestamps) do
			if tbl then
				tbl[player.UserId] = nil
			end
		end
	end)
end

return TurkeyService
