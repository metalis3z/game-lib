-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Utils.AnimationAssets)
local Audio = require(ReplicatedStorage.Shared.Audio)
require(ReplicatedStorage.Data.Guards)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}

v1.__index = v1
v1.__class = "GuardPresentationComponent"

function v1.new(v2, v3, v4) -- line 14 | captures: Audio, t, v1
    t.strict(t.instanceIsA("BasePart"))(v2)
    t.strict(t.Instance)(v3)
    t.strict(t.table)(v4)
    local v5 = {}
    local v6 = setmetatable(v5, v1)
    v6._afterWakeSoundConfigs = v1.NormalizeAfterWakeSoundConfigs(v4.AfterWakeSound)
    if #v6._afterWakeSoundConfigs <= 0 then
        v6._afterWakeSound = nil
    else
        local v7 = v1.CreateSoundFile(v6._afterWakeSoundConfigs[1])
        v6._afterWakeSound = Audio.CreateConfigured(v2, v7, "AfterWakeSound")
    end
    v6._afterWakeSoundAt = nil
    v6._animationBaseWalkSpeed = v4.AnimationBaseWalkSpeed or 7
    local v8 = v6._animationBaseWalkSpeed > 0
    local v9 = ("Guard %* animation base WalkSpeed must be greater than zero"):format(v4._id)
    assert(v8, v9)
    if v4.FootstepSound == nil then
        v6._footstepSound = nil
    else
        local v10 = v1.CreateSoundFile(v4.FootstepSound)
        v6._footstepSound = Audio.CreateConfigured(v2, v10, "FootstepSound")
    end
    if v4.FootstepSound == nil then
        v6._footstepPlaybackSpeed = nil
    else
        v6._footstepPlaybackSpeed = v4.FootstepSound.PlaybackSpeed or 1
    end
    local v11 = v1.CreateSoundFile(v4.AttackSound)
    v6._hitSound = Audio.CreateConfigured(v2, v11, "Hit")
    v6._hitTrack = v1.LoadTrack(v3, v4.AttackAnimation, false)
    v6._hitTrack.Priority = Enum.AnimationPriority.Action4
    v6._idleTrack = v1.LoadTrack(v3, v4.IdleAnimation, true)
    local v12 = v1.CreateSoundFile(v4.SleepSound)
    v6._sleepSound = Audio.CreateConfigured(v2, v12, "SleepSound")
    v6._sleepTrack = v1.LoadTrack(v3, v4.SleepAnimation, true)
    v6._random = Random.new()
    local v13 = v1.CreateSoundFile(v4.WakeSound)
    v6._wakeSound = Audio.CreateConfigured(v2, v13, "Detected")
    v6._walkTrack = v1.LoadTrack(v3, v4.WalkAnimation, true)
    return v6
end

local function CreateSoundFile(v14) -- line 64
    local v15 = {}
    v15.SoundId = v14.SoundIds or v14.SoundId
    v15.Data = {
        Speed = v14.PlaybackSpeed,
        Volume = v14.Volume,
        MaxDistance = v14.MaxDistance,
        Looped = v14.Looped
    }
    return v15
end

v1.CreateSoundFile = CreateSoundFile

local function NormalizeAfterWakeSoundConfigs(v16) -- line 74
    if v16 == nil then
        return {}
    end
    if typeof(v16) == "table" then
        local SoundId = v16.SoundId
        if typeof(SoundId) == "string" then
            local Volume = v16.Volume
            if typeof(Volume) == "number" then
                local MaxDistance = v16.MaxDistance
                if typeof(MaxDistance) == "number" then
                    return { v16 }
                end
                local v17 = #v16 > 0
                assert(v17, "AfterWakeSound config array must not be empty")
                return v16
            end
        end
    end
    local v18 = #v16 > 0
    assert(v18, "AfterWakeSound config array must not be empty")
    return v16
end

v1.NormalizeAfterWakeSoundConfigs = NormalizeAfterWakeSoundConfigs

function v1.LoadTrack(v19, v20, v21) -- line 91 | captures: t
    t.strict(t.instanceIsA("Animation"))(v20)
    t.strict(t.boolean)(v21)
    local v22 = v19:LoadAnimation(v20)
    v22.Looped = v21
    return v22
end

local function Destroy(v23) -- line 100
    v23._afterWakeSoundAt = nil
    v23:StopWalkAnimation()
    v23:StopIdleAnimation()
    v23:StopFootstepSound()
    v23._sleepTrack:Stop(0.1)
    v23._hitTrack:Stop(0.1)
    if v23._footstepSound ~= nil then
        v23._footstepSound:Destroy()
    end
    if v23._afterWakeSound ~= nil then
        v23._afterWakeSound:Destroy()
    end
    v23._hitSound:Destroy()
    v23._sleepSound:Destroy()
    v23._wakeSound:Destroy()
