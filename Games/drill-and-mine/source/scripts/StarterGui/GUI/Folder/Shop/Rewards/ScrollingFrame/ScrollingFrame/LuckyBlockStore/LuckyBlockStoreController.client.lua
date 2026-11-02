-- LuckyBlockStoreController: drives the store's "- Lucky Blocks -" tier cards
-- (LEGENDARY / GODLY / SECRET). Each card's DisplayViewport shows the tier's
-- block model with the Get Slim animation (40 deg/s yaw + bob + eased
-- 360-degree burst); the BrainrotCycle strip shows the granted block's LOOT
-- table (ReplicatedStorage.LuckyBlockLoot models as mini viewports + chance
-- %). Buying prompts the card's DEV PRODUCT through PurchaseService
-- (context "LootBlock_<key>"); LootBlockService grants one GrantBlockId
-- lucky block into the inventory per purchase -- repeatable, no OWNED
-- state.
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")

local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))
local ItemImagesConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("ItemImagesConfig"))
local BuyTransitionController = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Controllers"):WaitForChild("BuyTransitionController"))
local ViewportOutline = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Modules"):WaitForChild("ViewportOutline"))

local player = Players.LocalPlayer

-- Pre-release grant path: while a card has no ProductId yet the server hands
-- the block out directly (see LootBlockService.onRequestFreeLootBlock).
local RequestFreeLootBlockFunc = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("LuckyBlockService"):WaitForChild("RequestFreeLootBlock")
-- Dev-product purchases run through PurchaseService (server-side prompt +
-- "LootBlock_<key>" receipt context -> one block granted per purchase)
local PromptPurchaseFunc = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PurchaseService"):WaitForChild("PromptPurchase")

local holder = script.Parent
local ROBUX_GLYPH = utf8.char(0xE002)

local SPIN_RATE = math.rad(40)
local FLOAT_AMPLITUDE = 0.4
local FLOAT_FREQUENCY = 0.6
local BURST_INTERVAL = 2.0
local BURST_DURATION = 1.1
local BURST_STEP = math.pi * 2
local TWO_PI = math.pi * 2

local function easeInOutBack(t)
	if t <= 0 then return 0 end
	if t >= 1 then return 1 end
	local c2 = 1.70158 * 1.525
	if t < 0.5 then
		local u = 2 * t
		return (u * u * ((c2 + 1) * u - c2)) / 2
	else
		local u = 2 * t - 2
		return (u * u * ((c2 + 1) * u + c2) + 2) / 2
	end
end

