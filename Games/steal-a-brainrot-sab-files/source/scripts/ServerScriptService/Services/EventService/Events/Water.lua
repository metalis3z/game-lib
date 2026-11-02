--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local AnimalService = require(game.ServerScriptService.Services.AnimalService)
local Animals = require(ReplicatedStorage.Datas.Animals)
local Net = require(ReplicatedStorage.Packages.Net)
local Burst = Net:RemoteEvent("EventService/Water/Burst")

local Water = {}
local isActive = false
local sharks: { [string]: Part } = {}
local sharkTasks: { [string]: { wander: thread, attack: thread } } = {}
local recentlyTargeted: { [string]: number } = {}
local activeAttackCount = 0
local MAX_SIMULTANEOUS_ATTACKS = 2

local WanderArea = workspace.Events.Water.Wander

local SHARK_SPEED = 20
local MIN_TRALALEROS = 4
local MAX_TRALALEROS = 4
local MIN_ORCALEROS = 4
local MAX_ORCALEROS = 4
local TARGET_CHECK_MIN = 15
local TARGET_CHECK_MAX = 25 
local RECENT_TARGET_COOLDOWN = 30
local MIN_WANDER_DISTANCE = 50

local activeAttacks = 0
local MAX_ATTACKS = 1

local function getRandomWanderPosition(currentPosition: Vector3?)
	local maxAttempts = 20
	local attempts = 0
	local halfY = WanderArea.Size.Y / 2
	local topY = WanderArea.Position.Y + halfY

	while attempts < maxAttempts do
		local x = WanderArea.Position.X + (math.random() - 0.5) * WanderArea.Size.X
		local z = WanderArea.Position.Z + (math.random() - 0.5) * WanderArea.Size.Z
		local pos = Vector3.new(x, topY, z)

		if not currentPosition or (pos - currentPosition).Magnitude >= MIN_WANDER_DISTANCE then
			return pos
		end
		attempts += 1
	end

	local x = WanderArea.Position.X + (math.random() - 0.5) * WanderArea.Size.X
	local z = WanderArea.Position.Z + (math.random() - 0.5) * WanderArea.Size.Z
	return Vector3.new(x, topY, z)
end

local function clampPositionToWanderArea(pos: Vector3)
	local half = WanderArea.Size / 2
	local minBound = WanderArea.Position - half
	local maxBound = WanderArea.Position + half
	return Vector3.new(
		math.clamp(pos.X, minBound.X, maxBound.X),
		WanderArea.Position.Y + half.Y,
		math.clamp(pos.Z, minBound.Z, maxBound.Z)
	)
end

local function createSharkHitbox(sharkType: string)
	local hitbox = Instance.new("Part")
	hitbox.Name = HttpService:GenerateGUID(false)
	hitbox.Size = Vector3.new(1, 1, 1)
	hitbox.Transparency = 1
	hitbox.CanCollide = false
	hitbox.Anchored = true
	hitbox.CFrame = CFrame.new(getRandomWanderPosition(nil))
	hitbox:SetAttribute("SharkType", sharkType)
	CollectionService:AddTag(hitbox, "WaterShark")
	hitbox.Parent = workspace
	return hitbox
end

local function tweenSharkToPosition(shark: Part, position: Vector3, constrain: boolean)
	if constrain then
		position = clampPositionToWanderArea(position)
	end

	local currentPos = shark.Position
	local direction = (position - currentPos)
	local distance = direction.Magnitude

	if distance < 0.1 then
		return { Completed = { Wait = function() end }, Cancel = function() end }
	end

	shark.CFrame = CFrame.lookAt(currentPos, position)

	local duration = distance / SHARK_SPEED
	local finalCFrame = CFrame.lookAt(position, position + direction.Unit)

	local moveTween = TweenService:Create(shark, TweenInfo.new(duration, Enum.EasingStyle.Linear), { CFrame = finalCFrame })
	moveTween:Play()
	return moveTween
end

local function wanderShark(shark: Part)
	while isActive and shark.Parent do
		if shark:GetAttribute("IsAttacking") then
			task.wait(0.5)
			continue
		end

		local pos = getRandomWanderPosition(shark.Position)
		local tween = tweenSharkToPosition(shark, pos, true)

		local interruptConnection
		interruptConnection = shark:GetAttributeChangedSignal("IsAttacking"):Connect(function()
			if shark:GetAttribute("IsAttacking") then
				tween:Cancel()
			end
		end)

		tween.Completed:Wait()

		if interruptConnection then
			interruptConnection:Disconnect()
		end

		task.wait(0.1)
	end
end

