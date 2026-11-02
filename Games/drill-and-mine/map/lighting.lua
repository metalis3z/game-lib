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
	I[1] = new("Sky", nil, "Sky", { CelestialBodiesShown = false, SkyboxBackContent = Content.fromUri("rbxassetid://6295671271"), SkyboxDownContent = Content.fromUri("rbxassetid://6295671382"), SkyboxFrontContent = Content.fromUri("rbxassetid://6295671136"), SkyboxLeftContent = Content.fromUri("rbxassetid://6295670996"), SkyboxRightContent = Content.fromUri("rbxassetid://6295671509"), SkyboxUpContent = Content.fromUri("rbxassetid://6295671667"), SunAngularSize = 10 })
	I[2] = new("BlurEffect", nil, "Blur", { Enabled = false, Size = 0 })
	I[3] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Contrast = 0.25, Saturation = 0.1 })
	I[4] = new("SunRaysEffect", nil, "SunRays", { Enabled = false })
	I[5] = new("BloomEffect", nil, "Bloom", { Intensity = 0.1, Size = 0, Threshold = 0 })
	I[6] = new("BlurEffect", nil, "BlurUi", { Enabled = false, Size = 0 })
	I[7] = new("StringValue", nil, "LightingPreset")
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7] }
end

return build
