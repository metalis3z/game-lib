-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Shake = require(ReplicatedStorage.Client.Shake)
local Ease = require(ReplicatedStorage.Shared.Utils.Interpolation).Ease
local EggActionMovement = require(script.Parent.EggActionMovement)
local EggEnergyOrbField = require(script.Parent.EggEnergyOrbField)
local EggRenderer = require(script.Parent.EggRenderer)
local EmitTree = require(ReplicatedStorage.Shared.Utils.VFX).EmitTree
local Log = require(ReplicatedStorage.Packages.Log)
local PlayVFX = require(ReplicatedStorage.UserGenerated.VFX.PlayVFX)
local Spatial = require(ReplicatedStorage.Shared.Utils.Spatial)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local t = require(ReplicatedStorage.Packages.t)
local v1 = { "AssetAnimation", "Part" }
local v2 = Color3.fromRGB(80, 190, 220)
local v3 = Log.new()
local v4 = Workspace:FindFirstChild("__DEBRIS") or Workspace
local v5 = Random.new()
local v6 = {}

local function applyShake(v7, v8, v10, v11) -- line 29 | captures: EggActionMovement, v5
    local v12 = v5:NextNumber(-1, 1) * 0.55 * v10
    local v13 = v5:NextNumber(-1, 1) * 0.55 * v10
    local v14 = v8 * CFrame.new(v12, v13, v5:NextNumber(-1, 1) * 0.55 * v10)
    local v15 = math.rad(v11)
    local v16 = v14 * CFrame.Angles(0, v15, 0)
    local v17 = v5:NextNumber(-1, 1) * 24 * v10
    local v18 = math.rad(v17)
    local SetPivot = EggActionMovement.SetPivot
    local Angles = CFrame.Angles
    local v19 = v5:NextNumber(-1, 1) * 24 * v10
    SetPivot(v7, v16 * Angles(v18, 0, (math.rad(v19))))
end

local function playNamedSound(v20, v21) -- line 38 | captures: ReplicatedStorage, Audio, v3
    local Sounds = ReplicatedStorage.Assets:FindFirstChild("Sounds")
    local v22 = Sounds and Sounds:FindFirstChild(v20)
    if v22 ~= nil and v22:IsA("Sound") then
        Audio.Play(v22, v21)
    else
        v3:AtWarning():Log((("Missing ReplicatedStorage.Assets.Sounds.%*; sound skipped"):format(v20)))
    end
end

local function findParticleAsset(v23) -- line 50 | captures: ReplicatedStorage
    local v24 = ReplicatedStorage.Assets:FindFirstChild("Particles")
    for v25, v26 in v23 do
        if v24 == nil then
            return nil
        end
        v24 = v24:FindFirstChild(v26)
    end
    return v24
end

local function setEmittersEnabled(v27, v28) -- line 63
    for v29, v30 in v27:GetDescendants() do
        if v30:IsA("ParticleEmitter") then
            v30.Enabled = v28
        end
    end
end

local function createHostPart(v31, v32, v33) -- line 70 | captures: Debris, v4
    local Part = Instance.new("Part")
    Part.Name = v31
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Transparency = 1
    Part.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
    Part.CFrame = v32
    Part.Parent = v4
    Debris:AddItem(Part, v33)
    return Part
end

local function attachToEgg(v34, v35) -- line 85 | captures: Spatial
    local PrimaryPart = v35.PrimaryPart
    if PrimaryPart == nil then
        return
    end
    local v36 = Spatial.VisibleBounds(v35)
    v34.CFrame = PrimaryPart.CFrame:ToObjectSpace(CFrame.new(v36.Position))
    v34.Parent = PrimaryPart
end

local function createChargeParticles(v37) -- line 94 | captures: Spatial, v1, v3, findParticleAsset, setEmittersEnabled
    local v38 = findParticleAsset(v1)
    if v38 == nil then
        v3:AtWarning():Log((("Missing ReplicatedStorage.Assets.Particles.%*; charge VFX skipped"):format((table.concat(v1, ".")))))
    else
        local Emit = v38:FindFirstChild("Emit")
        local Enable = v38:FindFirstChild("Enable")
        if not (Emit ~= nil and Emit:IsA("Attachment")) then
            v3:AtWarning():Log("Charge VFX is missing its Emit attachment")
        else
            local v39, v40
            if Enable == nil then
                v40 = true
            elseif Enable:IsA("Attachment") then
                v39 = {
                    Emit = Emit:Clone(),
                    Enable = Enable:Clone()
                }
                local Emit_2 = v39.Emit
                local PrimaryPart = v37.PrimaryPart
                if PrimaryPart ~= nil then
                    local v41 = Spatial.VisibleBounds(v37)
                    Emit_2.CFrame = PrimaryPart.CFrame:ToObjectSpace(CFrame.new(v41.Position))
                    Emit_2.Parent = PrimaryPart
                end
                v40 = false
            else
                v40 = true
            end
            if not v40 then
                local Enable = v39.Enable
                local PrimaryPart = v37.PrimaryPart
                if PrimaryPart ~= nil then
                    local v42 = Spatial.VisibleBounds(v37)
                    Enable.CFrame = PrimaryPart.CFrame:ToObjectSpace(CFrame.new(v42.Position))
                    Enable.Parent = PrimaryPart
                end
                setEmittersEnabled(v39.Enable, true)
                return v39
            end
            v3:AtWarning():Log("Charge VFX is missing its Enable attachment")
        end
    end
    return nil
