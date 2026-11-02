local ContentProvider = game:GetService("ContentProvider")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local InventoryController = require(ReplicatedStorage.Source.Controllers.InventoryController)
local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))
local CashBoostHudController = require(ReplicatedStorage.Source.Controllers.CashBoostHudController)
local FormatUtils = require(ReplicatedStorage.Source.Utils.FormatUtils)

local RebirthController = nil
local function getRebirthMultiplier()
	if not RebirthController then
		RebirthController = require(ReplicatedStorage.Source.Controllers.RebirthController)
	end
	local ok, m = pcall(RebirthController.GetCurrentMultiplier)
	if ok and type(m) == "number" then
		return m
	end
	return 1
end
local function getCashBoostMultiplier()
	local ok, m = pcall(CashBoostHudController.GetMultiplier)
	if ok and type(m) == "number" then
		return m
	end
	return 1
end

local EquippedItemUpdateEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("InventoryService"):WaitForChild("EquippedItemUpdate")

local BrainrotController = {}

-- Brainrot template lookup. New pack layout is
-- ReplicatedStorage.Brainrots.<Rarity>.Normal.<id>; we wrap it behind a
-- BrainrotModels-shaped helper so callers below can keep using
-- `BrainrotModels:FindFirstChild(name)` and `BrainrotModels:GetChildren()`.
local BRAINROTS_FOLDER = ReplicatedStorage:WaitForChild("Brainrots")
local BrainrotModels = setmetatable({}, {
	__index = function(_, key)
		if key == "FindFirstChild" then
			return function(_, name)
				for _, rarityFolder in ipairs(BRAINROTS_FOLDER:GetChildren()) do
					local normal = rarityFolder:FindFirstChild("Normal")
					local hit = normal and normal:FindFirstChild(name)
					if hit then return hit end
				end
				return nil
			end
		elseif key == "GetChildren" then
			return function()
				local list = {}
				for _, rarityFolder in ipairs(BRAINROTS_FOLDER:GetChildren()) do
					local normal = rarityFolder:FindFirstChild("Normal")
					if normal then
						for _, c in ipairs(normal:GetChildren()) do table.insert(list, c) end
					end
				end
				return list
			end
		end
		return nil
	end,
})
local BILLBOARD_TEMPLATE = StarterGui:WaitForChild("PodiumBillboard")
local RarityGradientFolder = ReplicatedStorage:WaitForChild("Gradients"):WaitForChild("Rarity")
local TypeGradientFolder = ReplicatedStorage:WaitForChild("Gradients"):WaitForChild("Type")
local MutationVFXFolder = ReplicatedStorage:WaitForChild("MutationVFX")
local player = Players.LocalPlayer

local SCALE = 0.5
-- Fit-to-size targets for the new Brainrots pack (models ship pre-shrunk to
-- GetScale()~=0.017, so the previous "GetScale() * 0.5" recipe produced
-- 0.04-stud micro-brainrots in the carry visual). The PLACE flow uses a
-- different target (PodiumController) but the carry visual lives here.
-- Bumped from 2.8 -> 5.0 per user request ("scale up brainrots in players hands").
-- Held brainrot scale. User asked for all brainrots to read as "similar size"
-- in hand -- the old fit-to-maxDim normalised the LARGEST axis (so a 3x10x3
-- rig fit Y to 6 but a 10x3x3 rig fit X to 6 and ended up only 1.8 tall).
-- New formula targets HEIGHT first so every rig stands ~CARRY_TARGET_HEIGHT
-- studs tall in the player's hand. Falls back to shrinking proportionally if
-- a wide rig would blow X/Z past CARRY_MAX_WIDTH.
local CARRY_TARGET_HEIGHT = 5.5
local CARRY_MAX_WIDTH = 7.5
local function fitToCarrySize(model)
	local _, curSize = model:GetBoundingBox()
	local h = math.max(curSize.Y, 0.01)
	local s = CARRY_TARGET_HEIGHT / h
	local widestAfter = math.max(curSize.X, curSize.Z) * s
	if widestAfter > CARRY_MAX_WIDTH then
		s = s * (CARRY_MAX_WIDTH / widestAfter)
	end
	model:ScaleTo(model:GetScale() * s)
