-- Generated from ui/ReplicatedStorage/Assets/BillboardUIs/CosmeticControl.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "CosmeticControl", { Active = true, AlwaysOnTop = true, MaxDistance = math.huge, ResetOnSpawn = false, Size = UDim2.new(100, 0, 0, 200), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "HouseNotificationUI" })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(0, 200, 1, 0) })
			I[3] = new("Frame", I[2], "Buttons", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.375) })
				I[4] = new("Frame", I[3], "Delete", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.new(0, 60, 1, 0) }, nil, { "HousingDeleteButton" })
					I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint")
					I[6] = new("TextButton", I[4], "Hover", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 3 })
					I[7] = new("ImageLabel", I[4], "InletTexture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://118449132151095"), ImageTransparency = 0.37, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.4, 0.4), ZIndex = 0 })
						I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[9] = new("ImageLabel", I[4], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://10949133634"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.75) })
					I[10] = new("ImageLabel", I[4], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112331341441215"), ImageTransparency = 0.06, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.2, ZIndex = 0 })
					I[11] = new("UIStroke", I[4], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(63, 0, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
					I[12] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(199, 0, 0)), ColorSequenceKeypoint.new(0.1468048, Color3.fromRGB(255, 14, 14)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 89, 89)) }), Rotation = -90 })
					I[13] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[14] = new("Frame", I[4], "Shade", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
						I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[16] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[17] = new("Frame", I[3], "Move", { BackgroundColor3 = Color3.fromRGB(0, 170, 255), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.new(0, 60, 1, 0) }, nil, { "HousingMoveButton" })
					I[18] = new("Frame", I[17], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(29, 29, 29), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
						I[19] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[20] = new("Frame", I[18], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(53, 168, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -6, 1, -6), ZIndex = 2 })
							I[21] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
							I[22] = new("CanvasGroup", I[20], "CanvasGroup", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
								I[23] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
							I[24] = new("ImageLabel", I[20], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://10949252305"), Position = UDim2.fromScale(0.5, 0.5), Rotation = 45, Size = UDim2.fromScale(0.8, 0.8) })
					I[25] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint")
					I[26] = new("TextButton", I[17], "Hover", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Modal = true, Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 3 })
					I[27] = new("Frame", I[17], "Shade", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
						I[28] = new("UICorner", I[27], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[29] = new("ImageLabel", I[17], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112331341441215"), ImageTransparency = 0.06, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.2, ZIndex = 0 })
					I[30] = new("ImageLabel", I[17], "InletTexture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://118449132151095"), ImageTransparency = 0.37, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.4, 0.4), ZIndex = 0 })
						I[31] = new("UICorner", I[30], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[32] = new("UIStroke", I[17], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(35, 35, 35), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
					I[33] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[34] = new("Frame", I[2], "RotateBar", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.new(0.5, 0, 0, 140), Size = UDim2.fromOffset(60, 60) })
				I[35] = new("Frame", I[34], "Rotate", { BackgroundColor3 = Color3.fromRGB(0, 170, 0), BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromOffset(60, 60), ZIndex = 2 }, nil, { "HousingRotateButton" })
					I[36] = new("Frame", I[35], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(29, 29, 29), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
						I[37] = new("UICorner", I[36], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[38] = new("Frame", I[36], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(203, 255, 34), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -6, 1, -6), ZIndex = 2 })
							I[39] = new("UICorner", I[38], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
							I[40] = new("ImageLabel", I[38], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://10949238827"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7, 0.7) })
					I[41] = new("TextButton", I[35], "Hover", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 5 })
					I[42] = new("Frame", I[35], "Shade", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
						I[43] = new("UICorner", I[42], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[44] = new("UIAspectRatioConstraint", I[35], "UIAspectRatioConstraint")
					I[45] = new("UICorner", I[35], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[46] = new("UIStroke", I[35], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(35, 35, 35), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
					I[47] = new("ImageLabel", I[35], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112331341441215"), ImageTransparency = 0.06, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.2, ZIndex = 0 })
					I[48] = new("ImageLabel", I[35], "InletTexture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://118449132151095"), ImageTransparency = 0.37, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.4, 0.4), ZIndex = 0 })
						I[49] = new("UICorner", I[48], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[50] = new("ImageLabel", I[34], "ArrowSlider", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://121760321277714"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(5, 1), Visible = false })
			I[51] = new("TextLabel", I[2], "Tip", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, 34), Size = UDim2.new(1, 0, 0, 30), Text = "Hold + Drag to move", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
				I[52] = new("UIStroke", I[51], "UIStroke", { Thickness = 2.3 })
	return I[1]
end

return build
