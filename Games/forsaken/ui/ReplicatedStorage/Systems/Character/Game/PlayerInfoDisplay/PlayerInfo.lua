-- Generated from ui/ReplicatedStorage/Systems/Character/Game/PlayerInfoDisplay/PlayerInfo.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "PlayerInfo", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://18831294483"), ImageTransparency = 0.33, Position = UDim2.new(0, 20, 1, -20), Size = UDim2.fromScale(0.25, 0.125) })
		I[2] = new("UISizeConstraint", I[1], "UISizeConstraint", { MinSize = Vector2.new(200, 1) })
		I[3] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 4.5, AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
		I[4] = new("Frame", I[1], "Bars", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.25, 0.5), Size = UDim2.fromScale(0.675, 0.85) })
			I[5] = new("Frame", I[4], "Stamina", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.5) })
				I[6] = new("ImageLabel", I[5], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://12443244342"), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.2, 1.25) })
					I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint")
					I[8] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(168, 168, 168)) }), Rotation = 90 })
				I[9] = new("ImageLabel", I[5], "Bar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(145, 145, 145), ImageContent = Content.fromUri("rbxassetid://18818548751"), Position = UDim2.fromScale(0.2, 0.5), Size = UDim2.new(0.55, 0, 0.1, 4) })
					I[10] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(168, 168, 168)) }), Rotation = 90 })
					I[11] = new("Frame", I[9], "Clipping", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(1, 1) })
						I[12] = new("ImageLabel", I[11], "Top", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://18818548751"), Size = UDim2.fromScale(1, 1) })
							I[13] = new("UIGradient", I[12], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(168, 168, 168)) }), Rotation = 90 })
				I[14] = new("TextLabel", I[5], "Amount", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0.5), Size = UDim2.new(0.225, 0, 0.3, 14), Text = "N/A", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[15] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(168, 168, 168)) }), Rotation = 90 })
			I[16] = new("Frame", I[4], "Health", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.5) })
				I[17] = new("ImageLabel", I[16], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 111, 111), ImageContent = Content.fromUri("rbxassetid://16181404460"), Position = UDim2.fromScale(0.025, 0.55), Size = UDim2.fromScale(0.2, 1) })
					I[18] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint")
					I[19] = new("UIGradient", I[17], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(168, 168, 168)) }), Rotation = 90 })
				I[20] = new("ImageLabel", I[16], "Bar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(145, 63, 63), ImageContent = Content.fromUri("rbxassetid://18818548751"), Position = UDim2.fromScale(0.2, 0.5), Size = UDim2.new(0.55, 0, 0.1, 4) })
					I[21] = new("UIGradient", I[20], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(168, 168, 168)) }), Rotation = 90 })
					I[22] = new("Frame", I[20], "Clipping", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(1, 1) })
						I[23] = new("ImageLabel", I[22], "Top", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 111, 111), ImageContent = Content.fromUri("rbxassetid://18818548751"), Size = UDim2.fromScale(1, 1) })
							I[24] = new("UIGradient", I[23], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(168, 168, 168)) }), Rotation = 90 })
				I[25] = new("TextLabel", I[16], "Amount", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0.5), Size = UDim2.new(0.225, 0, 0.3, 14), Text = "N/A", TextColor3 = Color3.fromRGB(255, 111, 111), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[26] = new("UIGradient", I[25], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(168, 168, 168)) }), Rotation = 90 })
				I[27] = new("TextLabel", I[16], "Overheal", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.9, 0, -0.05, -4), Size = UDim2.new(0.5, 0, 0.225, 14), Text = "", TextColor3 = Color3.fromRGB(155, 155, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
					I[28] = new("UIGradient", I[27], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(168, 168, 168)) }), Rotation = 90 })
				I[29] = new("ImageLabel", I[16], "HardDamage", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(145, 0, 0), ImageContent = Content.fromUri("rbxassetid://18818548751"), ImageTransparency = 1, Position = UDim2.fromScale(0.2, 0.5), Size = UDim2.new(0.55, 0, 0.1, 4), ZIndex = 2 })
					I[30] = new("Frame", I[29], "Clipping", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(1, 1) })
						I[31] = new("ImageLabel", I[30], "Top", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(31, 0, 1), ImageContent = Content.fromUri("rbxassetid://87577631610763"), Position = UDim2.fromScale(1.0000001, 0), Size = UDim2.fromScale(0, 1) })
		I[32] = new("Frame", I[1], "CurrentSurvivors", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, -0.075), Size = UDim2.fromScale(1, 0.75) })
			I[33] = new("UIGridLayout", I[32], "UIGridLayout", { CellPadding = UDim2.fromScale(0.01, 0.25), CellSize = UDim2.fromScale(0.2, 1), FillDirectionMaxCells = 4, SortOrder = Enum.SortOrder.LayoutOrder, StartCorner = Enum.StartCorner.BottomLeft, VerticalAlignment = Enum.VerticalAlignment.Bottom })
		I[34] = new("ImageLabel", I[1], "PlayerIcon", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://15317582625"), Position = UDim2.fromScale(0.0655908, 0.1493615), Size = UDim2.fromScale(0.1657675, 0.7207947) })
			I[35] = new("UICorner", I[34], "UICorner", { BottomLeftRadius = UDim.new(100, 100), BottomRightRadius = UDim.new(100, 100), TopLeftRadius = UDim.new(100, 100), TopRightRadius = UDim.new(100, 100) })
			I[36] = new("UIGradient", I[34], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(166, 166, 166)) }), Rotation = 90 })
			I[37] = new("ImageLabel", I[34], "Outline", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://18818132015"), Position = UDim2.fromScale(0.4843318, 0.5000013), Size = UDim2.fromScale(1.1315541, 1.15), ZIndex = 2 })
				I[38] = new("UIGradient", I[37], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(166, 166, 166)) }), Rotation = 90 })
			I[39] = new("UIAspectRatioConstraint", I[34], "UIAspectRatioConstraint")
	return I[1]
end

return build
