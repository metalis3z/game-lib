-- AdminServer: handles announcements, egg restock, global egg spawn, give coins / animals (any server, by username)
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

---------------------------------------------------------------- Sync (stock) to admin client
local function sendSync(player)
	local stockCopy = {}
	for k, v in StockData.Stock do stockCopy[k] = v end
	remotes.SyncData:FireClient(player, stockCopy)
end

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

---------------------------------------------------------------- GIVE (argent / animaux) : par pseudo, depuis n'importe quel serveur
-- Joueur dans ce serveur : donné tout de suite. Sinon le cadeau est écrit dans le DataStore AdminGifts_v1 (clé u_<UserId>)
-- et tous les serveurs sont prévenus : celui où le joueur est connecté (ou celui qu'il rejoindra plus tard) réclame la liste
-- d'un seul coup (UpdateAsync) et l'applique. Un cadeau n'est donc jamais donné deux fois, et il arrive même hors ligne.
local EggConfig = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local DataStoreService = game:GetService("DataStoreService")
local giveZonePet = ServerStorage:WaitForChild("GameBindables"):WaitForChild("GiveZonePet")
local giftStore
pcall(function() giftStore = DataStoreService:GetDataStore("AdminGifts_v1") end)
local GIFT_TOPIC = "AdminGiftPing"
local MAX_PENDING = 100

local function findOnline(name)
	name = string.lower(string.gsub(tostring(name), "^@", ""))
	for _, p in Players:GetPlayers() do
		if string.lower(p.Name) == name then return p end
	end
end
local function userIdOf(name)
	local clean = string.gsub(tostring(name), "^@", "")
	local ok, id = pcall(function() return Players:GetUserIdFromNameAsync(clean) end)
	return ok and id or nil, clean
end

-- gamepass offerts par un admin (ex. Double Speed) : retenus ici, redonnés à chaque connexion (attribut "Pass_<Key>", comme PassServer)
local ShopConfig = require(game:GetService("ReplicatedStorage"):WaitForChild("ShopSystem"):WaitForChild("ShopConfig"))
local adminPassStore
pcall(function() adminPassStore = DataStoreService:GetDataStore("AdminPasses_v1") end)
local function setAdminPass(userId, key, on)
	if not adminPassStore then return end
	pcall(function()
		adminPassStore:UpdateAsync("u_" .. userId, function(old)
			local set = type(old) == "table" and old or {}
			set[key] = on or nil
			return set
		end)
	end)
end
local function loadAdminPasses(player)
	if not adminPassStore then return end
	local ok, set = pcall(function() return adminPassStore:GetAsync("u_" .. player.UserId) end)
	if ok and type(set) == "table" then
		for key, on in set do if on and ShopConfig.GetPass(key) then player:SetAttribute("Pass_" .. key, true) end end
	end
end
Players.PlayerAdded:Connect(loadAdminPasses)
for _, p in Players:GetPlayers() do task.spawn(loadAdminPasses, p) end
local tradeBridge = game:GetService("ServerScriptService"):WaitForChild("TradeBridge")

local function describe(gift)
	if gift.Kind == "Money" then
		return (gift.Amount >= 0 and "+" or "-") .. EggConfig.FormatMoney(math.abs(gift.Amount))
	elseif gift.Kind == "Pass" then
		local pass = ShopConfig.GetPass(gift.Key)
		return (gift.Remove and "removed " or "") .. (pass and pass.Name or tostring(gift.Key)) .. " pass"
	elseif gift.Kind == "FeaturedEggs" then
		return (gift.Count or 1) .. "x " .. (ShopConfig.Featured and ShopConfig.Featured.Title or "egg")
	end
	local info = EggConfig.Pets[gift.Pet]
	return (gift.Count or 1) .. "x " .. (info and info.Name or tostring(gift.Pet))
end

-- applique un cadeau à un joueur de CE serveur ; renvoie le texte du résultat
local function applyGift(target, gift)
	if gift.Kind == "Money" then
		target:SetAttribute("Money", math.max(0, (target:GetAttribute("Money") or 0) + gift.Amount))
		return describe(gift)
	elseif gift.Kind == "Pass" then
		target:SetAttribute("Pass_" .. gift.Key, (not gift.Remove) or nil)
		setAdminPass(target.UserId, gift.Key, not gift.Remove)
		return describe(gift)
	elseif gift.Kind == "FeaturedEggs" then
		local featured = ShopConfig.Featured
		if not featured then return "no featured egg" end
		local count = math.clamp(math.floor(tonumber(gift.Count) or 1), 1, 100)
		if not tradeBridge:Invoke("GiveEggs", target, featured.Egg, nil, count) then return "egg inventory full" end
		return describe(gift)
	elseif gift.Kind == "Pet" then
		local info = EggConfig.Pets[gift.Pet]
		if not info then return "unknown animal" end
		local given = 0
		for _ = 1, math.clamp(math.floor(tonumber(gift.Count) or 1), 1, 20) do
			local weight = gift.Kg and math.min(gift.Kg, 1e6) or info.Kg * (0.9 + math.random() * 0.2) -- pas de poids choisi : poids classique
			if giveZonePet:Invoke(target, gift.Pet, weight) then given += 1 else break end
		end
		return given .. "x " .. info.Name .. (given < (gift.Count or 1) and " (inventory full)" or "")
	end
	return "?"
end

-- le joueur a-t-il fini de charger ses données (PetServer pose l'attribut Money) ?
local function waitLoaded(player)
	local waited = 0
	while player.Parent and player:GetAttribute("Money") == nil and waited < 30 do waited += task.wait(0.5) end
	return player.Parent ~= nil and player:GetAttribute("Money") ~= nil
end

local claiming = {}
local function claimGifts(player)
	if not giftStore or claiming[player] then return end
	claiming[player] = true
	if waitLoaded(player) then
		local list
		local ok, err = pcall(function()
			giftStore:UpdateAsync("u_" .. player.UserId, function(old)
				list = old
				if type(old) ~= "table" or #old == 0 then return nil end -- rien à réclamer : on n'écrit pas
				return {}
			end)
		end)
		if not ok then warn("[AdminServer] gifts claim failed for " .. player.Name .. ": " .. tostring(err)) end
		if ok and type(list) == "table" then
			for _, gift in list do
				if type(gift) == "table" then
					local text = applyGift(player, gift)
					EggRemotes.Notify:FireClient(player, "An admin gave you " .. text .. "!")
				end
			end
		end
	end
	claiming[player] = nil
end
Players.PlayerAdded:Connect(claimGifts)
for _, p in Players:GetPlayers() do task.spawn(claimGifts, p) end
pcall(function()
	MessagingService:SubscribeAsync(GIFT_TOPIC, function(message)
		local data = message.Data
		local target = type(data) == "table" and Players:GetPlayerByUserId(data.userId)
		if target then task.spawn(claimGifts, target) end
	end)
end)

local function sendGift(admin, targetName, gift)
	local online = findOnline(targetName)
	if online then
		notifyAdmin(admin, applyGift(online, gift) .. " given to " .. online.Name)
		return
	end
	local userId, clean = userIdOf(targetName)
	if not userId then notifyAdmin(admin, "Player not found: " .. clean) return end
	if not giftStore then notifyAdmin(admin, "Give failed: DataStore unavailable (enable API access in Game Settings)") return end
	local ok, err = pcall(function()
		giftStore:UpdateAsync("u_" .. userId, function(old)
			local list = type(old) == "table" and old or {}
			if #list >= MAX_PENDING then return nil end
			table.insert(list, gift)
			return list
		end)
	end)
	if not ok then notifyAdmin(admin, "Give failed: " .. tostring(err)) return end
	pcall(function() MessagingService:PublishAsync(GIFT_TOPIC, {userId = userId}) end)
	notifyAdmin(admin, describe(gift) .. " sent to " .. clean .. " (delivered now if they play on another server, otherwise when they join)")
end

remotes.GiveCoins.OnServerEvent:Connect(function(player, targetName, amount)
	if not isAdmin(player) then return end
	if type(targetName) ~= "string" or type(amount) ~= "number" or amount ~= amount then return end
	amount = math.floor(amount)
	if amount == 0 then return end
	sendGift(player, targetName, {Kind = "Money", Amount = amount})
end)

-- Give animal : l'animal choisi va dans l'inventaire du joueur, avec le poids choisi
remotes:WaitForChild("GiveEgg").OnServerEvent:Connect(function(player, targetName, eggName, kg, count)
	if not isAdmin(player) then return end
	if type(targetName) ~= "string" or type(eggName) ~= "string" then return end
	local egg = EggConfig.Eggs[eggName]
	local directPet = EggConfig.Pets[eggName] and eggName or nil -- le panneau envoie le nom de l'animal (un nom d'œuf marche encore)
	if not egg and not directPet then notifyAdmin(player, "Unknown animal: " .. eggName) return end
	kg = tonumber(kg)
	if kg and (kg ~= kg or kg <= 0) then kg = nil end
	sendGift(player, targetName, {Kind = "Pet", Pet = directPet or egg.Pets[1].Pet, Kg = kg, Count = math.clamp(math.floor(tonumber(count) or 1), 1, 20)})
end)

-- Give shop item : un gamepass (donner / retirer) ou des œufs de la boutique (Fallen Angel...)
remotes:WaitForChild("GiveShopItem").OnServerEvent:Connect(function(player, targetName, item, value)
	if not isAdmin(player) or type(targetName) ~= "string" or type(item) ~= "string" then return end
	if item == "FeaturedEggs" then
		sendGift(player, targetName, {Kind = "FeaturedEggs", Count = math.clamp(math.floor(tonumber(value) or 1), 1, 100)})
	elseif ShopConfig.GetPass(item) then
		sendGift(player, targetName, {Kind = "Pass", Key = item, Remove = value == "remove"})
	end
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
	-- throwerId / throwerName : l'admin qui l'a lancé (son skin géant jette l'œuf sur la zone, AdminThrowClient)
	spawnAdminEgg:Fire(data.zoneName, data.eggName, timer, kg and math.min(kg, 1e6) or nil, tonumber(data.throwerId), type(data.throwerName) == "string" and data.throwerName or nil) -- kg nil = poids tiré au hasard, comme un œuf normal
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
	local data = {eggName = eggName, zoneName = zoneName, timer = timer, kg = tonumber(kg), throwerId = player.UserId, throwerName = player.DisplayName}
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

	local data = {eggName = eggName, zoneName = zoneName, timer = timer, kg = tonumber(kg), throwerId = player.UserId, throwerName = player.DisplayName}
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
	spawnHere({eggName = eggName, zoneName = zoneName, timer = timer, kg = kg, throwerId = player.UserId, throwerName = player.DisplayName})
	notifyAdmin(player, eggName .. " spawned in " .. zoneName .. " : this server only")
end)
