-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local Personalities = require(ReplicatedStorage.Data.Assets).Personalities
local Log = require(ReplicatedStorage.Packages.Log)
require(ReplicatedStorage.Data.Assets)
local t = require(ReplicatedStorage.Packages.t)
local AssetMutationWalkSpeed = require(script.Parent.AssetMutationWalkSpeed)
local AssetPersonalityMotion = require(script.Parent.AssetPersonalityMotion)
local AssetRetreatMotion = require(script.Parent.AssetRetreatMotion)
local AssetWanderArea = require(script.Parent.AssetWanderArea)
local AssetWanderMotion = require(script.Parent.AssetWanderMotion)
local v1 = Log.new()
local v2 = {}

v2.__index = v2
v2.__class = "AssetWanderSimulator"

function v2.new(v3, v4, v5, v6, v7, v8, v9) -- line 22 | captures: Players, AssetItem, Personalities, t, AssetPersonalityMotion, v1, v2
    t.strict(t.number)(v3)
    t.strict(t.instanceIsA("Player"))(v4)
    t.strict(t.instanceIsA("BasePart"))(v5)
    local v10 = AssetItem.AssetItemData(v6)
    assert(v10, "Invalid asset item data")
    t.strict(t.boolean)(v7)
    t.strict(t.number)(v8)
    t.strict(t.number)(v9)
    local v11 = Random.new(v3)
    local LocalPlayer = Players.LocalPlayer
    local v12 = LocalPlayer ~= nil
    assert(v12, "Asset wander simulator requires a local player")
    local v13 = Personalities.GetConfig(v6.Personality)
    local v14 = {}
    local v15 = setmetatable(v14, v2)
    v15._random = v11
    v15._owner = v4
    v15._localPlayer = LocalPlayer
    v15._assetArea = v5
    v15._itemData = v6
    v15._config = v13
    v15._greetingOrbitRadius = math.max(v8, 2.5)
    local v16 = math.max(v9, 1) * 2
    v15._jumpHeight = math.min(v16, 20)
    v15._destination = v5.Position
    v15._idleRemaining = 0
    v15._idleAnchorCFrame = nil
    v15._idleElapsed = 0
    v15._walkSpeed = v15:_rollWalkSpeed()
    v15._mode = "Destination"
    v15._phase = "Normal"
    v15._greetRemaining = 0
    v15._randomOrbitInsideSeconds = 0
    v15._farSeconds = 0
    v15._farRequiredSeconds = v11:NextNumber(105, 180)
    v15._joinGreetingPending = true
    v15._finishJumpsRemaining = 0
    v15._finishJumpCooldown = 0
    v15._returnGreetingHoldRemaining = 0
    v15._returnGreetingJumpsRemaining = 0
    v15._returnGreetingJumpCooldown = 0
    v15._returnGreetingOwnerOffset = nil
    v15._affectionInsideSeconds = 0
    v15._affectionHoldRemaining = 0
    v15._affectionJumpsRemaining = 0
    v15._affectionJumpCooldown = 0
    v15._affectionOwnerOffset = nil
    v15._loyalOwnerOffset = AssetPersonalityMotion.RandomOwnerOffset(v5, v11, v15._greetingOrbitRadius)
    v15._pendingBubbleText = nil
    v15._jumpRemaining = 0
    v15._jumpElapsed = 0
    v15._spinYaw = 0
    v15._spinAppliedYaw = 0
    v15._curveAngle = v11:NextNumber(-3.141592653589793, 3.141592653589793)
    v15._curveRotationSpeed = v11:NextNumber(-0.8, 0.8)
    v15._nextCurveChangeSeconds = v11:NextNumber(5, 10)
    v15._curveChangeElapsed = 0
    v15._retreatOwnerWasClose = false
    v15._retreatActive = false
    v15._lastOwnerPosition = nil
    v15:_chooseNextDestination()
    if v7 then
        v15:_tryStartFirstPlacementGreeting()
    end
    v1:AtDebug():Log((("Created asset wander simulator with seed %*"):format(v3)))
    return v15
end

function v2._rollWalkSpeed(v17) -- line 95 | captures: AssetMutationWalkSpeed
    local Movement = v17._config.Movement
    local v18 = v17._random:NextNumber(Movement.WalkSpeedMin, Movement.WalkSpeedMax)
    return math.max(v18, 4.5) * AssetMutationWalkSpeed.GetMultiplier(v17._itemData)
