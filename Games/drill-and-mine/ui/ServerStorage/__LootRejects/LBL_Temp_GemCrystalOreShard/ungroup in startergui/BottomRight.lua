-- Generated from ui/ServerStorage/__LootRejects/LBL_Temp_GemCrystalOreShard/ungroup in startergui/BottomRight.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BottomRight", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "spawningtime", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8824932, 0.9492434), Size = UDim2.fromScale(0.1789185, 0.0500293), Text = "spawning in 1:23", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.05 })
		I[4] = new("TextLabel", I[1], "spawningtype", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8824932, 0.8618709), Size = UDim2.fromScale(0.1789185, 0.1253378), Text = "RAINBOW TSUNAMI", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[5] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.1539792, Color3.fromRGB(255, 86, 30)), ColorSequenceKeypoint.new(0.3737024, Color3.fromRGB(255, 238, 0)), ColorSequenceKeypoint.new(0.5536332, Color3.fromRGB(4, 255, 0)), ColorSequenceKeypoint.new(0.7249135, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 15, 235)) }), Rotation = -136 })
			I[6] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(79, 79, 79), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.05 })
	return I[1]
end

return build
