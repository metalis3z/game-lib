-- Generated from ui/ReplicatedStorage/Controllers/ItemController/ConfettiLauncherController/ConfettiSizes/2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(55, 255, 55), BorderSizePixel = 0, Position = UDim2.fromScale(0.3819163, 0.5297556), Size = UDim2.fromScale(0.1886608, 0.1056283), ZIndex = -1 }, { ["_lemonadeUniqueId"] = "Pe2cXQaqPe2c" })
	return I[1]
end

return build
