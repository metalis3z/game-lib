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
	I[1] = new("ScreenGui", nil, "DuelsMachineTopFrame", { DisplayOrder = 11, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "kn0Gonuokn0G" }, { "ScreenGui" })
		I[2] = new("TextLabel", I[1], "Tip", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.21734, 0.1315105), Size = UDim2.fromScale(0.5652251, 0.0331496), Text = "first to 3 wins!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, ZIndex = 0 }, { ["_lemonadeUniqueId"] = "HkE7jW0MHkE7" })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 1.6638889, Transparency = 1 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "OUo4bAEEOUo4" }, { "ScreenStroke", "UIStroke" })
		I[4] = new("Frame", I[1], "DuelsMachineTopFrame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.4517423, 0.1132074), Visible = false }, { ["_lemonadeUniqueId"] = "N1GsTmAMN1Gs" })
			I[5] = new("Frame", I[4], "Blue", { BackgroundColor3 = Color3.fromRGB(0, 145, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.1437529, 0.1520693), Size = UDim2.fromScale(0.2421265, 0.6958614) }, { ["_lemonadeUniqueId"] = "SoPT8rp7SoPT" })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "NyszLAKSNysz" }, { "ScreenStroke", "UIStroke" })
				I[7] = new("ImageLabel", I[5], "Player", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=2678001507&w=100&h=100"), Position = UDim2.fromScale(0.6, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.357, 0.8719999) }, { ["_lemonadeUniqueId"] = "lqzYaJDRlqzY" })
				I[8] = new("TextLabel", I[5], "Label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0210754, 0.2106518), Size = UDim2.fromScale(0.5652252, 0.6717011), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "qBbrf4dfqBbr" })
					I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "C95xKoWEC95x" }, { "ScreenStroke", "UIStroke" })
				I[10] = new("ImageLabel", I[5], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://120184993966928"), Position = UDim2.fromScale(0.6486031, 0.724043), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.5477579, 0.5477578), ZIndex = 20 }, { ["_lemonadeUniqueId"] = "XUolQrSuXUol" })
			I[11] = new("Frame", I[4], "Red", { BackgroundColor3 = Color3.fromRGB(255, 0, 4), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.6248591, 0.1520693), Size = UDim2.fromScale(0.242, 0.696) }, { ["_lemonadeUniqueId"] = "bGTyzE9BbGTy" })
				I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "N5ZNAz0QN5ZN" }, { "ScreenStroke", "UIStroke" })
				I[13] = new("ImageLabel", I[11], "Player", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=2678001507&w=100&h=100"), Position = UDim2.fromScale(0.04, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3569319, 0.8724999) }, { ["_lemonadeUniqueId"] = "05v1I7BD05v1" })
				I[14] = new("TextLabel", I[11], "Label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4060754, 0.199), Size = UDim2.fromScale(0.5652252, 0.6717011), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "MgemBKjXMgem" })
					I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "2y2IyQ8C2y2I" }, { "ScreenStroke", "UIStroke" })
				I[16] = new("ImageLabel", I[11], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://132603130603934"), Position = UDim2.fromScale(0.3486031, 0.724043), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.5477579, 0.5477578), ZIndex = 20 }, { ["_lemonadeUniqueId"] = "dpWtUSHhdpWt" })
			I[17] = new("UIListLayout", I[4], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.04, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "L59NAoGcL59N" })
			I[18] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", { AspectRatio = 7.0903411 }, { ["_lemonadeUniqueId"] = "Kb6KJpcoKb6K" })
			I[19] = new("Frame", I[4], "Timer", { BackgroundColor3 = Color3.fromRGB(121, 121, 121), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.4143417, 0.2519225), Size = UDim2.fromScale(0.1713167, 0.5141422) }, { ["_lemonadeUniqueId"] = "SLUh0bx1SLUh" })
				I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "cBBytVV3cBBy" }, { "ScreenStroke", "UIStroke" })
				I[21] = new("TextLabel", I[19], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "1:24", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "02KvLGoQ02Kv" })
					I[22] = new("UIStroke", I[21], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "IOlCAAvlIOlC" }, { "ScreenStroke", "UIStroke" })
					I[23] = new("UITextSizeConstraint", I[21], "UITextSizeConstraint", { MaxTextSize = 57 }, { ["_lemonadeUniqueId"] = "9P4Nkwue9P4N" })
	return I[1]
end

return build
