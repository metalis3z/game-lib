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
	I[1] = new("Atmosphere", nil, "Atmosphere", { Density = 0.6 })
	I[2] = new("Sky", nil, "Skybox", { SkyboxBackContent = Content.fromUri("http://www.roblox.com/asset/?id=155657655"), SkyboxDownContent = Content.fromUri("http://www.roblox.com/asset/?id=155674246"), SkyboxFrontContent = Content.fromUri("http://www.roblox.com/asset/?id=155657609"), SkyboxLeftContent = Content.fromUri("http://www.roblox.com/asset/?id=155657671"), SkyboxRightContent = Content.fromUri("http://www.roblox.com/asset/?id=155657619"), SkyboxUpContent = Content.fromUri("http://www.roblox.com/asset/?id=155674931"), StarCount = 0, SunTextureContent = Content.fromUri("rbxassetid://9013498676") })
	I[3] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Saturation = -0.2 })
	I[4] = new("BlurEffect", nil, "EmoteBlur", { Size = 0 })
	I[5] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.002 })
	I[6] = new("ColorCorrectionEffect", nil, "HealthDesaturation")
	return { I[1], I[2], I[3], I[4], I[5], I[6] }
end

return build
