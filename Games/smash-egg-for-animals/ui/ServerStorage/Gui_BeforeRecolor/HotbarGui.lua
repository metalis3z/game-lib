-- Generated from ui/ServerStorage/Gui_BeforeRecolor/HotbarGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "HotbarGui", { DisplayOrder = 8, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextButton", I[1], "SlotTemplate", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromOffset(62, 62), Text = "", Visible = false }, { ["MontFix"] = true })
			I[3] = new("ViewportFrame", I[2], "View", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(5, 5), Size = UDim2.new(1, -10, 1, -10) })
				I[4] = new("UIGradient", I[3], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 232, 244)) }), Rotation = 90 })
			I[5] = new("TextLabel", I[2], "Key", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(5, 3), Size = UDim2.fromOffset(16, 16), Text = "1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
				I[6] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2 })
			I[7] = new("TextLabel", I[2], "Kg", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0, 3, 1, -16), Size = UDim2.new(1, -6, 0, 13), Text = "", TextColor3 = Color3.fromRGB(200, 235, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
				I[8] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2 })
			I[9] = new("TextLabel", I[2], "Count", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, -30, 0, 3), Size = UDim2.fromOffset(26, 16), Text = "", TextColor3 = Color3.fromRGB(255, 240, 150), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
				I[10] = new("UIStroke", I[9], "UIStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2 })
			I[11] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[12] = new("UIStroke", I[2], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(10, 10, 12), Thickness = 3.5 })
			I[13] = new("UIGradient", I[2], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(74, 74, 82)), ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 22)) }), Rotation = 90 })
			I[14] = new("UIScale", I[2], "UIScale")
		I[15] = new("Frame", I[1], "Dock", { AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 1, -10), Size = UDim2.fromOffset(700, 124) }, nil, { "AutoScale" })
			I[16] = new("Frame", I[15], "Bar", { AnchorPoint = Vector2.new(0.5, 1), AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromOffset(0, 70) })
				I[17] = new("UIListLayout", I[16], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[18] = new("TextButton", I[15], "HatchAll", { AnchorPoint = Vector2.new(0.5, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 1, -80), Size = UDim2.fromOffset(210, 42), Text = "Open All", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 1, TextWrapped = true, Visible = false }, nil, { "UIButton" })
				I[19] = new("TextLabel", I[18], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Open All", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
					I[20] = new("UIStroke", I[19], "TextStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2.5 })
					I[21] = new("UIPadding", I[19], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 6) })
				I[22] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[23] = new("UIStroke", I[18], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(36, 23, 51), Thickness = 3.5 })
				I[24] = new("UIGradient", I[18], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 214, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(245, 150, 50)) }), Rotation = 90 })
				I[25] = new("Frame", I[18], "FxGloss", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.72, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 4), Size = UDim2.new(1, -12, 0.34, 0), ZIndex = 2 })
					I[26] = new("UICorner", I[25], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[27] = new("Frame", I[18], "FxStitch", { BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), ZIndex = 2 })
					I[28] = new("UICorner", I[27], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[29] = new("UIStroke", I[27], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.5, Transparency = 0.5 })
				I[30] = new("ImageLabel", I[18], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26) })
					I[31] = new("UICorner", I[30], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[32] = new("UIGradient", I[30], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 214, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(245, 150, 50)) }), Rotation = 90 })
			I[33] = new("TextButton", I[15], "HarvestAll", { AnchorPoint = Vector2.new(0.5, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 112, 1, -80), Size = UDim2.fromOffset(210, 42), Text = "Harvest All", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 1, TextWrapped = true, Visible = false }, nil, { "UIButton" })
				I[34] = new("TextLabel", I[33], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Harvest All", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
					I[35] = new("UIStroke", I[34], "TextStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2.5 })
					I[36] = new("UIPadding", I[34], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 6) })
				I[37] = new("UICorner", I[33], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[38] = new("UIStroke", I[33], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(36, 23, 51), Thickness = 3.5 })
				I[39] = new("UIGradient", I[33], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 226, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 170, 70)) }), Rotation = 90 })
				I[40] = new("Frame", I[33], "FxGloss", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.72, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 4), Size = UDim2.new(1, -12, 0.34, 0), ZIndex = 2 })
					I[41] = new("UICorner", I[40], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[42] = new("Frame", I[33], "FxStitch", { BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), ZIndex = 2 })
					I[43] = new("UICorner", I[42], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[44] = new("UIStroke", I[42], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.5, Transparency = 0.5 })
				I[45] = new("ImageLabel", I[33], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26) })
					I[46] = new("UICorner", I[45], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[47] = new("UIGradient", I[45], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 226, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 170, 70)) }), Rotation = 90 })
	return I[1]
end

return build
