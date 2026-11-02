-- PathFollower (pattern module, written for this library)
-- What it does: moves a Humanoid NPC along a PathfindingService path, one waypoint at a time,
-- with per-waypoint timeouts, stuck detection, jump waypoints, Blocked re-pathing and a chase()
-- helper that re-paths on a timer or when the target has moved far enough.
--
-- Credit / ideas taken from:
--   steal-a-brainrot-sab-files  NpcPathfinding  (re-path interval + "target moved" threshold)
--   scp-tycoon                  Enemy AI        (path.Blocked -> recompute only if block is ahead)
--   animal-hospital-horror      PatientService  (MoveTo with a short timeout instead of the 8 s default)
--   gore-game                   Peds/Core       (stuck detection: give up when speed stays ~0)
--
-- Usage (server Script):
--   local PathFollower = require(path.to.PathFollower)
--   local follower = PathFollower.new(npcModel, { AgentRadius = 2, AgentHeight = 5, AgentCanJump = true })
--   follower:MoveTo(Vector3.new(0, 0, 50))            -- yields; returns true when the goal is reached
--   follower:Chase(function()                          -- yields until caught, lost or stopped
--       local hrp = targetCharacter:FindFirstChild("HumanoidRootPart")
--       return hrp and hrp.Position
--   end, { StopDistance = 4, MaxTime = 20 })
--   follower:Stop()                                    -- cancels whatever is running
--   follower:Destroy()

local PathfindingService = game:GetService("PathfindingService")

local PathFollower = {}
PathFollower.__index = PathFollower

export type ChaseOptions = {
	StopDistance: number?,      -- return true when this close to the target (default 4)
	MaxTime: number?,           -- give up after this many seconds (default 30)
	RepathInterval: number?,    -- recompute at least this often (default 0.5)
	RepathMoveThreshold: number?, -- recompute if the target moved this far since last path (default 6)
	DirectDistance: number?,    -- closer than this and visible -> walk straight at the target (default 12)
}

local DEFAULT_AGENT = {
	AgentRadius = 2,
	AgentHeight = 5,
	AgentCanJump = true,
	WaypointSpacing = 4,
}

function PathFollower.new(model: Model, agentParams: { [string]: any }?)
	local humanoid = model:FindFirstChildOfClass("Humanoid")
	local root = model:FindFirstChild("HumanoidRootPart") :: BasePart?
	assert(humanoid and root, "PathFollower needs a Humanoid and a HumanoidRootPart")

	local self = setmetatable({}, PathFollower)
	self.Model = model
	self.Humanoid = humanoid :: Humanoid
	self.Root = root :: BasePart
	self.Path = PathfindingService:CreatePath(agentParams or DEFAULT_AGENT)
	self.WaypointTimeout = 2.5   -- seconds allowed per waypoint
	self.StuckTime = 1.5         -- seconds of ~zero speed before we count as stuck
	self._runId = 0              -- bumping this cancels the current run
	self._waypoints = nil :: { PathWaypoint }?
	self._index = 0

	-- Server owns the physics so the NPC does not stutter when a player walks near it.
	pcall(function()
		(self.Root :: BasePart):SetNetworkOwner(nil)
	end)

	self._blockedConn = self.Path.Blocked:Connect(function(blockedIndex: number)
		-- Only care if the obstacle is still ahead of us.
		if self._waypoints and blockedIndex >= self._index then
			self._blocked = true
		end
	end)
	return self
end

-- Compute a path; returns the waypoint list or nil.
function PathFollower:Compute(goal: Vector3): { PathWaypoint }?
	local ok = pcall(function()
		self.Path:ComputeAsync(self.Root.Position, goal)
	end)
	if not ok or self.Path.Status ~= Enum.PathStatus.Success then
		return nil
	end
	return self.Path:GetWaypoints()
end

-- Walk to one point with a timeout. Returns true if MoveToFinished fired with reached = true.
local function stepTo(self, position: Vector3, runId: number): boolean
	local humanoid: Humanoid = self.Humanoid
	local reached: boolean? = nil
	local conn = humanoid.MoveToFinished:Connect(function(r)
		reached = r
	end)
	humanoid:MoveTo(position)

	local started = os.clock()
	local lastMoving = os.clock()
	while reached == nil do
		task.wait(0.05)
		if self._runId ~= runId or self._blocked then
			break
		end
		local now = os.clock()
		local flatSpeed = Vector3.new(self.Root.AssemblyLinearVelocity.X, 0, self.Root.AssemblyLinearVelocity.Z).Magnitude
		if flatSpeed > 0.5 then
			lastMoving = now
		end
		if now - started > self.WaypointTimeout or now - lastMoving > self.StuckTime then
			break
		end
	end
	conn:Disconnect()
	return reached == true
