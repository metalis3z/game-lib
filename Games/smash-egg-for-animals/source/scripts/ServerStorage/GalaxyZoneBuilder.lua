-- Outil d'édition (pas utilisé en jeu) : construit la 12e zone, GALAXY (rareté Galactic), après la zone Halloween.
-- Même style que ServerStorage.ZonesBuilder : tranchée, plateaux de 60 studs de chaque côté, décors en blocs à studs.
--   require(game.ServerStorage.GalaxyZoneBuilder)()  -> rapport. Peut être relancé : il refait la zone, ses plateaux et ses décors.
-- La première fois, il pousse aussi le fond de la carte (plateau du fond, murs invisibles du couloir, forêt de l'intro)
-- derrière la nouvelle zone. Sauvegarde de l'avant : ServerStorage.Backup_BeforeGalaxyZone.
local V, C, A, rad = Vector3.new, CFrame.new, CFrame.Angles, math.rad
local rgb = Color3.fromRGB
local ZONE_W, GROW, GAP = 150.73, 0.1, 27.9
local INDEX = 12                                -- 12e zone : x2,1 la longueur de la première
local WIDTH = ZONE_W * (1 + GROW * (INDEX - 1)) -- 316,5 studs
local ZONE_NAME = "GALACTIC galaxy egg zone"
local PREV_NAME = "Halloween demon egg zone"
local SIDE, LEDGE_UP = 60, 45.2
local OLD_NORTH, OLD_SOUTH = -84.3, -251.3
local FLOOR = rgb(58, 42, 128)                  -- sol : violet-indigo de l'espace
local rng = Random.new(20261017)

---------------------------------------------------------------- briques (comme ZonesBuilder)
local function block(model, size, cf, color, o)
	o = o or {}
	local p = Instance.new("Part")
	p.Name = o.name or "Stud"
	p.Size, p.CFrame, p.Color = size, cf, color
	p.Anchored = true
	p.CanCollide, p.CanTouch, p.CanQuery = false, false, false
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	p.Material = o.neon and Enum.Material.Neon or (o.glass and Enum.Material.Glass or Enum.Material.Plastic)
	if not o.neon and not o.glass then pcall(function() p.MaterialVariant = "Studs" end) end
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

---------------------------------------------------------------- couleurs de l'espace
local NAVY, INDIGO, VIOLET = rgb(30, 26, 70), rgb(62, 46, 140), rgb(120, 70, 220)
local CYAN, PINK, GOLDSTAR = rgb(80, 230, 255), rgb(255, 110, 220), rgb(255, 232, 110)
local MOON, MOON2, MOON3 = rgb(150, 146, 172), rgb(118, 112, 146), rgb(178, 174, 200)
local HULL, HULL2, RED = rgb(240, 242, 250), rgb(200, 206, 222), rgb(230, 60, 70)
local PLANETS = {
	{rgb(255, 150, 80), rgb(230, 100, 60), rgb(255, 205, 140)},   -- orange (type Mars)
	{rgb(90, 170, 255), rgb(60, 120, 220), rgb(170, 225, 255)},   -- bleue
	{rgb(200, 120, 255), rgb(150, 80, 220), rgb(240, 190, 255)},  -- violette
	{rgb(255, 210, 110), rgb(220, 160, 70), rgb(255, 240, 180)},  -- dorée (type Saturne)
	{rgb(110, 230, 170), rgb(60, 180, 130), rgb(190, 255, 220)},  -- verte
}

---------------------------------------------------------------- décors
-- planète en blocs : des tranches carrées empilées (une sphère en studs), avec des bandes, un anneau si ring
local function planet(size, ring, palette)
	local m = prop("Planet")
	local col = palette or pick(PLANETS)
	local r = size / 2
	local layers = 9
	for i = 0, layers - 1 do
		local y = -r + (i + 0.5) * size / layers
		local w = 2 * math.sqrt(math.max(r * r - y * y, 0)) * 0.92 + size * 0.06
		local color = (i == 3 or i == 5) and col[2] or (i == 4 and col[3] or col[1])
		block(m, V(w, size / layers + 0.05, w), C(0, r + y, 0) * A(0, rad(i % 2 * 45), 0), color)
		block(m, V(w * 0.72, size / layers + 0.05, w * 1.02), C(0, r + y, 0), color) -- arrondit les coins
	end
	if ring then
		local rr = r * 1.55
		for i = 0, 27 do
			local a = (i + 0.5) / 28 * math.pi * 2
			block(m, V(2 * rr * math.tan(math.pi / 28) * 1.1, math.max(size * 0.035, 0.2), r * 0.2), C(0, r, 0) * A(rad(20), 0, rad(-10)) * A(0, a, 0) * C(0, 0, rr), i % 2 == 0 and col[3] or col[2])
		end
	end
	return m
end
-- planète posée sur un socle (grand décor des plateaux)
local function planetStand(size)
	local m = prop("PlanetStand")
	block(m, V(size * 0.7, 1.4, size * 0.7), C(0, 0.7, 0), NAVY)
	block(m, V(size * 0.5, 1.2, size * 0.5), C(0, 2, 0), INDIGO)
	block(m, V(1.6, size * 0.45, 1.6), C(0, 2.6 + size * 0.225, 0), NAVY)
	block(m, V(size * 0.55, 0.5, size * 0.55), C(0, 2.7, 0), CYAN, {neon = true})
	local p = planet(size, rng:NextInteger(0, 1) == 0)
	place(p, m, C(0, 2.4 + size * 0.45, 0) * A(0, rad(rng:NextInteger(0, 90)), 0))
	return m
end
-- grappe de cristaux lumineux
local function crystals(size, color)
	local m = prop("Crystals")
	color = color or pick({CYAN, PINK, VIOLET, rgb(140, 160, 255)})
	block(m, V(size * 0.9, size * 0.25, size * 0.8), C(0, size * 0.12, 0), MOON2)
	for i = 0, 5 do
		local h = size * (i == 0 and 1.5 or rng:NextNumber(0.6, 1.1))
		local w = size * (i == 0 and 0.32 or 0.22)
		local a = i == 0 and C() or A(0, rad(i * 72), 0) * C(size * 0.28, 0, 0) * A(0, 0, rad(-22))
		local base = C(0, size * 0.15, 0) * a
		block(m, V(w, h, w), base * C(0, h / 2, 0) * A(0, rad(45), 0), i % 2 == 0 and color or shade(color, 0.35), {neon = i % 2 == 0})
		block(m, V(w * 0.62, w * 0.9, w * 0.62), base * C(0, h + w * 0.3, 0) * A(0, rad(45), 0), shade(color, 0.55), {neon = true})
	end
	return m
end
-- grande flèche de cristal
local function crystalSpire(height)
	local m = prop("CrystalSpire")
	local color = pick({CYAN, PINK, VIOLET})
	block(m, V(9, 2.4, 9), C(0, 1.2, 0) * A(0, rad(20), 0), MOON2)
	block(m, V(6.5, 2, 6.5), C(0, 3, 0) * A(0, rad(50), 0), MOON)
	local n = math.floor(height / 3)
	for i = 0, n - 1 do
		local w = 4.2 * (1 - i / n) + 0.8
		block(m, V(w, 3.05, w), C(0, 4 + i * 3 + 1.5, 0) * A(0, rad(45 + i * 9), 0), i % 3 == 1 and shade(color, 0.4) or color, {neon = i % 3 ~= 2})
	end
	for _, s in {-1, 1} do
		block(m, V(1.8, height * 0.35, 1.8), C(s * 3.4, 3.6 + height * 0.17, s * 1.2) * A(0, 0, rad(s * -18)) * A(0, rad(45), 0), shade(color, 0.3), {neon = true})
	end
	light(m:GetChildren()[3], color, 30, 1.6)
	return m
end
-- fusée blanche et rouge, hublot, ailerons, flamme
local function rocket(height)
	local m = prop("Rocket")
	local r = height * 0.13
	local body = height * 0.62
	local y0 = height * 0.12
	for i = 0, 5 do
		local h = body / 6
		block(m, V(r * 2, h + 0.05, r * 2), C(0, y0 + h * (i + 0.5), 0) * A(0, rad(i % 2 * 45), 0), (i == 1 or i == 4) and RED or (i % 2 == 0 and HULL or HULL2))
	end
	for i = 0, 3 do -- nez
		local w = r * 2 * (1 - i / 4) * 0.95
		block(m, V(w, height * 0.06, w), C(0, y0 + body + height * 0.06 * (i + 0.5), 0) * A(0, rad(i * 45), 0), i % 2 == 0 and RED or rgb(250, 90, 90))
	end
	block(m, V(r * 0.9, r * 0.9, 0.6), C(0, y0 + body * 0.62, -r - 0.1), CYAN, {neon = true}) -- hublot
	block(m, V(r * 1.2, r * 1.2, 0.4), C(0, y0 + body * 0.62, -r + 0.1), HULL2)
	for k = 0, 3 do -- ailerons
		local f = A(0, rad(k * 90 + 45), 0)
		block(m, V(0.8, height * 0.24, r * 1.4), f * C(0, y0 + height * 0.1, -r - r * 0.55) * A(rad(-12), 0, 0), RED)
	end
	block(m, V(r * 1.4, y0, r * 1.4), C(0, y0 / 2, 0), rgb(70, 70, 86)) -- tuyère
	local flame = block(m, V(r * 1.1, y0 * 0.8, r * 1.1), C(0, y0 * 0.2, 0) * A(0, rad(45), 0), rgb(255, 170, 60), {neon = true})
	light(flame, rgb(255, 170, 80), 22, 1.4)
	local fire = Instance.new("ParticleEmitter")
	fire.Texture = "rbxasset://textures/particles/fire_main.dds"
	fire.Color = ColorSequence.new(rgb(255, 220, 120), rgb(255, 90, 40))
	fire.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, r * 0.9), NumberSequenceKeypoint.new(1, 0)})
	fire.Lifetime, fire.Rate, fire.Speed = NumberRange.new(0.4, 0.7), 14, NumberRange.new(4, 7)
	fire.EmissionDirection = Enum.NormalId.Bottom
	fire.LightEmission = 1
	fire.Parent = flame
	return m
