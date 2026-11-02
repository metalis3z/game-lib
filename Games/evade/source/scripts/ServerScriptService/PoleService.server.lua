local ReplicatedStorage = game:GetService("ReplicatedStorage")
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
local PoleTemplate = Controller:WaitForChild("Pole")
local ItemsFolder = ReplicatedStorage:WaitForChild("Items")

local RayParams = RaycastParams.new()
RayParams.FilterType = Enum.RaycastFilterType.Include
RayParams.FilterDescendantsInstances = { workspace:FindFirstChild("Map"), workspace:FindFirstChild("Plots") }

local CONFIG = {
	DropHeight = 55,
	DropDuration = 2.3,
	AutoDespawn = 60,
	MaxGears = 12,
	SpawnDelay = {1, 1},
	DropRadius = {13, 23},
	MaxAcceptableGroundY = 20,
}

local PoleGame = {
	Name = "Pole",
	Running = false,
}
local ActiveGears = {}
local GearPos = {}
local GearCounter = 0
local CurrentPole = nil
local PoleCenter = nil
local GiftPrompts = {}

local POLE_POS = Vector3.new(-438.81, -10.589, -70.483)
local POLE_COMPENSATION_Y = 37.411

local CUSTOM_ANIMALS = {
	"Rang Ring Bus",
	"Pakrahmatmatina"
}

