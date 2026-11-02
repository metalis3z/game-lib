-- Generated from ui/ReplicatedStorage/Assets/Effects/Global/Cooldown.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "Cooldown", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 0, 4), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://9581732620"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.1, 1) }, { ["MoveName"] = "" })
		I[2] = new("UIGradient", I[1], "UIGradient", { Offset = Vector2.new(1, 0), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.0025031, 1), NumberSequenceKeypoint.new(1, 1) }) })
		I[3] = new("ImageLabel", I[1], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.25, 0.25), Size = UDim2.fromScale(0.5, 0.5), ZIndex = 3 })
		I[4] = new("ImageLabel", I[1], "Red", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 0, 4), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://9581732620"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 }, { ["MoveName"] = "" })
			I[5] = new("UIGradient", I[4], "UIGradient", { Offset = Vector2.new(1, 0), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.0025031, 1), NumberSequenceKeypoint.new(1, 1) }) })
	return I[1]
end

return build
