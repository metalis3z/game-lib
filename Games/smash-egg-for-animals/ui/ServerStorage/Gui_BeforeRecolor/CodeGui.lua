-- Generated from ui/ServerStorage/Gui_BeforeRecolor/CodeGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CodeGui", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromOffset(500, 340), Visible = false })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[4] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
			I[5] = new("UIGradient", I[2], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 44, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 24, 58)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
			I[6] = new("ImageLabel", I[2], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
				I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[8] = new("UIGradient", I[6], "Tint", { Rotation = 90 })
			I[9] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(10, 10), Size = UDim2.new(1, -20, 0, 58) })
				I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[11] = new("UIStroke", I[9], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[12] = new("UIGradient", I[9], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 136, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(222, 88, 12)) }) }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 235, 20)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(215, 250, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 235, 20)) }) })
				I[13] = new("ImageLabel", I[9], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
					I[14] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[15] = new("UIGradient", I[13], "Tint", { Rotation = 90 })
				I[16] = new("TextLabel", I[9], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(68, 9), Size = UDim2.new(0, 300, 1, -18), Text = "Redeem Code", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[17] = new("UIStroke", I[16], "TextStroke", { Thickness = 4.5 })
				I[18] = new("TextButton", I[9], "Close", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(1, -9, 0.5, 0), Size = UDim2.fromOffset(44, 44), Text = "", ZIndex = 2 }, { ["MontFix"] = true })
					I[19] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[20] = new("UIStroke", I[18], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[21] = new("UIGradient", I[18], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 70, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 0, 26)) }), Rotation = 90 })
					I[22] = new("ImageLabel", I[18], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 0 })
						I[23] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
						I[24] = new("UIGradient", I[22], "Tint", { Rotation = 90 })
					I[25] = new("Frame", I[18], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Rotation = 45, Size = UDim2.fromOffset(26, 7), ZIndex = 3 })
						I[26] = new("UICorner", I[25], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
						I[27] = new("UIStroke", I[25], "UIStroke", { Thickness = 2 })
					I[28] = new("Frame", I[18], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Rotation = -45, Size = UDim2.fromOffset(26, 7), ZIndex = 3 })
						I[29] = new("UICorner", I[28], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
						I[30] = new("UIStroke", I[28], "UIStroke", { Thickness = 2 })
			I[31] = new("TextLabel", I[2], "Subtitle", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, 76), Size = UDim2.new(1, -40, 0, 30), Text = "~ Enter a code below ~", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
				I[32] = new("UIGradient", I[31], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(236, 60, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 160, 0)) }), Rotation = 90 })
				I[33] = new("UIStroke", I[31], "TextStroke", { Thickness = 3.5 })
			I[34] = new("TextBox", I[2], "CodeInput", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(153, 153, 166), PlaceholderText = "Enter code here...", Position = UDim2.fromOffset(20, 120), Size = UDim2.new(1, -40, 0, 56), Text = "", TextScaled = true, TextWrapped = true, ZIndex = 2 })
				I[35] = new("UICorner", I[34], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[36] = new("UIStroke", I[34], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[37] = new("ImageLabel", I[34], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 0 })
					I[38] = new("UICorner", I[37], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[39] = new("UIGradient", I[37], "Tint", { Rotation = 90 })
				I[40] = new("UIPadding", I[34], "UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) })
			I[41] = new("TextButton", I[2], "Redeem", { AnchorPoint = Vector2.new(0.5, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0, 196), Size = UDim2.fromOffset(200, 56), Text = "Redeem", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 })
				I[42] = new("UICorner", I[41], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[43] = new("UIStroke", I[41], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[44] = new("UIGradient", I[41], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 214, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(245, 150, 50)) }), Rotation = 90 })
				I[45] = new("ImageLabel", I[41], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 0 })
					I[46] = new("UICorner", I[45], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[47] = new("UIGradient", I[45], "Tint", { Rotation = 90 })
				I[48] = new("UIStroke", I[41], "TextStroke", { Thickness = 4 })
				I[49] = new("UIPadding", I[41], "UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) })
			I[50] = new("TextLabel", I[2], "Result", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, 270), Size = UDim2.new(1, -40, 0, 40), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 })
				I[51] = new("UIStroke", I[50], "TextStroke", { Thickness = 3.5 })
	return I[1]
end

return build
