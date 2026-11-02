-- Generated from ui/StarterGui/LeftCenter.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LeftCenter", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_295937334c" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "LeftCenter", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1) }, { ["ViralWorkerRef"] = "vw_d8f5a14658" })
			I[3] = new("Frame", I[2], "Buttons", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.015625, 0.4946451), Size = UDim2.fromScale(0.06, 0.39) }, { ["ViralWorkerRef"] = "vw_a5e39c1461" })
				I[4] = new("ImageButton", I[3], "Index", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://86947637796850"), ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://79371787677745"), LayoutOrder = 1, Position = UDim2.fromScale(0.42, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.3015267) }, { ["ViralWorkerRef"] = "vw_c49dca0b09" })
					I[5] = new("ImageLabel", I[4], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://93319118644975"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.76055, 0.76055), ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_917a351d4b" })
					I[6] = new("TextLabel", I[4], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.2278481), Text = "Index", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_4b98ee32d7" })
						I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 2.0014815, Transparency = 0.35 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_0d13c9d4d6" }, { "ScreenStroke", "UIStroke" })
				I[8] = new("ImageButton", I[3], "Codes", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://86947637796850"), ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://79371787677745"), LayoutOrder = 6, Position = UDim2.fromScale(1.556, 0.842), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.3015267) }, { ["ViralWorkerRef"] = "vw_231974bdc0" })
					I[9] = new("TextLabel", I[8], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4771573, 0.9367086), Size = UDim2.fromScale(1, 0.2278481), Text = "Codes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_7afad23a04" })
						I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 2.0014815, Transparency = 0.35 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_cf9b96ba64" }, { "ScreenStroke", "UIStroke" })
					I[11] = new("ImageLabel", I[8], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://80679498557422"), Position = UDim2.fromScale(0.5114229, 0.5230656), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.9185247, 0.7821798), ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_308083a0cc" })
				I[12] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 0.3 }, { ["ViralWorkerRef"] = "vw_2e5f34d322" })
				I[13] = new("ImageButton", I[3], "EventShop", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://86947637796850"), ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://79371787677745"), LayoutOrder = 5, Position = UDim2.fromScale(1.556, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.3) }, { ["ViralWorkerRef"] = "vw_fc21fe3539" })
					I[14] = new("ImageLabel", I[13], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://117317369032558"), Position = UDim2.fromScale(0.4958922, 0.4625942), Size = UDim2.fromScale(0.9546223, 0.946806), SizeConstraint = Enum.SizeConstraint.RelativeYY }, { ["ViralWorkerRef"] = "vw_6d6f82f4d7" })
					I[15] = new("TextLabel", I[13], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.2278481), Text = "Coming soon ?", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_fc61b54ed9" })
						I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 2.0014815, Transparency = 0.35 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_e89e3e30bf" }, { "ScreenStroke", "UIStroke" })
				I[17] = new("ImageButton", I[3], "News", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://86947637796850"), ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://79371787677745"), LayoutOrder = 6, Position = UDim2.fromScale(1.556, 0.842), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.3015267) }, { ["ViralWorkerRef"] = "vw_339eaa310a" })
					I[18] = new("ImageLabel", I[17], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://87463359438228"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.85, 0.85), ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_b69425d6e3" })
					I[19] = new("TextLabel", I[17], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4771573, 0.9367086), Size = UDim2.fromScale(1, 0.2278481), Text = "Info", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_f7d3f4078b" })
						I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 2.0014815, Transparency = 0.35 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_afca6102dc" }, { "ScreenStroke", "UIStroke" })
				I[21] = new("ImageButton", I[3], "Sign", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://86947637796850"), ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://79371787677745"), LayoutOrder = 6, Position = UDim2.fromScale(2.7900002, 0.15), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.3), Visible = false }, { ["UIScalingAutoScaled"] = true, ["ViralWorkerRef"] = "vw_be84df725d" })
					I[22] = new("ImageLabel", I[21], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://120855437950510"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.85, 0.85), ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_73bba3eb20" })
					I[23] = new("TextLabel", I[21], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4771573, 0.9367086), Size = UDim2.fromScale(1, 0.2278481), Text = "Sign", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_3001bd3cfd" })
						I[24] = new("UIStroke", I[23], "UIStroke", { Thickness = 2.0014815, Transparency = 0.35 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_07cb1cf82d" }, { "ScreenStroke", "UIStroke" })
					I[25] = new("UIGradient", I[21], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }) }, { ["ViralWorkerRef"] = "vw_bf6e75f314" })
				I[26] = new("UIGridLayout", I[3], "UIGridLayout", { CellPadding = UDim2.fromScale(0.145, 0.045), CellSize = UDim2.fromScale(1, 0.3), FillDirection = Enum.FillDirection.Vertical, FillDirectionMaxCells = 4, SortOrder = Enum.SortOrder.LayoutOrder }, { ["ViralWorkerRef"] = "vw_f2ba412c5e" })
			I[27] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.1500001 }, { ["ViralWorkerRef"] = "vw_84ed6b6c09" })
	return I[1]
end

return build
