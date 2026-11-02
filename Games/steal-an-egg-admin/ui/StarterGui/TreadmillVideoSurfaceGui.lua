-- Generated from ui/StarterGui/TreadmillVideoSurfaceGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "TreadmillVideoSurfaceGui", { ClipsDescendants = true, LightInfluence = 1, MaxDistance = 1000, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "q2FwBMLtq2Fw" })
		I[2] = new("Frame", I[1], "VideoFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "wFqAXFWQwFqA" })
			I[3] = new("Frame", I[2], "Bar", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.01), ZIndex = 3 }, { ["_lemonadeUniqueId"] = "VNfVf7OMVNfV" })
				I[4] = new("Frame", I[3], "Progress", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "BDdOgiqIBDdO" })
			I[5] = new("Frame", I[2], "Loading", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(66, 66, 66), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 4 }, { ["_lemonadeUniqueId"] = "u12YIwIAu12Y" })
				I[6] = new("ImageLabel", I[5], "Spin", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://114843845676955"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.5, 0.25) }, { ["_lemonadeUniqueId"] = "Idt12xw2Idt1" })
			I[7] = new("ImageLabel", I[2], "MusicImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://87443731918082"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "p8bOxaJbp8bO" })
			I[8] = new("VideoFrame", I[2], "MainVideo", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Looped = true, Position = UDim2.fromScale(0.5, 0.5), RollOffMinDistance = 5, Size = UDim2.fromScale(1, 1), Volume = 5, ZIndex = -1 }, { ["_lemonadeUniqueId"] = "WqWJu9mMWqWJ" })
			I[9] = new("Frame", I[2], "Paused", { BackgroundColor3 = Color3.fromRGB(39, 25, 49), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 999 }, { ["_lemonadeUniqueId"] = "Paf7q9Y4Paf7" })
				I[10] = new("UIGradient", I[9], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3606558), NumberSequenceKeypoint.new(1, 0) }) }, { ["_lemonadeUniqueId"] = "DAhMKjOIDAhM" })
				I[11] = new("ImageLabel", I[9], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(148, 95, 186), ImageContent = Content.fromUri("rbxassetid://87932556702787"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(3, 0.8) }, { ["_lemonadeUniqueId"] = "3sTJXFFh3sTJ" })
				I[12] = new("ImageLabel", I[9], "StopPlay", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://87443731918082"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.4, 0.2), ZIndex = 3 }, { ["_lemonadeUniqueId"] = "J7EU4rOeJ7EU" })
					I[13] = new("TextLabel", I[12], "EnjoyFree", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, -0.35), Size = UDim2.fromScale(1.8, 0.5), Text = "ENJOY SOME FREE VIDEOS!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "arRgskEkarRg" })
			I[14] = new("ImageLabel", I[2], "StopPlay", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://87443731918082"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.4, 0.2), Visible = false, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "oRH0ArFpoRH0" })
				I[15] = new("TextLabel", I[14], "EnjoyFree", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, -0.35), Size = UDim2.fromScale(1.8, 0.5), Text = "ENJOY SOME FREE VIDEOS!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false }, { ["_lemonadeUniqueId"] = "PjBGBDiQPjBG" })
			I[16] = new("TextLabel", I[2], "VideoCounter", { AnchorPoint = Vector2.new(0, 1), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.02, 0.97), Size = UDim2.fromScale(0.6, 0.035), Text = "TOTAL VIDEOS: 0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 0.35, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 1000 }, { ["_lemonadeUniqueId"] = "fhtbQwqGfhtb" })
			I[17] = new("Frame", I[2], "GoToNext", { BackgroundColor3 = Color3.fromRGB(39, 25, 49), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 999 }, { ["_lemonadeUniqueId"] = "l6yVOwvjl6yV" })
				I[18] = new("UIGradient", I[17], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3606558), NumberSequenceKeypoint.new(1, 0) }) }, { ["_lemonadeUniqueId"] = "IFhsvchJIFhs" })
				I[19] = new("ImageLabel", I[17], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(148, 95, 186), ImageContent = Content.fromUri("rbxassetid://87932556702787"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(3, 0.8) }, { ["_lemonadeUniqueId"] = "R7bkgi8eR7bk" })
				I[20] = new("ImageLabel", I[17], "ArrowShadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://83096918932591"), Position = UDim2.fromScale(0.8, 0.5), Size = UDim2.fromScale(0.2, 0.2) }, { ["_lemonadeUniqueId"] = "zAvvvCvrzAvv" })
					I[21] = new("UIAspectRatioConstraint", I[20], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "Em8TdyssEm8T" })
				I[22] = new("TextLabel", I[17], "LabelShadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4, 0.5), Size = UDim2.fromScale(0.45, 0.1), Text = "TAP FOR NEXT VIDEO", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "Z5NxC464Z5Nx" })
				I[23] = new("TextLabel", I[17], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.4, 0, 0.5, -1), Size = UDim2.fromScale(0.45, 0.1), Text = "TAP FOR NEXT VIDEO", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "JAi3HzZRJAi3" })
				I[24] = new("ImageLabel", I[17], "Arrow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://83096918932591"), Position = UDim2.new(0.8, 0, 0.5, -1), Size = UDim2.fromScale(0.2, 0.2) }, { ["_lemonadeUniqueId"] = "lhRg6faGlhRg" })
					I[25] = new("UIAspectRatioConstraint", I[24], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "koVycg2UkoVy" })
	return I[1]
end

return build
