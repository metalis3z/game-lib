-- Generated from ui/ReplicatedStorage/Modules/MapVoting/PlayerIcon.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "PlayerIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://15317582625"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.166, 20, 0.721, 20) })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(100, 100), BottomRightRadius = UDim.new(100, 100), TopLeftRadius = UDim.new(100, 100), TopRightRadius = UDim.new(100, 100) })
		I[3] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(166, 166, 166)) }), Rotation = 90 })
		I[4] = new("ImageLabel", I[1], "Outline", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://18818132015"), Position = UDim2.fromScale(0.4843318, 0.5000013), Size = UDim2.fromScale(1.1315541, 1.15), ZIndex = 2 })
			I[5] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(166, 166, 166)) }), Rotation = 90 })
		I[6] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
	return I[1]
end

return build
