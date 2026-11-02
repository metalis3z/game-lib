-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/AvatarPreviewController/avatarPreviewQuickActions.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "avatarPreviewQuickActions", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, 0, 0, 4), Size = UDim2.new(1.0000001, -8, 0.1018494, 0), ZIndex = 5 }, { ["SkipTheme"] = true })
		I[2] = new("Frame", I[1], "right", { AnchorPoint = Vector2.new(1, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1.0000001, 0), Size = UDim2.fromScale(0.2228126, 0.9999999) }, { ["SkipTheme"] = true })
			I[3] = new("TextButton", I[2], "focusHead", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 }, { ["SkipTheme"] = true }, { "UIEffectSoundOnly" })
				I[4] = new("ImageLabel", I[3], "icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://115524655468365"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.75, 0.75) }, { ["SkipTheme"] = true })
				I[5] = new("Frame", I[3], "back", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.885, 0.85) }, { ["SkipTheme"] = true })
					I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["SkipTheme"] = true })
			I[7] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["SkipTheme"] = true })
			I[8] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.3200001, AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height }, { ["SkipTheme"] = true })
			I[9] = new("UIListLayout", I[2], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["SkipTheme"] = true })
		I[10] = new("Frame", I[1], "animationsDropdown", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0000004, 0), Size = UDim2.fromScale(0.2047666, 7.7685061), Visible = false }, { ["SkipTheme"] = true })
			I[11] = new("TextButton", I[10], "Run", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, LayoutOrder = 1, Position = UDim2.fromScale(0.6180124, 0.2084108), Selectable = false, Size = UDim2.fromScale(0.7639741, 0.0948405), Text = "" })
				I[12] = new("ImageLabel", I[11], "icon", { AnchorPoint = Vector2.new(0.25, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://132543529549586"), Position = UDim2.fromScale(0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(2, 7) }, { ["SkipTheme"] = true })
					I[13] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint", { AspectRatio = 0.2857143 })
				I[14] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint")
			I[15] = new("TextButton", I[10], "Walk", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, LayoutOrder = 2, Position = UDim2.fromScale(0.618012, 0.3296818), Selectable = false, Size = UDim2.fromScale(0.7639745, 0.0948405), Text = "" })
				I[16] = new("ImageLabel", I[15], "icon", { AnchorPoint = Vector2.new(0.25, 0.1428571), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://132543529549586"), Position = UDim2.fromScale(0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(2, 7) }, { ["SkipTheme"] = true })
					I[17] = new("UIAspectRatioConstraint", I[16], "UIAspectRatioConstraint", { AspectRatio = 0.2857143 })
				I[18] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint")
			I[19] = new("TextButton", I[10], "Fall", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, LayoutOrder = 3, Position = UDim2.fromScale(0.6180122, 0.4509528), Selectable = false, Size = UDim2.fromScale(0.7639738, 0.0948404), Text = "" })
				I[20] = new("ImageLabel", I[19], "icon", { AnchorPoint = Vector2.new(0.25, 0.2857143), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://132543529549586"), Position = UDim2.fromScale(0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(2, 7) }, { ["SkipTheme"] = true })
					I[21] = new("UIAspectRatioConstraint", I[20], "UIAspectRatioConstraint", { AspectRatio = 0.2857143 })
				I[22] = new("UIAspectRatioConstraint", I[19], "UIAspectRatioConstraint")
			I[23] = new("TextButton", I[10], "Jump", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, LayoutOrder = 4, Position = UDim2.fromScale(0.6180122, 0.5722238), Selectable = false, Size = UDim2.fromScale(0.7639738, 0.0948404), Text = "" })
				I[24] = new("ImageLabel", I[23], "icon", { AnchorPoint = Vector2.new(0.25, 0.4285714), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://132543529549586"), Position = UDim2.fromScale(0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(2, 7) }, { ["SkipTheme"] = true })
					I[25] = new("UIAspectRatioConstraint", I[24], "UIAspectRatioConstraint", { AspectRatio = 0.2857143 })
				I[26] = new("UIAspectRatioConstraint", I[23], "UIAspectRatioConstraint")
			I[27] = new("TextButton", I[10], "Swim", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, LayoutOrder = 5, Position = UDim2.fromScale(0.6180125, 0.6934948), Selectable = false, Size = UDim2.fromScale(0.7639744, 0.0948405), Text = "" })
				I[28] = new("ImageLabel", I[27], "icon", { AnchorPoint = Vector2.new(0.25, 0.5714286), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://132543529549586"), Position = UDim2.fromScale(0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(2, 7) }, { ["SkipTheme"] = true })
					I[29] = new("UIAspectRatioConstraint", I[28], "UIAspectRatioConstraint", { AspectRatio = 0.2857143 })
				I[30] = new("UIAspectRatioConstraint", I[27], "UIAspectRatioConstraint")
			I[31] = new("TextButton", I[10], "Climb", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, LayoutOrder = 6, Position = UDim2.fromScale(0.6180122, 0.8147658), Selectable = false, Size = UDim2.fromScale(0.7639734, 0.0948404), Text = "" })
				I[32] = new("ImageLabel", I[31], "icon", { AnchorPoint = Vector2.new(0.25, 0.7142857), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://132543529549586"), Position = UDim2.fromScale(0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(2, 7) }, { ["SkipTheme"] = true })
					I[33] = new("UIAspectRatioConstraint", I[32], "UIAspectRatioConstraint", { AspectRatio = 0.2857143 })
				I[34] = new("UIAspectRatioConstraint", I[31], "UIAspectRatioConstraint")
			I[35] = new("TextButton", I[10], "Idle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, LayoutOrder = 7, Position = UDim2.fromScale(0.6180122, 0.9360365), Selectable = false, Size = UDim2.fromScale(0.7639734, 0.0948403), Text = "" })
				I[36] = new("ImageLabel", I[35], "icon", { AnchorPoint = Vector2.new(0.75, 0.8571429), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://132543529549586"), Position = UDim2.fromScale(0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(2, 7) }, { ["SkipTheme"] = true })
					I[37] = new("UIAspectRatioConstraint", I[36], "UIAspectRatioConstraint", { AspectRatio = 0.2857143 })
				I[38] = new("UIAspectRatioConstraint", I[35], "UIAspectRatioConstraint")
			I[39] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0.4, 0), BottomRightRadius = UDim.new(0.4, 0), TopLeftRadius = UDim.new(0.4, 0), TopRightRadius = UDim.new(0.4, 0) }, { ["SkipTheme"] = true })
			I[40] = new("UIListLayout", I[10], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder })
			I[41] = new("Frame", I[10], "buffer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -1, Size = UDim2.fromScale(1, 0.1287249) })
		I[42] = new("Frame", I[1], "left", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.2228126, 0.9999999) }, { ["SkipTheme"] = true })
			I[43] = new("TextButton", I[42], "setAnimation", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 }, { ["SkipTheme"] = true }, { "UIEffectSoundOnly" })
				I[44] = new("Frame", I[43], "back", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.885, 0.85) }, { ["SkipTheme"] = true })
					I[45] = new("UICorner", I[44], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["SkipTheme"] = true })
				I[46] = new("Frame", I[43], "imageContainer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.85, 0.85) })
					I[47] = new("UIAspectRatioConstraint", I[46], "UIAspectRatioConstraint")
					I[48] = new("ImageLabel", I[46], "icon", { AnchorPoint = Vector2.new(0.75, 0.8571429), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://132543529549586"), Position = UDim2.fromScale(0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(2, 7) }, { ["SkipTheme"] = true })
						I[49] = new("UIAspectRatioConstraint", I[48], "UIAspectRatioConstraint", { AspectRatio = 0.2857143 })
			I[50] = new("UICorner", I[42], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["SkipTheme"] = true })
			I[51] = new("UIAspectRatioConstraint", I[42], "UIAspectRatioConstraint", { AspectRatio = 1.3200001, AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height }, { ["SkipTheme"] = true })
			I[52] = new("UIListLayout", I[42], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["SkipTheme"] = true })
	return I[1]
end

return build
