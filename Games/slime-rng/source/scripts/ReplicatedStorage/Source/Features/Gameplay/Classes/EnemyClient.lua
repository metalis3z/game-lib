-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: EnemyClient, time of decompilation: Sun May  3 10:11:19 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClientActorUtils = require(script.Parent.ClientActorUtils)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local Enemies = require(ReplicatedStorage.Source.Game.Items.Enemies)
local GameplayServiceUtils = require(ReplicatedStorage.Source.Features.Gameplay.GameplayServiceUtils)
local HealthBarBillboard = require(script.Parent.HealthBarBillboard)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local VfxUtils = require(ReplicatedStorage.Source.Core.Platform.VfxUtils)
local color3 = Color3.fromRGB(255, 214, 92)
local color3_2 = Color3.fromRGB(55, 24, 0)
local enemyStates = GameplayServiceUtils.enums.enemyStates
local t1 = {}

t1.__index = t1

local function getMutationLabel(p1) -- line: 67
	-- upvalues: Mutations (copy)
	local t2 = {}

	for _, v19 in Mutations.getIds(p1) do
		table.insert(t2, string.upper(Mutations.get(v19).name))
	end

	return table.concat(t2, " ")
end
local function createMutationBillboard(p2, p3, n1: number) -- line: 76
	-- upvalues: getMutationLabel (copy), color3 (copy), color3_2 (copy)
	local v23 = p2.PrimaryPart or p2:FindFirstChildWhichIsA("BasePart", true)

	if not v23 then
		return nil
	end

	local BillboardGui = Instance.new("BillboardGui")

	BillboardGui.Name = "MutationBillboard"
	BillboardGui.Active = false
	BillboardGui.AlwaysOnTop = true
	BillboardGui.LightInfluence = 0
	BillboardGui.MaxDistance = 120
	BillboardGui.Size = UDim2.fromScale(5.5, 1.3)
	BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, math.max(n1 - 1, 0) * 2.2 + 6.5, 0)
	BillboardGui.Adornee = v23
	BillboardGui.Parent = p2

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Name = "MutationLabel"
	TextLabel.BackgroundTransparency = 1
	TextLabel.Size = UDim2.fromScale(1, 1)
	TextLabel.Font = Enum.Font.BuilderSansExtraBold
	TextLabel.Text = getMutationLabel(p3)
	TextLabel.TextColor3 = color3
	TextLabel.TextScaled = true
	TextLabel.TextWrapped = true
	TextLabel.Parent = BillboardGui

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = color3_2
	UIStroke.Thickness = 3
	UIStroke.Parent = TextLabel

	return BillboardGui
end

