-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/Crosshair.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Crosshair", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.1, 0.1), ZIndex = 2 })
		I[2] = new("UIScale", I[1], "UIScale")
		I[3] = new("Frame", I[1], "Foreground", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[4] = new("ImageLabel", I[3], "Dot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://15085011006"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(2, 2) })
				I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[6] = new("ImageLabel", I[3], "Down", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://15085011006"), Position = UDim2.new(0.5, 0, 0.5, 8), Size = UDim2.fromOffset(2, 6) })
				I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[8] = new("ImageLabel", I[3], "Left", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://15085011006"), Position = UDim2.new(0.5, -8, 0.5, 0), Size = UDim2.fromOffset(6, 2) })
				I[9] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[10] = new("ImageLabel", I[3], "Right", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://15085011006"), Position = UDim2.new(0.5, 8, 0.5, 0), Size = UDim2.fromOffset(6, 2) })
				I[11] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[12] = new("ImageLabel", I[3], "Up", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://15085011006"), Position = UDim2.new(0.5, 0, 0.5, -8), Size = UDim2.fromOffset(2, 6) })
				I[13] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[14] = new("Frame", I[3], "Circle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(16, 16) })
				I[15] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
				I[16] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
		I[17] = new("Frame", I[1], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 0 })
			I[18] = new("ImageLabel", I[17], "Dot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://15085011006"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(2, 2) })
				I[19] = new("UIStroke", I[18], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 0 })
				I[20] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[21] = new("ImageLabel", I[17], "Down", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://15085011006"), ImageTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, 8), Size = UDim2.fromOffset(2, 6) })
				I[22] = new("UIStroke", I[21], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 0 })
				I[23] = new("UICorner", I[21], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[24] = new("ImageLabel", I[17], "Left", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://15085011006"), ImageTransparency = 1, Position = UDim2.new(0.5, -8, 0.5, 0), Size = UDim2.fromOffset(6, 2) })
				I[25] = new("UIStroke", I[24], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 0 })
				I[26] = new("UICorner", I[24], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[27] = new("ImageLabel", I[17], "Right", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://15085011006"), ImageTransparency = 1, Position = UDim2.new(0.5, 8, 0.5, 0), Size = UDim2.fromOffset(6, 2) })
				I[28] = new("UIStroke", I[27], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 0 })
				I[29] = new("UICorner", I[27], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[30] = new("ImageLabel", I[17], "Up", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://15085011006"), ImageTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, -8), Size = UDim2.fromOffset(2, 6) })
				I[31] = new("UIStroke", I[30], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 0 })
				I[32] = new("UICorner", I[30], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[33] = new("Frame", I[17], "Circle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(12, 12) })
				I[34] = new("UIStroke", I[33], "UIStroke", { Thickness = 0 })
				I[35] = new("UICorner", I[33], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
		I[36] = new("Frame", I[1], "Hitmarker", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
			I[37] = new("ImageLabel", I[36], "TL", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 50, 50), ImageContent = Content.fromUri("rbxassetid://13077299416"), Position = UDim2.new(0.5, -4, 0.5, -4), Size = UDim2.fromOffset(16, 16) })
			I[38] = new("ImageLabel", I[36], "TR", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 50, 50), ImageContent = Content.fromUri("rbxassetid://13077309724"), Position = UDim2.new(0.5, 4, 0.5, -4), Size = UDim2.fromOffset(16, 16) })
			I[39] = new("ImageLabel", I[36], "BR", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 50, 50), ImageContent = Content.fromUri("rbxassetid://13077309624"), Position = UDim2.new(0.5, 4, 0.5, 4), Size = UDim2.fromOffset(16, 16) })
			I[40] = new("ImageLabel", I[36], "BL", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 50, 50), ImageContent = Content.fromUri("rbxassetid://13077309526"), Position = UDim2.new(0.5, -4, 0.5, 4), Size = UDim2.fromOffset(16, 16) })
			I[41] = new("UIScale", I[36], "UIScale")
	return I[1]
end

return build
