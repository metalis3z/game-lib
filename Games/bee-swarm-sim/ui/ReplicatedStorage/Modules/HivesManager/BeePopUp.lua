-- Generated from ui/ReplicatedStorage/Modules/HivesManager/BeePopUp.rbxm by _tools/rbxm2lua.luau
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
		I[2] = new("ImageLabel", I[1], "Thumbnail", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 228, 92), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17164979410"), Position = UDim2.fromScale(0.4521419, 0.4613157), ScaleType = Enum.ScaleType.Fit, SliceCenter = Rect.new(0.5, 0.5, 0.5, 0.5), ZIndex = 3 })
		I[3] = new("TextButton", I[1], "CloseOverlay", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.1259398, 0.0456648), Size = UDim2.fromScale(1.2508868, 0.8530784), Text = "", TextSize = 14, ZIndex = 3 })
		I[4] = new("TextLabel", I[1], "Action", { BackgroundColor3 = Color3.fromRGB(255, 228, 92), BorderColor3 = Color3.fromRGB(97, 88, 51), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000001, 0), Size = UDim2.fromScale(0.9999999, 0.076), Text = "You hatched a...", TextScaled = true, TextSize = 16, TextWrapped = true, Visible = false })
		I[5] = new("TextLabel", I[1], "TypeName", { BackgroundColor3 = Color3.fromRGB(255, 228, 92), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.1732729, 0.0937834), Rotation = -4, Size = UDim2.fromScale(0.8922139, 0.1613095), Text = "Basic Bee", TextColor3 = Color3.fromRGB(61, 61, 61), TextScaled = true, TextSize = 29, TextStrokeColor3 = Color3.fromRGB(42, 42, 42), TextWrapped = true, ZIndex = 2 })
			I[6] = new("UICorner", I[5], "UICorner")
			I[7] = new("TextLabel", I[5], "Back", { BackgroundColor3 = Color3.fromRGB(255, 228, 92), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.01, -0.07), Size = UDim2.fromScale(1, 1), Text = "Basic Bee", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 29, TextStrokeColor3 = Color3.fromRGB(42, 42, 42), TextWrapped = true })
				I[8] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(61, 61, 61), Thickness = 3 })
			I[9] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.7254575, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.7287853, Color3.fromRGB(217, 217, 217)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 176, 176)) }), Offset = Vector2.new(0.2, 0), Rotation = 85, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.736411, 0), NumberSequenceKeypoint.new(1, 0) }) })
			I[10] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(61, 61, 61), Thickness = 3 })
		I[11] = new("TextLabel", I[1], "Discovered", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4947772, 0.0356879), Text = "New Type Discovered!", TextColor3 = Color3.fromRGB(111, 255, 111), TextScaled = true, TextSize = 24, TextStrokeColor3 = Color3.fromRGB(27, 42, 53), TextStrokeTransparency = 0.71, TextWrapped = true })
			I[12] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(101, 255, 183)) }), Rotation = 90 })
		I[13] = new("TextLabel", I[1], "Back", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(140, 107, 83), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.7122161), Size = UDim2.fromScale(0.9999999, 0.5093853), Text = " ", TextColor3 = Color3.fromRGB(242, 244, 255), TextScaled = true, TextSize = 29, TextTransparency = 1, TextWrapped = true })
			I[14] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
			I[15] = new("UIStroke", I[13], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(236, 180, 140), Thickness = 8 })
			I[16] = new("UIGradient", I[13], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.7254575, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.7287853, Color3.fromRGB(217, 217, 217)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 176, 176)) }), Offset = Vector2.new(0.2, 0), Rotation = 85, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.736411, 0), NumberSequenceKeypoint.new(1, 0) }) })
		I[17] = new("TextButton", I[1], "X", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 94, 94), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9106509, 0.249), Rotation = 10, Selected = true, Size = UDim2.fromScale(0.1415094, 0.109977), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
			I[18] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(0, 45), BottomRightRadius = UDim.new(0, 45), TopLeftRadius = UDim.new(0, 45), TopRightRadius = UDim.new(0, 45) })
		I[19] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 0.7676058 })
		I[20] = new("TextLabel", I[1], "ColorAndRarity", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.678), Size = UDim2.fromScale(0.8405592, 0.0873095), Text = "Blue Legendary", TextColor3 = Color3.fromRGB(61, 61, 61), TextScaled = true, TextSize = 23, TextStrokeColor3 = Color3.fromRGB(42, 42, 42), TextWrapped = true, ZIndex = 2 })
			I[21] = new("TextLabel", I[20], "TEXT", { BackgroundColor3 = Color3.fromRGB(255, 228, 92), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.06), Size = UDim2.fromScale(1, 1), Text = "Blue Legendary", TextColor3 = Color3.fromRGB(185, 225, 255), TextScaled = true, TextSize = 23, TextStrokeColor3 = Color3.fromRGB(42, 42, 42), TextWrapped = true })
				I[22] = new("UIGradient", I[21], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(214, 214, 214)), ColorSequenceKeypoint.new(0.4658902, Color3.fromRGB(214, 214, 214)), ColorSequenceKeypoint.new(0.4725457, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.6389351, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.6455907, Color3.fromRGB(214, 214, 214)), ColorSequenceKeypoint.new(0.7237936, Color3.fromRGB(214, 214, 214)), ColorSequenceKeypoint.new(0.7321131, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.8202995, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.8336107, Color3.fromRGB(214, 214, 214)), ColorSequenceKeypoint.new(1, Color3.fromRGB(214, 214, 214)) }), Enabled = false, Rotation = 75 })
				I[23] = new("UIStroke", I[21], "UIStroke", { Color = Color3.fromRGB(61, 61, 61), Thickness = 3 })
			I[24] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[25] = new("UIGradient", I[20], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.7254575, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.7287853, Color3.fromRGB(217, 217, 217)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 176, 176)) }), Offset = Vector2.new(0.3, 0), Rotation = 88 })
			I[26] = new("UIStroke", I[20], "UIStroke", { Color = Color3.fromRGB(61, 61, 61), Thickness = 3 })
			I[27] = new("UIStroke", I[20], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(47, 55, 68), Enabled = false, Thickness = 4.5 })
		I[28] = new("ImageButton", I[1], "JellyReroll", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, HoverImageContent = Content.fromUri("rbxassetid://15431515785"), ImageContent = Content.fromUri("rbxassetid://15431515785"), Position = UDim2.fromScale(1.0106018, 0.7160651), Rotation = 15, Size = UDim2.fromScale(0.2557263, 0.1981303), Visible = false, ZIndex = 4 })
			I[29] = new("ObjectValue", I[28], "Slot")
			I[30] = new("StringValue", I[28], "Item")
	return I[1]
end

return build
