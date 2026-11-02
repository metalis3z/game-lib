-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Player = require(ReplicatedStorage.Shared.Player)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    Vector3.new(-1, -1, -1),
    Vector3.new(1, -1, -1),
    Vector3.new(-1, 1, -1),
    Vector3.new(1, 1, -1),
    Vector3.new(-1, -1, 1),
    Vector3.new(1, -1, 1),
    Vector3.new(-1, 1, 1),
    (Vector3.new(1, 1, 1))
}
local v2 = {}

local function visibleParts(v3) -- line 22
    local v4 = {}
    for v5, v6 in v3:GetDescendants() do
        if v6:IsA("BasePart") and v6.Transparency < 1 then
            table.insert(v4, v6)
        end
    end
    return v4
end

local function requireModelOrTool(v7) -- line 31
    local v8 = if typeof(v7) == "Instance" then v7:IsA("Model") or v7:IsA("Tool") else false
    assert(v8, "a bounding box needs a Model or a Tool")
end

function v2.Bounds(v9, v10) -- line 41 | captures: t, v1
    t.strict(t.table)(v9)
    local v11 = #v9 > 0
    assert(v11, "a bounding box needs at least one part")
    local v12 = v10 or CFrame.identity
    local v13, v14 = Vector3.new(1, 1, 1) * (1/0), Vector3.new(1, 1, 1) * (-1/0)
    for v15, v16 in ipairs(v9) do
        if v16:IsA("BasePart") then
            local v17 = v13
            local v18 = v14
            for v19, v20 in v1 do
                local v21 = v12:PointToObjectSpace(v16.CFrame * (v16.Size * 0.5 * v20))
                v17, v18 = v17:Min(v21), v18:Max(v21)
                v13 = v17
                v14 = v18
            end
        end
    end
    return v12 * CFrame.new((v13 + v14) * 0.5), v14 - v13
end

function v2.VisibleBounds(v22) -- line 68 | captures: v2, visibleParts
    local v23 = if typeof(v22) == "Instance" then v22:IsA("Model") or v22:IsA("Tool") else false
    assert(v23, "a bounding box needs a Model or a Tool")
    local v24 = visibleParts(v22)
    if #v24 == 0 then
        return v22:GetPivot(), (Vector3.new(0, 0, 0))
    end
    return v2.Bounds(v24)
end

function v2.ModelBounds(v25) -- line 84 | captures: v2, visibleParts
    local v26 = if typeof(v25) == "Instance" then v25:IsA("Model") or v25:IsA("Tool") else false
    assert(v26, "a bounding box needs a Model or a Tool")
    local v27 = v25:FindFirstChild("CustomBoundingBox", true)
    if v27 then
        if v27:IsA("BasePart") then
            return v27.CFrame, v27.Size
        end
        local v28 = visibleParts(v25)
        local v29 = v25:GetPivot()
        if #v28 == 0 then
            return v29, (Vector3.new(0, 0, 0))
        end
        return v2.Bounds(v28, v29 - v29.Position)
    end
    local v30 = visibleParts(v25)
    local v31 = v25:GetPivot()
    if #v30 == 0 then
        return v31, (Vector3.new(0, 0, 0))
    end
    return v2.Bounds(v30, v31 - v31.Position)
end

function v2.ContainsPoint(v32, v33, v34) -- line 113 | captures: t
    t.strict(t.CFrame)(v32)
    t.strict(t.Vector3)(v33)
    t.strict(t.Vector3)(v34)
    local v35 = v32:PointToObjectSpace(v34)
    local v36 = v33 * 0.5
    local X = v35.X
    if math.abs(X) <= v36.X then
        local Y = v35.Y
        if math.abs(Y) <= v36.Y then
            local Z = v35.Z
            return math.abs(Z) <= v36.Z
        end
    end
    return false
end

local function DominantUpAxis(v37) -- line 134
    local Y = v37.RightVector.Y
    local v38 = math.abs(Y)
    local Y_2 = v37.UpVector.Y
    local v39 = math.abs(Y_2)
    local Y_3 = v37.LookVector.Y
    local v40 = math.abs(Y_3)
    if not (v39 < v38) and v40 <= v39 then
        return (Vector3.new(0, 1, 0))
    end
    if v40 <= v38 then
        return (Vector3.new(1, 0, 0))
    end
    return (Vector3.new(0, 0, 1))
