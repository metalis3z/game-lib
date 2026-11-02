-- Generated from ui/ReplicatedStorage/Assets/SpecialMenuUI/Toxic/IMG.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "IMG", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://7072715827"), Position = UDim2.fromScale(0.925, 0.075), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6, 0.6) })
		I[2] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 53, 0)), ColorSequenceKeypoint.new(0.464226, Color3.fromRGB(0, 90, 0)), ColorSequenceKeypoint.new(0.78203, Color3.fromRGB(87, 166, 75)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 0)) }) })
	return I[1]
end

return build
