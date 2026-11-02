--!strict
-- LOCAL FIRST 
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local frontend = modules.Parent.Controllers.UI
local Icons = require(frontend.Config.Icons)


-- CONFIG 
local NOTICE_SOUND_ID = "rbxassetid://2865227271"
local WARN_SOUND_ID = "rbxassetid://2865228021"
local ALERT_SOUND_ID = "rbxassetid://6176997734"
local SIDEBAR_WIDTH = 280
local CENTRE_WIDTH = 440
local CENTRE_IMAGE_WIDTH = 600 -- image cards go wider so screenshot text stays readable
local IMAGE_CARD_CHROME = 84 -- vertical space around a card image (top bar 42 + paddings 16+16 + gap 10)
local CENTRE_SCALE = 1.05 -- stops an appearance spring glitch when displays reach exactly 1
local TOP_MAX_WIDTH = 620
local PADDING_FROM_EDGE = 16
local PADDING_FROM_TOP = 16
local TYPE_COLOR_KEY = {
	info = "Info",
	success = "Success",
	warn = "Warning",
	error = "Error",
	alert = "Warning",
}
local TYPE_ICON = {
	info = Icons.LogoGlyph,
	success = Icons.CheckMarkFill,
	warn = Icons.WarningFill,
	error = Icons.ProhibitedFill,
	alert = Icons.WarningFill,
}
local TYPE_TITLE = {
	info = "Info",
	success = "Success",
	warn = "Warning",
	error = "Error",
	alert = "Alert",
}
-- These keep the status colour, other bars follow the role tag colour then theme primary
local STATUS_BAR_KINDS: {[string]: boolean} = {
	success = true,
	warn = true,
	error = true,
}


-- LOCAL
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Navigate = require(frontend.Util.Navigate)
local Pressable = require(frontend.Components.Pressable)
local FavouriteButton = require(frontend.Components.FavouriteButton)
local UnlockButton = require(frontend.Components.UnlockButton)
local EmotePreview = require(frontend.Config.EmotePreview)
local Viewport = require(frontend.Config.Viewport)
local Platform = require(frontend.Util.Platform)
local RoleBadge = require(frontend.Components.RoleBadge)
local LoadingSpinner = require(frontend.Components.LoadingSpinner)
local VoteBody = require(frontend.Components.VoteBody)
local InputObjects = require(frontend.Config.InputObjects)
local Popups = require(frontend.Util.Popups)
local popupLifecycle = require(frontend.Util.popupLifecycle)
local registerSound = require(modules.AssetUtil.registerSound)
local promptSetFavoriteAsync = require(modules.AssetUtil.promptSetFavoriteAsync)
local fuseState = require(modules.DataUtil.fuseState)
local Children = Fusion.Children
local Out = Fusion.Out
local _noticeSound: Sound? = nil
local _warnSound: Sound? = nil


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Entry = Popups.Entry
type Props = {
	entry: Entry,
	zIndex: UsedAs<number>?, -- sidebar only, its slot in the layer pool
}


-- HELPERS
local function clampWidth(scope: Scope, fullWidth: number, renderScale: number?): UsedAs<number>
	local scale = renderScale or 1
	return scope:Computed(function(use)
		local available = use(Viewport.ViewportSize).X - 2 * PADDING_FROM_EDGE
		return math.min(fullWidth, available / scale)
	end)
end

local function ensureSoundsFolder(): Instance
	local folder = SoundService:FindFirstChild("HDNoticeSounds")
	if folder then return folder end
	folder = Instance.new("Folder")
	folder.Name = "HDNoticeSounds"
	folder.Parent = SoundService
	return folder
end

local function getNoticeSound(): Sound
	if _noticeSound then return _noticeSound end
	local sound = Instance.new("Sound")
	sound.Name = "Notice"
	sound.SoundId = NOTICE_SOUND_ID
	sound.Volume = 0.5
	sound.Parent = ensureSoundsFolder()
	registerSound(sound, "Interface")
	_noticeSound = sound
	return sound
end

local function getWarnSound(): Sound
	if _warnSound then return _warnSound end
	local sound = Instance.new("Sound")
	sound.Name = "Warn"
	sound.SoundId = WARN_SOUND_ID
	sound.Volume = 0.5
	sound.Parent = ensureSoundsFolder()
	registerSound(sound, "Interface")
	_warnSound = sound
	return sound
end

local function playSoundForKind(kind: string)
	local sound = if kind == "warn" or kind == "error"
		then getWarnSound()
		else getNoticeSound()
	sound:Play()
end

-- A fresh looped sound per alert so each can be muted on its own
local function makeAlertSound(): Sound
	local sound = Instance.new("Sound")
	sound.Name = "Alert"
	sound.SoundId = ALERT_SOUND_ID
	sound.Looped = true
	sound.Volume = 0.5
	sound.Parent = ensureSoundsFolder()
	registerSound(sound, "Interface")
	return sound
end

local function makeAvatar(scope2: Fusion.Scope, senderId: any, sizePx: number, layoutOrder: number): Instance
	local avatarImage = if typeof(senderId) == "number"
		then `rbxthumb://type=AvatarHeadShot&id={senderId}&w=150&h=150`
		else ""
	return scope2:New "ImageLabel" {
		Name = "Avatar",
		BackgroundColor3 = Theme.Color.NeutralContent,
		Image = avatarImage,
		LayoutOrder = layoutOrder,
		Size = UDim2.fromOffset(sizePx, sizePx),

		[Children] = {
			scope2:New "UICorner" { CornerRadius = UDim.new(1, 0) },
		},
	}
end

local function makeServerGlyph(scope2: Fusion.Scope, sizePx: number, layoutOrder: number): Instance
	return scope2:New "ImageLabel" {
		Name = "ServerIcon",
		BackgroundTransparency = 1,
		Image = Icons.ServerGlyph,
		ImageColor3 = Theme.Color.BaseContent,
		LayoutOrder = layoutOrder,
		Size = UDim2.fromOffset(sizePx, sizePx),
	}
end

local function makeIconButton(scope2: Fusion.Scope, name: string, image: UsedAs<string>, onClick: () -> (), layoutOrder: number, isVisible: UsedAs<boolean>?, iconColor: UsedAs<Color3>?, iconSize: UsedAs<number>?): Instance
	local hovered: Fusion.Value<boolean> = scope2:Value(false)
	local pressed: Fusion.Value<boolean> = scope2:Value(false)
	local haloTransparencyTarget = scope2:Computed(function(use)
		if use(pressed) then return 0.65 end
		if use(hovered) then return 0.82 end
		return 1
	end)
	local haloTransparency: any = if Platform.isMobile
		then haloTransparencyTarget
		else (scope2 :: any):Spring(haloTransparencyTarget, 70, 1)
	return Pressable(scope2, {
		name = name,
		layoutOrder = layoutOrder,
		size = UDim2.fromOffset(28, 28),
		backgroundColor = nil :: any,
		iconImage = image,
		iconColor = iconColor or Theme.Color.NeutralContentDark,
		iconSize = iconSize or 18,
		visible = isVisible,
		onActivate = onClick,
		onHoverChanged = function(isHovered: boolean) hovered:set(isHovered) end,
		onPressChanged = function(isPressed: boolean) pressed:set(isPressed) end,

		[Children] = {
			scope2:New "Frame" {
				Name = "Halo",
				BackgroundColor3 = Theme.Color.NeutralContent,
				BackgroundTransparency = haloTransparency,
				BorderSizePixel = 0,
				Size = UDim2.fromScale(1, 1),
				ZIndex = 0,

				[Children] = {
					scope2:New "UICorner" { CornerRadius = UDim.new(1, 0) },
				},
			},
		},
	})
end

