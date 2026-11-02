--!strict
-- LOCAL 
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local CmdbarRow = require(frontend.Components.CmdbarRow)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
export type Row = {
	index: number,
	display: string,
	description: string?,
	image: string?,
	imageRounded: boolean?,
	swatch: Color3?,
	rich: boolean?,
	locked: boolean?,
	showUnlock: boolean?,
}
type Props = {
	rows: UsedAs<{ Row }>,
	selectedIndex: UsedAs<number>,
	signature: UsedAs<string>?,
	visible: UsedAs<boolean>?,
	layoutOrder: UsedAs<number>?,
	onActivateIndex: (index: number) -> (),
	onHoverIndex: (index: number) -> (),
}


-- COMPONENT
return function(scope: Scope, props: Props)
	return scope:New "Frame" {
		Name = "CmdbarList",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = Theme.Color.Base,
		LayoutOrder = props.layoutOrder,
		Size = UDim2.new(1, 0, 0, 0),
		Visible = if props.visible ~= nil then props.visible else true,

		[Children] = {
			scope:New "UICorner" {
				CornerRadius = UDim.new(0, 8),
			},
			scope:New "UIStroke" {
				Color = Theme.Color.NeutralStroke,
				Thickness = 1,
				Transparency = 0.3,
			},
			scope:New "UIPadding" {
				PaddingTop = UDim.new(0, 4),
				PaddingBottom = UDim.new(0, 4),
				PaddingLeft = UDim.new(0, 4),
				PaddingRight = UDim.new(0, 4),
			},
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 2),
			},

			scope:New "TextLabel" {
				Name = "Signature",
				LayoutOrder = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
				end),
				Text = props.signature or "",
				TextColor3 = Theme.Color.NeutralContentDark,
				TextSize = Theme.TextSize.Small,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextWrapped = true,
				Size = UDim2.fromScale(1, 0),
				Visible = scope:Computed(function(use): boolean
					local signature = if props.signature then use(props.signature) else nil
					return typeof(signature) == "string" and signature ~= ""
				end),
				[Children] = {
					scope:New "UIPadding" {
						PaddingTop = UDim.new(0, 4),
						PaddingBottom = UDim.new(0, 4),
						PaddingLeft = UDim.new(0, 8),
						PaddingRight = UDim.new(0, 8),
					},
				},
			},

			scope:ForValues(props.rows, function(_, innerScope: Scope, row: Row)
				return CmdbarRow(innerScope, {
					display = row.display,
					description = row.description,
					image = row.image,
					imageRounded = row.imageRounded,
					swatch = row.swatch,
					rich = row.rich,
					locked = row.locked,
					showUnlock = row.showUnlock,
					layoutOrder = row.index + 1,
					selected = innerScope:Computed(function(use): boolean
						return use(props.selectedIndex) == row.index
					end),
					onActivate = function()
						props.onActivateIndex(row.index)
					end,
					onHover = function()
						props.onHoverIndex(row.index)
					end,
				})
			end),
		},
	}
end