end
-- Held lucky blocks match the island spawn (LUCKYBLOCK_SCALE in
-- IslandLuckyBlockSpawner) so picking one up doesn't change its size.
-- The previous fit-to-4.5-max-dim path shrank big rigs (Dragon, Slime,
-- Autumn, Heaven*) to ~17-22% of their spawn footprint.
local LUCKYBLOCK_SPAWN_SCALE = 1.45
-- Lucky blocks are held noticeably bigger than brainrots.
local LUCKYBLOCK_HELD_SCALE = SCALE * 2.2
-- User asked the held brainrot to be oriented 90 degrees to the left (flipped
-- from the previous -90 rotation; rig now turns the other way around Y).
-- Brainrot is held facing the *same direction the player is looking*. The
-- mesh ships with identity rotation and a -Z LookVector (verified on the
-- Meowl_Rig template), so no rotation lines the rig up with the player's
-- forward axis. Earlier yaw values (+90° left the rig side-on, 180°
-- spun it to face the camera = "facing back") were the wrong fix; the
-- rig's authoring orientation already matches what we want.
local HOLD_OFFSET = CFrame.new(0, -0.2, -2.0)
-- Lucky blocks are held a bit further FORWARD (away from the body) than
-- brainrots. No yaw: the rig's authoring front faces the player's forward
-- direction. Forward push is size-aware (half-depth + clearance) so wide
-- rigs sit IN FRONT of the player instead of clipping into the torso when
-- their bbox grows past the static -3.6 distance.
local LUCKYBLOCK_HOLD_BACK_CLEARANCE = 1.0
local LUCKYBLOCK_HOLD_Y = -0.2

local function makeLuckyBlockHoldOffset(bbSize)
	local halfDepth = bbSize and math.max(bbSize.Z * 0.5, 1.8) or 1.8
	return CFrame.new(0, LUCKYBLOCK_HOLD_Y, -(LUCKYBLOCK_HOLD_BACK_CLEARANCE + halfDepth))
end
-- Held-brainrot billboard. Was 0.6x the podium template -- user asked for
-- bigger overhead text in hand, so bumped to match podium size (1.0x).
local BILLBOARD_OFFSET = Vector3.new(0, 3.5, 0)
local HELD_BILLBOARD_SIZE = UDim2.fromScale(1.0, 1.0)
-- Held lucky-block billboard. Same template, multiplied to be even bigger
-- than the brainrot overhead since the lucky block is the "hero" of the carry.
local HELD_LUCKYBLOCK_BILLBOARD_SCALE = 1.4

-- Multi-carry stacking: each new pickup sits above the previous one with a
-- small visible gap between their bounding boxes. Per-model height (not a
-- fixed step) so big brainrots get bigger spacing and small ones get less.
local CARRY_STACK_MARGIN = 0.4

local function setLabel(label, text)
	if not label then
		return
	end
	label.Text = text
	local inner = label:FindFirstChild("Inner")
	if inner and inner:IsA("TextLabel") then
		inner.Text = text
	end
end

-- Overhead for a HELD lucky block (Name + Rarity gradient + "xN.NN Luck").
-- Mirrors the island look; parented inside the held model so it moves with it.
local function buildLuckyBlockBillboard(name)
	local cfg = GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[name]
	local billboard = BILLBOARD_TEMPLATE:Clone()
	billboard:SetAttribute("HeldLuckyBlockBillboard", true)
	-- Scale the cloned template up so the held lucky-block overhead text reads
	-- bigger in 3rd-person. Multiplied across both scale and offset components
	-- so anchored UDim2 sizes scale too.
	local m = HELD_LUCKYBLOCK_BILLBOARD_SCALE
	billboard.Size = UDim2.new(
		billboard.Size.X.Scale * m, billboard.Size.X.Offset * m,
		billboard.Size.Y.Scale * m, billboard.Size.Y.Offset * m
	)
	setLabel(billboard:FindFirstChild("Name"), (cfg and cfg.DisplayName) or name)
	setLabel(billboard:FindFirstChild("Income"), string.format("x%.2f Luck", tonumber(cfg and cfg.Luck) or 1))
	local typeLabel = billboard:FindFirstChild("Type")
	if typeLabel then
		typeLabel.Visible = false
	end
	local timerFrame = billboard:FindFirstChild("TimerFrame")
	if timerFrame then
		timerFrame.Visible = false
	end
	local rarity = cfg and cfg.Rarity
	local rarityLabel = billboard:FindFirstChild("Rarity")
	if rarityLabel and rarity then
		rarityLabel.Text = rarity
		local rarityInner = rarityLabel:FindFirstChild("Rarity")
		local host = rarityInner or rarityLabel
		if rarityInner then
			rarityInner.Text = rarity
		end
		for _, ch in ipairs(host:GetChildren()) do
			if ch:IsA("UIGradient") then
				ch:Destroy()
			end
		end
		local grad = RarityGradientFolder:FindFirstChild(rarity)
		if grad then
			grad:Clone().Parent = host
		end
	end
	return billboard
end

-- baseCps, when provided, is the server-authoritative leveled-and-mutated income
-- (e.g. from EquippedItemSummary.CashPerSec). Falls back to config-derived base
-- income for paths that don't have a server number yet (island-pickup carry).
local function computeDisplayIncome(brainrotName, mutationId, baseCps)
	if not baseCps then
		local cfg = GameConfig.Items[brainrotName] or {}
		baseCps = cfg.income or cfg.CashPerSec or 1
		if mutationId and mutationId ~= "" then
			local mutCfg = GameConfig.Mutations[mutationId]
			if mutCfg and mutCfg.CashBoost then
				baseCps = baseCps * mutCfg.CashBoost
			end
		end
	end
	return baseCps * getRebirthMultiplier() * getCashBoostMultiplier()
