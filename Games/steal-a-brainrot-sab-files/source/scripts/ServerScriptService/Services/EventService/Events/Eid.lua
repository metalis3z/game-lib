local BalloonEid = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local Net = require(ReplicatedStorage.Packages.Net)
local Burst = Net:RemoteEvent("EventService/Eid/Burst")

local isActive = false
local balloons = {}
local balloonTasks = {}
local recentlyTargeted = {}
local activeAttacks = 0

local MAX_ATTACKS = 1
local BALLOON_SPEED = 14
local TARGET_CHECK_MIN = 8
local TARGET_CHECK_MAX = 16
local RECENT_TARGET_COOLDOWN = 25
local MIN_WANDER_DISTANCE = 40
local BALLOON_COUNT = 10

local WanderArea = workspace.Events.Eid.Wander

local BALLOON_WEIGHTS = {
	["Red"]     = 50,
	["Orange"]  = 80,
	["Green"]   = 65,
	["Blue"]    = 55,
	["Pink"]    = 35,
	["Rainbow"] = 15,
}

local BALLOON_TRAITS = {
	["Red"]     = "Red Balloon",
	["Orange"]  = "Orange Balloon",
	["Green"]   = "Green Balloon",
	["Blue"]    = "Blue Balloon",
	["Pink"]    = "Pink Balloon",
	["Rainbow"] = "Rainbow Balloon",
}

local function pickWeightedBalloonType()
	local totalWeight = 0
	for _, w in pairs(BALLOON_WEIGHTS) do
		totalWeight += w
	end

	local roll = math.random() * totalWeight
	local cumulative = 0
	for balloonType, weight in pairs(BALLOON_WEIGHTS) do
		cumulative += weight
		if roll <= cumulative then
			return balloonType
		end
	end

	return "Red"
end

local function traitToAttrKey(traitName)
	return "HasTrait_" .. traitName:gsub(" ", "_")
end

local function getRandomWanderPosition(currentPosition)
	local maxAttempts = 20
	local halfY = WanderArea.Size.Y / 2
	local topY = WanderArea.Position.Y + halfY

	for _ = 1, maxAttempts do
		local x = WanderArea.Position.X + (math.random() - 0.5) * WanderArea.Size.X
		local z = WanderArea.Position.Z + (math.random() - 0.5) * WanderArea.Size.Z
		local pos = Vector3.new(x, topY, z)
		if not currentPosition or (pos - currentPosition).Magnitude >= MIN_WANDER_DISTANCE then
			return pos
		end
	end

	local x = WanderArea.Position.X + (math.random() - 0.5) * WanderArea.Size.X
	local z = WanderArea.Position.Z + (math.random() - 0.5) * WanderArea.Size.Z
	return Vector3.new(x, topY, z)
end

local function clampToWanderArea(pos)
	local half = WanderArea.Size / 2
	local minB = WanderArea.Position - half
	local maxB = WanderArea.Position + half
	return Vector3.new(
		math.clamp(pos.X, minB.X, maxB.X),
		WanderArea.Position.Y + half.Y,
		math.clamp(pos.Z, minB.Z, maxB.Z)
	)
end

local function createBalloonHitbox(balloonType)
	local hitbox = Instance.new("Part")
	hitbox.Name = HttpService:GenerateGUID(false)
	hitbox.Size = Vector3.new(2, 2, 2)
	hitbox.Transparency = 1
	hitbox.CanCollide = false
	hitbox.Anchored = true
	hitbox.CFrame = CFrame.new(getRandomWanderPosition(nil))
	hitbox:SetAttribute("BalloonType", balloonType)
	hitbox:SetAttribute("BalloonColor", balloonType)
	CollectionService:AddTag(hitbox, "EidBalloon")
	hitbox.Parent = workspace
	return hitbox
end

local function floatBalloon(balloon)
	local timeOffset = math.random() * math.pi * 2
	local xOffset    = math.random() * math.pi * 2
	local zOffset    = math.random() * math.pi * 2

	local floatRangeY = math.random(1, 3)
	local driftRangeX = math.random(3, 6)
	local driftRangeZ = math.random(3, 6)

	local freqY = 0.20 + math.random() * 0.10
	local freqX = 0.18 + math.random() * 0.12
	local freqZ = 0.16 + math.random() * 0.12

	local origin = balloon.Position

	local conn
	conn = RunService.Heartbeat:Connect(function()
		if not balloon.Parent or not isActive then
			conn:Disconnect()
			return
		end

		if balloon:GetAttribute("IsAttacking") then return end

		local t = os.clock() + timeOffset
		local offsetY = math.sin(t * freqY * math.pi * 2) * floatRangeY
		local offsetX = math.sin(t * freqX * math.pi * 2 + xOffset) * driftRangeX
		local offsetZ = math.sin(t * freqZ * math.pi * 2 + zOffset) * driftRangeZ

		local newPos = clampToWanderArea(origin + Vector3.new(offsetX, offsetY, offsetZ))
		balloon.CFrame = CFrame.new(newPos)
	end)
end

local function hasTrait(animal, traitName)
	if animal:GetAttribute(traitToAttrKey(traitName)) then return true end
	local traitsJson = animal:GetAttribute("Traits")
	if not traitsJson then return false end
	local ok, decoded = pcall(function() return HttpService:JSONDecode(traitsJson) end)
	if ok and type(decoded) == "table" then
		for _, t in ipairs(decoded) do
			if t == traitName then
				animal:SetAttribute(traitToAttrKey(traitName), true)
				return true
			end
		end
	end
	return false
