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
	I[1] = new("DepthOfFieldEffect", nil, "TabControllerDepthBlur", { Enabled = false, FarIntensity = 0.755, FocusDistance = 200, InFocusRadius = 13.25, NearIntensity = 0 }, { ["_lemonadeUniqueId"] = "zRjpEFUWzRjp" })
	I[2] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.01, Spread = 0.5 }, { ["_lemonadeUniqueId"] = "JKxz6S7LJKxz" })
	I[3] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Contrast = 0.2, Saturation = 0.1, TintColor = Color3.fromRGB(255, 237, 239) }, { ["_lemonadeUniqueId"] = "AaBEuJhLAaBE" })
	I[4] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(0, 0, 0), Decay = Color3.fromRGB(0, 0, 0), Density = 0.309 }, { ["OriginalArchivable"] = true, ["OriginalColor"] = Color3.fromRGB(0, 0, 0), ["OriginalDecay"] = Color3.fromRGB(0, 0, 0), ["OriginalDensity"] = 0.309, ["OriginalGlare"] = 0, ["OriginalHaze"] = 0, ["OriginalName"] = "Atmosphere", ["OriginalOffset"] = 0, ["OriginalSandboxed"] = false, ["_lemonadeUniqueId"] = "z22GsLyoz22G" })
	I[5] = new("Sky", nil, "Sky", { SkyboxBackContent = Content.fromUri("rbxassetid://591058823"), SkyboxDownContent = Content.fromUri("rbxassetid://591059876"), SkyboxFrontContent = Content.fromUri("rbxassetid://591058104"), SkyboxLeftContent = Content.fromUri("rbxassetid://591057861"), SkyboxRightContent = Content.fromUri("rbxassetid://591057625"), SkyboxUpContent = Content.fromUri("rbxassetid://591059642") }, { ["OriginalCelestialBodiesShown"] = true, ["OriginalMoonAngularSize"] = 11, ["OriginalMoonTextureId"] = "rbxasset://sky/moon.jpg", ["OriginalSkyboxBk"] = "rbxassetid://591058823", ["OriginalSkyboxDn"] = "rbxassetid://591059876", ["OriginalSkyboxFt"] = "rbxassetid://591058104", ["OriginalSkyboxLf"] = "rbxassetid://591057861", ["OriginalSkyboxOrientation"] = Vector3.new(0, 0, 0), ["OriginalSkyboxRt"] = "rbxassetid://591057625", ["OriginalSkyboxUp"] = "rbxassetid://591059642", ["OriginalStarCount"] = 3000, ["OriginalSunAngularSize"] = 21, ["OriginalSunTextureId"] = "rbxasset://sky/sun.jpg", ["_lemonadeUniqueId"] = "XmHCzu7ZXmHC" })
	I[6] = new("DepthOfFieldEffect", nil, "TabDepthBlur", { Enabled = false, FarIntensity = 0.755, FocusDistance = 200, InFocusRadius = 13.25, NearIntensity = 0 }, { ["_lemonadeUniqueId"] = "G8adZ9N9G8ad" })
	I[7] = new("DepthOfFieldEffect", nil, "TabDepthBlur", { Enabled = false, FarIntensity = 0.755, FocusDistance = 200, InFocusRadius = 13.25, NearIntensity = 0 }, { ["_lemonadeUniqueId"] = "izH0wEN3izH0" })
	I[8] = new("BlurEffect", nil, "AdminPanelBlur", { Enabled = false, Size = 0 }, { ["_lemonadeUniqueId"] = "BFEECicGBFEE" })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8] }
end

return build
