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
	I[1] = new("ScreenGui", nil, "TopUI", { DisplayOrder = 5, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "OKtLZvjfOKtL" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "Ilzd32ffIlzd" })
			I[3] = new("Frame", I[2], "Poll", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.6, 0.175), Visible = false, ZIndex = 5 }, { ["_lemonadeUniqueId"] = "yPzUSsqOyPzU" })
				I[4] = new("TextLabel", I[3], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.2200298), RichText = true, Size = UDim2.fromScale(1, 0.2599403), Text = "How often should it auto skip fuse", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "sCGdj6bdsCGd" })
					I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "x64zmeqYx64z" }, { "ScreenStroke", "UIStroke" })
				I[6] = new("Frame", I[3], "Buttons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.85), Size = UDim2.fromScale(0.45, 0.275), ZIndex = 0 }, { ["_lemonadeUniqueId"] = "Gg9eHTusGg9e" })
					I[7] = new("UIListLayout", I[6], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, HorizontalFlex = Enum.UIFlexAlignment.Fill, Padding = UDim.new(0, 24), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "asJo3VKIasJo" })
					I[8] = new("ImageButton", I[6], "1", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(128, 0, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(80, 158, 87), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.282411, 1.0000001), Size = UDim2.fromScale(0.2833, 1) }, { ["_lemonadeUniqueId"] = "848us72O848u" })
						I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 1.7193518 }, { ["OriginalThickness"] = 3.0999999, ["_lemonadeUniqueId"] = "EquBajpdEquB" }, { "ScreenStroke", "UIStroke" })
						I[10] = new("TextLabel", I[8], "Function", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.4999999), Size = UDim2.fromScale(0.75, 0.75), Text = "1 minute", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "LYbvq0SQLYbv" })
							I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "UyB90v6IUyB9" }, { "ScreenStroke", "UIStroke" })
						I[12] = new("Frame", I[8], "Disabled", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "VjiGsGyEVjiG" })
					I[13] = new("ImageButton", I[6], "2", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(80, 158, 87), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.282411, 1.0000001), Size = UDim2.fromScale(0.2833, 1) }, { ["_lemonadeUniqueId"] = "aSKtqaxBaSKt" })
						I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 1.7193518 }, { ["OriginalThickness"] = 3.0999999, ["_lemonadeUniqueId"] = "Fp1BtjxtFp1B" }, { "ScreenStroke", "UIStroke" })
						I[15] = new("TextLabel", I[13], "Function", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.4999999), Size = UDim2.fromScale(0.75, 0.75), Text = "30 Seconds", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "J26oalmaJ26o" })
							I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "NaRscUXzNaRs" }, { "ScreenStroke", "UIStroke" })
						I[17] = new("Frame", I[13], "Disabled", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "zL47im0CzL47" })
				I[18] = new("Frame", I[3], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.515), Size = UDim2.fromScale(0.6, 0.15), ZIndex = 0 }, { ["_lemonadeUniqueId"] = "24ZVGQlx24ZV" })
					I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 1.7193518 }, { ["OriginalThickness"] = 3.0999999, ["_lemonadeUniqueId"] = "xZNuOLCMxZNu" }, { "ScreenStroke", "UIStroke" })
					I[20] = new("Frame", I[18], "Fill", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = -10 }, { ["_lemonadeUniqueId"] = "Vl7lM2ICVl7l" })
						I[21] = new("UIGradient", I[20], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(128, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 0, 255)) }), Offset = Vector2.new(0.0861291, 0), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.509, 0), NumberSequenceKeypoint.new(0.51, 0.994), NumberSequenceKeypoint.new(1, 1) }) }, { ["_lemonadeUniqueId"] = "BRAh8YblBRAh" })
					I[22] = new("TextLabel", I[18], "Fill2Text", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.025, 0.5), RichText = true, Size = UDim2.fromScale(0.312, 1.25), Text = "2,668,235", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "PRx0Iw0ePRx0" })
						I[23] = new("UIStroke", I[22], "UIStroke", { Thickness = 1.1092592 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "NFr1k9S4NFr1" }, { "ScreenStroke", "UIStroke" })
					I[24] = new("TextLabel", I[18], "Fill1Text", { AnchorPoint = Vector2.new(1, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.025, 0.5), RichText = true, Size = UDim2.fromScale(0.312, 1.25), Text = "3,778,788", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right }, { ["_lemonadeUniqueId"] = "uLBmHLCcuLBm" })
						I[25] = new("UIStroke", I[24], "UIStroke", { Thickness = 1.1092592 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "ib1YBJIWib1Y" }, { "ScreenStroke", "UIStroke" })
				I[26] = new("UIPadding", I[3], "UIPadding", nil, { ["_lemonadeUniqueId"] = "GJlbfcuCGJlb" })
				I[27] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 4.5 }, { ["_lemonadeUniqueId"] = "oMvp9NBpoMvp" })
			I[28] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "NxYhPBFRNxYh" })
			I[29] = new("Frame", I[2], "Countdown", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.6, 0.15), Visible = false, ZIndex = 5 }, { ["_lemonadeUniqueId"] = "8qaYAJpJ8qaY" })
				I[30] = new("TextLabel", I[29], "Title", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.09), RichText = true, Size = UDim2.fromScale(1, 0.4352035), Text = "UPDATE IN", TextColor3 = Color3.fromRGB(255, 234, 0), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "8FjiJhYE8Fji" })
					I[31] = new("UIStroke", I[30], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "pLmOGJlnpLmO" }, { "ScreenStroke", "UIStroke" })
				I[32] = new("TextLabel", I[29], "Timer", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(1, 0.3808031), Text = "1h 30m", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "wKOIcOvbwKOI" })
					I[33] = new("UIStroke", I[32], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "XimqXTGWXimq" }, { "ScreenStroke", "UIStroke" })
				I[34] = new("UIAspectRatioConstraint", I[29], "UIAspectRatioConstraint", { AspectRatio = 4.5 }, { ["_lemonadeUniqueId"] = "5CTa2sOO5CTa" })
	return I[1]
end

return build
