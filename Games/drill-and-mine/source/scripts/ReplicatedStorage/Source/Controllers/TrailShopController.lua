--[[
	TrailShopController -- the Trail shop (PlayerGui.GUI.Folder.TrailShop,
	a clone of the Drill shop frame; opened by ShopProximityController via
	the TrailShop booth prompt).
	Builds one card per GameConfig.Trails entry: empty icon holder (icons
	are authored later), trail name, "x1.2 Boost" stat row, and the buy row:
	  CashButton  (green, $ price)      } shown while NOT owned
	  RobuxButton (purple, dev product) }
	  EquipButton ("Equip"/"Unequip" toggle) when owned
	Cards are tinted with each trail's own color gradient.
	State comes from TrailShopService (OwnedTrails / EquippedTrail payload).
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))
local FormatUtils = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Utils"):WaitForChild("FormatUtils"))

local TrailShopController = {}

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local PURCHASE_SOUND_ID = "rbxassetid://100369772444661"
local EQUIP_TEXT = "Equip"
local UNEQUIP_TEXT = "Unequip"

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local TrailShopRemotes = Remotes:WaitForChild("TrailShopService")
local BuyTrailFunc = TrailShopRemotes:WaitForChild("BuyTrail")
local EquipTrailFunc = TrailShopRemotes:WaitForChild("EquipTrail")
local RequestTrailDataFunc = TrailShopRemotes:WaitForChild("RequestTrailData")
local TrailUpdateEvent = TrailShopRemotes:WaitForChild("TrailUpdate")

local PurchaseRemotes = Remotes:WaitForChild("PurchaseService")
local PromptPurchaseFunc = PurchaseRemotes:WaitForChild("PromptPurchase")

local ownedTrails = {}
local equippedTrail = ""
local cardsByTrail = {}
local pendingBuy = {}   -- [trailName] = true while a cash or Robux buy is in flight

-- ===== card tinting (each trail colors its own card) =====

-- The buy-row buttons and the stats row carry their own gradients/shadows
-- that must NOT be tinted by the trail color (same rule as the drill shop).
local PROTECTED_ROOTS = { Stats = true, CashButton = true, RobuxButton = true, EquipButton = true }

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

local function buildColorSequence(colors)
	local count = #colors
	if count == 0 then
		return nil
	end
	if count == 1 then
		return ColorSequence.new(colors[1])
	end
	local keypoints = {}
	for i, color in ipairs(colors) do
		keypoints[i] = ColorSequenceKeypoint.new((i - 1) / (count - 1), color)
	end
	return ColorSequence.new(keypoints)
end

