-- Generated from ui/ReplicatedStorage/Assets/UI/Leaderboards/Speed.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Speed", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(0.995, 0, 0, 100) }, { ["_lemonadeUniqueId"] = "sg807FpJsg80" })
		I[2] = new("Frame", I[1], "Holder_Thumbnail", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(0.16, 0.75) }, { ["_lemonadeUniqueId"] = "Rq7KSW8aRq7K" })
			I[3] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 226, 226)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 153, 255)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "Hthqv6KsHthq" })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) }, { ["_lemonadeUniqueId"] = "VbHDdjCIVbHD" })
			I[5] = new("UIStroke", I[2], "UIStroke", { Thickness = 3 }, { ["ThicknessUDim"] = UDim.new(0, 3), ["_lemonadeUniqueId"] = "A9rVJx4uA9rV" })
			I[6] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "jQuefHEqjQue" })
			I[7] = new("ImageLabel", I[2], "ImageLabel_PlayerThumb", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "pEbcUdaopEbc" })
				I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) }, { ["_lemonadeUniqueId"] = "TB0OV1GiTB0O" })
		I[9] = new("Frame", I[1], "Holder_PlayerName", { BackgroundColor3 = Color3.fromRGB(0, 15, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromOffset(195, 100) }, { ["_lemonadeUniqueId"] = "qufKZH8GqufK" })
			I[10] = new("ScrollingFrame", I[9], "Display", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(2, 0), Position = UDim2.fromScale(0.5, 0.5), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 6, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "DDAZfVo8DDAZ" })
				I[11] = new("TextLabel", I[10], "TextLabel_PlayerName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.6), TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "AwsKS2aIAwsK" }, { "Custom_Font" })
		I[12] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) }, { ["_lemonadeUniqueId"] = "WfCGTLCIWfCG" })
		I[13] = new("Frame", I[1], "Holder_Value", { BackgroundColor3 = Color3.fromRGB(0, 221, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 4, Size = UDim2.fromOffset(140, 80) }, { ["_lemonadeUniqueId"] = "u9PVfWjRu9PV" })
			I[14] = new("Frame", I[13], "Object", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.48) }, { ["Stroke"] = true, ["Text"] = "", ["TextCentered"] = true, ["TextSize"] = 10, ["_lemonadeUniqueId"] = "ebngVZzlebng" })
				I[15] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 226, 226)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 153, 255)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "RmsNiS60RmsN" })
				I[16] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) }, { ["_lemonadeUniqueId"] = "ICd0EBFFICd0" })
				I[17] = new("TextLabel", I[14], "TextLabel_ObjectName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Speed:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true }, { ["_lemonadeUniqueId"] = "I6rZLIb7I6rZ" }, { "Custom_Font" })
			I[18] = new("CanvasGroup", I[13], "Holder", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 47, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(2, 0.48) }, { ["_lemonadeUniqueId"] = "QYJb3uLJQYJb" })
				I[19] = new("TextLabel", I[18], "TextLabel_Value", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 1.2), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextWrapped = true }, { ["_lemonadeUniqueId"] = "jL4n9xQAjL4n" }, { "Custom_Font" })
		I[20] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 18), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 8) }, { ["_lemonadeUniqueId"] = "7934kKuq7934" })
		I[21] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 25), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "F13b0iFPF13b" })
	return I[1]
end

return build
