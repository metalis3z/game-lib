-- Generated from ui/TextChatService/adaspo_playground/ExclusiveEggConfirmFrame~2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "ExclusiveEggConfirmFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(786, 538), ZIndex = 500 })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
		I[3] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), Thickness = 5.5 })
		I[4] = new("Frame", I[1], "Pattern", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 500 })
			I[5] = new("ImageLabel", I[4], "Image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://16022483002"), ImageTransparency = 0.97, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1280, 720), ZIndex = 501 })
		I[6] = new("ImageLabel", I[1], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://15555380274"), ImageTransparency = 0.7, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.1934015, 1.2961222), SliceCenter = Rect.new(160, 160, 864, 864), ZIndex = 499 })
		I[7] = new("TextLabel", I[1], "HoverName", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.043), Size = UDim2.fromScale(0.92, 0.1480521), Text = "Open Summer Egg", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 505 })
			I[8] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
		I[9] = new("Frame", I[1], "Buttons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.76, 0.61), Size = UDim2.fromOffset(500, 100), ZIndex = 501 })
			I[10] = new("Frame", I[9], "Open1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.5000001, 0.8473387), Size = UDim2.fromOffset(228, 75), ZIndex = 503 })
				I[11] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
				I[12] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
				I[13] = new("Frame", I[10], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 32, 54), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 502 })
					I[14] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
					I[15] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
				I[16] = new("TextButton", I[10], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 600 })
				I[17] = new("UIGradient", I[10], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(161, 254, 55)), ColorSequenceKeypoint.new(1, Color3.fromRGB(34, 216, 14)) }), Rotation = 90 })
				I[18] = new("TextLabel", I[10], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.8), Text = "Open 1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 504 })
					I[19] = new("UIStroke", I[18], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
			I[20] = new("UIListLayout", I[9], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.3, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[21] = new("Frame", I[9], "Open3", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.5000001, 0.8473387), Size = UDim2.fromOffset(228, 75), ZIndex = 503 })
				I[22] = new("UIStroke", I[21], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
				I[23] = new("UICorner", I[21], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
				I[24] = new("Frame", I[21], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 32, 54), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 502 })
					I[25] = new("UIStroke", I[24], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
					I[26] = new("UICorner", I[24], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
				I[27] = new("TextButton", I[21], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 600 })
				I[28] = new("UIGradient", I[21], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(161, 254, 55)), ColorSequenceKeypoint.new(1, Color3.fromRGB(34, 216, 14)) }), Rotation = 90 })
				I[29] = new("TextLabel", I[21], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.8), Text = "Open 3", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 504 })
					I[30] = new("UIStroke", I[29], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
			I[31] = new("Frame", I[9], "Open8", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.5000001, 0.8473387), Size = UDim2.fromOffset(228, 75), ZIndex = 503 })
				I[32] = new("UIStroke", I[31], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
				I[33] = new("UICorner", I[31], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
				I[34] = new("Frame", I[31], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 32, 54), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 502 })
					I[35] = new("UIStroke", I[34], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
					I[36] = new("UICorner", I[34], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
				I[37] = new("TextButton", I[31], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 600 })
				I[38] = new("UIGradient", I[31], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(161, 254, 55)), ColorSequenceKeypoint.new(1, Color3.fromRGB(34, 216, 14)) }), Rotation = 90 })
				I[39] = new("TextLabel", I[31], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.8), Text = "Open 8", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 504 })
					I[40] = new("UIStroke", I[39], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
		I[41] = new("Frame", I[1], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.29, 0.61), Size = UDim2.fromOffset(328, 328), ZIndex = 505 })
			I[42] = new("Frame", I[41], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 506 })
				I[43] = new("TextButton", I[42], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 600 })
					I[44] = new("UITextSizeConstraint", I[43], "UITextSizeConstraint", { MaxTextSize = 14 })
				I[45] = new("Frame", I[42], "IconContainer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 508 })
					I[46] = new("ImageLabel", I[45], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://115130403201508"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), ZIndex = 510 })
				I[47] = new("ImageLabel", I[42], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://100064279845321"), ImageTransparency = 0.7, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.1, 1.1), ZIndex = 506 })
					I[48] = new("UIGradient", I[47], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 44, 72)), ColorSequenceKeypoint.new(0.183391, Color3.fromRGB(255, 134, 35)), ColorSequenceKeypoint.new(0.351211, Color3.fromRGB(255, 225, 53)), ColorSequenceKeypoint.new(0.550173, Color3.fromRGB(60, 255, 57)), ColorSequenceKeypoint.new(0.714533, Color3.fromRGB(51, 207, 255)), ColorSequenceKeypoint.new(0.856401, Color3.fromRGB(171, 46, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(166, 42, 255)) }), Rotation = 60 })
				I[49] = new("TextLabel", I[42], "Amount", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6900002, 0.0566243), Size = UDim2.fromScale(0.678966, 0.2972576), Text = "x109", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 513 })
					I[50] = new("UIStroke", I[49], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 5 })
		I[51] = new("CanvasGroup", I[1], "Canvas", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(1, 0, -0.0530855, 158), ZIndex = 503 })
			I[52] = new("Frame", I[51], "GradientBG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0.0686706, 166), ZIndex = 503 })
				I[53] = new("UIGradient", I[52], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 251, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(41, 162, 255)) }), Rotation = 90 })
				I[54] = new("UICorner", I[52], "UICorner", { BottomLeftRadius = UDim.new(0.16, 0), BottomRightRadius = UDim.new(0.16, 0), TopLeftRadius = UDim.new(0.16, 0), TopRightRadius = UDim.new(0.16, 0) })
		I[55] = new("Frame", I[1], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.9750636, 0.0372119), Size = UDim2.fromScale(0.1234097, 0.1802974), ZIndex = 950 })
			I[56] = new("TextButton", I[55], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 1000 })
			I[57] = new("Folder", I[55], "Device")
				I[58] = new("ImageLabel", I[57], "PCMobile", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://16022382102"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 950 }, { ["isNotControllerIcon"] = true })
				I[59] = new("ImageLabel", I[57], "Controller", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/DefaultController/ButtonB@2x.png"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.95), Visible = false, ZIndex = 950 }, { ["isControllerIcon"] = true, ["keyCodeImage"] = "ButtonB" })
					I[60] = new("Frame", I[59], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(95, 95, 95), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.0700001, 1.0700001), ZIndex = 940 })
						I[61] = new("UICorner", I[60], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[62] = new("UIGradient", I[60], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(246, 56, 88)), ColorSequenceKeypoint.new(1, Color3.fromRGB(213, 2, 42)) }), Rotation = 90 })
					I[63] = new("UIGradient", I[59], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(246, 56, 88)), ColorSequenceKeypoint.new(1, Color3.fromRGB(213, 2, 42)) }), Rotation = 90 })
	return I[1]
end

return build
