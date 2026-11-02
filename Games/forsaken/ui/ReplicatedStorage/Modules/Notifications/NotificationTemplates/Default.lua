-- Generated from ui/ReplicatedStorage/Modules/Notifications/NotificationTemplates/Default.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Default", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0.2, -10) })
		I[2] = new("Frame", I[1], "Main", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[3] = new("ImageLabel", I[2], "Background", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://132359932099303"), Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 0 })
			I[4] = new("Frame", I[2], "Card", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(42, 42, 42), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.05, 0.5), Size = UDim2.fromScale(0.325, 1.4) })
				I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", { AspectRatio = 0.75 })
				I[6] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Rotation = 90 })
				I[7] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
				I[8] = new("ImageLabel", I[4], "CharacterRender", { BackgroundColor3 = Color3.fromRGB(20, 20, 20), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://18831151594"), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1) })
					I[9] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(0, 34), BottomRightRadius = UDim.new(0, 34), TopLeftRadius = UDim.new(0, 34), TopRightRadius = UDim.new(0, 34) })
				I[10] = new("ImageLabel", I[4], "Outline", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://122785356471162"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.1, 1.0999999), ZIndex = 2 })
			I[11] = new("Frame", I[2], "Titles", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.485), Size = UDim2.fromScale(0.8, 0.55) })
				I[12] = new("UIListLayout", I[11], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(-0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, VerticalFlex = Enum.UIFlexAlignment.Fill })
				I[13] = new("TextLabel", I[11], "Secondary", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, LineHeight = 1.25, Position = UDim2.fromScale(0.5, 0.7), RichText = true, Size = UDim2.fromScale(1, 0.25), Text = "Not My First Time", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 30, TextTransparency = 0.25, TextWrapped = true, ZIndex = 2 })
				I[14] = new("TextLabel", I[11], "Primary", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LineHeight = 1.25, Position = UDim2.fromScale(0.5, 0.4), RichText = true, Size = UDim2.fromScale(1, 0.5), Text = "Achievement Unlocked!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 30, TextWrapped = true, ZIndex = 2 })
	return I[1]
end

return build
