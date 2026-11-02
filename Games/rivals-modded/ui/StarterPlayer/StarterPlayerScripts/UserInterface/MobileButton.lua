-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/MobileButton.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "MobileButton", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.new(1, -190, 1, -125), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(100, 100) })
		I[2] = new("ImageButton", I[1], "Resize", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13715299164"), Position = UDim2.fromScale(0.15, 0.15), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(20, 20), Visible = false, ZIndex = 4 })
		I[3] = new("ImageLabel", I[1], "IconContainer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16793449322"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(1, -2, 1, -2), ZIndex = 0 })
			I[4] = new("ImageLabel", I[3], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://13695061446"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(1, 2, 1, 2) })
		I[5] = new("ImageLabel", I[1], "Weapon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(3, 3) })
		I[6] = new("ImageLabel", I[1], "Invisible", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(127, 25, 25), ImageContent = Content.fromUri("rbxassetid://98733034699805"), ImageTransparency = 0.25, Position = UDim2.fromScale(0.5, 0.5), Rotation = 90, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(50, 50), ZIndex = 3 })
			I[7] = new("ImageLabel", I[6], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://110479459772264"), Position = UDim2.fromScale(0.5, 1), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(30, 45), Visible = false, ZIndex = 2 })
			I[8] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[9] = new("Frame", I[6], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(127, 25, 25), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[11] = new("UIGradient", I[9], "UIGradient", { Rotation = -90 })
			I[12] = new("UIGradient", I[6], "UIGradient", { Rotation = -90 })
		I[13] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
		I[14] = new("Frame", I[1], "Ammo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
			I[15] = new("ImageLabel", I[14], "Icon", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16539130428"), Position = UDim2.fromScale(0.925, 0.8), Size = UDim2.fromScale(0.15, 0.15) })
			I[16] = new("TextLabel", I[14], "Title", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.75, 0.76), RichText = true, Size = UDim2.fromScale(1.8, 0.3), Text = "20", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
				I[17] = new("UIStroke", I[16], "UIStroke", { Transparency = 0.875 })
	return I[1]
end

return build
