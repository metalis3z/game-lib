local TungTungAttack = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local IsActive = false
local ScanTask

local BabiesFolder
local Babies = {}
local WanderPoints = {}
local RecentlyHit = {}

local BabyMin = 20
local BabyMax = 30

local ScanRadius = 25
local HitCooldown = 2
local TraitName = "Zombie"

local function Decode(Data)
	if not Data then
		return {}
	end

	local Success,Decoded = pcall(function()
		return HttpService:JSONDecode(Data)
	end)

	if Success and type(Decoded) == "table" then
		return Decoded
	end

	return {}
end

local function Encode(Table)
	return HttpService:JSONEncode(Table)
end

local function HasTrait(Traits,Name)
	for _,Value in ipairs(Traits) do
		if Value == Name then
			return true
		end
	end
	return false
end

local function CreateFolder()
	local Folder = Instance.new("Folder")
	Folder.Name = "BabyTungTungs"
	Folder.Parent = workspace
	return Folder
end

local function GetWanders()
	local Events = workspace:FindFirstChild("Events")
	if not Events then
		return
	end

	local EventFolder = Events:FindFirstChild("Tung Tung Attack")
	if not EventFolder then
		return
	end

	for _,Object in ipairs(EventFolder:GetChildren()) do
		if Object:IsA("BasePart") and Object.Name == "Wander" then
			table.insert(WanderPoints,Object)
		end
	end
end

local function SetupAnimations(Baby)

	local Humanoid = Baby:FindFirstChild("Humanoid")
	if not Humanoid then
		return
	end

	local Animator = Humanoid:FindFirstChild("Animator")

	if not Animator then
		Animator = Instance.new("Animator")
		Animator.Parent = Humanoid
	end

	local WalkAnimation = Baby:FindFirstChild("BabyTungWalk")
	local IdleAnimation = Baby:FindFirstChild("BabyTungIdle")

	if not WalkAnimation or not IdleAnimation then
		return
	end

	local WalkTrack = Animator:LoadAnimation(WalkAnimation)
	local IdleTrack = Animator:LoadAnimation(IdleAnimation)

	WalkTrack.Looped = true
	IdleTrack.Looped = true

	IdleTrack:Play()

	Humanoid.Running:Connect(function(Speed)

		if Speed > 0 then
			if not WalkTrack.IsPlaying then
				IdleTrack:Stop()
				WalkTrack:Play()
			end
		else
			if not IdleTrack.IsPlaying then
				WalkTrack:Stop()
				IdleTrack:Play()
			end
		end

	end)

end

local function Wander(Baby)

	local Humanoid = Baby:FindFirstChild("Humanoid")
	local Root = Baby:FindFirstChild("HumanoidRootPart")

	if not Humanoid or not Root then
		return
	end

	Humanoid.WalkSpeed = 8

	task.spawn(function()

		while IsActive and Baby.Parent do

			local Point = WanderPoints[math.random(1,#WanderPoints)]

			local Target =
				Point.Position +
				Vector3.new(
					math.random(-4,4),
					0,
					math.random(-4,4)
				)

			local Distance = (Root.Position - Target).Magnitude

			if Distance > 3 then
				Humanoid:MoveTo(Target)
				Humanoid.MoveToFinished:Wait()
			end

			task.wait(math.random(2,4))

		end

	end)

end

local function SpawnBabies()

	local BabyModel = script:FindFirstChild("BabyTungTung")
	if not BabyModel then
		return
	end

	local Count = math.random(BabyMin,BabyMax)

	for i = 1,Count do

		local Clone = BabyModel:Clone()
		Clone.Parent = BabiesFolder

		CollectionService:AddTag(Clone,"BabyTungTung")

		local Root = Clone:FindFirstChild("HumanoidRootPart")

		if Root then

			local Wander = WanderPoints[math.random(1,#WanderPoints)]

			local Position =
				Wander.Position +
				Vector3.new(0,3,0)

			Root.CFrame = CFrame.new(Position)

		end

		SetupAnimations(Clone)
		Wander(Clone)

		table.insert(Babies,Clone)

	end

end

local function ApplyZombie(Animal)

	local Traits = Decode(Animal:GetAttribute("Traits"))

	if not HasTrait(Traits,TraitName) then

		table.insert(Traits,TraitName)

		Animal:SetAttribute(
			"Traits",
			Encode(Traits)
		)

	end

end

local function Scan()

	for _,Baby in ipairs(Babies) do

		if not Baby.Parent then
			continue
		end

		local Root = Baby:FindFirstChild("HumanoidRootPart")

		if not Root then
			continue
		end

		local Parts = workspace:GetPartBoundsInBox(
			Root.CFrame,
			Vector3.new(ScanRadius,ScanRadius,ScanRadius)
		)

		local Animals = {}

		for _,Part in ipairs(Parts) do

			local Model = Part:FindFirstAncestorOfClass("Model")

			if Model and CollectionService:HasTag(Model,"Animal") then
				Animals[Model] = true
			end

		end

		for Animal in pairs(Animals) do

			local Last = RecentlyHit[Animal]

			if Last and time() - Last < HitCooldown then
				continue
			end

			if Animal:GetAttribute("Index") then
				ApplyZombie(Animal)
				RecentlyHit[Animal] = time()
			end

		end

	end

end

local function ScanLoop()

	while IsActive do
		Scan()
		task.wait(0.4)
	end

end

function TungTungAttack.OnStart()

	if IsActive then
		return
	end

	IsActive = true

	ReplicatedStorage:SetAttribute(
		"TungTungAttack",
		true
	)

	GetWanders()

	BabiesFolder = CreateFolder()

	SpawnBabies()

	ScanTask = task.spawn(ScanLoop)

end

function TungTungAttack.OnStop()

	if not IsActive then
		return
	end

	IsActive = false

	ReplicatedStorage:SetAttribute(
		"TungTungAttack",
		false
	)
	
	ReplicatedStorage:SetAttribute(
		"TungTungAttack",
		nil
	)

	if ScanTask then
		task.cancel(ScanTask)
		ScanTask = nil
	end

	if BabiesFolder then
		BabiesFolder:Destroy()
	end

	Babies = {}
	WanderPoints = {}
	RecentlyHit = {}

end

function TungTungAttack.IsActive()
	return IsActive
end

return TungTungAttack