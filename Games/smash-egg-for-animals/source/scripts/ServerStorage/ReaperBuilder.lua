-- Outil d'édition (pas utilisé en jeu) : construit THE REAPER, gardien de la zone Phantom, en blocs à studs (recette de Zorvex),
-- et sa version animal (Grim Reaper, le meilleur animal Phantom).
--   require(game.ServerStorage.ReaperBuilder)() -> rapport. Peut être relancé.
--   * ServerStorage.ZoneBosses.Reaper            : le gardien (ZoneBossServer le fait flotter et le déplace)
--   * ServerStorage.CustomPets.Reaper            : modèle animal (taille animal), relu par AnimalWiring (EggConfig.Pets.GrimReaper.Custom)
--   * ReplicatedStorage.EggSystem.Pets.GrimReaper : l'animal
-- Squelette : 11 segments (sous-modèles) avec une JointPart invisible et un Weld animé (attribut RP), comme Zorvex.
--   Body, Head, Robe, Cape, ArmR, ForeR, Scythe, ArmL, ForeL, Lantern, Souls. Animé par StarterPlayerScripts.ReaperClient.
-- Il flotte : le bas de sa robe est à 4 studs du sol, la racine à 12 (ZoneBossServer le tient à cette hauteur).
-- L'avant regarde vers +Z. Palette : robe noire et ardoise, liserés violets, os ivoire, néon cyan fantôme (yeux, lame, âmes).
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local CollectionService = game:GetService("CollectionService")
local V, C, A, rad = Vector3.new, CFrame.new, CFrame.Angles, math.rad
local rgb = Color3.fromRGB

local VOID = rgb(14, 12, 20)
local ROBE = rgb(32, 28, 42)
local ROBE2 = rgb(50, 44, 64)
local TRIM = rgb(92, 56, 148)
local METAL = rgb(66, 70, 86)
local STEEL = rgb(168, 176, 196)
local BONE = rgb(228, 222, 200)
local BONE2 = rgb(186, 178, 156)
local WOOD = rgb(44, 32, 40)
local SOUL = rgb(90, 255, 225)
local SOULV = rgb(175, 115, 255)

local ROOT_Y = 12
local HEIGHT = 28

local function emitter(parent, props)
	local e = Instance.new("ParticleEmitter")
	e.LightInfluence = 0
	for k, v in props do e[k] = v end
	e.Parent = parent
	return e
end
local function nseq(points)
	local keys = {}
	for _, p in points do table.insert(keys, NumberSequenceKeypoint.new(p[1], p[2])) end
	return NumberSequence.new(keys)
end
local function light(parent, name, color, range, brightness)
	local l = Instance.new("PointLight")
	l.Name = name
	l.Color, l.Range, l.Brightness, l.Shadows = color, range, brightness, false
	l.Parent = parent
	return l
end

