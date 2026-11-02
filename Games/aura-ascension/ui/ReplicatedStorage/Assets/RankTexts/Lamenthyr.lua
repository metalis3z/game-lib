-- Generated from ui/ReplicatedStorage/Assets/RankTexts/Lamenthyr.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Lamenthyr", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(125, 70, 70), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(13, 7, 7), FontFace = Font.new("rbxassetid://12187371622", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.6978319, 0.7039338), Size = UDim2.fromScale(0.5156278, 0.1807454), Text = "BOUNDLESS", TextColor3 = Color3.fromRGB(255, 142, 142), TextScaled = true, TextSize = 100, TextWrapped = true })
		I[2] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(168, 94, 94), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
			I[3] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 143, 143)), ColorSequenceKeypoint.new(0.0588235, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.2162629, Color3.fromRGB(130, 73, 73)), ColorSequenceKeypoint.new(0.2352941, Color3.fromRGB(255, 143, 143)), ColorSequenceKeypoint.new(0.3408305, Color3.fromRGB(9, 5, 5)), ColorSequenceKeypoint.new(0.4065744, Color3.fromRGB(228, 128, 128)), ColorSequenceKeypoint.new(0.4463668, Color3.fromRGB(39, 22, 22)), ColorSequenceKeypoint.new(0.4878892, Color3.fromRGB(255, 143, 143)), ColorSequenceKeypoint.new(0.5034602, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5692042, Color3.fromRGB(147, 82, 82)), ColorSequenceKeypoint.new(0.7266436, Color3.fromRGB(16, 9, 9)), ColorSequenceKeypoint.new(0.8373703, Color3.fromRGB(203, 113, 113)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Rotation = 88 })
		I[4] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.0224914, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.1955017, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.4100346, Color3.fromRGB(20, 11, 11)), ColorSequenceKeypoint.new(0.5207613, Color3.fromRGB(255, 143, 143)), ColorSequenceKeypoint.new(0.5484429, Color3.fromRGB(83, 46, 46)), ColorSequenceKeypoint.new(0.5951557, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.66609, Color3.fromRGB(18, 10, 10)), ColorSequenceKeypoint.new(0.7093426, Color3.fromRGB(45, 25, 25)), ColorSequenceKeypoint.new(0.7214533, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.8148789, Color3.fromRGB(40, 22, 22)), ColorSequenceKeypoint.new(0.9186851, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(2, 1, 1)) }), Rotation = 90 })
	return I[1]
end

return build
