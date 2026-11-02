--!strict


-- LOCAL
local UserInputService = game:GetService("UserInputService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local HintBubble = require(frontend.Util.HintBubble)
local Pressable = require(frontend.Components.Pressable)
local dismissEpoch = 0


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	icon: UsedAs<string>,
	hintText: UsedAs<string>,
	visible: UsedAs<boolean>?,
	layoutOrder: UsedAs<number>?,
	position: UsedAs<UDim2>?,
	anchorPoint: UsedAs<Vector2>?,
	iconColor: UsedAs<Color3>?,
	iconSize: number?, -- px, defaults 16
	size: UsedAs<UDim2>?, -- hit area, defaults 20x20
}


-- COMPONENT
return function(scope: Scope, props: Props)
	local iconButton: GuiObject
	iconButton = Pressable(scope, {
		name = "HintIcon",
		size = props.size or UDim2.fromOffset(20, 20),
		position = props.position,
		anchorPoint = props.anchorPoint,
		layoutOrder = props.layoutOrder,
		visible = props.visible,
		backgroundColor = nil :: any,
		iconImage = props.icon,
		iconColor = props.iconColor or Theme.Color.NeutralContentDark,
		iconSize = props.iconSize or 16,
		onHoverChanged = function(isHovered: boolean)
			if isHovered then
				HintBubble.show(iconButton, tostring(Fusion.peek(props.hintText)), "hover")
			elseif HintBubble.via() == "hover" then
				HintBubble.hide(iconButton)
			end
		end,
		onActivate = function()
			-- Clicks only matter on touch, hover handles mouse devices
			if UserInputService.MouseEnabled
				and UserInputService:GetLastInputType() ~= Enum.UserInputType.Touch then
				return
			end
			if HintBubble.owner() == iconButton and HintBubble.via() == "tap" then
				HintBubble.hide(iconButton)
				return
			end
			HintBubble.show(iconButton, tostring(Fusion.peek(props.hintText)), "tap")
			dismissEpoch += 1
			local myEpoch = dismissEpoch
			task.delay(4, function()
				if dismissEpoch == myEpoch and HintBubble.owner() == iconButton then
					HintBubble.hide(iconButton)
				end
			end)
		end,
	}) :: GuiObject

	-- Hide the bubble if this icon gets destroyed while owning it
	table.insert(scope, function()
		HintBubble.hide(iconButton)
	end)

	return iconButton
end