local function populateViewport(viewport, blockId)
	local folder = ReplicatedStorage:FindFirstChild("LuckyBlocks")
	local template = (folder and folder:FindFirstChild(blockId)) or ReplicatedStorage:FindFirstChild(blockId)
	if not template then
		warn("[LuckyBlockStore] no block template:", blockId)
		return
	end

	-- clear the edit-time preview saved in the place
	for _, c in ipairs(viewport:GetChildren()) do
		if c:IsA("Model") or c:IsA("Camera") then c:Destroy() end
	end

	local model = template:Clone()
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
			d.CanTouch = false
			d.CanQuery = false
			d.Massless = true
		elseif d:IsA("Script") or d:IsA("LocalScript") then
			d:Destroy()
		end
	end
	local primary = model:IsA("BasePart") and model or model.PrimaryPart
	if not primary then
		for _, d in ipairs(model:GetDescendants()) do
			if d:IsA("BasePart") then
				if not primary or (d.Size.X * d.Size.Y * d.Size.Z) > (primary.Size.X * primary.Size.Y * primary.Size.Z) then
					primary = d
				end
			end
		end
	end
	if not primary then return end

	local container = Instance.new("Model")
	container.Name = "LuckyBlockContainer"
	model.Parent = container
	container.PrimaryPart = primary
	container.Parent = viewport

	-- Frame exactly like Get Slim's runtime shop: measured there, the core
	-- question-mark block fills ~43% of the viewport height and sits dead-
	-- center. Our block models are single fused meshes whose wing decorations
	-- inflate one axis, so the mesh's SMALLEST bbox dimension is the block-
	-- size proxy: d = blockSize / (2 * 0.425 * tan(35 deg)) = blockSize * 1.68.
	-- Wings may overshoot the frustum edges slightly -- same read as the
	-- reference cards where wings span the full card width.
	local origPivot = container:GetPivot()
	local bboxCF, bboxSize = container:GetBoundingBox()
	local homeRot = origPivot - origPivot.Position
	container:PivotTo(homeRot + (origPivot.Position - bboxCF.Position))

	local coreExtent = math.min(bboxSize.X, bboxSize.Y, bboxSize.Z)
	local camera = Instance.new("Camera")
	camera.CFrame = CFrame.new(Vector3.new(0, 0, math.max(coreExtent * 1.68, 3)), Vector3.new(0, 0, 0))
	camera.Parent = viewport
	viewport.CurrentCamera = camera

	-- Anchor the animation on the CENTERED pivot cframe, not (0,bob,0): these
	-- fused meshes have their pivot low in the model, so snapping the pivot to
	-- the origin every frame hoisted the visible block above the viewport
	-- center (the "floating too high" bug). Rotating the centered cframe about
	-- the world origin keeps the bbox center pinned while the block spins.
	local centered = container:GetPivot()
	local DOWN_BIAS = -0.4 -- studs; sit slightly low-center per user taste

	local floatPhase = math.random() * TWO_PI
	local burstPhaseRemaining = math.random() * BURST_INTERVAL
	local burstElapsed = BURST_DURATION
	local burstOffset = 0

	RunService.RenderStepped:Connect(function(dt)
		if not container.Parent then return end
		local now = os.clock()
		if burstPhaseRemaining > 0 then
			burstPhaseRemaining = burstPhaseRemaining - dt
		else
			burstElapsed = burstElapsed + dt
			if burstElapsed >= BURST_INTERVAL then
				burstOffset = (burstOffset + BURST_STEP) % TWO_PI
				burstElapsed = 0
			end
		end
		local burstYaw
		if burstElapsed < BURST_DURATION then
			burstYaw = easeInOutBack(burstElapsed / BURST_DURATION) * BURST_STEP
		else
			burstYaw = BURST_STEP
		end
		local yaw = (now * SPIN_RATE) % TWO_PI + burstOffset + burstYaw
		local bob = math.sin((now + floatPhase) * FLOAT_FREQUENCY * TWO_PI) * FLOAT_AMPLITUDE
		container:PivotTo(CFrame.new(0, bob + DOWN_BIAS, 0) * CFrame.Angles(0, yaw, 0) * centered)
	end)
end

-- Loot strip: one slot per entry of the granted block's Loot table, rendered
-- as a mini viewport of the actual loot model (the loot items have no 2D
-- icons) with the roll chance % underneath. Slot order = config order, so
-- the rarest (single-digit %) loot sits last, matching the user's lineup.
local LOOT_VIEW_DIR = Vector3.new(1, 0.7, -1).Unit
local LOOT_VIEW_FOV = 30

