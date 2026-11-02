-- Generated from ui/ReplicatedStorage/ReplicatedGui/LeftCenter.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LeftCenter", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "wFAaGAc0wFAa" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "LeftCenter", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "5BUjr4IM5BUj" })
			I[3] = new("Frame", I[2], "Buttons", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.015625, 0.5), Size = UDim2.fromScale(0.062, 0.38) }, { ["_lemonadeUniqueId"] = "Gzk0vxxjGzk0" })
				I[4] = new("ImageButton", I[3], "Index", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://86947637796850"), ImageContent = Content.fromUri("rbxassetid://79371787677745"), LayoutOrder = 1, Position = UDim2.fromScale(0.42, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.3015267) }, { ["_lemonadeUniqueId"] = "OdUB8MAcOdUB" })
					I[5] = new("ImageLabel", I[4], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://93319118644975"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.76055, 0.76055), ZIndex = 0 }, { ["_lemonadeUniqueId"] = "D4YE3dQwD4YE" })
					I[6] = new("TextLabel", I[4], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.2278481), Text = "Index", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "AU5LBQHPAU5L" })
						I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 1.8685185, Transparency = 0.35 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "h6MAMxIYh6MA" }, { "ScreenStroke", "UIStroke" })
				I[8] = new("ImageButton", I[3], "Shop", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://119376130178381"), ImageContent = Content.fromUri("rbxassetid://88734015663903"), Position = UDim2.fromScale(0.42, 0.158), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.3015267), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "8oi9QSDv8oi9" })
					I[9] = new("ImageLabel", I[8], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://89737709634138"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.76055, 0.76055), ZIndex = 0 }, { ["_lemonadeUniqueId"] = "V2VBvPWsV2VB" })
					I[10] = new("TextLabel", I[8], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.2278481), Text = "Shop", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "tcPgfOpFtcPg" })
						I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 1.8685185, Transparency = 0.35 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "BlzbwVAIBlzb" }, { "ScreenStroke", "UIStroke" })
					I[12] = new("ImageLabel", I[8], "Vector", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90950924141431"), Position = UDim2.fromScale(0, -0.96), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false, ZIndex = 0 }, { ["_lemonadeUniqueId"] = "Fl2yw0LJFl2y" })
				I[13] = new("ImageButton", I[3], "TradePlayerList", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://86947637796850"), ImageContent = Content.fromUri("rbxassetid://79371787677745"), LayoutOrder = 3, Position = UDim2.fromScale(0.412, 0.842), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.3015267) }, { ["_lemonadeUniqueId"] = "SiQbd8f9SiQb" })
					I[14] = new("TextLabel", I[13], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.2278481), Text = "Trade", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "Noy3l4aONoy3" })
						I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 1.8685185, Transparency = 0.35 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "aCNpB6skaCNp" }, { "ScreenStroke", "UIStroke" })
					I[16] = new("ImageLabel", I[13], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://119817932868799"), Position = UDim2.fromScale(0.525, 0.475), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.825, 0.825), ZIndex = 0 }, { ["_lemonadeUniqueId"] = "fS3FQH75fS3F" })
				I[17] = new("ImageButton", I[3], "Codes", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 0, 4), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://86947637796850"), ImageContent = Content.fromUri("rbxassetid://79371787677745"), LayoutOrder = 6, Position = UDim2.fromScale(1.556, 0.842), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.3015267) }, { ["_lemonadeUniqueId"] = "X8Oi2vj7X8Oi" })
					I[18] = new("TextLabel", I[17], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.2278481), Text = "Codes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "SN0yrjtZSN0y" })
						I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 1.8685185, Transparency = 0.35 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "3xIr4qko3xIr" }, { "ScreenStroke", "UIStroke" })
					I[20] = new("ImageLabel", I[17], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://80679498557422"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.85, 0.85), ZIndex = 0 }, { ["_lemonadeUniqueId"] = "XbuxgVYYXbux" })
					I[21] = new("UICorner", I[17], "UICorner", nil, { ["_lemonadeUniqueId"] = "Vcxi8DLTVcxi" })
				I[22] = new("UIGridLayout", I[3], "UIGridLayout", { CellPadding = UDim2.fromScale(0.145, 0.045), CellSize = UDim2.fromScale(1, 0.3), FillDirection = Enum.FillDirection.Vertical, FillDirectionMaxCells = 3, SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "5ECr5Aay5ECr" })
				I[23] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 0.3 }, { ["_lemonadeUniqueId"] = "7yif6uNR7yif" })
			I[24] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.1500001 }, { ["_lemonadeUniqueId"] = "AOg1GJ4OAOg1" })
	return I[1]
end

return build
