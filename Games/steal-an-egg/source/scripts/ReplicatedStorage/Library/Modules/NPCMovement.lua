-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local SimplePath = require(ReplicatedStorage.Library.Modules.SimplePath)

require(ReplicatedStorage.Library.Modules.Packages.Trove)

local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local Asserts = require(ReplicatedStorage.Library.Asserts)
local wcall = require(ReplicatedStorage.Library.Functions.wcall)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local t = {}

t.__index = t

local Heartbeat = RunService.Heartbeat

local function getRaycastFilterList() --[[ getRaycastFilterList | Line: 74 ]]
	return { workspace.Map.FloorParts }
end

local function getCFrameFromTarget(p1) --[[ getCFrameFromTarget | Line: 80 ]]
	if typeof(p1) == "CFrame" then
		return p1
	end

	if typeof(p1) == "Vector3" then
		return CFrame.new(p1)
	end

	return p1.CFrame
end

local function loadMovementTrack(p1, p2) --[[ loadMovementTrack | Line: 91 | Upvalues: Pipeline (copy) ]]
	if p2 == nil then
		return nil
	end

	local v1 = p1:LoadAnimation(Pipeline:GetAndSerializeAnimation(p2).anim)

	v1.Looped = true

	return v1
end

local function setupMovementAnimations(p1, p2, p3) --[[ setupMovementAnimations | Line: 102 | Upvalues: Pipeline (copy) ]]
	if p2.IdleAnimationId == nil and p2.WalkAnimationId == nil then
		return
	end

	local Animator = p1:FindFirstChildOfClass("Animator")
	local v1

	if Animator then
		v1 = Animator
	else
		local Animator2 = Instance.new("Animator")

		Animator2.Parent = p1
		p3:Add(Animator2)
		v1 = Animator2
	end

	local v2 = v1
	local IdleAnimationId = p2.IdleAnimationId
	local v3

	if IdleAnimationId == nil then
		v3 = nil
	else
		local v4 = v2:LoadAnimation(Pipeline:GetAndSerializeAnimation(IdleAnimationId).anim)

		v4.Looped = true
		v3 = v4
	end

	local v5 = v1
	local WalkAnimationId = p2.WalkAnimationId
	local v6

	if WalkAnimationId == nil then
		v6 = nil
	else
		local v7 = v5:LoadAnimation(Pipeline:GetAndSerializeAnimation(WalkAnimationId).anim)

		v7.Looped = true
		v6 = v7
	end

	local v8 = false

	local function setWalking(p1, p22) --[[ setWalking | Line: 121 | Upvalues: v8 (ref), v3 (copy), v6 (copy), p2 (copy) ]]
		if v8 == p1 and p1 == false then
			return
		end

		v8 = p1

		if p1 then
			if v3 and v3.IsPlaying then
				v3:Stop(0.15)
			end

			if not v6 then
				return
			end

			v6:AdjustSpeed((math.clamp(p22 / 16 * (p2.WalkAnimationSpeedMultiplier or 1), 0.65, 2)))

			if v6.IsPlaying then
				return
			end

			v6:Play(0.15)
		else
			if v6 and v6.IsPlaying then
				v6:Stop(0.15)
			end

			if not v3 or v3.IsPlaying then
				return
			end

			v3:Play(0.15)
		end
	end

	if v3 then
		v3:Play(0.15)
	end

	p3:Add(p1.Running:Connect(function(p1) --[[ Line: 155 | Upvalues: setWalking (copy) ]]
		setWalking(p1 > 0.5, p1)
	end))
	p3:Add(function() --[[ Line: 158 | Upvalues: v3 (copy), v6 (copy) ]]
		if v3 then
			v3:Stop()
			v3:Destroy()
		end

		if not v6 then
			return
		end

		v6:Stop()
		v6:Destroy()
	end)
end

local function stopActivePath(p1) --[[ stopActivePath | Line: 170 | Upvalues: SimplePath (copy) ]]
	if p1._path.Status ~= SimplePath.StatusType.Active then
		return
	end

	p1._path:Stop()
end

local function cleanupPrecisionMove(p1) --[[ cleanupPrecisionMove | Line: 176 ]]
	if not p1._precisionMoveConnection then
		return
	end

	p1._precisionMoveConnection:Disconnect()
	p1._precisionMoveConnection = nil
end

