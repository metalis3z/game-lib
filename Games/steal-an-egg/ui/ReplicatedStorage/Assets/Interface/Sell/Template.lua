-- Generated from ui/ReplicatedStorage/Assets/Interface/Sell/Template.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Template", { BackgroundColor3 = Color3.fromRGB(66, 89, 102), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, -0.0022474), Size = UDim2.fromScale(0.97, 0.2) })
		I[2] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://80024000248680"), LayoutOrder = 2, Position = UDim2.fromScale(0.02, 0.5), Size = UDim2.fromScale(0.9, 0.9), ZIndex = 3 })
			I[3] = new("TextLabel", I[2], "Amount", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.95), Size = UDim2.fromScale(0.85, 0.22), Text = "(1.8ft)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 5 })
				I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 2 })
			I[5] = new("ImageLabel", I[2], "Locked", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://89325563727424"), LayoutOrder = 2, Position = UDim2.fromScale(0.05, 0.05), Size = UDim2.fromScale(0.5, 0.5), Visible = false, ZIndex = 5 })
				I[6] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 234, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 162, 0)) }), Rotation = 90 })
				I[7] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint")
			I[8] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
		I[9] = new("TextLabel", I[1], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.125, 0.5), RichText = true, Size = UDim2.fromScale(0.5031276, 0.55), Text = "Noob Card", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 2.2 })
		I[11] = new("Frame", I[1], "Sell", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(0.17, 0.55) })
			I[12] = new("Frame", I[11], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(227, 227, 227), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 10 })
				I[13] = new("UIStroke", I[12], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
				I[14] = new("UIGradient", I[12], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(14, 209, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 145, 0)) }), Rotation = 90 })
				I[15] = new("UIListLayout", I[12], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.1, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[16] = new("TextLabel", I[12], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.fromScale(0.9, 0.7), Text = "Sell", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 11 })
			I[17] = new("TextButton", I[11], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 15 })
		I[18] = new("UIGradient", I[1], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
		I[19] = new("Frame", I[1], "Currency", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.82, 0.5), Size = UDim2.fromScale(0.2621015, 0.6448211) })
			I[20] = new("TextLabel", I[19], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.115004, 0.5000001), Size = UDim2.fromScale(1.0369999, 0.6), Text = "$2", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 11 })
				I[21] = new("UIGradient", I[20], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(166, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 255, 0)) }), Rotation = 80 })
				I[22] = new("UIStroke", I[20], "UIStroke", { Thickness = 2.4000001 })
			I[23] = new("Frame", I[19], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 100, Size = UDim2.fromScale(0.03, 1) })
			I[24] = new("UIListLayout", I[19], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[25] = new("UIAspectRatioConstraint", I[19], "UIAspectRatioConstraint", { AspectRatio = 4 })
	return I[1]
end

return build
