-- Generated from ui/ReplicatedFirst/UISelector/Loading/GamemodePhone.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GamemodePhone")
		I[2] = new("Frame", I[1], "BG", { BackgroundColor3 = Color3.fromRGB(12, 12, 12), Size = UDim2.fromScale(1, 1) })
		I[3] = new("Frame", I[1], "Select", { Active = true, BackgroundColor3 = Color3.fromRGB(86, 86, 86), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, -200, 0.5, -400), Size = UDim2.fromOffset(400, 400) })
			I[4] = new("TextLabel", I[3], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, -50), Size = UDim2.new(1, 0, 0, 50), Text = "Select Gamemode (BETA)", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 36 })
			I[5] = new("Frame", I[3], "Casual", { BackgroundColor3 = Color3.fromRGB(0, 126, 180), BorderSizePixel = 0, Size = UDim2.fromScale(0.5, 1) })
				I[6] = new("ImageLabel", I[5], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.8, BorderSizePixel = 0, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=238046440"), Position = UDim2.fromOffset(10, 10), Size = UDim2.fromOffset(180, 180), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 2 })
				I[7] = new("TextButton", I[5], "Play", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 5, 1, -50), Size = UDim2.fromOffset(190, 45), Style = Enum.ButtonStyle.RobloxRoundDefaultButton, Text = "Play", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 28, TextStrokeTransparency = 0.7 })
				I[8] = new("TextLabel", I[5], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, 190), Size = UDim2.fromOffset(200, 25), Text = "Casual", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextStrokeTransparency = 0.7 })
				I[9] = new("Frame", I[5], "Descirption", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9, BorderSizePixel = 0, Position = UDim2.fromOffset(10, 220), Size = UDim2.fromOffset(180, 120) })
					I[10] = new("TextLabel", I[9], "1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(5, 0), Size = UDim2.new(1, 0, 0, 20), Text = "+ Zooming in and out", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.7, TextXAlignment = Enum.TextXAlignment.Left })
					I[11] = new("TextLabel", I[9], "2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(5, 20), Size = UDim2.new(1, 0, 0, 20), Text = "+ Your own character", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.7, TextXAlignment = Enum.TextXAlignment.Left })
					I[12] = new("TextLabel", I[9], "3", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(5, 40), Size = UDim2.new(1, 0, 0, 20), Text = "+ Radio allowed", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.7, TextXAlignment = Enum.TextXAlignment.Left })
					I[13] = new("TextLabel", I[9], "4", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(5, 60), Size = UDim2.new(1, 0, 0, 20), Text = "+ Pets & Toys allowed", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.7, TextXAlignment = Enum.TextXAlignment.Left })
					I[14] = new("TextLabel", I[9], "5", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(5, 80), Size = UDim2.new(1, 0, 0, 20), Text = "Pets coming soon!", TextColor3 = Color3.fromRGB(182, 182, 182), TextSize = 18, TextStrokeTransparency = 0.7, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[15] = new("Frame", I[3], "Hardcore", { BackgroundColor3 = Color3.fromRGB(75, 75, 75), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.5, 1) })
				I[16] = new("ImageLabel", I[15], "Icon", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderSizePixel = 0, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=238043230"), Position = UDim2.fromOffset(10, 10), Size = UDim2.fromOffset(180, 180), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 2 })
				I[17] = new("TextButton", I[15], "Play", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 5, 1, -50), Size = UDim2.fromOffset(190, 45), Style = Enum.ButtonStyle.RobloxRoundButton, Text = "Play", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 28, TextStrokeTransparency = 0.7 })
				I[18] = new("TextLabel", I[15], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, 190), Size = UDim2.fromOffset(200, 25), Text = "Hardcore", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextStrokeTransparency = 0.7 })
				I[19] = new("Frame", I[15], "Descirption", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9, BorderSizePixel = 0, Position = UDim2.fromOffset(10, 220), Size = UDim2.fromOffset(180, 120) })
					I[20] = new("TextLabel", I[19], "1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(5, 0), Size = UDim2.new(1, 0, 0, 20), Text = "+ First Person only", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.7, TextXAlignment = Enum.TextXAlignment.Left })
					I[21] = new("TextLabel", I[19], "2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(5, 20), Size = UDim2.new(1, 0, 0, 20), Text = "+ Characters disguised", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.7, TextXAlignment = Enum.TextXAlignment.Left })
					I[22] = new("TextLabel", I[19], "3", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(5, 40), Size = UDim2.new(1, 0, 0, 20), Text = "+ NO Radio", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.7, TextXAlignment = Enum.TextXAlignment.Left })
					I[23] = new("TextLabel", I[19], "4", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(5, 60), Size = UDim2.new(1, 0, 0, 20), Text = "+ NO Pets & Toys", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.7, TextXAlignment = Enum.TextXAlignment.Left })
					I[24] = new("TextLabel", I[19], "5", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(5, 80), Size = UDim2.new(1, -10, 0, 40), Text = "+ Only play with other Hardcore players", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.7, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
			I[25] = new("Frame", I[3], "Divider", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(0, 1, 1, 0) })
			I[26] = new("TextLabel", I[3], "Note", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 30), Text = "You can switch your gamemode after at any time", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18 })
		I[27] = new("TextLabel", I[1], "Loading", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Loading", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 48, Visible = false, ZIndex = 2 })
	return I[1]
end

return build
