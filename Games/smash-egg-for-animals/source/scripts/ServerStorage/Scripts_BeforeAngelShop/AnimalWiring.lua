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
	for key in Config.Pets do
		local h = kit:FindFirstChild(key) and kit[key]:GetAttribute("Height")
		if h then
			local model = wrap(kit, key, key, math.clamp(1.7 + 0.95 * math.log(1 + h), 2.3, 5.5), 8)
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
	for _, kitName in BOSSES do
		local old = bosses:FindFirstChild("Mesh_" .. kitName)
		if old then old:Destroy() end
		local model, height = wrap(kit, kitName, "Mesh_" .. kitName, 20, 42, 3)
		if model then
			model.PrimaryPart.PivotOffset = CFrame.new(0, -height / 2, 0) -- le serveur pose le gardien par son pivot : au sol
			model:SetAttribute("Rig", "Mesh") -- pas le squelette en blocs de ZoneBossClient
			model.Parent = bosses
		else
			table.insert(report, "boss model missing: " .. kitName)
		end
	end
	table.insert(report, #BOSSES .. " zone guardians")
	return table.concat(report, "\n")
end
