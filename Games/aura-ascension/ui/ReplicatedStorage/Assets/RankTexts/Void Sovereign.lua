-- Generated from ui/ReplicatedStorage/Assets/RankTexts/Void Sovereign.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Void Sovereign", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 254, 253), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.6493129, 0.3790324), Size = UDim2.fromScale(1, 0.195), Text = "Void Sovereign", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 15, TextWrapped = true, ZIndex = 2 })
		I[2] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(56, 56, 56), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
		I[3] = new("UIGradient", I[1], "UiGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(162, 0, 255)), ColorSequenceKeypoint.new(0.1799308, Color3.fromRGB(204, 0, 255)), ColorSequenceKeypoint.new(0.3356402, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.4705882, Color3.fromRGB(136, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(162, 0, 255)) }), Offset = Vector2.new(0.1, -0.1), Rotation = 270 })
	return I[1]
end

return build
