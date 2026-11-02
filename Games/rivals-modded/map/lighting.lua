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
	I[1] = new("BlurEffect", nil, "GlowyBackgroundBlur - Teleporting", { Size = 0 })
	I[2] = new("ColorCorrectionEffect", nil, "GlowyBackgroundColorCorrection - Teleporting")
	I[3] = new("BlurEffect", nil, "Teleporting", { Size = 0 })
	I[4] = new("BlurEffect", nil, "GlowyBackgroundBlur - MatchmakingCountdown", { Size = 0 })
	I[5] = new("ColorCorrectionEffect", nil, "GlowyBackgroundColorCorrection - MatchmakingCountdown")
	I[6] = new("BlurEffect", nil, "PurchasePrompt", { Size = 0 })
	I[7] = new("BlurEffect", nil, "GlowyBackgroundBlur - MainGui", { Size = 0 })
	I[8] = new("ColorCorrectionEffect", nil, "GlowyBackgroundColorCorrection - MainGui")
	I[9] = new("BlurEffect", nil, "GlowyBackgroundBlur - WarningCard", { Size = 0 })
	I[10] = new("ColorCorrectionEffect", nil, "GlowyBackgroundColorCorrection - WarningCard")
	I[11] = new("Sky", nil, "LightingController", { CelestialBodiesShown = false, SkyboxBackContent = Content.fromUri("rbxassetid://14147881792"), SkyboxDownContent = Content.fromUri("rbxassetid://14147882149"), SkyboxFrontContent = Content.fromUri("rbxassetid://14147882761"), SkyboxLeftContent = Content.fromUri("rbxassetid://14147883091"), SkyboxRightContent = Content.fromUri("rbxassetid://14147882405"), SkyboxUpContent = Content.fromUri("rbxassetid://14147881297") })
	I[12] = new("Atmosphere", nil, "LightingController", { Color = Color3.fromRGB(140, 196, 231), Density = 0.255, Haze = 1.8200001, Offset = 0.2 })
	I[13] = new("ColorCorrectionEffect", nil, "ColorCorrection")
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13] }
end

return build
