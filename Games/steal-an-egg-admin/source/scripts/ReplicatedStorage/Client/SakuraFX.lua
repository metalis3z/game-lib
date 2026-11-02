-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Sakura = require(ReplicatedStorage.Data.Sakura)
local Audio = require(ReplicatedStorage.Shared.Audio)
local v1 = {}
local Sakura_2 = ReplicatedStorage.Assets.VFX:WaitForChild("Sakura")

local function spawnAnchor(v2, v3) -- line 13 | captures: Debris, Workspace
    local Part = Instance.new("Part")
    Part.Name = "SakuraFXHost"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(1, 1, 1) * v3
    Part.Position = v2
    Part.Parent = Workspace
    Debris:AddItem(Part, 6)
    return Part
end

local function cue(v4, v5, v6, v7, v8, v9) -- line 27 | captures: Sakura, Audio
    local v10 = Sakura.Sounds[v4]
    local v11 = v10 ~= nil
    local v12 = ("no sound id catalogued under Sakura.Sounds.%*"):format(v4)
    assert(v11, v12)
    return Audio.Play(v10, v5, {
        PlaybackSpeed = v7 or 1,
        Volume = v6 or 1,
        MaxDistance = v8 or 120,
        Looped = v9
    })
end

function v1.EmitBurst(v13, v14, v15, v16) -- line 33 | captures: Debris, Workspace, Sakura_2
    local v17 = Sakura_2:FindFirstChild(v13)
    local v18 = v17 ~= nil
    local v19 = ("no burst prefab named %* under Assets.VFX.Sakura"):format(v13)
    assert(v18, v19)
    local Part = Instance.new("Part")
    Part.Name = "SakuraFXHost"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(1, 1, 1) * (v16 or 4)
    Part.Position = v14
    Part.Parent = Workspace
    Debris:AddItem(Part, 6)
    for v20, v21 in v17:GetChildren() do
        if v21:IsA("ParticleEmitter") then
            local v22 = v21:Clone()
            v22.Enabled = false
            v22.Parent = Part
            local Rate = v21.Rate
            local v23 = v15 * math.max(Rate, 1) / 20
            local v24 = math.floor(v23)
            v22:Emit((math.max(1, v24)))
        end
    end
    return Part
end

function v1.PlayCue(v25, v26, v27, v28, v29) -- line 60 | captures: cue
    return cue(v25, v26, v27, v28, v29)
end

function v1.PlayLooped(v30, v31, v32, v33) -- line 63 | captures: cue
    return cue(v30, v31, v32, v33, nil, true)
end

return v1
