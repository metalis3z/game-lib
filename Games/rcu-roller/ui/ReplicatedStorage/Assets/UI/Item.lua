-- Generated from ui/ReplicatedStorage/Assets/UI/Item.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Item", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.1157025, 0.5517241), ZIndex = 620 })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 630 })
			I[3] = new("TextLabel", I[2], "Amount", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.69, 0.05), Size = UDim2.fromScale(0.678966, 0.2972576), Text = "x1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 650 })
				I[4] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
			I[5] = new("TextButton", I[2], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 900 })
				I[6] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 14 })
			I[7] = new("Frame", I[2], "IconContainer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 631 })
				I[8] = new("ImageLabel", I[7], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://114894435381289"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.86, 0.86), ZIndex = 640 })
			I[9] = new("ImageLabel", I[2], "Scribble", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://100064279845321"), ImageTransparency = 0.7, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.1, 1.1), ZIndex = 630 })
				I[10] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 213, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(44, 171, 255)) }), Rotation = 60 })
			I[11] = new("Frame", I[2], "Equipped", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.9, 0.08), Size = UDim2.fromScale(0.2691077, 0.2691077), Visible = false, ZIndex = 650 })
				I[12] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[13] = new("UIStroke", I[11], "UIStroke", { Color = Color3.fromRGB(23, 66, 18), Thickness = 4 })
				I[14] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(163, 255, 64)), ColorSequenceKeypoint.new(1, Color3.fromRGB(57, 255, 70)) }), Rotation = 90 })
			I[15] = new("Frame", I[2], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 630 })
				I[16] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
				I[17] = new("UIStroke", I[15], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), Thickness = 5 })
				I[18] = new("UIGradient", I[15], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.242215, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 236, 162)) }), Rotation = 45 })
			I[19] = new("ImageLabel", I[2], "Circle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(35, 247, 19), ImageContent = Content.fromUri("rbxassetid://80170921026117"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.15, 1.15), Visible = false, ZIndex = 630 })
			I[20] = new("Frame", I[2], "State", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.93, 0.07), Size = UDim2.fromScale(0.224, 0.224), Visible = false, ZIndex = 650 })
				I[21] = new("Frame", I[20], "ON", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 660 })
					I[22] = new("UICorner", I[21], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[23] = new("UIStroke", I[21], "UIStroke", { Color = Color3.fromRGB(23, 66, 18), Thickness = 4 })
					I[24] = new("UIGradient", I[21], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(163, 255, 64)), ColorSequenceKeypoint.new(1, Color3.fromRGB(57, 255, 70)) }), Rotation = 90 })
				I[25] = new("Frame", I[20], "OFF", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 660 })
					I[26] = new("UICorner", I[25], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[27] = new("UIGradient", I[25], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 121)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 1, 5)) }), Rotation = 90 })
					I[28] = new("UIStroke", I[25], "UIStroke", { Color = Color3.fromRGB(79, 13, 43), Thickness = 4 })
	return I[1]
end

return build
