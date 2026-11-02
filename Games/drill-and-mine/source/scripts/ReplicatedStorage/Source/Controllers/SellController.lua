local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))
local AnimatedText = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Modules"):WaitForChild("AnimatedText"))
local ViewportOutline = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Modules"):WaitForChild("ViewportOutline"))
local ItemImagesConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("ItemImagesConfig"))

local SellController = {}

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local InventoryRemotes = Remotes:WaitForChild("InventoryService")
local RequestInventoryFunc = InventoryRemotes:WaitForChild("RequestInventory")
local InventorySummaryUpdate = InventoryRemotes:WaitForChild("InventorySummaryUpdate")

local BRAINROTS_FOLDER = ReplicatedStorage:WaitForChild("Brainrots")
local RarityGradientFolder = ReplicatedStorage:WaitForChild("Gradients"):WaitForChild("Rarity")

-- Claimed rarity loot (underground items) also sells here; served by
-- RarityItemSpawner's RarityLoot remotes (created at runtime).
local function getLootRemotes()
	return Remotes:FindFirstChild("RarityLoot")
end

local CASH_SOUND = SoundService:WaitForChild("Sounds"):WaitForChild("CashSound")

-- Same camera framing the inventory slot viewports use (see IslandBrainrotClient).
local VIEWPORT_FOV = 30
local VIEWPORT_VIEW_DIR = Vector3.new(1, 0.7, -1).Unit
local VIEWPORT_PADDING = 1.05

local sellFrame = nil
local scrollingFrame = nil
local templateCard = nil
local isPopulating = false
local pendingRepopulate = false
local sellAllBar = nil
local isSellingAll = false

local cardByUniqueId = {}
local templateCache = {}
local lootCards = {}

local function setLabelText(label, text)
	if not label then return end
	if label:IsA("TextLabel") or label:IsA("TextButton") then
		label.Text = text
	end
	for _, d in ipairs(label:GetDescendants()) do
		if d:IsA("TextLabel") or d:IsA("TextButton") then
			d.Text = text
		end
	end
end

local function applyGradient(host, gradient)
	if not host then return end
	for _, c in ipairs(host:GetChildren()) do
		if c:IsA("UIGradient") then c:Destroy() end
	end
	if gradient then gradient:Clone().Parent = host end
end

local function findBrainrotTemplate(brainrotId, mutation)
	local mutationFolderName = (mutation and mutation ~= "") and mutation or "Normal"
	for _, rarityFolder in ipairs(BRAINROTS_FOLDER:GetChildren()) do
		local mutFolder = rarityFolder:FindFirstChild(mutationFolderName)
		local hit = mutFolder and mutFolder:FindFirstChild(brainrotId)
		if hit then return hit end
	end
	if mutationFolderName ~= "Normal" then
		for _, rarityFolder in ipairs(BRAINROTS_FOLDER:GetChildren()) do
			local normalFolder = rarityFolder:FindFirstChild("Normal")
			local hit = normalFolder and normalFolder:FindFirstChild(brainrotId)
			if hit then return hit end
		end
	end
	return nil
end

local function getCleanedTemplate(brainrotId, mutation)
	local key = brainrotId .. "|" .. (mutation or "")
	local cached = templateCache[key]
	if cached then return cached end

	local source = findBrainrotTemplate(brainrotId, mutation)
	if not source or not source:IsA("Model") then return nil end

	local template = source:Clone()
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
	templateCache[key] = template
	return template
end

local function fitCamera(camera, model)
	local _, bbSize = model:GetBoundingBox()
	local halfExtent = math.max(bbSize.X, bbSize.Y, bbSize.Z) * 0.5
	local distance = (halfExtent / math.sin(math.rad(VIEWPORT_FOV) * 0.5)) * VIEWPORT_PADDING
	local camPos = VIEWPORT_VIEW_DIR * distance
	camera.FieldOfView = VIEWPORT_FOV
	camera.CFrame = CFrame.lookAt(camPos, Vector3.zero)
end

-- Locate the brainrot rig's looped Idle animation. The pack ships it as an
-- Animation named "Idle" parented either inside the AnimationController or as
-- a direct sibling at the model root, so a flat GetDescendants pass catches
-- both layouts.
local function playIdleAnimation(model)
	local controller = model:FindFirstChildWhichIsA("AnimationController", true)
	if not controller then return end
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
	if not idle or idle.AnimationId == "" then return end
	local ok, track = pcall(function() return animator:LoadAnimation(idle) end)
	if ok and track then
		track.Looped = true
		track:Play()
	end
