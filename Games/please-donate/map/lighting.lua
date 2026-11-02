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
	I[1] = new("BloomEffect", nil, "Bloom", { Intensity = 1, Size = 45, Threshold = 3.5 })
	I[2] = new("BlurEffect", nil, "Blur", { Size = 0 })
	I[3] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Brightness = 0.05, Contrast = 0.2, Saturation = 0.25 })
	I[4] = new("DepthOfFieldEffect", nil, "DepthOfField", { Enabled = false, FarIntensity = 0.1, InFocusRadius = 30 })
	I[5] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.01, Spread = 0.1 })
	I[6] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(255, 255, 255), Decay = Color3.fromRGB(255, 255, 255), Density = 0 })
	I[7] = new("Sky", nil, "Sky", { CelestialBodiesShown = false, SkyboxBackContent = Content.fromUri("rbxassetid://144815627"), SkyboxDownContent = Content.fromUri("rbxassetid://144815649"), SkyboxFrontContent = Content.fromUri("rbxassetid://144815667"), SkyboxLeftContent = Content.fromUri("rbxassetid://144815688"), SkyboxRightContent = Content.fromUri("rbxassetid://144815714"), SkyboxUpContent = Content.fromUri("rbxassetid://144815743") })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7] }
end

return build
