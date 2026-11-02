-- Fabrique, à partir de ReplicatedStorage.AnimalKit.Models, tout ce que le jeu utilise comme animaux :
--   EggSystem.Pets       : un modèle par animal de EggConfig.Pets (racine "Root" invisible + mesh "Body" soudé, l'avant en +Z)
--   EggSystem.EggModels  : un œuf par entrée de EggConfig.Eggs (coquille aux couleurs de l'œuf)
--   ServerStorage.ZoneBosses.Mesh_<Animal> : les gardiens géants des zones
-- Les anciens modèles sont rangés dans ServerStorage.Removed_OldAnimals. return function(Config) -> rapport. Peut être relancé.
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
-- Le mesh devient blanc uni, une auréole de blocs lumineux tourne au-dessus de la tête, et ceux qui n'ont pas d'ailes
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
	local surface = body:FindFirstChildOfClass("SurfaceAppearance")
	if surface then surface:Destroy() end
	body.Color = color or Color3.fromRGB(244, 240, 228) -- blanc cassé : les ombres dessinent encore les formes (AngelColor dans EggConfig pour une autre teinte)
	body.Material = Enum.Material.SmoothPlastic
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

local function replaceFolder(parent, name, removed)
	local old = parent:FindFirstChild(name)
	if old then
		if removed:FindFirstChild(name) then old:Destroy() else old.Parent = removed end -- la première fois : les anciens modèles sont gardés
	end
	local folder = Instance.new("Folder")
	folder.Name = name
	return folder
end

return function(Config)
	local kit = ReplicatedStorage.AnimalKit.Models
	local eggSystem = ReplicatedStorage.EggSystem
	local removed = ServerStorage:FindFirstChild("Removed_OldAnimals")
	if not removed then
		removed = Instance.new("Folder")
		removed.Name = "Removed_OldAnimals"
		removed.Parent = ServerStorage
	end
	local report = {}

	-- œuf de base : un ancien œuf dont on enlève le visage de l'animal
	local baseEgg = (removed:FindFirstChild("EggModels") or eggSystem.EggModels):FindFirstChild("ChickenEgg")
	assert(baseEgg, "ChickenEgg (base egg model) not found")
	baseEgg = baseEgg:Clone()
	local shell = {} -- couleurs de la coquille de l'œuf de base, de la plus présente à la moins présente
	do
		local counts = {}
		for _, p in baseEgg:GetDescendants() do
			if p:IsA("BasePart") and p.Name == "Decor" then p:Destroy()
			elseif p:IsA("BasePart") and p.Name == "Stud" then counts[p.Color:ToHex()] = (counts[p.Color:ToHex()] or 0) + 1 end
		end
		for hex in counts do table.insert(shell, hex) end
		table.sort(shell, function(a, b) return counts[a] > counts[b] end)
		-- anti-lag : 220 œufs sont dans le monde en même temps. On ne garde que les 28 plus grosses pièces du nid, et rien ne projette d'ombre.
		local nest = {}
		for _, p in baseEgg:GetDescendants() do
			if p:IsA("BasePart") then
				p.CastShadow = false
				if p.Name == "Nest" then table.insert(nest, p) end
			end
		end
		table.sort(nest, function(a, b) return a.Size.X * a.Size.Y * a.Size.Z > b.Size.X * b.Size.Y * b.Size.Z end)
		for i = 29, #nest do nest[i]:Destroy() end
	end

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
			model.Parent = pets
			count += 1
		else
			table.insert(missing, key)
		end
		if count % 10 == 0 then task.wait() end
	end
	pets.Parent = eggSystem
	table.insert(report, count .. " pet models" .. (#missing > 0 and (" | NOT IN KIT: " .. table.concat(missing, ", ")) or ""))

	-- 2. œufs
	local eggs = replaceFolder(eggSystem, "EggModels", removed)
	count = 0
	for key, info in Config.Eggs do
		local egg = baseEgg:Clone()
		egg.Name = key
		local rank = Config.RarityRank[info.Rarity] or 1
		for _, p in egg:GetDescendants() do
			if p:IsA("BasePart") and p.Name == "Stud" then
				local index = table.find(shell, p.Color:ToHex()) or 1
				p.Color = info.Colors[math.min(index, 3)]
				if index >= 3 and rank >= 8 then p.Material = Enum.Material.Neon end -- les œufs des quatre dernières zones ont des taches lumineuses
			end
		end
		if info.Angel then angelEgg(egg) end
		egg.Parent = eggs
		count += 1
		if count % 10 == 0 then task.wait() end
	end
	eggs.Parent = eggSystem
	table.insert(report, count .. " egg models")

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
