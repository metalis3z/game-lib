--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	side: "left" | "right" | "top" | "bottom",
	color: UsedAs<Color3>,
	cornerRadius: number?,
	hideCorner: boolean?,
	noExtend: UsedAs<boolean>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local radius = props.cornerRadius or 9
	local side = props.side
	local isVertical = side == "top" or side == "bottom"
	-- "near" sides (left / top) keep position at 0 and grow past the far edge,
	-- "far" sides (right / bottom) shift back by extend so they overflow the near edge
	local growsFromNearEdge = side == "left" or side == "top"
	local noExtendProp = props.noExtend

	-- extend is 0 when noExtend (all corners visible), else radius so one side's corners clip
	local extend = scope:Computed(function(use)
		local ne = if noExtendProp ~= nil then use(noExtendProp :: any) else false
		return if ne then 0 else radius
	end)

	local highlightPosition: any = if growsFromNearEdge
		then UDim2.fromScale(0, 0)
		else scope:Computed(function(use)
			local amount = use(extend)
			return if isVertical then UDim2.new(0, 0, 0, -amount) else UDim2.new(0, -amount, 0, 0)
		end)

	local highlightSize = scope:Computed(function(use)
		local amount = use(extend)
		return if isVertical then UDim2.new(1, 0, 1, amount) else UDim2.new(1, amount, 1, 0)
	end)

	return scope:New "Frame" {
		Name = "ClipWrapper",
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Size = UDim2.new(1, 0, 1, 0),

		[Children] = {
			scope:New "Frame" {
				Name = "Highlight",
				BackgroundColor3 = props.color,
				Position = highlightPosition,
				Size = highlightSize,

				[Children] = {
					if not props.hideCorner then scope:New "UICorner" {
						CornerRadius = UDim.new(0, radius),
					} else nil,
				},
			},
		},
	}
end
