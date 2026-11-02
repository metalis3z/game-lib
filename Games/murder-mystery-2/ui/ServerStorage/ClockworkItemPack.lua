-- Generated from ui/ServerStorage/ClockworkItemPack.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "ClockworkItemPack", { BackgroundColor3 = Color3.fromRGB(17, 17, 17), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 5, Position = UDim2.new(0.5, -275, 0.5, -190), Size = UDim2.fromOffset(600, 400), Visible = false })
		I[2] = new("ImageLabel", I[1], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=360597458"), Position = UDim2.new(0.5, -275, 0, -25), Size = UDim2.fromOffset(550, 50) })
		I[3] = new("ImageLabel", I[1], "Godly", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=360598620"), Position = UDim2.fromOffset(-70, 40), Rotation = -5, Size = UDim2.fromOffset(450, 41) })
		I[4] = new("TextLabel", I[1], "Old", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -35, 1, -100), Size = UDim2.fromOffset(70, 50), Text = "900R", TextColor3 = Color3.fromRGB(121, 121, 121), TextSize = 42, Visible = false })
			I[5] = new("Frame", I[4], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0, 2), ZIndex = 2 })
		I[6] = new("TextLabel", I[1], "New", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -50, 1, -60), Size = UDim2.fromOffset(100, 50), Text = "600R", TextColor3 = Color3.fromRGB(0, 199, 0), TextSize = 60, Visible = false })
		I[7] = new("Frame", I[1], "Knife", { BackgroundColor3 = Color3.fromRGB(12, 12, 12), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 5, Position = UDim2.fromOffset(10, 100), Size = UDim2.fromOffset(180, 180) })
			I[8] = new("ImageLabel", I[7], "Clockwork", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=360610146"), Position = UDim2.fromOffset(-10, 0), Rotation = 5, Size = UDim2.new(1, 20, 1, 0) })
			I[9] = new("TextLabel", I[7], "ItemName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 5, 1, -40), Size = UDim2.fromOffset(200, 40), Text = "Clockwork", TextColor3 = Color3.fromRGB(255, 0, 255), TextSize = 32, TextXAlignment = Enum.TextXAlignment.Left, Visible = false })
			I[10] = new("TextLabel", I[7], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 30), Text = "Godly Knife", TextColor3 = Color3.fromRGB(255, 0, 255), TextSize = 28, Visible = false })
			I[11] = new("ImageLabel", I[7], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=360667753"), Position = UDim2.fromOffset(0, 3), Size = UDim2.fromOffset(180, 30) })
			I[12] = new("ImageLabel", I[7], "ItemName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=360668256"), Position = UDim2.new(0, 3, 1, -36), Size = UDim2.fromOffset(180, 36) })
		I[13] = new("Frame", I[1], "Effects", { BackgroundColor3 = Color3.fromRGB(12, 12, 12), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 5, Position = UDim2.fromOffset(210, 100), Size = UDim2.fromOffset(180, 180) })
			I[14] = new("ImageLabel", I[13], "Clockwork", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=360666852"), Size = UDim2.fromScale(1, 1) })
			I[15] = new("TextLabel", I[13], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 5, 1, -40), Size = UDim2.fromOffset(200, 40), Text = "Gear Storm", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 32, TextXAlignment = Enum.TextXAlignment.Left, Visible = false })
			I[16] = new("ImageLabel", I[13], "ItemName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=360669077"), Position = UDim2.new(0, 3, 1, -36), Size = UDim2.fromOffset(180, 36) })
			I[17] = new("ImageLabel", I[13], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=360669196"), Position = UDim2.fromOffset(0, 3), Size = UDim2.fromOffset(180, 30) })
		I[18] = new("Frame", I[1], "Pet", { BackgroundColor3 = Color3.fromRGB(12, 12, 12), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 5, Position = UDim2.fromOffset(410, 100), Size = UDim2.fromOffset(180, 180) })
			I[19] = new("ImageLabel", I[18], "Clockwork", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=360618881"), Size = UDim2.fromScale(1, 1) })
			I[20] = new("TextLabel", I[18], "ItemName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 5, 1, -40), Size = UDim2.fromOffset(200, 40), Text = "Steambird", TextColor3 = Color3.fromRGB(255, 0, 255), TextSize = 32, TextXAlignment = Enum.TextXAlignment.Left, Visible = false })
			I[21] = new("TextLabel", I[18], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 30), Text = "Godly Pet", TextColor3 = Color3.fromRGB(255, 0, 255), TextSize = 28, Visible = false })
			I[22] = new("ImageLabel", I[18], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=360667823"), Position = UDim2.fromOffset(0, 3), Size = UDim2.fromOffset(180, 30) })
			I[23] = new("ImageLabel", I[18], "ItemName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=360668750"), Position = UDim2.new(0, 3, 1, -36), Size = UDim2.fromOffset(180, 36) })
		I[24] = new("ImageLabel", I[1], "Timer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=360623295"), Position = UDim2.new(1, -180, 0, 30), Size = UDim2.fromOffset(50, 50) })
			I[25] = new("TextLabel", I[24], "TimeLeft", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(50, 0), Size = UDim2.fromOffset(120, 30), Text = "48:38:07", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 36 })
			I[26] = new("TextLabel", I[24], "Days", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(50, 30), Size = UDim2.fromOffset(120, 20), Text = "2 days left!", TextColor3 = Color3.fromRGB(255, 0, 0), TextSize = 28 })
		I[27] = new("TextLabel", I[1], "PackName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -175, 0, 290), Size = UDim2.fromOffset(350, 30), Text = "Clockwork Item Pack", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 42, Visible = false })
		I[28] = new("TextLabel", I[1], "OldPrice", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -160, 0, 310), Size = UDim2.fromOffset(150, 40), Text = "1200R", TextColor3 = Color3.fromRGB(107, 107, 107), TextSize = 42, TextXAlignment = Enum.TextXAlignment.Right })
			I[29] = new("Frame", I[28], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4, 0.5), Size = UDim2.new(0.6, 0, 0, 2), ZIndex = 2 })
		I[30] = new("TextLabel", I[1], "SalePrice", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -160, 0, 350), Size = UDim2.fromOffset(150, 40), Text = "899R", TextColor3 = Color3.fromRGB(0, 191, 0), TextSize = 60, TextStrokeColor3 = Color3.fromRGB(0, 191, 0), TextStrokeTransparency = 0.7, TextXAlignment = Enum.TextXAlignment.Right })
		I[31] = new("TextButton", I[1], "Buy", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -150, 0, 345), Size = UDim2.fromOffset(300, 45), Style = Enum.ButtonStyle.RobloxRoundDefaultButton, Text = "GET IT NOW!", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 32, TextStrokeTransparency = 0.7 })
			I[32] = new("TextButton", I[31], "Cancel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(-45, -7), Size = UDim2.fromOffset(35, 35), Style = Enum.ButtonStyle.RobloxRoundButton, Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 32, TextStrokeTransparency = 0.7 })
		I[33] = new("ImageLabel", I[1], "ItemPackName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(227, 213, 51), ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=360669658"), Position = UDim2.new(0.5, -175, 0, 290), Size = UDim2.fromOffset(350, 50), ZIndex = 2 })
	return I[1]
end

return build
