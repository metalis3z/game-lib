-- Argent, revenus des animaux, boutique d'oeufs, inventaire, kilos / mutations, jardin et sauvegarde
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local CollectionService = game:GetService("CollectionService")

local system = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(system.EggConfig)
local FuseConfig = require(game:GetService("ReplicatedStorage"):WaitForChild("FuseSystem"):WaitForChild("FuseConfig")) -- œufs fusionnés (Fuse Machine)
local remotes = system.Remotes
local petTemplates = system.Pets
local eggTemplates = system.EggModels
local bases = workspace:WaitForChild("all base")
local ShopConfig = require(ReplicatedStorage:WaitForChild("ShopSystem"):WaitForChild("ShopConfig"))
local UpgradeConfig = require(ReplicatedStorage:WaitForChild("DragonSystem"):WaitForChild("UpgradeConfig"))
local buyUpgrade = ReplicatedStorage.DragonSystem:WaitForChild("BuyUpgrade")
local DragonConfig = require(ReplicatedStorage.DragonSystem:WaitForChild("DragonConfig"))
local dragonShop = ReplicatedStorage.DragonSystem:WaitForChild("DragonShop")
local giveZoneEgg = game:GetService("ServerStorage"):WaitForChild("GameBindables"):WaitForChild("GiveZoneEgg")
local consumeHeldCrop = game:GetService("ServerStorage"):WaitForChild("GameBindables"):WaitForChild("ConsumeHeldCrop") -- répondu par PlantServer

-- Admin system (stock + codes)
local AdminSystem = ReplicatedStorage:WaitForChild("AdminSystem")
local StockData = require(AdminSystem:WaitForChild("StockData"))
local bindables = AdminSystem:WaitForChild("Bindables")

local STORE_NAME = "PlayerData_v3" -- v3 : tout le monde repart de zéro (les anciennes sauvegardes restent dans PlayerData_v2 : remettre v2 pour les retrouver)
local AUTOSAVE_INTERVAL = 60 -- sauvegarde automatique toutes les minutes (avant : 2 min)
local INCOME_INTERVAL = 1   -- les animaux posés paient toutes les secondes
local BASE_WAIT = 10        -- secondes max à attendre l'attribution de la base
local SHOP_RANGE = 30       -- distance max du stand pour acheter
local ZONE_MARGIN = 3       -- les animaux restent à cette distance du bord de la zone
local EGG_HALF_HEIGHT = 6.5 -- demi-hauteur d'un oeuf à l'échelle 1
local EGG_MARGIN = 1.5      -- distance min entre un oeuf posé et le bord de la zone
local HELD_EGG_SCALE = 0.6  -- taille de l'oeuf tenu en main par rapport à l'oeuf posé
local HELD_MAX_SIZE = 1.6   -- un oeuf géant ne grossit pas plus que ça dans la main
local PET_KG_VARIATION = 0.1

local store
do
	local ok, result = pcall(function() return DataStoreService:GetDataStore(STORE_NAME) end)
	if ok then store = result else warn("[PetServer] DataStore indisponible : " .. tostring(result)) end
end

local function makeFolder(name)
	local folder = Instance.new("Folder")
	folder.Name = name
	folder.Parent = workspace
	return folder
end
local placedPets = makeFolder("PlacedPets")
local placedEggs = makeFolder("PlacedEggs")

-- [player] = {CanSave, NextId,
--   Pets = {{Id, Pet, Kg, Mutation?, Model?}},
--   Eggs = {{Id, Egg, Kg, Tier?, Mutation?, Model?, ReadyAt?, X?, Z?}}}
local data = {}

local function notify(player, text)
	remotes.Notify:FireClient(player, text)
end

local function isOwner(player)
	return table.find(Config.OwnerUserIds, player.UserId) ~= nil
end

local function nextId(d)
	d.NextId += 1
	return d.NextId
end

local function countPlaced(list)
	local n = 0
	for _, item in list do
		if item.Model then n += 1 end
	end
	return n
end

local function findItem(list, id)
	for index, item in list do
		if item.Id == id then return item, index end
	end
	return nil
end

-- variation du poids : toujours vers le haut (un animal ne pèse jamais moins que son poids de base)
local function vary(amount)
	return 1 + math.random() * amount * 2
end

-- tire une entrée dans une liste {Chance = %} ; nil si aucune
local function rollChance(list, luck)
	local roll = math.random() * 100
	for _, entry in list do
		roll -= entry.Chance * (luck or 1)
		if roll <= 0 then return entry end
	end
	return nil
end

local function sync(player)
	local d = data[player]
	if not d then return end
	local pets, eggs = {}, {}
	for _, pet in d.Pets do
		table.insert(pets, {Id = pet.Id, Pet = pet.Pet, Kg = pet.Kg, Mutation = pet.Mutation, Trait = pet.Trait, Level = pet.Level or 1, Xp = pet.Xp or 0, Placed = pet.Model ~= nil})
	end
	for _, egg in d.Eggs do
		if not egg.Model then table.insert(eggs, {Id = egg.Id, Egg = egg.Egg, Kg = egg.Kg, Tier = egg.Tier, FusedPet = egg.Fused and egg.Fused.Pet or nil, FusedMutation = egg.Fused and egg.Fused.Mutation or nil}) end
	end
	remotes.InventoryUpdated:FireClient(player, {Pets = pets, Eggs = eggs, PlacedEggs = countPlaced(d.Eggs)})

	-- Index : tout animal possédé au moins une fois reste découvert (lu par le client via l'attribut PetIndex)
	d.Index = d.Index or {}
	for _, pet in d.Pets do d.Index[pet.Pet] = true end
	local names = {}
	for name in d.Index do table.insert(names, name) end
	table.sort(names)
	player:SetAttribute("PetIndex", table.concat(names, ","))
	-- récompense quand toute une rareté de l'index est découverte (une seule fois par rareté)
	d.IndexRewards = d.IndexRewards or {}
	for rarity, reward in Config.IndexRewards or {} do
		if not d.IndexRewards[rarity] then
			local any, complete = false, true
			for name, info in Config.Pets do
				if info.Rarity == rarity then
					any = true
					if not d.Index[name] then complete = false break end
				end
			end
			if any and complete then
				d.IndexRewards[rarity] = true
				player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + reward)
				notify(player, rarity .. " index complete! +" .. Config.FormatMoney(reward))
			end
		end
	end
	local claimed = {}
	for rarity in d.IndexRewards do table.insert(claimed, rarity) end
	player:SetAttribute("IndexRewards", table.concat(claimed, ","))
end

---------------------------------------------------------------- Labels et effets
-- texte blanc à contour noir ; dégradé animé pour les raretés spéciales, couleur / arc-en-ciel pour les mutations
local function makeLabel(parent, name, text, pos, size, rarity, mutationName)
	local label = Instance.new("TextLabel")
	label.Name = name
	label.BackgroundTransparency = 1
	label.Position, label.Size = pos, size
	label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
	label.Text = text
	label.TextScaled = true
	label.TextColor3 = Color3.new(1, 1, 1)
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.new(0, 0, 0)
	stroke.Thickness = 2
	stroke.Parent = label

	local mutation = mutationName and Config.GetMutation(mutationName)
	local gradientColor = (mutation and not mutation.Color and Config.Gradients[mutationName]) or (not mutation and rarity and Config.Gradients[rarity])
	if mutation and mutation.Color then
		label.TextColor3 = mutation.Color
	elseif gradientColor then
		local gradient = Instance.new("UIGradient")
		gradient.Color = gradientColor
		gradient.Parent = label
		CollectionService:AddTag(gradient, "AnimatedGradient")
	end
	label.Parent = parent
	return label
end

local function prefix(...)
	local parts = {}
	for index = 1, select("#", ...) do
		local word = select(index, ...)
		if word then table.insert(parts, word) end
	end
	return table.concat(parts, " ")
end

---------------------------------------------------------------- Zone "animaux" de la base
-- nombre d'animaux que le joueur peut poser : 5 au départ, +1 par agrandissement du jardin
local function maxPlaced(player)
	local d = data[player]
	return math.min(Config.MaxPlaced, (Config.BasePlaced or 5) + (d and d.Garden or 0))
end

local function getBase(player)
	local number = player:GetAttribute("BaseNumber")
	return number and bases:FindFirstChild("base " .. number)
end

local function getAnimalZone(player)
	local base = getBase(player)
	return base and base:FindFirstChild("animaux")
end

local function zonePoint(zone, x, z)
	return (zone.CFrame * CFrame.new(x, zone.Size.Y / 2, z)).Position
end

local function randomZoneXZ(zone)
	local halfX = math.max(zone.Size.X / 2 - ZONE_MARGIN, 0)
	local halfZ = math.max(zone.Size.Z / 2 - ZONE_MARGIN, 0)
	return (math.random() * 2 - 1) * halfX, (math.random() * 2 - 1) * halfZ
end

-- aux pieds du joueur s'il est dans la zone, sinon à un endroit au hasard (coordonnées locales à la zone)
local function pickZoneXZ(player, zone)
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		local lp = zone.CFrame:PointToObjectSpace(hrp.Position)
		if math.abs(lp.X) <= zone.Size.X / 2 - ZONE_MARGIN and math.abs(lp.Z) <= zone.Size.Z / 2 - ZONE_MARGIN then
			return lp.X, lp.Z
		end
	end
	return randomZoneXZ(zone)
end

