-- Generated from ui/ReplicatedStorage/AccessoriesStore.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "AccessoriesStore", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.8569915, 0.4024823), Size = UDim2.fromScale(0.2341137, 0.3144209) })
			I[3] = new("TextLabel", I[2], "Top", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/DenkOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1171429, 0.0248028), Size = UDim2.fromScale(0.7628571, 0.12), Text = "Street Caps", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.03, 0), BottomRightRadius = UDim.new(0.03, 0), TopLeftRadius = UDim.new(0.03, 0), TopRightRadius = UDim.new(0.03, 0) })
			I[5] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(2, 209, 255), Thickness = 3 })
			I[6] = new("TextLabel", I[2], "Current", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/DenkOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.2514866), Size = UDim2.fromScale(1, 0.090873), Text = "Accessories", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[7] = new("TextLabel", I[2], "CurrentNumber", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/DenkOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2857143, 0.3462236), Size = UDim2.fromScale(0.4285714, 0.2551586), Text = "1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[8] = new("TextButton", I[2], "Right", { BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5885714, 0.3426521), Size = UDim2.fromScale(0.1428571, 0.2551586), Text = ">", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
				I[9] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
			I[10] = new("TextLabel", I[2], "CurrentName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/DenkOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.598479), Size = UDim2.fromScale(1, 0.090873), Text = "Balaclava", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[11] = new("TextLabel", I[2], "CurrentPrice", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/DenkOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.7262986), Size = UDim2.fromScale(1, 0.090873), Text = " $1000", TextColor3 = Color3.fromRGB(170, 255, 127), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[12] = new("TextButton", I[2], "Close", { BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/DenkOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8742857, 0.0112781), Size = UDim2.fromScale(0.1257143, 0.1468709), Text = "X", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[13] = new("ScrollingFrame", I[2], "CurrentOwned", { Active = true, BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 4), Position = UDim2.fromScale(0.0864079, 1.1691725), ScrollBarThickness = 5, Size = UDim2.fromOffset(286, 191) })
				I[14] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(2, 209, 255), Thickness = 3 })
				I[15] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.03, 0), BottomRightRadius = UDim.new(0.03, 0), TopLeftRadius = UDim.new(0.03, 0), TopRightRadius = UDim.new(0.03, 0) })
				I[16] = new("UIListLayout", I[13], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.001, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[17] = new("UIPadding", I[13], "UIPadding", { PaddingTop = UDim.new(0.001, 0) })
			I[18] = new("TextLabel", I[2], "Top", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/DenkOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1171428, 1.0435995), Size = UDim2.fromScale(0.7628572, 0.101203), Text = "Currently Wearing", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[19] = new("TextButton", I[2], "Left", { BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2685714, 0.3426521), Size = UDim2.fromScale(0.1428571, 0.2551586), Text = "<", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
				I[20] = new("UICorner", I[19], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
			I[21] = new("TextButton", I[2], "Purchase", { BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/DenkOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0514286, 0.8426992), Size = UDim2.fromScale(0.8942857, 0.1222301), Text = "PURCHASE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
				I[22] = new("UICorner", I[21], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
				I[23] = new("UIStroke", I[21], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(0, 255, 0), Thickness = 2 })
				I[24] = new("UITextSizeConstraint", I[21], "UITextSizeConstraint", { MaxTextSize = 35, MinTextSize = 15 })
			I[25] = new("TextLabel", I[2], "Top", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/DenkOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0864086, 1.9120202), Size = UDim2.fromScale(0.8237551, 0.0786467), Text = "Press on any accessory to remove it!", TextColor3 = Color3.fromRGB(175, 175, 175), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.2, TextTransparency = 0.2, TextWrapped = true })
			I[26] = new("TextButton", I[2], "CLONE", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/DenkOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0465037, 0.0366492), Size = UDim2.fromScale(0.95, 0.03), Text = "AK-47", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
				I[27] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
		I[28] = new("Sound", I[1], "Kaching", { RollOffMaxDistance = 75, Volume = 2 })
		I[29] = new("Sound", I[1], "Press", { Volume = 0.8 })
		I[30] = new("Sound", I[1], "Error", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 1 })
	return I[1]
end

return build
