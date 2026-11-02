-- Generated from ui/ServerStorage/Gui_Before3Dv2/IndexGui.rbxm by _tools/rbxm2lua.luau
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
				I[4] = new("UIGradient", I[3], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(78, 91, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(44, 52, 65)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
			I[5] = new("TextButton", I[2], "Close", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, 16, 0, -20), Size = UDim2.fromOffset(58, 58), Text = "", ZIndex = 6 }, { ["MontFix"] = true }, { "UIButton" })
				I[6] = new("Frame", I[5], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = 45, Size = UDim2.fromOffset(26, 7), Visible = false, ZIndex = 3 })
					I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 1.5 })
				I[8] = new("Frame", I[5], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Rotation = -45, Size = UDim2.fromOffset(26, 7), Visible = false, ZIndex = 3 })
					I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 1.5 })
				I[10] = new("TextLabel", I[5], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 5 })
					I[11] = new("UIPadding", I[10], "UIPadding", { PaddingBottom = UDim.new(0.12, 0), PaddingLeft = UDim.new(0.12, 0), PaddingRight = UDim.new(0.12, 0), PaddingTop = UDim.new(0.12, 0) })
					I[12] = new("UIStroke", I[10], "UIStroke", { Thickness = 3 })
				I[13] = new("ImageLabel", I[5], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 2 })
					I[14] = new("UIGradient", I[13], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 70, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 0, 26)) }), Rotation = 90 })
				I[15] = new("UIStroke", I[5], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[16] = new("UIGradient", I[5], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(0.4833887, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }), Rotation = 90 })
			I[17] = new("ImageLabel", I[2], "TitleIcon", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://79640278698024"), Position = UDim2.fromOffset(-26, -40), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(84, 84), ZIndex = 6 })
			I[18] = new("TextLabel", I[2], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(62, -34), Size = UDim2.fromOffset(230, 60), Text = "Index", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6 })
				I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 5 })
			I[20] = new("TextLabel", I[2], "Total", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, -250, 0, -16), Size = UDim2.fromOffset(180, 34), Text = "0/21", TextColor3 = Color3.fromRGB(255, 225, 70), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 6 })
				I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 3.5 })
			I[22] = new("Frame", I[2], "Body", { BackgroundTransparency = 1, Position = UDim2.fromOffset(14, 40), Size = UDim2.new(1, -28, 1, -54), ZIndex = 2 })
				I[23] = new("ScrollingFrame", I[22], "List", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 8, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.new(0.7, -8, 1, 0), ZIndex = 2 })
					I[24] = new("UIListLayout", I[23], "UIListLayout", { Padding = UDim.new(0, 14), SortOrder = Enum.SortOrder.LayoutOrder })
					I[25] = new("UIPadding", I[23], "UIPadding", { PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 14), PaddingTop = UDim.new(0, 4) })
				I[26] = new("Frame", I[22], "Side", { BackgroundTransparency = 1, Position = UDim2.new(0.7, 4, 0, 0), Size = UDim2.new(0.3, -4, 1, 0), ZIndex = 2 })
					I[27] = new("Frame", I[26], "Detail", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(2, 4), Size = UDim2.new(1, -4, 0.6, -8), ZIndex = 2 })
						I[28] = new("UIGradient", I[27], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 101, 121)), ColorSequenceKeypoint.new(1, Color3.fromRGB(52, 61, 74)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(214, 214, 220)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 130)) }) })
						I[29] = new("UIStroke", I[27], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
						I[30] = new("ImageLabel", I[27], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 2 })
						I[31] = new("TextLabel", I[27], "FoundIn", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(8, 10), Size = UDim2.new(1, -16, 0, 22), Text = "Found in -", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
							I[32] = new("UIStroke", I[31], "UIStroke", { Thickness = 2.5 })
						I[33] = new("ImageLabel", I[27], "Paw", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxthumb://type=Asset&id=128895446491384&w=150&h=150"), Position = UDim2.fromScale(0.5, 0.46), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.62, 0.5), ZIndex = 3 })
						I[34] = new("ViewportFrame", I[27], "View", { Ambient = Color3.fromRGB(220, 220, 220), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.46), Size = UDim2.fromScale(0.8, 0.56), Visible = false, ZIndex = 3 })
						I[35] = new("TextLabel", I[27], "Selected", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0, 8, 1, -62), Size = UDim2.new(1, -16, 0, 24), Text = "Select an animal", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
							I[36] = new("UIStroke", I[35], "UIStroke", { Thickness = 2.5 })
						I[37] = new("TextLabel", I[27], "Info", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0, 8, 1, -34), Size = UDim2.new(1, -16, 0, 20), Text = "", TextColor3 = Color3.fromRGB(140, 255, 120), TextScaled = true, TextWrapped = true, ZIndex = 3 })
							I[38] = new("UIStroke", I[37], "UIStroke", { Thickness = 2.5 })
					I[39] = new("Frame", I[26], "Rewards", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.new(0, 2, 0.6, 4), Size = UDim2.new(1, -4, 0.4, -8), ZIndex = 2 })
						I[40] = new("UIGradient", I[39], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 150, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 255, 50)) }), Rotation = 90 })
						I[41] = new("UIStroke", I[39], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
						I[42] = new("ImageLabel", I[39], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), ZIndex = 2 })
						I[43] = new("TextLabel", I[39], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(8, 10), Size = UDim2.new(1, -16, 0, 24), Text = "Rewards:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
							I[44] = new("UIStroke", I[43], "UIStroke", { Thickness = 3 })
						I[45] = new("TextLabel", I[39], "Text", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(10, 42), Size = UDim2.new(1, -20, 1, -54), Text = "Discover every animal of a rarity to unlock a bonus.\nComing soon!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 13, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 3 })
							I[46] = new("UIStroke", I[45], "UIStroke", { Thickness = 2 })
							I[47] = new("UITextSizeConstraint", I[45], "UITextSizeConstraint", { MaxTextSize = 14 })
			I[48] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
			I[49] = new("UIGradient", I[2], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(78, 91, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(44, 52, 65)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
	return I[1]
end

return build
