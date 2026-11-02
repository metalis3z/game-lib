--!native
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local Net = require(ReplicatedStorage.Packages.Net)
local SpawnBomb = Net:RemoteEvent("EventService/Bombardiro Crocodilo/SpawnBomb")
local Explode = Net:RemoteEvent("EventService/Bombardiro Crocodilo/Explode")

local BombardiroCrocodilo = {}
local IsActive = false
local Planes = {}
local PlaneTasks = {}
local RecentlyTargeted = {}

local SKY_HEIGHT_OFFSET = 200
local PLANE_SPEED = 25
local NUM_PLANES = 6
local BOMB_DROP_MIN = 5
local BOMB_DROP_MAX = 10
local TARGET_CHANCE = 0.35
local BOUNCE_HEIGHT = 2
local BOUNCE_SPEED = 65

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

local function CreatePlaneHitbox(): BasePart
	local Plane = Instance.new("Part")
	Plane.Name = HttpService:GenerateGUID(false)
	Plane.Size = Vector3.new(10,5,15)
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
			local T0 = tick()
			while tick() - T0 < Dur and Plane.Parent and IsActive do
				local P = (tick() - T0)/Dur
				local X = StartPos.X + (Pos.X - StartPos.X)*P
				local Y = StartPos.Y + (Pos.Y - StartPos.Y)*P
				local Z = StartPos.Z + (Pos.Z - StartPos.Z)*P
				local BO = math.sin(P*math.pi*4)*BOUNCE_HEIGHT*(1-P*0.3)
				local NX = StartPos.X + (Pos.X-StartPos.X)*math.min(P+0.01,1)
				local NZ = StartPos.Z + (Pos.Z-StartPos.Z)*math.min(P+0.01,1)
				Plane.CFrame = CFrame.lookAt(Vector3.new(X,Y+BO,Z), Vector3.new(NX,Y+BO,NZ))
				task.wait()
			end
			if Plane.Parent and IsActive then
				Plane.CFrame = CFrame.lookAt(Pos, Pos+Dir)
			end
		end)
	else
		local Tween = TweenService:Create(Plane, TweenInfo.new(Dur, Enum.EasingStyle.Linear), {CFrame=CFrame.lookAt(Pos, Pos+Dir)})
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

local function DropBomb(Plane: BasePart)
	while IsActive and Plane.Parent do
		task.wait(math.random(BOMB_DROP_MIN,BOMB_DROP_MAX))
		if not IsActive then break end

		local TargetAnimal, DropPos = nil, nil
		if math.random() <= TARGET_CHANCE then
			local Animals = CollectionService:GetTagged("Animal")
			local Now = workspace:GetServerTimeNow()
			for Name, Last in pairs(RecentlyTargeted) do if Now-Last>15 then RecentlyTargeted[Name]=nil end end

			local Candidates = {}
			for _, A in ipairs(Animals) do
				if A.PrimaryPart then
					local IsRecent = RecentlyTargeted[A.Name] ~= nil
					local HasExplosive = false
					local TraitsJson = A:GetAttribute("Traits")
					if TraitsJson then
						local Success, Decoded = pcall(HttpService.JSONDecode, HttpService, TraitsJson)
						if Success and type(Decoded)=="table" then
							for _, T in ipairs(Decoded) do if T=="Explosive" then HasExplosive=true break end end
						end
					end
					if not IsRecent and not HasExplosive then table.insert(Candidates,A) end
				end
			end
			if #Candidates>0 then
				TargetAnimal = Candidates[math.random(1,#Candidates)]
				local PosA = TargetAnimal.PrimaryPart.Position
				DropPos = Vector3.new(PosA.X, Plane.Position.Y, PosA.Z)
				TweenPlaneToPosition(Plane, DropPos, true)
				RecentlyTargeted[TargetAnimal.Name] = workspace:GetServerTimeNow()
			end
		end

		if not DropPos then DropPos = Plane.Position end

		local WanderParts = WanderFolder:GetChildren()
		local GroundY = 0
		if #WanderParts>0 then local P=WanderParts[math.random(1,#WanderParts)] GroundY=P.Position.Y+P.Size.Y/2 end

		SpawnBomb:FireAllClients(Plane.Name, DropPos, Vector3.new(DropPos.X,GroundY,DropPos.Z))
		task.wait(2)
		Explode:FireAllClients(Vector3.new(DropPos.X,GroundY,DropPos.Z))

		if TargetAnimal then
			task.delay(0.1,function()
				if not TargetAnimal or not TargetAnimal.Parent then return end
				local Traits = {}
				local TJ = TargetAnimal:GetAttribute("Traits")
				if TJ then
					local Success, Decoded = pcall(HttpService.JSONDecode,HttpService,TJ)
					if Success and type(Decoded)=="table" then Traits=Decoded end
				end
				for _, T in ipairs(Traits) do if T=="Explosive" then return end end
				table.insert(Traits,"Explosive")
				TargetAnimal:SetAttribute("Traits",HttpService:JSONEncode(Traits))
			end)
		end
	end
end

local function SpawnPlane()
	local Plane = CreatePlaneHitbox()
	Planes[Plane.Name] = Plane
	PlaneTasks[Plane.Name] = {
		Fly = task.spawn(function() FlyPlane(Plane) end),
		Bomb = task.spawn(function() DropBomb(Plane) end)
	}
end

function BombardiroCrocodilo.OnStart()
	if IsActive then return end
	IsActive = true
	ReplicatedStorage:SetAttribute("BombardiroCrocodiloEvent", true)
	for _=1,NUM_PLANES do SpawnPlane() task.wait(0.5) end
end

function BombardiroCrocodilo.OnStop()
	if not IsActive then return end
	IsActive = false
	ReplicatedStorage:SetAttribute("BombardiroCrocodiloEvent", false)
	for _, T in pairs(PlaneTasks) do
		if T.Fly then task.cancel(T.Fly) end
		if T.Bomb then task.cancel(T.Bomb) end
	end
	for _, P in pairs(Planes) do if P then P:Destroy() end end
	PlaneTasks, Planes, RecentlyTargeted = {}, {}, {}
end

return BombardiroCrocodilo
