-- Generated from ui/TextChatService/adaspo_playground/auto_colors/Ultimate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Ultimate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.0609597, 0.5), Size = UDim2.fromScale(0.7867028, 0.079175), Text = "Ultimate", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 1550 })
		I[2] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(61, 61, 61), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
			I[3] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 44, 90)), ColorSequenceKeypoint.new(0.150519, Color3.fromRGB(255, 166, 42)), ColorSequenceKeypoint.new(0.295848, Color3.fromRGB(251, 255, 42)), ColorSequenceKeypoint.new(0.458478, Color3.fromRGB(71, 255, 61)), ColorSequenceKeypoint.new(0.586505, Color3.fromRGB(66, 214, 255)), ColorSequenceKeypoint.new(0.738754, Color3.fromRGB(64, 163, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 57, 245)) }), Rotation = 82 })
		I[4] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 44, 90)), ColorSequenceKeypoint.new(0.150519, Color3.fromRGB(255, 166, 42)), ColorSequenceKeypoint.new(0.295848, Color3.fromRGB(251, 255, 42)), ColorSequenceKeypoint.new(0.458478, Color3.fromRGB(71, 255, 61)), ColorSequenceKeypoint.new(0.586505, Color3.fromRGB(66, 214, 255)), ColorSequenceKeypoint.new(0.738754, Color3.fromRGB(64, 163, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 57, 245)) }), Rotation = 82 })
	return I[1]
end

return build
