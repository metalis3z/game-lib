-- Outil d'édition (pas utilisé en jeu) : thème Halloween de la carte.
-- Dans la barre de commande de Studio :
--   require(game.ServerStorage.HalloweenMapTheme).Build()   pose tout le décor dans Workspace.HalloweenTheme
--   require(game.ServerStorage.HalloweenMapTheme).Remove()  l'enlève et rend leurs couleurs aux murs, au sol et aux lampadaires
-- Le ciel et l'éclairage d'origine sont gardés dans ServerStorage.LightingBackup_PreHalloween.
local M = {}
local B = require(script.Parent:WaitForChild("HalloweenDecorBuilder"))
local rgb = Color3.fromRGB
local FOLDER = "HalloweenTheme"
local WALL_GREEN = rgb(91, 154, 76)     -- couleur d'origine des murs de la zone sûre
local WALL_COLOR = rgb(62, 44, 92)      -- pierre violette
local FLOOR_COLOR = rgb(78, 132, 90)    -- herbe plus sombre
local IRON, IRON2, BAND = rgb(46, 40, 56), rgb(62, 54, 74), rgb(128, 64, 190)
local ORANGE, ORANGE2, ORANGE3, GLOW = rgb(255, 128, 18), rgb(215, 85, 8), rgb(170, 60, 6), rgb(255, 190, 70)

local function folder(name)
	local root = workspace:FindFirstChild(FOLDER)
	if not root then
		root = Instance.new("Folder")
		root.Name = FOLDER
		root.Parent = workspace
	end
	local f = root:FindFirstChild(name)
	if f then f:Destroy() end
	f = Instance.new("Folder")
	f.Name = name
	f.Parent = root
	return f
end

-- garde la valeur d'origine d'une propriété dans un attribut, pour pouvoir la rendre plus tard
local function remember(inst, prop, value)
	if inst:GetAttribute("HW_" .. prop) == nil then inst:SetAttribute("HW_" .. prop, inst[prop]) end
	inst[prop] = value
end

local function wedge(model, size, cf, color, neon)
	local p = Instance.new("WedgePart")
	p.Name = neon and "Glow" or "Stud"
	p.Size, p.CFrame, p.Color = size, cf, color
	p.Material = neon and Enum.Material.Neon or Enum.Material.Plastic
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	p.Anchored = true
	p.CanCollide, p.CanQuery, p.CanTouch = false, false, false
	p.CastShadow = not neon
	p.Parent = model
	return p
end

-- petite citrouille-lanterne en quelques blocs (cf = son centre, visage vers +Z), avec sa lumière
local function miniPumpkin(model, cf, s, range)
	B.part(model, Vector3.new(s, 0.8 * s, s), cf, ORANGE)
	B.part(model, Vector3.new(1.24 * s, 0.58 * s, 0.7 * s), cf, ORANGE2, {Studs = false})
	B.part(model, Vector3.new(0.7 * s, 0.58 * s, 1.24 * s), cf, ORANGE2, {Studs = false})
	B.part(model, Vector3.new(0.66 * s, 0.12 * s, 0.66 * s), cf * CFrame.new(0, 0.45 * s, 0), ORANGE3)
	B.part(model, Vector3.new(0.16 * s, 0.3 * s, 0.16 * s), cf * CFrame.new(0.04 * s, 0.62 * s, 0) * CFrame.Angles(0, 0, -0.25), rgb(60, 110, 40), {Studs = false})
	for _, e in {1, -1} do -- yeux en triangle
		wedge(model, Vector3.new(0.06 * s, 0.22 * s, 0.28 * s), cf * CFrame.fromMatrix(Vector3.new(e * 0.24 * s, 0.1 * s, 0.63 * s), Vector3.new(0, 0, -e), Vector3.new(0, 1, 0), Vector3.new(e, 0, 0)), GLOW, true)
	end
	B.part(model, Vector3.new(0.56 * s, 0.11 * s, 0.06 * s), cf * CFrame.new(0, -0.17 * s, 0.63 * s), GLOW, {Neon = true, Studs = false})
	B.part(model, Vector3.new(0.1 * s, 0.09 * s, 0.07 * s), cf * CFrame.new(0.13 * s, -0.12 * s, 0.635 * s), ORANGE, {Studs = false})
	B.part(model, Vector3.new(0.1 * s, 0.09 * s, 0.07 * s), cf * CFrame.new(-0.13 * s, -0.22 * s, 0.635 * s), ORANGE, {Studs = false})
	local holder = B.part(model, Vector3.new(0.2, 0.2, 0.2), cf, GLOW, {Transparency = 1, Name = "Glow"})
	local light = Instance.new("PointLight")
	light.Name = "Flicker"
	light.Color, light.Range, light.Brightness, light.Shadows = rgb(255, 150, 50), range or 24, 1.7, false
	light.Parent = holder
