-- Generated from ui/StarterGui/Codes.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Codes", { DisplayOrder = 11, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 0, 0.4, 120) })
			I[3] = new("ImageLabel", I[2], "background", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(20, 58, 67), ImageContent = Content.fromUri("rbxassetid://116054484875156"), ImageTransparency = 0.95, Position = UDim2.fromScale(0, 1), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(171, 135), Visible = false })
				I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0.035, 0), BottomRightRadius = UDim.new(0.035, 0), TopLeftRadius = UDim.new(0.035, 0), TopRightRadius = UDim.new(0.035, 0) })
				I[5] = new("UIGradient", I[3], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3100872, 0.39375), NumberSequenceKeypoint.new(0.4956413, 0.59375), NumberSequenceKeypoint.new(0.7384807, 0.825), NumberSequenceKeypoint.new(1, 1) }) })
			I[6] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.55 })
			I[7] = new("ImageLabel", I[2], "SideIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://91842634041008"), Position = UDim2.fromScale(0.020337, 0.0037577), Rotation = -5, ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(0.116225, 8, 0.1967228, 8), ZIndex = 49 })
			I[8] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 0.75), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2589861, 0.0116279), Size = UDim2.fromScale(0.4069308, 0.1163887), Text = "Codes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 50 })
				I[9] = new("UIStroke", I[8], "UIStroke", { Color = Color3.fromRGB(42, 43, 49), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4.3000002 }, { ["oldp_Thickness"] = 5 })
			I[10] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(42, 43, 49), Thickness = 5.0999999 }, { ["oldp_Thickness"] = 7 })
			I[11] = new("Frame", I[2], "Bottom", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.3) })
				I[12] = new("ImageButton", I[11], "Claim", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126875624960627"), Position = UDim2.fromScale(0.5000001, 0.5851788), PressedImageContent = Content.fromUri("rbxassetid://124217248402069"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.35, 0.6796428), SliceCenter = Rect.new(20, 20, 80, 80), SliceScale = 1.1337963, ZIndex = 6 }, { ["oldp_SliceScale"] = 1 })
					I[13] = new("UIGradient", I[12], "green gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(92, 239, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 253, 28)) }), Rotation = -90 })
					I[14] = new("TextLabel", I[12], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.6), Text = "CLAIM!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
						I[15] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(0, 116, 14), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3.4013889 }, { ["oldp_Thickness"] = 3 })
					I[16] = new("ImageLabel", I[12], "ConsoleButton", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/DefaultController/ButtonA@2x.png"), Position = UDim2.fromScale(1, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.4), Visible = false, ZIndex = 10 }, { ["ConsoleButton"] = "ButtonX" })
						I[17] = new("UIAspectRatioConstraint", I[16], "UIAspectRatioConstraint")
					I[18] = new("UIScale", I[12], "ButtonUIScale")
			I[19] = new("Frame", I[2], "Input", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.75, BorderSizePixel = 0, Position = UDim2.fromScale(0.4985337, 0.5974545), Size = UDim2.fromScale(0.5467903, 0.168564), ZIndex = 50 })
				I[20] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 3 })
				I[21] = new("TextBox", I[19], "Input", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(255, 255, 255), PlaceholderText = "CODE...", Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.85), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 51 })
				I[22] = new("UICorner", I[19], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
			I[23] = new("TextLabel", I[2], "Desc", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.05), Size = UDim2.fromScale(0.9, 0.2008716), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextTransparency = 1, TextWrapped = true })
				I[24] = new("UIStroke", I[23], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Enabled = false, Thickness = 2.9000001, Transparency = 0.55 })
				I[25] = new("TextLabel", I[23], "Real", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.4428246), Size = UDim2.fromScale(0.9999999, 0.8403916), Text = "Check back for FREE codes every update!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true })
					I[26] = new("UIGradient", I[25], "RainbowGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 189, 85)), ColorSequenceKeypoint.new(0.0023545, Color3.fromRGB(255, 192, 84)), ColorSequenceKeypoint.new(0.1750661, Color3.fromRGB(112, 255, 102)), ColorSequenceKeypoint.new(0.2666033, Color3.fromRGB(96, 255, 255)), ColorSequenceKeypoint.new(0.3598675, Color3.fromRGB(23, 147, 255)), ColorSequenceKeypoint.new(0.4410419, Color3.fromRGB(107, 88, 255)), ColorSequenceKeypoint.new(0.5273977, Color3.fromRGB(164, 90, 255)), ColorSequenceKeypoint.new(0.606845, Color3.fromRGB(220, 92, 255)), ColorSequenceKeypoint.new(0.696655, Color3.fromRGB(220, 92, 255)), ColorSequenceKeypoint.new(0.786465, Color3.fromRGB(255, 83, 115)), ColorSequenceKeypoint.new(0.786465, Color3.fromRGB(255, 83, 115)), ColorSequenceKeypoint.new(0.8486412, Color3.fromRGB(255, 70, 70)), ColorSequenceKeypoint.new(0.9211801, Color3.fromRGB(255, 83, 115)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 189, 85)) }), Rotation = -1 }, { ["__gradient_style"] = "Wrapper" })
			I[27] = new("TextLabel", I[2], "Desc_2", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4985337, 0.2704648), Size = UDim2.fromScale(0.9, 0.1764016), Text = "Like & join the group to use codes! ", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true })
			I[28] = new("ImageButton", I[2], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.99, 0.022), Selectable = false, Size = UDim2.fromScale(0.0763118, 0.0953442), ZIndex = 5 })
				I[29] = new("TextLabel", I[28], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 15 })
					I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 2 })
				I[31] = new("ImageLabel", I[28], "DropShadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 4), ImageContent = Content.fromUri("rbxassetid://96735047582734"), ImageTransparency = 0.8, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.5088595, 1.7296873), SliceCenter = Rect.new(256, 256, 256, 256), SliceScale = 0.4, ZIndex = 12 })
				I[32] = new("UIAspectRatioConstraint", I[28], "UIAspectRatioConstraint", { AspectRatio = 1.1441339 })
				I[33] = new("ImageLabel", I[28], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://73214197551985"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = true, Size = UDim2.fromScale(1.1349496, 1.3059219), SliceCenter = Rect.new(64, 64, 64, 64), SliceScale = 0.2, ZIndex = 13 })
					I[34] = new("UIGradient", I[33], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 9, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 0, 8)) }), Rotation = 90 })
			I[35] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.07, 0), BottomRightRadius = UDim.new(0.07, 0), TopLeftRadius = UDim.new(0.07, 0), TopRightRadius = UDim.new(0.07, 0) })
		I[36] = new("UIPadding", I[1], "UIPadding", { PaddingTop = UDim.new(0, -12) })
	return I[1]
end

return build
