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
	I[1] = new("Sky", nil, "Sky", { MoonTextureContent = Content.fromUri("rbxassetid://6444320592"), SkyboxBackContent = Content.fromUri("rbxassetid://6444884337"), SkyboxDownContent = Content.fromUri("rbxassetid://6444884785"), SkyboxFrontContent = Content.fromUri("rbxassetid://6444884337"), SkyboxLeftContent = Content.fromUri("rbxassetid://6444884337"), SkyboxRightContent = Content.fromUri("rbxassetid://6444884337"), SkyboxUpContent = Content.fromUri("rbxassetid://6412503613"), SunAngularSize = 11, SunTextureContent = Content.fromUri("rbxassetid://6196665106") })
	I[2] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.01, Spread = 0.1 })
	I[3] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(199, 199, 199), Decay = Color3.fromRGB(106, 112, 125), Density = 0.3, Offset = 0.25 })
	I[4] = new("BloomEffect", nil, "Bloom", { Intensity = 1, Threshold = 2 })
	I[5] = new("DepthOfFieldEffect", nil, "DepthOfField", { Enabled = false, FarIntensity = 0.1, InFocusRadius = 30 })
	return { I[1], I[2], I[3], I[4], I[5] }
end

return build