end
-- antenne parabolique
local function satellite(height)
	local m = prop("SatelliteDish")
	block(m, V(7, 1.4, 7), C(0, 0.7, 0), HULL2)
	block(m, V(2, height * 0.55, 2), C(0, 1.4 + height * 0.275, 0), HULL)
	local head = C(0, 1.4 + height * 0.6, 0) * A(rad(-35), 0, 0)
	for i = 0, 2 do
		local w = height * (0.62 - i * 0.14)
		block(m, V(w, 0.9, w), head * C(0, i * 0.9, 0) * A(0, rad(i * 45), 0), i == 0 and HULL2 or HULL)
	end
	block(m, V(0.5, height * 0.3, 0.5), head * C(0, height * 0.15 + 1.5, 0), rgb(90, 90, 110))
	local tip = block(m, V(1.2, 1.2, 1.2), head * C(0, height * 0.3 + 1.6, 0), RED, {neon = true})
	light(tip, RED, 16, 1)
	return m
end
-- roche lunaire avec cratère
local function moonRock(size)
	local m = prop("MoonRock")
	block(m, V(size, size * 0.55, size * 0.85), C(0, size * 0.27, 0) * A(0, rad(rng:NextInteger(0, 80)), 0), MOON)
	block(m, V(size * 0.6, size * 0.5, size * 0.6), C(size * 0.4, size * 0.25, size * 0.2) * A(0, rad(rng:NextInteger(0, 80)), 0), MOON2)
	block(m, V(size * 0.45, size * 0.12, size * 0.45), C(-size * 0.1, size * 0.55, 0), MOON3)
	if rng:NextInteger(0, 1) == 0 then
		block(m, V(size * 0.22, size * 0.3, size * 0.22), C(-size * 0.25, size * 0.6, size * 0.1) * A(0, rad(45), 0), pick({CYAN, PINK}), {neon = true})
	end
	return m