end

v2.DominantUpAxis = DominantUpAxis

function v2.ScreenSpaceVolume(v41, v42) -- line 152 | captures: Workspace
    local CurrentCamera = Workspace.CurrentCamera
    local ViewportSize = CurrentCamera.ViewportSize
    local FieldOfView = CurrentCamera.FieldOfView
    local v43 = math.rad(FieldOfView) * 0.5
    local v44 = math.tan(v43)
    local v45 = CurrentCamera:ViewportPointToRay(ViewportSize.X * 0.5, ViewportSize.Y * 0.5, v41 - v42 * 0.5)
    local v46 = CFrame.lookAt(Vector3.new(0, 0, 0), v45.Direction)
    local v47 = v41 * 2 * (v44 * ViewportSize.X / ViewportSize.Y)
    local v48 = v41 * 2 * v44
    return v46 + v45.Origin, (Vector3.new(v47, v48, v42))
end

local function toPoint(v49) -- line 162
    if typeof(v49) == "CFrame" then
        return v49.Position
    end
    if typeof(v49) == "Instance" and v49.ClassName == "Model" then
        return v49:GetPivot().Position
    end
    return v49
end

local function characterPoint(v50) -- line 174 | captures: Players, Player
    local v51 = v50 or Players.LocalPlayer
    local v52 = Player.Optional.Humanoid(v51)
    local v53 = v52 and v52.RootPart
    return v53 and v53.Position
end

function v2.Between(v54, v55) -- line 190 | captures: Players, Player
    local v56
    if v54 then
        if typeof(v54) == "Instance" then
            if v54:IsA("Player") then
            end
        elseif typeof(v54) == "CFrame" then
            v56 = v54.Position
        elseif typeof(v54) == "Instance" and v54.ClassName == "Model" then
            v56 = v54:GetPivot().Position
        else
            v56 = v54
        end
    else
        local LocalPlayer = Players.LocalPlayer
        local v57 = Player.Optional.Humanoid(LocalPlayer)
        local v58 = v57 and v57.RootPart
        v56 = v58 and v58.Position
    end
    if v56 then
        local v59
        if typeof(v55) == "Instance" then
            if v55:IsA("Player") then
                local v60 = v55 or Players.LocalPlayer
                local v61 = Player.Optional.Humanoid(v60)
                local v62 = v61 and v61.RootPart
                v59 = v62 and v62.Position
            end
        elseif typeof(v55) == "CFrame" then
            v59 = v55.Position
        elseif typeof(v55) == "Instance" and v55.ClassName == "Model" then
            v59 = v55:GetPivot().Position
        else
            v59 = v55
        end
        if v59 and typeof(v56) == "Vector3" and typeof(v59) == "Vector3" then
            return (v56 - v59).Magnitude
        end
    end
    return nil
end

function v2.ProximityGate(v63, v64, v65) -- line 254 | captures: Workspace
    local v66
    if typeof(v63) == "Instance" then
        v66 = v63:IsA("PVInstance")
    else
        v66 = false
    end
    assert(v66)
    local v67 = if v64 == nil then true else type(v64) == "number"
    assert(v67)
    local v68 = if v65 == nil then true else type(v65) == "number"
    assert(v68)
    local v69 = v65 or 3
    local v70 = Vector3.new(0, 0, 0)
    if v63:IsA("Model") then
        local v71
        v71, v70 = v63:GetBoundingBox()
        _ = v71
    elseif v63:IsA("BasePart") then
        v70 = v63.Size
    end
    local v72 = v70 * 0.5 + Vector3.new(1, 1, 1) * (v64 or 300)
    local v73 = (-1/0)
    local v74 = false
    return function() -- line 274 | captures: v73, v74, v63, v69, v72, Workspace
        local v75 = os.clock()
        if v73 <= v75 then
            v73 = v75 + v69 * (0.5 + math.random())
            local v76 = v63:GetPivot():PointToObjectSpace(Workspace.CurrentCamera.CFrame.Position)
            local X = v76.X
            if math.abs(X) <= v72.X then
                local Y = v76.Y
                if math.abs(Y) <= v72.Y then
                    local Z = v76.Z
                    v74 = math.abs(Z) <= v72.Z
                else
                    v74 = false
                end
            else
                v74 = false
            end
        end
        return v74
    end
end

return table.freeze(v2)
