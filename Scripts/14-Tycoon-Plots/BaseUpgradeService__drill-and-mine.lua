-- Reference copy for study. Game: drill-and-mine
-- Original: ServerScriptService/Source/Services/BaseUpgradeService.lua
-- What it does: Buy-the-next-floor base upgrades: keeps floor/podium templates out of the world, clones the
--   unlocked ones into the player's plot per level, charges a per-level cost, throttles requests with a 1s
--   server cooldown, and pushes the new state to the client.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")

local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local PlotService = require(ServerScriptService.Source.Services.PlotService)
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

-- Lazy require to avoid load-order issues with PodiumService.
local _PodiumService
local function getPodiumService()
	if _PodiumService == nil then
		local ok, mod = pcall(require, ServerScriptService.Source.Services.PodiumService)
		if ok then _PodiumService = mod else _PodiumService = false end
	end
	return _PodiumService or nil
end

local function refreshPodiumState(player)
	local svc = getPodiumService()
	if svc and svc.SendStateToPlayer then
		pcall(svc.SendStateToPlayer, player)
	end
end

local function validatePlacements(player)
	local svc = getPodiumService()
	if svc and svc.ValidatePlacements then
		pcall(svc.ValidatePlacements, player)
	end
end

local BaseUpgradeService = {}

-- Per-player throttle on RequestUpgrade. Stops rapid clicks (or any client that
-- bypasses the local cooldown) from queuing up multiple animations on the same
-- floor model. Tuned to match the floor pop duration so the visual animation
-- always finishes between purchases.
local UPGRADE_COOLDOWN_SECONDS = 1.0
local lastUpgradeAt = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local NotEnoughCashEvent = Remotes:WaitForChild("NotEnoughCash")

local PLOTS_FOLDER = Workspace:WaitForChild("Assets"):WaitForChild("Plots")

local TEMPLATES_FOLDER_NAME = "BaseUpgradeTemplates"

local BaseUpgradeRemotes
local RequestUpgradeFunc
local RequestDataFunc
local UpdateEvent
local BuiltEvent

local templatesRoot

local function ensureRemotes()
	BaseUpgradeRemotes = Remotes:FindFirstChild("BaseUpgradeService")
	if not BaseUpgradeRemotes then
		BaseUpgradeRemotes = Instance.new("Folder")
		BaseUpgradeRemotes.Name = "BaseUpgradeService"
		BaseUpgradeRemotes.Parent = Remotes
	end

	RequestUpgradeFunc = BaseUpgradeRemotes:FindFirstChild("RequestUpgrade")
	if not RequestUpgradeFunc then
		RequestUpgradeFunc = Instance.new("RemoteFunction")
		RequestUpgradeFunc.Name = "RequestUpgrade"
		RequestUpgradeFunc.Parent = BaseUpgradeRemotes
	end

	RequestDataFunc = BaseUpgradeRemotes:FindFirstChild("RequestData")
	if not RequestDataFunc then
		RequestDataFunc = Instance.new("RemoteFunction")
		RequestDataFunc.Name = "RequestData"
		RequestDataFunc.Parent = BaseUpgradeRemotes
	end

	UpdateEvent = BaseUpgradeRemotes:FindFirstChild("BaseUpgradeUpdate")
	if not UpdateEvent then
		UpdateEvent = Instance.new("RemoteEvent")
		UpdateEvent.Name = "BaseUpgradeUpdate"
		UpdateEvent.Parent = BaseUpgradeRemotes
	end

	BuiltEvent = BaseUpgradeRemotes:FindFirstChild("BaseUpgradeBuilt")
	if not BuiltEvent then
		BuiltEvent = Instance.new("RemoteEvent")
		BuiltEvent.Name = "BaseUpgradeBuilt"
		BuiltEvent.Parent = BaseUpgradeRemotes
	end
end

