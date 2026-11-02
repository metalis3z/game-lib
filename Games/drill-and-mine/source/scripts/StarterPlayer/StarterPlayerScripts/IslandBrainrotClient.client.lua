local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")

local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))
-- Lucky-block pickup celebration: reuse the rebirth firework module + sound
-- (FireworkModule.PlayAtPlayer + GameConfig.Rebirth.Sound) so a lucky block
-- landing in inventory feels as satisfying as a rebirth.
local FireworkModule = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Modules"):WaitForChild("FireworkModule"))
local ViewportOutline = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Modules"):WaitForChild("ViewportOutline"))
local ISLANDS_FOLDER = workspace:WaitForChild("Assets"):WaitForChild("Islands")

local animLookup = {}
for name, data in pairs(GameConfig.Items) do
	if data.animationId and data.animationId ~= "" then
		animLookup[name] = data.animationId
	end
end

-- Populate the embedded Idle Animation on each brainrot template once, at init.
-- The template's child Animation is cloned with each spawn, so we never have to
-- Instance.new("Animation") + set AnimationId + :Destroy() in the per-spawn path.
-- New brainrot pack: ReplicatedStorage.Brainrots.<Rarity>.Normal.<modelName>.
-- Flatten the Normal-mutation models across every rarity into one virtual list
-- so the rest of this file (which assumed a flat ReplicatedStorage.Items.Normal)
-- keeps working unchanged.
local BRAINROTS_FOLDER = ReplicatedStorage:WaitForChild("Brainrots")
local function collectNormalBrainrotTemplates()
	local list = {}
	for _, rarityFolder in ipairs(BRAINROTS_FOLDER:GetChildren()) do
		local normal = rarityFolder:FindFirstChild("Normal")
		if normal then
			for _, model in ipairs(normal:GetChildren()) do
				if model:IsA("Model") then
					table.insert(list, model)
				end
			end
		end
	end
	return list
end
local NORMAL_TEMPLATES = collectNormalBrainrotTemplates()
for _, brainrotModel in ipairs(NORMAL_TEMPLATES) do
	local animId = animLookup[brainrotModel.Name]
	if not animId then continue end
	local controller = brainrotModel:FindFirstChildWhichIsA("AnimationController", true)
		or brainrotModel:FindFirstChildWhichIsA("Humanoid", true)
	if not controller then continue end
	local idle = controller:FindFirstChild("Idle")
	if idle and idle:IsA("Animation") and idle.AnimationId == "" then
		idle.AnimationId = animId
	end
end

-- Pre-fetch every brainrot animation asset off the hot path so the first spawn of
-- each type doesn't pay an asset-load yield on LoadAnimation.
task.spawn(function()
	-- Skip in Studio: mass preload of this template's (largely inaccessible)
	-- assets jams ContentProvider and delays the join load.
	if game:GetService("RunService"):IsStudio() then return end
	local toPreload = {}
	for _, animId in pairs(animLookup) do
		local a = Instance.new("Animation")
		a.AnimationId = animId
		table.insert(toPreload, a)
	end
	if #toPreload > 0 then
		pcall(function() ContentProvider:PreloadAsync(toPreload) end)
	end
	for _, a in ipairs(toPreload) do a:Destroy() end
end)

-- Pre-fetch every brainrot template's meshes/textures off the hot path. Otherwise
-- the first spawn of each brainrot type stalls the render thread for one to several
-- frames while the client loads ~15-30 MeshParts on the spawn frame.
task.spawn(function()
	local templates = {}
	for _, brainrotModel in ipairs(NORMAL_TEMPLATES) do
		table.insert(templates, brainrotModel)
	end
	if #templates > 0 then
		pcall(function() ContentProvider:PreloadAsync(templates) end)
	end
end)

-- Per-model idle AnimationTrack, populated lazily on first acquire. Pooled
-- instances at the park have their tracks Stopped so the Animator pump doesn't
-- spend CPU on 50 invisible idle animations (was a measurable background drag).
local idleTrackByModel = setmetatable({}, { __mode = "k" })

local function ensureIdleTrack(model)
	local existing = idleTrackByModel[model]
	if existing then
		return existing
	end
	local animController = model:FindFirstChildWhichIsA("Humanoid", true)
		or model:FindFirstChildWhichIsA("AnimationController", true)
	if not animController then return nil end

	-- Idle Animation in the current brainrot pack is a sibling of the
	-- AnimationController (parented to the model root), not nested inside
	-- it. The old controller:FindFirstChild("Idle") returned nil for every
	-- rig in the new pack, leaving viewport / island brainrots frozen.
	local idleAnim
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("Animation") and d.Name == "Idle" then
			idleAnim = d
			break
		end
	end
	if not idleAnim or idleAnim.AnimationId == "" then
		return nil
	end

	local animator = animController:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = animController
	end

	local track = animator:LoadAnimation(idleAnim)
	track.Looped = true
	idleTrackByModel[model] = track
	return track
end

local function playAnimation(model)
	local track = ensureIdleTrack(model)
	if track then
		track:Play()
	end
end

local function stopAnimation(model)
	local track = idleTrackByModel[model]
	if track then
		track:Stop(0)
	end
end

-- (Idle animations are started in spawnAt via playAnimation(clone) and stopped in
-- poolRelease via stopAnimation(model). The old ChildAdded auto-play hook was
-- removed because it would fire for every pool member parented at init — 50
-- Animators all running idle tracks at the park position. Lazy start on acquire
-- means only the brainrots actually visible on islands consume Animator CPU.)

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

