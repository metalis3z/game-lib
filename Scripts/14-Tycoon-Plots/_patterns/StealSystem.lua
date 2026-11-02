--!strict
-- StealSystem (pattern module)
-- Server-authoritative "steal an item from another player's base and carry it home" with base locks.
--
-- Ideas taken from: evade + steal-a-brainrot (StealService / PlotService: StealHitbox check with
-- GetPartBoundsInBox, carry weld + slower walk speed, DeliveryHitbox Heartbeat monitor, cancel on
-- death/leave, LockBase that "grandfathers" thieves already inside), steal-a-brainrot-sab-files
-- (per-slot steal lock, steal cooldown, protection for players who just joined) and steal-an-egg
-- (carry state machine, guards knocking the item loose).
-- One thing the leaked servers did NOT do: check the base lock on the server (they relied on
-- client-side laser collision). This module rejects steals from locked bases on the server.
--
-- World layout per plot (Model):
--   StealZone    (BasePart, non-colliding)  -- a thief must stand inside this to start a steal
--   DeliveryZone (BasePart, non-colliding)  -- the thief must reach their OWN plot's zone to finish
--
-- Usage (server):
--   local StealSystem = require(path.to.StealSystem)
--   StealSystem.Init({
--       GetPlot      = PlotManager.GetPlot,            -- (player) -> Model?
--       GetOwner     = PlotManager.GetOwner,           -- (plot) -> Player?
--       FindPlot     = function(name) return workspace.Plots:FindFirstChild(name) end,
--       PeekItem     = function(plot, slot) ... end,   -- -> item table or nil (read only)
--       TakeItem     = function(plot, slot) ... end,   -- -> item table or nil (removes it)
--       GiveItem     = function(player, item) ... end, -- -> true if stored in the thief's base
--       HasFreeSlot  = function(player) ... end,       -- -> boolean
--       MakeCarryModel = function(item) ... end,       -- -> Model? (visual only, optional)
--   })
--   -- client: StealRemote:FireServer(plot.Name, slotNumber)  (e.g. from a ProximityPrompt)
--   StealSystem.LockBase(player, 60)                  -- e.g. from a lock button on the plot
--   StealSystem.Stolen:Connect(function(thief, victim, item) ... end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

export type Hooks = {
	GetPlot: (Player) -> Model?,
	GetOwner: (Model) -> Player?,
	FindPlot: (string) -> Instance?,
	PeekItem: (Model, number) -> any,
	TakeItem: (Model, number) -> any,
	GiveItem: (Player, any) -> boolean,
	HasFreeSlot: (Player) -> boolean,
	MakeCarryModel: ((any) -> Model?)?,
}

type Carry = {
	VictimPlot: Model,
	Slot: number,
	StartedAt: number,
	Model: Model?,
	Connections: { RBXScriptConnection },
	OriginalSpeed: number?,
}

local CONFIG = {
	CarrySpeedMultiplier = 0.75,
	StealCooldown = 1.0,       -- seconds between steal attempts per thief
	JoinProtection = 30,       -- victims can't be robbed this soon after joining
	MaxCarryTime = 90,         -- give the item back if not delivered in time
	DefaultLockTime = 60,
}

local StealSystem = {}
StealSystem.Config = CONFIG

local stolenEvent = Instance.new("BindableEvent")
local cancelledEvent = Instance.new("BindableEvent")
StealSystem.Stolen = stolenEvent.Event       -- (thief, victim?, item)
StealSystem.Cancelled = cancelledEvent.Event -- (thief, reason)

local hooks: Hooks
local carries: { [Player]: Carry } = {}
local slotLocks: { [string]: Player } = {}       -- "plotName#slot" -> thief
local lastAttempt: { [Player]: number } = {}
local joinedAt: { [Player]: number } = {}
local grandfathered: { [Model]: { [Player]: boolean } } = {}

local function slotKey(plot: Instance, slot: number): string
	return plot.Name .. "#" .. tostring(slot)
end

local function isInside(part: BasePart, position: Vector3): boolean
	local localPos = part.CFrame:PointToObjectSpace(position)
	local half = part.Size * 0.5
	return math.abs(localPos.X) <= half.X and math.abs(localPos.Y) <= half.Y and math.abs(localPos.Z) <= half.Z
end

local function getRoot(player: Player): BasePart?
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	return if root and root:IsA("BasePart") then root else nil
end

local function getHumanoid(player: Player): Humanoid?
	local character = player.Character
	return character and character:FindFirstChildOfClass("Humanoid")
end

local function playerInZone(player: Player, plot: Model, zoneName: string): boolean
	local zone = plot:FindFirstChild(zoneName)
	local root = getRoot(player)
	return zone ~= nil and zone:IsA("BasePart") and root ~= nil and isInside(zone, root.Position)
end

-- Base locks ----------------------------------------------------------------

function StealSystem.IsLocked(plot: Model): boolean
	local untilTime = plot:GetAttribute("LockedUntil")
	return typeof(untilTime) == "number" and workspace:GetServerTimeNow() < untilTime
end

-- Lock the player's base. Thieves already inside the StealZone keep the right to finish
-- (the "GrandfatheredThieves" idea from Steal a Brainrot), everyone else is refused.
function StealSystem.LockBase(player: Player, seconds: number?): boolean
	local plot = hooks.GetPlot(player)
	if not plot or StealSystem.IsLocked(plot) then
		return false
	end
	local duration = seconds or CONFIG.DefaultLockTime
	local inside = {}
	for _, other in ipairs(Players:GetPlayers()) do
		if other ~= player and playerInZone(other, plot, "StealZone") then
			inside[other] = true
		end
	end
	grandfathered[plot] = inside
	plot:SetAttribute("LockedUntil", workspace:GetServerTimeNow() + duration) -- clients show a timer
	task.delay(duration, function()
		if not StealSystem.IsLocked(plot) then
			grandfathered[plot] = nil
		end
	end)
	return true
end

-- Carry lifecycle -------------------------------------------------------------

local function endCarry(thief: Player): Carry?
	local carry = carries[thief]
	if not carry then
		return nil
	end
	carries[thief] = nil
	slotLocks[slotKey(carry.VictimPlot, carry.Slot)] = nil
	for _, c in ipairs(carry.Connections) do
		c:Disconnect()
	end
	if carry.Model then
		carry.Model:Destroy()
	end
	local humanoid = getHumanoid(thief)
	if humanoid and carry.OriginalSpeed then
		humanoid.WalkSpeed = carry.OriginalSpeed
	end
	thief:SetAttribute("Carrying", nil)
	return carry
end

function StealSystem.Cancel(thief: Player, reason: string?)
	-- The item never left the victim's data, so cancelling just releases the slot lock.
	if endCarry(thief) then
		cancelledEvent:Fire(thief, reason or "cancelled")
	end
end

local function complete(thief: Player)
	local carry = carries[thief]
	if not carry then
		return
	end
	if not hooks.HasFreeSlot(thief) then
		return -- keep carrying until they free a slot or time runs out
	end
	local victimPlot = carry.VictimPlot
	local victim = hooks.GetOwner(victimPlot)
	endCarry(thief)
	local item = hooks.TakeItem(victimPlot, carry.Slot)
	if item == nil then
		cancelledEvent:Fire(thief, "item gone")
		return
	end
	if not hooks.GiveItem(thief, item) then
		-- HasFreeSlot was checked just above, so this should not happen; log it so the game
		-- can decide how to refund.
		warn("[StealSystem] GiveItem failed after TakeItem; item:", item)
	end
	stolenEvent:Fire(thief, victim, item)
end

local function attachCarryModel(thief: Player, item: any): Model?
	if not hooks.MakeCarryModel then
		return nil
	end
	local root = getRoot(thief)
	local model = hooks.MakeCarryModel(item)
	if not model or not root then
		if model then
			model:Destroy()
		end
		return nil
	end
	local primary = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
	if not primary then
		model:Destroy()
		return nil
	end
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = false
			d.CanCollide = false
			d.CanTouch = false
			d.CanQuery = false
			d.Massless = true
			if d ~= primary then
				local w = Instance.new("WeldConstraint")
				w.Part0 = primary
				w.Part1 = d
				w.Parent = primary
			end
		end
	end
	model:PivotTo(root.CFrame * CFrame.new(0, 1, -2))
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = root
	weld.Part1 = primary
	weld.Parent = primary
	model.Parent = thief.Character
	return model
end

-- Every check runs here. Returns (ok, reason).
function StealSystem.TryStartSteal(thief: Player, plotName: any, slot: any): (boolean, string?)
	if typeof(plotName) ~= "string" or typeof(slot) ~= "number" or slot ~= slot or slot % 1 ~= 0 then
		return false, "bad request"
	end
	local now = os.clock()
	if lastAttempt[thief] and now - lastAttempt[thief] < CONFIG.StealCooldown then
		return false, "cooldown"
	end
	lastAttempt[thief] = now

	if carries[thief] then
		return false, "already carrying"
	end
	local humanoid = getHumanoid(thief)
	if not humanoid or humanoid.Health <= 0 then
		return false, "dead"
	end
	local found = hooks.FindPlot(plotName)
	if not found or not found:IsA("Model") then
		return false, "no such plot"
	end
	local victimPlot: Model = found
	local victim = hooks.GetOwner(victimPlot)
	if not victim or victim == thief then
		return false, "not stealable"
	end
	if joinedAt[victim] and os.clock() - joinedAt[victim] < CONFIG.JoinProtection then
		return false, "victim just joined"
	end
	if StealSystem.IsLocked(victimPlot) then
		local allowed = grandfathered[victimPlot]
		if not (allowed and allowed[thief]) then
			return false, "base locked"
		end
	end
	if not playerInZone(thief, victimPlot, "StealZone") then
		return false, "too far"
	end
	if not hooks.HasFreeSlot(thief) then
		return false, "your base is full"
	end
	local key = slotKey(victimPlot, slot)
	if slotLocks[key] then
		return false, "someone else is stealing it"
	end
	local item = hooks.PeekItem(victimPlot, slot)
	if item == nil then
		return false, "empty slot"
	end

	-- Start carrying. The item stays in the victim's data until delivery (like Steal a Brainrot),
	-- so a crash, death or leave can never duplicate or delete it.
	slotLocks[key] = thief
	local carry: Carry = {
		VictimPlot = victimPlot,
		Slot = slot,
		StartedAt = os.clock(),
		Model = attachCarryModel(thief, item),
		Connections = {},
		OriginalSpeed = humanoid.WalkSpeed,
	}
	humanoid.WalkSpeed *= CONFIG.CarrySpeedMultiplier
	table.insert(carry.Connections, humanoid.Died:Connect(function()
		StealSystem.Cancel(thief, "died")
	end))
	table.insert(carry.Connections, victimPlot.AncestryChanged:Connect(function()
		if not victimPlot.Parent then
			StealSystem.Cancel(thief, "plot removed")
		end
	end))
	carries[thief] = carry
	thief:SetAttribute("Carrying", key)
	victimPlot:SetAttribute("BeingStolen", true) -- lets the victim's client show a warning
	return true, nil
end

function StealSystem.IsCarrying(player: Player): boolean
	return carries[player] ~= nil
end

function StealSystem.Init(h: Hooks, remote: RemoteEvent?)
	hooks = h

	local stealRemote = remote
	if not stealRemote then
		local r = Instance.new("RemoteEvent")
		r.Name = "StealRequest"
		r.Parent = ReplicatedStorage
		stealRemote = r
	end
	assert(stealRemote)
	stealRemote.OnServerEvent:Connect(function(player, plotName, slot)
		StealSystem.TryStartSteal(player, plotName, slot)
	end)

	Players.PlayerAdded:Connect(function(player)
		joinedAt[player] = os.clock()
	end)
	Players.PlayerRemoving:Connect(function(player)
		StealSystem.Cancel(player, "left")
		-- Cancel anyone stealing from the leaving player's base (works whether or not the
		-- plot manager already released the plot).
		for thief, carry in pairs(carries) do
			local owner = hooks.GetOwner(carry.VictimPlot)
			if owner == nil or owner == player then
				StealSystem.Cancel(thief, "victim left")
			end
		end
		joinedAt[player] = nil
		lastAttempt[player] = nil
	end)

	-- One Heartbeat for all carriers: deliver, time out, and clear the BeingStolen flag.
	RunService.Heartbeat:Connect(function()
		local stillStolen: { [Model]: boolean } = {}
		for thief, carry in pairs(carries) do
			local home = hooks.GetPlot(thief)
			if os.clock() - carry.StartedAt > CONFIG.MaxCarryTime then
				StealSystem.Cancel(thief, "timeout")
			elseif home and playerInZone(thief, home, "DeliveryZone") then
				complete(thief)
			end
			if carries[thief] then
				stillStolen[carry.VictimPlot] = true
			end
		end
		for _, player in ipairs(Players:GetPlayers()) do
			local plot = hooks.GetPlot(player)
			if plot and plot:GetAttribute("BeingStolen") and not stillStolen[plot] then
				plot:SetAttribute("BeingStolen", nil)
			end
		end
	end)
end

return StealSystem
