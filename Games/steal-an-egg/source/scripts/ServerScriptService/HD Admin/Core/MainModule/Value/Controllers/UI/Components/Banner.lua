--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Icons = require(frontend.Config.Icons)
local Pressable = require(frontend.Components.Pressable)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>


-- TYPES (props)
type Props = {
	name: string?,
	text: UsedAs<string>,
	buttonLabel: UsedAs<string>,
	onButton: () -> (),
	onClose: (() -> ())?, -- given one, the banner grows a close X
	visible: UsedAs<boolean>?,
	size: UsedAs<UDim2>?,
	layoutOrder: UsedAs<number>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local bannerChildren: {any} = {
		scope:New "UIStroke" {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Theme.Color.Primary,
			Thickness = 1,
			Transparency = 0,
		},
		scope:New "UIPadding" {
			PaddingLeft = UDim.new(0, 12),
			PaddingRight = UDim.new(0, 6),
			PaddingTop = UDim.new(0, 4),
			PaddingBottom = UDim.new(0, 4),
		},
		scope:New "UIListLayout" {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalFlex = Enum.UIFlexAlignment.None,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 6),
		},

		scope:New "TextLabel" {
			Name = "Label",
			BackgroundTransparency = 1,
			FontFace = scope:Computed(function(use)
				return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
			end),
			LayoutOrder = 1,
			Size = UDim2.new(0, 0, 1, 0),
			Text = props.text,
			TextColor3 = Theme.Color.Primary,
			TextSize = Theme.TextSize.Label,
			TextTruncate = Enum.TextTruncate.SplitWord,
			TextXAlignment = Enum.TextXAlignment.Left,
			[Children] = {
				scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
			},
		},

		Pressable(scope, {
			name = "ActionButton",
			size = UDim2.fromOffset(64, 26),
			backgroundColor = Theme.Color.Primary,
			layoutOrder = 2,
			onActivate = props.onButton,
			[Children] = {
				scope:New "UICorner" { CornerRadius = UDim.new(0, 4) },
				scope:New "TextLabel" {
					Name = "Label",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
					end),
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromScale(1, 1),
					Text = props.buttonLabel,
					TextColor3 = Theme.Color.PrimaryContent,
					TextSize = Theme.TextSize.Label,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextYAlignment = Enum.TextYAlignment.Center,
				},
			},
		}),
	}

	local onClose = props.onClose
	if onClose then
		table.insert(bannerChildren, Pressable(scope, {
			name = "CloseButton",
			size = UDim2.fromOffset(26, 26),
			layoutOrder = 3,
			iconImage = Icons.Close,
			iconColor = Theme.Color.Primary,
			iconSize = 14,
			onActivate = onClose,
		}))
	end

	return scope:New "Frame" {
		Name = props.name or "Banner",
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundColor3 = Theme.Color.Primary,
		BackgroundTransparency = 0.9,
		LayoutOrder = props.layoutOrder,
		Position = UDim2.new(0.5, 0, 0, 0),
		Size = props.size or UDim2.new(1, 0, 0, 36),
		Visible = props.visible,
		ZIndex = 10,

		[Children] = bannerChildren,
	}
end
