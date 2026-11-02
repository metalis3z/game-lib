--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local InputObjects = require(frontend.Config.InputObjects)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>

export type SettingType = InputObjects.InputType

type Props = {
	label: string,
	description: string?,
	settingType: SettingType,
	value: any,
	choices: { { id: string, label: string } }?,
	min: number?,
	max: number?,
	onUserActivate: (() -> ())?
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local factory = (InputObjects.items :: any)[props.settingType] :: ((Fusion.Scope, any) -> any)?

	local inputWidget = if factory then factory(scope, {
		inputType = props.settingType,
		title = props.label,
		value = props.value,
		min = props.min,
		max = props.max,
		optionsArray = if props.choices
			then (function()
				local arr = {}
				for _, choice in props.choices do
					table.insert(arr, choice.label)
				end
				return arr
			end)()
			else nil,
	}) else nil

	return scope:New "Frame" {
		Name = "Setting",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),

		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				Padding = UDim.new(0, 4),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			if props.description and props.description ~= "" then scope:New "TextLabel" {
				Name = "Description",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
				end),
				LayoutOrder = 1,
				RichText = true,
				Size = UDim2.fromScale(1, 0),
				Text = props.description,
				TextColor3 = Theme.Color.NeutralContentDark,
				TextSize = Theme.TextSize.Small,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
			} else nil,

			if inputWidget then scope:New "Frame" {
				Name = "InputWrapper",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = 2,
				Size = UDim2.fromScale(1, 0),
				[Children] = { inputWidget },
			} else nil,
		},
	}
end
