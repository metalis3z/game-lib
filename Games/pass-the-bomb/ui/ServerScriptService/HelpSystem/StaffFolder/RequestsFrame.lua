-- Generated from ui/ServerScriptService/HelpSystem/StaffFolder/RequestsFrame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "RequestsFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(65, 65, 65), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.2515278, 0.6709843), Visible = false })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
		I[3] = new("Frame", I[1], "Header", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(46, 46, 46), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.12), Size = UDim2.fromScale(1, 0.245) })
			I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0.27, 0), BottomRightRadius = UDim.new(0.27, 0), TopLeftRadius = UDim.new(0.27, 0), TopRightRadius = UDim.new(0.27, 0) })
			I[5] = new("Frame", I[3], "Frame", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(46, 46, 46), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.3836666) })
			I[6] = new("TextLabel", I[3], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4963791, 0.3902889), Size = UDim2.fromScale(0.8082717, 0.3297279), Text = "HELP REQUESTS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[7] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4963791, 0.6526917), Size = UDim2.fromScale(0.8082717, 0.2247668), Text = "View submitted requests.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[8] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 0.8135593 })
		I[9] = new("Frame", I[1], "Screens", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.62), Size = UDim2.fromScale(1.001875, 0.7608813) })
			I[10] = new("ScrollingFrame", I[9], "ScrollingFrame", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 0, Size = UDim2.fromScale(0.9480141, 0.9480141) })
				I[11] = new("UIListLayout", I[10], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.015, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[12] = new("UIPadding", I[10], "UIPadding", { PaddingBottom = UDim.new(0.01, 0), PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(0.01, 0), PaddingTop = UDim.new(0.01, 0) })
			I[13] = new("Frame", I[9], "Details", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(65, 65, 65), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 1) })
				I[14] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.08, 0), BottomRightRadius = UDim.new(0.08, 0), TopLeftRadius = UDim.new(0.08, 0), TopRightRadius = UDim.new(0.08, 0) })
				I[15] = new("TextLabel", I[13], "HeaderUsername", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3471393, 0.0862524), Size = UDim2.fromScale(0.5094614, 0.0866183), Text = "User", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[16] = new("ImageLabel", I[13], "ProfilePicture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.1482435, 0.2164987), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1153818, 0.1236014) })
					I[17] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[18] = new("TextLabel", I[13], "Username", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5606409, 0.1924062), Size = UDim2.fromScale(0.6611669, 0.0707923), Text = "TwentyCharactersOnly", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[19] = new("TextLabel", I[13], "Rank", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.560641, 0.2530509), Size = UDim2.fromScale(0.6611669, 0.0504969), Text = "Chairman", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[20] = new("TextLabel", I[13], "HeaderReason", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3471393, 0.3668391), Size = UDim2.fromScale(0.5094614, 0.0866183), Text = "Reason", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[21] = new("Frame", I[13], "Reason", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.0937267, 0.4080863), Size = UDim2.fromScale(0.809213, 0.4167565) })
					I[22] = new("TextLabel", I[21], "TextLabel", { AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Text = "Insert Label here asddddddddd asd asd asd adsd as d jahh h hh h h hh h ", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
				I[23] = new("TextButton", I[13], "Submit", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(3, 218, 198), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2876243, 0.8846517), Size = UDim2.fromScale(0.387, 0.092), Text = "RESPOND", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
					I[24] = new("UICorner", I[23], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[25] = new("UIPadding", I[23], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.1, 0), PaddingRight = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
				I[26] = new("TextButton", I[13], "Delete", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(207, 102, 121), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7038057, 0.8879083), Size = UDim2.fromScale(0.3865525, 0.0922372), Text = "DELETE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
					I[27] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[28] = new("UIPadding", I[26], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.1, 0), PaddingRight = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
				I[29] = new("TextButton", I[13], "BackButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(46, 46, 46), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8111567, 0.0862523), Size = UDim2.fromScale(0.1759097, 0.0866183), Text = "<", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
					I[30] = new("UICorner", I[29], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[31] = new("ImageButton", I[1], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(46, 46, 46), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.045, 0.112), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.1) })
			I[32] = new("UICorner", I[31], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[33] = new("ImageLabel", I[31], "ProfilePicture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.0956926, 0.4917464), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1454848, 0.7387345) })
				I[34] = new("UICorner", I[33], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[35] = new("TextLabel", I[31], "Username", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5663416, 0.3443965), Size = UDim2.fromScale(0.7279025, 0.4440349), Text = "TwentyCharactersOnly", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[36] = new("TextLabel", I[31], "Rank", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5663416, 0.7117208), Size = UDim2.fromScale(0.7279025, 0.2906137), Text = "Chairman", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
	return I[1]
end

return build
