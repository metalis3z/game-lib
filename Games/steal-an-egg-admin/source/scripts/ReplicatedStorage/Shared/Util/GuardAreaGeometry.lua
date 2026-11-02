-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.strict(t.Instance)
local v2 = t.strict(t.instanceIsA("BasePart"))
local v3 = t.strict(t.Vector3)
local v4 = {}

local function depthPast(v5, v6) -- line 12
    return v5.CFrame.LookVector:Dot(v6 - v5.Position)
end

local function checkStep(v7, v8, v9) -- line 15 | captures: v2, v3
    v2(v7)
    v3(v8)
    v3(v9)
end

function v4.SignedDistanceToLine(v10, v11) -- line 20 | captures: v2, v3, depthPast
    v2(v10)
    v3(v11)
    return depthPast(v10, v11)
end

function v4.IsPastLine(v12, v13) -- line 25 | captures: v2, v3
    v2(v12)
    v3(v13)
    return v12.CFrame.LookVector:Dot(v13 - v12.Position) > 0
end

function v4.CrossedLineInward(v14, v15, v16) -- line 32 | captures: v2, v3
    v2(v14)
    v3(v15)
    v3(v16)
    if v14.CFrame.LookVector:Dot(v15 - v14.Position) <= 0 then
        return v14.CFrame.LookVector:Dot(v16 - v14.Position) > 0
    end
    return false
end

function v4.CrossedLineOutward(v17, v18, v19) -- line 44 | captures: v2, v3
    v2(v17)
    v3(v18)
    v3(v19)
    if v17.CFrame.LookVector:Dot(v18 - v17.Position) > 0 then
        return v17.CFrame.LookVector:Dot(v19 - v17.Position) <= 0
    end
    return false
end

function v4.IsWithinFootprint(v20, v21) -- line 56 | captures: v2, v3
    v2(v20)
    v3(v21)
    local v22 = v20.CFrame:PointToObjectSpace(v21)
    local v23 = v20.Size * 0.5
    local X = v22.X
    if math.abs(X) <= v23.X then
        local Z = v22.Z
        return math.abs(Z) <= v23.Z
    end
    return false
end

function v4.ReadAreaBounds(v24) -- line 69 | captures: v1
    v1(v24)
    local Folder = v24:IsA("Folder")
    assert(Folder, "Guard areas have to be collected under a single Folder")
    local v25 = {}
    for v26, v27 in ipairs(v24:GetChildren()) do
        local Model = v27:IsA("Model")
        local v28 = ("%* sits under GuardAreas but is not a Model"):format((v27:GetFullName()))
        assert(Model, v28)
        local Bounds = v27.Bounds
        local BasePart = Bounds:IsA("BasePart")
        local v29 = ("%* has a Bounds child that is not a part"):format((v27:GetFullName()))
        assert(BasePart, v29)
        local v30 = {
            AreaId = v27.Name,
            Bounds = Bounds
        }
        table.insert(v25, v30)
    end
    local v31 = #v25 > 0
    assert(v31, "GuardAreas is empty; the game needs at least one guard area")
    return v25
end

return v4
