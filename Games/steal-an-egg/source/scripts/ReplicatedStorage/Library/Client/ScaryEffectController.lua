-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Audio = require(ReplicatedStorage.Library.Audio)
local CameraShaker = require(ReplicatedStorage.Library.Modules.Packages.CameraShaker)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local PreloadSounds = require(ReplicatedStorage.Library.Functions.PreloadSounds)
local Schema = require(script.Types.Schema)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)

require(script.Types.Interface)

local v1 = Log.new():LimitUnderLevel("Warning")
local t = { 113113198465358 }
local CurrentCamera = Workspace.CurrentCamera
local v2 = nil
local v3 = false
local v4 = 1
local t2 = {
	1.263728562240505,
	1.24413976577313,
	0.8219686932003283,
	1.074269037328637,
	0.7502054419233101,
	0.9848709870519721,
	0.9218227914770963,
	0.743954381007657,
	0.92724827099563,
	1.008364557765791,
	1.09791681826094,
	0.8170620855252841,
	0.7976348321317698,
	0.8978551805156156,
	1.252554092631066,
	0.7582926685664537,
	1.290053567694925,
	0.9533136158162119,
	0.8246673227008587,
	0.8527744096010031
}
local v5 = nil
local v6 = false
local v7 = false
local v8 = 0
local t3 = {}

local function requireResources() --[[ requireResources | Line: 81 | Upvalues: v2 (ref), Players (copy), SoundService (copy), TweenService (copy), CameraShaker (copy), CurrentCamera (ref), v6 (ref), v3 (ref), PreloadSounds (copy) ]]
	local v1 = v2

	if v1 ~= nil then
		return v1
	end

	local LocalPlayer = Players.LocalPlayer

	assert(LocalPlayer ~= nil, "Expected LocalPlayer")

	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

	assert(PlayerGui:IsA("PlayerGui"), "Expected PlayerGui")

	local Vignette = PlayerGui:WaitForChild("Vignette")

	assert(Vignette:IsA("ScreenGui"), "Expected Vignette ScreenGui")

	local Vignette2 = Vignette.Vignette

	assert(Vignette2:IsA("GuiObject"), "Expected Vignette frame")

	local UIScale = Vignette2.UIScale

	assert(UIScale:IsA("UIScale"), "Expected Vignette.UIScale")

	local FilmGrain = Vignette.FilmGrain

	assert(FilmGrain:IsA("ImageLabel"), "Expected Vignette.FilmGrain")

	local Ambience = Vignette.Ambience

	assert(Ambience:IsA("Sound"), "Expected Vignette.Ambience sound")

	local StealChase = SoundService.StealChase

	assert(StealChase:IsA("Sound"), "Expected SoundService.StealChase sound")

	local Volume = StealChase.Volume
	local v10 = TweenService:Create(StealChase, TweenInfo.new(0.2), {
		Volume = Volume
	})
	local v11 = TweenService:Create(StealChase, TweenInfo.new(3), {
		Volume = 0
	})
	local v12 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p1) --[[ Line: 111 | Upvalues: CurrentCamera (ref) ]]
		local v1 = CurrentCamera

		if not v1 or v1.CameraType == Enum.CameraType.Scriptable then
			return
		end

		v1.CFrame = v1.CFrame * p1
	end)
	local v13 = CameraShaker.CameraShakeInstance.new(2, 10, 0, 0)

	v13.PositionInfluence = Vector3.new(1, 1, 1)
	v13.RotationInfluence = Vector3.new(0.2, 0.2, 0.2)
	v12:ShakeSustain(v13)

	local t = {
		vignetteGui = Vignette,
		vignetteScale = UIScale,
		filmGrainEffect = FilmGrain,
		ambienceSound = Ambience,
		chaseSound = StealChase,
		chaseSoundBaseVolume = Volume,
		chaseFadeInTween = v10,
		chaseFadeOutTween = v11,
		cameraShake = v12,
		cameraShakeProperties = v13
	}

	v2 = t
	Vignette.Enabled = true
	v11.Completed:Connect(function(p1) --[[ Line: 137 | Upvalues: v6 (ref), StealChase (copy) ]]
		if v6 then
			return
		end

		if p1 ~= Enum.PlaybackState.Completed then
			return
		end

		StealChase:Stop()
		StealChase.Volume = 0
	end)

	if v3 then
		return t
	end

	v3 = true
	task.spawn(PreloadSounds, 128463138903874)

	return t
end

local function getFieldOfViewMultiplier(p1) --[[ getFieldOfViewMultiplier | Line: 156 ]]
	local v1 = p1:GetAttribute("FovMult")

	if typeof(v1) == "number" and v1 > 0 then
		return v1
	end

	return 1
