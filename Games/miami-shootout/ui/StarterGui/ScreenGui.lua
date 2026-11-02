-- Generated from ui/StarterGui/ScreenGui.rbxm by _tools/rbxm2lua.luau
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
		I[2] = new("TextButton", I[1], "TextButton", { BackgroundColor3 = Color3.fromRGB(67, 67, 67), FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.8784637, 0.0199501), Size = UDim2.fromOffset(132, 45), Text = "shop", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 33 })
			I[3] = new("UICorner", I[2], "UICorner")
		I[4] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(88, 88, 88), Position = UDim2.fromScale(0.5, 0.4862843), Size = UDim2.fromScale(0.5, 0.5), Visible = false })
			I[5] = new("ScrollingFrame", I[4], "Content", { Active = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 7), Position = UDim2.fromScale(0, 0.1), ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100), ScrollBarThickness = 0, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 0.9), VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar })
				I[6] = new("UIPadding", I[5], "UIPadding", { PaddingTop = UDim.new(0.005, 0) })
				I[7] = new("UIListLayout", I[5], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder })
			I[8] = new("Frame", I[4], "TitleBody", { BackgroundColor3 = Color3.fromRGB(38, 237, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.0975) })
				I[9] = new("TextLabel", I[8], "Title", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0418006, 0.5604278), Size = UDim2.fromScale(0.4074539, 0.7395251), Text = "gamepass shop", TextColor3 = Color3.fromRGB(235, 235, 235), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[10] = new("UICorner", I[8], "UICorner")
				I[11] = new("UIStroke", I[8], "UIStroke")
			I[12] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", { AspectRatio = 1.7268603 })
			I[13] = new("TextButton", I[4], "Exit", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4999098, 1.1325397), Size = UDim2.fromScale(0.2762524, 0.1825704), Text = "Exit", TextColor3 = Color3.fromRGB(222, 222, 222), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[14] = new("Frame", I[13], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.513965, 1.0172319), Size = UDim2.fromScale(0.972, 0.01) })
				I[15] = new("ImageLabel", I[13], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://3570695787"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5120707, 0.5017571), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.0008223, 1.0035137), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.12, ZIndex = 0 })
			I[16] = new("UICorner", I[4], "UICorner")
			I[17] = new("UIStroke", I[4], "UIStroke")
			I[18] = new("TextButton", I[4], "TextButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.3455657, 0.4330353), Size = UDim2.fromOffset(200, 50), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 54, TextStrokeColor3 = Color3.fromRGB(255, 255, 255) })
			I[19] = new("TextLabel", I[4], "Title", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1177744, 0.241479), Size = UDim2.fromScale(0.254897, 0.2516804), Text = "GlockDrumSwitch", TextColor3 = Color3.fromRGB(235, 235, 235), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[20] = new("TextLabel", I[4], "Title", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4277388, 0.1982703), Size = UDim2.fromScale(0.1441038, 0.1235441), Text = "Looting", TextColor3 = Color3.fromRGB(235, 235, 235), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[21] = new("TextButton", I[4], "TextButton", { BackgroundColor3 = Color3.fromRGB(52, 52, 52), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4169958, 0.2868616), Size = UDim2.fromOffset(100, 42), Text = "BUY", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
				I[22] = new("UICorner", I[21], "UICorner")
			I[23] = new("TextButton", I[4], "TextButton", { BackgroundColor3 = Color3.fromRGB(52, 52, 52), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.147074, 0.3107009), Size = UDim2.fromOffset(110, 28), Text = "BUY", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
				I[24] = new("UICorner", I[23], "UICorner")
			I[25] = new("TextLabel", I[4], "Title", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.091309, 0.8469176), Size = UDim2.fromScale(0.8441842, 0.2140738), Text = "after buying a gamepass leave the game and join back.", TextColor3 = Color3.fromRGB(235, 235, 235), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[26] = new("TextLabel", I[4], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.3404561, 0.3883365), Size = UDim2.fromOffset(200, 50), Text = "Auto Ingame", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20 })
			I[27] = new("TextLabel", I[4], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.0705343, 0.3883365), Size = UDim2.fromOffset(200, 50), Text = "/sg GlockDrumSwitch", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20 })
		I[28] = new("TextLabel", I[1], "Title", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5887826, 0.3678801), Size = UDim2.fromScale(0.088323, 0.0633291), Text = "Halloween22Drum", TextColor3 = Color3.fromRGB(235, 235, 235), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false })
		I[29] = new("TextButton", I[1], "TextButton", { BackgroundColor3 = Color3.fromRGB(52, 52, 52), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5921468, 0.4000308), Size = UDim2.fromOffset(100, 42), Text = "BUY", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Visible = false })
			I[30] = new("UICorner", I[29], "UICorner")
		I[31] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.5880834, 0.4692354), Size = UDim2.fromOffset(104, 28), Text = "/sg Halloween22Drum\n", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, Visible = false })
	return I[1]
end

return build
