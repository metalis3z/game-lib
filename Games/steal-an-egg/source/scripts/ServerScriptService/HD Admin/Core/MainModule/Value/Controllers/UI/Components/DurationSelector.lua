--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Navigate = require(frontend.Util.Navigate)
local Children = Fusion.Children
local InputRow = require(script.Parent.InputRow)
local Pressable = require(script.Parent.Pressable)
local convertSecondsToTimeString = require(modules.DataUtil.convertSecondsToTimeString)


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


-- LOCAL FUNCTIONS
type Unit = { label: string, seconds: number }
local UNITS: {Unit} = {
	{ label = "Secs",  seconds = 1 },
	{ label = "Mins",  seconds = 60 },
	{ label = "Hours", seconds = 3600 },
	{ label = "Days",  seconds = 86400 },
}

local function secondsToUnits(totalSecs: number): {number}
	local remaining = math.max(0, math.floor(totalSecs))
	local result: {number} = {}
	for index = #UNITS, 1, -1 do
		local secs = UNITS[index].seconds
		result[index] = math.floor(remaining / secs)
		remaining = remaining % secs
	end
	return result
end

local function unitsToSeconds(amounts: {number}): number
	local total = 0
	for index, unit in UNITS do
		total += (amounts[index] or 0) * unit.seconds
	end
	return total
end

-- 34px TextBox + 4px gap + 14px label + 16px padding
local EXPANDED_HEIGHT = 68


