-- Generated from ui/StarterGui/Minigame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Minigame", { DisplayOrder = 2, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.75) })
			I[3] = new("UIStroke", I[2], "UIStroke", { Enabled = false })
		I[4] = new("Folder", I[1], "Folder")
			I[5] = new("ImageButton", I[4], "Template", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.278, 0.3049451), Selectable = false, Size = UDim2.fromScale(0.15, 0.15), Visible = false, ZIndex = 2 }, { ["Static"] = true })
				I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint")
				I[7] = new("ImageLabel", I[5], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://76833679466645"), Position = UDim2.fromScale(0.6085591, 0.684968), Rotation = -20, Size = UDim2.fromScale(0.65, 0.6850536) })
				I[8] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
				I[9] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 5 })
			I[10] = new("ImageButton", I[4], "Empty", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Interactable = false, Position = UDim2.fromScale(0.278, 0.3049451), Selectable = false, Size = UDim2.fromScale(0.15, 0.15), Visible = false }, { ["Static"] = true })
				I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint")
				I[12] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
				I[13] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.5 })
			I[14] = new("Frame", I[4], "Warning", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Interactable = false, Position = UDim2.fromScale(0.278, 0.3049451), Size = UDim2.fromScale(0.075, 0.15), Visible = false, ZIndex = 0 })
				I[15] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint")
				I[16] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
				I[17] = new("TextLabel", I[14], "label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "!", TextColor3 = Color3.fromRGB(255, 38, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[18] = new("ImageButton", I[4], "Coin", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.278, 0.3049451), ResampleMode = Enum.ResamplerMode.Pixelated, Selectable = false, Size = UDim2.fromScale(0.15, 0.15), Visible = false, ZIndex = 2 }, { ["Static"] = true })
				I[19] = new("UIAspectRatioConstraint", I[18], "UIAspectRatioConstraint")
				I[20] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
				I[21] = new("UIStroke", I[18], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 5 })
				I[22] = new("UIGradient", I[18], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 182, 30)) }), Rotation = 90 })
				I[23] = new("ImageLabel", I[18], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17324051134"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.65, 0.6850536) })
			I[24] = new("ImageButton", I[4], "GoldNoCoin", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 226, 40), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.278, 0.3049451), ResampleMode = Enum.ResamplerMode.Pixelated, Selectable = false, Size = UDim2.fromScale(0.15, 0.15), Visible = false, ZIndex = 2 }, { ["Static"] = true })
				I[25] = new("UIAspectRatioConstraint", I[24], "UIAspectRatioConstraint")
				I[26] = new("ImageLabel", I[24], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://76833679466645"), Position = UDim2.fromScale(0.6085591, 0.684968), Rotation = -20, Size = UDim2.fromScale(0.65, 0.6850536) })
				I[27] = new("UICorner", I[24], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
				I[28] = new("UIStroke", I[24], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 5 })
				I[29] = new("UIGradient", I[24], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 182, 30)) }), Rotation = 90 })
			I[30] = new("ImageButton", I[4], "Danger", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.278, 0.3049451), Selectable = false, Size = UDim2.fromScale(0.15, 0.15), Visible = false, ZIndex = 2 }, { ["Static"] = true })
				I[31] = new("UIAspectRatioConstraint", I[30], "UIAspectRatioConstraint")
				I[32] = new("ImageLabel", I[30], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://2766332187"), Position = UDim2.fromScale(0.4978171, 0.4930153), Size = UDim2.fromScale(0.65, 0.6850536) })
					I[33] = new("UIAspectRatioConstraint", I[32], "UIAspectRatioConstraint")
					I[34] = new("Decal", I[32], "Skull", { TextureContent = Content.fromUri("rbxassetid://184046145") })
					I[35] = new("Decal", I[32], "skull", { TextureContent = Content.fromUri("rbxassetid://2766332187") })
				I[36] = new("UICorner", I[30], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
				I[37] = new("UIStroke", I[30], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 5 })
		I[38] = new("TextLabel", I[1], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187371840", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.2, 0.075), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[39] = new("UITextSizeConstraint", I[38], "UITextSizeConstraint", { MaxTextSize = 32 }, { ["Max"] = 16 })
			I[40] = new("UIStroke", I[38], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
		I[41] = new("TextLabel", I[1], "strikes", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.225), RichText = true, Size = UDim2.fromScale(0.2, 0.075), Text = "", TextColor3 = Color3.fromRGB(255, 38, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[42] = new("UITextSizeConstraint", I[41], "UITextSizeConstraint", { MaxTextSize = 48 })
			I[43] = new("UIStroke", I[41], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
		I[44] = new("TextButton", I[1], "UnlockMouse", { Active = false, AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, Visible = false, ZIndex = -100000000 })
		I[45] = new("TextButton", I[1], "Exit", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187371840", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4825258, 0.9362324), Size = UDim2.fromScale(0.1456323, 0.0406093), Text = "EXIT", TextColor3 = Color3.fromRGB(0, 249, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
			I[46] = new("UIStroke", I[45], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(0, 249, 0), LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 2 }, nil, { "ScreenStroke" })
			I[47] = new("UIAspectRatioConstraint", I[45], "UIAspectRatioConstraint", { AspectRatio = 5 })
	return I[1]
end

return build