-- Spawn/despawn animation strategy:
--   Originally we tweened `primary.CFrame` to do a rise/settle pop. The problem:
--   the templates are Motor6D rigs, and Motor6D children only catch up to a moved
--   anchored root over the next physics step — so for one or two frames the body
--   was visibly "stretched" between the old and new positions, and with several
--   slots tweening simultaneously the ghost limbs from different brainrots looked
--   like they were spawning inside each other.
--   Current strategy: instant placement, no movement. A short Highlight flash on
--   both spawn and despawn provides the visual cue. Cost is one Instance.new +
--   one TweenService tween (on the Highlight's single transparency property),
--   independent of part count.
local HIGHLIGHT_FLASH_DURATION = 0.3

-- Forward-declared because despawnAndPool (below) is defined alongside the spawn
-- animation helpers near the top of the file, while the pool implementation lives
-- next to spawnAt further down (where the cloning logic it replaces used to be).
-- Lua resolves upvalues at call time, but only if the local was declared before
-- the calling closure — hence this forward declaration.
local poolRelease

local function flashSpawn(model)
	if not model or not model.Parent then return end
	local h = Instance.new("Highlight")
	h.FillColor = Color3.new(1, 1, 1)
	h.FillTransparency = 0.4
	h.OutlineTransparency = 1
	h.Parent = model
	local tween = TweenService:Create(
		h,
		TweenInfo.new(HIGHLIGHT_FLASH_DURATION, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
		{ FillTransparency = 1 }
	)
	tween:Play()
	tween.Completed:Once(function()
		h:Destroy()
	end)
end

local function despawnAndPool(model)
	if not model or not model.Parent then
		return
	end
	local primary = model.PrimaryPart
	if primary then
		for _, child in ipairs(primary:GetChildren()) do
			if child:IsA("Attachment") then
				local prompt = child:FindFirstChildOfClass("ProximityPrompt")
				if prompt then
					prompt.Enabled = false
				end
			end
		end
	end
	flashSpawn(model)
	task.delay(HIGHLIGHT_FLASH_DURATION, function()
		poolRelease(model)
	end)
end

local MAIN_ISLAND = workspace:WaitForChild("Assets"):WaitForChild("Map"):WaitForChild("MainIsland")

local function flashIslandPart(part)
	if not part or not part:IsA("BasePart") then
		return
	end
	local originalColor = part.Color
	local upInfo = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local downInfo = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local up = TweenService:Create(part, upInfo, { Color = Color3.new(1, 1, 1) })
	up:Play()
	up.Completed:Once(function()
		TweenService:Create(part, downInfo, { Color = originalColor }):Play()
	end)
end

local function flashMainIsland()
	flashIslandPart(MAIN_ISLAND)
end

local function playUpgradeSound()
	-- Named playUpgradeSound for historical reasons, but this fires on
	-- brainrot CLAIM, not on cash-upgrade. Wire it to the dedicated
	-- ClaimBrainrotSound so the long-music UpgradeSound never plays here.
	local sounds = SoundService:FindFirstChild("Sounds")
	local source = sounds and (sounds:FindFirstChild("ClaimBrainrotSound") or sounds:FindFirstChild("UpgradeSound"))
	if not source then
		return
	end
	local one = source:Clone()
	one.Parent = SoundService
	one:Play()
	one.Ended:Once(function()
		one:Destroy()
	end)
	task.delay(5, function()
		if one.Parent then
			one:Destroy()
		end
	end)
end

-- Mirror of RebirthController.playRebirthSound so a lucky-block deposit gets
-- the same audio cue as a rebirth. Cloned per shot via Instance.new so a
-- batch of consecutive deposits layers without cutting itself off.
local REBIRTH_SOUND_ID = (GameConfig.Rebirth and GameConfig.Rebirth.Sound) or "rbxassetid://137771197859895"
local function playRebirthSound()
	local sound = Instance.new("Sound")
	sound.SoundId = REBIRTH_SOUND_ID
	sound.Parent = SoundService
	sound:Play()
	sound.Ended:Once(function()
		sound:Destroy()
	end)
	task.delay(8, function()
		if sound and sound.Parent then
			sound:Destroy()
		end
	end)
end

-- Generic SFX trigger by SoundService.Sounds.<name>. Cloned per shot so calls
-- don't cancel each other (UpgradeSound already does this). Volume optional.
local function playSfx(soundName, volume)
	local sounds = SoundService:FindFirstChild("Sounds")
	local source = sounds and sounds:FindFirstChild(soundName)
	if not source then return end
	local one = source:Clone()
	if volume then one.Volume = volume end
	one.Parent = SoundService
	one:Play()
	one.Ended:Once(function() one:Destroy() end)
	task.delay(5, function() if one.Parent then one:Destroy() end end)
end

-- Single-hold rule: the player can hold the axe, OR a brainrot, OR a lucky
-- block — never two at once. `unequipHeldAxe` puts away whichever Roblox Tool
-- (the axe is always a Tool) is currently in the character. Called whenever
-- the player is about to start carrying or equip an inventory item.
local function unequipHeldAxe()
	local character = player.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid:UnequipTools()
	end
end

local NotificationsController = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Controllers"):WaitForChild("NotificationsController"))

local function showGreenNotification(text)
	NotificationsController.SendGreen(text)
end

local function showRedNotification(text)
	NotificationsController.SendRed(text)
end

local islandRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("IslandBrainrot")
local collectedBrainrotEvent = islandRemotes:WaitForChild("CollectedBrainrot")
local startCarryEvent = islandRemotes:WaitForChild("StartCarry")
local cancelCarryEvent = islandRemotes:WaitForChild("CancelCarry")
local requestCarryEvent = islandRemotes:WaitForChild("RequestCarry")

local dataRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PlayerDataService")
local RequestDataFunc = dataRemotes:WaitForChild("RequestData")
local DataUpdateEvent = dataRemotes:WaitForChild("DataUpdate")

local inventoryRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("InventoryService")
local ToggleEquipFunc = inventoryRemotes:WaitForChild("ToggleEquip")
local EquippedItemUpdateEvent = inventoryRemotes:WaitForChild("EquippedItemUpdate")

local LUCKY_BLOCK_TEMPLATES = ReplicatedStorage:WaitForChild("LuckyBlocks")
local localEquippedLuckyBlockId = nil
local luckyBlockSlots = {} -- [luckyBlockId] = holder GuiObject

local inventoryUniqueIdsByStackKey = {}
local stackKeyToBrainrotId = {}
local stackKeyToLevel = {}
local uniqueIdToMutation = {}
local localEquippedUniqueId = nil
local localEquippedCashPerSec = nil
local refreshPodiumPromptsState

local function makeStackKey(brainrotId, level, mutation)
	return tostring(brainrotId) .. "|" .. tostring(level or 1) .. "|" .. tostring(mutation or "")
end

local stackKeyToMutation = {}

local function rebuildInventoryMap(brainrotInventory)
	inventoryUniqueIdsByStackKey = {}
	stackKeyToBrainrotId = {}
	stackKeyToLevel = {}
	stackKeyToMutation = {}
	uniqueIdToMutation = {}
	local entries = {}
	for uid, entry in pairs(brainrotInventory or {}) do
		uniqueIdToMutation[uid] = entry.Mutation
		table.insert(entries, {
			uid = uid,
			BrainrotId = entry.BrainrotId,
			Level = entry.Level or 1,
			Mutation = entry.Mutation,
			Timestamp = entry.Timestamp or 0,
		})
	end
	table.sort(entries, function(a, b)
		return (a.Timestamp or 0) < (b.Timestamp or 0)
	end)
	for _, e in ipairs(entries) do
		if e.BrainrotId then
			local key = makeStackKey(e.BrainrotId, e.Level, e.Mutation)
			local list = inventoryUniqueIdsByStackKey[key]
			if not list then
				list = {}
				inventoryUniqueIdsByStackKey[key] = list
				stackKeyToBrainrotId[key] = e.BrainrotId
				stackKeyToLevel[key] = e.Level
				stackKeyToMutation[key] = e.Mutation
			end
			table.insert(list, e.uid)
		end
	end
end

local BrainrotController = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Controllers"):WaitForChild("BrainrotController"))
local HoldingAnimationController = require(ReplicatedStorage.Source.Controllers:WaitForChild("HoldingAnimationController"))

-- Held lucky-block visual (for inventory-equipped lucky blocks in the safe
-- zone). The island-pickup path already spawns a visible block via
-- BrainrotController.AddCarryStack; this is the equivalent for the equipped-
-- from-hotbar path, which previously only played the carry pose with no
-- visible block / overhead. Mirrors buildStackedHeldModel(isLuckyBlock=true).
local LUCKYBLOCKS_FOLDER = ReplicatedStorage:WaitForChild("LuckyBlocks")
-- Held lucky block size. Was 1.8 (too small, user couldn't see it); bumped
-- to 3.0 so the block reads clearly in the player's hand while still being
-- noticeably smaller than the 5-stud placed-pad block (so the two never
-- look like "two of the same block" when the player stands at their plot).
local HELD_LUCKY_TARGET_MAX_DIM = 3.0
local HELD_LUCKY_HOLD_OFFSET = CFrame.new(0, -0.2, -3.0) * CFrame.Angles(0, math.rad(-90), 0)
-- Studs above the block's TOP face (not the handle center) for the overhead.
-- The block is 3.0 stud so top is at handle + 1.5; this lifts the label 1.0
-- studs above that, totaling +2.5 on the attachment.
local HELD_LUCKY_OVERHEAD_Y_EXTRA = 1.0
local HELD_RARITY_GRADIENT_FOLDER = ReplicatedStorage:WaitForChild("Gradients"):WaitForChild("Rarity")
local heldLuckyVisual = nil
local heldLuckyCharRemovingConn = nil

local function setHeldLabel(label, text)
    if not label then return end
    label.Text = text
    local inner = label:FindFirstChild("Inner")
    if inner then inner.Text = text end
end

-- Match the brainrot held billboard's downscale so the lucky overhead reads
-- at a similar size to the brainrot's. Without this the podium-template-sized
-- 10x7 board floats huge above a small held block.
local HELD_LB_BILLBOARD_SCALE = 0.6

local function buildHeldLuckyBlockBillboard(luckyBlockId)
    local bbTemplate = player:WaitForChild("PlayerGui"):WaitForChild("PodiumBillboard", 5)
    if not bbTemplate then return nil end
    local cfg = GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[luckyBlockId]
    local billboard = bbTemplate:Clone()
    billboard:SetAttribute("HeldLuckyBlockBillboard", true)
    billboard.Size = UDim2.new(
        billboard.Size.X.Scale * HELD_LB_BILLBOARD_SCALE,
        billboard.Size.X.Offset * HELD_LB_BILLBOARD_SCALE,
        billboard.Size.Y.Scale * HELD_LB_BILLBOARD_SCALE,
        billboard.Size.Y.Offset * HELD_LB_BILLBOARD_SCALE
    )
    setHeldLabel(billboard:FindFirstChild("Name"), (cfg and cfg.DisplayName) or luckyBlockId)
    setHeldLabel(billboard:FindFirstChild("Income"), string.format("x%.2f Luck", tonumber(cfg and cfg.Luck) or 1))
    local typeLabel = billboard:FindFirstChild("Type")
    if typeLabel then typeLabel.Visible = false end
    local timerFrame = billboard:FindFirstChild("TimerFrame")
    if timerFrame then timerFrame.Visible = false end
    local rarity = cfg and cfg.Rarity
    local rarityLabel = billboard:FindFirstChild("Rarity")
    if rarityLabel and rarity then
        rarityLabel.Text = rarity
        local rarityInner = rarityLabel:FindFirstChild("Rarity")
        local host = rarityInner or rarityLabel
        if rarityInner then rarityInner.Text = rarity end
        for _, ch in ipairs(host:GetChildren()) do
            if ch:IsA("UIGradient") then ch:Destroy() end
        end
        local grad = HELD_RARITY_GRADIENT_FOLDER:FindFirstChild(rarity)
        if grad then grad:Clone().Parent = host end
    end
    return billboard
end

-- Startup sweep: an older revision of this controller also spawned a held
-- lucky block (HeldLuckyBlock model) in addition to EquipVisualController's
-- own model (EquippedVisual). That left orphans across Studio script reloads.
-- EquipVisualController is now the single source of truth for the held lucky
-- block visual; clean any stale HeldLuckyBlock so the duplicate doesn't
-- linger from a previous session.
for _, c in ipairs(workspace:GetChildren()) do
    if c:IsA("Model") and c.Name == "HeldLuckyBlock" then
        c:Destroy()
    end
end

-- spawnHeldLuckyBlockVisual / destroyHeldLuckyBlockVisual are now no-ops.
-- EquipVisualController already creates the held lucky block model from
-- EquippedItemUpdate; running our own model in parallel produced the
-- two-blocks-stacked bug. The call sites below stay intact (they're cheap
-- and any future re-introduction has a clear hook).
local function destroyHeldLuckyBlockVisual()
end

local function spawnHeldLuckyBlockVisual(_luckyBlockId)
    -- No-op: EquipVisualController owns the held lucky block model. See the
    -- destroyHeldLuckyBlockVisual comment above.
end

-- Multi-carry: count of brainrots currently held from island pickups.
-- Gate is `localCarryCount >= getMaxCarry()`. MaxCarry is pushed as a player
-- attribute by UpgradeShopService and updates whenever the player buys a
-- Carry upgrade.
local localCarryCount = 0

local function getMaxCarry()
	local v = player:GetAttribute("MaxCarry")
	if type(v) == "number" and v >= 1 then
		return math.floor(v)
	end
	return 1
end

startCarryEvent.OnClientEvent:Connect(function(brainrotId, mutationId, isLuckyBlock)
	localCarryCount = localCarryCount + 1
	unequipHeldAxe()
	-- Hide any inventory-equipped held lucky visual while the island-pickup
	-- stack is active so the player doesn't see two stacked lucky blocks.
	destroyHeldLuckyBlockVisual()
	BrainrotController.AddCarryStack(brainrotId, mutationId, isLuckyBlock)
	HoldingAnimationController.StartCarry()
	playSfx("PopUpSound", 0.6)
end)

cancelCarryEvent.OnClientEvent:Connect(function()
	localCarryCount = 0
	BrainrotController.ClearCarryStack()
	destroyHeldLuckyBlockVisual()
	HoldingAnimationController.StopCarry()
end)

local playerGui = player:WaitForChild("PlayerGui")
local guiRoot = playerGui:WaitForChild("GUI")
local inventoryBottom = guiRoot:WaitForChild("Folder"):WaitForChild("InventoryBottom")
local holderTemplate = inventoryBottom:WaitForChild("Holder")
holderTemplate.Visible = false

local inventoryFrame = guiRoot.Folder:WaitForChild("InventoryFrame")
local frameScroll = inventoryFrame:WaitForChild("Frame"):WaitForChild("Frame"):WaitForChild("ScrollingFrame")
local frameHolderTemplate = frameScroll:WaitForChild("Holder")
frameHolderTemplate.Visible = false
inventoryFrame.Visible = false

-- Smooth open/close for the G-menu inventory. Same Back-out grow / Quad-in
-- shrink feel as FrameAnimator's shop frames, but standalone on purpose:
-- routing this frame through FrameAnimator would blur the world and slide
-- the hotbar offscreen (tweenBottomUi), and the hotbar must stay up so
-- slots can be dragged between it and this frame.
local inventoryOpenScale = Instance.new("UIScale")
inventoryOpenScale.Name = "OpenScale"
inventoryOpenScale.Parent = inventoryFrame

local inventoryFrameOpen = false
local inventoryAnimId = 0
local function setInventoryFrameOpen(open)
	inventoryFrameOpen = open
	inventoryAnimId += 1
	local id = inventoryAnimId
	if open then
		if not inventoryFrame.Visible then
			inventoryOpenScale.Scale = 0
		end
		inventoryFrame.Visible = true
		TweenService:Create(inventoryOpenScale, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Scale = 1,
		}):Play()
	else
		local tween = TweenService:Create(inventoryOpenScale, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Scale = 0,
		})
		tween.Completed:Once(function()
			-- ignore if a reopen started while this close was playing
			if id == inventoryAnimId then
				inventoryFrame.Visible = false
				inventoryOpenScale.Scale = 1
			end
		end)
		tween:Play()
	end
end

for _, child in ipairs(inventoryBottom:GetChildren()) do
	if child:IsA("GuiObject") and child ~= holderTemplate then
		child:Destroy()
	end
end
for _, child in ipairs(frameScroll:GetChildren()) do
	if child:IsA("GuiObject") and child ~= frameHolderTemplate then
		child:Destroy()
	end
end

for _, template in ipairs({ holderTemplate, frameHolderTemplate }) do
	local amt = template:FindFirstChild("Amount")
	if amt then
		amt.Visible = false
	end
end

local addBrainrotToInventory
-- Forward-declared so addBrainrotToInventory's body (defined below)
-- captures these as upvalues even though their `function` definitions sit
-- further down in the script. `local function name()` *introduces a new
-- local in the inner scope*, so without these forward declarations the
-- closure resolved them as globals (= nil), throwing "attempt to call a
-- nil value" the moment a placed brainrot was removed and the resulting
-- BrainrotInventory update tried to spawn a slot for it.
local getCleanedBrainrotTemplate
local buildSlotViewport

if not frameScroll:FindFirstChildOfClass("UIGridLayout") then
	local restoredLayout = Instance.new("UIGridLayout")
	restoredLayout.CellSize = UDim2.new(0.11, 0, 0.3, 0)
	restoredLayout.CellPadding = UDim2.new(0.015, 0, 0.03, 0)
	restoredLayout.SortOrder = Enum.SortOrder.LayoutOrder
	restoredLayout.Parent = frameScroll
end

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local MAX_SLOTS = 8
local BACKPACK_SLOT_INDEX = 9
local BACKPACK_ICON = "rbxassetid://121077876739653"

local selectedSlot = nil
local slots = {}

-- Slot 1 belongs to the permanent drill slot (the axe system that used to
-- reserve it is gone), so key "1" toggles the drill exactly like clicking it.
local KEY_TO_SLOT = {
	[Enum.KeyCode.One] = 1,
	[Enum.KeyCode.Two] = 2,
	[Enum.KeyCode.Three] = 3,
	[Enum.KeyCode.Four] = 4,
	[Enum.KeyCode.Five] = 5,
	[Enum.KeyCode.Six] = 6,
	[Enum.KeyCode.Seven] = 7,
	[Enum.KeyCode.Eight] = 8,
	[Enum.KeyCode.Nine] = 9,
}

-- Drill hotbar slot talks to DrillSystemServer through its RemoteEvent.
-- Resolved WITHOUT a blocking wait: a top-level WaitForChild here once
-- froze this entire script (no hotbar, no islands) while the server-side
-- drill setup was stalled. Background-resolved in the drill-slot section.
local drillEvent = ReplicatedStorage:FindFirstChild("DrillEvent")

local EQUIPPED_COLOR = Color3.fromRGB(255, 255, 255)

local originalStrokeColors = setmetatable({}, { __mode = "k" })

local function setSlotHighlight(slot, equipped)
	for _, child in ipairs(slot:GetChildren()) do
		if child:IsA("UIStroke") then
			if originalStrokeColors[child] == nil then
				originalStrokeColors[child] = child.Color
			end
			child.Color = equipped and EQUIPPED_COLOR or originalStrokeColors[child]
		end
	end
	-- grown slot draws over its neighbors instead of under them
	slot.ZIndex = equipped and 2 or 1
	-- Equip pop: same EquipScale recipe as the loot slots
	-- (RarityLootClient.refreshSlotHighlight) so every hotbar slot animates alike.
	-- Only the FIRST UIScale child of a GuiObject takes effect, so the
	-- HoverScale that HoverController auto-adds to every ImageButton was
	-- dead-switching this pop (it landed before the lazily-created EquipScale).
	-- Slot templates carry NoHover now; purge any stray copy just in case.
	local hoverScale = slot:FindFirstChild("HoverScale")
	if hoverScale then hoverScale:Destroy() end
	local scale = slot:FindFirstChild("EquipScale")
	if not scale then
		scale = Instance.new("UIScale")
		scale.Name = "EquipScale"
		scale.Parent = slot
	end
	-- equip: springy grow; unequip: clean soft shrink (Back easing on the way
	-- down reads as a jerk, so the two directions get their own curves).
	-- 1.25 -- reads clearly without swallowing the row. The hotbar list is
	-- VerticalAlignment=Bottom, so the grown slot pops UP off the row instead
	-- of poking below the screen edge (it did at Center alignment).
	local info = equipped
		and TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		or TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(scale, info, {
		Scale = equipped and 1.25 or 1,
	}):Play()
end

local function updateAmountLabel(holder)
	local amount = holder:FindFirstChild("Amount")
	if not amount then
		return
	end
	local count = holder:GetAttribute("Count") or 1
	local level = holder:GetAttribute("Level") or 1
	local text
	if level > 1 and count > 1 then
		text = string.format("Lv%d x%d", level, count)
	elseif level > 1 then
		text = string.format("Lv%d", level)
	elseif count > 1 then
		text = "x" .. count
	end
	if text then
		amount.Text = text
		amount.Visible = true
	else
		amount.Visible = false
	end
end

local function normalizeMutation(m)
	if m == nil or m == "" then return nil end
	return m
end

-- Mirror of server-side `getCashPerSec` (InventoryService / PodiumService) so the
-- held billboard renders the upgraded income on the same frame the user clicks an
-- equip slot, instead of flashing a Level-1 number before the server's
-- EquippedItemUpdate roundtrip lands. Percent brainrots aren't computable client-
-- side (they need bestNonPercentCps) — those fall through to BrainrotController's
-- cache, which catches the value as soon as EquippedItemUpdate fires.
local CPS_BONUS_PERCENT = 0.5
local function computeLeveledBaseCps(brainrotId, mutation, level)
	local cfg = GameConfig.Items[brainrotId]
	if not cfg or cfg.IsPercentBrainrot then return nil end
	local base = cfg.CashPerSec or 0
	if mutation and mutation ~= "" then
		local mutCfg = GameConfig.Mutations[mutation]
		if mutCfg and mutCfg.CashBoost then
			base = base * mutCfg.CashBoost
		end
	end
	level = level or 1
	if level > 1 then
		base = base + base * CPS_BONUS_PERCENT * (level - 1)
	end
	return base
end

local function holderMatches(holder, brainrotId, level, mutation)
	if holder:GetAttribute("BrainrotId") ~= brainrotId then
		return false
	end
	if (holder:GetAttribute("Level") or 1) ~= (level or 1) then
		return false
	end
	local holderMut = normalizeMutation(holder:GetAttribute("Mutation"))
	local wantMut = normalizeMutation(mutation)
	return holderMut == wantMut
end

local function findExistingHolder(brainrotId, level, mutation)
	for i = 1, MAX_SLOTS do
		local s = slots[i]
		if s and not s:GetAttribute("IsBackpack") and holderMatches(s, brainrotId, level, mutation) then
			return s
		end
	end
	for _, child in ipairs(frameScroll:GetChildren()) do
		if child:IsA("GuiObject") and child ~= frameHolderTemplate and holderMatches(child, brainrotId, level, mutation) then
			return child
		end
	end
	return nil
end

local function unequipSlot()
	if not selectedSlot then
		return
	end
	local slotWasLucky = selectedSlot:GetAttribute("LuckyBlockId")
	setSlotHighlight(selectedSlot, false)
	selectedSlot = nil
	if slotWasLucky and slotWasLucky ~= "" then
		local lbId = localEquippedLuckyBlockId
		localEquippedLuckyBlockId = nil
		destroyHeldLuckyBlockVisual()
		HoldingAnimationController.StopCarry()
		if lbId then
			task.spawn(function()
				pcall(function() ToggleEquipFunc:InvokeServer(lbId) end)
			end)
		end
		if refreshPodiumPromptsState then refreshPodiumPromptsState() end
		return
	end
	BrainrotController.StopCarry()
	HoldingAnimationController.StopCarry()

	if localEquippedUniqueId then
		local uid = localEquippedUniqueId
		localEquippedUniqueId = nil
		task.spawn(function()
			pcall(function() ToggleEquipFunc:InvokeServer(uid) end)
		end)
	end
	if refreshPodiumPromptsState then refreshPodiumPromptsState() end
end

local function equipSlot(slot)
	if localCarryCount > 0 then
		return
	end
	if slot:GetAttribute("IsBackpack") then
		return
	end
	if slot:GetAttribute("DrillSlot") then
		-- server-owned held state (DrillSystemServer): the highlight and the
		-- hold pose come back via drillEvent "hold"/"unhold"
		if drillEvent then
			playSfx("ClickSound", 0.5)
			drillEvent:FireServer("toggleHold")
		end
		return
	end
	local luckyBlockId = slot:GetAttribute("LuckyBlockId")
	if luckyBlockId and luckyBlockId ~= "" then
		if selectedSlot then
			setSlotHighlight(selectedSlot, false)
		end
		selectedSlot = slot
		setSlotHighlight(slot, true)
		localEquippedLuckyBlockId = luckyBlockId
		unequipHeldAxe()
		-- Lucky blocks reuse the same carry pose as brainrots so the player
		-- visibly holds them. Mirror call lives in unequipSlot below.
		HoldingAnimationController.StartCarry()
		-- Don't call spawnHeldLuckyBlockVisual here. The server-driven path
		-- (syncSelectionToServerEquipped, fired by EquippedItemUpdate) handles
		-- the spawn. Calling it here too raced with that path and produced two
		-- stacked held lucky blocks when the local + server spawns both ran.
		playSfx("ClickSound", 0.5)
		task.spawn(function()
			pcall(function() ToggleEquipFunc:InvokeServer(luckyBlockId) end)
		end)
		return
	end
	local brainrotId = slot:GetAttribute("BrainrotId")
	if not brainrotId or brainrotId == "" then
		return
	end
	local level = slot:GetAttribute("Level") or 1
	local mutation = normalizeMutation(slot:GetAttribute("Mutation"))
	if selectedSlot then
		setSlotHighlight(selectedSlot, false)
	end
	selectedSlot = slot
	setSlotHighlight(slot, true)
	unequipHeldAxe()
	playSfx("ClickSound", 0.5)

	local list = inventoryUniqueIdsByStackKey[makeStackKey(brainrotId, level, mutation)]
	local targetUid = list and list[1]
	local targetMutation = mutation
	if targetUid and uniqueIdToMutation then
		targetMutation = uniqueIdToMutation[targetUid] or mutation
	end
	BrainrotController.StartCarry(brainrotId, targetMutation, computeLeveledBaseCps(brainrotId, targetMutation, level))
	HoldingAnimationController.StartCarry()

	if targetUid then
		localEquippedUniqueId = targetUid
		-- Single ToggleEquip call. The previous code fired TWO task.spawn'd
		-- calls -- unequip(old) + equip(new) -- which raced over the network:
		-- if the equip(new) packet landed first the server toggled to it, then
		-- the unequip(old) packet flipped state again (since onToggleEquip
		-- truly toggles), so the equipped item ended up as something the
		-- player wasn't holding visually. One call handles all cases cleanly
		-- because onToggleEquip(targetUid) replaces a different equipped item
		-- with targetUid in a single atomic op.
		task.spawn(function()
			pcall(function() ToggleEquipFunc:InvokeServer(targetUid) end)
		end)
	end
	if refreshPodiumPromptsState then refreshPodiumPromptsState() end
end

local function syncSelectionToServerEquipped()
	if localCarryCount > 0 then
		return
	end

	if localEquippedLuckyBlockId and localEquippedLuckyBlockId ~= "" then
		local targetSlot = luckyBlockSlots[localEquippedLuckyBlockId]
		if targetSlot and targetSlot.Parent then
			if selectedSlot ~= targetSlot then
				if selectedSlot then setSlotHighlight(selectedSlot, false) end
				selectedSlot = targetSlot
				setSlotHighlight(targetSlot, true)
			end
			-- Clear any leftover brainrot visual (we just switched to a lucky
			-- block) and play the carry pose so the lucky block is actually
			-- held. This handler is what runs when the server sync confirms a
			-- lucky block as the equipped item, including on respawn / rejoin.
			BrainrotController.StopCarry()
			HoldingAnimationController.StartCarry()
			spawnHeldLuckyBlockVisual(localEquippedLuckyBlockId)
		end
		return
	end

	local equippedUid = localEquippedUniqueId
	if not equippedUid or equippedUid == "" then
		if selectedSlot then
			setSlotHighlight(selectedSlot, false)
			selectedSlot = nil
		end
		-- Always stop carry visuals when the server says nothing is equipped.
		-- Specifically: placing a lucky block on a pad clears EquippedItem and
		-- may also drop the last hotbar slot in the same tick, leaving
		-- selectedSlot already nil; gating StopCarry on selectedSlot in that
		-- case left the hold animation playing forever.
		BrainrotController.StopCarry()
		destroyHeldLuckyBlockVisual()
		HoldingAnimationController.StopCarry()
		return
	end

	local targetBrainrotId
	local targetLevel
	local targetMutation
	for key, uidList in pairs(inventoryUniqueIdsByStackKey) do
		for _, uid in ipairs(uidList) do
			if uid == equippedUid then
				targetBrainrotId = stackKeyToBrainrotId[key]
				targetLevel = stackKeyToLevel[key]
				targetMutation = stackKeyToMutation[key]
				break
			end
		end
		if targetBrainrotId then break end
	end

	if not targetBrainrotId then
		return
	end

	local targetSlot = findExistingHolder(targetBrainrotId, targetLevel, targetMutation)
	if not targetSlot then
		return
	end

	if selectedSlot ~= targetSlot then
		if selectedSlot then
			setSlotHighlight(selectedSlot, false)
		end
		selectedSlot = targetSlot
		setSlotHighlight(targetSlot, true)
	end
	BrainrotController.StartCarry(targetBrainrotId, targetMutation, localEquippedCashPerSec)
	HoldingAnimationController.StartCarry()
end

EquippedItemUpdateEvent.OnClientEvent:Connect(function(summary)
	if summary and summary.ItemType == "Brainrot" and summary.ItemId and summary.ItemId ~= "" then
		localEquippedUniqueId = summary.ItemId
		localEquippedCashPerSec = summary.CashPerSec
		localEquippedLuckyBlockId = nil
	elseif summary and summary.ItemType == "LuckyBlock" and summary.ItemId and summary.ItemId ~= "" then
		localEquippedUniqueId = nil
		localEquippedCashPerSec = nil
		localEquippedLuckyBlockId = summary.ItemId
	else
		localEquippedUniqueId = nil
		localEquippedCashPerSec = nil
		localEquippedLuckyBlockId = nil
	end
	syncSelectionToServerEquipped()
	if refreshPodiumPromptsState then refreshPodiumPromptsState() end
end)

-- Equipping a Tool (the axe) drops the slot highlight + local equipped
-- state immediately. TreeAreaController.unequipBrainrot fires the server
-- toggle in parallel; the EquippedItemUpdate round-trip lands a few frames
-- later and would do the same, but waiting on it makes the previously
-- selected slot stay highlighted (and BrainrotController's held visual
-- linger) so the player visibly holds two items at once.
local function clearLocalEquipStateOnToolEquip(character)
	character.ChildAdded:Connect(function(child)
		if not child:IsA("Tool") then return end
		if selectedSlot then
			setSlotHighlight(selectedSlot, false)
			selectedSlot = nil
		end
		localEquippedUniqueId = nil
		localEquippedCashPerSec = nil
		localEquippedLuckyBlockId = nil
		destroyHeldLuckyBlockVisual()
	end)
end
if player.Character then
	clearLocalEquipStateOnToolEquip(player.Character)
end
player.CharacterAdded:Connect(clearLocalEquipStateOnToolEquip)

local DRAG_THRESHOLD_SQ = 36
local activeDrag = nil
local frameOrderCounter = 0

local function rectsOverlap(a, b)
	if not a.Visible or not b.Visible then
		return false
	end
	local ap = a.AbsolutePosition
	local as = a.AbsoluteSize
	local bp = b.AbsolutePosition
	local bs = b.AbsoluteSize
	return ap.X < bp.X + bs.X
		and ap.X + as.X > bp.X
		and ap.Y < bp.Y + bs.Y
		and ap.Y + as.Y > bp.Y
end

local function findFreeBottomIndex()
	-- Slots[1] is reserved for the permanent drill slot (createDrillSlot pins
	-- itself there). Brainrot and lucky-block slots fill 2..MAX_SLOTS so each
	-- on-screen slot number matches the keyboard key that equips it.
	for i = 2, MAX_SLOTS do
		if not slots[i] then
			return i
		end
	end
	return nil
end

local function detachFromBottom(slot)
	for i = 1, MAX_SLOTS do
		if slots[i] == slot then
			slots[i] = nil
			return i
		end
	end
	return nil
end

local function moveSlotToFrame(slot)
	if selectedSlot == slot then
		unequipSlot()
	end
	detachFromBottom(slot)
	local slotNum = slot:FindFirstChild("SlotNumber")
	if slotNum then
		slotNum.Text = ""
	end
	frameOrderCounter = frameOrderCounter + 1
	slot.LayoutOrder = frameOrderCounter
	slot.Parent = frameScroll
end

local function moveSlotToBottom(slot)
	local idx = findFreeBottomIndex()
	if not idx then
		return false
	end
	slots[idx] = slot
	slot.LayoutOrder = idx
	local slotNum = slot:FindFirstChild("SlotNumber")
	if slotNum then
		slotNum.Text = tostring(idx)
	end
	slot.Parent = inventoryBottom
	return true
end

local function beginDragVisuals(drag)
	local src = drag.slot
	local ghost = src:Clone()
	ghost.Name = "DragGhost"
	ghost.Active = false
	ghost.AutoButtonColor = false
	ghost.AnchorPoint = Vector2.new(0, 0)
	ghost.Size = UDim2.fromOffset(drag.slotSizeX, drag.slotSizeY)
	ghost.Position = UDim2.fromOffset(drag.slotStartX, drag.slotStartY + drag.slotSizeY * 0.85)
	ghost.ZIndex = 100
	for _, desc in ipairs(ghost:GetDescendants()) do
		if desc:IsA("GuiObject") then
			desc.ZIndex = desc.ZIndex + 100
		end
	end
	ghost.Parent = guiRoot
	drag.ghost = ghost
	src.Visible = false
	if selectedSlot == src then
		unequipSlot()
	end
end

local function endDrag()
	local drag = activeDrag
	activeDrag = nil
	if not drag then
		return
	end

	if drag.slot and drag.slot.Parent then
		drag.slot.Visible = true
	end

	if not drag.moved then
		if drag.ghost then
			drag.ghost:Destroy()
		end
		if drag.slot and drag.slot.Parent and not drag.slot:GetAttribute("IsBackpack") then
			if selectedSlot == drag.slot then
				unequipSlot()
			else
				equipSlot(drag.slot)
			end
		end
		return
	end

	local ghost = drag.ghost
	if ghost then
		local overFrame = rectsOverlap(ghost, inventoryFrame)
		local overBottom = rectsOverlap(ghost, inventoryBottom)

		if drag.origin == "bottom" and overFrame then
			moveSlotToFrame(drag.slot)
		elseif drag.origin == "frame" and overBottom then
			moveSlotToBottom(drag.slot)
		end

		ghost:Destroy()
	end
end

local function attachDragAndClick(slot)
	slot.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		if activeDrag then
			return
		end
		activeDrag = {
			slot = slot,
			origin = (slot.Parent == inventoryBottom) and "bottom" or "frame",
			startMouseX = input.Position.X,
			startMouseY = input.Position.Y,
			slotStartX = slot.AbsolutePosition.X,
			slotStartY = slot.AbsolutePosition.Y,
			slotSizeX = slot.AbsoluteSize.X,
			slotSizeY = slot.AbsoluteSize.Y,
			moved = false,
			ghost = nil,
		}
	end)
