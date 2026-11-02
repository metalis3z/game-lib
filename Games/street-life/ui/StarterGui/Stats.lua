-- Generated from ui/StarterGui/Stats.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Stats", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Money", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.8538464, 0.0124069), Size = UDim2.fromScale(0.058, 0.038) })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
			I[4] = new("ImageLabel", I[2], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://16276978537"), Position = UDim2.fromScale(0.0489897, 0.0627581), Size = UDim2.fromScale(0.3, 0.84) })
				I[5] = new("UICorner", I[4], "UICorner")
			I[6] = new("TextLabel", I[2], "Amount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3578345, 0.0627581), RichText = true, Size = UDim2.fromScale(0.6421672, 0.8398508), Text = "$500", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[7] = new("UITextSizeConstraint", I[6], "UITextSizeConstraint", { MaxTextSize = 25, MinTextSize = 5 })
			I[8] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
		I[9] = new("Frame", I[1], "Stamina", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0192061, 0.9441687), Size = UDim2.fromScale(0.128041, 0.0186104) })
			I[10] = new("Frame", I[9], "Color", { BackgroundColor3 = Color3.fromRGB(0, 255, 247), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
				I[11] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
				I[12] = new("UIStroke", I[10], "UIStroke")
			I[13] = new("UIStroke", I[9], "UIStroke", { Thickness = 3 })
			I[14] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
			I[15] = new("ImageLabel", I[9], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 255, 247), ImageContent = Content.fromUri("rbxassetid://3926305904"), ImageRectOffset = Vector2.new(844, 804), ImageRectSize = Vector2.new(36, 36), Position = UDim2.fromScale(1.033, -0.393), Size = UDim2.fromScale(0.128, 1.6670001), ZIndex = 2 })
		I[16] = new("Frame", I[1], "Health", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0192061, 0.91067), Size = UDim2.fromScale(0.128041, 0.0186104) })
			I[17] = new("Frame", I[16], "Color", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
				I[18] = new("UIStroke", I[17], "UIStroke")
				I[19] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
			I[20] = new("UIStroke", I[16], "UIStroke", { Thickness = 3 })
			I[21] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
			I[22] = new("ImageLabel", I[16], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 255, 0), ImageContent = Content.fromUri("rbxassetid://3926305904"), ImageRectOffset = Vector2.new(964, 444), ImageRectSize = Vector2.new(36, 36), Position = UDim2.fromScale(1.028, -0.367), Size = UDim2.fromScale(0.128, 1.6670001), ZIndex = 2 })
			I[23] = new("Frame", I[16], "Extra", { BackgroundColor3 = Color3.fromRGB(67, 255, 183), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0, 1), Visible = false })
				I[24] = new("UICorner", I[23], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
				I[25] = new("UIStroke", I[23], "UIStroke")
		I[26] = new("Frame", I[1], "Bank", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.9203997, 0.0124069), Size = UDim2.fromScale(0.058, 0.038) })
			I[27] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
			I[28] = new("ImageLabel", I[26], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://16276975885"), Position = UDim2.fromScale(0.0489897, 0.0627581), Size = UDim2.fromScale(0.3, 0.84) })
				I[29] = new("UICorner", I[28], "UICorner")
			I[30] = new("TextLabel", I[26], "Amount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3578345, 0.0627581), RichText = true, Size = UDim2.fromScale(0.6421672, 0.8398508), Text = "$500", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[31] = new("UITextSizeConstraint", I[30], "UITextSizeConstraint", { MaxTextSize = 25, MinTextSize = 5 })
			I[32] = new("UIStroke", I[26], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
		I[33] = new("Frame", I[1], "XP", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0192061, 0.8771712), Size = UDim2.fromScale(0.128041, 0.0186104) })
			I[34] = new("Frame", I[33], "Color", { BackgroundColor3 = Color3.fromRGB(149, 0, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
				I[35] = new("UICorner", I[34], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
				I[36] = new("UIStroke", I[34], "UIStroke")
			I[37] = new("UIStroke", I[33], "UIStroke", { Thickness = 3 })
			I[38] = new("UICorner", I[33], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
			I[39] = new("ImageLabel", I[33], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(149, 0, 255), ImageContent = Content.fromUri("rbxassetid://3926305904"), ImageRectOffset = Vector2.new(116, 4), ImageRectSize = Vector2.new(24, 24), Position = UDim2.fromScale(1.027872, -0.3930013), Size = UDim2.fromScale(0.128, 1.6670001), ZIndex = 2 })
		I[40] = new("TextLabel", I[1], "CLog", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0192061, 0.8387097), Size = UDim2.fromScale(0.128041, 0.0310174), Text = "COMBAT LOGGED", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
	return I[1]
end

return build
