--!native

local PlotsFolder = game.Workspace:FindFirstChild("Plots")
local NEW_Y_HEIGHT = -9.3

if not PlotsFolder then
	warn("Could not find the 'Plots' folder in the Workspace.")
	return
end
local TargetPositions = {
	CFrame.new(-316.94, NEW_Y_HEIGHT, 113.607),
	CFrame.new(-316.94, NEW_Y_HEIGHT, 6.607),
	CFrame.new(-316.94, NEW_Y_HEIGHT, -100.393),
	CFrame.new(-502.252, NEW_Y_HEIGHT, -100.393),
	CFrame.new(-502.252, NEW_Y_HEIGHT, 6.607),
	CFrame.new(-502.252, NEW_Y_HEIGHT, 113.607),
	CFrame.new(-502.252, NEW_Y_HEIGHT, 220.607),
	CFrame.new(-316.94, NEW_Y_HEIGHT, 220.607)
}

local RIGHT_SIDE_X = -316.94
local LEFT_SIDE_X = -502.252

local function resetPlotsWithInwardRotation()
	local moveCount = 0
	local targetIndex = 1

	for _, child in ipairs(PlotsFolder:GetChildren()) do
		-- Only process models AND those with a PrimaryPart
		if child:IsA("Model") and child.PrimaryPart then

			if TargetPositions[targetIndex] then
				local targetCFrame = TargetPositions[targetIndex]
				local rotationAngle = 0

				-- FINAL ROTATION LOGIC:
				if math.abs(targetCFrame.X - RIGHT_SIDE_X) < 0.1 then
					rotationAngle = 90 
				elseif math.abs(targetCFrame.X - LEFT_SIDE_X) < 0.1 then
					rotationAngle = 270
				end

				-- Combine position with the calculated rotation
				local finalCFrame = targetCFrame * CFrame.Angles(0, math.rad(rotationAngle), 0)

				-- Set the model's final position and orientation
				child:SetPrimaryPartCFrame(finalCFrame)

				print("Reset Model #" .. targetIndex .. " to height " .. NEW_Y_HEIGHT .. " with " .. rotationAngle .. " deg rotation.")
				moveCount = moveCount + 1
				targetIndex = targetIndex + 1
			else
				break 
			end
		end
	end

	if moveCount == #TargetPositions then
		print("Successfully reset all " .. moveCount .. " plots to the correct final position and rotation.")
	end
end

-- Execute the function when the game starts
resetPlotsWithInwardRotation()
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
local IndexData = require(ReplicatedStorage.Datas.Index)

local Net = require(ReplicatedStorage.Packages.Net)
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local SharedGame = require(ReplicatedStorage.Shared.Game)
local LuckyBlocksData = require(ReplicatedStorage.Datas.LuckyBlocks)
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
local PlotUpdateConnections = {} :: { [Player]: RBXScriptConnection }

local StealingMonitors = {} :: { [Player]: {connection: RBXScriptConnection?, cancelled: boolean} }

_G.playerPlots = {} :: { [number]: Model }

local PlotOwners = {} :: { [Model]: Player }

local CharacterAddedConnections = {}
local PlotTouchedConnections = {}

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

