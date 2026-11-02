-- Generated from ui/ReplicatedStorage/ReplicatedGui/TopUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "TopUI", { DisplayOrder = 5, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_08e1f14c47" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["ViralWorkerRef"] = "vw_96c0315c7b" })
			I[3] = new("Frame", I[2], "Poll", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.6, 0.175), Visible = false, ZIndex = 5 }, { ["ViralWorkerRef"] = "vw_db0f9e5ef4" })
				I[4] = new("TextLabel", I[3], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.2200298), RichText = true, Size = UDim2.fromScale(1, 0.2599403), Text = "W update? (15s)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_bb2e4314b6" })
					I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_d34a583d25" }, { "ScreenStroke", "UIStroke" })
				I[6] = new("Frame", I[3], "Buttons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.85), Size = UDim2.fromScale(0.45, 0.275), ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_484dcdb96e" })
					I[7] = new("UIListLayout", I[6], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, HorizontalFlex = Enum.UIFlexAlignment.Fill, Padding = UDim.new(0, 24), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["ViralWorkerRef"] = "vw_9064d4b8f7" })
					I[8] = new("ImageButton", I[6], "1", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(33, 151, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(80, 158, 87), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.282411, 1.0000001), Size = UDim2.fromScale(0.2833, 1) }, { ["ViralWorkerRef"] = "vw_f4bc431b22" })
						I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 1.7193518 }, { ["OriginalThickness"] = 3.0999999, ["ViralWorkerRef"] = "vw_1af0af4a1a" }, { "ScreenStroke", "UIStroke" })
						I[10] = new("TextLabel", I[8], "Function", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.4999999), Size = UDim2.fromScale(0.75, 0.75), Text = "Yes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_7f56cf51ba" })
							I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_8ce73cf04e" }, { "ScreenStroke", "UIStroke" })
						I[12] = new("Frame", I[8], "Disabled", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["ViralWorkerRef"] = "vw_10ea439771" })
					I[13] = new("ImageButton", I[6], "2", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(218, 38, 26), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(80, 158, 87), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.282411, 1.0000001), Size = UDim2.fromScale(0.2833, 1) }, { ["ViralWorkerRef"] = "vw_23932aad4d" })
						I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 1.7193518 }, { ["OriginalThickness"] = 3.0999999, ["ViralWorkerRef"] = "vw_c6894f9fcf" }, { "ScreenStroke", "UIStroke" })
						I[15] = new("TextLabel", I[13], "Function", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.4999999), Size = UDim2.fromScale(0.75, 0.75), Text = "No", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_880a54afdc" })
							I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_44093a485b" }, { "ScreenStroke", "UIStroke" })
						I[17] = new("Frame", I[13], "Disabled", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["ViralWorkerRef"] = "vw_7ca75ddc6d" })
				I[18] = new("Frame", I[3], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(218, 38, 26), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.515), Size = UDim2.fromScale(0.6, 0.15), ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_1f69b22086" })
					I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 1.7193518 }, { ["OriginalThickness"] = 3.0999999, ["ViralWorkerRef"] = "vw_24f18186d8" }, { "ScreenStroke", "UIStroke" })
					I[20] = new("Frame", I[18], "Fill", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = -10 }, { ["ViralWorkerRef"] = "vw_8be8d7119d" })
						I[21] = new("UIGradient", I[20], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(33, 151, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(33, 151, 255)) }), Offset = Vector2.new(0, 2), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.509, 0), NumberSequenceKeypoint.new(0.51, 0.994), NumberSequenceKeypoint.new(1, 1) }) }, { ["ViralWorkerRef"] = "vw_85b81d7265" })
					I[22] = new("TextLabel", I[18], "Fill2Text", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.025, 0.5), RichText = true, Size = UDim2.fromScale(0.312, 1.25), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_4ba088d2c8" })
						I[23] = new("UIStroke", I[22], "UIStroke", { Thickness = 1.1092592 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_0977aebd7b" }, { "ScreenStroke", "UIStroke" })
					I[24] = new("TextLabel", I[18], "Fill1Text", { AnchorPoint = Vector2.new(1, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.025, 0.5), RichText = true, Size = UDim2.fromScale(0.312, 1.25), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right }, { ["ViralWorkerRef"] = "vw_bad5afa2a4" })
						I[25] = new("UIStroke", I[24], "UIStroke", { Thickness = 1.1092592 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_fe6d686f11" }, { "ScreenStroke", "UIStroke" })
				I[26] = new("UIPadding", I[3], "UIPadding", nil, { ["ViralWorkerRef"] = "vw_7df1ad1566" })
				I[27] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 4.5 }, { ["ViralWorkerRef"] = "vw_4cdc9cbc16" })
			I[28] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder }, { ["ViralWorkerRef"] = "vw_97490bb152" })
			I[29] = new("Frame", I[2], "Countdown", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.6, 0.15), Visible = false, ZIndex = 5 }, { ["ViralWorkerRef"] = "vw_7e25130445" })
				I[30] = new("TextLabel", I[29], "Title", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.09), RichText = true, Size = UDim2.fromScale(1, 0.4352035), Text = "UPDATE IN", TextColor3 = Color3.fromRGB(255, 234, 0), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_6b7a0c5060" })
					I[31] = new("UIStroke", I[30], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_6f63566eb1" }, { "ScreenStroke", "UIStroke" })
				I[32] = new("TextLabel", I[29], "Timer", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(1, 0.3808031), Text = "1h 30m", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_5f89539d35" })
					I[33] = new("UIStroke", I[32], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_098da79929" }, { "ScreenStroke", "UIStroke" })
				I[34] = new("UIAspectRatioConstraint", I[29], "UIAspectRatioConstraint", { AspectRatio = 4.5 }, { ["ViralWorkerRef"] = "vw_c5ff65cd53" })
	return I[1]
end

return build
