local ContentProvider = game:GetService("ContentProvider")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")


local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local FormatUtils = require(ReplicatedStorage.Source.Utils.FormatUtils)
local SettingsController = require(ReplicatedStorage.Source.Controllers.SettingsController)
local PadUnboxing = require(ReplicatedStorage.Source.Modules.PadUnboxing)

local RebirthController = nil
local CashBoostHudController = nil
local function getRebirthMultiplier()
	if not RebirthController then
		RebirthController = require(ReplicatedStorage.Source.Controllers.RebirthController)
	end
	return RebirthController.GetCurrentMultiplier()
end
local function getCashBoostMultiplier()
	if not CashBoostHudController then
		CashBoostHudController = require(ReplicatedStorage.Source.Controllers.CashBoostHudController)
	end
	local ok, m = pcall(CashBoostHudController.GetMultiplier)
	if ok and type(m) == "number" then return m end
	return 1
end
local function getDisplayMultiplier()
	return getRebirthMultiplier() * getCashBoostMultiplier()
end

local EffectsFolder = ReplicatedStorage:FindFirstChild("Effects")
local CollectAttachment = EffectsFolder and EffectsFolder:FindFirstChild("Collect")
local SoundsFolder = SoundService:FindFirstChild("Sounds")
local CashSound = SoundsFolder and SoundsFolder:FindFirstChild("CashSound")
-- Cash-collect SFX: plays every time the player collects cash (per-pad collect
-- + Collect All). Cloned per play so rapid collects layer instead of cutting.
-- Asset + volume ported from the "Get Slim For Brainrots" project so the feel
-- matches across both games (see memory: brainrot-cash-collection-system).
local CashCollectSound = Instance.new("Sound")
CashCollectSound.Name = "CashCollectSound"
CashCollectSound.SoundId = "rbxassetid://131737037329240"
CashCollectSound.Volume = 0.2
CashCollectSound.Parent = SoundService

-- Upgrade SFX template: cloned per play, parented to PlayerGui (2D, no fall-off).
-- Ported from the source project so rapid upgrade clicks layer instead of cutting
-- (the old shared SoundService.Sounds.UpgradeSound used to cancel itself).
local UPGRADE_SFX_ID = "rbxassetid://6506462579"
local UPGRADE_SFX_VOLUME = 0.25

