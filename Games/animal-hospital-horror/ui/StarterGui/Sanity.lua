-- Generated from ui/StarterGui/Sanity.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Sanity", { DisplayOrder = 3, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.None })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1000, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(0.6964006, 1) })
			I[3] = new("Frame", I[2], "Frame", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1000, Position = UDim2.fromScale(0, 0.8862718), Size = UDim2.fromScale(0.2250859, 0.1125429), ZIndex = 10 })
				I[4] = new("TextLabel", I[3], "dif", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, -0.3158613), Size = UDim2.fromScale(0.9, 0.585774), Text = "100%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextTransparency = 0.1, TextWrapped = true, Visible = false, ZIndex = 101 })
					I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 2 })
					I[6] = new("UIPadding", I[4], "UIPadding", { PaddingBottom = UDim.new(0.2, 0), PaddingTop = UDim.new(0.2, 0) })
				I[7] = new("ImageLabel", I[3], "textbox", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://16115026389"), ImageTransparency = 1, LayoutOrder = 1000, Position = UDim2.fromScale(0.5, 0.525), Size = UDim2.fromScale(1, 1) })
					I[8] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint")
					I[9] = new("TextLabel", I[7], "amount", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.8), Text = "100%", TextColor3 = Color3.fromRGB(0, 249, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextTransparency = 0.1, TextWrapped = true, ZIndex = 101 })
						I[10] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 75 })
						I[11] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5533333, Color3.fromRGB(141, 141, 141)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Offset = Vector2.new(0, 0.35), Rotation = -90 })
						I[12] = new("UIPadding", I[9], "UIPadding", { PaddingBottom = UDim.new(0.2, 0), PaddingTop = UDim.new(0.2, 0) })
						I[13] = new("UIStroke", I[9], "UIStroke", { Thickness = 3 })
					I[14] = new("TextLabel", I[7], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1.2668632), Size = UDim2.fromScale(1.1597286, 0.2448773), Text = "SANITY", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextTransparency = 0.1, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 101 })
						I[15] = new("UIStroke", I[14], "UIStroke", { Enabled = false, Thickness = 4 })
						I[16] = new("UIGradient", I[14], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1403712, 0.30625), NumberSequenceKeypoint.new(0.2099768, 0.1), NumberSequenceKeypoint.new(0.3039443, 0), NumberSequenceKeypoint.new(0.4988399, 0), NumberSequenceKeypoint.new(0.7018561, 0.00625), NumberSequenceKeypoint.new(0.7993039, 0.15), NumberSequenceKeypoint.new(0.8677494, 0.35625), NumberSequenceKeypoint.new(1, 1) }) })
					I[17] = new("Decal", I[7], "Heart", { TextureContent = Content.fromUri("rbxassetid://7516199736") })
					I[18] = new("UIGradient", I[7], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5533333, Color3.fromRGB(141, 141, 141)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Offset = Vector2.new(0, 0.3), Rotation = -90 })
				I[19] = new("TextLabel", I[3], "difDrain", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, -0.3668751), Size = UDim2.fromScale(0.7432451, 0.425), Text = "100%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextTransparency = 0.1, TextWrapped = true, Visible = false, ZIndex = 101 })
					I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 2 })
					I[21] = new("UIPadding", I[19], "UIPadding", { PaddingBottom = UDim.new(0.2, 0), PaddingTop = UDim.new(0.2, 0) })
			I[22] = new("Frame", I[2], "Images", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1000, Position = UDim2.fromScale(0, 0.8862718), Size = UDim2.fromScale(0.2250859, 0.1125429), ZIndex = 10 })
				I[23] = new("Frame", I[22], "Bar", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1000, Position = UDim2.fromScale(0.5, -0.0000044), Size = UDim2.fromScale(0.2, 2.8906887), Visible = false, ZIndex = 0 })
				I[24] = new("ImageLabel", I[22], "back", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://104959800870384"), LayoutOrder = 1000, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.625, 1.25), ZIndex = 0 })
					I[25] = new("UIAspectRatioConstraint", I[24], "UIAspectRatioConstraint")
				I[26] = new("ImageLabel", I[22], "brain", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://104959800870384"), LayoutOrder = 1000, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5976428, 1.1952854) })
					I[27] = new("UIAspectRatioConstraint", I[26], "UIAspectRatioConstraint")
					I[28] = new("UIGradient", I[26], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.0116667, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.015, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Offset = Vector2.new(0, -0.5), Rotation = -90 })
				I[29] = new("ImageLabel", I[22], "fade", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 38, 0), ImageContent = Content.fromUri("rbxassetid://18609186137"), LayoutOrder = 1000, Position = UDim2.fromScale(0.5175108, 0.5150094), Size = UDim2.fromScale(1.0402571, 2.0805137), Visible = false, ZIndex = -1 })
					I[30] = new("Decal", I[29], "Goodsound000/ Effect ", { TextureContent = Content.fromUri("rbxassetid://75232118444479") })
					I[31] = new("Decal", I[29], "Circular gradient fade effect", { TextureContent = Content.fromUri("rbxassetid://18609186137") })
					I[32] = new("UIAspectRatioConstraint", I[29], "UIAspectRatioConstraint")
			I[33] = new("TextLabel", I[2], "cash", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3513933, 0.9566112), Size = UDim2.fromScale(0.3068735, 0.043864), Text = "$0", TextColor3 = Color3.fromRGB(0, 249, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextTransparency = 0.1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 101 })
				I[34] = new("UIStroke", I[33], "UIStroke", { Thickness = 2 })
			I[35] = new("TextLabel", I[2], "class", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3513933, 0.9909999), Size = UDim2.fromScale(0.3068736, 0.0343887), Text = "CLASS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextTransparency = 0.1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 101 })
				I[36] = new("UIStroke", I[35], "UIStroke", { Thickness = 2 })
			I[37] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
			I[38] = new("UIScale", I[2], "UIScaleAndPos")
	return I[1]
end

return build
