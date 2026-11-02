-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local CollisionGroups = require(ReplicatedStorage.Shared.Types.CollisionGroups)
local GuardChasePolicy = require(script.Parent.GuardChasePolicy)
local GuardDistance = require(script.Parent.GuardDistance)
local GuardEggRetrievalComponent = require(script.Parent.GuardEggRetrievalComponent)
local GuardReturnHomeDistanceResolver = require(script.Parent.GuardReturnHomeDistanceResolver)
local GuardMovementRecovery = require(script.Parent.GuardMovementRecovery)
local GuardPresentationComponent = require(script.Parent.GuardPresentationComponent)
require(ReplicatedStorage.Data.Guards)
local Log = require(ReplicatedStorage.Packages.Log)
local Player = require(ReplicatedStorage.Shared.Player)
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.Types.Interface)
local WaitFor = require(ReplicatedStorage.Packages.WaitFor)
local v1 = {}

v1.__index = v1
v1.__class = "GuardComponent"
v1.ATTACK_MIN_INTERVAL = 0.75

local ATTACK_MIN_INTERVAL = v1.ATTACK_MIN_INTERVAL
local v2 = Log.new()

function v1.new(v3, v4, v5, v6, v7, v8, v9) -- line 29 | captures: Constants, CollisionGroups, GuardEggRetrievalComponent, GuardMovementRecovery, GuardPresentationComponent, t, WaitFor, v1
    local v10 = {}
    local v11 = setmetatable(v10, v1)
    t.strict(t.string)(v3)
    t.strict(t.instanceIsA("Model"))(v4)
    t.strict(t.instanceIsA("BasePart"))(v5)
    t.strict(t.instanceIsA("BasePart"))(v6)
    t.strict(t.table)(v7)
    t.strict(t.callback)(v8)
    t.strict(t.table)(v9)
    t.strict(t.callback)(v9.Attack)
    t.strict(t.boolean)(v9.ServerOwnsPhysics)
    t.strict(t.callback)(v9.Wake)
    local v12, v13 = WaitFor.Descendant(v4, "Humanoid", Constants.STUDIO_YIELD_TIMEOUT):await()
    local v14, v15 = WaitFor.Descendant(v4, "Animator", Constants.STUDIO_YIELD_TIMEOUT):await()
    local v16 = v4:WaitForChild("HumanoidRootPart", Constants.STUDIO_YIELD_TIMEOUT)
    local v17 = v4:WaitForChild("Collider", Constants.STUDIO_YIELD_TIMEOUT)
    local v18, v19 = WaitFor.Descendant(v4, "Head", Constants.STUDIO_YIELD_TIMEOUT):await()
    local v20 = ("Failed to resolve Humanoid under %*: %*"):format(v4:GetFullName(), (tostring(v13)))
    assert(v12, v20)
    local v21 = ("Failed to resolve Animator under %*: %*"):format(v4:GetFullName(), (tostring(v15)))
    assert(v14, v21)
    local v22 = ("Failed to resolve HumanoidRootPart under %*: %*"):format(v4:GetFullName(), (tostring(v16)))
    assert(v16, v22)
    local v23 = ("Failed to resolve Collider under %*"):format((v4:GetFullName()))
    assert(v17, v23)
    local v24 = ("Failed to resolve Head under %*: %*"):format(v4:GetFullName(), (tostring(v19)))
    assert(v18, v24)
    local Humanoid = v13:IsA("Humanoid")
    local v25 = ("%*.Humanoid must be a Humanoid"):format((v4:GetFullName()))
    assert(Humanoid, v25)
    local Animator = v15:IsA("Animator")
    local v26 = ("%*.Animator must be an Animator"):format((v4:GetFullName()))
    assert(Animator, v26)
    local BasePart = v16:IsA("BasePart")
    local v27 = ("%*.HumanoidRootPart must be a BasePart"):format((v4:GetFullName()))
    assert(BasePart, v27)
    local BasePart_2 = v17:IsA("BasePart")
    local v28 = ("%*.Collider must be a BasePart"):format((v4:GetFullName()))
    assert(BasePart_2, v28)
    if Constants.IS_STUDIO and v15.Parent == v13 and not v4:FindFirstChild("Model") then
        error((("Animator has to be parented to the animation controller for %*"):format((v4:GetFullName()))))
    end
    local CurrentPhysicalProperties = v17.CurrentPhysicalProperties
    v17.CustomPhysicalProperties = PhysicalProperties.new(0.01, CurrentPhysicalProperties.Friction, CurrentPhysicalProperties.Elasticity, CurrentPhysicalProperties.FrictionWeight, CurrentPhysicalProperties.ElasticityWeight)
    local v29 = v9.ServerOwnsPhysics and v4:GetAttribute("Hidden") == true
    for v30, v31 in v4:GetDescendants() do
        if v31:IsA("BasePart") then
            if not v29 then
                v31.Anchored = false
            end
            v31.CollisionGroup = CollisionGroups.GUARD_COLLISION_GROUP
        end
    end
    v11._areaId = v3
    v11._attackHandler = v9.Attack
    v11._bounds = v5
    v11._config = v7
    v11._eggRetrieval = GuardEggRetrievalComponent.new(v4, v16, v16.CFrame)
    v11._enabled = true
    v11._currentMoveTo = nil
    v11._guardModel = v4
    v11._homeCFrame = v16.CFrame
    v11._humanoid = v13
    v11._lastAttackTime = 0
    v11._lastNetworkOwnerRetry = (-1/0)
    v11._lastTargetRefresh = 0
    v11._movementRecovery = GuardMovementRecovery.new(v16, v6)
    v11._attackResumeTime = 0
    v11._ragdollEndTime = 0
    v11._presentation = GuardPresentationComponent.new(v16, v15, v7)
    v11._root = v16
    v11._serverOwnsPhysics = v9.ServerOwnsPhysics
    v11._sleepTurnConnection = nil
    v11._sleepTurnFromCFrame = nil
    v11._sleepTurnStartTime = 0
    v11._state = "Sleeping"
    v11._stolenEggUidByPlayer = {}
    v11._stolenPlayerByEggUid = {}
    v11._stolenPriorityByEggUid = {}
    v11._targetPlayer = nil
    v11._targetResolver = v8
    v11._wakeHandler = v9.Wake
    v11._wakingStartedAt = 0
    v11._walkResumeTime = 0
    v4:SetAttribute("TargetPlayer", "")
    v4:SetAttribute("Sleeping", false)
    v4:SetAttribute("GuardState", "")
    v4:SetAttribute("AreaId", v3)
    v4:SetAttribute("WakeTargetPlayer", "")
    v13.WalkSpeed = v7.WalkSpeed
    v13:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    v11:_trySetNetworkOwner(os.clock(), true)
    v11:_enterSleepState()
    return v11