local function makeMuteButton(scope2: Fusion.Scope, muteState: any, onMute: () -> (), layoutOrder: number, accentColor: UsedAs<Color3>): Instance
	local PULSE_SPEED = 4.5 -- radians/sec
	local phaseOffset = math.random() * math.pi * 2
	local phase = scope2:Value(0)
	local connection = RunService.Heartbeat:Connect(function()
		if Fusion.peek(muteState) then return end
		phase:set((math.sin(os.clock() * PULSE_SPEED + phaseOffset) + 1) / 2)
	end)
	table.insert(scope2 :: any, function() connection:Disconnect() end)
	local intensity = (scope2 :: any):Spring(scope2:Computed(function(use)
		return if use(muteState) then 0 else 1
	end), 16, 1)
	local swell = scope2:Computed(function(use)
		return use(phase) * use(intensity)
	end)
	local image = scope2:Computed(function(use)
		return if use(muteState) then Icons.VolumeOff else Icons.VolumeOn
	end)
	local iconSize = scope2:Computed(function(use)
		return 18 + 4 * use(swell)
	end)
	local iconColor = scope2:Computed(function(use)
		return use(Theme.Color.NeutralContentDark):Lerp(use(accentColor), use(swell) * 0.7)
	end)
	return makeIconButton(scope2, "MuteButton", image, onMute, layoutOrder, nil, iconColor, iconSize)
end

local function makeFlexSpacer(scope2: Fusion.Scope, layoutOrder: number): Instance
	return scope2:New "Frame" {
		Name = "Spacer",
		BackgroundTransparency = 1,
		LayoutOrder = layoutOrder,
		Size = UDim2.fromOffset(0, 0),

		[Children] = {
			scope2:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
		},
	}
end

local function makeProgressFill(scope2: Fusion.Scope, progress: UsedAs<number>, color: UsedAs<Color3>): Instance
	return scope2:New "Frame" {
		Name = "Fill",
		BackgroundColor3 = color,
		BorderSizePixel = 0,
		Size = scope2:Computed(function(use)
			return UDim2.new(use(progress), 0, 1, 0)
		end),
	}
end

local function escapeRich(text: string): string
	local out = text:gsub("&", "&amp;")
	out = out:gsub("<", "&lt;")
	out = out:gsub(">", "&gt;")
	return out
end

local function makeActionButton(scope2: Fusion.Scope, label: UsedAs<string>, onClick: () -> (), loadingValue: Fusion.Value<boolean>?, neutralStyle: boolean?, requiresConfirm: boolean?): Instance
	local background = if neutralStyle then Theme.Color.NeutralStroke else Theme.Color.Primary
	local content = if neutralStyle then Theme.Color.BaseContent else Theme.Color.PrimaryContent
	local loading = loadingValue or scope2:Value(false)
	local isArmed: Fusion.Value<boolean> = scope2:Value(false)
	local armToken = 0
	local function handleClick()
		if Fusion.peek(loading) then return end
		if requiresConfirm and not Fusion.peek(isArmed) then
			armToken += 1
			local thisToken = armToken
			isArmed:set(true)
			task.delay(2, function()
				if armToken == thisToken then
					isArmed:set(false)
				end
			end)
			return
		end
		if requiresConfirm then
			armToken += 1
			isArmed:set(false)
		end
		-- Only server buttons spin, a client button's work is instant
		if loadingValue then
			loading:set(true)
		end
		onClick()
	end
	local displayLabel: UsedAs<string> = if requiresConfirm
		then scope2:Computed(function(use)
			if use(isArmed) then
				return "Confirm?"
			end
			return if typeof(label) == "table" then use(label :: any) else (label :: string)
		end)
		else label
	local labelVisible = scope2:Computed(function(use) return not use(loading) end)
	local spinner = LoadingSpinner(scope2, {
		size = 11,
		thickness = 2,
		color = content,
		paddingY = 0,
		visible = loading,
	})
	local spinnerFrame = spinner :: any
	spinnerFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	spinnerFrame.Position = UDim2.fromScale(0.5, 0.5)
	return Pressable(scope2, {
		name = "ActionButton",
		backgroundColor = background,
		size = UDim2.new(0, 0, 0, 30),
		automaticSize = Enum.AutomaticSize.None,
		onActivate = handleClick,
		interactable = scope2:Computed(function(use) return not use(loading) end),

		[Children] = {
			scope2:New "UICorner" { CornerRadius = UDim.new(0, 6) },
			scope2:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
			scope2:New "TextLabel" {
				Name = "Label",
				BackgroundTransparency = 1,
				FontFace = scope2:Computed(function(use)
					return Font.new(use(Theme.Font.Body), Enum.FontWeight.Bold)
				end),
				Size = UDim2.fromScale(1, 1),
				Text = displayLabel,
				TextColor3 = content,
				TextSize = Theme.TextSize.Body,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
				Visible = labelVisible,
			},
			spinner,
		},
	})
end

local function makeToggleButton(scope2: Fusion.Scope, state: any, onPress: () -> ()): Instance
	local loading = scope2:Value(false)
	local pressedAt = 0
	local MIN_TOGGLE_TIME = 0.5 -- spinner and lock hold at least this long
	scope2:Observer(state):onChange(function()
		local elapsed = os.clock() - pressedAt
		if elapsed >= MIN_TOGGLE_TIME then
			loading:set(false)
		else
			task.delay(MIN_TOGGLE_TIME - elapsed, function()
				loading:set(false)
			end)
		end
	end)
	local function handlePress()
		if Fusion.peek(loading) then return end
		pressedAt = os.clock()
		loading:set(true)
		-- Safety net in case the server's state update never arrives
		task.delay(30, function()
			loading:set(false)
		end)
		onPress()
	end
	local isActive = scope2:Computed(function(use)
		return use(state) == "active"
	end)
	-- Appearance holds until the spinner finishes so nothing flips early
	local displayedActive = scope2:Value(Fusion.peek(isActive))
	local function syncDisplay()
		if not Fusion.peek(loading) then
			displayedActive:set(Fusion.peek(isActive))
		end
	end
	scope2:Observer(loading):onChange(syncDisplay)
	scope2:Observer(state):onChange(syncDisplay)
	local glyphImage = scope2:Computed(function(use)
		return if use(displayedActive) then Icons.ZapFill else Icons.Zap
	end)
	local glyphColor = scope2:Computed(function(use)
		return if use(displayedActive) then use(Theme.Color.Primary) else use(Theme.Color.BaseContent)
	end)
	local labelColor = scope2:Computed(function(use)
		return if use(displayedActive) then use(Theme.Color.BaseContent) else use(Theme.Color.PrimaryContent)
	end)
	local background = scope2:Computed(function(use)
		return if use(displayedActive) then use(Theme.Color.NeutralStroke) else use(Theme.Color.Primary)
	end)
	local contentVisible = scope2:Computed(function(use)
		return not use(loading)
	end)
	local spinner = LoadingSpinner(scope2, {
		size = 11,
		thickness = 2,
		color = Theme.Color.BaseContent,
		paddingY = 0,
		visible = loading,
	})
	local spinnerFrame = spinner :: any
	spinnerFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	spinnerFrame.Position = UDim2.fromScale(0.5, 0.5)
	return Pressable(scope2, {
		name = "ToggleButton",
		backgroundColor = background,
		size = UDim2.new(0, 0, 0, 30),
		automaticSize = Enum.AutomaticSize.None,
		onActivate = handlePress,
		interactable = scope2:Computed(function(use) return not use(loading) end),

		[Children] = {
			scope2:New "UICorner" { CornerRadius = UDim.new(0, 6) },
			scope2:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
			scope2:New "Frame" {
				Name = "Content",
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Visible = contentVisible,

				[Children] = {
					scope2:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						Padding = UDim.new(0, 6),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					scope2:New "ImageLabel" {
						Name = "Glyph",
						BackgroundTransparency = 1,
						Image = glyphImage,
						ImageColor3 = glyphColor,
						LayoutOrder = 1,
						Size = UDim2.fromOffset(16, 16),
					},
					scope2:New "TextLabel" {
						Name = "Label",
						AutomaticSize = Enum.AutomaticSize.X,
						BackgroundTransparency = 1,
						FontFace = scope2:Computed(function(use)
							return Font.new(use(Theme.Font.Body), Enum.FontWeight.Bold)
						end),
						LayoutOrder = 2,
						Size = UDim2.fromOffset(0, 16),
						Text = scope2:Computed(function(use)
							return if use(displayedActive) then "Deactivate" else "Activate"
						end),
						TextColor3 = labelColor,
						TextSize = Theme.TextSize.Body,
						TextYAlignment = Enum.TextYAlignment.Center,
					},
				},
			},
			spinner,
		},
	})
end

