-- Generated from ui/StarterGui/PetInventoryGui.rbxm by _tools/rbxm2lua.luau
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
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, Position = UDim2.new(0.5, 44, 0.46, 0), Size = UDim2.fromOffset(880, 540), Visible = false }, nil, { "AutoScale" })
			I[3] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 0, 72) })
				I[4] = new("ImageLabel", I[3], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(32, 32), Visible = false, ZIndex = 0 })
					I[5] = new("UIGradient", I[4], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(64, 180, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(43, 164, 222)) }) }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 140, 20)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 222, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 20)) }) })
				I[6] = new("TextLabel", I[3], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Italic), Position = UDim2.fromOffset(20, 6), Size = UDim2.fromOffset(330, 38), Text = "All Pets", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 4.5 })
				I[8] = new("TextButton", I[3], "Close", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, -12, 0.5, -1), Size = UDim2.fromOffset(54, 48), Text = "", ZIndex = 2 }, { ["MontFix"] = true }, { "UIButton" })
					I[9] = new("UIStroke", I[8], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[10] = new("Frame", I[8], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = 45, Size = UDim2.fromOffset(26, 7), Visible = false, ZIndex = 3 })
						I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 1.5 })
					I[12] = new("Frame", I[8], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = -45, Size = UDim2.fromOffset(26, 7), Visible = false, ZIndex = 3 })
						I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 1.5 })
					I[14] = new("UIGradient", I[8], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(0.4833887, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }), Rotation = 90 })
					I[15] = new("TextLabel", I[8], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 5 })
						I[16] = new("UIPadding", I[15], "UIPadding", { PaddingBottom = UDim.new(0.12, 0), PaddingLeft = UDim.new(0.12, 0), PaddingRight = UDim.new(0.12, 0), PaddingTop = UDim.new(0.12, 0) })
						I[17] = new("UIStroke", I[15], "UIStroke", { Thickness = 3 })
					I[18] = new("ImageLabel", I[8], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), Visible = false, ZIndex = 2 })
						I[19] = new("UIGradient", I[18], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 70, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 0, 26)) }), Rotation = 90 })
				I[20] = new("TextLabel", I[3], "Counter", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(22, 46), Size = UDim2.fromOffset(430, 18), Text = "", TextColor3 = Color3.fromRGB(255, 246, 196), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 2 })
				I[22] = new("ImageLabel", I[3], "HeaderIcon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://135211112386622"), Position = UDim2.new(0, 10, 0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(50, 50), Visible = false, ZIndex = 3 })
				I[23] = new("UIStroke", I[3], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Enabled = false, Thickness = 3 })
				I[24] = new("UIGradient", I[3], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 210, 76)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 120, 22)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 140, 20)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 222, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 20)) }) })
				I[25] = new("CanvasGroup", I[3], "Shine", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
					I[26] = new("Frame", I[25], "Stripe", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.68, BorderSizePixel = 0, Position = UDim2.fromScale(0.52, 0.5), Rotation = 28, Size = UDim2.new(0, 44, 2.5999999, 0) })
					I[27] = new("Frame", I[25], "Stripe", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.68, BorderSizePixel = 0, Position = UDim2.fromScale(0.595, 0.5), Rotation = 28, Size = UDim2.new(0, 38, 2.5999999, 0) })
					I[28] = new("Frame", I[25], "Stripe", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.68, BorderSizePixel = 0, Position = UDim2.fromScale(0.67, 0.5), Rotation = 28, Size = UDim2.new(0, 32, 2.5999999, 0) })
				I[29] = new("TextBox", I[3], "Search", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(60, 32, 10), BackgroundTransparency = 0.15, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(190, 194, 204), PlaceholderText = "Search", Position = UDim2.new(1, -78, 0.5, -1), Size = UDim2.fromOffset(230, 40), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
					I[30] = new("UIStroke", I[29], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[31] = new("UIPadding", I[29], "UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 8) })
				I[32] = new("Frame", I[3], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, 3) })
				I[33] = new("Frame", I[3], "Inner", { BackgroundTransparency = 1, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 1, -6) })
					I[34] = new("UIStroke", I[33], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2, Transparency = 0.45 })
			I[35] = new("Frame", I[2], "Tabs", { BackgroundTransparency = 1, Position = UDim2.fromOffset(-106, 6), Size = UDim2.fromOffset(94, 220) })
				I[36] = new("TextButton", I[35], "PetsTab", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 94), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 1, TextWrapped = true }, nil, { "UIButton" })
					I[37] = new("TextLabel", I[36], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0, 4, 0.9468085, -28), Size = UDim2.new(1, -8, 0.1170213, 22), Text = "Pets", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
						I[38] = new("UIStroke", I[37], "TextStroke", { Thickness = 2.5 })
						I[39] = new("UIPadding", I[37], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingTop = UDim.new(0, 6) })
					I[40] = new("ImageLabel", I[36], "TabIcon", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxthumb://type=Asset&id=128895446491384&w=150&h=150"), Position = UDim2.new(0.5, 0, 0, 8), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(54, 54), ZIndex = 3 })
					I[41] = new("UIStroke", I[36], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3.5 })
					I[42] = new("UIGradient", I[36], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(232, 190, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 124, 72)) }), Rotation = 90 })
					I[43] = new("ImageLabel", I[36], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), Visible = false })
						I[44] = new("UIGradient", I[43], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(232, 190, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 124, 72)) }), Rotation = 90 })
				I[45] = new("TextButton", I[35], "EggsTab", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 94), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 1, TextWrapped = true }, nil, { "UIButton" })
					I[46] = new("TextLabel", I[45], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0, 4, 0.9574468, -28), Size = UDim2.new(1, -8, 0.106383, 22), Text = "Eggs", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
						I[47] = new("UIStroke", I[46], "TextStroke", { Thickness = 2.5 })
						I[48] = new("UIPadding", I[46], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingTop = UDim.new(0, 6) })
					I[49] = new("ImageLabel", I[45], "TabIcon", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://132030564859829"), Position = UDim2.new(0.5, 0, 0, 8), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(54, 54), ZIndex = 3 })
					I[50] = new("UIStroke", I[45], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3.5 })
					I[51] = new("UIGradient", I[45], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(232, 190, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 124, 72)) }), Rotation = 90 })
					I[52] = new("ImageLabel", I[45], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), Visible = false })
						I[53] = new("UIGradient", I[52], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(232, 190, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 124, 72)) }), Rotation = 90 })
				I[54] = new("UIListLayout", I[35], "UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder })
			I[55] = new("ScrollingFrame", I[2], "Grid", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(22, 24, 34), BackgroundTransparency = 0.25, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromOffset(14, 88), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 6, Size = UDim2.new(1, -28, 1, -160) })
				I[56] = new("UIGridLayout", I[55], "UIGridLayout", { CellPadding = UDim2.fromOffset(10, 12), CellSize = UDim2.fromOffset(128, 158), SortOrder = Enum.SortOrder.LayoutOrder })
				I[57] = new("UIPadding", I[55], "UIPadding", { PaddingBottom = UDim.new(0, 12), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 10) })
				I[58] = new("UIStroke", I[55], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Enabled = false, Thickness = 3 })
			I[59] = new("TextLabel", I[2], "Hint", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0, 18, 1, -58), Size = UDim2.new(1, -430, 0, 40), Text = "", TextColor3 = Color3.fromRGB(214, 220, 240), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[60] = new("UIStroke", I[59], "UIStroke", { Thickness = 2 })
				I[61] = new("UITextSizeConstraint", I[59], "UITextSizeConstraint", { MaxTextSize = 15, MinTextSize = 8 })
			I[62] = new("TextLabel", I[2], "Empty", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, 0.55), Size = UDim2.new(0.8, 0, 0, 34), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, Visible = false })
				I[63] = new("UIStroke", I[62], "UIStroke", { Thickness = 2 })
			I[64] = new("TextButton", I[2], "PlaceBest", { AnchorPoint = Vector2.new(1, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, -14, 1, -16), Size = UDim2.fromOffset(200, 46), Text = "Place Best", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 1, TextWrapped = true }, nil, { "UIButton" })
				I[65] = new("TextLabel", I[64], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Place Best", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
					I[66] = new("UIStroke", I[65], "TextStroke", { Thickness = 2.5 })
					I[67] = new("UIPadding", I[65], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 6) })
				I[68] = new("UIStroke", I[64], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3.5 })
				I[69] = new("UIGradient", I[64], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(196, 255, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(52, 200, 40)) }), Rotation = 90 })
				I[70] = new("ImageLabel", I[64], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), Visible = false })
					I[71] = new("UIGradient", I[70], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 214, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(79, 176, 245)) }), Rotation = 90 })
			I[72] = new("TextButton", I[2], "Delete", { AnchorPoint = Vector2.new(1, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, -228, 1, -16), Size = UDim2.fromOffset(160, 46), Text = "Delete", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 1, TextWrapped = true }, nil, { "UIButton" })
				I[73] = new("TextLabel", I[72], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Delete", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
					I[74] = new("UIStroke", I[73], "TextStroke", { Thickness = 2.5 })
					I[75] = new("UIPadding", I[73], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 6) })
				I[76] = new("UIStroke", I[72], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3.5 })
				I[77] = new("UIGradient", I[72], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 130, 120)), ColorSequenceKeypoint.new(1, Color3.fromRGB(214, 56, 66)) }), Rotation = 90 })
				I[78] = new("ImageLabel", I[72], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), Visible = false })
					I[79] = new("UIGradient", I[78], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 130, 120)), ColorSequenceKeypoint.new(1, Color3.fromRGB(214, 56, 66)) }), Rotation = 90 })
			I[80] = new("UIStroke", I[2], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
			I[81] = new("UIGradient", I[2], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(58, 62, 84)), ColorSequenceKeypoint.new(1, Color3.fromRGB(34, 36, 52)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
			I[82] = new("Frame", I[2], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, 4) })
		I[83] = new("TextButton", I[1], "SlotTemplate", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Text = "", Visible = false }, { ["MontFix"] = true }, { "UIButton" })
			I[84] = new("ViewportFrame", I[83], "View", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(6, 36), Size = UDim2.new(1, -12, 1, -62), ZIndex = 2 })
			I[85] = new("TextLabel", I[83], "PetName", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 0, 18), Text = "Pet", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 4 })
				I[86] = new("UIStroke", I[85], "UIStroke", { Thickness = 2 })
			I[87] = new("TextLabel", I[83], "Rarity", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(6, 22), Size = UDim2.new(1, -12, 0, 13), Text = "Common", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 4 })
				I[88] = new("UIStroke", I[87], "UIStroke", { Thickness = 2 })
			I[89] = new("TextLabel", I[83], "Kg", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0, 4, 1, -20), Size = UDim2.new(1, -8, 0, 15), Text = "1.00 kg", TextColor3 = Color3.fromRGB(200, 235, 255), TextScaled = true, TextWrapped = true, ZIndex = 4 })
				I[90] = new("UIStroke", I[89], "UIStroke", { Thickness = 2 })
			I[91] = new("TextLabel", I[83], "Placed", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(10, 10), Size = UDim2.fromOffset(52, 18), Text = "PLACED", TextColor3 = Color3.fromRGB(110, 255, 130), TextScaled = true, TextWrapped = true, Visible = false, ZIndex = 5 })
				I[92] = new("UIStroke", I[91], "UIStroke", { Thickness = 2 })
			I[93] = new("UIStroke", I[83], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
			I[94] = new("UIGradient", I[83], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 154, 170)), ColorSequenceKeypoint.new(1, Color3.fromRGB(84, 88, 104)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 226, 160)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 168, 100)) }) })
			I[95] = new("Frame", I[83], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, 3) })
			I[96] = new("Frame", I[83], "RaysClip", { BackgroundTransparency = 1, ClipsDescendants = true, Size = UDim2.fromScale(1, 1) })
				I[97] = new("ImageLabel", I[96], "Rays", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://81911207340002"), ImageTransparency = 0.45, Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(1.7, 1.7), SizeConstraint = Enum.SizeConstraint.RelativeXX })
			I[98] = new("Frame", I[83], "Strip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.45, BorderSizePixel = 0, Position = UDim2.new(0, 0, 1, -24), Size = UDim2.new(1, 0, 0, 24), ZIndex = 3 })
			I[99] = new("Frame", I[83], "Inner", { BackgroundTransparency = 1, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 1, -6), ZIndex = 3 })
				I[100] = new("UIStroke", I[99], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2, Transparency = 0.5 })
		I[101] = new("TextLabel", I[1], "Toast", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.6), Size = UDim2.fromOffset(640, 46), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, Visible = false }, nil, { "AutoScale" })
			I[102] = new("UIStroke", I[101], "UIStroke", { Thickness = 3.5 })
			I[103] = new("UIPadding", I[101], "UIPadding", { PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 14), PaddingTop = UDim.new(0, 8) })
	return I[1]
end

return build
