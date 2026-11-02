--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Navigate = require(frontend.Util.Navigate)
local Children = Fusion.Children
local ColorSlider = require(script.Parent.ColorSlider)
local InputRow = require(script.Parent.InputRow)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	title: string?,
	default: any?,
	value: Fusion.Value<any>?,
	labelSize: UDim2?,
	labelTextSize: number?,
	slidersHeight: number?,
}


-- LOCAL FUNCTIONS
local function parseColorInput(raw: string): Color3?
	local trimmed = raw:match("^%s*(.-)%s*$")

	local hex = trimmed:match("^#?(%x%x%x%x%x%x)$")
	if hex then
		local red = tonumber(hex:sub(1, 2), 16) :: number
		local green = tonumber(hex:sub(3, 4), 16) :: number
		local blue = tonumber(hex:sub(5, 6), 16) :: number
		return Color3.fromRGB(red, green, blue)
	end

	local rs, gs, bs = trimmed:match("^(%d+)%s*,%s*(%d+)%s*,%s*(%d+)$")
	if rs and gs and bs then
		local red = math.clamp(tonumber(rs) :: number, 0, 255)
		local green = math.clamp(tonumber(gs) :: number, 0, 255)
		local blue = math.clamp(tonumber(bs) :: number, 0, 255)
		return Color3.fromRGB(red, green, blue)
	end

	return nil
end

local function colorToRgbString(color: Color3): string
	return math.round(color.R * 255) .. "," .. math.round(color.G * 255) .. "," .. math.round(color.B * 255)
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local title: string = props.title or ""
	local initialColor: Color3 = if typeof(props.value and Fusion.peek(props.value)) == "Color3"
		then Fusion.peek(props.value) :: Color3
		elseif typeof(props.default) == "Color3" then props.default
		else Fusion.peek(Theme.Color.Primary) :: Color3

	local colorValue: Fusion.Value<Color3> = scope:Value(initialColor)
	local isExpanded: Fusion.Value<boolean> = scope:Value(false)
	local isTextFocused: Fusion.Value<boolean> = scope:Value(false)

	scope:Observer(colorValue):onChange(function()
		if props.value then
			props.value:set(Fusion.peek(colorValue))
		end
	end)

	if props.value ~= nil then
		scope:Observer(props.value :: any):onChange(function()
			local ext = Fusion.peek(props.value :: any)
			if typeof(ext) ~= "Color3" then return end
			local cur = Fusion.peek(colorValue) :: Color3
			if cur.R == ext.R and cur.G == ext.G and cur.B == ext.B then return end
			colorValue:set(ext)
		end)
	end

	local expandedSize = scope:Spring(
		scope:Computed(function(use)
			return if use(isExpanded) then 1 else 0
		end),
		50, 1
	)

	local inputText: Fusion.Value<string> = scope:Value(colorToRgbString(initialColor)) :: Fusion.Value<string>
	scope:Observer(colorValue):onChange(function()
		if not (Fusion.peek(isTextFocused :: any) :: boolean) then
			inputText:set(colorToRgbString(Fusion.peek(colorValue) :: Color3))
		end
	end)

	local function toggleExpanded()
		isExpanded:set(not (Fusion.peek(isExpanded :: any) :: boolean))
	end

	return scope:New "Frame" {
		Name = "ColorPicker",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 0),

		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 2),
			},

			InputRow(scope, {
				title = title,
				name = "SwatchRow",
				labelSize = props.labelSize,
			labelTextSize = props.labelTextSize,
				autoHeight = true,
				framePaddingY = 0,
				framePaddingX = 0,
				strokeFocused = isTextFocused,

				[Children] = {
					Navigate.makeActivatable(scope:New "TextButton" {
						Name = "ToggleButton",
						AutoButtonColor = false,
						BackgroundTransparency = 1,
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
						Size = UDim2.fromScale(1, 1),
						Text = "",
						TextColor3 = Color3.new(),
						TextSize = 1,
						ZIndex = 1,
						[Fusion.OnEvent "Activated"] = toggleExpanded,
					}, toggleExpanded),

					scope:New "TextBox" {
						Name = "TextInput",
						AutoLocalize = false,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						ClearTextOnFocus = false,
						ClipsDescendants = true,
						FontFace = scope:Computed(function(use)
							return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
						end),
						PlaceholderColor3 = Theme.Color.NeutralContentDark,
						PlaceholderText = "R,G,B or #hex",
						Size = UDim2.new(1, -60, 0, 0),
						Text = inputText,
						TextColor3 = Theme.Color.BaseContent,
						TextSize = Theme.TextSize.Subtitle,
						TextTransparency = 0.5,
						TextTruncate = Enum.TextTruncate.SplitWord,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Top,
						ZIndex = 2,
						[Fusion.OnEvent "Focused"] = function()
							isTextFocused:set(true)
						end,
						[Fusion.OnEvent "FocusLost"] = function(_enterPressed: boolean)
							isTextFocused:set(false)
							local raw = Fusion.peek(inputText :: any) :: string
							local parsed = parseColorInput(raw)
							if parsed then
								colorValue:set(parsed)
							end
							inputText:set(colorToRgbString(Fusion.peek(colorValue) :: Color3))
						end,
						[Fusion.OnChange "Text"] = function(newText: string)
							inputText:set(newText)
						end,
						[Children] = {
							scope:New "UICorner" {
								CornerRadius = UDim.new(0, 6),
							},
							scope:New "UIPadding" {
								PaddingBottom = UDim.new(0, 8),
								PaddingLeft = UDim.new(0, 8),
								PaddingRight = UDim.new(0, 8),
								PaddingTop = UDim.new(0, 8),
							},
						},
					},

					Navigate.makeActivatable(scope:New "TextButton" {
						Name = "SwatchButton",
						AnchorPoint = Vector2.new(1, 0.5),
						AutoButtonColor = false,
						BackgroundColor3 = colorValue,
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
						Position = UDim2.new(1, -5, 0.5, 0),
						Size = UDim2.new(0, 28, 1, -12),
						Text = "",
						TextColor3 = Color3.new(),
						TextSize = 1,
						ZIndex = 3,
						[Fusion.OnEvent "Activated"] = toggleExpanded,
						[Children] = {
							scope:New "UICorner" {
								CornerRadius = UDim.new(0, 4),
							},
							scope:New "UIStroke" {
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
								Color = Theme.Color.NeutralStroke,
							},
							scope:New "UIAspectRatioConstraint" {},
						},
					}, toggleExpanded),
				},
			}),

			scope:New "Frame" {
				Name = "SlidersClip",
				LayoutOrder = 2,
				AutomaticSize = Enum.AutomaticSize.None,
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				Size = scope:Computed(function(use)
					local alpha: number = use(expandedSize) :: number
					return UDim2.new(1, 0, 0, math.round(alpha * (props.slidersHeight or 100)))
				end),
				[Children] = {
					scope:New "UIPadding" {
						PaddingTop = UDim.new(0, 8),
					},
					ColorSlider(scope, { color = colorValue }),
				},
			},
		},
	}
end