end

function v2._ownerRootPosition(v19) -- line 101 | captures: AssetPersonalityMotion
    return AssetPersonalityMotion.OwnerRootPosition(v19._owner)
end

function v2._distanceFromLocalPlayerToAreaCenter(v20) -- line 104 | captures: AssetPersonalityMotion
    return AssetPersonalityMotion.DistanceFromPlayerToAreaCenter(v20._localPlayer, v20._assetArea)
end

function v2._chooseNextDestination(v21) -- line 107 | captures: AssetPersonalityMotion
    local v22 = v21:_ownerRootPosition()
    local Movement = v21._config.Movement
    v21._walkSpeed = v21:_rollWalkSpeed()
    v21._destination = AssetPersonalityMotion.ChooseDestination(v21._assetArea, v21._random, Movement, v22)
    local v23 = v21._random:NextNumber()
    if Movement.CurvedWanderChance <= v23 then
        v21._mode = "Destination"
    else
        v21._mode = "Curve"
    end
end

function v2._tryRetreatFromOwner(v24, v25, v26) -- line 120 | captures: AssetPersonalityMotion, AssetRetreatMotion
    local Retreat = v24._config.Movement.Retreat
    if Retreat == nil then
        v24._retreatOwnerWasClose = false
        v24._retreatActive = false
    else
        local v27 = v25.X - v26.X
        local v28 = v25.Z - v26.Z
        if Vector3.new(v27, 0, v28).Magnitude <= Retreat.TriggerDistance then
            if v24._retreatActive then
                v24._destination = AssetRetreatMotion.Destination(v24._assetArea, v24._random, Retreat, v26, v25)
                v24._mode = "Destination"
                v24._idleRemaining = 0
                v24._idleAnchorCFrame = nil
                return true
            end
            if not v24._retreatOwnerWasClose then
                v24._retreatOwnerWasClose = true
                if AssetPersonalityMotion.RollChance(v24._random, Retreat.Chance) then
                    v24._retreatActive = true
                    v24._destination = AssetRetreatMotion.Destination(v24._assetArea, v24._random, Retreat, v26, v25)
                    v24._mode = "Destination"
                    v24._idleRemaining = 0
                    v24._idleAnchorCFrame = nil
                    v24._walkSpeed = v24:_rollWalkSpeed()
                    return true
                end
            end
        else
            v24._retreatOwnerWasClose = false
            v24._retreatActive = false
        end
    end
    return false
end

local function _beginIdle(v29, v30) -- line 156
    local Movement = v29._config.Movement
    v29._idleRemaining = v29._random:NextNumber(Movement.IdleSecondsMin, Movement.IdleSecondsMax)
    v29._idleAnchorCFrame = v30
    v29._idleElapsed = 0
end

v2._beginIdle = _beginIdle

function v2._stepIdle(v31, v32) -- line 162 | captures: AssetPersonalityMotion
    local _idleAnchorCFrame = v31._idleAnchorCFrame
    local v33 = _idleAnchorCFrame ~= nil
    assert(v33, "Idle phase requires a stable anchor CFrame")
    local v34, v35, v36, v37 = AssetPersonalityMotion.StepIdle(v32, v31._idleRemaining, v31._idleElapsed, _idleAnchorCFrame, v31._config.Movement.IdleTremble)
    v31._idleRemaining = v35
    v31._idleElapsed = v36
    if v37 then
        v31._idleAnchorCFrame = nil
        v31._idleElapsed = 0
    end
    return v31:_applyJump(v32, v34)
end

function v2._tryAmbientJump(v38, v39) -- line 176 | captures: AssetPersonalityMotion
    local Movement = v38._config.Movement
    local v40 = v38._jumpRemaining > 0
    if AssetPersonalityMotion.ShouldStartAmbientJump(v38._random, Movement.AmbientJumpRatePerSecond, v39, v40) then
        v38:_startJump(Movement.AmbientSpinJumpChance)
    end
end

local function _startJump(v41, v42) -- line 183
    if v41._jumpRemaining > 0 then
        return
    end
    local v43 = if v42 == nil then v41._config.Greeting.SpinJumpChance else v42
    v41._jumpRemaining = 0.45
    v41._jumpElapsed = 0
    v41._spinAppliedYaw = 0
    local v44 = if v41._random:NextNumber() >= 0.5 then 1 else -1
    if v43 <= v41._random:NextNumber() then
        v41._spinYaw = 0
    else
        v41._spinYaw = 6.283185307179586 * v44
    end