local function rotateTowardsDirection(p1, p2, p3) --[[ rotateTowardsDirection | Line: 183 | Upvalues: Heartbeat (copy) ]]
	if not p1.Parent then
		return false
	end

	local v1 = Vector3.new(p2.X, 0, p2.Z)

	if v1.Magnitude < 0.01 then
		return true
	end

	local Unit = v1.Unit
	local v2 = p1:GetPivot()
	local Position = v2.Position
	local v3 = CFrame.lookAt(Position, Position + Unit)
	local LookVector = v2.LookVector

	if math.acos((math.clamp(Vector3.new(LookVector.X, 0, LookVector.Z).Unit:Dot(Unit), -1, 1))) < 0.08726646259971647 then
		return true
	end

	local sum = 0

	while sum < p3 and p1.Parent do
		sum = sum + Heartbeat:Wait()

		local v6 = math.min(sum / p3, 1)

		p1:PivotTo((v2:Lerp(v3, v6 * v6 * (3 - v6 * 2))))
	end

	p1:PivotTo(v3)

	return true
end

local function applyFinalPositioning(p1, p2) --[[ applyFinalPositioning | Line: 222 | Upvalues: rotateTowardsDirection (copy), v1 (copy), Heartbeat (copy) ]]
	if not p1._model.Parent then
		return false
	end

	local Position = p1._model:GetPivot().Position
	local Position2 = p2.Position
	local v12 = Vector3.new(Position2.X, Position.Y, Position2.Z)

	p1._humanoid:MoveTo(Position)

	local Magnitude = (Position - v12).Magnitude

	if Magnitude <= 0.2 then
		rotateTowardsDirection(p1._model, p2.LookVector, 0.35)

		return true
	end

	if Magnitude <= 2 then
		v1:AtInfo():Log((("[NPCMovement] Close to target (distance: %*), quick adjustment"):format(math.floor(Magnitude * 100) / 100)))
		p1._humanoid:MoveTo(p1._rootPart.Position)
		sum = 0
		v2 = v12

		repeat
			if not (sum < 0.1 and p1._model.Parent) then
				break
			end

			sum = sum + Heartbeat:Wait()
		until (p1._rootPart.Position - v2).Magnitude <= 0.2

		rotateTowardsDirection(p1._model, p2.LookVector, 0.35)
	else
		v1:AtWarning():Log((("[NPCMovement] Far from target (distance: %*), full movement"):format(math.floor(Magnitude * 100) / 100)))
		p1._humanoid:MoveTo(v12)
		sum = 0
		v3 = v12

		repeat
			if not (sum < 2 and p1._model.Parent) then
				break
			end

			sum = sum + Heartbeat:Wait()
		until (p1._rootPart.Position - v3).Magnitude <= 0.2

		p1._humanoid:MoveTo(p1._rootPart.Position)
		rotateTowardsDirection(p1._model, p2.LookVector, 0.175)
		v1:AtInfo():Log("[NPCMovement] Final positioning complete")
	end

	return true
end

local function cleanupMoveToFinished(p1) --[[ cleanupMoveToFinished | Line: 298 ]]
	if not p1._moveToFinishedConnection then
		return
	end

	p1._moveToFinishedConnection:Disconnect()
	p1._moveToFinishedConnection = nil
end

local function directMoveTo(p1, p2) --[[ directMoveTo | Line: 305 | Upvalues: Heartbeat (copy) ]]
	p1._humanoid:MoveTo((Vector3.new(p2.X, p1._rootPart.Position.Y, p2.Z)))

	local v2 = false

	if p1._moveToFinishedConnection then
		p1._moveToFinishedConnection:Disconnect()
		p1._moveToFinishedConnection = nil
	end

	p1._moveToFinishedConnection = p1._humanoid.MoveToFinished:Connect(function(p1) --[[ Line: 314 | Upvalues: v2 (ref) ]]
		v2 = p1
	end)

	local sum = 0

	while not v2 and (p1._model.Parent and (p1._isMoving and sum < 10)) do
		sum = sum + Heartbeat:Wait()
	end

	if not p1._moveToFinishedConnection then
		return v2
	end

	p1._moveToFinishedConnection:Disconnect()
	p1._moveToFinishedConnection = nil

	return v2
end

function t.ensureRobotOnGround(p1) --[[ ensureRobotOnGround | Line: 327 ]]
	local v2 = RaycastParams.new()

	v2.FilterType = Enum.RaycastFilterType.Include
	v2.FilterDescendantsInstances = { workspace.Map.FloorParts }
	v2.IgnoreWater = true

	local v3 = workspace:Raycast(p1.rootPart.Position + Vector3.new(0, 2, 0), Vector3.new(0, -10, 0), v2)

	if not v3 then
		return
	end

	local v5 = v3.Position + Vector3.new(0, p1.humanoid.HipHeight or 0, 0)
	local v6 = p1.model:GetPivot()

	p1.model:PivotTo(CFrame.new(v5) * (v6 - v6.Position))
