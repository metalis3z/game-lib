-- Game: smash-egg-for-animals
-- Original: ServerScriptService/PetServer.server.lua  (1662 lines)
-- Excerpt of lines 1139-1291
-- What it does: The data-owner side of the trade: a BindableFunction 'TradeBridge' that lists tradable pets and performs the all-or-nothing swap (no duplicate ids, pets must be in inventory not placed, inventory-space check for both players, then remove + re-add with fresh ids). Also Take/Give for the escrow version.

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
		for _, pet in petsA do table.insert(db.Pets, {Id = nextId(db), Pet = pet.Pet, Kg = pet.Kg, Mutation = pet.Mutation, Trait = pet.Trait, Level = pet.Level, Xp = pet.Xp}) end -- (le niveau et l'XP suivent l'animal)
		for _, pet in petsB do table.insert(da.Pets, {Id = nextId(da), Pet = pet.Pet, Kg = pet.Kg, Mutation = pet.Mutation, Trait = pet.Trait, Level = pet.Level, Xp = pet.Xp}) end
		sync(a)
		sync(b)
		return true
	end

	bridge.Parent = script.Parent
end
