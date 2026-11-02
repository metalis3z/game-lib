--!strict
-- CONFIG
local ROW_HEIGHT = 34
local TEXT_FADE = 0.55
local NAME_MAX_WIDTH = 380


-- LOCAL 
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local Pressable = require(frontend.Components.Pressable)
local Icons = require(frontend.Config.Icons)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	display: UsedAs<string>,
	description: UsedAs<string>?,
	image: UsedAs<string>?,
	imageRounded: boolean?,
	swatch: UsedAs<Color3>?,
	rich: boolean?,
	locked: UsedAs<boolean>?,
	showUnlock: UsedAs<boolean>?,
	selected: UsedAs<boolean>,
	layoutOrder: UsedAs<number>?,
	onActivate: () -> (),
	onHover: (() -> ())?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local fadeFor = function(use: Fusion.Use, base: number): number
		return if use(props.locked or false) then math.max(base, TEXT_FADE) else base
	end

	return Pressable(scope, {
		name = "CmdbarRow",
		size = UDim2.new(1, 0, 0, ROW_HEIGHT),
		layoutOrder = props.layoutOrder,
		backgroundColor = scope:Computed(function(use): Color3
			return if use(props.selected) then use(Theme.Color.Neutral) else use(Theme.Color.Base)
		end),
		onActivate = props.onActivate,
		onHoverChanged = function(isHovered: boolean)
			if isHovered and props.onHover then
				props.onHover()
			end
		end,

		[Children] = {
			scope:New "UICorner" {
				CornerRadius = UDim.new(0, 6),
			},
			scope:New "UIPadding" {
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
			},
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				HorizontalFlex = Enum.UIFlexAlignment.None,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 8),
			},

			scope:New "ImageLabel" {
				Name = "Leading",
				LayoutOrder = 1,
				BackgroundColor3 = Theme.Color.Neutral,
				BackgroundTransparency = scope:Computed(function(use): number
					return if props.imageRounded then 0 else 1
				end),
				Image = props.image or "",
				ImageTransparency = scope:Computed(function(use): number
					return fadeFor(use, 0)
				end),
				ImageColor3 = scope:Computed(function(use): Color3
					return if props.imageRounded then Color3.new(1, 1, 1) else use(Theme.Color.NeutralContentMain)
				end),
				ScaleType = Enum.ScaleType.Fit,
				Size = UDim2.fromOffset(20, 20),
				Visible = scope:Computed(function(use): boolean
					local image = use(props.image)
					return typeof(image) == "string" and image ~= ""
				end),
				[Children] = {
					scope:New "UICorner" {
						CornerRadius = if props.imageRounded then UDim.new(1, 0) else UDim.new(0, 4),
					},
				},
			},
			
			scope:New "Frame" {
				Name = "Swatch",
				LayoutOrder = 1,
				BackgroundColor3 = props.swatch or Color3.new(1, 1, 1),
				BackgroundTransparency = scope:Computed(function(use): number
					return fadeFor(use, 0)
				end),
				Size = UDim2.fromOffset(18, 18),
				Visible = props.swatch ~= nil,
				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(0, 4) },
					scope:New "UIStroke" {
						Color = Theme.Color.NeutralStroke,
						Transparency = 0.3,
					},
				},
			},

			scope:New "TextLabel" {
				Name = "Label",
				LayoutOrder = 2,
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
				end),
				RichText = props.rich == true,
				Text = props.display,
				TextColor3 = Theme.Color.BaseContent,
				TextTransparency = scope:Computed(function(use): number
					return fadeFor(use, 0)
				end),
				TextSize = Theme.TextSize.Body,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
				AutomaticSize = Enum.AutomaticSize.X,
				Size = UDim2.fromScale(0, 1),
				[Children] = {
					-- Claim only the width our text needs so a long name can't take the lot
					scope:New "UISizeConstraint" {
						MaxSize = Vector2.new(NAME_MAX_WIDTH, math.huge),
					},
				},
			},

			scope:New "TextLabel" {
				Name = "Description",
				LayoutOrder = 3,
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Regular))
				end),
				Text = props.description or "",
				TextColor3 = Theme.Color.NeutralContentDark,
				TextTransparency = scope:Computed(function(use): number
					return fadeFor(use, 0.15)
				end),
				TextSize = Theme.TextSize.Small,
				TextXAlignment = Enum.TextXAlignment.Right,
				TextTruncate = Enum.TextTruncate.AtEnd,
				Size = UDim2.fromScale(0, 1),
				Visible = scope:Computed(function(use): boolean
					local description = use(props.description)
					return typeof(description) == "string" and description ~= ""
				end),
				[Children] = {
					scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },
				},
			},

			scope:New "ImageLabel" {
				Name = "Unlock",
				LayoutOrder = 4,
				BackgroundTransparency = 1,
				Image = Icons.Unlock,
				ImageColor3 = Theme.Color.Warning,
				Size = UDim2.fromOffset(16, 16),
				Visible = props.showUnlock or false,
			},
		},
	})
end
