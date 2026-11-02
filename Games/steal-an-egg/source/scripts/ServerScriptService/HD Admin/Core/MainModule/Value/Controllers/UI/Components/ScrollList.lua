--!strict


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local OnChange = Fusion.OnChange
local LoadingSpinner = require(frontend.Components.LoadingSpinner)
local StreamList = require(frontend.Components.StreamList)
local UserInputService = game:GetService("UserInputService")

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	isReady: UsedAs<boolean>,
	items: Fusion.UsedAs<{ any }>,
	visibleItems: Fusion.UsedAs<{ any }>?,
	itemKey: ((item: any) -> string)?, -- forwarded to StreamList for incremental diffing
	renderItem: (scope: Scope, item: any) -> Instance,
	padding: UDim?,
	minLoadTime: number?,
	layoutOrder: UsedAs<number>?,
	header: Instance?,
	headerGap: UDim?,
	paddingRight: number?,
	idle: Fusion.UsedAs<boolean>?,
	idleGrace: number?,
	onScrollerReady: ((scroller: ScrollingFrame) -> ())?,
	useStream: UsedAs<boolean>?, -- false = ForValues instead of StreamList
	overlay: Instance?, -- sits on top of the scroller and doesn't scroll
	pinBelowHeader: boolean?, -- overlay Y tracks the header's bottom edge
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local minLoadTime = props.minLoadTime or 0.4

	-- Min display time so spinner doesn't flash
	local minLoadingElapsed = scope:Value(false)
	task.delay(minLoadTime, function()
		minLoadingElapsed:set(true)
	end)

	local isLoading: Fusion.Computed<boolean> = scope:Computed(function(use)
		if not use(minLoadingElapsed) then return true end
		return not use(props.isReady)
	end)

	local isNotLoading: Fusion.Computed<boolean> = scope:Computed(function(use)
		return not use(isLoading)
	end)

	local scrollCanvasHeight = scope:Value(0)
	local scrollWindowHeight = scope:Value(0)
	local scrollbarVisible = scope:Computed(function(use)
		return use(scrollCanvasHeight) > use(scrollWindowHeight)
	end)

	local scroller = scope:New "ScrollingFrame" {
		Name = "ScrollingFrame",
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		BottomImage = "rbxassetid://16547643439",
		CanvasSize = UDim2.new(),
		LayoutOrder = 2,
		MidImage = "rbxassetid://16547330984",
		ScrollBarImageColor3 = Theme.Color.NeutralContentDark,
		ScrollBarImageTransparency = if isMobile then 1 else 0,
		ScrollBarThickness = if isMobile then 2 else 8,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Selectable = false,
		Size = UDim2.fromScale(1, 1),
		TopImage = "rbxassetid://16547667444",
		VerticalScrollBarInset = Enum.ScrollBarInset.Always,
		Visible = isNotLoading,
		[OnChange("AbsoluteCanvasSize")] = function(newSize: Vector2)
			scrollCanvasHeight:set(newSize.Y)
		end,
		[OnChange("AbsoluteWindowSize")] = function(newSize: Vector2)
			scrollWindowHeight:set(newSize.Y)
		end,

		[Children] = {
			scope:New "UIFlexItem" {
				FlexMode = Enum.UIFlexMode.Fill,
			},
			scope:New "UIPadding" {
				PaddingBottom = UDim.new(0, 1),
				PaddingLeft = UDim.new(0, 1),
				PaddingRight = UDim.new(0, if isMobile then 4 else (props.paddingRight or 2)),
				PaddingTop = UDim.new(0, 1),
			},
			scope:New "UIListLayout" {
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				Padding = props.headerGap or UDim.new(0, 0),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},
			props.header,

			scope:Computed(function(use, innerScope)
				local stream = if props.useStream ~= nil then use(props.useStream :: any) else true
				if stream then
					return StreamList(innerScope, {
						items = props.items,
						visibleItems = props.visibleItems,
						itemKey = props.itemKey,
						renderItem = props.renderItem,
						padding = props.padding,
						layoutOrder = 1,
						idle = props.idle,
						idleGrace = props.idleGrace,
						parentScrollingFrame = scroller :: ScrollingFrame,
					})
				else
					return innerScope:New "Frame" {
						Name = "DirectList",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundTransparency = 1,
						LayoutOrder = 1,
						Size = UDim2.fromScale(1, 0),
						[Children] = {
							innerScope:New "UIListLayout" {
								HorizontalFlex = Enum.UIFlexAlignment.Fill,
								Padding = props.padding or UDim.new(0, 8),
								SortOrder = Enum.SortOrder.LayoutOrder,
							},
							innerScope:ForValues(props.visibleItems or props.items, function(_, itemScope, item)
								return props.renderItem(itemScope, item)
							end),
						},
					}
				end
			end),
		},
	}

	if props.onScrollerReady then
		props.onScrollerReady(scroller :: ScrollingFrame)
	end

	-- OverlayWrapper aligns the overlay with the scroller's content area so a
	-- sticky header lines up pixel-perfect with the rows beneath it
	local overlayWrapper: any = nil
	local overlayRightInset = 1 + (if isMobile then 4 else (props.paddingRight or 2)) + (if isMobile then 2 else 8)
	if props.overlay then
		overlayWrapper = scope:New "Frame" {
			Name = "OverlayWrapper",
			AnchorPoint = Vector2.new(0, 0),
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(1, 0),
			Size = UDim2.new(1, -overlayRightInset, 1, 0),
			ZIndex = 5,
			[Children] = { props.overlay },
		}
	end

	-- The spinner drops below a visible overlay so a sticky heading keeps the top spot while loading
	local spinnerInset = scope:Value(0)
	if props.overlay and (props.overlay :: any):IsA("GuiObject") then
		local overlayObj = props.overlay :: GuiObject
		local function updateSpinnerInset()
			if not overlayObj.Visible then
				spinnerInset:set(0)
				return
			end
			local height = overlayObj.AbsoluteSize.Y
			if height <= 0 then
				height = overlayObj.Size.Y.Offset
			end
			spinnerInset:set(height)
		end
		local insetConns: {RBXScriptConnection} = {
			overlayObj:GetPropertyChangedSignal("Visible"):Connect(updateSpinnerInset),
			overlayObj:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSpinnerInset),
		}
		table.insert(scope, function()
			for _, connection in insetConns do connection:Disconnect() end
		end)
		updateSpinnerInset()
	end

	local scrollContainer = scope:New "Frame" {
		Name = "ScrollContainer",
		BackgroundTransparency = 1,
		LayoutOrder = 2,
		Size = UDim2.fromScale(1, 1),

		[Children] = {
			scope:New "UIFlexItem" {
				FlexMode = Enum.UIFlexMode.Fill,
			},
			scroller,

			scope:Computed(function(use, innerScope)
				if not use(isLoading) then return nil end
				return innerScope:New "Frame" {
					Name = "LoadingArea",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					Position = innerScope:Computed(function(useInner)
						return UDim2.fromOffset(0, useInner(spinnerInset))
					end),
					Size = UDim2.fromScale(1, 0),
					[Children] = { LoadingSpinner(innerScope, {layoutOrder = 1}) },
				}
			end),

			overlayWrapper,
		},
	}

	-- The overlay sits below the header until it scrolls off, then snaps to the
	-- scroller's top like an iOS sticky section header
	if props.pinBelowHeader and overlayWrapper and props.header and (props.header :: any):IsA("GuiObject") then
		local headerObj = props.header :: GuiObject
		local scrollerObj = scroller :: ScrollingFrame
		local function updateOverlayPosition()
			local headerBottom = headerObj.AbsolutePosition.Y + headerObj.AbsoluteSize.Y
			local scrollerTop = scrollerObj.AbsolutePosition.Y
			local offsetY = math.max(0, headerBottom - scrollerTop)
			overlayWrapper.Position = UDim2.fromOffset(1, offsetY)
			-- Shrink by the same amount so a centred child centres in the remaining space
			overlayWrapper.Size = UDim2.new(1, -overlayRightInset, 1, -offsetY)
		end
		local conns: {RBXScriptConnection} = {
			scrollerObj:GetPropertyChangedSignal("CanvasPosition"):Connect(updateOverlayPosition),
			scrollerObj:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateOverlayPosition),
			headerObj:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateOverlayPosition),
		}
		table.insert(scope, function()
			for _, connection in conns do connection:Disconnect() end
		end)
		task.defer(updateOverlayPosition)
	end

	return scope:New "Frame" {
		Name = "ScrollList",
		BackgroundTransparency = 1,
		LayoutOrder = props.layoutOrder or 1,
		Size = UDim2.fromScale(1, 0),

		[Children] = {
			scope:New "UIFlexItem" {
				FlexMode = Enum.UIFlexMode.Fill,
			},
			scope:New "UIListLayout" {
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			scrollContainer,
		},
	}
end
