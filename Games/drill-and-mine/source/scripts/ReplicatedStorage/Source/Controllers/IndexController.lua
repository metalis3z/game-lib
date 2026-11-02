--[[
	IndexController -- the loot Index (PlayerGui.GUI.Folder.Index).
	Catalogs EVERY underground rarity loot item (RarityItemsConfig.Items):
	one card per item, sorted Common -> Divine, each rendering the real
	model from ReplicatedStorage.RarityItems.<Rarity>.<Item> inside a
	ViewportFrame with the same fitted 3/4 camera the Drill shop cards use.
	Discovered state persists in PlayerData.LootDiscovered (marked by
	RarityItemSpawner on first pickup); undiscovered items render as a
	black silhouette with "???".

	The mutation tab row was brainrot-era UI and is hidden; the progressbar
	now shows overall discovery progress instead of per-tab index rewards.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RarityItemsConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("RarityItemsConfig"))
local ItemImagesConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("ItemImagesConfig"))
local ViewportOutline = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Modules"):WaitForChild("ViewportOutline"))
local ViewportScrollCuller = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Modules"):WaitForChild("ViewportScrollCuller"))

local IndexController = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local DataRemotes = Remotes:WaitForChild("PlayerDataService")
local DataUpdateEvent = DataRemotes:WaitForChild("DataUpdate")
local RequestDataFunc = DataRemotes:WaitForChild("RequestData")

local GradientsRoot = ReplicatedStorage:WaitForChild("Gradients")
local RarityGradientFolder = GradientsRoot:WaitForChild("Rarity")
local ItemTemplates = ReplicatedStorage:WaitForChild("RarityItems")

local player = Players.LocalPlayer

local indexFrame = nil
local scrollingFrame = nil
local lockedTemplate = nil
local unlockedTemplate = nil
-- Snapshots of the authored templates, parented OUTSIDE the IndexFrame so
-- FrameAnimator's open/close transparency tweens can't mutate them. Cards are
-- cloned from these snapshots, never from the live in-tree templates.
local lockedTemplateSnapshot = nil
local unlockedTemplateSnapshot = nil
local templateHolder = nil
local topFrame = nil
local progressbarFrame = nil

local lootDiscovered = {}

-- ===== catalog =====

local sortedItemsCache = nil
local function getSortedItems()
	if sortedItemsCache then return sortedItemsCache end
	local list = {}
	for _, rarityName in ipairs(RarityItemsConfig.RarityOrder) do
		for _, itemName in ipairs(RarityItemsConfig.Items[rarityName] or {}) do
			table.insert(list, { Item = itemName, Rarity = rarityName })
		end
	end
	sortedItemsCache = list
	return list
end

-- ===== helpers =====

-- Set text on a label and any nested 'Double'/'Amount' twin so the stroke-pair stays in sync.
local function setLabelText(label, text)
	if not label then return end
	if label:IsA("TextLabel") or label:IsA("TextButton") or label:IsA("TextBox") then
		label.Text = text
	end
	for _, descendant in ipairs(label:GetDescendants()) do
		if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
			descendant.Text = text
		end
	end
end

-- Replace any UIGradient direct child of `host` with a clone of `gradient`.
local function applyGradient(host, gradient)
	if not host then return end
	for _, c in ipairs(host:GetChildren()) do
		if c:IsA("UIGradient") then c:Destroy() end
	end
	if gradient then
		gradient:Clone().Parent = host
	end
end

-- ===== header + progressbar =====

local function countDiscovered()
	local unlocked = 0
	local items = getSortedItems()
	for _, entry in ipairs(items) do
		if lootDiscovered[entry.Item] then
			unlocked += 1
		end
	end
	return unlocked, #items
end