end

-- lampadaire d'Halloween : poteau de fer, bagues violettes, citrouille-lanterne au bout de la potence (qui part vers +Z)
local function lampPost(parent, pos, yaw)
	local model = Instance.new("Model")
	model.Name = "HalloweenLamp"
	local cf = CFrame.new(pos) * CFrame.Angles(0, yaw, 0)
	B.part(model, Vector3.new(2.2, 0.8, 2.2), cf * CFrame.new(0, 0.4, 0), IRON)
	B.part(model, Vector3.new(1.5, 0.5, 1.5), cf * CFrame.new(0, 1.05, 0), IRON2)
	B.part(model, Vector3.new(0.7, 9.6, 0.7), cf * CFrame.new(0, 6.1, 0), IRON2, {Studs = false})
	B.part(model, Vector3.new(0.95, 0.4, 0.95), cf * CFrame.new(0, 3.4, 0), BAND, {Studs = false})
	B.part(model, Vector3.new(0.95, 0.4, 0.95), cf * CFrame.new(0, 7.2, 0), BAND, {Studs = false})
	B.part(model, Vector3.new(1.1, 0.5, 1.1), cf * CFrame.new(0, 11.1, 0), IRON)
	for _, e in {1, -1} do -- pointe du sommet
		wedge(model, Vector3.new(0.5, 1.3, 0.3), cf * CFrame.new(0, 12.0, 0.15 * e) * CFrame.Angles(0, e == 1 and math.pi or 0, 0), BAND)
	end
	B.part(model, Vector3.new(0.5, 0.5, 3.4), cf * CFrame.new(0, 10.4, 1.6), IRON, {Studs = false})
	B.part(model, Vector3.new(0.35, 0.35, 2.4), cf * CFrame.new(0, 9.5, 0.95) * CFrame.Angles(math.rad(-42), 0, 0), IRON2, {Studs = false})
	B.part(model, Vector3.new(0.2, 0.7, 0.2), cf * CFrame.new(0, 9.85, 3.0), IRON2, {Studs = false})
	B.part(model, Vector3.new(0.7, 0.16, 0.7), cf * CFrame.new(0, 9.45, 3.0), IRON, {Studs = false})
	miniPumpkin(model, cf * CFrame.new(0, 8.55, 3.0), 1.7, 30)
	model.Parent = parent
	return model
end
M.LampPost = lampPost

local function put(model, pos, yaw, parent)
	model:PivotTo(CFrame.new(pos) * CFrame.Angles(0, yaw or 0, 0))
	model.Parent = parent
	return model
end

---------------------------------------------------------------- 1. couleurs des murs et du sol
function M.Colors()
	for _, c in workspace:GetChildren() do
		if c:IsA("BasePart") and c.Name == "Wall" and (c:GetAttribute("HW_Color") or (math.abs(c.Color.R - WALL_GREEN.R) < 0.02 and math.abs(c.Color.G - WALL_GREEN.G) < 0.02)) then
			remember(c, "Color", WALL_COLOR)
		end
	end
	local floor = workspace:FindFirstChild("safe zone")
	if floor then remember(floor, "Color", FLOOR_COLOR) end
end

---------------------------------------------------------------- 2. lampadaires existants : fer sombre, citrouille à la place de la lanterne
function M.Lamps()
	local out = folder("Lamps")
	local posts = {}
	local function collect(container)
		for _, m in container and container:GetChildren() or {} do
			if m:IsA("Model") and m.Name == "LampPost" then table.insert(posts, m) end
		end
	end
	collect(workspace:FindFirstChild("SafeZoneDecor"))
	collect(workspace:FindFirstChild("MapDecor") and workspace.MapDecor:FindFirstChild("EntranceLamps"))
	for _, post in posts do
		local neon, pole
		for _, p in post:GetChildren() do
			if p:IsA("BasePart") then
				if p.Material == Enum.Material.Neon or p:GetAttribute("HW_Lantern") then neon = p end
				if p.Size.Y > 6 then pole = p end
			end
		end
		if neon and pole then
			neon:SetAttribute("HW_Lantern", true)
			for _, p in post:GetChildren() do
				if p:IsA("BasePart") then
					local flat = Vector3.new(p.Position.X - neon.Position.X, 0, p.Position.Z - neon.Position.Z).Magnitude
					if p == neon or (flat < 0.3 and p.Size.Y < 0.3) then
						remember(p, "Transparency", 1) -- la lanterne d'origine et ses deux plateaux disparaissent
					else
						remember(p, "Color", p.Size.Y > 6 and IRON2 or IRON)
					end
				end
			end
			local light = neon:FindFirstChildOfClass("PointLight")
			if light then remember(light, "Enabled", false) end
			local dir = Vector3.new(neon.Position.X - pole.Position.X, 0, neon.Position.Z - pole.Position.Z)
			local yaw = dir.Magnitude > 0.1 and math.atan2(dir.X, dir.Z) or 0
			local model = Instance.new("Model")
			model.Name = "LampPumpkin"
			miniPumpkin(model, CFrame.new(neon.Position - Vector3.new(0, 0.15, 0)) * CFrame.Angles(0, yaw, 0), 1.5, 26)
			model.Parent = out
		end
	end
	return #posts
