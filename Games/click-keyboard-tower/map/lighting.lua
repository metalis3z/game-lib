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
	I[1] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.01, Spread = 0.1 })
	I[2] = new("DepthOfFieldEffect", nil, "DepthOfField", { Enabled = false, FarIntensity = 0.1, InFocusRadius = 30 })
	I[3] = new("BloomEffect", nil, "Bloom", { Intensity = 1, Threshold = 2 })
	I[4] = new("Sky", nil, "Sky ( Add To Lighting)", { CelestialBodiesShown = false, MoonAngularSize = 1, SkyboxBackContent = Content.fromUri("rbxassetid://2176109632"), SkyboxDownContent = Content.fromUri("rbxassetid://1181585971"), SkyboxFrontContent = Content.fromUri("rbxassetid://2176109632"), SkyboxLeftContent = Content.fromUri("rbxassetid://2176109632"), SkyboxRightContent = Content.fromUri("rbxassetid://2176109632"), SkyboxUpContent = Content.fromUri("rbxassetid://2176110058"), StarCount = 1, SunAngularSize = 1 })
	I[5] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(199, 199, 199), Decay = Color3.fromRGB(106, 112, 125), Density = 0.3, Offset = 0.25 })
	return { I[1], I[2], I[3], I[4], I[5] }
end

return build
