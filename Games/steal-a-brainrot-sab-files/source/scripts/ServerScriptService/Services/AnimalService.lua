local AnimalService = {}
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local PathfindingService = game:GetService("PathfindingService")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Net = require(ReplicatedStorage.Packages.Net)
local EventService = require(ServerScriptService.Services.EventService)
local OneByOneAlwaysActive = false
local function Is1x1x1x1Active()
	if EventService:GetActiveEvent("Backrooms") then
		return false
	end
	if OneByOneAlwaysActive then
		return true
	end
	return EventService:GetActiveEvent("1x1x1x1")
end
local LiveboardService = require(ServerScriptService.Services.LiveboardService)
local MessagingService = require(ServerScriptService.Services.MessagingService)
local FFlags                = require(ReplicatedStorage.Packages.FFlags)
local TOGGLE_MS_TOPIC       = "LiveboardToggle_Broadcast"
local TOGGLE_STORE_KEY      = "GlobalLiveboardFilterEnabled"
local LIVEBOARD_FILTER_LIST: { [string]: true } = {
	["Strawberry Elephant"] = true,
	["John Pork"]           = true,
	["Meowl"]               = true,
	["Skibidi Toilet"]      = true,
}
local excludedBlocks = {
	["Los Lucky Blocks"] = true, ["Los Festive Lucky Blocks"] = true,
	["Los Leprechaun Lucky Blocks"] = true, ["Los Spooky Lucky Blocks"] = true,
	["Los Heart Lucky Blocks"] = true, ["Los Secret Lucky Blocks"] = true,
	["Los Taco Blocks"] = true, ["Spooky Lucky Block"] = true,
	["Heart Lucky Block"] = true, ["Premium Heart Lucky Block"] = true,
	["Octo Lucky Block"] = true, ["Premium Octo Lucky Block"] = true,
	["Festive Lucky Block"] = true, ["Premium Festive Lucky Block"] = true,
	["Leprechaun Lucky Block"] = true, ["Premium Leprechaun Lucky Block"] = true,
	["Egg Lucky Block"] = true, ["Premium Egg Lucky Block"] = true,
	["Coffin Tung Tung Tung Sahur"] = true, ["Los Egg Lucky Blocks"] = true,
	["Los Duo Lucky Blocks"] = true,
}
local GlobalLiveboardFilterEnabled = false
local LIVEBOARD_TOPIC  = "Liveboard_Broadcast"
local LIVEBOARD_DISPLAY_DURATION = 120
local GameService = require(ServerScriptService.Services.GameService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local PlotService = require(ServerScriptService.Services.PlotService)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local ChatService = require(ServerScriptService.Services.ChatService)
local SoundService = require(ServerScriptService.Services.SoundService)
local LuckyBase = require(ServerScriptService.Services.EventService.Events["Lucky Base"])
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local BroadcastRemote = Net:RemoteEvent("AnimalService/Broadcast")
local CollectGoldElfRE = Net:RemoteEvent("SantaMerchantService/CollectGoldElf")
local CollectBrotinhoElfRE = Net:RemoteEvent("SantaMerchantService/CollectBrotinhoElf")
local COLLECTIBLE_ELVES = {
	["Gold Elf"]     = { Currency = "elf", },
	["Brotinho Elf"] = { Currency = "brotinho", },
}
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local CollectionService = game:GetService("CollectionService")
local Animals = require(ReplicatedStorage.Datas.Animals)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local ServerRoadWeights = require(ServerStorage.Modules.ServerRoadWeights)
local LuckyBlocks = require(ReplicatedStorage.Datas.LuckyBlocks)
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)
local GameData = require(ReplicatedStorage.Datas.Game)
local LuckyIndexData = require(ReplicatedStorage.Datas.Index)
local GameDataServerStorage = require(ReplicatedStorage.GameData)
local Trove = require(ReplicatedStorage.Packages.Trove)
local ANIMAL_SOUNDS = ReplicatedStorage.Sounds.Animals
local MainFrame = workspace.RoadPanel.SurfaceGui.MainFrame
local EventPathOccupied = false
local rotationSmoothness = 0.05
local GROUND_SINK_SPEED = 20
local GROUND_RISE_SPEED = 20
local GuaranteedLegendary = 300
local GuaranteedMythic = 900
local BEACON_DELAY = 2
local NEXT_QUEUE = {}
local SpawnDelayTable = {}
local MainRoadNextSpawnTime: number? = nil
local THREE_ROADS_QUEUE = {[2] = {}, [3] = {}}
local COFFIN_SAHUR_NAME = "Coffin Tung Tung Tung Sahur"
local COFFIN_WAIT_MIN = 4
local COFFIN_WAIT_MAX = 9
local COFFIN_DANCE_MIN = 2
local COFFIN_DANCE_MAX = 4
local COFFIN_RESUME_DELAY = 0.75
local function waitOrAbort(seconds, abortFn)
	local elapsed = 0
	while elapsed < seconds do
		if abortFn and abortFn() then
			return false
		end
		local step = math.min(0.1, seconds - elapsed)
		elapsed += task.wait(step)
	end
	return true
end
local function beginCoffinSahurCycle(AnimalModel, AnimalData, abortFn)
	if not AnimalModel or not AnimalData then return end
	if AnimalData.DisplayName ~= COFFIN_SAHUR_NAME then return end
	if AnimalModel:GetAttribute("CoffinSahurCycleStarted") then return end
	local soundtrove = Trove.new()
	AnimalModel:SetAttribute("CoffinSahurCycleStarted", true)
	local sound = ReplicatedStorage.Sounds.Others.Coffin:Clone()
	sound.RollOffMinDistance = 5
	sound.RollOffMaxDistance = 100
	sound.RollOffMode = Enum.RollOffMode.InverseTapered
	sound.TimePosition = 7.6
	sound.Parent = AnimalModel.PrimaryPart
	sound:Play()
	soundtrove:Add(function()
		sound:Destroy()
	end)
	task.spawn(function()
		while AnimalModel and AnimalModel.Parent do
			if abortFn and abortFn() then
				break
			end
			local ok = waitOrAbort(math.random(COFFIN_WAIT_MIN, COFFIN_WAIT_MAX), function()
				return (not AnimalModel) or (not AnimalModel.Parent) or (abortFn and abortFn())
			end)
			if not ok then break end
			if not AnimalModel or not AnimalModel.Parent then break end
			if AnimalModel:GetAttribute("ForceIdle")
				or AnimalModel:GetAttribute("Dance")
				or AnimalModel:GetAttribute("GroundDance") then
				continue
			end
			AnimalModel:SetAttribute("ForceIdle", true)
			task.wait(0.1)
			if not AnimalModel or not AnimalModel.Parent or (abortFn and abortFn()) then
				break
			end
			AnimalModel:SetAttribute("GroundDance", true)
			ok = waitOrAbort(math.random(COFFIN_DANCE_MIN, COFFIN_DANCE_MAX), function()
				return (not AnimalModel) or (not AnimalModel.Parent) or (abortFn and abortFn())
			end)
			if not AnimalModel or not AnimalModel.Parent then break end
			AnimalModel:SetAttribute("GroundDance", false)
			if not ok then break end
			ok = waitOrAbort(COFFIN_RESUME_DELAY, function()
				return (not AnimalModel) or (not AnimalModel.Parent) or (abortFn and abortFn())
			end)
			if not ok then break end
			if AnimalModel and AnimalModel.Parent then
				AnimalModel:SetAttribute("ForceIdle", false)
			end
		end
		if AnimalModel and AnimalModel.Parent then
			soundtrove:Destroy()
			AnimalModel:SetAttribute("GroundDance", false)
			AnimalModel:SetAttribute("Dance", false)
			AnimalModel:SetAttribute("ForceIdle", false)
		end
	end)
end
local ThreeRoadsData = {
	[2] = {GuaranteedLegendary = 300, GuaranteedMythic = 900, SpawnDelayEndTime = 0, SkipNextSpawn = false, InSyncGroup = true},
	[3] = {GuaranteedLegendary = 300, GuaranteedMythic = 900, SpawnDelayEndTime = 0, SkipNextSpawn = false, InSyncGroup = true},
}
local SyncEpoch: number? = nil
local function IsRoadInSyncGroup(roadIndex: number): boolean
	local rd = ThreeRoadsData[roadIndex]
	if not rd then return false end
	if rd.InSyncGroup == false then return false end
	return (rd.SpawnDelayEndTime or 0) <= os.clock()
end
local function AreSyncRoadsActive(): boolean
	return IsRoadInSyncGroup(2) and IsRoadInSyncGroup(3)
end
local function GetNextSyncTickAfter(afterTime: number?): number
	afterTime = afterTime or os.clock()
	local interval = GameData.RoadSpawn.SpawnEvery
	if not SyncEpoch or not interval or interval <= 0 then
		return afterTime
	end
	local elapsed = afterTime - SyncEpoch
	if elapsed < 0 then
		return SyncEpoch
	end
	local cycles = math.floor(elapsed / interval) + 1
	return SyncEpoch + cycles * interval
end
local function ScheduleSyncPaddingForRoad(roadIndex: number, spawnTime: number)
	local rd = ThreeRoadsData[roadIndex]
	if not rd then return end
	rd.SpawnDelayEndTime = GetNextSyncTickAfter(spawnTime)
end
local EventPathBusy = false
local PurchaseRemote = Net:RemoteEvent("156ed911-fc4b-4d24-a648-acd1e9761e4f")
local HoldBeganRemote = Net:RemoteEvent("f756228f-15f8-4b6d-93a4-dfe62bb409cb")
local ActiveAnimals = {}
local PurchaseLocks = {}
local LastPurchaseAttempt = {}
local ServerShuttingDown = false
local YoIsTsModded = false
local AprilFoolsMode = false
local TriggerEvent = true
local AprilFoolsLastSet = 0
local APRIL_FOOLS_COOLDOWN = 0.5
local EventMutationsList = {
	["BloodmoonEvent"] = {Chance = 5, Mutation = "Bloodrot"},
	["CandyEvent"] = {Chance = 5, Mutation = "Candy"},
	["MoltenEvent"] = {Chance = 5, Mutation = "Lava"},
	["YinYangEvent"] = {Chance = 5, Mutation = "YinYang"},
	["RadioactiveEvent"] = {Chance = 5, Mutation = "Radioactive"},
	["CursedEvent"] = {Chance = 5, Mutation = "Cursed"},
	["DivineEvent"] = {Chance = 5, Mutation = "Divine"},
	["RainbowEvent"] = {Chance = 5, Mutation = "Rainbow"},
	["GalaxyEvent"] = {Chance = 5, Mutation = "Galaxy"},
	["CyberEvent"] = {Chance = 5, Mutation = "Cyber"},
	["PhantomEvent"] = {Chance = 5, Mutation = "Phantom"},
}
local SoundSpecialRarities = {
	["Brainrot God"] = true,
	["Secret"] = true,
	["OG"] = true,
	["Admin"] = true,
	["Taco"] = true,
	["Spooky"] = true,
	["Festive"] = true,
	["Valentines"] = true,
	["St Patrick's"] = true,
	["Summer"] = true,
	["Easter"] = true
}
local BROADCAST_LIST = {
	["Los Admins"]              = { global = true },
	["Los Dragons Aquaninis"]              = { global = true },
	["Los Cocos and Mangos"]              = { global = true },
	["Smurf Cat"]              = { global = true },
	["Los Smurf Cats"]              = { global = true },
	["Los John Porks"]              = { global = true },
	["Los Steakinis Fattinis"]              = { global = true },
	["Los Skibidis"]             = { global = true },
	["La OG Combinasion"]             = { global = true },
	["Los Meowls"] = { global = true },
	["Sammy"]             = { global = true },
	["Jandel"]             = { global = true },
	["Los Headless"]             = { global = true },
	["Los Easter Combinasionas"]             = { global = true },
	["Los Tirilikalakos"]             = { global = true },
	["Los Carapaces"]             = { global = true },
	["Los Narwhals"]             = { global = true },
	["Los Ramenas"]             = { global = true },
	["Los Quackinis"]             = { global = true },
	["Los Elephants"]             = { global = true },
	["Los Spyder Elephants"]             = { global = true },
	["Los Ogs"]                 = { global = true },
	["Strawberry Elephant"]     = { global = false },
	["John Pork"]     = { global = false },
	["Meowl"]     = { global = false },
	["Skibidi Toilet"] = { global = false }
}
for itemName, itemData in pairs(Animals) do
	if itemData.Rarity == "Secret" and not BROADCAST_LIST[itemName] then
		BROADCAST_LIST[itemName] = { global = false }
	end
end
local ForcedRarity = nil
local ForcedRarityEndTime = 0
local GlobalSpeedOverride = nil
local RoadEnd = workspace.Road.End
local function fireBroadcast(
	msgType:    string,
	animalName: string,
	playerName: string?,
	isGlobal:   boolean,
	uid:        string,
	userId:     number?,
	mutation:   string?
)
	local effectiveGlobal = isGlobal
	if effectiveGlobal and GlobalLiveboardFilterEnabled and LIVEBOARD_FILTER_LIST[animalName] then
		effectiveGlobal = false
	end
	if msgType == "spawn" then
		LiveboardService:RecordSpawn(uid, animalName, mutation, not effectiveGlobal)
	elseif msgType == "claim" and userId and playerName then
		LiveboardService:RecordClaim(uid, userId, playerName)
	end
	if effectiveGlobal then
		pcall(function()
			MessagingService:PublishAsync(LIVEBOARD_TOPIC, {
				type         = msgType,
				uid          = uid,
				animal       = animalName,
				playerName   = playerName,
				userId       = userId,
				mutation     = mutation,
				originJobId  = game.JobId,
				isoTimestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
				readableTime = os.date("!%Y-%m-%d %H:%M:%S UTC"),
				displayName  = if userId
					then (game:GetService("Players"):GetPlayerByUserId(userId)
						and game:GetService("Players"):GetPlayerByUserId(userId).DisplayName)
					else nil,
			})
		end)
	end
end
local function ScheduleNextSpawnDelay(seconds, reason)
	if not seconds or seconds <= 0 then return end
	table.insert(SpawnDelayTable, { untilTime = os.clock() + seconds, reason = reason or "SpawnVFX" })
end
function AnimalService.SetRandomMode(enabled: boolean)
	YoIsTsModded = enabled
end
function AnimalService.SetAprilFoolsMode(enabled: boolean)
	if enabled and Is1x1x1x1Active() then
		warn("[AnimalService] Cannot enable April Fools mode while the 1x1x1x1 event is active.")
		return
	end
	local now = os.clock()
	if (now - AprilFoolsLastSet) < APRIL_FOOLS_COOLDOWN then return end
	AprilFoolsLastSet = now
	AprilFoolsMode = enabled
	ReplicatedStorage:SetAttribute("AprilFoolsMode", enabled)
	for _, entry in pairs(ActiveAnimals) do
		if entry.RedirectFunction then
			task.spawn(entry.RedirectFunction)
		end
	end
end
task.spawn(function()
	while true do
		task.wait(1)
		if AprilFoolsMode and Is1x1x1x1Active() then
			AprilFoolsMode = false
			AprilFoolsLastSet = os.clock()
			ReplicatedStorage:SetAttribute("AprilFoolsMode", false)
			for _, entry in pairs(ActiveAnimals) do
				if entry.RedirectFunction then
					task.spawn(entry.RedirectFunction)
				end
			end
		end
	end
end)
local ModdedRemote = Net:RemoteFunction("AdminService/ModdedBrainrots")
ModdedRemote.OnServerInvoke = function(Player)
	local IsAdmin = require(ReplicatedStorage.Shared.IsAdmin)
	if not IsAdmin(Player.UserId) then return false, false end
	local newState = AnimalService.ToggleModdedMode()
	return true, newState
end
local function getDynamicRayParams()
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	local ignoreList = {}
	for _, player in ipairs(game.Players:GetPlayers()) do
		if player.Character then table.insert(ignoreList, player.Character) end
	end
	params.FilterDescendantsInstances = ignoreList
	return params
end
local function preloadAnimalAnimations(animalIndex)
	local animFolder = ReplicatedStorage:WaitForChild("Animations").Animals:FindFirstChild(animalIndex)
	if not animFolder then return end
	local animsToLoad = {}
	for _, anim in animFolder:GetDescendants() do
		if anim:IsA("Animation") then
			table.insert(animsToLoad, anim)
		end
	end
	if #animsToLoad > 0 then
		game:GetService("ContentProvider"):PreloadAsync(animsToLoad)
	end
end
local function GetRemainingSpawnDelay(roadIndex: number?)
	if roadIndex == nil or roadIndex == 1 then
		local now = os.clock()
		local maxRemaining = 0
		for i = #SpawnDelayTable, 1, -1 do
			local entry = SpawnDelayTable[i]
			local remaining = (entry.untilTime or 0) - now
			if remaining <= 0 then
				table.remove(SpawnDelayTable, i)
			else
				if remaining > maxRemaining then maxRemaining = remaining end
			end
		end
		return maxRemaining
	elseif roadIndex == 2 or roadIndex == 3 then
		local roadData = ThreeRoadsData[roadIndex]
		if not roadData then return 0 end
		local now = os.clock()
		local endTime = roadData.SpawnDelayEndTime
		if endTime <= 0 then return 0 end
		local remaining = endTime - now
		return remaining > 0 and remaining or 0
	end
	return 0
end
local function getRoadParts(roadIndex: number)
	local mainRoad = workspace:FindFirstChild("Road")
	if not mainRoad then return nil, nil end
	local road = mainRoad:FindFirstChild(tostring(roadIndex))
	if not road then return nil, nil end
	return road:FindFirstChild("Start"), road:FindFirstChild("End")
end
local function GetRandomMutation()
	for EventName, EventData in pairs(EventMutationsList) do
		if ReplicatedStorage:GetAttribute(EventName) == true then
			if math.random(1, 100) <= EventData.Chance then
				return EventData.Mutation
			end
		end
	end
	if math.random(1, 10) == 1 then
		local TotalWeight = 0
		local WeightedMutations = {}
		for Name, Data in pairs(Mutations) do
			if Data.Weight and Data.Weight > 0 then
				TotalWeight += Data.Weight
				table.insert(WeightedMutations, { Name = Name, Weight = Data.Weight })
			end
		end
		if #WeightedMutations > 0 then
			local RandWeight = math.random() * TotalWeight
			local Cumulative = 0
			for _, Entry in ipairs(WeightedMutations) do
				Cumulative += Entry.Weight
				if RandWeight <= Cumulative then
					return Entry.Name
				end
			end
		end
	end
	return nil
end
function AnimalService:GetRandomMutation()
	return GetRandomMutation()
