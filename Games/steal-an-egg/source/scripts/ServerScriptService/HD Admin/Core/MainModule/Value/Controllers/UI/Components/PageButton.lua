--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Icons = require(frontend.Config.Icons)
local Pages = require(frontend.Config.Pages)
local Children = Fusion.Children
local Pressable = require(script.Parent.Pressable)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	pageId: UsedAs<string>,
	size: UsedAs<UDim2>?,
	onActivate: UsedAs<() -> ()>?,
	dimmed: UsedAs<boolean>?, -- faded "can't use this" look, still clickable
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local pageId = props.pageId
	local onActivate = props.onActivate
	local size = props.size
	local dimmed = props.dimmed

	local page = scope:Computed(function(use)
		local id = use(pageId)
		local entry = (Pages :: any)[id] or { Id = id }
		return {
			name = entry.Name or entry.Id or id,
			icon = entry.Icon or Icons.Pages.Settings,
		}
	end)

	local function dimmedTransparency(baseValue: number): Fusion.Computed<number>
		return scope:Computed(function(use): number
			local isDimmed = if typeof(dimmed) == "table" then use(dimmed :: any) else dimmed
			if isDimmed == true then return baseValue + (1 - baseValue) * 0.55 end
			return baseValue
		end)
	end

	return Pressable(scope, {
		name = "PageButton",
		automaticSize = Enum.AutomaticSize.Y,
		backgroundColor = Theme.Color.Neutral,
		clipsDescendants = true,
		size = size or UDim2.fromScale(1, 1),
		onActivate = onActivate,

		[Children] = {
			scope:New "UICorner" { CornerRadius = UDim.new(0, 9) },
			scope:New "UIPadding" {
				PaddingTop = UDim.new(0, 16),
				PaddingBottom = UDim.new(0, 16),
				PaddingLeft = UDim.new(0, 16),
				PaddingRight = UDim.new(0, 16),
			},
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralContent,
				Transparency = dimmedTransparency(0),
			},
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 13),
			},

			scope:New "ImageLabel" {
				Name = "Icon",
				LayoutOrder = 1,
				BackgroundTransparency = 1,
				Image = scope:Computed(function(use) return use(page).icon end),
			ImageColor3 = Theme.Color.BaseContent,
				ImageTransparency = dimmedTransparency(0),
				Size = UDim2.fromOffset(33, 33),
			},

			scope:New "TextLabel" {
				Name = "Label",
				LayoutOrder = 2,
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
			FontFace = scope:Computed(function(use)
				return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
			end),
			Text = scope:Computed(function(use) return use(page).name end),
			TextColor3 = Theme.Color.BaseContent,
			TextTransparency = dimmedTransparency(0),
			TextSize = Theme.TextSize.Subtitle,
				TextWrapped = false,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
		},
	})
end
