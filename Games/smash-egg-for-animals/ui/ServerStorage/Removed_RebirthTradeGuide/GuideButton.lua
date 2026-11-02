-- Generated from ui/ServerStorage/Removed_RebirthTradeGuide/GuideButton.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "GuideButton", { AutoButtonColor = false, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 5, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(86, 98), Text = "" }, { ["MontFix"] = true })
		I[2] = new("Frame", I[1], "Lip", { BackgroundColor3 = Color3.fromRGB(25, 75, 150), BorderSizePixel = 0, Size = UDim2.new(1, 0, 1.03, -7) })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[4] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
		I[5] = new("Frame", I[1], "Face", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 1, -7), ZIndex = 2 })
			I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[7] = new("UIStroke", I[5], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
			I[8] = new("UIGradient", I[5], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(110, 205, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 130, 230)) }), Rotation = 90 })
			I[9] = new("ImageLabel", I[5], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
				I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[11] = new("UIGradient", I[9], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(110, 205, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 130, 230)) }), Rotation = 90 })
			I[12] = new("ImageLabel", I[5], "Icon", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://128930198031680"), Position = UDim2.new(0.5, 0, 0, 6), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(76, 64), Visible = false, ZIndex = 3 })
			I[13] = new("TextLabel", I[5], "Label", { AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.945, -5), Size = UDim2.new(1, -8, 0, 26), Text = "Guide", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 19, ZIndex = 4 }, { ["MontFix"] = true })
				I[14] = new("UIStroke", I[13], "TextStroke", { Color = Color3.fromRGB(25, 75, 150), Thickness = 2.5 })
			I[15] = new("TextLabel", I[5], "QuestionMark", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0, 4), Size = UDim2.fromOffset(70, 62), Text = "?", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
				I[16] = new("UIStroke", I[15], "UIStroke", { Color = Color3.fromRGB(20, 60, 110), Thickness = 4 })
	return I[1]
end

return build
