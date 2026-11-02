-- Construit les modèles des marteaux (un par entrée de HammerConfig.Tiers) dans ReplicatedStorage.HammerSystem.Models.
-- Blocs à studs, manche court. La pièce "Handle" est la poignée : le manche monte le long de son axe Y, la tête frappe le long de X.
-- return function(HammerConfig) -> rapport. Peut être relancé.
local V, C, A, rad = Vector3.new, CFrame.new, CFrame.Angles, math.rad

local function build(tier, index)
	local model = Instance.new("Model")
	model.Name = "Tier" .. index
	local function piece(name, size, cf, color, o)
		o = o or {}
		local p = Instance.new("Part")
		p.Name = name
		p.Size, p.CFrame, p.Color = size, cf, color
		p.Material = o.neon and Enum.Material.Neon or Enum.Material.Plastic
		if o.studs then pcall(function() p.MaterialVariant = "Studs" end) end
		p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
		p.CanCollide, p.CanTouch, p.CanQuery, p.Massless, p.Anchored = false, false, false, true, false
		p.Parent = model
		return p
	end
	local LEATHER, DARK = Color3.fromRGB(58, 40, 30), Color3.fromRGB(30, 24, 22)
	local function lighter(c, k) return c:Lerp(Color3.new(1, 1, 1), k) end
	local function darker(c, k) return c:Lerp(Color3.new(0, 0, 0), k) end

	-- poignée de cuir, trois bagues, pommeau
	local handle = piece("Handle", V(0.46, 1.3, 0.46), C(0, 0, 0), LEATHER)
	model.PrimaryPart = handle
	for i = -1, 1 do piece("GripRing", V(0.54, 0.12, 0.54), C(0, i * 0.4, 0), DARK) end
	piece("Pommel", V(0.72, 0.3, 0.72), C(0, -0.8, 0), tier.Band, {studs = true})
	piece("PommelTip", V(0.4, 0.2, 0.4), C(0, -1.03, 0) * A(0, rad(45), 0), lighter(tier.Band, 0.3))
	-- manche
	piece("Guard", V(0.7, 0.2, 0.7), C(0, 0.75, 0), tier.Band)
	piece("Shaft", V(0.36, 1.3, 0.36), C(0, 1.5, 0), tier.Shaft)
	piece("ShaftBand", V(0.44, 0.14, 0.44), C(0, 1.3, 0), darker(tier.Shaft, 0.35))
	piece("Collar", V(0.66, 0.3, 0.66), C(0, 2.26, 0), tier.Band, {studs = true})
	-- tête : bloc central, bande, deux faces de frappe biseautées, rivets, chapeau
	local headY = 3.1
	piece("Head", V(1.9, 1.44, 1.44), C(0, headY, 0), tier.Head, {studs = true})
	piece("HeadBand", V(0.5, 1.56, 1.56), C(0, headY, 0), tier.Band)
	for _, sx in {-1, 1} do
		piece("Neck", V(0.26, 1.24, 1.24), C(sx * 1.06, headY, 0), darker(tier.Head, 0.3))
		piece("Face", V(0.46, 1.7, 1.7), C(sx * 1.4, headY, 0), tier.Face, {studs = true})
		piece("FaceRim", V(0.14, 1.84, 1.84), C(sx * 1.22, headY, 0), darker(tier.Face, 0.35))
		piece("Strike", V(0.1, 1.2, 1.2), C(sx * 1.66, headY, 0), lighter(tier.Face, 0.35))
		for _, sy in {-1, 1} do
			for _, sz in {-1, 1} do
				piece("Rivet", V(0.2, 0.2, 0.2), C(sx * 0.62, headY + sy * 0.5, sz * 0.74), lighter(tier.Band, 0.45))
			end
		end
	end
	piece("Cap", V(0.74, 0.22, 0.74), C(0, headY + 0.83, 0), tier.Band, {studs = true})
	piece("CapTip", V(0.4, 0.2, 0.4), C(0, headY + 1.02, 0) * A(0, rad(45), 0), lighter(tier.Band, 0.3))
	if tier.Glow then -- pierre lumineuse de chaque côté, lueur, étincelles
		for _, sz in {-1, 1} do
			piece("Gem", V(0.56, 0.56, 0.18), C(0, headY, sz * 0.8) * A(0, 0, rad(45)), tier.Glow, {neon = true})
		end
		local core = model.Head
		local light = Instance.new("PointLight")
		light.Color, light.Range, light.Brightness = tier.Glow, 9, 1.2
		light.Parent = core
		local sparkle = Instance.new("ParticleEmitter")
		sparkle.Texture = "rbxasset://textures/particles/sparkles_main.dds"
		sparkle.Color = ColorSequence.new(tier.Glow)
		sparkle.LightEmission = 1
		sparkle.Rate = index >= 5 and 9 or 4
		sparkle.Lifetime = NumberRange.new(0.5, 0.9)
		sparkle.Speed = NumberRange.new(0.6, 1.6)
		sparkle.SpreadAngle = Vector2.new(180, 180)
		sparkle.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3, 0.34), NumberSequenceKeypoint.new(1, 0)})
		sparkle.Parent = core
	end
	if tier.Rainbow then -- le dernier marteau : arêtes lumineuses qui changent de couleur (HammerClient)
		for _, sx in {-1, 1} do
			piece("Prism", V(0.12, 1.94, 1.94), C(sx * 1.52, headY, 0), Color3.fromRGB(255, 255, 255), {neon = true}).Transparency = 0.2
		end
		piece("Prism", V(0.42, 1.2, 0.16), C(0, 1.5, 0), Color3.fromRGB(255, 255, 255), {neon = true})
	end
	for _, p in model:GetChildren() do
		if p ~= handle then
			local w = Instance.new("Weld") -- décalage écrit en dur
			w.Part0, w.Part1 = handle, p
			w.C0 = handle.CFrame:ToObjectSpace(p.CFrame)
			w.Parent = p
		end
	end
	local off = Instance.new("Attachment") -- où se pose la deuxième main pendant un coup
	off.Name = "OffHand"
	off.Position = Vector3.new(0, 0.44, 0)
	off.Parent = handle
	model:ScaleTo(0.82) -- taille en main : environ 4,3 studs du pommeau au chapeau
	return model
