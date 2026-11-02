--!strict

-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local Pressable = require(frontend.Components.Pressable)
local ClipHighlight = require(frontend.Components.ClipHighlight)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>

export type SlotProps = {
	fills: boolean?, -- true = expand to fill, else square via aspect ratio
	width: number?, -- non-fills only, skips the aspect-ratio constraint
	backgroundColor: UsedAs<Color3>?, -- override the Neutral+applyHighlight default tint
	isHovered: Fusion.Value<boolean>?,
	isPressed: Fusion.Value<boolean>?,
	visible: UsedAs<boolean>?, -- hides slot AND its adjacent dividers
	interactable: UsedAs<boolean>?, -- false disables hover/press/click (passthrough to Pressable)
	onActivate: UsedAs<(() -> ())>?,
	onHoverChanged: ((isHovered: boolean) -> ())?,
	onPressChanged: ((isPressed: boolean) -> ())?,
	ref: Fusion.Value<Instance?>?, -- receives the Pressable's TextButton
	name: string?,
	clipHighlight: {[string]: any}?, -- passthrough for ClipHighlight quirks (noExtend, hideCorner override)
	[typeof(Children)]: any,
}

type Props = {
	name: UsedAs<string>?,
	height: number?, -- default 38
	cornerRadius: number?, -- default 9
	layoutOrder: UsedAs<number>?,
	size: UsedAs<UDim2>?,
	strokeColor: UsedAs<Color3>?, -- replaces the gradient stroke
	zIndex: UsedAs<number>?,
	left: SlotProps?,
	center: SlotProps?,
	right: SlotProps?,
	rights: {SlotProps}?, -- extra trailing slots after right, in order
}