---------------------------------------------------------------- Animaux posés
-- Le serveur choisit seulement les destinations ; le déplacement est animé côté client (PetClient)
local function startWander(model, zone)
	task.spawn(function()
		local current = model:GetAttribute("MoveTo")
		task.wait(0.5 + math.random())
		while model.Parent do
			local target = zonePoint(zone, randomZoneXZ(zone))
			model:SetAttribute("MoveTo", target)
			local travel = (target - current).Magnitude / Config.WanderSpeed
			current = target
			task.wait(travel + 1 + math.random() * 2.5)
		end
	end)
end

local feedPet -- défini plus bas

local function petTitle(pet, info)
	return (pet.Trait and (string.upper(pet.Trait) .. " ") or "") .. prefix(pet.Mutation, info.Name)
end

-- chapeau posé sur un animal qui a un trait : sorcière (pointu violet) ou cow-boy (brun à larges bords)
local TraitDeco = require(game:GetService("ReplicatedStorage"):WaitForChild("EggSystem"):WaitForChild("TraitDeco"))
-- chapeau du trait (Witch / Cowboy) : posé sur la tête et soudé à elle, il suit l'animal et ses animations
local function traitHat(model, trait)
	local root = model.PrimaryPart
	if not root or not TraitDeco.Hat(model, trait) then return end
	local _, size = model:GetBoundingBox()
	local sparkle = Instance.new("ParticleEmitter")
	sparkle.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	sparkle.Color = trait == "Witch" and ColorSequence.new(Color3.fromRGB(225, 150, 255), Color3.fromRGB(120, 50, 230)) or ColorSequence.new(Color3.fromRGB(255, 225, 120), Color3.fromRGB(230, 150, 40))
	sparkle.LightEmission = 0.8
	sparkle.Rate = 8
	sparkle.Lifetime = NumberRange.new(0.8, 1.4)
	sparkle.Speed = NumberRange.new(size.Y * 0.2, size.Y * 0.5)
	sparkle.SpreadAngle = Vector2.new(180, 180)
	sparkle.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.25, size.Y * 0.14), NumberSequenceKeypoint.new(1, 0)})
	sparkle.Parent = root
end

local function spawnPet(player, pet, zone, x, z)
	local template = petTemplates:FindFirstChild(pet.Pet)
	local info = Config.Pets[pet.Pet]
	if not template or not info then return end
	local pos = zonePoint(zone, x, z)
	local model = template:Clone()
	local size = Config.SizeScale(pet.Kg, info.Kg) * Config.PetSize -- (EggConfig.PetSize : pets 1,8 fois plus grands)
	model:ScaleTo(model:GetScale() * size)
	local groundOffset = model:GetAttribute("GroundOffset") * size
	local height = groundOffset + (info.Fly == "Always" and info.FlyHeight or 0)
	model:SetAttribute("GroundOffset", groundOffset)
	model:SetAttribute("Owner", player.UserId)
	model:SetAttribute("PetId", pet.Id)
	model:SetAttribute("GroundY", pos.Y)
	model:SetAttribute("MoveTo", pos)
	model.ModelStreamingMode = Enum.ModelStreamingMode.Atomic
	model:PivotTo(CFrame.new(pos + Vector3.new(0, height, 0)))
	for _, part in model:GetDescendants() do -- on passe à travers les animaux
		if part:IsA("BasePart") then part.CanCollide = false end
	end

	-- label : nom, poids, revenu
	pet.Income = Config.GetIncome(pet.Pet, pet.Kg, pet.Mutation, pet.Level)
	local _, bounds = model:GetBoundingBox()
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "PetLabel"
	billboard.LightInfluence = 0
	billboard.MaxDistance = 60
	billboard.Size = UDim2.new(4.6, 0, 1.9, 0)
	billboard.StudsOffsetWorldSpace = Vector3.new(0, bounds.Y / 2 + 1.5, 0)
	makeLabel(billboard, "PetName", petTitle(pet, info), UDim2.fromScale(0, 0), UDim2.fromScale(1, 0.4), info.Rarity, pet.Mutation)
	makeLabel(billboard, "Kg", Config.FormatKg(pet.Kg), UDim2.fromScale(0.15, 0.41), UDim2.fromScale(0.7, 0.27))
	makeLabel(billboard, "Income", Config.FormatMoney(pet.Income) .. "/s", UDim2.fromScale(0.15, 0.69), UDim2.fromScale(0.7, 0.3)).TextColor3 = Color3.fromRGB(130, 255, 120)
	billboard.Parent = model.PrimaryPart
	Config.ApplyMutation(model, pet.Mutation)
	if pet.Trait then pcall(traitHat, model, pet.Trait) end
	pcall(TraitDeco.MutationFx, model, pet.Mutation) -- projecteurs (Like), étincelles (Gold, Diamond, Rainbow) : ils suivent l'animal

	-- on nourrit l'animal avec la plante tenue en main
	local feed = Instance.new("ProximityPrompt")
	feed.Name = "FeedPrompt"
	feed.Enabled = false -- système d'XP retiré : on ne nourrit plus les animaux
	feed.ActionText = "Feed"
	feed.ObjectText = info.Name
	feed.HoldDuration = 0
	feed.MaxActivationDistance = 8 + bounds.Y / 2
	feed.RequiresLineOfSight = false
	feed.Parent = model.PrimaryPart
	feed.Triggered:Connect(function(who) feedPet(who, player, pet) end)

	model.Parent = placedPets
	pet.Model = model
	startWander(model, zone)
end

local function removePetModel(pet)
	if pet.Model then
		pet.Model:Destroy()
		pet.Model = nil
	end
end

local function placePet(player, id)
	local d = data[player]
	local pet = d and findItem(d.Pets, id)
	local zone = getAnimalZone(player)
	if not pet or pet.Model or not zone then return end
	if countPlaced(d.Pets) >= maxPlaced(player) then
		notify(player, "Maximum " .. maxPlaced(player) .. " pets in your garden! Upgrade it at the garden sign.")
		return
	end
	spawnPet(player, pet, zone, pickZoneXZ(player, zone))
	sync(player)
end

local function pickUpPet(player, id)
	local d = data[player]
	local pet = d and findItem(d.Pets, id)
	if not pet or not pet.Model then return end
	removePetModel(pet)
	sync(player)
end

-- Animal tenu dans la main (clic dans l'inventaire ou sur une case 1-0) : un clic dans le monde le pose dans le jardin
local function clearPetTool(player)
	for _, container in {player.Character, player:FindFirstChild("Backpack")} do
		if container then
			for _, tool in container:GetChildren() do
				if tool:IsA("Tool") and tool:GetAttribute("PetId") then tool:Destroy() end
			end
		end
	end
end

local function equipPet(player, id)
	local d = data[player]
	local pet = d and findItem(d.Pets, id)
	local character = player.Character
	local info = pet and Config.Pets[pet.Pet]
	local template = pet and game:GetService("ReplicatedStorage").EggSystem.Pets:FindFirstChild(pet.Pet)
	if not pet or pet.Model or not character or not template or not info then return end
	local held = character:FindFirstChildOfClass("Tool")
	local same = held and held:GetAttribute("PetId") == id
	clearPetTool(player)
	if same then return end -- deuxième clic : on le range

	local tool = Instance.new("Tool")
	tool.Name = info.Name
	tool.CanBeDropped = false
	tool.ToolTip = "Click to place it in your garden"
	tool:SetAttribute("PetId", id)
	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.one * 0.4
	handle.Transparency = 1
	handle.CanCollide, handle.CanQuery, handle.CanTouch, handle.Massless = false, false, false, true
	handle.Parent = tool
	local visual = template:Clone()
	visual.Name = "HeldPet"
	local _, size = visual:GetBoundingBox()
	local natural = math.max(size.X, size.Y, size.Z) * Config.SizeScale(pet.Kg or info.Kg, info.Kg) * Config.PetSize
	visual:ScaleTo(visual:GetScale() * math.clamp(natural, 3.5, 7) / math.max(size.X, size.Y, size.Z))
	local root = visual.PrimaryPart
	for _, part in visual:GetDescendants() do
		if part:IsA("BasePart") then
			part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.Massless = false, false, false, false, true
			if part ~= root then
				local weld = Instance.new("WeldConstraint")
				weld.Part0, weld.Part1 = root, part
				weld.Parent = part
			end
		end
	end
	visual:PivotTo(handle.CFrame * CFrame.new(0, math.clamp(natural, 3.5, 7) * 0.5, 0))
	local hold = Instance.new("WeldConstraint")
	hold.Part0, hold.Part1 = handle, root
	hold.Parent = handle
	visual.Parent = tool

	-- (la pose se fait en cliquant sur le sol du jardin : PetPlaceClient -> action "PlacePetAt")
	tool.Unequipped:Connect(function()
		task.defer(function() tool:Destroy() end)
	end)
	-- un seul objet en main : le marteau (ou la batte) est rangé quand on prend un animal
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then humanoid:UnequipTools() end
	tool.Parent = character
end

local function placePetAt(player, id, position)
	local d = data[player]
	local pet = d and findItem(d.Pets, id)
	local zone = getAnimalZone(player)
	if not pet or pet.Model or not zone or typeof(position) ~= "Vector3" then return end
	local lp = zone.CFrame:PointToObjectSpace(position)
	if math.abs(lp.X) > zone.Size.X / 2 - ZONE_MARGIN or math.abs(lp.Z) > zone.Size.Z / 2 - ZONE_MARGIN then
		notify(player, "Go to your garden and click the ground there to place your pet!")
		return
	end
	if countPlaced(d.Pets) >= maxPlaced(player) then
		notify(player, "Maximum " .. maxPlaced(player) .. " pets in your garden! Upgrade it at the garden sign.")
		return
	end
	spawnPet(player, pet, zone, lp.X, lp.Z)
	clearPetTool(player)
	sync(player)
end

-- Pose d'un coup les animaux qui rapportent le plus (et range les autres)
local function placeBest(player)
	local d = data[player]
	local zone = getAnimalZone(player)
	if not d or not zone or #d.Pets == 0 then return end
	local sorted = table.clone(d.Pets)
	table.sort(sorted, function(a, b)
		return Config.GetIncome(a.Pet, a.Kg, a.Mutation, a.Level) > Config.GetIncome(b.Pet, b.Kg, b.Mutation, b.Level)
	end)
	for index, pet in sorted do
		if index > maxPlaced(player) then removePetModel(pet) end
	end
	for index, pet in sorted do
		if index <= maxPlaced(player) and not pet.Model then
			spawnPet(player, pet, zone, randomZoneXZ(zone))
		end
	end
	notify(player, "Your best pets are now in your garden!")
	sync(player)
end

-- Revenus : chaque animal posé paie son revenu toutes les secondes
local function payIncome()
	for player, d in data do
		local total = 0
		for _, pet in d.Pets do
			if pet.Model then total += pet.Income or 0 end
		end
		total *= ShopConfig.MoneyMult(player) -- rebirth x VIP
		if total > 0 then
			player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + total * INCOME_INTERVAL)
		end
		if d.ShownIncome ~= total then
			d.ShownIncome = total
			player:SetAttribute("Income", total)
			local base = getBase(player)
			local display = base and base:FindFirstChild("BaseDisplay")
			local label = display and display:FindFirstChild("CashPerSecond", true)
			if label then label.Text = Config.FormatMoney(total) .. "/s" end
		end
	end
