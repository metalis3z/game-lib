-- Generated from ui/ReplicatedStorage/Templates/Brainrot_UI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Brainrot_UI", { Active = true, Brightness = 1.5, ClipsDescendants = true, MaxDistance = 70, ResetOnSpawn = false, Size = UDim2.fromScale(20, 16), StudsOffset = Vector3.new(0, 15, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 1) })
			I[3] = new("TextLabel", I[2], "Rarity", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.82), Size = UDim2.fromScale(0.9, 0.077), Text = "Common", TextColor3 = Color3.fromRGB(170, 170, 170), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[4] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(7, 7, 7), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
			I[5] = new("TextLabel", I[2], "Price", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 4, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(0.9, 0.077), Text = "$0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[6] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(229, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 225, 0)) }), Rotation = 90 })
				I[7] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(7, 7, 7), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
			I[8] = new("TextLabel", I[2], "Earn", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.92), Size = UDim2.fromScale(0.9, 0.077), Text = "$47/s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[9] = new("UIStroke", I[8], "UIStroke", { Color = Color3.fromRGB(7, 7, 7), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
				I[10] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(229, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 153, 0)) }), Rotation = 90 })
			I[11] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.72), Size = UDim2.fromScale(0.9, 0.077), Text = "Tim Cheese", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[12] = new("UIStroke", I[11], "UIStroke", { Color = Color3.fromRGB(7, 7, 7), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
			I[13] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[14] = new("TextLabel", I[2], "Type", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = -1, Position = UDim2.fromScale(0.5, 0.72), Size = UDim2.fromScale(0.9, 0.077), Text = "", TextColor3 = Color3.fromRGB(0, 150, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[15] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(7, 7, 7), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
			I[16] = new("Frame", I[2], "Mutations", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.1, 0.1) })
				I[17] = new("ImageLabel", I[16], "Acid", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://118132000922504"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
					I[18] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint")
				I[19] = new("ImageLabel", I[16], "Love", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://87173349325226"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
					I[20] = new("UIAspectRatioConstraint", I[19], "UIAspectRatioConstraint")
				I[21] = new("ImageLabel", I[16], "Hacker", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://82477760525511"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
					I[22] = new("UIAspectRatioConstraint", I[21], "UIAspectRatioConstraint")
				I[23] = new("ImageLabel", I[16], "Aquatic", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://118622014178261"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
					I[24] = new("UIAspectRatioConstraint", I[23], "UIAspectRatioConstraint")
				I[25] = new("ImageLabel", I[16], "Brazil", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://87906378918340"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
					I[26] = new("UIAspectRatioConstraint", I[25], "UIAspectRatioConstraint")
				I[27] = new("ImageLabel", I[16], "Matteo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://73889988090947"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
					I[28] = new("UIAspectRatioConstraint", I[27], "UIAspectRatioConstraint")
				I[29] = new("UIListLayout", I[16], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[30] = new("ImageLabel", I[16], "Tecnologia", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://82477760525511"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
					I[31] = new("UIAspectRatioConstraint", I[30], "UIAspectRatioConstraint")
				I[32] = new("ImageLabel", I[16], "Lava", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://79054696093130"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
					I[33] = new("UIAspectRatioConstraint", I[32], "UIAspectRatioConstraint")
				I[34] = new("ImageLabel", I[16], "AuraInfinita", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://113782956243005"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
					I[35] = new("UIAspectRatioConstraint", I[34], "UIAspectRatioConstraint")
				I[36] = new("ImageLabel", I[16], "LightShow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://73142702188223"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
					I[37] = new("UIAspectRatioConstraint", I[36], "UIAspectRatioConstraint")
				I[38] = new("ImageLabel", I[16], "TacoCombinasion", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://73305070207136"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
					I[39] = new("UIAspectRatioConstraint", I[38], "UIAspectRatioConstraint")
				I[40] = new("ImageLabel", I[16], "Taco", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131727959396765"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
					I[41] = new("UIAspectRatioConstraint", I[40], "UIAspectRatioConstraint")
				I[42] = new("ImageLabel", I[16], "Stars", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://135213133507900"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
					I[43] = new("UIAspectRatioConstraint", I[42], "UIAspectRatioConstraint")
				I[44] = new("ImageLabel", I[16], "Lightning", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://100732433455441"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
					I[45] = new("UIAspectRatioConstraint", I[44], "UIAspectRatioConstraint")
				I[46] = new("ImageLabel", I[16], "Flower", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://108991520533746"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
					I[47] = new("UIAspectRatioConstraint", I[46], "UIAspectRatioConstraint")
				I[48] = new("ImageLabel", I[16], "Sound", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://109371748822715"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
					I[49] = new("UIAspectRatioConstraint", I[48], "UIAspectRatioConstraint")
				I[50] = new("ImageLabel", I[16], "Ice", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://108593102772285"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false })
					I[51] = new("UIAspectRatioConstraint", I[50], "UIAspectRatioConstraint")
	return I[1]
end

return build
