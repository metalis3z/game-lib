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

-- spawnrandomserverbackroommutations : Spawn un animal ALÉATOIRE avec MUTATION ALÉATOIRE dans les Backrooms
local RARITY_WEIGHTS = {
	Rare            = 300,
	Epic            = 150,
	Legendary       = 60,
	Mythic          = 20,
	Secret          = 5,
	["Brainrot God"]= 1,
	OG              = 3,
	Cosmic          = 2,
}

local BASE_MUTATIONS = {
	{name=nil,          weight=400},
	{name="Gold",       weight=200},
	{name="Diamond",    weight=50},
	{name="Rainbow",    weight=20},
}
local EVENT_MUTATIONS = {
	{name="Candy",       weight=10, eventAttr="CandyEvent"},
	{name="YinYang",     weight=8,  eventAttr="YinYangEvent"},
	{name="Bloodrot",    weight=1,  eventAttr="BloodmoonEvent"},
	{name="Radioactive", weight=8,  eventAttr="RadioactiveEvent"},
	{name="Cursed",      weight=8,  eventAttr="CursedEvent"},
	{name="Divine",      weight=8,  eventAttr="DivineEvent"},
	{name="Cyber",       weight=7,  eventAttr="CyberEvent"},
	{name="Lava",        weight=7,  eventAttr="MoltenEvent"},
	{name="Galaxy",      weight=7,  eventAttr="GalaxyEvent"},
}

local function pickRandomBrainrot(Animals)
	local pool, total = {}, 0
	for name, data in pairs(Animals) do
		local w = RARITY_WEIGHTS[data.Rarity] or 0
		if w > 0 and not data.LuckyBlock then
			table.insert(pool, { data = data, weight = w })
			total += w
		end
	end
	if total == 0 then return nil end
	local r = math.random() * total
	local c = 0
	for _, e in ipairs(pool) do
		c += e.weight
		if r <= c then return e.data end
	end
	return pool[1] and pool[1].data
end

local function pickRandomMutation(RS)
	local pool, total = {}, 0
	for _, m in ipairs(BASE_MUTATIONS) do table.insert(pool, m); total += m.weight end
	for _, m in ipairs(EVENT_MUTATIONS) do
		if RS:GetAttribute(m.eventAttr) then table.insert(pool, m); total += m.weight end
	end
	local r = math.random() * total
	local c = 0
	for _, m in ipairs(pool) do
		c += m.weight
		if r <= c then return m.name end
	end
	return nil
end

local module = function(Conch, Config)
	local RS  = game:GetService("ReplicatedStorage")
	local SS  = game:GetService("ServerScriptService")
	local Players = game:GetService("Players")

	local Animals             = require(RS.Datas.Animals)
	local Rarities            = require(RS.Datas.Rarities)
	local AnimalService       = require(SS.Services.AnimalService)
	local NotificationService = require(SS.Services.NotificationService)

	Conch.register("spawnrandomserverbackroommutations", {
		description = "Spawn X animaux ALÉATOIRES avec MUTATION ALÉATOIRE dans les Backrooms (ce serveur).",
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{ kind = "argument", type = "number", name = "Amount", optional = true }
		end,
		callback = function(amount)
			amount = math.clamp(tonumber(amount) or 1, 1, 50)

			if not AnimalService.CaveSpawnActive then
				return false, "❌ Les Backrooms ne sont pas actifs sur ce serveur !"
			end

			for i = 1, amount do
				local AnimalData = pickRandomBrainrot(Animals)
				if not AnimalData then continue end

				local mutation = pickRandomMutation(RS)

				pcall(AnimalService.spawnAnimalCustom, AnimalData, mutation, {}, nil, nil, nil)

				local rarityData = Rarities[AnimalData.Rarity]
				local hex = rarityData and rarityData.Color
					and string.format("%02X%02X%02X",
						math.floor(rarityData.Color.R*255),
						math.floor(rarityData.Color.G*255),
						math.floor(rarityData.Color.B*255))
					or "FFFFFF"
				local coloredName = string.format('<font color="#%s"><b>%s</b></font>', hex, AnimalData.DisplayName)
				local mutLabel = mutation
					and (' <font color="#FFD700">[' .. mutation .. ']</font>')
					or ""
				local msg = '🔦 <font color="#FF8C00"><b>Admin</b></font> spawned '
					.. coloredName .. mutLabel
					.. ' <font color="#CCCCCC">in the Backrooms!</font>'

				for _, player in ipairs(Players:GetPlayers()) do
					NotificationService.Notify(player, msg, 6, RS.Sounds.Sfx.Success)
				end

				task.wait(0.1)
			end

			return ("✅ %d animal(ux) aléatoire(s) avec mutations spawné(s) dans les Backrooms !"):format(amount)
		end,
	})
end

return module
