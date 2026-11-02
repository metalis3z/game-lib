-- Generated from ui/ServerStorage/lol.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "lol", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), Position = UDim2.fromScale(0.3068513, 0.3209876), Size = UDim2.fromScale(0.442925, 0.4098766) })
			I[3] = new("UICorner", I[2], "UICorner")
			I[4] = new("Frame", I[2], "Player", { BackgroundColor3 = Color3.fromRGB(22, 22, 22) })
				I[5] = new("UIListLayout", I[4], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[6] = new("UIPadding", I[4], "UIPadding", { PaddingLeft = UDim.new(0, 5) })
				I[7] = new("ImageLabel", I[4], "Avatar", { BackgroundColor3 = Color3.fromRGB(66, 66, 66), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0, 0.1022727), Size = UDim2.fromScale(math.huge, 0/0) })
					I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[9] = new("UICorner", I[4], "UICorner")
				I[10] = new("TextLabel", I[4], "Display", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1198738, 0.2840909), Size = UDim2.fromScale(math.huge, 0/0), TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[11] = new("TextLabel", I[4], "Robux", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5646688, 0.2840909), Size = UDim2.fromScale(math.huge, 0/0), Text = "0", TextColor3 = Color3.fromRGB(85, 170, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
			I[12] = new("ScrollingFrame", I[2], "ScrollingFrame", { Active = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.0118812, 0.0271084), ScrollBarThickness = 5, Size = UDim2.fromScale(0.6594059, 0.9487952) })
				I[13] = new("UIListLayout", I[12], "UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder })
			I[14] = new("Frame", I[2], "Frame", { BackgroundColor3 = Color3.fromRGB(45, 45, 45), Position = UDim2.fromScale(0.6851485, 0), Size = UDim2.fromScale(0.3148515, 1) })
				I[15] = new("UICorner", I[14], "UICorner")
				I[16] = new("UIListLayout", I[14], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[17] = new("ImageLabel", I[14], "Avatar", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Size = UDim2.fromScale(0.6289308, 0.3012048) })
				I[18] = new("TextLabel", I[14], "Display", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0031447, 0.626506), Size = UDim2.fromScale(1.0062894, 0.0572289), TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[19] = new("TextLabel", I[14], "User", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0031447, 0.6656626), Size = UDim2.fromScale(1.0062894, 0.0481928), Text = "@", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.24, TextWrapped = true })
				I[20] = new("TextBox", I[14], "TextBox", { BackgroundColor3 = Color3.fromRGB(29, 29, 29), ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.fromScale(0.2735849, 0.683735), Size = UDim2.fromScale(0.8553459, 0.1174699), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true })
					I[21] = new("UICorner", I[20], "UICorner")
	return I[1]
end

return build