local function makeStopButton(scope2: Fusion.Scope, onPress: () -> ()): Instance
	return Pressable(scope2, {
		name = "StopButton",
		backgroundColor = Theme.Color.NeutralStroke,
		size = UDim2.fromOffset(30, 30),
		automaticSize = Enum.AutomaticSize.None,
		onActivate = onPress,
		iconImage = Icons.StopFill,
		iconColor = Theme.Color.BaseContent,
		iconSize = 14,

		[Children] = {
			scope2:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.None },
			scope2:New "UICorner" { CornerRadius = UDim.new(0, 6) },
		},
	})
end

-- Re-run re-invokes the command instead of toggling it off
local function makeRerunButton(scope2: Fusion.Scope, onPress: () -> ()): Instance
	local loading = scope2:Value(false)
	local function handlePress()
		if Fusion.peek(loading) then return end
		loading:set(true)
		task.delay(0.4, function() loading:set(false) end)
		onPress()
	end
	local contentVisible = scope2:Computed(function(use) return not use(loading) end)
	local spinner = LoadingSpinner(scope2, {
		size = 11,
		thickness = 2,
		color = Theme.Color.BaseContent,
		paddingY = 0,
		visible = loading,
	})
	local spinnerFrame = spinner :: any
	spinnerFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	spinnerFrame.Position = UDim2.fromScale(0.5, 0.5)
	return Pressable(scope2, {
		name = "RerunButton",
		backgroundColor = Theme.Color.NeutralStroke,
		size = UDim2.new(0, 0, 0, 30),
		automaticSize = Enum.AutomaticSize.None,
		onActivate = handlePress,
		interactable = scope2:Computed(function(use) return not use(loading) end),

		[Children] = {
			scope2:New "UICorner" { CornerRadius = UDim.new(0, 6) },
			scope2:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
			scope2:New "Frame" {
				Name = "Content",
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Visible = contentVisible,

				[Children] = {
					scope2:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						Padding = UDim.new(0, 6),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					scope2:New "ImageLabel" {
						Name = "Glyph",
						BackgroundTransparency = 1,
						Image = Icons.Rerun,
						ImageColor3 = Theme.Color.Primary,
						LayoutOrder = 1,
						Size = UDim2.fromOffset(16, 16),
					},
					scope2:New "TextLabel" {
						Name = "Label",
						AutomaticSize = Enum.AutomaticSize.X,
						BackgroundTransparency = 1,
						FontFace = scope2:Computed(function(use)
							return Font.new(use(Theme.Font.Body), Enum.FontWeight.Bold)
						end),
						LayoutOrder = 2,
						Size = UDim2.fromOffset(0, 16),
						Text = "Re-run",
						TextColor3 = Theme.Color.BaseContent,
						TextSize = Theme.TextSize.Body,
						TextYAlignment = Enum.TextYAlignment.Center,
					},
				},
			},
			spinner,
		},
	})
end

-- Matches makeToggleButton's styling, and retires itself after its one job
local function makeFooterButton(scope2: Fusion.Scope, label: string, icon: string?, neutralStyle: boolean, onActivate: () -> (), layoutOrder: number, visibleValue: Fusion.Value<boolean>, large: boolean?): Instance
	local background = if neutralStyle then Theme.Color.NeutralStroke else Theme.Color.Primary
	local labelColor = if neutralStyle then Theme.Color.BaseContent else Theme.Color.PrimaryContent
	local iconColor = if neutralStyle then Theme.Color.Primary else Theme.Color.PrimaryContent
	local loading = scope2:Value(false)
	local function handleClick()
		if Fusion.peek(loading) then return end
		loading:set(true)
		task.spawn(function()
			pcall(onActivate)
			visibleValue:set(false)
		end)
	end
	local contentVisible = scope2:Computed(function(use) return not use(loading) end)
	local spinner = LoadingSpinner(scope2, {
		size = 11,
		thickness = 2,
		color = labelColor,
		paddingY = 0,
		visible = loading,
	})
	local spinnerFrame = spinner :: any
	spinnerFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	spinnerFrame.Position = UDim2.fromScale(0.5, 0.5)
	return Pressable(scope2, {
		name = "FooterButton",
		backgroundColor = background,
		size = UDim2.new(0, 0, 0, if large then 30 else 26), -- large matches the action-card buttons
		automaticSize = Enum.AutomaticSize.None,
		layoutOrder = layoutOrder,
		visible = visibleValue,
		onActivate = handleClick,
		interactable = contentVisible,

		[Children] = {
			scope2:New "UICorner" { CornerRadius = UDim.new(0, 6) },
			scope2:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
			scope2:New "Frame" {
				Name = "Content",
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Visible = contentVisible,

				[Children] = {
					scope2:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						HorizontalFlex = Enum.UIFlexAlignment.None,
						VerticalFlex = Enum.UIFlexAlignment.None,
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 6),
					},
					scope2:Computed(function(_, innerScope)
						if icon == nil then return nil end
						return innerScope:New "ImageLabel" {
							Name = "Icon",
							BackgroundTransparency = 1,
							LayoutOrder = 1,
							Size = UDim2.fromOffset(16, 16),
							Image = icon,
							ImageColor3 = iconColor,
						}
					end),
					scope2:New "TextLabel" {
						Name = "Label",
						AutomaticSize = Enum.AutomaticSize.X,
						BackgroundTransparency = 1,
						FontFace = scope2:Computed(function(use)
							return Font.new(use(Theme.Font.Body), Enum.FontWeight.Bold)
						end),
						LayoutOrder = 2,
						Size = UDim2.fromOffset(0, if large then 18 else 15),
						Text = label,
						TextColor3 = labelColor,
						TextSize = if large then Theme.TextSize.Body else 15,
						TextYAlignment = Enum.TextYAlignment.Center,
					},
				},
			},
			spinner,
		},
	}) :: Instance
end

local function makeEquipButton(scope2: Fusion.Scope, label: string, onActivate: () -> (), pausedValue: Fusion.Value<boolean>?): Instance
	local loading = scope2:Value(false)
	local contentVisible = scope2:Computed(function(use)
		return not use(loading)
	end)
	local function handlePress()
		if Fusion.peek(loading) then return end
		loading:set(true)
		-- Resume only if we paused it, a user's manual pause is left alone
		local wasPaused = pausedValue ~= nil and Fusion.peek(pausedValue) == true
		if pausedValue and not wasPaused then
			pausedValue:set(true)
		end
		task.spawn(function()
			onActivate()
			loading:set(false)
			if pausedValue and not wasPaused then
				pausedValue:set(false)
			end
		end)
	end
	local spinner = LoadingSpinner(scope2, {
		size = 14,
		thickness = 2,
		color = Theme.Color.PrimaryContent,
		paddingY = 0,
		visible = loading,
	})
	local spinnerFrame = spinner :: any
	spinnerFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	spinnerFrame.Position = UDim2.fromScale(0.5, 0.5)
	return Pressable(scope2, {
		name = "EquipButton",
		backgroundColor = Theme.Color.Primary,
		size = UDim2.new(1, 0, 0, 32),
		automaticSize = Enum.AutomaticSize.None,
		onActivate = handlePress,
		interactable = contentVisible,

		[Children] = {
			scope2:New "UICorner" { CornerRadius = UDim.new(0, 6) },
			scope2:New "TextLabel" {
				Name = "Label",
				BackgroundTransparency = 1,
				FontFace = scope2:Computed(function(use)
					return Font.new(use(Theme.Font.Body), Enum.FontWeight.Bold)
				end),
				Size = UDim2.fromScale(1, 1),
				Text = label,
				TextColor3 = Theme.Color.PrimaryContent,
				TextSize = Theme.TextSize.Body,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
				Visible = contentVisible,
			},
			spinner,
		},
	})
end

