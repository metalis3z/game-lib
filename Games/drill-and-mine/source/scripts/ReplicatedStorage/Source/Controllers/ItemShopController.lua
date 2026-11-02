--[[
	ItemShopController -- the Drill shop (PlayerGui.GUI.Folder.ItemShop).
	Builds one card per GameConfig.Drills entry: a ViewportFrame preview of
	the workspace.Drills model, name + rarity + power stat, and the buy row:
	  CashButton  (green, $ price)     } shown while NOT owned
	  RobuxButton (purple, dev product) }
	  EquipButton (single centered button, "Equip"/"Equipped") when owned
	State comes from DrillShopService (OwnedDrills / SelectedDrill payload).
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))
local FormatUtils = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Utils"):WaitForChild("FormatUtils"))
local ViewportOutline = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Modules"):WaitForChild("ViewportOutline"))
local ViewportScrollCuller = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Modules"):WaitForChild("ViewportScrollCuller"))
local FrameAnimator = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Modules"):WaitForChild("FrameAnimator"))
local AnimatedText = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Modules"):WaitForChild("AnimatedText"))

local ItemShopController = {}

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local PURCHASE_SOUND_ID = "rbxassetid://100369772444661"
local EQUIPPED_TEXT = "Equipped"
local EQUIP_TEXT = "Equip"

-- card viewports stay hidden through the open/close size tween (every
-- AbsoluteSize change re-renders every visible viewport that frame) and
-- reveal as the Back-ease settles -- see ViewportScrollCuller.SetSuspended
local VIEWPORT_REVEAL_DELAY = 0.15

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local DrillShopRemotes = Remotes:WaitForChild("DrillShopService")
local BuyDrillFunc = DrillShopRemotes:WaitForChild("BuyDrill")
local EquipDrillFunc = DrillShopRemotes:WaitForChild("EquipDrill")
local RequestDrillDataFunc = DrillShopRemotes:WaitForChild("RequestDrillData")
local DrillUpdateEvent = DrillShopRemotes:WaitForChild("DrillUpdate")

local PurchaseRemotes = Remotes:WaitForChild("PurchaseService")
local PromptPurchaseFunc = PurchaseRemotes:WaitForChild("PromptPurchase")

local ownedDrills = {}
local selectedDrill = ""
local cardsByDrill = {}
local pendingBuy = {}   -- [drillName] = true while a cash or Robux buy is in flight

-- ===== rarity gradients (authored UIGradients win over config sequences) =====

local function getRarityGradientFolder()
	local gradients = ReplicatedStorage:FindFirstChild("Gradients")
	local rarityFolder = gradients and gradients:FindFirstChild("Rarity")
	return rarityFolder
end

local RARITY_GRADIENT_FOLDER = getRarityGradientFolder()

local function getRarityGradient(rarityName)
	if not rarityName or not RARITY_GRADIENT_FOLDER then
		return nil
	end
	local authored = RARITY_GRADIENT_FOLDER:FindFirstChild(rarityName)
	if authored and authored:IsA("UIGradient") then
		return authored
	end
	return nil
end

local function copyGradientProps(source, target)
	target.Color = source.Color
	target.Transparency = source.Transparency
	target.Rotation = source.Rotation
	target.Offset = source.Offset
	target.Enabled = source.Enabled
end

local function getPrimaryColor(authored, cfgSequence)
	local sequence = (authored and authored.Color) or cfgSequence
	if not sequence then
		return nil
	end
	local keypoints = sequence.Keypoints
	if not keypoints or #keypoints == 0 then
		return nil
	end
	return keypoints[1].Value
end

-- The buy-row buttons and the stats row carry their own gradients/shadows
-- that must NOT be tinted by the card rarity. Icon is protected too: the
-- glow around the drill viewport is authored RED in the template and stays
-- red on every card regardless of rarity (user request 2026-07-18).
local PROTECTED_ROOTS = { Stats = true, CashButton = true, RobuxButton = true, EquipButton = true, Icon = true }

local function isProtected(instance, root)
	local node = instance.Parent
	while node and node ~= root do
		if PROTECTED_ROOTS[node.Name] then
			return true
		end
		node = node.Parent
	end
	return false
end

local function recolorShadows(clone, color)
	if not color then
		return
	end
	for _, descendant in ipairs(clone:GetDescendants()) do
		if (descendant:IsA("ImageLabel") or descendant:IsA("ImageButton")) and descendant.Name == "Shadow" and not isProtected(descendant, clone) then
			descendant.ImageColor3 = color
		end
	end
