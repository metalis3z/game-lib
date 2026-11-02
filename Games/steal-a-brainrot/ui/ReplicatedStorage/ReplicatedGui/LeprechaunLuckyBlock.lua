-- Generated from ui/ReplicatedStorage/ReplicatedGui/LeprechaunLuckyBlock.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LeprechaunLuckyBlock", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_05e32dbf1d" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(51, 94, 56), BackgroundTransparency = 0.33, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.51), Size = UDim2.fromScale(0.4792192, 0.5547377), Visible = false }, { ["ViralWorkerRef"] = "vw_7449f632dd" })
			I[3] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(63, 181, 30), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0000001, 0), Size = UDim2.fromScale(1.0000002, 0.1544531) }, { ["ViralWorkerRef"] = "vw_e52a69694c" })
				I[4] = new("ImageButton", I[3], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.9437967, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0873362, 0.877193) }, { ["ViralWorkerRef"] = "vw_5967d21378" })
					I[5] = new("TextLabel", I[4], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_9d096dbd3d" })
						I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 1.8259258 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_e19a1e70d1" }, { "ScreenStroke", "UIStroke" })
						I[7] = new("UIPadding", I[5], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, { ["ViralWorkerRef"] = "vw_6cf17db37c" })
						I[8] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 47 }, { ["ViralWorkerRef"] = "vw_3d727ebc44" })
				I[9] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4534667, 0.4916196), Size = UDim2.fromScale(0.8604637, 0.6212938), Text = "Leprechaun Lucky Block", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_87870657ab" })
					I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 1.8259258 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_ec8cc226c9" }, { "ScreenStroke", "UIStroke" })
					I[11] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 69 }, { ["ViralWorkerRef"] = "vw_54cf6f7c1c" })
				I[12] = new("ImageLabel", I[3], "Vector", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://128380688042747"), Position = UDim2.fromScale(-0.0149739, -0.2676928), Rotation = -6, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1300135, 1.2649645), ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_134dca4e28" })
			I[13] = new("Frame", I[2], "Mid", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5172504), Size = UDim2.fromScale(0.2157691, 0.3257441) }, { ["ViralWorkerRef"] = "vw_0c6a504021" })
				I[14] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(142, 227, 63), Thickness = 1.217284 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_4a4083f8a5" }, { "ScreenStroke", "UIStroke" })
				I[15] = new("TextLabel", I[13], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.838), Size = UDim2.fromScale(0.9047543, 0.310953), Text = "Leprechaun Lucky Block", TextColor3 = Color3.fromRGB(142, 227, 63), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 }, { ["ViralWorkerRef"] = "vw_f012b5cfe8" })
					I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 1.8259258 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_0eff17fc86" }, { "ScreenStroke", "UIStroke" })
				I[17] = new("ViewportFrame", I[13], "ViewportFrame", { Ambient = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.98, 0.98) }, { ["ViralWorkerRef"] = "vw_ebc0bff88e" })
			I[18] = new("TextLabel", I[2], "Subtitle", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0224428, 0.1821384), RichText = true, Size = UDim2.fromScale(0.9650223, 0.1510124), Text = "Collect <font color=\"rgb(255, 204, 1)\">50 Gold Coins</font> to spawn a\n<font color=\"rgb(142, 227, 63)\">Leprechaun Lucky Block</font>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_a755bca46f" })
				I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 1.8259258 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_3570ceab71" }, { "ScreenStroke", "UIStroke" })
			I[20] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.5 }, { ["ViralWorkerRef"] = "vw_f2d66dc957" })
			I[21] = new("ImageLabel", I[2], "Vec1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://111990634835592"), Position = UDim2.fromScale(0.8616937, 0.8447859), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1989494, 0.2389979) }, { ["ViralWorkerRef"] = "vw_78fa1449eb" })
			I[22] = new("Frame", I[2], "Progress", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5000001, 0.7714996), Size = UDim2.fromScale(0.8, 0.0827497) }, { ["ViralWorkerRef"] = "vw_50c7c57edf" })
				I[23] = new("Frame", I[22], "Fill", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 204, 1), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0, 1) }, { ["ViralWorkerRef"] = "vw_cec67d3bf2" })
				I[24] = new("TextLabel", I[22], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "0/50", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_c0f3b9eb0b" })
					I[25] = new("UIStroke", I[24], "UIStroke", { Thickness = 1.217284 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_dbeb86873d" }, { "ScreenStroke", "UIStroke" })
			I[26] = new("ImageLabel", I[2], "Vec2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://116762624882914"), Position = UDim2.fromScale(0.0228564, 0.6913308), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.133, 0.16) }, { ["ViralWorkerRef"] = "vw_d57fa7b153" })
			I[27] = new("ImageButton", I[2], "Spawn", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(127, 127, 127), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 1, Interactable = false, Position = UDim2.fromScale(0.5, 0.9), Size = UDim2.fromScale(0.281, 0.108) }, { ["ViralWorkerRef"] = "vw_3870e44b60" })
				I[28] = new("UIStroke", I[27], "UIStroke", { Thickness = 1.217284 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_c56eecdbdb" }, { "ScreenStroke", "UIStroke" })
				I[29] = new("TextLabel", I[27], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "Spawn", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_2f9ce827e5" })
					I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 1.5216049 }, { ["OriginalThickness"] = 2.5, ["ViralWorkerRef"] = "vw_8b4d775e1d" }, { "ScreenStroke", "UIStroke" })
	return I[1]
end

return build
