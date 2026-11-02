-- Generated from ui/TextChatService/adaspo_playground/auto_colors/Eternal.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Eternal", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.0609597, 0.5), Size = UDim2.fromScale(0.7867028, 0.079175), Text = "Eternal", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 1550 })
		I[2] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(20, 36, 131), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
			I[3] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(1, 239, 252)), ColorSequenceKeypoint.new(1, Color3.fromRGB(195, 61, 253)) }), Rotation = 70 })
		I[4] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(1, 239, 252)), ColorSequenceKeypoint.new(1, Color3.fromRGB(195, 61, 253)) }), Rotation = 70 })
	return I[1]
end

return build
