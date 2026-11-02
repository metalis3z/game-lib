local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local RarityItemsConfig = require(ReplicatedStorage.Source.Configs.RarityItemsConfig)
local ItemImagesConfig = require(ReplicatedStorage.Source.Configs.ItemImagesConfig)
local ViewportOutline = require(ReplicatedStorage.Source.Modules.ViewportOutline)
local FrameAnimator = require(ReplicatedStorage.Source.Modules.FrameAnimator)
local NotificationsController = require(ReplicatedStorage.Source.Controllers.NotificationsController)
-- The Earnings (offline) popup must show FIRST on rejoin; we wait for it to
-- resolve before auto-opening the daily reward.
local OfflineRewardController = require(ReplicatedStorage.Source.Controllers.OfflineRewardController)

local DailyRewardController = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local DailyRemotes = Remotes:WaitForChild("DailyRewardService")
local ClaimRewardFunc = DailyRemotes:WaitForChild("ClaimReward")
local RequestDataFunc = DailyRemotes:WaitForChild("RequestData")
local DataUpdateEvent = DailyRemotes:WaitForChild("DataUpdate")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local dailyFrame = nil
local closeButton = nil
local timerLabel = nil
local streakLabel = nil
-- "!" badge on the HUD Gifts button (Gifts.Notify): action-required only
-- (user request 2026-07-23) -- shown while a claim is ready, hidden once
-- claimed. updateUI keeps it in sync (the server fires DataUpdate right
-- after every claim).
local notifyBadge = nil

local cachedPayload = nil
local isClaiming = false
local wasClaimable = false
local frameIsOpen = false
-- Snapshot of TutorialComplete at session start. The daily-reward popup is
-- intentionally rejoin-only: first-time joiners would get the Day-1 $1K
-- cash bonus during the tutorial, which trivialises the tutorial economy
-- (the player starts with $100 and the first upgrade-shop step is gated on
-- ~$250). Setting this once at Init keeps mid-session tutorial completion
-- from triggering the popup until the player's NEXT join.
-- Tutorial removed from the game: every join counts as post-tutorial.
local tutorialCompleteAtJoin = true

-- First-ever session shows NO join popups (user spec): the daily reward
-- auto-opens only on a REJOIN (server sets the IsRejoin attribute from the
-- saved LastLogin). Manual Gifts-button opens are unaffected.
local function isRejoin()
	return player:GetAttribute("IsRejoin") == true
end

-- Block the daily auto-open until the Earnings popup has resolved (shown +
-- closed, or nothing to show). The timeout only applies while the popup is
-- NOT on screen -- while the player is actually looking at it we wait for
-- as long as it takes (closing it fires DoneEvent).
local function waitForOfflineResolved()
	if OfflineRewardController.Done then return end
	local done = false
	local conn
	conn = OfflineRewardController.DoneEvent:Connect(function()
		done = true
	end)
	local gui = playerGui:FindFirstChild("GUI")
	local folder = gui and gui:FindFirstChild("Folder")
	local offlineFrame = folder and folder:FindFirstChild("OfflineReward")
	local deadline = os.clock() + 15
	while not done and not OfflineRewardController.Done do
		if offlineFrame and offlineFrame.Visible then
			deadline = os.clock() + 15 -- popup on screen: keep waiting
		elseif os.clock() >= deadline then
			break
		end
		task.wait(0.15)
	end
	if conn then conn:Disconnect() end
end

-- dayRefs[i] = { button, dayLabel, icon, rarityLabel, amountLabel, claimedFrame, baseIconSize }
local dayRefs = {}

local function formatCountdown(seconds)
	seconds = math.max(0, math.floor(seconds))
	local h = math.floor(seconds / 3600)
	local m = math.floor((seconds % 3600) / 60)
	local s = seconds % 60
	return string.format("%02d:%02d:%02d", h, m, s)
end

local function setLabelText(label, text)
	if not label then return end
	label.Text = text
	local double = label:FindFirstChild("Double")
	if double and double:IsA("TextLabel") then
		double.Text = text
	end