end

local function normalizeToUnitRange(p1, p2, p3) --[[ normalizeToUnitRange | Line: 165 ]]
	return math.clamp((p1 - p2) / (p3 - p2), 0, 1)
end

local function resolvePart(p1, p2) --[[ resolvePart | Line: 169 | Upvalues: Asserts (copy) ]]
	local v1 = if p2 then p2() else p1

	if v1 == nil then
		return nil
	end

	Asserts.BasePart(v1)

	if v1.Parent == nil then
		return nil
	end

	return v1
end

local function stopChaseSound(p1) --[[ stopChaseSound | Line: 183 | Upvalues: v2 (ref), v6 (ref) ]]
	local v1 = v2

	if v1 == nil then
		v6 = false

		return
	end

	if not (v6 or p1) then
		return
	end

	if v6 then
		v6 = false
	end

	v1.chaseFadeInTween:Cancel()

	if p1 then
		v1.chaseFadeOutTween:Cancel()
		v1.chaseSound:Stop()
		v1.chaseSound.Volume = 0
	else
		v1.chaseFadeOutTween:Play()
	end
end

local function startChaseSound() --[[ startChaseSound | Line: 210 | Upvalues: requireResources (copy), v6 (ref) ]]
	local v1 = requireResources()

	v1.chaseSound.Looped = true
	v1.chaseFadeOutTween:Cancel()

	if v6 and (v1.chaseSound.IsPlaying and v1.chaseSound.Volume > 0) then
		return
	end

	v6 = true
	v1.chaseSound.Volume = 0

	if not v1.chaseSound.IsPlaying then
		v1.chaseSound:Play()
	end

	v1.chaseFadeInTween:Cancel()
	v1.chaseFadeInTween:Play()
end

local function resetVisualEffects(p1) --[[ resetVisualEffects | Line: 228 | Upvalues: v2 (ref), CurrentCamera (ref) ]]
	local v1 = v2

	if v1 ~= nil then
		v1.vignetteScale.Scale = 2.2
		v1.filmGrainEffect.Visible = false
		v1.filmGrainEffect.ImageTransparency = 1

		if v1.ambienceSound.IsPlaying then
			v1.ambienceSound:Stop()
		end

		v1.cameraShake:Stop()
	end

	local v22 = CurrentCamera

	if v22 == nil then
		return
	end

	local v4 = v22:GetAttribute("FovMult")

	v22.FieldOfView = (p1 or 75) * (if typeof(v4) == "number" and v4 > 0 then v4 else 1)
end

local function captureBaseFieldOfView(p1) --[[ captureBaseFieldOfView | Line: 251 | Upvalues: CurrentCamera (ref) ]]
	if p1.baseFieldOfView ~= nil then
		return p1.baseFieldOfView
	end

	local v1 = CurrentCamera

	if v1 == nil then
		return 75
	end

	local v2 = v1:GetAttribute("FovMult")

	return v1.FieldOfView / (if typeof(v2) == "number" and v2 > 0 then v2 else 1)
end

local function updateProximityStinger(p1, p2, p3) --[[ updateProximityStinger | Line: 264 | Upvalues: v7 (ref), v8 (ref), Audio (copy), CurrentCamera (ref), SoundService (copy) ]]
	if p1 == nil then
		v7 = false

		return
	end

	local v1 = os.clock()

	if p1 <= p2 and (not v7 and v8 <= v1) then
		v7 = true
		v8 = v1 + 3
		Audio.Play(128463138903874, CurrentCamera or (if p3 then p3 else SoundService), 1, 1)
	else
		if not (p2 < p1) then
			return
		end

		v7 = false
	end
end

local function updateProximityAudio(p1, p2, p3) --[[ updateProximityAudio | Line: 280 | Upvalues: stopChaseSound (copy), v7 (ref), updateProximityStinger (copy), startChaseSound (copy) ]]
	if p1 == nil then
		stopChaseSound()
		v7 = false

		return
	end

	updateProximityStinger(p1, p2.proximitySoundDistance or 145, p3)

	if p1 <= (p2.chaseSoundDistance or 146) then
		startChaseSound()
	else
		stopChaseSound()
	end
end

