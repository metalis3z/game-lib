-- Outil d'édition (pas utilisé en jeu) : décorations propres à chaque dragon, ajoutées sur les modèles de ReplicatedStorage.Dragons.
-- Coordonnées = celles de StarterDragonBuilder (avant mise à l'échelle). Relançable : les anciennes décorations sont retirées.
local SCALE = 0.975
local V, rad, rgb = Vector3.new, math.rad, Color3.fromRGB
local A = CFrame.Angles
local STUDS = Enum.SurfaceType.Studs
local Mat = Enum.Material
local M = {}

local function tools(model)
	for _, p in model:GetDescendants() do
		if p:GetAttribute("Deco") then p:Destroy() end
	end
	local root = model.PrimaryPart
	local template = model:FindFirstChild("Stud")
	local J = {Wing = {}, WingTip = {}, Tail = {}, Leg = {}}
	for _, p in model:GetChildren() do
		if p.Name == "JointPart" then
			local weld = p:FindFirstChildOfClass("Weld")
			local anim = weld and weld:GetAttribute("Anim")
			local rel = root.CFrame:PointToObjectSpace(p.Position)
			if anim == "Wing" or anim == "WingTip" then J[anim][weld:GetAttribute("Side")] = p
			elseif anim == "Tail" then table.insert(J.Tail, p)
			elseif anim == "Leg" then J.Leg[(rel.X > 0 and "R" or "L") .. (rel.Z > 0 and "F" or "B")] = p
			elseif anim then J[anim] = p end
		end
	end
	table.sort(J.Tail, function(a, b) return root.CFrame:PointToObjectSpace(a.Position).Z > root.CFrame:PointToObjectSpace(b.Position).Z end)
	local T = {J = J, Count = 0}
	-- bloc : sans matière = plastique à studs ; avec matière = lisse
	function T.P(joint, size, cf, color, mat, transparency)
		if typeof(cf) == "Vector3" then cf = CFrame.new(cf) end
		local p = template:Clone()
		p:ClearAllChildren()
		p.Size = size * SCALE
		p.CFrame = root.CFrame * (CFrame.new(cf.Position * SCALE) * cf.Rotation)
		p.Color = color
		p.Transparency = transparency or 0
		p.Material = mat or Mat.Plastic
		local surface = mat and Enum.SurfaceType.Smooth or STUDS
		p.TopSurface, p.BottomSurface, p.LeftSurface, p.RightSurface, p.FrontSurface, p.BackSurface = surface, surface, surface, surface, surface, surface
		p:SetAttribute("Deco", true)
		local w = Instance.new("WeldConstraint")
		w.Part0, w.Part1 = joint or root, p
		w.Parent = p
		p.Parent = model
		T.Count += 1
		return p
	end
	-- pointe en trois blocs qui s'affinent, le long de l'axe "haut" de rot. colors / mats : une valeur ou une par étage
	function T.spike(joint, base, rot, len, w, colors, mats, transparency)
		local y = 0
		for i, f in {{0.45, 1}, {0.33, 0.68}, {0.22, 0.38}} do
			local h = len * f[1]
			local color = typeof(colors) == "table" and colors[i] or colors
			local mat = typeof(mats) == "table" and mats[i] or mats
			T.P(joint, V(w * f[2], h, w * f[2]), CFrame.new(base + rot * V(0, y + h / 2, 0)) * rot, color, mat, mat ~= Mat.Neon and transparency or 0)
			y += h
		end
	end
	-- anneau de n barres ; plane = "y" (à plat) ou "z" (debout, face à l'avant)
	function T.ring(joint, center, radius, n, thickness, plane, color, mat)
		local side = 2 * radius * math.tan(math.pi / n) + thickness * 0.4
		for i = 1, n do
			local a = (i - 0.5) / n * math.pi * 2
			if plane == "y" then
				T.P(joint, V(side, thickness, thickness), CFrame.new(center + V(math.sin(a) * radius, 0, math.cos(a) * radius)) * A(0, a, 0), color, mat)
			else
				T.P(joint, V(side, thickness, thickness), CFrame.new(center + V(math.sin(a) * radius, math.cos(a) * radius, 0)) * A(0, 0, -a), color, mat)
			end
		end
	end
	T.rng = Random.new(7)
	return T
end

local out = function(s, deg) return A(0, 0, rad(-s * deg)) end       -- penché vers l'extérieur
local back = function(deg) return A(rad(-deg), 0, 0) end             -- penché vers l'arrière
local DOWN = A(math.pi, 0, 0)
local Y45 = A(0, rad(45), 0)
local WINGS = {{"Wing", {3.0, 4.0, 5.0}}, {"WingTip", {6.4, 7.4, 8.4}}}

local DECOR = {}

DECOR["Fire Dragon"] = function(T)
	local J = T.J
	local FLAME = {rgb(255, 120, 30), rgb(255, 190, 50), rgb(255, 244, 170)}
	local function flame(j, base, h, w, rot) T.spike(j, base, (rot or CFrame.identity) * Y45, h, w, FLAME, Mat.Neon) end
	for _, s in {1, -1} do
		flame(nil, V(s * 2.0, 2.0, -2.6), 2.0, 0.9, out(s, 14))
		flame(nil, V(s * 2.0, 2.0, 2.0), 1.6, 0.8, out(s, 14))
		flame(J.Head, V(s * 1.0, 5.8, 5.2), 1.5, 0.7, out(s, 10))
		-- roches de braise sur les épaules, fissure incandescente
		T.P(nil, V(0.7, 1.3, 1.5), CFrame.new(s * 2.75, 0.8, 2.3) * A(rad(12), 0, 0), rgb(48, 34, 34), Mat.Basalt)
		T.P(nil, V(0.12, 0.2, 1.3), CFrame.new(s * 3.12, 0.8, 2.3) * A(rad(40), 0, 0), FLAME[1], Mat.Neon)
		flame(J.Wing[s], V(s * 5.5, 1.9, 1.2), 1.2, 0.6)
		flame(J.WingTip[s], V(s * 8.5, 1.9, 1.15), 1.0, 0.5)
	end
	flame(nil, V(0, 2.0, -2.8), 3.0, 1.2, back(14))
	flame(J.Head, V(0, 5.8, 4.5), 2.4, 1.0, back(12))
	flame(J.Tail[1], V(0, 1.2, -4.4), 1.5, 0.7, back(15))
	flame(J.Tail[2], V(0, 0.8, -6.3), 1.3, 0.6, back(15))
	flame(J.Tail[3], V(0, 0.2, -10.0), 3.0, 1.5, back(35))
	for _, z in {-2.2, 0, 2.2} do T.P(nil, V(3.6, 0.12, 0.35), V(0, -2.03, z), FLAME[1], Mat.Neon) end -- ventre incandescent
end

DECOR["Ice Dragon"] = function(T)
	local J = T.J
	local PALE, DEEP, CORE, SNOW = rgb(205, 242, 255), rgb(120, 200, 255), rgb(160, 245, 255), rgb(255, 255, 255)
	local function ice(j, base, rot, len, w, deep) T.spike(j, base, rot, len, w, {deep and DEEP or PALE, PALE, SNOW}, Mat.Ice, 0.18) end
	for _, s in {1, -1} do
		ice(nil, V(s * 2.0, 2.0, -2.6), out(s, 20), 3.0, 1.0, true)
		ice(nil, V(s * 2.2, 2.0, -0.2), out(s, 32), 2.2, 0.8)
		ice(nil, V(s * 2.0, 2.0, 2.0), out(s, 20) * A(rad(12), 0, 0), 2.6, 0.9, true)
		ice(nil, V(s * 2.5, 0.6, 2.6), out(s, 70), 1.8, 0.8)                      -- épaulières
		ice(nil, V(s * 2.5, 0.2, -2.8), out(s, 75), 1.5, 0.7)
		ice(J.Head, V(s * 2.0, 5.3, 4.7), out(s, 38), 2.2, 0.8, true)             -- couronne de givre
		ice(J.Head, V(s * 1.0, 5.8, 4.4), out(s, 12) * back(10), 2.0, 0.7)
		ice(J.Head, V(s * 2.2, 3.4, 4.6), out(s, 80) * back(20), 1.6, 0.7)        -- joues
		ice(J.Jaw, V(s * 1.0, 1.15, 8.2), DOWN, 0.9, 0.4)                         -- stalactites du menton
		for _, w in WINGS do                                                      -- stalactites sous les ailes
			for i, x in w[2] do ice(J[w[1]][s], V(s * x, 1.25, 1.2), DOWN, 0.7 + (i % 2) * 0.6, 0.4, i % 2 == 0) end
		end
		T.P(J.WingTip[s], V(2.8, 0.1, 0.5), V(s * 7.1, 1.65, -2.0), CORE, Mat.Neon)  -- nervures gelées
		T.P(J.Wing[s], V(3.0, 0.1, 0.5), V(s * 4.0, 1.65, -2.2), CORE, Mat.Neon)
	end
	for key, leg in J.Leg do                                                     -- neige sur les cuisses
		local sx, sz = key:sub(1, 1) == "R" and 1 or -1, key:sub(2, 2) == "F" and 1 or -1
		T.P(leg, V(1.9, 0.3, 1.9), V(sx * 1.9, -1.1, sz * 2.4), SNOW, Mat.Snow)
		ice(leg, V(sx * 2.8, -1.9, sz * 2.4), out(sx, 60), 1.1, 0.5)
	end
	ice(nil, V(0, 2.0, -2.8), back(16), 3.8, 1.3, true)
	ice(nil, V(0.8, 2.0, -3.2), back(30) * out(1, 18), 2.2, 0.8)
	ice(nil, V(-0.8, 2.0, -3.2), back(30) * out(-1, 18), 2.2, 0.8)
	ice(J.Head, V(0, 5.8, 4.2), back(14), 3.0, 1.0, true)
	ice(J.Head, V(0, 1.15, 6.5), DOWN, 1.3, 0.5)
	T.P(J.Head, V(2.8, 0.35, 1.5), V(0, 5.95, 6.4), SNOW, Mat.Snow)
	T.P(J.Head, V(0.9, 0.9, 0.3), CFrame.new(0, 5.0, 7.38) * A(0, 0, rad(45)), CORE, Mat.Neon) -- gemme de glace du front
	T.P(nil, V(1.3, 1.3, 0.35), CFrame.new(0, -0.3, 3.95) * A(0, 0, rad(45)), CORE, Mat.Neon)  -- coeur gelé
	ice(J.Tail[1], V(0, 1.2, -4.4), back(20), 1.8, 0.8, true)
	ice(J.Tail[2], V(0, 0.8, -6.3), back(20), 1.5, 0.7)
	-- masse de glace au bout de la queue
	T.P(J.Tail[3], V(1.7, 1.7, 1.7), CFrame.new(0, -0.1, -10.0) * A(rad(45), rad(45), 0), DEEP, Mat.Ice, 0.15)
	for _, r in {back(0), back(90), out(1, 90), out(-1, 90), back(50), DOWN} do ice(J.Tail[3], V(0, -0.1, -10.0), r, 2.2, 0.7) end
end

DECOR["Forest Dragon"] = function(T)
	local J = T.J
	local LEAF, DARK, LIME, WOOD = rgb(70, 170, 70), rgb(40, 115, 55), rgb(150, 215, 90), rgb(120, 82, 50)
	local PETALS = {rgb(255, 130, 190), rgb(255, 225, 90), rgb(255, 255, 255), rgb(190, 130, 255)}
	local function bush(j, pos, size, color) T.P(j, V(size, size, size), CFrame.new(pos) * A(rad(T.rng:NextInteger(-20, 20)), rad(T.rng:NextInteger(0, 90)), rad(T.rng:NextInteger(-20, 20))), color, Mat.LeafyGrass) end
	local function flower(j, pos, i)
		T.P(j, V(0.18, 0.7, 0.18), pos + V(0, 0.35, 0), DARK, Mat.SmoothPlastic)
		T.P(j, V(0.8, 0.25, 0.8), CFrame.new(pos + V(0, 0.8, 0)) * Y45, PETALS[(i - 1) % #PETALS + 1], Mat.SmoothPlastic)
		T.P(j, V(0.8, 0.25, 0.8), pos + V(0, 0.8, 0), PETALS[(i - 1) % #PETALS + 1], Mat.SmoothPlastic)
		T.P(j, V(0.36, 0.36, 0.36), pos + V(0, 0.9, 0), rgb(255, 215, 70), Mat.Neon)
	end
	local function mushroom(j, pos, size)
		T.P(j, V(0.4, 0.6, 0.4) * size, pos + V(0, 0.3 * size, 0), rgb(250, 240, 215), Mat.SmoothPlastic)
		T.P(j, V(1.1, 0.45, 1.1) * size, pos + V(0, 0.8 * size, 0), rgb(226, 54, 50))
		T.P(j, V(0.3, 0.1, 0.3) * size, pos + V(0.2 * size, 1.05 * size, 0.15 * size), Color3.new(1, 1, 1), Mat.SmoothPlastic)
		T.P(j, V(0.22, 0.1, 0.22) * size, pos + V(-0.28 * size, 1.05 * size, -0.2 * size), Color3.new(1, 1, 1), Mat.SmoothPlastic)
	end
	-- crinière de feuillage autour du cou
	for i, p in {V(1.7, 2.3, 3.4), V(-1.7, 2.3, 3.4), V(0, 3.4, 3.1), V(1.2, 3.2, 3.0), V(-1.2, 3.2, 3.0), V(1.8, 1.0, 3.5), V(-1.8, 1.0, 3.5)} do
		bush(J.Neck, p, 1.2 + (i % 3) * 0.2, i % 2 == 0 and LEAF or DARK)
	end
	for _, s in {1, -1} do
		bush(nil, V(s * 2.1, 2.3, -2.6), 1.3, LEAF)
		bush(nil, V(s * 2.3, 2.2, 2.0), 1.1, LIME)
		flower(nil, V(s * 2.1, 2.9, -2.6), s == 1 and 1 or 2)
		flower(nil, V(s * 2.2, 2.0, -0.6), s == 1 and 3 or 4)
		flower(nil, V(s * 2.3, 2.7, 2.0), s == 1 and 2 or 1)
		-- bois de cerf feuillus au bout des cornes
		T.P(J.Head, V(1.4, 0.35, 0.35), CFrame.new(s * 2.4, 8.0, 4.3) * A(0, 0, rad(s * 35)), WOOD, Mat.Wood)
		T.P(J.Head, V(0.3, 1.1, 0.3), CFrame.new(s * 1.6, 8.7, 4.2) * A(0, 0, rad(s * -12)), WOOD, Mat.Wood)
		bush(J.Head, V(s * 3.0, 8.5, 4.3), 0.9, LIME)
		bush(J.Head, V(s * 1.5, 9.4, 4.2), 0.8, LEAF)
		for _, w in WINGS do                                                    -- feuilles le long des ailes
			for i, x in w[2] do bush(J[w[1]][s], V(s * x, 2.0, 1.2), 0.6 + (i % 2) * 0.2, i % 2 == 0 and LIME or LEAF) end
		end
		T.P(J.WingTip[s], V(0.25, 0.25, 2.8), V(s * 7.1, 1.6, -1.6), DARK, Mat.SmoothPlastic) -- nervure de feuille
		T.P(J.Wing[s], V(0.25, 0.25, 3.2), V(s * 4.0, 1.6, -1.8), DARK, Mat.SmoothPlastic)
	end
	for key, leg in J.Leg do                                                    -- lianes autour des cuisses
		local sx, sz = key:sub(1, 1) == "R" and 1 or -1, key:sub(2, 2) == "F" and 1 or -1
		T.P(leg, V(1.9, 0.25, 1.9), CFrame.new(sx * 1.9, -1.9, sz * 2.4) * A(0, 0, rad(sx * 12)), DARK, Mat.LeafyGrass)
		bush(leg, V(sx * 2.8, -1.7, sz * 2.4), 0.6, LIME)
	end
	mushroom(nil, V(0.7, 2.0, -2.9), 1.1)
	mushroom(nil, V(-0.7, 2.0, -3.1), 0.8)
	mushroom(J.Tail[1], V(0, 1.2, -4.5), 0.9)
	flower(J.Tail[2], V(0, 0.8, -6.3), 1)
	bush(J.Head, V(0, 6.1, 4.4), 1.3, LEAF)
	flower(J.Head, V(0, 6.7, 4.4), 4)
	T.P(J.Tail[1], V(3.0, 0.25, 0.3), CFrame.new(0, 0.6, -4.4) * A(0, rad(20), 0), DARK, Mat.LeafyGrass)
	-- grande feuille au bout de la queue
	T.P(J.Tail[3], V(2.9, 0.3, 2.9), CFrame.new(0, -0.1, -10.3) * Y45, LEAF, Mat.LeafyGrass)
	T.P(J.Tail[3], V(1.8, 0.36, 1.8), CFrame.new(0, -0.1, -10.9) * Y45, LIME, Mat.LeafyGrass)
	T.P(J.Tail[3], V(0.25, 0.4, 3.4), V(0, -0.1, -10.4), DARK, Mat.SmoothPlastic)
end

DECOR["Ocean Dragon"] = function(T)
	local J = T.J
	local FIN, DEEP, GLOW, CORAL, SHELL = rgb(70, 215, 215), rgb(25, 110, 170), rgb(120, 255, 240), rgb(255, 120, 150), rgb(255, 236, 205)
	local function fin(j, pos, h, len, rot)
		T.P(j, V(0.25, h, len), CFrame.new(pos + V(0, h / 2, 0)) * (rot or CFrame.identity), FIN, Mat.Glass, 0.25)
		T.P(j, V(0.3, h * 0.9, 0.2), CFrame.new(pos + V(0, h / 2, 0)) * (rot or CFrame.identity) * CFrame.new(0, 0, len * 0.2), DEEP, Mat.SmoothPlastic)
		T.P(j, V(0.32, 0.16, len), CFrame.new(pos + V(0, h, 0)) * (rot or CFrame.identity), GLOW, Mat.Neon)
	end
	fin(nil, V(0, 2.0, -2.3), 2.8, 1.3, back(12))
	fin(nil, V(0, 2.0, -3.2), 1.9, 0.9, back(22))
	fin(J.Tail[1], V(0, 1.2, -4.4), 1.7, 1.5, back(15))
	fin(J.Tail[2], V(0, 0.8, -6.3), 1.3, 1.4, back(15))
	fin(J.Head, V(0, 5.8, 5.0), 2.2, 2.4, back(10))
	for _, s in {1, -1} do
		fin(J.Head, V(s * 2.5, 3.4, 4.6), 1.9, 1.7, A(0, rad(s * 40), 0) * out(s, 25))  -- nageoires des joues
		fin(nil, V(s * 2.6, -0.4, -1.8), 1.5, 1.6, out(s, 65))                           -- nageoires des flancs
		-- corail sur les épaules
		T.P(nil, V(0.5, 1.2, 0.5), V(s * 2.1, 2.6, 2.1), CORAL)
		T.P(nil, V(0.4, 0.9, 0.4), CFrame.new(s * 2.5, 3.0, 2.1) * A(0, 0, rad(-s * 40)), CORAL)
		T.P(nil, V(0.4, 0.8, 0.4), CFrame.new(s * 1.8, 3.2, 2.4) * A(rad(35), 0, 0), rgb(255, 170, 120))
		T.P(nil, V(0.5, 0.5, 0.5), V(s * 2.2, 3.4, 2.0), rgb(255, 200, 215), Mat.Neon)
		T.P(nil, V(0.9, 0.5, 0.9), CFrame.new(s * 2.0, 2.2, -1.0) * Y45, SHELL, Mat.SmoothPlastic)   -- coquillage
		T.P(nil, V(0.4, 0.4, 0.4), V(s * 2.0, 2.5, -1.0), rgb(255, 255, 255), Mat.Neon)               -- perle
		for i = 1, 5 do                                                                 -- écailles lumineuses
			T.P(nil, V(0.1, 0.4, 0.4), CFrame.new(s * 2.53, -0.9 + (i % 2) * 0.5, -3.0 + i * 1.0) * A(rad(45), 0, 0), GLOW, Mat.Neon)
		end
		T.P(J.Wing[s], V(3.0, 0.1, 0.3), V(s * 4.0, 1.65, -1.2), GLOW, Mat.Neon)
		T.P(J.Wing[s], V(3.0, 0.1, 0.3), V(s * 4.0, 1.65, -2.5), GLOW, Mat.Neon)
		T.P(J.WingTip[s], V(2.8, 0.1, 0.3), V(s * 7.1, 1.65, -1.1), GLOW, Mat.Neon)
		T.P(J.WingTip[s], V(2.8, 0.1, 0.3), V(s * 7.1, 1.65, -2.2), GLOW, Mat.Neon)
		-- nageoire caudale en deux lobes
		T.P(J.Tail[3], V(2.6, 0.3, 1.9), CFrame.new(s * 1.5, -0.1, -10.4) * A(0, rad(s * 32), 0), FIN, Mat.Glass, 0.2)
		T.P(J.Tail[3], V(1.6, 0.34, 1.2), CFrame.new(s * 2.6, -0.1, -11.3) * A(0, rad(s * 32), 0), DEEP)
		T.P(J.Tail[3], V(2.6, 0.12, 0.3), CFrame.new(s * 1.7, 0.1, -11.3) * A(0, rad(s * 32), 0), GLOW, Mat.Neon)
		-- bulles qui flottent près de la tête
		T.P(J.Head, V(0.6, 0.6, 0.6), CFrame.new(s * 3.0, 6.4, 6.4) * A(rad(20), rad(30), 0), rgb(200, 245, 255), Mat.Glass, 0.55)
		T.P(J.Head, V(0.35, 0.35, 0.35), CFrame.new(s * 3.3, 7.3, 5.8) * A(rad(20), rad(30), 0), rgb(200, 245, 255), Mat.Glass, 0.55)
	end
	for key, leg in J.Leg do
		local sx, sz = key:sub(1, 1) == "R" and 1 or -1, key:sub(2, 2) == "F" and 1 or -1
		fin(leg, V(sx * 1.9, -2.6, sz * 2.4 - 1.2), 1.1, 0.9, back(25))
	end
	T.P(J.Head, V(0.9, 0.9, 0.3), CFrame.new(0, 5.0, 7.38) * A(0, 0, rad(45)), GLOW, Mat.Neon)
end

DECOR["Thunder Dragon"] = function(T)
	local J = T.J
	local BOLT, CYAN, METAL, CLOUD = rgb(255, 235, 70), rgb(110, 225, 255), rgb(60, 66, 96), rgb(96, 106, 150)
	local function zigzag(j, origin, axisRot, unit, color)   -- éclair en trois blocs
		for i, a in {35, -35, 35} do
			T.P(j, V(0.22, 1.35 * unit, 0.5 * unit), CFrame.new(origin) * axisRot * CFrame.new(0, (2 - i) * 0.85 * unit, (i % 2 == 0 and -0.25 or 0.25) * unit) * A(rad(a), 0, 0), color, Mat.Neon)
		end
	end
	local function rod(j, base, h)
		T.P(j, V(0.3, h, 0.3), base + V(0, h / 2, 0), METAL, Mat.Metal)
		for i = 1, 3 do T.P(j, V(0.7, 0.16, 0.7), base + V(0, h * (0.2 + i * 0.18), 0), BOLT, Mat.Neon) end
		T.P(j, V(0.7, 0.7, 0.7), CFrame.new(base + V(0, h + 0.3, 0)) * A(rad(45), rad(45), 0), CYAN, Mat.Neon)
	end
	for _, s in {1, -1} do
		zigzag(nil, V(s * 2.58, 0, 1.6), CFrame.identity, 1, BOLT)
		zigzag(nil, V(s * 2.58, 0, -1.9), CFrame.identity, 0.8, CYAN)
		zigzag(J.Head, V(s * 2.26, 4.0, 5.3), CFrame.identity, 0.7, BOLT)
		rod(nil, V(s * 2.0, 2.0, -2.6), 1.9)
		rod(nil, V(s * 2.0, 2.0, 2.0), 1.5)
		-- cornes prolongées par des éclairs
		T.P(J.Head, V(0.35, 1.0, 0.35), CFrame.new(s * 2.05, 8.6, 4.1) * A(0, 0, rad(-s * 30)), BOLT, Mat.Neon)
		T.P(J.Head, V(0.3, 0.9, 0.3), CFrame.new(s * 2.1, 9.3, 4.0) * A(0, 0, rad(s * 30)), CYAN, Mat.Neon)
		-- nuage d'orage autour du cou
		T.P(J.Neck, V(1.3, 1.3, 1.3), CFrame.new(s * 1.8, 2.4, 3.5) * A(rad(15), rad(20), 0), CLOUD, Mat.SmoothPlastic)
		T.P(J.Neck, V(1.0, 1.0, 1.0), CFrame.new(s * 1.9, 1.2, 3.7) * A(rad(-15), rad(40), 0), rgb(130, 140, 180), Mat.SmoothPlastic)
		zigzag(J.Neck, V(s * 2.5, 0.9, 3.7), A(0, 0, rad(-s * 20)), 0.5, BOLT)
		-- circuits lumineux sur les ailes
		for _, w in {{"Wing", 4.0, 3.0}, {"WingTip", 7.1, 2.8}} do
			T.P(J[w[1]][s], V(w[3], 0.1, 0.16), V(s * w[2], 1.65, -1.0), CYAN, Mat.Neon)
			T.P(J[w[1]][s], V(w[3] * 0.6, 0.1, 0.16), V(s * w[2], 1.65, -2.1), BOLT, Mat.Neon)
			T.P(J[w[1]][s], V(0.16, 0.1, 1.2), V(s * (w[2] + 0.8), 1.65, -1.55), CYAN, Mat.Neon)
		end
		T.P(J.WingTip[s], V(0.5, 0.5, 0.5), CFrame.new(s * 9.9, 1.6, 0.2) * A(rad(45), rad(45), 0), CYAN, Mat.Neon)
	end
	for key, leg in J.Leg do                                                 -- bracelets électriques
		local sx, sz = key:sub(1, 1) == "R" and 1 or -1, key:sub(2, 2) == "F" and 1 or -1
		T.P(leg, V(1.9, 0.18, 1.9), V(sx * 1.9, -1.6, sz * 2.4), BOLT, Mat.Neon)
		T.P(leg, V(1.9, 0.18, 1.9), V(sx * 1.9, -2.3, sz * 2.4), CYAN, Mat.Neon)
	end
	rod(nil, V(0, 2.0, -2.9), 2.8)
	rod(J.Head, V(0, 5.8, 4.4), 1.6)
	rod(J.Tail[1], V(0, 1.2, -4.4), 1.2)
	zigzag(J.Tail[3], V(0, -0.1, -10.6), A(rad(-90), 0, 0), 1.2, BOLT)       -- queue en éclair
	T.P(J.Tail[3], V(0.9, 0.9, 0.9), CFrame.new(0, -0.1, -12.2) * A(rad(45), rad(45), 0), CYAN, Mat.Neon)
	T.P(nil, V(1.2, 1.2, 0.35), CFrame.new(0, -0.3, 3.95) * A(0, 0, rad(45)), CYAN, Mat.Neon)
end

DECOR["Lava Dragon"] = function(T)
	local J = T.J
	local ROCK, ROCK2, LAVA, HOT = rgb(40, 30, 32), rgb(66, 48, 46), rgb(255, 110, 20), rgb(255, 210, 80)
	local function volcano(j, base, size)
		T.P(j, V(2.0, 0.8, 1.7) * size, CFrame.new(base + V(0, 0.4, 0) * size) * A(0, rad(8), 0), ROCK, Mat.Basalt)
		T.P(j, V(1.45, 0.7, 1.25) * size, CFrame.new(base + V(0, 1.1, 0) * size) * A(0, rad(-10), 0), ROCK2, Mat.Basalt)
		T.P(j, V(1.0, 0.5, 0.9) * size, base + V(0, 1.65, 0) * size, ROCK, Mat.Basalt)
		T.P(j, V(0.7, 0.3, 0.6) * size, base + V(0, 1.85, 0) * size, LAVA, Mat.Neon)                        -- cratère
		T.P(j, V(0.25, 1.1, 0.3) * size, base + V(0.75, 1.0, 0.3) * size, HOT, Mat.Neon)                    -- coulée
		T.P(j, V(0.3, 0.7, 0.25) * size, base + V(-0.4, 1.0, -0.66) * size, LAVA, Mat.Neon)
	end
	volcano(nil, V(0, 2.0, -2.8), 1.15)
	volcano(J.Tail[1], V(0, 1.2, -4.5), 0.7)
	volcano(J.Head, V(0, 5.8, 4.5), 0.75)
	for _, s in {1, -1} do
		volcano(nil, V(s * 1.9, 2.0, 2.0), 0.65)
		volcano(nil, V(s * 2.0, 2.0, -1.0), 0.5)
		-- plaques de roche et fissures de magma sur les flancs
		T.P(nil, V(0.5, 1.9, 1.9), CFrame.new(s * 2.7, 0.5, 2.3) * A(rad(10), 0, 0), ROCK, Mat.Basalt)
		T.P(nil, V(0.5, 1.5, 1.6), CFrame.new(s * 2.7, 0.2, -2.3) * A(rad(-14), 0, 0), ROCK2, Mat.Basalt)
		T.P(nil, V(0.1, 0.2, 2.6), CFrame.new(s * 2.53, -0.2, 0.2) * A(rad(22), 0, 0), LAVA, Mat.Neon)
		T.P(nil, V(0.1, 0.2, 1.6), CFrame.new(s * 2.53, -0.9, -1.2) * A(rad(-30), 0, 0), HOT, Mat.Neon)
		T.P(nil, V(0.1, 0.2, 1.4), CFrame.new(s * 2.97, 0.6, 2.3) * A(rad(-35), 0, 0), LAVA, Mat.Neon)
		T.P(J.Head, V(0.1, 0.2, 2.0), CFrame.new(s * 2.23, 4.2, 5.5) * A(rad(25), 0, 0), LAVA, Mat.Neon)
		T.P(J.Head, V(0.5, 0.9, 0.5), V(s * 1.75, 8.5, 4.3), HOT, Mat.Neon)                                  -- cornes en fusion
		T.P(J.Head, V(1.7, 0.5, 0.6), CFrame.new(s * 1.2, 5.75, 7.2) * A(0, 0, rad(s * 16)), ROCK, Mat.Basalt) -- arcades de roche
		-- nervures de magma sur les ailes
		for _, w in {{"Wing", 4.0, 3.0}, {"WingTip", 7.1, 2.8}} do
			T.P(J[w[1]][s], V(w[3], 0.1, 0.22), CFrame.new(s * w[2], 1.65, -1.6) * A(0, rad(s * 14), 0), LAVA, Mat.Neon)
			T.P(J[w[1]][s], V(0.22, 0.1, 2.0), V(s * (w[2] - 0.6), 1.65, -1.8), HOT, Mat.Neon)
			T.P(J[w[1]][s], V(0.8, 0.8, 0.8), CFrame.new(s * (w[2] + 0.9), 1.9, 1.2) * A(rad(30), rad(30), 0), ROCK, Mat.Basalt)
		end
	end
	for key, leg in J.Leg do                                                 -- chevilles en fusion
		local sx, sz = key:sub(1, 1) == "R" and 1 or -1, key:sub(2, 2) == "F" and 1 or -1
		T.P(leg, V(2.1, 0.2, 2.4), V(sx * 1.9, -2.75, sz * 2.4 + 0.3), LAVA, Mat.Neon)
		T.P(leg, V(1.0, 0.9, 1.0), CFrame.new(sx * 2.7, -1.6, sz * 2.4) * A(rad(20), rad(30), 0), ROCK, Mat.Basalt)
	end
	for i, p in {V(1.2, -2.3, 2.0), V(-0.9, -2.4, 0.6), V(0.5, -2.3, -1.2), V(-1.3, -2.35, -2.4)} do -- gouttes de lave sous le ventre
		T.P(nil, V(0.45, 0.6 + (i % 2) * 0.4, 0.45), p, i % 2 == 0 and HOT or LAVA, Mat.Neon)
	end
	-- masse de roche en fusion au bout de la queue
	T.P(J.Tail[3], V(2.0, 2.0, 2.0), CFrame.new(0, -0.1, -10.2) * A(rad(30), rad(45), rad(15)), ROCK, Mat.Basalt)
	T.P(J.Tail[3], V(1.5, 1.5, 1.5), CFrame.new(0, -0.1, -10.2) * A(rad(45), 0, rad(45)), LAVA, Mat.Neon)
	T.P(J.Tail[3], V(1.0, 1.0, 1.0), CFrame.new(0, 0.9, -10.9) * A(rad(20), rad(20), 0), ROCK2, Mat.Basalt)
	T.P(nil, V(1.3, 1.3, 0.35), CFrame.new(0, -0.3, 3.95) * A(0, 0, rad(45)), HOT, Mat.Neon)
end

DECOR["Crystal Dragon"] = function(T)
	local J = T.J
	local PINK, VIOLET, CYAN, WHITE = rgb(255, 150, 230), rgb(190, 150, 255), rgb(150, 235, 255), rgb(255, 255, 255)
	local GEMS = {PINK, VIOLET, CYAN}
	local n = 0
	local function gem(j, base, rot, len, w)
		n += 1
		local c = GEMS[n % 3 + 1]
		T.spike(j, base, rot * Y45, len, w, {c, c:Lerp(WHITE, 0.35), WHITE}, {Mat.Glass, Mat.Glass, Mat.Neon}, 0.22)
		T.P(j, V(w * 0.3, len * 0.7, w * 0.3), CFrame.new(base + rot * V(0, len * 0.38, 0)) * rot * Y45, c:Lerp(WHITE, 0.5), Mat.Neon) -- coeur lumineux
	end
	local function cluster(j, base, size, rot)
		rot = rot or CFrame.identity
		gem(j, base, rot, 2.6 * size, 1.0 * size)
		gem(j, base + rot * V(0.6 * size, 0, 0.2 * size), rot * out(1, 28), 1.8 * size, 0.7 * size)
		gem(j, base + rot * V(-0.6 * size, 0, -0.1 * size), rot * out(-1, 30), 1.6 * size, 0.7 * size)
		gem(j, base + rot * V(0, 0, -0.6 * size), rot * back(30), 1.4 * size, 0.6 * size)
	end
	cluster(nil, V(0, 2.0, -2.8), 1.3, back(10))
	cluster(J.Tail[1], V(0, 1.2, -4.5), 0.75, back(15))
	gem(J.Tail[2], V(0, 0.8, -6.3), back(20), 1.5, 0.6)
	for _, s in {1, -1} do
		cluster(nil, V(s * 2.0, 2.0, 2.0), 0.8, out(s, 18))
		cluster(nil, V(s * 2.5, 0.5, 2.5), 0.7, out(s, 75))
		gem(nil, V(s * 2.1, 2.0, -1.0), out(s, 25), 1.5, 0.6)
		gem(nil, V(s * 2.5, 0.1, -2.6), out(s, 70), 1.6, 0.7)
		gem(J.Head, V(s * 2.0, 5.3, 4.7), out(s, 35), 2.0, 0.7)         -- diadème
		gem(J.Head, V(s * 1.0, 5.8, 4.6), out(s, 12), 1.7, 0.6)
		gem(J.Head, V(s * 2.2, 3.4, 4.6), out(s, 80), 1.3, 0.6)
		gem(J.Wing[s], V(s * 5.5, 1.9, 1.2), out(s, 15), 1.4, 0.6)
		gem(J.WingTip[s], V(s * 8.5, 1.9, 1.15), out(s, 25), 1.2, 0.5)
		for i, w in {{"Wing", 4.0}, {"WingTip", 7.1}} do                -- facettes brillantes sur les ailes
			T.P(J[w[1]][s], V(1.1, 0.12, 1.1), CFrame.new(s * w[2], 1.65, -1.7) * Y45, GEMS[i], Mat.Neon)
			T.P(J[w[1]][s], V(0.6, 0.12, 0.6), CFrame.new(s * (w[2] + 0.9), 1.65, -0.8) * Y45, WHITE, Mat.Neon)
		end
		for i = 1, 4 do                                                 -- éclats incrustés dans les flancs
			T.P(nil, V(0.14, 0.5, 0.5), CFrame.new(s * 2.53, -0.8 + (i % 2) * 0.9, -2.6 + i * 1.1) * A(rad(45), 0, 0), GEMS[i % 3 + 1], Mat.Neon)
		end
	end
	for key, leg in J.Leg do
		local sx, sz = key:sub(1, 1) == "R" and 1 or -1, key:sub(2, 2) == "F" and 1 or -1
		gem(leg, V(sx * 2.75, -1.9, sz * 2.4), out(sx, 65), 1.1, 0.5)
	end
	gem(J.Head, V(0, 5.8, 4.3), back(12), 2.8, 0.9)
	T.P(J.Head, V(1.0, 1.0, 0.35), CFrame.new(0, 5.0, 7.38) * A(0, 0, rad(45)), PINK, Mat.Neon)
	T.P(nil, V(1.5, 1.5, 0.4), CFrame.new(0, -0.3, 3.95) * A(0, 0, rad(45)), CYAN, Mat.Neon)
	cluster(J.Tail[3], V(0, -0.1, -9.6), 1.0, back(80))
	gem(J.Tail[3], V(0, -0.1, -9.8), back(40), 1.8, 0.7)
	gem(J.Tail[3], V(0, -0.1, -9.8), back(125), 1.8, 0.7)
end

DECOR["Shadow Dragon"] = function(T)
	local J = T.J
	local BLACK, DARK, GLOW, BONE = rgb(18, 16, 26), rgb(44, 34, 66), rgb(180, 90, 255), rgb(200, 192, 214)
	local function thorn(j, base, rot, len, w) T.spike(j, base, rot, len, w, {BLACK, DARK, GLOW}, {Mat.SmoothPlastic, Mat.SmoothPlastic, Mat.Neon}) end
	thorn(nil, V(0, 2.0, -2.8), back(28), 3.4, 1.0)
	thorn(nil, V(0, 2.0, -3.3), back(48), 2.4, 0.8)
	thorn(J.Tail[1], V(0, 1.2, -4.4), back(35), 2.0, 0.8)
	thorn(J.Tail[2], V(0, 0.8, -6.3), back(35), 1.7, 0.7)
	thorn(J.Head, V(0, 5.8, 4.3), back(30), 2.6, 0.9)
	for _, s in {1, -1} do
		thorn(nil, V(s * 2.0, 2.0, -2.6), out(s, 25) * back(25), 2.4, 0.8)
		thorn(nil, V(s * 2.0, 2.0, 2.0), out(s, 25) * back(25), 2.0, 0.8)
		thorn(nil, V(s * 2.5, 0.7, 2.6), out(s, 60) * back(20), 2.0, 0.8)
		-- côtes d'os sur les flancs
		for i, z in {1.7, 0.9, -1.0, -1.8, -2.6} do
			T.P(nil, V(0.3, 2.3 - math.abs(z) * 0.15, 0.32), CFrame.new(s * 2.62, -0.1, z) * A(rad(-10), 0, 0), BONE, Mat.SmoothPlastic)
		end
		-- cornes supplémentaires recourbées vers l'avant
		T.P(J.Head, V(0.8, 0.8, 1.5), CFrame.new(s * 2.5, 5.0, 5.4) * A(rad(-20), rad(s * 12), 0), BLACK, Mat.SmoothPlastic)
		T.P(J.Head, V(0.55, 0.55, 1.3), CFrame.new(s * 2.75, 5.5, 6.6) * A(rad(-35), rad(s * 8), 0), DARK, Mat.SmoothPlastic)
		T.P(J.Head, V(0.34, 0.34, 0.9), CFrame.new(s * 2.85, 6.2, 7.5) * A(rad(-50), 0, 0), GLOW, Mat.Neon)
		T.P(J.Head, V(0.1, 0.28, 1.8), V(s * 2.24, 4.6, 6.3), GLOW, Mat.Neon)       -- traînée lumineuse des yeux
		T.P(J.Head, V(0.5, 0.9, 0.5), V(s * 1.75, 8.5, 4.3), GLOW, Mat.Neon)
		for _, w in {{"Wing", 4.0, {2.9, 3.6, 4.4, 5.1}}, {"WingTip", 7.1, {6.0, 6.8, 7.6, 8.3}}} do
			T.P(J[w[1]][s], V(0.2, 0.1, 2.4), CFrame.new(s * w[2], 1.65, -1.7) * A(0, rad(s * 25), 0), GLOW, Mat.Neon)  -- runes
			T.P(J[w[1]][s], V(1.2, 0.1, 0.2), V(s * w[2], 1.65, -1.1), GLOW, Mat.Neon)
			for i, x in w[3] do                                                     -- lambeaux qui pendent du bord des ailes
				T.P(J[w[1]][s], V(0.55, 0.2, 0.7 + (i % 2) * 0.7), V(s * x, 1.4, -3.9 - (i % 2) * 0.35), i % 2 == 0 and BLACK or DARK, Mat.SmoothPlastic)
			end
			thorn(J[w[1]][s], V(s * (w[2] + 1.4), 1.9, 1.2), out(s, 20), 1.5, 0.5)
		end
	end
	for key, leg in J.Leg do
		local sx, sz = key:sub(1, 1) == "R" and 1 or -1, key:sub(2, 2) == "F" and 1 or -1
		thorn(leg, V(sx * 2.75, -1.8, sz * 2.4), out(sx, 55), 1.4, 0.6)
		T.P(leg, V(1.9, 0.16, 1.9), V(sx * 1.9, -1.7, sz * 2.4), GLOW, Mat.Neon)
	end
	-- capuche d'ombre derrière la tête
	T.P(J.Head, V(4.8, 3.0, 0.4), CFrame.new(0, 4.6, 3.7) * A(rad(-12), 0, 0), BLACK, Mat.SmoothPlastic)
	T.P(J.Head, V(3.6, 0.9, 0.4), CFrame.new(0, 6.4, 3.4) * A(rad(-25), 0, 0), DARK, Mat.SmoothPlastic)
	T.P(J.Head, V(0.8, 0.8, 0.3), CFrame.new(0, 5.0, 7.38) * A(0, 0, rad(45)), GLOW, Mat.Neon)
	T.P(nil, V(0.3, 2.2, 0.3), V(0, -0.3, 3.95), GLOW, Mat.Neon)                    -- rune du poitrail
	T.P(nil, V(1.6, 0.3, 0.3), V(0, 0.2, 3.95), GLOW, Mat.Neon)
	-- faux au bout de la queue
	T.P(J.Tail[3], V(0.3, 2.8, 1.3), CFrame.new(0, 1.0, -10.2) * A(rad(-25), 0, 0), BLACK, Mat.SmoothPlastic)
	T.P(J.Tail[3], V(0.3, 1.6, 1.0), CFrame.new(0, 2.6, -11.2) * A(rad(-55), 0, 0), DARK, Mat.SmoothPlastic)
	T.P(J.Tail[3], V(0.34, 0.8, 0.7), CFrame.new(0, 3.2, -12.2) * A(rad(-75), 0, 0), GLOW, Mat.Neon)
	T.P(J.Tail[3], V(0.36, 2.8, 0.14), CFrame.new(0, 0.72, -10.8) * A(rad(-25), 0, 0), GLOW, Mat.Neon)
end

DECOR["Void Dragon"] = function(T)
	local J = T.J
	local STARS = {rgb(255, 255, 255), rgb(150, 235, 255), rgb(255, 150, 240), rgb(190, 130, 255), rgb(255, 230, 150)}
	local PURPLE, PINK, BLACK, CYAN = rgb(170, 90, 255), rgb(255, 110, 230), rgb(8, 5, 20), rgb(110, 220, 255)
	local rng = T.rng
	local function star(j, pos, big)
		local size = big and rng:NextNumber(0.34, 0.5) or rng:NextNumber(0.12, 0.26)
		T.P(j, V(size, size, size), CFrame.new(pos) * A(rad(45), rad(45), 0), STARS[rng:NextInteger(1, #STARS)], Mat.Neon)
	end
	for _, s in {1, -1} do
		for i = 1, 16 do star(nil, V(s * 2.54, rng:NextNumber(-1.3, 1.3), rng:NextNumber(-3.3, 3.3)), i % 6 == 0) end     -- flancs étoilés
		for i = 1, 7 do star(J.Head, V(s * 2.24, rng:NextNumber(2.7, 5.3), rng:NextNumber(4.1, 7.0)), i % 5 == 0) end
		for _, w in {{"Wing", 2.6, 5.4, -3.3}, {"WingTip", 5.8, 8.4, -2.9}} do                                             -- galaxie sur les ailes
			for i = 1, 11 do star(J[w[1]][s], V(s * rng:NextNumber(w[2], w[3]), 1.66, rng:NextNumber(w[4], -0.5)), i % 5 == 0) end
			local cx = (w[2] + w[3]) / 2
			for i = 0, 6 do                                                                                               -- bras spiraux
				local a, r = i * 0.9, 0.25 + i * 0.17
				T.P(J[w[1]][s], V(0.34, 0.1, 0.34), CFrame.new(s * (cx + math.cos(a) * r), 1.66, -1.8 + math.sin(a) * r) * Y45, i % 2 == 0 and PINK or CYAN, Mat.Neon)
			end
			T.P(J[w[1]][s], V(0.55, 0.14, 0.55), CFrame.new(s * cx, 1.67, -1.8) * Y45, rgb(255, 255, 255), Mat.Neon)
		end
		-- éclats de vide qui flottent au-dessus du dos
		T.P(nil, V(0.7, 1.6, 0.7), CFrame.new(s * 2.4, 4.0, -2.8) * A(rad(15), rad(45), rad(-s * 15)), BLACK, Mat.SmoothPlastic)
		T.P(nil, V(0.3, 1.9, 0.3), CFrame.new(s * 2.4, 4.0, -2.8) * A(rad(15), rad(45), rad(-s * 15)), PURPLE, Mat.Neon)
		T.P(nil, V(0.5, 1.1, 0.5), CFrame.new(s * 2.9, 3.2, 1.8) * A(rad(-10), rad(45), rad(-s * 25)), BLACK, Mat.SmoothPlastic)
		T.P(nil, V(0.22, 1.3, 0.22), CFrame.new(s * 2.9, 3.2, 1.8) * A(rad(-10), rad(45), rad(-s * 25)), PINK, Mat.Neon)
		T.P(J.Head, V(0.5, 0.9, 0.5), V(s * 1.75, 8.5, 4.3), PURPLE, Mat.Neon)
		T.P(J.Head, V(0.45, 0.8, 0.45), CFrame.new(s * 2.9, 6.8, 4.6) * A(0, rad(45), rad(-s * 20)), BLACK, Mat.SmoothPlastic)
		T.P(J.Head, V(0.2, 1.0, 0.2), CFrame.new(s * 2.9, 6.8, 4.6) * A(0, rad(45), rad(-s * 20)), CYAN, Mat.Neon)
	end
	for key, leg in J.Leg do
		local sx, sz = key:sub(1, 1) == "R" and 1 or -1, key:sub(2, 2) == "F" and 1 or -1
		T.ring(leg, V(sx * 1.9, -1.7, sz * 2.4), 1.35, 8, 0.16, "y", PURPLE, Mat.Neon)
		for i = 1, 4 do star(leg, V(sx * 2.77, rng:NextNumber(-2.8, -1.4), sz * 2.4 + rng:NextNumber(-0.7, 0.7))) end
	end
	-- anneaux cosmiques : cou, dos, queue
	T.ring(J.Neck, V(0, 1.7, 3.8), 2.4, 10, 0.2, "z", PURPLE, Mat.Neon)
	T.ring(J.Neck, V(0, 1.7, 3.3), 2.8, 10, 0.12, "z", PINK, Mat.Neon)
	T.ring(J.Tail[2], V(0, 0, -6.3), 1.7, 8, 0.16, "z", CYAN, Mat.Neon)
	-- trou noir au bout de la queue, disque d'accrétion
	T.P(J.Tail[3], V(1.7, 1.7, 1.7), CFrame.new(0, -0.1, -10.6) * A(rad(45), rad(45), 0), BLACK, Mat.SmoothPlastic)
	T.ring(J.Tail[3], V(0, -0.1, -10.6), 1.9, 10, 0.2, "y", PINK, Mat.Neon)
	T.ring(J.Tail[3], V(0, -0.1, -10.6), 2.4, 10, 0.12, "y", CYAN, Mat.Neon)
	-- planète à anneau qui flotte derrière la selle
	T.P(nil, V(1.2, 1.2, 1.2), CFrame.new(0, 4.6, -3.2) * A(rad(20), rad(30), 0), rgb(110, 60, 200), Mat.SmoothPlastic)
	T.P(nil, V(1.24, 0.3, 1.24), CFrame.new(0, 4.6, -3.2) * A(rad(20), rad(30), 0), PINK, Mat.Neon)
	T.ring(nil, V(0, 4.6, -3.2), 1.3, 8, 0.12, "y", CYAN, Mat.Neon)
	-- troisième oeil et coeur de nébuleuse
	T.P(J.Head, V(0.7, 1.1, 0.3), V(0, 5.0, 7.38), PINK, Mat.Neon)
	T.P(J.Head, V(0.26, 0.7, 0.34), V(0, 5.0, 7.4), BLACK, Mat.SmoothPlastic)
	T.P(nil, V(1.4, 1.4, 0.35), CFrame.new(0, -0.3, 3.95) * A(0, 0, rad(45)), PURPLE, Mat.Neon)
	T.P(nil, V(0.7, 0.7, 0.4), CFrame.new(0, -0.3, 3.97) * A(0, 0, rad(45)), rgb(255, 255, 255), Mat.Neon)
	for i = 1, 8 do star(nil, V(rng:NextNumber(-1.6, 1.6), rng:NextNumber(-1.2, 0.6), 3.93), i % 4 == 0) end
end

DECOR["Celestial Dragon"] = function(T)
	local J = T.J
	local GOLD, LIGHT, WHITE, SKY = rgb(255, 205, 70), rgb(255, 240, 170), rgb(255, 255, 255), rgb(170, 225, 255)
	local function starShape(j, pos, size, rot)
		rot = rot or CFrame.identity
		T.P(j, V(size, size, size * 0.3), CFrame.new(pos) * rot, GOLD, Mat.Neon)
		T.P(j, V(size, size, size * 0.3), CFrame.new(pos) * rot * A(0, 0, rad(45)), LIGHT, Mat.Neon)
	end
	-- auréole au-dessus de la tête, grand disque solaire derrière la selle
	T.ring(J.Head, V(0, 9.4, 5.2), 1.7, 10, 0.3, "y", GOLD, Mat.Neon)
	T.ring(J.Head, V(0, 9.4, 5.2), 2.15, 10, 0.12, "y", LIGHT, Mat.Neon)
	T.ring(nil, V(0, 4.9, -3.3), 2.6, 12, 0.3, "z", GOLD, Mat.Neon)
	T.ring(nil, V(0, 4.9, -3.3), 1.9, 10, 0.14, "z", LIGHT, Mat.Neon)
	for i = 0, 7 do                                                             -- rayons
		local a = i / 8 * math.pi * 2
		T.P(nil, V(0.3, 1.2 + (i % 2) * 0.6, 0.25), CFrame.new(math.sin(a) * 3.6, 4.9 + math.cos(a) * 3.6, -3.3) * A(0, 0, -a), i % 2 == 0 and GOLD or LIGHT, Mat.Neon)
	end
	starShape(nil, V(0, 4.9, -3.3), 1.3)
	for _, s in {1, -1} do
		-- plumes en dégradé au bord des ailes
		for _, w in {{"Wing", {2.9, 3.7, 4.5, 5.2}}, {"WingTip", {6.0, 6.8, 7.6, 8.4}}} do
			for i, x in w[2] do
				T.P(J[w[1]][s], V(0.75, 0.26, 1.9), CFrame.new(s * x, 1.42, -4.1 - (i % 2) * 0.3) * A(rad(-8), rad(-s * 6), 0), WHITE)
				T.P(J[w[1]][s], V(0.55, 0.28, 0.7), CFrame.new(s * x, 1.36, -5.2 - (i % 2) * 0.3) * A(rad(-14), rad(-s * 6), 0), i % 2 == 0 and GOLD or SKY, Mat.Neon)
			end
		end
		T.P(J.WingTip[s], V(0.7, 0.26, 2.6), CFrame.new(s * 9.6, 1.42, -2.6) * A(0, rad(-s * 28), 0), WHITE)
		T.P(J.WingTip[s], V(0.5, 0.28, 0.8), CFrame.new(s * 10.3, 1.38, -3.9) * A(0, rad(-s * 28), 0), GOLD, Mat.Neon)
		starShape(J.Wing[s], V(s * 5.5, 2.3, 1.2), 0.8)
		-- armure dorée : épaulières, couronne
		T.P(nil, V(0.5, 1.6, 2.0), CFrame.new(s * 2.7, 0.8, 2.3) * A(rad(10), 0, 0), GOLD, Mat.Metal)
		T.P(nil, V(0.14, 0.9, 0.9), CFrame.new(s * 3.0, 0.8, 2.3) * A(rad(45), 0, 0), SKY, Mat.Neon)
		T.P(nil, V(0.3, 0.5, 6.4), V(s * 2.5, 1.75, 0), GOLD, Mat.Metal)
		T.P(J.Head, V(0.5, 1.4, 0.5), CFrame.new(s * 1.3, 6.5, 6.3) * A(0, rad(45), 0), GOLD, Mat.Metal)
		T.P(J.Head, V(0.3, 0.3, 0.3), CFrame.new(s * 1.3, 7.35, 6.3) * A(rad(45), rad(45), 0), SKY, Mat.Neon)
		T.P(J.Head, V(0.5, 0.9, 0.5), V(s * 1.75, 8.5, 4.3), LIGHT, Mat.Neon)
		T.P(J.Head, V(0.12, 1.6, 1.6), CFrame.new(s * 2.26, 4.0, 5.2) * A(rad(45), 0, 0), GOLD, Mat.Metal)
		-- petites étoiles qui flottent
		starShape(nil, V(s * 3.4, 3.4, 0.8), 0.6, A(0, rad(s * 30), 0))
		starShape(J.Head, V(s * 3.2, 7.0, 6.0), 0.5, A(0, rad(s * 30), 0))
	end
	for key, leg in J.Leg do                                                    -- jambières dorées
		local sx, sz = key:sub(1, 1) == "R" and 1 or -1, key:sub(2, 2) == "F" and 1 or -1
		T.P(leg, V(1.95, 0.4, 1.95), V(sx * 1.9, -1.45, sz * 2.4), GOLD, Mat.Metal)
		T.P(leg, V(2.1, 0.2, 2.4), V(sx * 1.9, -2.75, sz * 2.4 + 0.3), LIGHT, Mat.Neon)
	end
	-- couronne
	T.P(J.Head, V(3.4, 0.5, 0.5), V(0, 6.0, 6.3), GOLD, Mat.Metal)
	T.P(J.Head, V(0.6, 1.9, 0.6), CFrame.new(0, 6.9, 6.3) * A(0, rad(45), 0), GOLD, Mat.Metal)
	T.P(J.Head, V(0.45, 0.45, 0.45), CFrame.new(0, 8.0, 6.3) * A(rad(45), rad(45), 0), SKY, Mat.Neon)
	starShape(J.Head, V(0, 5.0, 7.4), 0.9)
	starShape(nil, V(0, -0.3, 3.97), 1.6)
	-- queue : anneaux dorés et étoile
	T.ring(J.Tail[1], V(0, 0.1, -4.4), 1.9, 8, 0.2, "z", GOLD, Mat.Neon)
	T.ring(J.Tail[2], V(0, 0, -6.3), 1.4, 8, 0.16, "z", LIGHT, Mat.Neon)
	starShape(J.Tail[3], V(0, -0.1, -10.4), 2.6, A(rad(90), 0, 0))
	starShape(J.Tail[3], V(0, -0.1, -10.4), 2.2)
end

M.tools = tools -- utilisé par ServerStorage.HalloweenDragons

function M.run(folder)
	local report = {}
	for name, fn in DECOR do
		local model = folder:FindFirstChild(name)
		if model then
			local T = tools(model)
			fn(T)
			table.insert(report, name .. " +" .. T.Count)
		end
	end
	return table.concat(report, ", ")
end

return M
