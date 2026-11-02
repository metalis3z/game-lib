-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/AudioVisualizerIcon.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "AudioVisualizerIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://131616644976154"), Position = UDim2.fromScale(0.5, 0.125), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.175, 0.175) })
		I[2] = new("UIGradient", I[1], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(0.8, 1), NumberSequenceKeypoint.new(1, 1) }) })
	return I[1]
end

return build
