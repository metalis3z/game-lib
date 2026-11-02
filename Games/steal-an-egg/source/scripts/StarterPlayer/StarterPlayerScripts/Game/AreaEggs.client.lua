local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local AreaEggs = require(ReplicatedStorage.Library.Types.AreaEggs)
local AreaEggNearbyPulse = require(script.AreaEggNearbyPulse)
local CarryRunBackEffects = require(script.CarryRunBackEffects)
local EggCmds = require(ReplicatedStorage.Library.Client.EggCmds)
local EggRenderer = require(ReplicatedStorage.Library.Client.Eggs.EggRenderer)
local AreaEggSlotIdentity = require(ReplicatedStorage.Library.Util.AreaEggSlotIdentity)
local GuardAreaLookupUtil = require(ReplicatedStorage.Library.Util.GuardAreaLookupUtil)
local HoverHighlight = require(script.HoverHighlight)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local RewardScreenTransition = require(ReplicatedStorage.Library.Client.GUIFX.RewardScreenTransition)
local NestResolver = require(script.NestResolver)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local Player = require(ReplicatedStorage.Library.Player)
local RareEggHighlight = require(script.RareEggHighlight)
local RenderBudget = require(ReplicatedStorage.Library.Modules.RenderBudget)
local SmartProximityPrompt = require(ReplicatedStorage.Library.Client.SmartProximityPrompt)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local WorkspaceEggVisibility = require(script.WorkspaceEggVisibility)
local wcall = require(ReplicatedStorage.Library.Functions.wcall)
local CarryVisualDisplay = require(script.CarryVisualDisplay)

local States = AreaEggs.States
local LocalPlayer = Players.LocalPlayer

local logger = Log.new()
local nearbyPulse = AreaEggNearbyPulse.new(LocalPlayer)

local renderBudget = RenderBudget.new({
	Name = "AreaEggRenderBudget",
	MaxJobsPerStep = 1,
	MaxStepTime = 0.004166666666666667,
	StepInterval = 0.03333333333333333,
	TargetSpreadSeconds = 3,
	SpreadMinJobs = 10
})

local initialRenderBudget = RenderBudget.new({
	Name = "InitialAreaEggRenderBudget",
	MaxJobsPerStep = 8,
	MaxStepTime = 0.008333333333333333,
	StepInterval = 0.03333333333333333,
	TargetSpreadSeconds = 0.35,
	SpreadMinJobs = 10
})

local OBJECTS = Workspace:WaitForChild("__OBJECTS")
assert(OBJECTS:IsA("Folder"), "Workspace.__OBJECTS must be a Folder")

local Areas = OBJECTS:WaitForChild("Areas")
assert(Areas:IsA("Folder"), "Workspace.__OBJECTS.Areas must be a Folder")

local SeparationLine = Areas:WaitForChild("SeparationLine")
assert(SeparationLine:IsA("BasePart"), "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")

local AreaEggSlotsClient = Instance.new("Folder")
AreaEggSlotsClient.Name = "AreaEggSlotsClient"
AreaEggSlotsClient.Parent = Workspace

local renderedEggs = {}
local renderQueueVersions = {}
local currentCarryState = nil

--==============================--
-- Helper Functions
--==============================--

local function canUsePrompt()
	local rootPart = Player.Optional.HumanoidRootPart(LocalPlayer)
	if not rootPart or not GuardAreaLookupUtil.IsInGameplaySide(SeparationLine, rootPart.Position) then
		return false
	end

	local character = Player.Optional.Character(LocalPlayer)
	if character and character:GetAttribute("IsTrapped") == true then
		return false
	end

	return true
end

local function cleanupRendered(uid)
	renderQueueVersions[uid] = nil
	renderBudget:Cancel(uid)
	initialRenderBudget:Cancel(uid)

	local renderData = renderedEggs[uid]
	if not renderData then return end

	renderedEggs[uid] = nil
	renderData.Trove:Destroy()

	if renderData.OwnsModel and renderData.Model.Parent ~= nil then
		wcall(renderData.Model.Destroy, renderData.Model)
	end
end

local function renderClientEgg(eggRecord)
	local result = EggRenderer.RenderVisual({
		OwnerUserId = 0,
		ScaleAlpha = 1,
		UID = eggRecord.Uid,
		ModelName = eggRecord.Uid,
		Record = {
			AssetCategory = eggRecord.AssetCategory,
			AssetScale = eggRecord.AssetScale,
			AssetEyeColor = eggRecord.AssetEyeColor,
			AssetColorSeed = eggRecord.AssetColorSeed,
			AssetColorIndex = eggRecord.AssetColorIndex,
			Mutations = table.clone(eggRecord.Mutations),
			BaseMutation = eggRecord.BaseMutation
		}
	}, AreaEggSlotsClient, false)

	result.Model:PivotTo(eggRecord.BottomCFrame)
	return result.Model
end

