-- Outil d'édition (pas utilisé en jeu) : les trois dragons d'Halloween de la boutique.
--   require(game.ServerStorage.HalloweenDragons).build()            construit les trois dans ReplicatedStorage.Dragons
--   require(game.ServerStorage.HalloweenDragons).build("Zombie Dragon")   n'en reconstruit qu'un
-- Même base que les autres dragons (StarterDragonBuilder : mêmes articulations, mêmes animations, même pilotage),
-- avec leurs couleurs, leurs décorations en blocs et leurs effets permanents (flammes, brume, gouttes).
-- Coordonnées = celles de StarterDragonBuilder (avant mise à l'échelle) : avant = +Z, sol à y = -3,5.
local Builder = require(script.Parent.StarterDragonBuilder)
local Decor = require(script.Parent.DragonDecor)
local SCALE = 0.975
local V, rad, rgb = Vector3.new, math.rad, Color3.fromRGB
local A = CFrame.Angles
local Mat = Enum.Material
local M = {}

local out = function(s, deg) return A(0, 0, rad(-s * deg)) end   -- penché vers l'extérieur
local back = function(deg) return A(rad(-deg), 0, 0) end         -- penché vers l'arrière
local DOWN = A(math.pi, 0, 0)
local Y45, Z45 = A(0, rad(45), 0), A(0, 0, rad(45))
local WHITE, INK = rgb(255, 255, 255), rgb(24, 18, 30)
local STUD_VARIANT = game:GetService("MaterialService"):FindFirstChild("Studs") and "Studs" or "" -- plastique à studs sur toutes les faces

local FIRE_TEX = "rbxasset://textures/particles/fire_main.dds"
local SMOKE_TEX = "rbxasset://textures/particles/smoke_main.dds"
local SPARK_TEX = "rbxasset://textures/particles/sparkles_main.dds"
local DROP_TEX = "rbxassetid://16939835586"  -- goutte (bibliothèque d'effets du jeu)
local PUFF_TEX = "rbxassetid://13346862770"  -- volute animée 4x4

local function seq(...)
	local points = {}
	for _, p in {...} do table.insert(points, NumberSequenceKeypoint.new(p[1], p[2])) end
	return NumberSequence.new(points)
end
local function colors(...)
	local list, points = {...}, {}
	if #list == 1 then return ColorSequence.new(list[1]) end
	for i, c in list do table.insert(points, ColorSequenceKeypoint.new((i - 1) / (#list - 1), c)) end
	return ColorSequence.new(points)
end

-- outils communs aux trois dragons, posés par-dessus ceux de DragonDecor
-- dents du bord de fuite des ailes : chaque membrane se termine par des pointes (wedges), comme une vraie aile de dragon.
-- Marche sur n'importe quel dragon de ReplicatedStorage.Dragons, sans toucher à ses décorations ; relançable.
local TEETH = { -- articulation, {x du début de chaque dent}, longueur le long de l'aile, z du bord, profondeur de la pointe
	{"Wing", {2.5, 4.0}, 1.5, -2.5, 1.9},
	{"WingTip", {5.7, 7.1}, 1.4, -2.05, 1.6},
	{"WingTip", {8.45}, 1.5, -0.65, 1.3},
}
function M.wingTeeth(model, colors)
	local root = model.PrimaryPart
	local joints = {Wing = {}, WingTip = {}}
	for _, p in model:GetChildren() do
		if p:GetAttribute("WingTeeth") then
			p:Destroy()
		elseif p.Name == "JointPart" then
			local weld = p:FindFirstChildOfClass("Weld")
			local anim = weld and weld:GetAttribute("Anim")
			if joints[anim] then joints[anim][weld:GetAttribute("Side")] = p end
		end
	end
	local made = 0
	for _, s in {1, -1} do
		local index = 0
		for _, row in TEETH do
			local joint = joints[row[1]][s]
			if joint then
				-- couleur : celle de la membrane de cette articulation (sa plus grande plaque), sauf couleurs imposées
				local membrane, area = nil, 0
				for _, p in model:GetChildren() do
					local wc = p:IsA("BasePart") and p:FindFirstChildOfClass("WeldConstraint")
					if wc and wc.Part0 == joint and not p:GetAttribute("Deco") and p.Size.Y < 0.4 and p.Size.X * p.Size.Z > area then membrane, area = p, p.Size.X * p.Size.Z end
				end
				for _, x0 in row[2] do
					index += 1
					local length, depth = row[3], row[5]
					local zAxis, yAxis = V(s, 0, 0), V(0, 0, -1) -- la pointe est du côté du bout de l'aile
					local p = Instance.new("WedgePart")
					p.Name = "Stud"
					p.Size = V(0.3, depth, length) * SCALE
					p.CFrame = root.CFrame * CFrame.fromMatrix(V(s * (x0 + length / 2), 1.45, row[4] - depth / 2 + 0.02) * SCALE, yAxis:Cross(zAxis), yAxis, zAxis)
					p.Color = colors and colors[(index - 1) % #colors + 1] or (membrane and membrane.Color or Color3.new(0.5, 0.5, 0.5))
					p.Material = Mat.Plastic
					p.MaterialVariant = STUD_VARIANT
					p.Anchored, p.Massless = false, true
					p.CanCollide, p.CanQuery, p.CanTouch = false, false, false
					p:SetAttribute("WingTeeth", true)
					local w = Instance.new("WeldConstraint")
					w.Part0, w.Part1 = joint, p
					w.Parent = p
					p.Parent = model
					made += 1
				end
			end
		end
	end
	return made
end

local function extend(T, model)
	local root = model.PrimaryPart
	-- barre fine entre deux points
	function T.bar(j, p1, p2, thick, color, mat, transparency)
		local d = p2 - p1
		local up = math.abs(d.Unit.Y) > 0.98 and Vector3.xAxis or Vector3.yAxis
		return T.P(j, V(thick, thick, d.Magnitude), CFrame.lookAt((p1 + p2) / 2, p2, up), color, mat, transparency)
	end
	-- point d'effet (Attachment) à une position du dragon
	function T.fx(j, pos, name)
		local a = Instance.new("Attachment")
		a.Name = name or "Fx"
		a:SetAttribute("Deco", true)
		a.Parent = j or root
		a.WorldCFrame = root.CFrame * CFrame.new(pos * SCALE)
		return a
	end
	function T.emit(att, props)
		local e = Instance.new("ParticleEmitter")
		for k, v in props do e[k] = v end
		e.Parent = att
		return e
	end
	-- wedge (pièce en biseau) : même repère que T.P
	function T.W(j, size, cf, color, mat, transparency)
		local p = Instance.new("WedgePart")
		p.Name = "Stud"
		p.Size = size * SCALE
		p.CFrame = root.CFrame * (CFrame.new(cf.Position * SCALE) * cf.Rotation)
		p.Color = color
		p.Material = mat or Mat.Plastic
		if not mat then p.MaterialVariant = STUD_VARIANT end
		p.Transparency = transparency or 0
		p.Anchored, p.Massless = false, true
		p.CanCollide, p.CanQuery, p.CanTouch = false, false, false
		p:SetAttribute("Deco", true)
		local w = Instance.new("WeldConstraint")
		w.Part0, w.Part1 = j or root, p
		w.Parent = p
		p.Parent = model
		T.Count += 1
		return p
	end
	-- triangle isocèle à plat sur une face qui regarde +Z (deux wedges dos à dos) : oeil ou nez de citrouille
	function T.triangle(j, center, width, height, thick, color, mat, roll)
		local base = CFrame.new(center) * A(0, 0, rad(roll or 0))
		for _, side in {1, -1} do
			local yAxis, zAxis = Vector3.yAxis, V(-side, 0, 0)
			T.W(j, V(thick, height, width / 2), base * CFrame.fromMatrix(V(side * width / 4, 0, 0), yAxis:Cross(zAxis), yAxis, zAxis), color, mat)
		end
	end
	function T.light(att, color, range, brightness)
		local l = Instance.new("PointLight")
		l.Color, l.Range, l.Brightness, l.Shadows = color, range, brightness, false
		l.Parent = att
		return l
	end
	-- brume qui rampe sous le ventre et reste en traînée derrière le dragon
	function T.mist(c1, c2, glow, rate)
		local a = T.fx(nil, V(0, -2.6, -0.5), "FxMist")
		local e = T.emit(a, {
			Name = "Mist", Texture = PUFF_TEX, Rate = rate or 7, Lifetime = NumberRange.new(1.8, 2.8), Speed = NumberRange.new(1.5, 4), SpreadAngle = Vector2.new(180, 180),
			Size = seq({0, 2.2}, {1, 6}), Transparency = seq({0, 1}, {0.25, 0.72}, {1, 1}), Color = colors(c1, c2), LightEmission = glow, LightInfluence = 1 - glow,
			Rotation = NumberRange.new(0, 360), RotSpeed = NumberRange.new(-25, 25), Drag = 1.2, Acceleration = V(0, 0.6, 0), ZOffset = -1,
		})
		e.FlipbookLayout, e.FlipbookMode = Enum.ParticleFlipbookLayout.Grid4x4, Enum.ParticleFlipbookMode.OneShot
		return e
	end
	-- gouttes qui tombent d'un point (bave, sang, cire)
	function T.drip(j, pos, color, rate, size)
		local a = T.fx(j, pos, "FxDrip")
		a.WorldCFrame = CFrame.new(a.WorldPosition) * A(rad(-90), 0, 0) -- "Front" pointe vers le bas
		return T.emit(a, {
			Name = "Drip", Texture = DROP_TEX, Rate = rate or 2.5, Lifetime = NumberRange.new(0.7, 1.1), Speed = NumberRange.new(0.5, 2), SpreadAngle = Vector2.new(6, 6),
			EmissionDirection = Enum.NormalId.Front, Orientation = Enum.ParticleOrientation.VelocityParallel, Size = seq({0, (size or 0.3) * 0.5}, {0.3, size or 0.3}, {1, (size or 0.3) * 0.7}),
			Transparency = seq({0, 0.05}, {0.8, 0.1}, {1, 1}), Color = ColorSequence.new(color), LightEmission = 0.15, LightInfluence = 0.6, Acceleration = V(0, -26, 0),
		})
	end
	-- petite chauve-souris en blocs (posée ou pendue)
	function T.bat(j, pos, size, rot, eyes)
		local cf = CFrame.new(pos) * (rot or CFrame.identity)
		local function p(sz, off, r, color, mat) return T.P(j, sz * size, cf * CFrame.new(off * size) * (r or CFrame.identity), color, mat) end
		p(V(0.5, 0.55, 0.42), V(0, 0, 0), nil, INK, Mat.SmoothPlastic)
		for _, s in {1, -1} do
			p(V(0.15, 0.26, 0.14), V(s * 0.17, 0.38, 0), nil, INK, Mat.SmoothPlastic)
			p(V(0.85, 0.44, 0.1), V(s * 0.6, 0.08, 0), A(0, 0, rad(s * 18)), INK, Mat.SmoothPlastic)
			p(V(0.55, 0.3, 0.1), V(s * 1.18, 0.2, 0), A(0, 0, rad(-s * 14)), rgb(52, 40, 66), Mat.SmoothPlastic)
			p(V(0.1, 0.1, 0.08), V(s * 0.12, 0.08, 0.21), nil, eyes, Mat.Neon)
		end
	end
	return T
end

---------------------------------------------------------------- 1. HALLOWEEN DRAGON : citrouille-lanterne (yeux et bouche qui brillent), chapeau de sorcière, bonbons sur le dos
local HALLOWEEN = {
	Name = "Halloween Dragon",
	Colors = {
		Red = rgb(255, 122, 24), Dark = rgb(46, 30, 66), Light = rgb(255, 160, 60), Black = INK, Cream = rgb(54, 36, 78),
		Orange = rgb(46, 30, 66), Yellow = rgb(255, 196, 64), White = rgb(255, 244, 214), Pupil = rgb(255, 214, 70),
		Horn = rgb(60, 40, 86), Mouth = rgb(255, 190, 40), Tongue = rgb(255, 120, 30), Wood = rgb(62, 44, 40), Gold = rgb(255, 196, 64),
		WingA = rgb(40, 28, 60), WingB = rgb(74, 48, 110), Glow = rgb(255, 140, 20),
	},
	Fire = {rgb(255, 230, 120), rgb(255, 130, 20), rgb(140, 60, 220)},
}
HALLOWEEN.Decor = function(T, model)
	local J = T.J
	local ORANGE, ORANGE_D, PURPLE, HAT = rgb(255, 122, 24), rgb(214, 86, 14), rgb(150, 70, 220), rgb(40, 26, 58)
	local GREEN, STEM, GLOW, GLOW_O = rgb(104, 190, 64), rgb(70, 130, 50), rgb(255, 214, 70), rgb(255, 140, 20)
	local CANDY = {rgb(255, 214, 50), rgb(255, 140, 30), WHITE}
	local function candy(j, base, rot, len, w) T.spike(j, base, rot, len, w, CANDY) end

	-- la gueule est une lanterne : l'intérieur brille
	local mouthColor = HALLOWEEN.Colors.Mouth
	for _, p in model:GetChildren() do
		if p:IsA("BasePart") and math.abs(p.Color.R - mouthColor.R) + math.abs(p.Color.G - mouthColor.G) + math.abs(p.Color.B - mouthColor.B) < 0.02 then p.Material = Mat.Neon end
	end

	-- tête de citrouille-lanterne : orbites creusées, yeux et nez en triangles lumineux, lueur sur les tempes
	for _, s in {1, -1} do
		T.P(J.Head, V(1.62, 1.5, 0.16), V(s * 1.2, 4.45, 7.58), ORANGE_D, Mat.SmoothPlastic)
		T.triangle(J.Head, V(s * 1.2, 4.42, 7.72), 1.5, 1.25, 0.2, GLOW, Mat.Neon, s * 12)
		T.P(J.Head, V(0.1, 0.3, 1.8), V(s * 2.24, 4.5, 6.3), GLOW_O, Mat.Neon)
	end
	T.triangle(J.Head, V(0, 3.28, 9.27), 0.8, 0.6, 0.16, GLOW, Mat.Neon)

	-- visage de citrouille sculpté sur le poitrail, fentes lumineuses sous le ventre
	for _, s in {1, -1} do T.triangle(nil, V(s * 0.82, -0.2, 3.94), 0.8, 0.7, 0.22, GLOW, Mat.Neon, s * 10) end
	T.P(nil, V(2.3, 0.24, 0.22), V(0, -1.0, 3.94), GLOW, Mat.Neon)
	for i, x in {-0.85, -0.28, 0.28, 0.85} do T.P(nil, V(0.3, 0.3, 0.22), V(x, i % 2 == 0 and -0.78 or -1.2, 3.94), GLOW, Mat.Neon) end
	for _, z in {-2.2, 0, 2.2} do T.P(nil, V(3.6, 0.12, 0.35), V(0, -2.03, z), GLOW_O, Mat.Neon) end

	-- chapeau de sorcière : bord, ruban violet, boucle dorée, pointe qui retombe vers l'arrière
	local hat = CFrame.new(0, 5.8, 6.05) * A(rad(-7), 0, 0)
	local function h(size, off, rot, color, mat) return T.P(J.Head, size, hat * CFrame.new(off) * (rot or CFrame.identity), color, mat) end
	h(V(3.5, 0.3, 2.9), V(0, 0.2, 0), nil, HAT)
	h(V(2.05, 0.45, 2.05), V(0, 0.55, 0), nil, PURPLE)
	h(V(0.7, 0.55, 0.2), V(0, 0.55, 1.06), nil, rgb(255, 204, 70), Mat.Metal)
	h(V(0.36, 0.26, 0.24), V(0, 0.55, 1.08), nil, HAT, Mat.SmoothPlastic)
	h(V(1.9, 0.9, 1.9), V(0, 1.2, 0), nil, HAT)
	h(V(1.4, 0.9, 1.4), V(0, 1.95, -0.12), A(rad(-10), 0, 0), HAT)
	h(V(0.95, 0.8, 0.95), V(0, 2.6, -0.4), A(rad(-24), 0, 0), HAT)
	h(V(0.58, 0.7, 0.58), V(0, 3.1, -0.78), A(rad(-45), 0, 0), HAT)
	h(V(0.34, 0.55, 0.34), V(0, 3.38, -1.2), A(rad(-75), 0, 0), PURPLE)
	h(V(0.36, 0.36, 0.36), V(0, 3.3, -1.58), A(rad(45), rad(45), 0), GLOW, Mat.Neon)

	-- bonbons "candy corn" le long de l'échine
	candy(nil, V(0, 2.0, -3.0), back(16), 3.2, 1.3)
	for _, s in {1, -1} do candy(nil, V(s * 2.0, 2.0, 2.0), out(s, 20), 2.0, 0.9) end
	candy(J.Tail[1], V(0, 1.2, -4.4), back(18), 1.8, 0.8)
	candy(J.Tail[2], V(0, 0.8, -6.3), back(18), 1.5, 0.7)

	-- citrouille-lanterne au bout de la queue : visage tourné vers l'arrière (c'est ce que voit le cavalier), tige et vrille
	local pk = V(0, 0.15, -10.35)
	local tail = J.Tail[3]
	T.P(tail, V(2.4, 2.0, 2.4), pk, ORANGE)
	T.P(tail, V(1.9, 0.3, 1.9), pk + V(0, 1.1, 0), ORANGE_D)
	T.P(tail, V(1.9, 0.3, 1.9), pk + V(0, -1.1, 0), ORANGE_D)
	for _, s in {1, -1} do T.P(tail, V(0.3, 1.6, 1.7), pk + V(s * 1.3, 0, 0), ORANGE_D) end
	T.P(tail, V(1.7, 1.6, 0.3), pk + V(0, 0, 1.3), ORANGE_D)
	local fz = pk.Z - 1.22
	for _, s in {1, -1} do T.P(tail, V(0.56, 0.56, 0.2), CFrame.new(s * 0.56, pk.Y + 0.42, fz) * Z45, GLOW, Mat.Neon) end
	T.P(tail, V(0.26, 0.26, 0.2), CFrame.new(0, pk.Y, fz) * Z45, GLOW, Mat.Neon)
	T.P(tail, V(1.7, 0.24, 0.2), V(0, pk.Y - 0.5, fz), GLOW, Mat.Neon)
	for i, x in {-0.6, 0, 0.6} do T.P(tail, V(0.3, 0.3, 0.2), V(x, pk.Y - (i % 2 == 0 and 0.27 or 0.73), fz), GLOW, Mat.Neon) end
	T.P(tail, V(0.5, 0.75, 0.5), CFrame.new(pk + V(0.1, 1.58, 0)) * A(0, 0, rad(-12)), STEM)
	T.P(tail, V(1.1, 0.14, 0.8), CFrame.new(pk + V(-0.7, 1.36, 0.4)) * A(rad(8), rad(-30), rad(10)), GREEN)
	T.bar(tail, pk + V(0.3, 1.9, 0), pk + V(1.1, 2.5, 0.5), 0.16, GREEN, Mat.SmoothPlastic)
	T.bar(tail, pk + V(1.1, 2.5, 0.5), pk + V(1.6, 2.1, 1.1), 0.16, GREEN, Mat.SmoothPlastic)
	T.bar(tail, pk + V(1.6, 2.1, 1.1), pk + V(1.3, 1.6, 1.5), 0.14, GREEN, Mat.SmoothPlastic)
	local flame = T.fx(tail, pk + V(0, 1.2, 0), "FxPumpkin")
	T.emit(flame, {Name = "Flame", Texture = FIRE_TEX, Rate = 22, Lifetime = NumberRange.new(0.5, 0.9), Speed = NumberRange.new(2.5, 5), SpreadAngle = Vector2.new(14, 14),
		EmissionDirection = Enum.NormalId.Top, Size = seq({0, 1.5}, {0.4, 1.1}, {1, 0.15}), Transparency = seq({0, 0.3}, {0.6, 0.5}, {1, 1}),
		Color = colors(rgb(255, 235, 150), rgb(255, 130, 20), rgb(150, 60, 230)), LightEmission = 0.9, Rotation = NumberRange.new(-30, 30), RotSpeed = NumberRange.new(-40, 40)})
	T.emit(flame, {Name = "Embers", Texture = SPARK_TEX, Rate = 10, Lifetime = NumberRange.new(0.8, 1.5), Speed = NumberRange.new(2, 6), SpreadAngle = Vector2.new(35, 35),
		EmissionDirection = Enum.NormalId.Top, Size = seq({0, 0.35}, {1, 0}), Color = colors(rgb(255, 220, 120), rgb(170, 80, 255)), LightEmission = 1, Acceleration = V(0, 3, 0), Drag = 1})
	T.light(flame, rgb(255, 150, 40), 14, 1.1)

	for _, s in {1, -1} do -- ailes de chauve-souris : os lumineux (les pointes du bord sont ajoutées par M.wingTeeth)
		for _, w in {{"Wing", {3.2, 4.8}, 2.9, -0.75}, {"WingTip", {6.4, 7.8}, 2.5, -0.55}} do
			for _, x in w[2] do T.P(J[w[1]][s], V(0.16, 0.1, w[3]), CFrame.new(s * x, 1.65, w[4]) * A(0, rad(s * 8), 0), GLOW_O, Mat.Neon) end
		end
	end
	for key, leg in J.Leg do -- bracelets lumineux
		local sx, sz = key:sub(1, 1) == "R" and 1 or -1, key:sub(2, 2) == "F" and 1 or -1
		T.P(leg, V(1.9, 0.18, 1.9), V(sx * 1.9, -1.7, sz * 2.4), PURPLE, Mat.Neon)
	end
	T.mist(rgb(170, 90, 255), rgb(60, 30, 110), 0.35, 7)
end

---------------------------------------------------------------- 2. ZOMBIE DRAGON : chair pourrie, côtes à nu, cervelle, pierre tombale, bave toxique
local ZOMBIE = {
	Name = "Zombie Dragon",
	Colors = {
		Red = rgb(120, 160, 88), Dark = rgb(70, 104, 62), Light = rgb(150, 190, 110), Black = rgb(26, 30, 26), Cream = rgb(170, 180, 140),
		Orange = rgb(120, 80, 140), Yellow = rgb(190, 200, 90), White = rgb(226, 220, 190), Pupil = rgb(190, 255, 60),
		Horn = rgb(200, 192, 160), Mouth = rgb(60, 20, 30), Tongue = rgb(150, 90, 130), Wood = rgb(86, 70, 54), Gold = rgb(110, 100, 96),
		WingA = rgb(84, 110, 70), WingB = rgb(110, 76, 100), Glow = rgb(140, 255, 60),
	},
	Fire = {rgb(220, 255, 140), rgb(120, 230, 50), rgb(40, 110, 30)},
}
ZOMBIE.Decor = function(T, model)
	local J = T.J
	local SKIN, SKIN_D, FLESH, FLESH_D = rgb(120, 160, 88), rgb(70, 104, 62), rgb(150, 40, 52), rgb(96, 20, 32)
	local BONE, BONE_D, SLIME, SLIME_D = rgb(226, 220, 190), rgb(180, 172, 140), rgb(150, 255, 60), rgb(70, 190, 40)
	local BRAIN, BRAIN_D, STONE, STONE_D = rgb(240, 140, 170), rgb(206, 100, 140), rgb(126, 130, 138), rgb(84, 88, 96)
	local IRON, RUST, BAND, PURPLE, DIRT = rgb(74, 74, 80), rgb(130, 82, 50), rgb(210, 200, 164), rgb(120, 80, 140), rgb(84, 60, 44)
	local function bone(j, base, rot, len, w) T.spike(j, base, rot, len, w, {BONE_D, BONE, BONE}, Mat.SmoothPlastic) end
	local function slime(j, base, len, w) T.spike(j, base, DOWN, len, w, {SLIME_D, SLIME, SLIME}, {Mat.Glass, Mat.Glass, Mat.Neon}, 0.15) end

	-- flanc droit ouvert : chair à vif et côtes ; flanc gauche recousu
	T.P(nil, V(0.14, 2.3, 5.6), V(2.54, -0.15, -0.4), FLESH_D, Mat.SmoothPlastic)
	for i, z in {1.9, 0.9, -1.0, -1.9, -2.8} do
		T.P(nil, V(0.32, 2.3 - math.abs(z) * 0.14, 0.34), CFrame.new(2.68, -0.1, z) * A(rad(-10), 0, 0), i % 2 == 0 and BONE or BONE_D, Mat.SmoothPlastic)
	end
	T.P(nil, V(0.3, 0.3, 5.0), V(2.66, 1.05, -0.45), BONE_D, Mat.SmoothPlastic)
	T.P(nil, V(0.16, 1.5, 1.7), V(-2.55, 0.0, 2.0), PURPLE)
	T.bar(nil, V(-2.6, -0.2, -0.6), V(-2.6, -0.9, -3.2), 0.14, INK, Mat.SmoothPlastic)
	for i = 0, 4 do T.P(nil, V(0.14, 0.6, 0.14), CFrame.new(-2.6, -0.3 - i * 0.16, -0.9 - i * 0.55) * A(rad(i % 2 == 0 and 20 or -20), 0, 0), INK, Mat.SmoothPlastic) end
	for _, z in {1.2, 2.8} do T.P(nil, V(0.14, 0.14, 0.6), V(-2.62, 0.75, z), INK, Mat.SmoothPlastic) end
	slime(nil, V(2.6, -1.3, 0.4), 0.9, 0.35)
	slime(nil, V(2.6, -1.3, -1.5), 1.3, 0.4)
	slime(nil, V(-1.2, -2.0, 1.4), 0.8, 0.4)
	slime(nil, V(0.9, -2.0, -1.8), 1.1, 0.45)

	-- crâne fendu, cervelle à l'air
	T.P(J.Head, V(2.2, 0.2, 2.0), V(-0.6, 5.85, 5.7), FLESH_D, Mat.SmoothPlastic)
	T.P(J.Head, V(1.0, 0.75, 0.95), V(-1.0, 6.2, 5.4), BRAIN, Mat.SmoothPlastic)
	T.P(J.Head, V(0.95, 0.65, 0.85), V(-0.1, 6.15, 6.05), BRAIN, Mat.SmoothPlastic)
	T.P(J.Head, V(0.85, 0.6, 0.75), V(-0.95, 6.1, 6.3), BRAIN_D, Mat.SmoothPlastic)
	T.P(J.Head, V(0.7, 0.55, 0.7), V(-0.15, 6.3, 5.25), BRAIN_D, Mat.SmoothPlastic)
	T.P(J.Head, V(0.1, 0.5, 1.6), V(-0.55, 6.35, 5.75), FLESH, Mat.SmoothPlastic)
	T.P(J.Head, V(0.3, 0.7, 1.5), CFrame.new(0.55, 6.1, 5.7) * A(0, 0, rad(-25)), BONE, Mat.SmoothPlastic)
	T.P(J.Head, V(0.3, 0.6, 1.2), CFrame.new(-1.75, 6.0, 5.6) * A(0, 0, rad(30)), BONE_D, Mat.SmoothPlastic)
	T.P(J.Head, V(1.3, 0.55, 0.3), CFrame.new(-0.6, 6.0, 6.85) * A(rad(-25), 0, 0), BONE, Mat.SmoothPlastic)
	T.bar(J.Head, V(-1.2, 6.6, 5.4), V(-1.7, 7.1, 5.0), 0.14, rgb(255, 170, 190), Mat.SmoothPlastic) -- ver
	T.bar(J.Head, V(-1.7, 7.1, 5.0), V(-1.5, 7.45, 4.6), 0.14, rgb(255, 170, 190), Mat.SmoothPlastic)
	-- oeil gauche exorbité, oeil droit crevé (croix)
	T.P(J.Head, V(1.15, 1.15, 0.85), V(-1.2, 4.5, 7.75), rgb(244, 240, 214), Mat.SmoothPlastic)
	T.P(J.Head, V(0.42, 0.42, 0.14), V(-1.05, 4.38, 8.18), rgb(26, 30, 26), Mat.SmoothPlastic)
	T.P(J.Head, V(0.2, 0.2, 0.16), V(-1.05, 4.38, 8.2), rgb(190, 255, 60), Mat.Neon)
	T.bar(J.Head, V(-1.72, 4.9, 8.19), V(-1.35, 4.6, 8.19), 0.07, FLESH, Mat.SmoothPlastic)
	T.bar(J.Head, V(-0.72, 4.05, 8.19), V(-0.95, 4.25, 8.19), 0.07, FLESH, Mat.SmoothPlastic)
	T.P(J.Head, V(1.45, 1.5, 0.1), V(1.2, 4.55, 7.53), FLESH_D, Mat.SmoothPlastic)
	for _, a in {40, -40} do T.P(J.Head, V(1.5, 0.24, 0.14), CFrame.new(1.2, 4.55, 7.63) * A(0, 0, rad(a)), INK, Mat.SmoothPlastic) end
	-- boulons dans le cou, bandage, langue qui pend, bave
	for _, s in {1, -1} do
		T.P(J.Neck, V(0.75, 0.42, 0.42), V(s * 1.7, 1.9, 3.9), IRON, Mat.Metal)
		T.P(J.Neck, V(0.22, 0.7, 0.7), V(s * 2.1, 1.9, 3.9), IRON, Mat.Metal)
	end
	T.P(J.Neck, V(3.0, 0.5, 2.36), CFrame.new(0, 0.9, 3.8) * A(0, 0, rad(6)), BAND)
	T.P(J.Neck, V(0.5, 1.1, 0.14), CFrame.new(1.0, 0.5, 5.0) * A(0, 0, rad(-20)), BAND, Mat.SmoothPlastic)
	T.P(J.Jaw, V(0.75, 0.2, 1.3), CFrame.new(1.0, 2.25, 9.3) * A(rad(28), rad(20), 0), ZOMBIE.Colors.Tongue, Mat.SmoothPlastic)
	T.P(J.Jaw, V(0.62, 0.2, 0.7), CFrame.new(1.25, 1.75, 9.95) * A(rad(65), rad(20), 0), ZOMBIE.Colors.Tongue, Mat.SmoothPlastic)
	slime(J.Jaw, V(-0.9, 1.15, 8.4), 1.2, 0.4)
	slime(J.Jaw, V(0.4, 1.15, 8.7), 0.7, 0.3)
	slime(J.Head, V(-1.75, 2.7, 8.6), 1.0, 0.3)
	-- incision recousue sur le poitrail, coeur toxique
	T.P(nil, V(0.75, 0.75, 0.2), CFrame.new(0, -0.45, 3.93) * Z45, SLIME, Mat.Neon)
	T.P(nil, V(0.14, 1.5, 0.14), V(0, -0.5, 4.0), INK, Mat.SmoothPlastic)
	for _, y in {-0.05, -0.5, -0.95} do T.P(nil, V(0.7, 0.14, 0.14), V(0, y, 4.0), INK, Mat.SmoothPlastic) end

	-- dos : pierre tombale, main qui sort de terre, os, épée et flèche plantées, champignons
	local grave = CFrame.new(0, 2.0, -2.75) * A(0, 0, rad(7))
	local function g(size, off, color, mat) return T.P(nil, size, grave * CFrame.new(off), color, mat) end
	g(V(2.5, 0.45, 1.5), V(0, 0.2, 0), DIRT)
	g(V(1.7, 2.0, 0.5), V(0, 1.3, 0), STONE, Mat.Slate)
	g(V(1.2, 0.4, 0.5), V(0, 2.5, 0), STONE, Mat.Slate)
	for _, d in {1, -1} do
		g(V(0.22, 1.0, 0.1), V(0, 1.6, d * 0.27), STONE_D, Mat.Slate)
		g(V(0.7, 0.22, 0.1), V(0, 1.85, d * 0.27), STONE_D, Mat.Slate)
	end
	g(V(0.7, 0.2, 0.56), V(-0.55, 2.35, 0), SLIME_D, Mat.LeafyGrass)
	g(V(0.5, 0.5, 0.56), V(0.62, 0.5, 0), SLIME_D, Mat.LeafyGrass)
	local hand = CFrame.new(1.85, 2.0, -2.1) * A(rad(-8), rad(25), rad(-14))
	local function hd(size, off, color, mat) return T.P(nil, size, hand * CFrame.new(off), color, mat) end
	hd(V(1.1, 0.35, 1.0), V(0, 0.15, 0), DIRT)
	hd(V(0.5, 1.2, 0.5), V(0, 0.75, 0), SKIN)
	hd(V(0.56, 0.2, 0.56), V(0, 0.9, 0), BAND, Mat.SmoothPlastic)
	hd(V(0.75, 0.5, 0.36), V(0, 1.55, 0), SKIN_D)
	for i, x in {-0.27, 0, 0.27} do hd(V(0.18, 0.5 - math.abs(x) * 0.5, 0.22), V(x, 2.02, 0), SKIN, Mat.SmoothPlastic) end
	hd(V(0.18, 0.36, 0.22), V(0.48, 1.6, 0.05), SKIN, Mat.SmoothPlastic)
	bone(nil, V(-1.9, 2.0, -2.5), out(-1, 30) * back(20), 2.2, 0.8)
	bone(nil, V(-2.0, 2.0, 2.2), out(-1, 25), 1.4, 0.6)
	-- épée rouillée plantée dans l'épaule droite
	local sword = CFrame.new(1.7, 2.0, 2.2) * A(rad(-12), 0, rad(-22))
	local function sw(size, off, color, mat) return T.P(nil, size, sword * CFrame.new(off), color, mat) end
	sw(V(0.9, 0.2, 0.7), V(0, 0.05, 0), FLESH, Mat.SmoothPlastic)
	sw(V(0.16, 1.7, 0.5), V(0, 0.85, 0), rgb(150, 154, 160), Mat.Metal)
	sw(V(0.24, 0.24, 1.2), V(0, 1.8, 0), RUST, Mat.Metal)
	sw(V(0.22, 0.7, 0.22), V(0, 2.25, 0), rgb(86, 70, 54), Mat.Wood)
	sw(V(0.34, 0.3, 0.34), V(0, 2.7, 0), RUST, Mat.Metal)
	-- champignons toxiques
	local function mushroom(j, pos, size)
		T.P(j, V(0.36, 0.55, 0.36) * size, pos + V(0, 0.28 * size, 0), rgb(214, 220, 190), Mat.SmoothPlastic)
		T.P(j, V(1.0, 0.42, 1.0) * size, pos + V(0, 0.72 * size, 0), PURPLE)
		T.P(j, V(0.26, 0.1, 0.26) * size, pos + V(0.2 * size, 0.95 * size, 0.14 * size), SLIME, Mat.Neon)
		T.P(j, V(0.2, 0.1, 0.2) * size, pos + V(-0.26 * size, 0.95 * size, -0.2 * size), SLIME, Mat.Neon)
	end
	mushroom(J.Tail[1], V(0.7, 1.2, -4.9), 0.9)

	for _, s in {1, -1} do
		-- ailes en lambeaux : doigts d'os, trous de chair morte, bave qui pend
		for _, w in {{"Wing", {3.2, 4.8}, 2.9, -0.75, {2.8, 3.5, 4.2, 4.9}, -2.5, {{3.4, -1.4}, {4.7, -0.3}}, {3.0, 4.2, 5.2}},
			{"WingTip", {6.4, 7.8}, 2.5, -0.55, {6.0, 6.7, 7.4, 8.1}, -2.05, {{6.6, -0.2}, {7.7, -1.2}}, {6.4, 7.6}}} do
			local j = J[w[1]][s]
			for _, x in w[2] do T.P(j, V(0.2, 0.14, w[3]), CFrame.new(s * x, 1.66, w[4]) * A(0, rad(s * 8), 0), BONE, Mat.SmoothPlastic) end
			for i, x in w[5] do
				local len = (i * 7 % 3 == 0) and 1.5 or (i % 2 == 0 and 0.5 or 0.95)
				T.P(j, V(0.55, 0.22, len), CFrame.new(s * x, 1.36, w[6] - len / 2 + 0.1) * A(rad(-14), 0, 0), i % 2 == 0 and SKIN_D or PURPLE, Mat.SmoothPlastic)
			end
			for _, hole in w[7] do T.P(j, V(0.95, 0.36, 0.85), CFrame.new(s * hole[1], 1.45, hole[2]) * A(0, rad(20), 0), FLESH_D, Mat.SmoothPlastic) end
			for i, x in w[8] do slime(j, V(s * x, 1.27, 1.2), 0.6 + (i % 2) * 0.6, 0.34) end
		end
	end
	for key, leg in J.Leg do                                                    -- bandages, fer et chaîne cassée, os à nu
		local sx, sz = key:sub(1, 1) == "R" and 1 or -1, key:sub(2, 2) == "F" and 1 or -1
		if key == "RB" or key == "LF" then
			T.P(leg, V(1.86, 0.36, 1.86), CFrame.new(sx * 1.9, -1.5, sz * 2.4) * A(0, 0, rad(7)), BAND)
			T.P(leg, V(1.86, 0.3, 1.86), CFrame.new(sx * 1.9, -2.15, sz * 2.4) * A(0, 0, rad(-9)), BAND)
			T.P(leg, V(0.14, 0.9, 0.4), CFrame.new(sx * 2.85, -2.5, sz * 2.4 - 0.5) * A(rad(20), 0, 0), BAND, Mat.SmoothPlastic)
		else
			T.P(leg, V(2.0, 0.34, 2.0), V(sx * 1.9, -2.35, sz * 2.4), IRON, Mat.Metal)
			for i = 1, 3 do
				T.P(leg, i % 2 == 1 and V(0.16, 0.5, 0.34) or V(0.34, 0.5, 0.16), CFrame.new(sx * 2.95, -2.55 - i * 0.3, sz * 2.4 - i * 0.12) * A(rad(12), 0, 0), IRON, Mat.Metal)
			end
			T.P(leg, V(0.14, 1.0, 0.9), V(sx * 2.77, -1.9, sz * 2.4), FLESH_D, Mat.SmoothPlastic)
			T.P(leg, V(0.22, 1.2, 0.26), V(sx * 2.82, -1.9, sz * 2.4), BONE, Mat.SmoothPlastic)
		end
	end
	-- queue : vertèbres à nu, masse d'os au bout
	for i, d in {{1.2, -4.4, 1.2}, {0.8, -6.25, 1.0}, {0.45, -8.0, 0.8}} do
		T.P(J.Tail[i], V(d[3], 0.4, d[3] * 0.9), V(0, d[1] + 0.15, d[2] + 0.5), BONE_D, Mat.SmoothPlastic)
		bone(J.Tail[i], V(0, d[1], d[2] - 0.3), back(25), 1.9 - i * 0.3, 0.75 - i * 0.1)
	end
	T.P(J.Tail[3], V(1.7, 1.7, 1.7), CFrame.new(0, -0.1, -10.5) * A(rad(45), rad(45), 0), BONE_D, Mat.SmoothPlastic)
	T.P(J.Tail[3], V(1.2, 1.2, 1.2), CFrame.new(0, -0.1, -10.5) * A(0, rad(20), rad(20)), BONE, Mat.SmoothPlastic)
	for _, r in {back(0), back(90), out(1, 90), out(-1, 90), back(45), DOWN} do bone(J.Tail[3], V(0, -0.1, -10.5), r, 2.1, 0.65) end
	slime(J.Tail[3], V(0, -1.0, -10.5), 1.1, 0.4)

	-- effets permanents : vapeurs toxiques, bave, mouches, brume verte
	local fumes = {Texture = PUFF_TEX, Lifetime = NumberRange.new(1.2, 2), Speed = NumberRange.new(1.5, 3.5), SpreadAngle = Vector2.new(25, 25), EmissionDirection = Enum.NormalId.Top,
		Size = seq({0, 0.6}, {1, 2.6}), Transparency = seq({0, 1}, {0.2, 0.55}, {1, 1}), Color = colors(rgb(190, 255, 110), rgb(60, 130, 40)), LightEmission = 0.35,
		Rotation = NumberRange.new(0, 360), RotSpeed = NumberRange.new(-40, 40), Acceleration = V(0, 2, 0), Drag = 0.8}
	for _, spot in {{J.Head, V(-0.5, 6.5, 5.7), 7}, {nil, V(2.7, 0.2, -0.4), 5}, {nil, V(0, 4.6, -2.75), 4}} do
		local props = table.clone(fumes)
		props.Name, props.Rate = "Fumes", spot[3]
		local e = T.emit(T.fx(spot[1], spot[2], "FxFumes"), props)
		e.FlipbookLayout, e.FlipbookMode = Enum.ParticleFlipbookLayout.Grid4x4, Enum.ParticleFlipbookMode.OneShot
	end
	T.emit(T.fx(J.Head, V(0, 6.6, 5.6), "FxFlies"), {Name = "Flies", Texture = SMOKE_TEX, Rate = 16, Lifetime = NumberRange.new(0.35, 0.7), Speed = NumberRange.new(5, 11),
		SpreadAngle = Vector2.new(180, 180), Size = seq({0, 0.14}, {1, 0.14}), Transparency = seq({0, 0}, {0.9, 0}, {1, 1}), Color = ColorSequence.new(rgb(14, 16, 12)),
		Drag = 4, Acceleration = V(0, 3, 0), LightInfluence = 0})
	T.drip(J.Jaw, V(-0.9, 0.1, 8.4), SLIME, 2.2, 0.34)
	T.drip(J.Jaw, V(1.25, 1.5, 10.0), SLIME, 1.6, 0.3)
	T.drip(nil, V(2.6, -2.5, -1.5), SLIME, 1.6, 0.34)
	T.light(T.fx(nil, V(0, -0.45, 4.3), "FxHeart"), rgb(150, 255, 70), 9, 1.2)
	T.mist(rgb(150, 235, 90), rgb(40, 90, 30), 0.3, 7)
end

---------------------------------------------------------------- 3. VAMPIRE DRAGON : corps sombre, cape noire à col haut doublée de rouge, crocs, sang, chauves-souris
local VAMPIRE = {
	Name = "Vampire Dragon",
	Colors = {
		Red = rgb(62, 52, 78), Dark = rgb(28, 22, 36), Light = rgb(88, 74, 106), Black = rgb(16, 12, 20), Cream = rgb(150, 18, 34),
		Orange = rgb(170, 20, 36), Yellow = rgb(100, 10, 24), White = rgb(250, 246, 240), Pupil = rgb(255, 30, 50),
		Horn = rgb(40, 30, 48), Mouth = rgb(110, 8, 18), Tongue = rgb(230, 40, 60), Wood = rgb(60, 14, 22), Gold = rgb(236, 190, 86),
		WingA = rgb(130, 16, 32), WingB = rgb(84, 10, 24), Glow = rgb(255, 40, 60),
	},
	Fire = {rgb(255, 120, 120), rgb(220, 20, 40), rgb(90, 0, 16)},
}
VAMPIRE.Decor = function(T, model)
	local J = T.J
	local CAPE, CAPE_L, CRIMSON, CRIMSON_D = rgb(22, 16, 28), rgb(44, 34, 54), rgb(170, 20, 36), rgb(100, 10, 24)
	local BLOOD, BLOOD_N, GOLD, RUBY, FANG = rgb(170, 10, 26), rgb(255, 40, 60), rgb(236, 190, 86), rgb(255, 30, 70), rgb(250, 246, 240)
	local function crystal(j, base, rot, len, w) -- cristal de sang
		T.spike(j, base, rot * Y45, len, w, {CRIMSON_D, BLOOD, RUBY}, {Mat.Glass, Mat.Glass, Mat.Neon}, 0.12)
		T.P(j, V(w * 0.28, len * 0.6, w * 0.28), CFrame.new(base + rot * V(0, len * 0.34, 0)) * rot * Y45, BLOOD_N, Mat.Neon)
	end
	local function drip(j, base, len, w) T.spike(j, base, DOWN, len, w, {BLOOD, BLOOD, BLOOD_N}, {Mat.Glass, Mat.Glass, Mat.Neon}, 0.08) end

	-- crocs de sabre, sang qui coule de la gueule, larmes de sang
	for _, s in {1, -1} do
		T.spike(J.Head, V(s * 1.32, 2.74, 9.33), DOWN, 1.9, 0.52, {FANG, FANG, BLOOD_N}, {Mat.SmoothPlastic, Mat.SmoothPlastic, Mat.Neon})
		T.P(J.Head, V(0.62, 0.3, 0.62), V(s * 1.32, 2.8, 9.33), VAMPIRE.Colors.Red)                 -- babine
		T.P(J.Jaw, V(0.12, 1.0, 0.34), V(s * 1.8, 1.85, 8.7), BLOOD, Mat.Glass)
		drip(J.Jaw, V(s * 0.75, 1.15, 8.4), s == 1 and 1.3 or 0.8, 0.36)
		T.P(J.Head, V(0.1, 1.5, 0.28), V(s * 2.24, 3.55, 7.0), BLOOD_N, Mat.Neon)                   -- larmes de sang
		T.P(J.Head, V(0.1, 0.7, 0.2), V(s * 2.24, 3.15, 6.6), BLOOD_N, Mat.Neon)
		T.P(J.Head, V(0.1, 0.3, 1.9), V(s * 2.24, 4.6, 6.3), BLOOD_N, Mat.Neon)          -- lueur des yeux
		T.P(J.Head, V(0.5, 0.9, 0.5), V(s * 1.75, 8.5, 4.3), BLOOD_N, Mat.Neon)          -- pointe des cornes
	end
	drip(J.Jaw, V(0, 1.15, 8.75), 0.6, 0.3)
	-- pointe de cheveux sur le front, mèches plaquées vers l'arrière
	T.P(J.Head, V(1.25, 1.25, 0.22), CFrame.new(0, 5.42, 7.34) * Z45, VAMPIRE.Colors.Dark, Mat.SmoothPlastic)
	T.P(J.Head, V(3.9, 0.5, 0.5), V(0, 5.72, 7.1), VAMPIRE.Colors.Dark)
	for i, x in {-0.52, 0, 0.52} do T.P(J.Head, V(0.5, 0.4, 1.5), CFrame.new(x, 5.7, 3.95) * A(rad(-30), 0, 0), i == 2 and CAPE_L or VAMPIRE.Colors.Dark) end

	-- grand col de cape derrière la tête (noir dehors, rouge dedans), jabot blanc et broche
	local collar = CFrame.new(0, 2.3, 2.75) * A(rad(-12), 0, 0)
	local function c(size, off, rot, color, mat) return T.P(J.Neck, size, collar * CFrame.new(off) * (rot or CFrame.identity), color, mat) end
	c(V(5.6, 3.6, 0.36), V(0, 1.8, 0), nil, CAPE)
	c(V(5.0, 3.3, 0.2), V(0, 1.75, 0.27), nil, CRIMSON)
	for _, s in {1, -1} do
		c(V(0.36, 3.3, 2.5), V(s * 3.05, 1.55, 1.0), A(0, rad(s * 20), 0), CAPE)
		c(V(0.2, 3.0, 2.2), V(s * 2.82, 1.5, 1.05), A(0, rad(s * 20), 0), CRIMSON)
		c(V(1.5, 1.5, 0.36), V(s * 2.05, 3.7, 0), Z45, CAPE)                     -- pointes du col
		c(V(0.36, 1.4, 1.4), V(s * 3.05, 3.2, 1.0), A(0, rad(s * 20), 0) * A(rad(45), 0, 0), CAPE)
		c(V(0.3, 0.3, 0.3), V(s * 2.05, 4.9, 0), A(rad(45), rad(45), 0), GOLD, Mat.Metal)
	end
	c(V(1.8, 1.8, 0.36), V(0, 3.9, 0), Z45, CAPE)
	c(V(0.34, 0.34, 0.34), V(0, 5.3, 0), A(rad(45), rad(45), 0), GOLD, Mat.Metal)
	for i, d in {{1.5, 1.25}, {1.15, 0.8}, {0.75, 0.38}} do T.P(J.Neck, V(d[1], 0.5, 0.3), V(0, d[2], 5.22 + i * 0.03), WHITE, Mat.SmoothPlastic) end
	T.P(J.Neck, V(0.5, 0.5, 0.24), CFrame.new(0, 1.62, 5.34) * Z45, RUBY, Mat.Neon)
	T.P(J.Neck, V(0.8, 0.8, 0.16), CFrame.new(0, 1.62, 5.3) * Z45, GOLD, Mat.Metal)

	-- médaillon d'or et rubis sur le poitrail, veines de sang sur les flancs et sous le ventre
	T.ring(nil, V(0, -0.5, 3.96), 0.72, 8, 0.16, "z", GOLD, Mat.Metal)
	T.P(nil, V(0.78, 0.78, 0.24), CFrame.new(0, -0.5, 3.96) * Z45, RUBY, Mat.Neon)
	for _, s in {1, -1} do
		T.bar(nil, V(s * 0.5, 0.15, 3.96), V(s * 1.45, 0.3, 3.96), 0.1, GOLD, Mat.Metal)
		T.bar(nil, V(s * 2.56, 0.9, 2.9), V(s * 2.56, 0.2, 2.0), 0.12, BLOOD_N, Mat.Neon)
		T.bar(nil, V(s * 2.56, 0.2, 2.0), V(s * 2.56, -0.6, 2.3), 0.12, BLOOD_N, Mat.Neon)
		T.bar(nil, V(s * 2.56, 0.2, 2.0), V(s * 2.56, -0.1, 0.9), 0.1, BLOOD_N, Mat.Neon)
		T.bar(nil, V(s * 2.56, -0.4, -0.8), V(s * 2.56, -1.2, -0.3), 0.1, BLOOD_N, Mat.Neon)
		crystal(nil, V(s * 2.5, 0.7, 2.6), out(s, 64), 1.7, 0.7)
		crystal(nil, V(s * 2.5, 0.3, -1.0), out(s, 70), 1.3, 0.6)
	end
	for _, z in {-1.6, 1.6} do T.P(nil, V(3.6, 0.12, 0.3), V(0, -2.03, z), BLOOD_N, Mat.Neon) end

	-- cape : sur le dos derrière la selle, pans qui tombent sur les flancs, traîne sur la queue (elle ondule avec elle)
	T.P(nil, V(5.0, 0.26, 2.3), V(0, 2.14, -2.55), CAPE)
	for _, s in {1, -1} do
		T.P(nil, V(0.26, 2.3, 2.3), V(s * 2.64, 1.1, -2.55), CAPE)
		T.P(nil, V(0.3, 0.34, 2.36), V(s * 2.66, -0.1, -2.55), CRIMSON)
		for i, z in {-1.8, -2.55, -3.3} do T.P(nil, V(0.26, 0.75, 0.75), CFrame.new(s * 2.64, -0.3, z) * A(rad(45), 0, 0), i == 2 and CRIMSON or CAPE) end
	end
	T.P(J.Tail[1], V(3.4, 0.26, 2.3), V(0, 1.36, -4.5), CAPE)
	T.P(J.Tail[1], V(3.5, 0.14, 0.3), V(0, 1.42, -5.6), CRIMSON)
	for _, s in {1, -1} do T.P(J.Tail[1], V(0.26, 1.5, 2.3), V(s * 1.56, 0.7, -4.5), CAPE) end
	T.P(J.Tail[2], V(2.5, 0.24, 2.0), V(0, 0.95, -6.35), CAPE)
	for i, x in {-0.85, 0, 0.85} do T.P(J.Tail[2], V(0.95, 0.24, 0.95), CFrame.new(x, 0.95, -7.4) * Y45, i == 2 and CRIMSON or CAPE) end
	crystal(nil, V(0, 2.25, -2.9), back(16), 3.0, 1.1)
	crystal(J.Tail[1], V(0, 1.45, -4.6), back(22), 1.8, 0.8)
	crystal(J.Tail[2], V(0, 1.05, -6.4), back(22), 1.5, 0.65)

	for _, s in {1, -1} do
		-- ailes de chauve-souris : doigts noirs, veines rouges, bord en pointes
		for _, w in {{"Wing", {3.2, 4.8}, 2.9, -0.75, {2.7, 3.5, 4.3, 5.1}, -2.5, 4.0, 3.0}, {"WingTip", {6.4, 7.8}, 2.5, -0.55, {6.0, 6.8, 7.6, 8.3}, -2.05, 7.1, 2.8}} do
			local j = J[w[1]][s]
			for _, x in w[2] do T.P(j, V(0.22, 0.14, w[3]), CFrame.new(s * x, 1.66, w[4]) * A(0, rad(s * 8), 0), CAPE, Mat.SmoothPlastic) end
			T.P(j, V(w[8], 0.1, 0.14), CFrame.new(s * w[7], 1.66, -1.2) * A(0, rad(s * 12), 0), BLOOD_N, Mat.Neon)
			T.P(j, V(0.14, 0.1, 1.5), CFrame.new(s * (w[7] + 0.5), 1.66, -1.5) * A(0, rad(s * -20), 0), BLOOD_N, Mat.Neon)
			T.spike(j, V(s * (w[7] + 1.4), 1.9, 1.2), out(s, 22), 1.5, 0.5, {CAPE, CAPE_L, FANG}, Mat.SmoothPlastic) -- griffe
		end
		T.bat(J.WingTip[s], V(s * 7.1, 1.02, 1.15), 0.9, A(0, 0, math.pi), BLOOD_N)      -- chauve-souris pendue sous l'aile
		-- nageoire de queue en ailes de chauve-souris
		T.P(J.Tail[3], V(2.6, 0.3, 1.9), CFrame.new(s * 1.5, -0.1, -10.3) * A(0, rad(s * 30), 0), CAPE)
		T.P(J.Tail[3], V(1.6, 0.34, 1.2), CFrame.new(s * 1.4, -0.1, -10.2) * A(0, rad(s * 30), 0), CRIMSON)
		T.P(J.Tail[3], V(0.9, 0.3, 0.9), CFrame.new(s * 2.9, -0.1, -11.1) * Y45, CAPE)
		T.P(J.Tail[3], V(0.7, 0.3, 0.7), CFrame.new(s * 1.6, -0.1, -11.5) * Y45, CAPE)
	end
	crystal(J.Tail[3], V(0, -0.1, -9.7), back(90), 2.8, 0.9)
	T.bat(nil, V(0, 6.0, -2.95), 1.0, A(0, math.pi, 0), BLOOD_N)                       -- perchée sur le grand cristal du dos
	T.bat(J.Neck, V(0, 8.05, 2.2), 0.85, A(rad(-12), math.pi, 0), BLOOD_N)             -- et sur la pointe du col
	for key, leg in J.Leg do                                                    -- bracelets d'or et rubis, griffes rouges
		local sx, sz = key:sub(1, 1) == "R" and 1 or -1, key:sub(2, 2) == "F" and 1 or -1
		T.P(leg, V(1.95, 0.4, 1.95), V(sx * 1.9, -1.5, sz * 2.4), GOLD, Mat.Metal)
		T.P(leg, V(0.5, 0.5, 0.2), CFrame.new(sx * 1.9, -1.5, sz * 2.4 + 1.0) * Z45, RUBY, Mat.Neon)
		T.P(leg, V(2.04, 0.14, 2.34), V(sx * 1.9, -2.85, sz * 2.4 + 0.3), BLOOD_N, Mat.Neon)
	end

	-- effets permanents : le sang goutte des crocs et du menton, brume rouge, lueur du rubis
	for _, s in {1, -1} do T.drip(J.Head, V(s * 1.32, 0.8, 9.33), rgb(190, 8, 24), 3, 0.34) end
	T.drip(J.Jaw, V(0.75, -0.2, 8.4), rgb(190, 8, 24), 2, 0.32)
	T.drip(nil, V(0, -2.2, 1.6), rgb(190, 8, 24), 1.5, 0.3)
	T.light(T.fx(nil, V(0, -0.5, 4.4), "FxRuby"), rgb(255, 40, 60), 9, 0.7)
	local eyes = T.fx(J.Head, V(0, 4.5, 7.7), "FxEyes")
	T.light(eyes, rgb(255, 40, 60), 6, 0.6)
	T.mist(rgb(200, 20, 40), rgb(60, 0, 12), 0.25, 7)
end

HALLOWEEN.Teeth = {rgb(40, 26, 58), INK}
VAMPIRE.Teeth = {rgb(22, 16, 28), rgb(100, 10, 24)}
local VARIANTS = {HALLOWEEN, ZOMBIE, VAMPIRE} -- (le Zombie garde ses ailes en lambeaux, sans dents)
local NO_TEETH = {["Shadow Dragon"] = true, ["Celestial Dragon"] = true, ["Zombie Dragon"] = true} -- leur bord d'aile est déjà décoré

-- pose les dents de bord d'aile sur tous les autres dragons de la boutique
function M.teethForAll()
	local folder = game:GetService("ReplicatedStorage"):WaitForChild("Dragons")
	local report = {}
	for _, model in folder:GetChildren() do
		if not NO_TEETH[model.Name] then
			local colors
			for _, variant in VARIANTS do if variant.Name == model.Name then colors = variant.Teeth end end
			table.insert(report, model.Name .. " +" .. M.wingTeeth(model, colors))
		end
	end
	return table.concat(report, ", ")
end

function M.build(only)
	local folder = game:GetService("ReplicatedStorage"):WaitForChild("Dragons")
	local report = {}
	for _, variant in VARIANTS do
		if not only or only == variant.Name then
			local model = Builder.build(folder, {Name = variant.Name, Colors = table.clone(variant.Colors), Fire = variant.Fire})
			local T = extend(Decor.tools(model), model)
			variant.Decor(T, model)
			if variant.Teeth then M.wingTeeth(model, variant.Teeth) end
			table.insert(report, ("%s : %d pièces"):format(variant.Name, #model:QueryDescendants("BasePart")))
		end
	end
	return table.concat(report, " | ")
end

return M
