-- Generated from ui/ReplicatedStorage/Assets/RankTexts/The Ascension.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "The Ascension", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic), LayoutOrder = 10, Position = UDim2.fromScale(-0.0476135, 0.441235), Size = UDim2.fromScale(0.5438121, 0.1884058), Text = "The Ascension", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[2] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(56, 56, 56), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
		I[3] = new("UIGradient", I[1], "CRIMSON_OMNIGOD", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 200)), ColorSequenceKeypoint.new(0.1, Color3.fromRGB(255, 120, 0)), ColorSequenceKeypoint.new(0.25, Color3.fromRGB(200, 0, 0)), ColorSequenceKeypoint.new(0.4, Color3.fromRGB(80, 0, 20)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.6, Color3.fromRGB(80, 0, 20)), ColorSequenceKeypoint.new(0.75, Color3.fromRGB(200, 0, 0)), ColorSequenceKeypoint.new(0.9, Color3.fromRGB(255, 120, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 85, 0)) }), Rotation = 90 })
	return I[1]
end

return build
