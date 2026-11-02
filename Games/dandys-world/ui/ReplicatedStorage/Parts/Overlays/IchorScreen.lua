-- Generated from ui/ReplicatedStorage/Parts/Overlays/IchorScreen.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "IchorScreen", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Margin", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[3] = new("ImageLabel", I[2], "Splat", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://106386339851018"), Position = UDim2.fromScale(0.0329503, 0.1874318), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3518227, 0.6074049) })
				I[4] = new("UIScale", I[3], "UIScale")
			I[5] = new("ImageLabel", I[2], "Splat", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://106386339851018"), Position = UDim2.fromScale(0.9773134, 0.8111297), Rotation = 11, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3518227, 0.6074049) })
				I[6] = new("UIScale", I[5], "UIScale")
			I[7] = new("ImageLabel", I[2], "Splat", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://106386339851018"), Position = UDim2.fromScale(0.0651612, 0.9426401), Rotation = -114, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3518227, 0.6074049) })
				I[8] = new("UIScale", I[7], "UIScale")
			I[9] = new("ImageLabel", I[2], "Splat", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://106386339851018"), Position = UDim2.fromScale(0.8302841, -0.0619791), Size = UDim2.fromScale(0.3518227, 0.6074049) })
				I[10] = new("UIScale", I[9], "UIScale")
			I[11] = new("ImageLabel", I[2], "Splat", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://106386339851018"), Position = UDim2.fromScale(0.7291436, 1.0728484), Rotation = -114, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3518227, 0.6074049) })
				I[12] = new("UIScale", I[11], "UIScale")
	return I[1]
end

return build
