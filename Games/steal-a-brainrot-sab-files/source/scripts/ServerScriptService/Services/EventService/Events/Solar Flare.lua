local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)
local CombatService = require(ServerScriptService.Services.CombatService)

local SolarFlare = {}
local isActive = false
local flareTask: thread?
local activeFlares = {}
local solarFlareBase: BasePart?
local roadsListener: RBXScriptConnection?
local hitCooldowns = {}
local roadsAdded = false

local middleTimeoutTasks: { [BasePart]: thread } = {}
local traitHitTracker: { [BasePart]: { count: number, windowStart: number } } = {}

local middleZoneTracker: { [BasePart]: { zone: string, zoneStart: number } } = {}

local roleSwapTasks: { [BasePart]: thread } = {}

local MapFloor = workspace.Events["Solar Flare"]:FindFirstChild("MapFloor") :: BasePart
local FullMapFloor = workspace.Events["Solar Flare"]:FindFirstChild("FullMapFloor") :: BasePart?

local BEAM_SPEED         = 32
local HIT_COOLDOWN       = 30
local MOVEMENT_THRESHOLD = 1
local BEAM_INTERVAL      = 15
local MAX_BEAMS_NORMAL   = 4

local ANIMAL_HIT_TIMEOUT   = 20
local MIDDLE_ROAM_FRACTION = 0.70
local SIDE_FRACTION        = 0.05
local SWITCH_SIDE_CHANCE   = 0.15
local MIDDLE_CHANCE        = 0.10

local SCATTER_THRESHOLD = 3
local SCATTER_WINDOW    = 10
local SCATTER_STUDS     = 6

local MIDDLE_ZONE_MAX = 3
local ROLE_SWAP_INTERVAL = 30

local ROLE_SIDE   = "side"
local ROLE_MIDDLE = "middle"

local ZONES = { "left", "centre", "right" }

local function getFloor(): BasePart
	return FullMapFloor or MapFloor
end


local function armMiddleTimeout(hitbox: BasePart)
	if middleTimeoutTasks[hitbox] then
		task.cancel(middleTimeoutTasks[hitbox])
		middleTimeoutTasks[hitbox] = nil
	end
	hitbox:SetAttribute("CanGoMiddle", false)
	middleTimeoutTasks[hitbox] = task.delay(ANIMAL_HIT_TIMEOUT, function()
		middleTimeoutTasks[hitbox] = nil
		if hitbox and hitbox.Parent then
			hitbox:SetAttribute("CanGoMiddle", true)
		end
	end)
