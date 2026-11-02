-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuardChasePolicy = require(script.Parent.GuardChasePolicy)
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.Types.Interface)
local v1 = {}

local function resolveHorizontalDirection(v2) -- line 11
    local X = v2.X
    local Z = v2.Z
    local v3 = Vector3.new(X, 0, Z)
    local v4 = v3.Magnitude > 0.000001
    assert(v4)
    return v3.Unit
end

local function resolveAtSpeed(v5, v6) -- line 17 | captures: GuardChasePolicy
    if v6 == 0 then
        return {
            ExitTime = (1/0),
            Outcome = "Caught",
            CatchTime = GuardChasePolicy.GetWakingDuration()
        }
    end
    local v7 = v5.ExitDistance / v6
    local v8 = GuardChasePolicy.GetWakingDuration()
    if v7 <= v8 then
        return {
            Outcome = "EscapedSafely",
            ExitTime = v7
        }
    end
    local ExitDirection = v5.ExitDirection
    local X = ExitDirection.X
    local Z = ExitDirection.Z
    local v9 = Vector3.new(X, 0, Z)
    local v10 = v9.Magnitude > 0.000001
    assert(v10)
    local v11 = (v5.PlayerStartPosition - v5.GuardStartPosition):Dot(v9.Unit) + v6 * v8
    if v11 <= v5.HitDistance then
        return {
            Outcome = "Caught",
            CatchTime = v8,
            ExitTime = v7
        }
    end
    local v12 = GuardChasePolicy.ResolveCatchDuration(v5.BaseGuardWalkSpeed, v5.FlatRadius, v5.HitDistance, v11, v6)
    local v13
    if v12 == nil then
    else
        v13 = v8 + v12
    end
    local v14 = if v13 == nil then false else v13 < v7
    local v15 = {
        CatchTime = v13,
        ExitTime = v7
    }
    if v14 then
        v15.Outcome = "Caught"
    else
        v15.Outcome = "EscapedSafely"
    end
    return v15
end

function v1.ResolveExitDistance(v16, v17, v18, v19) -- line 52 | captures: t
    t.strict(t.CFrame)(v16)
    t.strict(t.Vector3)(v17)
    t.strict(t.Vector3)(v18)
    t.strict(t.Vector3)(v19)
    local X = v19.X
    local Z = v19.Z
    local v20 = Vector3.new(X, 0, Z)
    local v21 = v20.Magnitude > 0.000001
    assert(v21)
    local Unit = v20.Unit
    local v22 = v16:PointToObjectSpace(v18)
    local v23 = v16:VectorToObjectSpace(Unit)
    local v24 = v17 * 0.5
    local X_2 = v22.X
    local v25 = math.abs(X_2) <= v24.X + 0.000001
    assert(v25)
    local Z_2 = v22.Z
    local v26 = math.abs(Z_2) <= v24.Z + 0.000001
    assert(v26)
    local X_3 = v23.X
    local v27
    if math.abs(X_3) > 0.000001 then
        local v28 = if v23.X <= 0 then -v24.X else v24.X
        v27 = (v28 - v22.X) / v23.X
    else
        v27 = (1/0)
    end
    local Z_3 = v23.Z
    local v29
    if math.abs(Z_3) > 0.000001 then
        local v30 = if v23.Z <= 0 then -v24.Z else v24.Z
        v29 = (v30 - v22.Z) / v23.Z
    else
        v29 = (1/0)
    end
    local v31 = math.min(v27, v29)
    local v32 = if v31 >= 0 then v31 < (1/0) else false
    assert(v32)
    return v31
end

function v1.ResolvePlayerWalkSpeedRequirement(v33, v34) -- line 100 | captures: GuardChasePolicy, t, resolveAtSpeed
    t.strict(t.table)(v33)
    t.strict(t.number)(v34)
    t.strict(t.number)(v33.BaseGuardWalkSpeed)
    t.strict(t.Vector3)(v33.ExitDirection)
    t.strict(t.number)(v33.ExitDistance)
    t.strict(t.number)(v33.FlatRadius)
    t.strict(t.Vector3)(v33.GuardStartPosition)
    t.strict(t.number)(v33.HitDistance)
    t.strict(t.Vector3)(v33.PlayerStartPosition)
    local v35 = v33.BaseGuardWalkSpeed > 0
    assert(v35)
    local v36 = v33.ExitDistance >= 0
    assert(v36)
    local v37 = v33.FlatRadius > 0
    assert(v37)
    local v38 = v33.HitDistance > 0
    assert(v38)
    local v39 = if v34 > 0 then v34 <= 1 else false
    assert(v39)
    if v33.ExitDistance == 0 then
        return 0
    end
    local v40, v41 = 0, v33.ExitDistance / GuardChasePolicy.GetWakingDuration() / v34
    for v42 = 1, 48 do
        local v43 = (v40 + v41) * 0.5
        if resolveAtSpeed(v33, v43 * v34).Outcome == "Caught" then
            v40 = v43
        else
            v41 = v43
        end
    end
    return v41
end

function v1.ResolveGreenPlayerWalkSpeedRequirement(v44) -- line 148 | captures: v1
    return v1.ResolvePlayerWalkSpeedRequirement(v44, 0.6)
end

function v1.ResolveSlowdownTolerance(v45, v46) -- line 151 | captures: t
    t.strict(t.number)(v45)
    t.strict(t.number)(v46)
    local v47 = v45 >= 0
    assert(v47)
    local v48 = v46 >= 0
    assert(v48)
    if v45 == 0 then
        return 1
    end
    if v46 == 0 then
        return -1
    end
    return 1 - v45 / v46
end

function v1.Resolve(v49) -- line 168 | captures: t, resolveAtSpeed
    t.strict(t.table)(v49)
    t.strict(t.number)(v49.BaseGuardWalkSpeed)
    t.strict(t.Vector3)(v49.ExitDirection)
    t.strict(t.number)(v49.ExitDistance)
    t.strict(t.number)(v49.FlatRadius)
    t.strict(t.Vector3)(v49.GuardStartPosition)
    t.strict(t.number)(v49.HitDistance)
    t.strict(t.number)(v49.PlayerWalkSpeed)
    t.strict(t.Vector3)(v49.PlayerStartPosition)
    local v50 = v49.BaseGuardWalkSpeed > 0
    assert(v50)
    local v51 = v49.ExitDistance >= 0
    assert(v51)
    local v52 = v49.FlatRadius > 0
    assert(v52)
    local v53 = v49.HitDistance > 0
    assert(v53)
    local v54 = v49.PlayerWalkSpeed >= 0
    assert(v54)
    local v55 = resolveAtSpeed(v49, v49.PlayerWalkSpeed)
    if v55.Outcome == "Caught" then
        return v55
    end
    local v56 = resolveAtSpeed(v49, v49.PlayerWalkSpeed * 0.6)
    local v57 = {
        CatchTime = v55.CatchTime,
        ExitTime = v55.ExitTime
    }
    if v56.Outcome == "Caught" then
        v57.Outcome = "EscapedAtRisk"
    else
        v57.Outcome = "EscapedSafely"
    end
    return v57
end

return v1
