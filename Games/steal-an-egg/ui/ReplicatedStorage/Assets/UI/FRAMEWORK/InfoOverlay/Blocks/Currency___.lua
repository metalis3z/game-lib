-- Generated from ui/ReplicatedStorage/Assets/UI/FRAMEWORK/InfoOverlay/Blocks/Currency___.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Currency___", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 100, Size = UDim2.new(1, 0, 0, 40) })
		I[2] = new("Configuration", I[1], "settings", nil, { ["boundsX"] = Vector2.new(65, 200) })
		I[3] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[4] = new("Frame", I[1], "Gold Coins", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1000, Size = UDim2.fromOffset(0, 40) })
			I[5] = new("ImageLabel", I[4], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.9) })
				I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint")
			I[7] = new("TextLabel", I[4], "Amount", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, LineHeight = 0.9, Size = UDim2.fromScale(0, 0.8), Text = "999", TextColor3 = Color3.fromRGB(255, 252, 219), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 2 })
				I[8] = new("UIStroke", I[7], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
			I[9] = new("UIListLayout", I[4], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[10] = new("Frame", I[1], "Platinum Bars", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromOffset(0, 40), Visible = false })
			I[11] = new("ImageLabel", I[10], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.9) })
				I[12] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint")
			I[13] = new("TextLabel", I[10], "Amount", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, LineHeight = 0.9, Size = UDim2.fromScale(0, 0.8), Text = "9", TextColor3 = Color3.fromRGB(213, 255, 247), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 2 })
				I[14] = new("UIStroke", I[13], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
			I[15] = new("UIListLayout", I[10], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[16] = new("Frame", I[1], "Platinum Coins", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 10, Size = UDim2.fromOffset(0, 40), Visible = false })
			I[17] = new("ImageLabel", I[16], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.9) })
				I[18] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint")
			I[19] = new("TextLabel", I[16], "Amount", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, LineHeight = 0.9, Size = UDim2.fromScale(0, 0.8), Text = "99", TextColor3 = Color3.fromRGB(247, 255, 254), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 2 })
				I[20] = new("UIStroke", I[19], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
			I[21] = new("UIListLayout", I[16], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[22] = new("Frame", I[1], "Gold Bars", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 100, Size = UDim2.fromOffset(0, 40) })
			I[23] = new("ImageLabel", I[22], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.9) })
				I[24] = new("UIAspectRatioConstraint", I[23], "UIAspectRatioConstraint")
			I[25] = new("TextLabel", I[22], "Amount", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, LineHeight = 0.9, Size = UDim2.fromScale(0, 0.8), Text = "999", TextColor3 = Color3.fromRGB(255, 248, 155), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 2 })
				I[26] = new("UIStroke", I[25], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
			I[27] = new("UIListLayout", I[22], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[28] = new("Frame", I[1], "Diamonds", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 100, Size = UDim2.fromOffset(0, 40) })
			I[29] = new("ImageLabel", I[28], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.9) })
				I[30] = new("UIAspectRatioConstraint", I[29], "UIAspectRatioConstraint")
			I[31] = new("TextLabel", I[28], "Amount", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, LineHeight = 0.9, Size = UDim2.fromScale(0, 0.8), Text = "999", TextColor3 = Color3.fromRGB(129, 253, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 2 })
				I[32] = new("UIStroke", I[31], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
			I[33] = new("UIListLayout", I[28], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
	return I[1]
end

return build