local function build(name)
	local model = Instance.new("Model")
	model.Name = name
	local root = Instance.new("Part")
	root.Name = "Root"
	root.Size = V(2, 2, 2)
	root.Transparency = 1
	root.Anchored = true
	root.CanCollide, root.CanQuery, root.CanTouch = false, false, false
	root.CFrame = C(0, ROOT_Y, 0)
	root.Parent = model
	model.PrimaryPart = root

	local joints = 0
	local segs = {}
	local function segment(segName, parentPart, at)
		local m = Instance.new("Model")
		m.Name = segName
		m.Parent = model
		local jp = Instance.new("Part")
		jp.Name = "JointPart"
		jp.Size = V(0.5, 0.5, 0.5)
		jp.Transparency = 1
		jp.CanCollide, jp.CanQuery, jp.CanTouch, jp.Massless, jp.Anchored = false, false, false, true, false
		jp.CFrame = C(at)
		jp.Parent = m
		local w = Instance.new("Weld")
		w.Name = "Joint"
		w.Part0, w.Part1 = parentPart, jp
		w.C0 = parentPart.CFrame:ToObjectSpace(jp.CFrame)
		w:SetAttribute("RP", segName)
		w.Parent = jp
		joints += 1
		local seg = {Model = m, Joint = jp}
		-- une brique du segment, soudée (Weld à décalage écrit) à la JointPart
		function seg.add(pname, size, cf, color, o)
			o = o or {}
			local p = Instance.new(o.wedge and "WedgePart" or "Part")
			p.Name = pname
			p.Size, p.CFrame, p.Color = size, cf, color
			p.Material = o.neon and Enum.Material.Neon or (o.glass and Enum.Material.Glass or (o.mat or Enum.Material.Plastic))
			if p.Material == Enum.Material.Plastic and not o.smooth then pcall(function() p.MaterialVariant = "Studs" end) end
			p.Transparency = o.transparency or 0
			p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
			p.CanCollide, p.CanQuery, p.CanTouch, p.Massless, p.Anchored = false, false, false, true, false
			p.CastShadow = not (o.neon or o.glass or o.noShadow)
			p.Parent = m
			local weld = Instance.new("Weld")
			weld.Part0, weld.Part1 = jp, p
			weld.C0 = jp.CFrame:ToObjectSpace(p.CFrame)
			weld.Parent = p
			return p
		end
		segs[segName] = seg
		return seg
	end

	------------------------------------------------------------ TRONC (taille -> épaules), cage thoracique et cœur d'âme
	local body = segment("Body", root, V(0, 13, 0))
	body.add("Chest", V(7, 6, 4.6), C(0, 16.2, 0), ROBE)
	body.add("ChestOpen", V(3.4, 4.8, 0.3), C(0, 16.3, 2.3), VOID, {smooth = true})
	for i, y in {17.5, 16.5, 15.5} do
		body.add("Rib", V(2.9 - (i - 1) * 0.35, 0.42, 0.35), C(0, y, 2.5), BONE)
	end
	body.add("Sternum", V(0.55, 3.6, 0.4), C(0, 16.5, 2.55), BONE2)
	local core = body.add("SoulCore", V(1.25, 1.25, 0.4), C(0, 16.0, 2.42) * A(0, 0, rad(45)), SOUL, {neon = true})
	light(core, "Core", SOUL, 10, 1.6)
	for _, sx in {-1, 1} do
		body.add("Lapel", V(1.1, 6.0, 0.5), C(sx * 2.25, 16.2, 2.4) * A(0, 0, rad(-sx * 10)), ROBE2)
	end
	body.add("Belt", V(7.3, 0.9, 4.9), C(0, 13.5, 0), METAL)
	body.add("Buckle", V(1.7, 1.5, 0.4), C(0, 13.5, 2.55), TRIM)
	body.add("Hourglass", V(0.6, 1.0, 0.42), C(0, 13.5, 2.62), SOUL, {neon = true})
	for i = 0, 2 do -- chaîne pendue à la hanche, un petit crâne au bout
		body.add("Chain", V(0.35, 0.9, 0.7), C(3.35, 12.7 - i * 0.8, 1.3 - i * 0.3) * A(0, i % 2 == 0 and 0 or rad(90), 0), METAL)
	end
	body.add("Charm", V(0.85, 0.8, 0.85), C(3.35, 10.3, 0.4), BONE)
	-- haut col en pointes derrière la tête
	body.add("Collar", V(6.2, 2.6, 0.8), C(0, 19.6, -1.9) * A(rad(-15), 0, 0), TRIM)
	for _, sx in {-1, 1} do
		local cf = C(sx * 2.75, 20.2, -1.3) * A(0, 0, rad(-sx * 18))
		body.add("CollarSpike", V(0.9, 2.6, 0.9), cf, TRIM)
		body.add("CollarTip", V(0.5, 0.8, 0.5), cf * C(0, 1.6, 0), SOULV, {neon = true})
	end

	------------------------------------------------------------ TÊTE : capuche profonde, crâne, yeux cyan
	local head = segment("Head", body.Joint, V(0, 19.4, 0))
	head.add("Hood", V(6, 5.6, 5.6), C(0, 22.1, -0.3), ROBE)
	head.add("HoodCavity", V(4.2, 4.0, 0.3), C(0, 21.6, 2.45), VOID, {smooth = true})
	head.add("HoodRim", V(4.8, 0.6, 0.5), C(0, 23.8, 2.55), TRIM)
	for _, sx in {-1, 1} do head.add("HoodRim", V(0.6, 4.4, 0.5), C(sx * 2.4, 21.6, 2.55), TRIM) end
	head.add("HoodGlow", V(4.2, 0.2, 0.2), C(0, 23.45, 2.68), SOULV, {neon = true})
	head.add("HoodPeak", V(5.0, 1.2, 2.6), C(0, 24.9, 1.0) * A(rad(-16), 0, 0), ROBE2)
	head.add("HoodTail", V(2.2, 2.2, 2.2), C(0, 24.6, -2.6) * A(rad(40), 0, 0), ROBE)
	head.add("Skull", V(3.0, 2.5, 1.0), C(0, 22.0, 2.55), BONE)
	head.add("Jaw", V(2.4, 0.9, 0.9), C(0, 20.4, 2.5), BONE2)
	head.add("Teeth", V(1.9, 0.14, 0.2), C(0, 20.75, 2.97), VOID, {smooth = true})
	head.add("Nose", V(0.4, 0.5, 0.2), C(0, 21.45, 3.08) * A(0, 0, rad(45)), VOID, {smooth = true})
	for _, sx in {-1, 1} do
		local eye = head.add("Eye", V(0.85, 0.7, 0.2), C(sx * 0.72, 22.25, 3.08), SOUL, {neon = true})
		if sx == 1 then light(eye, "EyeGlow", SOUL, 10, 2) end
		head.add("Brow", V(1.3, 0.3, 0.3), C(sx * 0.75, 22.78, 3.1) * A(0, 0, rad(sx * 14)), BONE2)
	end

	------------------------------------------------------------ ROBE : trois étages qui s'évasent, bas déchiré, lueur et brume
	local robe = segment("Robe", root, V(0, 13, 0))
	robe.add("Robe", V(7.2, 2.4, 5.2), C(0, 11.8, 0), ROBE)
	robe.add("Robe", V(8.2, 2.4, 6.0), C(0, 9.4, -0.1), ROBE2)
	robe.add("Robe", V(9.0, 2.4, 6.8), C(0, 7.0, -0.2), ROBE)
	robe.add("RobePlate", V(1.6, 2.4, 0.3), C(0, 9.4, 2.95), TRIM)
	robe.add("RobePlate", V(1.8, 2.4, 0.3), C(0, 7.0, 3.3), TRIM)
	for _, at in {C(0, 9.4, 2.97), C(0, 7.0, 3.32)} do -- losanges d'âme (un losange lumineux, un cœur sombre)
		robe.add("Rune", V(1.0, 1.0, 0.32), at * A(0, 0, rad(45)), SOUL, {neon = true})
		robe.add("RuneCore", V(0.45, 0.45, 0.34), at * A(0, 0, rad(45)), VOID, {smooth = true})
	end
	local HEM = 5.8
	for i, t in {
		{-3.6, 2.6, 2.0, 0}, {-1.4, 3.0, 1.4, 0}, {1.5, 3.0, 2.4, 0}, {3.6, 2.6, 1.6, 0},
		{-4.3, -0.4, 2.2, 1}, {4.3, -0.4, 1.8, 1}, {-2.0, -3.3, 2.6, 0}, {2.2, -3.3, 2.0, 0},
	} do
		local size = t[4] == 1 and V(0.45, t[3], 1.9) or V(1.9, t[3], 0.45)
		robe.add("Tatter", size, C(t[1], HEM - t[3] / 2 + 0.1, t[2]) * A(rad((i % 3 - 1) * 6), 0, rad((i % 2 == 0 and 1 or -1) * 5)), i % 2 == 0 and ROBE2 or ROBE)
	end
	local hem = robe.add("HemGlow", V(8.6, 0.3, 6.4), C(0, 5.75, -0.2), SOUL, {neon = true, transparency = 0.35})
	light(hem, "HemLight", SOUL, 12, 0.9) -- (pas plus : sinon la robe noire vire au bleu)
	emitter(hem, {Name = "GhostMist", Texture = "rbxasset://textures/particles/smoke_main.dds",
		Color = ColorSequence.new(rgb(120, 255, 230), rgb(140, 90, 255)), LightEmission = 0.7, Rate = 9,
		Lifetime = NumberRange.new(1.6, 2.6), Speed = NumberRange.new(1, 2.5), EmissionDirection = Enum.NormalId.Bottom,
		SpreadAngle = Vector2.new(40, 40), Acceleration = V(0, -0.6, 0), Rotation = NumberRange.new(0, 360), RotSpeed = NumberRange.new(-30, 30),
		Size = nseq({{0, 2.2}, {1, 6}}), Transparency = nseq({{0, 0.6}, {1, 1}})})

	------------------------------------------------------------ CAPE déchirée dans le dos
	local cape = segment("Cape", body.Joint, V(0, 18.6, -2.3))
	cape.add("CapeClasp", V(6.6, 0.7, 0.6), C(0, 18.5, -2.5), TRIM)
	for i, x in {-2.8, -1.4, 0, 1.4, 2.8} do
		local len = ({10.5, 12, 13, 12, 10.5})[i]
		local color = i % 2 == 0 and ROBE2 or ROBE
		cape.add("CapeStrip", V(1.5, len, 0.4), C(x, 18.6 - len / 2, -2.7), color)
		cape.add("CapeTip", V(1.05, 1.05, 0.38), C(x, 18.6 - len, -2.7) * A(0, 0, rad(45)), color)
	end

	------------------------------------------------------------ BRAS : épaulières à piques, manches larges, mains d'os
	local arms = {}
	for _, sx in {1, -1} do
		local side = sx == 1 and "R" or "L"
		local arm = segment("Arm" .. side, body.Joint, V(sx * 3.9, 18.4, 0))
		arm.add("Pauldron", V(2.9, 1.4, 3.3), C(sx * 4.4, 19.1, 0) * A(0, 0, rad(-sx * 12)), METAL)
		arm.add("PauldronTop", V(2.3, 0.6, 2.7), C(sx * 4.5, 19.9, 0) * A(0, 0, rad(-sx * 12)), TRIM)
		for _, sz in {-1, 1} do
			arm.add("Spike", V(0.6, 1.7, 0.6), C(sx * 4.9, 20.8, sz * 0.8) * A(0, 0, rad(-sx * 25)), BONE)
		end
		arm.add("Sleeve", V(2.2, 4.4, 2.4), C(sx * 4.3, 16.4, 0.1), ROBE)
		local fore = segment("Fore" .. side, arm.Joint, V(sx * 4.4, 14.4, 0.2))
		fore.add("Forearm", V(2.6, 2.6, 3.4), C(sx * 4.5, 14.2, 1.9), ROBE2)
		fore.add("Cuff", V(3.0, 3.0, 0.5), C(sx * 4.5, 14.2, 3.7), TRIM)
		if sx == 1 then -- main droite : elle serre le manche de la faux
			fore.add("Palm", V(1.0, 1.3, 1.3), C(5.35, 14.0, 4.6), BONE)
			for _, y in {14.4, 14.0, 13.6} do fore.add("Finger", V(1.6, 0.32, 0.35), C(4.7, y, 5.2), BONE) end
		else -- main gauche : elle tient la chaîne de la lanterne
			fore.add("Palm", V(1.3, 1.0, 1.3), C(-4.6, 13.7, 4.6), BONE)
			for _, dx in {-0.38, 0.38} do fore.add("Finger", V(0.32, 0.8, 1.0), C(-4.6 + dx, 13.0, 4.6), BONE) end
		end
		arms[side] = fore
	end

	------------------------------------------------------------ FAUX : long manche, crâne au sommet, lame courbe au tranchant cyan
	local scythe = segment("Scythe", arms.R.Joint, V(4.6, 14.0, 4.6))
	scythe.add("Shaft", V(0.8, 23, 0.8), C(4.6, 15.0, 4.6), WOOD)
	for _, y in {5.5, 23.5, 25.0} do scythe.add("Band", V(1.0, 0.45, 1.0), C(4.6, y, 4.6), TRIM) end
	scythe.add("ButtSpike", V(0.55, 1.4, 0.55), C(4.6, 2.9, 4.6) * A(0, rad(45), 0), METAL)
	scythe.add("SkullCap", V(1.5, 1.4, 1.5), C(4.6, 27.2, 4.6), BONE)
	for _, dx in {-0.35, 0.35} do scythe.add("SkullEye", V(0.35, 0.3, 0.1), C(4.6 + dx, 27.3, 5.37), SOUL, {neon = true}) end
	local p = V(3.9, 27.6, 4.6)
	for i = 0, 4 do
		local theta = rad(i * 15)
		local len, w = 2.6, ({2.3, 1.95, 1.6, 1.2, 0.75})[i + 1]
		local dir = V(-math.cos(theta), -math.sin(theta), 0)
		local cf = C(p + dir * len / 2) * A(0, 0, theta)
		scythe.add("Blade", V(len + 0.1, w, 0.36), cf, STEEL, {mat = Enum.Material.Metal})
		scythe.add("BladeSpine", V(len + 0.1, 0.3, 0.42), cf * C(0, w / 2 - 0.1, 0), METAL)
		local edge = scythe.add("BladeEdge", V(len + 0.1, 0.22, 0.34), cf * C(0, -w / 2 - 0.05, 0), SOUL, {neon = true})
		if i == 2 then light(edge, "BladeGlow", SOUL, 12, 1.6) end
		p += dir * len
	end

	------------------------------------------------------------ LANTERNE D'ÂMES (balancier)
	local lantern = segment("Lantern", arms.L.Joint, V(-4.6, 13.2, 4.6))
	for i = 0, 2 do
		lantern.add("Chain", V(0.25, 0.9, 0.6), C(-4.6, 12.6 - i * 0.8, 4.6) * A(0, i % 2 == 1 and rad(90) or 0, 0), METAL)
	end
	lantern.add("LanternCap", V(1.9, 0.5, 1.9), C(-4.6, 10.3, 4.6), METAL)
	lantern.add("LanternKnob", V(1.0, 0.5, 1.0), C(-4.6, 10.7, 4.6) * A(0, rad(45), 0), TRIM)
	lantern.add("LanternBase", V(1.9, 0.5, 1.9), C(-4.6, 7.9, 4.6), METAL)
	for _, sx in {-1, 1} do for _, sz in {-1, 1} do
		lantern.add("LanternPost", V(0.3, 1.9, 0.3), C(-4.6 + sx * 0.75, 9.1, 4.6 + sz * 0.75), METAL)
	end end
	lantern.add("LanternGlass", V(1.3, 1.9, 1.3), C(-4.6, 9.1, 4.6), rgb(150, 255, 235), {glass = true, transparency = 0.55})
	local flame = lantern.add("SoulFlame", V(0.6, 1.0, 0.6), C(-4.6, 9.0, 4.6) * A(0, rad(45), 0), SOUL, {neon = true})
	light(flame, "LanternLight", SOUL, 16, 2.5)
	emitter(flame, {Name = "Wisps", Texture = "rbxasset://textures/particles/fire_main.dds", Color = ColorSequence.new(rgb(170, 255, 240), rgb(120, 90, 255)),
		LightEmission = 1, Rate = 10, Lifetime = NumberRange.new(0.5, 0.9), Speed = NumberRange.new(0.8, 1.6), SpreadAngle = Vector2.new(15, 15),
		EmissionDirection = Enum.NormalId.Top, Size = nseq({{0, 0.7}, {1, 0}}), Transparency = nseq({{0, 0.2}, {1, 1}}), Rotation = NumberRange.new(0, 360)})

	------------------------------------------------------------ ÂMES qui tournent autour de lui
	local souls = segment("Souls", root, V(0, 15, 0))
	for k = 0, 2 do
		local a = k * math.pi * 2 / 3
		local pos = V(math.cos(a) * 8, 15 + (k - 1) * 1.4, math.sin(a) * 8)
		local orb = souls.add("SoulOrb", V(0.9, 0.9, 0.9), C(pos) * A(rad(45), rad(45), 0), k == 1 and SOULV or SOUL, {neon = true})
		souls.add("SoulShell", V(1.6, 1.6, 1.6), C(pos), rgb(200, 255, 245), {glass = true, transparency = 0.6, smooth = true})
		emitter(orb, {Name = "SoulTrail", Texture = "rbxasset://textures/particles/sparkles_main.dds", Color = ColorSequence.new(rgb(170, 255, 240), rgb(170, 120, 255)),
			LightEmission = 1, Rate = 7, Lifetime = NumberRange.new(0.6, 1.1), Speed = NumberRange.new(0.2, 0.6), SpreadAngle = Vector2.new(180, 180),
			Size = nseq({{0, 0}, {0.3, 0.5}, {1, 0}})})
	end

	model:SetAttribute("Rig", "Reaper")
	model:SetAttribute("RPJoints", joints)
	model:SetAttribute("Height", HEIGHT)
	root.PivotOffset = C(0, -ROOT_Y, 0) -- le pivot du modèle est au sol (ZoneBossServer le pose par là)
	return model
