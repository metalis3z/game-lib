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
	I[1] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Brightness = 0.009, Contrast = 0.1, Saturation = 0.05 })
	I[2] = new("BloomEffect", nil, "Bloom", { Intensity = 1, Size = 44444, Threshold = 3.6700001 })
	I[3] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.017, Spread = 0.19 })
	I[4] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(255, 255, 255), Decay = Color3.fromRGB(0, 0, 0), Density = 0.122, Haze = 2.0699997 })
	I[5] = new("Sky", nil, "Sky", { MoonAngularSize = 0, MoonTextureContent = Content.fromUri("rbxassetid://7812261658"), SkyboxBackContent = Content.fromUri("rbxassetid://7900939143"), SkyboxDownContent = Content.fromUri("rbxassetid://7812198921"), SkyboxFrontContent = Content.fromUri("rbxassetid://7900939143"), SkyboxLeftContent = Content.fromUri("rbxassetid://7900939143"), SkyboxRightContent = Content.fromUri("rbxassetid://7900939143"), SkyboxUpContent = Content.fromUri("rbxassetid://7900942238"), StarCount = 5000, SunAngularSize = 3.5, SunTextureContent = Content.fromUri("rbxassetid://7812253208") })
	return { I[1], I[2], I[3], I[4], I[5] }
end

return build
