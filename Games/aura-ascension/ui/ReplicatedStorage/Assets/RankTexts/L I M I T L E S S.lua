-- Generated from ui/ReplicatedStorage/Assets/RankTexts/L I M I T L E S S.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "L I M I T L E S S", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Guru.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.6743451, 0.5434783), RichText = true, Size = UDim2.fromScale(0.5355014, 0.2035197), Text = "L I M I T L E S S", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[2] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(2, 1, 21)), ColorSequenceKeypoint.new(0.2797928, Color3.fromRGB(13, 16, 48)), ColorSequenceKeypoint.new(0.3005181, Color3.fromRGB(2, 5, 25)), ColorSequenceKeypoint.new(0.3298791, Color3.fromRGB(39, 37, 106)), ColorSequenceKeypoint.new(0.4006909, Color3.fromRGB(135, 124, 255)), ColorSequenceKeypoint.new(0.4542314, Color3.fromRGB(36, 29, 118)), ColorSequenceKeypoint.new(0.5025907, Color3.fromRGB(2, 5, 25)), ColorSequenceKeypoint.new(0.5423144, Color3.fromRGB(5, 5, 47)), ColorSequenceKeypoint.new(0.5958549, Color3.fromRGB(0, 37, 25)), ColorSequenceKeypoint.new(0.6165803, Color3.fromRGB(25, 77, 51)), ColorSequenceKeypoint.new(0.6286701, Color3.fromRGB(119, 255, 214)), ColorSequenceKeypoint.new(0.6470588, Color3.fromRGB(28, 80, 54)), ColorSequenceKeypoint.new(0.6666667, Color3.fromRGB(11, 28, 18)), ColorSequenceKeypoint.new(0.7633851, Color3.fromRGB(3, 3, 31)), ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 6, 22)) }), Rotation = 87 })
		I[3] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), LineJoinMode = Enum.LineJoinMode.Miter, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
			I[4] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(65, 1, 255)), ColorSequenceKeypoint.new(0.1709845, Color3.fromRGB(20, 9, 84)), ColorSequenceKeypoint.new(0.4490501, Color3.fromRGB(44, 58, 134)), ColorSequenceKeypoint.new(0.6286701, Color3.fromRGB(72, 92, 219)), ColorSequenceKeypoint.new(0.6545768, Color3.fromRGB(124, 255, 183)), ColorSequenceKeypoint.new(0.6943005, Color3.fromRGB(78, 99, 236)), ColorSequenceKeypoint.new(0.9671848, Color3.fromRGB(5, 0, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Rotation = 85 })
	return I[1]
end

return build
