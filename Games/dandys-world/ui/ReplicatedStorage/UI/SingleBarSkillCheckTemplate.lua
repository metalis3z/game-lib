-- Generated from ui/ReplicatedStorage/UI/SingleBarSkillCheckTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "SingleBarSkillCheckTemplate", { BackgroundColor3 = Color3.fromRGB(47, 47, 47), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.3496606, 0.7803468), Size = UDim2.fromScale(0.3, 0.05) })
		I[2] = new("UICorner", I[1], "UICorner")
		I[3] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135)) }) })
		I[4] = new("Frame", I[1], "RequiredArea", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1, 0), Size = UDim2.fromScale(0.25, 1) })
			I[5] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135)) }), Rotation = 90 })
		I[6] = new("Frame", I[1], "Marker", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 87, 90), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0014752, -0.3988439), Size = UDim2.fromScale(0.01, 1.78), ZIndex = 5 })
			I[7] = new("UICorner", I[6], "UICorner")
		I[8] = new("Frame", I[1], "GoldArea", { BackgroundColor3 = Color3.fromRGB(255, 213, 62), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.033, 1), ZIndex = 2 })
			I[9] = new("Sound", I[8], "Sound", { PlaybackSpeed = 1.5, RollOffMode = Enum.RollOffMode.InverseTapered })
			I[10] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 204, 52)) }), Rotation = 90 })
	return I[1]
end

return build
