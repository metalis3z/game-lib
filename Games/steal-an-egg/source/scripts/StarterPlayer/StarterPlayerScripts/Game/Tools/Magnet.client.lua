-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolSetup = require(ReplicatedStorage.Library.Util.ToolSetup)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local Magnet = require(ReplicatedStorage.Directory.Gears._Index.Other.Magnet)
local Magnet2 = Constants.NETWORK_MAP.Magnet
local COOLDOWN = Magnet.COOLDOWN
local LocalPlayer = Players.LocalPlayer
local v2 = nil

local function cleanupTargetVFX() --[[ cleanupTargetVFX | Line: 26 | Upvalues: v2 (ref) ]]
	if v2 and v2.Parent then
		v2:Destroy()
	end

	v2 = nil
end

local function playTargetVFX() --[[ playTargetVFX | Line: 34 | Upvalues: v2 (ref), LocalPlayer (copy), v1 (copy), Magnet (copy) ]]
	if v2 and v2.Parent then
		v2:Destroy()
	end

	v2 = nil

	local Character = LocalPlayer.Character

	if not Character then
		v1:AtWarning():Log("[Magnet] Local character not found")

		return
	end

	local v12 = Character.PrimaryPart or Character:FindFirstChild("HumanoidRootPart")

	if not (v12 and v12:IsA("BasePart")) then
		v1:AtWarning():Log("[Magnet] Could not find local character root part")

		return
	end

	local MAGNET_EFFECT_PATH = Magnet.MAGNET_EFFECT_PATH

	if MAGNET_EFFECT_PATH then
		assert(MAGNET_EFFECT_PATH:IsA("BasePart"), "[Magnet] MagnetEffect template must be a Part")

		local MagnetTargetVFX = MAGNET_EFFECT_PATH:Clone()

		MagnetTargetVFX.Name = "MagnetTargetVFX"
		MagnetTargetVFX.Parent = v12
		v2 = MagnetTargetVFX
	else
		v1:AtWarning():Log("[Magnet] Could not find MagnetEffect template")
	end
end

local function stopTargetVFX() --[[ stopTargetVFX | Line: 64 | Upvalues: v2 (ref) ]]
	if not (v2 and v2.Parent) then
		v2 = nil

		return
	end

	v2:Destroy()
	v2 = nil
end

local function onActivated(p1) --[[ onActivated | Line: 68 | Upvalues: Network (copy), Magnet2 (copy) ]]
	Network.Fire(Magnet2.REQUEST_PULL)
end

local function onUnequipped() --[[ onUnequipped | Line: 72 | Upvalues: v2 (ref) ]]
	if v2 and v2.Parent then
		v2:Destroy()
	end

	v2 = nil
end

local v3 = ToolSetup.Initialize(Magnet.DisplayName, {
	onActivated = onActivated,
	onUnequipped = onUnequipped
})

Network.Fired(Magnet2.PLAY_BEAM_VFX):Connect(function(p1, p2) --[[ Line: 82 | Upvalues: LocalPlayer (copy), ToolSetup (copy), v3 (ref), COOLDOWN (copy) ]]
	if p1 ~= LocalPlayer.Character then
		return
	end

	ToolSetup.StartCooldown(v3, COOLDOWN)
end)
Network.Fired(Magnet2.PLAY_TARGET_VFX):Connect(function() --[[ Line: 88 | Upvalues: playTargetVFX (copy) ]]
	playTargetVFX()
end)
Network.Fired(Magnet2.STOP_TARGET_VFX):Connect(function() --[[ Line: 92 | Upvalues: v2 (ref) ]]
	if v2 and v2.Parent then
		v2:Destroy()
	end

	v2 = nil
end)