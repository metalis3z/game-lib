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
	I[1] = new("ColorCorrectionEffect", nil, "ColorCCorrection", { Brightness = 0.1, Contrast = 0.1, Saturation = 0.4, TintColor = Color3.fromRGB(255, 233, 233) }, { ["ViralWorkerRef"] = "vw_e3c8a2b680" })
	I[2] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0 }, { ["ViralWorkerRef"] = "vw_f6db1d618d" })
	return { I[1], I[2] }
end

return build
