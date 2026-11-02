-- Generated from ui/ReplicatedStorage/ReplicatedGui/EggLuckyBlock.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "EggLuckyBlock", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "pVMBdXpRpVMB" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(92, 153, 154), BackgroundTransparency = 0.33, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4792192, 0.5547377), Visible = false }, { ["_lemonadeUniqueId"] = "CvpqxlCSCvpq" })
			I[3] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(111, 255, 248), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0000001, 0), Size = UDim2.fromScale(1.0000002, 0.1544531) }, { ["_lemonadeUniqueId"] = "81ixWO5p81ix" })
				I[4] = new("ImageButton", I[3], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.9437967, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0873362, 0.877193) }, { ["_lemonadeUniqueId"] = "YXnzDFQSYXnz" })
					I[5] = new("TextLabel", I[4], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "FBvtXrBPFBvt" })
						I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3.2 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "ZQcTbGYqZQcT" }, { "ScreenStroke", "UIStroke" })
						I[7] = new("UIPadding", I[5], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, { ["_lemonadeUniqueId"] = "UnmxwdbpUnmx" })
						I[8] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 47 }, { ["_lemonadeUniqueId"] = "SHozBn33SHoz" })
				I[9] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4534667, 0.4916196), Size = UDim2.fromScale(0.8604637, 0.6212938), Text = "Egg Lucky Block", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "heIvGJosheIv" })
					I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 3.2 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "JBcMWkK0JBcM" }, { "ScreenStroke", "UIStroke" })
					I[11] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 69 }, { ["_lemonadeUniqueId"] = "8ICt6OwW8ICt" })
			I[12] = new("Frame", I[2], "Mid", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5172504), Size = UDim2.fromScale(0.2157691, 0.3257441) }, { ["_lemonadeUniqueId"] = "7HJZILsy7HJZ" })
				I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(178, 132, 255), Thickness = 2.1333334 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "ub33g8squb33" }, { "ScreenStroke", "UIStroke" })
				I[14] = new("TextLabel", I[12], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.838), Size = UDim2.fromScale(0.9047543, 0.310953), Text = "Egg Lucky Block", TextColor3 = Color3.fromRGB(178, 132, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "Jt4Wyg0iJt4W" })
					I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 3.2 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "wGzWTE33wGzW" }, { "ScreenStroke", "UIStroke" })
				I[16] = new("ViewportFrame", I[12], "ViewportFrame", { Ambient = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.98, 0.98) }, { ["_lemonadeUniqueId"] = "O1mf9ggsO1mf" })
			I[17] = new("TextLabel", I[2], "Subtitle", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0224428, 0.1821384), RichText = true, Size = UDim2.fromScale(0.9650223, 0.1510124), Text = "Collect <font color=\"rgb(255, 204, 1)\">200 Bunny Coins</font> to spawn a\n<font color=\"rgb(111, 255, 248)\">Egg Lucky Block</font>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "dQiF0uEkdQiF" })
				I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 3.2 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "b46QhGKEb46Q" }, { "ScreenStroke", "UIStroke" })
			I[19] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.5 }, { ["_lemonadeUniqueId"] = "qRNS0yCEqRNS" })
			I[20] = new("Frame", I[2], "Progress", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5000001, 0.7714996), Size = UDim2.fromScale(0.8, 0.0827497) }, { ["_lemonadeUniqueId"] = "iVtLApIkiVtL" })
				I[21] = new("Frame", I[20], "Fill", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 204, 1), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.005, 1) }, { ["_lemonadeUniqueId"] = "y8Is3Npby8Is" })
				I[22] = new("TextLabel", I[20], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "1/200", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "Z183OYOyZ183" })
					I[23] = new("UIStroke", I[22], "UIStroke", { Thickness = 2.1333334 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "9VePaCYs9VeP" }, { "ScreenStroke", "UIStroke" })
			I[24] = new("ImageLabel", I[2], "Vec2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://104580984078313"), Position = UDim2.fromScale(0.0228564, 0.6178173), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.133, 0.2401076) }, { ["_lemonadeUniqueId"] = "YfFlH1qwYfFl" })
			I[25] = new("ImageButton", I[2], "Spawn", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(127, 127, 127), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 1, Interactable = false, Position = UDim2.fromScale(0.5, 0.9), Size = UDim2.fromScale(0.281, 0.108) }, { ["_lemonadeUniqueId"] = "A4C4EgCGA4C4" })
				I[26] = new("UIStroke", I[25], "UIStroke", { Thickness = 2.1333334 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "osPfpanRosPf" }, { "ScreenStroke", "UIStroke" })
				I[27] = new("TextLabel", I[25], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "Spawn", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "Wa7TqyAUWa7T" })
					I[28] = new("UIStroke", I[27], "UIStroke", { Thickness = 2.6666667 }, { ["OriginalThickness"] = 2.5, ["_lemonadeUniqueId"] = "rYllJ5dTrYll" }, { "ScreenStroke", "UIStroke" })
	return I[1]
end

return build
