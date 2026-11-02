--!native

local AdminPanel = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local DatastoreService = game:GetService("DataStoreService")
local TeleportService = game:GetService("TeleportService")
local MessagingService = game:GetService("MessagingService")

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
local IndexData = require(ReplicatedStorage.Datas.Mutations)

local ServerSpawnBrainrot = Net:RemoteFunction("ServerSpawnBrainrot")
local SpawnBrainrotInBase = Net:RemoteFunction("AdminService/SpawnBrainrotInBase")
local ResetBrainrots = Net:RemoteFunction("AdminService/ResetBrainrots")
local Morph = Net:RemoteFunction("AdminService/Morph")
local UnMorph = Net:RemoteFunction("AdminService/UnMorph")
local AlertErrors = Net:RemoteEvent("AdminService/AlertErrors")
local GiveMoney = Net:RemoteFunction("AdminService/GiveMoney")
local GiveRebirth = Net:RemoteFunction("AdminService/GiveRebirth")
local ResetData = Net:RemoteEvent("AdminService/ResetData")
local PlayerMorph = Net:RemoteEvent("AdminService/PlayerMorph")
local GiveGear = Net:RemoteFunction("GiveGear")
local Announce = Net:RemoteFunction("AdminService/Announce")
local SetLuck = Net:RemoteFunction("AdminService/SetLuckRE")
local GiveMulti = Net:RemoteFunction("AdminService/GiveMulti")
local SetSteal = Net:RemoteFunction("AdminService/SetSteal")
local AddSteal = Net:RemoteFunction("AdminService/AddSteal")
local UnlockIndex = Net:RemoteFunction("AdminService/UnlockIndex")

local MainDS = DatastoreService:GetDataStore("Main")

local WhitelistedUsers = {"brodyherman"}
local ActiveMorphs = {}
local Cooldowns = {
	SpawnBrainrotInBase = {
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
	},
	UnMorph = {
		Time = 0,
		GamepassTime = 0,
		List = {},
		WhitelistedUsers = WhitelistedUsers,
	},
	Keybinds = {
		WhitelistedUsers = WhitelistedUsers,
	},
	PlayerMorph = {
		Time = 0,
		GamepassTime = 0,
		List = {},
		WhitelistedUsers = WhitelistedUsers,
	},
	ResetBrainrots = {
		Time = 0,
		GamepassTime = 0,
		List = {},
		WhitelistedUsers = WhitelistedUsers,
	},
	Announce = {
		Time = 0,
		GamepassTime = 5,
		List = {},
		WhitelistedUsers = WhitelistedUsers,
	},
	SetSteal = {
		Time = 0,
		GamepassTime = 0,
		List = {},
		WhitelistedUsers = WhitelistedUsers,
	},
	AddSteal = {
		Time = 0,
		GamepassTime = 0,
		List = {},
		WhitelistedUsers = WhitelistedUsers,
	},
	UnlockIndex = {
		Time = 0,
		GamepassTime = 0,
		List = {},
		WhitelistedUsers = WhitelistedUsers,
	},
}

local CurrentAdminPanel = 1568196858
local ADMIN_PANELS = {
	CurrentAdminPanel
}

local function OwnsAdminPlus(Player: Player): boolean
	for _, PanelId in ipairs(ADMIN_PANELS) do
		local Success, OwnsPass = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(Player.UserId, PanelId)
		end)

		if Success and OwnsPass then
			return true
		end
	end
	return false
end

function OwnsGamepass(Player: Player, Type: string?): boolean
	if RunService:IsStudio() then
		return true
	end

	local HasPlus = OwnsAdminPlus(Player)

	if HasPlus then
		return true
	elseif Type and Cooldowns[Type] then
		local IsWhitelistedByName = false
		for _, Username in pairs(Cooldowns[Type].WhitelistedUsers) do
			if Username == Player.Name then
				IsWhitelistedByName = true
				break
			end
		end
		if IsWhitelistedByName then
			return true
		end
	else
		local PromptSuccess, PromptErr = pcall(function()
			MarketplaceService:PromptGamePassPurchase(Player, CurrentAdminPanel)
		end)

		if not PromptSuccess then
			warn("[OwnsGamepass] Failed to prompt gamepass purchase: " .. tostring(PromptErr))
		end

		return false
	end
	return HasPlus
