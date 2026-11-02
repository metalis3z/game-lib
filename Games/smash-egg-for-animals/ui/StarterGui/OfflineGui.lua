-- Generated from ui/StarterGui/OfflineGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "OfflineGui", { DisplayOrder = 30, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Dim", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.45, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false })
			I[3] = new("Frame", I[2], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(40, 46, 34), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(540, 380), ZIndex = 2 })
				I[4] = new("UIScale", I[3], "Fit")
				I[5] = new("UIStroke", I[3], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[6] = new("Frame", I[3], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, 3), ZIndex = 2 })
				I[7] = new("ImageLabel", I[3], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.93, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(40, 40), Visible = false })
				I[8] = new("Frame", I[3], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 66), ZIndex = 2 })
					I[9] = new("UIGradient", I[8], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(190, 255, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 214, 50)) }), Rotation = 90 })
					I[10] = new("UIStroke", I[8], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[11] = new("Frame", I[8], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, 3), ZIndex = 2 })
					I[12] = new("Frame", I[8], "Gloss", { BackgroundTransparency = 1, ClipsDescendants = true, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[13] = new("ImageLabel", I[12], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.86, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(36, 36), Visible = false, ZIndex = 2 })
						I[14] = new("Frame", I[12], "Shine", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.78, BorderSizePixel = 0, Position = UDim2.fromScale(0.6, 0.5), Rotation = 24, Size = UDim2.fromScale(0.07, 3), ZIndex = 2 })
						I[15] = new("Frame", I[12], "Shine", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.78, BorderSizePixel = 0, Position = UDim2.fromScale(0.72, 0.5), Rotation = 24, Size = UDim2.fromScale(0.035, 3), ZIndex = 2 })
					I[16] = new("TextLabel", I[8], "Welcome", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(18, 11), Size = UDim2.new(0.8, 0, 0, 42), Text = "Offline Money", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
						I[17] = new("UIStroke", I[16], "UIStroke", { Thickness = 3 })
				I[18] = new("TextLabel", I[3], "Earned", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Italic), Position = UDim2.fromOffset(20, 82), Size = UDim2.new(1, -40, 0, 40), Text = "You earned:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
					I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 3 })
				I[20] = new("TextLabel", I[3], "Away", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, 124), Size = UDim2.new(1, -40, 0, 18), Text = "You were offline for 0s.", TextColor3 = Color3.fromRGB(214, 230, 200), TextScaled = true, TextWrapped = true, ZIndex = 3 })
					I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 2 })
				I[22] = new("ImageLabel", I[3], "Icon", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://70666404213952"), Position = UDim2.new(0.5, 0, 0, 138), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(170, 150) })
				I[23] = new("TextLabel", I[3], "Amount", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, 178), Size = UDim2.new(1, -40, 0, 70), Text = "$0", TextColor3 = Color3.fromRGB(120, 255, 70), TextScaled = true, TextWrapped = true, ZIndex = 3 })
					I[24] = new("UIStroke", I[23], "UIStroke", { Thickness = 5 })
				I[25] = new("TextButton", I[3], "Ok", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.new(0, 18, 1, -84), Size = UDim2.new(0.56, -27, 0, 64), Text = "", ZIndex = 3 })
					I[26] = new("UIGradient", I[25], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 255, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 200, 40)) }), Rotation = 90 })
					I[27] = new("UIStroke", I[25], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[28] = new("Frame", I[25], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, 3), ZIndex = 3 })
					I[29] = new("Frame", I[25], "Gloss", { BackgroundTransparency = 1, ClipsDescendants = true, Size = UDim2.fromScale(1, 1), ZIndex = 3 })
						I[30] = new("ImageLabel", I[29], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.86, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(36, 36), Visible = false, ZIndex = 3 })
						I[31] = new("Frame", I[29], "Shine", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.78, BorderSizePixel = 0, Position = UDim2.fromScale(0.6, 0.5), Rotation = 24, Size = UDim2.fromScale(0.07, 3), ZIndex = 3 })
						I[32] = new("Frame", I[29], "Shine", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.78, BorderSizePixel = 0, Position = UDim2.fromScale(0.72, 0.5), Rotation = 24, Size = UDim2.fromScale(0.035, 3), ZIndex = 3 })
					I[33] = new("TextLabel", I[25], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.06, 0.14), Size = UDim2.fromScale(0.88, 0.68), Text = "Claim", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 4 })
						I[34] = new("UIStroke", I[33], "UIStroke", { Thickness = 3 })
				I[35] = new("TextButton", I[3], "Double", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.new(0.56, 9, 1, -84), Size = UDim2.new(0.44, -27, 0, 64), Text = "", ZIndex = 3 })
					I[36] = new("UIGradient", I[35], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 110, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 40, 220)) }), Rotation = 90 })
					I[37] = new("UIStroke", I[35], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[38] = new("Frame", I[35], "Lip", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 6, 0, 3), ZIndex = 3 })
					I[39] = new("Frame", I[35], "Gloss", { BackgroundTransparency = 1, ClipsDescendants = true, Size = UDim2.fromScale(1, 1), ZIndex = 3 })
						I[40] = new("ImageLabel", I[39], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.86, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(36, 36), Visible = false, ZIndex = 3 })
						I[41] = new("Frame", I[39], "Shine", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.78, BorderSizePixel = 0, Position = UDim2.fromScale(0.6, 0.5), Rotation = 24, Size = UDim2.fromScale(0.07, 3), ZIndex = 3 })
						I[42] = new("Frame", I[39], "Shine", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.78, BorderSizePixel = 0, Position = UDim2.fromScale(0.72, 0.5), Rotation = 24, Size = UDim2.fromScale(0.035, 3), ZIndex = 3 })
					I[43] = new("TextLabel", I[35], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.06, 0.14), Size = UDim2.fromScale(0.88, 0.68), Text = "Double it!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 4 })
						I[44] = new("UIStroke", I[43], "UIStroke", { Thickness = 3 })
					I[45] = new("TextLabel", I[35], "Tag", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Italic), Position = UDim2.new(1, -44, 0, -24), Rotation = 14, Size = UDim2.fromOffset(62, 40), Text = "2x", TextColor3 = Color3.fromRGB(244, 130, 255), TextScaled = true, TextWrapped = true, ZIndex = 4 })
						I[46] = new("UIStroke", I[45], "UIStroke", { Thickness = 3 })
	return I[1]
end

return build
