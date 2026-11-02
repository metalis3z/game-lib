-- best ritualservice by kiwi's brother

local RitualService = {}

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")

local EventService = require(script.Parent:WaitForChild("EventService"))

export type Player = Player
export type Vector3 = Vector3

export type RitualSpot = {
	Instance: BasePart | Model,
	Center: Vector3,
	Radius: number,
	RequiredPlayers: number,
	Duration: number,
	Cooldown: number,
	RitualId: string,
	RitualType: string,
	IndexName: string,
	FreezePlayers: boolean,
	FaceCenter: boolean,
	State: "Idle" | "Gathering" | "Channeling" | "Completed" | "Failed" | "Cooldown",
	StateChangedAt: number,
	NextAllowedAt: number,
	ActivePlayers: {[Player]: boolean},
	Progress: number,
	LastProgressAt: number,
	Channelers: {Player},
}

export type RitualTypeDef = {
	Name: string,
	Description: string?,
	OnBegin: (spot: RitualSpot) -> (),
	OnStep: (spot: RitualSpot, dt: number) -> number,
	OnComplete: (spot: RitualSpot) -> (),
	OnFail: (spot: RitualSpot, reason: string?) -> (),
	OnStateChanged: (spot: RitualSpot, oldState: string, newState: string) -> (),
}

export type RitualSpotConfig = {
	Instance: BasePart | Model,
	RitualId: string?,
	RitualType: string?,
	IndexName: string?,
	Radius: number?,
	RequiredPlayers: number?,
	Duration: number?,
	Cooldown: number?,
	FreezePlayers: boolean?,
	FaceCenter: boolean?,
}

local _ritualTypes: {[string]: RitualTypeDef} = {}
local _spots: {[string]: RitualSpot} = {}
local _running = false
local _hbConn: RBXScriptConnection? = nil

local CONSTANTS = {
	DEFAULT_RADIUS = 8,
	DEFAULT_REQUIRED = 2,
	DEFAULT_DURATION = 10,
	DEFAULT_COOLDOWN = 20,
	STEP_GRACE_RADIUS = 1.5,
	STEP_FAIL_TIMEOUT = 1.25,
	MIN_HEARTBEAT = 1/60,
	STATE_DELAY = 0.5,

	PLACEHOLDER_ID = "Change_Me",
	PLACEHOLDER_EVENT = "Change_Me",

	RITUAL_FOLDER_NAME = "Rituals",
	VFX_TAG = "PlayerVFX",
}

type _FrozenMovement = {
	WalkSpeed: number,
	JumpPower: number,
	AutoRotate: boolean
}

local _frozen: {[Player]: _FrozenMovement} = {}

type _Conn = {
	Connected: boolean,
	Disconnect: (self: _Conn) -> ()
}

type _Signal = {
	Connect: (self: _Signal, f: (...any) -> ()) -> _Conn,
	Fire: (self: _Signal, ...any) -> ()
}

local OnRitualStateChanged: _Signal
local OnRitualProgress: _Signal

local function now(): number
	return os.clock()
end

local function getAttrNumber(obj: Instance, name: string, fallback: number): number
	local v = obj:GetAttribute(name)
	return if typeof(v) == "number" then v else fallback
end

local function getAttrString(obj: Instance, name: string, fallback: string): string
	local v = obj:GetAttribute(name)
	return if typeof(v) == "string" then v else fallback
end

local function getAttrBoolean(obj: Instance, name: string, fallback: boolean): boolean
	local v = obj:GetAttribute(name)
	return if typeof(v) == "boolean" then v else fallback
end

local function getWorldCenter(inst: Instance): Vector3
	if inst:IsA("BasePart") then
		return inst.Position
	elseif inst:IsA("Model") then
		local primary = inst.PrimaryPart
		if primary then return primary.Position end
		local cf = inst:GetBoundingBox()
		return cf.Position
	end
	error("Ritual spot must be a BasePart or Model")
end

local function getRoot(p: Player): BasePart?
	local c = p.Character
	if not c then return nil end
	return c:FindFirstChild("HumanoidRootPart") :: BasePart?
end

local function distance(a: Vector3, b: Vector3): number
	return (a - b).Magnitude
end

