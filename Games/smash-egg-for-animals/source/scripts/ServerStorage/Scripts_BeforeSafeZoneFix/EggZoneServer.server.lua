-- Zones d'oeufs : des oeufs apparaissent dans une zone, le joueur les attrape avec son dragon (ProximityPrompt)
-- et doit les ramener dans la zone sûre pour les gagner. Dès qu'un oeuf est pris, un autre apparaît.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local eggSystem = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(eggSystem:WaitForChild("EggConfig"))
local eggTemplates = eggSystem:WaitForChild("EggModels")
local notifyRemote = eggSystem:WaitForChild("Remotes"):WaitForChild("Notify")
local UpgradeConfig = require(ReplicatedStorage:WaitForChild("DragonSystem"):WaitForChild("UpgradeConfig"))
local giveZoneEgg = ServerStorage:WaitForChild("GameBindables"):WaitForChild("GiveZoneEgg")

-- une zone = une pièce du Workspace + la rareté des oeufs qui y apparaissent
local ZONES = {
	{Part = "common egg zone", Burn = 5, Rarity = "Common", Count = 20},
	{Part = "UNcommon egg zone", Burn = 10, Rarity = "Uncommon", Count = 20},
	{Part = "RARE egg zone", Burn = 20, Rarity = "Rare", Count = 20},
	{Part = "EPIC egg zone", Burn = 40, Rarity = "Epic", Count = 20},
	{Part = "LEGENDARY egg zone", Burn = 60, Rarity = "Legendary", Count = 20},
	{Part = "MYTHIC egg zone", Burn = 100, Rarity = "Mythic", Count = 20},
	{Part = "SECRET egg zone", Burn = 150, Rarity = "Secret", Count = 20},
	{Part = "ANCIENT dino egg zone", Burn = 200, Rarity = "Ancient", Theme = "dino", Count = 20},
	{Part = "OG candy egg zone", Burn = 250, Rarity = "OG", Theme = "candy", Count = 20},
	{Part = "DIVINE angel egg zone", Burn = 300, Rarity = "Divine", Theme = "angel", Count = 20},
	-- zone Halloween, tout au fond : les œufs Prismatic (les plus rares du jeu), gardés par le boss Pumpking
	{Part = "Halloween demon egg zone", Burn = 350, Rarity = "Prismatic", Theme = "halloween", Count = 20},
	-- zone Galaxy, la 12e (après Halloween) : œufs Galactic, gardés par la Galaxy Mosasaurus géante (ServerStorage.GalaxyZoneBuilder)
	{Part = "GALACTIC galaxy egg zone", Burn = 400, Rarity = "Galactic", Theme = "galaxy", Count = 20},
}
-- les zones peuvent être renommées dans le Workspace ("common FOREST egg zone"...) : on les retrouve par leur premier mot (la rareté)
local function resolveZoneName(name)
	if workspace:FindFirstChild(name) then return name end
	local keyword = string.lower(string.match(name, "^(%a+)") or name)
	for _, child in workspace:GetChildren() do
		local lower = string.lower(child.Name)
		if child:IsA("BasePart") and string.find(lower, "egg zone", 1, true) and string.sub(lower, 1, #keyword) == keyword then return child.Name end
	end
	return name
end
for _, zone in ZONES do zone.Part = resolveZoneName(zone.Part) end
local SAFE_ZONE = "safe zone"
-- points de vie d'un œuf normal de chaque zone, dans l'ordre des zones (un coup de marteau de base en enlève 1) ;
-- un œuf géant en a plus, en proportion de sa taille
local ZONE_HP = {5, 50, 500, 5000, 50000, 500000, 5000000, 50000000, 500000000, 5000000000, 50000000000, 500000000000}
for index, zone in ZONES do zone.Hp = zone.Hp or ZONE_HP[index] or ZONE_HP[#ZONE_HP] end
-- marteau demandé et speed conseillé de chaque zone (EggConfig.ZoneHammer / ZoneSpeed)
local HammerConfig = require(ReplicatedStorage:WaitForChild("HammerSystem"):WaitForChild("HammerConfig"))
for _, zone in ZONES do
	zone.Hammer = Config.ZoneHammer(zone.Rarity)
	zone.Speed = Config.ZoneSpeed[zone.Rarity] or 0
end
local hammerWarned = {}
local HIT_COOLDOWN = 0.35   -- secondes entre deux coups de marteau d'un même joueur
local HIT_REACH = 10        -- distance max entre le joueur et le bord de l'œuf
local DROPPED_LIFETIME = 120     -- secondes avant qu'un œuf lâché au sol disparaisse
local RESPAWN_DELAY = 5          -- secondes avant qu'un nouvel oeuf remplace celui qui a été cassé ou pris
local PLAYER_HEIGHT = 5
local EGG_UNIT_HEIGHT = 13       -- hauteur de la coquille d'un modèle d'oeuf à l'échelle 1
local NORMAL_HEIGHT = {2.2, 3.6} -- hauteur habituelle d'un oeuf (studs) : sert au calcul du poids et des PV
local EGG_VISUAL = 2 / 1.2       -- les œufs des zones sont AFFICHÉS ~1,67 fois plus grands (2x, puis réduits de 1,2) ;
                                 -- le poids, les PV et la lenteur quand on le porte suivent toujours la taille de calcul
-- oeufs géants : Chance en %, hauteur en "fois la taille d'un joueur". Le plus rare fait 50 fois le joueur.
local SIZE_TIERS = {
	{Chance = 0.0001, Min = 50, Max = 50, Kg = {1000000, 1500000}}, -- plus d'un million de kilos : presque impossible
	{Chance = 0.0005, Min = 50, Max = 50}, -- nerf x6 : 0.003 -> 0.0005
	{Chance = 0.0017, Min = 18, Max = 30},  -- 0.01 -> 0.0017
	{Chance = 0.007, Min = 8, Max = 15},    -- 0.04 -> 0.007
	{Chance = 0.025, Min = 3.5, Max = 6},   -- 0.15 -> 0.025
	{Chance = 0.13, Min = 1.4, Max = 2.4},  -- 0.8 -> 0.13
}
local KG_PER_SIZE = Config.SizeStepKg -- kilos par "taille d'oeuf normal" en plus : l'oeuf posé et l'animal auront la même taille que l'oeuf trouvé
local CARRIED_HEIGHT = 2.4       -- taille d'un oeuf posé sur le dos du dragon
local CARRY_SPOTS = {Vector3.new(0, 0.3, -0.3), Vector3.new(-0.16, 0.27, -0.42), Vector3.new(0.16, 0.27, -0.42)} -- position par rapport au centre du corps, en fraction de la hauteur du dragon (derrière la selle)

local folder = Instance.new("Folder")
folder.Name = "ZoneEggs"
folder.Parent = workspace
local carried = {} -- [player] = {{Key, Kg, Visual?}, ...}

local function notify(player, text) notifyRemote:FireClient(player, text) end

-- les oeufs d'une rareté, du moins bon au meilleur (même ordre que les chances de Config.SpawnChances)
local function eggKeysOf(rarity)
	return Config.EggsByValue(rarity)
end

-- evenement "x4 LUCK" : multiplicateur pose par LuckEventServer (1 = normal)
local function luck()
	local value = ReplicatedStorage:GetAttribute("LuckMultiplier")
	return type(value) == "number" and math.max(value, 1) or 1
end

local function rollHeight()
	local roll = math.random() * 100
	for _, tier in SIZE_TIERS do
		roll -= tier.Chance * luck()
		if roll <= 0 then -- (deuxième valeur : le poids imposé par ce palier, s'il en a un)
			return (tier.Min + math.random() * (tier.Max - tier.Min)) * PLAYER_HEIGHT, tier.Kg and (tier.Kg[1] + math.random() * (tier.Kg[2] - tier.Kg[1])) or nil
		end
	end
	return NORMAL_HEIGHT[1] + math.random() * (NORMAL_HEIGHT[2] - NORMAL_HEIGHT[1])
end

-- plus de dragon : le joueur porte lui-même ce qu'il ramène. Son personnage tient le rôle du porteur dans tout ce script
-- (la variable s'appelle encore `dragon` plus bas).
local function personalDragon(player)
	local character = player.Character
	return character and character.PrimaryPart and character or nil
end

local function setCarrying(player)
	player:SetAttribute("Carrying", #(carried[player] or {}))
	local zones = "|" -- zones d'où viennent les œufs portés : seul le gardien de ces zones poursuit le joueur
	for _, entry in carried[player] or {} do
		if entry.Zone then zones ..= entry.Zone.Part .. "|" end
	end
	player:SetAttribute("CarryZones", zones)
	-- un œuf géant porté en taille réelle cacherait la caméra : on la recule selon le plus gros œuf porté
	local biggest = 0
	for _, entry in carried[player] or {} do
		biggest = math.max(biggest, entry.Height or 0)
	end
	player:SetAttribute("CarrySize", biggest)
	-- animal de plus de 100 000 kg sur la tête : on court 1,25 fois moins vite (SpeedServer)
	local heavy = false
	for _, entry in carried[player] or {} do
		if (entry.PetKg or 0) > 100000 then heavy = true end
	end
	player:SetAttribute("CarryHeavy", heavy or nil)
	-- l'animal du dessus de la pile (celui que le bouton DROP lâchera) : affiché sur le bouton côté client
	local list = carried[player] or {}
	local top = list[#list]
	player:SetAttribute("CarryPet", top and top.Pet or nil)
	player:SetAttribute("CarryPetKg", top and top.PetKg or nil)
end

-- petit oeuf posé sur le dos du dragon
local petTemplates = eggSystem:WaitForChild("Pets")

-- où se tient le n-ième animal porté : au-dessus de la tête du joueur, empilés
local function seatCFrame(dragon, index, ground)
	return dragon.PrimaryPart.CFrame * CFrame.new(0, 3.2 + ground + (index - 1) * 3, 0)
end

-- animal ensorcelé : chapeau de sorcière posé sur lui, étincelles violettes et lueur
local TraitDeco = require(ReplicatedStorage.EggSystem:WaitForChild("TraitDeco"))
local function witchDeco(visual)
	local root = visual.PrimaryPart
	if not root or visual:FindFirstChild("WitchHat") then return end
	local cf, size = visual:GetBoundingBox()
	local w = math.max(math.min(size.X * 0.62, size.Z * 0.62, size.Y * 0.5), 0.5) -- jamais plus gros que l'animal
	local violet = Color3.fromRGB(190, 95, 255)
	require(ReplicatedStorage.EggSystem.TraitDeco).Hat(visual, "Witch", {Name = "WitchHat"}) -- sur la tête, soudé à elle
	local emitter = Instance.new("ParticleEmitter")
	emitter.Name = "WitchSparkles"
	emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	emitter.Color = ColorSequence.new(Color3.fromRGB(225, 150, 255), Color3.fromRGB(120, 50, 230))
	emitter.LightEmission = 0.8
	emitter.Rate = 14
	emitter.Lifetime = NumberRange.new(0.9, 1.6)
	emitter.Speed = NumberRange.new(size.Y * 0.25, size.Y * 0.6)
	emitter.SpreadAngle = Vector2.new(180, 180)
	emitter.Acceleration = Vector3.new(0, size.Y * 0.5, 0)
	emitter.Rotation = NumberRange.new(0, 360)
	emitter.RotSpeed = NumberRange.new(-90, 90)
	emitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.25, w * 0.45), NumberSequenceKeypoint.new(1, 0)})
	emitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1)})
	emitter.Parent = root
	local light = Instance.new("PointLight")
	light.Name = "WitchGlow"
	light.Color = violet
	light.Range = math.clamp(size.Magnitude * 1.5, 8, 60)
	light.Brightness = 1.6
	light.Parent = root
