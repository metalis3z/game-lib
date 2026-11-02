-- Fabrique, à partir de ReplicatedStorage.AnimalKit.Models, tout ce que le jeu utilise comme animaux :
--   EggSystem.Pets       : un modèle par animal de EggConfig.Pets (racine "Root" invisible + mesh "Body" soudé, l'avant en +Z)
--   EggSystem.EggModels  : un œuf par entrée de EggConfig.Eggs : la coquille est l'œuf de Workspace.Eggs (copié dans
--                          ServerStorage.EggShellSource), teinté, avec des taches, les ornements de sa zone et un nid de bouts de bois
--   ServerStorage.ZoneBosses.Mesh_<Animal> : les gardiens géants des zones
-- Les anciens modèles sont rangés dans ServerStorage.Removed_OldAnimals. return function(Config, only) -> rapport. Peut être relancé ; only = "Eggs" ne refait que les œufs.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local CollectionService = game:GetService("CollectionService")

local TAG = "MeshAnimal" -- animé côté joueur par StarterPlayerScripts.MeshAnimalClient

-- copie d'un modèle du kit, mise à la taille voulue, dans l'enveloppe attendue par les scripts du jeu
local function wrap(kit, kitName, name, targetHeight, maxDim, rootSize)
	local src = kit:FindFirstChild(kitName)
	if not src then return nil end
	local clone = src:Clone()
	local h, w, l = src:GetAttribute("Height"), src:GetAttribute("Width"), src:GetAttribute("Length")
	local factor = math.min(targetHeight / h, maxDim / math.max(h, w, l))
	clone:ScaleTo(clone:GetScale() * factor) -- ScaleTo est absolu : on multiplie l'échelle interne du modèle
	clone:PivotTo(CFrame.new())               -- pivot du kit : au sol, sous le centre, l'avant en -Z
	local body = clone:FindFirstChild("Body")
	local height = h * factor
	local model = Instance.new("Model")
	model.Name = name
	local root = Instance.new("Part")
	root.Name = "Root"
	root.Size = Vector3.one * (rootSize or 0.35)
	root.Transparency = 1
	root.Anchored = true
	root.CanCollide, root.CanQuery, root.CanTouch = false, false, false
	root.CFrame = CFrame.new(0, height / 2, 0)
	root.Parent = model
	body.CFrame = CFrame.Angles(0, math.pi, 0) * body.CFrame -- demi-tour : dans le jeu l'avant des animaux est en +Z
	body.Anchored = false
	body.Massless = true
	body.CanCollide, body.CanQuery, body.CanTouch = false, false, false
	body.Parent = model
	local weld = Instance.new("Weld")
	weld.Name = "BodyWeld"
	weld.Part0, weld.Part1 = root, body
	weld.C0 = root.CFrame:ToObjectSpace(body.CFrame)
	weld.Parent = root
	model.PrimaryPart = root
	model:SetAttribute("GroundOffset", height / 2) -- hauteur de la racine au-dessus du sol
	model:SetAttribute("Height", height)
	model:SetAttribute("Move", src:GetAttribute("Move") or "Walk")
	model:SetAttribute("Kit", kitName)
	local bones = 0
	for _, d in body:GetDescendants() do if d:IsA("Bone") then bones += 1 end end
	model:SetAttribute("Bones", bones) -- le client attend que tous les os soient arrivés avant d'animer
	CollectionService:AddTag(model, TAG)
	clone:Destroy()
	return model, height
end

---------------------------------------------------------------- animaux « ange » (EggConfig.Pets[...].Angel) et œuf ange
-- Le mesh garde sa texture, une auréole lumineuse tourne au-dessus de la tête, et ceux qui n'ont pas d'ailes
-- reçoivent deux ailes de plumes en blocs. Auréole et ailes sont soudées à la racine : MeshAnimalClient les anime.
local WHITE, GOLD, PALE = Color3.fromRGB(255, 253, 244), Color3.fromRGB(255, 208, 60), Color3.fromRGB(214, 236, 255)
local function angelPart(model, name, size, cf, color, neon)
	local p = Instance.new("Part")
	p.Name = name
	p.Size, p.CFrame, p.Color = size, cf, color
	p.Material = neon and Enum.Material.Neon or Enum.Material.Plastic
	if not neon then pcall(function() p.MaterialVariant = "Studs" end) end
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	p.Anchored, p.Massless, p.CastShadow = false, true, false
	p.CanCollide, p.CanQuery, p.CanTouch = false, false, false
	p.Parent = model
	return p
end
local function weldTo(part0, part1, name)
	local w = Instance.new("Weld")
	w.Name = name
	w.Part0, w.Part1 = part0, part1
	w.C0 = part0.CFrame:ToObjectSpace(part1.CFrame)
	w.Parent = part1
	return w
end
-- anneau lumineux, à plat, centré sur "center" : assez de segments pour paraître rond
local function ring(model, center, radius, make)
	local segments = 20
	local seg = 2 * radius * math.tan(math.pi / segments) * 1.12
	local thick = radius * 0.2
	for i = 1, segments do
		local a = (i - 0.5) / segments * math.pi * 2
		make(Vector3.new(seg, thick, thick), center * CFrame.Angles(0, a, 0) * CFrame.new(0, 0, radius))
	end
end

