-- ChaserBrain (pattern module, written for this library)
-- What it does: a small state machine for a monster / killer / guard NPC:
--   PATROL -> (notices player) -> CHASE -> (loses sight) -> SEARCH last known position -> PATROL
-- Senses: sight (field-of-view cone + raycast), hearing (players moving fast inside a radius),
-- a perception meter that must fill before the NPC commits to a chase, memory of the last known
-- position, a leash (gives up if dragged too far from home) and a melee attack with cooldown.
--
-- Credit / ideas taken from:
--   backrooms-exploration  AI Chase           (state table + enter/update functions, look-at check)
--   doors                  Figure AssetControl (blind monster that only "hears" moving players; patrol nodes)
--   scp-tycoon             Enemy AI           (perception value fills while visible, memory decays)
--   smash-egg-for-animals  ZoneBossServer     (leash / give-up rules, safe-zone check hook)
--   the-rake               BotBrain           (props table you can change at runtime)
--
-- Depends on the PathFollower pattern in this same folder.
--
-- Usage (server Script inside the monster model, or a manager script):
--   local ChaserBrain = require(path.to.ChaserBrain)
--   local brain = ChaserBrain.new(workspace.Monster, {
--       PatrolNodes = workspace.MonsterNodes:GetChildren(), -- optional; random wander if empty
--       SightRange = 80, FieldOfView = 110, HearRange = 40, HearSpeed = 12,
--       WalkSpeed = 10, ChaseSpeed = 22, AttackRange = 4, AttackDamage = 35,
--       IsValidTarget = function(player) return player.Team ~= game.Teams.Lobby end,
--   })
--   brain.StateChanged.Event:Connect(function(new, old) print(old, "->", new) end)
--   brain:Start()
--   -- later: brain:Destroy()

local Players = game:GetService("Players")

local PathFollower = require(script.Parent:WaitForChild("PathFollower"))

local ChaserBrain = {}
ChaserBrain.__index = ChaserBrain

ChaserBrain.State = { PATROL = "Patrol", CHASE = "Chase", SEARCH = "Search", RETURN = "Return" }

local DEFAULTS = {
	PatrolNodes = {},        -- BaseParts to walk between; empty = random wander around home
	WanderRadius = 40,
	PatrolPause = { 1, 3 },  -- seconds to wait at each patrol point
	SightRange = 80,
	FieldOfView = 110,       -- degrees, full cone
	HearRange = 35,
	HearSpeed = 12,          -- players moving faster than this are "heard" (DOORS Figure idea)
	PerceptionRate = 2.5,    -- meter units per second while the player is seen (meter goes 0..1)
	PerceptionDecay = 0.5,
	MemoryTime = 6,          -- seconds to keep chasing / searching after losing sight
	LeashDistance = 250,     -- give up if this far from home
	WalkSpeed = 10,
	ChaseSpeed = 22,
	AttackRange = 4,
	AttackDamage = 35,
	AttackCooldown = 1.2,
	TickRate = 0.15,         -- brain update interval (pathing runs in its own thread)
	IsValidTarget = nil :: ((Player) -> boolean)?,
	OnAttack = nil :: ((Player, Humanoid) -> ())?, -- replace the default damage (e.g. jumpscare)
}

function ChaserBrain.new(model: Model, config: { [string]: any }?)
	local self = setmetatable({}, ChaserBrain)
	self.Model = model
	self.Humanoid = model:FindFirstChildOfClass("Humanoid") :: Humanoid
	self.Root = model:FindFirstChild("HumanoidRootPart") :: BasePart
	assert(self.Humanoid and self.Root, "ChaserBrain needs a Humanoid and HumanoidRootPart")

	self.Config = table.clone(DEFAULTS)
	for k, v in pairs(config or {}) do
		self.Config[k] = v
	end

	self.Follower = PathFollower.new(model)
	self.Home = self.Root.Position
	self.State = ChaserBrain.State.PATROL
	self.Target = nil :: Player?
	self.LastKnown = nil :: Vector3?
	self.LastSeenAt = 0
	self.Perception = 0
	self._lastAttack = 0
	self._patrolIndex = 0
	self._moveThread = nil :: thread?
	self._running = false

	self.StateChanged = Instance.new("BindableEvent") -- (newState, oldState)
	return self