end

-- PodiumBillboard.Rarity has a same-named inner TextLabel (the stroke twin) which is
-- where the gradient lives. Mirror text to both, drop any old gradient on the inner
-- label, then clone in the matching rarity gradient.
local function applyRarityToBillboard(billboard, brainrotName)
	local rarityLabel = billboard:FindFirstChild("Rarity")
	if not rarityLabel then return end
	local rarity = GameConfig.GetItemRarity(brainrotName)
	rarityLabel.Text = rarity
	local rarityInner = rarityLabel:FindFirstChild("Rarity")
	local gradientHost = rarityInner or rarityLabel
	if rarityInner then
		rarityInner.Text = rarity
	end
	for _, child in ipairs(gradientHost:GetChildren()) do
		if child:IsA("UIGradient") then
			child:Destroy()
		end
	end
	local gradient = RarityGradientFolder:FindFirstChild(rarity)
	if gradient then
		gradient:Clone().Parent = gradientHost
	end
end

-- Roblox's auto-localization (AutoLocalize) fires per-frame for every visible
-- text label and showed up heavily in the microprofiler. The held billboard's
-- text is a brainrot name + cash string — no translation needed.
local function disableAutoLocalize(root)
	root.AutoLocalize = false
	for _, desc in ipairs(root:GetDescendants()) do
		if desc:IsA("GuiBase2d") then
			desc.AutoLocalize = false
		end
	end
end

local function buildBillboard(brainrotName, mutationId, baseCps)
	local billboard = BILLBOARD_TEMPLATE:Clone()
	disableAutoLocalize(billboard)
	billboard.StudsOffsetWorldSpace = BILLBOARD_OFFSET
	-- Scale the template-authored size down for the held view (template
	-- targets podiums, where a 10x7 board reads at distance).
	billboard.Size = UDim2.new(
		billboard.Size.X.Scale * HELD_BILLBOARD_SIZE.X.Scale,
		billboard.Size.X.Offset * HELD_BILLBOARD_SIZE.X.Scale,
		billboard.Size.Y.Scale * HELD_BILLBOARD_SIZE.Y.Scale,
		billboard.Size.Y.Offset * HELD_BILLBOARD_SIZE.Y.Scale
	)

	-- Use GameConfig's DisplayName (e.g. "Meowl") instead of the raw BrainrotId
	-- (e.g. "Meowl_Rig"). Mutation prefix mirrors the placed-pad overhead.
	local nameCfg = GameConfig.Items[brainrotName]
	local displayName = (nameCfg and nameCfg.DisplayName) or brainrotName
	if mutationId and mutationId ~= "" then
		local mutCfg = GameConfig.Mutations[mutationId]
		local mutDisplay = (mutCfg and mutCfg.DisplayName) or mutationId
		displayName = mutDisplay .. " " .. displayName
	end
	setLabel(billboard:FindFirstChild("Name"), displayName)
	-- Match the placed-pad income format ($14.4k/s) instead of %g which printed
	-- raw "$14437.5/s" -- ugly and inconsistent with everywhere else.
	setLabel(billboard:FindFirstChild("Income"), "$" .. FormatUtils.Abbreviate(computeDisplayIncome(brainrotName, mutationId, baseCps)) .. "/s")
	applyRarityToBillboard(billboard, brainrotName)

	local typeLabel = billboard:FindFirstChild("Type")
	if typeLabel then
		if mutationId and mutationId ~= "" then
			local mutCfg = GameConfig.Mutations[mutationId]
			local displayName = (mutCfg and mutCfg.DisplayName) or mutationId
			typeLabel.Text = displayName
			local typeInner = typeLabel:FindFirstChild("Type")
			local gradientHost = typeInner or typeLabel
			if typeInner then
				typeInner.Text = displayName
			end
			typeLabel.Visible = true
			for _, child in ipairs(gradientHost:GetChildren()) do
				if child:IsA("UIGradient") then
					child:Destroy()
				end
			end
			local gradientName = (mutCfg and mutCfg.GradientType) or mutationId
			local mutGradient = TypeGradientFolder:FindFirstChild(gradientName)
			if mutGradient then
				mutGradient:Clone().Parent = gradientHost
			end
		else
			typeLabel.Visible = false
		end
	end

	local timerFrame = billboard:FindFirstChild("TimerFrame")
	if timerFrame then
		timerFrame.Visible = false
	end

	return billboard
end

local currentModel = nil
local currentHandle = nil
local currentHRPWeld = nil
local currentBillboard = nil
local currentVFXAttachment = nil
local displayedName = nil
local displayedMutation = nil
local displayedBaseCps = nil
local characterRemovingConn = nil

