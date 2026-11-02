-- Generated from ui/ReplicatedStorage/Assets/RankTexts/Final Boss.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Final Boss", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 10, Position = UDim2.fromScale(-0.1107836, 0.2920301), Size = UDim2.fromScale(0.5438121, 0.1884058), Text = "Final Boss", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[2] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
			I[3] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.0557103, Color3.fromRGB(255, 85, 0)), ColorSequenceKeypoint.new(0.1114206, Color3.fromRGB(255, 170, 0)), ColorSequenceKeypoint.new(0.1671309, Color3.fromRGB(254, 255, 0)), ColorSequenceKeypoint.new(0.2228412, Color3.fromRGB(169, 255, 0)), ColorSequenceKeypoint.new(0.2785515, Color3.fromRGB(84, 255, 0)), ColorSequenceKeypoint.new(0.3342618, Color3.fromRGB(0, 255, 1)), ColorSequenceKeypoint.new(0.3899722, Color3.fromRGB(0, 255, 87)), ColorSequenceKeypoint.new(0.4456825, Color3.fromRGB(0, 255, 172)), ColorSequenceKeypoint.new(0.5013928, Color3.fromRGB(0, 253, 255)), ColorSequenceKeypoint.new(0.557103, Color3.fromRGB(0, 168, 255)), ColorSequenceKeypoint.new(0.6128134, Color3.fromRGB(0, 82, 255)), ColorSequenceKeypoint.new(0.6685237, Color3.fromRGB(3, 0, 255)), ColorSequenceKeypoint.new(0.724234, Color3.fromRGB(88, 0, 255)), ColorSequenceKeypoint.new(0.7799443, Color3.fromRGB(173, 0, 255)), ColorSequenceKeypoint.new(0.8356546, Color3.fromRGB(255, 0, 251)), ColorSequenceKeypoint.new(0.8913649, Color3.fromRGB(255, 0, 166)), ColorSequenceKeypoint.new(0.9470752, Color3.fromRGB(255, 0, 81)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }), Rotation = -51 })
	return I[1]
end

return build
