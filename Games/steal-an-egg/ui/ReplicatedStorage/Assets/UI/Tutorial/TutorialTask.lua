-- Generated from ui/ReplicatedStorage/Assets/UI/Tutorial/TutorialTask.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "TutorialTask", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0.03, 15), Size = UDim2.fromScale(1, 0.1475), Visible = false })
		I[2] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(42, 43, 49), Thickness = 5 })
		I[3] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.035, 0), BottomRightRadius = UDim.new(0.035, 0), TopLeftRadius = UDim.new(0.035, 0), TopRightRadius = UDim.new(0.035, 0) })
		I[4] = new("Frame", I[1], "Buttons", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1.5), Size = UDim2.fromScale(1, 0.4), Visible = false })
			I[5] = new("ImageButton", I[4], "Buy", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126875624960627"), Position = UDim2.fromScale(0, 0.5), PressedImageContent = Content.fromUri("rbxassetid://124217248402069"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.5, 1.3), SliceCenter = Rect.new(20, 20, 80, 80), ZIndex = 6 })
				I[6] = new("UIGradient", I[5], "green gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(92, 239, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 253, 28)) }), Rotation = -90 })
				I[7] = new("TextLabel", I[5], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.6), Text = "Buy", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
					I[8] = new("UIStroke", I[7], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
				I[9] = new("ImageLabel", I[5], "ConsoleButton", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/DefaultController/ButtonA@2x.png"), Position = UDim2.fromScale(1, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.4), Visible = false, ZIndex = 10 }, { ["ConsoleButton"] = "ButtonX" })
					I[10] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint")
			I[11] = new("UIPadding", I[4], "UIPadding", { PaddingBottom = UDim.new(0.05, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0) })
			I[12] = new("UIListLayout", I[4], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[13] = new("ImageLabel", I[1], "shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://130304595536693"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, 35, 1, 35), SliceCenter = Rect.new(50, 50, 150, 150), ZIndex = -2 })
		I[14] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 2.4000001 })
		I[15] = new("Frame", I[1], "Notification", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(1.0000966, 0.0121528), Size = UDim2.fromScale(0.1590445, 0.2416025), Visible = false, ZIndex = 13 })
			I[16] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[17] = new("TextLabel", I[15], "Count", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://11702779409", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LineHeight = 0.9, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.7), Text = "99", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 14 })
				I[18] = new("UIStroke", I[17], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
			I[19] = new("UIStroke", I[15], "UIStroke", { Color = Color3.fromRGB(77, 0, 0), Thickness = 3.5 })
			I[20] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint")
			I[21] = new("UIGradient", I[15], "red gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 2, 61)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 39, 125)) }), Rotation = -90 })
		I[22] = new("Frame", I[1], "Progress", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.4) })
			I[23] = new("UIListLayout", I[22], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[24] = new("Frame", I[22], "div", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.15), ZIndex = 10 })
			I[25] = new("TextLabel", I[22], "Amount", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://11702779409", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 3, LineHeight = 0.89, Position = UDim2.fromScale(0.5, 0.9999999), Size = UDim2.fromScale(1, 0.4), Text = "2,000 / 10,000 XP", TextColor3 = Color3.fromRGB(112, 237, 252), TextScaled = true, TextSize = 18, TextStrokeColor3 = Color3.fromRGB(19, 48, 57), TextWrapped = true, ZIndex = 2 })
				I[26] = new("UIStroke", I[25], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
			I[27] = new("Frame", I[22], "ProgressBar", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.22), Size = UDim2.fromScale(0.8, 0.2), ZIndex = 2 })
				I[28] = new("UICorner", I[27], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[29] = new("Frame", I[27], "Bar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0.2, 1, 1.1, 0), ZIndex = 3 })
					I[30] = new("UIStroke", I[29], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(17, 49, 58), Thickness = 2 })
					I[31] = new("UIGradient", I[29], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(87, 216, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 255, 249)) }), Rotation = -90 })
					I[32] = new("UICorner", I[29], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[33] = new("Frame", I[1], "Message", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.6) })
			I[34] = new("Frame", I[33], "Text", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(0.7, 1) })
				I[35] = new("TextLabel", I[34], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.165), Size = UDim2.fromScale(1, 0.5), Text = "Starter Quest!", TextColor3 = Color3.fromRGB(112, 237, 252), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, ZIndex = 7 })
					I[36] = new("UIStroke", I[35], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
				I[37] = new("TextLabel", I[34], "Desc", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.165), Size = UDim2.fromScale(1, 0.5), Text = "Unlock area #1", TextColor3 = Color3.fromRGB(42, 43, 49), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, ZIndex = 7 })
				I[38] = new("UIListLayout", I[34], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[39] = new("UIPadding", I[34], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.025, 0), PaddingRight = UDim.new(0.025, 0), PaddingTop = UDim.new(0.1, 0) })
			I[40] = new("ImageLabel", I[33], "SideIcon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://93505660219026"), LayoutOrder = 1, Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
				I[41] = new("UIAspectRatioConstraint", I[40], "UIAspectRatioConstraint")
			I[42] = new("UIListLayout", I[33], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[43] = new("UIPadding", I[33], "UIPadding", { PaddingTop = UDim.new(0.03, 0) })
		I[44] = new("Frame", I[1], "BonusReward", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.15, 1.1), Size = UDim2.fromScale(0.75, 0.5), Visible = false })
			I[45] = new("ImageLabel", I[44], "shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://130304595536693"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, 35, 1, 35), SliceCenter = Rect.new(50, 50, 150, 150), ZIndex = -2 })
			I[46] = new("UIStroke", I[44], "UIStroke", { Color = Color3.fromRGB(42, 43, 49), Thickness = 5 })
			I[47] = new("UICorner", I[44], "UICorner", { BottomLeftRadius = UDim.new(0.035, 0), BottomRightRadius = UDim.new(0.035, 0), TopLeftRadius = UDim.new(0.035, 0), TopRightRadius = UDim.new(0.035, 0) })
			I[48] = new("ImageLabel", I[44], "RewardImage", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://120096374556895"), LayoutOrder = 1, Position = UDim2.fromScale(0.725, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.85, 0.85), ZIndex = 5 })
				I[49] = new("UIAspectRatioConstraint", I[48], "UIAspectRatioConstraint")
			I[50] = new("TextLabel", I[44], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.38, 0.25), Size = UDim2.fromScale(1, 0.5), Text = "Bonus Item:", TextColor3 = Color3.fromRGB(252, 240, 111), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, ZIndex = 7 })
				I[51] = new("UIStroke", I[50], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
		I[52] = new("Frame", I[1], "TeleportButton", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1.5), Size = UDim2.fromScale(1, 0.4), Visible = false })
			I[53] = new("ImageButton", I[52], "TeleportOld", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126875624960627"), Position = UDim2.fromScale(0, 0.5), PressedImageContent = Content.fromUri("rbxassetid://124217248402069"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.5, 1.3), SliceCenter = Rect.new(20, 20, 80, 80), Visible = false, ZIndex = 6 })
				I[54] = new("UIGradient", I[53], "green gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(92, 239, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 253, 28)) }), Rotation = -90 })
				I[55] = new("TextLabel", I[53], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.6), Text = "Teleport", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
					I[56] = new("UIStroke", I[55], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
				I[57] = new("ImageLabel", I[53], "ConsoleButton", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/DefaultController/ButtonA@2x.png"), Position = UDim2.fromScale(1, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.4), Visible = false, ZIndex = 10 }, { ["ConsoleButton"] = "ButtonX" })
					I[58] = new("UIAspectRatioConstraint", I[57], "UIAspectRatioConstraint")
			I[59] = new("UIPadding", I[52], "UIPadding", { PaddingBottom = UDim.new(0.05, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0) })
			I[60] = new("UIListLayout", I[52], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[61] = new("ImageButton", I[52], "Teleport", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126875624960627"), Position = UDim2.fromScale(0.5, 1), PressedImageContent = Content.fromUri("rbxassetid://124217248402069"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.9, 1.15), SliceCenter = Rect.new(20, 20, 80, 80), SliceScale = 0.8, ZIndex = 6 })
				I[62] = new("UIGradient", I[61], "green gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(92, 239, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 253, 28)) }), Rotation = -90 })
				I[63] = new("TextLabel", I[61], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.825, 0.6), Text = "Teleport to Eggs", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
					I[64] = new("UIStroke", I[63], "Stroke", { Color = Color3.fromRGB(25, 63, 0), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
				I[65] = new("ImageLabel", I[61], "glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://130304595536693"), ImageTransparency = 0.65, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, 15, 1, 15), SliceCenter = Rect.new(50, 50, 150, 150), SliceScale = 0.65, ZIndex = -1 })
					I[66] = new("UIGradient", I[65], "green gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(92, 239, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 253, 28)) }), Rotation = -90 })
					I[67] = new("UIGradient", I[65], "black gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Enabled = false, Rotation = -90 })
				I[68] = new("UIAspectRatioConstraint", I[61], "UIAspectRatioConstraint", { AspectRatio = 4 })
				I[69] = new("ImageLabel", I[61], "ConsoleButton", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/DefaultController/ButtonA@2x.png"), Position = UDim2.fromScale(1, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.4), Visible = false, ZIndex = 10 }, { ["ConsoleButton"] = "ButtonX" })
					I[70] = new("UIAspectRatioConstraint", I[69], "UIAspectRatioConstraint")
				I[71] = new("UIGradient", I[61], "grey gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(199, 199, 199)), ColorSequenceKeypoint.new(1, Color3.fromRGB(199, 199, 199)) }), Enabled = false, Rotation = -90 })
	return I[1]
end

return build
