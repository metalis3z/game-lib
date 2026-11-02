--!native

local PlotService = {}

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

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
local LuckyBlocksData = require(ReplicatedStorage.Datas.LuckyBlocks)
local RebirthData = require(ReplicatedStorage.Datas.Rebirth)
local BasesData = require(ReplicatedStorage.Datas.Bases)

local FirstFloor = ReplicatedStorage.Bases.FirstFloor

local CashCollected = Net:RemoteEvent("PlotService/CashCollected")
local ToggleFriends = Net:RemoteEvent("PlotService/ToggleFriends")
local ClaimCoins = Net:RemoteEvent("PlotService/ClaimCoins")
local Sell = Net:RemoteEvent("PlotService/Sell")
local Open = Net:RemoteEvent("PlotService/Open")

local Steal = Net:RemoteEvent("3ba148c9-7ed6-4675-93f8-9f7c356a2c54")


local MAX_OFFLINE_SECONDS = 24 * 60 * 60
local START_GRACE_PERIOD = 30
local BASE_LOCK_TIME = 60

local ActivePlotConnections = {} :: { [any]: string }
local PlotUpdateConnections = {} :: { [Player]: RBXScriptConnection }

local StealingMonitors = {} :: { [Player]: {connection: RBXScriptConnection?, cancelled: boolean} }

_G.playerPlots = {} :: { [number]: Model }

local PlotOwners = {} :: { [Model]: Player }

local CharacterAddedConnections = {}
local PlotTouchedConnections = {}
local SkinAnimalConnections = {}
local SKIN_DISABLE_MAP = {
	["Skibidi Toilet"] = "Skibidi",
	["Meowl"] = "Meowl",
	["Strawberry Elephant"] = "Strawberry",
	["Headless Horseman"] = "Headless",
	["John Pork"] = "John Pork",
}
local ANIMAL_REPLACE_MAP = {
	["Las Vaccas Lepres"] = "Las Vaquitas Lepreinas",
	["Los Vaccas Lepres"] = "Las Vaquitas Lepreinas",
}
local PlotLaserTransparency = {}

local function applyLaserTransparency(plot, transparency)
	local Laser = plot and plot:FindFirstChild("Laser")
	if not Laser then return end

	PlotLaserTransparency[plot] = transparency

	for _, child in pairs(Laser:GetDescendants()) do
		if child:IsA("BasePart") then
			child.Transparency = transparency
		end
	end
end

local function cleanupLaserMonitoring(plot)
	PlotLaserTransparency[plot] = nil
end

function PlotService.SetLaserTransparency(Plot: Model, transparency: number)
	applyLaserTransparency(Plot, transparency)
end

local BotBaseLockGen = {} :: { [Model]: number }

function PlotService.LockBotBase(Plot: Model, Duration: number)
	if not Plot or not Plot.Parent then return end
	local PlotChannel = Synchronizer:Get(Plot.Name)
	if not PlotChannel then return end

	local Now = workspace:GetServerTimeNow()
	local EndTime = Now + Duration

	PlotChannel:Set("BlockEndTime", os.time() + Duration)
	PlotChannel:Set("BlockEndTimeFirstFloor", EndTime)
	PlotChannel:Set("BlockEndTimeSecondFloor", EndTime)
	PlotChannel:Set("BlockEndTimeThirdFloor", EndTime)
	PlotChannel:Set("BlockedDelayTime", EndTime)

	applyLaserTransparency(Plot, 0)

	local myGen = (BotBaseLockGen[Plot] or 0) + 1
	BotBaseLockGen[Plot] = myGen

	task.delay(Duration, function()
		if BotBaseLockGen[Plot] ~= myGen then return end
		if not Plot or not Plot.Parent then return end
		local LiveChannel = Synchronizer:Get(Plot.Name)
		if not LiveChannel or not getmetatable(LiveChannel) then return end

		LiveChannel:Set("BlockEndTime", nil)
		LiveChannel:Set("BlockEndTimeFirstFloor", nil)
		LiveChannel:Set("BlockEndTimeSecondFloor", nil)
		LiveChannel:Set("BlockEndTimeThirdFloor", nil)
		LiveChannel:Set("BlockedDelayTime", nil)

		applyLaserTransparency(Plot, 1)
		BotBaseLockGen[Plot] = nil
	end)
end
function PlotService.UnlockBotBase(Plot: Model)
	if not Plot then return end
	local LiveChannel = Synchronizer:Get(Plot.Name)
	if LiveChannel and getmetatable(LiveChannel) then
		LiveChannel:Set("BlockEndTime", nil)
		LiveChannel:Set("BlockEndTimeFirstFloor", nil)
		LiveChannel:Set("BlockEndTimeSecondFloor", nil)
		LiveChannel:Set("BlockEndTimeThirdFloor", nil)
		LiveChannel:Set("BlockedDelayTime", nil)
	end
	applyLaserTransparency(Plot, 1)
	BotBaseLockGen[Plot] = nil
end

local SkinValidated = {}