local function bindPrompt(eggRecord, model, ownsModel)
	RareEggHighlight.BindRenderedModel(eggRecord, model)

	local prompt = Instance.new("ProximityPrompt")
	prompt.Name = "CarryAreaEgg"
	prompt.ActionText = "Steal"
	prompt.ObjectText = "Egg"
	prompt.MaxActivationDistance = 8
	prompt.HoldDuration = 1.2
	prompt.RequiresLineOfSight = false
	prompt.Style = Enum.ProximityPromptStyle.Custom

	local anchor = SmartProximityPrompt.AttachToModel(prompt, model, {
		MaxActivationDistance = 8,
		TrackDistance = 8,
		SurfaceOffset = 0.75
	})

	local trove = Trove.new()
	trove:Add(anchor)

	local renderData = {
		Record = eggRecord,
		Model = model,
		OwnsModel = ownsModel,
		Prompt = prompt,
		Trove = trove
	}

	renderedEggs[eggRecord.Uid] = renderData

	if eggRecord.State == States.Slot then
		trove:Add(nearbyPulse:Bind(eggRecord.Uid, model, Workspace:GetServerTimeNow()))
	end

	HoverHighlight.Bind(model, prompt, trove)

	trove:Connect(prompt.Triggered, function(player)
		if player ~= LocalPlayer then return end

		local slotKey = AreaEggSlotIdentity.IsFirstAreaUid(eggRecord.Uid) and AreaEggSlotIdentity.BuildSlotKey(eggRecord.AreaId, eggRecord.NestId) or nil
		local success, errorMessage = EggCmds.RequestCarryAreaEgg(eggRecord.Uid, slotKey)

		if success and slotKey ~= nil then
			cleanupRendered(eggRecord.Uid)
			WorkspaceEggVisibility.SetHidden(eggRecord.Uid, false)
		end

		if not success and errorMessage ~= nil then
			logger:AtDebug():Log(string.format("Area egg carry denied for %s: %s", eggRecord.Uid, tostring(errorMessage)))
		end
	end)

	prompt.Enabled = canUsePrompt()
end

local function renderSlot(eggRecord)
	cleanupRendered(eggRecord.Uid)

	local nest = NestResolver.Resolve(eggRecord)
	nest:ScaleTo(eggRecord.NestScale)
	nest:PivotTo(nest:GetPivot())

	if AreaEggSlotIdentity.IsFirstAreaUid(eggRecord.Uid) then
		WorkspaceEggVisibility.SetHidden(eggRecord.Uid, true)
	else
		local visibilityModel = WorkspaceEggVisibility.ResolveModel(eggRecord.Uid)
		if visibilityModel ~= nil then
			WorkspaceEggVisibility.SetHidden(eggRecord.Uid, false)
			bindPrompt(eggRecord, visibilityModel, false)
			return
		end
	end

	bindPrompt(eggRecord, renderClientEgg(eggRecord), true)
end

local function renderDropped(eggRecord)
	cleanupRendered(eggRecord.Uid)

	if AreaEggSlotIdentity.IsFirstAreaUid(eggRecord.Uid) then
		WorkspaceEggVisibility.SetHidden(eggRecord.Uid, true)
		bindPrompt(eggRecord, renderClientEgg(eggRecord), true)
		return
	end

	WorkspaceEggVisibility.SetHidden(eggRecord.Uid, false)
	local visibilityModel = WorkspaceEggVisibility.ResolveModel(eggRecord.Uid)

	if visibilityModel == nil then
		logger:AtDebug():Log(string.format("Dropped area egg %s skipped because its Workspace model is not parented", eggRecord.Uid))
	else
		bindPrompt(eggRecord, visibilityModel, false)
	end
end

local function executeRenderJob(uid, targetVersion)
	local eggRecord = EggCmds.GetAreaEggRecord(uid)
	if not eggRecord or eggRecord.Version ~= targetVersion then return end

	renderQueueVersions[uid] = nil
	WorkspaceEggVisibility.SetHidden(eggRecord.Uid, false)

	if eggRecord.State == States.Dropped then
		renderDropped(eggRecord)
	elseif eggRecord.State == States.Slot then
		renderSlot(eggRecord)
	else
		cleanupRendered(eggRecord.Uid)
	end
end

local function shouldQueueRender(eggRecord)
	if renderQueueVersions[eggRecord.Uid] == eggRecord.Version then
		return false
	end

	local currentRender = renderedEggs[eggRecord.Uid]
	if not currentRender or currentRender.Record.Version ~= eggRecord.Version or currentRender.Record.State ~= eggRecord.State then
		return true
	end

	return false
end

local function queueRender(eggRecord, budget)
	if shouldQueueRender(eggRecord) then
		renderQueueVersions[eggRecord.Uid] = eggRecord.Version
		budget:Queue(eggRecord.Uid, function()
			executeRenderJob(eggRecord.Uid, eggRecord.Version)
		end)
	end
end

