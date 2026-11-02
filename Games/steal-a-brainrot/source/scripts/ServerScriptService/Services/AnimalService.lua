local AnimalService = {}

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local PathfindingService = game:GetService("PathfindingService")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService") 
local CollectionService = game:GetService("CollectionService")

local Net = require(ReplicatedStorage.Packages.Net)

local GameService = require(ServerScriptService.Services.GameService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local PlotService = require(ServerScriptService.Services.PlotService)
local LiveboardService = require(ServerScriptService.Services.LiveboardService)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local ChatService = require(ServerScriptService.Services.ChatService)
local EventServiceFolder = ServerScriptService:WaitForChild("Services")
local EventService = require(EventServiceFolder:WaitForChild("EventService"))

local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local Animals = require(ReplicatedStorage.Datas.Animals)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local LuckyBlocks = require(ReplicatedStorage.Datas.LuckyBlocks)
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)
local GameData = require(ReplicatedStorage.Datas.Game)

local GameDataServerStorage = require(ServerStorage.Modules.GameData)

local ANIMAL_SOUNDS = ReplicatedStorage.Sounds.Animals

local MainFrame = workspace.RoadPanel.SurfaceGui.MainFrame

local GuaranteedBrainrotGod = 900
local GuaranteedSecret = 1500

local NEXT_QUEUE = {}

local PendingSpawnDelayAnimal = nil
local SpawnDelayEndTime = 0

local PurchaseRemote = Net:RemoteEvent("156ed911-fc4b-4d24-a648-acd1e9761e4f")
local HoldBeganRemote = Net:RemoteEvent("f756228f-15f8-4b6d-93a4-dfe62bb409cb")

-- FakeAnimal poof effect
local FakePoofRemote = game:GetService("ReplicatedStorage"):FindFirstChild("FakeAnimalPoof")
if not FakePoofRemote then
	FakePoofRemote = Instance.new("RemoteEvent")
	FakePoofRemote.Name = "FakeAnimalPoof"
	FakePoofRemote.Parent = game:GetService("ReplicatedStorage")
end

local ActiveAnimals = {}
local PurchaseLocks = {}
local LastPurchaseAttempt = {}

function AnimalService.GetRoadAnimals()
	local all = CollectionService:GetTagged("Animal")
	local result = {}
	for _, animal in ipairs(all) do
		if animal:GetAttribute("InCave") ~= true then
			table.insert(result, animal)
		end
	end
	return result
end

local RAY_PARAMS = RaycastParams.new()
RAY_PARAMS.FilterType = Enum.RaycastFilterType.Include
RAY_PARAMS.FilterDescendantsInstances = {workspace.Map, workspace.Terrain}


local YoIsTsModded = false

local EventMutationsList = {
	["BloodmoonEvent"] = {Chance = 20, Mutation = "Bloodrot"},
	["CandyEvent"] = {Chance = 10, Mutation = "Candy"},
	["MoltenEvent"] = {Chance = 15, Mutation = "Lava"},
	["GalaxyEvent"] = {Chance = 15, Mutation = "Galaxy"},
	["YinYangEvent"] = {Chance = 25, Mutation = "YinYang"},
	["RadioactiveEvent"] = {Chance = 25, Mutation = "Radioactive"},
	["CursedEvent"] = {Chance = 15, Mutation = "Cursed"},
	["DivineEvent"] = {Chance = 12.5, Mutation = "Divine"},
	["CyberEvent"] = {Chance = 10, Mutation = "Cyber"}
}

local ForcedRarity = nil
local ForcedRarityEndTime = 0
local GlobalSpeedOverride = nil

local function getFirstFreePodium(Player: Player)
	local plot = PlotService.getPlot(Player)
	if not plot then return nil end

	local channel = Synchronizer:Get(Player)
	if not channel then return nil end

	local animalPodiums = channel:Get("AnimalPodiums")
	if not animalPodiums then return nil end

	for _, podium in ipairs(plot.AnimalPodiums:GetChildren()) do
		local index = tonumber(podium.Name)
		if index and animalPodiums[index] == "Empty" then
			return podium
		end
	end

	return nil
end

local function createOrUpdateTimer(name: string, text: string)
	local Existing = MainFrame:FindFirstChild(name)
	if Existing then
		Existing.Text = text
		return
	end

	local Template = MainFrame:FindFirstChild("Template")

	local Label = Template:Clone()
	Label.Name = name
	Label.Text = text
	Label.Visible = true
	Label.Parent = MainFrame
end