end

---------------------------------------------------------------- 3. bases : citrouilles aux quatre coins, bougies et bonbons le long des barrières
function M.Bases()
	local out = folder("Bases")
	local bases = workspace:FindFirstChild("all base")
	local count = 0
	for index, base in bases and bases:GetChildren() or {} do
		local floor = base:FindFirstChild("Floor")
		if not floor then continue end
		local c, h = floor.Position, floor.Size.X / 2 + 3.4
		local y = floor.Position.Y + floor.Size.Y / 2
		local seed = index * 17
		local front = math.rad(90) -- les visages regardent l'allée (+X)
		local corners = {{1, 1, "Jack", true}, {1, -1, "Scary", false}, {-1, 1, "Cute", false}, {-1, -1, "Jack", false}}
		for i, k in corners do
			put(B.Pumpkin({Radius = k[1] == 1 and 2.5 or 2.1, Face = k[3], Hat = k[4] and (index % 2 == 1), Seed = seed + i, Light = true}), Vector3.new(c.X + k[1] * h, y, c.Z + k[2] * h), front + k[2] * math.rad(18), out)
		end
		-- côtés gauche et droit (le long de Z constant)
		for _, side in {1, -1} do
			local z = c.Z + side * (h + 0.4)
			put(B.Candles({Seed = seed + 20 + side, Count = 3}), Vector3.new(c.X + 21, y, z), 0, out)
			put(B.Pumpkin({Radius = 1.3, Face = side == 1 and "Cute" or "Jack", Seed = seed + 30 + side, Light = true}), Vector3.new(c.X + 6, y, z), front + side * math.rad(35), out)
			put(B.CandyCorn({Size = 0.9}), Vector3.new(c.X - 8, y, z), side * 0.6, out)
			put(B.Candles({Seed = seed + 40 + side, Count = 4}), Vector3.new(c.X - 22, y, z), 1, out)
		end
		-- fond de la base
		put(B.Grave({Seed = seed + 50, Size = 0.9}), Vector3.new(c.X - h - 0.6, y, c.Z + 14), math.rad(90), out)
		put(B.Candles({Seed = seed + 51, Count = 3}), Vector3.new(c.X - h - 0.4, y, c.Z), 2, out)
		put(B.Grave({Seed = seed + 52, Size = 0.8}), Vector3.new(c.X - h - 0.6, y, c.Z - 15), math.rad(80), out)
		-- devant, près des coins seulement (le portail reste libre)
		put(B.CandyCorn({Size = 1}), Vector3.new(c.X + h + 0.6, y, c.Z + 24), 0.4, out)
		put(B.CandyCorn({Size = 0.8}), Vector3.new(c.X + h + 0.6, y, c.Z - 25), -0.5, out)
		count += 1
		task.wait()
	end
	return count
end

