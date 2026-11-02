-- Generated from ui/ReplicatedStorage/Assets/RankTexts/Nemesis.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Nemesis", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 10, Position = UDim2.fromScale(-0.0788381, 0.1958742), Size = UDim2.fromScale(0.5438121, 0.1884058), Text = "Nemesis", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[2] = new("UIStroke", I[1], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
		I[3] = new("UIGradient", I[1], "Nebula_Core", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 30)), ColorSequenceKeypoint.new(0.2, Color3.fromRGB(80, 0, 160)), ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 180, 255)), ColorSequenceKeypoint.new(0.6, Color3.fromRGB(200, 0, 255)), ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 80, 180)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 30)) }), Rotation = 90 })
	return I[1]
end

return build
