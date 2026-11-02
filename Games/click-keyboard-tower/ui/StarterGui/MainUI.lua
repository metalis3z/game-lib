-- Generated from ui/StarterGui/MainUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "MainUI", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "ShopFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.2256649, 0.2301796), Size = UDim2.fromScale(0.5486417, 0.588843), Visible = false })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
			I[4] = new("TextButton", I[2], "ShopToggle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9656728, 0.0438596), Size = UDim2.fromScale(0.1025554, 0.1760234), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
				I[6] = new("UIStroke", I[4], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[7] = new("UIScale", I[4], "UIScale")
				I[8] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint")
			I[9] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3417004, -0.1173115), Size = UDim2.fromScale(0.3151619, 0.1988304), Text = "KEY SOUNDS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
				I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 5 })
			I[11] = new("ScrollingFrame", I[2], "ScrollingFrame", { Active = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0238501, 0.131579), ScrollBarThickness = 9, Size = UDim2.fromScale(0.9642249, 0.8684211) })
				I[12] = new("Frame", I[11], "CreamyFrame", { BackgroundColor3 = Color3.fromRGB(182, 182, 182), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1024896, 0.0214742), Size = UDim2.fromScale(0.2482145, 0.2368999) })
					I[13] = new("UICorner", I[12], "UICorner")
					I[14] = new("TextLabel", I[12], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.041, -0.046), SelectionOrder = 1, Size = UDim2.fromScale(0.912606, 0.2443506), Text = "CREAMY KEYS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
						I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 4 })
						I[16] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 49, 49)) }) })
					I[17] = new("UIStroke", I[12], "UIStroke", { Thickness = 3 })
					I[18] = new("ImageLabel", I[12], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://76697449031687"), Position = UDim2.fromScale(-0.0023817, 0.0399196), Size = UDim2.fromOffset(282, 257) })
						I[19] = new("UIAspectRatioConstraint", I[18], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize })
						I[20] = new("UIScale", I[18], "UIScale")
					I[21] = new("TextButton", I[12], "ClaimButton", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0609911, 0.6749647), Size = UDim2.fromScale(0.8757435, 0.2670539), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 35, TextStrokeTransparency = 0, ZIndex = 4 })
						I[22] = new("UICorner", I[21], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
						I[23] = new("UIStroke", I[21], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
						I[24] = new("TextLabel", I[21], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1818182, 0.0952381), RichText = true, Size = UDim2.fromScale(0.6293706, 0.8095238), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextStrokeTransparency = 0 })
							I[25] = new("UIStroke", I[24], "UIStroke", { Thickness = 2 })
				I[26] = new("Frame", I[11], "ThockyFrame", { BackgroundColor3 = Color3.fromRGB(182, 182, 182), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.3706557, 0.0213336), Selectable = true, Size = UDim2.fromScale(0.248, 0.237) })
					I[27] = new("UICorner", I[26], "UICorner")
					I[28] = new("TextLabel", I[26], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.041, -0.046), SelectionOrder = 1, Size = UDim2.fromScale(0.912606, 0.2443506), Text = "THOCKY KEYS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
						I[29] = new("UIStroke", I[28], "UIStroke", { Thickness = 4 })
						I[30] = new("UIGradient", I[28], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 248, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 49, 49)) }) })
					I[31] = new("TextButton", I[26], "SaleButton", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0609911, 0.6749647), Size = UDim2.fromScale(0.8757435, 0.2670539), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 35, TextStrokeTransparency = 0, ZIndex = 4 })
						I[32] = new("UICorner", I[31], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
						I[33] = new("UIStroke", I[31], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
						I[34] = new("TextLabel", I[31], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1818182, 0.0952381), RichText = true, Size = UDim2.fromScale(0.6293706, 0.8095238), Text = " 99", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextStrokeTransparency = 0 })
							I[35] = new("UIStroke", I[34], "UIStroke", { Thickness = 2 })
					I[36] = new("UIStroke", I[26], "UIStroke", { Thickness = 3 })
					I[37] = new("ImageLabel", I[26], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://110878601861468"), Position = UDim2.fromScale(-0.0138142, 0.0392833), Size = UDim2.fromOffset(282, 257) })
						I[38] = new("UIAspectRatioConstraint", I[37], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize })
						I[39] = new("UIScale", I[37], "UIScale")
				I[40] = new("Frame", I[11], "HoneyFrame", { BackgroundColor3 = Color3.fromRGB(182, 182, 182), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.6386557, 0.0213336), Selectable = true, Size = UDim2.fromScale(0.248, 0.237) })
					I[41] = new("UICorner", I[40], "UICorner")
					I[42] = new("TextLabel", I[40], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.041, -0.046), SelectionOrder = 1, Size = UDim2.fromScale(0.912606, 0.2443506), Text = "HONEY KEYS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
						I[43] = new("UIStroke", I[42], "UIStroke", { Thickness = 4 })
						I[44] = new("UIGradient", I[42], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 49, 49)) }) })
					I[45] = new("TextButton", I[40], "ClaimButton", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0609911, 0.6749647), Size = UDim2.fromScale(0.8757435, 0.2670539), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 35, TextStrokeTransparency = 0, ZIndex = 4 })
						I[46] = new("UICorner", I[45], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
						I[47] = new("TextLabel", I[45], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1818182, 0.0952381), RichText = true, Size = UDim2.fromScale(0.6293706, 0.8095238), Text = " 99", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextStrokeTransparency = 0 })
							I[48] = new("UIStroke", I[47], "UIStroke", { Thickness = 2 })
						I[49] = new("UIStroke", I[45], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
					I[50] = new("UIStroke", I[40], "UIStroke", { Thickness = 3 })
					I[51] = new("ImageLabel", I[40], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://137832994771726"), Position = UDim2.fromScale(0.0202874, 0.0598499), Size = UDim2.fromOffset(246, 240) })
						I[52] = new("UIAspectRatioConstraint", I[51], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize })
						I[53] = new("UIScale", I[51], "UIScale")
			I[54] = new("UIStroke", I[2], "UIStroke", { Thickness = 3 })
			I[55] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(79, 204, 229)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Rotation = 90 })
		I[56] = new("TextButton", I[1], "Admin", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(136, 229, 226), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0501094, 0.4999387), Size = UDim2.fromScale(0.0561562, 0.1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[57] = new("UICorner", I[56], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
			I[58] = new("UIStroke", I[56], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 4.8000002 })
			I[59] = new("UIScale", I[56], "UIScale")
			I[60] = new("UIAspectRatioConstraint", I[56], "UIAspectRatioConstraint")
			I[61] = new("TextLabel", I[56], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0090151, 0.042954), Size = UDim2.fromScale(1, 1), Text = "admin", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 32, TextWrapped = true })
				I[62] = new("UIScale", I[61], "UIScale")
				I[63] = new("UIStroke", I[61], "UIStroke", { Color = Color3.fromRGB(59, 144, 180), Thickness = 2.3 })
				I[64] = new("UIAspectRatioConstraint", I[61], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize })
	return I[1]
end

return build
