-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = script.Parent
local v2 = v1:GetAttribute("Owner")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local GameplayToolGuard = require(ServerScriptService.Library.Tools.Internal.GameplayToolGuard)
local Ragdoll = require(ReplicatedStorage.Library.Modules.Ragdoll)
local Network = require(ServerScriptService.Library.Network)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Audio = require(ReplicatedStorage.Library.Audio)
local SubspaceMine = require(ReplicatedStorage.Directory.Gears._Index.Other.SubspaceMine)
local TRIGGER_RADIUS = SubspaceMine.TRIGGER_RADIUS
local RAGDOLL_DURATION = SubspaceMine.RAGDOLL_DURATION
local FADE_DURATION = SubspaceMine.FADE_DURATION
local SubspaceMine2 = Constants.NETWORK_MAP.SubspaceMine
local IMPULSE_STRENGTH = SubspaceMine.IMPULSE_STRENGTH
local v3 = false
local v4 = nil

v1.CanTouch = true
(function() --[[ fadeToInvisible | Line: 30 | Upvalues: FADE_DURATION (copy), v1 (copy) ]]
	local v12 = tick()

	while tick() - v12 < FADE_DURATION and (v1 and v1.Parent) do
		v1.Transparency = (tick() - v12) / FADE_DURATION
		task.wait(0.05)
	end

	if not (v1 and v1.Parent) then
		return
	end

	v1.Transparency = 1
end)()

local function getCharacterFromPart(p1) --[[ getCharacterFromPart | Line: 45 ]]
	local v1 = p1

	while v1 and v1 ~= workspace do
		if v1:IsA("Model") and v1:FindFirstChildOfClass("Humanoid") then
			return v1
		end

		v1 = v1.Parent
	end

	return nil
end

local function applyEffectToPlayer(p1, p2) --[[ applyEffectToPlayer | Line: 59 | Upvalues: Network (copy), SubspaceMine2 (copy), RAGDOLL_DURATION (copy), GameplayToolGuard (copy), IMPULSE_STRENGTH (copy), Ragdoll (copy) ]]
	local Humanoid = p1:FindFirstChildOfClass("Humanoid")
	local v1 = p1:FindFirstChild("HumanoidRootPart") or p1.PrimaryPart

	if Humanoid and (not (Humanoid.Health <= 0) and (v1 and v1:IsA("BasePart"))) then
		Network.FireAll(SubspaceMine2.APPLY_HIGHLIGHT, p2, RAGDOLL_DURATION)
		GameplayToolGuard.DropHeldEggFromPlayerHit(p2)
		Ragdoll.TimedRagdoll(p1, RAGDOLL_DURATION, Vector3.new(0, IMPULSE_STRENGTH, 0) * v1.AssemblyMass)
	end
end

local function activateTrap() --[[ activateTrap | Line: 74 | Upvalues: v3 (ref), v1 (copy), v4 (ref), Audio (copy), Players (copy), v2 (copy), TRIGGER_RADIUS (copy), GameplayToolGuard (copy), applyEffectToPlayer (copy), RAGDOLL_DURATION (copy) ]]
	if v3 or not v1.Parent then
		return
	end

	v3 = true

	if v4 then
		v4:Disconnect()
		v4 = nil
	end

	task.spawn(Audio.Play, 9126102254, v1.Position, { 0.9, 1.1 }, 0.7, 60)
	v1.Transparency = 1
	v1.CanCollide = false
	v1.CanTouch = false

	local t = {}

	for v12, v22 in Players:GetPlayers() do
		if v22.Name ~= v2 and v22.Character then
			local Character = v22.Character
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			local v32 = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart

			if Humanoid and (Humanoid.Health > 0 and (v32 and (v32:IsA("BasePart") and (v32.Position - v1.Position).Magnitude <= TRIGGER_RADIUS))) then
				table.insert(t, Character)
			end
		end
	end

	for v42, v5 in t do
		local v6 = Players:GetPlayerFromCharacter(v5)

		if v6 and GameplayToolGuard.IsPlayerInGameplayArea(v6) then
			applyEffectToPlayer(v5, v6)
		end
	end

	task.delay(RAGDOLL_DURATION + 0.5, function() --[[ Line: 115 | Upvalues: v1 (ref) ]]
		if not (v1 and v1.Parent) then
			return
		end

		v1:Destroy()
	end)
end

local function checkForTargetsNearby() --[[ checkForTargetsNearby | Line: 122 | Upvalues: v3 (ref), v1 (copy), Players (copy), v2 (copy), TRIGGER_RADIUS (copy), GameplayToolGuard (copy) ]]
	if v3 or not v1.Parent then
		return false
	end

	for v12, v22 in Players:GetPlayers() do
		if v22.Name ~= v2 and v22.Character then
			local Character = v22.Character
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			local v32 = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart

			if Humanoid and (Humanoid.Health > 0 and (v32 and (v32:IsA("BasePart") and ((v32.Position - v1.Position).Magnitude <= TRIGGER_RADIUS and GameplayToolGuard.IsPlayerInGameplayArea(v22))))) then
				return true
			end
		end
	end

	return false
end

local function onTouched(p1) --[[ onTouched | Line: 145 | Upvalues: v3 (ref), v1 (copy), getCharacterFromPart (copy), Players (copy), v2 (copy), GameplayToolGuard (copy), checkForTargetsNearby (copy), activateTrap (copy) ]]
	if v3 or not v1.Parent then
		return
	end

	if not p1 or p1:IsDescendantOf(v1) then
		return
	end

	local v12 = getCharacterFromPart(p1)

	if not v12 then
		return
	end

	local v22 = Players:GetPlayerFromCharacter(v12)

	if v22 and v22.Name == v2 then
		return
	end

	if not (v22 and GameplayToolGuard.IsPlayerInGameplayArea(v22)) then
		return
	end

	local Humanoid = v12:FindFirstChildOfClass("Humanoid")

	if not Humanoid or Humanoid.Health <= 0 then
		return
	end

	if not checkForTargetsNearby() then
		return
	end

	activateTrap()
end

v4 = v1.Touched:Connect(onTouched)