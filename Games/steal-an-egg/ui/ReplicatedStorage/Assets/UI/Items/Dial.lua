-- Generated from ui/ReplicatedStorage/Assets/UI/Items/Dial.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Dial", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.35), ZIndex = 2000 })
		I[2] = new("ImageLabel", I[1], "Left", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(113, 255, 62), ImageContent = Content.fromUri("rbxassetid://96652414317905"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 2000 })
			I[3] = new("UIGradient", I[2], "UIGradient", { Rotation = 180, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.499, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 1) }) })
		I[4] = new("ImageLabel", I[1], "Right", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(113, 255, 62), ImageContent = Content.fromUri("rbxassetid://101177892736984"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 2000 })
			I[5] = new("UIGradient", I[4], "UIGradient", { Rotation = 180, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.499, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 1) }) })
		I[6] = new("Frame", I[1], "background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1.1, 2, 1.1, 2), ZIndex = 1900 })
			I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[8] = new("TextLabel", I[1], "Quantity", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.7), Text = "99", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2000 })
			I[9] = new("UIStroke", I[8], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
		I[10] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
		I[11] = new("Frame", I[1], "Deadzone", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 66, 91), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.1), Size = UDim2.fromScale(0.1, 0.2), ZIndex = 2100 })
			I[12] = new("TextLabel", I[11], "zero", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, -0.15), Size = UDim2.fromScale(2, 1.3), Text = "0", TextColor3 = Color3.fromRGB(255, 66, 91), TextScaled = true, TextSize = 14, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 100 })
	return I[1]
end

return build