local function getFloors()
	return GameConfig.BaseUpgrades and GameConfig.BaseUpgrades.Floors or {}
end

local function getMaxLevel()
	local total = 0
	for _, floor in ipairs(getFloors()) do
		total = total + (floor.LastPodiumIndex - floor.FirstPodiumIndex + 1)
	end
	return total
end

-- Resolve which podium index the Nth upgrade reveals (1-indexed), and whether
-- that upgrade also reveals a new floor (returns floorName when it's the first
-- podium of a floor, nil otherwise).
local function resolveUpgrade(level)
	local cursor = 0
	for _, floor in ipairs(getFloors()) do
		local floorCount = floor.LastPodiumIndex - floor.FirstPodiumIndex + 1
		if level <= cursor + floorCount then
			local offset = level - cursor - 1
			local podiumIndex = floor.FirstPodiumIndex + offset
			local newFloor = (offset == 0) and floor.Name or nil
			return podiumIndex, newFloor, floor
		end
		cursor = cursor + floorCount
	end
	return nil, nil, nil
end

-- For a given level (slots upgraded so far), return the set of podiums and
-- floors that should currently exist on the plot.
local function resolveUnlocked(level)
	local podiums = {}
	local floorsBuilt = {}
	for i = 1, level do
		local podiumIndex, newFloorName, floorCfg = resolveUpgrade(i)
		if podiumIndex then
			table.insert(podiums, podiumIndex)
		end
		if newFloorName then
			floorsBuilt[newFloorName] = true
		end
		-- Even if the FIRST podium of the floor wasn't the trigger (e.g. dev
		-- skipping levels), make sure the floor a podium belongs to is built.
		if floorCfg then
			floorsBuilt[floorCfg.Name] = true
		end
	end
	return podiums, floorsBuilt
end

-- Piecewise exponential anchored to brainrot CPS tiers. Three segments
-- pivot at EarlyMidThreshold (Rare->Epic income jump) and MidLateThreshold
-- (Mythic/Exclusive endgame). If the piecewise fields are missing we fall
-- back to the legacy flat PriceMultiplier. The +9 CostOffset keeps every
-- BaseUpgrade price ending in 9 so it never collides with the per-stat
-- upgrade prices (which end in 7 / 3 / 1 for Storage / Damage / Carry).
local function costForLevel(level)
	local cfg = GameConfig.BaseUpgrades
	if not cfg then return math.huge end
	local start = cfg.StartPrice or 1000
	local offset = cfg.CostOffset or 0
	local mEarly = cfg.PriceMultiplierEarly or cfg.PriceMultiplier or 1.5
	local mMid   = cfg.PriceMultiplierMid
	local mLate  = cfg.PriceMultiplierLate
	local t1 = cfg.EarlyMidThreshold or 5
	local t2 = cfg.MidLateThreshold or 12

	local raw
	if mMid and mLate then
		if level <= t1 then
			raw = start * (mEarly ^ level)
		elseif level <= t2 then
			local pivot1 = start * (mEarly ^ t1)
			raw = pivot1 * (mMid ^ (level - t1))
		else
			local pivot1 = start * (mEarly ^ t1)
			local pivot2 = pivot1 * (mMid ^ (t2 - t1))
			raw = pivot2 * (mLate ^ (level - t2))
		end
	else
		raw = start * ((cfg.PriceMultiplier or 1.5) ^ level)
	end

	return math.floor(raw / 10) * 10 + offset
end

local function getLevel(playerData)
	local v = playerData and playerData.BaseUpgradeLevel
	if typeof(v) ~= "number" or v < 0 then return 0 end
	return math.floor(v)
end

local function buildPayload(playerData)
	local level = getLevel(playerData)
	local maxLevel = getMaxLevel()
	local nextCost = nil
	if level < maxLevel then
		nextCost = costForLevel(level)
	end
	return {
		Level = level,
		MaxLevel = maxLevel,
		NextCost = nextCost,
		IsMaxLevel = level >= maxLevel,
	}
