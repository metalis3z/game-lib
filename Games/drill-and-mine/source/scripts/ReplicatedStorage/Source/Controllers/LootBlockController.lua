-- LootBlockController
-- Client side of the store loot blocks' in-hand click-to-open flow
-- (server: LootBlockService).
--
-- While a loot block (GameConfig.LuckyBlocks[id].IsLootBlock) is equipped,
-- clicking / tapping:
--   1. asks the server for a roll (RequestLootOpen; the inventory mutation is
--      deferred server-side so the hotbar doesn't spoil the reveal),
--   2. DETACHES the block: a world-anchored stand-in is planted right where
--      the block was held and the whole open plays out THERE -- the player
--      can run off mid-open and nothing follows them,
--   3. shakes the planted block, pops it and runs the Get Slim-style roll:
--      the block's loot options cycle at one anchor point as fast-spinning
--      BLACK SILHOUETTES with dwell times easing longer, then the winner
--      reveals with a screen flash, camera punch, FOV kick and a satisfying
--      scale bounce (billboard with name/rarity/value above it),
--   4. LAUNCHES the loot into the player with a rarity-colored trail and
--      confirms the reveal -- the server then consumes one block and adds
--      the loot item to the inventory (hotbar viewport slot appears via the
--      normal Inventory update). NO cash is paid at open: the item's value
--      is realized when it's sold at the Sell Shop.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local Debris = game:GetService("Debris")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local EquipVisualController = require(ReplicatedStorage.Source.Controllers.EquipVisualController)
local FormatUtils = require(ReplicatedStorage.Source.Utils.FormatUtils)

local LootBlockController = {}

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local LuckyBlockRemotes = Remotes:WaitForChild("LuckyBlockService")
local RequestLootOpenFunc = LuckyBlockRemotes:WaitForChild("RequestLootOpen")
local ConfirmLootRevealEvent = LuckyBlockRemotes:WaitForChild("ConfirmLootReveal")

local InventoryRemotes = Remotes:WaitForChild("InventoryService")
local InventoryUpdateEvent = InventoryRemotes:WaitForChild("InventoryUpdate")
local EquippedItemUpdateEvent = InventoryRemotes:WaitForChild("EquippedItemUpdate")
local RequestEquippedItemFunc = InventoryRemotes:WaitForChild("RequestEquippedItem")

-- Wind-up (the planted block shakes in place before popping).
local SHAKE_DURATION = 0.5
local SHAKE_MAX_ANGLE = math.rad(14)
local SHAKE_MAX_JITTER = 0.22
local SHAKE_LIFT = 0.6 -- studs the block rises during the wind-up

-- Open-sequence sounds -- ids get pasted in as they're uploaded; an empty
-- slot is simply silent so the sequence never depends on them.
-- Each slot is a sound id, OR a list of ids that play OVERLAPPED together.
local OPEN_SOUND_IDS = {
	Windup = "", -- block shaking in place right after the click
	Pop = "rbxassetid://84872960927850", -- block bursts open, roll starts ("when it opens")
	RollTick = "rbxassetid://137872392480008", -- every option switching during the roll
	-- "when I get an item": the new get-item sound layered over the one we
	-- already had (6079105785), so both play at once on the reveal.
	Reveal = { "rbxassetid://17426290935", "rbxassetid://6079105785" },
	FlyIn = "", -- loot launching itself into the player
}
local OPEN_SOUND_VOLUME = 0.6

-- Get Slim-style roll ("scroll through the options").
local ROLL_ITEM_MAX_DIM = 4.5 -- roll/reveal models normalized to this bbox size
local ROLL_MIN_ENTRIES = 10
local ROLL_MAX_ENTRIES = 14
local SPIN_SPEED_RAD_PER_SEC = math.rad(720) -- 2 spins/sec during the roll
local REVEAL_HOLD_TIME = 1.1 -- pause on the revealed loot before the fly-in
local FLY_IN_DURATION = 0.6
local BILLBOARD_SCALE = 0.6
local BILLBOARD_Y_ABOVE_TOP = 1.0

local RarityGradients = ReplicatedStorage:WaitForChild("Gradients"):WaitForChild("Rarity")
local EffectsFolder = ReplicatedStorage:FindFirstChild("Effects")

-- Deferred to dodge controller load-order; cached after first lookup.
local NotificationsController = nil
local function getNotificationsController()
	if NotificationsController == false then return nil end
	if NotificationsController then return NotificationsController end
	local ok, mod = pcall(function()
		return require(ReplicatedStorage.Source.Controllers.NotificationsController)
	end)
	NotificationsController = (ok and mod) or false
	return NotificationsController or nil
end

local cachedEquippedSummary = nil
local isOpening = false

local function getEquippedLootBlockId()
	local summary = cachedEquippedSummary
	if not summary then return nil end
	local itemId = summary.ItemId or ""
	if itemId == "" then return nil end
	local cfg = GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[itemId]
	if cfg and cfg.IsLootBlock then return itemId end
	return nil
end

local function setHeldLabel(label, text)
	if not label then return end
	label.Text = text
	local inner = label:FindFirstChild("Inner")
	if inner and inner:IsA("TextLabel") then
		inner.Text = text
	end
end

-- Same PodiumBillboard recipe the held blocks use: Name + Rarity gradient,
-- Income line repurposed as the cash payout.
local function buildLootBillboard(lootCfg)
	local bbTemplate = StarterGui:FindFirstChild("PodiumBillboard")
	if not bbTemplate then return nil end
	local billboard = bbTemplate:Clone()
	billboard.Size = UDim2.new(
		billboard.Size.X.Scale * BILLBOARD_SCALE,
		billboard.Size.X.Offset * BILLBOARD_SCALE,
		billboard.Size.Y.Scale * BILLBOARD_SCALE,
		billboard.Size.Y.Offset * BILLBOARD_SCALE
	)
	setHeldLabel(billboard:FindFirstChild("Name"), lootCfg.DisplayName or "???")
	-- sell VALUE (realized at the Sell Shop), not a payout
	setHeldLabel(billboard:FindFirstChild("Income"), "$" .. FormatUtils.Abbreviate(lootCfg.CashReward or 0))
	local typeLabel = billboard:FindFirstChild("Type")
	if typeLabel then typeLabel.Visible = false end
	local timerFrame = billboard:FindFirstChild("TimerFrame")
	if timerFrame then timerFrame.Visible = false end
	local rarity = lootCfg.Rarity
	local rarityLabel = billboard:FindFirstChild("Rarity")
	if rarityLabel and rarity then
		rarityLabel.Text = rarity
		local rarityInner = rarityLabel:FindFirstChild("Rarity")
		local host = rarityInner or rarityLabel
		if rarityInner then rarityInner.Text = rarity end
		for _, ch in ipairs(host:GetChildren()) do
			if ch:IsA("UIGradient") then ch:Destroy() end
		end
		local grad = RarityGradients:FindFirstChild(rarity)
		if grad then grad:Clone().Parent = host end
	end
	return billboard
end

local function findLootTemplate(lootCfg)
	local lootRoot = ReplicatedStorage:FindFirstChild("LuckyBlockLoot")
	if not lootRoot then return nil end
	local tierFolder = lootCfg.LootFolder and lootRoot:FindFirstChild(lootCfg.LootFolder)
	if tierFolder then
		local hit = tierFolder:FindFirstChild(lootCfg.ModelName)
		if hit then return hit end
	end
	for _, folder in ipairs(lootRoot:GetChildren()) do
		local hit = folder:FindFirstChild(lootCfg.ModelName)
		if hit then return hit end
	end
	return nil
end

-- 3D one-shot at a world position (falls back to the camera when the
-- sequence has no anchor yet). Empty/missing slot = silent no-op.
local function playOpenSound(key, position)
	local ids = OPEN_SOUND_IDS[key]
	if not ids then return end
	if type(ids) == "string" then ids = { ids } end
	for _, id in ipairs(ids) do
		if id ~= "" then
			local host = Instance.new("Part")
			host.Anchored = true
			host.CanCollide = false
			host.CanQuery = false
			host.CanTouch = false
			host.Transparency = 1
			host.Size = Vector3.new(0.5, 0.5, 0.5)
			host.Position = position or (camera and camera.CFrame.Position) or Vector3.zero
			host.Parent = Workspace
			local sound = Instance.new("Sound")
			sound.SoundId = id
			sound.Volume = OPEN_SOUND_VOLUME
			sound.RollOffMaxDistance = 120
			sound.Parent = host
			sound:Play()
			sound.Ended:Once(function() host:Destroy() end)
			Debris:AddItem(host, 6)
		end
	end
end

-- One-shot particle burst at the block's position when it pops open.
-- HatchEffect (Attachment) preferred, Fireworks1 (Part) fallback; both are
-- guarded so a missing effect never blocks the reveal.
local function burstEffectAt(position)
	if not EffectsFolder then return end
	local source = EffectsFolder:FindFirstChild("HatchEffect") or EffectsFolder:FindFirstChild("Fireworks1")
	if not source then return end

	local host = Instance.new("Part")
	host.Size = Vector3.new(1, 1, 1)
	host.Transparency = 1
	host.CanCollide = false
	host.CanQuery = false
	host.CanTouch = false
	host.Anchored = true
	host.Position = position
	host.Parent = Workspace

	local cloned = source:Clone()
	cloned.Parent = host
	if cloned:IsA("BasePart") then
		cloned.Transparency = 1
		cloned.Anchored = true
		cloned.CanCollide = false
		cloned.Position = position
	end
	for _, emitter in ipairs(cloned:GetDescendants()) do
		if emitter:IsA("ParticleEmitter") then
			emitter.Enabled = true
			task.delay(0.35, function() emitter.Enabled = false end)
		end
	end
	if cloned:IsA("ParticleEmitter") then
		cloned.Enabled = true
		task.delay(0.35, function() cloned.Enabled = false end)
	end

	Debris:AddItem(host, 2.5)
end

-- Plants a world-anchored stand-in of the held block at its current spot.
-- The open animation runs on THIS copy, fixed in the world, while the real
-- (hidden) held model keeps following the player.
local function makeStageBlock(heldModel, stageCF)
	if not heldModel or not heldModel.PrimaryPart then return nil end
	local stage = heldModel:Clone()
	stage.Name = "LootOpenStage"
	-- strip the held-copy extras: overhead billboard + its attachment
	for _, d in ipairs(stage:GetDescendants()) do
		if d:IsA("BillboardGui") then
			d:Destroy()
		elseif d:IsA("Attachment") and d.Name == "HeldLuckyOverheadAtt" then
			d:Destroy()
		end
	end
	stage:PivotTo(stageCF)
	stage.Parent = Workspace
	return stage
end

-- Shake/lift the planted block for `duration` seconds around its fixed world
-- CFrame. Intensity ramps up so the pop feels earned. Keeps the timing even
-- if the stand-in couldn't be built.
local function shakeStageBlock(stage, stageCF, duration)
	if not stage then
		task.wait(duration)
		return
	end
	local elapsed = 0
	while elapsed < duration do
		local dt = task.wait()
		if not stage.Parent then return end
		elapsed += dt
		local progress = math.min(elapsed / duration, 1)
		local intensity = progress * progress
		local jitter = SHAKE_MAX_JITTER * intensity
		local angle = SHAKE_MAX_ANGLE * intensity
		stage:PivotTo(stageCF
			* CFrame.new(
				(math.random() - 0.5) * 2 * jitter,
				SHAKE_LIFT * progress + (math.random() - 0.5) * 2 * jitter,
				(math.random() - 0.5) * 2 * jitter)
			* CFrame.Angles(
				(math.random() - 0.5) * 2 * angle,
				(math.random() - 0.5) * 2 * angle,
				(math.random() - 0.5) * 2 * angle))
	end
end

-- Clone + prepare the loot model for the floating showcase.
local function buildRevealModel(lootCfg)
	local template = findLootTemplate(lootCfg)
	if not template then return nil end
	local model = template:Clone()
	model.Name = "LootReveal"
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
			d.CanQuery = false
			d.CanTouch = false
			d.CastShadow = false
		elseif d:IsA("ProximityPrompt") then
			d:Destroy()
		end
	end
	if not model.PrimaryPart then
		local largest, largestVol = nil, 0
		for _, d in ipairs(model:GetDescendants()) do
			if d:IsA("BasePart") then
				local vol = d.Size.X * d.Size.Y * d.Size.Z
				if vol > largestVol then largest, largestVol = d, vol end
			end
		end
		if not largest then
			model:Destroy()
			return nil
		end
		model.PrimaryPart = largest
	end
	local _, bbSize = model:GetBoundingBox()
	local maxDim = math.max(bbSize.X, bbSize.Y, bbSize.Z, 0.01)
	model:ScaleTo(model:GetScale() * (ROLL_ITEM_MAX_DIM / maxDim))
	return model
end

-- Billboard above the showcase loot, hosted on its own invisible anchored
-- part instead of an attachment on the model: loot models ship with
-- arbitrary primary-part rotations and keep spinning/bouncing through the
-- reveal, so a part-local +Y attachment offset can point anywhere -- that's
-- what kept planting the billboard inside/off to the side of the model. The
-- world-space host is immune to the model's rotation and scale bounce; it
-- sits above the model's PEAK-bounce top so nothing ever clips.
local REVEAL_BOUNCE_PEAK = 1.5 -- covers the 1.38x bounce measured at the 0.92x dip
local function attachRevealBillboard(model, lootCfg, anchorPos)
	local bb = buildLootBillboard(lootCfg)
	if not bb then return nil end
	local _, bbSize = model:GetBoundingBox()
	local host = Instance.new("Part")
	host.Name = "LootRevealBillboardHost"
	host.Anchored = true
	host.CanCollide = false
	host.CanQuery = false
	host.CanTouch = false
	host.Transparency = 1
	host.Size = Vector3.new(0.5, 0.5, 0.5)
	host.Position = anchorPos + Vector3.new(0, (bbSize.Y / 2) * REVEAL_BOUNCE_PEAK + BILLBOARD_Y_ABOVE_TOP, 0)
	host.Parent = Workspace
	bb.MaxDistance = 0
	bb.StudsOffsetWorldSpace = Vector3.zero
	bb.Adornee = host
	bb.Parent = host
	Debris:AddItem(host, 12) -- safety net; normally destroyed when the fly-in starts
	return host
end

local function notifyLoot(lootCfg)
	local nc = getNotificationsController()
	if not nc then return end
	nc.SendGreen(string.format("You unboxed %s! (worth $%s)",
		lootCfg.DisplayName or "???",
		FormatUtils.Abbreviate(lootCfg.CashReward or 0)))
end

-- ---------------------------------------------------------------------
-- Get Slim-style roll engine (ported from Get Slim For Brainrots'
-- BrainrotUnboxing at the user's request; sounds intentionally NOT ported).
-- ---------------------------------------------------------------------

local function easeOutQuint(t) local m = 1 - t return 1 - m * m * m * m * m end
local function easeOutQuart(t) local m = 1 - t return 1 - m * m * m * m end
local function easeOutCubic(t) local m = 1 - t return 1 - m * m * m end
local function easeInQuad(t) return t * t end

-- Per-entry dwell: fast at the head, settling toward the reveal.
local function rollDurationFor(i, total)
	local p = (i - 1) / math.max(total - 1, 1)
	return 0.04 + math.pow(p, 2.8) * 0.38
end

local SILHOUETTE_COLOR = Color3.new(0, 0, 0)

-- Paints the model black (mystery silhouette during the roll) and returns
-- what to restore for the winner reveal. FX stay disabled until the reveal.
local function applySilhouette(model)
	local saved = {}
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BasePart") then
			local entry = { obj = d, color = d.Color, material = d.Material, reflectance = d.Reflectance }
			if d:IsA("MeshPart") then
				entry.textureId = d.TextureID
				d.TextureID = ""
			end
			table.insert(saved, entry)
			d.Color = SILHOUETTE_COLOR
			d.Material = Enum.Material.SmoothPlastic
			d.Reflectance = 0
		elseif d:IsA("Decal") or d:IsA("Texture") then
			table.insert(saved, { obj = d, trans = d.Transparency })
			d.Transparency = 1
		elseif d:IsA("SurfaceAppearance") then
			table.insert(saved, { obj = d, parent = d.Parent })
			d.Parent = nil
		elseif d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam") or d:IsA("Fire") or d:IsA("Sparkles") or d:IsA("Smoke") or d:IsA("PointLight") or d:IsA("SurfaceLight") or d:IsA("SpotLight") then
			table.insert(saved, { obj = d, enabled = d.Enabled })
			d.Enabled = false
		end
	end
	return saved
end

local function removeSilhouette(saved)
	if not saved then return end
	for _, s in ipairs(saved) do
		if s.obj then
			if s.parent then
				s.obj.Parent = s.parent
			elseif s.obj.Parent then
				if s.color then s.obj.Color = s.color end
				if s.material then s.obj.Material = s.material end
				if s.reflectance then s.obj.Reflectance = s.reflectance end
				if s.trans ~= nil then s.obj.Transparency = s.trans end
				if s.textureId then pcall(function() s.obj.TextureID = s.textureId end) end
				if s.enabled ~= nil then pcall(function() s.obj.Enabled = s.enabled end) end
			end
		end
	end
end

-- Single-PivotTo placer: measures the bbox-to-pivot offset once and reuses
-- it, so the model's bbox CENTER (not its arbitrary pivot) sits at the
-- anchor no matter the model or its current scale.
local function makeBboxPlacer(model)
	local initialRot = model:GetPivot().Rotation
	local measureScale = model:GetScale()
	local measurePivot = model:GetPivot()
	local measureBbox = model:GetBoundingBox()
	local worldOffset = measureBbox.Position - measurePivot.Position
	local localOffset = initialRot:Inverse():VectorToWorldSpace(worldOffset)
	return function(worldPos, rotation)
		if not model.Parent then return end
		rotation = rotation or initialRot
		local scaledLocal = localOffset * (model:GetScale() / measureScale)
		local rotatedOffset = rotation:VectorToWorldSpace(scaledLocal)
		model:PivotTo(CFrame.new(worldPos - rotatedOffset) * rotation)
	end
end

local function scaleOutAndDestroy(model, duration)
	if not model or not model.Parent then return end
	task.spawn(function()
		local s0 = model:GetScale()
		local start = os.clock()
		while os.clock() - start < duration do
			RunService.RenderStepped:Wait()
			if not model.Parent then return end
			local t = math.min((os.clock() - start) / duration, 1)
			local eased = easeInQuad(t)
			model:ScaleTo(math.max(s0 * (1 - eased), 0.001))
			for _, d in ipairs(model:GetDescendants()) do
				if d:IsA("BasePart") then
					d.LocalTransparencyModifier = eased
				end
			end
		end
		if model.Parent then model:Destroy() end
	end)
end

local function screenFlash()
	local flash = Instance.new("ColorCorrectionEffect")
	flash.Name = "LootRevealFlash"
	flash.Brightness = 0
	flash.Saturation = 0
	flash.Parent = Lighting
	TweenService:Create(flash, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Brightness = 0.35,
		Saturation = 0.3,
	}):Play()
	task.delay(0.1, function()
		TweenService:Create(flash, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Brightness = 0,
			Saturation = 0,
		}):Play()
		task.delay(0.55, function() if flash.Parent then flash:Destroy() end end)
	end)