end

-- copie de l'animal à la taille de son poids (limitée pour tenir sur le dragon) ; renvoie le modèle et sa hauteur au sol
local function petVisual(entry, dragon)
	local template = petTemplates:FindFirstChild(entry.Pet or "")
	local info = Config.Pets[entry.Pet or ""]
	if not template or not info then return nil end
	local unit = (dragon:GetAttribute("Height") or 8.8) / 8.8
	local size = math.min(Config.SizeScale(entry.PetKg or info.Kg, info.Kg) * Config.PetSize, 3.2 * unit)
	local visual = template:Clone()
	visual.Name = "CarriedPet"
	visual:ScaleTo(visual:GetScale() * size)
	for _, part in visual:GetDescendants() do
		if part:IsA("BasePart") then
			part.Massless = true
			part.CanCollide, part.CanQuery, part.CanTouch = false, false, false
		end
	end
	if entry.Witch then witchDeco(visual) end
	if entry.Concert then pcall(TraitDeco.MutationFx, visual, entry.Concert) end
	return visual, (visual:GetAttribute("GroundOffset") or 1) * size
end

-- l'animal éclos est assis sur la queue du dragon
local function attachVisual(player, entry, index)
	local dragon = personalDragon(player)
	if not dragon or not dragon.PrimaryPart then return end
	local visual, ground = petVisual(entry, dragon)
	if not visual then return end
	visual:PivotTo(seatCFrame(dragon, index, ground))
	local petRoot = visual.PrimaryPart
	petRoot.Anchored = false
	local weld = Instance.new("WeldConstraint")
	weld.Part0, weld.Part1 = dragon.PrimaryPart, petRoot
	weld.Parent = petRoot
	visual.Parent = dragon
	entry.Visual = visual
end

local spawnEgg
local zoneBanner

local function grab(player, egg, zone)
	if not egg.Parent then return end
	local dragon = personalDragon(player)
	if not dragon then return end
	-- il faut être posé au sol à côté de l'œuf pour le ramasser
	local root = dragon.PrimaryPart
	if not root then return end
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {workspace:FindFirstChild("ZoneEggs"), player.Character}
	local reach = (dragon:GetAttribute("GroundOffset") or 3) + 3.5
	if not workspace:Raycast(root.Position, Vector3.new(0, -reach, 0), params) then
		notify(player, "Stand next to the egg to grab it!")
		return
	end
	local list = carried[player] or {}
	carried[player] = list
	local capacity = UpgradeConfig.Value(player, "Carry")
	if #list >= capacity then
		notify(player, "You can only carry " .. capacity .. (capacity == 1 and " egg" or " eggs") .. "! Bring them to the safe zone first.")
		return
	end
	local entry = {Key = egg:GetAttribute("EggKey"), Kg = egg:GetAttribute("Kg"), Height = egg:GetAttribute("BaseHeight") or egg:GetAttribute("Height"), Zone = zone}
	local wasDropped = egg:GetAttribute("Dropped")
	egg:Destroy()
	table.insert(list, entry)
	attachVisual(player, entry, #list)
	setCarrying(player)
	notify(player, "Egg grabbed! Run back to the safe zone to keep it.")
	ServerStorage.GameBindables.EggGrabbed:Fire(player, zone.Part) -- le gardien de la zone se met en chasse
	if not wasDropped then task.delay(RESPAWN_DELAY, spawnEgg, zone) end -- un œuf lâché puis repris n'en fait pas réapparaître un autre
end

-- oeuf lance par l'admin : un timer s'affiche au-dessus ; si personne ne l'a fait eclore a temps, il disparait
local function adminTimer(egg, height, lifetime)
	egg:SetAttribute("Dropped", true) -- pas de remplacement automatique : cet oeuf s'ajoute a ceux de la zone
	egg:SetAttribute("AdminEgg", true)
	local root = egg.PrimaryPart
	if not root then return end
	local deadline = os.clock() + lifetime

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "AdminTimer"
	billboard.Size = UDim2.new(8 + height * 0.5, 0, 2.6 + height * 0.2, 0)
	billboard.StudsOffsetWorldSpace = Vector3.new(0, height / 2 + 8 + height * 0.6, 0)
	billboard.AlwaysOnTop = false -- on ne le voit plus à travers toute la carte
	billboard.MaxDistance = 600
	billboard.LightInfluence = 0
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 1)
	label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	label.TextScaled = true
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Text = ""
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 3
	stroke.Color = Color3.new(0, 0, 0)
	stroke.Parent = label
	game:GetService("CollectionService"):AddTag(label, "Text3D")
	label.Parent = billboard
	billboard.Parent = root

	task.spawn(function()
		while egg.Parent and not egg:GetAttribute("Hatching") do
			local left = deadline - os.clock()
			if left <= 0 then
				egg:Destroy() -- personne ne l'a pris : il disparait
				return
			end
			local secs = math.ceil(left)
			label.Text = string.format("%d:%02d", math.floor(secs / 60), secs % 60)
			label.TextColor3 = secs <= 10 and Color3.fromRGB(255, 90, 70) or Color3.new(1, 1, 1)
			task.wait(0.25)
		end
	end)
end

