--!native

local AdminPanel = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local DatastoreService = game:GetService("DataStoreService")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService") 
local CollectionService = game:GetService("CollectionService")

local DefaultStats = require(ServerScriptService.Components.DefaultStats)
local PlotService = require(ServerScriptService.Services.PlotService)
local EventService = require(ServerScriptService.Services.EventService)
local SpeedService = require(ServerScriptService.Services.SpeedService)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local DataService = require(ServerScriptService.Services.DataService)

local Net = require(ReplicatedStorage.Packages.Net)
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)
local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local MutationsData = require(ReplicatedStorage.Datas.Mutations)
local TraitsData = require(ReplicatedStorage.Datas.Traits)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local RebirthData = require(ReplicatedStorage.Datas.Rebirth)
local BasesData = require(ReplicatedStorage.Datas.Bases)
local SharedGame = require(ReplicatedStorage.Shared.Game)
local RaritiesData = require(ReplicatedStorage.Datas.Rarities)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)

local SpawnBrainrot = Net:RemoteFunction("AdminService/SpawnBrainrot")
local SpawnBrainrotInBase = Net:RemoteFunction("AdminService/SpawnBrainrotInBase")
local Morph = Net:RemoteFunction("AdminService/Morph")
local UnMorph = Net:RemoteFunction("AdminService/UnMorph")
local AlertErrors = Net:RemoteEvent("AdminService/AlertErrors")
local StartEvent = Net:RemoteFunction("AdminService/StartEvent")
local StopEvent = Net:RemoteFunction("AdminService/StopEvent")
local GiveMoney = Net:RemoteFunction("AdminService/GiveMoney")
local GiveRebirth = Net:RemoteFunction("AdminService/GiveRebirth")
local ResetData = Net:RemoteEvent("AdminService/ResetData")
local PlayerMorph = Net:RemoteEvent("AdminService/PlayerMorph")
local GiveTool = Net:RemoteEvent("AdminService/GiveTool")
local GiveSteal = Net:RemoteFunction("AdminService/GiveSteal")
local SaveKey = Net:RemoteEvent("AdminService/SaveKey")
local ResetKeys = Net:RemoteEvent("AdminService/ResetKeys")
local GiveMulti = Net:RemoteFunction("AdminService/GiveMulti")
local ResetBrainrots = Net:RemoteFunction("AdminService/ResetBrainrots")

--extras start
local SetLuckyChance = Net:RemoteFunction("AdminService/SetLuckyBlockChance")
local SetLucky = Net:RemoteEvent("AdminService/SetLuckyBlock")
local UnlockIndex = Net:RemoteFunction("AdminService/UnlockIndex")
local SpawnBrainrotInBoat = Net:RemoteFunction("AdminService/SpawnBrainrotInBoat") 
--extras end

local WhitelistedUsers = {}

local ActiveMorphs = {}
local Cooldowns = {
	SpawnBrainrot = {
		Time = 0,
		GamepassTime = 0,
		VIPCooldownGamepass = 0,
		List = {},
		WhitelistedUsers = WhitelistedUsers,
	},
	SpawnBrainrotInBase = {
		Time = 0,
		GamepassTime = 0,
		List = {},
		WhitelistedUsers = WhitelistedUsers,
	},
	SpawnBrainrotInBoat = {
		Time = 0,
		GamepassTime = 0,
		List = {},
		WhitelistedUsers = WhitelistedUsers,
	},
	Morph = {
		Time = 0,
		GamepassTime = 0,
		List = {},
		WhitelistedUsers = WhitelistedUsers,
		RequiresPurchase = false,
	},
	UnMorph = {
		Time = 0,
		GamepassTime = 0,
		List = {},
		WhitelistedUsers = WhitelistedUsers,
	},
	Keybinds = {
		WhitelistedUsers = WhitelistedUsers,
		RequiresPurchase = false,
	},
	StartEvent = {
		Time = 0,
		GamepassTime = 0,
		VIPCooldownGamepass = 0,
		List = {},
		WhitelistedUsers = WhitelistedUsers,
		RequiresPurchase = false,
	},
	PlayerMorph = {
		Time = 0,
		GamepassTime = 0,
		List = {},
		WhitelistedUsers = WhitelistedUsers,
	},
	GiveTool = {
		Time = 0,
		GamepassTime = 0,
		List = {},
		WhitelistedUsers = WhitelistedUsers,
	},
}

local CurrentAdminPanel = 0
local ADMIN_PANELS = {
	CurrentAdminPanel
}

local function OwnsAdminPlus(Player: Player): boolean
	return true
end

function HandleCooldown(Player: Player, CooldownType: string): (boolean, string?)
	return true
end

function OwnsGamepass(Player: Player, Type: string?): boolean
	return true
end

