--!strict

-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Icons = require(frontend.Config.Icons)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	text: UsedAs<string>?,
	visible: UsedAs<boolean>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local text = props.text or "You do not have permission to view this page"

	return scope:New "Frame" {
		Name = "NoPermissionPlaceholder",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Visible = props.visible,
		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 10),
			},
			scope:New "ImageLabel" {
				Name = "Icon",
				LayoutOrder = 1,
				BackgroundTransparency = 1,
				Image = Icons.TagLockFill,
				ImageColor3 = Theme.Color.NeutralContentDark,
				ImageTransparency = 0.3,
				Size = UDim2.fromOffset(40, 40),
			},
			scope:New "TextLabel" {
				Name = "Label",
				LayoutOrder = 2,
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
				end),
				Size = UDim2.new(1, -40, 0, 0),
				Text = text,
				TextColor3 = Theme.Color.NeutralContentDark,
				TextSize = Theme.TextSize.Subtitle,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Top,
			},
		},
	}
end
