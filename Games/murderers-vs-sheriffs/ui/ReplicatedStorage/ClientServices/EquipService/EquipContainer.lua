-- Generated from ui/ReplicatedStorage/ClientServices/EquipService/EquipContainer.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "EquipContainer", { BackgroundColor3 = Color3.fromRGB(58, 58, 58), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(1, 1.1799999), SizeConstraint = Enum.SizeConstraint.RelativeXX })
		I[2] = new("TextButton", I[1], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextSize = 14, ZIndex = 5 })
		I[3] = new("Frame", I[1], "Unequip", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(47, 47, 47), BorderColor3 = Color3.fromRGB(6, 6, 6), BorderSizePixel = 2, LayoutOrder = 3, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.2, 0.2), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 2 })
			I[4] = new("TextLabel", I[3], "XLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 2, 1, 0), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true })
			I[5] = new("TextButton", I[3], "Button", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(5, 5), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, ZIndex = 2 })
		I[6] = new("Frame", I[1], "ItemFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 2, Size = UDim2.fromScale(1, 1) })
			I[7] = new("Frame", I[6], "Container", { BackgroundColor3 = Color3.fromRGB(57, 57, 57), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(1, 0.825) })
				I[8] = new("ImageLabel", I[7], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://584555920"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
					I[9] = new("UIAspectRatioConstraint", I[8], "UIAspectRatioConstraint")
				I[10] = new("TextButton", I[7], "ActionButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextSize = 14, ZIndex = 2 })
				I[11] = new("TextLabel", I[7], "Amount", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(1, -4, 0, 3), Size = UDim2.fromScale(0.5, 0.225), Text = "x1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeTransparency = 0.9, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
				I[12] = new("UIGradient", I[7], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5025907, Color3.fromRGB(253, 253, 253)), ColorSequenceKeypoint.new(1, Color3.fromRGB(197, 197, 197)) }), Rotation = 90 })
				I[13] = new("UIStroke", I[7], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 2 })
			I[14] = new("Frame", I[6], "ItemName", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.175) })
				I[15] = new("TextLabel", I[14], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "KnifeName", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, ZIndex = 2 })
				I[16] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.2314335, Color3.fromRGB(251, 251, 251)), ColorSequenceKeypoint.new(1, Color3.fromRGB(162, 162, 162)) }) })
				I[17] = new("UIStroke", I[14], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 2 })
			I[18] = new("Frame", I[6], "Tags", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 4, -0.175, -4), Size = UDim2.fromScale(1, 1) })
				I[19] = new("Frame", I[18], "Halloween", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 213, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.new(0, 6, 0.8, -3), Size = UDim2.fromScale(0.275, 0.275), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
					I[20] = new("ImageLabel", I[19], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2954739019"), Position = UDim2.new(0.5, 0, 0.5, -3), Size = UDim2.new(1, 3, 1, 3), SizeConstraint = Enum.SizeConstraint.RelativeYY })
					I[21] = new("TextLabel", I[19], "Year", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.5, 2), Size = UDim2.fromScale(0.8, 1), Text = "2018", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 2 })
					I[22] = new("TextLabel", I[19], "Year2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.new(0.5, 0, 0.5, -2), Size = UDim2.fromScale(0.8, 1), Text = "2018", TextColor3 = Color3.fromRGB(213, 213, 213), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false, ZIndex = 2 })
				I[23] = new("Frame", I[18], "Chroma", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 213, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), LayoutOrder = 1, Position = UDim2.new(0, 3, 0.8, -3), Size = UDim2.fromScale(0.5, 0.125), Visible = false })
					I[24] = new("TextLabel", I[23], "TagName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Chroma", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 2 })
					I[25] = new("ImageLabel", I[23], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://2576540162"), Size = UDim2.fromScale(1, 1) })
				I[26] = new("UIListLayout", I[18], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
				I[27] = new("Frame", I[18], "Christmas", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 213, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.new(0, 6, 0.8, -3), Size = UDim2.fromScale(0.275, 0.275), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
					I[28] = new("TextLabel", I[27], "Year", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Selectable = true, Size = UDim2.fromScale(0.9, 1), Text = "2018", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 2 })
					I[29] = new("ImageLabel", I[27], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2954412467"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
					I[30] = new("TextLabel", I[27], "Year2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.new(0.5, 0, 0.5, -2), Size = UDim2.fromScale(0.8, 1), Text = "2018", TextColor3 = Color3.fromRGB(213, 213, 213), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false, ZIndex = 2 })
				I[31] = new("Frame", I[18], "Unique", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 213, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.new(0, 6, 0.8, -3), Size = UDim2.new(1, -8, 0.14, 0), Visible = false })
					I[32] = new("ImageLabel", I[31], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2954739019"), Position = UDim2.new(0.5, 0, 0.5, -3), Size = UDim2.new(1, 3, 1, 3), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
					I[33] = new("TextLabel", I[31], "PlayerName", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, ZIndex = 2 })
				I[34] = new("Frame", I[18], "Evo", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), LayoutOrder = 1, Position = UDim2.new(0, 3, 0.8, -3), Size = UDim2.fromScale(0.5, 0.125), Visible = false })
					I[35] = new("ImageLabel", I[34], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://2576540162"), Size = UDim2.fromScale(1, 1), Visible = false })
					I[36] = new("TextLabel", I[34], "TagName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Evo", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 2 })
					I[37] = new("UIGradient", I[34], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(84, 42, 255)), ColorSequenceKeypoint.new(0.4193012, Color3.fromRGB(48, 120, 188)), ColorSequenceKeypoint.new(0.7720466, Color3.fromRGB(24, 176, 146)), ColorSequenceKeypoint.new(1, Color3.fromRGB(4, 222, 113)) }) })
				I[38] = new("Frame", I[18], "FX", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), LayoutOrder = 1, Position = UDim2.new(0, 3, 0.8, -3), Size = UDim2.fromScale(0.4, 0.125), Visible = false })
					I[39] = new("UIGradient", I[38], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 94, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(222, 185, 0)) }) })
					I[40] = new("TextLabel", I[38], "TagName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.new(0.5, 0, 1, 4), Text = "FX", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 2 })
					I[41] = new("ImageLabel", I[38], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://362390166"), Size = UDim2.fromScale(0.5, 1) })
						I[42] = new("UIAspectRatioConstraint", I[41], "UIAspectRatioConstraint")
						I[43] = new("UIGradient", I[41], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 162, 0)) }), Rotation = -180 })
					I[44] = new("UIListLayout", I[38], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
					I[45] = new("UIPadding", I[38], "UIPadding", { PaddingBottom = UDim.new(0, 2), PaddingLeft = UDim.new(0, 2), PaddingTop = UDim.new(0, 1) })
			I[46] = new("UIPadding", I[6], "UIPadding", { PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4), PaddingTop = UDim.new(0, 4) })
	return I[1]
end

return build
