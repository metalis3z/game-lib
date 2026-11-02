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
	I[1] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(183, 255, 253), Decay = Color3.fromRGB(33, 96, 112), Density = 0.214, Glare = 1.34, Haze = 1.22 })
	I[2] = new("Sky", nil, "Default", { CelestialBodiesShown = false, SkyboxBackContent = Content.fromUri("rbxassetid://3178156714"), SkyboxDownContent = Content.fromUri("rbxassetid://3178156991"), SkyboxFrontContent = Content.fromUri("rbxassetid://3178156714"), SkyboxLeftContent = Content.fromUri("rbxassetid://3178156714"), SkyboxRightContent = Content.fromUri("rbxassetid://3178156714"), SkyboxUpContent = Content.fromUri("rbxassetid://3178157411"), StarCount = 0 })
	I[3] = new("ColorCorrectionEffect", nil, "ColorCorrection", { Saturation = 0.65 })
	I[4] = new("ColorCorrectionEffect", nil, "CreditsColorCorrection", { Enabled = false })
	I[5] = new("DepthOfFieldEffect", nil, "DepthOfField", { FarIntensity = 0.267, FocusDistance = 70.4599991, InFocusRadius = 36.3650017, NearIntensity = 0.25 })
	I[6] = new("BlurEffect", nil, "MenuBlur", { Size = 8 })
	return { I[1], I[2], I[3], I[4], I[5], I[6] }
end

return build