function CleanupMorph(Player: Player)
	local MorphData = ActiveMorphs[Player.UserId]
	if not MorphData then
		return
	end

	if MorphData.connection then
		MorphData.connection:Disconnect()
	end

	if MorphData.idleModel and MorphData.idleModel.Parent then
		MorphData.idleModel:Destroy()
	end

	if MorphData.walkModel and MorphData.walkModel.Parent then
		MorphData.walkModel:Destroy()
	end

	if MorphData.speedConnection then
		MorphData.speedConnection:Disconnect()
	end

	local Character = Player.Character
	if Character then
		for _, Part: Instance in pairs(Character:GetDescendants()) do
			if Part:IsA("BasePart") and Part.Name ~= "HumanoidRootPart" then
				Part.Transparency = 0
			elseif Part:IsA("Decal") then
				Part.Transparency = 0
			end
		end
	end

	ActiveMorphs[Player.UserId] = nil
end

ResetKeys.OnServerEvent:Connect(function(Player)
	local Data = Synchronizer:Get(Player)
	if Data then
		Data:Set("Keybinds", {})  -- clears all keybinds
	end
end)


local function OnPlayerRemoving(Player: Player)
	local UserId = Player.UserId

	CleanupMorph(Player)

	for _, Data in pairs(Cooldowns) do
		if Data.List and Data.List[UserId] then
			task.delay(Data.Time, function()
				Data.List[UserId] = nil
			end)
		end
	end
end
local function SpawnAuraBoat(animalName)
	local Road = workspace:WaitForChild("Road", 10)
	if not Road then return false, "Road model not found." end

	local StartPart = Road:FindFirstChild("Start")
	local EndPart = Road:FindFirstChild("End")
	if not StartPart or not EndPart then return false, "Road points missing." end

	local boatPart = Instance.new("Part")
	boatPart.Name = "AuraBoat"
	boatPart.Anchored = true
	boatPart.CanCollide = false
	boatPart.Size = Vector3.new(4, 1, 4)
	boatPart.Transparency = 1
	boatPart.CFrame = StartPart.CFrame
	boatPart.Parent = workspace
	local animalData = AnimalsData[animalName]
	if not animalData then return false, "Animal not found." end

	local spawnedAnimal = AnimalService.spawnAnimalImmediate(animalData)
	if not spawnedAnimal then return false, "Failed to spawn animal." end
	if spawnedAnimal:IsA("Model") then
		spawnedAnimal:PivotTo(boatPart.CFrame * CFrame.new(0, 2, 0))
		spawnedAnimal.Parent = boatPart 
	end
	CollectionService:AddTag(boatPart, "IndonesiaCanoe")

	local targetForTag = (spawnedAnimal:IsA("Model") and spawnedAnimal.PrimaryPart) or spawnedAnimal
	if targetForTag then
		CollectionService:AddTag(targetForTag, "IndonesiaCanoe")
	end

	local distance = (EndPart.Position - StartPart.Position).Magnitude
	local speed = 10 
	local duration = distance / speed
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)

	local goalCFrame = CFrame.new(EndPart.Position, EndPart.Position + (EndPart.Position - StartPart.Position).Unit)

	local tween = TweenService:Create(boatPart, tweenInfo, {CFrame = goalCFrame})

	local connection
	connection = RunService.Heartbeat:Connect(function()
		if boatPart and boatPart.Parent and spawnedAnimal and spawnedAnimal.Parent then
			if spawnedAnimal:IsA("Model") then
				spawnedAnimal:PivotTo(boatPart.CFrame * CFrame.new(0, 1, 0))
			end
		else
			connection:Disconnect()
		end
	end)

	tween:Play()

	-- 6. Cleanup
	tween.Completed:Once(function()
		connection:Disconnect()
		boatPart:Destroy()
		if spawnedAnimal then spawnedAnimal:Destroy() end
	end)

	return true
end

-- Updated RemoteFunction to accept the Animal Name
function SpawnBrainrotInBoat.OnServerInvoke(Player: Player, Name: string): (boolean, string?)
	local Owns = OwnsGamepass(Player, "SpawnAuraBoat")
	if not Owns then
		return false, "You do not have permission to spawn the Aura Boat."
	end

	local Success, CooldownMessage = HandleCooldown(Player, "SpawnAuraBoat")
	if not Success then
		return false, CooldownMessage
	end

	-- Ensure a name was provided
	if not Name or Name == "" then
		return false, "Please select an animal to spawn in the boat."
	end

	local BoatSuccess, BoatMessage = SpawnAuraBoat(Name)

	if BoatSuccess then
		return true, "Successfully spawned " .. Name .. " in the Aura Boat!"
	else
		return false, BoatMessage or "Failed to spawn Aura Boat."
	end
end

