--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Children = Fusion.Children
local LoadingSpinner = require(frontend.Components.LoadingSpinner)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	isReady: UsedAs<boolean>,
	minLoadTime: number?, -- so a fast load doesn't flash the spinner
	layoutOrder: UsedAs<number>?,
	[typeof(Children)]: any,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local minLoadTime = props.minLoadTime or 0.4

	local minElapsed = scope:Value(false)
	task.delay(minLoadTime, function()
		minElapsed:set(true)
	end)

	local isLoading = scope:Computed(function(use)
		if not use(minElapsed) then return true end
		return not use(props.isReady)
	end)
	local isNotLoading = scope:Computed(function(use) return not use(isLoading) end)

	return scope:New "Frame" {
		Name = "LoadingGate",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = props.layoutOrder or 0,
		Size = UDim2.fromScale(1, 0),

		[Children] = {
			scope:New "UIListLayout" {
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			scope:Computed(function(use, innerScope)
				if not use(isLoading) then return nil end
				return LoadingSpinner(innerScope, { layoutOrder = 0 })
			end),

			-- Built eagerly so it streams in the background, hidden until ready
			scope:New "Frame" {
				Name = "Content",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = 1,
				Size = UDim2.fromScale(1, 0),
				Visible = isNotLoading,
				[Children] = props[Children],
			},
		},
	}
end
