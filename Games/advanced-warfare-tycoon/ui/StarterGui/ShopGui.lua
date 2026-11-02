-- Generated from ui/StarterGui/ShopGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ShopGui")
		I[2] = new("Frame", I[1], "Buttons", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.4), Size = UDim2.fromScale(0.12, 0.36) })
			I[3] = new("TextButton", I[2], "22339512", { BackgroundColor3 = Color3.fromRGB(58, 58, 58), BackgroundTransparency = 0.4, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.22, 0.07), Size = UDim2.fromScale(0.6, 0.1), Text = "$5,000", TextColor3 = Color3.fromRGB(255, 255, 255) })
				I[4] = new("ImageLabel", I[3], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.9, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=201850620"), Position = UDim2.fromScale(-0.3, 0), Size = UDim2.fromScale(0.275, 1) })
				I[5] = new("Frame", I[3], "Frame", { BackgroundColor3 = Color3.fromRGB(55, 255, 0), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.fromScale(0, -0.1), Size = UDim2.fromScale(1, 0.1) })
			I[6] = new("TextButton", I[2], "22339541", { BackgroundColor3 = Color3.fromRGB(58, 58, 58), BackgroundTransparency = 0.4, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.22, 0.21), Size = UDim2.fromScale(0.6, 0.1), Text = "Minigun ", TextColor3 = Color3.fromRGB(255, 255, 255) })
				I[7] = new("ImageLabel", I[6], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.9, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=201850659"), Position = UDim2.fromScale(-0.3, 0), Size = UDim2.fromScale(0.275, 1) })
				I[8] = new("Frame", I[6], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.fromScale(0, -0.1), Size = UDim2.fromScale(1, 0.1) })
			I[9] = new("TextButton", I[2], "22339545", { BackgroundColor3 = Color3.fromRGB(58, 58, 58), BackgroundTransparency = 0.4, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.22, 0.34), Size = UDim2.fromScale(0.6, 0.1), Text = "+10 Speed", TextColor3 = Color3.fromRGB(255, 255, 255) })
				I[10] = new("ImageLabel", I[9], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.9, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=201844182"), Position = UDim2.fromScale(-0.3, 0), Size = UDim2.fromScale(0.275, 1) })
				I[11] = new("Frame", I[9], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 255, 238), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.fromScale(0, -0.1), Size = UDim2.fromScale(1, 0.1) })
			I[12] = new("TextButton", I[2], "22339544", { BackgroundColor3 = Color3.fromRGB(58, 58, 58), BackgroundTransparency = 0.4, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.22, 0.48), Size = UDim2.fromScale(0.6, 0.1), Text = "+25 HP", TextColor3 = Color3.fromRGB(255, 255, 255) })
				I[13] = new("ImageLabel", I[12], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.9, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=201844201"), Position = UDim2.fromScale(-0.3, 0), Size = UDim2.fromScale(0.275, 1) })
				I[14] = new("Frame", I[12], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 0, 4), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.fromScale(0, -0.09), Size = UDim2.fromScale(1, 0.1) })
			I[15] = new("TextButton", I[2], "22339542", { BackgroundColor3 = Color3.fromRGB(58, 58, 58), BackgroundTransparency = 0.4, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.22, 0.615), Size = UDim2.fromScale(0.6, 0.1), Text = "Jetpack", TextColor3 = Color3.fromRGB(255, 255, 255) })
				I[16] = new("ImageLabel", I[15], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.9, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=201850643"), Position = UDim2.fromScale(-0.3, 0), Size = UDim2.fromScale(0.275, 1) })
				I[17] = new("Frame", I[15], "Frame", { BackgroundColor3 = Color3.fromRGB(226, 0, 255), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.fromScale(0, -0.1), Size = UDim2.fromScale(1, 0.1) })
			I[18] = new("TextButton", I[2], "22339514", { BackgroundColor3 = Color3.fromRGB(58, 58, 58), BackgroundTransparency = 0.4, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.22, 0.76), Size = UDim2.fromScale(0.6, 0.1), Text = "$25,000", TextColor3 = Color3.fromRGB(255, 255, 255) })
				I[19] = new("ImageLabel", I[18], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.9, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=193727678"), Position = UDim2.fromScale(-0.3, 0), Size = UDim2.fromScale(0.275, 1) })
				I[20] = new("Frame", I[18], "Frame", { BackgroundColor3 = Color3.fromRGB(59, 148, 43), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.fromScale(0, -0.1), Size = UDim2.fromScale(1, 0.1) })
			I[21] = new("TextButton", I[2], "22350023", { BackgroundColor3 = Color3.fromRGB(58, 58, 58), BackgroundTransparency = 0.4, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.6, -0.07), Size = UDim2.fromScale(0.6, 0.1), Text = "NUKE", TextColor3 = Color3.fromRGB(255, 255, 255) })
				I[22] = new("ImageLabel", I[21], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.9, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=142669951"), Position = UDim2.fromScale(-0.3, 0), Size = UDim2.fromScale(0.275, 1) })
				I[23] = new("Frame", I[21], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 85, 0), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.fromScale(0, -0.1), Size = UDim2.fromScale(1, 0.1) })
			I[24] = new("TextButton", I[2], "22381579", { BackgroundColor3 = Color3.fromRGB(58, 58, 58), BackgroundTransparency = 0.4, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.22, 0.9), Size = UDim2.fromScale(0.6, 0.1), Text = "Heatseeking Rocket", TextColor3 = Color3.fromRGB(255, 152, 34) })
				I[25] = new("ImageLabel", I[24], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.9, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=52054360"), Position = UDim2.fromScale(-0.3, 0), Size = UDim2.fromScale(0.275, 1) })
				I[26] = new("Frame", I[24], "Frame", { BackgroundColor3 = Color3.fromRGB(148, 0, 2), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.fromScale(0, -0.1), Size = UDim2.fromScale(1, 0.1) })
		I[27] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.01, 0.36), Text = "SHOP", TextColor3 = Color3.fromRGB(0, 0, 0), TextStrokeColor3 = Color3.fromRGB(30, 27, 11), TextStrokeTransparency = 0.8, TextXAlignment = Enum.TextXAlignment.Left })
		I[28] = new("Frame", I[1], "vpi", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.3, 0.23), Size = UDim2.fromScale(0.5, 0.6), Visible = false })
			I[29] = new("TextButton", I[28], "Normal", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 240, 233), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(0.5, 0.25), Text = "Normal VIP", TextColor3 = Color3.fromRGB(255, 0, 0) })
			I[30] = new("TextButton", I[28], "speed", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 240, 233), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.25), Size = UDim2.fromScale(0.5, 0.25), Text = "Ultra VIP", TextColor3 = Color3.fromRGB(251, 255, 15) })
			I[31] = new("TextButton", I[28], "Cash", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 240, 233), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.5, 0.25), Text = "Cash Bonus", TextColor3 = Color3.fromRGB(0, 255, 0) })
			I[32] = new("TextButton", I[28], "n/a", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 240, 233), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.752), Size = UDim2.fromScale(0.5, 0.25), Text = "Admin", TextColor3 = Color3.fromRGB(236, 25, 255), Visible = false })
			I[33] = new("TextLabel", I[28], "TextLabel", { BackgroundColor3 = Color3.fromRGB(22, 148, 0), BackgroundTransparency = 0.7, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.1), Size = UDim2.fromScale(1, 0.1), Text = "Gamepasses:", TextColor3 = Color3.fromRGB(0, 0, 0) })
				I[34] = new("TextButton", I[33], "Close", { BackgroundColor3 = Color3.fromRGB(193, 193, 193), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(193, 193, 193), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9, 0.06), Size = UDim2.fromScale(0.09, 0.8), Text = "Exit", TextColor3 = Color3.fromRGB(255, 0, 0), TextStrokeTransparency = 0 })
			I[35] = new("TextLabel", I[28], "Item", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.51, 0.05), Size = UDim2.fromScale(0.4, 0.05), Text = "Item: ", TextColor3 = Color3.fromRGB(255, 255, 255), TextXAlignment = Enum.TextXAlignment.Left })
			I[36] = new("TextLabel", I[28], "Cost1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.51, 0.15), Size = UDim2.fromScale(0.4, 0.05), Text = "Cost:", TextColor3 = Color3.fromRGB(255, 255, 255), TextXAlignment = Enum.TextXAlignment.Left })
			I[37] = new("TextLabel", I[28], "Description1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.51, 0.25), Size = UDim2.fromScale(0.4, 0.55), Text = "Description:", TextColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
			I[38] = new("TextButton", I[28], "Buy", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 240, 233), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6, 0.83), Size = UDim2.fromScale(0.3, 0.15), Style = Enum.ButtonStyle.RobloxRoundButton, Text = "Buy", TextColor3 = Color3.fromRGB(0, 0, 0) })
			I[39] = new("StringValue", I[28], "ID")
		I[40] = new("TextButton", I[1], "vip", { BackgroundColor3 = Color3.fromRGB(193, 0, 3), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(106, 0, 255), FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.84, 0.94), Size = UDim2.fromScale(0.1, 0.055), Text = "VIP Shop", TextColor3 = Color3.fromRGB(0, 0, 0) })
		I[41] = new("TextButton", I[1], "heet", { BackgroundColor3 = Color3.fromRGB(193, 118, 33), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(106, 0, 255), FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.01, 0.85), Size = UDim2.fromScale(0.1, 0.055), Text = "Heat Seeking Rocket PERM!", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextWrapped = true })
	return I[1]
end

return build
