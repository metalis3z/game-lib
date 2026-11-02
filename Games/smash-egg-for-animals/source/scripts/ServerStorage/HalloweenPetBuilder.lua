-- Outil d'édition (pas utilisé en jeu) : construit les 5 pets Halloween en studs avec PetBuilderKit.
-- Usage (barre de commande) : require(game.ServerStorage.HalloweenPetBuilder).BuildAll(folder)
-- Articulations animées par PetClient : Leg, Arm, Wing, WingTip, Tail, Neck, Head (voir PetBuilderKit).
local Kit = require(script.Parent:WaitForChild("PetBuilderKit"))
local rgb, shade = Kit.rgb, Kit.shade
local rad = math.rad
local INK = rgb(30, 22, 40)
local TAN8 = math.tan(math.pi / 8)

local M = {}

---------------------------------------------------------------- aides
-- prisme à 8 côtés (rayon = distance centre -> face), +Z = une face
local function oct(k, to, cf, r, h, color, opts)
	if typeof(cf) == "Vector3" then cf = CFrame.new(cf) end
	opts = opts or {}
	for i = 0, 3 do
		k:box(to, Vector3.new(2 * r, h, 2 * r * TAN8), cf * CFrame.Angles(0, i * math.pi / 4, 0), i % 2 == 0 and color or shade(color, opts.Alt or 0.94), {Studs = opts.Studs, Neon = opts.Neon, Transparency = opts.Transparency})
	end
end

-- chapeau de sorcière : bord, cône qui retombe, ruban et boucle
local function witchHat(k, to, base, s)
	local hat, hatLight, band, gold = rgb(40, 30, 55), rgb(62, 46, 82), rgb(150, 70, 215), rgb(255, 210, 70)
	oct(k, to, base, 2.6 * s, 0.3 * s, hat, {Studs = true, Alt = 1.25})
	local cf = base * CFrame.new(0, 0.15 * s, 0)
	local N = 8
	for j = 0, N - 1 do
		local t = j / (N - 1)
		local r = (1.6 * (1 - t) + 0.18) * s
		local h = 0.55 * s
		local color = j == 0 and band or (j % 2 == 0 and hat or hatLight)
		oct(k, to, cf * CFrame.new(0, h / 2, 0), j == 0 and r + 0.08 * s or r, h, color, {Studs = j == N - 1})
		cf = cf * CFrame.new(0, h, 0) * CFrame.Angles(rad(-t * t * 30), 0, 0)
	end
	k:box(to, Vector3.new(0.4, 0.4, 0.4) * s, cf * CFrame.new(0, 0.1 * s, 0) * CFrame.Angles(rad(45), 0, rad(45)), gold)
	local buckle = base * CFrame.new(0, 0.45 * s, 1.75 * s)
	k:box(to, Vector3.new(0.75, 0.55, 0.15) * s, buckle, gold)
	k:box(to, Vector3.new(0.42, 0.28, 0.2) * s, buckle, band)
end