end

task.spawn(function()
	while true do
		task.wait(INCOME_INTERVAL)
		payIncome()
	end
end)

---------------------------------------------------------------- Nourrir : XP et niveaux
function feedPet(who, owner, pet)
	if who ~= owner then
		notify(who, "This is not your pet!")
		return
	end
	local d = data[owner]
	local info = Config.Pets[pet.Pet]
	if not d or not info or not pet.Model then return end
	local level = pet.Level or 1
	if level >= Config.MaxLevel then
		notify(owner, "This pet is already at max level!")
		return
	end
	local xp = consumeHeldCrop:Invoke(owner) -- PlantServer retire la plante tenue en main et renvoie son XP
	if not xp then
		notify(owner, "Hold a crop (Inventory > Crops tab) to feed your pet!")
		return
	end

	if ShopConfig.HasPass(owner, "DoubleXp") then xp *= 2 end
	pet.Xp = (pet.Xp or 0) + xp
	local leveledUp = false
	while level < Config.MaxLevel and pet.Xp >= Config.XpForLevel(level) do
		pet.Xp -= Config.XpForLevel(level)
		level += 1
		leveledUp = true
	end
	if level >= Config.MaxLevel then pet.Xp = 0 end
	pet.Level = level
	pet.Income = Config.GetIncome(pet.Pet, pet.Kg, pet.Mutation, level)

	local label = pet.Model:FindFirstChild("PetLabel", true)
	if label then
		label.PetName.Text = petTitle(pet, info)
		label.Income.Text = Config.FormatMoney(pet.Income) .. "/s"
	end
	remotes.PetFed:FireClient(owner, pet.Model, xp, leveledUp and level or nil)
	sync(owner)
end

---------------------------------------------------------------- Oeufs
-- Tire un animal au sort selon les pourcentages de l'oeuf
local function rollPet(contents)
	return (rollChance(contents) or contents[1]).Pet
end

local function eggTitle(egg, info)
	if egg.Fused then -- œuf de la Fuse Machine : il porte le nom de l'animal fusionné
		local petInfo = Config.Pets[egg.Fused.Pet]
		return prefix(egg.Mutation, "Fused " .. (petInfo and petInfo.Name or info.Name) .. " Egg")
	end
	return prefix(egg.Mutation, info.Name)
end

-- met le modèle de l'oeuf à la taille de son poids, posé au sol, label au-dessus
local function fitEggModel(egg, info, zone)
	local model = egg.Model
	model:ScaleTo(model:GetAttribute("BaseScale") * Config.SizeScale(egg.Kg, info.Kg))
	local height = EGG_HALF_HEIGHT * model:GetScale()
	local yaw = model:GetAttribute("Yaw")
	model:PivotTo(CFrame.new(zonePoint(zone, egg.X, egg.Z) + Vector3.new(0, height, 0)) * CFrame.Angles(0, yaw, 0))
	local billboard = model.PrimaryPart:FindFirstChild("EggLabel")
	if billboard then
		billboard.StudsOffsetWorldSpace = Vector3.new(0, height + 2.8, 0)
		billboard.Kg.Text = Config.FormatKg(egg.Kg)
	end
	local prompt = model.PrimaryPart:FindFirstChildOfClass("ProximityPrompt")
	if prompt then prompt.MaxActivationDistance = 9 + height end
	return height
end

local function hatchEgg(player, egg)
	local d = data[player]
	local info = Config.Eggs[egg.Egg]
	local _, index = findItem(d and d.Eggs or {}, egg.Id)
	if not d or not index or not egg.Model or os.time() < egg.ReadyAt then return false end
	if #d.Pets >= Config.MaxInventory then
		notify(player, "Inventory full: " .. Config.MaxInventory .. " pets maximum!")
		return false
	end

	-- l'animal est acquis tout de suite (même si le joueur quitte) ; l'inventaire s'affiche à la fin de l'animation
	local model = egg.Model
	local petName, petKg
	local fused = egg.Fused
	if fused and Config.Pets[fused.Pet] then -- œuf fusionné : l'animal et son poids sont déjà connus
		petName, petKg = fused.Pet, tonumber(fused.Kg) or Config.Pets[fused.Pet].Kg
	else
		fused = nil
		petName = rollPet(info.Pets)
		petKg = math.min(Config.Pets[petName].Kg * vary(PET_KG_VARIATION) + math.max(0, egg.Kg - info.Kg), Config.MaxKg or 1e6) -- les kilos bonus de l'oeuf passent à l'animal (1M kg max)
	end
	table.remove(d.Eggs, index)
	egg.Model = nil
	table.insert(d.Pets, {Id = nextId(d), Pet = petName, Kg = petKg, Mutation = egg.Mutation,
		Trait = fused and (fused.Trait == "Witch" or fused.Trait == "Cowboy") and fused.Trait or nil,
		Level = fused and tonumber(fused.Level) or nil, Xp = fused and tonumber(fused.Xp) or nil})

	local prompt = model:FindFirstChildWhichIsA("ProximityPrompt", true)
	if prompt then prompt.Enabled = false end
	remotes.EggHatched:FireClient(player, egg.Egg, petName, model, petKg, egg.Mutation)
	task.delay(Config.Hatch.Wobble + Config.Hatch.Pop + 0.1, function() model:Destroy() end)
	task.delay(Config.HatchTime, function()
		if data[player] == d then sync(player) end
	end)
	return true
end

-- Ouvre d'un coup tous les oeufs prêts du joueur
local function hatchAll(player)
	local d = data[player]
	if not d then return end
	for _, egg in table.clone(d.Eggs) do
		if egg.Model and egg.ReadyAt and os.time() >= egg.ReadyAt then
			if not hatchEgg(player, egg) then break end
		end
	end
end

-- Pendant que l'oeuf couve, il a une chance de grossir à chaque intervalle
local function startGrowth(player, egg, info, zone)
	if egg.Fused then return end -- un œuf fusionné garde exactement le poids de la fusion
	local growth = Config.Growth
	local model = egg.Model
	task.spawn(function()
		while true do
			task.wait(growth.Interval)
			if egg.Model ~= model or not model.Parent or os.time() >= egg.ReadyAt then break end
			if math.random() * 100 < growth.Chance then
				egg.Kg *= growth.Mult
				fitEggModel(egg, info, zone)
				notify(player, "Your " .. info.Name .. " grew! " .. Config.FormatKg(egg.Kg))
			end
		end
	end)
end

local function spawnEgg(player, egg, zone, justPlaced)
	local template = eggTemplates:FindFirstChild(egg.Egg)
	local info = Config.Eggs[egg.Egg]
	if not template or not info then return end
	local model = template:Clone()
	local root = model.PrimaryPart
	model:SetAttribute("BaseScale", model:GetScale())
	model:SetAttribute("Yaw", math.random() * math.pi * 2)
	model:SetAttribute("Owner", player.UserId)
	model:SetAttribute("ReadyAt", egg.ReadyAt)
	model:SetAttribute("Mutation", egg.Mutation)
	model:SetAttribute("PlacedAt", justPlaced and workspace:GetServerTimeNow() or nil) -- PetClient joue l'effet de pose
	model.ModelStreamingMode = Enum.ModelStreamingMode.Atomic

	local title = eggTitle(egg, info)
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "EggLabel"
	billboard.AlwaysOnTop = true
	billboard.LightInfluence = 0
	billboard.MaxDistance = 120
	billboard.Size = UDim2.new(6, 0, 2.6, 0)
	makeLabel(billboard, "EggName", title, UDim2.fromScale(0, 0), UDim2.fromScale(1, 0.38), info.Rarity, egg.Mutation)
	makeLabel(billboard, "Kg", "", UDim2.fromScale(0.2, 0.39), UDim2.fromScale(0.6, 0.25))
	makeLabel(billboard, "Timer", "", UDim2.fromScale(0.15, 0.65), UDim2.fromScale(0.7, 0.34)) -- rempli par PetClient
	billboard.Parent = root

	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Open"
	prompt.ObjectText = title
	prompt.HoldDuration = 0.3
	prompt.RequiresLineOfSight = false
	prompt.Enabled = false
	prompt.Parent = root
	prompt.Triggered:Connect(function(who)
		if who == player then
			hatchEgg(player, egg)
		else
			notify(who, "This is not your egg!")
		end
	end)

	egg.Model = model
	fitEggModel(egg, info, zone)
	Config.ApplyMutation(model, egg.Mutation)
	pcall(TraitDeco.MutationFx, model, egg.Mutation)
	model.Parent = placedEggs

	task.delay(math.max(0, egg.ReadyAt - os.time()), function()
		if model.Parent then prompt.Enabled = true end
	end)
	startGrowth(player, egg, info, zone)
