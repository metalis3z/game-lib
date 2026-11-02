-- Generated from ui/ReplicatedStorage/ReplicatedGui/PollUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "PollUI", { DisplayOrder = 5, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_8fcd144bdd" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "Poll", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -999, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.6, 0.175), Visible = false, ZIndex = 5 }, { ["ViralWorkerRef"] = "vw_13411ab87b" })
			I[3] = new("TextLabel", I[2], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.2200298), RichText = true, Size = UDim2.fromScale(1, 0.2599403), Text = "Poll Text", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_e613fe3a26" })
				I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 2.8027778 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_65c0a76699" }, { "ScreenStroke", "UIStroke" })
			I[5] = new("Frame", I[2], "Buttons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.85), Size = UDim2.fromScale(0.45, 0.275), ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_6d76e6a10f" })
				I[6] = new("UIListLayout", I[5], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, HorizontalFlex = Enum.UIFlexAlignment.Fill, Padding = UDim.new(0, 24), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["ViralWorkerRef"] = "vw_25b0dbd7e7" })
				I[7] = new("ImageButton", I[5], "1", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(33, 151, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(80, 158, 87), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.282411, 1.0000001), Size = UDim2.fromScale(0.2833, 1) }, { ["ViralWorkerRef"] = "vw_011ec1e49b" })
					I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 2.8962035 }, { ["OriginalThickness"] = 3.0999999, ["ViralWorkerRef"] = "vw_8b80dbdccb" }, { "ScreenStroke", "UIStroke" })
					I[9] = new("TextLabel", I[7], "Function", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.4999999), Size = UDim2.fromScale(0.75, 0.75), Text = "Option1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_a9bce78969" })
						I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 2.8027778 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_9500c26c8c" }, { "ScreenStroke", "UIStroke" })
					I[11] = new("Frame", I[7], "Disabled", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["ViralWorkerRef"] = "vw_00e14762da" })
				I[12] = new("ImageButton", I[5], "2", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(218, 38, 26), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(80, 158, 87), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.282411, 1.0000001), Size = UDim2.fromScale(0.2833, 1) }, { ["ViralWorkerRef"] = "vw_5afa8e46a1" })
					I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 2.8962035 }, { ["OriginalThickness"] = 3.0999999, ["ViralWorkerRef"] = "vw_60170e8d00" }, { "ScreenStroke", "UIStroke" })
					I[14] = new("TextLabel", I[12], "Function", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.4999999), Size = UDim2.fromScale(0.75, 0.75), Text = "Option2", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_0052f4b06f" })
						I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 2.8027778 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_898eaf3216" }, { "ScreenStroke", "UIStroke" })
					I[16] = new("Frame", I[12], "Disabled", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["ViralWorkerRef"] = "vw_2c5ce42eb1" })
			I[17] = new("Frame", I[2], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(218, 38, 26), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.515), Size = UDim2.fromScale(0.6, 0.15), ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_d7c21d5295" })
				I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 2.8962035 }, { ["OriginalThickness"] = 3.0999999, ["ViralWorkerRef"] = "vw_e6e948b8d7" }, { "ScreenStroke", "UIStroke" })
				I[19] = new("Frame", I[17], "Fill", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = -10 }, { ["ViralWorkerRef"] = "vw_9211f79f86" })
					I[20] = new("UIGradient", I[19], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(33, 151, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(33, 151, 255)) }), Offset = Vector2.new(0, 2), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.509, 0), NumberSequenceKeypoint.new(0.51, 0.994), NumberSequenceKeypoint.new(1, 1) }) }, { ["ViralWorkerRef"] = "vw_65c56202ba" })
				I[21] = new("TextLabel", I[17], "Fill2Text", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.025, 0.5), RichText = true, Size = UDim2.fromScale(0.312, 1.25), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_699cc5bee7" })
					I[22] = new("UIStroke", I[21], "UIStroke", { Thickness = 1.8685185 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_d435823845" }, { "ScreenStroke", "UIStroke" })
				I[23] = new("TextLabel", I[17], "Fill1Text", { AnchorPoint = Vector2.new(1, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.025, 0.5), RichText = true, Size = UDim2.fromScale(0.312, 1.25), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right }, { ["ViralWorkerRef"] = "vw_80fcb3278b" })
					I[24] = new("UIStroke", I[23], "UIStroke", { Thickness = 1.8685185 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_4539aa09ff" }, { "ScreenStroke", "UIStroke" })
			I[25] = new("UIPadding", I[2], "UIPadding", nil, { ["ViralWorkerRef"] = "vw_27e533c8e1" })
			I[26] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 4.5 }, { ["ViralWorkerRef"] = "vw_6881dd49fa" })
	return I[1]
end

return build
