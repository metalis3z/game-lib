local Event3Roads = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local PathfindingService = game:GetService("PathfindingService")

local MapObjects = {
	Shop = workspace:WaitForChild("Shop"),
	Codes = workspace:WaitForChild("Map"):WaitForChild("Codes"),
	DivineSpin = workspace:WaitForChild("DivineSpinWheels"):WaitForChild("1"),
	RobuxShop = workspace:WaitForChild("RobuxShop"),
	Model1 = workspace:WaitForChild("Map"):WaitForChild("Model1"),
	StealsBoard = workspace:WaitForChild("Map"):WaitForChild("StealsBoard"),
	GenerationBoard = workspace:WaitForChild("Map"):WaitForChild("GenerationBoard"),
	TradeMachine = workspace:WaitForChild("TradeMachine"),
	FuseMachine = workspace:WaitForChild("FuseMachine"),
	TsunamiLTMMachine = workspace:WaitForChild("TsunamiLTMMachine"),
	StPatricksPot = workspace:WaitForChild("StPatricksPot"),
	Block = workspace.Events["Leprechaun Lucky Block"]:WaitForChild("Model")
}

local OriginalCFrames = {}
for name, model in pairs(MapObjects) do
	OriginalCFrames[name] = model:GetPivot()
end

local TargetCFrames = {
	Shop = CFrame.new(-358.752, -5, 40.253) * CFrame.Angles(0, math.rad(-180), 0),
	Codes = CFrame.new(-355.752, 4.25, -138.594),
	DivineSpin = CFrame.new(-459.611, -5.729, 62.007) * CFrame.Angles(0, math.rad(-90), 0),
	RobuxShop = CFrame.new(-462.752, -5, 40.253) * CFrame.Angles(math.rad(0), 0, 0),
	Model1 = CFrame.new(0, 100000, 0) * CFrame.Angles(math.rad(0), 0, 0),
	StealsBoard = CFrame.new(-363.752, 4.75, 258.906) * CFrame.Angles(0, math.rad(180), 0),
	GenerationBoard = CFrame.new(-457.752, 4.75, 258.906) * CFrame.Angles(0, math.rad(180), 0),
	TradeMachine = CFrame.new(-461.862, -3.5, 86.739) * CFrame.fromOrientation(math.rad(90), math.rad(-180), math.rad(0)),
	FuseMachine = CFrame.new(-361.752, -9, 72.653) * CFrame.Angles(0, math.rad(180), 0),
	TsunamiLTMMachine = CFrame.new(-360.252, -9.5, 95.253) * CFrame.Angles(math.rad(0), 0, 0),
	StPatricksPot = CFrame.new(-461.252, -5.211, 19.608) * CFrame.Angles(0, math.rad(90), 0),
	Block = CFrame.new(-357.096, -9.5, 19.023) * CFrame.Angles(0, math.rad(0), 0)
}

local function MoveMapObjects(toTarget)
	for name, model in pairs(MapObjects) do
		model:PivotTo(toTarget and TargetCFrames[name] or OriginalCFrames[name])
	end
end

local Animals = require(ReplicatedStorage.Datas.Animals)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local GameData = require(ReplicatedStorage.Datas.Game)
local GameDataServerStorage = require(ServerStorage.Modules.GameData)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)

local PlotService = require(ServerScriptService.Services.PlotService)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local NotificationService = require(ServerScriptService.Services.NotificationService)

local ANIMAL_SOUNDS = ReplicatedStorage.Sounds.Animals

local isActive = false
local currentMapInstance = nil
local spawnLoopConnections = {}
local activeAnimals = {}

local PurchaseLocks = {}
local LastPurchaseAttempt = {}

local MAP_STORAGE = script:FindFirstChild("3 Roads")

local EventMutationsList = {
	["BloodmoonEvent"] = {Chance = 20, Mutation = "Bloodrot"},
	["CandyEvent"] = {Chance = 10, Mutation = "Candy"},
	["MoltenEvent"] = {Chance = 15, Mutation = "Lava"},
	["YinYangEvent"] = {Chance = 25, Mutation = "YinYang"},
}