---------------------------------------------------------------- 4. contour de la zone sûre : arbres morts, tombes, grosses citrouilles, chaudrons
function M.Perimeter()
	local out = folder("Perimeter")
	local zone = workspace:FindFirstChild("safe zone")
	if not zone then return 0 end
	local y = zone.Position.Y + zone.Size.Y / 2
	local x0, x1 = zone.Position.X - zone.Size.X / 2, zone.Position.X + zone.Size.X / 2
	local z0, z1 = zone.Position.Z - zone.Size.Z / 2, zone.Position.Z + zone.Size.Z / 2
	local INSET, STEP = 8, 24
	local spots = {} -- {position, angle pour regarder vers l'intérieur}
	for z = z0 + 14, z1 - 10, STEP do table.insert(spots, {Vector3.new(x0 + INSET, y, z), math.rad(90)}) end      -- mur -X
	for x = x0 + 26, x1 - 12, STEP do table.insert(spots, {Vector3.new(x, y, z1 - INSET), math.rad(180)}) end   -- mur +Z
	for x = x0 + 18, x1 - 12, STEP do table.insert(spots, {Vector3.new(x, y, z0 + INSET), 0}) end               -- mur -Z
	for z = z0 + 24, z1 - 14, STEP do                                                                           -- mur +X (ouvert sur les zones d'oeufs)
		if z < -276 or z > -60 then table.insert(spots, {Vector3.new(x1 - INSET, y, z), math.rad(-90)}) end
	end
	local params = OverlapParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	local ignore = {zone, workspace:FindFirstChild(FOLDER)}
	for _, c in workspace:GetChildren() do if c:IsA("BasePart") and (c.Name == "Wall" or c.Name == "Part") then table.insert(ignore, c) end end
	params.FilterDescendantsInstances = ignore
	local kinds = {"Tree", "Graves", "Pumpkin", "Cauldron", "Graves", "Pumpkin", "Tree", "Candy"}
	local placed, k = 0, 0
	for i, spot in spots do
		local pos, yaw = spot[1], spot[2]
		-- si la place est prise par un décor existant, on essaie un peu plus loin le long du mur
		local along = (CFrame.new(pos) * CFrame.Angles(0, yaw, 0)).RightVector
		local free = false
		for _, shift in {0, 7, -7} do
			local try = pos + along * shift
			if #workspace:GetPartBoundsInBox(CFrame.new(try + Vector3.new(0, 8, 0)), Vector3.new(9, 14, 9), params) == 0 then pos, free = try, true break end
		end
		if not free then continue end
		k += 1
		local kind = kinds[(k - 1) % #kinds + 1]
		local cf = CFrame.new(pos) * CFrame.Angles(0, yaw, 0)
		local function at(dx, dz) return (cf * CFrame.new(dx, 0, dz)).Position end
		if kind == "Tree" then
			put(B.DeadTree({Seed = 100 + i, Size = 1 + (i % 3) * 0.12}), pos, yaw + i, out)
			put(B.Pumpkin({Radius = 1.4, Face = "Jack", Seed = 200 + i, Light = true}), at(4.2, 3), yaw + 0.3, out)
		elseif kind == "Graves" then
			put(B.Grave({Seed = 300 + i, Size = 1.1}), at(-3.2, -1), yaw + 0.15, out)
			put(B.Grave({Seed = 310 + i, Size = 0.9}), at(0.4, 0.6), yaw - 0.2, out)
			put(B.Grave({Seed = 320 + i, Size = 1}), at(3.6, -0.6), yaw + 0.3, out)
			put(B.Candles({Seed = 330 + i, Count = 4}), at(1.6, 3.4), yaw, out)
		elseif kind == "Pumpkin" then
			put(B.Pumpkin({Radius = 3.4 + (i % 3) * 0.4, Face = i % 2 == 0 and "Scary" or "Jack", Hat = i % 4 == 0, Seed = 400 + i, Light = true}), pos, yaw, out)
			put(B.Pumpkin({Radius = 1.5, Face = "Cute", Seed = 410 + i, Light = true}), at(5.2, 2.2), yaw - 0.4, out)
		elseif kind == "Cauldron" then
			put(B.Cauldron({Size = 1}), pos, yaw, out)
			put(B.Candles({Seed = 500 + i, Count = 3}), at(-4.6, 1.5), yaw, out)
			put(B.CandyCorn({Size = 1}), at(4.4, 2), yaw + 0.5, out)
		else
			put(B.CandyCorn({Size = 1.6}), at(-2, 0), yaw + 0.3, out)
			put(B.CandyCorn({Size = 1.1}), at(1.6, 1.4), yaw - 0.4, out)
			put(B.Pumpkin({Radius = 1.8, Face = "Jack", Seed = 600 + i, Light = true}), at(3.8, -0.6), yaw, out)
		end
		placed += 1
		task.wait()
	end
	return placed
end

---------------------------------------------------------------- 5. lampadaires d'Halloween : sortie de la zone sûre et coins des zones d'oeufs
function M.ZoneLamps()
	local out = folder("ZoneLamps")
	local count = 0
	for _, zone in workspace:GetChildren() do
		local lower = string.lower(zone.Name)
		if zone:IsA("BasePart") and string.find(lower, "egg zone", 1, true) and not string.find(lower, "halloween", 1, true) then
			local y = zone.Position.Y + zone.Size.Y / 2
			local hx, hz = zone.Size.X / 2 - 4, zone.Size.Z / 2 - 4
			for _, k in {{1, 1}, {1, -1}, {-1, 1}, {-1, -1}, {1, 0}, {-1, 0}} do
				local pos = Vector3.new(zone.Position.X + k[1] * hx, y, zone.Position.Z + k[2] * hz)
				local inward = Vector3.new(-k[1], 0, -k[2] * 0.6)
				lampPost(out, pos, math.atan2(inward.X, inward.Z))
				count += 1
			end
			task.wait()
		end
	end
	return count
end

---------------------------------------------------------------- 6. brume violette au pied des murs
function M.Mist()
	local out = folder("Mist")
	local zone = workspace:FindFirstChild("safe zone")
	if not zone then return 0 end
	local y = zone.Position.Y + zone.Size.Y / 2
	local hx, hz = zone.Size.X / 2 - 16, zone.Size.Z / 2 - 16
	local count = 0
	local function emitter(pos, size)
		local p = Instance.new("Part")
		p.Name = "Mist"
		p.Size, p.CFrame = size, CFrame.new(pos)
		p.Transparency = 1
		p.Anchored = true
		p.CanCollide, p.CanQuery, p.CanTouch = false, false, false
		local e = Instance.new("ParticleEmitter")
		e.Texture = "rbxasset://textures/particles/smoke_main.dds"
		e.Color = ColorSequence.new(rgb(150, 90, 200), rgb(255, 140, 70))
		e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 7), NumberSequenceKeypoint.new(1, 13)})
		e.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.25, 0.86), NumberSequenceKeypoint.new(0.75, 0.9), NumberSequenceKeypoint.new(1, 1)})
		e.Lifetime = NumberRange.new(7, 11)
		e.Rate = 2.5
		e.Speed = NumberRange.new(0.6, 1.6)
		e.SpreadAngle = Vector2.new(180, 180)
		e.Rotation = NumberRange.new(0, 360)
		e.RotSpeed = NumberRange.new(-8, 8)
		e.Acceleration = Vector3.new(0, 0.05, 0)
		e.LightEmission = 0.25
		e.LightInfluence = 0.6
		e.Parent = p
		p.Parent = out
		count += 1
	end
	for t = -1, 1, 0.5 do
		emitter(Vector3.new(zone.Position.X - hx, y + 2, zone.Position.Z + t * hz), Vector3.new(20, 1, 60))
		emitter(Vector3.new(zone.Position.X + t * hx, y + 2, zone.Position.Z + hz), Vector3.new(60, 1, 20))
		emitter(Vector3.new(zone.Position.X + t * hx, y + 2, zone.Position.Z - hz), Vector3.new(60, 1, 20))
	end
	return count
