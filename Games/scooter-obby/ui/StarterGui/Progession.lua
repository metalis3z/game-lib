-- Generated from ui/StarterGui/Progession.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Progession", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[3] = new("Frame", I[2], "ColorContainer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.2617861, 0.0135803), Size = UDim2.fromScale(0.4748413, 0.047381) })
				I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
				I[5] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder })
				I[6] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 214, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 157, 255)) }), Rotation = 90 })
				I[7] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(12, 12, 12), Thickness = 3 })
			I[8] = new("Frame", I[2], "PlayerContainer", { BackgroundColor3 = Color3.fromRGB(102, 102, 102), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.261786, 0.0135803), Size = UDim2.fromScale(0.4748413, 0.0387464) })
				I[9] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
				I[10] = new("ImageLabel", I[8], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://15639219520"), Position = UDim2.fromScale(1.0181515, 0.6083537), Size = UDim2.fromScale(0.0690804, 1.6674882), ZIndex = 2 })
					I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint")
		I[12] = new("NumberValue", I[1], "maxSize")
		I[13] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4085028, 0.0609612), Size = UDim2.fromScale(0.1829945, 0.0526175) })
			I[14] = new("Frame", I[13], "Progress", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 115, 172), BackgroundTransparency = 1, Position = UDim2.fromScale(-0.0004811, 0.5265796), Size = UDim2.fromScale(0.5821032, 1.0593256), ZIndex = 3 })
				I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
				I[16] = new("TextButton", I[14], "LabelButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 0 })
				I[17] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint", { AspectRatio = 4.2948041 })
				I[18] = new("Frame", I[14], "Top", { BackgroundColor3 = Color3.fromRGB(53, 53, 53), Position = UDim2.fromScale(-0.1156841, 0.2732621), Size = UDim2.fromScale(1.9312568, 0.9000002) })
					I[19] = new("Frame", I[18], "ImageHolder", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(-0.125, 0.5), Size = UDim2.fromScale(0.4014772, 1.85), ZIndex = 3 })
						I[20] = new("UIAspectRatioConstraint", I[19], "UIAspectRatioConstraint", { AspectRatio = 2 })
						I[21] = new("ImageLabel", I[19], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://15639219520"), Position = UDim2.fromScale(2.8732581, 0.4996186), Size = UDim2.fromScale(0.3480658, 0.6961312), ZIndex = 2 })
							I[22] = new("UIAspectRatioConstraint", I[21], "UIAspectRatioConstraint")
					I[23] = new("TextLabel", I[18], "Label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1501238, 0.5), Size = UDim2.fromScale(0.7, 0.9), Text = "PROGRESS: 41%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
						I[24] = new("UIStroke", I[23], "UIStroke", { Thickness = 3 })
					I[25] = new("UIStroke", I[18], "UIStroke", { Thickness = 2 })
					I[26] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
					I[27] = new("Frame", I[18], "ProgressBar", { BackgroundColor3 = Color3.fromRGB(84, 255, 113), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0, 1) })
	return I[1]
end

return build
