-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SlimeClient, time of decompilation: Sun May  3 10:11:21 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClientActorUtils = require(script.Parent.ClientActorUtils)
local HealthBarBillboard = require(script.Parent.HealthBarBillboard)
local SlimeInfoBillboard = require(script.Parent.SlimeInfoBillboard)
local GameplayServiceUtils = require(ReplicatedStorage.Source.Features.Gameplay.GameplayServiceUtils)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local SettingsState = require(ReplicatedStorage.Source.Features.Settings.SettingsState)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local VfxUtils = require(ReplicatedStorage.Source.Core.Platform.VfxUtils)
local SlimeKnocked = ReplicatedStorage.Assets.Animations.SlimeKnocked
local t1 = {}

t1.__index = t1

function t1.new(p1, p2, t2: {[any]: any}?) -- line: 83
	-- upvalues: Slimes (copy), InventoryServiceUtils (copy), Mutations (copy), VfxUtils (copy), HealthBarBillboard (copy), SlimeInfoBillboard (copy), ClientActorUtils (copy), t1 (copy), GameplayServiceUtils (copy)
	local clone = Slimes.getModel(p1.slimeId):Clone()

	Slimes.applyMutationVisuals(clone, p1.slimeId, p1.mutations)

	local v22 = Slimes.getSlime(p1.slimeId)
	local t3 = {
		level = 1,
		xp = 0,
		id = p1.slimeId,
		mutations = p1.mutations
	}
	local v24 = InventoryServiceUtils.getVisualOdds(t3)
	local v25 = Mutations.getDisplayName(v22.name, p1.mutations)
	local v26 = Mutations.getSizeScale(p1.mutations)
	local v27 = v22.colors or {}
	local v28 = v27[1] or Color3.fromRGB(255, 255, 255)
	local v29 = v27[2] or v28
	local EyeLeft = clone:FindFirstChild("EyeLeft", true)
	local v31 = if EyeLeft then EyeLeft:FindFirstChildWhichIsA("Decal") or nil else nil
	local EyeRight = clone:FindFirstChild("EyeRight", true)
	local v33 = if EyeRight then EyeRight:FindFirstChildWhichIsA("Decal") or nil else nil
	local v34 = not t2 or (t2.showHealthBar == nil or t2.showHealthBar)
	local v35 = not t2 or (t2.showInfoBillboard == nil or t2.showInfoBillboard)
	local v36 = not t2 or (t2.enableCombatVfx == nil or t2.enableCombatVfx)
	local v37 = nil

	if Mutations.has(p1.mutations, "shiny") then
		v37 = VfxUtils.getVfx("ShinyParticles")
		v37.Parent = clone.PrimaryPart
	end

	clone:ScaleTo(v26)
	clone.Name = p1.uniqueId
	clone.Parent = p2

	local v38 = setmetatable({
		lookVector = Vector3.new(0, 0, 1),
		velocity = Vector3.new(0, 0, 0),
		knockedTrack = nil,
		uniqueId = p1.uniqueId,
		inventoryUniqueId = p1.inventoryUniqueId,
		slimeId = p1.slimeId,
		mutations = p1.mutations,
		pos = Vector3.new(p1.pos.X, 0, p1.pos.Z),
		speed = p1.speed,
		state = p1.state,
		targetUniqueId = p1.targetUniqueId,
		health = p1.health,
		maxHealth = p1.maxHealth,
		healthBar = if not v34 then nil else HealthBarBillboard.new(clone),
		infoBillboard = if not v35 then nil else SlimeInfoBillboard.new(clone, v25, v24, v26),
		visuals = ClientActorUtils.newCombatVisualState(),
		highlight = if not v36 then nil else ClientActorUtils.createDamageHighlight(clone),
		hitSplat = if not v36 then nil else ClientActorUtils.createHitSplatVfx(clone, v28, v29),
		idleTrack = ClientActorUtils.playIdleAnimation(clone),
		leftEyeDecal = v31,
		rightEyeDecal = v33,
		defaultLeftEyeTexture = if not v31 then nil else v31.Texture,
		defaultRightEyeTexture = if not v33 then nil else v33.Texture,
		shinyVfx = v37,
		model = clone
	}, t1)
	local v39, v40 = ClientActorUtils.getLookAtCFrame(v38.pos, v38.lookVector, nil, 14, 0)

	v38.lookVector = v40
	v38.model:PivotTo(v39)

	if v38.healthBar then
		v38.healthBar:setHealth(v38.health, v38.maxHealth)
	end

	if v38.infoBillboard then
		local v41 = not v38.healthBar or not v38.healthBar:isVisible()

		v38.infoBillboard:setVisible(v41)
	end

	if v38.state == GameplayServiceUtils.enums.slimeStates.knockedOut then
		v38:applyKnockoutState()

		return v38
	end

	v38:syncAnimationState()

	return v38
