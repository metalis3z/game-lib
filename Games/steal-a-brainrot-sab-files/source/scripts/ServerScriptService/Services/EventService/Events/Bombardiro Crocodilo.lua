--!native
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)

local SpawnBomb = Net:RemoteEvent("EventService/Bombardiro Crocodilo/SpawnBomb")
local Explode = Net:RemoteEvent("EventService/Bombardiro Crocodilo/Explode")

local BombardiroCrocodilo = {}
local IsActive = false
local eventTrove = nil
local Planes = {}

local SKY_HEIGHT_OFFSET = 200
local PLANE_SPEED = 25
local NUM_PLANES = 6
local BOMB_DROP_MIN = 5
local BOMB_DROP_MAX = 10
local BOUNCE_HEIGHT = 2
local BLAST_RADIUS = 15
local DRY_SPELL_THRESHOLD = 25

local LastTraitAppliedTime = 0

local WanderFolder = workspace:WaitForChild("Events"):WaitForChild("Wander")

local function GetRandomWanderPosition(): Vector3
	local WanderParts = WanderFolder:GetChildren()
	if #WanderParts == 0 then return Vector3.new(0, SKY_HEIGHT_OFFSET, 0) end
	local RandomPart = WanderParts[math.random(1, #WanderParts)]
	local Size, Pos = RandomPart.Size, RandomPart.Position
	local X = Pos.X + (math.random() - 0.5) * Size.X
	local Z = Pos.Z + (math.random() - 0.5) * Size.Z
	local Y = Pos.Y + SKY_HEIGHT_OFFSET
	return Vector3.new(X, Y, Z)
end

local function GetGroundY(): number
	local WanderParts = WanderFolder:GetChildren()
	if #WanderParts == 0 then return 0 end
	local P = WanderParts[math.random(1, #WanderParts)]
	return P.Position.Y + P.Size.Y / 2
end

local function CreatePlaneHitbox(): BasePart
	local Plane = Instance.new("Part")
	Plane.Name = HttpService:GenerateGUID(false)
	Plane.Size = Vector3.new(10, 5, 15)
	Plane.Transparency = 1
	Plane.CanCollide = false
	Plane.Anchored = true
	Plane.CFrame = CFrame.new(GetRandomWanderPosition())
	CollectionService:AddTag(Plane, "BombardiroPlane")
	Plane.Parent = workspace
	return Plane
end

local function TweenPlaneToPosition(Plane: BasePart, Pos: Vector3, Bounce: boolean)
	if not Plane then return end
	local StartPos = Plane.Position
	local Dir = (Pos - StartPos).Unit
	local Dist = (Pos - StartPos).Magnitude
	local Dur = Dist / PLANE_SPEED
	if Bounce then
		task.spawn(function()
			local T0 = os.clock()
			while os.clock() - T0 < Dur and Plane.Parent and IsActive do
				local P = (os.clock() - T0) / Dur
				local X = StartPos.X + (Pos.X - StartPos.X) * P
				local Y = StartPos.Y + (Pos.Y - StartPos.Y) * P
				local Z = StartPos.Z + (Pos.Z - StartPos.Z) * P
				local BO = math.sin(P * math.pi * 4) * BOUNCE_HEIGHT * (1 - P * 0.3)
				local NX = StartPos.X + (Pos.X - StartPos.X) * math.min(P + 0.01, 1)
				local NZ = StartPos.Z + (Pos.Z - StartPos.Z) * math.min(P + 0.01, 1)
				Plane.CFrame = CFrame.lookAt(Vector3.new(X, Y + BO, Z), Vector3.new(NX, Y + BO, NZ))
				task.wait()
			end
			if Plane.Parent and IsActive then
				Plane.CFrame = CFrame.lookAt(Pos, Pos + Dir)
			end
		end)
	else
		local Tween = TweenService:Create(Plane, TweenInfo.new(Dur, Enum.EasingStyle.Linear), {CFrame = CFrame.lookAt(Pos, Pos + Dir)})
		Tween:Play()
	end
	task.wait(Dur)
end

local function FlyPlane(Plane: BasePart)
	while IsActive and Plane.Parent do
		TweenPlaneToPosition(Plane, GetRandomWanderPosition(), true)
		task.wait(0.5)
	end
end

local function CalculateFallTime(fromY: number, toY: number): number
	local dist = math.max(fromY - toY, 0)
	local gravity = workspace.Gravity
	return math.sqrt(2 * dist / gravity)
end

local function HasExplosiveTrait(animal: Model): boolean
	local TraitsJson = animal:GetAttribute("Traits")
	if not TraitsJson then return false end
	local Success, Decoded = pcall(HttpService.JSONDecode, HttpService, TraitsJson)
	if Success and type(Decoded) == "table" then
		for _, T in ipairs(Decoded) do
			if T == "Explosive" then return true end
		end
	end
	return false
end

local function ApplyExplosiveToAnimalsInRadius(explosionPos: Vector3): boolean
	local Animals = CollectionService:GetTagged("Animal")
	local hitAny = false
	for _, Animal in ipairs(Animals) do
		if Animal.PrimaryPart and Animal.Parent then
			local AnimalPos = Animal.PrimaryPart.Position
			local Distance = (Vector3.new(AnimalPos.X, 0, AnimalPos.Z) - Vector3.new(explosionPos.X, 0, explosionPos.Z)).Magnitude

			if Distance <= BLAST_RADIUS then
				if not HasExplosiveTrait(Animal) then
					local Traits = {}
					local TJ = Animal:GetAttribute("Traits")
					if TJ then
						local Success, Decoded = pcall(HttpService.JSONDecode, HttpService, TJ)
						if Success and type(Decoded) == "table" then Traits = Decoded end
					end
					table.insert(Traits, "Explosive")
					Animal:SetAttribute("Traits", HttpService:JSONEncode(Traits))
					hitAny = true
				end
			end
		end
	end
	return hitAny
end

local function FindValidAnimalTarget(): Model?
	local Animals = CollectionService:GetTagged("Animal")
	local Candidates = {}
	for _, Animal in ipairs(Animals) do
		if Animal.PrimaryPart and Animal.Parent and not HasExplosiveTrait(Animal) then
			table.insert(Candidates, Animal)
		end
	end
	if #Candidates == 0 then return nil end
	return Candidates[math.random(1, #Candidates)]
end

local function GetDropPositionUnderPlane(Plane: BasePart): Vector3
	local planePos = Plane.Position
	return Vector3.new(planePos.X, planePos.Y - (Plane.Size.Y / 2) - 1, planePos.Z)
end

local function IsDrySpell(): boolean
	return (os.clock() - LastTraitAppliedTime) >= DRY_SPELL_THRESHOLD
end

local function DropBomb(Plane: BasePart)
	while IsActive and Plane.Parent do
		task.wait(math.random(BOMB_DROP_MIN, BOMB_DROP_MAX))
		if not IsActive then break end

		if IsDrySpell() then
			local TargetAnimal = FindValidAnimalTarget()
			if TargetAnimal and TargetAnimal.PrimaryPart then
				local AnimalPos = TargetAnimal.PrimaryPart.Position
				local AboveAnimal = Vector3.new(AnimalPos.X, Plane.Position.Y, AnimalPos.Z)
				TweenPlaneToPosition(Plane, AboveAnimal, true)
				if not IsActive or not Plane.Parent then break end
			end
		end

		local DropPos = GetDropPositionUnderPlane(Plane)
		local GroundY = GetGroundY()

		local ImpactPos = Vector3.new(DropPos.X, GroundY, DropPos.Z)
		local fallTime = CalculateFallTime(DropPos.Y, GroundY)

		SpawnBomb:FireAllClients(Plane.Name, DropPos, ImpactPos)
		task.wait(fallTime)
		Explode:FireAllClients(ImpactPos)

		if eventTrove then
			local delayTrove = eventTrove:Extend()
			delayTrove:Add(task.delay(0.1, function()
				local hit = ApplyExplosiveToAnimalsInRadius(ImpactPos)
				if hit then
					LastTraitAppliedTime = os.clock()
				end
				delayTrove:Clean()
			end))
		end
	end
end

local function SpawnPlane()
	local planeTrove = eventTrove:Extend()

	local Plane = CreatePlaneHitbox()
	planeTrove:Add(Plane)
	Planes[Plane.Name] = Plane

	planeTrove:Add(task.spawn(function() FlyPlane(Plane) end))
	planeTrove:Add(task.spawn(function() DropBomb(Plane) end))

	Plane:SetAttribute("_planeTroveId", true)
	Planes[Plane.Name .. "_trove"] = planeTrove
end

local extraspawned = false

function BombardiroCrocodilo.OnStart()
	if IsActive then return end
	IsActive = true
	eventTrove = Trove.new()
	LastTraitAppliedTime = os.clock()

	ReplicatedStorage:SetAttribute("BombardiroCrocodiloEvent", true)

	local is3Roads = ReplicatedStorage:GetAttribute("3RoadsEvent") == true
	extraspawned = is3Roads

	local maxAllowed = is3Roads and (NUM_PLANES * 3) or NUM_PLANES

	eventTrove:Connect(ReplicatedStorage:GetAttributeChangedSignal("3RoadsEvent"), function()
		local now3Roads = ReplicatedStorage:GetAttribute("3RoadsEvent")
		if IsActive and now3Roads and not extraspawned then
			extraspawned = true
			maxAllowed = NUM_PLANES * 3
			for i = 1, (NUM_PLANES * 2) do
				if not IsActive then break end
				SpawnPlane()
				task.wait(0.2)
			end
		end
	end)

	for i = 1, maxAllowed do
		if not IsActive then break end
		SpawnPlane()
		task.wait(is3Roads and 0.2 or 0.5)
	end

	local currentPlaneIds = {}
	for id, val in pairs(Planes) do
		if typeof(val) == "Instance" then
			table.insert(currentPlaneIds, id)
		end
	end

	if #currentPlaneIds > maxAllowed then
		local overflow = #currentPlaneIds - maxAllowed
		for i = 1, overflow do
			local idToKill = currentPlaneIds[i]
			local troveKey = idToKill .. "_trove"
			local planeTrove = Planes[troveKey]

			if planeTrove then
				planeTrove:Clean()
				Planes[troveKey] = nil
			end

			Planes[idToKill] = nil
		end
	end
end

function BombardiroCrocodilo.OnStop()
	if not IsActive then return end
	IsActive = false
	ReplicatedStorage:SetAttribute("BombardiroCrocodiloEvent", false)

	if eventTrove then
		eventTrove:Clean()
		eventTrove = nil
	end

	Planes = {}
end

return BombardiroCrocodilo