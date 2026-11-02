-- Outil d'édition (pas utilisé en jeu) : l'arbre-perchoir où dort le dragon d'un joueur, dans la zone sûre.
--   require(game.ServerStorage.DragonPerchBuilder).build()   reconstruit ServerStorage.DragonPerch
-- DragonServer en pose une copie devant la base de chaque joueur présent (et l'enlève quand il part).
-- Origine = sol, au centre du tronc. "Nest" = pièce invisible posée sur la paille : le dragon s'y couche, tourné vers +Z.
local M = {}
local V, rad, rgb = Vector3.new, math.rad, Color3.fromRGB
local A = CFrame.Angles
local Mat = Enum.Material
local STUDS = Enum.SurfaceType.Studs

M.NEST_HEIGHT = 6.6 -- hauteur de la paille au-dessus du sol

function M.build()
	local model = Instance.new("Model")
	model.Name = "DragonPerch"
	local BARK, BARK_D, BARK_L = rgb(112, 78, 50), rgb(84, 58, 38), rgb(140, 100, 64)
	local STRAW, STRAW_D = rgb(236, 200, 104), rgb(206, 160, 70)
	local LEAF, LEAF_L, LEAF_D = rgb(76, 170, 70), rgb(130, 205, 84), rgb(44, 120, 58)
	local rng = Random.new(11)
	local count = 0
	-- bloc à studs (matière nil) ou lisse ; solid = on peut marcher dessus
	local function P(size, cf, color, mat, solid, class)
		if typeof(cf) == "Vector3" then cf = CFrame.new(cf) end
		local p = Instance.new(class or "Part")
		p.Name = solid and "Solid" or "Deco"
		p.Anchored = true
		p.Size, p.CFrame, p.Color = size, cf, color
		p.Material = mat or Mat.Plastic
		local surface = mat and Enum.SurfaceType.Smooth or STUDS
		if not class then p.TopSurface, p.BottomSurface, p.LeftSurface, p.RightSurface, p.FrontSurface, p.BackSurface = surface, surface, surface, surface, surface, surface end
		p.CanCollide = solid == true
		p.CanTouch = false
		p.CanQuery = solid == true
		p.CastShadow = size.X * size.Y * size.Z > 1.5
		p.Parent = model
		count += 1
		return p
	end

	-- racines qui s'étalent, tronc à huit pans, collerette sous le nid
	for i = 0, 7 do
		local yaw = rad(i * 45 + 22)
		local long = i % 2 == 0
		P(V(long and 2.6 or 2.0, long and 1.7 or 1.2, long and 5.6 or 4.2), A(0, yaw, 0) * CFrame.new(0, long and 0.75 or 0.5, long and 4.6 or 4.0) * A(rad(long and 16 or 12), 0, 0), i % 3 == 0 and BARK_D or BARK, nil, true)
	end
	P(V(6.2, 5.4, 6.2), V(0, 2.7, 0), BARK, nil, true)
	P(V(6.2, 5.4, 6.2), CFrame.new(0, 2.7, 0) * A(0, rad(45), 0), BARK_D, nil, true)
	for i = 0, 3 do -- écorce : nervures claires et un noeud
		P(V(0.5, 4.2, 1.1), A(0, rad(i * 90 + 12), 0) * CFrame.new(0, 2.6, 3.2), BARK_L, Mat.SmoothPlastic)
	end
	P(V(1.5, 1.5, 0.5), A(0, rad(200), 0) * CFrame.new(0, 3.2, 3.2) * A(0, 0, rad(45)), BARK_D, Mat.SmoothPlastic)
	P(V(0.8, 0.8, 0.6), A(0, rad(200), 0) * CFrame.new(0, 3.2, 3.25) * A(0, 0, rad(45)), rgb(50, 34, 24), Mat.SmoothPlastic)
	P(V(8.6, 1.0, 8.6), V(0, 5.5, 0), BARK_L, nil, true)
	P(V(8.6, 1.0, 8.6), CFrame.new(0, 5.5, 0) * A(0, rad(45), 0), BARK, nil, true)

	-- nid : lit de paille (deux carrés croisés), couronne de rondins, brindilles
	P(V(13.2, 0.8, 13.2), V(0, 6.2, 0), STRAW, nil, true)
	P(V(13.2, 0.8, 13.2), CFrame.new(0, 6.2, 0) * A(0, rad(45), 0), STRAW_D, nil, true)
	local radius, n = 7.4, 12
	for i = 0, n - 1 do
		local yaw = (i + 0.5) / n * math.pi * 2
		local len = 2 * radius * math.tan(math.pi / n) + 0.7
		P(V(len, 1.4, 1.7), A(0, yaw, 0) * CFrame.new(0, 6.95, radius) * A(0, 0, rad(rng:NextNumber(-5, 5))), i % 2 == 0 and BARK or BARK_D, nil, true)
		if i % 2 == 0 then P(V(len * 0.8, 0.9, 1.3), A(0, yaw, 0) * CFrame.new(0, 7.9, radius - 0.25) * A(0, 0, rad(rng:NextNumber(-7, 7))), BARK_L, nil, true) end
		for _ = 1, 2 do -- brindilles de paille qui dépassent
			P(V(0.3, 0.3, rng:NextNumber(1.8, 3)), A(0, yaw + rng:NextNumber(-0.2, 0.2), 0) * CFrame.new(0, rng:NextNumber(6.6, 7.6), radius + 0.9) * A(rad(rng:NextNumber(-30, 20)), rad(rng:NextNumber(-40, 40)), 0), rng:NextNumber() < 0.5 and STRAW or STRAW_D, Mat.SmoothPlastic)
		end
	end
	for _ = 1, 9 do -- touffes de paille sur le lit
		local a, r = rng:NextNumber(0, 6.28), rng:NextNumber(1, 5.6)
		P(V(1.6, 0.3, 1.6), CFrame.new(math.cos(a) * r, 6.68, math.sin(a) * r) * A(0, rng:NextNumber(0, 1.5), 0), rng:NextNumber() < 0.5 and STRAW_D or rgb(250, 222, 140))
	end

	-- branches : elles partent du tronc et montent vers l'extérieur, feuillage au bout (hors du nid : le dragon a la place)
	local function branch(yawDeg, steps, leafSize)
		local cf = A(0, rad(yawDeg), 0) * CFrame.new(0, 3.6, 3.0) * A(rad(62), 0, 0) -- passe sous le nid, ressort au-delà de la couronne
		for i, s in steps do
			P(V(s[2], s[1] + s[2] * 0.4, s[2]), cf * CFrame.new(0, s[1] / 2, 0), i % 2 == 1 and BARK or BARK_D, nil, i == 1)
			cf = cf * CFrame.new(0, s[1], 0) * A(rad(s[3]), 0, rad(s[4] or 0))
		end
		local tip = cf.Position
		for i, leaf in {{V(0, 0.6, 0), 1}, {V(1.9, -0.3, 0.8), 0.72}, {V(-1.5, 0.2, 1.4), 0.66}, {V(0.3, 1.9, -0.6), 0.6}, {V(-0.6, -0.9, -1.7), 0.56}} do
			local size = leafSize * leaf[2]
			P(V(size, size, size), CFrame.new(tip + leaf[1] * leafSize * 0.42) * A(rad(rng:NextNumber(-14, 14)), rad(rng:NextNumber(0, 90)), rad(rng:NextNumber(-14, 14))), ({LEAF, LEAF_L, LEAF_D})[(i - 1) % 3 + 1])
		end
		return tip
	end
	branch(204, {{5.6, 2.2, -30}, {4.6, 1.7, -28}, {3.0, 1.2, 0}}, 5.2)
	branch(152, {{5.4, 2.0, -30}, {4.2, 1.5, -28}, {2.6, 1.1, 0}}, 4.6)
	local hook = branch(258, {{5.2, 1.7, -30}, {3.6, 1.3, -28}, {2.4, 0.9, 0}}, 3.6)
	branch(104, {{5.2, 1.5, -34}, {2.6, 1.0, -20}, {1.6, 0.8, 0}}, 3.0)

	-- lanterne suspendue : elle éclaire le dragon qui dort
	local lantern = hook + V(0.4, -3.4, 1.6)
	P(V(0.14, 2.6, 0.14), lantern + V(0, 2.0, 0), rgb(40, 40, 46), Mat.Metal)
	P(V(1.5, 0.3, 1.5), lantern + V(0, 0.85, 0), rgb(40, 40, 46), Mat.Metal)
	P(V(1.5, 0.3, 1.5), lantern + V(0, -0.85, 0), rgb(40, 40, 46), Mat.Metal)
	for _, c in {V(1, 0, 1), V(-1, 0, 1), V(1, 0, -1), V(-1, 0, -1)} do P(V(0.18, 1.5, 0.18), lantern + c * 0.62, rgb(40, 40, 46), Mat.Metal) end
	local glow = P(V(1.0, 1.3, 1.0), lantern, rgb(255, 206, 120), Mat.Neon)
	glow.Name = "Lantern"
	local light = Instance.new("PointLight")
	light.Color, light.Range, light.Brightness, light.Shadows = rgb(255, 196, 110), 18, 1.3, false
	light.Parent = glow
	P(V(0.7, 0.5, 0.7), lantern + V(0, 1.15, 0), rgb(40, 40, 46), Mat.Metal)

	-- quelques champignons et une marche pour grimper
	for _, m in {{150, 3.6, 1.0}, {172, 3.9, 0.7}, {330, 3.7, 0.8}} do
		local base = A(0, rad(m[1]), 0) * CFrame.new(0, 0, m[2])
		P(V(0.45, 0.8, 0.45) * m[3], base * CFrame.new(0, 0.4 * m[3], 0), rgb(250, 240, 220), Mat.SmoothPlastic)
		P(V(1.3, 0.5, 1.3) * m[3], base * CFrame.new(0, 0.95 * m[3], 0), rgb(226, 60, 54))
		P(V(0.3, 0.12, 0.3) * m[3], base * CFrame.new(0.25 * m[3], 1.22 * m[3], 0.2 * m[3]), Color3.new(1, 1, 1), Mat.SmoothPlastic)
	end
	for i, step in {{2.2, 9.0}, {4.6, 7.4}} do
		P(V(3.4, 1.0, 2.4), A(0, rad(88), 0) * CFrame.new(0, step[1] - 0.5, step[2] + 1.6), i == 1 and BARK_D or BARK, nil, true)
	end

	local nest = Instance.new("Part")
	nest.Name = "Nest"
	nest.Anchored, nest.Transparency, nest.Size = true, 1, V(1, 0.2, 1)
	nest.CanCollide, nest.CanTouch, nest.CanQuery = false, false, false
	nest.CFrame = CFrame.new(0, M.NEST_HEIGHT, 0)
	nest.Parent = model
	nest.PivotOffset = CFrame.new(0, -M.NEST_HEIGHT, 0) -- le pivot de l'arbre est au sol, sous le nid
	model.PrimaryPart = nest
	local store = game:GetService("ServerStorage")
	local old = store:FindFirstChild(model.Name)
	if old then old:Destroy() end
	model.Parent = store
	return model, count
end

return M