end

v2._startJump = _startJump

local function _resetGreetingFinish(v45) -- line 209
    v45._finishJumpsRemaining = 0
    v45._finishJumpCooldown = 0
end

v2._resetGreetingFinish = _resetGreetingFinish

local function _resetReturnGreeting(v46) -- line 213
    v46._returnGreetingHoldRemaining = 0
    v46._returnGreetingJumpsRemaining = 0
    v46._returnGreetingJumpCooldown = 0
    v46._returnGreetingOwnerOffset = nil
end

v2._resetReturnGreeting = _resetReturnGreeting

local function _resetAffection(v47) -- line 219
    v47._affectionHoldRemaining = 0
    v47._affectionJumpsRemaining = 0
    v47._affectionJumpCooldown = 0
    v47._affectionOwnerOffset = nil
    v47._pendingBubbleText = nil
end

v2._resetAffection = _resetAffection

local function _popBubbleText(v48) -- line 226
    local _pendingBubbleText = v48._pendingBubbleText
    v48._pendingBubbleText = nil
    return _pendingBubbleText
end

v2._popBubbleText = _popBubbleText

local function _beginGreetingFinish(v49) -- line 231
    v49._phase = "GreetingFinish"
    v49._greetRemaining = 1.2
    v49._finishJumpsRemaining = 2
    v49._finishJumpCooldown = 0
    v49._lastOwnerPosition = nil
end

v2._beginGreetingFinish = _beginGreetingFinish

function v2._beginGreetingOrbit(v50, v51) -- line 238 | captures: t, AssetPersonalityMotion
    t.strict(t.boolean)(v51)
    local Greeting = v50._config.Greeting
    v50._phase = "GreetingOrbit"
    local DurationSeconds = Greeting.DurationSeconds
    v50._greetRemaining = math.min(DurationSeconds, 3)
    v50._randomOrbitInsideSeconds = 0
    v50._idleRemaining = 0
    v50._lastOwnerPosition = nil
    v50:_resetGreetingFinish()
    v50:_resetReturnGreeting()
    v50:_resetAffection()
    if v51 then
        v50._pendingBubbleText = AssetPersonalityMotion.RandomConfiguredText(v50._random, Greeting.Texts, v50._config._id, "greeting")
    end
end

function v2._tryStartGreetingOrbit(v52, v53, v54) -- line 254 | captures: t, AssetPersonalityMotion
    t.strict(t.boolean)(v54)
    if not (v53 <= 0) and not (v52._config.Greeting.DurationSeconds <= 0) and AssetPersonalityMotion.RollChance(v52._random, v53) then
        v52:_beginGreetingOrbit(v54)
        return true
    end
    return false
end

function v2._beginNormalGreeting(v55, v56, v57, v58, v59) -- line 263 | captures: t, AssetPersonalityMotion, AssetWanderArea
    t.strict(t.boolean)(v59)
    local v60 = AssetPersonalityMotion.RandomOwnerOffset(v55._assetArea, v55._random, v55._greetingOrbitRadius)
    v55._phase = "ReturnGreetingApproach"
    v55._returnGreetingOwnerOffset = v60
    v55._returnGreetingHoldRemaining = math.min(v58, 20)
    v55._returnGreetingJumpsRemaining = v57
    v55._returnGreetingJumpCooldown = 0
    v55._destination = AssetWanderArea.PointNearOwner(v55._assetArea, v56, v60)
    v55._idleRemaining = 0
    v55._walkSpeed = v55:_rollWalkSpeed()
    v55._lastOwnerPosition = nil
    v55:_resetGreetingFinish()
    v55:_resetAffection()
    if v59 then
        v55._pendingBubbleText = AssetPersonalityMotion.RandomConfiguredText(v55._random, v55._config.Greeting.Texts, v55._config._id, "greeting")
    end
end

