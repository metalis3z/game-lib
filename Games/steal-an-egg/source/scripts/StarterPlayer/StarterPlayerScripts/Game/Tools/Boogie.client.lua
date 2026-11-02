-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ToolSetup = require(ReplicatedStorage.Library.Util.ToolSetup)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local ShakePresets = require(ReplicatedStorage.Library.Modules.ShakePresets)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local Boogie = require(ReplicatedStorage.Directory.Gears._Index.Other.Boogie)
local Boogie2 = Constants.NETWORK_MAP.Boogie
local v2 = Asserts.defined(Players.LocalPlayer)
local v3 = Trove.new()
local CurrentCamera = workspace.CurrentCamera
local FieldOfView = CurrentCamera.FieldOfView

local function playBoogieAnimation(p1) --[[ playBoogieAnimation | Line: 32 | Upvalues: Asserts (copy), v1 (copy), Boogie (copy), v3 (copy) ]]
	Asserts.Model(p1)

	local Humanoid = p1:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		v1:AtError():Log("[BoogieClient] Humanoid not found")

		return nil
	end

	local Animator = Humanoid:FindFirstChildOfClass("Animator")

	if Animator then
		local Animation = Instance.new("Animation")

		Animation.AnimationId = Boogie.BOOGIE_ANIMATION_ID

		local v12 = Animator:LoadAnimation(Animation)

		v12:Play()
		v3:Add(function() --[[ Line: 53 | Upvalues: v12 (copy), Animation (copy) ]]
			if v12 then
				v12:Stop()
				Animation:Destroy()
			end
		end)

		return v12
	end

	v1:AtError():Log("[BoogieClient] Animator not found")

	return nil
end

local function applyScreenEffects(p1) --[[ applyScreenEffects | Line: 64 | Upvalues: v3 (copy), Boogie (copy), Lighting (copy), TweenService (copy), CurrentCamera (copy), FieldOfView (copy), ShakePresets (copy) ]]
	v3:Clean()

	local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")

	ColorCorrectionEffect.Saturation = Boogie.COLOR_CORRECTION.Saturation
	ColorCorrectionEffect.Brightness = Boogie.COLOR_CORRECTION.Brightness
	ColorCorrectionEffect.Contrast = Boogie.COLOR_CORRECTION.Contrast
	ColorCorrectionEffect.Parent = Lighting
	v3:Add(ColorCorrectionEffect)

	local v1 = TweenService:Create(CurrentCamera, Boogie.FOV_TWEEN_INFO, {
		FieldOfView = FieldOfView + Boogie.FOV_OFFSET
	})

	v1:Play()
	v3:Add(function() --[[ Line: 78 | Upvalues: v1 (copy), CurrentCamera (ref), FieldOfView (ref) ]]
		v1:Cancel()
		CurrentCamera.FieldOfView = FieldOfView
	end)

	local v2 = TweenService:Create(ColorCorrectionEffect, Boogie.COLOR_CORRECTION_TWEEN_INFO, {
		Brightness = Boogie.COLOR_CORRECTION_TWEEN.Brightness
	})

	v2:Play()
	v3:Add(function() --[[ Line: 87 | Upvalues: v2 (copy) ]]
		v2:Cancel()
	end)
	v3:Add((ShakePresets.BindShakeToCamera(ShakePresets[Boogie.SHAKE_PRESET]:Clone(), CurrentCamera)))
	v3:Add(task.delay(p1, function() --[[ Line: 95 | Upvalues: v3 (ref) ]]
		v3:Clean()
	end))
end

local function playBoogieSFX() --[[ playBoogieSFX | Line: 100 ]]
	print("Boogie SFX")
end

local function onBoogieEffectApplied(p1) --[[ onBoogieEffectApplied | Line: 104 | Upvalues: applyScreenEffects (copy), v2 (copy), playBoogieAnimation (copy) ]]
	applyScreenEffects(p1)
	print("Boogie SFX")

	local Character = v2.Character

	if not Character then
		return
	end

	playBoogieAnimation(Character)
end

local function onBoogieEffectRemoved() --[[ onBoogieEffectRemoved | Line: 114 | Upvalues: v3 (copy) ]]
	v3:Clean()
end

local function onPlaySFX() --[[ onPlaySFX | Line: 118 ]]
	print("Boogie SFX")
end

local function onActivated(p1) --[[ onActivated | Line: 122 | Upvalues: Network (copy), Boogie2 (copy) ]]
	Network.Fire(Boogie2.REQUEST_BOOGIE)
end

ToolSetup.Initialize(Boogie.DisplayName, {
	onActivated = onActivated
})
Network.Fired(Boogie2.APPLY_EFFECT):Connect(onBoogieEffectApplied)
Network.Fired(Boogie2.REMOVE_EFFECT):Connect(onBoogieEffectRemoved)
Network.Fired(Boogie2.PLAY_SFX):Connect(onPlaySFX)