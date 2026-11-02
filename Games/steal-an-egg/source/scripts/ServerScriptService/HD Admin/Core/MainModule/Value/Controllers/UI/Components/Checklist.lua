--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local CheckItem = require(script.Parent.CheckItem)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	items: UsedAs<{ string }>?,
	selection: Fusion.Value<{ string }>?,
	onToggle: UsedAs<(item: string, checked: boolean) -> ()>?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local items = props.items or scope:Value({})
	local selection: Fusion.Value<{ string }> = props.selection or scope:Value({})
	local onToggle = props.onToggle

	return scope:New "Frame" {
		Name = "Checklist",
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 0),

		[Children] = {
			scope:New "UIListLayout" {
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 4),
			},

			scope:ForValues(items, function(use, innerScope, item: string)
				local isChecked = innerScope:Computed(function(use2)
					return table.find(use2(selection), item) ~= nil
				end)

				return CheckItem(innerScope, {
					content = innerScope:Value(item),
					checked = isChecked,
					onCheck = function(checked: boolean)
						local sel = table.clone(Fusion.peek(selection))
						local idx = table.find(sel, item)
						if checked and not idx then
							table.insert(sel, item)
						elseif not checked and idx then
							table.remove(sel, idx)
						end
						selection:set(sel)
						local callback = onToggle
						if callback then
							local handler = if typeof(callback) == "table" then Fusion.peek(callback) else callback
							if handler then handler(item, checked) end
						end
					end,
				})
			end),
		},
	}
end