function v2._tryStartFirstPlacementGreeting(v61) -- line 282 | captures: AssetPersonalityMotion
    v61._joinGreetingPending = false
    local Greeting = v61._config.Greeting
    if not v61:_tryStartGreetingOrbit(Greeting.FirstPlacementChance, true) then
        local FirstPlacementBubbleChance = Greeting.FirstPlacementBubbleChance
        if FirstPlacementBubbleChance == nil or FirstPlacementBubbleChance <= 0 then
            local v62 = v61:_ownerRootPosition()
            if v62 ~= nil and AssetPersonalityMotion.RollChance(v61._random, Greeting.FirstPlacementNormalChance) then
                local FirstPlacementNormalJumpCount = Greeting.FirstPlacementNormalJumpCount
                if not (FirstPlacementNormalJumpCount <= 0) then
                    v61:_beginNormalGreeting(v62, FirstPlacementNormalJumpCount, 0.6 * FirstPlacementNormalJumpCount, true)
                end
            end
        elseif AssetPersonalityMotion.RollChance(v61._random, FirstPlacementBubbleChance) then
            v61._pendingBubbleText = AssetPersonalityMotion.RandomConfiguredText(v61._random, Greeting.Texts, v61._config._id, "greeting")
        else
            local v63 = v61:_ownerRootPosition()
            if v63 ~= nil and AssetPersonalityMotion.RollChance(v61._random, Greeting.FirstPlacementNormalChance) then
                local FirstPlacementNormalJumpCount = Greeting.FirstPlacementNormalJumpCount
                if not (FirstPlacementNormalJumpCount <= 0) then
                    v61:_beginNormalGreeting(v63, FirstPlacementNormalJumpCount, 0.6 * FirstPlacementNormalJumpCount, true)
                end
            end
        end
    end
end

function v2._tryStartReturnGreeting(v64, v65, v66) -- line 319 | captures: t, AssetPersonalityMotion
    t.strict(t.boolean)(v66)
    local Greeting = v64._config.Greeting
    if not (Greeting.Chance <= 0) and not (Greeting.DurationSeconds <= 0) and AssetPersonalityMotion.RollChance(v64._random, Greeting.Chance) then
        if v66 then
            if not v64:_tryStartGreetingOrbit(Greeting.ReturnOrbitChance, false) then
                local DurationSeconds = Greeting.DurationSeconds
                local v67 = math.min(DurationSeconds, 20)
                v64:_beginNormalGreeting(v65, Greeting.ReturnNormalJumpCount, v67, false)
            end
        else
            local DurationSeconds = Greeting.DurationSeconds
            local v68 = math.min(DurationSeconds, 20)
            v64:_beginNormalGreeting(v65, Greeting.ReturnNormalJumpCount, v68, false)
        end
    end
end

function v2._beginAffection(v69, v70) -- line 338 | captures: AssetPersonalityMotion, AssetWanderArea
    local Affection = v69._config.Affection
    local v71 = AssetPersonalityMotion.RandomOwnerOffset(v69._assetArea, v69._random, v69._greetingOrbitRadius)
    v69._phase = "AffectionApproach"
    v69._affectionOwnerOffset = v71
    v69._destination = AssetWanderArea.PointNearOwner(v69._assetArea, v70, v71)
    v69._idleRemaining = 0
    v69._walkSpeed = v69:_rollWalkSpeed()
    v69._affectionHoldRemaining = Affection.DurationSeconds
    v69._affectionJumpsRemaining = Affection.JumpCount
    v69._affectionJumpCooldown = 0
    v69._pendingBubbleText = nil
    v69._lastOwnerPosition = nil
    v69:_resetGreetingFinish()
end

function v2._updateAffectionTrigger(v72, v73, v74) -- line 353 | captures: AssetPersonalityMotion, AssetWanderArea
    if v72._phase ~= "Normal" then
        return
    end
    local Affection = v72._config.Affection
    if Affection.Enabled and not (Affection.IntervalSeconds <= 0) and v74 ~= nil and AssetWanderArea.IsPositionInside(v72._assetArea, v74) then
        v72._affectionInsideSeconds += v73
        if not (v72._affectionInsideSeconds < Affection.IntervalSeconds) then
            v72._affectionInsideSeconds = 0
            if AssetPersonalityMotion.RollChance(v72._random, Affection.Chance) then
                v72:_beginAffection(v74)
            end
        end
    else
        v72._affectionInsideSeconds = 0
    end
end

