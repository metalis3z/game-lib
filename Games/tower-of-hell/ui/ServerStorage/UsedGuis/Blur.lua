-- Generated from ui/ServerStorage/UsedGuis/Blur.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Blur", { BackgroundColor3 = Color3.fromRGB(158, 158, 158), BackgroundTransparency = 0.25, Position = UDim2.fromScale(0.0504185, 0.003113), Size = UDim2.fromOffset(100, 100) })
	return I[1]
end

return build
