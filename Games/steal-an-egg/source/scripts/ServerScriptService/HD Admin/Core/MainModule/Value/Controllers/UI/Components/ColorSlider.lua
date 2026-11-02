--!strict
-- LOCAL
local packages = script:FindFirstAncestor("MainModule").Value.Packages
local frontend = script:FindFirstAncestor("MainModule").Value.Controllers.UI
local Fusion = require(packages.Fusion)
local Children = Fusion.Children
local NumberSlider = require(frontend.Components.NumberSlider)
local Icons = require(frontend.Config.Icons)


-- TYPES 
type Scope = Fusion.Scope
type Props = {
	color: Fusion.Value<Color3>?,
}

-- HELPERS
-- Hue 0 and 360 are the same red, and the slider bottoms out at 1, so a zero
-- hue always shows as 360
local function hueToDegrees(hue: number): number
	local degrees = math.round(hue * 360)
	return if degrees == 0 then 360 else degrees
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local colorValue: Fusion.Value<Color3> = props.color or scope:Value(Color3.new(1, 1, 1))

	local h0, s0, v0 = Color3.toHSV(Fusion.peek(colorValue))
	local hNum: Fusion.Value<number> = scope:Value(hueToDegrees(h0))
	local sNum: Fusion.Value<number> = scope:Value(math.round(s0 * 100))
	local vNum: Fusion.Value<number> = scope:Value(math.round(v0 * 100))

	local isSyncing = false
	table.insert(scope, function() isSyncing = false end)

	local function rebuildColor()
		if isSyncing then return end
		colorValue:set(Color3.fromHSV(
			Fusion.peek(hNum) / 360,
			Fusion.peek(sNum) / 100,
			Fusion.peek(vNum) / 100
		))
	end

	-- Defer to avoid Fusion re-entrancy
	scope:Observer(hNum):onChange(function() task.defer(rebuildColor) end)
	scope:Observer(sNum):onChange(function() task.defer(rebuildColor) end)
	scope:Observer(vNum):onChange(function() task.defer(rebuildColor) end)

	scope:Observer(colorValue):onChange(function()
		local color = Fusion.peek(colorValue)
		if typeof(color) ~= "Color3" then return end
		local hue, saturation, value = Color3.toHSV(color)
		local newH = hueToDegrees(hue)
		local newS = math.round(saturation * 100)
		local newV = math.round(value * 100)
		if newH == Fusion.peek(hNum) and newS == Fusion.peek(sNum) and newV == Fusion.peek(vNum) then
			return
		end
		isSyncing = true
		hNum:set(newH)
		sNum:set(newS)
		vNum:set(newV)
		task.defer(function()
			isSyncing = false
		end)
	end)

	return scope:New "Frame" {
		Name = "ColorSlider",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				Padding = UDim.new(0, 6),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},
			NumberSlider(scope, {
				labelIcon = Icons.Color, labelSize = UDim2.new(0, 25, 0, 25),
				min = 1, max = 360, step = 1,
				value = hNum, hideRangeLabels = true, sliderHeight = 25,
				showValueInput = true, fillColor = colorValue,
				framePaddingTop = 5, framePaddingRight = 2,
				thumbStrokeThickness = 2,
			}),
			NumberSlider(scope, {
				labelIcon = Icons.LightBulbOutline, labelSize = UDim2.new(0, 25, 0, 25),
				min = 0, max = 100, step = 1,
				value = sNum, hideRangeLabels = true, sliderHeight = 25,
				showValueInput = true, fillColor = colorValue,
				framePaddingTop = 5, framePaddingRight = 2,
				thumbStrokeThickness = 2,
			}),
			NumberSlider(scope, {
				labelIcon = Icons.BrightnessHigh, labelSize = UDim2.new(0, 25, 0, 25),
				min = 0, max = 100, step = 1,
				value = vNum, hideRangeLabels = true, sliderHeight = 25,
				showValueInput = true, fillColor = colorValue,
				framePaddingTop = 5, framePaddingRight = 2,
				thumbStrokeThickness = 2,
			}),
		},
	}
end
