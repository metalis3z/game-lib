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
	I[1] = new("ScreenGui", nil, "FestiveLuckyBlock", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_8ec323a68b" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(51, 94, 56), BackgroundTransparency = 0.33, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4999848, 0.5096593), Size = UDim2.fromScale(0.4792192, 0.5547377), Visible = false }, { ["ViralWorkerRef"] = "vw_90dc1490a6" })
			I[3] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(69, 239, 31), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0000001, 0), Size = UDim2.fromScale(1.0000002, 0.1544531) }, { ["ViralWorkerRef"] = "vw_780946cf9d" })
				I[4] = new("ImageButton", I[3], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.9437967, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0873362, 0.877193) }, { ["ViralWorkerRef"] = "vw_d5c91079e8" })
					I[5] = new("TextLabel", I[4], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_0c041c44ad" })
						I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_24b6262b85" }, { "ScreenStroke", "UIStroke" })
						I[7] = new("UIPadding", I[5], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, { ["ViralWorkerRef"] = "vw_fce0a6b688" })
						I[8] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 47 }, { ["ViralWorkerRef"] = "vw_e6513eee9e" })
				I[9] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4534667, 0.4916196), Size = UDim2.fromScale(0.8604637, 0.6212938), Text = "Festive Lucky Block", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_84ac425395" })
					I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_9409b8981e" }, { "ScreenStroke", "UIStroke" })
					I[11] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 69 }, { ["ViralWorkerRef"] = "vw_a2294f57cb" })
			I[12] = new("Frame", I[2], "Mid", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5172504), Size = UDim2.fromScale(0.2157691, 0.3257441) }, { ["ViralWorkerRef"] = "vw_bdb06e1dd6" })
				I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 2 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_fcb6fed2a7" }, { "ScreenStroke", "UIStroke" })
				I[14] = new("TextLabel", I[12], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.838), Size = UDim2.fromScale(0.9047543, 0.310953), Text = "Festive Lucky Block", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 }, { ["ViralWorkerRef"] = "vw_f3bfc869cd" })
					I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_06703a4b35" }, { "ScreenStroke", "UIStroke" })
				I[16] = new("ViewportFrame", I[12], "ViewportFrame", { Ambient = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.98, 0.98) }, { ["ViralWorkerRef"] = "vw_bac35118bb" })
			I[17] = new("TextLabel", I[2], "Subtitle", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0224428, 0.1821384), RichText = true, Size = UDim2.fromScale(0.9650223, 0.1510124), Text = "Collect <font color=\"rgb(255, 64, 64)\">300 Candy Canes</font> to spawn a\n<font color=\"rgb(60, 255, 0)\">Festive Lucky Block</font>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_a6c97ecb68" })
				I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_ffc9b22d59" }, { "ScreenStroke", "UIStroke" })
			I[19] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.5 }, { ["ViralWorkerRef"] = "vw_551476a8d4" })
			I[20] = new("ImageLabel", I[2], "Vec1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://139221104786781"), Position = UDim2.fromScale(0.844766, 0.7178279), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.245116, 0.3244061) }, { ["ViralWorkerRef"] = "vw_17088b5487" })
			I[21] = new("Frame", I[2], "Progress", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5000001, 0.7714996), Size = UDim2.fromScale(0.8, 0.0827497) }, { ["ViralWorkerRef"] = "vw_04e6726778" })
				I[22] = new("Frame", I[21], "Fill", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 64, 64), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0, 1) }, { ["ViralWorkerRef"] = "vw_4f20c492b4" })
				I[23] = new("TextLabel", I[21], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "0/500", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_421276e36d" })
					I[24] = new("UIStroke", I[23], "UIStroke", { Thickness = 2 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_2c36a6840e" }, { "ScreenStroke", "UIStroke" })
			I[25] = new("ImageLabel", I[2], "Vec2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81083444361233"), Position = UDim2.fromScale(0.0228564, 0.6567057), Rotation = -20, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1334827, 0.1986504) }, { ["ViralWorkerRef"] = "vw_8065aa7fe4" })
			I[26] = new("ImageButton", I[2], "Spawn", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(81, 158, 86), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.9), Size = UDim2.fromScale(0.281, 0.108) }, { ["ViralWorkerRef"] = "vw_13e23ef532" })
				I[27] = new("UIStroke", I[26], "UIStroke", { Thickness = 2 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_3dfe030266" }, { "ScreenStroke", "UIStroke" })
				I[28] = new("TextLabel", I[26], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "Spawn", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_756cc40180" })
					I[29] = new("UIStroke", I[28], "UIStroke", { Thickness = 2.5 }, { ["OriginalThickness"] = 2.5, ["ViralWorkerRef"] = "vw_fdc61b6d8f" }, { "ScreenStroke", "UIStroke" })
	return I[1]
end

return build
