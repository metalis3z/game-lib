--!native

local Bubblegum = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local NotificationService = require(ServerScriptService.Services.NotificationService)
local SoundService = require(ServerScriptService.Services.SoundService)
local Net = require(ReplicatedStorage.Packages.Net)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)

local RollAnimation = Net:RemoteEvent("EventService/Bubblegum/RollAnimation")
local EmitBurst = Net:RemoteEvent("EventService/Bubblegum/EmitBurst")

local DETECTION_RADIUS = 3
local DETECTION_INTERVAL = 0.5
local COOLDOWN_MIN = 10 
local COOLDOWN_MAX = 20 
local PROCESS_CLEANUP_DELAY = 5
local HIDDEN_POSITION = Vector3.new(0, 100000, 0)
local Y_OFFSET = 1.5 

local IsActive = false
local DetectionLoop: thread? = nil
local CooldownUntil = 0 
local Machine2And3Positioned = false

local Machine = workspace.Events.Bubblegum.Machine
local Machine2 = workspace.Events.Bubblegum.Machine2
local Machine3 = workspace.Events.Bubblegum.Machine3

local MACHINE_POSITIONS = {
	Machine1 = {Position = Vector3.new(-389.653, -0.416, -47.629), Rotation = -90},
	Machine2 = {Position = Vector3.new(-412.653, -0.416, -47.629), Rotation = -90},
	Machine3 = {Position = Vector3.new(-366.653, -0.416, -47.629), Rotation = -90}
}

local MachineStatus = {
	[Machine] = {IsBusy = false},
	[Machine2] = {IsBusy = false},
	[Machine3] = {IsBusy = false},
}

local function DecodeTraits(json: string?): {string}
	if not json then
		return {}
	end
	local s, data = pcall(HttpService.JSONDecode, HttpService, json)
	if s and typeof(data) == "table" then
		return data :: {string}
	end
	return {}
end

local function EncodeTraits(tbl: {string}): string
	local s, data = pcall(HttpService.JSONEncode, HttpService, tbl)
	if s and typeof(data) == "string" then
		return data
	end
	return "[]"
end

local function HasTrait(traits: {string}, name: string): boolean
	for _, v in traits do
		if v == name then
			return true
		end
	end
	return false
end

local function AddTrait(Animal: Instance, name: string)
	local traits = DecodeTraits(Animal:GetAttribute("Traits"))
	if not HasTrait(traits, name) then
		table.insert(traits, name)
		Animal:SetAttribute("Traits", EncodeTraits(traits))
	end
end

