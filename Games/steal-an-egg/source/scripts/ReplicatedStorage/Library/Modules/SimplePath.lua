-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	TIME_VARIANCE = 0.07,
	COMPARISON_CHECKS = 1,
	JUMP_WHEN_STUCK = true
}
local PathfindingService = game:GetService("PathfindingService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local v1 = RunService:IsServer()

local function output(p1, p2) --[[ output | Line: 69 ]]
	p1((if p1 == error then "SimplePath Error: " else "SimplePath: ") .. p2)
end

local t2 = {
	StatusType = {
		Idle = "Idle",
		Active = "Active"
	},
	ErrorType = {
		LimitReached = "LimitReached",
		TargetUnreachable = "TargetUnreachable",
		ComputationError = "ComputationError",
		AgentStuck = "AgentStuck"
	}
}

function t2.__index(p1, p2) --[[ Line: 87 | Upvalues: t2 (copy) ]]
	if p2 == "Stopped" and not p1._humanoid then
		local v1 = error

		v1((if v1 == error then "SimplePath Error: " else "SimplePath: ") .. "Attempt to use Path.Stopped on a non-humanoid.")
	end

	return p1._events[p2] and p1._events[p2].Event or (p2 == "LastError" and p1._lastError or (p2 == "Status" and p1._status or t2[p2]))
end

local Part = Instance.new("Part")

Part.Size = Vector3.new(0.3, 0.3, 0.3)
Part.Anchored = true
Part.CanCollide = false
Part.Material = Enum.Material.Neon
Part.Shape = Enum.PartType.Ball

local function declareError(p1, p2) --[[ declareError | Line: 104 ]]
	p1._lastError = p2
	p1._events.Error:Fire(p2)
end

local function createVisualWaypoints(p1) --[[ createVisualWaypoints | Line: 109 | Upvalues: Part (copy) ]]
	local t = {}

	for i, v in ipairs(p1) do
		local v1 = Part:Clone()

		v1.Position = v.Position
		v1.Parent = workspace
		v1.Color = v == p1[#p1] and Color3.fromRGB(0, 255, 0) or (v.Action == Enum.PathWaypointAction.Jump and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 139, 0))
		table.insert(t, v1)
	end

	return t
end

local function destroyVisualWaypoints(p1) --[[ destroyVisualWaypoints | Line: 123 ]]
	if not p1 then
		return
	end

	for i, v in ipairs(p1) do
		v:Destroy()
	end
end

local function getNonHumanoidWaypoint(p1) --[[ getNonHumanoidWaypoint | Line: 132 ]]
	local _waypoints = p1._waypoints

	for i = 2, #_waypoints do
		if (_waypoints[i].Position - _waypoints[i - 1].Position).Magnitude > 0.1 then
			return i
		end
	end

	return 2
end

local function setJumpState(p1) --[[ setJumpState | Line: 142 ]]
	pcall(function() --[[ Line: 143 | Upvalues: p1 (copy) ]]
		local _humanoid = p1._humanoid

		if _humanoid:GetState() == Enum.HumanoidStateType.Jumping or _humanoid:GetState() == Enum.HumanoidStateType.Freefall then
			return
		end

		_humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end)
end

local function move(p1) --[[ move | Line: 154 ]]
	local _waypoints = p1._waypoints
	local _currentWaypoint = p1._currentWaypoint

	if _waypoints[_currentWaypoint].Action == Enum.PathWaypointAction.Jump then
		pcall(function() --[[ Line: 143 | Upvalues: p1 (copy) ]]
			local _humanoid = p1._humanoid

			if _humanoid:GetState() == Enum.HumanoidStateType.Jumping or _humanoid:GetState() == Enum.HumanoidStateType.Freefall then
				return
			end

			_humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end)
	end

	p1._humanoid:MoveTo(_waypoints[_currentWaypoint].Position)
end

local function disconnectMoveConnection(p1) --[[ disconnectMoveConnection | Line: 164 ]]
	p1._moveConnection:Disconnect()
	p1._moveConnection = nil
end

local function invokeWaypointReached(p1) --[[ invokeWaypointReached | Line: 170 ]]
	local _waypoints = p1._waypoints
	local _currentWaypoint = p1._currentWaypoint

	p1._events.WaypointReached:Fire(p1._agent, _waypoints[_currentWaypoint - 1], _waypoints[_currentWaypoint])
end

local function moveToFinished(p1, p2) --[[ moveToFinished | Line: 178 | Upvalues: t2 (copy) ]]
	if not getmetatable(p1) then
		return
	end

	local _waypoints = p1._waypoints
	local _currentWaypoint = p1._currentWaypoint

	if p1._humanoid then
		if p2 and _currentWaypoint + 1 <= #_waypoints then
			if _currentWaypoint + 1 < #_waypoints then
				local _waypoints2 = p1._waypoints
				local _currentWaypoint2 = p1._currentWaypoint

				p1._events.WaypointReached:Fire(p1._agent, _waypoints2[_currentWaypoint2 - 1], _waypoints2[_currentWaypoint2])
			end

			p1._currentWaypoint = _currentWaypoint + 1

			local _waypoints2 = p1._waypoints
			local _currentWaypoint2 = p1._currentWaypoint

			if _waypoints2[_currentWaypoint2].Action == Enum.PathWaypointAction.Jump then
				pcall(function() --[[ Line: 143 | Upvalues: p1 (copy) ]]
					local _humanoid = p1._humanoid

					if _humanoid:GetState() == Enum.HumanoidStateType.Jumping or _humanoid:GetState() == Enum.HumanoidStateType.Freefall then
						return
					end

					_humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end)
			end

			p1._humanoid:MoveTo(_waypoints2[_currentWaypoint2].Position)
		elseif p2 then
			p1._moveConnection:Disconnect()
			p1._moveConnection = nil
			p1._status = t2.StatusType.Idle

			local _visualWaypoints = p1._visualWaypoints

			if _visualWaypoints then
				for i, v in ipairs(_visualWaypoints) do
					v:Destroy()
				end
			end

			p1._visualWaypoints = nil
			p1._events.Reached:Fire(p1._agent, _waypoints[_currentWaypoint])
		else
			p1._moveConnection:Disconnect()
			p1._moveConnection = nil
			p1._status = t2.StatusType.Idle

			local _visualWaypoints = p1._visualWaypoints

			if _visualWaypoints then
				for i, v in ipairs(_visualWaypoints) do
					v:Destroy()
				end
			end

			p1._visualWaypoints = nil

			local TargetUnreachable = p1.ErrorType.TargetUnreachable

			p1._lastError = TargetUnreachable
			p1._events.Error:Fire(TargetUnreachable)
		end
	else
		if p2 and _currentWaypoint + 1 <= #_waypoints then
			local _waypoints2 = p1._waypoints
			local _currentWaypoint2 = p1._currentWaypoint

			p1._events.WaypointReached:Fire(p1._agent, _waypoints2[_currentWaypoint2 - 1], _waypoints2[_currentWaypoint2])
			p1._currentWaypoint = _currentWaypoint + 1

			return
		end

		if p2 then
			local _visualWaypoints = p1._visualWaypoints

			if _visualWaypoints then
				for i, v in ipairs(_visualWaypoints) do
					v:Destroy()
				end
			end

			p1._visualWaypoints = nil
			p1._target = nil
			p1._events.Reached:Fire(p1._agent, _waypoints[_currentWaypoint])
		else
			local _visualWaypoints = p1._visualWaypoints

			if _visualWaypoints then
				for i, v in ipairs(_visualWaypoints) do
					v:Destroy()
				end
			end

			p1._visualWaypoints = nil
			p1._target = nil

			local TargetUnreachable = p1.ErrorType.TargetUnreachable

			p1._lastError = TargetUnreachable
			p1._events.Error:Fire(TargetUnreachable)
		end
	end
end

local function comparePosition(p1) --[[ comparePosition | Line: 221 ]]
	if p1._currentWaypoint == #p1._waypoints then
		return
	end

	local PrimaryPart = p1._agent.PrimaryPart

	p1._position._count = (PrimaryPart.Position - p1._position._last).Magnitude <= 0.07 and p1._position._count + 1 or 0
	p1._position._last = PrimaryPart.Position

	if not (p1._position._count >= p1._settings.COMPARISON_CHECKS) then
		return
	end

	if p1._settings.JUMP_WHEN_STUCK then
		pcall(function() --[[ Line: 143 | Upvalues: p1 (copy) ]]
			local _humanoid = p1._humanoid

			if _humanoid:GetState() == Enum.HumanoidStateType.Jumping or _humanoid:GetState() == Enum.HumanoidStateType.Freefall then
				return
			end

			_humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end)
	end

	local AgentStuck = p1.ErrorType.AgentStuck

	p1._lastError = AgentStuck
	p1._events.Error:Fire(AgentStuck)
end

function t2.GetNearestCharacter(p1) --[[ GetNearestCharacter | Line: 241 | Upvalues: Players (copy) ]]
	local v1 = (1 / 0)
	local v2 = nil

	for i, v in ipairs(Players:GetPlayers()) do
		if v.Character and v.Character.PrimaryPart then
			local Magnitude = (v.Character.PrimaryPart.Position - p1).Magnitude

			if Magnitude < v1 then
				v2 = v.Character
				v1 = Magnitude
			end
		end
	end

	return v2
end
function t2.new(p1, p2, p3) --[[ new | Line: 254 | Upvalues: t (copy), PathfindingService (copy), t2 (copy), RunService (copy) ]]
	if not (p1 and (p1:IsA("Model") and p1.PrimaryPart)) then
		local v1 = error

		v1((if v1 == error then "SimplePath Error: " else "SimplePath: ") .. "Pathfinding agent must be a valid Model Instance with a set PrimaryPart.")
	end

	local t3 = {
		_status = "Idle",
		_t = 0,
		_waypoints = nil,
		_currentWaypoint = nil,
		_target = nil,
		_visualWaypoints = nil,
		_moveConnection = nil,
		_lastError = nil
	}

	t3._settings = if p3 then p3 else t
	t3._events = {
		Reached = Instance.new("BindableEvent"),
		WaypointReached = Instance.new("BindableEvent"),
		Blocked = Instance.new("BindableEvent"),
		Error = Instance.new("BindableEvent"),
		Stopped = Instance.new("BindableEvent")
	}
	t3._agent = p1
	t3._humanoid = p1:FindFirstChildOfClass("Humanoid")
	t3._path = PathfindingService:CreatePath(p2)
	t3._position = {
		_count = 0,
		_last = Vector3.new()
	}
	t3.StatusType = t2.StatusType
	t3.ErrorType = t2.ErrorType
	t3.Visualize = RunService:IsStudio()

	local v5 = setmetatable(t3, t2)

	for k, v in pairs(t) do
		v5._settings[k] = if v5._settings[k] == nil and v then v else v5._settings[k]
	end

	v5._path.Blocked:Connect(function(p1) --[[ Line: 293 | Upvalues: v5 (copy) ]]
		local _currentWaypoint = v5._currentWaypoint

		if not (_currentWaypoint and (_currentWaypoint <= p1 and (p1 <= _currentWaypoint + 1 and v5._humanoid))) then
			return
		end

		local v1 = v5

		pcall(function() --[[ Line: 143 | Upvalues: v1 (copy) ]]
			local _humanoid = v1._humanoid

			if _humanoid:GetState() == Enum.HumanoidStateType.Jumping or _humanoid:GetState() == Enum.HumanoidStateType.Freefall then
				return
			end

			_humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end)

		local _waypoints = v5._waypoints

		if not _waypoints then
			return
		end

		v5._events.Blocked:Fire(v5._agent, _waypoints[p1])
	end)

	return v5
end
function t2.Destroy(p1) --[[ Destroy | Line: 311 ]]
	for k, v in pairs(p1._events) do
		v:Destroy()
	end

	if p1._visualWaypoints then
		local _visualWaypoints = p1._visualWaypoints

		if _visualWaypoints then
			for i, v in ipairs(_visualWaypoints) do
				v:Destroy()
			end
		end

		p1._visualWaypoints = nil
	end

	p1._path:Destroy()
	setmetatable(p1, nil)

	for k, v in pairs(p1) do
		p1[k] = nil
	end
end
function t2.Stop(p1) --[[ Stop | Line: 325 | Upvalues: t2 (copy) ]]
	if p1._humanoid then
		if p1._status == t2.StatusType.Idle then
			return
		end

		p1._moveConnection:Disconnect()
		p1._moveConnection = nil
		p1._status = t2.StatusType.Idle

		local _visualWaypoints = p1._visualWaypoints

		if _visualWaypoints then
			for i, v in ipairs(_visualWaypoints) do
				v:Destroy()
			end
		end

		p1._visualWaypoints = nil
		p1._events.Stopped:Fire(p1._agent)
	else
		local v1 = error

		v1((if v1 == error then "SimplePath Error: " else "SimplePath: ") .. "Attempt to call Path:Stop() on a non-humanoid.")
	end
end
function t2.Run(p1, p2) --[[ Run | Line: 342 | Upvalues: moveToFinished (copy), t2 (copy), v1 (copy), comparePosition (copy), getNonHumanoidWaypoint (copy) ]]
	if not p2 and (not p1._humanoid and p1._target) then
		moveToFinished(p1, true)

		return true
	end

	if not p2 or typeof(p2) ~= "Vector3" and not p2:IsA("BasePart") then
		local v12 = error

		v12((if v12 == error then "SimplePath Error: " else "SimplePath: ") .. "Pathfinding target must be a valid Vector3 or BasePart.")
	end

	if os.clock() - p1._t <= p1._settings.TIME_VARIANCE and p1._humanoid then
		task.wait(os.clock() - p1._t)

		local LimitReached = p1.ErrorType.LimitReached

		p1._lastError = LimitReached
		p1._events.Error:Fire(LimitReached)

		return false
	end

	if p1._humanoid then
		p1._t = os.clock()
	end

	if pcall(function() --[[ Line: 360 | Upvalues: p1 (copy), p2 (copy) ]]
		p1._path:ComputeAsync(p1._agent.PrimaryPart.Position, if typeof(p2) == "Vector3" then p2 else p2.Position)
	end) and (p1._path and (p1._path.Status ~= Enum.PathStatus.NoPath and not (#p1._path:GetWaypoints() < 2))) then
		p1._status = if p1._humanoid then t2.StatusType.Active else t2.StatusType.Idle
		p1._target = p2

		if v1 then
			local ok, result = pcall(function() --[[ Line: 386 | Upvalues: p1 (copy) ]]
				p1._agent.PrimaryPart:SetNetworkOwner(nil)
			end)

			if not ok then
				warn((("failed to set network owner: %*"):format(result)))
			end
		end

		p1._waypoints = p1._path:GetWaypoints()
		p1._currentWaypoint = 2

		if p1._humanoid then
			comparePosition(p1)
		end

		local _visualWaypoints = p1._visualWaypoints

		if _visualWaypoints then
			for i, v in ipairs(_visualWaypoints) do
				v:Destroy()
			end
		end

		if p1.Visualize then
			local _waypoints = p1._waypoints
		end

		if p1._humanoid then
			p1._moveConnection = p1._moveConnection or p1._humanoid.MoveToFinished:Connect(function(p12) --[[ Line: 411 | Upvalues: moveToFinished (ref), p1 (copy) ]]
				moveToFinished(p1, p12)
			end)
		end

		if p1._humanoid then
			p1._humanoid:MoveTo(p1._waypoints[p1._currentWaypoint].Position)
		else
			local _waypoints = p1._waypoints

			if #_waypoints == 2 then
				p1._target = nil

				local _visualWaypoints2 = p1._visualWaypoints

				if _visualWaypoints2 then
					for i, v in ipairs(_visualWaypoints2) do
						v:Destroy()
					end
				end

				p1._visualWaypoints = nil
				p1._events.Reached:Fire(p1._agent, _waypoints[2])
			else
				p1._currentWaypoint = getNonHumanoidWaypoint(p1)
				moveToFinished(p1, true)
			end
		end

		return true
	end

	warn("no path:", if p1._path then p1._path.Status else "PathNil", if p1._path then #p1._path:GetWaypoints() else 0)

	local _visualWaypoints = p1._visualWaypoints

	if _visualWaypoints then
		for i, v in ipairs(_visualWaypoints) do
			v:Destroy()
		end
	end

	p1._visualWaypoints = nil
	task.wait()

	local ComputationError = p1.ErrorType.ComputationError

	p1._lastError = ComputationError
	p1._events.Error:Fire(ComputationError)

	return false
end

return t2