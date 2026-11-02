-- Outil d'édition (pas utilisé en jeu) : construit les tapis de course.
--   ServerStorage.TreadmillModels : un modèle de tapis par palier (SpeedConfig.Skins : Stone, Bronze, Gold...), déjà peint,
--                                   avec ses effets. SpeedServer en pose une copie dans la base du joueur selon son niveau.
--   Dans chaque base (Workspace["all base"]) : le repère invisible TreadmillSpot (là où le tapis est posé), le tapis de départ
--                                   pour le voir dans Studio, et le panneau d'améliorations TreadmillBoard.
-- Tous les tapis gardent la même base : la bande (seule pièce solide), les deux flancs en gradins coiffés de néons, les deux
-- rampes où l'on s'appuie, et l'arche inclinée à l'avant qui porte l'écran. Le nombre de gradins et les ornements changent à chaque palier (table ORNAMENTS).
-- return function(keepPlaces) -> rapport. keepPlaces = true : les tapis restent là où ils sont déjà.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Config = require(ReplicatedStorage:WaitForChild("SpeedSystem"):WaitForChild("SpeedConfig"))

local V = Vector3.new
local rad = math.rad
local rgb = Color3.fromRGB
local STUDS = "rbxassetid://7447638591"
local INK, WHITE = rgb(26, 27, 32), Color3.new(1, 1, 1)

-- mesures communes (repère du tapis : sol en y = 0, l'avant avec l'arche vers -Z, l'arrière par où l'on monte vers +Z)
local DECK_W, DECK_L = 12.7, 18.6
local BELT_W, BELT_L, BELT_Z = 6.4, 14.6, 1.0
local ARM_X, ARM_W, TIER_H = 4.65, 2.7, 0.8 -- flancs : milieu, largeur, hauteur d'un gradin
local ARM_FRONT, ARM_REAR = -6.7, 9.1
local TIER_LENGTH = {1, 0.45, 0.22}            -- part de la longueur du flanc occupée par chaque gradin, du bas vers le haut
local ARCH_Z, HOOD_H, TILT = -7.9, 1.9, 13  -- l'arche penche de TILT degrés vers l'avant
local TIERS = {Stone = 1, Bronze = 1, Gold = 2, Diamond = 2, Flash = 2, Emerald = 2, Lava = 3, Frost = 3, Galaxy = 3, Rainbow = 3, Void = 3, Galactic = 3}
-- flèches sur la bande (tous les tapis) : elles défilent vers l'arrière, comme si la bande tournait (TreadmillFxClient)
local ARROWS = "rbxassetid://114528332505892"
local ARROW_TILE = 2.8 -- un chevron tous les 2,8 studs
-- place du panneau par rapport au tapis : à gauche de l'arche, tourné de 45° vers le coureur (réglé par le créateur sur la base 1)
local BOARD_PLACE = CFrame.new(-12.5, 0.3, -3.4) * CFrame.Angles(0, rad(45), 0)
-- Les tapis sont dessinés avec les mesures ci-dessus, puis resserrés : 1,1 fois moins larges et 1,3 fois moins longs.
local SQUEEZE_X, SQUEEZE_Z = 1 / 1.1, 1 / 1.3
local function squeeze(model)
	for _, p in model:GetDescendants() do
		if p:IsA("BasePart") then
			local cf = p.CFrame
			local function along(axis) return V(axis.X * SQUEEZE_X, axis.Y, axis.Z * SQUEEZE_Z).Magnitude end -- ce que devient une longueur portée par cet axe
			local round = p:IsA("Part") and p.Shape == Enum.PartType.Ball -- une boule reste ronde (on la déplace seulement)
			if not round then p.Size = V(p.Size.X * along(cf.RightVector), p.Size.Y * along(cf.UpVector), p.Size.Z * along(cf.LookVector)) end
			p.CFrame = cf.Rotation + V(cf.X * SQUEEZE_X, cf.Y, cf.Z * SQUEEZE_Z)
		end
	end
end

-- Une pièce de tapis. On passe à travers (sauf solid = true, la bande) ; seules les grosses pièces projettent une ombre.
local function piece(model, name, size, cf, color, o)
	o = o or {}
	local p = Instance.new(o.wedge and "WedgePart" or "Part")
	p.Name = name
	p.Size, p.CFrame, p.Color = size, cf, color
	p.Material = o.material or (o.neon and Enum.Material.Neon or Enum.Material.Plastic)
	if p.Material == Enum.Material.Plastic then pcall(function() p.MaterialVariant = "Studs" end) end
	p.Transparency = o.transparency or 0
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	p.Anchored = true
	p.CanCollide, p.CanQuery, p.CanTouch = o.solid == true, o.solid == true, false
	p.CastShadow = o.shadow == true
	p.Parent = model
	return p
end

