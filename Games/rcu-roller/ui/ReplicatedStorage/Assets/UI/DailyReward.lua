-- Generated from ui/ReplicatedStorage/Assets/UI/DailyReward.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "DailyReward", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.2397602, 0.8979406), ZIndex = 505 })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 505 })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(8, 65, 103), Thickness = 5 })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.06, 0), BottomRightRadius = UDim.new(0.06, 0), TopLeftRadius = UDim.new(0.06, 0), TopRightRadius = UDim.new(0.06, 0) })
			I[5] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 244, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(46, 204, 240)) }), Rotation = 90 })
			I[6] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://101259119863060"), Position = UDim2.fromScale(0.5, 0.445), Size = UDim2.fromScale(0.625, 0.443787), ZIndex = 510 })
				I[7] = new("TextButton", I[6], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 1000 })
			I[8] = new("TextButton", I[2], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 650 })
			I[9] = new("TextLabel", I[2], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.113), Size = UDim2.fromScale(0.898, 0.1663118), Text = "+100 Clicks", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 610 })
				I[10] = new("UIStroke", I[9], "UIStroke", { Color = Color3.fromRGB(8, 65, 103), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
			I[11] = new("ImageLabel", I[2], "Sunburst", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://14545190818"), ImageTransparency = 0.7, Position = UDim2.fromScale(0.5, 0.445), Size = UDim2.fromScale(1.25, 0.887574), ZIndex = 509 })
			I[12] = new("Frame", I[2], "State", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.85), Size = UDim2.fromScale(0.88, 0.19), ZIndex = 950 })
				I[13] = new("Frame", I[12], "Waiting", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 950 })
					I[14] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(86, 86, 86), Thickness = 5 })
					I[15] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.24, 0), BottomRightRadius = UDim.new(0.24, 0), TopLeftRadius = UDim.new(0.24, 0), TopRightRadius = UDim.new(0.24, 0) })
					I[16] = new("Frame", I[13], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(80, 80, 80), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 940 })
						I[17] = new("UIStroke", I[16], "UIStroke", { Color = Color3.fromRGB(80, 80, 80), Thickness = 5 })
						I[18] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0.24, 0), BottomRightRadius = UDim.new(0.24, 0), TopLeftRadius = UDim.new(0.24, 0), TopRightRadius = UDim.new(0.24, 0) })
					I[19] = new("ImageLabel", I[13], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://103636235196677"), Position = UDim2.fromScale(0.54, 0.5), Size = UDim2.fromScale(0.9520534, 0.9520534), ZIndex = 250 })
					I[20] = new("UIGradient", I[13], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(245, 245, 245)), ColorSequenceKeypoint.new(1, Color3.fromRGB(181, 181, 181)) }), Rotation = 90 })
					I[21] = new("TextLabel", I[13], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.8), Text = "Day 1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 960 })
						I[22] = new("UIStroke", I[21], "UIStroke", { Color = Color3.fromRGB(80, 80, 80), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
				I[23] = new("Frame", I[12], "Claim", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 950 })
					I[24] = new("UIStroke", I[23], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
					I[25] = new("UICorner", I[23], "UICorner", { BottomLeftRadius = UDim.new(0.24, 0), BottomRightRadius = UDim.new(0.24, 0), TopLeftRadius = UDim.new(0.24, 0), TopRightRadius = UDim.new(0.24, 0) })
					I[26] = new("Frame", I[23], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 32, 54), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 940 })
						I[27] = new("UIStroke", I[26], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
						I[28] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(0.24, 0), BottomRightRadius = UDim.new(0.24, 0), TopLeftRadius = UDim.new(0.24, 0), TopRightRadius = UDim.new(0.24, 0) })
					I[29] = new("ImageLabel", I[23], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://103636235196677"), Position = UDim2.fromScale(0.54, 0.5), Size = UDim2.fromScale(0.9520534, 0.9520534), ZIndex = 250 })
					I[30] = new("UIGradient", I[23], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(161, 254, 55)), ColorSequenceKeypoint.new(1, Color3.fromRGB(34, 216, 14)) }), Rotation = 90 })
					I[31] = new("TextLabel", I[23], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.8), Text = "Claim", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 960 })
						I[32] = new("UIStroke", I[31], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
				I[33] = new("TextButton", I[12], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 1000 })
			I[34] = new("TextLabel", I[2], "Amount", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7399704, 0.6269831), Size = UDim2.fromScale(0.3930935, 0.1006354), Text = "x100", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 610 })
				I[35] = new("UIStroke", I[34], "UIStroke", { Color = Color3.fromRGB(8, 65, 103), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
	return I[1]
end

return build
