-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local ModelBounds = require(ReplicatedStorage.Shared.Utils.Spatial).ModelBounds
local Log = require(ReplicatedStorage.Packages.Log)
local Player = require(ReplicatedStorage.Shared.Player)
local FrameStepper = require(ReplicatedStorage.Shared.Utils.FrameStepper)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local v1 = Enum.RenderPriority.Camera.Value + 3
local v2 = {
    sweeping = false,
    blocked = {},
    faceOwner = {},
    probeFrom = {},
    probeSkip = {},
    roster = {}
}

v2.shelved = {}

local v3 = Log.new()
local LocalPlayer = Players.LocalPlayer
local v4 = t.strict(t.instanceIsA("Model"))
local v5 = t.strict(t.number)
local v6 = t.strict(t.boolean)
local v7 = {}

local function repaint(v8, v9) -- line 32 | captures: v2
    local shelved = v2.shelved
    if v9 == nil then
        local v10 = shelved[v8]
        if v10 ~= nil then
            shelved[v8] = nil
            if v8.Parent then
                v8.Transparency = v10
            end
        end
    elseif v8.Transparency < 1 then
        local Transparency = v8.Transparency
        local v11 = shelved[v8]
        if v11 == nil and Transparency < v9 then
            shelved[v8] = Transparency
        else
            Transparency = v11
        end
        if Transparency ~= nil then
            v8.Transparency = math.max(Transparency, v9)
        end
    end
end

local function repaintEntry(v12, v13) -- line 59 | captures: v2
    v12.Faded = v13
    local v14 = if v13 then v12.Target else nil
    for v15 in v12.Faces do
        local shelved = v2.shelved
        if v14 == nil then
            local v16 = shelved[v15]
            if v16 ~= nil then
                shelved[v15] = nil
                if v15.Parent then
                    v15.Transparency = v16
                end
            end
        elseif v15.Transparency < 1 then
            local Transparency = v15.Transparency
            local v17 = shelved[v15]
            if v17 == nil and Transparency < v14 then
                shelved[v15] = Transparency
            else
                Transparency = v17
            end
            if Transparency ~= nil then
                v15.Transparency = math.max(Transparency, v14)
            end
        end
    end
end

local function releaseEverything() -- line 93 | captures: v2
    for v18, v19 in v2.roster do
        v19.UnfadeAt = 0
        v19.Faded = false
        for v20 in v19.Faces do
            local shelved = v2.shelved
            local v21 = shelved[v20]
            if v21 ~= nil then
                shelved[v20] = nil
                if v20.Parent then
                    v20.Transparency = v21
                end
            end
        end
    end
    table.clear(v2.blocked)
end

local function demand(v22) -- line 117 | captures: v2
    local v23 = v2.roster[v22]
    local v24 = ("%* is not registered for occlusion"):format(v22.Name)
    return assert(v23, v24)
end

local function isUnderfoot(v25, v26, v27) -- line 120
    local v28 = v25:GetScale() / v26.RegisteredScale
    local Bounds = v26.Bounds
    local v29 = CFrame.new(Bounds.Position * v28)
    local v30 = v26.Pivot.CFrame * (v29 * Bounds.Rotation)
    local v31 = v30:PointToObjectSpace(v27)
    local v32 = v26.Extents * v28 * 0.5
    local X = v31.X
    local v33 = -v32.X
    local X_2 = v32.X
    local v34 = math.clamp(X, v33, X_2)
    local v35 = -v32.Y
    local v36 = -v32.Z
    local Z = v31.Z
    local Z_2 = v32.Z
    local v37 = math.clamp(Z, v36, Z_2)
    local v38 = v30:PointToWorldSpace((Vector3.new(v34, v35, v37))) - v27
    return v38.X * v38.X + v38.Z * v38.Z <= 625
end

local function advance(v39, v40, v41) -- line 136 | captures: v2, repaintEntry
    if v40 then
        v39.UnfadeAt = 0
        return repaintEntry(v39, true)
    end
    if v39.Faded then
        if v39.UnfadeAt == 0 then
            v39.UnfadeAt = v41 + 1
        elseif v39.UnfadeAt <= v41 then
            v39.UnfadeAt = 0
            v39.Faded = false
            for v42 in v39.Faces do
                local shelved = v2.shelved
                local v43 = shelved[v42]
                if v43 ~= nil then
                    shelved[v42] = nil
                    if v42.Parent then
                        v42.Transparency = v43
                    end
                end
            end
        end
    else
        v39.UnfadeAt = 0
    end