end

UserInputService.InputChanged:Connect(function(input)
	if not activeDrag then
		return
	end
	if input.UserInputType ~= Enum.UserInputType.MouseMovement
		and input.UserInputType ~= Enum.UserInputType.Touch then
		return
	end
	local dx = input.Position.X - activeDrag.startMouseX
	local dy = input.Position.Y - activeDrag.startMouseY
	if not activeDrag.moved then
		if dx * dx + dy * dy < DRAG_THRESHOLD_SQ then
			return
		end
		activeDrag.moved = true
		beginDragVisuals(activeDrag)
	end
	if activeDrag.ghost then
		activeDrag.ghost.Position = UDim2.fromOffset(
			activeDrag.slotStartX + dx,
			activeDrag.slotStartY + dy + activeDrag.slotSizeY * 0.85
		)
	end
	local now = os.clock()
	local lastTime = activeDrag.velLastTime
	local lastX = activeDrag.velLastX
	if lastTime and lastX then
		local timeDelta = math.max(now - lastTime, 0.005)
		local instVel = (input.Position.X - lastX) / timeDelta
		activeDrag.velocityX = ((activeDrag.velocityX or 0) * 0.15) + (instVel * 0.85)
	end
	activeDrag.velLastTime = now
	activeDrag.velLastX = input.Position.X
end)

