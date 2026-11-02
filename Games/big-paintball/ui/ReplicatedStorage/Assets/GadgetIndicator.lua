-- Generated from ui/ReplicatedStorage/Assets/GadgetIndicator.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "GadgetIndicator", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, ExtentsOffsetWorldSpace = Vector3.new(0, 5, 0), LightInfluence = 1, MaxDistance = math.huge, Size = UDim2.new(0.2, 10, 0.2, 10), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(58, 255, 44), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Rotation = 45, Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