end

local function cameraPunch(magnitude, dur)
	local char = player.Character
	local humanoid = char and char:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	task.spawn(function()
		local start = os.clock()
		while os.clock() - start < dur do
			RunService.RenderStepped:Wait()
			if not humanoid.Parent then return end
			local t = (os.clock() - start) / dur
			local falloff = (1 - t) * (1 - t)
			humanoid.CameraOffset = Vector3.new(
				(math.random() - 0.5) * 2 * magnitude * falloff,
				(math.random() - 0.5) * 2 * magnitude * falloff,
				(math.random() - 0.5) * 2 * magnitude * falloff
			)
		end
		if humanoid.Parent then humanoid.CameraOffset = Vector3.zero end
	end)
end

local function tweenFOV(targetFOV, duration, style)
	TweenService:Create(
		camera,
		TweenInfo.new(duration, style or Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{ FieldOfView = targetFOV }
	):Play()
end

-- Rarity-colored motion trail for the fly-in: Color comes straight off the
-- same Gradients.Rarity UIGradient the billboards use, so the streak always
-- matches the loot's rarity. Attachments sit on the primary part, so the
-- trail narrows naturally as the model shrinks into the player.
local function attachFlyTrail(model, rarity)
	local pp = model.PrimaryPart
	if not pp then return end
	local _, bbSize = model:GetBoundingBox()
	local half = math.max(bbSize.Y * 0.25, 0.4)
	local a0 = Instance.new("Attachment")
	a0.Position = Vector3.new(0, half, 0)
	a0.Parent = pp
	local a1 = Instance.new("Attachment")
	a1.Position = Vector3.new(0, -half, 0)
	a1.Parent = pp
	local trail = Instance.new("Trail")
	trail.Attachment0 = a0
	trail.Attachment1 = a1
	local grad = rarity and RarityGradients:FindFirstChild(rarity)
	if grad and grad:IsA("UIGradient") then
		trail.Color = grad.Color
	end
	trail.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.15),
		NumberSequenceKeypoint.new(1, 1),
	})
	trail.WidthScale = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(1, 0.2),
	})
	trail.Lifetime = 0.3
	trail.FaceCamera = true
	trail.LightEmission = 1
	trail.LightInfluence = 0
	trail.Parent = pp
