-- Generated from ui/ReplicatedStorage/Assets/Interface/Crafting/Template.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Template", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.00658, -0.0337112), Size = UDim2.fromScale(1, 0.42) })
		I[2] = new("Frame", I[1], "Selected", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5002034, 1.061166), Size = UDim2.fromScale(0.97942, 2.1223292), Visible = false, ZIndex = 21 })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 3 })
		I[4] = new("Frame", I[1], "List", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.201, 0.56), Size = UDim2.fromScale(0.5, 0.5), ZIndex = 5 })
			I[5] = new("UIListLayout", I[4], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.35, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[6] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint")
		I[7] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://75937061770026"), LayoutOrder = 2, Position = UDim2.fromScale(0.012, 0.5), Size = UDim2.fromScale(0.8, 0.8), ZIndex = 2 })
			I[8] = new("Frame", I[7], "Noti", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(212, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.4, 0.4), Visible = false, ZIndex = 10 })
				I[9] = new("UIAspectRatioConstraint", I[8], "UIAspectRatioConstraint")
				I[10] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
				I[11] = new("TextLabel", I[8], "ButtonName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 11 })
			I[12] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint")
		I[13] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.195, 0), RichText = true, Size = UDim2.fromScale(0.4653533, 0.2593179), Text = "TRADE SCAM", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 2.2 })
		I[15] = new("Frame", I[1], "Craft", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.87, 0.93), Size = UDim2.fromScale(0.2, 0.3) })
			I[16] = new("Frame", I[15], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(129, 204, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 10 })
				I[17] = new("Frame", I[16], "TooMuch", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 20 })
				I[18] = new("UIGradient", I[16], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(187, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(41, 222, 0)) }), Rotation = 90 })
				I[19] = new("UIStroke", I[16], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
				I[20] = new("TextLabel", I[16], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5061522, 0.5000008), Size = UDim2.fromScale(0.9, 0.9), Text = "Craft", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 11 })
			I[21] = new("TextButton", I[15], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 15 })
		I[22] = new("Frame", I[1], "Border", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[23] = new("UIStroke", I[22], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 2.4000001, Transparency = 0.4 })
		I[24] = new("TextLabel", I[1], "Stats", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7579367, 0.1143056), RichText = true, Size = UDim2.fromScale(0.2224908, 0.4), Text = "25 Storage 1.1x Luck", TextColor3 = Color3.fromRGB(220, 220, 220), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[25] = new("UIStroke", I[24], "UIStroke", { Thickness = 2.2 })
		I[26] = new("UIGradient", I[1], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.8), NumberSequenceKeypoint.new(1, 1) }) })
	return I[1]
end

return build
