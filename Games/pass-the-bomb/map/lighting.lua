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
	I[1] = new("Sky", nil, "Sky", { CelestialBodiesShown = false, MoonAngularSize = 1.5, MoonTextureContent = Content.fromUri("rbxassetid://1075087760"), SkyboxBackContent = Content.fromUri("rbxassetid://3740561496"), SkyboxDownContent = Content.fromUri("rbxassetid://3740563398"), SkyboxFrontContent = Content.fromUri("rbxassetid://3740562716"), SkyboxLeftContent = Content.fromUri("rbxassetid://3740562416"), SkyboxRightContent = Content.fromUri("rbxassetid://3740562051"), SkyboxUpContent = Content.fromUri("rbxassetid://3740563017"), StarCount = 500, SunAngularSize = 20, SunTextureContent = Content.fromUri("rbxassetid://1084351190") })
	I[2] = new("BlurEffect", nil, "Blur", { Size = 4.5 })
	I[3] = new("ColorCorrectionEffect", nil, "Default", { Brightness = 0.1, Contrast = 0.3, Saturation = 0.1, TintColor = Color3.fromRGB(151, 182, 255) })
	I[4] = new("SunRaysEffect", nil, "SunRays")
	I[5] = new("ColorGradingEffect", nil, "ColorGrading", { TonemapperPreset = Enum.TonemapperPreset.Retro })
	I[6] = new("BloomEffect", nil, "Bloom", { Intensity = 0 })
	return { I[1], I[2], I[3], I[4], I[5], I[6] }
end

return build
