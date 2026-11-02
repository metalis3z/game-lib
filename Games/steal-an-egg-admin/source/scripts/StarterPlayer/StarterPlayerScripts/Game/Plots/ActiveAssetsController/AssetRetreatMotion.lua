-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetWanderArea = require(script.Parent.AssetWanderArea)
require(ReplicatedStorage.Data.Assets)
local v1 = table.freeze({
    0,
    0.6108652381980153,
    -0.6108652381980153,
    1.2217304763960306,
    -1.2217304763960306,
    1.8325957145940461,
    -1.8325957145940461,
    2.443460952792061,
    -2.443460952792061,
    3.141592653589793
})
local v2 = {}

local function rotateLocalFlatDirection(v3, v4) -- line 22
    local v5 = math.cos(v4)
    local v6 = math.sin(v4)
    local v7 = v3.X * v5 - v3.Z * v6
    local v8 = v3.X * v6 + v3.Z * v5
    return (Vector3.new(v7, 0, v8))
end

local function distanceToAreaEdge(v9, v10, v11) -- line 29 | captures: AssetWanderArea
    local v12, v13 = AssetWanderArea.HalfExtents(v9)
    local v14
    if v11.X > 0 then
        v14 = (v12 - v10.X) / v11.X
    elseif v11.X < 0 then
        v14 = (-v12 - v10.X) / v11.X
    else
        v14 = (1/0)
    end
    local v15
    if v11.Z > 0 then
        v15 = (v13 - v10.Z) / v11.Z
    elseif v11.Z < 0 then
        v15 = (-v13 - v10.Z) / v11.Z
    else
        v15 = (1/0)
    end
    local v16 = math.min(v14, v15) - 2
    return (math.max(v16, 0))
end

local function ownerAwayDirection(v17, v18, v19) -- line 47
    local v20 = v19.X - v18.X
    local v21 = v19.Z - v18.Z
    local v22 = Vector3.new(v20, 0, v21)
    if v22.Magnitude > 0 then
        return v22.Unit
    end
    local v23 = v19.X - v17.Position.X
    local v24 = v19.Z - v17.Position.Z
    local v25 = Vector3.new(v23, 0, v24)
    if v25.Magnitude > 0 then
        return v25.Unit
    end
    local LookVector = v17.CFrame.LookVector
    local X = LookVector.X
    local Z = LookVector.Z
    local v26 = Vector3.new(X, 0, Z)
    local v27 = v26.Magnitude > 0
    assert(v27, "Asset area must provide a horizontal retreat direction")
    return v26.Unit
end

function v2.Destination(v28, v29, v30, v31, v32) -- line 63 | captures: AssetWanderArea, v1, distanceToAreaEdge, ownerAwayDirection
    local v33 = v28.CFrame:PointToObjectSpace(v32)
    local v34 = ownerAwayDirection(v28, v31, v32)
    local v35 = v28.CFrame:VectorToObjectSpace(v34)
    local X = v35.X
    local Z = v35.Z
    local v36 = Vector3.new(X, 0, Z)
    local v37 = v36.Magnitude > 0
    assert(v37, "Retreat direction must be horizontal")
    local Unit = v36.Unit
    local Unit_2 = Unit
    local v38 = 0
    local v39 = (-1/0)
    for v40, v41 in ipairs(v1) do
        local v42 = math.cos(v41)
        local v43 = math.sin(v41)
        local v44 = Unit.X * v42 - Unit.Z * v43
        local v45 = Unit.X * v43 + Unit.Z * v42
        local Unit_3 = Vector3.new(v44, 0, v45).Unit
        local v46 = distanceToAreaEdge(v28, v33, Unit_3)
        local v47 = Unit_3:Dot(Unit)
        local v48 = v46 * (math.max(v47, 0) + 0.6)
        if v39 < v48 then
            Unit_2 = Unit_3
            v38 = v46
            v39 = v48
        end
    end
    if v38 <= 0 then
        return AssetWanderArea.RandomPoint(v28, v29)
    end
    if v30.MaxTravelDistance ~= nil then
        local MaxTravelDistance = v30.MaxTravelDistance
        v38 = math.min(MaxTravelDistance, v38)
    end
    local v49 = v33 + Unit_2 * v38
    return (v28.CFrame * CFrame.new(v49.X, 0, v49.Z)).Position
end

return v2
