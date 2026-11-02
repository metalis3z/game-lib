-- Generated from ui/ServerStorage/ExampleGifts/Old.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Old", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 0, 115), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Size = UDim2.fromScale(1, 0) })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.085, 0), BottomRightRadius = UDim.new(0.085, 0), TopLeftRadius = UDim.new(0.085, 0), TopRightRadius = UDim.new(0.085, 0) })
		I[3] = new("UIListLayout", I[1], "UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder })
		I[4] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 8) })
		I[5] = new("Frame", I[1], "UserInfo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 26) })
			I[6] = new("UIListLayout", I[5], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 6), VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[7] = new("ImageLabel", I[5], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=2949104238&w=420&h=420"), Size = UDim2.fromOffset(26, 26) })
				I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[9] = new("TextLabel", I[5], "TextLabel", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), RichText = true, Size = UDim2.fromOffset(0, 22), Text = "Bikini_Carrot <b><font face='GothamSemibold' color='rgb(255, 204, 227)'>@Bikini_Carrot</font></b>", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 22 })
		I[10] = new("TextLabel", I[1], "TextLabel", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), RichText = true, Size = UDim2.new(1, 0, 0, 16), Text = "Gifted <b>1,000,000 Robux</b>", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16 })
		I[11] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 14), Text = "hey", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
		I[12] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 14), Text = "an hour ago", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
		I[13] = new("TextButton", I[1], "TextButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 28), Text = "CLAIM", TextColor3 = Color3.fromRGB(255, 0, 115), TextSize = 28 })
			I[14] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
	return I[1]
end

return build
