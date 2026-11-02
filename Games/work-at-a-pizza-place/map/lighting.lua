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
	I[1] = new("Sky", nil, "Sky", { CelestialBodiesShown = false, SkyboxBackContent = Content.fromUri("http://www.roblox.com/asset/?id=35268852"), SkyboxDownContent = Content.fromUri("http://www.roblox.com/asset/?id=35268837"), SkyboxFrontContent = Content.fromUri("http://www.roblox.com/asset/?id=35268884"), SkyboxLeftContent = Content.fromUri("http://www.roblox.com/asset/?id=35268868"), SkyboxRightContent = Content.fromUri("http://www.roblox.com/asset/?id=35268872"), SkyboxUpContent = Content.fromUri("http://www.roblox.com/asset/?id=35268877") })
	I[2] = new("ColorCorrectionEffect", nil, "Afternoon", { Contrast = 0.1, Saturation = 0.1, TintColor = Color3.fromRGB(255, 236, 213) })
	I[3] = new("ColorCorrectionEffect", nil, "Morning", { Contrast = 0.1, Enabled = false, Saturation = 0.1, TintColor = Color3.fromRGB(255, 242, 221) })
	I[4] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.2 })
	I[5] = new("ColorCorrectionEffect", nil, "Midday", { Brightness = 0.05, Contrast = 0.1, Enabled = false, Saturation = 0.1 })
	I[6] = new("ColorCorrectionEffect", nil, "Night", { Contrast = 0.1, Enabled = false, Saturation = 0.1, TintColor = Color3.fromRGB(212, 224, 255) })
	I[7] = new("BlurEffect", nil, "Blur", { Enabled = false, Size = 0 })
	I[8] = new("ObjectValue", nil, "CurrentCorrection")
	I[9] = new("ColorCorrectionEffect", nil, "WinterDay", { Enabled = false, Saturation = -0.1 })
	I[10] = new("ColorCorrectionEffect", nil, "WinterNight", { Enabled = false, Saturation = 0.2 })
	I[11] = new("ColorCorrectionEffect", nil, "HalloweenNight", { Enabled = false, Saturation = 0.1 })
	I[12] = new("ColorCorrectionEffect", nil, "ChristmasNight", { Brightness = -0.05, Enabled = false, Saturation = 0.2 })
	I[13] = new("ColorGradingEffect", nil, "ColorGrading", { TonemapperPreset = Enum.TonemapperPreset.Retro })
	I[14] = new("BloomEffect", nil, "Bloom", { Intensity = 0 })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14] }
end

return build
