--!strict
-- LOCAL
local packages = script:FindFirstAncestor("MainModule").Value.Packages
local frontend = script:FindFirstAncestor("MainModule").Value.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	title: string?,
	name: string?,
	frameTransparency: number?,
	hideStroke: boolean?,
	strokeFocused: Fusion.UsedAs<boolean>?,
	framePaddingY: number?,
	framePaddingTop: number?,
	framePaddingBottom: number?,
	framePaddingX: number?,
	framePaddingRight: number?,
	autoHeight: boolean?,
	fixedHeight: number?,
	clipsDescendants: boolean?,
	labelPaddingTop: number?,
	labelSize: UDim2?,
	labelTextSize: number?,
	labelIcon: string?,
	[typeof(Children)]: any,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local title: string = props.title or ""
	local labelPaddingTop = props.labelPaddingTop

	local rowHeight = props.fixedHeight or 36
	return scope:New "Frame" {
		Name = props.name or "InputRow",
		AutomaticSize = if props.autoHeight then Enum.AutomaticSize.Y else Enum.AutomaticSize.None,
		BackgroundTransparency = 1,
		Size = if props.autoHeight then UDim2.fromScale(1, 0) else UDim2.new(1, 0, 0, rowHeight),

		[Children] = {
			scope:New "UIListLayout" {
				Name = "UIListLayout",
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 6),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = if labelPaddingTop
					then Enum.VerticalAlignment.Top
					else Enum.VerticalAlignment.Center,
			},

			if props.labelIcon then scope:New "ImageLabel" {
				Name = "InputLabel",
				BackgroundTransparency = 1,
				Image = props.labelIcon,
				LayoutOrder = 1,
				Size = props.labelSize or UDim2.fromOffset(18, 18),
				ImageColor3 = Theme.Color.NeutralContentMain,
			} elseif title ~= "" then scope:New "TextLabel" {
				Name = "InputLabel",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), Enum.FontWeight.Medium)
				end),
				LayoutOrder = 1,
				RichText = true,
				Size = props.labelSize or UDim2.fromOffset(72, 0),
				Text = title .. ":",
				TextColor3 = Theme.Color.NeutralContentMain,
				TextSize = props.labelTextSize or Theme.TextSize.Subtitle,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				[Children] = {
					if labelPaddingTop then scope:New "UIPadding" {
						Name = "UIPadding",
						PaddingTop = UDim.new(0, labelPaddingTop),
					} else nil,
				},
			} else nil,

			-- InputFrame
			scope:New "Frame" {
				Name = "InputFrame",
				AutomaticSize = if props.autoHeight then Enum.AutomaticSize.Y else Enum.AutomaticSize.None,
				BackgroundColor3 = Theme.Color.Neutral,
				BackgroundTransparency = props.frameTransparency or 0,
				ClipsDescendants = props.clipsDescendants or false,
				LayoutOrder = 2,
				Size = if props.autoHeight then UDim2.fromOffset(0, 0) else UDim2.new(0, 0, 0, rowHeight),

				[Children] = {
					scope:New "UIFlexItem" {
						Name = "UIFlexItem",
						FlexMode = Enum.UIFlexMode.Fill,
					},
					scope:New "UICorner" {
						Name = "UICorner",
						CornerRadius = UDim.new(0, 6),
					},
					scope:New "UIPadding" {
						Name = "UIPadding",
						PaddingBottom = UDim.new(0, props.framePaddingBottom or props.framePaddingY or 9),
						PaddingLeft = UDim.new(0, props.framePaddingX or 8),
						PaddingRight = UDim.new(0, props.framePaddingRight or props.framePaddingX or 8),
						PaddingTop = UDim.new(0, props.framePaddingTop or props.framePaddingY or 9),
					},
					if not props.hideStroke then scope:New "UIStroke" {
						Name = "UIStroke",
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Color = if props.strokeFocused ~= nil
							then scope:Spring(scope:Computed(function(use)
								return if use(props.strokeFocused :: any) then use(Theme.Color.Primary) else use(Theme.Color.NeutralStroke)
							end), 40, 1)
							else Theme.Color.NeutralStroke,
					} else nil,
					props[Children],
				},
			},
		},
	}
end
