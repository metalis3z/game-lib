--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Net = require(ReplicatedStorage.Packages.Net)
local Burst = Net:RemoteEvent("EventService/Water/Burst")

local Water = {}
local isActive = false
local sharks: { [string]: Part } = {}
local sharkTasks: { [string]: { wander: thread, attack: thread } } = {}
local recentlyTargeted: { [string]: number } = {}

local WanderArea = workspace.Events.Water.Wander

local SHARK_SPEED = 20
local MIN_TRALALEROS = 1
local MAX_TRALALEROS = 6
local MIN_ORCALEROS = 1
local MAX_ORCALEROS = 3
local TARGET_CHECK_MIN = 6
local TARGET_CHECK_MAX = 12
local MIN_WANDER_DISTANCE = 50

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
	shark.CFrame = CFrame.lookAt(currentPos, position)
	local distance = (currentPos - position).Magnitude
	local duration = distance / SHARK_SPEED
	local targetCFrame = CFrame.lookAt(position, position + (position - currentPos).Unit)

	local tween = TweenService:Create(shark, TweenInfo.new(duration, Enum.EasingStyle.Linear), { CFrame = targetCFrame })
	tween:Play()
	return tween
end

local function wanderShark(shark: Part)
	while isActive and shark.Parent do
		local pos = getRandomWanderPosition(shark.Position)
		local tween = tweenSharkToPosition(shark, pos, true)
		if tween then tween.Completed:Wait() end
		task.wait(0.1)
	end
end

local function applySharkTrait(animal: Instance)
	local traitsJson = animal:GetAttribute("Traits")
	local traits: { string } = {}
	if traitsJson then
		local success, decoded = pcall(function() return HttpService:JSONDecode(traitsJson) end)
		if success and type(decoded) == "table" then traits = decoded end
	end
	for _, t in ipairs(traits) do
		if t == "Shark Fin" then return end
	end
	table.insert(traits, "Shark Fin")
	animal:SetAttribute("Traits", HttpService:JSONEncode(traits))
end

local function attackAnimal(shark: Part)
	while isActive and shark.Parent do
		task.wait(math.random(TARGET_CHECK_MIN, TARGET_CHECK_MAX))
		if not isActive then break end

		local animals = CollectionService:GetTagged("Animal")
		local currentTime = workspace:GetServerTimeNow()
		for name, last in pairs(recentlyTargeted) do
			if currentTime - last > 20 then recentlyTargeted[name] = nil end
		end

		local candidates: { Instance } = {}
		for _, animal in ipairs(animals) do
			if animal.PrimaryPart and not recentlyTargeted[animal.Name] then
				local hasSharkFin = false
				local traitsJson = animal:GetAttribute("Traits")
				if traitsJson then
					local success, decoded = pcall(function() return HttpService:JSONDecode(traitsJson) end)
					if success and type(decoded) == "table" then
						for _, t in ipairs(decoded) do if t == "Shark Fin" then hasSharkFin = true break end end
					end
				end
				if not hasSharkFin then table.insert(candidates, animal) end
			end
		end

		if #candidates == 0 then continue end
		local selected = candidates[math.random(1, #candidates)]
		local chaseStart = tick()
		local maxChase = 15
		local attackDistance = 5
		local tween: Tween? = nil

		while isActive and selected.Parent and selected.PrimaryPart and (tick() - chaseStart) < maxChase do
			local animalPos = selected.PrimaryPart.Position
			local dist = (shark.Position - animalPos).Magnitude
			if dist <= attackDistance then if tween then tween:Cancel() break end end
			if tween then tween:Cancel() end
			tween = tweenSharkToPosition(shark, animalPos, false)
			task.wait(0.5)
		end

		if selected and selected.Parent then
			shark:SetAttribute("Attack", not shark:GetAttribute("Attack"))
			Burst:FireAllClients(shark.Name, selected.Name)
			recentlyTargeted[selected.Name] = workspace:GetServerTimeNow()
			applySharkTrait(selected)
			task.wait(1)
			local surfacePos = getRandomWanderPosition(shark.Position)
			local surfaceTween = tweenSharkToPosition(shark, surfacePos, true)
			if surfaceTween then surfaceTween.Completed:Wait() end
		end
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
	ReplicatedStorage:SetAttribute("WaterEvent", true)

	for i = 1, math.random(MIN_TRALALEROS, MAX_TRALALEROS) do spawnShark("Tralalero Tralala") task.wait(0.5) end
	for i = 1, math.random(MIN_ORCALEROS, MAX_ORCALEROS) do spawnShark("Orcalero Orcala") task.wait(0.5) end
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
