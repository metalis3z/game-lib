-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local AreaEggResetCycle = require(ReplicatedStorage.Directory.AreaEggResetCycle)
local AreaEggResetTimeUtil = require(ReplicatedStorage.Library.Util.AreaEggResetTimeUtil)
local Audio = require(ReplicatedStorage.Library.Audio)
local LightingsController = require(ReplicatedStorage.Library.Client.LightingsController)

require(ReplicatedStorage.Directory.Lightings)

local MusicController = require(ReplicatedStorage.Library.Client.MusicController)
local PreloadSounds = require(ReplicatedStorage.Library.Functions.PreloadSounds)
local DayTransitionSoundId = AreaEggResetCycle.DayTransitionSoundId
local v1 = nil

local function transformToNight(p1) --[[ transformToNight | Line: 31 | Upvalues: AreaEggResetCycle (copy) ]]
	local v1 = table.clone(p1)
	local NightLighting = AreaEggResetCycle.NightLighting

	v1.Ambient = NightLighting.Ambient
	v1.Brightness = NightLighting.Brightness
	v1.ClockTime = NightLighting.ClockTime
	v1.ColorShift_Bottom = NightLighting.ColorShift_Bottom
	v1.ColorShift_Top = NightLighting.ColorShift_Top
	v1.OutdoorAmbient = NightLighting.OutdoorAmbient

	return v1
end

local function resolvePhase(p1) --[[ resolvePhase | Line: 43 | Upvalues: AreaEggResetTimeUtil (copy), AreaEggResetCycle (copy) ]]
	if AreaEggResetTimeUtil.IsNight(p1) then
		return "Night"
	end

	if AreaEggResetTimeUtil.IsNightTransition(p1, AreaEggResetCycle.NightLightingTransitionSeconds, AreaEggResetCycle.NightLightingStartDelaySeconds) then
		return "NightTransition"
	end

	return "Day"
end

local function setPhase(p1, p2, p3) --[[ setPhase | Line: 59 | Upvalues: v1 (ref), AreaEggResetTimeUtil (copy), AreaEggResetCycle (copy), LightingsController (copy), transformToNight (copy), MusicController (copy), DayTransitionSoundId (copy), Audio (copy), SoundService (copy) ]]
	if v1 == p1 then
		return
	end

	local v12 = v1

	v1 = p1

	if p1 == "NightTransition" then
		LightingsController:SetModifier("AreaEggResetNight", transformToNight, AreaEggResetCycle.LightingModifierPriority, (math.max(AreaEggResetTimeUtil.GetNightStartsAt(p3) + AreaEggResetCycle.NightLightingStartDelaySeconds - p3, 0)))
		MusicController.SetResetNightActive(false)

		return
	end

	if p1 == "Night" then
		if v12 ~= "NightTransition" then
			LightingsController:SetModifier("AreaEggResetNight", transformToNight, AreaEggResetCycle.LightingModifierPriority, (math.max(AreaEggResetTimeUtil.GetNightStartsAt(p3) + AreaEggResetCycle.NightLightingStartDelaySeconds - p3, 0)))
		end

		MusicController.SetResetNightActive(true, true)
	else
		LightingsController:ClearModifier("AreaEggResetNight", if p2 or v12 == nil then 0 else AreaEggResetCycle.DayLightingTransitionSeconds)
		MusicController.SetResetNightActive(false)

		if p2 or DayTransitionSoundId == nil then
			return
		end

		Audio.Play(DayTransitionSoundId, SoundService)
	end
end

local function runCycle() --[[ runCycle | Line: 104 | Upvalues: Workspace (copy), AreaEggResetTimeUtil (copy), AreaEggResetCycle (copy), setPhase (copy) ]]
	local v1 = true

	while true do
		local v2
		local v3 = Workspace:GetServerTimeNow()
		local v4 = if AreaEggResetTimeUtil.IsNight(v3) then "Night" elseif AreaEggResetTimeUtil.IsNightTransition(v3, AreaEggResetCycle.NightLightingTransitionSeconds, AreaEggResetCycle.NightLightingStartDelaySeconds) then "NightTransition" else "Day"

		setPhase(v4, v1, v3)
		v1 = false
		v2 = if v4 == "Night" then AreaEggResetTimeUtil.GetNextResetAt(v3) elseif v4 == "NightTransition" then AreaEggResetTimeUtil.GetNightStartsAt(v3) else AreaEggResetTimeUtil.GetNightTransitionStartsAt(v3, AreaEggResetCycle.NightLightingTransitionSeconds, AreaEggResetCycle.NightLightingStartDelaySeconds)

		local v8 = task.wait

		v8((math.min(math.max(v2 - Workspace:GetServerTimeNow(), 0.05), 0.1)))
	end
end

if DayTransitionSoundId == nil then
	runCycle()

	return
end

task.spawn(PreloadSounds, DayTransitionSoundId)
runCycle()