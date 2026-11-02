-- Generated from ui/ReplicatedStorage/Assets/RankTexts/APEX.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "APEX", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5241705, 0.1345756), Size = UDim2.fromScale(0.3924156, 0.2177743), Text = "APEX", TextColor3 = Color3.fromRGB(200, 200, 200), TextScaled = true, TextWrapped = true })
		I[2] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(96, 17, 255)), ColorSequenceKeypoint.new(0.1124568, Color3.fromRGB(45, 26, 182)), ColorSequenceKeypoint.new(0.1972318, Color3.fromRGB(20, 18, 104)), ColorSequenceKeypoint.new(0.3425606, Color3.fromRGB(70, 9, 191)), ColorSequenceKeypoint.new(0.5242215, Color3.fromRGB(13, 2, 36)), ColorSequenceKeypoint.new(0.7093426, Color3.fromRGB(9, 2, 26)), ColorSequenceKeypoint.new(1, Color3.fromRGB(13, 10, 48)) }), Rotation = 90 })
		I[3] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), LineJoinMode = Enum.LineJoinMode.Miter, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
			I[4] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(96, 17, 255)), ColorSequenceKeypoint.new(0.1124568, Color3.fromRGB(45, 26, 182)), ColorSequenceKeypoint.new(0.1972318, Color3.fromRGB(20, 18, 104)), ColorSequenceKeypoint.new(0.3425606, Color3.fromRGB(70, 9, 191)), ColorSequenceKeypoint.new(0.5242215, Color3.fromRGB(13, 2, 36)), ColorSequenceKeypoint.new(0.7093426, Color3.fromRGB(9, 2, 26)), ColorSequenceKeypoint.new(1, Color3.fromRGB(13, 10, 48)) }), Rotation = -90 })
	return I[1]
end

return build
