-- Generated from ui/ReplicatedStorage/ReplicatedGui/FestiveLuckyBlock.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "FestiveLuckyBlock", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "sXzPhRs4sXzP" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(51, 94, 56), BackgroundTransparency = 0.33, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4792192, 0.5547377), Visible = false }, { ["_lemonadeUniqueId"] = "hJqFzEYmhJqF" })
			I[3] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(69, 239, 31), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0000001, 0), Size = UDim2.fromScale(1.0000002, 0.1544531) }, { ["_lemonadeUniqueId"] = "uTW4rl3ZuTW4" })
				I[4] = new("ImageButton", I[3], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.9437967, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0873362, 0.877193) }, { ["_lemonadeUniqueId"] = "B4x6C1LhB4x6" })
					I[5] = new("TextLabel", I[4], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "booySweubooy" })
						I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3.825 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "jIbMnXPPjIbM" }, { "ScreenStroke", "UIStroke" })
						I[7] = new("UIPadding", I[5], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, { ["_lemonadeUniqueId"] = "z506nrlbz506" })
						I[8] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 47 }, { ["_lemonadeUniqueId"] = "pzafsGgspzaf" })
				I[9] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4534667, 0.4916196), Size = UDim2.fromScale(0.8604637, 0.6212938), Text = "Festive Lucky Block", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "VVb6euBDVVb6" })
					I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 3.825 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "xyPMvPmAxyPM" }, { "ScreenStroke", "UIStroke" })
					I[11] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 69 }, { ["_lemonadeUniqueId"] = "gEeS9qXjgEeS" })
			I[12] = new("Frame", I[2], "Mid", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5172504), Size = UDim2.fromScale(0.2157691, 0.3257441) }, { ["_lemonadeUniqueId"] = "QQlVasS2QQlV" })
				I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2.55 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "pDQIpMPBpDQI" }, { "ScreenStroke", "UIStroke" })
					I[14] = new("UIGradient", I[13], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(84, 171, 0)), ColorSequenceKeypoint.new(0.057293, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.2187513, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.2187513, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.369793, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.526043, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.7152791, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.8836819, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(84, 171, 0)) }) }, { ["_lemonadeUniqueId"] = "w3easbL1w3ea" })
				I[15] = new("TextLabel", I[12], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.838), Size = UDim2.fromScale(0.9047543, 0.310953), Text = "Festive Lucky Block", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "fHkCw9bxfHkC" })
					I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 3.825 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "YyhR7pHlYyhR" }, { "ScreenStroke", "UIStroke" })
					I[17] = new("UIGradient", I[15], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(84, 171, 0)), ColorSequenceKeypoint.new(0.057293, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.2187513, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.2187513, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.369793, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.526043, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.7152791, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.8836819, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(84, 171, 0)) }) }, { ["_lemonadeUniqueId"] = "m1bcKtRnm1bc" })
				I[18] = new("ViewportFrame", I[12], "ViewportFrame", { Ambient = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.98, 0.98) }, { ["_lemonadeUniqueId"] = "174f1aiu174f" })
			I[19] = new("TextLabel", I[2], "Subtitle", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0224428, 0.1821384), RichText = true, Size = UDim2.fromScale(0.9650223, 0.1510124), Text = "Collect <font color=\"rgb(255, 64, 64)\">500 Candy Canes</font> to spawn a\n<font color=\"rgb(60, 255, 0)\">Festive Lucky Block</font>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "O16vSaHZO16v" })
				I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 3.825 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "49m66KHN49m6" }, { "ScreenStroke", "UIStroke" })
			I[21] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.5 }, { ["_lemonadeUniqueId"] = "IZ7iaZMiIZ7i" })
			I[22] = new("ImageLabel", I[2], "Vec1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://139221104786781"), Position = UDim2.fromScale(0.844766, 0.7178279), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.245116, 0.3244061) }, { ["_lemonadeUniqueId"] = "p5fFLOsqp5fF" })
			I[23] = new("Frame", I[2], "Progress", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5000001, 0.7714996), Size = UDim2.fromScale(0.8, 0.0827497) }, { ["_lemonadeUniqueId"] = "0ynE7LTb0ynE" })
				I[24] = new("Frame", I[23], "Fill", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 64, 64), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.4, 1) }, { ["_lemonadeUniqueId"] = "19jrjE8I19jr" })
				I[25] = new("TextLabel", I[23], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "120/300", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "tZghCO8otZgh" })
					I[26] = new("UIStroke", I[25], "UIStroke", { Thickness = 2.55 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "pbd6QX2opbd6" }, { "ScreenStroke", "UIStroke" })
			I[27] = new("ImageLabel", I[2], "Vec2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81083444361233"), Position = UDim2.fromScale(0.0228564, 0.6567057), Rotation = -20, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1334827, 0.1986504) }, { ["_lemonadeUniqueId"] = "bBAGGJ0QbBAG" })
			I[28] = new("ImageButton", I[2], "Spawn", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(127, 127, 127), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 1, Interactable = false, Position = UDim2.fromScale(0.5, 0.9), Size = UDim2.fromScale(0.281, 0.108) }, { ["_lemonadeUniqueId"] = "hpehXLVBhpeh" })
				I[29] = new("UIStroke", I[28], "UIStroke", { Thickness = 2.55 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "tmAFoleqtmAF" }, { "ScreenStroke", "UIStroke" })
				I[30] = new("TextLabel", I[28], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "Spawn", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "dz0fNVi2dz0f" })
					I[31] = new("UIStroke", I[30], "UIStroke", { Thickness = 3.1875 }, { ["OriginalThickness"] = 2.5, ["_lemonadeUniqueId"] = "dB6W2VsOdB6W" }, { "ScreenStroke", "UIStroke" })
	return I[1]
end

return build
