-- Generated from ui/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main/RoundChoices.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "RoundChoices", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 43, 43), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1000, Position = UDim2.fromScale(0.5, -0.5), Selectable = true, Size = UDim2.fromScale(1.4, 0.5), Visible = false, ZIndex = -2 })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 2.5 })
		I[3] = new("ImageButton", I[1], "DropAsset", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 43, 43), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = -2 })
			I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
			I[5] = new("TextLabel", I[3], "Label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.7), Text = "Drop", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 0 })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 1.202963 }, { ["oldp_Thickness"] = 1.6 })
				I[7] = new("UIGradient", I[5], "UIGradient")
			I[8] = new("ImageLabel", I[3], "Pattern", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131176354845909"), ImageTransparency = 0.72, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1.0000001, 0.9999999), TileSize = UDim2.fromScale(0.8, 2), Visible = false, ZIndex = -1 })
			I[9] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 2.5 })
			I[10] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(88, 0, 0), Thickness = 1.8796296 }, { ["oldp_Thickness"] = 2.5 })
			I[11] = new("UISizeConstraint", I[3], "UISizeConstraint", { MaxSize = Vector2.new(math.huge, 100) })
			I[12] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 93, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 34, 86)) }), Enabled = false, Rotation = 90 })
			I[13] = new("UIScale", I[3], "ButtonUIScale")
		I[14] = new("ImageButton", I[1], "EscapeAndKeep", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(1.6125184, 0.4887811), Size = UDim2.fromScale(0.967259, 0.7787313), Visible = false, ZIndex = -2 })
			I[15] = new("UISizeConstraint", I[14], "UISizeConstraint", { MaxSize = Vector2.new(math.huge, 100) })
			I[16] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
			I[17] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(148, 148, 148), Thickness = 1.8796296 }, { ["oldp_Thickness"] = 2.5 })
				I[18] = new("UIGradient", I[17], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(47, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 157, 5)) }) })
			I[19] = new("TextLabel", I[14], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.7), Text = "Escape", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 0 })
				I[20] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(0, 144, 29), Thickness = 1.202963 }, { ["oldp_Thickness"] = 1.6 })
			I[21] = new("ImageLabel", I[14], "Pattern", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131176354845909"), ImageTransparency = 0.72, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1.0000001, 0.9999999), TileSize = UDim2.fromScale(0.8, 2), Visible = false, ZIndex = -1 })
			I[22] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(47, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 157, 5)) }), Rotation = 90 })
	return I[1]
end

return build
