-- AdminServer: handles announcements, codes, egg restock, global egg spawn, give coins
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")

local AdminSystem = ReplicatedStorage:WaitForChild("AdminSystem")
local remotes = AdminSystem:WaitForChild("Remotes")
local bindables = AdminSystem:WaitForChild("Bindables")
local StockData = require(AdminSystem:WaitForChild("StockData"))
local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local EggRemotes = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes")
local ServerStorage = game:GetService("ServerStorage")
local spawnAdminEgg = ServerStorage:WaitForChild("GameBindables"):WaitForChild("SpawnAdminEgg")
local CodesService = require(game:GetService("ServerScriptService"):WaitForChild("CodesService"))

local function notifyAdmin(player, text)
	EggRemotes.Notify:FireClient(player, text)
end

local function isAdmin(player)
	return table.find(AdminConfig.AdminIds, player.UserId) ~= nil
end

---------------------------------------------------------------- Announcements
local ANNOUNCE_TOPIC = "AdminGlobalAnnounce"

remotes.Announce.OnServerEvent:Connect(function(player, text, scope) -- scope "server" = ce serveur seulement
	if not isAdmin(player) then return end
	if type(text) ~= "string" then return end
	text = string.sub(text, 1, 100)
	if text == "" then return end
	-- Affichage immediat sur ce serveur + diffusion a TOUS les autres serveurs
	local payload = { name = player.DisplayName, userId = player.UserId, text = text, jobId = game.JobId }
	remotes.BroadcastAnnounce:FireAllClients(payload.name, payload.text, payload.userId)
	if scope ~= "server" then
		pcall(function()
			MessagingService:PublishAsync(ANNOUNCE_TOPIC, payload)
		end)
	end
end)

pcall(function()
	MessagingService:SubscribeAsync(ANNOUNCE_TOPIC, function(message)
		local data = message.Data
		if type(data) ~= "table" or data.jobId == game.JobId then return end
		remotes.BroadcastAnnounce:FireAllClients(data.name, data.text, data.userId)
	end)
end)

---------------------------------------------------------------- Codes (tout le système est dans CodesService : codes pour des PETS, nombre de personnes limité, SOLD OUT)
local function sendSync(player)
	local stockCopy = {}
	for k, v in StockData.Stock do stockCopy[k] = v end
	remotes.SyncData:FireClient(player, stockCopy, CodesService.List())
end

remotes.CreateCode.OnServerEvent:Connect(function(player, codeData)
	if not isAdmin(player) then return end
	if type(codeData) ~= "table" then return end
	local rewards = type(codeData.Rewards) == "table" and codeData.Rewards or {}
	local ok, result = CodesService.Create(codeData.Code, codeData.MaxUses, rewards.Money, rewards.Pets)
	if ok then
		notifyAdmin(player, "Code " .. result .. " created!")
	else
		notifyAdmin(player, "Code not created: " .. tostring(result))
	end
	sendSync(player)
end)

-- le panneau F5 passe par cet événement ; le résultat revient par CodeResult
remotes.RedeemCode.OnServerEvent:Connect(function(player, code)
	local ok, message = CodesService.Redeem(player, code)
	remotes.CodeResult:FireClient(player, ok, message)
end)

---------------------------------------------------------------- Stock / Restock
remotes.SetStock.OnServerEvent:Connect(function(player, eggName, amount)
	if not isAdmin(player) then return end
	if type(eggName) ~= "string" or type(amount) ~= "number" then return end
	StockData.Stock[eggName] = amount
	print("[AdminServer] Stock set: " .. eggName .. " = " .. amount)
end)

---------------------------------------------------------------- Sync to admin client
remotes.RequestSync.OnServerEvent:Connect(function(player)
	if not isAdmin(player) then return end
	sendSync(player)
end)


---------------------------------------------------------------- Sync players to admin client
local function sendPlayerList(player)
	if not isAdmin(player) then return end
	local list = {}
	for _, p in Players:GetPlayers() do
		table.insert(list, {Name = p.Name, DisplayName = p.DisplayName, UserId = p.UserId})
	end
	remotes.SyncPlayers:FireClient(player, list)
end

remotes.RequestSync.OnServerEvent:Connect(function(player)
	sendPlayerList(player)
end)

-- Send updated player list to all admins when players join/leave
local function syncAllAdmins()
	for _, p in Players:GetPlayers() do
		if isAdmin(p) then sendPlayerList(p) end
	end
end

Players.PlayerAdded:Connect(function() task.wait(1); syncAllAdmins() end)
Players.PlayerRemoving:Connect(function() task.wait(1); syncAllAdmins() end)

