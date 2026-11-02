-- Graines et plantes : boutique, plantation dans la zone "plantes", pousse, récolte dans l'inventaire,
-- plante en main pour nourrir les animaux, suppression, sauvegarde
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local DataStoreService = game:GetService("DataStoreService")
local CollectionService = game:GetService("CollectionService")

local eggSystem = ReplicatedStorage:WaitForChild("EggSystem")
local EggConfig = require(eggSystem.EggConfig)
local notifyRemote = eggSystem.Remotes.Notify

local system = ReplicatedStorage:WaitForChild("PlantSystem")
local Config = require(system.PlantConfig)
local remotes = system.Remotes
local cropTemplates = system.CropModels
local bases = workspace:WaitForChild("all base")
local consumeHeldCrop = ServerStorage:WaitForChild("GameBindables"):WaitForChild("ConsumeHeldCrop") -- appelé par PetServer

local STORE_NAME = "PlantData_v2"
local AUTOSAVE_INTERVAL = 120
local BASE_WAIT = 10       -- secondes max à attendre l'attribution de la base
local SHOP_RANGE = 30      -- distance max du stand pour acheter
local ZONE_MARGIN = 1.5    -- distance min entre une plante et le bord de la zone
local HELD_CROP_SCALE = 0.35
local HELD_MAX_SIZE = 1.8  -- une plante géante ne grossit pas plus que ça dans la main
local SACK_COLOR = Color3.fromRGB(214, 186, 132)

local store
do
	local ok, result = pcall(function() return DataStoreService:GetDataStore(STORE_NAME) end)
	if ok then store = result else warn("[PlantServer] DataStore indisponible : " .. tostring(result)) end
end

local placedPlants = Instance.new("Folder")
placedPlants.Name = "PlacedPlants"
placedPlants.Parent = workspace

-- [player] = {CanSave, NextId,
--   Seeds = {[nom] = nombre},
--   Plants = {{Id, Seed, X, Z, PlantedAt, ReadyAt, Kg, Mutation?, Model?}},   -- en terre
--   Crops = {{Id, Crop, Kg, Mutation?}}}                                      -- récoltées, dans l'inventaire
local data = {}

local function notify(player, text)
	notifyRemote:FireClient(player, text)
end

local ShopConfig = require(game:GetService("ReplicatedStorage"):WaitForChild("ShopSystem"):WaitForChild("ShopConfig"))

local function rollChance(list, luck)
	local roll = math.random() * 100
	for _, entry in list do
		roll -= entry.Chance * (luck or 1)
		if roll <= 0 then return entry end
	end
	return nil
end

local function nextId(d)
	d.NextId += 1
	return d.NextId
end

local function findCrop(d, id)
	for index, crop in d.Crops do
		if crop.Id == id then return crop, index end
	end
	return nil
end

local function countSeeds(d)
	local total = 0
	for _, count in d.Seeds do total += count end
	return total
end