-- Cash-collect burst constants (ported from source project). Applied at runtime to
-- whichever Vfx.Money / Effects.Collect template is found so the original authored
-- particle properties stay untouched.
local COLLECT_SIZE_BOOST = 2.6
local COLLECT_COUNT_BOOST = 2
-- 1.8-stud pop bounce on the placed brainrot when its slot is collected.
local COLLECT_POP_HEIGHT = 1.8
local COLLECT_POP_UP_INFO = TweenInfo.new(0.12, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local COLLECT_POP_DOWN_INFO = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- One-shot SFX clone-and-play. Same pattern as IslandBrainrotClient.playSfx so
-- each place / remove / open call is independent and never cancels another.
local function playSfx(soundName, volume)
	local source = SoundsFolder and SoundsFolder:FindFirstChild(soundName)
	if not source then return end
	local one = source:Clone()
	if volume then one.Volume = volume end
	one.Parent = SoundService
	one:Play()
	one.Ended:Once(function() one:Destroy() end)
	task.delay(5, function() if one.Parent then one:Destroy() end end)
end

local PodiumController = {}

-- Public reveal-state signals so other controllers (UpgradeController) can gate
-- their UIs on the at-the-pad unbox animation. revealingPodiums[idx] mirrors
-- visual.Unboxing for the local player's own podiums; RevealCompleted fires
-- with the podiumIndex when finish() runs. We track in a dedicated set
-- (instead of poking podiumVisuals which is declared later) so the public API
-- is reachable from external controllers without import-order surprises.
local revealingPodiums = {}
PodiumController.RevealCompleted = Instance.new("BindableEvent")
function PodiumController.IsRevealing(podiumIndex)
	podiumIndex = tonumber(podiumIndex) or podiumIndex
	return revealingPodiums[podiumIndex] == true
end

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local PodiumRemotes = Remotes:WaitForChild("PodiumService")
local PlaceBrainrotFunc = PodiumRemotes:WaitForChild("PlaceBrainrot")
local RemoveBrainrotFunc = PodiumRemotes:WaitForChild("RemoveBrainrot")
local SwapBrainrotFunc = PodiumRemotes:WaitForChild("SwapBrainrot")
local OpenPlacedLuckyBlockFunc = PodiumRemotes:WaitForChild("OpenPlacedLuckyBlock")

local LuckyBlockRemotes = Remotes:WaitForChild("LuckyBlockService")
local OpenResultEvent = LuckyBlockRemotes:WaitForChild("OpenResult")

local LUCKY_BLOCK_TEMPLATES = ReplicatedStorage:FindFirstChild("LuckyBlocks")
local CollectCashFunc = PodiumRemotes:WaitForChild("CollectCash")
local RequestPodiumDataFunc = PodiumRemotes:WaitForChild("RequestPodiumData")
local PodiumUpdateEvent = PodiumRemotes:WaitForChild("PodiumUpdate")
local CashAccumulateEvent = PodiumRemotes:WaitForChild("CashAccumulateUpdate")
local RequestAllPlotsDataFunc = PodiumRemotes:WaitForChild("RequestAllPlotsData")
local CollectOfflineCashFunc = PodiumRemotes:WaitForChild("CollectOfflineCash")
local OfflineCashEvent = PodiumRemotes:WaitForChild("OfflineCashUpdate")

-- Steal feature wires. StealBrainrot is the action invoke; StealNotification
-- is the thief-side toast hook. PodiumService creates StealNotification
-- lazily, so WaitForChild is safe.
local StealBrainrotFunc = PodiumRemotes:WaitForChild("StealBrainrot")
local StealNotificationEvent = PodiumRemotes:WaitForChild("StealNotification")

local InventoryRemotes = Remotes:WaitForChild("InventoryService")
local EquippedItemUpdateEvent = InventoryRemotes:WaitForChild("EquippedItemUpdate")
local RequestEquippedItemFunc = InventoryRemotes:WaitForChild("RequestEquippedItem")

local RebirthRemotes = Remotes:WaitForChild("RebirthService")
local RebirthUpdateEvent = RebirthRemotes:WaitForChild("RebirthUpdate")

-- New pack: ReplicatedStorage.Brainrots.<Rarity>.<MutationFolder>.<id>. The
-- legacy code reached into a flat folder via :FindFirstChild(modelName); the
-- helper below stays compatible by routing through GameConfig.GetBrainrotTemplate
-- which knows the rarity bucket for each id.
local BRAINROTS_FOLDER = ReplicatedStorage:WaitForChild("Brainrots")
local PLOTS_FOLDER = Workspace:WaitForChild("Assets"):WaitForChild("Plots")
local GradientFolder = ReplicatedStorage:WaitForChild("Gradients"):WaitForChild("Rarity")
local MutationGradientFolder = ReplicatedStorage:WaitForChild("Gradients"):WaitForChild("Type")
local MutationVFXFolder = ReplicatedStorage:WaitForChild("MutationVFX")
local PODIUM_MUTATION_VFX_ATTACHMENT = "PodiumMutationVFXAttachment"

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local podiumVisuals = {}
local podiumServerData = {}
local accumulatedCash = {}
local offlineCashPerPodium = {}

local cachedEquippedItemSummary = nil
local billboardTemplate = nil
local playerPlot = nil

local pendingOfflineCash = 0
local pendingOfflineCash = 0
local offlineCashCollected = false
local bestOwnPlacedCps = 0
local bestCpsChangedCallback = nil
local pendingOwnPrompt = false

local function makeKey(ownerUserId, podiumIndex)
	return tostring(ownerUserId) .. "_" .. podiumIndex
end

-- Sparse arrays sent over RemoteFunction are serialised as dicts with string keys.
-- Look up by both number and string so callers can use whichever they have.
local function podiumAt(podiums, idx)
	if not podiums then return nil end
	return podiums[idx] or podiums[tostring(idx)]
end

local function isOwnKey(key)
	return key:sub(1, #tostring(player.UserId) + 1) == tostring(player.UserId) .. "_"
end

local function recalcBestOwnPlacedCps()
	local best = 0
	for key, data in pairs(podiumServerData) do
		if isOwnKey(key) and data then
			local cfg = GameConfig.Items[data.BrainrotId]
			if cfg and not cfg.IsPercentBrainrot then
				local cps = data.CashPerSec or 0
				if cps > best then best = cps end
			end
		end
	end
	if best ~= bestOwnPlacedCps then
		bestOwnPlacedCps = best
		if bestCpsChangedCallback then bestCpsChangedCallback() end
	else
		bestOwnPlacedCps = best
	end
end

function PodiumController.GetBestPlacedNonPercentCps()
	return bestOwnPlacedCps
end

function PodiumController.OnBestCpsChanged(fn)
	bestCpsChangedCallback = fn
end
local function getPlayerPlot()
	if playerPlot and playerPlot.Parent then return playerPlot end
	for _, plot in ipairs(PLOTS_FOLDER:GetChildren()) do
		if plot:GetAttribute("OwnerUserId") == player.UserId then
			playerPlot = plot
			return plot
		end
	end
	playerPlot = nil
	return nil
end

local function getPlotByUserId(userId)
	for _, plot in ipairs(PLOTS_FOLDER:GetChildren()) do
		if plot:GetAttribute("OwnerUserId") == userId then
			return plot
		end
	end
	return nil
end

local function parsePodiumIndex(podiumModel)
	return tonumber(podiumModel.Name:match("Podium(%d+)"))
end

local function hasEquippedBrainrot()
	return cachedEquippedItemSummary ~= nil and cachedEquippedItemSummary.ItemType == "Brainrot"
end

local function hasEquippedLuckyBlock()
	if cachedEquippedItemSummary == nil or cachedEquippedItemSummary.ItemType ~= "LuckyBlock" then
		return false
	end
	-- Store loot blocks open in-hand (LootBlockController) and loot items are
	-- trophies; neither is placeable, so don't offer the pad Place/Swap prompt
	-- (the server rejects them anyway).
	local cfg = GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[cachedEquippedItemSummary.ItemId]
	if cfg and (cfg.IsLootBlock or cfg.IsLootItem) then
		return false
	end
	return true
end

local PLACED_SCALE = 0.63
-- 0 = placed brainrots/blocks rest on the slot surface (on the ground).
local FLOAT_HEIGHT = 0
-- Bumped 3.0 -> 3.5 per user request ("move them half a stud up"). Distance
-- between the brainrot bbox top and the billboard adornee.
local BILLBOARD_GAP = 3.5
local WIGGLE_DURATION = 0.8
local WIGGLE_AMP = 0.8

-- Continuous idle float for placed brainrots / lucky blocks. Sine-driven
-- vertical bob baked into the shared Heartbeat below.
-- FLOAT_AMP = half-range in studs; the actual motion swings between 0 (at
-- BaseCFrame) and 2 * FLOAT_AMP above it. Keeping the floor at exactly
-- BaseCFrame is what prevents the model from dipping into the pad on the
-- downstroke.
-- FLOAT_FREQ is cycles per second; 0.25 = a 4-second slow drift.
-- The phase shift off the key length keeps adjacent podiums slightly out
-- of sync so the row doesn't bob in lockstep.
local FLOAT_AMP = 0.25
local FLOAT_FREQ = 0.25

-- White outline-only highlight applied to every placed brainrot + lucky
-- Placed-brainrot highlight intentionally disabled. The outline read as noisy
-- White outline-only highlight for every plot brainrot, per user request:
-- no fill, just the outline silhouette so the model still reads through.
-- Recreated on each spawn (clearBrainrotModel doesn't auto-destroy it because
-- it lives on the model, not the visual table). DepthMode Occluded keeps the
-- outline behind walls instead of bleeding through plots viewed across the
-- map. AlwaysOnTop would punch through the floor and looks bad at distance.
local function applyPlacedHighlight(model)
	if not model then return end
	local existing = model:FindFirstChild("_PlacedHighlight")
	if existing then existing:Destroy() end

	local hl = Instance.new("Highlight")
	hl.Name = "_PlacedHighlight"
	hl.Adornee = model
	hl.FillTransparency = 1
	hl.OutlineTransparency = 0
	hl.OutlineColor = Color3.fromRGB(255, 255, 255)
	hl.DepthMode = Enum.HighlightDepthMode.Occluded
	hl.Parent = model
end

local function getCollectButtonPosition(podiumModel)
	if not podiumModel then return nil end
	local collectButton = podiumModel:FindFirstChild("CollectButton")
	if not collectButton then return nil end

	if collectButton:IsA("BasePart") then
		return collectButton.Position
	end

	local ok, pivot = pcall(function()
		return collectButton:GetPivot()
	end)
	if ok and pivot then
		return pivot.Position
	end

	for _, descendant in ipairs(collectButton:GetDescendants()) do
		if descendant:IsA("BasePart") then
			return descendant.Position
		end
	end
	return nil
end

-- Every brainrot rig is authored with its PrimaryPart / HumanoidRootPart's
-- local -Z as the creature's "front" (Roblox convention). Using that
-- universally gives consistent placed-brainrot orientation across every rig
-- -- the previous keyword scan ("eye", "head", "face", ...) gave wrong
-- results for any rig whose face parts weren't named with those keywords
-- AND for any rig whose face parts were at an unexpected offset.
--
-- Escape hatch for a rig authored backwards / sideways: set a `FaceAxis`
-- attribute on the rig itself in ReplicatedStorage.Brainrots:
--   model:SetAttribute("FaceAxis", "Z")   -- +Z is front
--   model:SetAttribute("FaceAxis", "X")   -- +X is front
--   model:SetAttribute("FaceAxis", "-X")  -- -X is front
-- Per-rig overrides for templates authored facing the wrong way. The FaceAxis
-- attribute is preferred (lives on the rig itself in ReplicatedStorage.Brainrots),
-- but maintaining attribute writes against a place that ships in Studio edit
-- mode is brittle, so name-based overrides cover the known offenders.
local FACE_AXIS_OVERRIDES = {
	["Spaghetti_Tualetti_Rig"] = "Z",
	-- Dragon_Cannelloni_Rig: authored with pivot rotated 90 degrees around Y
	-- relative to the mesh. In pivot-local space the mesh's forward axis is -X
	-- (he faces the OPPOSITE of pivot-local +X), so we tell the placement math
	-- that. "X" first sent his back to the collect button; "-X" turns him 180.
	["Dragon_Cannelloni_Rig"] = "-X",
}

local function detectModelFaceLocalDirection(model)
	local axis = model:GetAttribute("FaceAxis") or FACE_AXIS_OVERRIDES[model.Name]
	if axis == "Z" then return Vector3.new(0, 0, 1) end
	if axis == "X" then return Vector3.new(1, 0, 0) end
	if axis == "-X" then return Vector3.new(-1, 0, 0) end
	if axis == "-Z" then return Vector3.new(0, 0, -1) end
	return Vector3.new(0, 0, -1)
end

local function getBrainrotCFrameOnPlacePart(placePart, brainrotModel, podiumModel)
	if not placePart then return CFrame.new() end

	local topY = placePart.Position.Y + placePart.Size.Y / 2
	local boundsCF, modelSize = brainrotModel:GetBoundingBox()
	local currentPivot = brainrotModel:GetPivot()
	local pivotToBottom = currentPivot.Position.Y - (boundsCF.Position.Y - modelSize.Y / 2)

	local position = Vector3.new(placePart.Position.X, topY + pivotToBottom, placePart.Position.Z)
	local target = getCollectButtonPosition(podiumModel)

	local theta = 0
	if target then
		local toCB = Vector3.new(target.X - position.X, 0, target.Z - position.Z)
		if toCB.Magnitude >= 0.01 then
			local toCBunit = toCB.Unit
			local faceLocalDir = detectModelFaceLocalDirection(brainrotModel)
			local localAngle = math.atan2(faceLocalDir.Z, faceLocalDir.X)
			local worldAngle = math.atan2(toCBunit.Z, toCBunit.X)
			theta = localAngle - worldAngle
		end
	end

	-- Bbox-centering correction. The standard math above puts the PIVOT at the
	-- pad center, which is fine for rigs whose pivot sits at (bboxCenter.X,
	-- bboxCenter.Z). Dragon_Cannelloni_Rig (and any future off-pivot rig) has
	-- the pivot offset from the bbox in the horizontal plane, so the BODY ends
	-- up to one side of the pad. Subtract the rotated pivot-to-bbox offset in
	-- pivot-local space so the BBOX lands at the pad center instead. Y is left
	-- alone because pivotToBottom already handles ground fit.
	local pivotRot = currentPivot - currentPivot.Position -- rotation-only CFrame
	local worldOffset = boundsCF.Position - currentPivot.Position
	local localOffset = pivotRot:Inverse():VectorToWorldSpace(worldOffset)
	local finalRot = CFrame.Angles(0, theta, 0)
	local rotatedOffset = finalRot:VectorToWorldSpace(Vector3.new(localOffset.X, 0, localOffset.Z))
	position = Vector3.new(position.X - rotatedOffset.X, position.Y, position.Z - rotatedOffset.Z)

	return CFrame.new(position) * finalRot
end

local function getBillboardTemplate()
	if billboardTemplate then return billboardTemplate end
	local found = StarterGui:FindFirstChild("PodiumBillboard", true)
	if found and found:IsA("BillboardGui") then
		billboardTemplate = found
	end
	return billboardTemplate
end

local cashPodiumTemplate = nil
local function getCashPodiumTemplate()
	if cashPodiumTemplate then return cashPodiumTemplate end
	local found = StarterGui:FindFirstChild("CashPodium")
	if found and found:IsA("BillboardGui") then
		cashPodiumTemplate = found
	end
	return cashPodiumTemplate
end

-- Disable Roblox's auto-localization on every GuiBase2d descendant of a Gui clone.
-- The microprofiler showed `LocalizationServiceAttemptTranslationByExprMatchExecTime`
-- firing for every TextLabel on every visible BillboardGui as the camera moved,
-- which scales O(brainrots × labels-per-billboard) on camera rotation. Brainrot
-- names + cash strings don't need translation, so disable per-clone. AutoLocalize
-- on a child can override the parent's setting, so iterate every descendant.
local function disableAutoLocalize(root)
	root.AutoLocalize = false
	for _, desc in ipairs(root:GetDescendants()) do
		if desc:IsA("GuiBase2d") then
			desc.AutoLocalize = false
		end
	end
end

local function setLabelTextRaw(label, text)
	if not label then return end
	label.Text = text
	local inner = label:FindFirstChild("Inner")
	if inner and inner:IsA("TextLabel") then
		inner.Text = text
	end
end

local function ensureCashPodiumBillboard(visual)
	if visual.CashPodiumGui and visual.CashPodiumGui.Parent then return end
	if not visual.CollectPart then return end
	local tmpl = getCashPodiumTemplate()
	if not tmpl then return end
	local clone = tmpl:Clone()
	disableAutoLocalize(clone)
	clone.Parent = visual.CollectPart
	clone.Enabled = false
	visual.CashPodiumGui = clone
	visual.IncomeLabel = clone:FindFirstChild("Income")
	visual.OfflineRewardLabel = clone:FindFirstChild("OfflineReward")
	if visual.OfflineRewardLabel then
		visual.OfflineRewardLabel.Visible = false
	end
end

local function setCashPodiumVisible(visual, isVisible)
	if not visual.CashPodiumGui then return end
	visual.CashPodiumGui.Enabled = isVisible
end

local function ensureVisual(key, podiumModel)
	local v = podiumVisuals[key]
	if v then
		v.PodiumModel = podiumModel
		return v
	end
	v = { PodiumModel = podiumModel }
	podiumVisuals[key] = v
	return v
end

-- Forward declares so updatePromptState can reach the dedicated lucky-block
-- prompt builder defined alongside ensurePrompt below.
local ensureLuckyPrompts
local ensureBrainrotRemovePrompt

local function updatePromptState(visual, key)
	if not visual.Prompt then return end

	local isOwn = isOwnKey(key)
	local data = podiumServerData[key]
	local isOccupied = data ~= nil
	local isLuckyBlockOccupant = data and (data.ItemType == "LuckyBlock" or data.LuckyBlockId ~= nil)

	-- Opponent pad: the prompt is a Steal prompt. Just gate it on occupancy --
	-- no swap / remove / lucky-open variants to worry about, and there are no
	-- per-pad lucky open/remove prompts on opponent pads in the first place.
	if not isOwn then
		visual.Prompt.Enabled = isOccupied == true
		return
	end

	-- Mid-unbox: the pad is owned by the animation + its trigger handlers, so no
	-- prompt is interactable until PadUnboxing's onComplete clears the flag.
	-- Stuck-flag watchdog: if Unboxing has been true longer than 15s with no
	-- active UnboxHandle and no awaiting OpenResult, both safety nets missed
	-- (PadUnboxing errored mid-anim, server crashed during open, etc.) and the
	-- pad would otherwise stay frozen forever. Clear it and fall through to the
	-- normal prompt path so the player can interact again.
	if visual.Unboxing then
		local startedAt = visual.UnboxStartedAt
		if not visual.UnboxHandle and not visual.UnboxAwaitingResult
			and (not startedAt or (os.clock() - startedAt) > 15) then
			visual.Unboxing = false
			visual.UnboxStartedAt = nil
		else
			visual.Prompt.Enabled = false
			if visual.LuckyOpenPrompt then visual.LuckyOpenPrompt.Enabled = false end
			if visual.LuckyRemovePrompt then visual.LuckyRemovePrompt.Enabled = false end
			if visual.BrainrotRemovePrompt then visual.BrainrotRemovePrompt.Enabled = false end
			return
		end
	end

	if isOwn and isLuckyBlockOccupant then
		-- Lucky block placed: hide the shared brainrot prompt and show the two
		-- stacked dedicated prompts (Open on top = E, Remove below = X). Both
		-- are interactable the instant the block lands -- no countdown, no
		-- rarity wait, no "(Xs)" suffix on the ActionText.
		visual.Prompt.Enabled = false
		ensureLuckyPrompts(visual, key)
		if visual.LuckyOpenPrompt then
			visual.LuckyOpenPrompt.Enabled = true
			visual.LuckyOpenPrompt.ActionText = "Open"
		end
		if visual.LuckyRemovePrompt then visual.LuckyRemovePrompt.Enabled = true end
		-- A pad that USED to hold a brainrot may still have the X=Remove brainrot
		-- prompt parented; suppress it so it doesn't stack on top of LuckyRemove.
		if visual.BrainrotRemovePrompt then visual.BrainrotRemovePrompt.Enabled = false end
		return
	end

	-- Anything other than a lucky-block pad -> the dedicated prompts stay hidden.
	if visual.LuckyOpenPrompt then visual.LuckyOpenPrompt.Enabled = false end
	if visual.LuckyRemovePrompt then visual.LuckyRemovePrompt.Enabled = false end

	if isOwn then
		local hasBrainrot = hasEquippedBrainrot()
		local hasLucky = hasEquippedLuckyBlock()
		if isOccupied and (hasBrainrot or hasLucky) then
			-- Equipped-while-occupied = Swap. The brainrot-equipped path swaps
			-- the inventory + placed brainrots; the lucky-equipped path drops the
			-- brainrot into inventory and places the lucky block on the pad.
			visual.Prompt.ActionText = "Swap"
			visual.Prompt.Enabled = true
			-- Stacked X = Remove so the player can always pop the placed brainrot
			-- off without unequipping first. Without this, having anything equipped
			-- masks the Remove path.
			ensureBrainrotRemovePrompt(visual, key)
			if visual.BrainrotRemovePrompt then visual.BrainrotRemovePrompt.Enabled = true end
		elseif isOccupied then
			visual.Prompt.ActionText = "Remove"
			visual.Prompt.Enabled = true
			if visual.BrainrotRemovePrompt then visual.BrainrotRemovePrompt.Enabled = false end
		elseif not isOccupied and (hasBrainrot or hasLucky) then
			visual.Prompt.ActionText = "Place"
			visual.Prompt.Enabled = true
			if visual.BrainrotRemovePrompt then visual.BrainrotRemovePrompt.Enabled = false end
		else
			visual.Prompt.Enabled = false
			if visual.BrainrotRemovePrompt then visual.BrainrotRemovePrompt.Enabled = false end
		end
	else
		visual.Prompt.Enabled = false
		if visual.BrainrotRemovePrompt then visual.BrainrotRemovePrompt.Enabled = false end
	end
end

local refreshPodium

local function onOwnPromptTriggered(podiumIndex)
	-- Server-side validation rejects non-number indices (`type(podiumIndex) ~= "number"`).
	-- `podiumIndex` arrives here as a STRING when the closure was captured from a
	-- `PodiumUpdate` event (server keys `state.Podiums` by string to avoid sparse-array
	-- serialization). Normalize to number before any RemoteFunction invoke.
	podiumIndex = tonumber(podiumIndex) or podiumIndex

	if pendingOwnPrompt then return end
	pendingOwnPrompt = true

	local ok, err = pcall(function()
		local key = makeKey(player.UserId, podiumIndex)
		local data = podiumServerData[key]
		local isOccupied = data ~= nil
		local isLuckyBlockOccupant = data and (data.ItemType == "LuckyBlock" or data.LuckyBlockId ~= nil)
		local hasBrainrot = hasEquippedBrainrot()
		local hasLucky = hasEquippedLuckyBlock()

		if isLuckyBlockOccupant then
			-- Firework SFX removed (lucky-open feedback is now the confetti burst
			-- fired from the unbox reveal). This branch is dead anyway -- the main
			-- prompt is disabled for lucky pads.
			OpenPlacedLuckyBlockFunc:InvokeServer(podiumIndex)
			return
		end

		if isOccupied and (hasBrainrot or hasLucky) then
			-- Swap covers both brainrot-equipped and lucky-equipped cases now;
			-- the server distinguishes via validateEquippedBrainrot /
			-- validateEquippedLuckyBlock and routes accordingly.
			local okSwap = SwapBrainrotFunc:InvokeServer(podiumIndex)
			if okSwap then playSfx("PlaceSuccess", 0.6) end
		elseif isOccupied then
			local okRm = RemoveBrainrotFunc:InvokeServer(podiumIndex)
			if okRm then playSfx("PopUpSound", 0.6) end
		elseif hasBrainrot or hasLucky then
			local success = PlaceBrainrotFunc:InvokeServer(podiumIndex)
			if success then playSfx("PlaceSuccess", 0.7) end
			if not success then
				local okState, state = pcall(function()
					return RequestPodiumDataFunc:InvokeServer()
				end)
				if okState and state then
					refreshPodium(player.UserId, podiumIndex, podiumAt(state.Podiums, podiumIndex))
				end
			end
		end
	end)

	pendingOwnPrompt = false

	if not ok then
		warn(string.format("[PodiumController] onOwnPromptTriggered error on podium %s: %s", tostring(podiumIndex), tostring(err)))
	end
end

-- Tighter activation radius so the player only sees prompts for pads they're
-- effectively standing next to. 15 was wide enough that 3-4 "Press E" pads
-- were visible at once across a whole row.
local PLACE_DISTANCE = 8

-- A Lua reference can outlive the instance it points to (Destroy() doesn't
-- clear callers' upvalues). Treat a destroyed instance (Parent == nil) as if
-- the slot were empty so the prompt gets recreated against the new model.
local function isLive(inst)
	return inst ~= nil and inst.Parent ~= nil
end

local function ensurePrompt(visual, key, ownerUserId, podiumIndex)
	if isLive(visual.Prompt) then return end
	-- Stale prompt from a destroyed previous model. Clear so the rebuild path
	-- doesn't keep using the dead instance.
	visual.Prompt = nil

	local isOwn = (ownerUserId == player.UserId)

	local placePart = visual.PodiumModel:FindFirstChild("PlacePart")
	if not placePart or not placePart:IsA("BasePart") then return end

	-- Destroy any pre-existing ProximityPrompt instance on the PlacePart (e.g. the
	-- baked-in one shipped in the workspace) so we always work with a fresh prompt
	-- with known-good properties and a freshly-connected Triggered handler. Reusing
	-- a stale instance caused interactions to silently fail after rejoin.
	for _, descendant in ipairs(placePart:GetDescendants()) do
		if descendant:IsA("ProximityPrompt") then
			descendant:Destroy()
		end
	end

	local attachment = placePart:FindFirstChild("PlacePromptAttachment")
	if not attachment then
		attachment = Instance.new("Attachment")
		attachment.Name = "PlacePromptAttachment"
		attachment.CFrame = CFrame.new(0, 3, 0)
		attachment.Parent = placePart
	end

	if not isOwn then
		-- Opponent pad: attach a Steal prompt that only enables when the pad is
		-- occupied (driven from updatePromptState). Owner identity is captured
		-- in the upvalue so a closure reuse after a rebuild can't mislabel which
		-- victim's pad we're stealing from.
		local stealPrompt = Instance.new("ProximityPrompt")
		stealPrompt.ActionText = "Steal"
		stealPrompt.ObjectText = ""
		stealPrompt.HoldDuration = 0
		stealPrompt.MaxActivationDistance = PLACE_DISTANCE
		stealPrompt.RequiresLineOfSight = false
		stealPrompt.Style = Enum.ProximityPromptStyle.Custom
		stealPrompt.KeyboardKeyCode = Enum.KeyCode.E
		stealPrompt.Exclusivity = Enum.ProximityPromptExclusivity.OnePerButton
		stealPrompt.Parent = attachment
		stealPrompt.Enabled = false
		stealPrompt.Triggered:Connect(function(triggerPlayer)
			if triggerPlayer ~= player then return end
			pcall(function()
				StealBrainrotFunc:InvokeServer(ownerUserId, podiumIndex)
			end)
		end)
		visual.Prompt = stealPrompt
		updatePromptState(visual, key)
		return
	end

	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Place"
	prompt.ObjectText = ""
	prompt.HoldDuration = 0
	prompt.MaxActivationDistance = PLACE_DISTANCE
	prompt.RequiresLineOfSight = false
	prompt.Style = Enum.ProximityPromptStyle.Custom
	prompt.KeyboardKeyCode = Enum.KeyCode.E
	-- OnePerButton so only the closest pad's E prompt shows. AlwaysShow
	-- produced 3+ overlapping "Remove" widgets when multiple plot pads were
	-- in range simultaneously (image 15). Native closest-only is the clean
	-- behavior; the custom dedupe in ProximityPromptScript has been removed
	-- so this no longer interacts with a buggy stuck-blocker path.
	prompt.Exclusivity = Enum.ProximityPromptExclusivity.OnePerButton
	prompt.Parent = attachment
	prompt.Enabled = false

	prompt.Triggered:Connect(function(triggerPlayer)
		if triggerPlayer ~= player then return end
		onOwnPromptTriggered(podiumIndex)
	end)
	visual.Prompt = prompt
	-- Pre-create the stacked X = Remove prompt so it's available the instant the
	-- pad becomes occupied. Gating its creation on the equipped-state branch in
	-- updatePromptState created a race where some pads (the ones the player
	-- approached without anything equipped) never got the prompt at all,
	-- producing the "every other slot doesn't have Remove" pattern.
	ensureBrainrotRemovePrompt(visual, key)
	updatePromptState(visual, key)
end

-- Vertical offsets (studs) for the two stacked lucky-block prompts. The custom
-- ProximityPromptScript reads the "WorldOffsetY" attribute and applies it as
-- the billboard's StudsOffsetWorldSpace, so this is how we stack them.
local LUCKY_OPEN_OFFSET_Y = 1.6
local LUCKY_REMOVE_OFFSET_Y = -1.4

-- Consistent placed-brainrot sizing. Brainrot bounding boxes vary wildly on
-- which axis is longest (Cacto is tallest on Y, Mangolini/Orcalero/Dragon are
-- widest on X/Z), so the old max-dim fit made the wide ones stand short and
-- read tiny next to the tall ones. Fitting by HEIGHT makes every brainrot
-- stand the same height as the "perfect" green Cacto (7.5 studs), with a
-- ceiling so a very long model can't blow out horizontally.
-- Bumped from 7.5 to 9.5 -- user wanted placed brainrots even bigger.
-- Placed-on-podium brainrot scaling. Previous 9.5 / 14 values were sized
-- for the old, smaller-podium layout; on the current plots they
-- overflowed the pad and made the whole row feel oversized. 6.0 / 10.0
-- keeps tall rigs visible above the cash billboard without dominating the
-- plot.
local PLACED_TARGET_HEIGHT = 7.5
local PLACED_MAX_DIM_CEILING = 12.0
local function scaleBrainrotToPlaced(model)
	local _, sz = model:GetBoundingBox()
	local factor = PLACED_TARGET_HEIGHT / math.max(sz.Y, 0.01)
	local maxDim = math.max(sz.X, sz.Y, sz.Z, 0.01)
	if maxDim * factor > PLACED_MAX_DIM_CEILING then
		factor = PLACED_MAX_DIM_CEILING / maxDim
	end
	model:ScaleTo(model:GetScale() * factor)
end

-- Per-upgrade-level visual scale modifier. PodiumService caps brainrot levels
-- at MAX_BRAINROT_LEVEL (= 100), and the visual ramp tracks that exactly:
-- level 1 = 1.0x, level 100 = 1.5x, linearly interpolated. Applied AFTER
-- scaleBrainrotToPlaced so the standard size is the baseline.
local LEVEL_SCALE_MAX = 1.5
local LEVEL_SCALE_RAMP_END = 100
local function getLevelScaleFactor(level)
	if not level or level <= 1 then return 1.0 end
	local t = math.min(1, (level - 1) / (LEVEL_SCALE_RAMP_END - 1))
	return 1.0 + (LEVEL_SCALE_MAX - 1.0) * t
end

-- Resting pivot for a winner brainrot on this pad -- mirrors the transform
-- spawnBrainrotModel settles the real model at, so the cosmetic reveal model
-- can converge to the exact same spot for a seamless handoff.
local function computeLuckyRestCFrame(visual, brainrotId)
	local placePart = visual.PodiumModel and visual.PodiumModel:FindFirstChild("PlacePart")
	if not placePart then return nil end
	local cfg = GameConfig.Items[brainrotId]
	local modelName = (cfg and cfg.ModelName) or brainrotId
	local template = GameConfig.GetBrainrotTemplate and GameConfig.GetBrainrotTemplate(modelName, nil)
	if not template then
		local topY = placePart.Position.Y + placePart.Size.Y / 2
		return CFrame.new(placePart.Position.X, topY + FLOAT_HEIGHT, placePart.Position.Z)
	end
	local m = template:Clone()
	for _, d in ipairs(m:GetDescendants()) do
		if d:IsA("KeyframeSequence") then d:Destroy() end
	end
	if not m.PrimaryPart then
		m.PrimaryPart = m:FindFirstChild("HumanoidRootPart") or m:FindFirstChildWhichIsA("BasePart")
	end
	pcall(function()
		scaleBrainrotToPlaced(m)
	end)
	local groundCF = getBrainrotCFrameOnPlacePart(placePart, m, visual.PodiumModel)
	m:Destroy()
	return groundCF * CFrame.new(0, FLOAT_HEIGHT, 0)
end

local function onLuckyRemoveTriggered(podiumIndex)
	podiumIndex = tonumber(podiumIndex) or podiumIndex
	local key = makeKey(player.UserId, podiumIndex)
	local visual = podiumVisuals[key]
	if visual and visual.Unboxing then return end
	local data = podiumServerData[key]
	if not data or not (data.ItemType == "LuckyBlock" or data.LuckyBlockId) then return end
	-- Server's onRemoveBrainrot hands the block back to inventory for lucky pads.
	local ok = RemoveBrainrotFunc:InvokeServer(podiumIndex)
	if ok then playSfx("PopUpSound", 0.6) end
end

local function onLuckyOpenTriggered(podiumIndex)
	podiumIndex = tonumber(podiumIndex) or podiumIndex
	local key = makeKey(player.UserId, podiumIndex)
	local visual = podiumVisuals[key]
	if not visual or visual.Unboxing then return end
	local data = podiumServerData[key]
	if not data or not (data.ItemType == "LuckyBlock" or data.LuckyBlockId) then return end

	-- Lock the pad into the unbox flow up-front -- before the server round trip
	-- or any PodiumUpdate can land -- so the committed brainrot is held back
	-- until the reveal finishes.
	visual.Unboxing = true
	visual.UnboxAwaitingResult = true
	visual.UnboxStartedAt = os.clock()
	if visual.LuckyOpenPrompt then visual.LuckyOpenPrompt.Enabled = false end
	if visual.LuckyRemovePrompt then visual.LuckyRemovePrompt.Enabled = false end

	-- Pop the placed lucky-block model away (it is being cracked open).
	if visual.Model then
		local m = visual.Model
		visual.Model = nil
		local s0 = m:GetScale()
		task.spawn(function()
			local st = os.clock()
			while os.clock() - st < 0.18 do
				RunService.Heartbeat:Wait()
				if not m.Parent then return end
				local t = math.min((os.clock() - st) / 0.18, 1)
				m:ScaleTo(math.max(s0 * (1 - t), 0.001))
			end
			if m.Parent then m:Destroy() end
		end)
	end
	if visual.Billboard then visual.Billboard:Destroy(); visual.Billboard = nil end

	local ok = OpenPlacedLuckyBlockFunc:InvokeServer(podiumIndex)
	if ok then
		-- (firework SFX removed; the confetti burst fires from the unbox reveal)
		-- Safety net: OpenResult is fired synchronously by the server before it
		-- returns true, so this should never fire -- but never leave a pad frozen.
		task.delay(8, function()
			if visual.UnboxAwaitingResult then
				visual.UnboxAwaitingResult = false
				visual.Unboxing = false
				local d = visual.PendingPostUnboxData
				visual.PendingPostUnboxData = nil
				refreshPodium(player.UserId, podiumIndex, d or podiumServerData[key])
			end
		end)
	else
		visual.Unboxing = false
		visual.UnboxAwaitingResult = false
		local okState, state = pcall(function() return RequestPodiumDataFunc:InvokeServer() end)
		if okState and state then
			refreshPodium(player.UserId, podiumIndex, podiumAt(state.Podiums, podiumIndex))
		end
	end
end

local function makeLuckyPrompt(attachment, actionText, keyCode, worldOffsetY, podiumIndex, onTrigger)
	local p = Instance.new("ProximityPrompt")
	p.ActionText = actionText
	p.ObjectText = ""
	p.HoldDuration = 0
	p.MaxActivationDistance = PLACE_DISTANCE
	p.RequiresLineOfSight = false
	p.Style = Enum.ProximityPromptStyle.Custom
	p.KeyboardKeyCode = keyCode
	-- OnePerButton: Roblox shows only the closest in-range prompt per key, so
	-- standing between multiple pads gives one clean prompt for the pad you're
	-- actually closest to instead of three overlapping "Remove" widgets. The
	-- stacked Open(E)/Remove(X) pair on a single lucky pad still works because
	-- they have DIFFERENT keys; OnePerButton only dedupes within a key.
	p.Exclusivity = Enum.ProximityPromptExclusivity.OnePerButton
	p:SetAttribute("WorldOffsetY", worldOffsetY)
	p.Enabled = false
	p.Parent = attachment
	p.Triggered:Connect(function(triggerPlayer)
		if triggerPlayer ~= player then return end
		onTrigger(podiumIndex)
	end)
	return p
end

function ensureLuckyPrompts(visual, key)
	-- Clear stale references whose underlying ProximityPrompt was destroyed
	-- (e.g. when the podium model was streamed out / rebuilt). Without this,
	-- the early-return below kept the dead reference forever and the lucky
	-- pad's E/X prompts never re-appeared after a rebuild.
	if not isLive(visual.LuckyOpenPrompt) then visual.LuckyOpenPrompt = nil end
	if not isLive(visual.LuckyRemovePrompt) then visual.LuckyRemovePrompt = nil end
	if visual.LuckyOpenPrompt and visual.LuckyRemovePrompt then return end
	local podiumIndex = tonumber(key:match("_(%d+)$"))
	if not podiumIndex then return end
	local placePart = visual.PodiumModel and visual.PodiumModel:FindFirstChild("PlacePart")
	if not placePart or not placePart:IsA("BasePart") then return end
	-- Share the main prompt's attachment; the two are separated vertically via
	-- their WorldOffsetY attribute.
	local attachment = placePart:FindFirstChild("PlacePromptAttachment")
	if not attachment then
		attachment = Instance.new("Attachment")
		attachment.Name = "PlacePromptAttachment"
		attachment.CFrame = CFrame.new(0, 3, 0)
		attachment.Parent = placePart
	end
	if not visual.LuckyOpenPrompt then
		visual.LuckyOpenPrompt = makeLuckyPrompt(attachment, "Open", Enum.KeyCode.E, LUCKY_OPEN_OFFSET_Y, podiumIndex, onLuckyOpenTriggered)
	end
	if not visual.LuckyRemovePrompt then
		visual.LuckyRemovePrompt = makeLuckyPrompt(attachment, "Remove", Enum.KeyCode.X, LUCKY_REMOVE_OFFSET_Y, podiumIndex, onLuckyRemoveTriggered)
	end
end

-- Standalone X = Remove for non-lucky brainrot pads. Sits below the main E
-- prompt so the player always has a dedicated Remove regardless of what's
-- equipped (otherwise an equipped brainrot / lucky block forces E into Swap
-- mode and leaves no way to just remove).
-- Vertical offset (studs) for the stacked X = Remove prompt under the main E
-- prompt. The attachment lives ~+3 above placePart and the main prompt sits
-- there with no override, so this -2.8 puts the X bubble ~3 studs below E --
-- matching the lucky pad's Open/Remove spacing and keeping the two prompt
-- bubbles from visually overlapping. Was -1.4 (too tight, prompts stacked).
local BRAINROT_REMOVE_OFFSET_Y = -2.8

local function onBrainrotRemoveTriggered(podiumIndex)
	podiumIndex = tonumber(podiumIndex) or podiumIndex
	local key = makeKey(player.UserId, podiumIndex)
	local data = podiumServerData[key]
	if not data then return end
	-- Lucky-block pads have their own LuckyRemovePrompt; never fire from here.
	if data.ItemType == "LuckyBlock" or data.LuckyBlockId then return end
	local ok = RemoveBrainrotFunc:InvokeServer(podiumIndex)
	if ok then playSfx("PopUpSound", 0.6) end
end

function ensureBrainrotRemovePrompt(visual, key)
	if not isLive(visual.BrainrotRemovePrompt) then visual.BrainrotRemovePrompt = nil end
	if visual.BrainrotRemovePrompt then return end
	local podiumIndex = tonumber(key:match("_(%d+)$"))
	if not podiumIndex then return end
	local placePart = visual.PodiumModel and visual.PodiumModel:FindFirstChild("PlacePart")
	if not placePart or not placePart:IsA("BasePart") then return end
	local attachment = placePart:FindFirstChild("PlacePromptAttachment")
	if not attachment then
		attachment = Instance.new("Attachment")
		attachment.Name = "PlacePromptAttachment"
		attachment.CFrame = CFrame.new(0, 3, 0)
		attachment.Parent = placePart
	end
	visual.BrainrotRemovePrompt = makeLuckyPrompt(attachment, "Remove", Enum.KeyCode.X, BRAINROT_REMOVE_OFFSET_Y, podiumIndex, onBrainrotRemoveTriggered)
end

local CASH_PITCH_BASE = 1.0
local CASH_PITCH_STEP = 0.05
local CASH_PITCH_MAX = 1.4
local CASH_COMBO_RESET_AFTER = 1.0
local cashCombo = 0
local cashComboResetToken = 0

local function playCashWithCombo()
	if not CashCollectSound then return end
	cashCombo = cashCombo + 1
	local pitch = math.min(CASH_PITCH_BASE + (cashCombo - 1) * CASH_PITCH_STEP, CASH_PITCH_MAX)
	local s = CashCollectSound:Clone()
	s.PlaybackSpeed = pitch
	s.Parent = SoundService
	s:Play()
	s.Ended:Once(function() s:Destroy() end)
	task.delay(5, function() if s.Parent then s:Destroy() end end)

	cashComboResetToken = cashComboResetToken + 1
	local token = cashComboResetToken
	task.delay(CASH_COMBO_RESET_AFTER, function()
		if token == cashComboResetToken then
			cashCombo = 0
		end
	end)
end

-- Cash-collect VFX template lookup: prefer workspace.Assets.Vfx.Money (drop the
-- Part from the source project here for the exact source visuals), otherwise fall
-- back to the existing ReplicatedStorage.Effects.Collect attachment which we adapt
-- to the same weld-to-character pattern as the source.
local function findCollectVfxTemplate()
	local assets = Workspace:FindFirstChild("Assets")
	local vfxFolder = assets and assets:FindFirstChild("Vfx")
	local sourceStyle = vfxFolder and vfxFolder:FindFirstChild("Money")
	if sourceStyle then return sourceStyle, "part" end
	if CollectAttachment then return CollectAttachment, "attachment" end
	return nil, nil
end

-- Source-styled cash burst: clone the Vfx.Money Part, weld to the local player's
-- HumanoidRootPart, scale every emitter's Size keypoints by COLLECT_SIZE_BOOST and
-- emit floor(EmitCount * COLLECT_COUNT_BOOST). Falls back to the original
-- attachment-on-brainrot-HRP path if Vfx.Money isn't present yet.
local function spawnCollectVfx(visual)
	local template, kind = findCollectVfxTemplate()
	if not template then return end

	if kind == "attachment" then
		local hrp = visual.Model and visual.Model:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		local attachClone = template:Clone()
		attachClone.Parent = hrp
		local longestLifetime = 0
		for _, d in ipairs(attachClone:GetDescendants()) do
			if d:IsA("ParticleEmitter") then
				local newKeys = {}
				for _, kp in ipairs(d.Size.Keypoints) do
					table.insert(newKeys, NumberSequenceKeypoint.new(
						kp.Time,
						kp.Value * COLLECT_SIZE_BOOST,
						kp.Envelope * COLLECT_SIZE_BOOST
					))
				end
				d.Size = NumberSequence.new(newKeys)
				local baseCount = d.Name == "Effect_WhiteGlow" and 1 or 15
				d:Emit(math.floor(baseCount * COLLECT_COUNT_BOOST))
				if d.Lifetime.Max > longestLifetime then
					longestLifetime = d.Lifetime.Max
				end
			end
		end
		Debris:AddItem(attachClone, longestLifetime + 0.5)
		return
	end

	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local clone = template:Clone()
	clone.Name = "MoneyVfxBurst"
	clone.Anchored = false
	clone.CanCollide = false
	clone.CanTouch = false
	clone.CanQuery = false
	clone.Massless = true
	clone.Transparency = 1
	clone.Size = Vector3.new(0.2, 0.2, 0.2)
	clone.CFrame = hrp.CFrame
	clone.Parent = workspace

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = hrp
	weld.Part1 = clone
	weld.Parent = clone

	local longestLifetime = 0
	for _, d in ipairs(clone:GetDescendants()) do
		if d:IsA("ParticleEmitter") then
			local newKeys = {}
			for _, kp in ipairs(d.Size.Keypoints) do
				table.insert(newKeys, NumberSequenceKeypoint.new(
					kp.Time,
					kp.Value * COLLECT_SIZE_BOOST,
					kp.Envelope * COLLECT_SIZE_BOOST
				))
			end
			d.Size = NumberSequence.new(newKeys)
			local count = (d:GetAttribute("EmitCount") or 5) * COLLECT_COUNT_BOOST
			d.Enabled = false
			d:Emit(math.floor(count))
			if d.Lifetime.Max > longestLifetime then
				longestLifetime = d.Lifetime.Max
			end
		end
	end
	Debris:AddItem(clone, longestLifetime + 0.5)
end

-- Brainrot pop bounce: tween PrimaryPart up COLLECT_POP_HEIGHT studs then back to
-- the resting CFrame. Skipped if the wiggle from a recent upgrade is in flight
-- (the two PivotTo/CFrame writers would fight).
local function popBrainrotOnCollect(visual)
	local model = visual.Model
	if not model or not model.PrimaryPart then return end
	if visual._wiggleEndAt and os.clock() < visual._wiggleEndAt then return end
	local primary = model.PrimaryPart
	local origCF = primary.CFrame
	local upTween = TweenService:Create(primary, COLLECT_POP_UP_INFO, {
		CFrame = origCF + Vector3.new(0, COLLECT_POP_HEIGHT, 0),
	})
	upTween:Play()
	upTween.Completed:Once(function()
		if primary.Parent then
			TweenService:Create(primary, COLLECT_POP_DOWN_INFO, { CFrame = origCF }):Play()
		end
	end)
end

local COLLECT_PRESS_DEPTH = 0.3
local COLLECT_PRESS_DOWN_INFO = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local COLLECT_PRESS_UP_INFO = TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local COLLECT_FLASH_UP_INFO = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local COLLECT_FLASH_DOWN_INFO = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function pressCollectPart(part)
	if not part or not part:IsA("BasePart") then return end
	if part:GetAttribute("PodiumPressing") then return end
	part:SetAttribute("PodiumPressing", true)

	local restCFrame = part:GetAttribute("PodiumRestCFrame")
	if not restCFrame then
		part:SetAttribute("PodiumRestCFrame", part.CFrame)
		restCFrame = part.CFrame
	end

	local downCFrame = restCFrame * CFrame.new(0, -COLLECT_PRESS_DEPTH, 0)
	local down = TweenService:Create(part, COLLECT_PRESS_DOWN_INFO, { CFrame = downCFrame })
	down:Play()
	down.Completed:Once(function()
		local up = TweenService:Create(part, COLLECT_PRESS_UP_INFO, { CFrame = restCFrame })
		up:Play()
		up.Completed:Once(function()
			part:SetAttribute("PodiumPressing", nil)
		end)
	end)
end

local function flashCollectPart(part)
	if not part or not part:IsA("BasePart") then return end
	local originalColor = part:GetAttribute("PodiumRestColor")
	if not originalColor then
		originalColor = part.Color
		part:SetAttribute("PodiumRestColor", originalColor)
	end
	local up = TweenService:Create(part, COLLECT_FLASH_UP_INFO, { Color = Color3.new(1, 1, 1) })
	up:Play()
	up.Completed:Once(function()
		TweenService:Create(part, COLLECT_FLASH_DOWN_INFO, { Color = originalColor }):Play()
	end)
end

local CASH_PICKUP_IMAGE_ID = "rbxassetid://128499103360164"
local CASH_PICKUP_COUNT = 6

local function getCashHudScreenCenter(plr)
	local pg = plr:FindFirstChildOfClass("PlayerGui")
	local gui = pg and pg:FindFirstChild("GUI")
	local hud = gui and gui:FindFirstChild("HUD")
	local leftDown = hud and hud:FindFirstChild("LeftDownSide")
	local cash = leftDown and leftDown:FindFirstChild("Cash")
	if not cash then
		return nil
	end
	return cash.AbsolutePosition + cash.AbsoluteSize / 2
end

local function ensureCashFlyGui(plr)
	local pg = plr:FindFirstChildOfClass("PlayerGui")
	if not pg then
		return nil
	end
	local gui = pg:FindFirstChild("_PodiumCashFly")
	if gui then
		return gui
	end
	gui = Instance.new("ScreenGui")
	gui.Name = "_PodiumCashFly"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 100
	gui.Parent = pg
	return gui
end

local function spawnFlyingCashPickup(plr, startScreen)
	local flyGui = ensureCashFlyGui(plr)
	if not flyGui then
		return
	end

	-- Bumped from 44 -> 70 per user request -- the previous icons were
	-- barely-readable specks against the world; scatter/fly tweens scale
	-- relative to this so they keep their original arc.
	local size = 70
	local image = Instance.new("ImageLabel")
	image.Image = CASH_PICKUP_IMAGE_ID
	image.BackgroundTransparency = 1
	image.AnchorPoint = Vector2.new(0.5, 0.5)
	image.Size = UDim2.new(0, size, 0, size)
	image.Position = UDim2.new(0, startScreen.X, 0, startScreen.Y)
	image.Parent = flyGui

	local scatter = Vector2.new(math.random(-50, 50), math.random(-60, -10))
	local scatterPos = startScreen + scatter

	local scatterTween = TweenService:Create(image, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.new(0, scatterPos.X, 0, scatterPos.Y),
		Size = UDim2.new(0, size * 1.15, 0, size * 1.15),
	})
	scatterTween:Play()
	scatterTween.Completed:Once(function()
		local target = getCashHudScreenCenter(plr)
		if not target then
			image:Destroy()
			return
		end
		local flyTween = TweenService:Create(image, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Position = UDim2.new(0, target.X, 0, target.Y),
			Size = UDim2.new(0, size * 0.55, 0, size * 0.55),
			ImageTransparency = 0.2,
		})
		flyTween:Play()
		flyTween.Completed:Once(function()
			image:Destroy()
		end)
	end)
end

local function flyCashPickups(plr, worldPos, count)
	local cam = Workspace.CurrentCamera
	if not cam then
		return
	end
	local screenPos = cam:WorldToScreenPoint(worldPos)
	local start = Vector2.new(screenPos.X, screenPos.Y)
	for i = 1, count do
		task.delay((i - 1) * 0.06, function()
			spawnFlyingCashPickup(plr, start)
		end)
	end
end

local function ensureCollectButton(visual, podiumIndex)
	local collectButton = visual.PodiumModel:FindFirstChild("CollectButton")
	if not collectButton then return end

	local collectPart = collectButton:FindFirstChild("CollectPart")
	if not collectPart then
		for _, desc in ipairs(collectButton:GetDescendants()) do
			if desc:IsA("BasePart") and desc.Name == "CollectPart" then
				collectPart = desc
				break
			end
		end
	end
	visual.CollectPart = collectPart

	ensureCashPodiumBillboard(visual)

	if visual.CollectConnected then return end

	-- Touched fires repeatedly while a character stands on the pad (multiple
	-- body parts, animation micro-movement, physics). A plain time debounce
	-- would let the cooldown expire while still standing on the pad and re-
	-- collect every cycle, which made the billboard flicker 0 -> cps -> 0 -> cps
	-- forever. Gate collect on "player has fully stepped off" instead: track
	-- every character part currently touching the pad and only allow the next
	-- collect once that set becomes empty.
	local touchingParts = {}
	local animLocked = false

	local function isCharacterTouch(hit)
		local character = player.Character
		if not character then return false end
		return hit:IsDescendantOf(character)
			or hit:FindFirstAncestor("HeldBrainrot") ~= nil
			or hit:FindFirstAncestor("EquippedVisual") ~= nil
	end

	local function runCollect()
		if animLocked then return end
		animLocked = true

		pressCollectPart(visual.CollectPart)

		local collectedSomething = false

		local offlineAmount = offlineCashPerPodium[podiumIndex] or 0
		if offlineAmount > 0 then
			local offOk, offCollected = CollectOfflineCashFunc:InvokeServer(podiumIndex)
			if offOk then
				offlineCashPerPodium[podiumIndex] = nil
				if visual.OfflineRewardLabel then
					visual.OfflineRewardLabel.Visible = false
				end
				collectedSomething = true
			end
		end

		local success, collected = CollectCashFunc:InvokeServer(podiumIndex)
		if success then
			collectedSomething = true
			if SettingsController.IsBrainrotVfxEnabled() and visual.Model then
				task.spawn(function() spawnCollectVfx(visual) end)
				task.spawn(function() popBrainrotOnCollect(visual) end)
			end
		end

		if collectedSomething then
			flashCollectPart(visual.CollectPart)
			playCashWithCombo()

			local startPart = visual.CollectPart or visual.PodiumModel and visual.PodiumModel.PrimaryPart
			local startPos
			if startPart and startPart:IsA("BasePart") then
				startPos = startPart.Position
			elseif visual.PodiumModel then
				startPos = visual.PodiumModel:GetPivot().Position
			end
			if startPos then
				flyCashPickups(player, startPos, CASH_PICKUP_COUNT)
			end
		end

		local pressDuration = COLLECT_PRESS_DOWN_INFO.Time + COLLECT_PRESS_UP_INFO.Time
		local flashDuration = COLLECT_FLASH_UP_INFO.Time + COLLECT_FLASH_DOWN_INFO.Time
		local animDuration = math.max(pressDuration, flashDuration)
		task.delay(animDuration + 0.05, function() animLocked = false end)
	end

	local function onTouched(hit)
		if not isCharacterTouch(hit) then return end
		local wasEmpty = next(touchingParts) == nil
		touchingParts[hit] = true
		if wasEmpty then
			runCollect()
		end
	end

	local function onTouchEnded(hit)
		if touchingParts[hit] then
			touchingParts[hit] = nil
		end
	end

	-- Character removal/respawn leaves stale references in touchingParts that
	-- will never see a TouchEnded (body parts are destroyed mid-touch on death).
	-- Without this, a player who dies while standing on a pad would not be able
	-- to collect again after respawn because the set would never empty.
	player.CharacterRemoving:Connect(function()
		touchingParts = {}
	end)
	player.CharacterAdded:Connect(function()
		touchingParts = {}
	end)

	local connectedParts = {}
	local function connectPart(part)
		if connectedParts[part] then return end
		if not part:IsA("BasePart") then return end
		connectedParts[part] = true
		part.Touched:Connect(onTouched)
		part.TouchEnded:Connect(onTouchEnded)
	end

	for _, part in ipairs(collectButton:GetDescendants()) do
		connectPart(part)
	end
	if collectButton:IsA("BasePart") then
		connectPart(collectButton)
	end

	collectButton.DescendantAdded:Connect(function(desc)
		connectPart(desc)
	end)

	visual.CollectConnected = true
end

local function stopAnimation(visual)
	if visual.AnimTrack then
		visual.AnimTrack:Stop(0.2)
		visual.AnimTrack = nil
	end
end

-- Hover sway + visibility cull removed (2026-05-18). The previous design had a
-- single RunService.Heartbeat connection iterating every placed visual every
-- frame, computing camera distance, and either PivotTo'ing the rig for the
-- bobbing sway OR detaching the model from workspace for visibility cull. With
-- many brainrots in view this was the dominant remaining per-frame script cost.
-- Brainrots now stay at BaseCFrame (no whole-body bobbing); the Motor6D Idle
-- animation still plays and provides per-frame liveliness via Roblox's engine
-- (not Lua). Wiggle on upgrade is now a self-contained task.spawn one-shot.
-- startHoverLoop / stopHoverLoop are no-ops kept for backwards compatibility
-- with the existing call sites in spawnBrainrotModel and clearBrainrotModel.
local function startHoverLoop(visual, podiumIndex) end
local function stopHoverLoop(visual) end

local function triggerWiggle(visual)
	if not visual.Model or not visual.Model.PrimaryPart then return end
	if not visual.BaseCFrame then return end

	-- Token cancels any in-flight wiggle from a prior upgrade on the same
	-- visual — only the latest wiggle drives PivotTo at any moment.
	visual._wiggleToken = (visual._wiggleToken or 0) + 1
	-- Tell the shared Heartbeat float loop to back off for the duration of
	-- the wiggle so the two PivotTo writers don't fight per frame.
	visual._wiggleEndAt = os.clock() + WIGGLE_DURATION
	local token = visual._wiggleToken
	local model = visual.Model

	task.spawn(function()
		local startTime = os.clock()
		while true do
			local elapsed = os.clock() - startTime
			if elapsed >= WIGGLE_DURATION then break end
			if visual._wiggleToken ~= token then return end
			if visual.Model ~= model or not visual.BaseCFrame then return end
			local progress = elapsed / WIGGLE_DURATION
			local wiggleY = math.sin(progress * math.pi * 5) * (1 - progress) * WIGGLE_AMP
			model:PivotTo(visual.BaseCFrame * CFrame.new(0, wiggleY, 0))
			task.wait()
		end
		if visual.Model == model and visual.BaseCFrame then
			model:PivotTo(visual.BaseCFrame)
		end
	end)
end

local function playUpgradeSfx()
	local pg = player:FindFirstChildOfClass("PlayerGui")
	if not pg then return end
	local sound = Instance.new("Sound")
	sound.SoundId = UPGRADE_SFX_ID
	sound.Volume = UPGRADE_SFX_VOLUME
	sound.Parent = pg
	sound:Play()
	sound.Ended:Once(function() sound:Destroy() end)
	Debris:AddItem(sound, 5)
end

-- Original upgrade VFX (per user: keep the old VFX on upgrade — only the SOUND
-- was ported from the source project). Anchored + parked in workspace so the
-- emit can't pollute Model:GetBoundingBox() reads on the brainrot model.
local function triggerUpgradeVFX(visual)
	if not visual.Model or not visual.Model.PrimaryPart then return end
	if not EffectsFolder then return end
	local template = EffectsFolder:FindFirstChild("Upgrade")
	if not template then return end

	local clone = template:Clone()
	clone.Anchored = true
	clone.CanCollide = false
	clone.CanQuery = false
	clone.CanTouch = false
	clone.CFrame = visual.Model:GetPivot()
	clone.Parent = workspace

	for _, emitter in ipairs(clone:GetDescendants()) do
		if emitter:IsA("ParticleEmitter") then
			emitter:Emit(emitter:GetAttribute("EmitCount") or 1)
		end
	end

	task.delay(3, function()
		clone:Destroy()
	end)
end

function PodiumController.TriggerUpgradeFX(podiumIndex)
	local key = makeKey(player.UserId, podiumIndex)
	local visual = podiumVisuals[key]
	if not visual then return end
	playUpgradeSfx()
	triggerWiggle(visual)
	triggerUpgradeVFX(visual)
end

local function playBrainrotAnimation(visual, model, animationId)
	stopAnimation(visual)
	if not SettingsController.IsBrainrotVfxEnabled() then return end

	local resolvedId = animationId
	if not resolvedId or resolvedId == "" then
		for _, d in ipairs(model:GetDescendants()) do
			if d:IsA("Animation") and d.Name == "Idle" then
				resolvedId = d.AnimationId
				break
			end
		end
	end
	if not resolvedId or resolvedId == "" then return end

	local animController = model:FindFirstChildWhichIsA("Humanoid", true) or model:FindFirstChildWhichIsA("AnimationController", true)
	if not animController then return end

	local animator = animController:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = animController
	end
	-- Built-in distance LOD: Roblox auto-reduces evaluation rate for distant /
	-- offscreen Animators. Free perf on top of our manual cull.
	pcall(function()
		animator.PreferLodEnabled = true
	end)

	local anim = Instance.new("Animation")
	anim.AnimationId = resolvedId
	local track = animator:LoadAnimation(anim)
	track.Looped = true
	track:Play()
	anim:Destroy()

	visual.AnimTrack = track
end


local function clearBrainrotModel(visual)
	visual._retryKey = nil
	-- A teardown (plot cleared / owner left / re-place) aborts any running
	-- pad unbox so it can't keep animating against a dead visual.
	if visual.UnboxHandle then
		visual.UnboxHandle.cancelled = true
		visual.UnboxHandle = nil
	end
	visual.Unboxing = false
	visual.UnboxAwaitingResult = false
	visual.UnboxStartedAt = nil
	visual.PendingPostUnboxData = nil
	stopAnimation(visual)
	stopHoverLoop(visual)
	if visual.HoverConn then
		visual.HoverConn:Disconnect()
		visual.HoverConn = nil
	end
	visual.LuckyBlockOpenAt = nil
	visual.BaseCFrame = nil
	if visual.Billboard then
		visual.Billboard:Destroy()
		visual.Billboard = nil
	end
	if visual.Model then
		visual.Model:Destroy()
		visual.Model = nil
	end
end

local function setLabelText(label, text)
	if not label then
		return
	end
	label.Text = text
	local inner = label:FindFirstChild("Inner")
	if inner then
		inner.Text = text
	end
end

local function setupBillboard(model, data)
	local tmpl = getBillboardTemplate()
	if not tmpl then return nil end

	local rootPart = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
	if not rootPart then return nil end

	local bbCF, bbSize = model:GetBoundingBox()
	local bbTopY = bbCF.Position.Y + bbSize.Y / 2
	local attachment = rootPart:FindFirstChild("PodiumBillboardAttachment")
	if not attachment then
		attachment = Instance.new("Attachment")
		attachment.Name = "PodiumBillboardAttachment"
		attachment.Parent = rootPart
	end
	attachment.WorldCFrame = CFrame.new(bbCF.Position.X, bbTopY, bbCF.Position.Z)

	local billboard = tmpl:Clone()
	disableAutoLocalize(billboard)
	billboard.StudsOffsetWorldSpace = Vector3.new(0, BILLBOARD_GAP, 0)
	-- Scale the overhead a bit bigger than the template authored size. The
	-- placed-brainrot overhead is the player's main readable label for a pad
	-- (name + income + level), and the template targets a smaller world
	-- footprint than works well at typical 3rd-person camera distances.
	local BILLBOARD_SIZE_SCALE = 1.2
	billboard.Size = UDim2.new(
		billboard.Size.X.Scale * BILLBOARD_SIZE_SCALE,
		billboard.Size.X.Offset * BILLBOARD_SIZE_SCALE,
		billboard.Size.Y.Scale * BILLBOARD_SIZE_SCALE,
		billboard.Size.Y.Offset * BILLBOARD_SIZE_SCALE
	)
	-- Auto-hide far billboards — Roblox stops rendering BillboardGuis beyond
	-- MaxDistance. UI label only — the brainrot model itself stays visible.
	billboard.MaxDistance = 120
	billboard.Parent = attachment

	-- Strip the mutation prefix from the Name label -- the dedicated Type label
	-- below already shows "Diamond" / "Gold" / etc., so prepending it here was
	-- duplicating the mutation text ("Diamond Cacto Hipopotamo" + "Diamond").
	local nameCfg = data.BrainrotId and GameConfig.Items[data.BrainrotId]
	local baseName = (nameCfg and nameCfg.DisplayName) or data.BrainrotId or data.DisplayName or ""
	setLabelText(billboard:FindFirstChild("Name"), baseName)

	local incomeLabel = billboard:FindFirstChild("Income")
	if incomeLabel then
		local cps = data.CashPerSec
		if cps then
			setLabelText(incomeLabel, "$" .. FormatUtils.Abbreviate(cps * getDisplayMultiplier()) .. "/s")
		else
			setLabelText(incomeLabel, "")
		end
	end

	local rarityLabel = billboard:FindFirstChild("Rarity")
	if rarityLabel then
		local rarity = data.Rarity or "Common"
		-- Render the rarity by its DisplayName (e.g. show 'Secret' for the
		-- 'Exclusive' rarity enum). Falls back to the raw id so unknown rarities
		-- still render legibly. Same string is used for the gradient lookup so a
		-- white/black 'Secret' UIGradient sits under the Secret label.
		local rarityCfg = GameConfig.Rarities and GameConfig.Rarities[rarity]
		local labelText = (rarityCfg and rarityCfg.DisplayName) or rarity
		rarityLabel.Text = labelText
		local rarityInner = rarityLabel:FindFirstChild("Rarity")
		local gradientTarget = rarityInner or rarityLabel
		if rarityInner then
			rarityInner.Text = labelText
		end
		for _, child in ipairs(gradientTarget:GetChildren()) do
			if child:IsA("UIGradient") then
				child:Destroy()
			end
		end
		local gradient = GradientFolder:FindFirstChild(labelText)
			or GradientFolder:FindFirstChild(rarity)
		if gradient then
			gradient:Clone().Parent = gradientTarget
		end
	end

	local typeLabel = billboard:FindFirstChild("Type")
	local mutation = data.Mutation
	if typeLabel then
		if mutation and mutation ~= "" then
			local mutCfg = GameConfig.Mutations[mutation]
			local displayName = (mutCfg and mutCfg.DisplayName) or mutation
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
			local gradientName = (mutCfg and mutCfg.GradientType) or mutation
			local mutGradient = MutationGradientFolder:FindFirstChild(gradientName)
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

	-- Snapshot the authored stud-size so the upgrade rescale can restore it.
	-- Model:ScaleTo() scales every descendant BillboardGui's Size /
	-- StudsOffset / StudsOffsetWorldSpace because those values are in WORLD
	-- studs -- without restoring them after each upgrade the overhead text
	-- grew with the brainrot (visible up to 1.5x at L100). User wants the
	-- text size FIXED so labels read identically at every level; the
	-- billboard still rises with the brainrot because the attachment that
	-- holds it is inside the (scaled) rig.
	billboard:SetAttribute("_AuthoredSizeXS", billboard.Size.X.Scale)
	billboard:SetAttribute("_AuthoredSizeXO", billboard.Size.X.Offset)
	billboard:SetAttribute("_AuthoredSizeYS", billboard.Size.Y.Scale)
	billboard:SetAttribute("_AuthoredSizeYO", billboard.Size.Y.Offset)
	local so = billboard.StudsOffsetWorldSpace
	billboard:SetAttribute("_AuthoredStudsOffsetX", so.X)
	billboard:SetAttribute("_AuthoredStudsOffsetY", so.Y)
	billboard:SetAttribute("_AuthoredStudsOffsetZ", so.Z)

	return billboard
end

-- Re-apply the billboard's authored stud-size + offsets, undoing whatever
-- Model:ScaleTo just did to those world-stud properties. Cheap no-op if the
-- billboard hasn't mounted yet (deferred setupBillboard task hasn't run).
local function restoreBillboardScale(visual)
	local bb = visual and visual.Billboard
	if not bb then return end
	local xs = bb:GetAttribute("_AuthoredSizeXS")
	if xs == nil then return end
	bb.Size = UDim2.new(
		xs,
		bb:GetAttribute("_AuthoredSizeXO") or 0,
		bb:GetAttribute("_AuthoredSizeYS") or 0,
		bb:GetAttribute("_AuthoredSizeYO") or 0
	)
	bb.StudsOffsetWorldSpace = Vector3.new(
		bb:GetAttribute("_AuthoredStudsOffsetX") or 0,
		bb:GetAttribute("_AuthoredStudsOffsetY") or 0,
		bb:GetAttribute("_AuthoredStudsOffsetZ") or 0
	)
