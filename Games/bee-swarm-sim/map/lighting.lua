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
	I[1] = new("BloomEffect", nil, "Bloom", { Intensity = 0.15, Size = 56 })
	I[2] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Brightness = 0.08, Contrast = 0.02, Saturation = 0.4 })
	I[3] = new("DepthOfFieldEffect", nil, "DepthOfField", { Enabled = false, FarIntensity = 0.2, FocusDistance = 0, InFocusRadius = 50, NearIntensity = 0 })
	I[4] = new("BlurEffect", nil, "NpcsUI", { Enabled = false })
	I[5] = new("ColorCorrectionEffect", nil, "NpcsUI", { Brightness = -0.1, Contrast = -0.5, Enabled = false, Saturation = -0.6 })
	I[6] = new("SunRaysEffect", nil, "SunRays")
	I[7] = new("Sky", nil, "Sky", { MoonTextureContent = Content.fromUri("rbxassetid://6444320592"), SkyboxBackContent = Content.fromUri("rbxassetid://6444884337"), SkyboxDownContent = Content.fromUri("rbxassetid://6444884785"), SkyboxFrontContent = Content.fromUri("rbxassetid://6444884337"), SkyboxLeftContent = Content.fromUri("rbxassetid://6444884337"), SkyboxRightContent = Content.fromUri("rbxassetid://6444884337"), SkyboxUpContent = Content.fromUri("rbxassetid://6412503613"), SunAngularSize = 11, SunTextureContent = Content.fromUri("rbxassetid://6196665106") })
	I[8] = new("BlurEffect", nil, "Blur", { Enabled = false, Size = 15 })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8] }
end

return build
