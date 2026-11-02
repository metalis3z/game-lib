--!native

local FuseMachineService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlotService = require(ServerScriptService.Services.PlotService)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local StealService = require(ServerScriptService.Services.StealService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local AnimalsDB = require(ReplicatedStorage.Datas.Animals)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local Traits = require(ReplicatedStorage.Datas.Traits)
local FuseMachineData = require(ReplicatedStorage.Datas.FuseMachineData)

local RemoveBrainrot = FuseMachineData.Remotes.RemoveBrainrot
local ClaimBrainrot = FuseMachineData.Remotes.ClaimBrainrot
local ConfirmFusion = FuseMachineData.Remotes.ConfirmFusion
local Delivery = FuseMachineData.Remotes.Delivery
local RevealNow = FuseMachineData.Remotes.RevealNow
local FuseAnimation = FuseMachineData.Remotes.FuseAnimation
local ForceUpdate = FuseMachineData.Remotes.ForceUpdate

local FUSION_BRAINROTS = require(game:GetService("ServerStorage").Modules.FuseData).Brainrots

local RARITY_ORDER = {"Common", "Rare", "Epic", "Legendary", "Mythic", "Brainrot God", "Secret"}

local function GetRarityTier(Rarity: string): number
	for Index, RarityName in ipairs(RARITY_ORDER) do
		if RarityName == Rarity then
			return Index
		end
	end
	return 1
end

local function GetNextRarity(CurrentRarity: string): string
	local Tier = GetRarityTier(CurrentRarity)
	if Tier < #RARITY_ORDER then
		return RARITY_ORDER[Tier + 1]
	end
	return CurrentRarity
end

local function GetBrainrotGeneration(BrainrotName: string): number
	local AnimalData = AnimalsDB[BrainrotName]
	return AnimalData and AnimalData.Generation or 0
end

local function GetBrainrotsInMachine(Podiums: {[number]: any})
	local BrainrotsInMachine = {}
	for PodiumIndex, PodiumData in Podiums do
		if type(PodiumData) == "table" and PodiumData.Machine and PodiumData.Machine.Type == "Fuse" then
			table.insert(BrainrotsInMachine, {
				Index = PodiumData.Index,
				PodiumIndex = PodiumIndex,
				Mutation = PodiumData.Mutation,
				Traits = PodiumData.Traits
			})
		end
	end
	return BrainrotsInMachine
end

local function CalculateFusionOdds(Podiums)
	local BrainrotsInMachine = {}
	local TotalQuality = 0
	local RarityCount = {}
	local AverageTier = 0
	local InsertedGenerations = {}

	for _, PodiumData in pairs(Podiums) do
		if type(PodiumData) == "table" and 
			PodiumData.Machine and 
			PodiumData.Machine.Type == "Fuse" then

			local AnimalName = PodiumData.Index
			local AnimalData = AnimalsDB[AnimalName]
			if AnimalData then
				local Tier = GetRarityTier(AnimalData.Rarity)
				local Gen = GetBrainrotGeneration(AnimalName)
				table.insert(BrainrotsInMachine, {
					Name = AnimalName,
					Rarity = AnimalData.Rarity,
					Generation = Gen
				})

				RarityCount[AnimalData.Rarity] = (RarityCount[AnimalData.Rarity] or 0) + 1
				AverageTier = AverageTier + Tier
				table.insert(InsertedGenerations, Gen)
			end
		end
	end

	if #BrainrotsInMachine == 0 then
		return {}, {}
	end

	AverageTier = AverageTier / #BrainrotsInMachine
	local DominantTier = math.round(AverageTier)
	DominantTier = math.clamp(DominantTier, 1, #RARITY_ORDER)
	local DominantRarity = RARITY_ORDER[DominantTier]

	local NextRarity = GetNextRarity(DominantRarity)
	local SameRarityFusions = {}
	local NextRarityFusions = {}

	for _, FusionName in ipairs(FUSION_BRAINROTS) do
		local FusionData = AnimalsDB[FusionName]
		if FusionData then
			local Gen = GetBrainrotGeneration(FusionName)
			if FusionData.Rarity == DominantRarity then
				table.insert(SameRarityFusions, {
					Name = FusionName,
					Generation = Gen
				})
			elseif FusionData.Rarity == NextRarity then
				table.insert(NextRarityFusions, {
					Name = FusionName,
					Generation = Gen
				})
			end
		end
	end

	table.sort(SameRarityFusions, function(A, B)
		return A.Generation > B.Generation
	end)

	table.sort(NextRarityFusions, function(A, B)
		return A.Generation < B.Generation
	end)

	local MinNextChance = 10
	local MaxNextChance = 50
	local NextChance = MinNextChance + (MaxNextChance - MinNextChance) * ((AverageTier - 1) / (#RARITY_ORDER - 1))
	NextChance = math.floor(NextChance)
	local SameChance = 100 - NextChance

	local OutputOdds = {}
	local RarityOdds = {}

	if #SameRarityFusions > 0 and SameChance > 0 then
		local TotalGenSame = 0
		for _, Fusion in ipairs(SameRarityFusions) do
			TotalGenSame = TotalGenSame + Fusion.Generation
		end

		local AllocatedSame = 0
		for Index, Fusion in ipairs(SameRarityFusions) do
			if Index == #SameRarityFusions then
				OutputOdds[Fusion.Name] = SameChance - AllocatedSame
			else
				local Chance = math.floor((Fusion.Generation / TotalGenSame) * SameChance)
				OutputOdds[Fusion.Name] = Chance
				AllocatedSame = AllocatedSame + Chance
			end
		end
	end

	local NumNextToInclude = 1
	if #NextRarityFusions > 0 then
		local WorstNextGen = NextRarityFusions[1].Generation
		local MaxInsertedGen = math.max(unpack(InsertedGenerations))
		if MaxInsertedGen < WorstNextGen then
			NumNextToInclude = math.min(2, #NextRarityFusions)
		end
	end

	if #NextRarityFusions > 0 and NextChance > 0 then
		local IncludedNext = {}
		for i = 1, NumNextToInclude do
			table.insert(IncludedNext, NextRarityFusions[i])
		end

		table.sort(IncludedNext, function(A, B)
			return A.Generation > B.Generation
		end)

		local TotalGenNext = 0
		for _, Fusion in ipairs(IncludedNext) do
			TotalGenNext = TotalGenNext + Fusion.Generation
		end

		local AllocatedNext = 0
		for Index, Fusion in ipairs(IncludedNext) do
			if Index == #IncludedNext then
				OutputOdds[Fusion.Name] = NextChance - AllocatedNext
			else
				local Chance = math.floor((Fusion.Generation / TotalGenNext) * NextChance)
				OutputOdds[Fusion.Name] = Chance
				AllocatedNext = AllocatedNext + Chance
			end
		end
	end

	for Name, Chance in pairs(OutputOdds) do
		local AnimalData = AnimalsDB[Name]
		if AnimalData then
			RarityOdds[AnimalData.Rarity] = (RarityOdds[AnimalData.Rarity] or 0) + Chance
		end
	end

	return OutputOdds, RarityOdds
end

local function GetMutationOddsFromMachine(BrainrotsInMachine)
	local MutationCount = {}
	local TotalMutations = 0

	for _, BrainrotData in BrainrotsInMachine do
		local Mutation = BrainrotData.Mutation
		if Mutation then
			MutationCount[Mutation] = (MutationCount[Mutation] or 0) + 1
			TotalMutations = TotalMutations + 1
		end
	end

	local MutationOdds = {}

	if TotalMutations == 0 then
		return MutationOdds
	end

	for MutationName, Count in pairs(MutationCount) do
		local BaseChance = 10 + (10 * (Count - 1) / TotalMutations)
		MutationOdds[MutationName] = math.clamp(BaseChance, 10, 20)
	end

	local TotalChance = 0
	for _, Chance in pairs(MutationOdds) do
		TotalChance = TotalChance + Chance
	end

	if TotalChance > 100 then
		local Scale = 100 / TotalChance
		for MutationName, Chance in pairs(MutationOdds) do
			MutationOdds[MutationName] = math.floor(Chance * Scale)
		end
	end

	return MutationOdds
end

local function GetTraitOddsFromMachine(BrainrotsInMachine)
	local TraitCount = {}
	local TotalTraits = 0

	for _, BrainrotData in BrainrotsInMachine do
		local TraitsList = BrainrotData.Traits or {}
		for _, Trait in ipairs(TraitsList) do
			TraitCount[Trait] = (TraitCount[Trait] or 0) + 1
			TotalTraits = TotalTraits + 1
		end
	end

	local TraitOdds = {}

	if TotalTraits == 0 then
		return TraitOdds
	end

	for TraitName, Count in pairs(TraitCount) do
		local BaseChance = 10 + (10 * (Count - 1) / TotalTraits)
		TraitOdds[TraitName] = math.clamp(BaseChance, 10, 20)
	end

	local TotalChance = 0
	for _, Chance in pairs(TraitOdds) do
		TotalChance = TotalChance + Chance
	end

	if TotalChance > 100 then
		local Scale = 100 / TotalChance
		for TraitName, Chance in pairs(TraitOdds) do
			TraitOdds[TraitName] = math.floor(Chance * Scale)
		end
	end

	return TraitOdds
end

local function CalculateFuseCost(BrainrotsInMachine: {any})
	local TotalCost = 0
	for _, BrainrotData in BrainrotsInMachine do
		local BrainrotName = BrainrotData.Index
		local AnimalData = AnimalsDB[BrainrotName]
		if AnimalData and AnimalData.Price then
			TotalCost = TotalCost + AnimalData.Price
		end
	end
	return math.floor(TotalCost * (FuseMachineData.FFlagDefaults["FuseMachine/CostMultiplier"] or 1.25))
end

local function UpdateFuseMachineData(Player: Player)
	local Data = Synchronizer:Get(Player)
	if not Data then return end

	local Podiums = Data:Get("AnimalPodiums") or {}
	local BrainrotsInMachine = GetBrainrotsInMachine(Podiums)

	if #BrainrotsInMachine > 0 then
		local OutputOdds, RarityOdds = CalculateFusionOdds(Podiums)
		local MutationOdds = GetMutationOddsFromMachine(BrainrotsInMachine)
		local TraitOdds = GetTraitOddsFromMachine(BrainrotsInMachine)

		Data:Set("FuseMachine.OutputRarityOdds", OutputOdds)
		Data:Set("FuseMachine.OutputMutationOdds", MutationOdds)
		Data:Set("FuseMachine.OutputTraitsOdds", TraitOdds)

		if #BrainrotsInMachine >= FuseMachineData.FuseSlots then
			local FuseCost = CalculateFuseCost(BrainrotsInMachine)
			Data:Set("FuseMachine.Cost", FuseCost)
		else
			Data:Set("FuseMachine.Cost", nil)
		end
	else
		Data:Set("FuseMachine.OutputRarityOdds", {})
		Data:Set("FuseMachine.OutputMutationOdds", {})
		Data:Set("FuseMachine.OutputTraitsOdds", {})
		Data:Set("FuseMachine.Cost", nil)
	end

	ForceUpdate:FireClient(Player)
end

RemoveBrainrot.OnServerInvoke = function(Player: Player, PodiumIndex: number)
	local Data = Synchronizer:Get(Player)
	if not Data then return false, "Data not found" end

	local Podiums = Data:Get("AnimalPodiums") or {}
	local PodiumData = Podiums[PodiumIndex]

	if not PodiumData or not PodiumData.Machine or PodiumData.Machine.Type ~= "Fuse" then
		return false, "Invalid podium"
	end

	local FuseMachine = Data:Get("FuseMachine")
	if FuseMachine and FuseMachine.StartTime and FuseMachine.StartTime ~= 0 then
		return false, "Cannot remove during fusion"
	end

	PodiumData.Machine = nil
	Podiums[PodiumIndex] = PodiumData
	Data:Set("AnimalPodiums", Podiums)
	Data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

	UpdateFuseMachineData(Player)
	return true
end

Delivery.OnServerInvoke = function(Player: Player, Hitbox)
	local Data = Synchronizer:Get(Player)
	if not Data then return false end

	local StealData = StealService:GetStealData(Player)
	if not StealData or not StealData.StolenAnimalData then return false end

	local AnimalName = StealData.StolenAnimalData.Index or "Noobini Pizzanini"
	local Podiums = Data:Get("AnimalPodiums") or {}

	local HasAnimal = false
	for _, PodiumData in Podiums do
		if type(PodiumData) == "table" and PodiumData.Index == AnimalName then
			HasAnimal = true
			break
		end
	end

	if not HasAnimal then
		NotificationService.Error(Player, "You must own the brainrot to use it in the machine")
		return false
	end

	local BrainrotsInMachine = GetBrainrotsInMachine(Podiums)

	if #BrainrotsInMachine >= FuseMachineData.FuseSlots then
		NotificationService.Error(Player, "Fuse Machine is full")
		StealService:CancelSteal(Player)
		return false
	end

	local StolenAnimalData = StealData.StolenAnimalData
	local TraitsList = StolenAnimalData.Traits
	if TraitsList and #TraitsList == 0 then TraitsList = nil end

	local OriginalPodiumIndex = StealData.PodiumIndex
	if OriginalPodiumIndex and Podiums[OriginalPodiumIndex] then
		local ExistingPodium = Podiums[OriginalPodiumIndex]
		ExistingPodium.Machine = {
			Type = "Fuse",
			Active = false
		}
		Podiums[OriginalPodiumIndex] = ExistingPodium
	else
		local AvailableSlot = nil
		for I = 1, 50 do
			if not Podiums[I] then
				AvailableSlot = I
				break
			end
		end
		if not AvailableSlot then return false end

		Podiums[AvailableSlot] = {
			IndexOnPlot = OriginalPodiumIndex or AvailableSlot,
			Index = AnimalName,
			LastCollect = StolenAnimalData.LastCollect or workspace:GetServerTimeNow(),
			OfflineGain = StolenAnimalData.OfflineGain or nil,
			Mutation = StolenAnimalData.Mutation,
			Traits = TraitsList,
			Machine = {
				Type = "Fuse",
				Active = false
			}
		}
	end

	Data:Set("AnimalPodiums", Podiums)
	Data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
	StealService:CancelSteal(Player)

	local AnimalData = AnimalsDB[AnimalName]
	local RarityName = AnimalData and AnimalData.Rarity
	local RarityData = RarityName and Rarities[RarityName]
	local Color = RarityData and RarityData.Color
	local ColoredAnimalName = AnimalName

	if Color and typeof(Color) == "Color3" then
		local Hex = string.format("#%02X%02X%02X", math.floor(Color.R*255), math.floor(Color.G*255), math.floor(Color.B*255))
		ColoredAnimalName = string.format('<font color="%s">%s</font>', Hex, (AnimalData and AnimalData.DisplayName) or AnimalName)
	end

	NotificationService.Notify(Player, string.format("You have added %s to Santa's Fuse!", ColoredAnimalName), 5, "Sounds.Sfx.Success")
	UpdateFuseMachineData(Player)
	return true
end

ConfirmFusion.OnServerInvoke = function(Player: Player)
	local Data = Synchronizer:Get(Player)
	if not Data then return false, "Data not found" end

	local FuseMachine = Data:Get("FuseMachine")
	if not FuseMachine or not FuseMachine.Cost then return false, "Invalid fusion data" end

	if FuseMachine.StartTime and FuseMachine.StartTime ~= 0 then
		return false, "Fusion already in progress"
	end

	local Podiums = Data:Get("AnimalPodiums") or {}
	local BrainrotsInMachine = GetBrainrotsInMachine(Podiums)

	if #BrainrotsInMachine < FuseMachineData.FuseSlots then
		return false, "Not enough brainrots in machine"
	end

	local Coins = Data:Get("Coins") or 0
	if Coins < FuseMachine.Cost then
		return false, "Not enough coins"
	end

	local HighestRarity = "Common"
	local HighestWeight = 0

	for BrainrotName, Chance in FuseMachine.OutputRarityOdds do
		local AnimalData = AnimalsDB[BrainrotName]
		if AnimalData and AnimalData.Rarity then
			local RarityData = Rarities[AnimalData.Rarity]
			if RarityData and RarityData.Weight > HighestWeight then
				HighestWeight = RarityData.Weight
				HighestRarity = AnimalData.Rarity
			end
		end
	end

	local FuseTime = FuseMachineData.FuseTime[HighestRarity] or 900
	local CurrentTime = workspace:GetServerTimeNow()

	for PodiumIndex, PodiumData in Podiums do
		if type(PodiumData) == "table" and PodiumData.Machine and PodiumData.Machine.Type == "Fuse" then
			PodiumData.Machine.Active = true
			PodiumData.Machine.FinishTime = CurrentTime + FuseTime
			Podiums[PodiumIndex] = PodiumData
		end
	end
	Data:Set("AnimalPodiums", Podiums)
	Data:Set("AnimalAddedOrRemoved", CurrentTime)

	Data:Set("Coins", Coins - FuseMachine.Cost)
	Data:Set("FuseMachine.StartTime", CurrentTime)
	Data:Set("FuseMachine.FinishTime", CurrentTime + FuseTime)

	UpdateFuseMachineData(Player)

	return true
end

ClaimBrainrot.OnServerInvoke = function(Player: Player)
	local Data = Synchronizer:Get(Player)
	if not Data then return false, "Data not found" end

	local FuseMachine = Data:Get("FuseMachine")
	if not FuseMachine or not FuseMachine.FinishTime or FuseMachine.FinishTime == 0 then
		return false, "No fusion to claim"
	end

	local CurrentTime = workspace:GetServerTimeNow()
	if CurrentTime < FuseMachine.FinishTime then
		return false, "Fusion not complete"
	end

	local Plot = PlotService.getPlot(Player)
	if not Plot then return false, "Plot not found" end

	Data:Set("FuseMachine.FinishTime", 0)

	local Podiums = Data:Get("AnimalPodiums") or {}
	for PodiumIndex, PodiumData in Podiums do
		if type(PodiumData) == "table" and PodiumData.Machine and PodiumData.Machine.Type == "Fuse" then
			PodiumData.Machine.FinishTime = 0
			Podiums[PodiumIndex] = PodiumData
		end
	end
	Data:Set("AnimalPodiums", Podiums)
	Data:Set("AnimalAddedOrRemoved", CurrentTime)

	local OutputOdds = FuseMachine.OutputRarityOdds or {}
	if not next(OutputOdds) then
		NotificationService.Error(Player, "No valid brainrots available for fusion")
		return false, "No valid brainrots available"
	end

	local RandomValue = Random.new():NextNumber(0, 100)
	local CumulativeChance = 0
	local SelectedBrainrot = nil

	for BrainrotName, Chance in OutputOdds do
		CumulativeChance = CumulativeChance + Chance
		if RandomValue <= CumulativeChance then
			SelectedBrainrot = BrainrotName
			break
		end
	end

	if not SelectedBrainrot then
		for BrainrotName, _ in OutputOdds do
			SelectedBrainrot = BrainrotName
			break
		end
	end

	local SelectedAnimalData = AnimalsDB[SelectedBrainrot]
	if not SelectedAnimalData then
		NotificationService.Error(Player, "Invalid brainrot selected for fusion")
		return false, "Invalid brainrot selected"
	end

	local SelectedMutation: string? = nil
	local MutationOdds = FuseMachine.OutputMutationOdds or {}

	if next(MutationOdds) then
		local MutationRoll = Random.new():NextNumber(0, 100)
		local MutationCumulative = 0

		for MutationName, MutationChance in MutationOdds do
			MutationCumulative = MutationCumulative + MutationChance
			if MutationRoll <= MutationCumulative then
				SelectedMutation = MutationName
				break
			end
		end
	end

	local SelectedTraits: {string} = {}
	local TraitOdds = FuseMachine.OutputTraitsOdds or {}

	if next(TraitOdds) then
		for TraitName, TraitChance in TraitOdds do
			local TraitRoll = Random.new():NextNumber(0, 100)
			if TraitRoll <= TraitChance then
				table.insert(SelectedTraits, TraitName)
			end
		end
	end

	if #SelectedTraits == 0 then
		SelectedTraits = nil
	end

	FuseAnimation:FireClient(Player, SelectedBrainrot, CurrentTime, CurrentTime)

	AnimalService.spawnAnimalCustom(SelectedAnimalData, SelectedMutation, SelectedTraits, nil, {
		Start = workspace.FuseMachine.VisualSpawnCFrame,
		End = Plot.AnimalTarget,
		Owner = Player
	})

	for PodiumIndex, PodiumData in Podiums do
		if type(PodiumData) == "table" and PodiumData.Machine and PodiumData.Machine.Type == "Fuse" then
			Podiums[PodiumIndex] = nil
		end
	end
	Data:Set("AnimalPodiums", Podiums)
	Data:Set("AnimalAddedOrRemoved", CurrentTime)

	UpdateFuseMachineData(Player)

	Data:Set("FuseMachine", {
		OutputRarityOdds = {},
		OutputTraitsOdds = {},
		OutputMutationOdds = {},
		Cost = nil,
		StartTime = nil,
		FinishTime = nil,
		FuseLuckMultiplier = 1
	})

	ForceUpdate:FireClient(Player)

	return true
end

RevealNow.OnServerEvent:Connect(function(Player: Player)
	local Data = Synchronizer:Get(Player)
	if not Data then return end

	local FuseMachine = Data:Get("FuseMachine")
	if not FuseMachine or not FuseMachine.StartTime or FuseMachine.StartTime == 0 then return end

	local InstantReveals = Data:Get("FuseMachine.InstantReveals") or 0
	if InstantReveals > 0 then
		Data:Set("FuseMachine.InstantReveals", InstantReveals - 1)
		Data:Set("FuseMachine.FinishTime", workspace:GetServerTimeNow())
	end
end)

function FuseMachineService:PurchaseRevealNow(Player: Player)
	local Data = Synchronizer:Get(Player)
	if not Data then return end

	local FuseMachine = Data:Get("FuseMachine")
	if not FuseMachine or not FuseMachine.StartTime or FuseMachine.StartTime == 0 then return end
	if FuseMachine.FinishTime and FuseMachine.FinishTime <= workspace:GetServerTimeNow() then return end

	Data:Set("FuseMachine.FinishTime", 0)

	task.spawn(function()
		ClaimBrainrot:InvokeClient(Player)
	end)
end

function FuseMachineService:Start()
	for _, Player in Players:GetChildren() do
		local Data = Synchronizer:Wait(Player)
		if Data then
			local FuseMachine = Data:Get("FuseMachine")
			if not FuseMachine then
				Data:Set("FuseMachine", {
					OutputRarityOdds = {},
					OutputTraitsOdds = {},
					OutputMutationOdds = {},
					Cost = 0,
					StartTime = 0,
					FinishTime = 0,
					FuseLuckMultiplier = 1
				})
			end
			UpdateFuseMachineData(Player)
		end
	end

	Players.PlayerAdded:Connect(function(Player)
		local Data = Synchronizer:Wait(Player)
		if Data then
			local FuseMachine = Data:Get("FuseMachine")
			if not FuseMachine then
				Data:Set("FuseMachine", {
					OutputRarityOdds = {},
					OutputTraitsOdds = {},
					OutputMutationOdds = {},
					Cost = 0,
					StartTime = 0,
					FinishTime = 0,
					FuseLuckMultiplier = 1
				})
			end
			UpdateFuseMachineData(Player)
		end
	end)
end

return FuseMachineService