local function refreshHeader()
	local unlocked, total = countDiscovered()
	local pct = total > 0 and math.floor((unlocked / total) * 100) or 0
	if topFrame then
		setLabelText(topFrame:FindFirstChild("Discovered"), unlocked .. "/" .. total .. " discovered")
		setLabelText(topFrame:FindFirstChild("Completion"), pct .. "% complete")
	end
	if progressbarFrame then
		local fill = progressbarFrame:FindFirstChild("Fill")
		if fill then
			local progress = total > 0 and unlocked / total or 0
			fill.Size = UDim2.new(progress, 0, fill.Size.Y.Scale, fill.Size.Y.Offset)
		end
		setLabelText(progressbarFrame:FindFirstChild("Info"), "Discover every item hidden in the mines!")
		setLabelText(progressbarFrame:FindFirstChild("Completion"), unlocked .. "/" .. total)
	end
end

-- ===== viewport (same fitted 3/4 camera as the Drill shop cards) =====

local VIEWPORT_FOV = 30
local VIEWPORT_PADDING = 1.1

local function setupSlotViewport(card, entry, silhouette)
	local icon = card:FindFirstChild("Icon")
	-- flat card art (ItemImagesConfig) replaces the live viewport when we have
	-- it; undiscovered = the same art tinted pure black, like the silhouette
	local image = icon and ItemImagesConfig.Items[entry.Item]
	if image then
		icon.Image = image
		icon.ScaleType = Enum.ScaleType.Fit
		icon.ImageColor3 = silhouette and Color3.new(0, 0, 0) or Color3.new(1, 1, 1)
		icon.Visible = true
		return true
	end
	local tierFolder = ItemTemplates:FindFirstChild(entry.Rarity)
	local template = tierFolder and tierFolder:FindFirstChild(entry.Item)
	if not template then return false end

	local viewport = Instance.new("ViewportFrame")
	viewport.Name = "ModelViewport"
	viewport.BackgroundTransparency = 1
	if silhouette then
		-- undiscovered = pure flat black: no light, no ambient, no shading
		viewport.Ambient = Color3.new(0, 0, 0)
		viewport.LightColor = Color3.new(0, 0, 0)
	else
		viewport.Ambient = Color3.fromRGB(185, 185, 185)
		viewport.LightColor = Color3.fromRGB(255, 255, 255)
	end
	viewport.LightDirection = Vector3.new(-0.5, -1, -1.5)
	if icon then
		viewport.AnchorPoint = icon.AnchorPoint
		viewport.Position = icon.Position
		viewport.Size = icon.Size
		viewport.ZIndex = icon.ZIndex
		local ar = icon:FindFirstChildOfClass("UIAspectRatioConstraint")
		if ar then
			local arc = Instance.new("UIAspectRatioConstraint")
			arc.AspectRatio = ar.AspectRatio
			arc.Parent = viewport
		end
		icon.Visible = false
	else
		viewport.AnchorPoint = Vector2.new(0.5, 0.5)
		viewport.Position = UDim2.fromScale(0.5, 0.45)
		viewport.Size = UDim2.fromScale(0.8, 0.62)
	end

	local model = template:Clone()
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BaseScript") or d:IsA("ModuleScript") or d:IsA("Sound")
			or d:IsA("SurfaceGui") or d:IsA("BillboardGui") or d:IsA("ProximityPrompt") then
			d:Destroy()
		elseif d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
			d.CanQuery = false
			d.CanTouch = false
			if silhouette then
				d.Color = Color3.new(0, 0, 0)
				d.Material = Enum.Material.SmoothPlastic
				d.Reflectance = 0
				if d:IsA("MeshPart") then d.TextureID = "" end
			end
		elseif silhouette then
			if d:IsA("Decal") or d:IsA("Texture") then
				d.Transparency = 1
			elseif d:IsA("SurfaceAppearance") then
				d:Destroy()
			end
		end
	end

	-- center the model on the viewport origin, then fit the camera to its
	-- bounding sphere for the 3/4 view (identical framing to the Drill shop)
	local bbCF, bbSize = model:GetBoundingBox()
	model:PivotTo(CFrame.new(-bbCF.Position) * model:GetPivot())
	model.Parent = viewport

	local radius = math.max(bbSize.Magnitude / 2, 0.1)
	local camera = Instance.new("Camera")
	camera.FieldOfView = VIEWPORT_FOV
	local distance = radius / math.tan(math.rad(VIEWPORT_FOV / 2)) * VIEWPORT_PADDING
	camera.CFrame = CFrame.fromEulerAnglesYXZ(math.rad(-12), math.rad(35), 0) * CFrame.new(0, 0, distance)
	camera.Parent = viewport
	viewport.CurrentCamera = camera

	-- discovered items get the sticker outline; the undiscovered silhouette
	-- is already all-black, an outline there would be invisible anyway
	if not silhouette then
		ViewportOutline.Add(viewport, model, camera)
	end

	viewport.Parent = card
	return true