local OG_SKIN_NAMES = {
	Strawberry = true,
	Skibidi = true,
	Meowl = true,
	["John Pork"] = true,
	Headless = true,
}

local OG_ANIMAL_PRIORITY = {
	{animal = "Strawberry Elephant", skin = "Strawberry"},
	{animal = "Skibidi Toilet", skin = "Skibidi"},
	{animal = "Meowl", skin = "Meowl"},
	{animal = "John Pork", skin = "John Pork"},
	{animal = "Headless Horseman", skin = "Headless"},
}

local AutoAppliedOGSkin = {} :: { [Player]: string }

local function CheckAndUnequipSkin(Player: Player)
	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then return end

	local equippedSkin = PlayerChannel:Get("Settings.Base Skin")
	if not equippedSkin then return end

	local requiredAnimalName = nil
	for animalName, skinKey in pairs(SKIN_DISABLE_MAP) do
		if skinKey == equippedSkin then
			requiredAnimalName = animalName
			break
		end
	end

	if not requiredAnimalName then return end

	local AnimalPodiums = PlayerChannel:Get("AnimalPodiums") or {}
	local count = 0
	for _, podiumData in pairs(AnimalPodiums) do
		if type(podiumData) == "table" and podiumData.Index == requiredAnimalName then
			count += 1
		end
	end

	if count > 0 then
		SkinValidated[Player] = true
		return
	end

	if not SkinValidated[Player] then
		return
	end

	SkinValidated[Player] = nil

	PlayerChannel:Set("Settings.Base Skin", "Normal")

	local Plot = PlotService.getPlot(Player)
	if Plot then
		SkinService:Apply("Normal", Plot)
	end
end

local function CheckAndUnlockSmurfCatBase(Player: Player)
	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then return end

	local AnimalPodiums = PlayerChannel:Get("AnimalPodiums") or {}
	local smurfCatCount = 0
	for _, podiumData in pairs(AnimalPodiums) do
		if type(podiumData) == "table" and podiumData.Index == "Smurf Cat" then
			smurfCatCount += 1
		end
	end

	local unlockedSkins = PlayerChannel:Get("UnlockedBaseSkins") or {}
	local currentUnlockStatus = unlockedSkins.SmurfCat

	if smurfCatCount > 0 then
		if currentUnlockStatus ~= true then
			unlockedSkins.SmurfCat = true
			PlayerChannel:Set("UnlockedBaseSkins", unlockedSkins)
		end
	else
		if currentUnlockStatus == true then
			unlockedSkins.SmurfCat = false
			PlayerChannel:Set("UnlockedBaseSkins", unlockedSkins)

			local equippedSkin = PlayerChannel:Get("Settings.Base Skin")
			if equippedSkin == "SmurfCat" then
				PlayerChannel:Set("Settings.Base Skin", "Normal")
				local Plot = PlotService.getPlot(Player)
				if Plot then
					SkinService:Apply("Normal", Plot)
				end
			end
		end
	end
end