end
function t.new(p1, p2, p3) --[[ new | Line: 350 | Upvalues: Asserts (copy), v1 (copy), Constants (copy), wcall (copy), SimplePath (copy), setupMovementAnimations (copy), t (copy), applyFinalPositioning (copy) ]]
	Asserts.Model(p1)
	Asserts.table(p2)

	local PrimaryPart = p1.PrimaryPart

	if not PrimaryPart then
		v1:AtError():Log("[NPCMovement] Model missing PrimaryPart")

		return nil
	end

	local Humanoid = p1:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		v1:AtError():Log("[NPCMovement] Model missing Humanoid")

		return nil
	end

	if Constants.IS_SERVER then
		wcall(function() --[[ Line: 367 | Upvalues: PrimaryPart (copy) ]]
			PrimaryPart:SetNetworkOwner(nil)
		end)
	end

	local v2 = SimplePath.new(p1, p2.PathfindingAgentParams or {
		AgentRadius = 2,
		AgentHeight = 5,
		AgentCanJump = false,
		AgentCanClimb = false,
		WaypointSpacing = 4,
		Costs = {
			Water = (1 / 0)
		}
	})

	v2.Visualize = false
	setupMovementAnimations(Humanoid, p2, p3)

	local v3 = Instance.new("BindableEvent")

	p3:Add(function() --[[ Line: 391 | Upvalues: v3 (copy), v2 (copy) ]]
		v3:Destroy()
		v2:Destroy()
	end)

	local v5 = setmetatable({
		_isMoving = false,
		_targetPosition = nil,
		_targetCFrame = nil,
		_currentRequest = nil,
		_precisionMoveConnection = nil,
		_moveToFinishedConnection = nil,
		_initialRotationComplete = false,
		_model = p1,
		_config = p2,
		_trove = p3,
		_path = v2,
		_humanoid = Humanoid,
		_rootPart = PrimaryPart,
		_moveCompleteSignal = v3
	}, t)

	p3:Add(v2.Reached:Connect(function() --[[ Line: 413 | Upvalues: v5 (copy), applyFinalPositioning (ref) ]]
		if v5._isMoving and v5._targetCFrame then
			v5:_onMoveComplete((applyFinalPositioning(v5, v5._targetCFrame)))
		end
	end))
	p3:Add(v2.Blocked:Connect(function() --[[ Line: 422 | Upvalues: v1 (ref), v5 (copy), v2 (copy) ]]
		v1:AtWarning():Log("[NPCMovement] Path blocked, attempting recompute")

		if not (v5._targetPosition and v5._isMoving) then
			return
		end

		task.wait(0.5)

		if not v5._isMoving or (not v5._targetPosition or v2:Run(v5._targetPosition)) then
			return
		end

		v1:AtError():Log("[NPCMovement] Failed to recompute path after block")
		v5:_onMoveComplete(false)
	end))
	p3:Add(v2.Error:Connect(function(p1) --[[ Line: 438 | Upvalues: v1 (ref), v5 (copy), SimplePath (ref), v2 (copy) ]]
		v1:AtError():Log((("[NPCMovement] Path error: %*"):format(p1)))

		if v5._targetPosition and (v5._isMoving and p1 ~= SimplePath.ErrorType.ComputationError) then
			task.wait(0.5)

			if v5._isMoving and (v5._targetPosition and not v2:Run(v5._targetPosition)) then
				v5:_onMoveComplete(false)
			end
		else
			v5:_onMoveComplete(false)
		end
	end))

	return v5
end
function t._onMoveComplete(p1, p2) --[[ _onMoveComplete | Line: 458 | Upvalues: SimplePath (copy) ]]
	if not p1._isMoving then
		return
	end

	p1._isMoving = false
	p1._initialRotationComplete = false

	if p1._path.Status == SimplePath.StatusType.Active then
		p1._path:Stop()
	end

	if p1._moveToFinishedConnection then
		p1._moveToFinishedConnection:Disconnect()
		p1._moveToFinishedConnection = nil
	end

	if p1._precisionMoveConnection then
		p1._precisionMoveConnection:Disconnect()
		p1._precisionMoveConnection = nil
	end

	local _currentRequest = p1._currentRequest

	p1._currentRequest = nil
	p1._targetCFrame = nil
	p1._targetPosition = nil

	if _currentRequest and _currentRequest.callback then
		task.spawn(_currentRequest.callback, p2)
	end

	p1._moveCompleteSignal:Fire(p2)
