-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
local v1 = {}

local function sizeFactor(v2, v3, v4) -- line 9
    local baseWeight, weight
    if v4 then
        weight = v4.weight
        baseWeight = v4.baseWeight
    end
    if v3 == "WalkSound" then
        if typeof(weight) == "number" and typeof(baseWeight) == "number" and baseWeight > 0 then
            local v5 = weight / baseWeight
            return (math.max(v5, 0.001))
        end
    else
        local v6
        if v4 then
            local baseModelScale = v4.baseModelScale
            if typeof(baseModelScale) == "number" then
                v6 = v4.baseModelScale
            else
                v6 = 1
            end
        else
            v6 = 1
        end
        if v6 <= 0 then
            v6 = 1
        end
        local v7 = v2:GetScale() / v6
        return (math.max(v7, 0.001))
    end
end

local function scaled(v8, v9, v10, v11) -- line 35
    if typeof(v8) == "number" then
        return v8 * math.clamp(v9, v10, v11)
    end
    return nil
end

local function splitMutationList(v12) -- line 41
    local v13 = {}
    if typeof(v12) == "string" and v12 ~= "" then
        for v14 in string.gmatch(v12, "[^,]+") do
            local v15 = v14:gsub("^%s*(.-)%s*$", "%1")
            if v15 ~= "" then
                table.insert(v13, v15)
            end
        end
    end
    return v13
end

function v1.BuildSound(v16, v17, v18, v19, v20) -- line 55 | captures: Audio, sizeFactor
    if v18 then
        local Sound = Instance.new("Sound")
        Sound.Name = v19
        Audio.Configure(Sound, v18)
        Sound.RollOffMaxDistance = 40
        local v21 = sizeFactor(v17, v19, v20)
        if Sound.Volume > 0 then
            local v22 = if v19 == "WalkSound" then 3.5 else 3
            local Volume = Sound.Volume
            local v23 = if typeof(Volume) == "number" then Volume * math.clamp(v21, 1, v22) else nil
            if v23 then
                Sound.Volume = v23
            end
        end
        if Sound.RollOffMaxDistance > 0 then
            local RollOffMaxDistance = Sound.RollOffMaxDistance
            local v24 = if typeof(RollOffMaxDistance) == "number" then RollOffMaxDistance * math.clamp(v21, 0.7, 1.2) else nil
            if v24 then
                Sound.RollOffMaxDistance = v24
            end
        end
        Sound.Parent = v16
        return Sound
    end
    return nil
end

function v1.WeightedParams(v25) -- line 96
    if v25 == nil or v25 <= 0 then
        return 1, 1
    end
    local v26 = math.clamp(v25, 50, 480)
    local v27 = (math.log(v26) - 3.912023005428146) / 2.2617630984737906
    local v28 = v27 * 0.5 + 2.5
    if not (v26 < 80) and v26 <= 110 then
        return v28, 1
    end
    return v28, 2 - v27 * 1.5
end

function v1.ParseMutationList(v29) -- line 111 | captures: splitMutationList
    return (splitMutationList(v29))
end

function v1.ReadMutationState(v30, v31, v32) -- line 114 | captures: splitMutationList
    local v33 = splitMutationList(v30:GetAttribute(v31 or "Mutations"))
    local v34 = v30:GetAttribute(v32 or "BaseMutation")
    if typeof(v34) == "string" then
        if v34 == "" then
            v34 = nil
        end
    else
        v34 = nil
    end
    return v33, v34
end

function v1.AttachEffects(v35, v36) -- line 127
    if v35 then
        for v37, v38 in ipairs(v35) do
            v38.Parent = v36
        end
        return v35
    end
    return nil
end

function v1.StartFootsteps(v39) -- line 136
    if not v39 or v39.IsPlaying then
        return
    end
    v39.TimePosition = 0
    v39.Looped = true
    v39:Play()
end

function v1.StopFootsteps(v40) -- line 144
    if v40 and v40.IsPlaying then
        v40:Stop()
    end
end

function v1.PlayJump(v41) -- line 150
    if not v41 then
        return
    end
    v41.TimePosition = 0
    v41.Looped = false
    v41:Play()
end

return v1