end

local function _setState(v32, v33) -- line 134
    v32._state = v33
    if v33 ~= "Chasing" then
        v32._presentation:CancelAfterWake()
    end
end

v1._setState = _setState

function v1._isHitPaused(v34, v35) -- line 140 | captures: t
    t.strict(t.number)(v35)
    local _walkResumeTime = v34._walkResumeTime
    local _attackResumeTime = v34._attackResumeTime
    return v35 < math.max(_walkResumeTime, _attackResumeTime)
end

local function _enterSleepState(v36) -- line 146
    v36:_setState("Sleeping")
    v36._targetPlayer = nil
    v36._currentMoveTo = nil
    v36._movementRecovery:Reset()
    v36:_cancelSleepTurn()
    v36._wakingStartedAt = 0
    if v36._serverOwnsPhysics then
        if v36._guardModel:GetAttribute("Hidden") ~= true then
            v36._root.Anchored = false
        end
    else
        v36._root.Anchored = false
    end
    v36._root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    v36._root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    v36._guardModel:PivotTo(v36._homeCFrame)
    v36._root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    v36._root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    v36._humanoid.WalkSpeed = 0
    v36._humanoid:Move(Vector3.new(0, 0, 0), false)
    v36._guardModel:SetAttribute("Sleeping", true)
    v36._guardModel:SetAttribute("TargetPlayer", "")
    v36._guardModel:SetAttribute("WakeTargetPlayer", "")
    v36._guardModel:SetAttribute("GuardState", v36._state)
    v36._presentation:StopWalkAnimation()
    v36._presentation:StopIdleAnimation()
    v36._presentation:StopFootstepSound()
    v36._presentation:PlaySleep(0.75)
