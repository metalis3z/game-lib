-- Generated from ui/ReplicatedStorage/ReplicatedGui/Settings.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Settings", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "BSckgkUaBSck" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "Settings", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(51, 66, 73), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.320196, 0.6202756), Visible = false }, { ["_lemonadeUniqueId"] = "u2oyMMxJu2oy" })
			I[3] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(85, 112, 127), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0000001, 0), Size = UDim2.fromScale(0.999814, 0.1434383) }, { ["_lemonadeUniqueId"] = "bt8y1Vecbt8y" })
				I[4] = new("ImageButton", I[3], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.9089085, 0.4999999), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1397229, 0.877193) }, { ["_lemonadeUniqueId"] = "7STdQf8Y7STd" })
					I[5] = new("TextLabel", I[4], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "yBEU4RjFyBEU" })
						I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2.8027778 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "uAulC8VXuAul" }, { "ScreenStroke", "UIStroke" })
						I[7] = new("UIPadding", I[5], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, { ["_lemonadeUniqueId"] = "Xi7r1AH9Xi7r" })
						I[8] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 47 }, { ["_lemonadeUniqueId"] = "Hp7lK8AqHp7l" })
				I[9] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2466696, 0.4916194), Size = UDim2.fromScale(0.4529324, 0.7207085), Text = "SETTINGS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "120PFzPz120P" })
					I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 1.8685185 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "8jDkufeo8jDk" }, { "ScreenStroke", "UIStroke" })
					I[11] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 69 }, { ["_lemonadeUniqueId"] = "6ofNmkfZ6ofN" })
			I[12] = new("Frame", I[2], "Content", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.1720144), Size = UDim2.fromScale(1, 0.8262643) }, { ["_lemonadeUniqueId"] = "QWSFEEhTQWSF" })
				I[13] = new("ScrollingFrame", I[12], "ScrollingFrame", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.5, 0.5), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 8, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "e99TULOYe99T" })
					I[14] = new("Frame", I[13], "Template", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0206414, 0), Size = UDim2.fromScale(0.9159417, 0.1808318), Visible = false }, { ["_lemonadeUniqueId"] = "jcpHfhJ3jcpH" })
						I[15] = new("TextLabel", I[14], "Function", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0241187, 0.0877924), Size = UDim2.fromScale(0.6463196, 0.81), Text = "Setting", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "8o57inIw8o57" })
							I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 0.9342592 }, { ["OriginalThickness"] = 1, ["_lemonadeUniqueId"] = "HFIsqCpXHFIs" }, { "ScreenStroke", "UIStroke" })
							I[17] = new("UITextSizeConstraint", I[15], "UITextSizeConstraint", { MaxTextSize = 53 }, { ["_lemonadeUniqueId"] = "6fW7qWHz6fW7" })
						I[18] = new("Frame", I[14], "Buttons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.8270359, 0.483), Size = UDim2.fromScale(0.284, 0.746) }, { ["_lemonadeUniqueId"] = "uC4n0S3nuC4n" })
							I[19] = new("ImageButton", I[18], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(125, 111, 111), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "0xsyEz820xsy" })
								I[20] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(0, 65, 7), Thickness = 1.4013889 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "F2neILoaF2ne" }, { "ScreenStroke", "UIStroke" })
								I[21] = new("TextLabel", I[19], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.9), Text = "Off", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "557V7EFt557V" })
									I[22] = new("UIStroke", I[21], "UIStroke", { Color = Color3.fromRGB(2, 56, 0), Thickness = 1.4013889 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "UOScvbKcUOSc" }, { "ScreenStroke", "UIStroke" })
									I[23] = new("UITextSizeConstraint", I[21], "UITextSizeConstraint", { MaxTextSize = 67 }, { ["_lemonadeUniqueId"] = "rZUarNpPrZUa" })
					I[24] = new("UIListLayout", I[13], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "9iPhdRSM9iPh" })
					I[25] = new("Frame", I[13], "TemplateBaseSkin", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0206414, 0), Size = UDim2.fromScale(0.9159417, 0.1808318), Visible = false }, { ["_lemonadeUniqueId"] = "tAigFrGQtAig" })
						I[26] = new("TextLabel", I[25], "Function", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0241187, 0.0877924), Size = UDim2.fromScale(0.6463196, 0.81), Text = "Base Skin", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "xTugByp7xTug" })
							I[27] = new("UIStroke", I[26], "UIStroke", { Thickness = 0.9342592 }, { ["OriginalThickness"] = 1, ["_lemonadeUniqueId"] = "uupDfqkIuupD" }, { "ScreenStroke", "UIStroke" })
							I[28] = new("UITextSizeConstraint", I[26], "UITextSizeConstraint", { MaxTextSize = 53 }, { ["_lemonadeUniqueId"] = "PIeHXsntPIeH" })
						I[29] = new("ImageButton", I[25], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(125, 111, 111), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.827, 0.483), Size = UDim2.fromScale(0.284, 0.746) }, { ["_lemonadeUniqueId"] = "wr7g9Iyowr7g" })
							I[30] = new("UIStroke", I[29], "UIStroke", { Color = Color3.fromRGB(103, 91, 91), Thickness = 1.4013889 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "CN5ugxwICN5u" }, { "ScreenStroke", "UIStroke" })
							I[31] = new("TextLabel", I[29], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0.8488194, 0.5910062), Text = "Default", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "DK74D1MYDK74" })
								I[32] = new("UITextSizeConstraint", I[31], "UITextSizeConstraint", { MaxTextSize = 67 }, { ["_lemonadeUniqueId"] = "aHURf8aSaHUR" })
								I[33] = new("UIStroke", I[31], "UIStroke", { Color = Color3.fromRGB(103, 91, 91), Thickness = 0.9342592 }, { ["OriginalThickness"] = 1, ["_lemonadeUniqueId"] = "ACIsLqXzACIs" }, { "ScreenStroke", "UIStroke" })
							I[34] = new("ImageLabel", I[29], "Polygon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://88203048118743"), Position = UDim2.fromScale(0.8872048, 0.8698202), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1317829, 0.25) }, { ["_lemonadeUniqueId"] = "gRmJ4lJFgRmJ" })
							I[35] = new("Frame", I[29], "DropDown", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.498, 3.7969999), Size = UDim2.fromScale(1.2209998, 5.2370214), Visible = false }, { ["_lemonadeUniqueId"] = "vueZo4wuvueZ" })
								I[36] = new("ImageButton", I[35], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(125, 111, 111), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.4999999, 0.0852763), Size = UDim2.fromScale(0.831, 0.19), Visible = false }, { ["_lemonadeUniqueId"] = "yZniuiUuyZni" })
									I[37] = new("TextLabel", I[36], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.849, 0.591), Text = "Golden", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "bigMTD3tbigM" })
										I[38] = new("UITextSizeConstraint", I[37], "UITextSizeConstraint", { MaxTextSize = 67 }, { ["_lemonadeUniqueId"] = "ceaAcff1ceaA" })
										I[39] = new("UIStroke", I[37], "UIStroke", { Color = Color3.fromRGB(103, 91, 91), Thickness = 1.4013889 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "Hd9g2ReYHd9g" }, { "ScreenStroke", "UIStroke" })
									I[40] = new("Frame", I[36], "Locked", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "4RBHxb8q4RBH" })
										I[41] = new("ImageLabel", I[40], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://123877736890165"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.443, 0.6) }, { ["_lemonadeUniqueId"] = "vEGBlaL3vEGB" })
									I[42] = new("UIStroke", I[36], "UIStroke", { Color = Color3.fromRGB(103, 91, 91), Thickness = 1.8685185 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "TBGmmah5TBGm" }, { "ScreenStroke", "UIStroke" })
								I[43] = new("UIListLayout", I[35], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "kDB5ulxHkDB5" })
								I[44] = new("UIPadding", I[35], "UIPadding", { PaddingTop = UDim.new(0, 16) }, { ["_lemonadeUniqueId"] = "FShhGgVPFShh" })
								I[45] = new("Frame", I[35], "Padding", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 99999999, Size = UDim2.fromOffset(0, 8) }, { ["_lemonadeUniqueId"] = "BY4vV0g0BY4v" })
			I[46] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 0.9185674 }, { ["_lemonadeUniqueId"] = "n33WMevZn33W" })
	return I[1]
end

return build
