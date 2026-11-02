-- Generated from ui/ServerStorage/Gui_Before3D/SettingsGui.rbxm by _tools/rbxm2lua.luau
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
			I[3] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
			I[4] = new("UIGradient", I[2], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(78, 91, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(44, 52, 65)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
			I[5] = new("ImageLabel", I[2], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
				I[6] = new("UIGradient", I[5], "Tint", { Rotation = 90 })
			I[7] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(10, 10), Size = UDim2.new(1, -20, 0, 58) })
				I[8] = new("UIStroke", I[7], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[9] = new("UIGradient", I[7], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(64, 180, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(43, 164, 222)) }) }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 235, 20)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(215, 250, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 235, 20)) }) })
				I[10] = new("ImageLabel", I[7], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
					I[11] = new("UIGradient", I[10], "Tint", { Rotation = 90 })
				I[12] = new("TextLabel", I[7], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(68, 9), Size = UDim2.new(0, 300, 1, -18), Text = "Settings", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[13] = new("UIStroke", I[12], "TextStroke", { Thickness = 4.5 })
				I[14] = new("TextButton", I[7], "Close", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(1, -9, 0.5, 0), Size = UDim2.fromOffset(44, 44), Text = "", ZIndex = 2 }, { ["MontFix"] = true })
					I[15] = new("UIStroke", I[14], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[16] = new("UIGradient", I[14], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(0.4833887, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }), Rotation = 90 })
					I[17] = new("ImageLabel", I[14], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 0 })
						I[18] = new("UIGradient", I[17], "Tint", { Rotation = 90 })
					I[19] = new("Frame", I[14], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Rotation = 45, Size = UDim2.fromOffset(26, 7), ZIndex = 3 })
						I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 2 })
					I[21] = new("Frame", I[14], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Rotation = -45, Size = UDim2.fromOffset(26, 7), ZIndex = 3 })
						I[22] = new("UIStroke", I[21], "UIStroke", { Thickness = 2 })
			I[23] = new("UIScale", I[2], "Fit")
			I[24] = new("Frame", I[2], "Music", { BackgroundTransparency = 1, Position = UDim2.fromOffset(22, 84), Size = UDim2.new(1, -44, 0, 92), ZIndex = 2 })
				I[25] = new("TextLabel", I[24], "TextLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.new(0.6, 0, 0, 34), Text = "Music", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 26, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
					I[26] = new("UIStroke", I[25], "UIStroke", { Thickness = 3 })
				I[27] = new("TextLabel", I[24], "Value", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6, 0), Size = UDim2.new(0.4, 0, 0, 34), Text = "100%", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 26, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
					I[28] = new("UIStroke", I[27], "UIStroke", { Thickness = 3 })
				I[29] = new("TextButton", I[24], "Bar", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(28, 33, 40), Position = UDim2.fromOffset(0, 44), Size = UDim2.new(1, 0, 0, 30), Text = "", ZIndex = 3 })
					I[30] = new("UIStroke", I[29], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[31] = new("Frame", I[29], "Fill", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 4 })
						I[32] = new("UIGradient", I[31], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 192, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(74, 140, 200)) }), Rotation = 90 })
						I[33] = new("ImageLabel", I[31], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.6, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(30, 30), ZIndex = 5 })
					I[34] = new("Frame", I[29], "Knob", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromOffset(18, 44), ZIndex = 6 })
						I[35] = new("UIStroke", I[34], "UIStroke", { Thickness = 3 })
			I[36] = new("Frame", I[2], "Sfx", { BackgroundTransparency = 1, Position = UDim2.fromOffset(22, 186), Size = UDim2.new(1, -44, 0, 92), ZIndex = 2 })
				I[37] = new("TextLabel", I[36], "TextLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.new(0.6, 0, 0, 34), Text = "Sound effects", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 26, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
					I[38] = new("UIStroke", I[37], "UIStroke", { Thickness = 3 })
				I[39] = new("TextLabel", I[36], "Value", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6, 0), Size = UDim2.new(0.4, 0, 0, 34), Text = "100%", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 26, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
					I[40] = new("UIStroke", I[39], "UIStroke", { Thickness = 3 })
				I[41] = new("TextButton", I[36], "Bar", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(28, 33, 40), Position = UDim2.fromOffset(0, 44), Size = UDim2.new(1, 0, 0, 30), Text = "", ZIndex = 3 })
					I[42] = new("UIStroke", I[41], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[43] = new("Frame", I[41], "Fill", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 4 })
						I[44] = new("UIGradient", I[43], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(106, 183, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 176, 240)) }), Rotation = 90 })
						I[45] = new("ImageLabel", I[43], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.6, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(30, 30), ZIndex = 5 })
					I[46] = new("Frame", I[41], "Knob", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromOffset(18, 44), ZIndex = 6 })
						I[47] = new("UIStroke", I[46], "UIStroke", { Thickness = 3 })
		I[48] = new("TextButton", I[1], "Open", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(1, -14, 0, 66), Size = UDim2.fromOffset(58, 58), Text = "", Visible = false })
			I[49] = new("UIGradient", I[48], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 160, 180)), ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 96, 116)) }), Rotation = 90 })
			I[50] = new("UIStroke", I[48], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
			I[51] = new("ImageLabel", I[48], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://106209837661975"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.86, 0.86), ZIndex = 2 })
			I[52] = new("ImageLabel", I[48], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.7, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(29, 29) })
	return I[1]
end

return build
