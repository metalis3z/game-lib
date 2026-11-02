-- Generated from ui/ReplicatedStorage/ReplicatedGui/CandyShop.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CandyShop", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "nY1Fli9PnY1F" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "CandyShop", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(130, 58, 134), BackgroundTransparency = 0.33, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.448, 0.6202755), Visible = false }, { ["_lemonadeUniqueId"] = "VpsGyVj5VpsG" })
			I[3] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(250, 111, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0000001, 0), Size = UDim2.fromScale(0.9998139, 0.1434383) }, { ["_lemonadeUniqueId"] = "Zpp7poFFZpp7" })
				I[4] = new("ImageButton", I[3], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.935102, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0873362, 0.877193) }, { ["_lemonadeUniqueId"] = "wUZud0YOwUZu" })
					I[5] = new("TextLabel", I[4], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "2tFeFT8W2tFe" })
						I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3.2 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "K07TRAPPK07T" }, { "ScreenStroke", "UIStroke" })
						I[7] = new("UIPadding", I[5], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, { ["_lemonadeUniqueId"] = "zGHOpn8SzGHO" })
						I[8] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 47 }, { ["_lemonadeUniqueId"] = "WU7hz1mCWU7h" })
				I[9] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2440189, 0.4916196), Size = UDim2.fromScale(0.4334711, 0.7207084), Text = "CANDY SHOP", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "lRwxrApjlRwx" })
					I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 2.1333334 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "dGaHFnDXdGaH" }, { "ScreenStroke", "UIStroke" })
					I[11] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 69 }, { ["_lemonadeUniqueId"] = "Fvka3ktRFvka" })
			I[12] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.2852073 }, { ["_lemonadeUniqueId"] = "WSzCqzftWSzC" })
			I[13] = new("Frame", I[2], "Main", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.2010073), Size = UDim2.fromScale(0.9999999, 0.7989928) }, { ["_lemonadeUniqueId"] = "FIsO6GuCFIsO" })
				I[14] = new("UIListLayout", I[13], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "M3HE46OiM3HE" })
				I[15] = new("Frame", I[13], "Template", { BackgroundColor3 = Color3.fromRGB(176, 51, 155), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.03608, 0.107692), Size = UDim2.fromScale(0.4703261, 0.8615732), Visible = false }, { ["_lemonadeUniqueId"] = "bsiIuhIgbsiI" })
					I[16] = new("TextLabel", I[15], "Name", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4995049, 0.097701), Size = UDim2.fromScale(0.9393021, 0.1345707), Text = "Gear Candy", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "EZIepuoQEZIe" })
						I[17] = new("UIStroke", I[16], "UIStroke", { Thickness = 2.1333334 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "tquFM20ItquF" }, { "ScreenStroke", "UIStroke" })
						I[18] = new("UITextSizeConstraint", I[16], "UITextSizeConstraint", { MaxTextSize = 62 }, { ["_lemonadeUniqueId"] = "GjSBUHqgGjSB" })
					I[19] = new("ImageLabel", I[15], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90789170861148"), Position = UDim2.fromScale(0.5, 0.4143425), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.811825, 0.6270428) }, { ["_lemonadeUniqueId"] = "iKcVlz22iKcV" })
					I[20] = new("ImageButton", I[15], "Buy", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(81, 158, 86), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(81, 158, 86), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.85), Size = UDim2.fromScale(0.5918497, 0.1675018) }, { ["_lemonadeUniqueId"] = "k0z8eOzXk0z8" })
						I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 2.1333334 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "yJFl1CgGyJFl" }, { "ScreenStroke", "UIStroke" })
						I[22] = new("TextLabel", I[20], "Function", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.75), Text = "$500", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "xr3CN5Qqxr3C" })
							I[23] = new("UIStroke", I[22], "UIStroke", { Thickness = 3.2 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "KcviwAHRKcvi" }, { "ScreenStroke", "UIStroke" })
							I[24] = new("UITextSizeConstraint", I[22], "UITextSizeConstraint", { MaxTextSize = 57 }, { ["_lemonadeUniqueId"] = "WXoqGp6YWXoq" })
					I[25] = new("UIStroke", I[15], "UIStroke", { Thickness = 2.1333334, Transparency = 0.1 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "leMkqVdzleMk" }, { "ScreenStroke", "UIStroke" })
			I[26] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.167), RichText = true, Size = UDim2.fromScale(0.8, 0.07), Text = "Shop refreshes in <font color=\"rgb(250, 111, 255)\">2m 10s</font>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "ZwmYvNAUZwmY" })
				I[27] = new("UIStroke", I[26], "UIStroke", { Thickness = 1.6 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "TAceZZW8TAce" }, { "ScreenStroke", "UIStroke" })
	return I[1]
end

return build
