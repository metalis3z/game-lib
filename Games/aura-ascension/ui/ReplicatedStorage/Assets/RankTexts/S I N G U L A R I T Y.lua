-- Generated from ui/ReplicatedStorage/Assets/RankTexts/S I N G U L A R I T Y.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "S I N G U L A R I T Y", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(236, 242, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(236, 242, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Fondamento.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LineHeight = 2, Position = UDim2.fromScale(0.442048, 0.5583658), RichText = true, Size = UDim2.fromScale(0.4225836, 0.1476191), Text = "S I N G U L A R I T Y", TextColor3 = Color3.fromRGB(236, 242, 255), TextScaled = true, TextSize = 30, TextStrokeColor3 = Color3.fromRGB(236, 242, 255), TextWrapped = true, ZIndex = 2 })
		I[2] = new("UIStroke", I[1], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
		I[3] = new("UIGradient", I[1], "GODTIER_Transcendence", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.08, Color3.fromRGB(255, 200, 0)), ColorSequenceKeypoint.new(0.16, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 0, 200)), ColorSequenceKeypoint.new(0.3581315, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.42, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.58, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 0, 200)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.92, Color3.fromRGB(255, 200, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }) })
	return I[1]
end

return build
