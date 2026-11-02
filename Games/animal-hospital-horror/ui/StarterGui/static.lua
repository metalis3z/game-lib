-- Generated from ui/StarterGui/static.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "static", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "staticframe", { BackgroundColor3 = Color3.fromRGB(28, 28, 40), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(17, 17, 17), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4388380012"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 10 })
	return I[1]
end

return build