end

-- Builds a client-side visual sequence over the block's loot options (winner
-- forced last) and plays the whole roll + reveal + fly-in. Yields until done.
-- Purely visual: the caller commits the real state via ConfirmLootReveal.
local function playLootRoll(blockCfg, winnerLootId, anchorPos)
	local pool = blockCfg.Loot or {}
	local totalWeight = 0
	for _, e in ipairs(pool) do totalWeight += (e.Chance or 0) end
	local function pickVisual()
		if totalWeight <= 0 or #pool == 0 then return winnerLootId end
		local roll = math.random() * totalWeight
		local cum = 0
		for _, e in ipairs(pool) do
			cum += (e.Chance or 0)
			if roll <= cum then return e.LootId end
		end
		return pool[#pool].LootId
	end

	local sequence = {}
	local count = math.random(ROLL_MIN_ENTRIES, ROLL_MAX_ENTRIES)
	for i = 1, count - 1 do
		sequence[i] = pickVisual()
	end
	sequence[count] = winnerLootId

	local originalFOV = camera.FieldOfView
	tweenFOV(originalFOV - 6, 0.4)

	local currentModel, currentSilhouette, currentPlace, currentStoredRot
	local currentBaseScale = 1

	-- PHASE 1: ROLL -- silhouetted options cycle, spinning fast
	for i, lootId in ipairs(sequence) do
		local duration = rollDurationFor(i, #sequence)
		local transDur = math.min(duration, 0.13)
		if currentModel then
			scaleOutAndDestroy(currentModel, math.min(transDur * 1.1, 0.13))
			currentModel = nil
		end

		local lootCfg = GameConfig.LuckyBlocks[lootId]
		local model = lootCfg and buildRevealModel(lootCfg)
		if model then
			currentModel = model
			currentSilhouette = applySilhouette(model)
			currentBaseScale = model:GetScale()
			currentStoredRot = model:GetPivot().Rotation
			currentPlace = makeBboxPlacer(model)
			model:ScaleTo(math.max(currentBaseScale * 0.08, 0.001))

			local spinSeed = math.random() * math.pi * 2
			local itemStart = os.clock()
			currentPlace(anchorPos, CFrame.Angles(0, spinSeed, 0) * currentStoredRot)
			model.Parent = Workspace
			playOpenSound("RollTick", anchorPos)

			while os.clock() - itemStart < duration do
				RunService.RenderStepped:Wait()
				if not model.Parent then break end
				local elapsed = os.clock() - itemStart
				local scaleT = math.min(elapsed / transDur, 1)
				model:ScaleTo(currentBaseScale * (0.08 + easeOutQuint(scaleT) * 0.92))
				local rot = CFrame.Angles(0, spinSeed + elapsed * SPIN_SPEED_RAD_PER_SEC, 0) * currentStoredRot
				local bob = math.sin(os.clock() * 2.4) * 0.25
				currentPlace(anchorPos + Vector3.new(0, bob, 0), rot)
			end
		end
	end

	if not currentModel or not currentModel.Parent then
		tweenFOV(originalFOV, 0.4)
		return
	end

	local winnerCfg = GameConfig.LuckyBlocks[winnerLootId]
	local lastRot = currentModel:GetPivot().Rotation
	local revealBillboardHost = nil

	-- PHASE 2: wind-up -- silhouetted scale dip before the pop
	local windupStart = os.clock()
	local windupDur = 0.22
	while os.clock() - windupStart < windupDur do
		RunService.RenderStepped:Wait()
		if not currentModel.Parent then break end
		local t = (os.clock() - windupStart) / windupDur
		currentModel:ScaleTo(currentBaseScale * (1 - easeInQuad(t) * 0.08))
		currentPlace(anchorPos, lastRot)
	end

	-- PHASE 3: REVEAL
	removeSilhouette(currentSilhouette)
	currentSilhouette = nil
	if winnerCfg then
		revealBillboardHost = attachRevealBillboard(currentModel, winnerCfg, anchorPos)
		notifyLoot(winnerCfg)
	end
	playOpenSound("Reveal", anchorPos)
	screenFlash()
	cameraPunch(0.18, 0.3)
	burstEffectAt(anchorPos)
	tweenFOV(originalFOV - 14, 0.1, Enum.EasingStyle.Quad)
	task.delay(0.12, function() tweenFOV(originalFOV - 5, 0.45) end)

	-- scale bounce 0.92 -> 1.38 (plateau) -> 1.0 with a slow showcase spin
	local revealStart = os.clock()
	local revealDur = 1.0
	local yaw = 0
	while os.clock() - revealStart < revealDur do
		local dt = RunService.RenderStepped:Wait()
		if not currentModel.Parent then break end
		local t = (os.clock() - revealStart) / revealDur
		local scaleMul
		if t < 0.28 then
			scaleMul = 0.92 + easeOutCubic(t / 0.28) * 0.46
		elseif t < 0.42 then
			scaleMul = 1.38
		else
			scaleMul = 1.38 - easeOutQuart((t - 0.42) / 0.58) * 0.38
		end
		currentModel:ScaleTo(currentBaseScale * scaleMul)
		yaw += math.rad(40) * dt
		local rise = (t < 0.5) and (math.sin(t * math.pi) * 0.25) or 0
		currentPlace(anchorPos + Vector3.new(0, rise, 0), CFrame.Angles(0, yaw, 0) * lastRot)
	end
	if currentModel.Parent then
		currentModel:ScaleTo(currentBaseScale)
	end

	task.wait(REVEAL_HOLD_TIME)
	tweenFOV(originalFOV, 0.55)

	-- PHASE 4: LAUNCH -- the loot shoots itself into the player (live target,
	-- so it homes in even if they kept running) behind a rarity-colored trail,
	-- accelerating the whole way. The item lands in the inventory right after
	-- (hotbar slot pops in on the server's Inventory update).
	if currentModel.Parent then
		-- the info card served its purpose during the hold; it doesn't chase
		-- the launch
		if revealBillboardHost then
			revealBillboardHost:Destroy()
			revealBillboardHost = nil
		end
		playOpenSound("FlyIn", anchorPos)
		attachFlyTrail(currentModel, winnerCfg and winnerCfg.Rarity)
		local moveStart = os.clock()
		local startPos = anchorPos
		while os.clock() - moveStart < FLY_IN_DURATION do
			local dt = RunService.RenderStepped:Wait()
			if not currentModel.Parent then break end
			local t = math.min((os.clock() - moveStart) / FLY_IN_DURATION, 1)
			local eased = easeInQuad(t)
			local char = player.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local targetPos = hrp and hrp.Position or startPos
			local pos = startPos:Lerp(targetPos, eased)
			yaw += math.rad(240) * dt
			currentModel:ScaleTo(math.max(currentBaseScale * (1 - eased * 0.97), 0.001))
			currentPlace(pos, CFrame.Angles(0, yaw, 0) * lastRot)
		end
		if currentModel.Parent then currentModel:Destroy() end
	end
end

local function runOpenSequence(data)
	local blockCfg = GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[data.BlockId]
	local lootCfg = GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[data.LootId]
	if not blockCfg or not lootCfg then
		-- Unknown ids -- confirm immediately so the server still commits the loot.
		ConfirmLootRevealEvent:FireServer(data.RevealKey)
		isOpening = false
		return
	end

	local ok, err = pcall(function()
		local char = player.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		local heldModel = EquipVisualController.GetHeldModel()

		-- 1. DETACH & PLANT: the block leaves the hands the moment it's
		--    clicked. A world-anchored stand-in plays the whole open at this
		--    exact spot -- the player is free to run off, nothing follows.
		local stageCF
		if heldModel and heldModel.PrimaryPart then
			stageCF = heldModel:GetPivot()
		elseif hrp then
			stageCF = hrp.CFrame * CFrame.new(0, 0, -4)
		else
			stageCF = CFrame.identity
		end
		local stage = makeStageBlock(heldModel, stageCF)
		EquipVisualController.SetHeldHidden(true)

		-- 2. Wind-up: the planted block shakes in place.
		playOpenSound("Windup", stageCF.Position)
		shakeStageBlock(stage, stageCF, SHAKE_DURATION)

		-- 3. Pop: burst where the block sits, then clear the stand-in.
		local stagePos = stageCF.Position
		if stage then stage:Destroy() end
		burstEffectAt(stagePos)
		playOpenSound("Pop", stagePos)

		-- 4. Roll + reveal + fly-in, anchored just above where the block
		--    opened (world-fixed; only the final launch tracks the player).
		playLootRoll(blockCfg, data.LootId, stagePos + Vector3.new(0, 2.5, 0))
	end)
	if not ok then
		warn("[LootBlockController] open sequence failed:", err)
	end

	-- Commit FIRST, then un-hide once the post-open state has landed.
	-- Re-showing before the server round-trip flashed the just-consumed
	-- BLOCK back into the hands for a few frames before it swapped to the
	-- item / tore down (the "block appears, then turns into the item"
	-- glitch). Waiting for the next inventory/equip push (short timeout as
	-- the safety net) means whatever re-appears is already correct.
	ConfirmLootRevealEvent:FireServer(data.RevealKey)
	local settled = false
	local conns = {
		InventoryUpdateEvent.OnClientEvent:Connect(function() settled = true end),
		EquippedItemUpdateEvent.OnClientEvent:Connect(function() settled = true end),
	}
	local deadline = os.clock() + 1.5
	while not settled and os.clock() < deadline do
		task.wait()
	end
	for _, conn in ipairs(conns) do
		conn:Disconnect()
	end
	EquipVisualController.SetHeldHidden(false)
	isOpening = false
end

local function tryOpen()
	if isOpening then return end
	local blockId = getEquippedLootBlockId()
	if not blockId then return end

	isOpening = true
	local ok, result = pcall(function()
		return RequestLootOpenFunc:InvokeServer(blockId)
	end)
	if not ok or type(result) ~= "table" then
		isOpening = false
		return
	end
	task.spawn(runOpenSequence, result)
end

function LootBlockController.Init()
	EquippedItemUpdateEvent.OnClientEvent:Connect(function(summary)
		cachedEquippedSummary = summary
	end)

	task.defer(function()
		local ok, summary = pcall(function()
			return RequestEquippedItemFunc:InvokeServer()
		end)
		if ok and summary then
			cachedEquippedSummary = summary
		end
	end)

	-- Desktop: left click anywhere in the world (UI clicks arrive with
	-- gameProcessed = true and are ignored).
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			tryOpen()
		end
	end)

	-- Mobile: TouchTap (fires only for taps, not camera drags).
	UserInputService.TouchTap:Connect(function(_positions, gameProcessed)
		if gameProcessed then return end
		tryOpen()
	end)
end

return LootBlockController