-- Held-visual pool. The previous design Cloned the template + ran two
-- GetDescendants loops + welded ~26 parts + Destroyed the model on every equip /
-- unequip — ~3-5ms each, perceptible as a hitch when cycling hotbar slots. Pool
-- entries are built lazily on first equip of each brainrot type and reused
-- forever after. On equip we just PivotTo + HRPWeld; on unequip we destroy the
-- HRPWeld and pivot back to park. Pre-warmed at Init in the background so even
-- the first equip of each type is warm by the time the player gets to it.
-- Mirrors the same pattern IslandBrainrotClient uses for island spawns.
local heldPool = {}
local PARK_CFRAME = CFrame.new(0, -100000, 0)

-- Latest server-authoritative CashPerSec for the equipped brainrot. spawnVisual
-- falls back to this when callers (StartCarry, etc.) don't pass an explicit value,
-- so the held billboard reflects upgrades regardless of which event sequence wins.
local cachedSummaryBrainrotId = nil
local cachedSummaryCashPerSec = nil

-- Lazily-loaded looped Idle AnimationTrack per pool model. Brainrot templates
-- ship an AnimationController + Animator + child Animation called "Idle";
-- we load it once per model (pool models get reused) and cache the track in
-- a weak-keyed table so it auto-clears if the model is ever destroyed.
-- spawnVisual :Play()s it, stopVisual :Stop()s it -- otherwise either the
-- held brainrot sits frozen in T-pose, or parked pool models keep burning
-- Animator CPU between equips.
local idleTrackByHeldModel = setmetatable({}, { __mode = "k" })

local function ensureHeldIdleTrack(model)
	local existing = idleTrackByHeldModel[model]
	if existing then return existing end
	local controller = model:FindFirstChildWhichIsA("AnimationController", true)
	if not controller then return nil end
	local animator = controller:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = controller
	end
	-- Idle Animation can live either under the AnimationController OR as a
	-- direct child of the model -- the current brainrot pack ships it at the
	-- model root (sibling of the controller), not nested inside it. The old
	-- controller:FindFirstChild("Idle") lookup returned nil for every rig in
	-- the new pack, which is why held brainrots stayed frozen.
	local idle
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("Animation") and d.Name == "Idle" then
			idle = d
			break
		end
	end
	if not idle or idle.AnimationId == "" then return nil end
	local track = animator:LoadAnimation(idle)
	track.Looped = true
	idleTrackByHeldModel[model] = track
	return track
end

local function playHeldIdle(model)
	local track = ensureHeldIdleTrack(model)
	if track then track:Play() end
end

local function stopHeldIdle(model)
	local track = idleTrackByHeldModel[model]
	if track then track:Stop(0) end
end

local function refreshHeldIncomeLabel()
	if not currentModel or not displayedName then
		return
	end
	local handle = currentModel:FindFirstChild("Handle")
	if not handle then
		return
	end
	local billboard = handle:FindFirstChildWhichIsA("BillboardGui")
	if not billboard then
		return
	end
	local incomeLabel = billboard:FindFirstChild("Income")
	if not incomeLabel then
		return
	end
	setLabel(incomeLabel, "$" .. FormatUtils.Abbreviate(computeDisplayIncome(displayedName, displayedMutation, displayedBaseCps)) .. "/s")
end

local function stopVisual()
	if characterRemovingConn then
		characterRemovingConn:Disconnect()
		characterRemovingConn = nil
	end
	-- Destroy weld first so the handle stops chasing a (possibly invalid) HRP,
	-- then re-anchor + park. Billboard + VFX are children of handle, so destroying
	-- them is independent of weld state.
	if currentHRPWeld then
		currentHRPWeld:Destroy()
		currentHRPWeld = nil
	end
	if currentBillboard then
		currentBillboard:Destroy()
		currentBillboard = nil
	end
	if currentVFXAttachment then
		currentVFXAttachment:Destroy()
		currentVFXAttachment = nil
	end
	if currentHandle then
		currentHandle.Anchored = true
	end
	if currentModel then
		stopHeldIdle(currentModel)
		currentModel:PivotTo(PARK_CFRAME)
	end
	currentModel = nil
	currentHandle = nil
	displayedName = nil
	displayedMutation = nil
	displayedBaseCps = nil
end

