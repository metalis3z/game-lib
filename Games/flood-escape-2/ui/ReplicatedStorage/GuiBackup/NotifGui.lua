-- Generated from ui/ReplicatedStorage/GuiBackup/NotifGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "NotifGui", { DisplayOrder = 3, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Notification", { Active = true, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 15 })
			I[3] = new("Frame", I[2], "Window", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(22, 31, 40), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.5), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[4] = new("TextLabel", I[3], "Title", { BackgroundColor3 = Color3.fromRGB(44, 62, 80), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.2), Text = "Notification", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.65, TextWrapped = true })
					I[5] = new("UICorner", I[4], "UICorner")
					I[6] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(0.0499168, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.9500831, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(64, 64, 64)) }), Rotation = 90 })
					I[7] = new("UIPadding", I[4], "UIPadding")
				I[8] = new("TextButton", I[3], "Confirm", { BackgroundColor3 = Color3.fromRGB(41, 128, 185), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.8), Size = UDim2.fromScale(1, 0.2), Text = "Okay", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.65, TextWrapped = true })
					I[9] = new("UICorner", I[8], "UICorner")
					I[10] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(0.0499168, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.9500831, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(64, 64, 64)) }), Rotation = 90 })
					I[11] = new("UIPadding", I[8], "UIPadding")
				I[12] = new("Frame", I[3], "Content", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.2), Size = UDim2.fromScale(1, 0.6) })
					I[13] = new("TextLabel", I[12], "Info", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Hello", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.65, TextTransparency = 1, TextWrapped = true, ZIndex = 16 })
					I[14] = new("ImageLabel", I[12], "Img", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3, 1), ZIndex = 16 })
					I[15] = new("UICorner", I[12], "UICorner")
					I[16] = new("UIGradient", I[12], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(0.0499168, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.9500831, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(64, 64, 64)) }), Rotation = 90 })
					I[17] = new("UIPadding", I[12], "UIPadding")
				I[18] = new("ImageLabel", I[3], "DropShadow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://156579757"), ImageTransparency = 0.5, Position = UDim2.fromScale(0, 0.2), Rotation = 180, Size = UDim2.fromScale(1, 0.05), ZIndex = 2 })
				I[19] = new("ImageLabel", I[3], "DropShadow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://156579757"), ImageTransparency = 0.5, Position = UDim2.fromScale(0, 0.8), Size = UDim2.fromScale(1, -0.05), ZIndex = 2 })
				I[20] = new("Frame", I[3], "Choices", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.8), Size = UDim2.fromScale(1, 0.2), Visible = false })
					I[21] = new("TextButton", I[20], "Yes", { BackgroundColor3 = Color3.fromRGB(39, 174, 96), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 2, 0, 0), Size = UDim2.fromScale(0.4966555, 1), Text = "Confirm", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.65, TextWrapped = true, ZIndex = 17 })
						I[22] = new("UICorner", I[21], "UICorner")
						I[23] = new("UIGradient", I[21], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(0.0499168, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.9500831, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(64, 64, 64)) }), Rotation = 90 })
					I[24] = new("TextButton", I[20], "No", { BackgroundColor3 = Color3.fromRGB(231, 76, 60), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(0.4966555, 1), Text = "Cancel", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.65, TextWrapped = true, ZIndex = 17 })
						I[25] = new("UICorner", I[24], "UICorner")
						I[26] = new("UIGradient", I[24], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(0.0499168, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.9500831, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(64, 64, 64)) }), Rotation = 90 })
					I[27] = new("UIPadding", I[20], "UIPadding")
				I[28] = new("UICorner", I[3], "UICorner")
				I[29] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(0.0499168, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.9500831, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(64, 64, 64)) }), Rotation = 90 })
				I[30] = new("UIPadding", I[3], "UIPadding")
				I[31] = new("Frame", I[3], "Standard_Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = -1 })
					I[32] = new("Frame", I[31], "DropShadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.0234114, 1.0468228), Visible = false, ZIndex = -1 })
						I[33] = new("UIPadding", I[32], "UIPadding")
						I[34] = new("UICorner", I[32], "UICorner_Frame")
					I[35] = new("Frame", I[31], "Border_Corners", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 0 })
						I[36] = new("Frame", I[35], "TopLeftCorner", { AnchorPoint = Vector2.new(0.1, 0.1), BackgroundColor3 = Color3.fromRGB(22, 31, 40), Size = UDim2.fromScale(0.1, 0.2), SizeConstraint = Enum.SizeConstraint.RelativeYY })
							I[37] = new("UIGradient", I[36], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(127, 127, 127)) }), Enabled = false, Rotation = 45 })
							I[38] = new("UICorner", I[36], "UICorner")
						I[39] = new("Frame", I[35], "TopRightCorner", { AnchorPoint = Vector2.new(0.9, 0.1), BackgroundColor3 = Color3.fromRGB(22, 31, 40), Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.1, 0.2), SizeConstraint = Enum.SizeConstraint.RelativeYY })
							I[40] = new("UIGradient", I[39], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(127, 127, 127)) }), Enabled = false, Rotation = 135 })
							I[41] = new("UICorner", I[39], "UICorner")
						I[42] = new("Frame", I[35], "BottomRightCorner", { AnchorPoint = Vector2.new(0.9, 0.9), BackgroundColor3 = Color3.fromRGB(22, 31, 40), Position = UDim2.fromScale(1, 1), Size = UDim2.fromScale(0.1, 0.2), SizeConstraint = Enum.SizeConstraint.RelativeYY })
							I[43] = new("UIGradient", I[42], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(127, 127, 127)) }), Enabled = false, Rotation = 225 })
							I[44] = new("UICorner", I[42], "UICorner")
						I[45] = new("Frame", I[35], "BottomLeftCorner", { AnchorPoint = Vector2.new(0.1, 0.9), BackgroundColor3 = Color3.fromRGB(22, 31, 40), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(0.1, 0.2), SizeConstraint = Enum.SizeConstraint.RelativeYY })
							I[46] = new("UICorner", I[45], "UICorner")
							I[47] = new("UIGradient", I[45], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(127, 127, 127)) }), Enabled = false, Rotation = -45 })
					I[48] = new("Frame", I[31], "Title", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.7, 0.113), Visible = false })
						I[49] = new("ImageLabel", I[48], "Drop_Shadow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://1057492965"), ImageTransparency = 0.5, Size = UDim2.fromScale(1, 1) })
						I[50] = new("TextLabel", I[48], "Info", { BackgroundColor3 = Color3.fromRGB(44, 62, 80), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "FE2CM Hub", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.65, TextTransparency = 1, TextWrapped = true, ZIndex = 2 })
							I[51] = new("UIGradient", I[50], "TextGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.3311148, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 196, 196)) }), Rotation = 90 })
			I[52] = new("Frame", I[2], "TopBorder", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, -1) })
	return I[1]
end

return build
