-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Directory.Animations.Pipeline)

local Audio = require(ReplicatedStorage.Library.Audio)
local CreateConfiguredSound = require(ReplicatedStorage.Library.Audio.CreateConfiguredSound)
local Interface = require(ReplicatedStorage.Directory.Guards.Types.Interface)
local t = {}

t.__index = t
t.__class = "GuardPresentationComponent"
function t.new(p1, p2, p3) --[[ new | Line: 46 | Upvalues: Asserts (copy), t (copy), CreateConfiguredSound (copy) ]]
	Asserts.BasePart(p1)
	Asserts.Instance(p2)
	Asserts.table(p3)

	local v2 = setmetatable({}, t)

	v2._afterWakeSoundConfigs = t.NormalizeAfterWakeSoundConfigs(p3.AfterWakeSound)
	v2._afterWakeSound = if #v2._afterWakeSoundConfigs > 0 then CreateConfiguredSound(p1, t.CreateSoundFile(v2._afterWakeSoundConfigs[1]), "AfterWakeSound") else nil
	v2._afterWakeSoundAt = nil
	v2._animationBaseWalkSpeed = p3.AnimationBaseWalkSpeed or 7
	assert(if v2._animationBaseWalkSpeed > 0 then true else false, (("Guard %* animation base WalkSpeed must be greater than zero"):format(p3._id)))
	v2._footstepSound = if p3.FootstepSound == nil then nil else CreateConfiguredSound(p1, t.CreateSoundFile(p3.FootstepSound), "FootstepSound")
	v2._footstepPlaybackSpeed = if p3.FootstepSound == nil then nil else p3.FootstepSound.PlaybackSpeed or 1
	v2._hitSound = CreateConfiguredSound(p1, t.CreateSoundFile(p3.AttackSound), "Hit")
	v2._hitTrack = t.LoadTrack(p2, p3.AttackAnimation)
	v2._hitTrack.Priority = Enum.AnimationPriority.Action4
	v2._idleTrack = t.LoadTrack(p2, p3.IdleAnimation)
	v2._sleepSound = CreateConfiguredSound(p1, t.CreateSoundFile(p3.SleepSound), "SleepSound")
	v2._sleepTrack = t.LoadTrack(p2, p3.SleepAnimation)
	v2._random = Random.new()
	v2._wakeSound = CreateConfiguredSound(p1, t.CreateSoundFile(p3.WakeSound), "Detected")
	v2._walkTrack = t.LoadTrack(p2, p3.WalkAnimation)

	return v2
end
function t.CreateSoundFile(p1) --[[ CreateSoundFile | Line: 93 ]]
	local t = {}

	t.SoundId = p1.SoundIds or p1.SoundId
	t.Data = {
		Speed = p1.PlaybackSpeed,
		Volume = p1.Volume,
		MaxDistance = p1.MaxDistance,
		Looped = p1.Looped
	}

	return t
