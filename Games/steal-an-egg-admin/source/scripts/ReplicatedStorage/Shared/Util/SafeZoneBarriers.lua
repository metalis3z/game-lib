-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CaptureTheEgg = require(ReplicatedStorage.Data.CaptureTheEgg)
local GuardAreaGeometry = require(script.Parent.GuardAreaGeometry)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.strict(t.Vector3)
local v2 = t.strict(t.number)
local v3 = t.strict(t.boolean)
local v4 = t.strict(t.string)
local Areas
local v5 = {}

local function areasFolder() -- line 14 | captures: Areas, Workspace
    local Areas_2 = Areas
    if Areas_2 == nil then
        local __OBJECTS = Workspace:FindFirstChild("__OBJECTS")
        local v6 = __OBJECTS ~= nil
        assert(v6, "Workspace.__OBJECTS is missing")
        local Areas_2 = __OBJECTS:FindFirstChild("Areas")
        local v7
        if Areas_2 == nil then
            v7 = false
        else
            v7 = Areas_2:IsA("Folder")
        end
        assert(v7, "Workspace.__OBJECTS.Areas must be a Folder")
        Areas = Areas_2
        return Areas_2
    end
    if Areas_2.Parent == nil then
        return
    end
    return Areas_2
end

local function areaPart(v8) -- line 29 | captures: areasFolder
    local v9 = areasFolder():FindFirstChild(v8)
    local v10
    if v9 == nil then
        v10 = false
    else
        v10 = v9:IsA("BasePart")
    end
    local v11 = ("Workspace.__OBJECTS.Areas.%* must be a BasePart"):format(v8)
    assert(v10, v11)
    return v9
end

local function readBox(v12) -- line 35
    return {
        CFrame = v12.CFrame,
        HalfSize = v12.Size * 0.5
    }
end

local function depth(v13) -- line 38 | captures: GuardAreaGeometry, areasFolder
    local SeparationLine = areasFolder():FindFirstChild("SeparationLine")
    local v14
    if SeparationLine == nil then
        v14 = false
    else
        v14 = SeparationLine:IsA("BasePart")
    end
    assert(v14, "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")
    return GuardAreaGeometry.SignedDistanceToLine(SeparationLine, v13)
end

local function barrierBoxes(v15) -- line 44 | captures: ReplicatedStorage, areasFolder
    local v16 = {}
    local WallStartCollision = areasFolder():FindFirstChild("WallStartCollision")
    local v17
    if WallStartCollision == nil then
        v17 = false
    else
        v17 = WallStartCollision:IsA("BasePart")
    end
    assert(v17, "Workspace.__OBJECTS.Areas.WallStartCollision must be a BasePart")
    v16[1] = {
        CFrame = WallStartCollision.CFrame,
        HalfSize = WallStartCollision.Size * 0.5
    }
    if v15 then
        local SpawnLock = ReplicatedStorage.Assets:FindFirstChild("SpawnLock")
        if SpawnLock ~= nil then
            if SpawnLock:IsA("BasePart") then
                local v18 = {
                    CFrame = SpawnLock.CFrame,
                    HalfSize = SpawnLock.Size * 0.5
                }
                table.insert(v16, v18)
            end
            for v19, v20 in SpawnLock:GetDescendants() do
                if v20:IsA("BasePart") then
                    local v21 = {
                        CFrame = v20.CFrame,
                        HalfSize = v20.Size * 0.5
                    }
                    table.insert(v16, v21)
                end
            end
        end
    end
    return v16
end

local function projectedHalfExtent(v22, v23) -- line 68
    local v24 = v23:Dot(v22.CFrame.XVector)
    local v25 = math.abs(v24) * v22.HalfSize.X
    local v26 = v23:Dot(v22.CFrame.YVector)
    local v27 = v25 + math.abs(v26) * v22.HalfSize.Y
    local v28 = v23:Dot(v22.CFrame.ZVector)
    return v27 + math.abs(v28) * v22.HalfSize.Z
end