-- visage de citrouille creusé (face = centre du visage, +Z vers l'avant)
local function carvedFace(k, to, face, s)
	local RIM, GLOW, GLOW2 = rgb(55, 22, 10), rgb(255, 150, 20), rgb(255, 205, 70)
	for _, side in {1, -1} do
		for r, row in {{0.55, 1.05}, {0.85, 0.7}, {1.12, 0.36}} do
			k:box(to, Vector3.new(row[2] + 0.2, 0.36, 0.1) * s, face * CFrame.new(side * 0.85 * s, row[1] * s, 0.02), RIM)
			k:box(to, Vector3.new(row[2], 0.3, 0.16) * s, face * CFrame.new(side * 0.85 * s, row[1] * s, 0.04), r == 1 and GLOW or GLOW2, {Neon = true})
		end
	end
	k:box(to, Vector3.new(0.55, 0.28, 0.16) * s, face * CFrame.new(0, 0.05 * s, 0.04), GLOW, {Neon = true})
	k:box(to, Vector3.new(0.25, 0.22, 0.16) * s, face * CFrame.new(0, 0.28 * s, 0.04), GLOW, {Neon = true})
	for i = -4, 4 do
		local f = i / 4
		local y = (-0.75 + 0.35 * f * f) * s
		local h = (0.6 - 0.25 * f * f) * s
		k:box(to, Vector3.new(0.36 * s, h + 0.14 * s, 0.1), face * CFrame.new(i * 0.33 * s, y, 0.02), RIM)
		k:box(to, Vector3.new(0.34 * s, h, 0.16), face * CFrame.new(i * 0.33 * s, y, 0.04), GLOW, {Neon = true})
		if i == -2 or i == 2 then k:box(to, Vector3.new(0.3 * s, h * 0.45, 0.22), face * CFrame.new(i * 0.33 * s, y + h * 0.3, 0.05), rgb(255, 125, 15)) end
		if i == 0 then k:box(to, Vector3.new(0.3 * s, h * 0.45, 0.22), face * CFrame.new(0, y - h * 0.3, 0.05), rgb(255, 125, 15)) end
	end
end

local function bone(k, to, cf, len, color, thick)
	thick = thick or 0.4
	k:box(to, Vector3.new(thick, thick, len), cf, color)
	for _, ez in {1, -1} do
		for _, ex in {1, -1} do
			k:box(to, Vector3.new(thick * 1.15, thick * 1.15, thick * 1.15), cf * CFrame.new(ex * thick * 0.5, 0, ez * len / 2), color)
		end
	end
end

---------------------------------------------------------------- 1. PUMPKIN : citrouille sur pattes de lianes
function M.Pumpkin(k)
	local top, bottom = rgb(255, 130, 20), rgb(215, 80, 10)
	local R = 2.5
	oct(k, nil, Vector3.new(0, 0, 0), R, 2.4, rgb(245, 110, 15), {Studs = true})
	oct(k, nil, Vector3.new(0, 1.55, 0), R * 0.8, 0.7, top, {Studs = true})
	oct(k, nil, Vector3.new(0, -1.55, 0), R * 0.8, 0.7, bottom)
	oct(k, nil, Vector3.new(0, 2.0, 0), R * 0.5, 0.3, top, {Studs = true})
	-- côtes
	for i = 0, 7 do
		if i ~= 0 then
			local cf = CFrame.Angles(0, i * math.pi / 4, 0) * CFrame.new(0, 0, R + 0.06)
			k:box(nil, Vector3.new(0.35, 2.3, 0.14), cf, rgb(190, 75, 10))
			k:box(nil, Vector3.new(0.3, 0.6, 0.14), cf * CFrame.new(0, 1.35, -0.45) * CFrame.Angles(rad(-35), 0, 0), rgb(200, 85, 12))
		end
	end
	carvedFace(k, nil, CFrame.new(0, 0.25, R + 0.04), 1.05)
	-- lumière à l'intérieur
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness = rgb(255, 160, 40), 8, 1.2
	light.Parent = k.Root
	-- tige, feuille et vrille
	local brown, brown2 = rgb(105, 70, 35), rgb(80, 52, 28)
	k:chain(nil, CFrame.new(0, 2.1, 0) * CFrame.Angles(0, 0, rad(-8)), {{0.5, 0.7, 0, -18, brown}, {0.5, 0.6, 0, -24, brown2}, {0.4, 0.5, 0, 0, brown}})
	k:box(nil, Vector3.new(1.6, 0.18, 0.9), CFrame.new(-0.9, 2.3, 0.4) * CFrame.Angles(rad(-8), rad(25), rad(16)), rgb(95, 190, 70), {Studs = true})
	k:box(nil, Vector3.new(1.6, 0.2, 0.12), CFrame.new(-0.9, 2.32, 0.4) * CFrame.Angles(rad(-8), rad(25), rad(16)), rgb(60, 140, 50))
	k:chain(nil, CFrame.new(0.5, 2.2, 0.3) * CFrame.Angles(rad(15), 0, rad(-70)), {{0.4, 0.2, 0, 50, rgb(60, 140, 50)}, {0.4, 0.2, 0, 55, rgb(95, 190, 70)}, {0.35, 0.18, 0, 60, rgb(60, 140, 50)}, {0.3, 0.16, 0, 65, rgb(95, 190, 70)}})
	-- jambes en lianes avec pieds en feuilles
	local vine, vineDark, leaf = rgb(80, 150, 55), rgb(55, 110, 40), rgb(110, 200, 75)
	for _, side in {1, -1} do
		local hip = Vector3.new(side * 1.1, -1.7, 0)
		local j = k:joint("Leg", hip, {Phase = side == 1 and 0 or math.pi})
		k:box(j, Vector3.new(0.7, 1.3, 0.7), hip + Vector3.new(0, -0.6, 0), vine)
		k:box(j, Vector3.new(0.8, 0.25, 0.8), hip + Vector3.new(0, -0.35, 0), vineDark)
		k:box(j, Vector3.new(1.2, 0.4, 1.7), hip + Vector3.new(0, -1.35, 0.3), leaf, {Studs = true})
		k:box(j, Vector3.new(0.15, 0.42, 1.5), hip + Vector3.new(0, -1.34, 0.3), vineDark)
	end
	-- bras en lianes, une main tient un bonbon
	for _, side in {1, -1} do
		local sh = Vector3.new(side * 2.4, 0.1, 0.2)
		local j = k:joint("Arm", sh, {Side = side, Phase = side == 1 and 0 or math.pi, Held = side == 1})
		local tip = k:chain(j, CFrame.new(sh) * CFrame.Angles(rad(-20), 0, rad(-side * 120)), {{0.6, 0.4, 0, side * 20, vine}, {0.6, 0.38, 0, side * 25, vineDark}, {0.4, 0.36, 0, 0, vine}})
		k:box(j, Vector3.new(0.7, 0.5, 0.7), tip * CFrame.new(0, 0.2, 0), leaf, {Studs = true})
		if side == 1 then -- sucette en spirale
			local pop = CFrame.new((tip * CFrame.new(0, 0.3, 0)).Position)
			k:box(j, Vector3.new(0.15, 1.3, 0.15), pop * CFrame.new(0, 0.65, 0), rgb(250, 245, 235))
			k:box(j, Vector3.new(1.0, 1.0, 0.25), pop * CFrame.new(0, 1.6, 0), rgb(255, 120, 20))
			k:box(j, Vector3.new(0.7, 0.7, 0.3), pop * CFrame.new(0, 1.6, 0) * CFrame.Angles(0, 0, rad(45)), rgb(150, 70, 215))
			k:box(j, Vector3.new(0.35, 0.35, 0.35), pop * CFrame.new(0, 1.6, 0), rgb(255, 245, 230))
		end
	end
end

---------------------------------------------------------------- 2. GHOST : petit fantôme qui flotte avec son seau de bonbons
function M.Ghost(k)
	local W, W2, LAV = rgb(250, 250, 255), rgb(232, 228, 250), rgb(205, 195, 240)
	oct(k, nil, Vector3.new(0, 0.3, 0), 1.9, 2.6, W, {Studs = true, Alt = 0.97})
	oct(k, nil, Vector3.new(0, 1.95, 0), 1.5, 0.7, W, {Studs = true, Alt = 0.97})
	oct(k, nil, Vector3.new(0, 2.45, 0), 0.95, 0.4, W, {Studs = true})
	k:chain(nil, CFrame.new(0, 2.6, -0.1) * CFrame.Angles(rad(-15), 0, rad(15)), {{0.45, 0.6, -20, 15, W}, {0.4, 0.42, -25, 20, W2}, {0.3, 0.3, 0, 0, LAV}})
	-- bas du drap en languettes qui ondulent
	local skirt = k:joint("Tail", Vector3.new(0, -0.9, 0))
	for i = 0, 7 do
		local long = i % 2 == 0
		local cf = CFrame.Angles(0, i * math.pi / 4 + math.pi / 8, 0) * CFrame.new(0, long and -1.55 or -1.3, 1.55)
		k:box(skirt, Vector3.new(1.35, long and 1.1 or 0.6, 0.6), cf, long and W2 or W)
		if long then k:box(skirt, Vector3.new(0.6, 0.35, 0.5), cf * CFrame.new(0, -0.65, -0.05), LAV) end
	end
	oct(k, skirt, Vector3.new(0, -1.2, 0), 1.6, 0.6, W2)
	-- visage
	local face = CFrame.new(0, 0.5, 1.9)
	for _, side in {1, -1} do
		local c = face * CFrame.new(side * 0.75, 0.25, 0)
		k:box(nil, Vector3.new(0.8, 1.15, 0.1), c * CFrame.new(0, 0, 0.03), INK)
		k:box(nil, Vector3.new(0.6, 1.35, 0.1), c * CFrame.new(0, 0, 0.03), INK)
		k:box(nil, Vector3.new(0.5, 0.9, 0.14), c * CFrame.new(0, -0.05, 0.05), rgb(60, 45, 100))
		k:box(nil, Vector3.new(0.26, 0.26, 0.18), c * CFrame.new(-side * 0.13, 0.3, 0.07), W)
		k:box(nil, Vector3.new(0.13, 0.13, 0.18), c * CFrame.new(side * 0.15, -0.3, 0.07), W)
		k:box(nil, Vector3.new(0.55, 0.28, 0.08), face * CFrame.new(side * 1.25, -0.45, 0.02), rgb(255, 170, 200))
	end
	k:box(nil, Vector3.new(0.6, 0.75, 0.1), face * CFrame.new(0, -0.65, 0.03), INK)
	k:box(nil, Vector3.new(0.45, 0.9, 0.1), face * CFrame.new(0, -0.65, 0.03), INK)
	k:box(nil, Vector3.new(0.35, 0.25, 0.14), face * CFrame.new(0, -0.88, 0.05), rgb(255, 120, 150))
	-- petits bras ; la main droite tient un seau-citrouille
	for _, side in {1, -1} do
		local sh = Vector3.new(side * 1.9, 0.5, 0.2)
		local j = k:joint("Arm", sh, {Side = side, Phase = side == 1 and 0 or math.pi, Held = side == 1})
		local tip = k:chain(j, CFrame.new(sh) * CFrame.Angles(rad(-25), 0, rad(-side * 125)), {{0.5, 0.65, 0, 0, W}, {0.4, 0.55, 0, 0, W2}})
		if side == 1 then
			local b = tip * CFrame.Angles(0, 0, rad(side * 125)) * CFrame.new(0.1, -0.9, 0.2)
			oct(k, j, b, 0.6, 0.85, rgb(255, 125, 15), {Studs = true})
			k:box(j, Vector3.new(0.12, 0.12, 0.12), b * CFrame.new(0, 0, 0), INK)
			for _, sx in {1, -1} do k:box(j, Vector3.new(0.18, 0.18, 0.06), b * CFrame.new(sx * 0.22, 0.12, 0.6), rgb(255, 210, 70), {Neon = true}) end
			k:box(j, Vector3.new(0.4, 0.1, 0.06), b * CFrame.new(0, -0.18, 0.6), rgb(255, 210, 70), {Neon = true})
			k:box(j, Vector3.new(0.08, 0.7, 0.08), b * CFrame.new(-0.55, 0.65, 0), INK)
			k:box(j, Vector3.new(0.08, 0.7, 0.08), b * CFrame.new(0.55, 0.65, 0), INK)
			k:box(j, Vector3.new(1.15, 0.08, 0.08), b * CFrame.new(0, 1.0, 0), INK)
			for i, c in {rgb(255, 80, 120), rgb(110, 210, 70), rgb(150, 70, 215)} do -- bonbons qui dépassent
				k:box(j, Vector3.new(0.3, 0.3, 0.3), b * CFrame.new((i - 2) * 0.3, 0.48, (i % 2) * 0.15) * CFrame.Angles(0, rad(i * 30), rad(45)), c)
			end
		end
	end
	-- feux follets autour
	for i, a in {40, 160, 280} do
		k:box(nil, Vector3.new(0.3, 0.3, 0.3), CFrame.Angles(0, rad(a), 0) * CFrame.new(0, 1.2 + i * 0.4, 2.6) * CFrame.Angles(rad(45), rad(45), 0), rgb(170, 140, 255), {Neon = true})
	end
end

---------------------------------------------------------------- 3. WITCH CAT : chat noir avec chapeau de sorcière
function M.WitchCat(k)
	local BLACK, BLACK2, BELLY = rgb(42, 36, 54), rgb(58, 50, 74), rgb(75, 66, 92)
	local r = k:quad({W = 3.0, H = 2.7, L = 4.6, Body = BLACK, Back = BLACK2, Belly = BELLY, Leg = 1.7, LegW = 0.95, Hoof = rgb(85, 75, 105),
		Head = Vector3.new(3.6, 3.1, 3.0), HeadColor = BLACK, HeadTop = BLACK2, HeadUp = 0.7, TailJoints = 5, TailRise = 0.75, TailStep = 0.45, TailY = 0.9})
	-- queue en crochet
	for i, t in r.Tails do
		local s = 0.75 - i * 0.07
		k:box(t.Joint, Vector3.new(s, s, 0.8), CFrame.new(t.Pos + Vector3.new(0, 0.35, -0.2)) * CFrame.Angles(rad(-35 - i * 12), 0, 0), i == #r.Tails and rgb(150, 70, 215) or BLACK)
	end
	k:pointEars(r.Head, r.HeadCenter, r.HeadSize, {Color = BLACK, Inner = rgb(200, 120, 190), Spread = 0.32, Lean = 12, W = 1.15, H = 1.5})
	-- visage : yeux verts lumineux, museau, moustaches
	for _, side in {1, -1} do
		k:eye(r.Head, r.Face, side, {Dx = 0.82, Dy = 0.35, Size = 0.9, Iris = rgb(110, 240, 90), Glow = true, Slit = true, Lashes = side == 1})
		for i = -1, 1 do
			k:box(r.Head, Vector3.new(1.3, 0.07, 0.07), r.Face * CFrame.new(side * 1.55, -0.45 + i * 0.22, 0.12) * CFrame.Angles(0, 0, rad(side * i * 12)), rgb(235, 230, 245))
		end
	end
	k:box(r.Head, Vector3.new(1.5, 0.8, 0.4), r.Face * CFrame.new(0, -0.6, 0.15), BLACK2)
	k:box(r.Head, Vector3.new(0.45, 0.3, 0.2), r.Face * CFrame.new(0, -0.35, 0.38), rgb(255, 140, 180))
	k:smile(r.Head, r.Face * CFrame.new(0, 0, 0.36), -0.75, 0.5, rgb(20, 14, 26))
	k:blush(r.Head, r.Face * CFrame.new(0, 0, 0.02), {Dx = 1.3, Dy = -0.35, Color = rgb(200, 100, 170)})
	-- chapeau sur la tête, un peu penché
	local hc, hs = r.HeadCenter, r.HeadSize
	witchHat(k, r.Head, CFrame.new(hc + Vector3.new(0.15, hs.Y / 2 + 0.1, -0.3)) * CFrame.Angles(rad(-10), 0, rad(-12)), 0.68)
	-- collier violet et grelot doré
	local L, H = r.L, r.H
	k:box(nil, Vector3.new(3.25, 0.5, 0.7), Vector3.new(0, H / 2 - 0.5, L / 2 - 0.15), rgb(150, 70, 215))
	k:box(nil, Vector3.new(0.65, 0.65, 0.65), CFrame.new(0, H / 2 - 1.0, L / 2 + 0.25) * CFrame.Angles(0, rad(45), 0), rgb(255, 210, 70))
	k:box(nil, Vector3.new(0.5, 0.12, 0.7), Vector3.new(0, H / 2 - 1.05, L / 2 + 0.25), rgb(200, 150, 40))
	-- étoile dorée sur le flanc
	for _, side in {1, -1} do
		local c = CFrame.new(side * 1.52, 0.2, -0.4) * CFrame.Angles(0, rad(side * 90), 0)
		k:box(nil, Vector3.new(0.6, 0.6, 0.06), c, rgb(255, 210, 70))
		k:box(nil, Vector3.new(0.6, 0.6, 0.06), c * CFrame.Angles(0, 0, rad(45)), rgb(255, 210, 70))
	end
end

---------------------------------------------------------------- 4. SKELETON DOG : chien squelette aux yeux rouges
function M.SkeletonDog(k)
	local BONE, BONE2, DARK = rgb(240, 235, 215), rgb(205, 198, 175), rgb(38, 34, 48)
	local r = k:quad({W = 2.4, H = 2.4, L = 5.0, Body = DARK, Back = DARK, Leg = 2.2, LegW = 0.7, LegColor = BONE, Hoof = BONE2,
		Head = Vector3.new(2.9, 2.6, 2.6), HeadColor = BONE, HeadTop = BONE, Neck = 1.0, NeckW = 1.0, NeckTilt = 35, TailJoints = 4, TailRise = 0.35, TailStep = 0.75, TailY = 0.8})
	local W, H, L = r.W, r.H, r.L
	-- cage thoracique : côtes autour du corps sombre
	for i = 0, 5 do
		local z = 1.6 - i * 0.62
		k:box(nil, Vector3.new(W + 0.2, 0.32, 0.38), Vector3.new(0, H / 2 - 0.05, z), BONE)
		for _, side in {1, -1} do
			k:box(nil, Vector3.new(0.3, H * 0.75, 0.38), CFrame.new(side * (W / 2 + 0.05), 0.1, z) * CFrame.Angles(rad(-10), 0, 0), i % 2 == 0 and BONE or BONE2)
		end
		k:box(nil, Vector3.new(W * 0.55, 0.3, 0.38), Vector3.new(0, -H / 2 + 0.25, z), BONE2)
	end
	-- colonne vertébrale
	for z = -2.3, 2.3, 0.55 do k:box(nil, Vector3.new(0.55, 0.38, 0.4), Vector3.new(0, H / 2 + 0.2, z), BONE, {Studs = true}) end
	-- bassin et épaules
	k:box(nil, Vector3.new(W + 0.35, 0.9, 0.9), Vector3.new(0, 0.2, -L / 2 + 0.45), BONE2, {Studs = true})
	k:box(nil, Vector3.new(W + 0.35, 0.9, 0.9), Vector3.new(0, 0.3, L / 2 - 0.45), BONE2, {Studs = true})
	-- queue en os
	for i, t in r.Tails do
		k:box(t.Joint, Vector3.new(0.42, 0.42, 0.7), t.Pos + Vector3.new(0, 0.15, -0.35), BONE)
		k:box(t.Joint, Vector3.new(0.55, 0.3, 0.25), t.Pos + Vector3.new(0, 0.15, -0.05), BONE2)
	end
	-- crâne : museau, orbites, dents
	local face, hc, hs = r.Face, r.HeadCenter, r.HeadSize
	local snout = face * CFrame.new(0, -0.55, 0.7)
	k:box(r.Head, Vector3.new(1.7, 1.15, 1.5), snout, BONE, {Studs = true})
	k:box(r.Head, Vector3.new(0.75, 0.45, 0.2), snout * CFrame.new(0, 0.3, 0.72), INK)
	k:box(r.Head, Vector3.new(0.4, 0.25, 0.2), snout * CFrame.new(0, 0.05, 0.72), INK)
	k:box(r.Head, Vector3.new(1.75, 0.38, 1.45), snout * CFrame.new(0, -0.5, 0.02), INK)
	for i = -2, 2 do
		k:box(r.Head, Vector3.new(0.24, 0.32, 0.12), snout * CFrame.new(i * 0.32, -0.42, 0.75), BONE)
		k:box(r.Head, Vector3.new(0.24, 0.28, 0.12), snout * CFrame.new(i * 0.32 + 0.16, -0.72, 0.75), BONE2)
	end
	k:box(r.Head, Vector3.new(1.5, 0.35, 1.3), snout * CFrame.new(0, -0.9, -0.05), BONE2) -- mâchoire
	for _, side in {1, -1} do
		local c = face * CFrame.new(side * 0.68, 0.35, 0.03)
		k:box(r.Head, Vector3.new(0.95, 0.85, 0.12), c, INK)
		k:box(r.Head, Vector3.new(0.75, 1.05, 0.12), c, INK)
		k:box(r.Head, Vector3.new(0.38, 0.38, 0.18), c * CFrame.new(0, -0.05, 0.03), rgb(255, 40, 40), {Neon = true})
		k:box(r.Head, Vector3.new(0.16, 0.16, 0.22), c * CFrame.new(0, 0.05, 0.05), rgb(255, 200, 180), {Neon = true})
	end
	k:box(r.Head, Vector3.new(0.1, 0.6, 0.1), face * CFrame.new(0.9, 1.0, 0.03) * CFrame.Angles(0, 0, rad(25)), INK) -- fêlure
	k:pointEars(r.Head, hc, hs, {Color = BONE, Inner = DARK, Spread = 0.33, Lean = 18, W = 0.9, H = 1.2})
	-- collier à pointes
	local neckPos = Vector3.new(0, H / 2 - 0.3, L / 2 - 0.6)
	k:box(nil, Vector3.new(1.5, 0.5, 1.5), neckPos + Vector3.new(0, 0.5, 0.2), rgb(170, 25, 40))
	for i = 0, 3 do
		local a = i * math.pi / 2 + math.pi / 4
		k:box(nil, Vector3.new(0.25, 0.25, 0.5), CFrame.new(neckPos + Vector3.new(math.sin(a) * 0.8, 0.5, 0.2 + math.cos(a) * 0.8)) * CFrame.Angles(0, a, 0) * CFrame.Angles(rad(45), 0, 0), rgb(200, 205, 215))
	end
	-- os dans la gueule
	bone(k, r.Head, snout * CFrame.new(0, -0.6, 0.85) * CFrame.Angles(0, rad(90), 0), 2.0, rgb(250, 245, 230), 0.32)
end

---------------------------------------------------------------- 5. VAMPIRE BAT : chauve-souris vampire avec cape
function M.VampireBat(k)
	local FUR, FUR2, BELLY = rgb(58, 32, 72), rgb(78, 44, 95), rgb(110, 70, 125)
	oct(k, nil, Vector3.new(0, 0, 0), 1.7, 3.0, FUR, {Studs = true})
	oct(k, nil, Vector3.new(0, 1.7, 0), 1.35, 0.5, FUR2, {Studs = true})
	oct(k, nil, Vector3.new(0, -1.65, 0), 1.3, 0.4, FUR)
	k:box(nil, Vector3.new(1.8, 1.6, 0.2), Vector3.new(0, -0.55, 1.68), BELLY) -- ventre
	for i = 0, 2 do k:box(nil, Vector3.new(1.4 - i * 0.3, 0.12, 0.24), Vector3.new(0, -0.15 - i * 0.4, 1.7), shade(BELLY, 0.85)) end
	-- grandes oreilles
	for _, side in {1, -1} do
		local base = CFrame.new(side * 0.85, 1.85, 0) * CFrame.Angles(0, 0, rad(-side * 18))
		k:box(nil, Vector3.new(1.1, 1.2, 0.5), base * CFrame.new(0, 0.6, 0), FUR)
		k:box(nil, Vector3.new(0.75, 0.9, 0.5), base * CFrame.new(0, 1.5, 0), FUR)
		k:box(nil, Vector3.new(0.4, 0.4, 0.5), base * CFrame.new(0, 2.05, 0) * CFrame.Angles(0, 0, rad(45)), FUR2)
		k:box(nil, Vector3.new(0.6, 1.4, 0.15), base * CFrame.new(0, 0.9, 0.25), rgb(200, 70, 110))
	end
	-- visage : yeux rouges, sourcils, nez, crocs
	local face = CFrame.new(0, 0.75, 1.7)
	for _, side in {1, -1} do
		k:eye(nil, face, side, {Dx = 0.68, Dy = 0.15, Size = 0.82, Iris = rgb(255, 40, 60), Glow = true, Slit = true, Brow = rgb(25, 15, 30), BrowAngle = 24})
	end
	k:box(nil, Vector3.new(0.7, 0.45, 0.25), face * CFrame.new(0, -0.55, 0.1), rgb(150, 70, 120))
	for _, sx in {1, -1} do k:box(nil, Vector3.new(0.14, 0.14, 0.1), face * CFrame.new(sx * 0.15, -0.55, 0.24), INK) end
	k:box(nil, Vector3.new(1.0, 0.12, 0.1), face * CFrame.new(0, -0.95, 0.03), INK)
	for _, sx in {1, -1} do
		k:box(nil, Vector3.new(0.18, 0.4, 0.12), face * CFrame.new(sx * 0.32, -1.18, 0.05), rgb(255, 255, 250))
		k:box(nil, Vector3.new(0.1, 0.16, 0.12), face * CFrame.new(sx * 0.32, -1.42, 0.05), rgb(255, 255, 250))
	end
	k:box(nil, Vector3.new(0.1, 0.18, 0.13), face * CFrame.new(0.32, -1.6, 0.05), rgb(210, 0, 25), {Neon = true})
	-- ailes
	for _, side in {1, -1} do
		k:batWing(side, Vector3.new(side * 1.55, 0.5, -0.3), {L1 = 2.4, L2 = 2.8, Chord = 2.6, Dark = rgb(70, 25, 60), Light = rgb(130, 32, 62), Bone = rgb(38, 22, 45), Claw = rgb(235, 225, 210), Scallops = 2})
	end
	-- grand col de cape dans le dos
	for i = -3, 3 do
		local a = i * 0.32
		local cf = CFrame.Angles(0, math.pi + a, 0) * CFrame.new(0, 1.2, 1.85) * CFrame.Angles(rad(-12), 0, 0)
		local h = 2.2 - math.abs(i) * 0.2
		k:box(nil, Vector3.new(0.65, h, 0.15), cf * CFrame.new(0, h / 2 - 0.4, 0.06), rgb(20, 14, 26))
		k:box(nil, Vector3.new(0.6, h - 0.2, 0.1), cf * CFrame.new(0, h / 2 - 0.45, -0.07), rgb(190, 20, 45))
	end
	-- médaillon
	k:box(nil, Vector3.new(0.6, 0.6, 0.15), CFrame.new(0, -0.05, 1.82) * CFrame.Angles(0, 0, rad(45)), rgb(255, 205, 70))
	k:box(nil, Vector3.new(0.3, 0.3, 0.2), CFrame.new(0, -0.05, 1.84) * CFrame.Angles(0, 0, rad(45)), rgb(220, 10, 40), {Neon = true})
	-- petites pattes griffues
	for _, side in {1, -1} do
		local hip = Vector3.new(side * 0.7, -1.7, 0.2)
		local j = k:joint("Leg", hip, {Phase = side == 1 and 0 or math.pi})
		k:box(j, Vector3.new(0.45, 0.6, 0.45), hip + Vector3.new(0, -0.3, 0), FUR2)
		for _, cx in {-0.15, 0.15} do k:box(j, Vector3.new(0.14, 0.32, 0.14), hip + Vector3.new(cx, -0.7, 0.12), rgb(235, 225, 210)) end
	end
end

M.Order = {
	{Name = "Pumpkin", Build = "Pumpkin"},
	{Name = "Ghost", Build = "Ghost"},
	{Name = "WitchCat", Build = "WitchCat"},
	{Name = "SkeletonDog", Build = "SkeletonDog"},
	{Name = "VampireBat", Build = "VampireBat"},
}

function M.BuildAll(folder)
	local out = {}
	for _, entry in M.Order do
		local k = Kit.new(entry.Name)
		M[entry.Build](k)
		local count = k:finish(folder)
		table.insert(out, entry.Name .. " : " .. count .. " pièces")
	end
	return table.concat(out, "\n")
end

return M