end

v1._enterSleepState = _enterSleepState

function v1._enterWakingState(v37, v38) -- line 174 | captures: t
    t.strict(t.number)(v38)
    if v37._state == "Waking" then
        return
    end
    v37:_cancelSleepTurn()
    v37:_setTarget(nil)
    v37:_setState("Waking")
    v37._currentMoveTo = nil
    v37._movementRecovery:Reset()
    v37._wakingStartedAt = v38
    v37._guardModel:SetAttribute("TargetPlayer", "")
    v37._guardModel:SetAttribute("GuardState", v37._state)
    v37:_refreshWakeTarget()
end

function v1._updateWaking(v39, v40) -- line 190 | captures: GuardChasePolicy, t
    t.strict(t.number)(v40)
    if v39:HasStolenEggs() or v39._eggRetrieval:HasPending() then
        v39:_refreshWakeTarget()
        if not (v40 - v39._wakingStartedAt < GuardChasePolicy.GetWakingDuration()) then
            if v39._eggRetrieval:HasPending() then
                v39:_enterEggRetrievalState(v40)
            else
                v39:_enterChaseState(v40)
                v39:_updateChase(v40)
            end
        end
    else
        v39:_enterSleepState()
    end
end

function v1._getChaseWalkSpeed(v41, v42) -- line 223 | captures: GuardChasePolicy, t
    t.strict(t.number)(v42)
    return GuardChasePolicy.ResolveWalkSpeed(v41._config.WalkSpeed, v41._config.FlatRadius, v42)
end

local function _getReturnWalkSpeed(v43) -- line 228
    return v43._config.WalkSpeed * 1.5
end

v1._getReturnWalkSpeed = _getReturnWalkSpeed

local function _enterChaseState(v44, v45) -- line 231
    local v46 = v44._state == "Waking"
    v44:_cancelSleepTurn()
    if v44._state ~= "Chasing" then
        v44._wakingStartedAt = 0
        if v44._serverOwnsPhysics then
            if v44._guardModel:GetAttribute("Hidden") == true then
            end
        else
            v44._root.Anchored = false
        end
        v44:_trySetNetworkOwner(v45, true)
        v44._humanoid.WalkSpeed = v44._config.WalkSpeed
        v44._guardModel:SetAttribute("Sleeping", false)
        v44._guardModel:SetAttribute("GuardState", "Chasing")
        v44._guardModel:SetAttribute("WakeTargetPlayer", "")
        v44._presentation:StopSleep(0.4)
        v44._wakeHandler(v44._guardModel)
    end
    v44:_setState("Chasing")
    if v46 then
        v44._presentation:ScheduleAfterWake(v45)
    end
    if v44._walkResumeTime < v45 then
        v44._walkResumeTime = v45
    end
end

v1._enterChaseState = _enterChaseState

function v1._enterEggRetrievalState(v47, v48) -- line 256 | captures: t
    t.strict(t.number)(v48)
    local v49 = v47._state == "Waking"
    v47:_cancelSleepTurn()
    v47:_setTarget(nil)
    v47:_setState("RetrievingEgg")
    v47._wakingStartedAt = 0
    if v47._serverOwnsPhysics then
        if v47._guardModel:GetAttribute("Hidden") ~= true then
            v47._root.Anchored = false
        end
    else
        v47._root.Anchored = false
    end
    v47:_trySetNetworkOwner(v48, true)
    v47._guardModel:SetAttribute("Sleeping", false)
    v47._guardModel:SetAttribute("GuardState", v47._state)
    v47._guardModel:SetAttribute("WakeTargetPlayer", "")
    if v49 then
        v47._presentation:StopSleep(0.4)
        v47._wakeHandler(v47._guardModel)
    end
end

