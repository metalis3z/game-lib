-- Generated from ui/ReplicatedStorage/Resources/LegacyReplication/HeavyVi.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "HeavyVi", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4576475446"), Size = UDim2.fromScale(1, 1) })
			I[3] = new("Decal", I[2], "Vignette.png", { TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=4576475446") })
			I[4] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4576475446"), Size = UDim2.fromScale(1, 1) })
				I[5] = new("Decal", I[4], "Vignette.png", { TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=4576475446") })
	return I[1]
end

return build
