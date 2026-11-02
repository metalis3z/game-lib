--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
local FuseMachineService = {}
--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
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
--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
local RemoveBrainrot = FuseMachineData.Remotes.RemoveBrainrot
local ClaimBrainrot = FuseMachineData.Remotes.ClaimBrainrot
local ConfirmFusion = FuseMachineData.Remotes.ConfirmFusion
local Delivery = FuseMachineData.Remotes.Delivery
local RevealNow = FuseMachineData.Remotes.RevealNow
local FuseAnimation = FuseMachineData.Remotes.FuseAnimation
local ForceUpdate = FuseMachineData.Remotes.ForceUpdate
--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
local FUSION_BRAINROTS = require(game:GetService("ServerStorage").Modules.FuseData).Brainrots
local ClaimingPlayers = {}
local RARITY_ORDER = {"Common", "Rare", "Epic", "Legendary", "Mythic", "Brainrot God", "Secret", "OG"}
local SECRET_POOL = {"Griffin", "Los Cupids", "Cigno Fulgoro", "Serafinna Medusella", "Paradiso Axolottino"}
local function RefreshAnimalsDB()
	AnimalsDB = require(ReplicatedStorage.Datas.Animals)
end
--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
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
	for PodiumIndex, PodiumData in pairs(Podiums) do
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
--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
local function CalculateFusionOdds(Podiums)
	local BrainrotsInMachine = {}
	local RarityCount = {}
	local AverageTier = 0
	local InsertedGenerations = {}
	local TotalGeneration = 0
	local MaxGeneration = 0
	local hasKetupatKepat = 0
	local hasGingerGerat = 0
	for _, PodiumData in pairs(Podiums) do
		if type(PodiumData) == "table" and 
			PodiumData.Machine and 
			PodiumData.Machine.Type == "Fuse" then
			local AnimalName = PodiumData.Index
			local AnimalData = AnimalsDB[AnimalName]
			if AnimalData then
				local Tier = GetRarityTier(AnimalData.Rarity)
				local Gen = AnimalData.Generation or 0

				table.insert(BrainrotsInMachine, {
					Name = AnimalName,
					Rarity = AnimalData.Rarity,
					Generation = Gen
				})
				if AnimalName == "Ketupat Kepat" then
					hasKetupatKepat = hasKetupatKepat + 1
				elseif AnimalName == "Ginger Gerat" then
					hasGingerGerat = hasGingerGerat + 1
				end
				RarityCount[AnimalData.Rarity] = (RarityCount[AnimalData.Rarity] or 0) + 1
				AverageTier = AverageTier + Tier
				table.insert(InsertedGenerations, Gen)
				TotalGeneration = TotalGeneration + Gen
				if Gen > MaxGeneration then
					MaxGeneration = Gen
				end
			end
		end
	end
	if #BrainrotsInMachine == 0 then
		return {}, {}
	end
	--Secret Recipe :)
	local targetRecipeAnimal = "Ketupat Bros"
	if AnimalsDB[targetRecipeAnimal] then
		if hasKetupatKepat >= 1 and hasGingerGerat >= 1 and #BrainrotsInMachine == 2 then
			local OutputOdds = {
				[targetRecipeAnimal] = 100
			}
			local RarityOdds = {
				[AnimalsDB[targetRecipeAnimal].Rarity] = 100
			}
			return OutputOdds, RarityOdds
		end
		--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
		if #BrainrotsInMachine == 1 and (hasKetupatKepat == 1 or hasGingerGerat == 1) then
			local OutputOdds = {
				[targetRecipeAnimal] = 50
			}
			local targetRarity = AnimalsDB[targetRecipeAnimal].Rarity
			local RarityOdds = {
				[targetRarity] = 50
			}
			return OutputOdds, RarityOdds
		end
	end--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	AverageTier = AverageTier / #BrainrotsInMachine
	local DominantTier = math.round(AverageTier)
	DominantTier = math.clamp(DominantTier, 1, #RARITY_ORDER)
	local DominantRarity = RARITY_ORDER[DominantTier]
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	local NextRarity = GetNextRarity(DominantRarity)

	--Dominant Rarity
	if DominantRarity == "Secret" then
		local OutputOdds = {}

		--Generation (Income) not price
		local MaxGen = MaxGeneration

		OutputOdds = {
			["La Grande Combinasion"] = 92,
			["Los Mi Gatitos"] = 4,
			["Ketupat Kepat"] = 2,
			["Dragon Cannelloni"] = 1,
			["Garama and Madundung"] = 1
		}

		local RarityOdds = { ["Secret"] = 100 }
		return OutputOdds, RarityOdds
	end

	if DominantRarity == "OG" then
		local OutputOdds = {
			["Noobini Pizzanini"] = 68.74,
			["Skibidi Toilet"] = 27.76,
			["Meowl"] = 2,
			["John Pork"] = 1,
			["Strawberry Elephant"] = 0.5,
			["Spyder Elephant"] = 0.2
		}

		local RarityOdds = {
			["OG"] = 100
		}

		return OutputOdds, RarityOdds
	end

	-- FOR THE REST OF BRAINROTS WE USE FUSION_BRAINROTS
	NextRarity = GetNextRarity(DominantRarity)
	local SameRarityFusions = {}
	local NextRarityFusions = {}
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	for _, FusionName in ipairs(FUSION_BRAINROTS) do
		local FusionData = AnimalsDB[FusionName]
		if FusionData then
			if DominantRarity == "Brainrot God" then
				if FusionName == "Serafinna Medusella" or FusionName == "Cigno Fulgoro" or FusionName == "Los Cupids" or FusionName == "La Food Combinasion" or FusionName == "Celestial Pegasus" or FusionName == "Griffin" then
					continue
				end
			end
			--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
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
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	table.sort(SameRarityFusions, function(A, B) return A.Generation > B.Generation end)
	table.sort(NextRarityFusions, function(A, B) return A.Generation < B.Generation end)
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	local MinNextChance = 10
	local MaxNextChance = 50
	local NextChance = MinNextChance + (MaxNextChance - MinNextChance) * ((AverageTier - 1) / (#RARITY_ORDER - 1))
	NextChance = math.floor(NextChance)
	local SameChance = 100 - NextChance
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	local OutputOdds = {}
	local RarityOdds = {}
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	if #SameRarityFusions > 0 and SameChance > 0 then
		local TotalGenSame = 0
		for _, Fusion in ipairs(SameRarityFusions) do TotalGenSame = TotalGenSame + Fusion.Generation end
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
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	local NumNextToInclude = 1
	if #NextRarityFusions > 0 then
		local WorstNextGen = NextRarityFusions[1].Generation
		local MaxInsertedGen = math.max(unpack(InsertedGenerations))
		if MaxInsertedGen < WorstNextGen then
			NumNextToInclude = math.min(2, #NextRarityFusions)
		end
	end
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	if #NextRarityFusions > 0 and NextChance > 0 then
		local IncludedNext = {}
		for i = 1, NumNextToInclude do table.insert(IncludedNext, NextRarityFusions[i]) end
		table.sort(IncludedNext, function(A, B) return A.Generation > B.Generation end)
		local TotalGenNext = 0
		for _, Fusion in ipairs(IncludedNext) do TotalGenNext = TotalGenNext + Fusion.Generation end
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
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	for Name, Chance in pairs(OutputOdds) do
		local AnimalData = AnimalsDB[Name]
		if AnimalData then
			RarityOdds[AnimalData.Rarity] = (RarityOdds[AnimalData.Rarity] or 0) + Chance
		end
	end
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	return OutputOdds, RarityOdds
end

local EVENT_MUTATION_MAP = {
	BloodmoonEvent = "Bloodrot",
	CandyEvent = "Candy",
	MoltenEvent = "Lava",
	GalaxyEvent = "Galaxy",
	YinYangEvent = "YinYang",
	RadioactiveEvent = "Radioactive",
	CursedEvent = "Cursed",
	DivineEvent = "Divine"
}
--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
local function GetMutationOddsFromMachine(BrainrotsInMachine)
	local MutationCount = {}
	local TotalMutations = 0
	local HasGold, HasDiamond, HasRainbow, HasRadioactive = false, false, false, false
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	for _, BrainrotData in BrainrotsInMachine do
		local m = BrainrotData.Mutation
		if m then
			MutationCount[m] = (MutationCount[m] or 0) + 1
			TotalMutations += 1
			if m == "Gold" then HasGold = true
			elseif m == "Diamond" then HasDiamond = true
			elseif m == "Rainbow" then HasRainbow = true
			elseif m == "Radioactive" then HasRadioactive = true
			end
		end
	end
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	local MutationOdds = {}
	if HasGold then MutationOdds.Gold = 15 end
	if HasDiamond then MutationOdds.Diamond = 10 end
	if HasRainbow then MutationOdds.Rainbow = 5 end
	if HasRadioactive or ReplicatedStorage:GetAttribute("RadioactiveEvent") then MutationOdds.Radioactive = 10 end

	for attributeName, mutationName in pairs(EVENT_MUTATION_MAP) do
		if ReplicatedStorage:GetAttribute(attributeName) then
			MutationOdds[mutationName] = MutationOdds[mutationName] or 10
		end
	end
	local total = 0
	for _, chance in pairs(MutationOdds) do total += chance end
	if total > 100 then
		local scale = 100 / total
		for name, chance in pairs(MutationOdds) do
			MutationOdds[name] = math.floor(chance * scale)
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
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	local TraitOdds = {}
	if TotalTraits == 0 then return TraitOdds end

	for TraitName, Count in pairs(TraitCount) do
		local BaseChance = 10 + (10 * (Count - 1) / TotalTraits)
		TraitOdds[TraitName] = math.clamp(BaseChance, 10, 20)
	end
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	local TotalChance = 0
	for _, Chance in pairs(TraitOdds) do TotalChance = TotalChance + Chance end
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

	local MutationOdds = GetMutationOddsFromMachine(BrainrotsInMachine)
	Data:Set("FuseMachine.OutputMutationOdds", MutationOdds)

	local OutputOdds = {}
	local RarityOdds = {}
	if #BrainrotsInMachine > 0 then
		OutputOdds, RarityOdds = CalculateFusionOdds(Podiums)
	end
	Data:Set("FuseMachine.OutputRarityOdds", OutputOdds)
	local TraitOdds = GetTraitOddsFromMachine(BrainrotsInMachine)
	Data:Set("FuseMachine.OutputTraitsOdds", TraitOdds)
	if #BrainrotsInMachine == FuseMachineData.FuseSlots then
		Data:Set("FuseMachine.Cost", CalculateFuseCost(BrainrotsInMachine))
	else
		Data:Set("FuseMachine.Cost", nil)
	end
	ForceUpdate:FireClient(Player)
end
--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
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
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	PodiumData.Machine = nil
	Podiums[PodiumIndex] = PodiumData
	Data:Set("AnimalPodiums", Podiums)
	Data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

	UpdateFuseMachineData(Player)
	return true
end
--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
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
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	local BrainrotsInMachine = GetBrainrotsInMachine(Podiums)

	if #BrainrotsInMachine >= FuseMachineData.FuseSlots then
		NotificationService.Error(Player, string.format("Fuse Machine can only hold %d Brainrots", FuseMachineData.FuseSlots))
		StealService:CancelSteal(Player)
		return false
	end

	local StolenAnimalData = StealData.StolenAnimalData
	local TraitsList = StolenAnimalData.Traits
	if TraitsList and #TraitsList == 0 then TraitsList = nil end

	local OriginalPodiumIndex = StealData.PodiumIndex
	if OriginalPodiumIndex and Podiums[OriginalPodiumIndex] then
		local ExistingPodium = Podiums[OriginalPodiumIndex]
		ExistingPodium.Machine = { Type = "Fuse", Active = false }
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
		--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
		Podiums[AvailableSlot] = {
			IndexOnPlot = OriginalPodiumIndex or AvailableSlot,
			Index = AnimalName,
			LastCollect = StolenAnimalData.LastCollect or workspace:GetServerTimeNow(),
			OfflineGain = StolenAnimalData.OfflineGain or nil,
			Mutation = StolenAnimalData.Mutation,
			Traits = TraitsList,
			Machine = { Type = "Fuse", Active = false }
		}
	end
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	Data:Set("AnimalPodiums", Podiums)
	Data:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

	-- Effacer les flags Steal/Stolen de l'AnimalList du plot
	local playerPlot = _G.playerPlots[Player.UserId]
	if playerPlot then
		local plotChannel = Synchronizer:Get(playerPlot.Name)
		if plotChannel and OriginalPodiumIndex then
			plotChannel:Set(string.format("AnimalList.%d.Steal", OriginalPodiumIndex), false)
			plotChannel:Set(string.format("AnimalList.%d.Stolen", OriginalPodiumIndex), false)
			plotChannel:Set(string.format("AnimalList.%d.StealText", OriginalPodiumIndex), "")
		end
	end

	StealService:CancelSteal(Player, nil, true) -- true = skip restore, car le brainrot est dans la fusée

	local AnimalData = AnimalsDB[AnimalName]
	local RarityName = AnimalData and AnimalData.Rarity
	local RarityData = RarityName and Rarities[RarityName]
	local Color = RarityData and RarityData.Color
	local ColoredAnimalName = AnimalName

	if Color and typeof(Color) == "Color3" then
		local Hex = string.format("#%02X%02X%02X", math.floor(Color.R*255), math.floor(Color.G*255), math.floor(Color.B*255))
		ColoredAnimalName = string.format('<font color="%s">%s</font>', Hex, (AnimalData and AnimalData.DisplayName) or AnimalName)
	end
	--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
	NotificationService.Notify(Player, string.format("You have added %s to Fuse Machine!", ColoredAnimalName), 5, "Sounds.Sfx.Success")
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
	local OutputOdds = FuseMachine.OutputRarityOdds or {}

	if #BrainrotsInMachine ~= FuseMachineData.FuseSlots then
		return false, string.format("Need exactly %d Brainrots to fuse", FuseMachineData.FuseSlots)
	end

	if not next(OutputOdds) then
		return false, "Invalid fusion combination"
	end

	local Coins = Data:Get("Coins") or 0
	if Coins < FuseMachine.Cost then
		return false, "Not enough coins"
	end

	local HighestRarity = "Common"
	local HighestWeight = 0

	for BrainrotName, Chance in pairs(FuseMachine.OutputRarityOdds) do
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
	if ClaimingPlayers[Player] then return false, "Already claiming" end

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

	-- Prevent double-claiming
	ClaimingPlayers[Player] = true

	-- Capture OutputRarityOdds BEFORE any modifications
	local OutputOdds = FuseMachine.OutputRarityOdds or {}

	-- If OutputRarityOdds is empty, recalculate from current podiums before clearing them
	if not next(OutputOdds) then
		RefreshAnimalsDB()
		local CurrentPodiums = Data:Get("AnimalPodiums") or {}
		local CurrentBrainrots = GetBrainrotsInMachine(CurrentPodiums)
		if #CurrentBrainrots > 0 then
			OutputOdds = CalculateFusionOdds(CurrentPodiums)
		end
	end

	if not next(OutputOdds) then
		-- Still empty after recalculation — reset and return
		local Podiums = Data:Get("AnimalPodiums") or {}
		for PodiumIndex, PodiumData in Podiums do
			if type(PodiumData) == "table" and PodiumData.Machine and PodiumData.Machine.Type == "Fuse" then
				Podiums[PodiumIndex] = "Empty"
			end
		end
		Data:Set("AnimalPodiums", Podiums)
		Data:Set("AnimalAddedOrRemoved", CurrentTime)
		Data:Set("FuseMachine", {
			OutputRarityOdds = {}, OutputTraitsOdds = {}, OutputMutationOdds = {},
			Cost = nil, StartTime = nil, FinishTime = nil, FuseLuckMultiplier = 1, ForcedBrainrot = nil
		})
		ForceUpdate:FireClient(Player)
		UpdateFuseMachineData(Player)
		ClaimingPlayers[Player] = nil
		return false, "Failed"
	end

	-- IMMEDIATELY reset FinishTime to prevent double-claiming
	Data:Set("FuseMachine.FinishTime", 0)

	-- Clear podiums
	local Podiums = Data:Get("AnimalPodiums") or {}
	for PodiumIndex, PodiumData in Podiums do
		if type(PodiumData) == "table" and PodiumData.Machine and PodiumData.Machine.Type == "Fuse" then
			Podiums[PodiumIndex] = "Empty"
		end
	end
	Data:Set("AnimalPodiums", Podiums)
	Data:Set("AnimalAddedOrRemoved", CurrentTime)

	local SelectedBrainrot = nil
	local SelectedMutation: string? = nil
	local SelectedTraits: {string} = {}

	local ForcedBrainrot = FuseMachine.ForcedBrainrot

	if ForcedBrainrot and type(ForcedBrainrot) == "table" and ForcedBrainrot.Animal and AnimalsDB[ForcedBrainrot.Animal] then
		SelectedBrainrot = ForcedBrainrot.Animal
		SelectedMutation = ForcedBrainrot.Mutation
		SelectedTraits = ForcedBrainrot.Traits
	else
		local RandomValue = Random.new():NextNumber(0, 100)
		local CumulativeChance = 0

		for BrainrotName, Chance in pairs(OutputOdds) do
			CumulativeChance = CumulativeChance + Chance
			if not SelectedBrainrot and RandomValue <= CumulativeChance then
				SelectedBrainrot = BrainrotName
			end
		end

		if not SelectedBrainrot then
			for BrainrotName in pairs(OutputOdds) do
				SelectedBrainrot = BrainrotName
				break
			end
		end
		if not SelectedBrainrot or not AnimalsDB[SelectedBrainrot] then
			-- Fallback: pick a random brainrot from the secret pool or fusion brainrots
			if #SECRET_POOL > 0 then
				SelectedBrainrot = SECRET_POOL[math.random(1, #SECRET_POOL)]
			elseif #FUSION_BRAINROTS > 0 then
				SelectedBrainrot = FUSION_BRAINROTS[math.random(1, #FUSION_BRAINROTS)]
			end

			-- If still no valid selection, reset and return
			if not SelectedBrainrot or not AnimalsDB[SelectedBrainrot] then
				Data:Set("FuseMachine", {
					OutputRarityOdds = {}, OutputTraitsOdds = {}, OutputMutationOdds = {},
					Cost = nil, StartTime = nil, FinishTime = nil, FuseLuckMultiplier = 1, ForcedBrainrot = nil
				})
				ForceUpdate:FireClient(Player)
				UpdateFuseMachineData(Player)
				ClaimingPlayers[Player] = nil
				return true
			end
		end
	end

	local SelectedAnimalData = AnimalsDB[SelectedBrainrot]
	if not SelectedAnimalData then
		Data:Set("FuseMachine", {
			OutputRarityOdds = {}, OutputTraitsOdds = {}, OutputMutationOdds = {},
			Cost = nil, StartTime = nil, FinishTime = nil, FuseLuckMultiplier = 1, ForcedBrainrot = nil
		})
		ForceUpdate:FireClient(Player)
		UpdateFuseMachineData(Player)
		ClaimingPlayers[Player] = nil
		return false, "Error"
	end

	local MutationOdds = FuseMachine.OutputMutationOdds or {}
	if not ForcedBrainrot and next(MutationOdds) then
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

	local TraitOdds = FuseMachine.OutputTraitsOdds or {}
	if not ForcedBrainrot and next(TraitOdds) then
		for TraitName, TraitChance in TraitOdds do
			local TraitRoll = Random.new():NextNumber(0, 100)
			if TraitRoll <= TraitChance then
				table.insert(SelectedTraits, TraitName)
			end
		end
	end
	if SelectedTraits and #SelectedTraits == 0 then SelectedTraits = nil end

	-- FULL RESET of FuseMachine BEFORE spawning (so even if spawn fails, machine is properly reset)
	Data:Set("FuseMachine", {
		OutputRarityOdds = {}, OutputTraitsOdds = {}, OutputMutationOdds = {},
		Cost = nil, StartTime = nil, FinishTime = nil, FuseLuckMultiplier = 1, ForcedBrainrot = nil
	})
	UpdateFuseMachineData(Player)
	ForceUpdate:FireClient(Player)

	-- NOW spawn the animal (use workspace.FuseMachine, NOT ReplicatedStorage.FuseMachine which is a ScreenGui)
	local FuseMachineModel = workspace:FindFirstChild("FuseMachine")
	local SpawnZone = FuseMachineModel and FuseMachineModel:FindFirstChild("SpawnZone") or nil

	FuseAnimation:FireAllClients(Player, SelectedBrainrot, CurrentTime, CurrentTime)

	AnimalService.spawnAnimalCustom(SelectedAnimalData, SelectedMutation, SelectedTraits, nil, {
		Start = SpawnZone,
		End = Plot.AnimalTarget,
		Owner = Player
	})

	ClaimingPlayers[Player] = nil
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

	Data:Set("FuseMachine.FinishTime", workspace:GetServerTimeNow())

	task.spawn(function()
		ClaimBrainrot.OnServerInvoke(Player)
	end)
end
function FuseMachineService:ReplaceSecretFusion(oldName, newName)
	-- Refresh AnimalsDB to ensure we have the latest data
	RefreshAnimalsDB()

	-- Verify the new brainrot exists
	if not AnimalsDB[newName] then
		return false, "New brainrot not found in Animals database."
	end

	-- Find and replace in the secret pool
	local found = false
	for i, name in ipairs(SECRET_POOL) do
		if name == oldName then
			SECRET_POOL[i] = newName
			found = true
			break
		end
	end

	if not found then
		return false, "Old name not found in secret fusion pool."
	end
	for i, name in ipairs(FUSION_BRAINROTS) do
		if name == oldName then
			FUSION_BRAINROTS[i] = newName
			break
		end
	end
	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(function()
			UpdateFuseMachineData(player)
		end)
	end

	return true
end
--THIS SCRIPT WAS MADE BY WILLY ONLY LEAK WITH CREDIT!!!
function FuseMachineService:Start()
	for _, Player in Players:GetChildren() do
		local Data = Synchronizer:Wait(Player)
		if Data then
			local FuseMachine = Data:Get("FuseMachine")
			if not FuseMachine then
				Data:Set("FuseMachine", {
					OutputRarityOdds = {}, OutputTraitsOdds = {}, OutputMutationOdds = {},
					Cost = 0, StartTime = 0, FinishTime = 0, FuseLuckMultiplier = 1
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
					OutputRarityOdds = {}, OutputTraitsOdds = {}, OutputMutationOdds = {},
					Cost = 0, StartTime = 0, FinishTime = 0, FuseLuckMultiplier = 1
				})
			end
			UpdateFuseMachineData(Player)
		end
	end)
end

function FuseMachineService:ForceUpdateAll()
	for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
		UpdateFuseMachineData(player)
	end
end

return FuseMachineService