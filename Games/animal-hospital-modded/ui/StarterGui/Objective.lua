-- Generated from ui/StarterGui/Objective.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Objective", { DisplayOrder = 1, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.None })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.25 })
			I[4] = new("Frame", I[2], "keys", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.new(1, -15, 0.1222585, 0), Size = UDim2.fromScale(0.248428, 0.1115599) })
				I[5] = new("TextLabel", I[4], "objective", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0.9, 0.8), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextStrokeTransparency = 0, TextWrapped = true })
					I[6] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(249, 253, 255)), ColorSequenceKeypoint.new(0.35, Color3.fromRGB(251, 252, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(152, 151, 153)) }), Enabled = false, Offset = Vector2.new(0, 0.1), Rotation = 90 })
					I[7] = new("UIStroke", I[5], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
				I[8] = new("TextLabel", I[4], "title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.9999999, 0.3708425), Text = "Objective", TextColor3 = Color3.fromRGB(128, 128, 128), TextScaled = true, TextSize = 32, TextStrokeTransparency = 0.6, TextWrapped = true, Visible = false })
				I[9] = new("UIGradient", I[4], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1403712, 0.30625), NumberSequenceKeypoint.new(0.2099768, 0.1), NumberSequenceKeypoint.new(0.3039443, 0), NumberSequenceKeypoint.new(0.4988399, 0), NumberSequenceKeypoint.new(0.7018561, 0.00625), NumberSequenceKeypoint.new(0.7993039, 0.15), NumberSequenceKeypoint.new(0.8677494, 0.35625), NumberSequenceKeypoint.new(1, 1) }) })
			I[10] = new("UIScale", I[2], "UIScale", nil, { ["GoalScale"] = 1.2 })
	return I[1]
end

return build
