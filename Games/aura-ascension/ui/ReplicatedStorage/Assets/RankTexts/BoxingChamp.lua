-- Generated from ui/ReplicatedStorage/Assets/RankTexts/BoxingChamp.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "BoxingChamp", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 254, 253), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.6493129, 0.3790324), Size = UDim2.fromScale(1, 0.195), Text = "Undisputed Champion", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 15, TextWrapped = true, ZIndex = 2 })
		I[2] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(56, 56, 56), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
		I[3] = new("UIGradient", I[1], "UiGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 6, 255)), ColorSequenceKeypoint.new(0.1, Color3.fromRGB(170, 0, 255)), ColorSequenceKeypoint.new(0.3010381, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.9, Color3.fromRGB(255, 0, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 0, 255)) }), Rotation = -95 })
	return I[1]
end

return build