function GiveMoney.OnServerInvoke(Player: Player, Amount: number, AddMode: boolean?): (boolean, string?)
	-- Validate the amount
	if type(Amount) ~= "number" or Amount <= 0 then
		return false, "Amount must be a positive number."
	end

	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		return false, "Failed to get save."
	end

	local CurrentCoins = PlayerChannel:Get("Coins") or 0

	if AddMode then
		PlayerChannel:Set("Coins", CurrentCoins + Amount)
	else
		PlayerChannel:Set("Coins", Amount)
	end

	return true
end


local PlotService = require(ServerScriptService.Services.PlotService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

function GiveMulti.OnServerInvoke(Player: Player, Amount: number, AddMode: boolean?): (boolean, string?)
	if type(Amount) ~= "number" or Amount <= 0 then
		return false, "Amount must be a positive number."
	end

	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		return false, "Failed to get save."
	end

	local CurrentMultiplier = PlayerChannel:Get("Multiplier") or 1

	local NewMultiplier = AddMode and (CurrentMultiplier + Amount) or Amount

	PlayerChannel:Set("Multiplier", NewMultiplier)

	local Plot = PlotService.getPlot(Player)
	if Plot and Plot:FindFirstChild("Multiplier") and Plot.Multiplier:FindFirstChild("Main") then
		local AmountLabel = Plot.Multiplier.Main:FindFirstChild("Amount")
		if AmountLabel and AmountLabel:IsA("TextLabel") then
			AmountLabel.Text = string.format("x%d", NewMultiplier)
		end
	end

	return true
end



-- NEW: Handle SaveKey
SaveKey.OnServerEvent:Connect(function(Player: Player, KeyName: string, KeyValue: string)
	local Data = Synchronizer:Get(Player)
	if Data then
		local Keybinds = Data:Get("Keybinds") or {}
		Keybinds[KeyName] = KeyValue
		Data:Set("Keybinds", Keybinds)
	end
end)

-- NEW: Handle GiveSteal
function GiveSteal.OnServerInvoke(Player: Player, Amount: number, AddMode: boolean?)
	local Data = Synchronizer:Get(Player)
	if not Data then
		return false, "Failed to get player save."
	end

	Amount = tonumber(Amount)
	if not Amount or Amount <= 0 then
		return false, "Invalid amount."
	end

	local Coins = Data:Get("Steals") or 0

	if AddMode then
		Data:Set("Steals", Coins + Amount)
	else
		Data:Set("Steals", Amount)
	end

	return true
end

function ResetBrainrots.OnServerInvoke(Player: Player, Amount: number, AddMode: boolean?)

	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		return false
	end

	local AnimalList = PlayerChannel:Get("AnimalPodiums")
	if not AnimalList then
		return false
	end

	for index, slot in ipairs(AnimalList) do

		if typeof(slot) == "table" then

			if not slot.Steal then
				AnimalList[index] = "Empty"
			end
		end
	end

	PlayerChannel:Set("AnimalPodiums", AnimalList)
	PlayerChannel:Set("AnimalAddedOrRemoved", true)

	return true
end




-- new features start
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DataManagement = require(ServerScriptService.Services.DataManagment)
local Animals = require(ReplicatedStorage.Datas.Animals)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local cooldowns = {}
local COOLDOWN_TIME = 30000

function UnlockIndex.OnServerInvoke(player: Player, indexName: string)
	local userId = player.UserId

	if cooldowns[userId] then
		return false, "Rejoin to use this again!"
	end

	local animalNames = {}
	for name in pairs(Animals) do
		table.insert(animalNames, name)
	end

	for _, animalName in ipairs(animalNames) do
		DataManagement.addToIndex(player, animalName, indexName)
	end

	local profile = DataManagement.GetDataMan(player)
	local sync = Synchronizer:Get(player)
	if sync and profile and profile.Data and profile.Data.Index then
		sync:Set("Index", profile.Data.Index)
	end

	cooldowns[userId] = os.time()

	return true, string.format("✅ Successfully unlocked index for %s!", indexName)
end



-- 2nd

function SetLuckyChance.OnServerInvoke(player: Player, luckyBlockName: string, animalName: string, chanceText: string)
	local chance = tonumber(chanceText)
	if not chance then
		return false, "Chance must be a number!"
	end

	if chance < 0 or chance > 100 then
		return false, "Chance must be between 0 and 100!"
	end

	local LuckyBlocks = require(game.ReplicatedStorage.Datas.LuckyBlocks)
	local block = LuckyBlocks[luckyBlockName]
	if not block then
		return false, "Lucky Block not found!"
	end

	local found = false

	-- First, try to find the animal
	for _, animal in pairs(block.Animals) do
		if animal.Name == animalName then
			animal.Chance = chance
			found = true
			break
		end
	end

	-- If not found, add it
	if not found then
		table.insert(block.Animals, { Name = animalName, Chance = chance })
	end

	-- Double-check that the animal exists and has the correct chance
	local verified = false
	for _, animal in pairs(block.Animals) do
		if animal.Name == animalName and animal.Chance == chance then
			verified = true
			break
		end
	end

	if verified then
	else
		warn("[DEBUG] Verification FAILED for:", animalName, chance)
	end

	for i, animal in ipairs(block.Animals) do
	end

	AnimalService.spawnAnimalInBase(player, luckyBlockName)

	return true, "Chance updated successfully!"
end




--new features end

function GiveRebirth.OnServerInvoke(Player: Player, Rebirth: number, AddMode: boolean?): (boolean, string?) 
	-- Validate the rebirth amount
	if type(Rebirth) ~= "number" or Rebirth <= 0 then
		return false, "Amount must be a positive number."
	end

	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		return false, "Failed to get save."
	end

	local CurrentRebirth = PlayerChannel:Get("Rebirth") or 0
	local NewRebirth = Rebirth

	if AddMode then
		NewRebirth = CurrentRebirth + Rebirth
	end

	if not RebirthData[NewRebirth] then
		return false, "This rebirth does not exist."
	end

	PlayerChannel:Set("Rebirth", NewRebirth)

	local CurrentBase = BasesData[NewRebirth].Model
	local NewPlotClone = CurrentBase:Clone()

	if NewPlotClone.PrimaryPart then
		NewPlotClone.PrimaryPart.Anchored = true
	end

	PlotService.replacePlot(Player, NewPlotClone)

	return true
end


function StartEvent.OnServerInvoke(Player: Player, Event: string): (boolean, string?)
	-- Ownership check removed; HandleCooldown will always return true
	local Success, Message = HandleCooldown(Player, "StartEvent")
	if not Success then
		return false, Message
	end

	local MainEvent = ReplicatedStorage.Controllers.EventController.Events:FindFirstChild(Event)
	if not MainEvent then
		return false, "This event does not exist."
	end

	EventService:ExecuteEvent(Event, 300)
	Cooldowns.StartEvent.List[Player.UserId] = os.time()

	return true
end

function StopEvent.OnServerInvoke(Player: Player, Event: string): (boolean, string?)
	-- Ownership check removed; HandleCooldown will always return true
	local Success, Message = HandleCooldown(Player, "StartEvent")
	if not Success then
		return false, Message
	end

	local MainEvent = ReplicatedStorage.Controllers.EventController.Events:FindFirstChild(Event)
	if not MainEvent then
		return false, "This event does not exist."
	end

	EventService:CancelEvent(Event, 300)

	return true
end


function SpawnBrainrot.OnServerInvoke(
	Player: Player,
	Name: string,
	Mutation: string,
	Traits: string,
	Speed: number
): (boolean, string?)
	
	--custom
	
	
	local last = Cooldowns.SpawnBrainrot.List[Player.UserId]
	if last and (os.time() - last) < 3 then
		return false, "Please wait 3 Seconds before doing that."
	end
	
	
	--custom
	
	local Success, Message = HandleCooldown(Player, "SpawnBrainrot")
	if not Success then
		return false, Message
	end

	local Animal = AnimalsData[Name]
	if not Animal then
		return false, "Could not find brainrot."
	end

	if Mutation ~= "" and not MutationsData[Mutation] then
		return false, "Could not find this mutation."
	end

	if tonumber(Speed) and tonumber(Speed) < 2 then
		return false, "The speed has to be over 2."
	end

	if tonumber(Speed) and tonumber(Speed) > 100000 then
		return false, "The speed has to be under 100000."
	end

	local TraitTable

	if Traits == "All" then
		-- Convert the entire TraitsData dictionary into a list
		TraitTable = {}
		for traitName in pairs(TraitsData) do
			table.insert(TraitTable, traitName)
		end

		-- Normal handling
	else
		TraitTable = string.split(Traits, ", ")

		if Traits ~= "None" then
			if Traits == "" then
				TraitTable = {}
			end

			local Removed = {}
			local SeenTraits = {}

			for Index, Trait in pairs(TraitTable) do
				if SeenTraits[Trait] then
					return false, string.format("You cannot have more than one of the same trait: %s", Trait)
				end
				SeenTraits[Trait] = true

				if not TraitsData[Trait] then
					table.insert(Removed, Trait)
					TraitTable[Index] = nil
				end
			end

			if #Removed > 0 then
				local RemovedString = table.concat(Removed, ", ")
				return false, string.format("These traits do not exist: %s", RemovedString)
			end
		end
	end


	local MutationValue = Mutation ~= "" and Mutation or nil
	local SpeedValue = Speed and Speed or nil
	local TraitsValue = Traits ~= "None" and TraitTable or nil

	AnimalService.spawnAnimalCustom(Animal, MutationValue, TraitsValue, SpeedValue)
	Cooldowns.SpawnBrainrot.List[Player.UserId] = os.time()

	return true
end

function SpawnBrainrotInBase.OnServerInvoke(Player: Player, Name: string, Mutation: string, Traits: string): (boolean, string?)
	local Success, Message = HandleCooldown(Player, "SpawnBrainrotInBase")
	if not Success then
		return false, Message
	end

	local Animal = AnimalsData[Name]
	if not Animal then
		return false, "Could not find brainrot."
	end

	if Mutation ~= "" and not MutationsData[Mutation] then
		return false, "Could not find this mutation."
	end

	local TraitTable

	-- HANDLE "All"
	if Traits == "All" then
		-- Convert the entire TraitsData dictionary into a list
		TraitTable = {}
		for traitName in pairs(TraitsData) do
			table.insert(TraitTable, traitName)
		end

		-- Normal handling
	else
		TraitTable = string.split(Traits, ", ")

		if Traits ~= "None" then
			if Traits == "" then
				TraitTable = {}
			end

			local Removed = {}
			local SeenTraits = {}

			for Index, Trait in pairs(TraitTable) do
				if SeenTraits[Trait] then
					return false, string.format("You cannot have more than one of the same trait: %s", Trait)
				end
				SeenTraits[Trait] = true

				if not TraitsData[Trait] then
					table.insert(Removed, Trait)
					TraitTable[Index] = nil
				end
			end

			if #Removed > 0 then
				local RemovedString = table.concat(Removed, ", ")
				return false, string.format("These traits do not exist: %s", RemovedString)
			end
		end
	end


	local MutationValue = Mutation ~= "" and Mutation or nil
	local TraitsValue = Traits ~= "None" and TraitTable or nil

	AnimalService.spawnAnimalInBase(Player, Name, MutationValue, TraitsValue)
	Cooldowns.SpawnBrainrotInBase.List[Player.UserId] = os.time()

	return true
end

function Morph.OnServerInvoke(
	Player: Player,
	Name: string,
	Mutation: string,
	Traits: string,
	Speed: string,
	AnimalOverhead: string
): (boolean, string?)
	-- Ownership check removed; HandleCooldown will always return true
	local Success, Message = HandleCooldown(Player, "Morph")
	if not Success then
		return false, Message
	end

	CleanupMorph(Player)

	local Character = Player.Character
	if not Character then
		return false, "Failed to grab character."
	end

	local Humanoid = Character:WaitForChild("Humanoid") :: Humanoid
	if not Humanoid then
		return false, "Failed to grab Humanoid."
	end

	local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart") :: Part
	if not HumanoidRootPart then
		return false, "Failed to grab HRP."
	end

	local Animal = AnimalsData[Name]
	if not Animal then
		return false, "Could not find brainrot."
	end

	if Mutation ~= "" and not MutationsData[Mutation] then
		return false, "Could not find this mutation."
	end

	local TraitTable

	-- HANDLE "All"
	if Traits == "All" then
		-- Convert the entire TraitsData dictionary into a list
		TraitTable = {}
		for traitName in pairs(TraitsData) do
			table.insert(TraitTable, traitName)
		end

		-- Normal handling
	else
		TraitTable = string.split(Traits, ", ")

		if Traits ~= "None" then
			if Traits == "" then
				TraitTable = {}
			end

			local Removed = {}
			local SeenTraits = {}

			for Index, Trait in pairs(TraitTable) do
				if SeenTraits[Trait] then
					return false, string.format("You cannot have more than one of the same trait: %s", Trait)
				end
				SeenTraits[Trait] = true

				if not TraitsData[Trait] then
					table.insert(Removed, Trait)
					TraitTable[Index] = nil
				end
			end

			if #Removed > 0 then
				local RemovedString = table.concat(Removed, ", ")
				return false, string.format("These traits do not exist: %s", RemovedString)
			end
		end
	end


	local MutationValue = Mutation ~= "" and Mutation or nil
	local TraitsValue = Traits ~= "None" and TraitTable or nil

	local IdleAnimalModel = SharedAnimals:GetAnimatedModel(Name, "Idle")
	if not IdleAnimalModel or not IdleAnimalModel.PrimaryPart then
		return false, "Failed to get brainrot model."
	end

	local WalkAnimalModel = SharedAnimals:GetAnimatedModel(Name, "Walk")
	if not WalkAnimalModel or not WalkAnimalModel.PrimaryPart then
		return false, "Failed to get brainrot model."
	end

	local SpeedConnection

	if Speed:lower() == "yes" then
		SpeedConnection = RunService.Heartbeat:Connect(function()
			Humanoid.WalkSpeed = 16
		end)
	else
		SpeedService:Update(Player)
	end

	if AnimalOverhead:lower() == "yes" then
		local Overhead = script.Overhead.Attachment:Clone()
		Overhead.Parent = IdleAnimalModel.PrimaryPart
		Overhead.AnimalOverhead.DisplayName.Text = Name

		Overhead.AnimalOverhead.Generation.Text =
			string.format("$%*/s", NumberUtils:ToString(SharedAnimals:GetGeneration(Name, MutationValue, TraitsValue, Player)))
		Overhead.AnimalOverhead.Price.Text = string.format("$%*", NumberUtils:ToString(AnimalsData[Name].Price))
		Overhead.AnimalOverhead.Rarity.Text = AnimalsData[Name].Rarity
		Overhead.AnimalOverhead.Rarity.TextColor3 = RaritiesData[AnimalsData[Name].Rarity].Color

		local EasyVisualsPreset = RaritiesData[AnimalsData[Name].Rarity].EasyVisualsPresset
		if EasyVisualsPreset then
			Overhead.AnimalOverhead.Rarity.Visuals:SetAttribute("Preset", EasyVisualsPreset)
			Overhead.AnimalOverhead.Rarity.Visuals.Enabled = true
		end

		local EasyVisualsPresetMutation = MutationsData[MutationValue].EasyVisual
		if EasyVisualsPresetMutation then
			Overhead.AnimalOverhead.Mutation.Visuals:SetAttribute("Preset", EasyVisualsPresetMutation)
			Overhead.AnimalOverhead.Mutation.Visuals.Enabled = true
		end

		if MutationValue then
			Overhead.AnimalOverhead.Mutation.Visible = true
			Overhead.AnimalOverhead.Mutation.Text = MutationValue
			Overhead.AnimalOverhead.Mutation.TextColor3 = MutationsData[MutationValue].MainColor
		end

		for _, Trait in pairs(TraitTable) do
			Overhead.AnimalOverhead.Traits.Visible = true

			local MainTrait = TraitsData[Trait]
			local Template = Overhead.AnimalOverhead.Traits.Template:Clone()
			Template.Parent = Overhead.AnimalOverhead.Traits
			Template.Image = MainTrait.Icon
			Template.Visible = true
		end
	end

	if MutationValue then
		SharedAnimals:ApplyMutation(IdleAnimalModel, Name, MutationValue)
		SharedAnimals:ApplyMutation(WalkAnimalModel, Name, MutationValue)
	end

	if TraitsValue then
		SharedAnimals:ApplyTraits(IdleAnimalModel, Name, TraitsValue)
		SharedAnimals:ApplyTraits(WalkAnimalModel, Name, TraitsValue)
	end

	task.wait(0.1)
	local function CalculateYOffset(model: Model)
		local primary = model.PrimaryPart
		if not primary then
			return 0
		end

		local cframe, size = model:GetBoundingBox()

		local localCF = primary.CFrame:ToObjectSpace(cframe)

		local bottom = localCF.Y - (size.Y * 0.5)

		local neededOffset = -bottom

		return neededOffset * -0.4
	end

	local yOffset = CalculateYOffset(IdleAnimalModel)

	local weldIdle = Instance.new("Weld")
	weldIdle.Part0 = IdleAnimalModel.PrimaryPart
	weldIdle.Part1 = HumanoidRootPart
	weldIdle.C0 = CFrame.new(0, yOffset, 0)
	weldIdle.Parent = IdleAnimalModel.PrimaryPart

	local weldWalk = Instance.new("Weld")
	weldWalk.Part0 = WalkAnimalModel.PrimaryPart
	weldWalk.Part1 = HumanoidRootPart
	weldWalk.C0 = CFrame.new(0, yOffset, 0)
	weldWalk.Parent = WalkAnimalModel.PrimaryPart


	for _, Part: Instance in pairs(Player.Character:GetDescendants()) do
		if Part:IsA("BasePart") and Part.Name ~= "HumanoidRootPart" then
			Part.Transparency = 1
		elseif Part:IsA("Decal") then
			Part.Transparency = 1
		end
	end

	IdleAnimalModel.Parent = Player.Character
	WalkAnimalModel.Parent = Player.Character

	local OriginalIdleTransparency = {}
	local OriginalWalkTransparency = {}

	for _, Part in ipairs(IdleAnimalModel:GetDescendants()) do
		if Part:IsA("BasePart") then
			OriginalIdleTransparency[Part] = Part.Transparency
		end
	end

	for _, Part in ipairs(WalkAnimalModel:GetDescendants()) do
		if Part:IsA("BasePart") then
			OriginalWalkTransparency[Part] = Part.Transparency
		end
	end

	local function ShowModel(Model, TransparencyTable)
		for Part, TransparencyValue in pairs(TransparencyTable) do
			Part.Transparency = TransparencyValue
		end
	end

	local function HideModel(Model)
		for _, Part in ipairs(Model:GetDescendants()) do
			if Part:IsA("BasePart") then
				Part.Transparency = 1
			end
		end
	end

	ShowModel(IdleAnimalModel, OriginalIdleTransparency)
	HideModel(WalkAnimalModel)

	local Connection = Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
		if Humanoid.MoveDirection ~= Vector3.new(0, 0, 0) then
			ShowModel(WalkAnimalModel, OriginalWalkTransparency)
			HideModel(IdleAnimalModel)
		elseif Humanoid.MoveDirection == Vector3.new(0, 0, 0) then
			ShowModel(IdleAnimalModel, OriginalIdleTransparency)
			HideModel(WalkAnimalModel)
		end
	end)

	Humanoid.AncestryChanged:Once(function()
		CleanupMorph(Player)
	end)

	ActiveMorphs[Player.UserId] = {
		connection = Connection,
		idleModel = IdleAnimalModel,
		walkModel = WalkAnimalModel,
		speedConnection = SpeedConnection,
	}

	Cooldowns.Morph.List[Player.UserId] = os.time()

	return true
