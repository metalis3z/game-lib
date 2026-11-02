--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	layoutOrder: number?,
	paddingY: number?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local paddingY = props.paddingY or 9

	return scope:New "Frame" {
		Name = "Divider",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = props.layoutOrder,
		Size = UDim2.fromScale(1, 0),

		[Children] = {
			scope:New "UIPadding" {
				PaddingBottom = UDim.new(0, paddingY),
				PaddingTop = UDim.new(0, paddingY),
			},
			scope:New "Frame" {
				Name = "DividingLine",
				BackgroundColor3 = Theme.Color.BaseContent,
				BackgroundTransparency = 0.9,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 1),
			},
		},
	}
end
