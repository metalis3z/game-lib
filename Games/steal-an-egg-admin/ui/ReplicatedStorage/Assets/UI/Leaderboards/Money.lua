-- Generated from ui/ReplicatedStorage/Assets/UI/Leaderboards/Money.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Money", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(0.995, 0, 0, 100) }, { ["_lemonadeUniqueId"] = "ce3aOqB3ce3a" })
		I[2] = new("Frame", I[1], "Holder_Thumbnail", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(0.16, 0.75) }, { ["_lemonadeUniqueId"] = "kGrJanVLkGrJ" })
			I[3] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 226, 226)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 153, 255)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "X88XqcEOX88X" })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) }, { ["_lemonadeUniqueId"] = "XJlXSwbzXJlX" })
			I[5] = new("UIStroke", I[2], "UIStroke", { Thickness = 3 }, { ["ThicknessUDim"] = UDim.new(0, 3), ["_lemonadeUniqueId"] = "TWX7vaxZTWX7" })
			I[6] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "2i08DtpV2i08" })
			I[7] = new("ImageLabel", I[2], "ImageLabel_PlayerThumb", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "kvpoXyttkvpo" })
				I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) }, { ["_lemonadeUniqueId"] = "60AzZy2M60Az" })
		I[9] = new("Frame", I[1], "Holder_PlayerName", { BackgroundColor3 = Color3.fromRGB(0, 15, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromOffset(195, 100) }, { ["_lemonadeUniqueId"] = "tibfilK6tibf" })
			I[10] = new("ScrollingFrame", I[9], "Display", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(2, 0), Position = UDim2.fromScale(0.5, 0.5), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 6, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "TP5rjOMYTP5r" })
				I[11] = new("TextLabel", I[10], "TextLabel_PlayerName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.6), TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "yD4B6DNjyD4B" }, { "Custom_Font" })
		I[12] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) }, { ["_lemonadeUniqueId"] = "YemyAMa4Yemy" })
		I[13] = new("Frame", I[1], "Holder_Value", { BackgroundColor3 = Color3.fromRGB(0, 15, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 4, Size = UDim2.fromOffset(140, 80) }, { ["_lemonadeUniqueId"] = "iDF8gjRxiDF8" })
			I[14] = new("Frame", I[13], "Object", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.48) }, { ["Stroke"] = true, ["Text"] = "", ["TextCentered"] = true, ["TextSize"] = 10, ["_lemonadeUniqueId"] = "OcZ76HCoOcZ7" })
				I[15] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 226, 57)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 140)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "3rJIHOln3rJI" })
				I[16] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) }, { ["_lemonadeUniqueId"] = "LCKwKOhJLCKw" })
				I[17] = new("TextLabel", I[14], "TextLabel_ObjectName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Money/s:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true }, { ["_lemonadeUniqueId"] = "fXfNCulNfXfN" }, { "Custom_Font" })
			I[18] = new("CanvasGroup", I[13], "Holder", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 47, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(2, 0.48) }, { ["_lemonadeUniqueId"] = "vuVyqmwyvuVy" })
				I[19] = new("TextLabel", I[18], "TextLabel_Value", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 1.2), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextWrapped = true }, { ["_lemonadeUniqueId"] = "F6kCeCtNF6kC" }, { "Custom_Font" })
		I[20] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 18), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 8) }, { ["_lemonadeUniqueId"] = "A3pLAUVXA3pL" })
		I[21] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 25), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "Hw53rvjbHw53" })
	return I[1]
end

return build
