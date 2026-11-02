-- Generated from ui/ServerStorage/Scripts_BeforeAngelShop/PassShopHandler/Icons/WeightLuck.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "WeightLuck", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(64, 64), ZIndex = 2 })
		I[2] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(90, 96, 112), BorderSizePixel = 0, Position = UDim2.fromOffset(32, 19), Size = UDim2.fromOffset(20, 18), ZIndex = 3 })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 2 })
		I[4] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 247, 224), BorderSizePixel = 0, Position = UDim2.fromOffset(32, 19), Size = UDim2.fromOffset(9, 8), ZIndex = 4 })
			I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 1.5 })
		I[6] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(32, 40), Size = UDim2.fromOffset(44, 30), ZIndex = 5 })
			I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 2 })
			I[8] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(132, 140, 160)), ColorSequenceKeypoint.new(1, Color3.fromRGB(78, 84, 104)) }), Rotation = 90 })
		I[9] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(190, 198, 214), BorderSizePixel = 0, Position = UDim2.fromOffset(32, 29), Size = UDim2.fromOffset(34, 4), ZIndex = 6 })
		I[10] = new("TextLabel", I[1], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(32, 42), Size = UDim2.fromOffset(44, 22), Text = "KG", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 17, ZIndex = 7 }, { ["MontFix"] = true })
			I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 2 })
	return I[1]
end

return build