---------------------------------------------------------------- Give Coins
remotes.GiveCoins.OnServerEvent:Connect(function(player, targetName, amount)
	if not isAdmin(player) then return end
	if type(targetName) ~= "string" or type(amount) ~= "number" then return end
	amount = math.floor(amount)
	if amount == 0 then return end

	local target = Players:FindFirstChild(targetName)
	if not target then
		notifyAdmin(player, "Player not found: " .. targetName)
		return
	end

	local current = target:GetAttribute("Money") or 0
	target:SetAttribute("Money", current + amount)
	notifyAdmin(player, amount > 0 and "+" .. tostring(amount) .. " given to " .. target.Name or "-" .. tostring(math.abs(amount)) .. " removed from " .. target.Name)
end)

---------------------------------------------------------------- Give Egg : l'animal de l'œuf choisi va dans l'inventaire du joueur, avec le poids choisi
-- (les œufs ne se gardent plus dans l'inventaire : donner un œuf = donner l'animal qu'il contient)
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
remotes:WaitForChild("GiveEgg").OnServerEvent:Connect(function(player, targetName, eggName, kg, count)
	if not isAdmin(player) then return end
	if type(targetName) ~= "string" or type(eggName) ~= "string" then return end
	local target = Players:FindFirstChild(targetName)
	local egg = EggConfig.Eggs[eggName]
	local directPet = EggConfig.Pets[eggName] and eggName or nil -- le panneau envoie maintenant le nom de l'animal (un nom d'œuf marche encore)
	if not target or not target:IsA("Player") then
		notifyAdmin(player, "Player not found: " .. targetName)
		return
	end
	if not egg and not directPet then
		notifyAdmin(player, "Unknown animal: " .. eggName)
		return
	end
	local petName = directPet or egg.Pets[1].Pet
	local petInfo = EggConfig.Pets[petName]
	kg = tonumber(kg)
	if kg and (kg ~= kg or kg <= 0) then kg = nil end
	count = math.clamp(math.floor(tonumber(count) or 1), 1, 20)
	local given = 0
	local give = ServerStorage:WaitForChild("GameBindables"):WaitForChild("GiveZonePet")
	for _ = 1, count do
		local weight = kg and math.min(kg, 1e7) or petInfo.Kg * (0.9 + math.random() * 0.2) -- pas de poids choisi : poids classique
		if give:Invoke(target, petName, weight) then given += 1 else break end
	end
	notifyAdmin(player, given .. "x " .. petInfo.Name .. " given to " .. target.Name .. (given < count and " (inventory full)" or ""))
end)

---------------------------------------------------------------- Oeufs admin : spawn physique dans une zone, avec timer (tous les serveurs / serveurs au hasard)
local MemoryStoreService = game:GetService("MemoryStoreService")
local eggModels = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggModels")

local EGG_TOPIC = "AdminSpawnGlobalEgg"       -- message pour TOUS les serveurs
local SERVER_TOPIC_PREFIX = "AdminEggTo_"     -- message pour UN serveur precis (+ son JobId)
local VALID_ZONES = {Common = true, Uncommon = true, Rare = true, Epic = true, Legendary = true, Mythic = true, Secret = true, Ancient = true, OG = true, Divine = true, Prismatic = true}
local MIN_TIMER, MAX_TIMER, DEFAULT_TIMER = 10, 3600, 60
local MAX_SERVERS = 200
local JOB_ID = game.JobId -- vide dans Studio

-- fait apparaitre l'oeuf dans CE serveur
local function spawnHere(data)
	if type(data) ~= "table" then return end
	if type(data.eggName) ~= "string" or not eggModels:FindFirstChild(data.eggName) then return end
	if not VALID_ZONES[data.zoneName] then return end
	local timer = math.clamp(tonumber(data.timer) or DEFAULT_TIMER, MIN_TIMER, MAX_TIMER)
	local kg = tonumber(data.kg)
	if kg and (kg ~= kg or kg <= 0) then kg = nil end
	spawnAdminEgg:Fire(data.zoneName, data.eggName, timer, kg and math.min(kg, 1e7) or nil) -- kg nil = poids tiré au hasard, comme un œuf normal
end

-- registre des serveurs ouverts (MemoryStore) : sert a tirer des serveurs au hasard
local serverMap
pcall(function() serverMap = MemoryStoreService:GetSortedMap("ActiveServers_v1") end)

if serverMap and JOB_ID ~= "" then
	task.spawn(function()
		while true do
			pcall(function() serverMap:SetAsync(JOB_ID, 1, 90) end)
			task.wait(30)
		end
	end)
	game:BindToClose(function()
		pcall(function() serverMap:RemoveAsync(JOB_ID) end)
	end)
end

