-- Generated from ui/ServerStorage/DisabledOldAdminSystem/StarterGui/CreatorWindow.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "CreatorWindow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0, 450, 1, 0), Visible = false })
		I[2] = new("TextLabel", I[1], "PrivateServer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Private Servers Only", TextColor3 = Color3.fromRGB(138, 138, 138), TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false })
		I[3] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0, 6), BottomRightRadius = UDim.new(0, 6), TopLeftRadius = UDim.new(0, 6), TopRightRadius = UDim.new(0, 6) })
		I[4] = new("UIListLayout", I[1], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly })
		I[5] = new("UISizeConstraint", I[1], "UISizeConstraint", { MaxSize = Vector2.new(700, 350) })
		I[6] = new("Frame", I[1], "Title", { BackgroundColor3 = Color3.fromRGB(47, 47, 47), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.15) })
			I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0, 6), BottomRightRadius = UDim.new(0, 6), TopLeftRadius = UDim.new(0, 6), TopRightRadius = UDim.new(0, 6) })
			I[8] = new("TextLabel", I[6], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Creator Tools", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[9] = new("UIPadding", I[6], "UIPadding", { PaddingBottom = UDim.new(0, 5), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 5), PaddingTop = UDim.new(0, 5) })
			I[10] = new("Frame", I[6], "Close", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(177, 61, 63), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(1, -5, 0.5, 0), Size = UDim2.new(0, 45, 1, -5) })
				I[11] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0, 3), BottomRightRadius = UDim.new(0, 3), TopLeftRadius = UDim.new(0, 3), TopRightRadius = UDim.new(0, 3) })
				I[12] = new("ImageButton", I[10], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
				I[13] = new("TextLabel", I[10], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 2 })
				I[15] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(121, 42, 44), Thickness = 3 })
			I[16] = new("Frame", I[6], "Info", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(49, 121, 177), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(1, -60, 0.5, 0), Size = UDim2.new(0, 40, 1, -5), Visible = false })
				I[17] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0, 3), BottomRightRadius = UDim.new(0, 3), TopLeftRadius = UDim.new(0, 3), TopRightRadius = UDim.new(0, 3) })
				I[18] = new("ImageButton", I[16], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
				I[19] = new("TextLabel", I[16], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "?", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 2 })
				I[21] = new("UIStroke", I[16], "UIStroke", { Color = Color3.fromRGB(32, 79, 115), Thickness = 3 })
				I[22] = new("UIAspectRatioConstraint", I[16], "UIAspectRatioConstraint")
	return I[1]
end

return build