RunService.Heartbeat:Connect(function(dt)
	if not activeDrag or not activeDrag.ghost then
		return
	end
	local target = math.clamp((activeDrag.velocityX or 0) * 0.06, -28, 28)
	local current = activeDrag.currentRot or 0
	current = current + (target - current) * math.min(dt * 28, 1)
	activeDrag.currentRot = current
	activeDrag.ghost.Rotation = current
	activeDrag.velocityX = (activeDrag.velocityX or 0) * math.max(1 - dt * 14, 0)
end)

UserInputService.InputEnded:Connect(function(input)
	if not activeDrag then
		return
	end
	if input.UserInputType ~= Enum.UserInputType.MouseButton1
		and input.UserInputType ~= Enum.UserInputType.Touch then
		return
	end
	endDrag()
end)

local function createBackpackSlot()
	local holder = holderTemplate:Clone()
	holder.Name = "BackpackSlot"
	holder.Visible = true
	holder:SetAttribute("IsBackpack", true)

	local icon = holder:FindFirstChild("Icon")
	if icon then
		icon.Image = BACKPACK_ICON
	end

	local slotNum = holder:FindFirstChild("SlotNumber")
	if slotNum then
		slotNum.Text = "G"
	end

	local amount = holder:FindFirstChild("Amount")
	if amount then
		amount.Visible = false
	end

	holder.LayoutOrder = BACKPACK_SLOT_INDEX

	holder.MouseButton1Click:Connect(function()
		setInventoryFrameOpen(not inventoryFrameOpen)
	end)

	slots[BACKPACK_SLOT_INDEX] = holder
	holder.Parent = inventoryBottom
end

createBackpackSlot()

addBrainrotToInventory = function(brainrotId, level, mutation)
	level = level or 1
	mutation = normalizeMutation(mutation)
	local existing = findExistingHolder(brainrotId, level, mutation)
	if existing then
		return
	end

	local brainrotData = GameConfig.Items[brainrotId]

	local holder = holderTemplate:Clone()
	holder.Visible = true
	holder:SetAttribute("BrainrotId", brainrotId)
	holder:SetAttribute("Level", level)
	holder:SetAttribute("Mutation", mutation or "")
	holder:SetAttribute("Count", 1)

	-- Render the brainrot as a live 3D viewport (matching the lucky-block
	-- slot look) so the player sees the actual mesh + mutation, not a static
	-- icon. Falls back to the 2D Image path if the brainrot template can't
	-- be located -- catches mid-migration data or new ids without a model.
	local brainrotTemplate = getCleanedBrainrotTemplate(brainrotId, mutation)
	if brainrotTemplate then
		buildSlotViewport(holder, brainrotTemplate)
	else
		local icon = holder:FindFirstChild("Icon")
		if icon then
			local imgId = brainrotData and (brainrotData.imageId or brainrotData.ImageId) or ""
			if GameConfig.GetItemImage then
				imgId = GameConfig.GetItemImage(brainrotId, mutation)
			end
			if imgId and imgId ~= "" then
				icon.Image = imgId
			end
			local hasCustomMutImg = false
			if mutation then
				local mutCfg = GameConfig.Mutations and GameConfig.Mutations[mutation]
				if mutCfg and mutCfg.ImageIds and mutCfg.ImageIds[brainrotId] and mutCfg.ImageIds[brainrotId] ~= "" then
					hasCustomMutImg = true
				end
				if not hasCustomMutImg and mutCfg and mutCfg.ImageColor then
					icon.ImageColor3 = mutCfg.ImageColor
				else
					icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
				end
			else
				icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
			end
		end
	end

	updateAmountLabel(holder)
	attachDragAndClick(holder)

	local slotNum = holder:FindFirstChild("SlotNumber")
	local idx = findFreeBottomIndex()
	if idx then
		holder.Name = "Slot_" .. idx
		holder.LayoutOrder = idx
		if slotNum then
			slotNum.Text = tostring(idx)
		end
		slots[idx] = holder
		holder.Parent = inventoryBottom
	else
		frameOrderCounter = frameOrderCounter + 1
		holder.Name = "FrameSlot_" .. frameOrderCounter
		holder.LayoutOrder = frameOrderCounter
		if slotNum then
			slotNum.Text = ""
		end
		holder.Parent = frameScroll
	end
end

local function syncSlotCounts()
	local function destroySlotIfSelected(s)
		if selectedSlot == s then
			selectedSlot = nil
			BrainrotController.StopCarry()
			HoldingAnimationController.StopCarry()
		end
	end

	for i = 1, MAX_SLOTS do
		local s = slots[i]
		if s and not s:GetAttribute("IsBackpack") then
			local brainrotId = s:GetAttribute("BrainrotId")
			if brainrotId and brainrotId ~= "" then
				local level = s:GetAttribute("Level") or 1
				local mutation = normalizeMutation(s:GetAttribute("Mutation"))
				local list = inventoryUniqueIdsByStackKey[makeStackKey(brainrotId, level, mutation)]
				local newCount = list and #list or 0
				if newCount <= 0 then
					destroySlotIfSelected(s)
					slots[i] = nil
					s:Destroy()
				else
					s:SetAttribute("Count", newCount)
					updateAmountLabel(s)
				end
			end
		end
	end

	for _, holder in ipairs(frameScroll:GetChildren()) do
		if holder:IsA("GuiObject") and holder ~= frameHolderTemplate then
			local brainrotId = holder:GetAttribute("BrainrotId")
			if brainrotId and brainrotId ~= "" then
				local level = holder:GetAttribute("Level") or 1
				local mutation = normalizeMutation(holder:GetAttribute("Mutation"))
				local list = inventoryUniqueIdsByStackKey[makeStackKey(brainrotId, level, mutation)]
				local newCount = list and #list or 0
				if newCount <= 0 then
					holder:Destroy()
				else
					holder:SetAttribute("Count", newCount)
					updateAmountLabel(holder)
				end
			end
		end
	end
end

local function ensureSlotsForInventory()
	for key, list in pairs(inventoryUniqueIdsByStackKey) do
		local brainrotId = stackKeyToBrainrotId[key]
		local level = stackKeyToLevel[key] or 1
		local mutation = stackKeyToMutation[key]
		if brainrotId and #list > 0 and not findExistingHolder(brainrotId, level, mutation) then
			addBrainrotToInventory(brainrotId, level, mutation)
			local holder = findExistingHolder(brainrotId, level, mutation)
			if holder then
				holder:SetAttribute("Count", #list)
				updateAmountLabel(holder)
			end
		end
	end
end

-- Lucky-block toolbar slots use a ViewportFrame of the model instead of the
-- 2D Icon image, so the player sees the actual block they collected. Slot
-- creation/teardown is driven by the player's Inventory map (which is the
-- lucky-block count map; brainrots live in BrainrotInventory).
local luckyBlockTemplateCache = {}

