-- Generated from ui/ReplicatedStorage/Assets/Billboards/TopPlayer.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "TopPlayer", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, LightInfluence = 1, MaxDistance = 45, Size = UDim2.fromScale(12, 3), StudsOffsetWorldSpace = Vector3.new(0, 3, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "List", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.35), Size = UDim2.fromScale(0.9, 0.6) })
			I[3] = new("UIGridLayout", I[2], "UIGridLayout", { CellPadding = UDim2.fromScale(-0.13, 0.02), CellSize = UDim2.fromScale(0.2, 0.32), FillDirection = Enum.FillDirection.Vertical, FillDirectionMaxCells = 1, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, StartCorner = Enum.StartCorner.BottomLeft, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[4] = new("Frame", I[2], "Rebirths", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromOffset(100, 100), Visible = false })
				I[5] = new("ImageLabel", I[4], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://139351990977894"), Size = UDim2.fromScale(0.27, 1) })
					I[6] = new("TextLabel", I[5], "Rank", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.9, 0.8), Size = UDim2.fromScale(0.7, 0.9), Text = "#99", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.9, TextWrapped = true })
						I[7] = new("UITextSizeConstraint", I[6], "UITextSizeConstraint")
						I[8] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(117, 25, 31), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
						I[9] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 170, 175)), ColorSequenceKeypoint.new(1, Color3.fromRGB(253, 77, 80)) }), Rotation = 90 })
				I[10] = new("UIListLayout", I[4], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[11] = new("Frame", I[2], "EggsOpened", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromOffset(100, 100), Visible = false })
				I[12] = new("ImageLabel", I[11], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://124818338664786"), Size = UDim2.fromScale(0.27, 1) })
					I[13] = new("TextLabel", I[12], "Rank", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.9, 0.8), Size = UDim2.fromScale(0.7, 0.9), Text = "#99", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.9, TextWrapped = true })
						I[14] = new("UITextSizeConstraint", I[13], "UITextSizeConstraint")
						I[15] = new("UIGradient", I[13], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 247, 198)), ColorSequenceKeypoint.new(1, Color3.fromRGB(253, 173, 75)) }), Rotation = 90 })
						I[16] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(83, 48, 22), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
				I[17] = new("UIListLayout", I[11], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[18] = new("Frame", I[2], "TotalClicks", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromOffset(100, 100), Visible = false })
				I[19] = new("ImageLabel", I[18], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://101259119863060"), Size = UDim2.fromScale(0.27, 1) })
					I[20] = new("TextLabel", I[19], "Rank", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.9, 0.8), Size = UDim2.fromScale(0.7, 0.9), Text = "#99", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.9, TextWrapped = true })
						I[21] = new("UIGradient", I[20], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(171, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 203, 255)) }), Rotation = 90 })
						I[22] = new("UIStroke", I[20], "UIStroke", { Color = Color3.fromRGB(10, 53, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
						I[23] = new("UITextSizeConstraint", I[20], "UITextSizeConstraint")
				I[24] = new("UIListLayout", I[18], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[25] = new("Frame", I[2], "TimePlayed", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromOffset(100, 100), Visible = false })
				I[26] = new("ImageLabel", I[25], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://75331309940794"), Size = UDim2.fromScale(0.27, 1) })
					I[27] = new("TextLabel", I[26], "Rank", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.9, 0.8), Size = UDim2.fromScale(0.7, 0.9), Text = "#99", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.9, TextWrapped = true })
						I[28] = new("UITextSizeConstraint", I[27], "UITextSizeConstraint")
						I[29] = new("UIStroke", I[27], "UIStroke", { Color = Color3.fromRGB(98, 51, 27), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
						I[30] = new("UIGradient", I[27], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(254, 241, 65)), ColorSequenceKeypoint.new(1, Color3.fromRGB(253, 128, 26)) }), Rotation = 90 })
				I[31] = new("UIListLayout", I[25], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[32] = new("Frame", I[2], "RobuxSpent", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromOffset(100, 100), Visible = false })
				I[33] = new("ImageLabel", I[32], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://124683360134047"), Size = UDim2.fromScale(0.27, 1) })
					I[34] = new("TextLabel", I[33], "Rank", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.9, 0.8), Size = UDim2.fromScale(0.7, 0.9), Text = "#99", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.9, TextWrapped = true })
						I[35] = new("UITextSizeConstraint", I[34], "UITextSizeConstraint")
						I[36] = new("UIGradient", I[34], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(178, 254, 92)), ColorSequenceKeypoint.new(1, Color3.fromRGB(41, 253, 90)) }), Rotation = 90 })
						I[37] = new("UIStroke", I[34], "UIStroke", { Color = Color3.fromRGB(20, 83, 17), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
				I[38] = new("UIListLayout", I[32], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[39] = new("TextLabel", I[1], "PlayerName", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.76), Size = UDim2.fromScale(1, 0.216), Text = "Woiizz", TextColor3 = Color3.fromRGB(254, 254, 254), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.9, TextWrapped = true })
			I[40] = new("UITextSizeConstraint", I[39], "UITextSizeConstraint")
			I[41] = new("UIStroke", I[39], "UIStroke", { Thickness = 2, Transparency = 0.4 })
		I[42] = new("TextLabel", I[1], "ClanTag", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 4, Position = UDim2.fromScale(0.5, 0.93), Size = UDim2.fromScale(1, 0.144), Text = "[TAG]", TextColor3 = Color3.fromRGB(69, 190, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.9, TextWrapped = true, Visible = false })
			I[43] = new("UITextSizeConstraint", I[42], "UITextSizeConstraint")
			I[44] = new("UIStroke", I[42], "UIStroke", { Color = Color3.fromRGB(17, 43, 98), Thickness = 2, Transparency = 0.4 })
		I[45] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
	return I[1]
end

return build
