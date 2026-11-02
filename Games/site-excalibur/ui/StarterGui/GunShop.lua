-- Generated from ui/StarterGui/GunShop.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GunShop", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(76, 76, 76), Position = UDim2.fromScale(0.1693923, 0.0907127), Size = UDim2.fromOffset(636, 379), Visible = false })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 9), BottomRightRadius = UDim.new(0, 9), TopLeftRadius = UDim.new(0, 9), TopRightRadius = UDim.new(0, 9) })
			I[4] = new("Frame", I[2], "Frame2", { BackgroundColor3 = Color3.fromRGB(54, 54, 54), Position = UDim2.fromScale(0.0157233, 0.0273708), Size = UDim2.fromOffset(616, 357) })
				I[5] = new("UICorner", I[4], "UICorner")
				I[6] = new("ScrollingFrame", I[4], "ScrollingFrame", { Active = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(-0.001626, 0.0172658), ScrollBarImageColor3 = Color3.fromRGB(38, 38, 38), ScrollBarThickness = 5, Size = UDim2.fromOffset(617, 344) })
					I[7] = new("Frame", I[6], "CL3Frame", { BackgroundColor3 = Color3.fromRGB(76, 76, 76), Position = UDim2.fromScale(0.0291734, 0.0109683), Size = UDim2.fromOffset(581, 100) })
						I[8] = new("UICorner", I[7], "UICorner")
						I[9] = new("ImageLabel", I[7], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.0154905, 0.07), Size = UDim2.fromOffset(85, 85) })
							I[10] = new("UICorner", I[9], "UICorner")
						I[11] = new("TextLabel", I[7], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1497418, 0.07), Size = UDim2.fromOffset(110, 27), Text = "CL-3", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 30, TextWrapped = true })
						I[12] = new("TextLabel", I[7], "Design", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Position = UDim2.new(0.181, 1, 0.33, 4), Size = UDim2.fromScale(0.77, 0.028), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
							I[13] = new("UICorner", I[12], "UICorner")
						I[14] = new("TextLabel", I[7], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1049914, 0.3500001), Size = UDim2.fromOffset(539, 26), Text = "Clearance - 3 Keycard gives you access to most of the site.", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 12, TextWrapped = true })
						I[15] = new("TextButton", I[7], "TextButton", { BackgroundColor3 = Color3.fromRGB(41, 125, 0), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1827212, 0.6799999), Size = UDim2.fromOffset(446, 23), Text = "PURCHASE CL-3 FOR 250$", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 21, TextWrapped = true })
							I[16] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0, 6), BottomRightRadius = UDim.new(0, 6), TopLeftRadius = UDim.new(0, 6), TopRightRadius = UDim.new(0, 6) })
						I[17] = new("TextLabel", I[7], "Design", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Position = UDim2.new(0.181, 1, 0.52, 4), Size = UDim2.fromScale(0.77, 0.028), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
							I[18] = new("UICorner", I[17], "UICorner")
						I[19] = new("TextLabel", I[7], "Design", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Position = UDim2.new(0.181, 1, 0.85, 4), Size = UDim2.fromScale(0.77, 0.028), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
							I[20] = new("UICorner", I[19], "UICorner")
					I[21] = new("Frame", I[6], "ACRFrame", { BackgroundColor3 = Color3.fromRGB(76, 76, 76), Position = UDim2.fromScale(0.0296207, 0.172), Size = UDim2.fromOffset(581, 100) })
						I[22] = new("UICorner", I[21], "UICorner")
						I[23] = new("ImageLabel", I[21], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.0154905, 0.07), Size = UDim2.fromOffset(85, 85) })
							I[24] = new("UICorner", I[23], "UICorner")
						I[25] = new("TextLabel", I[21], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.161315, 0.07), Size = UDim2.fromOffset(103, 27), Text = "ACR1", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 30, TextWrapped = true })
						I[26] = new("TextLabel", I[21], "Design", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Position = UDim2.new(0.181, 1, 0.33, 4), Size = UDim2.fromScale(0.77, 0.028), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
							I[27] = new("UICorner", I[26], "UICorner")
						I[28] = new("TextLabel", I[21], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1049914, 0.3500001), Size = UDim2.fromOffset(539, 26), Text = "An assault rifle perfect for far range engagments.", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 12, TextWrapped = true })
						I[29] = new("TextButton", I[21], "TextButton", { BackgroundColor3 = Color3.fromRGB(41, 125, 0), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1827212, 0.6799999), Size = UDim2.fromOffset(446, 23), Text = "PURCHASE ACR1 FOR 300$", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 21, TextWrapped = true })
							I[30] = new("UICorner", I[29], "UICorner", { BottomLeftRadius = UDim.new(0, 6), BottomRightRadius = UDim.new(0, 6), TopLeftRadius = UDim.new(0, 6), TopRightRadius = UDim.new(0, 6) })
						I[31] = new("TextLabel", I[21], "Design", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Position = UDim2.new(0.181, 1, 0.52, 4), Size = UDim2.fromScale(0.77, 0.028), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
							I[32] = new("UICorner", I[31], "UICorner")
						I[33] = new("TextLabel", I[21], "Design", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Position = UDim2.new(0.181, 1, 0.85, 4), Size = UDim2.fromScale(0.77, 0.028), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
							I[34] = new("UICorner", I[33], "UICorner")
					I[35] = new("Frame", I[6], "G17Frame", { BackgroundColor3 = Color3.fromRGB(76, 76, 76), Position = UDim2.fromScale(0.0296207, 0.333), Size = UDim2.fromOffset(581, 100) })
						I[36] = new("UICorner", I[35], "UICorner")
						I[37] = new("ImageLabel", I[35], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.0154905, 0.07), Size = UDim2.fromOffset(85, 85) })
							I[38] = new("UICorner", I[37], "UICorner")
						I[39] = new("TextLabel", I[35], "Design", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Position = UDim2.new(0.181, 1, 0.33, 4), Size = UDim2.fromScale(0.77, 0.028), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
							I[40] = new("UICorner", I[39], "UICorner")
						I[41] = new("TextLabel", I[35], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1045163, 0.35), Size = UDim2.fromOffset(539, 26), Text = "A Pistol suited for close-range incounters.", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 12, TextWrapped = true })
							I[42] = new("TextLabel", I[41], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1497418, 0.07), Size = UDim2.fromOffset(110, 27), Text = "MK18", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 30, TextWrapped = true })
						I[43] = new("TextButton", I[35], "TextButton", { BackgroundColor3 = Color3.fromRGB(41, 125, 0), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1827212, 0.6799999), Size = UDim2.fromOffset(446, 23), Text = "PURCHASE G-17 FOR 350$", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 21, TextWrapped = true })
							I[44] = new("UICorner", I[43], "UICorner", { BottomLeftRadius = UDim.new(0, 6), BottomRightRadius = UDim.new(0, 6), TopLeftRadius = UDim.new(0, 6), TopRightRadius = UDim.new(0, 6) })
						I[45] = new("TextLabel", I[35], "Design", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Position = UDim2.new(0.181, 1, 0.52, 4), Size = UDim2.fromScale(0.77, 0.028), Text = "G-17", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
							I[46] = new("UICorner", I[45], "UICorner")
						I[47] = new("TextLabel", I[35], "Design", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Position = UDim2.new(0.181, 1, 0.85, 4), Size = UDim2.fromScale(0.77, 0.028), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
							I[48] = new("UICorner", I[47], "UICorner")
			I[49] = new("ImageButton", I[2], "ImageButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(44, 44, 44), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=7170557498"), Position = UDim2.fromScale(0.9585372, 0.0263852), Size = UDim2.fromOffset(18, 18) })
	return I[1]
end

return build
