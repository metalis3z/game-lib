--!native
-- hi to Kiwi's brother :3
local AnimalService = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerscriptService = game:GetService("ServerScriptService")
local Serverstorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local PathFindingService = game:GetService("PathfindingService")

local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local NumbUtils = require(ReplicatedStorage.Utils.NumberUtils)
local EventService = require(ServerscriptService.Services.EventService)
local Net = require(ReplicatedStorage.Packages.Net)
local Moneyservice = require(ServerscriptService.Services.MoneyService)
local Soundservice = require(ServerscriptService.Services.SoundService)
local Chatservice = require(ServerscriptService.Services.ChatService)
local Sync = require(ReplicatedStorage.Packages.Synchronizer)
local Plotservice = require(ServerscriptService.Services.PlotService)
local Gameservice = require(ServerscriptService.Services.GameService)
local NotifService = require(ServerscriptService.Services.NotificationService)
local AnimSounds = ReplicatedStorage.Sounds.Animals
local ElfService = require(ServerscriptService.Services.ElfService)

local LuckyBlocks = require(ReplicatedStorage.Datas.LuckyBlocks)
local gameData = require(ReplicatedStorage.Datas.Game)
local Animals = require(ReplicatedStorage.Datas.Animals)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local Animals2 = require(ReplicatedStorage.Shared.Animals)
local GameDataStorage = require(Serverstorage.Modules.GameData)
local MainFrame = workspace.RoadPanel.SurfaceGui.MainFrame

local GuaranteedLegendary = 600
local GuaranteedMythic = 900

local NEXT_QUEUE = {}

local SpawnDelayTable = {}

local PurchaseRemote = Net:RemoteEvent("156ed911-fc4b-4d24-a648-acd1e9761e4f")
local HoldBeganRemote = Net:RemoteEvent("f756228f-15f8-4b6d-93a4-dfe62bb409cb")
local CollectElfEffectRemote = Net:RemoteEvent("SantaMerchantService/CollectGoldElf")

local ActiveAnimals = {}
local PurchaseLocks = {}
local LastPurchaseAttempt = {}

local RayCastParams = RaycastParams.new()
RayCastParams.FilterType = Enum.RaycastFilterType.Exclude
RayCastParams.FilterDescendantsInstances = {}

local YoIsTsModded = false
local TriggerEvent = true


