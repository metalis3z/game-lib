--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Permissions = require(frontend.Util.Permissions)
local Children = Fusion.Children
local InputRow = require(script.Parent.InputRow)
local Pressable = require(script.Parent.Pressable)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	title: string?,
	default: any?,
	optionsArray: {string}?, -- the picked/stored values (single words, no spaces)
	optionsDisplayArray: {string}?, -- display labels by index; missing entries fall back to the token
	optionCommands: {[string]: string}?, -- option -> command key; unusable = disabled (server re-checks)
	value: Fusion.Value<any>?,
	labelSize: UDim2?,
	labelTextSize: number?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local optionsArray: {string} = props.optionsArray or {"Yes", "No"}
	local optionsDisplayArray: {string}? = props.optionsDisplayArray
	local optionCommands = props.optionCommands

	local function labelFor(option: string): string
		if optionsDisplayArray then
			local idx = table.find(optionsArray, option)
			if idx then
				local override = (optionsDisplayArray :: any)[idx]
				if typeof(override) == "string" and override ~= "" then return override end
			end
		end
		return option
	end
	local initialValue: string = tostring(
		Fusion.peek(props.value) or props.default or optionsArray[1] or ""
	)
	local selected: Fusion.Value<string> = scope:Value(initialValue)

	-- Seed the bound value on mount, otherwise the widget shows the first option
	-- picked while reveals elsewhere still read nil
	if props.value ~= nil and Fusion.peek(props.value) == nil then
		props.value:set(initialValue)
	end

	-- One Computed per option keeps the reactive graph small
	local optionEnabled: {[string]: Fusion.Computed<boolean>}? = nil
	if optionCommands then
		optionEnabled = {}
		for option, commandKey in optionCommands do
			(optionEnabled :: any)[option] = Permissions.canUseCommand(scope, string.lower(commandKey))
		end
	end

	scope:Observer(selected):onChange(function()
		if props.value then
			props.value:set(Fusion.peek(selected))
		end
	end)

	if props.value ~= nil then
		scope:Observer(props.value :: any):onChange(function()
			local ext = Fusion.peek(props.value :: any)
			if ext == nil then return end
			local extStr = tostring(ext)
			if extStr == Fusion.peek(selected) then return end
			selected:set(extStr)
		end)
	end

	local optionsValue = scope:Value(optionsArray)

	return InputRow(scope, {
		title = props.title or "",
		name = "Options",
		labelSize = props.labelSize,
		labelTextSize = props.labelTextSize,
		framePaddingY = 1,
		framePaddingX = 0,
		frameTransparency = 1,
		hideStroke = true,

		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 6),
			},

			scope:ForValues(optionsValue, function(use, innerScope, option: string)
				local isSelected = innerScope:Computed(function(use2)
					return use2(selected) == option
				end)
				local enabledComputed: Fusion.Computed<boolean>? = if optionEnabled
					then (optionEnabled :: any)[option]
					else nil
				local isEnabled = innerScope:Computed(function(use2)
					if not enabledComputed then return true end
					return use2(enabledComputed) == true
				end)
				local bgColor = innerScope:Spring(
					innerScope:Computed(function(use2)
						if not use2(isEnabled) then
							return use2(Theme.Color.NeutralContent)
						end
						return if use2(isSelected) then use2(Theme.Color.Primary) else use2(Theme.Color.NeutralContent)
					end),
					60, 1
				)
				return Pressable(innerScope, {
					name = option,
					backgroundColor = bgColor,
					size = UDim2.new(0, 0, 0, 28),
					layoutOrder = table.find(optionsArray, option),
					automaticSize = Enum.AutomaticSize.None,
					interactable = isEnabled,
					onActivate = function()
						if enabledComputed and Fusion.peek(enabledComputed) ~= true then
							-- Silently no-op, the server would reject anyway
							return
						end
						selected:set(option)
					end,
					[Children] = {
						innerScope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
						innerScope:New "UICorner" { CornerRadius = UDim.new(0, 8) },
						innerScope:New "UIPadding" {
							PaddingLeft = UDim.new(0, 14),
							PaddingRight = UDim.new(0, 14),
						},
						innerScope:New "TextLabel" {
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(1, 1),
							FontFace = innerScope:Computed(function(use2)
								return Font.new(use2(Theme.Font.Body), use2(Theme.FontWeight.Body))
							end),
							Text = labelFor(option),
							TextColor3 = innerScope:Computed(function(use2)
								if not use2(isEnabled) then
									return use2(Theme.Color.NeutralContentDark)
								end
								return if use2(isSelected)
									then use2(Theme.Color.PrimaryContent)
									else use2(Theme.Color.BaseContent)
							end),
							TextSize = Theme.TextSize.Body,
							TextTransparency = innerScope:Computed(function(use2)
								return if use2(isEnabled) then 0 else 0.3
							end),
						},
					},
				})
			end),
		},
	})
end
