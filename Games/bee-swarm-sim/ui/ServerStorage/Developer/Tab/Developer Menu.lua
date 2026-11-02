-- Generated from ui/ServerStorage/Developer/Tab/Developer Menu.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "Developer Menu", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(47, 47, 47), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(-1, 0.5), Size = UDim2.fromScale(0.9657143, 0.964), Visible = false })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0, 16), BottomRightRadius = UDim.new(0, 16), TopLeftRadius = UDim.new(0, 16), TopRightRadius = UDim.new(0, 16) })
		I[3] = new("ImageLabel", I[1], "Fade", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1.6124258, 3.0000002) })
			I[4] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(68, 68, 68)) }), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
		I[5] = new("ImageButton", I[1], "Handler", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 0.15, Position = UDim2.fromScale(1.03, -0.02), Size = UDim2.fromScale(1, 1), ZIndex = 3 })
			I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0, 16), BottomRightRadius = UDim.new(0, 16), TopLeftRadius = UDim.new(0, 16), TopRightRadius = UDim.new(0, 16) })
			I[7] = new("TextLabel", I[5], "Lbl", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.0260073, -0.037674), Rotation = 2, Size = UDim2.fromScale(0.6527113, 0.1063081), Text = "Developer Menu", TextColor3 = Color3.fromRGB(20, 20, 20), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
				I[8] = new("TextLabel", I[7], "Lbl", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(1, 1), Text = "Developer Menu", TextColor3 = Color3.fromRGB(249, 249, 249), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
					I[9] = new("UIStroke", I[8], "l", { Thickness = 2.3 })
					I[10] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 128, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 217, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 128, 0)) }), Offset = Vector2.new(0.03, 0) })
				I[11] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(20, 20, 20), Thickness = 2 })
			I[12] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(204, 204, 204)), ColorSequenceKeypoint.new(0.2525952, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = -58 })
			I[13] = new("ScrollingFrame", I[5], "List", { Active = true, AnchorPoint = Vector2.new(0.5, 1), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.4948223, 0.97757), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarImageTransparency = 1, ScrollBarThickness = 3, Size = UDim2.fromScale(0.95, 0.8068746) })
				I[14] = new("UIListLayout", I[13], "UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder })
			I[15] = new("Frame", I[5], "Palka", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(83, 83, 83), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4990506, 0.1472899), Size = UDim2.fromScale(0.8, 0.01), ZIndex = 4 })
				I[16] = new("UIGradient", I[15], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.75), NumberSequenceKeypoint.new(0.5, 0.5), NumberSequenceKeypoint.new(0.8, 0.75), NumberSequenceKeypoint.new(1, 1) }) })
			I[17] = new("Frame", I[5], "RankFrame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(239, 239, 239), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4948223, 0.061964), Size = UDim2.new(0.95, 0, -0.0155602, 50), ZIndex = 999 })
				I[18] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(0, 16), BottomRightRadius = UDim.new(0, 16), TopLeftRadius = UDim.new(0, 16), TopRightRadius = UDim.new(0, 16) })
				I[19] = new("TextLabel", I[17], "Rank", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0171914, 0), RichText = true, Size = UDim2.fromOffset(351, 41), Text = "Your rank: <font color=\"#f33\">OWNER</font>", TextColor3 = Color3.fromRGB(144, 144, 144), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[20] = new("Sound", I[1], "Enter", { Volume = 0.2 })
		I[21] = new("Sound", I[1], "Click")
		I[22] = new("ImageButton", I[1], "FunctionExample", { BackgroundColor3 = Color3.fromRGB(218, 218, 218), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(361, 100), Visible = false })
			I[23] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(0, 16), BottomRightRadius = UDim.new(0, 16), TopLeftRadius = UDim.new(0, 16), TopRightRadius = UDim.new(0, 16) })
			I[24] = new("ImageButton", I[22], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17044192260"), Position = UDim2.fromScale(0.1282196, 0.4949999), Size = UDim2.fromScale(0.2227836, 0.8), ZIndex = 4 })
			I[25] = new("Frame", I[22], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(30, 30, 30), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5902118, 0.0935428), Size = UDim2.fromScale(0.7012011, 0.1964568), ZIndex = 999999999 })
				I[26] = new("UIGradient", I[25], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.75), NumberSequenceKeypoint.new(0.5, 0.5), NumberSequenceKeypoint.new(0.8, 0.75), NumberSequenceKeypoint.new(1, 1) }) })
				I[27] = new("TextLabel", I[25], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.0000023), Size = UDim2.fromOffset(260, 19), Text = "Codes Management", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18 })
			I[28] = new("Frame", I[22], "Description", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(30, 30, 30), BackgroundTransparency = 0.55, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5902118, 0.3935434), Size = UDim2.fromScale(0.7012011, 0.5014572), ZIndex = 999999999 })
				I[29] = new("UIGradient", I[28], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.75), NumberSequenceKeypoint.new(0.5, 0.5), NumberSequenceKeypoint.new(0.8, 0.75), NumberSequenceKeypoint.new(1, 1) }) })
				I[30] = new("TextLabel", I[28], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.0000015), Size = UDim2.fromOffset(260, 50), Text = "Description", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true })
		I[31] = new("ImageButton", I[1], "NoAccessFunctionExample", { BackgroundColor3 = Color3.fromRGB(238, 238, 238), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Interactable = false, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(361, 100), Visible = false })
			I[32] = new("UICorner", I[31], "UICorner", { BottomLeftRadius = UDim.new(0, 16), BottomRightRadius = UDim.new(0, 16), TopLeftRadius = UDim.new(0, 16), TopRightRadius = UDim.new(0, 16) })
			I[33] = new("ImageButton", I[31], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17044192260"), ImageTransparency = 0.56, Interactable = false, Position = UDim2.fromScale(0.1282196, 0.4949999), Size = UDim2.fromScale(0.2227836, 0.8), ZIndex = 4 })
			I[34] = new("Frame", I[31], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(30, 30, 30), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5902118, 0.0935428), Size = UDim2.fromScale(0.7012011, 0.1964568), ZIndex = 999999999 })
				I[35] = new("UIGradient", I[34], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.75), NumberSequenceKeypoint.new(0.5, 0.5), NumberSequenceKeypoint.new(0.8, 0.75), NumberSequenceKeypoint.new(1, 1) }) })
				I[36] = new("TextLabel", I[34], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.0000023), Size = UDim2.fromOffset(260, 19), Text = "Codes Management", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18 })
				I[37] = new("TextButton", I[34], "TextButton", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Interactable = false, Position = UDim2.fromScale(-0.3417155, -0.4761493), Size = UDim2.fromOffset(361, 99), Text = "No Access", TextColor3 = Color3.fromRGB(29, 29, 29), TextSize = 45, TextWrapped = true, ZIndex = 999999999 })
					I[38] = new("UICorner", I[37], "UICorner", { BottomLeftRadius = UDim.new(0, 16), BottomRightRadius = UDim.new(0, 16), TopLeftRadius = UDim.new(0, 16), TopRightRadius = UDim.new(0, 16) })
	return I[1]
end

return build