local function applySharkTrait(animal: Instance)
	if animal:GetAttribute("HasSharkFin") then return end

	local traitsJson = animal:GetAttribute("Traits")
	local traits: { string } = {}

	if traitsJson then
		local success, decoded = pcall(function() return HttpService:JSONDecode(traitsJson) end)
		if success and type(decoded) == "table" then 
			traits = decoded 
		end
	end
	if animal:GetAttribute("HasSharkFin") then return end
	for _, t in ipairs(traits) do
		if t == "Shark Fin" then 
			animal:SetAttribute("HasSharkFin", true)
			return 
		end
	end

	table.insert(traits, "Shark Fin")

	animal:SetAttribute("Traits", HttpService:JSONEncode(traits))
	animal:SetAttribute("HasSharkFin", true)
end

local function attackAnimal(shark: Part)
	while isActive and shark.Parent do
		task.wait(math.random(TARGET_CHECK_MIN, TARGET_CHECK_MAX))

		if not isActive or activeAttacks >= MAX_ATTACKS then continue end
		if shark:GetAttribute("IsAttacking") then continue end

		local animals = CollectionService:GetTagged("Animal")
		local candidates: { Instance } = {}
		local currentTime = workspace:GetServerTimeNow()

		for _, animal in ipairs(animals) do
			local hasTrait = animal:GetAttribute("HasSharkFin")
			local isLocked = animal:GetAttribute("TargetedBy") ~= nil
			local lastHit = recentlyTargeted[animal.Name] or 0

			if animal.PrimaryPart and not hasTrait and not isLocked then
				if currentTime - lastHit > RECENT_TARGET_COOLDOWN then
					table.insert(candidates, animal)
				end
			end
		end

		if #candidates == 0 then continue end

		local selected = candidates[math.random(1, #candidates)]

		if activeAttacks >= MAX_ATTACKS then continue end

		activeAttacks += 1
		shark:SetAttribute("IsAttacking", true)
		selected:SetAttribute("TargetedBy", shark.Name)

		local chaseStart = os.clock()
		local reachedTarget = false
		local connection

		connection = RunService.Heartbeat:Connect(function(dt)
			local targetLost = not selected.Parent or not selected.PrimaryPart
			local targetAlreadyHit = selected:GetAttribute("HasSharkFin")

			if not isActive or targetLost or targetAlreadyHit or (os.clock() - chaseStart) > 15 then
				connection:Disconnect()
				return
			end

			local targetPos = selected.PrimaryPart.Position
			local currentPos = shark.Position

			shark.CFrame = CFrame.lookAt(currentPos, targetPos)

			shark.Position += shark.CFrame.LookVector * SHARK_SPEED * dt

			if (targetPos - currentPos).Magnitude <= 6 then
				reachedTarget = true
				connection:Disconnect()
			end
		end)

		repeat RunService.Heartbeat:Wait() until not connection.Connected

		if reachedTarget and isActive and selected.Parent then
			recentlyTargeted[selected.Name] = workspace:GetServerTimeNow()
			Burst:FireAllClients(shark.Name, selected.Name)
			applySharkTrait(selected)

			task.wait(0.25)
		end

		if selected and selected.Parent then
			selected:SetAttribute("TargetedBy", nil)
		end
		shark:SetAttribute("IsAttacking", false)
		activeAttacks = math.max(0, activeAttacks - 1)
	end
end

local function spawnShark(sharkType: string)
	local shark = createSharkHitbox(sharkType)
	sharks[shark.Name] = shark
	sharkTasks[shark.Name] = {
		wander = task.spawn(function() wanderShark(shark) end),
		attack = task.spawn(function() attackAnimal(shark) end)
	}
end

function Water.OnStart()
	if isActive then return end
	isActive = true

	for _, tasks in pairs(sharkTasks) do
		if tasks.wander then task.cancel(tasks.wander) end
		if tasks.attack then task.cancel(tasks.attack) end
	end
	for _, shark in pairs(sharks) do if shark then shark:Destroy() end end
	sharks = {}
	sharkTasks = {}
	recentlyTargeted = {}
	activeAttacks = 0

	ReplicatedStorage:SetAttribute("WaterEvent", true)
	for i = 1, math.random(MIN_TRALALEROS, MAX_TRALALEROS) do
		if not isActive then break end
		spawnShark("Tralalero Tralala")
	end
	for i = 1, math.random(MIN_ORCALEROS, MAX_ORCALEROS) do
		if not isActive then break end
		spawnShark("Orcalero Orcala")
	end
end

function Water.OnStop()
	if not isActive then return end
	isActive = false
	ReplicatedStorage:SetAttribute("WaterEvent", false)

	for _, tasks in pairs(sharkTasks) do
		if tasks.wander then task.cancel(tasks.wander) end
		if tasks.attack then task.cancel(tasks.attack) end
	end

	for _, shark in pairs(sharks) do if shark then shark:Destroy() end end
	sharks = {}
	sharkTasks = {}
	recentlyTargeted = {}
end

return Water