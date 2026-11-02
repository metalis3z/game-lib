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
	I[1] = new("SunRaysEffect", nil, "SunRays", { Enabled = false })
	I[2] = new("DepthOfFieldEffect", nil, "DepthOfField", { InFocusRadius = 250 })
	I[3] = new("BlurEffect", nil, "Blur", { Size = 0 })
		I[4] = new("Sky", I[3], "Sky", { MoonAngularSize = 0, SkyboxBackContent = Content.fromUri("http://www.roblox.com/asset?id=58372690"), SkyboxDownContent = Content.fromUri("http://www.roblox.com/asset?id=58372722"), SkyboxFrontContent = Content.fromUri("http://www.roblox.com/asset?id=58372742"), SkyboxLeftContent = Content.fromUri("http://www.roblox.com/asset?id=58372777"), SkyboxRightContent = Content.fromUri("http://www.roblox.com/asset?id=58372794"), SkyboxUpContent = Content.fromUri("http://www.roblox.com/asset?id=58372812") })
	I[5] = new("BloomEffect", nil, "Bloom", { Enabled = false, Intensity = 1, Size = 1, Threshold = 4 })
	I[6] = new("Configuration", nil, "Charles", nil, { ["Ambient"] = Color3.fromRGB(182, 182, 182), ["Brightness"] = 2, ["ClockTime"] = 14.5, ["ColorShift_Bottom"] = Color3.fromRGB(0, 0, 0), ["ColorShift_Top"] = Color3.fromRGB(0, 0, 0), ["EnvironmentDiffuseScale"] = 0, ["EnvironmentSpecularScale"] = 0, ["ExposureCompensation"] = 0, ["GeographicLatitude"] = 20, ["GlobalShadows"] = false, ["OutdoorAmbient"] = Color3.fromRGB(70, 70, 70), ["ShadowSoftness"] = 0.19 })
	I[7] = new("ColorCorrectionEffect", nil, "FlameEffect", { Brightness = 0.1, Enabled = false, Saturation = 0.1, TintColor = Color3.fromRGB(255, 246, 197) })
	I[8] = new("ColorCorrectionEffect", nil, "RainEffect")
	I[9] = new("ColorCorrectionEffect", nil, "LightningEffect")
	I[10] = new("ColorCorrectionEffect", nil, "RainbowEffect")
	I[11] = new("ColorCorrectionEffect", nil, "StarEffect")
	I[12] = new("ColorCorrectionEffect", nil, "ColorCorrection")
	I[13] = new("ColorCorrectionEffect", nil, "ColorCorrection")
	I[14] = new("Sky", nil, "Sky", { CelestialBodiesShown = false, SkyboxBackContent = Content.fromUri("rbxassetid://528480826"), SkyboxDownContent = Content.fromUri("rbxassetid://528481890"), SkyboxFrontContent = Content.fromUri("rbxassetid://528481964"), SkyboxLeftContent = Content.fromUri("rbxassetid://528482047"), SkyboxRightContent = Content.fromUri("rbxassetid://528482365"), SkyboxUpContent = Content.fromUri("rbxassetid://528484371"), StarCount = 0 })
	return { I[1], I[2], I[3], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14] }
end

return build
