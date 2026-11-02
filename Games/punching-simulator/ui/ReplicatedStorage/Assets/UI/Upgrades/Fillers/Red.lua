-- Generated from ui/ReplicatedStorage/Assets/UI/Upgrades/Fillers/Red.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Red", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.3577676, 0.6694421), Size = UDim2.fromScale(0.2, 1) })
		I[2] = new("UIStroke", I[1], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
		I[3] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 237, 242)), ColorSequenceKeypoint.new(0.4966667, Color3.fromRGB(212, 221, 230)), ColorSequenceKeypoint.new(0.5133333, Color3.fromRGB(199, 205, 214)), ColorSequenceKeypoint.new(1, Color3.fromRGB(209, 218, 226)) }), Rotation = 90 })
	return I[1]
end

return build