local function applyVisualEffects(p1, p2, p3) --[[ applyVisualEffects | Line: 299 | Upvalues: requireResources (copy), CurrentCamera (ref), v4 (ref), t2 (copy) ]]
	local v1 = requireResources()

	v1.vignetteScale.Scale = 2.2 - math.pow(p1, 0.5) * 1.2

	local v2 = CurrentCamera

	if v2 then
		local v42 = v2:GetAttribute("FovMult")

		v2.FieldOfView = (if p1 > 0.7 then p3 - (p1 - 0.7) * 10 else p3) * (if typeof(v42) == "number" and v42 > 0 then v42 else 1)
	end

	if p1 > 0.75 then
		v4 = v4 + p2 * 60

		if #t2 <= v4 then
			v4 = 1
		end

		local v7 = t2[math.floor(v4)]

		v1.filmGrainEffect.ImageTransparency = 1 - (p1 - 0.75) * 4
		v1.filmGrainEffect.TileSize = UDim2.new(0.1 * v7, math.floor(v7 * 10), 0.2 * v7, (math.floor(v7 * 12)))
		v1.filmGrainEffect.Visible = true
		v1.cameraShakeProperties.Magnitude = (p1 - 0.75) * 1.2
		v1.cameraShakeProperties.Roughness = (p1 - 0.75) * 100

		if not v1.ambienceSound.IsPlaying then
			v1.ambienceSound:Play()
			v1.cameraShake:Start()
		end

		v1.ambienceSound.Volume = (p1 - 0.75) * 2
	else
		v1.filmGrainEffect.Visible = false

		if v1.ambienceSound.IsPlaying then
			v1.ambienceSound:Stop()
		end

		v1.cameraShake:Stop()
	end
end

local function renderStep(p1) --[[ renderStep | Line: 341 | Upvalues: v5 (ref), Asserts (copy), stopChaseSound (copy), v7 (ref), resetVisualEffects (copy), updateProximityStinger (copy), startChaseSound (copy), applyVisualEffects (copy) ]]
	local v1 = v5

	if v1 == nil then
		return
	end

	local trackedPartResolver = v1.config.trackedPartResolver
	local v2 = if trackedPartResolver then trackedPartResolver() else v1.config.trackedPart
	local v3

	if v2 == nil then
		v3 = nil
	else
		Asserts.BasePart(v2)
		v3 = if v2.Parent == nil then nil else v2
	end

	local targetPartResolver = v1.config.targetPartResolver
	local v4 = if targetPartResolver then targetPartResolver() else v1.config.targetPart
	local v52

	if v4 == nil then
		v52 = nil
	else
		Asserts.BasePart(v4)
		v52 = if v4.Parent == nil then nil else v4
	end

	if v3 == nil or v52 == nil then
		local config = v1.config
		local _ = config.proximitySoundDistance or 145
		local _2 = config.chaseSoundDistance or 146

		stopChaseSound()
		v7 = false
		resetVisualEffects(v1.baseFieldOfView)

		return
	end

	if os.clock() < v1.effectReadyAt then
		local config = v1.config
		local _ = config.proximitySoundDistance or 145
		local _2 = config.chaseSoundDistance or 146

		stopChaseSound()
		v7 = false
		resetVisualEffects(v1.baseFieldOfView)

		return
	end

	local Magnitude = (v52.Position - v3.Position).Magnitude
	local config = v1.config
	local v6 = config.proximitySoundDistance or 145
	local v72 = config.chaseSoundDistance or 146

	if Magnitude == nil then
		stopChaseSound()
		v7 = false
	else
		updateProximityStinger(Magnitude, v6, v3)

		if Magnitude <= v72 then
			startChaseSound()
		else
			stopChaseSound()
		end
	end

	local v8 = v1.config.proximityMinDistance or 10

	applyVisualEffects(1 - math.clamp((Magnitude - v8) / ((v1.config.proximitySoundDistance or 145) - v8), 0, 1), p1, v1.baseFieldOfView)
end

local function validateStartConfig(p1) --[[ validateStartConfig | Line: 370 | Upvalues: Asserts (copy), Schema (copy) ]]
	Asserts.table(p1)
	assert(Schema.StartConfig(p1), "Invalid ScaryEffectController config")
	assert(if p1.trackedPart == nil then if p1.trackedPartResolver == nil then false else true else true, "ScaryEffectController requires trackedPart or trackedPartResolver")
	assert(if p1.targetPart == nil then if p1.targetPartResolver == nil then false else true else true, "ScaryEffectController requires targetPart or targetPartResolver")

	if p1.proximitySoundDistance ~= nil then
		Asserts.finiteNonNegative(p1.proximitySoundDistance)
		assert(p1.proximitySoundDistance > 0, "proximitySoundDistance must be positive")
	end

	if p1.chaseSoundDistance ~= nil then
		Asserts.finiteNonNegative(p1.chaseSoundDistance)
		assert(p1.chaseSoundDistance > 0, "chaseSoundDistance must be positive")
	end

	if p1.proximityMinDistance ~= nil then
		Asserts.finiteNonNegative(p1.proximityMinDistance)
	end

	if p1.baseFieldOfView ~= nil then
		Asserts.finiteNonNegative(p1.baseFieldOfView)
		assert(p1.baseFieldOfView > 0, "baseFieldOfView must be positive")
	end

	local v8 = p1.proximitySoundDistance or 145

	assert((p1.proximityMinDistance or 10) < v8, "proximityMinDistance must be lower than proximitySoundDistance")
	assert(if v8 <= (p1.chaseSoundDistance or 146) then true else false, "proximitySoundDistance must be lower than or equal to chaseSoundDistance")

	return p1
