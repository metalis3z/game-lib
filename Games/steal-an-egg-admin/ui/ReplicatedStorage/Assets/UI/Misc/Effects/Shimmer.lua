-- Generated from ui/ReplicatedStorage/Assets/UI/Misc/Effects/Shimmer.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Shimmer", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.99), Size = UDim2.fromScale(0.96, 0.93), ZIndex = 11 }, { ["_lemonadeUniqueId"] = "cZL3puDLcZL3" })
		I[2] = new("UIGradient", I[1], "UIGradient", { Offset = Vector2.new(-1, 0), Rotation = 25, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.3753117, 0.18125), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(0.6396509, 0.1875), NumberSequenceKeypoint.new(1, 1) }) }, { ["_lemonadeUniqueId"] = "4FbnUnHj4Fbn" })
		I[3] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.18, 0), BottomRightRadius = UDim.new(0.18, 0), TopLeftRadius = UDim.new(0.18, 0), TopRightRadius = UDim.new(0.18, 0) }, { ["_lemonadeUniqueId"] = "HfN5sv8AHfN5" })
	return I[1]
end

return build