local function applyTrailTint(clone, cfg)
	local sequence = buildColorSequence(cfg.Colors or {})
	if not sequence then
		return
	end
	for _, descendant in ipairs(clone:GetDescendants()) do
		if descendant:IsA("UIGradient") and not isProtected(descendant, clone) then
			descendant.Color = sequence
		end
	end
	-- shadows pick up the trail's mid color, like drill cards do with rarity
	local midColor = (cfg.Colors and cfg.Colors[math.max(1, math.ceil(#cfg.Colors / 2))]) or nil
	if midColor then
		for _, descendant in ipairs(clone:GetDescendants()) do
			if (descendant:IsA("ImageLabel") or descendant:IsA("ImageButton")) and descendant.Name == "Shadow" and not isProtected(descendant, clone) then
				descendant.ImageColor3 = midColor
			end
		end
	end
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

local function boostText(cfg)
	return string.format("x%g Boost", cfg.Boost or 1)
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

-- ===== catalog / card state =====

local function getSortedTrails()
	local list = {}
	for trailName, cfg in pairs(GameConfig.Trails or {}) do
		table.insert(list, { Name = trailName, Cfg = cfg })
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

local function applyButtonState(trailName)
	local card = cardsByTrail[trailName]
	if not card then
		return
	end
	local cfg = card.Cfg
	local isOwned = ownedTrails[trailName] == true
	local isEquipped = isOwned and (equippedTrail == trailName)

	card.Clone:SetAttribute("Owned", isOwned)
	card.Clone:SetAttribute("Equipped", isEquipped)

	if card.CashButton then
		-- Robux-exclusive trails never show a cash price
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
		setLabelText(card.EquipButton:FindFirstChild("Title"), isEquipped and UNEQUIP_TEXT or EQUIP_TEXT)
	end
end

local function refreshAllButtons()
	for trailName in pairs(cardsByTrail) do
		applyButtonState(trailName)
	end
end

local function applyPayload(payload)
	if type(payload) ~= "table" then
		return
	end
	local previouslyOwned = ownedTrails
	ownedTrails = {}
	for name, flag in pairs(payload.OwnedTrails or {}) do
		if flag then
			ownedTrails[name] = true
		end
	end
	equippedTrail = payload.EquippedTrail or ""

	for trailName in pairs(ownedTrails) do
		if not previouslyOwned[trailName] and pendingBuy[trailName] then
			playPurchaseSound()
		end
		pendingBuy[trailName] = nil
	end

	refreshAllButtons()
end

-- ===== click handlers =====

local function onCashClicked(trailName)
	if ownedTrails[trailName] or pendingBuy[trailName] then
		return
	end
	pendingBuy[trailName] = true
	task.spawn(function()
		local ok, success = pcall(function()
			return BuyTrailFunc:InvokeServer(trailName)
		end)
		if not ok or not success then
			pendingBuy[trailName] = nil
		end
	end)
end

local function onRobuxClicked(trailName, cfg)
	if ownedTrails[trailName] or pendingBuy[trailName] then
		return
	end
	local productId = cfg.ProductId or 0
	if productId == 0 then
		sendRedNotification("Robux purchase coming soon!")
		return
	end
	pendingBuy[trailName] = true
	task.spawn(function()
		local ok, success = pcall(function()
			return PromptPurchaseFunc:InvokeServer(productId, "BuyTrail_" .. trailName)
		end)
		if not ok or not success then
			pendingBuy[trailName] = nil
		end
	end)
end

local function onEquipClicked(trailName)
	if not ownedTrails[trailName] then
		return
	end
	task.spawn(function()
		pcall(function()
			return EquipTrailFunc:InvokeServer(trailName)
		end)
	end)
end

-- ===== card construction =====

-- Shared wiring for a card, authored OR runtime-cloned: registry entry,
-- owned/equip state, button handlers. Deliberately does NOT touch title/
-- boost text or the color tint -- authored cards keep whatever was edited
-- in Studio.
local function bindTrailEntry(clone, trailName, cfg)
	clone.LayoutOrder = cfg.Order or 0

	local cashButton = clone:FindFirstChild("CashButton")
	local robuxButton = clone:FindFirstChild("RobuxButton")
	local equipButton = clone:FindFirstChild("EquipButton")

	cardsByTrail[trailName] = {
		Clone = clone,
		Cfg = cfg,
		CashButton = cashButton,
		RobuxButton = robuxButton,
		EquipButton = equipButton,
	}
	applyButtonState(trailName)

	if cashButton then
		cashButton.Activated:Connect(function()
			onCashClicked(trailName)
		end)
	end
	if robuxButton then
		robuxButton.Activated:Connect(function()
			onRobuxClicked(trailName, cfg)
		end)
	end
	if equipButton then
		equipButton.Activated:Connect(function()
			onEquipClicked(trailName)
		end)
	end
end

local function buildTrailEntry(template, parent, trailName, cfg)
	local clone = template:Clone()
	clone.Name = "Trail_" .. trailName
	clone.Visible = true

	setLabelText(clone:FindFirstChild("Title"), cfg.DisplayName or trailName)

	local stats = clone:FindFirstChild("Stats")
	local powerRow = stats and stats:FindFirstChild("Power")
	local flatLabel = powerRow and powerRow:FindFirstChild("Value")
	if flatLabel then
		flatLabel.Visible = false
	end
	local boostLabel = powerRow and powerRow:FindFirstChild("Double")
	setLabelText(boostLabel, boostText(cfg))

	applyTrailTint(clone, cfg)

	-- Robux-exclusive: the lone Robux button takes the centered slot the
	-- Equip button normally uses (instead of hanging at the bottom)
	if cfg.RobuxOnly then
		local robuxButton = clone:FindFirstChild("RobuxButton")
		local equipButton = clone:FindFirstChild("EquipButton")
		if robuxButton and equipButton then
			robuxButton.Position = equipButton.Position
		end
	end

	-- no viewport/icon: the icon holder stays an empty plate; authored
	-- trail icons get dropped into Icon.Icon later

	bindTrailEntry(clone, trailName, cfg)

	clone.Parent = parent
	return clone
end

-- The 9 cards are MATERIALIZED in StarterGui (visible in Studio edit mode
-- so they can be restyled by hand). Adopt any authored "Trail_<name>" card
-- as-is and only clone the template for config entries with no authored
-- card; authored cards for names no longer in the config are dropped.
local function populate(scrollFrame, template)
	local entries = getSortedTrails()

	local validNames = {}
	for _, entry in ipairs(entries) do
		validNames["Trail_" .. entry.Name] = true
	end
	for _, child in ipairs(scrollFrame:GetChildren()) do
		if child.Name:sub(1, 6) == "Trail_" and not validNames[child.Name] then
			child:Destroy()
		end
	end

	for _, entry in ipairs(entries) do
		local existing = scrollFrame:FindFirstChild("Trail_" .. entry.Name)
		if existing then
			existing.Visible = true
			bindTrailEntry(existing, entry.Name, entry.Cfg)
		else
			buildTrailEntry(template, scrollFrame, entry.Name, entry.Cfg)
		end
	end
end

function TrailShopController.Init()
	local gui = playerGui:WaitForChild("GUI", 30)
	if not gui then return end
	local folder = gui:WaitForChild("Folder", 30)
	if not folder then return end
	local trailShop = folder:WaitForChild("TrailShop", 30)
	if not trailShop then return end
	local rewards = trailShop:WaitForChild("Rewards", 10)
	if not rewards then return end
	local outerScroll = rewards:WaitForChild("ScrollingFrame", 10)
	if not outerScroll then return end
	local innerScroll = outerScroll:WaitForChild("ScrollingFrame", 10)
	if not innerScroll then return end
	local template = innerScroll:WaitForChild("TrailTemplate", 10)
	if not template then return end

	template.Visible = false
	-- the frame ships Visible=true so the cards can be seen/edited in
	-- Studio; runtime always starts closed (the booth prompt opens it)
	trailShop.Visible = false

	TrailUpdateEvent.OnClientEvent:Connect(applyPayload)

	populate(innerScroll, template)

	task.spawn(function()
		for _ = 1, 20 do
			local ok, payload = pcall(function()
				return RequestTrailDataFunc:InvokeServer()
			end)
			if ok and payload then
				applyPayload(payload)
				break
			end
			task.wait(0.5)
		end
	end)
end

return TrailShopController