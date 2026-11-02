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
	I[1] = new("Atmosphere", nil, "Atmosphere", { Color = Color3.fromRGB(216, 255, 250), Density = 0.348, Glare = 0.63, Offset = 1 })
		I[2] = new("BlurEffect", I[1], "Blur", { Size = 7.9000001 })
	I[3] = new("Sky", nil, "Sky", { SkyboxBackContent = Content.fromUri("http://www.roblox.com/asset/?id=150335574"), SkyboxDownContent = Content.fromUri("http://www.roblox.com/asset/?id=150335585"), SkyboxFrontContent = Content.fromUri("http://www.roblox.com/asset/?id=150335628"), SkyboxLeftContent = Content.fromUri("http://www.roblox.com/asset/?id=150335620"), SkyboxRightContent = Content.fromUri("http://www.roblox.com/asset/?id=150335610"), SkyboxUpContent = Content.fromUri("http://www.roblox.com/asset/?id=150335642"), StarCount = 1334 })
	I[4] = new("ColorCorrectionEffect", nil, "ColorCorrection", { TintColor = Color3.fromRGB(231, 255, 243) })
	I[5] = new("DepthOfFieldEffect", nil, "DepthOfField", { FarIntensity = 1, FocusDistance = 200, InFocusRadius = 50, NearIntensity = 0 })
	I[6] = new("SunRaysEffect", nil, "SunRays", { Intensity = 0.126, Spread = 0.147 })
	return { I[1], I[3], I[4], I[5], I[6] }
end

return build
