-- Generated from ui/ReplicatedStorage/Assets/UI/Clans/Player.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Player", { BackgroundColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1550, Size = UDim2.fromScale(0.9554211, 0.2722126), ZIndex = 600 })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 600 })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
			I[4] = new("Frame", I[2], "PlayerIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.077, 0.5), Size = UDim2.fromScale(0.1237785, 0.8028169), ZIndex = 610 })
				I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[6] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), Thickness = 5 })
				I[7] = new("ImageLabel", I[4], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112951947643512"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 620 })
					I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[9] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 252, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Enabled = false, Rotation = 255 })
			I[10] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), Thickness = 5 })
			I[11] = new("TextLabel", I[2], "PlayerUsername", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 8, Position = UDim2.fromScale(0.4314464, 0.6210001), Size = UDim2.fromScale(0.5323563, 0.2617222), Text = "@Roks3k", TextColor3 = Color3.fromRGB(0, 32, 54), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 610 })
			I[12] = new("Folder", I[2], "PlayerRank")
				I[13] = new("TextLabel", I[12], "Leader", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 8, Position = UDim2.fromScale(0.852, 0.28), Size = UDim2.fromScale(0.2607716, 0.3661972), Text = "Leader", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false, ZIndex = 610 })
					I[14] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(93, 47, 29), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
					I[15] = new("UIGradient", I[13], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 119, 0)) }), Rotation = 90 })
				I[16] = new("TextLabel", I[12], "Member", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 8, Position = UDim2.fromScale(0.852, 0.28), Size = UDim2.fromScale(0.2607716, 0.3661972), Text = "Member", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false, ZIndex = 610 })
					I[17] = new("UIStroke", I[16], "UIStroke", { Color = Color3.fromRGB(16, 66, 93), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
					I[18] = new("UIGradient", I[16], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(181, 254, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 224, 255)) }), Rotation = 90 })
				I[19] = new("TextLabel", I[12], "Officer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 8, Position = UDim2.fromScale(0.852, 0.28), Size = UDim2.fromScale(0.2607716, 0.3661972), Text = "Officer", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false, ZIndex = 610 })
					I[20] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(70, 11, 93), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
					I[21] = new("UIGradient", I[19], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 166, 246)), ColorSequenceKeypoint.new(1, Color3.fromRGB(197, 23, 255)) }), Rotation = 90 })
			I[22] = new("TextButton", I[2], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 900 })
				I[23] = new("UITextSizeConstraint", I[22], "UITextSizeConstraint", { MaxTextSize = 14 })
			I[24] = new("Frame", I[2], "Check", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.821, 0.5), Size = UDim2.fromScale(0.2896043, 0.526959), Visible = false, ZIndex = 950 })
				I[25] = new("UICorner", I[24], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
				I[26] = new("Frame", I[24], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(17, 72, 6), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 940 })
					I[27] = new("UIStroke", I[26], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
					I[28] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
				I[29] = new("TextButton", I[24], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 1000 })
				I[30] = new("TextLabel", I[24], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.8), Text = "Check", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 960 })
					I[31] = new("UIStroke", I[30], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
				I[32] = new("UIGradient", I[24], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(161, 254, 55)), ColorSequenceKeypoint.new(1, Color3.fromRGB(34, 216, 14)) }), Rotation = 90 })
				I[33] = new("UIStroke", I[24], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
			I[34] = new("Frame", I[2], "Cancel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.821, 0.5), Size = UDim2.fromScale(0.2896043, 0.526959), Visible = false, ZIndex = 950 })
				I[35] = new("UIStroke", I[34], "UIStroke", { Color = Color3.fromRGB(84, 0, 16), Thickness = 5 })
				I[36] = new("UICorner", I[34], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
				I[37] = new("Frame", I[34], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(84, 0, 16), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 940 })
					I[38] = new("UIStroke", I[37], "UIStroke", { Color = Color3.fromRGB(84, 0, 16), Thickness = 5 })
					I[39] = new("UICorner", I[37], "UICorner", { BottomLeftRadius = UDim.new(0.26, 0), BottomRightRadius = UDim.new(0.26, 0), TopLeftRadius = UDim.new(0.26, 0), TopRightRadius = UDim.new(0.26, 0) })
				I[40] = new("TextButton", I[34], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 1000 })
				I[41] = new("UIGradient", I[34], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 59, 91)), ColorSequenceKeypoint.new(1, Color3.fromRGB(228, 4, 46)) }), Rotation = 90 })
				I[42] = new("TextLabel", I[34], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.8), Text = "Cancel", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 960 })
					I[43] = new("UIStroke", I[42], "UIStroke", { Color = Color3.fromRGB(84, 0, 16), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
			I[44] = new("Frame", I[2], "PlayerInfo", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.425, 0.314), Size = UDim2.fromScale(0.511, 0.366), ZIndex = 610 })
				I[45] = new("TextLabel", I[44], "PlayerDisplayName", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 8, Position = UDim2.fromScale(0.5690566, 0.5), Size = UDim2.fromScale(0.01, 1), Text = "Roksek", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 51, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 610 })
					I[46] = new("UIStroke", I[45], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
					I[47] = new("UIGradient", I[45], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(217, 255, 251)) }), Rotation = 90 })
				I[48] = new("UIListLayout", I[44], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.04, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[49] = new("Frame", I[44], "Status", { BackgroundColor3 = Color3.fromRGB(35, 230, 61), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1000, Position = UDim2.fromScale(0.3659722, 0.3394913), Size = UDim2.fromScale(0.0340395, 0.3079946), Visible = false, ZIndex = 610 })
					I[50] = new("UICorner", I[49], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[51] = new("UIStroke", I[49], "UIStroke", { Color = Color3.fromRGB(18, 115, 29), Thickness = 4 })
			I[52] = new("Frame", I[2], "Rebirths", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.982, 0.74), Size = UDim2.fromScale(0.0650871, 0.4221488), Visible = false, ZIndex = 600 })
				I[53] = new("UIListLayout", I[52], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 9), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[54] = new("ImageLabel", I[52], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://139351990977894"), Position = UDim2.fromScale(-1.1124094, 0.5000001), Size = UDim2.fromOffset(58, 58), ZIndex = 620 })
				I[55] = new("TextLabel", I[52], "Amount", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 8, Position = UDim2.fromScale(0.0293248, 0.4999995), Size = UDim2.fromScale(0.1, 0.9), Text = "10.9K", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 53, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 610 })
					I[56] = new("UIGradient", I[55], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 170, 175)), ColorSequenceKeypoint.new(1, Color3.fromRGB(253, 77, 80)) }), Rotation = 90 })
					I[57] = new("UIStroke", I[55], "UIStroke", { Color = Color3.fromRGB(117, 25, 31), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
			I[58] = new("UIGradient", I[2], "Leader", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 244, 225)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Enabled = false, Rotation = 255 })
			I[59] = new("UIGradient", I[2], "Member", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 252, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Enabled = false, Rotation = 255 })
			I[60] = new("UIGradient", I[2], "Officer", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(252, 226, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Enabled = false, Rotation = 255 })
	return I[1]
end

return build
