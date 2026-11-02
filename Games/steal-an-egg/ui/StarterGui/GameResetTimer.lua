-- Generated from ui/StarterGui/GameResetTimer.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GameResetTimer", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "EndingSoon", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.1), Size = UDim2.fromScale(0.631187, 0.0687859), Visible = false, ZIndex = -1 })
			I[3] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 1), ZIndex = -1 })
				I[4] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 1), NumberSequenceKeypoint.new(0.298, 0.95), NumberSequenceKeypoint.new(0.5012469, 0.7), NumberSequenceKeypoint.new(0.7, 0.95), NumberSequenceKeypoint.new(0.85, 1), NumberSequenceKeypoint.new(1, 1) }) })
			I[5] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 20.7714214 })
			I[6] = new("Frame", I[2], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 1), ZIndex = -1 })
				I[7] = new("TextLabel", I[6], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0, 1), Text = "Resets in 0:1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 45, TextWrapped = true })
					I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 2.2 })
				I[9] = new("UIListLayout", I[6], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.003, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[10] = new("ImageLabel", I[6], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1010992, 0.4021387), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.9) })
					I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint", { AspectRatio = 1.157323 })
					I[12] = new("ImageLabel", I[10], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://86038047961937"), Position = UDim2.fromScale(0.3927009, 0.4999999), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.2744241, 1.1111109) })
		I[13] = new("Frame", I[1], "TimeLeft", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.9900001, 0.98), Size = UDim2.fromScale(0.1394386, 0.0761933), ZIndex = -1 })
			I[14] = new("Frame", I[13], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(2, 1), ZIndex = -1 })
				I[15] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 1), NumberSequenceKeypoint.new(0.298, 0.95), NumberSequenceKeypoint.new(0.5012469, 0.7), NumberSequenceKeypoint.new(0.7, 0.95), NumberSequenceKeypoint.new(0.85, 1), NumberSequenceKeypoint.new(1, 1) }) })
			I[16] = new("Frame", I[13], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 1), ZIndex = -1 })
				I[17] = new("ImageLabel", I[16], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1010992, 0.4021387), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.9) })
					I[18] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint", { AspectRatio = 1.157323 })
					I[19] = new("ImageLabel", I[17], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131317614803230"), Position = UDim2.fromScale(0.4771324, 0.4472229), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.9457366, 1.005555) })
				I[20] = new("TextLabel", I[16], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5767727, 0.4999999), RichText = true, Size = UDim2.fromScale(0.911348, 0.5424669), Text = "3m 30s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 45, TextWrapped = true })
					I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 2.2 })
				I[22] = new("UIListLayout", I[16], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.003, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[23] = new("UIAspectRatioConstraint", I[13], "UIAspectRatioConstraint", { AspectRatio = 3.7113824 })
	return I[1]
end

return build