end

local function clearEggTool(player)
	for _, container in {player.Character, player:FindFirstChild("Backpack")} do
		if container then
			for _, tool in container:GetChildren() do
				if tool:IsA("Tool") and tool:GetAttribute("EggId") then tool:Destroy() end
			end
		end
	end
end

-- Met l'oeuf dans la main du joueur ; il choisit ensuite où le poser (EggPlacementClient)
local function equipEgg(player, id)
	local d = data[player]
	local egg = d and findItem(d.Eggs, id)
	local character = player.Character
	local template = egg and eggTemplates:FindFirstChild(egg.Egg)
	if not egg or egg.Model or not character or not template then return end
	if countPlaced(d.Eggs) >= Config.MaxPlacedEggs then
		notify(player, "Maximum " .. Config.MaxPlacedEggs .. " eggs placed at once! Wait for them to hatch.")
		return
	end
	clearEggTool(player)

	local info = Config.Eggs[egg.Egg]
	local size = Config.SizeScale(egg.Kg, info.Kg)
	local tool = Instance.new("Tool")
	tool.Name = egg.Fused and eggTitle(egg, info) or info.Name
	tool.CanBeDropped = false
	tool:SetAttribute("EggId", egg.Id)
	tool:SetAttribute("EggKey", egg.Egg)
	tool:SetAttribute("SizeScale", size)

	local visual = template:Clone()
	visual:ScaleTo(visual:GetScale() * HELD_EGG_SCALE * math.min(size, HELD_MAX_SIZE))
	local heldHalf = EGG_HALF_HEIGHT * visual:GetScale()
	local handle = visual.PrimaryPart
	handle.Name = "Handle"
	for _, part in visual:GetChildren() do
		if part:IsA("BasePart") then
			part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.Massless = false, false, false, false, true
			if part ~= handle then
				local weld = Instance.new("WeldConstraint")
				weld.Part0, weld.Part1 = handle, part
				weld.Parent = part
			end
			part.Parent = tool
		end
	end
	visual:Destroy()
	tool.Grip = CFrame.new(0, -heldHalf, 0)

	-- ranger l'outil = annuler : l'oeuf reste dans l'inventaire
	tool.Unequipped:Connect(function()
		task.defer(function() tool:Destroy() end)
	end)
	tool.Parent = character
end

-- Pose l'oeuf équipé à l'endroit choisi. C'est là que la chance se joue : taille et mutation.
local function placeEgg(player, id, position)
	local d = data[player]
	local egg = d and findItem(d.Eggs, id)
	local zone = getAnimalZone(player)
	if not egg or egg.Model or not zone or typeof(position) ~= "Vector3" then return end
	if countPlaced(d.Eggs) >= Config.MaxPlacedEggs then
		notify(player, "Maximum " .. Config.MaxPlacedEggs .. " eggs placed at once! Wait for them to hatch.")
		return
	end
	local lp = zone.CFrame:PointToObjectSpace(position)
	if math.abs(lp.X) > zone.Size.X / 2 - EGG_MARGIN or math.abs(lp.Z) > zone.Size.Z / 2 - EGG_MARGIN then
		notify(player, "Place the egg in the animals area of your garden!")
		return
	end

	local info = Config.Eggs[egg.Egg]
	local cooldown
	if egg.Fused then
		-- œuf de la Fuse Machine : pas de tirage (poids et mutation viennent de la fusion), 1 h avant de pouvoir l'ouvrir
		egg.Mutation = egg.Fused.Mutation
		cooldown = FuseConfig.EggHatchTime
	else
		-- chance de kilos bonus (voir EggConfig.WeightTiers)
		local tier = rollChance(Config.WeightTiers, ShopConfig.HasPass(player, "WeightLuck") and 2 or 1)
		if tier then
			egg.Kg = math.min(egg.Kg + tier.Min + math.random() * (tier.Max - tier.Min), Config.MaxKg or 1e6) -- jamais plus de 1M kg
		end
		-- la nuit, pas de tirage : l'œuf garde seulement la mutation qu'il avait déjà (EggConfig.MutationsAllowed)
		local mutation = Config.MutationsAllowed() and rollChance(Config.Mutations, ShopConfig.HasPass(player, "MutationLuck") and 2 or 1)
		if mutation then egg.Mutation = mutation.Name end

		cooldown = isOwner(player) and Config.OwnerCooldown or info.Cooldown
		if ShopConfig.HasPass(player, "FastHatch") then cooldown = math.max(1, math.floor(cooldown / 2)) end
	end
	egg.ReadyAt = os.time() + cooldown
	egg.X, egg.Z = lp.X, lp.Z
	clearEggTool(player)
	spawnEgg(player, egg, zone, true)
	sync(player)
end

-- Bouton « Place all » du panneau des œufs : chaque œuf de l'inventaire est posé à un endroit libre du jardin, tant qu'il reste de la place
local function placeAllEggs(player)
	local d = data[player]
	local zone = getAnimalZone(player)
	if not d or not zone then return end
	local waiting = 0
	for _, egg in d.Eggs do if not egg.Model then waiting += 1 end end
	if waiting == 0 then notify(player, "You have no eggs to place!") return end
	local halfX, halfZ = math.max(zone.Size.X / 2 - EGG_MARGIN - 1, 0), math.max(zone.Size.Z / 2 - EGG_MARGIN - 1, 0)
	for _, egg in table.clone(d.Eggs) do
		if not egg.Model then
			if countPlaced(d.Eggs) >= Config.MaxPlacedEggs then
				notify(player, "Maximum " .. Config.MaxPlacedEggs .. " eggs placed at once! Wait for them to hatch.")
				break
			end
			placeEgg(player, egg.Id, (zone.CFrame * CFrame.new((math.random() * 2 - 1) * halfX, zone.Size.Y / 2, (math.random() * 2 - 1) * halfZ)).Position)
		end
	end
end

-- Achat : l'oeuf va dans l'inventaire avec un poids proche de la normale
local function buyEgg(player, eggName)
	local d = data[player]
	local info = Config.Eggs[eggName]
	if not d or not info then return end
	if info.ZoneOnly then return end -- œufs Halloween : seulement dans la zone Halloween, jamais à vendre
	if #d.Eggs >= Config.MaxEggs then
		notify(player, "You already have " .. Config.MaxEggs .. " eggs!")
		return
	end
	-- Check admin stock (nil = unlimited, 0 = out of stock)
	local stock = StockData.Stock[eggName]
	if stock ~= nil and stock <= 0 then
		notify(player, "Out of stock: " .. info.Name .. "!")
		return
	end
	local money = player:GetAttribute("Money") or 0
	if money < info.Price then
		notify(player, "Not enough money! You need " .. Config.FormatMoney(info.Price))
		return
	end
	player:SetAttribute("Money", money - info.Price)
	-- Decrement stock if limited
	if stock ~= nil and stock > 0 then
		StockData.Stock[eggName] = stock - 1
	end
	local kg = info.Kg * vary(Config.KgVariation)
	table.insert(d.Eggs, {Id = nextId(d), Egg = eggName, Kg = kg})
	notify(player, info.Name .. " (" .. Config.FormatKg(kg) .. ") added to your inventory!")
	sync(player)
end

-- boutique : le joueur doit être près du stand
remotes.BuyEgg.OnServerEvent:Connect(function(player, eggName)
	if type(eggName) ~= "string" then return end
	local shop = workspace:FindFirstChild("egg shop")
	local spot = shop and shop:FindFirstChild("EggSpot")
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not spot or not hrp or (hrp.Position - spot.Position).Magnitude > SHOP_RANGE then return end
	buyEgg(player, eggName)
end)

-- Supprime définitivement des animaux et des oeufs : selection = {Pets = {ids}, Eggs = {ids}}
local function deleteItems(player, selection)
	local d = data[player]
	if not d then return end
	local count = 0
	if type(selection.Pets) == "table" then
		for _, id in selection.Pets do
			local pet, index = findItem(d.Pets, id)
			if pet then
				removePetModel(pet)
				table.remove(d.Pets, index)
				count += 1
			end
		end
	end
	if type(selection.Eggs) == "table" then
		for _, id in selection.Eggs do
			local egg, index = findItem(d.Eggs, id)
			if egg and not egg.Model then -- les oeufs déjà posés ne se suppriment pas
				table.remove(d.Eggs, index)
				count += 1
			end
		end
		clearEggTool(player)
	end
	if count > 0 then sync(player) end
end

remotes.PetAction.OnServerEvent:Connect(function(player, action, id, position)
	if action == "Sync" then
		sync(player)
	elseif action == "UnequipEgg" then
		clearEggTool(player)
	elseif action == "HatchAll" then
		hatchAll(player)
	elseif action == "PlaceBest" then
		placeBest(player)
	elseif action == "PlaceAllEggs" then
		placeAllEggs(player)
	elseif action == "UpgradeGarden" then -- bouton « +1 Slot » du panneau des animaux
		if game:GetService("ServerStorage").GameBindables.UpgradeGarden:Invoke(player) then sync(player) end
	elseif action == "Delete" and type(id) == "table" then
		deleteItems(player, id)
	elseif type(id) == "number" then
		if action == "Place" then
			placePet(player, id)
		elseif action == "PickUp" then
			pickUpPet(player, id)
		elseif action == "PlacePetAt" then
			placePetAt(player, id, position)
		elseif action == "EquipPet" then
			equipPet(player, id)
		elseif action == "EquipEgg" then
			equipEgg(player, id)
		elseif action == "PlaceEgg" then
			placeEgg(player, id, position)
		end
	end
end)

