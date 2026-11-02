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
	I[1] = new("Sky", nil, "Dark night", { CelestialBodiesShown = false, SkyboxBackContent = Content.fromUri("http://www.roblox.com/asset/?id=48020371"), SkyboxDownContent = Content.fromUri("http://www.roblox.com/asset/?id=48020144"), SkyboxFrontContent = Content.fromUri("http://www.roblox.com/asset/?id=48020234"), SkyboxLeftContent = Content.fromUri("http://www.roblox.com/asset/?id=48020211"), SkyboxRightContent = Content.fromUri("http://www.roblox.com/asset/?id=48020254"), SkyboxUpContent = Content.fromUri("http://www.roblox.com/asset/?id=48020383") })
	I[2] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(0, 0, 0), Decay = Color3.fromRGB(0, 0, 0), Density = 0.65, Glare = 3.6199999, Offset = 0.224 })
	return { I[1], I[2] }
end

return build