local function makeActionBody(scope2: Fusion.Scope, entry: Entry): Instance
	local opts: any = entry.options or {}
	local onAction = opts.onAction
	local rows = {}

	if entry.text and entry.text ~= "" then
		table.insert(rows, scope2:New "TextLabel" {
			Name = "ActionText",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			FontFace = scope2:Computed(function(use)
				return Font.new(use(Theme.Font.Body), Enum.FontWeight.Medium)
			end),
			LayoutOrder = 1,
			Size = UDim2.new(1, 0, 0, 0),
			Text = entry.text,
			TextColor3 = Theme.Color.NeutralContentMain,
			TextSize = Theme.TextSize.Body,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
	end

	local controlValuesState: any = opts.controlValuesState
	for controlIndex, control in (opts.controls or {}) do
		local factory = (InputObjects :: any).items[control.inputType]
		if not factory then continue end
		local valueState = scope2:Value(control.value)
		local pending = false
		local suppressedValue: any = nil
		scope2:Observer(valueState):onChange(function()
			local current = Fusion.peek(valueState)
			if suppressedValue ~= nil and current == suppressedValue then
				suppressedValue = nil
				return
			end
			if pending then return end
			pending = true
			task.delay(0.1, function()
				pending = false
				if onAction then
					onAction("control", control.id, Fusion.peek(valueState))
				end
			end)
		end)
		if controlValuesState then
			scope2:Observer(controlValuesState):onChange(function()
				local map = Fusion.peek(controlValuesState)
				local pushedValue = if typeof(map) == "table" then (map :: any)[control.id] else nil
				if pushedValue ~= nil and pushedValue ~= Fusion.peek(valueState) then
					suppressedValue = pushedValue
					valueState:set(pushedValue)
				end
			end)
		end
		local inputConfig = table.clone(control.config or {})
		inputConfig.value = valueState
		inputConfig.title = control.label or inputConfig.title
		local widget = factory(scope2, inputConfig)
		widget.LayoutOrder = 1 + controlIndex
		table.insert(rows, widget)
	end

	local iconButtonsState: any = opts.iconButtonsState
	local function currentIcon(index: number, fallback: any): any
		local list = iconButtonsState and Fusion.peek(iconButtonsState)
		return (list and list[index]) or fallback
	end
	local iconRowChildren = {}
	for index, iconButton in (opts.iconButtons or {}) do
		if iconButton.component == "Favourite" then
			local active = scope2:Value(iconButton.active == true)
			local favLoading = scope2:Value(false)
			local favouritedFuse = fuseState(scope2, "perm", "FavoritedEmotes")
			local function syncActive()
				local current = currentIcon(index, iconButton)
				if current.assetId then
					local fav = Fusion.peek(favouritedFuse)
					active:set(typeof(fav) == "table" and (fav :: any)[tostring(current.assetId)] ~= nil)
				elseif typeof(current.active) == "boolean" then
					active:set(current.active)
				end
			end
			scope2:Observer(favouritedFuse):onChange(syncActive)
			if iconButtonsState then
				scope2:Observer(iconButtonsState):onChange(syncActive)
			end
			table.insert(iconRowChildren, FavouriteButton(scope2, {
				isFavourited = active,
				loading = favLoading,
				layoutOrder = index,
				iconSize = 16,
				flexNone = true,
				onToggle = function()
					if Fusion.peek(favLoading) then return end
					local current = currentIcon(index, iconButton)
					local newActive = not Fusion.peek(active)
					if current.assetId then
						favLoading:set(true)
						task.spawn(function()
							local confirmed = promptSetFavoriteAsync(current.assetId, newActive)
							if confirmed then
								active:set(newActive)
								if onAction then
									onAction("iconButton", current.id, newActive)
								end
							end
							favLoading:set(false)
						end)
					else
						active:set(newActive)
						if onAction then
							onAction("iconButton", current.id, newActive)
						end
					end
				end,
			}))
		elseif iconButton.component == "Unlock" then
			table.insert(iconRowChildren, UnlockButton(scope2, {
				layoutOrder = index,
				size = UDim2.new(1, 0, 0, 30),
				onUnlock = function()
					local current = currentIcon(index, iconButton)
					if current.assetId then
						EmotePreview.open(current.assetId, current.emoteName, current.animationId)
					end
				end,
			}))
		end
	end
	if #iconRowChildren > 0 then
		table.insert(iconRowChildren, scope2:New "UIListLayout" {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			Padding = UDim.new(0, 4),
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
		})
		table.insert(rows, scope2:New "Frame" {
			Name = "IconButtonRow",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = 90,
			Size = UDim2.new(1, 0, 0, 0),
			[Children] = iconRowChildren,
		})
	end

	local buttonChildren = {}
	if opts.toggleable and opts.actionState then
		local state: any = opts.actionState
		table.insert(buttonChildren, makeToggleButton(scope2, state, function()
			if onAction then
				local action = if Fusion.peek(state) == "active" then "deactivate" else "activate"
				onAction(action, "", nil)
			end
		end))
		table.insert(buttonChildren, makeStopButton(scope2, function()
			if onAction then onAction("end", "", nil) end
		end))
	elseif opts.rerun then
		table.insert(buttonChildren, makeRerunButton(scope2, function()
			if onAction then onAction("rerun", "", nil) end
		end))
		table.insert(buttonChildren, makeStopButton(scope2, function()
			if onAction then onAction("end", "", nil) end
		end))
	end
	for _, clientButton in (opts.clientButtons or {}) do
		table.insert(buttonChildren, makeActionButton(scope2, clientButton.label, function()
			if clientButton.onActivate then clientButton.onActivate() end
		end, nil, clientButton.style == "Neutral"))
	end
	local buttonLoadingState: any = opts.buttonLoadingState
	for _, button in (opts.buttons or {}) do
		local buttonId = button.id
		local loading = scope2:Value(false)
		if buttonLoadingState then
			scope2:Observer(buttonLoadingState):onChange(function()
				local state = Fusion.peek(buttonLoadingState)
				loading:set(typeof(state) == "table" and state[buttonId] == true)
			end)
		end
		table.insert(buttonChildren, makeActionButton(scope2, button.label, function()
			if onAction then onAction("button", buttonId, nil) end
		end, loading, button.style == "Neutral", button.confirm == true))
	end
	if #buttonChildren > 0 then
		table.insert(buttonChildren, scope2:New "UIListLayout" {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			Padding = UDim.new(0, 4),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})
		table.insert(rows, scope2:New "Frame" {
			Name = "ButtonRow",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = 100,
			Size = UDim2.new(1, 0, 0, 0),
			[Children] = buttonChildren,
		})
	end

	table.insert(rows, scope2:New "UIListLayout" {
		FillDirection = Enum.FillDirection.Vertical,
		Padding = UDim.new(0, 10),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})
	table.insert(rows, scope2:New "UIPadding" {
		PaddingBottom = UDim.new(0, 14),
		PaddingLeft = UDim.new(0, 14),
		PaddingRight = UDim.new(0, 14),
	})
	return scope2:New "Frame" {
		Name = "ActionBody",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = 2,
		Size = UDim2.new(1, 0, 0, 0),
		[Children] = rows,
	}
end

-- I've disabled this for now so I can focus fully later on making it
-- complient with the new Roblox age-group-chatting guidelines
local function makeReplyArea(scope2: Fusion.Scope, placeholder: string, layoutOrder: number): Instance
	local FADE = 0.55 -- how dim the disabled box reads
	return scope2:New "Frame" {
		Name = "ReplyArea",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = layoutOrder,
		Size = UDim2.new(1, 0, 0, 0),

		[Children] = {
			scope2:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				Padding = UDim.new(0, 6),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			scope2:New "CanvasGroup" {
				Name = "ComposeBox",
				BackgroundColor3 = Theme.Color.Neutral,
				GroupTransparency = FADE,
				Interactable = false,
				LayoutOrder = 1,
				Size = UDim2.new(1, 0, 0, 40),

				[Children] = {
					scope2:New "UICorner" { CornerRadius = UDim.new(0, 8) },
					-- CanvasGroup transparency skips the stroke (roblox bug) so fade it by hand
					scope2:New "UIStroke" {
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Color = Theme.Color.NeutralStroke,
						Thickness = 1,
						Transparency = FADE,
					},
					scope2:New "UIPadding" {
						PaddingTop = UDim.new(0, 8),
						PaddingBottom = UDim.new(0, 8),
						PaddingLeft = UDim.new(0, 10),
						PaddingRight = UDim.new(0, 8),
					},
					scope2:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						Padding = UDim.new(0, 8),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},

					scope2:New "TextLabel" {
						Name = "Input",
						BackgroundTransparency = 1,
						FontFace = scope2:Computed(function(use)
							return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
						end),
						LayoutOrder = 1,
						Size = UDim2.new(1, 0, 1, 0),
						Text = placeholder,
						TextColor3 = Theme.Color.NeutralContentDark,
						TextSize = Theme.TextSize.Subtitle,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Center,

						[Children] = {
							scope2:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
						},
					},

					scope2:New "Frame" {
						Name = "SendButton",
						BackgroundColor3 = Theme.Color.Primary,
						LayoutOrder = 2,
						Size = UDim2.fromOffset(60, 26),

						[Children] = {
							scope2:New "UICorner" { CornerRadius = UDim.new(0, 6) },
							scope2:New "TextLabel" {
								Name = "Label",
								BackgroundTransparency = 1,
								FontFace = scope2:Computed(function(use)
									return Font.new(use(Theme.Font.Body), Enum.FontWeight.Bold)
								end),
								Size = UDim2.fromScale(1, 1),
								Text = "Send",
								TextColor3 = Theme.Color.PrimaryContent,
								TextSize = Theme.TextSize.Body,
								TextXAlignment = Enum.TextXAlignment.Center,
								TextYAlignment = Enum.TextYAlignment.Center,
							},
						},
					},
				},
			},

			scope2:New "TextLabel" {
				Name = "DisabledCaption",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				FontFace = scope2:Computed(function(use)
					return Font.new(use(Theme.Font.Body), Enum.FontWeight.Medium)
				end),
				LayoutOrder = 2,
				Size = UDim2.new(1, 0, 0, 0),
				Text = "Temporarily disabled. Coming soon with age-group limits",
				TextColor3 = Theme.Color.NeutralContentDark,
				TextSize = Theme.TextSize.Small,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
		},
	}
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local entry = props.entry
	local opts = entry.options
	local kind = entry.kind
	local duration: number = entry.duration
	local onActivate = if opts then opts.onActivate else nil
	local fromServer = if opts then opts.fromServer == true else false
	local senderId = if opts then opts.fromUserId else nil
	local senderName = if opts and opts.fromUserDisplayName and opts.fromUserDisplayName ~= ""
		then opts.fromUserDisplayName
		else if opts and opts.fromUserName and opts.fromUserName ~= "" then opts.fromUserName else nil
	local senderUserName = if opts and opts.fromUserName and opts.fromUserName ~= "" then opts.fromUserName else nil
	local senderTopRole = if opts and opts.fromUserTopRole and opts.fromUserTopRole ~= "" then opts.fromUserTopRole else nil
	local senderTopRoleColor = if opts then opts.fromUserTopRoleColor else nil
	local titleText = if opts and opts.title and opts.title ~= "" then opts.title else nil
	local imageId: string? = if opts and typeof(opts.image) == "string" and opts.image ~= "" then opts.image else nil
	local roleBadges: {any}? = if opts and typeof(opts.roleBadges) == "table" and #opts.roleBadges > 0 then opts.roleBadges else nil
	local subtext: string? = if opts and typeof(opts.subtext) == "string" and opts.subtext ~= "" then opts.subtext else nil
	local footerButtons: {any}? = if opts and typeof(opts.footerButtons) == "table" and #opts.footerButtons > 0 then opts.footerButtons else nil
	local titleInTopBar = titleText ~= nil and senderName == nil and not fromServer
	local keepOpenOnActivate = if opts then opts.keepOpenOnActivate == true else false
	local allowReply = if opts then opts.allowReply == true else false
	local isAction = kind == "action"
	local equipConfig = if opts then opts.equip else nil
	local onAction = if opts then opts.onAction else nil
	local muteState = if opts then opts.muteState else nil
	local onMute = if opts then opts.onMute else nil
	local countdownFrom: number? = if opts and typeof(opts.countdown) == "number" and opts.countdown >= 1
		then opts.countdown
		else nil
	local compactPrefix: string? = if kind == "privateMessage" then "Private Message"
		elseif kind == "alert" then "Alert"
		elseif kind == "vote" then "Click to view poll"
		elseif kind == "voteResults" then "Poll Results"
		elseif countdownFrom then "Countdown"
		else nil
	-- A poll card can't be paused because the poll itself keeps running on the
	-- server, so the bar would start lying
	local isPollCard = kind == "vote" or kind == "voteResults"
	local barColor: UsedAs<Color3> = if STATUS_BAR_KINDS[kind]
		then (Theme.Color :: any)[TYPE_COLOR_KEY[kind]]
		else (senderTopRoleColor or Theme.Color.Primary)

	local bail = false
	table.insert(scope, function() bail = true end)
	if entry.channel == "sidebar" and kind == "alert" and muteState then
		local alertSound = makeAlertSound()
		table.insert(scope, function()
			alertSound:Stop()
			alertSound:Destroy()
		end)
		scope:Observer(muteState):onChange(function()
			alertSound.Volume = if Fusion.peek(muteState) then 0 else 0.5
		end)
		task.defer(function()
			if bail then return end
			alertSound:Play()
		end)
	end

	local onShow = if entry.channel == "sidebar" and kind ~= "alert" and not isAction
		then function() playSoundForKind(kind) end
		else nil
	local life = popupLifecycle(scope, entry, onShow)

	local displayText: UsedAs<string> = if countdownFrom
		then scope:Computed(function(use)
			local remaining = math.ceil(use(life.progress) * countdownFrom)
			return tostring(math.max(remaining, 1))
		end)
		else entry.text

	-------------------------------------------------------------------- SIDEBAR
	if entry.channel == "sidebar" then
		local iconColor: UsedAs<Color3> = if kind == "info" or isAction
			then Theme.Color.BaseContent
			else (Theme.Color :: any)[TYPE_COLOR_KEY[kind] or "Info"]
		local iconOverride = if opts and typeof(opts.icon) == "string" then opts.icon else nil
		local typeIcon = iconOverride or (if isAction then Icons.Pages.Commands else (TYPE_ICON[kind] or Icons.Info))
		local headerTitle = if fromServer then "Server" else (senderName or titleText or (TYPE_TITLE[kind] or "Notice"))

		local cardWidth = clampWidth(scope, SIDEBAR_WIDTH)
		local targetPosition = scope:Computed(function(use)
			local off = use(life.offset) :: number
			local xOffset = if use(life.visible) then -PADDING_FROM_EDGE else (use(cardWidth) + 64)
			return UDim2.new(1, xOffset, 1, -(PADDING_FROM_EDGE + off))
		end)
		local position = scope:Spring(targetPosition, 28, 1)

		return scope:New "CanvasGroup" {
			Name = "Popup_" .. kind,
			Active = true,
			AnchorPoint = Vector2.new(1, 1),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Theme.Color.Base,
			BackgroundTransparency = 0.05,
			Position = position,
			ZIndex = props.zIndex,
			Size = scope:Computed(function(use)
				return UDim2.fromOffset(use(cardWidth), 0)
			end),

			[Out("AbsoluteSize")] = entry.size,

			[Children] = {
				scope:New "UICorner" { CornerRadius = UDim.new(0, 9) },
				scope:New "UIStroke" {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Color = Theme.Color.NeutralStroke,
					Thickness = 1,
				},

				scope:Computed(function(use, innerScope)
					if onActivate == nil then return nil end
					local function activateCard()
						if onActivate then onActivate() end
						if not keepOpenOnActivate then
							life.requestDismiss()
						end
					end
					return Navigate.makeActivatable(innerScope:New "TextButton" {
						Name = "CardButton",
						AutoButtonColor = false,
						BackgroundTransparency = 1,
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
						Size = UDim2.fromScale(1, 1),
						Text = "",
						TextColor3 = Color3.new(),
						TextSize = 1,
						ZIndex = 0,

						[Fusion.OnEvent "Activated"] = activateCard,
					}, activateCard)
				end),

				scope:New "Frame" {
					Name = "Content",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),

					[Children] = {
						scope:New "UIListLayout" {
							FillDirection = Enum.FillDirection.Vertical,
							HorizontalAlignment = Enum.HorizontalAlignment.Left,
							Padding = UDim.new(0, 0),
							SortOrder = Enum.SortOrder.LayoutOrder,
						},

						scope:New "Frame" {
							Name = "TitleBar",
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundTransparency = 1,
							LayoutOrder = 1,
							-- The 42 floor keeps headers level when close and pause are hidden
							Size = UDim2.new(1, 0, 0, 42),

							[Children] = {
								scope:New "UIPadding" {
									PaddingBottom = UDim.new(0, 6),
									PaddingLeft = UDim.new(0, 14),
									PaddingRight = UDim.new(0, 10),
									PaddingTop = UDim.new(0, 8),
								},
								scope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Horizontal,
									VerticalAlignment = Enum.VerticalAlignment.Center,
									Padding = UDim.new(0, 8),
									SortOrder = Enum.SortOrder.LayoutOrder,
								},

								if fromServer
									then makeServerGlyph(scope, 16, 1)
									elseif senderId ~= nil
									then makeAvatar(scope, senderId, 24, 1)
									else scope:New "ImageLabel" {
										Name = "TypeIcon",
										BackgroundTransparency = 1,
										Image = typeIcon,
										ImageColor3 = iconColor,
										LayoutOrder = 1,
										Size = UDim2.fromOffset(16, 16),

										[Children] = if kind == "info" then {
											scope:New "UICorner" { CornerRadius = UDim.new(0, 3) },
										} else nil,
									},

								scope:New "TextLabel" {
									Name = "Title",
									AutomaticSize = Enum.AutomaticSize.XY,
									BackgroundTransparency = 1,
									FontFace = scope:Computed(function(use)
										return Font.new(use(Theme.Font.Heading), use(Theme.FontWeight.Heading))
									end),
									LayoutOrder = 2,
									Size = UDim2.new(0, 0, 0, 0),
									Text = headerTitle,
									TextColor3 = Theme.Color.BaseContent,
									TextSize = Theme.TextSize.Subtitle,
									TextTruncate = Enum.TextTruncate.AtEnd,
									TextXAlignment = Enum.TextXAlignment.Left,

									[Children] = {
										scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Shrink },
									},
								},

								scope:Computed(function(use, innerScope)
									if senderName == nil or senderTopRole == nil then return nil end
									return RoleBadge(innerScope, {
										name = senderTopRole,
										color = senderTopRoleColor or Theme.Color.Primary,
										layoutOrder = 3,
										large = true,
										pillHeight = 25,
									})
								end),

								makeFlexSpacer(scope, 4),
								makeIconButton(scope, "PauseButton", scope:Computed(function(use)
									return if use(entry.paused) then Icons.PlayLarge else Icons.PauseLarge
								end), life.togglePause, 5, duration > 0 and countdownFrom == nil and not isAction and not isPollCard),
								scope:Computed(function(use, innerScope)
									if onMute == nil or muteState == nil then return nil end
									return makeMuteButton(innerScope, muteState, onMute, 6, senderTopRoleColor or Theme.Color.Primary)
								end),
								scope:Computed(function(_, innerScope)
									if opts and opts.dismissable == false then return nil end
									return makeIconButton(innerScope, "CloseButton", Icons.Close, function()
										if isAction and onAction then
											onAction("dismiss", "", nil)
										end
										life.requestDismiss()
									end, 7)
								end),
							},
						},

						(function()
							if isAction then
								return makeActionBody(scope, entry)
							end
							-- We don't use RichText as plain text keeps the selectable TextBox
							local isRich = string.find(entry.text, "<b>", 1, true) ~= nil
								or string.find(entry.text, "<font", 1, true) ~= nil
							local bodyPadding = scope:New "UIPadding" {
								PaddingBottom = UDim.new(0, if roleBadges ~= nil or subtext ~= nil then 6 else 16),
								PaddingLeft = UDim.new(0, 14),
								PaddingRight = UDim.new(0, 14),
							}
							local bodyFont = scope:Computed(function(use)
								return Font.new(use(Theme.Font.Body), Enum.FontWeight.Medium)
							end)
							if compactPrefix ~= nil then
								return scope:New "TextLabel" {
									Name = "Body",
									AutomaticSize = Enum.AutomaticSize.Y,
									BackgroundTransparency = 1,
									FontFace = bodyFont,
									LayoutOrder = 2,
									RichText = true,
									Size = UDim2.new(1, 0, 0, 0),
									Text = scope:Computed(function(use)
										local faded = use(Theme.Color.NeutralContentMain):Lerp(use(Theme.Color.Base), 0.35)
										local rgb = `rgb({math.round(faded.R * 255)},{math.round(faded.G * 255)},{math.round(faded.B * 255)})`
										local body = escapeRich(use(displayText))
										if isPollCard then
											body = `"{body}"`
										end
										return `<b><i><font color="{rgb}">{compactPrefix}:</font></i> {body}</b>`
									end),
									TextColor3 = Theme.Color.NeutralContentMain,
									TextSize = Theme.TextSize.Body,
									TextTruncate = Enum.TextTruncate.AtEnd,
									TextWrapped = false,
									TextXAlignment = Enum.TextXAlignment.Left,
									[Children] = {bodyPadding},
								}
							end
							if isRich then
								return scope:New "TextLabel" {
									Name = "Body",
									AutomaticSize = Enum.AutomaticSize.Y,
									BackgroundTransparency = 1,
									FontFace = bodyFont,
									LayoutOrder = 2,
									RichText = true,
									Size = UDim2.new(1, 0, 0, 0),
									Text = displayText,
									TextColor3 = Theme.Color.NeutralContentMain,
									TextSize = Theme.TextSize.Body,
									TextWrapped = true,
									TextXAlignment = Enum.TextXAlignment.Left,
									[Children] = {bodyPadding},
								}
							end
							return scope:New "TextBox" {
								Name = "Body",
								AutomaticSize = Enum.AutomaticSize.Y,
								BackgroundTransparency = 1,
								ClearTextOnFocus = false,
								-- When the card is clickable, don't let the TextBox swallow the click
								Interactable = onActivate == nil,
								FontFace = bodyFont,
								LayoutOrder = 2,
								MultiLine = true,
								Size = UDim2.new(1, 0, 0, 0),
								Text = displayText,
								TextColor3 = Theme.Color.NeutralContentMain,
								TextEditable = false,
								TextSize = Theme.TextSize.Body,
								TextWrapped = true,
								TextXAlignment = Enum.TextXAlignment.Left,
								[Children] = {bodyPadding},
							}
						end)(),

						scope:Computed(function(_, innerScope)
							if roleBadges == nil then return nil end
							local badgeChildren: {any} = {
								innerScope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Horizontal,
									Wraps = true,
									HorizontalFlex = Enum.UIFlexAlignment.None,
									VerticalFlex = Enum.UIFlexAlignment.None,
									SortOrder = Enum.SortOrder.LayoutOrder,
									Padding = UDim.new(0, 4),
								},
								innerScope:New "UIPadding" {
									PaddingBottom = UDim.new(0, if subtext ~= nil or footerButtons ~= nil then 8 else 16),
									PaddingLeft = UDim.new(0, 14),
									PaddingRight = UDim.new(0, 14),
								},
							}
							for index, badge in roleBadges :: {any} do
								if typeof(badge) ~= "table" or typeof(badge.name) ~= "string" then
									continue
								end
								table.insert(badgeChildren, RoleBadge(innerScope, {
									name = badge.name,
									color = if typeof(badge.color) == "Color3" then badge.color else nil,
									layoutOrder = index,
								}))
							end
							return innerScope:New "Frame" {
								Name = "RoleBadges",
								AutomaticSize = Enum.AutomaticSize.Y,
								BackgroundTransparency = 1,
								LayoutOrder = 3,
								Size = UDim2.new(1, 0, 0, 0),
								[Children] = badgeChildren,
							}
						end),

						scope:Computed(function(_, innerScope)
							if subtext == nil then return nil end
							return innerScope:New "TextLabel" {
								Name = "Subtext",
								AutomaticSize = Enum.AutomaticSize.Y,
								BackgroundTransparency = 1,
								FontFace = innerScope:Computed(function(use)
									return Font.new(use(Theme.Font.Body), Enum.FontWeight.Medium)
								end),
								LayoutOrder = 3,
								RichText = true,
								Size = UDim2.new(1, 0, 0, 0),
								Text = `<i>{subtext}</i>`,
								TextColor3 = Theme.Color.NeutralContentDark,
								TextSize = Theme.TextSize.Label,
								TextWrapped = true,
								TextXAlignment = Enum.TextXAlignment.Left,

								[Children] = {
									innerScope:New "UIPadding" {
										PaddingBottom = UDim.new(0, 16),
										PaddingLeft = UDim.new(0, 14),
										PaddingRight = UDim.new(0, 14),
									},
								},
							}
						end),

						scope:Computed(function(_, innerScope)
							if footerButtons == nil then return nil end
							local rowChildren: {any} = {
								innerScope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Horizontal,
									VerticalAlignment = Enum.VerticalAlignment.Center,
									HorizontalFlex = Enum.UIFlexAlignment.None,
									VerticalFlex = Enum.UIFlexAlignment.None,
									SortOrder = Enum.SortOrder.LayoutOrder,
									Padding = UDim.new(0, 6),
								},
								innerScope:New "UIPadding" {
									PaddingBottom = UDim.new(0, 12),
									PaddingLeft = UDim.new(0, 14),
									PaddingRight = UDim.new(0, 14),
								},
							}
							local buttonVisibles: {Fusion.Value<boolean>} = {}
							for index, buttonInfo in footerButtons :: {any} do
								if typeof(buttonInfo) ~= "table" or typeof(buttonInfo.label) ~= "string" or typeof(buttonInfo.onActivate) ~= "function" then
									continue
								end
								local visibleValue = innerScope:Value(true)
								table.insert(buttonVisibles, visibleValue)
								local icon = if typeof(buttonInfo.icon) == "string" then buttonInfo.icon else nil
								local neutralStyle = buttonInfo.style == "Neutral"
								table.insert(rowChildren, makeFooterButton(innerScope, buttonInfo.label, icon, neutralStyle, buttonInfo.onActivate, index, visibleValue, buttonInfo.large == true))
							end
							return innerScope:New "Frame" {
								Name = "FooterButtons",
								AutomaticSize = Enum.AutomaticSize.Y,
								BackgroundTransparency = 1,
								LayoutOrder = 3,
								Size = UDim2.new(1, 0, 0, 0),
								Visible = innerScope:Computed(function(use)
									for _, visibleValue in buttonVisibles do
										if use(visibleValue) then
											return true
										end
									end
									return false
								end),

								[Children] = rowChildren,
							}
						end),

						scope:Computed(function(use, innerScope)
							if equipConfig == nil then return nil end
							return innerScope:New "Frame" {
								Name = "EquipRow",
								AutomaticSize = Enum.AutomaticSize.Y,
								BackgroundTransparency = 1,
								LayoutOrder = 3,
								Size = UDim2.new(1, 0, 0, 0),
								[Children] = {
									innerScope:New "UIPadding" {
										PaddingBottom = UDim.new(0, 12),
										PaddingLeft = UDim.new(0, 14),
										PaddingRight = UDim.new(0, 14),
									},
									makeEquipButton(innerScope, equipConfig.label or "Equip", function()
										if equipConfig.onActivate then
											equipConfig.onActivate()
										end
									end, entry.paused),
								},
							}
						end),

						scope:New "Frame" {
							Name = "ProgressBar",
							BackgroundColor3 = Theme.Color.NeutralStroke,
							BorderSizePixel = 0,
							LayoutOrder = 4,
							Size = UDim2.new(1, 0, 0, 3),
							Visible = duration > 0,

							[Children] = {makeProgressFill(scope, life.progress, barColor)},
						},
					},
				},
			},
		}
	end

	--------------------------------------------------------------------- CENTRE
	if entry.channel == "centre" then
		local cardTransparency = scope:Spring(scope:Computed(function(use)
			return if use(life.visible) then 0 else 1
		end), 28, 1)
		local cardScale = scope:Spring(scope:Computed(function(use)
			return if use(life.visible) then CENTRE_SCALE else 0.92
		end), 24, 1)
		-- Settled only once fully expanded so the backdrop can't close a card mid-entrance
		scope:Observer(cardScale):onChange(function()
			local currentScale = Fusion.peek(cardScale) :: number
			if currentScale >= CENTRE_SCALE - 0.01 and not Fusion.peek(entry.settled) then
				entry.settled:set(true)
			end
		end)
		local position = scope:Spring(scope:Computed(function(use)
			return UDim2.new(0.5, 0, 0.5, math.round(use(life.offset) :: number))
		end), 28, 1)

		local progressScale: number? = if opts and typeof((opts :: any).progressScale) == "number"
			then math.clamp((opts :: any).progressScale, 0, 1)
			else nil
		local barProgress: UsedAs<number> = if progressScale ~= nil
			then scope:Computed(function(use)
				return (use(life.progress) :: number) * (progressScale :: number)
			end)
			else life.progress

		local explicitImageRatio: number? = if opts and typeof(opts.imageRatio) == "number" and opts.imageRatio > 0 then opts.imageRatio else nil
		local imageContentSize: Fusion.Value<Vector2> = scope:Value(Vector2.zero)
		local imageRatio = scope:Computed(function(use)
			if explicitImageRatio then
				return explicitImageRatio
			end
			local contentSize = use(imageContentSize)
			return if contentSize.X > 0 and contentSize.Y > 0 then contentSize.X / contentSize.Y else 16 / 9
		end)
		local cardWidth = clampWidth(scope, CENTRE_WIDTH, CENTRE_SCALE)
		if imageId ~= nil then
			-- Capped so a centred card never pokes above the Roblox topbar
			cardWidth = scope:Computed(function(use)
				local viewport = use(Viewport.ViewportSize)
				local maxWidth = math.min(CENTRE_IMAGE_WIDTH, (viewport.X - 2 * PADDING_FROM_EDGE) / CENTRE_SCALE)
				local reservedY = GuiService:GetGuiInset().Y + PADDING_FROM_TOP
				local maxImageHeight = (viewport.Y - 2 * reservedY) / CENTRE_SCALE - IMAGE_CARD_CHROME
				local maxWidthFromHeight = maxImageHeight * use(imageRatio) + 36 -- side paddings 18+18
				local contentSize = use(imageContentSize)
				local maxWidthFromNative = if contentSize.X > 0 then contentSize.X + 36 else math.huge
				return math.max(220, math.min(maxWidth, maxWidthFromHeight, maxWidthFromNative))
			end)
		end
		return scope:New "CanvasGroup" {
			Name = "Popup_message",
			Active = true,
			AnchorPoint = Vector2.new(0.5, 0.5),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Theme.Color.Base,
			GroupTransparency = cardTransparency,
			Position = position,
			Size = scope:Computed(function(use)
				return UDim2.fromOffset(use(cardWidth), 0)
			end),
			ZIndex = 2,

			[Out("AbsoluteSize")] = entry.size,

			[Children] = {
				scope:New "UIScale" { Scale = cardScale },
				scope:New "UICorner" { CornerRadius = UDim.new(0, 12) },
				-- Same CanvasGroup stroke bug as the compose box above
				scope:New "UIStroke" {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Color = Theme.Color.NeutralStroke,
					Thickness = 1,
					Transparency = cardTransparency,
				},

				-- Click sink so a card press doesn't fall through and dismiss the message
				scope:New "TextButton" {
					Name = "ClickBlocker",
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
					Selectable = false,
					Size = UDim2.fromScale(1, 1),
					Text = "",
					TextColor3 = Color3.new(),
					TextSize = 1,
					ZIndex = 0,
				},

				scope:New "Frame" {
					Name = "Content",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),

					[Children] = {
						scope:New "UIPadding" {
							PaddingTop = UDim.new(0, 16),
							PaddingBottom = UDim.new(0, 16),
							PaddingLeft = UDim.new(0, 18),
							PaddingRight = UDim.new(0, 18),
						},
						scope:New "UIListLayout" {
							FillDirection = Enum.FillDirection.Vertical,
							HorizontalAlignment = Enum.HorizontalAlignment.Left,
							Padding = UDim.new(0, 10),
							SortOrder = Enum.SortOrder.LayoutOrder,
						},

						scope:New "Frame" {
							Name = "TopBar",
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundTransparency = 1,
							LayoutOrder = 1,
							Size = UDim2.new(1, 0, 0, 0),

							[Children] = {
								scope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Horizontal,
									VerticalAlignment = Enum.VerticalAlignment.Center,
									Padding = UDim.new(0, 8),
									SortOrder = Enum.SortOrder.LayoutOrder,
								},

								scope:Computed(function(use, innerScope)
									if fromServer then return makeServerGlyph(innerScope, 28, 1) end
									if senderId == nil then return nil end
									return makeAvatar(innerScope, senderId, 28, 1)
								end),
								scope:Computed(function(use, innerScope)
									local displayName = if fromServer then "Server" else senderName
									if displayName == nil and titleInTopBar then
										displayName = titleText
									end
									if displayName == nil then return nil end
									local nameText = displayName
									if not fromServer and senderUserName ~= nil and senderUserName ~= displayName then
										nameText = `{displayName} <font weight="400">(@{senderUserName})</font>`
									end
									return innerScope:New "TextLabel" {
										Name = if titleInTopBar then "Title" else "SenderName",
										AutomaticSize = Enum.AutomaticSize.XY,
										BackgroundTransparency = 1,
										FontFace = innerScope:Computed(function(useInner)
											return Font.new(useInner(Theme.Font.Heading), useInner(Theme.FontWeight.Heading))
										end),
										LayoutOrder = 2,
										RichText = true,
										Size = UDim2.fromOffset(0, 0),
										Text = nameText,
										TextColor3 = Theme.Color.BaseContent,
										TextSize = if titleInTopBar then Theme.TextSize.Title else Theme.TextSize.Subtitle,
										TextXAlignment = Enum.TextXAlignment.Left,
									}
								end),
								scope:Computed(function(use, innerScope)
									if senderName == nil or senderTopRole == nil then return nil end
									return RoleBadge(innerScope, {
										name = senderTopRole,
										color = senderTopRoleColor or Theme.Color.Primary,
										layoutOrder = 3,
										large = true,
										pillHeight = 25,
									})
								end),

								makeFlexSpacer(scope, 4),
								makeIconButton(scope, "PauseButton", scope:Computed(function(use)
									return if use(entry.paused) then Icons.PlayLarge else Icons.PauseLarge
								end), life.togglePause, 5, duration > 0 and countdownFrom == nil and not isPollCard),
								scope:Computed(function(use, innerScope)
									if onMute == nil or muteState == nil then return nil end
									return makeMuteButton(innerScope, muteState, onMute, 6, senderTopRoleColor or Theme.Color.Primary)
								end),
								-- Tell the server so it drops its registry entry
								scope:Computed(function(_, innerScope)
									if opts and opts.dismissable == false then return nil end
									return makeIconButton(innerScope, "CloseButton", Icons.Close, function()
										if isAction and onAction then
											onAction("dismiss", "", nil)
										end
										life.requestDismiss()
									end, 7)
								end),
							},
						},

						scope:Computed(function(use, innerScope)
							if titleText == nil or titleInTopBar then return nil end
							return innerScope:New "TextLabel" {
								Name = "Title",
								AutomaticSize = Enum.AutomaticSize.Y,
								BackgroundTransparency = 1,
								FontFace = innerScope:Computed(function(useInner)
									return Font.new(useInner(Theme.Font.Heading), useInner(Theme.FontWeight.Heading))
								end),
								LayoutOrder = 2,
								Size = UDim2.new(1, 0, 0, 0),
								Text = titleText,
								TextColor3 = Theme.Color.BaseContent,
								TextSize = Theme.TextSize.Title,
								TextWrapped = true,
								TextXAlignment = Enum.TextXAlignment.Left,
							}
						end),

						scope:Computed(function(_, innerScope)
							-- An empty body still takes a list padding slot, so image-only cards skip it
							if entry.text == "" and countdownFrom == nil then return nil end
							return innerScope:New "TextLabel" {
								Name = "Body",
								AutomaticSize = Enum.AutomaticSize.Y,
								BackgroundTransparency = 1,
								FontFace = innerScope:Computed(function(use)
									return Font.new(use(Theme.Font.Body), Enum.FontWeight.Medium)
								end),
								LayoutOrder = 3,
								RichText = true,
								Size = UDim2.new(1, 0, 0, 0),
								Text = displayText,
								TextColor3 = Theme.Color.NeutralContentMain,
								TextSize = Theme.TextSize.Subtitle,
								TextWrapped = true,
								TextXAlignment = Enum.TextXAlignment.Left,
							}
						end),

						scope:Computed(function(_, innerScope)
							local voteConfig = if opts then (opts :: any).voteConfig else nil
							if typeof(voteConfig) ~= "table" then return nil end
							return VoteBody(innerScope, {
								mode = voteConfig.mode,
								preview = voteConfig.preview,
								options = voteConfig.options,
								results = voteConfig.results,
								votedIndex = voteConfig.votedIndex,
								endTime = voteConfig.endTime,
								onVote = voteConfig.onVote,
								colorSeed = voteConfig.colorSeed,
								layoutOrder = 5,
							})
						end),

						scope:Computed(function(_, innerScope)
							if imageId == nil then return nil end
							local imageLabel = innerScope:New "ImageLabel" {
								Name = "BodyImage",
								BackgroundTransparency = 1,
								LayoutOrder = 4,
								Size = UDim2.new(1, 0, 0, 4000), -- generous max so the ratio constraint stays width-led
								Image = imageId,
								ScaleType = Enum.ScaleType.Fit,

								[Children] = {
									innerScope:New "UIAspectRatioConstraint" { AspectRatio = imageRatio },
									innerScope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
								},
							} :: ImageLabel
							-- IsLoaded doesn't reliably fire a changed signal, so poll until it loads
							if explicitImageRatio == nil then
								local destroyed = false
								table.insert(innerScope, function() destroyed = true end)
								task.spawn(function()
									local startClock = os.clock()
									while not destroyed and not imageLabel.IsLoaded and os.clock() - startClock < 10 do
										task.wait(0.1)
									end
									if destroyed then return end
									local contentSize = imageLabel.ContentImageSize
									if contentSize.X > 0 and contentSize.Y > 0 then
										imageContentSize:set(contentSize)
									end
								end)
							end
							return imageLabel
						end),

						scope:Computed(function(use, innerScope)
							if not allowReply then return nil end
							local placeholder = if senderName ~= nil
								then `Reply to {senderName}...`
								else "Write a reply..."
							return makeReplyArea(innerScope, placeholder, 4)
						end),
					},
				},

				scope:New "Frame" {
					Name = "ProgressBar",
					AnchorPoint = Vector2.new(0, 1),
					BackgroundColor3 = Theme.Color.NeutralStroke,
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0, 1),
					Size = UDim2.new(1, 0, 0, 3),
					Visible = duration > 0,

					[Children] = {makeProgressFill(scope, barProgress, barColor)},
				},
			},
		}
	end

	------------------------------------------------------------------------ TOP
	local textColor: UsedAs<Color3> = if opts and opts.color then opts.color else Theme.Color.BaseContent
	local cardWidth = clampWidth(scope, TOP_MAX_WIDTH)
	local topPosition = scope:Spring(scope:Computed(function(use)
		local off = use(life.offset) :: number
		local topOffset = if use(life.visible) then PADDING_FROM_TOP + off else -120
		return UDim2.new(0.5, 0, 0, topOffset)
	end), 28, 1)

	return scope:New "Frame" {
		Name = "Popup_hint",
		Active = false,
		AnchorPoint = Vector2.new(0.5, 0),
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundColor3 = Theme.Color.Base,
		BackgroundTransparency = 0.05,
		Position = topPosition,
		Size = UDim2.fromOffset(0, 0),

		[Out("AbsoluteSize")] = entry.size,

		[Children] = {
			scope:New "UICorner" { CornerRadius = UDim.new(0, 9) },
			-- Lighter than the panel so the bar stays outlined without a dim backdrop
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralContent,
				Thickness = 1,
			},
			scope:New "UISizeConstraint" {
				MaxSize = scope:Computed(function(use)
					return Vector2.new(use(cardWidth), math.huge)
				end),
			},
			scope:New "UIPadding" {
				PaddingTop = UDim.new(0, 8),
				PaddingBottom = UDim.new(0, 8),
				PaddingLeft = UDim.new(0, 16),
				PaddingRight = UDim.new(0, 16),
			},

			scope:New "TextLabel" {
				Name = "Text",
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
				end),
				Size = UDim2.fromOffset(0, 0),
				Text = displayText,
				TextColor3 = textColor,
				TextSize = Theme.TextSize.Subtitle,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Center,
			},
		},
	}
end
