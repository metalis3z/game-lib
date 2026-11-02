-- Generated from ui/ReplicatedStorage/Assets/UI/FRAMEWORK/InfoOverlay/Blocks/BrainrotData.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "BrainrotData", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 400, Size = UDim2.new(1, 0, 0, 38) })
		I[2] = new("Configuration", I[1], "settings", nil, { ["boundsX"] = Vector2.new(65, 175) })
		I[3] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[4] = new("ImageLabel", I[1], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2593221, 1.0000001) })
			I[5] = new("ImageLabel", I[4], "RarityBg", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://109779235221479"), Position = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.2, 1.2), Visible = false })
			I[6] = new("TextLabel", I[4], "Quantity", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.7970006, 0.8373817), RichText = true, Size = UDim2.fromScale(1, 0.5), Text = "x2", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextWrapped = true, Visible = false })
				I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 1.2217592 }, { ["oldp_Thickness"] = 1.4 })
		I[8] = new("Frame", I[1], "Boosts", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5601693, 0.5000001), Size = UDim2.fromScale(0.720339, 1.0000001) })
			I[9] = new("UIListLayout", I[8], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[10] = new("Frame", I[8], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5601693, 0.5000001), Size = UDim2.fromScale(1, 0.5), Visible = false })
				I[11] = new("TextLabel", I[10], "boost", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5601693, 0.5000001), RichText = true, Size = UDim2.fromScale(1, 1), Text = "+100%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextWrapped = true })
					I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 1.4 })
				I[13] = new("UIListLayout", I[10], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[14] = new("ImageLabel", I[10], "icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.5, 1.5), Visible = false })
					I[15] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint")
					I[16] = new("ImageLabel", I[14], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
					I[17] = new("ImageLabel", I[14], "Shine", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://132632159010020"), ImageTransparency = 0.01, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.5, 1.5) })
	return I[1]
end

return build