end
-- plante extraterrestre : tiges et bulbes lumineux
local function alienPlant(height)
	local m = prop("AlienPlant")
	local glow = pick({CYAN, PINK, rgb(160, 255, 120)})
	for i = 0, 2 do
		local h = height * (i == 0 and 1 or 0.7)
		local f = A(0, rad(i * 120), 0) * C(i == 0 and 0 or height * 0.15, 0, 0) * A(0, 0, rad(i == 0 and 0 or -12))
		block(m, V(0.6, h, 0.6), f * C(0, h / 2, 0), rgb(70, 50, 140))
		block(m, V(1.6, 1.6, 1.6), f * C(0, h + 0.5, 0) * A(rad(45), rad(45), 0), glow, {neon = true})
	end
	block(m, V(2.6, 0.6, 2.6), C(0, 0.3, 0), rgb(90, 70, 160))
	return m
end
-- drapeau d'astronaute
local function flag()
	local m = prop("SpaceFlag")
	block(m, V(2.4, 0.6, 2.4), C(0, 0.3, 0), MOON2)
	block(m, V(0.35, 8, 0.35), C(0, 4.3, 0), HULL2)
	block(m, V(3.6, 2.2, 0.2), C(1.9, 7.1, 0), VIOLET)
	block(m, V(1.1, 1.1, 0.25), C(1.9, 7.1, 0) * A(0, 0, rad(45)), GOLDSTAR, {neon = true})
	return m