---------------------------------------------------------------- Améliorations du dragon (stand Upgrades)
buyUpgrade.OnServerEvent:Connect(function(player, key)
	local d = data[player]
	local stat = type(key) == "string" and UpgradeConfig.Stats[key]
	if not d or not stat then return end
	local level = d.Upgrades[key] or 0
	if level >= stat.Max then
		notify(player, stat.Title .. " is already at max level!")
		return
	end
	local cost = UpgradeConfig.Cost(key, level)
	local money = player:GetAttribute("Money") or 0
	if money < cost then
		notify(player, "Not enough money! You need " .. Config.FormatMoney(cost))
		return
	end
	player:SetAttribute("Money", money - cost)
	d.Upgrades[key] = level + 1
	player:SetAttribute("Up_" .. key, level + 1)
end)

---------------------------------------------------------------- Boutique de dragons : acheter / équiper
dragonShop.OnServerEvent:Connect(function(player, action, key)
	local d = data[player]
	local dragon = type(key) == "string" and DragonConfig.Get(key)
	if not d or not dragon then return end
	if action == "Buy" then
		if d.OwnedDragons[key] then return end
		local money = player:GetAttribute("Money") or 0
		if money < dragon.Price then
			notify(player, "Not enough money! You need " .. Config.FormatMoney(dragon.Price))
			return
		end
		player:SetAttribute("Money", money - dragon.Price)
		d.OwnedDragons[key] = true
		local ownedList = {}
		for name in d.OwnedDragons do table.insert(ownedList, name) end
		player:SetAttribute("OwnedDragons", table.concat(ownedList, ","))
		notify(player, dragon.Name .. " unlocked!")
		action = "Equip" -- on monte tout de suite sur le dragon qu'on vient d'acheter
	end
	if action == "Equip" and d.OwnedDragons[key] and d.Dragon ~= key then
		d.Dragon = key
		player:SetAttribute("Dragon", key) -- DragonServer remplace le dragon du joueur
	end
end)

---------------------------------------------------------------- Oeuf ramené d'une zone d'oeufs jusqu'à la zone sûre
giveZoneEgg.OnInvoke = function(player, eggName, kg)
	local d = data[player]
	local info = Config.Eggs[eggName]
	if not d or not info then return false end
	if #d.Eggs >= Config.MaxEggs then
		notify(player, "Egg inventory full!")
		return false
	end
	table.insert(d.Eggs, {Id = nextId(d), Egg = eggName, Kg = kg or info.Kg})
	notify(player, info.Name .. " (" .. Config.FormatKg(kg or info.Kg) .. ") added to your inventory!")
	sync(player)
	return true
end

-- Animal éclos dans une zone (œuf brûlé par le dragon) et ramené jusqu'à la zone sûre : il va directement dans l'inventaire
game:GetService("ServerStorage"):WaitForChild("GameBindables"):WaitForChild("GiveZonePet").OnInvoke = function(player, petName, kg, trait, mutation)
	local d = data[player]
	local info = Config.Pets[petName]
	if not d or not info then return false end
	if #d.Pets >= Config.MaxInventory then
		notify(player, "Inventory full: " .. Config.MaxInventory .. " pets maximum!")
		return false
	end
	-- mutation venue d'un événement de zone (Concert x5) : seulement une mutation qui existe
	mutation = mutation and Config.GetMutation(mutation) and mutation or nil
	table.insert(d.Pets, {Id = nextId(d), Pet = petName, Kg = kg or info.Kg, Trait = (trait == "Witch" or trait == "Cowboy") and trait or nil, Mutation = mutation})
	notify(player, (trait and (trait .. " ") or "") .. (mutation and (mutation .. " ") or "") .. info.Name .. " (" .. Config.FormatKg(kg or info.Kg) .. ") added to your inventory!")
	sync(player)
	return true
end

-- Agrandissement du jardin (panneau UpgradeSign de la base)
game:GetService("ServerStorage"):WaitForChild("GameBindables"):WaitForChild("UpgradeGarden").OnInvoke = function(player)
	local d = data[player]
	if not d then return false end
	local level = d.Garden or 0
	local cost = Config.GardenCosts[level + 1]
	if not cost then
		notify(player, "Your garden is already at its maximum size!")
		return false
	end
	local money = player:GetAttribute("Money") or 0
	if money < cost then
		notify(player, "You need " .. Config.FormatMoney(cost) .. " to upgrade your garden!")
		return false
	end
	player:SetAttribute("Money", money - cost)
	d.Garden = level + 1
	player:SetAttribute("GardenLevel", d.Garden)
	notify(player, "Garden upgraded! You can now place " .. maxPlaced(player) .. " pets.")
	return true
end

---------------------------------------------------------------- Give Egg / Pet (from code redemption)
bindables.GiveEgg.Event:Connect(function(player, eggName)
	local d = data[player]
	local info = Config.Eggs[eggName]
	if not d or not info then return end
	if #d.Eggs >= Config.MaxEggs then
		remotes.Notify:FireClient(player, "Egg inventory full!")
		return
	end
	local kg = info.Kg * vary(Config.KgVariation)
	table.insert(d.Eggs, {Id = nextId(d), Egg = eggName, Kg = kg})
	sync(player)
end)

bindables.GivePet.Event:Connect(function(player, petName)
	local d = data[player]
	local info = Config.Pets[petName]
	if not d or not info then return end
	if #d.Pets >= Config.MaxInventory then
		remotes.Notify:FireClient(player, "Pet inventory full!")
		return
	end
	local kg = info.Kg * vary(PET_KG_VARIATION)
	table.insert(d.Pets, {Id = nextId(d), Pet = petName, Kg = kg})
	sync(player)
end)

---------------------------------------------------------------- Commande admin GLOBALSKIPFUSEEGG
-- Termine le timer (1 h) de tous les œufs de la Fuse Machine posés dans les bases, dans TOUS les serveurs.
-- L'heure de la commande est gardée dans un DataStore : les joueurs hors ligne en profitent aussi à leur retour.
-- Les œufs posés APRÈS la commande gardent leur timer normal.
local skipFuseEggsOf -- (player) : appelé aussi au chargement des données
do
	local MessagingService = require(game:GetService("ServerScriptService"):WaitForChild("GlobalBus")) -- (un seul abonnement pour tout le jeu : voir GlobalBus)
	local TOPIC, KEY = "AdminSkipFuseEgg", "SkipBefore"
	local skipBefore = 0
	local store
	pcall(function() store = DataStoreService:GetDataStore("FuseEggSkip_v1") end)
	local adminRemotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
	local skipRemote = adminRemotes:FindFirstChild("GlobalSkipFuseEgg") or Instance.new("RemoteEvent")
	skipRemote.Name = "GlobalSkipFuseEgg"
	skipRemote.Parent = adminRemotes
	local skippedRemote = adminRemotes:FindFirstChild("FuseEggSkipped") or Instance.new("RemoteEvent") -- texte « Admin Skipped your egg time ! »
	skippedRemote.Name = "FuseEggSkipped"
	skippedRemote.Parent = adminRemotes

	function skipFuseEggsOf(player)
		local d = data[player]
		if not d or skipBefore <= 0 then return 0 end
		local now, count = os.time(), 0
		for _, egg in d.Eggs do
			-- œuf fusionné posé avant la commande et qui couve encore
			if egg.Fused and egg.ReadyAt and egg.ReadyAt > now and egg.ReadyAt - FuseConfig.EggHatchTime <= skipBefore then
				egg.ReadyAt = now
				count += 1
				local model = egg.Model
				if model then
					model:SetAttribute("ReadyAt", now) -- le timer affiche « Ready! »
					local prompt = model:FindFirstChildWhichIsA("ProximityPrompt", true)
					if prompt then prompt.Enabled = true end -- on peut l'ouvrir tout de suite
				end
			end
		end
		if count > 0 then
			sync(player)
			skippedRemote:FireClient(player, count)
		end
		return count
	end

	local function apply(time)
		time = tonumber(time)
		if not time or time <= skipBefore then return end
		skipBefore = time
		for _, player in Players:GetPlayers() do task.spawn(skipFuseEggsOf, player) end
	end

	pcall(function()
		MessagingService:SubscribeAsync(TOPIC, function(message)
			apply(type(message.Data) == "table" and message.Data.time)
		end)
	end)
	-- relecture du DataStore (serveurs ouverts après la commande, ou message perdu)
	task.spawn(function()
		while true do
			if store then
				local ok, value = pcall(function() return store:GetAsync(KEY) end)
				if ok then apply(value) end
			end
			task.wait(60)
		end
	end)

	local last = 0
	skipRemote.OnServerEvent:Connect(function(player)
		if player:GetAttribute("IsAdmin") ~= true then return end
		if os.clock() - last < 3 then return end
		last = os.clock()
		local now = os.time()
		if store then
			pcall(function() store:UpdateAsync(KEY, function(old) return math.max(tonumber(old) or 0, now) end) end)
		end
		apply(now)
		local ok = pcall(function() MessagingService:PublishAsync(TOPIC, {time = now}) end)
		notify(player, ok and "GLOBALSKIPFUSEEGG: every Fuse egg placed in a base can be opened now, on ALL servers!"
			or "GLOBALSKIPFUSEEGG: done on this server (other servers get it within a minute).")
	end)
