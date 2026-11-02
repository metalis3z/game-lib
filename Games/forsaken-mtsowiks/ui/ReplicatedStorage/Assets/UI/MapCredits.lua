-- Generated from ui/ReplicatedStorage/Assets/UI/MapCredits.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "MapCredits", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.8500002), Size = UDim2.fromScale(0.45, 0.3) })
		I[2] = new("ImageLabel", I[1], "MapBackground", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://102874561861857"), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1) })
			I[3] = new("ImageLabel", I[2], "Bar", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://84906831667454"), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
			I[4] = new("TextLabel", I[2], "MapName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.025, 0.185), Size = UDim2.fromScale(0.5, 0.3), Text = "brandon6875935's Place", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[5] = new("Frame", I[2], "Credits", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.02, 0.5), Size = UDim2.fromScale(0.965, 0.35) })
				I[6] = new("UIListLayout", I[5], "UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, VerticalFlex = Enum.UIFlexAlignment.Fill })
				I[7] = new("Frame", I[5], "Map", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.035, 0.5), Size = UDim2.fromScale(0.965, 1) })
					I[8] = new("ImageLabel", I[7], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://100708551153406"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.05, 1) })
					I[9] = new("TextLabel", I[7], "Credits", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.055, 0), Size = UDim2.fromScale(0.945, 1), Text = "OnlyTwentyCharacters — Map Builder(s)", TextColor3 = Color3.fromRGB(145, 145, 145), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[10] = new("Frame", I[5], "Ambience", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.035, 0.5), Size = UDim2.fromScale(0.965, 1) })
					I[11] = new("ImageLabel", I[10], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://103703320386725"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.05, 1) })
					I[12] = new("TextLabel", I[10], "Credits", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.055, 0), Size = UDim2.fromScale(0.945, 1), Text = "OnlyTwentyCharacters — Ambience Composer(s)", TextColor3 = Color3.fromRGB(145, 145, 145), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[13] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 4.2800002 })
	return I[1]
end

return build
