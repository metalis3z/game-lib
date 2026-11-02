--!native

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

local GameService = require(ServerScriptService.Services.GameService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local PlotService = require(ServerScriptService.Services.PlotService)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local ChatService = require(ServerScriptService.Services.ChatService)
local SoundService = require(ServerScriptService.Services.SoundService)

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

local GuaranteedLegendary = 600
local GuaranteedMythic = 900

local NEXT_QUEUE = {}

local SpawnDelayTable = {}

local PurchaseRemote = Net:RemoteEvent("156ed911-fc4b-4d24-a648-acd1e9761e4f")
local HoldBeganRemote = Net:RemoteEvent("f756228f-15f8-4b6d-93a4-dfe62bb409cb")

local ActiveAnimals = {}
local PurchaseLocks = {}
local LastPurchaseAttempt = {}

local RAY_PARAMS = RaycastParams.new()
RAY_PARAMS.FilterType = Enum.RaycastFilterType.Include
RAY_PARAMS.FilterDescendantsInstances = {workspace.Map, workspace.Terrain}

local YoIsTsModded = false
local TriggerEvent = true

local EventMutationsList = {
	["BloodmoonEvent"] = {Chance = 20, Mutation = "Bloodrot"},
	["CandyEvent"] = {Chance = 10, Mutation = "Candy"},
	["MoltenEvent"] = {Chance = 15, Mutation = "Lava"},
	["YinYangEvent"] = {Chance = 25, Mutation = "YinYang"},
	["RadioactiveEvent"] = {Chance = 100, Mutation = "Radioactive"},
}

local ForcedRarity = nil
local ForcedRarityEndTime = 0
local GlobalSpeedOverride = nil
local RoadEnd = workspace.Road.End

local function ScheduleNextSpawnDelay(seconds, reason)
	if not seconds or seconds <= 0 then return end
	table.insert(SpawnDelayTable, { untilTime = os.time() + seconds, reason = reason or "SpawnVFX" })
end

local function GetRemainingSpawnDelay()
	local now = os.time()
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
end


local function SpawnAuraBoat()
	local Road = workspace:WaitForChild("Road")
	local StartPart = Road:WaitForChild("Start")
	local EndPart = Road:WaitForChild("End")

	local model = Instance.new("Part")
	model.Name = "AuraBoat"
	model.Anchored = true
	model.CanCollide = false
	model.Position = StartPart.Position
	model.Transparency = 1
	model.Parent = workspace

	model.CFrame = CFrame.new(StartPart.Position, EndPart.Position)

	local distance = (EndPart.Position - StartPart.Position).Magnitude
	local duration = distance / 10
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)

	local direction = (EndPart.Position - StartPart.Position).Unit
	local goal = {CFrame = CFrame.new(EndPart.Position, EndPart.Position + direction)}

	local tween = TweenService:Create(model, tweenInfo, goal)
	tween:Play()

	game.CollectionService:AddTag(model, "IndonesiaCanoe")
end


