-- Generated from ui/ServerStorage/ProfileStatsImportBackup/ProfileStatsFromCoolGame/Inventory/ItemOld.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "ItemOld", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 2, Position = UDim2.fromScale(0.4, 0), Size = UDim2.fromScale(0.2, 0.25), SizeConstraint = Enum.SizeConstraint.RelativeXX })
		I[2] = new("Frame", I[1], "Container", { BackgroundColor3 = Color3.fromRGB(57, 57, 57), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, ClipsDescendants = true, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 0.825, -6) })
			I[3] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=2533350813"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2 })
			I[4] = new("TextButton", I[2], "ActionButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextSize = 14, ZIndex = 2 })
			I[5] = new("ImageLabel", I[2], "Gradient", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2957796423"), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 1) })
			I[6] = new("TextLabel", I[2], "Amount", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(1, -4, 0, 3), Size = UDim2.fromScale(0.5, 0.225), Text = "x1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeTransparency = 0.9, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
		I[7] = new("Frame", I[1], "ItemName", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 0, 179), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.new(0, 3, 1, -1), Size = UDim2.new(1, -6, 0.175, 0) })
			I[8] = new("TextLabel", I[7], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "Nik's Scythe", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, ZIndex = 2 })
			I[9] = new("ImageLabel", I[7], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2957790421"), Size = UDim2.fromScale(1, 1) })
		I[10] = new("Frame", I[1], "Tags", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 4, -0.175, -4), Size = UDim2.fromScale(1, 1) })
			I[11] = new("Frame", I[10], "Evo", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), LayoutOrder = 1, Position = UDim2.new(0, 3, 0.8, -3), Size = UDim2.fromScale(0.5, 0.125) })
				I[12] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(84, 42, 255)), ColorSequenceKeypoint.new(0.4193012, Color3.fromRGB(48, 120, 188)), ColorSequenceKeypoint.new(0.7720466, Color3.fromRGB(24, 176, 146)), ColorSequenceKeypoint.new(1, Color3.fromRGB(4, 222, 113)) }) })
				I[13] = new("TextLabel", I[11], "TagName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Evo", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 2 })
				I[14] = new("ImageLabel", I[11], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://2576540162"), Size = UDim2.fromScale(1, 1), Visible = false })
			I[15] = new("Frame", I[10], "Halloween", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 213, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.new(0, 6, 0.8, -3), Size = UDim2.fromScale(0.275, 0.275), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
				I[16] = new("ImageLabel", I[15], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2954739019"), Position = UDim2.new(0.5, 0, 0.5, -3), Size = UDim2.new(1, 3, 1, 3), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[17] = new("TextLabel", I[15], "Year", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.5, 2), Size = UDim2.fromScale(0.8, 1), Text = "2018", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 2 })
				I[18] = new("TextLabel", I[15], "Year2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.new(0.5, 0, 0.5, -2), Size = UDim2.fromScale(0.8, 1), Text = "2018", TextColor3 = Color3.fromRGB(213, 213, 213), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false, ZIndex = 2 })
			I[19] = new("Frame", I[10], "Chroma", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 213, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), LayoutOrder = 1, Position = UDim2.new(0, 3, 0.8, -3), Size = UDim2.fromScale(0.5, 0.125), Visible = false })
				I[20] = new("TextLabel", I[19], "TagName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Chroma", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 2 })
				I[21] = new("ImageLabel", I[19], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://2576540162"), Size = UDim2.fromScale(1, 1) })
			I[22] = new("UIListLayout", I[10], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[23] = new("Frame", I[10], "Christmas", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 213, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.new(0, 6, 0.8, -3), Size = UDim2.fromScale(0.275, 0.275), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
				I[24] = new("TextLabel", I[23], "Year", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Selectable = true, Size = UDim2.fromScale(0.9, 1), Text = "2018", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 2 })
				I[25] = new("ImageLabel", I[23], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2954412467"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[26] = new("TextLabel", I[23], "Year2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.new(0.5, 0, 0.5, -2), Size = UDim2.fromScale(0.8, 1), Text = "2018", TextColor3 = Color3.fromRGB(213, 213, 213), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false, ZIndex = 2 })
			I[27] = new("Frame", I[10], "Unique", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 213, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.new(0, 6, 0.8, -3), Size = UDim2.new(1, -8, 0.14, 0), Visible = false })
				I[28] = new("ImageLabel", I[27], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2954739019"), Position = UDim2.new(0.5, 0, 0.5, -3), Size = UDim2.new(1, 3, 1, 3), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
				I[29] = new("TextLabel", I[27], "PlayerName", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, ZIndex = 2 })
	return I[1]
end

return build
