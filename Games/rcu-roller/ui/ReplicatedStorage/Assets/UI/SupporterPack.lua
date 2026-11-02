-- Generated from ui/ReplicatedStorage/Assets/UI/SupporterPack.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "SupporterPack", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.11, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 650 })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 600 })
			I[3] = new("Frame", I[2], "RewardContainer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9333333, 0.9333333), ZIndex = 601 })
				I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0.12, 0), BottomRightRadius = UDim.new(0.12, 0), TopLeftRadius = UDim.new(0.12, 0), TopRightRadius = UDim.new(0.12, 0) })
				I[5] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), Thickness = 5 })
				I[6] = new("ImageLabel", I[3], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://89496877399666"), ImageTransparency = 0.7, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.5, 1.5), SliceCenter = Rect.new(160, 160, 864, 864), ZIndex = 600 })
			I[7] = new("ImageLabel", I[2], "Arrow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112543155993784"), Position = UDim2.fromScale(1.3298556, 0.5), Size = UDim2.fromScale(0.4597111, 0.4597111), ZIndex = 680 })
			I[8] = new("Frame", I[2], "State", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.502, 1.261), Size = UDim2.fromScale(0.93, 0.368) })
				I[9] = new("Frame", I[8], "Claim", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 950 })
					I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
					I[11] = new("Frame", I[9], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(17, 72, 6), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 940 })
						I[12] = new("UIStroke", I[11], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
						I[13] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
					I[14] = new("TextLabel", I[9], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.8), Text = "FREE!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 960 })
						I[15] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
					I[16] = new("UIStroke", I[9], "UIStroke", { Color = Color3.fromRGB(17, 72, 6), Thickness = 5 })
					I[17] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(161, 254, 55)), ColorSequenceKeypoint.new(1, Color3.fromRGB(34, 216, 14)) }), Rotation = 90 })
				I[18] = new("Frame", I[8], "Robux", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 950 })
					I[19] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
					I[20] = new("Frame", I[18], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(86, 86, 86), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 940 })
						I[21] = new("UIStroke", I[20], "UIStroke", { Color = Color3.fromRGB(86, 86, 86), Thickness = 5 })
						I[22] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
					I[23] = new("Frame", I[18], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5000001), Size = UDim2.fromScale(1.15, 1.1156485), ZIndex = 960 })
						I[24] = new("UIListLayout", I[23], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
						I[25] = new("TextLabel", I[23], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.6275804, 0.4158578), Size = UDim2.fromScale(0.1, 0.6405381), Text = "50", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 40, ZIndex = 960 })
							I[26] = new("UIStroke", I[25], "UIStroke", { Color = Color3.fromRGB(86, 86, 86), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
						I[27] = new("Frame", I[23], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1247808, 0.1601009), Size = UDim2.fromScale(0.2484105, 0.6797991), ZIndex = 960 })
							I[28] = new("TextLabel", I[27], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(1.4, 1.4), Text = "", TextColor3 = Color3.fromRGB(86, 86, 86), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 960 })
					I[29] = new("UIStroke", I[18], "UIStroke", { Color = Color3.fromRGB(86, 86, 86), Thickness = 5 })
					I[30] = new("UIGradient", I[18], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(245, 245, 245)), ColorSequenceKeypoint.new(1, Color3.fromRGB(181, 181, 181)) }), Rotation = 90 })
				I[31] = new("TextButton", I[8], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 1000 })
	return I[1]
end

return build
