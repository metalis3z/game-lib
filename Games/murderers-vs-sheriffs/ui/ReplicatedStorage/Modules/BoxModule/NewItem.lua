-- Generated from ui/ReplicatedStorage/Modules/BoxModule/NewItem.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "NewItem", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromScale(0.2, 0.25), SizeConstraint = Enum.SizeConstraint.RelativeXX })
		I[2] = new("Frame", I[1], "Container", { BackgroundColor3 = Color3.fromRGB(57, 57, 57), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, ClipsDescendants = true, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 0.825, -6) })
			I[3] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
			I[4] = new("ImageLabel", I[2], "Gradient", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2957796423"), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 1) })
		I[5] = new("Frame", I[1], "ItemName", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(220, 220, 220), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.new(0, 3, 1, -1), Size = UDim2.new(1, -6, 0.175, 0) })
			I[6] = new("TextLabel", I[5], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "Loading...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, ZIndex = 2 })
			I[7] = new("ImageLabel", I[5], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2957790421"), Size = UDim2.fromScale(1, 1) })
		I[8] = new("Frame", I[1], "Tags", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 4, -0.175, -4), Size = UDim2.fromScale(1, 1) })
			I[9] = new("Frame", I[8], "Halloween2", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 213, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.new(0, 6, 0.8, -3), Size = UDim2.fromScale(0.275, 0.275), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
				I[10] = new("ImageLabel", I[9], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2954739019"), Position = UDim2.new(0.5, 0, 0.5, -3), Size = UDim2.new(1, 3, 1, 3), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[11] = new("TextLabel", I[9], "Year", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.5, 2), Size = UDim2.fromScale(0.8, 1), Text = "2018", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 2 })
				I[12] = new("TextLabel", I[9], "Year2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.new(0.5, 0, 0.5, -2), Size = UDim2.fromScale(0.8, 1), Text = "2018", TextColor3 = Color3.fromRGB(213, 213, 213), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false, ZIndex = 2 })
			I[13] = new("Frame", I[8], "Chroma", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 213, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), LayoutOrder = 1, Position = UDim2.new(0, 3, 0.8, -3), Size = UDim2.fromScale(0.5, 0.125), Visible = false })
				I[14] = new("TextLabel", I[13], "TagName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Chroma", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 2 })
				I[15] = new("ImageLabel", I[13], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://2576540162"), Size = UDim2.fromScale(1, 1) })
			I[16] = new("UIListLayout", I[8], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[17] = new("Frame", I[8], "Christmas2", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 213, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.new(0, 6, 0.8, -3), Size = UDim2.fromScale(0.275, 0.275), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
				I[18] = new("TextLabel", I[17], "Year", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Selectable = true, Size = UDim2.fromScale(0.9, 1), Text = "2018", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 2 })
				I[19] = new("ImageLabel", I[17], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2954412467"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[20] = new("TextLabel", I[17], "Year2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.new(0.5, 0, 0.5, -2), Size = UDim2.fromScale(0.8, 1), Text = "2018", TextColor3 = Color3.fromRGB(213, 213, 213), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false, ZIndex = 2 })
			I[21] = new("Frame", I[8], "Unique", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 213, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.new(0, 6, 0.8, -3), Size = UDim2.new(1, -8, 0.14, 0), Visible = false })
				I[22] = new("ImageLabel", I[21], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2954739019"), Position = UDim2.new(0.5, 0, 0.5, -3), Size = UDim2.new(1, 3, 1, 3), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
				I[23] = new("TextLabel", I[21], "PlayerName", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, ZIndex = 2 })
	return I[1]
end

return build
