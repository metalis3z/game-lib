-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ClientActorUtils, time of decompilation: Sun May  3 10:11:18 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local SlimeIdle = ReplicatedStorage.Assets.Animations.SlimeIdle
local HitSplat = ReplicatedStorage.Assets.VFX.HitSplat
local GameplayServiceUtils = require(ReplicatedStorage.Source.Features.Gameplay.GameplayServiceUtils)
local SettingsState = require(ReplicatedStorage.Source.Features.Settings.SettingsState)
local t2 = {
	newCombatVisualState = function() --[[ newCombatVisualState ]] -- line: 52
		return {
			attackLungeTime = 0,
			attackLungeDirection = Vector3.new(0, 0, 1),
			attackFocusTime = 0,
			attackFocusPos = nil,
			combatExitHoldTime = 0,
			hurtTime = 0,
			hurtDirection = Vector3.new(0, 0, 0),
			hurtMagnitude = 0,
			flashTime = 0,
			flashStrength = 0
		}
	end,
	createDamageHighlight = function(p1) --[[ createDamageHighlight ]] -- line: 67
		local Highlight = Instance.new("Highlight")

		Highlight.Name = "DamageHighlight"
		Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		Highlight.FillColor = Color3.fromRGB(255, 80, 80)
		Highlight.OutlineColor = Color3.fromRGB(255, 60, 60)
		Highlight.FillTransparency = 1
		Highlight.OutlineTransparency = 1
		Highlight.Enabled = false
		Highlight.Parent = p1

		return Highlight
	end,
	createHitSplatVfx = function(p2, color3: Color3, color3_2: Color3) --[[ createHitSplatVfx ]] -- line: 94
		-- upvalues: HitSplat (copy)
		local PrimaryPart = p2.PrimaryPart

		if PrimaryPart then
		else
			local RootPart = p2:FindFirstChild("RootPart")

			PrimaryPart = if not RootPart or not RootPart:IsA("BasePart") then p2:FindFirstChildWhichIsA("BasePart") else RootPart
		end

		if not PrimaryPart then
			return nil
		end

		local clone = HitSplat:Clone()

		clone.Name = "HitSplat"
		clone.Anchored = false
		clone.Massless = true
		clone.CanCollide = false
		clone.CanQuery = false
		clone.CanTouch = false
		clone.CFrame = PrimaryPart.CFrame
		clone.Parent = p2

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Name = "HitSplatWeld"
		WeldConstraint.Part0 = clone
		WeldConstraint.Part1 = PrimaryPart
		WeldConstraint.Parent = clone

		local Primary = clone:FindFirstChild("Primary")
		local Secondary = clone:FindFirstChild("Secondary")
		local Sound = clone:FindFirstChild("Sound")

		assert(Primary and Primary:IsA("ParticleEmitter"), "HitSplat.Primary must be a ParticleEmitter")
		assert(Secondary and Secondary:IsA("ParticleEmitter"), "HitSplat.Secondary must be a ParticleEmitter")
		Primary.Color = ColorSequence.new(color3)
		Secondary.Color = ColorSequence.new(color3_2)

		return {
			part = clone,
			primary = Primary,
			secondary = Secondary,
			sound = if not Sound or not Sound:IsA("Sound") then nil else Sound
		}
	end,
	getHitSplatEmitCount = function(n1: number, n2: number) --[[ getHitSplatEmitCount ]] -- line: 133
		if n1 <= 0 then
			return 0
		end

		return (math.clamp(math.ceil(math.clamp(n1 / math.max(n2, 1), 0, 0.25) / 0.25 * 4), 1, 4))
	end,
	emitHitSplat = function(t1: {[any]: any}?, n3: number, b1: boolean?) --[[ emitHitSplat ]] -- line: 142
		-- upvalues: SettingsState (copy)
		if not t1 or n3 <= 0 then
			return
		end

		if SettingsState.get("hitSplatVfx") then
			t1.primary:Emit(n3)
			t1.secondary:Emit(n3)
		end

		if b1 and SettingsState.get("hitSounds") and t1.sound then
			if t1.sound.IsPlaying then
				t1.sound:Stop()
			end

			t1.sound.TimePosition = 0
			t1.sound:Play()
		end
	end
}

