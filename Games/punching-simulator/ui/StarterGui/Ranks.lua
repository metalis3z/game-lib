-- Generated from ui/StarterGui/Ranks.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Ranks", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 47, 182), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.6), Visible = false, ZIndex = 0 })
			I[3] = new("ImageButton", I[2], "Ranks", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://12489985753"), ImageTransparency = 1, Position = UDim2.fromScale(0.9954257, 0.0446514), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.09, 0.175), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 2, ZIndex = 6 }, nil, { "PopButton", "UIToggleButton" })
				I[4] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(-0.05, 0) })
				I[5] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[6] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.64, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(188, 4, 0)) }), Rotation = 90 })
				I[7] = new("UIStroke", I[3], "UIStroke", { Thickness = 3 })
				I[8] = new("ImageLabel", I[3], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13704067744"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.55, 0.55), ZIndex = 6 })
				I[9] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
			I[10] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
			I[11] = new("Frame", I[2], "Top", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.0473147), Size = UDim2.fromScale(1.0000002, 0.0946295) })
				I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 4 })
				I[13] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 248, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 144, 0)) }), Rotation = 90 })
			I[14] = new("Frame", I[2], "Dark", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.1, Position = UDim2.fromScale(0.5, 0.6519755), Size = UDim2.fromScale(0.98, 0.662), ZIndex = 5 })
				I[15] = new("TextLabel", I[14], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.498994, 0.6124153), Size = UDim2.fromScale(0.79, 0.1531691), Text = "30 minutes left to unlock!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
					I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 5 })
				I[17] = new("ImageLabel", I[14], "Icon", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://14487472249"), Position = UDim2.fromScale(0.5, 0.3320478), ScaleType = Enum.ScaleType.Fit, Selectable = true, Size = UDim2.fromScale(0.128525, 0.2937782), ZIndex = 9 })
			I[18] = new("TextLabel", I[2], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.055), Size = UDim2.fromScale(0.8, 0.06), Text = "ranks", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
				I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 2 })
				I[20] = new("TextLabel", I[18], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), Text = "ranks", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 2 })
			I[22] = new("Frame", I[2], "Pages", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 0.9) })
				I[23] = new("Frame", I[22], "DailyView", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 4, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[24] = new("Frame", I[23], "Content", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(157, 147, 238), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.4221137), Size = UDim2.fromScale(0.9750001, 0.7274184), ZIndex = 0 })
						I[25] = new("Frame", I[24], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 80, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.6131676), Size = UDim2.fromScale(1, 1.3105454), ZIndex = 0 })
							I[26] = new("Frame", I[25], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(157, 147, 238), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5764198), Size = UDim2.fromScale(1.0000001, 0.8471602) })
								I[27] = new("Frame", I[26], "Progress", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(20, 20, 20), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.4994269, 0.4580027), Size = UDim2.fromScale(0.7809719, 0.1378322) })
									I[28] = new("UIStroke", I[27], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
									I[29] = new("Frame", I[27], "Main", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 108, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1.0000001, 1) })
										I[30] = new("UIStroke", I[29], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
										I[31] = new("UIGradient", I[29], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 149, 0)), ColorSequenceKeypoint.new(0.4966667, Color3.fromRGB(255, 150, 56)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(238, 97, 43)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 0)) }), Rotation = 90 })
									I[32] = new("TextLabel", I[27], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.8), Text = "0/0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
										I[33] = new("UIStroke", I[32], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2.1040318 })
										I[34] = new("UITextSizeConstraint", I[32], "UITextSizeConstraint", { MaxTextSize = 35 })
			I[35] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.5383693 })
			I[36] = new("Frame", I[2], "A", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 80, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5539905), Size = UDim2.fromScale(0.9750001, 0.8579834), ZIndex = 0 })
				I[37] = new("TextLabel", I[36], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1227349, 0.3479752), Size = UDim2.fromScale(0.2, 0.0907796), Text = "Current:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[38] = new("UIStroke", I[37], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2.1040318 })
					I[39] = new("UITextSizeConstraint", I[37], "UITextSizeConstraint", { MaxTextSize = 35 })
				I[40] = new("TextLabel", I[36], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8750229, 0.3479752), Size = UDim2.fromScale(0.2, 0.0625), Text = "Next:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[41] = new("UIStroke", I[40], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2.1040318 })
					I[42] = new("UITextSizeConstraint", I[40], "UITextSizeConstraint", { MaxTextSize = 35 })
				I[43] = new("TextLabel", I[36], "C", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.122735, 0.4134966), Size = UDim2.fromScale(0.1482305, 0.075), Text = "Noob", TextColor3 = Color3.fromRGB(233, 255, 0), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[44] = new("UIStroke", I[43], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2.1040318 })
					I[45] = new("UITextSizeConstraint", I[43], "UITextSizeConstraint", { MaxTextSize = 35 })
				I[46] = new("TextLabel", I[36], "N", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8750229, 0.4134966), Size = UDim2.fromScale(0.1482305, 0.075), Text = "Pro", TextColor3 = Color3.fromRGB(30, 255, 0), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[47] = new("UIStroke", I[46], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2.1040318 })
					I[48] = new("UITextSizeConstraint", I[46], "UITextSizeConstraint", { MaxTextSize = 35 })
				I[49] = new("TextLabel", I[36], "T", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.499427, 0.6689666), Size = UDim2.fromScale(0.9, 0.074), Text = "💀 You need 4,999 more Kills to rank up 💀", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[50] = new("UIStroke", I[49], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2.1040318 })
					I[51] = new("UITextSizeConstraint", I[49], "UITextSizeConstraint", { MaxTextSize = 35 })
			I[52] = new("ImageButton", I[2], "ClaimBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13804213417"), Position = UDim2.fromScale(0.1925368, 0.8910641), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.3119135, 0.1264344), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
				I[53] = new("TextLabel", I[52], "Number", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(0.8520001, 0.45), Text = "CLAIM", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
					I[54] = new("UIStroke", I[53], "UIStroke", { Thickness = 1.5 })
			I[55] = new("Frame", I[2], "Bg", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 240, 255), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.499771, 0.8898416), Size = UDim2.fromScale(0.9503503, 0.1534433) })
				I[56] = new("UIStroke", I[55], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
				I[57] = new("UIGradient", I[55], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 24, 46)), ColorSequenceKeypoint.new(0.4966667, Color3.fromRGB(25, 25, 47)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 30, 51)), ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 51)) }), Rotation = 90 })
				I[58] = new("TextLabel", I[55], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6796231, 0.5046665), Size = UDim2.fromScale(0.6156079, 0.8305802), Text = "Come back every 6 hours to claim!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[59] = new("UIStroke", I[58], "UIStroke", { Thickness = 2 })
			I[60] = new("Frame", I[2], "Bg", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.3, BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.2923031, 0.2105878), Size = UDim2.fromScale(0.5022736, 0.156113) })
				I[61] = new("TextLabel", I[60], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5280828, 0.4891785), Size = UDim2.fromScale(0.8785682, 0.7870001), Text = "Rank up to unlock free titles and massive rewards!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[62] = new("UIStroke", I[61], "UIStroke", { Thickness = 2 })
				I[63] = new("UICorner", I[60], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
				I[64] = new("ImageLabel", I[60], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14486869174"), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(-0.0931658, -0.4590375) })
					I[65] = new("UIAspectRatioConstraint", I[64], "UIAspectRatioConstraint")
			I[66] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 47, 182), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4995208, 0.2197486), Size = UDim2.fromScale(0.9875002, 0.2117412), ZIndex = 0 })
			I[67] = new("Frame", I[2], "Bg", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.3, BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.7814591, 0.2105878), Size = UDim2.fromScale(0.4039165, 0.156113) })
				I[68] = new("TextLabel", I[67], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.589632, 0.4891785), Size = UDim2.fromScale(0.79, 0.85), Text = "10% chance of gettting a SUPER rare TITANIC!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[69] = new("UIStroke", I[68], "UIStroke", { Thickness = 2 })
				I[70] = new("UICorner", I[67], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
				I[71] = new("ImageLabel", I[67], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14487270120"), Position = UDim2.fromScale(0.0516454, 0.5000002), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(-0.218619, -0.870164) })
					I[72] = new("UIAspectRatioConstraint", I[71], "UIAspectRatioConstraint")
	return I[1]
end

return build
