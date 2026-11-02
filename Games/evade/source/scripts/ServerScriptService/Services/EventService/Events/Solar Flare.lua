--!strict

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
local hitCooldowns = {}

local MapFloor = workspace.Events.Brazil.MapFloor
local FullMapFloor = workspace.Events["Solar Flare"]:FindFirstChild("FullMapFloor")

local BEAM_SPEED = 25
local MIN_BEAMS = 1
local MAX_BEAMS = 6
local HIT_COOLDOWN = 30
local MOVEMENT_THRESHOLD = 1

local function getFloor(): BasePart
	return FullMapFloor or MapFloor
end

local function getRandomPosition(): Vector3
	local floor = getFloor()
	local s, p = floor.Size, floor.Position
	return Vector3.new(
		p.X + math.random(-s.X / 2, s.X / 2),
		p.Y + s.Y / 2,
		p.Z + math.random(-s.Z / 2, s.Z / 2)
	)
end

local function decodeTraits(data: string?): { any }
	if not data then return {} end
	local ok, result = pcall(function()
		return HttpService:JSONDecode(data)
	end)
	return ok and type(result) == "table" and result or {}
end

local function encodeTraits(traits: { any }): string
	return HttpService:JSONEncode(traits)
end

local function hasTrait(traits: { any }, name: string): boolean
	for _, v in ipairs(traits) do
		if v == name then
			return true
		end
	end
	return false
end

local function addTrait(animal: Model, name: string, pos: Vector3)
	local d = (animal.PrimaryPart.Position - pos).Magnitude
	if d > 8 then return end
	local traits = decodeTraits(animal:GetAttribute("Traits"))
	if hasTrait(traits, name) then return end
	table.insert(traits, name)
	animal:SetAttribute("Traits", encodeTraits(traits))
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

local function createHitbox(i: number): BasePart
	local template = ReplicatedStorage.Models.Events["Solar Flare"].SolarFlareBeam.Hitbox
	local hitbox = template:Clone()
	hitbox.Anchored = true
	hitbox.CanCollide = false
	hitbox.Position = Vector3.new(-411.132, 72.563, 60.17)
	hitbox:SetAttribute("LastPosition", hitbox.Position)
	CollectionService:AddTag(hitbox, "SolarFlareHitbox")
	hitbox.Parent = workspace.Events["Solar Flare"]
	return hitbox
end

local function tweenToTarget(hitbox: BasePart, target: Vector3)
	local distance = (hitbox.Position - target).Magnitude
	local duration = distance / BEAM_SPEED
	local tween = TweenService:Create(hitbox, TweenInfo.new(duration, Enum.EasingStyle.Linear), { Position = target })
	tween:Play()
	return tween, duration
end

local function moveBeam(hitbox: BasePart)
	task.spawn(function()
		while isActive and hitbox.Parent do
			local target = getRandomPosition()
			local tween, duration = tweenToTarget(hitbox, target)
			local step = 0.1
			local loops = math.ceil(duration / step)
			for _ = 1, loops do
				if not isActive or not hitbox.Parent then break end
				local pos = hitbox.Position
				for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
					if animal.PrimaryPart then
						addTrait(animal, "Fire", pos)
					end
				end
				handlePlayerHit(hitbox)
				hitbox:SetAttribute("LastPosition", pos)
				task.wait(step)
			end
		end
		if hitbox and hitbox.Parent then
			hitbox:Destroy()
			for i, flare in ipairs(activeFlares) do
				if flare.hitbox == hitbox then
					table.remove(activeFlares, i)
					break
				end
			end
		end
	end)
end

local function cleanup()
	for _, f in ipairs(activeFlares) do
		if f.hitbox and f.hitbox.Parent then
			f.hitbox:Destroy()
		end
	end
	activeFlares = {}
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
	isActive = true
	ReplicatedStorage:SetAttribute("SolarFlareEvent", true)
	hitCooldowns = {}
	local beamCount = math.random(MIN_BEAMS, MAX_BEAMS)
	solarFlareBase = ReplicatedStorage.Models.Events["Solar Flare"].SolarFlareBeam.BeamEnd:Clone()
	solarFlareBase.Position = Vector3.new(-411.132, 72.563, 60.17)
	solarFlareBase.Name = "SolarFlareBase"
	CollectionService:AddTag(solarFlareBase, "SolarFlareBase")
	solarFlareBase:SetAttribute("NumBeams", beamCount)
	solarFlareBase.Parent = workspace.Events["Solar Flare"]
	flareTask = task.spawn(function()
		for i = 1, beamCount do
			if not isActive then break end
			local hitbox = createHitbox(i)
			table.insert(activeFlares, { hitbox = hitbox, position = hitbox.Position })
			moveBeam(hitbox)
			task.wait(math.random(1, 3))
		end
	end)
end

function SolarFlare.OnStop()
	if not isActive then return end
	isActive = false
	ReplicatedStorage:SetAttribute("SolarFlareEvent", false)
	if flareTask then
		task.cancel(flareTask)
		flareTask = nil
	end
	cleanup()
end

function SolarFlare.IsActive(): boolean
	return isActive
end

function SolarFlare.GetActiveFlares(): { any }
	return activeFlares
end

function SolarFlare.GetBase(): BasePart?
	return solarFlareBase
end

return SolarFlare
