-- Generated from ui/ReplicatedStorage/Assets/Billboards/GateHUD.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "GateHUD", { Brightness = 1.1, ClipsDescendants = true, Face = Enum.NormalId.Right, MaxDistance = 500, PixelsPerStud = 7, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZOffset = 2 })
		I[2] = new("Frame", I[1], "Req", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0.54, 5), Size = UDim2.fromScale(0.9, 0.2) })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 25), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[4] = new("Frame", I[2], "Platinum Coins", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromScale(0, 1), Visible = false })
				I[5] = new("ImageLabel", I[4], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://108877816446605"), LayoutOrder = 1, Position = UDim2.fromScale(0.2, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(0, 90, 0.8, 0) })
				I[6] = new("TextLabel", I[4], "Amount", { AnchorPoint = Vector2.new(0, 0.5), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, LineHeight = 0.9, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0, 10, 1, 0), Text = "100", TextColor3 = Color3.fromRGB(247, 255, 254), TextScaled = true, TextSize = 18, TextStrokeColor3 = Color3.fromRGB(109, 72, 28), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 2 })
					I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 3.75 })
				I[8] = new("UIListLayout", I[4], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[9] = new("Frame", I[2], "Platinum Bars", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(0, 1), Visible = false })
				I[10] = new("ImageLabel", I[9], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.2, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(0, 90, 0.8, 0) })
				I[11] = new("TextLabel", I[9], "Amount", { AnchorPoint = Vector2.new(0, 0.5), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, LineHeight = 0.9, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0, 10, 1, 0), Text = "100", TextColor3 = Color3.fromRGB(213, 255, 247), TextScaled = true, TextSize = 18, TextStrokeColor3 = Color3.fromRGB(109, 72, 28), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 2 })
					I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 3.75 })
				I[13] = new("UIListLayout", I[9], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[14] = new("Frame", I[2], "Gold Coins", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 4, Size = UDim2.fromScale(0, 1) })
				I[15] = new("TextLabel", I[14], "Amount", { AnchorPoint = Vector2.new(0, 0.5), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, LineHeight = 0.9, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0, 10, 1, 0), Text = "100", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 18, TextStrokeColor3 = Color3.fromRGB(109, 72, 28), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 2 })
					I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 3.75 })
				I[17] = new("UIListLayout", I[14], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[18] = new("ImageLabel", I[14], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90674806393949"), LayoutOrder = 1, Position = UDim2.fromScale(0.2, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(0, 70, 0.8, 0) })
			I[19] = new("Frame", I[2], "Gold Bars", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Size = UDim2.fromScale(0, 1) })
				I[20] = new("ImageLabel", I[19], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81803967852152"), LayoutOrder = 1, Position = UDim2.fromScale(0.2, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(0, 70, 0.8, 0) })
				I[21] = new("TextLabel", I[19], "Amount", { AnchorPoint = Vector2.new(0, 0.5), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, LineHeight = 0.9, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0, 10, 1, 0), Text = "20", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 18, TextStrokeColor3 = Color3.fromRGB(109, 72, 28), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 2 })
					I[22] = new("UIStroke", I[21], "UIStroke", { Thickness = 3.75 })
				I[23] = new("UIListLayout", I[19], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[24] = new("TextLabel", I[1], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.1), Size = UDim2.fromScale(1, 0.165), Text = "Zone Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeColor3 = Color3.fromRGB(84, 84, 84), TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
			I[25] = new("UIStroke", I[24], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3.75 })
		I[26] = new("Frame", I[1], "HighlightFrame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderMode = Enum.BorderMode.Inset, BorderSizePixel = 12, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.65, 1) })
		I[27] = new("ImageButton", I[1], "Buy", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126875624960627"), Position = UDim2.fromScale(0.5, 0.8), PressedImageContent = Content.fromUri("rbxassetid://124217248402069"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.25, 0.21), SliceCenter = Rect.new(20, 20, 80, 80), Visible = false, ZIndex = 6 })
			I[28] = new("TextLabel", I[27], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.6), Text = "Figth!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
				I[29] = new("UIStroke", I[28], "UIStroke", { Color = Color3.fromRGB(41, 62, 35), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
			I[30] = new("UIGradient", I[27], "green gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(92, 239, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 253, 28)) }), Rotation = -90 })
		I[31] = new("Frame", I[1], "Quest", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.675), Size = UDim2.fromScale(0.7, 0.4), Visible = false })
			I[32] = new("TextLabel", I[31], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.25), Text = "Break 50 Breakables!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 2 })
				I[33] = new("UIStroke", I[32], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
			I[34] = new("Frame", I[31], "ProgressBar", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, Interactable = false, LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.7, 0.094), ZIndex = 10 })
				I[35] = new("UICorner", I[34], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[36] = new("Frame", I[34], "Bar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.2, 1.3), ZIndex = 10 })
					I[37] = new("UIGradient", I[36], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(87, 216, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 255, 249)) }), Rotation = -90 })
					I[38] = new("UICorner", I[36], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[39] = new("UIStroke", I[36], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
			I[40] = new("TextLabel", I[31], "Progress", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 5, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.175), Text = "33/100", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 2 })
				I[41] = new("UIStroke", I[40], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
			I[42] = new("Frame", I[31], "div", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.075) })
			I[43] = new("UIListLayout", I[31], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[44] = new("Frame", I[31], "div_2", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 6, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.2) })
			I[45] = new("Frame", I[31], "StageHolder", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 7, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.15) })
				I[46] = new("UIListLayout", I[45], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[47] = new("ImageLabel", I[45], "StageImage", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://121779632121547"), LayoutOrder = 1, Size = UDim2.fromScale(1, 1) })
					I[48] = new("UIAspectRatioConstraint", I[47], "UIAspectRatioConstraint")
				I[49] = new("TextLabel", I[45], "Stage", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(0, 1), Text = "2/20 finished", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[50] = new("Frame", I[45], "Padding", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Size = UDim2.fromScale(0.02, 1) })
			I[51] = new("Frame", I[31], "div_3", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 4, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.075) })
		I[52] = new("Frame", I[1], "BossReq", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.3), Size = UDim2.fromScale(0.9, 0.2) })
			I[53] = new("UIListLayout", I[52], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 20), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[54] = new("ImageLabel", I[52], "BossIcon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131034333228118"), LayoutOrder = 1, Position = UDim2.fromScale(0.2, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(0, 130, 0.7, 0) })
				I[55] = new("UIStroke", I[54], "UIStroke", { Thickness = 3.4000001 })
				I[56] = new("UICorner", I[54], "UICorner")
				I[57] = new("UIAspectRatioConstraint", I[54], "UIAspectRatioConstraint")
			I[58] = new("TextLabel", I[52], "Text", { AnchorPoint = Vector2.new(0, 0.5), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LineHeight = 0.9, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0, 10, 1, 0), Text = "BOSS", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 18, TextStrokeColor3 = Color3.fromRGB(109, 72, 28), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 2 })
				I[59] = new("UIStroke", I[58], "UIStroke", { Thickness = 3.75 })
	return I[1]
end

return build