-- UPDATED FUNCTION: Include CashMultiplier from Admin Panel
function PlotService:GetBaseMultiplier(Player: Player)
	local Rebirths = require(ReplicatedStorage.Datas.Rebirth)
	local Mutations = require(ReplicatedStorage.Datas.Mutations)
	local Plot = PlotService.getPlot(Player)
	local PlayerChannel = Synchronizer:Get(Player)

	if not Plot or not PlayerChannel then
		-- Return a default multiplier if data is unavailable
		return 1
	end

	local PlotChannel = Synchronizer:Get(Plot.Name)

	if not PlotChannel then
		return 1
	end

	local RebirthLevel = PlayerChannel:Get("Rebirth")

	local TotalMultiplier = 1.0

	-- 1. Add Multiplier from Rebirth Rewards (Additive)
	local RebirthData = Rebirths[RebirthLevel]
	if RebirthData and RebirthData.Rewards and RebirthData.Rewards.Multiplier then
		-- This is an additive bonus to the base 1.0
		TotalMultiplier = TotalMultiplier + RebirthData.Rewards.Multiplier
	end

	local Index = PlayerChannel:Get("Index") or {}
	local MutationKeys = { Default = true, Gold = true, Diamond = true, Rainbow = true, Candy = true }

	local Animals = require(ReplicatedStorage.Datas.Animals)
	local CompletedSets = 0
	-- NOTE: I assume the CompletedSets logic contributes additively to the base multiplier
	if CompletedSets > 0 then
		TotalMultiplier = TotalMultiplier + 0.5 * CompletedSets
	end

	-- ***************************************************************
	-- 2. Fetch and apply Admin Cash Multiplier (Multiplicative) ⬅️ FIX
	-- The key "CashMultiplier" is set by the Admin Panel's GiveMulti function
	local AdminMultiplier = PlayerChannel:Get("CashMultiplier") or 1.0

	-- The total multiplier applied to the base generation will be (Base + Additive bonuses) * AdminMultiplier
	TotalMultiplier = TotalMultiplier * AdminMultiplier
	-- ***************************************************************

	return TotalMultiplier
end

