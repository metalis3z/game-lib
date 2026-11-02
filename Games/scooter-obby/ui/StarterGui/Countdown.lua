-- Generated from ui/StarterGui/Countdown.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Countdown", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4581281, 0.1469718), Size = UDim2.fromScale(0.0837438, 0.0431066) })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(53, 53, 53), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.5860974, -0.3720595), Size = UDim2.fromScale(2.2805042, 1.3316057), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 39 })
				I[4] = new("UIStroke", I[3], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
					I[5] = new("UIGradient", I[4], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 1), NumberSequenceKeypoint.new(0.35, 0), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(0.65, 0), NumberSequenceKeypoint.new(0.8, 1), NumberSequenceKeypoint.new(1, 1) }) })
				I[6] = new("UITextSizeConstraint", I[3], "UITextSizeConstraint", { MaxTextSize = 49 })
				I[7] = new("TextLabel", I[3], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.276499, 0.0450162), Size = UDim2.fromScale(0.4096949, 0.9549838), Text = "05:00", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 3.5999999 })
				I[9] = new("UIGradient", I[3], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 1), NumberSequenceKeypoint.new(0.35, 0), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(0.65, 0), NumberSequenceKeypoint.new(0.8, 1), NumberSequenceKeypoint.new(1, 1) }) })
			I[10] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1576731, 0.9502673), Size = UDim2.fromScale(0.7138108, 0.5542687), Text = "2x", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 28, TextWrapped = true })
				I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 3.5999999 })
				I[12] = new("UITextSizeConstraint", I[10], "UITextSizeConstraint", { MaxTextSize = 49 })
				I[13] = new("UIGradient", I[10], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 200, 2)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 238, 0)) }), Rotation = 90 })
			I[14] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://16094533476"), LayoutOrder = 1, Position = UDim2.fromScale(-0.0227792, 0.3037286), Size = UDim2.fromScale(1.354483, 3.1140997), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2 })
				I[15] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint")
		I[16] = new("Sound", I[1], "Tick")
	return I[1]
end

return build
