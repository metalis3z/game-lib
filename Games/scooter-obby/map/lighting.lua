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
	I[1] = new("BloomEffect", nil, "Bloom", { Intensity = 3, Threshold = 2 })
	I[2] = new("DepthOfFieldEffect", nil, "DepthOfField", { Enabled = false, FarIntensity = 0.1, InFocusRadius = 30 })
	I[3] = new("ColorCorrectionEffect", nil, "Red")
	I[4] = new("BloomEffect", nil, "NukeBloom", { Intensity = 0, Size = 0, Threshold = 5 })
	I[5] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(135, 219, 255), Decay = Color3.fromRGB(207, 207, 207), Density = 0.34 })
	I[6] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Brightness = 0.2, Contrast = 0.3, Saturation = 0.3 })
	I[7] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.013, Spread = 0.352 })
	I[8] = new("Sky", nil, "Sky", { MoonTextureContent = Content.fromUri("rbxassetid://6444320592"), SkyboxBackContent = Content.fromUri("rbxassetid://6444884337"), SkyboxDownContent = Content.fromUri("rbxassetid://6444884785"), SkyboxFrontContent = Content.fromUri("rbxassetid://6444884337"), SkyboxLeftContent = Content.fromUri("rbxassetid://6444884337"), SkyboxRightContent = Content.fromUri("rbxassetid://6444884337"), SkyboxUpContent = Content.fromUri("rbxassetid://6412503613"), StarCount = 0, SunAngularSize = 5, SunTextureContent = Content.fromUri("rbxassetid://6196665106") })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8] }
end

return build