end
function t.MoveTo(p1, p2, p3) --[[ MoveTo | Line: 481 | Upvalues: v1 (copy), applyFinalPositioning (copy), rotateTowardsDirection (copy), directMoveTo (copy) ]]
	if p1._isMoving then
		v1:AtWarning():Log("[NPCMovement] Already moving, stopping previous")
		p1:Stop()
	end

	local v12 = if typeof(p2) == "CFrame" then p2 elseif typeof(p2) == "Vector3" then CFrame.new(p2) else p2.CFrame
	local Position = v12.Position
	local Magnitude = (p1._rootPart.Position - Position).Magnitude

	if not (Magnitude <= 0.2) then
		p1._isMoving = true
		p1._initialRotationComplete = false
		p1._targetCFrame = v12
		p1._targetPosition = Position
		p1._currentRequest = {
			target = p2,
			callback = p3
		}
		task.spawn(function() --[[ Line: 513 | Upvalues: Position (copy), p1 (copy), v1 (ref), rotateTowardsDirection (ref), Magnitude (copy), directMoveTo (ref), applyFinalPositioning (ref), v12 (copy) ]]
			local v13 = Position - p1._rootPart.Position

			v1:AtInfo():Log("[NPCMovement] Rotating towards target")
			rotateTowardsDirection(p1._model, v13, 0.35)

			if not p1._isMoving then
				return
			end

			p1._initialRotationComplete = true

			if Magnitude <= 5 then
				v1:AtInfo():Log("[NPCMovement] Close target, direct movement")

				local v2 = directMoveTo(p1, Position)

				if v2 then
					applyFinalPositioning(p1, v12)
				end

				p1:_onMoveComplete(v2)
			else
				v1:AtInfo():Log("[NPCMovement] Using pathfinding")

				if p1._path:Run(Position) then
					task.spawn(function() --[[ Line: 554 | Upvalues: p1 (ref) ]]
						repeat
							if not p1._isMoving then
								break
							end

							task.wait(0.5)
						until not p1._isMoving
					end)

					return
				end

				v1:AtError():Log("[NPCMovement] Pathfinding failed")

				if not (Magnitude <= 10) then
					p1:_onMoveComplete(false)

					return
				end

				v1:AtInfo():Log("[NPCMovement] Fallback to direct movement")

				local v3 = directMoveTo(p1, Position)

				if v3 then
					applyFinalPositioning(p1, v12)
				end

				p1:_onMoveComplete(v3)
			end
		end)

		return true
	end

	v1:AtInfo():Log("[NPCMovement] Already at target")
	applyFinalPositioning(p1, v12)

	if not p3 then
		return true
	end

	task.spawn(p3, true)

	return true
end
function t.MoveToAsync(p1, p2) --[[ MoveToAsync | Line: 567 ]]
	local v1 = false
	local v2 = false

	p1:MoveTo(p2, function(p1) --[[ Line: 571 | Upvalues: v1 (ref), v2 (ref) ]]
		v1 = p1
		v2 = true
	end)

	while not v2 and p1._isMoving do
		task.wait(0.1)
	end

	return v1
end
function t.Stop(p1) --[[ Stop | Line: 583 | Upvalues: v1 (copy), SimplePath (copy) ]]
	if not p1._isMoving then
		return
	end

	v1:AtInfo():Log("[NPCMovement] Stopping")
	p1._isMoving = false
	p1._initialRotationComplete = false

	if p1._path.Status == SimplePath.StatusType.Active then
		p1._path:Stop()
	end

	if p1._moveToFinishedConnection then
		p1._moveToFinishedConnection:Disconnect()
		p1._moveToFinishedConnection = nil
	end

	if p1._precisionMoveConnection then
		p1._precisionMoveConnection:Disconnect()
		p1._precisionMoveConnection = nil
	end

	p1._humanoid:MoveTo(p1._rootPart.Position)

	local _currentRequest = p1._currentRequest

	p1._currentRequest = nil
	p1._targetCFrame = nil
	p1._targetPosition = nil

	if not (_currentRequest and _currentRequest.callback) then
		return
	end

	task.spawn(_currentRequest.callback, false)
end
function t.IsMoving(p1) --[[ IsMoving | Line: 608 ]]
	return p1._isMoving
end
function t.GetMoveCompleteSignal(p1) --[[ GetMoveCompleteSignal | Line: 612 ]]
	return p1._moveCompleteSignal.Event
end

return t