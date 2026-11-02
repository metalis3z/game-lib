--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)
local Children = Fusion.Children
local RunService = game:GetService("RunService")
local frontend = modules.Parent.Controllers.UI
local Theme = require(frontend.Util.Theme)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	size: UsedAs<number>?,
	thickness: UsedAs<number>?,
	color: UsedAs<Color3>?,
	visible: UsedAs<boolean>?,
	layoutOrder: UsedAs<number>?,
	paddingY: number?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local angle = scope:Value(0)

	-- Only tick while visible
	local heartbeatConn: RBXScriptConnection? = nil
	local function startHeartbeat()
		if heartbeatConn then return end
		heartbeatConn = RunService.Heartbeat:Connect(function(dt)
			angle:set(Fusion.peek(angle) + dt * 540)
		end)
	end
	local function stopHeartbeat()
		if heartbeatConn then
			heartbeatConn:Disconnect()
			heartbeatConn = nil
		end
	end

	local visibleProp = props.visible
	if visibleProp == nil or Fusion.peek(visibleProp :: any) ~= false then
		startHeartbeat()
	end

	if visibleProp ~= nil then
		scope:Observer(visibleProp :: any):onChange(function()
			if Fusion.peek(visibleProp :: any) then
				startHeartbeat()
			else
				stopHeartbeat()
			end
		end)
	end

	table.insert(scope, function()
		stopHeartbeat()
	end)

	local diameter = props.size or 28
	local ringColor = props.color or Theme.Color.NeutralContentDark
	local strokeThickness = props.thickness or 3
	local paddingY = props.paddingY or 24

	local spinner = scope:New "Frame" {
		Name = "Spinner",
		BackgroundTransparency = 1,
		Size = scope:Computed(function(use)
			local diameterValue = if type(diameter) == "number" then diameter else use(diameter :: Fusion.UsedAs<number>)
			return UDim2.fromOffset(diameterValue, diameterValue)
		end),

		[Children] = {
			scope:New "UICorner" {
				CornerRadius = UDim.new(0.5, 0),
			},
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = ringColor,
				Thickness = strokeThickness,
				[Children] = {
					scope:New "UIGradient" {
						Rotation = angle,
						Transparency = NumberSequence.new({
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(0.853386, 0.0710383),
							NumberSequenceKeypoint.new(1, 0.551913),
						}),
					},
				},
			},
		},
	}

	return scope:New "Frame" {
		Name = "LoadingSpinner",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = props.layoutOrder or 0,
		Size = UDim2.fromScale(1, 0),
		Visible = props.visible or true,

		[Children] = {
			scope:New "UIPadding" {
				PaddingBottom = UDim.new(0, paddingY),
				PaddingTop = UDim.new(0, paddingY),
			},
			scope:New "UIListLayout" {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
			},
			spinner,
		},
	}
end