end

function HandleCooldown(Player: Player, CooldownType: string): (boolean, string?)
	local CommandData = Cooldowns[CooldownType]
	local UserId = Player.UserId

	local IsWhitelistedByName = false
	for _, Username in pairs(CommandData.WhitelistedUsers) do
		if Username == Player.Name then
			IsWhitelistedByName = true
			break
		end
	end

	local HasGamepass = OwnsAdminPlus(Player)
	local CooldownDuration = HasGamepass and CommandData.GamepassTime or CommandData.Time

	if HasGamepass and game.PrivateServerId ~= "" and CommandData.VIPCooldownGamepass then
		CooldownDuration = CommandData.VIPCooldownGamepass
	end

	if IsWhitelistedByName then
		CooldownDuration = 0
	end

	if CommandData.List[UserId] then
		local TimePassed = os.time() - CommandData.List[UserId]

		if TimePassed < CooldownDuration then
			local TimeLeft = CooldownDuration - TimePassed

			return false, string.format("Please wait %d seconds before using this.", math.ceil(TimeLeft))
		end
	end

	CommandData.List[UserId] = os.time() 

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

function GiveGear.OnServerInvoke(Player: Player, GearName: string): (boolean, string?)
	if type(GearName) ~= "string" or GearName == "" then
		return false, "Gear name cannot be empty."
	end

	local ItemsFolder = ReplicatedStorage:FindFirstChild("Items")
	if not ItemsFolder then
		return false, "Items folder not found."
	end

	local Gear = ItemsFolder:FindFirstChild(GearName)
	if not Gear then
		return false, "Gear not found: " .. GearName
	end

	local Backpack = Player:FindFirstChild("Backpack")
	if not Backpack then
		return false, "Failed to get your backpack."
	end

	local Clone = Gear:Clone()
	for _, Descendant in ipairs(Clone:GetDescendants()) do
		if Descendant:IsA("Script") then
			Descendant.Enabled = true
		end
	end

	Clone.Parent = Backpack

	return true
end

function ServerSpawnBrainrot.OnServerInvoke(Player: Player, Name: string, Mutation: string, Traits: string, Speed: number): (boolean, string?)
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

	local TraitTable = string.split(Traits, ", ")
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

	local MutationValue = Mutation ~= "" and Mutation or nil
	local SpeedValue = Speed and Speed or nil
	local TraitsValue = Traits ~= "None" and TraitTable or nil

	AnimalService.spawnAnimalCustom(Animal, MutationValue, TraitsValue, SpeedValue)

	return true
end

function UnlockIndex.OnServerInvoke(Player: Player, IndexName: string)
	if type(IndexName) ~= "string" or IndexName == "" then
		return false, "Invalid index name."
	end

	local Owns = OwnsGamepass(Player, "UnlockIndex")
	if not Owns then
		return false, "You do not have permission to unlock this index."
	end

	local Success, CooldownMessage = HandleCooldown(Player, "UnlockIndex")
	if not Success then
		return false, CooldownMessage
	end

	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		return false, "Failed to access player data."
	end

	local UnlockedIndexes = PlayerChannel:Get("UnlockedIndexes") or {}
	if table.find(UnlockedIndexes, IndexName) then
		return false, string.format("%s is already unlocked.", IndexName)
	end

	table.insert(UnlockedIndexes, IndexName)
	PlayerChannel:Set("UnlockedIndexes", UnlockedIndexes)
	Cooldowns.UnlockIndex.List[Player.UserId] = os.time()

	return true, string.format("Successfully unlocked index: %s!", IndexName)
end

ResetData.OnServerEvent:Connect(function(Player: Player)
	DataService:ResetData(Player)
end)

function GiveMoney.OnServerInvoke(Player: Player, Amount: number): (boolean, string?)
	local Success, Message = HandleCooldown(Player, "GiveMoney")
	if not Success then
		return false, Message
	end

	if type(Amount) ~= "number" or Amount <= 0 then
		return false, "Amount must be a positive number."
	end

	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		return false, "Failed to get save."
	end

	PlayerChannel:Set("Coins", Amount)

	return true
end