function t1.new(p4, p5) -- line: 112
	-- upvalues: Enemies (copy), Mutations (copy), VfxUtils (copy), HealthBarBillboard (copy), ClientActorUtils (copy), createMutationBillboard (copy), t1 (copy)
	local clone = Enemies.getModel(p4.enemyId):Clone()

	Enemies.applyMutationVisuals(clone, p4.enemyId, p4.mutations)

	local v30 = Enemies.getEnemyInfo(p4.enemyId)
	local v31 = Enemies.getEnemyColors()
	local v32 = v31[1] or Color3.fromRGB(255, 255, 255)
	local v33 = v31[2] or v32
	local v34 = p4.scale or 1

	if math.abs(v34 - 1) > 0.001 then
		clone:ScaleTo(v34)
	end

	clone.Name = tostring(p4.uniqueId)
	clone.Parent = p5

	local v35 = nil

	if Mutations.has(p4.mutations, "shiny") then
		v35 = VfxUtils.getVfx("ShinyParticles")

		local v36 = clone.PrimaryPart or (clone.PrimaryPart or clone:FindFirstChildWhichIsA("BasePart", true))

		if v36 then
			v35.Parent = v36
		else
			v35:Destroy()
			v35 = nil
		end
	end

	local v37 = setmetatable({
		lookVector = Vector3.new(0, 0, 1),
		velocity = Vector3.new(0, 0, 0),
		uniqueId = p4.uniqueId,
		enemyId = p4.enemyId,
		mutations = p4.mutations,
		pos = Vector3.new(p4.pos.X, 0, p4.pos.Z),
		speed = p4.speed,
		scale = v34,
		animationSpeed = math.clamp(p4.speed / math.max(if not v30 or not (v30.speed > 0) then p4.speed else v30.speed, 0.001), 0.35, 3),
		state = p4.state,
		targetUniqueId = p4.targetUniqueId,
		health = p4.health,
		maxHealth = p4.maxHealth,
		healthBar = HealthBarBillboard.new(clone),
		visuals = ClientActorUtils.newCombatVisualState(),
		highlight = ClientActorUtils.createDamageHighlight(clone),
		hitSplat = ClientActorUtils.createHitSplatVfx(clone, v32, v33),
		idleTrack = ClientActorUtils.playIdleAnimation(clone),
		mutationBillboard = if not Mutations.hasAny(p4.mutations) then nil else createMutationBillboard(clone, p4.mutations, v34),
		shinyVfx = v35,
		model = clone
	}, t1)

	if math.abs(v37.scale - 1) > 0.001 then
		local vector3 = Vector3.new(0, math.max((v37.scale - 1) * 2.2, 0), 0)

		v37.healthBar.baseStudsOffset = v37.healthBar.baseStudsOffset + vector3
		v37.healthBar.gui.StudsOffsetWorldSpace = v37.healthBar.baseStudsOffset
	end

	local v39, v40 = ClientActorUtils.getLookAtCFrame(v37.pos, v37.lookVector, nil, 12, 0)

	v37.lookVector = v40
	v37.model:PivotTo(v39)
	v37.healthBar:setHealth(v37.health, v37.maxHealth)
	v37:syncAnimationState()

	return v37
end
function t1.syncAnimationState(p6) -- line: 184
	-- upvalues: ClientActorUtils (copy)
	if not ClientActorUtils.animationsEnabled() then
		if p6.idleTrack then
			p6.idleTrack:Stop(0.1)
			p6.idleTrack:Destroy()
			p6.idleTrack = nil
		end

		return
	end

	if not p6.idleTrack then
		p6.idleTrack = ClientActorUtils.playIdleAnimation(p6.model)
	elseif not p6.idleTrack.IsPlaying then
		p6.idleTrack:Play(0.1)
	end

	if p6.idleTrack then
		p6.idleTrack:AdjustSpeed(p6.animationSpeed)
	end
end
function t1.setState(p7, n2: number, s1: string?) -- line: 205
	-- upvalues: enemyStates (copy), ClientActorUtils (copy)
	local state = p7.state

	p7.state = n2
	p7.targetUniqueId = s1

	local v46 = state == enemyStates.targetingSlime or state == enemyStates.attacking

	if n2 == enemyStates.followingPlayer and v46 then
		ClientActorUtils.beginCombatExitHold(p7.visuals, 0.2)
		p7.velocity = Vector3.new(0, 0, 0)
	end
end
function t1.setHealth(p8, n3: number, n4: number) -- line: 218
	p8.health = n3
	p8.maxHealth = n4
	p8.healthBar:setHealth(n3, n4)
end
function t1.getTargetPos(p9, vector3: Vector3, t3: {[any]: any}) -- line: 224
	-- upvalues: enemyStates (copy)
	if p9.state == enemyStates.followingPlayer then
		return vector3
	end

	if (p9.state == enemyStates.targetingSlime or p9.state == enemyStates.attacking) and p9.targetUniqueId and t3[p9.targetUniqueId] then
		return t3[p9.targetUniqueId].pos
	end

	return nil
end