end

local function setClaimedVisible(refs, visible)
	if refs.claimedFrame then
		refs.claimedFrame.Visible = visible
	end
end

local function startIdleEffects(refs)
	if refs.idleRunning then return end
	local token = (refs.idleToken or 0) + 1
	refs.idleToken = token
	refs.idleRunning = true

	if refs.outerStroke then
		task.spawn(function()
			local whiteColor = Color3.fromRGB(255, 255, 255)
			local baseColor = refs.outerStrokeBaseColor or refs.outerStroke.Color
			while refs.idleToken == token do
				TweenService:Create(refs.outerStroke, TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					Color = whiteColor,
				}):Play()
				task.wait(0.65)
				if refs.idleToken ~= token then break end
				TweenService:Create(refs.outerStroke, TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					Color = baseColor,
				}):Play()
				task.wait(0.65)
			end
		end)
	end

	if refs.icon then
		task.spawn(function()
			while refs.idleToken == token do
				TweenService:Create(refs.icon, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					Rotation = 8,
				}):Play()
				task.wait(0.45)
				if refs.idleToken ~= token then break end
				TweenService:Create(refs.icon, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					Rotation = -8,
				}):Play()
				task.wait(0.45)
			end
		end)
	end
end

local function stopIdleEffects(refs)
	if not refs.idleRunning then return end
	refs.idleRunning = false
	refs.idleToken = (refs.idleToken or 0) + 1

	if refs.outerStroke and refs.outerStrokeBaseColor then
		TweenService:Create(refs.outerStroke, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
			Color = refs.outerStrokeBaseColor,
		}):Play()
	end
	if refs.icon then
		TweenService:Create(refs.icon, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
			Rotation = 0,
		}):Play()
	end
end

local function setDayState(dayIndex, state)
	local refs = dayRefs[dayIndex]
	if not refs then return end

	if state == "claimed" then
		setClaimedVisible(refs, true)
		stopIdleEffects(refs)
	elseif state == "claimable" then
		setClaimedVisible(refs, false)
		-- perf (ported 2026-07-21): the stroke-pulse/icon-wiggle tweens only
		-- run while the frame is on screen; the Visible hook restarts them
		-- on open. They used to tick forever behind a closed frame.
		if dailyFrame and dailyFrame.Visible then
			startIdleEffects(refs)
		else
			stopIdleEffects(refs)
		end
	else
		setClaimedVisible(refs, false)
		stopIdleEffects(refs)
	end
end

local function playClaimAnimation(refs)
	if not refs then return end

	local button = refs.button
	local icon = refs.icon
	if not button or not icon then return end

	local baseIconSize = refs.baseIconSize or icon.Size
	refs.baseIconSize = baseIconSize

	local scale = refs.uiScale
	if not scale then
		scale = button:FindFirstChildOfClass("UIScale")
		if not scale then
			scale = Instance.new("UIScale")
			scale.Scale = 1
			scale.Parent = button
		end
		refs.uiScale = scale
	end
	scale.Scale = 1

	TweenService:Create(scale, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Scale = 1.18,
	}):Play()
	task.delay(0.2, function()
		TweenService:Create(scale, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Scale = 1.0,
		}):Play()
	end)

	local pulseUp = UDim2.new(baseIconSize.X.Scale * 1.4, baseIconSize.X.Offset, baseIconSize.Y.Scale * 1.4, baseIconSize.Y.Offset)
	icon.Size = baseIconSize
	icon.Rotation = 0
	TweenService:Create(icon, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Size = pulseUp,
		Rotation = 360,
	}):Play()
	task.delay(0.32, function()
		TweenService:Create(icon, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Size = baseIconSize,
			Rotation = 0,
		}):Play()
	end)
end

