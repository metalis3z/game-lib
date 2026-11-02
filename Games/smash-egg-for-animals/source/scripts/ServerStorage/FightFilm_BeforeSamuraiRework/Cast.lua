-- FightFilm.Cast : les accessoires et les personnages de la cinématique "Samouraï contre la horde", et leurs allures.
--   Cast.phone() / Cast.katana() / Cast.scabbard()        accessoires du héros (construits en blocs)
--   Cast.vampire() / Cast.zombie() / Cast.phantom()       monstres R6, chacun avec sa silhouette
--   Cast.headless()                                        le boss : R6 sans tête, 1,75 fois plus grand, avec son espadon
-- Tous regardent vers -Z (l'avant d'un personnage Roblox). Les armes pointent vers -Z, tranchant vers le bas.
local Kit = require(script.Parent:WaitForChild("Kit"))
local Cast = {}
local rgb = Color3.fromRGB
local rad, sin, cos, max = math.rad, math.sin, math.cos, math.max
local V, A = Vector3.new, CFrame.Angles
local function C(x, y, z, rx, ry, rz) return CFrame.new(x, y, z) * A(rad(rx or 0), rad(ry or 0), rad(rz or 0)) end

-- petit modèle rigide : une pièce racine invisible, tout le reste soudé dessus
local function prop(name)
	local model = Instance.new("Model")
	model.Name = name
	local root = Instance.new("Part")
	root.Name = "Root"
	root.Size = V(0.1, 0.1, 0.1)
	root.Transparency = 1
	root.Anchored, root.Massless = false, true
	root.CanCollide, root.CanQuery, root.CanTouch = false, false, false
	root.Parent = model
	model.PrimaryPart = root
	local function add(size, cf, color, o)
		o = o or {}
		o.Parent = model
		if o.Smooth == nil then o.Smooth = true end
		return Kit.deco(root, size, cf, color, o)
	end
	return model, root, add
end

---------------------------------------------------------------- téléphone
function Cast.phone()
	local model, root, add = prop("Phone")
	add(V(0.36, 0.72, 0.06), C(0, 0, 0), rgb(26, 26, 32), {Material = Enum.Material.Metal})
	add(V(0.4, 0.76, 0.03), C(0, 0, 0), rgb(150, 154, 168), {Material = Enum.Material.Metal})         -- tranche chromée
	local screen = add(V(0.31, 0.64, 0.02), C(0, 0, -0.035), rgb(120, 190, 255), {Neon = true, Name = "Screen"})
	add(V(0.12, 0.03, 0.02), C(0, 0.27, -0.045), rgb(20, 20, 26))                                     -- haut-parleur
	add(V(0.2, 0.2, 0.02), C(0, 0.05, -0.046), rgb(80, 220, 120), {Neon = true})                      -- icône d'appel
	add(V(0.14, 0.14, 0.03), C(-0.08, 0.24, 0.04), rgb(14, 14, 18))                                   -- bloc caméra
	add(V(0.06, 0.06, 0.02), C(-0.08, 0.24, 0.06), rgb(90, 110, 140), {Material = Enum.Material.Glass})
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness, light.Shadows = rgb(140, 200, 255), 5, 0.9, false
	light.Parent = screen
	return model, root
end