function v2._updateOrbitGreetingTrigger(v75, v76, v77) -- line 371 | captures: AssetWanderArea
    if v75._phase ~= "Normal" then
        return
    end
    local Greeting = v75._config.Greeting
    if not (Greeting.RandomOrbitChance <= 0) and not (Greeting.RandomOrbitIntervalSeconds <= 0) and not (Greeting.DurationSeconds <= 0) and v77 ~= nil and AssetWanderArea.IsPositionInside(v75._assetArea, v77) then
        v75._randomOrbitInsideSeconds += v76
        if not (v75._randomOrbitInsideSeconds < Greeting.RandomOrbitIntervalSeconds) then
            v75._randomOrbitInsideSeconds = 0
            v75:_tryStartGreetingOrbit(Greeting.RandomOrbitChance, false)
        end
    else
        v75._randomOrbitInsideSeconds = 0
    end
end

function v2._updateReturnGreeting(v78, v79) -- line 387 | captures: AssetWanderArea
    if v78._phase == "Normal" then
        if v78._joinGreetingPending then
            local v80 = v78:_ownerRootPosition()
            if v80 ~= nil then
                v78._joinGreetingPending = false
                v78._farSeconds = 0
                v78._farRequiredSeconds = v78._random:NextNumber(105, 180)
                v78:_tryStartReturnGreeting(v80, AssetWanderArea.IsPositionInside(v78._assetArea, v80))
            end
        else
            local v81 = v78:_distanceFromLocalPlayerToAreaCenter()
            if v81 ~= nil then
                if v81 >= 200 then
                    v78._farSeconds += v79
                else
                    local _farRequiredSeconds = v78._farRequiredSeconds
                    if v78._farSeconds < _farRequiredSeconds or v81 > 200 then
                        v78._farSeconds = 0
                    else
                        v78._farSeconds = 0
                        v78._farRequiredSeconds = v78._random:NextNumber(105, 180)
                        local v82 = v78:_ownerRootPosition()
                        if v82 ~= nil and AssetWanderArea.IsPositionInside(v78._assetArea, v82) then
                            v78:_tryStartReturnGreeting(v82, true)
                        end
                    end
                end
            end
        end
    end
end

local function _updateGreeting(v83, v84) -- line 423
    local v85 = v83._phase == "GreetingOrbit"
    local v86, v87
    if v85 then
        local v88 = v83:_distanceFromLocalPlayerToAreaCenter()
        if v88 == nil then
            local v89 = v83._greetRemaining - v84
            v83._greetRemaining = math.max(v89, 0)
            if v83._phase == "GreetingOrbit" then
                if v83._greetRemaining <= 0 then
                    v83:_beginGreetingFinish()
                elseif v83._random:NextNumber() < v83._config.Greeting.JumpChancePerSecond * v84 then
                    v83:_startJump()
                end
            else
                local v90 = v83._finishJumpCooldown - v84
                v83._finishJumpCooldown = math.max(v90, 0)
                if v83._finishJumpsRemaining > 0 and v83._finishJumpCooldown <= 0 then
                    v83:_startJump(0)
                    v83._finishJumpsRemaining -= 1
                    v83._finishJumpCooldown = 0.6
                end
                if v83._finishJumpsRemaining <= 0 and v83._jumpRemaining <= 0 and v83._greetRemaining <= 0 then
                    v83._phase = "Normal"
                    v83:_resetGreetingFinish()
                    v83:_resetReturnGreeting()
                    v83:_resetAffection()
                    v83:_chooseNextDestination()
                end
            end
            return
        end
        v86 = v88 > 300
    else
        v87 = v83._phase == "GreetingFinish"
    end
    if v85 and not v86 or not v85 and v87 or not v85 then
        return
    end
    v83._phase = "Normal"
    v83._greetRemaining = 0
    v83:_resetGreetingFinish()
    v83:_resetReturnGreeting()
    v83:_resetAffection()
    v83:_chooseNextDestination()
end

v2._updateGreeting = _updateGreeting