-- une aile : un plan fin et invisible qui porte, sur ses deux faces, l'image d'une aile à plumes (épaule à gauche de l'image,
-- à 6 % du bord et 42 % de la hauteur). "frame" = repère de l'épaule ; side = 1 pour l'aile qui part vers +X, -1 vers -X.
local WING, WING_MIRROR = "rbxassetid://107872807830791", "rbxassetid://126789615631185"
local function wingPlane(model, name, frame, span, side)
	local tall = span * 0.75
	local p = angelPart(model, name, Vector3.new(span, tall, 0.05), frame * CFrame.new(side * span * 0.44, -tall * 0.08, 0), WHITE, false)
	p.Transparency = 1
	for _, face in {Enum.NormalId.Back, Enum.NormalId.Front} do
		local decal = Instance.new("Decal")
		decal.Face = face
		-- sur la face arrière l'image part vers +X, sur la face avant vers -X : on choisit l'image ou son miroir
		decal.Texture = ((face == Enum.NormalId.Back) == (side > 0)) and WING or WING_MIRROR
		decal.Parent = p
	end
	return p
end
-- repère d'une aile : balayée vers l'arrière (sweep) et relevée (lift), en degrés
local function wingFrame(base, side, sweep, lift)
	return base * CFrame.Angles(0, math.rad(side * sweep), 0) * CFrame.Angles(0, 0, math.rad(side * lift))
end

local function angelize(model, height, color)
	local root, body = model.PrimaryPart, model:FindFirstChild("Body")
	-- l'animal garde la texture du kit (ses yeux, son visage, son pelage) : le créateur ne veut pas d'un mesh tout blanc.
	-- AngelColor (EggConfig) teinte seulement cette texture.
	local surface = body:FindFirstChildOfClass("SurfaceAppearance")
	if surface and color then surface.Color = color end
	-- repères lus sur le squelette : la tête (os du milieu le plus haut vers l'avant) et le dos (premier os).
	-- L'auréole et les ailes suivent ces os pendant les animations (MeshAnimalClient, attribut Bone des soudures).
	local eps = math.max(body.Size.X * 0.03, 0.04)
	local head, spine, names = nil, nil, {}
	for _, b in body:GetDescendants() do
		if b:IsA("Bone") then
			names[b.Name] = (names[b.Name] or 0) + 1
			local p = b.WorldPosition
			if not spine and not b.Parent:IsA("Bone") then spine = b end
			if math.abs(p.X) < eps and (not head or p.Y + p.Z > head.WorldPosition.Y + head.WorldPosition.Z) then head = b end
		end
	end
	local headName = head and names[head.Name] == 1 and head.Name or nil
	local spineName = spine and names[spine.Name] == 1 and spine.Name or nil
	local headAt = head and head.WorldPosition or Vector3.new(0, height * 0.8, height * 0.3)
	local spineAt = spine and spine.WorldPosition or Vector3.new(0, height * 0.6, 0)
	local count = 0
	local radius = math.max(height * 0.15, 0.26)
	ring(model, CFrame.new(0, math.min(headAt.Y + height * 0.27, height * 1.14), headAt.Z), radius, function(size, cf)
		weldTo(root, angelPart(model, "Halo", size, cf, GOLD, true), "AngelHalo"):SetAttribute("Bone", headName)
		count += 1
	end)
	if model:GetAttribute("Move") ~= "Fly" then -- ceux qui volent ont déjà leurs ailes
		for _, side in {-1, 1} do
			local base = CFrame.new(side * math.max(body.Size.X * 0.14, height * 0.05), math.min(spineAt.Y + height * 0.16, height * 0.94), spineAt.Z + height * 0.04)
			local pivot = angelPart(model, "WingPivot", Vector3.one * 0.1, base, WHITE, false)
			pivot.Transparency = 1
			local weld = weldTo(root, pivot, "AngelWing")
			weld:SetAttribute("Side", side)
			weld:SetAttribute("Bone", spineName)
			count += 1
			-- deux plans par aile, à deux angles : l'aile garde du volume vue de côté
			weldTo(pivot, wingPlane(model, "Wing", wingFrame(base, side, 14, 24), height * 1.1, side), "FeatherWeld")
			weldTo(pivot, wingPlane(model, "WingBack", wingFrame(base * CFrame.new(0, 0, -height * 0.03), side, 46, 34), height * 0.84, side), "FeatherWeld")
		end
	end
	local light = Instance.new("PointLight")
	light.Name = "AngelGlow"
	light.Color, light.Range, light.Brightness, light.Shadows = Color3.fromRGB(255, 236, 170), height * 1.8, 0.5, false
	light.Parent = root
	local sparkle = Instance.new("ParticleEmitter")
	sparkle.Name = "AngelSparkle"
	sparkle.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	sparkle.Color = ColorSequence.new(Color3.fromRGB(255, 250, 210), GOLD)
	sparkle.LightEmission, sparkle.LightInfluence = 1, 0
	sparkle.Rate = 5
	sparkle.Lifetime = NumberRange.new(0.8, 1.4)
	sparkle.Speed = NumberRange.new(height * 0.15, height * 0.4)
	sparkle.SpreadAngle = Vector2.new(180, 180)
	sparkle.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3, height * 0.09), NumberSequenceKeypoint.new(1, 0)})
	sparkle.Parent = root
	model:SetAttribute("Angel", true)
	model:SetAttribute("AngelParts", count) -- nombre de soudures animées : le client attend de les avoir toutes
end