function v1._updateEggRetrieval(v50, v51) -- line 278 | captures: GuardChasePolicy, t
    t.strict(t.number)(v51)
    if v50._eggRetrieval:HasPending() then
        if v50:_isHitPaused(v51) then
            v50._humanoid.WalkSpeed = 0
            v50:_stopMovement()
            v50._presentation:StopWalkAnimation()
            v50._presentation:EnsureIdleAnimation()
            v50._presentation:StopFootstepSound()
            return nil
        end
        local v52 = v50._eggRetrieval:GetCurrentEggUid()
        local v53 = v50._config.EggPickupDistance or GuardChasePolicy.ResolveHitDistance(v50._config.HitDistance)
        local v54 = v50._eggRetrieval:TryTransition(v53)
        if v54 == nil then
            local v55 = v50._eggRetrieval:GetMoveTarget()
            local v56 = v55 ~= nil
            assert(v56, "Pending guard retrieval requires a movement target")
            v50._humanoid.WalkSpeed = v50:_getReturnWalkSpeed()
            v50:_ensureWalkAnimation(v51)
            v50:_moveTo(v55)
            return nil
        end
        local v57 = v52 ~= nil
        assert(v57, "Guard retrieval transition requires an egg UID")
        local v58 = {
            AreaId = v50._areaId,
            EggUid = v52,
            Kind = v54
        }
        if v54 == "Deposited" then
            if v50._eggRetrieval:HasPending() then
                v50:_enterEggRetrievalState(v51)
            elseif v50:HasStolenEggs() then
                v50:_enterChaseState(v51)
                v50:_updateChase(v51)
            else
                v50:_enterReturnHomeState(v51)
            end
        else
            local v59 = v50._eggRetrieval:GetMoveTarget()
            local v60 = v59 ~= nil
            assert(v60, "Attached guard retrieval egg requires a home movement target")
            v50._humanoid.WalkSpeed = v50:_getReturnWalkSpeed()
            v50:_ensureWalkAnimation(v51)
            v50:_moveTo(v59)
        end
        return v58
    end
    if v50:HasStolenEggs() then
        v50:_enterChaseState(v51)
        v50:_updateChase(v51)
    else
        v50:_enterReturnHomeState(v51)
    end
    return nil
end

local function _enterReturnHomeState(v61, v62) -- line 339
    if v61._eggRetrieval:HasPending() then
        v61:_enterEggRetrievalState(v62)
    else
        v61:_setState("ReturningHome")
        v61._guardModel:SetAttribute("GuardState", "ReturningHome")
        v61:_setTarget(nil)
        v61:_cancelSleepTurn()
        if v61._serverOwnsPhysics then
            if v61._guardModel:GetAttribute("Hidden") ~= true then
                v61._root.Anchored = false
            end
        else
            v61._root.Anchored = false
        end
        if v61:_isHitPaused(v62) then
            v61._humanoid.WalkSpeed = 0
            v61:_stopMovement()
            v61._presentation:StopWalkAnimation()
            v61._presentation:EnsureIdleAnimation()
            v61._presentation:StopFootstepSound()
        else
            v61._humanoid.WalkSpeed = v61:_getReturnWalkSpeed()
            v61:_moveTo(v61._homeCFrame.Position)
        end
    end
end

v1._enterReturnHomeState = _enterReturnHomeState

function v1._updateChase(v63, v64) -- line 365 | captures: GuardChasePolicy, GuardDistance
    if v63._eggRetrieval:HasPending() then
        v63:_enterEggRetrievalState(v64)
    else
        if v63:HasStolenEggs() then
            local _targetPlayer = v63._targetPlayer
            local v65, v66, v67
            if _targetPlayer == nil or v63._stolenEggUidByPlayer[_targetPlayer] == nil then
            else
                v65, v66 = v63:_resolvePlayerTarget(_targetPlayer)
                v67 = v63._stolenEggUidByPlayer[_targetPlayer]
            end
            if v65 == nil or v66 == nil or v64 - v63._lastTargetRefresh >= 0.3 then
                _targetPlayer, v65, v66, v67 = v63:_chooseTargetPlayer()
                v63._lastTargetRefresh = v64
            end
            if _targetPlayer ~= nil and v65 ~= nil and v66 ~= nil then
                v63:_setTarget(_targetPlayer)
                if GuardDistance.XZ(v63._root.Position, v65.Position) <= GuardChasePolicy.ResolveHitDistance(v63._config.HitDistance) then
                    v63:_attemptAttack(_targetPlayer, v65, v66, v67, v64)
                else
                    local v68 = v63:_getChaseWalkSpeed(GuardDistance.XZ(v63._root.Position, v65.Position))
                    v63._humanoid.WalkSpeed = v68
                    v63:_ensureWalkAnimation(v64)
                    v63:_moveThrough(v65.Position)
                end
                return
            end
            v63:_setTarget(nil)
        end
        v63:_enterReturnHomeState(v64)
    end
