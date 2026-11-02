local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local Net = require(ReplicatedStorage.Packages.Net)
local Animals = require(ReplicatedStorage.Datas.Animals)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local PlotService = require(ServerScriptService.Services.PlotService)

local SpawnGear = Net:RemoteEvent("PoleGameService/SpawnGear")
local DestroyGear = Net:RemoteEvent("PoleGameService/DestroyGear")
local PickGear = Net:RemoteEvent("PoleGameService/PickGear")
local Burst = Net:RemoteEvent("PoleGameService/Burst")
local Blink = Net:RemoteEvent("PoleGameService/Blink")

local Controller = ReplicatedStorage.Controllers.PoleGameController
local GearVisuals = Controller:WaitForChild("GearVisuals")
local PoleTemplate = script:WaitForChild("Pole")
local ItemsFolder = ReplicatedStorage:WaitForChild("Items")

local RayParams = RaycastParams.new()
RayParams.FilterType = Enum.RaycastFilterType.Include
RayParams.FilterDescendantsInstances = { Workspace:FindFirstChild("Map"), Workspace:FindFirstChild("Plots") }

local CONFIG = {
	DropHeight = 55,
	DropDuration = 2.3,
	AutoDespawn = 60,
	MaxGears = 12,
	SpawnDelay = {1, 1},
	DropRadius = {13, 23},
	MaxAcceptableGroundY = 20,
}

local POLE_POS = Vector3.new(-438.81, -10.589, -70.483)
local POLE_COMPENSATION_Y = 37.411

local CUSTOM_ANIMALS = {
	"Rang Ring Bus",
	"Pakrahmatmatina"
}

local PoleGameService = {
	Name = "Pole",
	Running = false,
}

local ActiveGears = {}
local GearPos = {}
local GearCounter = 0
local CurrentPole = nil
local PoleCenter = nil
local GiftPrompts = {}

