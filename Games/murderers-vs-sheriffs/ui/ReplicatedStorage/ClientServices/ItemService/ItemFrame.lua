-- Generated from ui/ReplicatedStorage/ClientServices/ItemService/ItemFrame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "ItemFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 2, Size = UDim2.fromScale(1, 1) })
		I[2] = new("Frame", I[1], "Container", { BackgroundColor3 = Color3.fromRGB(57, 57, 57), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(1, 0.825) })
			I[3] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxthumb://type=Asset&w=150&h=150&id=16964448042"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
			I[5] = new("TextButton", I[2], "ActionButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextSize = 14, ZIndex = 2 })
			I[6] = new("TextLabel", I[2], "Amount", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(1, -4, 0, 3), Size = UDim2.fromScale(0.5, 0.225), Text = "x1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeTransparency = 0.9, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
			I[7] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5025907, Color3.fromRGB(253, 253, 253)), ColorSequenceKeypoint.new(1, Color3.fromRGB(197, 197, 197)) }), Rotation = 90 })
			I[8] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 2 })
		I[9] = new("Frame", I[1], "ItemName", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.175) })
			I[10] = new("TextLabel", I[9], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "KnifeName", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, ZIndex = 2 })
			I[11] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.2314335, Color3.fromRGB(251, 251, 251)), ColorSequenceKeypoint.new(1, Color3.fromRGB(162, 162, 162)) }) })
			I[12] = new("UIStroke", I[9], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 2 })
		I[13] = new("Frame", I[1], "Tags", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.825) })
			I[14] = new("Frame", I[13], "Chroma", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 213, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.new(0, 3, 0.8, -3), Size = UDim2.fromScale(0.5, 0.125), Visible = false })
				I[15] = new("TextLabel", I[14], "TagName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Chroma", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 2 })
				I[16] = new("ImageLabel", I[14], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://2576540162"), Size = UDim2.fromScale(1, 1) })
				I[17] = new("UIStroke", I[14], "UIStroke")
			I[18] = new("UIListLayout", I[13], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[19] = new("Frame", I[13], "Unique", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 213, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.new(0, 6, 0.8, -3), Size = UDim2.fromScale(1, 0.14) })
				I[20] = new("ImageLabel", I[19], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2954739019"), Position = UDim2.new(0.5, 0, 0.5, -3), Size = UDim2.new(1, 3, 1, 3), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
				I[21] = new("TextLabel", I[19], "PlayerName", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -8, 1, 0), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, ZIndex = 2 })
			I[22] = new("Frame", I[13], "Evo", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), LayoutOrder = 1, Position = UDim2.new(0, 3, 0.8, -3), Size = UDim2.fromScale(0.5, 0.125), Visible = false })
				I[23] = new("ImageLabel", I[22], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://2576540162"), Size = UDim2.fromScale(1, 1), Visible = false })
				I[24] = new("TextLabel", I[22], "TagName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Evo", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 2 })
				I[25] = new("UIGradient", I[22], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(84, 42, 255)), ColorSequenceKeypoint.new(0.4193012, Color3.fromRGB(48, 120, 188)), ColorSequenceKeypoint.new(0.7720466, Color3.fromRGB(24, 176, 146)), ColorSequenceKeypoint.new(1, Color3.fromRGB(4, 222, 113)) }) })
			I[26] = new("Frame", I[13], "FX", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.new(0, 3, 0.8, -3), Size = UDim2.fromScale(0.4, 0.125), Visible = false })
				I[27] = new("UIGradient", I[26], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 94, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(222, 185, 0)) }) })
				I[28] = new("TextLabel", I[26], "TagName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.new(0.5, 0, 1, 4), Text = "FX", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 2 })
				I[29] = new("ImageLabel", I[26], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://362390166"), Size = UDim2.fromScale(0.5, 1) })
					I[30] = new("UIAspectRatioConstraint", I[29], "UIAspectRatioConstraint")
					I[31] = new("UIGradient", I[29], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 162, 0)) }), Rotation = -180 })
				I[32] = new("UIListLayout", I[26], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[33] = new("UIPadding", I[26], "UIPadding", { PaddingBottom = UDim.new(0, 2), PaddingLeft = UDim.new(0, 2), PaddingTop = UDim.new(0, 1) })
				I[34] = new("UIStroke", I[26], "UIStroke")
			I[35] = new("UIPadding", I[13], "UIPadding", { PaddingBottom = UDim.new(0, 2) })
		I[36] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4), PaddingTop = UDim.new(0, 4) })
	return I[1]
end

return build