local function ensurePoolEntry(brainrotName)
	local entry = heldPool[brainrotName]
	if entry and entry.model.Parent then return entry end

	local template = BrainrotModels:FindFirstChild(brainrotName)
	if not template then
		warn(string.format("[BrainrotController] Pool template missing: %s", brainrotName))
		return nil
	end

	local model = template:Clone()
	model.Name = "HeldPool_" .. brainrotName

	-- Strip the 2 KeyframeSequence trees baked into the template (~4646 extra
	-- Instances of authoring data per rig). With 25 pool entries warmed up at
	-- Init this was ~116K useless instances in workspace. See PodiumController
	-- for the same fix on placed brainrots.
	for _, desc in ipairs(model:GetDescendants()) do
		if desc:IsA("KeyframeSequence") then
			desc:Destroy()
		end
	end

	-- Single descendant pass: kill humanoids + set all part properties at once.
	-- Previous design did two separate GetDescendants loops on every equip.
	for _, desc in ipairs(model:GetDescendants()) do
		if desc:IsA("Humanoid") then
			desc:Destroy()
		elseif desc:IsA("BasePart") then
			desc.CanCollide = false
			desc.CanQuery = false
			desc.CanTouch = false
			desc.Anchored = true
			desc.Massless = true
			desc.CastShadow = false
		end
	end

	fitToCarrySize(model)

	-- Re-measure after the fit-to-size ScaleTo above so bbSize reflects the
	-- final dimensions. We stash this on the pool entry below and feed it
	-- into spawnVisual's dynamic Z offset (bigger rigs get pushed further
	-- forward so their back edge doesn't clip into the player).
	local bbCF, finalBBSize = model:GetBoundingBox()
	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(0.1, 0.1, 0.1)
	handle.CFrame = bbCF
	handle.Transparency = 1
	handle.CanCollide = false
	handle.CanQuery = false
	handle.CanTouch = false
	handle.Anchored = true
	handle.Massless = true
	handle.CastShadow = false
	handle.Parent = model
	model.PrimaryPart = handle

	model:PivotTo(PARK_CFRAME)
	model.Parent = workspace

	-- Internal welds: every body part to handle. Created after Parent=workspace
	-- so the WeldConstraints bind. Body parts unanchor so the weld is what
	-- carries them with the handle.
	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") and part ~= handle then
			part.Anchored = false
			local w = Instance.new("WeldConstraint")
			w.Part0 = handle
			w.Part1 = part
			w.Parent = handle
		end
	end

	entry = { model = model, handle = handle, bbSize = finalBBSize }
	heldPool[brainrotName] = entry
	return entry
end

-- Dynamic hold offset. Static -2.0 Z worked for medium rigs but made big
-- ones clip into the player and left small ones floating awkwardly far out.
-- -1.0 puts the rig's back edge ~1 stud in front of the torso (clear of the
-- chest collider), then the size-dependent half-depth term pushes the
-- center further forward for bigger rigs. Identity rotation -- mesh ships
-- pointing -Z which matches the player's forward axis.
local HOLD_BACK_CLEARANCE = 1.0
local function makeHoldOffset(bbSize)
	local halfDepth = bbSize and bbSize.Z * 0.5 or 1.4
	return CFrame.new(0, -0.2, -HOLD_BACK_CLEARANCE - halfDepth)
end

local function spawnVisual(brainrotName, mutationId, baseCps)
	stopVisual()

	if not baseCps and cachedSummaryBrainrotId == brainrotName then
		baseCps = cachedSummaryCashPerSec
	end

	local character = player.Character
	if not character then return end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local entry = ensurePoolEntry(brainrotName)
	if not entry then return end

	local model = entry.model
	local handle = entry.handle

	-- Pivot pool model into hold position while handle is still anchored, then
	-- unanchor + weld to HRP. Internal welds are baked in at pool init so the
	-- rig moves as one unit once HRPWeld is live.
	local holdOffset = makeHoldOffset(entry.bbSize)
	model:PivotTo(hrp.CFrame * holdOffset)
	handle.Anchored = false

	local mainWeld = Instance.new("WeldConstraint")
	mainWeld.Name = "HRPWeld"
	mainWeld.Part0 = hrp
	mainWeld.Part1 = handle
	mainWeld.Parent = handle

	currentModel = model
	currentHandle = handle
	currentHRPWeld = mainWeld
	displayedName = brainrotName
	displayedMutation = mutationId
	displayedBaseCps = baseCps

	-- Drive the rig's Idle loop so the held brainrot visibly breathes /
	-- animates instead of holding a static rest pose under the welded HRP.
	playHeldIdle(model)

	-- Defer billboard + VFX. `currentModel ~= model` handles fast re-equip;
	-- `currentBillboard then return end` handles the race where stopVisual
	-- destroyed the previous billboard but a deferred closure from this same
	-- equip is queued to run.
	task.defer(function()
		if currentModel ~= model then return end
		if currentBillboard then return end
		local billboard = buildBillboard(brainrotName, mutationId, baseCps)
		-- Dynamic Y offset above the handle so the overhead always sits ~1 stud
		-- above the rig's bbox top. The static BILLBOARD_OFFSET (+3.5) put the
		-- overhead INSIDE tall rigs (Cacto, Spaghetti) and floating too high
		-- above short ones. entry.bbSize was measured at pool warm-up.
		local bbHalfY = (entry.bbSize and entry.bbSize.Y * 0.5) or 1.7
		-- Extra clearance bumped 1.0 -> 1.6 because the billboard is now full
		-- podium size (was 0.6x) and the bottom edge would touch the model head.
		billboard.StudsOffsetWorldSpace = Vector3.new(0, bbHalfY + 1.6, 0)
		billboard.Adornee = handle
		billboard.Parent = handle
		currentBillboard = billboard
	end)

	if mutationId and mutationId ~= "" then
		task.defer(function()
			if currentModel ~= model then return end
			if currentVFXAttachment then return end
			local mutCfg = GameConfig.Mutations[mutationId]
			local vfxName = mutCfg and mutCfg.VFXName
			local vfxTemplate = vfxName and MutationVFXFolder:FindFirstChild(vfxName)
			if vfxTemplate then
				local vfxAttachment = Instance.new("Attachment")
				vfxAttachment.Name = "HeldMutationVFX"
				vfxAttachment.Parent = handle
				for _, child in ipairs(vfxTemplate:GetChildren()) do
					child:Clone().Parent = vfxAttachment
				end
				currentVFXAttachment = vfxAttachment
			end
		end)
	end

	characterRemovingConn = player.CharacterRemoving:Connect(function()
		stopVisual()
	end)
