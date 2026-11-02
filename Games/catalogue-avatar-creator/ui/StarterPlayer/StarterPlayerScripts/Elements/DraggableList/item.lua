-- Generated from ui/StarterPlayer/StarterPlayerScripts/Elements/DraggableList/item.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "item", { BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(1, -4, 0.272, -4), SizeConstraint = Enum.SizeConstraint.RelativeXX }, { ["isItem"] = true })
		I[2] = new("ImageLabel", I[1], "dragIndicator", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://115356720605811"), ImageTransparency = 0.33, Position = UDim2.fromScale(0, 0.4999999), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0858585, 0.807065) })
		I[3] = new("TextLabel", I[1], "itemName", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.348, 0.5), Size = UDim2.fromScale(0.5183573, 0.3424965), Text = "1312312312321", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[4] = new("ImageLabel", I[1], "itemThumb", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(42, 44, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=Asset&id=11432067722&w=150&h=150"), ImageTransparency = 0.33, Position = UDim2.fromScale(0.093693, 0.4999998), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2621631, 0.8070651) })
			I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint")
			I[6] = new("UICorner", I[4], "UICorner")
		I[7] = new("TextButton", I[1], "drag", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1 })
	return I[1]
end

return build
