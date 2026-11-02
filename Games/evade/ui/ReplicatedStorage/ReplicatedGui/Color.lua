-- Generated from ui/ReplicatedStorage/ReplicatedGui/Color.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Color", { DisplayOrder = 999999, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "ScreenGui" })
		I[2] = new("Frame", I[1], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(51, 66, 73), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.2418393, 0.4331976), Visible = false })
			I[3] = new("Frame", I[2], "Content", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.1720144), Size = UDim2.fromScale(1, 0.8262643) })
				I[4] = new("Frame", I[3], "Color", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0342276, -0.1254898), Size = UDim2.fromScale(0.9, 0.9) })
					I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint")
					I[6] = new("TextButton", I[4], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
					I[7] = new("Frame", I[4], "White", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[8] = new("Frame", I[7], "Cursor", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.1, 0.1), ZIndex = 2 })
							I[9] = new("Frame", I[8], "Y", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0, 2, 1, 0) })
							I[10] = new("Frame", I[8], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 0, 0, 2) })
							I[11] = new("UIAspectRatioConstraint", I[8], "UIAspectRatioConstraint")
						I[12] = new("UIGradient", I[7], "UIGradient", { Rotation = 270, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
					I[13] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 1)), ColorSequenceKeypoint.new(0.1666667, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(0.3333333, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 225)), ColorSequenceKeypoint.new(0.6666667, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.8333333, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4806974, 0.29375), NumberSequenceKeypoint.new(1, 0) }) })
				I[14] = new("Frame", I[3], "Value", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.858, -0.125), Size = UDim2.fromScale(0.1, 0.9) })
					I[15] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = 270 })
					I[16] = new("Frame", I[14], "Cursor", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0, 1) })
						I[17] = new("TextButton", I[16], "TextButton", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(10, 10), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
							I[18] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(0, 50), BottomRightRadius = UDim.new(0, 50), TopLeftRadius = UDim.new(0, 50), TopRightRadius = UDim.new(0, 50) })
					I[19] = new("TextButton", I[14], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
			I[20] = new("ImageButton", I[2], "Cancel", { BackgroundColor3 = Color3.fromRGB(119, 12, 12), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(12, 119, 60), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5296829, 0.8698055), Size = UDim2.fromScale(0.341, 0.104) })
				I[21] = new("UIStroke", I[20], "UIStroke", { Color = Color3.fromRGB(49, 0, 0), Thickness = 1.4681481 }, { ["OriginalThickness"] = 2 }, { "ScreenStroke", "UIStroke" })
				I[22] = new("TextLabel", I[20], "Function", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4961075, 0.5000001), Size = UDim2.fromScale(0.8, 0.8), Text = "Cancel", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[23] = new("UIStroke", I[22], "UIStroke", { Color = Color3.fromRGB(56, 0, 0), Thickness = 1.4681481 }, { ["OriginalThickness"] = 2 }, { "ScreenStroke", "UIStroke" })
					I[24] = new("UITextSizeConstraint", I[22], "UITextSizeConstraint", { MaxTextSize = 63 })
			I[25] = new("ImageButton", I[2], "Ok", { BackgroundColor3 = Color3.fromRGB(12, 119, 60), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(12, 119, 60), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.1213466, 0.8703206), Size = UDim2.fromScale(0.3406006, 0.1041577) })
				I[26] = new("UIStroke", I[25], "UIStroke", { Color = Color3.fromRGB(0, 65, 7), Thickness = 1.4681481 }, { ["OriginalThickness"] = 2 }, { "ScreenStroke", "UIStroke" })
				I[27] = new("TextLabel", I[25], "Function", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.4999999), Size = UDim2.fromScale(0.8, 0.8), Text = "OK", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[28] = new("UIStroke", I[27], "UIStroke", { Color = Color3.fromRGB(0, 65, 7), Thickness = 1.4681481 }, { ["OriginalThickness"] = 2 }, { "ScreenStroke", "UIStroke" })
					I[29] = new("UITextSizeConstraint", I[27], "UITextSizeConstraint", { MaxTextSize = 63 })
	return I[1]
end

return build