end
local function snapToGround(Position: Vector3, AnimalModel: Model, isEventRoad: boolean): Vector3
	local Origin    = Position + Vector3.new(0, 10, 0)
	local Direction = Vector3.new(0, -30, 0)
	if AnimalModel and AnimalModel:GetAttribute("OnBackroomsPath") then
		local backroomsList = {}
		for _, inst in ipairs(CollectionService:GetTagged("BackroomsCollison")) do
			table.insert(backroomsList, inst)
		end
		for _, part in ipairs(CollectionService:GetTagged("Carpet"))    do table.insert(backroomsList, part) end
		if #backroomsList == 0 then
			return Position
		end
		local backroomsParams = RaycastParams.new()
		backroomsParams.FilterType = Enum.RaycastFilterType.Include
		backroomsParams.FilterDescendantsInstances = backroomsList
		local backroomsResult = workspace:Raycast(Origin, Direction, backroomsParams)
		if backroomsResult then
			return backroomsResult.Position
		end
		return Position
	end
	local isDulDul           = (not isEventRoad) and EventService:GetActiveEvent("Dul Dul Dul")
	local is1x1x1            = (not isEventRoad) and Is1x1x1x1Active()
	local DivineStairsActive = (not isEventRoad) and ReplicatedStorage:GetAttribute("DivineStairsEnabled")
	local isDivineAnimal     = (not isEventRoad) and (AnimalModel:GetAttribute("Mutation") == "Divine") and DivineStairsActive
	local anyEventActive     = isDulDul or is1x1x1 or DivineStairsActive
	local includeList = {}
	local road = workspace:FindFirstChild("Road")
	if not isEventRoad then
		local taggedMaps = CollectionService:GetTagged("1x1x1x1Map")
		local onex1x1Map = taggedMaps[1]
		if onex1x1Map then
			local conveyorSystem = onex1x1Map:FindFirstChild("ConveyorSystem")
			local caveExtension  = CollectionService:GetTagged("CaveExtensionGround")
			if conveyorSystem then table.insert(includeList, conveyorSystem) end
			if caveExtension then
				for _, ext in ipairs(caveExtension) do
					table.insert(includeList, ext)
				end
			end
		end
		local craftMachine = workspace:FindFirstChild("CraftingMachine")
		if craftMachine and craftMachine:FindFirstChild("ChargePad") then
			table.insert(includeList, craftMachine.ChargePad)
		end
	end
	for _, part in ipairs(CollectionService:GetTagged("Ground"))    do table.insert(includeList, part) end
	for _, part in ipairs(CollectionService:GetTagged("Carpet"))    do table.insert(includeList, part) end
	for _, part in ipairs(CollectionService:GetTagged("roadcarpet")) do table.insert(includeList, part) end
	for _, inst in ipairs(CollectionService:GetTagged("WalkOver"))  do table.insert(includeList, inst) end
	for _, inst in ipairs(CollectionService:GetTagged("walkover"))  do table.insert(includeList, inst) end
	if workspace:FindFirstChild("CraftingMachine") then table.insert(includeList, workspace.CraftingMachine) end
	if workspace:FindFirstChild("BrainrotTrader") then table.insert(includeList, workspace["BrainrotTrader"]) end
	if workspace:FindFirstChild("EventBoard") then table.insert(includeList, workspace.EventBoard) end
	if workspace:FindFirstChild("Events") and workspace.Events:FindFirstChild("Stock")  then table.insert(includeList, workspace.Events.Stock) end
	if workspace:FindFirstChild("CyberSpinWheel") then table.insert(includeList, workspace.CyberSpinWheel) end
	if workspace:FindFirstChild("Shop") then table.insert(includeList, workspace.Shop) end
	if workspace:FindFirstChild("RobuxShop") then table.insert(includeList, workspace.RobuxShop) end
	if workspace:FindFirstChild("TradeMachine") then table.insert(includeList, workspace.TradeMachine) end
	if DivineStairsActive then
		local stairs = workspace:FindFirstChild("Stairs", true)
		if stairs then table.insert(includeList, stairs) end
	end
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = includeList
	local Result = workspace:Raycast(Origin, Direction, params)
	if Result then
		local instance = Result.Instance
		if DivineStairsActive then
			local stairs = workspace:FindFirstChild("Stairs", true)
			if stairs and (instance == stairs or instance:IsDescendantOf(stairs)) then
				return Result.Position
			end
		end
		if CollectionService:HasTag(instance, "Ground")     then return Result.Position end
		if CollectionService:HasTag(instance, "Carpet")     then return Result.Position end
		if CollectionService:HasTag(instance, "roadcarpet") then return Result.Position end
		if road and (instance == road or instance:IsDescendantOf(road)) then return Result.Position end
		local hitModel = instance:FindFirstAncestorOfClass("Model")
		if hitModel and CollectionService:HasTag(hitModel, "walkover") then return Result.Position end
		if CollectionService:HasTag(instance, "walkover") then return Result.Position end
		if anyEventActive then
			if is1x1x1 then
				local sideMap = workspace:FindFirstChild("1x1x1x1Map")
				if sideMap and instance:IsDescendantOf(sideMap) then
					if CollectionService:HasTag(instance, "carpet") or Result.Position.Y < Position.Y then
						return Result.Position
					end
					return Position
				end
			end
			if isDulDul then
				local hitModelDulDul = instance:FindFirstAncestorOfClass("Model")
				if hitModelDulDul and CollectionService:HasTag(hitModelDulDul, "walkover") then
					return Result.Position
				end
			end
		end
		return Result.Position
	end
	if isEventRoad then
		local backupParams = RaycastParams.new()
		backupParams.FilterType = Enum.RaycastFilterType.Exclude
		backupParams.FilterDescendantsInstances = { AnimalModel }
		local backupResult = workspace:Raycast(Origin, Direction, backupParams)
		if backupResult then return backupResult.Position end
		return Position
	end
	local RoadStart = road and road:FindFirstChild("Start")
	if RoadStart then
		if isDivineAnimal then
			local backupParams = RaycastParams.new()
			backupParams.FilterType = Enum.RaycastFilterType.Exclude
			backupParams.FilterDescendantsInstances = { AnimalModel }
			local backupResult = workspace:Raycast(Origin, Direction, backupParams)
			if backupResult then return backupResult.Position end
			return Position
		end
		return Vector3.new(Position.X, RoadStart.Position.Y, Position.Z)
	end
	return Position
