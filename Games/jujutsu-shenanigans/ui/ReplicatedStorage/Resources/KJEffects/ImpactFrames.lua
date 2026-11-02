-- Generated from ui/ReplicatedStorage/Resources/KJEffects/ImpactFrames.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ImpactFrames", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Frame1", { ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17094610660"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[3] = new("ImageLabel", I[1], "Frame7", { ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17094608312"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[4] = new("ImageLabel", I[1], "Frame6", { ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17094608875"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[5] = new("ImageLabel", I[1], "Frame5", { ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17094609366"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[6] = new("ImageLabel", I[1], "Frame4", { ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17094609732"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[7] = new("ImageLabel", I[1], "Frame3", { ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17094610225"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[8] = new("ImageLabel", I[1], "Frame2", { ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17094610356"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[9] = new("ImageLabel", I[1], "Frame8", { ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17094608019"), Size = UDim2.fromScale(1, 1), Visible = false })
	return I[1]
end

return build