end

local function buildViewport(viewport, brainrotId, mutation)
	for _, c in ipairs(viewport:GetChildren()) do
		if c:IsA("WorldModel") or c:IsA("Camera") then c:Destroy() end
	end

	viewport.BackgroundTransparency = 1
	viewport.LightDirection = Vector3.new(-0.4, -1, -0.3)
	viewport.LightColor = Color3.fromRGB(255, 245, 220)
	viewport.Ambient = Color3.fromRGB(170, 170, 180)

	local template = getCleanedTemplate(brainrotId, mutation)
	if not template then return end

	-- Animator only deforms skinned meshes inside a WorldModel root.
	local worldModel = Instance.new("WorldModel")
	worldModel.Parent = viewport

	local modelClone = template:Clone()
	local bbCF = modelClone:GetBoundingBox()
	modelClone:PivotTo(CFrame.new(-bbCF.Position) * modelClone:GetPivot())
	modelClone.Parent = worldModel

	playIdleAnimation(modelClone)

	local camera = Instance.new("Camera")
	camera.Parent = viewport
	viewport.CurrentCamera = camera
	fitCamera(camera, modelClone)
end

local function formatCash(amount)
	if amount >= 1e9 then return string.format("$%.2fB", amount / 1e9) end
	if amount >= 1e6 then return string.format("$%.2fM", amount / 1e6) end
	if amount >= 1e3 then return string.format("$%.2fK", amount / 1e3) end
	return string.format("$%d", math.floor(amount))
end

local function playCashSound()
	local s = CASH_SOUND:Clone()
	s.Parent = SoundService
	s:Play()
	task.delay(2, function() s:Destroy() end)
end

local function clearCards()
	for _, card in pairs(cardByUniqueId) do
		card:Destroy()
	end
	cardByUniqueId = {}
	for _, card in pairs(lootCards) do
		card:Destroy()
	end
	lootCards = {}
end

local function getRarityForBrainrot(brainrotId)
	if GameConfig.GetItemRarity then
		return GameConfig.GetItemRarity(brainrotId)
	end
	local cfg = GameConfig.Items[brainrotId]
	return (cfg and cfg.Rarity) or "Common"
end

local function buildCard(item)
	local card = templateCard:Clone()
	card.Name = "SellCard_" .. item.ItemId
	card.Visible = true
	card:SetAttribute("UniqueId", item.ItemId)
	card:SetAttribute("BrainrotId", item.BrainrotId)
	card:SetAttribute("SellPrice", item.SellPrice)

	local title = card:FindFirstChild("Title")
	setLabelText(title, item.DisplayName)

	local rarity = item.Rarity
	local rarityLabel = card:FindFirstChild("Rarity")
	if rarityLabel then
		setLabelText(rarityLabel, rarity)
		local rarityGradient = RarityGradientFolder:FindFirstChild(rarity)
		applyGradient(rarityLabel, rarityGradient)
	end

	local cash = card:FindFirstChild("Cash")
	if cash then
		local double = cash:FindFirstChild("Double")
		local amount = double and double:FindFirstChild("Amount")
		if double then setLabelText(double, formatCash(item.SellPrice)) end
		if amount then amount.Text = formatCash(item.SellPrice) end
	end

	local icon = card:FindFirstChild("Icon")
	local viewport = icon and icon:FindFirstChild("ViewportFrame")
	if viewport then
		buildViewport(viewport, item.BrainrotId, item.Mutation)
	end

	local sellBtn = card:FindFirstChild("SellButton")
	if sellBtn and sellBtn:IsA("TextButton") then
		sellBtn.MouseButton1Click:Connect(function()
			SellController.SellItem(item.ItemId)
		end)
	end

	return card
end


local function buildLootViewport(viewport, template)
	for _, c in ipairs(viewport:GetChildren()) do
		if c:IsA("WorldModel") or c:IsA("Camera") then c:Destroy() end
	end
	viewport.BackgroundTransparency = 1
	local worldModel = Instance.new("WorldModel")
	worldModel.Parent = viewport
	local clone = template:Clone()
	local bbCF = clone:GetBoundingBox()
	clone:PivotTo(CFrame.new(-bbCF.Position) * clone:GetPivot())
	clone.Parent = worldModel
	local camera = Instance.new("Camera")
	camera.Parent = viewport
	viewport.CurrentCamera = camera
	fitCamera(camera, clone)
	ViewportOutline.Add(viewport, clone, camera)
