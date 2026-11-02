-- Generated from ui/StarterGui/MusicGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "MusicGui")
		I[2] = new("ImageButton", I[1], "ImageButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=138105553"), Position = UDim2.fromScale(0.945, 0.932), Size = UDim2.fromScale(0.05, 0.06) })
		I[3] = new("Frame", I[1], "MusicPlayer", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderSizePixel = 10, ClipsDescendants = true, Position = UDim2.fromScale(0.3, 0.2), Size = UDim2.fromScale(0.4, 0.6), Visible = false })
			I[4] = new("Frame", I[3], "Frame", { BackgroundColor3 = Color3.fromRGB(131, 131, 131), BackgroundTransparency = 0.9, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.3) })
			I[5] = new("TextButton", I[3], "Close", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(0.03, 0.05), Text = "X", ZIndex = 3 })
			I[6] = new("TextLabel", I[3], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.05), Text = "Music Player", TextColor3 = Color3.fromRGB(0, 0, 0) })
			I[7] = new("Frame", I[3], "Buttons", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
				I[8] = new("TextButton", I[7], "179188345", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2, 0.3), Size = UDim2.fromScale(0.3, 0.1), Text = "Battlefield 4 Theme", TextColor3 = Color3.fromRGB(255, 255, 255) })
				I[9] = new("TextButton", I[7], "161377023", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2, 0.4), Size = UDim2.fromScale(0.3, 0.1), Text = "Halo Theme", TextColor3 = Color3.fromRGB(255, 255, 255) })
				I[10] = new("TextButton", I[7], "173916362", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2, 0.5), Size = UDim2.fromScale(0.3, 0.1), Text = "Battlefield 3 Theme", TextColor3 = Color3.fromRGB(255, 255, 255) })
				I[11] = new("TextButton", I[7], "142397652", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2, 0.6), Size = UDim2.fromScale(0.3, 0.1), Text = "Hunger Games Remix", TextColor3 = Color3.fromRGB(255, 255, 255) })
				I[12] = new("TextButton", I[7], "162869167", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.3, 0.1), Text = "Dean Ambrose Theme", TextColor3 = Color3.fromRGB(255, 255, 255) })
				I[13] = new("TextButton", I[7], "186799913", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.3), Size = UDim2.fromScale(0.3, 0.1), Text = "CoD: Advanced Warfare", TextColor3 = Color3.fromRGB(255, 255, 255) })
				I[14] = new("TextButton", I[7], "183596502", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromScale(0.3, 0.1), Text = "Zombie (3LAU Edit)", TextColor3 = Color3.fromRGB(255, 255, 255) })
				I[15] = new("TextButton", I[7], "181366146", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.6), Size = UDim2.fromScale(0.3, 0.1), Text = "Plants vs Zombies Theme", TextColor3 = Color3.fromRGB(255, 255, 255) })
			I[16] = new("TextLabel", I[3], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.2), Text = "Pick your music for a better expirience!", TextColor3 = Color3.fromRGB(0, 0, 0), TextStrokeTransparency = 0.95 })
			I[17] = new("TextLabel", I[3], "OR", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.75), Text = "OR" })
			I[18] = new("TextBox", I[3], "TextBox", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(105, 122, 94), BorderSizePixel = 2, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2, 0.8), Size = UDim2.fromScale(0.4, 0.1), Text = "Enter Music ID", TextColor3 = Color3.fromRGB(255, 255, 255) })
			I[19] = new("TextButton", I[3], "Click", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6, 0.8), Size = UDim2.fromScale(0.2, 0.1), Style = Enum.ButtonStyle.RobloxRoundButton, Text = "Play" })
	return I[1]
end

return build
