-- Generated from map/lighting.rbxm by _tools/rbxm2lua.luau
-- Lighting pack: for _, o in require(this)() do o.Parent = game.Lighting end (Lighting properties are in Environment.lua)

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
	I[1] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.051, Spread = 0.308 })
	I[2] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(66, 176, 209), Decay = Color3.fromRGB(119, 175, 203), Density = 0.43, Glare = 0.5, Haze = 2.03, Offset = 0.554 })
	I[3] = new("BloomEffect", nil, "Bloom", { Intensity = 1, Threshold = 2 })
	I[4] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Contrast = 0.3, Saturation = 0.1, TintColor = Color3.fromRGB(226, 250, 255) })
	I[5] = new("Sky", nil, "Sky", { SkyboxBackContent = Content.fromUri("http://www.roblox.com/asset/?id=144933338"), SkyboxDownContent = Content.fromUri("http://www.roblox.com/asset/?id=144931530"), SkyboxFrontContent = Content.fromUri("http://www.roblox.com/asset/?id=144933262"), SkyboxLeftContent = Content.fromUri("http://www.roblox.com/asset/?id=144933244"), SkyboxRightContent = Content.fromUri("http://www.roblox.com/asset/?id=144933299"), SkyboxUpContent = Content.fromUri("http://www.roblox.com/asset/?id=144931564"), StarCount = 1500, SunAngularSize = 5 })
	return { I[1], I[2], I[3], I[4], I[5] }
end

return build
