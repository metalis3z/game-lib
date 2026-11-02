--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local Pressable = require(script.Parent.Pressable)
local SplitRow = require(script.Parent.SplitRow)
local Remote = require(modules.Objects.Remote)
local Prompt = require(modules.Prompt)
local RunService = game:GetService("RunService")
local sharedTypes = require(modules.References.sharedTypes)
local sendMessage = Remote.get("SendMessage")
local Icons = require(frontend.Config.Icons)


-- CONSTANTS
local GLOW_DURATION_SECONDS = 0.3


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type TrailingButton = {
	icon: string,
	iconColor: UsedAs<Color3>?,
	backgroundColor: UsedAs<Color3>?,
	onActivate: () -> (),
}
type Props = {
	commandKey: UsedAs<string>,
	commandName: UsedAs<string>?,
	quickRun: UsedAs<boolean>?,
	arguments: UsedAs<{ any }>?,
	text: UsedAs<string>?,
	commandPrefix: string?,
	customPrefix: UsedAs<string>?,
	activeCommands: Fusion.Value<{[string]: boolean}>?,
	onCommandActivate: (() -> ())?,
	commandText: UsedAs<string>?, -- overrides displayText for run
	chatSource: string?,
	runOnly: boolean?, -- always run, never stop
	runGate: (() -> (boolean, string?))?, -- return (false, reason) to block the run and warn
	unlockRole: UsedAs<string?>?, -- the Commands page section this run came from, so unlock invites match it
	size: UsedAs<UDim2>?,
	layoutOrder: UsedAs<number>?,
	textSize: number?,
	onCopy: (() -> ())?,
	trailingButtons: {TrailingButton}?, -- square icon slots on the right, mirroring the run button
	nameTag: string?, -- small pill on the right of the name area (the vet page's NEW marker)
	nameTagColor: UsedAs<Color3>?, -- pill background, defaults Primary
	nameTagTextColor: UsedAs<Color3>?, -- pill text, defaults PrimaryContent
}


-- COMPONENT
return function(scope: Scope, props: Props)
	debug.profilebegin("HD_CommandButton")
	local displayText = scope:Computed(function(use)
		local textValue = props.text and use(props.text) or ""
		local commandNameValue = props.commandName and use(props.commandName) or ""
		local prefixValue = props.commandPrefix or (props.customPrefix and use(props.customPrefix)) or ";"
		if type(textValue) == "string" and textValue:len() >= 1 then
			return textValue
		else
			return `{prefixValue}{commandNameValue}`
		end
	end)

	local isGlowing: Fusion.Value<boolean> = scope:Value(false)
	local pendingCount = 0

	local isActive = scope:Computed(function(use)
		if not props.activeCommands then return false end
		local active = use(props.activeCommands)
		local key = use(props.commandKey)
		return active[key] == true
	end)

	local isAnimating: Fusion.Value<boolean> = scope:Value(false)
	local animGlowOut: Fusion.Value<number> = scope:Value(0)
	local animActiveOut: Fusion.Value<number> = scope:Value(0)
	local displayAsActive: Fusion.Value<boolean> = scope:Value(Fusion.peek(isActive))
	local rotationOut: Fusion.Value<number> = scope:Value(0)

	-- Lazy anim infra, created on press, destroyed after settle
	local animScope: Fusion.Scope? = nil
	local rotationTarget: Fusion.Value<number>? = nil
	local animConnection: RBXScriptConnection? = nil

	local function teardownAnimInfra()
		if animConnection then
			animConnection:Disconnect()
			animConnection = nil
		end
		if animScope then
			Fusion.doCleanup(animScope)
			animScope = nil
		end
		rotationTarget = nil
		local active = Fusion.peek(isActive)
		animGlowOut:set(0)
		animActiveOut:set(if active then 1 else 0)
		rotationOut:set(0)
		displayAsActive:set(active)
		isAnimating:set(false)
	end

	local function ensureAnimInfra()
		if animScope then return end
		animScope = Fusion.scoped(Fusion)
		isAnimating:set(true)
		local animFrameCount = 0
		local MAX_ANIM_FRAMES = 600 -- ~10s at 60fps safety net

		local glowInput = (animScope :: any):Computed(function(use)
			return if use(isGlowing) then 1 else 0
		end)
		local glowSpring = (animScope :: any):Spring(glowInput, 40, 1.8)

		local activeInput = (animScope :: any):Computed(function(use)
			return if use(isActive) then 1 else 0
		end)
		local activeSpring = (animScope :: any):Spring(activeInput, 40, 1.8)

		rotationTarget = (animScope :: any):Value(0)
		local rotSpring = (animScope :: any):Spring(rotationTarget, 12, 1)

		animConnection = RunService.Heartbeat:Connect(function()
			animFrameCount += 1
			local glowVal = Fusion.peek(glowSpring)
			local activeVal = Fusion.peek(activeSpring)
			local rotVal = Fusion.peek(rotSpring)
			local activeTarget = Fusion.peek(activeInput)
			local rotTarget = Fusion.peek(rotationTarget)

			animGlowOut:set(glowVal)
			animActiveOut:set(activeVal)
			rotationOut:set(rotVal % 360)

			if activeVal >= 0.7 then
				displayAsActive:set(true)
			elseif activeVal <= 0.05 then
				displayAsActive:set(false)
			end

			local settled = not Fusion.peek(isGlowing)
				and glowVal < 0.01
				and math.abs(activeVal - activeTarget) < 0.01
				and rotTarget ~= nil and math.abs(rotVal - rotTarget) < 0.5
			if settled or animFrameCount >= MAX_ANIM_FRAMES then
				teardownAnimInfra()
			end
		end)
	end

	table.insert(scope, function()
		teardownAnimInfra()
	end)

	local stopText = scope:Computed(function(use)
		local textValue = props.text and use(props.text) or ""
		local commandNameValue = props.commandName and use(props.commandName) or ""
		local prefixValue = props.commandPrefix or (props.customPrefix and use(props.customPrefix)) or ";"
		if type(textValue) == "string" and textValue:len() >= 1 then
			local extractedPrefix = textValue:sub(1, 1)
			local extractedName = textValue:sub(2)
			return `{extractedPrefix}Un{extractedName}`
		else
			return `{prefixValue}Un{commandNameValue}`
		end
	end)

	local runIsHovered: Fusion.Value<boolean> = scope:Value(false)
	local runIsPressed: Fusion.Value<boolean> = scope:Value(false)
	local runButtonColor = scope:Computed(function(use)
		local normalColor = use(Theme.Color.Neutral)
		local primaryColor = use(Theme.Color.Primary)
		local glow, active
		if use(isAnimating) then
			glow = use(animGlowOut)
			active = use(animActiveOut)
		else
			glow = if use(isGlowing) then 1 else 0
			active = if use(isActive) then 1 else 0
		end
		local totalIntensity = math.min(1, active + glow)
		local base = normalColor:Lerp(primaryColor, totalIntensity)
		return Pressable.applyHighlight(use, base, runIsPressed, runIsHovered)
	end)

	local trailingSlots: {any}? = nil
	if props.trailingButtons then
		trailingSlots = {}
		for _, button in props.trailingButtons do
			local buttonHovered: Fusion.Value<boolean> = scope:Value(false)
			local buttonPressed: Fusion.Value<boolean> = scope:Value(false)
			local buttonBackground = button.backgroundColor
			table.insert(trailingSlots :: {any}, {
				name = "TrailingButton",
				fills = false,
				backgroundColor = if buttonBackground then scope:Computed(function(use)
					return Pressable.applyHighlight(use, use(buttonBackground :: any), buttonPressed, buttonHovered)
				end) else nil,
				isHovered = buttonHovered,
				isPressed = buttonPressed,
				onActivate = button.onActivate,
				[Children] = {
					scope:New "ImageLabel" {
						Name = "Icon",
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundTransparency = 1,
						Image = button.icon,
						ImageColor3 = button.iconColor or Theme.Color.NeutralContentMain,
						Position = UDim2.fromScale(0.5, 0.5),
						Size = scope:Computed(function(use)
							local size = math.round(17 * use(Theme.Layout.ContentScale))
							return UDim2.fromOffset(size, size)
						end),
					},
				},
			})
		end
	end

	local row = SplitRow(scope, {
		name = displayText,
		layoutOrder = props.layoutOrder,
		size = props.size or UDim2.new(1, 0, 0, 38),

		left = {
			name = "RunButton",
			fills = false,
			backgroundColor = runButtonColor,
			isHovered = runIsHovered,
			isPressed = runIsPressed,
			onActivate = function()
				if props.runGate then
					local canRun, reason = props.runGate()
					if not canRun then
						Prompt.warn(reason or "Text checks failed, please review and retry")
						return
					end
				end

				local forceRun = props.runOnly == true
				local overrideText = props.commandText
				local overrideValue = overrideText and (if typeof(overrideText) == "table" then Fusion.peek(overrideText) else overrideText) or nil
				local cmd = if (not forceRun) and Fusion.peek(isActive) then Fusion.peek(stopText)
					else (overrideValue or Fusion.peek(displayText))
				local chatSource: sharedTypes.MessageSource = (props.chatSource :: any) or "ClientRun"

				pendingCount += 1
				isGlowing:set(true)

				ensureAnimInfra()
				if rotationTarget then
					local current = Fusion.peek(rotationOut) % 360
					rotationTarget:set(current)
					rotationTarget:set(current + 360)
				end

				local startTime = tick()

				local unlockRoleRaw: any = props.unlockRole
				local unlockRole = if typeof(unlockRoleRaw) == "table" then Fusion.peek(unlockRoleRaw) else unlockRoleRaw
				local context = if typeof(unlockRole) == "string" and unlockRole ~= "" then {unlockRole = unlockRole} else nil
				local _, returnDetails: {[string]: any} = sendMessage:invokeServerAsync(cmd, chatSource, context)

				if not props.runOnly and returnDetails and props.activeCommands then
					local newActive = returnDetails.activeCommands or {}
					props.activeCommands:set(newActive)
				end

				local function finalize()
					pendingCount -= 1
					if pendingCount == 0 and Fusion.peek(isGlowing) then
						isGlowing:set(false)
					end
				end

				local elapsedTime = tick() - startTime
				local remainingTime = GLOW_DURATION_SECONDS - elapsedTime

				if remainingTime > 0 then
					task.delay(remainingTime, finalize)
				else
					finalize()
				end
			end,
			[Children] = {
				scope:New "ImageLabel" {
					Name = "Icon",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Image = scope:Computed(function(use)
						if props.runOnly then
							return Icons.RunCommand
						elseif use(isAnimating) then
							return if use(displayAsActive) then Icons.StopFill else Icons.RunCommand
						else
							return if use(isActive) then Icons.StopFill else Icons.RunCommand
						end
					end),
					ImageColor3 = scope:Computed(function(use)
						local glow, active
						if use(isAnimating) then
							glow = use(animGlowOut)
							active = use(animActiveOut)
						else
							glow = if use(isGlowing) then 1 else 0
							active = if use(isActive) then 1 else 0
						end
						local intensity = math.min(1, active + glow)
						return (use(Theme.Color.BaseContent) :: Color3):Lerp(use(Theme.Color.PrimaryContent), intensity)
					end),
					Position = UDim2.fromScale(0.5, 0.5),
					Size = scope:Computed(function(use)
						local size = math.round(17 * use(Theme.Layout.ContentScale))
						return UDim2.fromOffset(size, size)
					end),
					Rotation = rotationOut,
				},
			},
		},

		center = {
			name = "CommandButton",
			fills = true,
			onActivate = function()
				if props.onCommandActivate then
					props.onCommandActivate()
				end
			end,
			[Children] = {
				scope:New "TextLabel" {
					Name = "Text",
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1,
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), Enum.FontWeight.Medium)
					end),
					Position = UDim2.new(0, 10, 0.5, 0),
					Size = UDim2.new(1, -15, 0.5, -1),
					Text = displayText,
					TextColor3 = Theme.Color.BaseContent,
					TextSize = scope:Computed(function(use)
						local baseSize = props.textSize or 17
						return math.round(baseSize * use(Theme.Layout.ContentScale))
					end),
					TextTruncate = Enum.TextTruncate.SplitWord,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Center,
				},

				if props.nameTag then scope:New "Frame" {
					Name = "NameTag",
					AnchorPoint = Vector2.new(1, 0.5),
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundColor3 = props.nameTagColor or Theme.Color.Primary,
					Position = UDim2.new(1, -8, 0.5, 0),
					Size = UDim2.fromOffset(0, 18),
					[Children] = {
						scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
						scope:New "UIPadding" {
							PaddingLeft = UDim.new(0, 7),
							PaddingRight = UDim.new(0, 7),
						},
						scope:New "TextLabel" {
							Name = "Label",
							AutomaticSize = Enum.AutomaticSize.X,
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(0, 1),
							FontFace = scope:Computed(function(use)
								return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
							end),
							Text = props.nameTag,
							TextColor3 = props.nameTagTextColor or Theme.Color.PrimaryContent,
							TextSize = Theme.TextSize.Small,
						},
					},
				} else nil,
			},
		},

		right = if props.onCopy then {
			name = "CopyButton",
			fills = false,
			onActivate = function()
				local callback = props.onCopy
				if callback then callback() end
			end,
			[Children] = {
				scope:New "ImageLabel" {
					Name = "Icon",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Image = Icons.Copy,
					ImageColor3 = Theme.Color.NeutralContentMain,
					Position = UDim2.fromScale(0.5, 0.5),
					Size = scope:Computed(function(use)
						local size = math.round(17 * use(Theme.Layout.ContentScale))
						return UDim2.fromOffset(size, size)
					end),
				},
			},
		} else nil,

		rights = trailingSlots,
	})
	debug.profileend()
	return row
end
