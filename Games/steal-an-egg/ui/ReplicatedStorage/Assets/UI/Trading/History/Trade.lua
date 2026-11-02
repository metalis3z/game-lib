-- Generated from ui/ReplicatedStorage/Assets/UI/Trading/History/Trade.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "Trade", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.4), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 18, ZIndex = 2 }, { ["Tick"] = 0 })
		I[2] = new("UIStroke", I[1], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
		I[3] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0, 20), BottomRightRadius = UDim.new(0, 20), TopLeftRadius = UDim.new(0, 20), TopRightRadius = UDim.new(0, 20) })
		I[4] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(226, 255, 255)), ColorSequenceKeypoint.new(0.3823529, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = -90 })
		I[5] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder })
		I[6] = new("Frame", I[1], "ReceivedDiamonds", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 7, Position = UDim2.fromScale(0.975, 0.725), Size = UDim2.new(1, 0, 0, 40), ZIndex = 2 })
			I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
			I[8] = new("UIListLayout", I[6], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[9] = new("ImageLabel", I[6], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://115517396195730"), LayoutOrder = 1, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
				I[10] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint")
			I[11] = new("TextLabel", I[6], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://11702779409", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, LineHeight = 0.9, Size = UDim2.fromScale(0, 0.9), Text = "0", TextColor3 = Color3.fromRGB(164, 253, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 3 })
				I[12] = new("UIStroke", I[11], "UIStroke", { Color = Color3.fromRGB(17, 49, 58), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
		I[13] = new("Frame", I[1], "ReceivedItems", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 6, Size = UDim2.fromScale(1, 0) })
			I[14] = new("UIGridLayout", I[13], "UIGridLayout", { CellPadding = UDim2.fromOffset(15, 15), CellSize = UDim2.fromOffset(90, 90), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
		I[15] = new("Frame", I[1], "SentItems", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 3, Size = UDim2.fromScale(1, 0) })
			I[16] = new("UIGridLayout", I[15], "UIGridLayout", { CellPadding = UDim2.fromOffset(15, 15), CellSize = UDim2.fromOffset(90, 90), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
		I[17] = new("Frame", I[1], "Sent", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 30) })
			I[18] = new("TextLabel", I[17], "Username", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(0, 1), Text = "Sent", TextColor3 = Color3.fromRGB(42, 43, 49), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
			I[19] = new("UIListLayout", I[17], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[20] = new("Frame", I[17], "div", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.875, LayoutOrder = -10, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0.2, 0, 0, 1), ZIndex = 2 })
				I[21] = new("UIGradient", I[20], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1905355, 0.3875), NumberSequenceKeypoint.new(0.5018679, 0), NumberSequenceKeypoint.new(0.7895392, 0.36875), NumberSequenceKeypoint.new(1, 1) }) })
			I[22] = new("Frame", I[17], "div_2", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.875, LayoutOrder = 10, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0.2, 0, 0, 1), ZIndex = 2 })
				I[23] = new("UIGradient", I[22], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1905355, 0.3875), NumberSequenceKeypoint.new(0.5018679, 0), NumberSequenceKeypoint.new(0.7895392, 0.36875), NumberSequenceKeypoint.new(1, 1) }) })
		I[24] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 15), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 10) })
		I[25] = new("Frame", I[1], "Received", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 5, Size = UDim2.new(1, 0, 0, 30) })
			I[26] = new("TextLabel", I[25], "Username", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(0, 1), Text = "Received", TextColor3 = Color3.fromRGB(42, 43, 49), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
			I[27] = new("UIListLayout", I[25], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[28] = new("Frame", I[25], "div", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.875, LayoutOrder = -10, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0.2, 0, 0, 1), ZIndex = 2 })
				I[29] = new("UIGradient", I[28], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1905355, 0.3875), NumberSequenceKeypoint.new(0.5018679, 0), NumberSequenceKeypoint.new(0.7895392, 0.36875), NumberSequenceKeypoint.new(1, 1) }) })
			I[30] = new("Frame", I[25], "div_2", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.875, LayoutOrder = 10, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0.2, 0, 0, 1), ZIndex = 2 })
				I[31] = new("UIGradient", I[30], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1905355, 0.3875), NumberSequenceKeypoint.new(0.5018679, 0), NumberSequenceKeypoint.new(0.7895392, 0.36875), NumberSequenceKeypoint.new(1, 1) }) })
		I[32] = new("Frame", I[1], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 30) })
			I[33] = new("TextLabel", I[32], "Username", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(0, 1), Text = "CoderConner", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[34] = new("UIStroke", I[33], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
			I[35] = new("UIListLayout", I[32], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[36] = new("TextLabel", I[32], "Time", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://11702779409", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, LineHeight = 0.9, Size = UDim2.fromScale(0, 1), Text = "5 hours ago", TextColor3 = Color3.fromRGB(112, 237, 252), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[37] = new("UIStroke", I[36], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
			I[38] = new("Frame", I[32], "div", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.875, LayoutOrder = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.3), ZIndex = 2 })
				I[39] = new("UICorner", I[38], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[40] = new("UIAspectRatioConstraint", I[38], "UIAspectRatioConstraint")
			I[41] = new("ImageLabel", I[32], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 12, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://129396562195634"), LayoutOrder = -1, Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 15 })
				I[42] = new("UICorner", I[41], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[43] = new("UIAspectRatioConstraint", I[41], "UIAspectRatioConstraint")
		I[44] = new("Frame", I[1], "SentDiamonds", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 4, Position = UDim2.fromScale(0.975, 0.725), Size = UDim2.new(1, 0, 0, 40), ZIndex = 2 })
			I[45] = new("UICorner", I[44], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
			I[46] = new("UIListLayout", I[44], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[47] = new("ImageLabel", I[44], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://115517396195730"), LayoutOrder = 1, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
				I[48] = new("UIAspectRatioConstraint", I[47], "UIAspectRatioConstraint")
			I[49] = new("TextLabel", I[44], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://11702779409", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, LineHeight = 0.9, Size = UDim2.fromScale(0, 0.9), Text = "0", TextColor3 = Color3.fromRGB(164, 253, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 3 })
				I[50] = new("UIStroke", I[49], "UIStroke", { Color = Color3.fromRGB(17, 49, 58), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
		I[51] = new("Frame", I[1], "SentNothing", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 4, Position = UDim2.fromScale(0.975, 0.725), Size = UDim2.new(1, 0, 0, 40), Visible = false, ZIndex = 2 })
			I[52] = new("UICorner", I[51], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
			I[53] = new("UIListLayout", I[51], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[54] = new("TextLabel", I[51], "TextLabel", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(0, 1), Text = "Nothing", TextColor3 = Color3.fromRGB(42, 43, 49), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
		I[55] = new("Frame", I[1], "ReceivedNothing", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 8, Position = UDim2.fromScale(0.975, 0.725), Size = UDim2.new(1, 0, 0, 40), Visible = false, ZIndex = 3 })
			I[56] = new("UICorner", I[55], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
			I[57] = new("UIListLayout", I[55], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[58] = new("TextLabel", I[55], "TextLabel", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(0, 1), Text = "Nothing", TextColor3 = Color3.fromRGB(42, 43, 49), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
	return I[1]
end

return build
