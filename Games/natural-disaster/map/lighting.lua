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
	I[1] = new("ColorGradingEffect", nil, "ColorGrading", { TonemapperPreset = Enum.TonemapperPreset.Retro })
	I[2] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Saturation = 0.1 })
	I[3] = new("BloomEffect", nil, "Bloom", { Intensity = 0 })
	return { I[1], I[2], I[3] }
end

return build