local function CustomAnimalSpawnOnQueue(position: Vector3, player: Player)
	local animalName = CUSTOM_ANIMALS[math.random(#CUSTOM_ANIMALS)]
	local AnimalData = Animals[animalName]

	if not AnimalData then
		warn(string.format("[PoleGame] Cannot spawn animal: Data for '%s' not found.", animalName))
		return
	end

	local Plot = PlotService:GetPlotOfPlayer(player)
	if not Plot then
		warn(string.format("[PoleGame] Player %s does not have a plot.", player.Name))
		return
	end

	local offset = Vector3.new(math.random(-2, 2), 0, math.random(-2, 2))
	local spawnPosHorizontal = position + offset
	local startPosHigh = Vector3.new(spawnPosHorizontal.X, position.Y + CONFIG.DropHeight, spawnPosHorizontal.Z)

	local SpawnMarker = Instance.new("Part")
	SpawnMarker.Name = "AnimalSpawnMarker"
	SpawnMarker.Anchored = true
	SpawnMarker.CanCollide = false
	SpawnMarker.Transparency = 1
	SpawnMarker.Size = Vector3.new(1, 1, 1)
	SpawnMarker.CFrame = CFrame.new(startPosHigh)
	SpawnMarker.Parent = Workspace

	local customSpawnConfig = {
		Start = SpawnMarker,
		End = Plot.AnimalTarget,
		Owner = player
	}

	AnimalService:CustomAnimalSpawnOnQueue(AnimalData, nil, nil, nil, customSpawnConfig, nil)

	task.wait(0.1)
	SpawnMarker:Destroy()
end

local function spawnPole()
	if CurrentPole then
		CurrentPole:Destroy()
	end

	local pole = PoleTemplate:Clone()
	pole.Name = "Pole"
	pole.Parent = Workspace

	local compensatedPos = POLE_POS + Vector3.new(0, POLE_COMPENSATION_Y, 0)
	pole:SetPrimaryPartCFrame(CFrame.new(compensatedPos))

	for _, part in pole:GetDescendants() do
		if part:IsA("BasePart") then
			part.Anchored = true
		end
	end

	CurrentPole = pole
	PoleCenter = POLE_POS

	GiftPrompts = {}
	for _, prompt in pole:GetDescendants() do
		if prompt:IsA("ProximityPrompt") and prompt.Parent.Name == "Studs" then
			table.insert(GiftPrompts, prompt)
			prompt.Triggered:Connect(function(player)
				PoleGameService.OnGiftTriggered(player, prompt)
			end)
		end
	end
end

local function spawnGear(fixedPos: Vector3)
	if #ActiveGears >= CONFIG.MaxGears or not PoleCenter then return end

	local visualNames = {}
	for _, v in GearVisuals:GetChildren() do
		if v.Name ~= "Burst" then
			table.insert(visualNames, v.Name)
		end
	end

	if #visualNames == 0 then
		warn("[PoleGame] No gear visuals available!")
		return
	end

	local name = visualNames[math.random(#visualNames)]
	GearCounter += 1
	local id = name .. "*" .. GearCounter

	local rayOrigin = Vector3.new(fixedPos.X, fixedPos.Y + CONFIG.DropHeight, fixedPos.Z)
	local rayResult = Workspace:Raycast(rayOrigin, Vector3.new(0, -(CONFIG.DropHeight + 10), 0), RayParams)

	local groundY = rayResult and rayResult.Position.Y or PoleCenter.Y
	local groundPos = Vector3.new(fixedPos.X, groundY + 3, fixedPos.Z)
	local startPos = Vector3.new(fixedPos.X, fixedPos.Y + CONFIG.DropHeight, fixedPos.Z)

	SpawnGear:FireAllClients(id, name, startPos, groundPos, Workspace:GetServerTimeNow(), CONFIG.DropDuration)
	GearPos[id] = groundPos
	table.insert(ActiveGears, id)

	task.delay(CONFIG.AutoDespawn, function()
		local index = table.find(ActiveGears, id)
		if index then
			table.remove(ActiveGears, index)
			GearPos[id] = nil
			DestroyGear:FireAllClients(id)
		end
	end)
end

function PoleGameService.OnGiftTriggered(player: Player, prompt: ProximityPrompt)
	if not PoleGameService.Running then return end

	Blink:FireClient(player)
	prompt.Enabled = false

	local giftAssembly = prompt.Parent and prompt.Parent.Parent
	local burstPos = giftAssembly and giftAssembly.PrimaryPart and giftAssembly.PrimaryPart.Position

	if burstPos then
		Burst:FireAllClients(burstPos)
	else
		Burst:FireAllClients(PoleCenter + Vector3.new(0, 18, 0))
		warn("[PoleGame] Burst fallback to pole center.")
	end

	if giftAssembly then
		for _, part in giftAssembly:GetDescendants() do
			if part:IsA("BasePart") then
				part.Transparency = 1
				part.CanCollide = false
			end
		end
	end

	if burstPos then
		spawnGear(burstPos)
		CustomAnimalSpawnOnQueue(burstPos, player)
	end

	for i, p in ipairs(GiftPrompts) do
		if p == prompt then
			table.remove(GiftPrompts, i)
			break
		end
	end

	prompt:Destroy()
end

function PoleGameService.OnStart()
	if PoleGameService.Running then return end

	PoleGameService.Running = true
	ActiveGears = {}
	GearPos = {}
	GearCounter = 0

	spawnPole()
end

function PoleGameService.OnStop()
	if not PoleGameService.Running then return end

	PoleGameService.Running = false

	for _, prompt in GiftPrompts do
		if prompt and prompt.Parent then
			prompt:Destroy()
		end
	end
	GiftPrompts = {}

	if CurrentPole then
		CurrentPole:Destroy()
		CurrentPole = nil
	end
	PoleCenter = nil
end

PickGear.OnServerEvent:Connect(function(player: Player, gearId: string)
	local index = table.find(ActiveGears, gearId)
	if not index then return end

	table.remove(ActiveGears, index)
	local pos = GearPos[gearId]
	GearPos[gearId] = nil

	if pos then
		Burst:FireAllClients(pos)
	end

	local gearName = gearId:match("^(.-)*")
	local toolTemplate = ItemsFolder:FindFirstChild(gearName)

	if toolTemplate and toolTemplate:IsA("Tool") then
		local tool = toolTemplate:Clone()
		tool.Parent = player:FindFirstChild("Backpack") or player:FindFirstChild("StarterGear")
	end

	DestroyGear:FireAllClients(gearId)
end)

return PoleGameService