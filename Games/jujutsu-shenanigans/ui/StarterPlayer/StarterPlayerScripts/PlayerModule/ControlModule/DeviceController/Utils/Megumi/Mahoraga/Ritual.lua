-- Generated from ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Utils/Megumi/Mahoraga/Ritual.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Ritual", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ViewportFrame", I[1], "Viewport", { Ambient = Color3.fromRGB(0, 85, 127), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 1, LightColor = Color3.fromRGB(211, 255, 248), Size = UDim2.fromScale(1, 1) })
			I[3] = new("WorldModel", I[2], "Mahoraga")
		I[4] = new("UnionOperation", I[1], "Toad", { Anchored = true, CFrame = CFrame.new(34.4360924, 22.8606548, -85.9643784, 0, 0, -1, 0, 1, 0, 1, 0, 0), CanCollide = false, Color = Color3.fromRGB(248, 248, 248), Size = Vector3.new(5.6603827, 4.5595531, 4.507854), Transparency = 1, UsePartColor = true })
			I[5] = new("Decal", I[4], "Decal", { Face = Enum.NormalId.Bottom, TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=14448504614"), Transparency = 1 })
			I[6] = new("Decal", I[4], "Decal", { Face = Enum.NormalId.Top, TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=14448504614"), Transparency = 1 })
			I[7] = new("Decal", I[4], "Decal", { Face = Enum.NormalId.Back, TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=277037175"), Transparency = 1 })
			I[8] = new("Decal", I[4], "Decal", { Face = Enum.NormalId.Left, TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=277037175"), Transparency = 1 })
			I[9] = new("Decal", I[4], "Decal", { TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=277037175"), Transparency = 1 })
			I[10] = new("Decal", I[4], "Decal", { Face = Enum.NormalId.Right, TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=277037175"), Transparency = 1 })
		I[11] = new("UnionOperation", I[1], "Wolf", { Anchored = true, CFrame = CFrame.new(37.8011017, 23.7862206, -73.3083649), CanCollide = false, Color = Color3.fromRGB(73, 74, 84), Material = Enum.Material.Neon, Size = Vector3.new(4.7022133, 7.1053391, 8.120491), Transparency = 1, UsePartColor = true })
			I[12] = new("Decal", I[11], "Decal", { TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=277037175"), Transparency = 1 })
			I[13] = new("Decal", I[11], "Decal", { Face = Enum.NormalId.Bottom, TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=14448504614"), Transparency = 1 })
			I[14] = new("Decal", I[11], "Decal", { Face = Enum.NormalId.Left, TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=277037175"), Transparency = 1 })
			I[15] = new("Decal", I[11], "Decal", { Face = Enum.NormalId.Right, TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=277037175"), Transparency = 1 })
			I[16] = new("Decal", I[11], "Decal", { Face = Enum.NormalId.Back, TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=277037175"), Transparency = 1 })
			I[17] = new("Decal", I[11], "Decal", { Face = Enum.NormalId.Top, TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=14448504614"), Transparency = 1 })
	return I[1]
end

return build
