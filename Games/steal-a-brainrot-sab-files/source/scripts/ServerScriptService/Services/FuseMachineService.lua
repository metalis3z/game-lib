--!native
local FuseMachineService = {}


local SPECIAL_RECIPES = {
	{
		Output      = "Ketupat Bros",
		RequiredAll = {"Ginger Gerat", "Ketupat Kepat"},
		RequiredAny = {"Ginger Gerat"},
		BonusChance = 50,
	},
	{
		Output      = "Los Sweethearts",
		RequiredAny = {"Los Tralaleritos", "Las Tralaleritas", "Cupid Hotspot", "Noo My heart"},
		BonusChance = 50,
	},
}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService = game:GetService("CollectionService")
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

local FUSION_MODULE = require(game:GetService("ServerStorage").Modules.FuseData)

local ActiveMutationEvents = {}

local RARITY_ORDER = {"Common", "Rare", "Epic", "Legendary", "Mythic", "Brainrot God", "Secret", "OG"}

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

local function GetBrainrotPrice(BrainrotName: string): number
	local AnimalData = AnimalsDB[BrainrotName]
	return AnimalData and AnimalData.Price or 0
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

local function EvaluateSpecialRecipes(MachineAnimals: {string})
	local AnimalSet = {}
	for _, Name in ipairs(MachineAnimals) do
		AnimalSet[Name] = true
	end

	local guaranteedOutput = nil
	local bonuses = {}

	for _, Recipe in ipairs(SPECIAL_RECIPES) do
		if Recipe.RequiredAll and not guaranteedOutput then
			local allPresent = true
			for _, Required in ipairs(Recipe.RequiredAll) do
				if not AnimalSet[Required] then
					allPresent = false
					break
				end
			end
			if allPresent then
				guaranteedOutput = Recipe.Output
				return guaranteedOutput, bonuses
			end
		end

		if Recipe.RequiredAny and not guaranteedOutput then
			local allAnyPresent = true
			for _, Required in ipairs(Recipe.RequiredAny) do
				if not AnimalSet[Required] then
					allAnyPresent = false
					break
				end
			end
			if allAnyPresent then
				local Chance = Recipe.BonusChance or 50
				bonuses[Recipe.Output] = (bonuses[Recipe.Output] or 0) + Chance
			end
		end
	end

	return guaranteedOutput, bonuses
end

