-- Generated from ui/StarterGui/TwistedSquirmEscapeUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "TwistedSquirmEscapeUI", { DisplayOrder = 100, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextButton", I[1], "LeftTouchZone", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(60, 40, 40), BackgroundTransparency = 0.3, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 20, 0.5, -100), Size = UDim2.fromOffset(140, 200), Text = "◄", TextColor3 = Color3.fromRGB(255, 200, 200), TextSize = 72, Visible = false, ZIndex = 20 })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 16), BottomRightRadius = UDim.new(0, 16), TopLeftRadius = UDim.new(0, 16), TopRightRadius = UDim.new(0, 16) })
			I[4] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(180, 80, 80), Thickness = 3 })
			I[5] = new("TextLabel", I[2], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -40), Size = UDim2.new(1, 0, 0, 30), Text = "TAP", TextColor3 = Color3.fromRGB(200, 150, 150), TextSize = 18, ZIndex = 21 })
		I[6] = new("TextButton", I[1], "RightTouchZone", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(60, 40, 40), BackgroundTransparency = 0.3, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -160, 0.5, -100), Size = UDim2.fromOffset(140, 200), Text = "►", TextColor3 = Color3.fromRGB(255, 200, 200), TextSize = 72, Visible = false, ZIndex = 20 })
			I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0, 16), BottomRightRadius = UDim.new(0, 16), TopLeftRadius = UDim.new(0, 16), TopRightRadius = UDim.new(0, 16) })
			I[8] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(180, 80, 80), Thickness = 3 })
			I[9] = new("TextLabel", I[6], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -40), Size = UDim2.new(1, 0, 0, 30), Text = "TAP", TextColor3 = Color3.fromRGB(200, 150, 150), TextSize = 18, ZIndex = 21 })
		I[10] = new("Folder", I[1], "Stylesheets")
			I[11] = new("Folder", I[10], "directionIndicator") -- was a ModuleScript (code in source/scripts)
				I[12] = new("Sound", I[11], "Electric Piano - Mysterious Bass")
				I[13] = new("Sound", I[11], "error", { RollOffMinDistance = 11 })
					I[14] = new("PitchShiftSoundEffect", I[13], "PitchShiftSoundEffect", { Octave = -5 })
				I[15] = new("Sound", I[11], "piano A short", { PlaybackSpeed = 0.5 })
		I[16] = new("ImageLabel", I[1], "Vignette", { BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(14, 255, 163), ImageContent = Content.fromUri("rbxassetid://128190318258427"), ImageTransparency = 0.4, Size = UDim2.fromScale(1, 1) })
		I[17] = new("Frame", I[1], "EscapeFrame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(20, 15, 15), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.6), Size = UDim2.fromScale(0.3472662, 0.1998255), ZIndex = 10 })
			I[18] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(0, 12), BottomRightRadius = UDim.new(0, 12), TopLeftRadius = UDim.new(0, 12), TopRightRadius = UDim.new(0, 12) })
			I[19] = new("TextLabel", I[17], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.275), Size = UDim2.fromScale(0.8090312, 0.3405593), Text = "STRUGGLE!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 26, TextWrapped = true, ZIndex = 11 })
				I[20] = new("UIGradient", I[19], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.507772, Color3.fromRGB(252, 252, 252)), ColorSequenceKeypoint.new(1, Color3.fromRGB(112, 112, 112)) }), Rotation = 90 })
				I[21] = new("UIStroke", I[19], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.05 })
			I[22] = new("Frame", I[17], "DirectionIndicator", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5086123), Size = UDim2.fromScale(1.2104372, 0.8791296), ZIndex = 0 })
				I[23] = new("Frame", I[22], "LeftArrowBg", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(40, 80, 40), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.144741, -0.0720486), Size = UDim2.fromScale(0.3246869, 1.1623247), ZIndex = 11 })
					I[24] = new("TextLabel", I[23], "LeftArrow", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "◄◄", TextColor3 = Color3.fromRGB(80, 180, 80), TextSize = 28, Visible = false, ZIndex = 12 })
					I[25] = new("ImageLabel", I[23], "Key", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://125315027401160"), Position = UDim2.fromScale(0.5, 0.4438897), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
						I[26] = new("UIScale", I[25], "UIScale")
					I[27] = new("ImageLabel", I[23], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://134104651576648"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 0 })
						I[28] = new("UIScale", I[27], "UIScale")
					I[29] = new("UIAspectRatioConstraint", I[23], "UIAspectRatioConstraint")
					I[30] = new("ImageLabel", I[23], "Inactive", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://125315027401160"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.4438897), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
						I[31] = new("UIScale", I[30], "UIScale")
				I[32] = new("TextLabel", I[22], "NextIndicator", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -30, 0.5, -10), Size = UDim2.fromOffset(60, 20), Text = "◄◄◄", TextColor3 = Color3.fromRGB(255, 220, 100), TextSize = 14, ZIndex = 13 })
				I[33] = new("Frame", I[22], "RightArrowBg", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(40, 80, 40), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.8759804, -0.0720486), Size = UDim2.fromScale(0.3246869, 1.1623247), ZIndex = 11 })
					I[34] = new("TextLabel", I[33], "RightArrow", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "◄◄", TextColor3 = Color3.fromRGB(80, 180, 80), TextSize = 28, Visible = false, ZIndex = 12 })
					I[35] = new("ImageLabel", I[33], "Key", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://136733169160288"), Position = UDim2.fromScale(0.5, 0.4438897), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
						I[36] = new("UIScale", I[35], "UIScale")
					I[37] = new("ImageLabel", I[33], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://117049652983788"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 0 })
						I[38] = new("UIScale", I[37], "UIScale")
					I[39] = new("UIAspectRatioConstraint", I[33], "UIAspectRatioConstraint")
					I[40] = new("ImageLabel", I[33], "Inactive", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://136733169160288"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.4438897), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
						I[41] = new("UIScale", I[40], "UIScale")
			I[42] = new("TextLabel", I[17], "Hint", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.3), Size = UDim2.fromScale(0.952381, 0.1561224), Text = "Wiggle back and forth to break free!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 11 })
			I[43] = new("Frame", I[17], "ProgressBar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(56, 56, 56), BorderSizePixel = 0, Position = UDim2.fromScale(0.5107827, 0.5240175), Size = UDim2.fromScale(0.5931476, 0.0849651), ZIndex = 11 })
				I[44] = new("UICorner", I[43], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[45] = new("UIStroke", I[43], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.2 })
				I[46] = new("Frame", I[43], "Fill", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.fromScale(0.7, 1), ZIndex = 12 })
					I[47] = new("UIGradient", I[46], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(163, 200, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(99, 220, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 220, 187)) }), Rotation = -90 })
					I[48] = new("UICorner", I[46], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[49] = new("UIGradient", I[43], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135)) }), Rotation = 90 })
				I[50] = new("TextLabel", I[43], "ProgressText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.05, 0), Size = UDim2.fromScale(0.9, 1), Text = "70%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, Visible = false, ZIndex = 13 })
					I[51] = new("UIGradient", I[50], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.0967185, Color3.fromRGB(235, 235, 235)), ColorSequenceKeypoint.new(0.4162349, Color3.fromRGB(241, 241, 241)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 53, 53)) }), Rotation = 90 })
					I[52] = new("UIStroke", I[50], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.05 })
			I[53] = new("Frame", I[17], "TimerBar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(56, 56, 56), BorderSizePixel = 0, Position = UDim2.fromScale(0.5107827, 0.7528386), Size = UDim2.fromScale(0.5931475, 0.085), ZIndex = 11 })
				I[54] = new("UICorner", I[53], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[55] = new("Frame", I[53], "Fill", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6047888, 1), ZIndex = 12 })
					I[56] = new("UICorner", I[55], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[57] = new("UIGradient", I[55], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 72, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(225, 105, 0)) }), Rotation = 90 })
				I[58] = new("TextLabel", I[53], "ProgressText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.05, 0), Size = UDim2.fromScale(0.9, 1), Text = "70%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, Visible = false, ZIndex = 13 })
					I[59] = new("UIGradient", I[58], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.0967185, Color3.fromRGB(235, 235, 235)), ColorSequenceKeypoint.new(0.4162349, Color3.fromRGB(241, 241, 241)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 53, 53)) }), Rotation = 90 })
				I[60] = new("UIStroke", I[53], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.2 })
				I[61] = new("UIGradient", I[53], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135)) }), Rotation = 90 })
				I[62] = new("ImageLabel", I[53], "Clock", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://106322090314823"), Position = UDim2.fromScale(0.4999999, 0.5773749), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1528827, 3.6082594), ZIndex = 55 })
					I[63] = new("UIGradient", I[62], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 44, 0)), ColorSequenceKeypoint.new(0.3972366, Color3.fromRGB(237, 183, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(72, 52, 0)) }), Rotation = 90 })
					I[64] = new("ImageLabel", I[62], "Handle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://83976070919966"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 55 })
						I[65] = new("UIGradient", I[64], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 44, 0)), ColorSequenceKeypoint.new(0.3972366, Color3.fromRGB(237, 183, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(72, 52, 0)) }), Rotation = 90 })
				I[66] = new("ImageLabel", I[53], "ClockW", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(5, 5, 5), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://106322090314823"), Position = UDim2.fromScale(0.4999999, 0.5773749), Size = UDim2.fromScale(0.1528827, 3.6082594), Visible = false, ZIndex = 55 })
					I[67] = new("UIGradient", I[66], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.3972366, Color3.fromRGB(242, 242, 242)), ColorSequenceKeypoint.new(1, Color3.fromRGB(77, 77, 77)) }), Rotation = 90 })
					I[68] = new("ImageLabel", I[66], "Handle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(5, 5, 5), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://83976070919966"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 55 })
						I[69] = new("UIGradient", I[68], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.3972366, Color3.fromRGB(242, 242, 242)), ColorSequenceKeypoint.new(1, Color3.fromRGB(77, 77, 77)) }), Rotation = 90 })
			I[70] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint", { AspectRatio = 2.5999999 })
			I[71] = new("ImageLabel", I[17], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://132048402488880"), Position = UDim2.fromScale(-0.0375957, 0.5086126), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.0718328, 0.5245228), ZIndex = -2 })
			I[72] = new("UISizeConstraint", I[17], "UISizeConstraint", { MinSize = Vector2.new(300, 400) })
	return I[1]
end

return build
