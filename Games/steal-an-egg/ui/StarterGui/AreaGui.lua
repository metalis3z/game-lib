-- Generated from ui/StarterGui/AreaGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "AreaGui", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.16), Size = UDim2.fromScale(0.7, 0.09), ZIndex = -1 })
			I[3] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = -1 })
				I[4] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 1), NumberSequenceKeypoint.new(0.298, 0.95), NumberSequenceKeypoint.new(0.5012469, 0.7), NumberSequenceKeypoint.new(0.7, 0.95), NumberSequenceKeypoint.new(0.85, 1), NumberSequenceKeypoint.new(1, 1) }) })
			I[5] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 20.7714214 })
			I[6] = new("Frame", I[2], "Texts", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[7] = new("TextLabel", I[6], "Emoji", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(1.3527645, 0.5), RichText = true, Size = UDim2.fromScale(0, 1), Text = "🙂", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 45, TextWrapped = true })
					I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 2.2 })
				I[9] = new("TextLabel", I[6], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0, 1), Text = "Common Area", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 45, TextWrapped = true })
					I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 2.2 })
				I[11] = new("UIListLayout", I[6], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.007, 0), SortOrder = Enum.SortOrder.LayoutOrder })
	return I[1]
end

return build
