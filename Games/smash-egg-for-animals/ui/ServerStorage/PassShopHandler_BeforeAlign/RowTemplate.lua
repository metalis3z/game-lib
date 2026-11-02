-- Generated from ui/ServerStorage/PassShopHandler_BeforeAlign/RowTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "RowTemplate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 0, 92) })
		I[2] = new("ImageLabel", I[1], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), Visible = false, ZIndex = 0 })
			I[3] = new("UIGradient", I[2], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(81, 185, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(43, 154, 210)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 232, 150)), ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 170, 80)) }) })
		I[4] = new("Frame", I[1], "Badge", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(12, 12), Size = UDim2.fromOffset(68, 68) })
			I[5] = new("TextLabel", I[4], "Text", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "VIP", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 23 }, { ["MontFix"] = true })
				I[6] = new("UIStroke", I[5], "TextStroke", { Thickness = 2.5 })
				I[7] = new("UIGradient", I[5], "TextGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 240, 150)), ColorSequenceKeypoint.new(1, Color3.fromRGB(72, 169, 255)) }), Rotation = 90 })
			I[8] = new("UIStroke", I[4], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
			I[9] = new("UIGradient", I[4], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(69, 80, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 46, 56)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 250, 235)), ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 222, 190)) }) })
		I[10] = new("TextLabel", I[1], "PassName", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(94, 10), Size = UDim2.new(1, -270, 0, 30), Text = "VIP", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 23, TextXAlignment = Enum.TextXAlignment.Left }, { ["MontFix"] = true })
			I[11] = new("UIStroke", I[10], "TextStroke", { Thickness = 2.5 })
		I[12] = new("TextLabel", I[1], "Description", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(94, 42), Size = UDim2.new(1, -270, 0, 40), Text = "", TextColor3 = Color3.fromRGB(255, 248, 225), TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top }, { ["MontFix"] = true })
			I[13] = new("UIStroke", I[12], "TextStroke", { Thickness = 1.8 })
		I[14] = new("TextButton", I[1], "Buy", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(150, 60), Text = "R$ 300", TextTransparency = 1 }, { ["MontFix"] = true }, { "UIButton" })
			I[15] = new("TextLabel", I[14], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "R$ 300", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
				I[16] = new("UIStroke", I[15], "TextStroke", { Thickness = 2.5 })
				I[17] = new("UIPadding", I[15], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 7) })
			I[18] = new("ImageLabel", I[14], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), Visible = false })
				I[19] = new("UIGradient", I[18], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 226, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 170, 70)) }), Rotation = 90 })
			I[20] = new("UIStroke", I[14], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3.5 })
			I[21] = new("UIGradient", I[14], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 226, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 170, 70)) }), Rotation = 90 })
		I[22] = new("UIStroke", I[1], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
		I[23] = new("UIGradient", I[1], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(81, 185, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(43, 154, 210)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 232, 150)), ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 170, 80)) }) })
	return I[1]
end

return build
