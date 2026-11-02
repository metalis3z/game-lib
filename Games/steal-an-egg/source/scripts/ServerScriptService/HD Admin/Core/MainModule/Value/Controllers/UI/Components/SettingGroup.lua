--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Setting = require(frontend.Components.Setting)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>

export type SettingEntry = {
	key: string,
	label: string,
	description: string?,
	settingType: Setting.SettingType,
	value: any,
	choices: { { id: string, label: string } }?,
	min: number?,
	max: number?,
	onUserActivate: (() -> ())?
}

type Props = {
	heading: UsedAs<string>,
	settings: UsedAs<{SettingEntry}>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local settings = props.settings or scope:Value({} :: {SettingEntry})

	return scope:New "Frame" {
		Name = "SettingGroup",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),

		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				Padding = UDim.new(0, 0),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			scope:New "TextLabel" {
				Name = "Heading",
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Heading), use(Theme.FontWeight.Heading))
				end),
				LayoutOrder = 1,
				Text = props.heading,
				TextColor3 = Theme.Color.BaseContent,
				TextSize = Theme.TextSize.Subtitle,
				TextXAlignment = Enum.TextXAlignment.Left,
			},

			scope:New "Frame" {
				Name = "Divider",
				BackgroundColor3 = Theme.Color.NeutralContent,
				LayoutOrder = 2,
				Size = UDim2.new(1, 0, 0, 1),
			},

			scope:New "Frame" {
				Name = "Rows",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = 3,
				Size = UDim2.new(1, 0, 0, 0),

				[Children] = {
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalAlignment = Enum.HorizontalAlignment.Left,
						Padding = UDim.new(0, 12),
						SortOrder = Enum.SortOrder.LayoutOrder,
					},
					scope:New "UIPadding" {
						PaddingTop = UDim.new(0, 12),
						PaddingBottom = UDim.new(0, 4),
					},

					scope:ForValues(settings, function(_, innerScope, entry: SettingEntry, index: number)
						return innerScope:New "Frame" {
							Name = "SettingEntry_" .. entry.key,
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundTransparency = 1,
							LayoutOrder = index,
							Size = UDim2.new(1, 0, 0, 0),
							[Children] = {
								Setting(innerScope, {
									label = entry.label,
									description = entry.description,
									settingType = entry.settingType,
									value = entry.value,
									choices = entry.choices,
									min = entry.min,
									max = entry.max,
									onUserActivate = entry.onUserActivate,
								}),
							},
						}
					end),
				},
			},
		},
	}
end
