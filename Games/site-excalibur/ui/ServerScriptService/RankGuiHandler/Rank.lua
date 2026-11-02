-- Generated from ui/ServerScriptService/RankGuiHandler/Rank.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Rank", { Active = true, MaxDistance = math.huge, Size = UDim2.fromScale(4, 1.25), StudsOffset = Vector3.new(0, 2, 0) })
		I[2] = new("Frame", I[1], "Background", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.21, 0), Size = UDim2.new(0.6, 0, 1, 1) })
			I[3] = new("TextLabel", I[2], "GangN", { Active = true, AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.2), Size = UDim2.fromScale(1, 0.25), Text = "", TextColor3 = Color3.fromRGB(72, 72, 72), TextScaled = true, TextSize = 18, TextStrokeTransparency = 0.85, TextWrapped = true, ZIndex = 2 })
			I[4] = new("TextLabel", I[2], "UserN", { Active = true, AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.425), Size = UDim2.fromScale(1, 0.35), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 24, TextStrokeTransparency = 0.85, TextWrapped = true, ZIndex = 2 })
				I[5] = new("TextLabel", I[4], "TextLabel", { Active = true, AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(2, 2), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(102, 102, 102), TextScaled = true, TextSize = 18, TextStrokeTransparency = 0.85, TextWrapped = true })
			I[6] = new("TextLabel", I[2], "Rank", { Active = true, AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.75), Size = UDim2.fromScale(1, 0.25), Text = "", TextColor3 = Color3.fromRGB(106, 106, 106), TextScaled = true, TextSize = 18, TextStrokeTransparency = 0.85, TextWrapped = true, ZIndex = 2 })
				I[7] = new("TextLabel", I[6], "TextLabel", { Active = true, AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(2, 2), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(40, 40, 40), TextScaled = true, TextSize = 18, TextStrokeTransparency = 0.85, TextWrapped = true })
	return I[1]
end

return build