function t2.emitDetachedHitSplat(t3: {[any]: any}?, n4: number, b2: boolean?) -- line: 174
	-- upvalues: SettingsState (copy), t2 (copy), Workspace (copy)
	if not t3 or n4 <= 0 then
		return
	end

	if not SettingsState.get("hitSplatVfx") then
		t2.emitHitSplat(t3, n4, b2)

		return
	end

	local HitSplatWeld = t3.part:FindFirstChild("HitSplatWeld")

	if HitSplatWeld then
		HitSplatWeld:Destroy()
	end

	t3.part.Anchored = true
	t3.part.Parent = Workspace
	t2.emitHitSplat(t3, n4, b2)

	local delay = task.delay
	local v41 = math.max(t3.primary.Lifetime.Max, t3.secondary.Lifetime.Max)

	if t3.sound then
		local v42 = math.max(t3.sound.PlaybackSpeed, 0.01)

		v41 = if not (t3.sound.TimeLength > 0) then math.max(v41, 1) else math.max(v41, t3.sound.TimeLength / v42)
	end

	delay(v41 + 0.1, function() -- line: 193
		-- upvalues: t3 (copy)
		if t3.part.Parent then
			t3.part:Destroy()
		end
	end)
end
function t2.playIdleAnimation(p3) -- line: 200
	-- upvalues: SettingsState (copy), SlimeIdle (copy)
	if not SettingsState.get("slimeEnemyAnimations") then
		return nil
	end

	local Animator = p3:FindFirstChildWhichIsA("Animator", true)

	if not Animator then
		return nil
	end

	local v45 = Animator:LoadAnimation(SlimeIdle)

	v45.Looped = true
	v45.Priority = Enum.AnimationPriority.Idle
	v45:Play(0.1)

	return v45
end
function t2.animationsEnabled() -- line: 217
	-- upvalues: SettingsState (copy)
	return SettingsState.get("slimeEnemyAnimations")
end
function t2.getDirection(vector3: Vector3, vector3_2: Vector3?, vector3_3: Vector3) -- line: 221
	if vector3_2 then
		local v49 = vector3_2 - vector3
		local vector3_4 = Vector3.new(v49.X, 0, v49.Z)

		if vector3_4.Magnitude > 0.001 and vector3_4.Magnitude == vector3_4.Magnitude then
			return vector3_4.Unit
		end

		local vector3_5 = Vector3.new(vector3_3.X, 0, vector3_3.Z)

		if vector3_5.Magnitude > 0.001 and vector3_5.Magnitude == vector3_5.Magnitude then
			return vector3_5.Unit
		end

		return (Vector3.new(0, 0, 1))
	end

	local vector3_6 = Vector3.new(vector3_3.X, 0, vector3_3.Z)

	if vector3_6.Magnitude > 0.001 and vector3_6.Magnitude == vector3_6.Magnitude then
		return vector3_6.Unit
	end

	local vector3_7 = Vector3.new(0, 0, 1)

	if vector3_7.Magnitude > 0.001 and vector3_7.Magnitude == vector3_7.Magnitude then
		return vector3_7.Unit
	end

	return (Vector3.new(0, 0, 1))
end
function t2.getLookAtCFrame(vector3: Vector3, vector3_8: Vector3, vector3_9: Vector3?, n5: number, n6: number) -- line: 229
	-- upvalues: GameplayServiceUtils (copy)
	local vector3_10 = Vector3.new(vector3.X, 0, vector3.Z)
	local Unit = nil

	if vector3_9 then
		local v61 = vector3_9 - vector3_10
		local vector3_11 = Vector3.new(v61.X, 0, v61.Z)

		if vector3_11.Magnitude > 0.001 and vector3_11.Magnitude == vector3_11.Magnitude then
			Unit = vector3_11.Unit
		else
			local vector3_12 = Vector3.new(vector3_8.X, 0, vector3_8.Z)

			Unit = if not (vector3_12.Magnitude > 0.001) or vector3_12.Magnitude ~= vector3_12.Magnitude then Vector3.new(0, 0, 1) else vector3_12.Unit
		end
	end

	local v64 = GameplayServiceUtils.smoothDirection(vector3_8, Unit, n5, n6)

	return CFrame.lookAt(vector3_10, vector3_10 + v64) * CFrame.Angles(0, 3.141592653589793, 0), v64