local function updateUI(payload)
	if not payload then return end
	cachedPayload = payload

	setLabelText(streakLabel, "Join streak: " .. tostring(payload.Streak or 0))

	local currentDay = payload.CurrentDay or 1
	local canClaim = payload.CanClaim
	local secondsUntilNext = payload.SecondsUntilNext or 0

	if notifyBadge then
		notifyBadge.Visible = canClaim == true
	end

	if canClaim then
		setLabelText(timerLabel, "Reward ready!")
	else
		setLabelText(timerLabel, "Next reward in: " .. formatCountdown(secondsUntilNext))
	end

	for i = 1, 7 do
		if i < currentDay then
			setDayState(i, "claimed")
		elseif i == currentDay and canClaim then
			setDayState(i, "claimable")
		else
			setDayState(i, "locked")
		end
	end
end

local function openFrame(force)
	if frameIsOpen then return end
	-- The rejoin-only gate (`tutorialCompleteAtJoin`) used to live here, but
	-- it broke the manual Gifts HUD button -- a player who joins, finishes
	-- the tutorial in this session, then clicks Gifts couldn't open the
	-- frame at all. The gate now lives at the AUTO-open call sites
	-- (`checkAndOpenFrame` + the startup polling task) so manual clicks via
	-- `toggleFrame` always work regardless of tutorial state.
	frameIsOpen = true
	if FrameAnimator and FrameAnimator.Open then
		FrameAnimator:Open(dailyFrame)
	else
		dailyFrame.Visible = true
	end
end

local function closeFrame()
	frameIsOpen = false
	if FrameAnimator and FrameAnimator.Close then
		FrameAnimator:Close(dailyFrame)
	else
		dailyFrame.Visible = false
	end
end

local function toggleFrame()
	if frameIsOpen or dailyFrame.Visible then
		closeFrame()
	else
		openFrame(true)
	end
end

local function checkAndOpenFrame()
	if not cachedPayload then return end
	if cachedPayload.CanClaim and not wasClaimable then
		wasClaimable = true
		-- Rejoin-only, and only after the Earnings popup has had its turn.
		if tutorialCompleteAtJoin and isRejoin() then
			task.spawn(function()
				waitForOfflineResolved()
				openFrame(true)
			end)
		end
	elseif not cachedPayload.CanClaim then
		wasClaimable = false
	end
end

local function doClaim()
	if isClaiming then return false end
	if not cachedPayload or not cachedPayload.CanClaim then return false end

	isClaiming = true

	local currentDay = cachedPayload.CurrentDay or 1
	stopIdleEffects(dayRefs[currentDay])
	playClaimAnimation(dayRefs[currentDay])

	local success = ClaimRewardFunc:InvokeServer()

	if success then
		local sounds = SoundService:FindFirstChild("Sounds")
		local claimSound = sounds and sounds:FindFirstChild("PurchasedSound")
		if claimSound then claimSound:Play() end
		local cfg = GameConfig.DailyRewards and GameConfig.DailyRewards.Days and GameConfig.DailyRewards.Days[currentDay]
		local rewardName = (cfg and cfg.Label) or "reward"
		NotificationsController.SendGreen("Claimed " .. rewardName)
		-- claimed = done: auto-close the popup once the claim pulse has
		-- played instead of leaving it open on the countdown (user request
		-- 2026-07-23)
		task.delay(0.9, function()
			if frameIsOpen or (dailyFrame and dailyFrame.Visible) then
				closeFrame()
			end
		end)
	else
		NotificationsController.SendRed("Could not claim reward. Try again!")
	end

	task.delay(0.5, function()
		isClaiming = false
	end)

	return success
end

local function onCloseClicked()
	closeFrame()
end

local function onDayButtonClicked(dayIndex)
	if not cachedPayload then return end
	local currentDay = cachedPayload.CurrentDay or 1
	if dayIndex < currentDay then
		NotificationsController.SendRed("Already claimed")
		return
	end
	if dayIndex > currentDay or not cachedPayload.CanClaim then
		NotificationsController.SendRed("Come back tomorrow to claim this")
		return
	end
	task.spawn(doClaim)
end

