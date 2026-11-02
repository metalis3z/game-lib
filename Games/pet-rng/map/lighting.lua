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
	I[1] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(47, 252, 255), Decay = Color3.fromRGB(228, 246, 255), Density = 0.263, Glare = 0.45, Haze = 1, Offset = 0.3 })
	I[2] = new("Sky", nil, "Sunny", { CelestialBodiesShown = false, SkyboxBackContent = Content.fromUri("rbxassetid://6723457641"), SkyboxDownContent = Content.fromUri("rbxassetid://6723459185"), SkyboxFrontContent = Content.fromUri("rbxassetid://6723466949"), SkyboxLeftContent = Content.fromUri("rbxassetid://6723467797"), SkyboxRightContent = Content.fromUri("rbxassetid://6723468355"), SkyboxUpContent = Content.fromUri("rbxassetid://6723477494") })
	I[3] = new("BloomEffect", nil, "Bloom", { Intensity = 0.95, Size = 35, Threshold = 2.0639999 })
	I[4] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Brightness = 0.2, Contrast = 0.2, Saturation = 0.7, TintColor = Color3.fromRGB(255, 243, 235) })
	I[5] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.04 })
	return { I[1], I[2], I[3], I[4], I[5] }
end

return build