end

local function applyTrait(animal, traitName)
	if hasTrait(animal, traitName) then return end

	local traitsJson = animal:GetAttribute("Traits")
	local traits = {}
	if traitsJson then
		local ok, decoded = pcall(function() return HttpService:JSONDecode(traitsJson) end)
		if ok and type(decoded) == "table" then
			traits = decoded
		end
	end

	table.insert(traits, traitName)
	animal:SetAttribute("Traits", HttpService:JSONEncode(traits))
	animal:SetAttribute(traitToAttrKey(traitName), true)
end

local spawnBalloon

local function attackAnimal(balloon)
	local balloonType = balloon:GetAttribute("BalloonType")
	local traitName = BALLOON_TRAITS[balloonType] or "Red Balloon"

	while isActive and balloon.Parent do
		task.wait(math.random(TARGET_CHECK_MIN, TARGET_CHECK_MAX))

		if not isActive or not balloon.Parent then break end
		if activeAttacks >= MAX_ATTACKS then continue end
		if balloon:GetAttribute("IsAttacking") then continue end

		local animals = CollectionService:GetTagged("Animal")
		local candidates = {}
		local currentTime = workspace:GetServerTimeNow()

		for _, animal in ipairs(animals) do
			local lastHit = recentlyTargeted[animal.Name] or 0
			local isLocked = animal:GetAttribute("TargetedByBalloon") ~= nil
			if animal.PrimaryPart
				and not hasTrait(animal, traitName)
				and not isLocked
				and (currentTime - lastHit) > RECENT_TARGET_COOLDOWN
			then
				table.insert(candidates, animal)
			end
		end

		if #candidates == 0 then continue end
		if activeAttacks >= MAX_ATTACKS then continue end

		local selected = candidates[math.random(1, #candidates)]
		activeAttacks += 1
		balloon:SetAttribute("IsAttacking", true)
		selected:SetAttribute("TargetedByBalloon", balloon.Name)

		local chaseStart = os.clock()
		local reachedTarget = false
		local connection

		connection = RunService.Heartbeat:Connect(function(dt)
			local targetLost = not selected.Parent or not selected.PrimaryPart
			local alreadyHit = hasTrait(selected, traitName)

			if not isActive or targetLost or alreadyHit or (os.clock() - chaseStart) > 20 or not balloon.Parent then
				connection:Disconnect()
				return
			end

			local targetPos = selected.PrimaryPart.Position
			local currentPos = balloon.Position
			local direction = targetPos - currentPos
			local dist = direction.Magnitude

			if dist > 0.1 then
				local step = math.min(BALLOON_SPEED * dt, dist)
				balloon.CFrame = CFrame.new(currentPos + direction.Unit * step)
			end

			if dist <= 5 then
				reachedTarget = true
				connection:Disconnect()
			end
		end)

		repeat RunService.Heartbeat:Wait() until not connection.Connected

		if reachedTarget and isActive and selected.Parent then
			recentlyTargeted[selected.Name] = workspace:GetServerTimeNow()

			applyTrait(selected, traitName)
			Burst:FireAllClients(selected.PrimaryPart)

			if selected.Parent then
				selected:SetAttribute("TargetedByBalloon", nil)
			end

			activeAttacks = math.max(0, activeAttacks - 1)

			local oldName = balloon.Name
			local tasks = balloonTasks[oldName]
			if tasks and tasks.wander then
				task.cancel(tasks.wander)
			end
			balloons[oldName] = nil
			balloonTasks[oldName] = nil
			balloon:Destroy()

			if isActive then
				task.delay(2, function()
					if isActive then
						local newType = pickWeightedBalloonType()
						spawnBalloon(newType)
					end
				end)
			end

			return
		end

		if selected and selected.Parent then
			selected:SetAttribute("TargetedByBalloon", nil)
		end
		balloon:SetAttribute("IsAttacking", false)
		activeAttacks = math.max(0, activeAttacks - 1)
	end
end

spawnBalloon = function(balloonType)
	local balloon = createBalloonHitbox(balloonType)
	balloons[balloon.Name] = balloon
	balloonTasks[balloon.Name] = {
		wander = task.spawn(function() floatBalloon(balloon) end),
		attack = task.spawn(function() attackAnimal(balloon) end),
	}
end

function BalloonEid.OnStart()
	if isActive then return end
	isActive = true

	for _ = 1, BALLOON_COUNT do
		local balloonType = pickWeightedBalloonType()
		spawnBalloon(balloonType)
	end
	ReplicatedStorage:SetAttribute("EidEvent", true)
end

function BalloonEid.OnStop()
	if not isActive then return end
	isActive = false

	for _, tasks in pairs(balloonTasks) do
		if tasks.wander then task.cancel(tasks.wander) end
		if tasks.attack then task.cancel(tasks.attack) end
	end

	for _, balloon in pairs(balloons) do
		if balloon then balloon:Destroy() end
	end

	balloons = {}
	balloonTasks = {}
	recentlyTargeted = {}
	activeAttacks = 0
	ReplicatedStorage:SetAttribute("EidEvent", nil)
end

return BalloonEid