end
-- étoile lumineuse à 4 branches
local function star(size, color)
	local m = prop("Star")
	color = color or GOLDSTAR
	block(m, V(size, size * 0.3, size * 0.3), C(), color, {neon = true})
	block(m, V(size * 0.3, size, size * 0.3), C(), color, {neon = true})
	block(m, V(size * 0.55, size * 0.55, size * 0.25), C() * A(0, 0, rad(45)), shade(color, 0.5), {neon = true})
	return m
end
-- petite soucoupe volante
local function ufo(size)
	local m = prop("UFO")
	block(m, V(size, size * 0.14, size), C(), HULL2)
	block(m, V(size * 0.8, size * 0.14, size * 0.8), C(0, 0, 0) * A(0, rad(45), 0), HULL)
	block(m, V(size * 0.45, size * 0.3, size * 0.45), C(0, size * 0.18, 0), CYAN, {glass = true, transparency = 0.25})
	for i = 0, 5 do
		local a = i / 6 * math.pi * 2
		block(m, V(size * 0.1, size * 0.08, size * 0.1), C(math.cos(a) * size * 0.42, -size * 0.06, math.sin(a) * size * 0.42), i % 2 == 0 and GOLDSTAR or PINK, {neon = true})
	end
	return m
end

local THEME = {
	Big = {function() return rocket(rng:NextInteger(24, 32)) end, function() return crystalSpire(rng:NextInteger(18, 28)) end,
		function() return planetStand(rng:NextNumber(11, 15)) end, function() return satellite(rng:NextInteger(14, 18)) end},
	BigFit = 24,
	Small = {function() return crystals(rng:NextNumber(3.5, 6)) end, function() return moonRock(rng:NextNumber(3.5, 6)) end,
		function() return alienPlant(rng:NextNumber(4, 7)) end, flag, function() return crystals(rng:NextNumber(3, 5)) end},
	SmallFit = 10,
	Air = {function() return planet(rng:NextNumber(5, 9), rng:NextInteger(0, 2) == 0) end, function() return star(rng:NextNumber(2, 3.6)) end, function() return ufo(rng:NextNumber(6, 9)) end},
}

---------------------------------------------------------------- portail d'entrée : deux piliers et une poutre à travers le couloir
local function gate(folder, x, floorY)
	local m = prop("EntranceGate")
	local width = OLD_NORTH - OLD_SOUTH
	local beamY = 54
	for _, z in {OLD_NORTH - 2.5, OLD_SOUTH + 2.5} do
		for i = 0, 17 do
			block(m, V(5 - (i % 2) * 0.6, 3, 5 - (i % 2) * 0.6), C(x, floorY + 1.5 + i * 3, z) * A(0, rad(i * 10), 0), i % 3 == 2 and CYAN or (i % 2 == 0 and NAVY or INDIGO), {neon = i % 3 == 2})
		end
		local orb = block(m, V(4, 4, 4), C(x, floorY + beamY + 4, z) * A(rad(45), rad(45), 0), PINK, {neon = true})
		light(orb, PINK, 26, 1.5)
	end
	for i = 0, math.floor(width / 5) - 1 do
		local z = OLD_SOUTH + 2.5 + i * 5
		block(m, V(3, 3, 5.1), C(x, floorY + beamY, z), i % 2 == 0 and INDIGO or CYAN, {neon = i % 2 == 1})
		if i % 4 == 2 then -- planètes et étoiles suspendues
			local len = rng:NextInteger(5, 12)
			block(m, V(0.3, len, 0.3), C(x, floorY + beamY - 1.5 - len / 2, z), HULL2)
			if i % 8 == 2 then
				place(planet(4.2, true), m, C(x, floorY + beamY - 1.5 - len - 4.2, z))
			else
				place(star(3.4), m, C(x, floorY + beamY - 3.2 - len, z) * A(0, rad(90), 0))
			end
		end
	end
	m.Parent = folder