end

function v1._updateReturnHome(v69, v70) -- line 426 | captures: GuardReturnHomeDistanceResolver
    if v69._eggRetrieval:HasPending() then
        v69:_enterEggRetrievalState(v70)
    elseif v69:HasStolenEggs() then
        v69:_enterChaseState(v70)
    elseif not (v69._sleepTurnConnection ~= nil or v69:_updateSleepTurn(v70)) then
        if (v69._root.Position - v69._homeCFrame.Position).Magnitude <= GuardReturnHomeDistanceResolver.Resolve(v69._areaId) then
            v69:_beginSleepTurn(v70)
        elseif v69:_isHitPaused(v70) then
            v69._humanoid.WalkSpeed = 0
            v69:_stopMovement()
            v69._presentation:StopWalkAnimation()
            v69._presentation:EnsureIdleAnimation()
            v69._presentation:StopFootstepSound()
        else
            v69._humanoid.WalkSpeed = v69:_getReturnWalkSpeed()
            v69:_ensureWalkAnimation(v70)
            v69:_moveTo(v69._homeCFrame.Position)
        end
    end
end

function v1._beginSleepTurn(v71, v72) -- line 455 | captures: RunService, t
    t.strict(t.number)(v72)
    v71._sleepTurnFromCFrame = v71._root.CFrame
    v71._sleepTurnStartTime = v72
    if v71._sleepTurnConnection == nil then
        local Heartbeat = RunService.Heartbeat
        v71._sleepTurnConnection = Heartbeat:Connect(function() -- line 461 | captures: v71
            v71:_updateSleepTurn(os.clock())
        end)
    end
    v71._humanoid.WalkSpeed = 0
    v71:_stopMovement()
    v71._presentation:StopWalkAnimation()
    v71._presentation:EnsureIdleAnimation()
    v71._presentation:StopFootstepSound()
    v71:_updateSleepTurn(v72)
end

local function _cancelSleepTurn(v73) -- line 472
    local _sleepTurnConnection = v73._sleepTurnConnection
    if _sleepTurnConnection ~= nil then
        v73._sleepTurnConnection = nil
        _sleepTurnConnection:Disconnect()
    end
    v73._sleepTurnFromCFrame = nil
    v73._sleepTurnStartTime = 0
end

v1._cancelSleepTurn = _cancelSleepTurn

function v1._updateSleepTurn(v74, v75) -- line 481 | captures: t
    t.strict(t.number)(v75)
    local _sleepTurnFromCFrame = v74._sleepTurnFromCFrame
    if _sleepTurnFromCFrame ~= nil then
        if not (v74:HasStolenEggs() or v74._eggRetrieval:HasPending()) then
            local v76 = (v75 - v74._sleepTurnStartTime) / 0.3
            local v77 = math.clamp(v76, 0, 1)
            local X = v74._homeCFrame.Position.X
            local Y = v74._root.Position.Y
            local Z = v74._homeCFrame.Position.Z
            local v78 = Vector3.new(X, Y, Z)
            local v79 = CFrame.new(v78) * _sleepTurnFromCFrame.Rotation
            local v80 = CFrame.new(v78)
            v74._guardModel:PivotTo(v79:Lerp(v80 * v74._homeCFrame.Rotation, v77))
            if v77 >= 1 then
                v74:_enterSleepState()
            end
            return true
        end
        v74:_cancelSleepTurn()
    end
    return false
end

function v1._updateMovementRecovery(v81, v82) -- line 503 | captures: t
    t.strict(t.number)(v82)
    local v83
    if v81._currentMoveTo == nil then
        v83 = false
    elseif v81._state == "Chasing" then
        v83 = not v81:_isHitPaused(v82)
    else
        if v81._state ~= "ReturningHome" and v81._state == "RetrievingEgg" then
        end
        v83 = false
    end
    local v84 = v81._state == "ReturningHome"
    if v81._movementRecovery:Step(v82, v83, v84) then
        return v81:_recoverToHome()
    end
    return nil
end