end

function UnMorph.OnServerInvoke(Player: Player): (boolean, string?)
	local Success, Message = HandleCooldown(Player, "UnMorph")
	if not Success then
		return false, Message
	end

	CleanupMorph(Player)
	SpeedService:Update(Player)

	Cooldowns.UnMorph.List[Player.UserId] = os.time()

	return true
end









-- start of player morph
local UpdateChatName = ReplicatedStorage:FindFirstChild("UpdateChatNameServer")

function HandlePlayerMorph(Player: Player, TargetUsername: string, ChatName: string, Verified: string): (boolean, string?)
	local Success, Message = HandleCooldown(Player, "PlayerMorph")
	if not Success then
		return false, Message
	end

	local TargetUserId
	local UserSuccess, Err = pcall(function()
		TargetUserId = Players:GetUserIdFromNameAsync(TargetUsername)
	end)
	if not UserSuccess or not TargetUserId then
		return false, "Player not found: " .. tostring(Err)
	end

	local HumanoidDescription
	local DescSuccess, DescErr = pcall(function()
		HumanoidDescription = Players:GetHumanoidDescriptionFromUserId(TargetUserId)
	end)
	if not DescSuccess or not HumanoidDescription then
		return false, "Failed to get player description: " .. tostring(DescErr)
	end

	local Character = Player.Character
	if not Character then
		return false, "Failed to get your character."
	end

	local Humanoid = Character:FindFirstChild("Humanoid")
	if not Humanoid then
		return false, "Failed to get your humanoid."
	end

	-- Keep existing DisplayName behavior
	local USER
	if Verified:lower() == "yes" then
		USER = ChatName.."" 
	else
		USER = ChatName.."" 
	end
	
	if Humanoid then
		Humanoid.DisplayName = USER
	end
	
	local ApplySuccess, ApplyErr = pcall(function()
		Humanoid:ApplyDescription(HumanoidDescription)
	end)
	if not ApplySuccess then
		return false, "Failed to apply appearance: " .. tostring(ApplyErr)
	end

	-- Set CustomName and Verified attributes
	if ChatName and ChatName ~= "" then
		Player:SetAttribute("CustomName", ChatName)
	end

	if Verified:lower() == "yes" then
		Player:SetAttribute("Verified", true)
	else
		Player:SetAttribute("Verified", nil)
	end

	-- Update player's base TextLabel
	if workspace:FindFirstChild("Plots") then
		local newBaseName = (ChatName ~= "" and ChatName or Player.Name)
			newBaseName = newBaseName

		local originalDisplayName = Player.DisplayName -- use normal display name, not morphed

		local found = false
		for _, plot in pairs(workspace.Plots:GetChildren()) do
			if plot:IsA("Model") then
				local plotSign = plot:FindFirstChild("PlotSign")
				if plotSign then
					local surfaceGui = plotSign:FindFirstChildOfClass("SurfaceGui")
					if surfaceGui then
						local frame = surfaceGui:FindFirstChild("Frame")
						if frame then
							local textLabel = frame:FindFirstChildOfClass("TextLabel")
							if textLabel then
								-- check if first 3 letters match original display name
								if textLabel.Text:sub(1,3):lower() == originalDisplayName:sub(1,3):lower() then
									textLabel.Text = newBaseName .. "'s Base"
									found = true
								else
								end
							else
							end
						else
						end
					else
					end
				else
				end
			else
			end
		end

		if not found then
		end
	else
	end


	-- Fire client to handle chat prefix + verified badge
	UpdateChatName:Fire(Player, ChatName, Verified)

	Cooldowns.PlayerMorph.List[Player.UserId] = os.time()
	return true, string.format("Successfully morphed into %s!", TargetUsername)
