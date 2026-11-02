--!strict
-- CONFIG
local THUMB_SIZE = 14 -- must match Thumb's Size below


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local InputRow = require(script.Parent.InputRow)
local Platform = require(frontend.Util.Platform)
local UserInputService = game:GetService("UserInputService")
local registerSound = require(modules.AssetUtil.registerSound)
local _hoverSound: Sound? = nil
local _clickSound: Sound? = nil
local _activeSliderId: {}? = nil -- only one slider drags at a time
local _lockedScrollingFrame: ScrollingFrame? = nil -- on mobile, disable ancestor scrolling during drag so it doesn't fight the slider
local _lockedPrevScrollingEnabled: boolean? = nil
local _activeOnMove: ((input: InputObject) -> ())? = nil
local _activeOnEnd: ((input: InputObject) -> ())? = nil
local _sharedListenersConnected = false


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	title: string?,
	default: any?,
	min: number?,
	max: number?,
	step: number?,
	logarithmic: boolean?, -- more resolution at the low end
	value: Fusion.Value<any>?,
	hideRangeLabels: boolean?,
	sliderHeight: number?,
	showValueInput: boolean?,
	labelSize: UDim2?,
	labelTextSize: number?,
	labelIcon: string?,
	fillColor: Fusion.UsedAs<Color3>?,
	thumbStrokeThickness: number?,
	framePaddingTop: number?,
	framePaddingRight: number?,
}


-- LOCAL FUNCTIONS
local function ensureSliderSounds()
	if _hoverSound then return end
	local SoundService = game:GetService("SoundService")
	local folder = SoundService:FindFirstChild("PressableSounds")
		 or (function()
			local newFolder = Instance.new("Folder")
			newFolder.Name = "PressableSounds"
			newFolder.Parent = SoundService
			return newFolder
		end)()
	_hoverSound = (folder:FindFirstChild("SharedHover") :: Sound?) or (function()
		local sound = Instance.new("Sound")
		sound.Name = "SharedHover"
		sound.SoundId = "rbxassetid://10066936758"
		sound.Volume = 0.1
		sound.RollOffMaxDistance = 0
		sound.Parent = folder
		return sound
	end)()
	registerSound(_hoverSound :: Sound, "Interface")
	_clickSound = (folder:FindFirstChild("SharedClick") :: Sound?) or (function()
		local sound = Instance.new("Sound")
		sound.Name = "SharedClick"
		sound.SoundId = "rbxassetid://16480549841"
		sound.Volume = 0.2
		sound.RollOffMaxDistance = 0
		sound.Parent = folder
		return sound
	end)()
	registerSound(_clickSound :: Sound, "Interface")
end

local function lockAncestorScrolling(fromInstance: Instance)
	if not Platform.isMobile then return end
	if _lockedScrollingFrame then return end
	local ancestor: Instance? = fromInstance.Parent
	while ancestor do
		if ancestor:IsA("ScrollingFrame") then
			_lockedScrollingFrame = ancestor
			_lockedPrevScrollingEnabled = ancestor.ScrollingEnabled
			ancestor.ScrollingEnabled = false
			return
		end
		ancestor = ancestor.Parent
	end
end

local function unlockAncestorScrolling()
	local frame = _lockedScrollingFrame
	local prev = _lockedPrevScrollingEnabled
	_lockedScrollingFrame = nil
	_lockedPrevScrollingEnabled = nil
	if frame and frame.Parent then
		frame.ScrollingEnabled = if prev == nil then true else prev
	end
end

-- Shared global listener so we don't create N connections per N sliders
local function ensureSharedListeners()
	if _sharedListenersConnected then return end
	_sharedListenersConnected = true
	UserInputService.InputChanged:Connect(function(input: InputObject)
		local callback = _activeOnMove
		if callback and (input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch) then
			callback(input)
		end
	end)
	UserInputService.InputEnded:Connect(function(input: InputObject)
		local callback = _activeOnEnd
		if callback and (input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch) then
			callback(input)
		end
	end)
end

local function snapToStep(value: number, step: number?): number
	if step and step > 0 then
		local roundToNearest = require(modules.MathUtil.roundToNearest)
		return roundToNearest(value, step)
	end
	return value
end

-- The +1 offset lets a min of 0 work in logarithmic mode
local function fractionToValue(fraction: number, min: number, max: number, logarithmic: boolean?): number
	if logarithmic and max > min then
		return min + (max - min + 1) ^ fraction - 1
	end
	return min + fraction * (max - min)
end