-- COMPONENT
return function(scope: Scope, props: Props)
	debug.profilebegin("HD_SplitRow")
	local height = props.height or 38
	local cornerRadius = props.cornerRadius or 9

	type Entry = {slot: SlotProps, position: string}
	local entries: {Entry} = {}
	if props.left then table.insert(entries, {slot = props.left, position = "left"}) end
	if props.center then table.insert(entries, {slot = props.center, position = "center"}) end
	if props.right then table.insert(entries, {slot = props.right, position = "right"}) end
	if props.rights then
		for _, slot in props.rights do
			table.insert(entries, {slot = slot, position = "right"})
		end
	end
	local entryCount = #entries

	local slotIsHovered: {Fusion.Value<boolean>} = {}
	local slotIsPressed: {Fusion.Value<boolean>} = {}
	for index, entry in entries do
		slotIsHovered[index] = entry.slot.isHovered or scope:Value(false)
		slotIsPressed[index] = entry.slot.isPressed or scope:Value(false)
	end

	-- Plain bools, reactive hover churned in long lists
	local slotHovered: {boolean} = {}
	for _ = 1, entryCount do table.insert(slotHovered, false) end

	local dividerFrames: {Frame?} = table.create(math.max(0, entryCount - 1))

	local function updateDividers()
		for index = 1, entryCount - 1 do
			local df = dividerFrames[index]
			if df then
				local hovered = slotHovered[index] or slotHovered[index + 1]
				df.BackgroundTransparency = if hovered then 1 else 0.85
			end
		end
	end

	local strokeChildren: {any} = {}
	if props.strokeColor == nil then
		table.insert(strokeChildren, scope:New "UIGradient" {
			Color = scope:Computed(function(use)
				local stroke = use(Theme.Color.NeutralContent)
				local neutral = use(Theme.Color.Neutral)
				return ColorSequence.new({
					ColorSequenceKeypoint.new(0, stroke),
					ColorSequenceKeypoint.new(1, neutral),
				})
			end),
			Rotation = 90,
		})
	end

	local rendered: {any} = {
		scope:New "UICorner" { CornerRadius = UDim.new(0, cornerRadius) },
		scope:New "UIStroke" {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = if props.strokeColor ~= nil then (props.strokeColor :: any) else Color3.new(1, 1, 1),
			[Children] = strokeChildren,
		},
		scope:New "UIListLayout" {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalFlex = Enum.UIFlexAlignment.None,
			Padding = UDim.new(0, 1),
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
		},
	}

	for index, entry in entries do
		local slot = entry.slot
		local isFirst = index == 1
		local isLast = index == entryCount
		local slotLayoutOrder = index * 2 -- slots at 2, 4, 6 and dividers at 3, 5

		local chSide: "left" | "right"
		local chHideCorner: boolean
		if entryCount == 1 then
			chSide = "left"
			chHideCorner = false
		elseif isFirst then
			chSide = "left"
			chHideCorner = false
		elseif isLast then
			chSide = "right"
			chHideCorner = false
		else
			chSide = "right"
			chHideCorner = true
		end

		local chProps: {[string]: any} = {
			side = chSide,
			cornerRadius = cornerRadius,
			hideCorner = chHideCorner,
		}
		if isLast and entryCount >= 2 then
			chProps.noExtend = false
		else
			chProps.noExtend = scope:Computed(function(use)
				for nextIndex = index + 1, entryCount do
					local nextSlot = entries[nextIndex].slot
					local nextVisible = if nextSlot.visible ~= nil then use(nextSlot.visible :: any) else true
					if nextVisible then
						return false
					end
				end
				return true
			end)
		end
		if slot.clipHighlight then
			for key, value in slot.clipHighlight do
				chProps[key] = value
			end
		end

		local tintColor = slot.backgroundColor or scope:Computed(function(use)
			local base = use(Theme.Color.Neutral)
			return Pressable.applyHighlight(use, base, slotIsPressed[index], slotIsHovered[index])
		end)
		chProps.color = tintColor

		-- Closure-captured slot index for hover/press callbacks
		local slotIndex = index
		local callerHover = slot.onHoverChanged
		local callerPress = slot.onPressChanged

		local function onHover(hovered: boolean)
			slotHovered[slotIndex] = hovered
			slotIsHovered[slotIndex]:set(hovered)
			updateDividers()
			if callerHover then callerHover(hovered) end
		end

		local function onPress(pressed: boolean)
			slotIsPressed[slotIndex]:set(pressed)
			if callerPress then callerPress(pressed) end
		end

		local pressableSize: UDim2 = if slot.fills
			then UDim2.new(0, 0, 1, 0)
			elseif slot.width ~= nil
				then UDim2.new(0, slot.width, 1, 0)
				else UDim2.fromScale(0, 1)

		local sizingChild: any
		if slot.fills then
			sizingChild = scope:New "UIFlexItem" { FlexMode = Enum.UIFlexMode.Fill }
		elseif slot.width ~= nil then
			sizingChild = nil
		else
			sizingChild = scope:New "UIAspectRatioConstraint" {
				AspectType = Enum.AspectType.ScaleWithParentSize,
				DominantAxis = Enum.DominantAxis.Height,
			}
		end

		local pressableInstance = Pressable(scope, {
			name = slot.name or entry.position,
			size = pressableSize,
			layoutOrder = slotLayoutOrder,
			visible = slot.visible,
			interactable = slot.interactable,
			onActivate = slot.onActivate,
			onHoverChanged = onHover,
			onPressChanged = onPress,
			[Children] = {
				ClipHighlight(scope, chProps),
				sizingChild,
				(slot :: any)[Children],
			},
		})

		if slot.ref then
			(slot.ref :: any):set(pressableInstance)
		end

		table.insert(rendered, pressableInstance)

		-- A filled-in right neighbour draws its own edge, a divider would double up
		if not isLast and entries[index + 1].slot.backgroundColor == nil then
			local thisVis = slot.visible
			local nextVis = entries[index + 1].slot.visible
			local dividerVisible: any = nil
			if thisVis ~= nil or nextVis ~= nil then
				dividerVisible = scope:Computed(function(use)
					local thisVisible = if thisVis ~= nil then use(thisVis :: any) else true
					local nextVisible = if nextVis ~= nil then use(nextVis :: any) else true
					return thisVisible and nextVisible
				end)
			end

			local df: Frame = scope:New "Frame" {
				Name = "Divider",
				BackgroundColor3 = Theme.Color.NeutralContentDark,
				BackgroundTransparency = 0.85,
				BorderSizePixel = 0,
				LayoutOrder = slotLayoutOrder + 1,
				Size = UDim2.new(0, 1, 0, 26),
				Visible = dividerVisible,
			} :: Frame

			dividerFrames[index] = df
			table.insert(rendered, df)
		end
	end

	local row = scope:New "Frame" {
		Name = props.name or "SplitRow",
		BackgroundColor3 = Theme.Color.Neutral,
		LayoutOrder = props.layoutOrder,
		Size = props.size or UDim2.new(1, 0, 0, height),
		ZIndex = props.zIndex,

		[Children] = rendered,
	}
	debug.profileend()
	return row
end
