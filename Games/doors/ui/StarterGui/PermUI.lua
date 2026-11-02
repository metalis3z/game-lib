-- Generated from ui/StarterGui/PermUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "PermUI", { DisplayOrder = 10, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("ImageLabel", I[1], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(49, 42, 38), ImageContent = Content.fromUri("rbxassetid://61997378"), Position = UDim2.fromScale(1, 1), Size = UDim2.fromScale(0.3, 0.4), ZIndex = -99 })
		I[3] = new("Frame", I[1], "Stats", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(38, 38, 38), BackgroundTransparency = 1, Position = UDim2.fromScale(1.25, 1.25), Size = UDim2.new(0.15, 80, 0.15, 80), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
			I[4] = new("TextLabel", I[3], "Revives", { AnchorPoint = Vector2.new(1, 1), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(4, 4, 4), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.new(1, -10, 1, -10), Size = UDim2.fromScale(1, 0.25), Text = "3", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 100, TextStrokeColor3 = Color3.fromRGB(59, 59, 59), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
				I[5] = new("Sound", I[4], "SoundIncrease", { Volume = 0.4 })
				I[6] = new("Sound", I[4], "SoundDecrease", { PlaybackSpeed = 1.5, Volume = 0.4 })
				I[7] = new("ImageLabel", I[4], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7102850544"), Position = UDim2.fromScale(1.275, 0.525), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.2, 1.2), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[8] = new("UIPadding", I[4], "UIPadding", { PaddingRight = UDim.new(0.25, 0) })
			I[9] = new("UIListLayout", I[3], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[10] = new("TextLabel", I[3], "Gold", { AnchorPoint = Vector2.new(1, 1), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(4, 4, 4), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.new(1, -10, 1, -10), Size = UDim2.fromScale(1, 0.25), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 100, TextStrokeColor3 = Color3.fromRGB(59, 59, 59), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false })
				I[11] = new("Sound", I[10], "SoundIncrease", { Volume = 0.4 })
				I[12] = new("Sound", I[10], "SoundDecrease", { PlaybackSpeed = 1.5, Volume = 0.4 })
				I[13] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(116, 69, 59), Enabled = false, Thickness = 2.8, Transparency = 0.5 })
				I[14] = new("UIPadding", I[10], "UIPadding", { PaddingRight = UDim.new(0.25, 0) })
				I[15] = new("ImageLabel", I[10], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7102843132"), Position = UDim2.fromScale(1.275, 0.525), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[16] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(0, 10), PaddingRight = UDim.new(0.05, 15) })
			I[17] = new("TextLabel", I[3], "Knobs", { AnchorPoint = Vector2.new(1, 1), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(4, 4, 4), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.new(1, -10, 1, -10), Size = UDim2.fromScale(1, 0.25), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 100, TextStrokeColor3 = Color3.fromRGB(59, 59, 59), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false })
				I[18] = new("Sound", I[17], "SoundIncrease", { PlaybackSpeed = 1.2, Volume = 0.2 })
				I[19] = new("Sound", I[17], "SoundDecrease", { PlaybackSpeed = 0.8, Volume = 0.4 })
				I[20] = new("UIStroke", I[17], "UIStroke", { Color = Color3.fromRGB(116, 69, 59), Enabled = false, Thickness = 2.8, Transparency = 0.5 })
				I[21] = new("UIPadding", I[17], "UIPadding", { PaddingRight = UDim.new(0.25, 0) })
				I[22] = new("ImageLabel", I[17], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7152862528"), Position = UDim2.fromScale(1.275, 0.525), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
		I[23] = new("Frame", I[1], "Hints", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(24, 10, 7), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(0.02, -10, 0.95, -20), Size = UDim2.new(0.1, 50, 0.3, 150), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[24] = new("UIListLayout", I[23], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[25] = new("UIPadding", I[23], "UIPadding", { PaddingBottom = UDim.new(0.05, 0), PaddingLeft = UDim.new(0.05, 0) })
			I[26] = new("ImageLabel", I[23], "Template", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 228, 190), ImageContent = Content.fromUri("rbxassetid://12940047610"), ImageRectOffset = Vector2.new(600, 0), ImageRectSize = Vector2.new(50, 50), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.125, 0.125), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
				I[27] = new("TextLabel", I[26], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(4, 4, 4), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SpecialElite.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(1.25, 0.5), Size = UDim2.fromScale(1, 1), Text = "1", TextColor3 = Color3.fromRGB(255, 228, 190), TextScaled = true, TextSize = 100, TextStrokeColor3 = Color3.fromRGB(59, 59, 59), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
					I[28] = new("UIPadding", I[27], "UIPadding", { PaddingTop = UDim.new(0.2, 0) })
				I[29] = new("TextLabel", I[26], "Equals", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(4, 4, 4), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SpecialElite.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(1.35, 0.5), Size = UDim2.fromScale(0.4, 1), Text = "=", TextColor3 = Color3.fromRGB(255, 228, 190), TextScaled = true, TextSize = 100, TextStrokeColor3 = Color3.fromRGB(59, 59, 59), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
					I[30] = new("UIPadding", I[29], "UIPadding", { PaddingBottom = UDim.new(0.1, 0) })
				I[31] = new("ImageLabel", I[26], "User", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=6&w=48&h=48"), ImageRectSize = Vector2.new(50, 50), ImageTransparency = 0.25, Position = UDim2.fromScale(2.4000001, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.8), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false, ZIndex = 0 })
					I[32] = new("UICorner", I[31], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[33] = new("ImageButton", I[1], "VoiceChatIcon", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(38, 25, 25), BackgroundTransparency = 0.3, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageTransparency = 1, Position = UDim2.fromOffset(178, 4), Size = UDim2.fromOffset(32, 32), Visible = false, ZIndex = 1155 })
			I[34] = new("UICorner", I[33], "UICorner", { BottomLeftRadius = UDim.new(0, 9), BottomRightRadius = UDim.new(0, 9), TopLeftRadius = UDim.new(0, 9), TopRightRadius = UDim.new(0, 9) })
			I[35] = new("ImageLabel", I[33], "ImageLabel", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 222, 189), ImageContent = Content.fromUri("rbxassetid://11666779172"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2000 })
			I[36] = new("UIStroke", I[33], "UIStroke", { Color = Color3.fromRGB(255, 222, 189), Thickness = 2 })
		I[37] = new("ImageLabel", I[1], "Gold", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7102843132"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(60, 60), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
			I[38] = new("Sound", I[37], "Sound", { Volume = 0.15 })
		I[39] = new("Frame", I[1], "Topbar", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -12, 0, 12), Size = UDim2.new(1, 0, 0, 36), ZIndex = -9 })
			I[40] = new("UIPadding", I[39], "UIPadding", { PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), PaddingTop = UDim.new(0, 2) })
			I[41] = new("UIListLayout", I[39], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 56), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[42] = new("TextLabel", I[39], "Boosts", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(4, 4, 4), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 6, Position = UDim2.new(1, -10, 1, -10), Size = UDim2.new(0, 11, 1, 0), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 30, TextStrokeTransparency = 0.9, TextXAlignment = Enum.TextXAlignment.Left, Visible = false }, { ["FadeDecrease"] = Color3.fromRGB(255, 136, 0), ["FadeIncrease"] = Color3.fromRGB(255, 250, 76) })
				I[43] = new("Sound", I[42], "SoundIncrease", { PlaybackSpeed = 2, Volume = 0 })
				I[44] = new("Sound", I[42], "SoundDecrease", { PlaybackSpeed = 0.9, Volume = 0.03 })
				I[45] = new("UIStroke", I[42], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Enabled = false, Transparency = 1 })
				I[46] = new("ImageLabel", I[42], "Icon", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://10448639430"), Position = UDim2.new(0, -5, 0.525, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.2, 1.2), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[47] = new("Frame", I[42], "Frame", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(59, 25, 6), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(1, 10, 0.5, 0), Size = UDim2.new(1, 40, 0.9, 0), ZIndex = -9 })
					I[48] = new("UICorner", I[47], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[49] = new("UIGradient", I[47], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 183, 183)) }), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6125), NumberSequenceKeypoint.new(0.3757862, 0), NumberSequenceKeypoint.new(1, 0) }) })
					I[50] = new("UIStroke", I[47], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 222, 189), Enabled = false, Thickness = 2, Transparency = 0.7 })
						I[51] = new("UIGradient", I[50], "UIGradient")
			I[52] = new("UIScale", I[39], "UIScale")
			I[53] = new("TextLabel", I[39], "Knobs", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(4, 4, 4), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 4, Position = UDim2.new(1, -10, 1, -10), Size = UDim2.new(0, 13, 1, 0), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 30, TextStrokeTransparency = 0.9, TextXAlignment = Enum.TextXAlignment.Left, Visible = false }, { ["FadeDecrease"] = Color3.fromRGB(223, 88, 95), ["FadeIncrease"] = Color3.fromRGB(255, 217, 194) })
				I[54] = new("Sound", I[53], "SoundIncrease", { PlaybackSpeed = 1.2, Volume = 0.2 })
				I[55] = new("Sound", I[53], "SoundDecrease", { PlaybackSpeed = 0.8, Volume = 0.4 })
				I[56] = new("UIStroke", I[53], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Enabled = false, Transparency = 1 })
				I[57] = new("Frame", I[53], "Frame", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(35, 20, 19), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(1, 10, 0.5, 0), Size = UDim2.new(1, 40, 0.9, 0), ZIndex = -9 })
					I[58] = new("UICorner", I[57], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[59] = new("UIGradient", I[57], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6125), NumberSequenceKeypoint.new(0.3757862, 0), NumberSequenceKeypoint.new(1, 0) }) })
					I[60] = new("UIStroke", I[57], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 222, 189), Enabled = false, Thickness = 2, Transparency = 0.7 })
						I[61] = new("UIGradient", I[60], "UIGradient")
				I[62] = new("ImageLabel", I[53], "Icon", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16587915599"), Position = UDim2.new(0, -5, 0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.3, 1.3), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[63] = new("NumberValue", I[53], "TweenNumber")
			I[64] = new("TextLabel", I[39], "Revives", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(4, 4, 4), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(1, -10, 1, -10), Size = UDim2.new(0, 13, 1, 0), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 30, TextStrokeTransparency = 0.9, TextXAlignment = Enum.TextXAlignment.Left, Visible = false }, { ["FadeDecrease"] = Color3.fromRGB(79, 17, 18), ["FadeIncrease"] = Color3.fromRGB(255, 250, 76) })
				I[65] = new("Sound", I[64], "SoundIncrease", { PlaybackSpeed = 1.1, Volume = 0.3 })
				I[66] = new("Sound", I[64], "SoundDecrease", { PlaybackSpeed = 0.7, Volume = 0.4 })
				I[67] = new("UIStroke", I[64], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Enabled = false, Transparency = 1 })
				I[68] = new("Frame", I[64], "Frame", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(34, 11, 12), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(1, 10, 0.5, 0), Size = UDim2.new(1, 40, 0.9, 0), ZIndex = -9 })
					I[69] = new("UICorner", I[68], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[70] = new("UIGradient", I[68], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6125), NumberSequenceKeypoint.new(0.3757862, 0), NumberSequenceKeypoint.new(1, 0) }) })
					I[71] = new("UIStroke", I[68], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 222, 189), Enabled = false, Thickness = 2, Transparency = 0.7 })
						I[72] = new("UIGradient", I[71], "UIGradient")
				I[73] = new("ImageLabel", I[64], "Icon", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16587986504"), Position = UDim2.new(0, -5, 0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.7, 1.7), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[74] = new("NumberValue", I[64], "TweenNumber")
			I[75] = new("TextLabel", I[39], "BoostActive", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(4, 4, 4), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://11702779517", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 5, LineHeight = 0.8, Position = UDim2.new(1, -10, 1, -10), Size = UDim2.new(0, 50, 1, 0), Text = "BOOST\nACTIVE", TextColor3 = Color3.fromRGB(255, 179, 46), TextScaled = true, TextSize = 30, TextStrokeTransparency = 0.9, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false }, { ["FadeDecrease"] = Color3.fromRGB(79, 17, 18), ["FadeIncrease"] = Color3.fromRGB(255, 250, 76) })
				I[76] = new("UIStroke", I[75], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Enabled = false, Transparency = 1 })
				I[77] = new("ImageLabel", I[75], "Icon", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://10448639430"), Position = UDim2.new(0, -5, 0.525, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[78] = new("ImageLabel", I[75], "Glow", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 144, 32), ImageContent = Content.fromUri("rbxassetid://172380355"), ImageTransparency = 0.6, Position = UDim2.fromScale(-2, 2), Size = UDim2.fromScale(5, 4), ZIndex = -1 })
			I[79] = new("TextLabel", I[39], "Modifiers", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(4, 4, 4), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 99, Position = UDim2.new(1, -10, 1, -10), Size = UDim2.new(0, 30, 1, 0), Text = "0", TextColor3 = Color3.fromRGB(250, 250, 250), TextSize = 40, TextStrokeTransparency = 0.9, Visible = false }, { ["FadeDecrease"] = Color3.fromRGB(79, 17, 18), ["FadeIncrease"] = Color3.fromRGB(255, 250, 76) })
				I[80] = new("Sound", I[79], "SoundIncrease", { PlaybackSpeed = 1.1, Volume = 0.3 })
				I[81] = new("Sound", I[79], "SoundDecrease", { PlaybackSpeed = 0.7, Volume = 0.4 })
				I[82] = new("UIStroke", I[79], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Enabled = false, Transparency = 1 })
				I[83] = new("ImageLabel", I[79], "Icon", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14380950090"), Position = UDim2.new(0, -5, 0.525, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.1, 1.1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
					I[84] = new("UIGradient", I[83], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 213, 213)), ColorSequenceKeypoint.new(0.5813149, Color3.fromRGB(255, 139, 139)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 139, 139)) }), Rotation = 90 })
				I[85] = new("ImageLabel", I[79], "Glow", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 58, 58), ImageContent = Content.fromUri("rbxassetid://172380355"), ImageTransparency = 0.6, Position = UDim2.fromScale(0.5, 2), Size = UDim2.new(0, 200, 4, 0), ZIndex = -1 })
				I[86] = new("UIGradient", I[79], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 213, 213)), ColorSequenceKeypoint.new(0.5813149, Color3.fromRGB(255, 139, 139)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 139, 139)) }), Rotation = 90 })
			I[87] = new("Sound", I[39], "SoundIncrease", { Volume = 0.4 })
			I[88] = new("Folder", I[39], "StatModules")
			I[89] = new("TextLabel", I[39], "Gold", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(4, 4, 4), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.new(1, -10, 1, -10), Size = UDim2.new(0, 13, 1, 0), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 30, TextStrokeTransparency = 0.9, TextXAlignment = Enum.TextXAlignment.Left, Visible = false }, { ["FadeDecrease"] = Color3.fromRGB(223, 88, 95), ["FadeIncrease"] = Color3.fromRGB(255, 235, 162) })
				I[90] = new("Sound", I[89], "SoundIncrease", { Volume = 0.4 })
				I[91] = new("Sound", I[89], "SoundDecrease", { PlaybackSpeed = 1.5, Volume = 0.4 })
				I[92] = new("Frame", I[89], "Frame", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(33, 30, 20), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(1, 10, 0.5, 0), Size = UDim2.new(1, 40, 0.9, 0), ZIndex = -9 })
					I[93] = new("UICorner", I[92], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[94] = new("UIGradient", I[92], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6125), NumberSequenceKeypoint.new(0.3757862, 0), NumberSequenceKeypoint.new(1, 0) }) })
					I[95] = new("UIStroke", I[92], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 222, 189), Enabled = false, Thickness = 2, Transparency = 0.7 })
						I[96] = new("UIGradient", I[95], "UIGradient")
				I[97] = new("ImageLabel", I[89], "Icon", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16587947721"), Position = UDim2.new(0, -5, 0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.3, 1.3), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[98] = new("NumberValue", I[89], "TweenNumber")
	return I[1]
end

return build