local function valueToFraction(value: number, min: number, max: number, logarithmic: boolean?): number
	if max == min then
		return 0
	end
	if logarithmic then
		return math.log(math.max(value - min + 1, 1)) / math.log(max - min + 1)
	end
	return (value - min) / (max - min)
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local title: string = props.title or ""
	local min: number = props.min or 0
	local max: number = props.max or 100
	local step: number? = props.step
	local logarithmic: boolean? = props.logarithmic

	local initialNum: number = tonumber(
		if props.value then Fusion.peek(props.value) else props.default
	) or min
	initialNum = math.clamp(initialNum, min, max)

	local numValue: Fusion.Value<number> = scope:Value(initialNum) :: Fusion.Value<number>

	local fraction: Fusion.Value<number> = scope:Value(
		valueToFraction(initialNum, min, max, logarithmic)
	) :: Fusion.Value<number>

	if props.value ~= nil then
		scope:Observer(props.value :: any):onChange(function()
			local ext = tonumber(Fusion.peek(props.value :: any))
			if ext == nil then return end
			ext = math.clamp(ext, min, max)
			if ext == Fusion.peek(numValue :: any) then return end
			numValue:set(ext)
			fraction:set(valueToFraction(ext, min, max, logarithmic))
		end)
	end

	local function setFromFraction(newFraction: number)
		newFraction = math.clamp(newFraction, 0, 1)
		local raw = fractionToValue(newFraction, min, max, logarithmic)
		local snapped = snapToStep(raw, step)
		snapped = math.clamp(snapped, min, max)
		local prev = Fusion.peek(numValue :: any) :: number
		numValue:set(snapped)
		fraction:set(valueToFraction(snapped, min, max, logarithmic))
		if props.value and snapped ~= prev then props.value:set(snapped) end
	end

	local sliderId = {} -- unique identity for the drag lock

	local isDragging: Fusion.Value<boolean> = scope:Value(false) :: Fusion.Value<boolean>
	local isMoving: Fusion.Value<boolean> = scope:Value(false) :: Fusion.Value<boolean>
	local isHeld: Fusion.Value<boolean> = scope:Value(false) :: Fusion.Value<boolean>
	local holdThread: thread? = nil
	local bar: GuiObject? = nil

	local function getFraction(input: InputObject): number
		if not bar then return 0 end
		local relX = input.Position.X - bar.AbsolutePosition.X
		return math.clamp((relX - THUMB_SIZE / 2) / (bar.AbsoluteSize.X - THUMB_SIZE), 0, 1)
	end

	ensureSliderSounds()

	local function onDragMove(input: InputObject)
		if Fusion.peek(isDragging :: any) then
			isMoving:set(true)
			setFromFraction(getFraction(input))
		end
	end

	local function onDragEnd(_input: InputObject)
		if _activeSliderId ~= sliderId then return end
		if Fusion.peek(isDragging :: any) == true and _clickSound then
			_clickSound.TimePosition = 0
			_clickSound:Play()
		end
		if holdThread then task.cancel(holdThread); holdThread = nil end
		_activeSliderId = nil
		_activeOnMove = nil
		_activeOnEnd = nil
		unlockAncestorScrolling()
		isDragging:set(false)
		isMoving:set(false)
		isHeld:set(false)
	end

	local trackButton = scope:New "TextButton" {
		Name = "Track",
		LayoutOrder = 2,
		AutoButtonColor = false,
		BackgroundColor3 = Theme.Color.NeutralContent,
		Size = UDim2.new(1, 0, 0, 15),
		Text = "",
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		TextColor3 = Color3.new(),
		TextSize = 1,
		[Fusion.OnEvent "MouseEnter"] = function()
			if _hoverSound then
				_hoverSound.TimePosition = 0
				_hoverSound:Play()
			end
		end,
		[Fusion.OnEvent "InputBegan"] = function(input: InputObject)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				if _activeSliderId ~= nil and _activeSliderId ~= sliderId then return end
				_activeSliderId = sliderId
				_activeOnMove = onDragMove
				_activeOnEnd = onDragEnd
				if bar then lockAncestorScrolling(bar) end
				isDragging:set(true)
				setFromFraction(getFraction(input))
				holdThread = task.delay(0.2, function()
					if Fusion.peek(isDragging :: any) then
						isHeld:set(true)
					end
				end)
			end
		end,
		[Children] = {
			scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralContent,
				Transparency = 0.5,
			},
			scope:New "Frame" {
				Name = "Fill",
				BackgroundColor3 = props.fillColor or Theme.Color.Primary,
				Size = scope:Computed(function(use)
					local fractionValue: number = use(fraction) :: number
					-- Width reaches thumb centre: f*(W-T)+T/2
					return UDim2.new(fractionValue, math.round(THUMB_SIZE / 2 * (1 - 2 * fractionValue)), 1, 0)
				end),
				[Children] = { scope:New "UICorner" { CornerRadius = UDim.new(1, 0) } },
			},
			scope:New "Frame" {
				Name = "Thumb",
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Theme.Color.BaseContent,
				Position = scope:Computed(function(use)
					local fractionValue: number = use(fraction) :: number
					-- Keeps thumb fully inside the track
					return UDim2.new(fractionValue, math.round((0.5 - fractionValue) * THUMB_SIZE), 0.5, 0)
				end),
				Size = UDim2.fromOffset(THUMB_SIZE, THUMB_SIZE),
				ZIndex = 2,
				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
					scope:New "UIStroke" {
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Color = Theme.Color.Base,
						Thickness = props.thumbStrokeThickness or 1,
					},
				},
			},
		},
	}
	bar = trackButton

	ensureSharedListeners()

	-- If this slider is mid-drag when its scope is destroyed, release the lock
	table.insert(scope, function()
		if _activeSliderId == sliderId then
			_activeSliderId = nil
			_activeOnMove = nil
			_activeOnEnd = nil
			unlockAncestorScrolling()
		end
	end)

	local sliderContent = {
		scope:New "UIListLayout" {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			SortOrder = Enum.SortOrder.LayoutOrder,
		},

		trackButton,

		scope:New "Frame" {
			Name = "RangeLabels",
			LayoutOrder = 3,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 14),
			[Children] = {
				if not props.hideRangeLabels then scope:New "TextLabel" {
					Name = "Min",
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0, 0.5),
					Size = UDim2.fromOffset(60, 14),
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
					end),
					Text = tostring(min),
					TextColor3 = Theme.Color.NeutralContentDark,
					TextSize = Theme.TextSize.Small,
					TextXAlignment = Enum.TextXAlignment.Left,
				} else nil,
				if not props.hideRangeLabels then scope:New "TextLabel" {
					Name = "Max",
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(1, 0.5),
					Size = UDim2.fromOffset(60, 14),
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
					end),
					Text = tostring(max),
					TextColor3 = Theme.Color.NeutralContentDark,
					TextSize = Theme.TextSize.Small,
					TextXAlignment = Enum.TextXAlignment.Right,
				} else nil,
				scope:New "TextLabel" {
					Name = "Value",
					AnchorPoint = Vector2.new(0.5, 0.5),
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundColor3 = Theme.Color.Base,
					BackgroundTransparency = 0,
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
					end),
					Position = scope:Computed(function(use)
						local fractionValue: number = use(fraction) :: number
						return UDim2.new(fractionValue, math.round((0.5 - fractionValue) * THUMB_SIZE), 0.5, 0)
					end),
					Size = UDim2.fromOffset(0, 14),
					Text = scope:Computed(function(use)
						return tostring(use(numValue) :: number)
					end),
					TextColor3 = Theme.Color.BaseContent,
					TextSize = Theme.TextSize.Label,
					Visible = scope:Computed(function(use)
						return (use(isMoving) :: boolean) or (use(isHeld) :: boolean)
					end),
					ZIndex = 2,
					[Children] = {
						scope:New "UIPadding" {
							PaddingLeft = UDim.new(0, 4),
							PaddingRight = UDim.new(0, 4),
						},
					},
				},
			},
		},
	}

	local inputChildren: any
	if props.showValueInput then
		local textValue: Fusion.Value<string> = scope:Value(tostring(Fusion.peek(numValue :: any))) :: Fusion.Value<string>
		local isFocused: Fusion.Value<boolean> = scope:Value(false) :: Fusion.Value<boolean>
		scope:Observer(numValue):onChange(function()
			if not (Fusion.peek(isFocused :: any) :: boolean) then
				textValue:set(tostring(Fusion.peek(numValue :: any) :: number))
			end
		end)

		local valueTextBox = scope:New "TextBox" {
			Name = "ValueInput",
			BackgroundTransparency = 1,
			ClearTextOnFocus = false,
			FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json"),
			LayoutOrder = 2,
			Size = UDim2.new(0, 50, 1, 3),
			Text = textValue,
			TextColor3 = Theme.Color.BaseContent,
			TextSize = Theme.TextSize.Label,
			TextXAlignment = Enum.TextXAlignment.Center,
			[Fusion.OnEvent "Focused"] = function()
				isFocused:set(true)
			end,
			[Fusion.OnEvent "FocusLost"] = function(_enterPressed: boolean)
				isFocused:set(false)
				local raw = Fusion.peek(textValue :: any) :: string
				local cleaned = tostring(raw):match("^%-?%d+") or ""
				local parsedNumber = tonumber(cleaned)
				if parsedNumber then
					local clamped = math.clamp(math.round(parsedNumber :: number), min, max)
					setFromFraction(valueToFraction(clamped, min, max, logarithmic))
				end
				textValue:set(tostring(Fusion.peek(numValue :: any) :: number))
			end,
			[Fusion.OnChange "Text"] = function(newText: string)
				local filtered: string = newText:match("^%-?%d*") or ""
				textValue:set(filtered)
			end,
			[Children] = {
				scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
				scope:New "UIStroke" {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Color = Theme.Color.NeutralContentDark,
					Transparency = 0.6,
				},
			},
		}

		inputChildren = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 6),
			},
			scope:New "Frame" {
				Name = "SliderArea",
				LayoutOrder = 1,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				[Children] = {
					scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
					table.unpack(sliderContent),
				},
			},
			valueTextBox,
		}
	else
		inputChildren = sliderContent
	end

	return InputRow(scope, {
		title = title,
		name = "NumberInput",
		framePaddingTop = props.framePaddingTop or 11,
		framePaddingX = 0,
		framePaddingRight = props.framePaddingRight,
		framePaddingBottom = 4,
		frameTransparency = 1,
		hideStroke = true,
		fixedHeight = props.sliderHeight,
		labelSize = props.labelSize,
		labelTextSize = props.labelTextSize,
		labelIcon = props.labelIcon,

		[Children] = inputChildren,
	})
end