end

local function sellLootItem(uid)
	local lootRemotes = getLootRemotes()
	local rf = lootRemotes and lootRemotes:FindFirstChild("SellLootItem")
	if not rf then return end
	local ok, response = pcall(function() return rf:InvokeServer(uid) end)
	if not ok or not response or not response.Success then return end
	-- sell sound comes from the loot system's Sold event, no extra sound here
	local card = lootCards[uid]
	if card then
		card:Destroy()
		lootCards[uid] = nil
	end
end

local function buildLootCard(entry)
	local card = templateCard:Clone()
	card.Name = "LootCard_" .. (entry.Uid or entry.Item or "loot")
	card.Visible = true

	setLabelText(card:FindFirstChild("Title"), entry.Item or "?")

	local rarityLabel = card:FindFirstChild("Rarity")
	if rarityLabel then
		setLabelText(rarityLabel, entry.Rarity or "")
		applyGradient(rarityLabel, RarityGradientFolder:FindFirstChild(entry.Rarity or ""))
	end

	local cash = card:FindFirstChild("Cash")
	if cash then
		local double = cash:FindFirstChild("Double")
		if double then setLabelText(double, formatCash(entry.Value or 0)) end
	end

	local icon = card:FindFirstChild("Icon")
	local viewport = icon and icon:FindFirstChild("ViewportFrame")
	local itemsFolder = ReplicatedStorage:FindFirstChild("RarityItems")
	local tierFolder = itemsFolder and entry.Rarity and itemsFolder:FindFirstChild(entry.Rarity)
	local template = tierFolder and tierFolder:FindFirstChild(entry.Item or "")
	if not template then
		-- store-block loot items (lucky-block unbox rewards) live under
		-- ReplicatedStorage.LuckyBlockLoot.<Tier>.<ModelName>
		local lootRoot = ReplicatedStorage:FindFirstChild("LuckyBlockLoot")
		local wanted = entry.ModelName or entry.Item
		if lootRoot and wanted then
			local folder = entry.LootFolder and lootRoot:FindFirstChild(entry.LootFolder)
			template = folder and folder:FindFirstChild(wanted)
			if not template then
				for _, tier in ipairs(lootRoot:GetChildren()) do
					local hit = tier:FindFirstChild(wanted)
					if hit then template = hit break end
				end
			end
		end
	end
	-- flat card art instead of a live 3D render whenever we have it (ported
	-- 2026-07-21: no viewports in the Sell frame when art exists) -- the
	-- same ItemImagesConfig art the Index / store / hotbar cards use. The
	-- viewport stays only as the fallback for art-less items.
	local art = ItemImagesConfig.Items[entry.Item or ""]
		or ItemImagesConfig.LuckyBlockLoot[entry.ModelName or entry.Item or ""]
	if icon and art then
		if viewport then viewport.Visible = false end
		local img = icon:FindFirstChild("ArtImage")
		if not img then
			img = Instance.new("ImageLabel")
			img.Name = "ArtImage"
			img.BackgroundTransparency = 1
			img.AnchorPoint = Vector2.new(0.5, 0.5)
			img.Position = UDim2.fromScale(0.5, 0.5)
			img.Size = UDim2.fromScale(0.92, 0.92)
			img.ScaleType = Enum.ScaleType.Fit
			img.ZIndex = viewport and viewport.ZIndex or icon.ZIndex
			img.Parent = icon
		end
		img.Image = art
	elseif viewport and template then
		buildLootViewport(viewport, template)
	end

	local sellBtn = card:FindFirstChild("SellButton")
	if sellBtn and sellBtn:IsA("TextButton") then
		sellBtn.MouseButton1Click:Connect(function()
			sellLootItem(entry.Uid)
		end)
	end

	return card
end

local function fetchClaimedLoot()
	local lootRemotes = getLootRemotes()
	local rf = lootRemotes and lootRemotes:FindFirstChild("GetClaimedLoot")
	if not rf then return {} end
	local ok, list = pcall(function() return rf:InvokeServer() end)
	if ok and type(list) == "table" then return list end
	return {}
end

