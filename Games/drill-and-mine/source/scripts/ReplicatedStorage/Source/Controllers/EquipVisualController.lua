local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local FormatUtils = require(ReplicatedStorage.Source.Utils.FormatUtils)

-- Held lucky block billboard template (Name + Rarity gradient + "xN.NN Luck").
-- Same PodiumBillboard the placed pads use; rendered with TimerFrame hidden
-- because held blocks don't run an open countdown.
local HELD_BB_RARITY_FOLDER = ReplicatedStorage:WaitForChild("Gradients"):WaitForChild("Rarity")
local HELD_BB_SCALE = 0.6 -- match the brainrot held billboard's downscale
local HELD_BB_Y_ABOVE_TOP = 1.0 -- studs above the block's top face

local function setHeldLabel(label, text)
	if not label then return end
	label.Text = text
	local inner = label:FindFirstChild("Inner")
	if inner and inner:IsA("TextLabel") then
		inner.Text = text
	end
end

local function buildHeldLuckyBillboard(luckyBlockId)
	local bbTemplate = StarterGui:FindFirstChild("PodiumBillboard")
	if not bbTemplate then return nil end
	local cfg = GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[luckyBlockId]
	if not cfg then return nil end
	local billboard = bbTemplate:Clone()
	billboard:SetAttribute("HeldLuckyBlockBillboard", true)
	billboard.Size = UDim2.new(
		billboard.Size.X.Scale * HELD_BB_SCALE,
		billboard.Size.X.Offset * HELD_BB_SCALE,
		billboard.Size.Y.Scale * HELD_BB_SCALE,
		billboard.Size.Y.Offset * HELD_BB_SCALE
	)
	setHeldLabel(billboard:FindFirstChild("Name"), cfg.DisplayName or luckyBlockId)
	-- Value line by item kind: store loot blocks advertise the click-to-open
	-- interaction, loot items show their cash payout, classic lucky blocks
	-- keep the Luck multiplier.
	local incomeText
	if cfg.IsLootBlock then
		incomeText = "Click to Open!"
	elseif cfg.IsLootItem then
		incomeText = "$" .. FormatUtils.Abbreviate(cfg.CashReward or 0)
	else
		incomeText = string.format("x%.2f Luck", tonumber(cfg.Luck) or 1)
	end
	setHeldLabel(billboard:FindFirstChild("Income"), incomeText)
	local typeLabel = billboard:FindFirstChild("Type")
	if typeLabel then typeLabel.Visible = false end
	local timerFrame = billboard:FindFirstChild("TimerFrame")
	if timerFrame then timerFrame.Visible = false end
	local rarity = cfg.Rarity
	local rarityLabel = billboard:FindFirstChild("Rarity")
	if rarityLabel and rarity then
		rarityLabel.Text = rarity
		local rarityInner = rarityLabel:FindFirstChild("Rarity")
		local host = rarityInner or rarityLabel
		if rarityInner then rarityInner.Text = rarity end
		for _, ch in ipairs(host:GetChildren()) do
			if ch:IsA("UIGradient") then ch:Destroy() end
		end
		local grad = HELD_BB_RARITY_FOLDER:FindFirstChild(rarity)
		if grad then grad:Clone().Parent = host end
	end
	return billboard
end