end

local function onFrame() -- line 168 | captures: Workspace, Player, v2, LocalPlayer, releaseEverything, isUnderfoot
    local CurrentCamera = Workspace.CurrentCamera
    local v44 = Player.Optional.Character(LocalPlayer)
    local v45 = Player.Optional.Head(LocalPlayer)
    local v46 = Player.Optional.HumanoidRootPart(LocalPlayer)
    if v2.sweeping and CurrentCamera and v44 and v45 and v46 then
        local blocked = v2.blocked
        v2.probeFrom[1] = v45.Position
        v2.probeSkip[1] = v44
        table.clear(blocked)
        for v47, v48 in CurrentCamera:GetPartsObscuringTarget(v2.probeFrom, v2.probeSkip) do
            local v49 = v2.faceOwner[v48]
            if v49 then
                blocked[v49] = true
            end
        end
        local Position = v46.Position
        local v50 = Workspace:GetServerTimeNow()
        for v51, v52 in v2.roster do
            if not v52.Muted then
                if blocked[v51] == true or isUnderfoot(v51, v52, Position) then
                    v52.UnfadeAt = 0
                    v52.Faded = true
                    local Target = v52.Target
                    for v53 in v52.Faces do
                        local shelved = v2.shelved
                        if Target == nil then
                            local v54 = shelved[v53]
                            if v54 ~= nil then
                                shelved[v53] = nil
                                if v53.Parent then
                                    v53.Transparency = v54
                                end
                            end
                        elseif v53.Transparency < 1 then
                            local Transparency = v53.Transparency
                            local v55 = shelved[v53]
                            if v55 == nil and Transparency < Target then
                                shelved[v53] = Transparency
                            else
                                Transparency = v55
                            end
                            if Transparency ~= nil then
                                v53.Transparency = math.max(Transparency, Target)
                            end
                        end
                    end
                elseif v52.Faded then
                    if v52.UnfadeAt == 0 then
                        v52.UnfadeAt = v50 + 1
                    elseif v52.UnfadeAt <= v50 then
                        v52.UnfadeAt = 0
                        v52.Faded = false
                        for v56 in v52.Faces do
                            local shelved = v2.shelved
                            local v57 = shelved[v56]
                            if v57 ~= nil then
                                shelved[v56] = nil
                                if v56.Parent then
                                    v56.Transparency = v57
                                end
                            end
                        end
                    end
                else
                    v52.UnfadeAt = 0
                end
            end
        end
    else
        return releaseEverything()
    end
end

