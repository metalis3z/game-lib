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
	I[1] = new("ScreenGui", nil, "Settings", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "ScreenGui" })
		I[2] = new("Frame", I[1], "Settings", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(51, 66, 73), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.320196, 0.6202756), Visible = false })
			I[3] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(85, 112, 127), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0000001, 0), Size = UDim2.fromScale(0.999814, 0.1434383) })
				I[4] = new("ImageButton", I[3], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.9089085, 0.4999999), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1397229, 0.877193) })
					I[5] = new("TextLabel", I[4], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
						I[7] = new("UIPadding", I[5], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) })
						I[8] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 47 })
				I[9] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2466696, 0.4916194), Size = UDim2.fromScale(0.4529324, 0.7207085), Text = "SETTINGS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 1.1092592 }, { ["OriginalThickness"] = 2 }, { "ScreenStroke", "UIStroke" })
					I[11] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 69 })
			I[12] = new("Frame", I[2], "Content", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.1720144), Size = UDim2.fromScale(1, 0.8262643) })
				I[13] = new("ScrollingFrame", I[12], "ScrollingFrame", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromOffset(0, 226), Position = UDim2.fromScale(0.5, 0.5), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 8, Size = UDim2.fromScale(1, 1) })
					I[14] = new("UIListLayout", I[13], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder })
					I[15] = new("Frame", I[13], "Template", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0206414, 0), Size = UDim2.fromScale(0.9159417, 0.1808318), Visible = false })
						I[16] = new("TextLabel", I[15], "Function", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0241187, 0.0877924), Size = UDim2.fromScale(0.6463196, 0.81), Text = "Setting", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
							I[17] = new("UIStroke", I[16], "UIStroke", { Thickness = 0.5546296 }, { ["OriginalThickness"] = 1 }, { "ScreenStroke", "UIStroke" })
							I[18] = new("UITextSizeConstraint", I[16], "UITextSizeConstraint", { MaxTextSize = 53 })
						I[19] = new("Frame", I[15], "Buttons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.8270359, 0.483), Size = UDim2.fromScale(0.284, 0.746) })
							I[20] = new("ImageButton", I[19], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(125, 111, 111), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
								I[21] = new("UIStroke", I[20], "UIStroke", { Color = Color3.fromRGB(0, 65, 7), Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5 }, { "ScreenStroke", "UIStroke" })
								I[22] = new("TextLabel", I[20], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.9), Text = "Off", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
									I[23] = new("UIStroke", I[22], "UIStroke", { Color = Color3.fromRGB(2, 56, 0), Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5 }, { "ScreenStroke", "UIStroke" })
									I[24] = new("UITextSizeConstraint", I[22], "UITextSizeConstraint", { MaxTextSize = 67 })
					I[25] = new("Frame", I[13], "TemplateBaseSkin", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0206414, 0), Size = UDim2.fromScale(0.9159417, 0.1808318), Visible = false })
						I[26] = new("TextLabel", I[25], "Function", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0241187, 0.0877924), Size = UDim2.fromScale(0.6463196, 0.81), Text = "Base Skin", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
							I[27] = new("UIStroke", I[26], "UIStroke", { Thickness = 0.5546296 }, { ["OriginalThickness"] = 1 }, { "ScreenStroke", "UIStroke" })
							I[28] = new("UITextSizeConstraint", I[26], "UITextSizeConstraint", { MaxTextSize = 53 })
						I[29] = new("ImageButton", I[25], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(125, 111, 111), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.827, 0.483), Size = UDim2.fromScale(0.284, 0.746) })
							I[30] = new("UIStroke", I[29], "UIStroke", { Color = Color3.fromRGB(103, 91, 91), Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5 }, { "ScreenStroke", "UIStroke" })
							I[31] = new("TextLabel", I[29], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0.8488194, 0.5910062), Text = "Default", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
								I[32] = new("UITextSizeConstraint", I[31], "UITextSizeConstraint", { MaxTextSize = 67 })
								I[33] = new("UIStroke", I[31], "UIStroke", { Color = Color3.fromRGB(103, 91, 91), Thickness = 0.5546296 }, { ["OriginalThickness"] = 1 }, { "ScreenStroke", "UIStroke" })
							I[34] = new("ImageLabel", I[29], "Polygon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://88203048118743"), Position = UDim2.fromScale(0.8872048, 0.8698202), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1317829, 0.25) })
							I[35] = new("Frame", I[29], "DropDown", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.498, 3.7969999), Size = UDim2.fromScale(1.2209998, 5.2370214), Visible = false })
								I[36] = new("ImageButton", I[35], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(125, 111, 111), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.4999999, 0.0852763), Size = UDim2.fromScale(0.831, 0.19), Visible = false })
									I[37] = new("TextLabel", I[36], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.849, 0.591), Text = "Golden", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
										I[38] = new("UITextSizeConstraint", I[37], "UITextSizeConstraint", { MaxTextSize = 67 })
										I[39] = new("UIStroke", I[37], "UIStroke", { Color = Color3.fromRGB(103, 91, 91), Thickness = 0.8319445 }, { ["OriginalThickness"] = 1.5 }, { "ScreenStroke", "UIStroke" })
									I[40] = new("Frame", I[36], "Locked", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
										I[41] = new("ImageLabel", I[40], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://123877736890165"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.443, 0.6) })
									I[42] = new("UIStroke", I[36], "UIStroke", { Color = Color3.fromRGB(103, 91, 91), Thickness = 1.1092592 }, { ["OriginalThickness"] = 2 }, { "ScreenStroke", "UIStroke" })
								I[43] = new("UIListLayout", I[35], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder })
								I[44] = new("UIPadding", I[35], "UIPadding", { PaddingTop = UDim.new(0, 16) })
								I[45] = new("Frame", I[35], "Padding", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 99999999, Size = UDim2.fromOffset(0, 8) })
			I[46] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 0.9185674 })
	return I[1]
end

return build