local function _recoverToHome(v85) -- line 521
    v85:_stopMovement()
    if v85._eggRetrieval:HasPending() then
        v85._guardModel:PivotTo(v85._homeCFrame)
        v85:_enterEggRetrievalState(os.clock())
        return v85:_updateEggRetrieval(os.clock())
    end
    v85:_enterSleepState()
    return nil
end

v1._recoverToHome = _recoverToHome

function v1._chooseTargetPlayer(v86) -- line 531 | captures: Players
    local v87
    local v88
    local v89
    local v90
    local v91 = (-1/0)
    local v92 = (1/0)
    for v93, v94 in pairs(v86._stolenPlayerByEggUid) do
        if v94 ~= nil then
            local v95 = Players:GetPlayers()
            if table.find(v95, v94) then
                local v96, v97 = v86:_resolvePlayerTarget(v94)
                if v96 ~= nil and v97 ~= nil then
                    local v98 = v86._stolenPriorityByEggUid[v93] or 0
                    local Magnitude = (v86._root.Position - v96.Position).Magnitude
                    if v91 < v98 then
                        v87 = v94
                        v88 = v96
                        v89 = v97
                        v90 = v93
                        v91 = v98
                        v92 = Magnitude
                    elseif v98 == v91 and v92 <= Magnitude then
                    end
                end
            end
        end
    end
    return v87, v88, v89, v90
end

local function _refreshWakeTarget(v99) -- line 563
    local v100 = v99:_chooseTargetPlayer()
    local v101
    if v100 == nil then
        v101 = ""
    else
        local UserId = v100.UserId
        v101 = tostring(UserId)
    end
    if v99._guardModel:GetAttribute("WakeTargetPlayer") ~= v101 then
        v99._guardModel:SetAttribute("WakeTargetPlayer", v101)
    end
end

v1._refreshWakeTarget = _refreshWakeTarget

function v1._resolvePlayerTarget(v102, v103) -- line 576 | captures: Player
    if not v102._targetResolver(v103) or Player.Optional.Character(v103) == nil then
        return nil, nil
    end
    local v104 = Player.Optional.HumanoidRootPart(v103)
    local v105 = Player.Optional.Humanoid(v103)
    if v104 == nil or v105 == nil then
        return nil, nil
    end
    local BasePart = v104:IsA("BasePart")
    local v106 = ("%* must be a BasePart"):format((v104:GetFullName()))
    assert(BasePart, v106)
    if v105.Health <= 0 then
        return nil, nil
    end
    return v104, v105
end

function v1._attemptAttack(v107, v108, v109, v110, v111, v112) -- line 592 | captures: t, ATTACK_MIN_INTERVAL
    t.strict(t.instanceIsA("Player"))(v108)
    t.strict(t.instanceIsA("BasePart"))(v109)
    t.strict(t.instanceIsA("Humanoid"))(v110)
    t.strict(t.optional(t.string))(v111)
    t.strict(t.number)(v112)
    if v112 < v107._attackResumeTime or v112 < v107._ragdollEndTime or v112 - v107._lastAttackTime < ATTACK_MIN_INTERVAL then
        return
    end
    v107._lastAttackTime = v112
    v107._currentMoveTo = nil
    v107._movementRecovery:Reset()
    local v113 = v107._presentation:PlayHit()
    local v114 = ATTACK_MIN_INTERVAL
    if v113 > 0 then
        v114 = math.max(ATTACK_MIN_INTERVAL, v113)
    end
    v107._walkResumeTime = v112 + v114
    local _attackResumeTime = v107._attackResumeTime
    local v115 = v112 + v114
    v107._attackResumeTime = math.max(_attackResumeTime, v115)
    v107._attackHandler({
        AreaId = v107._areaId,
        Bounds = v107._bounds,
        EggUid = v111,
        GuardHomePosition = v107._homeCFrame.Position,
        GuardModel = v107._guardModel,
        GuardRoot = v107._root,
        GuardWalkSpeed = v107._config.WalkSpeed,
        Player = v108,
        PlayerHumanoid = v110,
        PlayerRoot = v109
    })
end

function v1._moveTo(v116, v117) -- line 633 | captures: t
    t.strict(t.Vector3)(v117)
    local X = v117.X
    local Y = v116._root.Position.Y
    local Z = v117.Z
    local v118 = Vector3.new(X, Y, Z)
    v116._currentMoveTo = v118
    v116._humanoid:MoveTo(v118)