end

---------------------------------------------------------------- construction
return function()
	local report = {}
	local prev = workspace:FindFirstChild(PREV_NAME)
	assert(prev, "Halloween zone not found")
	local ledges, decorRoot, corridor = workspace.ZoneLedges, workspace.ZoneDecor, workspace.Corridor
	local prevEnd = prev.Position.X + prev.Size.X / 2
	local x0z = prevEnd + GAP                      -- début du sol de la zone
	local x1z = x0z + WIDTH                         -- fin du sol de la zone
	local floorY = prev.Position.Y + prev.Size.Y / 2
	local top = floorY + LEDGE_UP
	local zMid = (OLD_NORTH + OLD_SOUTH) / 2
	local shift = x1z - prevEnd                     -- de combien le fond de la carte recule

	-- 0. le fond de la carte recule (une seule fois)
	if not corridor:GetAttribute("ExtendedForGalaxy") then
		for _, p in corridor:GetChildren() do
			if p:IsA("BasePart") then
				if string.sub(p.Name, 1, 3) == "End" then
					p.Position += V(shift, 0, 0)
				elseif math.abs(p.Position.X + p.Size.X / 2 - (prevEnd + GAP)) < 2 then -- les pans du couloir qui s'arrêtaient au fond
					local start = p.Position.X - p.Size.X / 2
					p.Size += V(shift, 0, 0)
					p.Position = V(start + p.Size.X / 2, p.Position.Y, p.Position.Z)
				end
			end
		end
		local forest = game.ReplicatedStorage:FindFirstChild("IntroForest") -- forêt de la cinématique, derrière la dernière zone
		if forest then
			for _, p in forest:GetDescendants() do
				if p:IsA("BasePart") then p.Position += V(shift, 0, 0) end
			end
		end
		-- décors Halloween du plateau du fond : rangés (le plateau du fond devient celui de la zone Galaxy)
		local store = game.ServerStorage:FindFirstChild("Removed_HalloweenEndPlateauDecor") or Instance.new("Folder")
		store.Name = "Removed_HalloweenEndPlateauDecor"
		store.Parent = game.ServerStorage
		local hw = decorRoot:FindFirstChild("Halloween")
		for _, m in hw and hw:GetChildren() or {} do
			if m:IsA("Model") and m:GetBoundingBox().X > prevEnd + 0.5 then m.Parent = store end
		end
		-- plateaux Halloween : ils bordent maintenant aussi la moitié de la bande vers la zone Galaxy
		for _, p in ledges:GetChildren() do
			if p:IsA("BasePart") and (p.Name == "HalloweenNorth" or p.Name == "HalloweenSouth" or p.Name == "Top") and math.abs(p.Position.X + p.Size.X / 2 - prevEnd) < 1 and p.Size.Z < 100 then
				local start = p.Position.X - p.Size.X / 2
				p.Size += V(GAP / 2, 0, 0)
				p.Position = V(start + p.Size.X / 2, p.Position.Y, p.Position.Z)
			end
		end
		-- plateau du fond : reculé
		for _, p in ledges:GetChildren() do
			if p:IsA("BasePart") and p.Size.Z > 200 and p.Position.X > prevEnd then p.Position += V(shift, 0, 0) end
		end
		corridor:SetAttribute("ExtendedForGalaxy", true)
		table.insert(report, string.format("map end pushed back by %.1f studs", shift))
	end

	-- 1. le sol de la zone (copie de la zone Halloween : même hauteur, même texture à damier)
	local zone = workspace:FindFirstChild(ZONE_NAME)
	if zone then zone:Destroy() end
	zone = prev:Clone()
	for _, k in zone:GetChildren() do if not k:IsA("Texture") then k:Destroy() end end
	for name in zone:GetAttributes() do zone:SetAttribute(name, nil) end
	zone.Name = ZONE_NAME
	zone.Color = FLOOR
	zone.Size = V(WIDTH, prev.Size.Y, prev.Size.Z)
	zone.Position = V((x0z + x1z) / 2, prev.Position.Y, prev.Position.Z)
	zone.Parent = workspace

	-- 2. bande entre les zones Halloween et Galaxy, et ses deux murets
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

	-- 3. plateaux nord et sud (comme ZonesBuilder) ; plateau du fond recoloré aux couleurs de la galaxie
	local x0, x1 = x0z - GAP / 2, x1z
	for _, p in ledges:GetChildren() do
		if p.Name == "GalaxyNorth" or p.Name == "GalaxySouth" or (p.Name == "Top" and p:GetAttribute("Galaxy")) then p:Destroy() end
	end
	local texture = zone:FindFirstChildOfClass("Texture")
	for _, side in {1, -1} do
		local edge = side == 1 and OLD_NORTH or OLD_SOUTH
		local zc = edge + side * SIDE / 2
		local ledge = Instance.new("Part")
		ledge.Name = side == 1 and "GalaxyNorth" or "GalaxySouth"
		ledge.Anchored = true
		ledge.Size = V(x1 - x0, 44, SIDE)
		ledge.Position = V((x0 + x1) / 2, top - 23.2, zc)
		ledge.Color = shade(FLOOR, -0.42)
		ledge.Material = zone.Material
		pcall(function() ledge.MaterialVariant = zone.MaterialVariant end)
		ledge.TopSurface, ledge.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
		if texture then texture:Clone().Parent = ledge end
		ledge.Parent = ledges
		local trim = Instance.new("Part")
		trim.Name = "Top"
		trim:SetAttribute("Galaxy", true)
		trim.Anchored = true
		trim.Size = V(x1 - x0, 1.2, SIDE)
		trim.Position = V((x0 + x1) / 2, top - 0.6, zc)
		trim.Color = shade(FLOOR, 0.08)
		trim.Material = Enum.Material.Plastic
		pcall(function() trim.MaterialVariant = "Studs" end)
		trim.TopSurface, trim.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
		if texture then texture:Clone().Parent = trim end
		trim.Parent = ledges
	end
	local endLedge, endTop
	for _, p in ledges:GetChildren() do
		if p:IsA("BasePart") and p.Size.Z > 200 then
			if p.Name == "EndPlateau" then endLedge = p elseif p.Name == "Top" then endTop = p end
		end
	end
	if endLedge then endLedge.Color = shade(FLOOR, -0.42) end
	if endTop then
		endTop.Color = shade(FLOOR, 0.08)
		for _, t in endTop:GetChildren() do if t:IsA("Texture") then t:Destroy() end end
		if texture then texture:Clone().Parent = endTop end
	end

	-- 4. décors
	local folder = decorRoot:FindFirstChild("Galaxy")
	if folder then folder:Destroy() end
	folder = Instance.new("Folder")
	folder.Name = "Galaxy"
	folder:SetAttribute("CenterX", zone.Position.X) -- lu par AntiLagClient
	folder:SetAttribute("HalfX", zone.Size.X / 2)
	folder.Parent = decorRoot
	for _, side in {1, -1} do
		local edge = side == 1 and OLD_NORTH or OLD_SOUTH
		local yawBase = side == 1 and 0 or 180
		local span = x1 - x0 - 8
		for row = 1, 2 do
			local depth = row == 1 and 24 or 46
			local count = math.max(1, math.floor(span / (row == 1 and 30 or 26)))
			for i = 1, count do
				local m = THEME.Big[(i * row + INDEX + (side == 1 and 0 or 2)) % #THEME.Big + 1]()
				local x = x0 + 4 + span * (i - (row == 1 and 0 or 0.15) - (row == 1 and 0.5 or 0)) / count + rng:NextNumber(-3, 3)
				fitted(m, folder, C(math.clamp(x, x0 + 6, x1 - 6), top, edge + side * (depth + rng:NextNumber(-3, 3))) * A(0, rad(yawBase + rng:NextInteger(-14, 14)), 0), THEME.BigFit)
			end
		end
		local smallCount = math.floor(span / 9)
		for i = 1, smallCount do
			local x = x0 + 3 + (x1 - x0 - 6) * (i - 0.5) / smallCount + rng:NextNumber(-2.5, 2.5)
			local z = edge + side * ((i % 3 == 0) and rng:NextNumber(30, 54) or rng:NextNumber(4, 16))
			fitted(pick(THEME.Small)(), folder, C(x, top, z) * A(0, rad(yawBase + rng:NextInteger(-40, 40)), 0), THEME.SmallFit)
		end
		for _ = 1, 7 do
			fitted(pick(THEME.Air)(), folder, C(rng:NextNumber(x0 + 6, x1 - 6), top + rng:NextNumber(22, 44), edge + side * rng:NextNumber(4, SIDE - 4)) * A(rad(rng:NextInteger(-15, 15)), rad(rng:NextInteger(0, 180)), 0))
		end
	end
	gate(folder, x0z + 3, floorY)
	-- dans la zone : grands décors près des bords, petits partout, planètes et étoiles au-dessus, poussière d'étoiles au sol
	local bigCount = math.floor(6 * WIDTH / ZONE_W + 0.5)
	for i = 1, bigCount do
		local m = THEME.Big[(i + INDEX) % #THEME.Big + 1]()
		local z = i % 2 == 0 and (OLD_NORTH - rng:NextNumber(8, 20)) or (OLD_SOUTH + rng:NextNumber(8, 20))
		fitted(m, folder, C(x0z + 14 + (WIDTH - 28) * (i - 0.5) / bigCount + rng:NextNumber(-4, 4), floorY, z) * A(0, rad(rng:NextInteger(0, 360)), 0), 15)
	end
	for _ = 1, math.floor(10 * WIDTH / ZONE_W + 0.5) do
		fitted(pick(THEME.Small)(), folder, C(rng:NextNumber(x0z + 8, x1z - 8), floorY, rng:NextNumber(OLD_SOUTH + 8, OLD_NORTH - 8)) * A(0, rad(rng:NextInteger(0, 360)), 0), 9)
	end
	for _ = 1, 6 do
		fitted(planet(rng:NextNumber(7, 13), rng:NextInteger(0, 1) == 0), folder, C(rng:NextNumber(x0z + 12, x1z - 12), floorY + rng:NextNumber(42, 60), rng:NextNumber(OLD_SOUTH + 14, OLD_NORTH - 14)) * A(rad(rng:NextInteger(-20, 20)), rad(rng:NextInteger(0, 180)), 0))
	end
	for _ = 1, 14 do
		fitted(star(rng:NextNumber(2, 4), pick({GOLDSTAR, CYAN, rgb(255, 255, 255), PINK})), folder, C(rng:NextNumber(x0z + 8, x1z - 8), floorY + rng:NextNumber(30, 62), rng:NextNumber(OLD_SOUTH + 6, OLD_NORTH - 6)) * A(0, rad(rng:NextInteger(0, 180)), 0))
	end
	local dust = prop("StarDust")
	for _ = 1, 170 do
		local s = rng:NextNumber(0.5, 1.1)
		block(dust, V(s, 0.25, s), C(rng:NextNumber(x0z + 4, x1z - 4), floorY + 0.13, rng:NextNumber(OLD_SOUTH + 3, OLD_NORTH - 3)) * A(0, rad(rng:NextInteger(0, 90)), 0), pick({rgb(255, 255, 255), CYAN, GOLDSTAR, PINK}), {neon = true})
	end
	dust.Parent = folder
	-- 5. plateau du fond : décors de la galaxie
	local width = OLD_NORTH - OLD_SOUTH + SIDE * 2
	for i = 1, 8 do
		fitted(THEME.Big[i % #THEME.Big + 1](), folder, C(x1z + rng:NextNumber(14, SIDE - 12), top, zMid - width / 2 + width * (i - 0.5) / 8) * A(0, rad(-90 + rng:NextInteger(-14, 14)), 0), THEME.BigFit)
	end
	for i = 1, 22 do
		fitted(pick(THEME.Small)(), folder, C(x1z + rng:NextNumber(4, 14), top, zMid - width / 2 + width * (i - 0.5) / 22) * A(0, rad(-90 + rng:NextInteger(-40, 40)), 0), THEME.SmallFit)
	end
	fitted(planet(26, true, PLANETS[3]), folder, C(x1z + 40, top + 48, zMid) * A(rad(10), rad(30), 0)) -- grosse planète à anneau au fond, bien visible
	for _, d in folder:GetDescendants() do
		if d:IsA("BasePart") then d.CanCollide, d.CanQuery, d.CanTouch, d.CastShadow = false, false, false, false end
	end
	table.insert(report, string.format("%s X %.1f..%.1f (width %.1f), %d decor instances", ZONE_NAME, x0z, x1z, WIDTH, #folder:GetDescendants()))
	return table.concat(report, "\n")
end
