--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local Pressable = require(frontend.Components.Pressable)
local Checkbox = require(frontend.Components.Checkbox)
local HintIcon = require(frontend.Components.HintIcon)
local Icons = require(frontend.Config.Icons)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	content: UsedAs<string>?,
	header: UsedAs<string>?, -- bold portion of label
	body: UsedAs<string>?, -- secondary text after header
	icon: UsedAs<string>?,
	category: UsedAs<string>?, -- controls icon/text sizing
	checked: UsedAs<boolean>?,
	onCheck: UsedAs<(checked: boolean) -> ()>?,
	onRemove: (() -> ())?, -- shows remove button when set
	orderNumber: UsedAs<number?>?, -- shows order number instead of checkmark
	hideCheckbox: UsedAs<boolean>?,
	labelFont: Font?,
	strongSelected: UsedAs<boolean>?, -- fills row with Primary when true
	colorIndicator: UsedAs<Color3>?, -- small coloured dot before the label
	hintIcon: UsedAs<string>?, -- hover/tap reveals hintText
	hintText: UsedAs<string>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local isChecked: Fusion.Value<boolean> = scope:Value(
		if props.checked ~= nil then Fusion.peek(props.checked :: any) else false
	)
	if props.checked ~= nil then
		scope:Observer(props.checked :: any):onBind(function()
			isChecked:set(Fusion.peek(props.checked :: any))
		end)
	end
	local onCheck = props.onCheck

	local displayText = scope:Computed(function(use)
		local header = if props.header ~= nil then use(props.header :: any) else nil
		local body = if props.body ~= nil then use(props.body :: any) else nil
		local content = if props.content ~= nil then use(props.content :: any) else ""

		if header then
			if body and body ~= "" then
				local bodyColor: Color3 = use(Theme.Color.NeutralContentDark)
				local hex = string.format("#%02X%02X%02X", math.round(bodyColor.R * 255), math.round(bodyColor.G * 255), math.round(bodyColor.B * 255))
				return string.format("<b>%s</b> <font color=\"%s\">(%s)</font>", header, hex, body)
			else
				return string.format("<b>%s</b>", header)
			end
		else
			return content
		end
	end)

	local rowBackgroundColor = scope:Spring(
		scope:Computed(function(use)
			local isStrong = if props.strongSelected ~= nil then use(props.strongSelected :: any) else false
			return if isStrong then use(Theme.Color.Primary) else use(Theme.Color.Neutral)
		end),
		Theme.Animation.SpringSpeed,
		Theme.Animation.SpringDampening
	)
	local rowTextColor = scope:Spring(
		scope:Computed(function(use)
			local isStrong = if props.strongSelected ~= nil then use(props.strongSelected :: any) else false
			return if isStrong then use(Theme.Color.PrimaryContent) else use(Theme.Color.BaseContent)
		end),
		Theme.Animation.SpringSpeed,
		Theme.Animation.SpringDampening
	)
	local rowStrokeTransparency = scope:Spring(
		scope:Computed(function(use)
			local isStrong = if props.strongSelected ~= nil then use(props.strongSelected :: any) else false
			return if isStrong then 1 else 0.3
		end),
		Theme.Animation.SpringSpeed,
		Theme.Animation.SpringDampening
	)

	return Pressable(scope, {
		name = "CheckItem",
		automaticSize = Enum.AutomaticSize.Y,
		backgroundColor = rowBackgroundColor,
		size = UDim2.fromScale(1, 0),
		-- Wrapped labels can mismeasure past the row edge, so hard clip as the backstop
		clipsDescendants = true,

		onActivate = function()
			local next = not (Fusion.peek(isChecked :: any) :: boolean)
			isChecked:set(next)
			local callback = onCheck
			if callback then
				local handler = if typeof(callback) == "table" then Fusion.peek(callback :: any) :: (boolean) -> () else callback
				if handler then handler(next) end
			end
		end,

		[Children] = {
			scope:New "UICorner" { CornerRadius = UDim.new(0, 9) },
			scope:New "UIPadding" {
				Name = "UIPadding",
				PaddingBottom = UDim.new(0, 12),
				PaddingLeft = UDim.new(0, if props.hideCheckbox then 6 else 12),
				PaddingRight = UDim.new(0, if props.hideCheckbox then 6 else 12),
				PaddingTop = UDim.new(0, 12),
			},
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralStroke,
				Transparency = rowStrokeTransparency,
			},
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 6),
			},

			scope:New "Frame" {
				Name = "Spacer",
				BackgroundTransparency = 1,
				LayoutOrder = 1,
			},

			Checkbox(scope, {
				checked = isChecked,
				orderNumber = props.orderNumber,
				layoutOrder = 0,
				visible = if props.hideCheckbox ~= nil then scope:Computed(function(use)
					return not use(props.hideCheckbox :: any)
				end) else nil,
			}),

			scope:New "Frame" {
				Name = "IconHolder",
				BackgroundTransparency = 1,
				LayoutOrder = 2,
				Size = scope:Computed(function(use)
					local cat = if props.category ~= nil then use(props.category :: any) else nil
					return if cat == "player" or cat == "preset" then UDim2.fromOffset(24, 0) else UDim2.fromOffset(28, 0)
				end),
				Visible = props.icon ~= nil,
				[Children] = {
					scope:New "ImageLabel" {
						Name = "Icon",
						AnchorPoint = Vector2.new(1, 0.5),
						BackgroundColor3 = scope:Computed(function(use)
							local cat = if props.category ~= nil then use(props.category :: any) else nil
							return if cat == "qualifier" then Color3.fromRGB(194, 194, 200) else Color3.fromRGB(61, 61, 63)
						end),
						Image = props.icon :: any,
						LayoutOrder = 2,
						Position = UDim2.fromScale(1, 0.5),
						ScaleType = Enum.ScaleType.Fit,
						Size = scope:Computed(function(use)
							local cat = if props.category ~= nil then use(props.category :: any) else nil
							return if cat == "player" or cat == "preset" then UDim2.fromOffset(24, 24) else UDim2.fromOffset(28, 28)
						end),
						[Children] = {
							scope:New "UICorner" {
								Name = "UICorner",
								CornerRadius = UDim.new(0.5, 0),
							},
							scope:New "UIStroke" {
								Name = "UIStroke",
								Color = Theme.Color.NeutralStroke,
								Transparency = scope:Computed(function(use)
									local cat = if props.category ~= nil then use(props.category :: any) else nil
									return if cat == "qualifier" then 0 else 1
								end),
							},
						},
					},
				},
			},

			-- Matches the dot in RoleBadge
			if props.colorIndicator then scope:New "Frame" {
				Name = "ColorDot",
				BackgroundColor3 = props.colorIndicator,
				LayoutOrder = 3,
				Size = UDim2.fromOffset(10, 10),
				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
				},
			} else nil,

			if props.hintIcon then HintIcon(scope, {
				icon = props.hintIcon :: any,
				hintText = props.hintText or "",
				layoutOrder = 9,
				iconColor = Theme.Color.Warning,
			}) else nil,

			if props.onRemove then Pressable(scope, {
				name = "RemoveButton",
				layoutOrder = 10,
				size = UDim2.fromOffset(28, 18),
				iconImage = Icons.Close,
				iconSize = 14,
				onActivate = props.onRemove,
				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
				},
			}) else nil,

			-- Wrapped labels measure against their unwrapped width under flex and paint
			-- past the row's right edge, so the wrapper takes a fixed share instead
			scope:New "Frame" {
				Name = "ContentArea",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = 4,
				-- The hint icon eats into the fixed share or the row clips it
				Size = if props.hintIcon then UDim2.new(0.9, -26, 0, 0) else UDim2.fromScale(0.9, 0),
				[Children] = {
					scope:New "TextLabel" {
						Name = "Label",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						-- A scale height feeds the wrapper's auto height back in and a
						-- brief wrap would stay stretched forever
						Size = UDim2.new(1, -6, 0, 0),
						FontFace = if props.labelFont then props.labelFont else scope:Computed(function(use)
							return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
						end),
						RichText = true,
						Text = displayText,
						TextColor3 = rowTextColor,
						TextSize = Theme.TextSize.Subtitle,
						TextTruncate = scope:Computed(function(use)
							local cat = if props.category ~= nil then use(props.category :: any) else nil
							local truncate = cat == "player" or cat == "custom" or cat == "in-game"
							return if truncate then Enum.TextTruncate.SplitWord else Enum.TextTruncate.None
						end),
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Top,
					},
				},
			},

			scope:New "Frame" {
				Name = "RightGutter",
				BackgroundTransparency = 1,
				LayoutOrder = 11,
				Size = UDim2.fromOffset(12, 1),
			},
		},
	})
end