end

local function OnPlayerCharacterAdded(Player: Player)
	local Character = Player.Character or Player.CharacterAdded:Wait()
	local Humanoid = Character:WaitForChild("Humanoid")

	Humanoid.Died:Connect(function()
		Player:SetAttribute("CustomName", nil)
		Player:SetAttribute("Verified", nil)
	end)
end

local function ResetPlayerAttributes(Player: Player)
	local Character = Player.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			Humanoid.DisplayName = Player.Name
			Humanoid.Health = 0 -- kill the player
		end
	end
	-- Reset DisplayName
	local Character = Player.Character
	if Character then
		local Humanoid = Character:FindFirstChild("Humanoid")
		if Humanoid then
			Humanoid.DisplayName = Player.Name
		end
	end

	-- Reset specific attributes individually
	Player:SetAttribute("CustomName", nil)
	Player:SetAttribute("Verified", nil)

	-- Fire client to update chat
	UpdateChatName:Fire(Player, nil, nil)

	-- Reset plot labels if needed
	if workspace:FindFirstChild("Plots") then
		for _, plot in pairs(workspace.Plots:GetChildren()) do
			if plot:IsA("Model") then
				local plotSign = plot:FindFirstChild("PlotSign")
				if plotSign then
					local surfaceGui = plotSign:FindFirstChildOfClass("SurfaceGui")
					if surfaceGui then
						local frame = surfaceGui:FindFirstChild("Frame")
						if frame then
							local textLabel = frame:FindFirstChildOfClass("TextLabel")
							if textLabel then
								textLabel.Text = Player.Name .. "'s Base"
							end
						end
					end
				end
			end
		end
	end
