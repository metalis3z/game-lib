-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/CreateAvatarController/SkinToneStage/colorSliders.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "colorSliders", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 10, Position = UDim2.fromScale(0.5, 0.5634649), Size = UDim2.fromScale(1, 0.2173803) }, { ["SkipTheme"] = true })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.1, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, VerticalFlex = Enum.UIFlexAlignment.SpaceBetween }, { ["SkipTheme"] = true })
		I[3] = new("Frame", I[1], "hue", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.005, -0.0000003), Size = UDim2.fromScale(0.99, 0.375) }, { ["SkipTheme"] = true })
			I[4] = new("TextButton", I[3], "slider", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1 }, { ["SkipTheme"] = true })
				I[5] = new("Frame", I[4], "line", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["SkipTheme"] = true })
					I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["SkipTheme"] = true })
					I[7] = new("UIStroke", I[5], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Center, Color = Color3.fromRGB(240, 239, 249), Thickness = 1.5 }, { ["SkipTheme"] = true })
					I[8] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.166667, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.333333, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.666667, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.833333, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }) }, { ["SkipTheme"] = true })
				I[9] = new("Frame", I[4], "circle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 252, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1552356, 0.5), Size = UDim2.fromScale(0.035, 1.35) }, { ["SkipTheme"] = true })
					I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.4, 0), BottomRightRadius = UDim.new(0.4, 0), TopLeftRadius = UDim.new(0.4, 0), TopRightRadius = UDim.new(0.4, 0) }, { ["SkipTheme"] = true })
					I[11] = new("UIStroke", I[9], "UIStroke", { Color = Color3.fromRGB(240, 239, 249), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.15 }, { ["SkipTheme"] = true })
					I[12] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint", { AspectRatio = 0.21 }, { ["SkipTheme"] = true })
					I[13] = new("UIStroke", I[9], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(18, 18, 21), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1, ZIndex = 2 }, { ["SkipTheme"] = true })
		I[14] = new("Frame", I[1], "saturationAndValue", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 10, Position = UDim2.fromScale(0.005, 0.31044), Size = UDim2.fromScale(0.99, 0.375) }, { ["SkipTheme"] = true })
			I[15] = new("TextButton", I[14], "slider", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1 }, { ["SkipTheme"] = true })
				I[16] = new("Frame", I[15], "line", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["SkipTheme"] = true })
					I[17] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["SkipTheme"] = true })
					I[18] = new("UIStroke", I[16], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Center, Color = Color3.fromRGB(240, 239, 249), Thickness = 1.5 }, { ["SkipTheme"] = true })
					I[19] = new("UIGradient", I[16], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.166667, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.333333, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.666667, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.833333, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }) }, { ["SkipTheme"] = true })
				I[20] = new("Frame", I[15], "circle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 252, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1552356, 0.5), Size = UDim2.fromScale(0.035, 1.35) }, { ["SkipTheme"] = true })
					I[21] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(0.4, 0), BottomRightRadius = UDim.new(0.4, 0), TopLeftRadius = UDim.new(0.4, 0), TopRightRadius = UDim.new(0.4, 0) }, { ["SkipTheme"] = true })
					I[22] = new("UIAspectRatioConstraint", I[20], "UIAspectRatioConstraint", { AspectRatio = 0.21 }, { ["SkipTheme"] = true })
					I[23] = new("UIStroke", I[20], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(18, 18, 21), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1, ZIndex = 2 }, { ["SkipTheme"] = true })
					I[24] = new("UIStroke", I[20], "UIStroke", { Color = Color3.fromRGB(240, 239, 249), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.15 }, { ["SkipTheme"] = true })
	return I[1]
end

return build
