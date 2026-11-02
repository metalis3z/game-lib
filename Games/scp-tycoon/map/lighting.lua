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
	I[1] = new("Sky", nil, "Sky", { MoonTextureContent = Content.fromUri("rbxassetid://0"), SkyboxBackContent = Content.fromUri("http://www.roblox.com/asset/?id=4498828382"), SkyboxDownContent = Content.fromUri("http://www.roblox.com/asset/?id=4498828812"), SkyboxFrontContent = Content.fromUri("http://www.roblox.com/asset/?id=4498829917"), SkyboxLeftContent = Content.fromUri("http://www.roblox.com/asset/?id=4498830911"), SkyboxRightContent = Content.fromUri("http://www.roblox.com/asset/?id=4498830417"), SkyboxUpContent = Content.fromUri("http://www.roblox.com/asset/?id=4498831746") })
	return I[1]
end

return build
