-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Ease = require(ReplicatedStorage.Shared.Utils.Interpolation).Ease
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}

v1.__index = v1
v1.__class = "EggEnergyOrbField"

local function getOrbTransparency(v2) -- line 14
    if v2 < 0.14 then
        return 1 - v2 / 0.14
    end
    if v2 > 0.72 then
        return (v2 - 0.72) / 0.28
    end
    return 0
end

local function randomUnitVector(v3) -- line 23
    local v4 = v3:NextNumber(-1, 1)
    local v5 = v3:NextNumber(0, 6.283185307179586)
    local v6 = 1 - v4 * v4
    local v7 = math.max(v6, 0)
    local v8 = math.sqrt(v7)
    local v9 = v8 * math.cos(v5)
    local v10 = v8 * math.sin(v5)
    return (Vector3.new(v9, v10, v4))
end

local function randomOrbitPlane(v11) -- line 32
    local v14 = v11:NextNumber(-1, 1)
    local v15 = v11:NextNumber(0, 6.283185307179586)
    local v16 = 1 - v14 * v14
    local v17 = math.max(v16, 0)
    local v18 = math.sqrt(v17)
    local v19 = v18 * math.cos(v15)
    local v20 = v18 * math.sin(v15)
    local v21 = Vector3.new(v19, v20, v14)
    local Y = v21.Y
    local v22
    if math.abs(Y) >= 0.9 then
        v22 = Vector3.new(1, 0, 0)
    else
        v22 = Vector3.new(0, 1, 0)
    end
    local Unit = v21:Cross(v22).Unit
    return Unit, v21:Cross(Unit).Unit
end

function v1.new(v23, v24) -- line 49 | captures: t, v1
    t.strict(t.Instance)(v23)
    t.strict(t.Color3)(v24)
    local v25 = {}
    local v26 = setmetatable(v25, v1)
    v26._color = v24
    v26._parent = v23
    v26._rng = Random.new()
    v26._orbs = {}
    v26._spawnAccumulator = 0
    v26._destroyed = false
    return v26
end

local function _resetOrb(v27, v28, v29) -- line 63
    local _rng = v27._rng
    local v30 = _rng:NextNumber(-1, 1)
    local v31 = _rng:NextNumber(0, 6.283185307179586)
    local v32 = 1 - v30 * v30
    local v33 = math.max(v32, 0)
    local v34 = math.sqrt(v33)
    local v35 = v34 * math.cos(v31)
    local v36 = v34 * math.sin(v31)
    local v37 = Vector3.new(v35, v36, v30)
    local Y = v37.Y
    local v38
    if math.abs(Y) >= 0.9 then
        v38 = Vector3.new(1, 0, 0)
    else
        v38 = Vector3.new(0, 1, 0)
    end
    local Unit = v37:Cross(v38).Unit
    v28.PlaneU = Unit
    v28.PlaneV = v37:Cross(Unit).Unit
    v28.Radius = _rng:NextNumber(4.5, 6.5)
    v28.Angle = _rng:NextNumber(0, 6.283185307179586)
    local v39 = _rng:NextNumber(3, 7)
    local v40 = if _rng:NextInteger(0, 1) == 0 then -1 else 1
    v28.AngularSpeed = v39 * v40
    v28.Age = 0
    v28.CurrentRadius = v28.Radius
    local PlaneU = v28.PlaneU
    local Angle = v28.Angle
    local v41 = PlaneU * math.cos(Angle)
    local PlaneV = v28.PlaneV
    local Angle_2 = v28.Angle
    local v42 = v41 + PlaneV * math.sin(Angle_2)
    v28.Part.Position = v29 + v42 * v28.Radius
    v28.Part.Transparency = 1
    v28.Trail.Enabled = true
    v28.Trail:Clear()
end

v1._resetOrb = _resetOrb