local function buildLootSlotViewport(slot, lootCfg)
	local lootRoot = ReplicatedStorage:FindFirstChild("LuckyBlockLoot")
	local tierFolder = lootRoot and lootCfg.LootFolder and lootRoot:FindFirstChild(lootCfg.LootFolder)
	local template = tierFolder and tierFolder:FindFirstChild(lootCfg.ModelName)
	local icon = slot:FindFirstChild("Icon")
	if not icon then return false end

	-- flat card art (ItemImagesConfig) replaces the live loot render when we
	-- have it (BlackHole is the only loot still missing art -> viewport)
	local image = ItemImagesConfig.LuckyBlockLoot[lootCfg.ModelName]
	if image then
		local oldViewport = slot:FindFirstChild("LootIcon")
		if oldViewport then oldViewport:Destroy() end
		icon.Image = image
		icon.ScaleType = Enum.ScaleType.Fit
		icon.Visible = true
		return true
	end
	if not template then return false end

	local viewport = slot:FindFirstChild("LootIcon")
	if not viewport then
		viewport = Instance.new("ViewportFrame")
		viewport.Name = "LootIcon"
		-- Sized INSIDE the slot (the authored Icon overflows its slot bounds
		-- slightly, which made round loot renders clip past the card frame).
		viewport.AnchorPoint = Vector2.new(0.5, 0)
		viewport.Position = UDim2.new(0.5, 0, 0.02, 0)
		viewport.Size = UDim2.new(0.88, 0, 0.82, 0)
		viewport.BackgroundTransparency = 1
		viewport.LightDirection = Vector3.new(-0.4, -1, -0.3)
		viewport.LightColor = Color3.fromRGB(255, 245, 220)
		viewport.Ambient = Color3.fromRGB(170, 170, 180)
		viewport.ZIndex = icon.ZIndex
		viewport.Parent = slot
	end
	icon.Visible = false

	for _, c in ipairs(viewport:GetChildren()) do
		if c:IsA("Model") or c:IsA("Camera") then c:Destroy() end
	end

	local model = template:Clone()
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
			-- ViewportFrames can't render the ForceField shader (the shells
			-- came out near-invisible) -- swap to translucent Neon so the orb
			-- bodies actually read in the card.
			if d.Material == Enum.Material.ForceField then
				d.Material = Enum.Material.Neon
				d.Transparency = math.max(d.Transparency, 0.45)
			end
		elseif d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam") then
			-- not rendered in viewports; drop so nothing lingers
			d:Destroy()
		end
	end
	local bbCF, bbSize = model:GetBoundingBox()
	model:PivotTo(CFrame.new(-bbCF.Position) * model:GetPivot())
	model.Parent = viewport

	local camera = Instance.new("Camera")
	camera.FieldOfView = LOOT_VIEW_FOV
	local halfExtent = math.max(bbSize.X, bbSize.Y, bbSize.Z) * 0.5
	local distance = (halfExtent / math.sin(math.rad(LOOT_VIEW_FOV) * 0.5)) * 1.35
	camera.CFrame = CFrame.lookAt(LOOT_VIEW_DIR * distance, Vector3.zero)
	camera.Parent = viewport
	viewport.CurrentCamera = camera
	ViewportOutline.Add(viewport, model, camera)
	return true
end