end

local function OnPlayerAdded(Player: Player)
	if Player.Character then
		OnPlayerCharacterAdded(Player)
	end
	Player.CharacterAdded:Connect(function()
		OnPlayerCharacterAdded(Player)
	end)
end


PlayerMorph.OnServerEvent:Connect(function(Player: Player, TargetUsernameOrUnmorph, ChatName, Verified)
	if TargetUsernameOrUnmorph == true then
		-- Unmorph: reset all attributes and restore original DisplayName
		local Character = Player.Character
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid then
				Humanoid.DisplayName = Player.Name
			end
		end
		
		ResetPlayerAttributes(Player)
		Player:SetAttribute("CustomName", nil)
		Player:SetAttribute("Verified", nil)
		print("unmorph")

		UpdateChatName:Fire(Player, nil, nil)
		return
	end

	-- Otherwise, do normal morph
	local Success, Message = HandlePlayerMorph(Player, TargetUsernameOrUnmorph, ChatName, Verified)
	if not Success then
		warn("[PlayerMorph] Error for " .. Player.Name .. ": " .. (Message or "Unknown error"))
	end
end)


for _, Player in pairs(Players:GetPlayers()) do
	OnPlayerAdded(Player)
end
Players.PlayerAdded:Connect(OnPlayerAdded)
-- end of player morph