function GiveRebirth.OnServerInvoke(Player: Player, Rebirth: number): (boolean, string?)
	local Success, Message = HandleCooldown(Player, "GiveRebirth")
	if not Success then
		return false, Message
	end

	if type(Rebirth) ~= "number" or Rebirth <= 0 then
		return false, "Amount must be a positive number."
	end

	if not RebirthData[Rebirth] then
		return false, "This rebirth does not exist."
	end

	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		return false, "Failed to get save."
	end

	PlayerChannel:Set("Rebirth", Rebirth)

	local CurrentBase = BasesData[Rebirth].Model
	local NewPlotClone = CurrentBase:Clone()

	if NewPlotClone.PrimaryPart then
		NewPlotClone.PrimaryPart.Anchored = true
	end

	PlotService.replacePlot(Player, NewPlotClone)

	return true
end

function SpawnBrainrotInBase.OnServerInvoke(Player: Player, Name: string, Mutation: string, Traits: string): (boolean, string?)
	local Animal = AnimalsData[Name]
	if not Animal then
		return false, "Could not find brainrot."
	end

	if Mutation ~= "" and not MutationsData[Mutation] then
		return false, "Could not find this mutation."
	end

	local TraitTable = string.split(Traits, ", ")
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

	local MutationValue = Mutation ~= "" and Mutation or nil
	local TraitsValue = Traits ~= "None" and TraitTable or nil

	AnimalService.spawnAnimalInBase(Player, Name, MutationValue, TraitsValue)

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
	local Owns = OwnsGamepass(Player, "Morph")
	if not Owns then
		return false, "You do not own this gamepass."
	end

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

	local TraitTable = string.split(Traits, ", ")
	if Traits ~= "None" then
		if Traits == "" then
			TraitTable = {}
		end

		local Removed = {}

		for Index, Trait in pairs(TraitTable) do
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
		local Overhead = script.Parent.Resources.Models.Overhead.Attachment:Clone()
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

	local WeldIdle = Instance.new("Weld", IdleAnimalModel.PrimaryPart)
	WeldIdle.Part0 = IdleAnimalModel.PrimaryPart
	WeldIdle.Part1 = HumanoidRootPart

	local WeldWalk = Instance.new("Weld", WalkAnimalModel.PrimaryPart)
	WeldWalk.Part0 = WalkAnimalModel.PrimaryPart
	WeldWalk.Part1 = HumanoidRootPart

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

	return true
end

function UnMorph.OnServerInvoke(Player: Player): (boolean, string?)
	local Success, Message = HandleCooldown(Player, "UnMorph")
	if not Success then
		return false, Message
	end

	CleanupMorph(Player)
	SpeedService:Update(Player)

	return true
end

function HandlePlayerMorph(Player: Player, TargetUsername: string, ChatName: string, Verified: string): (boolean, string?)
	local Success, Message = HandleCooldown(Player, "PlayerMorph")
	if not Success then
		return false, Message
	end

	local TargetUserId = nil
	if not TargetUsername or TargetUsername == "" then
		return false, "You must enter a valid username."
	end

	local UserSuccess, Result = pcall(function()
		return Players:GetUserIdFromNameAsync(TargetUsername)
	end)

	if not UserSuccess or not Result then
		return false, "Player '" .. TargetUsername .. "' does NOT exist on Roblox."
	end

	TargetUserId = Result


	local HumanoidDescription = nil
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
	local USER
	if Verified:lower() == "yes" then
		USER = TargetUsername .. " " .. utf8.char(0x2713)
	else
		USER = TargetUsername
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

	if ChatName and ChatName ~= "" then
		Player:SetAttribute("CustomName", ChatName)
	else
		Player:SetAttribute("CustomName", nil)
	end

	if Verified:lower() == "yes" then
		Player:SetAttribute("Verified", true)
	else
		Player:SetAttribute("Verified", nil)
	end

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

local function OnPlayerAdded(Player: Player)
	if Player.Character then
		OnPlayerCharacterAdded(Player)
	end
	Player.CharacterAdded:Connect(function()
		OnPlayerCharacterAdded(Player)
	end)
end

PlayerMorph.OnServerEvent:Connect(function(Player: Player, TargetUsername: string, ChatName: string, Verified: string)
	local Success, Message = HandlePlayerMorph(Player, TargetUsername, ChatName, Verified)
	if not Success then
		warn("[PlayerMorph] Error for " .. Player.Name .. ": " .. (Message or "Unknown error"))
	end
end)

