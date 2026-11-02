-- Generated from ui/ReplicatedStorage/Assets/RankTexts/Superhuman.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Superhuman", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic), LayoutOrder = 10, Position = UDim2.fromScale(0.0209698, 0.5449681), Size = UDim2.fromScale(0.5438121, 0.1884058), Text = "Superhuman", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[2] = new("UIStroke", I[1], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
		I[3] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 5)), ColorSequenceKeypoint.new(0.1, Color3.fromRGB(0, 10, 40)), ColorSequenceKeypoint.new(0.25, Color3.fromRGB(0, 30, 100)), ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 80, 180)), ColorSequenceKeypoint.new(0.55, Color3.fromRGB(20, 140, 255)), ColorSequenceKeypoint.new(0.7, Color3.fromRGB(0, 80, 200)), ColorSequenceKeypoint.new(0.85, Color3.fromRGB(0, 20, 80)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 15)) }), Rotation = 90 })
	return I[1]
end

return build
