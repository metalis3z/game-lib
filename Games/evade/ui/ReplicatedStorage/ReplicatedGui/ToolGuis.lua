-- Generated from ui/ReplicatedStorage/ReplicatedGui/ToolGuis.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ToolGuis", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ScreenGui", I[1], "Fishing", { Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
			I[3] = new("Sound", I[2], "Click", { RollOffMode = Enum.RollOffMode.InverseTapered })
			I[4] = new("Frame", I[2], "Fillbar", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 1, -116), Size = UDim2.fromScale(0.45, 0.045), Visible = false })
				I[5] = new("Frame", I[4], "Fill", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(19, 204, 255), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0, 1) })
					I[6] = new("UICorner", I[5], "UICorner")
					I[7] = new("UIStroke", I[5], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(36, 90, 121), LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 1.5 })
					I[8] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(36, 90, 121), LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 1.5 })
					I[9] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(117, 200, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(52, 150, 255)) }), Rotation = 90 })
				I[10] = new("Frame", I[4], "Mover", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.135, 1.25), ZIndex = 10 })
					I[11] = new("UICorner", I[10], "UICorner")
					I[12] = new("UIGradient", I[10], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 124, 202)), ColorSequenceKeypoint.new(1, Color3.fromRGB(41, 174, 201)) }), Rotation = -54 })
					I[13] = new("ImageLabel", I[10], "Fish", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://120061557855930"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.75, 0.75) })
					I[14] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(22, 101, 138) })
				I[15] = new("UICorner", I[4], "UICorner")
				I[16] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", { AspectRatio = 16 })
				I[17] = new("TextLabel", I[4], "TextLabel", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, -0.44), Size = UDim2.fromScale(0.568, 0.75), Text = "Click Anywhere! (013)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[18] = new("UIStroke", I[17], "UIStroke", { Color = Color3.fromRGB(15, 56, 78), Thickness = 1.5 })
					I[19] = new("ImageLabel", I[17], "Vector", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://111355707180857"), Position = UDim2.fromScale(0.1, 0.4), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.5, 1.5), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[20] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), LineJoinMode = Enum.LineJoinMode.Miter })
				I[21] = new("Frame", I[4], "Dividers", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
					I[22] = new("UIListLayout", I[21], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
					I[23] = new("Frame", I[21], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(0, 2, 1, 0) })
					I[24] = new("Frame", I[21], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(0, 2, 1, 0) })
					I[25] = new("Frame", I[21], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(0, 2, 1, 0) })
					I[26] = new("Frame", I[21], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(0, 2, 1, 0) })
					I[27] = new("Frame", I[21], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(0, 2, 1, 0) })
			I[28] = new("BillboardGui", I[2], "CastBar", { Active = true, AlwaysOnTop = true, Enabled = false, LightInfluence = 1, MaxDistance = math.huge, ResetOnSpawn = false, Size = UDim2.fromScale(8, 4), StudsOffset = Vector3.new(3.5, 0, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
				I[29] = new("ImageLabel", I[28], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
					I[30] = new("TextLabel", I[29], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(5.5, 0.1), Size = UDim2.fromScale(8, 0.14), Text = "CHARGE YOUR CAST!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[31] = new("UIStroke", I[30], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
					I[32] = new("UIAspectRatioConstraint", I[29], "UIAspectRatioConstraint", { AspectRatio = 0.182 })
					I[33] = new("Frame", I[29], "Bar", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.75, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.51, 1), Size = UDim2.fromScale(0.6, 0.984) })
						I[34] = new("Frame", I[33], "Fill", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(0.95, 0.5), ZIndex = 5 })
							I[35] = new("UIGradient", I[34], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 175, 16)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 221, 36)) }) })
						I[36] = new("Frame", I[33], "Dividers", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.04, 1), ZIndex = 5 })
							I[37] = new("Frame", I[36], "Frame", { BackgroundColor3 = Color3.fromRGB(21, 19, 15), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.01) })
							I[38] = new("Frame", I[36], "Frame", { BackgroundColor3 = Color3.fromRGB(21, 19, 15), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.01) })
							I[39] = new("Frame", I[36], "Frame", { BackgroundColor3 = Color3.fromRGB(21, 19, 15), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.01) })
							I[40] = new("UIListLayout", I[36], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly })
						I[41] = new("ImageLabel", I[33], "TopGrad", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://72273287880831"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(3.5, 1.03), ZIndex = 2 })
							I[42] = new("UIGradient", I[41], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 175, 16)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 221, 36)) }) })
						I[43] = new("Frame", I[33], "TopDivider", { BackgroundColor3 = Color3.fromRGB(21, 19, 15), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 0.01), ZIndex = 6 })
						I[44] = new("UIStroke", I[33], "UIStroke", { BorderOffset = UDim.new(0, -1) })
					I[45] = new("TextLabel", I[29], "Luck", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(5.5, 0.25), Size = UDim2.fromScale(8, 0.14), Text = "LUCK: 1x", TextColor3 = Color3.fromRGB(13, 255, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[46] = new("UIStroke", I[45], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
	return I[1]
end

return build
