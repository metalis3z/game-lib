-- Generated from ui/ReplicatedStorage/ReplicatedGui/TradePrompts.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "TradePrompts", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_df87e3fb9b" }, { "ScreenGui" })
		I[2] = new("ImageLabel", I[1], "Prompt", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.9944771, 0.985081), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.1698942, 0.1375656), SliceCenter = Rect.new(485, 14, 485, 75), Visible = false }, { ["ViralWorkerRef"] = "vw_dc83b00e4d" })
			I[3] = new("TextLabel", I[2], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5008216, 0.1523008), Size = UDim2.fromScale(0.9183587, 0.2144083), Text = "Trade Request", TextColor3 = Color3.fromRGB(186, 149, 223), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_c3436dd134" })
				I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 1.1092592 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_c85c9c1057" }, { "ScreenStroke", "UIStroke" })
			I[5] = new("TextLabel", I[2], "Username", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.507, 0.45), Size = UDim2.fromScale(0.9297194, 0.3222941), Text = "Onlytwentycharacters wants to trade with you", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_d3ea62f1e8" })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 1.1092592 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_d246af93bb" }, { "ScreenStroke", "UIStroke" })
			I[7] = new("ImageButton", I[2], "Yes", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(81, 158, 86), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.04, 0.933), Size = UDim2.fromScale(0.4394761, 0.2736073) }, { ["ViralWorkerRef"] = "vw_be83ac71f0" })
				I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5, ["ViralWorkerRef"] = "vw_1cf6d6df11" }, { "ScreenStroke", "UIStroke" })
				I[9] = new("TextLabel", I[7], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.7), Text = "Accept", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_e32f9f25c4" })
					I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5, ["ViralWorkerRef"] = "vw_ffa582364f" }, { "ScreenStroke", "UIStroke" })
			I[11] = new("ImageButton", I[2], "No", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(233, 66, 66), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.96, 0.933), Size = UDim2.fromScale(0.4394762, 0.2736073) }, { ["ViralWorkerRef"] = "vw_703302129b" })
				I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5, ["ViralWorkerRef"] = "vw_c4e38ff586" }, { "ScreenStroke", "UIStroke" })
				I[13] = new("TextLabel", I[11], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.7), Text = "Decline", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_59edaeef6d" })
					I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5, ["ViralWorkerRef"] = "vw_aed56d4a0f" }, { "ScreenStroke", "UIStroke" })
			I[15] = new("UIStroke", I[2], "UIStroke", { Thickness = 0.5546296 }, { ["OriginalThickness"] = 1, ["ViralWorkerRef"] = "vw_1189ccfa20" }, { "ScreenStroke", "UIStroke" })
			I[16] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }) }, { ["ViralWorkerRef"] = "vw_37b58181d0" })
	return I[1]
end

return build
