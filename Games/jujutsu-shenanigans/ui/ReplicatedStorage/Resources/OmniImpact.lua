-- Generated from ui/ReplicatedStorage/Resources/OmniImpact.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "OmniImpact", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "1", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=16516658091"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[3] = new("ImageLabel", I[1], "2", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=16516718975"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[4] = new("ImageLabel", I[1], "3", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=16516663035"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[5] = new("ImageLabel", I[1], "4", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=16516666774"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[6] = new("ImageLabel", I[1], "5", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=16516670462"), Size = UDim2.fromScale(1, 1), Visible = false })
	return I[1]
end

return build
