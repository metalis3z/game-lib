-- Generated from ui/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main/PetTemplateContent/Data.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Data", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 25 })
		I[2] = new("Frame", I[1], "BottomLeft", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0249998, 0.8250626), Size = UDim2.fromScale(0.4093621, 0.1241027), ZIndex = 25 })
			I[3] = new("Frame", I[2], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 25 })
				I[4] = new("Frame", I[3], "MoneyPerSecond", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.9100004), Size = UDim2.fromScale(1, 0.45), ZIndex = 25 })
					I[5] = new("TextLabel", I[4], "Label", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 50, RichText = true, Size = UDim2.fromScale(1, 1), Text = "Coins: <font color='#ffe100'>1/s</font>", TextColor3 = Color3.fromRGB(204, 204, 204), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 25 })
						I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 1.7981482 }, { ["oldp_Thickness"] = 2 })
				I[7] = new("Frame", I[3], "MineSpeed", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.45), ZIndex = 25 })
					I[8] = new("TextLabel", I[7], "Label", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 50, RichText = true, Size = UDim2.fromScale(1, 1), Text = "Mines each: <font color='#00ff00'>50s</font>", TextColor3 = Color3.fromRGB(204, 204, 204), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 25 })
						I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 1.7981482 }, { ["oldp_Thickness"] = 2 })
				I[10] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 4.4000001, Transparency = 0.96 })
				I[11] = new("UIPadding", I[3], "UIPadding", { PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6), PaddingTop = UDim.new(0, 2) })
				I[12] = new("UIListLayout", I[3], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[13] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
			I[14] = new("ImageButton", I[2], "Toggle", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://122643571970464"), Position = UDim2.fromScale(0.5, -0.027), PressedImageContent = Content.fromUri("rbxassetid://72851794087068"), Rotation = -90, ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(0.2, 0.4), Visible = false, ZIndex = 28 })
				I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
				I[16] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 3.3, Transparency = 0.95 })
				I[17] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint")
		I[18] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 5), PaddingLeft = UDim.new(0, 5), PaddingRight = UDim.new(0, 5), PaddingTop = UDim.new(0, 5) })
		I[19] = new("Frame", I[1], "ToggleEquip", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.1703384), ZIndex = 25 })
			I[20] = new("ImageButton", I[19], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 21), BackgroundTransparency = 0.6, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(0.95, 0.65), ZIndex = 29 })
				I[21] = new("TextLabel", I[20], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.8), Text = "EQUIP", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 30 })
					I[22] = new("UIStroke", I[21], "UIStroke", { Color = Color3.fromRGB(0, 162, 30), LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
				I[23] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
				I[24] = new("UIStroke", I[20], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(45, 180, 45), Thickness = 2 })
					I[25] = new("UIGradient", I[24], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.75), NumberSequenceKeypoint.new(1, 0) }) })
		I[26] = new("Frame", I[1], "BottomRight", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.9800003, 0.8249999), Size = UDim2.fromScale(0.161335, 0.1241027), ZIndex = 25 })
			I[27] = new("ImageButton", I[26], "Main", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Selectable = false, Size = UDim2.fromScale(1, 1), ZIndex = 25 })
				I[28] = new("UIStroke", I[27], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 4.4000001, Transparency = 0.96 })
				I[29] = new("UICorner", I[27], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
				I[30] = new("ImageLabel", I[27], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81617374664180"), ImageTransparency = 0.31, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.8), ZIndex = 28 })
			I[31] = new("Frame", I[26], "Composition", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, -0.3), Size = UDim2.fromScale(2.717, 2.6210001), Visible = false, ZIndex = 25 })
				I[32] = new("UIStroke", I[31], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 4.4000001, Transparency = 0.82 })
				I[33] = new("UICorner", I[31], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
				I[34] = new("ScrollingFrame", I[31], "List", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.5, 0.5), ScrollBarThickness = 5, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 0.95), ZIndex = 25 })
					I[35] = new("UIPadding", I[34], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 5), PaddingTop = UDim.new(0, 3) })
					I[36] = new("UIGridLayout", I[34], "UIGridLayout", { CellPadding = UDim2.fromScale(0.039, 0.04), CellSize = UDim2.fromScale(0.88, 0.88), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
						I[37] = new("UIAspectRatioConstraint", I[36], "UIAspectRatioConstraint")
					I[38] = new("ImageLabel", I[34], "Template", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(66, 66, 66), ImageContent = Content.fromUri("rbxassetid://110332752204831"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.8), SizeConstraint = Enum.SizeConstraint.RelativeXX, Visible = false, ZIndex = 29 })
						I[39] = new("ImageLabel", I[38], "Image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://110332752204831"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 29 })
							I[40] = new("UIGradient", I[39], "UIGradient", { Offset = Vector2.new(0.5, 0), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.490025, 0), NumberSequenceKeypoint.new(0.5012469, 1), NumberSequenceKeypoint.new(1, 1) }) })
						I[41] = new("TextLabel", I[38], "Percent", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 1), Text = "50%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 31 })
							I[42] = new("UIStroke", I[41], "UIStroke", { Thickness = 1.6 })
	return I[1]
end

return build
