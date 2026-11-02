-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local AssetWanderArea = require(script.Parent.AssetWanderArea)
local v1 = {
    YawFromFlatDirection = function(v2) -- YawFromFlatDirection | line 8
        local v3 = -v2.X
        local v4 = -v2.Z
        return (math.atan2(v3, v4))
    end,
    ShortestYawDelta = function(v5, v6) -- ShortestYawDelta | line 12
        local v7 = v6 - v5
        local v8 = math.sin(v7)
        local v9 = math.cos(v7)
        return (math.atan2(v8, v9))
    end
}

function v1.StepYawToward(v10, v11, v12) -- line 18 | captures: v1
    local v13 = v1.ShortestYawDelta(v10, v11)
    local v14 = v12 * 3.839724354387525
    local v15 = -v14
    local v16 = math.clamp(v13, v15, v14)
    return v10 + v16, v16
end

function v1.StepMoveToward(v17, v18, v19, v20) -- line 24 | captures: v1
    local Position = v18.Position
    local v21 = v19 - Position
    local X = v21.X
    local Z = v21.Z
    local v22 = Vector3.new(X, 0, Z)
    local Magnitude = v22.Magnitude
    if Magnitude <= 0 then
        return v18, false, 0
    end
    local v23 = v20 * v17
    local v24 = math.min(Magnitude, v23)
    local Unit = v22.Unit
    local LookVector = v18.LookVector
    local X_2 = LookVector.X
    local Z_2 = LookVector.Z
    local v25 = Vector3.new(X_2, 0, Z_2)
    local v26 = if v25.Magnitude <= 0 then Unit else v25.Unit
    local v27 = v1.YawFromFlatDirection(v26)
    local v28 = v1.YawFromFlatDirection(Unit)
    local v29, v30 = v1.StepYawToward(v27, v28, v17)
    local v31 = v1.ShortestYawDelta(v29, v28)
    local v32 = math.abs(v31)
    local v33 = (math.cos(v32) - 0.2) / 0.8
    local v34 = math.clamp(v33, 0, 1)
    local v35 = CFrame.new(Position + Unit * v24 * v34)
    local v36 = if v34 <= 0 then math.abs(v30) > 0.008726646259971648 else true
    return v35 * CFrame.Angles(0, v29, 0), v36, v20 * v34
end

function v1.FaceOwnerCFrame(v37, v38, v39, v40) -- line 55 | captures: v1
    local Position = v37.Position
    local v41 = v38.X - Position.X
    local v42 = v38.Z - Position.Z
    local v43 = Vector3.new(v41, 0, v42)
    if v43.Magnitude <= 0 then
        return v37
    end
    local LookVector = v37.LookVector
    local X = LookVector.X
    local Z = LookVector.Z
    local v44 = Vector3.new(X, 0, Z)
    local v45 = v44.Magnitude > 0
    assert(v45, "Asset wander CFrame must have a horizontal facing direction")
    local v46 = v1.YawFromFlatDirection(v44.Unit)
    local v47 = v1.YawFromFlatDirection(v43.Unit)
    if v40 ~= true then
        v47 = v1.StepYawToward(v46, v47, v39)
    end
    return CFrame.new(Position) * CFrame.Angles(0, v47, 0)
end

function v1.StepFollowOwner(v48, v49, v50, v51, v52, v53, v54) -- line 76 | captures: AssetWanderArea, v1
    local v55 = AssetWanderArea.PointNearOwner(v48, v51, v52)
    local v56, v57, v58 = v1.StepMoveToward(v49, v50, v55, v53)
    local v59 = v55.X - v56.Position.X
    local v60 = v55.Z - v56.Position.Z
    if Vector3.new(v59, 0, v60).Magnitude <= v54 then
        v56 = v1.FaceOwnerCFrame(v56, v51, v49)
    end
    return v56, v57, v58
end

local function OwnerMoveVector(v61, v62, v63) -- line 86
    if v62 == nil then
        return Vector3.new(0, 0, 0), nil
    end
    if v63 == nil or v61 <= 0 then
        return Vector3.new(0, 0, 0), v62
    end
    local v64 = v62 - v63
    local X = v64.X
    local Z = v64.Z
    return Vector3.new(X, 0, Z) / v61, v62
end

v1.OwnerMoveVector = OwnerMoveVector

function v1.OrbitGreetingCFrame(v65, v66, v67, v68, v69, v70, v71, v72) -- line 97 | captures: AssetWanderArea, v1
    local Position = v67.Position
    local v73 = Position.X - v68.X
    local v74 = Position.Z - v68.Z
    local v75 = Vector3.new(v73, 0, v74)
    local Unit
    if v75.Magnitude == 0 then
        local LookVector = v65.CFrame.LookVector
        local X = LookVector.X
        local Z = LookVector.Z
        local v76 = Vector3.new(X, 0, Z)
        local v77 = v76.Magnitude > 0
        assert(v77, "Asset area must provide a horizontal orbit greeting direction")
        Unit = v76.Unit
    else
        local Unit_2 = v75.Unit
        local v78 = -Unit_2.Z
        local X = Unit_2.X
        local v79 = Vector3.new(v78, 0, X)
        local v80 = (v70 - v75.Magnitude) / v70
        local v81 = -v72
        Unit = (v79 + Unit_2 * math.clamp(v80, v81, v72)).Unit
    end
    local v82 = Unit * v71 + v69
    local X = v82.X
    local Z = v82.Z
    if Vector3.new(X, 0, Z).Magnitude <= 0 then
        return v67, false, 0
    end
    local v83 = AssetWanderArea.ClampedPointToward(v65, Position + v82 * v66)
    local v84 = v83.X - Position.X
    local v85 = v83.Z - Position.Z
    local v86 = Vector3.new(v84, 0, v85)
    if v86.Magnitude <= 0 then
        return v67, false, 0
    end
    return CFrame.new(v83) * CFrame.Angles(0, v1.YawFromFlatDirection(v86.Unit), 0), true, v82.Magnitude
end

return v1