---------------------------------------------------------------- katana et fourreau
-- repère du katana : garde en z = -0.35, lame de z = -0.5 à -4.75, poignée de z = -0.3 à +0.9. La main tient le point GRIP.
Cast.KATANA_GRIP = V(0, 0, 0.18)
function Cast.katana()
	local model, root, add = prop("Katana")
	local STEEL, EDGE, GOLD, WRAP, DIAMOND = rgb(196, 204, 218), rgb(170, 235, 255), rgb(226, 178, 70), rgb(52, 30, 84), rgb(240, 120, 30)
	-- lame : dos sombre, plat poli, tranchant lumineux, pointe biseautée
	local blade = add(V(0.07, 0.24, 3.8), C(0, 0, -2.4), STEEL, {Material = Enum.Material.Metal, Name = "Blade"})
	add(V(0.09, 0.06, 3.8), C(0, 0.13, -2.4), rgb(70, 74, 88), {Material = Enum.Material.Metal})        -- dos
	add(V(0.035, 0.05, 3.9), C(0, -0.135, -2.45), EDGE, {Neon = true, Name = "Edge"})                   -- tranchant
	add(V(0.075, 0.04, 3.4), C(0, -0.06, -2.3), rgb(232, 238, 248), {Material = Enum.Material.Metal})   -- ligne de trempe
	add(V(0.07, 0.3, 0.5), C(0, -0.005, -4.52, 0, 180, 0), STEEL, {Wedge = true, Material = Enum.Material.Metal}) -- pointe
	add(V(0.035, 0.05, 0.52), C(0, -0.13, -4.5, -30, 0, 0), EDGE, {Neon = true})
	-- collet, garde carrée à quatre lobes
	add(V(0.12, 0.3, 0.2), C(0, 0, -0.45), GOLD, {Material = Enum.Material.Metal})
	add(V(0.62, 0.62, 0.07), C(0, 0, -0.33, 0, 0, 45), rgb(34, 28, 44), {Material = Enum.Material.Metal})
	add(V(0.5, 0.5, 0.09), C(0, 0, -0.33), GOLD, {Material = Enum.Material.Metal})
	add(V(0.2, 0.34, 0.11), C(0, 0, -0.33), rgb(34, 28, 44), {Material = Enum.Material.Metal})
	-- poignée : tressage violet, losanges orange, pommeau doré
	add(V(0.17, 0.25, 1.2), C(0, 0, 0.3), WRAP)
	for i = 0, 4 do
		add(V(0.19, 0.13, 0.13), C(0, 0, -0.16 + i * 0.23, 45, 0, 0), DIAMOND)
		add(V(0.2, 0.27, 0.04), C(0, 0, -0.05 + i * 0.23, 0, 0, 0), rgb(34, 20, 56))
	end
	add(V(0.2, 0.3, 0.12), C(0, 0, 0.94), GOLD, {Material = Enum.Material.Metal})
	add(V(0.1, 0.1, 0.3), C(0, -0.2, 1.0, 35, 0, 0), DIAMOND)                                           -- cordon
	return model, root, blade
end