local RoadData = {
	[2] = {
		GuaranteedLegendary = 300, 
		GuaranteedMythic = 900, 
		PendingSpawnDelayAnimal = nil, 
		SpawnDelayEndTime = 0,
		LastSpawnTime = 0
	},
	[3] = {
		GuaranteedLegendary = 300, 
		GuaranteedMythic = 900, 
		PendingSpawnDelayAnimal = nil, 
		SpawnDelayEndTime = 0,
		LastSpawnTime = 0
	}
}

local RAY_PARAMS = RaycastParams.new()
RAY_PARAMS.FilterType = Enum.RaycastFilterType.Include
RAY_PARAMS.FilterDescendantsInstances = {workspace.Map, workspace.Terrain}

local function getRoadParts(roadIndex)
	local mainRoad = workspace:FindFirstChild("Road")
	if not mainRoad then return nil, nil end

	local road = mainRoad:FindFirstChild(tostring(roadIndex))
	if not road then return nil, nil end

	local roadStart = road:FindFirstChild("Start")
	local roadEnd = road:FindFirstChild("End")

	if not roadStart or not roadEnd then return nil, nil end
	return roadStart, roadEnd
end

local function randomAnimal(Rarity)
	local candidates = {}
	local totalWeight = 0

	for name, data in pairs(Animals) do
		if (not Rarity or data.Rarity == Rarity) and data.RoadWeight then
			table.insert(candidates, data)
			totalWeight += data.RoadWeight
		end
	end

	if #candidates == 0 then
		return nil
	end

	local roll = math.random() * totalWeight
	local accum = 0

	for _, data in ipairs(candidates) do
		accum += data.RoadWeight
		if roll <= accum then
			return data
		end
	end

	return candidates[#candidates]
end

local function stickToGround(Position: Vector3, AnimalModel: Model): Vector3
	local Origin = Position + Vector3.new(0, 5, 0)
	local Direction = Vector3.new(0, -20, 0)

	local Result = workspace:Raycast(Origin, Direction, RAY_PARAMS)

	if Result then
		return Result.Position
	end

	local BackupParams = RaycastParams.new()
	BackupParams.FilterType = Enum.RaycastFilterType.Blacklist
	BackupParams.FilterDescendantsInstances = {AnimalModel}

	local BackupResult = workspace:Raycast(Origin, Direction, BackupParams)
	if BackupResult then
		return BackupResult.Position
	end

	return Position
end

local function createPurchasableAnimal(roadIndex, AnimalData, roadStart, roadEnd)
	local MoveTarget = roadEnd
	local IsBought = false
	local PurchasingPlayer = nil
	local ReservedPodiumIndex = nil
	local IsDestroying = false
	local IsMoving = false
	local MovementConnection = nil
	local OriginalSpeed = GameData.RoadSpawn.AnimalSpeed or 15
	local CurrentSpeed = OriginalSpeed

	local rotationSpeed = 999
	local rotationSmoothness = 0.95
	local DESTINATION_THRESHOLD = 2.5

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
	PromptAttachment.Position = Vector3.new(0, 1.714, 0)
	PromptAttachment.Parent = AnimalPart

	AnimalModel.PrimaryPart = AnimalPart

	local FinalMutation = nil
	local ForceStraightLine = false

	if roadIndex == 3 then
		ForceStraightLine = true
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

	if not FinalMutation then
		if math.random(1, 10) == 1 then
			local TotalWeight = 0
			local WeightedMutations = {}

			for Name, Data in pairs(Mutations) do
				if Data.Weight and Data.Weight > 0 then
					TotalWeight += Data.Weight
					table.insert(WeightedMutations, {Name = Name, Weight = Data.Weight})
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

	if FinalMutation then
		AnimalModel:SetAttribute("Mutation", FinalMutation)
	end

	AnimalModel:SetAttribute("Index", AnimalData.DisplayName)
	AnimalModel:SetAttribute("EventAnimal", true)
	AnimalModel:SetAttribute("EventRoad", roadIndex)
	AnimalModel:AddTag("Animal")
	AnimalModel:AddTag("EventAnimal")

	AnimalModel.Parent = workspace:FindFirstChild("MovingAnimals") or workspace

	local InitialGroundPos = stickToGround(roadStart.Position, AnimalModel)
	AnimalModel:PivotTo(CFrame.new(InitialGroundPos))

	local Prompt = Instance.new("ProximityPrompt")
	Prompt.ObjectText = string.format("%s $%s", AnimalData.DisplayName, NumberUtils.ToString(nil, AnimalData.Price))
	Prompt.ActionText = "Purchase"
	Prompt.HoldDuration = 0.25
	Prompt.RequiresLineOfSight = true
	Prompt.Enabled = true
	Prompt.Parent = PromptAttachment
	Prompt:AddTag("AnimalPurchasePrompt")
	Prompt:SetAttribute("Disabled", false)
	Prompt:SetAttribute("UID", AnimalName)

	local CurrentPath = nil
	local CurrentWaypoints = nil
	local CurrentWaypointIndex = 1

	local function MoveAlongPath(Target: BasePart)
		if IsDestroying then return end

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
				CurrentWaypoints = nil
				CurrentWaypointIndex = 1
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

			if not isActive then
				if MovementConnection then
					MovementConnection:Disconnect()
					MovementConnection = nil
				end
				return
			end

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

					IsDestroying = true

					if IsBought and PurchasingPlayer then
						task.spawn(function()
							local PlayerChannel = Synchronizer:Get(PurchasingPlayer)
							if not PlayerChannel then
								PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
								AnimalModel:Destroy()
								return
							end

							local AnimalPodiums = PlayerChannel:Get("AnimalPodiums") or {}
							local IndexData = PlayerChannel:Get("Index") or {}
							local FinalIndex = AnimalModel:GetAttribute("Index")
							local FinalMutation = AnimalModel:GetAttribute("Mutation")

							IndexData[FinalIndex] = IndexData[FinalIndex] or {}
							if FinalMutation then
								IndexData[FinalIndex][FinalMutation] = (IndexData[FinalIndex][FinalMutation] or 0) + 1
							else
								IndexData[FinalIndex].Default = (IndexData[FinalIndex].Default or 0) + 1
							end

							AnimalPodiums[ReservedPodiumIndex] = {
								Index = FinalIndex,
								LastCollect = os.time(),
								Mutation = FinalMutation,
								Traits = nil,
								Timer = nil
							}

							PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)

							local GenerationAmount = SharedAnimals:GetGeneration(FinalIndex, FinalMutation, nil, PurchasingPlayer)

							PlayerChannel:Increase("Generation", GenerationAmount)
							PlayerChannel:Set("Index", IndexData)
							PlayerChannel:Set("AnimalPodiums", AnimalPodiums)
							PlayerChannel:Set("AnimalAddedOrRemoved", true)

							AnimalModel:Destroy()
						end)
					else
						AnimalModel:Destroy()
					end
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
					NewPosition = stickToGround(NewPosition, AnimalModel)
				end

				local LookDirection = Direction.Unit
				local TargetCFrame = CFrame.new(NewPosition, NewPosition + LookDirection)

				local CurrentCFrame = AnimalPart.CFrame
				local Alpha = math.min(rotationSmoothness * rotationSpeed * DeltaTime, 1)
				local SmoothedCFrame = CurrentCFrame:Lerp(TargetCFrame, Alpha)

				AnimalModel:PivotTo(CFrame.new(NewPosition) * (SmoothedCFrame - SmoothedCFrame.Position))
			end
		end)
	end

	local function purchaseAnimal(PlayerWhoTriggered)
		if IsBought or IsDestroying then return end

		local LockKey = AnimalName .. "_" .. PlayerWhoTriggered.UserId
		local CurrentTime = tick()

		if PurchaseLocks[LockKey] then return end
		if LastPurchaseAttempt[LockKey] and (CurrentTime - LastPurchaseAttempt[LockKey]) < 0.1 then return end

		LastPurchaseAttempt[LockKey] = CurrentTime
		PurchaseLocks[LockKey] = true

		local PlayerChannel = Synchronizer:Get(PlayerWhoTriggered)
		if not PlayerChannel then
			PurchaseLocks[LockKey] = nil
			return
		end

		local Price = AnimalData.Price
		local CanAfford, Amount = MoneyService:CanAfford(PlayerWhoTriggered, Price)
		if not CanAfford then
			NotificationService.Error(PlayerWhoTriggered, string.format("You need $%s more to buy this", NumberUtils.ToString(nil, Amount)))
			PurchaseLocks[LockKey] = nil
			return
		end

		local Podiums = PlotService.getFreePodium(PlayerWhoTriggered)
		if not Podiums then
			NotificationService.Error(PlayerWhoTriggered, "You need more room in your base to buy a brainrot.")
			PurchaseLocks[LockKey] = nil
			return
		end

		ReservedPodiumIndex = tonumber(Podiums.Name)
		if not ReservedPodiumIndex then
			NotificationService.Error(PlayerWhoTriggered, "Invalid podium index.")
			PurchaseLocks[LockKey] = nil
			return
		end

		IsBought = true
		PlotService.AddToQueue(PlayerWhoTriggered, ReservedPodiumIndex)
		Prompt:SetAttribute("TargetPlayer", PlayerWhoTriggered.UserId)
		Prompt.Enabled = false
		PurchasingPlayer = PlayerWhoTriggered

		MoneyService:Add(PlayerWhoTriggered, -Price)

		local Sound = ANIMAL_SOUNDS:FindFirstChild(AnimalData.DisplayName)
		if Sound then
			local MainSound = Sound:Clone()
			MainSound.PlayOnRemove = true
			MainSound.Parent = AnimalPart
			MainSound:Destroy()
		end

		local Plot = PlotService.getPlot(PlayerWhoTriggered)
		if Plot and Plot.AnimalTarget then
			MoveTarget = Plot.AnimalTarget
		end

		MoveAlongPath(MoveTarget)

		task.delay(1, function()
			PurchaseLocks[LockKey] = nil
		end)
	end

	Prompt.Triggered:Connect(function(player)
		purchaseAnimal(player)
	end)

	local PlayerRemovingConn = Players.PlayerRemoving:Connect(function(Player)
		if Player == PurchasingPlayer then
			PlotService.RemoveFromQueue(Player, ReservedPodiumIndex)
			MoveTarget = roadEnd
			IsBought = false
			ReservedPodiumIndex = nil 

			if not IsDestroying then
				MoveAlongPath(MoveTarget)
			end
		end
	end)

	AnimalModel.Destroying:Connect(function()
		IsDestroying = true
		if MovementConnection then MovementConnection:Disconnect() end
		if PlayerRemovingConn then PlayerRemovingConn:Disconnect() end

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

	local InitialGroundPos = stickToGround(AnimalPart.Position, AnimalModel)
	AnimalPart.CFrame = CFrame.new(InitialGroundPos)

	MoveAlongPath(MoveTarget)

	table.insert(activeAnimals, {
		Model = AnimalModel,
		Connection = MovementConnection,
		RoadIndex = roadIndex
	})

	return AnimalModel
end

local function spawnAnimalOnRoad(roadIndex, AnimalData)
	if not isActive then return end
	if not AnimalData then return end

	local roadStart, roadEnd = getRoadParts(roadIndex)
	if not roadStart or not roadEnd then return end

	createPurchasableAnimal(roadIndex, AnimalData, roadStart, roadEnd)
end

local function startSpawningForRoad(roadIndex)
	local testStart, testEnd = getRoadParts(roadIndex)
	if not testStart or not testEnd then
		return
	end

	local roadData = RoadData[roadIndex]
	local SpawnInterval = GameData.RoadSpawn.SpawnEvery or 5

	local mainLoop = task.spawn(function()
		task.wait(SpawnInterval)

		while isActive do
			local AnimalToSpawn = nil

			if roadData.PendingSpawnDelayAnimal and os.time() >= roadData.SpawnDelayEndTime then
				AnimalToSpawn = roadData.PendingSpawnDelayAnimal
				roadData.PendingSpawnDelayAnimal = nil
				roadData.SpawnDelayEndTime = 0
			end

			if not AnimalToSpawn and os.time() >= roadData.SpawnDelayEndTime then
				local RarityToSpawn = nil

				if roadData.GuaranteedMythic <= 0 then
					RarityToSpawn = "Mythic"
				elseif roadData.GuaranteedLegendary <= 0 then
					RarityToSpawn = "Legendary"
				end

				repeat
					AnimalToSpawn = randomAnimal(RarityToSpawn)
				until not AnimalToSpawn or not table.find(GameDataServerStorage.UnSpawnableBrainrots or {}, AnimalToSpawn.DisplayName)

				if AnimalToSpawn then
					if AnimalToSpawn.Rarity == "Legendary" and RarityToSpawn == "Legendary" then
						roadData.GuaranteedLegendary = 300
					end
					if AnimalToSpawn.Rarity == "Mythic" and RarityToSpawn == "Mythic" then
						roadData.GuaranteedMythic = 900
						roadData.GuaranteedLegendary = 300
					end

					if AnimalToSpawn.SpawnDelay and AnimalToSpawn.SpawnDelay > 0 then
						roadData.PendingSpawnDelayAnimal = AnimalToSpawn
						roadData.SpawnDelayEndTime = os.time() + AnimalToSpawn.SpawnDelay
						AnimalToSpawn = nil
					end
				end
			end

			if AnimalToSpawn then
				spawnAnimalOnRoad(roadIndex, AnimalToSpawn)
			end

			task.wait(SpawnInterval)
		end
	end)
	table.insert(spawnLoopConnections, mainLoop)

	local countdownLoop = task.spawn(function()
		while isActive do
			if roadData.GuaranteedLegendary > 0 then
				roadData.GuaranteedLegendary -= 1
			end
			if roadData.GuaranteedMythic > 0 then
				roadData.GuaranteedMythic -= 1
			end
			task.wait(1)
		end
	end)
	table.insert(spawnLoopConnections, countdownLoop)
end

function Event3Roads.OnStart()
	if isActive then return end


	isActive = true
	ReplicatedStorage:SetAttribute("3RoadsEvent", true)
	MoveMapObjects(true)

	if MAP_STORAGE then
		currentMapInstance = MAP_STORAGE:Clone()
		currentMapInstance.Parent = workspace.Map
		CollectionService:AddTag(currentMapInstance, "3 Roads")
	end

	for roadIndex, data in pairs(RoadData) do
		data.GuaranteedLegendary = 300
		data.GuaranteedMythic = 900
		data.PendingSpawnDelayAnimal = nil
		data.SpawnDelayEndTime = 0
		data.LastSpawnTime = 0
	end

	local validRoads = 0
	for roadIndex = 2, 3 do
		local testStart, testEnd = getRoadParts(roadIndex)
		if testStart and testEnd then
			validRoads = validRoads + 1
			startSpawningForRoad(roadIndex)
		end
	end

	if validRoads == 0 then
		Event3Roads.OnStop()
		return
	end

	local SpawnInterval = GameData.RoadSpawn.SpawnEvery or 5
	local AnimalSpeed = GameData.RoadSpawn.AnimalSpeed or 15
end

function Event3Roads.OnStop()
	if not isActive then return end

	isActive = false
	ReplicatedStorage:SetAttribute("3RoadsEvent", false)
	MoveMapObjects(false)

	for _, connection in ipairs(spawnLoopConnections) do
		if type(connection) == "thread" then
			task.cancel(connection)
		elseif type(connection) == "userdata" and connection.ClassName == "RBXScriptConnection" then
			connection:Disconnect()
		end
	end
	spawnLoopConnections = {}

	for _, info in pairs(activeAnimals) do
		if info.Connection then info.Connection:Disconnect() end
		if info.Model and info.Model.Parent then info.Model:Destroy() end
	end
	activeAnimals = {}

	if currentMapInstance and currentMapInstance.Parent then
		currentMapInstance:Destroy()
	end
	currentMapInstance = nil
end

return Event3Roads