-- Generated from ui/ReplicatedStorage/ReplicatedGui/ValentinesGifts.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ValentinesGifts", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_de5129ed6c" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "ValentinesGifts", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.99, 0.98) }, { ["ViralWorkerRef"] = "vw_8297affe3c" })
			I[3] = new("ImageLabel", I[2], "Template", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(244, 154, 220), BackgroundTransparency = 0.35, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.1698942, 0.1375656), SliceCenter = Rect.new(485, 14, 485, 75), Visible = false }, { ["ViralWorkerRef"] = "vw_28b42dad31" })
				I[4] = new("TextLabel", I[3], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.152), Size = UDim2.fromScale(0.93, 0.214), Text = "GIFT RECEIVED", TextColor3 = Color3.fromRGB(244, 102, 190), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_2c7cb985ab" })
					I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 1.1092592 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_57963f1988" }, { "ScreenStroke", "UIStroke" })
				I[6] = new("TextLabel", I[3], "Username", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromScale(0.93, 0.225), Text = "SpyderSammy sent you a gift!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_5c7a0f5ec8" })
					I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 1.1092592 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_16b7c63030" }, { "ScreenStroke", "UIStroke" })
				I[8] = new("ImageButton", I[3], "Yes", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(81, 158, 86), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.04, 0.9), Size = UDim2.fromScale(0.439, 0.3) }, { ["ViralWorkerRef"] = "vw_f9bc36404f" })
					I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5, ["ViralWorkerRef"] = "vw_b671236605" }, { "ScreenStroke", "UIStroke" })
					I[10] = new("TextLabel", I[8], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.7), Text = "OPEN", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_adf0f58487" })
						I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5, ["ViralWorkerRef"] = "vw_9d8467aa5d" }, { "ScreenStroke", "UIStroke" })
				I[12] = new("ImageButton", I[3], "No", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(233, 66, 66), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.96, 0.9), Size = UDim2.fromScale(0.439, 0.3) }, { ["ViralWorkerRef"] = "vw_978a92f6f4" })
					I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5, ["ViralWorkerRef"] = "vw_010e7f29f3" }, { "ScreenStroke", "UIStroke" })
					I[14] = new("TextLabel", I[12], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.7), Text = "CLOSE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_392a534db5" })
						I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5, ["ViralWorkerRef"] = "vw_1456fb9955" }, { "ScreenStroke", "UIStroke" })
				I[16] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 0.5546296 }, { ["OriginalThickness"] = 1, ["ViralWorkerRef"] = "vw_d0ffea8430" }, { "ScreenStroke", "UIStroke" })
				I[17] = new("Frame", I[3], "Fill", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.025) }, { ["ViralWorkerRef"] = "vw_c71b0b5449" })
				I[18] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 2.75 }, { ["ViralWorkerRef"] = "vw_e88b2aea06" })
	return I[1]
end

return build
