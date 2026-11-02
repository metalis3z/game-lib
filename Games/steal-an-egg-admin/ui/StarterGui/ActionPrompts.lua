-- Generated from ui/StarterGui/ActionPrompts.rbxm by _tools/rbxm2lua.luau
-- UI builder: local gui = require(this)(); gui.Parent = game.Players.LocalPlayer.PlayerGui (or StarterGui)

local function new(class, parent, name, props, attrs, tags)
	local o = Instance.new(class)
	o.Name = name
	if props then
		for k, v in props do
			o[k] = v
		end
	end
	if attrs then
		for k, v in attrs do
			o:SetAttribute(k, v)
		end
	end
	if tags then
		for _, t in tags do
			o:AddTag(t)
		end
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function build()
	local I = {}
	I[1] = new("ScreenGui", nil, "ActionPrompts", { DisplayOrder = 5, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "N0Ixz3XzN0Ix" })
		I[2] = new("Frame", I[1], "Holder", { AnchorPoint = Vector2.new(1, 1), AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, Position = UDim2.fromScale(0.4528646, 0.965), Size = UDim2.fromScale(0, 0.15), Visible = false }, { ["_lemonadeUniqueId"] = "UcVK6j5bUcVK" })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { Padding = UDim.new(0.06, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom }, { ["_lemonadeUniqueId"] = "WyXuTUlFWyXu" })
	return I[1]
end

return build