Players.PlayerAdded:Connect(OnPlayerAdded)

GiveTool.OnServerEvent:Connect(function(Player: Player, ToolName: string, Remove: boolean)
	local ItemsFolder = game:GetService("ReplicatedStorage"):WaitForChild("Items")
	local Backpack = Player:WaitForChild("Backpack")
	local Character = Player.Character or Player.CharacterAdded:Wait()

	if Remove then
		-- Remove from Backpack
		local Tool = Backpack:FindFirstChild(ToolName)
		if Tool then
			Tool:Destroy()
		end

		-- Remove from Character (if equipped)
		local EquippedTool = Character:FindFirstChild(ToolName)
		if EquippedTool then
			EquippedTool:Destroy()
		end

		return
	end

	-- Give tool
	local Tool = ItemsFolder:FindFirstChild(ToolName)
	if not Tool then
		return
	end

	local Clone = Tool:Clone()
	for _, Descendant in ipairs(Clone:GetDescendants()) do
		if Descendant:IsA("Script") then
			Descendant.Enabled = true
		end
	end

	Clone.Parent = Backpack
end)


AlertErrors.OnServerEvent:Connect(function(Player: Player)
	local Data = Synchronizer:Get(Player)
	if not Data then
		return
	end

	local Status = Data:Get("AdminAlertErrors")
	if Status == nil then
		Status = false
	end

	Data:Set("AdminAlertErrors", not Status)
end)

function AdminPanel.Start()
	for Key, Data in pairs(Cooldowns) do
		if Data.WhitelistedUsers and Data.RequiresPurchase then
			local Usernames = {}
			for Username, _ in pairs(Data.WhitelistedUsers) do
				table.insert(Usernames, Username)
			end

			local NewValue = Instance.new("StringValue")
			NewValue.Name = string.format("%*Bypass", Key)
			NewValue.Value = table.concat(Usernames, ",")
			NewValue.Parent = ReplicatedStorage
		end
	end

	Players.PlayerRemoving:Connect(OnPlayerRemoving)
end

return AdminPanel
