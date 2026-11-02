-- Generated from ui/ServerStorage/Gui_Before3Dv2/PetInventoryGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "PetInventoryGui", { DisplayOrder = 10, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextButton", I[1], "SlotTemplate", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Text = "", Visible = false }, { ["MontFix"] = true }, { "UIButton" })
			I[3] = new("ViewportFrame", I[2], "View", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.7, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(7, 7), Size = UDim2.new(1, -14, 0, 80) })
				I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 3 })
				I[5] = new("UIGradient", I[3], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 154, 166)), ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 94, 104)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 252, 240)), ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 226, 200)) }) })
			I[6] = new("TextLabel", I[2], "PetName", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(6, 90), Size = UDim2.new(1, -12, 0, 22), Text = "Pet", TextColor3 = Color3.fromRGB(160, 255, 120), TextScaled = true, TextWrapped = true })
				I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 2 })
			I[8] = new("TextLabel", I[2], "Rarity", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(10, 113), Size = UDim2.new(1, -20, 0, 16), Text = "Common", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
				I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 2 })
				I[10] = new("UIGradient", I[8], "UIGradient", { Enabled = false })
			I[11] = new("TextLabel", I[2], "Kg", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(10, 131), Size = UDim2.new(1, -20, 0, 15), Text = "1.00 kg", TextColor3 = Color3.fromRGB(200, 235, 255), TextScaled = true, TextWrapped = true })
				I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 2 })
			I[13] = new("TextLabel", I[2], "Placed", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(10, 10), Size = UDim2.fromOffset(52, 18), Text = "PLACED", TextColor3 = Color3.fromRGB(110, 255, 130), TextScaled = true, TextWrapped = true, Visible = false, ZIndex = 3 })
				I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 2 })
			I[15] = new("UIStroke", I[2], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
			I[16] = new("UIGradient", I[2], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 73, 82)), ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 40, 47)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 226, 160)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 168, 100)) }) })
			I[17] = new("ImageLabel", I[2], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.75, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
				I[18] = new("UIGradient", I[17], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 73, 82)), ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 40, 47)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 226, 160)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 168, 100)) }) })
		I[19] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, Position = UDim2.new(0.5, 44, 0.46, 0), Size = UDim2.fromOffset(880, 540), Visible = false }, nil, { "AutoScale" })
			I[20] = new("ImageLabel", I[19], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.72, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(32, 32), ZIndex = 0 })
				I[21] = new("UIGradient", I[20], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(96, 100, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(52, 55, 63)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
			I[22] = new("Frame", I[19], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 10), Size = UDim2.new(1, -20, 0, 58) })
				I[23] = new("ImageLabel", I[22], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(32, 32), Visible = false, ZIndex = 0 })
					I[24] = new("UIGradient", I[23], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(64, 180, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(43, 164, 222)) }) }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 140, 20)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 222, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 20)) }) })
				I[25] = new("TextLabel", I[22], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Italic), Position = UDim2.fromOffset(8, 0), Size = UDim2.fromOffset(430, 32), Text = "All Pets", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[26] = new("UIStroke", I[25], "UIStroke", { Thickness = 4.5 })
				I[27] = new("TextButton", I[22], "Close", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, -9, 0.5, 0), Size = UDim2.fromOffset(44, 44), Text = "", ZIndex = 2 }, { ["MontFix"] = true }, { "UIButton" })
					I[28] = new("UIStroke", I[27], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[29] = new("Frame", I[27], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = 45, Size = UDim2.fromOffset(26, 7), Visible = false, ZIndex = 3 })
						I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 1.5 })
					I[31] = new("Frame", I[27], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = -45, Size = UDim2.fromOffset(26, 7), Visible = false, ZIndex = 3 })
						I[32] = new("UIStroke", I[31], "UIStroke", { Thickness = 1.5 })
					I[33] = new("UIGradient", I[27], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(0.4833887, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }), Rotation = 90 })
					I[34] = new("TextLabel", I[27], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 5 })
						I[35] = new("UIPadding", I[34], "UIPadding", { PaddingBottom = UDim.new(0.12, 0), PaddingLeft = UDim.new(0.12, 0), PaddingRight = UDim.new(0.12, 0), PaddingTop = UDim.new(0.12, 0) })
						I[36] = new("UIStroke", I[34], "UIStroke", { Thickness = 3 })
					I[37] = new("ImageLabel", I[27], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 2 })
						I[38] = new("UIGradient", I[37], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 70, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 0, 26)) }), Rotation = 90 })
				I[39] = new("TextLabel", I[22], "Counter", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(8, 34), Size = UDim2.fromOffset(430, 22), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[40] = new("UIStroke", I[39], "UIStroke", { Thickness = 2 })
				I[41] = new("ImageLabel", I[22], "HeaderIcon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://135211112386622"), Position = UDim2.new(0, 10, 0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(50, 50), Visible = false, ZIndex = 3 })
				I[42] = new("UIStroke", I[22], "UIStroke", { Enabled = false, Thickness = 3.5 })
				I[43] = new("UIGradient", I[22], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(64, 180, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(43, 164, 222)) }) }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 140, 20)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 222, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 20)) }) })
				I[44] = new("UIStroke", I[22], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Enabled = false, Thickness = 3 })
				I[45] = new("CanvasGroup", I[22], "Shine", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
					I[46] = new("Frame", I[45], "Stripe", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.68, BorderSizePixel = 0, Position = UDim2.fromScale(0.52, 0.5), Rotation = 28, Size = UDim2.new(0, 44, 2.5999999, 0) })
					I[47] = new("Frame", I[45], "Stripe", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.68, BorderSizePixel = 0, Position = UDim2.fromScale(0.595, 0.5), Rotation = 28, Size = UDim2.new(0, 38, 2.5999999, 0) })
					I[48] = new("Frame", I[45], "Stripe", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.68, BorderSizePixel = 0, Position = UDim2.fromScale(0.67, 0.5), Rotation = 28, Size = UDim2.new(0, 32, 2.5999999, 0) })
				I[49] = new("TextBox", I[22], "Search", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(30, 32, 38), BackgroundTransparency = 0.5, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(190, 194, 204), PlaceholderText = "Search", Position = UDim2.new(1, -66, 0.5, 0), Size = UDim2.fromOffset(240, 40), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
					I[50] = new("UIStroke", I[49], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2.5 })
					I[51] = new("UIPadding", I[49], "UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 8) })
			I[52] = new("Frame", I[19], "Tabs", { BackgroundTransparency = 1, Position = UDim2.fromOffset(-106, 6), Size = UDim2.fromOffset(94, 220) })
				I[53] = new("TextButton", I[52], "PetsTab", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 94), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 1, TextWrapped = true }, nil, { "UIButton" })
					I[54] = new("TextLabel", I[53], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0, 4, 0.9468085, -28), Size = UDim2.new(1, -8, 0.1170213, 22), Text = "Pets", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
						I[55] = new("UIStroke", I[54], "TextStroke", { Thickness = 2.5 })
						I[56] = new("UIPadding", I[54], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingTop = UDim.new(0, 6) })
					I[57] = new("ImageLabel", I[53], "TabIcon", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxthumb://type=Asset&id=128895446491384&w=150&h=150"), Position = UDim2.new(0.5, 0, 0, 8), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(54, 54), ZIndex = 3 })
					I[58] = new("UIStroke", I[53], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3.5 })
					I[59] = new("UIGradient", I[53], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(232, 190, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 124, 72)) }), Rotation = 90 })
					I[60] = new("ImageLabel", I[53], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26) })
						I[61] = new("UIGradient", I[60], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(232, 190, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 124, 72)) }), Rotation = 90 })
				I[62] = new("TextButton", I[52], "EggsTab", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 94), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 1, TextWrapped = true }, nil, { "UIButton" })
					I[63] = new("TextLabel", I[62], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0, 4, 0.9574468, -28), Size = UDim2.new(1, -8, 0.106383, 22), Text = "Eggs", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
						I[64] = new("UIStroke", I[63], "TextStroke", { Thickness = 2.5 })
						I[65] = new("UIPadding", I[63], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingTop = UDim.new(0, 6) })
					I[66] = new("ImageLabel", I[62], "TabIcon", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://132030564859829"), Position = UDim2.new(0.5, 0, 0, 8), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(54, 54), ZIndex = 3 })
					I[67] = new("UIStroke", I[62], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3.5 })
					I[68] = new("UIGradient", I[62], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(232, 190, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 124, 72)) }), Rotation = 90 })
					I[69] = new("ImageLabel", I[62], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26) })
						I[70] = new("UIGradient", I[69], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(232, 190, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 124, 72)) }), Rotation = 90 })
				I[71] = new("UIListLayout", I[52], "UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder })
			I[72] = new("ScrollingFrame", I[19], "Grid", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromOffset(14, 76), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 6, Size = UDim2.new(1, -28, 1, -122) })
				I[73] = new("UIGridLayout", I[72], "UIGridLayout", { CellPadding = UDim2.fromOffset(10, 10), CellSize = UDim2.fromOffset(124, 152), SortOrder = Enum.SortOrder.LayoutOrder })
				I[74] = new("UIPadding", I[72], "UIPadding", { PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 10), PaddingTop = UDim.new(0, 10) })
				I[75] = new("UIStroke", I[72], "UIStroke", { Enabled = false, Thickness = 3 })
				I[76] = new("UIGradient", I[72], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(36, 42, 52)), ColorSequenceKeypoint.new(1, Color3.fromRGB(24, 28, 35)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(232, 233, 240)), ColorSequenceKeypoint.new(1, Color3.fromRGB(198, 200, 212)) }) })
				I[77] = new("UIStroke", I[72], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Enabled = false, Thickness = 3 })
			I[78] = new("TextLabel", I[19], "Hint", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0, 18, 1, -36), Size = UDim2.new(1, -250, 0, 22), Text = "", TextColor3 = Color3.fromRGB(255, 240, 210), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[79] = new("UIStroke", I[78], "UIStroke", { Thickness = 2 })
			I[80] = new("TextLabel", I[19], "Empty", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, 0.55), Size = UDim2.new(0.8, 0, 0, 34), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, Visible = false })
				I[81] = new("UIStroke", I[80], "UIStroke", { Thickness = 2 })
			I[82] = new("TextButton", I[19], "PlaceBest", { AnchorPoint = Vector2.new(1, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, -14, 1, -8), Size = UDim2.fromOffset(200, 36), Text = "Place Best", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 1, TextWrapped = true }, nil, { "UIButton" })
				I[83] = new("TextLabel", I[82], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Place Best", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
					I[84] = new("UIStroke", I[83], "TextStroke", { Thickness = 2.5 })
					I[85] = new("UIPadding", I[83], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 6) })
				I[86] = new("UIStroke", I[82], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3.5 })
				I[87] = new("UIGradient", I[82], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 214, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(79, 176, 245)) }), Rotation = 90 })
				I[88] = new("ImageLabel", I[82], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26) })
					I[89] = new("UIGradient", I[88], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 214, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(79, 176, 245)) }), Rotation = 90 })
			I[90] = new("TextButton", I[19], "Delete", { AnchorPoint = Vector2.new(0, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, -10), Size = UDim2.fromOffset(176, 44), Text = "Delete", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 1, TextWrapped = true }, nil, { "UIButton" })
				I[91] = new("TextLabel", I[90], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Delete", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
					I[92] = new("UIStroke", I[91], "TextStroke", { Thickness = 2.5 })
					I[93] = new("UIPadding", I[91], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 6) })
				I[94] = new("UIStroke", I[90], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3.5 })
				I[95] = new("UIGradient", I[90], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 130, 120)), ColorSequenceKeypoint.new(1, Color3.fromRGB(214, 56, 66)) }), Rotation = 90 })
				I[96] = new("ImageLabel", I[90], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26) })
					I[97] = new("UIGradient", I[96], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 130, 120)), ColorSequenceKeypoint.new(1, Color3.fromRGB(214, 56, 66)) }), Rotation = 90 })
			I[98] = new("UIStroke", I[19], "UIStroke", { Thickness = 4.5 })
			I[99] = new("UIGradient", I[19], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(96, 100, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(52, 55, 63)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
			I[100] = new("UIStroke", I[19], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
		I[101] = new("TextLabel", I[1], "Toast", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.6), Size = UDim2.fromOffset(640, 46), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, Visible = false }, nil, { "AutoScale" })
			I[102] = new("UIStroke", I[101], "UIStroke", { Thickness = 3.5 })
			I[103] = new("UIPadding", I[101], "UIPadding", { PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 14), PaddingTop = UDim.new(0, 8) })
	return I[1]
end

return build