end

local function updateBillboard(visual, data)
	if not visual.Billboard then
		print(string.format("[DBG_UPGRADE] CLIENT updateBillboard SKIPPED no billboard cps=%s", tostring(data and data.CashPerSec)))
		return
	end
	-- BillboardVisibility reparents the billboard's direct children into a
	-- _CenterHost Frame (for the pop-in scale animation), so by upgrade time
	-- the Income label is nested one level deeper than setupBillboard saw it.
	-- Shallow FindFirstChild returns nil here and the overhead cash/sec text
	-- stays frozen across upgrades -- use a recursive lookup.
	local incomeLabel = visual.Billboard:FindFirstChild("Income", true)
	if incomeLabel then
		local cps = data.CashPerSec
		if cps then
			local txt = "$" .. FormatUtils.Abbreviate(cps * getDisplayMultiplier()) .. "/s"
			print(string.format("[DBG_UPGRADE] CLIENT updateBillboard cps=%s mult=%s -> '%s' prevText='%s'", tostring(cps), tostring(getDisplayMultiplier()), txt, tostring(incomeLabel.Text)))
			setLabelText(incomeLabel, txt)
		else
			print("[DBG_UPGRADE] CLIENT updateBillboard cps is nil!")
		end
	else
		print("[DBG_UPGRADE] CLIENT updateBillboard Income label missing!")
	end
