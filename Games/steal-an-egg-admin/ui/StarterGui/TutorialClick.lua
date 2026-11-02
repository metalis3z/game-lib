-- Generated from ui/StarterGui/TutorialClick.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "TutorialClick", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "K3GIL0rZK3GI" })
		I[2] = new("ImageLabel", I[1], "Image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://96606025304766"), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.15, 0.15) }, { ["_lemonadeUniqueId"] = "LN9sC3zDLN9s" })
			I[3] = new("UIScale", I[2], "UIScale", nil, { ["_lemonadeUniqueId"] = "WB4ALZrLWB4A" })
			I[4] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "zIo7OzU0zIo7" })
	return I[1]
end

return build
