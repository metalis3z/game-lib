-- Generated from ui/ReplicatedStorage/ReplicatedGui/Confirmation.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Confirmation", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "ixVYrWFLixVY" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(51, 66, 73), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.3666538, 0.2682242), Visible = false }, { ["_lemonadeUniqueId"] = "G5j0br42G5j0" })
			I[3] = new("Frame", I[2], "Content", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.1720144), Size = UDim2.fromScale(1, 0.8262643) }, { ["_lemonadeUniqueId"] = "VHtm38wWVHtm" })
				I[4] = new("TextLabel", I[3], "Description", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0255691, 0.0407934), RichText = true, Size = UDim2.fromScale(0.9474764, 0.4432691), Text = "Loading...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "Fxzn4tQwFxzn" })
					I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 1.5 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "M4KJax0OM4KJ" }, { "ScreenStroke", "UIStroke" })
					I[6] = new("UITextSizeConstraint", I[4], "UITextSizeConstraint", nil, { ["_lemonadeUniqueId"] = "37vW6IGy37vW" })
			I[7] = new("ImageButton", I[2], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.987691, 0.0336435), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0985404, 0.2373749) }, { ["_lemonadeUniqueId"] = "F4NNQOvrF4NN" })
				I[8] = new("TextLabel", I[7], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "0xDQszsG0xDQ" })
					I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "VC3IvfeSVC3I" }, { "ScreenStroke", "UIStroke" })
					I[10] = new("UITextSizeConstraint", I[8], "UITextSizeConstraint", { MaxTextSize = 47 }, { ["_lemonadeUniqueId"] = "leVy6FkcleVy" })
					I[11] = new("UIPadding", I[8], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, { ["_lemonadeUniqueId"] = "isCHrs7DisCH" })
			I[12] = new("ImageButton", I[2], "No", { BackgroundColor3 = Color3.fromRGB(119, 12, 12), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(12, 119, 60), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5428265, 0.6291039), Size = UDim2.fromScale(0.3406006, 0.2757739) }, { ["_lemonadeUniqueId"] = "nqoLCCWwnqoL" })
				I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(49, 0, 0), Thickness = 2 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "tq2JTEDhtq2J" }, { "ScreenStroke", "UIStroke" })
				I[14] = new("TextLabel", I[12], "Function", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4961075, 0.5000001), Size = UDim2.fromScale(0.8, 0.8), Text = "No", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "tzmbRvL9tzmb" })
					I[15] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(56, 0, 0), Thickness = 2 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "LEeY8UT7LEeY" }, { "ScreenStroke", "UIStroke" })
					I[16] = new("UITextSizeConstraint", I[14], "UITextSizeConstraint", { MaxTextSize = 63 }, { ["_lemonadeUniqueId"] = "jveaOL75jvea" })
			I[17] = new("ImageButton", I[2], "Yes", { BackgroundColor3 = Color3.fromRGB(12, 119, 60), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(12, 119, 60), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.1134605, 0.6291039), Size = UDim2.fromScale(0.3406006, 0.2757739) }, { ["_lemonadeUniqueId"] = "CXG1hegOCXG1" })
				I[18] = new("UIStroke", I[17], "UIStroke", { Color = Color3.fromRGB(0, 65, 7), Thickness = 2 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "WsTnBeiIWsTn" }, { "ScreenStroke", "UIStroke" })
				I[19] = new("TextLabel", I[17], "Function", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.4999999), Size = UDim2.fromScale(0.8, 0.8), Text = "Yes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "ePZVRDuuePZV" })
					I[20] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(0, 65, 7), Thickness = 2 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "8woukVOq8wou" }, { "ScreenStroke", "UIStroke" })
					I[21] = new("UITextSizeConstraint", I[19], "UITextSizeConstraint", { MaxTextSize = 63 }, { ["_lemonadeUniqueId"] = "rHYSZK6srHYS" })
			I[22] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.4324174 }, { ["_lemonadeUniqueId"] = "IN8sjZsuIN8s" })
	return I[1]
end

return build