-- tire un oeuf parmi ceux d'une rareté : le premier a 60 % de chance, le meilleur 1 % (Config.SpawnChances).
-- Pendant un event de chance, tous les oeufs sauf le premier voient leur chance multipliée.
local function pickKey(keys)
	local first = Config.Eggs[keys[1] ]
	if first and first.SpawnWeight then
		local chances = {}
		for i, key in keys do chances[i] = Config.Eggs[key].SpawnWeight or 0 end
		local L = luck()
		local total = 0
		for i in keys do total += chances[i] * (i > 1 and L or 1) end
		local roll = math.random() * total
		for i, key in keys do
			roll -= chances[i] * (i > 1 and L or 1)
			if roll <= 0 then return key end
		end
		return keys[1]
	end
	local chances = Config.SpawnChancesFor(#keys)
	local L = luck()
	local total = 0
	for i in keys do total += chances[i] * (i > 1 and L or 1) end
	local roll = math.random() * total
	for i, key in keys do
		roll -= chances[i] * (i > 1 and L or 1)
		if roll <= 0 then return key end
	end
	return keys[1]
end

-- forced = {Key, Height, Kg, Position} : repose un œuf précis à un endroit précis (œuf lâché par un joueur)
local ZONE_RARITY_COLORS = {Common = Color3.fromRGB(236, 236, 240), Uncommon = Color3.fromRGB(120, 230, 110), Rare = Color3.fromRGB(90, 160, 255), Epic = Color3.fromRGB(200, 110, 255)}
function spawnEgg(zone, forced, admin)
	local part = workspace:FindFirstChild(zone.Part)
	if not part then return end
	local key = (forced and forced.Key) or (admin and admin.Key)
	if not key then
		if zone.SpawnPool then
			local L = luck()
			local total = 0
			for i, entry in zone.SpawnPool do total += entry.Chance * (i > 1 and L or 1) end
			local roll = math.random() * total
			local accumulated = 0
			local chosenKeys = zone.Keys
			for i, entry in zone.SpawnPool do
				accumulated += entry.Chance * (i > 1 and L or 1)
				if roll <= accumulated and #entry.Keys > 0 then
					chosenKeys = entry.Keys
					break
				end
			end
			key = pickKey(chosenKeys)
		else
			key = pickKey(zone.Keys)
		end
	end
	local info, template = Config.Eggs[key], eggTemplates:FindFirstChild(key)
	if not template or not info then return end
	local height, giantKg
	if forced then height = forced.Height else height, giantKg = rollHeight() end -- (forced.Height = taille de calcul, attribut BaseHeight)
	-- œuf admin avec un poids choisi : sa taille suit le poids (sinon tirage classique)
	local adminKg = admin and tonumber(admin.Kg)
	if adminKg and adminKg > 0 then
		height = math.clamp((1 + math.max(0, adminKg - info.Kg) / KG_PER_SIZE) * ((NORMAL_HEIGHT[1] + NORMAL_HEIGHT[2]) / 2), NORMAL_HEIGHT[1], 50 * PLAYER_HEIGHT)
	else
		adminKg = nil
	end
	local shown = height * EGG_VISUAL -- taille affichée
	local scale = shown / EGG_UNIT_HEIGHT
	local half = part.Size / 2
	local margin = math.min(half.X, half.Z, shown * 0.6 + 4)
	local x = part.Position.X + (math.random() * 2 - 1) * (half.X - margin)
	local z = part.Position.Z + (math.random() * 2 - 1) * (half.Z - margin)
	local floorY = part.Position.Y + half.Y
	if forced then x, floorY, z = forced.Position.X, forced.Position.Y, forced.Position.Z end
	local egg = template:Clone()
	-- l'œuf arrive en entier chez les joueurs (sinon, en streaming, un gros œuf peut arriver en morceaux sans sa pièce
	-- centrale : le marteau ne le trouve plus et on ne peut pas le taper)
	egg.ModelStreamingMode = Enum.ModelStreamingMode.Atomic
	egg.Name = key
	egg:ScaleTo(scale)
	egg:PivotTo(CFrame.new(x, floorY + shown / 2, z) * CFrame.Angles(0, math.random() * math.pi * 2, 0))
	for _, d in egg:GetDescendants() do
		if d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide, d.CanTouch = false, false -- on passe à travers les œufs
			d.CanQuery = true
		end
	end
	local sizes = height / ((NORMAL_HEIGHT[1] + NORMAL_HEIGHT[2]) / 2)
	-- poids : le poids de base (jamais moins), et pour les œufs géants les kilos de leur taille
	local kg = info.Kg * (1 + math.random() * 0.3) + (height > NORMAL_HEIGHT[2] and math.max(0, sizes - 1) * KG_PER_SIZE or 0)
	if giantKg then kg = giantKg end
	if forced then kg = forced.Kg end
	if adminKg then kg = adminKg end
	kg = math.min(kg, Config.MaxKg or 1e6) -- jamais plus de 1M kg
	egg:SetAttribute("EggKey", key)
	egg:SetAttribute("Kg", kg)
	egg:SetAttribute("Height", shown)       -- taille affichée (effets, étiquettes)
	egg:SetAttribute("BaseHeight", height)  -- taille de calcul (poids, PV, lenteur quand on le porte)
	-- PV : ceux des œufs de la zone OÙ il apparaît (un œuf Royal Halloween posé dans la Forest a les PV d'un œuf royal de la Forest,
	-- pas 1T), puis plus il est gros / lourd, plus il en a
	local baseHp = info.Hp or zone.Hp or 5
	if info.Rarity ~= zone.Rarity and Config.ZoneEggHp[zone.Rarity] then
		baseHp = Config.ZoneEggHp[zone.Rarity][info.Royal and 2 or 1]
	end
	local maxHp = math.max(1, math.floor(baseHp * math.clamp(height / NORMAL_HEIGHT[2], 1, 12) + 0.5))
	egg:SetAttribute("MaxHp", maxHp)
	egg:SetAttribute("Hp", maxHp)

	local root = egg.PrimaryPart
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "EggLabel"
	billboard.Size = UDim2.new(6.5 + height * 0.65, 0, 3 + height * 0.3, 0)
	billboard.StudsOffsetWorldSpace = Vector3.new(0, shown * 0.98 + 1.5, 0) -- au-dessus de la pointe de l'œuf
	billboard.MaxDistance = 120 + shown * 6
	billboard.LightInfluence = 0
	local function text(str, pos, size, color)
		local label = Instance.new("TextLabel")
		label.BackgroundTransparency = 1
		label.Position, label.Size = pos, size
		label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
		label.Text = str
		label.TextScaled = true
		label.TextColor3 = color
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 2
		stroke.Color = Color3.new(0, 0, 0)
		stroke.Thickness = 3
		stroke.Parent = label
		game:GetService("CollectionService"):AddTag(label, "Text3D") -- texte en relief
		label.Parent = billboard
		return label
	end
	if info.ZoneEgg then
		-- œuf de zone : son nom, et sa rareté juste en dessous (dans la couleur de la rareté)
		local nameLabel = text(info.Name, UDim2.fromScale(0, 0), UDim2.fromScale(1, 0.42), info.Royal and Color3.fromRGB(255, 225, 110) or Color3.new(1, 1, 1))
		local rarityLabel = text(info.Rarity .. (kg > info.Kg * 2 and ("  ·  " .. Config.FormatKg(kg)) or ""), UDim2.fromScale(0.1, 0.42), UDim2.fromScale(0.8, 0.27), Color3.new(1, 1, 1))
		local gradient = Config.Gradients[info.Rarity]
		if gradient then
			local g = Instance.new("UIGradient") g.Color = gradient g.Parent = rarityLabel
			game:GetService("CollectionService"):AddTag(g, "AnimatedGradient")
		else
			rarityLabel.TextColor3 = ZONE_RARITY_COLORS[info.Rarity] or Color3.new(1, 1, 1)
		end
	else
		text(string.upper(info.Rarity) .. " · " .. info.Name, UDim2.fromScale(0, 0), UDim2.fromScale(1, 0.4), Color3.new(1, 1, 1)) -- rareté + nom
		local chance = Config.SpawnChanceOf(key) -- chance d'apparition de cet oeuf parmi ceux de sa rareté
		egg:SetAttribute("SpawnChance", chance)
		text(Config.FormatKg(kg) .. (chance and ("  ·  " .. Config.FormatChance(chance)) or ""), UDim2.fromScale(0, 0.4), UDim2.fromScale(1, 0.27), kg > info.Kg * 2 and Color3.fromRGB(255, 220, 90) or Color3.fromRGB(200, 235, 255))
	end
	billboard.Parent = root

	local prompt = Instance.new("ProximityPrompt")
	prompt.Name = "GrabEggPrompt"
	prompt.ActionText = "Grab"
	prompt.ObjectText = info.Name
	prompt.HoldDuration = 0.2
	prompt.RequiresLineOfSight = false
	-- l'invite est au pied de l'œuf, en son centre : il suffit d'être à côté de l'œuf, quelle que soit sa taille
	local extents = egg:GetExtentsSize()
	local radius = math.max(extents.X, extents.Z) / 2
	-- HITBOX : la vraie largeur de l'œuf, mesurée UNE fois ici. On ne remesure plus le modèle ensuite : l'icône 3D d'une
	-- mutation (modèle dans un ViewportFrame de l'étiquette, posé près du centre du monde) le faisait passer pour un œuf de
	-- plusieurs centaines de studs, et le marteau tapait cet œuf au lieu de celui d'à côté (HammerClient)
	egg:SetAttribute("HitRadius", radius)
	prompt.MaxActivationDistance = radius + 12 + shown * 0.1
	local foot = Instance.new("Attachment")
	foot.Name = "GrabPoint"
	foot.Parent = root
	foot.WorldPosition = Vector3.new(x, floorY + math.min(shown * 0.25, 4), z)
	prompt.Enabled = false -- on ne ramasse plus les œufs : il faut les casser au marteau
	prompt.Parent = foot
	prompt.Triggered:Connect(function(player) grab(player, egg, zone) end)
	if forced then
		egg:SetAttribute("Dropped", true)
		game:GetService("Debris"):AddItem(egg, DROPPED_LIFETIME) -- un œuf abandonné finit par disparaître
	end
	if admin and admin.Hold then return egg, shown end -- œuf lancé par un admin : il ne sera posé qu'à l'atterrissage (voir SpawnAdminEgg)
	egg.Parent = zone.Folder
	if admin then adminTimer(egg, shown, admin.Lifetime) end
	return egg
end

-- Grande pancarte flottante à l'entrée de chaque zone : nom du lieu, rareté, puissance de brûlure recommandée
local ZONE_THEMES = { -- mot trouvé dans le nom de la pièce -> nom affiché et couleurs ; sinon thème par défaut de la rareté
	forest = {"Forest Zone", Color3.fromRGB(150, 255, 90), Color3.fromRGB(30, 170, 50)},
	jungle = {"Jungle Zone", Color3.fromRGB(190, 255, 110), Color3.fromRGB(0, 170, 110)},
	aquatic = {"Aquatic Zone", Color3.fromRGB(120, 225, 255), Color3.fromRGB(20, 110, 235)},
	ocean = {"Ocean Zone", Color3.fromRGB(120, 225, 255), Color3.fromRGB(20, 110, 235)},
	ice = {"Ice Zone", Color3.fromRGB(235, 250, 255), Color3.fromRGB(110, 190, 255)},
	desert = {"Desert Zone", Color3.fromRGB(255, 236, 130), Color3.fromRGB(245, 160, 30)},
	dessert = {"Desert Zone", Color3.fromRGB(255, 236, 130), Color3.fromRGB(245, 160, 30)},
	lava = {"Lava Zone", Color3.fromRGB(255, 190, 70), Color3.fromRGB(230, 40, 20)},
	crystal = {"Crystal Zone", Color3.fromRGB(255, 190, 245), Color3.fromRGB(170, 110, 255)},
	void = {"Void Zone", Color3.fromRGB(215, 150, 255), Color3.fromRGB(110, 40, 210)},
	demon = {"Demon Zone", Color3.fromRGB(255, 120, 150), Color3.fromRGB(150, 20, 60)},
	meadow = {"Meadow Zone", Color3.fromRGB(215, 255, 120), Color3.fromRGB(90, 190, 40)},
	volcano = {"Volcano Zone", Color3.fromRGB(255, 190, 70), Color3.fromRGB(230, 40, 20)},
	dino = {"Dino Zone", Color3.fromRGB(200, 255, 120), Color3.fromRGB(110, 150, 40)},
	angel = {"Angel Zone", Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 215, 90)},
	snow = {"Snow Zone", Color3.fromRGB(255, 255, 255), Color3.fromRGB(160, 215, 255)},
	candy = {"Candy Zone", Color3.fromRGB(255, 190, 230), Color3.fromRGB(255, 90, 170)},
	galaxy = {"Galaxy Zone", Color3.fromRGB(190, 170, 255), Color3.fromRGB(90, 50, 210)},
	halloween = {"Halloween Zone", Color3.fromRGB(255, 170, 50), Color3.fromRGB(140, 50, 220)},
}
local RARITY_THEME = {Common = "forest", Uncommon = "jungle", Rare = "aquatic", Epic = "ice", Legendary = "desert", Mythic = "lava", Secret = "demon", Ancient = "dino", OG = "candy", Divine = "angel", Prismatic = "halloween", Galactic = "galaxy"}
local RARITY_COLOR = {Common = Color3.fromRGB(190, 250, 40), Uncommon = Color3.fromRGB(40, 240, 150), Rare = Color3.fromRGB(40, 185, 255), Epic = Color3.fromRGB(200, 100, 255),
	Legendary = Color3.fromRGB(255, 225, 40), Mythic = Color3.fromRGB(255, 100, 140), Secret = Color3.fromRGB(200, 200, 215), Ancient = Color3.fromRGB(150, 220, 90), OG = Color3.fromRGB(255, 190, 60), Divine = Color3.fromRGB(255, 240, 170), Prismatic = Color3.fromRGB(255, 120, 220),
	Galactic = Color3.fromRGB(130, 170, 255)}
local FLAME_ICON = "rbxassetid://78970514864199"