-- ---------------------------------------------------------------------
-- Chance label styling (user spec):
--   every chance label -> BLACK outline
--   rarest (last) loot -> flowing rainbow text (tagged VipTagGradient so
--     VipTagFlowClient's scrolling rainbow drives it, same as the VIP tag)
--   second-rarest      -> black/white stripes scrolling slowly downward
-- ---------------------------------------------------------------------
local STRIPE_PERIODS = 3 -- stripe pattern repeats 3x across the text height
local STRIPE_SPEED = 0.12 -- pattern-heights per second (slow, infinite)
local stripeGradients = {}

local function makeStripeSequence()
	local white = Color3.new(1, 1, 1)
	local black = Color3.new(0, 0, 0)
	local kps = {}
	local band = 1 / (STRIPE_PERIODS * 2)
	for i = 0, STRIPE_PERIODS * 2 - 1 do
		local c = (i % 2 == 0) and white or black
		local t0 = i * band
		local t1 = (i + 1) * band
		table.insert(kps, ColorSequenceKeypoint.new(t0, c))
		table.insert(kps, ColorSequenceKeypoint.new(math.min(t1 - 0.001, 1), c))
	end
	kps[#kps] = ColorSequenceKeypoint.new(1, kps[#kps].Value)
	return ColorSequence.new(kps)
end

local function styleChanceLabel(slot, kind)
	local chance = slot:FindFirstChild("Chance")
	if not chance then return end
	-- black outline on every chance label (user request)
	for _, d in ipairs(chance:GetDescendants()) do
		if d:IsA("UIStroke") then
			d.Color = Color3.new(0, 0, 0)
		end
	end
	chance.TextColor3 = Color3.new(1, 1, 1)

	local grad = chance:FindFirstChild("ChanceFxGradient")
	if kind == nil then
		if grad then grad:Destroy() end
		return
	end
	if not grad then
		grad = Instance.new("UIGradient")
		grad.Name = "ChanceFxGradient"
		grad.Parent = chance
	end
	if kind == "rainbow" then
		grad.Rotation = 0
		grad.Offset = Vector2.zero
		CollectionService:AddTag(grad, "VipTagGradient")
	elseif kind == "stripes" then
		CollectionService:RemoveTag(grad, "VipTagGradient")
		grad.Rotation = 90
		grad.Color = makeStripeSequence()
		table.insert(stripeGradients, grad)
	end
end

-- Scrolls the stripe gradients downward forever. Shifting the offset by one
-- pattern period (1/STRIPE_PERIODS) lands on an identical pattern, so the
-- wrap is seamless.
RunService.RenderStepped:Connect(function()
	if #stripeGradients == 0 then return end
	local period = 1 / STRIPE_PERIODS
	local off = (os.clock() * STRIPE_SPEED) % period
	for i = #stripeGradients, 1, -1 do
		local g = stripeGradients[i]
		if g.Parent then
			g.Offset = Vector2.new(0, off)
		else
			table.remove(stripeGradients, i)
		end
	end
end)

local function populateLoot(card, storeCfg)
	local blockCfg = storeCfg.GrantBlockId and GameConfig.LuckyBlocks
		and GameConfig.LuckyBlocks[storeCfg.GrantBlockId]
	local pool = blockCfg and blockCfg.Loot or {}
	if #pool == 0 then return end -- keep authored placeholders

	local total = 0
	for _, e in ipairs(pool) do total += (e.Chance or 0) end
	if total <= 0 then return end

	local slots = {}
	for _, s in ipairs(card.BrainrotCycle:GetChildren()) do
		if s.Name == "BrainrotImage" then table.insert(slots, s) end
	end
	table.sort(slots, function(a, b) return a.LayoutOrder < b.LayoutOrder end)

	for i, slot in ipairs(slots) do
		local e = pool[i]
		local lootCfg = e and GameConfig.LuckyBlocks[e.LootId]
		if e and lootCfg then
			slot.Visible = true
			buildLootSlotViewport(slot, lootCfg)
			local pct = (e.Chance / total) * 100
			slot.Chance.Text = (pct >= 1) and string.format("%d%%", math.floor(pct + 0.5)) or string.format("%.1f%%", pct)
			-- rarest = rainbow, second-rarest = scrolling stripes, rest plain
			local kind
			if i == #pool then
				kind = "rainbow"
			elseif i == #pool - 1 then
				kind = "stripes"
			end
			styleChanceLabel(slot, kind)
		else
			slot.Visible = false
		end
	end
end

local storeCfg = GameConfig.Shop and GameConfig.Shop.LuckyBlockStore or {}
for _, key in ipairs({ "Legendary", "Godly", "Secret" }) do
	local card = holder:WaitForChild(key)
	local cfg = storeCfg[key]
	if cfg then
		populateViewport(card:WaitForChild("DisplayViewport"), cfg.DisplayBlockId or cfg.BlockId)
		populateLoot(card, cfg)
		local buy = card:WaitForChild("BuyButton")
		local price = buy:FindFirstChild("Price")
		local authoredPrice = ROBUX_GLYPH .. tostring(cfg.PriceRobux or "")
		if price and cfg.PriceRobux then
			price.Text = authoredPrice
		end

		-- Dev product, REPEATABLE: no OWNED state -- every purchase grants
		-- one more block, so the button stays buyable forever.
		buy.MouseButton1Click:Connect(function()
			if not cfg.ProductId or cfg.ProductId == 0 then
				-- Pre-release: no product ids yet -- grant the block straight
				-- into the inventory so the flow is testable end to end. Once
				-- the real ProductId is set this branch is dead and the
				-- product prompt below takes over.
				task.spawn(function()
					pcall(function()
						RequestFreeLootBlockFunc:InvokeServer(key)
					end)
				end)
				return
			end
			task.spawn(function()
				pcall(function()
					PromptPurchaseFunc:InvokeServer(cfg.ProductId, "LootBlock_" .. key)
				end)
			end)
		end)
	end
end
