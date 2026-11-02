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
	I[1] = new("Sky", nil, "Sky", { SkyboxBackContent = Content.fromUri("rbxassetid://591058823"), SkyboxDownContent = Content.fromUri("rbxassetid://591059876"), SkyboxFrontContent = Content.fromUri("rbxassetid://591058104"), SkyboxLeftContent = Content.fromUri("rbxassetid://591057861"), SkyboxRightContent = Content.fromUri("rbxassetid://591057625"), SkyboxUpContent = Content.fromUri("rbxassetid://591059642") })
	I[2] = new("BloomEffect", nil, "Bloom", { Intensity = 1, Threshold = 2 })
	I[3] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.01, Spread = 0.1 })
	I[4] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Brightness = 0.05, Contrast = 0.1, Saturation = 0.15 })
	I[5] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(199, 199, 199), Decay = Color3.fromRGB(106, 112, 125), Density = 0.3, Offset = 0.25 })
	return { I[1], I[2], I[3], I[4], I[5] }
end

return build
