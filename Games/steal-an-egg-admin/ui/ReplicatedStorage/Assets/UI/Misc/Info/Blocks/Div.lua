-- Generated from ui/ReplicatedStorage/Assets/UI/Misc/Info/Blocks/Div.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Div", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 3, Size = UDim2.new(1, 0, 0, 15) }, { ["_lemonadeUniqueId"] = "yvYt8QGkyvYt" })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9, LayoutOrder = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0, 1), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "uJcQLawWuJcQ" })
			I[3] = new("UIGradient", I[2], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1905355, 0.3875), NumberSequenceKeypoint.new(0.5018679, 0), NumberSequenceKeypoint.new(0.7895392, 0.36875), NumberSequenceKeypoint.new(1, 1) }) }, { ["_lemonadeUniqueId"] = "GCuTorWyGCuT" })
	return I[1]
end

return build
