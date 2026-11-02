-- Outil d'édition (pas utilisé en jeu) : construit les 5 œufs Halloween en studs avec EggBuilderKit.
-- Usage (barre de commande) : require(game.ServerStorage.HalloweenEggBuilder).BuildAll(folder, origin)
local Kit = require(script.Parent:WaitForChild("EggBuilderKit"))
local rgb, shade = Kit.rgb, Kit.shade
local rad = math.rad
local INK = rgb(30, 22, 40)

local M = {}

---------------------------------------------------------------- petits décors réutilisables
local function nestHalloween(k, seed, c1, c2, straw)
	local outer = k:nest(c1 or rgb(62, 40, 70), c2 or rgb(44, 30, 34), {Seed = seed})
	k:straws(straw or rgb(255, 140, 30), 14, outer, 2.4, seed)
	return outer
end

local function candyCorn(k, cf)
	k:part("Nest", Vector3.new(0.95, 0.45, 0.75), cf * CFrame.new(0, 0.22, 0), rgb(255, 210, 40))
	k:part("Nest", Vector3.new(0.72, 0.45, 0.58), cf * CFrame.new(0, 0.66, 0), rgb(255, 130, 20))
	k:part("Nest", Vector3.new(0.42, 0.42, 0.36), cf * CFrame.new(0, 1.08, 0), rgb(255, 250, 240))
end

local function miniPumpkin(k, cf, s)
	s = s or 1
	local o = rgb(255, 135, 25)
	k:part("Nest", Vector3.new(1.7, 1.25, 1.7) * s, cf * CFrame.new(0, 0.62 * s, 0), o, {Studs = true})
	k:part("Nest", Vector3.new(1.7, 1.15, 1.7) * s, cf * CFrame.new(0, 0.6 * s, 0) * CFrame.Angles(0, rad(45), 0), shade(o, 0.85), {Studs = true})
	k:part("Nest", Vector3.new(1.2, 1.45, 1.2) * s, cf * CFrame.new(0, 0.62 * s, 0) * CFrame.Angles(0, rad(22), 0), shade(o, 0.93))
	k:part("Nest", Vector3.new(0.3, 0.6, 0.3) * s, cf * CFrame.new(0.05, 1.45 * s, 0) * CFrame.Angles(0, 0, rad(-12)), rgb(95, 60, 30))
	k:part("Nest", Vector3.new(0.6, 0.12, 0.35) * s, cf * CFrame.new(0.35 * s, 1.3 * s, 0) * CFrame.Angles(0, 0, rad(-20)), rgb(80, 170, 60))
	-- petit visage de lanterne
	for _, sx in {1, -1} do
		k:part("Nest", Vector3.new(0.3, 0.3, 0.1) * s, cf * CFrame.new(sx * 0.35 * s, 0.85 * s, 0.86 * s) * CFrame.Angles(0, 0, rad(45)), rgb(255, 220, 90), {Neon = true})
	end
	k:part("Nest", Vector3.new(0.8, 0.18, 0.1) * s, cf * CFrame.new(0, 0.42 * s, 0.86 * s), rgb(255, 220, 90), {Neon = true})
end

local function candle(k, cf, h)
	h = h or 1.6
	k:part("Nest", Vector3.new(0.6, h, 0.6), cf * CFrame.new(0, h / 2, 0), rgb(240, 232, 205))
	k:part("Nest", Vector3.new(0.68, 0.3, 0.68), cf * CFrame.new(0.05, h - 0.25, 0.05) * CFrame.Angles(0, 0, rad(8)), rgb(250, 245, 225)) -- cire qui coule
	k:part("Nest", Vector3.new(0.08, 0.25, 0.08), cf * CFrame.new(0, h + 0.12, 0), INK)
	k:part("Nest", Vector3.new(0.3, 0.5, 0.3), cf * CFrame.new(0, h + 0.45, 0) * CFrame.Angles(0, rad(45), 0), rgb(255, 170, 40), {Neon = true})
	k:part("Nest", Vector3.new(0.16, 0.26, 0.16), cf * CFrame.new(0, h + 0.78, 0) * CFrame.Angles(0, rad(45), 0), rgb(255, 240, 150), {Neon = true})
