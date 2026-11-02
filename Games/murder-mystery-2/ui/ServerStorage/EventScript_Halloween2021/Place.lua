-- Generated from ui/ServerStorage/EventScript_Halloween2021/Place.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Place", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 235), Size = UDim2.new(1, 0, 0, 40) })
		I[2] = new("Frame", I[1], "Container", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.9, BorderSizePixel = 0, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 1, -6) })
			I[3] = new("TextLabel", I[2], "TokenCount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Size = UDim2.new(1, -3, 1, 0), Text = "10,500 tokens", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextStrokeTransparency = 0.7, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
			I[4] = new("TextLabel", I[2], "Username", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(3, 0), Size = UDim2.new(1, -93, 1, 0), Text = "#4 - OnlyTwentyCharacters", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 23, TextStrokeTransparency = 0.7, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
	return I[1]
end

return build
