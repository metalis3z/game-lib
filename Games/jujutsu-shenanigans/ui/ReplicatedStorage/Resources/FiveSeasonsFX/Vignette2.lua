-- Generated from ui/ReplicatedStorage/Resources/FiveSeasonsFX/Vignette2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "Vignette2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=12754479702"), Position = UDim2.new(0, -3, -0.0953704, -3), Size = UDim2.new(1, 5, 1.1, 5) })
		I[2] = new("Decal", I[1], "Vignett overlay", { TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=13457209270") })
			I[3] = new("Decal", I[2], "Vignette", { TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=10024624251") })
				I[4] = new("Decal", I[3], "Vignette", { TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=3124804643") })
					I[5] = new("Decal", I[4], "red vignette", { TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=3242422929") })
						I[6] = new("Decal", I[5], "White Vignette", { TextureContent = Content.fromUri("http://www.roblox.com/asset/?id=12754479702") })
	return I[1]
end

return build
