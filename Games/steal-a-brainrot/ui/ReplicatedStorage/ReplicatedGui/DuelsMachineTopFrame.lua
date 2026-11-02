-- Generated from ui/ReplicatedStorage/ReplicatedGui/DuelsMachineTopFrame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "DuelsMachineTopFrame", { DisplayOrder = 11, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_a262a77420" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "DuelsMachineTopFrame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.01), Size = UDim2.fromScale(0.4517423, 0.1132074), Visible = false }, { ["ViralWorkerRef"] = "vw_004b819189" })
			I[3] = new("Frame", I[2], "Blue", { BackgroundColor3 = Color3.fromRGB(0, 145, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.1437529, 0.1520693), Size = UDim2.fromScale(0.2421265, 0.6958614) }, { ["ViralWorkerRef"] = "vw_20230e3941" })
				I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_2de7b07cbc" }, { "ScreenStroke", "UIStroke" })
				I[5] = new("ImageLabel", I[3], "Player", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=2678001507&w=100&h=100"), Position = UDim2.fromScale(0.6, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.357, 0.8719999) }, { ["ViralWorkerRef"] = "vw_240c90ba30" })
				I[6] = new("TextLabel", I[3], "Label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0210754, 0.2106518), Size = UDim2.fromScale(0.5652252, 0.6717011), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_3405aef9ac" })
					I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_b4daf16b92" }, { "ScreenStroke", "UIStroke" })
				I[8] = new("ImageLabel", I[3], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://120184993966928"), Position = UDim2.fromScale(0.6486031, 0.724043), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.5477579, 0.5477578), ZIndex = 20 }, { ["ViralWorkerRef"] = "vw_19f8cd95f6" })
			I[9] = new("Frame", I[2], "Red", { BackgroundColor3 = Color3.fromRGB(255, 0, 4), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.6248591, 0.1520693), Size = UDim2.fromScale(0.242, 0.696) }, { ["ViralWorkerRef"] = "vw_ad6859cd70" })
				I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_c51f99ddd8" }, { "ScreenStroke", "UIStroke" })
				I[11] = new("ImageLabel", I[9], "Player", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=2678001507&w=100&h=100"), Position = UDim2.fromScale(0.04, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3569319, 0.8724999) }, { ["ViralWorkerRef"] = "vw_4e9363d29f" })
				I[12] = new("TextLabel", I[9], "Label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4060754, 0.199), Size = UDim2.fromScale(0.5652252, 0.6717011), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_49f1a18125" })
					I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_d8cd5cb7c2" }, { "ScreenStroke", "UIStroke" })
				I[14] = new("ImageLabel", I[9], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://132603130603934"), Position = UDim2.fromScale(0.3486031, 0.724043), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.5477579, 0.5477578), ZIndex = 20 }, { ["ViralWorkerRef"] = "vw_0897a4d4e0" })
			I[15] = new("UIListLayout", I[2], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.04, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["ViralWorkerRef"] = "vw_a137d769cf" })
			I[16] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 7.0903411 }, { ["ViralWorkerRef"] = "vw_cc9c167c02" })
			I[17] = new("Frame", I[2], "Timer", { BackgroundColor3 = Color3.fromRGB(121, 121, 121), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.4143417, 0.2519225), Size = UDim2.fromScale(0.1713167, 0.5141422) }, { ["ViralWorkerRef"] = "vw_e4a3f2c935" })
				I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_4934e1cf63" }, { "ScreenStroke", "UIStroke" })
				I[19] = new("TextLabel", I[17], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "1:24", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_93dbabbd2b" })
					I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_acadf6816c" }, { "ScreenStroke", "UIStroke" })
					I[21] = new("UITextSizeConstraint", I[19], "UITextSizeConstraint", { MaxTextSize = 57 }, { ["ViralWorkerRef"] = "vw_bd67defa23" })
		I[22] = new("TextLabel", I[1], "Tip", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.21734, 0.1315105), Size = UDim2.fromScale(0.5652251, 0.0331496), Text = "first to 3 wins!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_0084104a15" })
			I[23] = new("UIStroke", I[22], "UIStroke", { Thickness = 1.6638889, Transparency = 1 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_fc17196acd" }, { "ScreenStroke", "UIStroke" })
	return I[1]
end

return build