-- un effet du palier (SpeedConfig.Skins[...].Fx) : particules qui sortent du socle, ou image posée à plat au milieu de la bande
local function skinFx(spec, deck, belt)
	local e = Instance.new("ParticleEmitter")
	e.Name = "SkinFx"
	e.Texture = Config.FxTextures[spec.Tex]
	e.Color = typeof(spec.Color) == "ColorSequence" and spec.Color or ColorSequence.new(spec.Color)
	e.LightEmission, e.LightInfluence = spec.LE or 1, 0
	e.Rate = spec.Rate
	e.Lifetime = NumberRange.new(spec.Life[1], spec.Life[2])
	e.Speed = NumberRange.new(spec.Speed[1], spec.Speed[2])
	e.SpreadAngle = Vector2.new(spec.Spread or 20, spec.Spread or 20)
	e.Rotation = NumberRange.new(0, 360)
	e.RotSpeed = NumberRange.new(spec.Flat and (spec.Spin or 0) or -(spec.Spin or 60), spec.Spin or (spec.Flat and 0 or 60))
	if spec.Accel then e.Acceleration = spec.Accel end
	local size, alpha = spec.Size, spec.Alpha or 0
	if spec.Grow then
		e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, size * 0.25), NumberSequenceKeypoint.new(1, size)})
		e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, alpha), NumberSequenceKeypoint.new(1, 1)})
	else
		e.Size = spec.Flat and NumberSequence.new(size) or NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.25, size), NumberSequenceKeypoint.new(1, 0)})
		e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, alpha), NumberSequenceKeypoint.new(0.8, alpha), NumberSequenceKeypoint.new(1, 1)})
	end
	e.EmissionDirection = Enum.NormalId.Top
	if spec.Flat then
		e.Orientation = Enum.ParticleOrientation.VelocityPerpendicular -- à plat sur la bande
		e.Speed = NumberRange.new(0.01)
		e.SpreadAngle = Vector2.zero
		local at = Instance.new("Attachment")
		at.Name = "SkinFx"
		at.Position = V(0, belt.Size.Y / 2 + 0.12, 0)
		at.Parent = belt
		e.Parent = at
	else
		e.Parent = deck
	end
end

---------------------------------------------------------------- ornements propres à chaque palier
-- c : add(nom, taille, cf, couleur, options), A = repère du pied de l'arche (incliné), H = hauteur de ses jambes,
--     archTop = dessus de la poutre, rearCorner(côté) = dessus du flanc à l'arrière, tiers, tierTop(k), F / T / G = couleurs du palier
local function bolt(c, at, s, color) -- éclair en zigzag, à plat face à l'arrière
	c.add("Bolt", V(0.5, 1.5, 0.35) * s, at * CFrame.new(0.3 * s, 0.7 * s, 0) * CFrame.Angles(0, 0, rad(-30)), color, {neon = true})
	c.add("Bolt", V(0.5, 1.3, 0.35) * s, at * CFrame.new(-0.05 * s, 1.75 * s, 0) * CFrame.Angles(0, 0, rad(38)), color, {neon = true})
	c.add("Bolt", V(0.5, 1.5, 0.35) * s, at * CFrame.new(0.3 * s, 2.8 * s, 0) * CFrame.Angles(0, 0, rad(-30)), color, {neon = true})
end
local function gem(c, at, s, color) -- gemme taillée : deux blocs croisés, un cœur lumineux
	c.add("Gem", V(1.5, 1.5, 0.9) * s, at * CFrame.Angles(0, 0, rad(45)), color, {material = Enum.Material.Glass, transparency = 0.1})
	c.add("Gem", V(1.15, 1.15, 1.1) * s, at, color:Lerp(WHITE, 0.35), {neon = true})
end

local ORNAMENTS = {}
ORNAMENTS.Bronze = function(c) -- rivets sur les flancs, deux cheminées sur l'arche
	local dark = rgb(92, 50, 22)
	for _, sx in {-1, 1} do
		for _, z in {-4.2, -0.6, 3.0, 6.6} do
			c.add("Rivet", V(0.3, 0.45, 0.45), CFrame.new(sx * (ARM_X + ARM_W / 2 + 0.1), 0.82, z), dark)
		end
		c.add("Pipe", V(0.8, 1.5, 0.8), c.archTop * CFrame.new(sx * 4.7, 0.75, 0), dark)
		c.add("PipeLight", V(0.55, 0.3, 0.55), c.archTop * CFrame.new(sx * 4.7, 1.6, 0), c.G, {neon = true})
	end
end
ORNAMENTS.Gold = function(c) -- couronne sur l'arche, piles de pièces à l'arrière
	local bright, deep = rgb(255, 232, 120), rgb(240, 180, 40)
	for i, h in {1.2, 1.8, 2.5, 1.8, 1.2} do
		c.add("CrownSpike", V(0.9, h, 0.9), c.archTop * CFrame.new((i - 3) * 2.3, h / 2, 0) * CFrame.Angles(0, rad(45), 0), bright)
	end
	c.add("CrownGem", V(0.8, 0.8, 0.8), c.archTop * CFrame.new(0, 2.9, 0) * CFrame.Angles(rad(45), 0, rad(45)), rgb(255, 60, 90), {neon = true})
	for _, sx in {-1, 1} do
		for i = 0, 2 do
			c.add("Coin", V(1.6, 0.4, 1.6), c.rearCorner(sx) * CFrame.new(i * 0.12 * sx, 0.3 + i * 0.42, 0) * CFrame.Angles(0, rad(i * 22), 0), i % 2 == 0 and bright or deep)
		end
	end
