local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local SoundService = game:GetService("SoundService")

-- Plays once whenever a Robux gamepass or dev product prompt opens (every
-- prompt path funnels through showPrompt below).
local promptSound = SoundService:WaitForChild("Sounds"):WaitForChild("PromptSound")

local BuyTransitionController = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local PurchaseRemotes = Remotes:WaitForChild("PurchaseService")
local PurchaseResultEvent = PurchaseRemotes:WaitForChild("PurchaseResult")

local FADE_IN_TIME = 0.25
local FADE_OUT_TIME = 0.3
local ICON_SPIN_SPEED = 180
local GRADIENT_SPIN_SPEED = 90
local SUCCESS_HOLD_TIME = 1.6
local BG_TARGET_TRANSPARENCY = 0.35
local ZINDEX_BOOST = 1000
-- Safety net: if no PromptXxxPurchaseFinished and no server PurchaseResult
-- lands within this many seconds of showPrompt(), force-clear the overlay.
-- Roblox occasionally swallows the Finished event (throttled prompt, prompt
-- blocked by another modal, server-side pending replaced by a racing click)
-- which used to leave the spinning Robux icon stuck on screen indefinitely.
local PROMPT_TIMEOUT = 75

local player = Players.LocalPlayer

local frame = nil
local shadow = nil
local shadowGradient = nil
local icon = nil
local textLabel = nil
local textInner = nil
local outerStroke = nil
local innerStroke = nil

local originalBgTransparency = 1
local originalShadowTransparency = 0
local originalIconTransparency = 0
local originalIconSize = nil
local originalTextSize = nil
local originalOuterTextTransparency = 0
local originalInnerTextTransparency = 0
local originalOuterStrokeTransparency = 0
local originalInnerStrokeTransparency = 0

local state = "idle"
local promptToken = 0
local heartbeatConn = nil
local activeTweens = {}

local function tween(obj, time, props, style, dir)
	local info = TweenInfo.new(time, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out)
	local t = TweenService:Create(obj, info, props)
	table.insert(activeTweens, t)
	t:Play()
	return t
end

local function cancelTweens()
	for _, t in ipairs(activeTweens) do
		pcall(function() t:Cancel() end)
	end
	table.clear(activeTweens)
end

local function startSpin()
	if heartbeatConn then
		return
	end
	heartbeatConn = RunService.Heartbeat:Connect(function(dt)
		if shadowGradient then
			shadowGradient.Rotation = (shadowGradient.Rotation + GRADIENT_SPIN_SPEED * dt) % 360
		end
		if icon then
			icon.Rotation = (icon.Rotation + ICON_SPIN_SPEED * dt) % 360
		end
	end)
end

local function stopSpin()
	if heartbeatConn then
		heartbeatConn:Disconnect()
		heartbeatConn = nil
	end
end

local function resetVisuals()
	if frame then
		frame.BackgroundTransparency = 1
		frame.Visible = false
	end
	if shadow then
		shadow.ImageTransparency = 1
		shadow.Rotation = 0
	end
	if icon then
		icon.ImageTransparency = 1
		icon.Rotation = 0
		if originalIconSize then
			icon.Size = originalIconSize
		end
	end
	if textLabel then
		textLabel.Visible = false
		textLabel.TextTransparency = 1
		if originalTextSize then
			textLabel.Size = originalTextSize
		end
	end
	if textInner then
		textInner.TextTransparency = 1
	end
	if outerStroke then
		outerStroke.Transparency = 1
	end
	if innerStroke then
		innerStroke.Transparency = 1
	end
end