local function attachHeldLuckyOverhead(model, luckyBlockId)
	local handle = model.PrimaryPart
	if not handle then return end
	if handle:FindFirstChild("HeldLuckyOverheadAtt") then return end -- already attached
	local bb = buildHeldLuckyBillboard(luckyBlockId)
	if not bb then return end
	local _, bbSize = model:GetBoundingBox()
	local handleY = handle.Position.Y
	local topY = handle.Position.Y + bbSize.Y / 2 -- not quite right (handle isn't always model center); recompute via bbox
	local bbCF = model:GetBoundingBox()
	local topAboveHandle = (bbCF.Position.Y + bbSize.Y / 2) - handleY
	local att = Instance.new("Attachment")
	att.Name = "HeldLuckyOverheadAtt"
	att.Position = Vector3.new(0, topAboveHandle + HELD_BB_Y_ABOVE_TOP, 0)
	att.Parent = handle
	bb.MaxDistance = 0
	bb.StudsOffsetWorldSpace = Vector3.zero
	bb.Adornee = att
	bb.Parent = att
end

local EquipVisualController = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local InventoryRemotes = Remotes:WaitForChild("InventoryService")
local InventoryUpdateEvent = InventoryRemotes:WaitForChild("InventoryUpdate")
local EquippedItemUpdateEvent = InventoryRemotes:WaitForChild("EquippedItemUpdate")
local RequestEquippedItemFunc = InventoryRemotes:WaitForChild("RequestEquippedItem")

-- Brainrot templates moved from the old flat ReplicatedStorage.Items.
-- Normal.<id> layout to a rarity-bucketed ReplicatedStorage.Brainrots.
-- <Rarity>.Normal.<id> layout. The previous WaitForChild("Items") never
-- returned (Items doesn't exist anymore), which blocked module load
-- forever -- so Init() never ran, the EquippedItemUpdate handler never
-- attached, and the lucky block model never appeared on the player. The
-- BrainrotModels proxy mirrors the pattern in BrainrotController so the
-- brainrot type-detection path below keeps working (it returns early
-- without using the template, but the lookup must still succeed).
local BrainrotsFolder = ReplicatedStorage:FindFirstChild("Brainrots")
	or ReplicatedStorage:WaitForChild("Brainrots", 30)
local BrainrotModels = setmetatable({}, {
	__index = function(_, key)
		if key == "FindFirstChild" then
			return function(_, name)
				if not BrainrotsFolder then return nil end
				for _, rarityFolder in ipairs(BrainrotsFolder:GetChildren()) do
					local normal = rarityFolder:FindFirstChild("Normal")
					local hit = normal and normal:FindFirstChild(name)
					if hit then return hit end
				end
				return nil
			end
		end
		return nil
	end,
})

local function findLuckyBlockTemplate(modelName)
	local folder = ReplicatedStorage:FindFirstChild("LuckyBlocks")
	if folder then
		local template = folder:FindFirstChild(modelName)
		if template then return template end
	end
	-- Store loot item models live under ReplicatedStorage.LuckyBlockLoot.<Tier>
	local lootRoot = ReplicatedStorage:FindFirstChild("LuckyBlockLoot")
	if lootRoot then
		for _, tierFolder in ipairs(lootRoot:GetChildren()) do
			local template = tierFolder:FindFirstChild(modelName)
			if template then return template end
		end
	end
	return ReplicatedStorage:FindFirstChild(modelName)
end

local player = Players.LocalPlayer

-- "Egg Idle Anim2" carry pose. IMPORTANT: use the +1 Lucky Block group upload
-- (134432300238280) -- the identical clip also exists as 99756604818753 under
-- the Comeback Games group (Get Slim), but THIS experience has no asset
-- permission for that copy and it fails to load with an access error.
local HOLD_ANIMATION_ID = "rbxassetid://134432300238280"
local EQUIPPED_SCALE_BRAINROT = 0.5
-- Held lucky-block size mirrors the island spawn exactly: the spawn
-- (IslandLuckyBlockSpawner.LUCKYBLOCK_SCALE) applies the same 1.45x
-- multiplier on top of the template's authoring scale, so picking up or
-- equipping a block doesn't change its visible footprint.
local LUCKYBLOCK_SPAWN_SCALE = 1.45
-- No yaw: held lucky blocks face the same direction as the player so the
-- rig's authoring front is what the player sees (the previous -90 yaw
-- pointed the block's side at the camera). The forward push is size-aware:
-- the model's local Z half-extent + clearance, so wide-bodied rigs (Dragon,
-- Slime, Heaven) sit IN FRONT of the player instead of clipping into
-- the torso when their bbox depth grows past the static -3.6 distance.
local LUCKYBLOCK_HOLD_BACK_CLEARANCE = 1.0
local LUCKYBLOCK_HOLD_Y = -0.2

local function makeLuckyBlockOffset(model)
	local halfDepth = 1.8
	if model then
		local _, bbSize = model:GetBoundingBox()
		halfDepth = math.max(bbSize.Z * 0.5, 1.8)
	end
	return CFrame.new(0, LUCKYBLOCK_HOLD_Y, -(LUCKYBLOCK_HOLD_BACK_CLEARANCE + halfDepth))
end

-- Universal held offset (loot items + any future non-block item): same
-- size-aware idea as the lucky blocks but with a tighter floor so small
-- objects sit right at the hands instead of floating a body-length ahead.
-- Local Z half-extent + clearance keeps big objects out of the torso while
-- small ones nestle into the grip.
local GENERIC_HOLD_BACK_CLEARANCE = 0.9
local GENERIC_HOLD_Y = -0.2
-- Held loot items are normalized to this max bbox dimension so a 20-stud
-- showcase orb and a 2-stud crystal both read as hand-held props.
local HELD_LOOT_TARGET_MAX_DIM = 3.0

local function makeGenericHeldOffset(model)
	local halfDepth = 1.0
	if model then
		local _, bbSize = model:GetBoundingBox()
		halfDepth = math.max(bbSize.Z * 0.5, 0.6)
	end
	return CFrame.new(0, GENERIC_HOLD_Y, -(GENERIC_HOLD_BACK_CLEARANCE + halfDepth))
end

-- Cache of looped Idle AnimationTracks per held lucky-block model. The
-- templates ship with an AnimationController + child "Idle" Animation;
-- without playing it here the winged blocks (Angel / Heaven / Dragon)
-- freeze with their wings spread instead of flapping while held.
local heldLuckyIdleTracks = setmetatable({}, { __mode = "k" })

-- Plain cube blocks (Pink / Blue / Yellow / Bulky / Spiked / Lava) ship a
-- 2-bone wobble Idle that reads as a stutter when held; the rigged variants
-- (3+ Bones: Angel / Heaven / Dragon wings, Slime / Autumn body wobble,
-- Planet rotation, King crown, Chained / Void chains) have meaningful idle
-- motion. Same threshold the inventory viewport uses.
local function luckyBlockShouldAnimate(model)
	local bones = 0
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("Bone") then
			bones = bones + 1
			if bones >= 3 then return true end
		end
	end
	return false
end

local function ensureHeldLuckyIdleTrack(model)
	local existing = heldLuckyIdleTracks[model]
	if existing then return existing end
	local controller = model:FindFirstChildWhichIsA("AnimationController", true)
	if not controller then return nil end
	local animator = controller:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = controller
	end
	local idle
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("Animation") and d.Name == "Idle" then
			idle = d
			break
		end
	end
	if not idle or idle.AnimationId == "" then return nil end
	local ok, track = pcall(function() return animator:LoadAnimation(idle) end)
	if not ok or not track then return nil end
	track.Looped = true
	heldLuckyIdleTracks[model] = track
	return track
end

local function playHeldLuckyIdle(model)
	local track = ensureHeldLuckyIdleTrack(model)
	if track then track:Play() end
end

local function stopHeldLuckyIdle(model)
	local track = heldLuckyIdleTracks[model]
	if track then track:Stop(0) end
end

local currentEquippedItem = nil
local currentItemType = nil
local currentModel = nil
-- Extra held-model transform composed into the follow loop each frame;
-- LootBlockController drives this during the in-hand open animation.
local openFxOffset = CFrame.identity
local currentAnimTrack = nil
local currentFollowConnection = nil
local cachedPayload = nil
local cachedEquippedSummary = nil
local isEquipping = false
local modelCache = {}

local function stopCurrentVisual()
	if currentAnimTrack then
		currentAnimTrack:Stop(0.15)
		currentAnimTrack = nil
	end

	if currentFollowConnection then
		currentFollowConnection:Disconnect()
		currentFollowConnection = nil
	end

	if currentModel then
		if currentItemType == "LuckyBlock" then
			stopHeldLuckyIdle(currentModel)
		end
		currentModel.Parent = nil
		currentModel = nil
	end

	currentEquippedItem = nil
	currentItemType = nil
	openFxOffset = CFrame.identity
end

local function getModelTemplate(itemId)
	local lbConfig = GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[itemId]
	if lbConfig then
		-- Loot items (store block payouts) get their own scale/offset profile;
		-- blocks (classic + store loot blocks) share "LuckyBlock".
		local kind = lbConfig.IsLootItem and "LootItem" or "LuckyBlock"
		return findLuckyBlockTemplate(lbConfig.ModelName), kind
	end

	if cachedEquippedSummary and cachedEquippedSummary.ItemId == itemId and cachedEquippedSummary.ItemType == "Brainrot" then
		local mutation = cachedEquippedSummary.Mutation
		local modelName = cachedEquippedSummary.ModelName
		if mutation and mutation ~= "" then
			local mutFolder = BrainrotsFolder:FindFirstChild(mutation)
			if mutFolder and modelName then
				local mutTemplate = mutFolder:FindFirstChild(modelName)
				if mutTemplate then return mutTemplate, "Brainrot" end
			end
		end
		local brainrotId = cachedEquippedSummary.BrainrotId
		local brainrotConfig = brainrotId and GameConfig.Items[brainrotId]
		if brainrotConfig then
			local name = modelName or brainrotConfig.ModelName or brainrotId
			return BrainrotModels:FindFirstChild(name), "Brainrot"
		end
	end

	local brainrotConfig = GameConfig.Items[itemId]
	if brainrotConfig then
		return BrainrotModels:FindFirstChild(brainrotConfig.ModelName or itemId), "Brainrot"
	end

	if cachedPayload then
		for _, item in ipairs(cachedPayload.Items or {}) do
			if item.ItemId == itemId and item.ItemType == "Brainrot" and item.BrainrotId then
				local cfg = GameConfig.Items[item.BrainrotId]
				if cfg then
					local mutation = item.Mutation
					if mutation and mutation ~= "" then
						local mutFolder = BrainrotsFolder:FindFirstChild(mutation)
						if mutFolder then
							local mutModelName = item.ModelName
							if mutModelName then
								local mutTemplate = mutFolder:FindFirstChild(mutModelName)
								if mutTemplate then return mutTemplate, "Brainrot" end
							end
						end
					end
					return BrainrotModels:FindFirstChild(cfg.ModelName or item.BrainrotId), "Brainrot"
				end
			end
		end
	end

	return nil, nil
end

local function playHoldAnimation(character)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return nil end

	local animator = humanoid:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	local animation = Instance.new("Animation")
	animation.AnimationId = HOLD_ANIMATION_ID

	-- pcall: a failed LoadAnimation here would otherwise kill equipVisual
	-- mid-run and strand isEquipping=true, silently blocking every later
	-- equip. Warn instead so a permission/load failure is diagnosable.
	local ok, track = pcall(function()
		return animator:LoadAnimation(animation)
	end)
	animation:Destroy()
	if not ok or not track then
		warn("[EquipVisualController] hold animation failed to load: " .. tostring(track))
		return nil
	end
	track.Priority = Enum.AnimationPriority.Action4
	track.Looped = true
	track:Play(0.05)
	track:AdjustWeight(0.85)

	return track
end

local function attachModelToTorso(character, model, itemType)
	-- Anchor to HumanoidRootPart, not UpperTorso. HRP sits roughly half a
	-- stud lower than UpperTorso, which is exactly what makes the held
	-- lucky block line up with how it looks during island carry.
	local anchorPart = character:FindFirstChild("HumanoidRootPart")
	if not anchorPart then return false end
	local torso = anchorPart

	if not model:GetAttribute("_prepared") then
		local buyPrompt = model:FindFirstChild("BuyPrompt", true)
		if buyPrompt then buyPrompt:Destroy() end
		local uiPartEgg = model:FindFirstChild("UIPartEgg", true)
		if uiPartEgg then uiPartEgg:Destroy() end

		local hasHumanoid = false
		for _, d in model:GetDescendants() do
			if d:IsA("Humanoid") then hasHumanoid = true break end
		end
		for _, desc in model:GetDescendants() do
			if desc:IsA("Humanoid") or (hasHumanoid and desc.Name == "HumanoidRootPart") then
				desc:Destroy()
			end
		end

		for _, desc in model:GetDescendants() do
			if desc:IsA("BasePart") then
				desc.LocalTransparencyModifier = 0
			end
		end

		if itemType == "LuckyBlock" then
			-- Match the island spawn scale (1.45x template authoring scale)
			-- so the block looks the same studs-wise whether it's lying on
			-- the island, held in hand, or placed on a pad. The previous
			-- fit-to-4.5-max-dim normalization made big blocks (Dragon,
			-- Slime, Autumn, Heaven*) shrink to ~17-22% of their spawn
			-- size when equipped.
			model:ScaleTo(model:GetScale() * LUCKYBLOCK_SPAWN_SCALE)
		elseif itemType == "LootItem" then
			-- Loot item source models ship at wildly different authored
			-- sizes (2-20 studs) -- normalize so every one reads hand-held.
			local _, bbSize = model:GetBoundingBox()
			local maxDim = math.max(bbSize.X, bbSize.Y, bbSize.Z, 0.01)
			model:ScaleTo(model:GetScale() * (HELD_LOOT_TARGET_MAX_DIM / maxDim))
		else
			model:ScaleTo(model:GetScale() * EQUIPPED_SCALE_BRAINROT)
		end

		for _, desc in model:GetDescendants() do
			if desc:IsA("BasePart") then
				desc.CanCollide = false
				desc.CanQuery = false
				desc.CanTouch = false
				desc.Anchored = true
				desc.Massless = true
				desc.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0)
			end
		end

		local primaryPart = model.PrimaryPart
		if not primaryPart then
			for _, part in model:GetDescendants() do
				if part:IsA("BasePart") then
					model.PrimaryPart = part
					primaryPart = part
					break
				end
			end
		end

		if not primaryPart then return false end

		model:SetAttribute("_prepared", true)
	end

	if not model.PrimaryPart then return false end

	local heldOffset
	if itemType == "LuckyBlock" then
		heldOffset = makeLuckyBlockOffset(model)
	else
		heldOffset = makeGenericHeldOffset(model)
	end

	local function getTargetCF()
		-- openFxOffset = shake/lift driven by LootBlockController's in-hand
		-- open sequence; identity when idle.
		return torso.CFrame * heldOffset * openFxOffset
	end

	model:PivotTo(getTargetCF())
	model.Parent = workspace

	local connection
	connection = RunService.RenderStepped:Connect(function()
		if not model or not model.Parent then
			connection:Disconnect()
			return
		end
		if not torso or not torso.Parent then
			connection:Disconnect()
			model.Parent = nil
			return
		end
		model:PivotTo(getTargetCF())
	end)

	model.Destroying:Connect(function()
		if connection then
			connection:Disconnect()
		end
	end)

	return true, connection
