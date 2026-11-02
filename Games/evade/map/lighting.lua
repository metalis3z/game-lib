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
	I[1] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.071, Spread = 0.576 })
	I[2] = new("ColorCorrectionEffect", nil, "ColorCCorrection", { Brightness = 0.1, Contrast = 0.1, Saturation = -0.2, TintColor = Color3.fromRGB(255, 233, 233) })
	I[3] = new("Atmosphere", nil, "AtmosphereMolten", { Color = Color3.fromRGB(199, 199, 199), Decay = Color3.fromRGB(106, 112, 125), Density = 0.2, Offset = 0.25 })
	I[4] = new("Sky", nil, "SkyMolten", { CelestialBodiesShown = false, SkyboxBackContent = Content.fromUri("rbxassetid://528480826"), SkyboxDownContent = Content.fromUri("rbxassetid://528481890"), SkyboxFrontContent = Content.fromUri("rbxassetid://528481964"), SkyboxLeftContent = Content.fromUri("rbxassetid://528482047"), SkyboxRightContent = Content.fromUri("rbxassetid://528482365"), SkyboxUpContent = Content.fromUri("rbxassetid://528484371"), StarCount = 0 })
	I[5] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(199, 199, 199), Decay = Color3.fromRGB(106, 112, 125), Density = 0.2, Offset = 0.25 })
	I[6] = new("Sky", nil, "Cartoon", { CelestialBodiesShown = false, SkyboxBackContent = Content.fromUri("rbxassetid://528480826"), SkyboxDownContent = Content.fromUri("rbxassetid://528481890"), SkyboxFrontContent = Content.fromUri("rbxassetid://528481964"), SkyboxLeftContent = Content.fromUri("rbxassetid://528482047"), SkyboxRightContent = Content.fromUri("rbxassetid://528482365"), SkyboxUpContent = Content.fromUri("rbxassetid://528484371"), StarCount = 0 })
	return { I[1], I[2], I[3], I[4], I[5], I[6] }
end

return build
