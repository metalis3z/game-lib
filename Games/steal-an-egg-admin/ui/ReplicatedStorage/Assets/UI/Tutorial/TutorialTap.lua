-- Generated from ui/ReplicatedStorage/Assets/UI/Tutorial/TutorialTap.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "TutorialTap", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "XjRFw8WeXjRF" })
		I[2] = new("ImageLabel", I[1], "Arrow", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://101631932656609"), Position = UDim2.fromScale(1.1709576, -0.0715451), Rotation = -90, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.325, 1.1), ZIndex = 51 }, { ["_lemonadeUniqueId"] = "C9iuYfpzC9iu" })
		I[3] = new("Frame", I[1], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 49 }, { ["_lemonadeUniqueId"] = "F9hjR70mF9hj" })
			I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "GY202R4uGY20" })
			I[5] = new("UIScale", I[3], "UIScale", { Scale = 1.5 }, { ["_lemonadeUniqueId"] = "hDskgyOMhDsk" })
		I[6] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "MNIXQQAcMNIX" })
			I[7] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(255, 0, 0), Thickness = 4.1999998 }, { ["_lemonadeUniqueId"] = "gZiNCNxrgZiN" })
			I[8] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) }, { ["_lemonadeUniqueId"] = "suNwn3HnsuNw" })
			I[9] = new("UIStroke", I[6], "UIStroke_2", { Thickness = 6, ZIndex = 0 }, { ["_lemonadeUniqueId"] = "WKtdccJBWKtd" })
			I[10] = new("UIStroke", I[6], "UIStroke_3", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Thickness = 2.0999999, ZIndex = 0 }, { ["_lemonadeUniqueId"] = "Wu2dnsGmWu2d" })
	return I[1]
end

return build