end

local function equipVisual(itemId)
	if currentEquippedItem == itemId then return end
	if isEquipping then return end

	isEquipping = true
	stopCurrentVisual()

	if not itemId or itemId == "" then
		isEquipping = false
		return
	end

	local character = player.Character
	if not character then
		isEquipping = false
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then
		isEquipping = false
		return
	end

	local template, itemType = getModelTemplate(itemId)
	if not template then
		isEquipping = false
		return
	end

	if itemType == "Brainrot" then
		isEquipping = false
		return
	end

	local model = modelCache[itemId]
	if not model then
		model = template:Clone()
		model.Name = "EquippedVisual"
		modelCache[itemId] = model
	end

	local success, followConn = attachModelToTorso(character, model, itemType)
	if not success then
		modelCache[itemId] = nil
		model:Destroy()
		isEquipping = false
		return
	end

	currentModel = model
	currentEquippedItem = itemId
	currentItemType = itemType
	currentFollowConnection = followConn
	currentAnimTrack = playHoldAnimation(character)
	-- Models are cached across equips; make sure one hidden mid-open-sequence
	-- (SetHeldHidden) never comes back invisible.
	EquipVisualController.SetHeldHidden(false)

	-- Lucky blocks: overhead on the block itself (rarity + Luck), mirroring the
	-- island-spawn/placed-pad look so the player can see what they're holding
	-- without that info living on the avatar's nameplate.
	if itemType == "LuckyBlock" then
		attachHeldLuckyOverhead(model, itemId)
		-- Idle only for rigged variants (winged / leafy / chained / planet /
		-- king). Cube blocks stay static -- their 2-bone wobble looked like
		-- a stutter when held a stud in front of the player.
		if luckyBlockShouldAnimate(model) then
			playHeldLuckyIdle(model)
		end
	elseif itemType == "LootItem" then
		-- Same overhead treatment as blocks: name + rarity + value floating
		-- just above the object's top face (never clipping into it).
		attachHeldLuckyOverhead(model, itemId)
	end

	isEquipping = false