end

local function pushUpdate(player, playerData)
	if UpdateEvent then
		UpdateEvent:FireClient(player, buildPayload(playerData))
	end
end

-- Templates layout: ReplicatedStorage.BaseUpgradeTemplates.<PlotName>.{FirstFloor, SecondFloor, Podium11..Podium30}
local function ensureTemplatesRoot()
	templatesRoot = ReplicatedStorage:FindFirstChild(TEMPLATES_FOLDER_NAME)
	if not templatesRoot then
		templatesRoot = Instance.new("Folder")
		templatesRoot.Name = TEMPLATES_FOLDER_NAME
		templatesRoot.Parent = ReplicatedStorage
	end
end

local function getPlotTemplates(plotName)
	return templatesRoot:FindFirstChild(plotName)
end

local function migratePlotTemplates(plot)
	local plotFolder = templatesRoot:FindFirstChild(plot.Name)
	if not plotFolder then
		plotFolder = Instance.new("Folder")
		plotFolder.Name = plot.Name
		plotFolder.Parent = templatesRoot
	end

	local upgradeContainer = plot:FindFirstChild("Upgrade")
	if upgradeContainer then
		for _, floor in ipairs(getFloors()) do
			local floorModel = upgradeContainer:FindFirstChild(floor.Name)
			if floorModel and not plotFolder:FindFirstChild(floor.Name) then
				floorModel.Parent = plotFolder
			end
		end
	end

	for _, floor in ipairs(getFloors()) do
		for idx = floor.FirstPodiumIndex, floor.LastPodiumIndex do
			local name = "Podium" .. idx
			local model = plot:FindFirstChild(name)
			if model and not plotFolder:FindFirstChild(name) then
				model.Parent = plotFolder
			end
		end
	end
end

local function migrateAllPlots()
	for _, plot in ipairs(PLOTS_FOLDER:GetChildren()) do
		if plot:IsA("Model") then
			local ok, err = pcall(migratePlotTemplates, plot)
			if not ok then
				warn(string.format("[BaseUpgradeService] Template migration failed for %s: %s", plot.Name, tostring(err)))
			end
		end
	end
end

local function ensureUpgradeContainer(plot)
	local c = plot:FindFirstChild("Upgrade")
	if not c then
		c = Instance.new("Folder")
		c.Name = "Upgrade"
		c.Parent = plot
	end
	return c
end

local function cloneFloorInto(plot, floorName)
	local plotTpl = getPlotTemplates(plot.Name)
	if not plotTpl then return nil end
	local tpl = plotTpl:FindFirstChild(floorName)
	if not tpl then return nil end
	local container = ensureUpgradeContainer(plot)
	if container:FindFirstChild(floorName) then return container:FindFirstChild(floorName) end
	local cloned = tpl:Clone()
	cloned.Parent = container
	return cloned
end

local function clonePodiumInto(plot, podiumIndex)
	local name = "Podium" .. podiumIndex
	local plotTpl = getPlotTemplates(plot.Name)
	if not plotTpl then return nil end
	local tpl = plotTpl:FindFirstChild(name)
	if not tpl then return nil end
	if plot:FindFirstChild(name) then return plot:FindFirstChild(name) end
	local cloned = tpl:Clone()
	cloned.Parent = plot
	return cloned
end

local function clearUpgradeBuildings(plot)
	local container = plot:FindFirstChild("Upgrade")
	if container then
		for _, floor in ipairs(getFloors()) do
			local existing = container:FindFirstChild(floor.Name)
			if existing then
				existing:Destroy()
			end
		end
	end
	for _, floor in ipairs(getFloors()) do
		for idx = floor.FirstPodiumIndex, floor.LastPodiumIndex do
			local existing = plot:FindFirstChild("Podium" .. idx)
			if existing then
				existing:Destroy()
			end
		end
	end
