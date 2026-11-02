local THIS_JOB_ID = game.JobId
local MSG_TYPE    = "SpawnRandomMutations_v4"

local RARITY_WEIGHTS = {
	["Rare"]         = 300,
	["Epic"]         = 150,
	["Legendary"]    = 60,
	["Mythic"]       = 20,
	["Secret"]       = 5,
	["Brainrot God"] = 1,
}

local MUTATION_WEIGHTS = {
	{name="Gold",        weight=50},
	{name="Diamond",     weight=25},
	{name="Rainbow",     weight=10},
	{name="Radioactive", weight=8},
	{name="Candy",       weight=6},
	{name="Galaxy",      weight=5},
	{name="Cursed",      weight=4},
	{name="Lava",        weight=3},
	{name="YinYang",     weight=2},
	{name="Bloodrot",    weight=2},
	{name="Divine",      weight=1},
}

local function pickMutation()
	local total = 0
	for _, m in ipairs(MUTATION_WEIGHTS) do total += m.weight end
	local r = math.random() * total
	local c = 0
	for _, m in ipairs(MUTATION_WEIGHTS) do
		c += m.weight
		if r <= c then return m.name end
	end
	return "Gold"
end

local function pickRandomBrainrot()
	local RS      = game:GetService("ReplicatedStorage")
	local Animals = require(RS.Datas.Animals)
	local pool, total = {}, 0
	for name, data in pairs(Animals) do
		local w = RARITY_WEIGHTS[data.Rarity] or 0
		if w > 0 and not data.LuckyBlock then
			table.insert(pool, {name=name, weight=w})
			total += w
		end
	end
	if total == 0 then return nil end
	local r = math.random() * total
	local c = 0
	for _, e in ipairs(pool) do
		c += e.weight
		if r <= c then return e.name end
	end
	return pool[1].name
end

local function registerHandler()
	if not _G.MessagingHub then return end
	_G.MessagingHub.Register(MSG_TYPE, function(data)
		if typeof(data) ~= "table" then return end
		if data._jobId == THIS_JOB_ID then return end -- sender ne spawn JAMAIS

		local totalServers = math.max(tonumber(data.totalServers) or 1, 1)
		local seed         = tonumber(data.seed) or 1
		local amount       = math.clamp(tonumber(data.amount) or 1, 1, 1000)
		local brainrot     = data.brainrot -- nil = random

		-- Même mécanisme: seed commun + JobId = slot déterministe
		math.randomseed(seed + #THIS_JOB_ID)
		local mySlot = math.random(1, totalServers)
		if mySlot ~= 1 then return end -- seul 1 serveur passe

		local RS  = game:GetService("ReplicatedStorage")
		local SS  = game:GetService("ServerScriptService")
		local Animals             = require(RS.Datas.Animals)
		local AnimalService       = require(SS.Services.AnimalService)
		local NotificationService = require(SS.Services.NotificationService)
		local Rarities            = require(RS.Datas.Rarities)

		for i = 1, amount do
			local name = brainrot or pickRandomBrainrot()
			if name and Animals[name] then
				local mutation = pickMutation()
				pcall(AnimalService.spawnAnimalCustom, Animals[name], mutation, nil, nil, nil, nil)

				local A = Animals[name]
				local R = A and Rarities[A.Rarity]
				local n = A and A.DisplayName or name
				if R and R.Color then
					n = '<font color="#' .. R.Color:ToHex() .. '">' .. n .. '</font>'
				end
				for _, P in ipairs(game:GetService("Players"):GetPlayers()) do
					NotificationService.Notify(P,
						'<font color="#FFFFFF">badr & Zynna Admin spawned a '..n..' ['..mutation..']!</font>',
						5, RS.Sounds.Sfx.Success)
				end
				task.wait(0.1)
			end
		end
	end)
end

task.spawn(function()
	while not _G.MessagingHub do task.wait(0.5) end
	registerHandler()
end)

local Module = function(Conch, Config)
	local RS = game:GetService("ReplicatedStorage")
	local Animals = require(RS.Datas.Animals)

	Conch.register("spawnramdommutations", {
		description = "Spawn X animaux avec mutations aléatoires dans 1 seul serveur aléatoire.",
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{ kind="argument", type="Brainrot", name="Brainrot (vide=random)", optional=true },
				{ kind="argument", type="number",   name="Amount" },
				{ kind="argument", type="number",   name="TotalServers", optional=true }
		end,
		callback = function(brainrot, amount, totalServers)
			amount       = math.clamp(tonumber(amount) or 1, 1, 1000)
			totalServers = math.clamp(tonumber(totalServers) or 10, 1, 200)

			-- Valider brainrot si fourni
			if brainrot and not Animals[brainrot] then
				return "❌ Brainrot invalide: " .. tostring(brainrot)
			end

			local seed = os.time() + math.random(1, 999999)

			if _G.MessagingHub then
				_G.MessagingHub.Publish(MSG_TYPE, {
					amount       = amount,
					totalServers = totalServers,
					seed         = seed,
					brainrot     = brainrot or nil,
				})
			end

			local animalDesc = brainrot or "aléatoire"
			return string.format("✅ %s ×%d [mutation random] → 1 serveur parmi ~%d", animalDesc, amount, totalServers)
		end,
	})
end
return Module
