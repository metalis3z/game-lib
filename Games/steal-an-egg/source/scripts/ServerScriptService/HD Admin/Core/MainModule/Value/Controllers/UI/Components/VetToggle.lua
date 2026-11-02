--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local frontend = modules.Parent.Controllers.UI
local Fusion = require(modules.Parent.Packages.Fusion)
local Icons = require(frontend.Config.Icons)
local SearchRowToggle = require(frontend.Components.SearchRowToggle)


-- TYPES
type Scope = Fusion.Scope
type Props = {
	isActive: Fusion.UsedAs<boolean>,
	isVisible: Fusion.UsedAs<boolean>?,
	layoutOrder: Fusion.UsedAs<number>?,
	onActivate: () -> (),
}


-- COMPONENT
return function(scope: Scope, props: Props)
	return SearchRowToggle(scope, {
		name = "VetToggle",
		icon = Icons.VetDeselected,
		activeIcon = Icons.VetSelected,
		isActive = props.isActive,
		isVisible = props.isVisible,
		layoutOrder = props.layoutOrder,
		onActivate = props.onActivate,
	})
end
