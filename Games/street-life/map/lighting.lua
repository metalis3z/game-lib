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
	I[1] = new("Atmosphere", nil, "Atmosphere", { Density = 0.368, Offset = 0.662 })
	I[2] = new("RemoteEvent", nil, "bt")
	I[3] = new("BlurEffect", nil, "IntroBlur", { Enabled = false, Size = 0 })
	I[4] = new("ColorCorrectionEffect", nil, "GunHSCC", { Brightness = -0.01, Contrast = 0.1, Enabled = false, Saturation = -0.1, TintColor = Color3.fromRGB(226, 226, 226) })
	I[5] = new("BlurEffect", nil, "GunHSBLUR", { Enabled = false, Size = 0 })
	I[6] = new("BlurEffect", nil, "EffectBLUR", { Enabled = false, Size = 0 })
	I[7] = new("DepthOfFieldEffect", nil, "DepthOfField", { FarIntensity = 0.093, FocusDistance = 0, InFocusRadius = 21.7849998 })
	I[8] = new("ColorCorrectionEffect", nil, "Dead", { Contrast = 1, Enabled = false, Saturation = 0.9, TintColor = Color3.fromRGB(33, 33, 33) })
	I[9] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.01, Spread = 0.1 })
	I[10] = new("BloomEffect", nil, "Bloom", { Intensity = 1, Threshold = 2 })
	I[11] = new("Sky", nil, "Cloudy Sky", { CelestialBodiesShown = false, MoonAngularSize = 0, SkyboxBackContent = Content.fromUri("http://www.roblox.com/asset/?id=4498803477"), SkyboxDownContent = Content.fromUri("http://www.roblox.com/asset/?id=4498803790"), SkyboxFrontContent = Content.fromUri("http://www.roblox.com/asset/?id=4498804837"), SkyboxLeftContent = Content.fromUri("http://www.roblox.com/asset/?id=4498805961"), SkyboxRightContent = Content.fromUri("http://www.roblox.com/asset/?id=4498805526"), SkyboxUpContent = Content.fromUri("http://www.roblox.com/asset/?id=4498807979"), SunAngularSize = 0 })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11] }
end

return build
