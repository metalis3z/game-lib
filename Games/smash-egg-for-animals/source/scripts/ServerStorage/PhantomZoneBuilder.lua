-- Outil d'édition (pas utilisé en jeu) : construit la 13e zone, PHANTOM (rareté Phantom), après la zone Galaxy, tout au fond.
-- Même recette que ServerStorage.GalaxyZoneBuilder : tranchée, plateaux de 60 studs de chaque côté, décors en blocs à studs.
--   require(game.ServerStorage.PhantomZoneBuilder)()  -> rapport. Peut être relancé : il refait la zone, ses plateaux et ses décors.
-- La première fois, il pousse aussi le fond de la carte (plateau du fond, murs du couloir, forêt de l'intro) derrière la zone.
-- Thème : cimetière fantôme de nuit. Pierre noire et ardoise, bois mort, os ivoire ; seuls accents lumineux : cyan fantôme et violet.
-- Longueur : comme les autres zones (ZoneStretcher, +20 % de la première par zone) : 150,73 x 3,4 = 512,5 studs.
local V, C, A, rad = Vector3.new, CFrame.new, CFrame.Angles, math.rad
local rgb = Color3.fromRGB
local ZONE_W, GROW, GAP = 150.73, 0.2, 27.9
local INDEX = 13
local WIDTH = ZONE_W * (1 + GROW * (INDEX - 1)) -- 512,5 studs
local ZONE_NAME = "PHANTOM phantom egg zone"
local PREV_NAME = "GALACTIC galaxy egg zone"
local SIDE, LEDGE_UP = 60, 45.2
local OLD_NORTH, OLD_SOUTH = -84.3, -251.3
local FLOOR = rgb(34, 30, 44)                   -- sol : ardoise presque noire
local rng = Random.new(20261024)

---------------------------------------------------------------- briques
local function block(model, size, cf, color, o)
	o = o or {}
	local p = Instance.new(o.wedge and "WedgePart" or "Part")
	p.Name = o.name or "Stud"
	p.Size, p.CFrame, p.Color = size, cf, color
	p.Anchored = true
	p.CanCollide, p.CanTouch, p.CanQuery = false, false, false
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	p.Material = o.neon and Enum.Material.Neon or (o.glass and Enum.Material.Glass or (o.mat or Enum.Material.Plastic))
	if p.Material == Enum.Material.Plastic and not o.smooth then pcall(function() p.MaterialVariant = "Studs" end) end
	p.Transparency = o.transparency or 0
	p.CastShadow = false
	p.Parent = model
	return p
end
local function prop(name)
	local m = Instance.new("Model")
	m.Name = name
	m.WorldPivot = C()
	return m
end
local function place(m, parent, cf)
	m.WorldPivot = C()
	m.Parent = parent
	m:PivotTo(cf)
	return m
end
local function fitted(m, parent, cf, maxFootprint)
	m.Parent = parent
	if maxFootprint then
		local size = m:GetExtentsSize()
		local footprint = math.max(size.X, size.Z)
		if footprint > maxFootprint then m:ScaleTo(m:GetScale() * maxFootprint / footprint) end
	end
	m:PivotTo(cf)
end
local function shade(color, k) return color:Lerp(k < 0 and Color3.new(0, 0, 0) or Color3.new(1, 1, 1), math.abs(k)) end
local function pick(list) return list[rng:NextInteger(1, #list)] end
local function light(part, color, range, brightness)
	local l = Instance.new("PointLight")
	l.Color, l.Range, l.Brightness, l.Shadows = color, range, brightness, false
	l.Parent = part
end
local function nseq(points)
	local keys = {}
	for _, p in points do table.insert(keys, NumberSequenceKeypoint.new(p[1], p[2])) end
	return NumberSequence.new(keys)
end

---------------------------------------------------------------- couleurs du cimetière fantôme
local STONE, STONE2, STONE3 = rgb(40, 38, 50), rgb(28, 26, 36), rgb(58, 56, 72)
local DEADWOOD, DEADWOOD2 = rgb(30, 25, 34), rgb(46, 39, 52)
local IRON, VOID = rgb(36, 38, 48), rgb(12, 10, 18)
local BONE, BONE2 = rgb(226, 220, 198), rgb(186, 178, 156)
local GHOST, GHOSTV, PALE = rgb(90, 255, 225), rgb(170, 110, 255), rgb(205, 240, 255)
local MOON, MOON2 = rgb(220, 228, 240), rgb(178, 188, 208)

---------------------------------------------------------------- décors
-- lanterne d'âme : petite cage de fer et flamme cyan (accrochée ou posée)
local function soulLamp(m, cf, s, withLight)
	block(m, V(1.2, 0.3, 1.2) * s, cf * C(0, 0.95 * s, 0), IRON)
	block(m, V(1.2, 0.3, 1.2) * s, cf * C(0, -0.95 * s, 0), IRON)
	for _, sx in {-1, 1} do for _, sz in {-1, 1} do
		block(m, V(0.18, 1.6, 0.18) * s, cf * C(sx * 0.48 * s, 0, sz * 0.48 * s), IRON)
	end end
	local flame = block(m, V(0.5, 0.9, 0.5) * s, cf * A(0, rad(45), 0), GHOST, {neon = true})
	if withLight then light(flame, GHOST, 14 * s, 1.4) end
	return flame
end
-- arbre mort : tronc noir tordu, branches crochues, lanternes d'âme pendues
local function deadTree(height)
	local m = prop("DeadTree")
	local w = height * 0.11
	local cf = C(0, 0, 0)
	block(m, V(w * 2.2, height * 0.08, w * 2.2), C(0, height * 0.04, 0) * A(0, rad(45), 0), DEADWOOD) -- racines
	local tops = {}
	local segs = 5
	for i = 1, segs do
		local h = height * 0.62 / segs
		local ww = w * (1.15 - i * 0.12)
		cf = cf * C(0, h / 2, 0) * A(rad(rng:NextNumber(-9, 9)), rad(rng:NextInteger(0, 40)), rad(rng:NextNumber(-9, 9))) * C(0, h / 2, 0)
		block(m, V(ww, h + 0.3, ww), cf * C(0, -h / 2, 0), i % 2 == 0 and DEADWOOD2 or DEADWOOD)
	end
	table.insert(tops, cf)
	for b = 1, 4 do -- branches
		local at = C(0, height * (0.38 + b * 0.09), 0) * A(0, rad(b * 97 + rng:NextInteger(0, 30)), 0)
		local bcf = at * A(0, 0, rad(-48 - rng:NextNumber(0, 18)))
		local len = height * rng:NextNumber(0.22, 0.32)
		block(m, V(w * 0.55, len, w * 0.55), bcf * C(0, len / 2, 0), DEADWOOD)
		local tip = bcf * C(0, len, 0) * A(0, 0, rad(38))
		block(m, V(w * 0.35, len * 0.55, w * 0.35), tip * C(0, len * 0.27, 0), DEADWOOD2)
		if b % 2 == 1 then -- une lanterne pendue au bout
			local hang = (tip * C(0, len * 0.4, 0)).Position
			block(m, V(0.15, 2.2, 0.15), C(hang - V(0, 1.1, 0)), IRON)
			soulLamp(m, C(hang - V(0, 3.1, 0)), 1, b == 1)
		end
	end
	return m
end
-- crypte : socle, murs, toit en pente, porte noire au liseré cyan, deux colonnes, cristal d'âme au sommet
local function crypt(size)
	local m = prop("Crypt")
	local s = size / 14
	block(m, V(15, 1.2, 13) * s, C(0, 0.6 * s, 0), STONE2)
	block(m, V(13, 1.0, 11) * s, C(0, 1.7 * s, 0), STONE)
	block(m, V(11, 8, 9) * s, C(0, 6.2 * s, -0.5 * s), STONE)
	for _, sx in {-1, 1} do
		block(m, V(7.4, 1.2, 10.4) * s, C(sx * 2.9 * s, 11.5 * s, -0.5 * s) * A(0, 0, rad(-sx * 28)), STONE3)
		block(m, V(1.5, 8.6, 1.5) * s, C(sx * 4.3 * s, 6.5 * s, 4.4 * s), STONE3)
		block(m, V(2.1, 0.8, 2.1) * s, C(sx * 4.3 * s, 11.0 * s, 4.4 * s), STONE2)
		block(m, V(2.1, 0.8, 2.1) * s, C(sx * 4.3 * s, 2.6 * s, 4.4 * s), STONE2)
	end
	block(m, V(2.4, 1.6, 10.2) * s, C(0, 13.3 * s, -0.5 * s), STONE2)
	block(m, V(4.4, 6.2, 0.4) * s, C(0, 5.3 * s, 4.05 * s), VOID, {smooth = true})
	block(m, V(0.3, 6.2, 0.42) * s, C(0, 5.3 * s, 4.07 * s), GHOST, {neon = true})
	block(m, V(5.2, 0.5, 0.5) * s, C(0, 8.6 * s, 4.1 * s), GHOST, {neon = true})
	block(m, V(1.6, 1.4, 0.6) * s, C(0, 9.8 * s, 4.1 * s), BONE) -- crâne au-dessus de la porte
	for _, sx in {-1, 1} do block(m, V(0.4, 0.35, 0.2) * s, C(sx * 0.35 * s, 9.95 * s, 4.42 * s), GHOST, {neon = true}) end
	local gem = block(m, V(1.6, 2.6, 1.6) * s, C(0, 15.6 * s, -0.5 * s) * A(0, rad(45), 0), GHOSTV, {neon = true})
	block(m, V(1.0, 1.4, 1.0) * s, C(0, 17.4 * s, -0.5 * s) * A(0, rad(45), 0), shade(GHOSTV, 0.4), {neon = true})
	light(gem, GHOSTV, 24 * s, 1.4)
	return m
end
-- obélisque : socle à gradins, colonne qui s'affine, runes cyan, cristal qui flotte au sommet
local function obelisk(height)
	local m = prop("Obelisk")
	block(m, V(7, 1.4, 7), C(0, 0.7, 0), STONE2)
	block(m, V(5.4, 1.4, 5.4), C(0, 2.1, 0) * A(0, rad(45), 0), STONE)
	local n = math.floor(height / 3)
	for i = 0, n - 1 do
		local w = 3.6 - i * (1.8 / n)
		block(m, V(w, 3.05, w), C(0, 4.3 + i * 3, 0), i % 2 == 0 and STONE or STONE3)
		if i % 2 == 1 then
			for k = 0, 3 do block(m, V(w * 0.5, 0.35, 0.2), C(0, 4.3 + i * 3, 0) * A(0, rad(k * 90), 0) * C(0, 0, w / 2 + 0.05), GHOST, {neon = true}) end
		end
	end
	local top = 2.8 + n * 3
	block(m, V(1.4, 1.4, 1.4), C(0, top + 0.7, 0) * A(rad(45), 0, rad(45)), STONE3)
	local gem = block(m, V(1.5, 2.6, 1.5), C(0, top + 4, 0) * A(0, rad(45), 0), GHOST, {neon = true})
	light(gem, GHOST, 26, 1.6)
	return m
end
-- faux géante plantée dans le sol, de biais
local function giantScythe(height)
	local m = prop("GiantScythe")
	block(m, V(4, 0.8, 4), C(0, 0.4, 0) * A(0, rad(30), 0), STONE2)
	local base = C(0, 0.6, 0) * A(rad(14), 0, rad(-10))
	block(m, V(1.1, height, 1.1), base * C(0, height / 2, 0), DEADWOOD)
	for _, k in {0.25, 0.7, 0.92} do block(m, V(1.4, 0.6, 1.4), base * C(0, height * k, 0), rgb(92, 56, 148)) end
	local p = base * C(-0.4, height, 0)
	for i = 0, 4 do
		local len, w = height * 0.11, height * (0.1 - i * 0.016)
		local cf = p * A(0, 0, rad(i * 15)) * C(-len / 2, 0, 0)
		block(m, V(len + 0.1, w, 0.45), cf, rgb(150, 158, 178), {mat = Enum.Material.Metal})
		block(m, V(len + 0.1, 0.35, 0.5), cf * C(0, -w / 2 - 0.1, 0), GHOST, {neon = true})
		p = p * A(0, 0, rad(i * 15)) * C(-len, 0, 0) * A(0, 0, rad(-i * 15))
	end
	return m
end
-- réverbère d'âme : poteau de fer, bras courbé, lanterne cyan
local function lampPost(height)
	local m = prop("LampPost")
	block(m, V(2.2, 0.8, 2.2), C(0, 0.4, 0), IRON)
	block(m, V(0.7, height, 0.7), C(0, height / 2 + 0.6, 0), IRON)
	block(m, V(3.2, 0.5, 0.5), C(1.4, height + 0.4, 0), IRON)
	block(m, V(0.9, 0.9, 0.9), C(0, height + 0.9, 0) * A(rad(45), 0, rad(45)), rgb(92, 56, 148))
	soulLamp(m, C(2.8, height - 1.2, 0), 1.2, true)
	return m
end
-- pierre tombale : dalle, sommet en escalier, rune lumineuse, parfois un petit crâne au pied
local function tombstone(size)
	local m = prop("Tombstone")
	local s = size / 4
	local tilt = A(rad(rng:NextNumber(-8, 8)), 0, rad(rng:NextNumber(-8, 8)))
	block(m, V(3.4, 0.4, 2.0) * s, C(0, 0.2 * s, 0), STONE2)
	local base = C(0, 0.4 * s, 0) * tilt
	block(m, V(2.6, 3.0, 0.8) * s, base * C(0, 1.5 * s, 0), pick({STONE, STONE3}))
	block(m, V(1.8, 0.7, 0.8) * s, base * C(0, 3.35 * s, 0), STONE)
	block(m, V(0.9, 0.5, 0.8) * s, base * C(0, 3.9 * s, 0), STONE3)
	block(m, V(1.2, 0.18, 0.1) * s, base * C(0, 2.3 * s, 0.42 * s), GHOST, {neon = true})
	block(m, V(0.8, 0.18, 0.1) * s, base * C(0, 1.8 * s, 0.42 * s), GHOST, {neon = true})
	if rng:NextInteger(0, 2) == 0 then block(m, V(0.8, 0.7, 0.8) * s, C(0.9 * s, 0.75 * s, 1.0 * s) * A(0, rad(20), 0), BONE) end
	return m
end
-- tas de crânes
local function skullPile(size)
	local m = prop("SkullPile")
	local s = size / 3
	for i, p in {V(0, 0.5, 0), V(1.1, 0.5, 0.3), V(-1.0, 0.5, 0.4), V(0.2, 0.5, -1.0), V(0.1, 1.4, 0.1)} do
		local cf = C(p * s) * A(0, rad(i * 47), 0)
		block(m, V(1.0, 0.9, 1.0) * s, cf, i % 2 == 0 and BONE or BONE2)
		if i % 2 == 1 then
			for _, sx in {-1, 1} do block(m, V(0.24, 0.22, 0.1) * s, cf * C(sx * 0.22 * s, 0.06 * s, 0.51 * s), VOID, {smooth = true}) end
		end
	end
	return m
end
-- bougies d'os aux flammes cyan
local function candles(size)
	local m = prop("Candles")
	local s = size / 3
	block(m, V(2.4, 0.3, 2.0) * s, C(0, 0.15 * s, 0), STONE2)
	for i, p in {V(-0.6, 0, 0.3), V(0.5, 0, -0.2), V(0.1, 0, 0.6)} do
		local h = (1.6 - i * 0.35) * s
		block(m, V(0.45, h, 0.45) * V(s, 1, s), C(p.X * s, 0.3 * s + h / 2, p.Z * s), BONE)
		block(m, V(0.25, 0.4, 0.25) * s, C(p.X * s, 0.3 * s + h + 0.25 * s, p.Z * s) * A(0, rad(45), 0), GHOST, {neon = true})
	end
	return m
end
-- grappe de cristaux sombres aux pointes lumineuses
local function shadowCrystals(size)
	local m = prop("ShadowCrystals")
	local color = pick({GHOST, GHOSTV})
	block(m, V(size * 0.9, size * 0.25, size * 0.8), C(0, size * 0.12, 0), STONE2)
	for i = 0, 4 do
		local h = size * (i == 0 and 1.4 or rng:NextNumber(0.6, 1.0))
		local w = size * (i == 0 and 0.3 or 0.2)
		local a = i == 0 and C() or A(0, rad(i * 90), 0) * C(size * 0.26, 0, 0) * A(0, 0, rad(-22))
		local base = C(0, size * 0.15, 0) * a
		block(m, V(w, h, w), base * C(0, h / 2, 0) * A(0, rad(45), 0), rgb(40, 34, 60), {mat = Enum.Material.Glass, transparency = 0.1})
		block(m, V(w * 0.62, w * 1.1, w * 0.62), base * C(0, h + w * 0.3, 0) * A(0, rad(45), 0), color, {neon = true})
	end
	return m
end
-- colonne brisée couchée et morceaux
local function brokenPillar(size)
	local m = prop("BrokenPillar")
	local s = size / 6
	block(m, V(3, 1, 3) * s, C(0, 0.5 * s, 0), STONE2)
	block(m, V(2.2, 3.4, 2.2) * s, C(0, 2.7 * s, 0) * A(0, rad(10), rad(4)), STONE3)
	block(m, V(2.0, 5.4, 2.0) * s, C(3.4 * s, 1.0 * s, 0.6 * s) * A(rad(6), rad(25), rad(84)), STONE)
	block(m, V(1.0, 0.9, 1.1) * s, C(-1.8 * s, 0.45 * s, 1.4 * s) * A(0, rad(30), rad(12)), STONE3)
	return m
end
-- grille de fer à piques
local function fence()
	local m = prop("IronFence")
	for i = -2, 2 do
		block(m, V(0.3, 4.2, 0.3), C(i * 1.3, 2.1, 0), IRON)
		block(m, V(0.3, 0.6, 0.3), C(i * 1.3, 4.4, 0) * A(0, rad(45), rad(45)), IRON)
	end
	for _, y in {1.2, 3.3} do block(m, V(5.8, 0.25, 0.25), C(0, y, 0), IRON) end
	for _, sx in {-1, 1} do
		block(m, V(0.8, 5.2, 0.8), C(sx * 3.2, 2.6, 0), STONE)
		block(m, V(0.5, 0.5, 0.5), C(sx * 3.2, 5.45, 0) * A(0, rad(45), 0), GHOSTV, {neon = true})
	end
	return m
end
-- fantôme qui flotte : tête pâle, corps qui s'affine en traîne déchirée, yeux et bouche noirs
local function ghost(size)
	local m = prop("Ghost")
	local s = size / 6
	local pale = {smooth = true, transparency = 0.2}
	block(m, V(3.2, 2.8, 3.0) * s, C(0, 4.6 * s, 0), PALE, pale)
	block(m, V(2.8, 1.6, 2.6) * s, C(0, 2.6 * s, 0), PALE, pale)
	block(m, V(2.0, 1.4, 1.9) * s, C(0.2 * s, 1.2 * s, -0.2 * s) * A(rad(-10), 0, rad(8)), shade(PALE, -0.06), pale)
	block(m, V(1.2, 1.2, 1.0) * s, C(0.5 * s, 0.1 * s, -0.5 * s) * A(rad(-20), 0, rad(16)), shade(PALE, -0.1), pale)
	for _, sx in {-1, 1} do
		block(m, V(0.6, 0.9, 0.2) * s, C(sx * 0.7 * s, 4.9 * s, 1.5 * s), VOID, {smooth = true})
		block(m, V(0.8, 1.4, 0.8) * s, C(sx * 1.8 * s, 3.0 * s, 0.4 * s) * A(rad(-30), 0, rad(sx * 30)), PALE, pale) -- bras
	end
	block(m, V(0.9, 0.7, 0.2) * s, C(0, 3.8 * s, 1.5 * s), VOID, {smooth = true})
	return m
end
-- feu follet : petite flamme d'âme dans une bulle
local function wisp(size)
	local m = prop("Wisp")
	block(m, V(size, size, size) * 0.5, C() * A(rad(45), rad(45), 0), pick({GHOST, GHOSTV}), {neon = true})
	block(m, V(size, size, size) * 0.9, C(), rgb(200, 255, 245), {glass = true, transparency = 0.6, smooth = true})
	return m
end
-- lune en blocs (tranches empilées), avec ses cratères
local function moon(size)
	local m = prop("Moon")
	local r = size / 2
	local layers = 11
	for i = 0, layers - 1 do
		local y = -r + (i + 0.5) * size / layers
		local w = 2 * math.sqrt(math.max(r * r - y * y, 0)) * 0.92 + size * 0.05
		local color = (i == 3 or i == 7) and MOON2 or MOON
		block(m, V(w, size / layers + 0.05, w), C(0, r + y, 0) * A(0, rad(i % 2 * 45), 0), color, {smooth = true})
		block(m, V(w * 0.72, size / layers + 0.05, w * 1.02), C(0, r + y, 0), color, {smooth = true})
	end
	for _, c in {V(0.25, 0.6, 0.42), V(-0.3, 0.35, 0.4), V(0.05, 0.28, 0.47)} do
		block(m, V(size * 0.16, size * 0.16, size * 0.06), C(c.X * size, c.Y * size, c.Z * size), MOON2, {smooth = true})
	end
	return m
end

local THEME = {
	Big = {function() return deadTree(rng:NextInteger(22, 30)) end, function() return crypt(rng:NextNumber(14, 18)) end,
		function() return obelisk(rng:NextInteger(15, 21)) end, function() return deadTree(rng:NextInteger(20, 26)) end,
		function() return giantScythe(rng:NextInteger(18, 24)) end, function() return lampPost(rng:NextInteger(11, 14)) end},
	BigFit = 22,
	Small = {function() return tombstone(rng:NextNumber(3.5, 5)) end, function() return tombstone(rng:NextNumber(3, 4.5)) end,
		function() return skullPile(rng:NextNumber(2.5, 3.5)) end, function() return candles(rng:NextNumber(2.5, 3.5)) end,
		function() return shadowCrystals(rng:NextNumber(3.5, 5.5)) end, function() return brokenPillar(rng:NextNumber(5, 7)) end, fence},
	SmallFit = 9,
	Air = {function() return ghost(rng:NextNumber(5, 8)) end, function() return wisp(rng:NextNumber(1.6, 2.6)) end, function() return wisp(rng:NextNumber(1.2, 2)) end},
}

---------------------------------------------------------------- portail d'entrée : deux piliers de pierre noire, une poutre, un grand crâne
local function gate(folder, x, floorY)
	local m = prop("EntranceGate")
	local width = OLD_NORTH - OLD_SOUTH
	local beamY = 54
	for _, z in {OLD_NORTH - 2.5, OLD_SOUTH + 2.5} do
		for i = 0, 17 do
			local rune = i % 4 == 2
			block(m, V(5.2 - (i % 2) * 0.6, 3, 5.2 - (i % 2) * 0.6), C(x, floorY + 1.5 + i * 3, z), rune and GHOST or (i % 2 == 0 and STONE2 or STONE), {neon = rune})
		end
		local orb = block(m, V(4, 4, 4), C(x, floorY + beamY + 4, z) * A(rad(45), rad(45), 0), GHOSTV, {neon = true})
		light(orb, GHOSTV, 26, 1.5)
		for _, sz in {-1, 1} do -- piques sur le haut des piliers
			block(m, V(1, 4, 1), C(x, floorY + beamY + 3, z + sz * 2.6) * A(rad(sz * 25), 0, 0), BONE)
		end
	end
	for i = 0, math.floor(width / 5) - 1 do
		local z = OLD_SOUTH + 2.5 + i * 5
		block(m, V(3.2, 3.2, 5.1), C(x, floorY + beamY, z), i % 2 == 0 and STONE2 or STONE)
		if i % 4 == 1 then -- chaînes et lanternes d'âme suspendues
			local len = rng:NextInteger(6, 13)
			for k = 0, math.floor(len / 1.4) do
				block(m, V(0.3, 1.2, 0.7), C(x, floorY + beamY - 1.6 - 0.7 - k * 1.4, z) * A(0, k % 2 == 1 and rad(90) or 0, 0), IRON)
			end
			soulLamp(m, C(x, floorY + beamY - 3.5 - len, z), 1.5, i % 8 == 1)
		end
	end
	block(m, V(1.2, 0.3, width), C(x, floorY + beamY - 1.75, (OLD_NORTH + OLD_SOUTH) / 2), GHOST, {neon = true, transparency = 0.45})
	-- le grand crâne au milieu de la poutre, yeux cyan
	local zc = (OLD_NORTH + OLD_SOUTH) / 2
	block(m, V(4, 6, 7), C(x, floorY + beamY + 4.2, zc), BONE)
	block(m, V(3.6, 2, 5), C(x, floorY + beamY + 0.4, zc), BONE2)
	for _, sz in {-1, 1} do
		local eye = block(m, V(4.2, 1.6, 1.8), C(x, floorY + beamY + 4.6, zc + sz * 1.6), GHOST, {neon = true})
		if sz == 1 then light(eye, GHOST, 30, 2) end
	end
	block(m, V(4.2, 0.9, 0.9), C(x, floorY + beamY + 2.6, zc) * A(rad(45), 0, 0), VOID, {smooth = true})
	block(m, V(4.2, 0.3, 3.8), C(x, floorY + beamY + 1.1, zc), VOID, {smooth = true})
	m.Parent = folder
end

-- brume au sol : quelques émetteurs invisibles qui traînent une fumée basse, cyan et violette
local function fog(folder, cf, size)
	local p = Instance.new("Part")
	p.Name = "GroundFog"
	p.Size = V(size, 1, size)
	p.CFrame = cf
	p.Transparency = 1
	p.Anchored = true
	p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = false, false, false, false
	local e = Instance.new("ParticleEmitter")
	e.Name = "Fog"
	e.Texture = "rbxasset://textures/particles/smoke_main.dds"
	e.Color = ColorSequence.new(rgb(110, 230, 220), rgb(120, 90, 200))
	e.LightEmission, e.LightInfluence = 0.35, 0
	e.Rate = 2.5
	e.Lifetime = NumberRange.new(7, 10)
	e.Speed = NumberRange.new(0.6, 1.4)
	e.SpreadAngle = Vector2.new(180, 10)
	e.EmissionDirection = Enum.NormalId.Top
	e.Acceleration = V(0, -0.05, 0)
	e.Rotation, e.RotSpeed = NumberRange.new(0, 360), NumberRange.new(-8, 8)
	e.Size = nseq({{0, 10}, {1, 22}})
	e.Transparency = nseq({{0, 1}, {0.25, 0.86}, {0.75, 0.86}, {1, 1}})
	e.Parent = p
	p.Parent = folder
end

---------------------------------------------------------------- construction
return function()
	local report = {}
	local prev = workspace:FindFirstChild(PREV_NAME)
	assert(prev, "Galaxy zone not found")
	local ledges, decorRoot, corridor = workspace.ZoneLedges, workspace.ZoneDecor, workspace.Corridor
	local prevEnd = prev.Position.X + prev.Size.X / 2
	local x0z = prevEnd + GAP
	local x1z = x0z + WIDTH
	local floorY = prev.Position.Y + prev.Size.Y / 2
	local top = floorY + LEDGE_UP
	local zMid = (OLD_NORTH + OLD_SOUTH) / 2
	local shift = x1z - prevEnd

	-- 0. le fond de la carte recule (une seule fois)
	if not corridor:GetAttribute("ExtendedForPhantom") then
		local newEnd = x1z + GAP -- face arrière du mur du fond, une fois reculé
		for _, p in corridor:GetChildren() do
			if p:IsA("BasePart") and string.sub(p.Name, 1, 3) == "End" then p.Position += V(shift, 0, 0) end
		end
		-- les grands pans du couloir (Name2) s'arrêtent à la taille maximale d'une pièce (2048) : on ajoute Name3 jusqu'au fond
		for _, p in corridor:GetChildren() do
			if p:IsA("BasePart") and string.sub(p.Name, -1) == "2" then
				local stop = p.Position.X + p.Size.X / 2
				if stop < newEnd - 1 and not corridor:FindFirstChild(string.sub(p.Name, 1, -2) .. "3") then
					local q = p:Clone()
					q.Name = string.sub(p.Name, 1, -2) .. "3"
					q.Size = V(newEnd - stop, p.Size.Y, p.Size.Z)
					q.Position = V((stop + newEnd) / 2, p.Position.Y, p.Position.Z)
					q.Parent = corridor
				end
			end
		end
		local forest = game.ReplicatedStorage:FindFirstChild("IntroForest")
		if forest then forest:PivotTo(forest:GetPivot() + V(shift, 0, 0)) end
		-- décors Galaxy du plateau du fond : rangés (le plateau du fond devient celui de la zone Phantom)
		local store = game.ServerStorage:FindFirstChild("Removed_GalaxyEndPlateauDecor") or Instance.new("Folder")
		store.Name = "Removed_GalaxyEndPlateauDecor"
		store.Parent = game.ServerStorage
		local gx = decorRoot:FindFirstChild("Galaxy")
		for _, m in gx and gx:GetChildren() or {} do
			if m:IsA("Model") and m:GetBoundingBox().X > prevEnd + 0.5 then m.Parent = store end
		end
		-- plateaux Galaxy : ils bordent aussi la moitié de la bande vers la zone Phantom
		for _, p in ledges:GetChildren() do
			if p:IsA("BasePart") and (p.Name == "GalaxyNorth" or p.Name == "GalaxySouth" or (p.Name == "Top" and p:GetAttribute("Galaxy"))) and math.abs(p.Position.X + p.Size.X / 2 - prevEnd) < 1 and p.Size.Z < 100 then
				local start = p.Position.X - p.Size.X / 2
				p.Size += V(GAP / 2, 0, 0)
				p.Position = V(start + p.Size.X / 2, p.Position.Y, p.Position.Z)
			end
		end
		-- plateau du fond : reculé
		for _, p in ledges:GetChildren() do
			if p:IsA("BasePart") and p.Size.Z > 200 and p.Position.X > prevEnd then p.Position += V(shift, 0, 0) end
		end
		corridor:SetAttribute("ExtendedForPhantom", true)
		table.insert(report, string.format("map end pushed back by %.1f studs", shift))
	end

	-- 1. le sol de la zone (copie de la zone Galaxy : même hauteur, même texture)
	local zone = workspace:FindFirstChild(ZONE_NAME)
	if zone then zone:Destroy() end
	zone = prev:Clone()
	for _, k in zone:GetChildren() do if not k:IsA("Texture") then k:Destroy() end end
	for name in zone:GetAttributes() do zone:SetAttribute(name, nil) end
	for _, tag in game:GetService("CollectionService"):GetTags(zone) do game:GetService("CollectionService"):RemoveTag(zone, tag) end
	zone.Name = ZONE_NAME
	zone.Color = FLOOR
	zone.Size = V(WIDTH, prev.Size.Y, prev.Size.Z)
	zone.Position = V((x0z + x1z) / 2, prev.Position.Y, prev.Position.Z)
	for _, t in zone:GetChildren() do if t:IsA("Texture") then t.Color3 = rgb(70, 64, 92) end end
	zone.Parent = workspace

	-- 2. bande entre les zones Galaxy et Phantom, et ses deux murets
	local sepX = prevEnd + GAP / 2
	local seps = workspace.ZoneSeparators
	for _, s in seps:GetChildren() do if math.abs(s.Position.X - sepX) < 1 then s:Destroy() end end
	local model = seps:FindFirstChild("ZoneSeparator")
	local strip = model:Clone()
	strip.Position = V(sepX, model.Position.Y, model.Position.Z)
	strip.Parent = seps
	for _, n in {"NorthSeparatorWall", "SouthSeparatorWall"} do
		local src
		for _, p in ledges:GetChildren() do
			if p.Name == n then
				if math.abs(p.Position.X - sepX) < 1 then p:Destroy() elseif not src then src = p end
			end
		end
		local w = src:Clone()
		w.Position = V(sepX, src.Position.Y, src.Position.Z)
		w.Parent = ledges
	end

	-- 3. plateaux nord et sud ; plateau du fond aux couleurs de la zone
	local x0, x1 = x0z - GAP / 2, x1z
	for _, p in ledges:GetChildren() do
		if p.Name == "PhantomNorth" or p.Name == "PhantomSouth" or (p.Name == "Top" and p:GetAttribute("Phantom")) then p:Destroy() end
	end
	local texture = zone:FindFirstChildOfClass("Texture")
	for _, side in {1, -1} do
		local edge = side == 1 and OLD_NORTH or OLD_SOUTH
		local zc = edge + side * SIDE / 2
		local ledge = Instance.new("Part")
		ledge.Name = side == 1 and "PhantomNorth" or "PhantomSouth"
		ledge.Anchored = true
		ledge.Size = V(x1 - x0, 44, SIDE)
		ledge.Position = V((x0 + x1) / 2, top - 23.2, zc)
		ledge.Color = shade(FLOOR, -0.45)
		ledge.Material = zone.Material
		pcall(function() ledge.MaterialVariant = zone.MaterialVariant end)
		ledge.TopSurface, ledge.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
		if texture then texture:Clone().Parent = ledge end
		ledge.Parent = ledges
		local trim = Instance.new("Part")
		trim.Name = "Top"
		trim:SetAttribute("Phantom", true)
		trim.Anchored = true
		trim.Size = V(x1 - x0, 1.2, SIDE)
		trim.Position = V((x0 + x1) / 2, top - 0.6, zc)
		trim.Color = shade(FLOOR, 0.1)
		trim.Material = Enum.Material.Plastic
		pcall(function() trim.MaterialVariant = "Studs" end)
		trim.TopSurface, trim.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
		if texture then texture:Clone().Parent = trim end
		trim.Parent = ledges
		-- liseré cyan au bord du plateau, du côté de la tranchée
		local rim = Instance.new("Part")
		rim.Name = "Top"
		rim:SetAttribute("Phantom", true)
		rim.Anchored = true
		rim.CanCollide, rim.CanQuery, rim.CanTouch, rim.CastShadow = false, false, false, false
		rim.Size = V(x1 - x0, 0.3, 0.5)
		rim.Position = V((x0 + x1) / 2, top + 0.1, edge + side * 0.35)
		rim.Color = GHOST
		rim.Material = Enum.Material.Neon
		rim.Transparency = 0.25
		rim.Parent = ledges
	end
	local endLedge, endTop
	for _, p in ledges:GetChildren() do
		if p:IsA("BasePart") and p.Size.Z > 200 then
			if p.Name == "EndPlateau" then endLedge = p elseif p.Name == "Top" then endTop = p end
		end
	end
	if endLedge then endLedge.Color = shade(FLOOR, -0.45) end
	if endTop then
		endTop.Color = shade(FLOOR, 0.1)
		for _, t in endTop:GetChildren() do if t:IsA("Texture") then t:Destroy() end end
		if texture then texture:Clone().Parent = endTop end
	end

	-- 4. décors
	local folder = decorRoot:FindFirstChild("Phantom")
	if folder then folder:Destroy() end
	folder = Instance.new("Folder")
	folder.Name = "Phantom"
	folder:SetAttribute("CenterX", zone.Position.X) -- lu par AntiLagClient
	folder:SetAttribute("HalfX", zone.Size.X / 2)
	folder.Parent = decorRoot
	for _, side in {1, -1} do
		local edge = side == 1 and OLD_NORTH or OLD_SOUTH
		local yawBase = side == 1 and 0 or 180
		local span = x1 - x0 - 8
		for row = 1, 2 do
			local depth = row == 1 and 22 or 45
			local count = math.max(1, math.floor(span / (row == 1 and 32 or 27)))
			for i = 1, count do
				local m = THEME.Big[(i * row + INDEX + (side == 1 and 0 or 3)) % #THEME.Big + 1]()
				local x = x0 + 4 + span * (i - (row == 1 and 0.5 or 0.15)) / count + rng:NextNumber(-3, 3)
				fitted(m, folder, C(math.clamp(x, x0 + 6, x1 - 6), top, edge + side * (depth + rng:NextNumber(-3, 3))) * A(0, rad(yawBase + rng:NextInteger(-14, 14)), 0), THEME.BigFit)
			end
		end
		local smallCount = math.floor(span / 9)
		for i = 1, smallCount do
			local x = x0 + 3 + (x1 - x0 - 6) * (i - 0.5) / smallCount + rng:NextNumber(-2.5, 2.5)
			local z = edge + side * ((i % 3 == 0) and rng:NextNumber(30, 54) or rng:NextNumber(4, 15))
			fitted(pick(THEME.Small)(), folder, C(x, top, z) * A(0, rad(yawBase + rng:NextInteger(-40, 40)), 0), THEME.SmallFit)
		end
		for _ = 1, 7 do
			fitted(pick(THEME.Air)(), folder, C(rng:NextNumber(x0 + 6, x1 - 6), top + rng:NextNumber(14, 34), edge + side * rng:NextNumber(4, SIDE - 4)) * A(rad(rng:NextInteger(-12, 12)), rad(rng:NextInteger(0, 360)), 0))
		end
	end
	gate(folder, x0z + 3, floorY)
	-- dans la zone : grands décors près des bords, tombes et petits décors partout, fantômes et feux follets au-dessus
	local bigCount = math.floor(8 * WIDTH / ZONE_W + 0.5)
	for i = 1, bigCount do
		local m = THEME.Big[(i + INDEX) % #THEME.Big + 1]()
		local z = i % 2 == 0 and (OLD_NORTH - rng:NextNumber(8, 18)) or (OLD_SOUTH + rng:NextNumber(8, 18))
		fitted(m, folder, C(x0z + 14 + (WIDTH - 28) * (i - 0.5) / bigCount + rng:NextNumber(-4, 4), floorY, z) * A(0, rad(rng:NextInteger(0, 360)), 0), 15)
	end
	for _ = 1, math.floor(10 * WIDTH / ZONE_W + 0.5) do
		fitted(pick(THEME.Small)(), folder, C(rng:NextNumber(x0z + 8, x1z - 8), floorY, rng:NextNumber(OLD_SOUTH + 8, OLD_NORTH - 8)) * A(0, rad(rng:NextInteger(0, 360)), 0), 8)
	end
	for _ = 1, math.floor(8 * WIDTH / ZONE_W + 0.5) do -- rangées de tombes le long des murs
		local north = rng:NextInteger(0, 1) == 0
		fitted(tombstone(rng:NextNumber(3.5, 5)), folder, C(rng:NextNumber(x0z + 8, x1z - 8), floorY, north and (OLD_NORTH - rng:NextNumber(3, 7)) or (OLD_SOUTH + rng:NextNumber(3, 7))) * A(0, rad((north and 180 or 0) + rng:NextInteger(-15, 15)), 0), 8)
	end
	for _ = 1, 9 do
		fitted(ghost(rng:NextNumber(6, 10)), folder, C(rng:NextNumber(x0z + 12, x1z - 12), floorY + rng:NextNumber(22, 44), rng:NextNumber(OLD_SOUTH + 14, OLD_NORTH - 14)) * A(rad(rng:NextInteger(-10, 10)), rad(rng:NextInteger(0, 360)), 0))
	end
	for _ = 1, 16 do
		fitted(wisp(rng:NextNumber(1.4, 2.6)), folder, C(rng:NextNumber(x0z + 8, x1z - 8), floorY + rng:NextNumber(8, 40), rng:NextNumber(OLD_SOUTH + 6, OLD_NORTH - 6)))
	end
	-- fissures d'âme au sol : petits traits cyan et violets en zigzag
	local cracks = prop("SoulCracks")
	for _ = 1, 26 do
		local at = V(rng:NextNumber(x0z + 6, x1z - 6), floorY + 0.06, rng:NextNumber(OLD_SOUTH + 6, OLD_NORTH - 6))
		local yaw = rng:NextNumber(0, 360)
		local color = rng:NextInteger(0, 3) == 0 and GHOSTV or GHOST
		for k = 0, rng:NextInteger(2, 4) do
			local len = rng:NextNumber(2, 4.5)
			yaw += rng:NextNumber(-40, 40)
			local dir = V(math.cos(rad(yaw)), 0, math.sin(rad(yaw)))
			block(cracks, V(len, 0.12, 0.35), C(at + dir * len / 2) * A(0, -rad(yaw), 0), color, {neon = true, transparency = 0.15})
			at += dir * len
		end
	end
	cracks.Parent = folder
	-- brume basse
	for i = 1, 9 do
		fog(folder, C(x0z + WIDTH * (i - 0.5) / 9, floorY + 1, zMid + rng:NextNumber(-40, 40)), 40)
	end
	-- 5. plateau du fond : cryptes, arbres morts, et une immense lune pâle dans le ciel
	local width = OLD_NORTH - OLD_SOUTH + SIDE * 2
	for i = 1, 8 do
		fitted(THEME.Big[i % #THEME.Big + 1](), folder, C(x1z + rng:NextNumber(14, SIDE - 12), top, zMid - width / 2 + width * (i - 0.5) / 8) * A(0, rad(-90 + rng:NextInteger(-14, 14)), 0), THEME.BigFit)
	end
	for i = 1, 22 do
		fitted(pick(THEME.Small)(), folder, C(x1z + rng:NextNumber(4, 14), top, zMid - width / 2 + width * (i - 0.5) / 22) * A(0, rad(-90 + rng:NextInteger(-40, 40)), 0), THEME.SmallFit)
	end
	local bigMoon = moon(56)
	fitted(bigMoon, folder, C(x1z + 70, top + 46, zMid) * A(0, rad(-90), 0))
	local halo = Instance.new("Part")
	halo.Name = "MoonHalo"
	halo.Shape = Enum.PartType.Cylinder
	halo.Size = V(0.4, 76, 76)
	halo.CFrame = C(x1z + 76, top + 74, zMid) -- (cylindre couché sur X : un disque face à la zone)
	halo.Color = rgb(150, 230, 255)
	halo.Material = Enum.Material.Neon
	halo.Transparency = 0.82
	halo.Anchored = true
	halo.CanCollide, halo.CanQuery, halo.CanTouch, halo.CastShadow = false, false, false, false
	halo.Parent = folder
	for _, d in folder:GetDescendants() do
		if d:IsA("BasePart") then d.CanCollide, d.CanQuery, d.CanTouch, d.CastShadow = false, false, false, false end
	end
	table.insert(report, string.format("%s X %.1f..%.1f (width %.1f), %d decor instances", ZONE_NAME, x0z, x1z, WIDTH, #folder:GetDescendants()))
	return table.concat(report, "\n")
end
