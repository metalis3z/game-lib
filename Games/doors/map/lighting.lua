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
	I[1] = new("ColorCorrectionEffect", nil, "CinematicDoor", { Brightness = -1, Contrast = 1, Enabled = false })
	I[2] = new("ColorCorrectionEffect", nil, "TempLookmanCC", { Brightness = -4, Contrast = 3, Enabled = false, Saturation = -0.8 })
	I[3] = new("Sky", nil, "Sky", { CelestialBodiesShown = false, SkyboxBackContent = Content.fromUri("rbxassetid://10006799348"), SkyboxDownContent = Content.fromUri("rbxassetid://10006799348"), SkyboxFrontContent = Content.fromUri("rbxassetid://10006799348"), SkyboxLeftContent = Content.fromUri("rbxassetid://10006799348"), SkyboxRightContent = Content.fromUri("rbxassetid://10006799348"), SkyboxUpContent = Content.fromUri("rbxassetid://10006799348"), StarCount = 0 })
	return { I[1], I[2], I[3] }
end

return build
