--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local TabBar = require(frontend.Components.TabBar)
local Children = Fusion.Children
local UserInputService = game:GetService("UserInputService")
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>

export type Props = {
	tabs: { TabBar.Tab },
	buildTabContent: (innerScope: Fusion.Scope, tabIdx: number) -> any,
	activeTabRef: Fusion.Value<number>?, -- auto-created if omitted
	onTabChanged: ((newIdx: number, prevIdx: number?) -> ())?,
	footerSlot: any?, -- pinned outside the scroll
	footerHeight: UsedAs<number>?, -- needed when the footer animates or clips internally
	headerPadding: UDim?, -- default 14px
	contentPadding: UDim2?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local activeTab: Fusion.Value<number> = props.activeTabRef or scope:Value(1)
	local prevTab: Fusion.Value<number?> = scope:Value(nil :: number?)
	local tabDirection: Fusion.Value<number> = scope:Value(1)
	local onTabChanged = props.onTabChanged

	local destroyed = false
	table.insert(scope, function()
		destroyed = true
	end)

	local tabSizes: { Fusion.Value<Vector2> } = {}
	local tabIndices: { number } = {}
	for index = 1, #props.tabs do
		tabSizes[index] = scope:Value(Vector2.zero)
		tabIndices[index] = index
	end

	local scrollSize: Fusion.Value<Vector2> = scope:Value(Vector2.zero)
	local tabBarSize: Fusion.Value<Vector2> = scope:Value(Vector2.zero)

	local headerPad = props.headerPadding or UDim.new(0, 14)
	local innerPad = props.contentPadding

	local function onTabChange(newIdx: number, prevIdx: number?)
		if prevIdx == nil then
			prevTab:set(nil)
			if onTabChanged then onTabChanged(newIdx, nil) end
			return
		end
		tabDirection:set(if newIdx > prevIdx then 1 else -1)
		prevTab:set(prevIdx)
		task.delay(0.6, function()
			if destroyed then return end
			prevTab:set(nil)
		end)
		if onTabChanged then onTabChanged(newIdx, prevIdx) end
	end

	-- Snaps on tab change, the slide alone feels smoother than a height spring
	local activeTabHeight = scope:Computed(function(use)
		local active = use(activeTab)
		local sizeValue = tabSizes[active]
		local contentH = 0
		if sizeValue then
			local size = use(sizeValue)
			if typeof(size) == "Vector2" then
				contentH = size.Y
			end
		end
		-- A few px slack keeps a near-minimum canvas under the scrollbar threshold
		local viewport = use(scrollSize)
		local viewportH = if typeof(viewport) == "Vector2" then viewport.Y else 0
		local barSize = use(tabBarSize)
		local barH = if typeof(barSize) == "Vector2" then barSize.Y else 0
		local minH = math.max(0, viewportH - barH - headerPad.Offset - 10)
		return math.max(contentH, minH)
	end)

	local theTabBar = TabBar(scope, {
		tabs = props.tabs,
		activeTab = activeTab,
		onTabChange = onTabChange,
	})

	-- AbsoluteSize is post-UIScale but feeds back into Size.Offset where the scale
	-- applies again, so divide out the cumulative scale first
	local function getCumulativeUIScale(inst: Instance?): number
		local scale = 1
		local cur = inst
		while cur do
			local us = cur:FindFirstChildOfClass("UIScale")
			if us then scale *= us.Scale end
			cur = cur.Parent
		end
		return scale
	end

	local function trackUnscaledSize(innerScope: Fusion.Scope, inst: GuiObject, target: Fusion.Value<Vector2>)
		local function write()
			if not inst.Parent then return end
			local scale = math.max(getCumulativeUIScale(inst), 0.0001)
			local absoluteSize = inst.AbsoluteSize
			target:set(Vector2.new(absoluteSize.X / scale, absoluteSize.Y / scale))
		end
		local conn = inst:GetPropertyChangedSignal("AbsoluteSize"):Connect(write)
		table.insert(innerScope, function() conn:Disconnect() end)
		task.defer(write)
	end

	local function buildMeasuredTab(innerScope: Fusion.Scope, tabIdx: number): any
		local userContent = props.buildTabContent(innerScope, tabIdx)
		local frame = innerScope:New "Frame" {
			Name = "TabContent_" .. tabIdx,
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 0),
			[Children] = { userContent },
		}
		trackUnscaledSize(innerScope, frame, tabSizes[tabIdx])
		return frame
	end

	local tabBarSlot = scope:New "Frame" {
		Name = "TabBarSlot",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = 0,
		Size = UDim2.fromScale(1, 0),
		[Children] = {
			scope:New "UIPadding" {
				PaddingRight = UDim.new(0, 5),
			},
			theTabBar,
		},
	}
	trackUnscaledSize(scope, tabBarSlot, tabBarSize)

	local scrollChildren: {any} = {
		scope:New "UIListLayout" {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			Padding = headerPad,
			SortOrder = Enum.SortOrder.LayoutOrder,
		},

		tabBarSlot,

		-- Size, not AutomaticSize.Y, the off-screen TabSlide still measures under clip
		scope:New "Frame" {
			Name = "TabContentArea",
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			LayoutOrder = 1,
			Size = scope:Computed(function(use)
				return UDim2.new(1, 0, 0, math.round(use(activeTabHeight)) + 2) -- +2 breathing gap so the last row isn't flush with the edge
			end),

			[Children] = {
				scope:ForValues(tabIndices, function(_, innerScope, tabIdx: number)
					local posTarget = innerScope:Computed(function(use)
						local active = use(activeTab)
						local prev = use(prevTab)
						local dir = use(tabDirection)
						if active == nil then
							return if tabIdx == 1 then UDim2.fromScale(0, 0) else UDim2.fromScale(1, 0)
						end
						if active == tabIdx then
							return UDim2.fromScale(0, 0)
						elseif prev == tabIdx then
							return UDim2.fromScale(-dir, 0)
						end
						return if tabIdx < active then UDim2.fromScale(-1, 0) else UDim2.fromScale(1, 0)
					end)

					local springSpeed = innerScope:Computed(function(use)
						return if use(activeTab) == tabIdx or use(prevTab) == tabIdx then 120 else 9999
					end)

					local springPos = innerScope:Spring(posTarget, springSpeed, 2.25)

					return innerScope:New "Frame" {
						Name = "TabSlide_" .. tabIdx,
						BackgroundTransparency = 1,
						ClipsDescendants = true,
						Position = springPos,
						Size = UDim2.fromScale(1, 1),
						[Children] = {
							innerScope:New "UIPadding" {
								Name = "UIPadding",
								PaddingBottom = UDim.new(0, 1),
								PaddingLeft = UDim.new(0, 1),
								PaddingRight = UDim.new(0, 5),
								PaddingTop = UDim.new(0, 1),
							},
							buildMeasuredTab(innerScope, tabIdx),
						},
					}
				end),
			},
		},
	}

	-- Always reserving the inset stops content shifting when scrollability flips
	local insetMode = if isMobile then Enum.ScrollBarInset.None else Enum.ScrollBarInset.Always

	local scrollFrame = scope:New "ScrollingFrame" {
		Name = "Scroll",
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		BottomImage = "rbxassetid://16547643439",
		CanvasSize = UDim2.new(),
		ClipsDescendants = true,
		MidImage = "rbxassetid://16547330984",
		ScrollBarImageColor3 = Theme.Color.NeutralContentDark,
		ScrollBarImageTransparency = if isMobile then 1 else 0,
		ScrollBarThickness = if isMobile then 0 else 8,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Selectable = false,
		Size = UDim2.fromScale(1, 1),
		TopImage = "rbxassetid://16547667444",
		VerticalScrollBarInset = insetMode,

		[Children] = {
			scope:New "UIPadding" {
				Name = "UIPadding",
				PaddingBottom = UDim.new(0, 1),
				PaddingLeft = UDim.new(0, 1),
				PaddingRight = UDim.new(0, 1),
				PaddingTop = UDim.new(0, 1),
			},
			scrollChildren,
		},
	}
	trackUnscaledSize(scope, scrollFrame, scrollSize)

	if not props.footerSlot then
		return scrollFrame
	end

	-- The caller passes footerHeight, measuring an animated clipped footer is unreliable
	local footerHeightProp: any = props.footerHeight or 0

	return scope:New "Frame" {
		Name = "TabbedScroller",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),

		[Children] = {
			scope:New "Frame" {
				Name = "ScrollArea",
				BackgroundTransparency = 1,
				Size = scope:Computed(function(use)
					local height = if typeof(footerHeightProp) == "table"
						then (use(footerHeightProp) :: number) or 0
						else (footerHeightProp :: number)
					return UDim2.new(1, 0, 1, -height)
				end),
				[Children] = { scrollFrame },
			},

			scope:New "Frame" {
				Name = "FooterHost",
				AnchorPoint = Vector2.new(0, 1),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0, 1),
				Size = scope:Computed(function(use)
					local height = if typeof(footerHeightProp) == "table"
						then (use(footerHeightProp) :: number) or 0
						else (footerHeightProp :: number)
					return UDim2.new(1, 0, 0, height)
				end),
				[Children] = { props.footerSlot },
			},
		},
	}
end