local function listServers()
	local ids = {}
	if serverMap then
		local ok, items = pcall(function() return serverMap:GetRangeAsync(Enum.SortDirection.Ascending, MAX_SERVERS) end)
		if ok and items then
			for _, item in items do table.insert(ids, item.key) end
		end
	end
	if JOB_ID ~= "" and not table.find(ids, JOB_ID) then table.insert(ids, JOB_ID) end
	return ids
end

-- reception : oeuf pour tous les serveurs
pcall(function()
	MessagingService:SubscribeAsync(EGG_TOPIC, function(message)
		spawnHere(message.Data)
	end)
end)
-- reception : oeuf pour ce serveur seulement (tirage au hasard)
if JOB_ID ~= "" then
	pcall(function()
		MessagingService:SubscribeAsync(SERVER_TOPIC_PREFIX .. JOB_ID, function(message)
			spawnHere(message.Data)
		end)
	end)
end

local function checkSpawnArgs(player, eggName, zoneName, timer)
	if not isAdmin(player) then return end
	if type(eggName) ~= "string" or type(zoneName) ~= "string" then return end
	if not eggModels:FindFirstChild(eggName) then
		notifyAdmin(player, "Unknown egg: " .. eggName)
		return
	end
	if not VALID_ZONES[zoneName] then
		notifyAdmin(player, "Unsupported zone: " .. zoneName)
		return
	end
	local t = tonumber(timer)
	if not t or t ~= t then t = DEFAULT_TIMER end
	return eggName, zoneName, math.clamp(math.floor(t), MIN_TIMER, MAX_TIMER)
end

-- SPAWN GLOBAL : l'oeuf apparait dans la zone de TOUS les serveurs, avec un timer
remotes.SpawnGlobalEgg.OnServerEvent:Connect(function(player, eggName, zoneName, timer, kg)
	eggName, zoneName, timer = checkSpawnArgs(player, eggName, zoneName, timer)
	if not eggName then return end
	local data = {eggName = eggName, zoneName = zoneName, timer = timer, kg = tonumber(kg)}
	local ok = pcall(function() MessagingService:PublishAsync(EGG_TOPIC, data) end)
	if ok then
		notifyAdmin(player, eggName .. " spawned in " .. zoneName .. " : ALL servers (" .. timer .. "s)")
	else
		spawnHere(data) -- MessagingService indisponible (Studio) : au moins ce serveur
		notifyAdmin(player, "MessagingService unavailable: egg spawned on this server only")
	end
end)

-- SPAWN RANDOM SERVERS : l'oeuf apparait dans N serveurs tires au hasard
remotes:WaitForChild("SpawnRandomServerEgg").OnServerEvent:Connect(function(player, eggName, zoneName, timer, serverCount, kg)
	eggName, zoneName, timer = checkSpawnArgs(player, eggName, zoneName, timer)
	if not eggName then return end
	local count = tonumber(serverCount)
	if not count or count ~= count then
		notifyAdmin(player, "Invalid server count")
		return
	end
	count = math.clamp(math.floor(count), 1, MAX_SERVERS)

	local data = {eggName = eggName, zoneName = zoneName, timer = timer, kg = tonumber(kg)}
	local ids = listServers()
	if #ids == 0 then -- Studio / registre indisponible
		spawnHere(data)
		notifyAdmin(player, "Server registry unavailable: egg spawned on this server only")
		return
	end

	-- melange puis on prend les N premiers
	for i = #ids, 2, -1 do
		local j = math.random(i)
		ids[i], ids[j] = ids[j], ids[i]
	end
	local sent = 0
	for i = 1, math.min(count, #ids) do
		local jobId = ids[i]
		if jobId == JOB_ID then
			spawnHere(data)
			sent += 1
		else
			local ok = pcall(function() MessagingService:PublishAsync(SERVER_TOPIC_PREFIX .. jobId, data) end)
			if ok then sent += 1 end
		end
	end
	notifyAdmin(player, eggName .. " spawned in " .. zoneName .. " : " .. sent .. " server(s) of " .. #ids .. " (" .. timer .. "s)")
end)

-- œuf pour CE serveur seulement
remotes:WaitForChild("SpawnLocalEgg").OnServerEvent:Connect(function(player, eggName, zoneName, timer, kg)
	if not isAdmin(player) then return end
	if type(eggName) ~= "string" or not eggModels:FindFirstChild(eggName) then
		notifyAdmin(player, "Unknown egg: " .. tostring(eggName))
		return
	end
	if not VALID_ZONES[zoneName] then
		notifyAdmin(player, "Unsupported zone: " .. tostring(zoneName))
		return
	end
	spawnHere({eggName = eggName, zoneName = zoneName, timer = timer, kg = kg})
	notifyAdmin(player, eggName .. " spawned in " .. zoneName .. " : this server only")
end)
