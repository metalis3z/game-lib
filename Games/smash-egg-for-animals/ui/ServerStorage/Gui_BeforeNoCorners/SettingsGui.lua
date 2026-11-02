-- Generated from ui/ServerStorage/Gui_BeforeNoCorners/SettingsGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SettingsGui", { DisplayOrder = 5, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.47), Size = UDim2.fromOffset(460, 300), Visible = false })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[4] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
			I[5] = new("UIGradient", I[2], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(78, 91, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(44, 52, 65)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
			I[6] = new("ImageLabel", I[2], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
				I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[8] = new("UIGradient", I[6], "Tint", { Rotation = 90 })
			I[9] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(10, 10), Size = UDim2.new(1, -20, 0, 58) })
				I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[11] = new("UIStroke", I[9], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[12] = new("UIGradient", I[9], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(64, 180, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(43, 164, 222)) }) }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 235, 20)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(215, 250, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 235, 20)) }) })
				I[13] = new("ImageLabel", I[9], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
					I[14] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[15] = new("UIGradient", I[13], "Tint", { Rotation = 90 })
				I[16] = new("TextLabel", I[9], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(68, 9), Size = UDim2.new(0, 300, 1, -18), Text = "Settings", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[17] = new("UIStroke", I[16], "TextStroke", { Thickness = 4.5 })
				I[18] = new("TextButton", I[9], "Close", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(1, -9, 0.5, 0), Size = UDim2.fromOffset(44, 44), Text = "", ZIndex = 2 }, { ["MontFix"] = true })
					I[19] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[20] = new("UIStroke", I[18], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[21] = new("UIGradient", I[18], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(0.4833887, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }), Rotation = 90 })
					I[22] = new("ImageLabel", I[18], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 0 })
						I[23] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
						I[24] = new("UIGradient", I[22], "Tint", { Rotation = 90 })
					I[25] = new("Frame", I[18], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Rotation = 45, Size = UDim2.fromOffset(26, 7), ZIndex = 3 })
						I[26] = new("UICorner", I[25], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
						I[27] = new("UIStroke", I[25], "UIStroke", { Thickness = 2 })
					I[28] = new("Frame", I[18], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Rotation = -45, Size = UDim2.fromOffset(26, 7), ZIndex = 3 })
						I[29] = new("UICorner", I[28], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
						I[30] = new("UIStroke", I[28], "UIStroke", { Thickness = 2 })
			I[31] = new("UIScale", I[2], "Fit")
			I[32] = new("Frame", I[2], "Music", { BackgroundTransparency = 1, Position = UDim2.fromOffset(22, 84), Size = UDim2.new(1, -44, 0, 92), ZIndex = 2 })
				I[33] = new("TextLabel", I[32], "TextLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.new(0.6, 0, 0, 34), Text = "Music", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 26, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
					I[34] = new("UIStroke", I[33], "UIStroke", { Thickness = 3 })
				I[35] = new("TextLabel", I[32], "Value", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6, 0), Size = UDim2.new(0.4, 0, 0, 34), Text = "100%", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 26, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
					I[36] = new("UIStroke", I[35], "UIStroke", { Thickness = 3 })
				I[37] = new("TextButton", I[32], "Bar", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(28, 33, 40), Position = UDim2.fromOffset(0, 44), Size = UDim2.new(1, 0, 0, 30), Text = "", ZIndex = 3 })
					I[38] = new("UIStroke", I[37], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[39] = new("UICorner", I[37], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[40] = new("Frame", I[37], "Fill", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 4 })
						I[41] = new("UIGradient", I[40], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 192, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(74, 140, 200)) }), Rotation = 90 })
						I[42] = new("ImageLabel", I[40], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.6, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(30, 30), ZIndex = 5 })
					I[43] = new("Frame", I[37], "Knob", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromOffset(18, 44), ZIndex = 6 })
						I[44] = new("UIStroke", I[43], "UIStroke", { Thickness = 3 })
						I[45] = new("UICorner", I[43], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[46] = new("Frame", I[2], "Sfx", { BackgroundTransparency = 1, Position = UDim2.fromOffset(22, 186), Size = UDim2.new(1, -44, 0, 92), ZIndex = 2 })
				I[47] = new("TextLabel", I[46], "TextLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.new(0.6, 0, 0, 34), Text = "Sound effects", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 26, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
					I[48] = new("UIStroke", I[47], "UIStroke", { Thickness = 3 })
				I[49] = new("TextLabel", I[46], "Value", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6, 0), Size = UDim2.new(0.4, 0, 0, 34), Text = "100%", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 26, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
					I[50] = new("UIStroke", I[49], "UIStroke", { Thickness = 3 })
				I[51] = new("TextButton", I[46], "Bar", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(28, 33, 40), Position = UDim2.fromOffset(0, 44), Size = UDim2.new(1, 0, 0, 30), Text = "", ZIndex = 3 })
					I[52] = new("UIStroke", I[51], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[53] = new("UICorner", I[51], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[54] = new("Frame", I[51], "Fill", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 4 })
						I[55] = new("UIGradient", I[54], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(106, 183, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 176, 240)) }), Rotation = 90 })
						I[56] = new("ImageLabel", I[54], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.6, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(30, 30), ZIndex = 5 })
					I[57] = new("Frame", I[51], "Knob", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromOffset(18, 44), ZIndex = 6 })
						I[58] = new("UIStroke", I[57], "UIStroke", { Thickness = 3 })
						I[59] = new("UICorner", I[57], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
		I[60] = new("TextButton", I[1], "Open", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(1, -14, 0, 66), Size = UDim2.fromOffset(58, 58), Text = "", Visible = false })
			I[61] = new("UIGradient", I[60], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 160, 180)), ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 96, 116)) }), Rotation = 90 })
			I[62] = new("UIStroke", I[60], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
			I[63] = new("UICorner", I[60], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[64] = new("ImageLabel", I[60], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://106209837661975"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.86, 0.86), ZIndex = 2 })
			I[65] = new("ImageLabel", I[60], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.7, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(29, 29) })
	return I[1]
end

return build
