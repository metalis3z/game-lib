-- Outil d'édition (pas utilisé en jeu) : construit la forêt d'Halloween de la cinématique "Samouraï contre la horde"
-- dans ReplicatedStorage.FightFilm.Set. Dans la barre de commande : require(game.ServerStorage.SamuraiForestBuilder).Build()
-- Repère : clairière au centre (0, 0, 0), sol à y = 0. Les monstres et le boss arrivent par le sentier côté +X,
-- la lune se lève dans l'axe de ce sentier. Les troncs proches portent l'attribut Blocker (la caméra les évite).
local M = {}
local rgb = Color3.fromRGB
local rad, sin, cos = math.rad, math.sin, math.cos
local V = Vector3.new

function M.Build()
	local rng = Random.new(31)
	local film = game.ReplicatedStorage:FindFirstChild("FightFilm")
	local old = film:FindFirstChild("Set")
	if old then old:Destroy() end
	local set = Instance.new("Model")
	set.Name = "Set"
	local folders = {}
	local function folder(name)
		if not folders[name] then
			local f = Instance.new("Model")
			f.Name = name
			f.Parent = set
			folders[name] = f
		end
		return folders[name]
	end
	local function part(group, size, cf, color, o)
		o = o or {}
		local p = Instance.new(o.Wedge and "WedgePart" or "Part")
		p.Name = o.Name or "Part"
		p.Size = size
		p.CFrame = typeof(cf) == "Vector3" and CFrame.new(cf) or cf
		p.Color = color
		p.Material = o.Neon and Enum.Material.Neon or (o.Material or Enum.Material.Plastic)
		if o.Studs then p.MaterialVariant = "Studs" end
		p.Transparency = o.Transparency or 0
		p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
		p.Anchored = true
		p.CanCollide, p.CanTouch = false, false
		p.CanQuery = o.Blocker == true
		if o.Blocker then p:SetAttribute("Blocker", true) end
		p.CastShadow = o.Shadow ~= false and not o.Neon
		p.Parent = typeof(group) == "string" and folder(group) or group
		return p
	end
	local function light(parent, color, range, brightness, name)
		local l = Instance.new("PointLight")
		l.Name = name or "Flicker"
		l.Color, l.Range, l.Brightness, l.Shadows = color, range, brightness, false
		l.Parent = parent
		return l
	end
	local function polar(r, a) return V(cos(a) * r, 0, sin(a) * r) end

	local origin = part(set, V(1, 1, 1), V(0, 0, 0), rgb(0, 0, 0), {Transparency = 1, Name = "Origin"})
	set.PrimaryPart = origin

	---------------- sol : terre sombre à studs, plaques de terre battue dans la clairière, sentier vers +X
	part("Ground", V(420, 2, 420), V(0, -1, 0), rgb(20, 30, 32), {Studs = true, Name = "Ground"})
	for i = 1, 16 do
		local p = polar(rng:NextNumber(0, 24), rng:NextNumber(0, 6.283))
		part("Ground", V(rng:NextNumber(9, 18), 0.12, rng:NextNumber(8, 15)), CFrame.new(p + V(0, 0.03 + i * 0.004, 0)) * CFrame.Angles(0, rng:NextNumber(0, 3), 0), i % 3 == 0 and rgb(44, 40, 44) or rgb(34, 36, 40), {Studs = true, Shadow = false})
	end
	for i = 0, 9 do
		part("Ground", V(11, 0.12, rng:NextNumber(9, 12)), CFrame.new(26 + i * 9, 0.05 + i * 0.003, sin(i * 0.7) * 2.5) * CFrame.Angles(0, rng:NextNumber(-0.3, 0.3), 0), rgb(40, 38, 44), {Studs = true, Shadow = false})
	end

	---------------- arrière-plan : collines et silhouettes de grands arbres
	for i = 1, 14 do
		local a = i / 14 * 6.283 + 0.2
		if math.abs(((a + math.pi) % 6.283) - math.pi) < 0.32 then continue end -- l'axe de la lune reste dégagé
		local r, h, w = rng:NextNumber(170, 200), rng:NextNumber(26, 58), rng:NextNumber(70, 120)
		local p = polar(r, a)
		part("Background", V(w, h, 40), CFrame.new(p + V(0, h / 2 - 4, 0)) * CFrame.Angles(0, -a + rad(90), 0), rgb(9, 13, 22), {Shadow = false})
		part("Background", V(w * 0.6, h * 0.5, 36), CFrame.new(p + V(0, h + h * 0.2 - 4, 0)) * CFrame.Angles(0, -a + rad(90), rad(rng:NextNumber(-8, 8))), rgb(9, 13, 22), {Shadow = false})
	end

	---------------- arbres tordus
	local BARK = {rgb(30, 24, 30), rgb(38, 30, 34), rgb(24, 20, 28)}
	local LEAF = {rgb(14, 34, 36), rgb(20, 26, 48), rgb(12, 28, 26), rgb(96, 46, 16)}
	local treeCount = 0
	local function tree(pos, height, girth, near)
		treeCount += 1
		local group = Instance.new("Model")
		group.Name = "Tree"
		group.Parent = folder(near and "TreesNear" or "TreesFar")
		local bark = BARK[rng:NextInteger(1, #BARK)]
		local cf = CFrame.new(pos) * CFrame.Angles(0, rng:NextNumber(0, 6.283), 0)
		local segments = near and 5 or 3
		local segH = height / segments
		local tips = {}
		-- racines
		for k = 1, near and 5 or 3 do
			local a = k / 5 * 6.283 + rng:NextNumber(-0.3, 0.3)
			part(group, V(girth * 0.45, girth * 0.5, girth * 1.6), cf * CFrame.Angles(0, a, 0) * CFrame.new(0, girth * 0.12, -girth * 0.9) * CFrame.Angles(rad(-22), 0, 0), bark, {Studs = true})
		end
		for i = 1, segments do
			local g = girth * (1 - (i - 1) / segments * 0.62)
			part(group, V(g, segH + g * 0.3, g), cf * CFrame.new(0, segH / 2, 0), bark, {Studs = true, Blocker = near and i <= 3})
			cf = cf * CFrame.new(0, segH, 0) * CFrame.Angles(rad(rng:NextNumber(-16, 16)), rng:NextNumber(-0.5, 0.5), rad(rng:NextNumber(-16, 16)))
			if i >= 2 then table.insert(tips, {cf, g}) end
		end
		-- branches : deux segments coudés puis une brindille
		for _, tip in tips do
			for _ = 1, near and 2 or 1 do
				local b = tip[1] * CFrame.Angles(0, rng:NextNumber(0, 6.283), 0) * CFrame.Angles(rad(rng:NextNumber(48, 78)), 0, 0)
				local len, g = height * rng:NextNumber(0.2, 0.34), tip[2] * 0.5
				part(group, V(g, len, g), b * CFrame.new(0, len / 2, 0), bark, {Studs = true})
				b = b * CFrame.new(0, len, 0) * CFrame.Angles(rad(rng:NextNumber(-40, -10)), rng:NextNumber(-0.6, 0.6), rad(rng:NextNumber(-25, 25)))
				part(group, V(g * 0.6, len * 0.8, g * 0.6), b * CFrame.new(0, len * 0.4, 0), bark)
				if near then
					local twig = b * CFrame.new(0, len * 0.8, 0) * CFrame.Angles(rad(rng:NextNumber(-50, 50)), 0, rad(rng:NextNumber(-50, 50)))
					part(group, V(g * 0.3, len * 0.5, g * 0.3), twig * CFrame.new(0, len * 0.25, 0), bark, {Shadow = false})
				end
				-- feuillage clairsemé au bout
				if rng:NextNumber() < 0.75 then
					local c = (b * CFrame.new(0, len * 0.8, 0)).Position
					local s = height * rng:NextNumber(0.16, 0.26)
					part(group, V(s * 1.5, s * 0.5, s * 1.3), CFrame.new(c) * CFrame.Angles(rng:NextNumber(-0.3, 0.3), rng:NextNumber(0, 3), rng:NextNumber(-0.3, 0.3)), LEAF[rng:NextInteger(1, #LEAF)], {Studs = true})
					if near then part(group, V(s, s * 0.4, s * 0.9), CFrame.new(c + V(rng:NextNumber(-2, 2), s * 0.4, rng:NextNumber(-2, 2))) * CFrame.Angles(0, rng:NextNumber(0, 3), 0), LEAF[rng:NextInteger(1, 3)], {Studs = true}) end
				end
			end
		end
		return group
	end
	local placed = {}
	local function free(p, minDist)
		for _, q in placed do if (q - p).Magnitude < minDist then return false end end
		return true
	end
	local tries = 0
	while treeCount < 58 and tries < 900 do
		tries += 1
		local a = rng:NextNumber(0, 6.283)
		local r = 36 + rng:NextNumber(0, 1) ^ 1.6 * 110
		local p = polar(r, a)
		local onPath = p.X > 20 and math.abs(p.Z) < 9 + p.X * 0.05 -- le sentier et l'axe de la lune restent libres
		if not onPath and free(p, r < 60 and 10 or 14) then
			table.insert(placed, p)
			local near = r < 64
			tree(p, near and rng:NextNumber(26, 38) or rng:NextNumber(34, 56), near and rng:NextNumber(3.0, 4.4) or rng:NextNumber(4, 6.5), near)
		end
		if tries % 60 == 0 then task.wait() end
	end
	-- deux grands arbres qui encadrent l'entrée du sentier : le boss sortira entre ces deux troncs
	tree(V(40, 0, -11), 44, 5.2, true)
	tree(V(42, 0, 11.5), 48, 5.6, true)
	task.wait()

	---------------- rochers, racines, branches tombées
	for i = 1, 16 do
		local p = polar(rng:NextNumber(24, 46), rng:NextNumber(0, 6.283))
		if p.X > 18 and math.abs(p.Z) < 8 then continue end
		local s = rng:NextNumber(1.6, 4.2)
		for k = 1, 3 do
			part("Rocks", V(s * rng:NextNumber(0.6, 1.3), s * rng:NextNumber(0.5, 0.9), s * rng:NextNumber(0.6, 1.2)), CFrame.new(p + V(rng:NextNumber(-s, s) * 0.6, s * 0.25, rng:NextNumber(-s, s) * 0.6)) * CFrame.Angles(rng:NextNumber(-0.4, 0.4), rng:NextNumber(0, 3), rng:NextNumber(-0.4, 0.4)), k == 1 and rgb(52, 56, 70) or rgb(40, 44, 58), {Studs = true})
		end
	end
	for i = 1, 9 do
		local p = polar(rng:NextNumber(14, 32), rng:NextNumber(0, 6.283))
		local cf = CFrame.new(p + V(0, 0.3, 0)) * CFrame.Angles(0, rng:NextNumber(0, 6.283), rad(rng:NextNumber(-6, 6)))
		local len = rng:NextNumber(4, 8)
		part("Branches", V(len, 0.5, 0.5), cf, BARK[1], {Studs = true})
		part("Branches", V(len * 0.4, 0.3, 0.3), cf * CFrame.new(len * 0.2, 0.1, 0.5) * CFrame.Angles(0, rad(35), 0), BARK[2])
		part("Branches", V(len * 0.3, 0.26, 0.26), cf * CFrame.new(-len * 0.25, 0.1, -0.4) * CFrame.Angles(0, rad(-40), 0), BARK[2])
	end

	---------------- herbes sombres et feuilles mortes (premier plan)
	for i = 1, 150 do
		local p = polar(rng:NextNumber(3, 46), rng:NextNumber(0, 6.283))
		local yaw = rng:NextNumber(0, 6.283)
		local h = rng:NextNumber(0.9, 2.0)
		local color = i % 4 == 0 and rgb(34, 70, 60) or rgb(22, 52, 46)
		for k = -1, 1 do
			part("Grass", V(0.12, h * (k == 0 and 1 or 0.75), 0.4), CFrame.new(p) * CFrame.Angles(0, yaw + k * 0.9, 0) * CFrame.Angles(rad(k * 16), 0, rad(k * 12)) * CFrame.new(0, h * 0.4, 0), color, {Wedge = true, Shadow = false, Name = "Blade"})
		end
		if i % 30 == 0 then task.wait() end
	end
	local LEAVES = {rgb(190, 86, 20), rgb(140, 60, 16), rgb(214, 130, 30), rgb(96, 40, 14)}
	for i = 1, 110 do
		local p = polar(rng:NextNumber(1, 40), rng:NextNumber(0, 6.283))
		local s = rng:NextNumber(0.45, 0.8)
		part("Leaves", V(s, 0.05, s * 0.8), CFrame.new(p + V(0, 0.2, 0)) * CFrame.Angles(rng:NextNumber(-0.15, 0.15), rng:NextNumber(0, 6.283), rng:NextNumber(-0.15, 0.15)), LEAVES[rng:NextInteger(1, #LEAVES)], {Shadow = false, Name = "Leaf"})
	end
	task.wait()

	---------------- citrouilles lumineuses
	local function pumpkin(p, s, yaw)
		local group = Instance.new("Model")
		group.Name = "Pumpkin"
		group.Parent = folder("Pumpkins")
		local cf = CFrame.new(p + V(0, s * 0.42, 0)) * CFrame.Angles(0, yaw, 0)
		local O1, O2, O3, GLOW = rgb(240, 112, 15), rgb(214, 86, 10), rgb(160, 58, 6), rgb(255, 196, 70)
		part(group, V(s, s * 0.8, s), cf, O1, {Studs = true})
		part(group, V(s * 1.22, s * 0.58, s * 0.72), cf, O2)
		part(group, V(s * 0.72, s * 0.58, s * 1.22), cf, O2)
		part(group, V(s * 0.66, s * 0.12, s * 0.66), cf * CFrame.new(0, s * 0.45, 0), O3)
		part(group, V(s * 0.16, s * 0.3, s * 0.16), cf * CFrame.new(s * 0.04, s * 0.62, 0) * CFrame.Angles(0, 0, -0.25), rgb(60, 110, 40))
		for _, e in {1, -1} do
			part(group, V(s * 0.06, s * 0.22, s * 0.28), cf * CFrame.fromMatrix(V(e * s * 0.24, s * 0.1, -s * 0.63), V(0, 0, e), V(0, 1, 0), V(-e, 0, 0)), GLOW, {Neon = true, Wedge = true})
		end
		part(group, V(s * 0.56, s * 0.11, s * 0.06), cf * CFrame.new(0, -s * 0.17, -s * 0.63), GLOW, {Neon = true})
		part(group, V(s * 0.1, s * 0.09, s * 0.07), cf * CFrame.new(s * 0.13, -s * 0.12, -s * 0.635), O1)
		part(group, V(s * 0.1, s * 0.09, s * 0.07), cf * CFrame.new(-s * 0.13, -s * 0.22, -s * 0.635), O1)
		local core = part(group, V(0.2, 0.2, 0.2), cf, GLOW, {Transparency = 1, Name = "Glow"})
		light(core, rgb(255, 140, 40), 9 + s * 5, 1.5)
	end
	local function facing(p) return math.atan2(p.X, p.Z) end -- le visage (côté -Z) regarde le centre de la clairière
	for i = 1, 15 do
		local a = i / 15 * 6.283 + rng:NextNumber(-0.15, 0.15)
		local p = polar(rng:NextNumber(23, 33), a)
		if p.X > 16 and math.abs(p.Z) < 7 then p = V(p.X, 0, p.Z < 0 and -8.5 or 8.5) end
		pumpkin(p, rng:NextNumber(1.6, 3.2), facing(p) + rng:NextNumber(-0.3, 0.3))
		if i % 3 == 0 then pumpkin(p + V(rng:NextNumber(-2.4, 2.4), 0, rng:NextNumber(1.6, 2.6)), rng:NextNumber(0.9, 1.4), facing(p) + rng:NextNumber(-0.6, 0.6)) end
	end
	for i = 1, 5 do -- le long du sentier
		for _, e in {1, -1} do
			local p = V(34 + i * 11, 0, e * (8 + i * 0.5))
			pumpkin(p, rng:NextNumber(1.2, 2.2), e == 1 and math.pi or 0)
		end
	end

	---------------- lanternes sur leurs poteaux tordus
	local IRON = rgb(34, 30, 40)
	for i = 1, 8 do
		local a = i / 8 * 6.283 + 0.4
		local p = polar(29, a)
		if p.X > 16 and math.abs(p.Z) < 9 then p = V(p.X, 0, p.Z < 0 and -10 or 10) end
		local group = Instance.new("Model")
		group.Name = "Lantern"
		group.Parent = folder("Lanterns")
		local cf = CFrame.new(p) * CFrame.Angles(0, facing(p), 0) * CFrame.Angles(0, 0, rad(rng:NextNumber(-5, 5)))
		part(group, V(0.7, 8.5, 0.7), cf * CFrame.new(0, 4.25, 0), rgb(46, 34, 30), {Studs = true})
		part(group, V(0.4, 0.4, 3.0), cf * CFrame.new(0, 8.3, -1.3), rgb(46, 34, 30))
		part(group, V(0.3, 0.3, 2.0), cf * CFrame.new(0, 7.5, -0.8) * CFrame.Angles(rad(-42), 0, 0), rgb(46, 34, 30))
		part(group, V(0.1, 1.2, 0.1), cf * CFrame.new(0, 7.6, -2.5), IRON)
		local body = cf * CFrame.new(0, 6.4, -2.5)
		part(group, V(1.1, 0.18, 1.1), body * CFrame.new(0, 0.7, 0), IRON)
		part(group, V(1.1, 0.18, 1.1), body * CFrame.new(0, -0.7, 0), IRON)
		for _, cx in {0.5, -0.5} do for _, cz in {0.5, -0.5} do part(group, V(0.12, 1.4, 0.12), body * CFrame.new(cx, 0, cz), IRON) end end
		part(group, V(0.6, 0.5, 0.6), body * CFrame.new(0, 0.95, 0), IRON, {Wedge = false})
		local core = part(group, V(0.7, 0.95, 0.7), body, rgb(255, 170, 60), {Neon = true, Name = "Glow"})
		light(core, rgb(255, 150, 50), 22, 1.6)
	end

	---------------- tombes et bouts de clôture
	for i = 1, 7 do
		local p = polar(rng:NextNumber(27, 36), math.pi + rng:NextNumber(-0.9, 0.9))
		local cf = CFrame.new(p) * CFrame.Angles(0, facing(p) + rng:NextNumber(-0.3, 0.3), rad(rng:NextNumber(-8, 8)))
		local STONE = rgb(86, 90, 106)
		part("Graves", V(2.2, 0.5, 1.2), cf * CFrame.new(0, 0.25, 0), rgb(66, 70, 86), {Studs = true})
		part("Graves", V(1.8, 2.6, 0.5), cf * CFrame.new(0, 1.8, 0), STONE, {Studs = true})
		if i % 2 == 0 then
			part("Graves", V(1.2, 0.5, 0.5), cf * CFrame.new(0, 3.3, 0), STONE)
		else
			part("Graves", V(0.5, 1.6, 0.5), cf * CFrame.new(0, 3.9, 0), STONE)
			part("Graves", V(1.5, 0.5, 0.5), cf * CFrame.new(0, 3.8, 0), STONE)
		end
		part("Graves", V(0.8, 0.12, 0.06), cf * CFrame.new(0, 2.1, -0.27), rgb(40, 42, 54))
		part("Graves", V(0.5, 0.12, 0.06), cf * CFrame.new(0, 1.7, -0.27), rgb(40, 42, 54))
	end

	---------------- brume au ras du sol
	for i = 1, 12 do
		local p = polar(rng:NextNumber(10, 60), rng:NextNumber(0, 6.283))
		local holder = part("Mist", V(34, 1, 34), p + V(0, 1.4, 0), rgb(0, 0, 0), {Transparency = 1, Name = "Mist"})
		local e = Instance.new("ParticleEmitter")
		e.Texture = "rbxasset://textures/particles/smoke_main.dds"
		e.Color = ColorSequence.new(rgb(120, 140, 200), rgb(150, 110, 200))
		e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 9), NumberSequenceKeypoint.new(1, 16)})
		e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.25, 0.9), NumberSequenceKeypoint.new(0.75, 0.93), NumberSequenceKeypoint.new(1, 1)})
		e.Lifetime = NumberRange.new(8, 12)
		e.Rate = 1.6
		e.Speed = NumberRange.new(0.5, 1.4)
		e.SpreadAngle = Vector2.new(180, 180)
		e.Rotation = NumberRange.new(0, 360)
		e.RotSpeed = NumberRange.new(-6, 6)
		e.LightEmission, e.LightInfluence = 0.15, 0.8
		e.Parent = holder
	end

	---------------- chauves-souris (animées par le client) et feux follets
	for i = 1, 9 do
		local bat = Instance.new("Model")
		bat.Name = "Bat"
		bat.Parent = folder("Bats")
		local BLACK = rgb(10, 8, 14)
		local body = part(bat, V(0.6, 0.6, 0.9), V(0, 0, 0), BLACK, {Name = "Body", Shadow = false})
		part(bat, V(1.7, 0.1, 1.0), CFrame.new(1.1, 0, 0), BLACK, {Name = "WingR", Shadow = false})
		part(bat, V(1.7, 0.1, 1.0), CFrame.new(-1.1, 0, 0), BLACK, {Name = "WingL", Shadow = false})
		bat.PrimaryPart = body
		bat:SetAttribute("Radius", rng:NextNumber(34, 80))
		bat:SetAttribute("Height", rng:NextNumber(20, 40))
		bat:SetAttribute("Speed", rng:NextNumber(0.25, 0.6) * (i % 2 == 0 and 1 or -1))
		bat:SetAttribute("Phase", rng:NextNumber(0, 6.283))
		bat:PivotTo(CFrame.new(polar(bat:GetAttribute("Radius"), bat:GetAttribute("Phase")) + V(0, bat:GetAttribute("Height"), 0)))
	end
	for i = 1, 10 do
		local p = polar(rng:NextNumber(34, 58), rng:NextNumber(0, 6.283)) + V(0, rng:NextNumber(2, 6), 0)
		local color = i % 2 == 0 and rgb(170, 100, 255) or rgb(110, 230, 255)
		local wisp = part("Wisps", V(0.5, 0.5, 0.5), CFrame.new(p) * CFrame.Angles(0.7, 0.7, 0), color, {Neon = true, Name = "Wisp"})
		light(wisp, color, 12, 1.2, "WispLight")
	end
	-- silhouettes inquiétantes entre les troncs, deux points rouges à la place des yeux
	for i = 1, 4 do
		local a = ({2.2, 3.6, 4.6, 1.2})[i]
		local p = polar(rng:NextNumber(52, 66), a)
		local cf = CFrame.new(p) * CFrame.Angles(0, facing(p), 0)
		part("Watchers", V(2.4, 5.2, 1.4), cf * CFrame.new(0, 2.6, 0), rgb(6, 6, 10), {Shadow = false})
		part("Watchers", V(1.8, 1.8, 1.6), cf * CFrame.new(0, 6.0, 0), rgb(6, 6, 10), {Shadow = false})
		for _, e in {0.36, -0.36} do part("Watchers", V(0.24, 0.16, 0.1), cf * CFrame.new(e, 6.1, -0.82), rgb(255, 40, 40), {Neon = true, Name = "Eye"}) end
	end

	set.Parent = film
	local count = 0
	for _, d in set:GetDescendants() do if d:IsA("BasePart") then count += 1 end end
	return set, count, treeCount
end

return M
