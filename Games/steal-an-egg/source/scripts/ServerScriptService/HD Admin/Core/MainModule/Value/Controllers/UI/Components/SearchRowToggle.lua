--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local Pressable = require(frontend.Components.Pressable)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	name: UsedAs<string>?,
	size: UsedAs<UDim2>?,
	icon: UsedAs<string>?,
	activeIcon: UsedAs<string>?,
	iconSize: UsedAs<UDim2>?,
	text: UsedAs<string>?, -- when set, renders a TextLabel instead of an ImageLabel
	isActive: UsedAs<boolean>?,
	isVisible: UsedAs<boolean>?,
	layoutOrder: UsedAs<number>?,
	cornerRadius: UsedAs<UDim>?, -- defaults to UDim.new(0, 6)
	onActivate: () -> (),
	onHoverChanged: ((isHovered: boolean) -> ())?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local hovered: Fusion.Value<boolean> = scope:Value(false)

	local backgroundColor = scope:Computed(function(use)
		local base = use(Theme.Color.Neutral) :: Color3
		if use(hovered) then
			local luminance = 0.299 * base.R + 0.587 * base.G + 0.114 * base.B
			local tint = if luminance > 0.5 then Color3.new(0, 0, 0) else Color3.new(1, 1, 1)
			return base:Lerp(tint, 0.10)
		end
		return base
	end)

	local iconImage = scope:Computed(function(use)
		local activeIcon = if props.activeIcon ~= nil then use(props.activeIcon :: any) else nil
		local isActive = if props.isActive ~= nil then use(props.isActive :: any) else false
		if isActive and activeIcon then
			return activeIcon
		end
		return use(props.icon :: any)
	end)

	-- Colour stays the same regardless of active state
	local iconColor = Theme.Color.NeutralContentMain

	return Pressable(scope, {
		name = props.name or "SearchRowToggle",
		size = props.size or UDim2.fromOffset(38, 38),
		layoutOrder = props.layoutOrder,
		visible = props.isVisible,
		backgroundColor = backgroundColor,
		onHoverChanged = function(isHovered)
			hovered:set(isHovered)
			if props.onHoverChanged then props.onHoverChanged(isHovered) end
		end,
		onActivate = props.onActivate,

		[Children] = {
			scope:New "UIAspectRatioConstraint" {
				AspectRatio = 1,
				AspectType = Enum.AspectType.FitWithinMaxSize,
				DominantAxis = Enum.DominantAxis.Height,
			},
			scope:New "UICorner" {
				CornerRadius = if props.cornerRadius ~= nil then props.cornerRadius else UDim.new(0, 6),
			},
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralStroke,
			},
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			},
			if props.text ~= nil then scope:New "TextLabel" {
				Name = "Label",
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
				end),
				Text = props.text,
				TextColor3 = iconColor,
				TextSize = 20,
			} else scope:New "ImageLabel" {
				Name = "Icon",
				BackgroundTransparency = 1,
				Image = iconImage,
				ImageColor3 = iconColor,
				Size = props.iconSize or UDim2.fromOffset(20, 20),
			},
		},
	})
end