local function correctAttackDrift(p10, vector3: Vector3, n5: number) -- line: 240
	-- upvalues: GameplayServiceUtils (copy)
	local vector3_2 = Vector3.new(vector3.X, 0, vector3.Z)
	local v57 = p10.pos - vector3_2
	local Magnitude = v57.Magnitude

	if Magnitude <= 15 then
		return
	end

	local v59 = if not (p10.lookVector.Magnitude > 0.001) then Vector3.new(-0, -0, -1) else -p10.lookVector.Unit
	local v60 = vector3_2 + ((if not (Magnitude > 0.001) then v59 else v57.Unit)) * 8.5

	p10.pos = GameplayServiceUtils.moveTowards(p10.pos, v60, p10.speed, n5)
end

function t1.update(p11, n6: number, vector3: Vector3, t4: {[any]: any}) -- line: 254
	-- upvalues: ClientActorUtils (copy), enemyStates (copy), GameplayServiceUtils (copy), correctAttackDrift (copy)
	local v65 = p11:getTargetPos(vector3, t4)

	ClientActorUtils.advanceCombatVisualState(p11.visuals, n6)

	if (p11.state == enemyStates.followingPlayer or p11.state == enemyStates.targetingSlime) and (v65 and p11.visuals.combatExitHoldTime <= 0) then
		local vector3_3 = Vector3.new(v65.X, 0, v65.Z)
		local v67, v68 = GameplayServiceUtils.predictFluidMovement(p11.pos, p11.velocity, vector3_3, p11.speed, 8, p11.speed * 2, n6)

		p11.pos = v67
		p11.velocity = v68
	else
		p11.velocity = Vector3.new(0, 0, 0)
	end

	p11.pos = Vector3.new(p11.pos.X, 0, p11.pos.Z)

	if p11.state == enemyStates.attacking and v65 then
		correctAttackDrift(p11, v65, n6)
	end

	local v69 = p11.pos + ClientActorUtils.getVisualOffset(p11.visuals, 0.34, 4.25, 0.32)
	local v70 = p11.visuals.attackFocusPos or v65
	local v71, v72 = ClientActorUtils.getLookAtCFrame(v69, p11.lookVector, v70, 12, n6)

	p11.lookVector = v72
	p11.model:PivotTo(v71)
	p11:syncAnimationState()
	p11.healthBar:update(n6)
	ClientActorUtils.updateDamageHighlight(p11.visuals, p11.highlight, 0.28, 0.12, 0)
end
function t1.onAttack(p12, vector3: Vector3?, _: number) -- line: 304
	-- upvalues: ClientActorUtils (copy)
	ClientActorUtils.startAttack(p12.visuals, p12.pos, vector3, p12.lookVector, 0.34)
	p12:playAttackVfx()
end
function t1.onDamaged(p13, vector3: Vector3?, n8: number, n9: number?) -- line: 309
	-- upvalues: ClientActorUtils (copy), enemyStates (copy)
	local v80 = n9 or p13.maxHealth

	ClientActorUtils.applyDamage(p13.visuals, p13.pos, vector3, p13.lookVector, n8, v80, 0.32, 5.25, 0.28, p13.state ~= enemyStates.attacking)
	ClientActorUtils.emitHitSplat(p13.hitSplat, ClientActorUtils.getHitSplatEmitCount(n8, v80), true)
end
function t1.playAttackVfx(_) -- line: 326
end
function t1.playDeathVfx(p15) -- line: 328
	-- upvalues: ClientActorUtils (copy)
	ClientActorUtils.emitDetachedHitSplat(p15.hitSplat, 10, true)
end
function t1.destroy(p16) -- line: 332
	if p16.idleTrack then
		p16.idleTrack:Stop(0.1)
		p16.idleTrack:Destroy()
	end

	if p16.mutationBillboard then
		p16.mutationBillboard:Destroy()
	end

	if p16.shinyVfx then
		p16.shinyVfx:Destroy()
	end

	p16.healthBar:destroy()
	p16.highlight:Destroy()
	p16.model:Destroy()
end

return t1