end

-- ===== cards =====

local function buildCard(entry, index)
	local isUnlocked = lootDiscovered[entry.Item] == true
	local snapshot = isUnlocked and unlockedTemplateSnapshot or lockedTemplateSnapshot
	local card = snapshot:Clone()
	card.Visible = true
	card.Name = "Item_" .. entry.Rarity .. "_" .. entry.Item
	card.LayoutOrder = index

	local viewportOk = setupSlotViewport(card, entry, not isUnlocked)
	local icon = card:FindFirstChild("Icon")
	if not viewportOk and icon then
		icon.Visible = false
	end

	local rarityGradient = RarityGradientFolder:FindFirstChild(entry.Rarity)

	setLabelText(card:FindFirstChild("BrainrotName"), isUnlocked and entry.Item or "???")

	local rarityLabel = card:FindFirstChild("Rarity")
	if rarityLabel then
		-- rarity is part of the reveal: shown (with its gradient) once obtained
		setLabelText(rarityLabel, isUnlocked and entry.Rarity or "???")
		applyGradient(rarityLabel, isUnlocked and rarityGradient or nil)
	end

	local questionmark = card:FindFirstChild("Questionmark")
	if questionmark then
		questionmark.Visible = not isUnlocked
	end

	-- Unlocked tiles carry the rarity color on their gradients, matching the
	-- rarity-tinted cards elsewhere in the game.
	if isUnlocked and rarityGradient then
		for _, descendant in ipairs(card:GetDescendants()) do
			if descendant:IsA("UIGradient") and descendant.Parent ~= rarityLabel
				and not descendant:FindFirstAncestor("ModelViewport") then
				descendant.Color = rarityGradient.Color
				descendant.Transparency = rarityGradient.Transparency
			end
		end
	end

	return card
end

-- ===== async build =====

local buildToken = 0
local built = false
local YIELD_TIME_BUDGET = 0.005

local function clearCards()
	for _, c in ipairs(scrollingFrame:GetChildren()) do
		if c.Name:sub(1, 5) == "Item_" then
			c:Destroy()
		end
	end
end

local function rebuildAsync()
	buildToken += 1
	local myToken = buildToken
	built = false
	clearCards()
	local lastYield = os.clock()
	for i, entry in ipairs(getSortedItems()) do
		if buildToken ~= myToken then return end
		local card = buildCard(entry, i)
		card.Parent = scrollingFrame
		-- hand a frame back every ~5ms of card building so weak devices stay smooth
		if os.clock() - lastYield > YIELD_TIME_BUDGET then
			task.wait()
			if buildToken ~= myToken then return end
			lastYield = os.clock()
		end
	end
	built = true
end

-- ===== setup =====

