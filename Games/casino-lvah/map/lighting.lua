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
	I[1] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(199, 199, 199), Decay = Color3.fromRGB(106, 112, 125), Density = 0.2, Offset = 0.25 })
	I[2] = new("BloomEffect", nil, "Bloom", { Intensity = 1, Threshold = 2 })
	I[3] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Brightness = 0.01, Contrast = -0.1, Saturation = 0.2, TintColor = Color3.fromRGB(255, 240, 205) })
	I[4] = new("Sky", nil, "Sky", { CelestialBodiesShown = false, SkyboxBackContent = Content.fromUri("http://www.roblox.com/asset/?id=433330330"), SkyboxDownContent = Content.fromUri("http://www.roblox.com/asset/?id=433331565"), SkyboxFrontContent = Content.fromUri("http://www.roblox.com/asset/?id=433330428"), SkyboxLeftContent = Content.fromUri("http://www.roblox.com/asset/?id=433330546"), SkyboxRightContent = Content.fromUri("http://www.roblox.com/asset/?id=433331052"), SkyboxUpContent = Content.fromUri("http://www.roblox.com/asset/?id=433331565") })
	return { I[1], I[2], I[3], I[4] }
end

return build
