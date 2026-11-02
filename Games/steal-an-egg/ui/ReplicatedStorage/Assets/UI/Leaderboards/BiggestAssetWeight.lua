-- Generated from ui/ReplicatedStorage/Assets/UI/Leaderboards/BiggestAssetWeight.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "BiggestAssetWeight", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(0.995, 0, 0, 100) })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 25), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[3] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 18), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 8) })
		I[4] = new("Frame", I[1], "Holder_PlayerName", { BackgroundColor3 = Color3.fromRGB(0, 15, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromOffset(195, 100) })
			I[5] = new("ScrollingFrame", I[4], "Display", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(2, 0), Position = UDim2.fromScale(0.5, 0.5), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 6, Size = UDim2.fromScale(1, 1) })
				I[6] = new("TextLabel", I[5], "TextLabel_PlayerName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.6), TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[7] = new("Frame", I[1], "Holder_Thumbnail", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(0.16, 0.75) })
			I[8] = new("ImageLabel", I[7], "ImageLabel_PlayerThumb", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Size = UDim2.fromScale(1, 1) })
				I[9] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
			I[10] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint")
			I[11] = new("UIStroke", I[7], "UIStroke", { Thickness = 3 }, { ["ThicknessUDim"] = UDim.new(0, 3) })
			I[12] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
			I[13] = new("UIGradient", I[7], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(226, 130, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 241, 0)) }), Rotation = -90 })
		I[14] = new("Frame", I[1], "Holder_Value", { BackgroundColor3 = Color3.fromRGB(0, 15, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 4, Size = UDim2.fromOffset(140, 80) })
			I[15] = new("Frame", I[14], "Object", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.48) }, { ["Stroke"] = true, ["Text"] = "", ["TextCentered"] = true, ["TextSize"] = 10 })
				I[16] = new("TextLabel", I[15], "TextLabel_ObjectName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "PoopWeight:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true })
				I[17] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
				I[18] = new("UIGradient", I[15], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(226, 130, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 241, 0)) }), Rotation = -90 })
			I[19] = new("CanvasGroup", I[14], "Holder", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 47, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(2, 0.48) })
				I[20] = new("TextLabel", I[19], "TextLabel_Value", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 1.2), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextWrapped = true })
		I[21] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
	return I[1]
end

return build
