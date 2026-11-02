-- Outil d'édition (pas utilisé en jeu) : construit les tapis de course.
--   ServerStorage.TreadmillModels : un modèle de tapis par palier (SpeedConfig.Skins : Stone, Bronze, Gold...), déjà peint,
--                                   avec ses effets. SpeedServer en pose une copie dans la base du joueur selon son niveau.
--   Dans chaque base (Workspace["all base"]) : le repère invisible TreadmillSpot (là où le tapis est posé), le tapis de départ
--                                   pour le voir dans Studio, et le panneau d'améliorations TreadmillBoard.
-- Tous les tapis gardent la même base : la bande (seule pièce solide), les deux flancs en gradins coiffés de néons, et l'arche
-- inclinée à l'avant qui porte l'écran. Le nombre de gradins et les ornements changent à chaque palier (table ORNAMENTS).
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
local TIER_LENGTH = {1, 0.64, 0.4, 0.2}     -- part de la longueur du flanc occupée par chaque gradin, du bas vers le haut
local ARCH_Z, HOOD_H, TILT = -7.9, 1.9, 13  -- l'arche penche de TILT degrés vers l'avant
local TIERS = {Stone = 2, Bronze = 2, Gold = 3, Diamond = 3, Flash = 3, Emerald = 3, Lava = 4, Frost = 4, Galaxy = 4, Rainbow = 4, Void = 4}
-- place du panneau par rapport au tapis : à gauche de l'arche, tourné de 45° vers le coureur (réglé par le créateur sur la base 1)
local BOARD_PLACE = CFrame.new(-13.2, 0.3, -4.1) * CFrame.Angles(0, rad(45), 0)

-- Une pièce de tapis. On passe à travers (sauf solid = true, la bande) ; seules les grosses pièces projettent une ombre.
local function piece(model, name, size, cf, color, o)
	o = o or {}
	local p = Instance.new("Part")
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
local function crystals(c, at, s, color)
	local glass = {material = Enum.Material.Glass, transparency = 0.15}
	local pale = color:Lerp(WHITE, 0.5)
	c.add("Crystal", V(0.7, 2.4, 0.7) * s, at * CFrame.Angles(rad(8), rad(45), rad(-10)) * CFrame.new(0, 1.2 * s, 0), color, {neon = true})
	c.add("Crystal", V(0.55, 1.7, 0.55) * s, at * CFrame.new(0.5 * s, 0, 0.2 * s) * CFrame.Angles(rad(-14), rad(20), rad(-32)) * CFrame.new(0, 0.85 * s, 0), pale, glass)
	c.add("Crystal", V(0.5, 1.3, 0.5) * s, at * CFrame.new(-0.45 * s, 0, -0.2 * s) * CFrame.Angles(rad(12), rad(60), rad(30)) * CFrame.new(0, 0.65 * s, 0), pale, glass)
end
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
ORNAMENTS.Diamond = function(c) -- bouquets de cristaux
	local ice = rgb(150, 230, 255)
	for _, sx in {-1, 1} do
		crystals(c, c.rearCorner(sx) * CFrame.Angles(0, sx > 0 and 0 or math.pi, 0), 1, ice)
		crystals(c, c.archTop * CFrame.new(sx * 4.8, 0, 0) * CFrame.Angles(0, sx > 0 and 0 or math.pi, 0), 0.9, ice)
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
		piece(m, "Stripe", V(BELT_W / 5, 0.04, BELT_L), CFrame.new(i * BELT_W / 5, 0.52, BELT_Z), rgb(58, 60, 70))
	end
	trim("RearLip", V(BELT_W, 0.45, 0.5), CFrame.new(0, 0.3, BELT_Z + BELT_L / 2 + 0.25))

	-- flancs en gradins : le plus bas fait toute la longueur, les suivants sont de plus en plus courts et montent vers l'arche.
	-- Chaque gradin porte un néon, un peu plus étroit que lui : son bord sombre fait le contour.
	local tiers = TIERS[skin.Name] or 2
	local total = ARM_REAR - ARM_FRONT
	local function tierRear(k) return ARM_FRONT + total * TIER_LENGTH[k] end
	local function tierTop(k) return 0.3 + k * TIER_H end
	local tierGlow = skin.Name == "Rainbow" and {rgb(255, 70, 70), rgb(255, 214, 50), rgb(90, 235, 90), rgb(70, 170, 255)} or {}
	for _, sx in {-1, 1} do
		for k = 1, tiers do
			local width = ARM_W - (k - 1) * 0.3
			local rear = tierRear(k)
			frame("Arm", V(width, TIER_H, rear - ARM_FRONT), CFrame.new(sx * ARM_X, tierTop(k) - TIER_H / 2, (ARM_FRONT + rear) / 2), k == 1)
			local from = k < tiers and tierRear(k + 1) or ARM_FRONT + 0.2 -- le néon ne couvre que la partie visible du gradin
			glow("ArmLight", V(width - 0.7, 0.24, rear - from - 0.6), CFrame.new(sx * ARM_X, tierTop(k) + 0.02, (from + rear) / 2), tierGlow[k])
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
	frame("Console", V(8.3, H, 0.5), A * CFrame.new(0, H / 2, -0.6))
	local screen = piece(m, "Screen", V(7.2, H - 0.8, 0.12), A * CFrame.new(0, H / 2, -0.3), INK)
	local gui = Instance.new("SurfaceGui")
	gui.Name = "Display"
	gui.Face = Enum.NormalId.Back
	gui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	gui.PixelsPerStud = 40
	gui.LightInfluence = 0
	local function label(name, text, pos, size, color)
		local l = Instance.new("TextLabel")
		l.Name = name
		l.BackgroundTransparency = 1
		l.Position, l.Size = pos, size
		l.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
		l.Text, l.TextScaled, l.TextColor3 = text, true, color
		local s = Instance.new("UIStroke")
		s.Thickness = 3
		s.Parent = l
		l.Parent = gui
	end
	label("Gain", "+1", UDim2.fromScale(0.04, 0.04), UDim2.fromScale(0.92, 0.58), rgb(120, 255, 120))
	label("Level", "LEVEL 0", UDim2.fromScale(0.04, 0.62), UDim2.fromScale(0.92, 0.32), WHITE)
	gui.Parent = screen

	local ornaments = ORNAMENTS[skin.Name]
	if ornaments then
		ornaments({
			add = function(name, size, cf, color, o) return piece(m, name, size, cf, color, o) end,
			A = A, H = H, archTop = A * CFrame.new(0, H + 1.5, 0), tiers = tiers, tierTop = tierTop, F = F, T = T, G = G,
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

return function(keepPlaces)
	local report = {}
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