local function getCleanedLuckyBlockTemplate(modelName)
	if not modelName or modelName == "" then return nil end
	local cached = luckyBlockTemplateCache[modelName]
	if cached then return cached end
	local original = LUCKY_BLOCK_TEMPLATES:FindFirstChild(modelName)
	if not original then
		-- Store loot item models (GameConfig.LuckyBlocks entries with
		-- IsLootItem) live under ReplicatedStorage.LuckyBlockLoot.<Tier>.
		local lootRoot = ReplicatedStorage:FindFirstChild("LuckyBlockLoot")
		if lootRoot then
			for _, tierFolder in ipairs(lootRoot:GetChildren()) do
				local hit = tierFolder:FindFirstChild(modelName)
				if hit then original = hit break end
			end
		end
	end
	if not original or not original:IsA("Model") then return nil end
	local template = original:Clone()
	-- Strip authoring leftovers but KEEP the AnimationController/Animator +
	-- Idle Animation so buildSlotViewport can drive the skinned-mesh Idle
	-- loop in the slot icon (otherwise the model sits in a frozen rest pose).
	for _, d in ipairs(template:GetDescendants()) do
		if d.Name == "AnimSaves" or d.Name == "InitialPoses" then
			d:Destroy()
		elseif d:IsA("KeyframeSequence") then
			d:Destroy()
		elseif d:IsA("ProximityPrompt") or d:IsA("BillboardGui") then
			d:Destroy()
		end
	end
	for _, d in ipairs(template:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
			d.CanQuery = false
			d.CanTouch = false
		end
	end
	luckyBlockTemplateCache[modelName] = template
	return template
end

-- Three-quarter isometric framing: front-right + slight pitch from above.
-- Camera direction uses -Z (front) so we see the model's face -- the rigs
-- have LookVector = -Z, so a +Z camera was looking at their back. +X gives
-- the slight "angled to the right" framing the inventory slots use.
-- Distance is derived from the bounding sphere radius + camera FOV so the
-- model is exactly inscribed in the square viewport regardless of size.
local VIEWPORT_FOV = 30
local VIEWPORT_VIEW_DIR = Vector3.new(1, 0.7, -1).Unit
-- Smaller padding = camera sits closer = the model fills more of the slot.
local VIEWPORT_PADDING = 1.05

-- Default lucky-block padding (1.85) gives every block breathing room in
-- the slot. Wide/winged rigs (Dragon, Angel, Heaven, Slime, Autumn) get
-- pulled in a bit so their wings/long axis reads bigger -- the long-side
-- fit otherwise makes their bodies feel small in the middle of the slot.
local LUCKY_VIEWPORT_PADDING = 1.85
local LUCKY_VIEWPORT_PADDING_WINGED = 1.45

local function fitCameraToModel(camera, model, paddingOverride)
	local _, bbSize = model:GetBoundingBox()
	-- Fit by the longest axis-aligned extent, not the diagonal. bbSize.Magnitude
	-- (the diagonal) treats every model like a sphere, which made elongated
	-- rigs (Spaghetti / tall brainrots) shoot off the top of the slot while
	-- short/wide rigs floated tiny in the middle. Using max(X,Y,Z) sizes every
	-- model so its longest dimension just fits the viewport's vertical FOV.
	local halfExtent = math.max(bbSize.X, bbSize.Y, bbSize.Z) * 0.5
	local padding = paddingOverride or VIEWPORT_PADDING
	local distance = (halfExtent / math.sin(math.rad(VIEWPORT_FOV) * 0.5)) * padding
	local camPos = VIEWPORT_VIEW_DIR * distance
	camera.FieldOfView = VIEWPORT_FOV
	camera.CFrame = CFrame.lookAt(camPos, Vector3.zero)
end

-- Cache of cleaned brainrot templates so each slot creation doesn't re-clone
-- + strip a fresh template every time. Keyed by brainrotId + mutation since
-- the same brainrot can render different (e.g. Golden vs Normal) variants.
local brainrotTemplateCache = {}

function getCleanedBrainrotTemplate(brainrotId, mutation)
	if not brainrotId or brainrotId == "" then return nil end
	local cacheKey = brainrotId .. "|" .. (mutation or "")
	local cached = brainrotTemplateCache[cacheKey]
	if cached then return cached end

	local mutationFolderName = (mutation and mutation ~= "") and mutation or "Normal"
	local original
	for _, rarityFolder in ipairs(BRAINROTS_FOLDER:GetChildren()) do
		local mutFolder = rarityFolder:FindFirstChild(mutationFolderName)
		local hit = mutFolder and mutFolder:FindFirstChild(brainrotId)
		if hit then original = hit break end
	end
	-- Fallback to Normal if a mutation-specific template doesn't exist (some
	-- mutations only ship a recolor / VFX overlay on the Normal mesh).
	if not original and mutationFolderName ~= "Normal" then
		for _, rarityFolder in ipairs(BRAINROTS_FOLDER:GetChildren()) do
			local normalFolder = rarityFolder:FindFirstChild("Normal")
			local hit = normalFolder and normalFolder:FindFirstChild(brainrotId)
			if hit then original = hit break end
		end
	end
	if not original or not original:IsA("Model") then return nil end

	local template = original:Clone()
	-- Same KEEP-animations rule as the lucky-block cleaner above. Humanoid is
	-- still stripped because brainrots in the inventory slot don't need rig
	-- state, and Humanoid presence would block Anchored-part rendering.
	for _, d in ipairs(template:GetDescendants()) do
		if d.Name == "AnimSaves" or d.Name == "InitialPoses" then
			d:Destroy()
		elseif d:IsA("KeyframeSequence") or d:IsA("Humanoid") then
			d:Destroy()
		elseif d:IsA("ProximityPrompt") or d:IsA("BillboardGui") then
			d:Destroy()
		end
	end
	for _, d in ipairs(template:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
			d.CanQuery = false
			d.CanTouch = false
		end
	end
	brainrotTemplateCache[cacheKey] = template
	return template
end

-- Freeze a slot model's idle on the pose it's currently holding: bake every
-- Bone/Motor6D Transform, stop the track, and re-apply the baked pose (twice:
-- the Animator's deferred teardown can zero transforms a frame after Stop).
-- WHY: an animated WorldModel inside an always-on-screen hotbar viewport
-- re-deforms its skinned mesh AND re-renders the viewport EVERY frame for as
-- long as the slot exists -- a permanent per-frame cost per filled slot.
-- A baked pose is pixel-identical to a paused frame of the idle at zero cost.
local SLOT_IDLE_FREEZE_MIN = 1.1
local SLOT_IDLE_FREEZE_SPREAD = 0.8 -- randomized so slots freeze on varied poses

local function freezeSlotIdle(modelClone)
	local track = idleTrackByModel[modelClone]
	if not track or not modelClone.Parent then return end
	local posed = {}
	for _, d in ipairs(modelClone:GetDescendants()) do
		if d:IsA("Bone") or d:IsA("Motor6D") then
			posed[d] = d.Transform
		end
	end
	track:Stop(0)
	idleTrackByModel[modelClone] = nil
	local function apply()
		if not modelClone.Parent then return end
		for d, tf in pairs(posed) do
			if d.Parent then
				d.Transform = tf
			end
		end
	end
	apply()
	task.delay(0.15, apply)
end

-- Now takes a cleaned template directly. The two callers (lucky blocks +
-- brainrots) look up their respective templates via the per-type cache and
-- hand the result in. Centralizing the viewport-construction logic keeps the
-- camera / lighting / aspect-ratio handling identical for both types.
-- `isLuckyBlock` switches the padding profile (lucky blocks have their own
-- cube-vs-irregular fit picked below) but the Idle animation is driven for
-- both types -- winged lucky blocks (Angel / Heaven / Dragon) flap in the
-- slot the same way brainrots breathe.
function buildSlotViewport(holder, template, isLuckyBlock)
	if not template then return end

	local oldIcon = holder:FindFirstChild("Icon")
	if not oldIcon then return end

	-- The drill slot renders with the EXACT drill-shop recipe (user request:
	-- hotbar icon must match the shop card) -- neutral lighting + sphere-fit
	-- 3/4 camera instead of the warm brainrot-slot profile.
	local isDrill = holder:GetAttribute("DrillSlot") == true

	local viewport = holder:FindFirstChild("ModelIcon")
	if not viewport then
		viewport = Instance.new("ViewportFrame")
		viewport.Name = "ModelIcon"
		viewport.AnchorPoint = oldIcon.AnchorPoint
		viewport.Position = oldIcon.Position
		viewport.Size = oldIcon.Size
		viewport.BackgroundTransparency = 1
		viewport.LightDirection = Vector3.new(-0.4, -1, -0.3)
		viewport.LightColor = Color3.fromRGB(255, 245, 220)
		viewport.Ambient = Color3.fromRGB(170, 170, 180)
		viewport.ZIndex = oldIcon.ZIndex
		local ar = oldIcon:FindFirstChildOfClass("UIAspectRatioConstraint")
		if ar then
			local arc = Instance.new("UIAspectRatioConstraint")
			arc.AspectRatio = ar.AspectRatio
			arc.Parent = viewport
		end
		viewport.Parent = holder
	end
	oldIcon.Visible = false

	if isDrill then
		viewport.LightDirection = Vector3.new(-0.5, -1, -1.5)
		viewport.LightColor = Color3.fromRGB(255, 255, 255)
		viewport.Ambient = Color3.fromRGB(185, 185, 185)
	end

	-- WorldModel wrapper: Animator only deforms skinned meshes inside a world
	-- root, so without this the slot model would sit in a rest pose even with
	-- the Idle track playing. Camera still lives directly on the ViewportFrame.
	local worldModel = viewport:FindFirstChildOfClass("WorldModel")
	if not worldModel then
		worldModel = Instance.new("WorldModel")
		worldModel.Parent = viewport
	end

	-- Rebuild the model fresh each call so size changes (different lucky
	-- blocks reusing the same slot via Inventory diffs) reframe correctly.
	for _, c in ipairs(worldModel:GetChildren()) do
		c:Destroy()
	end
	for _, c in ipairs(viewport:GetChildren()) do
		if c:IsA("Camera") then
			c:Destroy()
		end
	end

	local modelClone = template:Clone()
	-- Center the model on the origin so the camera (which looks at Vector3.zero)
	-- frames it regardless of where the source model's pivot sits. The old
	-- `pivot * bbCF:Inverse()` math mixed world-space transforms incorrectly
	-- (the inverse rotates *and* translates), which placed off-pivot models
	-- below/beside the camera target. Translating by -bbCenter directly puts
	-- the bbox center exactly at the origin while preserving rotation.
	local bbCF, bbSize = modelClone:GetBoundingBox()
	-- Brainrots: shift UP by ~12% of bbox height so the head/body lands at the
	-- slot center (bbox center is hip-height because of the legs, which left
	-- the visual focus low).
	-- Lucky blocks: shift DOWN slightly so cubes align with the brainrot icons
	-- in the same row.
	local verticalShift
	if isDrill then
		-- drill shop centers on the bounds; no hip-height compensation
		verticalShift = 0
	elseif isLuckyBlock then
		verticalShift = -0.45
	else
		verticalShift = bbSize.Y * 0.12
	end
	modelClone:PivotTo(CFrame.new(-bbCF.Position + Vector3.new(0, verticalShift, 0)) * modelClone:GetPivot())
	modelClone.Parent = worldModel

	-- Drive the looped Idle track. Brainrots: always. Lucky blocks: only the
	-- rigged ones (>= 3 Bones) -- the plain cube blocks (Pink / Blue / Yellow /
	-- Bulky / Spiked / Lava) ship a 2-bone wobble Idle that reads as a stutter
	-- in the small slot viewport. Winged / leafy / chained / planet / king /
	-- slime variants (3+ Bones) have meaningful idle motion worth showing.
	local shouldPlayIdle = true
	if isLuckyBlock then
		local boneCount = 0
		for _, d in ipairs(modelClone:GetDescendants()) do
			if d:IsA("Bone") then
				boneCount = boneCount + 1
				if boneCount >= 3 then break end
			end
		end
		shouldPlayIdle = boneCount >= 3
	end
	if shouldPlayIdle then
		playAnimation(modelClone)
		-- let the idle establish a natural mid-motion pose, then freeze it
		task.delay(SLOT_IDLE_FREEZE_MIN + math.random() * SLOT_IDLE_FREEZE_SPREAD, function()
			freezeSlotIdle(modelClone)
		end)
	end

	local paddingOverride = nil
	if isLuckyBlock then
		-- Winged / wide-spread rigs (Dragon, Angel, Heaven, Slime, Autumn)
		-- have one axis much longer than the others. Fit-to-longest-dim
		-- shrinks their body to the middle of the slot, so pull the camera
		-- a bit closer for them. Cube-ish blocks keep the default padding.
		local maxDim = math.max(bbSize.X, bbSize.Y, bbSize.Z, 0.01)
		local minDim = math.max(math.min(bbSize.X, bbSize.Y, bbSize.Z), 0.01)
		local aspect = maxDim / minDim
		paddingOverride = (aspect >= 2.0) and LUCKY_VIEWPORT_PADDING_WINGED or LUCKY_VIEWPORT_PADDING
	end

	local camera = Instance.new("Camera")
	camera.Parent = viewport
	viewport.CurrentCamera = camera
	if isDrill then
		-- same fitted 3/4 camera as ItemShopController.buildViewport: bounding
		-- SPHERE fit (not longest-extent) at euler(-12, 35), padding 1.05
		local radius = math.max(bbSize.Magnitude / 2, 0.1)
		camera.FieldOfView = VIEWPORT_FOV
		local distance = radius / math.tan(math.rad(VIEWPORT_FOV / 2)) * 1.05
		camera.CFrame = CFrame.fromEulerAnglesYXZ(math.rad(-12), math.rad(35), 0) * CFrame.new(0, 0, distance)
		-- shop cards carry the sticker outline; the hotbar drill icon is the
		-- one static slot viewport, so it can (and should) match. Brainrot /
		-- lucky-block slots play Idle tracks -- a static outline would desync,
		-- so they intentionally stay outline-free.
		ViewportOutline.Add(viewport, modelClone, camera)
	else
		fitCameraToModel(camera, modelClone, paddingOverride)
	end
end

local function addLuckyBlockToInventory(luckyBlockId, count)
	local existing = luckyBlockSlots[luckyBlockId]
	if existing and existing.Parent then
		existing:SetAttribute("Count", count)
		updateAmountLabel(existing)
		return existing
	end

	local cfg = GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[luckyBlockId]
	if not cfg then return nil end

	local holder = holderTemplate:Clone()
	holder.Visible = true
	holder:SetAttribute("LuckyBlockId", luckyBlockId)
	holder:SetAttribute("BrainrotId", "")
	holder:SetAttribute("Count", count)
	holder:SetAttribute("Level", 1)

	-- true = lucky-block padding profile (cube-aware fit). Idle animation is
	-- driven for both types now so winged blocks flap their wings in the slot.
	buildSlotViewport(holder, getCleanedLuckyBlockTemplate(cfg.ModelName or luckyBlockId), true)
	updateAmountLabel(holder)
	attachDragAndClick(holder)

	local slotNum = holder:FindFirstChild("SlotNumber")
	local idx = findFreeBottomIndex()
	if idx then
		holder.Name = "LuckyBlockSlot_" .. luckyBlockId
		holder.LayoutOrder = idx
		if slotNum then slotNum.Text = tostring(idx) end
		slots[idx] = holder
		holder.Parent = inventoryBottom
	else
		frameOrderCounter = frameOrderCounter + 1
		holder.Name = "LuckyBlockFrameSlot_" .. luckyBlockId
		holder.LayoutOrder = frameOrderCounter
		if slotNum then slotNum.Text = "" end
		holder.Parent = frameScroll
	end

	luckyBlockSlots[luckyBlockId] = holder
	return holder
end

local function removeLuckyBlockSlot(luckyBlockId)
	local holder = luckyBlockSlots[luckyBlockId]
	luckyBlockSlots[luckyBlockId] = nil
	if not holder then return end
	if selectedSlot == holder then
		setSlotHighlight(holder, false)
		selectedSlot = nil
		if localEquippedLuckyBlockId == luckyBlockId then
			localEquippedLuckyBlockId = nil
		end
	end
	for i = 1, MAX_SLOTS do
		if slots[i] == holder then slots[i] = nil end
	end
	holder:Destroy()
end

local function syncLuckyBlockSlotsFromInventory(inventoryMap)
	inventoryMap = inventoryMap or {}
	for luckyBlockId, holder in pairs(luckyBlockSlots) do
		local amount = inventoryMap[luckyBlockId] or 0
		if amount <= 0 or not holder.Parent then
			removeLuckyBlockSlot(luckyBlockId)
		end
	end
	for luckyBlockId, amount in pairs(inventoryMap) do
		if type(amount) == "number" and amount > 0 and GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[luckyBlockId] then
			local slot = luckyBlockSlots[luckyBlockId]
			if slot and slot.Parent then
				slot:SetAttribute("Count", amount)
				updateAmountLabel(slot)
			else
				addLuckyBlockToInventory(luckyBlockId, amount)
			end
		end
	end
end

-- ===== Permanent drill hotbar slot =====
-- The player's owned drill (starter Wood drill until the drill shop
-- exists) lives in the hotbar as a permanent slot with a 3D viewport
-- icon. Click / number key toggles the server-owned held state:
-- held = drill in the drilling grip + upper-body hold pose (legs free);
-- unheld = drill on the back. Equipping a brainrot / lucky block
-- auto-releases the drill server-side (one pair of hands).
local drillSlot = nil

local function getCleanedDrillTemplate()
	-- catalog lives in ReplicatedStorage.Drills (moved out of workspace 2026-07-16)
	local drills = ReplicatedStorage:FindFirstChild("Drills") or workspace:FindFirstChild("Drills")
	-- Selected drill from the drill shop (SelectedDrill attribute mirrors the
	-- profile); starter Wood drill until it resolves.
	local selected = player:GetAttribute("SelectedDrill")
	local original = nil
	if type(selected) == "string" and selected ~= "" and drills then
		original = drills:FindFirstChild(selected)
	end
	original = original
		or (drills and drills:FindFirstChild("Drill1 - Wood"))
		or workspace:FindFirstChild("Drill1 - Wood", true)
		or workspace:FindFirstChild("Drill1", true)
	if not original or not original:IsA("Model") then return nil end
	local template = original:Clone()
	for _, d in ipairs(template:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
			d.CanQuery = false
			d.CanTouch = false
		elseif d:IsA("ProximityPrompt") or d:IsA("BillboardGui") then
			d:Destroy()
		end
	end
	return template
end

-- Flat drill card art (GameConfig.Drills[..].ImageId, uploaded 2026-07-22)
-- replaces the slot's 3D viewport. Returns false when the selected drill
-- has no art (Wood) so the caller keeps the viewport fallback.
local function applyDrillSlotIcon(holder)
	local selected = player:GetAttribute("SelectedDrill")
	local cfg = (type(selected) == "string" and GameConfig.Drills and GameConfig.Drills[selected])
		or (GameConfig.Drills and GameConfig.Drills[GameConfig.DefaultDrill or "Drill1 - Wood"])
	local imageId = cfg and cfg.ImageId
	if not imageId then return false end
	local icon = holder:FindFirstChild("Icon")
	if not icon then return false end
	local viewport = holder:FindFirstChild("ModelIcon")
	if viewport then viewport:Destroy() end
	icon.Image = imageId
	icon.ScaleType = Enum.ScaleType.Fit
	icon.Visible = true
	return true
end

local function createDrillSlot()
	if drillSlot and drillSlot.Parent then return end
	local holder = holderTemplate:Clone()
	holder.Visible = true
	holder:SetAttribute("DrillSlot", true)
	holder:SetAttribute("BrainrotId", "")
	holder:SetAttribute("LuckyBlockId", "")
	holder:SetAttribute("Count", 1)
	holder:SetAttribute("Level", 1)
	if not applyDrillSlotIcon(holder) then
		local template = getCleanedDrillTemplate()
		if not template then
			holder:Destroy()
			return
		end
		buildSlotViewport(holder, template, false)
	end
	updateAmountLabel(holder)
	attachDragAndClick(holder)
	local slotNum = holder:FindFirstChild("SlotNumber")
	-- the drill owns hotbar slot 1 (freed up when the axe system was removed);
	-- items keep filling 2..MAX_SLOTS via findFreeBottomIndex
	local idx = (slots[1] == nil) and 1 or findFreeBottomIndex()
	holder.Name = "DrillSlot"
	if idx then
		holder.LayoutOrder = idx
		if slotNum then slotNum.Text = tostring(idx) end
		slots[idx] = holder
		holder.Parent = inventoryBottom
	else
		frameOrderCounter = frameOrderCounter + 1
		holder.LayoutOrder = frameOrderCounter
		if slotNum then slotNum.Text = "" end
		holder.Parent = frameScroll
	end
	drillSlot = holder
end
createDrillSlot()

-- Re-render the hotbar slot's viewport whenever the shop equips a
-- different drill (buildSlotViewport rebuilds the WorldModel + camera
-- from scratch, so re-calling it on the live holder is safe).
player:GetAttributeChangedSignal("SelectedDrill"):Connect(function()
	if not (drillSlot and drillSlot.Parent) then return end
	if applyDrillSlotIcon(drillSlot) then return end
	local template = getCleanedDrillTemplate()
	if template then
		buildSlotViewport(drillSlot, template, false)
	end
end)

-- background resolve + listen: never blocks this script when the remote
-- is late (or the drill system is down entirely)
task.spawn(function()
	if not drillEvent then
		drillEvent = ReplicatedStorage:WaitForChild("DrillEvent", 120)
	end
	if not drillEvent then return end
	drillEvent.OnClientEvent:Connect(function(action)
		-- "start"/"stop" are the drilling-session events: mining auto-swaps
		-- the hands to the drill server-side, so the hotbar highlight follows
		-- it exactly like the manual hold toggle
		if action == "hold" or action == "start" then
			if drillSlot then setSlotHighlight(drillSlot, true) end
		elseif action == "unhold" or action == "stop" then
			if drillSlot then setSlotHighlight(drillSlot, false) end
		end
	end)
end)

DataUpdateEvent.OnClientEvent:Connect(function(statName, value)
	if statName == "Inventory" then
		syncLuckyBlockSlotsFromInventory(value)
		return
	end
	if statName ~= "BrainrotInventory" then return end
	rebuildInventoryMap(value)
	if localEquippedUniqueId and not (value and value[localEquippedUniqueId]) then
		localEquippedUniqueId = nil
	end
	syncSlotCounts()
	if addBrainrotToInventory then ensureSlotsForInventory() end
	if refreshPodiumPromptsState then refreshPodiumPromptsState() end
end)

task.spawn(function()
	for _ = 1, 20 do
		local ok, data = pcall(function()
			return RequestDataFunc:InvokeServer()
		end)
		if ok and data and data.BrainrotInventory then
			rebuildInventoryMap(data.BrainrotInventory)
			ensureSlotsForInventory()
			if data.Inventory then
				syncLuckyBlockSlotsFromInventory(data.Inventory)
			end
			return
		end
		task.wait(0.5)
	end
end)

local lastCollectedAt = 0
local lastCollectedBrainrot = nil
local lastDeliveryAt = 0

collectedBrainrotEvent.OnClientEvent:Connect(function(brainrotId, mutationId, isLuckyBlock)
	local now = os.clock()
	lastCollectedBrainrot = brainrotId
	lastCollectedAt = now
	lastDeliveryAt = now

	-- Multi-carry: the server fires CollectedBrainrot once per deposited entry.
	-- Only the first event in a batch should tear down the held stack / play the
	-- island flash + sound; subsequent events just add to the inventory and show
	-- their per-brainrot notification.
	local firstOfBatch = localCarryCount > 0
	if firstOfBatch then
		localCarryCount = 0
		BrainrotController.ClearCarryStack()
		HoldingAnimationController.StopCarry()
		if selectedSlot then
			setSlotHighlight(selectedSlot, false)
			selectedSlot = nil
		end

		flashMainIsland()
		playUpgradeSound()
	end

	if isLuckyBlock then
		-- Lucky block lands in the lucky-block inventory (synced via the normal
		-- data pipeline); just confirm it. No brainrot-inventory UI add.
		local lbCfg = GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[brainrotId]
		local lbName = (lbCfg and lbCfg.DisplayName) or brainrotId
		showGreenNotification(lbName .. " added to inventory!")
		-- Rebirth-style celebration on every lucky block deposit: fireworks
		-- around the player + rebirth SFX. Fires per lucky block in a batch so
		-- carrying multiple blocks back triggers the cue for each.
		FireworkModule.PlayAtPlayer()
		playRebirthSound()
		return
	end

	local mutDisplay = ""
	if mutationId and mutationId ~= "" then
		local mutCfg = GameConfig.Mutations and GameConfig.Mutations[mutationId]
		mutDisplay = ((mutCfg and mutCfg.DisplayName) or mutationId) .. " "
	end
	showGreenNotification(mutDisplay .. brainrotId .. " added to inventory!")

	addBrainrotToInventory(brainrotId, 1, mutationId)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end
	if input.KeyCode == Enum.KeyCode.G then
		setInventoryFrameOpen(not inventoryFrameOpen)
		return
	end
	local index = KEY_TO_SLOT[input.KeyCode]
	if not index then
		return
	end
	local slot = slots[index]
	if not slot then
		return
	end
	if selectedSlot == slot then
		unequipSlot()
	else
		equipSlot(slot)
	end
end)

local StarterGui = game:GetService("StarterGui")
-- Same flattened-Normal list, re-collected at the pool-warmup site so this
-- block doesn't depend on the order of declarations above.
local NORMAL_FOLDER_TEMPLATES = collectNormalBrainrotTemplates()
local PLOTS_FOLDER = workspace:WaitForChild("Assets"):WaitForChild("Plots")
local BILLBOARD_TEMPLATE = StarterGui:WaitForChild("PodiumBillboard")
local RARITY_GRADIENT_FOLDER = ReplicatedStorage:WaitForChild("Gradients"):WaitForChild("Rarity")
local TYPE_GRADIENT_FOLDER = ReplicatedStorage:WaitForChild("Gradients"):WaitForChild("Type")
local MUTATION_VFX_FOLDER = ReplicatedStorage:WaitForChild("MutationVFX")

local MUTATION_VFX_ATTACHMENT_NAME = "MutationVFXAttachment"

-- Combined anchor + ProximityPrompt strip in a single GetDescendants pass.
-- Brainrot templates have dozens of parts; doing two passes (anchor, then prompt-remove)
-- noticeably stutters when several slots respawn on the same frame.
local function prepareIslandClone(model)
	-- Strip KeyframeSequence + descendants (Keyframe, Pose, IntValue trees) that
	-- ship baked into the templates as animation-authoring leftovers. ~4646 extra
	-- Instances per rig that Roblox doesn't need at runtime (it uses the
	-- rbxassetid Animations instead). With 50 pool entries this was ~232K useless
	-- Instances in workspace adding per-frame engine overhead. Same fix is
	-- applied in PodiumController.spawnBrainrotModel and
	-- BrainrotController.ensurePoolEntry.
	for _, desc in ipairs(model:GetDescendants()) do
		if desc:IsA("KeyframeSequence") then
			desc:Destroy()
		end
	end

	local primary = model.PrimaryPart
	for _, desc in ipairs(model:GetDescendants()) do
		if desc:IsA("BasePart") then
			desc.Anchored = (desc == primary)
			desc.CanCollide = false
		elseif desc:IsA("ProximityPrompt") then
			desc:Destroy()
		end
	end
end

-- Instance pool. Pre-cloned brainrot Models are parented to ISLANDS_FOLDER once at
-- init and parked at a far-below-map CFrame. "Spawn" becomes a single PivotTo —
-- skipping the multi-millisecond cost of Clone() + parent + renderer-onboard of
-- 13+ MeshParts. "Despawn" pivots back to the park. The Animator's Idle track keeps
-- looping at the park (free, off-screen).
local POOL_PARK_CFRAME = CFrame.new(0, -100000, 0)
local pool = {}

local function poolStripPerSpawnChildren(model)
	local primary = model.PrimaryPart
	if primary then
		for _, child in ipairs(primary:GetChildren()) do
			if child:IsA("Attachment") and (child.Name == "PromptAttachment" or child.Name == "BillboardAttachment" or child.Name == MUTATION_VFX_ATTACHMENT_NAME) then
				child:Destroy()
			end
		end
	end
	for _, child in ipairs(model:GetChildren()) do
		if child:IsA("Highlight") then
			child:Destroy()
		end
	end
end

local function poolAcquire(name)
	local bucket = pool[name]
	if bucket and #bucket > 0 then
		return table.remove(bucket)
	end
	return nil
end

poolRelease = function(model)
	if not model or not model.Parent then
		return
	end
	poolStripPerSpawnChildren(model)
	stopAnimation(model)
	model:PivotTo(POOL_PARK_CFRAME)
	local bucket = pool[model.Name]
	if not bucket then
		bucket = {}
		pool[model.Name] = bucket
	end
	table.insert(bucket, model)
end

-- Build the pool synchronously at script init. Two pre-clones per brainrot template,
-- because CommonIsland (6 slots / 4 brainrots), RareIsland (5/4) and EpicIsland (4/4)
-- guarantee that the initial fill rolls the same brainrot more than once on the same
-- island. One pre-clone per type would force Clone() fallbacks during the visible
-- spawn loop. Two per type covers the worst case (6 slots from 4 brainrots = at most
-- 2 collisions on the same name) so the entire join-time fill is PivotTo only.
-- ~50 Clones total, paid during the loading screen.
--
-- Note: we deliberately do NOT call ensureIdleTrack here — idle animations are loaded
-- and started lazily on first acquire, so 50 invisible Animators don't run at park.
-- Fit-to-size: the new Brainrots pack ships at GetScale() ~ 0.017, so spawning
-- a clone at the source scale produces a ~0.1-stud micro-brainrot. Target ~5
-- studs on the longest axis so they’re visible from the rarity islands.
local ISLAND_SPAWN_TARGET_MAX_DIM = 5.0
local function fitIslandClone(clone)
	local _, curSize = clone:GetBoundingBox()
	local maxDim = math.max(curSize.X, curSize.Y, curSize.Z, 0.01)
	pcall(function()
		clone:ScaleTo(clone:GetScale() * (ISLAND_SPAWN_TARGET_MAX_DIM / maxDim))
	end)
end

for _, template in ipairs(NORMAL_FOLDER_TEMPLATES) do
	local bucket = {}
	for _ = 1, 2 do
		local clone = template:Clone()
		prepareIslandClone(clone)
		fitIslandClone(clone)
		clone:PivotTo(POOL_PARK_CFRAME)
		clone.Parent = ISLANDS_FOLDER
		table.insert(bucket, clone)
	end
	pool[template.Name] = bucket
end

local function getPlotsCenter()
	local total = Vector3.zero
	local count = 0
	for _, plot in ipairs(PLOTS_FOLDER:GetChildren()) do
		for _, child in ipairs(plot:GetChildren()) do
			if child:IsA("BasePart") then
				total = total + child.Position
				count = count + 1
				break
			end
		end
	end
	return count > 0 and (total / count) or Vector3.zero
end

local function setLabel(label, text)
	if not label then
		return
	end
	label.Text = text
	local inner = label:FindFirstChild("Inner")
	if inner then
		inner.Text = text
	end
end

local PLOTS_CENTER = getPlotsCenter()

local function attachMutationVFX(clone, mutationId, centerY)
	if not mutationId then return end
	local mutCfg = GameConfig.Mutations[mutationId]
	if not mutCfg then return end
	local vfxName = mutCfg.VFXName
	if not vfxName then return end
	local template = MUTATION_VFX_FOLDER:FindFirstChild(vfxName)
	if not template then return end
	local primary = clone.PrimaryPart
	if not primary then return end

	local attachment = Instance.new("Attachment")
	attachment.Name = MUTATION_VFX_ATTACHMENT_NAME
	attachment.Parent = primary
	attachment.WorldCFrame = CFrame.new(primary.Position.X, centerY, primary.Position.Z)

	for _, child in ipairs(template:GetChildren()) do
		child:Clone().Parent = attachment
	end
end

local function spawnAt(islandTopY, brainrotList, worldX, worldZ, lifetime)
	local template = brainrotList[math.random(1, #brainrotList)]
	local clone = poolAcquire(template.Name)
	if not clone then
		-- Cold-cache fallback: two slots wanted the same brainrot in the same frame.
		-- Pays Clone() cost but the resulting instance gets pooled on despawn, so this
		-- happens at most a few times per session.
		clone = template:Clone()
		prepareIslandClone(clone)
		fitIslandClone(clone)
		clone.Parent = ISLANDS_FOLDER
	end
	playAnimation(clone)

	local mutationId = GameConfig.RollIslandMutation and GameConfig.RollIslandMutation() or nil

	local bbCF, bbSize = clone:GetBoundingBox()
	local hrpOffsetFromBottom = clone.PrimaryPart.Position.Y - (bbCF.Position.Y - bbSize.Y / 2)
	local targetY = islandTopY + hrpOffsetFromBottom

	local spawnPos = Vector3.new(worldX, targetY, worldZ)
	local lookTarget = Vector3.new(PLOTS_CENTER.X, targetY, PLOTS_CENTER.Z)
	local finalCFrame = CFrame.lookAt(spawnPos, lookTarget)

	clone:PivotTo(finalCFrame)

	local state = { collected = false, mutation = mutationId }

	-- bottomY of the bounding box after PivotTo is exactly islandTopY by construction
	-- (we offset targetY = islandTopY + hrpOffsetFromBottom). Skip the second GetBoundingBox.
	local bottomY = islandTopY
	local topY = islandTopY + bbSize.Y
	local desiredY = math.min(bottomY + 3, topY)
	local centerY = (bottomY + topY) / 2

	attachMutationVFX(clone, mutationId, centerY)

	local primaryPos = clone.PrimaryPart.Position
	local promptAttachment = Instance.new("Attachment")
	promptAttachment.Name = "PromptAttachment"
	promptAttachment.Parent = clone.PrimaryPart
	promptAttachment.WorldCFrame = CFrame.new(primaryPos.X, desiredY, primaryPos.Z)

	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Collect"
	prompt.ObjectText = clone.Name
	prompt.HoldDuration = 1
	prompt:SetAttribute("GrabZoom", true)
	prompt.MaxActivationDistance = 12
	prompt.Style = Enum.ProximityPromptStyle.Custom
	prompt.RequiresLineOfSight = false
	prompt.Parent = promptAttachment

	prompt.Triggered:Connect(function(triggerPlayer)
		if triggerPlayer ~= player then
			return
		end
		if state.collected then
			return
		end
		if localCarryCount >= getMaxCarry() then
			showRedNotification("Upgrade your carry strength!")
			return
		end

		local character = player.Character
		local hrp = character and character:FindFirstChild("HumanoidRootPart")
		if not hrp or not clone.PrimaryPart then
			return
		end
		if (hrp.Position - clone.PrimaryPart.Position).Magnitude > 14 then
			return
		end

		state.collected = true

		local brainrotName = clone.Name
		local capturedMutation = state.mutation
		poolRelease(clone)

		requestCarryEvent:FireServer(brainrotName, capturedMutation)
	end)

	-- Defer the billboard creation off the spawn frame. Cloning the BILLBOARD_TEMPLATE,
	-- setting up 4 labels, gradient and timer task is ~half of the per-spawn cost; doing it
	-- one frame later means the spawn frame just clones the model, anchors it, parents it,
	-- and wires the prompt.
	task.spawn(function()
		if not clone.Parent then return end
		local billboardAttachment = Instance.new("Attachment")
		billboardAttachment.Name = "BillboardAttachment"
		billboardAttachment.Parent = clone.PrimaryPart
		billboardAttachment.WorldCFrame = CFrame.new(primaryPos.X, (bottomY + topY) / 2, primaryPos.Z)

		local cfg = GameConfig.Items[clone.Name] or {}
		local billboard = BILLBOARD_TEMPLATE:Clone()
		billboard.StudsOffsetWorldSpace = Vector3.new(0, 10, 0)
		billboard:SetAttribute("IslandBrainrotBillboard", true)

		local baseIncome = cfg.income or 1
		local displayIncome = baseIncome
		if mutationId then
			local mutCfg = GameConfig.Mutations[mutationId]
			if mutCfg and mutCfg.CashBoost then
				displayIncome = baseIncome * mutCfg.CashBoost
			end
		end

		setLabel(billboard:FindFirstChild("Name"), clone.Name)
		setLabel(billboard:FindFirstChild("Income"), string.format("$%g/s", displayIncome))

		local rarityLabel = billboard:FindFirstChild("Rarity")
		if rarityLabel then
			local rarity = GameConfig.GetItemRarity(clone.Name)
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
			local grad = RARITY_GRADIENT_FOLDER:FindFirstChild(rarity)
			if grad then
				grad:Clone().Parent = gradientHost
			end
		end

		local typeLabel = billboard:FindFirstChild("Type")
		if typeLabel then
			if mutationId then
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
				local mutGradient = TYPE_GRADIENT_FOLDER:FindFirstChild(gradientName)
				if mutGradient then
					mutGradient:Clone().Parent = gradientHost
				end
			else
				typeLabel.Text = ""
				local typeInner = typeLabel:FindFirstChild("Type")
				if typeInner then typeInner.Text = "" end
				typeLabel.Visible = false
			end
		end

		local timerFrame = billboard:FindFirstChild("TimerFrame")
		local timerLabel = timerFrame and timerFrame:FindFirstChild("Timer")
		local timerInner = timerLabel and timerLabel:FindFirstChild("Inner")

		billboard.Adornee = rootBone or primary
		billboard.Parent = primary

		if timerLabel and lifetime then
			local endTime = os.clock() + lifetime
			task.spawn(function()
				while not state.collected and clone.Parent do
					local remaining = math.max(0, endTime - os.clock())
					local text
					if remaining >= 3600 then
						text = string.format("%dh %dm", math.floor(remaining / 3600), math.floor((remaining % 3600) / 60))
					elseif remaining >= 60 then
						text = string.format("%dm %ds", math.floor(remaining / 60), math.floor(remaining % 60))
					else
						text = string.format("%.1fs", remaining)
					end
					timerLabel.Text = text
					if timerInner then
						timerInner.Text = text
					end
					if remaining <= 0 then
						break
					end
					task.wait(0.1)
				end
			end)
		end
	end)

	flashSpawn(clone)

	return clone, state
end

-- Lifetime bounds match what's written in GameConfig.Islands. Pick a fresh value
-- per spawn cycle so slots don't lock into a synchronised despawn cadence after
-- the first cycle. The GameConfig values are the *initial* lifetimes used on
-- module load (also random in [45,90]); these picks override per cycle.
local LIFETIME_MIN = 45
local LIFETIME_MAX = 90

local function pickLifetime()
	return LIFETIME_MIN + math.random() * (LIFETIME_MAX - LIFETIME_MIN)
end

local LUCKYBLOCKS_FOLDER = ReplicatedStorage:WaitForChild("LuckyBlocks")

-- World lucky-block spawn. Each rarity island now spawns its
-- GameConfig.LuckyBlockSpawn[islandName] block instead of brainrot models. The
-- PodiumBillboard overhead shows the block's DisplayName + the island Rarity
-- with the matching ReplicatedStorage.Gradients.Rarity gradient, so it lines up
-- exactly with the island SurfaceGui / existing in-game overheads. Income and
-- Type are hidden (a lucky block has no per-sec income or mutation); the Timer
-- countdown is kept.
-- desc = GameConfig.LuckyBlockSpawn[islandName] = { Rarity, DisplayName, Models }.
-- Picks one of that rarity's models, clones it from ReplicatedStorage.LuckyBlocks,
-- and reads that specific model's GameConfig.LuckyBlocks entry for the overhead
-- (DisplayName / Rarity / Luck) and for the id granted on collect.
local function spawnLuckyBlockAt(islandTopY, desc, worldX, worldZ, lifetime)
	local models = desc.Models
	if not models or #models == 0 then
		return nil, { collected = true }
	end
	local modelName = models[math.random(1, #models)]
	local cfg = GameConfig.LuckyBlocks[modelName] or {}
	local displayName = cfg.DisplayName or modelName
	local rarity = cfg.Rarity or desc.Rarity
	local luck = tonumber(cfg.Luck) or 1

	local template = LUCKYBLOCKS_FOLDER:FindFirstChild(modelName)
	if not template then
		warn("[IslandBrainrotClient] missing lucky-block model: " .. tostring(modelName))
		return nil, { collected = true }
	end

	local clone = template:Clone()
	-- Drop animation-authoring leftovers (AnimSaves KeyframeSequences +
	-- InitialPoses) but KEEP the AnimationController/Animator so the model's
	-- Idle animation can play. prepareIslandClone then anchors the primary /
	-- no-collides everything / strips baked ProximityPrompts + KeyframeSequences.
	for _, d in ipairs(clone:GetDescendants()) do
		if d.Name == "AnimSaves" or d.Name == "InitialPoses" then
			d:Destroy()
		end
	end
	prepareIslandClone(clone)
	clone.Name = modelName

	local primary = clone.PrimaryPart
	-- Scale the block up, and sit it a touch lower so the bigger model still
	-- reads as grounded on the island instead of floating.
	local LUCKYBLOCK_SCALE = 1.45
	local LUCKYBLOCK_SINK_FRAC = 0.14
	clone:ScaleTo(clone:GetScale() * LUCKYBLOCK_SCALE)
	-- Face the plots, then snap vertically using the REAL post-pivot bounding
	-- box -- skinned-mesh visual bounds don't line up with the part origin, so
	-- a single-pass offset leaves the block floating. Sink a touch so the
	-- bigger block reads grounded rather than hovering.
	local lookTarget = Vector3.new(PLOTS_CENTER.X, islandTopY, PLOTS_CENTER.Z)
	clone:PivotTo(CFrame.lookAt(Vector3.new(worldX, islandTopY, worldZ), lookTarget))
	local bbCF, bbSize = clone:GetBoundingBox()
	local desiredBottom = islandTopY - bbSize.Y * LUCKYBLOCK_SINK_FRAC
	local currentBottom = bbCF.Position.Y - bbSize.Y / 2
	clone:PivotTo(clone:GetPivot() + Vector3.new(0, desiredBottom - currentBottom, 0))
	clone.Parent = ISLANDS_FOLDER
	-- Play the block's looped Idle (Animation named "Idle" under its
	-- AnimationController). No-ops cleanly if the asset isn't accessible.
	playAnimation(clone)

	local bottomY = islandTopY
	local topY = islandTopY + bbSize.Y

	local state = { collected = false }

	local promptAttachment = Instance.new("Attachment")
	promptAttachment.Name = "PromptAttachment"
	promptAttachment.Parent = primary
	promptAttachment.Position = Vector3.new(0, bbSize.Y / 2 + 1, 0)

	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Collect"
	prompt.ObjectText = displayName
	prompt.HoldDuration = 1
	prompt:SetAttribute("GrabZoom", true)
	prompt.MaxActivationDistance = 12
	prompt.Style = Enum.ProximityPromptStyle.Custom
	prompt.RequiresLineOfSight = false
	prompt.Parent = promptAttachment

	prompt.Triggered:Connect(function(triggerPlayer)
		if triggerPlayer ~= player then
			return
		end
		if state.collected then
			return
		end
		if localCarryCount >= getMaxCarry() then
			showRedNotification("Upgrade your carry strength!")
			return
		end

		local character = player.Character
		local hrp = character and character:FindFirstChild("HumanoidRootPart")
		if not hrp or not clone.Parent or not clone.PrimaryPart then
			return
		end
		if (hrp.Position - clone.PrimaryPart.Position).Magnitude > 14 then
			return
		end

		state.collected = true
		requestCarryEvent:FireServer(modelName)
		clone:Destroy()
	end)

	-- Defer the billboard off the spawn frame (mirrors the old brainrot path).
	task.spawn(function()
		if not clone.Parent then return end
		-- Adornee the overhead to the model's root Bone so it tracks the
		-- skinned Idle animation, but PARENT it to the part (a BillboardGui
		-- orphans if parented to a Bone). Falls back to the part if no bones.
		local rootBone = primary:FindFirstChildWhichIsA("Bone")

		local billboard = BILLBOARD_TEMPLATE:Clone()
		billboard.StudsOffsetWorldSpace = Vector3.new(0, bbSize.Y / 2 + 5, 0)
		billboard:SetAttribute("IslandLuckyBlockBillboard", true)

		setLabel(billboard:FindFirstChild("Name"), displayName)

		-- Repurposed: the per-second income label now shows the block's luck
		-- multiplier ("xN.NN Luck"). Kept visible -- a world lucky block has no
		-- $/s; its luck is the meaningful overhead stat here.
		setLabel(billboard:FindFirstChild("Income"), string.format("x%.2f Luck", luck))

		local typeLabel = billboard:FindFirstChild("Type")
		if typeLabel then
			typeLabel.Visible = false
		end

		local rarityLabel = billboard:FindFirstChild("Rarity")
		if rarityLabel then
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
			local grad = RARITY_GRADIENT_FOLDER:FindFirstChild(rarity)
			if grad then
				grad:Clone().Parent = gradientHost
			end
		end

		local timerFrame = billboard:FindFirstChild("TimerFrame")
		local timerLabel = timerFrame and timerFrame:FindFirstChild("Timer")
		local timerInner = timerLabel and timerLabel:FindFirstChild("Inner")

		billboard.Adornee = rootBone or primary
		billboard.Parent = primary

		if timerLabel and lifetime then
			local endTime = os.clock() + lifetime
			task.spawn(function()
				while not state.collected and clone.Parent do
					local remaining = math.max(0, endTime - os.clock())
					local text
					if remaining >= 3600 then
						text = string.format("%dh %dm", math.floor(remaining / 3600), math.floor((remaining % 3600) / 60))
					elseif remaining >= 60 then
						text = string.format("%dm %ds", math.floor(remaining / 60), math.floor(remaining % 60))
					else
						text = string.format("%.1fs", remaining)
					end
					timerLabel.Text = text
					if timerInner then
						timerInner.Text = text
					end
					if remaining <= 0 then
						break
					end
					task.wait(0.1)
				end
			end)
		end
	end)

	return clone, state
end

-- Random world X/Z on an island's top surface, in the island Part's object
-- space so it respects the island's orientation. Margins keep blocks off the
-- edges.
local ISLAND_EDGE_MARGIN_X = 5
local ISLAND_EDGE_MARGIN_Z = 7
local function randomIslandXZ(island)
	local hx = math.max(1, island.Size.X / 2 - ISLAND_EDGE_MARGIN_X)
	local hz = math.max(1, island.Size.Z / 2 - ISLAND_EDGE_MARGIN_Z)
	local lx = (math.random() * 2 - 1) * hx
	local lz = (math.random() * 2 - 1) * hz
	local p = (island.CFrame * CFrame.new(lx, 0, lz)).Position
	return p.X, p.Z
end

-- Random spot at least LUCKYBLOCK_MIN_SEPARATION studs from every other live
-- block on the same island (best-effort: keeps the last try after a few fails).
local LUCKYBLOCK_MIN_SEPARATION = 16
local function pickFreeIslandXZ(island, active)
	local x, z
	for _ = 1, 14 do
		x, z = randomIslandXZ(island)
		local ok = true
		for _, p in pairs(active) do
			local dx, dz = p.x - x, p.z - z
			if (dx * dx + dz * dz) < (LUCKYBLOCK_MIN_SEPARATION * LUCKYBLOCK_MIN_SEPARATION) then
				ok = false
				break
			end
		end
		if ok then
			break
		end
	end
	return x, z
end

-- One slot loop = one concurrent block on the island (slot COUNT per rarity is
-- still GameConfig.Islands[<island>].slots, so Common has more live blocks than
-- Secret). Each respawn picks a fresh random, non-overlapping position rather
-- than a fixed slot coordinate.
local function runLuckyBlockSlot(islandTopY, desc, ctx)
	-- First cycle uses the config-supplied lifetime so the join-time fill matches
	-- whatever's in GameConfig (itself random 45-90 at module load).
	local lifetime = ctx.lifetime
	local slotKey = {}
	while true do
		local worldX, worldZ = pickFreeIslandXZ(ctx.island, ctx.active)
		ctx.active[slotKey] = { x = worldX, z = worldZ }

		local block, state = spawnLuckyBlockAt(islandTopY, desc, worldX, worldZ, lifetime)
		local spawnedAt = os.clock()

		while not state.collected and os.clock() - spawnedAt < lifetime do
			task.wait(0.15)
		end
		if not state.collected and block and block.Parent then
			block:Destroy()
		end
		ctx.active[slotKey] = nil
		-- Jitter the respawn gap so slots that briefly share a lifetime don't
		-- resync into a single despawn+spawn burst on the same frame.
		task.wait(0.5 + math.random() * 0.6)
		lifetime = pickLifetime()
	end
end

-- Per-island discovery: each time the player touches MainIsland, the discovered set
-- resets. The next time they touch each island, it flashes white (+ chime).
-- The green name notification was removed on user request -- the flash alone
-- marks the arrival.
local discoveredIslands = {}

local function announceIslandDiscovery(islandName, config, islandPart)
	if discoveredIslands[islandName] then
		return
	end
	discoveredIslands[islandName] = true

	flashIslandPart(islandPart)
	playUpgradeSound()
end

local function bindIslandDiscovery(islandPart, islandName, config)
	islandPart.Touched:Connect(function(hit)
		if discoveredIslands[islandName] then
			return
		end
		local character = player.Character
		if not character or not hit:IsDescendantOf(character) then
			return
		end
		announceIslandDiscovery(islandName, config, islandPart)
	end)
end

MAIN_ISLAND.Touched:Connect(function(hit)
	local character = player.Character
	if not character or not hit:IsDescendantOf(character) then
		return
	end
	discoveredIslands = {}
end)

-- Discovery binds from the ISLANDS FOLDER itself, not GameConfig.Islands:
-- the config only describes Zone1..7 (lucky-block era), while the map has
-- 30 ZoneNIsland parts -- config-driven binding left zones 8+ with no
-- arrival flash/chime. ChildAdded covers islands that replicate late (on
-- some joins individual island Parts arrive after this script runs); the
-- runtime lucky-block MODELS parented into this folder are filtered by the
-- BasePart check.
-- Lucky-block spawning runs server-side (IslandLuckyBlockSpawner); the
-- client billboard + animation follower lives in LuckyBlockBillboardClient.
local function setupIslandDiscovery(island)
	if not island:IsA("BasePart") then return end
	bindIslandDiscovery(island, island.Name, GameConfig.Islands[island.Name])
end

for _, island in ipairs(ISLANDS_FOLDER:GetChildren()) do
	setupIslandDiscovery(island)
end
ISLANDS_FOLDER.ChildAdded:Connect(setupIslandDiscovery)
