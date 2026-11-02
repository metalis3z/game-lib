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
	I[1] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(180, 180, 180), Decay = Color3.fromRGB(90, 100, 115), Density = 0.4, Glare = 10, Haze = 0.01, Offset = 0.9 })
	I[2] = new("Sky", nil, "DreamyOcean", { SkyboxBackContent = Content.fromUri("http://www.roblox.com/asset/?id=188914951"), SkyboxDownContent = Content.fromUri("http://www.roblox.com/asset/?id=188914976"), SkyboxFrontContent = Content.fromUri("http://www.roblox.com/asset/?id=188914995"), SkyboxLeftContent = Content.fromUri("http://www.roblox.com/asset/?id=188915051"), SkyboxRightContent = Content.fromUri("http://www.roblox.com/asset/?id=188915064"), SkyboxUpContent = Content.fromUri("http://www.roblox.com/asset/?id=188915071"), StarCount = 1000 })
	I[3] = new("BloomEffect", nil, "Bloom", { Intensity = 1, Threshold = 2 })
	I[4] = new("BlurEffect", nil, "Blur", { Size = 1 })
	I[5] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Contrast = 0.3, Saturation = 1, TintColor = Color3.fromRGB(243, 242, 255) })
	I[6] = new("DepthOfFieldEffect", nil, "DepthOfField", { FarIntensity = 0.025, InFocusRadius = 50, NearIntensity = 0.044 })
	I[7] = new("SunRaysEffect", nil, "SunRays", { Enabled = false })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7] }
end

return build
