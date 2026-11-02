--!strict
-- LOCAL 
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local frontend = modules.Parent.Controllers.UI
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Pressable = require(frontend.Components.Pressable)
local LoadingSpinner = require(frontend.Components.LoadingSpinner)
local Icons = require(frontend.Config.Icons)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	isFavourited: UsedAs<boolean>,
	onToggle: (() -> ())?,
	loading: UsedAs<boolean>?,
	buttonSize: number?,
	iconSize: number?,
	layoutOrder: UsedAs<number>?,
	visible: UsedAs<boolean>?,
	flexNone: boolean?, 
	anchorPoint: UsedAs<Vector2>?, -- for overlaying like a grid card corner
	position: UsedAs<UDim2>?,
}


-- COMPONENT
-- Styled like the action cards Stop button
return function(scope: Scope, props: Props)
	local buttonPx = props.buttonSize or 30
	local iconPx = props.iconSize or 14
	local loading = props.loading
	local extras = { scope:New "UICorner" { CornerRadius = UDim.new(0, 6) } }
	if props.flexNone then
		table.insert(extras, scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.None })
	end
	if loading ~= nil then
		local spinner = LoadingSpinner(scope, {
			size = iconPx * 0.6, -- a touch smaller than the star glyph
			thickness = 2,
			color = Theme.Color.BaseContent,
			paddingY = 0,
			visible = loading,
		}) :: any
		spinner.AnchorPoint = Vector2.new(0.5, 0.5)
		spinner.Position = UDim2.fromScale(0.5, 0.5)
		table.insert(extras, spinner)
	end
	return Pressable(scope, {
		name = "FavouriteButton",
		backgroundColor = Theme.Color.NeutralStroke,
		size = UDim2.fromOffset(buttonPx, buttonPx),
		automaticSize = Enum.AutomaticSize.None,
		layoutOrder = props.layoutOrder,
		visible = props.visible,
		anchorPoint = props.anchorPoint,
		position = props.position,
		iconColor = Theme.Color.BaseContent,
		iconSize = iconPx,
		iconImage = scope:Computed(function(use)
			return if use(props.isFavourited) then Icons.FavouriteFill else Icons.FavouriteHollow
		end),
		iconTransparency = if loading ~= nil
			then scope:Computed(function(use)
				return if use(loading :: any) then 1 else 0
			end)
			else nil,
		onActivate = function()
			if props.onToggle then
				props.onToggle()
			end
		end,
		[Children] = extras,
	})
end
