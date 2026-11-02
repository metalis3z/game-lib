-- Generated from ui/ReplicatedStorage/Templates/LeaderboardEntry.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "LeaderboardEntry", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.65, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.03) })
		I[2] = new("TextLabel", I[1], "RankLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.15, 0.8), Text = "#0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 40, TextStrokeColor3 = Color3.fromRGB(30, 30, 30), TextStrokeTransparency = 0, TextWrapped = true })
			I[3] = new("UIStroke", I[2], "Stroke", { Thickness = 3 })
		I[4] = new("TextLabel", I[1], "NameLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.5), Size = UDim2.fromScale(0.45, 0.8), Text = "Player0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 40, TextStrokeTransparency = 0, TextWrapped = true })
			I[5] = new("UIStroke", I[4], "Stroke", { Thickness = 3 })
		I[6] = new("TextLabel", I[1], "ScoreLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.62, 0.5), Size = UDim2.fromScale(0.34, 0.8), Text = "0s", TextColor3 = Color3.fromRGB(255, 200, 0), TextScaled = true, TextSize = 40, TextStrokeTransparency = 0, TextWrapped = true })
			I[7] = new("UIStroke", I[6], "Stroke", { Thickness = 3 })
		I[8] = new("UICorner", I[1], "UICorner")
	return I[1]
end

return build
