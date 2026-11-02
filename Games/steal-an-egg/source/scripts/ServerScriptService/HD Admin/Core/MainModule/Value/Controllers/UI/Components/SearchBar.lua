--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local GlowTextInput = require(script.Parent.GlowTextInput)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	searchText: Fusion.Value<string>,
	placeholderText: UsedAs<string>?,
	layoutOrder: UsedAs<number>?,
	slot: any?, -- right-side element
	slotVisible: UsedAs<boolean>?, -- defaults to (slot ~= nil)
	leadingSlot: any?, -- left-side element
	leadingSlotVisible: UsedAs<boolean>?,
	onFocusLost: (() -> ())?,
	gap: UsedAs<UDim>?, -- spacing between the input and its slots, defaults to 10
}


-- COMPONENT
return function(scope: Scope, props: Props)
	return scope:New "Frame" {
		Name = "SearchRow",
		BackgroundTransparency = 1,
		LayoutOrder = props.layoutOrder or 0,
		Size = UDim2.new(1, 0, 0, 38), -- fixed 38, AutomaticSize.Y shrank to 36 with no slot

		[Children] = {
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = props.gap or UDim.new(0, 10),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				VerticalFlex = Enum.UIFlexAlignment.Fill,
			},

			scope:New "Frame" {
				Name = "LeadingSlot",
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				LayoutOrder = 0,
				Visible = if props.leadingSlotVisible ~= nil then props.leadingSlotVisible else (props.leadingSlot ~= nil),
				[Children] = if props.leadingSlot then { props.leadingSlot } else nil,
			},

			GlowTextInput(scope, {
				name = "SearchInput",
				placeholderText = props.placeholderText or "Search",
				text = props.searchText,
				backgroundColor = Theme.Color.Base,
				flexMode = Enum.UIFlexMode.Fill,
				layoutOrder = 1,
				onFocusLost = props.onFocusLost,
			}),

			scope:New "Frame" {
				Name = "TrailingSlot",
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				LayoutOrder = 2,
				Visible = if props.slotVisible ~= nil then props.slotVisible else (props.slot ~= nil),
				[Children] = if props.slot then { props.slot } else nil,
			},
		},
	}
end