-- fourreau : même repère que le katana rangé (l'entrée est en z = -0.42)
function Cast.scabbard()
	local model, root, add = prop("Scabbard")
	local LACQUER, GOLD, CORD = rgb(30, 18, 46), rgb(226, 178, 70), rgb(240, 120, 30)
	add(V(0.2, 0.36, 4.3), C(0, 0, -2.6), LACQUER)
	add(V(0.22, 0.2, 4.3), C(0, 0, -2.6), rgb(44, 28, 66))
	add(V(0.25, 0.41, 0.2), C(0, 0, -0.52), GOLD, {Material = Enum.Material.Metal})                     -- entrée
	add(V(0.24, 0.4, 0.14), C(0, 0, -1.5), GOLD, {Material = Enum.Material.Metal})
	add(V(0.24, 0.4, 0.3), C(0, 0, -4.62), GOLD, {Material = Enum.Material.Metal})                      -- bout
	add(V(0.3, 0.14, 0.34), C(0, 0.2, -1.1), CORD)                                                      -- nœud du cordon
	add(V(0.08, 0.5, 0.08), C(0.1, -0.1, -1.1, 0, 0, 14), CORD)
	add(V(0.08, 0.4, 0.08), C(-0.1, -0.06, -1.1, 0, 0, -18), CORD)
	for i = 0, 2 do add(V(0.21, 0.12, 0.12), C(0, 0.13, -2.4 - i * 0.6, 45, 0, 0), rgb(120, 70, 200), {Neon = true}) end -- incrustations
	return model, root
end

---------------------------------------------------------------- monstres
local function deco(model, limbName)
	local limb = model:FindFirstChild(limbName)
	return function(size, cf, color, o)
		o = o or {}
		o.Parent = model
		return Kit.deco(limb, size, cf, color, o)
	end, limb
end

function Cast.vampire()
	local s = 1.12
	local BLACK, SKIN, RED, WHITE = rgb(24, 20, 30), rgb(170, 162, 186), rgb(170, 20, 36), rgb(205, 205, 214) -- peau et blancs un ton plus bas : sinon ils saturent sous les lumières du décor
	local m = Kit.makeR6({Name = "Vampire", Scale = s, Colors = {Torso = BLACK, Head = SKIN, Arms = BLACK, Legs = rgb(34, 28, 44)}})
	local function sz(x, y, z) return V(x, y, z) * s end
	local function at(x, y, z, rx, ry, rz) return C(x * s, y * s, z * s, rx, ry, rz) end
	local t = deco(m, "Torso")
	t(sz(0.9, 1.8, 0.08), at(0, -0.05, -0.52), RED, {Smooth = true})                       -- gilet
	t(sz(0.5, 0.5, 0.1), at(0, 0.7, -0.55), WHITE, {Smooth = true})                        -- jabot
	for i = 0, 2 do t(sz(0.14, 0.14, 0.06), at(0, 0.25 - i * 0.4, -0.58), rgb(255, 205, 80), {Smooth = true}) end
	for _, e in {1, -1} do t(sz(0.5, 1.9, 0.07), at(e * 0.72, 0, -0.53, 0, 0, e * -5), rgb(40, 34, 52), {Smooth = true}) end -- revers
	-- grand col
	t(sz(2.1, 1.25, 0.14), at(0, 1.5, 0.62, -12, 0, 0), BLACK, {Smooth = true})
	t(sz(1.9, 1.1, 0.06), at(0, 1.5, 0.53, -12, 0, 0), RED, {Smooth = true})
	for _, e in {1, -1} do
		t(sz(0.14, 1.2, 1.0), at(e * 1.0, 1.42, 0.2, 0, 0, e * -14), BLACK, {Smooth = true})
		t(sz(0.06, 1.05, 0.9), at(e * 0.93, 1.42, 0.2, 0, 0, e * -14), RED, {Smooth = true})
	end
	-- cape articulée (elle se soulève quand il fonce)
	local cape, capeWeld = t(sz(2.3, 0.2, 0.2), at(0, 0.85, 0.6), BLACK, {Smooth = true, Name = "CapeTop"})
	local function c(size, cf, color) return Kit.deco(cape, size, cf, color, {Smooth = true, Parent = m}) end
	c(sz(2.4, 3.3, 0.12), at(0, -1.7, 0.06), BLACK)
	c(sz(2.2, 3.1, 0.05), at(0, -1.65, -0.02), RED)
	for i = -1, 1 do c(sz(0.6, 0.6, 0.12), at(i * 0.8, -3.35, 0.06, 0, 0, 45), BLACK) end
	-- tête : cheveux plaqués, yeux rouges, crocs
	local h = deco(m, "Head")
	h(sz(1.36, 0.34, 1.36), at(0, 0.56, 0.02), BLACK)
	h(sz(1.36, 1.0, 0.3), at(0, 0.1, 0.56), BLACK)
	h(sz(0.5, 0.2, 0.5), at(0, 0.46, -0.52, 0, 45, 0), BLACK, {Smooth = true})
	for _, e in {1, -1} do
		h(sz(0.26, 0.16, 0.06), at(e * 0.3, 0.08, -0.66), rgb(255, 30, 40), {Neon = true})
		h(sz(0.4, 0.1, 0.07), at(e * 0.3, 0.26, -0.67, 0, 0, e * -18), BLACK, {Smooth = true})
		h(sz(0.1, 0.24, 0.08), at(e * 0.2, -0.46, -0.66, 180, 0, 0), WHITE, {Wedge = true})
	end
	h(sz(0.56, 0.07, 0.06), at(0, -0.32, -0.66), rgb(90, 14, 30), {Smooth = true})
	-- mains griffues
	for _, side in {"Right Arm", "Left Arm"} do
		local a = deco(m, side)
		a(sz(1.04, 0.42, 1.04), at(0, -0.8, 0), SKIN)
		a(sz(1.06, 0.14, 1.06), at(0, -0.55, 0), WHITE, {Smooth = true})
		for i = -1, 1 do a(sz(0.14, 0.5, 0.16), at(i * 0.3, -1.2, -0.3, 200, 0, 0), WHITE, {Wedge = true}) end
	end
	for _, side in {"Right Leg", "Left Leg"} do
		local l = deco(m, side)
		l(sz(1.06, 0.5, 1.2), at(0, -0.76, -0.08), BLACK)
	end
	return m, {Cape = capeWeld}
end

function Cast.zombie()
	local s = 1.08
	local SKIN, SKIN2, SHIRT, PANTS, BONE, WOUND = rgb(122, 162, 104), rgb(92, 128, 82), rgb(112, 86, 62), rgb(66, 78, 104), rgb(238, 232, 214), rgb(112, 24, 44)
	local m = Kit.makeR6({Name = "Zombie", Scale = s, Colors = {Torso = SHIRT, Head = SKIN, Arms = SKIN, Legs = PANTS}})
	local function sz(x, y, z) return V(x, y, z) * s end
	local function at(x, y, z, rx, ry, rz) return C(x * s, y * s, z * s, rx, ry, rz) end
	local t = deco(m, "Torso")
	t(sz(0.9, 0.8, 0.07), at(-0.4, -0.4, -0.52), WOUND, {Smooth = true})                   -- plaie : on voit les côtes
	for i = 0, 2 do t(sz(0.8, 0.14, 0.1), at(-0.4, -0.14 - i * 0.26, -0.55), BONE, {Smooth = true}) end
	t(sz(0.7, 0.5, 0.06), at(0.5, 0.5, -0.52, 0, 0, 12), SKIN2, {Smooth = true})
	t(sz(2.04, 0.3, 1.04), at(0, -0.9, 0), rgb(84, 62, 44))
	for i = -2, 2 do t(sz(0.3, 0.4, 0.07), at(i * 0.42, -1.1, -0.5, 0, 0, i * 9), SHIRT, {Smooth = true}) end -- chemise déchirée
	local h = deco(m, "Head")
	h(sz(0.7, 0.3, 0.8), at(0.3, 0.62, 0.1), rgb(255, 140, 180))                           -- cervelle
	h(sz(0.5, 0.5, 0.06), at(-0.36, -0.3, -0.66), SKIN2, {Smooth = true})
	h(sz(0.34, 0.36, 0.06), at(0.3, 0.08, -0.66), rgb(24, 20, 28), {Smooth = true})
	h(sz(0.22, 0.24, 0.07), at(0.3, 0.08, -0.67), rgb(190, 255, 70), {Neon = true})
	h(sz(0.26, 0.26, 0.06), at(-0.3, 0.1, -0.66), rgb(24, 20, 28), {Smooth = true})
	h(sz(0.12, 0.12, 0.07), at(-0.3, 0.1, -0.67), rgb(190, 255, 70), {Neon = true})
	h(sz(0.7, 0.34, 0.07), at(0, -0.4, -0.66, 0, 0, 6), rgb(40, 16, 26), {Smooth = true}) -- bouche ouverte
	for i = -1, 1 do h(sz(0.12, 0.14, 0.08), at(i * 0.2, -0.3, -0.67), BONE, {Smooth = true}) end
	local ra = deco(m, "Right Arm")
	ra(sz(1.04, 0.9, 1.04), at(0, 0.56, 0), SHIRT)
	ra(sz(0.34, 0.9, 0.34), at(0, -1.2, 0), BONE)                                           -- avant-bras réduit à l'os
	ra(sz(0.5, 0.3, 0.5), at(0, -1.7, 0), BONE)
	local la = deco(m, "Left Arm")
	la(sz(1.04, 0.5, 1.04), at(0, 0.76, 0), SHIRT)
	la(sz(0.06, 0.6, 0.5), at(-0.52, -0.2, 0), WOUND, {Smooth = true})
	for i = -1, 1 do la(sz(0.16, 0.34, 0.16), at(i * 0.3, -1.12, -0.2), SKIN2) end
	local rl = deco(m, "Right Leg")
	rl(sz(1.04, 0.7, 1.04), at(0, -0.66, 0), SKIN)                                          -- jambe de pantalon arrachée
	rl(sz(1.06, 0.3, 1.2), at(0, -0.86, -0.08), rgb(60, 46, 36))
	local ll = deco(m, "Left Leg")
	ll(sz(1.06, 0.4, 1.2), at(0, -0.82, -0.08), rgb(60, 46, 36))
	ll(sz(0.5, 0.4, 0.06), at(0.1, 0.1, -0.52), SKIN2, {Smooth = true})
	return m, {}
end

function Cast.phantom()
	local s = 1.2
	local ROBE, ROBE2, VOID, GLOW, BONE = rgb(62, 48, 116), rgb(40, 30, 82), rgb(10, 8, 16), rgb(110, 240, 255), rgb(226, 232, 240)
	local m = Kit.makeR6({Name = "Phantom", Scale = s, NoLegs = true, Colors = {Torso = ROBE, Head = VOID, Arms = ROBE2}})
	for _, p in m:GetChildren() do
		if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" and p.Name ~= "Head" then p.Transparency = 0.22 end
	end
	local function sz(x, y, z) return V(x, y, z) * s end
	local function at(x, y, z, rx, ry, rz) return C(x * s, y * s, z * s, rx, ry, rz) end
	local t, torso = deco(m, "Torso")
	t(sz(0.8, 0.8, 0.5), at(0, 0.2, 0), GLOW, {Neon = true, Name = "Core"})               -- cœur lumineux, visible à travers la robe
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness, light.Shadows = GLOW, 16, 1.6, false
	light.Parent = torso
	-- traîne en lambeaux, quatre segments articulés
	local welds = {}
	local previous = torso
	for i = 1, 4 do
		local w = 2.1 - i * 0.36
		local seg, weld = Kit.deco(previous, sz(w, 0.9, 1.05 - i * 0.14), i == 1 and at(0, -1.35, 0) or at(0, -0.8, 0), i % 2 == 1 and ROBE2 or ROBE, {Parent = m, Transparency = 0.22 + i * 0.1, Name = "Tail" .. i})
		for e = -1, 1, 2 do Kit.deco(seg, sz(0.3, 0.5, 0.1), at(e * w * 0.3, -0.6, 0, 0, 0, 45), ROBE2, {Parent = m, Smooth = true, Transparency = 0.3 + i * 0.1}) end
		welds["Tail" .. i] = weld
		previous = seg
	end
	-- capuche
	local h = deco(m, "Head")
	h(sz(1.56, 0.3, 1.6), at(0, 0.72, 0.05), ROBE)
	h(sz(1.56, 1.5, 0.3), at(0, 0.02, 0.72), ROBE)
	for _, e in {1, -1} do
		h(sz(0.26, 1.5, 1.5), at(e * 0.74, 0.02, 0.06), ROBE)
		h(sz(0.3, 0.2, 0.06), at(e * 0.3, 0.06, -0.66, 0, 0, e * 14), GLOW, {Neon = true})
	end
	h(sz(0.5, 0.5, 0.5), at(0, 0.98, 0.5, 30, 0, 0), ROBE2)
	-- manches et mains d'os
	for _, side in {"Right Arm", "Left Arm"} do
		local a = deco(m, side)
		a(sz(1.2, 0.6, 1.2), at(0, -0.8, 0), ROBE, {Transparency = 0.22})
		for i = -1, 1 do
			a(sz(0.14, 0.6, 0.14), at(i * 0.28, -1.36, -0.1, 12, 0, i * 8), BONE)
			a(sz(0.3, 0.5, 0.1), at(i * 0.36, -1.2, 0.3, 0, 0, 45), ROBE2, {Smooth = true, Transparency = 0.3})
		end
	end
	return m, welds
end

---------------------------------------------------------------- Headless
-- repère de l'espadon : garde en z = -0.5, lame de z = -0.7 à -7.6
Cast.GREATSWORD_GRIP = V(0, 0, 0.6)
function Cast.greatsword()
	local model, root, add = prop("Greatsword")
	local IRON, DARK, VIOLET, GOLD = rgb(52, 50, 64), rgb(22, 20, 28), rgb(190, 90, 255), rgb(190, 150, 60)
	local blade = add(V(0.18, 1.0, 6.4), C(0, 0, -3.9), IRON, {Material = Enum.Material.Metal, Name = "Blade"})
	add(V(0.22, 0.34, 6.2), C(0, 0, -3.8), DARK, {Material = Enum.Material.Metal})                      -- gouttière
	add(V(0.08, 0.1, 6.5), C(0, -0.52, -3.95), VIOLET, {Neon = true})                                   -- tranchant
	add(V(0.08, 0.1, 6.5), C(0, 0.52, -3.95), VIOLET, {Neon = true})
	add(V(0.18, 0.5, 1.0), C(0, -0.25, -7.6, 0, 180, 0), IRON, {Wedge = true, Material = Enum.Material.Metal})
	add(V(0.18, 0.5, 1.0), C(0, 0.25, -7.6, 0, 180, 180), IRON, {Wedge = true, Material = Enum.Material.Metal})
	for i = 0, 3 do add(V(0.24, 0.26, 0.26), C(0, 0, -1.6 - i * 1.3, 45, 0, 0), VIOLET, {Neon = true}) end -- runes
	for i = 0, 2 do add(V(0.2, 0.34, 0.5), C(0, -0.62, -2.2 - i * 1.7, 0, 180, 0), IRON, {Wedge = true, Material = Enum.Material.Metal}) end -- dents
	add(V(0.4, 2.6, 0.34), C(0, 0, -0.5), DARK, {Material = Enum.Material.Metal})                       -- garde
	for _, e in {1, -1} do add(V(0.36, 0.7, 0.3), C(0, e * 1.4, -0.86, e * 28, 0, 0), DARK, {Material = Enum.Material.Metal}) end
	add(V(0.5, 0.5, 0.4), C(0, 0, -0.5, 0, 0, 45), VIOLET, {Neon = true})
	add(V(0.28, 0.34, 1.9), C(0, 0, 0.6), rgb(60, 30, 30))
	for i = 0, 4 do add(V(0.31, 0.37, 0.1), C(0, 0, -0.1 + i * 0.36), GOLD, {Material = Enum.Material.Metal}) end
	add(V(0.5, 0.56, 0.4), C(0, 0, 1.68, 0, 0, 45), DARK, {Material = Enum.Material.Metal})
	return model, root, blade
end

function Cast.headless()
	local s = 1.75
	local COAT, COAT2, STEEL, VIOLET, GOLD = rgb(22, 20, 28), rgb(27, 23, 36), rgb(27, 26, 38), rgb(190, 90, 255), rgb(190, 150, 60)
	local m = Kit.makeR6({Name = "Headless", Scale = s, NoHead = true, Colors = {Torso = COAT, Arms = COAT2, Legs = COAT}})
	local function sz(x, y, z) return V(x, y, z) * s end
	local function at(x, y, z, rx, ry, rz) return C(x * s, y * s, z * s, rx, ry, rz) end
	local t, torso = deco(m, "Torso")
	-- plastron, rune, ceinture
	t(sz(1.7, 1.3, 0.14), at(0, 0.25, -0.54), STEEL, {Material = Enum.Material.Metal})
	t(sz(1.3, 0.5, 0.16), at(0, -0.55, -0.54), STEEL, {Material = Enum.Material.Metal})
	t(sz(0.5, 0.5, 0.1), at(0, 0.3, -0.62, 0, 0, 45), VIOLET, {Neon = true})
	for _, e in {1, -1} do t(sz(0.12, 0.9, 0.1), at(e * 0.5, 0.3, -0.62, 0, 0, e * 24), VIOLET, {Neon = true}) end
	t(sz(2.1, 0.34, 1.1), at(0, -0.92, 0), rgb(70, 44, 30))
	t(sz(0.56, 0.5, 0.14), at(0, -0.92, -0.58), GOLD, {Material = Enum.Material.Metal})
	t(sz(0.24, 0.2, 0.06), at(0, -0.9, -0.66), rgb(255, 140, 30), {Neon = true})
	-- col montant autour du cou tranché, moignon, braise violette
	t(sz(1.5, 0.5, 0.16), at(0, 1.2, 0.48, -14, 0, 0), COAT2)
	for _, e in {1, -1} do t(sz(0.16, 0.5, 0.9), at(e * 0.72, 1.2, 0.05, 0, 0, e * -12), COAT2) end
	t(sz(0.9, 0.2, 0.8), at(0, 1.06, 0), rgb(70, 16, 40))
	local stump = t(sz(0.5, 0.14, 0.44), at(0, 1.2, 0), VIOLET, {Neon = true, Name = "Stump"})
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness, light.Shadows = VIOLET, 13, 0.9, false
	light.Parent = stump
	-- grande cape en lambeaux et pans du manteau, articulés
	local welds = {}
	local cape, capeWeld = t(sz(2.3, 0.2, 0.2), at(0, 0.95, 0.62), COAT, {Name = "CapeTop", Smooth = true})
	Kit.deco(cape, sz(2.5, 3.9, 0.14), at(0, -2.0, 0.04), COAT, {Parent = m, Smooth = true})
	Kit.deco(cape, sz(2.3, 3.7, 0.06), at(0, -1.95, -0.05), rgb(60, 24, 90), {Parent = m, Smooth = true})
	for i = -2, 2 do Kit.deco(cape, sz(0.5, 0.9, 0.14), at(i * 0.5, -4.1 - (i % 2) * 0.3, 0.04, 0, 0, i * 6), COAT, {Parent = m, Smooth = true}) end
	welds.Cape = capeWeld
	local tails, tailWeld = t(sz(2.1, 0.16, 0.16), at(0, -1.02, -0.5), COAT2, {Name = "CoatFront", Smooth = true})
	for _, e in {1, -1} do Kit.deco(tails, sz(0.86, 1.5, 0.1), at(e * 0.56, -0.8, 0), COAT2, {Parent = m, Smooth = true}) end
	welds.Coat = tailWeld
	-- épaulières à pointes, gantelets
	for _, e in {1, -1} do
		local a = deco(m, e == 1 and "Right Arm" or "Left Arm")
		a(sz(1.36, 0.6, 1.36), at(e * 0.1, 0.9, 0), STEEL, {Material = Enum.Material.Metal})
		a(sz(1.1, 0.3, 1.1), at(e * 0.1, 1.3, 0), COAT2)
		for i = -1, 1 do a(sz(0.24, 0.7, 0.3), at(e * 0.4, 1.5, i * 0.4, 0, e * 90, e * -20), STEEL, {Wedge = true, Material = Enum.Material.Metal}) end
		a(sz(1.14, 0.8, 1.14), at(0, -0.56, 0), STEEL, {Material = Enum.Material.Metal})
		a(sz(1.18, 0.1, 1.18), at(0, -0.3, 0), VIOLET, {Neon = true})
		a(sz(1.06, 0.3, 1.06), at(0, -1.0, 0), rgb(40, 34, 30))
	end
	-- jambières
	for _, e in {1, -1} do
		local l = deco(m, e == 1 and "Right Leg" or "Left Leg")
		l(sz(1.12, 0.9, 1.3), at(0, -0.62, -0.08), STEEL, {Material = Enum.Material.Metal})
		l(sz(1.14, 0.3, 1.12), at(0, 0.1, 0), STEEL, {Material = Enum.Material.Metal})
		l(sz(0.3, 0.6, 0.3), at(0, 0.2, -0.62, -160, 0, 0), STEEL, {Wedge = true, Material = Enum.Material.Metal})
		l(sz(1.16, 0.1, 1.14), at(0, -0.2, 0), VIOLET, {Neon = true})
	end
	return m, welds, stump
end

---------------------------------------------------------------- allures (cycle de marche : la phase avance avec la distance parcourue)
local G = Kit.Gaits
-- héros R15 : buste penché, jambes à près de 40° de chaque côté, bras opposés, épaules qui tournent contre le bassin
G.heroWalk = {stride = 4.9, fn = function(p)
	local s, c = sin(p), cos(p)
	return {
		RightHip = {38 * s}, LeftHip = {-38 * s},
		RightKnee = {-(8 + 50 * max(0, c) ^ 1.3)}, LeftKnee = {-(8 + 50 * max(0, -c) ^ 1.3)},
		RightAnkle = {10 * s}, LeftAnkle = {-10 * s},
		RightShoulder = {-36 * s, 0, 5}, LeftShoulder = {36 * s, 0, -5},
		RightElbow = {16 + 26 * max(0, -s)}, LeftElbow = {16 + 26 * max(0, s)},
		Root = {0, 0, 0}, Waist = {-9, 0, 0}, Neck = {6, 0, 0},
	}
end}
-- marche le sabre à la main : le bras droit balance peu, la lame reste le long de la jambe
G.heroWalkSword = {stride = 4.9, fn = function(p)
	local pose = G.heroWalk.fn(p)
	local s = sin(p)
	pose.RightShoulder = {6 - 14 * s, 0, 12}
	pose.RightElbow = {20 + 8 * max(0, -s)}
	return pose
end}
-- promenade au téléphone : petits pas, buste presque droit ; le bras droit (téléphone) et la tête ne sont pas touchés
G.heroStroll = {stride = 4.4, fn = function(p)
	local s, c = sin(p), cos(p)
	return {
		RightHip = {27 * s}, LeftHip = {-27 * s},
		RightKnee = {-(6 + 38 * max(0, c) ^ 1.3)}, LeftKnee = {-(6 + 38 * max(0, -c) ^ 1.3)},
		RightAnkle = {8 * s}, LeftAnkle = {-8 * s},
		LeftShoulder = {26 * s, 0, -5}, LeftElbow = {16 + 16 * max(0, s)},
		Root = {0, 0, 0}, Waist = {-4, 0, 0},
	}
end}
G.heroRun = {stride = 8.2, fn = function(p)
	local s, c = sin(p), cos(p)
	return {
		RightHip = {10 + 52 * s}, LeftHip = {10 - 52 * s},
		RightKnee = {-(20 + 86 * max(0, c) ^ 1.2)}, LeftKnee = {-(20 + 86 * max(0, -c) ^ 1.2)},
		RightAnkle = {16 * s}, LeftAnkle = {-16 * s},
		RightShoulder = {-56 * s, 0, 8}, LeftShoulder = {56 * s, 0, -8},
		RightElbow = {78 + 10 * s}, LeftElbow = {78 - 10 * s},
		Root = {0, 0, 0}, Waist = {-20, -6 * s, 0}, Neck = {16, 3 * s, 0},
	}
end}
G.r6Walk = {stride = 4.2, fn = function(p)
	local s, c = sin(p), cos(p)
	return {RightHip = {32 * s}, LeftHip = {-32 * s}, RightShoulder = {-28 * s, 0, 5}, LeftShoulder = {28 * s, 0, -5}, Root = {-6, 2 * s, 0}, Neck = {3, 0, 0}}
end}
-- vampire : il fonce penché en avant, les bras ramenés derrière lui, la cape à l'horizontale
G.vampireSprint = {stride = 7.4, fn = function(p)
	local s, c = sin(p), cos(p)
	return {RightHip = {34 + 56 * s}, LeftHip = {34 - 56 * s}, RightShoulder = {-66 + 8 * s, 0, 18}, LeftShoulder = {-66 - 8 * s, 0, -18},
		Root = {-34, 4 * s, 0}, Neck = {30, 0, 0}, Cape = {58 + 6 * c}}
end}
-- zombie : une jambe traîne, le corps tangue, les bras tendus devant
G.zombieShamble = {stride = 3.0, fn = function(p)
	local s, c = sin(p), cos(p)
	return {RightHip = {12 + 26 * s}, LeftHip = {8 - 14 * s, 0, -6}, RightShoulder = {80 + 8 * sin(p * 2), 0, -6}, LeftShoulder = {62 + 10 * cos(p * 2), 0, 10},
		Root = {-13 + 3 * c, 4 * s, 4 * s}, Neck = {-8 + 8 * s, 12 * c, 6 * s}}
end}
-- phantom : il flotte, la traîne ondule, même sur place
G.phantomFloat = {stride = 6, idleRate = 2.6, fn = function(p, a)
	a.sink = -sin(p * 0.9) * 0.35
	return {Root = {-10 + 4 * sin(p), 0, 3 * cos(p * 0.7)}, RightShoulder = {34 + 10 * sin(p + 1), 0, 20}, LeftShoulder = {34 + 10 * sin(p + 2), 0, -20},
		Neck = {6, 0, 4 * sin(p * 0.8)}, Tail1 = {14 + 9 * sin(p), 0, 4 * cos(p)}, Tail2 = {10 + 10 * sin(p - 0.8), 0, 5 * cos(p - 0.8)},
		Tail3 = {8 + 11 * sin(p - 1.6), 0, 6 * cos(p - 1.6)}, Tail4 = {6 + 12 * sin(p - 2.4), 0, 6 * cos(p - 2.4)}}
end}
-- Headless : pas lourds, le torse et les épaules roulent, l'espadon reste en main
G.headlessWalk = {stride = 3.5, fn = function(p)
	local s, c = sin(p), cos(p)
	return {RightHip = {26 * s}, LeftHip = {-26 * s}, RightShoulder = {18 - 6 * s, 0, 12}, LeftShoulder = {26 * s, 0, -10},
		Root = {-5 + 2 * math.abs(c), 3 * s, 0}, Cape = {12 + 5 * c}, Coat = {-8 * math.abs(s)}}
end}

return Cast