end

local carryName = nil
local carryMutation = nil

function BrainrotController.StartCarry(brainrotName, mutationId, baseCps)
	carryName = brainrotName
	carryMutation = mutationId
	spawnVisual(brainrotName, mutationId, baseCps)
end

function BrainrotController.StopCarry()
	carryName = nil
	carryMutation = nil
	stopVisual()
end

function BrainrotController.SpawnHeldVisual(brainrotName, mutationId, baseCps)
	spawnVisual(brainrotName, mutationId, baseCps)
end

-- Multi-carry stack: island pickups are held above the player. The first stack
-- item occupies the same hand slot as the equipped-inventory visual (HOLD_OFFSET),
-- so we hide the equipped visual while the stack is non-empty and restore it on
-- clear, mirroring the pre-multicarry behavior of StartCarry/StopCarry.
--
-- Each entry stores its `height` (post-scale Y bbox) and `centerOffsetY`
-- (handle Y relative to HOLD_OFFSET center). Next item sits at
--   prevCenterY + prevHeight/2 + MARGIN + newHeight/2
-- so there is always exactly CARRY_STACK_MARGIN studs of empty space between
-- adjacent bounding boxes regardless of asset size.
local carryStack = {}
local carryStackRemovingConn = nil
local savedEquippedForStack = nil

local function destroyCarryStack()
	for _, entry in ipairs(carryStack) do
		if entry.model then
			entry.model:Destroy()
			entry.model = nil
		end
	end
	carryStack = {}
	if carryStackRemovingConn then
		carryStackRemovingConn:Disconnect()
		carryStackRemovingConn = nil
	end
	if savedEquippedForStack then
		local saved = savedEquippedForStack
		savedEquippedForStack = nil
		spawnVisual(saved.name, saved.mutation, saved.baseCps)
	end
end