end

---------------------------------------------------------------- senses

local function rootOf(player: Player): BasePart?
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then
		return nil
	end
	return character:FindFirstChild("HumanoidRootPart") :: BasePart?
end

function ChaserBrain:_valid(player: Player): boolean
	local check = self.Config.IsValidTarget
	return rootOf(player) ~= nil and (check == nil or check(player))
end

function ChaserBrain:CanSee(player: Player): boolean
	local hrp = rootOf(player)
	if not hrp then
		return false
	end
	local offset = hrp.Position - self.Root.Position
	if offset.Magnitude > self.Config.SightRange then
		return false
	end
	local cosHalf = math.cos(math.rad(self.Config.FieldOfView / 2))
	if self.Root.CFrame.LookVector:Dot(offset.Unit) < cosHalf then
		return false
	end
	return self.Follower:CanSee(hrp.Position, { player.Character :: Instance })
end

function ChaserBrain:CanHear(player: Player): boolean
	local hrp = rootOf(player)
	if not hrp then
		return false
	end
	local v = hrp.AssemblyLinearVelocity
	local flatSpeed = Vector3.new(v.X, 0, v.Z).Magnitude
	return flatSpeed >= self.Config.HearSpeed and (hrp.Position - self.Root.Position).Magnitude <= self.Config.HearRange
end

-- Best candidate: anyone visible first, otherwise anyone heard; nearest wins.
function ChaserBrain:_scan(): (Player?, boolean)
	local best, bestDist, bestSeen = nil, math.huge, false
	for _, player in ipairs(Players:GetPlayers()) do
		if self:_valid(player) then
			local seen = self:CanSee(player)
			if seen or self:CanHear(player) then
				local d = ((rootOf(player) :: BasePart).Position - self.Root.Position).Magnitude
				if (seen and not bestSeen) or (seen == bestSeen and d < bestDist) then
					best, bestDist, bestSeen = player, d, seen
				end
			end
		end
	end
	return best, bestSeen
end

---------------------------------------------------------------- movement (one background thread at a time)

function ChaserBrain:_go(fn: () -> ())
	self.Follower:Stop()
	local old = self._moveThread
	-- A move thread may itself trigger the next state (SEARCH -> RETURN); never cancel the running thread.
	if old and old ~= coroutine.running() and coroutine.status(old) ~= "dead" then
		task.cancel(old)
	end
	self._moveThread = task.spawn(fn)
end

function ChaserBrain:_setState(new: string)
	local old = self.State
	if new == old then
		return
	end
	self.State = new
	self.StateChanged:Fire(new, old)

	local cfg = self.Config
	if new == ChaserBrain.State.PATROL then
		self.Humanoid.WalkSpeed = cfg.WalkSpeed
		self:_go(function()
			while self.State == ChaserBrain.State.PATROL do
				self.Follower:MoveTo(self:_nextPatrolPoint())
				task.wait(math.random(cfg.PatrolPause[1] * 10, cfg.PatrolPause[2] * 10) / 10)
			end
		end)
	elseif new == ChaserBrain.State.CHASE then
		self.Humanoid.WalkSpeed = cfg.ChaseSpeed
		self:_go(function()
			-- Chase() returns when we are in attack range; keep chasing while the state lasts.
			while self.State == ChaserBrain.State.CHASE do
				local caught = self.Follower:Chase(function()
					local hrp = self.Target and rootOf(self.Target)
					return hrp and hrp.Position or self.LastKnown
				end, { StopDistance = cfg.AttackRange * 0.8, MaxTime = 120 })
				task.wait(caught and 0.2 or 0.5)
			end
		end)
	elseif new == ChaserBrain.State.SEARCH then
		self.Humanoid.WalkSpeed = (cfg.WalkSpeed + cfg.ChaseSpeed) / 2
		local spot = self.LastKnown
		self:_go(function()
			if spot then
				self.Follower:MoveTo(spot)
			end
			task.wait(2) -- look around for a moment
			if self.State == ChaserBrain.State.SEARCH then
				self:_setState(ChaserBrain.State.RETURN)
			end
		end)
	elseif new == ChaserBrain.State.RETURN then
		self.Humanoid.WalkSpeed = cfg.WalkSpeed
		self:_go(function()
			self.Follower:MoveTo(self.Home)
			if self.State == ChaserBrain.State.RETURN then
				self:_setState(ChaserBrain.State.PATROL)
			end
		end)
	end
