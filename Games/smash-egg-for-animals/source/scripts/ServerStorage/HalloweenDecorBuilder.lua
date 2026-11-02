-- Outil d'édition (pas utilisé en jeu) : citrouilles d'Halloween et décors en studs.
-- M.Pumpkin({Radius, Face = "Jack" | "Scary" | "Cute" | "None", Hat, Seed, Light}) -> Model posé au sol (pivot = bas, face vers +Z)
local M = {}
local rad = math.rad
local function rgb(r, g, b) return Color3.fromRGB(r, g, b) end
local function shade(c, f)
	if f >= 1 then return c:Lerp(Color3.new(1, 1, 1), f - 1) end
	return Color3.new(c.R * f, c.G * f, c.B * f)
end
M.rgb, M.shade = rgb, shade
local INK = rgb(30, 22, 40)

-- nouveau modèle avec une base invisible (pivot au sol)
local function newModel(name)
	local model = Instance.new("Model")
	model.Name = name
	local base = Instance.new("Part")
	base.Name = "Base"
	base.Size = Vector3.new(1, 0.2, 1)
	base.Transparency = 1
	base.Anchored = true
	base.CanCollide, base.CanQuery, base.CanTouch = false, false, false
	base.CFrame = CFrame.new()
	base.Parent = model
	model.PrimaryPart = base
	return model
end

local function part(model, size, cf, color, opts)
	opts = opts or {}
	local p = Instance.new("Part")
	p.Name = opts.Name or "Stud"
	p.Size = size
	p.CFrame = cf
	p.Color = color
	p.Material = opts.Neon and Enum.Material.Neon or (opts.Material or Enum.Material.Plastic)
	p.Transparency = opts.Transparency or 0
	p.TopSurface = opts.Studs == false and Enum.SurfaceType.Smooth or Enum.SurfaceType.Studs
	p.BottomSurface = Enum.SurfaceType.Inlet
	p.Anchored = true
	p.CanCollide = opts.Collide == true
	p.CanQuery = opts.Collide == true
	p.CanTouch = false
	p.CastShadow = not opts.Neon
	p.Parent = model
	return p
end
M.part = part

-- chaîne de segments (tige, vrille...) ; +Y du start = sens de la pousse
local function chain(model, start, steps)
	local cf = start
	for _, st in steps do
		local len, thick = st[1], st[2]
		part(model, Vector3.new(thick, len + thick * 0.35, st.Depth or thick), cf * CFrame.new(0, len / 2, 0), st[5])
		cf = cf * CFrame.new(0, len, 0) * CFrame.Angles(rad(st[3] or 0), 0, rad(st[4] or 0))
	end
	return cf
end

---------------------------------------------------------------- CITROUILLE
local ORANGES = {
	{rgb(255, 128, 18), rgb(215, 85, 8)},   -- orange vif
	{rgb(255, 150, 40), rgb(225, 100, 20)}, -- orange clair
	{rgb(240, 105, 15), rgb(190, 65, 5)},   -- orange foncé
}

