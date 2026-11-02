-- RarityLootClient: visual layer for the underground rarity loot.
--  * PodiumBillboard overhead (name / rarity gradient / $value / countdown)
--  * bob + spin float (PivotTo against the server-set base pivot; parts are
--    fully anchored so PivotTo moves the whole model)
--  * animated rarity gradient for the top tiers (Mythic and up)
--  * pickup animation: rise, then a curved (bezier) dive into the player,
--    ending with the ForceField-Break-01 burst
--  * Loot HUD counter (0/1), claim + sell notifications and sounds

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local RarityItemsConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("RarityItemsConfig"))
local ItemImagesConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("ItemImagesConfig"))
local ViewportOutline = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Modules"):WaitForChild("ViewportOutline"))

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local LIVE_FOLDER = Workspace:WaitForChild("RarityLootLive")
local TEMPLATES = ReplicatedStorage:WaitForChild("RarityItems")
local EFFECTS = ReplicatedStorage:WaitForChild("Effects")
local BILLBOARD_TEMPLATE = playerGui:WaitForChild("PodiumBillboard")
local RARITY_GRADIENT_FOLDER = ReplicatedStorage:WaitForChild("Gradients"):WaitForChild("Rarity")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local lootRemotes = Remotes:WaitForChild("RarityLoot")
local PickupEvent = lootRemotes:WaitForChild("Pickup")
local ClaimedEvent = lootRemotes:WaitForChild("Claimed")
local DeniedEvent = lootRemotes:WaitForChild("Denied")
local SoldEvent = lootRemotes:WaitForChild("Sold")
local LootChangedEvent = lootRemotes:WaitForChild("LootChanged")
local EquipLootToolEvent = lootRemotes:WaitForChild("EquipLootTool")
local GetClaimedLootFunc = lootRemotes:WaitForChild("GetClaimedLoot")

-- NotificationsController is the game's live toast system (GUI.Folder.Notification
-- with NotificationGreen/NotificationRed templates). The older NotificationController
-- waits on a "MainUI" gui that doesn't exist in this place, so it never shows anything.
local NotificationsController
pcall(function()
	NotificationsController = require(ReplicatedStorage.Source.Controllers.NotificationsController)
end)

-- ConfettiFX is the firework + confetti celebration the lucky-block claim
-- uses (PadUnboxing); reused here for the back-on-the-surface loot claim.
local ConfettiFX
pcall(function()
	ConfettiFX = require(ReplicatedStorage.Source.Modules.ConfettiFX)
end)

local function notify(text)
	if NotificationsController then NotificationsController.Send("Green", text) end
end
local function notifyRed(text)
	if NotificationsController then NotificationsController.Send("Red", text) end
end

local function playSound(name, volume)
	local folder = SoundService:FindFirstChild("Sounds")
	local template = folder and folder:FindFirstChild(name)
	if not template then return end
	local s = template:Clone()
	s.Volume = volume or template.Volume
	s.Parent = SoundService
	s:Play()
	task.delay(5, function() s:Destroy() end)
end

-- Board force-spawns (RarityItemSpawner BOARD_TIMERS): every player gets a
-- rainbow toast. The NotificationRainbow template's text gradient is tagged
-- VipTagGradient, so VipTagFlowClient scrolls it with the same rainbow flow
-- as every other rainbow text in the game.
local BoardSpawnEvent = lootRemotes:WaitForChild("BoardSpawn")
BoardSpawnEvent.OnClientEvent:Connect(function(rarity, zoneLabel)
	if type(rarity) ~= "string" then return end
	-- The server fires BoardSpawn ONLY when an item actually spawned (never on
	-- checking/refreshing/failing), so this is the successful-spawn cue.
	playSound("SpawnBoardSound")
	if NotificationsController then
		NotificationsController.Send("Rainbow", ("A %s has spawned in %s!"):format(rarity, zoneLabel or "Zone 1"), 4)
	end
end)

--------------------------------------------------------------------------------
-- Billboards + float
--------------------------------------------------------------------------------
local OVERHEAD_RAISE = 3.6
local BOB_HEIGHT = 0.55
local BOB_SPEED = 2.2
local SPIN_SPEED = math.rad(40)
local GRADIENT_SCROLL_SPEED = 0.9

local active = {} -- [model] = entry
local animatedGradients = {} -- [UIGradient] = phase

local function setLabel(label, text)
	if not label then return end
	label.Text = text
	local inner = label:FindFirstChild("Inner")
	if inner then inner.Text = text end
end

local function formatRemaining(remaining)
	if remaining >= 60 then
		return string.format("%dm %ds", math.floor(remaining / 60), math.floor(remaining % 60))
	elseif remaining > 3 then
		-- whole seconds only; decimals are reserved for the final countdown
		return string.format("%ds", math.floor(remaining))
	end
	return string.format("%.1fs", math.max(0, remaining))
end

local function detach(model)
	local entry = active[model]
	if not entry then return end
	active[model] = nil
	for _, conn in ipairs(entry.connections) do conn:Disconnect() end
	if entry.gradient then animatedGradients[entry.gradient] = nil end
	if entry.billboard then entry.billboard:Destroy() end
end