function v2._stepReturnGreeting(v91, v92, v93, v94) -- line 466 | captures: AssetWanderArea, AssetWanderMotion
    if v91._phase == "ReturnGreetingApproach" then
        local _returnGreetingOwnerOffset = v91._returnGreetingOwnerOffset
        local v95 = _returnGreetingOwnerOffset ~= nil
        assert(v95, "Return greeting approach requires a stable owner offset")
        v91._destination = AssetWanderArea.PointNearOwner(v91._assetArea, v94, _returnGreetingOwnerOffset)
        local v96, v97, v98 = AssetWanderMotion.StepMoveToward(v92, v93, v91._destination, v91._walkSpeed)
        local v99 = v91._destination.X - v96.Position.X
        local v100 = v91._destination.Z - v96.Position.Z
        if Vector3.new(v99, 0, v100).Magnitude > 2.25 then
            local v101, v102 = v91:_applyJump(v92, v96)
            return v101, v97 or v91._jumpRemaining > 0, v102, v98
        end
        v91._phase = "ReturnGreetingHold"
        v91._returnGreetingJumpCooldown = 0
        if v91._returnGreetingJumpsRemaining > 0 then
            v91:_startJump(0)
            v91._returnGreetingJumpsRemaining -= 1
            v91._returnGreetingJumpCooldown = 0.6
        end
        local v103, v104 = v91:_applyJump(v92, (AssetWanderMotion.FaceOwnerCFrame(v96, v94, v92, true)))
        return v103, v97 or v91._jumpRemaining > 0, v104, v98
    end
    local v105 = v91._returnGreetingHoldRemaining - v92
    v91._returnGreetingHoldRemaining = math.max(v105, 0)
    local v106 = v91._returnGreetingJumpCooldown - v92
    v91._returnGreetingJumpCooldown = math.max(v106, 0)
    if v91._returnGreetingJumpsRemaining > 0 and v91._returnGreetingJumpCooldown <= 0 then
        v91:_startJump(0)
        v91._returnGreetingJumpsRemaining -= 1
        v91._returnGreetingJumpCooldown = 0.6
    end
    local v107, v108 = v91:_applyJump(v92, (AssetWanderMotion.FaceOwnerCFrame(v93, v94, v92)))
    if v91._returnGreetingHoldRemaining <= 0 and v91._returnGreetingJumpsRemaining <= 0 and v91._jumpRemaining <= 0 then
        v91._phase = "Normal"
        v91:_resetReturnGreeting()
        v91:_chooseNextDestination()
    end
    return v107, v91._jumpRemaining > 0, v108, v91._walkSpeed
end

function v2._stepAffection(v109, v110, v111, v112) -- line 515 | captures: AssetPersonalityMotion, AssetWanderArea, AssetWanderMotion
    if v109._phase == "AffectionApproach" then
        local _affectionOwnerOffset = v109._affectionOwnerOffset
        local v113 = _affectionOwnerOffset ~= nil
        assert(v113, "Affection approach requires a stable owner offset")
        v109._destination = AssetWanderArea.PointNearOwner(v109._assetArea, v112, _affectionOwnerOffset)
        local v114, v115, v116 = AssetWanderMotion.StepMoveToward(v110, v111, v109._destination, v109._walkSpeed)
        local v117 = v109._destination.X - v114.Position.X
        local v118 = v109._destination.Z - v114.Position.Z
        if Vector3.new(v117, 0, v118).Magnitude > 2.25 then
            local v119, v120 = v109:_applyJump(v110, v114)
            return v119, v115 or v109._jumpRemaining > 0, v120, v116
        end
        v109._phase = "AffectionHold"
        v109._affectionJumpCooldown = 0.6
        v109._pendingBubbleText = AssetPersonalityMotion.RandomConfiguredText(v109._random, v109._config.Affection.Texts, v109._config._id, "affection")
        if v109._affectionJumpsRemaining > 0 then
            v109:_startJump(0)
            v109._affectionJumpsRemaining -= 1
        end
        local v121, v122 = v109:_applyJump(v110, (AssetWanderMotion.FaceOwnerCFrame(v114, v112, v110, true)))
        return v121, v115 or v109._jumpRemaining > 0, v122, v116
    end
    local v123 = v109._affectionHoldRemaining - v110
    v109._affectionHoldRemaining = math.max(v123, 0)
    local v124 = v109._affectionJumpCooldown - v110
    v109._affectionJumpCooldown = math.max(v124, 0)
    if v109._affectionJumpsRemaining > 0 and v109._affectionJumpCooldown <= 0 then
        v109:_startJump(0)
        v109._affectionJumpsRemaining -= 1
        v109._affectionJumpCooldown = 0.6
    end
    local v125, v126 = v109:_applyJump(v110, (AssetWanderMotion.FaceOwnerCFrame(v111, v112, v110)))
    if v109._affectionHoldRemaining <= 0 and v109._affectionJumpsRemaining <= 0 and v109._jumpRemaining <= 0 then
        v109._phase = "Normal"
        v109:_resetAffection()
        v109:_chooseNextDestination()
    end
    return v125, v109._jumpRemaining > 0, v126, v109._walkSpeed