for _, Player in pairs(Players:GetPlayers()) do
	OnPlayerAdded(Player)
end

Players.PlayerAdded:Connect(OnPlayerAdded)

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

function ResetBrainrots.OnServerInvoke(Player: Player): (boolean, string?)
	local Success, Message = HandleCooldown(Player, "ResetBrainrots")
	if not Success then
		return false, Message
	end
	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		return false, "Failed to get player data."
	end
	local AnimalPodiums = PlayerChannel:Get("AnimalPodiums")
	if not AnimalPodiums then
		return false, "No podiums found."
	end
	for i, _ in ipairs(AnimalPodiums) do
		AnimalPodiums[i] = "Empty"
	end
	PlayerChannel:Set("AnimalPodiums", AnimalPodiums)
	PlayerChannel:Set("AnimalAddedOrRemoved", true)

	return true
end

function Announce.OnServerInvoke(Player: Player, Message: string): (boolean, string?)
	local Success, ErrorMsg = HandleCooldown(Player, "Announce")
	if not Success then
		return false, ErrorMsg
	end

	if type(Message) ~= "string" or Message == "" then
		return false, "Message cannot be empty."
	end

	if #Message > 200 then
		return false, "Message is too long (max 200 characters)."
	end

	local NotificationService = require(game.ReplicatedStorage.Packages.NotificationService)
	for _, OtherPlayer in pairs(Players:GetPlayers()) do
		NotificationService.NotifyTop(OtherPlayer, Message, 5, "Sounds.Sfx.Success")
	end
	return true
end

function SetSteal.OnServerInvoke(Player: Player, StealAmount: number): (boolean, string?)
	local Success, Message = HandleCooldown(Player, "SetSteal")
	if not Success then
		return false, Message
	end

	if type(StealAmount) ~= "number" or StealAmount < 0 then
		return false, "Steal amount must be a positive number or zero."
	end

	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		return false, "Failed to get player data."
	end

	PlayerChannel:Set("Steals", StealAmount)

	return true, string.format("Set Steals count to %s", NumberUtils:ToString(StealAmount))
end

function AddSteal.OnServerInvoke(Player: Player, StealAmount: number): (boolean, string?)
	local Success, Message = HandleCooldown(Player, "AddSteal")
	if not Success then
		return false, Message
	end

	if type(StealAmount) ~= "number" or StealAmount <= 0 then
		return false, "Steal amount must be a positive number to add."
	end

	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		return false, "Failed to get player data."
	end

	local CurrentSteal = PlayerChannel:Get("Steals") or 0
	local NewSteal = CurrentSteal + StealAmount

	PlayerChannel:Set("Steals", NewSteal)

	return true, string.format("Added %s to Steals count. New total: %s",
		NumberUtils:ToString(StealAmount),
		NumberUtils:ToString(NewSteal))
end


function GiveMulti.OnServerInvoke(Player: Player, Amount: number, isAdd: boolean?): (boolean, string?)
	local Success, Message = HandleCooldown(Player, "GiveMulti")
	if not Success then
		return false, Message
	end

	if type(Amount) ~= "number" or Amount < 0 then
		return false, "Amount must be a positive number or zero."
	end

	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		return false, "Failed to get save."
	end

	local MultiKey = "CashMultiplier"
	local NewMulti = Amount
	local successMessage = ""

	if isAdd then
		if Amount <= 0 then
			return false, "Amount must be a positive number to add."
		end
		local CurrentMulti = PlayerChannel:Get(MultiKey) or 1.0
		NewMulti = CurrentMulti + Amount
		successMessage = string.format("Added %s to %s. New total: %s", Amount, MultiKey, NewMulti)
	else
		successMessage = string.format("Set %s to %s", MultiKey, Amount)
	end

	PlayerChannel:Set(MultiKey, NewMulti)

	local Plot = PlotService.getPlot(Player)
	if Plot then
		local MultiplierValue = PlotService:GetBaseMultiplier(Player) or 1
		if Plot:FindFirstChild("Multiplier") and Plot.Multiplier:FindFirstChild("Main") then
			Plot.Multiplier.Main.Amount.Text = string.format("x%.1f", MultiplierValue)
		end
	end

	return true, successMessage
end

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