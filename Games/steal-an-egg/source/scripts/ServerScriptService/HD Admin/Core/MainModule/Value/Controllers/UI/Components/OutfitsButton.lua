--!strict
-- LOCAL
local RunService = game:GetService("RunService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Icons = require(frontend.Config.Icons)
local Children = Fusion.Children
local Pressable = require(frontend.Components.Pressable)

local TILT_DEGREES = 8
local TILT_PERIOD = 2


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	size: UsedAs<UDim2>?,
	layoutOrder: UsedAs<number>?,
	onActivate: () -> (),
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

	local icon = scope:New "ImageLabel" {
		Name = "Icon",
		BackgroundTransparency = 1,
		Image = Icons.Outfits,
		ImageColor3 = Theme.Color.NeutralContentMain,
		Size = UDim2.fromOffset(20, 20),
	}

	-- Rock the icon gently side to side so the store draws the eye
	local elapsed = 0
	local connection = RunService.Heartbeat:Connect(function(deltaTime)
		if not icon.Parent then return end
		elapsed += deltaTime
		icon.Rotation = math.sin(elapsed * (math.pi * 2 / TILT_PERIOD)) * TILT_DEGREES
	end)
	table.insert(scope, connection)

	return Pressable(scope, {
		name = "OutfitsButton",
		size = props.size or UDim2.fromOffset(38, 38),
		layoutOrder = props.layoutOrder,
		backgroundColor = backgroundColor,
		onHoverChanged = function(isHovered)
			hovered:set(isHovered)
		end,
		onActivate = props.onActivate,

		[Children] = {
			scope:New "UIAspectRatioConstraint" {
				AspectRatio = 1,
				AspectType = Enum.AspectType.FitWithinMaxSize,
				DominantAxis = Enum.DominantAxis.Height,
			},
			scope:New "UICorner" {
				CornerRadius = UDim.new(0, 6),
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
			icon,
		},
	})
end