end
function t.NormalizeAfterWakeSoundConfigs(p1) --[[ NormalizeAfterWakeSoundConfigs | Line: 105 | Upvalues: Interface (copy) ]]
	if p1 == nil then
		return {}
	end

	if Interface.SoundConfig(p1) then
		return { p1 }
	end

	assert(#p1 > 0, "AfterWakeSound config array must not be empty")

	return p1
end
function t.LoadTrack(p1, p2) --[[ LoadTrack | Line: 120 ]]
	local v1 = p1:LoadAnimation(p2.anim)

	v1.Looped = p2.looped == true

	local v2 = p2.protocol and p2.protocol.Play

	if v2 and v2[2] then
		v1:AdjustWeight(v2[2])
	end

	return v1
end
function t.Destroy(p1) --[[ Destroy | Line: 137 ]]
	p1._afterWakeSoundAt = nil
	p1:StopWalkAnimation()
	p1:StopIdleAnimation()
	p1:StopFootstepSound()
	p1._sleepTrack:Stop(0.1)
	p1._hitTrack:Stop(0.1)

	if p1._footstepSound ~= nil then
		p1._footstepSound:Destroy()
	end

	if p1._afterWakeSound ~= nil then
		p1._afterWakeSound:Destroy()
	end

	p1._hitSound:Destroy()
	p1._sleepSound:Destroy()
	p1._wakeSound:Destroy()
end
function t.PlaySleep(p1, p2) --[[ PlaySleep | Line: 155 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)

	if not p1._sleepTrack.IsPlaying then
		p1._sleepTrack:Play(p2)
	end

	if p1._sleepSound.IsPlaying then
		return
	end

	p1._sleepSound.Looped = true
	p1._sleepSound.TimePosition = 0
	p1._sleepSound:Play()
end
function t.StopSleep(p1, p2) --[[ StopSleep | Line: 167 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)
	p1._sleepTrack:Stop(p2)
	p1._sleepSound:Stop()
end
function t.PlayWake(p1) --[[ PlayWake | Line: 173 ]]
	p1._wakeSound.TimePosition = 0
	p1._wakeSound:Play()
end
function t.PlayAfterWake(p1) --[[ PlayAfterWake | Line: 178 | Upvalues: Audio (copy), t (copy) ]]
	local _afterWakeSound = p1._afterWakeSound

	if _afterWakeSound == nil then
		return
	end

	local v1 = p1._afterWakeSoundConfigs[p1._random:NextInteger(1, #p1._afterWakeSoundConfigs)]

	assert(v1 ~= nil, "AfterWakeSound playback requires a configured sound")
	_afterWakeSound:Stop()
	Audio.PrepareSoundFromSoundFile(_afterWakeSound, t.CreateSoundFile(v1))
	_afterWakeSound.TimePosition = 0
	_afterWakeSound:Play()
end
function t.ScheduleAfterWake(p1, p2) --[[ ScheduleAfterWake | Line: 191 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)

	if p1._afterWakeSound == nil then
		return
	end

	p1._afterWakeSoundAt = p2 + 1
end
function t.CancelAfterWake(p1) --[[ CancelAfterWake | Line: 198 ]]
	p1._afterWakeSoundAt = nil
end
function t.UpdateAfterWake(p1, p2, p3) --[[ UpdateAfterWake | Line: 202 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)
	Asserts.boolean(p3)

	local _afterWakeSoundAt = p1._afterWakeSoundAt

	if _afterWakeSoundAt == nil or p2 < _afterWakeSoundAt then
		return
	end

	p1._afterWakeSoundAt = nil

	if not p3 then
		return
	end

	p1:PlayAfterWake()
end
function t.PlayHit(p1) --[[ PlayHit | Line: 221 ]]
	p1:StopWalkAnimation()
	p1:StopFootstepSound()
	p1:EnsureIdleAnimation()
	p1._hitTrack.TimePosition = 0
	p1._hitTrack:Play(0.05)
	p1._hitSound.TimePosition = 0
	p1._hitSound:Play()

	return p1._hitTrack.Length
end
function t.EnsureFootstepSound(p1, p2) --[[ EnsureFootstepSound | Line: 232 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)

	local _footstepSound = p1._footstepSound
	local _footstepPlaybackSpeed = p1._footstepPlaybackSpeed

	if _footstepSound == nil or _footstepPlaybackSpeed == nil then
		return
	end

	_footstepSound.PlaybackSpeed = _footstepPlaybackSpeed * math.max(p2 / p1._animationBaseWalkSpeed, 0.01)

	if _footstepSound.IsPlaying then
		return
	end

	_footstepSound.Looped = true
	_footstepSound.TimePosition = 0
	_footstepSound:Play()
end
function t.StopFootstepSound(p1) --[[ StopFootstepSound | Line: 247 ]]
	local _footstepSound = p1._footstepSound

	if _footstepSound == nil or not _footstepSound.IsPlaying then
		return
	end

	_footstepSound:Stop()
end
function t.EnsureIdleAnimation(p1) --[[ EnsureIdleAnimation | Line: 254 ]]
	if p1._idleTrack.IsPlaying then
		return
	end

	p1._idleTrack:Play(0.2)
end
function t.StopIdleAnimation(p1) --[[ StopIdleAnimation | Line: 260 ]]
	if not p1._idleTrack.IsPlaying then
		return
	end

	p1._idleTrack:Stop(0.2)
end
function t.EnsureWalkAnimation(p1, p2) --[[ EnsureWalkAnimation | Line: 266 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)
	p1:StopIdleAnimation()
	p1:EnsureFootstepSound(p2)
	p1._walkTrack:AdjustSpeed((math.max(p2 / p1._animationBaseWalkSpeed, 0.01)))

	if p1._walkTrack.IsPlaying then
		return
	end

	p1._walkTrack:Play(0.4)
end
function t.StopWalkAnimation(p1) --[[ StopWalkAnimation | Line: 276 ]]
	if not p1._walkTrack.IsPlaying then
		return
	end

	p1._walkTrack:Stop(0.2)
end

return t