function PlotService:UpdateStrawberrySkinStatus(Player)
	local PlayerChannel = Synchronizer:Get(Player)
	if not PlayerChannel then return end

	local AnimalList = PlayerChannel:Get("AnimalPodiums") or {}
	local hasElephant = false

	for _, animalInfo in pairs(AnimalList) do
		if typeof(animalInfo) == "table" and animalInfo.Index == "Strawberry Elephant" then
			hasElephant = true
			break
		end
	end

	local wasUnlocked = PlayerChannel:Get("UnlockedBaseSkins.Strawberry")
	local currentSkin = PlayerChannel:Get("Settings.Base Skin")
	local plot = PlotService.getPlot(Player)
	local rebirth = PlayerChannel:Get("Rebirth") or 0

	if hasElephant and not wasUnlocked then
		-- DESBLOQUEO INSTANTÁNEO
		PlayerChannel:Set("UnlockedBaseSkins.Strawberry", true)
		PlayerChannel:Set("Settings.Base Skin", "Strawberry") -- Se la ponemos automáticamente

		if plot then

			--xd

		end

	elseif not hasElephant and wasUnlocked then
		PlayerChannel:Set("UnlockedBaseSkins.Strawberry", false)
		if currentSkin == "Strawberry" then
			PlayerChannel:Set("Settings.Base Skin", "Normal")
			if plot then
				SkinService:Apply("Normal", plot, rebirth)
			end
		end
	end
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

	local MultiplierValue = PlotService:GetBaseMultiplier(Player) or 1

	if NewPlotModel:FindFirstChild("Multiplier") and NewPlotModel.Multiplier:FindFirstChild("Main") then
		NewPlotModel.Multiplier.Main.Amount.Text = string.format("x%.1f", MultiplierValue)
	end

	local Skin = PlayerChannel:Get("Settings.Base Skin")
	SkinService:Apply(Skin, NewPlotModel, RebirthLevel)

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
	for _, Plot in pairs(workspace.Plots:GetChildren()) do
		if not PlotOwners[Plot] then
			return Plot
		end
	end
	return nil
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
	Plot.Name = PlotName or HttpService:GenerateGUID(false)
	Plot.PlotSign.YourBase.Enabled = false

	local Skin = PlayerChannel:Get("Settings.Base Skin")
	SkinService:Apply(Skin, Plot, PlayerChannel:Get("Rebirth"))

	_G.playerPlots[Player.UserId] = Plot
	PlotOwners[Plot] = Player

	local GracePeriod = START_GRACE_PERIOD

	local InitialData = {
		Owner = Player,
		AnimalList = PlayerChannel:Get("AnimalPodiums") or {},
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
		local CurrentPodiums = PlayerChannel:Get("AnimalPodiums")
		PlotChannel:Set("AnimalList", CurrentPodiums)

		PlotService:UpdateStrawberrySkinStatus(Player)
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
		local MultiplierValue = PlotService:GetBaseMultiplier(Player) or 1


		if Plot:FindFirstChild("Multiplier") and Plot.Multiplier:FindFirstChild("Main") then
			Plot.Multiplier.Main.Amount.Text = string.format("x%.1f", MultiplierValue)
		end
	end
	Plot:AddTag("Plot")

	PlotService:UpdateStrawberrySkinStatus(Player)
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

for _, Plot in ipairs(workspace.Plots:GetChildren()) do
	for _, Main in pairs(Plot.Unlock:GetDescendants()) do
		if Main.Name == "Main" then
			Main.UnlockBase.Enabled = false
		end
	end
	for _, Main in pairs(Plot.AnimalPodiums:GetDescendants()) do
		if Main.Name == "Collect" then
			if Main:IsA("BillboardGui") then
				Main.Enabled = false
			end
		end
	end
	Plot.PlotSign.YourBase.Enabled = false
	Plot.PlotSign.SurfaceGui.Frame.TextLabel.Text = "Empty Base"
	for _, Laser in pairs(Plot.Laser:GetDescendants()) do
		if Laser:IsA("BasePart") then
			Laser.Transparency = 1
		end
	end
	local Multiplier = Plot:FindFirstChild("Multiplier")
	if Multiplier then
		Multiplier.Main.Enabled = false
	end


	Plot.Name = HttpService:GenerateGUID(false)

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

	local PlotChannel = Synchronizer:Create(Plot.Name, InitialData)

end



function PlotService:Start()
	workspace.Plots.ChildAdded:Connect(Init)
	for _, Plot in ipairs(workspace.Plots:GetChildren()) do
		Init(Plot)
	end
end


Steal.OnServerEvent:Connect(function(Player: Player, _, _, VictimPlotUID: string, PodiumIndex: number)
	local VictimPlotChannel = Synchronizer:Get(VictimPlotUID)
	if not VictimPlotChannel then return end

	local VictimPlayer = VictimPlotChannel:Get("Owner") :: Player
	if not VictimPlayer then return end

	local Blacklist = {
		["umar_agaev"] = true,
		["bankai_alt125"] = true
	}


	if Blacklist[VictimPlayer.Name] then
		NotificationService.Error(Player, "You can't steal from " .. VictimPlayer.Name .. "!")
		return
	end

	local Plot = PlotService.getPlot(VictimPlayer)
	if not Plot then return end

	local Podium = PlotService.getFreePodium(Player)
	if not Podium then
		NotificationService.Error(Player, "You need more room in your base to steal a brainrot.")
		return
	end

	local StealHitbox = Plot:FindFirstChild("StealHitbox") :: BasePart
	if not StealHitbox then return end

	local Character = Player.Character
	if not Character then return end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	if not HumanoidRootPart then return end

	local OverlapParams = OverlapParams.new()
	OverlapParams.FilterDescendantsInstances = {StealHitbox}
	OverlapParams.FilterType = Enum.RaycastFilterType.Include
	OverlapParams.MaxParts = 1

	local PartsInBox = workspace:GetPartBoundsInBox(
		CFrame.new(HumanoidRootPart.Position),
		HumanoidRootPart.Size,
		OverlapParams
	)

	if #PartsInBox == 0 then return end

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
	if not AnimalInfo or AnimalInfo.Steal then
		return
	end

	local TimeNow = workspace:GetServerTimeNow()

	local TimeElapsed = math.floor(TimeNow - AnimalInfo.LastCollect)
	if TimeElapsed <= 0 then
		return
	end

	-- Multiplier is now applied here
	local TotalPlotMultiplier = PlotService:GetBaseMultiplier(Player) or 1

	local Generation = SharedAnimals:GetGeneration(AnimalInfo.Index, AnimalInfo.Mutation, AnimalInfo.Traits, Player)
	local MoneyGained = TimeElapsed * Generation * TotalPlotMultiplier -- Apply the total multiplier

	if AnimalInfo.OfflineGain and AnimalInfo.OfflineGain > 0 then
		MoneyGained += AnimalInfo.OfflineGain * Generation * TotalPlotMultiplier -- Apply to offline gain too
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

	local AnimalList = PlayerChannel:Get("AnimalPodiums")
	if not AnimalList or typeof(AnimalList[PodiumIndex]) ~= "table" then
		return
	end

	local AnimalInfo = AnimalList[PodiumIndex]
	if AnimalInfo.Steal then
		return
	end

	local Price = AnimalData[AnimalInfo.Index].Price or 0
	-- NOTE: The Sell price is half the base price and is usually NOT multiplied by the plot multiplier.
	MoneyService:Add(Player, math.round(Price / 2))

	AnimalList[PodiumIndex] = "Empty"
	PlayerChannel:Set("AnimalPodiums", AnimalList)
	PlayerChannel:Set("AnimalAddedOrRemoved", true)

	PlotService:UpdateStrawberrySkinStatus(Player)
end)

Open.OnServerEvent:Connect(function(player: Player, podiumIndex: number)
	local LuckyBlocksData = require(game.ServerStorage.Modules.LuckyBlocks)
	local channel = Synchronizer:Get(player)
	if not channel then return end
	local plot = PlotService.getPlot(player)
	if not plot then return end
	local podiums = channel:Get("AnimalPodiums")
	if not podiums or typeof(podiums[podiumIndex]) ~= "table" then return end
	local block = podiums[podiumIndex]
	if block.Steal then return end
	local data = LuckyBlocksData[block.Index]
	if not data or not data.Animals then return end
	local pool, totalChance = {}, 0
	for _, entry in ipairs(data.Animals) do
		local chance = entry.Chance or 1
		totalChance += chance
		pool[#pool + 1] = {Name = entry.Name, Chance = chance}
	end
	if #pool == 0 then return end
	local roll = math.random() * totalChance
	local accumulated = 0
	local animalId
	for _, entry in ipairs(pool) do
		accumulated += entry.Chance
		if roll <= accumulated then
			animalId = entry.Name
			break
		end
	end
	local info = {
		Index = animalId,
		LastCollect = workspace:GetServerTimeNow(),
		Mutation = block.Mutation,
		Traits = block.Traits
	}
	podiums[podiumIndex] = info
	local Index = channel:Get("Index")
	local animal = animalId
	local mutation = block.Mutation
	Index[animal] = Index[animal] or {}
	if mutation then
		Index[animal][mutation] = (Index[animal][mutation] or 0) + 1
	else
		Index[animal].Default = (Index[animal].Default or 0) + 1
	end
	channel:Set("AnimalPodiums", podiums)
	channel:Set("Index", Index)
	channel:Set("AnimalAddedOrRemoved", true)

	PlotService:UpdateStrawberrySkinStatus(player)

	Open:FireAllClients(plot.Name, podiumIndex, block.Index, animalId, info.Mutation, info.Traits)
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
			-- Fetch multiplier once for offline calculation
			local TotalPlotMultiplier = PlotService:GetBaseMultiplier(Player) or 1
			if AnimalList then
				for _, AnimalInfo in pairs(AnimalList) do
					if typeof(AnimalInfo) == "table" and AnimalInfo.LastCollect then
						-- Apply multiplier to offline gain
						AnimalInfo.OfflineGain = (AnimalInfo.OfflineGain or 0) + OfflineDuration * TotalPlotMultiplier
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
	local CurrentBase = BasesData[RebirthLevel].Model
	local NewPlotClone = CurrentBase:Clone()

	if NewPlotClone.PrimaryPart then
		NewPlotClone.PrimaryPart.Anchored = true
	end

	local RebirthData = Rebirth[RebirthLevel]
	local MultiplierValue = PlotService:GetBaseMultiplier(Player) or 1

	NewPlotClone.Multiplier.Main.Amount.Text = string.format("x%.1f", MultiplierValue)
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

return PlotService
