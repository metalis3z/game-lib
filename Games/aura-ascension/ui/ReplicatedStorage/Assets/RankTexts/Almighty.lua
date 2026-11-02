-- Generated from ui/ReplicatedStorage/Assets/RankTexts/Almighty.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Almighty", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic), LayoutOrder = 10, Position = UDim2.fromScale(0.4024036, 0.204762), Size = UDim2.fromScale(0.5438121, 0.1884058), Text = "Almighty", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[2] = new("UIStroke", I[1], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
		I[3] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 29)), ColorSequenceKeypoint.new(0.08, Color3.fromRGB(0, 0, 47)), ColorSequenceKeypoint.new(0.2, Color3.fromRGB(0, 0, 91)), ColorSequenceKeypoint.new(0.32, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.44, Color3.fromRGB(0, 170, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(85, 255, 255)), ColorSequenceKeypoint.new(0.56, Color3.fromRGB(0, 170, 255)), ColorSequenceKeypoint.new(0.68, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 103)), ColorSequenceKeypoint.new(0.92, Color3.fromRGB(0, 0, 31)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 12)) }), Rotation = -95 })
	return I[1]
end

return build