local function fetchInventory()
	local allItems = {}
	local startIndex = 1
	local PAGE = 100
	local totalCount = nil
	while true do
		local ok, response = pcall(function()
			return RequestInventoryFunc:InvokeServer(startIndex, PAGE)
		end)
		if not ok or not response then break end
		for _, item in ipairs(response.Items or {}) do
			table.insert(allItems, item)
		end
		totalCount = response.TotalItemCount or #allItems
		if #allItems >= totalCount then break end
		startIndex = startIndex + (response.PageItemCount or PAGE)
		if (response.PageItemCount or 0) <= 0 then break end
	end
	return allItems
end

-- Inventory CashPerSec already includes mutation + level multipliers (see
-- InventoryService.buildUnifiedItemList) so the 10x sell price mirrors
-- the server-side getSellAllTotalPrice formula without re-deriving it.
local function computeClientSellPrice(item)
	local cps = tonumber(item.CashPerSec) or 0
	return math.floor(cps * 10)
end

local function updateSellAllTotal(total)
	local row = sellAllBar and sellAllBar:FindFirstChild("Total")
	if not row then return end
	local text = "+" .. formatCash(total or 0)
	local zero = (total or 0) <= 0
	for _, d in ipairs(row:GetDescendants()) do
		if d:IsA("TextLabel") then
			if zero then
				-- Sell All drops the total straight to $0; that long->short
				-- animated transition can strand per-char overlay state in a
				-- live session (renders as "+$$$0" mush until the frame is
				-- reopened). Write the zero plainly: drop the overlay, set the
				-- text, rebind so future non-zero changes animate again.
				AnimatedText.Unbind(d)
				d.Text = text
				AnimatedText.Bind(d)
			else
				d.Text = text
			end
		end
	end
end

local function populate()
	if not sellFrame or not scrollingFrame or not templateCard then return end
	-- SellAll() sells items one at a time and every server confirmation pushes
	-- an InventorySummaryUpdate -> populate() -> updateSellAllTotal() with an
	-- intermediate total. That burst of text rewrites keeps the AnimatedText
	-- per-char transition permanently mid-flight on the Total label (reads as
	-- "+$$$0" mush), so hold all repopulates until the final one SellAll()
	-- defers after the loop finishes.
	if isSellingAll then return end
	if isPopulating then
		pendingRepopulate = true
		return
	end
	isPopulating = true

	local allItems = fetchInventory()
	clearCards()

	local grandTotal = 0
	local layoutOrder = 1
	for _, item in ipairs(allItems) do
		if item.ItemType == "Brainrot" and item.BrainrotId then
			item.Rarity = getRarityForBrainrot(item.BrainrotId)
			item.SellPrice = computeClientSellPrice(item)
			grandTotal = grandTotal + (item.SellPrice or 0)
			local card = buildCard(item)
			card.LayoutOrder = layoutOrder
			layoutOrder = layoutOrder + 1
			card.Parent = scrollingFrame
			cardByUniqueId[item.ItemId] = card
		end
	end

	-- claimed rarity loot (underground items brought back to the surface)
	for _, entry in ipairs(fetchClaimedLoot()) do
		if entry.Uid then
			grandTotal = grandTotal + (entry.Value or 0)
			local card = buildLootCard(entry)
			card.LayoutOrder = layoutOrder
			layoutOrder = layoutOrder + 1
			card.Parent = scrollingFrame
			lootCards[entry.Uid] = card
		end
	end

	updateSellAllTotal(grandTotal)

	isPopulating = false
	if pendingRepopulate then
		pendingRepopulate = false
		task.defer(populate)
	end
end

function SellController.SellAll()
	if isSellingAll then return end
	isSellingAll = true
	local soldAnything = false

	-- claimed loot goes in one server call
	local lootRemotes = getLootRemotes()
	local sellAllLoot = lootRemotes and lootRemotes:FindFirstChild("SellAllLoot")
	if sellAllLoot then
		local ok, response = pcall(function() return sellAllLoot:InvokeServer() end)
		if ok and response and response.Success then
			soldAnything = true
		end
	end

	-- then every brainrot currently listed
	local ids = {}
	for uniqueId in pairs(cardByUniqueId) do
		table.insert(ids, uniqueId)
	end
	if #ids > 0 then
		local sellRemote = InventoryRemotes:FindFirstChild("SellBrainrot") or InventoryRemotes:WaitForChild("SellBrainrot", 5)
		if sellRemote then
			for _, uniqueId in ipairs(ids) do
				local ok, response = pcall(function() return sellRemote:InvokeServer(uniqueId) end)
				if ok and response and response.Success then
					soldAnything = true
				end
			end
		end
	end

	if soldAnything then
		playCashSound()
	end
	isSellingAll = false
	task.defer(populate)