end

local function applyRarityGradient(clone, rarityName)
	if not rarityName then
		return
	end

	local authored = getRarityGradient(rarityName)
	local cfgSequence
	local rarityCfg = GameConfig.Rarities and GameConfig.Rarities[rarityName]
	if rarityCfg and rarityCfg.Gradient then
		cfgSequence = rarityCfg.Gradient
	end

	if not authored and not cfgSequence then
		return
	end

	local applied = false
	for _, descendant in ipairs(clone:GetDescendants()) do
		if descendant:IsA("UIGradient") and not isProtected(descendant, clone) then
			if authored then
				copyGradientProps(authored, descendant)
			else
				descendant.Color = cfgSequence
			end
			applied = true
		end
	end

	if not applied then
		local gradient
		if authored then
			gradient = authored:Clone()
		else
			gradient = Instance.new("UIGradient")
			gradient.Color = cfgSequence
			gradient.Rotation = 90
		end
		gradient.Name = "RarityGradient"
		gradient.Parent = clone
	end

	recolorShadows(clone, getPrimaryColor(authored, cfgSequence))
end

-- ===== small helpers =====

local function setLabelText(label, text)
	if not label then
		return
	end
	if label:IsA("TextLabel") or label:IsA("TextButton") or label:IsA("TextBox") then
		label.Text = text
	end
	for _, descendant in ipairs(label:GetDescendants()) do
		if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
			descendant.Text = text
		end
	end
end

local function formatPrice(price)
	if price <= 0 then
		return "Free"
	end
	return "$" .. FormatUtils.Abbreviate(price)
end

-- Drills add flat Power on top of Strength (damage per second while
-- drilling = Strength + Power), so each card advertises that as a live
-- multiplier of the player's CURRENT Strength: x(Strength + Power)/Strength.
-- Two decimals below x10 so consecutive low-tier cards read x1.01/x1.02
-- instead of all collapsing to "x1"; when the gain is too small even for
-- x1.01 the card advertises the flat +Power bonus instead, which is
-- always distinct per drill.
local function formatMultiplier(mult)
	if mult >= 100 then
		return FormatUtils.Abbreviate(mult)
	end
	local text
	if mult >= 10 then
		text = string.format("%.1f", mult)
	else
		text = string.format("%.2f", mult)
	end
	text = text:gsub("0+$", ""):gsub("%.$", "")
	return text
end

local function damageText(cfg)
	local strength = math.max(tonumber(player:GetAttribute("Strength")) or 0, 1)
	local power = cfg.Power or 0
	local mult = (strength + power) / strength
	local text = formatMultiplier(mult)
	if power > 0 and text == "1" then
		return "Damage +" .. FormatUtils.Abbreviate(power)
	end
	return "Damage x" .. text
end

local function refreshDamageLabels()
	for _, card in pairs(cardsByDrill) do
		if card.DamageLabel then
			setLabelText(card.DamageLabel, damageText(card.Cfg))
		end
	end
end

-- AnimatedText churn guard: Strength always moves between shop visits, so
-- every open used to rewrite all 28 Damage labels (stroked + gradient'd,
-- ~11 chars, twin "Amount" label each) at once -- AnimatedText then built
-- ~1200 per-char CanvasGroups in a single frame and re-rastered them every
-- frame of the open tween. That was the big remaining open hitch. Fix:
-- while the shop is CLOSED the damage labels stay UNBOUND and their text is
-- kept fresh with plain (near-free) Text writes, so an open finds the text
-- already correct and triggers ZERO AnimatedText work. Re-binding on open
-- keeps the per-char animation for Strength changes while it's visible.
local function setDamageLabelsBound(bound)
	for _, card in pairs(cardsByDrill) do
		local label = card.DamageLabel
		if label then
			local targets = { label }
			for _, d in ipairs(label:GetDescendants()) do
				if d:IsA("TextLabel") or d:IsA("TextButton") then
					table.insert(targets, d)
				end
			end
			for _, t in ipairs(targets) do
				if bound then
					AnimatedText.Bind(t)
				else
					AnimatedText.Unbind(t)
				end
			end
		end
	end
end

