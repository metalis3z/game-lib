-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Directory.Guards.Types.Interface)

local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Player = require(ReplicatedStorage.Library.Player)
local WaitFor = require(ReplicatedStorage.Library.Modules.Packages.WaitFor)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local GuardDistance = require(script.Parent.GuardDistance)
local GuardChasePolicy = require(script.Parent.GuardChasePolicy)
local GuardEggRetrievalComponent = require(script.Parent.GuardEggRetrievalComponent)
local GuardMovementRecovery = require(script.Parent.GuardMovementRecovery)
local GuardPresentationComponent = require(script.Parent.GuardPresentationComponent)
local GuardReturnHomeDistanceResolver = require(script.Parent.GuardReturnHomeDistanceResolver)

require(script.Parent.Types.Interface)

local CollisionGroups = require(ReplicatedStorage.Library.Types.CollisionGroups)
local t = {}

t.__index = t
t.__class = "GuardComponent"
t.ATTACK_MIN_INTERVAL = 0.75

local ATTACK_MIN_INTERVAL = t.ATTACK_MIN_INTERVAL
local v1 = Log.new()

function t.new(p1, p2, p3, p4, p5, p6, p7) --[[ new | Line: 84 | Upvalues: t (copy), Asserts (copy), WaitFor (copy), Constants (copy), CollisionGroups (copy), GuardEggRetrievalComponent (copy), GuardMovementRecovery (copy), GuardPresentationComponent (copy) ]]
	local v2 = setmetatable({}, t)

	Asserts.string(p1)
	Asserts.Model(p2)
	Asserts.BasePart(p3)
	Asserts.BasePart(p4)
	Asserts.table(p5)
	Asserts.func(p6)
	Asserts.table(p7)
	Asserts.func(p7.Attack)
	Asserts.boolean(p7.ServerOwnsPhysics)
	Asserts.func(p7.Wake)

	local v3, v4 = WaitFor.Descendant(p2, "Humanoid", Constants.STUDIO_YIELD_TIMEOUT):await()
	local v5, v6 = WaitFor.Descendant(p2, "Animator", Constants.STUDIO_YIELD_TIMEOUT):await()
	local HumanoidRootPart = p2:WaitForChild("HumanoidRootPart", Constants.STUDIO_YIELD_TIMEOUT)
	local Collider = p2:WaitForChild("Collider", Constants.STUDIO_YIELD_TIMEOUT)
	local v7, v8 = WaitFor.Descendant(p2, "Head", Constants.STUDIO_YIELD_TIMEOUT):await()

	assert(v3, (("Failed to resolve Humanoid under %*: %*"):format(p2:GetFullName(), (tostring(v4)))))
	assert(v5, (("Failed to resolve Animator under %*: %*"):format(p2:GetFullName(), (tostring(v6)))))
	assert(HumanoidRootPart, (("Failed to resolve HumanoidRootPart under %*: %*"):format(p2:GetFullName(), (tostring(HumanoidRootPart)))))
	assert(Collider, (("Failed to resolve Collider under %*"):format((p2:GetFullName()))))
	assert(v7, (("Failed to resolve Head under %*: %*"):format(p2:GetFullName(), (tostring(v8)))))
	assert(v4:IsA("Humanoid"), (("%*.Humanoid must be a Humanoid"):format((p2:GetFullName()))))
	assert(v6:IsA("Animator"), (("%*.Animator must be an Animator"):format((p2:GetFullName()))))
	assert(HumanoidRootPart:IsA("BasePart"), (("%*.HumanoidRootPart must be a BasePart"):format((p2:GetFullName()))))
	assert(Collider:IsA("BasePart"), (("%*.Collider must be a BasePart"):format((p2:GetFullName()))))

	if Constants.IS_STUDIO and (v6.Parent == v4 and not p2:FindFirstChild("Model")) then
		error((("Animator has to be parented to the animation controller for %*"):format((p2:GetFullName()))))
	end

	local CurrentPhysicalProperties = Collider.CurrentPhysicalProperties

	Collider.CustomPhysicalProperties = PhysicalProperties.new(0.01, CurrentPhysicalProperties.Friction, CurrentPhysicalProperties.Elasticity, CurrentPhysicalProperties.FrictionWeight, CurrentPhysicalProperties.ElasticityWeight)

	for v22, v23 in p2:GetDescendants() do
		if v23:IsA("BasePart") then
			v23.Anchored = false
			v23.CollisionGroup = CollisionGroups.GUARD_COLLISION_GROUP
		end
	end

	v2._areaId = p1
	v2._attackHandler = p7.Attack
	v2._bounds = p3
	v2._config = p5
	v2._eggRetrieval = GuardEggRetrievalComponent.new(p2, HumanoidRootPart, HumanoidRootPart.CFrame)
	v2._currentMoveTo = nil
	v2._guardModel = p2
	v2._homeCFrame = HumanoidRootPart.CFrame
	v2._humanoid = v4
	v2._lastAttackTime = 0
	v2._lastNetworkOwnerRetry = (-1 / 0)
	v2._lastTargetRefresh = 0
	v2._movementRecovery = GuardMovementRecovery.new(HumanoidRootPart, p4)
	v2._attackResumeTime = 0
	v2._ragdollEndTime = 0
	v2._presentation = GuardPresentationComponent.new(HumanoidRootPart, v6, p5)
	v2._root = HumanoidRootPart
	v2._serverOwnsPhysics = p7.ServerOwnsPhysics
	v2._sleepTurnConnection = nil
	v2._sleepTurnFromCFrame = nil
	v2._sleepTurnStartTime = 0
	v2._state = "Sleeping"
	v2._stolenEggUidByPlayer = {}
	v2._stolenPlayerByEggUid = {}
	v2._targetPlayer = nil
	v2._targetResolver = p6
	v2._wakeHandler = p7.Wake
	v2._wakingStartedAt = 0
	v2._walkResumeTime = 0
	p2:SetAttribute("TargetPlayer", "")
	p2:SetAttribute("Sleeping", false)
	p2:SetAttribute("GuardState", "")
	p2:SetAttribute("AreaId", p1)
	p2:SetAttribute("WakeTargetPlayer", "")
	v4.WalkSpeed = p5.WalkSpeed
	v4:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
	v2:_trySetNetworkOwner(os.clock(), true)
	v2:_enterSleepState()

	return v2
