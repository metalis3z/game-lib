-- Generated from ui/ReplicatedStorage/ReplicatedGui/VoiceChat.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "VoiceChat", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "q5XwdsH1q5Xw" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "VoiceChat", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(51, 66, 73), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.3666538, 0.2682242), Visible = false }, { ["_lemonadeUniqueId"] = "JrXtszzxJrXt" })
			I[3] = new("Frame", I[2], "Content", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.1720144), Size = UDim2.fromScale(1, 0.8262643) }, { ["_lemonadeUniqueId"] = "etACuK2wetAC" })
				I[4] = new("TextLabel", I[3], "Description", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0255691, 0.0407934), Size = UDim2.fromScale(0.9474764, 0.4432691), Text = "Are you sure you want to join VC servers?", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "qwNmZdXpqwNm" })
					I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 1.5 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "Oba67ZhBOba6" }, { "ScreenStroke", "UIStroke" })
					I[6] = new("UITextSizeConstraint", I[4], "UITextSizeConstraint", nil, { ["_lemonadeUniqueId"] = "h4tw9ifhh4tw" })
			I[7] = new("ImageButton", I[2], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.987691, 0.0336435), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0985404, 0.2373749) }, { ["_lemonadeUniqueId"] = "EHXzAMMoEHXz" })
				I[8] = new("TextLabel", I[7], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "matJjr8OmatJ" })
					I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "YMQAum1tYMQA" }, { "ScreenStroke", "UIStroke" })
					I[10] = new("UITextSizeConstraint", I[8], "UITextSizeConstraint", { MaxTextSize = 47 }, { ["_lemonadeUniqueId"] = "rwOdU5uWrwOd" })
					I[11] = new("UIPadding", I[8], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, { ["_lemonadeUniqueId"] = "rsUqG4JPrsUq" })
			I[12] = new("ImageButton", I[2], "Cancel", { BackgroundColor3 = Color3.fromRGB(119, 12, 12), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(12, 119, 60), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5428265, 0.6291039), Size = UDim2.fromScale(0.3406006, 0.2757739) }, { ["_lemonadeUniqueId"] = "fPH5RYQIfPH5" })
				I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(49, 0, 0), Thickness = 2 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "wufJrNN9wufJ" }, { "ScreenStroke", "UIStroke" })
				I[14] = new("TextLabel", I[12], "Function", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4961075, 0.5000001), Size = UDim2.fromScale(0.8, 0.8), Text = "Cancel", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "WxfBJaIkWxfB" })
					I[15] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(56, 0, 0), Thickness = 2 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "SRdMpr9NSRdM" }, { "ScreenStroke", "UIStroke" })
					I[16] = new("UITextSizeConstraint", I[14], "UITextSizeConstraint", { MaxTextSize = 63 }, { ["_lemonadeUniqueId"] = "WvmOEK0kWvmO" })
			I[17] = new("ImageButton", I[2], "Yes", { BackgroundColor3 = Color3.fromRGB(12, 119, 60), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(12, 119, 60), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.1134605, 0.6291039), Size = UDim2.fromScale(0.3406006, 0.2757739) }, { ["_lemonadeUniqueId"] = "kn3IhbfNkn3I" })
				I[18] = new("UIStroke", I[17], "UIStroke", { Color = Color3.fromRGB(0, 65, 7), Thickness = 2 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "2m1PHSPB2m1P" }, { "ScreenStroke", "UIStroke" })
				I[19] = new("TextLabel", I[17], "Function", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.4999999), Size = UDim2.fromScale(0.8, 0.8), Text = "Yes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "vtO3vgpXvtO3" })
					I[20] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(0, 65, 7), Thickness = 2 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "OimH7aznOimH" }, { "ScreenStroke", "UIStroke" })
					I[21] = new("UITextSizeConstraint", I[19], "UITextSizeConstraint", { MaxTextSize = 63 }, { ["_lemonadeUniqueId"] = "LvCVAFpBLvCV" })
			I[22] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.4324174 }, { ["_lemonadeUniqueId"] = "u2mYd7pdu2mY" })
	return I[1]
end

return build