end

---------------------------------------------------------------- 7. arbres et buissons en couleurs d'automne
local AUTUMN = {{rgb(214, 96, 20), rgb(240, 132, 30), rgb(250, 168, 50)}, {rgb(170, 48, 26), rgb(206, 72, 30), rgb(232, 108, 40)}, {rgb(196, 140, 24), rgb(226, 172, 40), rgb(246, 200, 70)}, {rgb(110, 52, 120), rgb(140, 70, 150), rgb(170, 96, 180)}}
function M.Trees()
	local decor = workspace:FindFirstChild("SafeZoneDecor")
	local count = 0
	for index, m in decor and decor:GetChildren() or {} do
		if m.Name == "Tree" or m.Name == "Bush" then
			local pal = m.Name == "Tree" and AUTUMN[index % 3 + 1] or AUTUMN[4]
			local shade = 0
			for _, p in m:GetDescendants() do
				if p:IsA("BasePart") then
					if p.Name == "Leaves" or p.Name == "Bush" then
						shade += 1
						remember(p, "Color", pal[(shade - 1) % 3 + 1])
					elseif p.Name == "Apple" or p.Name == "Berry" then
						remember(p, "Color", ORANGE)
					elseif p.Name == "Trunk" or p.Name == "Root" then
						remember(p, "Color", rgb(58, 42, 38))
					end
				end
			end
			count += 1
		end
	end
	return count
end

