-- Generated from ui/ServerStorage/Christmas/ShopItem.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "ShopItem", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(0.5, 0, 0, 75), SizeConstraint = Enum.SizeConstraint.RelativeXX })
		I[2] = new("Frame", I[1], "Container", { BackgroundColor3 = Color3.fromRGB(239, 239, 239), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8) })
			I[3] = new("ImageLabel", I[2], "RewardIcon", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://583684053"), Position = UDim2.fromOffset(1, 24), Size = UDim2.fromOffset(42, 42), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2 })
			I[4] = new("ImageLabel", I[2], "CostIcon", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://584578609"), Position = UDim2.new(1, -26, 1, -26), Size = UDim2.fromOffset(25, 25), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2 })
			I[5] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(1, 0), Size = UDim2.new(1, -2, 0, 25), Text = "100 Blue Tokens", TextColor3 = Color3.fromRGB(58, 58, 58), TextScaled = true, TextSize = 18, TextWrapped = true })
			I[6] = new("TextLabel", I[2], "CostText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 50, 1, -25), Size = UDim2.new(1, -77, 0.5, -12), Text = "x1", TextColor3 = Color3.fromRGB(129, 129, 129), TextSize = 24, TextXAlignment = Enum.TextXAlignment.Right })
			I[7] = new("TextButton", I[2], "Buy", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(43, 0), Size = UDim2.new(1, -43, 0.5, 6), Style = Enum.ButtonStyle.RobloxRoundDefaultButton, Text = "Buy", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.7, TextWrapped = true, Visible = false })
			I[8] = new("TextLabel", I[2], "Purchased", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 1, 0.5, -12), Size = UDim2.new(1, -2, 0, 25), Text = "Purchased", TextColor3 = Color3.fromRGB(179, 240, 132), TextSize = 32, TextStrokeTransparency = 0, TextWrapped = true, Visible = false, ZIndex = 3 })
	return I[1]
end

return build
