-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local ResolveAssetId = require(ReplicatedStorage.Shared.Utils.Warmup).ResolveAssetId
local v1 = RunService:IsClient()
local v2

if v1 then
    v2 = require(ReplicatedStorage.Shared.SettingsCmds)
end
local Music = script:WaitForChild("Music")
local __DEBRIS = workspace:WaitForChild("__DEBRIS")
local v3 = {}
local v4 = Random.new()
local Sound = Instance.new("Sound")

local function resolveNumber(v5, v6) -- line 25 | captures: v4
    if v5 == nil then
        return v6
    end
    if type(v5) == "table" then
        local v7 = #v5 == 2
        assert(v7, "audio range needs minimum and maximum")
        return v4:NextNumber(v5[1], v5[2])
    end
    return v5
end

local function resolveId(v8) -- line 36 | captures: ResolveAssetId
    local v9 = if type(v8) == "table" then v8[math.random(1, #v8)] else v8
    if type(v9) == "string" then
        v9 = ResolveAssetId(v9)
    end
    local v10 = if type(v9) == "number" then v9 > 0 else false
    assert(v10, "sound id must resolve to a positive number")
    return v9
end

local function resolveGroup(v11, v12) -- line 52 | captures: SoundService
    local v13
    if typeof(v11) == "Instance" then
        v13 = v11
    else
        v13 = SoundService:FindFirstChild(v11 or v12)
    end
    local v14 = v13 and v13:IsA("SoundGroup")
    local v15 = ("missing SoundGroup %*"):format(v11 or v12)
    assert(v14, v15)
    if v13.Name == "Music" then
        local GameMusic = v13:FindFirstChild("GameMusic")
        if GameMusic and GameMusic:IsA("SoundGroup") then
            return GameMusic
        end
    end
    return v13
end

local function locate(v16) -- line 76
    if typeof(v16) == "Vector3" then
        return CFrame.new(v16), (Vector3.new(0, 0, 0))
    end
    if typeof(v16) == "CFrame" then
        return v16, (Vector3.new(0, 0, 0))
    end
    if v16:IsA("Model") then
        if v16:IsA("Workspace") then
            if v16:IsA("BasePart") then
                return v16.CFrame, v16.Size
            end
            if v16:IsA("Attachment") then
                return v16.WorldCFrame, (Vector3.new(0, 0, 0))
            end
            if v16:IsA("PVInstance") then
                return v16:GetPivot(), (Vector3.new(0, 0, 0))
            end
            return nil, (Vector3.new(0, 0, 0))
        end
        local PrimaryPart = v16.PrimaryPart
        if PrimaryPart then
            CFrame = PrimaryPart.CFrame
            return CFrame, PrimaryPart.Size
        end
        CFrame = nil
        return CFrame, (Vector3.new(0, 0, 0))
    end
    if v16:IsA("BasePart") then
        return v16.CFrame, v16.Size
    end
    if v16:IsA("Attachment") then
        return v16.WorldCFrame, (Vector3.new(0, 0, 0))
    end
    if v16:IsA("PVInstance") then
        return v16:GetPivot(), (Vector3.new(0, 0, 0))
    end
    return nil, (Vector3.new(0, 0, 0))
end

local function isAudible(v17, v18, v19) -- line 124
    local v20 = v18 * 0.5 + Vector3.new(1, 1, 1) * v19 * 2
    local Position = v17:ToObjectSpace(workspace.CurrentCamera.CFrame).Position
    local X = Position.X
    if math.abs(X) <= v20.X then
        local Y = Position.Y
        if math.abs(Y) <= v20.Y then
            local Z = Position.Z
            return math.abs(Z) <= v20.Z
        end
    end
    return false
end

local function configure(v21, v22, v23) -- line 139 | captures: v4, resolveId, resolveGroup
    v21.SoundId = ("rbxassetid://%*"):format((resolveId(v22)))
    local PlaybackSpeed = v23.PlaybackSpeed
    if PlaybackSpeed == nil then
        PlaybackSpeed = 1
    elseif type(PlaybackSpeed) == "table" then
        local v24 = #PlaybackSpeed == 2
        assert(v24, "audio range needs minimum and maximum")
        PlaybackSpeed = v4:NextNumber(PlaybackSpeed[1], PlaybackSpeed[2])
    end
    v21.PlaybackSpeed = PlaybackSpeed
    local Volume = v23.Volume
    if Volume == nil then
        Volume = 1
    elseif type(Volume) == "table" then
        local v25 = #Volume == 2
        assert(v25, "audio range needs minimum and maximum")
        Volume = v4:NextNumber(Volume[1], Volume[2])
    end
    v21.Volume = Volume
    v21.Looped = v23.Looped == true
    v21.TimePosition = v23.TimePosition or 0
    v21.RollOffMode = Enum.RollOffMode.LinearSquare
    v21.RollOffMinDistance = 0.001
    v21.RollOffMaxDistance = v23.MaxDistance or 200
    v21.SoundGroup = resolveGroup(v23.SoundGroup, "Default")
end

local function start(v26, v27) -- line 172
    local v28 = false

    local function retire() -- line 176 | captures: v28, v26, v27
        if not v28 then
            v28 = true
            if v27 then
                v27:Destroy()
            else
                v26:Destroy()
            end
        end
    end

    v26:Play()
    return v26
end

function v3.Play(v29, v30, v31) -- line 196 | captures: v2, GameFlags, Remotes, v1, __DEBRIS, v4, Sound, resolveGroup, locate, isAudible, configure
    local v32 = v31 or {}
    if not v1 then
        local Recipient = v32.Recipient
        local v33 = table.clone(v32)
        v33.Recipient = nil
        if Recipient then
            Remotes.SoundBus.EmitSound:FireClient(Recipient, v29, v30, v33)
        else
            Remotes.SoundBus.EmitSound:FireAllClients(v29, v30, v33)
        end
        return nil
    end
    if not GameFlags.SFX:Get() then
        return Sound
    end
    if v2 then
        if not v2.Allows("SFX") then
            return Sound
        end
    else
        local v34, v35 = locate(v30)
        if typeof(v30) == "Instance" then
            if v30:IsA("Model") and not v30:IsA("Workspace") and v34 == nil then
                warn("Audio.Play model needs PrimaryPart", v30)
                return Sound
            end
        else
            local v36 = v32.MaxDistance or 200
            if v34 then
                if v32.Looped ~= true and not isAudible(v34, v35, v36) then
                    return Sound
                end
            else
                local Part, v37
                if typeof(v30) == "Vector3" then
                    Part = Instance.new("Part")
                    Part.Name = "AudioEmitter"
                    Part.Anchored = true
                    Part.CanCollide = false
                    Part.CanQuery = false
                    Part.CanTouch = false
                    Part.Transparency = 1
                    Part.Size = Vector3.new(0, 0, 0)
                    Part.CFrame = assert(v34)
                    Part.Parent = __DEBRIS
                    v37 = Part
                elseif typeof(v30) == "CFrame" then
                    v37 = v30
                elseif v30:IsA("Model") then
                    if v30:IsA("Workspace") then
                        v37 = v30
                    else
                        local PrimaryPart = v30.PrimaryPart
                        Part, v37 = nil, assert(PrimaryPart)
                    end
                else
                    v37 = v30
                end
                local Sound
                if typeof(v29) == "Instance" then
                    local Sound_2 = v29:IsA("Sound")
                    assert(Sound_2, "Audio.Play instance source must be Sound")
                    Sound = v29:Clone()
                    if v32.PlaybackSpeed then
                        local PlaybackSpeed = v32.PlaybackSpeed
                        if PlaybackSpeed == nil then
                            PlaybackSpeed = 1
                        elseif type(PlaybackSpeed) == "table" then
                            local v38 = #PlaybackSpeed == 2
                            local v39 = "audio range needs minimum and maximum"
                            assert(v38, v39)
                            PlaybackSpeed = v4:NextNumber(PlaybackSpeed[1], PlaybackSpeed[2])
                        end
                        Sound.PlaybackSpeed = PlaybackSpeed
                    end
                    if v32.Volume then
                        local Volume = v32.Volume
                        if Volume == nil then
                            Volume = 1
                        elseif type(Volume) == "table" then
                            local v40 = #Volume == 2
                            local v41 = "audio range needs minimum and maximum"
                            assert(v40, v41)
                            Volume = v4:NextNumber(Volume[1], Volume[2])
                        end
                        Sound.Volume = Volume
                    end
                    if v32.MaxDistance then
                        Sound.RollOffMaxDistance = v32.MaxDistance
                    end
                    if v32.SoundGroup then
                        Sound.SoundGroup = resolveGroup(v32.SoundGroup, "Default")
                    end
                    if v32.Looped ~= nil then
                        Sound.Looped = v32.Looped
                    end
                    if v32.TimePosition then
                        Sound.TimePosition = v32.TimePosition
                    end
                else
                    Sound = Instance.new("Sound")
                    configure(Sound, v29, v32)
                end
                for v42, v43 in v32.Effects or {} do
                    v43:Clone().Parent = Sound
                end
                Sound.Parent = v37
                if not v32.Deferred then
                    local v44 = false
                    local Part_2 = Part
                    local Sound_2 = Sound

                    local function retire() -- line 304 | captures: v44, Part_2, Sound_2
                        if not v44 then
                            v44 = true
                            if Part_2 then
                                Part_2:Destroy()
                            else
                                Sound_2:Destroy()
                            end
                        end
                    end

                    Sound:Play()
                end
                return Sound
            end
        end
    end
end

local function PlaySound(v45, v46) -- line 334
    if v46 then
        v45.Parent = v46
    end
    local v47 = false

    local function retire() -- line 342 | captures: v47, v45
        if not v47 then
            v47 = true
            v45:Destroy()
        end
    end

    v45:Play()
    return v45
end

v3.PlaySound = PlaySound

local function catalogOptions(v48) -- line 362
    return {
        PlaybackSpeed = v48.Speed,
        Volume = v48.Volume,
        MaxDistance = v48.MaxDistance,
        SoundGroup = v48.SoundGroup,
        Looped = v48.Looped,
        TimePosition = v48.TimePos,
        Recipient = v48.Player,
        Deferred = v48.SkipPlay
    }
end

function v3.PlayFile(v49, v50, v51) -- line 374 | captures: v3
    local Data = v49.Data
    return v3.Play(v49.SoundId, v50, {
        PlaybackSpeed = Data.Speed,
        Volume = Data.Volume,
        MaxDistance = Data.MaxDistance,
        SoundGroup = Data.SoundGroup,
        Looped = Data.Looped,
        TimePosition = Data.TimePos,
        Recipient = Data.Player,
        Deferred = Data.SkipPlay,
        Effects = v51
    })
end

function v3.Configure(v52, v53) -- line 388 | captures: configure
    local SoundId = v53.SoundId
    local v54 = typeof(SoundId) ~= "Instance"
    assert(v54, "catalogued Sound source cannot configure another Sound")
    local Data = v53.Data
    configure(v52, SoundId, {
        PlaybackSpeed = Data.Speed,
        Volume = Data.Volume,
        MaxDistance = Data.MaxDistance,
        SoundGroup = Data.SoundGroup,
        Looped = Data.Looped,
        TimePosition = Data.TimePos,
        Recipient = Data.Player,
        Deferred = Data.SkipPlay
    })
    return v52
end

function v3.CreateConfigured(v55, v56, v57) -- line 405 | captures: v3
    local Sound = Instance.new("Sound")
    local v58 = v3.Configure(Sound, v56)
    v58.Name = v57 or "ConfiguredSound"
    v58.Parent = v55
    return v58
end

function v3.CreateMusic(v59, v60, v61) -- line 412 | captures: SoundService, Music, resolveId
    local v62 = Music:FindFirstChild(v59)
    while true do
        if v62 == nil then
            break
        end
        if v62:IsA("Sound") then
            v62:Stop()
        end
        v62:Destroy()
        v62 = Music:FindFirstChild(v59)
    end
    local Sound = Instance.new("Sound")
    Sound.Name = v59
    Sound.SoundId = ("rbxassetid://%*"):format((resolveId(v60)))
    Sound.Volume = 0
    Sound.Looped = v61
    local Music_2 = SoundService:FindFirstChild("Music")
    local v63 = Music_2 and Music_2:IsA("SoundGroup")
    assert(v63, "missing SoundGroup Music")
    local GameMusic
    if Music_2.Name == "Music" then
        GameMusic = Music_2:FindFirstChild("GameMusic")
        if not (GameMusic and GameMusic:IsA("SoundGroup")) then
            GameMusic = Music_2
        end
    else
        GameMusic = Music_2
    end
    Sound.SoundGroup = GameMusic
    Sound.Parent = Music
    return Sound
end

function v3.Fade(v64, v65, v66, v67, v68) -- line 453 | captures: Tween
    local v69 = if typeof(v65) == "number" then v65 else 0
    local v70
    if typeof(v66) == "number" then
        v70 = math.max(v66, 0)
    else
        v70 = 0.25
    end
    local v71 = if typeof(v67) == "EnumItem" then v67 else Enum.EasingStyle.Linear
    local v72 = if typeof(v68) == "EnumItem" then v68 else Enum.EasingDirection.Out
    return Tween(v64, { Volume = v69 }, { v70, v71, v72 })
end

function v3.Cue(v73, v74, v75) -- line 461 | captures: v3
    local v76
    if v73 == "Statement" then
        v76 = 0.5
    elseif v73 == "Question" then
        v76 = 0.8
    else
        v76 = 1
    end
    v3.Play(91386772775244, script, {
        Volume = v76 * (v74 or 1),
        Recipient = v75
    })
end

if v1 then
    local DefaultReverb = SoundService:FindFirstChild("DefaultReverb")
    local v77 = DefaultReverb and DefaultReverb:FindFirstChild("ReverbSoundEffect")
    if v77 and v77:IsA("ReverbSoundEffect") then
        v77.DryLevel = -1.3389357926122634
        v77.WetLevel = -16.90196080028514
    end
    Remotes.SoundBus.EmitSound.OnClientEvent:Connect(v3.Play)
end
return table.freeze(v3)
