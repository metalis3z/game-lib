-- Generated from ui/StarterGui/AwakeningBar.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "AwakeningBar", { ResetOnSpawn = false })
		I[2] = new("Frame", I[1], "UltimateBar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 1, -100), Size = UDim2.fromOffset(397, 25) })
			I[3] = new("ImageButton", I[2], "ActivateButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[4] = new("Frame", I[2], "Progress", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.new(0.5050378, 0, 4.2800002, -80), Size = UDim2.fromOffset(300, 20) })
				I[5] = new("ImageLabel", I[4], "Bar", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://17136251960"), ImageTransparency = 1, Position = UDim2.new(0, 0, 1.25, -25), Size = UDim2.fromScale(0, 1), ZIndex = 3 })
					I[6] = new("Frame", I[5], "Fill", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderMode = Enum.BorderMode.Inset, BorderSizePixel = 0, Size = UDim2.fromScale(20, 1) })
						I[7] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 170, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = -90 })
			I[8] = new("TextLabel", I[2], "UltName", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187375716", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 4.48, -105), Size = UDim2.fromOffset(300, 25), Text = "Domain Expansion", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[9] = new("UIStroke", I[8], "UIStroke")
			I[10] = new("Frame", I[2], "DoubleProgress", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 5, -97), Size = UDim2.fromOffset(300, 4) })
				I[11] = new("Frame", I[10], "Bar", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderMode = Enum.BorderMode.Inset, BorderSizePixel = 0, Position = UDim2.fromScale(-0.0033333, 0), Size = UDim2.fromScale(0, 1) })
					I[12] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.3529412, Color3.fromRGB(111, 255, 0)), ColorSequenceKeypoint.new(0.5743945, Color3.fromRGB(0, 213, 255)), ColorSequenceKeypoint.new(0.7854671, Color3.fromRGB(126, 234, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 81, 255)) }), Rotation = -90 })
			I[13] = new("TextLabel", I[2], "UltKey", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187375716", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.7), Size = UDim2.fromScale(1, 1), Text = "Press G to activate", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 5 }, nil, { "Keyboard" })
				I[14] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(255, 255, 255) })
				I[15] = new("ImageLabel", I[13], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12553547082"), Position = UDim2.fromScale(0.5, -3.1500001), Size = UDim2.fromOffset(84, 91), Visible = false })
		I[16] = new("Highlight", I[1], "HLight", { DepthMode = Enum.HighlightDepthMode.Occluded, FillColor = Color3.fromRGB(255, 255, 255), FillTransparency = 0.25, OutlineTransparency = 0.25 })
		I[17] = new("PointLight", I[1], "Light", { Brightness = 3 })
	return I[1]
end

return build
