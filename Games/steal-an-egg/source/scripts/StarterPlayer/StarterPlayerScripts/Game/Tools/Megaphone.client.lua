-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolSetup = require(ReplicatedStorage.Library.Util.ToolSetup)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local Megaphone = require(ReplicatedStorage.Directory.Gears._Index.Other.Megaphone)
local Megaphone2 = Constants.NETWORK_MAP.Megaphone
local COOLDOWN = Megaphone.COOLDOWN
local v2 = false
local t = {}

local function playVFX(p1, p2) --[[ playVFX | Line: 26 | Upvalues: Asserts (copy), v1 (copy), t (copy), Megaphone (copy) ]]
	Asserts.Model(p1)

	local v12 = p2:FindFirstChildWhichIsA("ParticleEmitter", true)

	if v12 then
		v12.Enabled = true
		t[p1] = v12
		task.delay(Megaphone.EFFECT_DURATION, function() --[[ Line: 39 | Upvalues: t (ref), p1 (copy), v12 (copy) ]]
			if t[p1] ~= v12 then
				return
			end

			t[p1] = nil

			if not v12.Parent then
				return
			end

			v12.Enabled = false
		end)
	else
		v1:AtWarning():Log((("[Megaphone] No VFX found for %*"):format(p1.Name)))
	end
end

local function playSFX(p1) --[[ playSFX | Line: 49 | Upvalues: Asserts (copy), Megaphone (copy) ]]
	Asserts.Model(p1)

	if Megaphone.SFX_ID == "rbxassetid://0" then
		return
	end

	local v1 = p1.PrimaryPart or p1:FindFirstChild("HumanoidRootPart")

	if not (v1 and v1:IsA("BasePart")) then
		return
	end

	local Sound = Instance.new("Sound")

	Sound.SoundId = Megaphone.SFX_ID
	Sound.Parent = v1
	Sound:Play()
	task.delay(5, function() --[[ Line: 60 | Upvalues: Sound (copy) ]]
		if not Sound.Parent then
			return
		end

		Sound:Destroy()
	end)
end

local function _stopVFX(p1) --[[ _stopVFX | Line: 69 | Upvalues: t (copy) ]]
	if not p1 then
		return
	end

	local v1 = t[p1]

	if not (v1 and v1.Parent) then
		return
	end

	v1:Destroy()
	t[p1] = nil
end

local function startEffectWindow() --[[ startEffectWindow | Line: 81 | Upvalues: v2 (ref) ]]
	if not v2 then
		v2 = true
	end
end

local function stopEffectWindow() --[[ stopEffectWindow | Line: 89 | Upvalues: v2 (ref) ]]
	if v2 then
		v2 = false
	end
end

local function onActivated(p1) --[[ onActivated | Line: 97 | Upvalues: v2 (ref), Network (copy), Megaphone2 (copy) ]]
	if not v2 then
		Network.Fire(Megaphone2.REQUEST_ACTIVATE)
	end
end

local function onUnequipped() --[[ onUnequipped | Line: 105 | Upvalues: v2 (ref) ]]
	if v2 then
		v2 = false
	end
end

local v3 = ToolSetup.Initialize(Megaphone.DisplayName, {
	onActivated = onActivated,
	onUnequipped = onUnequipped
})

Network.Fired(Megaphone2.PLAY_VFX):Connect(playVFX)
Network.Fired(Megaphone2.PLAY_SFX):Connect(playSFX)
Network.Fired(Megaphone2.START_EFFECT_WINDOW):Connect(function() --[[ Line: 119 | Upvalues: v2 (ref), ToolSetup (copy), v3 (ref), COOLDOWN (copy) ]]
	if v2 then
		ToolSetup.StartCooldown(v3, COOLDOWN)

		return
	end

	v2 = true
	ToolSetup.StartCooldown(v3, COOLDOWN)
end)
Network.Fired(Megaphone2.STOP_EFFECT_WINDOW):Connect(stopEffectWindow)