end
-- Le diamant du créateur (Workspace.diamond, gardé en copie dans ServerStorage.TreadmillDiamondSource), translucide et lumineux.
-- "at" = le point où repose sa pointe du bas.
local function diamond(c, at, scale, color)
	local source = ServerStorage:FindFirstChild("TreadmillDiamondSource")
	if not source then
		local model = workspace:FindFirstChild("diamond")
		local mesh = model and (model:IsA("MeshPart") and model or model:FindFirstChildWhichIsA("MeshPart", true))
		assert(mesh, "Workspace.diamond : mesh not found")
		source = mesh:Clone()
		source.Name = "TreadmillDiamondSource"
		source.Parent = ServerStorage
	end
	local d = source:Clone()
	d.Name = "Diamond"
	d.Size = source.Size * scale
	d.CFrame = at * CFrame.new(0, d.Size.Y / 2, 0)
	d.Color = color
	d.Material = Enum.Material.Neon
	d.Transparency = 0.4
	d.Anchored = true
	d.CanCollide, d.CanQuery, d.CanTouch, d.CastShadow = false, false, false, false
	d.Parent = c.m
	return d
end
ORNAMENTS.Diamond = function(c) -- les diamants du créateur : un gros qui flotte au-dessus de l'arche, d'autres sur des socles
	local blue, pale = rgb(90, 214, 255), rgb(190, 244, 255)
	diamond(c, c.archTop * CFrame.new(0, 1.0, 0), 1.7, blue)
	c.add("DiamondStand", V(1.8, 0.4, 1.4), c.archTop * CFrame.new(0, 0.2, 0), c.T)
	for _, sx in {-1, 1} do
		diamond(c, c.archTop * CFrame.new(sx * 4.6, 0.3, 0) * CFrame.Angles(0, rad(30 * sx), 0), 0.85, pale)
		c.add("DiamondStand", V(1.5, 0.5, 1.5), c.rearCorner(sx) * CFrame.new(0, 0.25, 0), c.T)
		diamond(c, c.rearCorner(sx) * CFrame.new(0, 0.6, 0), 1.0, blue)
		diamond(c, CFrame.new(sx * ARM_X, c.tierTop(c.tiers) + 0.2, ARM_FRONT + 1.5) * CFrame.Angles(0, rad(45), 0), 0.6, pale)
	end
end
ORNAMENTS.Flash = function(c) -- grand éclair sur l'arche, antennes, petits éclairs à l'arrière
	local yellow = rgb(255, 236, 70)
	bolt(c, c.archTop * CFrame.new(-0.3, 0, 0), 1, yellow)
	for _, sx in {-1, 1} do
		c.add("Antenna", V(0.25, 2.6, 0.25), c.archTop * CFrame.new(sx * 5.2, 1.3, 0), INK)
		c.add("AntennaTip", V(0.55, 0.55, 0.55), c.archTop * CFrame.new(sx * 5.2, 2.8, 0), yellow, {neon = true})
		bolt(c, c.rearCorner(sx) * CFrame.new(-0.2, 0, 0), 0.6, yellow)
	end
end
ORNAMENTS.Emerald = function(c) -- gemmes serties d'or
	local green, gold = rgb(50, 220, 110), rgb(255, 214, 90)
	c.add("GemClaw", V(2.6, 0.4, 1.6), c.archTop * CFrame.new(0, 0.2, 0), gold)
	gem(c, c.archTop * CFrame.new(0, 1.6, 0), 1.3, green)
	for _, sx in {-1, 1} do
		gem(c, c.archTop * CFrame.new(sx * 4.6, 0.9, 0), 0.7, green)
		c.add("GemBase", V(1.3, 0.35, 1.3), c.rearCorner(sx) * CFrame.new(0, 0.18, 0), gold)
		gem(c, c.rearCorner(sx) * CFrame.new(0, 1.0, 0), 0.75, green)
	end
end
ORNAMENTS.Lava = function(c) -- roches, coulées sur les flancs, bain de lave sur l'arche
	local rock, lava = rgb(46, 34, 34), rgb(255, 120, 20)
	for _, sx in {-1, 1} do
		local base = c.rearCorner(sx)
		c.add("Rock", V(1.6, 1.3, 1.5), base * CFrame.new(0, 0.5, 0) * CFrame.Angles(rad(12), rad(25 * sx), rad(8)), rock)
		c.add("Rock", V(1.0, 0.9, 1.0), base * CFrame.new(sx * 0.5, 1.3, -0.3) * CFrame.Angles(rad(-20), rad(40), rad(15)), rock)
		c.add("Rock", V(1.5, 1.6, 1.4), c.archTop * CFrame.new(sx * 5.0, 0.6, 0) * CFrame.Angles(rad(10), rad(30 * sx), rad(-12 * sx)), rock)
		c.add("Rock", V(0.8, 1.3, 0.8), c.archTop * CFrame.new(sx * 5.2, 1.7, 0) * CFrame.Angles(rad(8), rad(45), rad(-20 * sx)), rock)
		for i, z in {-3.5, 1.5, 6.5} do
			local long = 0.5 + (i % 2) * 0.35
			c.add("LavaDrip", V(0.14, long, 0.7), CFrame.new(sx * (ARM_X + ARM_W / 2 + 0.05), 1.1 - long / 2, z), lava, {neon = true})
		end
	end
	c.add("LavaPool", V(8.4, 0.25, 1.5), c.archTop * CFrame.new(0, 0.1, 0), lava, {neon = true})