local function sync(player)
	local d = data[player]
	if not d then return end
	local seeds, crops = {}, {}
	for name, count in d.Seeds do
		if count > 0 and Config.Seeds[name] then table.insert(seeds, {Seed = name, Count = count}) end
	end
	table.sort(seeds, function(a, b) return Config.Seeds[a.Seed].Order < Config.Seeds[b.Seed].Order end)
	for _, crop in d.Crops do
		table.insert(crops, {Id = crop.Id, Crop = crop.Crop, Kg = crop.Kg, Mutation = crop.Mutation})
	end
	remotes.SeedsUpdated:FireClient(player, {Seeds = seeds, Crops = crops, Planted = #d.Plants})
end

---------------------------------------------------------------- Zone "plantes" de la base
local function getPlantZone(player)
	local number = player:GetAttribute("BaseNumber")
	local base = number and bases:FindFirstChild("base " .. number)
	return base and base:FindFirstChild("plantes")
end

local function zonePoint(zone, x, z)
	return (zone.CFrame * CFrame.new(x, zone.Size.Y / 2, z)).Position
end

---------------------------------------------------------------- Plantes en terre
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

	local mutation = mutationName and EggConfig.GetMutation(mutationName)
	local gradientColor = (mutation and not mutation.Color and EggConfig.Gradients[mutationName]) or (not mutation and rarity and EggConfig.Gradients[rarity])
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

local function cropTitle(seedName, mutationName)
	local name = Config.Seeds[seedName].Name
	return mutationName and (mutationName .. " " .. name) or name
end

local harvest -- défini plus bas

local function spawnPlant(player, plant, zone, justPlanted)
	local template = cropTemplates:FindFirstChild(plant.Seed)
	local info = Config.Seeds[plant.Seed]
	if not template or not info then return end
	local model = template:Clone()
	local root = model.PrimaryPart
	local fullScale = EggConfig.SizeScale(plant.Kg) -- plus lourd = plus gros
	local ready = os.time() >= plant.ReadyAt
	local title = cropTitle(plant.Seed, plant.Mutation)
	EggConfig.ApplyMutation(model, plant.Mutation)

	-- PlantClient fait grossir la plante entre PlantedAt et ReadyAt
	model:SetAttribute("Owner", player.UserId)
	model:SetAttribute("PlantId", plant.Id)
	model:SetAttribute("Title", title)
	model:SetAttribute("PlantedAt", plant.PlantedAt)
	model:SetAttribute("ReadyAt", plant.ReadyAt)
	model:SetAttribute("FullScale", fullScale)
	model:SetAttribute("Mutation", plant.Mutation)
	model:SetAttribute("JustPlanted", justPlanted and workspace:GetServerTimeNow() or nil)
	model.ModelStreamingMode = Enum.ModelStreamingMode.Atomic
	model:ScaleTo(fullScale * (ready and 1 or Config.StartScale))
	model:PivotTo(CFrame.new(zonePoint(zone, plant.X, plant.Z)) * CFrame.Angles(0, math.random() * math.pi * 2, 0))

	local _, bounds = template:GetBoundingBox()
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "PlantLabel"
	billboard.LightInfluence = 0
	billboard.MaxDistance = 70
	billboard.Size = UDim2.new(5, 0, 2.4, 0)
	billboard.StudsOffsetWorldSpace = Vector3.new(0, bounds.Y * fullScale + 1.6, 0)
	makeLabel(billboard, "PlantName", title, UDim2.fromScale(0, 0), UDim2.fromScale(1, 0.38), info.Rarity, plant.Mutation)
	makeLabel(billboard, "Kg", EggConfig.FormatKg(plant.Kg), UDim2.fromScale(0.2, 0.39), UDim2.fromScale(0.6, 0.25))
	makeLabel(billboard, "Timer", "", UDim2.fromScale(0.1, 0.65), UDim2.fromScale(0.8, 0.34)) -- rempli par PlantClient
	billboard.Parent = root

	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Harvest"
	prompt.ObjectText = title
	prompt.HoldDuration = 0.2
	prompt.MaxActivationDistance = 8 + bounds.Y * fullScale / 2
	prompt.RequiresLineOfSight = false
	prompt.Enabled = ready
	prompt.Parent = root
	prompt.Triggered:Connect(function(who)
		if who == player then
			harvest(player, plant)
		else
			notify(who, "This is not your plant!")
		end
	end)

	model.Parent = placedPlants
	plant.Model = model
	if not ready then
		task.delay(plant.ReadyAt - os.time(), function()
			if plant.Model ~= model or not model.Parent then return end
			model:ScaleTo(fullScale)
			prompt.Enabled = true
		end)
	end
end

-- Récolte : la plante va dans l'inventaire (onglet Plantes) ; elle sert à nourrir les animaux
function harvest(player, plant, quiet)
	local d = data[player]
	if not d or not plant.Model or os.time() < plant.ReadyAt then return false end
	local index = table.find(d.Plants, plant)
	if not index then return false end
	if #d.Crops >= Config.MaxCrops then
		notify(player, "Crop inventory full (" .. Config.MaxCrops .. " max)! Feed your pets or delete some crops.")
		return false
	end
	local position = plant.Model:GetPivot().Position
	table.remove(d.Plants, index)
	plant.Model:Destroy()
	plant.Model = nil
	table.insert(d.Crops, {Id = nextId(d), Crop = plant.Seed, Kg = plant.Kg, Mutation = plant.Mutation})
	remotes.Harvested:FireClient(player, position, cropTitle(plant.Seed, plant.Mutation), Config.Seeds[plant.Seed].Color)
	if not quiet then sync(player) end
	return true
end

local function harvestAll(player)
	local d = data[player]
	if not d then return end
	for _, plant in table.clone(d.Plants) do
		if plant.Model and os.time() >= plant.ReadyAt then
			if not harvest(player, plant, true) then break end
		end
	end
	sync(player)
end

---------------------------------------------------------------- Objets en main : sachet de graines ou plante récoltée
local function clearTools(player)
	for _, container in {player.Character, player:FindFirstChild("Backpack")} do
		if container then
			for _, tool in container:GetChildren() do
				if tool:IsA("Tool") and (tool:GetAttribute("SeedName") or tool:GetAttribute("CropId")) then tool:Destroy() end
			end
		end
	end
end

-- un seul objet en main à la fois : on range aussi l'oeuf éventuel
local function clearHands(player)
	clearTools(player)
	local character = player.Character
	if not character then return end
	for _, tool in character:GetChildren() do
		if tool:IsA("Tool") and tool:GetAttribute("EggId") then tool:Destroy() end
	end
end

local function weldTo(handle, part)
	part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.Massless = false, false, false, false, true
	local weld = Instance.new("WeldConstraint")
	weld.Part0, weld.Part1 = handle, part
	weld.Parent = part
end

local function sackPart(tool, handle, size, offset, color)
	local part = Instance.new("Part")
	part.Size = size
	part.Color = color
	part.CFrame = handle.CFrame * offset
	part.TopSurface, part.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
	weldTo(handle, part)
	part.Parent = tool
end

local function finishTool(player, tool)
	tool.CanBeDropped = false
	tool.Unequipped:Connect(function() -- ranger l'outil = annuler
		task.defer(function() tool:Destroy() end)
	end)
	tool.Parent = player.Character
end

-- Sachet de graines en main ; le joueur clique ensuite dans sa zone "plantes" (SeedPlantingClient)
local function equipSeed(player, seedName)
	local d = data[player]
	local info = Config.Seeds[seedName]
	if not d or not info or not player.Character or (d.Seeds[seedName] or 0) <= 0 then return end
	clearHands(player)

	local tool = Instance.new("Tool")
	tool.Name = info.Name .. " Seed"
	tool:SetAttribute("SeedName", seedName)
	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(1.1, 1.3, 0.7)
	handle.Color = SACK_COLOR
	handle.CanCollide, handle.CanQuery, handle.CanTouch, handle.Massless = false, false, false, true
	handle.TopSurface, handle.BottomSurface = Enum.SurfaceType.Studs, Enum.SurfaceType.Smooth
	handle.Parent = tool
	sackPart(tool, handle, Vector3.new(0.8, 0.3, 0.5), CFrame.new(0, 0.8, 0), SACK_COLOR)                       -- haut du sachet froncé
	sackPart(tool, handle, Vector3.new(0.9, 0.12, 0.6), CFrame.new(0, 0.62, 0), Color3.fromRGB(150, 100, 60))   -- ficelle
	sackPart(tool, handle, Vector3.new(0.7, 0.7, 0.08), CFrame.new(0, -0.05, -0.38), info.Color)                -- étiquette de la couleur de la plante
	sackPart(tool, handle, Vector3.new(0.3, 0.3, 0.1), CFrame.new(0, -0.05, -0.43), Color3.new(1, 1, 1))
	tool.Grip = CFrame.new(0, -0.5, 0)
	finishTool(player, tool)
end

-- Plante récoltée en main ; le joueur va ensuite voir un de ses animaux et le nourrit (prompt "Nourrir")
local function equipCrop(player, id)
	local d = data[player]
	local crop = d and findCrop(d, id)
	local template = crop and cropTemplates:FindFirstChild(crop.Crop)
	if not crop or not template or not player.Character then return end
	clearHands(player)

	local tool = Instance.new("Tool")
	tool.Name = cropTitle(crop.Crop, crop.Mutation)
	tool:SetAttribute("CropId", crop.Id)
	local visual = template:Clone()
	EggConfig.ApplyMutation(visual, crop.Mutation)
	visual:ScaleTo(HELD_CROP_SCALE * math.min(EggConfig.SizeScale(crop.Kg), HELD_MAX_SIZE))
	local handle = visual.PrimaryPart
	handle.Name = "Handle"
	for _, part in visual:GetChildren() do
		if part:IsA("BasePart") then
			if part ~= handle then weldTo(handle, part) end
			part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.Massless = false, false, false, false, true
			part.Parent = tool
		end
	end
	visual:Destroy()
	finishTool(player, tool)
end

-- PetServer demande la plante tenue en main pour nourrir un animal : on la retire et on renvoie son XP
consumeHeldCrop.OnInvoke = function(player)
	local d = data[player]
	local character = player.Character
	if not d or not character then return nil end
	for _, tool in character:GetChildren() do
		local id = tool:IsA("Tool") and tool:GetAttribute("CropId")
		if id then
			local crop, index = findCrop(d, id)
			if not crop then return nil end
			table.remove(d.Crops, index)
			tool:Destroy()
			sync(player)
			return Config.GetXp(crop.Crop, crop.Kg, crop.Mutation)
		end
	end
	return nil
end

-- Plante une graine à l'endroit choisi. C'est là que la chance se joue : kilos bonus et mutation.
local function plantSeed(player, seedName, position)
	local d = data[player]
	local info = Config.Seeds[seedName]
	local zone = getPlantZone(player)
	if not d or not info or not zone or typeof(position) ~= "Vector3" or (d.Seeds[seedName] or 0) <= 0 then return end
	if #d.Plants >= Config.MaxPlanted then
		notify(player, "Maximum " .. Config.MaxPlanted .. " plants at once! Harvest first.")
		return
	end
	local lp = zone.CFrame:PointToObjectSpace(position)
	if math.abs(lp.X) > zone.Size.X / 2 - ZONE_MARGIN or math.abs(lp.Z) > zone.Size.Z / 2 - ZONE_MARGIN then
		notify(player, "Plant the seed in the plants area of your garden!")
		return
	end
	for _, other in d.Plants do
		if (Vector2.new(other.X, other.Z) - Vector2.new(lp.X, lp.Z)).Magnitude < Config.MinSpacing then
			notify(player, "Too close to another plant!")
			return
		end
	end

	d.Seeds[seedName] -= 1
	if d.Seeds[seedName] <= 0 then
		d.Seeds[seedName] = nil
		clearTools(player) -- plus de graines de cette sorte : on range le sachet
	end

	local kg = info.Kg * (1 + (math.random() * 2 - 1) * EggConfig.KgVariation)
	local tier = rollChance(EggConfig.WeightTiers, ShopConfig.HasPass(player, "WeightLuck") and 2 or 1)
	if tier then kg += tier.Min + math.random() * (tier.Max - tier.Min) end
	local mutation = rollChance(EggConfig.Mutations, ShopConfig.HasPass(player, "MutationLuck") and 2 or 1)

	local now = os.time()
	local plant = {
		Id = nextId(d), Seed = seedName, X = lp.X, Z = lp.Z, Kg = kg,
		Mutation = mutation and mutation.Name or nil,
		PlantedAt = now, ReadyAt = now + Config.GetGrowTime(seedName, kg, player.UserId), -- plus lourd = plus long
	}
	table.insert(d.Plants, plant)
	spawnPlant(player, plant, zone, true)
	sync(player)
end

-- Achat au stand : la graine va dans l'inventaire
local function buySeed(player, seedName)
	local d = data[player]
	local info = Config.Seeds[seedName]
	if not d or not info then return end
	if countSeeds(d) >= Config.MaxSeeds then
		notify(player, "You already have " .. Config.MaxSeeds .. " seeds!")
		return
	end
	local money = player:GetAttribute("Money") or 0
	if money < info.Price then
		notify(player, "Not enough money! You need " .. EggConfig.FormatMoney(info.Price))
		return
	end
	player:SetAttribute("Money", money - info.Price)
	d.Seeds[seedName] = (d.Seeds[seedName] or 0) + 1
	sync(player)
end

-- Supprime définitivement des graines et des plantes récoltées : selection = {Seeds = {noms}, Crops = {ids}}
local function deleteItems(player, selection)
	local d = data[player]
	if not d then return end
	if type(selection.Seeds) == "table" then
		for _, name in selection.Seeds do
			if type(name) == "string" then d.Seeds[name] = nil end
		end
	end
	if type(selection.Crops) == "table" then
		for _, id in selection.Crops do
			local _, index = findCrop(d, id)
			if index then table.remove(d.Crops, index) end
		end
	end
	clearTools(player)
	sync(player)
end

remotes.BuySeed.OnServerEvent:Connect(function(player, seedName)
	if type(seedName) ~= "string" then return end
	local shop = workspace:FindFirstChild("seed shop")
	local spot = shop and shop:FindFirstChild("SeedSpot")
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not spot or not hrp or (hrp.Position - spot.Position).Magnitude > SHOP_RANGE then return end
	buySeed(player, seedName)
end)

remotes.SeedAction.OnServerEvent:Connect(function(player, action, target, position)
	if action == "Sync" then
		sync(player)
	elseif action == "Unequip" then
		clearTools(player)
	elseif action == "HarvestAll" then
		harvestAll(player)
	elseif action == "Delete" and type(target) == "table" then
		deleteItems(player, target)
	elseif action == "EquipCrop" and type(target) == "number" then
		equipCrop(player, target)
	elseif type(target) == "string" then
		if action == "Equip" then
			equipSeed(player, target)
		elseif action == "Plant" then
			plantSeed(player, target, position)
		end
	end
end)

---------------------------------------------------------------- Sauvegarde
local function save(player)
	local d = data[player]
	if not d or not d.CanSave or not store then return end
	local saved = {Seeds = {}, Plants = {}, Crops = {}, SavedAt = os.time()}
	for name, count in d.Seeds do saved.Seeds[name] = count end
	for _, plant in d.Plants do
		table.insert(saved.Plants, {Seed = plant.Seed, X = plant.X, Z = plant.Z, Kg = plant.Kg, Mutation = plant.Mutation, PlantedAt = plant.PlantedAt, ReadyAt = plant.ReadyAt})
	end
	for _, crop in d.Crops do
		table.insert(saved.Crops, {Crop = crop.Crop, Kg = crop.Kg, Mutation = crop.Mutation})
	end
	local ok, err = pcall(function() store:SetAsync("u_" .. player.UserId, saved) end)
	if not ok then warn("[PlantServer] sauvegarde ratée pour " .. player.Name .. " : " .. tostring(err)) end
end

-- reset global lancé par un admin (AdminToolsServer) : horodatage du dernier reset, partagé par tous les serveurs
local gameBindables = game:GetService("ServerStorage"):WaitForChild("GameBindables")
local function waitResetEpoch()
	local waited = 0
	while not gameBindables:GetAttribute("ResetEpochReady") and waited < 6 do waited += task.wait(0.2) end
	return gameBindables:GetAttribute("ResetEpoch") or 0
end

local function load(player)
	local d = {CanSave = false, NextId = 0, Seeds = {}, Plants = {}, Crops = {}}
	local saved
	if store then
		local ok, result = pcall(function() return store:GetAsync("u_" .. player.UserId) end)
		if ok then
			saved = result
			d.CanSave = true -- on ne sauvegarde jamais par-dessus des données qu'on n'a pas pu lire
		else
			warn("[PlantServer] chargement raté pour " .. player.Name .. " : " .. tostring(result))
		end
	end
	if not player.Parent then return end
	local resetEpoch = waitResetEpoch()
	if saved and resetEpoch > 0 and (tonumber(saved.SavedAt) or 0) < resetEpoch then saved = nil end -- sauvegarde d'avant le reset global
	if saved then
		for name, count in saved.Seeds or {} do
			if Config.Seeds[name] and type(count) == "number" and count > 0 then d.Seeds[name] = count end
		end
		for _, plant in saved.Plants or {} do
			if Config.Seeds[plant.Seed] and #d.Plants < Config.MaxPlanted then
				table.insert(d.Plants, {Id = nextId(d), Seed = plant.Seed, X = plant.X, Z = plant.Z, Kg = plant.Kg, Mutation = plant.Mutation, PlantedAt = plant.PlantedAt, ReadyAt = plant.ReadyAt})
			end
		end
		for _, crop in saved.Crops or {} do
			if Config.Seeds[crop.Crop] and #d.Crops < Config.MaxCrops then
				table.insert(d.Crops, {Id = nextId(d), Crop = crop.Crop, Kg = crop.Kg, Mutation = crop.Mutation})
			end
		end
	end
	data[player] = d

	-- remet les plantes dans le jardin (elles ont continué de pousser hors ligne)
	local waited = 0
	while player.Parent and not getPlantZone(player) and waited < BASE_WAIT do
		waited += task.wait(0.2)
	end
	local zone = getPlantZone(player)
	if zone and data[player] == d then
		for _, plant in d.Plants do spawnPlant(player, plant, zone, false) end
	end
	sync(player)
end

-- reset d'un joueur connecté (admin) : graines, plantes et récoltes effacées
local function wipe(player)
	if not player.Parent then return end
	local d = data[player]
	data[player] = nil
	if d then
		for _, plant in d.Plants do
			if plant.Model then plant.Model:Destroy() end
		end
	end
	if store then pcall(function() store:RemoveAsync("u_" .. player.UserId) end) end
	if player.Parent then load(player) end
end
gameBindables:WaitForChild("WipePlayer").Event:Connect(function(player) task.spawn(wipe, player) end)

Players.PlayerAdded:Connect(load)
for _, player in Players:GetPlayers() do task.spawn(load, player) end

Players.PlayerRemoving:Connect(function(player)
	save(player)
	local d = data[player]
	data[player] = nil
	if not d then return end
	for _, plant in d.Plants do
		if plant.Model then plant.Model:Destroy() end
	end
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
	while pending > 0 and waited < 20 do waited += task.wait(0.1) end
end)