end

return function()
	local report = {}
	-- 1. le gardien
	local bosses = ServerStorage:WaitForChild("ZoneBosses")
	local old = bosses:FindFirstChild("Reaper")
	if old then old:Destroy() end
	local boss = build("Reaper")
	boss.Parent = bosses
	local parts = 0
	for _, d in boss:GetDescendants() do if d:IsA("BasePart") then parts += 1 end end
	table.insert(report, "ZoneBosses.Reaper: " .. parts .. " parts, " .. boss:GetAttribute("RPJoints") .. " joints")

	-- 2. l'animal (même modèle en petit) : racine ancrée au milieu, comme les animaux du kit
	local pet = build("GrimReaper")
	local scale = 5.4 / (HEIGHT - 2.9)
	pet:ScaleTo(scale)
	pet:PivotTo(CFrame.new())
	local root = pet.PrimaryPart
	local groundOffset = root.Position.Y
	root.PivotOffset = CFrame.new()
	pet:PivotTo(CFrame.new(0, groundOffset, 0))
	pet:SetAttribute("GroundOffset", groundOffset)
	pet:SetAttribute("Height", (HEIGHT - 2.9) * scale)
	pet:SetAttribute("Move", "Fly")
	pet:SetAttribute("Kit", "Reaper")
	pet:SetAttribute("Phantom", true)
	for _, d in pet:GetDescendants() do -- en petit : lumières plus discrètes, pas de brume au sol
		if d:IsA("PointLight") then d.Brightness *= 0.35 end
		if d:IsA("ParticleEmitter") and d.Name == "GhostMist" then d.Rate = 4 end
	end
	CollectionService:AddTag(pet, "ReaperRig")
	local custom = ServerStorage:FindFirstChild("CustomPets") or Instance.new("Folder")
	custom.Name = "CustomPets"
	custom.Parent = ServerStorage
	old = custom:FindFirstChild("Reaper")
	if old then old:Destroy() end
	local stored = pet:Clone()
	stored.Name = "Reaper"
	stored.Parent = custom
	local pets = ReplicatedStorage.EggSystem.Pets
	old = pets:FindFirstChild("GrimReaper")
	if old then old:Destroy() end
	pet.Parent = pets
	table.insert(report, string.format("Pets.GrimReaper: height %.2f, ground offset %.2f", pet:GetAttribute("Height"), groundOffset))
	return table.concat(report, "\n")
end
