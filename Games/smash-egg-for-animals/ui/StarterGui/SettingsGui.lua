-- Generated from ui/StarterGui/SettingsGui.rbxm by _tools/rbxm2lua.luau
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
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(44, 40, 52), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.47), Size = UDim2.fromOffset(480, 312), Visible = false })
			I[3] = new("UIScale", I[2], "Fit")
			I[4] = new("UIStroke", I[2], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
			I[5] = new("Frame", I[2], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, 3) })
			I[6] = new("ImageLabel", I[2], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.93, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(40, 40), Visible = false })
			I[7] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 72), ZIndex = 2 })
				I[8] = new("UIGradient", I[7], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 200, 222)) }), Rotation = 90 })
				I[9] = new("UIStroke", I[7], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[10] = new("Frame", I[7], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, 3), ZIndex = 2 })
				I[11] = new("Frame", I[7], "Gloss", { BackgroundTransparency = 1, ClipsDescendants = true, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
					I[12] = new("ImageLabel", I[11], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.86, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(36, 36), Visible = false, ZIndex = 2 })
					I[13] = new("Frame", I[11], "Shine", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.78, BorderSizePixel = 0, Position = UDim2.fromScale(0.6, 0.5), Rotation = 24, Size = UDim2.fromScale(0.07, 3), ZIndex = 2 })
					I[14] = new("Frame", I[11], "Shine", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.78, BorderSizePixel = 0, Position = UDim2.fromScale(0.72, 0.5), Rotation = 24, Size = UDim2.fromScale(0.035, 3), ZIndex = 2 })
				I[15] = new("TextLabel", I[7], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(18, 9), Size = UDim2.new(0.7, 0, 0, 52), Text = "Settings", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
					I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 3 })
				I[17] = new("TextButton", I[7], "Close", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.new(1, -12, 0.5, -2), Size = UDim2.fromOffset(56, 50), Text = "", ZIndex = 3 })
					I[18] = new("UIGradient", I[17], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 10, 20)) }), Rotation = 90 })
					I[19] = new("UIStroke", I[17], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[20] = new("Frame", I[17], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, 3), ZIndex = 3 })
					I[21] = new("Frame", I[17], "Gloss", { BackgroundTransparency = 1, ClipsDescendants = true, Size = UDim2.fromScale(1, 1), ZIndex = 3 })
						I[22] = new("ImageLabel", I[21], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.86, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(36, 36), Visible = false, ZIndex = 3 })
						I[23] = new("Frame", I[21], "Shine", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.78, BorderSizePixel = 0, Position = UDim2.fromScale(0.6, 0.5), Rotation = 24, Size = UDim2.fromScale(0.07, 3), ZIndex = 3 })
						I[24] = new("Frame", I[21], "Shine", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.78, BorderSizePixel = 0, Position = UDim2.fromScale(0.72, 0.5), Rotation = 24, Size = UDim2.fromScale(0.035, 3), ZIndex = 3 })
					I[25] = new("TextLabel", I[17], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.06, 0.14), Size = UDim2.fromScale(0.88, 0.68), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 4 })
						I[26] = new("UIStroke", I[25], "UIStroke", { Thickness = 3 })
			I[27] = new("Frame", I[2], "Music", { BackgroundColor3 = Color3.fromRGB(64, 62, 72), BorderSizePixel = 0, Position = UDim2.fromOffset(14, 90), Size = UDim2.new(1, -28, 0, 90), ZIndex = 2 })
				I[28] = new("UIStroke", I[27], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[29] = new("Frame", I[27], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, 2), ZIndex = 2 })
				I[30] = new("TextLabel", I[27], "TextLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(14, 12), Size = UDim2.new(0.46, -14, 0, 34), Text = "Music", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
					I[31] = new("UIStroke", I[30], "UIStroke", { Thickness = 3 })
				I[32] = new("TextLabel", I[27], "Hint", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(14, 52), Size = UDim2.new(0.46, -14, 0, 18), Text = "Background music!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
					I[33] = new("UIStroke", I[32], "UIStroke", { Thickness = 2 })
				I[34] = new("TextLabel", I[27], "Value", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0, 8), Size = UDim2.new(0.5, -18, 0, 22), Text = "100%", TextColor3 = Color3.fromRGB(255, 226, 90), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
					I[35] = new("UIStroke", I[34], "UIStroke", { Thickness = 2.5 })
				I[36] = new("TextButton", I[27], "Bar", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(30, 28, 36), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0, 46), Size = UDim2.new(0.5, -30, 0, 18), Text = "", ZIndex = 3 }, { ["NoFx"] = true })
					I[37] = new("UIStroke", I[36], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[38] = new("Frame", I[36], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, 2), ZIndex = 3 })
					I[39] = new("Frame", I[36], "Fill", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 3 })
						I[40] = new("UIGradient", I[39], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 232, 80)), ColorSequenceKeypoint.new(1, Color3.fromRGB(250, 170, 0)) }), Rotation = 90 })
					I[41] = new("Frame", I[36], "Knob", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromOffset(24, 32), ZIndex = 4 })
						I[42] = new("UIGradient", I[41], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 236, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(250, 176, 10)) }), Rotation = 90 })
						I[43] = new("UIStroke", I[41], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
						I[44] = new("Frame", I[41], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, 3), ZIndex = 4 })
			I[45] = new("Frame", I[2], "Sfx", { BackgroundColor3 = Color3.fromRGB(64, 62, 72), BorderSizePixel = 0, Position = UDim2.fromOffset(14, 198), Size = UDim2.new(1, -28, 0, 90), ZIndex = 2 })
				I[46] = new("UIStroke", I[45], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[47] = new("Frame", I[45], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, 2), ZIndex = 2 })
				I[48] = new("TextLabel", I[45], "TextLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(14, 12), Size = UDim2.new(0.46, -14, 0, 34), Text = "Sound effects", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
					I[49] = new("UIStroke", I[48], "UIStroke", { Thickness = 3 })
				I[50] = new("TextLabel", I[45], "Hint", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(14, 52), Size = UDim2.new(0.46, -14, 0, 18), Text = "Volume of the sound effects!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
					I[51] = new("UIStroke", I[50], "UIStroke", { Thickness = 2 })
				I[52] = new("TextLabel", I[45], "Value", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0, 8), Size = UDim2.new(0.5, -18, 0, 22), Text = "100%", TextColor3 = Color3.fromRGB(255, 226, 90), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
					I[53] = new("UIStroke", I[52], "UIStroke", { Thickness = 2.5 })
				I[54] = new("TextButton", I[45], "Bar", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(30, 28, 36), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0, 46), Size = UDim2.new(0.5, -30, 0, 18), Text = "", ZIndex = 3 }, { ["NoFx"] = true })
					I[55] = new("UIStroke", I[54], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[56] = new("Frame", I[54], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, 2), ZIndex = 3 })
					I[57] = new("Frame", I[54], "Fill", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 3 })
						I[58] = new("UIGradient", I[57], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 232, 80)), ColorSequenceKeypoint.new(1, Color3.fromRGB(250, 170, 0)) }), Rotation = 90 })
					I[59] = new("Frame", I[54], "Knob", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromOffset(24, 32), ZIndex = 4 })
						I[60] = new("UIGradient", I[59], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 236, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(250, 176, 10)) }), Rotation = 90 })
						I[61] = new("UIStroke", I[59], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
						I[62] = new("Frame", I[59], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, 3), ZIndex = 4 })
		I[63] = new("TextButton", I[1], "Open", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(1, -14, 0, 66), Size = UDim2.fromOffset(58, 58), Text = "", Visible = false })
			I[64] = new("UIGradient", I[63], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 160, 180)), ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 96, 116)) }), Rotation = 90 })
			I[65] = new("UIStroke", I[63], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
			I[66] = new("ImageLabel", I[63], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://106209837661975"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.86, 0.86), ZIndex = 2 })
			I[67] = new("ImageLabel", I[63], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.7, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(29, 29), Visible = false })
			I[68] = new("UICorner", I[63], "UICorner", { BottomLeftRadius = UDim.new(0, 30), BottomRightRadius = UDim.new(0, 30), TopLeftRadius = UDim.new(0, 30), TopRightRadius = UDim.new(0, 30) })
	return I[1]
end

return build