end
function t._setState(p1, p2) --[[ _setState | Line: 203 ]]
	p1._state = p2

	if p2 == "Chasing" then
		return
	end

	p1._presentation:CancelAfterWake()
end
function t._isHitPaused(p1, p2) --[[ _isHitPaused | Line: 210 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)

	return p2 < math.max(p1._walkResumeTime, p1._attackResumeTime)
end
function t._enterSleepState(p1) --[[ _enterSleepState | Line: 216 ]]
	p1:_setState("Sleeping")
	p1._targetPlayer = nil
	p1._currentMoveTo = nil
	p1._movementRecovery:Reset()
	p1:_cancelSleepTurn()
	p1._wakingStartedAt = 0
	p1._root.Anchored = false
	p1._root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
	p1._root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
	p1._guardModel:PivotTo(p1._homeCFrame)
	p1._root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
	p1._root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
	p1._humanoid.WalkSpeed = 0
	p1._humanoid:Move(Vector3.new(0, 0, 0), false)
	p1._guardModel:SetAttribute("Sleeping", true)
	p1._guardModel:SetAttribute("TargetPlayer", "")
	p1._guardModel:SetAttribute("WakeTargetPlayer", "")
	p1._guardModel:SetAttribute("GuardState", p1._state)
	p1._presentation:StopWalkAnimation()
	p1._presentation:StopIdleAnimation()
	p1._presentation:StopFootstepSound()
	p1._presentation:PlaySleep(0.75)
end
function t._enterWakingState(p1, p2) --[[ _enterWakingState | Line: 241 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)

	if p1._state ~= "Waking" then
		p1:_cancelSleepTurn()
		p1:_setTarget(nil)
		p1:_setState("Waking")
		p1._currentMoveTo = nil
		p1._movementRecovery:Reset()
		p1._wakingStartedAt = p2
		p1._guardModel:SetAttribute("TargetPlayer", "")
		p1._guardModel:SetAttribute("GuardState", p1._state)
		p1:_refreshWakeTarget()
	end
end
function t._updateWaking(p1, p2) --[[ _updateWaking | Line: 259 | Upvalues: Asserts (copy), GuardChasePolicy (copy) ]]
	Asserts.number(p2)

	if not (p1:HasStolenEggs() or p1._eggRetrieval:HasPending()) then
		p1:_enterSleepState()

		return
	end

	p1:_refreshWakeTarget()

	if p2 - p1._wakingStartedAt < GuardChasePolicy.GetWakingDuration() then
		return
	end

	if p1._eggRetrieval:HasPending() then
		p1:_enterEggRetrievalState(p2)
	else
		p1:_enterChaseState(p2)
		p1:_updateChase(p2)
	end
end
function t._getChaseWalkSpeed(p1, p2) --[[ _getChaseWalkSpeed | Line: 281 | Upvalues: Asserts (copy), GuardChasePolicy (copy) ]]
	Asserts.number(p2)

	return GuardChasePolicy.ResolveWalkSpeed(p1._config.WalkSpeed, p1._config.FlatRadius, p2)
end
function t._getReturnWalkSpeed(p1) --[[ _getReturnWalkSpeed | Line: 287 ]]
	return p1._config.WalkSpeed * 1.5
end
function t._enterChaseState(p1, p2) --[[ _enterChaseState | Line: 291 ]]
	local v1 = if p1._state == "Waking" then true else false

	p1:_cancelSleepTurn()

	if p1._state ~= "Chasing" then
		p1._wakingStartedAt = 0
		p1._root.Anchored = false
		p1:_trySetNetworkOwner(p2, true)
		p1._humanoid.WalkSpeed = p1._config.WalkSpeed
		p1._guardModel:SetAttribute("Sleeping", false)
		p1._guardModel:SetAttribute("GuardState", "Chasing")
		p1._guardModel:SetAttribute("WakeTargetPlayer", "")
		p1._presentation:StopSleep(0.4)
		p1._wakeHandler(p1._guardModel)
	end

	p1:_setState("Chasing")

	if v1 then
		p1._presentation:ScheduleAfterWake(p2)
	end

	if not (p1._walkResumeTime < p2) then
		return
	end

	p1._walkResumeTime = p2
end
function t._enterEggRetrievalState(p1, p2) --[[ _enterEggRetrievalState | Line: 316 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)

	local is_state = p1._state == "Waking"

	p1:_cancelSleepTurn()
	p1:_setTarget(nil)
	p1:_setState("RetrievingEgg")
	p1._wakingStartedAt = 0
	p1._root.Anchored = false
	p1:_trySetNetworkOwner(p2, true)
	p1._guardModel:SetAttribute("Sleeping", false)
	p1._guardModel:SetAttribute("GuardState", p1._state)
	p1._guardModel:SetAttribute("WakeTargetPlayer", "")

	if not is_state then
		return
	end

	p1._presentation:StopSleep(0.4)
	p1._wakeHandler(p1._guardModel)
end
function t._updateEggRetrieval(p1, p2) --[[ _updateEggRetrieval | Line: 334 | Upvalues: Asserts (copy), GuardChasePolicy (copy) ]]
	Asserts.number(p2)

	if p1._eggRetrieval:HasPending() then
		if p1:_isHitPaused(p2) then
			p1._humanoid.WalkSpeed = 0
			p1:_stopMovement()
			p1._presentation:StopWalkAnimation()
			p1._presentation:EnsureIdleAnimation()
			p1._presentation:StopFootstepSound()

			return nil
		end

		local v1 = p1._eggRetrieval:GetCurrentEggUid()
		local v3 = p1._eggRetrieval:TryTransition(p1._config.EggPickupDistance or GuardChasePolicy.ResolveHitDistance(p1._config.HitDistance))

		if v3 == nil then
			local v4 = p1._eggRetrieval:GetMoveTarget()

			assert(if v4 == nil then false else true, "Pending guard retrieval requires a movement target")
			p1._humanoid.WalkSpeed = p1:_getReturnWalkSpeed()
			p1:_ensureWalkAnimation(p2)
			p1:_moveTo(v4)

			return nil
		end

		assert(v1 ~= nil, "Guard retrieval transition requires an egg UID")

		local t = {
			AreaId = p1._areaId,
			EggUid = v1,
			Kind = v3
		}

		if v3 == "Deposited" then
			if p1._eggRetrieval:HasPending() then
				p1:_enterEggRetrievalState(p2)

				return t
			end

			if p1:HasStolenEggs() then
				p1:_enterChaseState(p2)
				p1:_updateChase(p2)
			else
				p1:_enterReturnHomeState(p2)
			end
		else
			local v7 = p1._eggRetrieval:GetMoveTarget()

			assert(if v7 == nil then false else true, "Attached guard retrieval egg requires a home movement target")
			p1._humanoid.WalkSpeed = p1:_getReturnWalkSpeed()
			p1:_ensureWalkAnimation(p2)
			p1:_moveTo(v7)
		end

		return t
	end

	if p1:HasStolenEggs() then
		p1:_enterChaseState(p2)
		p1:_updateChase(p2)
	else
		p1:_enterReturnHomeState(p2)
	end

	return nil
end
function t._enterReturnHomeState(p1, p2) --[[ _enterReturnHomeState | Line: 394 ]]
	if p1._eggRetrieval:HasPending() then
		p1:_enterEggRetrievalState(p2)

		return
	end

	p1:_setState("ReturningHome")
	p1._guardModel:SetAttribute("GuardState", "ReturningHome")
	p1:_setTarget(nil)
	p1:_cancelSleepTurn()
	p1._root.Anchored = false

	if p1:_isHitPaused(p2) then
		p1._humanoid.WalkSpeed = 0
		p1:_stopMovement()
		p1._presentation:StopWalkAnimation()
		p1._presentation:EnsureIdleAnimation()
		p1._presentation:StopFootstepSound()
	else
		p1._humanoid.WalkSpeed = p1:_getReturnWalkSpeed()
		p1:_moveTo(p1._homeCFrame.Position)
	end
end
function t._updateChase(p1, p2) --[[ _updateChase | Line: 417 | Upvalues: GuardDistance (copy), GuardChasePolicy (copy) ]]
	if p1._eggRetrieval:HasPending() then
		p1:_enterEggRetrievalState(p2)

		return
	end

	if not p1:HasStolenEggs() then
		p1:_enterReturnHomeState(p2)

		return
	end

	local _targetPlayer = p1._targetPlayer
	local v1, v2, v3

	if _targetPlayer == nil or p1._stolenEggUidByPlayer[_targetPlayer] == nil then
		v1 = nil
		v2 = nil
		v3 = nil
	else
		local v4, v5 = p1:_resolvePlayerTarget(_targetPlayer)

		v3 = p1._stolenEggUidByPlayer[_targetPlayer]
		v1 = v4
		v2 = v5
	end

	if v1 == nil or (v2 == nil or p2 - p1._lastTargetRefresh >= 0.3) then
		local v6, v7, v8, v9 = p1:_chooseClosestPlayer()

		p1._lastTargetRefresh = p2
		_targetPlayer = v6
		v1 = v7
		v2 = v8
		v3 = v9
	end

	if _targetPlayer == nil or (v1 == nil or v2 == nil) then
		p1:_setTarget(nil)
		p1:_enterReturnHomeState(p2)

		return
	end

	p1:_setTarget(_targetPlayer)

	if GuardDistance.XZ(p1._root.Position, v1.Position) <= GuardChasePolicy.ResolveHitDistance(p1._config.HitDistance) then
		p1:_attemptAttack(_targetPlayer, v1, v2, v3, p2)
	else
		p1._humanoid.WalkSpeed = p1:_getChaseWalkSpeed(GuardDistance.XZ(p1._root.Position, v1.Position))
		p1:_ensureWalkAnimation(p2)
		p1:_moveThrough(v1.Position)
	end
end
function t._updateReturnHome(p1, p2) --[[ _updateReturnHome | Line: 461 | Upvalues: GuardReturnHomeDistanceResolver (copy) ]]
	if p1._eggRetrieval:HasPending() then
		p1:_enterEggRetrievalState(p2)

		return
	end

	if p1:HasStolenEggs() then
		p1:_enterChaseState(p2)

		return
	end

	if p1._sleepTurnConnection ~= nil then
		return
	end

	if p1:_updateSleepTurn(p2) then
		return
	end

	if (p1._root.Position - p1._homeCFrame.Position).Magnitude <= GuardReturnHomeDistanceResolver.Resolve(p1._areaId) then
		p1:_beginSleepTurn(p2)

		return
	end

	if p1:_isHitPaused(p2) then
		p1._humanoid.WalkSpeed = 0
		p1:_stopMovement()
		p1._presentation:StopWalkAnimation()
		p1._presentation:EnsureIdleAnimation()
		p1._presentation:StopFootstepSound()
	else
		p1._humanoid.WalkSpeed = p1:_getReturnWalkSpeed()
		p1:_ensureWalkAnimation(p2)
		p1:_moveTo(p1._homeCFrame.Position)
	end
end
function t._beginSleepTurn(p1, p2) --[[ _beginSleepTurn | Line: 498 | Upvalues: Asserts (copy), RunService (copy) ]]
	Asserts.number(p2)
	p1._sleepTurnFromCFrame = p1._root.CFrame
	p1._sleepTurnStartTime = p2

	if p1._sleepTurnConnection == nil then
		p1._sleepTurnConnection = RunService.Heartbeat:Connect(function() --[[ Line: 504 | Upvalues: p1 (copy) ]]
			p1:_updateSleepTurn(os.clock())
		end)
	end

	p1._humanoid.WalkSpeed = 0
	p1:_stopMovement()
	p1._presentation:StopWalkAnimation()
	p1._presentation:EnsureIdleAnimation()
	p1._presentation:StopFootstepSound()
	p1:_updateSleepTurn(p2)
end
function t._cancelSleepTurn(p1) --[[ _cancelSleepTurn | Line: 516 ]]
	local _sleepTurnConnection = p1._sleepTurnConnection

	if _sleepTurnConnection ~= nil then
		p1._sleepTurnConnection = nil
		_sleepTurnConnection:Disconnect()
	end

	p1._sleepTurnFromCFrame = nil
	p1._sleepTurnStartTime = 0
end
function t._updateSleepTurn(p1, p2) --[[ _updateSleepTurn | Line: 527 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)

	local _sleepTurnFromCFrame = p1._sleepTurnFromCFrame

	if _sleepTurnFromCFrame == nil then
		return false
	end

	if p1:HasStolenEggs() or p1._eggRetrieval:HasPending() then
		p1:_cancelSleepTurn()

		return false
	end

	local v2 = math.clamp((p2 - p1._sleepTurnStartTime) / 0.3, 0, 1)
	local v3 = Vector3.new(p1._homeCFrame.Position.X, p1._root.Position.Y, p1._homeCFrame.Position.Z)

	p1._guardModel:PivotTo((CFrame.new(v3) * _sleepTurnFromCFrame.Rotation):Lerp(CFrame.new(v3) * p1._homeCFrame.Rotation, v2))

	if not (v2 >= 1) then
		return true
	end

	p1:_enterSleepState()

	return true
end
function t._updateMovementRecovery(p1, p2) --[[ _updateMovementRecovery | Line: 555 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)

	if p1._movementRecovery:Step(p2, if p1._currentMoveTo == nil or p1._state ~= "Chasing" and (p1._state ~= "ReturningHome" and p1._state ~= "RetrievingEgg") then false else not p1:_isHitPaused(p2), p1._state == "ReturningHome") then
		return p1:_recoverToHome()
	end

	return nil
end
function t._recoverToHome(p1) --[[ _recoverToHome | Line: 567 ]]
	p1:_stopMovement()

	if p1._eggRetrieval:HasPending() then
		p1._guardModel:PivotTo(p1._homeCFrame)
		p1:_enterEggRetrievalState(os.clock())

		return p1:_updateEggRetrieval(os.clock())
	end

	p1:_enterSleepState()

	return nil
end
function t._chooseClosestPlayer(p1) --[[ _chooseClosestPlayer | Line: 578 | Upvalues: Players (copy) ]]
	local v1 = (1 / 0)
	local v2 = nil
	local v3 = nil
	local v4 = nil
	local v5 = nil

	for k, v in pairs(p1._stolenPlayerByEggUid) do
		if v ~= nil and table.find(Players:GetPlayers(), v) then
			local v6, v7 = p1:_resolvePlayerTarget(v)

			if v6 ~= nil and v7 ~= nil then
				local Magnitude = (p1._root.Position - v6.Position).Magnitude

				if Magnitude < v1 then
					v1 = Magnitude
					v2 = v
					v3 = v6
					v4 = v7
					v5 = k
				end
			end
		end
	end

	return v2, v3, v4, v5
end
function t._refreshWakeTarget(p1) --[[ _refreshWakeTarget | Line: 612 ]]
	local v1 = p1:_chooseClosestPlayer()
	local v2 = if v1 == nil then "" else tostring(v1.UserId)

	if p1._guardModel:GetAttribute("WakeTargetPlayer") ~= v2 then
		p1._guardModel:SetAttribute("WakeTargetPlayer", v2)
	end
end
function t._resolvePlayerTarget(p1, p2) --[[ _resolvePlayerTarget | Line: 622 | Upvalues: Player (copy) ]]
	if not p1._targetResolver(p2) then
		return nil, nil
	end

	if Player.Optional.Character(p2) == nil then
		return nil, nil
	end

	local v1 = Player.Optional.HumanoidRootPart(p2)
	local v2 = Player.Optional.Humanoid(p2)

	if v1 == nil or v2 == nil then
		return nil, nil
	end

	assert(v1:IsA("BasePart"), (("%* must be a BasePart"):format((v1:GetFullName()))))

	if v2.Health <= 0 then
		return nil, nil
	end

	return v1, v2
end
function t._attemptAttack(p1, p2, p3, p4, p5, p6) --[[ _attemptAttack | Line: 645 | Upvalues: Asserts (copy), ATTACK_MIN_INTERVAL (copy) ]]
	Asserts.Player(p2)
	Asserts.BasePart(p3)
	Asserts.Humanoid(p4)
	Asserts.optional.string(p5)
	Asserts.number(p6)

	if p6 < p1._attackResumeTime then
		return
	end

	if p6 < p1._ragdollEndTime then
		return
	end

	if p6 - p1._lastAttackTime < ATTACK_MIN_INTERVAL then
		return
	end

	p1._lastAttackTime = p6
	p1._currentMoveTo = nil
	p1._movementRecovery:Reset()

	local v1 = p1._presentation:PlayHit()
	local v2 = ATTACK_MIN_INTERVAL

	if v1 > 0 then
		v2 = math.max(v2, v1)
	end

	p1._walkResumeTime = p6 + v2
	p1._attackResumeTime = math.max(p1._attackResumeTime, p6 + v2)
	p1._attackHandler({
		AreaId = p1._areaId,
		Bounds = p1._bounds,
		EggUid = p5,
		GuardHomePosition = p1._homeCFrame.Position,
		GuardModel = p1._guardModel,
		GuardRoot = p1._root,
		GuardWalkSpeed = p1._config.WalkSpeed,
		Player = p2,
		PlayerHumanoid = p4,
		PlayerRoot = p3
	})
end
function t._moveTo(p1, p2) --[[ _moveTo | Line: 696 | Upvalues: Asserts (copy) ]]
	Asserts.Vector3(p2)

	local v1 = Vector3.new(p2.X, p1._root.Position.Y, p2.Z)

	p1._currentMoveTo = v1
	p1._humanoid:MoveTo(v1)
end
function t._moveThrough(p1, p2) --[[ _moveThrough | Line: 705 | Upvalues: Asserts (copy) ]]
	Asserts.Vector3(p2)
	p1:_moveTo(p2 + Vector3.new(p2.X - p1._root.Position.X, 0, p2.Z - p1._root.Position.Z).Unit * 100)
end
function t._stopMovement(p1) --[[ _stopMovement | Line: 712 ]]
	p1._currentMoveTo = nil
	p1._movementRecovery:Reset()
	p1._humanoid:MoveTo(p1._root.Position)
	p1._humanoid:Move(Vector3.new(0, 0, 0), false)
end
function t._setTarget(p1, p2) --[[ _setTarget | Line: 719 ]]
	if p1._targetPlayer == p2 then
		return
	end

	p1._targetPlayer = p2

	if p2 == nil then
		p1._guardModel:SetAttribute("TargetPlayer", "")
	else
		p1._guardModel:SetAttribute("TargetPlayer", (tostring(p2.UserId)))
		p1._presentation:PlayWake()
	end
end
function t._ensureWalkAnimation(p1, p2) --[[ _ensureWalkAnimation | Line: 734 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)

	if p2 < p1._walkResumeTime then
		p1._presentation:EnsureIdleAnimation()
	else
		p1._presentation:EnsureWalkAnimation(p1._humanoid.WalkSpeed)
	end
end
function t._trySetNetworkOwner(p1, p2, p3) --[[ _trySetNetworkOwner | Line: 745 | Upvalues: Asserts (copy), v1 (copy) ]]
	Asserts.number(p2)
	Asserts.boolean(p3)

	if not p1._serverOwnsPhysics or p1._root.Anchored then
		return
	end

	if not p3 and p2 - p1._lastNetworkOwnerRetry < 5 then
		return
	end

	p1._lastNetworkOwnerRetry = p2

	if p1._root:CanSetNetworkOwnership() then
		p1._root:SetNetworkOwner(nil)
	else
		v1:AtWarning():Log((("Guard root network ownership cannot be set yet: %*"):format((p1._root:GetFullName()))))
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 770 ]]
	p1._eggRetrieval:Destroy()
	p1:_cancelSleepTurn()
	p1:_stopMovement()
	p1._presentation:Destroy()
	table.clear(p1._stolenEggUidByPlayer)
	table.clear(p1._stolenPlayerByEggUid)
end
function t.RegisterStolenEgg(p1, p2, p3) --[[ RegisterStolenEgg | Line: 779 | Upvalues: Asserts (copy) ]]
	Asserts.Player(p2)
	Asserts.string(p3)

	local v1 = p1._stolenPlayerByEggUid[p3]

	if v1 == p2 then
		return false
	end

	if v1 ~= nil then
		error((("Stolen egg \"%*\" is already registered to %*"):format(p3, v1.Name)))
	end

	local v2 = p1._stolenEggUidByPlayer[p2]

	if v2 ~= nil then
		p1._stolenPlayerByEggUid[v2] = nil
	end

	p1._stolenPlayerByEggUid[p3] = p2
	p1._stolenEggUidByPlayer[p2] = p3

	local v3 = os.clock()

	if p1._eggRetrieval:HasPending() then
		if p1._state ~= "Sleeping" then
			return true
		end

		p1:_enterWakingState(v3)
	elseif p1._state == "Sleeping" or p1._state == "Waking" then
		p1:_enterWakingState(v3)
	else
		p1:_enterChaseState(v3)
		p1:_updateChase(v3)
	end

	return true
end
function t.RegisterDroppedEgg(p1, p2) --[[ RegisterDroppedEgg | Line: 814 | Upvalues: Asserts (copy) ]]
	Asserts.table(p2)

	if not p1._eggRetrieval:Register(p2) then
		return false
	end

	local v1 = os.clock()

	if p1._state == "Sleeping" then
		p1:_enterWakingState(v1)
	else
		if p1._state == "Waking" then
			return true
		end

		p1:_enterEggRetrievalState(v1)
	end

	return true
end
function t.ClearDroppedEgg(p1, p2) --[[ ClearDroppedEgg | Line: 829 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)

	if not p1._eggRetrieval:Clear(p2) then
		return false
	end

	if p1._state ~= "RetrievingEgg" or p1._eggRetrieval:HasPending() then
		return true
	end

	local v1 = os.clock()

	if p1:HasStolenEggs() then
		p1:_enterChaseState(v1)
		p1:_updateChase(v1)
	else
		p1:_enterReturnHomeState(v1)
	end

	return true
end
function t.IsDroppedEggAttached(p1, p2) --[[ IsDroppedEggAttached | Line: 847 ]]
	return p1._eggRetrieval:IsAttached(p2)
end
function t.ClearStolenEgg(p1, p2) --[[ ClearStolenEgg | Line: 851 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)

	local v1 = p1._stolenPlayerByEggUid[p2]

	if v1 == nil then
		return false
	end

	p1._stolenPlayerByEggUid[p2] = nil

	if p1._stolenEggUidByPlayer[v1] == p2 then
		p1._stolenEggUidByPlayer[v1] = nil
	end

	if p1._targetPlayer == v1 then
		p1:_setTarget(nil)
	end

	if p1:HasStolenEggs() then
		return true
	end

	if p1._eggRetrieval:HasPending() then
		return true
	end

	if p1._state == "Waking" or p1._state == "Sleeping" then
		p1:_enterSleepState()
	else
		p1:_enterReturnHomeState(os.clock())
	end

	return true
end
function t.ClearPlayer(p1, p2) --[[ ClearPlayer | Line: 880 | Upvalues: Asserts (copy) ]]
	Asserts.Player(p2)

	local v1 = p1._stolenEggUidByPlayer[p2]

	if v1 ~= nil then
		p1._stolenEggUidByPlayer[p2] = nil
		p1._stolenPlayerByEggUid[v1] = nil
	end

	if p1._targetPlayer == p2 then
		p1:_setTarget(nil)
	end

	if p1:HasStolenEggs() then
		return
	end

	if p1._eggRetrieval:HasPending() then
		return
	end

	if p1._state == "Waking" or p1._state == "Sleeping" then
		p1:_enterSleepState()
	else
		p1:_enterReturnHomeState(os.clock())
	end
end
function t.HasStolenEggs(p1) --[[ HasStolenEggs | Line: 903 ]]
	return next(p1._stolenPlayerByEggUid) ~= nil
end
function t.Step(p1, p2) --[[ Step | Line: 907 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)

	if p1._movementRecovery:ShouldRecoverFromFall() then
		return p1:_recoverToHome()
	end

	p1:_trySetNetworkOwner(p2, false)

	if p1._state ~= "Waking" and (p1._state ~= "RetrievingEgg" and p1._eggRetrieval:HasPending()) then
		p1:_enterEggRetrievalState(p2)
	end

	local v1 = nil

	if p1._state == "Sleeping" then
		if p1:HasStolenEggs() then
			p1:_enterWakingState(p2)
		end
	elseif p1._state == "Waking" then
		p1:_updateWaking(p2)
	elseif p1._state == "Chasing" then
		p1:_updateChase(p2)
	elseif p1._state == "ReturningHome" then
		p1:_updateReturnHome(p2)
	elseif p1._state == "RetrievingEgg" then
		v1 = p1:_updateEggRetrieval(p2)
	end

	p1._presentation:UpdateAfterWake(p2, if p1._state == "Chasing" then true else false)

	if v1 == nil then
		return p1:_updateMovementRecovery(p2)
	end

	return v1
end

return t