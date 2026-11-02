-- Generated from ui/StarterGui/Trade.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Trade", { DisplayOrder = 1, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(177, 243, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.6), Visible = false, ZIndex = 8 })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.55 })
			I[4] = new("Frame", I[2], "You", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.0993789), Size = UDim2.fromScale(1, 1) })
				I[5] = new("Frame", I[4], "ListBG", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 39, 82), Position = UDim2.fromScale(0.2192917, 0.0171045), Size = UDim2.fromScale(0.4125713, 0.7056033), ZIndex = 0 })
					I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
				I[7] = new("ScrollingFrame", I[4], "MainList", { AnchorPoint = Vector2.new(0.5, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(75, 0, 160), BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.2201158, 0.0284217), ScrollBarThickness = 4, Selectable = false, Size = UDim2.fromScale(0.399944, 0.6827991), VerticalScrollBarInset = Enum.ScrollBarInset.Always, ZIndex = 2 })
					I[8] = new("UIGridLayout", I[7], "UIGridLayout", { CellPadding = UDim2.fromScale(0.02, 0.02), CellSize = UDim2.fromScale(0.32, 0.32), FillDirectionMaxCells = 4, SortOrder = Enum.SortOrder.LayoutOrder })
						I[9] = new("UIAspectRatioConstraint", I[8], "UIAspectRatioConstraint")
				I[10] = new("TextLabel", I[4], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2196424, -0.0390269), Size = UDim2.fromScale(0.35, 0.0801271), Text = "You", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.6, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 15 })
					I[11] = new("UIStroke", I[10], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3.5 })
				I[12] = new("Frame", I[4], "Actions", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 39, 82), Position = UDim2.fromScale(0.2191769, 0.7458693), Size = UDim2.fromScale(0.4120928, 0.1242831), ZIndex = 9 })
					I[13] = new("UIListLayout", I[12], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
					I[14] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[15] = new("ImageButton", I[12], "ReadyBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 239, 28), LayoutOrder = 2, Position = UDim2.fromScale(0.2473758, 0.4911173), Selectable = false, Size = UDim2.fromScale(0.453621, 0.7452348), ZIndex = 15 }, nil, { "PopButton" })
						I[16] = new("TextLabel", I[15], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.51), Size = UDim2.fromScale(0.926, 0.7), Text = "Ready", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, ZIndex = 16 })
							I[17] = new("UIStroke", I[16], "UIStroke", { Thickness = 2 })
						I[18] = new("UIStroke", I[15], "UIStroke", { Thickness = 3 })
						I[19] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[20] = new("ImageButton", I[12], "CancelBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 54, 47), LayoutOrder = 3, Position = UDim2.fromScale(0.7302986, 0.4911173), Selectable = false, Size = UDim2.fromScale(0.453621, 0.7452348), ZIndex = 15 }, nil, { "PopButton" })
						I[21] = new("TextLabel", I[20], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.51), Size = UDim2.fromScale(0.926, 0.7), Text = "Cancel", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, ZIndex = 16 })
							I[22] = new("UIStroke", I[21], "UIStroke", { Thickness = 2 })
						I[23] = new("UIStroke", I[20], "UIStroke", { Thickness = 3 })
						I[24] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[25] = new("Frame", I[4], "Ready", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(74, 74, 74), BackgroundTransparency = 0.5, Position = UDim2.fromScale(0.2190699, 0.0171045), Size = UDim2.fromScale(0.4130149, 0.7056034), Visible = false, ZIndex = 49 })
					I[26] = new("UICorner", I[25], "UICorner", { BottomLeftRadius = UDim.new(0.0285, 0), BottomRightRadius = UDim.new(0.0285, 0), TopLeftRadius = UDim.new(0.0285, 0), TopRightRadius = UDim.new(0.0285, 0) })
					I[27] = new("TextLabel", I[25], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.4982003), Size = UDim2.fromScale(0.5733748, 0.154916), Text = "READY", TextColor3 = Color3.fromRGB(59, 255, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.6, TextWrapped = true, ZIndex = 50 })
						I[28] = new("UIStroke", I[27], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 4 })
			I[29] = new("Frame", I[2], "Top", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 47, 182), Position = UDim2.fromScale(0.5, 0.49), Size = UDim2.fromScale(1, 1), ZIndex = -1 })
				I[30] = new("UIStroke", I[29], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
				I[31] = new("Frame", I[29], "Processing", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 99 })
					I[32] = new("TextLabel", I[31], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4, 0.125), Text = "Processing...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 1231231231 })
						I[33] = new("UIStroke", I[32], "UIStroke", { Thickness = 5 })
					I[34] = new("Frame", I[31], "ListBG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(20, 20, 20), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 0.2), ZIndex = 2000 })
						I[35] = new("UICorner", I[34], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[36] = new("UIStroke", I[34], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 70, 70), Thickness = 4 })
					I[37] = new("UICorner", I[31], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
			I[38] = new("Frame", I[2], "Other", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.0993789), Size = UDim2.fromScale(1, 1) })
				I[39] = new("Frame", I[38], "Ready", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(74, 74, 74), BackgroundTransparency = 0.5, Position = UDim2.fromScale(0.7735207, 0.0171046), Size = UDim2.fromScale(0.4119586, 0.7011846), Visible = false, ZIndex = 49 })
					I[40] = new("UICorner", I[39], "UICorner", { BottomLeftRadius = UDim.new(0.0285, 0), BottomRightRadius = UDim.new(0.0285, 0), TopLeftRadius = UDim.new(0.0285, 0), TopRightRadius = UDim.new(0.0285, 0) })
					I[41] = new("TextLabel", I[39], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.4982003), Size = UDim2.fromScale(0.5733748, 0.154916), Text = "READY", TextColor3 = Color3.fromRGB(59, 255, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.6, TextWrapped = true, ZIndex = 50 })
						I[42] = new("UIStroke", I[41], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 4 })
				I[43] = new("TextLabel", I[38], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7750914, -0.0372957), Size = UDim2.fromScale(0.35, 0.0801271), Text = "@Hashbloxian", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.6, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 15 })
					I[44] = new("UIStroke", I[43], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3.5 })
				I[45] = new("ScrollingFrame", I[38], "MainList", { AnchorPoint = Vector2.new(0.5, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(75, 0, 160), BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.7743436, 0.0283508), ScrollBarThickness = 4, Selectable = false, Size = UDim2.fromScale(0.39935, 0.6785231), VerticalScrollBarInset = Enum.ScrollBarInset.Always, ZIndex = 2 })
					I[46] = new("UIGridLayout", I[45], "UIGridLayout", { CellPadding = UDim2.fromScale(0.02, 0.02), CellSize = UDim2.fromScale(0.32, 0.32), FillDirectionMaxCells = 4, SortOrder = Enum.SortOrder.LayoutOrder })
						I[47] = new("UIAspectRatioConstraint", I[46], "UIAspectRatioConstraint")
				I[48] = new("Frame", I[38], "ListBG", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 39, 82), Position = UDim2.fromScale(0.7735207, 0.0171046), Size = UDim2.fromScale(0.4119586, 0.7011845), ZIndex = 0 })
					I[49] = new("UICorner", I[48], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
			I[50] = new("ImageLabel", I[2], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14195026855"), Position = UDim2.fromScale(0.4975001, 0.4993519), Rotation = 180, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.12, 0.3) })
	return I[1]
end

return build
