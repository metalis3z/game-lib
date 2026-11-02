-- Generated from ui/StarterGui/Rainbow Shovel/RainbowShovel.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "RainbowShovel", { Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageButton", I[1], "RobuxButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 61, 4), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.38, 0.7), Size = UDim2.fromScale(0.2, 0.1), ZIndex = 2 })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 3.24 })
			I[4] = new("Frame", I[2], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(22, 220, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.98, 0.95) })
				I[5] = new("ImageLabel", I[4], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://74198330006537"), Position = UDim2.fromScale(0.3, 0.5), Size = UDim2.fromScale(0.21, 0.7) })
				I[6] = new("TextLabel", I[4], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6, 0.5), RichText = true, Size = UDim2.fromScale(0.5, 0.8), Text = "5", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[7] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(0, 42, 4), Thickness = 2 })
				I[8] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
				I[9] = new("TextLabel", I[4], "porcentaje", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9, 0), RichText = true, Rotation = 20, Size = UDim2.fromScale(0.7, 0.8), Text = "95% OFF", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[10] = new("UIStroke", I[9], "UIStroke", { Color = Color3.fromRGB(0, 42, 4), Thickness = 2 })
					I[11] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.1747405, Color3.fromRGB(255, 157, 0)), ColorSequenceKeypoint.new(0.3615917, Color3.fromRGB(255, 238, 0)), ColorSequenceKeypoint.new(0.5380623, Color3.fromRGB(17, 255, 0)), ColorSequenceKeypoint.new(0.6972318, Color3.fromRGB(0, 255, 238)), ColorSequenceKeypoint.new(0.8356402, Color3.fromRGB(0, 17, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 0, 255)) }), Rotation = 30 })
			I[12] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
		I[13] = new("ImageButton", I[1], "MoneyButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 61, 4), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.62, 0.7), Size = UDim2.fromScale(0.2, 0.1) })
			I[14] = new("UIAspectRatioConstraint", I[13], "UIAspectRatioConstraint", { AspectRatio = 3.24 })
			I[15] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
			I[16] = new("Frame", I[13], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(22, 220, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.98, 0.95) })
				I[17] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
				I[18] = new("TextLabel", I[16], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0.9, 0.9), Text = "$50M", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[19] = new("UIStroke", I[18], "UIStroke", { Color = Color3.fromRGB(0, 42, 4), Thickness = 2 })
		I[20] = new("TextLabel", I[1], "Warn", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.8), RichText = true, Size = UDim2.fromScale(0.5, 0.08), Text = "IF YOU BUY IT FOR SHECKELS YOU WOULD LOST IT IF YOU LEAVE", TextColor3 = Color3.fromRGB(255, 200, 0), TextScaled = true, TextWrapped = true })
			I[21] = new("UIStroke", I[20], "UIStroke", { Color = Color3.fromRGB(66, 47, 0), Thickness = 2 })
			I[22] = new("UIAspectRatioConstraint", I[20], "UIAspectRatioConstraint", { AspectRatio = 10 })
	return I[1]
end

return build