end

local function getModelTemplate(data)
	local modelName = data.ModelName or data.BrainrotId
	if not modelName then return nil end

	local mutation = data.Mutation
	if mutation and mutation ~= "" and GameConfig.GetBrainrotTemplate then
		local mutTemplate = GameConfig.GetBrainrotTemplate(modelName, mutation)
		if mutTemplate then return mutTemplate end
	end

	if GameConfig.GetBrainrotTemplate then
		return GameConfig.GetBrainrotTemplate(modelName, nil)
	end
	return nil
end

-- Lucky-block-on-pad rendering. The placed lucky block doesn't ship with a
-- Motor6D Idle animation like the brainrot rigs, so the float is driven by a
-- Lua bob (sin) + slow spin. The billboard shows a live countdown to OpenAt;
-- when it hits zero the ProximityPrompt's ActionText flips from Remove to
-- Open (updatePromptState is called from the same loop).
local function spawnLuckyBlockOnPodium(visual, podiumIndex, data, key)
	clearBrainrotModel(visual)

	if not LUCKY_BLOCK_TEMPLATES then return end
	local template = LUCKY_BLOCK_TEMPLATES:FindFirstChild(data.ModelName or data.LuckyBlockId)
	if not template or not template:IsA("Model") then return end

	local placePart = visual.PodiumModel:FindFirstChild("PlacePart")
	if not placePart or not placePart:IsA("BasePart") then return end

	local model = template:Clone()
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("KeyframeSequence") or d:IsA("ProximityPrompt") or d:IsA("BillboardGui") then
			d:Destroy()
		elseif d.Name == "AnimSaves" or d.Name == "InitialPoses" then
			d:Destroy()
		end
	end
	if not model.PrimaryPart then
		model.PrimaryPart = model:FindFirstChildWhichIsA("BasePart")
	end
	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = true
			part.CanCollide = false
			part.CanQuery = false
			part.CanTouch = false
			part.CastShadow = false
		end
	end
	-- Match the island spawn scale (LUCKYBLOCK_SCALE = 1.45 in
	-- IslandLuckyBlockSpawner). Placing a block on a pad must not change
	-- its size — the previous fit-to-5-max-dim path shrank big rigs
	-- (Dragon ~24%, Slime/Autumn ~19% of spawn footprint).
	local LUCKYBLOCK_SPAWN_SCALE = 1.45
	pcall(function()
		model:ScaleTo(model:GetScale() * LUCKYBLOCK_SPAWN_SCALE)
	end)

	local groundCF = getBrainrotCFrameOnPlacePart(placePart, model, visual.PodiumModel)
	local baseCF = groundCF * CFrame.new(0, FLOAT_HEIGHT, 0)
	visual.BaseCFrame = baseCF
	model:PivotTo(baseCF)
	model.Name = "PodiumLuckyBlock_" .. podiumIndex
	model.Parent = visual.PodiumModel
	visual.Model = model
	visual.LuckyBlockOpenAt = 0
	-- White outline highlight is brainrot-only per user request; lucky blocks
	-- already read clearly as their own model + open prompt.

	-- Reuse the existing PodiumBillboard template (the one brainrots use) so the
	-- lucky block overhead matches the rest of the game. Pass DisplayName +
	-- Rarity; no CashPerSec / Mutation — setupBillboard hides the Income label
	-- when CashPerSec is nil and the Type label when Mutation is empty.
	visual.Billboard = setupBillboard(model, {
		DisplayName = data.DisplayName or data.LuckyBlockId or "Lucky Block",
		Rarity = data.Rarity or "Common",
		CashPerSec = nil,
		Mutation = nil,
	})
	-- Overhead sits a bit higher above the placed block so it clears the
	-- stacked Open/Remove prompts beneath it.
	if visual.Billboard then
		visual.Billboard.StudsOffsetWorldSpace = Vector3.new(0, 2.75, 0)
	end

	-- No more Lua bob/spin -- play the block's OWN Idle animation (per the
	-- LuckyBlockAnims mapping; each cloned model carries its correct Idle).
	-- The model stays at baseCF; the skinned Idle provides the motion.
	local animController = model:FindFirstChildWhichIsA("AnimationController", true)
		or model:FindFirstChildWhichIsA("Humanoid", true)
	if animController then
		local idleAnim = animController:FindFirstChild("Idle")
		if idleAnim and idleAnim:IsA("Animation") and idleAnim.AnimationId ~= "" then
			local animator = animController:FindFirstChildOfClass("Animator")
			if not animator then
				animator = Instance.new("Animator")
				animator.Parent = animController
			end
			local okAnim, track = pcall(function()
				return animator:LoadAnimation(idleAnim)
			end)
			if okAnim and track then
				track.Looped = true
				track:Play()
				visual.AnimTrack = track
			end
		end
	end
