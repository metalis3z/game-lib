-- Generated from ui/ServerStorage/GunScripts/KnifeLocal/Target.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Target", { Enabled = false, MaxDistance = math.huge, Size = UDim2.fromScale(2.5, 2.5) })
		I[2] = new("ImageLabel", I[1], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=343330656"), Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