function M.Pumpkin(opts)
	opts = opts or {}
	local R = opts.Radius or 4
	local rng = Random.new(opts.Seed or 1)
	local pal = opts.Palette or ORANGES[rng:NextInteger(1, #ORANGES)]
	local light, dark = pal[1], pal[2]
	local model = newModel("Pumpkin")
	local H = R * 0.74              -- demi-hauteur (citrouille un peu écrasée)
	local center = CFrame.new(0, H, 0)
	local function radiusAt(y) -- y relatif au centre
		local f = math.clamp(math.abs(y) / H, 0, 1)
		return R * math.sqrt(math.max(0.06, 1 - f ^ 2.3))
	end
	local sectors = R >= 3 and 12 or 8
	local layers = R >= 3 and 8 or 6
	local t = 2 * H / layers
	local half = math.pi / sectors
	-- coque : tranches verticales = côtes de la citrouille (bossues et creusées en alternance)
	for i = 1, layers do
		local yc = -H + (i - 0.5) * t
		local r = radiusAt(yc)
		local tone = light:Lerp(dark, 1 - (i - 0.5) / layers) -- plus clair en haut
		for k = 0, sectors - 1 do
			local groove = k % 2 == 1
			local rr = groove and r * 0.93 or r
			local depth = rr * 0.85
			local width = 2 * rr * math.tan(half) * 1.08
			part(model, Vector3.new(width, t + 0.02, depth), center * CFrame.Angles(0, k * 2 * half, 0) * CFrame.new(0, yc, rr - depth / 2), groove and shade(tone, 0.8) or tone)
		end
	end
	-- dessus et dessous
	local capR = radiusAt(H - t * 0.5) * 0.85
	for k = 0, 1 do
		part(model, Vector3.new(2 * capR, t * 0.5, 2 * capR * math.tan(math.pi / 8) * 2.4), center * CFrame.new(0, H - t * 0.1, 0) * CFrame.Angles(0, k * math.pi / 2, 0), shade(light, 0.95))
		part(model, Vector3.new(2 * capR, t * 0.4, 2 * capR * math.tan(math.pi / 8) * 2.4), center * CFrame.new(0, -H + t * 0.1, 0) * CFrame.Angles(0, k * math.pi / 2, 0), dark, {Studs = false})
	end

	-- plaque collée sur la face avant (x, y relatifs au centre ; d = épaisseur qui dépasse)
	local function facePlate(x, y, w, h, d, color, o)
		o = o or {}
		local r = radiusAt(y)
		local ang = math.asin(math.clamp(x / r, -0.95, 0.95))
		local cf = center * CFrame.new(0, y, 0) * CFrame.Angles(0, ang, 0) * CFrame.new(0, 0, r + d / 2 - 0.08 * R / 4) * CFrame.Angles(0, 0, rad(o.Rot or 0))
		return part(model, Vector3.new(w, h, d), cf, color, {Neon = o.Neon, Studs = false})
	end

	local face = opts.Face or "Jack"
	local u = R / 4 -- unité : un visage dessiné pour une citrouille de rayon 4
	local RIM = rgb(60, 24, 8)
	local GLOW = opts.Glow or rgb(255, 160, 30)
	local GLOW2 = opts.Glow2 or rgb(255, 215, 80)
	local d1, d2 = 0.22 * u, 0.32 * u
	if face == "Jack" or face == "Scary" then
		-- yeux
		for _, side in {1, -1} do
			local rows = face == "Jack" and {{0.3, 1.5}, {0.62, 1.05}, {0.92, 0.6}, {1.18, 0.22}} or {{0.35, 1.6}, {0.62, 1.25}, {0.88, 0.75}}
			for r, row in rows do
				local dx = face == "Scary" and side * (r - 1) * 0.18 or 0 -- yeux méchants inclinés vers le centre
				local x = side * 1.25 * u + dx * u
				local y = (face == "Jack" and row[1] or (row[1] - (r - 1) * 0.02)) * u
				facePlate(x, y, (row[2] + 0.3) * u, 0.38 * u, d1, RIM, {Rot = face == "Scary" and side * 14 or 0})
				facePlate(x, y, row[2] * u, 0.32 * u, d2, r == 1 and GLOW or GLOW2, {Neon = true, Rot = face == "Scary" and side * 14 or 0})
			end
			if face == "Scary" then facePlate(side * 1.3 * u, 1.35 * u, 1.9 * u, 0.3 * u, d2 + 0.05, RIM, {Rot = side * 22}) end -- sourcil froncé
		end
		-- nez
		for r, row in {{-0.25, 0.75}, {0.0, 0.4}} do
			facePlate(0, row[1] * u, (row[2] + 0.25) * u, 0.32 * u, d1, RIM)
			facePlate(0, row[1] * u, row[2] * u, 0.26 * u, d2, GLOW, {Neon = true})
		end
		-- bouche
		local cols = 11
		for c = 0, cols - 1 do
			local f = (c - (cols - 1) / 2) / ((cols - 1) / 2)
			local x = f * 2.0 * u
			local y = (-1.25 + 0.55 * f * f) * u
			local h = (0.95 - 0.45 * f * f) * u
			facePlate(x, y, 0.42 * u, h + 0.22 * u, d1, RIM)
			facePlate(x, y, 0.4 * u, h, d2, GLOW, {Neon = true})
			local tooth = face == "Jack" and (c == 3 or c == 7) or (face == "Scary" and c % 2 == 1)
			if tooth then facePlate(x, y + h * 0.28, 0.36 * u, h * 0.45, d2 + 0.06 * u, light) end
			if face == "Jack" and c == 5 then facePlate(x, y - h * 0.28, 0.36 * u, h * 0.45, d2 + 0.06 * u, light) end
			if face == "Scary" and c % 2 == 0 and c > 0 and c < cols - 1 then facePlate(x, y - h * 0.3, 0.3 * u, h * 0.4, d2 + 0.06 * u, light) end
		end
		if opts.Light ~= false then
			local l = Instance.new("PointLight")
			l.Color = GLOW
			l.Range = math.clamp(R * 3, 8, 40)
			l.Brightness = 1.4
			l.Shadows = false
			l.Parent = part(model, Vector3.new(0.2, 0.2, 0.2), center * CFrame.new(0, 0, R * 1.1), GLOW, {Transparency = 1, Name = "Glow"})
		end
	elseif face == "Cute" then
		for _, side in {1, -1} do
			local x, y = side * 1.15 * u, 0.45 * u
			facePlate(x, y, 1.0 * u, 1.3 * u, d1, INK)
			facePlate(x, y, 1.25 * u, 1.0 * u, d1, INK)
			facePlate(x - side * 0.15 * u, y + 0.3 * u, 0.4 * u, 0.4 * u, d2, rgb(255, 255, 255))
			facePlate(x + side * 0.2 * u, y - 0.3 * u, 0.2 * u, 0.2 * u, d2, rgb(255, 255, 255))
			facePlate(side * 2.0 * u, -0.45 * u, 0.8 * u, 0.4 * u, d1, rgb(255, 120, 120))
		end
		facePlate(0, -0.55 * u, 0.9 * u, 0.22 * u, d1, INK)
		for _, side in {1, -1} do facePlate(side * 0.55 * u, -0.43 * u, 0.35 * u, 0.22 * u, d1, INK, {Rot = side * 35}) end
	end

	-- tige tordue, feuilles, vrille
	local brown, brown2 = rgb(105, 70, 35), rgb(78, 50, 26)
	local leaf, leafDark = rgb(95, 185, 70), rgb(60, 135, 48)
	local top = center * CFrame.new(0, H - t * 0.1, 0)
	local st = 0.42 * u
	chain(model, top * CFrame.Angles(rad(rng:NextNumber(-8, 8)), 0, rad(rng:NextNumber(-10, 10))), {
		{0.45 * u, st * 1.25, 0, -16, brown2, Depth = st * 1.25}, {0.45 * u, st * 1.1, 0, -22, brown, Depth = st * 1.1}, {0.4 * u, st * 0.95, 0, -28, brown2, Depth = st * 0.95}, {0.3 * u, st * 0.85, 0, 0, brown, Depth = st * 0.85},
	})
	for n = 1, (R >= 2.5 and 2 or 1) do
		local a = rad(n * 150 + rng:NextNumber(-25, 25))
		local cf = top * CFrame.Angles(0, a, 0) * CFrame.new(0, 0.12 * u, 0.9 * u) * CFrame.Angles(rad(-12), 0, 0)
		part(model, Vector3.new(1.2 * u, 0.12 * u, 1.6 * u), cf * CFrame.new(0, 0, 0.6 * u), leaf)
		part(model, Vector3.new(0.8 * u, 0.12 * u, 0.7 * u), cf * CFrame.new(0, 0, 1.55 * u) * CFrame.Angles(0, rad(45), 0), leaf)
		part(model, Vector3.new(0.12 * u, 0.15 * u, 1.9 * u), cf * CFrame.new(0, 0.02, 0.8 * u), leafDark, {Studs = false})
	end
	local curl = top * CFrame.Angles(0, rad(rng:NextNumber(0, 360)), 0) * CFrame.new(0.3 * u, 0.1 * u, 0) * CFrame.Angles(0, 0, rad(-75))
	local steps = {}
	for s = 1, 7 do table.insert(steps, {0.38 * u, 0.16 * u, 6, 52, s % 2 == 0 and leaf or leafDark}) end
	chain(model, curl, steps)

	-- chapeau de sorcière en option
	if opts.Hat then
		local hat, hatLight, band, gold = rgb(40, 30, 55), rgb(62, 46, 82), rgb(150, 70, 215), rgb(255, 210, 70)
		local base = center * CFrame.new(0.2 * u, H - 0.05 * u, -0.1 * u) * CFrame.Angles(rad(-8), 0, rad(-9))
		local br = R * 0.95
		for k = 0, 3 do part(model, Vector3.new(2 * br, 0.3 * u, 2 * br * math.tan(math.pi / 8)), base * CFrame.Angles(0, k * math.pi / 4, 0), k % 2 == 0 and hat or hatLight) end
		local cf = base * CFrame.new(0, 0.15 * u, 0)
		for j = 0, 8 do
			local f = j / 8
			local r = (R * 0.55 * (1 - f) + 0.12 * u)
			local h = 0.55 * u
			local color = j == 0 and band or (j % 2 == 0 and hat or hatLight)
			for k = 0, 3 do part(model, Vector3.new(2 * r, h, 2 * r * math.tan(math.pi / 8)), cf * CFrame.new(0, h / 2, 0) * CFrame.Angles(0, k * math.pi / 4, 0), color, {Studs = j == 8}) end
			cf = cf * CFrame.new(0, h, 0) * CFrame.Angles(rad(-f * f * 34), 0, 0)
		end
		part(model, Vector3.new(0.35, 0.35, 0.35) * u, cf * CFrame.Angles(rad(45), 0, rad(45)), gold)
		local buckle = base * CFrame.new(0, 0.42 * u, R * 0.57)
		part(model, Vector3.new(0.8 * u, 0.55 * u, 0.15 * u), buckle, gold)
		part(model, Vector3.new(0.45 * u, 0.28 * u, 0.2 * u), buckle, band)
	end
	return model
end

---------------------------------------------------------------- PIERRE TOMBALE
function M.Grave(opts)
	opts = opts or {}
	local s = opts.Size or 1
	local rng = Random.new(opts.Seed or 3)
	local model = newModel("Gravestone")
	local stone, stone2, moss = rgb(130, 130, 145), rgb(100, 100, 115), rgb(90, 130, 70)
	local tilt = CFrame.Angles(rad(rng:NextNumber(-6, 6)), 0, rad(rng:NextNumber(-7, 7)))
	part(model, Vector3.new(4.6, 0.6, 2.4) * s, CFrame.new(0, 0.3 * s, 0), stone2)
	local body = CFrame.new(0, 0.6 * s, 0) * tilt
	part(model, Vector3.new(3.4, 4.2, 0.9) * s, body * CFrame.new(0, 2.1 * s, 0), stone)
	part(model, Vector3.new(2.6, 0.7, 0.9) * s, body * CFrame.new(0, 4.5 * s, 0), stone)
	part(model, Vector3.new(1.6, 0.5, 0.9) * s, body * CFrame.new(0, 5.05 * s, 0), stone)
	-- "RIP" gravé (blocs foncés)
	local letters = {
		{-1.0, 3.4, 0.22, 1.1}, {-0.8, 3.85, 0.42, 0.2}, {-0.62, 3.55, 0.2, 0.42}, {-0.8, 3.3, 0.3, 0.2}, {-0.62, 3.05, 0.2, 0.42}, -- R
		{0.0, 3.4, 0.22, 1.1}, -- I
		{0.6, 3.4, 0.22, 1.1}, {0.85, 3.85, 0.42, 0.2}, {1.0, 3.65, 0.2, 0.3}, {0.85, 3.45, 0.42, 0.2}, -- P
	}
	for _, l in letters do part(model, Vector3.new(l[3], l[4], 0.15) * s, body * CFrame.new(l[1] * s, l[2] * s, 0.42 * s), INK, {Studs = false}) end
	part(model, Vector3.new(2.2, 0.15, 0.15) * s, body * CFrame.new(0, 2.3 * s, 0.42 * s), stone2, {Studs = false})
	part(model, Vector3.new(1.6, 0.15, 0.15) * s, body * CFrame.new(0, 1.9 * s, 0.42 * s), stone2, {Studs = false})
	-- fissure et mousse
	part(model, Vector3.new(0.12, 0.9, 0.15) * s, body * CFrame.new(1.2 * s, 1.0 * s, 0.42 * s) * CFrame.Angles(0, 0, rad(20)), INK, {Studs = false})
	part(model, Vector3.new(1.4, 0.5, 1.0) * s, body * CFrame.new(-1.0 * s, 0.35 * s, 0.05 * s), moss)
	part(model, Vector3.new(0.8, 0.4, 1.0) * s, body * CFrame.new(1.2 * s, 4.35 * s, 0.05 * s), moss)
	return model
end

---------------------------------------------------------------- BOUGIES
function M.Candles(opts)
	opts = opts or {}
	local model = newModel("Candles")
	local rng = Random.new(opts.Seed or 5)
	local n = opts.Count or 3
	for i = 1, n do
		local a = i / n * math.pi * 2
		local h = rng:NextNumber(1.2, 3.0)
		local p = Vector3.new(math.cos(a) * 1.1, 0, math.sin(a) * 1.1)
		part(model, Vector3.new(0.8, h, 0.8), CFrame.new(p + Vector3.new(0, h / 2, 0)), rgb(240, 232, 205))
		part(model, Vector3.new(0.95, 0.35, 0.95), CFrame.new(p + Vector3.new(0.05, h - 0.2, 0)), rgb(250, 245, 225))
		part(model, Vector3.new(0.12, 0.3, 0.12), CFrame.new(p + Vector3.new(0, h + 0.15, 0)), INK)
		part(model, Vector3.new(0.4, 0.6, 0.4), CFrame.new(p + Vector3.new(0, h + 0.55, 0)) * CFrame.Angles(0, rad(45), 0), rgb(255, 170, 40), {Neon = true})
		part(model, Vector3.new(0.22, 0.32, 0.22), CFrame.new(p + Vector3.new(0, h + 0.95, 0)) * CFrame.Angles(0, rad(45), 0), rgb(255, 240, 150), {Neon = true})
	end
	local l = Instance.new("PointLight")
	l.Color, l.Range, l.Brightness = rgb(255, 170, 60), 12, 1
	l.Parent = part(model, Vector3.new(0.2, 0.2, 0.2), CFrame.new(0, 2.5, 0), rgb(255, 170, 60), {Transparency = 1, Name = "Glow"})
	return model
end

---------------------------------------------------------------- BONBON (candy corn géant)
function M.CandyCorn(opts)
	local s = (opts and opts.Size) or 1
	local model = newModel("CandyCorn")
	part(model, Vector3.new(2.2, 1.0, 1.7) * s, CFrame.new(0, 0.5 * s, 0), rgb(255, 210, 40))
	part(model, Vector3.new(1.7, 1.0, 1.35) * s, CFrame.new(0, 1.5 * s, 0), rgb(255, 130, 20))
	part(model, Vector3.new(1.0, 0.9, 0.85) * s, CFrame.new(0, 2.45 * s, 0), rgb(255, 250, 240))
	part(model, Vector3.new(0.5, 0.4, 0.45) * s, CFrame.new(0, 3.1 * s, 0), rgb(255, 250, 240))
	return model
end

---------------------------------------------------------------- ARBRE MORT (branches tordues, lanternes accrochées)
function M.DeadTree(opts)
	opts = opts or {}
	local rng = Random.new(opts.Seed or 9)
	local s = opts.Size or 1
	local model = newModel("DeadTree")
	local bark, bark2 = rgb(58, 42, 38), rgb(42, 30, 28)
	-- racines
	for k = 0, 4 do
		local a = k / 5 * math.pi * 2 + rng:NextNumber(-0.3, 0.3)
		part(model, Vector3.new(1.2, 1.0, 4.0) * s, CFrame.Angles(0, a, 0) * CFrame.new(0, 0.4 * s, 2.2 * s) * CFrame.Angles(rad(-14), 0, 0), k % 2 == 0 and bark or bark2)
	end
	-- tronc qui se tord
	local steps = {}
	for i = 1, 7 do table.insert(steps, {2.2 * s, (2.6 - i * 0.22) * s, rng:NextNumber(-12, 12), rng:NextNumber(-12, 12), i % 2 == 0 and bark or bark2}) end
	local tip = chain(model, CFrame.new(0, 0, 0), steps)
	-- branches
	local hooks = {}
	for b = 1, 5 do
		local h = (4 + b * 2.2) * s
		local a = b * 2.1 + rng:NextNumber(-0.4, 0.4)
		local start = CFrame.new(0, h, 0) * CFrame.Angles(0, a, 0) * CFrame.Angles(rad(70 - b * 4), 0, 0)
		local bs = {}
		for i = 1, 4 do table.insert(bs, {1.6 * s, (1.1 - i * 0.2) * s, rng:NextNumber(-25, 10), rng:NextNumber(-30, 30), i % 2 == 0 and bark or bark2}) end
		table.insert(hooks, chain(model, start, bs))
	end
	chain(model, tip, {{1.4 * s, 0.6 * s, 20, 15, bark}, {1.0 * s, 0.4 * s, 25, -20, bark2}})
	-- creux dans le tronc avec deux yeux qui brillent
	part(model, Vector3.new(1.4, 1.8, 0.4) * s, CFrame.new(0, 3.2 * s, 1.15 * s), INK, {Studs = false})
	for _, sx in {-1, 1} do part(model, Vector3.new(0.3, 0.3, 0.3) * s, CFrame.new(sx * 0.3 * s, 3.5 * s, 1.3 * s), rgb(255, 220, 60), {Neon = true}) end
	-- lanternes citrouilles accrochées au bout de deux branches
	for i, hook in hooks do
		if i % 2 == 1 and i < 5 then
			local pos = hook.Position
			for c = 0, 3 do part(model, Vector3.new(0.18, 0.7, 0.35) * s, CFrame.new(pos - Vector3.new(0, (0.35 + c * 0.7) * s, 0)) * CFrame.Angles(0, (c % 2) * math.pi / 2, 0), rgb(60, 55, 65), {Studs = false}) end
			local lantern = M.Pumpkin({Radius = 1.1 * s, Face = "Jack", Seed = i + (opts.Seed or 0), Light = false})
			local _, size = lantern:GetBoundingBox()
			lantern:PivotTo(CFrame.new(pos - Vector3.new(0, 2.9 * s + size.Y, 0)) * CFrame.Angles(0, rng:NextNumber(0, 6.28), 0))
			for _, p in lantern:GetChildren() do if p.Name ~= "Base" then p.Parent = model end end
			lantern:Destroy()
		end
	end
	return model
end

---------------------------------------------------------------- CHAUDRON (potion verte qui bouillonne)
function M.Cauldron(opts)
	local s = (opts and opts.Size) or 1
	local model = newModel("Cauldron")
	local iron, iron2 = rgb(45, 42, 52), rgb(30, 28, 36)
	local T8 = math.tan(math.pi / 8)
	local function ring(y, r, h, color, studs)
		for k = 0, 3 do part(model, Vector3.new(2 * r, h, 2 * r * T8), CFrame.new(0, y, 0) * CFrame.Angles(0, k * math.pi / 4, 0), k % 2 == 0 and color or shade(color, 1.15), {Studs = studs}) end
	end
	for _, a in {0, 2.1, 4.2} do part(model, Vector3.new(0.9, 1.6, 0.9) * s, CFrame.Angles(0, a, 0) * CFrame.new(0, 0.8 * s, 2.4 * s), iron2) end
	ring(1.8 * s, 2.4 * s, 1.0 * s, iron2)
	ring(3.0 * s, 3.2 * s, 1.6 * s, iron)
	ring(4.4 * s, 3.4 * s, 1.4 * s, iron)
	ring(5.5 * s, 3.0 * s, 0.9 * s, iron2)
	ring(6.05 * s, 3.25 * s, 0.35 * s, iron, true) -- rebord
	ring(6.0 * s, 2.7 * s, 0.4 * s, rgb(110, 240, 70)) -- potion
	ring(6.05 * s, 2.3 * s, 0.4 * s, rgb(150, 255, 90))
	for i, b in {{0.8, 0.5, 0.9}, {-1.0, -0.6, 0.7}, {0.2, -1.2, 0.5}, {-0.5, 1.1, 0.6}} do
		part(model, Vector3.new(b[3], b[3], b[3]) * s, CFrame.new(b[1] * s, (6.4 + b[3] * 0.3) * s, b[2] * s) * CFrame.Angles(rad(45), rad(i * 20), rad(45)), rgb(180, 255, 120), {Neon = true})
	end
	part(model, Vector3.new(0.35, 5.5, 0.35) * s, CFrame.new(0.6 * s, 7.4 * s, 0.4 * s) * CFrame.Angles(rad(-18), 0, rad(14)), rgb(120, 82, 45)) -- louche
	local l = Instance.new("PointLight")
	l.Color, l.Range, l.Brightness = rgb(120, 255, 80), 18, 1.4
	l.Parent = part(model, Vector3.new(0.2, 0.2, 0.2), CFrame.new(0, 7.5 * s, 0), rgb(120, 255, 80), {Transparency = 1, Name = "Glow"})
	local fx = Instance.new("ParticleEmitter")
	fx.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	fx.Color = ColorSequence.new(rgb(150, 255, 100))
	fx.LightEmission = 1
	fx.Rate = 6
	fx.Lifetime = NumberRange.new(1, 2)
	fx.Speed = NumberRange.new(2, 4)
	fx.Size = NumberSequence.new(0.6 * s, 0)
	fx.SpreadAngle = Vector2.new(25, 25)
	fx.Parent = l.Parent
	return model
end

---------------------------------------------------------------- LANTERNE SUSPENDUE (citrouille qui pend à une chaîne)
function M.HangingLantern(opts)
	opts = opts or {}
	local len = opts.Chain or 8
	local model = M.Pumpkin({Radius = opts.Radius or 1.6, Face = "Jack", Seed = opts.Seed, Light = true})
	model.Name = "HangingLantern"
	local cf, size = model:GetBoundingBox()
	local topY = cf.Position.Y + size.Y / 2
	for i = 0, math.floor(len / 0.8) - 1 do
		part(model, Vector3.new(0.25, 0.8, 0.5), CFrame.new(0, topY + 0.4 + i * 0.8, 0) * CFrame.Angles(0, (i % 2) * math.pi / 2, 0), rgb(60, 55, 65), {Studs = false})
	end
	return model
end

return M
