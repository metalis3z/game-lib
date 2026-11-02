-- Generated from ui/ReplicatedStorage/Assets/UI/OTHER/Shockwave/Pulse.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "Pulse", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://133024305034650"), Position = UDim2.fromScale(0.5, 0.502), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.5, 1.5), ZIndex = 20 }, { ["_lemonadeUniqueId"] = "NheBbdcmNheB" })
		I[2] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 156, 156)), ColorSequenceKeypoint.new(0.2249135, Color3.fromRGB(255, 253, 185)), ColorSequenceKeypoint.new(0.4463668, Color3.fromRGB(223, 255, 203)), ColorSequenceKeypoint.new(0.6314879, Color3.fromRGB(208, 255, 252)), ColorSequenceKeypoint.new(0.8304499, Color3.fromRGB(228, 216, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 156, 156)) }) }, { ["_lemonadeUniqueId"] = "Wuxtb2z3Wuxt" })
		I[3] = new("UIScale", I[1], "UIScale", nil, { ["_lemonadeUniqueId"] = "ngYkvYGkngYk" })
	return I[1]
end

return build