local function createPurchasableAnimal(AnimalData: any, Mutation: string?, Traits: {string}?, Speed: number?, CustomSpawn: {Start: BasePart?, End: BasePart?, Owner: Player?}?, AFKTime: number?, ForceStraightLine: boolean?, IsFake: boolean?)
	local isCaveSpawn = (AnimalService.CaveSpawnActive and AnimalService.CaveWaypoints and #AnimalService.CaveWaypoints > 0)
		or (AnimalService.EventWaypointActive and AnimalService.EventWaypoints and #AnimalService.EventWaypoints > 0)
	local InCave = false
	local MoveTarget = (AnimalService.CaveSpawnActive and AnimalService.CustomSpawnEnd)
		or (AnimalService.EventWaypointActive and AnimalService.CustomSpawnEnd)
		or workspace.Road.End
	local IsBought = false
	local PurchasingPlayer: Player?
	local ReservedPodiumIndex: number?
	local OriginalSpeed = Speed or GlobalSpeedOverride or GameData.RoadSpawn.AnimalSpeed
	local ForceIdleConnection: RBXScriptConnection?
	local MovementConnection: RBXScriptConnection?
	local CurrentPath: Path?
	local CurrentWaypoints: {PathWaypoint}?
	local CurrentWaypointIndex = 1
	local IsMoving = false
	local IsDestroying = false
	local animConn: RBXScriptConnection?
	local lastRepath = 0

	local AnimalModel = Instance.new("Model")
	local AnimalName = HttpService:GenerateGUID(false)
	AnimalModel.Name = AnimalName

	local AnimalPart = Instance.new("Part")
	AnimalPart.Size = Vector3.new(1, 1, 1)
	AnimalPart.Transparency = 1
	AnimalPart.Anchored = true
	AnimalPart.CanCollide = false
	AnimalPart.CanQuery = false
	AnimalPart.CanTouch = false
	AnimalPart.Parent = AnimalModel

	local PromptAttachment = Instance.new("Attachment")
	PromptAttachment.Name = "PromptAttachment"
	PromptAttachment.Parent = AnimalPart

	PromptAttachment.Position = Vector3.new(0, 1.714, 0)

	AnimalModel.PrimaryPart = AnimalPart

	AnimalModel.Parent = workspace:FindFirstChild("MovingAnimals")

	-- FakeAnimal flag
	if IsFake then
		AnimalModel:SetAttribute("FakeAnimal", true)
	end

	local isFuseSpawn =
		CustomSpawn
		and CustomSpawn.Start
		and ReplicatedStorage:FindFirstChild("FuseMachine")
		and CustomSpawn.Start == ReplicatedStorage.FuseMachine.SpawnZone
	AnimalModel:SetAttribute("IsFuseSpawn", isFuseSpawn)

	local isCupidSpawn =
		CustomSpawn
		and CustomSpawn.Start
		and CustomSpawn.Start == workspace.CupidsMachine.SpawnZone
	AnimalModel:SetAttribute("IsCupidSpawn", isCupidSpawn)

	local isCraftSpawn =
		CustomSpawn
		and CustomSpawn.Start
		and CustomSpawn.Start == workspace.CraftingMachine.SpawnZone
	AnimalModel:SetAttribute("IsCraftSpawn", isCraftSpawn)

	local isSpinSpawn =
		CustomSpawn
		and CustomSpawn.Start
		and CustomSpawn.Start == workspace.SpinMachine.SpawnZone
	AnimalModel:SetAttribute("IsSpinSpawn", isSpinSpawn)

	local isRNGSpawn =
		CustomSpawn
		and CustomSpawn.Start
		and workspace:FindFirstChild("RNG Machine")
		and CustomSpawn.Start == workspace["RNG Machine"]:FindFirstChild("SpawnPart")
	AnimalModel:SetAttribute("IsRNGSpawn", isRNGSpawn)

	local startCFrame

	if isFuseSpawn or isCupidSpawn or isCraftSpawn or isSpinSpawn or isRNGSpawn then
		local spawnZone = CustomSpawn.Start

		if isCraftSpawn then
			spawnZone = workspace.CraftingMachine.SpawnZone
		elseif isCupidSpawn then
			spawnZone = workspace.CupidsMachine.SpawnZone
		end

		startCFrame = spawnZone.CFrame
	elseif (AnimalService.CaveSpawnActive or AnimalService.EventWaypointActive) and AnimalService.CustomSpawnStart then
		startCFrame = AnimalService.CustomSpawnStart.CFrame
	elseif AnimalService.BackroomsSpawnActive and AnimalService.BackroomsSpawnStart then

		startCFrame = AnimalService.BackroomsSpawnStart.CFrame
	else
		startCFrame = workspace.Road.Start.CFrame
	end

	if Mutation == "Cyber" and not isFuseSpawn and not isCupidSpawn and not isCraftSpawn and not isSpinSpawn and not isRNGSpawn then
		local CyberBridge = game:GetService("ServerStorage"):FindFirstChild("CyberBeaconBridge")
		if CyberBridge then
			local didBeaconFire = CyberBridge:Invoke()

			if didBeaconFire then
				task.wait(1.9)				
			end
		end
	end

	if Mutation == "Cyber" and AnimalData.SpawnVFX and not isFuseSpawn and not isCupidSpawn and not isCraftSpawn and not isSpinSpawn and not isRNGSpawn and not isCaveSpawn then
		GameService.SpawnEffect(AnimalData.SpawnVFX, 0)
	end
	-- À ajouter dans createPurchasableAnimal, après la création de l'animal
	-- Envoie un signal que l'animal a spawn (surtout pour l'event 1x1x1x1)
	if isCaveSpawn or AnimalService.EventWaypointActive then
		local AnimalSpawnSignal = game:GetService("ReplicatedStorage"):FindFirstChild("AnimalSpawnBindable")
		if AnimalSpawnSignal then
			AnimalSpawnSignal:Fire()
			print("[AnimalService] Signal d'animal spawn envoyé pour:", AnimalData.DisplayName)
		end
	end
	AnimalModel:PivotTo(startCFrame)
	task.delay(0.0000000000000000001, function()
		if AnimalModel and AnimalModel.PrimaryPart then
			local currentCF = AnimalModel.PrimaryPart.CFrame
			if not isFuseSpawn and not isCupidSpawn and not isSpinSpawn and not isRNGSpawn then
				AnimalModel:PivotTo(currentCF * CFrame.Angles(0, math.rad(180), 0))
			end
		end
	end)

	task.spawn(function()
		local animalPart = AnimalModel.PrimaryPart
		if not animalPart then return end

		local rayParams = RaycastParams.new()
		rayParams.FilterType = Enum.RaycastFilterType.Exclude
		rayParams.FilterDescendantsInstances = {AnimalModel}

		local maxFallDistance = 300
		local fallSpeed = 1
		local grounded = false

		while not grounded and AnimalModel and AnimalModel.Parent do
			local result = workspace:Raycast(animalPart.Position, Vector3.new(0, -maxFallDistance, 0), rayParams)
			local dt = RunService.Heartbeat:Wait()

			local newY
			if result then
				local targetY = result.Position.Y + (animalPart.Size.Y / 2)
				if animalPart.Position.Y - targetY > 0.2 then
					newY = math.max(animalPart.Position.Y - fallSpeed * dt, targetY)
				else
					newY = targetY
					grounded = true
				end
			else
				newY = animalPart.Position.Y - fallSpeed * dt
			end

			local currentCF = AnimalModel:GetPivot()
			local newPos = Vector3.new(currentCF.Position.X, newY, currentCF.Position.Z)
			AnimalModel:PivotTo(CFrame.new(newPos) * CFrame.fromMatrix(Vector3.zero, currentCF.XVector, currentCF.YVector, currentCF.ZVector))
		end
	end)

	if Mutation then
		AnimalModel:SetAttribute("Mutation", Mutation)
	end

	if Traits and #Traits > 0 then
		local Success, Result = pcall(HttpService.JSONEncode, HttpService, Traits)
		if Success then
			AnimalModel:SetAttribute("Traits", Result)
		else
			warn("Failed to encode traits:", Traits)
		end
	end

	if AnimalData.DisplayName == "Los Lucky Blocks" then
		AnimalModel:SetAttribute("Index", "Los Lucky Blocks")
	elseif AnimalData.DisplayName == "Heart Lucky Block" then	
		AnimalModel:SetAttribute("Index", "Heart Lucky Block")
	elseif AnimalData.DisplayName == "Premium Heart Lucky Block" then	
		AnimalModel:SetAttribute("Index", "Premium Heart Lucky Block")
	elseif AnimalData.DisplayName == "Leprechaun Lucky Block" then	
		AnimalModel:SetAttribute("Index", "Leprechaun Lucky Block")
	elseif AnimalData.DisplayName == "Premium Leprechaun Lucky Block" then	
		AnimalModel:SetAttribute("Index", "Premium Leprechaun Lucky Block")
	elseif AnimalData.DisplayName == "Egg Lucky Block" then	
		AnimalModel:SetAttribute("Index", "Egg Lucky Block")
	elseif AnimalData.DisplayName == "Premium Egg Lucky Block" then	
		AnimalModel:SetAttribute("Index", "Premium Egg Lucky Block")
	elseif AnimalData.DisplayName == "Ultime Lucky Block" then
		AnimalModel:SetAttribute("Index", "Ultime Lucky Block")
	elseif AnimalData.LuckyBlock then
		if not string.find(AnimalData.DisplayName, AnimalData.Rarity) then
			AnimalModel:SetAttribute("Index", string.format("%s %s", AnimalData.Rarity, AnimalData.DisplayName))
		else
			AnimalModel:SetAttribute("Index", AnimalData.DisplayName)
		end
	else
		AnimalModel:SetAttribute("Index", AnimalData.DisplayName)
	end

	-- Liveboard entry
	if not IsFake then
		task.spawn(function()
			pcall(LiveboardService.CreateEntry, LiveboardService, AnimalModel, AnimalData)
		end)
	end

	if AnimalData.AdminCost then
		AnimalModel:SetAttribute("AdminCost", AnimalData.AdminCost)
	end
	if AnimalData.AdminGeneration then
		AnimalModel:SetAttribute("AdminGeneration", AnimalData.AdminGeneration)
	end

	if AnimalData.SpawnVFX and not isFuseSpawn and not isCupidSpawn and not isCraftSpawn and not isSpinSpawn and not isRNGSpawn and not isCaveSpawn and Mutation ~= "Cyber" then
		GameService.SpawnEffect(AnimalData.SpawnVFX, 0)
	end

	if AnimalData.SpawnDelay and AnimalData.SpawnDelay > 0 and not isFuseSpawn and not isCupidSpawn and not isCraftSpawn and not isSpinSpawn and not isRNGSpawn then
		task.wait(AnimalData.SpawnDelay)

		task.delay(0.0000000000000000001, function()
			if AnimalModel and AnimalModel.PrimaryPart then
				local currentCF = AnimalModel.PrimaryPart.CFrame
				AnimalModel:PivotTo(currentCF * CFrame.Angles(0, math.rad(180), 0))
			end
		end)
	end

	if not isCaveSpawn and (AnimalData.Rarity == "Brainrot God" or AnimalData.Rarity == "Secret" or AnimalData.Rarity == "OG" or AnimalData.Rarity == "Admin") then
		local Sound = ANIMAL_SOUNDS:FindFirstChild(AnimalData.DisplayName)
		if Sound then
			local MainSound = Sound:Clone()
			MainSound.PlayOnRemove = true
			MainSound.Parent = AnimalPart
			MainSound:Destroy()
		end
	end

	if AnimalData.Rarity == "Secret" and not isFuseSpawn and not isCupidSpawn and not isCraftSpawn and not isSpinSpawn and not isRNGSpawn then
		if AnimalData.DisplayName ~= "Lucky Block" then
			ChatService:SendMessage("<font color='#000000'>[SERVER] A secret Brainrot has spawned!</font>")
		else
			local Sound = ANIMAL_SOUNDS:FindFirstChild("Secret Lucky Block")
			if Sound then
				local MainSound = Sound:Clone()
				MainSound.PlayOnRemove = true
				MainSound.Parent = AnimalPart
				MainSound:Destroy()
			else
				warn("[AnimalService] Secret Lucky Block sound not found!")
			end

			ChatService:SendMessage("<font color='#000000'>[SERVER] A Secret Lucky Block has spawned!</font>")
		end
	end
	
	if AnimalData.Rarity == "OG" and not isFuseSpawn and not isCupidSpawn and not isCraftSpawn and not isSpinSpawn and not isRNGSpawn then
		if AnimalData.DisplayName ~= "Lucky Block" then
			ChatService:SendMessage("<font color='#00aa00'>[SERVER] A OG Brainrot has spawned!</font>")
		else
			local Sound = ANIMAL_SOUNDS:FindFirstChild("OG Lucky Block")
			if Sound then
				local MainSound = Sound:Clone()
				MainSound.PlayOnRemove = true
				MainSound.Parent = AnimalPart
				MainSound:Destroy()
			else
				warn("[AnimalService] OG Lucky Block sound not found!")
			end

			ChatService:SendMessage("<font color='#00aa00'>[SERVER] A OG Lucky Block has spawned!</font>")
		end
	end

	if AnimalData.Rarity == "Spooky" then
		if AnimalData.DisplayName ~= "Spooky Lucky Block" then
			ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Spooky Lucky Block</font><font color='#d1d202'> has spawned!</font>")
		else
			local Sound = ANIMAL_SOUNDS:FindFirstChild("Spooky Lucky Block")
			if Sound then
				local MainSound = Sound:Clone()
				MainSound.PlayOnRemove = true
				MainSound.Parent = AnimalPart
				MainSound:Destroy()
			else
				warn("[AnimalService] Spooky Lucky Block sound not found!")
			end

			ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Spooky Lucky Block</font><font color='#d1d202'> has spawned!</font>")
		end
	end

	if AnimalData.Rarity == "Festive" then
		if AnimalData.DisplayName ~= "Festive Lucky Block" then
			local Sound = ANIMAL_SOUNDS:FindFirstChild("Festive Lucky Block")
			if Sound then
				local MainSound = Sound:Clone()
				MainSound.PlayOnRemove = true
				MainSound.Parent = AnimalPart
				MainSound:Destroy()
			else
				warn("[AnimalService] Festive Lucky Block sound not found!")
			end
		end
	end

	if AnimalData.Rarity == "Easter" then
		if AnimalData.DisplayName ~= "Egg Lucky Block" then
			local Sound = ANIMAL_SOUNDS:FindFirstChild("Egg Lucky Block")
			if Sound then
				local MainSound = Sound:Clone()
				MainSound.PlayOnRemove = true
				MainSound.Parent = AnimalPart
				MainSound:Destroy()
			else
				warn("[AnimalService] Egg Lucky Block sound not found!")
			end
		end
	end

	if AnimalData.Rarity == "Festive" then
		if AnimalData.DisplayName ~= "Premium Festive Lucky Block" then
			local Sound = ANIMAL_SOUNDS:FindFirstChild("Festive Lucky Block")
			if Sound then
				local MainSound = Sound:Clone()
				MainSound.PlayOnRemove = true
				MainSound.Parent = AnimalPart
				MainSound:Destroy()
			else
				warn("[AnimalService] Festive Lucky Block sound not found!")
			end
		end
	end

	if AnimalData.Rarity == "St Patrick\'s" then
		if AnimalData.DisplayName ~= "Leprechaun Lucky Block" then
			local Sound = ANIMAL_SOUNDS:FindFirstChild("Leprechaun Lucky Block")
			if Sound then
				local MainSound = Sound:Clone()
				MainSound.PlayOnRemove = true
				MainSound.Parent = AnimalPart
				MainSound:Destroy()
			else
				warn("[AnimalService] Leprechaun Lucky Block sound not found!")
			end
		end
	end

	if AnimalData.Rarity == "Valentines" then
		if AnimalData.DisplayName ~= "Heart Lucky Block" then
			local Sound = ANIMAL_SOUNDS:FindFirstChild("Heart Lucky Block")
			if Sound then
				local MainSound = Sound:Clone()
				MainSound.PlayOnRemove = true
				MainSound.Parent = AnimalPart
				MainSound:Destroy()
			else
				warn("[AnimalService] Heart Lucky Block sound not found!")
			end
		end
	end

	if AnimalData.Rarity == "Valentines" then
		if AnimalData.DisplayName ~= "Premium Heart Lucky Block" then
			local Sound = ANIMAL_SOUNDS:FindFirstChild("Premium Heart Lucky Block")
			if Sound then
				local MainSound = Sound:Clone()
				MainSound.PlayOnRemove = true
				MainSound.Parent = AnimalPart
				MainSound:Destroy()
			else
				warn("[AnimalService] Premium Heart Lucky Block sound not found!")
			end
		end
	end

	if AnimalData.Rarity == "Taco" and AnimalData.DisplayName ~= "Lucky Block" then
		local Sound = ANIMAL_SOUNDS:FindFirstChild("Los Taco Blocks")
		if Sound then
			local MainSound = Sound:Clone()
			MainSound.PlayOnRemove = true
			MainSound.Parent = AnimalPart
			MainSound:Destroy()
		end
		ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Los Taco Blocks</font><font color='#d1d202'> has spawned!</font>")
	end

	if AnimalData.DisplayName == "Los Lucky Blocks" then
		ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Los Lucky Blocks</font><font color='#d1d202'> has spawned!</font>")
	end

	if AnimalData.DisplayName == "Lucky Block" then
		if AnimalData.Rarity == "Admin" then
			ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Admin Lucky Block</font><font color='#d1d202'> has spawned!</font>")
			local Sound = ANIMAL_SOUNDS:FindFirstChild("Admin Lucky Block")
			if Sound then
				local MainSound = Sound:Clone()
				MainSound.PlayOnRemove = true
				MainSound.Parent = AnimalPart
				MainSound:Destroy()
			end
		elseif AnimalData.Rarity == "Taco" then
			ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Taco og Lucky Block</font><font color='#d1d202'> has spawned!</font>")
			local Sound = ANIMAL_SOUNDS:FindFirstChild("Taco og Lucky Block")
			if Sound then
				local MainSound = Sound:Clone()
				MainSound.PlayOnRemove = true
				MainSound.Parent = AnimalPart
				MainSound:Destroy()
			end
		elseif AnimalData.Rarity == "Brainrot God" then
			local Sound = ANIMAL_SOUNDS:FindFirstChild("Brainrot God Lucky Block")
			if Sound then
				local MainSound = Sound:Clone()
				MainSound.PlayOnRemove = true
				MainSound.Parent = AnimalPart
				MainSound:Destroy()
			end
			ChatService:SendMessage("<font color='#22afe2'>[SERVER] A Brainrot God Lucky Block has spawned!</font>")
		end
	end

	if AnimalData.TriggerEvent and not isFuseSpawn and not isCupidSpawn and not isCraftSpawn and not isSpinSpawn and not isRNGSpawn and not isCaveSpawn then
		task.spawn(function()
			while not ReplicatedStorage:GetAttribute("EventsLoaded") do
				task.wait()
			end

			if AnimalData.SpawnDelay and AnimalData.SpawnDelay > 0 then
				task.wait(AnimalData.SpawnDelay)
			end

			if AnimalData.TriggerEventDelay and AnimalData.TriggerEventDelay > 0 then
				task.wait(AnimalData.TriggerEventDelay)
			end

			local options = AnimalData.TriggerEventOptions
			local success, err = pcall(function()
				if options then
					EventService:ExecuteEvent(AnimalData.TriggerEvent, 180, table.unpack(options))
				else
					EventService:ExecuteEvent(AnimalData.TriggerEvent, 180)
				end
			end)

			if not success then
				warn("[TriggerEvent] Failed to execute '" .. AnimalData.TriggerEvent .. "':", err)
			end
		end)
	end

	local Prompt = Instance.new("ProximityPrompt")
	Prompt.ObjectText = string.format("%s $%s", AnimalData.DisplayName, NumberUtils.ToString(nil, AnimalData.Price))
	Prompt.ActionText = "Purchase"
	Prompt.HoldDuration = 0.25
	Prompt.RequiresLineOfSight = true
	Prompt.Parent = PromptAttachment
	CollectionService:AddTag(AnimalModel, "Animal")
	CollectionService:AddTag(Prompt, "AnimalPurchasePrompt")

	if isCaveSpawn then
		AnimalModel:SetAttribute("InCave", true)
	end

	if AnimalData.NotPurchasable then
		Prompt.Enabled = false
		Prompt:SetAttribute("Disabled", true)
	else
		Prompt:SetAttribute("Disabled", false)
	end
	Prompt:SetAttribute("UID", AnimalName)

	ActiveAnimals[AnimalName] = {
		Model = AnimalModel,
		Data = AnimalData,
		PurchaseFunction = nil
	}

	local function stickToGround(Position: Vector3): Vector3
		local Origin = Position + Vector3.new(0, 5, 0)
		local Direction = Vector3.new(0, -20, 0)

		local Result = workspace:Raycast(Origin, Direction, RAY_PARAMS)

		if Result then
			return Result.Position
		end

		local BackupParams = RaycastParams.new()
		BackupParams.FilterType = Enum.RaycastFilterType.Exclude
		BackupParams.FilterDescendantsInstances = {AnimalModel}

		local BackupResult = workspace:Raycast(Origin, Direction, BackupParams)
		if BackupResult then
			return BackupResult.Position
		end

		return Position
	end

	local function onDestinationReached()
		if IsDestroying then return end
		IsDestroying = true

		if MovementConnection then
			MovementConnection:Disconnect()
			MovementConnection = nil
		end
		IsMoving = false

		if not AnimalModel or not AnimalModel.Parent or not AnimalPart or not MoveTarget then
			warn("[AnimalService] Invalid model data during destination reached")
			if AnimalModel and AnimalModel.Parent then
				AnimalModel:Destroy()
			end
			if PurchasingPlayer and ReservedPodiumIndex then
				PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
			end
			return
		end

		if IsBought and PurchasingPlayer then
			local PlayerChannel = Synchronizer:Get(PurchasingPlayer)
			if not PlayerChannel then
				AnimalModel:Destroy()
				return
			end

			local Plot = PlotService.getPlot(PurchasingPlayer)
			if not Plot then
				AnimalModel:Destroy()
				return
			end

			local AnimalPodiums = PlayerChannel:Get("AnimalPodiums") or {}
			local IndexData = PlayerChannel:Get("Index") or {}

			local Plot = PlotService.getPlot(PurchasingPlayer)
			local PodiumPart = Plot and Plot.AnimalPodiums:FindFirstChild(tostring(ReservedPodiumIndex))

			if not PodiumPart then
				warn("[AnimalService] No free podium on arrival for player:", PurchasingPlayer.Name)
				AnimalModel:Destroy()
				return
			end

			ReservedPodiumIndex = tonumber(PodiumPart.Name)

			local PodiumData = AnimalPodiums[ReservedPodiumIndex]

			if PodiumData and PodiumData ~= "Empty" then
				PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)

				local NewPodium = PlotService.getFreePodium(PurchasingPlayer)
				if not NewPodium then
					AnimalModel:Destroy()
					return
				end

				ReservedPodiumIndex = tonumber(NewPodium.Name)
				PlotService.AddToQueue(PurchasingPlayer, ReservedPodiumIndex)
			end

			local FinalIndex = AnimalModel:GetAttribute("Index")
			local FinalMutation = AnimalModel:GetAttribute("Mutation")

			if not FinalIndex or FinalIndex == "" then
				warn("[AnimalService] Invalid FinalIndex for animal: " .. AnimalModel.Name)
				AnimalModel:Destroy()
				return
			end

			if not AnimalData.LuckyBlock then
				IndexData[FinalIndex] = IndexData[FinalIndex] or {}

				if FinalMutation then
					local current = tonumber(IndexData[FinalIndex][FinalMutation]) or 0
					IndexData[FinalIndex][FinalMutation] = current + 1
				else
					local current = tonumber(IndexData[FinalIndex].Default) or 0
					IndexData[FinalIndex].Default = current + 1
				end
			end

			local FinalTraits
			local TraitJson = AnimalModel:GetAttribute("Traits")
			if TraitJson then
				local Success, Result = pcall(HttpService.JSONDecode, HttpService, TraitJson)
				if Success then FinalTraits = Result end
			end

			local AdminGeneration = AnimalModel:GetAttribute("AdminGeneration")
			local AdminCost = AnimalModel:GetAttribute("AdminCost")

			AnimalPodiums[ReservedPodiumIndex] = {
				Index = FinalIndex,
				LastCollect = os.time(),
				Mutation = FinalMutation,
				Traits = FinalTraits,
				Timer = AnimalData.LuckyBlock and 0 or nil,
				AdminGeneration = AdminGeneration,
				AdminCost = AdminCost,
				IsFake = IsFakeAnimal or nil,
			}

			PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)

			local GenerationAmount = AdminGeneration or SharedAnimals:GetGeneration(
				FinalIndex,
				FinalMutation,
				FinalTraits,
				PurchasingPlayer
			)

			PlayerChannel:Increase("Generation", GenerationAmount)
			PlayerChannel:Set("Index", IndexData)
			PlayerChannel:Set("AnimalPodiums", AnimalPodiums)
			PlayerChannel:Set("AnimalAddedOrRemoved", true)
		end

		AnimalModel:Destroy()
	end

	local function MoveAlongPath(Target: BasePart)
		if IsDestroying then return end

		if AnimalModel:GetAttribute("ForceIdle") == true then
			if MovementConnection then
				MovementConnection:Disconnect()
				MovementConnection = nil
			end
			IsMoving = false
			return
		end

		if MovementConnection then
			MovementConnection:Disconnect()
			MovementConnection = nil
		end

		IsMoving = true

		if not ForceStraightLine then
			CurrentPath = PathfindingService:CreatePath({
				AgentCanJump = false,
				AgentRadius = 1,
				Costs = {
					Avoid = math.huge
				}
			})

			local success, errorMsg = pcall(function()
				CurrentPath:ComputeAsync(AnimalPart.Position, Target.Position)
			end)

			if not success or CurrentPath.Status ~= Enum.PathStatus.Success then
				CurrentWaypoints = {}
				CurrentWaypointIndex = 1
				return
			else
				CurrentWaypoints = CurrentPath:GetWaypoints()
				CurrentWaypointIndex = 1

				for i = 1, math.min(5, #CurrentWaypoints) do
					if (CurrentWaypoints[i].Position - AnimalPart.Position).Magnitude < 3 then
						CurrentWaypointIndex = i + 1
					else
						break
					end
				end
			end
		else
			CurrentWaypoints = nil
			CurrentWaypointIndex = 1
		end

		local DESTINATION_THRESHOLD = 2.5

		MovementConnection = RunService.Heartbeat:Connect(function(DeltaTime)
			if IsDestroying then
				if MovementConnection then
					MovementConnection:Disconnect()
					MovementConnection = nil
				end
				return
			end

			if not AnimalModel or not AnimalModel.Parent or not IsMoving or not AnimalPart or not AnimalPart.Parent then
				if MovementConnection then
					MovementConnection:Disconnect()
					MovementConnection = nil
				end
				return
			end

			if AnimalModel:GetAttribute("ForceIdle") == true then
				if MovementConnection then
					MovementConnection:Disconnect()
					MovementConnection = nil
				end
				IsMoving = false
				return
			end

			local CurrentSpeed = GlobalSpeedOverride or OriginalSpeed

			local targetPosition: Vector3

			if not ForceStraightLine and CurrentWaypoints and CurrentWaypointIndex <= #CurrentWaypoints then
				local waypoint = CurrentWaypoints[CurrentWaypointIndex]
				targetPosition = waypoint.Position

				local HorizontalTarget = Vector3.new(targetPosition.X, AnimalPart.Position.Y, targetPosition.Z)
				local Distance = (HorizontalTarget - AnimalPart.Position).Magnitude

				if Distance < 2 then
					CurrentWaypointIndex += 1

					if CurrentWaypointIndex > #CurrentWaypoints then
						CurrentWaypoints = nil
					end
					return
				end
			else
				targetPosition = Target.Position

				local Distance = (targetPosition - AnimalPart.Position).Magnitude

				if Distance < DESTINATION_THRESHOLD then
					if MovementConnection then
						MovementConnection:Disconnect()
						MovementConnection = nil
					end
					IsMoving = false
					task.spawn(onDestinationReached)
					return
				end
			end

			local HorizontalTarget = Vector3.new(targetPosition.X, AnimalPart.Position.Y, targetPosition.Z)
			local Direction = (HorizontalTarget - AnimalPart.Position)
			local Distance = Direction.Magnitude

			if Distance > 0.1 then
				local MoveStep = CurrentSpeed * DeltaTime

				if MoveStep > Distance then
					MoveStep = Distance
				end

				local NewPosition = AnimalPart.Position + (Direction.Unit * MoveStep)

				if not ForceStraightLine then
					NewPosition = stickToGround(NewPosition)
				end

				AnimalModel:PivotTo(CFrame.new(NewPosition) * AnimalPart.CFrame.Rotation)

				local lookDir = HorizontalTarget - NewPosition
				if lookDir.Magnitude > 0.05 then
					lookDir = lookDir.Unit

					local targetCF = CFrame.lookAt(
						NewPosition,
						NewPosition + lookDir
					)

					local currentCF = AnimalModel:GetPivot()

					local alpha = math.clamp(DeltaTime * 5, 0, 1)

					AnimalModel:PivotTo(currentCF:Lerp(targetCF, alpha))
				else
					AnimalModel:PivotTo(CFrame.new(NewPosition) * AnimalPart.CFrame.Rotation)
				end
			end
		end)
	end

	local function updateForceIdle()
		if IsDestroying then return end

		if AnimalModel:GetAttribute("InCave") == true then return end

		InCave = false -- sync la variable locale avec l'attribut

		local ForceIdle = AnimalModel:GetAttribute("ForceIdle")
		if ForceIdle == true then
			if MovementConnection then
				MovementConnection:Disconnect()
				MovementConnection = nil
			end
			IsMoving = false
		else
			local TargetToMoveTo
			if not IsBought then
				TargetToMoveTo = workspace.Road.End
			elseif MoveTarget and MoveTarget ~= workspace.Road.End then
				TargetToMoveTo = MoveTarget
			end

			if TargetToMoveTo and not IsMoving then
				MoveAlongPath(TargetToMoveTo)
			end
		end
	end

	ForceIdleConnection = AnimalModel.AttributeChanged:Connect(function(AttributeName)
		if AttributeName == "ForceIdle" then
			updateForceIdle()
		end
	end)

	local function purchaseAnimal(PlayerWhoTriggered: Player, IsFree: boolean?)

		if InCave then
			return
		end

		-- Vérification anticipée : base pleine
		do
			local _freePodium = PlotService.getFreePodium(PlayerWhoTriggered)
			if not _freePodium then
				NotificationService.Error(PlayerWhoTriggered, "Votre base est pleine !")
				return
			end
		end

		local LockKey = AnimalName .. "_" .. PlayerWhoTriggered.UserId
		local CurrentTime = tick()

		if PurchaseLocks[LockKey] then
			return
		end

		if LastPurchaseAttempt[LockKey] and (CurrentTime - LastPurchaseAttempt[LockKey]) < 0.1 then
			return
		end

		LastPurchaseAttempt[LockKey] = CurrentTime

		-- FakeAnimal: poof et disparaît
		if AnimalModel:GetAttribute("FakeAnimal") == true then
			local FakePoofRemote = game:GetService("ReplicatedStorage"):FindFirstChild("FakeAnimalPoof")
			if FakePoofRemote then FakePoofRemote:FireAllClients(AnimalPart.Position) end
			task.wait(0.05)
			if AnimalModel and AnimalModel.Parent then AnimalModel:Destroy() end
			return
		end

		if PurchasingPlayer and PurchasingPlayer ~= PlayerWhoTriggered then
			Prompt:SetAttribute("TargetPlayer", nil)
		end

		local PlayerChannel = Synchronizer:Get(PlayerWhoTriggered)
		if not PlayerChannel then
			PurchaseLocks[LockKey] = nil
			return
		end

		local BasePrice = AnimalData.Price
		local Price = BasePrice
		local CanAfford, Amount = MoneyService:CanAfford(PlayerWhoTriggered, Price)
		if not CanAfford and not IsFree then
			NotificationService.Error(PlayerWhoTriggered, string.format("You need $%s more to buy this", NumberUtils.ToString(nil, Amount)))
			PurchaseLocks[LockKey] = nil
			return
		end

		local Podium = PlotService.getFreePodium(PlayerWhoTriggered)
		warn("[AnimalService] DEBUG purchaseAnimal - player:", PlayerWhoTriggered.Name, "IsFree:", IsFree, "Podium:", Podium and Podium.Name or "NIL")
		if not Podium then
			NotificationService.Error(PlayerWhoTriggered, "Votre base est pleine !")
			PurchaseLocks[LockKey] = nil
			return
		end

		PurchaseLocks[LockKey] = true

		ReservedPodiumIndex = tonumber(Podium.Name)
		PlotService.AddToQueue(PlayerWhoTriggered, ReservedPodiumIndex)

		Prompt:SetAttribute("TargetPlayer", PlayerWhoTriggered.UserId)
		PurchasingPlayer = PlayerWhoTriggered
		IsBought = true

		task.delay(30, function()
			if PurchasingPlayer == PlayerWhoTriggered
				and ReservedPodiumIndex
				and not IsDestroying
			then
				PlotService.RemoveFromQueue(PlayerWhoTriggered, ReservedPodiumIndex)
			end
		end)

		local Plot: any = PlotService.getPlot(PlayerWhoTriggered)
		if not Plot then
			MoveTarget = workspace.Road.End
		else
			MoveTarget = Plot.AnimalTarget
		end

		if not IsFree then
			MoneyService:Add(PlayerWhoTriggered, -Price)
			Price = Price + BasePrice * 1.5
		end

		-- Libère l'idle du tapis de l'event avant de bouger
		AnimalModel:SetAttribute("ForceIdle", false)
		MoveAlongPath(MoveTarget)

		local Sound = ANIMAL_SOUNDS:FindFirstChild(AnimalModel:GetAttribute("Index"))
		if Sound then
			local MainSound = Sound:Clone()
			MainSound.PlayOnRemove = true
			MainSound.Parent = AnimalPart
			MainSound:Destroy()
		end

		task.delay(1, function()
			PurchaseLocks[LockKey] = nil
		end)
	end

	ActiveAnimals[AnimalName].PurchaseFunction = purchaseAnimal

	if CustomSpawn and CustomSpawn.End then
		MoveTarget = CustomSpawn.End
	end

	if CustomSpawn and CustomSpawn.Owner then
		local _owner = CustomSpawn.Owner
		if not IsDestroying then purchaseAnimal(_owner, true) end
	end

	local PlayerRemovingConn = Players.PlayerRemoving:Connect(function(Player: Player)
		if Player == PurchasingPlayer then
			Prompt:SetAttribute("TargetPlayer", nil)

			if ReservedPodiumIndex then
				PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
			end

			PurchasingPlayer = nil
			MoveTarget = workspace.Road.End
			IsBought = false
			ReservedPodiumIndex = nil

			if not IsDestroying then
				MoveAlongPath(MoveTarget)
			end
		end
	end)

	AnimalModel.Destroying:Connect(function()
		IsDestroying = true

		if ForceIdleConnection then
			ForceIdleConnection:Disconnect()
			ForceIdleConnection = nil
		end
		if MovementConnection then
			MovementConnection:Disconnect()
			MovementConnection = nil
		end
		if animConn then
			animConn:Disconnect()
			animConn = nil
		end
		PlayerRemovingConn:Disconnect()
		ActiveAnimals[AnimalName] = nil

		if PurchasingPlayer and ReservedPodiumIndex then
			PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
		end

		for Key in pairs(PurchaseLocks) do
			if string.find(Key, AnimalName) then
				PurchaseLocks[Key] = nil
			end
		end

		for Key in pairs(LastPurchaseAttempt) do
			if string.find(Key, AnimalName) then
				LastPurchaseAttempt[Key] = nil
			end
		end
	end)

	local InitialGroundPos = stickToGround(AnimalPart.Position)
	AnimalPart.CFrame = CFrame.new(InitialGroundPos)

	if isCaveSpawn then
		local caveWPs = (AnimalService.CaveSpawnActive and AnimalService.CaveWaypoints)
			or (AnimalService.EventWaypointActive and AnimalService.EventWaypoints)
			or {}
		local carpetPart = AnimalService.CaveCarpetPart
		local CARPET_REACH_DIST = 6
		local CAVE_SPEED = AnimalService.CaveSpeedOverride or 10
		local caveVFXPart = AnimalService.CaveVFXPart

		local SPAWN_VFX_WAYPOINT
		if caveVFXPart then
			local closestNum, closestDist = nil, math.huge
			for _, wpData in ipairs(caveWPs) do
				local d = (wpData.part.Position - caveVFXPart.Position).Magnitude
				if d < closestDist then
					closestDist = d
					closestNum = wpData.num
				end
			end
			SPAWN_VFX_WAYPOINT = closestNum
			print("[CaveVFX] SpawnVfxDelay mapped to waypoint " .. tostring(closestNum))
		else
			SPAWN_VFX_WAYPOINT = #caveWPs >= 2 and caveWPs[#caveWPs - 1].num or nil
		end

		InCave = true
		AnimalModel:SetAttribute("InCave", true)
		AnimalModel:SetAttribute("ForceIdle", true) -- idle pendant toute la cave
		Prompt.Enabled = false
		Prompt:SetAttribute("Disabled", true)

		task.spawn(function()
			local hasSpawnVFX = AnimalData.SpawnVFX ~= nil and AnimalData.SpawnDelay ~= nil
			local vfxFired = false

			for _, wpData in ipairs(caveWPs) do
				if IsDestroying or not AnimalModel or not AnimalModel.Parent then return end

				local targetPos = wpData.part.Position

				if (AnimalPart.Position - targetPos).Magnitude < 1.5 then
					continue
				end

				local arrived = false
				local moveConn
				moveConn = RunService.Heartbeat:Connect(function(dt)
					if IsDestroying or not AnimalModel or not AnimalModel.Parent then
						moveConn:Disconnect()
						arrived = true
						return
					end

					if AnimalModel:GetAttribute("CavePaused") then
						return
					end

					local curPos = AnimalPart.Position
					local toTarget = Vector3.new(targetPos.X, targetPos.Y, targetPos.Z) - curPos
					local dist = toTarget.Magnitude

					if dist < 1.5 then
						moveConn:Disconnect()
						arrived = true
						return
					end

					local step = math.min(CAVE_SPEED * dt, dist)
					local newPos = curPos + toTarget.Unit * step

					local flatDir = Vector3.new(toTarget.X, 0, toTarget.Z)
					if flatDir.Magnitude > 0.01 then
						local newCF = CFrame.lookAt(newPos, newPos + flatDir.Unit)
						local curCF = AnimalModel:GetPivot()
						AnimalModel:PivotTo(curCF:Lerp(newCF, math.clamp(dt * 8, 0, 1)))
					else
						AnimalModel:PivotTo(CFrame.new(newPos) * AnimalModel:GetPivot().Rotation)
					end
				end)

				while not arrived and not IsDestroying do
					task.wait()
				end

				if IsDestroying or not AnimalModel or not AnimalModel.Parent then return end

				local shouldFireVFX = hasSpawnVFX and not vfxFired and SPAWN_VFX_WAYPOINT and wpData.num == SPAWN_VFX_WAYPOINT
				if shouldFireVFX then
					vfxFired = true

					AnimalModel:SetAttribute("CavePaused", true)
					AnimalModel:SetAttribute("ForceIdle", true)

					local frozenAnimals = {}
					local movingFolder = workspace:FindFirstChild("MovingAnimals")
					if movingFolder then
						for _, otherModel in ipairs(movingFolder:GetChildren()) do
							if otherModel ~= AnimalModel and otherModel:GetAttribute("InCave") == true then
								otherModel:SetAttribute("CavePaused", true)

								table.insert(frozenAnimals, otherModel)
							end
						end
					end

					if Mutation == "Cyber" then
						local CyberBridge = game:GetService("ServerStorage"):FindFirstChild("CyberBeaconBridge")
						if CyberBridge then
							local didBeaconFire = CyberBridge:Invoke()
							if didBeaconFire then
								task.wait(1.9)
							end
						end
					end

					GameService.SpawnEffect(AnimalData.SpawnVFX, 0)
					print("[CaveVFX] Fired SpawnVFX '" .. AnimalData.SpawnVFX .. "' at waypoint " .. wpData.num)

					local vfxWait = AnimalData.SpawnDelay or 3
					task.wait(vfxWait)

					AnimalModel:SetAttribute("ForceIdle", false)
					AnimalModel:SetAttribute("CavePaused", false)

					for _, otherModel in ipairs(frozenAnimals) do
						if otherModel and otherModel.Parent then
							otherModel:SetAttribute("CavePaused", false)
						end
					end

					if AnimalData.TriggerEvent then
						task.spawn(function()
							while not ReplicatedStorage:GetAttribute("EventsLoaded") do
								task.wait()
							end
							if AnimalData.TriggerEventDelay and AnimalData.TriggerEventDelay > 0 then
								task.wait(AnimalData.TriggerEventDelay)
							end
							local options = AnimalData.TriggerEventOptions
							local ok, err = pcall(function()
								if options then
									EventService:ExecuteEvent(AnimalData.TriggerEvent, 180, table.unpack(options))
								else
									EventService:ExecuteEvent(AnimalData.TriggerEvent, 180)
								end
							end)
							if not ok then
								warn("[CaveTriggerEvent] Failed to execute '" .. AnimalData.TriggerEvent .. "':", err)
							end
						end)
					end
				end

				if carpetPart then
					local distToCarpet = (AnimalPart.Position - carpetPart.Position).Magnitude
					if distToCarpet <= CARPET_REACH_DIST then
						break
					end
				end
			end

			if IsDestroying or not AnimalModel or not AnimalModel.Parent then return end

			InCave = false
			AnimalModel:SetAttribute("InCave", false)
			Prompt.Enabled = true
			Prompt:SetAttribute("Disabled", false)

			local rarity = AnimalData.Rarity
			if rarity == "Brainrot God" or rarity == "Secret" or rarity == "OG" or rarity == "Admin" then
				local carpetSound = ANIMAL_SOUNDS:FindFirstChild(AnimalModel:GetAttribute("Index"))
				if carpetSound then
					local s = carpetSound:Clone()
					s.PlayOnRemove = true
					s.Parent = AnimalPart
					s:Destroy()
				end
			end

			-- Idle sur le CarpetExtension de l'event 1x1x1x1
			if AnimalService.EventWaypointActive then
				local mapModel = workspace:FindFirstChild("1x1x1x1Map")
				local carpet = mapModel and mapModel:FindFirstChild("CarpetExtension", true)
				if carpet then
					AnimalModel:PivotTo(carpet.CFrame)
					MoveTarget = workspace.Road.End
					-- ForceIdle reste true (mis à ligne 1123), pas de walk flash
					return
				end
			end

			AnimalModel:SetAttribute("ForceIdle", false)
			MoveTarget = workspace.Road.End
			MoveAlongPath(MoveTarget)
		end)

	elseif isFuseSpawn or isCupidSpawn or isCraftSpawn or isSpinSpawn or isRNGSpawn then
		local spawnZone = workspace.FuseMachine.SpawnZone

		if isSpinSpawn then
			spawnZone = workspace.SpinMachine.SpawnZone
		elseif isCupidSpawn then
			spawnZone = workspace.CupidsMachine.SpawnZone
		elseif isRNGSpawn then
			spawnZone = CustomSpawn.Start
		end

		if isCraftSpawn then
			-- FIX: spawn sur le tapis ChargePad.Pad
			local chargePad = workspace.CraftingMachine:FindFirstChild("ChargePad")
			spawnZone = (chargePad and chargePad:FindFirstChild("Pad")) or workspace.CraftingMachine.SpawnZone
		end

		if not spawnZone then
			warn("[AnimalService] Missing SpawnZone for spawn type")
			AnimalModel:Destroy()
			return
		end

		AnimalModel:SetAttribute("ForceIdle", true)
		AnimalModel:SetAttribute("Scale", 0.01)

		local levitateDuration = 1.5
		local spawnZoneDuration = 0.75
		local idleDuration = (isFuseSpawn or isSpinSpawn or isRNGSpawn) and 0 or 1.5

		local initialRotSpeed = 10
		local peakRotSpeed = 1800
		local finalRotSpeed = 0

		local tweenInfoLevitate = TweenInfo.new(
			levitateDuration,
			Enum.EasingStyle.Sine,
			Enum.EasingDirection.Out
		)
		local tweenLevitate = TweenService:Create(
			AnimalPart,
			tweenInfoLevitate,
			{CFrame = spawnZone.CFrame}
		)
		local startTime = tick()
		animConn = RunService.Heartbeat:Connect(function(dt)
			if IsDestroying then
				if animConn then
					animConn:Disconnect()
					animConn = nil
				end
				return
			end

			local t = math.clamp((tick() - startTime) / levitateDuration, 0, 1)

			local rotSpeed
			if t < 0.5 then
				rotSpeed = initialRotSpeed + (peakRotSpeed - initialRotSpeed) * (t / 0.5)
			else
				rotSpeed = peakRotSpeed + (finalRotSpeed - peakRotSpeed) * ((t - 0.5) / 0.5)
			end

			local rot = math.rad(rotSpeed * dt)
			local scale = 0.01 + (1 - 0.01) * t

			AnimalModel:SetAttribute("Scale", scale)

			local currentCF = AnimalModel:GetPivot()
			local targetCF = currentCF * CFrame.Angles(0, rot, 0)

			AnimalModel:PivotTo(currentCF:Lerp(targetCF, 0.15))

			if t >= 1 then
				if animConn then
					animConn:Disconnect()
					animConn = nil
				end
			end
		end)

		tweenLevitate:Play()
		tweenLevitate.Completed:Wait()

		if IsDestroying then return end

		local tweenInfoSpawnZone = TweenInfo.new(
			spawnZoneDuration,
			Enum.EasingStyle.Linear,
			Enum.EasingDirection.InOut
		)
		local tweenSpawnZone = TweenService:Create(
			AnimalPart,
			tweenInfoSpawnZone,
			{CFrame = spawnZone.CFrame}
		)
		AnimalModel:SetAttribute("Scale", 1)
		tweenSpawnZone:Play()
		tweenSpawnZone.Completed:Wait()

		if IsDestroying then return end

		task.wait(idleDuration)

		if not IsDestroying then
			AnimalModel:SetAttribute("ForceIdle", false)
			MoveAlongPath(MoveTarget)
		end
	elseif AFKTime and AFKTime > 0 then
		AnimalModel:SetAttribute("ForceIdle", true)
		task.delay(AFKTime, function()
			if AnimalModel and AnimalModel.Parent and not IsDestroying then
				AnimalModel:SetAttribute("ForceIdle", false)
				MoveAlongPath(MoveTarget)
			end
		end)
	else
		MoveAlongPath(MoveTarget)
	end
end

function AnimalService.spawnAnimalInBase(Player: Player, Animal: string, Mutation: string?, Traits: any?, OverrideGeneration: number?, OverrideCost: number?)
	local PlayerChannel = Synchronizer:Wait(Player)
	if not PlayerChannel then return end

	local Podiums = PlotService.getFreePodium(Player)
	if not Podiums then
		return
	end

	local AnimalPodiums = PlayerChannel:Get("AnimalPodiums")
	local Index = PlayerChannel:Get("Index")

	if not LuckyBlocks[Animal] then
		Index[Animal] = Index[Animal] or {}

		if Mutation then
			local current = tonumber(Index[Animal][Mutation]) or 0
			Index[Animal][Mutation] = current + 1
		else
			local current = tonumber(Index[Animal].Default) or 0
			Index[Animal].Default = current + 1
		end
	end

	AnimalPodiums[tonumber(Podiums.Name)] = {
		Index = Animal,
		LastCollect = os.time(),
		Mutation = Mutation,
		Traits = Traits,
		Timer = LuckyBlocks[Animal] and 0 or nil,
		AdminGeneration = OverrideGeneration,
		AdminCost = OverrideCost,
	}

	PlayerChannel:Set("Index", Index)
	PlayerChannel:Set("AnimalPodiums", AnimalPodiums)
	PlayerChannel:Set("AnimalAddedOrRemoved", true)
end

function AnimalService.spawnAnimalCustom(
	Animal: any,
	Mutation: string?,
	Traits: {string}?,
	Speed: number?,
	CustomSpawn: {Start: BasePart?, End: BasePart?, Owner: Player?}?,
	StandFor: number?
)

	local isFuseSpawn =
		CustomSpawn
		and CustomSpawn.Start
		and CustomSpawn.Start == workspace.FuseMachine.SpawnZone

	local isCupidSpawn =
		CustomSpawn
		and CustomSpawn.Start
		and CustomSpawn.Start == workspace.CupidsMachine.SpawnZone

	local isCraftSpawn =
		CustomSpawn
		and CustomSpawn.Start
		and CustomSpawn.Start == workspace.CraftingMachine.SpawnZone

	local isSpinSpawn =
		CustomSpawn
		and CustomSpawn.Start
		and CustomSpawn.Start == workspace.SpinMachine.SpawnZone

	local isRNGSpawn =
		CustomSpawn
		and CustomSpawn.Start
		and workspace:FindFirstChild("RNG Machine")
		and CustomSpawn.Start == workspace["RNG Machine"]:FindFirstChild("SpawnPart")

	if isFuseSpawn or isCupidSpawn or isCraftSpawn or isSpinSpawn or isRNGSpawn then
		createPurchasableAnimal(
			Animal,
			Mutation,
			Traits,
			Speed,
			CustomSpawn,
			StandFor
		)
		return
	end

	table.insert(NEXT_QUEUE, {
		Animal = Animal,
		Mutation = Mutation,
		Traits = Traits,
		Speed = Speed,
		CustomSpawn = CustomSpawn,
		AFKTime = StandFor
	})
end

function AnimalService.SpawnForcedAnimal(Animal: any)
	table.insert(NEXT_QUEUE, {
		Animal = Animal,
	})
end

function AnimalService.spawnFakeAnimal(Animal: any, Mutation: string?)
	table.insert(NEXT_QUEUE, {
		Animal = Animal,
		Mutation = Mutation,
		Traits = {},
		IsFake = true,
	})
end

function AnimalService.spawnAnimal(Animal: any)
	local FinalMutation: string?
	local FinalTraits: {string} = {}
	local ForceStraightLine = false

	for EventName, EventData in pairs(EventMutationsList) do
		local EventAttribute = ReplicatedStorage:GetAttribute(EventName)
		if EventAttribute ~= nil then
			if math.random(1, 100) <= EventData.Chance then
				FinalMutation = EventData.Mutation
				ForceStraightLine = true
				break
			end
		end
	end

	if not FinalMutation then
		if math.random(1, 10) == 1 then
			local TotalWeight = 0
			local WeightedMutations = {}

			for Name, Data in pairs(Mutations) do
				if Data.Weight and Data.Weight > 0 then
					TotalWeight += Data.Weight
					table.insert(WeightedMutations, {
						Name = Name,
						Weight = Data.Weight
					})
				end
			end

			if #WeightedMutations > 0 then
				local RandWeight = math.random() * TotalWeight
				local Cumulative = 0

				for _, Entry in ipairs(WeightedMutations) do
					Cumulative += Entry.Weight
					if RandWeight <= Cumulative then
						FinalMutation = Entry.Name
						break
					end
				end
			end
		end
	end

	createPurchasableAnimal(Animal, FinalMutation, FinalTraits, nil, nil, nil, ForceStraightLine)
end

local NEXT_ANIMAL: string?

function AnimalService.randomAnimal(Rarity: string?): any
	local Candidates = {}

	if NEXT_ANIMAL then
		local CurrentAnimal = NEXT_ANIMAL
		NEXT_ANIMAL = nil
		return Animals[CurrentAnimal]
	end

	for Name, Data in pairs(Animals) do
		if (not Rarity or Data.Rarity == Rarity) then
			table.insert(Candidates, {
				Name = Name,
				Data = Data
			})
		end
	end

	if #Candidates == 0 then
		return nil
	end

	local ServerLuck = Synchronizer:Get("ServerLuck")
	local LuckMultiplier = ServerLuck:Get("Index")
	if LuckMultiplier == 0 then
		LuckMultiplier = 1
	end

	local TotalWeight = 0
	local WeightedAnimals = {}

	for _, Entry in ipairs(Candidates) do
		local Data = Entry.Data
		if Data.RoadWeight and Data.RoadWeight > 0 then
			local AdjustedWeight = Data.RoadWeight

			if Data.Rarity then
				-- RarityPowers v2 : courbe équilibrée, plafonnée à 500x max
				-- Common=0 (luck n'affecte pas les communs pour préserver l'économie de base)
				-- Plus la rareté est haute, plus la luck a d'effet, mais de façon progressive
				local RarityPowers = {
					Common = 0,
					Rare = 0.3,
					Epic = 0.5,
					Legendary = 1.0,
					Mythic = 1.3,
					["Brainrot God"] = 2.0,
					Secret = 3.0,
					OG = 7.0,
					Cosmic = 4.5,
				}

				local Power = RarityPowers[Data.Rarity] or 0
				AdjustedWeight = AdjustedWeight * (LuckMultiplier ^ Power)
				AdjustedWeight = math.min(AdjustedWeight, 500)
			end

			TotalWeight = TotalWeight + AdjustedWeight
			table.insert(WeightedAnimals, {
				Name = Entry.Name,
				Weight = AdjustedWeight
			})
		end
	end

	if #WeightedAnimals == 0 then
		return nil
	end

	local RandomWeight = math.random() * TotalWeight
	local Cumulative = 0

	for _, Animal in ipairs(WeightedAnimals) do
		Cumulative = Cumulative + Animal.Weight
		if RandomWeight <= Cumulative then
			return Animals[Animal.Name]
		end
	end

	return nil
end

function AnimalService.SpawnRarityOnly(Rarity: string, Duration: number)
	ForcedRarity = Rarity
	ForcedRarityEndTime = os.time() + Duration

	task.delay(Duration, function()
		if ForcedRarity == Rarity and os.time() >= ForcedRarityEndTime then
			ForcedRarity = nil
			ForcedRarityEndTime = 0
		end
	end)
end

function AnimalService.SetSpeed(Speed: number)
	GlobalSpeedOverride = Speed
end

function AnimalService:Start()
	PurchaseRemote.OnServerEvent:Connect(function(Player: Player, Timestamp: number, SecurityKey: string, AnimalUID: string)
		local AnimalInfo = ActiveAnimals[AnimalUID]
		if not AnimalInfo then
			warn("Animal not found:", AnimalUID)
			return
		end

		if AnimalInfo.PurchaseFunction then
			AnimalInfo.PurchaseFunction(Player, false)
		end
	end)

	HoldBeganRemote.OnServerEvent:Connect(function(Player: Player, Timestamp: number, SecurityKey: string)
		if SecurityKey ~= "fa977cd5-427c-407c-a672-f287d64070ce" and SecurityKey ~= "a522d125-48d8-497c-a586-d42e60018a78" then
			warn("Invalid security key from", Player.Name)
			return
		end
	end)

	task.spawn(function()
		while true do
			if GuaranteedBrainrotGod > 0 then
				GuaranteedSecret -= 1
			end

			if GuaranteedSecret > 0 then
				GuaranteedSecret -= 1
			end

			createOrUpdateTimer(
				"Brainrot God",
				string.format(
					'Guaranteed <font color="#fbff00">Brainrot God</font> in %s',
					TimeUtils:B(GuaranteedBrainrotGod)
				)
			)

			createOrUpdateTimer(
				"Secret",
				string.format(
					'Guaranteed <font color="#ff0000">Secret</font> in %s',
					TimeUtils:B(GuaranteedSecret)
				)
			)

			task.wait(1)
		end
	end)

	while true do
		local RandomAnimal
		local FinalMutation: string?
		local FinalTraits: {string} = {}
		local ForceStraightLine = false
		local Skip = false

		for i, Data in pairs(NEXT_QUEUE) do
			table.remove(NEXT_QUEUE, i)
			Skip = true
			createPurchasableAnimal(Data.Animal, Data.Mutation, Data.Traits, Data.Speed, Data.CustomSpawn, Data.AFKTime, nil, Data.IsFake)
			break
		end

		if not Skip then
			if AnimalService.CaveSpawnActive then

				if os.time() < SpawnDelayEndTime then

				elseif PendingSpawnDelayAnimal then
					if not table.find(GameDataServerStorage.UnSpawnableBrainrots, PendingSpawnDelayAnimal.DisplayName) then
						AnimalService.spawnAnimal(PendingSpawnDelayAnimal)
					end
					PendingSpawnDelayAnimal = nil
				else
					if ForcedRarity and os.time() < ForcedRarityEndTime then
						repeat
							RandomAnimal = AnimalService.randomAnimal(ForcedRarity)
						until not RandomAnimal or not table.find(GameDataServerStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
					elseif YoIsTsModded then
						local AllAnimals = {}
						for Name, Data in pairs(Animals) do
							if not table.find(GameDataServerStorage.UnSpawnableBrainrots, Data.DisplayName) then
								table.insert(AllAnimals, Data)
							end
						end
						if #AllAnimals > 0 then
							RandomAnimal = AllAnimals[math.random(1, #AllAnimals)]
						end
					else
						repeat
							RandomAnimal = AnimalService.randomAnimal()
						until not RandomAnimal or not table.find(GameDataServerStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
					end

					if RandomAnimal then
						if RandomAnimal.SpawnDelay and RandomAnimal.SpawnDelay > 0 then
							PendingSpawnDelayAnimal = RandomAnimal
							SpawnDelayEndTime = os.time() + RandomAnimal.SpawnDelay
						else
							AnimalService.spawnAnimal(RandomAnimal)
						end
					end
				end
			else

				if YoIsTsModded then
					if os.time() < SpawnDelayEndTime then

					elseif PendingSpawnDelayAnimal then
						if not table.find(GameDataServerStorage.UnSpawnableBrainrots, PendingSpawnDelayAnimal.DisplayName) then
							AnimalService.spawnAnimal(PendingSpawnDelayAnimal)
						end
						PendingSpawnDelayAnimal = nil
					else
						local AllAnimals = {}
						for Name, Data in pairs(Animals) do
							if not table.find(GameDataServerStorage.UnSpawnableBrainrots, Data.DisplayName) then
								table.insert(AllAnimals, Data)
							end
						end
						if #AllAnimals > 0 then
							RandomAnimal = AllAnimals[math.random(1, #AllAnimals)]
						end

						if RandomAnimal then
							if math.random(1, 100) > 15 then
								local AllMutations = {}
								for Name, _ in pairs(Mutations) do
									table.insert(AllMutations, Name)
								end
								if #AllMutations > 0 then
									FinalMutation = AllMutations[math.random(1, #AllMutations)]
								end
							else
								FinalMutation = nil
							end
						end

						for EventName, EventData in pairs(EventMutationsList) do
							local EventAttribute = ReplicatedStorage:GetAttribute(EventName)
							if EventAttribute ~= nil then
								if math.random(1, 100) <= EventData.Chance then
									FinalMutation = EventData.Mutation
									ForceStraightLine = true
									break
								end
							end
						end

						if RandomAnimal then
							if RandomAnimal.SpawnDelay and RandomAnimal.SpawnDelay > 0 then
								PendingSpawnDelayAnimal = RandomAnimal
								SpawnDelayEndTime = os.time() + RandomAnimal.SpawnDelay
							else
								createPurchasableAnimal(RandomAnimal, FinalMutation, FinalTraits, nil, nil, nil, ForceStraightLine)
							end
						end
					end
				else

					if os.time() < SpawnDelayEndTime then

					elseif PendingSpawnDelayAnimal then
						if not table.find(GameDataServerStorage.UnSpawnableBrainrots, PendingSpawnDelayAnimal.DisplayName) then
							AnimalService.spawnAnimal(PendingSpawnDelayAnimal)
						end
						PendingSpawnDelayAnimal = nil
					else
						if ForcedRarity and os.time() < ForcedRarityEndTime then
							repeat
								RandomAnimal = AnimalService.randomAnimal(ForcedRarity)
							until not RandomAnimal or not table.find(GameDataServerStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
						elseif GuaranteedBrainrotGod == 0 then
							repeat
								RandomAnimal = AnimalService.randomAnimal("Brainrot God")
							until not RandomAnimal or not table.find(GameDataServerStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
							GuaranteedBrainrotGod = 900
						elseif GuaranteedSecret == 0 then
							repeat
								RandomAnimal = AnimalService.randomAnimal("Secret")
							until not RandomAnimal or not table.find(GameDataServerStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
							GuaranteedSecret = 1500
						else
							repeat
								RandomAnimal = AnimalService.randomAnimal()
							until not RandomAnimal or not table.find(GameDataServerStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
						end

						if RandomAnimal then
							if RandomAnimal.SpawnDelay and RandomAnimal.SpawnDelay > 0 then
								PendingSpawnDelayAnimal = RandomAnimal
								SpawnDelayEndTime = os.time() + RandomAnimal.SpawnDelay
							else
								AnimalService.spawnAnimal(RandomAnimal)
							end
						end
					end
				end
			end
		end

		local spawnInterval = (AnimalService.CaveSpawnActive and math.random(4, 5)) or GameData.RoadSpawn.SpawnEvery
		task.wait(spawnInterval)
	end
end

function AnimalService:AddTraits(AnimalModel: Model, Traits: {string})
	if not AnimalModel or not AnimalModel.Parent then
		warn("[AnimalService] Invalid animal model passed to AddTraits")
		return
	end
	local ExistingTraits = {}
	local TraitJson = AnimalModel:GetAttribute("Traits")

	if TraitJson then
		local Success, Decoded = pcall(HttpService.JSONDecode, HttpService, TraitJson)
		if Success and type(Decoded) == "table" then
			ExistingTraits = Decoded
		end
	end

	for _, NewTrait in ipairs(Traits) do
		local AlreadyHas = false
		for _, T in ipairs(ExistingTraits) do
			if T == NewTrait then
				AlreadyHas = true
				break
			end
		end
		if not AlreadyHas then
			table.insert(ExistingTraits, NewTrait)
		end
	end

	if #ExistingTraits > 0 then
		local Success, Result = pcall(HttpService.JSONEncode, HttpService, ExistingTraits)
		if Success then
			AnimalModel:SetAttribute("Traits", Result)
		else
			warn("[AnimalService] Failed to encode traits:", ExistingTraits)
		end
	else
		AnimalModel:SetAttribute("Traits", nil)
	end
end

return AnimalService