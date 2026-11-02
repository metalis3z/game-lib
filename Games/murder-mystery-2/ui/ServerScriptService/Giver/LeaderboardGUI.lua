-- Generated from ui/ServerScriptService/Giver/LeaderboardGUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LeaderboardGUI", { Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "MainFrame", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), BorderSizePixel = 20, Position = UDim2.new(0.5, -236, 0.5, -141), Size = UDim2.fromOffset(473, 395) })
			I[3] = new("TextButton", I[2], "WipeLeaderboardTokens", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.2561614), Size = UDim2.fromOffset(234, 291), Text = "Wipe Leaderboard Tokens", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[4] = new("TextBox", I[2], "PlayerName", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "Enter the player's name here! (E.g. AniDarkness)", Position = UDim2.fromScale(-0.0021142, -0.0020665), Size = UDim2.fromOffset(428, 34), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[5] = new("TextButton", I[2], "TextButton", { BackgroundColor3 = Color3.fromRGB(255, 0, 4), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9027484, -0.0001252), Size = UDim2.fromOffset(46, 34), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[6] = new("TextButton", I[2], "GiveLeaderboardItems", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4947146, 0.2561614), Size = UDim2.fromOffset(239, 292), Text = "Give Leaderboard Item", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[7] = new("TextBox", I[2], "ItemName", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "Enter the item name here! (E.g. Candy)", Position = UDim2.fromScale(0, 0.0840095), Size = UDim2.fromOffset(473, 34), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[8] = new("TextBox", I[2], "Rank", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "Enter the player's rank here!", Position = UDim2.fromScale(-0.0021142, 0.1700854), Size = UDim2.fromOffset(473, 34), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
	return I[1]
end

return build
