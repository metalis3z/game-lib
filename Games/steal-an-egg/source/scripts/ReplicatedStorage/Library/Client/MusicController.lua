-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Library.Audio)
local AreaEggResetCycle = require(ReplicatedStorage.Directory.AreaEggResetCycle)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local CreateMusicSound = require(ReplicatedStorage.Library.Audio.CreateMusicSound)
local GuardAreaLookupUtil = require(ReplicatedStorage.Library.Util.GuardAreaLookupUtil)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Player = require(ReplicatedStorage.Library.Player)
local SettingsCmds = require(ReplicatedStorage.Library.Client.SettingsCmds)
local Shuffle = require(ReplicatedStorage.Library.Functions.Shuffle)
local Treadmills = require(ReplicatedStorage.Directory.Treadmills)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Variables = require(ReplicatedStorage.Library.Variables)
local t = {
	Id = 5026653246,
	Volume = 1.5
}
local t2 = {
	Id = 77770487605071,
	Volume = 0.4
}
local t3 = {
	{
		Id = 1836009208,
		Volume = 0.22
	},
	{
		Id = 1846088038,
		Volume = 0.22
	},
	{
		Id = 9045766074,
		Volume = 0.22
	},
	{
		Id = 1842150151,
		Volume = 0.22
	}
}
local t4 = {
	{
		Id = 77770487605071,
		Volume = 0.5
	}
}
local t5 = {
	{
		Id = 95532010565428,
		Volume = 0
	},
	{
		Id = 140667339171815,
		Volume = 0
	},
	{
		Id = 95532010565428,
		Volume = 0
	}
}
local Quad = Enum.EasingStyle.Quad
local InOut = Enum.EasingDirection.InOut
local Treadmills2 = Constants.NETWORK_MAP.Treadmills
local LocalPlayer = Players.LocalPlayer
local v1 = Log.new():LimitUnderLevel("Warning")
local __OBJECTS = Workspace.__OBJECTS

assert(__OBJECTS:IsA("Folder"), "Workspace.__OBJECTS must be a Folder")

local Areas = __OBJECTS.Areas

assert(Areas:IsA("Folder"), "Workspace.__OBJECTS.Areas must be a Folder")

local SeparationLine = Areas.SeparationLine

assert(SeparationLine:IsA("BasePart"), "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")

local t6 = {}
local v5 = nil

local function createManagedSound(p1, p2, p3, p4) --[[ createManagedSound | Line: 111 ]]
	local t = {
		Tween = nil,
		Generation = 0,
		ResumeTimePosition = 0,
		Sound = p1,
		BaseVolume = p2
	}

	t.ShouldResumeTimePosition = if p3 == true then true else false
	t.KeepPlayingWhenSilent = p4 == true

	return t
end

