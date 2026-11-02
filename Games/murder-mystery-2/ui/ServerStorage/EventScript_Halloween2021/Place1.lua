-- Generated from ui/ServerStorage/EventScript_Halloween2021/Place1.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Place1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 100) })
		I[2] = new("Frame", I[1], "Container", { BackgroundColor3 = Color3.fromRGB(255, 204, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromOffset(5, 5), Size = UDim2.new(1, -10, 1, -10) })
			I[3] = new("TextLabel", I[2], "TokenCount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(93, 45), Size = UDim2.new(1, -93, 1, 0), Text = "10,500 tokens", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 28, TextStrokeTransparency = 0.7, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
			I[4] = new("TextLabel", I[2], "Username", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(93, 0), Size = UDim2.new(1, -93, 1, 0), Text = "#1 - OnlyTwentyCharacters", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 45, TextStrokeTransparency = 0.7, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
			I[5] = new("ImageLabel", I[2], "PlayerImage", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.9, BorderSizePixel = 0, Size = UDim2.new(0, 90, 1, 0) })
	return I[1]
end

return build
