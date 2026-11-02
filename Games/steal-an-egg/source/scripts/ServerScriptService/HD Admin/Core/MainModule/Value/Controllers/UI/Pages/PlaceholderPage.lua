--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Icons = require(frontend.Config.Icons)
local Viewport = require(frontend.Config.Viewport)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	pageName: UsedAs<string>?,
	centered: boolean?, -- set inside AutomaticSize.Y-collapsing ancestors (tab in TabbedScroller) so centring gets real height
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local pageName = props.pageName or "This page"
	-- 52 covers the TabBar (about 38) plus TabbedScroller headerPad (14), otherwise
	-- the placeholder over-claims the scroller's slot and forces a scrollbar
	local size = if props.centered
		then scope:Computed(function(use): UDim2
			return UDim2.new(1, 0, 0, math.max(0, use(Viewport.MaxContentHeight) - 52))
		end)
		else (UDim2.fromScale(1, 1) :: any)

	return scope:New "Frame" {
		Name = "PlaceholderPage",
		BackgroundTransparency = 1,
		Size = size,

		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, 18),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			scope:New "ImageLabel" {
				BackgroundTransparency = 1,
				Image = Icons.LogoGlyph,
				ImageColor3 = Theme.Color.NeutralContentDark,
				LayoutOrder = 1,
				Size = UDim2.fromOffset(48, 48),
				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(0, 3) },
				},
			},

			scope:New "TextLabel" {
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
			FontFace = scope:Computed(function(use)
				return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
			end),
			LayoutOrder = 2,
			Size = UDim2.new(1, 0, 0, 0),
			Text = scope:Computed(function(use)
				local name = if typeof(pageName) == "table" then use(pageName) else pageName
				return name .. " is under development.\nPlease check back later!"
			end),
			TextColor3 = Theme.Color.NeutralContentDark,
			TextSize = Theme.TextSize.Body,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Center,
			},
		},
	}
end