local function attach(model)
	if active[model] then return end
	if not model:GetAttribute("RarityLootItem") and not model:GetAttribute("DisplayLootItem") then return end
	local primary = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
	if not primary then return end

	local displayName = model:GetAttribute("DisplayName") or model.Name
	local rarity = model:GetAttribute("Rarity") or "Common"
	-- config is the price authority (the pedestal egg once carried a stale baked
	-- Value attribute); the attribute stays the fallback for unlisted items
	local value = RarityItemsConfig.GetItemValue(model:GetAttribute("ItemId") or displayName)
	if not value or value <= 0 then
		value = tonumber(model:GetAttribute("Value")) or 0
	end
	local rarityCfg = RarityItemsConfig.Rarities[rarity]

	-- pedestal display items (DisplayLootItem, Workspace.DevProductN) float
	-- only: the pedestal's static BillboardAnchor sign already shows the
	-- name/price/timer, so the runtime card here doubled it (user report)
	if model:GetAttribute("DisplayLootItem") and not model:GetAttribute("RarityLootItem") then
		local entry = {
			billboard = nil,
			primary = primary,
			basePivot = model:GetPivot(),
			bobPhase = math.random() * math.pi * 2,
			spinStart = os.clock(),
			connections = {},
		}
		active[model] = entry
		table.insert(entry.connections, model.AncestryChanged:Connect(function(_, parent)
			if not parent then detach(model) end
		end))
		table.insert(entry.connections, model.Destroying:Connect(function()
			detach(model)
		end))
		return
	end

	local billboard = BILLBOARD_TEMPLATE:Clone()
	billboard:SetAttribute("RarityLootBillboard", true)

	setLabel(billboard:FindFirstChild("Name"), displayName)
	setLabel(billboard:FindFirstChild("Income"), RarityItemsConfig.FormatValue(value))

	local typeLabel = billboard:FindFirstChild("Type")
	if typeLabel then typeLabel.Visible = false end

	local animGradient = nil
	local rarityLabel = billboard:FindFirstChild("Rarity")
	if rarityLabel then
		rarityLabel.Text = rarity
		local rarityInner = rarityLabel:FindFirstChild("Rarity")
		local gradientHost = rarityInner or rarityLabel
		if rarityInner then rarityInner.Text = rarity end
		for _, child in ipairs(gradientHost:GetChildren()) do
			if child:IsA("UIGradient") then child:Destroy() end
		end
		local grad = RARITY_GRADIENT_FOLDER:FindFirstChild(rarity)
		if grad then
			local g = grad:Clone()
			g.Parent = gradientHost
			if rarity == "Mythic" then
				-- the one true rainbow: VipTagFlowClient rewrites the Color of every
				-- VipTagGradient-tagged gradient with the same flowing rainbow as the
				-- strength buy buttons' PriceRainbowFlow
				g.Rotation = 0
				CollectionService:AddTag(g, "VipTagGradient")
			elseif rarityCfg and rarityCfg.Animated then
				animGradient = g
				animatedGradients[g] = math.random() * 2
			end
		elseif rarityCfg then
			if gradientHost:IsA("TextLabel") then gradientHost.TextColor3 = rarityCfg.Color end
			if rarityLabel:IsA("TextLabel") then rarityLabel.TextColor3 = rarityCfg.Color end
		end
	end

	-- Rarity is the headline on loot billboards (user request): swap ONLY the
	-- geometry of the Name/Rarity labels -- rarity takes the big top row, the
	-- item name the smaller row below. Colors and gradients stay with their
	-- own labels; the billboard lays out via UIListLayout, so LayoutOrder is
	-- what decides who sits on top.
	local nameLabel = billboard:FindFirstChild("Name")
	if nameLabel and rarityLabel then
		nameLabel.LayoutOrder, rarityLabel.LayoutOrder = rarityLabel.LayoutOrder, nameLabel.LayoutOrder
		nameLabel.Size, rarityLabel.Size = rarityLabel.Size, nameLabel.Size
	end

	local timerFrame = billboard:FindFirstChild("TimerFrame")
	-- pedestal display items never despawn -- no countdown row
	if timerFrame and not model:GetAttribute("SpawnedAt") then timerFrame.Visible = false end
	local timerLabel = timerFrame and timerFrame:FindFirstChild("Timer")
	local timerInner = timerLabel and timerLabel:FindFirstChild("Inner")

	-- The attachment point is computed fully in WORLD space and pinned to the
	-- spin axis: object-space +Y is NOT world up for templates whose pivot isn't
	-- stored upright (the Golden Key's flipped pivot buried its tag underground),
	-- and an off-axis point orbits the item as it spins (Phoenix Fire Arrow).
	local bbCF, ohSize = model:GetBoundingBox()
	local pivotPos = model:GetPivot().Position
	local ohAtt = Instance.new("Attachment")
	ohAtt.Name = "OverheadAttachment"
	ohAtt.Position = primary.CFrame:PointToObjectSpace(Vector3.new(pivotPos.X, bbCF.Position.Y + ohSize.Y / 2 + OVERHEAD_RAISE, pivotPos.Z))
	ohAtt.Parent = primary
	-- with ~5 items per zone across 30 zones, cull far billboards for perf
	billboard.MaxDistance = 250
	billboard.StudsOffsetWorldSpace = Vector3.zero
	billboard.Adornee = ohAtt
	billboard.Parent = ohAtt

	local entry = {
		billboard = billboard,
		primary = primary,
		basePivot = model:GetPivot(),
		bobPhase = math.random() * math.pi * 2,
		spinStart = os.clock(),
		timerLabel = timerLabel,
		timerInner = timerInner,
		lastTimerText = nil,
		spawnedAt = tonumber(model:GetAttribute("SpawnedAt")),
		lifetime = tonumber(model:GetAttribute("Lifetime")),
		gradient = animGradient,
		connections = {},
	}
	active[model] = entry

	table.insert(entry.connections, model.AncestryChanged:Connect(function(_, parent)
		if not parent then detach(model) end
	end))
	table.insert(entry.connections, model.Destroying:Connect(function()
		detach(model)
	end))
end

-- Past this range the float motion and countdown text are unreadable (the
-- overhead billboard engine-culls at ~130 studs), so the whole per-frame
-- body is skipped: PivotTo on ~150 concurrent drops every frame -- most of
-- them zones away -- was a constant CPU cost for nothing. The bob/spin is a
-- pure function of time, so a drop re-entering range resumes at the exact
-- phase it would have had, and the next Heartbeat refreshes a stale timer.
local ANIMATE_DISTANCE = 150

RunService.Heartbeat:Connect(function()
	local now = Workspace:GetServerTimeNow()
	local clockNow = os.clock()
	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	local playerPos = hrp and hrp.Position
	for model, entry in pairs(active) do
		if not model.Parent then
			detach(model)
		elseif not playerPos or (entry.basePivot.Position - playerPos).Magnitude <= ANIMATE_DISTANCE then
			-- float: bob + slow spin around the server-set base pivot
			local t = clockNow - entry.spinStart
			local bob = math.sin(t * BOB_SPEED + entry.bobPhase) * BOB_HEIGHT
			model:PivotTo(entry.basePivot * CFrame.Angles(0, t * SPIN_SPEED, 0) + Vector3.new(0, bob, 0))
			-- countdown
			if entry.timerLabel and entry.spawnedAt and entry.lifetime then
				local remaining = math.max(0, (entry.spawnedAt + entry.lifetime) - now)
				local text = formatRemaining(remaining)
				if text ~= entry.lastTimerText then
					entry.lastTimerText = text
					entry.timerLabel.Text = text
					if entry.timerInner then entry.timerInner.Text = text end
				end
			end
		end
	end
	-- smooth scrolling color for the rarest tiers
	for gradient, phase in pairs(animatedGradients) do
		if gradient.Parent then
			local x = ((clockNow * GRADIENT_SCROLL_SPEED + phase) % 2) - 1
			gradient.Offset = Vector2.new(x, 0)
		else
			animatedGradients[gradient] = nil
		end
	end
end)

for _, inst in ipairs(LIVE_FOLDER:GetChildren()) do
	if inst:IsA("Model") then task.defer(attach, inst) end
end
LIVE_FOLDER.ChildAdded:Connect(function(inst)
	if inst:IsA("Model") then task.defer(attach, inst) end
end)

-- Dev-product pedestal display items (Workspace.DevProductN, see
-- DevProductPedestalServer) get the float only -- their static
-- BillboardAnchor sign is the price card (attach() skips the runtime one).
for _, inst in ipairs(Workspace:GetChildren()) do
	if inst:IsA("Model") and inst.Name:match("^DevProduct%d+$") then
		for _, child in ipairs(inst:GetChildren()) do
			if child:IsA("Model") and child:GetAttribute("DisplayLootItem") then
				task.defer(attach, child)
			end
		end
	end
end

--------------------------------------------------------------------------------
-- Pickup animation: rise up, then curve down into the player + VFX burst
--------------------------------------------------------------------------------
local RISE_TIME = 0.18
local RISE_HEIGHT = 4
local DIVE_TIME = 0.32

local function playForceFieldBreak(atCFrame, parentPart)
	local template = EFFECTS:FindFirstChild("ForceField-Break-01")
	if not template then return end
	local fx = template:Clone()
	fx.CanCollide = false
	fx.CanQuery = false
	fx.Massless = true
	fx.Transparency = 1
	fx.CFrame = atCFrame
	-- ride along with the player instead of being left behind when they move
	if parentPart and parentPart.Parent then
		fx.Anchored = false
		local weld = Instance.new("WeldConstraint")
		weld.Part0 = fx
		weld.Part1 = parentPart
		weld.Parent = fx
		fx.Parent = parentPart.Parent
	else
		fx.Anchored = true
		fx.Parent = Workspace
	end
	for _, d in ipairs(fx:GetDescendants()) do
		if d:IsA("ParticleEmitter") then
			d.Enabled = false
			-- already-emitted particles live in world space; lock them to the part
			-- so the whole burst follows the player
			d.LockedToPart = true
			-- the pack ships EmitCount=1 (a single 0.5s sprite half-buried in the
			-- character) which reads as nothing at all -- burst several per emitter
			local count = math.max(tonumber(d:GetAttribute("EmitCount")) or 1, 6)
			d:Emit(count)
		end
	end
	-- quick light flash so the burst reads even when sprites overlap the body
	local light = Instance.new("PointLight")
	light.Brightness = 8
	light.Range = 12
	light.Color = Color3.fromRGB(170, 225, 255)
	light.Parent = fx
	TweenService:Create(light, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Brightness = 0, Range = 4 }):Play()
	task.delay(3, function() fx:Destroy() end)
