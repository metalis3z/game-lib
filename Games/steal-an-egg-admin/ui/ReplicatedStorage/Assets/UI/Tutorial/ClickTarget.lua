-- Generated from ui/ReplicatedStorage/Assets/UI/Tutorial/ClickTarget.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ClickTarget", { ClipToDeviceSafeArea = false, DisplayOrder = 899, Enabled = false, ResetOnSpawn = false, SafeAreaCompatibility = Enum.SafeAreaCompatibility.None, ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "nwvUCJrTnwvU" })
		I[2] = new("Frame", I[1], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.404511, 0.4965536), Size = UDim2.fromOffset(100, 100) }, { ["_lemonadeUniqueId"] = "V4IpMd4IV4Ip" })
			I[3] = new("Frame", I[2], "Frame", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(6880, 3000) }, { ["_lemonadeUniqueId"] = "FYvZoWgWFYvZ" })
			I[4] = new("Frame", I[2], "Frame", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0, 3000, 1, 0) }, { ["_lemonadeUniqueId"] = "yzGKp2QqyzGK" })
			I[5] = new("Frame", I[2], "Frame", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.new(0, 3000, 1, 0) }, { ["_lemonadeUniqueId"] = "tdSsrZbltdSs" })
			I[6] = new("Frame", I[2], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromOffset(6880, 3000) }, { ["_lemonadeUniqueId"] = "1jmxjuRv1jmx" })
			I[7] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2 }, { ["_lemonadeUniqueId"] = "cs3i6S0kcs3i" })
	return I[1]
end

return build
