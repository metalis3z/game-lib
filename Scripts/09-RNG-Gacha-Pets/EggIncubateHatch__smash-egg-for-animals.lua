-- Game: smash-egg-for-animals
-- Original: ServerScriptService/PetServer.server.lua
-- Excerpt of lines 85-100, 555-652
-- What it does: Eggs placed in the player's base incubate until ReadyAt, can randomly grow heavier while waiting, then hatch on the server (inventory cap check, roll by % table, egg weight carried into the pet).
-- Note: Original comments are in French.
-- ===== Excerpt of lines 85-100 of ServerScriptService/PetServer.server.lua =====
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

-- ===== Excerpt of lines 555-652 of ServerScriptService/PetServer.server.lua =====
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