function v7.Register(v58, v59) -- line 248 | captures: ModelBounds, Trove, v2, v4, v5
    v4(v58)
    v5(v59)
    local v60 = if v59 >= 0 then v59 <= 1 else false
    assert(v60, "an occlusion fade target has to land between 0 and 1")
    local v61 = v2.roster[v58] == nil
    local v62 = ("%* is being registered for occlusion twice"):format(v58.Name)
    assert(v61, v62)
    local PrimaryPart = v58.PrimaryPart
    local v63 = ("%* has no PrimaryPart to measure against"):format(v58.Name)
    local v64 = assert(PrimaryPart, v63)
    local v65 = v58:GetScale()
    local v66 = v65 > 0
    local v67 = ("%* reports a scale of %*, which cannot be normalised"):format(v58.Name, v65)
    assert(v66, v67)
    local v68, v69 = ModelBounds(v58)
    local v70 = {
        Faded = false,
        Muted = false,
        UnfadeAt = 0,
        Bounds = v64.CFrame:ToObjectSpace(v68),
        Extents = v69,
        Faces = {},
        Lifetime = Trove.new(),
        Pivot = v64,
        RegisteredScale = v65,
        Target = v59
    }
    v2.roster[v58] = v70

    local function adopt(v71) -- line 278 | captures: v58, v70, v2
        if not v71:IsA("BasePart") then
            return
        end
        local v72 = v2.faceOwner[v71] == nil
        local v73 = ("%* is claimed by two occlusion models"):format((v71:GetFullName()))
        assert(v72, v73)
        v70.Faces[v71] = true
        v2.faceOwner[v71] = v58
        if not v70.Faded then
            return
        end
        local Target = v70.Target
        local shelved = v2.shelved
        if Target == nil then
            local v74 = shelved[v71]
            if v74 ~= nil then
                shelved[v71] = nil
                if v71.Parent then
                    v71.Transparency = v74
                end
            end
        elseif v71.Transparency < 1 then
            local Transparency = v71.Transparency
            local v75 = shelved[v71]
            if v75 == nil and Transparency < Target then
                shelved[v71] = Transparency
            else
                Transparency = v75
            end
            if Transparency ~= nil then
                v71.Transparency = math.max(Transparency, Target)
            end
        end
    end

    for v76, v77 in v58:GetDescendants() do
        adopt(v77)
    end
    v70.Lifetime:Connect(v58.DescendantAdded, adopt)
    v70.Lifetime:Connect(v58.DescendantRemoving, function(v78) -- line 320 | captures: v70, v2
        if not (v78:IsA("BasePart") and v70.Faces[v78]) then
            return
        end
        local shelved = v2.shelved
        local v79 = shelved[v78]
        if v79 ~= nil then
            shelved[v78] = nil
            if v78.Parent then
                v78.Transparency = v79
            end
        end
        v70.Faces[v78] = nil
        v2.faceOwner[v78] = nil
    end)
end

function v7.Forget(v80) -- line 335 | captures: v2, v4
    v4(v80)
    local v81 = v2.roster[v80]
    local v82 = ("%* is not registered for occlusion"):format(v80.Name)
    local v83 = assert(v81, v82)
    v83.UnfadeAt = 0
    v83.Faded = false
    for v84 in v83.Faces do
        local shelved = v2.shelved
        local v85 = shelved[v84]
        if v85 ~= nil then
            shelved[v84] = nil
            if v84.Parent then
                v84.Transparency = v85
            end
        end
    end
    for v86 in v83.Faces do
        v2.faceOwner[v86] = nil
    end
    v83.Lifetime:Destroy()
    table.clear(v83.Faces)
    v2.roster[v80] = nil
    v2.blocked[v80] = nil
end

function v7.SetIgnored(v87, v88) -- line 365 | captures: v2, v4, v6
    v4(v87)
    v6(v88)
    local v89 = v2.roster[v87]
    local v90 = ("%* is not registered for occlusion"):format(v87.Name)
    local v91 = assert(v89, v90)
    if v91.Muted ~= v88 then
        v91.Muted = v88
        if v88 then
            v91.UnfadeAt = 0
            v91.Faded = false
            for v92 in v91.Faces do
                local shelved = v2.shelved
                local v93 = shelved[v92]
                if v93 ~= nil then
                    shelved[v92] = nil
                    if v92.Parent then
                        v92.Transparency = v93
                    end
                end
            end
            v2.blocked[v87] = nil
        end
    end
end

local function standDown() -- line 392 | captures: v2, v3, releaseEverything
    v2.sweeping = false
    local sweep = v2.sweep
    v2.sweep = nil
    if sweep then
        sweep:Destroy()
    end
    releaseEverything()
    if v2.sweeping then
        v3:AtDebug():Log("Occlusion sweep released the camera")
    end
end

function v7.SetEnabled(v94) -- line 404 | captures: FrameStepper, v1, v2, v3, v6, releaseEverything, onFrame
    v6(v94)
    if v94 then
        if not v2.sweeping then
            local v95 = v2.sweep == nil
            assert(v95, "an occlusion sweep is bound while the system reads as idle")
            v2.sweeping = true
            v2.sweep = FrameStepper.OnRender(onFrame, nil, nil, nil, v1)
            v3:AtDebug():Log("Occlusion sweep took the camera")
        end
    else
        v2.sweeping = false
        local sweep = v2.sweep
        v2.sweep = nil
        if sweep then
            sweep:Destroy()
        end
        releaseEverything()
        if v2.sweeping then
            v3:AtDebug():Log("Occlusion sweep released the camera")
        end
    end
end

return v7