end

local function detachParticles(v43, v44) -- line 129 | captures: Debris, v4
    local v45 = CFrame.new(v44)
    local Part = Instance.new("Part")
    Part.Name = "MechaUpgradeParticleKeeper"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Transparency = 1
    Part.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
    Part.CFrame = v45
    Part.Parent = v4
    Debris:AddItem(Part, 8)
    v43.Emit.CFrame = CFrame.new()
    v43.Emit.Parent = Part
    v43.Enable.CFrame = CFrame.new()
    v43.Enable.Parent = Part
    return Part
end

local function releaseParticles(v46) -- line 150 | captures: Debris, setEmittersEnabled
    setEmittersEnabled(v46.Enable, false)
    Debris:AddItem(v46.Emit, 8)
    Debris:AddItem(v46.Enable, 8)
end

local function emitImpactVfx(v47) -- line 155 | captures: Debris, PlayVFX, TryCall, v3, v4, findParticleAsset
    local v48 = { "HitGroundAttach" }
    local v49 = findParticleAsset(v48)
    if v49 == nil then
        v3:AtWarning():Log("Missing ReplicatedStorage.Assets.Particles.HitGroundAttach; impact VFX skipped")
    else
        local Part = Instance.new("Part")
        Part.Name = "MechaUpgradeImpactVFX"
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanQuery = false
        Part.CanTouch = false
        Part.CastShadow = false
        Part.Transparency = 1
        Part.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
        Part.CFrame = v47
        Part.Parent = v4
        Debris:AddItem(Part, 10)
        local v50 = v49:Clone()
        if not TryCall(PlayVFX, Part, v47, v50) then
            v50:Destroy()
        end
    end
end