end
function t1.syncAnimationState(p3) -- line: 171
	-- upvalues: GameplayServiceUtils (copy), ClientActorUtils (copy), SlimeKnocked (copy)
	local slimeStates = GameplayServiceUtils.enums.slimeStates

	if not ClientActorUtils.animationsEnabled() then
		if p3.idleTrack then
			p3.idleTrack:Stop(0.1)
			p3.idleTrack:Destroy()
			p3.idleTrack = nil
		end

		if p3.knockedTrack then
			p3.knockedTrack:Stop(0.1)
			p3.knockedTrack:Destroy()
			p3.knockedTrack = nil
		end

		return
	end

	if p3.state == slimeStates.knockedOut then
		if p3.idleTrack and p3.idleTrack.IsPlaying then
			p3.idleTrack:Stop(0.1)
		end

		if not p3.knockedTrack then
			local Animator = p3.model:FindFirstChildWhichIsA("Animator", true)

			if Animator then
				p3.knockedTrack = Animator:LoadAnimation(SlimeKnocked)
			end
		end

		if p3.knockedTrack and not p3.knockedTrack.IsPlaying then
			p3.knockedTrack:Play(0.1)
		end

		return
	end

	if p3.knockedTrack then
		p3.knockedTrack:Stop(0.1)
		p3.knockedTrack:Destroy()
		p3.knockedTrack = nil
	end

	if not p3.idleTrack then
		p3.idleTrack = ClientActorUtils.playIdleAnimation(p3.model)

		return
	end

	if not p3.idleTrack.IsPlaying then
		p3.idleTrack:Play(0.1)
	end
end
function t1.applyKnockoutState(p4) -- line: 221
	-- upvalues: ImageIds (copy)
	if p4.leftEyeDecal then
		p4.leftEyeDecal.Texture = ImageIds.eyes.knocked.left
	end

	if p4.rightEyeDecal then
		p4.rightEyeDecal.Texture = ImageIds.eyes.knocked.right
	end

	p4:syncAnimationState()
end
function t1.clearKnockoutState(p5) -- line: 232
	if p5.leftEyeDecal and p5.defaultLeftEyeTexture then
		p5.leftEyeDecal.Texture = p5.defaultLeftEyeTexture
	end

	if p5.rightEyeDecal and p5.defaultRightEyeTexture then
		p5.rightEyeDecal.Texture = p5.defaultRightEyeTexture
	end

	p5:syncAnimationState()
end
function t1.setState(p6, n1: number, n2: number?) -- line: 243
	-- upvalues: GameplayServiceUtils (copy), ClientActorUtils (copy)
	local state = p6.state

	p6.state = n1
	p6.targetUniqueId = n2

	local slimeStates = GameplayServiceUtils.enums.slimeStates
	local v52 = state == slimeStates.targeting or state == slimeStates.attacking

	if n1 == slimeStates.following and v52 then
		ClientActorUtils.beginCombatExitHold(p6.visuals, 0.18)
		p6.velocity = Vector3.new(0, 0, 0)
	end

	if n1 == slimeStates.knockedOut and state ~= slimeStates.knockedOut then
		p6:playKnockoutVfx()

		return
	end

	if state == slimeStates.knockedOut and n1 ~= slimeStates.knockedOut then
		p6:clearKnockoutState()
	end
end
function t1.setHealth(p7, n3: number, n4: number) -- line: 263
	p7.health = n3
	p7.maxHealth = n4

	if p7.healthBar then
		p7.healthBar:setHealth(n3, n4)
	end

	if p7.infoBillboard then
		local v56 = not p7.healthBar or not p7.healthBar:isVisible()

		p7.infoBillboard:setVisible(v56)
	end