end
function t2.advanceCombatVisualState(t4: {[any]: any}, n7: number) -- line: 246
	t4.attackLungeTime = math.max(t4.attackLungeTime - n7, 0)
	t4.attackFocusTime = math.max(t4.attackFocusTime - n7, 0)
	t4.combatExitHoldTime = math.max(t4.combatExitHoldTime - n7, 0)
	t4.hurtTime = math.max(t4.hurtTime - n7, 0)
	t4.flashTime = math.max(t4.flashTime - n7, 0)

	if t4.attackFocusTime <= 0 then
		t4.attackFocusPos = nil
	end
end
function t2.beginCombatExitHold(t5: {[any]: any}, n8: number) -- line: 258
	t5.combatExitHoldTime = math.max(t5.combatExitHoldTime, (math.max(t5.attackLungeTime, n8)))
end
function t2.getVisualOffset(t6: {[any]: any}, n9: number, n10: number, n11: number) -- line: 263
	local vector3 = Vector3.new(0, 0, 0)

	if t6.attackLungeTime > 0 and n9 > 0 then
		local v74 = 1 - t6.attackLungeTime / n9

		vector3 += t6.attackLungeDirection * (math.sin(v74 * 3.141592653589793) * n10)
	end

	if t6.hurtTime > 0 and n11 > 0 then
		local v75 = 1 - t6.hurtTime / n11

		vector3 += t6.hurtDirection * (math.sin((1 - v75) * 3.141592653589793 * 0.5) * t6.hurtMagnitude)
	end

	return (Vector3.new(vector3.X, 0, vector3.Z))
end
function t2.updateDamageHighlight(t7: {[any]: any}, p4, n12: number, n13: number, n14: number) -- line: 283
	if t7.flashTime > 0 and n12 > 0 then
		local v81 = 1 - (1 - t7.flashTime / n12)
		local v82 = t7.flashStrength * v81

		p4.Enabled = v82 > 0.001
		p4.FillTransparency = 1 - (1 - n13) * v82
		p4.OutlineTransparency = 1 - (1 - n14) * v82

		return
	end

	p4.Enabled = false
	p4.FillTransparency = 1
	p4.OutlineTransparency = 1
end
function t2.startAttack(t8: {[any]: any}, vector3: Vector3, vector3_13: Vector3?, vector3_14: Vector3, n15: number) -- line: 305
	-- upvalues: t2 (copy)
	t8.attackLungeTime = n15
	t8.attackLungeDirection = t2.getDirection(vector3, vector3_13, vector3_14)
	t8.attackFocusTime = n15
	t8.attackFocusPos = if not vector3_13 then nil else Vector3.new(vector3_13.X, 0, vector3_13.Z)
end
function t2.applyDamage(t9: {[any]: any}, vector3: Vector3, vector3_15: Vector3?, vector3_16: Vector3, n16: number, n17: number, n18: number, n19: number, n20: number, b3: boolean) -- line: 318
	-- upvalues: t2 (copy)
	local v98 = math.clamp(n16 / math.max(n17, 1), 0, 1) * 0.7 + 0.3

	if b3 then
		t9.hurtTime = n18
		t9.hurtDirection = -t2.getDirection(vector3, vector3_15, vector3_16)
		t9.hurtMagnitude = n19 * v98
	end

	t9.flashTime = n20
	t9.flashStrength = math.max(v98, 0.8)

	return v98
end

return t2