end

---------------------------------------------------------------- Pont pour le système de trade (TradeServer)
do
	local bridge = Instance.new("BindableFunction")
	bridge.Name = "TradeBridge"

	local function tradable(player)
		local d = data[player]
		local list = {}
		if d then
			for _, pet in d.Pets do
				if not pet.Model then -- seuls les animaux rangés dans l'inventaire sont échangeables
					table.insert(list, {Id = pet.Id, Pet = pet.Pet, Kg = pet.Kg, Mutation = pet.Mutation, Trait = pet.Trait})
				end
			end
		end
		return list
	end

	local function collect(d, ids)
		local seen, pets = {}, {}
		for _, id in ids do
			if seen[id] then return nil end
			seen[id] = true
			local pet = findItem(d.Pets, id)
			if not pet or pet.Model then return nil end
			table.insert(pets, pet)
		end
		return pets
	end

	bridge.OnInvoke = function(action, a, idsA, b, idsB)
		if action == "GetTradable" then return tradable(a) end
		if action == "PetList" then -- lecture seule (Content Creator Panel, PLAYER INFO) : les animaux du joueur, posés ou non
			local d = typeof(a) == "Instance" and data[a]
			if not d then return nil end
			local list = {}
			for _, pet in d.Pets do
				table.insert(list, {Pet = pet.Pet, Kg = pet.Kg, Mutation = pet.Mutation, Level = pet.Level, Placed = pet.Model ~= nil})
			end
			return list
		end
		-- échanges entre serveurs (TradeServer) : chaque serveur retire / donne les animaux de SON joueur
		if action == "Loaded" then
			local d = data[a]
			return d ~= nil and d.CanSave == true
		end
		if action == "Count" then
			local d = data[a]
			return d and #d.Pets or nil, Config.MaxInventory
		end
		if action == "Take" then -- retire les animaux offerts (rangés dans l'inventaire) et renvoie leurs fiches
			local d = data[a]
			if not d then return nil, "Your data is unavailable." end
			local pets = collect(d, idsA or {})
			if not pets then return nil, "One of your pets is no longer available." end
			local records = {}
			for _, pet in pets do
				table.remove(d.Pets, table.find(d.Pets, pet))
				table.insert(records, {Pet = pet.Pet, Kg = pet.Kg, Mutation = pet.Mutation, Trait = pet.Trait, Level = pet.Level, Xp = pet.Xp})
			end
			sync(a)
			return records
		end
		if action == "Give" then -- ajoute des animaux reçus (fiches)
			local d = data[a]
			if not d then return false end
			for _, rec in idsA or {} do
				if type(rec) == "table" and Config.Pets[rec.Pet] then
					table.insert(d.Pets, {Id = nextId(d), Pet = rec.Pet, Kg = tonumber(rec.Kg) or Config.Pets[rec.Pet].Kg,
						Mutation = rec.Mutation and Config.GetMutation(rec.Mutation) and rec.Mutation or nil,
						Trait = (rec.Trait == "Witch" or rec.Trait == "Cowboy") and rec.Trait or nil,
						Level = tonumber(rec.Level), Xp = tonumber(rec.Xp)})
				end
			end
			sync(a)
			return true
		end
		if action == "PetSpecies" then -- espèce de chaque pet proposé à la Fuse Machine (rangés dans l'inventaire)
			local d = data[a]
			local pets = d and collect(d, idsA or {})
			if not pets then return nil end
			local names = {}
			for _, pet in pets do table.insert(names, pet.Pet) end
			return names
		end
		if action == "GiveFusedEgg" then -- œuf fusionné (Fuse Machine) : idsA = fiche du pet obtenu
			local d, rec = data[a], idsA
			if not d or type(rec) ~= "table" or not Config.Pets[rec.Pet] then return false end
			local key = FuseConfig.EggKeyFor(rec.Pet, Config)
			local info = key and Config.Eggs[key]
			if not info then return false end
			local kg = tonumber(rec.Kg) or Config.Pets[rec.Pet].Kg
			table.insert(d.Eggs, {Id = nextId(d), Egg = key, Kg = math.max(kg, info.Kg),
				Fused = {Pet = rec.Pet, Kg = kg, Mutation = rec.Mutation, Trait = rec.Trait, Level = rec.Level, Xp = rec.Xp}})
			sync(a)
			return true
		end
		if action == "GetFuse" then -- fusion en cours dans la Fuse Machine (FuseServer)
			local d = data[a]
			return d and d.Fuse or nil
		end
		if action == "SetFuse" then
			local d = data[a]
			if not d then return false end
			d.Fuse = type(idsA) == "table" and idsA or nil
			return true
		end
		if action == "Save" then
			local f = script:FindFirstChild("TradeSave")
			if f then return f:Invoke(a) end
			return false
		end
		if action == "GiveEggs" then -- œufs achetés à la boutique : idsA = clé de l'œuf, idsB = nombre (un achat n'est jamais perdu : pas de limite d'inventaire ici)
			local d, info = data[a], Config.Eggs[idsA]
			local count = math.clamp(math.floor(tonumber(idsB) or 0), 0, 100)
			if not d or not info or count < 1 then return false end
			for _ = 1, count do table.insert(d.Eggs, {Id = nextId(d), Egg = idsA, Kg = info.Kg * vary(Config.KgVariation)}) end
			sync(a)
			return true
		end
		if action == "EggSpace" then
			local d = data[a]
			return d ~= nil and #d.Eggs < Config.MaxEggs
		end
		if action == "GiveEgg" then
			local d, info = data[a], Config.Eggs[idsA]
			if not d or not info or #d.Eggs >= Config.MaxEggs then return false end
			table.insert(d.Eggs, {Id = nextId(d), Egg = idsA, Kg = info.Kg * vary(Config.KgVariation)})
			sync(a)
			return true
		end
		if action ~= "Execute" then return false, "Unknown action." end
		local da, db = data[a], data[b]
		if not da or not db then return false, "A player's data is unavailable." end
		local petsA, petsB = collect(da, idsA), collect(db, idsB)
		if not petsA or not petsB then return false, "One of the pets is no longer available." end
		if #da.Pets - #petsA + #petsB > Config.MaxInventory then
			return false, a.DisplayName .. " does not have enough inventory space."
		end
		if #db.Pets - #petsB + #petsA > Config.MaxInventory then
			return false, b.DisplayName .. " does not have enough inventory space."
		end
		for _, pet in petsA do table.remove(da.Pets, table.find(da.Pets, pet)) end
		for _, pet in petsB do table.remove(db.Pets, table.find(db.Pets, pet)) end
		for _, pet in petsA do table.insert(db.Pets, {Id = nextId(db), Pet = pet.Pet, Kg = pet.Kg, Mutation = pet.Mutation, Trait = pet.Trait}) end
		for _, pet in petsB do table.insert(da.Pets, {Id = nextId(da), Pet = pet.Pet, Kg = pet.Kg, Mutation = pet.Mutation, Trait = pet.Trait}) end
		sync(a)
		sync(b)
		return true
	end

	bridge.Parent = script.Parent
end

---------------------------------------------------------------- Sauvegarde
-- Retrait unique des pets Secret (économie cassée) : chaque joueur perd ses pets Secret une seule fois, à sa prochaine connexion.
-- Pour refaire un retrait plus tard, passer à 2, 3...
local SECRET_PURGE_VERSION = 1
local OFFLINE_CAP = 12 * 3600 -- on compte au plus 12 h d'absence
local OFFLINE_RATE = 0.1      -- part du revenu gagnée hors ligne (0.1 = 10 fois moins qu'en ligne)
local OFFLINE_MIN = 30        -- pas de fenêtre pour une absence de moins de 30 s
local function serialize(player, d)
	local saved = {Money = (player:GetAttribute("Money") or 0) + (d.Offline or 0), Pets = {}, Eggs = {}} -- + argent hors ligne pas encore récupéré
	for _, pet in d.Pets do
		table.insert(saved.Pets, {Pet = pet.Pet, Kg = pet.Kg, Mutation = pet.Mutation, Trait = pet.Trait, Level = pet.Level, Xp = pet.Xp, Placed = pet.Model ~= nil or pet.WasPlaced == true})
	end
	for _, egg in d.Eggs do
		table.insert(saved.Eggs, {Egg = egg.Egg, Kg = egg.Kg, Tier = egg.Tier, Mutation = egg.Mutation, ReadyAt = egg.ReadyAt, X = egg.X, Z = egg.Z, Fused = egg.Fused})
	end
	saved.Rebirths = d.Rebirths or 0
	saved.Upgrades = d.Upgrades
	saved.Speed = player:GetAttribute("Speed") or 0 -- speed gagné sur le tapis (SpeedServer)
	saved.SpeedReset = 2 -- remises à zéro déjà faites : speed (1) + tapis au niveau 2 (2)
	saved.Treadmill = player:GetAttribute("TreadmillLevel") or 0
	saved.TreadmillV = 2 -- le tapis a 10 niveaux (avant : 50)
	saved.Hammer = player:GetAttribute("Hammer") or 1 -- meilleur marteau possédé (HammerServer)
	saved.OwnedHammers = player:GetAttribute("OwnedHammers") or "1" -- chaque marteau acheté ("1,4,9")
	saved.EquippedHammer = player:GetAttribute("EquippedHammer") or saved.Hammer
	saved.Trails = player:GetAttribute("Trails") or "" -- traînées possédées et équipée (TrailServer)
	saved.Trail = player:GetAttribute("Trail") or 0
	saved.Dragons = {Owned = {}, Equipped = d.Dragon}
	for key in d.OwnedDragons or {} do table.insert(saved.Dragons.Owned, key) end
	saved.Index = {}
	for name in d.Index or {} do table.insert(saved.Index, name) end
	saved.LastSeen = os.time() -- pour l'argent gagné hors ligne
	saved.Garden = d.Garden or 0
	saved.IndexRewards = {}
	for rarity in d.IndexRewards or {} do table.insert(saved.IndexRewards, rarity) end
	if d.SecretPurged then saved.SecretPurge = SECRET_PURGE_VERSION end -- les pets Secret ont déjà été retirés une fois
	if d.KrakenPurged then saved.KrakenPurge = 4 end -- retraits uniques déjà faits (v1 : Kraken/Megalodon, v2 : Crocodile, v3 : Leviathan, v4 : TOUS les pets Halloween)
	saved.Fuse = d.Fuse -- fusion en cours dans la Fuse Machine (les 3 pets, le résultat, l'heure de fin)
	return saved
end

local savingMap -- marqueur partagé entre serveurs : "ce joueur est en train d'être sauvegardé"
pcall(function() savingMap = game:GetService("MemoryStoreService"):GetSortedMap("SavingPlayers_v1") end)
local lastSaved = {}
-- un nombre invalide (NaN, infini) fait échouer TOUTE la sauvegarde : on les remplace avant d'écrire
local function clean(value, depth)
	if type(value) == "number" then
		if value ~= value then return 0 end
		if value == math.huge then return 1e300 end
		if value == -math.huge then return -1e300 end
		return value
	elseif type(value) == "table" and (depth or 0) < 8 then
		local out = {}
		for k, v in value do out[k] = clean(v, (depth or 0) + 1) end
		return out
	end
	return value
end
local function save(player)
	local d = data[player]
	if not d or not d.CanSave or not store then return end
	local saved = clean(serialize(player, d))
	local ok, err
	for attempt = 1, 3 do -- Roblox peut refuser une écriture (trop de requêtes) : on réessaie
		ok, err = pcall(function()
			store:UpdateAsync("u_" .. player.UserId, function() return saved end)
		end)
		if ok then break end
		task.wait(attempt * 1.5)
	end
	if ok then lastSaved[player.UserId] = os.clock() end
	if not ok then warn("[PetServer] sauvegarde ratée pour " .. player.Name .. " : " .. tostring(err)) end
	return ok
end
-- sauvegarde immédiate demandée par le système d'échange (après un échange)
do
	local f = Instance.new("BindableFunction")
	f.Name = "TradeSave"
	f.OnInvoke = function(player) return save(player) end
	f.Parent = script
end

-- reset global lancé par un admin (AdminToolsServer) : horodatage du dernier reset, partagé par tous les serveurs
local gameBindables = game:GetService("ServerStorage"):WaitForChild("GameBindables")
local function waitResetEpoch()
	local waited = 0
	while not gameBindables:GetAttribute("ResetEpochReady") and waited < 6 do waited += task.wait(0.2) end
	return gameBindables:GetAttribute("ResetEpoch") or 0
end

local function load(player)
	local d = {CanSave = false, NextId = 0, Pets = {}, Eggs = {}, Index = {}}
	local saved
	if savingMap then -- son ancien serveur n'a peut-être pas fini d'écrire sa sauvegarde : on attend (10 s au plus)
		local waited = 0
		while waited < 10 do
			local okMark, mark = pcall(function() return savingMap:GetAsync("u_" .. player.UserId) end)
			if not okMark or not mark then break end
			waited += task.wait(0.5)
		end
	end
	if store then
		local ok, result
		for attempt = 1, 5 do -- une lecture peut échouer un instant : on réessaie avant d'abandonner
			ok, result = pcall(function() return store:GetAsync("u_" .. player.UserId) end)
			if ok or not player.Parent or string.find(tostring(result), "Studio", 1, true) then break end -- (Studio sans accès aux données : inutile d'insister)
			task.wait(attempt)
		end
		if ok then
			saved = result
			d.CanSave = true -- on ne sauvegarde jamais par-dessus des données qu'on n'a pas pu lire
		else
			warn("[PetServer] chargement raté pour " .. player.Name .. " : " .. tostring(result))
			-- en jeu (pas dans Studio) : plutôt que de jouer avec un speed et un argent à zéro (qui ne seraient pas sauvegardés),
			-- le joueur est invité à revenir : ses vraies données l'attendent
			if not game:GetService("RunService"):IsStudio() and player.Parent then
				player:Kick("Your data could not be loaded (Roblox servers are busy). Please rejoin: nothing is lost!")
				return
			end
		end
	end
	if not player.Parent then return end
	local resetEpoch = waitResetEpoch()
	if saved and resetEpoch > 0 and (tonumber(saved.LastSeen) or 0) < resetEpoch then saved = nil end -- sauvegarde d'avant le reset global : on repart de zéro

	local startMoney = isOwner(player) and Config.OwnerStartMoney or Config.StartMoney
	player:SetAttribute("Money", saved and saved.Money or startMoney)
	d.Rebirths = saved and tonumber(saved.Rebirths) or 0 -- le rebirth a été retiré du jeu : la valeur est seulement conservée dans la sauvegarde
	-- dragons : celui de départ est toujours possédé
	d.OwnedDragons = {[DragonConfig.Starter] = true}
	local savedDragons = saved and type(saved.Dragons) == "table" and saved.Dragons or {}
	for _, key in type(savedDragons.Owned) == "table" and savedDragons.Owned or {} do
		if DragonConfig.Get(key) then d.OwnedDragons[key] = true end
	end
	d.Dragon = d.OwnedDragons[savedDragons.Equipped] and savedDragons.Equipped or DragonConfig.Starter
	local ownedList = {}
	for key in d.OwnedDragons do table.insert(ownedList, key) end
	player:SetAttribute("OwnedDragons", table.concat(ownedList, ","))
	player:SetAttribute("Dragon", d.Dragon)
	d.Upgrades = {}
	for key, stat in UpgradeConfig.Stats do
		local level = saved and type(saved.Upgrades) == "table" and tonumber(saved.Upgrades[key]) or 0
		d.Upgrades[key] = math.clamp(math.floor(level), 0, stat.Max)
		player:SetAttribute("Up_" .. key, d.Upgrades[key])
	end
	-- tapis de course : niveau et speed gagné (utilisés par SpeedServer)
	local treadmill = math.floor(saved and tonumber(saved.Treadmill) or 0)
	if saved and saved.TreadmillV ~= 2 then treadmill = math.floor(treadmill / 5) end -- ancienne sauvegarde : 50 niveaux, un tapis tous les 5
	-- REMISE À ZÉRO UNIQUE (le jeu était trop facile) : speed 0 = vitesse de course 16, et le tapis de course est ramené au
	-- niveau 2 au maximum (sinon le speed revient trop vite). Une seule fois par joueur : la suite est gardée normalement.
	-- SpeedReset : 1 = speed remis à zéro, 2 = speed + tapis ramené au niveau 2
	local resetDone = saved ~= nil and (tonumber(saved.SpeedReset) or 2) or math.huge -- (sauvegardes PlayerData_v3 : déjà faite)
	if resetDone < 2 then treadmill = math.min(treadmill, 2) end
	-- jusqu'au tapis Galactic (niveau 11, update Galactic) : le niveau acheté est toujours gardé, même si l'update charge après
	local SpeedConfig = require(ReplicatedStorage:WaitForChild("SpeedSystem"):WaitForChild("SpeedConfig"))
	player:SetAttribute("TreadmillLevel", math.clamp(treadmill, 0, SpeedConfig.GalacticMaxLevel or 11))
	local speedReset = resetDone < 1
	player:SetAttribute("Speed", speedReset and 0 or math.max(saved and tonumber(saved.Speed) or 0, 0))
	-- marteaux : 20 niveaux (avant, la valeur était bloquée à 6 au chargement : les marteaux 7 à 20 étaient perdus en revenant)
	local hammerCount = #require(game:GetService("ReplicatedStorage"):WaitForChild("HammerSystem"):WaitForChild("HammerConfig")).Tiers
	local bestHammer = math.clamp(math.floor(saved and tonumber(saved.Hammer) or 1), 1, hammerCount)
	local ownedHammers = {[1] = true}
	if saved and type(saved.OwnedHammers) == "string" then
		for n in string.gmatch(saved.OwnedHammers, "%d+") do
			local tier = tonumber(n)
			if tier >= 1 and tier <= hammerCount then ownedHammers[tier] = true end
		end
	else
		for tier = 1, bestHammer do ownedHammers[tier] = true end -- ancienne sauvegarde : on avait tous ceux d'en dessous
	end
	local ownedList = {}
	for tier in ownedHammers do table.insert(ownedList, tier) bestHammer = math.max(bestHammer, tier) end
	table.sort(ownedList)
	player:SetAttribute("OwnedHammers", table.concat(ownedList, ","))
	local equippedHammer = math.floor(saved and tonumber(saved.EquippedHammer) or bestHammer)
	player:SetAttribute("EquippedHammer", ownedHammers[equippedHammer] and equippedHammer or bestHammer)
	player:SetAttribute("Hammer", bestHammer)
	player:SetAttribute("Trails", saved and type(saved.Trails) == "string" and saved.Trails or "")
	player:SetAttribute("Trail", saved and tonumber(saved.Trail) or 0)
	-- agrandissements du jardin (cette ligne s'était retrouvée dans le rebirth : le niveau n'était jamais relu au chargement)
	d.Garden = math.clamp(math.floor(saved and tonumber(saved.Garden) or 0), 0, #Config.GardenCosts)
	player:SetAttribute("GardenLevel", d.Garden)
	d.IndexRewards = {}
	for _, rarity in (saved and type(saved.IndexRewards) == "table" and saved.IndexRewards) or {} do d.IndexRewards[rarity == "Halloween" and "Prismatic" or rarity] = true end
	local removedSecrets = 0
	local mustPurge = saved ~= nil and (tonumber(saved.SecretPurge) or 0) < SECRET_PURGE_VERSION
	d.SecretPurged = true
	-- RETRAITS UNIQUES : pets retirés des bases et inventaires (ainsi que leurs œufs), une seule fois par joueur ;
	-- ceux gagnés ensuite sont gardés. Le chiffre = la version du retrait qui les enlève.
	local PURGED_PETS = {Kraken = 1, Megalodon = 1, Crocodile = 2, Leviathan = 3}
	local PURGED_EGGS = {KrakenEgg = 1, MegalodonEgg = 1, CrocodileEgg = 2, LeviathanEgg = 3}
	local PURGED_RARITY = {Prismatic = 4} -- v4 : tous les pets et œufs de la zone Halloween (les joueurs doivent les re-farmer)
	local purgeDone = saved ~= nil and (tonumber(saved.KrakenPurge) or 0) or math.huge
	local function purged(map, name)
		if map[name] ~= nil and map[name] > purgeDone then return true end
		local info = (map == PURGED_EGGS and Config.Eggs or Config.Pets)[name]
		local byRarity = info and PURGED_RARITY[info.Rarity]
		return byRarity ~= nil and byRarity > purgeDone
	end
	local purgeBig = purgeDone < 4
	d.KrakenPurged = true
	if saved then
		-- sauvegardes d'avant les animaux en mesh : un animal ou un œuf qui n'existe plus devient celui du même rang (EggConfig.LegacyPets / LegacyEggs)
		for _, name in saved.Index or {} do
			name = Config.Pets[name] and name or Config.LegacyPets[name]
			if name then d.Index[name] = true end
		end
		for _, pet in saved.Pets or {} do
			if not Config.Pets[pet.Pet] and Config.LegacyPets[pet.Pet] then
				pet.Pet, pet.Kg = Config.LegacyPets[pet.Pet], nil -- poids normal du nouvel animal
			end
		end
		for _, egg in saved.Eggs or {} do
			if not Config.Eggs[egg.Egg] and Config.LegacyEggs[egg.Egg] then egg.Egg, egg.Kg = Config.LegacyEggs[egg.Egg], nil end
		end
		-- les objets sauvegardés avant le système de kilos reçoivent le poids normal
		for _, pet in saved.Pets or {} do
			local info = Config.Pets[pet.Pet]
			if info and mustPurge and info.Rarity == "Secret" then
				removedSecrets += 1 -- pet Secret retiré (retrait unique)
			elseif info and purgeBig and purged(PURGED_PETS, pet.Pet) then
				-- pet Halloween retiré (retrait unique)
			elseif info and #d.Pets < Config.MaxInventory then
				table.insert(d.Pets, {Id = nextId(d), Pet = pet.Pet, Kg = math.max(pet.Kg or info.Kg, info.Kg), Mutation = pet.Mutation, Trait = pet.Trait, Level = pet.Level, Xp = pet.Xp, WasPlaced = pet.Placed})
			end
		end
		for _, egg in saved.Eggs or {} do
			local info = Config.Eggs[egg.Egg]
			local purgedEgg = purgeBig and (purged(PURGED_EGGS, egg.Egg) or (type(egg.Fused) == "table" and purged(PURGED_PETS, egg.Fused.Pet)))
			if info and not purgedEgg then
				local fused = type(egg.Fused) == "table" and Config.Pets[egg.Fused.Pet] and egg.Fused or nil
				table.insert(d.Eggs, {Id = nextId(d), Egg = egg.Egg, Kg = math.max(egg.Kg or info.Kg, info.Kg), Tier = egg.Tier, Mutation = egg.Mutation, ReadyAt = egg.ReadyAt, X = egg.X, Z = egg.Z, Fused = fused})
			end
		end
	end
	-- fusion en cours dans la Fuse Machine : gardée telle quelle si elle est valide
	local fuse = saved and saved.Fuse
	if type(fuse) == "table" and type(fuse.Result) == "table" and Config.Pets[fuse.Result.Pet] and tonumber(fuse.Ends) and tonumber(fuse.Start)
		and not (purgeBig and purged(PURGED_PETS, fuse.Result.Pet)) then
		d.Fuse = fuse
	end
	data[player] = d

	-- remet dans le jardin ce qui y était (une fois la base attribuée)
	local waited = 0
	while player.Parent and not getAnimalZone(player) and waited < BASE_WAIT do
		waited += task.wait(0.2)
	end
	local zone = getAnimalZone(player)
	if zone and data[player] == d then
		for _, pet in d.Pets do
			if pet.WasPlaced and countPlaced(d.Pets) < maxPlaced(player) then
				spawnPet(player, pet, zone, randomZoneXZ(zone))
			end
		end
		for _, egg in d.Eggs do
			if egg.ReadyAt and egg.X and egg.Z then spawnEgg(player, egg, zone) end
		end
	end
	if data[player] == d then skipFuseEggsOf(player) end -- skip admin des œufs fusionnés fait pendant qu'il était hors ligne
	for _, pet in d.Pets do pet.WasPlaced = nil end
	sync(player)
	if removedSecrets > 0 then
		notify(player, removedSecrets .. " Secret pet(s) were removed to fix the economy. Go catch new ones!")
		task.spawn(save, player) -- on enregistre tout de suite le retrait
	end

	-- argent gagné hors ligne : revenu des animaux posés x temps d'absence (plafonné), à récupérer dans la fenêtre "Welcome back!"
	local lastSeen = saved and tonumber(saved.LastSeen)
	if lastSeen and data[player] == d then
		local away = math.min(os.time() - lastSeen, OFFLINE_CAP)
		local income = 0
		for _, pet in d.Pets do
			if pet.Model then income += pet.Income or 0 end
		end
		local amount = math.floor(income * ShopConfig.MoneyMult(player) * away * OFFLINE_RATE)
		if away >= OFFLINE_MIN and amount > 0 then
			d.Offline = amount
			player:SetAttribute("OfflineSeconds", away)
			player:SetAttribute("OfflineMoney", amount)
		end
	end
end

local OFFLINE_DOUBLE_PRODUCT = 0 -- id du produit Robux "Double it!" (0 = pas encore créé)
game:GetService("ReplicatedStorage"):WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("ClaimOffline").OnServerEvent:Connect(function(player, double)
	local d = data[player]
	if not d or not d.Offline then return end
	if double == true then
		if OFFLINE_DOUBLE_PRODUCT == 0 then
			notify(player, "Double it is coming soon!")
		else
			game:GetService("MarketplaceService"):PromptProductPurchase(player, OFFLINE_DOUBLE_PRODUCT)
		end
		return
	end
	local amount = d.Offline
	d.Offline = nil
	player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + amount)
	player:SetAttribute("OfflineMoney", nil)
	notify(player, "+" .. Config.FormatMoney(amount) .. " earned while you were away!")
end)

-- reset d'un joueur connecté (admin) : argent, animaux, œufs, améliorations, dragons, index... tout est effacé
local wiping = {}
local function wipe(player)
	if wiping[player] or not player.Parent then return end
	wiping[player] = true
	local d = data[player]
	data[player] = nil
	if d then
		for _, list in {d.Pets, d.Eggs} do
			for _, item in list do
				if item.Model then item.Model:Destroy() end
			end
		end
	end
	local base = getBase(player)
	local display = base and base:FindFirstChild("BaseDisplay")
	local label = display and display:FindFirstChild("CashPerSecond", true)
	if label then label.Text = "$0/s" end
	player:SetAttribute("OfflineMoney", nil)
	player:SetAttribute("OfflineSeconds", nil)
	if store then pcall(function() store:RemoveAsync("u_" .. player.UserId) end) end
	if player.Parent then load(player) end
	wiping[player] = nil
end
gameBindables:WaitForChild("WipePlayer").Event:Connect(function(player) task.spawn(wipe, player) end)

Players.PlayerAdded:Connect(load)
for _, player in Players:GetPlayers() do task.spawn(load, player) end

Players.PlayerRemoving:Connect(function(player)
	local key = "u_" .. player.UserId
	if savingMap then pcall(function() savingMap:SetAsync(key, 1, 30) end) end
	if not (lastSaved[player.UserId] and os.clock() - lastSaved[player.UserId] < 1.5) then save(player) end -- pas deux écritures coup sur coup
	if savingMap then pcall(function() savingMap:RemoveAsync(key) end) end
	local d = data[player]
	data[player] = nil
	if not d then return end
	for _, list in {d.Pets, d.Eggs} do
		for _, item in list do
			if item.Model then item.Model:Destroy() end
		end
	end
	-- la base redevient vide
	local base = getBase(player)
	local display = base and base:FindFirstChild("BaseDisplay")
	local label = display and display:FindFirstChild("CashPerSecond", true)
	if label then label.Text = "$0/s" end
end)

task.spawn(function()
	while true do
		task.wait(AUTOSAVE_INTERVAL)
		for _, player in Players:GetPlayers() do task.spawn(save, player) end
	end
end)

game:BindToClose(function()
	local pending = 0
	for _, player in Players:GetPlayers() do
		pending += 1
		task.spawn(function()
			save(player)
			pending -= 1
		end)
	end
	local waited = 0
	while pending > 0 and waited < 27 do waited += task.wait(0.1) end
end)
