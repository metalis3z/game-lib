-- Generated from ui/ReplicatedStorage/Assets/RankTexts/Supreme.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Supreme", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 10, Position = UDim2.fromScale(0.3459792, 0.0682184), Size = UDim2.fromScale(0.3079777, 0.1948261), Text = "Supreme", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[2] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(40, 40, 40), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
		I[3] = new("UIGradient", I[1], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 18, 18)), ColorSequenceKeypoint.new(0.2482394, Color3.fromRGB(9, 9, 9)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 51, 0)), ColorSequenceKeypoint.new(0.7570422, Color3.fromRGB(18, 18, 18)), ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 22)) }), Rotation = -90 })
	return I[1]
end

return build