local function playPurchaseSound()
	local sound = Instance.new("Sound")
	sound.SoundId = PURCHASE_SOUND_ID
	sound.Parent = SoundService
	sound:Play()
	sound.Ended:Once(function()
		sound:Destroy()
	end)
	task.delay(5, function()
		if sound and sound.Parent then
			sound:Destroy()
		end
	end)
end

local function sendRedNotification(text)
	task.spawn(function()
		local ok, RedNotification = pcall(require, ReplicatedStorage.Source.Controllers.RedNotificationController)
		if ok and RedNotification and RedNotification.Send then
			RedNotification.Send(text)
		end
	end)
end

-- ===== viewport preview =====

local function buildViewport(iconHolder, drillName)
	local old = iconHolder:FindFirstChild("Viewport")
	if old then
		old:Destroy()
	end

	-- Flat card art (GameConfig.Drills[..].ImageId, uploaded 2026-07-22)
	-- replaces the live ViewportFrame -- no more drill viewports (user
	-- request). Drills without art (Wood) keep the viewport fallback below.
	local cfg = GameConfig.Drills and GameConfig.Drills[drillName]
	if cfg and cfg.ImageId then
		local image = Instance.new("ImageLabel")
		image.Name = "Viewport" -- same name so the rebuild path above replaces it
		image.BackgroundTransparency = 1
		image.AnchorPoint = Vector2.new(0.5, 0.5)
		image.Position = UDim2.new(0.5, 0, 0.5, 0)
		image.Size = UDim2.new(0.92, 0, 0.92, 0)
		image.ScaleType = Enum.ScaleType.Fit
		image.Image = cfg.ImageId
		image.ZIndex = iconHolder.ZIndex + 1
		image.Parent = iconHolder
		return
	end

	-- catalog lives in ReplicatedStorage.Drills (moved out of workspace 2026-07-16)
	local drillsFolder = ReplicatedStorage:FindFirstChild("Drills") or workspace:FindFirstChild("Drills")
	local template = drillsFolder and drillsFolder:FindFirstChild(drillName)
	if not template then
		return
	end

	local viewport = Instance.new("ViewportFrame")
	viewport.Name = "Viewport"
	viewport.BackgroundTransparency = 1
	viewport.AnchorPoint = Vector2.new(0.5, 0.5)
	viewport.Position = UDim2.new(0.5, 0, 0.5, 0)
	viewport.Size = UDim2.new(0.92, 0, 0.92, 0)
	viewport.Ambient = Color3.fromRGB(185, 185, 185)
	viewport.LightColor = Color3.fromRGB(255, 255, 255)
	viewport.LightDirection = Vector3.new(-0.5, -1, -1.5)
	viewport.ZIndex = iconHolder.ZIndex + 1

	local model = template:Clone()
	for _, descendant in ipairs(model:GetDescendants()) do
		if descendant:IsA("BaseScript") or descendant:IsA("ModuleScript") or descendant:IsA("Sound")
			or descendant:IsA("SurfaceGui") or descendant:IsA("BillboardGui") then
			descendant:Destroy()
		elseif descendant:IsA("BasePart") then
			descendant.Anchored = true
		end
	end
	model.Parent = viewport

	-- 3/4 view fitted to the model's bounding sphere
	local boundsCFrame, boundsSize = model:GetBoundingBox()
	local radius = math.max(boundsSize.Magnitude / 2, 0.1)
	local camera = Instance.new("Camera")
	camera.FieldOfView = 30
	local distance = radius / math.tan(math.rad(camera.FieldOfView / 2)) * 1.05
	camera.CFrame = CFrame.new(boundsCFrame.Position)
		* CFrame.fromEulerAnglesYXZ(math.rad(-12), math.rad(35), 0)
		* CFrame.new(0, 0, distance)
	camera.Parent = viewport
	viewport.CurrentCamera = camera

	ViewportOutline.Add(viewport, model, camera)

	viewport.Parent = iconHolder
end

-- ===== catalog / card state =====

local function getSortedDrills()
	local list = {}
	for drillName, cfg in pairs(GameConfig.Drills or {}) do
		table.insert(list, { Name = drillName, Cfg = cfg })
	end
	table.sort(list, function(a, b)
		local oa = a.Cfg.Order or math.huge
		local ob = b.Cfg.Order or math.huge
		if oa == ob then
			return a.Name < b.Name
		end
		return oa < ob
	end)
	return list
end

