-- Outil d'édition (pas utilisé en jeu) : éléments communs des oeufs (visages, oreilles, familles dragon / cheval).
local Kit = require(script.Parent.EggBuilderKit)
local rgb, shade = Kit.rgb, Kit.shade
local rad = math.rad
local INK = rgb(30, 22, 40)

-- repère qui sort de la coquille : +Y = vers l'extérieur
function Kit:outward(yaw, y, inset)
	return self:surface(yaw, y, -(inset or 0.3)) * CFrame.Angles(rad(90), 0, 0)
end

function Kit:smile(y, w, color)
	self:plate("Relief", 0, y, w, 0.26, 0.3, color or INK)
	for _, s in {1, -1} do self:plate("Relief", 0, y, 0.55, 0.26, 0.3, color or INK, {Dx = s * (w / 2 + 0.12), Dy = 0.16, Rot = s * 38}) end
end

-- taches en relief : {yaw, y, taille, ratio?}
function Kit:spots(color, list, d)
	for _, s in list do
		self:plate("Relief", s[1], s[2], s[3], s[3] * (s[4] or 1), d or 0.22, color)
		self:plate("Relief", s[1], s[2], s[3] * 0.55, s[3] * 0.55 * (s[4] or 1), (d or 0.22) + 0.12, shade(color, 1.22))
	end
end

-- oreilles pointues (renard, loup, cheval, chat...)
function Kit:pointEars(cfg)
	for _, s in {1, -1} do
		local base = CFrame.new(s * (cfg.X or 2.3), cfg.Y or 5.7, cfg.Z or 0.3) * CFrame.Angles(rad(cfg.Tilt or 10), 0, rad(-s * (cfg.Lean or 18)))
		local w, h = cfg.W or 1.7, cfg.H or 2.4
		self:part("Decor", Vector3.new(w, h * 0.6, 0.7), base * CFrame.new(0, h * 0.3, 0), cfg.Color)
		self:part("Decor", Vector3.new(w * 0.72, h * 0.4, 0.7), base * CFrame.new(0, h * 0.72, 0), cfg.Color)
		self:part("Decor", Vector3.new(w * 0.5, w * 0.5, 0.7), base * CFrame.new(0, h * 0.95, 0) * CFrame.Angles(0, 0, rad(45)), cfg.TipColor or cfg.Color)
		self:part("Decor", Vector3.new(w * 0.55, h * 0.55, 0.3), base * CFrame.new(0, h * 0.42, 0.3), cfg.Inner or rgb(255, 180, 190))
	end
end

-- corne courbe : part du haut de l'oeuf, vers l'arrière et l'extérieur
function Kit:horns(cfg)
	for _, s in {1, -1} do
		local steps = {}
		local n = cfg.Segments or 4
		for i = 1, n do
			local f = (i - 1) / (n - 1)
			table.insert(steps, {(cfg.Len or 1.7) * (1 - f * 0.25), (cfg.Thick or 1.1) * (1 - f * 0.68), cfg.BendX or 16, -s * (cfg.BendZ or 6), i == n and (cfg.Tip or cfg.Color) or cfg.Color})
		end
		local start = CFrame.new(s * (cfg.X or 2.0), cfg.Y or 5.8, cfg.Z or -0.4) * CFrame.Angles(rad(cfg.Back or -20), 0, rad(-s * (cfg.Out or 22)))
		self:chain("Decor", start, steps)
		if cfg.Ring then -- anneaux sur la corne
			local cf = start
			for i = 1, n - 1 do
				cf = cf * CFrame.new(0, steps[i][1], 0)
				self:part("Decor", Vector3.new(steps[i][2] + 0.3, 0.32, steps[i][2] + 0.3), cf, cfg.Ring)
				cf = cf * CFrame.Angles(rad(steps[i][3]), 0, rad(steps[i][4]))
			end
		end
	end
end

-- queue enroulée autour du nid (dragon, démon, renard...) : du dos vers l'avant, de plus en plus fine
function Kit:wrapTail(cfg)
	local outer = cfg.Radius
	local n = cfg.Segments or 7
	local dir = cfg.Dir or 1
	for i = 0, n - 1 do
		local f = i / (n - 1)
		local yaw = 180 - dir * (20 + f * (cfg.Sweep or 130))
		local th = (cfg.Thick or 1.6) * (1 - f * 0.6)
		local arc = 2 * outer * math.sin(rad((cfg.Sweep or 130) / (n - 1)) / 2) + 0.5
		self:part("Decor", Vector3.new(arc, th, th), CFrame.Angles(0, rad(yaw), 0) * CFrame.new(0, (cfg.Y or -4.4) + th / 2 - 0.4, outer), i % 2 == 0 and cfg.Color or (cfg.Alt or cfg.Color))
		if cfg.Spike and i < n - 1 then
			self:part("Decor", Vector3.new(0.5, 0.7, 0.5), CFrame.Angles(0, rad(yaw), 0) * CFrame.new(0, (cfg.Y or -4.4) + th + 0.1, outer) * CFrame.Angles(0, 0, rad(45)), cfg.Spike)
		end
	end
	local tipYaw = 180 - dir * (20 + (cfg.Sweep or 130) + 9)
	local tip = CFrame.Angles(0, rad(tipYaw), 0) * CFrame.new(0, (cfg.Y or -4.4), outer)
	if cfg.TipColor then
		self:part("Decor", Vector3.new(1.3, 1.3, 0.6), tip * CFrame.Angles(0, 0, rad(45)), cfg.TipColor, {Neon = cfg.TipNeon})
	end
