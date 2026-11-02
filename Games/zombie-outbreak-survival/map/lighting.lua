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
	I[1] = new("Sky", nil, "Sky", { CelestialBodiesShown = false, SkyboxBackContent = Content.fromUri("http://www.roblox.com/asset/?id=10930707221"), SkyboxDownContent = Content.fromUri("http://www.roblox.com/asset/?id=10930708281"), SkyboxFrontContent = Content.fromUri("http://www.roblox.com/asset/?id=10930708925"), SkyboxLeftContent = Content.fromUri("http://www.roblox.com/asset/?id=10930709518"), SkyboxRightContent = Content.fromUri("http://www.roblox.com/asset/?id=10930710052"), SkyboxUpContent = Content.fromUri("http://www.roblox.com/asset/?id=10930710574") })
	return I[1]
end

return build