end

local function onEquippedItemUpdate(summary)
	cachedEquippedSummary = summary
	local equippedItem = summary and summary.ItemId or ""
	if equippedItem == "" then
		stopCurrentVisual()
	else
		equipVisual(equippedItem)
	end
end

local function onInventoryUpdate(payload)
	if not payload then return end
	cachedPayload = payload

	local equippedItem = payload.EquippedItem or ""
	if equippedItem ~= "" then
		for _, item in ipairs(payload.Items or {}) do
			if item.ItemId == equippedItem then
				cachedEquippedSummary = {
					ItemId = item.ItemId,
					ItemType = item.ItemType,
					BrainrotId = item.BrainrotId,
					Mutation = item.Mutation,
					ModelName = item.ModelName,
				}
				break
			end
		end
	else
		cachedEquippedSummary = {
			ItemId = "",
			ItemType = "",
		}
	end

	if equippedItem == "" then
		stopCurrentVisual()
	else
		equipVisual(equippedItem)
	end
end

local function onCharacterAdded(character)
	local prevItemId = currentEquippedItem
	stopCurrentVisual()

	-- Single-hold rule: equipping a Tool (the axe) means the player can't
	-- also be holding a lucky block. Without this the model lingers on the
	-- torso for the round-trip it takes the server's EquippedItemUpdate to
	-- land (fired by unequipBrainrot in TreeAreaController), so the player
	-- visibly holds both the axe and the lucky block for a few frames.
	character.ChildAdded:Connect(function(child)
		if child:IsA("Tool") then
			stopCurrentVisual()
		end
	end)

	local humanoid = character:WaitForChild("Humanoid", 10)
	if not humanoid then return end

	if not character:FindFirstChild("UpperTorso") then
		if not character:FindFirstChild("Torso") then
			character:WaitForChild("UpperTorso", 10)
		end
	end

	if prevItemId and prevItemId ~= "" then
		task.defer(function()
			equipVisual(prevItemId)
		end)
	end
