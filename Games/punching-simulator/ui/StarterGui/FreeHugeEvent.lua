-- Generated from ui/StarterGui/FreeHugeEvent.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "FreeHugeEvent", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Main", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(244, 50, 0), Interactable = false, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.525), Visible = false, ZIndex = 0 })
			I[3] = new("ImageButton", I[2], "FreeHugeEvent", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://12489985753"), ImageTransparency = 1, Interactable = false, Position = UDim2.fromScale(0.9823702, 0.0268938), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.1000238, 0.1750417), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 2, Visible = false, ZIndex = 2 }, nil, { "PopButton", "UIToggleButton" })
				I[4] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(-0.05, 0) })
				I[5] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[6] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.64, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(188, 4, 0)) }), Rotation = 90 })
				I[7] = new("UIStroke", I[3], "UIStroke", { Thickness = 3 })
				I[8] = new("ImageLabel", I[3], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13704067744"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.55, 0.55), ZIndex = 2 })
				I[9] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
			I[10] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
			I[11] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.9469727 })
			I[12] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7317603, 0.1244968), Size = UDim2.fromScale(0.4677621, 0.0583095), Text = "v Kill 25 Players v", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 2 })
			I[14] = new("Frame", I[2], "Kills", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(137, 0, 5), Position = UDim2.fromScale(0.7317603, 0.2447561), Size = UDim2.fromScale(0.4049429, 0.1609309) })
				I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[16] = new("ImageLabel", I[14], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14262761173"), Position = UDim2.fromScale(0.1218377, 0.4998382), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2002419, 0.7950761), ZIndex = 45 })
				I[17] = new("ImageLabel", I[14], "ProgressBar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12445578494"), Position = UDim2.fromScale(0.6, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.7, 0.5), SliceCenter = Rect.new(50, 47, 50, 47) })
					I[18] = new("ImageLabel", I[17], "Progress", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13873553599"), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.1679571, 1), SliceCenter = Rect.new(50, 47, 50, 47), ZIndex = 2 })
						I[19] = new("UIGradient", I[18], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.0011601, 0), NumberSequenceKeypoint.new(0.0023202, 1), NumberSequenceKeypoint.new(0.4709977, 1), NumberSequenceKeypoint.new(1, 1) }) })
					I[20] = new("TextLabel", I[17], "ProgressText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 0.75), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
						I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 2 })
						I[22] = new("UITextSizeConstraint", I[20], "UITextSizeConstraint", { MaxTextSize = 39 })
			I[23] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7330623, 0.9047305), Size = UDim2.fromScale(0.5, 0.0968195), Text = "Complete the Quests to claim for FREE!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[24] = new("UIStroke", I[23], "UIStroke", { Thickness = 2 })
			I[25] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2303523, 0.9061334), Size = UDim2.fromScale(0.3306376, 0.1645788), Text = "FREE!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
				I[26] = new("UIStroke", I[25], "UIStroke", { Thickness = 4 })
			I[27] = new("Frame", I[2], "Buttons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(137, 0, 5), Position = UDim2.fromScale(0.7325606, 0.7667772), Size = UDim2.fromScale(0.4228997, 0.1749867) })
				I[28] = new("UICorner", I[27], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
				I[29] = new("UIListLayout", I[27], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[30] = new("ImageButton", I[27], "Huge_Cthulhu", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 255, 0), ImageContent = Content.fromUri("rbxassetid://13804939232"), LayoutOrder = 3, Position = UDim2.fromScale(0.8235983, 0.5000002), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.3961768, 0.8228529), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton", "ProductButton" })
					I[31] = new("TextLabel", I[30], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000004, 0.4623573), Size = UDim2.fromScale(0.9, 0.6), Text = "R$ 1249", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
						I[32] = new("UIStroke", I[31], "UIStroke", { Thickness = 2 })
				I[33] = new("TextLabel", I[27], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5407643, 0.5), Size = UDim2.fromScale(0.1148607, 0.6038699), Text = "or", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[34] = new("UIStroke", I[33], "UIStroke", { Thickness = 2 })
				I[35] = new("ImageButton", I[27], "ClaimBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 255, 0), ImageContent = Content.fromUri("rbxassetid://13804939232"), Position = UDim2.fromScale(0.2579306, 0.5000002), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.396, 0.9), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
					I[36] = new("TextLabel", I[35], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000004, 0.4623573), Size = UDim2.fromScale(0.9, 0.8), Text = "Claim For Free!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
						I[37] = new("UIStroke", I[36], "UIStroke", { Thickness = 2 })
			I[38] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13859487181"), Position = UDim2.fromScale(0.4107764, 0.6401897), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1811181, 0.3125696), ZIndex = 4 })
			I[39] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14263280136"), Position = UDim2.fromScale(0.1912018, 0.4085607), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.5561082, 1.0921649), ZIndex = 2 })
				I[40] = new("ImageLabel", I[39], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(254, 207, 239), ImageContent = Content.fromUri("rbxassetid://8574506083"), Position = UDim2.fromScale(0.6007835, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.3115617, 1.17) })
					I[41] = new("UIAspectRatioConstraint", I[40], "UIAspectRatioConstraint")
					I[42] = new("UIScale", I[40], "UIScale", { Scale = 0.9 })
			I[43] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(190, 16, 0), Position = UDim2.fromScale(0.7306051, 0.5224429), Size = UDim2.fromScale(0.5223772, 0.8924523), ZIndex = 0 })
				I[44] = new("UICorner", I[43], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
				I[45] = new("UIGradient", I[43], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(171, 171, 171)) }), Rotation = 90 })
			I[46] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7304582, 0.3899382), Size = UDim2.fromScale(0.4677621, 0.0583094), Text = "v Play for 60 minutes v", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[47] = new("UIStroke", I[46], "UIStroke", { Thickness = 2 })
			I[48] = new("Frame", I[2], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(137, 0, 5), Position = UDim2.fromScale(0.7304583, 0.5084087), Size = UDim2.fromScale(0.4049429, 0.1609309) })
				I[49] = new("UICorner", I[48], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[50] = new("ImageLabel", I[48], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13873482402"), Position = UDim2.fromScale(0.1218377, 0.4998382), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2002419, 0.7950761), ZIndex = 45 })
				I[51] = new("ImageLabel", I[48], "ProgressBar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12445578494"), Position = UDim2.fromScale(0.6, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.7, 0.5), SliceCenter = Rect.new(50, 47, 50, 47) })
					I[52] = new("ImageLabel", I[51], "Progress", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13873553599"), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.1679571, 1), SliceCenter = Rect.new(50, 47, 50, 47), ZIndex = 2 })
						I[53] = new("UIGradient", I[52], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.0011601, 0), NumberSequenceKeypoint.new(0.0023202, 1), NumberSequenceKeypoint.new(0.4709977, 1), NumberSequenceKeypoint.new(1, 1) }) })
					I[54] = new("TextLabel", I[51], "ProgressText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 0.75), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
						I[55] = new("UIStroke", I[54], "UIStroke", { Thickness = 2 })
						I[56] = new("UITextSizeConstraint", I[54], "UITextSizeConstraint", { MaxTextSize = 39 })
			I[57] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7304582, 0.6282396), Size = UDim2.fromScale(0.4677621, 0.0583094), Text = "------------------------------------------", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[58] = new("UIStroke", I[57], "UIStroke", { Thickness = 2 })
			I[59] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2303523, 1.0100834), Size = UDim2.fromScale(0.3306376, 0.0686375), Text = "x80 POWER", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
				I[60] = new("UIStroke", I[59], "UIStroke", { Thickness = 3 })
			I[61] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(50, 50, 50), Thickness = 5 })
	return I[1]
end

return build
