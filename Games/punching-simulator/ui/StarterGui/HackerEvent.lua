-- Generated from ui/StarterGui/HackerEvent.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "HackerEvent", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Main", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.525), Visible = false, ZIndex = 0 })
			I[3] = new("ImageButton", I[2], "HackerEvent", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://12489985753"), ImageTransparency = 1, Position = UDim2.fromScale(0.9823702, 0.0268938), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.1000238, 0.1750417), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton", "UIToggleButton" })
				I[4] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(-0.05, 0) })
				I[5] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[6] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.64, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(188, 4, 0)) }), Rotation = 90 })
				I[7] = new("UIStroke", I[3], "UIStroke", { Thickness = 3 })
				I[8] = new("ImageLabel", I[3], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13704067744"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.55, 0.55), ZIndex = 2 })
				I[9] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
			I[10] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.9469727 })
			I[11] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7317603, 0.1244968), Size = UDim2.fromScale(0.4677621, 0.0583095), Text = "v Kill 25 Players v", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 2 })
			I[13] = new("Frame", I[2], "Kills", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(9, 108, 0), Position = UDim2.fromScale(0.7317603, 0.2447561), Size = UDim2.fromScale(0.4049429, 0.1609309) })
				I[14] = new("ImageLabel", I[13], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14262761173"), Position = UDim2.fromScale(0.1218377, 0.4998382), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2002419, 0.7950761), ZIndex = 45 })
				I[15] = new("ImageLabel", I[13], "ProgressBar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12445578494"), Position = UDim2.fromScale(0.6, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.7, 0.5), SliceCenter = Rect.new(50, 47, 50, 47) })
					I[16] = new("ImageLabel", I[15], "Progress", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13873553599"), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.1679571, 1), SliceCenter = Rect.new(50, 47, 50, 47), ZIndex = 2 })
						I[17] = new("UIGradient", I[16], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.0011601, 0), NumberSequenceKeypoint.new(0.0023202, 1), NumberSequenceKeypoint.new(0.4709977, 1), NumberSequenceKeypoint.new(1, 1) }) })
					I[18] = new("TextLabel", I[15], "ProgressText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 0.75), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
						I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 2 })
						I[20] = new("UITextSizeConstraint", I[18], "UITextSizeConstraint", { MaxTextSize = 39 })
				I[21] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[22] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7330623, 0.9047305), Size = UDim2.fromScale(0.5, 0.0968195), Text = "Complete the Quests to claim for FREE!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[23] = new("UIStroke", I[22], "UIStroke", { Thickness = 2 })
			I[24] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2303523, 0.9061334), Size = UDim2.fromScale(0.3306376, 0.1645788), Text = "FREE!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
				I[25] = new("UIStroke", I[24], "UIStroke", { Thickness = 4 })
			I[26] = new("Frame", I[2], "Buttons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(9, 108, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.7325606, 0.7667772), Size = UDim2.fromScale(0.4228997, 0.1749867) })
				I[27] = new("UIListLayout", I[26], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[28] = new("ImageButton", I[26], "Hacker_Dominus", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 255, 0), ImageContent = Content.fromUri("rbxassetid://13804939232"), LayoutOrder = 3, Position = UDim2.fromScale(0.8235983, 0.5000002), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.3961768, 0.8228529), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton", "ProductButton" })
					I[29] = new("TextLabel", I[28], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000004, 0.4623573), Size = UDim2.fromScale(0.9, 0.6), Text = "R$ 1249", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
						I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 2 })
				I[31] = new("TextLabel", I[26], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5407643, 0.5), Size = UDim2.fromScale(0.1148607, 0.6038699), Text = "or", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[32] = new("UIStroke", I[31], "UIStroke", { Thickness = 2 })
				I[33] = new("ImageButton", I[26], "ClaimBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 255, 0), ImageContent = Content.fromUri("rbxassetid://13804939232"), Position = UDim2.fromScale(0.2579306, 0.5000002), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.396, 0.9), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
					I[34] = new("TextLabel", I[33], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000004, 0.4623573), Size = UDim2.fromScale(0.9, 0.8), Text = "Claim For Free!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
						I[35] = new("UIStroke", I[34], "UIStroke", { Thickness = 2 })
			I[36] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13859487181"), Position = UDim2.fromScale(0.4107764, 0.6401897), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1811181, 0.3125696), ZIndex = 4 })
			I[37] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14378065165"), Position = UDim2.fromScale(0.1866551, 0.4365695), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.311813, 0.6123832), ZIndex = 2 })
				I[38] = new("ImageLabel", I[37], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(254, 207, 239), ImageContent = Content.fromUri("rbxassetid://8574506083"), Position = UDim2.fromScale(0.6007835, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.3115617, 1.17) })
					I[39] = new("UIAspectRatioConstraint", I[38], "UIAspectRatioConstraint")
					I[40] = new("UIScale", I[38], "UIScale", { Scale = 0.9 })
			I[41] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(8, 155, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.7306051, 0.5224429), Size = UDim2.fromScale(0.5223772, 0.8924523), ZIndex = 0 })
			I[42] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7304582, 0.3899382), Size = UDim2.fromScale(0.4677621, 0.0583094), Text = "v Play for 60 minutes v", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[43] = new("UIStroke", I[42], "UIStroke", { Thickness = 2 })
			I[44] = new("Frame", I[2], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(9, 108, 0), Position = UDim2.fromScale(0.7304583, 0.5084087), Size = UDim2.fromScale(0.4049429, 0.1609309) })
				I[45] = new("ImageLabel", I[44], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13873482402"), Position = UDim2.fromScale(0.1218377, 0.4998382), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2002419, 0.7950761), ZIndex = 45 })
				I[46] = new("ImageLabel", I[44], "ProgressBar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12445578494"), Position = UDim2.fromScale(0.6, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.7, 0.5), SliceCenter = Rect.new(50, 47, 50, 47) })
					I[47] = new("ImageLabel", I[46], "Progress", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13873553599"), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.1679571, 1), SliceCenter = Rect.new(50, 47, 50, 47), ZIndex = 2 })
						I[48] = new("UIGradient", I[47], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.0011601, 0), NumberSequenceKeypoint.new(0.0023202, 1), NumberSequenceKeypoint.new(0.4709977, 1), NumberSequenceKeypoint.new(1, 1) }) })
					I[49] = new("TextLabel", I[46], "ProgressText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 0.75), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
						I[50] = new("UIStroke", I[49], "UIStroke", { Thickness = 2 })
						I[51] = new("UITextSizeConstraint", I[49], "UITextSizeConstraint", { MaxTextSize = 39 })
				I[52] = new("UICorner", I[44], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[53] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7304582, 0.6282396), Size = UDim2.fromScale(0.4677621, 0.0583094), Text = "------------------------------------------", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[54] = new("UIStroke", I[53], "UIStroke", { Thickness = 2 })
			I[55] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2303523, 1.0100834), Size = UDim2.fromScale(0.3306376, 0.0686375), Text = "x80 POWER", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
				I[56] = new("UIStroke", I[55], "UIStroke", { Thickness = 3 })
			I[57] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
	return I[1]
end

return build