local function startCountdownLoop()
	task.spawn(function()
		while true do
			task.wait(1)
			if not cachedPayload then continue end
			if cachedPayload.CanClaim then continue end

			local secondsLeft = cachedPayload.SecondsUntilNext or 0
			if secondsLeft <= 0 then
				local ok, fresh = pcall(function()
					return RequestDataFunc:InvokeServer()
				end)
				if ok and fresh then
					updateUI(fresh)
					checkAndOpenFrame()
				end
				continue
			end

			cachedPayload.SecondsUntilNext = math.max(0, secondsLeft - 1)
			-- perf (ported 2026-07-21): write the label ONLY while the frame
			-- shows. The timer + its Double are AnimatedText-bound, so a text
			-- write every second built ~100 per-char overlay instances per
			-- second for the whole session, invisibly (the Rebirth-frame
			-- disease). The Visible hook rewrites fresh text on open.
			if dailyFrame.Visible then
				setLabelText(timerLabel, "Next reward in: " .. formatCountdown(cachedPayload.SecondsUntilNext))
			end

			if cachedPayload.SecondsUntilNext <= 0 then
				cachedPayload.CanClaim = true
				updateUI(cachedPayload)
				checkAndOpenFrame()
			end
		end
	end)
end

-- ===== reward model viewport (same fitted 3/4 camera as the Index) =====

local VIEWPORT_FOV = 30
local VIEWPORT_PADDING = 1.1

-- LootItem days show the RarityItems template, LuckyBlock days with a
-- BlockId show that block's model; everything else keeps the Icon image.
local function resolveRewardModel(cfg)
	if cfg.Type == "LootItem" and cfg.ItemName then
		local rarity = RarityItemsConfig.GetItemRarity(cfg.ItemName)
		local itemsFolder = ReplicatedStorage:FindFirstChild("RarityItems")
		local tierFolder = rarity and itemsFolder and itemsFolder:FindFirstChild(rarity)
		return tierFolder and tierFolder:FindFirstChild(cfg.ItemName) or nil
	end
	if cfg.Type == "LuckyBlock" and cfg.BlockId then
		local blockCfg = GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[cfg.BlockId]
		local modelName = blockCfg and blockCfg.ModelName
		if not modelName then return nil end
		local blocksFolder = ReplicatedStorage:FindFirstChild("LuckyBlocks")
		return (blocksFolder and blocksFolder:FindFirstChild(modelName))
			or ReplicatedStorage:FindFirstChild(modelName)
	end
	return nil
end

local function setupDayViewport(button, template)
	local icon = button:FindFirstChild("Icon")
	local old = button:FindFirstChild("ModelViewport")
	if old then old:Destroy() end

	local viewport = Instance.new("ViewportFrame")
	viewport.Name = "ModelViewport"
	viewport.BackgroundTransparency = 1
	viewport.Ambient = Color3.fromRGB(185, 185, 185)
	viewport.LightColor = Color3.fromRGB(255, 255, 255)
	viewport.LightDirection = Vector3.new(-0.5, -1, -1.5)
	-- fixed rect in the clear band between the Day label (ends ~0.19) and
	-- the Amount text (starts ~0.635). The authored Icon rect (centered,
	-- 0.8 sq) runs UNDER those labels -- images with transparent padding
	-- got away with it, a 3D model visibly clips into the text.
	viewport.AnchorPoint = Vector2.new(0.5, 0.5)
	viewport.Position = UDim2.fromScale(0.5, 0.42)
	viewport.Size = UDim2.fromScale(0.8, 0.4)
	if icon then
		viewport.ZIndex = icon.ZIndex
		local ar = icon:FindFirstChildOfClass("UIAspectRatioConstraint")
		if ar then
			local arc = Instance.new("UIAspectRatioConstraint")
			arc.AspectRatio = ar.AspectRatio
			arc.Parent = viewport
		end
		icon.Visible = false
	end

	local model = template:Clone()
	if model:IsA("BasePart") then
		local wrapper = Instance.new("Model")
		model.Parent = wrapper
		model = wrapper
	end
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BaseScript") or d:IsA("ModuleScript") or d:IsA("Sound")
			or d:IsA("SurfaceGui") or d:IsA("BillboardGui") or d:IsA("ProximityPrompt") then
			d:Destroy()
		elseif d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
			d.CanQuery = false
			d.CanTouch = false
		end
	end

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

	ViewportOutline.Add(viewport, model, camera)

	viewport.Parent = button
	return viewport
