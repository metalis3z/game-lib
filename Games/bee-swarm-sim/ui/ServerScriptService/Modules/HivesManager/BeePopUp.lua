-- Generated from ui/ServerScriptService/Modules/HivesManager/BeePopUp.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "BeePopUp", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(83, 77, 58), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(11, 10, 6), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), ZIndex = 2 })
		I[2] = new("ImageLabel", I[1], "Thumbnail", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 228, 92), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://8458479373"), Position = UDim2.fromScale(0.4990411, 0.4673157), ScaleType = Enum.ScaleType.Fit, SliceCenter = Rect.new(0.5, 0.5, 0.5, 0.5), ZIndex = 3 })
		I[3] = new("TextButton", I[1], "CloseOverlay", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.1259398, 0.0456648), Size = UDim2.fromScale(1.2508868, 0.8530784), Text = "", TextSize = 14, ZIndex = 3 })
		I[4] = new("TextLabel", I[1], "Action", { BackgroundColor3 = Color3.fromRGB(255, 228, 92), BorderColor3 = Color3.fromRGB(97, 88, 51), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000001, 0), Size = UDim2.fromScale(0.9999999, 0.076), Text = "You hatched a...", TextScaled = true, TextSize = 16, TextWrapped = true, Visible = false })
		I[5] = new("TextLabel", I[1], "TypeName", { BackgroundColor3 = Color3.fromRGB(255, 228, 92), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0508005, 0.0477834), Size = UDim2.fromScale(0.8922139, 0.1613095), Text = "Basic Bee", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 29, TextStrokeColor3 = Color3.fromRGB(42, 42, 42), TextWrapped = true, ZIndex = 2 })
			I[6] = new("UICorner", I[5], "UICorner")
			I[7] = new("TextLabel", I[5], "Back", { BackgroundColor3 = Color3.fromRGB(255, 228, 92), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.05), Size = UDim2.fromScale(1, 1), Text = "Basic Bee", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 29, TextStrokeColor3 = Color3.fromRGB(42, 42, 42), TextWrapped = true })
			I[8] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.7254575, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.7287853, Color3.fromRGB(217, 217, 217)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 176, 176)) }), Offset = Vector2.new(0.2, 0), Rotation = 85, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.736411, 0), NumberSequenceKeypoint.new(1, 0) }) })
		I[9] = new("TextLabel", I[1], "Discovered", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4947772, 0.0076879), Text = "New Type Discovered!", TextColor3 = Color3.fromRGB(111, 255, 111), TextScaled = true, TextSize = 24, TextStrokeColor3 = Color3.fromRGB(27, 42, 53), TextStrokeTransparency = 0.71, TextWrapped = true })
			I[10] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(101, 255, 183)) }), Rotation = 90 })
		I[11] = new("TextLabel", I[1], "Back", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(158, 134, 78), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.7122161), Size = UDim2.fromScale(0.9999999, 0.5093853), Text = " ", TextColor3 = Color3.fromRGB(242, 244, 255), TextScaled = true, TextSize = 29, TextTransparency = 1, TextWrapped = true })
			I[12] = new("UICorner", I[11], "UICorner")
			I[13] = new("UIStroke", I[11], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(76, 60, 51), Thickness = 10.6999998 })
			I[14] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.7254575, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.7287853, Color3.fromRGB(217, 217, 217)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 176, 176)) }), Offset = Vector2.new(0.2, 0), Rotation = 85, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.736411, 0), NumberSequenceKeypoint.new(1, 0) }) })
		I[15] = new("TextButton", I[1], "X", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 94, 94), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9607266, 0.23228), Rotation = 10, Selected = true, Size = UDim2.fromScale(0.156, 0.116), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
			I[16] = new("UICorner", I[15], "UICorner")
		I[17] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 0.7676058 })
		I[18] = new("TextLabel", I[1], "RarityBack", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.85, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0508005, 0.7354841), Size = UDim2.fromScale(0.8922139, 0.1613095), Text = " ", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 29, TextStrokeColor3 = Color3.fromRGB(42, 42, 42), TextTransparency = 0.79, TextWrapped = true })
			I[19] = new("UICorner", I[18], "UICorner")
		I[20] = new("TextLabel", I[1], "NameBack", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.85, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0508006, 0.0486393), Size = UDim2.fromScale(0.8922139, 0.1837217), Text = " ", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 29, TextStrokeColor3 = Color3.fromRGB(42, 42, 42), TextTransparency = 0.79, TextWrapped = true })
			I[21] = new("UICorner", I[20], "UICorner")
		I[22] = new("TextLabel", I[1], "ColorAndRarity", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0508005, 0.712216), Size = UDim2.fromScale(0.8922139, 0.1613095), Text = "Rare", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 67, TextStrokeColor3 = Color3.fromRGB(42, 42, 42), TextWrapped = true, ZIndex = 2 })
			I[23] = new("TextLabel", I[22], "TEXT", { BackgroundColor3 = Color3.fromRGB(255, 228, 92), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.05), Size = UDim2.fromScale(1, 1), Text = "Rare", TextColor3 = Color3.fromRGB(209, 209, 209), TextScaled = true, TextSize = 29, TextStrokeColor3 = Color3.fromRGB(42, 42, 42), TextWrapped = true })
				I[24] = new("UIGradient", I[23], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(214, 214, 214)), ColorSequenceKeypoint.new(0.4658902, Color3.fromRGB(214, 214, 214)), ColorSequenceKeypoint.new(0.4725457, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.6389351, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.6455907, Color3.fromRGB(214, 214, 214)), ColorSequenceKeypoint.new(0.7237936, Color3.fromRGB(214, 214, 214)), ColorSequenceKeypoint.new(0.7321131, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.8202995, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.8336107, Color3.fromRGB(214, 214, 214)), ColorSequenceKeypoint.new(1, Color3.fromRGB(214, 214, 214)) }), Rotation = 75 })
			I[25] = new("UICorner", I[22], "UICorner")
			I[26] = new("UIGradient", I[22], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.7254575, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.7287853, Color3.fromRGB(217, 217, 217)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 176, 176)) }), Offset = Vector2.new(0.2, 0), Rotation = 85, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.736411, 0), NumberSequenceKeypoint.new(1, 0) }) })
		I[27] = new("ImageButton", I[1], "JellyReroll", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, HoverImageContent = Content.fromUri("rbxassetid://12888156513"), ImageContent = Content.fromUri("rbxassetid://12888156513"), Position = UDim2.fromScale(1.0106016, 0.7080652), Rotation = 15, Size = UDim2.fromScale(0.2557263, 0.1981303), Visible = false, ZIndex = 4 })
			I[28] = new("ObjectValue", I[27], "Slot")
			I[29] = new("StringValue", I[27], "Item")
	return I[1]
end

return build