local function buildStackedHeldModel(brainrotName, mutationId, isLuckyBlock)
	local character = player.Character
	if not character then
		return nil
	end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then
		return nil
	end

	local template
	if isLuckyBlock then
		local lbFolder = ReplicatedStorage:FindFirstChild("LuckyBlocks")
		template = lbFolder and lbFolder:FindFirstChild(brainrotName)
	else
		template = BrainrotModels:FindFirstChild(brainrotName)
	end
	if not template then
		warn(string.format("[BrainrotController] Model not found for stack: %s", brainrotName))
		return nil
	end

	local model = template:Clone()
	model.Name = "HeldBrainrotStack"

	-- Strip KeyframeSequence authoring data (see ensurePoolEntry comment).
	for _, desc in model:GetDescendants() do
		if desc:IsA("KeyframeSequence") then desc:Destroy() end
	end

	for _, desc in model:GetDescendants() do
		if desc:IsA("Humanoid") then desc:Destroy() end
	end

	for _, desc in model:GetDescendants() do
		if desc:IsA("BasePart") then
			desc.CanCollide = false
			desc.CanQuery = false
			desc.CanTouch = false
			desc.Anchored = true
			desc.Massless = true
			desc.CastShadow = false
		end
	end

	if isLuckyBlock then
		model:ScaleTo(model:GetScale() * LUCKYBLOCK_SPAWN_SCALE)
	else
		fitToCarrySize(model)
	end

	local bbCF, bbSize = model:GetBoundingBox()
	local height = bbSize.Y

	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(0.1, 0.1, 0.1)
	handle.CFrame = bbCF
	handle.Transparency = 1
	handle.CanCollide = false
	handle.CanQuery = false
	handle.CanTouch = false
	handle.Anchored = true
	handle.Massless = true
	handle.CastShadow = false
	handle.Parent = model
	model.PrimaryPart = handle

	if isLuckyBlock then
		-- Overhead lives INSIDE the held model (parented to the welded handle)
		-- so it moves together with the lucky block.
		local bb = buildLuckyBlockBillboard(brainrotName)
		-- Overhead on an Attachment INSIDE the held model (handle is welded to
		-- the HRP) so the text moves with the block. MaxDistance 0 = always seen.
		local ohAtt = Instance.new("Attachment")
		ohAtt.Name = "OverheadAttachment"
		-- Lift bumped from +6 to +7.5 to clear the larger billboard text.
		ohAtt.Position = Vector3.new(0, height / 2 + 7.5, 0)
		ohAtt.Parent = handle
		bb.MaxDistance = 0
		bb.StudsOffsetWorldSpace = Vector3.zero
		bb.Adornee = ohAtt
		bb.Parent = ohAtt
	end

	-- Center-Y for this model in HRP-local space, relative to HOLD_OFFSET’s
	-- center (which is where item #1 sits).
	local centerOffsetY = 0
	if #carryStack > 0 then
		local prev = carryStack[#carryStack]
		centerOffsetY = prev.centerOffsetY + prev.height / 2 + CARRY_STACK_MARGIN + height / 2
	end

	local stackOffset = CFrame.new(0, centerOffsetY, 0)
	local heldOffset = isLuckyBlock and makeLuckyBlockHoldOffset(bbSize) or HOLD_OFFSET
	model:PivotTo(hrp.CFrame * stackOffset * heldOffset)

	if mutationId and mutationId ~= "" then
		local mutCfg = GameConfig.Mutations[mutationId]
		local vfxName = mutCfg and mutCfg.VFXName
		local vfxTemplate = vfxName and MutationVFXFolder:FindFirstChild(vfxName)
		if vfxTemplate then
			local vfxAttachment = Instance.new("Attachment")
			vfxAttachment.Name = "HeldMutationVFX"
			vfxAttachment.Parent = handle
			for _, child in ipairs(vfxTemplate:GetChildren()) do
				child:Clone().Parent = vfxAttachment
			end
		end
	end

	model.Parent = workspace

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") and part ~= handle then
			part.Anchored = false
			local w = Instance.new("WeldConstraint")
			w.Part0 = handle
			w.Part1 = part
			w.Parent = handle
		end
	end

	handle.Anchored = false
	local mainWeld = Instance.new("WeldConstraint")
	mainWeld.Name = "HRPWeld"
	mainWeld.Part0 = hrp
	mainWeld.Part1 = handle
	mainWeld.Parent = handle

	-- Lucky-block rigs ship with their own AnimationController + Idle track.
	-- Only the rigged variants (3+ Bones: Angel / Heaven / Dragon wings,
	-- Slime / Autumn body, Planet rotation, King crown, Chained / Void
	-- chains) animate; plain cube blocks stay static because their 2-bone
	-- wobble Idle reads as a stutter on a held model. Same threshold the
	-- inventory viewport and equipped held-visual use.
	if isLuckyBlock then
		local boneCount = 0
		for _, d in ipairs(model:GetDescendants()) do
			if d:IsA("Bone") then
				boneCount = boneCount + 1
				if boneCount >= 3 then break end
			end
		end
		if boneCount >= 3 then
			local animController = model:FindFirstChildWhichIsA("AnimationController", true)
			if animController then
				local animator = animController:FindFirstChildOfClass("Animator")
				if not animator then
					animator = Instance.new("Animator")
					animator.Parent = animController
				end
				local idle
				for _, d in ipairs(model:GetDescendants()) do
					if d:IsA("Animation") and d.Name == "Idle" then
						idle = d
						break
					end
				end
				if idle and idle.AnimationId ~= "" then
					local okAnim, track = pcall(function()
						return animator:LoadAnimation(idle)
					end)
					if okAnim and track then
						track.Looped = true
						track:Play()
					end
				end
			end
		end
	end

	return model, height, centerOffsetY
end

function BrainrotController.AddCarryStack(brainrotName, mutationId, isLuckyBlock)
	if #carryStack == 0 and currentModel then
		savedEquippedForStack = {
			name = displayedName,
			mutation = displayedMutation,
			baseCps = displayedBaseCps,
		}
		stopVisual()
	end

	local model, height, centerOffsetY = buildStackedHeldModel(brainrotName, mutationId, isLuckyBlock)
	if not model then
		return
	end

	table.insert(carryStack, {
		name = brainrotName,
		mutation = mutationId,
		model = model,
		height = height,
		centerOffsetY = centerOffsetY,
	})

	if not carryStackRemovingConn then
		carryStackRemovingConn = player.CharacterRemoving:Connect(function()
			destroyCarryStack()
		end)
	end
end

function BrainrotController.ClearCarryStack()
	destroyCarryStack()
end

function BrainrotController.GetCarryStackCount()
	return #carryStack
end

function BrainrotController.Init()
	-- Pre-fetch every brainrot animation asset off the hot path. Redundant with the
	-- preload in IslandBrainrotClient and PodiumController; PreloadAsync de-dupes
	-- internally, so the cost is trivial and the benefit is that any controller's
	-- Init order produces a warm cache before the first equip.
	task.spawn(function()
		-- Skip mass preload in Studio (floods ContentProvider with this
		-- template's inaccessible assets -> long join stall).
		if game:GetService("RunService"):IsStudio() then return end
		local toPreload = {}
		for _, data in pairs(GameConfig.Items) do
			if data.animationId and data.animationId ~= "" then
				local a = Instance.new("Animation")
				a.AnimationId = data.animationId
				table.insert(toPreload, a)
			end
		end
		if #toPreload > 0 then
			pcall(function() ContentProvider:PreloadAsync(toPreload) end)
		end
		for _, a in ipairs(toPreload) do a:Destroy() end
	end)

	-- Pre-fetch every Normal brainrot template's meshes/textures. spawnVisual only
	-- ever pulls from BrainrotModels (Normal), even for mutated equips — the held
	-- visual uses the Normal mesh with a mutation VFX on top.
	task.spawn(function()
		if game:GetService("RunService"):IsStudio() then return end
		local templates = {}
		for _, m in ipairs(BrainrotModels:GetChildren()) do
			table.insert(templates, m)
		end
		if #templates > 0 then
			pcall(function() ContentProvider:PreloadAsync(templates) end)
		end
	end)

	-- Pre-warm held-visual pool: build one pool entry per Normal brainrot template
	-- in the background, one per frame, so first-equip of each type is fast.
	-- Starts after a 5-second delay to give other Init work time to finish.
	task.spawn(function()
		task.wait(5)
		for _, template in ipairs(BrainrotModels:GetChildren()) do
			ensurePoolEntry(template.Name)
			task.wait()
		end
	end)

	CashBoostHudController.BoostChanged:Connect(refreshHeldIncomeLabel)

	local RebirthUpdateEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RebirthService"):WaitForChild("RebirthUpdate")
	RebirthUpdateEvent.OnClientEvent:Connect(refreshHeldIncomeLabel)

	InventoryController.OnSelectionChanged(function(brainrotName, mutationId)
		if brainrotName then
			spawnVisual(brainrotName, mutationId)
		else
			stopVisual()
		end
	end)

	-- The server can change the equipped item without the client touching its hotbar
	-- (e.g. a Swap on a podium gives the displaced brainrot back as the equipped one).
	-- Re-spawn the held visual from the new summary so the held model + Type label stay
	-- consistent with what the server says is equipped.
	-- Server EquippedItemUpdate is the source of truth for upgraded income.
	-- Cache the value so any later spawnVisual call (including IslandBrainrotClient's
	-- StartCarry path, whose event handler fires on the same tick) renders the
	-- upgraded CashPerSec. Also update in place if a matching visual already exists.
	EquippedItemUpdateEvent.OnClientEvent:Connect(function(summary)
		if summary and summary.ItemType == "Brainrot" and summary.BrainrotId then
			cachedSummaryBrainrotId = summary.BrainrotId
			cachedSummaryCashPerSec = summary.CashPerSec
			-- If an island multi-carry stack is active, the equipped visual is
			-- hidden — just update the saved record so it restores correctly on
			-- ClearCarryStack instead of spawning over the stack.
			if #carryStack > 0 then
				savedEquippedForStack = {
					name = summary.BrainrotId,
					mutation = summary.Mutation,
					baseCps = summary.CashPerSec,
				}
			elseif currentModel and displayedName == summary.BrainrotId then
				displayedBaseCps = summary.CashPerSec
				refreshHeldIncomeLabel()
			elseif not carryName then
				spawnVisual(summary.BrainrotId, summary.Mutation, summary.CashPerSec)
			end
		else
			cachedSummaryBrainrotId = nil
			cachedSummaryCashPerSec = nil
			if #carryStack > 0 then
				savedEquippedForStack = nil
			elseif not carryName then
				stopVisual()
			end
		end
	end)

	player.CharacterAdded:Connect(function()
		task.wait(0.3)
		if carryName then
			spawnVisual(carryName, carryMutation)
			return
		end
		local selected = InventoryController.GetSelected()
		if selected then
			spawnVisual(selected)
		end
	end)

	-- Equipping a Tool (the axe) clears the held brainrot -- same single-hold
	-- rule that unequipHeldAxe enforces in the other direction. carryName has
	-- to be cleared so the EquippedItemUpdate(empty) handler above isn't
	-- blocked by its `if not carryName` guard, and stopVisual hides the model
	-- now without waiting for the server round-trip from unequipBrainrot.
	local function watchToolEquips(character)
		character.ChildAdded:Connect(function(child)
			if child:IsA("Tool") then
				carryName = nil
				carryMutation = nil
				stopVisual()
			end
		end)
	end
	if player.Character then
		watchToolEquips(player.Character)
	end
	player.CharacterAdded:Connect(watchToolEquips)
end

return BrainrotController