end

local function quadBezier(p0, p1, p2, alpha)
	local a = p0:Lerp(p1, alpha)
	local b = p1:Lerp(p2, alpha)
	return a:Lerp(b, alpha)
end

PickupEvent.OnClientEvent:Connect(function(pickupPlayer, itemName, rarity, pivotCF)
	local tierFolder = TEMPLATES:FindFirstChild(rarity)
	local template = tierFolder and tierFolder:FindFirstChild(itemName)
	if not template then return end

	local visual = template:Clone()
	visual.Name = "LootPickupVisual"
	visual:PivotTo(pivotCF)
	visual.Parent = Workspace

	-- rarity-colored trail behind the flying item
	local trailPart = visual.PrimaryPart or visual:FindFirstChildWhichIsA("BasePart", true)
	if trailPart then
		local rarityColor = (RarityItemsConfig.Rarities[rarity] and RarityItemsConfig.Rarities[rarity].Color) or Color3.new(1, 1, 1)
		local a0 = Instance.new("Attachment")
		a0.Position = Vector3.new(0, trailPart.Size.Y / 2, 0)
		a0.Parent = trailPart
		local a1 = Instance.new("Attachment")
		a1.Position = Vector3.new(0, -trailPart.Size.Y / 2, 0)
		a1.Parent = trailPart
		local trail = Instance.new("Trail")
		trail.Attachment0 = a0
		trail.Attachment1 = a1
		trail.Color = ColorSequence.new(rarityColor)
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
		trail.Parent = trailPart
	end

	task.spawn(function()
		local startPivot = pivotCF
		local topPivot = startPivot + Vector3.new(0, RISE_HEIGHT, 0)

		-- phase 1: smooth rise
		local t0 = os.clock()
		while true do
			local alpha = math.min(1, (os.clock() - t0) / RISE_TIME)
			local eased = 1 - (1 - alpha) * (1 - alpha) -- quad out
			visual:PivotTo(startPivot:Lerp(topPivot, eased))
			if alpha >= 1 then break end
			RunService.Heartbeat:Wait()
		end

		-- phase 2: bezier dive into the player (tracks them while they move)
		local scale0 = visual:GetScale()
		local t1 = os.clock()
		while true do
			local alpha = math.min(1, (os.clock() - t1) / DIVE_TIME)
			local eased = alpha * alpha * (3 - 2 * alpha) -- smoothstep
			local character = pickupPlayer.Character
			local hrp = character and character:FindFirstChild("HumanoidRootPart")
			if not hrp then break end
			local p0 = topPivot.Position
			local p2 = hrp.Position
			local mid = (p0 + p2) / 2
			local p1 = Vector3.new(mid.X, math.max(p0.Y, p2.Y) + 7, mid.Z)
			local pos = quadBezier(p0, p1, p2, eased)
			visual:PivotTo(CFrame.new(pos) * CFrame.Angles(0, eased * math.pi * 3, eased * math.pi * 0.5))
			pcall(function()
				visual:ScaleTo(math.max(0.12, scale0 * (1 - 0.85 * eased)))
			end)
			-- burst the instant the item visually reaches the player; waiting for
			-- alpha == 1 reads as a delay because the smoothstep tail barely moves
			-- the item over the final frames
			if alpha >= 1 or (pos - p2).Magnitude <= 2.5 then
				playForceFieldBreak(hrp.CFrame, hrp)
				if pickupPlayer == player then
					playSound("PopUpSound", 0.7)
				end
				break
			end
			RunService.Heartbeat:Wait()
		end
		visual:Destroy()
	end)
end)