end

-- OEUF DE DRAGON complet à partir d'une palette
function Kit:dragon(p)
	self:shell(function(i) return p.Deep:Lerp(p.Main, math.clamp((i - 1) / 8, 0, 1)) end)
	-- écailles sur le dos et les flancs
	for row = 0, 4 do
		local y = -3 + row * 1.6
		for kk = 0, 8 do
			local yaw = 64 + kk * 29 + (row % 2) * 14.5
			if yaw <= 296 then self:plate("Relief", yaw, y, 1.5, 1.05, 0.24, (kk + row) % 2 == 0 and p.Scale or shade(p.Scale, 1.18)) end
		end
	end
	-- ventre segmenté
	for i, b in {{-4.6, 4.4}, {-3.6, 5.0}, {-2.6, 5.2}, {-1.6, 4.8}, {-0.6, 3.8}} do
		self:plate("Relief", 0, b[1], b[2], 0.82, 0.24, i % 2 == 0 and p.Belly or shade(p.Belly, 0.92))
	end
	for _, s in {1, -1} do
		self:eye(s, {Y = 3.0, Yaw = 25, Iris = p.Eye, Glow = true, Slit = true, White = p.EyeWhite or rgb(255, 250, 220), Brow = p.Deep, BrowAngle = 22, Rim = p.Rim or INK})
	end
	-- museau, naseaux, crocs
	self:part("Decor", Vector3.new(2.8, 1.5, 1.7), self:surface(0, 1.0, 0.55), p.Main)
	self:part("Decor", Vector3.new(2.4, 0.5, 1.5), self:surface(0, 1.85, 0.5), shade(p.Main, 1.12))
	self:part("Decor", Vector3.new(2.6, 0.6, 1.4), self:surface(0, 0.1, 0.4), p.Deep)
	for _, s in {1, -1} do
		self:part("Decor", Vector3.new(0.4, 0.4, 0.3), self:surface(0, 1.45, 1.42) * CFrame.new(s * 0.65, 0, 0), INK)
		self:part("Decor", Vector3.new(0.38, 0.7, 0.38), self:surface(0, 0.3, 1.2) * CFrame.new(s * 1.0, -0.15, 0), rgb(255, 255, 250))
		self:part("Decor", Vector3.new(0.3, 0.5, 0.3), self:surface(0, 0.3, 1.2) * CFrame.new(s * 0.4, -0.08, 0), rgb(255, 255, 250))
	end
	self:horns({Color = p.Horn, Tip = shade(p.Horn, 1.25), Segments = 5, Len = 1.8, Thick = 1.2, BendX = 14, Back = -28, Out = 24, X = 2.1, Y = 5.6, Ring = p.HornRing})
	-- crête dorsale
	for i = 0, 6 do
		local y = 6.2 - i * 1.5
		local cf = self:surface(180, math.max(y, -4), 0.1)
		if i == 0 then cf = CFrame.new(0, 6.9, -0.6) end
		self:part("Decor", Vector3.new(0.5, 1.3 - i * 0.08, 1.3 - i * 0.08), cf * CFrame.Angles(rad(45), 0, 0), p.Spike)
	end
	for _, s in {1, -1} do self:batWing(s, {Bone = p.Bone, Claw = p.Claw, Dark = p.WingDark, Light = p.WingLight, Y = 1.8}) end
	local outer = self:nest(p.Nest1, p.Nest2, {Seed = p.Seed or 20})
	self:wrapTail({Radius = outer + 1.5, Color = p.Main, Alt = p.Deep, Spike = p.Spike, TipColor = p.Spike, Thick = 1.7, Sweep = 140})
	return outer
end