local function safeAddTag(inst: Instance, tag: string)
	local ok = pcall(function()
		CollectionService:AddTag(inst, tag)
	end)
	if not ok then
		local any = inst :: any
		if typeof(any.AddTag) == "function" then
			pcall(function() any:AddTag(tag) end)
		end
	end
end

local function createSignal(): _Signal
	local be = Instance.new("BindableEvent")
	local sig = {}

	function sig:Connect(f: (...any) -> ()): _Conn
		local c = be.Event:Connect(f)
		return {
			Connected = true,
			Disconnect = function(self)
				if self.Connected then
					self.Connected = false
					c:Disconnect()
				end
			end
		}
	end

	function sig:Fire(...)
		be:Fire(...)
	end

	return sig :: any
end

OnRitualStateChanged = createSignal()
OnRitualProgress = createSignal()

local function freezePlayer(p: Player, spot: RitualSpot)
	if _frozen[p] then return end

	local c = p.Character
	if not c then return end

	local hum = c:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	_frozen[p] = {
		WalkSpeed = hum.WalkSpeed,
		JumpPower = hum.JumpPower,
		AutoRotate = hum.AutoRotate,
	}

	hum.WalkSpeed = 0
	hum.JumpPower = 0
	hum.AutoRotate = false

	if spot.FaceCenter then
		local root = c:FindFirstChild("HumanoidRootPart") :: BasePart?
		if root then
			local dir = spot.Center - root.Position
			if dir.Magnitude > 0.1 then
				root.CFrame = CFrame.new(root.Position, root.Position + dir.Unit)
			end
		end
	end
end

local function unfreezePlayer(p: Player)
	local rec = _frozen[p]
	if not rec then return end

	_frozen[p] = nil

	local c = p.Character
	if not c then return end

	local hum = c:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	hum.WalkSpeed = rec.WalkSpeed
	hum.JumpPower = rec.JumpPower
	hum.AutoRotate = rec.AutoRotate
end

local function setState(spot: RitualSpot, newState: typeof(spot.State))
	if spot.State == newState then return end

	local old = spot.State
	spot.State = newState
	spot.StateChangedAt = now()

	local t = _ritualTypes[spot.RitualType]
	if t and t.OnStateChanged then
		pcall(t.OnStateChanged, spot, old, newState)
	end

	OnRitualStateChanged:Fire(spot, old, newState)
end

local function clearRuntime(spot: RitualSpot)
	spot.ActivePlayers = {}
	spot.Channelers = {}
	spot.Progress = 0
	spot.LastProgressAt = 0
end

local function coolingDown(spot: RitualSpot): boolean
	return now() < spot.NextAllowedAt
end

local function markCooldown(spot: RitualSpot)
	spot.NextAllowedAt = now() + math.max(0, spot.Cooldown)
	setState(spot, "Cooldown")
end

local function unfreezeAllInSpot(spot: RitualSpot)
	for p, _ in pairs(spot.ActivePlayers) do
		unfreezePlayer(p)
	end
end

local function complete(spot: RitualSpot)
	setState(spot, "Completed")

	local t = _ritualTypes[spot.RitualType]
	if t and t.OnComplete then
		pcall(t.OnComplete, spot)
	end

	task.delay(CONSTANTS.STATE_DELAY, function()
		markCooldown(spot)
		task.delay(spot.Cooldown, function()
			clearRuntime(spot)
			setState(spot, "Idle")
		end)
	end)
end

local function fail(spot: RitualSpot, reason: string)
	setState(spot, "Failed")

	local t = _ritualTypes[spot.RitualType]
	if t and t.OnFail then
		pcall(t.OnFail, spot, reason)
	end

	task.delay(CONSTANTS.STATE_DELAY, function()
		markCooldown(spot)
		task.delay(spot.Cooldown, function()
			clearRuntime(spot)
			setState(spot, "Idle")
		end)
	end)

	unfreezeAllInSpot(spot)
end

local function gateAllowsRitual(): boolean
	return EventService:GetActiveEvent(CONSTANTS.PLACEHOLDER_EVENT) and true or false
end

local function isPlayerEligible(plr: Player, spot: RitualSpot): boolean
	if not plr:GetAttribute("Stealing") then return false end
	if plr:GetAttribute("StealingIndex") ~= CONSTANTS.PLACEHOLDER_ID then return false end

	local root = getRoot(plr)
	if not root then return false end

	return distance(root.Position, spot.Center) <= spot.Radius