end

function ChaserBrain:_nextPatrolPoint(): Vector3
	local nodes = self.Config.PatrolNodes
	if #nodes > 0 then
		self._patrolIndex = self._patrolIndex % #nodes + 1
		return nodes[self._patrolIndex].Position
	end
	local angle = math.random() * math.pi * 2
	local r = math.random() * self.Config.WanderRadius
	return self.Home + Vector3.new(math.cos(angle) * r, 0, math.sin(angle) * r)
end

---------------------------------------------------------------- attack

function ChaserBrain:_tryAttack()
	local player = self.Target
	local hrp = player and rootOf(player)
	if not hrp or (hrp.Position - self.Root.Position).Magnitude > self.Config.AttackRange then
		return
	end
	local now = os.clock()
	if now - self._lastAttack < self.Config.AttackCooldown then
		return
	end
	self._lastAttack = now
	local humanoid = (player :: Player).Character:FindFirstChildOfClass("Humanoid") :: Humanoid
	if self.Config.OnAttack then
		self.Config.OnAttack(player :: Player, humanoid)
	else
		humanoid:TakeDamage(self.Config.AttackDamage)
	end
end

---------------------------------------------------------------- main loop

function ChaserBrain:_tick(dt: number)
	local cfg = self.Config
	local S = ChaserBrain.State

	-- Leash: dragged too far from home -> forget everything and go back.
	if (self.Root.Position - self.Home).Magnitude > cfg.LeashDistance and self.State ~= S.RETURN then
		self.Target, self.Perception = nil, 0
		self:_setState(S.RETURN)
		return
	end

	local candidate, seen = self:_scan()
	local now = os.clock()

	if candidate then
		-- Seeing fills the meter quickly; hearing only half as fast.
		self.Perception = math.min(1, self.Perception + cfg.PerceptionRate * dt * (seen and 1 or 0.5))
		self.LastKnown = (rootOf(candidate) :: BasePart).Position
		self.LastSeenAt = now
		if self.Perception >= 1 then
			self.Target = candidate
			if self.State ~= S.CHASE then
				self:_setState(S.CHASE)
			end
		end
	else
		self.Perception = math.max(0, self.Perception - cfg.PerceptionDecay * dt)
	end

	if self.State == S.CHASE then
		if self.Target and not self:_valid(self.Target) then
			self.Target = nil -- died / left / became invalid
		end
		if not self.Target or now - self.LastSeenAt > cfg.MemoryTime then
			self.Target = nil
			self:_setState(S.SEARCH)
		else
			self:_tryAttack()
		end
	end
end

function ChaserBrain:Start()
	if self._running then
		return
	end
	self._running = true
	self.State = "" -- force the enter logic below
	self:_setState(ChaserBrain.State.PATROL)
	self._loop = task.spawn(function()
		local last = os.clock()
		while self._running and self.Humanoid.Health > 0 and self.Model.Parent do
			local now = os.clock()
			self:_tick(now - last)
			last = now
			task.wait(self.Config.TickRate)
		end
		self:Stop()
	end)
end

function ChaserBrain:Stop()
	self._running = false
	self.Follower:Stop()
	if self._moveThread and coroutine.status(self._moveThread) ~= "dead" and coroutine.running() ~= self._moveThread then
		task.cancel(self._moveThread)
	end
end

function ChaserBrain:Destroy()
	self:Stop()
	if self._loop and coroutine.status(self._loop) ~= "dead" and coroutine.running() ~= self._loop then
		task.cancel(self._loop)
	end
	self.Follower:Destroy()
	self.StateChanged:Destroy()
end

return ChaserBrain
