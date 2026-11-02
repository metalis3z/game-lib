-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local v1 = {}
local GameSettings

local function qualityLevel() -- line 11 | captures: GameSettings
    if GameSettings == nil then
        GameSettings = UserSettings().GameSettings
    end
    return GameSettings.SavedQualityLevel.Value
end

local function emitCount(v2, v3) -- line 17 | captures: Constants
    local v4 = v2:GetAttribute("EmitCount") or v2.Rate
    local v5 = type(v4) == "number"
    assert(v5, "EmitCount must be a number")
    local v6 = math.floor(v4)
    local v7 = math.random()
    if not (v4 - v6 <= v7) then
        v6 += 1
    end
    if v3 and Constants.IS_MOBILE and v6 > 1 then
        local v8 = if type(v3) == "number" then v3 else 0.1
        local v9 = v6 * v8 + 0.5
        local v10 = math.floor(v9)
        return (math.max(v10, 1))
    end
    return v6
end

local function emitOne(v11, v12) -- line 42 | captures: emitCount
    if not (v11.TimeScale <= 0) then
        local v13 = emitCount(v11, v12)
        local v14 = v11:GetAttribute("EmitDelay") or 0
        local v15 = type(v14) == "number"
        assert(v15, "EmitDelay must be a number")
        if not (v13 < 1 or v14 == (1/0)) then
            local v16 = math.max(v14, 0)
            if v16 == 0 then
                v11:Emit(v13)
            else
                task.delay(v16, function() -- line 55 | captures: v11, v13
                    if v11.Parent then
                        v11:Emit(v13)
                    end
                end)
            end
            return v16 + v11.Lifetime.Max / v11.TimeScale
        end
    end
    return 0
end

function v1.Discard(v17, v18) -- line 65 | captures: Debris
    local v19 = v18 or 0
    Debris:AddItem(v17, (math.max(v19, 0)))
end

function v1.EmitTree(v20, v21) -- line 68 | captures: emitOne
    local v22
    if v20:IsA("ParticleEmitter") then
        v22 = emitOne(v20, v21)
    else
        v22 = 0
    end
    for v23, v24 in v20:GetDescendants() do
        if v24:IsA("ParticleEmitter") then
            local v25 = emitOne(v24, v21)
            v22 = math.max(v22, v25)
        end
    end
    return v22
end

function v1.Emit(v26, v27, ...) -- line 77 | captures: v1, emitOne
    local Part, v28
    if typeof(v26) == "Instance" then
        if v26:IsA("Model") then
            local PrimaryPart = v26.PrimaryPart
            v28 = assert(PrimaryPart, "VFX model origin needs a PrimaryPart")
        else
            v28 = v26
        end
    else
        local Part_2 = Instance.new("Part")
        Part = Part_2
        Part_2.Name = "VFXHost"
        Part_2.Anchored = true
        Part_2.CanCollide = false
        Part_2.CanQuery = false
        Part_2.CanTouch = false
        Part_2.CastShadow = false
        Part_2.Transparency = 1
        Part_2.Size = Vector3.new(0, 0, 0)
        if typeof(v26) == "CFrame" then
            Part_2.CFrame = v26
        else
            Part_2.CFrame = CFrame.new(v26)
        end
        Part_2.Parent = workspace:WaitForChild("__DEBRIS")
        local Attachment = Instance.new("Attachment")
        Attachment.Parent = Part_2
        v28 = Attachment
    end
    local v29 = {}
    local v30 = 0

    local function cloneAndEmit(v31) -- line 108 | captures: v28, Part, v30, v27, v29, v1, emitOne
        if v31.TimeScale <= 0 then
            return
        end
        local v32 = v31:Clone()
        v32.Enabled = false
        if v27 then
            v27(v32)
        end
        v32.Parent = v28
        local v33 = emitOne(v32, true)
        if v33 <= 0 then
            v32:Destroy()
        else
            table.insert(v29, v32)
            local v34 = v30
            v30 = math.max(v34, v33)
            if Part == nil then
                v1.Discard(v32, v33)
            end
        end
    end

    local v35 = table.pack(...)
    local n = v35.n
    for v36 = 1, n do
        local v37 = v35[v36]
        if type(v37) == "table" then
            for v38, v39 in v37 do
                cloneAndEmit(v39)
            end
        else
            cloneAndEmit(v37)
        end
    end
    if Part then
        v1.Discard(Part, v30)
    end
    return v29, v30
end

local function ScaleSequence(v40, v41) -- line 150
    local v42 = table.create(#v40.Keypoints)
    for v43, v44 in v40.Keypoints do
        v42[v43] = NumberSequenceKeypoint.new(v44.Time, v44.Value * v41, v44.Envelope * v41)
    end
    return NumberSequence.new(v42)
end

v1.ScaleSequence = ScaleSequence

function v1.Rescale(v45, v46) -- line 160 | captures: v1
    local v47 = if type(v45) == "table" then v45 else { v45 }
    for v48, v49 in v47 do
        v49.Size = v1.ScaleSequence(v49.Size, v46)
        v49.Drag *= v46
        v49.Speed = NumberRange.new(v49.Speed.Min * v46, v49.Speed.Max * v46)
        v49.Acceleration *= v46
        v49.ZOffset *= v46
    end
end

function v1.RateForDistance(v50, v51) -- line 178 | captures: GameSettings
    if GameSettings == nil then
        GameSettings = UserSettings().GameSettings
    end
    local Value = GameSettings.SavedQualityLevel.Value
    if Value == 0 then
        Value = 10
    end
    local v52 = v50 * (Value / 10)
    local v53 = 1 - ((workspace.CurrentCamera.CFrame.Position - v51).Magnitude - 200) / 800
    return v52 * math.clamp(v53, 0, 1)
end

return table.freeze(v1)
