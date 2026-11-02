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
	I[1] = new("Sky", nil, "Sky", { SkyboxBackContent = Content.fromUri("http://www.roblox.com/asset?id=58372690"), SkyboxDownContent = Content.fromUri("http://www.roblox.com/asset?id=58372722"), SkyboxFrontContent = Content.fromUri("http://www.roblox.com/asset?id=58372742"), SkyboxLeftContent = Content.fromUri("http://www.roblox.com/asset?id=58372777"), SkyboxRightContent = Content.fromUri("http://www.roblox.com/asset?id=58372794"), SkyboxUpContent = Content.fromUri("http://www.roblox.com/asset?id=58372812"), StarCount = 0, SunAngularSize = 10 })
	I[2] = new("BloomEffect", nil, "Bloom", { Intensity = 0.5, Size = 50, Threshold = 2 })
	I[3] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Brightness = 0.3, Contrast = 0.3, Saturation = 0.2, TintColor = Color3.fromRGB(184, 190, 237) })
	I[4] = new("DepthOfFieldEffect", nil, "DepthOfField", { FarIntensity = 0, FocusDistance = 0, InFocusRadius = 0, NearIntensity = 0 })
	I[5] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.01 })
	I[6] = new("ColorCorrectionEffect", nil, "VFX")
	I[7] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(217, 255, 252), Decay = Color3.fromRGB(54, 90, 102), Density = 0, Glare = 1.3, Haze = 0.35 })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7] }
end

return build