local function CheckAndAutoApplyOGSkin(Player: Player)
	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then return end

	local AnimalPodiums = PlayerChannel:Get("AnimalPodiums") or {}

	-- Find which OG animals are present
	local foundOGAnimals = {}
	for _, entry in ipairs(OG_ANIMAL_PRIORITY) do
		for _, podiumData in pairs(AnimalPodiums) do
			if type(podiumData) == "table" and podiumData.Index == entry.animal then
				foundOGAnimals[entry.animal] = true
				break
			end
		end
	end

	-- Unlock/lock OG skins based on animal presence
	local unlockedSkins = PlayerChannel:Get("UnlockedBaseSkins") or {}
	local unlockChanged = false
	for _, entry in ipairs(OG_ANIMAL_PRIORITY) do
		if foundOGAnimals[entry.animal] then
			if unlockedSkins[entry.skin] ~= true then
				unlockedSkins[entry.skin] = true
				unlockChanged = true
			end
		else
			if unlockedSkins[entry.skin] == true then
				unlockedSkins[entry.skin] = false
				unlockChanged = true
			end
		end
	end
	if unlockChanged then
		PlayerChannel:Set("UnlockedBaseSkins", unlockedSkins)
	end

	local currentSkin = PlayerChannel:Get("Settings.Base Skin") or "Normal"
	local currentSkinIsOG = OG_SKIN_NAMES[currentSkin] == true

	-- Determine current skin's required animal (if OG)
	local currentSkinAnimal = nil
	if currentSkinIsOG then
		for _, entry in ipairs(OG_ANIMAL_PRIORITY) do
			if entry.skin == currentSkin then
				currentSkinAnimal = entry.animal
				break
			end
		end
	end

	local hasAnyOG = next(foundOGAnimals) ~= nil
	local rebirthLevel = PlayerChannel:Get("Rebirth")

	if hasAnyOG then
		-- OG animal(s) present
		if currentSkinIsOG and foundOGAnimals[currentSkinAnimal] then
			-- Current OG skin's animal is still present, keep it
			SkinValidated[Player] = true
			AutoAppliedOGSkin[Player] = currentSkin
			return
		end

		-- Only auto-apply if current skin is Normal or was previously auto-applied by us
		if currentSkin == "Normal" or AutoAppliedOGSkin[Player] ~= nil then
			for _, entry in ipairs(OG_ANIMAL_PRIORITY) do
				if foundOGAnimals[entry.animal] then
					if currentSkin ~= entry.skin then
						PlayerChannel:Set("Settings.Base Skin", entry.skin)
						local Plot = PlotService.getPlot(Player)
						if Plot then
							SkinService:Apply(entry.skin, Plot, rebirthLevel)
						end
					end
					SkinValidated[Player] = true
					AutoAppliedOGSkin[Player] = entry.skin
					return
				end
			end
		end
	else
		-- No OG animals present
		if currentSkinIsOG and AutoAppliedOGSkin[Player] ~= nil then
			-- Only remove if we auto-applied it (don't touch manually equipped skins)
			PlayerChannel:Set("Settings.Base Skin", "Normal")
			local Plot = PlotService.getPlot(Player)
			if Plot then
				SkinService:Apply("Normal", Plot, rebirthLevel)
			end
			SkinValidated[Player] = nil
			AutoAppliedOGSkin[Player] = nil
		end
	end
end

local function SetupSkinAnimalWatcher(Player: Player)
	local PlayerChannel = Synchronizer:Wait(Player)
	if not PlayerChannel then return end

	if SkinAnimalConnections[Player] then
		SkinAnimalConnections[Player]:Disconnect()
	end

	local equippedSkin = PlayerChannel:Get("Settings.Base Skin")
	if equippedSkin then
		for _, entry in ipairs(OG_ANIMAL_PRIORITY) do
			if entry.skin == equippedSkin then
				local AnimalPodiums = PlayerChannel:Get("AnimalPodiums") or {}
				for _, podiumData in pairs(AnimalPodiums) do
					if type(podiumData) == "table" and podiumData.Index == entry.animal then
						SkinValidated[Player] = true
						AutoAppliedOGSkin[Player] = equippedSkin
						break
					end
				end
				break
			end
		end
	end

	local skinChangeConnection = PlayerChannel:OnChanged("Settings.Base Skin", function()
		SkinValidated[Player] = nil
		AutoAppliedOGSkin[Player] = nil

		local newSkin = PlayerChannel:Get("Settings.Base Skin")
		if not newSkin then return end

		for _, entry in ipairs(OG_ANIMAL_PRIORITY) do
			if entry.skin == newSkin then
				local AnimalPodiums = PlayerChannel:Get("AnimalPodiums") or {}
				for _, podiumData in pairs(AnimalPodiums) do
					if type(podiumData) == "table" and podiumData.Index == entry.animal then
						SkinValidated[Player] = true
						AutoAppliedOGSkin[Player] = newSkin
						break
					end
				end
				break
			end
		end
	end)

	-- Initial check for OG skin auto-apply
	CheckAndAutoApplyOGSkin(Player)

	SkinAnimalConnections[Player] = PlayerChannel:OnChanged("AnimalAddedOrRemoved", function()
		CheckAndUnequipSkin(Player)
		CheckAndAutoApplyOGSkin(Player)
		CheckAndUnlockSmurfCatBase(Player)
	end)

	local originalConnection = SkinAnimalConnections[Player]
	SkinAnimalConnections[Player] = {
		Disconnect = function()
			originalConnection:Disconnect()
			skinChangeConnection:Disconnect()
		end
	}
end

local function playfakevfx_at(Plot, PodiumIndex)
	local AnimalPodiumsFolder = Plot and Plot:FindFirstChild("AnimalPodiums")
	local PodiumModel = AnimalPodiumsFolder and AnimalPodiumsFolder:FindFirstChild(tostring(PodiumIndex))

	local vfxPosition
	if PodiumModel then
		local Base  = PodiumModel:FindFirstChild("Base")
		local Spawn = Base and Base:FindFirstChild("Spawn")
		if Spawn then
			vfxPosition = Spawn.Position + Vector3.new(0, 1, 0)
		elseif Base and Base.PrimaryPart then
			vfxPosition = Base.PrimaryPart.Position + Vector3.new(0, 1, 0)
		elseif PodiumModel.PrimaryPart then
			vfxPosition = PodiumModel.PrimaryPart.Position + Vector3.new(0, 1, 0)
		end
	end
	if not vfxPosition and Plot and Plot.PrimaryPart then
		vfxPosition = Plot.PrimaryPart.Position
	end

	if vfxPosition then
		pcall(function()
			Net:RemoteEvent("SpawnFakeBrainrot/Poof"):FireAllClients({ Position = vfxPosition })
		end)
	end
end

local function CheckAndClearFakeAnimal(PlayerChannel, Plot, PodiumIndex)
	local AnimalList = PlayerChannel:Get("AnimalPodiums")

	if AnimalList and type(AnimalList[PodiumIndex]) == "table" and AnimalList[PodiumIndex].isfake == true then
		playfakevfx_at(Plot, PodiumIndex)

		AnimalList[PodiumIndex] = "Empty"
		PlayerChannel:Set("AnimalPodiums", AnimalList)
		PlayerChannel:Set("AnimalAddedOrRemoved", true)

		return true
	end

	return false
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

		if StealService.CancelSteal then
			StealService:CancelSteal(Player)
			PlotService.RemoveFromQueue(Player)
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
local DICT_SENTINEL_KEY = "__dict__"
local function forceDictSerialization(t)
	if type(t) ~= "table" then return t end
	local out = {}
	for k, v in pairs(t) do
		out[k] = v
	end
	out[DICT_SENTINEL_KEY] = true
	return out
end

function PlotService.replacePlot(Player: Player, NewPlotModel: any): any
	local OldPlot: Model = PlotService.getPlot(Player)
	if not OldPlot then return end

	local PlotName = OldPlot.Name
	local PlotCFrame = OldPlot:GetPivot()

	CleanupPlotConnections(OldPlot)
	PlotOwners[OldPlot] = nil

	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then return end

	local RebirthLevel = PlayerChannel:Get("Rebirth") or 0
	local BaseData = BasesData[RebirthLevel]

	local AnimalPodiumsFolder = NewPlotModel:FindFirstChild("AnimalPodiums")
	if AnimalPodiumsFolder and BaseData and BaseData.MaxAnimals then
		for _, Podium in pairs(AnimalPodiumsFolder:GetChildren()) do
			local PodiumIndex = tonumber(Podium.Name)
			if PodiumIndex and PodiumIndex > BaseData.MaxAnimals then
				Podium:Destroy()
			end
		end
	end

	local ExistingPlotChannel = Synchronizer:Get(PlotName)
	if ExistingPlotChannel then
		ExistingPlotChannel:Set("AnimalList", {})
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

	NewPlotModel:SetAttribute("Loaded", false)
	NewPlotModel:SetAttribute("Tier", RebirthLevel)

	NewPlotModel.Parent = workspace:WaitForChild("Plots")
	OldPlot:Destroy()

	local MultiplierValue = 1
	if RebirthLevel > 0 then
		MultiplierValue = PlotService:GetBaseMultiplier(Player) or 1
	end

	if NewPlotModel:FindFirstChild("Multiplier") and NewPlotModel.Multiplier:FindFirstChild("Main") then
		NewPlotModel.Multiplier.Main.Amount.Text = string.format("x%d", MultiplierValue)
	end

	local Skin = PlayerChannel:Get("Settings.Base Skin")
	SkinService:Apply(Skin, NewPlotModel)

	local PlotChannel = Synchronizer:Get(PlotName)
	if PlotChannel then
		local currentPodiums = PlayerChannel:Get("AnimalPodiums") or {}
		PlotChannel:Set("AnimalList", forceDictSerialization(currentPodiums))
	end

	NewPlotModel:SetAttribute("Loaded", true)

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
	cleanupLaserMonitoring(PlotToReset)

	local NewDefaultPlot = FirstFloor:Clone()
	NewDefaultPlot.Name = PlotName

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

	applyLaserTransparency(NewDefaultPlot, 1)

	NewDefaultPlot:PivotTo(PlotCFrame)
	NewDefaultPlot.Parent = workspace:WaitForChild("Plots")
	PlotToReset:Destroy()

	NewDefaultPlot:SetAttribute("Loaded", true)
end

function PlotService.getFreePlot()
	local allPlots = workspace:WaitForChild("Plots"):GetChildren()

	table.sort(allPlots, function(a, b)
		local numA = tonumber(a.Name) or 999
		local numB = tonumber(b.Name) or 999
		return numA < numB
	end)

	for _, Plot in ipairs(allPlots) do
		if tonumber(Plot.Name) and not PlotOwners[Plot] then
			return Plot
		end
	end

	return nil
end

function PlotService.isPlotFree(Plot: Model): boolean
	if not Plot then return false end
	if PlotOwners[Plot] then return false end
	if Plot:GetAttribute("IsBotBase") == true then return false end

	local PlotChannel = Synchronizer:Get(Plot.Name)
	if PlotChannel then
		local Owner = PlotChannel:Get("Owner")
		if Owner ~= nil and Owner ~= "nil" and Owner ~= "" then
			return false
		end
	end

	return true
end

local function normalizeKeys(t)
	if type(t) ~= "table" then return t end
	local hasStringKey = false
	for k in pairs(t) do
		if type(k) == "string" and tonumber(k) then
			hasStringKey = true
			break
		end
	end
	if not hasStringKey then return t end
	local out = {}
	for k, v in pairs(t) do
		local nk = tonumber(k)
		out[nk or k] = v
	end
	return out
end



function PlotService.assignPlot(Plot: any, Player: Player, PlotName: string?)
	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then return end

	if PlotUpdateConnections[Player] then
		PlotUpdateConnections[Player]:Disconnect()
		PlotUpdateConnections[Player] = nil
	end

	local previousOwner = PlotOwners[Plot]
	if previousOwner and previousOwner ~= Player then
		if PlotUpdateConnections[previousOwner] then
			PlotUpdateConnections[previousOwner]:Disconnect()
			PlotUpdateConnections[previousOwner] = nil
		end
	end

	Plot.PlotSign.SurfaceGui.Frame.TextLabel.Text = Player and string.format("%s's Base", Player.DisplayName)
		or "Empty Base"
	Plot.Name = PlotName or HttpService:GenerateGUID(false)
	Plot.PlotSign.YourBase.Enabled = false

	local Skin = PlayerChannel:Get("Settings.Base Skin")
	SkinService:Apply(Skin, Plot)

	_G.playerPlots[Player.UserId] = Plot
	PlotOwners[Plot] = Player

	local GracePeriod = START_GRACE_PERIOD

	local InitialData = {
		Owner = Player,
		AnimalList = forceDictSerialization(normalizeKeys(PlayerChannel:Get("AnimalPodiums") or {})),
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

	task.delay(GracePeriod, function()
		if not Players:FindFirstChild(Player.Name) then return end
		if not Plot or not Plot.Parent then return end
		if not PlotChannel or not getmetatable(PlotChannel) then return end

		local BlockEnd = PlotChannel:Get("BlockEndTime")

		if not BlockEnd or os.time() >= BlockEnd then
			PlotChannel:Set("GrandfatheredThieves", nil)
			PlotChannel:Set("BlockEndTime", nil)
			PlotChannel:Set("BlockEndTimeFirstFloor", nil)
			PlotChannel:Set("BlockEndTimeSecondFloor", nil)
			PlotChannel:Set("BlockEndTimeThirdFloor", nil)
			PlotChannel:Set("BlockedDelayTime", nil)

			applyLaserTransparency(Plot, 1)
		end
	end)

	local function OnPodiumsChanged()
		local CurrentPodiums = normalizeKeys(PlayerChannel:Get("AnimalPodiums"))
		local Outgoing = forceDictSerialization(CurrentPodiums)
		do
			local count = 0
			local keysSummary = {}
			local nonEmptySlots = {}
			for k, v in pairs(Outgoing or {}) do
				count = count + 1
				if #keysSummary < 30 then
					table.insert(keysSummary, tostring(k) .. "(" .. type(k) .. ")")
				end
				if type(v) == "table" then
					table.insert(nonEmptySlots, tostring(k) .. "=" .. tostring(v.Index))
				end
			end
		end
		PlotChannel:Set("AnimalList", Outgoing)
	end

	PlotUpdateConnections[Player] = PlayerChannel:OnChanged("AnimalAddedOrRemoved", function()
		OnPodiumsChanged()
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

	local AnimalPodiumsFolder = Plot:FindFirstChild("AnimalPodiums")
	if not AnimalPodiumsFolder then
		return true
	end

	local AllPodiums = AnimalPodiumsFolder:GetChildren()

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

	applyLaserTransparency(Plot, 0)

	NotificationService.Success(Player, string.format("You locked your base for %d Seconds!", TotalTime))

	task.wait(TotalTime)

	if not Players:FindFirstChild(Player.Name) then return end
	if not Plot or not Plot.Parent then return end
	if not PlotChannel or not getmetatable(PlotChannel) then return end

	PlotChannel:Set("GrandfatheredThieves", nil)
	PlotChannel:Set("BlockEndTime", nil)
	PlotChannel:Set("BlockEndTimeFirstFloor", nil)
	PlotChannel:Set("BlockEndTimeSecondFloor", nil)
	PlotChannel:Set("BlockEndTimeThirdFloor", nil)
	PlotChannel:Set("BlockedDelayTime", nil)

	applyLaserTransparency(Plot, 1)
end

local function Init(Plot: any)
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

local plotsFolder = workspace:WaitForChild("Plots")
local plotChildren = plotsFolder:GetChildren()

for i, Plot in ipairs(plotChildren) do
	for _, Main in pairs(Plot.Unlock:GetDescendants()) do
		if Main.Name == "Main" then
			Main.UnlockBase.Enabled = false
		end
	end

	local Multiplier = Plot:FindFirstChild("Multiplier")
	if Multiplier then
		Multiplier.Main.Enabled = false
	end

end

function PlotService:Start()
	workspace:WaitForChild("Plots").ChildAdded:Connect(Init)
	for _, Plot in ipairs(workspace:WaitForChild("Plots"):GetChildren()) do
		Init(Plot)
	end
end

Steal.OnServerEvent:Connect(function(Player: Player, _, _, VictimPlotUID: string, PodiumIndex: number)
	warn(("[STEALDBG] ENTRY by %s | UID=%s | Podium=%s (%s)"):format(Player.Name, tostring(VictimPlotUID), tostring(PodiumIndex), typeof(PodiumIndex)))
	local VictimPlotChannel = Synchronizer:Get(VictimPlotUID)
	if not VictimPlotChannel then warn("[STEALDBG] no channel for "..tostring(VictimPlotUID)) return end

	local VictimOwner = VictimPlotChannel:Get("Owner")

	local PlotsFolder = workspace:FindFirstChild("Plots")
	local Plot = PlotsFolder and PlotsFolder:FindFirstChild(VictimPlotUID)

	local IsBotBase = (Plot ~= nil and Plot:GetAttribute("IsBotBase") == true)
		or (VictimPlotChannel:Get("IsBotBase") == true)
		or (typeof(VictimOwner) == "string")

	if not IsBotBase and not VictimOwner then
		warn("[STEALDBG] no VictimOwner")
		return
	end

	if not IsBotBase then
		local realPlot = PlotService.getPlot(VictimOwner)
		if realPlot then Plot = realPlot end
	end

	if not Plot then warn("[STEALDBG] could not resolve Plot") return end
	warn("[STEALDBG] resolved Plot="..Plot.Name.." IsBotBase="..tostring(IsBotBase))

	if not IsBotBase then
		local VictimPlayerChannel = Synchronizer:Get(VictimOwner)

		if VictimPlayerChannel and CheckAndClearFakeAnimal(VictimPlayerChannel, Plot, PodiumIndex) then
			return
		end
	end

	local Podium = PlotService.getFreePodium(Player)
	if not Podium then
		warn("[STEALDBG] getFreePodium nil (thief base full)")
		NotificationService.Error(Player, "You need more room in your base to steal a brainrot.")
		return
	end
	warn("[STEALDBG] free podium="..tostring(Podium.Name))

	local StealHitbox = Plot:FindFirstChild("StealHitbox") :: BasePart
	if not StealHitbox then
		warn("[STEALDBG] no StealHitbox")
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
		warn("[STEALDBG] HRP not in StealHitbox -- not close enough")
		return
	end
	warn("[STEALDBG] passed hitbox")

	local TargetPodiumIndex = tonumber(Podium.Name)

	if IsBotBase then
		warn("[STEALDBG] Bot base detected, using SimulateSteal")

		local VictimAnimalList = VictimPlotChannel:Get("AnimalList") or {}
		local VictimAnimalData = VictimAnimalList[PodiumIndex]

		if not VictimAnimalData or type(VictimAnimalData) ~= "table" then
			warn("[STEALDBG] No animal data at podium", PodiumIndex)
			return
		end

		local animalName = VictimAnimalData.Index
		local mutation = VictimAnimalData.Mutation

		VictimPlotChannel:Set(string.format("AnimalList.%d.Steal", PodiumIndex), Player.UserId)
		VictimPlotChannel:Set(string.format("AnimalList.%d.Stolen", PodiumIndex), true)
		VictimPlotChannel:Set(string.format("AnimalList.%d.StealText", PodiumIndex), "STOLEN")

		local VictimPodiumsFolder = Plot:FindFirstChild("AnimalPodiums")
		local VictimPodium = VictimPodiumsFolder and VictimPodiumsFolder:FindFirstChild(tostring(PodiumIndex))

		local displayAnimalClone, displayOverhead, displayPrompt

		if VictimPodium then
			displayAnimalClone = VictimPodium:FindFirstChild("AnimalClone")
			displayOverhead = VictimPodium:FindFirstChild("Overhead")
			local base = VictimPodium:FindFirstChild("Base")
			if base then
				displayPrompt = base:FindFirstChildOfClass("ProximityPrompt")
			end
		end

		local success = StealService:SimulateSteal(
			Player.Name,
			animalName,
			displayAnimalClone,
			displayOverhead,
			displayPrompt,
			mutation,
			TargetPodiumIndex,
			VictimPlotChannel,
			PodiumIndex
		)

		if success then
			warn("[STEALDBG] SimulateSteal SUCCESS")
		else
			warn("[STEALDBG] SimulateSteal FAILED - restoring victim animal")
			VictimPlotChannel:Set(string.format("AnimalList.%d.Steal", PodiumIndex), nil)
			VictimPlotChannel:Set(string.format("AnimalList.%d.Stolen", PodiumIndex), nil)
			VictimPlotChannel:Set(string.format("AnimalList.%d.StealText", PodiumIndex), nil)
		end

		return
	end

	warn("[STEALDBG] Real base, calling StartSteal")

	PlotService.AddToQueue(Player, TargetPodiumIndex)

	local started = StealService:StartSteal(Player, VictimPlotUID, PodiumIndex, TargetPodiumIndex)
	if not started then
		warn("[STEALDBG] StartSteal returned falsy")
		PlotService.RemoveFromQueue(Player, TargetPodiumIndex)
		return
	end
	warn("[STEALDBG] StartSteal SUCCESS")

	MonitorStealing(Player)
end)

ClaimCoins.OnServerEvent:Connect(function(Player: Player, PodiumIndex: number)
	local PlayerChannel = Synchronizer:Get(Player)
	assert(PlayerChannel)

	local Plot = PlotService.getPlot(Player)

	if Plot and CheckAndClearFakeAnimal(PlayerChannel, Plot, PodiumIndex) then
		return
	end

	local AnimalList = PlayerChannel:Get("AnimalPodiums")
	if not AnimalList or typeof(AnimalList[PodiumIndex]) ~= "table" then
		return
	end

	local AnimalInfo = AnimalList[PodiumIndex]
	if not AnimalInfo or AnimalInfo.Steal then
		return
	end

	local TimeNow = workspace:GetServerTimeNow()

	local TimeElapsed = math.floor(TimeNow - AnimalInfo.LastCollect)
	if TimeElapsed <= 0 then
		return
	end

	local Generation
	if AnimalInfo.CustomGeneration then
		local traitMult = 1
		local hasSleepy = false
		if AnimalInfo.Traits then
			for _, traitName in ipairs(AnimalInfo.Traits) do
				local td = require(ReplicatedStorage.Datas.Traits)[traitName]
				if td then
					if traitName == "Sleepy" then hasSleepy = true
					else traitMult = traitMult + (td.MultiplierModifier or 0) end
				end
			end
		end
		if AnimalInfo.Mutation then
			local md = Mutations[AnimalInfo.Mutation]
			if md then traitMult = traitMult + (md.Modifier or 0) end
		end
		Generation = AnimalInfo.CustomGeneration * traitMult
		if hasSleepy then Generation = Generation * 0.5 end
		Generation = math.round(Generation)
	else
		Generation = SharedAnimals:GetGeneration(AnimalInfo.Index, AnimalInfo.Mutation, AnimalInfo.Traits, Player)
	end


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
	if not PlayerChannel then return end

	local Plot = PlotService.getPlot(Player)

	if Plot and CheckAndClearFakeAnimal(PlayerChannel, Plot, PodiumIndex) then
		return
	end

	local AnimalList = PlayerChannel:Get("AnimalPodiums")
	if not AnimalList or typeof(AnimalList[PodiumIndex]) ~= "table" then
		return
	end

	local AnimalInfo = AnimalList[PodiumIndex]
	if AnimalInfo.Steal then
		return
	end

	local Price = AnimalData[AnimalInfo.Index].Price or 0
	MoneyService:Add(Player, math.round(Price / 2))

	AnimalList[PodiumIndex] = "Empty"
	PlayerChannel:Set("AnimalPodiums", AnimalList)
	PlayerChannel:Set("AnimalAddedOrRemoved", true)
end)

local function SelectAnimalByChance(Animals: { {Name: string, Chance: number?, IsEnabled: (() -> boolean)?} }): string?
	if not Animals or #Animals == 0 then
		return nil
	end

	local scale = 1000

	local eligible = {}
	for i = 1, #Animals do
		local entry = Animals[i]
		if entry and (not entry.IsEnabled or entry.IsEnabled()) then
			table.insert(eligible, entry)
		end
	end

	if #eligible == 0 then
		return nil
	end

	local hasChances = false
	for _, entry in ipairs(eligible) do
		if entry.Chance and entry.Chance > 0 then
			hasChances = true
			break
		end
	end

	if not hasChances then
		return eligible[math.random(1, #eligible)].Name
	end

	local weighted = {}
	for _, entry in ipairs(eligible) do
		if entry.Chance and entry.Chance > 0 then
			table.insert(weighted, entry)
		end
	end
	if #weighted == 0 then
		return eligible[math.random(1, #eligible)].Name
	end

	local total = 0
	for _, entry in ipairs(weighted) do
		total += math.floor(entry.Chance * scale)
	end

	local roll = math.random(1, math.max(1, total))

	local cumulative = 0
	for _, entry in ipairs(weighted) do
		cumulative += math.floor(entry.Chance * scale)
		if roll <= cumulative then
			return entry.Name
		end
	end

	return weighted[#weighted].Name
end

Open.OnServerEvent:Connect(function(Player: Player, PodiumIndex: number)
	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then return end

	local Plot = PlotService.getPlot(Player)
	if not Plot then return end

	if CheckAndClearFakeAnimal(PlayerChannel, Plot, PodiumIndex) then
		return
	end

	local AnimalList = PlayerChannel:Get("AnimalPodiums")
	if not AnimalList or typeof(AnimalList[PodiumIndex]) ~= "table" then
		return
	end

	local LuckyBlockInfo = AnimalList[PodiumIndex]
	if LuckyBlockInfo.Steal then
		return
	end

	local animalEntry = AnimalData[LuckyBlockInfo.Index]
	if animalEntry and animalEntry.Egg then
		local eggAnimals = animalEntry.Egg.Animals
		if not eggAnimals or #eggAnimals == 0 then
			return
		end

		local WinningAnimalName = SelectAnimalByChance(eggAnimals)
		if not WinningAnimalName then
			warn("Egg open: failed to select animal for", LuckyBlockInfo.Index)
			return
		end

		local NewAnimalInfo = {
			Index       = WinningAnimalName,
			LastCollect = workspace:GetServerTimeNow(),
			Mutation    = LuckyBlockInfo.Mutation,
			Traits      = LuckyBlockInfo.Traits,
		}

		AnimalList[PodiumIndex] = NewAnimalInfo
		PlayerChannel:Set("AnimalPodiums", AnimalList)
		PlayerChannel:Set("AnimalAddedOrRemoved", true)

		Open:FireAllClients(
			Plot.Name,
			PodiumIndex,
			LuckyBlockInfo.Index,
			NewAnimalInfo.Index,
			NewAnimalInfo.Mutation,
			NewAnimalInfo.Traits
		)
		return
	end

	local LuckyBlockData = LuckyBlocksData[LuckyBlockInfo.Index]
	if not LuckyBlockData or not LuckyBlockData.Animals then
		warn("[LuckyBlock] Open: No LuckyBlockData or Animals for index:", tostring(LuckyBlockInfo.Index))
		return
	end

	local Animals = LuckyBlockData.Animals
	local mt = getmetatable(Animals)

	local WinningAnimalName = SelectAnimalByChance(Animals)

	if not WinningAnimalName then
		WinningAnimalName = Animals[1] and Animals[1].Name or "UNKNOWN"
		warn("[LuckyBlock] Open: FALLBACK triggered! WinningAnimalName set to:", WinningAnimalName)
	end

	local WinningMutation = LuckyBlockInfo.Mutation
	local WinningTraits = LuckyBlockInfo.Traits

	local NewAnimalInfo = {
		Index = WinningAnimalName,
		LastCollect = workspace:GetServerTimeNow(),
		Mutation = WinningMutation,
		Traits = WinningTraits,
	}

	AnimalList[PodiumIndex] = NewAnimalInfo
	PlayerChannel:Set("AnimalPodiums", AnimalList)
	PlayerChannel:Set("AnimalAddedOrRemoved", true)

	Open:FireAllClients(
		Plot.Name,
		PodiumIndex,
		LuckyBlockInfo.Index,
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
	assert(PlayerChannel)

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

	do
		local AnimalList = PlayerChannel:Get("AnimalPodiums")
		if AnimalList then
			local HasReplacements = false
			for key, AnimalInfo in pairs(AnimalList) do
				if typeof(AnimalInfo) == "table" and AnimalInfo.Index then
					local replacement = ANIMAL_REPLACE_MAP[AnimalInfo.Index]
					if replacement then
						AnimalInfo.Index = replacement
						HasReplacements = true
					end
				end
			end
			if HasReplacements then
				PlayerChannel:Set("AnimalPodiums", AnimalList)
				PlayerChannel:Set("AnimalAddedOrRemoved", true)
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
		game:GetService("RunService").Heartbeat:Wait()
		if not Players:FindFirstChild(Player.Name) then
			return
		end
		Plot = PlotService.getFreePlot()
	end

	if not Players:FindFirstChild(Player.Name) then
		return
	end


	PlotOwners[Plot] = Player

	local RecycledPlotName = Plot.Name

	local RebirthLevel = PlayerChannel:Get("Rebirth") or 0

	if not Players:FindFirstChild(Player.Name) then
		PlotOwners[Plot] = nil
		return
	end

	local CurrentBase = BasesData[RebirthLevel].Model
	local NewPlotClone = CurrentBase:Clone()

	if NewPlotClone.PrimaryPart then
		NewPlotClone.PrimaryPart.Anchored = true
	end

	local RebirthData = Rebirth[RebirthLevel]
	local MultiplierValue = 1

	if RebirthLevel > 0 then
		MultiplierValue = PlotService:GetBaseMultiplier(Player) or 1
	end

	NewPlotClone.Multiplier.Main.Amount.Text = string.format("x%d", MultiplierValue)
	local BaseData = BasesData[RebirthLevel]
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
	NewPlotClone:WaitForChild("Root")
	NewPlotClone:PivotTo(Plot:GetPivot())
	NewPlotClone.Parent = workspace:WaitForChild("Plots")
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
	task.spawn(SetupSkinAnimalWatcher, Player)
	NewPlotClone:SetAttribute(`Player`, Player.Name)
	NewPlotClone:SetAttribute("Loaded", true)
end

for _, Player: Player in pairs(Players:GetChildren()) do
	PlayerAdded(Player)
end

Players.PlayerAdded:Connect(PlayerAdded)

Players.PlayerRemoving:Connect(function(Player: Player)
	local Name = Player.Name

	if PlotUpdateConnections[Player] then
		PlotUpdateConnections[Player]:Disconnect()
		PlotUpdateConnections[Player] = nil
	end
	if StealingMonitors[Player] then
		if StealingMonitors[Player].connection then
			StealingMonitors[Player].connection:Disconnect()
		end
		StealingMonitors[Player] = nil
	end

	if SkinAnimalConnections[Player] then
		SkinAnimalConnections[Player]:Disconnect()
		SkinAnimalConnections[Player] = nil
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
	SkinValidated[Player] = nil
	AutoAppliedOGSkin[Player] = nil
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

			for Key, Data in pairs(InitialData) do
				if Data == "nil" then
					PlotChannel:Set(Key, nil)
				else
					PlotChannel:Set(Key, Data)
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

return PlotService