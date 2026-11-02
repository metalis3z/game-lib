-- Generated from ui/ServerScriptService/Server/Sprouts/HpUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "HpUI", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, LightInfluence = 1, MaxDistance = 300, ResetOnSpawn = false, Size = UDim2.fromScale(25, 4) })
		I[2] = new("TextLabel", I[1], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "1,000", TextColor3 = Color3.fromRGB(54, 54, 54), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[3] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.4757785, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.482699, Color3.fromRGB(197, 197, 197)), ColorSequenceKeypoint.new(1, Color3.fromRGB(194, 194, 194)) }), Offset = Vector2.new(0, 0.2), Rotation = 86 })
			I[4] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(54, 54, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.2 })
			I[5] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 138, 220), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.49, 0.45), Size = UDim2.fromScale(1, 1), Text = "1,000", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.72, TextWrapped = true, ZIndex = 6 })
				I[6] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.4757785, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.482699, Color3.fromRGB(197, 197, 197)), ColorSequenceKeypoint.new(1, Color3.fromRGB(194, 194, 194)) }), Offset = Vector2.new(0, 0.2), Rotation = 86 })
				I[7] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(54, 54, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.2 })
	return I[1]
end

return build
