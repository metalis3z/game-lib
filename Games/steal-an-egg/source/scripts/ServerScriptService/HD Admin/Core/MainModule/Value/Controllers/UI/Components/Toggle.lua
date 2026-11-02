--!strict
-- CONFIG
local TRACK_WIDTH = 48


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local InputRow = require(script.Parent.InputRow)
local Pressable = require(frontend.Components.Pressable)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	title: string?,
	default: any?,
	value: Fusion.Value<any>?,
	labelSize: UDim2?,
	labelTextSize: number?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local title: string = props.title or ""
	local isOn: Fusion.Value<boolean> = scope:Value(
		if props.value then Fusion.peek(props.value) == true
		else props.default == true
	)

	-- A deferred Observer can fire after teardown and a set into props.value then
	-- re-enters the graph mid-teardown, tripping Fusion's infinite-loop detector
	local destroyed = false
	table.insert(scope, function() destroyed = true end)

	scope:Observer(isOn):onChange(function()
		if destroyed or not props.value then return end
		-- Coerce both sides to boolean, props.value is any and a non-boolean would
		-- read as different every pass and ping-pong until Fusion bails
		local newIsOn = Fusion.peek(isOn)
		if (Fusion.peek(props.value) == true) ~= newIsOn then
			props.value:set(newIsOn)
		end
	end)

	if props.value ~= nil then
		scope:Observer(props.value :: any):onChange(function()
			if destroyed then return end
			local ext = Fusion.peek(props.value :: any) == true
			if ext == Fusion.peek(isOn) then return end
			isOn:set(ext)
		end)
	end

	local thumbPos = scope:Spring(
		scope:Computed(function(use)
			return if use(isOn) then UDim2.new(1, -20, 0.5, 0) else UDim2.new(0, 4, 0.5, 0)
		end),
		60, 1
	)

	local trackColor = scope:Spring(
		scope:Computed(function(use)
			return if use(isOn) then use(Theme.Color.Primary) else use(Theme.Color.NeutralContent)
		end),
		60, 1
	)

	return InputRow(scope, {
		title = title,
		name = "Toggle",
		labelSize = props.labelSize or UDim2.new(1, -TRACK_WIDTH - 12, 0, 0),
		labelTextSize = props.labelTextSize,
		frameTransparency = 1,
		hideStroke = true,
		framePaddingRight = 0,

		[Children] = {
			scope:New "Frame" {
				Name = "TrackWrap",
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				[Children] = {
					Pressable(scope, {
						name = "Track",
						anchorPoint = Vector2.new(1, 0.5),
						position = UDim2.new(1, 0, 0.5, 0),
						size = UDim2.fromOffset(TRACK_WIDTH, 26),
						backgroundColor = trackColor,
						onActivate = function()
							isOn:set(not Fusion.peek(isOn))
						end,
						[Children] = {
							scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
							scope:New "Frame" {
								Name = "Thumb",
								AnchorPoint = Vector2.new(0, 0.5),
								BackgroundColor3 = scope:Computed(function(use)
									return if use(isOn)
										then use(Theme.Color.PrimaryContent)
										else use(Theme.Color.BaseContent)
								end),
								Position = thumbPos,
								Size = UDim2.fromOffset(16, 16),
								ZIndex = 2,
								[Children] = {
									scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
								},
							},
						},
					}),
				},
			},
		},
	})
end