function zoneBanner(zone)
	local part = workspace:FindFirstChild(zone.Part)
	if not part then return end
	local theme = zone.Theme and ZONE_THEMES[zone.Theme] -- thème imposé (ex. zone Halloween, dont le nom contient aussi "demon")
	local lower = string.lower(zone.Part)
	if not theme then
		for word, entry in ZONE_THEMES do
			if string.find(lower, word, 1, true) then theme = entry break end
		end
	end
	theme = theme or ZONE_THEMES[RARITY_THEME[zone.Rarity] ] or ZONE_THEMES.forest
	-- le message s'affiche sur l'écran du joueur qui entre dans la zone (script client ZoneBannerGui) : on publie juste les infos
	part:SetAttribute("ZoneTitle", theme[1])
	part:SetAttribute("ZoneColor1", theme[2])
	part:SetAttribute("ZoneColor2", theme[3])
	part:SetAttribute("ZoneRarity", zone.DisplayRarity or zone.Rarity)
	part:SetAttribute("ZoneRarityColor", RARITY_COLOR[zone.DisplayRarity or zone.Rarity] or Color3.new(1, 1, 1))
	part:SetAttribute("ZoneBurn", zone.Burn or 0)
	part:SetAttribute("ZoneHp", zone.Hp or 0)
	part:SetAttribute("ZoneSpeed", zone.Speed or 0)
	part:SetAttribute("ZoneHammer", HammerConfig.Get(zone.Hammer or 1).Name)
	game:GetService("CollectionService"):AddTag(part, "EggZoneArea")
end

local GalacticGate = require(ReplicatedStorage:WaitForChild("GalacticUpdate")) -- update Galactic (admin)
for _, zone in ZONES do
	-- les deux œufs de zone (EggConfig.ZoneEggKeys) ; les anciens œufs (un par animal) n'apparaissent plus dans les zones
	zone.Keys = Config.ZoneEggKeys[zone.Rarity] or eggKeysOf(zone.Rarity)
	if zone.SpawnPool then
		for _, entry in zone.SpawnPool do
			entry.Keys = Config.ZoneEggKeys[entry.Rarity] or eggKeysOf(entry.Rarity)
		end
	end
	zone.Folder = Instance.new("Folder")
	zone.Folder.Name = zone.Part
	zone.Folder.Parent = folder
	if GalacticGate.Hidden(zone.Rarity) then
		-- zone Galaxy : cachée jusqu'à l'update Galactic (panneau admin) ; ses œufs apparaissent à ce moment-là
		GalacticGate.OnRelease(function()
			for _ = 1, 50 do if workspace:FindFirstChild(zone.Part) then break end task.wait(0.1) end
			zoneBanner(zone)
			if workspace:FindFirstChild(zone.Part) and #zone.Keys > 0 then
				for _ = 1, zone.Count do spawnEgg(zone) end
			end
		end)
		continue
	end
	zoneBanner(zone)
	if workspace:FindFirstChild(zone.Part) and #zone.Keys > 0 then
		for _ = 1, zone.Count do spawnEgg(zone) end
	else
		warn("[EggZoneServer] zone introuvable ou sans oeufs : " .. zone.Part)
	end
end

-- nuit : tous les œufs des zones sont remplacés par de nouveaux. Renvoie les œufs spéciaux apparus (géants, ou d'une rareté différente de la zone).
local SECRET_BONUS_CHANCE = 0.1    -- % de chance, à chaque réinitialisation des œufs (la nuit)
local SECRET_BONUS_LIFETIME = 290 -- secondes : il reste jusqu'à la nuit suivante
-- Nuit (NightServer) : ClearEggs efface les œufs des zones dès que la nuit tombe ; ResetEggs(durée) les fait réapparaître
-- petit à petit pendant "durée" secondes (un œuf de plus dans chaque zone à chaque vague) et renvoie les œufs spéciaux apparus.
local function clearZoneEggs()
	for _, zone in ZONES do
		if zone.Folder then
			for _, egg in zone.Folder:GetChildren() do
				if egg:GetAttribute("EggKey") and not egg:GetAttribute("Hatching") and not egg:GetAttribute("AdminEgg") and not egg:GetAttribute("Dropped") then egg:Destroy() end
			end
		end
	end
end
local clearEggs = Instance.new("BindableFunction")
clearEggs.Name = "ClearEggs"
clearEggs.OnInvoke = clearZoneEggs
clearEggs.Parent = ServerStorage:WaitForChild("GameBindables")
local resetEggs = Instance.new("BindableFunction")
resetEggs.Name = "ResetEggs"
resetEggs.OnInvoke = function(duration)
	local specials = {}
	clearZoneEggs()
	local waves = 0
	for _, zone in ZONES do waves = math.max(waves, zone.Count) end
	local pause = (tonumber(duration) or 0) / math.max(waves, 1)
	for wave = 1, waves do
		for _, zone in ZONES do
			local zonePart = workspace:FindFirstChild(zone.Part)
			if zone.Folder and zonePart and #zone.Keys > 0 and wave <= zone.Count then
				local egg = spawnEgg(zone)
				local info = egg and Config.Eggs[egg:GetAttribute("EggKey")]
				if info then
					local giant = (egg:GetAttribute("BaseHeight") or egg:GetAttribute("Height") or 0) >= 3.5 * PLAYER_HEIGHT
					local RANK = Config.RarityRank
					if giant or (RANK[info.Rarity] or 0) > (RANK[zone.Rarity] or 0) then -- seulement ce qui est vraiment rare
						table.insert(specials, {Name = info.Name, Rarity = info.Rarity, Giant = giant, Zone = zonePart:GetAttribute("ZoneTitle") or (zone.Rarity .. " Zone")})
					end
				end
			end
		end
		if pause > 0 then task.wait(pause) end
	end
	-- œuf Secret bonus : à chaque réinitialisation, SECRET_BONUS_CHANCE % de chance qu'un œuf Secret apparaisse dans la zone Secret
	if math.random() * 100 < SECRET_BONUS_CHANCE then
		for _, zone in ZONES do
			local zonePart = workspace:FindFirstChild(zone.Part)
			local keys = eggKeysOf("Secret")
			if zone.Rarity == "Secret" and zonePart and #keys > 0 then
				local egg = spawnEgg(zone, nil, {Key = keys[math.random(#keys)], Lifetime = SECRET_BONUS_LIFETIME})
				local info = egg and Config.Eggs[egg:GetAttribute("EggKey")]
				if info then
					table.insert(specials, 1, {Name = info.Name, Rarity = "Secret", Giant = false, Zone = zonePart:GetAttribute("ZoneTitle") or "Secret Zone"})
				end
			end
		end
	end
	return specials
end
resetEggs.Parent = ServerStorage:WaitForChild("GameBindables")

-- HUGE EGG : toutes les 30 min (NightServer l'appelle pendant la réinitialisation des œufs d'une nuit sur six), un œuf géant de
-- 50 000 kg minimum apparaît dans une zone au hasard. Il reste jusqu'au prochain Huge Egg s'il n'est pas cassé.
local HUGE_MIN_KG = 50000
local HUGE_LIFETIME = 1800
local spawnHuge = ServerStorage:WaitForChild("GameBindables"):FindFirstChild("SpawnHugeEgg") or Instance.new("BindableFunction")
spawnHuge.Name = "SpawnHugeEgg"
spawnHuge.OnInvoke = function()
	local choices = {}
	for _, zone in ZONES do
		if zone.Folder and workspace:FindFirstChild(zone.Part) and #zone.Keys > 0 then table.insert(choices, zone) end
	end
	if #choices == 0 then return nil end
	local zone = choices[math.random(#choices)]
	local kg = math.floor(HUGE_MIN_KG * (1 + math.random()) ) -- 50k à 100k kg
	local egg = spawnEgg(zone, nil, {Key = pickKey(zone.Keys), Lifetime = HUGE_LIFETIME, Kg = kg})
	if not egg then return nil end
	egg:SetAttribute("HugeEgg", true)
	-- grande étiquette dorée au-dessus
	local shown = egg:GetAttribute("Height") or 20
	local tag = Instance.new("BillboardGui")
	tag.Name = "HugeTag"
	tag.Size = UDim2.new(22, 0, 5, 0)
	tag.StudsOffsetWorldSpace = Vector3.new(0, shown * 1.25 + 6, 0)
	tag.LightInfluence, tag.MaxDistance, tag.AlwaysOnTop = 0, 600, true
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 1)
	label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	label.Text = "HUGE EGG!"
	label.TextScaled = true
	label.TextColor3 = Color3.new(1, 1, 1)
	local stroke = Instance.new("UIStroke") stroke.Thickness = 4 stroke.Parent = label
	local grad = Instance.new("UIGradient") grad.Rotation = 90
	grad.Color = ColorSequence.new(Color3.fromRGB(255, 245, 150), Color3.fromRGB(255, 150, 20)) grad.Parent = label
	label.Parent = tag
	tag.Parent = egg.PrimaryPart
	local zonePart = workspace:FindFirstChild(zone.Part)
	return {Name = "HUGE " .. (Config.Eggs[egg:GetAttribute("EggKey")] and Config.Eggs[egg:GetAttribute("EggKey")].Name or "Egg"),
		Zone = zonePart and zonePart:GetAttribute("ZoneTitle") or (zone.Rarity .. " Zone"), Rarity = zone.Rarity, Giant = true, Kg = kg}
end
spawnHuge.Parent = ServerStorage:WaitForChild("GameBindables")

-- dans la zone sûre : les oeufs portés sont gagnés
local function inSafeZone(position)
	local safe = workspace:FindFirstChild(SAFE_ZONE)
	if not safe then return false end
	local rel = safe.CFrame:PointToObjectSpace(position)
	return math.abs(rel.X) <= safe.Size.X / 2 and math.abs(rel.Z) <= safe.Size.Z / 2 and rel.Y >= 0 and rel.Y <= safe.Size.Y / 2 + 60
end

task.spawn(function()
	while true do
		task.wait(0.3)
		for player, list in carried do
			if #list > 0 then
				local dragon = personalDragon(player)
				local root = dragon and dragon.PrimaryPart
				if root and inSafeZone(root.Position) then
					for index = #list, 1, -1 do
						local entry = list[index]
						if ServerStorage.GameBindables.GiveZonePet:Invoke(player, entry.Pet, entry.PetKg, entry.Witch and "Witch" or entry.Cowboy and "Cowboy" or nil, entry.Concert) then
							if entry.Visual then entry.Visual:Destroy() end
							table.remove(list, index)
						end
					end
					setCarrying(player)
				end
			end
		end
	end
end)

-- nouveau dragon (changement à la boutique) : on remet les oeufs portés sur son dos
local function watchDragons(dragons)
	dragons.ChildAdded:Connect(function(dragon)
		task.wait(0.3)
		local owner = Players:GetPlayerByUserId(dragon:GetAttribute("Owner") or 0)
		local list = owner and carried[owner]
		for index, entry in list or {} do attachVisual(owner, entry, index) end
	end)
end
if workspace:FindFirstChild("Dragons") then watchDragons(workspace.Dragons) end
workspace.ChildAdded:Connect(function(child) if child.Name == "Dragons" then watchDragons(child) end end)

-- mort ou départ : les oeufs portés sont perdus
local function clear(player)
	for _, entry in carried[player] or {} do
		if entry.Visual then entry.Visual:Destroy() end
	end
	carried[player] = nil
end
local function onPlayer(player)
	setCarrying(player)
	player.CharacterAdded:Connect(function(character)
		character:WaitForChild("Humanoid").Died:Connect(function()
			local had = #(carried[player] or {})
			clear(player)
			setCarrying(player)
			if had > 0 then notify(player, "You lost the eggs you were carrying!") end
		end)
	end)
end
Players.PlayerAdded:Connect(onPlayer)
for _, player in Players:GetPlayers() do onPlayer(player) end
Players.PlayerRemoving:Connect(clear)

-- touché par le gardien d'une zone : les œufs portés sont perdus
ServerStorage:WaitForChild("GameBindables"):WaitForChild("DropCarried").Event:Connect(function(player)
	clear(player)
	setCarrying(player)
end)

-- bouton DROP : le joueur lâche l'animal du dessus de la pile. Il est posé au sol devant lui, y reste (le gardien ne le
-- reprend pas : on ne le porte plus) et peut être repris avec l'invite Grab. (défini plus bas, après placePet)
local dropCarried

---------------------------------------------------------------- Casser un œuf au marteau : chaque coup lui enlève des points de vie ; à zéro il éclot
local BURN_TIME = UpgradeConfig.BurnTime or 3
local burnRemote = eggSystem:WaitForChild("Remotes"):WaitForChild("BurnEgg")
local burning = {}  -- [egg] = {Player, Time, Last}
local warned = {}   -- [player] = heure du dernier message (pas de spam)
local function warn1(player, text)
	if os.clock() - (warned[player] or 0) > 2.5 then
		warned[player] = os.clock()
		notify(player, text)
	end
end
local function zoneOf(egg)
	for _, zone in ZONES do
		if zone.Folder == egg.Parent then return zone end
	end
end

local function burnFx(egg, on)
	local root = egg.PrimaryPart
	if not root then return end
	local fire = root:FindFirstChild("BurnFire")
	if on and not fire then
		local height = egg:GetAttribute("Height") or 3
		fire = Instance.new("ParticleEmitter")
		fire.Name = "BurnFire"
		fire.Texture = "rbxassetid://9968039364"
		fire.FlipbookLayout, fire.FlipbookMode = Enum.ParticleFlipbookLayout.Grid4x4, Enum.ParticleFlipbookMode.OneShot
		fire.Rate = 16
		fire.Lifetime = NumberRange.new(0.5, 0.8)
		fire.Speed = NumberRange.new(height * 0.6, height * 1.2)
		fire.SpreadAngle = Vector2.new(40, 40)
		fire.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, height * 0.5), NumberSequenceKeypoint.new(1, height * 1.1)})
		fire.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 1)})
		fire.LightEmission = 1
		fire.Rotation = NumberRange.new(0, 360)
		fire.EmissionDirection = Enum.NormalId.Top
		fire.Parent = root
		-- barre de progression au-dessus de l'œuf : cadre blanc à studs, remplissage de feu, flamme et pourcentage en relief
		local bar = Instance.new("BillboardGui")
		bar.Name = "BurnBar"
		bar.Size = UDim2.new(7 + height * 0.7, 0, 1.5 + height * 0.15, 0)
		bar.StudsOffsetWorldSpace = Vector3.new(0, height / 2 + 5.5 + height * 0.42, 0)
		bar.AlwaysOnTop = true
		bar.LightInfluence = 0
		local back = Instance.new("Frame")
		back.Name = "Back"
		back.Position = UDim2.fromScale(0.16, 0.2)
		back.Size = UDim2.fromScale(0.84, 0.6)
		back.BackgroundColor3 = Color3.new(1, 1, 1)
		back.BorderSizePixel = 0
		local outline = Instance.new("UIStroke")
		outline.Thickness = 3
		outline.Parent = back
		local function studs(parent)
			local image = Instance.new("ImageLabel")
			image.Name = "Studs"
			image.BackgroundTransparency = 1
			image.Size = UDim2.fromScale(1, 1)
			image.Image = "rbxassetid://7447638591"
			image.ScaleType = Enum.ScaleType.Tile
			image.TileSize = UDim2.fromScale(0.12, 1)
			image.ImageTransparency = 0.2
			image.Parent = parent
			return image
		end
		studs(back).ImageColor3 = Color3.fromRGB(226, 228, 238)
		local fill = Instance.new("Frame")
		fill.Name = "Fill"
		fill.Size = UDim2.fromScale(0, 1)
		fill.BackgroundColor3 = Color3.new(1, 1, 1)
		fill.BorderSizePixel = 0
		fill.ClipsDescendants = true
		local gradient = Instance.new("UIGradient")
		gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 225, 70)), ColorSequenceKeypoint.new(0.6, Color3.fromRGB(255, 140, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 60, 30))})
		gradient.Parent = fill
		fill.Parent = back
		local label = Instance.new("TextLabel")
		label.Name = "Label"
		label.BackgroundTransparency = 1
		label.Size = UDim2.fromScale(1, 1)
		label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
		label.Text = "0%"
		label.TextScaled = true
		label.TextColor3 = Color3.new(1, 1, 1)
		label.ZIndex = 3
		local textStroke = Instance.new("UIStroke")
		textStroke.Thickness = 3
		textStroke.Parent = label
		game:GetService("CollectionService"):AddTag(label, "Text3D")
		label.Parent = back
		back.Parent = bar
		local icon = Instance.new("ImageLabel")
		icon.Name = "Flame"
		icon.BackgroundTransparency = 1
		icon.Image = "rbxassetid://86524369025968"
		icon.ScaleType = Enum.ScaleType.Fit
		icon.Size = UDim2.fromScale(0.2, 1)
		icon.ZIndex = 4
		icon.Parent = bar
		bar.Parent = root
	elseif not on then
		if fire then fire:Destroy() end
		local bar = root:FindFirstChild("BurnBar")
		if bar then bar:Destroy() end
	end
