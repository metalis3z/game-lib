local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LostRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("LostBrainrotService")
local ShowEvent = LostRemotes:WaitForChild("Show")
local HideEvent = LostRemotes:WaitForChild("Hide")
local GiveUpEvent = LostRemotes:WaitForChild("GiveUp")

local PurchaseRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PurchaseService")
local PromptPurchaseFunc = PurchaseRemotes:WaitForChild("PromptPurchase")

local FrameAnimator = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Modules"):WaitForChild("FrameAnimator"))
local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))

local LuckyBlockModels = ReplicatedStorage:WaitForChild("LuckyBlocks")

-- Viewport tuning copied from IndexController so the lucky-block models render
-- with the same framing/lighting as the rest of the game's slot viewports.
local VIEWPORT_FOV = 30
local VIEWPORT_VIEW_DIR = Vector3.new(1, 0.7, -1).Unit
local VIEWPORT_PADDING = 1.45
local VIEWPORT_LIGHT_DIR = Vector3.new(-0.4, -1, -0.3)
local VIEWPORT_LIGHT_COLOR = Color3.fromRGB(255, 245, 220)
local VIEWPORT_AMBIENT = Color3.fromRGB(170, 170, 180)

local function fitCamera(camera, model)
	local _, bbSize = model:GetBoundingBox()
	local halfExtent = math.max(bbSize.X, bbSize.Y, bbSize.Z) * 0.5
	local distance = (halfExtent / math.sin(math.rad(VIEWPORT_FOV) * 0.5)) * VIEWPORT_PADDING
	local camPos = VIEWPORT_VIEW_DIR * distance
	camera.FieldOfView = VIEWPORT_FOV
	camera.CFrame = CFrame.lookAt(camPos, Vector3.zero)
end

-- Lifted from IndexController.playSlotIdle: walk the model for an Animation
-- named "Idle" (fallback to any Animation), resolve to a Humanoid or
-- AnimationController + Animator, load + play looped. Lucky-block models ship
-- with an AnimationController.Idle Animation that drives the skinned mesh's
-- Bones; anchoring the root MeshPart doesn't block the bones from deforming
-- so the carry-pad bob/rotate idle still plays in the viewport.
local function playSlotIdle(model)
	local resolvedId, fallbackId
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("Animation") and d.AnimationId ~= "" then
			if d.Name == "Idle" then
				resolvedId = d.AnimationId
				break
			elseif not fallbackId then
				fallbackId = d.AnimationId
			end
		end
	end
	resolvedId = resolvedId or fallbackId
	if not resolvedId then return end

	local ac = model:FindFirstChildWhichIsA("AnimationController", true)
		or model:FindFirstChildWhichIsA("Humanoid", true)
	if not ac then return end

	local animator = ac:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = ac
	end

	local anim = Instance.new("Animation")
	anim.AnimationId = resolvedId
	local ok, track = pcall(function() return animator:LoadAnimation(anim) end)
	anim:Destroy()
	if ok and track then
		track.Looped = true
		pcall(function() track:Play() end)
	end
end

-- One-per-frame queue (same idea as IndexController.enqueueIdle). 5 slots is
-- modest but LoadAnimation can block briefly while the asset streams in, so
-- spreading them across frames avoids a single-frame hitch when the modal
-- opens.
local idleQueue = {}
local idleWorkerActive = false

local function processIdleQueue()
	if idleWorkerActive then return end
	idleWorkerActive = true
	task.spawn(function()
		while true do
			local model = table.remove(idleQueue, 1)
			if not model then break end
			if model.Parent then
				playSlotIdle(model)
			end
			task.wait()
		end
		idleWorkerActive = false
	end)
end

local function enqueueIdle(model)
	table.insert(idleQueue, model)
	processIdleQueue()
end

