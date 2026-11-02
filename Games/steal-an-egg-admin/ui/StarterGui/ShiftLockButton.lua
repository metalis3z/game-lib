-- Generated from ui/StarterGui/ShiftLockButton.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ShiftLockButton", { ClipToDeviceSafeArea = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "W5vMM9LNW5vM" })
		I[2] = new("ImageButton", I[1], "ImageButton", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/mouseLock_off@2x.png"), Position = UDim2.fromScale(1.03, 1), Size = UDim2.fromScale(0.0636147, 0.0661306), SizeConstraint = Enum.SizeConstraint.RelativeXX, Visible = false }, { ["_lemonadeUniqueId"] = "a4P8SjxDa4P8" })
		I[3] = new("ImageLabel", I[1], "Lock", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://117149460324030"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.05, 0.05), Visible = false }, { ["_lemonadeUniqueId"] = "XJZDHwX3XJZD" })
			I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "uf340HWQuf34" })
	return I[1]
end

return build