end
ORNAMENTS.Frost = function(c) -- neige sur l'arche et les flancs, glaçons, pics de glace
	local ice, snow = rgb(170, 226, 255), rgb(250, 253, 255)
	local frozen = {material = Enum.Material.Ice}
	c.add("Snow", V(DECK_W + 0.1, 0.45, 2.6), c.archTop * CFrame.new(0, 0.2, 0), snow)
	c.add("Snow", V(5.2, 0.5, 2.0), c.archTop * CFrame.new(-1.2, 0.6, 0), snow)
	for i, h in {0.9, 0.55, 0.7, 0.5, 1.0} do
		c.add("Icicle", V(0.4, h, 0.4), c.A * CFrame.new((i - 3) * 2.2, c.H - h / 2, 1.0) * CFrame.Angles(0, rad(45), 0), ice, frozen)
	end
	for _, sx in {-1, 1} do
		local base = c.rearCorner(sx)
		c.add("IceSpike", V(0.8, 2.4, 0.8), base * CFrame.Angles(rad(10), rad(45), rad(-12 * sx)) * CFrame.new(0, 1.2, 0), ice, frozen)
		c.add("IceSpike", V(0.6, 1.5, 0.6), base * CFrame.new(sx * 0.5, 0, 0.4) * CFrame.Angles(rad(-18), rad(20), rad(-30 * sx)) * CFrame.new(0, 0.75, 0), rgb(220, 244, 255), frozen)
		c.add("Snow", V(ARM_W - 0.6, 0.35, 1.5), CFrame.new(sx * ARM_X, c.tierTop(c.tiers) + 0.3, ARM_FRONT + 1.0), snow)
	end
end
ORNAMENTS.Galaxy = function(c) -- planète et son anneau au-dessus de l'arche, étoiles qui flottent
	local violet, cyan = rgb(170, 100, 255), rgb(120, 220, 255)
	local centre = c.archTop * CFrame.new(0, 2.2, 0)
	c.add("Planet", V(1.5, 1.5, 1.5), centre * CFrame.Angles(rad(20), rad(30), 0), rgb(90, 60, 200))
	c.add("Planet", V(1.5, 1.5, 1.5), centre * CFrame.Angles(rad(20), rad(75), 0), rgb(120, 80, 230))
	local ring = centre * CFrame.Angles(rad(24), 0, rad(14))
	local radius, count = 2.3, 8
	for i = 1, count do
		c.add("Ring", V(2 * radius * math.tan(math.pi / count) * 1.05, 0.16, 0.34), ring * CFrame.Angles(0, i / count * math.pi * 2, 0) * CFrame.new(0, 0, radius), violet, {neon = true})
	end
	for i, p in {V(-4.9, 4.4, -3), V(5.0, 4.0, 1.5), V(-4.5, 2.6, 6.5), V(4.6, 5.0, -5.5)} do
		c.add("Star", V(0.6, 0.6, 0.6), CFrame.new(p) * CFrame.Angles(rad(45), rad(i * 30), rad(45)), cyan, {neon = true})
	end
