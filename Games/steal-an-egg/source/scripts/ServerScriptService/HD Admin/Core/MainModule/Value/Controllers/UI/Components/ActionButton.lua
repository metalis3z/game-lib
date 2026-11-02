--!strict

-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local InputRow = require(script.Parent.InputRow)
local Pressable = require(script.Parent.Pressable)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	title: string?,
	buttonText: UsedAs<string>?,
	buttonIcon: UsedAs<string>?,
	onActivate: (() -> ())?,
	labelSize: UDim2?,
	labelTextSize: number?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local buttonText: any = props.buttonText or ""
	local buttonIcon: any = props.buttonIcon

	local button = Pressable(scope, {
		name = "Button",
		size = UDim2.fromScale(1, 1),
		backgroundColor = Theme.Color.Neutral,
		onActivate = props.onActivate,
		[Children] = {
			scope:New "UICorner" {
				CornerRadius = scope:Computed(function(use)
					return UDim.new(0, use(Theme.Layout.CornerRadius) :: number)
				end),
			},
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralStroke,
			},
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, 6),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},
			if buttonIcon ~= nil then scope:New "ImageLabel" {
				Name = "Icon",
				BackgroundTransparency = 1,
				Image = buttonIcon,
				ImageColor3 = Theme.Color.NeutralContentMain,
				LayoutOrder = 1,
				Size = UDim2.fromOffset(16, 16),
			} else nil,
			scope:New "TextLabel" {
				Name = "Label",
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
				end),
				LayoutOrder = 2,
				Size = UDim2.new(0, 0, 1, 0),
				Text = buttonText,
				TextColor3 = Theme.Color.BaseContent,
				TextSize = Theme.TextSize.Body,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
			},
		},
	})

	return InputRow(scope, {
		title = props.title,
		name = "ActionButton",
		labelSize = props.labelSize,
		labelTextSize = props.labelTextSize,
		framePaddingX = 0,
		framePaddingY = 0,
		[Children] = button,
	})
end