local EventMutationsList = {
	["BloodmoonEvent"] = {Chance = 20, Mutation = "Bloodrot"},
	["CandyEvent"] = {Chance = 10, Mutation = "Candy"},
	["MoltenEvent"] = {Chance = 15, Mutation = "Lava"},
	["YinYangEvent"] = {Chance = 25, Mutation = "YinYang"},
	["RadioactiveEvent"] = {Chance = 25, Mutation = "Radioactive"},
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

local function createPurchasableAnimal(AnimalData, Mutation, Traits, Speed, CustomSpawn, AFKTime, ForceStraightLine, PreGeneratedId)
	local MoveTarget = workspace.Road.End
	local RoadEnd = workspace.Road.End
	local RoadStart = workspace.Road.Start
	local IsBought = false
	local PurchasingPlayer
	local ReservedPodiumIndex
	local ConfigSpeed = 10
	if GameDataStorage and GameDataStorage.RoadSpawn and GameDataStorage.RoadSpawn.AnimalSpeed then
		ConfigSpeed = GameDataStorage.RoadSpawn.AnimalSpeed
	end
	local OriginalSpeed = Speed or GlobalSpeedOverride or ConfigSpeed
	local ForceIdleConnection
	local MovementConnection
	local CurrentPath
	local CurrentWaypoints
	local CurrentWaypointIndex = 1
	local IsMoving = false
	local IsDestroying = false
	local animConn
	local indexName
	local AnimalName = PreGeneratedId or HttpService:GenerateGUID(false)


	if CustomSpawn and CustomSpawn.Owner then
		task.spawn(function()
			pcall(function()
				Net:RemoteEvent("AnimalSpawnService/SpawnRequest"):FireClient(CustomSpawn.Owner, AnimalName)
			end)
		end)
	end


	if AnimalData.LuckyBlock and AnimalData.DisplayName ~= "Los Lucky Blocks" and AnimalData.DisplayName ~= "Spooky Lucky Block" then
		indexName = string.format("%s %s", AnimalData.Rarity, AnimalData.DisplayName)
	else
		indexName = AnimalData.DisplayName
	end

	if EventService:GetActiveEvent("1x1x1x1") then
		if indexName == "1x1x1x1" then
			Net:RemoteEvent("GameService/SpawnEffect"):FireAllClients("Cave_1x1x1x1", nil, 4.5)		
			ScheduleNextSpawnDelay(4.5, ("SpawnVFX:%s"):format(indexName))
			task.wait(4)


		end
		if indexName == "Guest 666" then
			Net:RemoteEvent("GameService/SpawnEffect"):FireAllClients("Cave_Guest 666", nil, 4.5)		
			ScheduleNextSpawnDelay(4.5, ("SpawnVFX:%s"):format(indexName))
			task.wait(4)


		end

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

	local StartPos = CustomSpawn and CustomSpawn.Start and CustomSpawn.Start.Position or workspace.Road.Start.Position
	local LookAtPos = workspace.Road.End.Position
	local LookAtFlat = Vector3.new(LookAtPos.X, StartPos.Y, LookAtPos.Z)
	AnimalModel:PivotTo(CFrame.lookAt(StartPos, LookAtFlat))

	if EventService:GetActiveEvent("1x1x1x1") == nil then
		if AnimalData.Rarity == "Brainrot God" or AnimalData.Rarity == "Secret" or AnimalData.Rarity == "OG" or AnimalData.Rarity == "Admin" then
			local Sound = AnimSounds:FindFirstChild(indexName)
			if Sound then
				for _, Player in game.Players:GetPlayers() do
					Soundservice:Play(Player, Sound)

				end
			end
		end

		if AnimalData.Rarity == "Secret" and AnimalData.DisplayName ~= "Lucky Block" then
			Chatservice:SendMessage("<font color='#000000'>[SERVER] A secret Brainrot has spawned!</font>")
		end
		if AnimalData.Rarity == "OG" and AnimalData.DisplayName ~= "Lucky Block" then
			Chatservice:SendMessage("<font color='#FFFF00'>[SERVER] A OG Brainrot has spawned!</font>")
		end

		if AnimalData.DisplayName == "Lucky Block" then
			if AnimalData.Rarity == "Admin"then Chatservice:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Admin Lucky Block</font><font color='#d1d202'> has spawned!</font>")
			elseif AnimalData.Rarity == "Spooky"then Chatservice:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Spooky Lucky Block</font><font color='#d1d202'> has spawned!</font>")
			elseif AnimalData.Rarity == "Taco"then Chatservice:SendMessage("<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Taco Lucky Block</font><font color='#d1d202'> has spawned!</font>")
			elseif AnimalData.Rarity == "Brainrot God" then Chatservice:SendMessage("<font color='#22afe2'>[SERVER] A Brainrot God Lucky Block has spawned!</font>")
			elseif AnimalData.Rarity == "Secret"then Chatservice:SendMessage("<font color='#000000'>[SERVER] A Secret Lucky Block has spawned!</font>")
			end
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
	if AnimalData.DisplayName == "Gold Elf" then
		AnimalModel:SetAttribute("NoOverhead", true)
	end

	local Prompt
	local pendingTargetUserId

	local function spawnPrompt()
		if not AnimalModel or not AnimalModel.Parent then return end
		if Prompt and Prompt.Parent then return end

		Prompt = Instance.new("ProximityPrompt")
		if AnimalData.DisplayName == "Gold Elf" then
			Prompt.ObjectText = AnimalData.DisplayName
			Prompt.ActionText = "Collect"
		else
			Prompt.ObjectText = string.format("%s $%s", AnimalData.DisplayName, NumbUtils.ToString(nil, AnimalData.Price))
			Prompt.ActionText = "Purchase"
		end

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
	spawnPrompt()

	ActiveAnimals[AnimalName] = {
		Model = AnimalModel,
		Data = AnimalData,
		PurchaseFunction = nil
	}

	local function stickToGround(Position: Vector3): Vector3
		local a = {}

		for i,v in pairs(game.Players:GetPlayers()) do
			table.insert(a, v.Character)
		end

		table.insert(a, AnimalModel)

		local Origin = Position + Vector3.new(0, 10, 0)
		local Direction = Vector3.new(0, -500, 0)

		local StartGround = workspace.Road:FindFirstChild("StartGround")
		if StartGround then
			local Params = RaycastParams.new()
			Params.FilterType = Enum.RaycastFilterType.Include
			Params.FilterDescendantsInstances = {StartGround}

			local GroundResult = workspace:Raycast(Origin, Direction, Params)
			if GroundResult then
				return GroundResult.Position
			end
		end

		local BackupParams = RaycastParams.new()
		BackupParams.FilterType = Enum.RaycastFilterType.Exclude
		BackupParams.FilterDescendantsInstances = a

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
				Plotservice.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
			end
			return
		end

		if IsBought and PurchasingPlayer then
			local PlayerChannel = Sync:Get(PurchasingPlayer)
			if not PlayerChannel then
				Plotservice.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
				AnimalModel:Destroy()
				return
			end

			local Plot = Plotservice.getPlot(PurchasingPlayer)
			if not Plot then
				Plotservice.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
				AnimalModel:Destroy()
				return
			end

			local AnimalPodiums = PlayerChannel:Get("AnimalPodiums") or {}
			local IndexData = PlayerChannel:Get("Index") or {}

			if not ReservedPodiumIndex then
				Plotservice.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
				warn("[AnimalService] No reserved podium index for player: " .. PurchasingPlayer.Name)
				AnimalModel:Destroy()
				return
			end

			local targetPodium = Plot.AnimalPodiums:FindFirstChild(tostring(ReservedPodiumIndex))
			if not targetPodium then
				Plotservice.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
				warn("[AnimalService] Podium " .. ReservedPodiumIndex .. " not found for player: " .. PurchasingPlayer.Name)
				AnimalModel:Destroy()
				return
			end

			local PodiumData = AnimalPodiums[ReservedPodiumIndex]
			if PodiumData and PodiumData ~= "Empty" then
				Plotservice.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
				warn("[AnimalService] Reserved podium " .. ReservedPodiumIndex .. " is not empty for player: " .. PurchasingPlayer.Name)
				AnimalModel:Destroy()
				return
			end

			local FinalIndex = AnimalModel:GetAttribute("Index")
			local FinalMutation = AnimalModel:GetAttribute("Mutation")

			if not FinalIndex or FinalIndex == "" then
				Plotservice.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
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

			Plotservice.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)

			local GenerationAmount = Animals2:GetGeneration(
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
		if IsDestroying or not AnimalModel or not AnimalPart then return end
		if MovementConnection then MovementConnection:Disconnect() MovementConnection = nil end
		IsMoving = true

		if EventService:GetActiveEvent("Dul Dul Dul") then
			ForceStraightLine = true
		end

		CurrentPath = PathFindingService:CreatePath({AgentCanJump = true, AgentRadius = 1, Costs = { Avoid = math.huge }})
		local success = pcall(function() CurrentPath:ComputeAsync(AnimalPart.Position, Target.Position) end)

		if success and CurrentPath.Status == Enum.PathStatus.Success then
			CurrentWaypoints = CurrentPath:GetWaypoints()
			CurrentWaypointIndex = 1
			for i = 1, math.min(5, #CurrentWaypoints) do
				if (CurrentWaypoints[i].Position - AnimalPart.Position).Magnitude < 3 then
					CurrentWaypointIndex = i + 1
				else
					break
				end
			end
		else
			CurrentWaypoints = nil
			CurrentWaypointIndex = 1
		end

		local rotationSpeed = 10
		local rotationSmoothness = 0.85
		local DEST_THRESHOLD = 2.5

		MovementConnection = RunService.Heartbeat:Connect(function(dt)
			if IsDestroying or not AnimalModel.Parent or not AnimalPart.Parent or AnimalModel:GetAttribute("ForceIdle") then
				MovementConnection:Disconnect()
				MovementConnection = nil
				IsMoving = false
				return
			end

			local CurrentSpeed = GlobalSpeedOverride or OriginalSpeed
			local targetPosition

			if not ForceStraightLine and CurrentWaypoints and CurrentWaypointIndex <= #CurrentWaypoints then
				local waypoint = CurrentWaypoints[CurrentWaypointIndex]
				targetPosition = waypoint.Position
				if (Vector3.new(targetPosition.X, AnimalPart.Position.Y, targetPosition.Z) - AnimalPart.Position).Magnitude < 2 then
					CurrentWaypointIndex += 1
					if CurrentWaypointIndex > #CurrentWaypoints then CurrentWaypoints = nil end
					return
				end
			else
				targetPosition = Target.Position
				if (targetPosition - AnimalPart.Position).Magnitude < DEST_THRESHOLD then
					MovementConnection:Disconnect()
					MovementConnection = nil
					IsMoving = false
					task.spawn(onDestinationReached)
					return
				end
			end

			local HorizontalTarget = Vector3.new(targetPosition.X, AnimalPart.Position.Y, targetPosition.Z)
			local direction = HorizontalTarget - AnimalPart.Position
			local distance = direction.Magnitude
			if distance > 0.1 then
				local moveStep = math.min(CurrentSpeed * dt, distance)

				if EventService:GetActiveEvent("Chicleteira Bicicleteira") then
					moveStep *= 1.5
				end


				local newPos
				if EventService:GetActiveEvent("Dul Dul Dul") then
					newPos = stickToGround(AnimalPart.Position + direction.Unit * moveStep)
				else
					newPos = ForceStraightLine and (AnimalPart.Position + direction.Unit * moveStep) or stickToGround(AnimalPart.Position + direction.Unit * moveStep)
				end

				local targetCFrame = CFrame.new(newPos, newPos + direction.Unit)
				AnimalModel:PivotTo(targetCFrame)
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

		if PurchaseLocks[LockKey] then return end
		if LastPurchaseAttempt[LockKey] and (CurrentTime - LastPurchaseAttempt[LockKey]) < 0.1 then return end

		LastPurchaseAttempt[LockKey] = CurrentTime
		PurchaseLocks[LockKey] = true

		if AnimalData.DisplayName == "Gold Elf" then
			local PlayerChannel = Sync:Get(PlayerWhoTriggered)
			if PlayerChannel then
				ElfService:Add(PlayerWhoTriggered, 2, 5)
				CollectElfEffectRemote:FireAllClients(PlayerWhoTriggered, AnimalModel:GetPivot())

				local Sound = AnimSounds:FindFirstChild(indexName)
				if Sound then
					Soundservice:Play(PlayerWhoTriggered, Sound)
				end
				AnimalModel:Destroy()
				return 
			else
				warn("Could not find Data Channel for " .. PlayerWhoTriggered.Name)
				PurchaseLocks[LockKey] = nil
				return
			end
		end
		local PlayerChannel = Sync:Get(PlayerWhoTriggered)

		if PurchasingPlayer and PurchasingPlayer ~= PlayerWhoTriggered then
			if PurchasingPlayer then
				Plotservice.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
			end
		end

		local PlayerChannel = Sync:Get(PlayerWhoTriggered)
		if not PlayerChannel then
			PurchaseLocks[LockKey] = nil
			return
		end

		local BasePrice = AnimalData.Price
		local Price = BasePrice
		local CanAfford, Amount = Moneyservice:CanAfford(PlayerWhoTriggered, Price)
		if not CanAfford and not IsFree then
			NotifService.Error(PlayerWhoTriggered, string.format("You need $%s more to buy this", NumbUtils.ToString(nil, Amount)))
			PurchaseLocks[LockKey] = nil
			return
		end

		local Podiums = Plotservice.getFreePodium(PlayerWhoTriggered)
		if not Podiums then
			NotifService.Error(PlayerWhoTriggered, "You need more room in your base to buy a brainrot.")
			PurchaseLocks[LockKey] = nil
			return
		end

		ReservedPodiumIndex = tonumber(Podiums.Name)
		if not ReservedPodiumIndex then
			NotifService.Error(PlayerWhoTriggered, "Invalid podium index.")
			PurchaseLocks[LockKey] = nil
			return
		end

		Plotservice.AddToQueue(PlayerWhoTriggered, ReservedPodiumIndex)

		pendingTargetUserId = PlayerWhoTriggered.UserId
		if Prompt and Prompt.Parent then
			Prompt:SetAttribute("TargetPlayer", pendingTargetUserId)
		end

		PurchasingPlayer = PlayerWhoTriggered
		IsBought = true

		local Plot: any = Plotservice.getPlot(PlayerWhoTriggered)
		if not Plot then
			Plotservice.RemoveFromQueue(PlayerWhoTriggered, ReservedPodiumIndex)
			MoveTarget = workspace.Road.End
		else
			MoveTarget = Plot.AnimalTarget
		end

		if not IsFree then
			Moneyservice:Add(PlayerWhoTriggered, -Price)
			Price = Price + BasePrice * 1.5
		end

		MoveAlongPath(MoveTarget)

		local Sound = AnimSounds:FindFirstChild(indexName)
		if Sound then
			for _, Player in game.Players:GetPlayers() do
				Soundservice:Play(Player, Sound)

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
			Plotservice.RemoveFromQueue(Player, ReservedPodiumIndex)
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
			Plotservice.RemoveFromQueue(PurchasingPlayer, ReservedPodiumIndex)
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
				local PathfindingService = game:GetService("PathfindingService")
				local TweenService = game:GetService("TweenService")
				local RoadEnd = workspace.Road:WaitForChild("End")
				local Waypoints = script.Path:GetChildren()
				table.sort(Waypoints, function(a, b) return tonumber(a.Name) < tonumber(b.Name) end)
				if #Waypoints == 0 or not AnimalModel or not AnimalModel.Parent then return end

				local speed = 10
				AnimalModel:PivotTo(CFrame.new(Waypoints[1].Position, RoadEnd.Position))

				for i = 2, #Waypoints do
					if not AnimalModel or not AnimalModel.Parent then break end
					if i == 3 then door:SetAttribute("Open", false) end
					if i == 11 then
						AnimalModel:SetAttribute("ForceIdle", false)
						if AnimalData.SpawnVFX then
							Net:RemoteEvent("GameService/SpawnEffect"):FireAllClients(AnimalData.SpawnVFX, nil, AnimalData.SpawnDelay)
							AnimalModel:SetAttribute("ForceIdle", true)
						end
						task.wait(AnimalData.SpawnDelay)
						AnimalModel:SetAttribute("ForceIdle", false)
						if TriggerEvent and AnimalData.TriggerEvent then EventService:ExecuteEvent(AnimalData.TriggerEvent, 300) end
					end

					local startPos, endPos = AnimalModel:GetPivot().Position, Waypoints[i].Position
					local path = PathfindingService:CreatePath({AgentRadius = 2, AgentHeight = 4, Costs = {Avoid = math.huge}, AgentCanJump = false})
					path:ComputeAsync(startPos, endPos)
					local points = path.Status == Enum.PathStatus.Success and path:GetWaypoints() or {{Position = endPos}}

					for _, point in ipairs(points) do
						if not AnimalModel or not AnimalModel.Parent then break end
						local pos = point.Position
						local startPosInner = AnimalModel:GetPivot().Position
						AnimalModel.PrimaryPart.CFrame = CFrame.new(AnimalModel.PrimaryPart.Position, RoadEnd.Position)
						local tween = TweenService:Create(AnimalModel.PrimaryPart, TweenInfo.new((pos - startPosInner).Magnitude / speed, Enum.EasingStyle.Linear), {Position = pos})
						tween:Play()
						tween.Completed:Wait()
						AnimalModel.PrimaryPart.CFrame = CFrame.new(pos, RoadEnd.Position)
					end
				end

				if not AnimalModel or not AnimalModel.Parent then return end
				local rarity, name = AnimalData.Rarity, AnimalData.DisplayName
				if table.find({"Brainrot God", "Secret", "OG", "Admin"}, rarity) then
					local Sound = AnimSounds:FindFirstChild(indexName)
					if Sound then for _, p in game.Players:GetPlayers() do Soundservice:Play(p, Sound) end end
				end

				if rarity == "Secret" and name ~= "Lucky Block" then
					Chatservice:SendMessage("<font color='#000000'>[SERVER] A secret Brainrot has spawned!</font>")
				elseif name == "Lucky Block" then
					local msgs = {
						Admin = "<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Admin Lucky Block</font><font color='#d1d202'> has spawned!</font>",
						Spooky = "<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Spooky Lucky Block</font><font color='#d1d202'> has spawned!</font>",
						Taco = "<font color='#d1d202'>[SERVER] A </font><font color='#ff0000'>Taco Lucky Block</font><font color='#d1d202'> has spawned!</font>",
						["Brainrot God"] = "<font color='#22afe2'>[SERVER] A Brainrot God Lucky Block has spawned!</font>",
						Secret = "<font color='#000000'>[SERVER] A Secret Lucky Block has spawned!</font>"
					}
					Chatservice:SendMessage(msgs[rarity])
				end

				spawnPrompt()
				MoveAlongPath(MoveTarget)
			end)

		else
			-- [[[ MODIFIED: ANIMATION LOGIC START ]]] --
			if AnimalModel and AnimalModel.Parent and AnimalModel.PrimaryPart then
				local startCF = AnimalModel.PrimaryPart.CFrame

				-- Use a lower height like 7 studs (matches the video better)
				local riseHeight = 7 
				local hoverTime = 0.3 
				local dropTime = 0.001 -- Fast drop

				local highCF = startCF + Vector3.new(0, riseHeight, 0)

				-- 1. INSTANTLY appear in the air (no tween up)
				AnimalModel.PrimaryPart.CFrame = highCF

				if AnimalModel and AnimalModel.Parent then
					-- 2. Stay in air
					task.wait(hoverTime)

					if AnimalModel and AnimalModel.Parent then
						-- 3. Drop instantly
						local dropInfo = TweenInfo.new(dropTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
						local dropTween = TweenService:Create(AnimalModel.PrimaryPart, dropInfo, {CFrame = startCF})
						dropTween:Play()
						dropTween.Completed:Wait()
					end
				end
			end

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
local function RollForMutation()
	for eventName, data in pairs(EventMutationsList) do
		if EventService:GetActiveEvent(eventName) then
			if math.random(1, 100) <= data.Chance then
				return data.Mutation
			end
		end
	end

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
					return Entry.Name
				end
			end
		end
	end

	return nil
end
function AnimalService:SpawnNoDelay(AnimalData, Mutation, Traits, Speed, CustomSpawn, AFKTime, ForceStraightLine)
	createPurchasableAnimal(AnimalData, Mutation, Traits, Speed, CustomSpawn, AFKTime, ForceStraightLine)
end

function AnimalService.spawnAnimalInBase(Player: Player, Animal: string, Mutation: string?, Traits: any?)
	local FinalMutation = Mutation or RollForMutation()
	local PlayerChannel = Sync:Wait(Player)
	if not PlayerChannel then return end
	local Podiums = Plotservice.getFreePodium(Player)
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
	local animalId = HttpService:GenerateGUID(false)

	table.insert(NEXT_QUEUE, {
		Animal = Animal,
		Mutation = Mutation,
		Traits = Traits,
		Speed = Speed,
		CustomSpawn = CustomSpawn,
		AFKTime = StandFor,
		AnimalId = animalId  
	})

	return animalId  
end

function AnimalService.SpawnForcedAnimal(Animal: any)
	table.insert(NEXT_QUEUE, { Animal = Animal })
end
function AnimalService.spawnAnimal(Animal: any)
	local FinalMutation = nil
	local FinalTraits = nil
	local ForceStraightLine = false

	-- 1. Check if ANY mutation should occur (10% chance)
	if math.random(1, 10) == 1 then
		local chance = math.random(1, 100)

		-- 2. Determine WHICH mutation (This adds up to 100%)
		if chance <= 10 then
			FinalMutation = "Rainbow"
		elseif chance <= 35 then
			FinalMutation = "Diamond"
		elseif chance <= 70 then
			FinalMutation = "Gold"
		else
			-- 3. Fallback for "Special" mutations from your Mutations table
			local TotalWeight = 0
			local WeightedMutations = {}

			for Name, Data in pairs(Mutations) do
				-- Exclude the main 3 to prevent double-dipping
				if Name ~= "Gold" and Name ~= "Diamond" and Name ~= "Rainbow" then
					if Data.Weight and Data.Weight > 0 then
						TotalWeight += Data.Weight
						table.insert(WeightedMutations, {Name = Name, Weight = Data.Weight})
					end
				end
			end

			if #WeightedMutations > 0 then
				local RandWeight = math.random() * TotalWeight
				local Cumulative = 0
				for _, mData in ipairs(WeightedMutations) do
					Cumulative += mData.Weight
					if RandWeight <= Cumulative then
						FinalMutation = mData.Name
						break
					end
				end
			end
		end
	end

	-- 4. Overwrite if an Event Mutation is active (Highest Priority)
	for eventName, data in pairs(EventMutationsList) do
		if EventService:GetActiveEvent(eventName) then
			if math.random(1, 100) <= data.Chance then
				FinalMutation = data.Mutation
			end
		end
	end

	-- 5. Final Spawn Call
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

	local ServerLuck = Sync:Get("ServerLuck")
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
				createPurchasableAnimal(Data.Animal, Data.Mutation, Data.Traits, Data.Speed, Data.CustomSpawn, Data.AFKTime, nil, Data.AnimalId) 
				break
			end

			if not Skip then
				if YoIsTsModded then
					local AllAnimals = {}
					for Name, Data in pairs(Animals) do
						if not table.find(GameDataStorage.UnSpawnableBrainrots, Data.DisplayName) then
							table.insert(AllAnimals, Data)
						end
					end

					if #AllAnimals > 0 then
						RandomAnimal = AllAnimals[math.random(1, #AllAnimals)]
					end

					if RandomAnimal then
						local roll = math.random() * 100
						local SelectedMutation = nil

						if roll <= 0.5 then
							SelectedMutation = "Rainbow"
						elseif roll <= 2 then
							SelectedMutation = "Diamond"
						elseif roll <= 7 then
							SelectedMutation = "Gold"
						end
						for EventName, EventData in pairs(EventMutationsList) do
							local EventAttribute = ReplicatedStorage:GetAttribute(EventName)
							if EventAttribute ~= nil then
								if math.random(1, 100) <= EventData.Chance then
									SelectedMutation = EventData.Mutation
									ForceStraightLine = true
									break
								end
							end
						end

						createPurchasableAnimal(RandomAnimal, SelectedMutation, {}, nil, nil, nil, ForceStraightLine)
					end
				else
					if ForcedRarity and os.time() < ForcedRarityEndTime then
						repeat
							RandomAnimal = AnimalService.randomAnimal(ForcedRarity)
						until not RandomAnimal or not table.find(GameDataStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
					elseif GuaranteedLegendary == 0 then
						repeat
							RandomAnimal = AnimalService.randomAnimal("Legendary")
						until not RandomAnimal or not table.find(GameDataStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
						GuaranteedLegendary = 600
					elseif GuaranteedMythic == 0 then
						repeat
							RandomAnimal = AnimalService.randomAnimal("Mythic")
						until not RandomAnimal or not table.find(GameDataStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
						GuaranteedMythic = 900
					else
						repeat
							RandomAnimal = AnimalService.randomAnimal()
						until not RandomAnimal or not table.find(GameDataStorage.UnSpawnableBrainrots, RandomAnimal.DisplayName)
					end

					if RandomAnimal then
						createPurchasableAnimal(RandomAnimal, nil, {}, nil, nil, nil, false)
					end
				end
			end
		end

		task.wait(gameData.RoadSpawn.SpawnEvery)
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


-- YES. FUCKING WORKED. FINALLY.
-- onions