end

-- Day-6 lucky block: the SAME "Get Slim" animation the Robux shop's Lucky
-- Block store cards use (LuckyBlockStoreController.populateViewport): 40
-- deg/s yaw + bob + an eased 360-degree burst every 2s, framed off the
-- model's smallest bbox extent. Ported from "+1 Kick Door" 2026-07-21: the
-- daily card must read like the store card, not a static render.
local LB_SPIN_RATE = math.rad(40)
local LB_FLOAT_AMPLITUDE = 0.4
local LB_FLOAT_FREQUENCY = 0.6
local LB_BURST_INTERVAL = 2.0
local LB_BURST_DURATION = 1.1
local LB_BURST_STEP = math.pi * 2
local LB_TWO_PI = math.pi * 2
local LB_DOWN_BIAS = -0.4

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

local function setupLuckyBlockViewport(button, template)
	local icon = button:FindFirstChild("Icon")
	local old = button:FindFirstChild("ModelViewport")
	if old then old:Destroy() end

	local viewport = Instance.new("ViewportFrame")
	viewport.Name = "ModelViewport"
	viewport.BackgroundTransparency = 1
	viewport.Ambient = Color3.fromRGB(185, 185, 185)
	viewport.LightColor = Color3.fromRGB(255, 255, 255)
	viewport.LightDirection = Vector3.new(-0.5, -1, -1.5)
	-- same clear band between the Day and Amount labels as setupDayViewport
	viewport.AnchorPoint = Vector2.new(0.5, 0.5)
	viewport.Position = UDim2.fromScale(0.5, 0.42)
	viewport.Size = UDim2.fromScale(0.8, 0.4)
	if icon then
		viewport.ZIndex = icon.ZIndex
		local ar = icon:FindFirstChildOfClass("UIAspectRatioConstraint")
		if ar then
			local arc = Instance.new("UIAspectRatioConstraint")
			arc.AspectRatio = ar.AspectRatio
			arc.Parent = viewport
		end
		icon.Visible = false
	end

	local model = template:Clone()
	if model:IsA("BasePart") then
		model.Anchored = true
		model.CanCollide = false
		model.CanQuery = false
		model.CanTouch = false
	end
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BaseScript") or d:IsA("ModuleScript") or d:IsA("Sound")
			or d:IsA("SurfaceGui") or d:IsA("BillboardGui") or d:IsA("ProximityPrompt") then
			d:Destroy()
		elseif d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
			d.CanQuery = false
			d.CanTouch = false
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
	if not primary then return nil end

	local container = Instance.new("Model")
	container.Name = "LuckyBlockContainer"
	model.Parent = container
	container.PrimaryPart = primary
	container.Parent = viewport

	-- center on the bbox, then frame off the SMALLEST extent (the wing
	-- decorations inflate one axis) -- same math as the store card
	local origPivot = container:GetPivot()
	local bboxCF, bboxSize = container:GetBoundingBox()
	local homeRot = origPivot - origPivot.Position
	container:PivotTo(homeRot + (origPivot.Position - bboxCF.Position))

	local coreExtent = math.min(bboxSize.X, bboxSize.Y, bboxSize.Z)
	local camera = Instance.new("Camera")
	camera.CFrame = CFrame.new(Vector3.new(0, 0, math.max(coreExtent * 1.68, 3)), Vector3.new(0, 0, 0))
	camera.Parent = viewport
	viewport.CurrentCamera = camera

	local centered = container:GetPivot()
	local floatPhase = math.random() * LB_TWO_PI
	local burstPhaseRemaining = math.random() * LB_BURST_INTERVAL
	local burstElapsed = LB_BURST_DURATION
	local burstOffset = 0

	local conn
	conn = RunService.RenderStepped:Connect(function(dt)
		if not container.Parent then
			conn:Disconnect()
			return
		end
		-- the frame is closed most of the session; skip the per-frame PivotTo
		if dailyFrame and not dailyFrame.Visible then return end
		local now = os.clock()
		if burstPhaseRemaining > 0 then
			burstPhaseRemaining = burstPhaseRemaining - dt
		else
			burstElapsed = burstElapsed + dt
			if burstElapsed >= LB_BURST_INTERVAL then
				burstOffset = (burstOffset + LB_BURST_STEP) % LB_TWO_PI
				burstElapsed = 0
			end
		end
		local burstYaw
		if burstElapsed < LB_BURST_DURATION then
			burstYaw = easeInOutBack(burstElapsed / LB_BURST_DURATION) * LB_BURST_STEP
		else
			burstYaw = LB_BURST_STEP
		end
		local yaw = (now * LB_SPIN_RATE) % LB_TWO_PI + burstOffset + burstYaw
		local bob = math.sin((now + floatPhase) * LB_FLOAT_FREQUENCY * LB_TWO_PI) * LB_FLOAT_AMPLITUDE
		container:PivotTo(CFrame.new(0, bob + LB_DOWN_BIAS, 0) * CFrame.Angles(0, yaw, 0) * centered)
	end)

	viewport.Parent = button
	return viewport
