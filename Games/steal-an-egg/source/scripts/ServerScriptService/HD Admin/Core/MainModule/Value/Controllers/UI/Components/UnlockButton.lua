--!strict
-- LOCAL 
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local frontend = modules.Parent.Controllers.UI
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Pressable = require(frontend.Components.Pressable)
local ClipHighlight = require(frontend.Components.ClipHighlight)
local Icons = require(frontend.Config.Icons)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	onUnlock: (() -> ())?,
	size: UsedAs<UDim2>?,
	layoutOrder: UsedAs<number>?,
	visible: UsedAs<boolean>?,
	flexNone: boolean?,
	flatTop: boolean?,
	robuxPrice: UsedAs<number>?, -- when set, shows the Robux icon and price instead of the Unlock glyph
	style: ("Primary" | "Neutral")?, -- Neutral swaps the Primary fill for the grey button look
}


-- LOCAL FUNCTIONS
local function makeContent(scope: Scope, robuxPrice: UsedAs<number>?, contentColor: UsedAs<Color3>): { any }
	local showPrice = robuxPrice ~= nil
	return {
		scope:New "UIListLayout" {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			Padding = UDim.new(0, 6),
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
		},
		scope:New "ImageLabel" {
			Name = "Icon",
			BackgroundTransparency = 1,
			Image = if showPrice then Icons.RobuxFill else Icons.Unlock,
			ImageColor3 = contentColor,
			LayoutOrder = 1,
			Size = UDim2.fromOffset(16, 16),
		},
		scope:New "TextLabel" {
			Name = "Label",
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			FontFace = scope:Computed(function(use)
				return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
			end),
			LayoutOrder = 2,
			Text = if showPrice
				then scope:Computed(function(use)
					return tostring(use(robuxPrice :: any))
				end)
				else "Unlock",
			TextColor3 = contentColor,
			TextSize = Theme.TextSize.Body,
		},
	}
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local buttonSize = props.size or UDim2.new(1, 0, 0, 28)
	local isNeutral = props.style == "Neutral"
	local fillToken = if isNeutral then Theme.Color.NeutralContent else Theme.Color.Primary
	local contentToken = if isNeutral then Theme.Color.BaseContent else Theme.Color.PrimaryContent
	local children: { any } = {}
	if props.flexNone then
		table.insert(children, scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.None })
	end

	if props.flatTop then
		local hovered = scope:Value(false)
		local pressed = scope:Value(false)
		local fillColor = scope:Computed(function(use)
			return Pressable.applyHighlight(use, use(fillToken) :: Color3, pressed, hovered)
		end)
		table.insert(children, ClipHighlight(scope, { side = "bottom", color = fillColor, cornerRadius = 9 }))
		table.insert(children, scope:New "Frame" {
			Name = "Content",
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			[Children] = makeContent(scope, props.robuxPrice, contentToken),
		})
		return Pressable(scope, {
			name = "UnlockButton",
			size = buttonSize,
			automaticSize = Enum.AutomaticSize.None,
			layoutOrder = props.layoutOrder,
			visible = props.visible,
			onActivate = function()
				if props.onUnlock then props.onUnlock() end
			end,
			onHoverChanged = function(isHovered) hovered:set(isHovered) end,
			onPressChanged = function(isPressed) pressed:set(isPressed) end,
			[Children] = children,
		})
	end

	table.insert(children, scope:New "UICorner" { CornerRadius = UDim.new(0, 6) })
	for _, child in makeContent(scope, props.robuxPrice, contentToken) do
		table.insert(children, child)
	end
	return Pressable(scope, {
		name = "UnlockButton",
		backgroundColor = fillToken,
		size = buttonSize,
		automaticSize = Enum.AutomaticSize.None,
		layoutOrder = props.layoutOrder,
		visible = props.visible,
		onActivate = function()
			if props.onUnlock then props.onUnlock() end
		end,
		[Children] = children,
	})
end
