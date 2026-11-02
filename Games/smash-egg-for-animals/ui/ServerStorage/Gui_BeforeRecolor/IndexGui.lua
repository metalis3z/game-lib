-- Generated from ui/ServerStorage/Gui_BeforeRecolor/IndexGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "IndexGui", { DisplayOrder = 5, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromOffset(780, 580), Visible = false }, nil, { "AutoScale" })
			I[3] = new("ImageLabel", I[2], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
				I[4] = new("UIGradient", I[3], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 44, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 24, 58)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
				I[5] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[6] = new("TextButton", I[2], "Close", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, 16, 0, -20), Size = UDim2.fromOffset(58, 58), Text = "", ZIndex = 6 }, { ["MontFix"] = true }, { "UIButton" })
				I[7] = new("Frame", I[6], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = 45, Size = UDim2.fromOffset(26, 7), Visible = false, ZIndex = 3 })
					I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[9] = new("UIStroke", I[7], "UIStroke", { Thickness = 1.5 })
				I[10] = new("Frame", I[6], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = -45, Size = UDim2.fromOffset(26, 7), Visible = false, ZIndex = 3 })
					I[11] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[12] = new("UIStroke", I[10], "UIStroke", { Thickness = 1.5 })
				I[13] = new("TextLabel", I[6], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 5 })
					I[14] = new("UIPadding", I[13], "UIPadding", { PaddingBottom = UDim.new(0.12, 0), PaddingLeft = UDim.new(0.12, 0), PaddingRight = UDim.new(0.12, 0), PaddingTop = UDim.new(0.12, 0) })
					I[15] = new("UIStroke", I[13], "UIStroke", { Thickness = 3 })
				I[16] = new("ImageLabel", I[6], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 2 })
					I[17] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[18] = new("UIGradient", I[16], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 70, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 0, 26)) }), Rotation = 90 })
				I[19] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[20] = new("UIStroke", I[6], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[21] = new("UIGradient", I[6], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 70, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 0, 26)) }), Rotation = 90 })
			I[22] = new("ImageLabel", I[2], "TitleIcon", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://79640278698024"), Position = UDim2.fromOffset(-26, -40), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(84, 84), ZIndex = 6 })
			I[23] = new("TextLabel", I[2], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(62, -34), Size = UDim2.fromOffset(230, 60), Text = "Index", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6 })
				I[24] = new("UIStroke", I[23], "UIStroke", { Thickness = 5 })
			I[25] = new("TextLabel", I[2], "Total", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, -250, 0, -16), Size = UDim2.fromOffset(180, 34), Text = "0/21", TextColor3 = Color3.fromRGB(255, 225, 70), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 6 })
				I[26] = new("UIStroke", I[25], "UIStroke", { Thickness = 3.5 })
			I[27] = new("Frame", I[2], "Body", { BackgroundTransparency = 1, Position = UDim2.fromOffset(14, 40), Size = UDim2.new(1, -28, 1, -54), ZIndex = 2 })
				I[28] = new("ScrollingFrame", I[27], "List", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 8, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.new(0.7, -8, 1, 0), ZIndex = 2 })
					I[29] = new("UIListLayout", I[28], "UIListLayout", { Padding = UDim.new(0, 14), SortOrder = Enum.SortOrder.LayoutOrder })
					I[30] = new("UIPadding", I[28], "UIPadding", { PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 14), PaddingTop = UDim.new(0, 4) })
				I[31] = new("Frame", I[27], "Side", { BackgroundTransparency = 1, Position = UDim2.new(0.7, 4, 0, 0), Size = UDim2.new(0.3, -4, 1, 0), ZIndex = 2 })
					I[32] = new("Frame", I[31], "Detail", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(2, 4), Size = UDim2.new(1, -4, 0.6, -8), ZIndex = 2 })
						I[33] = new("UIGradient", I[32], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 54, 108)), ColorSequenceKeypoint.new(1, Color3.fromRGB(46, 30, 66)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(214, 214, 220)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 130)) }) })
						I[34] = new("UIStroke", I[32], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
						I[35] = new("ImageLabel", I[32], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 2 })
						I[36] = new("TextLabel", I[32], "FoundIn", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(8, 10), Size = UDim2.new(1, -16, 0, 22), Text = "Found in -", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
							I[37] = new("UIStroke", I[36], "UIStroke", { Thickness = 2.5 })
						I[38] = new("ImageLabel", I[32], "Paw", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxthumb://type=Asset&id=128895446491384&w=150&h=150"), Position = UDim2.fromScale(0.5, 0.46), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.62, 0.5), ZIndex = 3 })
						I[39] = new("ViewportFrame", I[32], "View", { Ambient = Color3.fromRGB(220, 220, 220), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.46), Size = UDim2.fromScale(0.8, 0.56), Visible = false, ZIndex = 3 })
						I[40] = new("TextLabel", I[32], "Selected", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0, 8, 1, -62), Size = UDim2.new(1, -16, 0, 24), Text = "Select an animal", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
							I[41] = new("UIStroke", I[40], "UIStroke", { Thickness = 2.5 })
						I[42] = new("TextLabel", I[32], "Info", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0, 8, 1, -34), Size = UDim2.new(1, -16, 0, 20), Text = "", TextColor3 = Color3.fromRGB(140, 255, 120), TextScaled = true, TextWrapped = true, ZIndex = 3 })
							I[43] = new("UIStroke", I[42], "UIStroke", { Thickness = 2.5 })
					I[44] = new("Frame", I[31], "Rewards", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.new(0, 2, 0.6, 4), Size = UDim2.new(1, -4, 0.4, -8), ZIndex = 2 })
						I[45] = new("UIGradient", I[44], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 150, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 255, 50)) }), Rotation = 90 })
						I[46] = new("UIStroke", I[44], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
						I[47] = new("ImageLabel", I[44], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 2 })
						I[48] = new("TextLabel", I[44], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(8, 10), Size = UDim2.new(1, -16, 0, 24), Text = "Rewards:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
							I[49] = new("UIStroke", I[48], "UIStroke", { Thickness = 3 })
						I[50] = new("TextLabel", I[44], "Text", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(10, 42), Size = UDim2.new(1, -20, 1, -54), Text = "Discover every animal of a rarity to unlock a bonus.\nComing soon!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 13, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 3 })
							I[51] = new("UIStroke", I[50], "UIStroke", { Thickness = 2 })
							I[52] = new("UITextSizeConstraint", I[50], "UITextSizeConstraint", { MaxTextSize = 14 })
			I[53] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[54] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
			I[55] = new("UIGradient", I[2], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 44, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 24, 58)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
	return I[1]
end

return build