end

local function applyDayConfig(button, index)
	local cfg = GameConfig.DailyRewards and GameConfig.DailyRewards.Days and GameConfig.DailyRewards.Days[index]
	if not cfg then return end

	local dayLabel = button:FindFirstChild("Day")
	if dayLabel then setLabelText(dayLabel, "Day " .. tostring(index)) end

	local rarityLabel = button:FindFirstChild("Rarity")
	if rarityLabel then setLabelText(rarityLabel, cfg.Rarity or "Common") end

	local amountLabel = button:FindFirstChild("Amount")
	if amountLabel then setLabelText(amountLabel, cfg.Label or "") end

	local icon = button:FindFirstChild("Icon")
	-- LootItem days (4/7): the flat card art every other card system uses
	-- (Index / store / hotbar, ItemImagesConfig) IS the item's correct image
	-- -- prefer it over a live render (ported 2026-07-21); the 3D viewport
	-- stays as the fallback for items without art.
	local itemArt = (cfg.Type == "LootItem" and cfg.ItemName) and ItemImagesConfig.Items[cfg.ItemName] or nil
	local rewardModel = resolveRewardModel(cfg)
	if itemArt and icon then
		local oldViewport = button:FindFirstChild("ModelViewport")
		if oldViewport then oldViewport:Destroy() end
		icon.Image = itemArt
		icon.ScaleType = Enum.ScaleType.Fit
		icon.Visible = true
	elseif cfg.Type == "LuckyBlock" and rewardModel then
		-- day 6: store-style animated lucky block card
		setupLuckyBlockViewport(button, rewardModel)
	elseif rewardModel then
		setupDayViewport(button, rewardModel)
	elseif icon and cfg.Icon then
		icon.Image = cfg.Icon
	end
end

local function buildDayRefs(button, index)
	-- config first: viewport days replace the Icon image, and the idle/
	-- claim animations should act on whatever ends up visible
	applyDayConfig(button, index)

	local icon = button:FindFirstChild("ModelViewport") or button:FindFirstChild("Icon")
	local claimedFrame = button:FindFirstChild("Claimed")

	local stale = button:FindFirstChild("ClaimFlash")
	if stale then
		stale:Destroy()
	end

	local outerStroke = nil
	for _, child in ipairs(button:GetChildren()) do
		if child:IsA("UIStroke") and not child:FindFirstChildOfClass("UIGradient") then
			outerStroke = child
			break
		end
	end

	dayRefs[index] = {
		button = button,
		icon = icon,
		baseIconSize = icon and icon.Size or nil,
		dayLabel = button:FindFirstChild("Day"),
		rarityLabel = button:FindFirstChild("Rarity"),
		amountLabel = button:FindFirstChild("Amount"),
		claimedFrame = claimedFrame,
		outerStroke = outerStroke,
		outerStrokeBaseColor = outerStroke and outerStroke.Color or nil,
	}

	if claimedFrame then
		claimedFrame.Visible = false
	end

	if button:IsA("GuiButton") then
		button.MouseButton1Click:Connect(function()
			onDayButtonClicked(index)
		end)
	end