end

-- Follow a computed path. Yields. Returns true if the final waypoint was reached.
function PathFollower:MoveTo(goal: Vector3): boolean
	self._runId += 1
	local runId = self._runId
	self._blocked = false

	local waypoints = self:Compute(goal)
	if not waypoints then
		return false
	end
	self._waypoints = waypoints

	for i = 2, #waypoints do -- waypoint 1 is where we already stand
		if self._runId ~= runId then
			return false
		end
		self._index = i
		local wp = waypoints[i]
		if wp.Action == Enum.PathWaypointAction.Jump then
			self.Humanoid.Jump = true
		end
		if not stepTo(self, wp.Position, runId) then
			if self._blocked and self._runId == runId then
				return self:MoveTo(goal) -- re-path around the new obstacle
			end
			return false
		end
	end
	self._waypoints = nil
	return true
end

-- Simple line-of-sight check from the NPC's root to a point.
function PathFollower:CanSee(position: Vector3, ignore: { Instance }?): boolean
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	local list: { Instance } = { self.Model }
	for _, inst in ipairs(ignore or {}) do
		table.insert(list, inst)
	end
	params.FilterDescendantsInstances = list
	local origin = self.Root.Position
	return workspace:Raycast(origin, position - origin, params) == nil
end

-- Chase a moving target. getTargetPosition returns a Vector3 or nil (nil = target lost).
-- Yields. Returns true when within StopDistance, false when lost / timed out / stopped.
function PathFollower:Chase(getTargetPosition: () -> Vector3?, opts: ChaseOptions?): boolean
	local o: ChaseOptions = opts or {}
	local stopDistance = o.StopDistance or 4
	local maxTime = o.MaxTime or 30
	local repathInterval = o.RepathInterval or 0.5
	local moveThreshold = o.RepathMoveThreshold or 6
	local directDistance = o.DirectDistance or 12

	self._runId += 1
	local runId = self._runId
	local started = os.clock()
	local lastPathAt = -math.huge
	local lastGoal: Vector3? = nil
	local waypoints: { PathWaypoint }? = nil
	local index = 2

	while self._runId == runId do
		if os.clock() - started > maxTime then
			return false
		end
		local target = getTargetPosition()
		if not target then
			return false
		end
		local distance = (target - self.Root.Position).Magnitude
		if distance <= stopDistance then
			self.Humanoid:MoveTo(self.Root.Position)
			return true
		end

		-- Close and visible: skip pathfinding entirely (this is what most of the games do).
		if distance <= directDistance and self:CanSee(target) then
			waypoints = nil
			self.Humanoid:MoveTo(target)
			task.wait(0.1)
			continue
		end

		local now = os.clock()
		local needPath = waypoints == nil
			or index > #(waypoints :: { PathWaypoint })
			or now - lastPathAt >= repathInterval
			or (lastGoal ~= nil and (target - (lastGoal :: Vector3)).Magnitude >= moveThreshold)
		if needPath then
			waypoints = self:Compute(target)
			lastPathAt = now
			lastGoal = target
			index = 2
			if not waypoints then
				self.Humanoid:MoveTo(target) -- fall back to a straight line
				task.wait(0.2)
				continue
			end
		end

		local list = waypoints :: { PathWaypoint }
		local wp = list[index]
		if wp then
			if wp.Action == Enum.PathWaypointAction.Jump then
				self.Humanoid.Jump = true
			end
			self.Humanoid:MoveTo(wp.Position)
			-- advance when close enough (do not wait for MoveToFinished; the path is refreshed often)
			local flat = Vector3.new(wp.Position.X - self.Root.Position.X, 0, wp.Position.Z - self.Root.Position.Z)
			if flat.Magnitude < 3 then
				index += 1
			end
		end
		task.wait(0.1)
	end
	return false
end

function PathFollower:Stop()
	self._runId += 1
	self._waypoints = nil
	if self.Humanoid.Parent then
		self.Humanoid:MoveTo(self.Root.Position)
	end
end

function PathFollower:Destroy()
	self:Stop()
	if self._blockedConn then
		self._blockedConn:Disconnect()
	end
	self.Path:Destroy()
end

return PathFollower
