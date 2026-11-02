--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Icons = require(frontend.Config.Icons)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	url: UsedAs<string>?,
	layoutOrder: number?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local url: any = props.url or "https://devforum.roblox.com/"

	local isLightTheme = scope:Computed(function(use)
		local base = use(Theme.Color.Base)
		return 0.299 * base.R + 0.587 * base.G + 0.114 * base.B > 0.5
	end)

	return scope:New "Frame" {
		Name = "UpdatesLink",
		AutomaticSize = Enum.AutomaticSize.Y,
		-- Fixed black on every theme so the url reads like a field on the artwork
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = scope:Computed(function(use)
			return if use(isLightTheme) then 0.4 else 0.75
		end),
		LayoutOrder = props.layoutOrder,
		Size = UDim2.fromScale(1, 0),

		[Children] = {
			scope:New "UICorner" {
				CornerRadius = UDim.new(1, 0),
			},
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Color3.fromRGB(161, 161, 170),
			},
			scope:New "UIPadding" {
				PaddingLeft = UDim.new(0, 8),
				PaddingRight = UDim.new(0, 8),
			},
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			},
			scope:New "ImageLabel" {
				Name = "Icon",
				BackgroundTransparency = 1,
				Image = Icons.GlobeFill,
				ImageColor3 = Color3.fromRGB(161, 161, 170),
				LayoutOrder = 1,
				Size = UDim2.fromOffset(22, 22),
			},
			scope:New "TextBox" {
				Name = "TextInput",
				AutoLocalize = false,
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				ClearTextOnFocus = false,
				ClipsDescendants = true,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
				end),
				LayoutOrder = 2,
				Size = UDim2.new(0, 0, 0, 0),
				Text = url,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextEditable = false,
				TextSize = Theme.TextSize.Subtitle,
				TextTransparency = scope:Computed(function(use)
					return if use(isLightTheme) then 0 else 0.25
				end),
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextXAlignment = Enum.TextXAlignment.Left,

				[Children] = {
					scope:New "UIPadding" {
						PaddingBottom = UDim.new(0, 8),
						PaddingLeft = UDim.new(0, 8),
						PaddingRight = UDim.new(0, 8),
						PaddingTop = UDim.new(0, 8),
					},
					scope:New "UIFlexItem" {
						FlexMode = Enum.UIFlexMode.Fill,
					},
				},
			},
		},
	}
end