local function spawnAnimalCustom(position, player)
	local animalName = CUSTOM_ANIMALS[math.random(#CUSTOM_ANIMALS)]
	local AnimalData = Animals[animalName]

	if not AnimalData then
		warn(string.format("[PoleGame] Cannot spawn animal: Data for '%s' not found in ReplicatedStorage.Datas.Animals.", animalName))
		return
	end

	local Plot = PlotService.getPlot(player)
	if not Plot then
		warn(string.format("[PoleGame] Player %s does not have a plot to receive the animal reward.", player.Name))
		return
	end

	local offset = Vector3.new(math.random() * 4 - 2, 0, math.random() * 4 - 2)
	local spawnPosHorizontal = position + offset

	local startY = position.Y + CONFIG.DropHeight
	local startPosHigh = Vector3.new(spawnPosHorizontal.X, startY, spawnPosHorizontal.Z)

	local SpawnMarker = Instance.new("Part")
	SpawnMarker.Name = "AnimalSpawnMarker"
	SpawnMarker.Anchored = true
	SpawnMarker.CanCollide = false
	SpawnMarker.Transparency = 1
	SpawnMarker.Size = Vector3.new(1, 1, 1)
	SpawnMarker.CFrame = CFrame.new(startPosHigh)
	SpawnMarker.Parent = workspace

	local customSpawnConfig = {
		Start = SpawnMarker,
		End = Plot.AnimalTarget,
		Owner = player
	}

	AnimalService.spawnAnimalCustom(
		AnimalData,
		nil,
		nil,
		nil,
		customSpawnConfig,
		nil
	)

	task.wait(0.1) 
	SpawnMarker:Destroy()

	print(string.format("[PoleGame] Custom animal '%s' queued to spawn high (Y=%.1f) and travel to %s's plot.", animalName, startPosHigh.Y, player.Name))
end

local function spawnPole()
	if CurrentPole then CurrentPole:Destroy() end
	local pole = PoleTemplate:Clone()
	pole.Name = "Pole"
	pole.Parent = workspace

	local compensatedPos = POLE_POS + Vector3.new(0, POLE_COMPENSATION_Y, 0)

	pole:SetPrimaryPartCFrame(CFrame.new(compensatedPos))

	for _, part in pole:GetDescendants() do
		if part:IsA("BasePart") then
			part.Anchored = true
		end
	end
	CurrentPole = pole
	PoleCenter = POLE_POS

	print("[PoleGame] Candy Pole spawned at", PoleCenter)

	GiftPrompts = {}
	for _, prompt in pole:GetDescendants() do
		if prompt:IsA("ProximityPrompt") and prompt.Parent.Name == "Studs" then
			table.insert(GiftPrompts, prompt)
			prompt.Triggered:Connect(function(player)
				PoleGame.OnGiftTriggered(player, prompt)
			end)
		end
	end
	print(string.format("[PoleGame] Connected %d Gift ProximityPrompts.", #GiftPrompts))
end

local function spawnGear(fixedPos)
	if #ActiveGears >= CONFIG.MaxGears or not PoleCenter then return end

	local list = {}
	for _, v in pairs(GearVisuals:GetChildren()) do
		if v.Name ~= "Burst" then table.insert(list, v.Name) end
	end

	if #list == 0 then
		warn("[PoleGame] Cannot spawn gear: GearVisuals list is empty!")
		return
	end

	local name = list[math.random(#list)]
	GearCounter += 1
	local id = name .. "*" .. GearCounter

	local startPos, groundPos

	if fixedPos then
		startPos = fixedPos

		local rayOrigin = Vector3.new(fixedPos.X, fixedPos.Y + CONFIG.DropHeight, fixedPos.Z)
		local ray = workspace:Raycast(rayOrigin, Vector3.new(0, -(CONFIG.DropHeight + 10), 0), RayParams)

		local rayGroundY
		if ray then
			rayGroundY = ray.Position.Y
		else
			rayGroundY = PoleCenter.Y
		end

		groundPos = Vector3.new(fixedPos.X, rayGroundY + 3, fixedPos.Z)

	else
		warn("[PoleGame] Error: spawnGear called without fixed position! Falling back is not supported.")
		return
	end

	if not startPos or not groundPos then
		warn("[PoleGame] Cannot spawn gear: Invalid start or ground position calculated!")
		return
	end

	SpawnGear:FireAllClients(id, name, startPos, groundPos, workspace:GetServerTimeNow(), CONFIG.DropDuration)
	GearPos[id] = groundPos
	table.insert(ActiveGears, id)

	task.delay(CONFIG.AutoDespawn, function()
		if table.find(ActiveGears, id) then
			table.remove(ActiveGears, table.find(ActiveGears, id))
			GearPos[id] = nil
			DestroyGear:FireAllClients(id)
			print(string.format("[PoleGame] Auto-despawned gear: %s", id))
		end
	end)
	print(string.format("[PoleGame] Spawned gear: %s STARTING at gift's Y=%.1f, dropping to ground Y=%.1f", id, startPos.Y, groundPos.Y))
end

function PoleGame.OnGiftTriggered(player, prompt)
	if not PoleGame.Running then return end

	Blink:FireClient(player)

	prompt.Enabled = false

	local giftAssembly = prompt.Parent and prompt.Parent.Parent
	local burstPos = giftAssembly and giftAssembly.PrimaryPart and giftAssembly.PrimaryPart.Position

	if burstPos then
		Burst:FireAllClients(burstPos)
	else
		Burst:FireAllClients(PoleCenter + Vector3.new(0, 18, 0))
		warn(string.format("[PoleGame] Burst location error. Falling back to PoleCenter."))
	end

	if giftAssembly then
		for _, part in giftAssembly:GetDescendants() do
			if part:IsA("BasePart") then
				part.Transparency = 1
				part.CanCollide = false
			end
		end
		print(string.format("[PoleGame] Gift assembly made invisible: %s", giftAssembly.Name))
	end

	if burstPos then
		print("[PoleGame] Triggered gift! Spawning a single gear at gift's X/Z.")
		spawnGear(burstPos)

		spawnAnimalCustom(burstPos, player)
	else
		print("[PoleGame] Triggered gift! Spawning failed (No position found).")
		return
	end

	local promptToDestroy = prompt

	for i, p in ipairs(GiftPrompts) do
		if p == promptToDestroy then
			table.remove(GiftPrompts, i)
			break
		end
	end

	if #GiftPrompts == 0 then
		print("[PoleGame] ALL gifts triggered! Destroying the pole. Gears remain collectible.")
		PoleGame.OnStop()
	end

	promptToDestroy:Destroy()
end

function PoleGame.OnStart()
	if PoleGame.Running then return end
	PoleGame.Running = true
	ActiveGears = {}
	GearPos = {}
	GearCounter = 0

	spawnPole()

	print("[PoleGame] Event started! Waiting for Gift triggers.")
end

function PoleGame.OnStop()
	if not PoleGame.Running then return end
	PoleGame.Running = false

	for _, prompt in GiftPrompts do
		if prompt:IsA("ProximityPrompt") and prompt.Parent then
			prompt:Destroy()
		end
	end
	GiftPrompts = {}

	if CurrentPole then
		CurrentPole:Destroy()
	end

	CurrentPole = nil
	PoleCenter = nil
	print("[PoleGame] Event phase stopped. Pole destroyed. Active gears remain collectible.")
end

PickGear.OnServerEvent:Connect(function(plr, gearId)
	if not table.find(ActiveGears, gearId) then return end

	table.remove(ActiveGears, table.find(ActiveGears, gearId))

	local pos = GearPos[gearId]
	GearPos[gearId] = nil
	if pos then Burst:FireAllClients(pos) end

	local gearName = gearId:match("^(.-)*")
	local tool = ItemsFolder:FindFirstChild(gearName)
	if tool and tool:IsA("Tool") then
		tool:Clone().Parent = plr.Backpack
	end

	DestroyGear:FireAllClients(gearId)
end)

return PoleGame