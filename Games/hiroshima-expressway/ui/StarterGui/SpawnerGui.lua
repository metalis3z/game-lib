-- Generated from ui/StarterGui/SpawnerGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SpawnerGui", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Window", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.75), Visible = false })
			I[3] = new("UIGradient", I[2], "UIGradient", { Rotation = 60, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4009962, 0.1125), NumberSequenceKeypoint.new(0.7372354, 0.1875), NumberSequenceKeypoint.new(1, 0.21875) }) })
			I[4] = new("UICorner", I[2], "UICorner")
			I[5] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(50, 25), RichText = true, Size = UDim2.new(0.25, 0, 0, 50), Text = "SPAWNER", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 30, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[6] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 40, MinTextSize = 10 })
			I[7] = new("ScrollingFrame", I[2], "List", { Active = true, AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), ScrollBarImageColor3 = Color3.fromRGB(50, 50, 50), Size = UDim2.new(1, 0, 1, -100), Visible = false })
				I[8] = new("TextButton", I[7], "Template", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(0.95, 0, 0, 125), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, Visible = false })
					I[9] = new("ViewportFrame", I[8], "ViewportFrame", { Ambient = Color3.fromRGB(255, 255, 255), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LightColor = Color3.fromRGB(0, 0, 0), Position = UDim2.fromOffset(25, 0), Size = UDim2.new(0, 200, 1, 0) })
					I[10] = new("TextLabel", I[8], "VehicleName", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -25, 0.5, 0), RichText = true, Size = UDim2.new(1, -300, 0.5, 0), Text = "1999 AQBCAS (FD154)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[11] = new("UITextSizeConstraint", I[10], "UITextSizeConstraint", { MaxTextSize = 50 })
					I[12] = new("UICorner", I[8], "UICorner")
					I[13] = new("Frame", I[8], "Border", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.new(0, 250, 0.5, 0), Size = UDim2.new(0, 1, 0.9, 0) })
					I[14] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 125, 125)) }), Rotation = 90 })
				I[15] = new("Frame", I[7], "CategoryHeader", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 75), Visible = false })
					I[16] = new("TextLabel", I[15], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.5, 1), Text = "CATEGORY_NAME", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 25 })
					I[17] = new("Frame", I[15], "RightBorder", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.95, 0.5), Size = UDim2.new(0.2, 0, 0, 1) })
					I[18] = new("Frame", I[15], "LeftBorder", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.05, 0.5), Size = UDim2.new(0.2, 0, 0, 1) })
			I[19] = new("Frame", I[2], "Cooldown", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(0.25, 50, 0.074596, 0), Size = UDim2.new(0.1, 0, 0, 50), Visible = false })
				I[20] = new("UIAspectRatioConstraint", I[19], "UIAspectRatioConstraint")
				I[21] = new("Frame", I[19], "Flash", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 127, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.5, 1.5), Visible = false, ZIndex = 0 })
					I[22] = new("UICorner", I[21], "UICorner")
				I[23] = new("ImageLabel", I[19], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://9901920982"), Size = UDim2.fromScale(1, 1) })
				I[24] = new("Frame", I[19], "Frame2", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.5, 1) })
					I[25] = new("ImageLabel", I[24], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://3587367081"), Position = UDim2.fromScale(-1, 0), Size = UDim2.fromScale(2, 1) })
						I[26] = new("UIGradient", I[25], "UIGradient", { Rotation = 180, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(0.501, 1), NumberSequenceKeypoint.new(1, 1) }) })
				I[27] = new("Frame", I[19], "Frame1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(0.5, 1) })
					I[28] = new("ImageLabel", I[27], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://3587367081"), Size = UDim2.fromScale(2, 1) })
						I[29] = new("UIGradient", I[28], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(0.501, 1), NumberSequenceKeypoint.new(1, 1) }) })
			I[30] = new("ImageLabel", I[2], "FortuneLogo", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://8037604757"), Position = UDim2.new(1, -50, 0, 25), Size = UDim2.fromOffset(50, 50) })
				I[31] = new("UIAspectRatioConstraint", I[30], "UIAspectRatioConstraint")
			I[32] = new("ScrollingFrame", I[2], "Grid", { Active = true, AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromOffset(0, 1650), Position = UDim2.fromScale(0, 1), ScrollBarImageColor3 = Color3.fromRGB(50, 50, 50), ScrollBarThickness = 0, Size = UDim2.new(1, 0, 1, -100), Visible = false })
				I[33] = new("TextButton", I[32], "Template", { BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(50, 0), Size = UDim2.new(0.25, -100, 0, 150), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, Visible = false })
					I[34] = new("ViewportFrame", I[33], "ViewportFrame", { Ambient = Color3.fromRGB(255, 255, 255), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LightColor = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(1, 0.75) })
					I[35] = new("TextLabel", I[33], "VehicleName", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.975), RichText = true, Size = UDim2.fromScale(0.75, 0.15), Text = "1999 AQBCAS (FD154)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[36] = new("UITextSizeConstraint", I[35], "UITextSizeConstraint", { MaxTextSize = 50 })
					I[37] = new("Frame", I[33], "Border", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.8), Size = UDim2.new(0.9, 0, 0, 1) })
					I[38] = new("UIGradient", I[33], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 125, 125)) }), Rotation = 90 })
					I[39] = new("UICorner", I[33], "UICorner")
				I[40] = new("Frame", I[32], "CategoryHeader", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 75), Visible = false })
					I[41] = new("TextLabel", I[40], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.5, 1), Text = "CATEGORY_NAME", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 25 })
					I[42] = new("Frame", I[40], "RightBorder", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.95, 0.5), Size = UDim2.new(0.2, 0, 0, 1) })
					I[43] = new("Frame", I[40], "LeftBorder", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.05, 0.5), Size = UDim2.new(0.2, 0, 0, 1) })
			I[44] = new("Frame", I[2], "Sort", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(1, -150, 0, 25), Size = UDim2.fromOffset(100, 50) })
				I[45] = new("Frame", I[44], "Grid", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.5, 1) })
					I[46] = new("TextButton", I[45], "Button", { BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-1, 0), Size = UDim2.fromScale(2, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
						I[47] = new("UICorner", I[46], "UICorner")
						I[48] = new("UIGradient", I[46], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 125, 125)) }), Rotation = 90 })
						I[49] = new("ImageLabel", I[46], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://89587005204514"), Position = UDim2.fromScale(0.75, 0.5), Size = UDim2.fromScale(0.5, 0.65) })
							I[50] = new("UIAspectRatioConstraint", I[49], "UIAspectRatioConstraint")
				I[51] = new("Frame", I[44], "List", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(0.5, 1) })
					I[52] = new("TextButton", I[51], "Button", { BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(2, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
						I[53] = new("UIGradient", I[52], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 125, 125)) }), Rotation = 90 })
						I[54] = new("ImageLabel", I[52], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112755708545769"), Position = UDim2.fromScale(0.25, 0.5), Size = UDim2.fromScale(0.5, 0.7) })
							I[55] = new("UIAspectRatioConstraint", I[54], "UIAspectRatioConstraint")
						I[56] = new("UICorner", I[52], "UICorner")
			I[57] = new("TextLabel", I[2], "AccessDenied", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(200, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0, 100), Size = UDim2.new(0.5, 0, 0, 50), Text = "ACCESS DENIED", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextWrapped = true, Visible = false })
				I[58] = new("UICorner", I[57], "UICorner")
	return I[1]
end

return build
