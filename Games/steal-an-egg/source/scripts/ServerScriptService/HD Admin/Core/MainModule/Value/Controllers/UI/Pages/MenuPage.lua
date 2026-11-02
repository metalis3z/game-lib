--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Viewport = require(frontend.Config.Viewport)
local PageButton = require(frontend.Components.PageButton)
local Navigation = require(frontend.Config.Navigation)
local DashboardSections = require(frontend.Config.DashboardSections)
local Permissions = require(frontend.Util.Permissions)
local Prompt = require(modules.Prompt)
local Children = Fusion.Children
local Out = Fusion.Out


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	onPageActivate: UsedAs<(pageId: string) -> ()>?,
	contentHeight: UsedAs<number>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local onPageActivate = props.onPageActivate

	local isExpanded = scope:Computed(function(use)
		local contentHeight = props.contentHeight
		local current = if contentHeight ~= nil and typeof(contentHeight) == "table" then use(contentHeight :: any) else (contentHeight or 0)
		return current > use(Viewport.MenuHeightPixels)
	end)

	local navChildren = scope:Value(Navigation.children or {})

	-- Hide UIStroke at zero height so Roblox doesn't render a faint border
	local hiddenAbsSize: Fusion.Value<Vector2> = scope:Value(Vector2.zero)

	return scope:New "Frame" {
		Name = "MenuPage",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),

		[Children] = {
			scope:New "ScrollingFrame" {
				Name = "Scroller",
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				BottomImage = "rbxassetid://16547643439",
				CanvasSize = UDim2.new(),
				MidImage = "rbxassetid://16547330984",
				ScrollBarImageTransparency = 1,
				ScrollBarThickness = 0,
				ScrollingDirection = Enum.ScrollingDirection.Y,
				TopImage = "rbxassetid://16547667444",
				Size = UDim2.fromScale(1, 1),

		[Children] = {
			scope:New "UIPadding" {
				PaddingTop = UDim.new(0, 1),
				PaddingBottom = UDim.new(0, 1),
				PaddingLeft = UDim.new(0, 1),
				PaddingRight = UDim.new(0, 1),
			},
			scope:New "UIListLayout" {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
				Padding = UDim.new(0, 7),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			scope:New "Frame" {
				Name = "Pages",
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,

				[Children] = {
					scope:New "UIPadding" {
						PaddingTop = UDim.new(0, 1),
						PaddingBottom = UDim.new(0, 1),
						PaddingLeft = UDim.new(0, 1),
						PaddingRight = UDim.new(0, 1),
					},
					scope:New "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
					Padding = UDim.new(0, 8),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Wraps = true,
				},

				scope:ForValues(navChildren, function(_, innerScope, entry)
					-- An empty bundle (like About) means the card has no permission gating
					local sectionPages: {string} = DashboardSections[entry.id] or {}
					local canEnter = Permissions.canViewAnyOf(innerScope, sectionPages)
					local youReady = Permissions.youReady(innerScope)
					-- While perms load cards stay normal and navigate as usual, the
					-- destination page renders its own spinner
					local denied = innerScope:Computed(function(use): boolean
						return use(youReady) and not use(canEnter)
					end)
					return PageButton(innerScope, {
						pageId = entry.id,
						size = UDim2.new(0.5, -5, 0, 0),
						dimmed = denied,
							onActivate = function()
								if Fusion.peek(denied) then
									Prompt.error("You do not have permission to view this section.")
									return
								end
								local callback = onPageActivate
								if callback then
									local handler = if typeof(callback) == "table"
										then Fusion.peek(callback)
										else callback
									if handler then handler(entry.id) end
								end
							end,
						})
					end),
				},
			},

			scope:New "TextButton" {
				Name = "HiddenContent",
				AutoButtonColor = false,
				AutomaticSize = scope:Computed(function(use)
					return if use(isExpanded) then Enum.AutomaticSize.Y else Enum.AutomaticSize.None
				end),
				[Out("AbsoluteSize")] = hiddenAbsSize,
				BackgroundColor3 = Theme.Color.Neutral,
				ClipsDescendants = true,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
				end),
				Size = UDim2.new(1, -6, 0, 0),
				Text = "",
				TextColor3 = Theme.Color.BaseContent,
				TextSize = Theme.TextSize.Body,

				[Children] = {
					scope:New "UIFlexItem" {
						Name = "UIFlexItem",
						FlexMode = Enum.UIFlexMode.Fill,
					},

					scope:New "UICorner" {
						Name = "UICorner",
						CornerRadius = UDim.new(0, 9),
					},

					scope:New "UIPadding" {
						Name = "UIPadding",
						PaddingBottom = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding)) end),
						PaddingLeft = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding)) end),
						PaddingRight = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding)) end),
						PaddingTop = scope:Computed(function(use) return UDim.new(0, use(Theme.Layout.Padding)) end),
					},

					scope:New "UIStroke" {
						Name = "UIStroke",
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Color = Theme.Color.NeutralContent,
						Thickness = Theme.Layout.StrokeThickness,
						Enabled = scope:Computed(function(use)
							return use(hiddenAbsSize).Y > 0
						end),
					},

					scope:New "UIListLayout" {
						Name = "UIListLayout",
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						Padding = UDim.new(0, 5),
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Center,
					},

				},
			},

			scope:New "Frame" {
				Name = "PaddingBottom",
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				LayoutOrder = 999,
				Size = UDim2.fromScale(1, 0),
				Visible = scope:Computed(function(use)
					return use(hiddenAbsSize).Y > 0
				end),
			},
				},
			},
		},
	}
end