end
-- Galactic (update Galactic) : planète géante au-dessus de l'arche avec deux anneaux et une lune qui tournent (modèles "Orbit",
-- animés par TreadmillFxClient), deux soleils sur les coins arrière, cristaux sur les flancs, étoiles qui tournent sur elles-mêmes.
ORNAMENTS.Galactic = function(c)
	local cyan, pink, violet, gold = rgb(80, 220, 255), rgb(255, 110, 230), rgb(150, 90, 255), rgb(255, 196, 70)
	local function ball(parent, name, d, cf, color, o)
		local p = piece(parent, name, V(d, d, d), cf, color, o)
		p.Shape = Enum.PartType.Ball
		return p
	end
	-- anneau en segments, rangé dans un modèle Orbit qui tourne autour de son centre (attribut Spin, en degrés par seconde)
	local function orbit(name, center, radius, count, thick, colors, spin, moon)
		local o = Instance.new("Model")
		o.Name = "Orbit"
		o:SetAttribute("Spin", spin)
		piece(o, "OrbitCenter", V(0.2, 0.2, 0.2), center, WHITE, {transparency = 1})
		for i = 1, count do
			piece(o, name, V(2 * radius * math.tan(math.pi / count) * 1.06, thick, thick * 1.6),
				center * CFrame.Angles(0, i / count * math.pi * 2, 0) * CFrame.new(0, 0, radius), colors[(i - 1) % #colors + 1], {neon = true})
		end
		if moon then
			ball(o, "Moon", moon, center * CFrame.new(radius + moon * 0.9, 0, 0), rgb(220, 226, 255))
			ball(o, "MoonGlow", moon * 1.4, center * CFrame.new(radius + moon * 0.9, 0, 0), cyan, {neon = true, transparency = 0.75})
		end
		o.Parent = c.m
		return o
	end
	-- la planète
	local centre = c.archTop * CFrame.new(0, 4.4, 0)
	c.add("PlanetStand", V(3.0, 0.5, 2.2), c.archTop * CFrame.new(0, 0.25, 0), c.T, {neon = true})
	c.add("PlanetPole", V(0.7, 1.9, 0.7), c.archTop * CFrame.new(0, 1.4, 0), c.F)
	ball(c.m, "Planet", 4.6, centre, rgb(74, 52, 200))
	ball(c.m, "PlanetCap", 2.9, centre * CFrame.new(0.7, 1.0, 0.8), rgb(110, 80, 235))
	ball(c.m, "PlanetSpot", 1.6, centre * CFrame.new(-1.2, -0.6, 1.5), rgb(255, 110, 230), {neon = true})
	ball(c.m, "PlanetGlow", 5.8, centre, violet, {neon = true, transparency = 0.82})
	orbit("Ring", centre * CFrame.Angles(rad(22), 0, rad(16)), 4.7, 20, 0.28, {cyan, cyan:Lerp(WHITE, 0.35), pink}, 32, 1.1)
	orbit("Ring", centre * CFrame.Angles(rad(-28), 0, rad(-10)), 3.6, 16, 0.18, {pink, violet}, -55, nil)
	-- deux soleils sur les coins arrière, chacun avec son petit anneau
	for _, sx in {-1, 1} do
		local base = c.rearCorner(sx)
		c.add("SunPillar", V(1.0, 1.6, 1.0), base * CFrame.new(0, 0.8, 0), c.F)
		c.add("SunCup", V(1.5, 0.35, 1.5), base * CFrame.new(0, 1.7, 0), c.T, {neon = true})
		local sun = base * CFrame.new(0, 2.8, 0)
		ball(c.m, "Sun", 1.5, sun, gold, {neon = true})
		ball(c.m, "SunGlow", 2.2, sun, rgb(255, 150, 60), {neon = true, transparency = 0.7})
		orbit("SunRing", sun * CFrame.Angles(rad(70), 0, rad(20 * sx)), 1.55, 10, 0.12, {gold, rgb(255, 240, 180)}, 90 * sx, nil)
	end
	-- cristaux sur le haut des flancs, à l'avant
	for _, sx in {-1, 1} do
		local top = CFrame.new(sx * ARM_X, c.tierTop(c.tiers), ARM_FRONT + 1.4)
		c.add("Crystal", V(0.7, 2.2, 0.7), top * CFrame.Angles(rad(8), rad(45), rad(-14 * sx)) * CFrame.new(0, 1.0, 0), cyan, {neon = true})
		c.add("Crystal", V(0.5, 1.4, 0.5), top * CFrame.new(sx * 0.6, 0, 0.5) * CFrame.Angles(rad(-15), rad(20), rad(-35 * sx)) * CFrame.new(0, 0.6, 0), pink, {neon = true})
		c.add("Crystal", V(0.45, 1.1, 0.45), top * CFrame.new(-sx * 0.5, 0, 0.6) * CFrame.Angles(rad(20), rad(60), rad(25 * sx)) * CFrame.new(0, 0.5, 0), violet, {neon = true})
	end
	-- étoiles qui flottent et tournent sur elles-mêmes (attribut SpinSelf)
	for i, p in {V(-5.4, 5.6, -2.5), V(5.5, 6.4, 0.5), V(-5.0, 3.4, 5.5), V(5.1, 4.2, -5.6), V(-4.2, 7.4, -6.2), V(4.4, 3.0, 6.8)} do
		local s = c.add("Star", V(0.55, 0.55, 0.55), CFrame.new(p) * CFrame.Angles(rad(45), rad(i * 30), rad(45)), i % 2 == 0 and pink or cyan, {neon = true})
		s:SetAttribute("SpinSelf", 60 + i * 15)
	end
end
ORNAMENTS.Rainbow = function(c) -- arc-en-ciel sur l'arche (et chaque gradin a sa couleur), nuages à l'arrière
	local colors = {rgb(255, 70, 70), rgb(255, 150, 40), rgb(255, 224, 50), rgb(90, 235, 90), rgb(70, 170, 255), rgb(170, 100, 255)}
	local width = (DECK_W - 0.6) / #colors
	for i, color in colors do
		local h = 0.5 + (2.5 - math.abs(i - 3.5)) * 0.3 -- plus haut au milieu
		c.add("RainbowBar", V(width, h, 2.3), c.archTop * CFrame.new((i - 3.5) * width, h / 2, 0), color, {neon = true})
	end
	for _, sx in {-1, 1} do
		local base = c.rearCorner(sx)
		c.add("Cloud", V(1.9, 1.0, 1.5), base * CFrame.new(0, 0.5, 0), WHITE)
		c.add("Cloud", V(1.2, 0.9, 1.2), base * CFrame.new(sx * 0.3, 1.2, 0.1), rgb(240, 246, 255))
	end
end
ORNAMENTS.Void = function(c) -- cornes sur l'arche, cœur lumineux, pics et éclats qui flottent
	local dark, pink = rgb(30, 16, 48), rgb(255, 70, 210)
	for _, sx in {-1, 1} do
		local cf = c.archTop * CFrame.new(sx * 4.6, 0, 0) * CFrame.Angles(0, 0, rad(-28 * sx))
		c.add("Horn", V(1.3, 1.9, 1.3), cf * CFrame.new(0, 0.9, 0), dark)
		cf = cf * CFrame.new(0, 1.8, 0) * CFrame.Angles(0, 0, rad(26 * sx))
		c.add("Horn", V(1.0, 1.7, 1.0), cf * CFrame.new(0, 0.8, 0), rgb(48, 24, 76))
		cf = cf * CFrame.new(0, 1.6, 0) * CFrame.Angles(0, 0, rad(26 * sx))
		c.add("HornTip", V(0.6, 1.3, 0.6), cf * CFrame.new(0, 0.6, 0), pink, {neon = true})
		local spike = c.rearCorner(sx) * CFrame.Angles(rad(14), rad(45), rad(-14 * sx))
		c.add("Spike", V(0.9, 2.6, 0.9), spike * CFrame.new(0, 1.3, 0), dark)
		c.add("SpikeTip", V(0.5, 0.8, 0.5), spike * CFrame.new(0, 2.9, 0), pink, {neon = true})
	end
	local eye = c.archTop * CFrame.new(0, 1.7, 0)
	c.add("Core", V(1.2, 1.2, 1.2), eye * CFrame.Angles(rad(45), 0, rad(45)), pink, {neon = true})
	c.add("CoreRing", V(2.6, 0.3, 0.5), eye, dark)
	c.add("CoreRing", V(0.3, 2.6, 0.5), eye, dark)
	for i, p in {V(-5.6, 4.6, 2), V(5.7, 5.2, -2), V(-5.3, 6.2, -5), V(5.2, 3.6, 6.5)} do
		c.add("Shard", V(0.45, 1.5, 0.45), CFrame.new(p) * CFrame.Angles(rad(20 * i), rad(40), rad(15 * i)), i % 2 == 0 and pink or rgb(120, 50, 200), {neon = true})
	end
end

---------------------------------------------------------------- le tapis d'un palier
local function treadmill(skin)
	local m = Instance.new("Model")
	m.Name = skin.Name
	local F, T, G = skin.Frame, skin.Trim, skin.Glow
	local function frame(name, size, cf, shadow) return piece(m, name, size, cf, F, {shadow = shadow}) end
	local function trim(name, size, cf) return piece(m, name, size, cf, T, {neon = skin.NeonTrim == true}) end
	local function glow(name, size, cf, color) return piece(m, name, size, cf, color or G, {neon = true}) end

	local deck = frame("Deck", V(DECK_W, 0.3, DECK_L), CFrame.new(0, 0.15, 0), true)
	m.PrimaryPart = deck
	-- la bande : sombre, à peine plus haute que le sol (on monte dessus en marchant), deux couloirs clairs dans la longueur
	local belt = piece(m, "Belt", V(BELT_W, 0.3, BELT_L), CFrame.new(0, 0.36, BELT_Z), INK, {solid = true})
	local tex = Instance.new("Texture")
	tex.Name = "Scroll"
	tex.Texture = STUDS
	tex.Face = Enum.NormalId.Top
	tex.StudsPerTileU, tex.StudsPerTileV = 3.2, 3.2
	tex.Transparency = 0.55
	tex.Color3 = rgb(90, 92, 104)
	tex.Parent = belt
	for _, i in {-1, 1} do
		piece(m, "Stripe", V(BELT_W / 5, 0.04, BELT_L), CFrame.new(i * BELT_W / 5, 0.52, BELT_Z), skin.Galactic and rgb(60, 40, 140) or rgb(58, 60, 70))
	end
	if skin.Galactic then belt.Color = rgb(16, 12, 40) end
	local arrows = Instance.new("Texture")
	arrows.Name = "Arrows"
	arrows.Texture = ARROWS
	arrows.Face = Enum.NormalId.Top
	arrows.StudsPerTileU, arrows.StudsPerTileV = BELT_W, ARROW_TILE
	arrows.Color3 = G
	arrows.Transparency = 0.3
	arrows.Parent = belt
	trim("RearLip", V(BELT_W, 0.45, 0.5), CFrame.new(0, 0.3, BELT_Z + BELT_L / 2 + 0.25))

	-- flancs en gradins : le plus bas fait toute la longueur, les suivants sont plus courts et montent vers l'arche.
	-- Chaque gradin porte un grand néon en creux, cerné d'un vrai contour (deux bords longs et un bord arrière).
	local tiers = TIERS[skin.Name] or 1
	local total = ARM_REAR - ARM_FRONT
	local function tierRear(k) return ARM_FRONT + total * TIER_LENGTH[k] end
	local function tierTop(k) return 0.3 + k * TIER_H end
	local tierGlow = skin.Name == "Rainbow" and {rgb(255, 70, 70), rgb(255, 214, 50), rgb(70, 170, 255)}
		or skin.Name == "Galactic" and {rgb(150, 90, 255), rgb(255, 110, 230), rgb(80, 220, 255)} or {}
	for _, sx in {-1, 1} do
		for k = 1, tiers do
			local width = ARM_W - (k - 1) * 0.2
			local rear, top = tierRear(k), tierTop(k)
			frame("Arm", V(width, TIER_H, rear - ARM_FRONT), CFrame.new(sx * ARM_X, top - TIER_H / 2, (ARM_FRONT + rear) / 2), k == 1)
			local from = k < tiers and tierRear(k + 1) or ARM_FRONT -- seule la partie visible du gradin est habillée
			local mid, len = (from + rear) / 2, rear - from
			glow("ArmLight", V(width - 0.8, 0.2, len - 0.4), CFrame.new(sx * ARM_X, top + 0.1, mid - 0.2), tierGlow[k])
			for _, edge in {-1, 1} do
				frame("ArmRim", V(0.4, 0.36, len), CFrame.new(sx * ARM_X + edge * (width / 2 - 0.2), top + 0.18, mid))
			end
			frame("ArmRim", V(width - 0.8, 0.36, 0.4), CFrame.new(sx * ARM_X, top + 0.18, rear - 0.2))
		end
		trim("Skirt", V(0.5, 0.55, DECK_L - 1.2), CFrame.new(sx * 6.1, 0.28, 0.3))
	end

	-- arche à l'avant : un capot droit, puis deux jambes et une poutre penchées, l'écran dans l'ouverture
	local H = 3.6 + 0.4 * (tiers - 2)
	frame("Hood", V(DECK_W, HOOD_H, 2.6), CFrame.new(0, HOOD_H / 2, ARCH_Z), true)
	local A = CFrame.new(0, HOOD_H, ARCH_Z) * CFrame.Angles(rad(-TILT), 0, 0)
	for _, sx in {-1, 1} do
		frame("ArchLeg", V(2.2, H, 2.0), A * CFrame.new(sx * 5.15, H / 2, 0), true)
		glow("ArchLegLight", V(0.4, H - 0.5, 1.2), A * CFrame.new(sx * 3.9, H / 2, 0.2))
		glow("HoodLight", V(1.5, 0.4, 1.0), CFrame.new(sx * 3.2, HOOD_H + 0.1, ARCH_Z + 0.95))
	end
	frame("ArchBeam", V(DECK_W - 0.2, 1.5, 2.2), A * CFrame.new(0, H + 0.75, 0), true)
	glow("ArchBeamLight", V(8.2, 0.4, 0.2), A * CFrame.new(0, H + 0.75, 1.12))
	-- le panneau : une plaque à studs dans l'ouverture de l'arche, cernée d'un contour (pas d'écran : le niveau se lit sur le grand panneau d'à côté)
	local dark = F.R * 0.3 + F.G * 0.59 + F.B * 0.11 < 0.4
	local panel = piece(m, "Panel", V(7.6, H - 0.5, 0.5), A * CFrame.new(0, H / 2, -0.5), dark and F:Lerp(WHITE, 0.4) or F:Lerp(INK, 0.45))
	if skin.Galactic then -- panneau Galactic : une nébuleuse qui tourbillonne sur fond de nuit
		panel.Color = rgb(34, 22, 90)
		for i, spec in {{"Vortex", rgb(170, 110, 255), 0.15}, {"Glow", rgb(80, 220, 255), 0.45}} do
			local d = Instance.new("Decal")
			d.Name = "Nebula" .. i
			d.Texture = Config.FxTextures[spec[1] ]
			d.Color3, d.Transparency = spec[2], spec[3]
			d.Face = Enum.NormalId.Back
			d.ZIndex = i
			d.Parent = panel
		end
	end
	for _, sy in {0.25, H - 0.25} do trim("PanelRim", V(7.6, 0.4, 0.5), A * CFrame.new(0, sy, -0.15)) end
	for _, sx in {-1, 1} do trim("PanelRim", V(0.4, H - 0.9, 0.5), A * CFrame.new(sx * 3.6, H / 2, -0.15)) end
	-- rampes où l'on s'appuie : une grosse barre qui part de chaque jambe de l'arche vers l'arrière, à hauteur de main, tenue par
	-- une équerre en triangle ; un néon en creux dessus, un bloc au bout. Rien ne redescend au sol.
	local railY = HOOD_H + H * 0.72
	local railFront, railRear = ARCH_Z + 0.6, -0.4
	for _, sx in {-1, 1} do
		local x = sx * ARM_X
		local mid, len = (railFront + railRear) / 2, railRear - railFront
		frame("Rail", V(1.2, 0.8, len), CFrame.new(x, railY, mid), true)
		glow("RailLight", V(0.6, 0.16, len - 1.0), CFrame.new(x, railY + 0.36, mid))
		trim("RailEnd", V(1.5, 1.2, 1.1), CFrame.new(x, railY, railRear + 0.4))
		piece(m, "RailBrace", V(1.0, 2.4, 3.4), CFrame.new(x, railY - 0.4 - 1.2, railFront + 1.7) * CFrame.Angles(math.pi, 0, 0), F, {wedge = true})
	end

	local ornaments = ORNAMENTS[skin.Name]
	if ornaments then
		ornaments({
			add = function(name, size, cf, color, o) return piece(m, name, size, cf, color, o) end,
			m = m, A = A, H = H, archTop = A * CFrame.new(0, H + 1.5, 0), tiers = tiers, tierTop = tierTop, F = F, T = T, G = G,
			rearCorner = function(sx) return CFrame.new(sx * ARM_X, tierTop(1), ARM_REAR - 1.0) end,
		})
	end
	for _, spec in skin.Fx or {} do skinFx(spec, deck, belt) end
	if skin.Fx then
		local light = Instance.new("PointLight")
		light.Name = "SkinFx"
		light.Color, light.Range, light.Brightness, light.Shadows = G, 18, 1.4, false
		light.Parent = belt
	end
	squeeze(m)
	arrows.StudsPerTileU = belt.Size.X -- un seul chevron dans la largeur de la bande (resserrée)
	m:SetAttribute("Skin", skin.Name)
	return m
end

---------------------------------------------------------------- le panneau d'améliorations (SpeedServer le repeint selon le palier : attribut Role)
local function board()
	local m = Instance.new("Model")
	m.Name = "TreadmillBoard"
	local function part(role, name, size, cf, color, o)
		local p = piece(m, name, size, cf, color, o)
		p.CanCollide = not (o and o.ghost)
		p.CastShadow = true
		p:SetAttribute("Role", role)
		return p
	end
	local GREY, DARKGREY = rgb(128, 132, 142), rgb(74, 77, 86)
	m.PrimaryPart = part("Trim", "Base", V(10.4, 0.6, 2.6), CFrame.new(0, 0.3, 0), DARKGREY)
	for _, sx in {-1, 1} do part("Trim", "Leg", V(0.9, 3, 0.9), CFrame.new(sx * 4, 2.1, 0), DARKGREY) end
	part("Frame", "Panel", V(10.4, 7.4, 0.9), CFrame.new(0, 7.1, 0), GREY)
	part("Dark", "Screen", V(9.4, 6.4, 0.14), CFrame.new(0, 7.1, 0.5), INK, {ghost = true}).CanQuery = true
	part("Glow", "TopLight", V(10.4, 0.35, 0.35), CFrame.new(0, 11, 0), rgb(235, 240, 255), {neon = true, ghost = true})
	part("Frame", "Crest", V(4.2, 1.1, 1.1), CFrame.new(0, 11.6, 0), GREY)
	return m
end

-- only = "Galactic" : construit seulement ce tapis-là dans ServerStorage.TreadmillModels, sans toucher aux autres ni aux bases
return function(keepPlaces, only)
	local report = {}
	if only then
		local folder = ServerStorage:WaitForChild("TreadmillModels")
		for _, skin in Config.Skins do
			if skin.Name == only then
				local old = folder:FindFirstChild(skin.Name)
				if old then old:Destroy() end
				local t = treadmill(skin)
				t.Parent = folder
				return skin.Name .. " built (" .. #t:GetDescendants() .. " objects)"
			end
		end
		return "skin not found: " .. tostring(only)
	end
	-- 1. un modèle par palier
	local old = ServerStorage:FindFirstChild("TreadmillModels")
	if old then old:Destroy() end
	local folder = Instance.new("Folder")
	folder.Name = "TreadmillModels"
	local counts = {}
	for _, skin in Config.Skins do
		local t = treadmill(skin)
		t.Parent = folder
		table.insert(counts, skin.Name .. " " .. #t:GetChildren())
	end
	folder.Parent = ServerStorage
	table.insert(report, "models (parts): " .. table.concat(counts, ", "))

	-- 2. dans chaque base : le repère, le tapis de départ, le panneau
	local safe = workspace:FindFirstChild("safe zone")
	for _, base in workspace:WaitForChild("all base"):GetChildren() do
		local garden, spawnPart = base:FindFirstChild("animaux"), base:FindFirstChild("Spawn")
		if not (garden and spawnPart) then continue end
		local spot = base:FindFirstChild("TreadmillSpot")
		local oldTreadmill = base:FindFirstChild("Treadmill")
		local oldDeck = oldTreadmill and oldTreadmill:FindFirstChild("Deck")
		local ground -- repère au sol, sous le milieu du tapis, tourné comme lui
		if keepPlaces and spot then
			ground = spot.CFrame * CFrame.new(0, -0.15, 0)
		elseif keepPlaces and oldDeck then
			ground = oldDeck.CFrame * CFrame.new(0, -oldDeck.Size.Y / 2, 0)
		else
			-- devant le jardin, à droite du point d'apparition (quand on regarde le jardin) : on court dos au jardin
			local toGarden = (V(garden.Position.X, 0, garden.Position.Z) - V(spawnPart.Position.X, 0, spawnPart.Position.Z)).Unit
			local left = V(toGarden.Z, 0, -toGarden.X)
			local at = V(spawnPart.Position.X, spawnPart.Position.Y, spawnPart.Position.Z) - toGarden * 6 - left * 19.5
			ground = CFrame.lookAt(at, at - toGarden)
		end
		if safe then ground = ground + V(0, safe.Position.Y + safe.Size.Y / 2 - ground.Y, 0) end -- posé à même le sol
		if oldTreadmill then oldTreadmill:Destroy() end
		if not spot then
			spot = Instance.new("Part")
			spot.Name = "TreadmillSpot"
			spot.Size = V(1, 0.2, 1)
			spot.Transparency = 1
			spot.Anchored = true
			spot.CanCollide, spot.CanQuery, spot.CanTouch = false, false, false
			spot.Parent = base
		end
		spot.CFrame = ground * CFrame.new(0, 0.15, 0)
		local t = folder:FindFirstChild(Config.Skins[1].Name):Clone()
		t.Name = "Treadmill"
		t:PivotTo(spot.CFrame)
		t.Parent = base
		local b = base:FindFirstChild("TreadmillBoard") or board()
		b:PivotTo(ground * BOARD_PLACE)
		b.Parent = base
		table.insert(report, base.Name .. " ok")
	end
	return table.concat(report, "\n")
end
