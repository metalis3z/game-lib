local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Overall prompt size in px. The stock template used 72; everything inside
-- (key button, action text) scales off this. 90 = user-tuned 2026-07-17
-- (80 read too small, 100 too big); the text reads big because ActionText
-- is TextScaled (fills 55% of this height).
-- Template geometry is tied to this: InputFrame width and ActionText
-- x-offset are 90, ActionText right inset is -(90+24).
local PROMPT_HEIGHT = 90

local GamepadButtonImage = {
	[Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/xboxX.png",
	[Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/xboxY.png",
	[Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/xboxA.png",
	[Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/xboxB.png",
	[Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/dpadLeft.png",
	[Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/dpadRight.png",
	[Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/dpadUp.png",
	[Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/dpadDown.png",
	[Enum.KeyCode.ButtonSelect] = "rbxasset://textures/ui/Controls/xboxmenu.png",
	[Enum.KeyCode.ButtonL1] = "rbxasset://textures/ui/Controls/xboxLS.png",
	[Enum.KeyCode.ButtonR1] = "rbxasset://textures/ui/Controls/xboxRS.png",
}

local KeyboardButtonImage = {
	[Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png",
	[Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png",
	[Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png",
	[Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png",
	[Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png",
}

local KeyboardButtonIconMapping = {
	["'"] = "rbxasset://textures/ui/Controls/apostrophe.png",
	[","] = "rbxasset://textures/ui/Controls/comma.png",
	["`"] = "rbxasset://textures/ui/Controls/graveaccent.png",
	["."] = "rbxasset://textures/ui/Controls/period.png",
	[" "] = "rbxasset://textures/ui/Controls/spacebar.png",
}

local KeyCodeToTextMapping = {
	[Enum.KeyCode.LeftControl] = "Ctrl",
	[Enum.KeyCode.RightControl] = "Ctrl",
	[Enum.KeyCode.LeftAlt] = "Alt",
	[Enum.KeyCode.RightAlt] = "Alt",
	[Enum.KeyCode.F1] = "F1",
	[Enum.KeyCode.F2] = "F2",
	[Enum.KeyCode.F3] = "F3",
	[Enum.KeyCode.F4] = "F4",
	[Enum.KeyCode.F5] = "F5",
	[Enum.KeyCode.F6] = "F6",
	[Enum.KeyCode.F7] = "F7",
	[Enum.KeyCode.F8] = "F8",
	[Enum.KeyCode.F9] = "F9",
	[Enum.KeyCode.F10] = "F10",
	[Enum.KeyCode.F11] = "F11",
	[Enum.KeyCode.F12] = "F12",
}

local function getScreenGui()
	local screenGui = PlayerGui:FindFirstChild("ProximityPrompts")
	if screenGui == nil then
		screenGui = Instance.new("ScreenGui")
		screenGui.Name = "ProximityPrompts"
		screenGui.ResetOnSpawn = false
		screenGui.Parent = PlayerGui
	end
	return screenGui
end

local function setUpCircularProgressBar(bar)
	local leftGradient = bar.LeftGradient.ProgressBarImage.UIGradient
	local rightGradient = bar.RightGradient.ProgressBarImage.UIGradient

	local progress = bar.Progress
	progress.Changed:Connect(function(value)
		local angle = math.clamp(value * 360, 0, 360)
		leftGradient.Rotation = math.clamp(angle, 180, 360)
		rightGradient.Rotation = math.clamp(angle, 0, 180)
	end)
end

local function createPrompt(prompt, inputType, gui)
	local tweensForButtonHoldBegin = {}
	local tweensForButtonHoldEnd = {}
	local tweensForFadeOut = {}
	local tweensForFadeIn = {}
	local tweenInfoInFullDuration = TweenInfo.new(prompt.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local tweenInfoFast = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tweenInfoQuick = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local tweenInfoInstant = TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

	local promptUI = nil
	local promptTheme = prompt:GetAttribute("Theme")
	if promptTheme then
		local themedPromptUI = script:FindFirstChild(promptTheme)
		if themedPromptUI then
			promptUI = themedPromptUI:Clone()
		else
			warn(string.format("ProximityPrompt %q references missing theme %q, falling back to Default", prompt.Name, tostring(promptTheme)))
		end
	end

	if promptUI == nil then
		promptUI = script.Default:Clone()
	end

	promptUI.Enabled = true

	local frame = promptUI.PromptFrame
	local inputFrame = frame.InputFrame
	local actionText = frame.ActionText
	local objectText = frame.ObjectText

	-- Tweens for Frame and children
	local backgroundTransparency = frame.BackgroundTransparency
	local imageTransparency = frame.ImageTransparency
	frame.BackgroundTransparency = 1
	frame.ImageTransparency = 1
	-- TODO consolidate this with the other tweens for image labels, theres some duplication
	-- TODO make these functions somehow consolidate the properties objects?
	-- No Size keys in these four (stock collapsed the pill to half width on
	-- hold): PromptFrame carries a UIAspectRatioConstraint in this theme, so
	-- any width shrink drags the WHOLE widget's height down with it -- the
	-- prompt visibly squished while holding. Hold/trigger feedback is fades only.
	table.insert(tweensForButtonHoldBegin, TweenService:Create(frame, tweenInfoFast, { BackgroundTransparency = 1, ImageTransparency = 1 }))
	table.insert(tweensForButtonHoldEnd, TweenService:Create(frame, tweenInfoFast, { BackgroundTransparency = backgroundTransparency, ImageTransparency = imageTransparency }))
	table.insert(tweensForFadeOut, TweenService:Create(frame, tweenInfoFast, { BackgroundTransparency = 1, ImageTransparency = 1 }))
	table.insert(tweensForFadeIn, TweenService:Create(frame, tweenInfoFast, { BackgroundTransparency = backgroundTransparency, ImageTransparency = imageTransparency }))

	local function setupUIStrokeTweens(uiStroke)
		local transparency = uiStroke.Transparency
		uiStroke.Transparency = 1
		table.insert(tweensForButtonHoldBegin, TweenService:Create(uiStroke, tweenInfoFast, { Transparency = 1 }))
		table.insert(tweensForButtonHoldEnd, TweenService:Create(uiStroke, tweenInfoFast, { Transparency = transparency }))
		table.insert(tweensForFadeOut, TweenService:Create(uiStroke, tweenInfoFast, { Transparency = 1 }))
		table.insert(tweensForFadeIn, TweenService:Create(uiStroke, tweenInfoFast, { Transparency = transparency }))
	end

	local function setupGUIObjectTweens(guiObject)
		local guiObjectBackgroundTransparency = guiObject.BackgroundTransparency
		guiObject.BackgroundTransparency = 1
		table.insert(tweensForButtonHoldBegin, TweenService:Create(guiObject, tweenInfoFast, { BackgroundTransparency = 1 }))
		table.insert(tweensForButtonHoldEnd, TweenService:Create(guiObject, tweenInfoFast, { BackgroundTransparency = guiObjectBackgroundTransparency }))
		table.insert(tweensForFadeOut, TweenService:Create(guiObject, tweenInfoFast, { BackgroundTransparency = 1 }))
		table.insert(tweensForFadeIn, TweenService:Create(guiObject, tweenInfoFast, { BackgroundTransparency = guiObjectBackgroundTransparency }))
	end

	local function setupTextLabelTweens(textLabel)
		local textTransparency = textLabel.TextTransparency
		local textStrokeTransparency = textLabel.TextStrokeTransparency
		textLabel.TextTransparency = 1
		textLabel.TextStrokeTransparency = 1
		table.insert(tweensForButtonHoldBegin, TweenService:Create(textLabel, tweenInfoFast, { TextTransparency = 1, TextStrokeTransparency = 1 }))
		table.insert(tweensForButtonHoldEnd, TweenService:Create(textLabel, tweenInfoFast, { TextTransparency = textTransparency, TextStrokeTransparency = textStrokeTransparency }))
		table.insert(tweensForFadeOut, TweenService:Create(textLabel, tweenInfoFast, { TextTransparency = 1, TextStrokeTransparency = 1 }))
		table.insert(tweensForFadeIn, TweenService:Create(textLabel, tweenInfoFast, { TextTransparency = textTransparency, TextStrokeTransparency = textStrokeTransparency }))
	end

	local function setupImageLabelTweens(imageLabel)
		local imageTransparency = imageLabel.ImageTransparency
		imageLabel.ImageTransparency = 1
		table.insert(tweensForButtonHoldBegin, TweenService:Create(imageLabel, tweenInfoFast, { ImageTransparency = 1 }))
		table.insert(tweensForButtonHoldEnd, TweenService:Create(imageLabel, tweenInfoFast, { ImageTransparency = imageTransparency }))
		table.insert(tweensForFadeOut, TweenService:Create(imageLabel, tweenInfoFast, { ImageTransparency = 1 }))
		table.insert(tweensForFadeIn, TweenService:Create(imageLabel, tweenInfoFast, { ImageTransparency = imageTransparency }))
	end

	local function setupUnexpectedChildTweens(child)
		if child:IsA("UIStroke") then
			setupUIStrokeTweens(child)
		elseif child:IsA("UIGradient") then
			-- The Transparency property of UIGradients is not tweenable
		elseif child:IsA("GuiObject") then
			setupGUIObjectTweens(child)

			if child:IsA("TextLabel") then
				setupTextLabelTweens(child)
			elseif child:IsA("ImageLabel") then
				setupImageLabelTweens(child)
			end
		end

		for _, grandChild in pairs(child:GetChildren()) do
			setupUnexpectedChildTweens(grandChild)
		end
	end

	-- Key is UI object, value is whether or not we should tween out the children of it in the same manner
	local expectedFrameChildren = {[inputFrame] = false, [actionText] = true, [objectText] = true}
	for _, child in pairs(frame:GetChildren()) do
		if expectedFrameChildren[child] == nil then
			-- Unexpected child of the frame and direct children elements
			setupUnexpectedChildTweens(child)
		elseif expectedFrameChildren[child] == true then
			for _, grandChild in pairs(child:GetChildren()) do
				-- All children of ActionText or ObjectText
				setupUnexpectedChildTweens(grandChild)
			end
		end
	end

	local resizeableInputFrame = inputFrame.Frame
	-- Stock also widened the keycap on hold (AspectRatio -> 1.33/1.6), but the
	-- square 80px InputFrame box means widening can only SHRINK the height,
	-- squashing the keycap and the progress ring into an ellipse. Stays square.

	-- Tweens for ActionText and ObjectText
	setupTextLabelTweens(actionText)
	setupTextLabelTweens(objectText)

	local buttonFrame = resizeableInputFrame.ButtonFrame

	local function setupButtonFrameTweens()
		local buttonFrameBackgroundTransparency = buttonFrame.BackgroundTransparency
		local buttonFrameImageTransparency = buttonFrame.ImageTransparency

		table.insert(tweensForFadeOut, TweenService:Create(buttonFrame, tweenInfoQuick, { BackgroundTransparency = 1, ImageTransparency = 1 }))
		table.insert(tweensForFadeIn, TweenService:Create(buttonFrame, tweenInfoQuick, { BackgroundTransparency = buttonFrameBackgroundTransparency, ImageTransparency = buttonFrameImageTransparency }))

		for _, child in pairs(buttonFrame:GetChildren()) do
			if child:IsA("UIStroke") then
				local transparency = child.Transparency
				table.insert(tweensForFadeOut, TweenService:Create(child, tweenInfoQuick, { Transparency = 1 }))
				table.insert(tweensForFadeIn, TweenService:Create(child, tweenInfoQuick, { Transparency = transparency }))
			end
			-- Currently not supporting any other children other than UIStroke
		end
	end
	setupButtonFrameTweens()

	local buttonImage = resizeableInputFrame.ButtonImage
	local buttonText = resizeableInputFrame.ButtonText
	local icon = resizeableInputFrame.ButtonTextImage

	local function setupButtonTextTweens()
		local textTransparency = buttonText.TextTransparency
		local textStrokeTransparency = buttonText.TextStrokeTransparency
		local textBackgroundTransparency = buttonText.BackgroundTransparency
		buttonText.BackgroundTransparency = 1
		buttonText.TextStrokeTransparency = 1
		buttonText.TextTransparency = 1
		table.insert(tweensForFadeOut, TweenService:Create(buttonText, tweenInfoQuick, { TextTransparency = 1, TextStrokeTransparency = 1, BackgroundTransparency = 1 }))
		table.insert(tweensForFadeIn, TweenService:Create(buttonText, tweenInfoQuick, { TextTransparency = textTransparency, TextStrokeTransparency = textStrokeTransparency, BackgroundTransparency = textBackgroundTransparency }))

		for _, child in pairs(buttonText:GetChildren()) do
			if child:IsA("UIStroke") then
				local transparency = child.Transparency
				table.insert(tweensForFadeOut, TweenService:Create(child, tweenInfoQuick, { Transparency = 1 }))
				table.insert(tweensForFadeIn, TweenService:Create(child, tweenInfoQuick, { Transparency = transparency }))
			end
			-- Currently not supporting any other children other than UIStroke
		end
	end

	local function setupButtonImageTweens()
		local buttonImageTransparency = buttonImage.ImageTransparency
		local buttonImageBackgroundTransparency = buttonImage.BackgroundTransparency
		buttonImage.BackgroundTransparency = 1
		buttonImage.ImageTransparency = 1
		table.insert(tweensForFadeOut, TweenService:Create(buttonImage, tweenInfoQuick, { ImageTransparency = 1, BackgroundTransparency = 1 }))
		table.insert(tweensForFadeIn, TweenService:Create(buttonImage, tweenInfoQuick, { ImageTransparency = buttonImageTransparency, BackgroundTransparency = buttonImageBackgroundTransparency }))
	end

	local function setupIconTweens()
		local iconBackgroundTransparency = icon.BackgroundTransparency
		local iconImageTransparency = icon.ImageTransparency
		icon.BackgroundTransparency = 1
		icon.ImageTransparency = 1
		table.insert(tweensForFadeOut, TweenService:Create(icon, tweenInfoQuick, { ImageTransparency = 1, BackgroundTransparency = 1 }))
		table.insert(tweensForFadeIn, TweenService:Create(icon, tweenInfoQuick, { ImageTransparency = iconImageTransparency, BackgroundTransparency = iconBackgroundTransparency }))
	end

	if inputType == Enum.ProximityPromptInputType.Gamepad then
		if GamepadButtonImage[prompt.GamepadKeyCode] then
			setupIconTweens()
			icon.Image = GamepadButtonImage[prompt.GamepadKeyCode]

			-- Hide ButtonText and ButtonImage, show ButtonTextImage
			buttonText.Visible = false
			buttonImage.Visible = false
			icon.Visible = true	
		end
	elseif inputType == Enum.ProximityPromptInputType.Touch then
		setupButtonImageTweens()
		buttonImage.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png"

		-- Hide ButtonText and ButtonTextImage, show ButtonImage
		buttonText.Visible = false
		icon.Visible = false
		buttonImage.Visible = true	
	else
		setupButtonImageTweens()

		-- Show ButtonImage
		buttonImage.Visible = true

		local buttonTextString = UserInputService:GetStringForKeyCode(prompt.KeyboardKeyCode)

		local buttonTextImage = KeyboardButtonImage[prompt.KeyboardKeyCode]
		if buttonTextImage == nil then
			buttonTextImage = KeyboardButtonIconMapping[buttonTextString]
		end

		if buttonTextImage == nil then
			local keyCodeMappedText = KeyCodeToTextMapping[prompt.KeyboardKeyCode]
			if keyCodeMappedText then
				buttonTextString = keyCodeMappedText
			end
		end

		if buttonTextImage then
			setupIconTweens()
			icon.Image = buttonTextImage

			--  Hide ButtonText, show ButtonTextImage
			buttonText.Visible = false
			icon.Visible = true
		elseif buttonTextString ~= nil and buttonTextString ~= '' then
			if string.len(buttonTextString) > 2 then
				buttonText.TextSize = math.round(buttonText.TextSize * 6/7)
			end
			setupButtonTextTweens()
			buttonText.Text = buttonTextString

			-- Hide ButtonTextImage, show ButtonText
			icon.Visible = false
			buttonText.Visible = true
		else
			warn(string.format("ProximityPrompt %q has unsupported KeyCode %s, rendering placeholder", prompt.Name, tostring(prompt.KeyboardKeyCode)))
			setupButtonTextTweens()
			buttonText.Text = "?"

			icon.Visible = false
			buttonText.Visible = true
		end
	end

	if inputType == Enum.ProximityPromptInputType.Touch or prompt.ClickablePrompt then
		local button = promptUI.TextButton

		local buttonDown = false

		button.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) and
				input.UserInputState ~= Enum.UserInputState.Change then
				prompt:InputHoldBegin()
				buttonDown = true
			end
		end)
		button.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
				if buttonDown then
					buttonDown = false
					prompt:InputHoldEnd()
				end
			end
		end)

		promptUI.Active = true
	end

	if prompt.HoldDuration > 0 then
		local circleBar = resizeableInputFrame.ProgressBar
		setUpCircularProgressBar(circleBar)
		table.insert(tweensForButtonHoldBegin, TweenService:Create(circleBar.Progress, tweenInfoInFullDuration, { Value = 1 }))
		table.insert(tweensForButtonHoldEnd, TweenService:Create(circleBar.Progress, tweenInfoInstant, { Value = 0 }))
	end

	local holdBeganConnection
	local holdEndedConnection
	local triggeredConnection
	local triggerEndedConnection

	if prompt.HoldDuration > 0 then
		holdBeganConnection = prompt.PromptButtonHoldBegan:Connect(function()
			for _, tween in ipairs(tweensForButtonHoldBegin) do
				tween:Play()
			end
		end)

		holdEndedConnection = prompt.PromptButtonHoldEnded:Connect(function()
			for _, tween in ipairs(tweensForButtonHoldEnd) do
				tween:Play()
			end
		end)
	end

	triggeredConnection = prompt.Triggered:Connect(function()
		for _, tween in ipairs(tweensForFadeOut) do
			tween:Play()
		end
	end)

	triggerEndedConnection = prompt.TriggerEnded:Connect(function()
		for _, tween in ipairs(tweensForFadeIn) do
			tween:Play()
		end
	end)

	local function updateUIFromPrompt()
		-- todo: Use AutomaticSize instead of GetTextSize when that feature becomes available
		local actionTextParams = Instance.new("GetTextBoundsParams")
		actionTextParams.Text = prompt.ActionText
		actionTextParams.Font = actionText.FontFace
		-- Measure at the size the text actually RENDERS. ActionText is
		-- TextScaled: one line fills the label's pixel height (55% of the
		-- prompt height), not the authored TextSize (14). Measuring at 14
		-- under-reported the width, so the box came out too narrow and the
		-- scaled text wrapped ("Pick / Up").
		actionTextParams.Size = math.floor(PROMPT_HEIGHT * 0.55)
		actionTextParams.Width = 1000
		local actionTextSize = TextService:GetTextBoundsAsync(actionTextParams)

		-- ObjectText is fully transparent in this theme. It used to be measured
		-- and fed into the width via math.max, which made two identical
		-- "Pick Up" prompts render at different widths depending on the item
		-- name under them. It no longer affects sizing.
		
		local maxTextWidth = actionTextSize.X
		local promptHeight = PROMPT_HEIGHT
		local promptWidth = PROMPT_HEIGHT
		local textPaddingLeft = PROMPT_HEIGHT

		if (prompt.ActionText ~= nil and prompt.ActionText ~= '') or
			(prompt.ObjectText ~= nil and prompt.ObjectText ~= '') then
			promptWidth = maxTextWidth + textPaddingLeft + 24
		end

		local fixedWidth = prompt:GetAttribute("FixedWidth")
		if fixedWidth then
			promptWidth = fixedWidth
		end

		actionText.Text = prompt.ActionText
		objectText.Text = prompt.ObjectText
		actionText.AutoLocalize = prompt.AutoLocalize
		actionText.RootLocalizationTable = prompt.RootLocalizationTable

		objectText.AutoLocalize = prompt.AutoLocalize
		objectText.RootLocalizationTable = prompt.RootLocalizationTable

		promptUI.Size = UDim2.fromOffset(promptWidth, promptHeight)
		promptUI.SizeOffset = Vector2.new(prompt.UIOffset.X / promptUI.Size.Width.Offset, prompt.UIOffset.Y / promptUI.Size.Height.Offset)
	end

	local changedConnections = {}
	local function trackChanged(signal)
		table.insert(changedConnections, signal:Connect(updateUIFromPrompt))
	end
	trackChanged(prompt:GetPropertyChangedSignal("ActionText"))
	trackChanged(prompt:GetPropertyChangedSignal("ObjectText"))
	trackChanged(prompt:GetPropertyChangedSignal("AutoLocalize"))
	trackChanged(prompt:GetPropertyChangedSignal("RootLocalizationTable"))
	trackChanged(prompt:GetPropertyChangedSignal("UIOffset"))
	trackChanged(prompt:GetAttributeChangedSignal("FixedWidth"))

	updateUIFromPrompt()

	promptUI.Adornee = prompt.Parent
	promptUI.MaxDistance = 0
	local worldOffsetY = prompt:GetAttribute("WorldOffsetY")
	promptUI.StudsOffsetWorldSpace = Vector3.new(0, worldOffsetY or 0, 0)
	promptUI.Parent = gui

	for _, tween in ipairs(tweensForFadeIn) do
		tween:Play()
	end

	local cleaned = false
	local function cleanup()
		-- rerenderKey calls cleanup synchronously and used to yield here on the
		-- 200ms fade tween, which let Heartbeat fire concurrent rerenderKey
		-- coroutines and each created a fresh promptUI -- the orphans were
		-- never destroyed because cleanupByKey[key] had already been
		-- overwritten by the time their wait returned. Multiple "Remove"
		-- widgets piled up on screen as the player walked past adjacent pads.
		-- Make cleanup non-yielding: disconnect immediately, schedule the
		-- destroy in a separate coroutine. The `cleaned` guard prevents
		-- double-cleanup if the same closure is invoked twice.
		if cleaned then return end
		cleaned = true

		if holdBeganConnection then
			holdBeganConnection:Disconnect()
		end

		if holdEndedConnection then
			holdEndedConnection:Disconnect()
		end

		triggeredConnection:Disconnect()
		triggerEndedConnection:Disconnect()

		for _, conn in ipairs(changedConnections) do
			conn:Disconnect()
		end

		-- Destroy IMMEDIATELY -- no fade-out delay. A 200ms task.delay before
		-- destroy let duplicate UIs pile up when the closest-prompt picker
		-- flickered between two equidistant pads (each Heartbeat created a
		-- new UI for the new closest while the previous UI was still alive
		-- in its 200ms window). 4+ "Remove" widgets would accumulate on
		-- screen. Snap-destroy keeps at most one UI per key at any moment.
		if promptUI and promptUI.Parent then
			promptUI:Destroy()
		end
	end

	return cleanup
end

-- Per-keycode dedupe with distance-based picking. When multiple prompts in
-- range share the same KeyboardKeyCode (e.g. dozens of "Press E to Place"
-- pads visible at once on a player's plot), the player can't tell which one
-- their keypress will hit. We render only the closest prompt for each key
-- and re-evaluate every frame so the rendered one swaps as the player walks
-- between them. Prompts with DIFFERENT keys (E vs X, etc.) render side-by-
-- side as normal -- this dedupe is strictly per-key.
local promptsByKey = {}    -- [KeyCode] = { [prompt] = inputType }
local renderedByKey = {}   -- [KeyCode] = prompt currently rendered
local cleanupByKey = {}    -- [KeyCode] = cleanup function from createPrompt
local rerendering = {}     -- [KeyCode] = true while a rerender is mid-flight

local function getPromptAnchorPosition(prompt)
	local parent = prompt.Parent
	if parent and parent:IsA("Attachment") then
		parent = parent.Parent
	end
	if parent and parent:IsA("BasePart") then
		return parent.Position
	end
	return nil
end

local HYSTERESIS_STUDS = 1.5

local function pickClosestPromptForKey(key)
	local set = promptsByKey[key]
	if not set then return nil end
	local character = LocalPlayer.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	if not hrp then return nil end
	local playerPos = hrp.Position
	local currentBest = renderedByKey[key]
	local currentBestDist
	local best, bestDist
	for prompt in pairs(set) do
		local anchor = getPromptAnchorPosition(prompt)
		if anchor then
			local d = (anchor - playerPos).Magnitude
			if prompt == currentBest then currentBestDist = d end
			if not bestDist or d < bestDist then
				best = prompt
				bestDist = d
			end
		end
	end
	-- Hysteresis: if the currently rendered prompt is still in range, only
	-- swap to a new candidate that's meaningfully closer. Without this the
	-- picker flips every frame when the player stands roughly equidistant
	-- between two pads, and even with immediate-destroy cleanup the create/
	-- destroy ping-pong produces visible flicker and stacked widgets.
	if currentBest and currentBestDist and best and best ~= currentBest then
		if bestDist >= currentBestDist - HYSTERESIS_STUDS then
			return currentBest
		end
	end
	return best
end

-- rerenderKey is reentrancy-guarded per key. createPrompt yields inside
-- TextService:GetTextBoundsAsync, and Heartbeat fires a fresh callback
-- thread every frame -- without the guard, parallel callers would race: a
-- stale caller would see the pre-yield renderedByKey/cleanupByKey, call the
-- old cleanup a second time, then overwrite cleanupByKey with a fresh
-- prompt, orphaning the UI the in-flight call was building. That leak was
-- the "3+ Remove widgets stacking" symptom when walking past plot pads.
local function rerenderKey(key)
	if rerendering[key] then return end
	rerendering[key] = true

	local ok, err = pcall(function()
		local closest = pickClosestPromptForKey(key)
		if closest == renderedByKey[key] then return end

		-- Snapshot + clear bookkeeping BEFORE invoking cleanup/createPrompt,
		-- so any rerender call that does slip past the lock (e.g. fired from
		-- the PromptShown coroutine while we are mid-yield) sees the new
		-- target via the closest==rendered early-exit.
		local oldCleanup = cleanupByKey[key]
		cleanupByKey[key] = nil
		renderedByKey[key] = closest

		if oldCleanup then
			oldCleanup()
		end

		if closest then
			local inputType = promptsByKey[key] and promptsByKey[key][closest]
			local gui = getScreenGui()
			cleanupByKey[key] = createPrompt(closest, inputType, gui)
		end
	end)

	rerendering[key] = nil

	if not ok then
		warn("[ProximityPromptScript] rerenderKey error: " .. tostring(err))
	end
end

local function onLoad()
	ProximityPromptService.PromptShown:Connect(function(prompt, inputType)
		if prompt.Style == Enum.ProximityPromptStyle.Default then
			return
		end

		local key = prompt.KeyboardKeyCode
		local hasKey = key and key ~= Enum.KeyCode.Unknown
		if not hasKey then
			-- No keyboard binding (touch/gamepad-only) -- render plainly.
			local gui = getScreenGui()
			local cleanupFunction = createPrompt(prompt, inputType, gui)
			prompt.PromptHidden:Wait()
			cleanupFunction()
			return
		end

		promptsByKey[key] = promptsByKey[key] or {}
		promptsByKey[key][prompt] = inputType
		rerenderKey(key)

		prompt.PromptHidden:Wait()

		if promptsByKey[key] then
			promptsByKey[key][prompt] = nil
			if next(promptsByKey[key]) == nil then
				promptsByKey[key] = nil
			end
		end
		rerenderKey(key)
	end)

	-- Re-pick closest each frame so the rendered prompt swaps as the player
	-- walks between two prompts sharing the same key. Cheap iteration: only
	-- keys with at least one prompt in range stay in promptsByKey.
	RunService.Heartbeat:Connect(function()
		for key in pairs(promptsByKey) do
			rerenderKey(key)
		end
	end)
end

onLoad()