local function snapshotTemplates()
	-- Detached holder so FrameAnimator's descendant scan doesn't find the snapshots.
	templateHolder = Instance.new("Folder")
	templateHolder.Name = "IndexTemplateSnapshots"
	templateHolder.Parent = ReplicatedStorage

	unlockedTemplateSnapshot = unlockedTemplate:Clone()
	unlockedTemplateSnapshot.Visible = false
	unlockedTemplateSnapshot.Parent = templateHolder

	lockedTemplateSnapshot = lockedTemplate:Clone()
	lockedTemplateSnapshot.Visible = false
	lockedTemplateSnapshot.Parent = templateHolder
end

function IndexController.Init()
	if not player then return end
	local playerGui = player:WaitForChild("PlayerGui")

	local gui = playerGui:WaitForChild("GUI", 10)
	if not gui then return end
	local folder = gui:WaitForChild("Folder", 10)
	if not folder then return end
	indexFrame = folder:WaitForChild("Index", 10)
	if not indexFrame then return end

	topFrame = indexFrame:WaitForChild("TopFrame", 10)
	progressbarFrame = indexFrame:FindFirstChild("Progressbar")

	-- brainrot-era mutation tabs: hidden, the index is one all-items grid now
	local buttons = indexFrame:FindFirstChild("Buttons")
	if buttons then buttons.Visible = false end

	local rewards = indexFrame:WaitForChild("Rewards", 10)
	if not rewards then return end
	local outerScroll = rewards:WaitForChild("ScrollingFrame", 10)
	if not outerScroll then return end
	scrollingFrame = outerScroll:WaitForChild("ScrollingFrame", 10)
	if not scrollingFrame then return end

	unlockedTemplate = scrollingFrame:FindFirstChild("Discovered")
	lockedTemplate = scrollingFrame:FindFirstChild("Undiscovered")
	if not unlockedTemplate and not lockedTemplate then
		warn("[IndexController] expected Discovered + Undiscovered templates in the Index scroll")
		return
	end
	unlockedTemplate = unlockedTemplate or lockedTemplate
	lockedTemplate = lockedTemplate or unlockedTemplate
	unlockedTemplate.Visible = false
	lockedTemplate.Visible = false

	snapshotTemplates()

	-- render only the item viewports near the visible scroll window (52
	-- live card models at once otherwise all re-render every frame)
	ViewportScrollCuller.Attach(scrollingFrame)

	refreshHeader()

	task.spawn(function()
		for _ = 1, 20 do
			local ok, fullData = pcall(function()
				return RequestDataFunc:InvokeServer()
			end)
			if ok and fullData then
				lootDiscovered = type(fullData.LootDiscovered) == "table" and fullData.LootDiscovered or {}
				refreshHeader()
				task.spawn(rebuildAsync)
				return
			end
			task.wait(0.5)
		end
	end)

	DataUpdateEvent.OnClientEvent:Connect(function(statName, value)
		if statName ~= "LootDiscovered" then return end
		lootDiscovered = type(value) == "table" and value or {}
		if indexFrame.Visible then
			task.spawn(rebuildAsync)
		else
			-- abort any in-flight build; the next open rebuilds with fresh data
			buildToken += 1
			built = false
		end
		refreshHeader()
	end)

	indexFrame:GetPropertyChangedSignal("Visible"):Connect(function()
		if not indexFrame.Visible then
			-- keep the 52 card viewports off through the close shrink
			ViewportScrollCuller.SetSuspended(scrollingFrame, true)
			return
		end
		-- viewports stay hidden through the open size tween (every
		-- AbsoluteSize change re-renders every visible viewport that
		-- frame) and reveal as the Back-ease settles
		ViewportScrollCuller.SetSuspended(scrollingFrame, true)
		task.delay(0.15, function()
			if indexFrame.Visible then
				ViewportScrollCuller.SetSuspended(scrollingFrame, false)
			end
		end)
		task.delay(0.05, function()
			if not indexFrame.Visible then return end
			if not built then
				task.spawn(rebuildAsync)
			end
			refreshHeader()
		end)
	end)
end

return IndexController