---------------------------------------------------------------- 8. lanternes-citrouilles accrochées aux murs de la zone sûre, reliées par une guirlande
function M.WallLanterns()
	local out = folder("WallLanterns")
	local zone = workspace:FindFirstChild("safe zone")
	if not zone then return 0 end
	local y = zone.Position.Y + zone.Size.Y / 2 + 15
	local x0, x1 = zone.Position.X - zone.Size.X / 2, zone.Position.X + zone.Size.X / 2
	local z0, z1 = zone.Position.Z - zone.Size.Z / 2, zone.Position.Z + zone.Size.Z / 2
	local STEP = 26
	local runs = { -- {départ, arrivée, direction vers l'intérieur}
		{Vector3.new(x0, y, z0 + 12), Vector3.new(x0, y, z1 - 12), Vector3.new(1, 0, 0)},
		{Vector3.new(x0 + 12, y, z1), Vector3.new(x1 - 12, y, z1), Vector3.new(0, 0, -1)},
		{Vector3.new(x0 + 12, y, z0), Vector3.new(x1 - 12, y, z0), Vector3.new(0, 0, 1)},
	}
	local count = 0
	for _, run in runs do
		local a, b, inward = run[1], run[2], run[3]
		local length = (b - a).Magnitude
		local n = math.floor(length / STEP)
		local yaw = math.atan2(inward.X, inward.Z)
		local previous
		for i = 0, n do
			local wallPoint = a:Lerp(b, i / n)
			local model = Instance.new("Model")
			model.Name = "WallLantern"
			local cf = CFrame.new(wallPoint) * CFrame.Angles(0, yaw, 0)
			B.part(model, Vector3.new(1.6, 2.2, 0.5), cf * CFrame.new(0, 0, 0.25), IRON)
			B.part(model, Vector3.new(0.5, 0.5, 3.2), cf * CFrame.new(0, 0.6, 1.6), IRON2, {Studs = false})
			B.part(model, Vector3.new(0.35, 0.35, 2.4), cf * CFrame.new(0, -0.3, 1.0) * CFrame.Angles(math.rad(-40), 0, 0), IRON, {Studs = false})
			B.part(model, Vector3.new(0.2, 1.5, 0.2), cf * CFrame.new(0, -0.35, 2.9), IRON2, {Studs = false})
			miniPumpkin(model, cf * CFrame.new(0, -2.3, 2.9), 2.2, 30)
			if i % 2 == 1 then -- une lumière sur deux, pour ne pas en mettre trop
				local light = model:FindFirstChild("Flicker", true)
				if light then light:Destroy() end
			end
			model.Parent = out
			count += 1
			-- guirlande : fil qui pend entre deux lanternes, avec des fanions orange et violets
			local hook = (cf * CFrame.new(0, 0.9, 0.5)).Position
			if previous then
				local garland = Instance.new("Model")
				garland.Name = "Garland"
				local SEG = 6
				local last = previous
				for s = 1, SEG do
					local t = s / SEG
					local point = previous:Lerp(hook, t) - Vector3.new(0, math.sin(t * math.pi) * 3.2, 0)
					local mid = (last + point) / 2
					B.part(garland, Vector3.new(0.18, 0.18, (point - last).Magnitude + 0.1), CFrame.lookAt(mid, point), IRON, {Studs = false})
					if s < SEG then
						-- fanion : deux coins dos à dos, pointe vers le bas
						local base = CFrame.lookAt(point, point + (hook - previous).Unit) * CFrame.new(0, -0.8, 0) * CFrame.Angles(math.pi, 0, 0)
						local color = s % 2 == 0 and ORANGE or BAND
						wedge(garland, Vector3.new(0.12, 1.5, 0.7), base * CFrame.new(0, 0, -0.35), color)
						wedge(garland, Vector3.new(0.12, 1.5, 0.7), base * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, 0, -0.35), color)
					end
					last = point
				end
				garland.Parent = out
			end
			previous = hook
		end
		task.wait()
	end
	return count
end

---------------------------------------------------------------- 9. boutiques : auvent orange et noir, bois sombre, toile d'araignée, chauves-souris, citrouilles, fanions
-- Les deux stands ont la même forme : les positions sont écrites pour un stand dont le centre (modèle Stand) est à z = 0,
-- comptoir vers -X (côté joueurs), puis décalées jusqu'à chaque boutique.
local SHOP_COLORS = {
	["172,81,143"] = rgb(235, 110, 20), ["237,234,234"] = rgb(38, 28, 50),                                   -- rayures de l'auvent
	["132,70,39"] = rgb(64, 44, 52), ["95,56,31"] = rgb(44, 30, 38), ["143,82,47"] = rgb(54, 38, 46), ["120,82,46"] = rgb(58, 40, 48), -- bois
}
local function colorKey(c) return string.format("%d,%d,%d", math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5)) end

local function bat(model, cf, s)
	local BLACK = rgb(20, 16, 26)
	B.part(model, Vector3.new(0.4, 0.5, 0.35) * s, cf, BLACK, {Studs = false})
	B.part(model, Vector3.new(0.12, 0.3, 0.1) * s, cf * CFrame.new(0.13 * s, 0.36 * s, 0), BLACK, {Studs = false})
	B.part(model, Vector3.new(0.12, 0.3, 0.1) * s, cf * CFrame.new(-0.13 * s, 0.36 * s, 0), BLACK, {Studs = false})
	for _, e in {1, -1} do -- ailes : deux coins de chaque côté
		local wing = cf * CFrame.new(0, 0.05 * s, e * 0.55 * s) * CFrame.Angles(e * math.rad(-18), 0, 0)
		wedge(model, Vector3.new(0.1, 0.5, 0.8) * s, wing * CFrame.Angles(0, e == 1 and math.pi or 0, 0), BLACK)
		wedge(model, Vector3.new(0.1, 0.35, 0.7) * s, wing * CFrame.new(0, -0.05 * s, e * 0.7 * s) * CFrame.Angles(math.pi, e == 1 and math.pi or 0, 0), BLACK)
	end
