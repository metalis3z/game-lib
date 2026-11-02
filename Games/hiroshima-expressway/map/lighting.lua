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
	I[1] = new("Sky", nil, "Zaibatsu_Night", { MoonAngularSize = 0, SkyboxBackContent = Content.fromUri("rbxassetid://4932314971"), SkyboxDownContent = Content.fromUri("rbxassetid://4932328466"), SkyboxFrontContent = Content.fromUri("rbxassetid://4932330866"), SkyboxLeftContent = Content.fromUri("rbxassetid://4932332041"), SkyboxRightContent = Content.fromUri("rbxassetid://4932345845"), SkyboxUpContent = Content.fromUri("rbxassetid://4932346224"), StarCount = 0, SunAngularSize = 7, SunTextureContent = Content.fromUri("rbxassetid://106593226257469") })
	I[2] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(255, 255, 255), Decay = Color3.fromRGB(90, 101, 113), Density = 0, Glare = 10, Haze = 1 })
	I[3] = new("BloomEffect", nil, "Bloom", { Intensity = 1, Size = 555, Threshold = 1.9 })
	return { I[1], I[2], I[3] }
end

return build