end

local function spawnBrainrotModel(visual, podiumIndex, data)
	clearBrainrotModel(visual)

	local cfg = GameConfig.Items[data.BrainrotId]
	if not cfg then return end

	local template = getModelTemplate(data)
	if not template then
		local retryKey = data.BrainrotId .. (data.Mutation or "")
		if visual._retryKey == retryKey then return end
		visual._retryKey = retryKey
		task.spawn(function()
			local deadline = os.clock() + 30
			while os.clock() < deadline do
				task.wait(0.5)
				if visual._retryKey ~= retryKey then return end
				if visual.Model then return end
				local t = getModelTemplate(data)
				if t then
					visual._retryKey = nil
					spawnBrainrotModel(visual, podiumIndex, data)
					return
				end
			end
			visual._retryKey = nil
		end)
		return
	end
	visual._retryKey = nil

	local placePart = visual.PodiumModel:FindFirstChild("PlacePart")
	if not placePart then return end

	local model = template:Clone()

	-- Strip KeyframeSequence + descendants (Keyframe, Pose, IntValue, etc).
	-- The templates ship with the animation AUTHORING data baked in (~4646 extra
	-- Instances per rig). Roblox uses the rbxassetid Animations at runtime; the
	-- KeyframeSequence trees are pure waste. With 30 placed brainrots this was
	-- ~139K useless instances in workspace adding per-frame engine overhead.
	-- Destroying the KeyframeSequence wipes ~98.6% of descendants and leaves the
	-- BaseParts, Motor6Ds, Welds, AnimationController, and Animations intact.
	for _, desc in ipairs(model:GetDescendants()) do
		if desc:IsA("KeyframeSequence") then
			desc:Destroy()
		end
	end

	if not model.PrimaryPart then
		model.PrimaryPart = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
	end
	local anchorPart = model.PrimaryPart

	-- Replace Humanoid with AnimationController. Humanoid runs a state machine
	-- every Heartbeat (terrain checks, jumping, physics evaluation) which is pure
	-- waste for static decorative models. AnimationController is the lean subset
	-- that still supports LoadAnimation/Animator. 30 active Humanoids was a major
	-- per-frame CPU drain even with the distance cull.
	for _, desc in ipairs(model:GetDescendants()) do
		if desc:IsA("Humanoid") then
			local parent = desc.Parent
			desc:Destroy()
			local ac = Instance.new("AnimationController")
			ac.Parent = parent
			break
		end
	end

	local jointedParts = {}
	for _, descendant in ipairs(model:GetDescendants()) do
		if descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint") then
			if descendant.Part0 then
				jointedParts[descendant.Part0] = true
			end
			if descendant.Part1 then
				jointedParts[descendant.Part1] = true
			end
		end
	end

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = false
			-- Steady-state perf: 30 placed rigs casting shadows + receiving queries
			-- adds real GPU + raycast cost every frame. The player only interacts
			-- with podiums via the PlacePart prompt, never the brainrot itself.
			part.CastShadow = false
			part.CanQuery = false
			part.CanTouch = false
			if part == anchorPart then
				part.Anchored = true
			else
				part.Anchored = not jointedParts[part]
			end
		end
	end

	-- Height-based fit so every brainrot stands the same height regardless of
	-- which bbox axis is longest (see scaleBrainrotToPlaced).
	pcall(function()
		scaleBrainrotToPlaced(model)
	end)

	-- Snapshot the post-fit scale BEFORE applying the level multiplier. Stored
	-- on the visual so upgrade refreshes can rescale from the right baseline
	-- (calling ScaleTo with a fresh level multiplier requires the base, not the
	-- compounded value).
	visual.BaseModelScale = model:GetScale()

	-- Capture the level-1 ground CFrame + pivot-to-bottom distance NOW, while
	-- the model is at exactly BaseModelScale and has no effect children yet.
	-- Stored values let the upgrade refresh recompute pivot Y deterministically
	-- (newPivotY = topY + pivotToBottomBase * levelScale) without ever needing
	-- another GetBoundingBox call -- so a stray VFX child or animation pose
	-- can't bloat the bbox and rocket the brainrot upward.
	local baseGroundCF = getBrainrotCFrameOnPlacePart(placePart, model, visual.PodiumModel)
	local padTopY = placePart.Position.Y + placePart.Size.Y / 2
	visual.SpawnBaseGroundCF = baseGroundCF
	visual.SpawnPadTopY = padTopY
	visual.PivotToBottomBase = baseGroundCF.Position.Y - padTopY

	-- Level-based scale on top of the standard placed scale. Computed AFTER
	-- scaleBrainrotToPlaced so the base footprint is what every other system
	-- (camera distance, billboard offset) already expects.
	local levelScale = getLevelScaleFactor(data.Level)
	if levelScale ~= 1.0 then
		pcall(function()
			model:ScaleTo(visual.BaseModelScale * levelScale)
		end)
	end

	-- Compose the level-adjusted ground CFrame by translating the base ground
	-- CFrame up by (pivotToBottomBase * (levelScale - 1)). Preserves X / Z /
	-- rotation from the level-1 capture; only the Y component moves.
	local yDelta = visual.PivotToBottomBase * (levelScale - 1.0)
	local groundCF = baseGroundCF + Vector3.new(0, yDelta, 0)
	visual.BaseCFrame = groundCF * CFrame.new(0, FLOAT_HEIGHT, 0)
	visual.PlacePartRef = placePart
	model:PivotTo(visual.BaseCFrame)
	model.Name = "PodiumBrainrot_" .. podiumIndex
	model.Parent = visual.PodiumModel
	visual.Model = model
	applyPlacedHighlight(model)

	-- Defer non-critical mounts so the place frame only pays Clone + anchor +
	-- ScaleTo + PivotTo + Parent. The `visual.Model == model` guard handles fast
	-- re-spawn (swap/remove/place within one frame) — the deferred closure no-ops
	-- if the visual has already moved on to a newer model.
	-- `visual.Billboard` guard handles fast upgrade: if refreshPodium's sameIdentity
	-- branch created the billboard synchronously before this defer fires, skip so
	-- we don't end up with TWO billboards parented to the same attachment
	-- (the duplicate was the root cause of the "two textlabels don't update" bug).
	task.defer(function()
		if visual.Model ~= model then return end
		if visual.Billboard then return end
		visual.Billboard = setupBillboard(model, data)
	end)

	local mutation = data.Mutation
	if mutation and mutation ~= "" then
		task.defer(function()
			if visual.Model ~= model then return end
			local mutCfg = GameConfig.Mutations[mutation]
			local vfxName = mutCfg and mutCfg.VFXName
			local vfxTemplate = vfxName and MutationVFXFolder:FindFirstChild(vfxName)
			-- Anchor the aura to the brainrot's mesh (every rig's PrimaryPart IS
			-- its single MeshPart), then fall back to the first MeshPart child if
			-- PrimaryPart is somehow non-mesh. Local identity CFrame keeps the
			-- attachment glued to the mesh's center so particles emit from inside
			-- the body instead of off at the bbox center.
			local meshHost = (model.PrimaryPart and model.PrimaryPart:IsA("MeshPart")) and model.PrimaryPart
				or model:FindFirstChildWhichIsA("MeshPart", true)
				or model.PrimaryPart
			if vfxTemplate and meshHost then
				local attachment = Instance.new("Attachment")
				attachment.Name = PODIUM_MUTATION_VFX_ATTACHMENT
				attachment.Parent = meshHost
				for _, child in ipairs(vfxTemplate:GetChildren()) do
					child:Clone().Parent = attachment
				end
			end
		end)
	end

	-- LoadAnimation yields on cold asset cache — defer so it doesn't block the
	-- place frame. Preload at Init makes the yield trivial in steady state.
	task.defer(function()
		if visual.Model ~= model then return end
		local animId = cfg.animationId or data.AnimationId or cfg.AnimationId or ""
		playBrainrotAnimation(visual, model, animId)
	end)

	startHoverLoop(visual, podiumIndex)
