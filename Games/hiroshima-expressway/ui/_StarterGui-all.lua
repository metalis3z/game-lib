-- Generated from ui/_StarterGui-all.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SpectateGui")
		I[2] = new("Frame", I[1], "Bar", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderSizePixel = 5, Position = UDim2.new(-1, -100, 0.88, -50), Size = UDim2.fromOffset(200, 50) })
			I[3] = new("TextButton", I[2], "Previous", { BackgroundColor3 = Color3.fromRGB(134, 134, 134), BorderColor3 = Color3.fromRGB(130, 203, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(0.25, 1), Text = "<", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 48 })
			I[4] = new("TextButton", I[2], "Next", { BackgroundColor3 = Color3.fromRGB(134, 134, 134), BorderColor3 = Color3.fromRGB(130, 203, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(-0.25, 1), Text = ">", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 48 })
			I[5] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.275, 0), Size = UDim2.fromScale(0.45, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[6] = new("ImageButton", I[1], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 5, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=176106970"), Position = UDim2.new(0, 0, 0.5, -25), Size = UDim2.fromOffset(50, 50) })
	I[7] = new("ScreenGui", nil, "SpawnerGui", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[8] = new("Frame", I[7], "Window", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.75), Visible = false })
			I[9] = new("UIGradient", I[8], "UIGradient", { Rotation = 60, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4009962, 0.1125), NumberSequenceKeypoint.new(0.7372354, 0.1875), NumberSequenceKeypoint.new(1, 0.21875) }) })
			I[10] = new("UICorner", I[8], "UICorner")
			I[11] = new("TextLabel", I[8], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(50, 25), RichText = true, Size = UDim2.new(0.25, 0, 0, 50), Text = "SPAWNER", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 30, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[12] = new("UITextSizeConstraint", I[11], "UITextSizeConstraint", { MaxTextSize = 40, MinTextSize = 10 })
			I[13] = new("ScrollingFrame", I[8], "List", { Active = true, AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), ScrollBarImageColor3 = Color3.fromRGB(50, 50, 50), Size = UDim2.new(1, 0, 1, -100), Visible = false })
				I[14] = new("TextButton", I[13], "Template", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(0.95, 0, 0, 125), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, Visible = false })
					I[15] = new("ViewportFrame", I[14], "ViewportFrame", { Ambient = Color3.fromRGB(255, 255, 255), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LightColor = Color3.fromRGB(0, 0, 0), Position = UDim2.fromOffset(25, 0), Size = UDim2.new(0, 200, 1, 0) })
					I[16] = new("TextLabel", I[14], "VehicleName", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -25, 0.5, 0), RichText = true, Size = UDim2.new(1, -300, 0.5, 0), Text = "1999 AQBCAS (FD154)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[17] = new("UITextSizeConstraint", I[16], "UITextSizeConstraint", { MaxTextSize = 50 })
					I[18] = new("UICorner", I[14], "UICorner")
					I[19] = new("Frame", I[14], "Border", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.new(0, 250, 0.5, 0), Size = UDim2.new(0, 1, 0.9, 0) })
					I[20] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 125, 125)) }), Rotation = 90 })
				I[21] = new("Frame", I[13], "CategoryHeader", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 75), Visible = false })
					I[22] = new("TextLabel", I[21], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.5, 1), Text = "CATEGORY_NAME", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 25 })
					I[23] = new("Frame", I[21], "RightBorder", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.95, 0.5), Size = UDim2.new(0.2, 0, 0, 1) })
					I[24] = new("Frame", I[21], "LeftBorder", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.05, 0.5), Size = UDim2.new(0.2, 0, 0, 1) })
			I[25] = new("Frame", I[8], "Cooldown", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(0.25, 50, 0.074596, 0), Size = UDim2.new(0.1, 0, 0, 50), Visible = false })
				I[26] = new("UIAspectRatioConstraint", I[25], "UIAspectRatioConstraint")
				I[27] = new("Frame", I[25], "Flash", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 127, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.5, 1.5), Visible = false, ZIndex = 0 })
					I[28] = new("UICorner", I[27], "UICorner")
				I[29] = new("ImageLabel", I[25], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://9901920982"), Size = UDim2.fromScale(1, 1) })
				I[30] = new("Frame", I[25], "Frame2", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.5, 1) })
					I[31] = new("ImageLabel", I[30], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://3587367081"), Position = UDim2.fromScale(-1, 0), Size = UDim2.fromScale(2, 1) })
						I[32] = new("UIGradient", I[31], "UIGradient", { Rotation = 180, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(0.501, 1), NumberSequenceKeypoint.new(1, 1) }) })
				I[33] = new("Frame", I[25], "Frame1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(0.5, 1) })
					I[34] = new("ImageLabel", I[33], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://3587367081"), Size = UDim2.fromScale(2, 1) })
						I[35] = new("UIGradient", I[34], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(0.501, 1), NumberSequenceKeypoint.new(1, 1) }) })
			I[36] = new("ImageLabel", I[8], "FortuneLogo", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://8037604757"), Position = UDim2.new(1, -50, 0, 25), Size = UDim2.fromOffset(50, 50) })
				I[37] = new("UIAspectRatioConstraint", I[36], "UIAspectRatioConstraint")
			I[38] = new("ScrollingFrame", I[8], "Grid", { Active = true, AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromOffset(0, 1650), Position = UDim2.fromScale(0, 1), ScrollBarImageColor3 = Color3.fromRGB(50, 50, 50), ScrollBarThickness = 0, Size = UDim2.new(1, 0, 1, -100), Visible = false })
				I[39] = new("TextButton", I[38], "Template", { BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(50, 0), Size = UDim2.new(0.25, -100, 0, 150), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, Visible = false })
					I[40] = new("ViewportFrame", I[39], "ViewportFrame", { Ambient = Color3.fromRGB(255, 255, 255), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LightColor = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(1, 0.75) })
					I[41] = new("TextLabel", I[39], "VehicleName", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.975), RichText = true, Size = UDim2.fromScale(0.75, 0.15), Text = "1999 AQBCAS (FD154)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[42] = new("UITextSizeConstraint", I[41], "UITextSizeConstraint", { MaxTextSize = 50 })
					I[43] = new("Frame", I[39], "Border", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.8), Size = UDim2.new(0.9, 0, 0, 1) })
					I[44] = new("UIGradient", I[39], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 125, 125)) }), Rotation = 90 })
					I[45] = new("UICorner", I[39], "UICorner")
				I[46] = new("Frame", I[38], "CategoryHeader", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 75), Visible = false })
					I[47] = new("TextLabel", I[46], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.5, 1), Text = "CATEGORY_NAME", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 25 })
					I[48] = new("Frame", I[46], "RightBorder", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.95, 0.5), Size = UDim2.new(0.2, 0, 0, 1) })
					I[49] = new("Frame", I[46], "LeftBorder", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.05, 0.5), Size = UDim2.new(0.2, 0, 0, 1) })
			I[50] = new("Frame", I[8], "Sort", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(1, -150, 0, 25), Size = UDim2.fromOffset(100, 50) })
				I[51] = new("Frame", I[50], "Grid", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.5, 1) })
					I[52] = new("TextButton", I[51], "Button", { BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-1, 0), Size = UDim2.fromScale(2, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
						I[53] = new("UICorner", I[52], "UICorner")
						I[54] = new("UIGradient", I[52], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 125, 125)) }), Rotation = 90 })
						I[55] = new("ImageLabel", I[52], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://89587005204514"), Position = UDim2.fromScale(0.75, 0.5), Size = UDim2.fromScale(0.5, 0.65) })
							I[56] = new("UIAspectRatioConstraint", I[55], "UIAspectRatioConstraint")
				I[57] = new("Frame", I[50], "List", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(0.5, 1) })
					I[58] = new("TextButton", I[57], "Button", { BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(2, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
						I[59] = new("UIGradient", I[58], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 125, 125)) }), Rotation = 90 })
						I[60] = new("ImageLabel", I[58], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112755708545769"), Position = UDim2.fromScale(0.25, 0.5), Size = UDim2.fromScale(0.5, 0.7) })
							I[61] = new("UIAspectRatioConstraint", I[60], "UIAspectRatioConstraint")
						I[62] = new("UICorner", I[58], "UICorner")
			I[63] = new("TextLabel", I[8], "AccessDenied", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(200, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0, 100), Size = UDim2.new(0.5, 0, 0, 50), Text = "ACCESS DENIED", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextWrapped = true, Visible = false })
				I[64] = new("UICorner", I[63], "UICorner")
	I[65] = new("ScreenGui", nil, "ShadowToggleGUI", { ResetOnSpawn = false })
		I[66] = new("TextButton", I[65], "ToggleButton", { BackgroundColor3 = Color3.fromRGB(45, 45, 45), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 0.9710425, -25), Size = UDim2.fromOffset(160, 40), Text = "Shadows: ON", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16, TextWrapped = true })
	return { I[1], I[7], I[65] }
end

return build
