-- Generated from ui/ServerStorage/Gui_BeforeRecolor/left bottom.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "left bottom", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Holder", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.new(0, 14, 0.5, 0), Size = UDim2.fromOffset(180, 310) }, nil, { "AutoScale" })
			I[3] = new("TextButton", I[2], "IndexButton", { AutoButtonColor = false, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(86, 98), Text = "" }, { ["MontFix"] = true }, { "UIButton" })
				I[4] = new("Frame", I[3], "Face", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 1, -7), ZIndex = 2 })
					I[5] = new("ImageLabel", I[4], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
						I[6] = new("UIGradient", I[5], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 236, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 164, 74)) }), Rotation = 90 })
						I[7] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[8] = new("ImageLabel", I[4], "Icon", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://79640278698024"), Position = UDim2.new(0.5116279, 0, 0.0769231, 6), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(76, 64), ZIndex = 3 })
					I[9] = new("TextLabel", I[4], "Label", { AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.9450549, -5), Size = UDim2.new(1, -8, 0, 26), Text = "Index", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 19, ZIndex = 4 }, { ["MontFix"] = true })
						I[10] = new("UIStroke", I[9], "TextStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2.5 })
					I[11] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[12] = new("UIStroke", I[4], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(36, 23, 51), Thickness = 3 })
					I[13] = new("UIGradient", I[4], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 236, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 164, 74)) }), Rotation = 90 })
				I[14] = new("Frame", I[3], "Lip", { BackgroundColor3 = Color3.fromRGB(40, 116, 54), Size = UDim2.new(1, 0, 1.03, -7) })
					I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[16] = new("UIStroke", I[14], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(36, 23, 51), Thickness = 3 })
			I[17] = new("TextButton", I[2], "ShopButton", { AutoButtonColor = false, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.new(0.5, 0, 0, 114), Size = UDim2.fromOffset(86, 98), Text = "" }, { ["MontFix"] = true }, { "UIButton" })
				I[18] = new("Frame", I[17], "Face", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 1, -7), ZIndex = 2 })
					I[19] = new("ImageLabel", I[18], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
						I[20] = new("UIGradient", I[19], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 224, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(245, 150, 50)) }), Rotation = 90 })
						I[21] = new("UICorner", I[19], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[22] = new("TextLabel", I[18], "Label", { AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.956044, -5), Size = UDim2.new(1, -8, 0, 26), Text = "Shop", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 19, ZIndex = 4 }, { ["MontFix"] = true })
						I[23] = new("UIStroke", I[22], "TextStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2.5 })
					I[24] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[25] = new("UIStroke", I[18], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(36, 23, 51), Thickness = 3 })
					I[26] = new("UIGradient", I[18], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 224, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(245, 150, 50)) }), Rotation = 90 })
					I[27] = new("Frame", I[18], "Icon", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0, 7), Size = UDim2.fromOffset(52, 52), ZIndex = 3 })
						I[28] = new("ImageLabel", I[27], "IconImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://84499021410249"), Position = UDim2.fromScale(0.5, 0.6538461), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(60, 60), ZIndex = 3 })
				I[29] = new("Frame", I[17], "Lip", { BackgroundColor3 = Color3.fromRGB(255, 170, 0), BackgroundTransparency = 0.5, Position = UDim2.fromOffset(0, 7), Size = UDim2.new(1, 0, 0.95, -7) })
					I[30] = new("UICorner", I[29], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[31] = new("UIStroke", I[29], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(36, 23, 51), Thickness = 3 })
			I[32] = new("TextButton", I[2], "CodesButton", { AutoButtonColor = false, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 4, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(86, 98), Text = "" }, { ["MontFix"] = true })
				I[33] = new("Frame", I[32], "Lip", { BackgroundColor3 = Color3.fromRGB(40, 116, 54), BorderSizePixel = 0, Size = UDim2.new(1, 0, 1.03, -7) })
					I[34] = new("UICorner", I[33], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[35] = new("UIStroke", I[33], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(36, 23, 51), Thickness = 3 })
				I[36] = new("Frame", I[32], "Face", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 1, -7), ZIndex = 2 })
					I[37] = new("UICorner", I[36], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[38] = new("UIStroke", I[36], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(36, 23, 51), Thickness = 3 })
					I[39] = new("UIGradient", I[36], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 170, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 255)) }), Rotation = 90 })
					I[40] = new("ImageLabel", I[36], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
						I[41] = new("UICorner", I[40], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
						I[42] = new("UIGradient", I[40], "Tint", { Rotation = 90 })
					I[43] = new("ImageLabel", I[36], "Icon", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://128930198031680"), Position = UDim2.new(0.5, 0, 0, 6), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(76, 64), ZIndex = 3 })
					I[44] = new("TextLabel", I[36], "Label", { AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.945, -5), Size = UDim2.new(1, -8, 0, 26), Text = "Codes", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 19, ZIndex = 4 }, { ["MontFix"] = true })
						I[45] = new("UIStroke", I[44], "TextStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2.5 })
			I[46] = new("UIGridLayout", I[2], "UIGridLayout", { CellPadding = UDim2.fromOffset(8, 8), CellSize = UDim2.fromOffset(86, 98), FillDirectionMaxCells = 2, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
	return I[1]
end

return build
