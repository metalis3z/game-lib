-- Generated from ui/ReplicatedStorage/Assets/UI/Gifting/Frame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://118094190966237"), ImageTransparency = 1, Position = UDim2.fromScale(-0.3910533, 0.1720001), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.3910532, 0.828) })
		I[2] = new("Frame", I[1], "Holder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("Frame", I[2], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5000001, 0.7231652), Size = UDim2.fromScale(1.0000008, 0.2277167), ZIndex = 100 })
				I[4] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[5] = new("ImageButton", I[3], "Accept", { BackgroundColor3 = Color3.fromRGB(17, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.6880384, 0.1147728), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.444, 1) })
					I[6] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(25, 115, 0), Thickness = 1.8 })
					I[7] = new("Frame", I[5], "Hover_Effect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false })
						I[8] = new("ImageLabel", I[7], "0_0", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=78700452711905"), ImageTransparency = 1, Position = UDim2.fromScale(0, 0.992551), Size = UDim2.fromScale(0.297701, 0.4190345), ZIndex = 11 })
							I[9] = new("UIAspectRatioConstraint", I[8], "UIAspectRatioConstraint")
						I[10] = new("ImageLabel", I[7], "0_1", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=99240183652324"), ImageTransparency = 1, Position = UDim2.fromScale(0, 0.416004), Size = UDim2.fromScale(0.297701, 0.4190345), ZIndex = 11 })
							I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint")
						I[12] = new("ImageLabel", I[7], "1_0", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=90260459849924"), ImageTransparency = 1, Position = UDim2.fromScale(0.9, 0.992551), Size = UDim2.fromScale(0.297701, 0.4190345), ZIndex = 11 })
							I[13] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint")
						I[14] = new("ImageLabel", I[7], "1_1", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=116303632731499"), ImageTransparency = 1, Position = UDim2.fromScale(0.9, 0.416004), Size = UDim2.fromScale(0.297701, 0.4190345), ZIndex = 11 })
							I[15] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint")
					I[16] = new("TextLabel", I[5], "Description", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = -1, Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0.9, 0.75), Text = "Accept", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 11 })
						I[17] = new("UIPadding", I[16], "UIPadding", { PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0) })
						I[18] = new("UIStroke", I[16], "UIStroke", { Color = Color3.fromRGB(0, 85, 0), Thickness = 2 })
					I[19] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.4, 0), BottomRightRadius = UDim.new(0.4, 0), TopLeftRadius = UDim.new(0.4, 0), TopRightRadius = UDim.new(0.4, 0) })
				I[20] = new("ImageButton", I[3], "Decline", { BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.6880384, 0.1147728), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.444, 1) })
					I[21] = new("Frame", I[20], "Hover_Effect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false })
						I[22] = new("ImageLabel", I[21], "0_0", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=78700452711905"), ImageTransparency = 1, Position = UDim2.fromScale(0, 0.992551), Size = UDim2.fromScale(0.297701, 0.4190345), ZIndex = 11 })
							I[23] = new("UIAspectRatioConstraint", I[22], "UIAspectRatioConstraint")
						I[24] = new("ImageLabel", I[21], "0_1", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=99240183652324"), ImageTransparency = 1, Position = UDim2.fromScale(0, 0.416004), Size = UDim2.fromScale(0.297701, 0.4190345), ZIndex = 11 })
							I[25] = new("UIAspectRatioConstraint", I[24], "UIAspectRatioConstraint")
						I[26] = new("ImageLabel", I[21], "1_0", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=90260459849924"), ImageTransparency = 1, Position = UDim2.fromScale(0.9, 0.992551), Size = UDim2.fromScale(0.297701, 0.4190345), ZIndex = 11 })
							I[27] = new("UIAspectRatioConstraint", I[26], "UIAspectRatioConstraint")
						I[28] = new("ImageLabel", I[21], "1_1", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=116303632731499"), ImageTransparency = 1, Position = UDim2.fromScale(0.9, 0.416004), Size = UDim2.fromScale(0.297701, 0.4190345), ZIndex = 11 })
							I[29] = new("UIAspectRatioConstraint", I[28], "UIAspectRatioConstraint")
					I[30] = new("TextLabel", I[20], "Description", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = -1, Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0.9, 0.75), Text = "Decline", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 11 })
						I[31] = new("UIPadding", I[30], "UIPadding", { PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0) })
						I[32] = new("UIStroke", I[30], "UIStroke", { Color = Color3.fromRGB(80, 0, 0), Thickness = 2 })
					I[33] = new("UIStroke", I[20], "UIStroke", { Color = Color3.fromRGB(115, 0, 0), Thickness = 1.8 })
					I[34] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(0.4, 0), BottomRightRadius = UDim.new(0.4, 0), TopLeftRadius = UDim.new(0.4, 0), TopRightRadius = UDim.new(0.4, 0) })
			I[35] = new("Frame", I[2], "Notification_UI", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -3, Position = UDim2.fromScale(0.5, 0.125), Size = UDim2.fromScale(1, 0.25), ZIndex = 100 })
				I[36] = new("TextLabel", I[35], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.85), RichText = true, Size = UDim2.fromScale(0.969, 0.7), Text = "Gift from @sat_omr", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
					I[37] = new("UIStroke", I[36], "UIStroke", { Thickness = 1.5 })
				I[38] = new("UIScale", I[35], "UIScale")
			I[39] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.4999997, 0.4589771), RichText = true, Size = UDim2.fromScale(0.946, 0.2), Text = "150.0kg Coconut", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 50 })
				I[40] = new("UIStroke", I[39], "UIStroke", { Color = Color3.fromRGB(34, 34, 34), Thickness = 2 })
			I[41] = new("ImageLabel", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://118094190966237"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