end

local HATCHED_LIFETIME = 45 -- secondes avant qu'un animal éclos que personne ne ramasse disparaisse
local DROPPED_PET_LIFETIME = 300 -- secondes avant qu'un animal lâché au sol disparaisse (5 minutes)
local grabPet

-- le joueur ramasse l'animal éclos : il apparaît aussitôt au-dessus de sa tête et le gardien de la zone se met en chasse
function grabPet(player, visual, entry, zone)
	if not visual.Parent or visual:GetAttribute("Taken") then return end
	local dragon = personalDragon(player)
	if not dragon or not dragon.PrimaryPart then return end
	local list = carried[player] or {}
	carried[player] = list
	local capacity = UpgradeConfig.Value(player, "Carry")
	if #list >= capacity then
		notify(player, "You can only carry " .. capacity .. (capacity == 1 and " animal" or " animals") .. "! Bring them to the safe zone first.")
		return
	end
	visual:SetAttribute("Taken", true)
	-- le compte à rebours s'arrête pendant qu'on le porte : on garde le temps qui lui restait
	if entry.ExpiresAt then entry.Remaining = math.max(3, entry.ExpiresAt - os.clock()) end
	visual:Destroy()
	table.insert(list, entry)
	setCarrying(player)
	ServerStorage.GameBindables.EggGrabbed:Fire(player, zone.Part)
	-- plus d'animation de tourbillon : l'animal est téléporté directement au-dessus de la tête
	attachVisual(player, entry, #list)
	notify(player, (entry.Witch and "Witch " or "") .. Config.Pets[entry.Pet].Name .. " grabbed! Run back to the safe zone to keep it.")
end

-- pose un animal au sol (éclos d'un œuf, ou lâché par un joueur) avec son étiquette et l'invite Grab.
-- floor = CFrame au niveau du sol ; dropped = lâché par un joueur (pas de présentation, reprenable presque tout de suite)
local function placePet(entry, zone, floor, dropped)
	local petInfo = Config.Pets[entry.Pet or ""]
	local template = petTemplates:FindFirstChild(entry.Pet or "")
	if not template or not petInfo then return nil end
	local petKg = entry.PetKg or petInfo.Kg
	local size = Config.SizeScale(petKg, petInfo.Kg) * Config.PetSize
	local visual = template:Clone()
	visual.Name = "HatchedPet"
	visual:ScaleTo(visual:GetScale() * size)
	for _, part in visual:GetDescendants() do
		if part:IsA("BasePart") then part.CanCollide, part.CanTouch, part.CanQuery = false, false, false end
	end
	local ground = (visual:GetAttribute("GroundOffset") or 1) * size
	visual.PrimaryPart.Anchored = true
	visual:PivotTo(floor * CFrame.new(0, ground, 0))
	local _, bounds = visual:GetBoundingBox()
	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(5 + bounds.Y * 0.5, 0, 1.4 + bounds.Y * 0.14, 0)
	billboard.StudsOffsetWorldSpace = Vector3.new(0, bounds.Y * 0.6 + 2, 0)
	billboard.LightInfluence = 0
	billboard.MaxDistance = 160 + bounds.Y * 6
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 1)
	label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	-- (mutations d'event : pas de texte, leurs icônes sont posées au-dessus du nom)
	label.Text = (entry.Cowboy and "COWBOY " or "") .. (entry.Witch and "WITCH " or "") .. petInfo.Name .. "  ·  " .. Config.FormatMoney(Config.GetIncome(entry.Pet, petKg, entry.Concert, 1)) .. "/s" -- ce qu'il rapporte par seconde
	local icons = Config.MutationList(entry.Concert)
	if #icons > 0 then
		local row = Instance.new("BillboardGui")
		row.Name = "MutationIcons"
		local side = 1.3 + bounds.Y * 0.1
		local cols = math.min(#icons, 5)
		local rows = math.ceil(#icons / 5)
		row.Size = UDim2.new(side * cols * 1.1, 0, side * rows * 1.1, 0)
		row.StudsOffsetWorldSpace = Vector3.new(0, bounds.Y * 0.6 + 2 + (1.4 + bounds.Y * 0.14) / 2 + side * rows * 0.6 + 0.2, 0)
		row.LightInfluence = 0
		row.MaxDistance = 160 + bounds.Y * 6
		for i, name in icons do
			local col, r = (i - 1) % 5, (i - 1) // 5
			local inRow = math.min(5, #icons - r * 5)
			local img = Instance.new("ImageLabel")
			img.Name = name
			img.BackgroundTransparency = 1
			img.Image = Config.MutationIcons[name] or ""
			img.ScaleType = Enum.ScaleType.Fit
			img.AnchorPoint = Vector2.new(0.5, 0.5)
			img.Size = UDim2.fromScale(0.94 / cols, 0.94 / rows)
			img.Position = UDim2.fromScale((col + 0.5 + (cols - inRow) / 2) / cols, (r + 0.5) / rows)
			img.Parent = row
		end
		row.Parent = visual.PrimaryPart
	end
	label.TextScaled = true
	local eventMutation = entry.Concert and Config.GetMutation(entry.Concert)
	label.TextColor3 = entry.Concert == "Like" and Color3.fromRGB(255, 90, 215) or eventMutation and eventMutation.Color or entry.Witch and Color3.fromRGB(215, 140, 255) or entry.Cowboy and Color3.fromRGB(255, 205, 60) or Color3.fromRGB(150, 255, 130)
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 3
	stroke.Parent = label
	game:GetService("CollectionService"):AddTag(label, "Text3D")
	label.Parent = billboard
	billboard.Parent = visual.PrimaryPart
	local prompt = Instance.new("ProximityPrompt")
	prompt.Name = "GrabPetPrompt"
	prompt.ActionText = "Grab"
	prompt.ObjectText = petInfo.Name
	prompt.HoldDuration = 0.2
	prompt.RequiresLineOfSight = false
	prompt.MaxActivationDistance = 14 + math.max(bounds.X, bounds.Z)
	prompt.Enabled = false
	prompt.Parent = visual.PrimaryPart
	prompt.Triggered:Connect(function(who) grabPet(who, visual, entry, zone) end)
	-- éclos : il disparaît s'il n'est pas ramassé (compte à rebours rouge + trou noir côté client, HatchFxClient).
	-- lâché par un joueur : il reste là où il a été posé, sans compte à rebours, jusqu'à ce que quelqu'un le reprenne.
	-- éclos : HATCHED_LIFETIME secondes ; lâché après avoir été attrapé : le compte à rebours REPREND avec le temps qui restait
	-- (un animal sans compte à rebours, ex. volé par le gardien, reste au sol sans limite)
	local lifetime = (not dropped) and HATCHED_LIFETIME or entry.Remaining
	if lifetime then
		entry.ExpiresAt = os.clock() + lifetime
		entry.Remaining = nil
		visual:SetAttribute("Lifetime", lifetime)
	else
		visual:SetAttribute("Dropped", true)
	end
	visual.Parent = zone.Folder
	if entry.Witch then witchDeco(visual) end
	if entry.Concert then pcall(TraitDeco.MutationFx, visual, entry.Concert) end -- comètes / arcs / halo / projecteurs autour de lui
	if lifetime then game:GetService("Debris"):AddItem(visual, lifetime) end
	-- éclos : on peut le prendre tout de suite (la présentation continue côté client) ; lâché : reprenable après un court instant
	task.delay(dropped and 0.6 or 0.1, function()
		if visual.Parent and not visual:GetAttribute("Taken") then prompt.Enabled = true end
	end)
	return visual
end

local lastDrop = {} -- [player] = heure du dernier lâcher (anti-spam)
function dropCarried(player)
	local list = carried[player]
	local character = personalDragon(player)
	local root = character and character.PrimaryPart
	if not list or #list == 0 or not root then return end
	if os.clock() - (lastDrop[player] or 0) < 0.4 then return end
	lastDrop[player] = os.clock()
	-- devant le joueur, au sol
	local look = Vector3.new(root.CFrame.LookVector.X, 0, root.CFrame.LookVector.Z)
	look = look.Magnitude > 0.01 and look.Unit or Vector3.new(0, 0, -1)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {folder, player.Character}
	local hit = workspace:Raycast(root.Position + look * 4 + Vector3.new(0, 2, 0), Vector3.new(0, -600, 0), params)
		or workspace:Raycast(root.Position, Vector3.new(0, -600, 0), params)
	if not hit then
		notify(player, "You can't drop it over the void!")
		return
	end
	local entry = list[#list]
	local zone = entry.Zone or ZONES[1]
	if entry.Pet then
		-- l'animal est posé là où on le lâche, tourné vers le joueur
		local spot = Vector3.new(hit.Position.X, hit.Position.Y, hit.Position.Z)
		local floor = CFrame.lookAt(spot, Vector3.new(root.Position.X, spot.Y, root.Position.Z))
		if not placePet(entry, zone, floor, true) then return end
	else
		spawnEgg(zone, {Key = entry.Key, Height = entry.Height, Kg = entry.Kg, Position = hit.Position})
	end
	table.remove(list)
	if entry.Visual then entry.Visual:Destroy() end
	entry.Visual = nil
	setCarrying(player) -- il ne porte plus rien de cette zone : le gardien abandonne la poursuite
	notify(player, entry.Pet and (Config.Pets[entry.Pet].Name .. " dropped! Grab it again when you want.") or "Egg dropped!")
end
eggSystem.Remotes.DropPet.OnServerEvent:Connect(dropCarried)
eggSystem.Remotes.DropEgg.OnServerEvent:Connect(dropCarried)
-- coup de batte (HammerServer) : le joueur touché pose TOUT ce qu'il porte au sol, là où il a été tapé (on peut le reprendre ensuite)
ServerStorage:WaitForChild("GameBindables"):WaitForChild("PlaceCarried").Event:Connect(function(player)
	for _ = 1, 20 do
		local list = carried[player]
		if not list or #list == 0 then break end
		local before = #list
		lastDrop[player] = nil -- pas d'attente entre deux poses ici
		dropCarried(player)
		if #list >= before then break end -- rien n'a pu être posé (au-dessus du vide...)
	end
end)
Players.PlayerRemoving:Connect(function(player) lastDrop[player] = nil end)

local CRACK_TIME = 2  -- secondes pendant lesquelles l'œuf craque avant de s'ouvrir
local REEL_TIME = 3   -- secondes de défilement des animaux avant le résultat
local hatchReel = eggSystem:WaitForChild("Remotes"):WaitForChild("HatchReel")
local function hatch(player, egg, zone)
	egg:SetAttribute("Hatching", true)
	local key, kg, height = egg:GetAttribute("EggKey"), egg:GetAttribute("Kg"), egg:GetAttribute("Height")
	local info = Config.Eggs[key]
	assert(info and info.Pets and info.Pets[1], "unknown egg " .. tostring(key))
	kg = tonumber(kg) or info.Kg or 1
	height = tonumber(height) or 4
	-- quel animal ? tirage selon les pourcentages de l'œuf (un ancien œuf n'a qu'un animal à 100 %)
	local petName = info.Pets[1].Pet
	if #info.Pets > 1 then
		local total = 0
		for _, entry in info.Pets do total += entry.Chance end
		local roll = math.random() * total
		for _, entry in info.Pets do
			roll -= entry.Chance
			if roll <= 0 then petName = entry.Pet break end
		end
	end
	local petInfo = Config.Pets[petName]
	egg:SetAttribute("CrackTime", CRACK_TIME) -- l'œuf craque pendant ce temps (HatchFxClient)
	-- les kilos en plus de l'œuf passent à l'animal : œuf géant = animal géant
	local petKg = math.min(petInfo.Kg * (1 + math.random() * 0.25) + math.max(0, kg - info.Kg), Config.MaxKg or 1e6)
	local entry = {Key = key, Kg = kg, Height = height, Zone = zone, Pet = petName, PetKg = petKg, Witch = egg:GetAttribute("WitchTrait"), Cowboy = egg:GetAttribute("CowboyTrait"),
		Concert = (function() -- mutations d'event (Like du concert, Disco, Galaxy... qui s'empilent : "Like+Disco+Galaxy") : l'animal les garde toutes
			local all = egg:GetAttribute("ConcertMutation") and "Like" or nil
			for _, m in Config.MutationList(egg:GetAttribute("EventMutation")) do all = all and Config.AddMutation(all, m) or m end
			return all
		end)()} -- mutation d'event (Like x5 du CONCERT, Cosmic / Storm / Alien x4 des events du ciel) : l'animal la garde
	if not egg:GetAttribute("Dropped") then task.delay(RESPAWN_DELAY, spawnEgg, zone) end

	task.spawn(function()
		local pivot, scale = egg:GetPivot(), egg:GetScale()
		for _, d in egg:GetDescendants() do
			if d:IsA("BillboardGui") or d:IsA("ProximityPrompt") then d:Destroy() end
		end
		-- 1) l'œuf tremble de plus en plus fort et gonfle
		local start = os.clock()
		while os.clock() - start < CRACK_TIME and egg.Parent do
			local k = (os.clock() - start) / CRACK_TIME
			-- (gonflement et lueur animés côté client : HatchFxClient)
			-- (plus de tremblement : l'œuf gonfle seulement)
			task.wait()
		end
		-- 2) il éclate : éclair, étincelles, morceaux de coquille
		local center = pivot.Position
		local flash = Instance.new("Part")
		flash.Shape = Enum.PartType.Ball
		flash.Material = Enum.Material.Neon
		flash.Color = Color3.fromRGB(255, 240, 170)
		flash.Anchored, flash.CanCollide, flash.CanQuery, flash.CanTouch, flash.CastShadow = true, false, false, false, false
		flash.Size = Vector3.one * height * 0.6
		flash.CFrame = CFrame.new(center)
		flash.Parent = workspace
		game:GetService("TweenService"):Create(flash, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.one * height * 3, Transparency = 1}):Play()
		game:GetService("Debris"):AddItem(flash, 0.5)
		local sparks = Instance.new("Attachment")
		sparks.WorldPosition = center
		sparks.Parent = workspace.Terrain
		local emitter = Instance.new("ParticleEmitter")
		emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
		emitter.Rate = 0
		emitter.Lifetime = NumberRange.new(0.6, 1.2)
		emitter.Speed = NumberRange.new(height * 3, height * 7)
		emitter.SpreadAngle = Vector2.new(180, 180)
		emitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, height * 0.35), NumberSequenceKeypoint.new(1, 0)})
		emitter.Color = ColorSequence.new(Color3.fromRGB(255, 240, 150), Color3.fromRGB(255, 140, 40))
		emitter.LightEmission = 1
		emitter.Drag = 3
		emitter.Parent = sparks
		emitter:Emit(40)
		game:GetService("Debris"):AddItem(sparks, 1.5)
		local shards = 0
		for _, part in egg:GetChildren() do
			if part:IsA("BasePart") and part ~= egg.PrimaryPart and part.Transparency < 1 and shards < 22 and math.random() < 0.3 then
				shards += 1
				part.Parent = workspace
				part.Anchored = false
				part.CanCollide = false
				local away = (part.Position - center)
				away = away.Magnitude > 0.1 and away.Unit or Vector3.yAxis
				part.AssemblyLinearVelocity = (away + Vector3.new(0, 0.9, 0)) * (18 + height * 4)
				part.AssemblyAngularVelocity = Vector3.new(math.random(-12, 12), math.random(-12, 12), math.random(-12, 12))
				game:GetService("Debris"):AddItem(part, 1.4)
			end
		end
		egg:Destroy()
		-- 3) défilement : tous les animaux de l'œuf sortent de l'œuf l'un après l'autre, en silhouette noire (HatchReelClient), puis l'animal tiré apparaît
		if #info.Pets > 1 then
			local petKg = entry.PetKg or (petInfo and petInfo.Kg)
			local finalSize = petInfo and (Config.SizeScale(petKg, petInfo.Kg) * Config.PetSize) or 1
			hatchReel:FireAllClients(key, petName, REEL_TIME, Vector3.new(center.X, center.Y - height / 2, center.Z), height, finalSize)
			task.wait(REEL_TIME)
		end
		-- 4) l'animal est là, à sa vraie taille : il se présente (tour sur lui-même, il suit du regard) puis attend qu'on vienne le chercher
		local visual = placePet(entry, zone, CFrame.new(center.X, center.Y - height / 2, center.Z) * CFrame.Angles(0, math.random() * math.pi * 2, 0), false)
		if not visual then return end
		if Config.HasMutation(entry.Concert, "Disco") then -- animal DISCO : explosion disco autour de lui (DiscoFxClient)
			eggSystem.Remotes.DiscoFx:FireAllClients("hatch", Vector3.new(center.X, center.Y - height / 2, center.Z), height)
		end
		if entry.Concert then
			local m = Config.GetMutation(entry.Concert)
			local mult = m and m.Mult or 5
			notify(player, string.upper(entry.Concert) .. " TRAIT x" .. mult .. "! Your " .. petInfo.Name .. " will earn x" .. mult .. "! Go grab it!")
		end
		notify(player, entry.Witch and ("WITCH TRAIT! Your " .. petInfo.Name .. " got x" .. tostring(entry.Witch) .. " weight from the witch! Go grab it!") or (petInfo.Name .. " hatched! Go grab it!"))
	end)