end

local function witchHat(model, cf, s, weldTo)
	local HAT, BANDC, GOLD = rgb(36, 26, 52), rgb(240, 112, 15), rgb(255, 200, 60)
	local made = {}
	local function p(size, c, color, studs) table.insert(made, B.part(model, size * s, cf * c, color, {Studs = studs})) end
	p(Vector3.new(2.6, 0.18, 2.6), CFrame.new(), HAT, true)
	p(Vector3.new(1.6, 0.4, 1.6), CFrame.new(0, 0.28, 0), BANDC, false)
	p(Vector3.new(0.5, 0.42, 0.12), CFrame.new(0, 0.28, 0.8), GOLD, false)
	local c = CFrame.new(0, 0.45, 0)
	for i, w in {1.45, 1.1, 0.75, 0.42} do
		p(Vector3.new(w, 0.62, w), c * CFrame.new(0, 0.3, 0), i % 2 == 1 and HAT or rgb(48, 34, 68), false)
		c = c * CFrame.new(0, 0.56, 0) * CFrame.Angles(math.rad(-10 - i * 5), 0, 0)
	end
	if weldTo then
		for _, part in made do
			part.Anchored, part.Massless = false, true
			local w = Instance.new("WeldConstraint")
			w.Part0, w.Part1 = weldTo, part
			w.Parent = part
		end
	end
end
M.WitchHat = witchHat