end

local function bone(k, cf, len, color, thick)
	color = color or rgb(238, 232, 212)
	thick = thick or 0.45
	k:part("Decor", Vector3.new(thick, thick, len), cf, color)
	for _, ez in {1, -1} do
		for _, ex in {1, -1} do
			k:part("Decor", Vector3.new(thick * 1.2, thick * 1.2, thick * 1.2), cf * CFrame.new(ex * thick * 0.55, 0, ez * len / 2), color)
		end
	end
end

-- étoile à 8 branches posée sur la coquille
local function star(k, yaw, y, s, color, d)
	k:plate("Relief", yaw, y, s, s, d or 0.3, color)
	k:plate("Relief", yaw, y, s, s, d or 0.3, color, {Rot = 45})
	k:plate("Relief", yaw, y, s * 0.45, s * 0.45, (d or 0.3) + 0.08, shade(color, 1.35))
end

local function oval(k, yaw, y, w, h, color, d, opts)
	opts = opts or {}
	k:plate("Relief", yaw, y, w, h * 0.72, d, color, opts)
	k:plate("Relief", yaw, y, w * 0.72, h, d, color, opts)
	k:plate("Relief", yaw, y, w * 0.88, h * 0.88, d, color, opts)
end

local function setFx(model, color, rate)
	local fx = model:FindFirstChild("Fx")
	if not fx then return end
	for _, e in fx:GetDescendants() do
		if e:IsA("ParticleEmitter") then
			e.Color = ColorSequence.new(color)
			if rate then e.Rate = rate end
		end
	end
end

