local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService       = game:GetService("HttpService")
local TweenService      = game:GetService("TweenService")

local Net = require(ReplicatedStorage.Packages.Net)
local Burst = Net:RemoteEvent("EventService/Laser City/Burst")

local LaserCity = {}


local isActive   = false
local moveTask: thread? = nil
local laserPart: BasePart? = nil
local hitCooldowns: { [Model]: number } = {}


local TRAIT_NAME = "Aura Shades"
local TAG_NAME   = "LaserCityImpact"

local LASER_SPEED   = 26
local HIT_RADIUS    = 8
local HIT_COOLDOWN  = 4
local DWELL_MIN     = 0.15
local DWELL_MAX     = 0.6

local function getFloors(): { BasePart }
	local folder = workspace:FindFirstChild("Events")
	local model  = folder and folder:FindFirstChild("Laser City")
	if not model then return {} end
	local out = {}
	for _, name in ipairs({ "MapFloorLeft", "MapFloorRight" }) do
		local p = model:FindFirstChild(name)
		if p and p:IsA("BasePart") then
			table.insert(out, p)
		end
	end
	return out
end


local function decodeTraits(data: string?): { any }
	if not data then return {} end
	local ok, result = pcall(function() return HttpService:JSONDecode(data) end)
	return ok and type(result) == "table" and result or {}
end

local function hasTrait(traits: { any }, name: string): boolean
	for _, v in ipairs(traits) do
		if v == name then return true end
	end
	return false
end

local function giveTrait(animal: Model)
	local traits = decodeTraits(animal:GetAttribute("Traits"))
	if hasTrait(traits, TRAIT_NAME) then return false end
	table.insert(traits, TRAIT_NAME)
	animal:SetAttribute("Traits", HttpService:JSONEncode(traits))
	return true
end


local function pickRandomPoint(): Vector3
	local floors = getFloors()
	if #floors == 0 then
		return Vector3.new(0, 0, 0)
	end
	local floor = floors[math.random(1, #floors)]
	local s, p  = floor.Size, floor.Position
	local halfX = s.X / 2
	local halfZ = s.Z / 2
	local x = p.X + (math.random() * 2 - 1) * halfX
	local z = p.Z + (math.random() * 2 - 1) * halfZ
	return Vector3.new(x, p.Y + s.Y / 2, z)
end


local function applyHits(pos: Vector3)
	local now = tick()
	for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
		if not animal.PrimaryPart then continue end
		if hitCooldowns[animal] and now < hitCooldowns[animal] then continue end
		if (animal.PrimaryPart.Position - pos).Magnitude <= HIT_RADIUS then
			if giveTrait(animal) then
				hitCooldowns[animal] = now + HIT_COOLDOWN
				Burst:FireAllClients(animal.Name)
			end
		end
	end
end


local function moveLaser()
	moveTask = task.spawn(function()
		while isActive and laserPart and laserPart.Parent do
			local target   = pickRandomPoint()
			local start    = laserPart.Position
			local distance = (target - start).Magnitude
			local duration = math.max(distance / LASER_SPEED, 0.001)

			local tween = TweenService:Create(
				laserPart,
				TweenInfo.new(duration, Enum.EasingStyle.Linear),
				{ Position = target }
			)
			tween:Play()

			local step    = 0.05
			local elapsed = 0
			while elapsed < duration do
				if not isActive or not laserPart or not laserPart.Parent then break end
				applyHits(laserPart.Position)
				task.wait(step)
				elapsed += step
			end

			if isActive and laserPart and laserPart.Parent then
				applyHits(laserPart.Position)
				task.wait(DWELL_MIN + math.random() * (DWELL_MAX - DWELL_MIN))
			end
		end
	end)
end


function LaserCity.OnStart()
	if isActive then return end
	isActive     = true
	hitCooldowns = {}
	ReplicatedStorage:SetAttribute("LaserCityEvent", true)

	local part = Instance.new("Part")
	part.Name         = "LaserCityImpact"
	part.Size         = Vector3.new(1, 1, 1)
	part.Transparency = 1
	part.Anchored     = true
	part.CanCollide   = false
	part.CanQuery     = false
	part.CanTouch     = false
	part.Massless     = true
	part.Position     = pickRandomPoint()
	CollectionService:AddTag(part, TAG_NAME)
	part.Parent       = workspace.Events:FindFirstChild("Laser City") or workspace
	laserPart = part

	moveLaser()
end

function LaserCity.OnStop()
	if not isActive then return end
	isActive = false
	ReplicatedStorage:SetAttribute("LaserCityEvent", nil)

	if moveTask then
		task.cancel(moveTask)
		moveTask = nil
	end
	if laserPart then
		laserPart:Destroy()
		laserPart = nil
	end
	hitCooldowns = {}
end

function LaserCity.OnLoad() end

function LaserCity.IsActive(): boolean return isActive end

return LaserCity
