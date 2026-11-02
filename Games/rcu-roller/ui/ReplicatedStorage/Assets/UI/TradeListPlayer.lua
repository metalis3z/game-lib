-- Generated from ui/ReplicatedStorage/Assets/UI/TradeListPlayer.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "TradeListPlayer", { BackgroundColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.9440098, 0.1806417), ZIndex = 600 })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 600 })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), Thickness = 5 })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
			I[5] = new("Frame", I[2], "PlayerIcon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.02, 0.5), Size = UDim2.fromScale(0.1242236, 0.8), ZIndex = 600 })
				I[6] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), Thickness = 5 })
				I[7] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[8] = new("ImageLabel", I[5], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112951947643512"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 600 })
					I[9] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[10] = new("TextButton", I[8], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 1000 })
				I[11] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(235, 255, 253)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = 45 })
			I[12] = new("TextLabel", I[2], "DisplayName", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 8, Position = UDim2.fromScale(0.3913043, 0.36), Size = UDim2.fromScale(0.4384785, 0.58), Text = "adaspo", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 610 })
				I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
				I[14] = new("UIGradient", I[12], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(201, 255, 247)) }), Rotation = 90 })
			I[15] = new("TextLabel", I[2], "Username", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 8, Position = UDim2.fromScale(0.3897516, 0.74), Size = UDim2.fromScale(0.4394115, 0.34), Text = "@adaspo", TextColor3 = Color3.fromRGB(0, 32, 54), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 610 })
			I[16] = new("Frame", I[2], "State", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.8045741, 0.5), Size = UDim2.fromScale(0.3374417, 0.63), ZIndex = 610 })
				I[17] = new("TextButton", I[16], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 700 })
				I[18] = new("Frame", I[16], "InTrade", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 610 })
					I[19] = new("UIStroke", I[18], "UIStroke", { Color = Color3.fromRGB(125, 51, 17), Thickness = 5 })
					I[20] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
					I[21] = new("Frame", I[18], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(125, 51, 17), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 600 })
						I[22] = new("UIStroke", I[21], "UIStroke", { Color = Color3.fromRGB(125, 51, 17), Thickness = 5 })
						I[23] = new("UICorner", I[21], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
					I[24] = new("UIGradient", I[18], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 224, 55)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 119, 0)) }), Rotation = 90 })
					I[25] = new("TextLabel", I[18], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "In Trade", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 630 })
						I[26] = new("UIStroke", I[25], "UIStroke", { Color = Color3.fromRGB(125, 51, 17), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
				I[27] = new("Frame", I[16], "Trade", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 610 })
					I[28] = new("UIStroke", I[27], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
					I[29] = new("UICorner", I[27], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
					I[30] = new("Frame", I[27], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 32, 54), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 600 })
						I[31] = new("UIStroke", I[30], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
						I[32] = new("UICorner", I[30], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
					I[33] = new("UIGradient", I[27], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(161, 254, 55)), ColorSequenceKeypoint.new(1, Color3.fromRGB(34, 216, 14)) }), Rotation = 90 })
					I[34] = new("TextLabel", I[27], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "Trade", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 630 })
						I[35] = new("UIStroke", I[34], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
				I[36] = new("Frame", I[16], "Sent", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 610 })
					I[37] = new("UIStroke", I[36], "UIStroke", { Color = Color3.fromRGB(101, 22, 117), Thickness = 5 })
					I[38] = new("UICorner", I[36], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
					I[39] = new("Frame", I[36], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(101, 22, 117), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 600 })
						I[40] = new("UIStroke", I[39], "UIStroke", { Color = Color3.fromRGB(101, 22, 117), Thickness = 5 })
						I[41] = new("UICorner", I[39], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
					I[42] = new("UIGradient", I[36], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 132, 244)), ColorSequenceKeypoint.new(1, Color3.fromRGB(217, 29, 255)) }), Rotation = 90 })
					I[43] = new("TextLabel", I[36], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "Sent", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 630 })
						I[44] = new("UIStroke", I[43], "UIStroke", { Color = Color3.fromRGB(101, 22, 117), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
				I[45] = new("Frame", I[16], "Accept", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 610 })
					I[46] = new("UIStroke", I[45], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
					I[47] = new("UICorner", I[45], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
					I[48] = new("Frame", I[45], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 32, 54), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 600 })
						I[49] = new("UIStroke", I[48], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
						I[50] = new("UICorner", I[48], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
					I[51] = new("UIGradient", I[45], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(161, 254, 55)), ColorSequenceKeypoint.new(1, Color3.fromRGB(34, 216, 14)) }), Rotation = 90 })
					I[52] = new("TextLabel", I[45], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "Accept", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 630 })
						I[53] = new("UIStroke", I[52], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
				I[54] = new("Frame", I[16], "Disabled", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 610 })
					I[55] = new("UICorner", I[54], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
					I[56] = new("Frame", I[54], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(84, 0, 16), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 600 })
						I[57] = new("UIStroke", I[56], "UIStroke", { Color = Color3.fromRGB(84, 0, 16), Thickness = 5 })
						I[58] = new("UICorner", I[56], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
					I[59] = new("TextLabel", I[54], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.87), Text = "Disabled", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 630 })
						I[60] = new("UIStroke", I[59], "UIStroke", { Color = Color3.fromRGB(84, 0, 16), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
					I[61] = new("UIGradient", I[54], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 59, 91)), ColorSequenceKeypoint.new(1, Color3.fromRGB(228, 4, 46)) }), Rotation = 90 })
					I[62] = new("UIStroke", I[54], "UIStroke", { Color = Color3.fromRGB(84, 0, 16), Thickness = 5 })
			I[63] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(231, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = 255 })
	return I[1]
end

return build
