-- Generated from ui/ReplicatedStorage/ClientServices/CraftingService/CraftFrame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "CraftFrame", { BackgroundColor3 = Color3.fromRGB(24, 24, 24), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0.5, -3) })
		I[2] = new("TextLabel", I[1], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 24), Text = "Input", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 22 })
		I[3] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3), PaddingTop = UDim.new(0, 3) })
		I[4] = new("Frame", I[1], "MultipleContainer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.new(1, 0, 1, -24), Visible = false })
			I[5] = new("UIGridLayout", I[4], "UIGridLayout", { CellPadding = UDim2.fromOffset(6, 6), CellSize = UDim2.new(0.5, -3, 0.5, -3), SortOrder = Enum.SortOrder.LayoutOrder })
			I[6] = new("UIPadding", I[4], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3), PaddingTop = UDim.new(0, 3) })
			I[7] = new("Frame", I[4], "Material1", { BackgroundColor3 = Color3.fromRGB(65, 65, 65), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromOffset(100, 100) })
				I[8] = new("ImageLabel", I[7], "Icon", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=377277359"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[9] = new("UIAspectRatioConstraint", I[8], "UIAspectRatioConstraint")
				I[10] = new("TextLabel", I[7], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 1, -3), Text = "Common Shards", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
					I[11] = new("UIStroke", I[10], "UIStroke")
				I[12] = new("TextLabel", I[7], "Amount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(-3, 3), Size = UDim2.fromScale(1, 1), Text = "x3", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top })
					I[13] = new("UIStroke", I[12], "UIStroke")
			I[14] = new("Frame", I[4], "Material2", { BackgroundColor3 = Color3.fromRGB(65, 65, 65), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromOffset(100, 100) })
				I[15] = new("TextLabel", I[14], "Amount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(-3, 3), Size = UDim2.fromScale(1, 1), Text = "x3", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top })
					I[16] = new("UIStroke", I[15], "UIStroke")
				I[17] = new("TextLabel", I[14], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 1, -3), Text = "Common Shards", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
					I[18] = new("UIStroke", I[17], "UIStroke")
				I[19] = new("ImageLabel", I[14], "Icon", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=377277359"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[20] = new("UIAspectRatioConstraint", I[19], "UIAspectRatioConstraint")
			I[21] = new("Frame", I[4], "Material3", { BackgroundColor3 = Color3.fromRGB(65, 65, 65), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Size = UDim2.fromOffset(100, 100) })
				I[22] = new("TextLabel", I[21], "Amount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(-3, 3), Size = UDim2.fromScale(1, 1), Text = "x3", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top })
					I[23] = new("UIStroke", I[22], "UIStroke")
				I[24] = new("TextLabel", I[21], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 1, -3), Text = "Common Shards", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
					I[25] = new("UIStroke", I[24], "UIStroke")
				I[26] = new("ImageLabel", I[21], "Icon", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=377277359"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[27] = new("UIAspectRatioConstraint", I[26], "UIAspectRatioConstraint")
			I[28] = new("Frame", I[4], "Material4", { BackgroundColor3 = Color3.fromRGB(65, 65, 65), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 4, Size = UDim2.fromOffset(100, 100) })
				I[29] = new("TextLabel", I[28], "Amount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(-3, 3), Size = UDim2.fromScale(1, 1), Text = "x3", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top })
					I[30] = new("UIStroke", I[29], "UIStroke")
				I[31] = new("TextLabel", I[28], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 1, -3), Text = "Common Shards", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
					I[32] = new("UIStroke", I[31], "UIStroke")
				I[33] = new("ImageLabel", I[28], "Icon", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=377277359"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[34] = new("UIAspectRatioConstraint", I[33], "UIAspectRatioConstraint")
		I[35] = new("UIListLayout", I[1], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
		I[36] = new("Frame", I[1], "SingleContainer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.new(1, 0, 1, -24), Visible = false })
			I[37] = new("UIPadding", I[36], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3), PaddingTop = UDim.new(0, 3) })
			I[38] = new("Frame", I[36], "NewItem", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.85, 0, 1, -10), SizeConstraint = Enum.SizeConstraint.RelativeXX })
				I[39] = new("Frame", I[38], "Container", { BackgroundColor3 = Color3.fromRGB(57, 57, 57), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, ClipsDescendants = true, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 0.825, -6) })
					I[40] = new("ImageLabel", I[39], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=2533350813"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2 })
					I[41] = new("TextButton", I[39], "ActionButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextSize = 14, ZIndex = 2 })
					I[42] = new("ImageLabel", I[39], "Gradient", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2957796423"), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 1) })
					I[43] = new("TextLabel", I[39], "Amount", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(1, -4, 0, 3), Size = UDim2.fromScale(0.5, 0.225), Text = "x1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeTransparency = 0.9, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
					I[44] = new("TextLabel", I[39], "TradeAmount", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(59, 255, 0), TextScaled = true, TextSize = 18, TextStrokeTransparency = 0.9, TextWrapped = true, ZIndex = 3 })
				I[45] = new("Frame", I[38], "ItemName", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 0, 179), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.new(0, 3, 1, -1), Size = UDim2.new(1, -6, 0.175, 0) })
					I[46] = new("TextLabel", I[45], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "Nik's Scythe", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, ZIndex = 2 })
					I[47] = new("ImageLabel", I[45], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2957790421"), Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