end

function v2._updateCurve(v127, v128, v129) -- line 564 | captures: AssetWanderArea
    v127._curveChangeElapsed += v128
    if v127._nextCurveChangeSeconds <= v127._curveChangeElapsed then
        v127._curveChangeElapsed = 0
        v127._nextCurveChangeSeconds = v127._random:NextNumber(5, 10)
        v127._curveAngle = v127._random:NextNumber(-3.141592653589793, 3.141592653589793)
        v127._curveRotationSpeed = v127._random:NextNumber(-0.8, 0.8)
    end
    v127._curveAngle += v127._curveRotationSpeed * v128
    local _curveAngle = v127._curveAngle
    local v130 = math.cos(_curveAngle)
    local _curveAngle_2 = v127._curveAngle
    local v131 = math.sin(_curveAngle_2)
    local v132 = v129 + Vector3.new(v130, 0, v131) * 9
    v127._destination = AssetWanderArea.ClampedPointToward(v127._assetArea, v132)
end

function v2._orbitGreetingCFrame(v133, v134, v135, v136) -- line 577 | captures: AssetWanderMotion
    local v137, v138 = AssetWanderMotion.OwnerMoveVector(v134, v136, v133._lastOwnerPosition)
    v133._lastOwnerPosition = v138
    return AssetWanderMotion.OrbitGreetingCFrame(v133._assetArea, v134, v135, v136, v137, v133._greetingOrbitRadius, 22, 0.75)
end

local function _applyJump(v139, v140, v141) -- line 583
    if v139._jumpRemaining <= 0 then
        return v141, true
    end
    local v142 = v139._jumpRemaining - v140
    v139._jumpRemaining = math.max(v142, 0)
    local v143 = v139._jumpElapsed + v140
    v139._jumpElapsed = math.min(v143, 0.45)
    local v144 = v139._jumpElapsed / 0.45
    local v145 = v144 * 3.141592653589793
    math.sin(v145)
    local v146 = if v139._spinYaw == 0 then 0 else v139._spinYaw * v144
    local v147 = v146 - v139._spinAppliedYaw
    v139._spinAppliedYaw = v146
    local new = CFrame.new
    local Position = v141.Position
    local v148 = v146 * v139._jumpHeight
    local v149 = new(Position + Vector3.new(0, v148, 0)) * v141.Rotation
    if v147 ~= 0 then
        v149 *= CFrame.Angles(0, v147, 0)
    end
    if v139._jumpRemaining <= 0 then
        v139._spinAppliedYaw = 0
    end
    return v149, v139._jumpRemaining <= 0
end

v2._applyJump = _applyJump

function v2.SetAssetArea(v150, v151) -- line 609 | captures: t, AssetPersonalityMotion
    t.strict(t.instanceIsA("BasePart"))(v151)
    local v152 = v150._assetArea ~= v151
    v150._assetArea = v151
    if v152 then
        v150._loyalOwnerOffset = AssetPersonalityMotion.RandomOwnerOffset(v151, v150._random, v150._greetingOrbitRadius)
        if v150._returnGreetingOwnerOffset == nil then
            v150._returnGreetingOwnerOffset = nil
        else
            v150._returnGreetingOwnerOffset = AssetPersonalityMotion.RandomOwnerOffset(v151, v150._random, v150._greetingOrbitRadius)
        end
        if v150._affectionOwnerOffset == nil then
            v150._affectionOwnerOffset = nil
        else
            v150._affectionOwnerOffset = AssetPersonalityMotion.RandomOwnerOffset(v151, v150._random, v150._greetingOrbitRadius)
        end
    end
    v150:_chooseNextDestination()
end

function v2.SetItemData(v153, v154, v155) -- line 632 | captures: AssetItem, Personalities, t
    local v156 = AssetItem.AssetItemData(v154)
    assert(v156, "Invalid asset item data")
    t.strict(t.boolean)(v155)
    v153._itemData = v154
    v153._config = Personalities.GetConfig(v154.Personality)
    if v155 then
        v153:_tryStartFirstPlacementGreeting()
    end
end

