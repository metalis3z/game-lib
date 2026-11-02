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
	I[1] = new("ColorCorrectionEffect", nil, "ColorCorrection", { TintColor = Color3.fromRGB(197, 197, 197) })
	I[2] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(216, 255, 250), Density = 0.348, Glare = 0.63, Offset = 1 })
	I[3] = new("Sky", nil, "Cloudy", { MoonAngularSize = 1, SkyboxBackContent = Content.fromUri("http://www.roblox.com/asset/?id=4495864450"), SkyboxDownContent = Content.fromUri("http://www.roblox.com/asset/?id=4495864887"), SkyboxFrontContent = Content.fromUri("http://www.roblox.com/asset/?id=4495865458"), SkyboxLeftContent = Content.fromUri("http://www.roblox.com/asset/?id=4495866035"), SkyboxRightContent = Content.fromUri("http://www.roblox.com/asset/?id=4495866584"), SkyboxUpContent = Content.fromUri("http://www.roblox.com/asset/?id=4495867486"), SunAngularSize = 1 })
	return { I[1], I[2], I[3] }
end

return build