--==============================--
-- Snapshot Management
--==============================--

local function applySnapshot(snapshot, budget)
	local activeUids = {}
	local processList = {}

	for _, eggRecord in ipairs(snapshot.Records) do
		activeUids[eggRecord.Uid] = true
		WorkspaceEggVisibility.SetHidden(eggRecord.Uid, false)

		if eggRecord.State == States.Slot or eggRecord.State == States.Dropped then
			table.insert(processList, eggRecord)
		end
	end

	for uid in pairs(renderedEggs) do
		if not activeUids[uid] then
			cleanupRendered(uid)
		end
	end

	for _, eggRecord in ipairs(processList) do
		queueRender(eggRecord, budget)
	end
end

local function applyInitialSnapshot(snapshot)
	local activeUids = {}
	local directRenderList = {}
	local queuedRenderList = {}

	for _, eggRecord in ipairs(snapshot.Records) do
		activeUids[eggRecord.Uid] = true
		WorkspaceEggVisibility.SetHidden(eggRecord.Uid, false)

		if eggRecord.State == States.Slot or eggRecord.State == States.Dropped then
			if AreaEggSlotIdentity.IsFirstAreaUid(eggRecord.Uid) then
				table.insert(directRenderList, eggRecord)
			else
				table.insert(queuedRenderList, eggRecord)
			end
		end
	end

	for uid in pairs(renderedEggs) do
		if not activeUids[uid] then
			cleanupRendered(uid)
		end
	end

	-- Direct renders bypass the queue
	for _, eggRecord in ipairs(directRenderList) do
		renderQueueVersions[eggRecord.Uid] = nil
		WorkspaceEggVisibility.SetHidden(eggRecord.Uid, false)

		if eggRecord.State == States.Dropped then
			renderDropped(eggRecord)
		elseif eggRecord.State == States.Slot then
			renderSlot(eggRecord)
		else
			cleanupRendered(eggRecord.Uid)
		end
	end

	-- Queued renders use the initial budget
	for _, eggRecord in ipairs(queuedRenderList) do
		queueRender(eggRecord, initialRenderBudget)
	end
end

--==============================--
-- Event Connections
--==============================--

EggCmds.AreaEggClaimed:Connect(function(eventData)
	RewardScreenTransition()
	Message.Bottom({
		Time = 2.5,
		Message = string.format('You stole an <font color="#%s">EGG</font>!', eventData.Color:ToHex()),
		Color = Color3.new(1, 1, 1)
	})
end)

EggCmds.AreaEggSnapshotUpdated:Connect(function(snapshot)
	applySnapshot(snapshot, renderBudget)
end)

EggCmds.AreaEggUpdated:Connect(function(eggRecord)
	WorkspaceEggVisibility.SetHidden(eggRecord.Uid, false)

	if eggRecord.State ~= States.Slot and eggRecord.State ~= States.Dropped then
		cleanupRendered(eggRecord.Uid)
		return
	end

	renderBudget:Cancel(eggRecord.Uid)
	initialRenderBudget:Cancel(eggRecord.Uid)
	renderQueueVersions[eggRecord.Uid] = nil

	queueRender(eggRecord, renderBudget)
end)

EggCmds.AreaEggCarryStateChanged:Connect(function(carryState)
	currentCarryState = carryState

	if not carryState.IsCarrying or carryState.Uid == nil then return end

	if AreaEggSlotIdentity.IsFirstAreaUid(carryState.Uid) then
		cleanupRendered(carryState.Uid)
		WorkspaceEggVisibility.SetHidden(carryState.Uid, false)
		return
	end

	WorkspaceEggVisibility.SetHidden(carryState.Uid, false)
end)

EggCmds.AreaEggRemoved:Connect(function(uid)
	cleanupRendered(uid)

	local isBeingCarried = currentCarryState and currentCarryState.IsCarrying and currentCarryState.Uid == uid
	WorkspaceEggVisibility.SetHidden(uid, not isBeingCarried)
end)

WorkspaceEggVisibility.ModelAdded:Connect(function(model)
	local eggRecord = EggCmds.GetAreaEggRecord(model.Name)

	if not eggRecord or eggRecord.State ~= States.Dropped or AreaEggSlotIdentity.IsFirstAreaUid(eggRecord.Uid) then
		return
	end

	queueRender(eggRecord, renderBudget)
end)

RunService.Heartbeat:Connect(function()
	nearbyPulse:Step(Workspace:GetServerTimeNow())

	local isPromptEnabled = canUsePrompt()
	for _, renderData in pairs(renderedEggs) do
		renderData.Prompt.Enabled = isPromptEnabled
	end
end)

--==============================--
-- Initialization
--==============================--

CarryRunBackEffects.Start()
CarryVisualDisplay.Start()
WorkspaceEggVisibility.Start()
RareEggHighlight.Start()

applyInitialSnapshot(EggCmds.RequestAreaEggSnapshot())