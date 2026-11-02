-- Generated from ui/ReplicatedStorage/ReplicatedGui/StockMachine.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "StockMachine", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_a91353fed6" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "StockMachine", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(186, 178, 133), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4999848, 0.55), Size = UDim2.fromScale(0.4792193, 0.6351967), Visible = false }, { ["ViralWorkerRef"] = "vw_49169b6455" })
			I[3] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(224, 187, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0000001, 0), Size = UDim2.fromScale(1.0000002, 0.1544531) }, { ["ViralWorkerRef"] = "vw_5ef4c70a02" })
				I[4] = new("ImageButton", I[3], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.9440019, 0.4566889), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0877465, 0.7905689) }, { ["ViralWorkerRef"] = "vw_2dd292f3eb" })
					I[5] = new("TextLabel", I[4], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4918542, 0.4999999), Size = UDim2.fromScale(0.9171997, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_1f089f2bfd" })
						I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2.8027778 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_246b3e31c4" }, { "ScreenStroke", "UIStroke" })
						I[7] = new("UIPadding", I[5], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, { ["ViralWorkerRef"] = "vw_79f1573345" })
				I[8] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3639, 0.4916192), Size = UDim2.fromScale(0.6813304, 0.7207083), Text = "Limited Quantity Truck", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_0c9bb3aeaa" })
					I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 2.8027778 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_4bae877255" }, { "ScreenStroke", "UIStroke" })
			I[10] = new("Frame", I[2], "Content", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0032605, 0.1542887), Size = UDim2.fromScale(0.9966298, 0.845574) }, { ["ViralWorkerRef"] = "vw_9115332f62" })
				I[11] = new("UIListLayout", I[10], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["ViralWorkerRef"] = "vw_f778efff84" })
				I[12] = new("Frame", I[10], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(39, 37, 28), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.2365217), Size = UDim2.fromScale(0.9153563, 0.4641415), Visible = false }, { ["ViralWorkerRef"] = "vw_9edfc31c55" })
					I[13] = new("UIPadding", I[12], "UIPadding", { PaddingBottom = UDim.new(0.32, 0) }, { ["ViralWorkerRef"] = "vw_3355a869d2" })
					I[14] = new("UIListLayout", I[12], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.04, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom }, { ["ViralWorkerRef"] = "vw_dd29dddabf" })
					I[15] = new("Frame", I[12], "Output", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 5, Position = UDim2.fromScale(0.6133611, 0.5042961), Size = UDim2.fromScale(0.2035514, 0.9174385) }, { ["ViralWorkerRef"] = "vw_95ecd89f33" })
						I[16] = new("ImageButton", I[15], "Spawn", { BackgroundColor3 = Color3.fromRGB(81, 158, 86), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 1, Position = UDim2.fromScale(0, 1.185758), Size = UDim2.fromScale(1, 0.2739441) }, { ["ViralWorkerRef"] = "vw_c56d875f3a" })
							I[17] = new("UIStroke", I[16], "UIStroke", { Thickness = 1.8685185 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_455c3f0110" }, { "ScreenStroke", "UIStroke" })
							I[18] = new("TextLabel", I[16], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "Spawn", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_382ef0aae0" })
								I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 2.3356481 }, { ["OriginalThickness"] = 2.5, ["ViralWorkerRef"] = "vw_788a7691f4" }, { "ScreenStroke", "UIStroke" })
						I[20] = new("UIStroke", I[15], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Thickness = 1.8685185 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_ae40b5e32f" }, { "ScreenStroke", "UIStroke" })
						I[21] = new("TextLabel", I[15], "Quantity", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1.085), Size = UDim2.fromScale(1.1582394, 0.1501555), Text = "5,000,000 Left", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 }, { ["ViralWorkerRef"] = "vw_a23709f477" })
							I[22] = new("UIStroke", I[21], "UIStroke", { Thickness = 1.8685185 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_ed67b72706" }, { "ScreenStroke", "UIStroke" })
						I[23] = new("TextLabel", I[15], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5100803, 0.1743485), Size = UDim2.fromScale(0.8798403, 0.2894168), Text = "Brainrot Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 }, { ["ViralWorkerRef"] = "vw_d7d0422e36" })
							I[24] = new("UIStroke", I[23], "UIStroke", { Thickness = 2.8027778 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_d9dc550be7" }, { "ScreenStroke", "UIStroke" })
						I[25] = new("ViewportFrame", I[15], "ViewportFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["ViralWorkerRef"] = "vw_1056a6159a" })
					I[26] = new("Frame", I[12], "Input", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.2841389, 0.1369203), Size = UDim2.fromScale(0.1867222, 0.8630795), Visible = false }, { ["ViralWorkerRef"] = "vw_68ad35accd" })
						I[27] = new("TextLabel", I[26], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.509531, 0.1743485), Size = UDim2.fromScale(0.8787413, 0.2894168), Text = "Brainrot Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 }, { ["ViralWorkerRef"] = "vw_c53f07fe15" })
							I[28] = new("UIStroke", I[27], "UIStroke", { Thickness = 2.8027778 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_068650de3a" }, { "ScreenStroke", "UIStroke" })
						I[29] = new("ImageButton", I[26], "Return", { BackgroundColor3 = Color3.fromRGB(240, 198, 48), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 1, Position = UDim2.fromScale(0.0083674, 1.0851285), Size = UDim2.fromScale(0.9916336, 0.2728657) }, { ["ViralWorkerRef"] = "vw_05d93c26e4" })
							I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 1.8685185 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_0c813799fe" }, { "ScreenStroke", "UIStroke" })
							I[31] = new("TextLabel", I[29], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "Return", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_898740e83f" })
								I[32] = new("UIStroke", I[31], "UIStroke", { Thickness = 2.3356481 }, { ["OriginalThickness"] = 2.5, ["ViralWorkerRef"] = "vw_0733bbe365" }, { "ScreenStroke", "UIStroke" })
						I[33] = new("UIStroke", I[26], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Thickness = 1.8685185 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_b54f4d9043" }, { "ScreenStroke", "UIStroke" })
						I[34] = new("ViewportFrame", I[26], "ViewportFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["ViralWorkerRef"] = "vw_9c53e6aa25" })
			I[35] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.3437191 }, { ["ViralWorkerRef"] = "vw_e0d4e5f670" })
	return I[1]
end

return build