end
function t1.update(p8, n5: number, vector3: Vector3?, vector3_2: Vector3?, vector3_3: Vector3?) -- line: 275
	-- upvalues: ClientActorUtils (copy), GameplayServiceUtils (copy)
	ClientActorUtils.advanceCombatVisualState(p8.visuals, n5)

	if vector3 and (p8.pos - vector3).Magnitude > 60 then
		p8.pos = vector3
		p8.velocity = Vector3.new(0, 0, 0)
	end

	local slimeStates = GameplayServiceUtils.enums.slimeStates

	if p8.state ~= slimeStates.knockedOut and (vector3_2 ~= nil and p8.visuals.combatExitHoldTime <= 0) and vector3_2 then
		local vector3_4 = Vector3.new(vector3_2.X, 0, vector3_2.Z)
		local v64, v65 = GameplayServiceUtils.predictFluidMovement(p8.pos, p8.velocity, vector3_4, p8.speed, 14, p8.speed * 0.7, n5)

		p8.pos = v64
		p8.velocity = v65
	else
		p8.velocity = Vector3.new(0, 0, 0)
	end

	local v66 = p8.pos + ClientActorUtils.getVisualOffset(p8.visuals, 0.32, 3.5, 0.3)
	local v67 = p8.visuals.attackFocusPos or vector3_3
	local v68, v69 = ClientActorUtils.getLookAtCFrame(v66, p8.lookVector, v67, 14, n5)

	p8.lookVector = v69
	p8.model:PivotTo(v68)
	p8:syncAnimationState()

	if p8.healthBar then
		p8.healthBar:update(n5)
	end

	if p8.infoBillboard then
		local v70 = not p8.healthBar or not p8.healthBar:isVisible()

		p8.infoBillboard:setVisible(v70)
	end

	if p8.highlight then
		ClientActorUtils.updateDamageHighlight(p8.visuals, p8.highlight, 0.28, 0.12, 0)
	end
end
function t1.onAttack(p9, vector3: Vector3?, _: number) -- line: 338
	-- upvalues: ClientActorUtils (copy)
	ClientActorUtils.startAttack(p9.visuals, p9.pos, vector3, p9.lookVector, 0.32)
	p9:playAttackVfx()
end
function t1.onDamaged(p10, vector3: Vector3?, n7: number, n8: number?) -- line: 343
	-- upvalues: ClientActorUtils (copy)
	local v78 = n8 or p10.maxHealth

	ClientActorUtils.applyDamage(p10.visuals, p10.pos, vector3, p10.lookVector, n7, v78, 0.3, 4.5, 0.28, true)
	ClientActorUtils.emitHitSplat(p10.hitSplat, ClientActorUtils.getHitSplatEmitCount(n7, v78), true)
end
function t1.playAttackVfx(_) -- line: 360
end
function t1.playKnockoutVfx(p12) -- line: 362
	-- upvalues: ClientActorUtils (copy), VfxUtils (copy), SettingsState (copy)
	p12:applyKnockoutState()
	ClientActorUtils.emitHitSplat(p12.hitSplat, 10, false)
	VfxUtils.emitAllAtPosition("KnockedOut", p12.model:GetPivot().Position, SettingsState.get("hitSounds"))
end
function t1.playDeathVfx(p13) -- line: 368
	-- upvalues: ClientActorUtils (copy)
	ClientActorUtils.emitDetachedHitSplat(p13.hitSplat, 10, true)
end
function t1.destroy(p14) -- line: 372
	if p14.idleTrack then
		p14.idleTrack:Stop(0.1)
		p14.idleTrack:Destroy()
	end

	if p14.knockedTrack then
		p14.knockedTrack:Stop(0.1)
		p14.knockedTrack:Destroy()
	end

	if p14.healthBar then
		p14.healthBar:destroy()
	end

	if p14.infoBillboard then
		p14.infoBillboard:destroy()
	end

	if p14.highlight then
		p14.highlight:Destroy()
	end

	if p14.shinyVfx then
		p14.shinyVfx:Destroy()
	end

	p14.model:Destroy()
end

return t1
