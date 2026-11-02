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
	I[1] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(255, 255, 255), Decay = Color3.fromRGB(255, 255, 255), Density = 0.111 })
	I[2] = new("Sky", nil, "Sky", { SkyboxBackContent = Content.fromUri("rbxassetid://13107325341"), SkyboxDownContent = Content.fromUri("rbxassetid://13107329809"), SkyboxFrontContent = Content.fromUri("rbxassetid://13107334845"), SkyboxLeftContent = Content.fromUri("rbxassetid://13107337703"), SkyboxRightContent = Content.fromUri("rbxassetid://13107340396"), SkyboxUpContent = Content.fromUri("rbxassetid://13107344387") })
	I[3] = new("BloomEffect", nil, "Bloom", { Intensity = 0.45, Size = 50, Threshold = 2.1730001 })
	I[4] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Contrast = 0.2, Saturation = 0.2 })
	return { I[1], I[2], I[3], I[4] }
end

return build
