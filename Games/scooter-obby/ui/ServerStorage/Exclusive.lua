-- Generated from ui/ServerStorage/Exclusive.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Exclusive", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.15), Size = UDim2.fromScale(1, 0.3) })
		I[2] = new("Frame", I[1], "Inside", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9) })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 3.5 })
				I[4] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.0588235, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(0.2318339, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.4083045, Color3.fromRGB(0, 255, 85)), ColorSequenceKeypoint.new(0.5294118, Color3.fromRGB(0, 221, 255)), ColorSequenceKeypoint.new(0.6903114, Color3.fromRGB(0, 34, 255)), ColorSequenceKeypoint.new(0.7958478, Color3.fromRGB(170, 0, 255)), ColorSequenceKeypoint.new(0.8927336, Color3.fromRGB(225, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }), Rotation = -113 })
			I[5] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
			I[6] = new("Frame", I[2], "ImageHolder", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.05, 0.5), Size = UDim2.fromScale(0.25, 0.9), ZIndex = 2 })
				I[7] = new("Frame", I[6], "ItemFrame", { BackgroundColor3 = Color3.fromRGB(118, 118, 118), BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.fromScale(1, 1) })
					I[8] = new("Frame", I[7], "Back", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
						I[9] = new("Frame", I[8], "Top", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.85, 0.85), ZIndex = 2 })
							I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
							I[11] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint")
							I[12] = new("UIStroke", I[9], "UIStroke", { Thickness = 2.5 })
							I[13] = new("ImageLabel", I[9], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://15452136674"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.95, 0.95), ZIndex = 2 })
								I[14] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
							I[15] = new("Frame", I[9], "Hover", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.9, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3 })
								I[16] = new("UIGradient", I[15], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(211, 211, 211)), ColorSequenceKeypoint.new(1, Color3.fromRGB(211, 211, 211)) }), Rotation = 90 })
							I[17] = new("ImageLabel", I[9], "Border", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=9845885467"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
							I[18] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.0588235, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(0.2318339, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.4083045, Color3.fromRGB(0, 255, 85)), ColorSequenceKeypoint.new(0.5294118, Color3.fromRGB(0, 221, 255)), ColorSequenceKeypoint.new(0.6903114, Color3.fromRGB(0, 34, 255)), ColorSequenceKeypoint.new(0.7958478, Color3.fromRGB(170, 0, 255)), ColorSequenceKeypoint.new(0.8927336, Color3.fromRGB(225, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }), Rotation = 43 })
			I[19] = new("TextLabel", I[2], "NameLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6, 0.05), Size = UDim2.fromScale(0.35, 0.45), Text = "Giga Bundle", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[20] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(220, 73, 220), Thickness = 1.75 })
			I[21] = new("Frame", I[2], "Buy", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.775, 0.7), Size = UDim2.fromScale(0.35, 0.4), ZIndex = 2 })
				I[22] = new("Frame", I[21], "Back", { BackgroundColor3 = Color3.fromRGB(54, 175, 35), Size = UDim2.fromScale(1, 1) })
					I[23] = new("UICorner", I[22], "UICorner")
					I[24] = new("Frame", I[22], "Top", { BackgroundColor3 = Color3.fromRGB(79, 255, 52), Size = UDim2.fromScale(1, 0.9) })
						I[25] = new("UICorner", I[24], "UICorner")
						I[26] = new("UIGradient", I[24], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.495, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.505, Color3.fromRGB(225, 225, 225)), ColorSequenceKeypoint.new(1, Color3.fromRGB(225, 225, 225)) }), Offset = Vector2.new(0, 0.1), Rotation = 75 })
						I[27] = new("TextLabel", I[24], "Label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "875", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
							I[28] = new("UIStroke", I[27], "UIStroke", { Color = Color3.fromRGB(54, 175, 35), Thickness = 2 })
						I[29] = new("Frame", I[24], "Highlight", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
							I[30] = new("UICorner", I[29], "UICorner")
						I[31] = new("Frame", I[24], "ImageHolder", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.3, 0.7) })
							I[32] = new("ImageLabel", I[31], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=10115849673"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
								I[33] = new("UIAspectRatioConstraint", I[32], "UIAspectRatioConstraint")
						I[34] = new("UIStroke", I[24], "UIStroke", { Color = Color3.fromRGB(57, 171, 0) })
					I[35] = new("TextButton", I[22], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 2 })
				I[36] = new("Sound", I[21], "ClickSound")
			I[37] = new("ImageLabel", I[2], "Hexagons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=10212808150"), ImageTransparency = 0.8, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(6, 6), TileSize = UDim2.fromScale(0.25, 0.25) })
				I[38] = new("UIAspectRatioConstraint", I[37], "UIAspectRatioConstraint")
				I[39] = new("UICorner", I[37], "UICorner", { BottomLeftRadius = UDim.new(555, 0), BottomRightRadius = UDim.new(555, 0), TopLeftRadius = UDim.new(555, 0), TopRightRadius = UDim.new(555, 0) })
			I[40] = new("Frame", I[2], "ExclusiveHolder", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.315, 0.5), Size = UDim2.fromScale(0.25, 0.9), ZIndex = 2 })
				I[41] = new("ImageLabel", I[40], "ButtonImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=11322060400"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.95, 0.95), ZIndex = 2 })
					I[42] = new("UICorner", I[41], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
					I[43] = new("UIAspectRatioConstraint", I[41], "UIAspectRatioConstraint")
			I[44] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.0588235, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(0.2318339, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.4083045, Color3.fromRGB(0, 255, 85)), ColorSequenceKeypoint.new(0.5294118, Color3.fromRGB(0, 221, 255)), ColorSequenceKeypoint.new(0.6903114, Color3.fromRGB(0, 34, 255)), ColorSequenceKeypoint.new(0.7958478, Color3.fromRGB(170, 0, 255)), ColorSequenceKeypoint.new(0.8927336, Color3.fromRGB(225, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }), Rotation = 168 })
		I[45] = new("Sound", I[1], "ClickSound")
	return I[1]
end

return build