---------------------------------------------------------------- 1. Œuf CITROUILLE (jack-o'-lantern)
function M.Pumpkin(k)
	local top, bottom = rgb(255, 125, 15), rgb(205, 75, 8)
	k:shell(function(i) return bottom:Lerp(top, math.clamp((i - 1) / 12, 0, 1)) end)
	-- côtes de citrouille (sauf sur le visage)
	for yaw = 0, 345, 30 do
		local a = (yaw + 180) % 360 - 180
		for y = -5.5, 5.5, 1 do
			if not (math.abs(a) < 42 and y > -3 and y < 4) then
				local c = bottom:Lerp(top, (y + 6) / 12)
				k:plate("Relief", yaw, y, 0.55, 1.08, 0.22, shade(c, 0.66))
			end
		end
	end
	local RIM, GLOW, GLOW2 = rgb(55, 22, 10), rgb(255, 150, 20), rgb(255, 200, 60)
	-- yeux triangulaires creusés et lumineux
	for _, side in {1, -1} do
		local yaw = side * 19
		for r, row in {{2.0, 1.9}, {2.55, 1.35}, {3.05, 0.8}, {3.45, 0.32}} do
			k:plate("Relief", yaw, row[1], row[2] + 0.35, 0.62, 0.24, RIM)
			k:plate("Relief", yaw, row[1], row[2], 0.55, 0.3, r == 1 and GLOW or GLOW2, {Neon = true})
		end
	end
	-- nez
	for r, row in {{0.75, 1.0}, {1.15, 0.5}} do
		k:plate("Relief", 0, row[1], row[2] + 0.3, 0.5, 0.24, RIM)
		k:plate("Relief", 0, row[1], row[2], 0.42, 0.3, GLOW, {Neon = true})
	end
	-- grand sourire denté
	for yaw = -36, 36, 6 do
		local f = yaw / 36
		local y = -1.75 + 0.75 * f * f
		local h = 1.25 - 0.55 * f * f
		k:plate("Relief", yaw, y, 0.78, h + 0.3, 0.24, RIM)
		k:plate("Relief", yaw, y, 0.62, h, 0.3, GLOW, {Neon = true})
	end
	for _, t in {{-18, 1}, {18, 1}, {0, -1}, {-30, -1}, {30, -1}} do -- dents (haut = 1, bas = -1)
		local f = t[1] / 36
		local y = -1.75 + 0.75 * f * f
		local h = 1.25 - 0.55 * f * f
		k:plate("Relief", t[1], y, 0.7, h * 0.42, 0.36, top, {Dy = t[2] * h * 0.3})
	end
	-- tige tordue, feuille et vrille
	local brown, brown2 = rgb(105, 70, 35), rgb(80, 52, 28)
	k:part("Decor", Vector3.new(2.2, 0.6, 2.2), CFrame.new(0, 6.95, 0), brown2, {Studs = true})
	k:chain("Decor", CFrame.new(0, 7.0, 0) * CFrame.Angles(0, 0, rad(-6)), {
		{0.9, 1.3, 0, -14, brown, Depth = 1.3}, {0.9, 1.15, 0, -20, brown2, Depth = 1.15}, {0.8, 1.0, 0, -26, brown, Depth = 1.0}, {0.6, 0.85, 0, 0, brown2, Depth = 0.85},
	})
	local leaf, leafDark = rgb(95, 190, 70), rgb(60, 140, 50)
	k:part("Decor", Vector3.new(2.4, 0.25, 1.5), CFrame.new(-1.5, 7.3, 0.6) * CFrame.Angles(rad(-10), rad(25), rad(18)), leaf, {Studs = true})
	k:part("Decor", Vector3.new(1.4, 0.25, 0.9), CFrame.new(-2.7, 7.75, 0.95) * CFrame.Angles(rad(-10), rad(25), rad(30)), leaf, {Studs = true})
	k:part("Decor", Vector3.new(2.6, 0.3, 0.2), CFrame.new(-1.9, 7.45, 0.75) * CFrame.Angles(rad(-10), rad(25), rad(22)), leafDark)
	k:chain("Decor", CFrame.new(0.9, 6.95, 0.5) * CFrame.Angles(rad(20), 0, rad(-70)), {
		{0.6, 0.28, 0, 45, leafDark}, {0.6, 0.28, 0, 50, leafDark}, {0.55, 0.26, 0, 55, leaf}, {0.5, 0.24, 0, 60, leaf}, {0.45, 0.22, 0, 65, leafDark}, {0.4, 0.2, 0, 70, leaf},
	})
	-- nid : mini-citrouilles et bonbons
	local outer = nestHalloween(k, 11)
	miniPumpkin(k, CFrame.Angles(0, rad(40), 0) * CFrame.new(0, -5.3, outer - 0.4) , 1)
	miniPumpkin(k, CFrame.Angles(0, rad(-130), 0) * CFrame.new(0, -5.3, outer - 0.4), 0.85)
	for _, a in {-45, 95, 165, -100} do candyCorn(k, CFrame.Angles(0, rad(a), 0) * CFrame.new(0, -5.0, outer - 0.6) * CFrame.Angles(rad(-15), 0, 0)) end
	setFx(k.Model, rgb(255, 160, 40))
end

---------------------------------------------------------------- 2. Œuf FANTÔME
function M.Ghost(k)
	local top, bottom = rgb(250, 250, 255), rgb(205, 195, 240)
	k:shell(function(i) return bottom:Lerp(top, math.clamp((i - 1) / 9, 0, 1)) end)
	-- drap qui retombe en vagues sur le nid
	for yaw = 0, 337.5, 22.5 do
		local long = (yaw / 22.5) % 2 == 0
		k:plate("Relief", yaw, long and -4.6 or -4.1, 1.9, long and 2.4 or 1.4, 0.3, rgb(235, 232, 250))
		k:plate("Relief", yaw, long and -5.7 or -4.75, 1.1, 0.6, 0.38, rgb(225, 220, 245))
	end
	-- grands yeux noirs brillants
	for _, side in {1, -1} do
		oval(k, side * 17, 1.6, 1.7, 2.5, INK, 0.3)
		oval(k, side * 17, 1.6, 1.25, 1.95, rgb(45, 35, 75), 0.36)
		k:plate("Relief", side * 17, 1.6, 0.55, 0.55, 0.44, rgb(255, 255, 255), {Dx = -side * 0.25, Dy = 0.5})
		k:plate("Relief", side * 17, 1.6, 0.28, 0.28, 0.44, rgb(255, 255, 255), {Dx = side * 0.3, Dy = -0.55})
		k:plate("Relief", side * 17, 3.0, 1.2, 0.3, 0.3, rgb(120, 110, 160), {Rot = -side * 15}) -- sourcil inquiet
	end
	-- bouche "OOOH"
	oval(k, 0, -0.65, 1.3, 1.7, INK, 0.3)
	oval(k, 0, -0.75, 0.9, 1.15, rgb(90, 30, 60), 0.36)
	k:plate("Relief", 0, -1.15, 0.7, 0.4, 0.42, rgb(255, 120, 150))
	k:blush({Yaw = 36, Y = 0.1, Color = rgb(255, 170, 200)})
	-- mèche du drap au sommet
	k:chain("Decor", CFrame.new(0, 6.6, 0) * CFrame.Angles(rad(-10), 0, rad(10)), {
		{0.8, 1.5, -15, 10, top, Depth = 1.5}, {0.7, 1.1, -20, 15, top, Depth = 1.1}, {0.6, 0.8, -25, 20, bottom, Depth = 0.8}, {0.4, 0.5, 0, 0, bottom, Depth = 0.5},
	})
	-- petits fantômes qui flottent autour
	local function miniGhost(angle, y, s)
		local cf = CFrame.Angles(0, rad(angle), 0) * CFrame.new(0, y, 8.2) * CFrame.Angles(0, rad(-20), rad(8))
		local w = rgb(248, 248, 255)
		k:part("Decor", Vector3.new(1.8, 1.9, 1.5) * s, cf, w, {Studs = true})
		k:part("Decor", Vector3.new(1.3, 0.55, 1.1) * s, cf * CFrame.new(0, 1.15 * s, 0), w, {Studs = true})
		k:part("Decor", Vector3.new(2.1, 1.2, 1.2) * s, cf * CFrame.new(0, 0.1 * s, 0), w)
		for i = -1, 1 do k:part("Decor", Vector3.new(0.5, 0.55, 1.3) * s, cf * CFrame.new(i * 0.62 * s, -1.2 * s, 0), i == 0 and rgb(225, 220, 245) or w) end
		for _, sx in {1, -1} do
			k:part("Decor", Vector3.new(0.32, 0.5, 0.1) * s, cf * CFrame.new(sx * 0.38 * s, 0.35 * s, 0.76 * s), INK)
			k:part("Decor", Vector3.new(0.6, 0.3, 0.4) * s, cf * CFrame.new(sx * 1.15 * s, -0.1 * s, 0) * CFrame.Angles(0, 0, rad(sx * 35)), w) -- petits bras
		end
		k:part("Decor", Vector3.new(0.35, 0.35, 0.1) * s, cf * CFrame.new(0, -0.25 * s, 0.76 * s), INK)
	end
	miniGhost(55, 3.5, 1)
	miniGhost(-60, 0.5, 0.8)
	miniGhost(170, 5.0, 0.9)
	-- feux follets
	for i, a in {20, 100, -110, 200, -20} do
		k:part("Decor", Vector3.new(0.5, 0.5, 0.5), CFrame.Angles(0, rad(a), 0) * CFrame.new(0, -2 + i * 1.3, 7.4) * CFrame.Angles(rad(45), rad(45), 0), rgb(170, 140, 255), {Neon = true})
	end
	-- nid : bougies
	local outer = nestHalloween(k, 23, rgb(70, 60, 95), rgb(45, 38, 60), rgb(170, 150, 220))
	for _, a in {35, -40, 140, -150} do candle(k, CFrame.Angles(0, rad(a), 0) * CFrame.new(0, -5.4, outer - 0.5), a % 2 == 0 and 1.8 or 1.3) end
	setFx(k.Model, rgb(200, 180, 255))
end

---------------------------------------------------------------- 3. Œuf SORCIÈRE
function M.Witch(k)
	local purple, green = rgb(120, 55, 185), rgb(110, 210, 70)
	k:shell(function(i)
		if i == 3 or i == 7 then return green end
		if i == 4 or i == 8 then return INK end
		return shade(purple, 0.8 + i * 0.03)
	end)
	-- lune et étoiles
	local gold = rgb(255, 215, 70)
	oval(k, 120, 1.2, 2.2, 2.2, gold, 0.3)
	oval(k, 120, 1.5, 1.9, 2.0, shade(purple, 1.0), 0.36, {Dx = 0.75})
	star(k, -70, 0.5, 1.0, gold)
	star(k, 160, -1.8, 0.8, gold)
	star(k, -140, 2.2, 0.9, gold)
	star(k, 45, -2.6, 0.7, gold)
	star(k, -35, -2.8, 0.6, gold)
	star(k, 210, 1.0, 0.7, gold)
	-- yeux verts malicieux avec cils + sourire en coin
	for _, side in {1, -1} do
		k:eye(side, {Yaw = 21, Y = 2.2, Size = 0.85, Iris = rgb(90, 220, 80), Glow = true, Lashes = true, Slit = true})
	end
	k:plate("Relief", 0, -0.2, 1.8, 0.3, 0.3, INK, {Rot = -6})
	k:plate("Relief", 0, -0.2, 0.5, 0.3, 0.3, INK, {Dx = 1.05, Dy = 0.18, Rot = 35})
	k:plate("Relief", 0, -0.62, 0.5, 0.35, 0.3, rgb(255, 120, 150), {Dx = 0.3}) -- langue tirée
	k:blush({Yaw = 40, Y = 0.6, Color = rgb(230, 120, 210)})
	-- chapeau pointu (bord, cône qui retombe, ruban et boucle dorée)
	local H = CFrame.new(0, 5.15, -0.2) * CFrame.Angles(rad(-9), 0, rad(5))
	local hat, hatLight = rgb(40, 30, 55), rgb(60, 45, 80)
	for kk = 0, 7 do
		k:part("Decor", Vector3.new(12, 0.45, 12 * math.tan(math.pi / 16)), H * CFrame.Angles(0, kk * math.pi / 8, 0), kk % 2 == 0 and hat or hatLight, {Studs = true})
	end
	k:part("Decor", Vector3.new(9.4, 0.5, 9.4), H * CFrame.new(0, 0.05, 0), hat, {Studs = true})
	local N = 11
	local cf = H * CFrame.new(0, 0.25, 0)
	for j = 0, N - 1 do
		local t = j / (N - 1)
		local r = 3.4 * (1 - t) + 0.3
		local h = 0.85
		local color = (j == 0 or j == 1) and rgb(150, 70, 215) or (j % 2 == 0 and hat or hatLight)
		local rr = (j <= 1) and r + 0.18 or r
		for kk = 0, 3 do
			k:part("Decor", Vector3.new(2 * rr, h, 2 * rr * math.tan(math.pi / 8)), cf * CFrame.new(0, h / 2, 0) * CFrame.Angles(0, kk * math.pi / 4, 0), color, {Studs = j == N - 1})
		end
		cf = cf * CFrame.new(0, h, 0) * CFrame.Angles(rad(-t * t * 24), 0, 0) -- la pointe retombe vers l'arrière
	end
	k:part("Decor", Vector3.new(0.7, 0.7, 0.7), cf * CFrame.new(0, 0.2, 0) * CFrame.Angles(rad(45), 0, rad(45)), gold) -- grelot au bout
	-- boucle dorée devant le ruban
	local buckle = H * CFrame.new(0, 1.1, 3.62) * CFrame.Angles(rad(-8), 0, 0)
	k:part("Decor", Vector3.new(1.6, 1.3, 0.3), buckle, gold)
	k:part("Decor", Vector3.new(0.95, 0.65, 0.4), buckle, rgb(150, 70, 215))
	k:part("Decor", Vector3.new(0.25, 0.65, 0.45), buckle * CFrame.new(0.15, 0, 0), shade(gold, 0.85))
	-- balai appuyé contre l'œuf
	local broomBase = CFrame.new(6.6, -5.3, 2.8) * CFrame.Angles(rad(-6), 0, rad(19))
	local wood, wood2 = rgb(125, 82, 45), rgb(100, 64, 35)
	k:chain("Decor", broomBase * CFrame.new(0, 1.6, 0), {{3.2, 0.5, 0, 0, wood}, {3.2, 0.5, 0, 0, wood2}, {3.0, 0.5, 0, 8, wood}, {0.6, 0.65, 0, 0, wood2}})
	local straw, straw2 = rgb(235, 190, 90), rgb(205, 150, 60)
	k:part("Decor", Vector3.new(1.9, 2.4, 1.9), broomBase * CFrame.new(0, 0.6, 0), straw, {Studs = true})
	k:part("Decor", Vector3.new(1.9, 2.3, 1.9), broomBase * CFrame.new(0, 0.55, 0) * CFrame.Angles(0, rad(45), 0), straw2)
	k:part("Decor", Vector3.new(2.5, 1.0, 2.5), broomBase * CFrame.new(0, -0.3, 0) * CFrame.Angles(0, rad(22), 0), straw)
	k:part("Decor", Vector3.new(1.3, 0.45, 1.3), broomBase * CFrame.new(0, 1.9, 0), rgb(150, 40, 60))
	-- nid : potion qui brille, bonbons
	local outer = nestHalloween(k, 37, rgb(55, 35, 75), rgb(40, 30, 45), rgb(140, 220, 90))
	local potion = CFrame.Angles(0, rad(-50), 0) * CFrame.new(0, -5.4, outer - 0.5)
	k:part("Nest", Vector3.new(1.4, 1.4, 1.4), potion * CFrame.new(0, 0.7, 0), rgb(120, 255, 90), {Neon = true, Transparency = 0.15})
	k:part("Nest", Vector3.new(1.0, 1.6, 1.0), potion * CFrame.new(0, 0.75, 0) * CFrame.Angles(0, rad(45), 0), rgb(150, 230, 140), {Transparency = 0.4})
	k:part("Nest", Vector3.new(0.55, 0.7, 0.55), potion * CFrame.new(0, 1.75, 0), rgb(190, 230, 200), {Transparency = 0.3})
	k:part("Nest", Vector3.new(0.65, 0.4, 0.65), potion * CFrame.new(0, 2.25, 0), wood)
	k:part("Nest", Vector3.new(0.9, 0.5, 0.1), potion * CFrame.new(0, 0.7, 0.72), rgb(245, 230, 190))
	for _, a in {20, 130, -150} do candyCorn(k, CFrame.Angles(0, rad(a), 0) * CFrame.new(0, -5.0, outer - 0.6) * CFrame.Angles(rad(-15), 0, 0)) end
	setFx(k.Model, rgb(130, 255, 90))
end

---------------------------------------------------------------- 4. Œuf SQUELETTE
function M.Skeleton(k)
	local top, bottom = rgb(55, 52, 68), rgb(28, 25, 36)
	k:shell(function(i) return bottom:Lerp(top, math.clamp((i - 1) / 12, 0, 1)) end)
	local BONE, BONE2 = rgb(240, 235, 215), rgb(205, 198, 175)
	-- crâne : colonnes collées à la coquille
	for yaw = -28, 28, 7 do
		local f = math.abs(yaw) / 28
		local y0, y1 = -0.2 + f * 0.6, 4.2 - f * f * 1.4
		for y = y0, y1, 0.8 do k:plate("Relief", yaw, y, 0.75, 0.9, 0.26, f > 0.9 and BONE2 or BONE) end
		if math.abs(yaw) <= 14 then -- mâchoire
			for y = -2.1, -0.6, 0.75 do k:plate("Relief", yaw, y, 0.75, 0.85, 0.26, math.abs(yaw) == 14 and BONE2 or BONE) end
		end
	end
	-- orbites + yeux rouges qui brillent
	for _, side in {1, -1} do
		oval(k, side * 12, 2.1, 1.7, 1.8, INK, 0.34)
		k:plate("Relief", side * 12, 2.0, 0.6, 0.6, 0.42, rgb(255, 40, 40), {Neon = true})
		k:plate("Relief", side * 12, 2.0, 0.28, 0.28, 0.48, rgb(255, 200, 180), {Neon = true, Dy = 0.12})
	end
	-- nez en cœur inversé
	k:plate("Relief", 0, 0.75, 0.95, 0.4, 0.34, INK)
	k:plate("Relief", 0, 0.45, 0.5, 0.4, 0.34, INK)
	-- dents
	k:plate("Relief", 0, -0.8, 3.6, 1.3, 0.32, INK)
	for i = -2, 2 do
		k:plate("Relief", i * 7.5, -0.55, 0.55, 0.55, 0.38, BONE) -- dents du haut
		k:plate("Relief", i * 7.5, -1.08, 0.55, 0.5, 0.38, BONE2) -- dents du bas
	end
	-- fissures
	k:plate("Relief", 14, 3.6, 0.15, 0.8, 0.32, INK, {Rot = 25})
	k:plate("Relief", 16, 3.0, 0.15, 0.6, 0.32, INK, {Rot = -20})
	k:plate("Relief", -8, 3.85, 0.15, 0.5, 0.32, INK, {Rot = -35})
	-- os croisés sur les côtés
	for _, yaw in {90, -90} do
		local base = CFrame.Angles(0, rad(yaw), 0) * CFrame.new(0, 0.5, Kit.R(0.5) + 0.25)
		bone(k, base * CFrame.Angles(0, rad(90), rad(45)) * CFrame.Angles(0, rad(90), 0), 4.0, BONE)
		bone(k, base * CFrame.Angles(0, rad(90), rad(-45)) * CFrame.Angles(0, rad(90), 0), 4.0, BONE2)
	end
	-- colonne vertébrale et côtes dans le dos
	for y = -4.5, 4.5, 1.1 do k:plate("Relief", 180, y, 0.9, 0.8, 0.34, BONE) end
	for y = -2.5, 2.5, 1.25 do
		for _, side in {1, -1} do
			for j = 1, 4 do
				k:plate("Relief", 180 + side * (6 + j * 7), y - j * 0.12, 1.0, 0.42, 0.3, j == 4 and BONE2 or BONE)
			end
		end
	end
	-- petit os sur le sommet comme une mèche
	bone(k, CFrame.new(0.3, 7.0, 0) * CFrame.Angles(rad(90), rad(30), rad(0)) * CFrame.Angles(rad(-60), 0, 0), 2.2, BONE)
	-- nid d'os
	local outer = nestHalloween(k, 51, rgb(50, 48, 55), rgb(32, 30, 36), rgb(120, 115, 105))
	for i, a in {0, 50, 100, 150, 200, 250, 300} do
		bone(k, CFrame.Angles(0, rad(a), 0) * CFrame.new(0, -4.85, outer - 0.3) * CFrame.Angles(0, rad(70 + i * 9), rad(i % 2 == 0 and 8 or -8)), 2.0 + (i % 3) * 0.4, i % 2 == 0 and BONE or BONE2, 0.38)
	end
	setFx(k.Model, rgb(255, 90, 80))
end

---------------------------------------------------------------- 5. Œuf VAMPIRE (chauve-souris)
function M.Vampire(k)
	local top, bottom = rgb(45, 25, 55), rgb(120, 15, 35)
	k:shell(function(i) return bottom:Lerp(top, math.clamp((i - 1) / 11, 0, 1)) end)
	-- pointe de cheveux en V sur le front
	for j = 0, 4 do
		for _, side in {1, -1} do
			k:plate("Relief", side * (4 + j * 6), 4.1 + j * 0.35, 1.1, 1.0 + j * 0.15, 0.3, rgb(25, 15, 30))
		end
	end
	k:plate("Relief", 0, 3.75, 0.9, 1.0, 0.3, rgb(25, 15, 30), {Rot = 45})
	-- yeux rouges perçants et sourcils froncés
	for _, side in {1, -1} do
		k:eye(side, {Yaw = 20, Y = 1.9, Size = 0.85, Iris = rgb(255, 40, 60), Glow = true, Slit = true, Brow = rgb(25, 15, 30), BrowAngle = 22})
	end
	-- sourire avec crocs (et une goutte de sang)
	k:plate("Relief", 0, -0.45, 2.4, 0.3, 0.3, INK)
	for _, side in {1, -1} do
		k:plate("Relief", 0, -0.45, 0.55, 0.3, 0.3, INK, {Dx = side * 1.3, Dy = 0.18, Rot = side * 30})
		k:plate("Relief", 0, -0.85, 0.42, 0.75, 0.38, rgb(255, 255, 250), {Dx = side * 0.6})
		k:plate("Relief", 0, -1.18, 0.22, 0.3, 0.4, rgb(255, 255, 250), {Dx = side * 0.6})
	end
	k:plate("Relief", 0, -1.45, 0.22, 0.32, 0.42, rgb(210, 0, 25), {Dx = 0.6, Neon = true})
	-- ailes de chauve-souris
	for _, side in {1, -1} do
		k:batWing(side, {Dark = rgb(55, 18, 40), Light = rgb(130, 30, 60), Bone = rgb(35, 22, 42), Claw = rgb(235, 225, 210), Size = 0.72, Y = 1.4, Sweep = 28})
	end
	-- oreilles pointues
	for _, side in {1, -1} do
		local base = CFrame.new(side * 2.0, 5.6, -0.3) * CFrame.Angles(0, 0, rad(-side * 22))
		k:chain("Decor", base, {{0.9, 1.5, 0, 0, top, Depth = 0.7}, {0.8, 1.0, 0, 0, top, Depth = 0.6}, {0.6, 0.5, 0, 0, top, Depth = 0.5}})
		k:part("Decor", Vector3.new(0.8, 1.3, 0.2), base * CFrame.new(0, 1.1, 0.3), rgb(170, 40, 70))
	end
	-- grand col de cape (noir dehors, rouge dedans) dans le dos
	for yaw = 105, 255, 15 do
		local a = math.rad(yaw)
		local cf = CFrame.Angles(0, a, 0) * CFrame.new(0, -0.8, Kit.R(-0.8) + 1.0) * CFrame.Angles(rad(-14), 0, 0)
		local h = 6.2 + math.cos((yaw - 180) / 75 * math.pi / 2) * 1.6
		k:part("Decor", Vector3.new(2.1, h, 0.35), cf * CFrame.new(0, h / 2 - 2.5, 0.12), rgb(20, 14, 26))
		k:part("Decor", Vector3.new(1.95, h - 0.4, 0.2), cf * CFrame.new(0, h / 2 - 2.6, -0.1), rgb(185, 20, 45))
	end
	-- médaillon doré avec rubis
	local gold = rgb(255, 205, 70)
	oval(k, 0, -3.3, 1.7, 1.7, gold, 0.3)
	oval(k, 0, -3.3, 1.0, 1.0, rgb(220, 10, 40), 0.4, {Neon = true})
	for _, side in {1, -1} do k:plate("Relief", side * 18, -2.6, 2.4, 0.3, 0.26, gold, {Rot = side * 25}) end
	-- nid : bougies rouges et chauves-souris endormies
	local outer = nestHalloween(k, 67, rgb(55, 20, 35), rgb(35, 18, 25), rgb(170, 30, 50))
	for _, a in {30, -35, 150, -150} do candle(k, CFrame.Angles(0, rad(a), 0) * CFrame.new(0, -5.4, outer - 0.5), 1.5) end
	setFx(k.Model, rgb(255, 40, 70))
end

M.Order = {
	{Name = "PumpkinEgg", Build = "Pumpkin"},
	{Name = "GhostEgg", Build = "Ghost"},
	{Name = "WitchEgg", Build = "Witch"},
	{Name = "SkeletonEgg", Build = "Skeleton"},
	{Name = "VampireEgg", Build = "Vampire"},
}

-- construit un œuf à partir d'un œuf existant (Root + Fx), à l'échelle des autres œufs du jeu
function M.Build(entry, template, folder)
	local model = template:Clone()
	model.Name = entry.Name
	local k = Kit.open(model)
	M[entry.Build](k)
	local count = k:close()
	local old = folder:FindFirstChild(entry.Name)
	if old then old:Destroy() end
	model.Parent = folder
	return model, count
end

function M.BuildAll(folder, template)
	local out = {}
	for _, entry in M.Order do
		local _, count = M.Build(entry, template, folder)
		table.insert(out, entry.Name .. " : " .. count .. " pièces")
	end
	return table.concat(out, "\n")
end

return M