-- COMPONENT
return function(scope: Scope, props: Props)
	local title: string = props.title or ""

	local initialSeconds: number = tonumber(
		if props.value then Fusion.peek(props.value) else props.default
	) or 0
	local initialAmounts = secondsToUnits(initialSeconds)

	local unitValues: {Fusion.Value<number>} = {}
	local textDisplayValues: {Fusion.Value<string>} = {}
	for index = 1, #UNITS do
		unitValues[index] = scope:Value(initialAmounts[index] or 0)
		textDisplayValues[index] = scope:Value(tostring(initialAmounts[index] or 0))
	end

	local totalSeconds: Fusion.Value<number> = scope:Value(initialSeconds)
	local isExpanded: Fusion.Value<boolean> = scope:Value(false)
	local function toggleExpanded()
		isExpanded:set(not Fusion.peek(isExpanded))
	end
	local timeString: Fusion.Value<string> = scope:Value(
		if initialSeconds > 0 then convertSecondsToTimeString(initialSeconds) else "None"
	)

	local isRebuilding = false
	table.insert(scope, function() isRebuilding = false end)
	local function rebuildTotal()
		if isRebuilding then return end
		isRebuilding = true
		local amounts: {number} = {}
		for index, unitValue in unitValues do
			amounts[index] = math.max(0, math.floor(Fusion.peek(unitValue) or 0))
		end
		local total = unitsToSeconds(amounts)
		local redistributed = secondsToUnits(total)
		for index, unitValue in unitValues do
			local amount = redistributed[index] or 0
			unitValue:set(amount)
			textDisplayValues[index]:set(tostring(amount))
		end
		totalSeconds:set(total)
		timeString:set(if total > 0 then convertSecondsToTimeString(total) else "None")
		if props.value then props.value:set(total) end
		isRebuilding = false
	end

	if props.value ~= nil then
		scope:Observer(props.value :: any):onChange(function()
			if isRebuilding then return end
			local ext = tonumber(Fusion.peek(props.value :: any)) or 0
			if ext == Fusion.peek(totalSeconds) then return end
			local amounts = secondsToUnits(ext)
			isRebuilding = true
			for index, unitValue in unitValues do
				local amount = amounts[index] or 0
				unitValue:set(amount)
				textDisplayValues[index]:set(tostring(amount))
			end
			totalSeconds:set(ext)
			timeString:set(if ext > 0 then convertSecondsToTimeString(ext) else "None")
			isRebuilding = false
		end)
	end

	local expandedSize = scope:Spring(
		scope:Computed(function(use)
			return if use(isExpanded) then 1 else 0
		end),
		50, 1
	)

	local function makeUnitColumn(unitIndex: number)
		local unit = UNITS[unitIndex]
		local unitVal = unitValues[unitIndex]
		local textDisplay = textDisplayValues[unitIndex]
		local textBoxRef: TextBox? = nil

		local function commit(raw: string)
			local amount = math.max(0, math.floor(tonumber(raw) or 0))
			unitVal:set(amount)
			rebuildTotal()
		end

		textBoxRef = scope:New "TextBox" {
			Name = "Input",
			LayoutOrder = 1,
			Size = UDim2.new(1, 0, 0, 34),
			BackgroundColor3 = Theme.Color.NeutralContent,
			ClearTextOnFocus = false,
			FontFace = scope:Computed(function(use)
				return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
			end),
			Text = textDisplay,
			TextColor3 = Theme.Color.BaseContent,
			TextSize = Theme.TextSize.Body,
			TextXAlignment = Enum.TextXAlignment.Center,
			[Fusion.OnEvent "FocusLost"] = function()
				commit(Fusion.peek(textDisplay))
			end,
			[Fusion.OnChange "Text"] = function(new: string)
				local filtered = new:gsub("[^0-9]", "")
				if filtered ~= new then
					local tb = textBoxRef
					if tb then tb.Text = filtered end
				end
				textDisplay:set(filtered)
			end,
			[Children] = {
				scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
				scope:New "UIStroke" {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Color = Theme.Color.NeutralStroke,
				},
			},
		} :: TextBox

		return scope:New "Frame" {
			Name = unit.label,
			LayoutOrder = unitIndex,
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 0, 0, 0),
			[Children] = {
				scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
				scope:New "UIListLayout" {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 4),
				},
				textBoxRef,
				scope:New "TextLabel" {
					Name = "Label",
					LayoutOrder = 2,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 14),
					FontFace = scope:Computed(function(use)
						return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
					end),
					Text = unit.label,
					TextColor3 = Theme.Color.NeutralContentDark,
					TextSize = Theme.TextSize.Small,
					TextXAlignment = Enum.TextXAlignment.Center,
				},
			},
		}
	end

	return scope:New "Frame" {
		Name = "DurationSelector",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 0),

		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 8),
			},

			InputRow(scope, {
				title = title,
				name = "TriggerRow",
				labelSize = props.labelSize,
				labelTextSize = props.labelTextSize,
				autoHeight = true,
				framePaddingY = 8,
				framePaddingX = 8,

				[Children] = {
					Navigate.makeActivatable(scope:New "TextButton" {
						Name = "ExpandButton",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 0),
						Text = "",
						[Fusion.OnEvent "Activated"] = toggleExpanded,

						[Children] = {
							scope:New "TextLabel" {
								Name = "TimeString",
								AutomaticSize = Enum.AutomaticSize.Y,
								BackgroundTransparency = 1,
								ClipsDescendants = true,
								Position = UDim2.new(0, 0, 0, 0),
								Size = UDim2.new(1, -26, 1, 0),
								FontFace = scope:Computed(function(use)
									return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
								end),
								Text = timeString,
								TextColor3 = scope:Computed(function(use)
									return if use(totalSeconds) > 0
										then use(Theme.Color.BaseContent)
										else use(Theme.Color.NeutralContentDark)
								end),
								TextSize = Theme.TextSize.Subtitle,
								TextXAlignment = Enum.TextXAlignment.Left,
								TextYAlignment = Enum.TextYAlignment.Top,

								[Children] = {
									scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
								},
							},

							scope:New "ImageLabel" {
								Name = "ChevronIcon",
								AnchorPoint = Vector2.new(1, 0.5),
								BackgroundTransparency = 1,
								Image = "rbxassetid://78914100674850",
								ImageColor3 = Theme.Color.NeutralContentDark,
								Position = UDim2.new(1, 0, 0.5, 0),
								Size = UDim2.fromOffset(20, 20),
								Rotation = scope:Spring(
									scope:Computed(function(use)
										return if use(isExpanded) then 180 else 0
									end),
									60, 1
								),
							},
						},
					}, toggleExpanded),
				},
			}),

			scope:New "Frame" {
				Name = "ExpandClip",
				LayoutOrder = 2,
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				Size = scope:Computed(function(use)
					local height = math.round(use(expandedSize) * EXPANDED_HEIGHT)
					return UDim2.new(1, 0, 0, height)
				end),

				[Children] = {
					scope:New "Frame" {
						Name = "BoxRow",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 0),

						[Children] = {
							scope:New "UIListLayout" {
								FillDirection = Enum.FillDirection.Horizontal,
								HorizontalFlex = Enum.UIFlexAlignment.Fill,
								VerticalAlignment = Enum.VerticalAlignment.Top,
								SortOrder = Enum.SortOrder.LayoutOrder,
								Padding = UDim.new(0, 8),
							},
							makeUnitColumn(1),
							makeUnitColumn(2),
							makeUnitColumn(3),
							makeUnitColumn(4),
						},
					},
				},
			},
		},
	}
end
