-- PickUpButtonsController: Drop / HomeButton shown whenever the player is
-- currently carrying a lucky block. Previously this also required the player
-- to be inside a rarity island's AABB, which caused the buttons to collapse
-- the moment the player stepped onto a bridge plank between islands -- the
-- exact spot where players actually need the Drop / Home prompts to be
-- visible. Now the carry state alone drives visibility.
--
-- Drop button  -> fires IslandBrainrot.DropCarry. Server respawns the world
--                 lucky block at the player's feet with its preserved
--                 SpawnedAt/Lifetime so the timer doesn't reset.
-- HomeButton   -> prompts the Robux dev-product purchase (id 3595863792).
--                 On receipt PurchaseService's HomeTeleport context deposits
--                 the carry to the player's lucky-block inventory and
--                 teleports the player to their plot SpawnLocation.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local Workspace = game:GetService("Workspace")

local BrainrotController = require(ReplicatedStorage.Source.Controllers.BrainrotController)

local HOME_PRODUCT_ID = 3595863792
-- Pop-in is the only feedback on these buttons appearing, so we lean into it.
-- Drop is the primary action -> snappier, arrives first. Home is secondary ->
-- staggered + slightly longer so it announces itself as a separate beat.
local DROP_TWEEN_TIME = 0.32
local HOME_TWEEN_TIME = 0.42
local HOME_STAGGER_DELAY = 0.22
local COLLAPSE_TIME = 0.18
local ISLAND_AABB_PADDING_Y = 8 -- generous Y so jumping doesn't drop the prompt

local player = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local IslandRemotes = Remotes:WaitForChild("IslandBrainrot", 30)
local DropCarryEvent = IslandRemotes and IslandRemotes:WaitForChild("DropCarry", 30)
local PurchaseRemotes = Remotes:WaitForChild("PurchaseService")
local PromptPurchaseFunc = PurchaseRemotes:WaitForChild("PromptPurchase")

local PickUpButtonsController = {}

local function findIslands()
	local islandsFolder = Workspace:FindFirstChild("Assets")
	islandsFolder = islandsFolder and islandsFolder:FindFirstChild("Islands")
	local islands = {}
	if islandsFolder then
		for _, c in ipairs(islandsFolder:GetChildren()) do
			if c:IsA("BasePart") then table.insert(islands, c) end
		end
	end
	return islands
end

local function isInsideAnyIsland(pos, islands)
	for _, island in ipairs(islands) do
		local lp = island.CFrame:PointToObjectSpace(pos)
		if math.abs(lp.X) <= island.Size.X / 2
			and math.abs(lp.Y) <= island.Size.Y / 2 + ISLAND_AABB_PADDING_Y
			and math.abs(lp.Z) <= island.Size.Z / 2 then
			return true
		end
	end
	return false
end

-- The pop UIScale is *pre-created at Init* and held at Scale=0 so the first
-- rendered frame after `frame.Visible = true` never sees the button at full
-- size. Lazy creation inside popIn left a single-frame full-size flash that
-- read as "the buttons just appeared, no animation". Authored hover scaling
-- already lives on a separate UIScale ("HoverScale") and two UIScales stack
-- multiplicatively, so this one only contributes the pop motion.
local activeTweens = {}
local function getScale(button)
	local scale = button:FindFirstChild("_ZoomScale")
	if not scale then
		scale = Instance.new("UIScale")
		scale.Name = "_ZoomScale"
		scale.Scale = 0
		scale.Parent = button
	end
	return scale
end

local function cancelTween(button)
	local t = activeTweens[button]
	if t then t:Cancel() end
	activeTweens[button] = nil
end

local function popIn(button, duration, delaySec)
	cancelTween(button)
	local scale = getScale(button)
	scale.Scale = 0
	local info = TweenInfo.new(duration, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, delaySec or 0)
	local tw = TweenService:Create(scale, info, { Scale = 1 })
	activeTweens[button] = tw
	tw:Play()
end

local function collapseOut(button, duration)
	cancelTween(button)
	local scale = button:FindFirstChild("_ZoomScale")
	if not scale then return end
	local info = TweenInfo.new(duration, Enum.EasingStyle.Back, Enum.EasingDirection.In)
	local tw = TweenService:Create(scale, info, { Scale = 0 })
	activeTweens[button] = tw
	tw:Play()
end

function PickUpButtonsController.Init()
	local pg = player:WaitForChild("PlayerGui")
	local hud = pg:WaitForChild("GUI"):WaitForChild("HUD")
	local frame = hud:WaitForChild("PickUpButtons")
	local dropBtn = frame:WaitForChild("DropButton")
	local homeBtn = frame:WaitForChild("HomeButton")

	-- Hide on load. The frame is shown by the per-frame visibility check.
	frame.Visible = false

	-- Pre-create the pop UIScale at 0 so the buttons start invisibly small.
	-- See getScale comment for why this matters (first-frame flash).
	getScale(dropBtn).Scale = 0
	getScale(homeBtn).Scale = 0

	-- Populate the HomeButton's Price label with the product cost. PriceInRobux
	-- comes back from MarketplaceService asynchronously; sub in "..." until it
	-- arrives so the label doesn't read "100".
	local priceLabel = homeBtn:FindFirstChild("Price")
	local function setPriceText(text)
		if not priceLabel then return end
		priceLabel.Text = text
		local inner = priceLabel:FindFirstChild("Double")
		if inner and inner:IsA("TextLabel") then inner.Text = text end
	end
	setPriceText("...")
	task.spawn(function()
		local ok, info = pcall(function()
			return MarketplaceService:GetProductInfo(HOME_PRODUCT_ID, Enum.InfoType.Product)
		end)
		if ok and info and info.PriceInRobux then
			setPriceText(tostring(info.PriceInRobux) .. " R$")
		end
	end)

	-- Click handlers.
	dropBtn.MouseButton1Click:Connect(function()
		if DropCarryEvent then DropCarryEvent:FireServer() end
	end)
	homeBtn.MouseButton1Click:Connect(function()
		pcall(function() PromptPurchaseFunc:InvokeServer(HOME_PRODUCT_ID, "HomeTeleport") end)
	end)

	local lastVisible = false
	local POLL_INTERVAL = 0.15
	local accum = 0
	RunService.Heartbeat:Connect(function(dt)
		accum = accum + dt
		if accum < POLL_INTERVAL then return end
		accum = 0

		-- Visibility now depends only on carry state: a player carrying a
		-- lucky block needs the Drop / Home prompts wherever they are
		-- (especially on bridge planks between islands). The previous island
		-- AABB gate hid the buttons exactly where the player needed them.
		local carry = BrainrotController.GetCarryStackCount and BrainrotController.GetCarryStackCount() or 0
		local shouldShow = carry > 0

		if shouldShow == lastVisible then return end
		lastVisible = shouldShow

		if shouldShow then
			-- Force scale to 0 BEFORE Visible=true so the first paint can't
			-- catch the button at full size.
			getScale(dropBtn).Scale = 0
			getScale(homeBtn).Scale = 0
			frame.Visible = true
			popIn(dropBtn, DROP_TWEEN_TIME, 0)
			popIn(homeBtn, HOME_TWEEN_TIME, HOME_STAGGER_DELAY)
		else
			collapseOut(dropBtn, COLLAPSE_TIME)
			collapseOut(homeBtn, COLLAPSE_TIME)
			task.delay(COLLAPSE_TIME + 0.02, function()
				if not lastVisible then frame.Visible = false end
			end)
		end
	end)
end

return PickUpButtonsController