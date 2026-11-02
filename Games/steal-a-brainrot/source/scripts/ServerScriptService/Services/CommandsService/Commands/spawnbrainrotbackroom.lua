-- Helper : spawn directement dans les backrooms (pas depuis le portail)
local function spawnInBackroomsInternal(AnimalService, AnimalData, mutation, traits)
	if not AnimalService.CaveSpawnActive then return false end

	local origStart = AnimalService.CustomSpawnStart
	local origWPs   = AnimalService.CaveWaypoints
	local origSpeed = AnimalService.CaveSpeedOverride

	local wps = AnimalService.CaveWaypoints or {}
	local totalWPs = #wps

	-- Avec 4 waypoints : WP1=portail, WP2=entrée, WP3=intérieur, WP4=tapis
	-- On part de WP3 (index 3) pour spawner directement dans les backrooms
	-- Si moins de 3 waypoints, prendre le dernier disponible sauf le final
	local startIdx
	if totalWPs >= 3 then
		startIdx = totalWPs - 1  -- avant-dernier = bien à l'intérieur
	elseif totalWPs == 2 then
		startIdx = 2
	elseif totalWPs == 1 then
		startIdx = 1
	else
		-- Pas de waypoints actifs : fallback via template
		local mapTemplate = game:GetService("ServerScriptService").Services.EventService.Events.Backrooms:FindFirstChild("BackroomsMap")
		if mapTemplate then
			local wpFolder = mapTemplate:FindFirstChild("BrainrotWaypoints")
			if wpFolder then
				local parts = {}
				for _, p in ipairs(wpFolder:GetChildren()) do
					if p:IsA("BasePart") then
						local n = tonumber(p.Name)
						if n then table.insert(parts, {num=n, part=p}) end
					end
				end
				table.sort(parts, function(a,b) return a.num < b.num end)
				if #parts >= 3 then
					local tr = {}
					for i = #parts - 1, #parts do table.insert(tr, parts[i]) end
					AnimalService.CaveWaypoints    = tr
					AnimalService.CustomSpawnStart = parts[#parts - 1].part
					AnimalService.CaveSpeedOverride = 80
				end
			end
		end
		pcall(AnimalService.spawnAnimalCustom, AnimalData, mutation, traits or {}, nil, nil, nil)
		AnimalService.CustomSpawnStart  = origStart
		AnimalService.CaveWaypoints     = origWPs
		AnimalService.CaveSpeedOverride = origSpeed
		return true
	end

	-- Tronquer : garder seulement WP[startIdx] → WP[fin]
	local truncated = {}
	for i = startIdx, totalWPs do
		table.insert(truncated, wps[i])
	end

	AnimalService.CaveWaypoints    = truncated
	AnimalService.CustomSpawnStart = wps[startIdx].part
	AnimalService.CaveSpeedOverride = 80

	pcall(AnimalService.spawnAnimalCustom, AnimalData, mutation, traits or {}, nil, nil, nil)

	-- Restaurer
	AnimalService.CustomSpawnStart  = origStart
	AnimalService.CaveWaypoints     = origWPs
	AnimalService.CaveSpeedOverride = origSpeed
	return true
end

-- spawnbrainrotbackroom : Spawn un animal spécifique dans les Backrooms (serveur local)
local module = function(Conch, Config)
	local ReplicatedStorage   = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")
	local Players             = game:GetService("Players")

	local Animals             = require(ReplicatedStorage.Datas.Animals)
	local Mutations           = require(ReplicatedStorage.Datas.Mutations)
	local Rarities            = require(ReplicatedStorage.Datas.Rarities)
	local AnimalService       = require(ServerScriptService.Services.AnimalService)
	local NotificationService = require(ServerScriptService.Services.NotificationService)

	Conch.register("spawnbrainrotbackroom", {
		description = "Spawn un animal dans les Backrooms (ce serveur).",
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{ kind = "argument", type = "Brainrot",  name = "Brainrot" },
				{ kind = "argument", type = "Mutation",  name = "Mutation",  optional = true },
				{ kind = "argument", type = "number",    name = "Amount",    optional = true },
				{ kind = "argument", type = "Traits",    name = "Traits",    optional = true }
		end,

		callback = function(brainrot, mutation, amount, traits)
			amount = math.clamp(tonumber(amount) or 1, 1, 50)

			-- Vérifier que les Backrooms sont actifs
			if not AnimalService.CaveSpawnActive then
				return false, "❌ Les Backrooms ne sont pas actifs sur ce serveur !"
			end

			-- Valider l'animal
			local AnimalData
			for _, data in pairs(Animals) do
				if data.DisplayName == brainrot or data.Name == brainrot then
					AnimalData = data; break
				end
			end
			if not AnimalData then
				return false, ("❌ Animal '%s' introuvable."):format(tostring(brainrot))
			end

			-- Valider la mutation
			local mutParam = nil
			if mutation and mutation ~= "" and mutation ~= "Normal" then
				if not Mutations[mutation] then
					return false, ("❌ Mutation '%s' introuvable."):format(tostring(mutation))
				end
				mutParam = mutation
			end

			-- Valider les traits
			local validTraits = {}
			if traits and type(traits) == "table" then
				local Traits = require(ReplicatedStorage.Datas.Traits)
				for _, trait in ipairs(traits) do
					if Traits[trait] then table.insert(validTraits, trait) end
				end
			end

			-- Spawner dans les Backrooms
			for i = 1, amount do
				pcall(AnimalService.spawnAnimalCustom, AnimalData, mutParam, validTraits, nil, nil, nil)
				task.wait(0.05)
			end

			-- Notification à tous les joueurs
			local rarityData = Rarities[AnimalData.Rarity]
			local hex = rarityData and rarityData.Color
				and string.format("%02X%02X%02X",
					math.floor(rarityData.Color.R*255),
					math.floor(rarityData.Color.G*255),
					math.floor(rarityData.Color.B*255))
				or "FFFFFF"
			local coloredName = string.format('<font color="#%s"><b>%s</b></font>', hex, AnimalData.DisplayName)
			local mutLabel = mutParam and (" [" .. mutParam .. "]") or ""
			local amountLabel = amount > 1 and (" x" .. amount) or ""
			local msg = '🔦 <font color="#FFDD00"><b>Admin</b></font> spawned '
				.. coloredName .. mutLabel .. amountLabel
				.. ' <font color="#CCCCCC">in the Backrooms!</font>'

			for _, player in ipairs(Players:GetPlayers()) do
				NotificationService.Notify(player, msg, 6, ReplicatedStorage.Sounds.Sfx.Success)
			end

			return ("✅ %d x %s [%s] spawné(s) dans les Backrooms !"):format(
				amount, AnimalData.DisplayName, mutParam or "Normal")
		end,
	})
end

return module