local function applyButtonState(drillName)
	local card = cardsByDrill[drillName]
	if not card then
		return
	end
	local cfg = card.Cfg
	local isOwned = ownedDrills[drillName] == true
	local isSelected = isOwned and (selectedDrill == drillName)

	card.Clone:SetAttribute("Owned", isOwned)
	card.Clone:SetAttribute("Equipped", isSelected)

	if card.CashButton then
		-- Robux-exclusive drills never show a cash price
		card.CashButton.Visible = not isOwned and not cfg.RobuxOnly
		setLabelText(card.CashButton:FindFirstChild("Title"), formatPrice(cfg.Price or 0))
	end
	if card.RobuxButton then
		card.RobuxButton.Visible = not isOwned
		-- Robux SYMBOL glyph inline in the text (game-wide standard), not an icon
		setLabelText(card.RobuxButton:FindFirstChild("Title"), utf8.char(0xE002) .. tostring(cfg.RobuxPrice or 0))
	end
	if card.EquipButton then
		card.EquipButton.Visible = isOwned
		setLabelText(card.EquipButton:FindFirstChild("Title"), isSelected and EQUIPPED_TEXT or EQUIP_TEXT)
	end
end

local function refreshAllButtons()
	for drillName in pairs(cardsByDrill) do
		applyButtonState(drillName)
	end
end

local function applyPayload(payload)
	if type(payload) ~= "table" then
		return
	end
	local previouslyOwned = ownedDrills
	ownedDrills = {}
	for name, flag in pairs(payload.OwnedDrills or {}) do
		if flag then
			ownedDrills[name] = true
		end
	end
	selectedDrill = payload.SelectedDrill or ""

	for drillName in pairs(ownedDrills) do
		if not previouslyOwned[drillName] and pendingBuy[drillName] then
			playPurchaseSound()
		end
		pendingBuy[drillName] = nil
	end

	refreshAllButtons()
end

-- ===== click handlers =====

local function onCashClicked(drillName)
	if ownedDrills[drillName] or pendingBuy[drillName] then
		return
	end
	pendingBuy[drillName] = true
	task.spawn(function()
		local ok, success = pcall(function()
			return BuyDrillFunc:InvokeServer(drillName)
		end)
		if not ok or not success then
			pendingBuy[drillName] = nil
		end
	end)
end

local function onRobuxClicked(drillName, cfg)
	if ownedDrills[drillName] or pendingBuy[drillName] then
		return
	end
	local productId = cfg.ProductId or 0
	if productId == 0 then
		sendRedNotification("Robux purchase coming soon!")
		return
	end
	pendingBuy[drillName] = true
	task.spawn(function()
		local ok, success = pcall(function()
			return PromptPurchaseFunc:InvokeServer(productId, "BuyDrill_" .. drillName)
		end)
		if not ok or not success then
			pendingBuy[drillName] = nil
		end
	end)
end

local function onEquipClicked(drillName)
	if not ownedDrills[drillName] or selectedDrill == drillName then
		return
	end
	task.spawn(function()
		pcall(function()
			return EquipDrillFunc:InvokeServer(drillName)
		end)
	end)
end

-- ===== card construction =====

local function buildDrillEntry(template, parent, drillName, cfg)
	local clone = template:Clone()
	clone.Name = "Drill_" .. drillName
	clone.Visible = true
	clone.LayoutOrder = cfg.Order or 0

	setLabelText(clone:FindFirstChild("Title"), cfg.DisplayName or drillName)

	local rarityCfg = cfg.Rarity and GameConfig.Rarities and GameConfig.Rarities[cfg.Rarity]
	local rarityText = (rarityCfg and rarityCfg.DisplayName) or cfg.Rarity or ""
	setLabelText(clone:FindFirstChild("Rarity"), rarityText)

	local stats = clone:FindFirstChild("Stats")
	local powerRow = stats and stats:FindFirstChild("Power")
	-- The raw "+Power" number next to the multiplier confused players --
	-- hide it and let the Damage multiplier text tell the whole story.
	local flatLabel = powerRow and powerRow:FindFirstChild("Value")
	if flatLabel then
		flatLabel.Visible = false
	end
	local damageLabel = powerRow and powerRow:FindFirstChild("Double")
	setLabelText(damageLabel, damageText(cfg))

	applyRarityGradient(clone, cfg.Rarity)

	local iconHolder = clone:FindFirstChild("Icon")
	if iconHolder then
		buildViewport(iconHolder, drillName)
	end

	-- Robux-exclusive: the lone Robux button takes the centered slot the
	-- Equip button normally uses (same treatment as the Gold Trail card)
	if cfg.RobuxOnly then
		local robuxBtn = clone:FindFirstChild("RobuxButton")
		local equipBtn = clone:FindFirstChild("EquipButton")
		if robuxBtn and equipBtn then
			robuxBtn.Position = equipBtn.Position
		end
	end

	local cashButton = clone:FindFirstChild("CashButton")
	local robuxButton = clone:FindFirstChild("RobuxButton")
	local equipButton = clone:FindFirstChild("EquipButton")

	cardsByDrill[drillName] = {
		Clone = clone,
		Cfg = cfg,
		DamageLabel = damageLabel,
		CashButton = cashButton,
		RobuxButton = robuxButton,
		EquipButton = equipButton,
	}
	applyButtonState(drillName)

	if cashButton then
		cashButton.Activated:Connect(function()
			onCashClicked(drillName)
		end)
	end
	if robuxButton then
		robuxButton.Activated:Connect(function()
			onRobuxClicked(drillName, cfg)
		end)
	end
	if equipButton then
		equipButton.Activated:Connect(function()
			onEquipClicked(drillName)
		end)
	end

	clone.Parent = parent
	return clone