end

local COLLECT_LERP_SPEED = 9
local function updateCollectLabel(visual, podiumIndex)
	if not visual.IncomeLabel then return end
	-- Set the target only; the Heartbeat loop below counts the shown number
	-- toward it so accrue/collect changes animate smoothly instead of snapping.
	visual._collectTarget = math.floor(accumulatedCash[podiumIndex] or 0)
	if visual._collectShown == nil then
		visual._collectShown = visual._collectTarget
		visual._collectLastText = "$" .. FormatUtils.FormatNumber(visual._collectTarget)
		setLabelTextRaw(visual.IncomeLabel, visual._collectLastText)
	end
end

-- One shared lerp loop drives every podium's collect-overhead number.
RunService.Heartbeat:Connect(function(dt)
	local now = os.clock()
	for key, visual in pairs(podiumVisuals) do
		-- Idle float for placed brainrots + lucky blocks. Phase-shifted off the
		-- key length so adjacent podiums bob out of sync; suppressed while a
		-- wiggle one-shot is in flight (PodiumController.TriggerUpgradeFX) so
		-- the two PivotTo writers don't compete.
		if visual.Model and visual.BaseCFrame then
			local wiggleActive = visual._wiggleEndAt and now < visual._wiggleEndAt
			if not wiggleActive then
				local phase = (#key * 0.37) % (math.pi * 2)
				-- (sin + 1) * AMP keeps the bob strictly non-negative so the
				-- lowest point is exactly at BaseCFrame (pad surface). Without
				-- the +1 offset, the downstroke pushed the model AMP studs below
				-- the pad and clipped through the geometry on smaller rigs.
				local floatY = (math.sin(now * math.pi * 2 * FLOAT_FREQ + phase) + 1) * FLOAT_AMP
				visual.Model:PivotTo(visual.BaseCFrame * CFrame.new(0, floatY, 0))
			end
		end

		local label = visual.IncomeLabel
		if label and visual._collectTarget ~= nil then
			local shown = visual._collectShown or 0
			local target = visual._collectTarget
			if shown ~= target then
				local diff = target - shown
				if math.abs(diff) < 1 then
					shown = target
				else
					shown = shown + diff * math.min(1, COLLECT_LERP_SPEED * dt)
				end
				visual._collectShown = shown
				local txt = "$" .. FormatUtils.FormatNumber(math.floor(shown + 0.5))
				if txt ~= visual._collectLastText then
					setLabelTextRaw(label, txt)
					visual._collectLastText = txt
				end
			end
		end
	end
end)

local function updateOfflineLabels()
	-- Per-pad "Offline Cash: $X" labels are no longer the source of truth for
	-- offline rewards -- the OfflineReward popup is. Always hide the label so
	-- the player doesn't see the per-pad text and try to double-collect.
	for _, visual in pairs(podiumVisuals) do
		if visual.OfflineRewardLabel then
			visual.OfflineRewardLabel.Visible = false
		end
	end
end

local function getPodiumsContainer(plot)
	local nested = plot:FindFirstChild("Podiums")
	if nested then return nested end
	return plot
end

function refreshPodium(ownerUserId, podiumIndex, data)
	local key = makeKey(ownerUserId, podiumIndex)
	local prevData = podiumServerData[key]
	podiumServerData[key] = data
	local isOwn = (ownerUserId == player.UserId)
	if isOwn then recalcBestOwnPlacedCps() end

	local plot = getPlotByUserId(ownerUserId)
	if not plot then return end
	local podiumsFolder = getPodiumsContainer(plot)
	local podiumModel = podiumsFolder:FindFirstChild("Podium" .. podiumIndex)
	if not podiumModel then return end

	local visual = ensureVisual(key, podiumModel)

	ensurePrompt(visual, key, ownerUserId, podiumIndex)

	if isOwn then
		ensureCollectButton(visual, podiumIndex)
	end
	if data then
		-- Pad locked into the unbox flow: ignore live updates. The committed
		-- brainrot is stashed and rendered by PadUnboxing's onComplete once the
		-- reveal finishes, so it doesn't pop in mid-animation.
		if visual.Unboxing then
			if data.ItemType ~= "LuckyBlock" and not data.LuckyBlockId then
				visual.PendingPostUnboxData = data
			end
			updatePromptState(visual, key)
			return
		end
		-- Lucky-block pad payload: rendered by spawnLuckyBlockOnPodium (separate
		-- model source, no Motor6D Idle, Lua-driven bob + countdown billboard).
		if data.ItemType == "LuckyBlock" or data.LuckyBlockId then
			local prevWasLucky = prevData and (prevData.ItemType == "LuckyBlock" or prevData.LuckyBlockId)
			local sameLucky = visual.Model and prevWasLucky and prevData.LuckyBlockId == data.LuckyBlockId
			if not sameLucky then
				spawnLuckyBlockOnPodium(visual, podiumIndex, data, key)
			else
				visual.LuckyBlockOpenAt = data.OpenAt or visual.LuckyBlockOpenAt
			end
			if isOwn then
				accumulatedCash[podiumIndex] = 0
				updateCollectLabel(visual, podiumIndex)
				setCashPodiumVisible(visual, false)
			end
			updatePromptState(visual, key)
			if isOwn then updateOfflineLabels() end
			return
		end
		local sameIdentity = visual.Model and prevData
			and prevData.BrainrotId == data.BrainrotId
			and prevData.Mutation == data.Mutation
		print(string.format("[DBG_UPGRADE] CLIENT refreshPodium pod=%s isOwn=%s sameIdent=%s prevLevel=%s newLevel=%s prevCps=%s newCps=%s hasBB=%s", tostring(podiumIndex), tostring(isOwn), tostring(sameIdentity and true or false), tostring(prevData and prevData.Level), tostring(data.Level), tostring(prevData and prevData.CashPerSec), tostring(data.CashPerSec), tostring(visual.Billboard ~= nil)))
		if not sameIdentity then
			-- spawnBrainrotModel already schedules its own deferred billboard mount
			-- with a `visual.Billboard then return end` guard. Do NOT schedule a
			-- second one here — the old code did, which produced duplicate billboards.
			spawnBrainrotModel(visual, podiumIndex, data)
		else
			-- Upgrade path: same brainrot, new income/level. updateBillboard is a
			-- no-op if billboard hasn't mounted yet — in that case the deferred
			-- billboard from spawnBrainrotModel will create it later. Schedule a
			-- one-frame retry so the post-mount billboard reflects the latest data.
			if visual.Billboard then
				updateBillboard(visual, data)
			else
				task.defer(function()
					if visual.Billboard then
						updateBillboard(visual, data)
					end
				end)
			end

			-- Level changed via upgrade: rescale the existing model from its base
			-- (snapshotted at spawn) so each level adds 5% size up to the 1.5x cap
			-- without compounding across upgrades. Pivot Y is computed analytically
			-- from PivotToBottomBase * levelScale -- never via GetBoundingBox at
			-- upgrade time, which is what caused the "flies into the sky" bug:
			-- the upgrade VFX clone (un-anchored) drifted inside the model and
			-- ballooned the bbox, so the recomputed ground put the pivot way above
			-- the pad. With the snapshot we don't care what's inside the model.
			local prevLevel = (prevData and prevData.Level) or 1
			local newLevel = data.Level or 1
			if visual.Model and visual.BaseModelScale and visual.SpawnBaseGroundCF
				and visual.PivotToBottomBase and prevLevel ~= newLevel then
				local levelScale = getLevelScaleFactor(newLevel)
				pcall(function()
					visual.Model:ScaleTo(visual.BaseModelScale * levelScale)
				end)
				local yDelta = visual.PivotToBottomBase * (levelScale - 1.0)
				local groundCF = visual.SpawnBaseGroundCF + Vector3.new(0, yDelta, 0)
				visual.BaseCFrame = groundCF * CFrame.new(0, FLOAT_HEIGHT, 0)
				visual.Model:PivotTo(visual.BaseCFrame)
				restoreBillboardScale(visual)
			end
		end

		if isOwn then
			accumulatedCash[podiumIndex] = data.AccumulatedCash or 0
			updateCollectLabel(visual, podiumIndex)
			setCashPodiumVisible(visual, true)
		end
	else
		clearBrainrotModel(visual)
		if isOwn then
			accumulatedCash[podiumIndex] = 0
			updateCollectLabel(visual, podiumIndex)
			setCashPodiumVisible(visual, false)
		end
	end

	updatePromptState(visual, key)

	if isOwn then
		updateOfflineLabels()
	end
end

local function refreshAllPrompts()
	for key, visual in pairs(podiumVisuals) do
		updatePromptState(visual, key)
	end
end


local ownPlotChildAddedConnected = false
local function setupOwnPlotUI()
	local plot = getPlayerPlot()
	if not plot then return false end
	local podiumsFolder = getPodiumsContainer(plot)

	for _, child in ipairs(podiumsFolder:GetChildren()) do
		local idx = parsePodiumIndex(child)
		if idx then
			local key = makeKey(player.UserId, idx)
			refreshPodium(player.UserId, idx, podiumServerData[key])
		end
	end

	if not ownPlotChildAddedConnected then
		ownPlotChildAddedConnected = true
		podiumsFolder.ChildAdded:Connect(function(child)
			local idx = parsePodiumIndex(child)
			if idx then
				task.defer(function()
					local key = makeKey(player.UserId, idx)
					refreshPodium(player.UserId, idx, podiumServerData[key])
				end)
			end
		end)
	end

	return true
end

local function scanOwnPlot(serverState)
	local plot = getPlayerPlot()
	if not plot then return end
	local podiumsFolder = getPodiumsContainer(plot)

	local podiums = serverState and serverState.Podiums or {}

	for _, child in ipairs(podiumsFolder:GetChildren()) do
		local idx = parsePodiumIndex(child)
		if idx then
			refreshPodium(player.UserId, idx, podiumAt(podiums, idx))
		end
	end

	if not ownPlotChildAddedConnected then
		ownPlotChildAddedConnected = true
		podiumsFolder.ChildAdded:Connect(function(child)
			local idx = parsePodiumIndex(child)
			if idx then
				task.defer(function()
					local key = makeKey(player.UserId, idx)
					refreshPodium(player.UserId, idx, podiumServerData[key])
				end)
			end
		end)
	end
end

local function scanOtherPlots(allPlotsState)
	if not allPlotsState then return end

	local jobs = {}
	for userIdKey, plotState in pairs(allPlotsState) do
		local userId = tonumber(userIdKey) or userIdKey
		if userId == player.UserId then continue end

		local podiums = plotState.Podiums or {}
		for idx, data in pairs(podiums) do
			local idxNum = tonumber(idx) or idx
			table.insert(jobs, { userId = userId, idx = idxNum, data = data })
		end

		-- Always cache, even if plot not visible yet — iterate by the payload's
		-- own keys so upper-floor podiums (11+) cache correctly.
		local plot = getPlotByUserId(userId)
		if not plot then
			for idxKey, entry in pairs(podiums) do
				local idx = tonumber(idxKey) or idxKey
				if idx then
					local key = makeKey(userId, idx)
					if entry and not podiumServerData[key] then
						podiumServerData[key] = entry
					end
				end
			end
		end
	end

	task.spawn(function()
		for _, job in ipairs(jobs) do
			refreshPodium(job.userId, job.idx, job.data)
			task.wait()
		end
	end)
end


local function cleanupPlayerVisuals(userId)
	local prefix = tostring(userId) .. "_"
	local keysToRemove = {}
	for key, visual in pairs(podiumVisuals) do
		if key:sub(1, #prefix) == prefix then
			clearBrainrotModel(visual)
			table.insert(keysToRemove, key)
		end
	end
	for _, key in ipairs(keysToRemove) do
		podiumVisuals[key] = nil
		podiumServerData[key] = nil
	end
end


-- Rejoin lag fix: server fires a burst of PodiumUpdate events (one per placed
-- brainrot for the joining player, plus broadcasts to existing players for every
-- player's placed brainrots, plus a 2-second re-fire — see PodiumService
-- ProfileLoaded handler). Processing them inline synchronously meant 10+ Clone +
-- anchor passes on one frame, which the user reported as "lags like hell" on
-- rejoin. Queue them and drain one per frame so other code (rendering, input)
-- breathes between podium spawns. Map-based coalesce — if the 2s re-fire arrives
-- before the first batch is drained, we replace the queued data in place instead
-- of double-rendering the same podium.
local pendingPodiumUpdates = {}
local pendingPodiumOrder = {}
local podiumUpdateWorkerActive = false

local function processPodiumUpdateQueue()
	if podiumUpdateWorkerActive then return end
	podiumUpdateWorkerActive = true
	task.spawn(function()
		while #pendingPodiumOrder > 0 do
			local key = table.remove(pendingPodiumOrder, 1)
			local entry = pendingPodiumUpdates[key]
			if entry then
				pendingPodiumUpdates[key] = nil
				local ok, err = pcall(function()
					refreshPodium(entry.ownerUserId, entry.podiumIndex, entry.data)
				end)
				if not ok then
					warn(string.format("[PodiumController] queued refreshPodium error: %s", tostring(err)))
				end
				task.wait()
			end
		end
		podiumUpdateWorkerActive = false
	end)
end

PodiumUpdateEvent.OnClientEvent:Connect(function(podiumIndex, data, ownerUserId)
	-- Defence-in-depth: normalise podiumIndex to number at the entry point.
	-- Server's SendStateToPlayer used to leak string keys via this event, which
	-- caused ensureCollectButton to capture a string `podiumIndex` in its onTouched
	-- closure — server then rejected CollectCash (type ~= "number"). Server has
	-- been fixed too, but normalising here makes the contract robust against any
	-- future code path that fires PodiumUpdate with a string key.
	podiumIndex = tonumber(podiumIndex) or podiumIndex
	if not ownerUserId then
		ownerUserId = player.UserId
	end

	if podiumIndex == 0 then
		-- Drop any pending updates for this owner so we don't render stale data
		-- after the cleanup signal.
		local prefix = tostring(ownerUserId) .. "_"
		for i = #pendingPodiumOrder, 1, -1 do
			local queuedKey = pendingPodiumOrder[i]
			if queuedKey:sub(1, #prefix) == prefix then
				pendingPodiumUpdates[queuedKey] = nil
				table.remove(pendingPodiumOrder, i)
			end
		end
		cleanupPlayerVisuals(ownerUserId)
		return
	end

	local key = makeKey(ownerUserId, podiumIndex)
	local existing = pendingPodiumUpdates[key]
	if existing then
		existing.data = data
		existing.ownerUserId = ownerUserId
		existing.podiumIndex = podiumIndex
	else
		pendingPodiumUpdates[key] = {
			ownerUserId = ownerUserId,
			podiumIndex = podiumIndex,
			data = data
		}
		table.insert(pendingPodiumOrder, key)
	end
	processPodiumUpdateQueue()
end)

-- Placed lucky-block open -> drive the at-the-pad unbox animation. Keyed by
-- PodiumIndex (added to the OpenResult payload server-side). The pad was
-- locked into visual.Unboxing by onLuckyOpenTriggered before this fires.
OpenResultEvent.OnClientEvent:Connect(function(data)
	if not data or not data.SkipInventoryAdd then return end
	local podiumIndex = tonumber(data.PodiumIndex)
	if not podiumIndex then return end
	local key = makeKey(player.UserId, podiumIndex)
	local visual = podiumVisuals[key]
	if not visual then return end
	visual.UnboxAwaitingResult = false
	visual.Unboxing = true
	visual.UnboxStartedAt = os.clock()
	revealingPodiums[podiumIndex] = true

	local placePart = visual.PodiumModel and visual.PodiumModel:FindFirstChild("PlacePart")
	local winner = data.Results and data.Results[1] and data.Results[1].BrainrotId
	local restCFrame = winner and computeLuckyRestCFrame(visual, winner)

	-- Fire the "You unboxed X!" notification only AFTER the reveal
	-- finishes. Used to live in LuckyBlockController.onOpenResult and
	-- popped the instant the player pressed E -- spoiled the roulette.
	local notified = false
	local function notifyOnce()
		if notified or not winner then return end
		notified = true
		local ok, LBC = pcall(require, ReplicatedStorage.Source.Controllers.LuckyBlockController)
		if ok and LBC and LBC.NotifyUnboxed then
			pcall(LBC.NotifyUnboxed, winner)
		end
	end

	local function finish()
		visual.UnboxHandle = nil
		visual.Unboxing = false
		revealingPodiums[podiumIndex] = nil
		local d = visual.PendingPostUnboxData
		visual.PendingPostUnboxData = nil
		notifyOnce()
		refreshPodium(player.UserId, podiumIndex, d or podiumServerData[key])
		-- Tell UpgradeController (and anyone else listening) the pad's brainrot is
		-- now committed visually, so it's safe to show the upgrade UI.
		pcall(function() PodiumController.RevealCompleted:Fire(podiumIndex) end)
	end

	if not placePart or not winner or not restCFrame then
		finish()
		return
	end

	if visual.UnboxHandle then visual.UnboxHandle.cancelled = true end
	visual.UnboxHandle = PadUnboxing.Play({
		placePart = placePart,
		restCFrame = restCFrame,
		winnerId = winner,
		possibleIds = data.PossibleBrainrots,
		onComplete = finish,
	})
end)

CashAccumulateEvent.OnClientEvent:Connect(function(podiumIndex, amount)
	accumulatedCash[podiumIndex] = amount
	local key = makeKey(player.UserId, podiumIndex)
	local visual = podiumVisuals[key]
	if visual then updateCollectLabel(visual, podiumIndex) end
end)

EquippedItemUpdateEvent.OnClientEvent:Connect(function(summary)
	cachedEquippedItemSummary = summary
	refreshAllPrompts()
end)

OfflineCashEvent.OnClientEvent:Connect(function(podiumIndex, amount)
	if amount > 0 then
		offlineCashPerPodium[podiumIndex] = amount
	else
		offlineCashPerPodium[podiumIndex] = nil
	end
	updateOfflineLabels()
end)

local function rerenderCachedForOwner(ownerUserId)
	if not ownerUserId or ownerUserId == 0 then return end
	local prefix = tostring(ownerUserId) .. "_"
	local pending = {}
	for key, data in pairs(podiumServerData) do
		if key:sub(1, #prefix) == prefix then
			local idx = tonumber(key:match("_(%d+)$"))
			if idx then
				table.insert(pending, { idx = idx, data = data })
			end
		end
	end
	task.spawn(function()
		for _, item in ipairs(pending) do
			refreshPodium(ownerUserId, item.idx, item.data)
			task.wait()
		end
	end)
end

local function watchPlotForOwner(plot)
	local ownerUserId = plot:GetAttribute("OwnerUserId")
	if not ownerUserId or ownerUserId == 0 then return end

	local podiumsFolder = getPodiumsContainer(plot)
	local isOwn = (ownerUserId == player.UserId)

	for _, child in ipairs(podiumsFolder:GetChildren()) do
		local idx = parsePodiumIndex(child)
		if idx then
			local key = makeKey(ownerUserId, idx)
			if not podiumVisuals[key] then
				local visual = ensureVisual(key, child)
				ensurePrompt(visual, key, ownerUserId, idx)
				if isOwn then
					ensureCollectButton(visual, idx)
				end
			end
		end
	end

	rerenderCachedForOwner(ownerUserId)
end

local function setupPlotWatchers()
	for _, plot in ipairs(PLOTS_FOLDER:GetChildren()) do
		plot:GetAttributeChangedSignal("OwnerUserId"):Connect(function()
			local newOwner = plot:GetAttribute("OwnerUserId")
			if newOwner and newOwner ~= 0 then
				task.defer(function()
					task.wait(0.5)
					watchPlotForOwner(plot)
				end)
			end
		end)

		local currentOwner = plot:GetAttribute("OwnerUserId")
		if currentOwner and currentOwner ~= 0 then
			task.defer(function()
				watchPlotForOwner(plot)
			end)
		end
	end
end


function PodiumController.CollectAll()
	local anyCash = false
	for _, amount in pairs(accumulatedCash) do if amount > 0 then anyCash = true break end end
	if not anyCash then
		for _, amount in pairs(offlineCashPerPodium) do if amount > 0 then anyCash = true break end end
	end
	if anyCash then playCashWithCombo() end
	for podiumIndex, amount in pairs(accumulatedCash) do
		if amount > 0 then
			task.spawn(function()
				CollectCashFunc:InvokeServer(podiumIndex)
			end)
		end
	end
	for podiumIndex, amount in pairs(offlineCashPerPodium) do
		if amount > 0 then
			task.spawn(function()
				local ok = CollectOfflineCashFunc:InvokeServer(podiumIndex)
				if ok then
					offlineCashPerPodium[podiumIndex] = nil
				end
			end)
		end
	end
end

function PodiumController.Init()
	-- Pre-fetch every brainrot animation asset off the hot path so the first place
	-- of each type doesn't pay an asset-load yield on LoadAnimation.
	task.spawn(function()
		-- Skip mass preload in Studio: it floods ContentProvider with this
		-- template's many inaccessible assets and stalls the join load.
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

	-- Pre-fetch every brainrot template's meshes/textures (Normal + all mutation
	-- variants from getModelTemplate). Otherwise the first place of each brainrot
	-- type stalls the render thread while the client loads ~15-30 MeshParts on
	-- the place frame.
	task.spawn(function()
		if game:GetService("RunService"):IsStudio() then return end
		local templates = {}
		for _, folder in ipairs(BRAINROTS_FOLDER:GetChildren()) do
			for _, brainrotModel in ipairs(folder:GetChildren()) do
				table.insert(templates, brainrotModel)
			end
		end
		if #templates > 0 then
			pcall(function() ContentProvider:PreloadAsync(templates) end)
		end
	end)

	task.spawn(function()
		local localPlot = nil
		for _ = 1, 150 do
			localPlot = getPlayerPlot()
			if localPlot then break end
			task.wait(0.2)
		end
		if not localPlot then return end

		setupOwnPlotUI()

		for _ = 1, 60 do
			local ok, state = pcall(function()
				return RequestPodiumDataFunc:InvokeServer()
			end)

			if ok and state then
				local podiums = state.Podiums or {}
				local offlineCash = state.OfflineCash or {}
				for podiumIndex, amount in pairs(offlineCash) do
					local idx = tonumber(podiumIndex) or podiumIndex
					if amount and amount > 0 then
						offlineCashPerPodium[idx] = amount
					end
				end

				local podiumsFolder = getPodiumsContainer(localPlot)
				local indices = {}
				for _, child in ipairs(podiumsFolder:GetChildren()) do
					local idx = parsePodiumIndex(child)
					if idx then
						table.insert(indices, idx)
					end
				end
				task.spawn(function()
					for _, idx in ipairs(indices) do
						refreshPodium(player.UserId, idx, podiumAt(podiums, idx))
						task.wait()
					end
				end)

				updateOfflineLabels()

				task.spawn(function()
					task.wait(2)
					for key, visual in pairs(podiumVisuals) do
						local data = podiumServerData[key]
						if data then updateBillboard(visual, data) end
					end
				end)
				break
			end
			task.wait(0.5)
		end

		task.defer(function()
			local ok, allState = pcall(function()
				return RequestAllPlotsDataFunc:InvokeServer()
			end)
			if ok and allState then
				scanOtherPlots(allState)
			end
		end)

		setupPlotWatchers()
	end)

	SettingsController.VfxToggled.Event:Connect(function(enabled)
		for key, visual in pairs(podiumVisuals) do
			if not isOwnKey(key) then continue end
			if enabled then
				local data = podiumServerData[key]
				if data and visual.Model then
					local cfg = GameConfig.Items[data.BrainrotId]
					local animId = (cfg and cfg.animationId) or data.AnimationId or ""
					playBrainrotAnimation(visual, visual.Model, animId)
				end
			else
				stopAnimation(visual)
			end
		end
	end)

	RebirthUpdateEvent.OnClientEvent:Connect(function()
		task.defer(function()
			for key, visual in pairs(podiumVisuals) do
				local data = podiumServerData[key]
				if data then
					updateBillboard(visual, data)
				end
			end
		end)
	end)

	-- Steal toast. Server fires this to the thief once the steal commits.
	-- NotificationsController is required lazily here so PodiumController's
	-- module-load order stays unchanged (matches the existing lazy require
	-- pattern used for RebirthController / CashBoostHudController above).
	StealNotificationEvent.OnClientEvent:Connect(function(itemDisplayName, victimName)
		local ok, NotificationsController = pcall(function()
			return require(ReplicatedStorage.Source.Controllers.NotificationsController)
		end)
		if not ok or not NotificationsController then return end
		local text = string.format("Stolen %s from %s!",
			tostring(itemDisplayName or "item"),
			tostring(victimName or "player"))
		NotificationsController.SendGreen(text)
	end)

	-- Cash boost % can change at any time (index reward unlocked, future rebirth boost,
	-- etc). Refresh every visible income label whenever the client cache flips.
	local cbh = require(ReplicatedStorage.Source.Controllers.CashBoostHudController)
	CashBoostHudController = cbh
	cbh.BoostChanged:Connect(function()
		task.defer(function()
			for key, visual in pairs(podiumVisuals) do
				local data = podiumServerData[key]
				if data then
					updateBillboard(visual, data)
				end
			end
		end)
	end)

	task.defer(function()
		local ok, summary = pcall(function()
			return RequestEquippedItemFunc:InvokeServer()
		end)
		if ok and summary then
			cachedEquippedItemSummary = summary
			refreshAllPrompts()
		end
	end)
end

return PodiumController