local function buildSlotViewport(slot, luckyBlockId)
	local cfg = GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[luckyBlockId]
	local modelName = (cfg and cfg.ModelName) or luckyBlockId
	local sourceModel = LuckyBlockModels:FindFirstChild(modelName)
	if not sourceModel then return false end

	-- Existing viewport gets reused on subsequent populates so we don't churn
	-- WorldModel children every show. The Template ships as an ImageLabel; we
	-- hide its 2D image and overlay the ViewportFrame at the same size.
	local viewport = slot:FindFirstChild("ModelViewport")
	if not viewport then
		viewport = Instance.new("ViewportFrame")
		viewport.Name = "ModelViewport"
		viewport.AnchorPoint = Vector2.new(0.5, 0.5)
		viewport.Position = UDim2.fromScale(0.5, 0.5)
		viewport.Size = UDim2.fromScale(1, 1)
		viewport.BackgroundTransparency = 1
		viewport.LightDirection = VIEWPORT_LIGHT_DIR
		viewport.LightColor = VIEWPORT_LIGHT_COLOR
		viewport.Ambient = VIEWPORT_AMBIENT
		-- Sit behind the name + rarity labels so the model never covers them.
		-- The labels both get ZIndex 5 below; viewport stays at the slot default.
		viewport.ZIndex = 1
		viewport.Parent = slot
	end

	local worldModel = viewport:FindFirstChildOfClass("WorldModel")
	if not worldModel then
		worldModel = Instance.new("WorldModel")
		worldModel.Parent = viewport
	end
	for _, c in ipairs(worldModel:GetChildren()) do c:Destroy() end
	for _, c in ipairs(viewport:GetChildren()) do
		if c:IsA("Camera") then c:Destroy() end
	end

	local modelClone = sourceModel:Clone()
	for _, d in ipairs(modelClone:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
			d.CanQuery = false
			d.CanTouch = false
		elseif d:IsA("KeyframeSequence") then
			-- IndexController strips these from rigged models in viewports because
			-- a baked KeyframeSequence sitting next to the live Animation can
			-- compete for the Animator and freeze the rig on the rest pose.
			d:Destroy()
		end
	end

	local bbCF = modelClone:GetBoundingBox()
	modelClone:PivotTo(CFrame.new(-bbCF.Position) * modelClone:GetPivot())
	modelClone.Parent = worldModel

	local camera = Instance.new("Camera")
	camera.Parent = viewport
	viewport.CurrentCamera = camera
	fitCamera(camera, modelClone)

	enqueueIdle(modelClone)

	return true
end

-- Dev product for lucky-block recovery. The price (29 Robux) is shown on the
-- RobuxPurchase button's Text label; this script does not assume any price,
-- only the id.
local RECOVERY_PRODUCT_ID = 3597991104

local screen = script.Parent
local modal = screen:WaitForChild("LostBrainrots")
local declineButton = modal:WaitForChild("Decline")
local robuxButton = modal:WaitForChild("RobuxPurchase")
local timerLabel = modal:WaitForChild("Timer")
local displays = modal:WaitForChild("BrainrotDisplays")
local listLayout = displays:WaitForChild("UIListLayout")
local template = displays:WaitForChild("Template")

listLayout.FillDirection = Enum.FillDirection.Horizontal
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.VerticalAlignment = Enum.VerticalAlignment.Center
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0.02, 0)

-- Hide the template itself; clones become the visible entries. LayoutOrder = -1
-- keeps it out of the UIListLayout flow even if its Visible flag toggles.
template.Visible = false
template.LayoutOrder = -1

-- Cache the screen's original transparency so the Give Up fade returns the
-- overlay to its designed dim level on the next show (instead of fully opaque
-- or fully clear).
local screenOriginalTransparency = screen.BackgroundTransparency
screen.Visible = false

local currentToken
local currentExpireAt
local timerConn
local screenFadeTween
local isShowing = false
local fadeOutInfo = TweenInfo.new(0.22 * 0.7, Enum.EasingStyle.Quad)
local fadeInInfo = TweenInfo.new(0.22 * 0.7, Enum.EasingStyle.Quad)

local function stopTimer()
	if timerConn then
		timerConn:Disconnect()
		timerConn = nil
	end
end

local function formatTime(secondsLeft)
	secondsLeft = math.max(0, math.floor(secondsLeft))
	local mins = math.floor(secondsLeft / 60)
	local secs = secondsLeft % 60
	return string.format("%02d:%02d", mins, secs)
end

-- Insert spaces between lower->upper case transitions so an unrecognized id
-- like "VoidLuckyBlock" still reads as "Void Lucky Block" instead of the raw
-- camelCase model identifier. Only used as a last-resort fallback.
local function humanizeId(id)
	if type(id) ~= "string" or id == "" then return id end
	local spaced = (id:gsub("(%l)(%u)", "%1 %2"))
	return spaced
end