end

local function populate(scrollFrame, template)
	for _, child in ipairs(scrollFrame:GetChildren()) do
		if child.Name:sub(1, 6) == "Drill_" or child.Name:sub(1, 4) == "Axe_" then
			child:Destroy()
		end
	end
	for _, entry in ipairs(getSortedDrills()) do
		buildDrillEntry(template, scrollFrame, entry.Name, entry.Cfg)
	end
end

function ItemShopController.Init()
	local gui = playerGui:WaitForChild("GUI", 30)
	if not gui then return end
	local folder = gui:WaitForChild("Folder", 30)
	if not folder then return end
	local itemShop = folder:WaitForChild("ItemShop", 30)
	if not itemShop then return end
	local rewards = itemShop:WaitForChild("Rewards", 10)
	if not rewards then return end
	local outerScroll = rewards:WaitForChild("ScrollingFrame", 10)
	if not outerScroll then return end
	local innerScroll = outerScroll:WaitForChild("ScrollingFrame", 10)
	if not innerScroll then return end
	local template = innerScroll:WaitForChild("DrillTemplate", 10)
	if not template then return end

	template.Visible = false

	DrillUpdateEvent.OnClientEvent:Connect(applyPayload)

	populate(innerScroll, template)

	-- render only the drill viewports near the visible scroll window --
	-- all 28 card models (~950 parts) re-rendering every frame was a big
	-- chunk of the shop's open cost
	ViewportScrollCuller.Attach(innerScroll)

	-- Keep every card's Damage multiplier honest as Strength changes --
	-- ALSO while closed (plain text writes on unbound labels, near-free),
	-- so opening never finds stale text to storm-animate.
	player:GetAttributeChangedSignal("Strength"):Connect(refreshDamageLabels)
	itemShop:GetPropertyChangedSignal("Visible"):Connect(function()
		if itemShop.Visible then
			ViewportScrollCuller.SetSuspended(innerScroll, true)
			task.delay(VIEWPORT_REVEAL_DELAY, function()
				if itemShop.Visible then
					ViewportScrollCuller.SetSuspended(innerScroll, false)
				end
			end)
			setDamageLabelsBound(true)
			refreshDamageLabels()
		else
			ViewportScrollCuller.SetSuspended(innerScroll, true)
			setDamageLabelsBound(false)
		end
	end)

	-- AnimatedTextController auto-binds the cards as they were parented;
	-- drop the damage labels back out until the first open (deferred so it
	-- runs after those queued auto-binds).
	task.defer(function()
		if not itemShop.Visible then
			setDamageLabelsBound(false)
		end
	end)

	-- First open used to pay the whole fade-tween creation burst AND fade
	-- ~20 clipped cards (the snap set only fills at first CLOSE): warm both
	-- caches at startup so the first open behaves like every later one.
	task.delay(3, function()
		FrameAnimator.Prewarm(itemShop)
	end)

	task.spawn(function()
		for _ = 1, 20 do
			local ok, payload = pcall(function()
				return RequestDrillDataFunc:InvokeServer()
			end)
			if ok and payload then
				applyPayload(payload)
				break
			end
			task.wait(0.5)
		end
	end)
end

return ItemShopController
