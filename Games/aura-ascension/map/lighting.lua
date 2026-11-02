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
	I[1] = new("Atmosphere", nil, "Normal", { Color = Color3.fromRGB(169, 225, 255), Decay = Color3.fromRGB(78, 124, 138), Density = 0.278, Glare = 0.2, Haze = 2 })
	I[2] = new("Sky", nil, "Normal", { SkyboxBackContent = Content.fromUri("rbxassetid://16573631102"), SkyboxDownContent = Content.fromUri("rbxassetid://16573631950"), SkyboxFrontContent = Content.fromUri("rbxassetid://16573632795"), SkyboxLeftContent = Content.fromUri("rbxassetid://16573633258"), SkyboxRightContent = Content.fromUri("rbxassetid://16573633908"), SkyboxUpContent = Content.fromUri("rbxassetid://16573634370") })
	I[3] = new("BlurEffect", nil, "Normal", { Size = 0 })
	I[4] = new("BloomEffect", nil, "Normal", { Intensity = 1, Threshold = 3.0109999 })
	I[5] = new("BlurEffect", nil, "UI", { Size = 0 })
	I[6] = new("DepthOfFieldEffect", nil, "DepthOfField", { Enabled = false, FarIntensity = 1, FocusDistance = 0, InFocusRadius = 7.8649998, NearIntensity = 1 })
	I[7] = new("ColorCorrectionEffect", nil, "Normal", { Contrast = 0.2, Saturation = 0.3 })
	I[8] = new("BlurEffect", nil, "PurchaseBlur", { Size = 0 })
	I[9] = new("BlurEffect", nil, "UIBlur", { Size = 0 })
	I[10] = new("DepthOfFieldEffect", nil, "InventoryHudDepthOfField", { Enabled = false, FarIntensity = 0, FocusDistance = 12, InFocusRadius = 18, NearIntensity = 0 })
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10] }
end

return build
