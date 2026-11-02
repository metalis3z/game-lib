-- Construit les modèles des marteaux (un par entrée de HammerConfig.Tiers) dans ReplicatedStorage.HammerSystem.Models.
-- Blocs à studs, manche court. La pièce "Handle" est la poignée : le manche monte le long de son axe Y, la tête frappe le long de X.
-- Chaque marteau a un thème (lu dans son nom : Wooden, Stone, Inferno...) qui ajoute ses décors (cornes, ailes, cristaux,
-- runes...) et ses effets (lueur, braises, neige, fumée, étoiles...).
-- Effets lus par HammerClient :
--   Handle.TrailTop / Handle.TrailBottom + Trail "SwingTrail" (éteinte) : allumée pendant le coup
--   attribut FxColor du modèle (et de l'outil) : couleur des étincelles quand on frappe un œuf
--   pièces "Prism" : arêtes arc-en-ciel (marteaux Rainbow)
-- return function(HammerConfig) -> rapport. Peut être relancé.
local V, C, A, rad = Vector3.new, CFrame.new, CFrame.Angles, math.rad
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
local rgb = Color3.fromRGB
local TEX = {
	sparkle = "rbxasset://textures/particles/sparkles_main.dds",
	fire = "rbxasset://textures/particles/fire_main.dds",
	sparks = "rbxasset://textures/particles/fire_sparks_main.dds",
	smoke = "rbxasset://textures/particles/smoke_main.dds",
	glow = "rbxasset://textures/particles/forcefield_glow_main.dds",
}

-- thème d'un marteau : premier mot de son nom
local THEMES = {wooden = "wood", stone = "stone", iron = "iron", gold = "gold", diamond = "diamond", prismatic = "prism", mythic = "mythic",
	secret = "secret", divine = "divine", ancient = "ancient", obsidian = "obsidian", emerald = "emerald", sapphire = "sapphire",
	inferno = "inferno", frost = "frost", void = "void", thunder = "thunder", shadow = "shadow", holy = "holy", cosmos = "cosmos",
	planet = "planet", sun = "sun", spectral = "spectral", reaper = "reaper"}

local function lighter(c, k) return c:Lerp(WHITE, k) end
local function darker(c, k) return c:Lerp(BLACK, k) end
local function seq(a, b) return ColorSequence.new(a, b or a) end
local function nseq(points)
	local keys = {}
	for _, p in points do table.insert(keys, NumberSequenceKeypoint.new(p[1], p[2])) end
	return NumberSequence.new(keys)
end

local function build(tier, index)
	local model = Instance.new("Model")
	model.Name = "Tier" .. index
	local theme = THEMES[string.lower(string.match(tier.Name, "^(%a+)") or "")] or "iron"
	local glow = tier.Glow
	local function piece(name, size, cf, color, o)
		o = o or {}
		local p = Instance.new(o.wedge and "WedgePart" or "Part")
		p.Name = name
		if o.shape then p.Shape = o.shape end
		p.Size, p.CFrame, p.Color = size, cf, color
		p.Material = o.neon and Enum.Material.Neon or o.mat or Enum.Material.Plastic
		if o.studs and p.Material == Enum.Material.Plastic then pcall(function() p.MaterialVariant = "Studs" end) end
		p.Transparency = o.transparency or 0
		p.Reflectance = o.reflect or 0
		p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
		p.CanCollide, p.CanTouch, p.CanQuery, p.Massless, p.Anchored = false, false, false, true, false
		p.CastShadow = not o.neon
		p.Parent = model
		return p
	end
	local function emitter(parent, props)
		local e = Instance.new("ParticleEmitter")
		e.LightEmission, e.LockedToPart = 1, false
		for k, v in props do e[k] = v end
		e.Parent = parent
		return e
	end
	local function light(parent, color, range, brightness)
		local l = Instance.new("PointLight")
		l.Color, l.Range, l.Brightness, l.Shadows = color, range or 8, brightness or 1.2, false
		l.Parent = parent
		return l
	end

	-- matière principale selon le thème
	local METAL = {iron = true, gold = true, sapphire = true, thunder = true, holy = true, cosmos = true, mythic = true}
	local headMat = (theme == "wood" and Enum.Material.Wood) or (theme == "stone" and Enum.Material.Slate) or (theme == "frost" and Enum.Material.Ice)
		or ((theme == "obsidian" or theme == "spectral") and Enum.Material.Glass) or (METAL[theme] and Enum.Material.Metal) or Enum.Material.Plastic
	local bandMat = (theme == "wood" or theme == "stone") and Enum.Material.Fabric or Enum.Material.Metal
	local shiny = (theme == "gold" or theme == "holy") and 0.12 or 0

	---------------------------------------------------------------- manche
	local LEATHER, DARK = rgb(70, 46, 32), rgb(30, 24, 22)
	local handle = piece("Handle", V(0.46, 1.4, 0.46), C(0, 0, 0), LEATHER, {mat = Enum.Material.Leather})
	model.PrimaryPart = handle
	-- cuir enroulé en biais
	for i = 0, 4 do piece("GripWrap", V(0.52, 0.1, 0.52), C(0, -0.52 + i * 0.26, 0) * A(0, 0, rad(14)), darker(LEATHER, 0.35), {mat = Enum.Material.Leather}) end
	-- pommeau octogonal (deux blocs croisés) et sa pierre
	piece("Pommel", V(0.74, 0.32, 0.74), C(0, -0.84, 0), tier.Band, {studs = true, mat = bandMat == Enum.Material.Metal and Enum.Material.Plastic or bandMat})
	piece("Pommel", V(0.74, 0.32, 0.74), C(0, -0.84, 0) * A(0, rad(45), 0), darker(tier.Band, 0.15))
	piece("PommelTip", V(0.42, 0.24, 0.42), C(0, -1.1, 0) * A(0, rad(45), 0), lighter(tier.Band, 0.3), {reflect = shiny})
	if glow then
		local gem = piece("PommelGem", V(0.26, 0.26, 0.26), C(0, -1.26, 0) * A(rad(45), 0, rad(45)), glow, {neon = true})
		light(gem, glow, 4, 0.8)
	end
	-- garde, manche, bagues
	piece("Guard", V(0.76, 0.22, 0.76), C(0, 0.8, 0), tier.Band, {reflect = shiny})
	piece("Guard", V(0.76, 0.22, 0.76), C(0, 0.8, 0) * A(0, rad(45), 0), darker(tier.Band, 0.15))
	local shaftMat = theme == "wood" and Enum.Material.Wood or nil
	piece("Shaft", V(0.36, 1.36, 0.36), C(0, 1.56, 0), tier.Shaft, {mat = shaftMat})
	piece("Shaft", V(0.36, 1.36, 0.36), C(0, 1.56, 0) * A(0, rad(45), 0), darker(tier.Shaft, 0.08), {mat = shaftMat})
	for _, y in {1.2, 1.9} do piece("ShaftBand", V(0.46, 0.12, 0.46), C(0, y, 0), darker(tier.Shaft, 0.4), {mat = Enum.Material.Metal}) end
	piece("Collar", V(0.7, 0.32, 0.7), C(0, 2.36, 0), tier.Band, {studs = true})
	piece("Collar", V(0.7, 0.32, 0.7), C(0, 2.36, 0) * A(0, rad(45), 0), darker(tier.Band, 0.15))
	if glow then -- veine lumineuse le long du manche
		for _, sx in {-1, 1} do piece("ShaftVein", V(0.06, 1.1, 0.06), C(sx * 0.19, 1.56, 0), glow, {neon = true}).Transparency = 0.15 end
	end

	---------------------------------------------------------------- tête
	local s = 1 + (index - 1) * 0.012 -- les meilleurs marteaux ont une tête un peu plus grosse
	local headY = 3.2
	local hx, hy = 1.9 * s, 1.42 * s
	local head = piece("Head", V(hx, hy, hy), C(0, headY, 0), tier.Head, {studs = true, mat = headMat, reflect = shiny,
		transparency = theme == "obsidian" and 0.05 or (theme == "spectral" and 0.25 or 0)})
	-- liserés haut et bas (effet bombé)
	for _, sy in {-1, 1} do
		piece("Trim", V(hx * 0.86, 0.1, hy + 0.08), C(0, headY + sy * (hy / 2 + 0.03), 0), sy > 0 and lighter(tier.Head, 0.3) or darker(tier.Head, 0.3), {mat = headMat})
	end
	piece("HeadBand", V(0.56 * s, hy + 0.16, hy + 0.16), C(0, headY, 0), tier.Band, {mat = bandMat, reflect = shiny})
	for _, sx in {-1, 1} do
		local x = sx * hx / 2
		piece("Neck", V(0.24, hy * 0.86, hy * 0.86), C(x + sx * 0.1, headY, 0), darker(tier.Head, 0.3), {mat = headMat})
		piece("FaceRim", V(0.14, hy * 1.3, hy * 1.3), C(x + sx * 0.26, headY, 0), darker(tier.Face, 0.35), {mat = headMat})
		piece("Face", V(0.46, hy * 1.2, hy * 1.2), C(x + sx * 0.46, headY, 0), tier.Face, {studs = true, mat = headMat, reflect = shiny})
		local strike = piece("Strike", V(0.1, hy * 0.86, hy * 0.86), C(x + sx * 0.72, headY, 0), glow or lighter(tier.Face, 0.35), {neon = glow ~= nil, mat = headMat})
		if glow then strike.Transparency = 0.1 end
		-- rivets aux quatre coins
		for _, sy in {-1, 1} do
			for _, sz in {-1, 1} do
				piece("Rivet", V(0.18, 0.18, 0.18), C(sx * hx * 0.33, headY + sy * hy * 0.34, sz * (hy / 2 + 0.04)) * A(0, 0, rad(45)), lighter(tier.Band, 0.45), {mat = Enum.Material.Metal})
			end
		end
	end
	-- chapeau
	piece("Cap", V(0.78, 0.22, 0.78), C(0, headY + hy / 2 + 0.12, 0), tier.Band, {studs = true})
	piece("Cap", V(0.78, 0.22, 0.78), C(0, headY + hy / 2 + 0.12, 0) * A(0, rad(45), 0), darker(tier.Band, 0.15))
	local capTop = headY + hy / 2 + 0.23

	-- emblème de chaque côté de la bande (losange ; lumineux si le marteau brille)
	for _, sz in {-1, 1} do
		local z = sz * (hy / 2 + 0.1)
		piece("EmblemBack", V(0.5, 0.5, 0.08), C(0, headY, z) * A(0, 0, rad(45)), darker(tier.Band, 0.4), {mat = Enum.Material.Metal})
		local gem = piece("Gem", V(0.34, 0.34, 0.12), C(0, headY, z + sz * 0.05) * A(0, 0, rad(45)), glow or lighter(tier.Band, 0.4), {neon = glow ~= nil})
		if glow then light(gem, glow, 9, 1.3) end
	end

	---------------------------------------------------------------- décors du thème
	local function crystals(color, list, o) -- {position, taille, inclinaison}
		o = o or {}
		for _, c in list do
			local cf = C(c[1]) * A(rad(c[3] and c[3].X or 0), rad(c[3] and c[3].Y or 0), rad(c[3] and c[3].Z or 0))
			piece("Crystal", V(c[2], c[2] * 2.2, c[2]), cf * A(0, rad(45), 0), color, {mat = Enum.Material.Glass, transparency = o.transparency or 0.15, reflect = 0.1})
			piece("CrystalTip", V(c[2] * 0.6, c[2] * 0.6, c[2] * 0.6), cf * C(0, c[2] * 1.15, 0) * A(rad(45), rad(45), 0), lighter(color, 0.4), {mat = Enum.Material.Glass, transparency = o.transparency or 0.15})
		end
	end
	local function horns(color, tip)
		for _, sz in {-1, 1} do
			local base = C(0, capTop - 0.05, sz * 0.42)
			piece("Horn", V(0.3, 0.6, 0.3), base * A(rad(-sz * 28), 0, 0) * C(0, 0.3, 0), color)
			piece("Horn", V(0.22, 0.5, 0.22), base * A(rad(-sz * 28), 0, 0) * C(0, 0.6, 0) * A(rad(-sz * 30), 0, 0) * C(0, 0.22, 0), darker(color, 0.15))
			piece("HornTip", V(0.14, 0.34, 0.14), base * A(rad(-sz * 28), 0, 0) * C(0, 0.6, 0) * A(rad(-sz * 30), 0, 0) * C(0, 0.5, 0) * A(rad(-sz * 25), 0, 0) * C(0, 0.12, 0), tip or lighter(color, 0.3), {neon = tip ~= nil})
		end
	end
	local function wings(color, edge)
		for _, sz in {-1, 1} do
			for i = 0, 3 do -- quatre plumes en éventail, de plus en plus longues
				local len = 0.7 + i * 0.28
				local cf = C(0, headY + 0.1, sz * (hy / 2 + 0.12)) * A(rad(sz * (20 + i * 22)), 0, 0) * C(0, len / 2, sz * 0.05)
				piece("Feather", V(0.42 - i * 0.04, len, 0.1), cf, i % 2 == 0 and color or darker(color, 0.06), {studs = true})
				piece("FeatherEdge", V(0.06, len * 0.9, 0.12), cf * C(0.21 - i * 0.02, 0, 0), edge or lighter(color, 0.2), {neon = edge ~= nil})
			end
		end
	end
	local function halo(color, y, radius)
		for i = 0, 11 do
			local a = i / 12 * math.pi * 2
			piece("Halo", V(radius * 0.56, 0.1, 0.12), C(math.cos(a) * radius, y, math.sin(a) * radius) * A(0, -a + math.pi / 2, 0), color, {neon = true})
		end
	end
	local function runes(color) -- traits lumineux gravés sur les côtés de la tête
		for _, sz in {-1, 1} do
			for _, sx in {-1, 1} do
				local z = sz * (hy / 2 + 0.01)
				piece("Rune", V(0.08, hy * 0.6, 0.04), C(sx * hx * 0.3, headY, z), color, {neon = true})
				piece("Rune", V(0.34, 0.08, 0.04), C(sx * hx * 0.3, headY + hy * 0.18, z), color, {neon = true})
				piece("Rune", V(0.08, 0.3, 0.04), C(sx * hx * 0.3 + sx * 0.12, headY - hy * 0.12, z) * A(0, 0, rad(sx * 35)), color, {neon = true})
			end
		end
	end
	local function spikes(color, count)
		for i = 1, count do
			local a = (i - 0.5) / count * math.pi * 2
			piece("Spike", V(0.18, 0.4, 0.18), C(0, 2.36, 0) * A(0, a, 0) * C(0, 0, 0.42) * A(rad(70), 0, 0) * A(0, rad(45), 0), color, {mat = Enum.Material.Metal})
		end
	end
	local function bolt(color, sz) -- éclair en zigzag
		local z = sz * (hy / 2 + 0.12)
		piece("Bolt", V(0.14, 0.5, 0.06), C(0.15, headY + 0.3, z) * A(0, 0, rad(-25)), color, {neon = true})
		piece("Bolt", V(0.4, 0.12, 0.06), C(0.02, headY + 0.06, z), color, {neon = true})
		piece("Bolt", V(0.14, 0.55, 0.06), C(-0.12, headY - 0.22, z) * A(0, 0, rad(-25)), color, {neon = true})
	end

	if theme == "wood" then
		for _, sx in {-1, 1} do for _, sy in {-1, 1} do for _, sz in {-1, 1} do
			piece("Nail", V(0.12, 0.12, 0.12), C(sx * (hx / 2 + 0.71), headY + sy * hy * 0.32, sz * hy * 0.32), rgb(70, 70, 76), {mat = Enum.Material.Metal})
		end end end
		for i = -1, 1 do piece("Rope", V(0.58 * s, 0.1, hy + 0.2), C(0, headY + i * 0.4, 0), rgb(200, 170, 110), {mat = Enum.Material.Fabric}) end
	elseif theme == "stone" then
		for _, c in {{V(0.5, 0.75, 0.62), V(0, 0, 30)}, {V(-0.45, 0.72, -0.6), V(0, 0, -25)}, {V(0.6, -0.72, -0.5), V(0, 0, 20)}, {V(-0.3, -0.74, 0.6), V(0, 0, -15)}} do
			piece("Chip", V(0.3, 0.22, 0.26), C(c[1].X * s, headY + c[1].Y * s, c[1].Z * s) * A(0, 0, rad(c[2].Z)), darker(tier.Head, 0.2), {mat = Enum.Material.Rock})
		end
		for i = -1, 1, 2 do piece("Rope", V(0.6 * s, 0.1, hy + 0.2), C(0, headY + i * 0.3, 0), rgb(190, 160, 100), {mat = Enum.Material.Fabric}) end
	elseif theme == "iron" then
		spikes(lighter(tier.Band, 0.3), 4)
	elseif theme == "gold" then
		crystals(rgb(255, 80, 90), {{V(0, capTop + 0.3, 0), 0.32}})
	elseif theme == "diamond" then
		crystals(rgb(170, 240, 255), {{V(0, capTop + 0.42, 0), 0.4}, {V(0.38, capTop + 0.22, 0.12), 0.24, V(0, 0, -30)}, {V(-0.38, capTop + 0.22, -0.12), 0.24, V(0, 0, 30)}})
	elseif theme == "prism" or theme == "void" then
		for _, sx in {-1, 1} do
			piece("Prism", V(0.12, hy * 1.36, hy * 1.36), C(sx * (hx / 2 + 0.56), headY, 0), WHITE, {neon = true}).Transparency = 0.2
		end
		piece("Prism", V(0.42, 1.2, 0.16), C(0, 1.56, 0), WHITE, {neon = true})
		if theme == "prism" then
			crystals(rgb(240, 170, 255), {{V(0, capTop + 0.4, 0), 0.36}, {V(0.34, capTop + 0.18, 0), 0.22, V(0, 0, -35)}, {V(-0.34, capTop + 0.18, 0), 0.22, V(0, 0, 35)}})
		else -- void : un orbe sombre flotte au-dessus de la tête
			local orb = piece("VoidOrb", V(0.7, 0.7, 0.7), C(0, capTop + 0.55, 0), rgb(40, 0, 60), {shape = Enum.PartType.Ball, mat = Enum.Material.Glass, transparency = 0.1})
			piece("VoidCore", V(0.38, 0.38, 0.38), C(0, capTop + 0.55, 0), glow, {shape = Enum.PartType.Ball, neon = true})
			emitter(orb, {Texture = TEX.glow, Color = seq(rgb(190, 80, 255), rgb(60, 0, 120)), Rate = 8, Lifetime = NumberRange.new(0.6, 1), Speed = NumberRange.new(0.2, 0.6),
				Size = nseq({{0, 0.9}, {1, 0}}), Transparency = nseq({{0, 0.4}, {1, 1}}), RotSpeed = NumberRange.new(-120, 120), Rotation = NumberRange.new(0, 360)})
		end
	elseif theme == "mythic" or theme == "inferno" then
		horns(theme == "inferno" and rgb(50, 20, 15) or rgb(240, 220, 190), glow)
		runes(glow) -- fissures de lave
		emitter(head, {Texture = TEX.fire, Color = seq(rgb(255, 200, 80), rgb(255, 60, 20)), Rate = theme == "inferno" and 14 or 7, Lifetime = NumberRange.new(0.35, 0.6),
			Speed = NumberRange.new(1, 2.5), Acceleration = V(0, 4, 0), Size = nseq({{0, 0.7}, {1, 0}}), Transparency = nseq({{0, 0.3}, {1, 1}}), SpreadAngle = Vector2.new(20, 20),
			EmissionDirection = Enum.NormalId.Top, RotSpeed = NumberRange.new(-90, 90), Rotation = NumberRange.new(0, 360)})
		emitter(head, {Texture = TEX.sparks, Color = seq(rgb(255, 170, 60)), Rate = 5, Lifetime = NumberRange.new(0.6, 1), Speed = NumberRange.new(1.5, 3), Acceleration = V(0, 3, 0),
			Size = nseq({{0, 0.25}, {1, 0}}), SpreadAngle = Vector2.new(60, 60), EmissionDirection = Enum.NormalId.Top})
	elseif theme == "secret" or theme == "shadow" then
		runes(glow)
		spikes(darker(tier.Head, 0.2), 6)
		for _, sz in {-1, 1} do -- yeux rouges sur la bande
			for _, sx in {-1, 1} do piece("Eye", V(0.1, 0.1, 0.16), C(sx * 0.14, headY + 0.42, sz * (hy / 2 + 0.12)), glow, {neon = true}) end
		end
		emitter(head, {Texture = TEX.smoke, Color = seq(rgb(20, 10, 25)), LightEmission = 0, Rate = 6, Lifetime = NumberRange.new(0.8, 1.3), Speed = NumberRange.new(0.3, 0.9),
			Acceleration = V(0, 1.5, 0), Size = nseq({{0, 0.6}, {1, 1.6}}), Transparency = nseq({{0, 0.55}, {1, 1}}), RotSpeed = NumberRange.new(-40, 40), Rotation = NumberRange.new(0, 360)})
	elseif theme == "divine" or theme == "holy" then
		wings(theme == "holy" and rgb(255, 250, 235) or WHITE, glow)
		halo(glow, capTop + 0.55, 0.5)
		emitter(head, {Texture = TEX.sparkle, Color = seq(rgb(255, 250, 210), glow), Rate = 8, Lifetime = NumberRange.new(0.7, 1.2), Speed = NumberRange.new(0.4, 1),
			Acceleration = V(0, 1.2, 0), Size = nseq({{0, 0}, {0.3, 0.35}, {1, 0}}), SpreadAngle = Vector2.new(180, 180)})
	elseif theme == "ancient" or theme == "emerald" then
		runes(glow or rgb(80, 255, 160))
		local green = theme == "ancient" and rgb(70, 160, 70) or rgb(60, 200, 110)
		for i = 0, 5 do -- lierre qui s'enroule autour du manche
			piece("Vine", V(0.12, 0.34, 0.12), C(0, 1.0 + i * 0.24, 0) * A(0, rad(i * 70), 0) * C(0.22, 0, 0) * A(0, 0, rad(30)), green, {mat = Enum.Material.Grass})
			if i % 2 == 0 then piece("Leaf", V(0.24, 0.05, 0.16), C(0, 1.05 + i * 0.24, 0) * A(0, rad(i * 70), 0) * C(0.34, 0, 0) * A(0, 0, rad(-20)), lighter(green, 0.2)) end
		end
		if theme == "emerald" then
			crystals(rgb(70, 230, 130), {{V(0, capTop + 0.4, 0), 0.36}, {V(0.32, capTop + 0.2, 0.1), 0.22, V(0, 0, -30)}, {V(-0.32, capTop + 0.2, -0.1), 0.22, V(0, 0, 30)}})
		end
	elseif theme == "obsidian" then
		for _, c in {{V(0, capTop + 0.4, 0), 0.34}, {V(0.5, headY + hy * 0.62, 0.3), 0.2, V(0, 0, -35)}, {V(-0.5, headY + hy * 0.62, -0.3), 0.2, V(0, 0, 35)}, {V(0.2, headY - hy * 0.7, 0.4), 0.18, V(180, 0, 20)}} do
			crystals(rgb(45, 35, 60), {c}, {transparency = 0.05})
		end
		runes(rgb(170, 90, 255))
	elseif theme == "sapphire" then
		crystals(rgb(70, 130, 255), {{V(0, capTop + 0.42, 0), 0.38}, {V(0.36, capTop + 0.2, 0), 0.22, V(0, 0, -32)}, {V(-0.36, capTop + 0.2, 0), 0.22, V(0, 0, 32)}})
	elseif theme == "frost" then
		crystals(rgb(190, 240, 255), {{V(0, capTop + 0.44, 0), 0.34}, {V(0.55, headY + hy * 0.6, 0), 0.22, V(0, 0, -40)}, {V(-0.55, headY + hy * 0.6, 0), 0.22, V(0, 0, 40)},
			{V(0, headY, hy / 2 + 0.3), 0.18, V(80, 0, 0)}, {V(0, headY, -hy / 2 - 0.3), 0.18, V(-80, 0, 0)}}, {transparency = 0.25})
		emitter(head, {Texture = TEX.sparkle, Color = seq(WHITE, rgb(170, 230, 255)), Rate = 10, Lifetime = NumberRange.new(0.8, 1.4), Speed = NumberRange.new(0.3, 0.8),
			Acceleration = V(0, -1.5, 0), Size = nseq({{0, 0.25}, {1, 0}}), SpreadAngle = Vector2.new(180, 180), RotSpeed = NumberRange.new(-60, 60)})
	elseif theme == "thunder" then
		bolt(glow, 1)
		bolt(glow, -1)
		emitter(head, {Texture = TEX.sparks, Color = seq(rgb(255, 255, 200), rgb(255, 220, 60)), Rate = 9, Lifetime = NumberRange.new(0.12, 0.25), Speed = NumberRange.new(4, 8),
			Size = nseq({{0, 0.3}, {1, 0}}), SpreadAngle = Vector2.new(180, 180)})
	elseif theme == "planet" then
		-- tête "ciel de nuit" étoilée, et une grosse planète à anneaux posée dessus avec sa lune
		for i = 1, 14 do -- étoiles incrustées sur la tête
			local sx, sz = (i % 2 == 0) and 1 or -1, (i % 3 == 0) and 1 or -1
			piece("Star", V(0.09, 0.09, 0.09), C((math.random() - 0.5) * hx * 0.8, headY + (math.random() - 0.5) * hy * 0.8, sz * (hy / 2 + 0.02)) * A(0, 0, rad(45)), WHITE, {neon = true})
		end
		local py = capTop + 0.75
		local planet = piece("Planet", V(1.05, 1.05, 1.05), C(0, py, 0), rgb(90, 120, 255), {shape = Enum.PartType.Ball, mat = Enum.Material.SmoothPlastic})
		piece("PlanetBand", V(1.07, 0.16, 1.07), C(0, py + 0.18, 0) * A(rad(8), 0, rad(90)), rgb(160, 120, 255), {shape = Enum.PartType.Cylinder, mat = Enum.Material.SmoothPlastic}).Size = V(0.16, 1.07, 1.07)
		piece("PlanetGlow", V(1.3, 1.3, 1.3), C(0, py, 0), glow, {shape = Enum.PartType.Ball, neon = true, transparency = 0.82})
		for i = 0, 23 do -- l'anneau incliné, de deux couleurs
			local a = i / 24 * math.pi * 2
			piece("Ring", V(0.28, 0.05, 0.16), C(0, py, 0) * A(rad(22), 0, rad(-14)) * C(math.cos(a) * 0.95, 0, math.sin(a) * 0.95) * A(0, -a + math.pi / 2, 0),
				i % 3 == 0 and rgb(255, 210, 140) or rgb(140, 220, 255), {neon = true})
		end
		piece("Moon", V(0.26, 0.26, 0.26), C(0.85, py + 0.45, 0.25), rgb(225, 225, 240), {shape = Enum.PartType.Ball, mat = Enum.Material.Slate})
		light(planet, glow, 12, 1.6)
		emitter(planet, {Texture = TEX.sparkle, Color = seq(WHITE, rgb(160, 200, 255)), Rate = 12, Lifetime = NumberRange.new(0.8, 1.5), Speed = NumberRange.new(0.3, 0.9),
			Size = nseq({{0, 0}, {0.4, 0.3}, {1, 0}}), SpreadAngle = Vector2.new(180, 180), RotSpeed = NumberRange.new(-60, 60)})
		emitter(head, {Texture = TEX.glow, Color = seq(rgb(140, 90, 255), rgb(60, 140, 255)), Rate = 4, Lifetime = NumberRange.new(1, 1.6), Speed = NumberRange.new(0.1, 0.4),
			Size = nseq({{0, 1.2}, {1, 2.4}}), Transparency = nseq({{0, 0.75}, {1, 1}}), RotSpeed = NumberRange.new(-30, 30), Rotation = NumberRange.new(0, 360)})
	elseif theme == "sun" then
		-- tête de feu, et un soleil brûlant posé dessus : boule lumineuse, couronne de rayons, flammes et éruptions
		runes(rgb(255, 240, 150))
		local py = capTop + 0.8
		local sun = piece("Sun", V(1.15, 1.15, 1.15), C(0, py, 0), rgb(255, 210, 60), {shape = Enum.PartType.Ball, neon = true})
		piece("SunCore", V(0.8, 0.8, 0.8), C(0, py, 0), rgb(255, 250, 210), {shape = Enum.PartType.Ball, neon = true})
		piece("SunHalo", V(1.6, 1.6, 1.6), C(0, py, 0), rgb(255, 160, 40), {shape = Enum.PartType.Ball, neon = true, transparency = 0.78})
		for i = 0, 11 do -- rayons en pointe tout autour
			local a = i / 12 * math.pi * 2
			local len = i % 2 == 0 and 0.55 or 0.38
			piece("SunRay", V(0.16, len, 0.16), C(0, py, 0) * A(0, 0, a) * C(0, 0.62 + len / 2, 0) * A(0, rad(45), 0), i % 2 == 0 and rgb(255, 230, 90) or rgb(255, 140, 40), {neon = true})
		end
		light(sun, rgb(255, 190, 70), 18, 3)
		emitter(sun, {Texture = TEX.fire, Color = seq(rgb(255, 240, 150), rgb(255, 90, 20)), Rate = 22, Lifetime = NumberRange.new(0.4, 0.7), Speed = NumberRange.new(0.6, 1.6),
			Size = nseq({{0, 0.9}, {1, 0}}), Transparency = nseq({{0, 0.2}, {1, 1}}), SpreadAngle = Vector2.new(180, 180), RotSpeed = NumberRange.new(-120, 120), Rotation = NumberRange.new(0, 360)})
		emitter(sun, {Texture = TEX.glow, Color = seq(rgb(255, 200, 80)), Rate = 4, Lifetime = NumberRange.new(0.9, 0.9), Speed = NumberRange.new(0, 0), LockedToPart = true,
			Size = nseq({{0, 3}, {0.5, 3.6}, {1, 3}}), Transparency = nseq({{0, 1}, {0.5, 0.7}, {1, 1}})})
		emitter(sun, {Texture = TEX.sparks, Color = seq(rgb(255, 230, 120), rgb(255, 120, 30)), Rate = 10, Lifetime = NumberRange.new(0.5, 0.9), Speed = NumberRange.new(2, 4),
			Size = nseq({{0, 0.3}, {1, 0}}), SpreadAngle = Vector2.new(180, 180), Acceleration = V(0, -2, 0)})
		emitter(head, {Texture = TEX.fire, Color = seq(rgb(255, 200, 80), rgb(255, 60, 20)), Rate = 8, Lifetime = NumberRange.new(0.35, 0.6),
			Speed = NumberRange.new(1, 2), Acceleration = V(0, 4, 0), Size = nseq({{0, 0.6}, {1, 0}}), Transparency = nseq({{0, 0.3}, {1, 1}}), SpreadAngle = Vector2.new(20, 20),
			EmissionDirection = Enum.NormalId.Top, RotSpeed = NumberRange.new(-90, 90), Rotation = NumberRange.new(0, 360)})
	elseif theme == "spectral" then
		-- marteau fantôme : tête de verre, runes cyan, une lanterne d'âme posée dessus, deux âmes qui flottent, brume qui retombe
		runes(glow)
		local ly = capTop + 0.5
		local IRON = rgb(40, 42, 54)
		for _, sx in {-1, 1} do for _, sz in {-1, 1} do
			piece("LanternPost", V(0.08, 0.66, 0.08), C(sx * 0.27, ly, sz * 0.27), IRON, {mat = Enum.Material.Metal})
		end end
		piece("LanternTop", V(0.72, 0.12, 0.72), C(0, ly + 0.38, 0), IRON, {mat = Enum.Material.Metal})
		piece("LanternTop", V(0.4, 0.14, 0.4), C(0, ly + 0.5, 0) * A(0, rad(45), 0), tier.Band)
		piece("LanternBase", V(0.72, 0.1, 0.72), C(0, ly - 0.36, 0), IRON, {mat = Enum.Material.Metal})
		local flame = piece("SoulFlame", V(0.28, 0.44, 0.28), C(0, ly - 0.02, 0) * A(0, rad(45), 0), glow, {neon = true})
		piece("LanternGlass", V(0.5, 0.62, 0.5), C(0, ly, 0), rgb(170, 255, 240), {mat = Enum.Material.Glass, transparency = 0.6})
		light(flame, glow, 10, 1.8)
		for i, p in {V(1.2, headY + 0.55, 0.45), V(-1.25, headY - 0.25, -0.5)} do
			piece("Soul", V(0.24, 0.24, 0.24), C(p) * A(rad(45), rad(45), 0), i == 1 and glow or rgb(170, 110, 255), {neon = true})
			piece("SoulShell", V(0.42, 0.42, 0.42), C(p), rgb(200, 255, 245), {mat = Enum.Material.Glass, transparency = 0.6})
		end
		emitter(flame, {Texture = TEX.fire, Color = seq(rgb(170, 255, 240), rgb(120, 90, 255)), Rate = 12, Lifetime = NumberRange.new(0.35, 0.6), Speed = NumberRange.new(0.5, 1.2),
			Size = nseq({{0, 0.35}, {1, 0}}), Transparency = nseq({{0, 0.2}, {1, 1}}), SpreadAngle = Vector2.new(10, 10), EmissionDirection = Enum.NormalId.Top, Rotation = NumberRange.new(0, 360)})
		emitter(head, {Texture = TEX.smoke, Color = seq(rgb(110, 255, 230), rgb(120, 80, 220)), LightEmission = 0.6, Rate = 6, Lifetime = NumberRange.new(1, 1.6), Speed = NumberRange.new(0.2, 0.6),
			Acceleration = V(0, -0.8, 0), Size = nseq({{0, 0.7}, {1, 1.7}}), Transparency = nseq({{0, 0.6}, {1, 1}}), RotSpeed = NumberRange.new(-40, 40), Rotation = NumberRange.new(0, 360)})
	elseif theme == "reaper" then
		-- marteau du Reaper : un crâne sur chaque face (yeux violets), une lame de faux qui sort du chapeau, piques d'os, flammes d'âme
		local BONE, VOID = rgb(228, 222, 200), rgb(14, 12, 20)
		for _, p in model:GetChildren() do
			if p:IsA("BasePart") and p.Name == "Strike" then p.Color, p.Material, p.Transparency = BONE, Enum.Material.Plastic, 0 end
		end
		for _, sx in {-1, 1} do
			local x = sx * (hx / 2 + 0.79)
			for _, sz in {-1, 1} do
				piece("SkullEye", V(0.05, 0.3, 0.3), C(x, headY + 0.14, sz * 0.27), VOID)
				piece("SkullPupil", V(0.06, 0.13, 0.13), C(x + sx * 0.01, headY + 0.14, sz * 0.27), glow, {neon = true})
			end
			piece("SkullNose", V(0.05, 0.15, 0.15), C(x, headY - 0.12, 0) * A(rad(45), 0, 0), VOID)
			piece("SkullTeeth", V(0.05, 0.07, 0.62), C(x, headY - 0.38, 0), VOID)
		end
		spikes(BONE, 6)
		-- la lame de faux : un petit mât sur le chapeau, puis une lame courbe vers l'avant, tranchant lumineux
		piece("BladeMount", V(0.18, 0.5, 0.18), C(0, capTop + 0.25, 0), rgb(60, 54, 76), {mat = Enum.Material.Metal})
		local p = V(0, capTop + 0.5, 0.05)
		for i = 0, 3 do
			local theta = rad(i * 22)
			local len, w = 0.46, 0.36 - i * 0.07
			local dir = V(0, -math.sin(theta), math.cos(theta))
			local cf = C(p + dir * len / 2) * A(theta, 0, 0)
			piece("ScytheBlade", V(0.08, w, len + 0.04), cf, rgb(170, 178, 198), {mat = Enum.Material.Metal})
			piece("ScytheEdge", V(0.1, 0.05, len + 0.04), cf * C(0, -w / 2 - 0.02, 0), glow, {neon = true})
			p += dir * len
		end
		emitter(head, {Texture = TEX.fire, Color = seq(rgb(200, 150, 255), rgb(110, 255, 230)), Rate = 10, Lifetime = NumberRange.new(0.35, 0.6), Speed = NumberRange.new(1, 2),
			Acceleration = V(0, 3, 0), Size = nseq({{0, 0.55}, {1, 0}}), Transparency = nseq({{0, 0.3}, {1, 1}}), SpreadAngle = Vector2.new(25, 25),
			EmissionDirection = Enum.NormalId.Top, RotSpeed = NumberRange.new(-90, 90), Rotation = NumberRange.new(0, 360)})
		emitter(head, {Texture = TEX.smoke, Color = seq(rgb(30, 20, 50)), LightEmission = 0, Rate = 5, Lifetime = NumberRange.new(0.8, 1.3), Speed = NumberRange.new(0.3, 0.8),
			Acceleration = V(0, 1.2, 0), Size = nseq({{0, 0.6}, {1, 1.5}}), Transparency = nseq({{0, 0.55}, {1, 1}}), RotSpeed = NumberRange.new(-40, 40), Rotation = NumberRange.new(0, 360)})
	elseif theme == "cosmos" then
		-- anneau de planète incliné autour de la tête et petites planètes
		for i = 0, 15 do
			local a = i / 16 * math.pi * 2
			piece("Ring", V(0.36, 0.06, 0.12), C(0, headY, 0) * A(rad(20), 0, rad(-15)) * C(math.cos(a) * 1.35 * s, 0, math.sin(a) * 1.35 * s) * A(0, -a + math.pi / 2, 0),
				i % 2 == 0 and glow or rgb(255, 200, 80), {neon = true})
		end
		piece("Planet", V(0.34, 0.34, 0.34), C(0.9, capTop + 0.4, 0.3), rgb(255, 150, 80), {shape = Enum.PartType.Ball})
		piece("Planet", V(0.22, 0.22, 0.22), C(-0.7, capTop + 0.25, -0.4), rgb(120, 200, 255), {shape = Enum.PartType.Ball})
		emitter(head, {Texture = TEX.sparkle, Color = seq(WHITE, glow), Rate = 10, Lifetime = NumberRange.new(0.8, 1.4), Speed = NumberRange.new(0.2, 0.6),
			Size = nseq({{0, 0}, {0.4, 0.3}, {1, 0}}), SpreadAngle = Vector2.new(180, 180)})
	end

	---------------------------------------------------------------- lueur, étincelles et traînée de coup
	if glow then
		light(head, glow, 10, 1.4)
		emitter(head, {Texture = TEX.sparkle, Color = seq(glow, lighter(glow, 0.5)), Rate = index >= 5 and 7 or 4, Lifetime = NumberRange.new(0.5, 0.9), Speed = NumberRange.new(0.6, 1.6),
			SpreadAngle = Vector2.new(180, 180), Size = nseq({{0, 0}, {0.3, 0.34}, {1, 0}})})
		-- halo doux autour de la tête
		emitter(head, {Texture = TEX.glow, Color = seq(glow), Rate = 3, Lifetime = NumberRange.new(0.8, 0.8), Speed = NumberRange.new(0, 0), LockedToPart = true,
			Size = nseq({{0, 2.6 * s}, {0.5, 2.9 * s}, {1, 2.6 * s}}), Transparency = nseq({{0, 1}, {0.5, 0.82}, {1, 1}})})
	end
	local fx = glow or lighter(tier.Face, 0.25)
	model:SetAttribute("FxColor", fx)
	local top = Instance.new("Attachment")
	top.Name, top.Position = "TrailTop", V(0, headY + 0.2, 0)
	top.Parent = handle
	local bottom = Instance.new("Attachment")
	bottom.Name, bottom.Position = "TrailBottom", V(0, 2.0, 0)
	bottom.Parent = handle
	local trail = Instance.new("Trail")
	trail.Name = "SwingTrail"
	trail.Attachment0, trail.Attachment1 = top, bottom
	trail.Enabled = false -- allumée par HammerClient pendant le coup
	trail.Lifetime = 0.2
	trail.MinLength = 0
	trail.FaceCamera = false
	trail.LightEmission = glow and 1 or 0.4
	trail.Color = tier.Rainbow and ColorSequence.new({ColorSequenceKeypoint.new(0, rgb(255, 90, 90)), ColorSequenceKeypoint.new(0.5, rgb(90, 220, 255)), ColorSequenceKeypoint.new(1, rgb(220, 110, 255))})
		or seq(lighter(fx, 0.5), fx)
	trail.Transparency = nseq({{0, glow and 0.25 or 0.5}, {1, 1}})
	trail.WidthScale = nseq({{0, 1}, {1, 0.3}})
	trail.Parent = handle

	for _, p in model:GetChildren() do
		if p:IsA("BasePart") and p ~= handle then
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
	model:ScaleTo(0.82) -- taille en main : environ 4,5 studs du pommeau au chapeau
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
		if p:IsA("BasePart") and p ~= handle then
			local w = Instance.new("Weld")
			w.Part0, w.Part1 = handle, p
			w.C0 = handle.CFrame:ToObjectSpace(p.CFrame)
			w.Parent = p
		end
	end
	return model
end

return function(HammerConfig, only)
	local system = game:GetService("ReplicatedStorage"):WaitForChild("HammerSystem")
	-- only = {21, 22} : ne construit que ces marteaux, dans le dossier existant (les autres modèles ne bougent pas)
	if only then
		local folder = system:WaitForChild("Models")
		for _, index in only do
			local old = folder:FindFirstChild("Tier" .. index)
			if old then old:Destroy() end
			build(HammerConfig.Tiers[index], index).Parent = folder
		end
		return #only .. " hammer models built"
	end
	local folder = Instance.new("Folder")
	folder.Name = "Models"
	for index, tier in HammerConfig.Tiers do build(tier, index).Parent = folder end
	buildBat().Parent = folder
	local old = system:FindFirstChild("Models")
	if old then old:Destroy() end
	folder.Parent = system
	return #HammerConfig.Tiers .. " hammer models and the bat built"
end