local function CalculateFusionOdds(Podiums)
	local BrainrotsInMachine = {}
	local AverageTier = 0
	local InsertedPrices = {}
	local HighestGeneration = 0
	local MachineAnimalNames = {}
	local fuseMachine = workspace:FindFirstChild("FuseMachine")
	local currentFuseType = fuseMachine and fuseMachine:GetAttribute("FuseType")

	local FUSION_BRAINROTS = (currentFuseType == "Divine" and FUSION_MODULE.Brainrots) 
		or (currentFuseType == "Normal" and FUSION_MODULE.BrainrotsNormal)
		or (currentFuseType == "Witch" and FUSION_MODULE.BrainrotsWitch)
		or (currentFuseType == "Santa" and FUSION_MODULE.BrainrotsSanta)
		or FUSION_MODULE.BrainrotsSummer
	for _, PodiumData in pairs(Podiums) do
		if type(PodiumData) == "table" and
			PodiumData.Machine and
			PodiumData.Machine.Type == "Fuse" then

			local AnimalName = PodiumData.Index
			table.insert(MachineAnimalNames, AnimalName)

			local AnimalData = AnimalsDB[AnimalName]
			if AnimalData then
				local Tier = GetRarityTier(AnimalData.Rarity)
				local Price = GetBrainrotPrice(AnimalName)

				local Gen = AnimalData.Generation or 0
				if Gen > HighestGeneration then
					HighestGeneration = Gen
				end

				table.insert(BrainrotsInMachine, {
					Name = AnimalName,
					Rarity = AnimalData.Rarity,
					Price = Price,
					Generation = Gen
				})

				AverageTier = AverageTier + Tier
				table.insert(InsertedPrices, Price)
			end
		end
	end

	if #BrainrotsInMachine == 0 then
		return {}, {}
	end

	local guaranteedOutput, bonuses = EvaluateSpecialRecipes(MachineAnimalNames)

	local OutputOdds = {}
	local RarityOdds = {}

	if guaranteedOutput then
		OutputOdds[guaranteedOutput] = 100
		local targetData = AnimalsDB[guaranteedOutput]
		if targetData then RarityOdds[targetData.Rarity] = 100 end
		return OutputOdds, RarityOdds
	end

	local SpecialBonusPool = 0
	for OutputName, Chance in pairs(bonuses) do
		OutputOdds[OutputName] = Chance
		SpecialBonusPool = SpecialBonusPool + Chance
	end

	AverageTier = AverageTier / #BrainrotsInMachine
	local DominantTier = math.round(AverageTier)
	DominantTier = math.clamp(DominantTier, 1, #RARITY_ORDER)
	local DominantRarity = RARITY_ORDER[DominantTier]
	local NextRarity = GetNextRarity(DominantRarity)

	local SpecialOutputNames = {}
	for _, Recipe in ipairs(SPECIAL_RECIPES) do
		SpecialOutputNames[Recipe.Output] = true
	end

	local SameRarityFusions = {}
	local NextRarityFusions = {}
	for FusionName, Config in pairs(FUSION_BRAINROTS) do
		if SpecialOutputNames[FusionName] then continue end

		if Config.MinGeneration and HighestGeneration < Config.MinGeneration then
			continue
		end
		if Config.MaxGeneration and HighestGeneration > Config.MaxGeneration then
			continue
		end

		local FusionData = AnimalsDB[FusionName]
		if FusionData then
			local Price = GetBrainrotPrice(FusionName)
			local Entry = {
				Name = FusionName,
				Price = Price,
				Min = Config.Min or 0,
				Max = Config.Max or 100
			}

			if FusionData.Rarity == DominantRarity then
				table.insert(SameRarityFusions, Entry)
			elseif FusionData.Rarity == NextRarity then
				table.insert(NextRarityFusions, Entry)
			end
		end
	end

	table.sort(SameRarityFusions, function(A, B) return A.Price > B.Price end)
	table.sort(NextRarityFusions, function(A, B) return A.Price < B.Price end)

	local AvailableWeight = 100 - SpecialBonusPool
	local BaseMinNext = 10
	local BaseMaxNext = 50

	local NextChance = math.floor((BaseMinNext + (BaseMaxNext - BaseMinNext) * ((AverageTier - 1) / (#RARITY_ORDER - 1))) * (AvailableWeight / 100))
	local SameChance = AvailableWeight - NextChance

	if #SameRarityFusions > 0 and SameChance > 0 then
		local TotalPriceSame = 0
		for _, Fusion in ipairs(SameRarityFusions) do
			TotalPriceSame = TotalPriceSame + Fusion.Price
		end

		local AllocatedSame = 0
		for Index, Fusion in ipairs(SameRarityFusions) do
			local CalculatedChance = 0

			if TotalPriceSame > 0 then
				CalculatedChance = math.floor((Fusion.Price / TotalPriceSame) * SameChance)
			else
				CalculatedChance = math.floor(SameChance / #SameRarityFusions)
			end

			local minLimit = tonumber(Fusion.Min) or 0
			local maxLimit = tonumber(Fusion.Max) or 100
			if maxLimit < minLimit then maxLimit = minLimit end
			if (not minLimit) or (not maxLimit) then minLimit = 0; maxLimit = 100 end

			CalculatedChance = math.clamp(CalculatedChance, minLimit, maxLimit)

			if Index == #SameRarityFusions then
				local Remainder = SameChance - AllocatedSame
				if Remainder <= Fusion.Max and Remainder >= Fusion.Min then
					CalculatedChance = Remainder
				end
			end

			OutputOdds[Fusion.Name] = (OutputOdds[Fusion.Name] or 0) + CalculatedChance
			AllocatedSame = AllocatedSame + CalculatedChance
		end
	end

	local NumNextToInclude = 1
	if #NextRarityFusions > 0 then
		local WorstNextPrice = NextRarityFusions[1].Price
		local MaxInsertedPrice = math.max(unpack(InsertedPrices))
		if MaxInsertedPrice < WorstNextPrice then
			NumNextToInclude = math.min(2, #NextRarityFusions)
		end
	end

	if #NextRarityFusions > 0 and NextChance > 0 then
		local IncludedNext = {}
		for i = 1, NumNextToInclude do
			table.insert(IncludedNext, NextRarityFusions[i])
		end

		table.sort(IncludedNext, function(A, B) return A.Price > B.Price end)

		local TotalPriceNext = 0
		for _, Fusion in ipairs(IncludedNext) do
			TotalPriceNext = TotalPriceNext + Fusion.Price
		end

		local AllocatedNext = 0
		for Index, Fusion in ipairs(IncludedNext) do
			local CalculatedChance = 0

			if TotalPriceNext > 0 then
				CalculatedChance = math.floor((Fusion.Price / TotalPriceNext) * NextChance)
			else
				CalculatedChance = math.floor(NextChance / #IncludedNext)
			end

			local minLimit = tonumber(Fusion.Min) or 0
			local maxLimit = tonumber(Fusion.Max) or 100
			if maxLimit < minLimit then maxLimit = minLimit end
			if (not minLimit) or (not maxLimit) then minLimit = 0; maxLimit = 100 end

			CalculatedChance = math.clamp(CalculatedChance, minLimit, maxLimit)

			if Index == #IncludedNext then
				local Remainder = NextChance - AllocatedNext
				if Remainder <= Fusion.Max and Remainder >= Fusion.Min then
					CalculatedChance = Remainder
				end
			end

			OutputOdds[Fusion.Name] = (OutputOdds[Fusion.Name] or 0) + CalculatedChance
			AllocatedNext = AllocatedNext + CalculatedChance
		end
	end

	local FinalResultsList = {}
	for Name, Chance in pairs(OutputOdds) do
		if Chance > 0 then
			local Price = GetBrainrotPrice(Name)
			table.insert(FinalResultsList, { Name = Name, Chance = Chance, Price = Price })
		end
	end

	table.sort(FinalResultsList, function(A, B) return A.Price > B.Price end)

	local PrunedResults = {}
	local NewTotalWeight = 0
	for i = 1, math.min(4, #FinalResultsList) do
		table.insert(PrunedResults, FinalResultsList[i])
		NewTotalWeight = NewTotalWeight + FinalResultsList[i].Chance
	end

	for OutputName, Chance in pairs(bonuses) do
		local alreadyIncluded = false
		for _, r in ipairs(PrunedResults) do
			if r.Name == OutputName then alreadyIncluded = true; break end
		end
		if not alreadyIncluded then
			table.insert(PrunedResults, {
				Name   = OutputName,
				Chance = Chance,
				Price  = GetBrainrotPrice(OutputName)
			})
			NewTotalWeight = NewTotalWeight + Chance
		end
	end

	OutputOdds = {}
	local FinalChances = {}
	local TotalAssigned = 0

	if #PrunedResults > 0 then
		for i, Data in ipairs(PrunedResults) do
			local Config = FUSION_BRAINROTS[Data.Name]
			local MaxLimit = (Config and Config.Max) or 100
			local MinLimit = (Config and Config.Min) or 0

			local RawShare = 0
			if NewTotalWeight > 0 then
				RawShare = math.floor((Data.Chance / NewTotalWeight) * 100)
			end

			local NewChance = math.clamp(RawShare, MinLimit, MaxLimit)
			FinalChances[i] = {
				Name   = Data.Name,
				Chance = NewChance,
				Min    = MinLimit,
				Max    = MaxLimit
			}
			TotalAssigned = TotalAssigned + NewChance
		end

		local SafetyCounter = 0
		while TotalAssigned ~= 100 and SafetyCounter < 20 do
			SafetyCounter = SafetyCounter + 1
			local NeedWeight = 100 - TotalAssigned
			local Step = NeedWeight > 0 and 1 or -1
			local Changed = false

			for i = 1, #FinalChances do
				local item = FinalChances[i]
				if Step > 0 and item.Chance < item.Max then
					item.Chance   = item.Chance + 1
					TotalAssigned = TotalAssigned + 1
					Changed = true
				elseif Step < 0 and item.Chance > item.Min then
					item.Chance   = item.Chance - 1
					TotalAssigned = TotalAssigned - 1
					Changed = true
				end
				if TotalAssigned == 100 then break end
			end
			if not Changed then break end
		end

		for _, item in ipairs(FinalChances) do
			OutputOdds[item.Name] = item.Chance
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

	for _, BrainrotData in BrainrotsInMachine do
		local Mutation = BrainrotData.Mutation
		if Mutation then
			MutationCount[Mutation] = (MutationCount[Mutation] or 0) + 1
		end
	end

	local MutationOdds = {}
	for MutationName, Count in pairs(MutationCount) do
		MutationOdds[MutationName] = Count * 10
	end

	for MutationName in pairs(ActiveMutationEvents) do
		MutationOdds[MutationName] = (MutationOdds[MutationName] or 0) + 15
	end

	if not next(MutationOdds) then return MutationOdds end

	local TotalChance = 0
	for _, Chance in pairs(MutationOdds) do TotalChance = TotalChance + Chance end

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

	for _, BrainrotData in BrainrotsInMachine do
		local TraitsList = BrainrotData.Traits or {}
		for _, Trait in ipairs(TraitsList) do
			TraitCount[Trait] = (TraitCount[Trait] or 0) + 1
		end
	end

	local TraitOdds = {}
	for TraitName, Count in pairs(TraitCount) do
		TraitOdds[TraitName] = math.min(Count * 15, 100)
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

		local PercentOverride = Data:Get("FuseMachine.PercentOverride")
		if PercentOverride and next(PercentOverride) then
			OutputOdds = PercentOverride
		end

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
	local DisplayName = (AnimalData and AnimalData.DisplayName) or AnimalName
	local ColoredAnimalName = DisplayName

	if RarityData then
		if RarityData.GradientPreset then
			local tag = string.lower(RarityData.GradientPreset)
			ColoredAnimalName = string.format("<%s>%s</%s>", tag, DisplayName, tag)
		elseif RarityData.Color and typeof(RarityData.Color) == "Color3" then
			local c = RarityData.Color
			local Hex = string.format("#%02X%02X%02X", math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255))
			ColoredAnimalName = string.format('<font color="%s">%s</font>', Hex, DisplayName)
		end
	end
	local FuseType = workspace:FindFirstChild("FuseMachine"):GetAttribute("FuseType")

	local MachineColor = "#00BFFF"

	if FuseType == "Normal" then
		MachineColor = "#00BFFF"
	elseif FuseType == "Divine" then
		MachineColor = "#FFD700"
	elseif FuseType == "Witch" then
		MachineColor = "#9B30FF"
	elseif FuseType == "Santa" then
		MachineColor = "#FF0000"
	elseif FuseType == "Summer" then
		MachineColor = "#e1bb62"
	end

	local MachineDisplayName = (FuseType == "Witch") and "Witch Fuse" or (FuseType == "Santa") and "Santa's Fuse" or "Fuse Machine"

	NotificationService.Notify(
		Player, 
		string.format('You have added %s to <font color="%s">%s</font>!', ColoredAnimalName, MachineColor, MachineDisplayName), 
		5, 
		"Sounds.Sfx.Success"
	)
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

local function InternalClaim(Player)
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

	local SelectedBrainrot = nil
	local AdminOverride   = Data:Get("FuseMachine.AdminOverride")
	local PercentOverride = Data:Get("FuseMachine.PercentOverride")
	local gamedata        = require(ReplicatedStorage.GameData)
	local blacklisted     = gamedata.UnSpawnableBrainrots

	if blacklisted[AdminOverride] then
		NotificationService.Error(Player, "This Brainrot is blacklisted")
		return false, "Blacklisted brainrot"
	end

	if AdminOverride and AnimalsDB[AdminOverride] and not blacklisted[AdminOverride] then
		SelectedBrainrot = AdminOverride

	elseif PercentOverride and next(PercentOverride) then
		local SafeOdds  = {}
		local SafeTotal = 0
		for Name, Chance in pairs(PercentOverride) do
			if AnimalsDB[Name] and not blacklisted[Name] then
				SafeOdds[Name] = Chance
				SafeTotal      = SafeTotal + Chance
			end
		end

		if SafeTotal > 0 then
			local Roll       = Random.new():NextNumber(0, SafeTotal)
			local Cumulative = 0
			for Name, Chance in pairs(SafeOdds) do
				Cumulative = Cumulative + Chance
				if Roll <= Cumulative then
					SelectedBrainrot = Name
					break
				end
			end
			if not SelectedBrainrot then
				SelectedBrainrot = next(SafeOdds)
			end
		end

	else
		local OutputOdds = FuseMachine.OutputRarityOdds or {}

		if not next(OutputOdds) then
			local FallbackPool = {"Dragon Aquanini"}

			if #FallbackPool == 0 then
				for AnimalName, AnimalData in pairs(AnimalsDB) do
					if AnimalData.Rarity == "Secret" then
						table.insert(FallbackPool, AnimalName)
					end
				end
			end

			if #FallbackPool > 0 then
				local EqualChance = math.floor(100 / #FallbackPool)
				for _, AnimalName in ipairs(FallbackPool) do
					OutputOdds[AnimalName] = EqualChance
				end
				local Remainder = 100 - (EqualChance * #FallbackPool)
				if Remainder > 0 then
					OutputOdds[FallbackPool[1]] = OutputOdds[FallbackPool[1]] + Remainder
				end
			else
				NotificationService.Error(Player, "No valid brainrots available for fusion")
				return false, "No valid brainrots available"
			end
		end

		local RandomValue      = Random.new():NextNumber(0, 100)
		local CumulativeChance = 0
		for BrainrotName, Chance in pairs(OutputOdds) do
			CumulativeChance = CumulativeChance + Chance
			if RandomValue <= CumulativeChance then
				SelectedBrainrot = BrainrotName
				break
			end
		end

		if not SelectedBrainrot then
			SelectedBrainrot = next(OutputOdds)
		end
	end

	local SelectedAnimalData = AnimalsDB[SelectedBrainrot]
	if not SelectedAnimalData then
		NotificationService.Error(Player, "Invalid brainrot selected for fusion")
		return false, "Invalid brainrot selected"
	end

	local AdminMutationOverride = Data:Get("FuseMachine.AdminMutationOverride")
	local SelectedMutation: string? = nil

	if AdminMutationOverride then
		SelectedMutation = AdminMutationOverride
	else
		local MutationOdds = FuseMachine.OutputMutationOdds or {}
		if next(MutationOdds) then
			local MutationRoll       = Random.new():NextNumber(0, 100)
			local MutationCumulative = 0
			for MutationName, MutationChance in MutationOdds do
				MutationCumulative = MutationCumulative + MutationChance
				if MutationRoll <= MutationCumulative then
					SelectedMutation = MutationName
					break
				end
			end
		end
	end

	local AdminTraitsOverride = Data:Get("FuseMachine.AdminTraitsOverride")
	local SelectedTraits: {string} = {}

	if AdminTraitsOverride then
		SelectedTraits = AdminTraitsOverride
	else
		local TraitOdds = FuseMachine.OutputTraitsOdds or {}
		if next(TraitOdds) then
			for TraitName, TraitChance in TraitOdds do
				local TraitRoll = Random.new():NextNumber(0, 100)
				if TraitRoll <= TraitChance then
					table.insert(SelectedTraits, TraitName)
				end
			end
		end
	end

	if #SelectedTraits == 0 then SelectedTraits = nil end

	local Podiums = Data:Get("AnimalPodiums") or {}
	for PodiumIndex, PodiumData in Podiums do
		if type(PodiumData) == "table" and PodiumData.Machine and PodiumData.Machine.Type == "Fuse" then
			Podiums[PodiumIndex] = nil
		end
	end
	Data:Set("AnimalPodiums", Podiums)
	Data:Set("AnimalAddedOrRemoved", CurrentTime)

	Data:Set("FuseMachine", {
		OutputRarityOdds   = {},
		OutputTraitsOdds   = {},
		OutputMutationOdds = {},
		Cost               = nil,
		StartTime          = nil,
		FinishTime         = nil,
		FuseLuckMultiplier = 1,
		PercentOverride    = nil,
		AdminOverride      = nil,
		AdminMutationOverride = nil,
		AdminTraitsOverride = nil,
	})

	UpdateFuseMachineData(Player)
	ForceUpdate:FireClient(Player)

	local UniqueAnimalId = game:GetService("HttpService"):GenerateGUID(false)
	local fusetype = workspace:FindFirstChild("FuseMachine"):GetAttribute("FuseType")
	local Startpos = fusetype == "Witch" and workspace:FindFirstChild("Witch Fuse").SpawnZone or workspace:FindFirstChild("FuseMachine").SpawnZone

	UniqueAnimalId = AnimalService.spawnAnimalCustom(
		SelectedAnimalData,
		SelectedMutation,
		SelectedTraits,
		nil,
		{
			Start = Startpos,
			End = Plot.AnimalTarget,
			Owner = Player,
			AnimalId = UniqueAnimalId
		},
		0,
		true
	)

	game:GetService("RunService").Heartbeat:Wait()

	local animalmodel = workspace:WaitForChild(UniqueAnimalId, 5)
	if not animalmodel then
		warn("Animal model " .. UniqueAnimalId .. " failed to spawn!")
		return false, "Animal spawn timeout"
	end

	animalmodel:SetAttribute("ForceIdle", true)
	FuseAnimation:FireAllClients(SelectedBrainrot, UniqueAnimalId, CurrentTime, SelectedMutation, SelectedTraits)

	if fusetype ~= "Witch" then
		local spawnZone = Startpos
		local targetCFrame = spawnZone.CFrame * CFrame.new(0, -1, 0)
		animalmodel:PivotTo(targetCFrame)

		task.delay(0.2, function()
			if animalmodel and animalmodel.Parent then
				animalmodel:PivotTo(targetCFrame)

				task.delay(2.7, function()
					if animalmodel and animalmodel.Parent then
						animalmodel:SetAttribute("ForceIdle", false)
					end
				end)
			else
				warn("Animal model " .. UniqueAnimalId .. " timed out during animation!")
			end
		end)
	end

	return true
end

ClaimBrainrot.OnServerInvoke = function(Player)
	local Data = Synchronizer:Get(Player)
	local FuseMachine = Data:Get("FuseMachine")
	if workspace:GetServerTimeNow() < FuseMachine.FinishTime then
		return false, "Not finished"
	end
	return InternalClaim(Player)
end

RevealNow.OnServerEvent:Connect(function(Player: Player)
	local Data = Synchronizer:Get(Player)
	if not Data then return end

	local FuseMachine = Data:Get("FuseMachine")
	if not FuseMachine or not FuseMachine.StartTime or FuseMachine.StartTime == 0 then return end

	local InstantReveals = Data:Get("FuseMachine.InstantReveals") or 0
	if InstantReveals ~= 1000 then
		Data:Set("FuseMachine.InstantReveals", InstantReveals - 1)
		Data:Set("FuseMachine.FinishTime", workspace:GetServerTimeNow() - 1)
		UpdateFuseMachineData(Player)
	end
end)

function FuseMachineService:PurchaseRevealNow(Player: Player)
	local Data = Synchronizer:Get(Player)
	if not Data then return end

	local FuseMachine = Data:Get("FuseMachine")
	if not FuseMachine or not FuseMachine.StartTime or FuseMachine.StartTime == 0 then return end
	if FuseMachine.FinishTime and FuseMachine.FinishTime <= workspace:GetServerTimeNow() then return end

	Data:Set("FuseMachine.FinishTime", workspace:GetServerTimeNow() - 1)
	UpdateFuseMachineData(Player)
end

function FuseMachineService:SetMutationEvent(MutationName: string, IsActive: boolean)
	if IsActive then
		ActiveMutationEvents[MutationName] = true
	else
		ActiveMutationEvents[MutationName] = nil
	end
	for _, Player in Players:GetPlayers() do
		UpdateFuseMachineData(Player)
	end
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

local ForceRemote = Net:RemoteFunction("FuseMachineService/AdminForceFuse")
ForceRemote.OnServerInvoke = function(Player, AnimalName, Mutation, Trait)
	local TargetPlayer = Player
	if not TargetPlayer then return false, "Player not found" end
	if not AnimalsDB[AnimalName] then return false, "Invalid Animal Name" end

	local Data = Synchronizer:Get(TargetPlayer)
	local gamedata = require(ReplicatedStorage.GameData)
	local blacklisted = gamedata.UnSpawnableBrainrots
	if blacklisted[AnimalName] then
		NotificationService.Error(Player, AnimalName .. " is blacklisted!")
		return false
	end

	if Mutation ~= nil and Mutation ~= "" then
		if not Mutations[Mutation] then
			return false, "Invalid mutation: " .. tostring(Mutation)
		end
	else
		Mutation = nil
	end

	local TraitsList = nil
	if Trait ~= nil and Trait ~= "" then
		if string.lower(Trait) == "all" then
			TraitsList = {}
			for traitName, traitData in pairs(Traits) do
				if not traitData.Blacklisted then
					table.insert(TraitsList, traitName)
				end
			end
			if #TraitsList == 0 then TraitsList = nil end
		else
			TraitsList = {}
			for _, t in ipairs(string.split(Trait, ",")) do
				local trimmed = t:match("^%s*(.-)%s*$")
				if trimmed ~= "" then
					if not Traits[trimmed] then
						return false, "Invalid trait: " .. tostring(trimmed)
					end
					if Traits[trimmed].Blacklisted then
						return false, "Trait is blacklisted: " .. tostring(trimmed)
					end
					table.insert(TraitsList, trimmed)
				end
			end
			if #TraitsList == 0 then TraitsList = nil end
		end
	end

	if Data then
		Data:Set("FuseMachine.AdminOverride", AnimalName)
		Data:Set("FuseMachine.AdminMutationOverride", Mutation)
		Data:Set("FuseMachine.AdminTraitsOverride", TraitsList)

		local summary = AnimalName
		if Mutation then summary = summary .. " | Mutation: " .. Mutation end
		if TraitsList then summary = summary .. " | Traits: " .. table.concat(TraitsList, ", ") end
		return true, "Next fuse for " .. TargetPlayer.DisplayName .. " forced to: " .. summary
	end

	return false, "Data error"
end

local PercentOverrideRemote = Net:RemoteFunction("FuseMachineService/AdminPercentOverride")
PercentOverrideRemote.OnServerInvoke = function(Player, Animals, Chance1, Chance2, Chance3, Chance4)
	local TargetPlayer = Player
	if not TargetPlayer then return false, "Player not found" end

	local Data = Synchronizer:Get(TargetPlayer)
	if not Data then return false, "Data error" end

	local gamedata = require(ReplicatedStorage.GameData)
	local blacklisted = gamedata.UnSpawnableBrainrots

	if type(Animals) ~= "table" then
		return false, "Animals must be a table"
	end

	local Chances = {Chance1, Chance2, Chance3, Chance4}
	local ValidEntries = {}
	local TotalChance  = 0
	local SlotCount    = math.min(#Animals, 4)

	for i = 1, SlotCount do
		local AnimalName = Animals[i]
		local Chance     = Chances[i]

		if AnimalName == nil or AnimalName == "" then
			if Chance ~= nil and Chance ~= 0 then
				return false, "Slot " .. i .. ": has a chance but no animal name"
			end
		else
			if not AnimalsDB[AnimalName] then
				return false, "Invalid brainrot in slot " .. i .. ": " .. tostring(AnimalName)
			end
			if blacklisted[AnimalName] then
				NotificationService.Error(Player, AnimalName .. " is blacklisted!")
				return false, AnimalName .. " is blacklisted"
			end

			local NumChance = tonumber(Chance)
			if not NumChance or NumChance <= 0 then
				return false, "Slot " .. i .. ": chance must be a positive number"
			end

			TotalChance = TotalChance + NumChance
			table.insert(ValidEntries, { Name = AnimalName, Chance = NumChance })
		end
	end

	if #ValidEntries == 0 then return false, "Must supply at least one animal" end
	if TotalChance ~= 100 then return false, "Chances must sum to 100 (got " .. TotalChance .. ")" end

	local OverrideOdds = {}
	for _, Entry in ipairs(ValidEntries) do
		OverrideOdds[Entry.Name] = Entry.Chance
	end

	Data:Set("FuseMachine.PercentOverride", OverrideOdds)
	UpdateFuseMachineData(Player)

	local Summary = {}
	for _, Entry in ipairs(ValidEntries) do
		table.insert(Summary, Entry.Name .. " (" .. Entry.Chance .. "%)")
	end

	return true, "Set fuse to " .. TargetPlayer.DisplayName .. ": " .. table.concat(Summary, ", ")
end

return FuseMachineService