local function playChargeLift(v51, v52, v53, v54, v55, v56) -- line 180 | captures: RunService, Ease, applyShake
    local v57 = 0
    while true do
        if v57 < 5 then
            local v58 = RunService.Heartbeat:Wait()
            v57 += v58
            if v51.Parent == nil then
                break
            end
            local v59 = v57 / 5
            local v60 = math.min(v59, 1)
            local v61 = v60 / 0.62
            local v62 = math.min(v61, 1)
            local v63 = v52:Lerp(v53, Ease(v62, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
            local v64 = Ease(v62, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)
            v56.Spin += 216 * v58
            applyShake(v51, v63, v64, v56.Spin)
            v55:Step(v63.Position + v54, v60, v58)
            continue
        end
        return true
    end
    return false
end

local function playShakeSettle(v65, v66, v67) -- line 199 | captures: RunService, Ease, EggActionMovement, applyShake
    local Spin = v67.Spin
    local v68 = 0
    while true do
        if v68 < 0.5 then
            v68 += RunService.Heartbeat:Wait()
            if v65.Parent == nil then
                break
            end
            local v69 = v68 / 0.5
            local v70 = math.min(v69, 1)
            local v71 = Ease(v70, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local v72 = Spin / 360
            v67.Spin = Spin + (math.ceil(v72) * 360 - Spin) * v71
            applyShake(v65, v66, 1 - v70, v67.Spin)
            continue
        end
        EggActionMovement.SetPivot(v65, v66)
        return
    end
end

local function playDrop(v73, v74, v75, v76) -- line 215 | captures: RunService, Ease, EggActionMovement
    local v77 = 0
    local v78 = false
    while v77 < 0.26 do
        local v79 = RunService.Heartbeat:Wait()
        v77 += v79
        if v73.Parent == nil then
            return
        end
        if not v78 and v77 + v79 * 1 >= 0.26 then
            v76()
            v78 = true
        end
        local v80 = v77 / 0.26
        local v81 = math.min(v80, 1)
        local v82 = Ease(v81, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        EggActionMovement.SetPivot(v73, v9:Lerp(v75, v82))
    end
    EggActionMovement.SetPivot(v73, v75)
    if not v78 then
        v76()
    end
end

local function triggerImpact(v83, v84) -- line 242 | captures: Shake, playNamedSound, emitImpactVfx
    emitImpactVfx(v83)
    if v84 then
        Shake.Play(0.45, 1.6)
    end
    playNamedSound("MechaHatch", v83)
end

local function playSettle(v85, v86) -- line 249 | captures: RunService, Ease, EggActionMovement
    local v87 = v85:GetScale()
    local v88 = 0
    while v88 < 0.22 do
        v88 += RunService.Heartbeat:Wait()
        if v85.Parent == nil then
            return
        end
        local v89 = v88 / 0.22
        local v90 = math.min(v89, 1)
        local v91 = 6.283185307179586 * v90
        local v92 = math.sin(v91)
        local v93 = math.abs(v92) * 0.9 * ((1 - v90) * (1 - v90))
        EggActionMovement.SetPivot(v85, v86 * CFrame.new(0, v93, 0))
        v85:ScaleTo(v87 * (0.88 + 0.12 * Ease(v90, Enum.EasingStyle.Back, Enum.EasingDirection.Out)))
    end
    if v85.Parent ~= nil then
        v85:ScaleTo(v87)
        EggActionMovement.SetPivot(v85, v86)
    end
end

function v6.Play(v94, v95, v96) -- line 268 | captures: Debris, Players, Shake, EggEnergyOrbField, EggRenderer, EmitTree, Spatial, t, v2, v3, v4, applyShake, playNamedSound, setEmittersEnabled, createChargeParticles, detachParticles, emitImpactVfx, playChargeLift, playShakeSettle, playDrop, playSettle
    t.strict(t.number)(v94)
    t.strict(t.instanceIsA("Model"))(v95)
    t.strict(t.callback)(v96)
    EggRenderer.DisableCollisions(v95)
    local v97 = v95:GetPivot()
    local v98 = v97 * CFrame.new(0, 7, 0)
    local v99, v100 = Spatial.VisibleBounds(v95)
    local v101 = v99.Position - v97.Position
    local v102 = CFrame.new(v99.Position - Vector3.new(0, 1, 0) * (v100.Y * 0.5))
    local v103 = v94 == Players.LocalPlayer.UserId
    playNamedSound("MechaShake", v97)
    local v104 = createChargeParticles(v95)
    local v105 = EggEnergyOrbField.new(v4, v2)
    local v106 = { Spin = 0 }
    if playChargeLift(v95, v97, v98, v101, v105, v106) then
        v105:Absorb(v98.Position + v101, 0.6, function(v107) -- line 290 | captures: v95, v98, v106, applyShake
            if v95.Parent ~= nil then
                v106.Spin += v107 * 216
                applyShake(v95, v98, 1, v106.Spin)
            end
        end)
    else
        v105:Destroy()
    end
    local v108
    if v104 == nil then
    else
        v108 = detachParticles(v104, v98.Position + v101)
    end
    local v109 = v96()
    if v109 == nil then
        v3:AtWarning():Log("Mecha upgrade swap did not produce a replacement egg model")
    else
        EggRenderer.DisableCollisions(v109)
        applyShake(v109, v98, 1, v106.Spin)
        if v104 ~= nil and v108 ~= nil then
            local Emit = v104.Emit
            local PrimaryPart = v109.PrimaryPart
            if PrimaryPart ~= nil then
                local v110 = Spatial.VisibleBounds(v109)
                Emit.CFrame = PrimaryPart.CFrame:ToObjectSpace(CFrame.new(v110.Position))
                Emit.Parent = PrimaryPart
            end
            local Enable = v104.Enable
            local PrimaryPart_2 = v109.PrimaryPart
            if PrimaryPart_2 ~= nil then
                local v111 = Spatial.VisibleBounds(v109)
                Enable.CFrame = PrimaryPart_2.CFrame:ToObjectSpace(CFrame.new(v111.Position))
                Enable.Parent = PrimaryPart_2
            end
            v108:Destroy()
            EmitTree(v104.Emit)
        end
        playShakeSettle(v109, v98, v106)
        playDrop(v109, v98, v97, function() -- line 336 | captures: v102, v103, Shake, playNamedSound, emitImpactVfx
            emitImpactVfx(v102)
            if v103 then
                Shake.Play(0.45, 1.6)
            end
            playNamedSound("MechaHatch", v102)
        end)
        playSettle(v109, v97)
    end
    if v104 == nil then
        return
    end
    setEmittersEnabled(v104.Enable, false)
    Debris:AddItem(v104.Emit, 8)
    Debris:AddItem(v104.Enable, 8)
end

return v6
