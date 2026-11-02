-- Generated from ui/ReplicatedStorage/Modules/ShopModule/ShopTabs/NewItem.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "NewItem", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 2, Position = UDim2.fromScale(0.4, 0), Size = UDim2.fromScale(0.2, 0.25), SizeConstraint = Enum.SizeConstraint.RelativeXX })
		I[2] = new("Frame", I[1], "Container", { BackgroundColor3 = Color3.fromRGB(57, 57, 57), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, ClipsDescendants = true, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 0.825, -6) })
			I[3] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://376565564"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2 })
			I[4] = new("TextButton", I[2], "ActionButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = "", TextSize = 14, ZIndex = 2 })
			I[5] = new("ImageLabel", I[2], "Gradient", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2957796423"), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 1) })
			I[6] = new("TextLabel", I[2], "Amount", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(1, -4, 0, 3), Size = UDim2.fromScale(0.5, 0.225), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeTransparency = 0.9, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
			I[7] = new("TextLabel", I[2], "Classic", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, LayoutOrder = 5, Position = UDim2.new(0.5, 0, 0, 6), Size = UDim2.fromScale(1, 0.175), Text = "CLASSIC", TextColor3 = Color3.fromRGB(255, 170, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.3, TextWrapped = true, Visible = false, ZIndex = 2 })
		I[8] = new("Frame", I[1], "ItemName", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(118, 118, 118), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.new(0, 3, 1, -1), Size = UDim2.new(1, -6, 0.175, 0) })
			I[9] = new("TextLabel", I[8], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "Knife Box  #1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, ZIndex = 2 })
			I[10] = new("ImageLabel", I[8], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2957790421"), Size = UDim2.fromScale(1, 1) })
		I[11] = new("Frame", I[1], "Tags", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 4, -0.175, -4), Size = UDim2.fromScale(1, 1) })
			I[12] = new("UIListLayout", I[11], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[13] = new("Frame", I[11], "Gems", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 4, Position = UDim2.new(0, 3, 1, 6), Size = UDim2.new(1, -6, 0.175, 0), Visible = false })
				I[14] = new("Frame", I[13], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(-6, 0), Size = UDim2.fromScale(1, 1) })
					I[15] = new("Frame", I[14], "PriceFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
						I[16] = new("TextLabel", I[15], "PriceLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 2, Position = UDim2.new(0, 0, 0.5, -3), Size = UDim2.fromScale(1, 1), Text = "100", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 2 })
					I[17] = new("ImageLabel", I[14], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://2576540162"), Size = UDim2.fromScale(1, 1), Visible = false })
					I[18] = new("ImageLabel", I[14], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(65, 65, 65), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://377010926"), LayoutOrder = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[19] = new("UIAspectRatioConstraint", I[18], "UIAspectRatioConstraint")
					I[20] = new("UIListLayout", I[14], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[21] = new("Frame", I[11], "Coins", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 5, Position = UDim2.new(0, 3, 1, 6), Size = UDim2.new(1, -6, 0.175, 0), Visible = false })
				I[22] = new("Frame", I[21], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(-6, 0), Size = UDim2.fromScale(1, 1) })
					I[23] = new("Frame", I[22], "PriceFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
						I[24] = new("TextLabel", I[23], "PriceLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 2, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1), Text = "2,000", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 2 })
					I[25] = new("ImageLabel", I[22], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://2576540162"), Size = UDim2.fromScale(1, 1), Visible = false })
					I[26] = new("ImageLabel", I[22], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(65, 65, 65), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://3150319038"), LayoutOrder = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[27] = new("UIAspectRatioConstraint", I[26], "UIAspectRatioConstraint")
					I[28] = new("UIListLayout", I[22], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[29] = new("Frame", I[11], "Owned", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 5, Position = UDim2.new(0, 3, 1, 6), Size = UDim2.new(1, -6, 0.175, 0), Visible = false })
				I[30] = new("Frame", I[29], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(-6, 0), Size = UDim2.fromScale(1, 1) })
					I[31] = new("Frame", I[30], "PriceFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
						I[32] = new("TextLabel", I[31], "PriceLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 2, Position = UDim2.new(0, 0, 0.5, -3), Size = UDim2.fromScale(1, 1), Text = "OWNED", TextColor3 = Color3.fromRGB(17, 255, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 2 })
					I[33] = new("ImageLabel", I[30], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://2576540162"), Size = UDim2.fromScale(1, 1), Visible = false })
					I[34] = new("UIListLayout", I[30], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
	return I[1]
end

return build
