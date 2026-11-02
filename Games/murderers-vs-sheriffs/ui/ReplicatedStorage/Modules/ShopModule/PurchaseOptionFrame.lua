-- Generated from ui/ReplicatedStorage/Modules/ShopModule/PurchaseOptionFrame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "PurchaseOptionFrame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 10, Position = UDim2.new(0, 3, 1, 6), Size = UDim2.fromScale(1, 0.25), Visible = false })
		I[2] = new("TextButton", I[1], "Buy", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromScale(1, 1), Style = Enum.ButtonStyle.RobloxRoundDefaultButton, Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 32, TextStrokeTransparency = 0.7, TextWrapped = true })
		I[3] = new("Frame", I[1], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(-6, 0), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
			I[4] = new("Frame", I[3], "PriceFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.9) })
				I[5] = new("TextLabel", I[4], "PriceLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.new(0, 0, 0.5, -2), Size = UDim2.fromScale(1, 1), Text = "125", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 2 })
			I[6] = new("ImageLabel", I[3], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://2576540162"), Size = UDim2.fromScale(1, 1), Visible = false })
			I[7] = new("ImageLabel", I[3], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(65, 65, 65), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://4521639303"), LayoutOrder = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.7), ZIndex = 2 })
				I[8] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint")
				I[9] = new("ImageLabel", I[7], "Insufficient", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(65, 65, 65), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://3081649687"), LayoutOrder = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
			I[10] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[11] = new("ImageLabel", I[1], "BG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 255, 217), ImageContent = Content.fromUri("rbxassetid://3032214721"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 15, 15), Visible = false })
	return I[1]
end

return build
