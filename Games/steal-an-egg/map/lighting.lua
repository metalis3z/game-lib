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
	I[1] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(0, 0, 0), Decay = Color3.fromRGB(0, 0, 0), Density = 0.309 })
	I[2] = new("Sky", nil, "Sky", { SkyboxBackContent = Content.fromUri("rbxassetid://591058823"), SkyboxDownContent = Content.fromUri("rbxassetid://591059876"), SkyboxFrontContent = Content.fromUri("rbxassetid://591058104"), SkyboxLeftContent = Content.fromUri("rbxassetid://591057861"), SkyboxRightContent = Content.fromUri("rbxassetid://591057625"), SkyboxUpContent = Content.fromUri("rbxassetid://591059642") })
	I[3] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Contrast = 0.2, Saturation = 0.1, TintColor = Color3.fromRGB(255, 237, 239) })
	I[4] = new("ColorCorrectionEffect", nil, "DJJhai")
	I[5] = new("BlurEffect", nil, "FrameBlur", { Enabled = false, Size = 0 })
	I[6] = new("ColorCorrectionEffect", nil, "MeteorShower")
	I[7] = new("ColorCorrectionEffect", nil, "NightColor")
	I[8] = new("BlurEffect", nil, "SpaceTravel", { Size = 0 })
	I[9] = new("ColorCorrectionEffect", nil, "SunGod")
	I[10] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.01, Spread = 0.5 })
	I[11] = new("DepthOfFieldEffect", nil, "TabControllerDepthBlur", { Enabled = false, FarIntensity = 0.755, FocusDistance = 200, InFocusRadius = 13.25, NearIntensity = 0 })
	I[12] = new("ColorCorrectionEffect", nil, "TrackerColorCorrection", { Enabled = false, TintColor = Color3.fromRGB(0, 166, 255) })
	I[13] = new("DepthOfFieldEffect", nil, "TabControllerDepthBlur", { Enabled = false, FarIntensity = 0.755, FocusDistance = 200, InFocusRadius = 13.25, NearIntensity = 0 })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13] }
end

return build