function v2.Step(v157, v158, v159) -- line 643 | captures: t, AssetMutationWalkSpeed, AssetWanderArea, AssetWanderMotion
    t.strict(t.number)(v158)
    t.strict(t.CFrame)(v159)
    v157:_updateReturnGreeting(v158)
    v157:_updateGreeting(v158)
    local Position = v159.Position
    local v160 = v157:_ownerRootPosition()
    if v157._phase ~= "Normal" and v160 == nil then
        v157._phase = "Normal"
        v157._greetRemaining = 0
        v157:_resetGreetingFinish()
        v157:_resetReturnGreeting()
        v157:_resetAffection()
        v157:_chooseNextDestination()
    end
    v157:_updateAffectionTrigger(v158, v160)
    v157:_updateOrbitGreetingTrigger(v158, v160)
    local v161
    if v157._phase ~= "Normal" or v160 == nil then
        v161 = false
    else
        v161 = v157:_tryRetreatFromOwner(Position, v160)
    end
    if v157._phase == "Normal" then
        v157:_tryAmbientJump(v158)
    end
    if v157._idleRemaining <= 0 then
        if v157._phase == "GreetingOrbit" then
            if v160 ~= nil then
                local v162, v163, v164 = v157:_orbitGreetingCFrame(v158, v159, v160)
                local v165, v166 = v157:_applyJump(v158, v162)
                return v165, v163 or v157._jumpRemaining > 0, v166, v164, true, v157:_popBubbleText()
            end
        elseif v157._phase == "GreetingFinish" then
            if v160 ~= nil then
                local v167, v168 = v157:_applyJump(v158, (AssetWanderMotion.FaceOwnerCFrame(v159, v160, v158)))
                return v167, v157._jumpRemaining > 0, v168, v157._walkSpeed, true, v157:_popBubbleText()
            end
        elseif v157._phase == "ReturnGreetingApproach" or v157._phase == "ReturnGreetingHold" then
            if v160 ~= nil then
                local v169, v170, v171, v172 = v157:_stepReturnGreeting(v158, v159, v160)
                return v169, v170, v171, v172, false, v157:_popBubbleText()
            end
        elseif (v157._phase == "AffectionApproach" or v157._phase == "AffectionHold") and v160 ~= nil then
            local v173, v174, v175, v176 = v157:_stepAffection(v158, v159, v160)
            return v173, v174, v175, v176, false, v157:_popBubbleText()
        end
        if v157._config.Movement.FollowOwnerInPen then
            local v177, v178, v179, v180, v181
            if v160 == nil then
                v181 = true
            elseif AssetWanderArea.IsPositionInside(v157._assetArea, v160) then
                local v182, v183
                v182, v183, v177 = AssetWanderMotion.StepFollowOwner(v157._assetArea, v158, v159, v160, v157._loyalOwnerOffset, v157._walkSpeed, 2.25)
                v178, v179 = v157:_applyJump(v158, v182)
                v180 = v183 or v157._jumpRemaining > 0
                v181 = false
            else
                v181 = true
            end
            if not v181 then
                return v178, v180, v179, v177, false, v157:_popBubbleText()
            end
        else
            if v157._mode == "Curve" then
                v157:_updateCurve(v158, v159.Position)
            end
            local _destination = v157._destination
            local v184 = _destination - Position
            local X = v184.X
            local Z = v184.Z
            if Vector3.new(X, 0, Z).Magnitude > 0.35 then
                local _walkSpeed = v157._walkSpeed
                if v157._random:NextNumber() < v157._config.Movement.BurstChance * v158 then
                    _walkSpeed = v157._config.Movement.WalkSpeedMax * 1.25 * AssetMutationWalkSpeed.GetMultiplier(v157._itemData)
                    v157:_startJump()
                end
                local v185, v186, v187 = AssetWanderMotion.StepMoveToward(v158, v159, _destination, _walkSpeed)
                local v188, v189 = v157:_applyJump(v158, v185)
                return v188, v186 or v157._jumpRemaining > 0, v189, v187, false, v157:_popBubbleText()
            end
            if not v161 then
                v157:_beginIdle(v159)
                v157:_chooseNextDestination()
                local v190, v191 = v157:_applyJump(v158, v159)
                return v190, v157._jumpRemaining > 0, v191, v157._walkSpeed, false, v157:_popBubbleText()
            end
        end
    elseif v157._phase == "Normal" then
        local v192, v193 = v157:_stepIdle(v158)
        return v192, v157._jumpRemaining > 0, v193, 0, false, v157:_popBubbleText()
    end
end

return v2
