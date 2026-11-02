-- Generated from ui/ReplicatedStorage/Assets/RankTexts/The Ultimate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "The Ultimate", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic), LayoutOrder = 10, Position = UDim2.fromScale(0.3843718, 0.2474206), Size = UDim2.fromScale(0.5438121, 0.1884058), Text = "Simply Better", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[2] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(56, 56, 56), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
		I[3] = new("UIGradient", I[1], "ABYSSAL_DIVINITY", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 240, 255)), ColorSequenceKeypoint.new(0.1, Color3.fromRGB(160, 100, 255)), ColorSequenceKeypoint.new(0.25, Color3.fromRGB(60, 0, 120)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(5, 0, 15)), ColorSequenceKeypoint.new(0.75, Color3.fromRGB(60, 0, 120)), ColorSequenceKeypoint.new(0.9, Color3.fromRGB(160, 100, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 240, 255)) }), Rotation = 88 })
	return I[1]
end

return build