--------------------------------------------------------------------------------
-- Loot HUD counter (0/1 -> 1/1), cloned from the Storage stat frame
--------------------------------------------------------------------------------
local lootDouble, lootAmount, lootScale

local function updateLootCounter()
	if not lootDouble then return end
	local current = tonumber(player:GetAttribute("LootCarried")) or 0
	local max = tonumber(player:GetAttribute("MaxLootStorage")) or 1
	local text = string.format("%d/%d", current, max)
	lootDouble.Text = text
	if lootAmount then lootAmount.Text = text end
	if lootScale then
		lootScale.Scale = 1.25
		TweenService:Create(lootScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
	end
end

local function buildLootCounter(gui)
	local hud = gui:WaitForChild("HUD", 10)
	if not hud then return end
	local leftDown = hud:WaitForChild("LeftDownSide", 10)
	local storageFrame = leftDown and leftDown:FindFirstChild("Storage")
	if not storageFrame then return end
	local existing = leftDown:FindFirstChild("Loot")
	if existing then existing:Destroy() end

	-- The Storage row used to show bridge material; loot takes over its slot so
	-- there's exactly ONE backpack counter on the HUD.
	storageFrame.Visible = false

	local lootFrame = storageFrame:Clone()
	lootFrame.Name = "Loot"
	lootFrame.LayoutOrder = storageFrame.LayoutOrder or 0
	lootFrame.Visible = true
	lootFrame.Parent = leftDown

	lootDouble = lootFrame:FindFirstChild("Double")
	lootAmount = lootDouble and lootDouble:FindFirstChild("Amount")
	lootScale = Instance.new("UIScale")
	lootScale.Parent = lootFrame
	updateLootCounter()
end

playerGui.ChildAdded:Connect(function(c)
	if c.Name == "GUI" then task.spawn(buildLootCounter, c) end
end)
local existingGui = playerGui:FindFirstChild("GUI")
if existingGui then task.spawn(buildLootCounter, existingGui) end

player:GetAttributeChangedSignal("LootCarried"):Connect(updateLootCounter)
player:GetAttributeChangedSignal("MaxLootStorage"):Connect(updateLootCounter)

--------------------------------------------------------------------------------
-- Claim / sell / denied feedback
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Loot Tools in the custom hotbar. The native Backpack gui is disabled in this
-- game (TreeAreaController), so the loot Tools RarityItemSpawner puts in the
-- Backpack would be invisible. Render one slot per loot Tool inside
-- InventoryBottom (styled from the same Holder template the brainrot slots
-- use) and equip/unequip on click via Humanoid:EquipTool -- which is exactly
-- what the native backpack bar does, so the item comes out like any gear.
--------------------------------------------------------------------------------
-- Stacked by ITEM: one slot per item name with an "x2"-style Amount badge
-- when the player holds multiple copies (user request -- was one slot per
-- individual tool). Each stack tracks every live Tool of that item.
local lootStacks = {} -- [stackKey] = { slot = ImageButton, tools = { Tool, ... } }
local lootStackByTool = {} -- [tool] = stackKey (reverse lookup for removals)

local function stackKeyOf(tool)
	return (tool:GetAttribute("LootRarity") or "?") .. "|" .. tool.Name
end

local VIEWPORT_FOV = 30
local VIEWPORT_VIEW_DIR = Vector3.new(1, 0.7, -1).Unit

local function buildToolViewport(viewport, tool)
	-- flat card art (ItemImagesConfig) replaces the live render when we have
	-- it, matching the Index / Lucky Block store cards: the slot's authored
	-- Icon plate shows the art and the viewport stays hidden
	local slotIcon = viewport.Parent and viewport.Parent:FindFirstChild("Icon")
	local image = ItemImagesConfig.Items[tool.Name]
	if slotIcon and image then
		slotIcon.Image = image
		slotIcon.ScaleType = Enum.ScaleType.Fit
		slotIcon.ImageColor3 = Color3.new(1, 1, 1)
		slotIcon.Visible = true
		viewport.Visible = false
		return
	end
	viewport.Visible = true
	for _, c in ipairs(viewport:GetChildren()) do
		if c:IsA("WorldModel") or c:IsA("Camera") then c:Destroy() end
	end
	local rarity = tool:GetAttribute("LootRarity")
	local tierFolder = rarity and TEMPLATES:FindFirstChild(rarity)
	local template = tierFolder and tierFolder:FindFirstChild(tool.Name)
	if not template then return end
	viewport.BackgroundTransparency = 1
	-- same lighting recipe as the Index / drill-shop cards (user request:
	-- keep every item viewport consistent)
	viewport.LightDirection = Vector3.new(-0.5, -1, -1.5)
	viewport.LightColor = Color3.fromRGB(255, 255, 255)
	viewport.Ambient = Color3.fromRGB(185, 185, 185)
	local worldModel = Instance.new("WorldModel")
	worldModel.Parent = viewport
	local clone = template:Clone()
	local bbCF = clone:GetBoundingBox()
	clone:PivotTo(CFrame.new(-bbCF.Position) * clone:GetPivot())
	clone.Parent = worldModel
	local camera = Instance.new("Camera")
	camera.Parent = viewport
	viewport.CurrentCamera = camera
	local _, bbSize = clone:GetBoundingBox()
	-- Index-card camera: bounding-sphere fit at euler(-12, 35), padding 1.1
	local radius = math.max(bbSize.Magnitude / 2, 0.1)
	camera.FieldOfView = VIEWPORT_FOV
	local distance = radius / math.tan(math.rad(VIEWPORT_FOV / 2)) * 1.1
	camera.CFrame = CFrame.fromEulerAnglesYXZ(math.rad(-12), math.rad(35), 0) * CFrame.new(0, 0, distance)
	ViewportOutline.Add(viewport, clone, camera)
end

local function getInventoryBottom()
	local gui = playerGui:FindFirstChild("GUI")
	local folder = gui and gui:FindFirstChild("Folder")
	return folder and folder:FindFirstChild("InventoryBottom")
end

-- The G-menu inventory frame's scroll grid -- the same overflow home the
-- lucky-block / brainrot slots use (see IslandBrainrotClient's frameScroll).
local function getInventoryFrameScroll()
	local gui = playerGui:FindFirstChild("GUI")
	local folder = gui and gui:FindFirstChild("Folder")
	local invFrame = folder and folder:FindFirstChild("InventoryFrame")
	local outer = invFrame and invFrame:FindFirstChild("Frame")
	local inner = outer and outer:FindFirstChild("Frame")
	return inner and inner:FindFirstChild("ScrollingFrame")
end

local hookedContainers = setmetatable({}, { __mode = "k" })
local renumberLootSlots -- forward declared: assigns keybind digits to loot slots

local function isToolEquipped(tool)
	local character = player.Character
	return character ~= nil and tool.Parent == character
end

local function stackEquippedTool(stack)
	for _, tool in ipairs(stack.tools) do
		if isToolEquipped(tool) then
			return tool
		end
	end
	return nil
end

local function refreshSlotHighlight(stack)
	local slot = stack.slot
	local scale = slot and slot:FindFirstChild("EquipScale")
	if scale then
		-- same dual-curve recipe as the hotbar (IslandBrainrotClient
		-- .setSlotHighlight): springy grow on equip, soft shrink on unequip
		local equipped = stackEquippedTool(stack) ~= nil
		-- grown slot draws over its neighbors instead of under them
		slot.ZIndex = equipped and 2 or 1
		-- only the FIRST UIScale child takes effect -- purge any stray
		-- HoverController HoverScale that would dead-switch the pop
		local hoverScale = slot:FindFirstChild("HoverScale")
		if hoverScale then hoverScale:Destroy() end
		local info = equipped
			and TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
			or TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		TweenService:Create(scale, info, {
			Scale = equipped and 1.25 or 1,
		}):Play()
	end
end

local function pruneStackTools(stack)
	for i = #stack.tools, 1, -1 do
		local tool = stack.tools[i]
		if not tool.Parent then
			lootStackByTool[tool] = nil
			table.remove(stack.tools, i)
		end
	end
end

local function updateStackBadge(stack)
	local slot = stack.slot
	if not slot then return end
	local amount = slot:FindFirstChild("Amount")
	if amount then
		-- same "x2" badge style the brainrot stacks use (updateAmountLabel)
		local count = #stack.tools
		amount.Text = "x" .. count
		amount.Visible = count > 1
	end
end

local function removeToolFromStack(tool)
	local key = lootStackByTool[tool] or stackKeyOf(tool)
	lootStackByTool[tool] = nil
	local stack = lootStacks[key]
	if not stack then return end
	for i = #stack.tools, 1, -1 do
		if stack.tools[i] == tool then
			table.remove(stack.tools, i)
		end
	end
	pruneStackTools(stack)
	if #stack.tools == 0 then
		lootStacks[key] = nil
		if stack.slot then stack.slot:Destroy() end
		if renumberLootSlots then renumberLootSlots() end
	else
		updateStackBadge(stack)
		refreshSlotHighlight(stack)
	end
end

local function addToolToStack(tool)
	local key = stackKeyOf(tool)
	local stack = lootStacks[key]

	-- existing stack: just register the copy and bump the badge
	if stack then
		if not lootStackByTool[tool] then
			lootStackByTool[tool] = key
			table.insert(stack.tools, tool)
		end
		pruneStackTools(stack)
		updateStackBadge(stack)
		refreshSlotHighlight(stack)
		return
	end

	local inventoryBottom = getInventoryBottom()
	local holderTemplate = inventoryBottom and inventoryBottom:FindFirstChild("Holder")
	if not holderTemplate then return end

	-- renumber whenever the game's own slots come and go (their numbers shift)
	if not hookedContainers[inventoryBottom] then
		hookedContainers[inventoryBottom] = true
		inventoryBottom.ChildAdded:Connect(function()
			task.defer(function() if renumberLootSlots then renumberLootSlots() end end)
		end)
		inventoryBottom.ChildRemoved:Connect(function()
			task.defer(function() if renumberLootSlots then renumberLootSlots() end end)
		end)
	end

	local slot = holderTemplate:Clone()
	slot.Name = "LootStack_" .. key
	-- sit with the item slots: just before the backpack (G) button
	local backpackSlot
	for _, c in ipairs(inventoryBottom:GetChildren()) do
		if c:GetAttribute("IsBackpack") then
			backpackSlot = c
			break
		end
	end
	slot.LayoutOrder = (backpackSlot and (backpackSlot.LayoutOrder - 1)) or 60
	slot.Visible = true
	local icon = slot:FindFirstChild("Icon")
	if icon then icon.Visible = false end
	-- SlotNumber stays visible: renumberLootSlots assigns it a real keybind digit
	local amount = slot:FindFirstChild("Amount")
	if amount then amount.Visible = false end

	local viewport = Instance.new("ViewportFrame")
	viewport.Name = "ModelIcon"
	viewport.AnchorPoint = Vector2.new(0.5, 0.5)
	viewport.Position = UDim2.fromScale(0.5, 0.5)
	viewport.Size = UDim2.fromScale(0.9, 0.9)
	viewport.BackgroundTransparency = 1
	viewport.Parent = slot
	buildToolViewport(viewport, tool)

	local scale = Instance.new("UIScale")
	scale.Name = "EquipScale"
	scale.Parent = slot

	stack = { slot = slot, tools = { tool } }
	lootStacks[key] = stack
	lootStackByTool[tool] = key

	-- equip goes through the server so it always replicates. Activated and
	-- MouseButton1Click are both wired (whichever input path works fires) with
	-- a debounce so a double-fire can't instantly re-toggle the equip.
	-- Toggling a stack unequips the held copy if one is out, otherwise
	-- equips the first copy.
	local lastToggle = 0
	local function toggleEquip()
		if os.clock() - lastToggle < 0.2 then return end
		lastToggle = os.clock()
		local target = stackEquippedTool(stack) or stack.tools[1]
		if target then
			EquipLootToolEvent:FireServer(target:GetAttribute("LootUid"))
		end
	end
	slot.Activated:Connect(toggleEquip)
	slot.MouseButton1Click:Connect(toggleEquip)

	slot.Parent = inventoryBottom
	updateStackBadge(stack)
	refreshSlotHighlight(stack)
	renumberLootSlots()
end

-- Give each loot slot a hotbar number that CONTINUES the existing sequence
-- (drill = 2, lucky block = 3 -> loot = 4, 5, ...) so the printed number
-- always matches the slot's visual position, like the classic backpack bar.
renumberLootSlots = function()
	local inventoryBottom = getInventoryBottom()
	if not inventoryBottom then return end
	local mine = {}
	for _, stack in pairs(lootStacks) do
		if stack.slot then mine[stack.slot] = true end
	end
	local highestNumber = 0
	local highestItemOrder = 0
	local backpackSlot
	for _, child in ipairs(inventoryBottom:GetChildren()) do
		if child:IsA("GuiObject") and child.Visible and not mine[child] then
			if child:GetAttribute("IsBackpack") then
				backpackSlot = child
			else
				local label = child:FindFirstChild("SlotNumber")
				local n = label and tonumber(label.Text)
				if n and n > highestNumber then highestNumber = n end
				if child.LayoutOrder > highestItemOrder then highestItemOrder = child.LayoutOrder end
			end
		end
	end
	local ordered = {}
	for _, stack in pairs(lootStacks) do
		if stack.slot then table.insert(ordered, stack.slot) end
	end
	table.sort(ordered, function(a, b) return a.Name < b.Name end)
	local MAX_HOTBAR_NUMBER = 9 -- native-Roblox-style hotbar cap (user request)
	local frameScroll = getInventoryFrameScroll()
	for i, slot in ipairs(ordered) do
		local n = highestNumber + i
		local label = slot:FindFirstChild("SlotNumber")
		if n <= MAX_HOTBAR_NUMBER then
			slot.Visible = true
			slot:SetAttribute("LootKeyNumber", n)
			-- right after the last numbered item slot so position and label agree
			slot.LayoutOrder = highestItemOrder + i
			if slot.Parent ~= inventoryBottom then
				slot.Parent = inventoryBottom
			end
			if label then
				label.Visible = true
				label.Text = tostring(n)
			end
		elseif frameScroll then
			-- hotbar numbers used up: the stack lives in the G-menu inventory
			-- frame (same overflow home the lucky/brainrot slots use), still
			-- clickable there to equip, and moves back up automatically when
			-- a number frees (renumber reruns on every change)
			slot:SetAttribute("LootKeyNumber", nil)
			slot.Visible = true
			slot.LayoutOrder = 10000 + i
			if slot.Parent ~= frameScroll then
				slot.Parent = frameScroll
			end
			if label then
				label.Visible = false
				label.Text = ""
			end
		else
			-- no inventory frame found: old behavior (hidden but sellable)
			slot.Visible = false
			slot:SetAttribute("LootKeyNumber", nil)
		end
	end
	-- the backpack (G) button always stays last in the row
	if backpackSlot and backpackSlot.LayoutOrder <= highestItemOrder + #ordered then
		backpackSlot.LayoutOrder = highestItemOrder + #ordered + 1
	end
end

local DIGIT_KEYCODES = {
	[Enum.KeyCode.One] = 1, [Enum.KeyCode.Two] = 2, [Enum.KeyCode.Three] = 3,
	[Enum.KeyCode.Four] = 4, [Enum.KeyCode.Five] = 5, [Enum.KeyCode.Six] = 6,
	[Enum.KeyCode.Seven] = 7, [Enum.KeyCode.Eight] = 8, [Enum.KeyCode.Nine] = 9,
}
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	local digit = DIGIT_KEYCODES[input.KeyCode]
	if not digit then return end
	for _, stack in pairs(lootStacks) do
		local slot = stack.slot
		if slot and slot:GetAttribute("LootKeyNumber") == digit then
			local target = stackEquippedTool(stack) or stack.tools[1]
			if target then
				EquipLootToolEvent:FireServer(target:GetAttribute("LootUid"))
			end
			return
		end
	end
end)

local function onLootToolContainerChange(c)
	if not (c:IsA("Tool") and c:GetAttribute("RarityLootTool")) then return end
	task.defer(function()
		if not c.Parent then
			removeToolFromStack(c)
			return
		end
		addToolToStack(c)
	end)
end

local function watchContainer(container)
	container.ChildAdded:Connect(onLootToolContainerChange)
	container.ChildRemoved:Connect(onLootToolContainerChange)
	for _, c in ipairs(container:GetChildren()) do
		onLootToolContainerChange(c)
	end
end

player.ChildAdded:Connect(function(c)
	if c:IsA("Backpack") then task.defer(watchContainer, c) end
end)
local backpackNow = player:FindFirstChildOfClass("Backpack")
if backpackNow then watchContainer(backpackNow) end

local function onCharacter(character)
	watchContainer(character)
	-- the old character's tools were destroyed with it; purge their slots
	-- (the server re-grants fresh tools ~0.6s after spawn)
	task.delay(1.5, function()
		for tool in pairs(lootStackByTool) do
			if not tool.Parent then
				removeToolFromStack(tool)
			end
		end
	end)
end
player.CharacterAdded:Connect(onCharacter)
if player.Character then onCharacter(player.Character) end

--------------------------------------------------------------------------------
-- Overhead billboard on EQUIPPED loot Tools (any player's): the same
-- name / rarity / value card the ground drops use (rarity headline on top,
-- no countdown), downscaled like the held lucky-block overhead so it reads
-- as a held-item tag rather than a world drop.
--------------------------------------------------------------------------------
local HELD_TOOL_BB_SCALE = 0.6 -- match EquipVisualController's held overhead
local HELD_TOOL_RAISE = 1.4 -- studs of clear air above the model's top

local heldToolBillboards = setmetatable({}, { __mode = "k" }) -- [tool] = billboard

local function attachToolOverhead(tool)
	if heldToolBillboards[tool] then return end
	local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart")
	if not handle then return end

	local rarity = tool:GetAttribute("LootRarity") or "Common"
	local value = tonumber(tool:GetAttribute("LootValue")) or 0
	local rarityCfg = RarityItemsConfig.Rarities[rarity]

	local billboard = BILLBOARD_TEMPLATE:Clone()
	billboard:SetAttribute("HeldLootToolBillboard", true)
	billboard.Size = UDim2.new(
		billboard.Size.X.Scale * HELD_TOOL_BB_SCALE,
		billboard.Size.X.Offset * HELD_TOOL_BB_SCALE,
		billboard.Size.Y.Scale * HELD_TOOL_BB_SCALE,
		billboard.Size.Y.Offset * HELD_TOOL_BB_SCALE
	)

	setLabel(billboard:FindFirstChild("Name"), tool.Name)
	setLabel(billboard:FindFirstChild("Income"), RarityItemsConfig.FormatValue(value))

	local typeLabel = billboard:FindFirstChild("Type")
	if typeLabel then typeLabel.Visible = false end
	local timerFrame = billboard:FindFirstChild("TimerFrame")
	if timerFrame then timerFrame.Visible = false end

	local rarityLabel = billboard:FindFirstChild("Rarity")
	if rarityLabel then
		rarityLabel.Text = rarity
		local rarityInner = rarityLabel:FindFirstChild("Rarity")
		local gradientHost = rarityInner or rarityLabel
		if rarityInner then rarityInner.Text = rarity end
		for _, child in ipairs(gradientHost:GetChildren()) do
			if child:IsA("UIGradient") then child:Destroy() end
		end
		local grad = RARITY_GRADIENT_FOLDER:FindFirstChild(rarity)
		if grad then
			local g = grad:Clone()
			g.Parent = gradientHost
			if rarity == "Mythic" then
				g.Rotation = 0
				CollectionService:AddTag(g, "VipTagGradient")
			elseif rarityCfg and rarityCfg.Animated then
				animatedGradients[g] = math.random() * 2
			end
		elseif rarityCfg then
			if gradientHost:IsA("TextLabel") then gradientHost.TextColor3 = rarityCfg.Color end
			if rarityLabel:IsA("TextLabel") then rarityLabel.TextColor3 = rarityCfg.Color end
		end
	end

	-- rarity headline on top, item name below (same swap as the ground drops)
	local nameLabel = billboard:FindFirstChild("Name")
	if nameLabel and rarityLabel then
		nameLabel.LayoutOrder, rarityLabel.LayoutOrder = rarityLabel.LayoutOrder, nameLabel.LayoutOrder
		nameLabel.Size, rarityLabel.Size = rarityLabel.Size, nameLabel.Size
	end

	-- world-up offset above the model's top (immune to the tool's grip tilt)
	local height = HELD_TOOL_RAISE
	local model = tool:FindFirstChildOfClass("Model")
	if model then
		local ok, bbSize = pcall(function()
			local _, size = model:GetBoundingBox()
			return size
		end)
		if ok and bbSize then
			height = bbSize.Y / 2 + HELD_TOOL_RAISE
		end
	end
	billboard.MaxDistance = 120
	billboard.StudsOffsetWorldSpace = Vector3.new(0, height, 0)
	billboard.Adornee = handle
	billboard.Parent = handle
	heldToolBillboards[tool] = billboard
end

local function detachToolOverhead(tool)
	local billboard = heldToolBillboards[tool]
	if not billboard then return end
	heldToolBillboards[tool] = nil
	billboard:Destroy()
end

local function watchCharacterHeldTools(character)
	local function onHeldChildAdded(child)
		if child:IsA("Tool") and child:GetAttribute("RarityLootTool") then
			attachToolOverhead(child)
		end
	end
	character.ChildAdded:Connect(onHeldChildAdded)
	character.ChildRemoved:Connect(function(child)
		if child:IsA("Tool") then detachToolOverhead(child) end
	end)
	for _, c in ipairs(character:GetChildren()) do onHeldChildAdded(c) end
end

local function watchPlayerHeldTools(plr)
	plr.CharacterAdded:Connect(watchCharacterHeldTools)
	if plr.Character then watchCharacterHeldTools(plr.Character) end
end
Players.PlayerAdded:Connect(watchPlayerHeldTools)
for _, plr in ipairs(Players:GetPlayers()) do watchPlayerHeldTools(plr) end

ClaimedEvent.OnClientEvent:Connect(function(names, totalValue)
	if ConfettiFX then pcall(ConfettiFX.Burst) end
	local count = #names
	if count == 1 then
		notify(string.format("Claimed Loot! %s (%s)", names[1], RarityItemsConfig.FormatValue(totalValue)))
	else
		notify(string.format("Claimed Loot! %d items (%s)", count, RarityItemsConfig.FormatValue(totalValue)))
	end
	playSound("CashSound", 1)
end)

SoldEvent.OnClientEvent:Connect(function(count, totalValue)
	notify(string.format("Sold %d loot for %s!", count, RarityItemsConfig.FormatValue(totalValue)))
	playSound("PurchasedSound", 1)
end)

DeniedEvent.OnClientEvent:Connect(function(reason)
	if reason == "full" then
		notifyRed("Loot storage full!")
	elseif reason == "nothingToSell" then
		notifyRed("No loot to sell!")
	end
end)