end

local hitRemote = eggSystem:WaitForChild("Remotes"):WaitForChild("HitEgg")
local lastHit = {} -- [player] = heure du dernier coup

-- (la barre de vie et les "-N" sont dessinés sur l'écran de chaque joueur : StarterPlayerScripts.EggHitClient lit l'attribut Hp)

-- bruit du marteau : un « pop » net et un petit « tok » de bois aigu, rien de grave (pas d'effet d'explosion).
-- Plus l'œuf est abîmé, plus le pop monte dans l'aigu ; quand il casse, double « pop-pop » encore plus aigu.
local POP = 6586979979      -- pop cartoon très court (0,2 s)
local POP2 = 140323850218372 -- second pop, pour la casse
local KNOCK = 9126266458    -- coup sec sur du bois (Pro Sound Effects), joué aigu et doux
local function playOn(parent, id, volume, speed, life)
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://" .. id
	sound.Volume = volume
	sound.PlaybackSpeed = speed
	sound.RollOffMinDistance = 10
	sound.RollOffMaxDistance = 110
	sound.Parent = parent
	sound:Play()
	game:GetService("Debris"):AddItem(sound, life or 1.5)
end
local function hitSound(root, hp, maxHp)
	local damaged = 1 - math.clamp((hp or 0) / math.max(maxHp or 1, 1), 0, 1) -- 0 : œuf neuf, 1 : cassé
	local jitter = (math.random() - 0.5) * 0.06
	playOn(root, POP, 0.8, 1 + 0.5 * damaged + jitter, 1)
	playOn(root, KNOCK, 0.3, 1.6 + jitter, 1)
	if hp and hp <= 0 then -- il casse (sur un point fixe : l'œuf va disparaître)
		local spot = Instance.new("Part")
		spot.Anchored, spot.CanCollide, spot.CanQuery, spot.CanTouch, spot.Transparency = true, false, false, false, 1
		spot.Size = Vector3.one
		spot.CFrame = CFrame.new(root.Position)
		spot.Parent = workspace
		game:GetService("Debris"):AddItem(spot, 2)
		playOn(spot, POP2, 0.9, 1.25, 1.5)
		task.delay(0.09, function() if spot.Parent then playOn(spot, POP, 0.9, 1.75, 1) end end)
	end
end

-- éclats de coquille, bruit satisfaisant et petite secousse à chaque coup
local shaking = {} -- [œuf] = {Rest = position d'origine, Token} pendant une secousse
local function hitFx(egg, from, hp, maxHp)
	local root = egg.PrimaryPart
	if not root then return end
	local height = egg:GetAttribute("Height") or 3
	hitSound(root, hp, maxHp)
	local chips = root:FindFirstChild("HitChips")
	if not chips then
		chips = Instance.new("ParticleEmitter")
		chips.Name = "HitChips"
		chips.Texture = "rbxasset://textures/particles/sparkles_main.dds"
		chips.Color = ColorSequence.new(Color3.fromRGB(255, 250, 235))
		chips.Rate = 0
		chips.Lifetime = NumberRange.new(0.35, 0.7)
		chips.Speed = NumberRange.new(height * 2.5, height * 5)
		chips.SpreadAngle = Vector2.new(180, 180)
		chips.Acceleration = Vector3.new(0, -60, 0)
		chips.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, math.max(height * 0.14, 0.3)), NumberSequenceKeypoint.new(1, 0)})
		chips.Rotation = NumberRange.new(0, 360)
		chips.Parent = root
	end
	chips:Emit(14)
	-- petite secousse, toujours autour de la place d'origine de l'œuf (deux coups rapprochés, de deux joueurs, le faisaient
	-- glisser peu à peu : la secousse repartait de la position déjà décalée)
	local shake = shaking[egg] or {Rest = egg:GetPivot(), Token = 0}
	shaking[egg] = shake
	shake.Token += 1
	local token = shake.Token
	local rest = shake.Rest
	local away = Vector3.new(rest.Position.X - from.X, 0, rest.Position.Z - from.Z)
	away = away.Magnitude > 0.1 and away.Unit or Vector3.new(1, 0, 0)
	task.spawn(function()
		for _, k in {0.35, -0.2, 0.1, 0} do
			if shake.Token ~= token then return end -- un coup plus récent a repris la secousse
			if not egg.Parent or egg:GetAttribute("Hatching") then shaking[egg] = nil return end
			egg:PivotTo(rest + away * k * math.min(height * 0.12, 1.2))
			task.wait(0.04)
		end
		if shake.Token == token then shaking[egg] = nil end -- l'œuf est revenu pile à sa place
	end)
