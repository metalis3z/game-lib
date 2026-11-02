-- Generated from ui/ReplicatedStorage/Assets/RankTexts/Dominator.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Dominator", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 10, Position = UDim2.fromScale(-0.1107836, 0.128469), Size = UDim2.fromScale(0.5438121, 0.1884058), Text = "Dominator", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[2] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(255, 0, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
	return I[1]
end

return build
