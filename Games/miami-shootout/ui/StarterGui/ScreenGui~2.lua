-- Generated from ui/StarterGui/ScreenGui~2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ScreenGui", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextButton", I[1], "TextButton", { BackgroundColor3 = Color3.fromRGB(68, 68, 68), BackgroundTransparency = 0.04, BorderColor3 = Color3.fromRGB(0, 0, 0), FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), LineHeight = 0.95, Position = UDim2.fromScale(0.8777227, 0.0835411), Size = UDim2.fromOffset(130, 40), Text = "settings", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 33, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true })
			I[3] = new("UICorner", I[2], "UICorner")
		I[4] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(88, 88, 88), Position = UDim2.fromScale(0.5, 0.4887781), Size = UDim2.fromScale(0.5, 0.5), Visible = false })
			I[5] = new("ScrollingFrame", I[4], "Content", { Active = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 7), Position = UDim2.fromScale(0, 0.1), ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100), ScrollBarThickness = 0, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 0.9), VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar })
				I[6] = new("UIPadding", I[5], "UIPadding", { PaddingTop = UDim.new(0.005, 0) })
				I[7] = new("UIListLayout", I[5], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder })
			I[8] = new("Frame", I[4], "TitleBody", { BackgroundColor3 = Color3.fromRGB(38, 237, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.0975) })
				I[9] = new("TextLabel", I[8], "Title", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0418006, 0.5604278), Size = UDim2.fromScale(0.4074539, 0.7395251), Text = "Settings/Help", TextColor3 = Color3.fromRGB(235, 235, 235), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[10] = new("UICorner", I[8], "UICorner")
				I[11] = new("UIStroke", I[8], "UIStroke")
			I[12] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", { AspectRatio = 1.7268603 })
			I[13] = new("TextButton", I[4], "Exit", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4999098, 1.1325397), Size = UDim2.fromScale(0.2762524, 0.1825704), Text = "Exit", TextColor3 = Color3.fromRGB(222, 222, 222), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[14] = new("Frame", I[13], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.513965, 1.0172319), Size = UDim2.fromScale(0.972, 0.01) })
				I[15] = new("ImageLabel", I[13], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://3570695787"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5120707, 0.5017571), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.0008223, 1.0035137), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.12, ZIndex = 0 })
			I[16] = new("Frame", I[4], "Low Graphics", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, Position = UDim2.fromScale(0.0196409, 0.1364947), Size = UDim2.fromScale(0.96, 0.1451019) })
				I[17] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
				I[18] = new("TextButton", I[16], "Low Poly", { AnchorPoint = Vector2.new(1, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4435027, 0.8511886), Size = UDim2.fromScale(0.412987, 0.7341994), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
					I[19] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
					I[20] = new("TextLabel", I[18], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(37, 246, 112), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000017, 0.4999859), Size = UDim2.fromScale(0.85, 0.5996499), Text = "Low Poly (Less Lag)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextTransparency = 0.3, TextWrapped = true })
					I[21] = new("UIStroke", I[18], "UIStroke")
				I[22] = new("TextButton", I[16], "Remove Nature", { AnchorPoint = Vector2.new(1, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.65, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9750664, 0.832328), Size = UDim2.fromScale(0.412987, 0.7341994), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
					I[23] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
					I[24] = new("TextLabel", I[22], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(37, 246, 112), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000017, 0.4999859), Size = UDim2.fromScale(0.85, 0.5996499), Text = "Remove Nature (Less Lag)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextTransparency = 0.3, TextWrapped = true })
				I[25] = new("UIStroke", I[16], "UIStroke")
			I[26] = new("Frame", I[4], "HideIcons", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, Position = UDim2.fromScale(0.0196409, 0.3110607), Size = UDim2.fromScale(0.96, 0.1451019) })
				I[27] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
				I[28] = new("TextButton", I[26], "Show Icons", { AnchorPoint = Vector2.new(1, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.61, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4435027, 0.8511886), Size = UDim2.fromScale(0.412987, 0.7341994), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
					I[29] = new("UICorner", I[28], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
					I[30] = new("TextLabel", I[28], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(37, 246, 112), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000017, 0.4999859), Size = UDim2.fromScale(0.85, 0.5996499), Text = "Show Icons", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextTransparency = 0.3, TextWrapped = true })
					I[31] = new("UIStroke", I[28], "UIStroke")
				I[32] = new("TextButton", I[26], "Remove Icons", { AnchorPoint = Vector2.new(1, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9750664, 0.832328), Size = UDim2.fromScale(0.412987, 0.7341994), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
					I[33] = new("UICorner", I[32], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
					I[34] = new("TextLabel", I[32], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000017, 0.4999859), Size = UDim2.fromScale(0.85, 0.5996499), Text = "Hide Icons", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextTransparency = 0.3, TextWrapped = true })
					I[35] = new("UIStroke", I[32], "UIStroke")
				I[36] = new("UIStroke", I[26], "UIStroke")
			I[37] = new("UICorner", I[4], "UICorner")
			I[38] = new("UIStroke", I[4], "UIStroke")
	return I[1]
end

return build