end

hitRemote.OnServerEvent:Connect(function(player, egg)
	if typeof(egg) ~= "Instance" or not egg:IsA("Model") or not egg:IsDescendantOf(folder) or egg:GetAttribute("Hatching") then return end
	if egg:GetAttribute("GalaxyLock") then return end -- œuf absorbé par la galaxie (Galaxy Event) : intouchable jusqu'à son retour
	local character = personalDragon(player)
	local root = character and character.PrimaryPart
	if not root or not player:GetAttribute("HammerOut") then return end
	local now = os.clock()
	if now - (lastHit[player] or 0) < HIT_COOLDOWN then return end
	-- distance mesurée depuis le vrai centre de l'œuf (boîte englobante), jusqu'à son bord ; marge pour le décalage réseau
	-- centre : la pièce Root de l'œuf (pas la boîte englobante : l'icône 3D d'une mutation, dans l'étiquette, la déplace très loin)
	local extents = egg:GetExtentsSize()
	local center = egg.PrimaryPart and egg.PrimaryPart.Position or egg:GetPivot().Position
	local flat = Vector3.new(root.Position.X - center.X, 0, root.Position.Z - center.Z).Magnitude
	local lag = math.min(Vector3.new(root.AssemblyLinearVelocity.X, 0, root.AssemblyLinearVelocity.Z).Magnitude * 0.25, 12) -- un joueur rapide est "en retard" côté serveur
	local radius = egg:GetAttribute("HitRadius") or math.max(extents.X, extents.Z) / 2 -- (largeur mesurée à l'apparition de l'œuf)
	if flat > radius + HIT_REACH + lag then return end
	local zone = zoneOf(egg)
	local maxHp = egg:GetAttribute("MaxHp")
	if not zone or not maxHp then return end
	lastHit[player] = now
	local damage = math.max(player:GetAttribute("HammerDamage") or 1, 1)
		* math.max(tonumber(ReplicatedStorage:GetAttribute("DamageEventMult")) or 1, 1) -- event admin 2X DAMAGE (DamageEventServer)
	local hp = math.max((egg:GetAttribute("Hp") or maxHp) - damage, 0)
	egg:SetAttribute("Hp", hp)
	hitFx(egg, root.Position, hp, maxHp)
	if hp <= 0 then
		-- si l'éclosion plante (œuf aux données incomplètes...), l'œuf ne reste JAMAIS bloqué en "Hatching" (intouchable pour toujours)
		local ok, err = pcall(hatch, player, egg, zone)
		if not ok then
			warn("[EggZoneServer] hatch failed for " .. tostring(egg:GetAttribute("EggKey")) .. " : " .. tostring(err))
			if egg.Parent then
				egg:SetAttribute("Hatching", nil)
				egg:SetAttribute("CrackTime", nil)
				egg:SetAttribute("Hp", math.max(1, math.floor((maxHp or 1) * 0.05)))
			end
		end
	end
end)
Players.PlayerRemoving:Connect(function(player) warned[player] = nil lastHit[player] = nil end)

-- le gardien touche le joueur : il lui reprend ce qu'il porte et rapporte un œuf dans sa zone
ServerStorage.GameBindables:WaitForChild("StealCarried").OnInvoke = function(player, zoneName)
	local list = carried[player] or {}
	local taken
	for _, entry in list do
		if entry.Zone and entry.Zone.Part == zoneName then taken = entry break end
	end
	taken = taken or list[1]
	local stolen = taken and {Key = taken.Key, Height = taken.Height, Kg = taken.Kg} or nil
	clear(player)
	setCarrying(player)
	return stolen
end
ServerStorage.GameBindables:WaitForChild("ReturnEgg").Event:Connect(function(zoneName, stolen, position)
	for _, zone in ZONES do
		if zone.Part == zoneName then
			spawnEgg(zone, {Key = stolen.Key, Height = stolen.Height, Kg = stolen.Kg, Position = position})
		end
	end
end)