function M.Shops()
	local out = folder("Shops")
	local count = 0
	for index, name in {"UPGRADE shop", "dragon shop", "egg shop"} do
		local shop = workspace:FindFirstChild(name)
		local stand = shop and shop:FindFirstChild("Stand")
		if not stand then continue end
		local dz = stand:GetBoundingBox().Position.Z
		local function at(x, y, z) return Vector3.new(x, y, z + dz) end
		local FACE = math.rad(-90) -- regarde les joueurs (-X)
		-- couleurs du stand et de son décor
		for _, p in shop:GetDescendants() do
			if p:IsA("BasePart") and (p:IsDescendantOf(stand) or p.Name == "Decor") then
				local to = SHOP_COLORS[p:GetAttribute("HW_Color") and colorKey(p:GetAttribute("HW_Color")) or colorKey(p.Color)]
				if to then remember(p, "Color", to) end
				if p.Material == Enum.Material.Neon then remember(p, "Color", rgb(255, 150, 40)) end -- lanternes
			end
			if p:IsA("PointLight") and p:IsDescendantOf(shop) then remember(p, "Color", rgb(255, 140, 50)) end
		end
		local model = Instance.new("Model")
		model.Name = name .. " decor"
		-- fanions sous le bord de l'auvent
		for i = 0, 11 do
			local base = CFrame.new(at(10.72, 7.2, -5.6 + i * 1.0)) * CFrame.Angles(math.pi, 0, 0)
			local color = ({rgb(235, 110, 20), rgb(128, 64, 190), rgb(30, 22, 40)})[i % 3 + 1]
			wedge(model, Vector3.new(0.1, 0.9, 0.48), base * CFrame.new(0, 0, -0.24), color)
			wedge(model, Vector3.new(0.1, 0.9, 0.48), base * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, 0, -0.24), color)
		end
		-- toile d'araignée dans l'angle du poteau avant gauche (plan face aux joueurs)
		local WEB = rgb(236, 236, 246)
		local corner = CFrame.new(at(12.95, 7.75, -5.3))
		local rays = {0, 30, 60, 90}
		for _, a in rays do
			local dir = CFrame.Angles(math.rad(a), 0, 0) -- 0 = le long de l'auvent (+Z), 90 = vers le bas
			B.part(model, Vector3.new(0.07, 0.07, 3.0), corner * dir * CFrame.new(0, 0, 1.5), WEB, {Studs = false})
		end
		for _, r in {0.9, 1.7, 2.5} do
			for i = 1, #rays - 1 do
				local p0 = (corner * CFrame.Angles(math.rad(rays[i]), 0, 0) * CFrame.new(0, 0, r)).Position
				local p1 = (corner * CFrame.Angles(math.rad(rays[i + 1]), 0, 0) * CFrame.new(0, 0, r)).Position
				B.part(model, Vector3.new(0.06, 0.06, (p1 - p0).Magnitude), CFrame.lookAt((p0 + p1) / 2, p1), WEB, {Studs = false})
			end
		end
		-- araignée au bout de son fil, de l'autre côté
		B.part(model, Vector3.new(0.05, 1.9, 0.05), CFrame.new(at(12.6, 6.95, 4.6)), WEB, {Studs = false})
		B.part(model, Vector3.new(0.55, 0.45, 0.6), CFrame.new(at(12.6, 5.8, 4.6)), rgb(20, 16, 26), {Studs = false})
		B.part(model, Vector3.new(0.36, 0.32, 0.3), CFrame.new(at(12.3, 5.76, 4.6)), rgb(20, 16, 26), {Studs = false})
		for _, e in {1, -1} do
			B.part(model, Vector3.new(0.06, 0.08, 0.06), CFrame.new(at(12.12, 5.8, 4.6 + e * 0.08)), rgb(255, 40, 40), {Neon = true, Studs = false})
			for i = -1, 1 do B.part(model, Vector3.new(0.07, 0.07, 0.7), CFrame.new(at(12.6 + i * 0.18, 5.7, 4.6 + e * 0.55)) * CFrame.Angles(e * math.rad(35), i * math.rad(20), 0), rgb(20, 16, 26), {Studs = false}) end
		end
		-- chauves-souris sur l'enseigne et au-dessus
		bat(model, CFrame.new(at(11.7, 12.85, -2.6)) * CFrame.Angles(0, 0, math.rad(8)), 1.5)
		bat(model, CFrame.new(at(11.2, 13.9, 1.4)) * CFrame.Angles(math.rad(12), 0, math.rad(-10)), 1.2)
		bat(model, CFrame.new(at(11.0, 12.3, 5.9)) * CFrame.Angles(math.rad(-10), 0, math.rad(14)), 1.0)
		-- chapeau de sorcière posé sur le coin de l'enseigne
		witchHat(model, CFrame.new(at(11.95, 12.55, 3.6)) * CFrame.Angles(0, FACE, math.rad(-14)), 1.0)
		-- crâne et bougies sur le comptoir
		local BONE = rgb(240, 236, 220)
		B.part(model, Vector3.new(0.8, 0.7, 0.8), CFrame.new(at(13.1, 3.72, -4.3)), BONE)
		B.part(model, Vector3.new(0.55, 0.3, 0.6), CFrame.new(at(13.0, 3.5, -4.3)), rgb(214, 206, 184), {Studs = false})
		for _, e in {1, -1} do B.part(model, Vector3.new(0.06, 0.24, 0.22), CFrame.new(at(12.69, 3.78, -4.3 + e * 0.19)), rgb(16, 12, 20), {Studs = false}) end
		local candles = B.Candles({Seed = 70 + index, Count = 3})
		candles:ScaleTo(0.42)
		put(candles, at(13.2, 3.36, 4.2), 0, model)
		local small = B.Pumpkin({Radius = 0.65, Face = "Jack", Seed = 80 + index, Light = true})
		put(small, at(13.2, 3.36, 2.6), FACE, model)
		-- citrouilles et chaudron à gauche du stand
		put(B.Pumpkin({Radius = 1.9, Face = index % 2 == 0 and "Scary" or "Jack", Hat = true, Seed = 90 + index, Light = true}), at(10.4, 0, -9.6), FACE + 0.25, model)
		put(B.Pumpkin({Radius = 1.0, Face = "Cute", Seed = 95 + index, Light = true}), at(12.9, 0, -8.2), FACE - 0.3, model)
		local cauldron = B.Cauldron({Size = 1})
		cauldron:ScaleTo(0.5)
		put(cauldron, at(16.4, 0, -9.4), FACE, model)
		model.Parent = out
		-- le vendeur fermier porte un chapeau de sorcière
		local farmer = shop:FindFirstChild("FarmerNpc")
		local head = farmer and farmer:FindFirstChild("Head")
		if head then
			local hat = Instance.new("Model")
			hat.Name = "FarmerWitchHat"
			witchHat(hat, CFrame.new(head.Position + Vector3.new(0, 1.35, 0)) * CFrame.Angles(0, FACE, math.rad(6)), 0.95, head)
			hat.Parent = out
		end
		count += 1
		task.wait()
	end
	return count
end

function M.Build()
	M.Colors()
	M.Shops()
	return {Lamps = M.Lamps(), Bases = M.Bases(), Trees = M.Trees(), Perimeter = M.Perimeter(), ZoneLamps = M.ZoneLamps(), WallLanterns = M.WallLanterns(), Mist = M.Mist()}
end

-- enlève tout le décor et rend les couleurs d'origine
function M.Remove()
	local root = workspace:FindFirstChild(FOLDER)
	if root then root:Destroy() end
	for _, d in workspace:GetDescendants() do
		for name, value in d:GetAttributes() do
			if string.sub(name, 1, 3) == "HW_" then
				local prop = string.sub(name, 4)
				if prop ~= "Lantern" then pcall(function() d[prop] = value end) end
				d:SetAttribute(name, nil)
			end
		end
	end
end

return M