local function resolveOutsideStates() --[[ resolveOutsideStates | Line: 128 | Upvalues: t3 (copy), CreateMusicSound (copy) ]]
	local t = {}

	for i, v in ipairs(t3) do
		t[#t + 1] = {
			Tween = nil,
			Generation = 0,
			ResumeTimePosition = 0,
			ShouldResumeTimePosition = false,
			KeepPlayingWhenSilent = true,
			Sound = CreateMusicSound(("OutsidePlaylistMusic_%*_%*"):format(i, v.Id), v.Id, false),
			BaseVolume = v.Volume
		}
	end

	assert(#t > 0, "MusicController expected at least one outside playlist track")

	return t
end

local function resolveInStagesState() --[[ resolveInStagesState | Line: 140 | Upvalues: CreateMusicSound (copy) ]]
	return {
		BaseVolume = 0.4,
		Tween = nil,
		Generation = 0,
		ResumeTimePosition = 0,
		ShouldResumeTimePosition = false,
		KeepPlayingWhenSilent = false,
		Sound = CreateMusicSound(("CoreGameplayMusic_%*"):format(77770487605071), 77770487605071, true)
	}
end

local function resolveGameplayBackgroundState() --[[ resolveGameplayBackgroundState | Line: 146 | Upvalues: CreateMusicSound (copy) ]]
	return {
		BaseVolume = 1.5,
		Tween = nil,
		Generation = 0,
		ResumeTimePosition = 0,
		ShouldResumeTimePosition = false,
		KeepPlayingWhenSilent = false,
		Sound = CreateMusicSound(("GameplayBackgroundMusic_%*"):format(5026653246), 5026653246, true)
	}
end

local function resolveResetNightState() --[[ resolveResetNightState | Line: 155 | Upvalues: AreaEggResetCycle (copy), CreateMusicSound (copy) ]]
	local NightMusic = AreaEggResetCycle.NightMusic

	if NightMusic == nil then
		return nil
	end

	return {
		Tween = nil,
		Generation = 0,
		ResumeTimePosition = 0,
		ShouldResumeTimePosition = false,
		KeepPlayingWhenSilent = false,
		Sound = CreateMusicSound(("AreaEggResetNightMusic_%*"):format(NightMusic.Id), NightMusic.Id, true),
		BaseVolume = NightMusic.Volume
	}
end

local function createSaveZoneSound(p1) --[[ createSaveZoneSound | Line: 165 | Upvalues: CreateMusicSound (copy) ]]
	return {
		Tween = nil,
		Generation = 0,
		ResumeTimePosition = 0,
		ShouldResumeTimePosition = false,
		KeepPlayingWhenSilent = false,
		Sound = CreateMusicSound(("SaveZoneMusic_%*"):format(p1.Id), p1.Id, true),
		BaseVolume = p1.Volume
	}
end

local function createTreadmillSound(p1) --[[ createTreadmillSound | Line: 170 | Upvalues: CreateMusicSound (copy) ]]
	return {
		Tween = nil,
		Generation = 0,
		ResumeTimePosition = 0,
		ShouldResumeTimePosition = false,
		KeepPlayingWhenSilent = false,
		Sound = CreateMusicSound(("TreadmillMusic_%*_%*"):format(p1.Id, (math.floor(p1.Volume * 100))), p1.Id, false),
		BaseVolume = p1.Volume
	}
end

local function refillOutsideOrder(p1) --[[ refillOutsideOrder | Line: 175 | Upvalues: Shuffle (copy) ]]
	table.clear(p1.OutsideOrder)

	for i = 1, #p1.OutsideStates do
		p1.OutsideOrder[i] = i
	end

	Shuffle(p1.OutsideOrder, p1.OutsideRandom)
	p1.CurrentOutsideOrderPosition = 1
	p1.CurrentOutsideIndex = assert(p1.OutsideOrder[p1.CurrentOutsideOrderPosition], "MusicController outside playlist order must not be empty")
end

local function resolveRuntime() --[[ resolveRuntime | Line: 189 | Upvalues: v5 (ref), Trove (copy), resolveOutsideStates (copy), CreateMusicSound (copy), t (copy), t2 (copy), AreaEggResetCycle (copy), Variables (copy), SettingsCmds (copy), refillOutsideOrder (copy) ]]
	local v1 = v5

	if v1 ~= nil then
		return v1
	end

	local t3 = {
		GameplaySideScanAccumulator = 0,
		CurrentOutsideIndex = 1,
		CurrentOutsideOrderPosition = 1,
		CurrentTreadmillIndex = 1,
		GameplayAreaActive = false,
		ResetNightActive = false,
		ResetNightTrackActive = false,
		SaveZoneActive = false,
		Started = false,
		NonDefaultTreadmillActive = false,
		LastDesiredMode = nil,
		Trove = Trove.new(),
		OutsideStates = resolveOutsideStates(),
		GameplayBackgroundState = {
			Tween = nil,
			Generation = 0,
			ResumeTimePosition = 0,
			ShouldResumeTimePosition = false,
			KeepPlayingWhenSilent = false,
			Sound = CreateMusicSound(("GameplayBackgroundMusic_%*"):format(t.Id), t.Id, true),
			BaseVolume = t.Volume
		},
		InStagesState = {
			Tween = nil,
			Generation = 0,
			ResumeTimePosition = 0,
			ShouldResumeTimePosition = false,
			KeepPlayingWhenSilent = false,
			Sound = CreateMusicSound(("CoreGameplayMusic_%*"):format(t2.Id), t2.Id, true),
			BaseVolume = t2.Volume
		}
	}
	local NightMusic = AreaEggResetCycle.NightMusic

	t3.ResetNightState = if NightMusic == nil then nil else {
	Tween = nil,
	Generation = 0,
	ResumeTimePosition = 0,
	ShouldResumeTimePosition = false,
	KeepPlayingWhenSilent = false,
	Sound = CreateMusicSound(("AreaEggResetNightMusic_%*"):format(NightMusic.Id), NightMusic.Id, true),
	BaseVolume = NightMusic.Volume
}
	t3.SaveZoneStates = {}
	t3.TreadmillStates = {}
	t3.OutsideOrder = {}
	t3.OutsideRandom = Random.new()
	t3.CarryingAreaEgg = Variables.Locks.AreaEggRunBack:IsLocked()
	t3.GuardedGameplayActive = Variables.Locks.GuardedGameplayMusic:IsLocked()
	t3.MusicEnabled = SettingsCmds.IsEnabled("Music")
	t3.UiHidden = Variables.Locks.HideUI:IsLocked()
	refillOutsideOrder(t3)
	v5 = t3

	return t3
end

local function resolveResumeTimePosition(p1) --[[ resolveResumeTimePosition | Line: 227 ]]
	local Sound = p1.Sound
	local ResumeTimePosition = p1.ResumeTimePosition

	if Sound.TimeLength > 0 and Sound.TimeLength - 0.05 <= ResumeTimePosition then
		return 0
	end

	return ResumeTimePosition
end

local function ensureSoundPlaying(p1) --[[ ensureSoundPlaying | Line: 238 ]]
	local Sound = p1.Sound

	if Sound.TimeLength > 0 and Sound.TimePosition >= Sound.TimeLength - 0.05 then
		Sound.TimePosition = 0
	end

	if p1.ShouldResumeTimePosition and not Sound.IsPlaying then
		local Sound2 = p1.Sound
		local ResumeTimePosition = p1.ResumeTimePosition

		Sound.TimePosition = if Sound2.TimeLength > 0 and Sound2.TimeLength - 0.05 <= ResumeTimePosition then 0 else ResumeTimePosition
	end

	if Sound.IsPlaying then
		return
	end

	Sound:Play()
end

local function finalizeMutedState(p1) --[[ finalizeMutedState | Line: 253 ]]
	local Sound = p1.Sound

	if p1.ShouldResumeTimePosition then
		p1.ResumeTimePosition = Sound.TimePosition
	end

	if Sound.IsPlaying then
		Sound:Pause()
	end

	Sound.Volume = 0
end

local function resetManagedSoundTimePosition(p1) --[[ resetManagedSoundTimePosition | Line: 265 ]]
	local Sound = p1.Sound

	p1.ResumeTimePosition = 0
	Sound.TimePosition = 0
end

local function stopManagedSoundImmediately(p1) --[[ stopManagedSoundImmediately | Line: 271 ]]
	p1.Generation = p1.Generation + 1

	local Tween = p1.Tween

	if Tween ~= nil then
		Tween:Cancel()
		p1.Tween = nil
	end

	local Sound = p1.Sound

	if p1.ShouldResumeTimePosition then
		p1.ResumeTimePosition = Sound.TimePosition
	end

	if Sound.IsPlaying then
		Sound:Pause()
	end

	Sound.Volume = 0
end

local function driveManagedSound(p1, p2, p3, p4) --[[ driveManagedSound | Line: 283 | Upvalues: Audio (copy), Quad (copy), InOut (copy) ]]
	local Sound = p1.Sound

	p1.Generation = p1.Generation + 1

	local Generation = p1.Generation
	local Tween = p1.Tween

	if Tween ~= nil then
		Tween:Cancel()
		p1.Tween = nil
	end

	if p2 then
		local Sound2 = p1.Sound

		if Sound2.TimeLength > 0 and Sound2.TimePosition >= Sound2.TimeLength - 0.05 then
			Sound2.TimePosition = 0
		end

		if p1.ShouldResumeTimePosition and not Sound2.IsPlaying then
			local Sound3 = p1.Sound
			local ResumeTimePosition = p1.ResumeTimePosition

			Sound2.TimePosition = if Sound3.TimeLength > 0 and Sound3.TimeLength - 0.05 <= ResumeTimePosition then 0 else ResumeTimePosition
		end

		if not Sound2.IsPlaying then
			Sound2:Play()
		end
	end

	if not (math.abs(Sound.Volume - p3) <= 0.001) then
		local v3 = Audio.Fade(Sound, p3, p4, Quad, InOut)

		p1.Tween = v3
		v3.Completed:Once(function(p12) --[[ Line: 315 | Upvalues: p1 (copy), Generation (copy), v3 (copy), Sound (copy), p3 (copy), p2 (copy) ]]
			if p1.Generation ~= Generation or p1.Tween ~= v3 then
				return
			end

			p1.Tween = nil

			if p12 ~= Enum.PlaybackState.Completed then
				return
			end

			Sound.Volume = p3

			if not (p3 <= 0) or p2 and p1.KeepPlayingWhenSilent then
				return
			end

			local v1 = p1
			local Sound2 = v1.Sound

			if v1.ShouldResumeTimePosition then
				v1.ResumeTimePosition = Sound2.TimePosition
			end

			if Sound2.IsPlaying then
				Sound2:Pause()
			end

			Sound2.Volume = 0
		end)

		return
	end

	Sound.Volume = p3

	if not (p3 <= 0) or p2 and p1.KeepPlayingWhenSilent then
		return
	end

	local Sound2 = p1.Sound

	if p1.ShouldResumeTimePosition then
		p1.ResumeTimePosition = Sound2.TimePosition
	end

	if Sound2.IsPlaying then
		Sound2:Pause()
	end

	Sound2.Volume = 0
end

local function ensureSaveZoneStates(p1) --[[ ensureSaveZoneStates | Line: 332 | Upvalues: t4 (copy), CreateMusicSound (copy) ]]
	if #p1.SaveZoneStates > 0 then
		return p1.SaveZoneStates
	end

	for i, v in ipairs(t4) do
		p1.SaveZoneStates[#p1.SaveZoneStates + 1] = {
			Tween = nil,
			Generation = 0,
			ResumeTimePosition = 0,
			ShouldResumeTimePosition = false,
			KeepPlayingWhenSilent = false,
			Sound = CreateMusicSound(("SaveZoneMusic_%*"):format(v.Id), v.Id, true),
			BaseVolume = v.Volume
		}
	end

	return p1.SaveZoneStates
end

local function ensureTreadmillStates(p1) --[[ ensureTreadmillStates | Line: 344 | Upvalues: t5 (copy), CreateMusicSound (copy) ]]
	if #p1.TreadmillStates > 0 then
		return p1.TreadmillStates
	end

	for i, v in ipairs(t5) do
		p1.TreadmillStates[#p1.TreadmillStates + 1] = {
			Tween = nil,
			Generation = 0,
			ResumeTimePosition = 0,
			ShouldResumeTimePosition = false,
			KeepPlayingWhenSilent = false,
			Sound = CreateMusicSound(("TreadmillMusic_%*_%*"):format(v.Id, (math.floor(v.Volume * 100))), v.Id, false),
			BaseVolume = v.Volume
		}
	end

	return p1.TreadmillStates
end

local function resetTreadmillPlaylist(p1) --[[ resetTreadmillPlaylist | Line: 356 | Upvalues: ensureTreadmillStates (copy) ]]
	p1.CurrentTreadmillIndex = 1

	for i, v in ipairs((ensureTreadmillStates(p1))) do
		v.Generation = v.Generation + 1

		local Tween = v.Tween

		if Tween ~= nil then
			Tween:Cancel()
			v.Tween = nil
		end

		local Sound = v.Sound

		if v.ShouldResumeTimePosition then
			v.ResumeTimePosition = Sound.TimePosition
		end

		if Sound.IsPlaying then
			Sound:Pause()
		end

		Sound.Volume = 0
		v.Sound.TimePosition = 0
	end
end

local function resolveDesiredMode(p1) --[[ resolveDesiredMode | Line: 365 ]]
	if not p1.MusicEnabled then
		return "Muted"
	end

	if p1.ResetNightActive then
		return "ResetNight"
	end

	if p1.NonDefaultTreadmillActive then
		return "Treadmill"
	end

	if p1.GuardedGameplayActive then
		return "Muted"
	end

	if p1.GameplayAreaActive then
		if p1.CarryingAreaEgg then
			return "GuardedGameplay"
		end

		return "GameplayBackground"
	end

	if p1.UiHidden then
		return "Muted"
	end

	if p1.SaveZoneActive then
		return "SaveZone"
	end

	return "Outside"
end

local function moveToNextOutsideTrack(p1) --[[ moveToNextOutsideTrack | Line: 401 | Upvalues: refillOutsideOrder (copy) ]]
	p1.CurrentOutsideOrderPosition = p1.CurrentOutsideOrderPosition + 1

	if p1.CurrentOutsideOrderPosition > #p1.OutsideOrder then
		refillOutsideOrder(p1)
	else
		p1.CurrentOutsideIndex = assert(p1.OutsideOrder[p1.CurrentOutsideOrderPosition], "MusicController outside playlist order position must reference a track")
	end
end

local function applyMusicState(p1) --[[ applyMusicState | Line: 414 | Upvalues: resetTreadmillPlaylist (copy), v1 (copy), driveManagedSound (copy), ensureSaveZoneStates (copy), ensureTreadmillStates (copy), AreaEggResetCycle (copy) ]]
	local v12 = if p1.MusicEnabled then if p1.ResetNightActive then "ResetNight" elseif p1.NonDefaultTreadmillActive then "Treadmill" elseif p1.GuardedGameplayActive then "Muted" elseif p1.GameplayAreaActive then if p1.CarryingAreaEgg then "GuardedGameplay" else "GameplayBackground" elseif p1.UiHidden then "Muted" elseif p1.SaveZoneActive then "SaveZone" else "Outside" else "Muted"
	local LastDesiredMode = p1.LastDesiredMode
	local v2 = if v12 == "GuardedGameplay" then true elseif LastDesiredMode == "GuardedGameplay" then true else false
	local v3 = if v12 == "GameplayBackground" then true elseif LastDesiredMode == "GameplayBackground" then true else false

	if LastDesiredMode ~= v12 then
		if v12 == "Treadmill" then
			resetTreadmillPlaylist(p1)
		end

		p1.LastDesiredMode = v12
		v1:AtDebug():Log("MusicController mode updated", {
			Mode = v12
		})
	end

	for i, v in ipairs(p1.OutsideStates) do
		local v4 = if i == p1.CurrentOutsideIndex then true else false

		driveManagedSound(v, v4, if if v12 == "Outside" then v4 else false then v.BaseVolume else 0, if v12 == "SaveZone" then 1 elseif v2 then 0.1 elseif v3 then 0.4 else 0.8)
	end

	local SaveZoneStates = p1.SaveZoneStates

	if v12 == "SaveZone" or #SaveZoneStates > 0 then
		SaveZoneStates = ensureSaveZoneStates(p1)
	end

	for i, v in ipairs(SaveZoneStates) do
		local v10, v11, v122
		local v13 = if v12 == "SaveZone" then true else false
		local v15 = if v13 then v.BaseVolume else 0

		if v2 then
			v10 = v
			v11 = v13
			v122 = 0.1
		elseif v3 then
			v10 = v
			v11 = v13
			v122 = 0.4
		else
			v10 = v
			v11 = v13
			v122 = 1.25
		end

		driveManagedSound(v10, v11, v15, v122)
	end

	local TreadmillStates = p1.TreadmillStates

	if v12 == "Treadmill" or #TreadmillStates > 0 then
		TreadmillStates = ensureTreadmillStates(p1)
	end

	for i, v in ipairs(TreadmillStates) do
		local v17, v18, v19
		local v20 = if v12 == "Treadmill" then if i == p1.CurrentTreadmillIndex then true else false else false
		local v22 = if v20 then v.BaseVolume else 0

		if v2 then
			v17 = v
			v18 = v20
			v19 = 0.1
		elseif v3 then
			v17 = v
			v18 = v20
			v19 = 0.4
		else
			v17 = v
			v18 = v20
			v19 = 1
		end

		driveManagedSound(v17, v18, v22, v19)
	end

	local GameplayBackgroundState = p1.GameplayBackgroundState
	local v23 = v12 == "GameplayBackground"

	driveManagedSound(GameplayBackgroundState, v23, if v23 then GameplayBackgroundState.BaseVolume else 0, if v2 then 0.1 else 0.4)

	local InStagesState = p1.InStagesState
	local v29 = if v12 == "GuardedGameplay" then true else false
	local v31 = if v29 then InStagesState.BaseVolume else 0
	local v32, v33, v34

	if v2 then
		v32 = InStagesState
		v33 = v29
		v34 = 0.1
	elseif v29 then
		v32 = InStagesState
		v33 = v29
		v34 = 1
	else
		v32 = InStagesState
		v33 = v29
		v34 = 0.8
	end

	driveManagedSound(v32, v33, v31, v34)

	local ResetNightState = p1.ResetNightState

	if ResetNightState == nil then
		return
	end

	local v35 = if v12 == "ResetNight" then p1.ResetNightTrackActive else false

	driveManagedSound(ResetNightState, v35, if v35 then ResetNightState.BaseVolume else 0, AreaEggResetCycle.MusicTransitionSeconds)
end

local function handleOutsideTrackEnded(p1, p2) --[[ handleOutsideTrackEnded | Line: 517 | Upvalues: refillOutsideOrder (copy), applyMusicState (copy) ]]
	if p2 ~= p1.CurrentOutsideIndex then
		return
	end

	p1.CurrentOutsideOrderPosition = p1.CurrentOutsideOrderPosition + 1

	if p1.CurrentOutsideOrderPosition > #p1.OutsideOrder then
		refillOutsideOrder(p1)
	else
		p1.CurrentOutsideIndex = assert(p1.OutsideOrder[p1.CurrentOutsideOrderPosition], "MusicController outside playlist order position must reference a track")
	end

	applyMusicState(p1)
end

local function moveToNextTreadmillTrack(p1) --[[ moveToNextTreadmillTrack | Line: 526 ]]
	p1.CurrentTreadmillIndex = p1.CurrentTreadmillIndex + 1

	if not (p1.CurrentTreadmillIndex > #p1.TreadmillStates) then
		return
	end

	p1.CurrentTreadmillIndex = 1
end

local function handleTreadmillTrackEnded(p1, p2) --[[ handleTreadmillTrackEnded | Line: 533 | Upvalues: applyMusicState (copy) ]]
	if (if p1.MusicEnabled then if p1.ResetNightActive then "ResetNight" elseif p1.NonDefaultTreadmillActive then "Treadmill" elseif p1.GuardedGameplayActive then "Muted" elseif p1.GameplayAreaActive then if p1.CarryingAreaEgg then "GuardedGameplay" else "GameplayBackground" elseif p1.UiHidden then "Muted" elseif p1.SaveZoneActive then "SaveZone" else "Outside" else "Muted") ~= "Treadmill" then
		return
	end

	if p2 ~= p1.CurrentTreadmillIndex then
		return
	end

	p1.CurrentTreadmillIndex = p1.CurrentTreadmillIndex + 1

	if p1.CurrentTreadmillIndex > #p1.TreadmillStates then
		p1.CurrentTreadmillIndex = 1
	end

	applyMusicState(p1)
end

local function updateGameplayAreaState(p1) --[[ updateGameplayAreaState | Line: 546 | Upvalues: Player (copy), LocalPlayer (copy), GuardAreaLookupUtil (copy), SeparationLine (copy), applyMusicState (copy) ]]
	local v1 = Player.Optional.HumanoidRootPart(LocalPlayer)
	local v2 = if v1 == nil or not v1:IsA("BasePart") then false else GuardAreaLookupUtil.IsInGameplaySide(SeparationLine, v1.Position)

	if p1.GameplayAreaActive ~= v2 then
		p1.GameplayAreaActive = v2
		applyMusicState(p1)
	end
end

function t6.StartSaveZoneMusic() --[[ StartSaveZoneMusic | Line: 566 | Upvalues: resolveRuntime (copy), applyMusicState (copy) ]]
	local v1 = resolveRuntime()

	if not v1.SaveZoneActive then
		v1.SaveZoneActive = true
		applyMusicState(v1)
	end
end
function t6.StopSaveZoneMusic() --[[ StopSaveZoneMusic | Line: 576 | Upvalues: resolveRuntime (copy), applyMusicState (copy) ]]
	local v1 = resolveRuntime()

	if v1.SaveZoneActive then
		v1.SaveZoneActive = false
		applyMusicState(v1)
	end
end
function t6.StopInStagesMusicInstant() --[[ StopInStagesMusicInstant | Line: 586 | Upvalues: resolveRuntime (copy) ]]
	local InStagesState = resolveRuntime().InStagesState

	InStagesState.Generation = InStagesState.Generation + 1

	local Tween = InStagesState.Tween

	if Tween ~= nil then
		Tween:Cancel()
		InStagesState.Tween = nil
	end

	local Sound = InStagesState.Sound

	if InStagesState.ShouldResumeTimePosition then
		InStagesState.ResumeTimePosition = Sound.TimePosition
	end

	if Sound.IsPlaying then
		Sound:Pause()
	end

	Sound.Volume = 0
end
function t6.ResetInStagesMusicInstant() --[[ ResetInStagesMusicInstant | Line: 591 | Upvalues: resolveRuntime (copy) ]]
	local InStagesState = resolveRuntime().InStagesState

	InStagesState.Generation = InStagesState.Generation + 1

	local Tween = InStagesState.Tween

	if Tween ~= nil then
		Tween:Cancel()
		InStagesState.Tween = nil
	end

	local Sound = InStagesState.Sound

	if InStagesState.ShouldResumeTimePosition then
		InStagesState.ResumeTimePosition = Sound.TimePosition
	end

	if Sound.IsPlaying then
		Sound:Pause()
	end

	Sound.Volume = 0

	local Sound2 = InStagesState.Sound

	InStagesState.ResumeTimePosition = 0
	Sound2.TimePosition = 0
end
function t6.IsNonDefaultTreadmillActive() --[[ IsNonDefaultTreadmillActive | Line: 598 | Upvalues: resolveRuntime (copy) ]]
	return resolveRuntime().NonDefaultTreadmillActive
end
function t6.SetResetNightActive(p1, p2) --[[ SetResetNightActive | Line: 602 | Upvalues: resolveRuntime (copy), applyMusicState (copy) ]]
	local v1 = resolveRuntime()
	local v2 = if p1 then p2 == true else p1

	if v1.ResetNightActive == p1 and v1.ResetNightTrackActive == v2 then
		return
	end

	v1.ResetNightActive = p1
	v1.ResetNightTrackActive = v2
	applyMusicState(v1)
end
function t6.Start() --[[ Start | Line: 614 | Upvalues: resolveRuntime (copy), refillOutsideOrder (copy), applyMusicState (copy), ensureTreadmillStates (copy), SettingsCmds (copy), Variables (copy), Network (copy), Treadmills2 (copy), Treadmills (copy), RunService (copy), updateGameplayAreaState (copy) ]]
	local v1 = resolveRuntime()

	if v1.Started then
		return
	end

	v1.Started = true

	for i, v in ipairs(v1.OutsideStates) do
		v1.Trove:Add(v.Sound.Ended:Connect(function() --[[ Line: 623 | Upvalues: v1 (copy), i (copy), refillOutsideOrder (ref), applyMusicState (ref) ]]
			local v12 = v1

			if i ~= v12.CurrentOutsideIndex then
				return
			end

			v12.CurrentOutsideOrderPosition = v12.CurrentOutsideOrderPosition + 1

			if v12.CurrentOutsideOrderPosition > #v12.OutsideOrder then
				refillOutsideOrder(v12)
			else
				v12.CurrentOutsideIndex = assert(v12.OutsideOrder[v12.CurrentOutsideOrderPosition], "MusicController outside playlist order position must reference a track")
			end

			applyMusicState(v12)
		end))
	end

	for i, v in ipairs((ensureTreadmillStates(v1))) do
		v1.Trove:Add(v.Sound.Ended:Connect(function() --[[ Line: 629 | Upvalues: v1 (copy), i (copy), applyMusicState (ref) ]]
			local v12 = v1

			if (if v12.MusicEnabled then if v12.ResetNightActive then "ResetNight" elseif v12.NonDefaultTreadmillActive then "Treadmill" elseif v12.GuardedGameplayActive then "Muted" elseif v12.GameplayAreaActive then if v12.CarryingAreaEgg then "GuardedGameplay" else "GameplayBackground" elseif v12.UiHidden then "Muted" elseif v12.SaveZoneActive then "SaveZone" else "Outside" else "Muted") ~= "Treadmill" then
				return
			end

			if i ~= v12.CurrentTreadmillIndex then
				return
			end

			v12.CurrentTreadmillIndex = v12.CurrentTreadmillIndex + 1

			if v12.CurrentTreadmillIndex > #v12.TreadmillStates then
				v12.CurrentTreadmillIndex = 1
			end

			applyMusicState(v12)
		end))
	end

	v1.Trove:Add(SettingsCmds.Changed:Connect(function(p1, p2) --[[ Line: 634 | Upvalues: v1 (copy), applyMusicState (ref) ]]
		if p1 == "Music" then
			v1.MusicEnabled = p2
			applyMusicState(v1)
		end
	end))
	v1.Trove:Add(Variables.Locks.HideUI.Modified:Connect(function() --[[ Line: 643 | Upvalues: v1 (copy), Variables (ref), applyMusicState (ref) ]]
		v1.UiHidden = Variables.Locks.HideUI:IsLocked()
		applyMusicState(v1)
	end))
	v1.Trove:Add(Variables.Locks.GuardedGameplayMusic.Modified:Connect(function() --[[ Line: 648 | Upvalues: v1 (copy), Variables (ref), applyMusicState (ref) ]]
		v1.GuardedGameplayActive = Variables.Locks.GuardedGameplayMusic:IsLocked()
		applyMusicState(v1)
	end))
	v1.Trove:Add(Variables.Locks.AreaEggRunBack.Modified:Connect(function() --[[ Line: 653 | Upvalues: v1 (copy), Variables (ref), applyMusicState (ref) ]]
		v1.CarryingAreaEgg = Variables.Locks.AreaEggRunBack:IsLocked()
		applyMusicState(v1)
	end))
	v1.Trove:Add(Network.Fired(Treadmills2.ACTIVE_TREADMILL_EVENT):Connect(function(p1) --[[ Line: 658 | Upvalues: Treadmills (ref), v1 (copy), applyMusicState (ref) ]]
		local v12

		if p1 == nil then
			v12 = false
		else
			local v2 = Treadmills.GetUpgradeLevel(p1) ~= nil

			assert(v2, (("Missing treadmill config \"%*\""):format(p1)))
			v12 = true
		end

		v1.NonDefaultTreadmillActive = v12
		applyMusicState(v1)
	end))
	v1.Trove:Add(RunService.Heartbeat:Connect(function(p1) --[[ Line: 669 | Upvalues: v1 (copy), updateGameplayAreaState (ref) ]]
		local v12 = v1

		v12.GameplaySideScanAccumulator = v12.GameplaySideScanAccumulator + p1

		if not (v1.GameplaySideScanAccumulator < 0.1) then
			v1.GameplaySideScanAccumulator = 0
			updateGameplayAreaState(v1)
		end
	end))
	updateGameplayAreaState(v1)
	applyMusicState(v1)
end
t6.Start()

return t6