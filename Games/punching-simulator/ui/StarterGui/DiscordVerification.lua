-- Generated from ui/StarterGui/DiscordVerification.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "DiscordVerification", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Main", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(65, 84, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.525), Visible = false, ZIndex = 0 })
			I[3] = new("ImageButton", I[2], "DiscordVerification", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://12489985753"), ImageTransparency = 1, Position = UDim2.fromScale(0.9823702, 0.0268938), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.1000238, 0.1750417), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 2, ZIndex = 6 }, nil, { "PopButton", "UIToggleButton" })
				I[4] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(-0.05, 0) })
				I[5] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[6] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.64, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(188, 4, 0)) }), Rotation = 90 })
				I[7] = new("UIStroke", I[3], "UIStroke", { Thickness = 3 })
				I[8] = new("ImageLabel", I[3], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13704067744"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.55, 0.55), ZIndex = 7 })
				I[9] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
			I[10] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.9469727 })
			I[11] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1647152, 0.9036276), Size = UDim2.fromScale(0.3306376, 0.1645788), Text = "FREE!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
				I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 4 })
			I[13] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13859487181"), Position = UDim2.fromScale(0.3605833, 0.74042), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1811181, 0.3125696), ZIndex = 4 })
			I[14] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14391299698"), Position = UDim2.fromScale(0.1686371, 0.3939717), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.301517, 0.5921625), ZIndex = 2 })
				I[15] = new("ImageLabel", I[14], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(254, 207, 239), ImageContent = Content.fromUri("rbxassetid://8574506083"), Position = UDim2.fromScale(0.6007835, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.3115617, 1.17) })
					I[16] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint")
					I[17] = new("UIScale", I[15], "UIScale", { Scale = 0.9 })
			I[18] = new("Frame", I[2], "H", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(58, 70, 213), BorderSizePixel = 0, Position = UDim2.fromScale(0.7083305, 0.5224429), Size = UDim2.fromScale(0.5669264, 0.8924523), ZIndex = 0 })
				I[19] = new("TextBox", I[18], "TextBox", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(203, 203, 203), PlaceholderText = "Enter Code", Position = UDim2.fromScale(0.3130777, 0.876), RichText = true, Size = UDim2.fromScale(0.5289215, 0.1283372), Text = "", TextColor3 = Color3.fromRGB(30, 30, 30), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[20] = new("ImageLabel", I[19], "Bg", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13763145948"), Position = UDim2.fromScale(0.5000001, 0.3746796), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.1, 1.3693759), SliceCenter = Rect.new(23, 21, 27, 33) })
			I[21] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7074261, 0.6824597), Size = UDim2.fromScale(0.4677621, 0.0583094), Text = "------------------------------------------", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[22] = new("UIStroke", I[21], "UIStroke", { Thickness = 2 })
			I[23] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
			I[24] = new("ImageButton", I[2], "VerifyBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 255, 0), ImageContent = Content.fromUri("rbxassetid://13804939232"), Position = UDim2.fromScale(0.8843183, 0.85), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.1924749, 0.1491036), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
				I[25] = new("TextLabel", I[24], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000004, 0.4623573), Size = UDim2.fromScale(0.8, 0.8), Text = "Verify", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
					I[26] = new("UIStroke", I[25], "UIStroke", { Thickness = 2 })
				I[27] = new("UIPadding", I[24], "UIPadding", { PaddingBottom = UDim.new(0.05, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.05, 0) })
			I[28] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(58, 70, 213), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.7059699, 0.3711767), Size = UDim2.fromScale(0.4952788, 0.4817417), ZIndex = 0 })
				I[29] = new("UIListLayout", I[28], "UIListLayout", { Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[30] = new("TextLabel", I[28], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4508797, 0.1232627), Size = UDim2.fromScale(1.0433395, 0.2465254), Text = "1. Join discord.gg/hotsimulators", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[31] = new("UIStroke", I[30], "UIStroke", { Thickness = 2 })
				I[32] = new("TextLabel", I[28], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5027484, 0.4327016), Size = UDim2.fromScale(0.9029861, 0.2723527), Text = "2. Go to #🎁┃game-reward", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[33] = new("UIStroke", I[32], "UIStroke", { Thickness = 2 })
				I[34] = new("TextLabel", I[28], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5216698, 0.7834962), Size = UDim2.fromScale(1.0433396, 0.3292363), Text = "3. Enter the code that you will find in the channel below", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[35] = new("UIStroke", I[34], "UIStroke", { Thickness = 2 })
			I[36] = new("Frame", I[2], "Verified", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.11, BorderSizePixel = 0, Position = UDim2.fromScale(0.7083305, 0.5224429), Size = UDim2.fromScale(0.5669264, 0.8924523), Visible = false, ZIndex = 5 })
				I[37] = new("ImageLabel", I[36], "Checkmark", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 255, 0), ImageContent = Content.fromUri("rbxassetid://14292339333"), Position = UDim2.fromScale(0.5153084, 0.3324595), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3456638, 0.3729003), ZIndex = 7 })
					I[38] = new("UIAspectRatioConstraint", I[37], "UIAspectRatioConstraint")
					I[39] = new("UIScale", I[37], "UIScale", { Scale = 0.75 })
				I[40] = new("TextLabel", I[36], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5132965, 0.5975862), Size = UDim2.fromScale(0.5914731, 0.1645788), Text = "Verified!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
					I[41] = new("UIStroke", I[40], "UIStroke", { Thickness = 4 })
	return I[1]
end

return build
