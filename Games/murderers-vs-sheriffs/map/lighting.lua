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
	I[1] = new("BloomEffect", nil, "Bloom", { Intensity = 0 })
	I[2] = new("ColorGradingEffect", nil, "ColorGrading", { TonemapperPreset = Enum.TonemapperPreset.Retro })
	I[3] = new("StringValue", nil, "LightingPreset")
	I[4] = new("BlurEffect", nil, "MenuBlur", { Enabled = false, Size = 14 })
	I[5] = new("BlurEffect", nil, "NewItemBlur", { Enabled = false, Size = 8 })
	I[6] = new("BlurEffect", nil, "PurchasePendingBlur", { Size = 0 })
	return { I[1], I[2], I[3], I[4], I[5], I[6] }
end

return build