local function MoveToTarget(Part: BasePart, Target: CFrame, Duration: number)
	local tween = TweenService:Create(Part, TweenInfo.new(Duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {CFrame = Target})
	tween:Play()
	tween.Completed:Wait()
end

local function CooldownRandom(minTime: number, maxTime: number)
	CooldownUntil = os.clock() + math.random(minTime, maxTime)
end

local function NotifyAll(msg: string, duration: number, sound: string)
	for _, p in Players:GetPlayers() do
		task.spawn(function()
			pcall(function()
				NotificationService.Notify(p, msg, duration, sound)
			end)
		end)
	end
end

local function Is3RoadsActive(): boolean
	return ReplicatedStorage:GetAttribute("3RoadsEvent") == true
end

local function PositionMachine2And3()
	if not IsActive then return end
	if Machine2And3Positioned then return end

	local m2Pos = MACHINE_POSITIONS.Machine2.Position
	local m2Rot = math.rad(MACHINE_POSITIONS.Machine2.Rotation)
	Machine2:PivotTo(
		CFrame.new(m2Pos) * CFrame.Angles(0, m2Rot, 0)
	)

	local m3Pos = MACHINE_POSITIONS.Machine3.Position
	local m3Rot = math.rad(MACHINE_POSITIONS.Machine3.Rotation)
	Machine3:PivotTo(
		CFrame.new(m3Pos) * CFrame.Angles(0, m3Rot, 0)
	)

	Machine2And3Positioned = true
end

local function HideMachine2And3()
	if not IsActive then return end
	if not Machine2And3Positioned then return end

	Machine2:PivotTo(CFrame.new(HIDDEN_POSITION))
	Machine3:PivotTo(CFrame.new(HIDDEN_POSITION))

	Machine2And3Positioned = false
end

local function GetAllActiveMachineData()
	local machines = {
		{machine = Machine, goal = Machine:FindFirstChild("Goal"), inMachine = Machine:FindFirstChild("InMachine")},
	}

	if Is3RoadsActive() and Machine2And3Positioned then
		table.insert(machines, {machine = Machine2, goal = Machine2:FindFirstChild("Goal"), inMachine = Machine2:FindFirstChild("InMachine")})
		table.insert(machines, {machine = Machine3, goal = Machine3:FindFirstChild("Goal"), inMachine = Machine3:FindFirstChild("InMachine")})
	end

	local activeData = {}
	for _, data in machines do
		if data.goal and data.inMachine and MachineStatus[data.machine] then
			data.IsBusy = MachineStatus[data.machine].IsBusy
			table.insert(activeData, data)
		end
	end

	return activeData
end

local function ProcessAnimal(Animal: Model, TargetMachine: Model, Goal: BasePart, InMachine: BasePart)
	if MachineStatus[TargetMachine] then
		MachineStatus[TargetMachine].IsBusy = true
	else
		return
	end

	local Primary = Animal:FindFirstChild("PrimaryPart") or Animal.PrimaryPart
	if not Primary or not SharedEventUtils.isPointInCarpet(Primary.Position) then
		MachineStatus[TargetMachine].IsBusy = false
		return
	end

	if not Primary:IsA("BasePart") then
		MachineStatus[TargetMachine].IsBusy = false
		return
	end

	local animalHeightOffset = Primary.Size.Y / 2
	if animalHeightOffset < Y_OFFSET then
		animalHeightOffset = Y_OFFSET
	end

	local traits = DecodeTraits(Animal:GetAttribute("Traits"))
	if HasTrait(traits, "Bubblegum") then
		MachineStatus[TargetMachine].IsBusy = false
		return
	end

	local success = pcall(function()
		Animal:SetAttribute("ForceIdle", true)

		task.wait(1)

		pcall(function()
			RollAnimation:FireAllClients(TargetMachine)
		end)
		local machinePosition = InMachine.Position
		SoundService:PlayAllAt("Sounds.Sfx.Bubblegum Machine.Pickup", machinePosition)
		SoundService:PlayAllAt("Sounds.Sfx.Bubblegum Machine.Crank", machinePosition)

		local InMachineCFrame = InMachine.CFrame + Vector3.new(0, animalHeightOffset, 0)
		MoveToTarget(Primary, InMachineCFrame, 1.5)

		AddTrait(Animal, "Bubblegum")
		SoundService:PlayAllAt("Sounds.Sfx.Bubblegum Machine.Apply", machinePosition)
		SoundService:PlayAllAt("Sounds.Sfx.Bubblegum Machine.ApplyBrainrot", machinePosition)

		pcall(function()
			EmitBurst:FireAllClients(InMachine)
		end)

		task.wait(3)

		local GoalCFrame = Goal.CFrame + Vector3.new(0, animalHeightOffset, 0)
		MoveToTarget(Primary, GoalCFrame - Vector3.new(0, 1.5, 0), 1.5)

		Animal:SetAttribute("ForceIdle", false)
		Animal:SetAttribute("ForceIdle", nil)
	end)

	if not success then
		warn("Failed to process animal at machine:", TargetMachine.Name, Animal:GetFullName())
		pcall(function()
			Animal:SetAttribute("ForceIdle", nil)
		end)
	end

	MachineStatus[TargetMachine].IsBusy = false
	CooldownRandom(COOLDOWN_MIN, COOLDOWN_MAX)
end

function Bubblegum.StartDetection()
	local processed: {[Instance]: boolean} = {}

	DetectionLoop = task.spawn(function()
		while IsActive do
			task.wait(DETECTION_INTERVAL)
			if os.clock() < CooldownUntil then
				continue
			end

			local availableMachines = GetAllActiveMachineData()
			if #availableMachines == 0 then
				continue
			end

			local animals = CollectionService:GetTagged("Animal")

			for _, machineData in availableMachines do

				if machineData.IsBusy then
					continue
				end

				local NearestAnimal = nil
				local NearestDistance = DETECTION_RADIUS

				for _, Animal in animals do
					if not Animal:IsDescendantOf(workspace) then
						processed[Animal] = nil
						continue
					end

					local Primary = Animal:FindFirstChild("PrimaryPart") or Animal.PrimaryPart
					if Primary and Primary:IsA("BasePart") and not processed[Animal] and not HasTrait(DecodeTraits(Animal:GetAttribute("Traits")), "Bubblegum") then

						local distance = (Primary.Position - machineData.goal.Position).Magnitude

						if distance < NearestDistance then
							NearestDistance = distance
							NearestAnimal = Animal
						end
					end
				end

				if NearestAnimal then
					processed[NearestAnimal] = true 

					task.spawn(function()
						ProcessAnimal(NearestAnimal, machineData.machine, machineData.goal, machineData.inMachine)
						task.wait(PROCESS_CLEANUP_DELAY)
						processed[NearestAnimal] = nil
					end)
				end
			end
		end
	end)
end

local function Setup3RoadsListener()
	ReplicatedStorage:GetAttributeChangedSignal("3RoadsEvent"):Connect(function()
		local is3RoadsActive = Is3RoadsActive()

		if is3RoadsActive then
			PositionMachine2And3()
		else
			HideMachine2And3()
		end
	end)
end

function Bubblegum.OnStart()
	if IsActive then
		return
	end
	IsActive = true

	for _, status in pairs(MachineStatus) do
		status.IsBusy = false
	end

	CooldownUntil = 0
	Machine2And3Positioned = false

	local m1Pos = MACHINE_POSITIONS.Machine1.Position
	local m1Rot = math.rad(MACHINE_POSITIONS.Machine1.Rotation)
	Machine:PivotTo(
		CFrame.new(m1Pos) * CFrame.Angles(0, m1Rot, 0)
	)

	if Is3RoadsActive() then
		PositionMachine2And3()
	end

	NotifyAll("<font color='#ff69af'>Bubblegum Machine</font> has been activated!", 15, "Sounds.Sfx.Success")

	local allData = GetAllActiveMachineData()
	if #allData == 0 then
		warn("Bubblegum: No machine parts (Goal/InMachine) found!")
		IsActive = false
		return
	end

	Bubblegum.StartDetection()
end

function Bubblegum.OnStop()
	if not IsActive then
		return
	end
	IsActive = false

	for _, status in pairs(MachineStatus) do
		status.IsBusy = false
	end

	CooldownUntil = 0
	Machine2And3Positioned = false

	if DetectionLoop then
		task.cancel(DetectionLoop)
		DetectionLoop = nil
	end

	Machine:PivotTo(CFrame.new(HIDDEN_POSITION))
	Machine2:PivotTo(CFrame.new(HIDDEN_POSITION))
	Machine3:PivotTo(CFrame.new(HIDDEN_POSITION))
end

function Bubblegum.IsRunning(): boolean
	return IsActive
end

function Bubblegum.IsMachineBusy(): boolean
	for _, status in pairs(MachineStatus) do
		if status.IsBusy then
			return true
		end
	end
	return false
end

function Bubblegum.GetCooldown(): number
	return math.max(0, CooldownUntil - os.clock())
end

Setup3RoadsListener()

return Bubblegum