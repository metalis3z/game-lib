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
	text: UsedAs<string>?,
	icon: UsedAs<string>?,
	iconColor: UsedAs<Color3>?,
	backgroundColor: UsedAs<Color3>?,
	backgroundTransparency: UsedAs<number>?,
	strokeColor: UsedAs<Color3>?,
	textColor: UsedAs<Color3>?,
	layoutOrder: number?,
	paddingRight: number?,
	onActivate: (() -> ())?, -- badge becomes a Pressable when set
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local text: any = props.text or "0.0.0"
	local icon: any = props.icon or ""

	local iconVisible = scope:Computed(function(use)
		local img = if typeof(icon) == "table" then use(icon) else icon
		return img ~= nil and img ~= ""
	end)

	local badgeChildren = {
		scope:New "UICorner" {
			CornerRadius = UDim.new(1, 0),
		},
		scope:New "UIPadding" {
			PaddingBottom = UDim.new(0, 8),
			PaddingLeft = UDim.new(0, 8),
			PaddingRight = UDim.new(0, props.paddingRight or 8),
			PaddingTop = UDim.new(0, 8),
		},
		scope:New "UIStroke" {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = if props.strokeColor ~= nil then props.strokeColor else Theme.Color.NeutralContent,
		},
		scope:New "UIListLayout" {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			Padding = UDim.new(0, 9),
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
		},
		scope:New "ImageLabel" {
			Name = "Icon",
			BackgroundTransparency = 1,
			Image = icon,
			ImageColor3 = if props.iconColor ~= nil then props.iconColor else Color3.new(1, 1, 1),
			LayoutOrder = 1,
			Size = UDim2.fromOffset(18, 18),
			Visible = iconVisible,
		},
		scope:New "TextLabel" {
			Name = "Text",
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundTransparency = 1,
			FontFace = scope:Computed(function(use)
				return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
			end),
			LayoutOrder = 2,
			Text = text,
			TextColor3 = if props.textColor ~= nil then props.textColor else Theme.Color.BaseContent,
			TextSize = Theme.TextSize.Subtitle,
			TextWrapped = false,
		},
	}

	if props.onActivate then
		return Pressable(scope, {
			name = "CreditBadge",
			automaticSize = Enum.AutomaticSize.XY,
			backgroundColor = props.backgroundColor or Theme.Color.Neutral,
			layoutOrder = props.layoutOrder,
			onActivate = props.onActivate,
			size = UDim2.new(0, 0, 0, 0),
			[Children] = badgeChildren,
		})
	end

	return scope:New "Frame" {
		Name = "CreditBadge",
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundColor3 = if props.backgroundColor ~= nil then props.backgroundColor else Theme.Color.Neutral,
		BackgroundTransparency = if props.backgroundTransparency ~= nil then props.backgroundTransparency else 0,
		LayoutOrder = props.layoutOrder,
		[Children] = badgeChildren,
	}
end