-- animaux « galaxie » (EggConfig.Pets[...].Galaxy, zone Galactic) : la texture du kit est teintée de violet cosmique,
-- une lueur bleue et des étoiles qui scintillent autour d'eux (rien de soudé : MeshAnimalClient n'a rien de plus à animer)
local function galaxify(model, height)
	local root, body = model.PrimaryPart, model:FindFirstChild("Body")
	local surface = body and body:FindFirstChildOfClass("SurfaceAppearance")
	if surface then surface.Color = Color3.fromRGB(196, 176, 255) end
	local glow = Instance.new("PointLight")
	glow.Name = "GalaxyGlow"
	glow.Color, glow.Range, glow.Brightness, glow.Shadows = Color3.fromRGB(120, 170, 255), height * 1.8, 0.7, false
	glow.Parent = root
	local stars = Instance.new("ParticleEmitter")
	stars.Name = "GalaxyStars"
	stars.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	stars.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 220, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 130, 230))})
	stars.LightEmission, stars.LightInfluence = 1, 0
	stars.Rate = 7
	stars.Lifetime = NumberRange.new(0.8, 1.6)
	stars.Speed = NumberRange.new(height * 0.1, height * 0.3)
	stars.SpreadAngle = Vector2.new(180, 180)
	stars.Rotation = NumberRange.new(0, 360)
	stars.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4, height * 0.1), NumberSequenceKeypoint.new(1, 0)})
	stars.Parent = root
	model:SetAttribute("Galaxy", true)
end

-- animaux « fantôme » (EggConfig.Pets[...].Phantom, zone Phantom) : la texture du kit est assombrie (ombre violette),
-- une lueur cyan fantôme et une brume qui s'échappe d'eux et retombe doucement
local function phantomize(model, height)
	local root, body = model.PrimaryPart, model:FindFirstChild("Body")
	local surface = body and body:FindFirstChildOfClass("SurfaceAppearance")
	if surface then surface.Color = Color3.fromRGB(150, 140, 190) end
	local glow = Instance.new("PointLight")
	glow.Name = "PhantomGlow"
	glow.Color, glow.Range, glow.Brightness, glow.Shadows = Color3.fromRGB(110, 255, 230), height * 1.8, 0.8, false
	glow.Parent = root
	local mist = Instance.new("ParticleEmitter")
	mist.Name = "PhantomMist"
	mist.Texture = "rbxasset://textures/particles/smoke_main.dds"
	mist.Color = ColorSequence.new(Color3.fromRGB(130, 255, 230), Color3.fromRGB(150, 100, 255))
	mist.LightEmission, mist.LightInfluence = 0.8, 0
	mist.Rate = 5
	mist.Lifetime = NumberRange.new(1, 1.8)
	mist.Speed = NumberRange.new(height * 0.05, height * 0.15)
	mist.SpreadAngle = Vector2.new(180, 180)
	mist.Acceleration = Vector3.new(0, -height * 0.15, 0)
	mist.Rotation, mist.RotSpeed = NumberRange.new(0, 360), NumberRange.new(-40, 40)
	mist.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, height * 0.15), NumberSequenceKeypoint.new(1, height * 0.4)})
	mist.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.65), NumberSequenceKeypoint.new(1, 1)})
	mist.Parent = root
	local sparks = Instance.new("ParticleEmitter")
	sparks.Name = "PhantomSparks"
	sparks.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	sparks.Color = ColorSequence.new(Color3.fromRGB(160, 255, 235), Color3.fromRGB(190, 140, 255))
	sparks.LightEmission, sparks.LightInfluence = 1, 0
	sparks.Rate = 4
	sparks.Lifetime = NumberRange.new(0.8, 1.4)
	sparks.Speed = NumberRange.new(height * 0.1, height * 0.25)
	sparks.SpreadAngle = Vector2.new(180, 180)
	sparks.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4, height * 0.08), NumberSequenceKeypoint.new(1, 0)})
	sparks.Parent = root
	model:SetAttribute("Phantom", true)
end