-- OEUF DE CHEVAL (licorne, pégase, céleste) à partir d'une palette
function Kit:horse(p)
	self:shell(function(i) return p.Tint:Lerp(p.Main, math.clamp((i - 1) / 7, 0, 1)) end)
	for _, s in {1, -1} do self:eye(s, {Y = 2.0, Yaw = 25, Size = 1.12, Iris = p.Eye, Lashes = true, Rim = p.Rim or rgb(60, 40, 80)}) end
	self:blush({Y = 0.2, Yaw = 48, Color = p.Blush or rgb(255, 160, 200)})
	self:part("Decor", Vector3.new(2.6, 1.7, 0.9), self:surface(0, 0.2, 0.3), p.Muzzle)
	for _, s in {1, -1} do self:part("Decor", Vector3.new(0.34, 0.5, 0.2), self:surface(0, 0.5, 0.8) * CFrame.new(s * 0.6, 0, 0), p.Nostril or rgb(200, 130, 160)) end
	self:plate("Relief", 0, -0.35, 1.0, 0.24, 0.9, p.Rim or rgb(60, 40, 80), {Out = 0.3})
	self:pointEars({Color = p.Main, Inner = p.EarInner or rgb(255, 190, 215), X = 2.4, Y = 5.6, H = 2.2, W = 1.4})
	-- crinière : mèches qui descendent dans le dos et sur un côté
	local m = p.Mane
	local idx = 0
	for _, yaw in {130, 155, 180, 205, 230} do
		idx += 1
		local c = m[(idx - 1) % #m + 1]
		local start = self:outward(yaw, 5.2, 0.4) * CFrame.Angles(rad(70), 0, 0)
		self:chain("Decor", start, {{1.9, 1.3, 14, (yaw - 180) * 0.12, c}, {1.8, 1.2, 12, 0, shade(c, 1.1)}, {1.7, 1.05, 10, 0, c}, {1.5, 0.85, -25, 0, shade(c, 1.1)}, {1.1, 0.6, 0, 0, c}})
	end
	for i, dx in {-1.0, 0, 1.0} do -- toupet
		local c = m[(i + 1) % #m + 1]
		self:chain("Decor", CFrame.new(dx, 6.6, 0.9) * CFrame.Angles(rad(60), 0, rad(-dx * 16)), {{1.3, 1.0, 35, 0, c}, {1.0, 0.8, 0, 0, shade(c, 1.1)}})
	end
	for i, a in {-18, 0, 18} do -- queue
		local c = m[(i + 2) % #m + 1]
		self:chain("Decor", self:outward(180 + a, -2.8) * CFrame.Angles(rad(35), 0, rad(a * 0.5)), {{1.6, 1.0, 25, 0, c}, {1.5, 0.9, 20, 0, shade(c, 1.1)}, {1.3, 0.7, 0, 0, c}})
	end
	if p.Horn then -- corne torsadée
		local cf = CFrame.new(0, 6.7, 1.3) * CFrame.Angles(rad(14), 0, 0)
		for i = 0, 6 do
			local w = 1.25 - i * 0.15
			self:part("Decor", Vector3.new(w, 0.8, w), cf * CFrame.new(0, 0.4 + i * 0.72, 0) * CFrame.Angles(0, rad(i * 32), 0), i % 2 == 0 and p.Horn or shade(p.Horn, 1.3))
		end
		self:part("Decor", Vector3.new(0.3, 0.7, 0.3), cf * CFrame.new(0, 5.6, 0), rgb(255, 255, 255), {Neon = true})
	end
	if p.Wing then
		for _, s in {1, -1} do self:featherWing(s, {Size = 1, Y = 1.4, Main = p.Wing, Alt = p.WingAlt, Tip = p.WingTip or p.WingAlt, Cover = p.WingCover or p.Wing}) end
	end
	-- nid de nuages
	local outer = self:nest(p.Nest1, p.Nest2, {Seed = p.Seed or 30})
	for i = 0, 7 do
		local cf = CFrame.Angles(0, rad(i * 45 + 10), 0) * CFrame.new(0, -4.6, outer + 0.2)
		local s = 1.5 + (i % 3) * 0.3
		self:part("Nest", Vector3.new(s * 1.5, s, s), cf, p.Cloud or rgb(255, 255, 255), {Studs = true})
		self:part("Nest", Vector3.new(s * 0.9, s * 0.8, s * 0.9), cf * CFrame.new(s * 0.3, s * 0.55, 0), p.Cloud or rgb(255, 255, 255))
	end
	return outer
end

-- petites étoiles / éclats lumineux flottant autour de l'oeuf
function Kit:sparkles(color, list, neon)
	for _, s in list do
		local cf = CFrame.Angles(0, rad(s[1]), 0) * CFrame.new(0, s[2], s[3])
		self:part("Decor", Vector3.new(s[4], s[4] * 0.3, 0.2), cf, color, {Neon = neon ~= false})
		self:part("Decor", Vector3.new(s[4] * 0.3, s[4], 0.2), cf, color, {Neon = neon ~= false})
	end
end

return Kit
