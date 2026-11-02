-- Generated from ui/StarterGui/Strikes.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Strikes", { DisplayOrder = 4, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.6, 0.2), Visible = false })
			I[3] = new("TextLabel", I[2], "strikes", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.7500001), Size = UDim2.fromScale(0.5986864, 0.3269233), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 6 })
				I[4] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, HorizontalFlex = Enum.UIFlexAlignment.Fill, Padding = UDim.new(0.1, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[5] = new("ImageLabel", I[3], "1", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(65, 255, 64), ImageContent = Content.fromUri("rbxassetid://76282943379227"), Interactable = false, LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.5), Selectable = true, Size = UDim2.fromScale(0.625, 1), ZIndex = 0 })
					I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint")
					I[7] = new("ImageLabel", I[5], "dead", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 96, 111), ImageContent = Content.fromUri("rbxassetid://104790137032407"), LayoutOrder = 1000, Position = UDim2.fromScale(0.5, 0.5), Selectable = true, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 0 })
					I[8] = new("TextLabel", I[5], "strikes", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.0000001, 1), Size = UDim2.fromScale(0.3121695, 0.3269233), Text = "X", TextColor3 = Color3.fromRGB(255, 38, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, Visible = false, ZIndex = 6 })
				I[9] = new("ImageLabel", I[3], "2", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(65, 255, 64), ImageContent = Content.fromUri("rbxassetid://76282943379227"), Interactable = false, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Selectable = true, Size = UDim2.fromScale(0.625, 1), ZIndex = 0 })
					I[10] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint")
					I[11] = new("ImageLabel", I[9], "dead", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 96, 111), ImageContent = Content.fromUri("rbxassetid://104790137032407"), LayoutOrder = 1000, Position = UDim2.fromScale(0.5, 0.5), Selectable = true, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 0 })
					I[12] = new("TextLabel", I[9], "strikes", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.0000001, 1), Size = UDim2.fromScale(0.3121695, 0.3269233), Text = "X", TextColor3 = Color3.fromRGB(255, 38, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, Visible = false, ZIndex = 6 })
				I[13] = new("ImageLabel", I[3], "3", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(65, 255, 64), ImageContent = Content.fromUri("rbxassetid://76282943379227"), Interactable = false, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Selectable = true, Size = UDim2.fromScale(0.625, 1), ZIndex = 0 })
					I[14] = new("UIAspectRatioConstraint", I[13], "UIAspectRatioConstraint")
					I[15] = new("TextLabel", I[13], "strikes", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.0000001, 1), Size = UDim2.fromScale(0.3121695, 0.3269233), Text = "X", TextColor3 = Color3.fromRGB(255, 38, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, Visible = false, ZIndex = 6 })
					I[16] = new("ImageLabel", I[13], "dead", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 96, 111), ImageContent = Content.fromUri("rbxassetid://104790137032407"), LayoutOrder = 1000, Position = UDim2.fromScale(0.5, 0.5), Selectable = true, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 0 })
			I[17] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 4.1199999 })
			I[18] = new("TextLabel", I[2], "header", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = -2, Position = UDim2.fromScale(0.5, 0.1490384), Size = UDim2.fromScale(0.8, 0.2980768), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 6 })
				I[19] = new("UIStroke", I[18], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel })
				I[20] = new("UIGradient", I[18], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1403712, 0.30625), NumberSequenceKeypoint.new(0.2099768, 0.1), NumberSequenceKeypoint.new(0.3039443, 0), NumberSequenceKeypoint.new(0.4988399, 0), NumberSequenceKeypoint.new(0.7018561, 0.00625), NumberSequenceKeypoint.new(0.7993039, 0.15), NumberSequenceKeypoint.new(0.8677494, 0.35625), NumberSequenceKeypoint.new(1, 1) }) })
				I[21] = new("TextLabel", I[18], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = -2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.95), Text = "Hospital Deaths", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 6 })
					I[22] = new("UIStroke", I[21], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel })
			I[23] = new("TextLabel", I[2], "sep", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187371840", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = -2, Position = UDim2.fromScale(0.4999999, 0.3205505), Size = UDim2.fromScale(0.673826, 0.025), Text = "", TextColor3 = Color3.fromRGB(178, 177, 179), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
				I[24] = new("UIStroke", I[23], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
				I[25] = new("UIGradient", I[23], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.199536, 0.46875), NumberSequenceKeypoint.new(0.4988399, 0), NumberSequenceKeypoint.new(0.7981438, 0.475), NumberSequenceKeypoint.new(1, 1) }) })
			I[26] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder })
			I[27] = new("Folder", I[2], "Folder")
				I[28] = new("ImageLabel", I[27], "Template", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(254, 252, 255), ImageContent = Content.fromUri("rbxassetid://12560510770"), LayoutOrder = 1000, Position = UDim2.fromScale(0.5, 0.5), Selectable = true, Size = UDim2.fromScale(0.625, 1), Visible = false, ZIndex = 0 })
					I[29] = new("UIAspectRatioConstraint", I[28], "UIAspectRatioConstraint")
					I[30] = new("ViewportFrame", I[28], "viewport", { Ambient = Color3.fromRGB(152, 152, 152), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LightColor = Color3.fromRGB(200, 200, 200), LightDirection = Vector3.new(-1, 1, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(3, 3), ZIndex = 2 })
						I[31] = new("WorldModel", I[30], "WorldModel")
						I[32] = new("Part", I[30], "RootPart", { CFrame = CFrame.new(0, -1.2, 0.4, 0.9681025, -0.0163111, 0.2500229, -0.0505947, 0.9645958, 0.2588342, -0.2453929, -0.2632279, 0.9330024), Size = Vector3.new(2.5, 2.5, 1.25), Transparency = 1 })
					I[33] = new("TextLabel", I[28], "strikes", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 1), Size = UDim2.fromScale(0.3121695, 0.3269233), Text = "X", TextColor3 = Color3.fromRGB(255, 38, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 6 })
					I[34] = new("Decal", I[28], "The Riddling Skull Badge", { TextureContent = Content.fromUri("rbxassetid://74871990") })
						I[35] = new("Decal", I[34], "mr skull", { TextureContent = Content.fromUri("rbxassetid://409226202") })
			I[36] = new("TextLabel", I[2], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = -1, Position = UDim2.fromScale(0.5, 0.8808559), Size = UDim2.fromScale(0.8, 0.1166667), Text = "Lives 3/3", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, Visible = false, ZIndex = 6 })
				I[37] = new("UIStroke", I[36], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel })
	return I[1]
end

return build