-- œuf ange : auréole au-dessus de la coquille et deux ailes à plumes (pièces ancrées, comme le reste de l'œuf)
local function angelEgg(egg)
	local lo, hi = Vector3.one * math.huge, Vector3.one * -math.huge
	for _, p in egg:GetDescendants() do
		if p:IsA("BasePart") and p.Name == "Stud" then
			lo, hi = lo:Min(p.Position - p.Size / 2), hi:Max(p.Position + p.Size / 2)
		end
	end
	local c, s = (lo + hi) / 2, hi - lo
	ring(egg, CFrame.new(c.X, hi.Y + s.Y * 0.16, c.Z), s.X * 0.36, function(size, cf)
		angelPart(egg, "Angel", size, cf, GOLD, true).Anchored = true
	end)
	for _, side in {-1, 1} do
		local base = CFrame.new(c.X + side * s.X * 0.34, c.Y + s.Y * 0.16, c.Z)
		wingPlane(egg, "Angel", wingFrame(base, side, 10, 26), s.Y * 1.15, side).Anchored = true
		wingPlane(egg, "Angel", wingFrame(base * CFrame.new(0, 0, -s.Z * 0.12), side, 42, 36), s.Y * 0.9, side).Anchored = true
	end
end

---------------------------------------------------------------- œufs
-- Mesures à l'échelle 1, par rapport au pivot (la racine) : les mêmes que les anciens œufs, les scripts du jeu comptent dessus.
local SHELL_LO, SHELL_HI = -5.4, 12.7 -- bas et haut de la coquille
local EGG_AT = Vector3.new(0, 3000, 0) -- les œufs sont assemblés loin de la carte
local rgb = Color3.fromRGB
local rad = math.rad

local function eggPiece(model, name, size, cf, color, opts)
	opts = opts or {}
	local p = Instance.new("Part")
	p.Name = name
	p.Size, p.CFrame, p.Color = size, cf + EGG_AT, color
	p.Material = opts.Material or (opts.Neon and Enum.Material.Neon or Enum.Material.Plastic)
	if p.Material == Enum.Material.Plastic then pcall(function() p.MaterialVariant = "Studs" end) end
	p.Transparency = opts.Transparency or 0
	p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	p.Anchored, p.Massless, p.CastShadow = true, true, false
	p.CanCollide, p.CanQuery, p.CanTouch = false, false, false
	p.Parent = model
	return p
end

-- le nid, le même pour tous les œufs : trois rangs de petits rondins empilés en couronne, décalés d'un rang à l'autre,
-- quelques brindilles qui dépassent et un peu de paille
local function buildNest()
	local nest = Instance.new("Folder")
	local rng = Random.new(7)
	local WOOD = {rgb(150, 98, 52), rgb(122, 76, 38), rgb(176, 122, 68)}
	local CUT = rgb(226, 190, 132) -- bois clair des bouts coupés
	local PER = 8
	for row = 0, 2 do
		local radius = 5.3 + row * 0.62
		local y = -5.95 + row * 0.95
		local length = 2 * radius * math.tan(math.pi / PER) * 1.5
		for k = 1, PER do
			local angle = (k + row * 0.5) / PER * math.pi * 2
			local cf = CFrame.new(0, y, 0) * CFrame.Angles(0, angle + rng:NextNumber(-0.07, 0.07), 0) * CFrame.new(radius, 0, 0)
				* CFrame.Angles(rng:NextNumber(-0.1, 0.1), 0, rng:NextNumber(-0.08, 0.08))
			eggPiece(nest, "Nest", Vector3.new(1.0, 0.95, length), cf, WOOD[(k + row) % 3 + 1])
			if (k + row) % 2 == 0 then -- un bout coupé clair, d'un côté
				eggPiece(nest, "Nest", Vector3.new(0.74, 0.7, 0.2), cf * CFrame.new(0, 0, length / 2 + 0.06), CUT, {Material = Enum.Material.SmoothPlastic})
			end
		end
	end
	-- fond du nid
	eggPiece(nest, "Nest", Vector3.new(9.4, 0.6, 9.4), CFrame.new(0, -6.2, 0), WOOD[2])
	eggPiece(nest, "Nest", Vector3.new(9.4, 0.6, 9.4), CFrame.new(0, -6.2, 0) * CFrame.Angles(0, math.pi / 4, 0), WOOD[2])
	-- brindilles qui dépassent
	for k = 1, 5 do
		local angle = (k + 0.3) / 5 * math.pi * 2
		eggPiece(nest, "Nest", Vector3.new(0.42, 0.42, 3.6), CFrame.new(0, -4.3, 0) * CFrame.Angles(0, angle, 0) * CFrame.new(6.5, 0, 0)
			* CFrame.Angles(rng:NextNumber(-0.5, 0.5), rng:NextNumber(-0.5, 0.5), 0), k % 2 == 0 and WOOD[3] or WOOD[1])
	end
	-- paille
	for k = 1, 4 do
		local angle = (k + 0.8) / 4 * math.pi * 2
		eggPiece(nest, "Nest", Vector3.new(0.3, 0.3, 2.8), CFrame.new(0, -3.75, 0) * CFrame.Angles(0, angle, 0) * CFrame.new(5.6, 0, 0)
			* CFrame.Angles(rng:NextNumber(-0.3, 0.3), rng:NextNumber(-0.7, 0.7), 0), rgb(236, 206, 120))
	end
	return nest
end

-- Ornements par rareté (= par zone). add(size, cf, color, opts) pose une pièce ; T = haut de la coquille ;
-- side(y, angle) = repère posé sur la coquille (−Z vers l'extérieur, Y vers le haut) ; radius(y) = rayon de la coquille à cette hauteur.
local T = SHELL_HI
local DECO = {}
DECO.Common = function(add) -- forêt : une pousse
	add(Vector3.new(0.7, 2.2, 0.7), CFrame.new(0, T + 0.8, 0), rgb(70, 150, 50))
	for _, s in {-1, 1} do
		add(Vector3.new(2.8, 0.45, 1.6), CFrame.new(s * 1.5, T + 2.0, 0) * CFrame.Angles(0, 0, s * rad(28)), rgb(112, 214, 70))
	end
end
DECO.Uncommon = function(add) -- jungle : collerette de feuilles et fleur
	for i = 0, 3 do
		add(Vector3.new(3.6, 0.45, 2.0), CFrame.new(0, T - 0.5, 0) * CFrame.Angles(0, i * math.pi / 2 + math.pi / 4, 0) * CFrame.new(2.4, 0, 0) * CFrame.Angles(0, 0, rad(-24)),
			i % 2 == 0 and rgb(48, 160, 80) or rgb(96, 208, 106))
	end
	add(Vector3.new(1.7, 1.0, 1.7), CFrame.new(0, T + 0.7, 0) * CFrame.Angles(0, rad(45), 0), rgb(255, 96, 162))
	add(Vector3.new(0.9, 0.6, 0.9), CFrame.new(0, T + 1.4, 0), rgb(255, 222, 80))
end
DECO.Rare = function(add, side, radius, colors) -- aquatique : nageoires et bulles
	for i, len in {4.2, 3.0, 1.7} do
		add(Vector3.new(0.6, 1.15, len), CFrame.new(0, T + 0.4 + (i - 1) * 1.1, -0.3 * i), colors[2])
	end
	for _, angle in {0, math.pi} do
		local f = side(4.5, angle)
		add(Vector3.new(0.6, 2.6, 3.0), f * CFrame.new(0, 0, -1.1) * CFrame.Angles(rad(22), 0, 0), colors[2])
		add(Vector3.new(0.6, 1.6, 1.8), f * CFrame.new(0, 0.9, -3.0) * CFrame.Angles(rad(22), 0, 0), colors[2])
	end
	for _, b in {Vector3.new(4.4, T + 1.0, 2.2), Vector3.new(-3.6, T + 2.4, -2.0), Vector3.new(1.2, T + 3.8, -3.4)} do
		add(Vector3.one * 1.0, CFrame.new(b), rgb(190, 240, 255), {Material = Enum.Material.Glass, Transparency = 0.35})
	end
end
DECO.Epic = function(add) -- glace : couronne de cristaux
	local ice = {Material = Enum.Material.Ice}
	add(Vector3.new(1.4, 4.8, 1.4), CFrame.new(0, T + 1.4, 0) * CFrame.Angles(0, rad(45), 0), rgb(196, 240, 255), ice)
	for i = 0, 3 do
		add(Vector3.new(1.05, 3.2, 1.05), CFrame.new(0, T - 0.4, 0) * CFrame.Angles(0, i * math.pi / 2, 0) * CFrame.new(2.1, 0, 0) * CFrame.Angles(0, rad(45), rad(-30)) * CFrame.new(0, 1.0, 0),
			i % 2 == 0 and rgb(150, 222, 255) or rgb(214, 246, 255), ice)
	end
end
DECO.Legendary = function(add, side, radius) -- désert : couronne d'or
	local y = T - 2.2
	local half = radius(y) + 0.45
	local gold = rgb(255, 204, 52)
	for i = 0, 3 do
		local turn = CFrame.new(0, y, 0) * CFrame.Angles(0, i * math.pi / 2, 0)
		add(Vector3.new(half * 2 + 0.6, 1.2, 0.6), turn * CFrame.new(0, 0, half), gold)
		add(Vector3.new(0.85, 2.4, 0.85), turn * CFrame.new(half, 0.9, half), rgb(255, 226, 110))
	end
	add(Vector3.new(1.0, 1.0, 0.5), CFrame.new(0, y, half + 0.4) * CFrame.Angles(0, 0, rad(45)), rgb(255, 60, 80), {Neon = true})
end
DECO.Mythic = function(add, side) -- lave : roches et coulées
	local rock = rgb(48, 38, 40)
	add(Vector3.new(2.4, 1.8, 2.4), CFrame.new(0.3, T + 0.2, 0) * CFrame.Angles(rad(12), rad(30), rad(8)), rock)
	add(Vector3.new(1.6, 1.5, 1.6), CFrame.new(-1.5, T - 0.7, 1.0) * CFrame.Angles(rad(-15), rad(10), rad(20)), rock)
	add(Vector3.new(1.4, 1.3, 1.4), CFrame.new(1.4, T - 0.9, -1.3) * CFrame.Angles(rad(20), rad(50), 0), rock)
	for i = 0, 3 do
		local y = 9.2 - (i % 2) * 2.2
		add(Vector3.new(0.9, 3.6 - (i % 2), 0.5), side(y, i * math.pi / 2 + 0.6), rgb(255, 128, 30), {Neon = true})
	end
end
DECO.Secret = function(add) -- démon : cornes
	local dark = rgb(52, 26, 66)
	for _, s in {-1, 1} do
		local base = CFrame.new(s * 2.5, T - 1.3, 0) * CFrame.Angles(0, 0, s * rad(-38))
		add(Vector3.new(1.5, 2.6, 1.5), base * CFrame.new(0, 1.0, 0), dark)
		local mid = base * CFrame.new(0, 2.2, 0) * CFrame.Angles(0, 0, s * rad(30))
		add(Vector3.new(1.1, 2.2, 1.1), mid * CFrame.new(0, 0.9, 0), rgb(74, 36, 92))
		local tip = mid * CFrame.new(0, 1.9, 0) * CFrame.Angles(0, 0, s * rad(30))
		add(Vector3.new(0.7, 1.5, 0.7), tip * CFrame.new(0, 0.6, 0), rgb(255, 70, 200), {Neon = true})
	end
end
DECO.Ancient = function(add, side, radius, colors) -- dino : plaques sur le dos
	local plate = colors[2]
	add(Vector3.new(0.7, 2.6, 2.6), CFrame.new(0, T + 0.4, 0) * CFrame.Angles(rad(45), 0, 0), plate)
	for i, y in {9.6, 6.2, 2.8, -0.6} do
		local s = i <= 2 and 2.6 or 2.0
		add(Vector3.new(0.7, s, s), side(y, -math.pi / 2) * CFrame.new(0, 0, -0.5) * CFrame.Angles(rad(45), 0, 0), plate)
	end
end
DECO.OG = function(add, side, radius) -- bonbon : chantilly, cerise et vermicelles
	local cream = rgb(255, 250, 244)
	local half = radius(T - 1.2) + 0.5
	add(Vector3.new(half * 2, 1.1, half * 2), CFrame.new(0, T - 1.9, 0), cream)
	add(Vector3.new(half * 1.5, 1.0, half * 1.5), CFrame.new(0, T - 0.9, 0) * CFrame.Angles(0, rad(45), 0), cream)
	add(Vector3.new(half * 0.9, 1.0, half * 0.9), CFrame.new(0, T + 0.05, 0), cream)
	add(Vector3.one * 1.4, CFrame.new(0, T + 1.2, 0) * CFrame.Angles(0, rad(20), 0), rgb(232, 34, 62))
	add(Vector3.new(0.3, 1.4, 0.3), CFrame.new(0.3, T + 2.4, 0) * CFrame.Angles(0, 0, rad(-22)), rgb(70, 150, 50))
	local sprinkles = {rgb(255, 222, 80), rgb(110, 220, 255), rgb(255, 120, 190), rgb(150, 240, 130)}
	for i = 1, 8 do
		add(Vector3.new(0.5, 1.5, 0.45), side(1 + (i * 37 % 9), i * 2.4) * CFrame.Angles(0, 0, i * 1.1), sprinkles[i % 4 + 1])
	end
end
DECO.Prismatic = function(add, side) -- Halloween : ailes de chauve-souris et queue de citrouille
	local skin, bone = rgb(58, 34, 84), rgb(34, 20, 50)
	for _, angle in {0, math.pi} do
		local f = side(6.5, angle)
		add(Vector3.new(0.5, 0.7, 5.6), f * CFrame.new(0, 2.0, -2.4) * CFrame.Angles(rad(28), 0, 0), bone)
		add(Vector3.new(0.4, 3.0, 2.4), f * CFrame.new(0, 0.2, -1.4), skin)
		add(Vector3.new(0.4, 2.4, 2.0), f * CFrame.new(0, 1.2, -3.4), skin)
		add(Vector3.new(0.4, 1.5, 1.6), f * CFrame.new(0, 2.4, -5.0), skin)
	end
	add(Vector3.new(1.3, 1.5, 1.3), CFrame.new(0, T + 0.5, 0), rgb(86, 120, 50))
	add(Vector3.new(0.9, 0.9, 1.8), CFrame.new(0, T + 1.4, 0.6) * CFrame.Angles(rad(-20), 0, 0), rgb(104, 146, 60))
end
DECO.Galactic = function(add, side, radius) -- galaxie : anneau de planète penché, étoile au sommet, petites étoiles sur la coquille
	local y = 4.2
	local r = radius(y) + 2.2
	for i = 0, 19 do
		local a = (i + 0.5) / 20 * math.pi * 2
		add(Vector3.new(2 * r * math.tan(math.pi / 20) * 1.12, 0.7, 1.3), CFrame.new(0, y, 0) * CFrame.Angles(rad(16), 0, rad(-8)) * CFrame.Angles(0, a, 0) * CFrame.new(0, 0, r),
			i % 2 == 0 and rgb(120, 230, 255) or rgb(200, 150, 255), {Neon = i % 4 == 0})
	end
	local starColor = rgb(255, 236, 120)
	add(Vector3.new(3.4, 1.0, 1.0), CFrame.new(0, T + 1.5, 0), starColor, {Neon = true})
	add(Vector3.new(1.0, 3.4, 1.0), CFrame.new(0, T + 1.5, 0), starColor, {Neon = true})
	add(Vector3.new(2.0, 2.0, 0.8), CFrame.new(0, T + 1.5, 0) * CFrame.Angles(0, 0, rad(45)), rgb(255, 250, 200), {Neon = true})
	for i = 0, 5 do
		add(Vector3.new(0.8, 0.8, 0.5), side(-0.5 + i * 1.8, i * 2.1 + 0.4) * CFrame.new(0, 0, 0.1) * CFrame.Angles(0, 0, rad(45)), rgb(255, 255, 255), {Neon = true})
	end
end

DECO.Phantom = function(add, side, radius) -- fantôme : couronne de pics sombres aux pointes lumineuses, petite faux plantée, éclats fantômes
	local dark, ghost, violet = rgb(26, 22, 38), rgb(120, 255, 225), rgb(160, 100, 255)
	for i = 0, 5 do
		local a = i / 6 * math.pi * 2
		local f = CFrame.new(0, T - 0.6, 0) * CFrame.Angles(0, a, 0) * CFrame.new(0, 0, 2.2) * CFrame.Angles(rad(-18), 0, 0)
		add(Vector3.new(0.9, 2.4, 0.9), f * CFrame.new(0, 1.0, 0), dark)
		add(Vector3.new(0.55, 0.9, 0.55), f * CFrame.new(0, 2.6, 0), i % 2 == 0 and ghost or violet, {Neon = true})
	end
	add(Vector3.new(0.5, 4.2, 0.5), CFrame.new(0, T + 1.6, 0) * CFrame.Angles(0, 0, rad(-12)), rgb(60, 50, 74))
	add(Vector3.new(0.35, 0.9, 3.0), CFrame.new(-0.4, T + 3.5, 1.1) * CFrame.Angles(rad(-20), 0, 0), rgb(200, 205, 220))
	add(Vector3.new(0.2, 0.25, 2.6), CFrame.new(-0.4, T + 3.0, 1.3) * CFrame.Angles(rad(-20), 0, 0), ghost, {Neon = true})
	for i = 0, 4 do
		add(Vector3.new(0.7, 0.7, 0.45), side(0.5 + i * 2, i * 2.4 + 1) * CFrame.new(0, 0, 0.1) * CFrame.Angles(0, 0, rad(45)), i % 2 == 0 and ghost or violet, {Neon = true})
	end
end

local function buildEggs(Config, folder, filter)
	-- la coquille : l'œuf de Workspace.Eggs, gardé en copie dans ServerStorage pour que la carte puisse changer
	local source = ServerStorage:FindFirstChild("EggShellSource")
	if not source then
		local eggsFolder = workspace:FindFirstChild("Eggs")
		local found = eggsFolder and eggsFolder:FindFirstChildWhichIsA("UnionOperation", true)
		assert(found, "Workspace.Eggs : egg union not found")
		source = found:Clone()
		source.Name = "EggShellSource"
		source.Parent = ServerStorage
	end
	local shell = source:Clone()
	shell.Name = "Stud"
	shell.Size = source.Size * ((SHELL_HI - SHELL_LO) / source.Size.Y)
	shell.CFrame = CFrame.new(EGG_AT + Vector3.new(0, (SHELL_LO + SHELL_HI) / 2, 0)) * source.CFrame.Rotation
	shell.Anchored, shell.CastShadow, shell.Massless = true, false, true
	shell.CanCollide, shell.CanTouch, shell.CanQuery = false, false, true
	shell.UsePartColor = true
	shell.Parent = workspace
	task.wait(0.2)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = {shell}
	-- repère posé sur la coquille, à la hauteur y (par rapport au pivot) et à l'angle donné ; les faces de l'œuf sont des cubes :
	-- la normale est ramenée sur l'axe le plus proche
	local function side(y, angle)
		local dir = Vector3.new(math.cos(angle), 0, math.sin(angle))
		local hit = workspace:Raycast(EGG_AT + Vector3.new(0, y, 0) + dir * 30, -dir * 30, params)
		local pos = hit and (hit.Position - EGG_AT) or Vector3.new(0, y, 0) + dir * 5
		local n = hit and hit.Normal or dir
		n = math.abs(n.X) >= math.abs(n.Z) and Vector3.new(math.sign(n.X), 0, 0) or Vector3.new(0, 0, math.sign(n.Z))
		return CFrame.lookAt(pos, pos + n)
	end
	local function radius(y)
		local r = 0
		for i = 0, 7 do
			local dir = Vector3.new(math.cos(i * math.pi / 4), 0, math.sin(i * math.pi / 4))
			local hit = workspace:Raycast(EGG_AT + Vector3.new(0, y, 0) + dir * 30, -dir * 30, params)
			if hit then r = math.max(r, ((hit.Position - EGG_AT) * Vector3.new(1, 0, 1)).Magnitude) end
		end
		return r
	end
	local nest = buildNest()
	local count = 0
	for key, info in Config.Eggs do
		if filter and not filter(key, info) then continue end
		local old = filter and folder:FindFirstChild(key)
		if old then old:Destroy() end
		local egg = Instance.new("Model")
		egg.Name = key
		local root = Instance.new("Part")
		root.Name = "Root"
		root.Size = Vector3.one
		root.CFrame = CFrame.new(EGG_AT)
		root.Transparency = 1
		root.Anchored = true
		root.CanCollide, root.CanQuery, root.CanTouch = false, false, false
		root.Parent = egg
		egg.PrimaryPart = root
		local body = shell:Clone()
		body.Color = info.Colors[1]
		body.Parent = egg
		for _, p in nest:GetChildren() do p:Clone().Parent = egg end
		-- taches : de gros carrés de la deuxième couleur, de petits de la troisième (lumineux pour les quatre dernières zones et la lave)
		local rank = Config.RarityRank[info.Rarity] or 1
		local seed = 0
		for i = 1, #key do seed = (seed * 31 + string.byte(key, i)) % 100000 end
		local rng = Random.new(seed)
		local glow = rank >= 8 or info.Rarity == "Mythic"
		for i = 1, 9 do
			local big = i <= 5
			local s = big and (rng:NextInteger(0, 1) == 0 and 2.7 or 1.8) or 1.0
			local f = side(rng:NextNumber(-1.5, 9.5), (i + rng:NextNumber(-0.3, 0.3)) / 9 * math.pi * 2 * 2)
			eggPiece(egg, "Spot", Vector3.new(s, s, 0.7), f * CFrame.new(0, 0, 0.05), info.Colors[big and 2 or 3], {Neon = glow and not big})
		end
		local function add(size, cf, color, opts) return eggPiece(egg, "Deco", size, cf, color, opts) end
		if info.Angel or info.Rarity == "Divine" then
			angelEgg(egg)
		elseif DECO[info.Rarity] then
			DECO[info.Rarity](add, side, radius, info.Colors)
		end
		egg:SetAttribute("Tall", true)
		egg:SetAttribute("SmoothShell", true)
		egg:ScaleTo(0.2)
		egg.Parent = folder
		count += 1
		if count % 10 == 0 then task.wait() end
	end
	shell:Destroy()
	nest:Destroy()
	return count
end

local function replaceFolder(parent, name, removed)
	local old = parent:FindFirstChild(name)
	if old then
		if removed:FindFirstChild(name) then old:Destroy() else old.Parent = removed end -- la première fois : les anciens modèles sont gardés
	end
	local folder = Instance.new("Folder")
	folder.Name = name
	return folder
end

-- only = "Rarity:Galactic" : ajoute (ou refait) seulement les animaux, les œufs et le gardien d'UNE rareté, sans toucher au reste
local function buildRarity(Config, rarity)
	local kit = ReplicatedStorage.AnimalKit.Models
	local eggSystem = ReplicatedStorage.EggSystem
	local report = {}
	local pets, count, missing = eggSystem.Pets, 0, {}
	for key, info in Config.Pets do
		if info.Rarity ~= rarity then continue end
		local kitName = info.Model or key
		local h = kit:FindFirstChild(kitName) and kit[kitName]:GetAttribute("Height")
		if h then
			local model, height = wrap(kit, kitName, key, math.clamp(1.7 + 0.95 * math.log(1 + h), 2.3, 5.5), 8)
			if info.Angel then angelize(model, height, info.AngelColor) end
			if info.Galaxy then galaxify(model, height) end
			if info.Phantom then phantomize(model, height) end
			local old = pets:FindFirstChild(key)
			if old then old:Destroy() end
			model.Parent = pets
			count += 1
		else
			table.insert(missing, key)
		end
	end
	table.insert(report, count .. " " .. rarity .. " pet models" .. (#missing > 0 and (" | NOT IN KIT: " .. table.concat(missing, ", ")) or ""))
	local eggCount = buildEggs(Config, eggSystem.EggModels, function(_, info) return info.Rarity == rarity end)
	table.insert(report, eggCount .. " " .. rarity .. " egg models (zone eggs included)")
	local keys = Config.EggsByValue(rarity)
	if #keys > 0 then
		local petKey = Config.Eggs[keys[#keys]].Pets[1].Pet
		local info = Config.Pets[petKey]
		local bosses = ServerStorage:WaitForChild("ZoneBosses")
		local old = bosses:FindFirstChild("Mesh_" .. petKey)
		if old then old:Destroy() end
		local model, height = wrap(kit, info.Model or petKey, "Mesh_" .. petKey, 20, 42, 3)
		if model then
			if info.Angel then angelize(model, height, info.AngelColor) end
			if info.Galaxy then galaxify(model, height) end
			if info.Phantom then phantomize(model, height) end
			model.PrimaryPart.PivotOffset = CFrame.new(0, -height / 2, 0)
			model:SetAttribute("Rig", "Mesh")
			model.Parent = bosses
			table.insert(report, "zone guardian Mesh_" .. petKey)
		end
	end
	return table.concat(report, "\n")
end

return function(Config, only)
	if type(only) == "string" and string.sub(only, 1, 7) == "Rarity:" then return buildRarity(Config, string.sub(only, 8)) end
	local kit = ReplicatedStorage.AnimalKit.Models
	local eggSystem = ReplicatedStorage.EggSystem
	local removed = ServerStorage:FindFirstChild("Removed_OldAnimals")
	if not removed then
		removed = Instance.new("Folder")
		removed.Name = "Removed_OldAnimals"
		removed.Parent = ServerStorage
	end
	local report = {}

	if only ~= "Eggs" then
	-- 1. animaux
	local pets = replaceFolder(eggSystem, "Pets", removed)
	local missing = {}
	local count = 0
	for key, info in Config.Pets do
		local kitName = info.Model or key -- Model : un animal qui réutilise le modèle d'un autre (les animaux ange de la boutique)
		local h = kit:FindFirstChild(kitName) and kit[kitName]:GetAttribute("Height")
		if h then
			local model, height = wrap(kit, kitName, key, math.clamp(1.7 + 0.95 * math.log(1 + h), 2.3, 5.5), 8)
			if info.Angel then angelize(model, height, info.AngelColor) end
			if info.Galaxy then galaxify(model, height) end
			if info.Phantom then phantomize(model, height) end
			model.Parent = pets
			count += 1
		else
			table.insert(missing, key)
		end
		if count % 10 == 0 then task.wait() end
	end
	pets.Parent = eggSystem
	table.insert(report, count .. " pet models" .. (#missing > 0 and (" | NOT IN KIT: " .. table.concat(missing, ", ")) or ""))

	end

	-- 2. œufs
	local eggs = replaceFolder(eggSystem, "EggModels", removed)
	local eggCount = buildEggs(Config, eggs)
	eggs.Parent = eggSystem
	table.insert(report, eggCount .. " egg models")
	if only == "Eggs" then return table.concat(report, "\n") end

	-- 3. gardiens des zones : le meilleur animal de chaque rareté, en géant (la zone Prismatic garde le Pumpking)
	local bosses = ServerStorage:WaitForChild("ZoneBosses")
	for _, old in bosses:GetChildren() do if string.sub(old.Name, 1, 5) == "Mesh_" then old:Destroy() end end
	local BOSSES = {}
	for _, rarity in Config.Rarities do
		local keys = Config.EggsByValue(rarity)
		if #keys > 0 then table.insert(BOSSES, Config.Eggs[keys[#keys]].Pets[1].Pet) end
	end
	for _, petKey in BOSSES do
		local info = Config.Pets[petKey]
		local kitName = info.Model or petKey
		local model, height = wrap(kit, kitName, "Mesh_" .. petKey, 20, 42, 3)
		if model then
			if info.Angel then angelize(model, height, info.AngelColor) end
			if info.Galaxy then galaxify(model, height) end
			if info.Phantom then phantomize(model, height) end
			model.PrimaryPart.PivotOffset = CFrame.new(0, -height / 2, 0) -- le serveur pose le gardien par son pivot : au sol
			model:SetAttribute("Rig", "Mesh") -- pas le squelette en blocs de ZoneBossClient
			model.Parent = bosses
		else
			table.insert(report, "boss model missing: " .. petKey)
		end
	end
	table.insert(report, #BOSSES .. " zone guardians")
	return table.concat(report, "\n")
end