end
local function pickNewZone(currentZone: string): string
	local choices: { string } = {}
	for _, z in ipairs(ZONES) do
		if z ~= currentZone then
			table.insert(choices, z)
		end
	end
	return choices[math.random(1, #choices)]
end

local function getZoneBounds(zone: string): (number, number)
	local floor = getFloor()
	local s, p  = floor.Size, floor.Position
	local halfX = s.X / 2
	local roamHalfX = halfX * MIDDLE_ROAM_FRACTION
	local third = roamHalfX * 2 / 3

	if zone == "left" then
		return p.X - roamHalfX, p.X - roamHalfX + third
	elseif zone == "right" then
		return p.X + roamHalfX - third, p.X + roamHalfX
	else
		return p.X - third / 2, p.X + third / 2
	end
end

local function xToZone(x: number): string
	local floor = getFloor()
	local p     = floor.Position
	local halfX = floor.Size.X / 2
	local roamHalfX = halfX * MIDDLE_ROAM_FRACTION
	local third = roamHalfX * 2 / 3
	if x < p.X - roamHalfX + third then
		return "left"
	elseif x > p.X + roamHalfX - third then
		return "right"
	else
		return "centre"
	end
end

local function advanceZoneIfNeeded(hitbox: BasePart): string
	local tracker = middleZoneTracker[hitbox]
	if not tracker then
		local zone = ZONES[math.random(1, #ZONES)]
		middleZoneTracker[hitbox] = { zone = zone, zoneStart = tick() }
		return zone
	end

	if tick() - tracker.zoneStart >= MIDDLE_ZONE_MAX then
		local newZone = pickNewZone(tracker.zone)
		tracker.zone      = newZone
		tracker.zoneStart = tick()
	end
	return tracker.zone
end


local function recordMiddleTraitHit(hitbox: BasePart)
	local now     = tick()
	local tracker = traitHitTracker[hitbox]
	if not tracker then
		traitHitTracker[hitbox] = { count = 1, windowStart = now }
		return
	end
	if now - tracker.windowStart > SCATTER_WINDOW then
		tracker.count       = 1
		tracker.windowStart = now
		return
	end
	tracker.count += 1
	if tracker.count >= SCATTER_THRESHOLD then
		tracker.count       = 0
		tracker.windowStart = now
		if hitbox and hitbox.Parent then
			local floor     = getFloor()
			local s, p      = floor.Size, floor.Position
			local roamHalfX = s.X / 2 * MIDDLE_ROAM_FRACTION
			local nudge     = if math.random() > 0.5 then SCATTER_STUDS else -SCATTER_STUDS
			local newX      = math.clamp(hitbox.Position.X + nudge, p.X - roamHalfX, p.X + roamHalfX)
			TweenService:Create(hitbox, TweenInfo.new(0), {}):Play()
			hitbox.Position = Vector3.new(newX, hitbox.Position.Y, hitbox.Position.Z)
			if middleZoneTracker[hitbox] then
				middleZoneTracker[hitbox].zone      = xToZone(newX)
				middleZoneTracker[hitbox].zoneStart = tick()
			end
		end
	end
end


local function scheduleRoleSwap(hitbox: BasePart)
	if roleSwapTasks[hitbox] then
		task.cancel(roleSwapTasks[hitbox])
		roleSwapTasks[hitbox] = nil
	end

	roleSwapTasks[hitbox] = task.spawn(function()
		while isActive and hitbox.Parent do
			task.wait(ROLE_SWAP_INTERVAL)
			if not isActive or not hitbox.Parent then break end

			local current = hitbox:GetAttribute("BeamRole") :: string?
			if current == ROLE_MIDDLE then
				hitbox:SetAttribute("BeamRole", ROLE_SIDE)
				local side = if math.random() > 0.5 then 1 else -1
				hitbox:SetAttribute("PreferredSide", side)
				armMiddleTimeout(hitbox)
			else
				hitbox:SetAttribute("BeamRole", ROLE_MIDDLE)
				middleZoneTracker[hitbox] = { zone = ZONES[math.random(1, #ZONES)], zoneStart = tick() }
				traitHitTracker[hitbox] = { count = 0, windowStart = tick() }
				if middleTimeoutTasks[hitbox] then
					task.cancel(middleTimeoutTasks[hitbox])
					middleTimeoutTasks[hitbox] = nil
				end
				hitbox:SetAttribute("CanGoMiddle", false)
			end
		end
		roleSwapTasks[hitbox] = nil
	end)
end


local function getSidePosition(hitbox: BasePart): Vector3
	local floor = getFloor()
	local s, p  = floor.Size, floor.Position
	local halfX = s.X / 2
	local halfZ = s.Z / 2
	local sideWidth = halfX * SIDE_FRACTION

	local side = hitbox:GetAttribute("PreferredSide") :: number?
	if not side then
		side = if math.random() > 0.5 then 1 else -1
		hitbox:SetAttribute("PreferredSide", side)
	end
	if math.random() < SWITCH_SIDE_CHANCE then
		side = -side :: number
		hitbox:SetAttribute("PreferredSide", side)
	end

	local minX: number
	local maxX: number
	if side == 1 then
		minX = p.X + halfX - sideWidth
		maxX = p.X + halfX
	else
		minX = p.X - halfX
		maxX = p.X - halfX + sideWidth
	end

	local x = minX + math.random() * (maxX - minX)
	local z = p.Z + math.random(-math.floor(halfZ), math.floor(halfZ))
	return Vector3.new(x, p.Y + s.Y / 2, z)
end

local function getMiddlePosition(hitbox: BasePart): Vector3
	local floor = getFloor()
	local s, p  = floor.Size, floor.Position
	local halfZ = s.Z / 2

	local zone           = advanceZoneIfNeeded(hitbox)
	local minX, maxX     = getZoneBounds(zone)
	local middleThreshold = (maxX - minX) / 2

	local candidates: { BasePart } = {}
	for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
		if animal.PrimaryPart then
			local ax = animal.PrimaryPart.Position.X
			if ax >= minX and ax <= maxX then
				table.insert(candidates, animal.PrimaryPart)
			end
		end
	end

	local x: number
	if #candidates > 0 then
		local chosen = candidates[math.random(1, #candidates)]
		x = math.clamp(chosen.Position.X, minX, maxX)
	else
		x = minX + math.random() * (maxX - minX)
	end

	local z = p.Z + math.random(-math.floor(halfZ), math.floor(halfZ))
	return Vector3.new(x, p.Y + s.Y / 2, z)
end

local function getTargetPosition(hitbox: BasePart): Vector3
	local role = hitbox:GetAttribute("BeamRole") :: string?

	if role == ROLE_MIDDLE then
		return getMiddlePosition(hitbox)
	end

	local floor = getFloor()
	local s, p  = floor.Size, floor.Position
	local halfX = s.X / 2

	local canGoMiddle = hitbox:GetAttribute("CanGoMiddle") == true
	if canGoMiddle then
		local middleThreshold = halfX * (1 - SIDE_FRACTION * 2)
		local animalInMiddle  = false
		for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
			if animal.PrimaryPart then
				if math.abs(animal.PrimaryPart.Position.X - p.X) <= middleThreshold then
					animalInMiddle = true
					break
				end
			end
		end
		if not animalInMiddle then canGoMiddle = false end
	end

	if canGoMiddle and math.random() < MIDDLE_CHANCE then
		local middleThreshold = halfX * (1 - SIDE_FRACTION * 2)
		local candidates: { BasePart } = {}
		for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
			if animal.PrimaryPart then
				if math.abs(animal.PrimaryPart.Position.X - p.X) <= middleThreshold then
					table.insert(candidates, animal.PrimaryPart)
				end
			end
		end
		if #candidates > 0 then
			local chosen = candidates[math.random(1, #candidates)]
			return Vector3.new(chosen.Position.X, p.Y + s.Y / 2, chosen.Position.Z)
		end
	end

	return getSidePosition(hitbox)
end


local function decodeTraits(data: string?): { any }
	if not data then return {} end
	local ok, result = pcall(function() return HttpService:JSONDecode(data) end)
	return ok and type(result) == "table" and result or {}
end

local function encodeTraits(traits: { any }): string
	return HttpService:JSONEncode(traits)
end

local function hasTrait(traits: { any }, name: string): boolean
	for _, v in ipairs(traits) do
		if v == name then return true end
	end
	return false
end

local function addTrait(hitbox: BasePart, animal: Model, name: string, pos: Vector3)
	if not animal.PrimaryPart then return end
	if (animal.PrimaryPart.Position - pos).Magnitude > 8 then return end
	local traits = decodeTraits(animal:GetAttribute("Traits"))
	if hasTrait(traits, name) then return end
	table.insert(traits, name)
	animal:SetAttribute("Traits", encodeTraits(traits))

	local role = hitbox:GetAttribute("BeamRole") :: string?
	if role == ROLE_MIDDLE then
		recordMiddleTraitHit(hitbox)
	else
		armMiddleTimeout(hitbox)
	end
end


local function isHitboxMoving(hitbox: BasePart): boolean
	local last = hitbox:GetAttribute("LastPosition")
	if not last then return false end
	return (hitbox.Position - last).Magnitude > MOVEMENT_THRESHOLD
end

local function ragdollPlayer(char: Model)
	Ragdoll.Ragdoll(char)
	task.delay(2.5, function()
		if char and char.Parent then
			Ragdoll.Unragdoll(char)
		end
	end)
end

local function flingPlayer(hrp: BasePart, origin: Vector3)
	CombatService.Fling(hrp, 600, origin)
end

local function handlePlayerHit(hitbox: BasePart)
	if not isHitboxMoving(hitbox) then return end
	local pos, size = hitbox.Position, hitbox.Size
	for _, player in ipairs(Players:GetPlayers()) do
		local char = player.Character
		if not char then continue end
		local hrp = char:FindFirstChild("HumanoidRootPart") :: BasePart?
		local hum = char:FindFirstChild("Humanoid") :: Humanoid?
		if not hrp or not hum or hum.Health <= 0 then continue end
		if hitCooldowns[player.UserId] and tick() < hitCooldowns[player.UserId] then continue end
		local r = (size.X + size.Z) / 4 + 3
		if (hrp.Position - pos).Magnitude <= r then
			hitCooldowns[player.UserId] = tick() + HIT_COOLDOWN
			flingPlayer(hrp, pos)
			ragdollPlayer(char)
		end
	end
end


local function createHitbox(role: string): BasePart
	local template = ReplicatedStorage.Models.Events["Solar Flare"].SolarFlareBeam.Hitbox
	local hitbox   = template:Clone()
	hitbox.Anchored   = true
	hitbox.CanCollide = false
	hitbox.Position   = Vector3.new(-411.132, 72.563, 60.17)
	hitbox:SetAttribute("LastPosition", hitbox.Position)
	hitbox:SetAttribute("CanGoMiddle",  false)
	hitbox:SetAttribute("BeamRole",     role)
	CollectionService:AddTag(hitbox, "SolarFlareHitbox")
	hitbox.Parent = workspace.Events["Solar Flare"]
	return hitbox
end

local function tweenToTarget(hitbox: BasePart, target: Vector3): (Tween, number)
	local distance = (hitbox.Position - target).Magnitude
	local duration = math.max(distance / BEAM_SPEED, 0.001)
	local tween = TweenService:Create(
		hitbox,
		TweenInfo.new(duration, Enum.EasingStyle.Linear),
		{ Position = target }
	)
	tween:Play()
	return tween, duration
end

local function moveBeam(hitbox: BasePart)
	local role = hitbox:GetAttribute("BeamRole") :: string?
	if role == ROLE_SIDE then
		armMiddleTimeout(hitbox)
	else
		traitHitTracker[hitbox]   = { count = 0, windowStart = tick() }
		middleZoneTracker[hitbox] = { zone = ZONES[math.random(1, #ZONES)], zoneStart = tick() }
		scheduleRoleSwap(hitbox)
	end

	task.spawn(function()
		while isActive and hitbox.Parent do
			local target      = getTargetPosition(hitbox)
			local _, duration = tweenToTarget(hitbox, target)
			local step        = 0.1
			local elapsed     = 0

			while elapsed < duration do
				if not isActive or not hitbox.Parent then break end
				local pos = hitbox.Position
				for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
					if animal.PrimaryPart then
						addTrait(hitbox, animal, "Fire", pos)
					end
				end
				handlePlayerHit(hitbox)
				hitbox:SetAttribute("LastPosition", pos)
				task.wait(step)
				elapsed += step
			end
		end

		if middleTimeoutTasks[hitbox] then
			task.cancel(middleTimeoutTasks[hitbox])
			middleTimeoutTasks[hitbox] = nil
		end
		if roleSwapTasks[hitbox] then
			task.cancel(roleSwapTasks[hitbox])
			roleSwapTasks[hitbox] = nil
		end
		traitHitTracker[hitbox]   = nil
		middleZoneTracker[hitbox] = nil
		if hitbox and hitbox.Parent then
			hitbox:Destroy()
		end
		for i, flare in ipairs(activeFlares) do
			if flare.hitbox == hitbox then
				table.remove(activeFlares, i)
				break
			end
		end
	end)
end


local function spawnFlare(role: string)
	local hitbox = createHitbox(role)
	if role == ROLE_SIDE then
		local startSide = if math.random() > 0.5 then 1 else -1
		hitbox:SetAttribute("PreferredSide", startSide)
	end
	table.insert(activeFlares, { hitbox = hitbox, position = hitbox.Position })
	moveBeam(hitbox)
	if solarFlareBase then
		solarFlareBase:SetAttribute("NumBeams", #activeFlares)
	end
end


local function cleanup()
	for _, f in ipairs(activeFlares) do
		if f.hitbox and f.hitbox.Parent then
			f.hitbox:Destroy()
		end
	end
	for _, t in pairs(middleTimeoutTasks) do task.cancel(t) end
	for _, t in pairs(roleSwapTasks)      do task.cancel(t) end
	middleTimeoutTasks = {}
	roleSwapTasks      = {}
	traitHitTracker    = {}
	middleZoneTracker  = {}
	activeFlares       = {}
	for _, h in ipairs(CollectionService:GetTagged("SolarFlareHitbox")) do
		h:Destroy()
	end
	if solarFlareBase then
		solarFlareBase:Destroy()
		solarFlareBase = nil
	end
	hitCooldowns = {}
end

function SolarFlare.OnStart()
	if isActive then return end
	isActive           = true
	roadsAdded         = false
	hitCooldowns       = {}
	middleTimeoutTasks = {}
	roleSwapTasks      = {}
	traitHitTracker    = {}
	middleZoneTracker  = {}
	ReplicatedStorage:SetAttribute("SolarFlareEvent", true)

	solarFlareBase = ReplicatedStorage.Models.Events["Solar Flare"].SolarFlareBeam.BeamEnd:Clone() :: BasePart
	solarFlareBase.Position = Vector3.new(-411.132, 72.563, 60.17)
	solarFlareBase.Name     = "SolarFlareBase"
	CollectionService:AddTag(solarFlareBase, "SolarFlareBase")
	solarFlareBase:SetAttribute("NumBeams", 0)
	solarFlareBase.Parent = workspace.Events["Solar Flare"]

	roadsListener = ReplicatedStorage:GetAttributeChangedSignal("3RoadsEvent"):Connect(function()
		if ReplicatedStorage:GetAttribute("3RoadsEvent") == true and isActive and not roadsAdded then
			roadsAdded = true
			if #activeFlares >= MAX_BEAMS_NORMAL then
				spawnFlare(ROLE_SIDE)
				spawnFlare(ROLE_SIDE)
			end
		end
	end)

	flareTask = task.spawn(function()
		spawnFlare(ROLE_MIDDLE)

		while isActive and #activeFlares < MAX_BEAMS_NORMAL do
			task.wait(BEAM_INTERVAL)
			if not isActive then break end
			spawnFlare(ROLE_SIDE)
			if #activeFlares == MAX_BEAMS_NORMAL then
				if ReplicatedStorage:GetAttribute("3RoadsEvent") == true and not roadsAdded then
					roadsAdded = true
					spawnFlare(ROLE_SIDE)
					spawnFlare(ROLE_SIDE)
				end
			end
		end
	end)
end

function SolarFlare.OnStop()
	if not isActive then return end
	isActive   = false
	roadsAdded = false
	if roadsListener then
		roadsListener:Disconnect()
		roadsListener = nil
	end
	ReplicatedStorage:SetAttribute("SolarFlareEvent", false)
	if flareTask then
		task.cancel(flareTask)
		flareTask = nil
	end
	cleanup()
end

function SolarFlare.IsActive(): boolean  return isActive          end
function SolarFlare.GetActiveFlares(): { any } return activeFlares end
function SolarFlare.GetBase(): BasePart? return solarFlareBase     end

return SolarFlare