end

local function applyUnlockedToPlot(plot, level)
	clearUpgradeBuildings(plot)
	local podiums, floorsBuilt = resolveUnlocked(level)
	for floorName in pairs(floorsBuilt) do
		cloneFloorInto(plot, floorName)
	end
	for _, idx in ipairs(podiums) do
		clonePodiumInto(plot, idx)
	end
end

local function onRequestUpgrade(player)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return false end

	-- Server-side cooldown. Silently drops the request if the player just
	-- upgraded — prevents floors from getting two BuiltEvent animations layered
	-- on top of each other when the player spam-clicks.
	local now = os.clock()
	local last = lastUpgradeAt[player] or 0
	if now - last < UPGRADE_COOLDOWN_SECONDS then
		return false
	end

	local level = getLevel(playerData)
	local maxLevel = getMaxLevel()

	if level >= maxLevel then
		NotEnoughCashEvent:FireClient(player, "Maximum upgrade reached")
		return false
	end

	local cost = costForLevel(level)
	if (playerData.Cash or 0) < cost then
		NotEnoughCashEvent:FireClient(player)
		return false
	end

	local plot = PlotService.GetPlot(player)
	if not plot then
		return false
	end

	local ok = PlayerDataService.AddStat(player, "Cash", -cost)
	if not ok then return false end

	lastUpgradeAt[player] = now

	local nextLevel = level + 1
	PlayerDataService.SetStat(player, "BaseUpgradeLevel", nextLevel)
	PlayerDataService.ScheduleSave(player)

	local podiumIndex, newFloorName = resolveUpgrade(nextLevel)

	if newFloorName then
		cloneFloorInto(plot, newFloorName)
	end
	if podiumIndex then
		clonePodiumInto(plot, podiumIndex)
	end

	pushUpdate(player, playerData)
	refreshPodiumState(player)

	if BuiltEvent and podiumIndex then
		BuiltEvent:FireClient(player, podiumIndex, newFloorName)
	end

	return true
end

local function onRequestData(player)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return nil end
	return buildPayload(playerData)
end

local function initPlayerPlot(player)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return end
	local plot = PlotService.GetPlot(player)
	if not plot then return end
	local level = getLevel(playerData)
	applyUnlockedToPlot(plot, level)
	pushUpdate(player, playerData)

	-- Now that the plot has every unlocked podium, run PodiumService's ghost
	-- cleanup. Any PlacedBrainrot entry whose podium is locked, whose BrainrotId
	-- is invalid, or whose UniqueId is already in inventory gets returned to
	-- BrainrotInventory and cleared from PlacedBrainrot. Must happen BEFORE
	-- SendStateToPlayer so we don't fire PodiumUpdate for entries we just nuked.
	validatePlacements(player)

	refreshPodiumState(player)
end

function BaseUpgradeService.Init()
	if not GameConfig.BaseUpgrades then
		warn("[BaseUpgradeService] GameConfig.BaseUpgrades missing")
		return
	end

	ensureRemotes()
	ensureTemplatesRoot()
	migrateAllPlots()

	RequestUpgradeFunc.OnServerInvoke = onRequestUpgrade
	RequestDataFunc.OnServerInvoke = onRequestData

	PlotService.RegisterResetCallback(function(plot)
		clearUpgradeBuildings(plot)
	end)

	PlayerDataService.ProfileLoaded.Event:Connect(function(player)
		task.defer(function()
			for _ = 1, 20 do
				if PlotService.GetPlot(player) then break end
				task.wait(0.25)
			end
			initPlayerPlot(player)
		end)
	end)

	for _, plr in ipairs(Players:GetPlayers()) do
		task.spawn(function()
			initPlayerPlot(plr)
		end)
	end

	Players.PlayerRemoving:Connect(function(plr)
		lastUpgradeAt[plr] = nil
	end)
end

return BaseUpgradeService