end

local function playersEligibleAtSpot(spot: RitualSpot): {Player}
	local results = {}

	if not gateAllowsRitual() then
		return results
	end

	for _, plr in ipairs(Players:GetPlayers()) do
		if isPlayerEligible(plr, spot) then
			table.insert(results, plr)
		end
	end

	return results
end

local function lockPlayersIfNeeded(spot: RitualSpot, list: {Player})
	if not spot.FreezePlayers then return end

	for _, p in ipairs(list) do
		freezePlayer(p, spot)
		local c = p.Character
		if c then
			safeAddTag(c, CONSTANTS.VFX_TAG)
			c:SetAttribute("Index", spot.IndexName)
		end
	end
end

local function setChannelerAttributes(spot: RitualSpot)
	for _, p in ipairs(spot.Channelers) do
		local c = p.Character
		if c then
			c:SetAttribute("RitualType", spot.RitualType)
			c:SetAttribute("RitualIndex", spot.IndexName)
		end
	end
end

local function clearChannelerAttributes(spot: RitualSpot)
	for _, p in ipairs(spot.Channelers) do
		unfreezePlayer(p)
		local c = p.Character
		if c then
			c:SetAttribute("RitualType", nil)
			c:SetAttribute("RitualIndex", nil)
		end
	end
end

local function beginChanneling(spot: RitualSpot, chan: {Player})
	spot.Channelers = table.clone(chan)
	spot.Progress = 0
	spot.LastProgressAt = now()

	lockPlayersIfNeeded(spot, spot.Channelers)

	local t = _ritualTypes[spot.RitualType]
	if t and t.OnBegin then
		pcall(t.OnBegin, spot)
	end

	setState(spot, "Channeling")
end

local function checkChannelersPresent(spot: RitualSpot): boolean
	local present = {}
	local maxRadius = spot.Radius + CONSTANTS.STEP_GRACE_RADIUS

	for _, p in ipairs(spot.Channelers) do
		local root = getRoot(p)
		if root and distance(root.Position, spot.Center) <= maxRadius then
			present[p] = true
		end
	end

	for _, p in ipairs(spot.Channelers) do
		if not present[p] then
			if (now() - spot.LastProgressAt) >= CONSTANTS.STEP_FAIL_TIMEOUT then
				return false
			end
		end
	end

	return true
end