-- LANCER DE L'ADMIN : son skin géant apparaît au-dessus de la zone et jette l'œuf (cinématique : AdminThrowClient).
-- Le serveur prépare une copie de l'avatar (ReplicatedStorage.AdminThrow.Rigs), prévient tous les joueurs, puis pose le vrai
-- œuf pile au moment où celui de l'animation touche le sol (THROW_LAND secondes après le signal).
local THROW_LAND = 5.5 -- (le géant arrive en volant, s'arrête, prend son élan, lance : l'œuf touche le sol 5,5 s après le signal)
local throwFolder = ReplicatedStorage:WaitForChild("AdminThrow")
local throwRemote = throwFolder:WaitForChild("Play")
local throwRigs = throwFolder:WaitForChild("Rigs")
local throwCount = 0
local function throwerRig(userId)
	local ok, rig = pcall(function()
		local desc = userId and userId > 0 and Players:GetHumanoidDescriptionFromUserId(userId) or Instance.new("HumanoidDescription")
		return Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R15)
	end)
	if not ok or not rig then
		warn("[EggZoneServer] skin du lanceur introuvable : " .. tostring(rig))
		ok, rig = pcall(function() return Players:CreateHumanoidModelFromDescription(Instance.new("HumanoidDescription"), Enum.HumanoidRigType.R15) end)
		if not ok then return nil end
	end
	for _, d in rig:GetDescendants() do
		if d:IsA("Script") or d:IsA("LocalScript") then d:Destroy() end
	end
	return rig
end
local function playThrow(egg, height, zonePart, throwerId, throwerName)
	throwCount += 1
	local token = "Throw" .. throwCount
	local rig = throwerRig(throwerId)
	if rig then
		rig.Name = token
		rig.Parent = throwRigs
		game:GetService("Debris"):AddItem(rig, 30)
	end
	throwRemote:FireAllClients({
		Token = rig and token or nil, Name = throwerName or "Admin", EggKey = egg:GetAttribute("EggKey"), Scale = egg:GetScale(), Height = height,
		Landing = egg:GetPivot(), ZoneCenter = zonePart and zonePart.Position or egg:GetPivot().Position,
		ZoneTop = zonePart and (zonePart.Position.Y + zonePart.Size.Y / 2) or egg:GetPivot().Position.Y - height / 2,
		Land = THROW_LAND,
	})
end

-- oeuf lance par l'admin (panel) : apparait dans la zone de cette rarete avec un timer, disparait si personne ne le prend
ServerStorage:WaitForChild("GameBindables"):WaitForChild("SpawnAdminEgg").Event:Connect(function(rarity, eggKey, lifetime, kg, throwerId, throwerName)
	print("[EggZoneServer] SpawnAdminEgg received: rarity=" .. tostring(rarity) .. " eggKey=" .. tostring(eggKey) .. " lifetime=" .. tostring(lifetime))
	for _, zone in ZONES do
		if (zone.DisplayRarity or zone.Rarity) == rarity then -- la zone Halloween se choisit avec "Halloween"
			print("[EggZoneServer] Found zone " .. zone.Part .. " for rarity " .. rarity .. ", spawning egg...")
			local egg, height = spawnEgg(zone, nil, {Key = eggKey, Lifetime = lifetime, Kg = kg, Hold = true})
			if egg then
				task.spawn(function()
					local ok, err = pcall(playThrow, egg, height, workspace:FindFirstChild(zone.Part), throwerId, throwerName)
					if not ok then warn("[EggZoneServer] lancer : " .. tostring(err)) end
					task.wait(ok and THROW_LAND or 0)
					egg.Parent = zone.Folder -- l'œuf touche le sol
					adminTimer(egg, height, lifetime)
				end)
			end
			-- tout le serveur est prévenu : quel œuf, dans quelle zone
			local zonePart = workspace:FindFirstChild(zone.Part)
			local eggInfo = Config.Eggs[eggKey]
			local announce = game:GetService("ReplicatedStorage"):FindFirstChild("AdminSystem") and game:GetService("ReplicatedStorage").AdminSystem.Remotes:FindFirstChild("EggSpawnAnnounce")
			if announce and eggInfo then
				announce:FireAllClients(eggInfo.Name, zonePart and zonePart:GetAttribute("ZoneTitle") or (rarity .. " Zone"), eggInfo.Rarity, nil, nil, lifetime, false, true)
			end
			return
		end
	end
	warn("[EggZoneServer] zone admin introuvable : " .. tostring(rarity))
end)

---------------------------------------------------------------- Pet gagné avec un code : apparaît dans la Common Egg Zone, réservé au joueur qui a utilisé le code
local CODE_PET_LIFETIME = 300 -- secondes avant qu'un pet de code non ramassé disparaisse
ServerStorage:WaitForChild("GameBindables"):WaitForChild("SpawnCodePet").Event:Connect(function(owner, petName)
	local zone
	for _, z in ZONES do
		if z.Rarity == "Common" then zone = z break end
	end
	local part = zone and workspace:FindFirstChild(zone.Part)
	local template = petTemplates:FindFirstChild(petName)
	local petInfo = Config.Pets[petName]
	if not part or not template or not petInfo or typeof(owner) ~= "Instance" or owner.Parent ~= Players then
		warn("[EggZoneServer] SpawnCodePet impossible : pet=" .. tostring(petName) .. " zone=" .. tostring(part))
		return
	end

	-- position au hasard dans la zone Common
	local half = part.Size / 2
	local margin = math.min(10, half.X * 0.5, half.Z * 0.5)
	local x = part.Position.X + (math.random() * 2 - 1) * (half.X - margin)
	local z = part.Position.Z + (math.random() * 2 - 1) * (half.Z - margin)
	local floorY = part.Position.Y + half.Y

	local petKg = petInfo.Kg * (1 + math.random() * 0.25)
	local size = Config.SizeScale(petKg, petInfo.Kg) * Config.PetSize
	local visual = template:Clone()
	visual.Name = "CodePet"
	visual:ScaleTo(visual:GetScale() * size)
	for _, d in visual:GetDescendants() do
		if d:IsA("BasePart") then d.CanCollide, d.CanTouch, d.CanQuery = false, false, false end
	end
	local ground = (visual:GetAttribute("GroundOffset") or 1) * size
	local rest = CFrame.new(x, floorY + ground, z) * CFrame.Angles(0, math.random() * math.pi * 2, 0)
	visual.PrimaryPart.Anchored = true
	visual:PivotTo(rest)
	visual:SetAttribute("OwnerId", owner.UserId)
	local _, bounds = visual:GetBoundingBox()

	-- entrée compatible avec le reste du système (gardien de zone qui reprend ce qu'on porte, zone sûre...)
	local eggKey = zone.Keys[1]
	for key, egg in Config.Eggs do
		if egg.Rarity == "Common" and not egg.ZoneEgg and egg.Pets and egg.Pets[1] and egg.Pets[1].Pet == petName then eggKey = key break end
	end
	local eggInfo = Config.Eggs[eggKey]
	local entry = {Key = eggKey, Kg = eggInfo and eggInfo.Kg or 1, Height = (NORMAL_HEIGHT[1] + NORMAL_HEIGHT[2]) / 2, Zone = zone, Pet = petName, PetKg = petKg}

	-- étiquette : nom + poids, puis "FOR <joueur>" avec le temps restant
	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(6 + bounds.Y * 0.5, 0, 2.6 + bounds.Y * 0.2, 0)
	billboard.StudsOffsetWorldSpace = Vector3.new(0, bounds.Y * 0.6 + 2.5, 0)
	billboard.LightInfluence = 0
	billboard.AlwaysOnTop = true
	billboard.MaxDistance = 5000
	local function makeLabel(pos, sz, color)
		local label = Instance.new("TextLabel")
		label.BackgroundTransparency = 1
		label.Position, label.Size = pos, sz
		label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
		label.TextScaled = true
		label.TextColor3 = color
		label.Text = ""
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 3
		stroke.Parent = label
		game:GetService("CollectionService"):AddTag(label, "Text3D")
		label.Parent = billboard
		return label
	end
	local nameLabel = makeLabel(UDim2.fromScale(0, 0), UDim2.fromScale(1, 0.55), Color3.fromRGB(150, 255, 130))
	nameLabel.Text = petInfo.Name .. "  ·  " .. Config.FormatKg(petKg)
	local ownerLabel = makeLabel(UDim2.fromScale(0, 0.58), UDim2.fromScale(1, 0.4), Color3.fromRGB(255, 225, 90))
	billboard.Parent = visual.PrimaryPart

	-- grand rayon de lumière pour le repérer facilement dans la zone
	local beam = Instance.new("Part")
	beam.Name = "CodePetBeam"
	beam.Anchored, beam.CanCollide, beam.CanQuery, beam.CanTouch, beam.CastShadow = true, false, false, false, false
	beam.Material = Enum.Material.Neon
	beam.Color = Color3.fromRGB(255, 225, 90)
	beam.Transparency = 0.55
	beam.Size = Vector3.new(4, 300, 4)
	beam.CFrame = CFrame.new(x, floorY + 150, z)
	beam.Parent = workspace

	local prompt = Instance.new("ProximityPrompt")
	prompt.Name = "GrabPetPrompt"
	prompt.ActionText = "Grab"
	prompt.ObjectText = petInfo.Name
	prompt.HoldDuration = 0.2
	prompt.RequiresLineOfSight = false
	prompt.MaxActivationDistance = 14 + math.max(bounds.X, bounds.Z)
	prompt.Parent = visual.PrimaryPart
	prompt.Triggered:Connect(function(who)
		if who ~= owner then
			notify(who, "This pet belongs to " .. owner.DisplayName .. "!")
			return
		end
		grabPet(who, visual, entry, zone)
	end)
	visual.Parent = zone.Folder

	task.spawn(function()
		local t0 = os.clock()
		local lastSecs = -1
		while visual.Parent and not visual:GetAttribute("Taken") do
			local t = os.clock() - t0
			local left = CODE_PET_LIFETIME - t
			if left <= 0 or owner.Parent ~= Players then break end
			visual:PivotTo(rest * CFrame.Angles(0, math.sin(t * 1.5) * 0.5, 0))
			local secs = math.ceil(left)
			if secs ~= lastSecs then
				lastSecs = secs
				ownerLabel.Text = string.format("FOR %s  %d:%02d", string.upper(owner.DisplayName), math.floor(secs / 60), secs % 60)
			end
			task.wait()
		end
		beam:Destroy()
		if visual.Parent and not visual:GetAttribute("Taken") then visual:Destroy() end
	end)
end)