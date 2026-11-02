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
	I[1] = new("BlurEffect", nil, "Fade_Blur", { Enabled = false, Size = 56 })
	I[2] = new("ColorCorrectionEffect", nil, "Fade_ColorCorrection", { Brightness = -1, Enabled = false })
	I[3] = new("BlurEffect", nil, "Notification_Blur", { Enabled = false, Size = 56 })
	I[4] = new("BlurEffect", nil, "Water_Blur", { Enabled = false, Size = 4 })
	I[5] = new("ColorCorrectionEffect", nil, "Water_ColorCorrection", { Enabled = false, TintColor = Color3.fromRGB(0, 170, 255) })
	I[6] = new("DepthOfFieldEffect", nil, "Water_DepthOfField", { Enabled = false, FarIntensity = 1, FocusDistance = 16, InFocusRadius = 0, NearIntensity = 0 })
	I[7] = new("BloomEffect", nil, "Water_Bloom", { Enabled = false, Intensity = 0.2, Size = 56, Threshold = 0.4 })
	I[8] = new("BlurEffect", nil, "Standard_Blur", { Size = 1.5 })
	I[9] = new("ColorCorrectionEffect", nil, "Standard_ColorCorrection")
	I[10] = new("BloomEffect", nil, "Standard_Bloom", { Intensity = 0.2, Size = 16, Threshold = 0.8 })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10] }
end

return build
