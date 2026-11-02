-- Generated from ui/StarterGui/Notifications.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Notifications", { DisplayOrder = 11, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "lOaJ2JtLlOaJ" })
		I[2] = new("Frame", I[1], "Bottom", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0.93, -40), Size = UDim2.new(0.5, 25, 0.12, 55) }, { ["_lemonadeUniqueId"] = "LKhRqFE4LKhR" })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom }, { ["_lemonadeUniqueId"] = "7ZniDxkU7Zni" })
		I[4] = new("Frame", I[1], "MessageTop", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.14), Size = UDim2.new(0.5, 25, 0.12, 55), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "dbQ3btaedbQ3" })
			I[5] = new("UIListLayout", I[4], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "c64JqBt3c64J" })
	return I[1]
end

return build