local function applySlotVisuals(slot, luckyBlockId)
	local lookup = GameConfig.LuckyBlocks or {}
	local cfg = lookup[luckyBlockId]
	-- The lucky-block carry path stores the in-world ModelName as the id (e.g.
	-- "PinkLuckyBlock"), which matches a GameConfig.LuckyBlocks key for every
	-- physical block. For the alias entries (`LuckyBlock` -> ModelName
	-- `PinkLuckyBlock`, `Exclusive` -> ModelName `LuckyBlock`), resolve through
	-- the ModelName so the label matches the visual model rendered in the
	-- viewport instead of the alias's generic name (e.g. "Pink Lucky Block"
	-- when a pink block is shown, not just "Lucky Block").
	local modelName = (cfg and cfg.ModelName) or luckyBlockId
	local modelCfg = lookup[modelName] or cfg
	local rarity = (modelCfg and modelCfg.Rarity) or (cfg and cfg.Rarity) or "Common"
	local rarityCfg = GameConfig.Rarities and GameConfig.Rarities[rarity]
	local displayName = (modelCfg and (modelCfg.DisplayName or modelCfg.displayName))
		or (cfg and (cfg.DisplayName or cfg.displayName))
		or humanizeId(modelName)

	local rarityLabel = slot:FindFirstChild("Rarity")
	local nameLabel = slot:FindFirstChild("Mutation")

	if rarityLabel then
		rarityLabel.Text = (rarityCfg and rarityCfg.DisplayName) or rarity
		rarityLabel.ZIndex = 5
		local grad = rarityLabel:FindFirstChildOfClass("UIGradient")
		if rarityCfg and rarityCfg.Gradient then
			if not grad then
				grad = Instance.new("UIGradient")
				grad.Parent = rarityLabel
			end
			grad.Color = rarityCfg.Gradient
		end
	end

	-- The slot template ships with a "Mutation" label sitting above the icon;
	-- we repurpose it as the block name label since lucky blocks don't carry a
	-- mutation. Authored width is 1.16 (overflows the slot for the short "Normal"
	-- it was designed for) and authored height is 0.29 (tall enough that
	-- TextScaled lets long names like "Spiked Lucky Block" wrap onto a second
	-- line and bleed into the rarity row below). Clamp width to 1.0 and shrink
	-- the height so TextScaled is forced to pick a smaller single-line font.
	-- TextScaled forces TextWrapped=true under the hood; we let it stay true
	-- because the shorter height keeps the wrap from ever firing.
	if nameLabel then
		nameLabel.Text = displayName
		nameLabel.Size = UDim2.new(1, 0, 0.16, 0)
		nameLabel.Position = UDim2.new(0, 0, -0.18, 0)
		nameLabel.TextScaled = true
		nameLabel.ZIndex = 5
	end

	-- ImageLabel template's static icon is hidden in favor of the live
	-- ViewportFrame. If the model is missing for some reason, fall back to the
	-- authored icon so the slot doesn't render empty.
	local viewportOk = buildSlotViewport(slot, luckyBlockId)
	if viewportOk then
		slot.ImageTransparency = 1
	else
		slot.ImageTransparency = 0
	end
end

local function clearDisplays()
	for _, child in ipairs(displays:GetChildren()) do
		if child:IsA("ImageLabel") and child ~= template then
			child:Destroy()
		end
	end
end

local function populateDisplays(blocks)
	clearDisplays()
	for i, luckyBlockId in ipairs(blocks) do
		local slot = template:Clone()
		slot.Name = "Slot_" .. i
		slot.LayoutOrder = i
		slot.Visible = true
		slot.Parent = displays
		applySlotVisuals(slot, luckyBlockId)
	end
end

local function startTimer()
	stopTimer()
	if not currentExpireAt then return end

	local function tick()
		local left = currentExpireAt - os.time()
		timerLabel.Text = formatTime(left)
		if left <= 0 then
			stopTimer()
		end
	end

	tick()
	timerConn = RunService.Heartbeat:Connect(function()
		tick()
	end)
end

local function fadeScreenTo(target)
	if screenFadeTween then
		screenFadeTween:Cancel()
	end
	screenFadeTween = TweenService:Create(screen, target == screenOriginalTransparency and fadeInInfo or fadeOutInfo, {
		BackgroundTransparency = target,
	})
	screenFadeTween:Play()
end

local function showModal()
	if isShowing then return end
	isShowing = true
	screen.BackgroundTransparency = 1
	screen.Visible = true
	fadeScreenTo(screenOriginalTransparency)
	FrameAnimator:Open(modal)
end

local function hideModal()
	if not isShowing then return end
	isShowing = false
	stopTimer()
	fadeScreenTo(1)
	FrameAnimator:Close(modal)
	-- Hide the overlay after the fade so subsequent layouts don't intercept
	-- input. The fade matches FrameAnimator's close duration so they land
	-- together visually.
	task.delay(0.22 * 0.7 + 0.05, function()
		if not isShowing then
			screen.Visible = false
		end
	end)
end

ShowEvent.OnClientEvent:Connect(function(payload)
	if type(payload) ~= "table" then return end
	currentToken = payload.Token
	currentExpireAt = payload.ExpireAt
	populateDisplays(payload.Blocks or {})
	showModal()
	startTimer()
end)

HideEvent.OnClientEvent:Connect(function()
	hideModal()
end)

declineButton.MouseButton1Click:Connect(function()
	if not isShowing then return end
	-- Tell the server the player gave up so it clears the pending recovery
	-- (otherwise a re-fall would still see stale Token state).
	GiveUpEvent:FireServer()
	hideModal()
end)

robuxButton.MouseButton1Click:Connect(function()
	if not isShowing or not currentToken then return end
	local context = "LostBrainrotsRecover_" .. tostring(currentToken)
	-- Fire-and-forget: the server's PurchaseService routes the success path
	-- through LostBrainrotService.OnRecoveryPurchase which itself fires the
	-- Hide RemoteEvent, so we don't need to act on the return here.
	task.spawn(function()
		pcall(function()
			PromptPurchaseFunc:InvokeServer(RECOVERY_PRODUCT_ID, context)
		end)
	end)
end)

Players.LocalPlayer.AncestryChanged:Connect(function(_, parent)
	if not parent then stopTimer() end
end)