local function showPrompt()
	if not frame then
		return
	end
	if state == "prompting" or state == "success" then
		return
	end
	state = "prompting"
	promptToken = promptToken + 1
	local myToken = promptToken
	cancelTweens()
	resetVisuals()

	if promptSound then
		promptSound:Play()
	end

	frame.Visible = true
	frame.BackgroundTransparency = 1
	tween(frame, FADE_IN_TIME, { BackgroundTransparency = BG_TARGET_TRANSPARENCY }, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	if shadow then
		tween(shadow, FADE_IN_TIME, { ImageTransparency = originalShadowTransparency })
	end
	if icon then
		icon.ImageTransparency = 1
		tween(icon, FADE_IN_TIME, { ImageTransparency = originalIconTransparency })
	end
	startSpin()

	-- Safety timeout: snap the overlay to hidden if no result lands. Functions
	-- defined after showPrompt (hideAll/cancel) aren't in scope here, so the
	-- cleanup is inlined using helpers declared above.
	task.delay(PROMPT_TIMEOUT, function()
		if myToken ~= promptToken or state ~= "prompting" then
			return
		end
		state = "idle"
		cancelTweens()
		stopSpin()
		resetVisuals()
	end)
end

local function hideAll()
	cancelTweens()
	stopSpin()
	if frame then
		tween(frame, FADE_OUT_TIME, { BackgroundTransparency = 1 }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	end
	if shadow then
		tween(shadow, FADE_OUT_TIME, { ImageTransparency = 1 })
	end
	if icon then
		tween(icon, FADE_OUT_TIME, { ImageTransparency = 1 })
	end
	if textLabel then
		tween(textLabel, FADE_OUT_TIME, { TextTransparency = 1 })
	end
	if textInner then
		tween(textInner, FADE_OUT_TIME, { TextTransparency = 1 })
	end
	if outerStroke then
		tween(outerStroke, FADE_OUT_TIME, { Transparency = 1 })
	end
	if innerStroke then
		tween(innerStroke, FADE_OUT_TIME, { Transparency = 1 })
	end

	task.delay(FADE_OUT_TIME + 0.05, function()
		if state == "hiding" then
			state = "idle"
			resetVisuals()
		end
	end)
end

local function playSuccess()
	if state ~= "prompting" then
		return
	end
	state = "success"
	stopSpin()

	if icon then
		local shrink = originalIconSize and UDim2.new(0, 0, 0, 0) or icon.Size
		tween(icon, 0.25, { ImageTransparency = 1, Size = shrink }, Enum.EasingStyle.Back, Enum.EasingDirection.In)
	end

	task.wait(0.18)

	if textLabel and textInner then
		textLabel.Visible = true
		local targetSize = originalTextSize
		textLabel.Size = UDim2.new(0, 0, 0, 0)
		textLabel.TextTransparency = 1
		textInner.TextTransparency = 1
		if outerStroke then
			outerStroke.Transparency = 1
		end
		if innerStroke then
			innerStroke.Transparency = 1
		end

		tween(textLabel, 0.45, { Size = targetSize }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		tween(textLabel, 0.35, { TextTransparency = originalOuterTextTransparency }, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		tween(textInner, 0.35, { TextTransparency = originalInnerTextTransparency }, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		if outerStroke then
			tween(outerStroke, 0.35, { Transparency = originalOuterStrokeTransparency }, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		end
		if innerStroke then
			tween(innerStroke, 0.35, { Transparency = originalInnerStrokeTransparency }, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		end
	end

	task.delay(SUCCESS_HOLD_TIME, function()
		if state == "success" then
			state = "hiding"
			hideAll()
		end
	end)
end

local function cancel()
	if state == "idle" or state == "hiding" then
		return
	end
	state = "hiding"
	hideAll()
end

local function onPurchaseResult(status, _context)
	if status == "Prompting" then
		showPrompt()
	elseif status == "Success" then
		playSuccess()
	elseif status == "Cancelled" then
		cancel()
	end
end

function BuyTransitionController.Show()
	showPrompt()
end

function BuyTransitionController.Success()
	playSuccess()
end

function BuyTransitionController.Hide()
	cancel()
end

function BuyTransitionController.Init()
	local playerGui = player:WaitForChild("PlayerGui")
	local gui = playerGui:WaitForChild("GUI", 15)
	if not gui then
		return
	end
	local folder = gui:WaitForChild("Folder", 15)
	if not folder then
		return
	end
	frame = folder:WaitForChild("BuyTransition", 15)
	if not frame then
		return
	end

	shadow = frame:WaitForChild("Shadow", 5)
	icon = frame:WaitForChild("Icon", 5)
	textLabel = frame:WaitForChild("Double", 5)

	if shadow then
		shadowGradient = shadow:FindFirstChildOfClass("UIGradient")
		originalShadowTransparency = shadow.ImageTransparency
	end
	if icon then
		originalIconTransparency = icon.ImageTransparency
		originalIconSize = icon.Size
	end
	if textLabel then
		textInner = textLabel:FindFirstChild("Amount")
		originalTextSize = textLabel.Size
		originalOuterTextTransparency = textLabel.TextTransparency
		outerStroke = textLabel:FindFirstChildOfClass("UIStroke")
		if outerStroke then
			originalOuterStrokeTransparency = outerStroke.Transparency
		end
	end
	if textInner then
		originalInnerTextTransparency = textInner.TextTransparency
		innerStroke = textInner:FindFirstChildOfClass("UIStroke")
		if innerStroke then
			originalInnerStrokeTransparency = innerStroke.Transparency
		end
	end
	originalBgTransparency = frame.BackgroundTransparency

	frame.ZIndex = frame.ZIndex + ZINDEX_BOOST
	for _, desc in ipairs(frame:GetDescendants()) do
		if desc:IsA("GuiObject") then
			desc.ZIndex = desc.ZIndex + ZINDEX_BOOST
		end
	end

	resetVisuals()

	PurchaseResultEvent.OnClientEvent:Connect(onPurchaseResult)

	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(plr, _gamePassId, wasPurchased)
		if plr ~= player then
			return
		end
		if wasPurchased then
			playSuccess()
		else
			cancel()
		end
	end)

	-- Client-side backstop for dev products. The authoritative hide path goes
	-- through PurchaseService -> PurchaseResultEvent, but the server filters by
	-- pending.ProductId and stays silent on a mismatch (rapid double-click,
	-- replaced pending, Roblox auto-cancel). That used to leave the icon
	-- frozen on screen. Listening directly here clears the overlay as soon as
	-- the Roblox prompt closes for THIS player, regardless of server state.
	MarketplaceService.PromptProductPurchaseFinished:Connect(function(userId, _productId, isPurchased)
		if userId ~= player.UserId then
			return
		end
		if isPurchased then
			playSuccess()
		else
			cancel()
		end
	end)
end

-- Convenience wrapper: shows the transition and then prompts. Call this from any
-- client-side gamepass button instead of MarketplaceService:PromptGamePassPurchase
-- directly. Roblox provides no "PromptGamePassPurchaseStarted" event, so callers
-- must opt-in to the transition by using this helper.
function BuyTransitionController.PromptGamePass(gamePassId)
	showPrompt()
	pcall(function()
		MarketplaceService:PromptGamePassPurchase(player, gamePassId)
	end)
end

return BuyTransitionController