end
local function randomAnimalForRoad(): any?
	local Candidates  = {}
	local TotalWeight = 0
	for Name, Weight in pairs(ServerRoadWeights) do
		local AnimalData = Animals[Name]
		if AnimalData and not table.find(GameDataServerStorage.UnSpawnableBrainrots or {}, AnimalData.DisplayName) then
			table.insert(Candidates, {Data = AnimalData, Weight = Weight})
			TotalWeight += Weight
		end
	end
	if TotalWeight <= 0 or #Candidates == 0 then return nil end
	local RandomNumber     = math.random() * TotalWeight
	local CumulativeWeight = 0
	for _, Entry in ipairs(Candidates) do
		CumulativeWeight += Entry.Weight
		if RandomNumber <= CumulativeWeight then return Entry.Data end
	end
	return Candidates[#Candidates].Data
end
local function getAnimalByRarityForRoad(Rarity: string): any?
	local Pool = {}
	for _, data in pairs(Animals) do
		if data.Rarity == Rarity then table.insert(Pool, data) end
	end
	if #Pool > 0 then return Pool[math.random(1, #Pool)] end
	return nil
end
local function CreateAnimal(args)
	local AnimalData          = args.AnimalData
	local Mutation            = args.Mutation
	local Traits              = args.Traits
	local Speed               = args.Speed or 10
	local CustomSpawn         = args.CustomSpawn
	local AFKTime             = args.AFKTime
	local ForceStraightLine   = args.ForceStraightLine or false
	local PreGeneratedId      = args.PreGeneratedId
	local isfake              = args.IsFake or false
	local isAnimalFakeInBase  = args.IsAnimalFakeInBase or false
	local RoadIndex           = args.RoadIndex
	local VfxAlreadyFired     = args.VfxAlreadyFired or false
	local CustomGeneration    = args.CustomGeneration
	local CustomRarity        = args.CustomRarity
	local CustomPrice         = args.CustomPrice
	local CustomDisplayName   = args.CustomDisplayName
	local CustomModelScale    = args.CustomModelScale
	local SkipSpawnDelay      = args.SkipSpawnDelay or false
	local CatchUpProgress     = args.CatchUpProgress
	if not AnimalData then
		warn("[AnimalService] CreateAnimal called without AnimalData")
		return
	end
	if not RoadIndex or RoadIndex > 3 or RoadIndex < 1 then
		RoadIndex = 1
	end
	local isEventRoad = RoadIndex ~= nil and RoadIndex ~= 1
	local roadStart, roadEnd
	if isEventRoad then
		roadStart, roadEnd = getRoadParts(RoadIndex)
		if not roadStart or not roadEnd then
			warn("[AnimalService] CreateAnimal – missing road parts for index", RoadIndex)
			return
		end
		if AprilFoolsMode then
			roadStart, roadEnd = roadEnd, roadStart
		end
	else
		roadStart = (CustomSpawn and CustomSpawn.Start) or workspace.Road.Start
		roadEnd   = workspace.Road.End
		if AprilFoolsMode and not CustomSpawn then
			roadStart = workspace.Road.End
			roadEnd   = workspace.Road.Start
		end
	end
	local MoveTarget          = roadEnd
	local IsBought            = false
	local PurchasingPlayer    = nil
	local ReservedPodiumIndex = nil
	local IsDestroying        = false
	local IsMoving            = false
	local MovementConnection  = nil
	local ForceIdleConnection = nil
	local CurrentPath
	local CurrentWaypoints
	local CurrentWaypointIndex = 1
	local MovementGeneration   = 0
	local animConn
	local morphEarlyDestroyConn
	local OriginalSpeed = Speed or GlobalSpeedOverride or GameData.RoadSpawn.AnimalSpeed or 15
	local AnimalName    = PreGeneratedId or HttpService:GenerateGUID(false)
	local DEST_THRESHOLD     = 2.5
	local originalSmoothness      = rotationSmoothness
	local currentAnimalSmoothness = originalSmoothness
	local startPosForStraight, totalHorizontalDist, startY, endY
	local indexName
	if AnimalData.LuckyBlock and not excludedBlocks[AnimalData.DisplayName] and not GameDataServerStorage[AnimalData.DisplayName] then
		indexName = string.format("%s %s", AnimalData.Rarity, AnimalData.DisplayName)
	else
		indexName = AnimalData.DisplayName
	end
	local FinalMutation = Mutation
	local isFuseSpawn  = (not isEventRoad) and CustomSpawn
		and (CustomSpawn.Start == workspace.FuseMachine.SpawnZone or CustomSpawn.Start == workspace:FindFirstChild("Witch Fuse").SpawnZone)
	local isCupidSpawn = (not isEventRoad) and CustomSpawn
		and CustomSpawn.Start == workspace.CupidsMachine.SpawnZone
	if (not isEventRoad) and CustomSpawn and CustomSpawn.Owner then
		task.spawn(function()
			pcall(function()
				Net:RemoteEvent("AnimalSpawnService/SpawnRequest"):FireClient(CustomSpawn.Owner, AnimalName)
			end)
		end)
	end
	if not isEventRoad then
		if Is1x1x1x1Active() then
			if AnimalData.SpawnVFX and AnimalData.SpawnDelay and AnimalData.SpawnDelay > 0 then
				ScheduleNextSpawnDelay(AnimalData.SpawnDelay, ("SpawnVFX:%s"):format(indexName))
			end
			if indexName == "1x1x1x1" or indexName == "Guest 666" or indexName == "John Doe" then
				Net:RemoteEvent("GameService/SpawnEffect"):FireAllClients("Cave_" .. indexName, 4.5)
				ScheduleNextSpawnDelay(4, ("SpawnVFX:%s"):format(indexName))
				local taggedMaps = CollectionService:GetTagged("1x1x1x1Map")
				local SideMap = taggedMaps[1]
				if SideMap then
					local door = SideMap.Lab.Printer:WaitForChild("Latch")
					if door then door:SetAttribute("Open", true) end
				end
				task.wait(3.5)
				local Sound = ANIMAL_SOUNDS:FindFirstChild(indexName)
				if Sound then
					for _, Player in game.Players:GetPlayers() do
						SoundService:Play(Player, Sound)
					end
				end
			end
		end
		if Is1x1x1x1Active() == nil then
			local DivineStairsActive = ReplicatedStorage:GetAttribute("DivineStairsEnabled")
			local isDivineActive     = (FinalMutation == "Divine" and DivineStairsActive)
			local isBackroomsActive  = EventService:GetActiveEvent("Backrooms") ~= nil
			if not SkipSpawnDelay and not isFuseSpawn and AnimalData.SpawnVFX and not isDivineActive and not CustomSpawn and not isBackroomsActive then
				local isCyberSpawn = (FinalMutation == "Cyber" and ReplicatedStorage:GetAttribute("CyberEvent") == true)
				local isPhantomSpawn = (FinalMutation == "Phantom" and ReplicatedStorage:GetAttribute("PhantomEvent") == true)
				if isCyberSpawn then
					Net:RemoteEvent("GameService/CyberBeaconAnimation"):FireAllClients()
					ScheduleNextSpawnDelay(BEACON_DELAY, ("CyberBeacon:%s"):format(indexName))
					task.wait(BEACON_DELAY)
				elseif isPhantomSpawn then
					Net:RemoteEvent("GameService/PhantomCaveFlash"):FireAllClients()
				end
				if indexName == "Matteo" then
					local MatteoSound = ReplicatedStorage.Sounds.Others:FindFirstChild("MatteoAppearanceVoice")
					if MatteoSound then
						for _, Player in game.Players:GetPlayers() do
							SoundService:Play(Player, MatteoSound)
						end
					end
				end
				Net:RemoteEvent("GameService/SpawnEffect"):FireAllClients(AnimalData.SpawnVFX, AnimalData.SpawnDelay, roadStart.CFrame)
				if AnimalData.SpawnDelay and AnimalData.SpawnDelay > 0 and not CustomSpawn then
					ScheduleNextSpawnDelay(AnimalData.SpawnDelay, ("SpawnVFX:%s"):format(indexName))
				end
				task.wait(AnimalData.SpawnDelay)
			elseif not SkipSpawnDelay and not isFuseSpawn and not isDivineActive and not CustomSpawn and not isBackroomsActive
				and FinalMutation == "Cyber" and ReplicatedStorage:GetAttribute("CyberEvent") == true then
				Net:RemoteEvent("GameService/CyberBeaconAnimation"):FireAllClients()
				ScheduleNextSpawnDelay(BEACON_DELAY, ("CyberBeacon:%s"):format(indexName))
				task.wait(BEACON_DELAY)
			elseif not SkipSpawnDelay and not isFuseSpawn and not isDivineActive and not CustomSpawn and not isBackroomsActive
				and FinalMutation == "Phantom" and ReplicatedStorage:GetAttribute("PhantomEvent") == true then
				Net:RemoteEvent("GameService/PhantomCaveFlash"):FireAllClients()
			end
			if TriggerEvent == true and not isFuseSpawn and not CustomSpawn and not isBackroomsActive then
				if AnimalData.DisplayName == "Los Ogs" then
					EventService:ExecuteEvent("Strawberry", 300)
					EventService:ExecuteEvent("Meowl", 300)
					EventService:ExecuteEvent("Skibidi", 300)
				elseif AnimalData.DisplayName == "Los Admins" then
					EventService:ExecuteEvent("Phase 1: Sleepy", 300)
					EventService:ExecuteEvent("Sammyni Spyderini", 300)
				elseif AnimalData.TriggerEvent then
					local triggerDelay   = AnimalData.TriggerEventDelay or 0
					local triggerEvent   = AnimalData.TriggerEvent
					local triggerOptions = AnimalData.TriggerEventOptions

					if triggerDelay > 0 then
						task.delay(triggerDelay, function()
							if not IsDestroying then
								EventService:ExecuteEvent(triggerEvent, nil, nil, triggerOptions)
							end
						end)
					else
						EventService:ExecuteEvent(triggerEvent, nil, nil, triggerOptions)
					end
				end
			end
		end
	else
		if AnimalData.SpawnVFX and not VfxAlreadyFired then
			Net:RemoteEvent("GameService/SpawnEffect"):FireAllClients(
				AnimalData.SpawnVFX,
				AnimalData.SpawnDelay,
				roadStart.CFrame
			)
		end
		if TriggerEvent == true then
			if AnimalData.DisplayName == "Los Ogs" then
				EventService:ExecuteEvent("Strawberry", 300)
				EventService:ExecuteEvent("Meowl", 300)
				EventService:ExecuteEvent("Skibidi", 300)
			elseif AnimalData.DisplayName == "Los Admins" then
				EventService:ExecuteEvent("Phase 1: Sleepy", 300)
				EventService:ExecuteEvent("Sammyni Spyderini", 300)
			elseif AnimalData.TriggerEvent then
				local triggerDelay = AnimalData.TriggerEventDelay or 0
				local triggerEvent = AnimalData.TriggerEvent
				if triggerDelay > 0 then
					task.delay(triggerDelay, function()
						if not IsDestroying then
							EventService:ExecuteEvent(triggerEvent)
						end
					end)
				else
					EventService:ExecuteEvent(triggerEvent, nil, nil, AnimalData.TriggerEventOptions)
				end
			end
		end
	end
	local AnimalModel       = Instance.new("Model")
	AnimalModel.Name        = AnimalName
	if isCupidSpawn then
		AnimalModel:SetAttribute("IsCupidSpawn", true)
	end
	local AnimalPart        = Instance.new("Part")
	AnimalPart.Size         = Vector3.new(1, 1, 1)
	AnimalPart.Transparency = 1
	AnimalPart.Anchored     = true
	AnimalPart.CanCollide   = false
	AnimalPart.CanQuery     = false
	AnimalPart.CanTouch     = false
	AnimalPart.Parent       = AnimalModel
	local PromptAttachment    = Instance.new("Attachment")
	PromptAttachment.Name     = "PromptAttachment"
	PromptAttachment.Position = Vector3.new(0, 1.714, 0)
	PromptAttachment.Parent   = AnimalPart
	AnimalModel.PrimaryPart = AnimalPart
	AnimalModel.Parent      = workspace
	if CollectionService:HasTag(AnimalPart, "IndonesiaCanoe") then
		currentAnimalSmoothness = 1
	end
	local DivineStairsActive = ReplicatedStorage:GetAttribute("DivineStairsEnabled")
	local isDivine           = (FinalMutation == "Divine")
	local StartPos
	if (not isEventRoad) and isDivine and DivineStairsActive then
		task.spawn(function()
			local RandomAnimalData = AnimalService.randomAnimal()
			if RandomAnimalData then
				AnimalService:SpawnNoDelay(RandomAnimalData, nil, {}, Speed, nil, AFKTime, ForceStraightLine)
			end
		end)
		local DivineFolder = workspace.Events:FindFirstChild("Divine")
		local DivineStart  = DivineFolder and DivineFolder:FindFirstChild("Start")
		if DivineStart then
			StartPos = DivineStart.Position
		else
			StartPos = roadStart.Position
		end
		task.spawn(function()
			task.wait(0.5)
			local soundPlayed, pauseTriggered = false, false
			while AnimalPart and AnimalPart.Parent and not IsDestroying do
				if IsBought then break end
				local distance = (AnimalPart.Position - workspace.Road.Start.Position).Magnitude
				if distance < 30 and not pauseTriggered then
					pauseTriggered = true
					AnimalService:PauseSpawning()
					task.delay(3, function() AnimalService:UnpauseSpawning() end)
				end
				if distance < 8 and not soundPlayed then
					soundPlayed = true
					AnimalModel:SetAttribute("DivineSoundPlayed", true)
					if SoundSpecialRarities[AnimalData.Rarity] then
						local Sound = ANIMAL_SOUNDS:FindFirstChild(indexName)
						if Sound then
							for _, Player in game.Players:GetPlayers() do
								SoundService:Play(Player, Sound)
							end
						end
					end
					break
				end
				task.wait(0.1)
			end
		end)
	else
		StartPos = (CustomSpawn and CustomSpawn.Start and CustomSpawn.Start.Position)
			or roadStart.Position
	end
	local LookAtPos       = roadEnd.Position
	local LookAtFlat      = Vector3.new(LookAtPos.X, StartPos.Y, LookAtPos.Z)
	local forwardDir      = (LookAtFlat - StartPos).Unit
	local initialFacingCF = CFrame.lookAt(StartPos, StartPos + forwardDir)
	local SPAWN_HOVER_HEIGHT = 0.3
	if not isEventRoad then
		if not Is1x1x1x1Active() then
			AnimalModel:PivotTo(initialFacingCF * CFrame.new(0, SPAWN_HOVER_HEIGHT, 0))
		else
			local dropHeight = -3
			AnimalModel:PivotTo(initialFacingCF * CFrame.new(0, dropHeight, 0))
		end
	else
		AnimalModel:PivotTo(initialFacingCF * CFrame.new(0, SPAWN_HOVER_HEIGHT, 0))
	end
	local function claimCollectibleElf(claimingPlayer)
		if IsDestroying then return false end
		local elfCfg = COLLECTIBLE_ELVES[AnimalData.DisplayName]
		if not elfCfg then return false end
		IsDestroying = true
		if MovementConnection then MovementConnection:Disconnect(); MovementConnection = nil end
		IsMoving = false
		local claimCFrame = (AnimalPart and AnimalPart.Parent and AnimalPart.CFrame)
			or (AnimalModel and AnimalModel.Parent and AnimalModel:GetPivot())
			or CFrame.new()
		if claimingPlayer and ReservedPodiumIndex then
			PlotService.RemoveFromQueue(claimingPlayer, ReservedPodiumIndex)
			ReservedPodiumIndex = nil
		end
		if claimingPlayer then
			pcall(function()
				local SantaMerchantService = require(ServerScriptService.Services.SantaMerchantService)
				SantaMerchantService:AddCurrency(claimingPlayer, elfCfg.Currency, 1)
			end)
			pcall(function()
				CollectGoldElfRE:FireClient(claimingPlayer, claimingPlayer, claimCFrame, elfCfg.Currency)
			end)
		end
		if AnimalModel and AnimalModel.Parent then
			AnimalModel:Destroy()
		end
		return true
	end
	local skipChat = (not isEventRoad) and (Is1x1x1x1Active() or EventService:GetActiveEvent("Backrooms"))
	if not skipChat then
		if AnimalData.Rarity == "Secret" and AnimalData.DisplayName ~= "Lucky Block" then
			ChatService:SendMessage("<font color='#000000'>[SERVER] A secret Brainrot has spawned!</font>")
		elseif AnimalData.Rarity == "OG" then
			ChatService:SendMessage("<font color='#FFD700'>[SERVER] A " .. AnimalData.DisplayName .. " has spawned!</font>")
		end
		if AnimalData.DisplayName == "Lucky Block" then
			if AnimalData.Rarity == "Admin" then
				ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Admin Lucky Block</font><font color='#d1d202'> has spawned!</font>")
			elseif AnimalData.Rarity == "Spooky" then
				ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Spooky Lucky Block</font><font color='#d1d202'> has spawned!</font>")
			elseif AnimalData.Rarity == "Taco" then
				ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Taco Lucky Block</font><font color='#d1d202'> has spawned!</font>")
			elseif AnimalData.Rarity == "Brainrot God" then
				ChatService:SendMessage("<font color='#22afe2'>[SERVER] A Brainrot God Lucky Block has spawned!</font>")
			elseif AnimalData.Rarity == "Secret" and AnimalData.DisplayName == "Coffin Tung Tung Tung Sahur" then
				ChatService:SendMessage("<font color='#000000'>[SERVER] A Coffin Tung Tung Tung Sahur has spawned!</font>")
			elseif AnimalData.Rarity == "Secret" then
				ChatService:SendMessage("<font color='#000000'>[SERVER] A Secret Lucky Block has spawned!</font>")
			end
		end
	end
	if FinalMutation then AnimalModel:SetAttribute("Mutation", FinalMutation) end
	AnimalModel:SetAttribute("Speed", OriginalSpeed)
	AnimalModel:SetAttribute("IsFake", isfake)
	AnimalModel:SetAttribute("IsAnimalFakeInBase", isAnimalFakeInBase)
	if AnimalData.Price       then AnimalModel:SetAttribute("CustomPrice",      AnimalData.Price)      end
	if AnimalData.Rarity      then AnimalModel:SetAttribute("CustomRarity",     AnimalData.Rarity)     end
	if AnimalData.Generation  then AnimalModel:SetAttribute("CustomGeneration", AnimalData.Generation) end
	local FinalCustomDisplayName = CustomDisplayName or AnimalData.CustomDisplayName
	local FinalCustomModelScale  = CustomModelScale  or AnimalData.CustomModelScale
	if FinalCustomDisplayName then AnimalModel:SetAttribute("CustomDisplayName", FinalCustomDisplayName) end
	if FinalCustomModelScale  then AnimalModel:SetAttribute("CustomModelScale",  FinalCustomModelScale)  end
	if AnimalData.HideOverhead then AnimalModel:SetAttribute("HideOverhead", true) end
	if Traits and #Traits > 0 then
		local ok, encoded = pcall(HttpService.JSONEncode, HttpService, Traits)
		if ok then AnimalModel:SetAttribute("Traits", encoded)
		else warn("Failed to encode traits:", Traits) end
	end
	AnimalModel:SetAttribute("Index", indexName)
	if isEventRoad then
		AnimalModel:SetAttribute("EventAnimal", true)
		AnimalModel:SetAttribute("EventRoad",   RoadIndex)
		AnimalModel:AddTag("EventAnimal")
		AnimalModel:AddTag("Animal")
	else
		if Is1x1x1x1Active() and not CustomSpawn then
			AnimalModel:AddTag("1x1x1x1animal")
		elseif EventService:GetActiveEvent("Backrooms")  and not CustomSpawn then
			AnimalModel:AddTag("BackroomsAnimal")
		else
			AnimalModel:AddTag("Animal")
		end
	end
	if isEventRoad and SoundSpecialRarities[AnimalData.Rarity] then
		local Sound = ANIMAL_SOUNDS:FindFirstChild(indexName)
		if Sound then
			for _, Player in game.Players:GetPlayers() do
				SoundService:Play(Player, Sound)
			end
		end
	end
	if isfake then
		local function setupMorphEarlyDestroy()
			if morphEarlyDestroyConn or IsDestroying then return end
			morphEarlyDestroyConn = Net:RemoteEvent("SpawnFakeBrainrot/EarlyDestroy").OnServerEvent:Connect(function(player, targetId)
				if targetId ~= AnimalName or IsDestroying then return end
				IsDestroying = true
				if morphEarlyDestroyConn then morphEarlyDestroyConn:Disconnect(); morphEarlyDestroyConn = nil end
				if MovementConnection then MovementConnection:Disconnect(); MovementConnection = nil end
				IsMoving = false
				if AnimalModel and AnimalModel.Parent and AnimalPart then
					local vfxPosition = AnimalPart.Position + Vector3.new(0, 1, 0)
					pcall(function()
						Net:RemoteEvent("SpawnFakeBrainrot/Poof"):FireAllClients({Position = vfxPosition})
					end)
					pcall(function()
						Net:RemoteEvent("SpawnFakeBrainrot/Camera"):FireClient(player, nil, nil)
					end)
					task.wait(0.1)
					AnimalModel:Destroy()
				end
			end)
		end
		if AnimalModel:GetAttribute("IsMorphAnimal") then setupMorphEarlyDestroy() end
		local morphAttrConn
		morphAttrConn = AnimalModel.AttributeChanged:Connect(function(attrName)
			if attrName == "IsMorphAnimal" and AnimalModel:GetAttribute("IsMorphAnimal") then
				if morphAttrConn then morphAttrConn:Disconnect(); morphAttrConn = nil end
				setupMorphEarlyDestroy()
			end
		end)
		AnimalModel.Destroying:Once(function()
			if morphAttrConn then morphAttrConn:Disconnect(); morphAttrConn = nil end
		end)
	end
	local Prompt
	local pendingTargetUserId
	local function spawnPrompt()
		if not AnimalModel or not AnimalModel.Parent then return end
		if Prompt and Prompt.Parent then return end
		if AnimalData.DisplayName == "Wheelchair Granny" then return end
		Prompt = Instance.new("ProximityPrompt")
		Prompt.ObjectText          = string.format("%s $%s", AnimalData.DisplayName, NumberUtils.ToString(nil, AnimalData.Price))
		Prompt.ActionText          = "Purchase"
		Prompt.HoldDuration        = 0.25
		Prompt.RequiresLineOfSight = true
		Prompt.Parent              = PromptAttachment
		Prompt:AddTag("AnimalPurchasePrompt")
		Prompt:SetAttribute("Disabled", false)
		Prompt:SetAttribute("UID",       AnimalName)
		if pendingTargetUserId then
			Prompt:SetAttribute("TargetPlayer", pendingTargetUserId)
		end
	end
	ActiveAnimals[AnimalName] = {
		Model            = AnimalModel,
		Data             = AnimalData,
		PurchaseFunction = nil,
	}
	local function onDestinationReached()
		if IsDestroying then return end
		IsDestroying = true
		if MovementConnection then MovementConnection:Disconnect(); MovementConnection = nil end
		IsMoving = false
		if not AnimalModel or not AnimalModel.Parent or not AnimalPart or not MoveTarget then
			if AnimalModel and AnimalModel.Parent then AnimalModel:Destroy() end
			if PurchasingPlayer and ReservedPodiumIndex then
				PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
			end
			return
		end
		if isfake and AnimalModel:GetAttribute("IsMorphAnimal") then
			if morphEarlyDestroyConn then morphEarlyDestroyConn:Disconnect(); morphEarlyDestroyConn = nil end
			if AnimalPart and AnimalPart.Parent then
				local vfxPosition = AnimalPart.Position + Vector3.new(0, 1, 0)
				pcall(function()
					Net:RemoteEvent("SpawnFakeBrainrot/Poof"):FireAllClients({Position = vfxPosition})
				end)
				if PurchasingPlayer then
					pcall(function()
						Net:RemoteEvent("SpawnFakeBrainrot/Camera"):FireClient(PurchasingPlayer, nil, nil)
					end)
				end
				task.wait(0.1)
			end
			AnimalModel:Destroy()
			return
		end
		if IsBought and PurchasingPlayer then
			if claimCollectibleElf(PurchasingPlayer) then
				return
			end
			local PlayerChannel = Synchronizer:Get(PurchasingPlayer)
			if not PlayerChannel then
				PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
				AnimalModel:Destroy(); return
			end
			local Plot = PlotService.getPlot(PurchasingPlayer)
			if not Plot then
				PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
				AnimalModel:Destroy(); return
			end
			local AnimalPodiums = PlayerChannel:Get("AnimalPodiums") or {}
			local IndexData     = PlayerChannel:Get("Index") or {}
			if not ReservedPodiumIndex then
				PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
				AnimalModel:Destroy(); return
			end
			local targetPodium = Plot.AnimalPodiums:FindFirstChild(tostring(ReservedPodiumIndex))
			if not targetPodium then
				PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
				AnimalModel:Destroy(); return
			end
			local PodiumData = AnimalPodiums[ReservedPodiumIndex]
			if PodiumData and PodiumData ~= "Empty" then
				PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
				AnimalModel:Destroy(); return
			end
			local BetterPodium = PlotService.getFreePodium(PurchasingPlayer)
			if BetterPodium then
				local BetterIndex = tonumber(BetterPodium.Name)
				if BetterIndex and BetterIndex < ReservedPodiumIndex then
					local BetterData = AnimalPodiums[BetterIndex]
					if BetterData == nil or BetterData == "Empty" then
						PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
						ReservedPodiumIndex = BetterIndex
						PlotService.AddToQueue(PurchasingPlayer, ReservedPodiumIndex)
						targetPodium = Plot.AnimalPodiums:FindFirstChild(tostring(ReservedPodiumIndex))
						if not targetPodium then
							PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
							AnimalModel:Destroy(); return
						end
					end
				end
			end
			local FinalIndex = AnimalModel:GetAttribute("Index")
			local FinalMut   = AnimalModel:GetAttribute("Mutation")
			if not FinalIndex or FinalIndex == "" then
				PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
				AnimalModel:Destroy(); return
			end
			if not isAnimalFakeInBase and not AnimalData.LuckyBlock then
				IndexData[FinalIndex] = IndexData[FinalIndex] or {}
				if FinalMut then
					IndexData[FinalIndex][FinalMut] = (tonumber(IndexData[FinalIndex][FinalMut]) or 0) + 1
				else
					IndexData[FinalIndex].Default = (tonumber(IndexData[FinalIndex].Default) or 0) + 1
				end
			end
			local FinalTraits
			local TraitJson = AnimalModel:GetAttribute("Traits")
			if TraitJson then
				local ok, decoded = pcall(HttpService.JSONDecode, HttpService, TraitJson)
				if ok then FinalTraits = decoded end
			end
			AnimalPodiums[ReservedPodiumIndex] = {
				Index             = FinalIndex,
				LastCollect       = workspace:GetServerTimeNow(),
				Mutation          = FinalMut,
				Traits            = FinalTraits,
				Timer             = AnimalData.LuckyBlock and 0 or nil,
				CustomPrice       = CustomPrice or (AnimalData.Price ~= Animals[FinalIndex].Price and AnimalData.Price or nil),
				CustomRarity      = CustomRarity or (AnimalData.Rarity ~= Animals[FinalIndex].Rarity and AnimalData.Rarity or nil),
				CustomGeneration  = CustomGeneration or AnimalData.Generation or nil,
				CustomDisplayName = FinalCustomDisplayName or nil,
				CustomModelScale  = FinalCustomModelScale  or nil,
				isfake            = isAnimalFakeInBase and true or nil,
			}
			PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
			if not isAnimalFakeInBase then
				local GenerationAmount = SharedAnimals:GetGeneration(FinalIndex, FinalMut, FinalTraits, PurchasingPlayer)
				PlayerChannel:Increase("Generation", GenerationAmount)
				local LuckyIndex = LuckyIndexData.Lucky and LuckyIndexData.Lucky.Index
				if LuckyIndex and LuckyIndex[FinalIndex] then
					IndexData[FinalIndex] = IndexData[FinalIndex] or {}
					IndexData[FinalIndex].Lucky = true
				end
			end
			PlayerChannel:Set("Index",                IndexData)
			PlayerChannel:Set("AnimalPodiums",        AnimalPodiums)
			PlayerChannel:Set("AnimalAddedOrRemoved", true)
			local broadcastCfg = BROADCAST_LIST[AnimalData.DisplayName]
			if broadcastCfg then
				fireBroadcast("claim", AnimalData.DisplayName, PurchasingPlayer.DisplayName,
					broadcastCfg.global, AnimalName, PurchasingPlayer.UserId, nil)
			end
		end
		AnimalModel:Destroy()
	end
	if ActiveAnimals[AnimalName] then
		ActiveAnimals[AnimalName].ForceDepositForPlayerIfBought = function(targetPlayer)
			if IsDestroying then return false end
			if not (IsBought and PurchasingPlayer) then return false end
			if targetPlayer and PurchasingPlayer ~= targetPlayer then return false end
			if not ReservedPodiumIndex then return false end
			local PlayerChannel = Synchronizer:Get(PurchasingPlayer)
			if not PlayerChannel then return false end
			local AnimalPodiums = PlayerChannel:Get("AnimalPodiums") or {}
			local IndexData     = PlayerChannel:Get("Index") or {}
			local PodiumData = AnimalPodiums[ReservedPodiumIndex]
			if PodiumData and PodiumData ~= "Empty" then return false end
			local FinalIndex = AnimalModel and AnimalModel:GetAttribute("Index")
			local FinalMut   = AnimalModel and AnimalModel:GetAttribute("Mutation")
			if not FinalIndex or FinalIndex == "" then return false end
			IsDestroying = true
			if not isAnimalFakeInBase and not AnimalData.LuckyBlock then
				IndexData[FinalIndex] = IndexData[FinalIndex] or {}
				if FinalMut then
					IndexData[FinalIndex][FinalMut] = (tonumber(IndexData[FinalIndex][FinalMut]) or 0) + 1
				else
					IndexData[FinalIndex].Default = (tonumber(IndexData[FinalIndex].Default) or 0) + 1
				end
			end
			local FinalTraits
			local TraitJson = AnimalModel and AnimalModel:GetAttribute("Traits")
			if TraitJson then
				local ok, decoded = pcall(HttpService.JSONDecode, HttpService, TraitJson)
				if ok then FinalTraits = decoded end
			end
			AnimalPodiums[ReservedPodiumIndex] = {
				Index             = FinalIndex,
				LastCollect       = workspace:GetServerTimeNow(),
				Mutation          = FinalMut,
				Traits            = FinalTraits,
				Timer             = AnimalData.LuckyBlock and 0 or nil,
				CustomPrice       = CustomPrice or (Animals[FinalIndex] and AnimalData.Price ~= Animals[FinalIndex].Price and AnimalData.Price or nil),
				CustomRarity      = CustomRarity or (Animals[FinalIndex] and AnimalData.Rarity ~= Animals[FinalIndex].Rarity and AnimalData.Rarity or nil),
				CustomGeneration  = CustomGeneration or AnimalData.Generation or nil,
				CustomDisplayName = FinalCustomDisplayName or nil,
				CustomModelScale  = FinalCustomModelScale  or nil,
				isfake            = isAnimalFakeInBase and true or nil,
			}
			if not isAnimalFakeInBase then
				local genOk, GenerationAmount = pcall(function()
					return SharedAnimals:GetGeneration(FinalIndex, FinalMut, FinalTraits, PurchasingPlayer)
				end)
				if genOk and GenerationAmount then
					PlayerChannel:Increase("Generation", GenerationAmount)
				end
				local LuckyIndex = LuckyIndexData.Lucky and LuckyIndexData.Lucky.Index
				if LuckyIndex and LuckyIndex[FinalIndex] then
					IndexData[FinalIndex] = IndexData[FinalIndex] or {}
					IndexData[FinalIndex].Lucky = true
				end
			end
			PlayerChannel:Set("Index",                IndexData)
			PlayerChannel:Set("AnimalPodiums",        AnimalPodiums)
			PlayerChannel:Set("AnimalAddedOrRemoved", true)
			pcall(function() PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex) end)
			if AnimalModel and AnimalModel.Parent then AnimalModel:Destroy() end
			return true
		end
	end
	local function MoveAlongPath(Target)
		if IsDestroying or not AnimalModel or not AnimalPart then return end
		if MovementConnection then MovementConnection:Disconnect(); MovementConnection = nil end
		IsMoving = true
		local isFirstMovementFrame = true
		startPosForStraight = AnimalPart.Position
		local endPos = Target.Position
		totalHorizontalDist = (Vector3.new(endPos.X, 0, endPos.Z)
			- Vector3.new(startPosForStraight.X, 0, startPosForStraight.Z)).Magnitude
		startY, endY = startPosForStraight.Y, endPos.Y
		if EventService:GetActiveEvent("Dul Dul Dul") then
			ForceStraightLine = true
		end
		MovementGeneration += 1
		local thisGeneration = MovementGeneration
		CurrentWaypoints     = nil
		CurrentWaypointIndex = 1
		if not ForceStraightLine then
			task.spawn(function()
				local costs = { Avoid = math.huge }
				local thisIsCupidSpawn = (not isEventRoad) and CustomSpawn
					and CustomSpawn.Start == workspace.CupidsMachine.SpawnZone
				if thisIsCupidSpawn then costs.CupidsMachine = math.huge end
				local path = PathfindingService:CreatePath({
					AgentCanJump = true,
					AgentRadius  = 1,
					Costs        = costs,
				})
				local ok = pcall(function()
					path:ComputeAsync(startPosForStraight, Target.Position)
				end)
				if thisGeneration ~= MovementGeneration then return end
				if IsDestroying or not AnimalModel or not AnimalModel.Parent or not AnimalPart then return end
				if ok and path.Status == Enum.PathStatus.Success then
					CurrentPath = path
					local waypoints = path:GetWaypoints()
					local startIdx  = 1
					for i = 1, math.min(5, #waypoints) do
						if (waypoints[i].Position - AnimalPart.Position).Magnitude < 3 then
							startIdx = i + 1
						else break end
					end
					CurrentWaypointIndex = startIdx
					CurrentWaypoints     = waypoints
				end
			end)
		end
		MovementConnection = RunService.Heartbeat:Connect(function(dt)
			if isEventRoad and not EventService:IsEventActive("3 Roads") then
				if MovementConnection then MovementConnection:Disconnect(); MovementConnection = nil end
				return
			end
			if not isEventRoad then
				local isDivineActive = (FinalMutation == "Divine" and ReplicatedStorage:GetAttribute("DivineStairsEnabled"))
				if isDivineActive then
					local DivineFolder = workspace.Events:FindFirstChild("Divine")
					local StairsRef    = DivineFolder and DivineFolder:FindFirstChild("Stairs")
					if StairsRef then
						local stairPos = StairsRef:IsA("Model") and StairsRef:GetPivot().Position or StairsRef.Position
						local dist     = (AnimalPart.Position - stairPos).Magnitude
						local currently = AnimalModel:GetAttribute("InDivineRoad")
						if not IsBought then
							if dist < 80 and not currently then
								AnimalModel:SetAttribute("InDivineRoad", true)
							elseif dist >= 80 and currently then
								AnimalModel:SetAttribute("InDivineRoad", nil)
							end
						elseif currently then
							AnimalModel:SetAttribute("InDivineRoad", nil)
						end
					end
				end
			end
			if IsDestroying or not AnimalModel.Parent or not AnimalPart.Parent
				or AnimalModel:GetAttribute("ForceIdle") then
				if MovementConnection then MovementConnection:Disconnect(); MovementConnection = nil end
				IsMoving = false
				return
			end
			local CurrentSpeed = GlobalSpeedOverride or OriginalSpeed
			local targetPosition
			if not ForceStraightLine and CurrentWaypoints and CurrentWaypointIndex <= #CurrentWaypoints then
				local waypoint = CurrentWaypoints[CurrentWaypointIndex]
				targetPosition = waypoint.Position
				local horizTarget = Vector3.new(targetPosition.X, AnimalPart.Position.Y, targetPosition.Z)
				if (horizTarget - AnimalPart.Position).Magnitude < 2 then
					CurrentWaypointIndex += 1
					if CurrentWaypointIndex > #CurrentWaypoints then
						CurrentWaypoints = nil
						targetPosition   = Target.Position
						if (targetPosition - AnimalPart.Position).Magnitude < DEST_THRESHOLD then
							MovementConnection:Disconnect(); MovementConnection = nil
							IsMoving = false
							task.spawn(onDestinationReached)
							return
						end
					else
						return
					end
				end
			else
				targetPosition = Target.Position
				if (targetPosition - AnimalPart.Position).Magnitude < DEST_THRESHOLD then
					MovementConnection:Disconnect(); MovementConnection = nil
					IsMoving = false
					task.spawn(onDestinationReached)
					return
				end
			end
			local HorizTarget = Vector3.new(targetPosition.X, AnimalPart.Position.Y, targetPosition.Z)
			local Direction   = HorizTarget - AnimalPart.Position
			local Distance    = Direction.Magnitude
			if Distance > 0.1 then
				local MoveStep    = math.min(CurrentSpeed * dt, Distance)
				local NewHorizPos = AnimalPart.Position + Direction.Unit * MoveStep
				local targetGroundPos
				if ForceStraightLine then
					local isDulDulActive = (not isEventRoad) and EventService:GetActiveEvent("Dul Dul Dul")
					if isDulDulActive then
						targetGroundPos = snapToGround(NewHorizPos, AnimalModel, isEventRoad)
					else
						local traveledDist = (Vector3.new(NewHorizPos.X, 0, NewHorizPos.Z)
							- Vector3.new(startPosForStraight.X, 0, startPosForStraight.Z)).Magnitude
						local progress = totalHorizontalDist > 0
							and math.clamp(traveledDist / totalHorizontalDist, 0, 1) or 0
						local interpY = startY + (endY - startY) * progress
						targetGroundPos = Vector3.new(NewHorizPos.X, interpY, NewHorizPos.Z)
					end
				else
					targetGroundPos = snapToGround(NewHorizPos, AnimalModel, isEventRoad)
				end
				local currentY = AnimalPart.Position.Y
				local targetY  = targetGroundPos.Y
				local newY
				if targetY >= currentY then
					newY = math.min(targetY, currentY + GROUND_RISE_SPEED * dt)
				else
					newY = math.max(targetY, currentY - GROUND_SINK_SPEED * dt)
				end
				isFirstMovementFrame = false
				local newPos = Vector3.new(targetGroundPos.X, newY, targetGroundPos.Z)
				local targetLookCF = CFrame.lookAt(newPos, newPos + Direction.Unit)
				local currentPivot = AnimalModel:GetPivot()
				local smoothedRot = currentPivot.Rotation:Lerp(targetLookCF.Rotation, currentAnimalSmoothness)
				AnimalModel:PivotTo(CFrame.new(newPos) * smoothedRot)
			end
		end)
	end
	local function updateForceIdle()
		if IsDestroying then return end
		local ForceIdle = AnimalModel:GetAttribute("ForceIdle")
		if ForceIdle == true then
			if MovementConnection then MovementConnection:Disconnect(); MovementConnection = nil end
			IsMoving = false
			return
		end
		if isEventRoad then
			if not IsMoving then
				MoveAlongPath(IsBought and MoveTarget or roadEnd)
			end
			return
		end
		local DivineStairsIsActive = ReplicatedStorage:GetAttribute("DivineStairsEnabled")
		if not IsBought and not CustomSpawn and FinalMutation == "Divine" and DivineStairsIsActive then
			task.spawn(function()
				if IsDestroying then return end
				local DivineFolder = workspace.Events:FindFirstChild("Divine")
				local DivineStart  = DivineFolder and DivineFolder:FindFirstChild("Start")
				local needsStairsTraversal = false
				if DivineStart then
					local distToRoadStart   = (AnimalPart.Position - workspace.Road.Start.Position).Magnitude
					local distToDivineStart = (AnimalPart.Position - DivineStart.Position).Magnitude
					needsStairsTraversal    = distToDivineStart < distToRoadStart
				end
				if needsStairsTraversal and not IsDestroying then
					MoveAlongPath(workspace.Road.Start)
					local elapsed, timeout = 0, 60
					while not IsDestroying and AnimalPart and AnimalPart.Parent do
						if (AnimalPart.Position - workspace.Road.Start.Position).Magnitude <= 8 then break end
						elapsed += task.wait(0.1)
						if elapsed >= timeout then break end
					end
				end
				if not IsDestroying and AnimalPart and AnimalPart.Parent then
					MoveAlongPath(workspace.Road.End)
				end
			end)
		else
			local TargetToMoveTo
			if not IsBought then
				TargetToMoveTo = AprilFoolsMode and workspace.Road.Start or workspace.Road.End
			elseif MoveTarget then
				TargetToMoveTo = MoveTarget
			end
			if TargetToMoveTo and not IsMoving then
				MoveAlongPath(TargetToMoveTo)
			end
		end
	end
	ForceIdleConnection = AnimalModel.AttributeChanged:Connect(function(AttributeName)
		if AttributeName == "ForceIdle" then updateForceIdle() end
	end)
	local function purchaseAnimal(PlayerWhoTriggered, IsFree)
		if IsDestroying then return end
		local LockKey     = AnimalName .. "_" .. PlayerWhoTriggered.UserId
		local CurrentTime = os.clock()
		if PurchaseLocks[LockKey] then return end
		if isfake then
			if AnimalModel:GetAttribute("IsMorphAnimal") then
				if LastPurchaseAttempt[LockKey] and (CurrentTime - LastPurchaseAttempt[LockKey]) < 0.1 then return end
				LastPurchaseAttempt[LockKey] = CurrentTime
				PurchaseLocks[LockKey] = true
				IsBought = true
				PurchasingPlayer = PlayerWhoTriggered
				local Plot = PlotService.getPlot(PlayerWhoTriggered)
				if isEventRoad then
					MoveTarget = (Plot and Plot.AnimalTarget) or roadEnd
				else
					MoveTarget = (Plot and Plot.AnimalTarget) or (AprilFoolsMode and workspace.Road.Start or workspace.Road.End)
				end
				pendingTargetUserId = PlayerWhoTriggered.UserId
				if Prompt and Prompt.Parent then
					Prompt:SetAttribute("TargetPlayer", pendingTargetUserId)
					Prompt.Enabled = false
				end
				MoveAlongPath(MoveTarget)
				local Sound = ANIMAL_SOUNDS:FindFirstChild(indexName)
				if Sound then
					task.delay(0, function()
						if IsDestroying then return end
						for _, Player in game.Players:GetPlayers() do
							SoundService:Play(Player, Sound)
						end
					end)
				end
				task.delay(1, function() PurchaseLocks[LockKey] = nil end)
				return
			else
				local v12 = Net:RemoteEvent("SpawnFakeBrainrot/Poof")
				pcall(function() v12:FireAllClients({Position = AnimalPart.Position}) end)
				task.delay(3, function()
					if EventService:GetActiveEvent(AnimalData.TriggerEvent) then
						EventService:CancelEvent(AnimalData.TriggerEvent)
					end
				end)
				IsDestroying = true
				if AnimalModel then AnimalModel:Destroy() end
				return
			end
		end
		if CollectionService:HasTag(AnimalPart, "IndonesiaCanoe") then
			CollectionService:RemoveTag(AnimalPart, "IndonesiaCanoe")
			currentAnimalSmoothness = originalSmoothness
			AnimalPart:SetAttribute("ForceIdle", nil)
		end
		local targetForTag = (AnimalModel:IsA("Model") and AnimalModel.PrimaryPart) or AnimalModel
		if targetForTag and CollectionService:HasTag(targetForTag, "IndonesiaCanoe") then
			CollectionService:RemoveTag(targetForTag, "IndonesiaCanoe")
		end
		if LastPurchaseAttempt[LockKey] and (CurrentTime - LastPurchaseAttempt[LockKey]) < 0.1 then return end
		LastPurchaseAttempt[LockKey] = CurrentTime
		PurchaseLocks[LockKey] = true
		if IsBought and PurchasingPlayer and PurchasingPlayer ~= PlayerWhoTriggered then
			PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
			ReservedPodiumIndex = nil
			IsBought = false
			PurchasingPlayer = nil
		elseif IsBought and PurchasingPlayer == PlayerWhoTriggered then
			PurchaseLocks[LockKey] = nil
			return
		end
		local PlayerChannel = Synchronizer:Get(PlayerWhoTriggered)
		if not PlayerChannel then PurchaseLocks[LockKey] = nil; return end
		local BasePrice = AnimalData.Price
		local Price     = BasePrice
		local CanAfford, Amount = MoneyService:CanAfford(PlayerWhoTriggered, Price)
		if not CanAfford and not IsFree then
			NotificationService.Error(PlayerWhoTriggered,
				string.format("You need $%s more to buy this", NumberUtils.ToString(nil, Amount)))
			PurchaseLocks[LockKey] = nil; return
		end
		local Podiums = PlotService.getFreePodium(PlayerWhoTriggered)
		if not Podiums then
			NotificationService.Error(PlayerWhoTriggered, "You need more room in your base to buy a brainrot.")
			PurchaseLocks[LockKey] = nil; return
		end
		ReservedPodiumIndex = tonumber(Podiums.Name)
		if not ReservedPodiumIndex then
			NotificationService.Error(PlayerWhoTriggered, "Invalid podium index.")
			PurchaseLocks[LockKey] = nil; return
		end
		if AnimalModel and AnimalModel.Parent ~= workspace then
			AnimalModel.Parent = workspace
		end
		PlotService.AddToQueue(PlayerWhoTriggered, ReservedPodiumIndex)
		pendingTargetUserId = PlayerWhoTriggered.UserId
		if Prompt and Prompt.Parent then
			Prompt:SetAttribute("TargetPlayer", pendingTargetUserId)
			if isEventRoad then Prompt.Enabled = false end
		end
		IsBought         = true
		PurchasingPlayer = PlayerWhoTriggered
		local Plot = PlotService.getPlot(PlayerWhoTriggered)
		if not Plot then
			PlotService.RemoveFromQueue(PlayerWhoTriggered, ReservedPodiumIndex)
			MoveTarget = AprilFoolsMode and workspace.Road.Start or roadEnd
		else
			MoveTarget = Plot.AnimalTarget
		end
		if not IsFree then
			MoneyService:Add(PlayerWhoTriggered, -Price)
			Price = Price + BasePrice * 1.5
		end
		if claimCollectibleElf(PlayerWhoTriggered) then
			task.delay(1, function() PurchaseLocks[LockKey] = nil end)
			return
		end
		local DivineStairsActiveNow = ReplicatedStorage:GetAttribute("DivineStairsEnabled")
		if (not isEventRoad) and (not CustomSpawn) and FinalMutation == "Divine" and DivineStairsActiveNow then
			task.spawn(function()
				local distanceToStart = (AnimalPart.Position - workspace.Road.Start.Position).Magnitude
				local alreadyAtStart  = distanceToStart <= 8
				if not alreadyAtStart then
					if MovementConnection then MovementConnection:Disconnect(); MovementConnection = nil end
					IsMoving = false
					local divineFolder = workspace.Events:FindFirstChild("Divine")
					local divineStart  = divineFolder and divineFolder:FindFirstChild("Start")
					if divineStart then
						local distToRoadStart   = (AnimalPart.Position - workspace.Road.Start.Position).Magnitude
						local distToDivineStart = (AnimalPart.Position - divineStart.Position).Magnitude
						if distToDivineStart < distToRoadStart then
							MoveAlongPath(workspace.Road.Start)
							local elapsed, timeout = 0, 60
							while not IsDestroying and AnimalPart and AnimalPart.Parent do
								if (AnimalPart.Position - workspace.Road.Start.Position).Magnitude <= 8 then break end
								elapsed += task.wait(0.1)
								if elapsed >= timeout then break end
							end
						end
					else
						MoveAlongPath(workspace.Road.Start)
						local elapsed, timeout = 0, 60
						while not IsDestroying and AnimalPart and AnimalPart.Parent do
							if (AnimalPart.Position - workspace.Road.Start.Position).Magnitude <= 8 then break end
							elapsed += task.wait(0.1)
							if elapsed >= timeout then break end
						end
					end
				end
				if IsDestroying then return end
				if not AnimalModel:GetAttribute("DivineSoundPlayed") then
					AnimalModel:SetAttribute("DivineSoundPlayed", true)
					if SoundSpecialRarities[AnimalData.Rarity] then
						local Sound = ANIMAL_SOUNDS:FindFirstChild(indexName)
						if Sound then
							for _, Player in game.Players:GetPlayers() do
								SoundService:Play(Player, Sound)
							end
						end
					end
				end
				if IsDestroying then return end
				AnimalPart:SetAttribute("InDivineRoad", nil)
				AnimalModel:SetAttribute("InDivineRoad", nil)
				MoveAlongPath(MoveTarget)
			end)
		else
			MoveAlongPath(MoveTarget)
		end
		if not (isFuseSpawn and IsFree) then
			local Sound = ANIMAL_SOUNDS:FindFirstChild(indexName)
			if Sound then
				task.delay(0, function()
					if IsDestroying then return end
					for _, Player in game.Players:GetPlayers() do
						SoundService:Play(Player, Sound)
					end
				end)
			end
		end
		task.delay(1, function() PurchaseLocks[LockKey] = nil end)
	end
	ActiveAnimals[AnimalName].PurchaseFunction = purchaseAnimal
	do
		local _isRedirecting = false
		local function redirectForAprilFools()
			if IsBought or IsDestroying then return end
			if (not isEventRoad) and CustomSpawn then return end
			if _isRedirecting then return end
			_isRedirecting = true
			local newTarget
			if isEventRoad then
				local rS, rE = getRoadParts(RoadIndex)
				if not rS or not rE then _isRedirecting = false; return end
				newTarget = AprilFoolsMode and rS or rE
			else
				newTarget = AprilFoolsMode and workspace.Road.Start or workspace.Road.End
			end
			MoveAlongPath(newTarget)
			task.delay(0.3, function() _isRedirecting = false end)
		end
		ActiveAnimals[AnimalName].RedirectFunction = redirectForAprilFools
	end
	do
		local function forceFinishOnEventEnd()
			if IsDestroying then return end
			if not AnimalModel or not AnimalModel.Parent then return end
			local onEventPath = AnimalModel:HasTag("1x1x1x1animal")
				or AnimalModel:HasTag("BackroomsAnimal")
				or AnimalModel:GetAttribute("OnBackroomsPath")
			if onEventPath then
				AnimalModel:SetAttribute("ForceEventExit", true)
			else
				AnimalModel:SetAttribute("ForceIdle", false)
				local dest = (IsBought and MoveTarget) or workspace.Road.End
				if dest and not IsDestroying then
					MoveAlongPath(dest)
				end
			end
		end
		ActiveAnimals[AnimalName].ForceFinishFunction = forceFinishOnEventEnd
	end
	if (not isEventRoad) and CustomSpawn and CustomSpawn.End then
		MoveTarget = CustomSpawn.End
	end
	if isCupidSpawn then AnimalModel:SetAttribute("ForceIdle", true) end
	if (not isEventRoad) and CustomSpawn and CustomSpawn.Owner then
		purchaseAnimal(CustomSpawn.Owner, true)
	end
	local PlayerRemovingConn = Players.PlayerRemoving:Connect(function(Player)
		if Player ~= PurchasingPlayer then return end
		if IsDestroying then return end
		local entry = ActiveAnimals[AnimalName]
		local deposited = false
		if entry and entry.ForceDepositForPlayerIfBought then
			local ok, did = pcall(entry.ForceDepositForPlayerIfBought, Player)
			deposited = ok and did == true
		end
		if not deposited and not IsDestroying then
			PlotService.RemoveFromQueue(Player, ReservedPodiumIndex)
			MoveTarget          = isEventRoad and roadEnd
				or (AprilFoolsMode and workspace.Road.Start or workspace.Road.End)
			IsBought            = false
			ReservedPodiumIndex = nil
			MoveAlongPath(MoveTarget)
		end
	end)
	AnimalModel.Destroying:Connect(function()
		IsDestroying = true
		if ForceIdleConnection  then ForceIdleConnection:Disconnect();  ForceIdleConnection  = nil end
		if MovementConnection   then MovementConnection:Disconnect();   MovementConnection   = nil end
		if animConn             then animConn:Disconnect();             animConn             = nil end
		if PlayerRemovingConn   then PlayerRemovingConn:Disconnect();   PlayerRemovingConn   = nil end
		if morphEarlyDestroyConn then morphEarlyDestroyConn:Disconnect(); morphEarlyDestroyConn = nil end
		ActiveAnimals[AnimalName] = nil
		if PurchasingPlayer and ReservedPodiumIndex then
			PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
		end
		for Key in pairs(PurchaseLocks) do
			if string.find(Key, AnimalName) then PurchaseLocks[Key] = nil end
		end
		for Key in pairs(LastPurchaseAttempt) do
			if string.find(Key, AnimalName) then LastPurchaseAttempt[Key] = nil end
		end
	end)
	local spawnAbovePos = Vector3.new(StartPos.X, StartPos.Y + SPAWN_HOVER_HEIGHT, StartPos.Z)
	AnimalPart.CFrame = CFrame.new(spawnAbovePos) * initialFacingCF.Rotation
	if (not isEventRoad)
		and not CustomSpawn and not isFuseSpawn and not isCupidSpawn
		and not AprilFoolsMode and not Is1x1x1x1Active() then
		local StartGround = workspace.Road:FindFirstChild("StartGround")
		if StartGround then
			local currentPos  = AnimalModel:GetPivot().Position
			local lookTarget  = Vector3.new(StartGround.Position.X, currentPos.Y, StartGround.Position.Z)
			local direction   = lookTarget - currentPos
			if direction.Magnitude > 0.1 then
				AnimalModel:PivotTo(CFrame.lookAt(currentPos, currentPos + direction.Unit))
			end
		end
	end
	if AFKTime and AFKTime > 0 then
		AnimalModel:SetAttribute("ForceIdle", true)
		task.delay(AFKTime, function()
			if AnimalModel and AnimalModel.Parent and not IsDestroying then
				AnimalModel:SetAttribute("ForceIdle", false)
			end
		end)
	end
	if isEventRoad then
		task.wait(0.05)
		spawnPrompt()
		MoveAlongPath(MoveTarget)
	elseif isFuseSpawn then
		local delay = workspace:FindFirstChild("FuseMachine"):GetAttribute("FuseType") == "Witch" and 6 or 3
		if SoundSpecialRarities[AnimalData.Rarity]
			and not (FinalMutation == "Divine" and ReplicatedStorage:GetAttribute("DivineStairsEnabled")) then
			local Sound = ANIMAL_SOUNDS:FindFirstChild(indexName)
			if Sound then
				task.delay(delay, function()
					if IsDestroying then return end
					if not AnimalModel or not AnimalModel.Parent then return end
					for _, Player in game.Players:GetPlayers() do
						SoundService:Play(Player, Sound)
					end
				end)
			end
		end
		local FuseMachine    = workspace:FindFirstChild("FuseMachine"):GetAttribute("FuseType") == "Witch" and workspace:FindFirstChild("Witch Fuse") or workspace:FindFirstChild("FuseMachine")
		local VisualSpawn    = FuseMachine:FindFirstChild("VisualSpawnCFrame")
		local VisualLevitate = FuseMachine:FindFirstChild("VisualLevitateCFrame")
		local SpawnZone      = FuseMachine:FindFirstChild("SpawnZone")
		if not SpawnZone then
			warn("[AnimalService] Missing required object: SpawnZone")
			AnimalModel:Destroy(); return
		end
		if VisualSpawn and VisualLevitate then
			task.delay(delay, function()
				if not IsDestroying then
					AnimalModel:SetAttribute("ForceIdle", nil)
					spawnPrompt()
					MoveAlongPath(MoveTarget)
				end
			end)
		else
			spawnPrompt()
		end
	elseif isCupidSpawn then
		AnimalModel:SetAttribute("IsCupidSpawn", true)
		spawnPrompt()
		task.wait(1)
		if not IsDestroying then
			AnimalModel:SetAttribute("ForceIdle", false)
			MoveAlongPath(MoveTarget)
		end
	elseif (not CustomSpawn) and Is1x1x1x1Active() then
		AnimalModel:SetAttribute("ForceIdle", true)
		local isOn1x1x1Path = true
		if not SkipSpawnDelay and AnimalData.SpawnDelay and AnimalData.SpawnDelay > 0 then
			AnimalModel:PivotTo(CFrame.new(-1000, -1000, -1000))
			ScheduleNextSpawnDelay(AnimalData.SpawnDelay, ("1x1x1x1_SpawnVFX:%s"):format(indexName))
			task.wait(AnimalData.SpawnDelay)
			if IsDestroying or not AnimalModel or not AnimalModel.Parent then
				EventPathOccupied = false
				isOn1x1x1Path = false
				return
			end
		end
		if not CatchUpProgress then
			local taggedMaps = CollectionService:GetTagged("1x1x1x1Map")
			local SideMap = taggedMaps[1]
			if SideMap then
				local door = SideMap.Lab.Printer:WaitForChild("Latch")
				if door then
					door:SetAttribute("Open", true)
					task.delay(2, function()
						if door and door.Parent then door:SetAttribute("Open", false) end
					end)
				end
			end
		end
		task.spawn(function()
			EventPathOccupied = true
			local RoadEndPart      = workspace.Road:WaitForChild("End")
			local RoadStartGround  = workspace.Road:WaitForChild("StartGround")
			local Waypoints        = script.Path:GetChildren()
			table.sort(Waypoints, function(a, b) return tonumber(a.Name) < tonumber(b.Name) end)
			if #Waypoints == 0 or not AnimalModel or not AnimalModel.Parent then
				EventPathOccupied = false; isOn1x1x1Path = false; return
			end
			local speed = 10
			local function getGroundPosition(pos)
				local rayOrigin = Vector3.new(pos.X, pos.Y + 2, pos.Z)
				local excludeList = {AnimalModel}
				for _, player in ipairs(Players:GetPlayers()) do
					if player.Character then table.insert(excludeList, player.Character) end
				end
				local road = workspace:FindFirstChild("Road")
				if road then table.insert(excludeList, road) end
				local params = RaycastParams.new()
				params.FilterType = Enum.RaycastFilterType.Exclude
				params.FilterDescendantsInstances = excludeList
				local rayResult = workspace:Raycast(rayOrigin, Vector3.new(0, -30, 0), params)
				if rayResult then return rayResult.Position end
				return pos
			end
			local startIndex = 1
			local initialPos = Waypoints[1].Position
			if CatchUpProgress and CatchUpProgress > 0 then
				local totalLen = 0
				local segLen   = {}
				for j = 2, #Waypoints do
					local d = (Waypoints[j].Position - Waypoints[j - 1].Position).Magnitude
					segLen[j] = d
					totalLen += d
				end
				local targetDist = math.clamp(CatchUpProgress, 0, 1) * totalLen
				local acc = 0
				startIndex = #Waypoints
				initialPos = Waypoints[#Waypoints].Position
				for j = 2, #Waypoints do
					local d = segLen[j] or 0
					if acc + d >= targetDist then
						local alpha = d > 0 and ((targetDist - acc) / d) or 0
						initialPos = Waypoints[j - 1].Position:Lerp(Waypoints[j].Position, alpha)
						startIndex = j
						break
					end
					acc += d
				end
			end
			local lookAtFlat = Vector3.new(RoadEndPart.Position.X, initialPos.Y, RoadEndPart.Position.Z)
			AnimalModel:PivotTo(CFrame.lookAt(initialPos, lookAtFlat))
			if not CatchUpProgress then
				do
					local totalWaypointDist = 0
					local prevWpPos = Waypoints[1].Position
					for j = 2, #Waypoints do
						local wpPos = Waypoints[j].Position
						if j < 9 then
							totalWaypointDist += (wpPos - prevWpPos).Magnitude
						else
							totalWaypointDist += (Vector3.new(wpPos.X, prevWpPos.Y, wpPos.Z) - prevWpPos).Magnitude
						end
						prevWpPos = wpPos
					end
					local finalSegSpeed = math.max(GlobalSpeedOverride or OriginalSpeed, 1)
					local finalSegDist  = (Vector3.new(RoadStartGround.Position.X, prevWpPos.Y, RoadStartGround.Position.Z) - prevWpPos).Magnitude
					local totalPathTime = (totalWaypointDist / speed) + (finalSegDist / finalSegSpeed)
					local isCyberMutation = (FinalMutation == "Cyber" and ReplicatedStorage:GetAttribute("CyberEvent") == true)
					local isPhantomMutation = (FinalMutation == "Phantom" and ReplicatedStorage:GetAttribute("PhantomEvent") == true)
					if AnimalData.SpawnVFX and AnimalData.SpawnDelay and AnimalData.SpawnDelay > 0 then
						local spawnDelay = AnimalData.SpawnDelay
						local vfxFireDelay = math.max(0, (totalPathTime - spawnDelay))
						task.delay(vfxFireDelay, function()
							if IsDestroying then return end
							if indexName == "Matteo" then
								local MatteoSound = ReplicatedStorage.Sounds.Others:FindFirstChild("MatteoAppearanceVoice")
								if MatteoSound then
									for _, Player in game.Players:GetPlayers() do
										SoundService:Play(Player, MatteoSound)
									end
								end
							end
							Net:RemoteEvent("GameService/SpawnEffect"):FireAllClients(AnimalData.SpawnVFX, spawnDelay)
							if isCyberMutation then
								local beaconDelay = spawnDelay - 2
								if beaconDelay > 0 then
									task.delay(beaconDelay, function()
										if IsDestroying then return end
										Net:RemoteEvent("GameService/CyberBeaconAnimation"):FireAllClients()
									end)
								else
									Net:RemoteEvent("GameService/CyberBeaconAnimation"):FireAllClients()
								end
							elseif isPhantomMutation then
								local beaconDelay = spawnDelay - 2
								if beaconDelay > 0 then
									task.delay(beaconDelay, function()
										if IsDestroying then return end
										Net:RemoteEvent("GameService/PhantomCaveFlash"):FireAllClients()
									end)
								else
									Net:RemoteEvent("GameService/PhantomCaveFlash"):FireAllClients()
								end
							end
						end)
					elseif isCyberMutation then
						local beaconDelay = math.max(0, totalPathTime - 2)
						task.delay(beaconDelay, function()
							if IsDestroying then return end
							Net:RemoteEvent("GameService/CyberBeaconAnimation"):FireAllClients()
						end)
					elseif isPhantomMutation then
						local beaconDelay = math.max(0, totalPathTime - 2)
						task.delay(beaconDelay, function()
							if IsDestroying then return end
							Net:RemoteEvent("GameService/PhantomCaveFlash"):FireAllClients()
						end)
					end
				end
			end
			local hasTriggeredWaypoint10Effects = false
			local hasTriggeredWaypoint11Effects = false
			for i = startIndex, #Waypoints do
				if not AnimalModel or not AnimalModel.Parent then break end
				if AnimalModel:GetAttribute("ForceEventExit") then
					isOn1x1x1Path = false
					AnimalModel:SetAttribute("ForceIdle", false)
					local snapPos = snapToGround(RoadEndPart.Position, AnimalModel, isEventRoad)
					AnimalModel:PivotTo(CFrame.new(snapPos))
					MoveAlongPath(RoadEndPart)
					EventPathOccupied = false
					task.spawn(function()
						if not AnimalModel or not AnimalModel.Parent then return end
						if AnimalModel:HasTag("1x1x1x1animal") then
							AnimalModel:SetAttribute("1x1x1x1ToAnimalSwap", true)
							AnimalModel:RemoveTag("1x1x1x1animal")
							AnimalModel:AddTag("Animal")
						end
						spawnPrompt()
					end)
					break
				end
				while _G.GlobalVFXPause and i < 11 do task.wait(0.1) end
				local waypointPos = Waypoints[i].Position
				local currentPos  = AnimalModel:GetPivot().Position
				local targetPos
				if i >= 9 then
					targetPos = getGroundPosition(Vector3.new(waypointPos.X, currentPos.Y, waypointPos.Z))
					local arrived = false
					local conn
					conn = RunService.Heartbeat:Connect(function(dt)
						if IsDestroying or not AnimalModel or not AnimalModel.Parent
							or AnimalModel:GetAttribute("ForceEventExit") then
							conn:Disconnect(); arrived = true; return
						end
						local currentAnimalPos = AnimalPart.Position
						local horizTarget = Vector3.new(targetPos.X, currentAnimalPos.Y, targetPos.Z)
						local direction   = horizTarget - currentAnimalPos
						local distance    = direction.Magnitude
						if distance < 0.5 then conn:Disconnect(); arrived = true; return end
						local moveStep      = math.min(speed * dt, distance)
						local nextHorizPos  = currentAnimalPos + direction.Unit * moveStep
						local groundResult  = getGroundPosition(nextHorizPos)
						local currentY, groundY = currentAnimalPos.Y, groundResult.Y
						local newY
						if groundY < currentY then
							newY = math.max(groundY, currentY - 60 * dt)
						else
							newY = math.min(groundY, currentY + 10 * dt)
						end
						local newPos      = Vector3.new(groundResult.X, newY, groundResult.Z)
						local lookAtTarget = Vector3.new(RoadEndPart.Position.X, newPos.Y, RoadEndPart.Position.Z)
						AnimalModel:PivotTo(CFrame.lookAt(newPos, lookAtTarget))
					end)
					while not arrived do task.wait() end
				else
					targetPos = waypointPos
					local startWpPos = AnimalModel:GetPivot().Position
					local distance   = (targetPos - startWpPos).Magnitude
					local duration   = distance / speed
					if duration > 0.01 then
						local targetLookAt = Vector3.new(RoadEndPart.Position.X, targetPos.Y, RoadEndPart.Position.Z)
						local targetCFrame = CFrame.lookAt(targetPos, targetLookAt)
						local tween = TweenService:Create(
							AnimalModel.PrimaryPart,
							TweenInfo.new(duration, Enum.EasingStyle.Linear),
							{CFrame = targetCFrame}
						)
						tween:Play(); tween.Completed:Wait()
					end
				end
				if i == 10 and not hasTriggeredWaypoint10Effects then
					hasTriggeredWaypoint10Effects = true
					task.spawn(function()
						if AnimalModel and AnimalModel.Parent then
							AnimalModel:SetAttribute("ForceIdle", false)
						end
					end)
				end
				if i == 11 and not hasTriggeredWaypoint11Effects then
					hasTriggeredWaypoint11Effects = true
					isOn1x1x1Path = false
					AnimalModel:SetAttribute("ForceIdle", false)
					MoveAlongPath(RoadEndPart)
					EventPathOccupied = false
					task.spawn(function()
						if not AnimalModel or not AnimalModel.Parent then return end
						if AnimalModel:HasTag("1x1x1x1animal") then
							AnimalModel:SetAttribute("1x1x1x1ToAnimalSwap", true)
							AnimalModel:RemoveTag("1x1x1x1animal")
							AnimalModel:AddTag("Animal")
						end
						spawnPrompt()
						if SoundSpecialRarities[AnimalData.Rarity] then
							local Sound = ANIMAL_SOUNDS:FindFirstChild(indexName)
							if Sound then
								for _, p in game.Players:GetPlayers() do SoundService:Play(p, Sound) end
							end
						end
						local rarity, name = AnimalData.Rarity, AnimalData.DisplayName
						if rarity == "Secret" and name ~= "Lucky Block" then
							ChatService:SendMessage("<font color='#000000'>[SERVER] A secret Brainrot has spawned!</font>")
						elseif name == "Lucky Block" then
							local msgs = {
								Admin           = "<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Admin Lucky Block</font><font color='#d1d202'> has spawned!</font>",
								Spooky          = "<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Spooky Lucky Block</font><font color='#d1d202'> has spawned!</font>",
								Taco            = "<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Taco Lucky Block</font><font color='#d1d202'> has spawned!</font>",
								["Brainrot God"]= "<font color='#22afe2'>[SERVER] A Brainrot God Lucky Block has spawned!</font>",
								Secret          = "<font color='#000000'>[SERVER] A Secret Lucky Block has spawned!</font>",
							}
							if msgs[rarity] then ChatService:SendMessage(msgs[rarity]) end
						end
						if AnimalData.DisplayName == "Los Ogs" then
							EventService:ExecuteEvent("Strawberry", 300)
							EventService:ExecuteEvent("Meowl", 300)
							EventService:ExecuteEvent("Skibidi", 300)
						elseif TriggerEvent and AnimalData.TriggerEvent then
							EventService:ExecuteEvent(AnimalData.TriggerEvent)
						end
					end)
					break
				end
			end
			if not AnimalModel or not AnimalModel.Parent then
				EventPathOccupied = false; isOn1x1x1Path = false; return
			end
		end)
		if ForceIdleConnection then ForceIdleConnection:Disconnect() end
		ForceIdleConnection = AnimalModel.AttributeChanged:Connect(function(AttributeName)
			if AttributeName == "ForceIdle" then
				if isOn1x1x1Path then return end
				updateForceIdle()
			end
		end)
	elseif (not CustomSpawn) and EventService:GetActiveEvent("Backrooms") then
		local isOnBackroomsPath = true
		AnimalModel:SetAttribute("OnBackroomsPath", true)
		do
			local _wpFolder = script:FindFirstChild("BrainrotWaypoints")
			local _firstWp  = _wpFolder and _wpFolder:FindFirstChild("1")
			if _firstWp then
				local wpPos     = _firstWp.Position
				local hoverPos  = Vector3.new(wpPos.X, wpPos.Y + SPAWN_HOVER_HEIGHT, wpPos.Z)
				local _secondWp = _wpFolder:FindFirstChild("2")
				local lookTarget
				if _secondWp then
					lookTarget = Vector3.new(_secondWp.Position.X, hoverPos.Y, _secondWp.Position.Z)
				else
					lookTarget = Vector3.new(roadEnd.Position.X, hoverPos.Y, roadEnd.Position.Z)
				end
				if (lookTarget - hoverPos).Magnitude > 0.01 then
					AnimalModel:PivotTo(CFrame.lookAt(hoverPos, lookTarget))
				else
					AnimalModel:PivotTo(CFrame.new(hoverPos))
				end
			end
		end
		if not SkipSpawnDelay and AnimalData.SpawnDelay and AnimalData.SpawnDelay > 0 then
			local hoverCFrame = AnimalModel:GetPivot()
			AnimalModel:SetAttribute("ForceIdle", true)
			AnimalModel:PivotTo(CFrame.new(-1000, -1000, -1000))
			ScheduleNextSpawnDelay(AnimalData.SpawnDelay, ("Backrooms_SpawnVFX:%s"):format(indexName))
			task.wait(AnimalData.SpawnDelay)
			if IsDestroying or not AnimalModel or not AnimalModel.Parent then
				isOnBackroomsPath = false
				if AnimalModel and AnimalModel.Parent then
					AnimalModel:SetAttribute("OnBackroomsPath", nil)
				end
				return
			end
			AnimalModel:PivotTo(hoverCFrame)
			AnimalModel:SetAttribute("ForceIdle", false)
		end
		task.spawn(function()
			EventPathOccupied = true
			local RoadEndPart       = workspace.Road:WaitForChild("End")
			local WaypointsFolder   = script:WaitForChild("BrainrotWaypoints", 5)
			if not WaypointsFolder then
				EventPathOccupied = false; isOnBackroomsPath = false
				if AnimalModel and AnimalModel.Parent then
					AnimalModel:SetAttribute("OnBackroomsPath", nil)
				end
				if AnimalModel and AnimalModel.Parent and not IsDestroying then
					spawnPrompt()
					MoveAlongPath(MoveTarget)
				end
				return
			end
			local Waypoints = WaypointsFolder:GetChildren()
			table.sort(Waypoints, function(a, b) return tonumber(a.Name) < tonumber(b.Name) end)
			if #Waypoints == 0 or not AnimalModel or not AnimalModel.Parent then
				EventPathOccupied = false; isOnBackroomsPath = false
				if AnimalModel and AnimalModel.Parent then
					AnimalModel:SetAttribute("OnBackroomsPath", nil)
				end
				if AnimalModel and AnimalModel.Parent and not IsDestroying then
					spawnPrompt()
					MoveAlongPath(MoveTarget)
				end
				return
			end
			local speed = math.max(GlobalSpeedOverride or OriginalSpeed, 1)
			local startIndex = 1
			if CatchUpProgress and CatchUpProgress > 0 then
				local totalLen = 0
				local segLen   = {}
				for j = 2, #Waypoints do
					local d = (Waypoints[j].Position - Waypoints[j - 1].Position).Magnitude
					segLen[j] = d
					totalLen += d
				end
				if totalLen > 0 then
					local targetDist = math.clamp(CatchUpProgress, 0, 1) * totalLen
					local acc        = 0
					local entryPos   = Waypoints[#Waypoints].Position
					startIndex = #Waypoints
					for j = 2, #Waypoints do
						local d = segLen[j] or 0
						if acc + d >= targetDist then
							local alpha = d > 0 and ((targetDist - acc) / d) or 0
							entryPos   = Waypoints[j - 1].Position:Lerp(Waypoints[j].Position, alpha)
							startIndex = j
							break
						end
						acc += d
					end
					local groundPos  = snapToGround(entryPos, AnimalModel, false)
					local lookTarget = Waypoints[startIndex].Position
					local lookFlat   = Vector3.new(lookTarget.X, groundPos.Y, lookTarget.Z)
					if (lookFlat - groundPos).Magnitude > 0.01 then
						AnimalModel:PivotTo(CFrame.lookAt(groundPos, lookFlat))
					else
						AnimalModel:PivotTo(CFrame.new(groundPos))
					end
				end
			end
			if not CatchUpProgress then
				local totalDist = 0
				local prevPos   = AnimalModel:GetPivot().Position
				for j = 1, #Waypoints do
					local wpPos = Waypoints[j].Position
					totalDist += (Vector3.new(wpPos.X, prevPos.Y, wpPos.Z) - prevPos).Magnitude
					prevPos = wpPos
				end
				local totalPathTime   = totalDist / speed
				local isCyberMutation = (FinalMutation == "Cyber" and ReplicatedStorage:GetAttribute("CyberEvent") == true)
				local isPhantomMutation = (FinalMutation == "Phantom" and ReplicatedStorage:GetAttribute("PhantomEvent") == true)
				if AnimalData.SpawnVFX and AnimalData.SpawnDelay and AnimalData.SpawnDelay > 0 then
					local spawnDelay   = AnimalData.SpawnDelay
					local vfxFireDelay = math.max(0, (totalPathTime - spawnDelay))
					task.delay(vfxFireDelay, function()
						if IsDestroying then return end
						if indexName == "Matteo" then
							local MatteoSound = ReplicatedStorage.Sounds.Others:FindFirstChild("MatteoAppearanceVoice")
							if MatteoSound then
								for _, Player in game.Players:GetPlayers() do
									SoundService:Play(Player, MatteoSound)
								end
							end
						end
						Net:RemoteEvent("GameService/SpawnEffect"):FireAllClients(AnimalData.SpawnVFX, spawnDelay)
						if isCyberMutation then
							local beaconDelay = spawnDelay - 2
							if beaconDelay > 0 then
								task.delay(beaconDelay, function()
									if IsDestroying then return end
									Net:RemoteEvent("GameService/CyberBeaconAnimation"):FireAllClients()
								end)
							else
								Net:RemoteEvent("GameService/CyberBeaconAnimation"):FireAllClients()
							end
						elseif isPhantomMutation then
							local beaconDelay = spawnDelay - 2
							if beaconDelay > 0 then
								task.delay(beaconDelay, function()
									if IsDestroying then return end
									Net:RemoteEvent("GameService/PhantomCaveFlash"):FireAllClients()
								end)
							else
								Net:RemoteEvent("GameService/PhantomCaveFlash"):FireAllClients()
							end
						end
					end)
				elseif isCyberMutation then
					local beaconDelay = math.max(0, totalPathTime - 2)
					task.delay(beaconDelay, function()
						if IsDestroying then return end
						Net:RemoteEvent("GameService/CyberBeaconAnimation"):FireAllClients()
					end)
				elseif isPhantomMutation then
					local beaconDelay = math.max(0, totalPathTime - 2)
					task.delay(beaconDelay, function()
						if IsDestroying then return end
						Net:RemoteEvent("GameService/PhantomCaveFlash"):FireAllClients()
					end)
				end
			end
			for i = startIndex, #Waypoints do
				if not AnimalModel or not AnimalModel.Parent or IsDestroying then break end
				if AnimalModel:GetAttribute("ForceEventExit") then
					AnimalModel:SetAttribute("OnBackroomsPath", nil)
					local snapPos = snapToGround(RoadEndPart.Position, AnimalModel, isEventRoad)
					AnimalModel:PivotTo(CFrame.new(snapPos))
					break
				end
				local waypointPos = Waypoints[i].Position
				local arrived     = false
				local conn
				conn = RunService.Heartbeat:Connect(function(dt)
					if IsDestroying or not AnimalModel or not AnimalModel.Parent
						or AnimalModel:GetAttribute("ForceEventExit") then
						conn:Disconnect(); arrived = true; return
					end
					if AnimalModel:GetAttribute("ForceIdle") then return end
					local currentAnimalPos = AnimalPart.Position
					local horizTarget = Vector3.new(waypointPos.X, currentAnimalPos.Y, waypointPos.Z)
					local direction   = horizTarget - currentAnimalPos
					local distance    = direction.Magnitude
					if distance < 0.5 then conn:Disconnect(); arrived = true; return end
					local currentSpeed = math.max(GlobalSpeedOverride or OriginalSpeed, 1)
					local moveStep     = math.min(currentSpeed * dt, distance)
					local nextHorizPos = currentAnimalPos + direction.Unit * moveStep
					local groundPos = snapToGround(nextHorizPos, AnimalModel, false)
					local currentY  = currentAnimalPos.Y
					local groundY   = groundPos.Y
					local newY
					if groundY < currentY then
						newY = math.max(groundY, currentY - GROUND_SINK_SPEED * dt)
					else
						newY = math.min(groundY, currentY + GROUND_RISE_SPEED * dt)
					end
					local newPos      = Vector3.new(groundPos.X, newY, groundPos.Z)
					local lookTowards = (i < #Waypoints) and Waypoints[i + 1].Position or RoadEndPart.Position
					local lookAtFlat  = Vector3.new(lookTowards.X, newPos.Y, lookTowards.Z)
					AnimalModel:PivotTo(CFrame.lookAt(newPos, lookAtFlat))
				end)
				while not arrived do task.wait() end
				if not AnimalModel or not AnimalModel.Parent or IsDestroying then break end
				if i == #Waypoints then
					if SoundSpecialRarities[AnimalData.Rarity] then
						local Sound = ANIMAL_SOUNDS:FindFirstChild(indexName)
						if Sound then
							for _, p in game.Players:GetPlayers() do
								SoundService:Play(p, Sound)
							end
						end
					end
				end
			end
			isOnBackroomsPath = false
			if AnimalModel and AnimalModel.Parent then
				AnimalModel:SetAttribute("OnBackroomsPath", nil)
			end
			if AnimalModel and AnimalModel.Parent and not IsDestroying then
				local snapPos  = snapToGround(AnimalPart.Position, AnimalModel, isEventRoad)
				local lookDir  = (RoadEndPart.Position - snapPos)
				local flatLook = Vector3.new(lookDir.X, 0, lookDir.Z)
				if flatLook.Magnitude > 0.01 then
					AnimalModel:PivotTo(CFrame.lookAt(snapPos, snapPos + flatLook.Unit))
				end
				MoveAlongPath(MoveTarget)
			end
			EventPathOccupied = false
			task.spawn(function()
				if not AnimalModel or not AnimalModel.Parent then return end
				if AnimalModel:HasTag("BackroomsAnimal") then
					AnimalModel:SetAttribute("BackroomsToAnimalSwap", true)
					AnimalModel:RemoveTag("BackroomsAnimal")
					AnimalModel:AddTag("Animal")
				end
				spawnPrompt()
			end)
			task.spawn(function()
				local rarity, name = AnimalData.Rarity, AnimalData.DisplayName
				if rarity == "Secret" and name ~= "Lucky Block" then
					ChatService:SendMessage("<font color='#000000'>[SERVER] A secret Brainrot has spawned!</font>")
				elseif rarity == "OG" then
					ChatService:SendMessage("<font color='#FFD700'>[SERVER] A " .. name .. " has spawned!</font>")
				end
				if name == "Lucky Block" then
					if rarity == "Admin" then
						ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Admin Lucky Block</font><font color='#d1d202'> has spawned!</font>")
					elseif rarity == "Spooky" then
						ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Spooky Lucky Block</font><font color='#d1d202'> has spawned!</font>")
					elseif rarity == "Taco" then
						ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Taco Lucky Block</font><font color='#d1d202'> has spawned!</font>")
					elseif rarity == "Brainrot God" then
						ChatService:SendMessage("<font color='#22afe2'>[SERVER] A Brainrot God Lucky Block has spawned!</font>")
					elseif rarity == "Secret" and name == "Coffin Tung Tung Tung Sahur" then
						ChatService:SendMessage("<font color='#000000'>[SERVER] A Coffin Tung Tung Tung Sahur has spawned!</font>")
					elseif rarity == "Secret" then
						ChatService:SendMessage("<font color='#000000'>[SERVER] A Secret Lucky Block has spawned!</font>")
					end
				end
				if TriggerEvent and not isFuseSpawn and not CustomSpawn then
					if name == "Los Ogs" then
						EventService:ExecuteEvent("Strawberry", 300)
						EventService:ExecuteEvent("Meowl", 300)
						EventService:ExecuteEvent("Skibidi", 300)
					elseif name == "Los Admins" then
						EventService:ExecuteEvent("Phase 1: Sleepy", 300)
						EventService:ExecuteEvent("Sammyni Spyderini", 300)
					elseif AnimalData.TriggerEvent then
						local triggerDelay   = AnimalData.TriggerEventDelay or 0
						local triggerEvent   = AnimalData.TriggerEvent
						local triggerOptions = AnimalData.TriggerEventOptions
						if triggerDelay > 0 then
							task.delay(triggerDelay, function()
								if not IsDestroying then
									EventService:ExecuteEvent(triggerEvent, name == "Wheelchair Granny" and 180 or 300)
								end
							end)
						else
							EventService:ExecuteEvent(triggerEvent, nil, nil, triggerOptions)
						end
					end
				end
			end)
		end)
		if ForceIdleConnection then ForceIdleConnection:Disconnect() end
		ForceIdleConnection = AnimalModel.AttributeChanged:Connect(function(AttributeName)
			if AttributeName == "ForceIdle" then
				if isOnBackroomsPath then return end
				updateForceIdle()
			end
		end)
	else
		if AnimalModel and AnimalModel.Parent and AnimalModel.PrimaryPart then
			if SoundSpecialRarities[AnimalData.Rarity]
				and not (FinalMutation == "Divine" and ReplicatedStorage:GetAttribute("DivineStairsEnabled")) then
				local Sound = ANIMAL_SOUNDS:FindFirstChild(indexName)
				if Sound then
					for _, Player in game.Players:GetPlayers() do
						SoundService:Play(Player, Sound)
					end
				end
			end
		end
		spawnPrompt()
		MoveAlongPath(MoveTarget)
	end
	do
		local broadcastCfg = BROADCAST_LIST[AnimalData.DisplayName]
		if broadcastCfg then
			fireBroadcast("spawn", AnimalData.DisplayName, nil, broadcastCfg.global, AnimalName, nil, FinalMutation)
		end
	end
	beginCoffinSahurCycle(AnimalModel, AnimalData, function() return IsDestroying end)
	return AnimalModel
end
local function rollCatchUpAnimal(): (any?, string?)
	if YoIsTsModded then
		local pool = {}
		for _, Data in pairs(Animals) do
			if not GameDataServerStorage.UnSpawnableBrainrots[Data.DisplayName]
				and not GameDataServerStorage.UnSpawnableBrainrots[Data.LuckyBlock] then
				table.insert(pool, Data)
			end
		end
		if #pool == 0 then return nil, nil end
		local data = pool[math.random(1, #pool)]
		local mutation
		if math.random(1, 100) > 15 then
			local muts = {}
			for Name in pairs(Mutations) do table.insert(muts, Name) end
			if #muts > 0 then mutation = muts[math.random(1, #muts)] end
		end
		for EventName, EventData in pairs(EventMutationsList) do
			if ReplicatedStorage:GetAttribute(EventName) == true then
				if math.random(1, 100) <= EventData.Chance then
					mutation = EventData.Mutation
					break
				end
			end
		end
		return data, mutation
	end
	return randomAnimalForRoad(), nil
end
local _prePopulating: { [string]: boolean } = {}
local function PrePopulateEventTrack(eventName: string)
	if _prePopulating[eventName] then return end
	if not EventService:GetActiveEvent(eventName) then return end
	local pathFolder, walkSpeed
	if eventName == "1x1x1x1" then
		pathFolder = script:FindFirstChild("Path")
		walkSpeed  = 10
	elseif eventName == "Backrooms" then
		pathFolder = script:FindFirstChild("BrainrotWaypoints")
		walkSpeed  = GlobalSpeedOverride or GameData.RoadSpawn.AnimalSpeed or 15
	else
		return
	end
	if not pathFolder then
		warn(("[AnimalService] PrePopulateEventTrack: waypoint folder for %s not found"):format(eventName))
		return
	end
	if not walkSpeed or walkSpeed <= 0 then return end
	local Waypoints = pathFolder:GetChildren()
	table.sort(Waypoints, function(a, b) return tonumber(a.Name) < tonumber(b.Name) end)
	if #Waypoints < 2 then return end
	local totalLen = 0
	for j = 2, #Waypoints do
		totalLen += (Waypoints[j].Position - Waypoints[j - 1].Position).Magnitude
	end
	if totalLen <= 0 then return end
	local totalPathTime = totalLen / walkSpeed
	local spawnEvery    = GameData.RoadSpawn.SpawnEvery
	if not spawnEvery or spawnEvery <= 0 then return end
	local delta = 0
	if MainRoadNextSpawnTime then
		delta = MainRoadNextSpawnTime - os.clock()
	end
	delta = delta % spawnEvery
	if delta < 0 then delta += spawnEvery end
	local maxSlots = math.ceil((totalPathTime + spawnEvery) / spawnEvery) + 1
	_prePopulating[eventName] = true
	for j = 1, maxSlots do
		if not EventService:GetActiveEvent(eventName) then break end
		local progress = (j * spawnEvery - delta) / totalPathTime
		if progress <= 0 then
			continue
		end
		if progress >= 1 then
			break
		end
		local AnimalData, Mutation = rollCatchUpAnimal()
		if AnimalData then
			task.spawn(function()
				CreateAnimal({
					AnimalData      = AnimalData,
					Mutation        = Mutation,
					SkipSpawnDelay  = true,
					CatchUpProgress = progress,
				})
			end)
			task.wait()
		end
	end
	_prePopulating[eventName] = false
end
local function CleanupEventTrackAnimals(eventName: string)
	for _, entry in pairs(ActiveAnimals) do
		local model = entry.Model
		if model and model.Parent then
			local belongsToTrack
			if eventName == "1x1x1x1" then
				belongsToTrack = model:HasTag("1x1x1x1animal")
			elseif eventName == "Backrooms" then
				belongsToTrack = model:HasTag("BackroomsAnimal")
					or model:GetAttribute("OnBackroomsPath")
			end
			if belongsToTrack and entry.ForceFinishFunction then
				task.spawn(entry.ForceFinishFunction)
			end
		end
	end
end
function AnimalService:CancelEventTrackAnimals(eventName: string)
	CleanupEventTrackAnimals(eventName)
end
task.spawn(function()
	local prev1x1x1     = Is1x1x1x1Active() ~= nil
	local prevBackrooms = EventService:GetActiveEvent("Backrooms") ~= nil
	while true do
		local now1x1x1     = Is1x1x1x1Active() ~= nil
		local nowBackrooms = EventService:GetActiveEvent("Backrooms") ~= nil
		if now1x1x1 and not prev1x1x1 then
			task.spawn(function() PrePopulateEventTrack("1x1x1x1") end)
		elseif prev1x1x1 and not now1x1x1 then
			task.spawn(function() CleanupEventTrackAnimals("1x1x1x1") end)
		end
		if nowBackrooms and not prevBackrooms then
			task.spawn(function() PrePopulateEventTrack("Backrooms") end)
		elseif prevBackrooms and not nowBackrooms then
			task.spawn(function() CleanupEventTrackAnimals("Backrooms") end)
		end
		prev1x1x1     = now1x1x1
		prevBackrooms = nowBackrooms
		task.wait(0.2)
	end
end)
function AnimalService:SpawnNoDelay(AnimalData, Mutation, Traits, Speed, CustomSpawn, AFKTime, ForceStraightLine)
	local animalId = HttpService:GenerateGUID(false)
	CreateAnimal({
		AnimalData        = AnimalData,
		Mutation          = Mutation,
		Traits            = Traits,
		Speed             = Speed,
		CustomSpawn       = CustomSpawn,
		AFKTime           = AFKTime,
		ForceStraightLine = ForceStraightLine,
		PreGeneratedId    = animalId,
	})
	return animalId
end
function AnimalService.spawnAnimalInBase(Player: Player, Animal: string, Mutation: string?, Traits: any?, IsFake: boolean?)
	local PlayerChannel = Synchronizer:Wait(Player)
	if not PlayerChannel then return end
	local Podiums = PlotService.getFreePodium(Player)
	if not Podiums then
		return
	end
	local AnimalPodiums = PlayerChannel:Get("AnimalPodiums")
	local Index = PlayerChannel:Get("Index")
	if not IsFake then
		if not LuckyBlocks[Animal] then
			Index[Animal] = Index[Animal] or {}
			if Mutation then
				Index[Animal][Mutation] = (Index[Animal][Mutation] or 0) + 1
			else
				Index[Animal].Default = (Index[Animal].Default or 0) + 1
			end
		end
	end
	local PodiumIndex = tonumber(Podiums.Name)
	AnimalPodiums[PodiumIndex] = {
		Index = Animal,
		LastCollect = workspace:GetServerTimeNow(),
		Mutation = Mutation,
		Traits = Traits,
		Timer = LuckyBlocks[Animal] and 0 or nil,
		isfake = IsFake and true or nil,
	}
	PlayerChannel:Set("Index", Index)
	PlayerChannel:Set("AnimalPodiums", AnimalPodiums)
	PlayerChannel:Set("AnimalAddedOrRemoved", true)
end
function AnimalService.spawnAnimalCustom(Animal: any, Mutation: string?, Traits: {string}?, Speed: number?, CustomSpawn: {Start: BasePart?, End: BasePart?, Owner: Player?}?, StandFor: number?, IsIstant: boolean, isfake: boolean, isAnimalFakeInBase: boolean?, customGeneration: number?, customRarity: string?, customPrice: number?, roadindex: number?, SkipSpawnDelay:boolean, CustomDisplayName: string, CustomModelScale:number )
	local animalId = HttpService:GenerateGUID(false)
	roadindex = roadindex or 1
	if IsIstant then
		task.spawn(function()
			CreateAnimal({
				AnimalData         = Animal,
				Mutation           = Mutation,
				Traits             = Traits or {},
				Speed              = Speed,
				CustomSpawn        = CustomSpawn,
				AFKTime            = StandFor,
				ForceStraightLine  = false,
				PreGeneratedId     = animalId,
				IsFake             = isfake,
				IsAnimalFakeInBase = isAnimalFakeInBase,
				CustomGeneration   = customGeneration,
				CustomRarity       = customRarity,
				CustomPrice        = customPrice,
				RoadIndex          = roadindex,
				SkipSpawnDelay     = SkipSpawnDelay,
				CustomDisplayName  = CustomDisplayName,
				CustomModelScale   = CustomModelScale
			})
		end)
	else
		if roadindex == 2 or roadindex == 3 then
			table.insert(THREE_ROADS_QUEUE[roadindex], {
				Animal             = Animal,
				Mutation           = Mutation,
				Traits             = Traits,
				Speed              = Speed,
				AFKTime            = StandFor,
				CustomSpawn        = CustomSpawn,
				AnimalId           = animalId,
				isfake             = isfake,
				isAnimalFakeInBase = isAnimalFakeInBase,
				customGeneration   = customGeneration,
				customRarity       = customRarity,
				customPrice        = customPrice,
				SkipSpawnDelay     = SkipSpawnDelay,
				CustomDisplayName  = CustomDisplayName,
				CustomModelScale   = CustomModelScale
			})
		else
			table.insert(NEXT_QUEUE, {
				Animal = Animal,
				Mutation = Mutation,
				Traits = Traits,
				Speed = Speed,
				CustomSpawn = CustomSpawn,
				AFKTime = StandFor,
				AnimalId = animalId,
				isfake = isfake,
				isAnimalFakeInBase = isAnimalFakeInBase,
				customGeneration = customGeneration,
				customRarity = customRarity,
				customPrice = customPrice,
				SkipSpawnDelay     = SkipSpawnDelay,
				CustomDisplayName  = CustomDisplayName,
				CustomModelScale   = CustomModelScale
			})
		end
	end
	return animalId
end
function AnimalService.SpawnThreeRoads(Animal: any, Mutation: string?, Traits: {string}?, Speed: number?, StandFor: number?)
	if not EventService:IsEventActive("3 Roads") then
		warn("[AnimalService] SpawnThreeRoads called but '3 Roads' event is not active – ignoring.")
		return
	end
	table.insert(NEXT_QUEUE, {
		Animal = Animal,
		Mutation = Mutation,
		Traits = Traits,
		Speed = Speed,
		AFKTime = StandFor,
		AnimalId = HttpService:GenerateGUID(false)
	})
	for i = 2, 3 do
		table.insert(THREE_ROADS_QUEUE[i], {
			Animal   = Animal,
			Mutation = Mutation,
			Traits   = Traits,
			Speed    = Speed,
			AFKTime  = StandFor,
		})
	end
end
function AnimalService.ResetThreeRoadsData()
	for roadIndex = 2, 3 do
		ThreeRoadsData[roadIndex].GuaranteedLegendary   = 300
		ThreeRoadsData[roadIndex].GuaranteedMythic      = 900
		ThreeRoadsData[roadIndex].PendingSpawnDelayAnimal = nil
		ThreeRoadsData[roadIndex].SpawnDelayEndTime     = 0
		ThreeRoadsData[roadIndex].PendingMutation       = nil
		ThreeRoadsData[roadIndex].SkipNextSpawn         = false
		ThreeRoadsData[roadIndex].InSyncGroup           = true
		THREE_ROADS_QUEUE[roadIndex] = {}
	end
	SyncEpoch = nil
end
function AnimalService.SpawnForcedAnimal(Animal: any, Mutation: string?)
	local FinalMutation = Mutation or GetRandomMutation()
	local animalId = HttpService:GenerateGUID(false)
	table.insert(NEXT_QUEUE, {
		Animal = Animal,
		Mutation = FinalMutation,
		AnimalId = animalId
	})
	return animalId
end
function AnimalService.spawnAnimal(Animal: any)
	local FinalMutation: string?
	local FinalTraits: {string} = {}
	local ForceStraightLine = false
	local ForcedMutationName = nil
	local CurrentMutation = nil
	do
		local RainMutation = ReplicatedStorage:GetAttribute("MutationRain")
		local RainAmount = ReplicatedStorage:GetAttribute("MutationRainAmount")
		if RainMutation and RainAmount and RainAmount > 0 then
			if RainMutation == "_CYCLE_" then
				local cycleList = {}
				for name in pairs(Mutations) do
					table.insert(cycleList, name)
				end
				table.sort(cycleList)
				if #cycleList > 0 then
					local prevIndex = ReplicatedStorage:GetAttribute("MutationRainCycleIndex") or 0
					local nextIndex = (prevIndex % #cycleList) + 1
					ForcedMutationName = cycleList[nextIndex]
					ReplicatedStorage:SetAttribute("MutationRainCycleIndex", nextIndex)
				end
			elseif Mutations[RainMutation] then
				ForcedMutationName = RainMutation
			else
				warn("[AnimalService] MutationRain references unknown mutation: " .. tostring(RainMutation))
			end
			local remaining = RainAmount - 1
			if remaining <= 0 then
				ReplicatedStorage:SetAttribute("MutationRain", nil)
				ReplicatedStorage:SetAttribute("MutationRainAmount", nil)
				ReplicatedStorage:SetAttribute("MutationRainCycleIndex", nil)
			else
				ReplicatedStorage:SetAttribute("MutationRainAmount", remaining)
			end
		end
	end
	if ForcedMutationName and ForcedMutationName ~= "" then
		if Mutations[ForcedMutationName] then
			FinalMutation = ForcedMutationName
			CurrentMutation = ForcedMutationName
		else
			warn("Mutation not found in Mutations table: " .. tostring(ForcedMutationName))
		end
	else
		for EventName, EventData in pairs(EventMutationsList) do
			if ReplicatedStorage:GetAttribute(EventName) == true then
				if math.random(1, 100) <= EventData.Chance then
					FinalMutation = EventData.Mutation
					ForceStraightLine = false
					break
				end
			end
		end
	end
	if not FinalMutation then
		local randChance = math.random(1, 10)
		if randChance == 1 then
			local TotalWeight = 0
			local WeightedMutations = {}
			for Name, Data in pairs(Mutations) do
				if Data.Weight and Data.Weight > 0 then
					TotalWeight += Data.Weight
					table.insert(WeightedMutations, { Name = Name, Weight = Data.Weight })
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
	return CreateAnimal({
		AnimalData        = Animal,
		Mutation          = FinalMutation,
		Traits            = FinalTraits,
		ForceStraightLine = ForceStraightLine,
	})
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
			table.insert(Candidates, { Name = Name, Data = Data })
		end
	end
	if #Candidates == 0 then
		return nil
	end
	local ServerLuck = Synchronizer:Get("ServerLuck")
	local LuckMultiplier = ServerLuck and ServerLuck:Get("Index")
	if not LuckMultiplier then
		LuckMultiplier = 1
	end
	if LuckMultiplier  and LuckMultiplier == nil then
		LuckMultiplier = 1
	end
	local TotalWeight = 0
	local WeightedAnimals = {}
	for _, Entry in ipairs(Candidates) do
		local Data = Entry.Data
		if Data.RoadWeight and Data.RoadWeight > 0 then
			local AdjustedWeight = Data.RoadWeight
			if Data.Rarity then
				local RarityPowers = {
					Common = 0,
					Rare = 0.3,
					Epic = 0.5,
					Legendary = 1,
					Mythic = 1.3,
					["Brainrot God"] = 2,
					Secret = 3,
					OG = 7,
				}
				local Power = RarityPowers[Data.Rarity] or 0
				AdjustedWeight = AdjustedWeight * (LuckMultiplier ^ Power)
				AdjustedWeight = math.min(AdjustedWeight, 1e9)
			end
			TotalWeight = TotalWeight + AdjustedWeight
			table.insert(WeightedAnimals, { Name = Entry.Name, Weight = AdjustedWeight })
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
	ForcedRarityEndTime = os.clock() + Duration
	task.delay(Duration, function()
		if ForcedRarity == Rarity and os.clock() >= ForcedRarityEndTime then
			ForcedRarity = nil
			ForcedRarityEndTime = 0
		end
	end)
end
function AnimalService.SetSpeed(Speed: number)
	GlobalSpeedOverride = Speed
end
function AnimalService.MarkServerClosing()
	ServerShuttingDown = true
end
function AnimalService.DepositBoughtAnimalsForPlayer(player: Player): number
	local snapshot = {}
	for name, entry in pairs(ActiveAnimals) do
		snapshot[name] = entry
	end
	local deposited = 0
	for name, entry in pairs(snapshot) do
		local depositFn = entry and entry.ForceDepositForPlayerIfBought
		if depositFn then
			local ok, didDeposit = pcall(depositFn, player)
			if not ok then
				warn("[AnimalService] Deposit errored for", name, "-", didDeposit)
			elseif didDeposit then
				deposited += 1
			end
		end
	end
	return deposited
end
function AnimalService.DepositAllBoughtAnimals(): number
	local snapshot = {}
	for name, entry in pairs(ActiveAnimals) do
		snapshot[name] = entry
	end
	local deposited = 0
	for name, entry in pairs(snapshot) do
		local depositFn = entry and entry.ForceDepositForPlayerIfBought
		if depositFn then
			local ok, didDeposit = pcall(depositFn, nil)
			if ok and didDeposit then
				deposited += 1
			end
		end
	end
	if deposited > 0 then
		warn(string.format("[AnimalService] Shutdown: deposited %d bought animal(s) into plots", deposited))
	end
	return deposited
end

local IsAdmin = require(ReplicatedStorage.Shared.IsAdmin)

local MUTATION_RAIN_TOPIC = "AnimalService/GlobalMutationRain"
local MUTATION_RAIN_CYCLE_SENTINEL = "_CYCLE_"

local rainQueue = {}
local rainIsProcessing = false
local rainCurrentActive = nil

local function clearRainAttributes()
	ReplicatedStorage:SetAttribute("MutationRain", nil)
	ReplicatedStorage:SetAttribute("MutationRainAmount", nil)
	ReplicatedStorage:SetAttribute("MutationRainCycleIndex", nil)
end

local function processRainQueue()
	if rainIsProcessing then return end
	rainIsProcessing = true
	while #rainQueue > 0 do
		local current = table.remove(rainQueue, 1)
		rainCurrentActive = current
		ReplicatedStorage:SetAttribute("MutationRain", current.mutation)
		ReplicatedStorage:SetAttribute("MutationRainAmount", current.amount)
		ReplicatedStorage:SetAttribute("MutationRainCycleIndex", 0)
		while rainCurrentActive == current do
			local remaining = ReplicatedStorage:GetAttribute("MutationRainAmount")
			if not remaining or remaining <= 0 then break end
			task.wait(0.25)
		end
		if rainCurrentActive == current then
			clearRainAttributes()
			rainCurrentActive = nil
		end
	end
	rainIsProcessing = false
end

local function cleanRainName(s)
	if not s then return "" end
	return tostring(s):gsub("^%s*(.-)%s*$", "%1")
end

function AnimalService:StartMutationRain(mutationName: string?, amount: number)
	amount = tonumber(amount)
	if not amount or amount <= 0 then return false end
	amount = math.floor(amount)

	local cleanName = cleanRainName(mutationName)
	local resolved
	if cleanName == "" then
		resolved = MUTATION_RAIN_CYCLE_SENTINEL
	elseif Mutations[cleanName] then
		resolved = cleanName
	else
		return false
	end

	table.insert(rainQueue, { mutation = resolved, amount = amount })

	NotificationService.Broadcast(
		string.format("Fayple activated <rainbow></rainbow> for the next %d Brainrots!", amount),
		5, "Sounds.Sfx.Success"
	)

	task.spawn(processRainQueue)
	return true, resolved
end

function AnimalService:StopMutationRain(mutationName: string?)
	local cleanName = cleanRainName(mutationName)
	if cleanName == "" then
		rainQueue = {}
		if rainCurrentActive then
			rainCurrentActive = nil
			clearRainAttributes()
		end
		return true
	end
	local target = Mutations[cleanName] and cleanName or nil
	if not target then return true end
	for i = #rainQueue, 1, -1 do
		if rainQueue[i].mutation == target then
			table.remove(rainQueue, i)
		end
	end
	if rainCurrentActive and rainCurrentActive.mutation == target then
		rainCurrentActive = nil
		clearRainAttributes()
	end
	return true
end

function AnimalService:StartGlobalMutationRain(mutationName: string?, amount: number, requesterUserId: number?)
	if not (requesterUserId ~= nil and IsAdmin(requesterUserId)) then
		warn("[AnimalService] StartGlobalMutationRain denied — non-admin/missing userId:", tostring(requesterUserId))
		return false, "Only admins can start a global "
	end
	amount = tonumber(amount)
	if not amount or amount <= 0 then return false, "Amount must be a positive number" end
	amount = math.floor(amount)
	local cleanName = cleanRainName(mutationName)
	if cleanName ~= "" and not Mutations[cleanName] then
		return false, ("Unknown mutation: %s"):format(cleanName)
	end
	AnimalService:StartMutationRain(cleanName, amount)
	MessagingService:PublishAsync(MUTATION_RAIN_TOPIC, {
		action = "start",
		mutation = cleanName,
		amount = amount,
		originJobId = game.JobId,
	})
	return true
end

function AnimalService:StopGlobalMutationRain(mutationName: string?, requesterUserId: number?)
	if not (requesterUserId ~= nil and IsAdmin(requesterUserId)) then
		return false, "Only admins can stop a global "
	end
	local cleanName = cleanRainName(mutationName)
	AnimalService:StopMutationRain(cleanName)
	MessagingService:PublishAsync(MUTATION_RAIN_TOPIC, {
		action = "stop",
		mutation = cleanName,
		originJobId = game.JobId,
	})
	return true
end
function AnimalService:Start()
	local Paused = false
	task.spawn(function()
		GlobalLiveboardFilterEnabled = FFlags:Get(TOGGLE_STORE_KEY, false) == true
		FFlags:OnChange(TOGGLE_STORE_KEY, function(newValue)
			GlobalLiveboardFilterEnabled = newValue == true
		end)
	end)
	local toggleSubOk, toggleSubErr = pcall(function()
		MessagingService:SubscribeAsync(TOGGLE_MS_TOPIC, function(data)
			if type(data) ~= "table" then return end
			if data.originJobId == game.JobId then return end
			if type(data.enabled) == "boolean" then
				GlobalLiveboardFilterEnabled = data.enabled
				warn(string.format(
					"[AnimalService] Liveboard filter synced from remote server: %s",
					tostring(GlobalLiveboardFilterEnabled)
					))
			end
		end)
	end)
	if not toggleSubOk then
		warn("[AnimalService] Failed to subscribe to LiveboardToggle_Broadcast:", toggleSubErr)
	end
	local rainSubOk, rainSubErr = pcall(function()
		MessagingService:SubscribeAsync(MUTATION_RAIN_TOPIC, function(data)
			if type(data) ~= "table" then return end
			if data.originJobId == game.JobId then return end
			if data.action == "start" then
				AnimalService:StartMutationRain(data.mutation, data.amount)
			elseif data.action == "stop" then
				AnimalService:StopMutationRain(data.mutation)
			end
		end)
	end)
	if not rainSubOk then
		warn("[AnimalService] Failed to subscribe to GlobalMutationRain:", rainSubErr)
	end
	function AnimalService:PauseSpawning()  Paused = true  end
	function AnimalService:UnpauseSpawning() Paused = false end
	game:BindToClose(function()
		AnimalService.MarkServerClosing()
		AnimalService.DepositAllBoughtAnimals()
	end)
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
			if GuaranteedLegendary > 0 then GuaranteedLegendary -= 1 end
			if GuaranteedMythic > 0 then GuaranteedMythic -= 1 end
			MainFrame.Legendary.Text = string.format('Guaranteed <font color="#fbff00">Legendary</font> in %*', TimeUtils:B(GuaranteedLegendary))
			MainFrame.Mythic.Text    = string.format('Guaranteed <font color="#ff0000">Mythic</font> in %*', TimeUtils:B(GuaranteedMythic))
			task.wait(1)
		end
	end)
	task.wait(2)
	local function syncDivineStairs()
		local is1x1x1Active = ReplicatedStorage:GetAttribute("1x1x1x1")
		if is1x1x1Active then
			ReplicatedStorage:SetAttribute("DivineStairsEnabled", false)
			if AprilFoolsMode then
				AnimalService.SetAprilFoolsMode(false)
			end
		end
	end
	syncDivineStairs()
	ReplicatedStorage.AttributeChanged:Connect(function(attributeName)
		if attributeName == "1x1x1x1" then
			syncDivineStairs()
		end
	end)
	task.spawn(function()
		while true do
			local DefaultInterval = GameData.RoadSpawn.SpawnEvery
			task.wait(DefaultInterval)
			if not Paused then
				if not EventService:IsEventActive("3 Roads") then
					SyncEpoch = nil
					continue
				end
				local MainRoadRemainingDelay = 0
				if MainRoadNextSpawnTime and DefaultInterval > 0 then
					local rem = MainRoadNextSpawnTime - os.clock()
					if rem > 0 then MainRoadRemainingDelay = rem end
				end
				local Offset = (DefaultInterval > 0)
					and (MainRoadRemainingDelay % DefaultInterval)
					or 0
				if Offset > 0 then
					local alignEndTime = os.clock() + Offset
					for _, ri in ipairs({2, 3}) do
						if ThreeRoadsData[ri].SpawnDelayEndTime <= os.clock() then
							ThreeRoadsData[ri].SpawnDelayEndTime = alignEndTime
						end
					end
					task.wait(Offset)
					for _, ri in ipairs({2, 3}) do
						local endTime = ThreeRoadsData[ri].SpawnDelayEndTime
						if endTime > 0 and endTime <= os.clock() then
							ThreeRoadsData[ri].SpawnDelayEndTime = 0
						end
					end
				end
				SyncEpoch = os.clock()
				for _, roadIndex in ipairs({2, 3}) do
					task.spawn(function()
						local roadData = ThreeRoadsData[roadIndex]
						local AnimalToSpawn = nil
						local roadMutation  = nil
						local queued = table.remove(THREE_ROADS_QUEUE[roadIndex], 1)
						if queued then
							AnimalToSpawn = queued.Animal
							roadMutation  = queued.Mutation
							local queuedTraits             = queued.Traits
							local queuedSpeed              = queued.Speed
							local queuedAFKTime            = queued.AFKTime
							local queuedCustomSpawn        = queued.CustomSpawn
							local queuedAnimalId           = queued.AnimalId
							local queuedIsFake             = queued.isfake
							local queuedIsAnimalFakeInBase = queued.isAnimalFakeInBase
							local queuedCustomGeneration   = queued.customGeneration
							local queuedCustomRarity       = queued.customRarity
							local queuedCustomPrice        = queued.customPrice
							if AnimalToSpawn.SpawnDelay and AnimalToSpawn.SpawnDelay > 0 then
								local rStart = getRoadParts(roadIndex)
								local isCyber3 = (roadMutation == "Cyber" and ReplicatedStorage:GetAttribute("CyberEvent") == true)
								local isPhantom3 = (roadMutation == "Phantom" and ReplicatedStorage:GetAttribute("PhantomEvent") == true)
								local extraCyberDelay = (isCyber3 or isPhantom3) and BEACON_DELAY or 0
								if isCyber3 then
									Net:RemoteEvent("GameService/CyberBeaconAnimation"):FireAllClients()
								elseif isPhantom3 then
									Net:RemoteEvent("GameService/PhantomCaveFlash"):FireAllClients()
								end
								local totalDelay = AnimalToSpawn.SpawnDelay + extraCyberDelay
								local spawnAt    = os.clock() + totalDelay
								ScheduleSyncPaddingForRoad(roadIndex, spawnAt)
								local capturedRoad     = roadIndex
								local capturedAnimal   = AnimalToSpawn
								local capturedMutation = roadMutation
								local capturedVFX      = AnimalToSpawn.SpawnVFX
								local capturedVFXDelay = AnimalToSpawn.SpawnDelay
								local capturedRStart   = rStart
								task.delay(extraCyberDelay, function()
									if capturedVFX and capturedRStart then
										Net:RemoteEvent("GameService/SpawnEffect"):FireAllClients(
											capturedVFX,
											capturedVFXDelay,
											capturedRStart.CFrame
										)
									end
								end)
								task.delay(totalDelay, function()
									CreateAnimal({
										AnimalData      = capturedAnimal,
										Mutation        = capturedMutation,
										RoadIndex       = capturedRoad,
										VfxAlreadyFired = true,
									})
									local _rd = ThreeRoadsData[capturedRoad]
									if _rd then
										_rd.SpawnDelayEndTime = os.clock() + (GameData.RoadSpawn.SpawnEvery or 4)
									end
								end)
							else
								task.spawn(function()
									CreateAnimal({
										AnimalData      = AnimalToSpawn,
										Mutation        = roadMutation,
										RoadIndex       = roadIndex,
										Traits          = queuedTraits,
										Speed           = queuedSpeed,
										AFKTime         = queuedAFKTime,
										CustomSpawn     = queuedCustomSpawn,
										AnimalId        = queuedAnimalId,
										isfake          = queuedIsFake,
										isAnimalFakeInBase = queuedIsAnimalFakeInBase,
										customGeneration = queuedCustomGeneration,
										customRarity    = queuedCustomRarity,
										customPrice     = queuedCustomPrice,
									})
								end)
							end
							if roadData.GuaranteedLegendary > 0 then roadData.GuaranteedLegendary -= 1 end
							if roadData.GuaranteedMythic    > 0 then roadData.GuaranteedMythic    -= 1 end
							return
						end
						if roadData.SkipNextSpawn then
							roadData.SkipNextSpawn = false
							if roadData.GuaranteedLegendary > 0 then roadData.GuaranteedLegendary -= 1 end
							if roadData.GuaranteedMythic    > 0 then roadData.GuaranteedMythic    -= 1 end
							return
						end
						if not AnimalToSpawn and os.clock() >= roadData.SpawnDelayEndTime then
							if YoIsTsModded then
								local AllAnimals = {}
								for Name, Data in pairs(Animals) do
									if not GameDataServerStorage.UnSpawnableBrainrots[Data.DisplayName] and not GameDataServerStorage.UnSpawnableBrainrots[Data.LuckyBlock] then
										table.insert(AllAnimals, Data)
									end
								end
								if #AllAnimals > 0 then
									AnimalToSpawn = AllAnimals[math.random(1, #AllAnimals)]
								end
								if AnimalToSpawn then
									if math.random(1, 100) > 15 then
										local AllMutations = {}
										for Name, _ in pairs(Mutations) do
											table.insert(AllMutations, Name)
										end
										if #AllMutations > 0 then
											roadMutation = AllMutations[math.random(1, #AllMutations)]
										end
									end
									for EventName, EventData in pairs(EventMutationsList) do
										if ReplicatedStorage:GetAttribute(EventName) == true then
											if math.random(1, 100) <= EventData.Chance then
												roadMutation = EventData.Mutation
												break
											end
										end
									end
								end
							else
								if roadData.GuaranteedMythic <= 0 then
									repeat
										AnimalToSpawn = getAnimalByRarityForRoad("Mythic")
									until not AnimalToSpawn or not table.find(GameDataServerStorage.UnSpawnableBrainrots or {}, AnimalToSpawn.DisplayName)
									if AnimalToSpawn and AnimalToSpawn.Rarity == "Mythic" then
										roadData.GuaranteedMythic    = 900
										roadData.GuaranteedLegendary = 300
									end
								elseif roadData.GuaranteedLegendary <= 0 then
									repeat
										AnimalToSpawn = getAnimalByRarityForRoad("Legendary")
									until not AnimalToSpawn or not table.find(GameDataServerStorage.UnSpawnableBrainrots or {}, AnimalToSpawn.DisplayName)
									if AnimalToSpawn and AnimalToSpawn.Rarity == "Legendary" then
										roadData.GuaranteedLegendary = 300
									end
								else
									AnimalToSpawn = randomAnimalForRoad()
								end
							end
							if AnimalToSpawn and AnimalToSpawn.SpawnDelay and AnimalToSpawn.SpawnDelay > 0 then
								local rStart = getRoadParts(roadIndex)
								local isCyber3 = (roadMutation == "Cyber" and ReplicatedStorage:GetAttribute("CyberEvent") == true)
								local isPhantom3 = (roadMutation == "Phantom" and ReplicatedStorage:GetAttribute("PhantomEvent") == true)
								local extraCyberDelay = (isCyber3 or isPhantom3) and BEACON_DELAY or 0
								if isCyber3 then
									Net:RemoteEvent("GameService/CyberBeaconAnimation"):FireAllClients()
								elseif isPhantom3 then
									Net:RemoteEvent("GameService/PhantomCaveFlash"):FireAllClients()
								end
								local totalDelay = AnimalToSpawn.SpawnDelay + extraCyberDelay
								local spawnAt    = os.clock() + totalDelay
								ScheduleSyncPaddingForRoad(roadIndex, spawnAt)
								local capturedRoad     = roadIndex
								local capturedAnimal   = AnimalToSpawn
								local capturedMutation = roadMutation
								local capturedVFX      = AnimalToSpawn.SpawnVFX
								local capturedVFXDelay = AnimalToSpawn.SpawnDelay
								local capturedRStart   = rStart
								task.delay(extraCyberDelay, function()
									if capturedVFX and capturedRStart then
										Net:RemoteEvent("GameService/SpawnEffect"):FireAllClients(
											capturedVFX,
											capturedVFXDelay,
											capturedRStart.CFrame
										)
									end
								end)
								task.delay(totalDelay, function()
									CreateAnimal({
										AnimalData      = capturedAnimal,
										Mutation        = capturedMutation,
										RoadIndex       = capturedRoad,
										VfxAlreadyFired = true,
									})
									local _rd = ThreeRoadsData[capturedRoad]
									if _rd then
										_rd.SpawnDelayEndTime = os.clock() + (GameData.RoadSpawn.SpawnEvery or 4)
									end
								end)
								AnimalToSpawn = nil
							elseif AnimalToSpawn and roadMutation == "Cyber"
								and ReplicatedStorage:GetAttribute("CyberEvent") == true then
								Net:RemoteEvent("GameService/CyberBeaconAnimation"):FireAllClients()
								local spawnAt = os.clock() + BEACON_DELAY
								ScheduleSyncPaddingForRoad(roadIndex, spawnAt)
								local capturedRoad     = roadIndex
								local capturedAnimal   = AnimalToSpawn
								local capturedMutation = roadMutation
								task.delay(BEACON_DELAY, function()
									CreateAnimal({
										AnimalData      = capturedAnimal,
										Mutation        = capturedMutation,
										RoadIndex       = capturedRoad,
										VfxAlreadyFired = true,
									})
									local _rd = ThreeRoadsData[capturedRoad]
									if _rd then
										_rd.SpawnDelayEndTime = os.clock() + (GameData.RoadSpawn.SpawnEvery or 4)
									end
								end)
								AnimalToSpawn = nil
							elseif AnimalToSpawn and roadMutation == "Phantom"
								and ReplicatedStorage:GetAttribute("PhantomEvent") == true then
								Net:RemoteEvent("GameService/PhantomCaveFlash"):FireAllClients()
								local spawnAt = os.clock() + BEACON_DELAY
								ScheduleSyncPaddingForRoad(roadIndex, spawnAt)
								local capturedRoad     = roadIndex
								local capturedAnimal   = AnimalToSpawn
								local capturedMutation = roadMutation
								task.delay(BEACON_DELAY, function()
									CreateAnimal({
										AnimalData      = capturedAnimal,
										Mutation        = capturedMutation,
										RoadIndex       = capturedRoad,
										VfxAlreadyFired = true,
									})
									local _rd = ThreeRoadsData[capturedRoad]
									if _rd then
										_rd.SpawnDelayEndTime = os.clock() + (GameData.RoadSpawn.SpawnEvery or 4)
									end
								end)
								AnimalToSpawn = nil
							end
						end
						if AnimalToSpawn then
							local capturedAnimal   = AnimalToSpawn
							local capturedMutation = roadMutation
							task.spawn(function()
								CreateAnimal({
									AnimalData = capturedAnimal,
									Mutation   = capturedMutation,
									RoadIndex  = roadIndex,
								})
							end)
						end
						if roadData.GuaranteedLegendary > 0 then roadData.GuaranteedLegendary -= 1 end
						if roadData.GuaranteedMythic    > 0 then roadData.GuaranteedMythic    -= 1 end
					end)
				end
			end
		end
	end)
	task.spawn(function()
		while true do
			if not Paused then
				local RandomAnimal
				local FinalMutation: string?
				local FinalTraits: {string} = {}
				local ForceStraightLine = false
				local Skip = false
				for i, Data in pairs(NEXT_QUEUE) do
					table.remove(NEXT_QUEUE, i)
					Skip = true
					CreateAnimal({
						AnimalData         = Data.Animal,
						Mutation           = Data.Mutation,
						Traits             = Data.Traits,
						Speed              = Data.Speed,
						CustomSpawn        = Data.CustomSpawn,
						AFKTime            = Data.AFKTime,
						PreGeneratedId     = Data.AnimalId,
						IsFake             = Data.isfake,
						IsAnimalFakeInBase = Data.isAnimalFakeInBase,
						CustomGeneration   = Data.customGeneration,
						CustomRarity       = Data.customRarity,
						CustomPrice        = Data.customPrice,
						RoadIndex          = Data.roadindex,
						CustomDisplayName  = Data.CustomDisplayName,
						CustomModelScale   = Data.CustomModelScale
					})
					break
				end
				if not Skip then
					if YoIsTsModded then
						local AllAnimals = {}
						for Name, Data in pairs(Animals) do
							if not GameDataServerStorage.UnSpawnableBrainrots[Data.DisplayName] and not GameDataServerStorage.UnSpawnableBrainrots[Data.LuckyBlock] then
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
							if ReplicatedStorage:GetAttribute(EventName) == true then
								if math.random(1, 100) <= EventData.Chance then
									FinalMutation = EventData.Mutation
									ForceStraightLine = false
									break
								end
							end
						end
						if RandomAnimal then
							CreateAnimal({
								AnimalData        = RandomAnimal,
								Mutation          = FinalMutation,
								Traits            = FinalTraits,
								ForceStraightLine = ForceStraightLine,
							})
						end
					else
						if ForcedRarity and os.clock() < ForcedRarityEndTime then
							repeat
								RandomAnimal = AnimalService.randomAnimal(ForcedRarity)
							until not RandomAnimal or not table.find(GameDataServerStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
						elseif GuaranteedLegendary == 0 then
							repeat
								RandomAnimal = AnimalService.randomAnimal("Legendary")
							until not RandomAnimal or not table.find(GameDataServerStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
							GuaranteedLegendary = 300
						elseif GuaranteedMythic == 0 then
							repeat
								RandomAnimal = AnimalService.randomAnimal("Mythic")
							until not RandomAnimal or not table.find(GameDataServerStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
							GuaranteedMythic = 900
						else
							repeat
								RandomAnimal = AnimalService.randomAnimal()
							until not RandomAnimal or not table.find(GameDataServerStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
						end
						if RandomAnimal then
							AnimalService.spawnAnimal(RandomAnimal)
						end
					end
				end
			end
			if false then
				for roadIndex = 2, 3 do
					local roadData = ThreeRoadsData[roadIndex]
					local AnimalToSpawn = nil
					local roadMutation = nil
					local queued = table.remove(THREE_ROADS_QUEUE[roadIndex], 1)
					if queued then
						AnimalToSpawn = queued.Animal
						roadMutation = queued.Mutation
						task.spawn(function()
							CreateAnimal({
								AnimalData = AnimalToSpawn,
								Mutation   = roadMutation,
								RoadIndex  = roadIndex,
							})
						end)
						continue
					end
					if roadData.SkipNextSpawn then
						roadData.SkipNextSpawn = false
						if roadData.GuaranteedLegendary > 0 then roadData.GuaranteedLegendary -= 1 end
						if roadData.GuaranteedMythic    > 0 then roadData.GuaranteedMythic    -= 1 end
						continue
					end
					if not AnimalToSpawn and os.clock() >= roadData.SpawnDelayEndTime then
						if YoIsTsModded then
							local AllAnimals = {}
							for Name, Data in pairs(Animals) do
								if not GameDataServerStorage.UnSpawnableBrainrots[Data.DisplayName] and not GameDataServerStorage.UnSpawnableBrainrots[Data.LuckyBlock] then
									table.insert(AllAnimals, Data)
								end
							end
							if #AllAnimals > 0 then
								AnimalToSpawn = AllAnimals[math.random(1, #AllAnimals)]
							end
							if AnimalToSpawn then
								if math.random(1, 100) > 15 then
									local AllMutations = {}
									for Name, _ in pairs(Mutations) do
										table.insert(AllMutations, Name)
									end
									if #AllMutations > 0 then
										roadMutation = AllMutations[math.random(1, #AllMutations)]
									end
								end
								for EventName, EventData in pairs(EventMutationsList) do
									if ReplicatedStorage:GetAttribute(EventName) == true then
										if math.random(1, 100) <= EventData.Chance then
											roadMutation = EventData.Mutation
											break
										end
									end
								end
							end
						else
							if roadData.GuaranteedMythic <= 0 then
								repeat
									AnimalToSpawn = getAnimalByRarityForRoad("Mythic")
								until not AnimalToSpawn or not table.find(GameDataServerStorage.UnSpawnableBrainrots or {}, AnimalToSpawn.DisplayName)
								if AnimalToSpawn and AnimalToSpawn.Rarity == "Mythic" then
									roadData.GuaranteedMythic    = 900
									roadData.GuaranteedLegendary = 300
								end
							elseif roadData.GuaranteedLegendary <= 0 then
								repeat
									AnimalToSpawn = getAnimalByRarityForRoad("Legendary")
								until not AnimalToSpawn or not table.find(GameDataServerStorage.UnSpawnableBrainrots or {}, AnimalToSpawn.DisplayName)
								if AnimalToSpawn and AnimalToSpawn.Rarity == "Legendary" then
									roadData.GuaranteedLegendary = 300
								end
							else
								AnimalToSpawn = randomAnimalForRoad()
							end
						end
						if AnimalToSpawn and AnimalToSpawn.SpawnDelay and AnimalToSpawn.SpawnDelay > 0 then
							local rStart = getRoadParts(roadIndex)
							local isCyber3 = (roadMutation == "Cyber" and ReplicatedStorage:GetAttribute("CyberEvent") == true)
							local isPhantom3 = (roadMutation == "Phantom" and ReplicatedStorage:GetAttribute("PhantomEvent") == true)
							local extraCyberDelay = (isCyber3 or isPhantom3) and BEACON_DELAY or 0
							if isCyber3 then
								Net:RemoteEvent("GameService/CyberBeaconAnimation"):FireAllClients()
							elseif isPhantom3 then
								Net:RemoteEvent("GameService/PhantomCaveFlash"):FireAllClients()
							end
							local totalDelay = AnimalToSpawn.SpawnDelay + extraCyberDelay
							roadData.SpawnDelayEndTime = os.clock() + totalDelay
							local capturedDelay    = totalDelay
							local capturedRoad     = roadIndex
							local capturedAnimal   = AnimalToSpawn
							local capturedMutation = roadMutation
							local capturedVFX      = AnimalToSpawn.SpawnVFX
							local capturedVFXDelay = AnimalToSpawn.SpawnDelay
							local capturedRStart   = rStart
							task.delay(extraCyberDelay, function()
								if capturedVFX and capturedRStart then
									Net:RemoteEvent("GameService/SpawnEffect"):FireAllClients(
										capturedVFX,
										capturedVFXDelay,
										capturedRStart.CFrame
									)
								end
							end)
							AnimalToSpawn = nil
						elseif AnimalToSpawn and roadMutation == "Cyber"
							and ReplicatedStorage:GetAttribute("CyberEvent") == true then
							Net:RemoteEvent("GameService/CyberBeaconAnimation"):FireAllClients()
							roadData.SpawnDelayEndTime = os.clock() + BEACON_DELAY
							local capturedRoad     = roadIndex
							local capturedAnimal   = AnimalToSpawn
							local capturedMutation = roadMutation
							task.delay(BEACON_DELAY, function()
								roadData.SpawnDelayEndTime = 0
								if BEACON_DELAY ~= GameData.RoadSpawn.SpawnEvery then
									ThreeRoadsData[capturedRoad].SkipNextSpawn = true
								end
								CreateAnimal({
									AnimalData      = capturedAnimal,
									Mutation        = capturedMutation,
									RoadIndex       = capturedRoad,
									VfxAlreadyFired = true,
								})
							end)
							AnimalToSpawn = nil
						elseif AnimalToSpawn and roadMutation == "Phantom"
							and ReplicatedStorage:GetAttribute("PhantomEvent") == true then
							Net:RemoteEvent("GameService/PhantomCaveFlash"):FireAllClients()
							roadData.SpawnDelayEndTime = os.clock() + BEACON_DELAY
							local capturedRoad     = roadIndex
							local capturedAnimal   = AnimalToSpawn
							local capturedMutation = roadMutation
							task.delay(BEACON_DELAY, function()
								roadData.SpawnDelayEndTime = 0
								if BEACON_DELAY ~= GameData.RoadSpawn.SpawnEvery then
									ThreeRoadsData[capturedRoad].SkipNextSpawn = true
								end
								CreateAnimal({
									AnimalData      = capturedAnimal,
									Mutation        = capturedMutation,
									RoadIndex       = capturedRoad,
									VfxAlreadyFired = true,
								})
							end)
							AnimalToSpawn = nil
						end
					end
					if AnimalToSpawn then
						local capturedAnimal   = AnimalToSpawn
						local capturedIndex    = roadIndex
						local capturedMutation = roadMutation
						task.spawn(function()
							CreateAnimal({
								AnimalData = capturedAnimal,
								Mutation   = capturedMutation,
								RoadIndex  = capturedIndex,
							})
						end)
					end
					if roadData.GuaranteedLegendary > 0 then roadData.GuaranteedLegendary -= 1 end
					if roadData.GuaranteedMythic    > 0 then roadData.GuaranteedMythic    -= 1 end
				end
			end
			local extraDelay = GetRemainingSpawnDelay()
			local waitTime   = GameData.RoadSpawn.SpawnEvery + extraDelay
			MainRoadNextSpawnTime = os.clock() + waitTime
			task.wait(waitTime)
		end
	end)
end
function AnimalService.SetSpawnRate(NewRate)
	GameData.RoadSpawn.SpawnEvery = NewRate
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
function AnimalService.ReplaceAnimal(
	existingAnimalModel: Model,
	newAnimalData: any,
	options: {
		Mutation: string?,
		Traits: {string}?,
		IsFake: boolean?,
		Speed: number?,
		PlaySound: boolean?,
		isAnimalFakeInBase: boolean?
	}?
)
	if not existingAnimalModel or not existingAnimalModel.Parent then
		warn("[AnimalService] ReplaceAnimal: existingAnimalModel is invalid or has no parent")
		return
	end
	options = options or {}
	local existingPosition  = existingAnimalModel:GetPivot()
	local existingMutation  = existingAnimalModel:GetAttribute("Mutation")
	local existingTraitsRaw = existingAnimalModel:GetAttribute("Traits")
	local existingIsFake    = existingAnimalModel:GetAttribute("IsFake")
	local existingisAnimalFakeInBase = existingAnimalModel:GetAttribute("IsAnimalFakeInBase")
	local existingSpeed     = existingAnimalModel:GetAttribute("Speed")
	local existingUID       = existingAnimalModel.Name
	local existingActiveInfo = ActiveAnimals[existingUID]
	local wasBought = false
	local purchaser = nil
	if existingActiveInfo then
		local primaryPart = existingAnimalModel.PrimaryPart
		if primaryPart then
			local promptAttachment = primaryPart:FindFirstChild("PromptAttachment")
			if promptAttachment then
				local prompt = promptAttachment:FindFirstChildOfClass("ProximityPrompt")
				if prompt then
					local targetUserId = prompt:GetAttribute("TargetPlayer")
					if targetUserId then
						wasBought = true
						purchaser = Players:GetPlayerByUserId(targetUserId)
					end
				end
			end
		end
	end
	local existingTraits = {}
	if existingTraitsRaw then
		local success, decoded = pcall(HttpService.JSONDecode, HttpService, existingTraitsRaw)
		if success and type(decoded) == "table" then
			existingTraits = decoded
		end
	end
	local finalMutation = if options.Mutation ~= nil then options.Mutation else existingMutation
	local finalTraits   = if options.Traits   ~= nil then options.Traits   else existingTraits
	local finalIsFake   = if options.IsFake   ~= nil then options.IsFake   else existingIsFake
	local finalSpeed    = if options.Speed    ~= nil then options.Speed    else existingSpeed
	local playSound     = if options.PlaySound ~= nil then options.PlaySound else false
	local finalisAnimalFakeInBase = if options.isAnimalFakeInBase ~= nil
		then options.isAnimalFakeInBase
		else existingisAnimalFakeInBase
	existingAnimalModel:Destroy()
	local tempStartPart = Instance.new("Part")
	tempStartPart.Name = "ReplaceAnimalTempStart"
	tempStartPart.Anchored = true
	tempStartPart.CanCollide = false
	tempStartPart.CanQuery = false
	tempStartPart.CanTouch = false
	tempStartPart.Transparency = 1
	tempStartPart.Size = Vector3.new(1, 1, 1)
	tempStartPart.CFrame = existingPosition
	tempStartPart.Parent = workspace
	local endTarget
	if wasBought and purchaser then
		local plot = PlotService.getPlot(purchaser)
		if plot and plot.AnimalTarget then
			endTarget = plot.AnimalTarget
		end
	end
	if not endTarget then
		if AprilFoolsMode then
			endTarget = workspace.Road.Start
		else
			endTarget = workspace.Road.End
		end
	end
	local customSpawn = {
		Start = tempStartPart,
		End = endTarget,
		Owner = if wasBought and purchaser then purchaser else nil,
	}
	local newAnimalId = HttpService:GenerateGUID(false)
	local savedTriggerEvent = TriggerEvent
	TriggerEvent = false
	local newModel = CreateAnimal({
		AnimalData         = newAnimalData,
		Mutation           = finalMutation,
		Traits             = finalTraits,
		Speed              = finalSpeed,
		CustomSpawn        = customSpawn,
		AFKTime            = 0,
		ForceStraightLine  = false,
		PreGeneratedId     = newAnimalId,
		IsFake             = finalIsFake,
		IsAnimalFakeInBase = finalisAnimalFakeInBase,
	})
	TriggerEvent = savedTriggerEvent
	task.delay(1, function()
		if tempStartPart and tempStartPart.Parent then
			tempStartPart:Destroy()
		end
	end)
	local indexName
	if newAnimalData.LuckyBlock
		and not excludedBlocks[newAnimalData.DisplayName]
		and not GameDataServerStorage[newAnimalData.DisplayName]
	then
		indexName = string.format("%s %s", newAnimalData.Rarity, newAnimalData.DisplayName)
	else
		indexName = newAnimalData.DisplayName
	end
	if playSound and newModel and newModel.Parent then
		local Sound = ANIMAL_SOUNDS:FindFirstChild(indexName)
		if Sound then
			for _, Player in game.Players:GetPlayers() do
				SoundService:Play(Player, Sound)
			end
		end
	end
	return newModel
end
function AnimalService.SetGlobalLiveboardFilter(enabled: boolean, jobid: string?)
	if jobid == "" then jobid = nil end
	if jobid ~= nil and not MessagingService:IsKnownJobId(jobid) then
		warn(string.format("[AnimalService] SetGlobalLiveboardFilter: invalid jobid '%s'", jobid))
		return false
	end
	if not jobid or jobid == game.JobId then
		GlobalLiveboardFilterEnabled = enabled
	end
	if not jobid then
		task.spawn(function()
			local ok, err = pcall(function()
				FFlags:Set(TOGGLE_STORE_KEY, enabled, "all")
			end)
			if not ok then
				warn("[AnimalService] Failed to persist liveboard filter via FFlags:", err)
			end
		end)
	else
		task.spawn(function()
			local ok, err = pcall(function()
				MessagingService:PublishAsync(TOGGLE_MS_TOPIC, {
					enabled     = enabled,
					originJobId = game.JobId,
				}, jobid)
			end)
			if not ok then
				warn("[AnimalService] Failed to publish targeted liveboard toggle:", err)
			end
		end)
	end
	return true
end
return AnimalService