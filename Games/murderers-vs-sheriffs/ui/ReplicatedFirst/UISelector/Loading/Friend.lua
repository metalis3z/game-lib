-- Generated from ui/ReplicatedFirst/UISelector/Loading/Friend.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Friend", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30) })
		I[2] = new("TextLabel", I[1], "PlayerName", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(5, 0), Size = UDim2.new(0.5, 10, 1, 0), Text = "OnlyTwentyCharacters", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextXAlignment = Enum.TextXAlignment.Left })
		I[3] = new("TextLabel", I[1], "GameMode", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(0.8, 1), Text = "Casual", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Right })
		I[4] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 1) })
		I[5] = new("TextButton", I[1], "Join", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8, 0), Size = UDim2.fromScale(0.2, 1), Style = Enum.ButtonStyle.RobloxRoundButton, Text = "Join", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.7 })
	return I[1]
end

return build
