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
	I[1] = new("BloomEffect", nil, "Bloom", { Intensity = 1, Threshold = 2 })
	I[2] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Contrast = 0.3, Saturation = 0.1 })
	I[3] = new("DepthOfFieldEffect", nil, "DepthOfField", { FarIntensity = 0.1, FocusDistance = 18.6399994, InFocusRadius = 20 })
	I[4] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.01, Spread = 0.1 })
	I[5] = new("Sky", nil, "Sky", { CelestialBodiesShown = false, MoonAngularSize = 60, SkyboxBackContent = Content.fromUri("rbxassetid://6295671271"), SkyboxDownContent = Content.fromUri("rbxassetid://6295671382"), SkyboxFrontContent = Content.fromUri("rbxassetid://6295671136"), SkyboxLeftContent = Content.fromUri("rbxassetid://6295670996"), SkyboxRightContent = Content.fromUri("rbxassetid://6295671509"), SkyboxUpContent = Content.fromUri("rbxassetid://6295671667"), StarCount = 0, SunAngularSize = 10 })
	I[6] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(199, 169, 194), Decay = Color3.fromRGB(189, 229, 255), Density = 0.283, Glare = 0.5, Haze = 0.1, Offset = 1 })
	return { I[1], I[2], I[3], I[4], I[5], I[6] }
end

return build
