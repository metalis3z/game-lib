-- Generated from ui/ReplicatedStorage/Parts/NameTag_new.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "NameTag_new", { Active = true, Brightness = 1.33, ExtentsOffsetWorldSpace = Vector3.new(0, 5, 0), MaxDistance = 30, Size = UDim2.fromScale(6, 3), StudsOffsetWorldSpace = Vector3.new(0, 2, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "NameTag" })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
			I[3] = new("TextLabel", I[2], "GroupRank", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = -5, Position = UDim2.fromScale(0.3, -0.1), RichText = true, Size = UDim2.fromScale(0.4, 0.2), Text = "[Developer]", TextColor3 = Color3.fromRGB(130, 174, 255), TextDirection = Enum.TextDirection.LeftToRight, TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[4] = new("TextLabel", I[2], "UserName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.1, 0.35), RichText = true, Size = UDim2.fromScale(0.8, 0.3), Text = "@Scribels", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[5] = new("TextLabel", I[2], "DisplayName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), LayoutOrder = 1, Position = UDim2.fromScale(0.1, 0.15), RichText = true, Size = UDim2.fromScale(0.8, 0.18), Text = "NotScribels", TextColor3 = Color3.fromRGB(114, 117, 130), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[6] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 6, Position = UDim2.fromScale(0.1, 0.7), RichText = true, Size = UDim2.fromScale(0.8, 0.3), Text = "[ Item Tracker ]", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
				I[7] = new("UIGradient", I[6], "Bronze", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(218, 171, 151)), ColorSequenceKeypoint.new(0.2262522, Color3.fromRGB(220, 175, 151)), ColorSequenceKeypoint.new(0.3609672, Color3.fromRGB(190, 128, 122)), ColorSequenceKeypoint.new(0.4956822, Color3.fromRGB(231, 160, 106)), ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 218, 165)) }), Enabled = false, Rotation = -90 })
				I[8] = new("UIGradient", I[6], "Silver", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(168, 195, 237)), ColorSequenceKeypoint.new(0.2262522, Color3.fromRGB(168, 186, 239)), ColorSequenceKeypoint.new(0.3609672, Color3.fromRGB(131, 202, 209)), ColorSequenceKeypoint.new(0.4956822, Color3.fromRGB(112, 132, 250)), ColorSequenceKeypoint.new(1, Color3.fromRGB(213, 184, 255)) }), Rotation = -90 })
				I[9] = new("UIStroke", I[6], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
				I[10] = new("UIGradient", I[6], "Iridescent2", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(175, 207, 241)), ColorSequenceKeypoint.new(0.266436, Color3.fromRGB(225, 198, 241)), ColorSequenceKeypoint.new(0.3633218, Color3.fromRGB(182, 241, 215)), ColorSequenceKeypoint.new(0.449827, Color3.fromRGB(233, 231, 192)), ColorSequenceKeypoint.new(0.5207613, Color3.fromRGB(223, 181, 214)), ColorSequenceKeypoint.new(0.633218, Color3.fromRGB(155, 167, 219)), ColorSequenceKeypoint.new(0.7249135, Color3.fromRGB(198, 173, 153)), ColorSequenceKeypoint.new(0.8806229, Color3.fromRGB(194, 237, 200)), ColorSequenceKeypoint.new(1, Color3.fromRGB(42, 50, 79)) }), Enabled = false, Rotation = 90 })
				I[11] = new("UIGradient", I[6], "Gold", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(237, 223, 119)), ColorSequenceKeypoint.new(0.2262522, Color3.fromRGB(239, 229, 118)), ColorSequenceKeypoint.new(0.3609672, Color3.fromRGB(209, 177, 88)), ColorSequenceKeypoint.new(0.4956822, Color3.fromRGB(250, 245, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(162, 255, 131)) }), Enabled = false, Rotation = -90 })
				I[12] = new("Folder", I[6], "DEPRECATED")
					I[13] = new("UIGradient", I[12], "Gold", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(229, 189, 108)), ColorSequenceKeypoint.new(0.2024222, Color3.fromRGB(237, 226, 167)), ColorSequenceKeypoint.new(0.2612457, Color3.fromRGB(227, 193, 74)), ColorSequenceKeypoint.new(0.4186851, Color3.fromRGB(241, 237, 188)), ColorSequenceKeypoint.new(0.532872, Color3.fromRGB(218, 176, 71)), ColorSequenceKeypoint.new(0.6557094, Color3.fromRGB(240, 194, 78)), ColorSequenceKeypoint.new(0.8027682, Color3.fromRGB(154, 119, 69)), ColorSequenceKeypoint.new(1, Color3.fromRGB(71, 70, 36)) }), Enabled = false, Rotation = 90 })
					I[14] = new("UIGradient", I[12], "Bronze", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(189, 152, 100)), ColorSequenceKeypoint.new(0.4896194, Color3.fromRGB(171, 118, 71)), ColorSequenceKeypoint.new(1, Color3.fromRGB(149, 72, 57)) }), Enabled = false, Rotation = 90 })
					I[15] = new("UIGradient", I[12], "Silver", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(199, 199, 199)), ColorSequenceKeypoint.new(0.4411765, Color3.fromRGB(202, 202, 202)), ColorSequenceKeypoint.new(0.5934256, Color3.fromRGB(120, 120, 120)), ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 70, 70)) }), Enabled = false, Rotation = 90 })
				I[16] = new("TextLabel", I[6], "Shine", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), RichText = true, SelectionOrder = 2, Size = UDim2.fromScale(1, 1), Text = "[ Item Tracker ]", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.2, TextWrapped = true, ZIndex = 5 })
					I[17] = new("UIGradient", I[16], "UIGradient", { Offset = Vector2.new(0.8, 0), Rotation = 20, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1647184, 0), NumberSequenceKeypoint.new(0.2582359, 0), NumberSequenceKeypoint.new(0.2763018, 1), NumberSequenceKeypoint.new(0.3453773, 1), NumberSequenceKeypoint.new(0.455898, 1), NumberSequenceKeypoint.new(0.5324124, 0), NumberSequenceKeypoint.new(0.6184909, 0), NumberSequenceKeypoint.new(0.6227418, 1), NumberSequenceKeypoint.new(1, 1) }) })
					I[18] = new("Frame", I[16], "Particles", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(1, 0.5) })
						I[19] = new("ParticleEmitter", I[18], "Sparkle", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 226, 176)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 226, 176)) }), Enabled = false, Lifetime = NumberRange.new(0.5, 0.5), LightEmission = 1, LightInfluence = 1, Rate = 7, RotSpeed = NumberRange.new(100, 100), Rotation = NumberRange.new(-360, 360), Shape = Enum.ParticleEmitterShape.Cylinder, Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5006784, 0.2732241, 0.1), NumberSequenceKeypoint.new(1, 0) }), Speed = NumberRange.new(0, 0), SpreadAngle = Vector2.new(30, 360), Squash = NumberSequence.new({ NumberSequenceKeypoint.new(0, -0.0375001), NumberSequenceKeypoint.new(0.5018679, 0.0749998), NumberSequenceKeypoint.new(1, 0) }), TextureContent = Content.fromUri("rbxassetid://124495345790728"), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5047821, 0.2407932, 0.1586403), NumberSequenceKeypoint.new(1, 1) }) })
				I[20] = new("UIGradient", I[6], "Iridescent", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(217, 201, 237)), ColorSequenceKeypoint.new(0.2262522, Color3.fromRGB(162, 202, 239)), ColorSequenceKeypoint.new(0.3609672, Color3.fromRGB(201, 209, 209)), ColorSequenceKeypoint.new(0.4956822, Color3.fromRGB(229, 154, 250)), ColorSequenceKeypoint.new(0.5699482, Color3.fromRGB(254, 215, 235)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 218, 234)) }), Rotation = -90 })
				I[21] = new("UIGradient", I[6], "Normal", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(186, 186, 186)) }), Rotation = 90 })
				I[22] = new("ImageLabel", I[6], "ImageLabel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1), Visible = false })
					I[23] = new("UIAspectRatioConstraint", I[22], "UIAspectRatioConstraint")
				I[24] = new("UIGradient", I[6], "Onyx", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 54, 63)), ColorSequenceKeypoint.new(0.200692, Color3.fromRGB(53, 48, 56)), ColorSequenceKeypoint.new(0.4152249, Color3.fromRGB(88, 79, 93)), ColorSequenceKeypoint.new(0.8096886, Color3.fromRGB(42, 38, 45)), ColorSequenceKeypoint.new(1, Color3.fromRGB(43, 38, 45)) }), Enabled = false, Rotation = 90 })
			I[25] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[26] = new("Frame", I[2], "Outline", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), LayoutOrder = 5, Position = UDim2.fromScale(0.125, 0.65), Size = UDim2.fromScale(0.75, 0.025) })
				I[27] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
	return I[1]
end

return build