end

-- Batte : pièces rondes (cylindres et sphères). Pommeau, poignée gainée, fût qui s'élargit, bout arrondi, deux anneaux rouges.
local function buildBat()
	local model = Instance.new("Model")
	model.Name = "Bat"
	local WOOD, LIGHT, TAPE, RED = Color3.fromRGB(196, 142, 84), Color3.fromRGB(222, 174, 112), Color3.fromRGB(38, 36, 44), Color3.fromRGB(214, 44, 52)
	local function common(p, name, color, material)
		p.Name = name
		p.Color = color
		p.Material = material or Enum.Material.SmoothPlastic
		p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
		p.CanCollide, p.CanTouch, p.CanQuery, p.Massless, p.Anchored = false, false, false, true, false
		p.Parent = model
		return p
	end
	local function round(name, diameter, height, y, color, material) -- cylindre debout le long du manche
		local p = Instance.new("Part")
		p.Shape = Enum.PartType.Cylinder
		p.Size = V(height, diameter, diameter)
		p.CFrame = C(0, y, 0) * A(0, 0, rad(90))
		return common(p, name, color, material)
	end
	local function ball(name, diameter, y, color, material)
		local p = Instance.new("Part")
		p.Shape = Enum.PartType.Ball
		p.Size = V(diameter, diameter, diameter)
		p.CFrame = C(0, y, 0)
		return common(p, name, color, material)
	end
	local handle = Instance.new("Part") -- prise (invisible) : le manche monte le long de son axe Y
	handle.Size = V(0.3, 0.3, 0.3)
	handle.CFrame = C(0, 0, 0)
	handle.Transparency = 1
	common(handle, "Handle", WOOD)
	model.PrimaryPart = handle
	ball("Knob", 0.62, -0.78, WOOD, Enum.Material.Wood)
	round("KnobRing", 0.66, 0.12, -0.62, LIGHT, Enum.Material.Wood)
	round("Grip", 0.36, 1.4, 0.1, TAPE)
	for i = 0, 5 do round("Tape", 0.4, 0.07, -0.46 + i * 0.24, Color3.fromRGB(70, 68, 80)) end
	round("GripEnd", 0.44, 0.1, 0.84, RED)
	-- fût : sept tronçons de plus en plus larges
	local y = 0.89
	for i = 0, 6 do
		local d = 0.4 + i * 0.075
		round("Barrel", d, 0.44, y + 0.22, i % 2 == 0 and WOOD or LIGHT, Enum.Material.Wood)
		y += 0.44
	end
	round("Ring", 0.9, 0.12, y - 0.9, RED)
	round("Ring", 0.9, 0.12, y - 0.6, RED)
	round("Head", 0.88, 0.5, y + 0.25, WOOD, Enum.Material.Wood)
	ball("Tip", 0.88, y + 0.5, LIGHT, Enum.Material.Wood)
	local off = Instance.new("Attachment")
	off.Name = "OffHand"
	off.Position = Vector3.new(0, 0.4, 0)
	off.Parent = handle
	for _, p in model:GetChildren() do
		if p ~= handle then
			local w = Instance.new("Weld")
			w.Part0, w.Part1 = handle, p
			w.C0 = handle.CFrame:ToObjectSpace(p.CFrame)
			w.Parent = p
		end
	end
	return model
end

return function(HammerConfig)
	local system = game:GetService("ReplicatedStorage"):WaitForChild("HammerSystem")
	local old = system:FindFirstChild("Models")
	if old then old:Destroy() end
	local folder = Instance.new("Folder")
	folder.Name = "Models"
	for index, tier in HammerConfig.Tiers do build(tier, index).Parent = folder end
	buildBat().Parent = folder
	folder.Parent = system
	return #HammerConfig.Tiers .. " hammer models and the bat built"
end
