-- Generated from ui/StarterGui/SpeedGainAnimation.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SpeedGainAnimation", { ClipToDeviceSafeArea = false, ResetOnSpawn = false, SafeAreaCompatibility = Enum.SafeAreaCompatibility.None, ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.3056836, 0.3947369), Size = UDim2.fromScale(0.1958525, 0.0545113), Visible = false })
			I[3] = new("ImageLabel", I[2], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://117600447507784"), Position = UDim2.fromScale(0.1940826, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1770758, 1) })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 1.157323 })
			I[5] = new("TextLabel", I[2], "CurrentBoost", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5421618, 0.5), Size = UDim2.fromScale(0.3036697, 1), Text = "+100 Speed", TextColor3 = Color3.fromRGB(0, 200, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[6] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(0, 65, 121), Thickness = 2.3 })
			I[7] = new("UIListLayout", I[2], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder })
			I[8] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 8.7931032 })
		I[9] = new("Frame", I[1], "X2Gain", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.3056836, 0.3947368), Size = UDim2.fromScale(0.2211982, 0.1103206), Visible = false })
			I[10] = new("ImageLabel", I[9], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://123461933606111"), Position = UDim2.fromScale(0.1940826, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1770758, 1) })
				I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint", { AspectRatio = 1.157323 })
			I[12] = new("TextLabel", I[9], "CurrentBoost", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6884555, 0.5), Size = UDim2.fromScale(0.7254902, 1), Text = "+100 Bonus Speed", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(121, 95, 0), Thickness = 2.3 })
				I[14] = new("UIGradient", I[12], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 1)), ColorSequenceKeypoint.new(0.2629758, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.3321799, Color3.fromRGB(255, 200, 0)), ColorSequenceKeypoint.new(0.4186851, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.5155709, Color3.fromRGB(255, 255, 127)), ColorSequenceKeypoint.new(0.5968859, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.6591696, Color3.fromRGB(255, 217, 0)), ColorSequenceKeypoint.new(0.7785468, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 0)) }), Rotation = -35 })
			I[15] = new("UIListLayout", I[9], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder })
			I[16] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint", { AspectRatio = 8.7931032 })
	return I[1]
end

return build
