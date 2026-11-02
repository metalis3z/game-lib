-- Generated from ui/StarterGui/CameraSystem.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CameraSystem", { DisplayOrder = 2, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Folder", I[1], "CameraEffects")
			I[3] = new("ImageLabel", I[2], "Lines", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=86817076706012"), ImageTransparency = 0.61, Size = UDim2.fromScale(1, 1), Visible = false })
			I[4] = new("Frame", I[2], "TransitionFrame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3 })
				I[5] = new("TextLabel", I[4], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187371840", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.3941606, 0.45), Size = UDim2.fromScale(0.2107709, 0.1), Text = "N0 SIGNAL", TextColor3 = Color3.fromRGB(12, 244, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
			I[6] = new("ImageLabel", I[2], "black", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(79, 55, 38), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageTransparency = 1, Interactable = false, Position = UDim2.fromScale(0.5, 0.5), ResampleMode = Enum.ResamplerMode.Pixelated, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(2, 2), SliceScale = 0, TileSize = UDim2.fromOffset(120, 120), Visible = false, ZIndex = 0 })
				I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint")
				I[8] = new("TextLabel", I[6], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187371840", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), RichText = true, Size = UDim2.fromScale(0.4, 0.15), Text = "NO SIGNAL - REQUIRES FIX", TextColor3 = Color3.fromRGB(253, 255, 241), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 1000 })
					I[9] = new("UITextSizeConstraint", I[8], "UITextSizeConstraint", { MaxTextSize = 32 })
			I[10] = new("ImageLabel", I[2], "static", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(79, 55, 38), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageTransparency = 1, Interactable = false, Position = UDim2.fromScale(0.5, 0.5), ResampleMode = Enum.ResamplerMode.Pixelated, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), SliceScale = 0, TileSize = UDim2.fromOffset(120, 120), ZIndex = 0 })
				I[11] = new("ImageLabel", I[10], "staticframe", { BackgroundColor3 = Color3.fromRGB(28, 28, 40), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(17, 17, 17), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4388380012"), ImageTransparency = 0.95, Position = UDim2.fromScale(0, -0.1), Size = UDim2.fromScale(1, 1.2), Visible = false })
		I[12] = new("Folder", I[1], "Sounds")
			I[13] = new("Sound", I[12], "Static Effect", { Looped = true, Volume = 0.1 })
			I[14] = new("Sound", I[12], "Click", { Volume = 0.1 })
		I[15] = new("Folder", I[1], "Controls")
			I[16] = new("Frame", I[15], "Container", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
				I[17] = new("Frame", I[16], "ButtonsHolder", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.8), Size = UDim2.fromScale(0.3, 0.0573918) })
					I[18] = new("TextButton", I[17], "LeftButton", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Modal = true, Position = UDim2.fromScale(0, 0.0734559), Size = UDim2.fromScale(0.2404718, 1), Text = "<", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[19] = new("UIAspectRatioConstraint", I[18], "UIAspectRatioConstraint")
					I[20] = new("TextButton", I[17], "RightButton", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Modal = true, Position = UDim2.fromScale(1, 0.0734559), Size = UDim2.fromScale(0.2404719, 1), Text = ">", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[21] = new("UIAspectRatioConstraint", I[20], "UIAspectRatioConstraint")
					I[22] = new("TextButton", I[17], "BackButton", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187371840", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Modal = true, Position = UDim2.fromScale(0.2504054, 1.7094445), Size = UDim2.fromScale(0.4943217, 0.8127913), Text = "EXIT", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[23] = new("TextLabel", I[17], "CurrentCam", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187371840", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.8), Text = "CAM", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
	return I[1]
end

return build
