-- Generated from ui/ReplicatedStorage/Modules/ShopModule/HotItems/NewHotItem.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "NewHotItem", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 2, Position = UDim2.fromScale(0, 0.15), Size = UDim2.fromScale(0.25, 1) })
		I[2] = new("Frame", I[1], "Container", { BackgroundColor3 = Color3.fromRGB(57, 57, 57), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, ClipsDescendants = true, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 0.825, -6) })
			I[3] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=310709709"), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1.2, 1.2), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2 })
			I[4] = new("TextButton", I[2], "ActionButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = "", TextSize = 14, ZIndex = 2 })
			I[5] = new("ImageLabel", I[2], "Gradient", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2957796423"), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 1) })
			I[6] = new("TextLabel", I[2], "Amount", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(1, -4, 0, 3), Size = UDim2.fromScale(0.5, 0.225), Text = "x1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeTransparency = 0.9, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false, ZIndex = 3 })
			I[7] = new("TextLabel", I[2], "New", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.6, 0.2), Text = "New!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeTransparency = 0.3, TextWrapped = true, ZIndex = 3 })
		I[8] = new("Frame", I[1], "ItemName", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(149, 149, 149), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.new(0, 3, 1, -1), Size = UDim2.new(1, -6, 0.175, 0) })
			I[9] = new("TextLabel", I[8], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "Yellow Sparkle", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true, ZIndex = 2 })
			I[10] = new("ImageLabel", I[8], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2957790421"), Size = UDim2.fromScale(1, 1) })
		I[11] = new("Frame", I[1], "Tags", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 8, -0.15, -3), Size = UDim2.new(1, -8, 0.98, 0) })
			I[12] = new("UIListLayout", I[11], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[13] = new("Frame", I[11], "Price", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.new(0, 3, 0.8, -3), Size = UDim2.fromScale(1, 0.175), Visible = false })
				I[14] = new("ImageLabel", I[13], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://2576540162"), Size = UDim2.fromScale(1, 1), Visible = false })
				I[15] = new("ImageLabel", I[13], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(65, 65, 65), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=377010926"), LayoutOrder = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2 })
				I[16] = new("UIListLayout", I[13], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[17] = new("Frame", I[13], "PriceFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 2, Size = UDim2.fromScale(3, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
					I[18] = new("TextLabel", I[17], "Amount", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 2, Position = UDim2.fromScale(0.55, 0.425), Size = UDim2.fromScale(3, 1.25), SizeConstraint = Enum.SizeConstraint.RelativeYY, Text = "25", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
			I[19] = new("ImageLabel", I[11], "Timer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=360623295"), Size = UDim2.fromOffset(50, 50), Visible = false })
				I[20] = new("TextLabel", I[19], "TimeLeft", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(50, 0), Size = UDim2.fromOffset(120, 30), Text = "48:38:07", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 36, TextStrokeTransparency = 0.7 })
				I[21] = new("TextLabel", I[19], "Days", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(50, 30), Size = UDim2.fromOffset(120, 20), Text = "2 days left!", TextColor3 = Color3.fromRGB(255, 0, 0), TextSize = 28, TextStrokeColor3 = Color3.fromRGB(54, 0, 0), TextStrokeTransparency = 0.7 })
			I[22] = new("Frame", I[11], "Chroma", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromOffset(100, 100) })
		I[23] = new("ImageLabel", I[1], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=360597458"), Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(1.2, 0, 0, 25), Visible = false })
	return I[1]
end

return build