local function calculateProgress(spot: RitualSpot, dt: number): number
	local t = _ritualTypes[spot.RitualType]

	if t and t.OnStep then
		local ok, res = pcall(t.OnStep, spot, dt)
		if ok and typeof(res) == "number" then
			return res
		end
	end

	return (dt / math.max(0.1, spot.Duration)) * math.max(1, #spot.Channelers)
end

local function updateChanneling(spot: RitualSpot, dt: number)
	if not checkChannelersPresent(spot) then
		fail(spot, "Player left radius")
		return
	end

	local delta = calculateProgress(spot, dt)
	spot.Progress = math.clamp(spot.Progress + delta, 0, 1)

	if delta > 0 then
		spot.LastProgressAt = now()
	end

	OnRitualProgress:Fire(spot, spot.Progress)

	if spot.Progress >= 1 then
		clearChannelerAttributes(spot)
		complete(spot)
	end
end

local function handleIdleOrGathering(spot: RitualSpot)
	if coolingDown(spot) then
		setState(spot, "Cooldown")
		return
	end

	local eligible = playersEligibleAtSpot(spot)
	spot.ActivePlayers = {}
	for _, p in ipairs(eligible) do
		spot.ActivePlayers[p] = true
	end

	if #eligible >= spot.RequiredPlayers then
		if spot.State ~= "Gathering" then
			setState(spot, "Gathering")
		end
		beginChanneling(spot, eligible)
	else
		if spot.State ~= "Idle" then
			setState(spot, "Idle")
		end
	end
end

local function tickSpot(spot: RitualSpot, dt: number)
	local ok, newCenter = pcall(getWorldCenter, spot.Instance)
	if ok and typeof(newCenter) == "Vector3" then
		spot.Center = newCenter
	end

	if spot.State == "Cooldown" then
		return
	end

	if not gateAllowsRitual() then
		if spot.State == "Channeling" or spot.State == "Gathering" then
			fail(spot, "Event gate closed")
		end
		return
	end

	if spot.State == "Idle" or spot.State == "Gathering" then
		handleIdleOrGathering(spot)
	elseif spot.State == "Channeling" then
		updateChanneling(spot, dt)
	end
end

local function bakeSpot(inst: Instance): RitualSpot
	local center = getWorldCenter(inst)
	return {
		Instance = inst :: any,
		Center = center,
		Radius = getAttrNumber(inst, "Radius", CONSTANTS.DEFAULT_RADIUS),
		RequiredPlayers = getAttrNumber(inst, "RequiredPlayers", CONSTANTS.DEFAULT_REQUIRED),
		Duration = getAttrNumber(inst, "Duration", CONSTANTS.DEFAULT_DURATION),
		Cooldown = getAttrNumber(inst, "Cooldown", CONSTANTS.DEFAULT_COOLDOWN),
		RitualId = getAttrString(inst, "RitualId", CONSTANTS.PLACEHOLDER_ID),
		RitualType = getAttrString(inst, "RitualType", CONSTANTS.PLACEHOLDER_ID),
		IndexName = getAttrString(inst, "IndexName", inst.Name),
		FreezePlayers = getAttrBoolean(inst, "FreezePlayers", true),
		FaceCenter = getAttrBoolean(inst, "FaceCenter", true),
		State = "Idle",
		StateChangedAt = 0,
		NextAllowedAt = 0,
		ActivePlayers = {},
		Progress = 0,
		LastProgressAt = 0,
		Channelers = {},
	}
end

local function addSpotFromInstance(inst: Instance)
	if inst:IsA("BasePart") or inst:IsA("Model") then
		local spot = bakeSpot(inst)
		_spots[spot.IndexName] = spot
	end
end

local function cacheSpotsFromFolder()
	local folder = script:FindFirstChild(CONSTANTS.RITUAL_FOLDER_NAME)
	if not folder then
		warn("[RitualService] No Rituals folder; creating an empty one for hot-add.")
		folder = Instance.new("Folder")
		folder.Name = CONSTANTS.RITUAL_FOLDER_NAME
		folder.Parent = script
	end

	for _, inst in ipairs(folder:GetChildren()) do
		addSpotFromInstance(inst)
	end

	folder.ChildAdded:Connect(function(inst)
		task.defer(function()
			addSpotFromInstance(inst)
		end)
	end)
end

local function createBasicStepFunction(scale: number)
	return function(spot: RitualSpot, dt: number): number
		local k = #spot.Channelers
		return (dt / math.max(0.1, spot.Duration)) * math.max(1, k) * scale
	end
end

local function createBasicCompleteCallback(label: string)
	return function(spot: RitualSpot)
		print(("[RitualService] %s ritual COMPLETE at %s (%s)")
			:format(label, spot.IndexName, spot.RitualId))
	end
end

local function createBasicFailCallback(label: string)
	return function(spot: RitualSpot, reason: string?)
		print(("[RitualService] %s ritual FAILED at %s (%s) reason=%s")
			:format(label, spot.IndexName, spot.RitualId, tostring(reason)))
	end
end

local function basicBegin(spot: RitualSpot)
	setChannelerAttributes(spot)
end

local function basicStateChanged(_spot: RitualSpot, _old: string, _new: string)
end

local function registerDefaultRitualTypes()
	RitualService:RegisterType({
		Name = "Sealing",
		Description = "Seal the target by focusing together.",
		OnBegin = basicBegin,
		OnStep = createBasicStepFunction(1.0),
		OnComplete = createBasicCompleteCallback("Sealing"),
		OnFail = createBasicFailCallback("Sealing"),
		OnStateChanged = basicStateChanged,
	})

	RitualService:RegisterType({
		Name = "Summoning",
		Description = "Summon; scales up with more participants.",
		OnBegin = basicBegin,
		OnStep = function(spot: RitualSpot, dt: number)
			local k = #spot.Channelers
			local scale = 1.0 + 0.25 * math.max(0, k - 1)
			return (dt / math.max(0.1, spot.Duration)) * math.max(1, k) * scale
		end,
		OnComplete = createBasicCompleteCallback("Summoning"),
		OnFail = createBasicFailCallback("Summoning"),
		OnStateChanged = basicStateChanged,
	})

	RitualService:RegisterType({
		Name = "Purification",
		Description = "Cleanse; progress decays if short on players.",
		OnBegin = basicBegin,
		OnStep = function(spot: RitualSpot, dt: number)
			local k = #spot.Channelers
			local inc = (dt / math.max(0.1, spot.Duration)) * math.max(1, k)
			if k < spot.RequiredPlayers then
				inc -= (dt * 0.05)
			end
			return inc
		end,
		OnComplete = createBasicCompleteCallback("Purification"),
		OnFail = createBasicFailCallback("Purification"),
		OnStateChanged = basicStateChanged,
	})
end

function RitualService:GetSignals()
	return {
		OnRitualStateChanged = OnRitualStateChanged,
		OnRitualProgress = OnRitualProgress,
	}
end

function RitualService:RegisterType(def: RitualTypeDef)
	assert(def and def.Name, "RitualTypeDef missing Name")
	_ritualTypes[def.Name] = def
end

function RitualService:GetType(name: string): RitualTypeDef?
	return _ritualTypes[name]
end

function RitualService:RegisterRitualSpot(cfg: RitualSpotConfig)
	assert(cfg.Instance, "RegisterRitualSpot requires Instance")
	local spot = bakeSpot(cfg.Instance)

	if cfg.RitualId then spot.RitualId = cfg.RitualId end
	if cfg.RitualType then spot.RitualType = cfg.RitualType end
	if cfg.IndexName then spot.IndexName = cfg.IndexName end
	if cfg.Radius then spot.Radius = cfg.Radius end
	if cfg.RequiredPlayers then spot.RequiredPlayers = cfg.RequiredPlayers end
	if cfg.Duration then spot.Duration = cfg.Duration end
	if cfg.Cooldown then spot.Cooldown = cfg.Cooldown end
	if cfg.FreezePlayers ~= nil then spot.FreezePlayers = cfg.FreezePlayers end
	if cfg.FaceCenter ~= nil then spot.FaceCenter = cfg.FaceCenter end

	_spots[spot.IndexName] = spot
end

function RitualService:GetSpots(): {[string]: RitualSpot}
	return _spots
end

function RitualService:ForceStartAt(indexName: string, players: {Player}?)
	local spot = _spots[indexName]
	assert(spot, "No ritual spot named " .. indexName)

	if not gateAllowsRitual() then
		error("Gate not open")
	end

	if coolingDown(spot) then
		error("Spot on cooldown")
	end

	local channelers = players or playersEligibleAtSpot(spot)
	if #channelers < spot.RequiredPlayers then
		error(("Need at least %d players, got %d"):format(spot.RequiredPlayers, #channelers))
	end

	beginChanneling(spot, channelers)
end

function RitualService:Cancel(indexName: string, reason: string?)
	local spot = _spots[indexName]
	if not spot then return end

	if spot.State == "Channeling" or spot.State == "Gathering" then
		fail(spot, reason or "Cancelled")
	end
end

function RitualService:GetSpot(indexName: string): RitualSpot?
	return _spots[indexName]
end

function RitualService:GetActiveRituals(): {RitualSpot}
	local list = {}
	for _, s in pairs(_spots) do
		if s.State == "Gathering" or s.State == "Channeling" then
			table.insert(list, s)
		end
	end
	return list
end

function RitualService:Start()
	if _running then return end
	_running = true

	cacheSpotsFromFolder()
	registerDefaultRitualTypes()

	local last = now()
	_hbConn = RunService.Heartbeat:Connect(function(_)
		local tnow = now()
		local dt = math.max(CONSTANTS.MIN_HEARTBEAT, tnow - last)
		last = tnow

		for _, spot in pairs(_spots) do
			local okTick, err = pcall(tickSpot, spot, dt)
			if not okTick then
				warn("[RitualService] tick error: ", err)
			end
		end
	end)
end

function RitualService:Stop()
	if not _running then return end
	_running = false

	if _hbConn then
		_hbConn:Disconnect()
	end
	_hbConn = nil

	for _, s in pairs(_spots) do
		setState(s, "Idle")
	end

	for p, _ in pairs(_frozen) do
		unfreezePlayer(p)
	end
end

return RitualService