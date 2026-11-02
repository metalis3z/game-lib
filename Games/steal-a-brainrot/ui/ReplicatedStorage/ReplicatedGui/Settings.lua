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
	I[1] = new("ScreenGui", nil, "Settings", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_89ec46562e" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "Settings", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(51, 66, 73), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.511948, 0.487025), Size = UDim2.fromScale(0.320196, 0.6202756), Visible = false }, { ["ViralWorkerRef"] = "vw_943610997f" })
			I[3] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(85, 112, 127), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0000001, 0), Size = UDim2.fromScale(0.999814, 0.1434383) }, { ["ViralWorkerRef"] = "vw_f5ed330ec6" })
				I[4] = new("ImageButton", I[3], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.9089085, 0.4999999), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1397229, 0.877193) }, { ["ViralWorkerRef"] = "vw_a179c5f8b2" })
					I[5] = new("TextLabel", I[4], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_64a91df15c" })
						I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_c68736cb39" }, { "ScreenStroke", "UIStroke" })
						I[7] = new("UIPadding", I[5], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, { ["ViralWorkerRef"] = "vw_021a08d74b" })
						I[8] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 47 }, { ["ViralWorkerRef"] = "vw_186c6478bf" })
				I[9] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2466696, 0.4916194), Size = UDim2.fromScale(0.4529324, 0.7207085), Text = "SETTINGS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_376c834659" })
					I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 2 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_3fc9c27eb6" }, { "ScreenStroke", "UIStroke" })
					I[11] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 69 }, { ["ViralWorkerRef"] = "vw_bf113f9c10" })
			I[12] = new("Frame", I[2], "Content", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.1720144), Size = UDim2.fromScale(1, 0.8262643) }, { ["ViralWorkerRef"] = "vw_384237ee27" })
				I[13] = new("ScrollingFrame", I[12], "ScrollingFrame", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromOffset(0, 544), Position = UDim2.fromScale(0.5, 0.5), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 8, Size = UDim2.fromScale(1, 1) }, { ["ViralWorkerRef"] = "vw_4618fd4677" })
					I[14] = new("Frame", I[13], "Template", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0206414, 0), Size = UDim2.fromScale(0.9159417, 0.1808318), Visible = false }, { ["ViralWorkerRef"] = "vw_9debd1a3ce" })
						I[15] = new("TextLabel", I[14], "Function", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0241187, 0.0877924), Size = UDim2.fromScale(0.6463196, 0.81), Text = "Setting", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_c07dcf4773" })
							I[16] = new("UIStroke", I[15], "UIStroke", nil, { ["OriginalThickness"] = 1, ["ViralWorkerRef"] = "vw_318cee0ec3" }, { "ScreenStroke", "UIStroke" })
							I[17] = new("UITextSizeConstraint", I[15], "UITextSizeConstraint", { MaxTextSize = 53 }, { ["ViralWorkerRef"] = "vw_d829265710" })
						I[18] = new("Frame", I[14], "Buttons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.8270359, 0.483), Size = UDim2.fromScale(0.284, 0.746) }, { ["ViralWorkerRef"] = "vw_d4a7508471" })
							I[19] = new("ImageButton", I[18], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(125, 111, 111), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["ViralWorkerRef"] = "vw_0136c45415" })
								I[20] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(0, 65, 7), Thickness = 1.5 }, { ["OriginalThickness"] = 1.5, ["ViralWorkerRef"] = "vw_88d54a1263" }, { "ScreenStroke", "UIStroke" })
								I[21] = new("TextLabel", I[19], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.9), Text = "Off", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_017615426b" })
									I[22] = new("UIStroke", I[21], "UIStroke", { Color = Color3.fromRGB(2, 56, 0), Thickness = 1.5 }, { ["OriginalThickness"] = 1.5, ["ViralWorkerRef"] = "vw_200aa96e46" }, { "ScreenStroke", "UIStroke" })
									I[23] = new("UITextSizeConstraint", I[21], "UITextSizeConstraint", { MaxTextSize = 67 }, { ["ViralWorkerRef"] = "vw_bdb8ecbf55" })
					I[24] = new("UIListLayout", I[13], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder }, { ["ViralWorkerRef"] = "vw_f3eaa10fe2" })
					I[25] = new("Frame", I[13], "TemplateBaseSkin", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0206414, 0), Size = UDim2.fromScale(0.9159417, 0.1808318), Visible = false }, { ["ViralWorkerRef"] = "vw_1b6f00516c" })
						I[26] = new("TextLabel", I[25], "Function", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0241187, 0.0877924), Size = UDim2.fromScale(0.6463196, 0.81), Text = "Base Skin", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_7f44ab39dc" })
							I[27] = new("UIStroke", I[26], "UIStroke", nil, { ["OriginalThickness"] = 1, ["ViralWorkerRef"] = "vw_bfb754d8b9" }, { "ScreenStroke", "UIStroke" })
							I[28] = new("UITextSizeConstraint", I[26], "UITextSizeConstraint", { MaxTextSize = 53 }, { ["ViralWorkerRef"] = "vw_429595a420" })
						I[29] = new("ImageButton", I[25], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(125, 111, 111), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.827, 0.483), Size = UDim2.fromScale(0.284, 0.746) }, { ["ViralWorkerRef"] = "vw_83f086cd89" })
							I[30] = new("UIStroke", I[29], "UIStroke", { Color = Color3.fromRGB(103, 91, 91), Thickness = 1.5 }, { ["OriginalThickness"] = 1.5, ["ViralWorkerRef"] = "vw_f2d072e11c" }, { "ScreenStroke", "UIStroke" })
							I[31] = new("TextLabel", I[29], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0.8488194, 0.5910062), Text = "Default", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_eb838fe851" })
								I[32] = new("UITextSizeConstraint", I[31], "UITextSizeConstraint", { MaxTextSize = 67 }, { ["ViralWorkerRef"] = "vw_6de8434ec6" })
								I[33] = new("UIStroke", I[31], "UIStroke", { Color = Color3.fromRGB(103, 91, 91) }, { ["OriginalThickness"] = 1, ["ViralWorkerRef"] = "vw_467f503d93" }, { "ScreenStroke", "UIStroke" })
							I[34] = new("ImageLabel", I[29], "Polygon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://88203048118743"), Position = UDim2.fromScale(0.8872048, 0.8698202), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1317829, 0.25) }, { ["ViralWorkerRef"] = "vw_cfa031744a" })
							I[35] = new("Frame", I[29], "DropDown", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.498, 3.7969999), Size = UDim2.fromScale(1.2209998, 5.2370214), Visible = false }, { ["ViralWorkerRef"] = "vw_f0e9c75466" })
								I[36] = new("ImageButton", I[35], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(125, 111, 111), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.4999999, 0.0852763), Size = UDim2.fromScale(0.831, 0.19), Visible = false }, { ["ViralWorkerRef"] = "vw_ae86c81476" })
									I[37] = new("TextLabel", I[36], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.849, 0.591), Text = "Golden", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_9d3260de04" })
										I[38] = new("UITextSizeConstraint", I[37], "UITextSizeConstraint", { MaxTextSize = 67 }, { ["ViralWorkerRef"] = "vw_f9f7fe5abd" })
										I[39] = new("UIStroke", I[37], "UIStroke", { Color = Color3.fromRGB(103, 91, 91), Thickness = 1.5 }, { ["OriginalThickness"] = 1.5, ["ViralWorkerRef"] = "vw_8dd49c16a2" }, { "ScreenStroke", "UIStroke" })
									I[40] = new("Frame", I[36], "Locked", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["ViralWorkerRef"] = "vw_9b065d5ff8" })
										I[41] = new("ImageLabel", I[40], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://123877736890165"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.443, 0.6) }, { ["ViralWorkerRef"] = "vw_ec41540f81" })
									I[42] = new("UIStroke", I[36], "UIStroke", { Color = Color3.fromRGB(103, 91, 91), Thickness = 2 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_bb4ca35366" }, { "ScreenStroke", "UIStroke" })
								I[43] = new("UIListLayout", I[35], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, { ["ViralWorkerRef"] = "vw_ab802b0ddd" })
								I[44] = new("UIPadding", I[35], "UIPadding", { PaddingTop = UDim.new(0, 16) }, { ["ViralWorkerRef"] = "vw_470d61b8ce" })
								I[45] = new("Frame", I[35], "Padding", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 99999999, Size = UDim2.fromOffset(0, 8) }, { ["ViralWorkerRef"] = "vw_087a49309b" })
			I[46] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 0.9185674 }, { ["ViralWorkerRef"] = "vw_4a6ea3a4cd" })
	return I[1]
end

return build