end

function v1._moveThrough(v119, v120) -- line 640 | captures: t
    t.strict(t.Vector3)(v120)
    local v121 = v120.X - v119._root.Position.X
    local v122 = v120.Z - v119._root.Position.Z
    v119:_moveTo(v120 + Vector3.new(v121, 0, v122).Unit * 100)
end

local function _stopMovement(v123) -- line 645
    v123._currentMoveTo = nil
    v123._movementRecovery:Reset()
    v123._humanoid:MoveTo(v123._root.Position)
    v123._humanoid:Move(Vector3.new(0, 0, 0), false)
end

v1._stopMovement = _stopMovement

local function _setTarget(v124, v125) -- line 651
    if v124._targetPlayer ~= v125 then
        v124._targetPlayer = v125
        if v125 == nil then
            v124._guardModel:SetAttribute("TargetPlayer", "")
        else
            local _guardModel = v124._guardModel
            local UserId = v125.UserId
            _guardModel:SetAttribute("TargetPlayer", (tostring(UserId)))
            v124._presentation:PlayWake()
        end
    end
end

v1._setTarget = _setTarget

function v1._ensureWalkAnimation(v126, v127) -- line 663 | captures: t
    t.strict(t.number)(v127)
    if v127 < v126._walkResumeTime then
        v126._presentation:EnsureIdleAnimation()
    else
        v126._presentation:EnsureWalkAnimation(v126._humanoid.WalkSpeed)
    end
end

function v1._trySetNetworkOwner(v128, v129, v130) -- line 672 | captures: t, v2
    t.strict(t.number)(v129)
    t.strict(t.boolean)(v130)
    if not (not v128._serverOwnsPhysics or v128._root.Anchored) and (v130 or not (v129 - v128._lastNetworkOwnerRetry < 5)) then
        v128._lastNetworkOwnerRetry = v129
        if v128._root:CanSetNetworkOwnership() then
            v128._root:SetNetworkOwner(nil)
        else
            v2:AtWarning():Log((("Guard root network ownership cannot be set yet: %*"):format((v128._root:GetFullName()))))
        end
    end
end

local function Destroy(v131) -- line 700
    v131._eggRetrieval:Destroy()
    v131:_cancelSleepTurn()
    v131:_stopMovement()
    v131._presentation:Destroy()
    table.clear(v131._stolenEggUidByPlayer)
    table.clear(v131._stolenPlayerByEggUid)
    table.clear(v131._stolenPriorityByEggUid)
end

v1.Destroy = Destroy

function v1.RegisterStolenEgg(v132, v133, v134, v135) -- line 709 | captures: t
    t.strict(t.instanceIsA("Player"))(v133)
    t.strict(t.string)(v134)
    t.strict(t.number)(v135)
    local v136 = v132._stolenPlayerByEggUid[v134]
    if v136 == v133 then
        return false
    end
    if v136 ~= nil then
        error((("Stolen egg \"%*\" is already registered to %*"):format(v134, v136.Name)))
    end
    local v137 = v132._stolenEggUidByPlayer[v133]
    if v137 ~= nil then
        v132._stolenPlayerByEggUid[v137] = nil
        v132._stolenPriorityByEggUid[v137] = nil
    end
    v132._stolenPlayerByEggUid[v134] = v133
    v132._stolenEggUidByPlayer[v133] = v134
    v132._stolenPriorityByEggUid[v134] = v135
    if v132._enabled then
        local v138 = os.clock()
        if v132._eggRetrieval:HasPending() then
            if v132._state == "Sleeping" then
                v132:_enterWakingState(v138)
            end
        elseif v132._state == "Sleeping" or v132._state == "Waking" then
            v132:_enterWakingState(v138)
        else
            v132:_enterChaseState(v138)
            v132:_updateChase(v138)
        end
    end
    return true
end

function v1.RegisterDroppedEgg(v139, v140) -- line 751 | captures: t
    t.strict(t.table)(v140)
    if v139._eggRetrieval:Register(v140) then
        if v139._enabled then
            local v141 = os.clock()
            if v139._state == "Sleeping" then
                v139:_enterWakingState(v141)
            elseif v139._state ~= "Waking" then
                v139:_enterEggRetrievalState(v141)
            end
        end
        return true
    end
    return false