local function _createOrb(v43, v44) -- line 99
    local Part = Instance.new("Part")
    Part.Name = "EnergyOrb"
    Part.Shape = Enum.PartType.Ball
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Material = Enum.Material.Neon
    Part.Color = v43._color
    Part.Size = Vector3.new(0.25999999046325684, 0.25999999046325684, 0.25999999046325684)
    local Attachment = Instance.new("Attachment")
    Attachment.Position = Vector3.new(0, 0.12999999523162842, 0)
    Attachment.Parent = Part
    local Attachment_2 = Instance.new("Attachment")
    Attachment_2.Position = Vector3.new(0, -0.12999999523162842, 0)
    Attachment_2.Parent = Part
    local Trail = Instance.new("Trail")
    Trail.Attachment0 = Attachment
    Trail.Attachment1 = Attachment_2
    Trail.Lifetime = 0.32
    Trail.LightEmission = 1
    Trail.LightInfluence = 0
    Trail.FaceCamera = true
    Trail.MinLength = 0
    Trail.Color = ColorSequence.new(v43._color)
    local v45 = {}
    v45[1] = NumberSequenceKeypoint.new(0, 0.85)
    v45[2] = NumberSequenceKeypoint.new(1, 0)
    Trail.WidthScale = NumberSequence.new(v45)
    local v46 = {}
    v46[1] = NumberSequenceKeypoint.new(0, 0.2)
    v46[2] = NumberSequenceKeypoint.new(1, 1)
    Trail.Transparency = NumberSequence.new(v46)
    Trail.Parent = Part
    local v47 = {
        CurrentRadius = 6.5,
        PlaneU = Vector3.new(1, 0, 0),
        PlaneV = Vector3.new(0, 0, 1),
        Radius = 6.5,
        Angle = 0,
        AngularSpeed = 3,
        Age = 0,
        Part = Part,
        Trail = Trail,
        AbsorbSeconds = v43._rng:NextNumber(0.9, 1.8)
    }
    v43:_resetOrb(v47, v44)
    Part.Parent = v43._parent
    return v47
end

v1._createOrb = _createOrb

local function Step(v48, v49, v50, v51) -- line 153
    local function v52(v53, ...)
        table.insert(v53, ...)
    end

    if v48._destroyed then
        return
    end
    local _orbs = v48._orbs
    if #_orbs < 26 then
        v48._spawnAccumulator += v51
        local v54 = math.clamp(v50, 0, 1) * -0.19999999999999998 + 0.24
        while v54 <= v48._spawnAccumulator do
            if #_orbs >= 26 then
                break
            end
            v48._spawnAccumulator -= v54
            v52(_orbs, v48:_createOrb(v49))
        end
    end
    for v55, v56 in _orbs do
        v56.Age += v51
        local v57 = v56.Age / v56.AbsorbSeconds
        if v57 < 1 then
            v56.Angle += v56.AngularSpeed * v51 * (1 + v57 * 2.5)
            v56.CurrentRadius = v56.Radius * (1 - v57) ^ 1.5
            local PlaneU = v56.PlaneU
            local Angle = v56.Angle
            local v58 = PlaneU * math.cos(Angle)
            local PlaneV = v56.PlaneV
            local Angle_2 = v56.Angle
            local v59 = v58 + PlaneV * math.sin(Angle_2)
            v56.Part.Position = v49 + v59 * v56.CurrentRadius
            local v60
            if v57 < 0.14 then
                v60 = 1 - v57 / 0.14
            elseif v57 <= 0.72 then
                v60 = 0
            else
                v60 = (v57 - 0.72) / 0.28
            end
            v56.Part.Transparency = v60
            local v61 = v57 <= 0.72
            v56.Trail.Enabled = v61
        else
            v48:_resetOrb(v56, v49)
        end
    end
end

v1.Step = Step

function v1.Absorb(v62, v63, v64, v65) -- line 198 | captures: Debris, RunService, Ease
    if v62._destroyed then
        return
    end
    v62._destroyed = true
    local v66 = table.clone(v62._orbs)
    table.clear(v62._orbs)
    if #v66 == 0 then
        return
    end
    local v67 = 0
    while v67 < v64 do
        local v68 = RunService.Heartbeat:Wait()
        v67 += v68
        local v69 = v67 / v64
        local v70 = math.min(v69, 1)
        local v71 = (v70 - 0.72) / 0.28
        local v72 = math.max(v71, 0)
        for v73, v74 in v66 do
            v74.Angle += v74.AngularSpeed * v68 * 3.5
            local PlaneU = v74.PlaneU
            local Angle = v74.Angle
            local v75 = PlaneU * math.cos(Angle)
            local PlaneV = v74.PlaneV
            local Angle_2 = v74.Angle
            local v76 = v75 + PlaneV * math.sin(Angle_2)
            v74.Part.Position = v12 + v76 * (v74.CurrentRadius * (1 - Ease(v70, Enum.EasingStyle.Quart, Enum.EasingDirection.In)))
            local Part = v74.Part
            local Transparency = v74.Part.Transparency
            Part.Transparency = math.max(Transparency, v72)
            if v70 >= 0.82 then
                v74.Trail.Enabled = false
            end
        end
        if v13 ~= nil then
            v13(v68)
        end
    end
    for v77, v78 in v66 do
        v78.Part.Transparency = 1
        v78.Trail.Enabled = false
        Debris:AddItem(v78.Part, 0.32)
    end
end

local function Destroy(v79) -- line 242
    if v79._destroyed then
        return
    end
    v79._destroyed = true
    for v80, v81 in v79._orbs do
        v81.Part:Destroy()
    end
    table.clear(v79._orbs)
end

v1.Destroy = Destroy
return v1
