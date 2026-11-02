--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Pressable = require(frontend.Components.Pressable)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	name: string?,
	label: UsedAs<string>,
	isOn: UsedAs<boolean>,
	onToggle: () -> (),
	fills: boolean?, -- flex-fills a shared horizontal layout
	visible: UsedAs<boolean>?,
	layoutOrder: UsedAs<number>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local isOn = props.isOn
	local toggleHovered: Fusion.Value<boolean> = scope:Value(false)
	local togglePressed: Fusion.Value<boolean> = scope:Value(false)
	local trackColor = scope:Computed(function(use)
		local base = if use(isOn) then use(Theme.Color.Primary) else use(Theme.Color.NeutralContent)
		local lum = 0.299 * base.R + 0.587 * base.G + 0.114 * base.B
		local tint = if lum > 0.5 then Color3.new(0, 0, 0) else Color3.new(1, 1, 1)
		if use(togglePressed) then return base:Lerp(tint, 0.20)
		elseif use(toggleHovered) then return base:Lerp(tint, 0.10) end
		return base
	end)

	return scope:New "Frame" {
		Name = props.name or "InlineToggleRow",
		BackgroundColor3 = Theme.Color.Neutral,
		LayoutOrder = props.layoutOrder,
		Size = if props.fills then UDim2.new(0, 0, 0, 38) else UDim2.new(1, 0, 0, 38),
		Visible = props.visible,
		[Children] = {
			if props.fills then scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill } else nil,
			scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralStroke,
			},
			scope:New "UIPadding" {
				PaddingLeft = UDim.new(0, 12),
				PaddingRight = UDim.new(0, 8),
			},
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
				SortOrder = Enum.SortOrder.LayoutOrder,
			},
			scope:New "TextLabel" {
				Name = "Label",
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
				end),
				LayoutOrder = 1,
				Text = props.label,
				TextColor3 = Theme.Color.NeutralContentDark,
				TextSize = Theme.TextSize.Subtitle,
			},
			Pressable(scope, {
				name = "InlineToggle",
				size = UDim2.fromOffset(48, 26),
				layoutOrder = 2,
				onActivate = props.onToggle,
				onHoverChanged = function(hovered) toggleHovered:set(hovered) end,
				onPressChanged = function(pressed) togglePressed:set(pressed) end,
				[Children] = {
					scope:New "Frame" {
						Name = "Track",
						BackgroundColor3 = trackColor,
						Size = UDim2.fromScale(1, 1),
						[Children] = {
							scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
							scope:New "Frame" {
								Name = "Thumb",
								AnchorPoint = Vector2.new(0, 0.5),
								BackgroundColor3 = Color3.new(1, 1, 1),
								Position = scope:Spring(scope:Computed(function(use)
									return if use(isOn)
										then UDim2.new(1, -22, 0.5, 0)
										else UDim2.new(0, 4, 0.5, 0)
								end), 40, 1),
								Size = UDim2.fromOffset(16, 16),
								ZIndex = 2,
								[Children] = {
									scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
								},
							},
						},
					},
				},
			}),
		},
	}
end