end

function v1.ClearDroppedEgg(v142, v143) -- line 768 | captures: t
    t.strict(t.string)(v143)
    if v142._eggRetrieval:Clear(v143) then
        if v142._state == "RetrievingEgg" and not v142._eggRetrieval:HasPending() then
            local v144 = os.clock()
            if v142:HasStolenEggs() then
                v142:_enterChaseState(v144)
                v142:_updateChase(v144)
            else
                v142:_enterReturnHomeState(v144)
            end
        end
        return true
    end
    return false
end

local function IsDroppedEggAttached(v145, v146) -- line 785
    return v145._eggRetrieval:IsAttached(v146)
end

v1.IsDroppedEggAttached = IsDroppedEggAttached

function v1.ClearStolenEgg(v147, v148) -- line 788 | captures: t
    t.strict(t.string)(v148)
    local v149 = v147._stolenPlayerByEggUid[v148]
    if v149 == nil then
        return false
    end
    v147._stolenPlayerByEggUid[v148] = nil
    v147._stolenPriorityByEggUid[v148] = nil
    if v147._stolenEggUidByPlayer[v149] == v148 then
        v147._stolenEggUidByPlayer[v149] = nil
    end
    if v147._targetPlayer == v149 then
        v147:_setTarget(nil)
    end
    if v147:HasStolenEggs() or v147._eggRetrieval:HasPending() then
        return true
    end
    if v147._state == "Waking" or v147._state == "Sleeping" then
        v147:_enterSleepState()
    else
        v147:_enterReturnHomeState(os.clock())
    end
    return true
end

function v1.ClearPlayer(v150, v151) -- line 815 | captures: t
    t.strict(t.instanceIsA("Player"))(v151)
    local v152 = v150._stolenEggUidByPlayer[v151]
    if v152 ~= nil then
        v150._stolenEggUidByPlayer[v151] = nil
        v150._stolenPlayerByEggUid[v152] = nil
        v150._stolenPriorityByEggUid[v152] = nil
    end
    if v150._targetPlayer == v151 then
        v150:_setTarget(nil)
    end
    if not (v150:HasStolenEggs() or v150._eggRetrieval:HasPending()) then
        if v150._state == "Waking" or v150._state == "Sleeping" then
            v150:_enterSleepState()
        else
            v150:_enterReturnHomeState(os.clock())
        end
    end
end

local function HasStolenEggs(v153) -- line 836
    return next(v153._stolenPlayerByEggUid) ~= nil
end

v1.HasStolenEggs = HasStolenEggs

local function IsEnabled(v154) -- line 840
    return v154._enabled
end

v1.IsEnabled = IsEnabled

function v1.SetEnabled(v155, v156) -- line 843 | captures: t
    t.strict(t.boolean)(v156)
    if v155._enabled ~= v156 then
        v155._enabled = v156
        if not v156 then
            v155:_enterSleepState()
        end
    end
end

function v1.Step(v157, v158) -- line 854 | captures: t
    t.strict(t.number)(v158)
    if v157._enabled then
        if v157._movementRecovery:ShouldRecoverFromFall() then
            return v157:_recoverToHome()
        end
        v157:_trySetNetworkOwner(v158, false)
        if v157._state ~= "Waking" and v157._state ~= "RetrievingEgg" and v157._eggRetrieval:HasPending() then
            v157:_enterEggRetrievalState(v158)
        end
        local v159
        if v157._state == "Sleeping" then
            if v157:HasStolenEggs() then
                v157:_enterWakingState(v158)
            end
        elseif v157._state == "Waking" then
            v157:_updateWaking(v158)
        elseif v157._state == "Chasing" then
            v157:_updateChase(v158)
        elseif v157._state == "ReturningHome" then
            v157:_updateReturnHome(v158)
        elseif v157._state == "RetrievingEgg" then
            v159 = v157:_updateEggRetrieval(v158)
        end
        local v160 = v157._state == "Chasing"
        v157._presentation:UpdateAfterWake(v158, v160)
        if v159 == nil then
            return v157:_updateMovementRecovery(v158)
        end
        return v159
    end
    return nil
end

return v1