end

function DailyRewardController.Init()
	local gui = playerGui:WaitForChild("GUI", 10)
	if not gui then return end
	local folder = gui:WaitForChild("Folder", 10)
	if not folder then return end
	dailyFrame = folder:WaitForChild("DailyGifts", 10)
	if not dailyFrame then return end
	dailyFrame.Visible = false

	local topFrame = dailyFrame:WaitForChild("TopFrame")
	closeButton = topFrame:FindFirstChild("CloseButton")
	timerLabel = topFrame:FindFirstChild("Timer")
	streakLabel = topFrame:FindFirstChild("Streak")

	local rewards = dailyFrame:WaitForChild("Rewards")
	local innerFrame = rewards:FindFirstChild("Frame")

	for i = 1, 6 do
		local btn = innerFrame and innerFrame:FindFirstChild(tostring(i))
		if btn then
			buildDayRefs(btn, i)
		end
	end

	local day7 = rewards:FindFirstChild("7")
	if day7 then
		buildDayRefs(day7, 7)
	end

	dailyFrame:GetPropertyChangedSignal("Visible"):Connect(function()
		if not dailyFrame.Visible then
			frameIsOpen = false
			-- perf: invisible cards must not keep tweening
			for _, refs in pairs(dayRefs) do
				stopIdleEffects(refs)
			end
		else
			-- catch up what the closed-frame path skipped (timer text and
			-- the claimable card's idle FX are gated on Visible)
			updateUI(cachedPayload)
		end
	end)

	if closeButton then
		closeButton.MouseButton1Click:Connect(onCloseClicked)
	end

	task.spawn(function()
		local hud = gui:WaitForChild("HUD", 10)
		local leftSide = hud and hud:WaitForChild("LeftSide", 10)
		local right = leftSide and leftSide:WaitForChild("Right", 10)
		local giftsBtn = right and right:WaitForChild("Gifts", 10)
		if giftsBtn and giftsBtn:IsA("GuiButton") then
			giftsBtn.MouseButton1Click:Connect(toggleFrame)
			notifyBadge = giftsBtn:FindFirstChild("Notify")
			if notifyBadge then
				-- the badge ships Visible=true; sync it to whatever payload
				-- arrived before this button resolved
				notifyBadge.Visible = cachedPayload ~= nil and cachedPayload.CanClaim == true
			end
		end
	end)

	DataUpdateEvent.OnClientEvent:Connect(function(payload)
		updateUI(payload)
		checkAndOpenFrame()
	end)

	-- Note: we deliberately do NOT listen to TutorialCompleteEvent here. If
	-- the player finishes the tutorial mid-session the daily reward should
	-- still wait until their NEXT join -- matches "only on rejoin".

	task.spawn(function()
		-- Wait until the GUI actually has layout dimensions before the join
		-- auto-open: opening while the HUD is still mid-layout made
		-- FrameAnimator push the side groups only partially off screen.
		local layoutDeadline = os.clock() + 5
		while gui.AbsoluteSize.X < 4 and os.clock() < layoutDeadline do
			task.wait(0.1)
		end
		task.wait(1)
		for _ = 1, 20 do
			local okData, payload = pcall(function()
				return RequestDataFunc:InvokeServer()
			end)
			if okData and payload then
				updateUI(payload)
				if payload.CanClaim and tutorialCompleteAtJoin and isRejoin() then
					wasClaimable = true
					-- Earnings popup goes first; then a short beat so the HUD has
					-- settled before the daily modal pops.
					waitForOfflineResolved()
					task.wait(0.5)
					openFrame(true)
				end
				break
			end
			task.wait(0.5)
		end
	end)

	startCountdownLoop()
end

return DailyRewardController
