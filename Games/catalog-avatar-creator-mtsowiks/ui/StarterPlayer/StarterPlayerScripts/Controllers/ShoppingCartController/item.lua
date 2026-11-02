-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/ShoppingCartController/item.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "item", { BackgroundColor3 = Color3.fromRGB(33, 34, 39), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5255405), Size = UDim2.fromScale(1, 0.3218112), SizeConstraint = Enum.SizeConstraint.RelativeXX }, { ["isItem"] = true })
		I[2] = new("ImageLabel", I[1], "icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(43, 45, 51), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=Asset&id=11432067722&w=150&h=150"), ImageTransparency = 0.33, Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3350348, 0.9226086) }, { ["SkipThemeImage"] = true })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
			I[4] = new("UICorner", I[2], "UICorner")
			I[5] = new("TextButton", I[2], "checkbox", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[6] = new("ImageLabel", I[5], "unchecked", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(22, 23, 26), BackgroundTransparency = 0.65, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://108840008135273"), Position = UDim2.fromScale(1, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.343, 0.358) })
					I[7] = new("UICorner", I[6], "UICorner")
				I[8] = new("ImageLabel", I[5], "checked", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://71418101941296"), ImageTransparency = 1, Position = UDim2.fromScale(1, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.343, 0.358) })
		I[9] = new("TextLabel", I[1], "price", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3149206, 0.8192709), Size = UDim2.fromScale(0.645925, 0.2124322), Text = "95", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[10] = new("ImageButton", I[1], "unequip", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81024172191247"), ImageTransparency = 0.82, Position = UDim2.fromScale(0.9816103, 0.4999997), Size = UDim2.fromScale(0.1022948, 0.4087845), ZIndex = 10 })
			I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint")
		I[12] = new("TextLabel", I[1], "name", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3149206, 0.3478948), Size = UDim2.fromScale(0.5663577, 0.6220818), Text = "Friendly Pirate", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 29, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top }, { ["baseSize"] = 32, ["baseX"] = 1960, ["baseY"] = 1190, ["sizeConstraint"] = "XX" }, { "ScaledTextSizeMultiLine" })
			I[13] = new("TextButton", I[12], "inspectButton", { AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Text = "", ZIndex = 2 })
	return I[1]
end

return build