end

function SellController.SellItem(uniqueId)
	local card = cardByUniqueId[uniqueId]
	local sellBtn = card and card:FindFirstChild("SellButton")
	if sellBtn then sellBtn.Active = false end

	local sellRemote = InventoryRemotes:FindFirstChild("SellBrainrot")
	if not sellRemote then
		sellRemote = InventoryRemotes:WaitForChild("SellBrainrot", 5)
	end
	if not sellRemote then
		if sellBtn then sellBtn.Active = true end
		return
	end

	local ok, response = pcall(function()
		return sellRemote:InvokeServer(uniqueId)
	end)
	if not ok or not response or not response.Success then
		if sellBtn then sellBtn.Active = true end
		return
	end

	playCashSound()

	if card then
		card:Destroy()
		cardByUniqueId[uniqueId] = nil
	end
end

local function findSellFrame()
	local gui = playerGui:WaitForChild("GUI", 30)
	if not gui then return nil end
	local folder = gui:WaitForChild("Folder", 30)
	if not folder then return nil end
	return folder:WaitForChild("SellFrame", 30)
end

function SellController.Init()
	sellFrame = findSellFrame()
	if not sellFrame then return end

	local selling = sellFrame:WaitForChild("Selling", 10)
	local outerScroll = selling and selling:WaitForChild("ScrollingFrame", 10)
	scrollingFrame = outerScroll and outerScroll:WaitForChild("ScrollingFrame", 10)
	if not scrollingFrame then return end

	-- The authored template card lives inside the ScrollingFrame as "AxeTemplate".
	-- Snapshot it under ReplicatedStorage so FrameAnimator's open/close tweens
	-- can't mutate it, then hide the in-tree template.
	local liveTemplate = scrollingFrame:WaitForChild("AxeTemplate", 10)
	if not liveTemplate then return end
	local snapshotHolder = ReplicatedStorage:FindFirstChild("SellTemplateSnapshot")
	if not snapshotHolder then
		snapshotHolder = Instance.new("Folder")
		snapshotHolder.Name = "SellTemplateSnapshot"
		snapshotHolder.Parent = ReplicatedStorage
	end
	templateCard = liveTemplate:Clone()
	templateCard.Visible = false
	templateCard.Parent = snapshotHolder
	liveTemplate.Visible = false

	-- golden SELL ALL banner above the list
	sellAllBar = selling:FindFirstChild("SellAllBar")
	local sellAllButton = sellAllBar and sellAllBar:FindFirstChild("SellAllButton")
	if sellAllButton and sellAllButton:IsA("TextButton") then
		sellAllButton.MouseButton1Click:Connect(function()
			task.spawn(SellController.SellAll)
		end)
	end

	-- The FrameAnimator open/close size tweens can strand the Total row's
	-- AnimatedText overlay with stale per-char geometry, so reopening the
	-- frame showed the total as overlapping garbled characters. Rebinding on
	-- every open throws away any stale overlay and shows the plain text; the
	-- next total change rebuilds the per-char animation from scratch.
	local function resetTotalTextAnimation()
		local row = sellAllBar and sellAllBar:FindFirstChild("Total")
		if not row then return end
		for _, d in ipairs(row:GetDescendants()) do
			if d:IsA("TextLabel") then
				AnimatedText.Unbind(d)
				AnimatedText.Bind(d)
			end
		end
	end

	sellFrame:GetPropertyChangedSignal("Visible"):Connect(function()
		if sellFrame.Visible then
			resetTotalTextAnimation()
			task.defer(populate)
		end
	end)

	InventorySummaryUpdate.OnClientEvent:Connect(function()
		if sellFrame.Visible then
			task.defer(populate)
		end
	end)

	-- repopulate when claimed loot changes (claim at surface / sold elsewhere)
	task.spawn(function()
		local lootRemotes = Remotes:WaitForChild("RarityLoot", 30)
		local changed = lootRemotes and lootRemotes:WaitForChild("LootChanged", 10)
		if changed then
			changed.OnClientEvent:Connect(function()
				if sellFrame.Visible then
					task.defer(populate)
				end
			end)
		end
	end)
end

return SellController
