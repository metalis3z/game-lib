--THIS CYBER BASE WAS MADE BY TRUSTEDASB

local PlotService = {}

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local PlotsFolder = workspace:WaitForChild("Plots")
local PlotTemplate = script:WaitForChild("0")
local SkinsFolder = script:WaitForChild("Skins")

local PlotsCreated = false

local SkinService = require(ServerScriptService.Services.SkinService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local StealService = require(ServerScriptService.Services.StealService)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local AnimalData = require(ReplicatedStorage.Datas.Animals)
local Rebirth = require(ReplicatedStorage.Datas.Rebirth)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local Net = require(ReplicatedStorage.Packages.Net)
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local SharedGame = require(ReplicatedStorage.Shared.Game)
local ServerStorage = game:GetService("ServerStorage")
local LuckyBlocks = require(ServerStorage.Modules.LuckyBlocks)
local RebirthData = require(ReplicatedStorage.Datas.Rebirth)
local BasesData = require(ReplicatedStorage.Datas.Bases)

local AnimalModels = ReplicatedStorage.Models.Animals
local FirstFloor = ReplicatedStorage.Bases.FirstFloor

local CashCollected = Net:RemoteEvent("PlotService/CashCollected")
local ToggleFriends = Net:RemoteEvent("PlotService/ToggleFriends")
local ClaimCoins = Net:RemoteEvent("PlotService/ClaimCoins")
local Sell = Net:RemoteEvent("PlotService/Sell")
local Open = Net:RemoteEvent("PlotService/Open")

local Steal = Net:RemoteEvent("5aa39ea1-0c65-4fcf-aff9-b18a7ef277c3")
local StartedHoldingSteal = Net:RemoteEvent("b096e1ca-9c3a-453b-8b60-268b235083b9")
local _ = Net:RemoteEvent("5c8f0dd0-0f9e-44ba-8f9b-197958b661ab")

local MAX_OFFLINE_SECONDS = 24 * 60 * 60
local START_GRACE_PERIOD = 30
local BASE_LOCK_TIME = 60

local ActivePlotConnections = {} :: { [any]: string }

-- Global brainrot counting for "1 of 1" unique indicator
local BrainrotCounts = {}

local function GetBrainrotKey(index, mutation, traits)
	local traitsKey = ""
	if type(traits) == "table" then
		traitsKey = table.concat(traits, "|")
	end
	return (index or "") .. "|" .. (mutation or "") .. "|" .. traitsKey
end

local function ComputeBrainrotCounts()
	table.clear(BrainrotCounts)
	for _, player in Players:GetPlayers() do
		local channel = Synchronizer:Get(player)
		if channel then
			local podiums = channel:Get("AnimalPodiums")
			if podiums and type(podiums) == "table" then
				for _, animalInfo in pairs(podiums) do
					if typeof(animalInfo) == "table" and not animalInfo.Steal and not animalInfo.Machine and not animalInfo.InTrade then
						local key = GetBrainrotKey(animalInfo.Index, animalInfo.Mutation, animalInfo.Traits)
						BrainrotCounts[key] = (BrainrotCounts[key] or 0) + 1
					end
				end
			end
		end
	end
end

local function UpdateAllPlotAnimalLists()
	for _, player in Players:GetPlayers() do
		local plot = _G.playerPlots[player.UserId]
		if plot then
			local plotChannel = Synchronizer:Get(plot.Name)
			if plotChannel then
				local currentList = plotChannel:Get("AnimalList")
				if currentList and type(currentList) == "table" then
					local updated = false
					for _, animalInfo in pairs(currentList) do
						if typeof(animalInfo) == "table" then
							local key = GetBrainrotKey(animalInfo.Index, animalInfo.Mutation, animalInfo.Traits)
							local count = BrainrotCounts[key] or 1
							if animalInfo.GlobalCount ~= count then
								animalInfo.GlobalCount = count
								updated = true
							end
						end
					end
					if updated then
						plotChannel:Set("AnimalList", currentList)
					end
				end
			end
		end
	end
end
local PlotUpdateConnections = {} :: { [Player]: RBXScriptConnection }
local InitializedPlots = {}

local StealingMonitors = {} :: { [Player]: {connection: RBXScriptConnection?, cancelled: boolean} }

_G.playerPlots = {} :: { [number]: Model }

local PlotOwners = {} :: { [Model]: Player }

local CharacterAddedConnections = {}
local PlotTouchedConnections = {}

function PlotService:RebuildBase(Player: Player)
	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then return end

	local Plot = PlotService.getPlot(Player)
	if not Plot then return end

	local RebirthLevel = PlayerChannel:Get("Rebirth") or 0
	local BaseData = BasesData[RebirthLevel]
	if not BaseData or not BaseData.Model then return end

	local BaseSkin = PlayerChannel:Get("Settings.Base Skin")
	local floorName = BaseData.Model.Name

	local BaseModel

	if BaseSkin == "Meowl" then
		local MeowlFolder = SkinsFolder:FindFirstChild("Meowl")
		if MeowlFolder then
			local MeowlFloor = MeowlFolder:FindFirstChild(floorName)
			if MeowlFloor then
				BaseModel = MeowlFloor
			end
		end
	end

	if BaseSkin == "Strawberry" then
		local StrawberryFolder = SkinsFolder:FindFirstChild("Strawberry")
		if StrawberryFolder then
			local StrawberryFloor = StrawberryFolder:FindFirstChild(floorName)
			if StrawberryFloor then
				BaseModel = StrawberryFloor
			end
		end
	end

	if BaseSkin == "Lucky" then
		local LuckyFolder = SkinsFolder:FindFirstChild("Lucky")
		if LuckyFolder then
			local LuckyFloor = LuckyFolder:FindFirstChild(floorName)
			if LuckyFloor then
				BaseModel = LuckyFloor
			end
		end
	end


	if BaseSkin == "Cyber" then
		local CyberFolder = SkinsFolder:FindFirstChild("Cyber")
		if CyberFolder then
			local CyberFloor = CyberFolder:FindFirstChild(floorName)
			if CyberFloor then
				BaseModel = CyberFloor
			end
		end
	end

	if BaseSkin == "Leperchaun" then
		local LeperchaunFolder = SkinsFolder:FindFirstChild("Leperchaun")
		if LeperchaunFolder then
			local LeperchaunFloor = LeperchaunFolder:FindFirstChild(floorName)
			if LeperchaunFloor then
				BaseModel = LeperchaunFloor
			end
		end
	end

	if BaseSkin == "Cursed" then
		local CursedFolder = SkinsFolder:FindFirstChild("Cursed")
		if CursedFolder then
			local CursedFloor = CursedFolder:FindFirstChild(floorName)
			if CursedFloor then
				BaseModel = CursedFloor
			end
		end
	end

	if BaseSkin == "Galaxy" then
		local GalaxyFolder = SkinsFolder:FindFirstChild("Galaxy")
		if GalaxyFolder then
			local GalaxyFloor = GalaxyFolder:FindFirstChild(floorName)
			if GalaxyFloor then
				BaseModel = GalaxyFloor
			end
		end
	end

	if BaseSkin == "Radioactive" then
		local RadioactiveFolder = SkinsFolder:FindFirstChild("Radioactive")
		if RadioactiveFolder then
			local RadioactiveFloor = RadioactiveFolder:FindFirstChild(floorName)
			if RadioactiveFloor then
				BaseModel = RadioactiveFloor
			end
		end
	end

	if BaseSkin == "Taco" then
		local TacoFolder = SkinsFolder:FindFirstChild("Taco")
		if TacoFolder then
			local TacoFloor = TacoFolder:FindFirstChild(floorName)
			if TacoFloor then
				BaseModel = TacoFloor
			end
		end
	end

	if BaseSkin == "Skibidi" then
		local SkibidiFolder = SkinsFolder:FindFirstChild("Skibidi")
		if SkibidiFolder then
			local SkibidiFloor = SkibidiFolder:FindFirstChild(floorName)
			if SkibidiFloor then
				BaseModel = SkibidiFloor
			end
		end
	end

	if BaseSkin == "Christmas" then
		local ChristmasFolder = SkinsFolder:FindFirstChild("Christmas")
		if ChristmasFolder then
			local ChristmasFloor = ChristmasFolder:FindFirstChild(floorName)
			if ChristmasFloor then
				BaseModel = ChristmasFloor
			end
		end
	end

	if BaseSkin == "Gingerbread" then
		local GingerbreadFolder = SkinsFolder:FindFirstChild("Gingerbread")
		if GingerbreadFolder then
			local GingerbreadFloor = GingerbreadFolder:FindFirstChild(floorName)
			if GingerbreadFloor then
				BaseModel = GingerbreadFloor
			end
		end
	end

	if BaseSkin == "Divine" then
		local DivineFolder = SkinsFolder:FindFirstChild("Divine")
		if DivineFolder then
			local DivineFloor = DivineFolder:FindFirstChild(floorName)
			if DivineFloor then
				BaseModel = DivineFloor
			end
		end
	end

	if BaseSkin == "Rainbow" then
		local RainbowFolder = SkinsFolder:FindFirstChild("Rainbow")
		if RainbowFolder then
			local RainbowFloor = RainbowFolder:FindFirstChild(floorName)
			if RainbowFloor then
				BaseModel = RainbowFloor
			end
		end
	end

	if BaseSkin == "Rose" then
		local RoseFolder = SkinsFolder:FindFirstChild("Rose")
		if RoseFolder then
			local RoseFloor = RoseFolder:FindFirstChild(floorName)
			if RoseFloor then
				BaseModel = RoseFloor
			end
		end
	end

	if BaseSkin == "Bunny Basket" then
		local BunnyBasketFolder = SkinsFolder:FindFirstChild("Bunny Basket")
		if BunnyBasketFolder then
			local BunnyBasketFloor = BunnyBasketFolder:FindFirstChild(floorName)
			if BunnyBasketFloor then
				BaseModel = BunnyBasketFloor
			end
		end
	end

	if BaseSkin == "Headless" then
		local HeadlessFolder = SkinsFolder:FindFirstChild("Headless")
		if HeadlessFolder then
			local HeadlessFloor = HeadlessFolder:FindFirstChild(floorName)
			if HeadlessFloor then
				BaseModel = HeadlessFloor
			end
		end
	end

	if BaseSkin == "Valentines" then
		local ValentinesFolder = SkinsFolder:FindFirstChild("Valentines")
		if ValentinesFolder then
			local ValentinesFloor = ValentinesFolder:FindFirstChild(floorName)
			if ValentinesFloor then
				BaseModel = ValentinesFloor
			end
		end
	end

	if not BaseModel then
		BaseModel = BaseData.Model
	end

	local NewPlot = BaseModel:Clone()
	PlotService.replacePlot(Player, NewPlot)
end

local BaseRequirements = {
	Strawberry = "Strawberry Elephant",
	Skibidi = "Skibidi Toilet",
	Meowl = "Meowl",
}

local function HasRequiredAnimal(Player, animalName)
	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then return false end

	local AnimalList = PlayerChannel:Get("AnimalPodiums")
	if not AnimalList then return false end

	for _, AnimalInfo in pairs(AnimalList) do
		if typeof(AnimalInfo) == "table" then
			if AnimalInfo.Index == animalName
				and (not AnimalInfo.Steal or (typeof(AnimalInfo.Steal) == "number" and Players:GetPlayerByUserId(AnimalInfo.Steal) == nil)) then
				return true
			end
		end
	end

	return false
end

local function CreatePlotsFromGenerator()
	if PlotsCreated then return end
	PlotsCreated = true

	local generator = PlotsFolder:FindFirstChild("PlotGenerator")
	if not generator then
		warn("PlotGenerator not found")
		return
	end

	for _, marker in ipairs(generator:GetChildren()) do
		if not marker:IsA("BasePart") then continue end

		local order = tonumber(marker.Name)
		if not order then continue end

		local plot = PlotTemplate:Clone()
		plot.Name = HttpService:GenerateGUID(false)
		plot:SetAttribute("Order", order)
		plot:AddTag("Plot")

		plot:PivotTo(marker.CFrame * CFrame.new(0, -0.5, 0))
		plot.Parent = PlotsFolder
	end

	generator:Destroy()
end

local function GetPlayersInHitbox(Hitbox: BasePart): { number }
	local PlayersFound = {}
	local PlayerIds = {}

	local TouchingParts = workspace:GetPartsInPart(Hitbox)
	for _, Part in ipairs(TouchingParts) do
		local Character = Part.Parent
		if Character and Character:FindFirstChildOfClass("Humanoid") then
			local Player = Players:GetPlayerFromCharacter(Character)
			if Player and not PlayerIds[Player.UserId] then
				table.insert(PlayersFound, Player.UserId)
				PlayerIds[Player.UserId] = true
			end
		end
	end

	return PlayersFound
end

function PlotService.getPlot(Player)
	return _G.playerPlots[Player.UserId]
end

local function MonitorStealing(Player: Player)
	if StealingMonitors[Player] then
		if StealingMonitors[Player].connection then
			StealingMonitors[Player].connection:Disconnect()
		end
		StealingMonitors[Player] = nil
	end

	local Plot = PlotService.getPlot(Player)
	if not Plot then
		return
	end

	local DeliveryHitboxes = {}
	for _, Part in Plot:GetChildren() do
		if Part.Name == "DeliveryHitbox" then
			table.insert(DeliveryHitboxes, Part)
		end
	end

	if #DeliveryHitboxes == 0 then
		warn("No DeliveryHitbox found for player:", Player.Name)
		return
	end

	StealingMonitors[Player] = {
		cancelled = false,
		connection = nil
	}

	local Connection = RunService.Heartbeat:Connect(function()
		if StealingMonitors[Player] and StealingMonitors[Player].cancelled then
			return
		end

		if not Player:GetAttribute("Stealing") then
			if StealingMonitors[Player] and StealingMonitors[Player].connection then
				StealingMonitors[Player].connection:Disconnect()
				StealingMonitors[Player] = nil
			end
			return
		end

		local Character = Player.Character
		if not Character or not Character:FindFirstChild("HumanoidRootPart") then
			return
		end

		local OverlapParams = OverlapParams.new()
		OverlapParams.FilterDescendantsInstances = DeliveryHitboxes
		OverlapParams.FilterType = Enum.RaycastFilterType.Include
		OverlapParams.MaxParts = 1

		local PlayerPosition = Character:GetPivot().Position
		local PartsInBox = workspace:GetPartBoundsInBox(
			CFrame.new(PlayerPosition), 
			Vector3.new(4, 4, 2), 
			OverlapParams
		)

		if #PartsInBox > 0 then
			StealService:CompleteSteal(Player)
			PlotService.RemoveFromQueue(Player) 

			if StealingMonitors[Player] and StealingMonitors[Player].connection then
				StealingMonitors[Player].connection:Disconnect()
				StealingMonitors[Player] = nil
			end
		end
	end)

	StealingMonitors[Player].connection = Connection
end

function PlotService.CancelStealing(Player: Player)
	if StealingMonitors[Player] then
		StealingMonitors[Player].cancelled = true
		if StealingMonitors[Player].connection then
			StealingMonitors[Player].connection:Disconnect()
		end
		StealingMonitors[Player] = nil
		PlotService.RemoveFromQueue(Player)

		if StealService.CancelSteal then
			StealService:CancelSteal(Player)
		end
	end
end

local function CleanupPlotConnections(Plot: Model)
	local Connections = PlotTouchedConnections[Plot]
	if Connections then
		for _, Conn in ipairs(Connections) do
			Conn:Disconnect()
		end
		PlotTouchedConnections[Plot] = nil
	end
end

function PlotService:GetBaseMultiplier(Player: Player)
	local Rebirths = require(ReplicatedStorage.Datas.Rebirth)
	local Mutations = require(ReplicatedStorage.Datas.Mutations)
	local Plot = PlotService.getPlot(Player)
	local PlayerChannel = Synchronizer:Get(Player)

	if not Plot or not PlayerChannel then
		return
	end

	local PlotChannel = Synchronizer:Get(Plot.Name)

	if not PlotChannel then
		return
	end

	local RebirthLevel = PlayerChannel:Get("Rebirth")

	local TotalMultiplier = 1
	local RebirthData = Rebirths[RebirthLevel]
	if RebirthData and RebirthData.Rewards and RebirthData.Rewards.Multiplier then
		TotalMultiplier = TotalMultiplier + RebirthData.Rewards.Multiplier
	end

	local Index = PlayerChannel:Get("Index") or {}
	local MutationKeys = { Default = true, Gold = true, Diamond = true, Rainbow = true, Candy = true }

	local Animals = require(ReplicatedStorage.Datas.Animals)
	local CompletedSets = 0

	if CompletedSets > 0 then
		TotalMultiplier = TotalMultiplier + 0.5 * CompletedSets
	end

	return TotalMultiplier
end

function PlotService.replacePlot(Player: Player, NewPlotModel: any): any
	local OldPlot: Model = PlotService.getPlot(Player)
	if not OldPlot then
		return
	end

	local PlotName = OldPlot.Name
	local PlotCFrame = OldPlot:GetPivot()

	CleanupPlotConnections(OldPlot)
	PlotOwners[OldPlot] = nil

	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		return
	end

	local RebirthLevel = PlayerChannel:Get("Rebirth") or 0
	local BaseData = BasesData[RebirthLevel]

	local AnimalPodiumsFolder = NewPlotModel:FindFirstChild("AnimalPodiums")

	if AnimalPodiumsFolder and BaseData and BaseData.MaxAnimals then
		local Podiums = AnimalPodiumsFolder:GetChildren()

		for _, Podium in pairs(Podiums) do
			local PodiumIndex = tonumber(Podium.Name)

			if PodiumIndex and PodiumIndex > BaseData.MaxAnimals then
				Podium:Destroy()
			end
		end
	end

	PlotService.assignPlot(NewPlotModel, Player, PlotName)

	for _, Main in pairs(NewPlotModel.Unlock:GetDescendants()) do
		if Main.Name == "Main" then
			Main.UnlockBase.Enabled = false
		end
	end

	if NewPlotModel.PrimaryPart then
		NewPlotModel.PrimaryPart.Anchored = true
	end

	NewPlotModel:PivotTo(PlotCFrame)
	NewPlotModel.Parent = workspace.Plots
	OldPlot:Destroy()

	NewPlotModel:SetAttribute("Tier", RebirthLevel)

	local MultiplierValue = 1
	if RebirthLevel > 0 then
		MultiplierValue = PlotService:GetBaseMultiplier(Player) or 1
	end

	if NewPlotModel:FindFirstChild("Multiplier") and NewPlotModel.Multiplier:FindFirstChild("Main") then
		NewPlotModel.Multiplier.Main.Amount.Text = string.format("x%d", MultiplierValue)
	end

	NewPlotModel:SetAttribute("Loaded", true)

	task.defer(function()
		local Skin = PlayerChannel:Get("Settings.Base Skin")
		if Skin then
			SkinService:Apply(Skin, NewPlotModel)
		end
	end)

	return NewPlotModel
end

function PlotService.resetPlot(PlotToReset: Model)
	if not PlotToReset or not PlotToReset.Parent then
		return
	end

	local PlotCFrame = PlotToReset:GetPivot()
	local PlotName = PlotToReset.Name

	CleanupPlotConnections(PlotToReset)
	PlotOwners[PlotToReset] = nil

	local NewDefaultPlot = FirstFloor:Clone()

	if NewDefaultPlot.PrimaryPart then
		NewDefaultPlot.PrimaryPart.Anchored = true
	end

	NewDefaultPlot.Name = PlotName
	NewDefaultPlot.PlotSign.SurfaceGui.Frame.TextLabel.Text = "Empty Base"
	NewDefaultPlot.PlotSign.YourBase.Enabled = false
	NewDefaultPlot:SetAttribute("Tier", 0)
	NewDefaultPlot:AddTag("Plot")

	local Multiplier = NewDefaultPlot:FindFirstChild("Multiplier")
	if Multiplier then
		Multiplier.Main.Enabled = false
	end

	for _, Main in pairs(NewDefaultPlot.Unlock:GetDescendants()) do
		if Main.Name == "Main" then
			Main.UnlockBase.Enabled = false
		end
	end

	for _, Laser in pairs(NewDefaultPlot.Laser:GetDescendants()) do
		if Laser:IsA("BasePart") then
			Laser.Transparency = 1
		end
	end

	NewDefaultPlot:PivotTo(PlotCFrame)
	NewDefaultPlot.Parent = workspace.Plots
	PlotToReset:Destroy()

	NewDefaultPlot:SetAttribute("Loaded", true)
end

function PlotService.getFreePlot()
	local Plots = workspace.Plots:GetChildren()

	table.sort(Plots, function(a, b)
		return (a:GetAttribute("Order") or 0) < (b:GetAttribute("Order") or 0)
	end)

	for _, Plot in ipairs(Plots) do
		if not PlotOwners[Plot] and not Plot:GetAttribute("BaseCheckPreview") then
			return Plot
		end
	end

	return nil
end

function PlotService.getFreePlots()
	local Plots = workspace.Plots:GetChildren()

	table.sort(Plots, function(a, b)
		return (a:GetAttribute("Order") or 0) < (b:GetAttribute("Order") or 0)
	end)

	local FreePlots = {}
	for _, Plot in ipairs(Plots) do
		if not PlotOwners[Plot] and not Plot:GetAttribute("BaseCheckPreview") and Plot:HasTag("Plot") then
			table.insert(FreePlots, Plot)
		end
	end

	return FreePlots
end

function PlotService.movePlayerToFreePlot(Player: Player, TargetPlot: Model)
	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		return false, "Your data is still loading."
	end

	local OldPlot = PlotService.getPlot(Player)
	if not OldPlot then
		return false, "You don't have a base to move from."
	end

	if not TargetPlot or not TargetPlot.Parent then
		return false, "Target base no longer exists."
	end

	if PlotOwners[TargetPlot] then
		return false, "This base is no longer available."
	end

	local TargetCFrame = TargetPlot:GetPivot()
	local TargetPlotName = TargetPlot.Name

	-- Disconnect CharacterAdded connection
	if CharacterAddedConnections[Player.UserId] then
		CharacterAddedConnections[Player.UserId]:Disconnect()
		CharacterAddedConnections[Player.UserId] = nil
	end

	-- Disconnect PlotUpdate connection
	if PlotUpdateConnections[Player] then
		PlotUpdateConnections[Player]:Disconnect()
		PlotUpdateConnections[Player] = nil
	end

	-- Cancel any active stealing
	PlotService.CancelStealing(Player)

	-- Reset the old plot (creates a fresh default plot at old position, frees it)
	PlotService.resetPlot(OldPlot)
	_G.playerPlots[Player.UserId] = nil

	-- Clean up old plot's Synchronizer channel
	for PlotChannel, OwnerName in pairs(ActivePlotConnections) do
		if OwnerName == Player.Name then
			local CleanupData = {
				Owner = "nil",
				AnimalList = {},
				FriendsAllowed = false,
				BlockEndTime = "nil",
				BlockEndTimeFirstFloor = "nil",
				BlockEndTimeSecondFloor = "nil",
				BlockEndTimeThirdFloor = "nil",
				BlockedDelayTime = "nil",
			}
			for Key, Value in pairs(CleanupData) do
				if Value == "nil" then
					PlotChannel:Set(Key, nil)
				else
					PlotChannel:Set(Key, Value)
				end
			end
			ActivePlotConnections[PlotChannel] = nil
			break
		end
	end

	-- Build a basic base model at the target position
	local RebirthLevel = PlayerChannel:Get("Rebirth") or 0
	local BaseData = BasesData[RebirthLevel]
	if not BaseData or not BaseData.Model then
		return false, "Could not determine base model."
	end

	local NewPlotClone = BaseData.Model:Clone()
	if NewPlotClone.PrimaryPart then
		NewPlotClone.PrimaryPart.Anchored = true
	end

	-- Trim podiums based on MaxAnimals
	local AnimalPodiumsFolder = NewPlotClone:FindFirstChild("AnimalPodiums")
	if AnimalPodiumsFolder and BaseData.MaxAnimals then
		for _, Podium in pairs(AnimalPodiumsFolder:GetChildren()) do
			local PodiumIndex = tonumber(Podium.Name)
			if PodiumIndex and PodiumIndex > BaseData.MaxAnimals then
				Podium:Destroy()
			end
		end
	end

	NewPlotClone:SetAttribute("Tier", RebirthLevel)

	-- Assign the new plot to the player
	PlotService.assignPlot(NewPlotClone, Player, TargetPlotName)

	-- Position at target and parent
	NewPlotClone:PivotTo(TargetCFrame)
	NewPlotClone.Parent = workspace.Plots

	-- Destroy the old free plot at the target position
	TargetPlot:Destroy()

	-- Rebuild with proper skin (replaces the basic model with the skinned version)
	PlotService:RebuildBase(Player)

	-- Get the final plot
	local FinalPlot = PlotService.getPlot(Player)
	if not FinalPlot then
		return false, "Failed to build new base."
	end

	-- Teleport player and set up CharacterAdded connection
	local SpawnPart = FinalPlot:FindFirstChild("Spawn")
	if SpawnPart then
		local Character = Player.Character
		if Character then
			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
			if HumanoidRootPart then
				HumanoidRootPart.CFrame = SpawnPart.CFrame
			end
		end

		CharacterAddedConnections[Player.UserId] = Player.CharacterAdded:Connect(function(Character: Model)
			local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart") :: BasePart
			HumanoidRootPart.CFrame = SpawnPart.CFrame
		end)
	end

	FinalPlot:SetAttribute("Player", Player.Name)
	FinalPlot:SetAttribute("Loaded", true)

	return true
end

function PlotService.assignPlot(Plot: any, Player: Player, PlotName: string?)
	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		return
	end

	if PlotUpdateConnections[Player] then
		PlotUpdateConnections[Player]:Disconnect()
		PlotUpdateConnections[Player] = nil
	end

	Plot.PlotSign.SurfaceGui.Frame.TextLabel.Text = Player and string.format("%s's Base", Player.DisplayName)
		or "Empty Base"
	Plot.Name = HttpService:GenerateGUID(false)
	Plot.PlotSign.YourBase.Enabled = false

	local Skin = PlayerChannel:Get("Settings.Base Skin")
	SkinService:Apply(Skin, Plot)

	_G.playerPlots[Player.UserId] = Plot
	PlotOwners[Plot] = Player

	local GracePeriod = START_GRACE_PERIOD

	local isDeduplicating = false

	-- Anti-duplication helper: remove brainrots with identical Index + Mutation + Traits
	-- Returns the number of duplicates removed
	local function deduplicatePodiums(podiums)
		local seen = {}
		local duplicateCount = 0
		for index, animalInfo in pairs(podiums) do
			if typeof(animalInfo) == "table" and not animalInfo.Steal and not animalInfo.Machine and not animalInfo.InTrade then
				local animalEntry = AnimalData[animalInfo.Index]
				local isLucky = animalEntry and animalEntry.LuckyBlock
				if not isLucky then
					local key = GetBrainrotKey(animalInfo.Index, animalInfo.Mutation, animalInfo.Traits)
					if seen[key] then
						podiums[index] = "Empty"
						duplicateCount = duplicateCount + 1
					else
						seen[key] = true
					end
				end
			end
		end
		return duplicateCount
	end

	local initialDuplicateCount = 0
	local InitialData = {
		Owner = Player,
		AnimalList = (function()
			local initialPodiums = PlayerChannel:Get("AnimalPodiums") or {}
			initialDuplicateCount = deduplicatePodiums(initialPodiums)
			-- Persist deduplication back to AnimalPodiums so it saves
			if initialDuplicateCount > 0 then
				PlayerChannel:Set("AnimalPodiums", initialPodiums)
			end
			return initialPodiums
		end)(),
		FriendsAllowed = false,
		BlockEndTime = os.time() + GracePeriod,
		BlockEndTimeFirstFloor = workspace:GetServerTimeNow() + GracePeriod,
		BlockEndTimeSecondFloor = workspace:GetServerTimeNow() + GracePeriod,
		BlockEndTimeThirdFloor = workspace:GetServerTimeNow() + GracePeriod,
		BlockedDelayTime = workspace:GetServerTimeNow() + GracePeriod,
	}

	local PlotChannel = Synchronizer:Get(Plot.Name)
	if PlotChannel then
		for Key, Value in pairs(InitialData) do
			PlotChannel:Set(Key, Value)
		end
	else
		PlotChannel = Synchronizer:Create(Plot.Name, InitialData)
	end

	-- Notify player about pre-existing duplicates that were removed
	if initialDuplicateCount > 0 then
		task.delay(2, function()
			if Player and Player.Parent then
				NotificationService.Error(Player, "Detected by anti-duplication")
			end
		end)
		warn(string.format("[Anti-Duplication] Removed %d duplicate brainrots from %s's base on join", initialDuplicateCount, Player.Name))
	end

	-- Delayed re-deduplication to catch data that loads after plot assignment
	task.delay(5, function()
		if Player and Player.Parent and Plot and Plot.Parent then
			local delayedPodiums = PlayerChannel:Get("AnimalPodiums")
			if delayedPodiums then
				local delayedCount = deduplicatePodiums(delayedPodiums)
				if delayedCount > 0 then
					PlayerChannel:Set("AnimalPodiums", delayedPodiums)
					PlayerChannel:Set("AnimalAddedOrRemoved", true)
					NotificationService.Error(Player, "Detected by anti-duplication")
					warn(string.format("[Anti-Duplication] Removed %d duplicate brainrots from %s's base (delayed scan)", delayedCount, Player.Name))
				end
			end
		end
	end)

	task.delay(GracePeriod, function()
		if Player and Plot:FindFirstChild("Laser") and PlotChannel and getmetatable(PlotChannel) then
			local BlockEnd = PlotChannel:Get("BlockEndTime")

			if not BlockEnd or os.time() >= BlockEnd then
				PlotChannel:Set("GrandfatheredThieves", nil)
				PlotChannel:Set("BlockEndTime", nil)
				PlotChannel:Set("BlockEndTimeFirstFloor", nil)
				PlotChannel:Set("BlockEndTimeSecondFloor", nil)
				PlotChannel:Set("BlockEndTimeThirdFloor", nil)
				PlotChannel:Set("BlockedDelayTime", nil)

				for _, Laser in pairs(Plot.Laser:GetDescendants()) do
					if Laser:IsA("BasePart") then
						Laser.Transparency = 1
					end
				end
			end
		end
	end)

	local function OnPodiumsChanged()
		if isDeduplicating then return end
		local CurrentPodiums = PlayerChannel:Get("AnimalPodiums")
		if not CurrentPodiums then return end
		-- Anti-duplication: remove brainrots with identical Index + Mutation + Traits
		local dupCount = deduplicatePodiums(CurrentPodiums)
		if dupCount > 0 then
			isDeduplicating = true
			PlayerChannel:Set("AnimalPodiums", CurrentPodiums)
			PlayerChannel:Set("AnimalAddedOrRemoved", true)
			isDeduplicating = false
			NotificationService.Error(Player, "Detected by anti-duplication")
			warn(string.format("[Anti-Duplication] Removed %d duplicate brainrots from %s's base", dupCount, Player.Name))
		end
		-- Compute global brainrot counts and add GlobalCount to each animal
		ComputeBrainrotCounts()
		for _, animalInfo in pairs(CurrentPodiums) do
			if typeof(animalInfo) == "table" then
				local key = GetBrainrotKey(animalInfo.Index, animalInfo.Mutation, animalInfo.Traits)
				animalInfo.GlobalCount = BrainrotCounts[key] or 1
			end
		end
		PlotChannel:Set("AnimalList", CurrentPodiums)
		-- Delayed update for other players' plots (their counts may have changed)
		task.delay(0.5, UpdateAllPlotAnimalLists)
	end

	PlotUpdateConnections[Player] = PlayerChannel:OnChanged("AnimalAddedOrRemoved", function()
		OnPodiumsChanged()

		local currentSkin = PlayerChannel:Get("Settings.Base Skin")
		local requiredAnimal = BaseRequirements[currentSkin]

		if requiredAnimal then
			if not HasRequiredAnimal(Player, requiredAnimal) then
				PlayerChannel:Set("Settings.Base Skin", "Normal")
				PlotService:RebuildBase(Player)
			end
		end
	end)

	-- FIX: Re-sync AnimalList after a delay in case AnimalPodiums data loads after plot assignment
	-- This handles the race condition where DataStore data arrives after assignPlot runs
	task.defer(function()
		if Plot and Plot.Parent and PlotChannel and getmetatable(PlotChannel) then
			local currentPodiums = PlayerChannel:Get("AnimalPodiums")
			if currentPodiums then
				PlotChannel:Set("AnimalList", currentPodiums)
			end
		end
	end)

	task.delay(3, function()
		if Plot and Plot.Parent and PlotChannel and getmetatable(PlotChannel) then
			local currentPodiums = PlayerChannel:Get("AnimalPodiums")
			if currentPodiums then
				PlotChannel:Set("AnimalList", currentPodiums)
			end
		end
	end)

	if PlotChannel then
		for _, Player: Player in pairs(Players:GetPlayers()) do
			PlotChannel:AddListener(Player)
		end

		ActivePlotConnections[PlotChannel] = Player.Name
	end

	local CurrentRebirth = PlayerChannel:Get("Rebirth")
	if not CurrentRebirth then
		return
	end

	local RebirthData = Rebirth[CurrentRebirth]
	if RebirthData then
		local MultiplierValue = 1
		if CurrentRebirth > 0 then
			MultiplierValue = PlotService:GetBaseMultiplier(Player) or 1
		end

		if Plot:FindFirstChild("Multiplier") and Plot.Multiplier:FindFirstChild("Main") then
			Plot.Multiplier.Main.Amount.Text = string.format("x%d", MultiplierValue)
		end
	end
	Plot:AddTag("Plot")
end

_G.playerQueue = _G.playerQueue or {} :: { [number]: {number} }

function PlotService.getFreePodium(Player): Model?
	local Plot = PlotService.getPlot(Player) :: any
	if not Plot then
		warn("GetFreePodium: Could not find a plot for player: " .. Player.Name)
		return
	end

	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		warn("GetFreePodium: Could not find a player channel for: " .. Player.Name)
		return
	end

	local AnimalData = PlayerChannel:Get("AnimalPodiums") or {}

	do
		local queue = _G.playerQueue[Player.UserId]
		if queue then
			for i = #queue, 1, -1 do
				local index = queue[i]
				if AnimalData[index] == "Empty" or AnimalData[index] == nil then
					table.remove(queue, i)
				end
			end

			if #queue == 0 then
				_G.playerQueue[Player.UserId] = nil
			end
		end
	end

	local AllPodiums = Plot.AnimalPodiums:GetChildren()

	table.sort(AllPodiums, function(A, B)
		return tonumber(A.Name) < tonumber(B.Name)
	end)

	local emptyCount = 0
	local queuedCount = #(_G.playerQueue[Player.UserId] or {})
	for _, Podium in ipairs(AllPodiums) do
		local PodiumIndex = tonumber(Podium.Name)
		if not PodiumIndex then
			continue
		end
		local PodiumData = AnimalData[PodiumIndex]
		if PodiumData == "Empty" or PodiumData == nil then
			emptyCount += 1
		end
	end

	if emptyCount - queuedCount <= 0 then
		return nil
	end

	for _, Podium in ipairs(AllPodiums) do
		local PodiumIndex = tonumber(Podium.Name)
		if not PodiumIndex then
			continue
		end

		local PodiumData = AnimalData[PodiumIndex]
		if PodiumData == "Empty" or PodiumData == nil then
			local isQueued = false
			local playerQueue = _G.playerQueue[Player.UserId] or {}
			for _, queuedIndex in ipairs(playerQueue) do
				if queuedIndex == PodiumIndex then
					isQueued = true
					break
				end
			end
			if not isQueued then
				return Podium
			end
		end
	end

	return nil
end

function PlotService:IsBaseFull(Player: Player): boolean
	local Plot = PlotService.getPlot(Player)
	if not Plot then
		return true
	end

	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		return true
	end

	local AnimalData = PlayerChannel:Get("AnimalPodiums") or {}
	local queuedCount = #(_G.playerQueue[Player.UserId] or {})

	local AllPodiums = Plot.AnimalPodiums:GetChildren()

	local emptyCount = 0
	for _, Podium in ipairs(AllPodiums) do
		local PodiumIndex = tonumber(Podium.Name)
		if not PodiumIndex then
			continue
		end

		local PodiumData = AnimalData[PodiumIndex]
		if PodiumData == "Empty" or PodiumData == nil then
			emptyCount += 1
		end
	end

	return emptyCount - queuedCount <= 0
end

function PlotService.AddToQueue(Player: Player, plotNumber: number)
	if not plotNumber then
		warn("AddToQueue: plotNumber is nil for player " .. Player.Name)
		return
	end

	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		warn("AddToQueue: Could not find player channel for " .. Player.Name)
		return
	end

	local AnimalData = PlayerChannel:Get("AnimalPodiums") or {}
	if AnimalData[plotNumber] and AnimalData[plotNumber] ~= "Empty" then
		warn("AddToQueue: Podium " .. plotNumber .. " is not empty for player " .. Player.Name)
		return
	end

	_G.playerQueue[Player.UserId] = _G.playerQueue[Player.UserId] or {}
	table.insert(_G.playerQueue[Player.UserId], plotNumber)
end

function PlotService.RemoveFromQueue(Player: Player, plotNumber: number?)
	if not _G.playerQueue[Player.UserId] then
		return
	end

	if plotNumber then
		local queue = _G.playerQueue[Player.UserId]
		for i, queuedIndex in ipairs(queue) do
			if queuedIndex == plotNumber then
				table.remove(queue, i)
				break
			end
		end
		if #queue == 0 then
			_G.playerQueue[Player.UserId] = nil
		end
	else
		_G.playerQueue[Player.UserId] = nil
	end
end

function PlotService.AddAnimalOnPlotOrQueue(Player: Player, AnimalName: string, Mutation: string?, Traits: any?)
	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then return end

	local freePodium = PlotService.getFreePodium(Player)
	if freePodium then
		local AnimalService = require(ServerScriptService.Services.AnimalService)
		AnimalService.spawnAnimalInBase(Player, AnimalName, Mutation, Traits)
	else
		local queue = PlayerChannel:Get("AnimalsQueue") or {}
		table.insert(queue, {
			Name = AnimalName,
			Mutation = Mutation,
			Traits = Traits,
		})
		PlayerChannel:Set("AnimalsQueue", queue)
		NotificationService.Notify(Player, "Your base is full! Animal added to queue.", 3, "Sounds.Sfx.Error")
	end
end

function PlotService.ProcessQueue(Player: Player)
	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then return end

	local queue = PlayerChannel:Get("AnimalsQueue") or {}
	if #queue == 0 then return end

	local AnimalService = require(ServerScriptService.Services.AnimalService)
	local newQueue = {}

	for _, item in ipairs(queue) do
		local freePodium = PlotService.getFreePodium(Player)
		if freePodium then
			AnimalService.spawnAnimalInBase(Player, item.Name, item.Mutation, item.Traits)
		else
			table.insert(newQueue, item)
		end
	end

	if #newQueue ~= #queue then
		PlayerChannel:Set("AnimalsQueue", newQueue)
	end
end

function PlotService.LockBase(Player: Player, Override: boolean)
	local Plot = PlotService.getPlot(Player)
	local PlayerChannel = Synchronizer:Get(Player)

	if not Plot or not PlayerChannel then
		return
	end

	local PlotChannel = Synchronizer:Get(Plot.Name)

	if not PlotChannel then
		return
	end

	local CurrentTime = os.time()
	local BlockEndTime = PlotChannel:Get("BlockEndTime")
	if BlockEndTime and CurrentTime < BlockEndTime and not Override then
		NotificationService.Error(Player, "Your base is already locked!")
		return
	end

	local RebirthLevel = PlayerChannel:Get("Rebirth")
	local ExtraTime = RebirthData[RebirthLevel] and RebirthData[RebirthLevel].Rewards.AdditionalLockTime or 0
	local TotalTime = BASE_LOCK_TIME + ExtraTime

	local StealHitbox = Plot:FindFirstChild("StealHitbox")
	if StealHitbox then
		local PlayersToGrandfather = GetPlayersInHitbox(StealHitbox)
		PlotChannel:Set("GrandfatheredThieves", PlayersToGrandfather)
	end

	PlotChannel:Set("BlockEndTime", os.time() + TotalTime)
	PlotChannel:Set("BlockEndTimeFirstFloor", workspace:GetServerTimeNow() + TotalTime)
	PlotChannel:Set("BlockEndTimeSecondFloor", workspace:GetServerTimeNow() + TotalTime)
	PlotChannel:Set("BlockEndTimeThirdFloor", workspace:GetServerTimeNow() + TotalTime)
	PlotChannel:Set("BlockedDelayTime", workspace:GetServerTimeNow() + TotalTime)

	for _, Laser: Instance in pairs(Plot.Laser:GetDescendants()) do
		if Laser:IsA("BasePart") then
			Laser.Transparency = 0
		end
	end

	NotificationService.Success(Player, string.format("You locked your base for %d Seconds!", TotalTime))

	task.wait(TotalTime)

	if Player and PlotChannel and getmetatable(PlotChannel) and Plot:FindFirstChild("Laser") then
		PlotChannel:Set("GrandfatheredThieves", nil)
		PlotChannel:Set("BlockEndTime", nil)
		PlotChannel:Set("BlockEndTimeFirstFloor", nil)
		PlotChannel:Set("BlockEndTimeSecondFloor", nil)
		PlotChannel:Set("BlockEndTimeThirdFloor", nil)
		PlotChannel:Set("BlockedDelayTime", nil)

		for _, Laser: Instance in pairs(Plot.Laser:GetDescendants()) do
			if Laser:IsA("BasePart") then
				Laser.Transparency = 1
			end
		end
	end
end

local function Init(Plot: Model)
	if InitializedPlots[Plot] then return end
	if Plot.Name == "PlotGenerator" or not Plot:FindFirstChild("Purchases") then
		return
	end

	InitializedPlots[Plot] = true

	PlotTouchedConnections[Plot] = {}

	local Alerted = os.time()

	local PlotChannel = Synchronizer:Get(Plot.Name)
	if PlotChannel then
		PlotChannel:Set("GrandfatheredThieves", nil)
	end

	for _, PlotBlock: any in pairs(Plot.Purchases:GetChildren()) do
		if PlotBlock:IsA("Model") then
			local Connection = PlotBlock.Hitbox.Touched:Connect(function(Hit)
				local Player = Players:GetPlayerFromCharacter(Hit.Parent)

				local Owner = PlotOwners[Plot]
				if not Player or Player ~= Owner then
					return
				end

				if not PlotChannel then
					return
				end

				local PlayerChannel = Synchronizer:Get(Player)
				if not PlayerChannel then
					return
				end

				if os.time() - Alerted < 2 then
					return
				end

				Alerted = os.time()
				PlotService.LockBase(Player, false)
			end)

			table.insert(PlotTouchedConnections[Plot], Connection)
		end
	end
end

function PlotService:Start()
	workspace.Plots.ChildAdded:Connect(Init)
	for _, Plot in ipairs(workspace.Plots:GetChildren()) do
		Init(Plot)
	end
end

Steal.OnServerEvent:Connect(function(Player: Player, _, _, VictimPlotUID: string, PodiumIndex: number)
	local VictimPlotChannel = Synchronizer:Get(VictimPlotUID)
	if not VictimPlotChannel then
		return
	end

	local VictimPlayer = VictimPlotChannel:Get("Owner") :: Player
	if not VictimPlayer then
		return
	end

	local Plot = PlotService.getPlot(VictimPlayer)
	if not Plot then
		return
	end

	local Podium = PlotService.getFreePodium(Player)
	if not Podium then
		NotificationService.Error(Player, "You need more room in your base to steal a brainrot.")
		return
	end

	local StealHitbox = Plot:FindFirstChild("StealHitbox") :: BasePart
	if not StealHitbox then
		return
	end

	local Character = Player.Character
	if not Character then
		return
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	if not HumanoidRootPart then
		return
	end

	local OverlapParams = OverlapParams.new()
	OverlapParams.FilterDescendantsInstances = {StealHitbox}
	OverlapParams.FilterType = Enum.RaycastFilterType.Include
	OverlapParams.MaxParts = 1

	local HRPPosition = HumanoidRootPart.Position
	local PartsInBox = workspace:GetPartBoundsInBox(
		CFrame.new(HRPPosition),
		HumanoidRootPart.Size,
		OverlapParams
	)

	if #PartsInBox == 0 then
		return
	end

	local AnimalList = VictimPlotChannel:Get("AnimalList")
	local AnimalInfo = AnimalList and AnimalList[PodiumIndex]

	if AnimalInfo and AnimalInfo.Machine and AnimalInfo.Machine.Active == true then
		return
	end

	StealService:StartSteal(Player, VictimPlotUID, PodiumIndex)

	MonitorStealing(Player)
end)

ClaimCoins.OnServerEvent:Connect(function(Player: Player, PodiumIndex: number)
	local PlayerChannel = Synchronizer:Get(Player)
	assert(PlayerChannel)

	local AnimalList = PlayerChannel:Get("AnimalPodiums")
	if not AnimalList or typeof(AnimalList[PodiumIndex]) ~= "table" then
		return
	end

	local AnimalInfo = AnimalList[PodiumIndex]
	if not AnimalInfo then
		return
	end

	if AnimalInfo.Machine then
		return
	end

	local TimeNow = workspace:GetServerTimeNow()

	local TimeElapsed = math.floor(TimeNow - AnimalInfo.LastCollect)
	if TimeElapsed <= 0 then
		return
	end

	local Generation = SharedAnimals:GetGeneration(AnimalInfo.Index, AnimalInfo.Mutation, AnimalInfo.Traits, Player)
	local MoneyGained = TimeElapsed * Generation

	if AnimalInfo.OfflineGain and AnimalInfo.OfflineGain > 0 then
		MoneyGained += AnimalInfo.OfflineGain * Generation
		AnimalInfo.OfflineGain = nil
	end

	MoneyService:Add(Player, MoneyGained)

	AnimalInfo.LastCollect = TimeNow
	PlayerChannel:Set("AnimalPodiums", AnimalList)
	PlayerChannel:Set("AnimalAddedOrRemoved", true)

	CashCollected:FireClient(Player)
end)

Sell.OnServerEvent:Connect(function(Player: Player, PodiumIndex: number)
	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then
		return
	end

	local Plot = PlotService.getPlot(Player)
	if not Plot then return end

	local AnimalList = PlayerChannel:Get("AnimalPodiums")
	if not AnimalList or typeof(AnimalList[PodiumIndex]) ~= "table" then
		return
	end

	local AnimalInfo = AnimalList[PodiumIndex]
	if AnimalInfo.Steal and AnimalInfo.Steal ~= false then
		local stealingUserId = AnimalInfo.Steal
		if StealService:IsStealActiveOnPodium(stealingUserId, Plot.Name, PodiumIndex) then
			return
		end
		warn(string.format("[PlotService] Clearing stale Steal flag on sell podium %d (was UserId %d)", PodiumIndex, stealingUserId))
		AnimalInfo.Steal = nil
		PlayerChannel:Set("AnimalPodiums", AnimalList)
	end

	local Price = AnimalData[AnimalInfo.Index].Price or 0
	MoneyService:Add(Player, math.round(Price / 2))

	AnimalList[PodiumIndex] = "Empty"
	PlotService.RemoveFromQueue(Player, PodiumIndex)
	PlayerChannel:Set("AnimalPodiums", AnimalList)
	PlayerChannel:Set("AnimalAddedOrRemoved", true)
end)

Open.OnServerEvent:Connect(function(Player: Player, PodiumIndex: number)
	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then return end

	local Plot = PlotService.getPlot(Player)
	if not Plot then return end

	local AnimalList = PlayerChannel:Get("AnimalPodiums")
	if not AnimalList or typeof(AnimalList[PodiumIndex]) ~= "table" then
		return
	end

	local LuckyBlockInfo = AnimalList[PodiumIndex]
	if LuckyBlockInfo.Steal and LuckyBlockInfo.Steal ~= false then
		local stealingUserId = LuckyBlockInfo.Steal
		if StealService:IsStealActiveOnPodium(stealingUserId, Plot.Name, PodiumIndex) then
			return
		end
		warn(string.format("[PlotService] Clearing stale Steal flag on lucky block podium %d (was UserId %d)", PodiumIndex, stealingUserId))
		LuckyBlockInfo.Steal = nil
		PlayerChannel:Set("AnimalPodiums", AnimalList)
	end

	local blockName = LuckyBlockInfo.Index

	local ForcedAnimal = PlayerChannel:Get("ForcedLuckyAnimal")
	local WinningAnimalName

	if ForcedAnimal then
		WinningAnimalName = ForcedAnimal
		PlayerChannel:Set("ForcedLuckyAnimal", nil)
	else
		WinningAnimalName = LuckyBlocks.Roll(blockName)
	end

	if not WinningAnimalName then return end

	local NewAnimalInfo = {
		Index = WinningAnimalName,
		LastCollect = workspace:GetServerTimeNow(),
		Mutation = LuckyBlockInfo.Mutation,
		Traits = LuckyBlockInfo.Traits,
	}

	AnimalList[PodiumIndex] = NewAnimalInfo
	PlayerChannel:Set("AnimalPodiums", AnimalList)
	PlayerChannel:Set("AnimalAddedOrRemoved", true)

	Open:FireAllClients(
		Plot.Name,
		PodiumIndex,
		blockName,
		NewAnimalInfo.Index,
		NewAnimalInfo.Mutation,
		NewAnimalInfo.Traits
	)
end)

ToggleFriends.OnServerEvent:Connect(function(Player: Player)
	local Plot = PlotService.getPlot(Player)
	if not Plot then
		return
	end

	local PlotChannel = Synchronizer:Get(Plot.Name)
	if not PlotChannel then
		return
	end

	local CurrentStatus = PlotChannel:Get("FriendsAllowed")
	local NewStatus = not CurrentStatus

	PlotChannel:Set("FriendsAllowed", NewStatus)
end)

function PlayerAdded(Player: Player)
	local PlayerChannel = Synchronizer:Wait(Player)
	CreatePlotsFromGenerator()
	assert(PlayerChannel)

	PlayerChannel:OnChanged("Settings.Base Skin", function(newSkin)
		if not newSkin then return end
		PlotService:RebuildBase(Player)
	end)

	PlayerChannel:OnChanged("Rebirth", function()
		PlotService:RebuildBase(Player)
	end)

	local LastLogout = PlayerChannel:Get("LastLogoutTime")
	if LastLogout then
		local OfflineDuration = os.time() - LastLogout
		OfflineDuration = math.min(OfflineDuration, MAX_OFFLINE_SECONDS)
		if OfflineDuration > 0 then
			local AnimalList = PlayerChannel:Get("AnimalPodiums")
			local HasChanges = false
			if AnimalList then
				for _, AnimalInfo in pairs(AnimalList) do
					if typeof(AnimalInfo) == "table" and AnimalInfo.LastCollect then
						AnimalInfo.OfflineGain = (AnimalInfo.OfflineGain or 0) + OfflineDuration
						AnimalInfo.LastCollect += OfflineDuration
						HasChanges = true
					end
				end
			end
			if HasChanges then
				PlayerChannel:Set("AnimalPodiums", AnimalList)
			end
		end
	end

	for Base in pairs(ActivePlotConnections) do
		if Base and type(Base.AddListener) == "function" then
			task.spawn(function()
				Base:AddListener(Player)
			end)
		end
	end

	local Plot: Model = PlotService.getFreePlot()
	while not Plot do
		task.wait(0.1)
		Plot = PlotService.getFreePlot()
	end

	if not Player then
		return
	end

	local RecycledPlotName = Plot.Name

	local RebirthLevel = PlayerChannel:Get("Rebirth") or 0
	local BaseData = BasesData[RebirthLevel]

	if not BaseData or not BaseData.Model then
		warn("NO BaseData for rebirth", RebirthLevel)
		return
	end

	local BaseSkin = PlayerChannel:Get("Settings.Base Skin")

	local BaseModel
	local floorName = BaseData.Model.Name

	if BaseSkin == "Meowl" then
		local MeowlFolder = SkinsFolder:WaitForChild("Meowl")
		local MeowlFloor = MeowlFolder:FindFirstChild(floorName)

		if MeowlFloor and MeowlFloor:IsA("Model") then
			BaseModel = MeowlFloor
		end
	end

	if BaseSkin == "Headless" then
		local HeadlessFolder = SkinsFolder:WaitForChild("Headless")
		local HeadlessFloor = HeadlessFolder:FindFirstChild(floorName)

		if HeadlessFloor and HeadlessFloor:IsA("Model") then
			BaseModel = HeadlessFloor
		end
	end

	if BaseSkin == "Strawberry" then
		local StrawberryFolder = SkinsFolder:WaitForChild("Strawberry")
		local StrawberryFloor = StrawberryFolder:FindFirstChild(floorName)

		if StrawberryFloor and StrawberryFloor:IsA("Model") then
			BaseModel = StrawberryFloor
		end
	end

	if BaseSkin == "Lucky" then
		local LuckyFolder = SkinsFolder:WaitForChild("Lucky")
		local LuckyFloor = LuckyFolder:FindFirstChild(floorName)

		if LuckyFloor and LuckyFloor:IsA("Model") then
			BaseModel = LuckyFloor
		end
	end

	if BaseSkin == "Leperchaun" then
		local LeperchaunFolder = SkinsFolder:WaitForChild("Leperchaun")
		local LeperchaunFloor = LeperchaunFolder:FindFirstChild(floorName)

		if LeperchaunFloor and LeperchaunFloor:IsA("Model") then
			BaseModel = LeperchaunFloor
		end
	end

	if BaseSkin == "Cyber" then
		local CyberFolder = SkinsFolder:WaitForChild("Cyber")
		local CyberFloor = CyberFolder:FindFirstChild(floorName)

		if CyberFloor and CyberFloor:IsA("Model") then
			BaseModel = CyberFloor
		end
	end

	if BaseSkin == "Prototype" then
		local PrototypeFolder = SkinsFolder:WaitForChild("Prototype")
		local PrototypeFloor = PrototypeFolder:FindFirstChild(floorName)

		if PrototypeFloor and PrototypeFloor:IsA("Model") then
			BaseModel = PrototypeFloor
		end
	end

	if BaseSkin == "Cursed" then
		local CursedFolder = SkinsFolder:WaitForChild("Cursed")
		local CursedFloor = CursedFolder:FindFirstChild(floorName)

		if CursedFloor and CursedFloor:IsA("Model") then
			BaseModel = CursedFloor
		end
	end

	if BaseSkin == "Bunny Basket" then
		local BunnyBasketFolder = SkinsFolder:WaitForChild("Bunny Basket")
		local BunnyBasketFloor = BunnyBasketFolder:FindFirstChild(floorName)

		if BunnyBasketFloor and BunnyBasketFloor:IsA("Model") then
			BaseModel = BunnyBasketFloor
		end
	end

	if BaseSkin == "Galaxy" then
		local GalaxyFolder = SkinsFolder:WaitForChild("Galaxy")
		local GalaxyFloor = GalaxyFolder:FindFirstChild(floorName)

		if GalaxyFloor and GalaxyFloor:IsA("Model") then
			BaseModel = GalaxyFloor
		end
	end

	if BaseSkin == "Radioactive" then
		local RadioactiveFolder = SkinsFolder:WaitForChild("Radioactive")
		local RadioactiveFloor = RadioactiveFolder:FindFirstChild(floorName)

		if RadioactiveFloor and RadioactiveFloor:IsA("Model") then
			BaseModel = RadioactiveFloor
		end
	end

	if BaseSkin == "Taco" then
		local TacoFolder = SkinsFolder:WaitForChild("Taco")
		local TacoFloor = TacoFolder:FindFirstChild(floorName)

		if TacoFloor and TacoFloor:IsA("Model") then
			BaseModel = TacoFloor
		end
	end

	if BaseSkin == "Skibidi" then
		local SkibidiFolder = SkinsFolder:WaitForChild("Skibidi")
		local SkibidiFloor = SkibidiFolder:FindFirstChild(floorName)

		if SkibidiFloor and SkibidiFloor:IsA("Model") then
			BaseModel = SkibidiFloor
		end
	end

	if BaseSkin == "Christmas" then
		local ChristmasFolder = SkinsFolder:WaitForChild("Christmas")
		local ChristmasFloor = ChristmasFolder:FindFirstChild(floorName)

		if ChristmasFloor and ChristmasFloor:IsA("Model") then
			BaseModel = ChristmasFloor
		end
	end

	if BaseSkin == "Gingerbread" then
		local GingerbreadFolder = SkinsFolder:WaitForChild("Gingerbread")
		local GingerbreadFloor = GingerbreadFolder:FindFirstChild(floorName)

		if GingerbreadFloor and GingerbreadFloor:IsA("Model") then
			BaseModel = GingerbreadFloor
		end
	end

	if BaseSkin == "Rainbow" then
		local RainbowFolder = SkinsFolder:WaitForChild("Rainbow")
		local RainbowFloor = RainbowFolder:FindFirstChild(floorName)

		if RainbowFloor and RainbowFloor:IsA("Model") then
			BaseModel = RainbowFloor
		end
	end

	if BaseSkin == "Rose" then
		local RoseFolder = SkinsFolder:WaitForChild("Rose")
		local RoseFloor = RoseFolder:FindFirstChild(floorName)

		if RoseFloor and RoseFloor:IsA("Model") then
			BaseModel = RoseFloor
		end
	end

	if BaseSkin == "Valentines" then
		local ValentinesFolder = SkinsFolder:WaitForChild("Valentines")
		local ValentinesFloor = ValentinesFolder:FindFirstChild(floorName)

		if ValentinesFloor and ValentinesFloor:IsA("Model") then
			BaseModel = ValentinesFloor
		end
	end

	if not BaseModel then
		BaseModel = BaseData.Model
	end

	local NewPlotClone = BaseModel:Clone()


	if NewPlotClone.PrimaryPart then
		NewPlotClone.PrimaryPart.Anchored = true
	end

	local RebirthData = Rebirth[RebirthLevel]
	local MultiplierValue = 1

	if RebirthLevel > 0 then
		MultiplierValue = PlotService:GetBaseMultiplier(Player) or 1
	end

	NewPlotClone.Multiplier.Main.Amount.Text = string.format("x%d", MultiplierValue)
	local AnimalPodiumsFolder = NewPlotClone:FindFirstChild("AnimalPodiums")

	if AnimalPodiumsFolder and BaseData and BaseData.MaxAnimals then
		local Podiums = AnimalPodiumsFolder:GetChildren()

		for _, Podium in pairs(Podiums) do
			local PodiumIndex = tonumber(Podium.Name)

			if PodiumIndex and PodiumIndex > BaseData.MaxAnimals then
				Podium:Destroy()
			end
		end
	end

	NewPlotClone:SetAttribute("Tier", RebirthLevel)
	PlotService.assignPlot(NewPlotClone, Player, RecycledPlotName)
	local root = NewPlotClone:FindFirstChild("Root")
		or NewPlotClone:FindFirstChild("MainRoot")

	if not root then
		warn("NO ROOT FOUND IN BASE:", NewPlotClone.Name)
	end
	NewPlotClone:PivotTo(Plot:GetPivot())
	NewPlotClone.Parent = workspace.Plots
	Plot:Destroy()

	local SpawnPart = NewPlotClone:WaitForChild("Spawn") :: BasePart
	local Character = Player.Character
	if Character then
		local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart") :: BasePart
		HumanoidRootPart.CFrame = SpawnPart.CFrame
	end

	CharacterAddedConnections[Player.UserId] = Player.CharacterAdded:Connect(function(Character: Model)
		local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart") :: BasePart
		HumanoidRootPart.CFrame = SpawnPart.CFrame
	end)

	NewPlotClone:SetAttribute(`Player`, Player.Name)
	NewPlotClone:SetAttribute("Loaded", true)
end

for _, Player: Player in pairs(Players:GetChildren()) do
	PlayerAdded(Player)
end

Players.PlayerAdded:Connect(PlayerAdded)

Players.PlayerRemoving:Connect(function(Player: Player)
	local Name = Player.Name

	if StealingMonitors[Player] then
		if StealingMonitors[Player].connection then
			StealingMonitors[Player].connection:Disconnect()
		end
		StealingMonitors[Player] = nil
	end

	if PlotUpdateConnections[Player] then
		PlotUpdateConnections[Player]:Disconnect()
		PlotUpdateConnections[Player] = nil
	end

	local Conn = CharacterAddedConnections[Player.UserId]

	if Conn then
		Conn:Disconnect()

		CharacterAddedConnections[Player.UserId] = nil
	end

	local Plot: Model? = PlotService.getPlot(Player)
	if Plot then
		PlotService.resetPlot(Plot)
	end

	_G.playerPlots[Player.UserId] = nil

	for PlotChannel, Owner: any in pairs(ActivePlotConnections) do
		if Owner == Name and PlotChannel and type(PlotChannel.Set) == "function" then
			local InitialData = {
				Owner = "nil",
				AnimalList = {},
				FriendsAllowed = false,
				BlockEndTime = "nil",
				BlockEndTimeFirstFloor = "nil",
				BlockEndTimeSecondFloor = "nil",
				BlockEndTimeThirdFloor = "nil",
				BlockedDelayTime = "nil",
			}

			for Name, Data in pairs(InitialData) do
				if Data == "nil" then
					PlotChannel:Set(Name, nil)
				else
					PlotChannel:Set(Name, Data)
				end
			end

			ActivePlotConnections[PlotChannel] = nil

			break
		end
	end
end)

task.spawn(function()
	while true do
		task.wait(300)

		local ConnectionsToRemove = {}

		for PlotChannel, Owner in pairs(ActivePlotConnections) do
			if not Players:FindFirstChild(Owner) then
				table.insert(ConnectionsToRemove, PlotChannel)
			end
		end

		for _, PlotChannel in ipairs(ConnectionsToRemove) do
			ActivePlotConnections[PlotChannel] = nil
		end
	end
end)

PlotService:Start()

return PlotService