end

v1.Destroy = Destroy

function v1.PlaySleep(v24, v25) -- line 117 | captures: t
    t.strict(t.number)(v25)
    if not v24._sleepTrack.IsPlaying then
        v24._sleepTrack:Play(v25)
    end
    if v24._sleepSound.IsPlaying then
        return
    end
    v24._sleepSound.Looped = true
    v24._sleepSound.TimePosition = 0
    v24._sleepSound:Play()
end

function v1.StopSleep(v26, v27) -- line 129 | captures: t
    t.strict(t.number)(v27)
    v26._sleepTrack:Stop(v27)
    v26._sleepSound:Stop()
end

local function PlayWake(v28) -- line 135
    v28._wakeSound.TimePosition = 0
    v28._wakeSound:Play()
end

v1.PlayWake = PlayWake

function v1.PlayAfterWake(v29) -- line 139 | captures: Audio, v1
    local _afterWakeSound = v29._afterWakeSound
    if _afterWakeSound == nil then
        return
    end
    local v30 = v29._afterWakeSoundConfigs[v29._random:NextInteger(1, #v29._afterWakeSoundConfigs)]
    local v31 = v30 ~= nil
    assert(v31, "AfterWakeSound playback requires a configured sound")
    _afterWakeSound:Stop()
    Audio.Configure(_afterWakeSound, v1.CreateSoundFile(v30))
    _afterWakeSound.TimePosition = 0
    _afterWakeSound:Play()
end

function v1.ScheduleAfterWake(v32, v33) -- line 152 | captures: t
    t.strict(t.number)(v33)
    if v32._afterWakeSound ~= nil then
        v32._afterWakeSoundAt = v33 + 1
    end
end

local function CancelAfterWake(v34) -- line 159
    v34._afterWakeSoundAt = nil
end

v1.CancelAfterWake = CancelAfterWake

function v1.UpdateAfterWake(v35, v36, v37) -- line 162 | captures: t
    t.strict(t.number)(v36)
    t.strict(t.boolean)(v37)
    local _afterWakeSoundAt = v35._afterWakeSoundAt
    if _afterWakeSoundAt == nil or v36 < _afterWakeSoundAt then
        return
    end
    v35._afterWakeSoundAt = nil
    if v37 then
        v35:PlayAfterWake()
    end
end

local function PlayHit(v38) -- line 176
    v38:StopWalkAnimation()
    v38:StopFootstepSound()
    v38:EnsureIdleAnimation()
    v38._hitTrack.TimePosition = 0
    v38._hitTrack:Play(0.05)
    v38._hitSound.TimePosition = 0
    v38._hitSound:Play()
    return v38._hitTrack.Length
end

v1.PlayHit = PlayHit

function v1.EnsureFootstepSound(v39, v40) -- line 186 | captures: t
    t.strict(t.number)(v40)
    local _footstepSound = v39._footstepSound
    local _footstepPlaybackSpeed = v39._footstepPlaybackSpeed
    if _footstepSound == nil or _footstepPlaybackSpeed == nil then
        return
    end
    local v41 = v40 / v39._animationBaseWalkSpeed
    _footstepSound.PlaybackSpeed = _footstepPlaybackSpeed * math.max(v41, 0.01)
    if _footstepSound.IsPlaying then
        return
    end
    _footstepSound.Looped = true
    _footstepSound.TimePosition = 0
    _footstepSound:Play()
end

local function StopFootstepSound(v42) -- line 201
    local _footstepSound = v42._footstepSound
    if _footstepSound ~= nil and _footstepSound.IsPlaying then
        _footstepSound:Stop()
    end
end

v1.StopFootstepSound = StopFootstepSound

local function EnsureIdleAnimation(v43) -- line 207
    if not v43._idleTrack.IsPlaying then
        v43._idleTrack:Play(0.2)
    end
end

v1.EnsureIdleAnimation = EnsureIdleAnimation

local function StopIdleAnimation(v44) -- line 212
    if v44._idleTrack.IsPlaying then
        v44._idleTrack:Stop(0.2)
    end
end

v1.StopIdleAnimation = StopIdleAnimation

function v1.EnsureWalkAnimation(v45, v46) -- line 217 | captures: t
    t.strict(t.number)(v46)
    v45:StopIdleAnimation()
    v45:EnsureFootstepSound(v46)
    local v47 = v46 / v45._animationBaseWalkSpeed
    v45._walkTrack:AdjustSpeed((math.max(v47, 0.01)))
    if not v45._walkTrack.IsPlaying then
        v45._walkTrack:Play(0.4)
    end
end

local function StopWalkAnimation(v48) -- line 228
    if v48._walkTrack.IsPlaying then
        v48._walkTrack:Stop(0.2)
    end
end

v1.StopWalkAnimation = StopWalkAnimation
return v1
