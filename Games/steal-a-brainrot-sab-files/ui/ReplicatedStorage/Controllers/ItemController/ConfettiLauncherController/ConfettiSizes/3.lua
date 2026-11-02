-- Generated from ui/ReplicatedStorage/Controllers/ItemController/ConfettiLauncherController/ConfettiSizes/3.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "3", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 225, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5269905, 0.6168969), Size = UDim2.fromScale(0.2047164, 0.1556999), ZIndex = -1 }, { ["_lemonadeUniqueId"] = "QGaEX6XFQGaE" })
	return I[1]
end

return build