local function createPurchasableAnimal(AnimalData, Mutation, Traits, Speed, CustomSpawn, AFKTime, ForceStraightLine)
	local MoveTarget = workspace.Road.End
	local RoadEnd = workspace.Road.End
	local RoadStart = workspace.Road.Start
	local IsBought = false
	local PurchasingPlayer
	local ReservedPodiumIndex
	local OriginalSpeed = Speed or GlobalSpeedOverride or GameData.RoadSpawn.AnimalSpeed
	local ForceIdleConnection
	local MovementConnection
	local CurrentPath
	local CurrentWaypoints
	local CurrentWaypointIndex = 1
	local IsMoving = false
	local IsDestroying = false
	local animConn
	local indexName
	local AnimalName = HttpService:GenerateGUID(false)

	if AnimalData.LuckyBlock and AnimalData.DisplayName ~= "Los Lucky Blocks" and AnimalData.DisplayName ~= "Spooky Lucky Block" then
		indexName = string.format("%s %s", AnimalData.Rarity, AnimalData.DisplayName)
	else
		indexName = AnimalData.DisplayName
	end
	
	if EventService:GetActiveEvent("1x1x1x1") == nil then
		if AnimalData.SpawnVFX then
			Net:RemoteEvent("GameService/SpawnEffect"):FireAllClients(AnimalData.SpawnVFX, nil, AnimalData.SpawnDelay)
			if AnimalData.SpawnDelay and AnimalData.SpawnDelay > 0 then
				ScheduleNextSpawnDelay(AnimalData.SpawnDelay, ("SpawnVFX:%s"):format(indexName))
			end
		end
		task.wait(AnimalData.SpawnDelay)
		if TriggerEvent == true then
			if AnimalData.TriggerEvent then
				EventService:ExecuteEvent(AnimalData.TriggerEvent, 300)
			end
		end
	

	end

	
	

	local AnimalModel = Instance.new("Model")
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
	AnimalModel.Parent = workspace

	if CustomSpawn and CustomSpawn.Start then
		AnimalModel:PivotTo(CustomSpawn.Start.CFrame)
	else
		AnimalModel:PivotTo(workspace.Road.Start.CFrame)
	end
	
	if EventService:GetActiveEvent("1x1x1x1") == nil then
		if AnimalData.Rarity == "Brainrot God" or AnimalData.Rarity == "Secret" or AnimalData.Rarity == "OG" or AnimalData.Rarity == "Admin" then
			local Sound = ANIMAL_SOUNDS:FindFirstChild(indexName)
			if Sound then
				for _, Player in game.Players:GetPlayers() do
					SoundService:Play(Player, Sound)

				end
			end
		end
		
		if AnimalData.Rarity == "Secret" and AnimalData.DisplayName ~= "Lucky Block" then
			ChatService:SendMessage("<font color='#000000'>[SERVER] A secret Brainrot has spawned!</font>")
		end

		-- Lucky Block messages
		if AnimalData.DisplayName == "Lucky Block" then
			if      AnimalData.Rarity == "Admin"        then ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Admin Lucky Block</font><font color='#d1d202'> has spawned!</font>")
			elseif  AnimalData.Rarity == "Spooky"       then ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Spooky Lucky Block</font><font color='#d1d202'> has spawned!</font>")
			elseif  AnimalData.Rarity == "Taco"         then ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Taco Lucky Block</font><font color='#d1d202'> has spawned!</font>")
			elseif  AnimalData.Rarity == "Brainrot God" then ChatService:SendMessage("<font color='#22afe2'>[SERVER] A Brainrot God Lucky Block has spawned!</font>")
			elseif  AnimalData.Rarity == "Secret"       then ChatService:SendMessage("<font color='#000000'>[SERVER] A Secret Lucky Block has spawned!</font>")
			end

			-- Los Lucky Blocks message
		elseif AnimalData.DisplayName == "Los Lucky Blocks" and AnimalData.Rarity == "Admin" then
			ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Los Lucky Blocks</font><font color='#d1d202'> has spawned!</font>")
		end

	end




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

	AnimalModel:SetAttribute("Index", indexName)

	local Prompt
	local pendingTargetUserId

	local function spawnPrompt()
		if not AnimalModel or not AnimalModel.Parent then return end
		if Prompt and Prompt.Parent then return end
		Prompt = Instance.new("ProximityPrompt")
		Prompt.ObjectText = string.format("%s $%s", AnimalData.DisplayName, NumberUtils.ToString(nil, AnimalData.Price))
		Prompt.ActionText = "Purchase"
		Prompt.HoldDuration = 0.25
		Prompt.RequiresLineOfSight = true
		Prompt.Parent = PromptAttachment
		Prompt:AddTag("AnimalPurchasePrompt")
		Prompt:SetAttribute("Disabled", false)
		Prompt:SetAttribute("UID", AnimalName)
		if pendingTargetUserId then
			Prompt:SetAttribute("TargetPlayer", pendingTargetUserId)
		end
	end

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
		BackupParams.FilterType = Enum.RaycastFilterType.Include
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
				PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
				AnimalModel:Destroy()
				return
			end

			local Plot = PlotService.getPlot(PurchasingPlayer)
			if not Plot then
				PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
				AnimalModel:Destroy()
				return
			end

			local AnimalPodiums = PlayerChannel:Get("AnimalPodiums") or {}
			local IndexData = PlayerChannel:Get("Index") or {}

			if not ReservedPodiumIndex then
				PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
				warn("[AnimalService] No reserved podium index for player: " .. PurchasingPlayer.Name)
				AnimalModel:Destroy()
				return
			end

			local targetPodium = Plot.AnimalPodiums:FindFirstChild(tostring(ReservedPodiumIndex))
			if not targetPodium then
				PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
				warn("[AnimalService] Podium " .. ReservedPodiumIndex .. " not found for player: " .. PurchasingPlayer.Name)
				AnimalModel:Destroy()
				return
			end

			local PodiumData = AnimalPodiums[ReservedPodiumIndex]
			if PodiumData and PodiumData ~= "Empty" then
				PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
				warn("[AnimalService] Reserved podium " .. ReservedPodiumIndex .. " is not empty for player: " .. PurchasingPlayer.Name)
				AnimalModel:Destroy()
				return
			end

			local FinalIndex = AnimalModel:GetAttribute("Index")
			local FinalMutation = AnimalModel:GetAttribute("Mutation")

			if not FinalIndex or FinalIndex == "" then
				PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
				warn("[AnimalService] Invalid FinalIndex for animal: " .. AnimalModel.Name)
				AnimalModel:Destroy()
				return
			end

			if not AnimalData.LuckyBlock then
				IndexData[FinalIndex] = IndexData[FinalIndex] or {}
				if FinalMutation then
					IndexData[FinalIndex][FinalMutation] = (IndexData[FinalIndex][FinalMutation] or 0) + 1
				else
					IndexData[FinalIndex].Default = (IndexData[FinalIndex].Default or 0) + 1
				end
			end

			local FinalTraits
			local TraitJson = AnimalModel:GetAttribute("Traits")
			if TraitJson then
				local Success, Result = pcall(HttpService.JSONDecode, HttpService, TraitJson)
				if Success then FinalTraits = Result end
			end

			AnimalPodiums[ReservedPodiumIndex] = {
				Index = FinalIndex,
				LastCollect = os.time(),
				Mutation = FinalMutation,
				Traits = FinalTraits,
				Timer = AnimalData.LuckyBlock and 0 or nil
			}

			PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)

			local GenerationAmount = SharedAnimals:GetGeneration(
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
				Costs = { Avoid = math.huge }
			})

			local success, _ = pcall(function()
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

		local rotationSpeed = 10
		local rotationSmoothness = 0.85
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
				if MoveStep > Distance then MoveStep = Distance end

				local NewPosition = AnimalPart.Position + (Direction.Unit * MoveStep)

				if not ForceStraightLine then
					NewPosition = stickToGround(NewPosition)
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

	local function updateForceIdle()
		if IsDestroying then return end

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
		local LockKey = AnimalName .. "_" .. PlayerWhoTriggered.UserId
		local CurrentTime = tick()

		if PurchaseLocks[LockKey] then
			return
		end

		if LastPurchaseAttempt[LockKey] and (CurrentTime - LastPurchaseAttempt[LockKey]) < 0.1 then
			return
		end

		LastPurchaseAttempt[LockKey] = CurrentTime
		PurchaseLocks[LockKey] = true

		if PurchasingPlayer and PurchasingPlayer ~= PlayerWhoTriggered then
			if PurchasingPlayer then
				PlotService.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
			end
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

		PlotService.AddToQueue(PlayerWhoTriggered, ReservedPodiumIndex)

		pendingTargetUserId = PlayerWhoTriggered.UserId
		if Prompt and Prompt.Parent then
			Prompt:SetAttribute("TargetPlayer", pendingTargetUserId)
		end

		PurchasingPlayer = PlayerWhoTriggered
		IsBought = true

		local Plot: any = PlotService.getPlot(PlayerWhoTriggered)
		if not Plot then
			PlotService.RemoveFromQueue(PlayerWhoTriggered, ReservedPodiumIndex)
			MoveTarget = workspace.Road.End
		else
			MoveTarget = Plot.AnimalTarget
		end

		if not IsFree then
			MoneyService:Add(PlayerWhoTriggered, -Price)
			Price = Price + BasePrice * 1.5
		end

		MoveAlongPath(MoveTarget)

		local Sound = ANIMAL_SOUNDS:FindFirstChild(indexName)
		if Sound then
			for _, Player in game.Players:GetPlayers() do
				SoundService:Play(Player, Sound)

			end
		end
		
		task.delay(1, function()
			PurchaseLocks[LockKey] = nil
		end)
	end

	ActiveAnimals[AnimalName].PurchaseFunction = purchaseAnimal

	if CustomSpawn and CustomSpawn.End then
		MoveTarget = CustomSpawn.End
	end

	local isFuseSpawn = CustomSpawn and CustomSpawn.Start == workspace.FuseMachine.VisualSpawnCFrame
	if isFuseSpawn then
		AnimalModel:SetAttribute("ForceIdle", true)
	end

	if CustomSpawn and CustomSpawn.Owner then
		purchaseAnimal(CustomSpawn.Owner, true)
	end

	local PlayerRemovingConn = Players.PlayerRemoving:Connect(function(Player: Player)
		if Player == PurchasingPlayer then
			PlotService.RemoveFromQueue(Player, ReservedPodiumIndex)
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

	if isFuseSpawn then
		if not workspace.FuseMachine:FindFirstChild("VisualSpawnCFrame")
			or not workspace.FuseMachine:FindFirstChild("VisualLevitateCFrame")
			or not workspace.FuseMachine:FindFirstChild("SpawnZone") then
			warn("[AnimalService] Missing required objects: VisualSpawnCFrame, VisualLevitateCFrame, or SpawnZone")
			AnimalModel:Destroy()
			return
		end

		AnimalModel:SetAttribute("Scale", 0.01)

		local levitateDuration = 1.5
		local spawnZoneDuration = 0.75
		local idleDuration = 1.5
		local initialRotSpeed = 10
		local peakRotSpeed = 1800
		local finalRotSpeed = 0

		local tweenInfoLevitate = TweenInfo.new(levitateDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
		local tweenLevitate = TweenService:Create(AnimalPart, tweenInfoLevitate, {CFrame = workspace.FuseMachine.VisualLevitateCFrame.CFrame})

		local startTime = tick()
		animConn = RunService.Heartbeat:Connect(function(dt)
			if IsDestroying then
				if animConn then animConn:Disconnect(); animConn = nil end
				return
			end

			local t = math.clamp((tick() - startTime) / levitateDuration, 0, 1)
			if t >= 1 then
				if animConn then animConn:Disconnect(); animConn = nil end
			else
				local rotSpeed
				if t < 0.5 then
					rotSpeed = initialRotSpeed + (peakRotSpeed - initialRotSpeed) * (t / 0.5)
				else
					rotSpeed = peakRotSpeed + (finalRotSpeed - peakRotSpeed) * ((t - 0.5) / 0.5)
				end
				AnimalPart.CFrame = AnimalPart.CFrame * CFrame.Angles(0, math.rad(rotSpeed * dt), 0)
				local scale = 0.01 + (1 - 0.01) * t
				AnimalModel:SetAttribute("Scale", scale)
			end
		end)

		tweenLevitate:Play()
		tweenLevitate.Completed:Wait()
		if IsDestroying then return end

		local tweenInfoSpawnZone = TweenInfo.new(spawnZoneDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
		local tweenSpawnZone = TweenService:Create(AnimalPart, tweenInfoSpawnZone, {CFrame = workspace.FuseMachine.SpawnZone.CFrame})
		AnimalModel:SetAttribute("Scale", 1)
		tweenSpawnZone:Play()
		tweenSpawnZone.Completed:Wait()
		if IsDestroying then return end

		task.wait(idleDuration)

		spawnPrompt()

		if not IsDestroying then
			AnimalModel:SetAttribute("ForceIdle", false)
			MoveAlongPath(MoveTarget)
		end
	else
		if EventService:GetActiveEvent("1x1x1x1") then
			AnimalModel:SetAttribute("ForceIdle", true)
			local door
			local SideMap = workspace:WaitForChild("1x1x1x1Map")
			if SideMap then
				door = SideMap.Lab.Printer:WaitForChild("Latch")
				if door then
					door:SetAttribute("Open", true)
				
				end
			end

			task.spawn(function()
				local Waypoints = script.Path:GetChildren()
				table.sort(Waypoints, function(a, b) return tonumber(a.Name) < tonumber(b.Name) end)

				if #Waypoints > 0 and AnimalModel and AnimalModel.Parent then
					AnimalModel:PivotTo(CFrame.new(Waypoints[1].Position, RoadEnd.Position))

					for i = 2, #Waypoints do
						if not AnimalModel or not AnimalModel.Parent then break end
						
						if i == 3 then
							door:SetAttribute("Open", false)

						end

						local startPos = AnimalModel:GetPivot().Position
						local endPos = Waypoints[i].Position
						local distance = (endPos - startPos).Magnitude
						local duration = distance / 10
						local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
						local tween = TweenService:Create(AnimalPart, tweenInfo, {CFrame = CFrame.new(endPos, RoadEnd.Position)})
						tween:Play()
						tween.Completed:Wait()
					end

					if AnimalData.SpawnVFX then
						Net:RemoteEvent("GameService/SpawnEffect"):FireAllClients(AnimalData.SpawnVFX, nil, AnimalData.SpawnDelay)
						if AnimalData.SpawnDelay and AnimalData.SpawnDelay > 0 then
							ScheduleNextSpawnDelay(AnimalData.SpawnDelay, ("SpawnVFX:%s"):format(indexName))
						end
					end

					task.wait(AnimalData.SpawnDelay)
					if TriggerEvent == true then
						if AnimalData.TriggerEvent then
							EventService:ExecuteEvent(AnimalData.TriggerEvent, 300)
						end
					end


					if AnimalData.Rarity == "Brainrot God" or AnimalData.Rarity == "Secret" or AnimalData.Rarity == "OG" or AnimalData.Rarity == "Admin" then
						local Sound = ANIMAL_SOUNDS:FindFirstChild(indexName)
						if Sound then
							for _, Player in game.Players:GetPlayers() do
								SoundService:Play(Player, Sound)

							end
						end
					end
					if AnimalData.Rarity == "Secret" and AnimalData.DisplayName ~= "Lucky Block" then
						ChatService:SendMessage("<font color='#000000'>[SERVER] A secret Brainrot has spawned!</font>")
					end

					if AnimalData.Rarity == "Admin" then
						if AnimalData.DisplayName == "Los Lucky Blocks" then
							ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Los Lucky Blocks</font><font color='#d1d202'> has spawned!</font>")
						end
					end

					if AnimalData.DisplayName == "Lucky Block" then
						if      AnimalData.Rarity == "Admin"        then ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Admin Lucky Block</font><font color='#d1d202'> has spawned!</font>")
						elseif  AnimalData.Rarity == "Spooky"       then ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Spooky Lucky Block</font><font color='#d1d202'> has spawned!</font>")
						elseif  AnimalData.Rarity == "Taco"         then ChatService:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Taco Lucky Block</font><font color='#d1d202'> has spawned!</font>")
						elseif  AnimalData.Rarity == "Brainrot God" then ChatService:SendMessage("<font color='#22afe2'>[SERVER] A Brainrot God Lucky Block has spawned!</font>")
						elseif  AnimalData.Rarity == "Secret"       then ChatService:SendMessage("<font color='#000000'>[SERVER] A Secret Lucky Block has spawned!</font>")
						end

					end
				end

				if AnimalModel and AnimalModel.Parent then
					spawnPrompt()
					AnimalModel:SetAttribute("ForceIdle", false)
					MoveAlongPath(MoveTarget)
				end
			end)
		else
			--SpawnAuraBoat()
			spawnPrompt()
			if AFKTime and AFKTime > 0 then
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
	end


	AnimalModel:AddTag("Animal")
end

function AnimalService:SpawnNoDelay(AnimalData, Mutation, Traits, Speed, CustomSpawn, AFKTime, ForceStraightLine)
	createPurchasableAnimal(AnimalData, Mutation, Traits, Speed, CustomSpawn, AFKTime, ForceStraightLine)
end

function AnimalService.spawnAnimalInBase(Player: Player, Animal: string, Mutation: string?, Traits: any?)
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
			Index[Animal][Mutation] = (Index[Animal][Mutation] or 0) + 1
		else
			Index[Animal].Default = (Index[Animal].Default or 0) + 1
		end
	end

	AnimalPodiums[tonumber(Podiums.Name)] = {
		Index = Animal,
		LastCollect = os.time(),
		Mutation = Mutation,
		Traits = Traits,
		Timer = LuckyBlocks[Animal] and 0 or nil
	}

	PlayerChannel:Set("Index", Index)
	PlayerChannel:Set("AnimalPodiums", AnimalPodiums)
	PlayerChannel:Set("AnimalAddedOrRemoved", true)
end

function AnimalService.spawnAnimalCustom(Animal: any, Mutation: string?, Traits: {string}?, Speed: number?, CustomSpawn: {Start: BasePart?, End: BasePart?, Owner: Player?}?, StandFor: number?)
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
	table.insert(NEXT_QUEUE, { Animal = Animal })
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
			table.insert(Candidates, { Name = Name, Data = Data })
		end
	end

	if #Candidates == 0 then
		return nil
	end

	local ServerLuck = Synchronizer:Get("ServerLuck")
	local LuckMultiplier = ServerLuck:Get("Index")
	if LuckMultiplier == nil then
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
	local Paused = false

	function AnimalService:PauseSpawning()  Paused = true  end
	function AnimalService:UnpauseSpawning() Paused = false end

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

	-- task.spawn(function()
	-- 	while true do
	-- 		if GuaranteedLegendary > 9999 then GuaranteedLegendary -= 1 end
	-- 		if GuaranteedMythic > 9999 then GuaranteedMythic -= 1 end
	-- 		MainFrame.Legendary.Text = string.format('Guaranteed <font color="#161e21">Serect</font> in %*', TimeUtils:B(GuaranteedLegendary))
	-- 		MainFrame.Mythic.Text    = string.format('Guaranteed <font color="#403f10">OG</font>  in %*', TimeUtils:B(GuaranteedMythic))
	-- 		task.wait(1)
	-- 	end
	-- end)


	-- task.spawn(function()
	-- 	while true do
	-- 		if GuaranteedLegendary > 9999 then GuaranteedLegendary -= 1 end
	-- 		if GuaranteedMythic > 9999 then GuaranteedMythic -= 1 end
	-- 		MainFrame.Legendary.Text = string.format('Guaranteed <font color="#161e21">Serect</font> in %*', TimeUtils:B(GuaranteedLegendary))
	-- 		MainFrame.Mythic.Text    = string.format('Guaranteed <font color="#403f10">OG</font>  in %*', TimeUtils:B(GuaranteedMythic))
	-- 		task.wait(1)
	-- 	end
	-- end)


	task.wait(2)

	while true do
		if not Paused then
			local remaining = GetRemainingSpawnDelay()
			if remaining > 0 then
				task.wait(remaining)
			end

			local RandomAnimal
			local FinalMutation: string?
			local FinalTraits: {string} = {}
			local ForceStraightLine = false
			local Skip = false

			for i, Data in pairs(NEXT_QUEUE) do
				table.remove(NEXT_QUEUE, i)
				Skip = true
				createPurchasableAnimal(Data.Animal, Data.Mutation, Data.Traits, Data.Speed, Data.CustomSpawn, Data.AFKTime)
				break
			end

			if not Skip then
				if YoIsTsModded then
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
						createPurchasableAnimal(RandomAnimal, FinalMutation, FinalTraits, nil, nil, nil, ForceStraightLine)
					end
				else
					if ForcedRarity and os.time() < ForcedRarityEndTime then
						repeat
							RandomAnimal = AnimalService.randomAnimal(ForcedRarity)
						until not RandomAnimal or not table.find(GameDataServerStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
						-- elseif GuaranteedLegendary == 0 then
						-- 	repeat
						-- 		RandomAnimal = AnimalService.randomAnimal("Secret")
						-- 	until not RandomAnimal or not table.find(GameDataServerStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
						-- 	GuaranteedLegendary = 12

					elseif GuaranteedMythic == 0 then
						repeat
							RandomAnimal = AnimalService.randomAnimal("OG")
						until not RandomAnimal or not table.find(GameDataServerStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
						GuaranteedMythic = 9
					else
						repeat
							RandomAnimal = AnimalService.randomAnimal()
						until not RandomAnimal or not table.find(GameDataServerStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
					end

					if RandomAnimal then
						createPurchasableAnimal(RandomAnimal, nil, {}, nil, nil, nil, false)
					end
				end
			end
		end

		task.wait(GameData.RoadSpawn.SpawnEvery)
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
