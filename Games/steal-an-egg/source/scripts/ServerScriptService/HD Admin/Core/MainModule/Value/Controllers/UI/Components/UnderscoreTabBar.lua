--!strict


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Viewport = require(frontend.Config.Viewport)
local Pressable = require(frontend.Components.Pressable)
local ClipHighlight = require(frontend.Components.ClipHighlight)
local Children = Fusion.Children
local Out = Fusion.Out

-- Must match the bar's UICorner so edge-tab highlights round at the same radius
local OUTER_CORNER_RADIUS = 6


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
export type Tab = {
	label: UsedAs<string>,
	icon: string?,
	visible: UsedAs<boolean>?, -- hidden tabs leave no gap, the rest reflow to fill the bar
}
type Props = {
	tabs: { Tab },
	activeTab: Fusion.Value<number>,
	onTabChange: ((newIdx: number, prevIdx: number?) -> ())?,
	layoutOrder: UsedAs<number>?,
	underlineHeight: number?, -- default 2
	underlineInset: number?, -- default 0
	height: number?, -- label padding drives it otherwise
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local tabs = props.tabs
	local activeTab = props.activeTab
	local onTabChange = props.onTabChange
	local underlineHeight = props.underlineHeight or 2
	local underlineInset = props.underlineInset or 0
	local fixedHeight = props.height

	local tabAbsPos: {Fusion.Value<Vector2>} = {}
	local tabAbsSize: {Fusion.Value<Vector2>} = {}
	for index = 1, #tabs do
		tabAbsPos[index] = scope:Value(Vector2.zero)
		tabAbsSize[index] = scope:Value(Vector2.zero)
	end
	local barAbsPos: Fusion.Value<Vector2> = scope:Value(Vector2.zero)

	-- The underline frames are siblings so the horizontal flex can't push them around
	local tabPressables: { any } = {
		scope:New "UIListLayout" {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			Padding = UDim.new(0, 0), -- tabs sit flush so the underline tracks abut into one continuous divider
			SortOrder = Enum.SortOrder.LayoutOrder,
		},
	}

	for idx, tab in tabs do
		local tabIdx = idx
		local tabCount = #tabs
		local isActive = scope:Computed(function(use)
			return use(activeTab) == tabIdx
		end)

		local hovered: Fusion.Value<boolean> = scope:Value(false)
		local pressed: Fusion.Value<boolean> = scope:Value(false)

		local isFirst = tabIdx == 1
		local isLast = tabIdx == tabCount
		local highlightSide: "left" | "right" = if isFirst then "left" else "right"
		local hideCorner = not isFirst and not isLast
		local noExtend = tabCount == 1

		-- Pressable doesn't forward [Out], so the wrapper Frame owns the rect bindings
		-- and the Track is embedded here so it always spans exactly the tab's width
		local labelName = if typeof(tab.label) == "string" then tab.label :: string else tostring(tabIdx)
		table.insert(tabPressables, scope:New "Frame" {
			Name = "Tab_" .. labelName,
			AutomaticSize = if fixedHeight then Enum.AutomaticSize.None else Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 0, 0, fixedHeight or 0),
			LayoutOrder = tabIdx,
			Visible = tab.visible,
			[Out("AbsolutePosition")] = tabAbsPos[tabIdx],
			[Out("AbsoluteSize")] = tabAbsSize[tabIdx],
			[Children] = {
				scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill },

				scope:New "Frame" {
					Name = "Track",
					AnchorPoint = Vector2.new(0, 1),
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 0.5,
					BorderSizePixel = 0,
					Position = UDim2.new(0, underlineInset, 1, 0),
					Size = UDim2.new(1, -underlineInset * 2, 0, underlineHeight),
					ZIndex = 10, -- above the Pressable's ClipHighlight so it can't hide the track
				},
				Pressable(scope, {
					name = "TabPressable_" .. labelName,
					size = if fixedHeight then UDim2.fromScale(1, 1) else UDim2.new(1, 0, 0, 0),
					automaticSize = if fixedHeight then nil else Enum.AutomaticSize.Y,
					backgroundColor = nil :: any, -- stays transparent; ClipHighlight below does the tint so edge tabs round their outer corner
					clipsDescendants = false,
					onHoverChanged = function(isHovered)
						hovered:set(isHovered)
					end,
					onPressChanged = function(isPressed)
						pressed:set(isPressed)
					end,
					onActivate = function()
						local prev = Fusion.peek(activeTab)
						if prev == tabIdx then return end
						activeTab:set(tabIdx)
						if onTabChange then
							onTabChange(tabIdx, prev)
						end
					end,
					[Children] = {
						-- A direct child so the Content layout can't suck it into the flow
						ClipHighlight(scope, {
							side = highlightSide,
							cornerRadius = OUTER_CORNER_RADIUS,
							hideCorner = hideCorner,
							noExtend = noExtend,
							color = scope:Computed(function(use)
								return Pressable.applyHighlight(use, use(Theme.Color.Neutral), pressed, hovered)
							end),
						}),
						scope:New "Frame" {
							Name = "Content",
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(1, 1),
							ZIndex = 2,
							[Children] = {
								scope:New "UIPadding" {
									PaddingTop = UDim.new(0, if fixedHeight then 0 else 8),
									-- Centres the label in the space above the underline
									PaddingBottom = UDim.new(0, if fixedHeight then underlineHeight else 10),
									PaddingLeft = UDim.new(0, 4),
									PaddingRight = UDim.new(0, 4),
								},
								scope:New "UIListLayout" {
									FillDirection = Enum.FillDirection.Horizontal,
									HorizontalAlignment = Enum.HorizontalAlignment.Center,
									Padding = UDim.new(0, 4),
									SortOrder = Enum.SortOrder.LayoutOrder,
									VerticalAlignment = Enum.VerticalAlignment.Center,
								},
								if tab.icon ~= nil
									then scope:New "ImageLabel" {
										Name = "Icon",
										BackgroundTransparency = 1,
										Image = tab.icon,
										ImageColor3 = scope:Computed(function(use)
											return if use(isActive)
												then use(Theme.Color.BaseContent)
												else use(Theme.Color.NeutralContentDark)
										end),
										LayoutOrder = 1,
										Size = UDim2.fromOffset(18, 18),
									}
									else nil,
								scope:New "TextLabel" {
									Name = "Label",
									AutomaticSize = Enum.AutomaticSize.XY,
									BackgroundTransparency = 1,
									LayoutOrder = 2,
									FontFace = scope:Computed(function(use)
										return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body)) -- constant weight so the label doesn't reflow on switch
									end),
									RichText = true,
									Text = tab.label,
									TextColor3 = scope:Computed(function(use)
										return if use(isActive)
											then use(Theme.Color.BaseContent)
											else use(Theme.Color.NeutralContentDark)
									end),
									TextSize = Theme.TextSize.Subtitle,
								},
							},
						},
					},
				}),
			},
		})
	end

	local tabsFrame = scope:New "Frame" {
		Name = "Tabs",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		ZIndex = 1,
		[Children] = tabPressables,
	}

	local function readVisible(use: any, v: any): boolean
		if v == nil then return true end
		if typeof(v) == "boolean" then return v end
		return use(v) == true
	end

	local underlineChildren: { any } = {}

	-- Only X springs, a UDim2 Spring on Size starts as a zero-width bar. tabAbsPos
	-- and tabAbsSize are screen px, so divide by Viewport.Scale for local units
	local indicatorX = scope:Computed(function(use)
		local activeIdx = use(activeTab)
		local pos = tabAbsPos[activeIdx]
		if pos == nil then return 0 end
		local scale = use(Viewport.Scale)
		if scale <= 0 then scale = 1 end
		local delta = (use(pos) :: Vector2).X - (use(barAbsPos) :: Vector2).X
		return delta / scale + underlineInset
	end)
	local indicatorWidth = scope:Computed(function(use)
		local activeIdx = use(activeTab)
		local size = tabAbsSize[activeIdx]
		if size == nil then return 0 end
		local scale = use(Viewport.Scale)
		if scale <= 0 then scale = 1 end
		return (use(size) :: Vector2).X / scale - underlineInset * 2
	end)
	local indicatorXSpring = (scope :: any):Spring(indicatorX, 45, 1)

	-- Hide rather than strand a Primary bar when the active tab isn't visible
	local indicatorVisible = scope:Computed(function(use)
		local activeIdx = use(activeTab)
		local activeTab = tabs[activeIdx]
		if activeTab == nil then return false end
		return readVisible(use, activeTab.visible)
	end)

	table.insert(underlineChildren, scope:New "Frame" {
		Name = "Indicator",
		AnchorPoint = Vector2.new(0, 1), -- bottom-anchored so the indicator shares the tracks' baseline at any bar height
		Visible = indicatorVisible,
		BackgroundColor3 = Theme.Color.Primary,
		BorderSizePixel = 0,
		Position = scope:Computed(function(use)
			return UDim2.new(0, use(indicatorXSpring), 1, 0)
		end),
		Size = scope:Computed(function(use)
			return UDim2.fromOffset(use(indicatorWidth), underlineHeight)
		end),
		ZIndex = 2,
	})

	local underlinesFrame = scope:New "Frame" {
		Name = "Underlines",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1), -- no UIListLayout governs this frame, so its children are pure absolute overlays
		ZIndex = 2,
		[Children] = underlineChildren,
	}

	return scope:New "Frame" {
		Name = "UnderscoreTabBar",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = Theme.Color.Neutral,
		LayoutOrder = props.layoutOrder or 0,
		Size = UDim2.new(1, 0, 0, 0),
		[Out("AbsolutePosition")] = barAbsPos,
		[Children] = { -- tabsFrame drives the height, underlinesFrame overlays on top
			scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.NeutralStroke,
				[Children] = {
					scope:New "UIGradient" {
						Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
							ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
						}),
						Rotation = 90,
					},
				},
			},
			tabsFrame,
			underlinesFrame,
		},
	}
end
