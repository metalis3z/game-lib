-- Outil d'édition (pas utilisé en jeu) : construit le décor de la cinématique d'arrivée, Workspace.IntroForest.
-- Une forêt d'Halloween derrière la dernière zone : une allée bordée de grands arbres morts, de citrouilles, de tombes et de
-- lanternes. Le boss de la dernière zone y bondit d'arbre en arbre vers la caméra (StarterPlayerScripts.IntroClient).
-- Repères invisibles lus par la cinématique : BossStart, Perch1..6 (cimes où il se pose), BossLand, CameraSpot.
-- Tout est sans collision et sans ombre ; le modèle arrive d'un bloc chez le joueur (streaming « Atomic »).
-- return function() -> rapport. Peut être relancé.
local V = Vector3.new
local rad = math.rad
local rgb = Color3.fromRGB

local AHEAD = 110   -- distance entre la fin de la dernière zone et le début de la forêt
local LENGTH = 520  -- longueur de l'allée
local HALF = 100    -- demi-largeur de la forêt

return function()
	local zones = {}
	for _, p in workspace:GetChildren() do
		if p:IsA("BasePart") and p.Name:lower():find("egg zone") then table.insert(zones, p) end
	end
	table.sort(zones, function(a, b) return a.Position.X < b.Position.X end)
	local last = zones[#zones]
	assert(last, "no egg zone found")
	local x0 = last.Position.X + last.Size.X / 2 + AHEAD
	local zc = last.Position.Z
	local ground = last.Position.Y + last.Size.Y / 2

	local old = workspace:FindFirstChild("IntroForest")
	if old then old:Destroy() end
	local m = Instance.new("Model")
	m.Name = "IntroForest"
	m.ModelStreamingMode = Enum.ModelStreamingMode.Atomic
	local rng = Random.new(31)
	local count = 0
	local function block(name, size, cf, color, o)
		o = o or {}
		local p = Instance.new("Part")
		p.Name = name
		p.Size, p.CFrame, p.Color = size, cf, color
		p.Material = o.neon and Enum.Material.Neon or Enum.Material.Plastic
		if not o.neon then pcall(function() p.MaterialVariant = "Studs" end) end
		p.Transparency = o.transparency or 0
		p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
		p.Anchored = true
		p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = false, false, false, false
		p.Parent = m
		count += 1
		return p
	end
	local function marker(name, position)
		local p = block(name, V(1, 1, 1), CFrame.new(position), rgb(255, 255, 255), {transparency = 1})
		return p
	end

	-- sol : terre sombre, allée plus claire au milieu
	block("Ground", V(LENGTH + 120, 2, HALF * 2 + 40), CFrame.new(x0 + LENGTH / 2, ground - 1.02, zc), rgb(36, 28, 50))
	block("Path", V(LENGTH + 120, 2, 34), CFrame.new(x0 + LENGTH / 2, ground - 1, zc), rgb(62, 48, 74))

	-- arbres : tronc en trois tronçons décalés, branches nues, feuillage en gros blocs
	local TRUNK = rgb(44, 34, 44)
	local LEAVES = {rgb(58, 34, 92), rgb(88, 46, 128), rgb(196, 92, 24), rgb(150, 60, 20), rgb(40, 30, 70)}
	local function tree(x, z, height, perch)
		local width = math.max(height * 0.13, 3)
		local y = ground
		for i = 1, 3 do
			local w = width * (1.2 - 0.17 * i)
			local h = height / 3
			block("Trunk", V(w, h, w), CFrame.new(x + rng:NextNumber(-0.6, 0.6) * i, y + h / 2, z + rng:NextNumber(-0.6, 0.6) * i) * CFrame.Angles(0, rad(rng:NextInteger(0, 3) * 12), 0), TRUNK)
			y += h
		end
		for i = 1, 3 do -- branches
			local at = CFrame.new(x, ground + height * (0.5 + i * 0.11), z) * CFrame.Angles(0, rad(i * 120 + rng:NextInteger(-25, 25)), 0) * CFrame.Angles(0, 0, rad(rng:NextInteger(48, 64)))
			block("Branch", V(width * 0.34, height * 0.34, width * 0.34), at * CFrame.new(0, height * 0.17, 0), TRUNK)
		end
		local top = ground + height
		if perch then
			-- cime plate et large : le boss s'y pose
			block("Canopy", V(36, 7, 36), CFrame.new(x, top + 0.5, z) * CFrame.Angles(0, rad(rng:NextInteger(0, 40)), 0), LEAVES[1])
			block("Canopy", V(26, 6, 26), CFrame.new(x + 4, top - 5, z - 3) * CFrame.Angles(0, rad(25), 0), LEAVES[2])
			block("Canopy", V(20, 5, 20), CFrame.new(x - 6, top - 9, z + 5), LEAVES[3])
			return top + 4
		end
		for i = 1, 3 do
			local s = height * rng:NextNumber(0.3, 0.44)
			block("Canopy", V(s, s * 0.62, s), CFrame.new(x + rng:NextNumber(-0.14, 0.14) * height, top - (i - 1) * height * 0.1, z + rng:NextNumber(-0.14, 0.14) * height) * CFrame.Angles(0, rad(rng:NextInteger(0, 80)), 0), LEAVES[rng:NextInteger(1, #LEAVES)])
		end
		return top
	end

	-- les six arbres où le boss se pose : en zigzag de part et d'autre de l'allée, du fond vers la caméra
	local perches = {{470, 40, 60}, {400, -40, 56}, {330, 38, 62}, {262, -38, 52}, {196, 36, 56}, {134, -30, 46}}
	for i, p in perches do
		local top = tree(x0 + p[1], zc + p[2], p[3], true)
		marker("Perch" .. i, V(x0 + p[1], top, zc + p[2]))
	end
	-- la forêt autour : deux bandes de chaque côté de l'allée
	local placed = 0
	while placed < 34 do
		local x = x0 + rng:NextNumber(0, LENGTH + 60)
		local side = placed % 2 == 0 and 1 or -1
		local z = zc + side * rng:NextNumber(58, HALF + 8)
		local clear = true
		for _, p in perches do
			if math.abs(x - (x0 + p[1])) < 30 and math.abs(z - (zc + p[2])) < 30 then clear = false end
		end
		if clear then
			tree(x, z, rng:NextNumber(34, 66), false)
			placed += 1
		end
	end

	-- citrouilles taillées le long de l'allée, le visage tourné vers la caméra
	local function pumpkin(x, z, s, lit)
		local body = block("Pumpkin", V(5, 4, 5) * s, CFrame.new(x, ground + 2 * s, z), rgb(236, 120, 20))
		block("Pumpkin", V(3.8, 0.8, 3.8) * s, CFrame.new(x, ground + 4.3 * s, z), rgb(206, 96, 14))
		block("Pumpkin", V(0.9, 1.3, 0.9) * s, CFrame.new(x + 0.2 * s, ground + 5.2 * s, z) * CFrame.Angles(0, 0, rad(-12)), rgb(86, 110, 44))
		local face = x - 2.5 * s - 0.06
		local glow = rgb(255, 214, 70)
		for _, side in {-1, 1} do
			block("PumpkinFace", V(0.14, 0.9 * s, 0.9 * s), CFrame.new(face, ground + 2.7 * s, z + side * 1.1 * s) * CFrame.Angles(rad(45), 0, 0), glow, {neon = true})
		end
		block("PumpkinFace", V(0.14, 0.6 * s, 2.8 * s), CFrame.new(face, ground + 1.3 * s, z), glow, {neon = true})
		if lit then
			local light = Instance.new("PointLight")
			light.Color, light.Range, light.Brightness, light.Shadows = rgb(255, 150, 40), 30, 1.3, false
			light.Parent = body
		end
	end
	for i = 0, 15 do
		local side = i % 2 == 0 and 1 or -1
		pumpkin(x0 + 26 + i * 31 + rng:NextNumber(-6, 6), zc + side * rng:NextNumber(20, 30), rng:NextNumber(0.8, 1.7), i % 3 == 0)
	end
	-- tombes
	for i = 0, 9 do
		local side = i % 2 == 0 and -1 or 1
		local at = CFrame.new(x0 + 46 + i * 48 + rng:NextNumber(-8, 8), ground, zc + side * rng:NextNumber(34, 48)) * CFrame.Angles(0, rad(90 + rng:NextInteger(-14, 14)), rad(rng:NextInteger(-7, 7)))
		block("Tomb", V(3.2, 4.6, 0.9), at * CFrame.new(0, 2.3, 0), rgb(120, 118, 132))
		block("Tomb", V(2.2, 1.0, 0.9), at * CFrame.new(0, 5.0, 0), rgb(138, 136, 150))
	end
	-- lanternes : un poteau, un bras, une lampe orange
	for i = 0, 5 do
		local side = i % 2 == 0 and 1 or -1
		local x, z = x0 + 60 + i * 84, zc + side * 19
		block("Lantern", V(0.9, 10, 0.9), CFrame.new(x, ground + 5, z), rgb(30, 26, 36))
		block("Lantern", V(0.7, 0.7, 3.2), CFrame.new(x, ground + 9.6, z - side * 1.4), rgb(30, 26, 36))
		local lamp = block("LanternLight", V(1.6, 1.8, 1.6), CFrame.new(x, ground + 8.3, z - side * 2.8), rgb(255, 150, 50), {neon = true})
		local light = Instance.new("PointLight")
		light.Color, light.Range, light.Brightness, light.Shadows = rgb(255, 160, 70), 34, 1.5, false
		light.Parent = lamp
	end

	-- repères de la cinématique
	marker("BossStart", V(x0 + LENGTH + 40, ground, zc + 10))
	marker("BossLand", V(x0 + 66, ground, zc))
	marker("CameraSpot", V(x0 + 10, ground + 15, zc + 6))
	m.Parent = workspace
	return string.format("IntroForest built : %d parts, from x %.0f to %.0f, ground y %.2f", count, x0, x0 + LENGTH, ground)
end