local function boxIntrusion(v29, v30, v31, v32) -- line 76 | captures: GuardAreaGeometry, areasFolder, projectedHalfExtent
    local v33 = v29.CFrame:PointToObjectSpace(v30)
    local v34 = v29.HalfSize + Vector3.new(1, 1, 1) * v31
    local X = v33.X
    local v35 = math.abs(X)
    if not (v34.X < v35) then
        local Y = v33.Y
        local v36 = math.abs(Y)
        if not (v34.Y < v36) then
            local Z = v33.Z
            local v37 = math.abs(Z)
            if not (v34.Z < v37) then
                local SeparationLine = areasFolder():FindFirstChild("SeparationLine")
                local v38
                if SeparationLine == nil then
                    v38 = false
                else
                    v38 = SeparationLine:IsA("BasePart")
                end
                assert(v38, "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")
                local v39 = GuardAreaGeometry.SignedDistanceToLine(SeparationLine, v29.CFrame.Position)
                local SeparationLine_2 = areasFolder():FindFirstChild("SeparationLine")
                local v40
                if SeparationLine_2 == nil then
                    v40 = false
                else
                    v40 = SeparationLine_2:IsA("BasePart")
                end
                assert(v40, "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")
                local v41 = v39 + projectedHalfExtent(v29, v32) + v31 - GuardAreaGeometry.SignedDistanceToLine(SeparationLine_2, v30)
                if v41 > 0 then
                    return v41
                end
            end
        end
    end
    return nil
end

local function segmentHitsBox(v42, v43, v44, v45) -- line 104
    local v46 = v42.CFrame:PointToObjectSpace(v43)
    local v47 = v42.CFrame:PointToObjectSpace(v44) - v46
    local v48 = v42.HalfSize + Vector3.new(1, 1, 1) * v45
    local v49 = {
        v46.X,
        v46.Y,
        v46.Z
    }
    local v50 = {
        v47.X,
        v47.Y,
        v47.Z
    }
    local v51 = {
        v48.X,
        v48.Y,
        v48.Z
    }
    local v52 = 0
    local v53 = 1
    for v54 = 1, 3 do
        local v55 = v49[v54]
        local v56 = v50[v54]
        local v57 = v51[v54]
        if math.abs(v56) >= 0.0001 then
            local v58 = (-v57 - v55) / v56
            local v59 = (v57 - v55) / v56
            if not (v59 < v58) then
                v59, v58 = v58, v59
            end
            v52 = math.max(v52, v59)
            v53 = math.min(v53, v58)
            if v53 < v52 then
                return false
            end
        elseif v57 < math.abs(v55) then
            return false
        end
    end
    return true
end

function v5.IsFencedUid(v60) -- line 140 | captures: Workspace, CaptureTheEgg, v4
    v4(v60)
    return Workspace:GetAttribute(CaptureTheEgg.EggUidAttribute) == v60
end

function v5.Depth(v61) -- line 145 | captures: v1, depth
    v1(v61)
    return depth(v61)
end

function v5.Intrusion(v62, v63, v64, v65) -- line 149 | captures: GuardAreaGeometry, v1, v2, v3, areasFolder, barrierBoxes, boxIntrusion
    v1(v62)
    v2(v63)
    v3(v64)
    v1(v65)
    local v66

    local function consider(v67) -- line 156 | captures: v66
        if v67 ~= nil and (v66 == nil or v66 < v67) then
            v66 = v67
        end
    end

    local SeparationLine = areasFolder():FindFirstChild("SeparationLine")
    local v68
    if SeparationLine == nil then
        v68 = false
    else
        v68 = SeparationLine:IsA("BasePart")
    end
    assert(v68, "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")
    local v69 = v63 - GuardAreaGeometry.SignedDistanceToLine(SeparationLine, v62)
    if v69 <= 0 then
        v69 = nil
    end
    if v69 ~= nil then
        if v66 == nil then
            v66 = v69
        elseif v69 <= v66 then
        end
    end
    for v70, v71 in barrierBoxes(v64) do
        local v72 = boxIntrusion(v71, v62, v63, v65)
        if v72 ~= nil then
            if v66 == nil then
                v66 = v72
            elseif v72 <= v66 then
            end
        end
    end
    return v66
end

function v5.Separates(v73, v74, v75) -- line 192 | captures: GuardAreaGeometry, v1, v3, areasFolder, barrierBoxes, segmentHitsBox
    v1(v73)
    v1(v74)
    v3(v75)
    local SeparationLine = areasFolder():FindFirstChild("SeparationLine")
    local v76
    if SeparationLine == nil then
        v76 = false
    else
        v76 = SeparationLine:IsA("BasePart")
    end
    assert(v76, "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")
    local v77 = GuardAreaGeometry.SignedDistanceToLine(SeparationLine, v73) > 0
    local SeparationLine_2 = areasFolder():FindFirstChild("SeparationLine")
    local v78
    if SeparationLine_2 == nil then
        v78 = false
    else
        v78 = SeparationLine_2:IsA("BasePart")
    end
    assert(v78, "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")
    if v77 == (GuardAreaGeometry.SignedDistanceToLine(SeparationLine_2, v74) > 0) then
        for v79, v80 in barrierBoxes(v75) do
            if segmentHitsBox(v80, v73, v74, 0) then
                return true
            end
        end
        return false
    end
    return true
end

return v5