end

-- ---------------------------------------------------------------------
-- Hooks for LootBlockController's in-hand open sequence
-- ---------------------------------------------------------------------

function EquipVisualController.GetHeldModel()
	return currentModel
end

function EquipVisualController.GetHeldItemId()
	return currentEquippedItem
end

-- Extra transform composed onto the held model every frame (shake / lift
-- during the open animation). Pass nil to reset.
function EquipVisualController.SetOpenFxOffset(cf)
	openFxOffset = cf or CFrame.identity
end

-- Temporarily rebalance the looping Carry pose so the one-shot Swing (same
-- Action4 priority) reads clearly while it plays. Pass nil to restore the
-- default 0.85.
function EquipVisualController.SetHoldAnimWeight(weight)
	if currentAnimTrack then
		currentAnimTrack:AdjustWeight(weight or 0.85, 0.1)
	end
end

-- Hide/show the held model without unequipping (used at the burst moment of
-- the open sequence). LocalTransparencyModifier keeps the server state and
-- the follow connection intact. Particle emitters remember their authored
-- Enabled state via an attribute so show never force-enables one that ships
-- disabled.
function EquipVisualController.SetHeldHidden(hidden)
	local model = currentModel
	if not model then return end
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BasePart") then
			d.LocalTransparencyModifier = hidden and 1 or 0
		elseif d:IsA("BillboardGui") then
			d.Enabled = not hidden
		elseif d:IsA("ParticleEmitter") then
			if hidden then
				if d:GetAttribute("_openFxWasEnabled") == nil then
					d:SetAttribute("_openFxWasEnabled", d.Enabled)
				end
				d.Enabled = false
			else
				local was = d:GetAttribute("_openFxWasEnabled")
				if was ~= nil then
					d.Enabled = was
					d:SetAttribute("_openFxWasEnabled", nil)
				end
			end
		end
	end
end

function EquipVisualController.Init()
	InventoryUpdateEvent.OnClientEvent:Connect(onInventoryUpdate)
	EquippedItemUpdateEvent.OnClientEvent:Connect(onEquippedItemUpdate)

	task.defer(function()
		local ok, summary = pcall(function()
			return RequestEquippedItemFunc:InvokeServer()
		end)
		if ok and summary then
			onEquippedItemUpdate(summary)
		end
	end)

	player.CharacterAdded:Connect(onCharacterAdded)

	if player.Character then
		task.defer(function()
			onCharacterAdded(player.Character)
		end)
	end
end

return EquipVisualController