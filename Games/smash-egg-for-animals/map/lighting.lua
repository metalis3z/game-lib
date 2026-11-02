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
	I[1] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.07, Spread = 0.7 })
	I[2] = new("BloomEffect", nil, "Bloom", { Intensity = 0.45, Size = 30, Threshold = 2.2 })
	I[3] = new("DepthOfFieldEffect", nil, "DepthOfField", { Enabled = false, FarIntensity = 0.1, InFocusRadius = 30 })
	I[4] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Brightness = 0.02, Contrast = 0.1, Saturation = 0.06, TintColor = Color3.fromRGB(255, 252, 248) })
	I[5] = new("Sky", nil, "DaySky", { SunAngularSize = 14 })
	return { I[1], I[2], I[3], I[4], I[5] }
end

return build