end

local function connectRuntime(p1) --[[ connectRuntime | Line: 414 | Upvalues: RunService (copy), renderStep (copy), stopChaseSound (copy), resetVisualEffects (copy) ]]
	p1.trove:Connect(RunService.RenderStepped, renderStep)
	p1.trove:Add(function() --[[ Line: 416 | Upvalues: stopChaseSound (ref), resetVisualEffects (ref), p1 (copy) ]]
		stopChaseSound()
		resetVisualEffects(p1.baseFieldOfView)
	end)
end

local function playEffectIntroSounds() --[[ playEffectIntroSounds | Line: 422 | Upvalues: t (copy), Audio (copy), SoundService (copy) ]]
	for i, v in ipairs(t) do
		Audio.Play(v, SoundService, 1, 1)
	end
end

function t3.Start(p1) --[[ Start | Line: 431 | Upvalues: validateStartConfig (copy), requireResources (copy), v5 (ref), CurrentCamera (ref), Trove (copy), RunService (copy), renderStep (copy), stopChaseSound (copy), resetVisualEffects (copy), playEffectIntroSounds (copy), v1 (copy) ]]
	local v12 = validateStartConfig(p1)

	requireResources()

	local v2 = v5

	if v2 == nil then
		local t = {
			config = v12
		}
		local v3

		if v12.baseFieldOfView == nil then
			local v4 = CurrentCamera

			if v4 == nil then
				v3 = 75
			else
				local v52 = v4:GetAttribute("FovMult")

				v3 = v4.FieldOfView / (if typeof(v52) == "number" and v52 > 0 then v52 else 1)
			end
		else
			v3 = v12.baseFieldOfView
		end

		t.baseFieldOfView = v3
		t.effectReadyAt = os.clock() + 1.98
		t.trove = Trove.new()
		v5 = t
		t.trove:Connect(RunService.RenderStepped, renderStep)
		t.trove:Add(function() --[[ Line: 416 | Upvalues: stopChaseSound (ref), resetVisualEffects (ref), t (copy) ]]
			stopChaseSound()
			resetVisualEffects(t.baseFieldOfView)
		end)
		playEffectIntroSounds()
	else
		v2.config = v12

		local v7

		if v12.baseFieldOfView == nil then
			local v8 = CurrentCamera

			if v8 == nil then
				v7 = 75
			else
				local v9 = v8:GetAttribute("FovMult")

				v7 = v8.FieldOfView / (if typeof(v9) == "number" and v9 > 0 then v9 else 1)
			end
		else
			v7 = v12.baseFieldOfView
		end

		v2.baseFieldOfView = v7
	end

	v1:AtDebug():Log("ScaryEffectController started")
	renderStep(0)
end
function t3.Configure(p1) --[[ Configure | Line: 456 | Upvalues: validateStartConfig (copy), v5 (ref), t3 (copy), v1 (copy), renderStep (copy) ]]
	local v12 = validateStartConfig(p1)
	local v2 = v5

	if v2 == nil then
		t3.Start(v12)

		return
	end

	v2.config = v12

	if v12.baseFieldOfView == nil then
		v1:AtDebug():Log("ScaryEffectController reconfigured")
		renderStep(0)

		return
	end

	v2.baseFieldOfView = v12.baseFieldOfView
	v1:AtDebug():Log("ScaryEffectController reconfigured")
	renderStep(0)
end
function t3.Stop(p1) --[[ Stop | Line: 473 | Upvalues: v5 (ref), stopChaseSound (copy), resetVisualEffects (copy), v7 (ref), v1 (copy) ]]
	local v12 = v5

	v7 = false

	if v12 == nil then
		stopChaseSound(p1)
		resetVisualEffects(nil)
	else
		v5 = nil
		v12.trove:Destroy()
		stopChaseSound(p1)
		resetVisualEffects(v12.baseFieldOfView)
		v1:AtDebug():Log("ScaryEffectController stopped")
	end
end
function t3.IsActive() --[[ IsActive | Line: 490 | Upvalues: v5 (ref) ]]
	return v5 ~= nil
end
Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 497 | Upvalues: CurrentCamera (ref), Workspace (copy) ]]
	CurrentCamera = Workspace.CurrentCamera
end)

return t3