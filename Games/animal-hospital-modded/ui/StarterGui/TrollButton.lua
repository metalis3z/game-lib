-- Generated from ui/StarterGui/TrollButton.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "TrollButton")
		I[2] = new("TextButton", I[1], "Troll", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.95, 0.62), Size = UDim2.fromScale(0.0581782, 0.1142298), SizeConstraint = Enum.SizeConstraint.RelativeXX, Text = "", Visible = false }, { ["Container"] = "Troll" })
			I[3] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://80102826775539"), Position = UDim2.fromScale(0.5, 0.45), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.86, 0.86), ZIndex = 5 })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize })
			I[5] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.84), Size = UDim2.fromScale(0.9, 0.27), Text = "TROLL", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 10, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 10 })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 4 })
				I[7] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectRatio = 3.333333, AspectType = Enum.AspectType.ScaleWithParentSize })
			I[8] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
			I[9] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2.5 })
				I[10] = new("UIGradient", I[9], "ModdedRainbow", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 55, 85)), ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 180, 55)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 245, 80)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 255, 120)), ColorSequenceKeypoint.new(0.66, Color3.fromRGB(60, 220, 255)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(135, 90, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 65, 210)) }), Offset = Vector2.new(0, 0.1), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 0.5375) }) })
			I[11] = new("UICorner", I[2], "UICorner")
		I[12] = new("TextButton", I[1], "Extra", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.8772958, 0.6201956), Size = UDim2.fromScale(0.0589473, 0.0924513), SizeConstraint = Enum.SizeConstraint.RelativeXX, Text = "", Visible = false }, { ["Container"] = "Troll" })
			I[13] = new("UIStroke", I[12], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(0, 170, 255), LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 4 })
			I[14] = new("ImageLabel", I[12], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://99188543612923"), Position = UDim2.fromScale(0.5, 0.45), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.86, 0.86), ZIndex = 5 })
				I[15] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize })
			I[16] = new("TextLabel", I[12], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.84), Size = UDim2.fromScale(0.9, 0.27), Text = "Panal", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 10, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 10 })
				I[17] = new("UIStroke", I[16], "UIStroke", { Thickness = 4 })
				I[18] = new("UIAspectRatioConstraint", I[16], "UIAspectRatioConstraint", { AspectRatio = 3.333333, AspectType = Enum.AspectType.ScaleWithParentSize })
			I[19] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint")
	return I[1]
end

return build
