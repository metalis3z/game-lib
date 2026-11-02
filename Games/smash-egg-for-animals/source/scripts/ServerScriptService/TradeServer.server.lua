-- TradeServer : échanges d'animaux entre deux joueurs du MÊME serveur, à la Trade Machine (Workspace."Trade Machine").
-- Le serveur décide de tout ; le client (TradeClient) ne fait qu'afficher et demander.
--   * invite E devant la machine -> la fenêtre s'ouvre : liste des joueurs du serveur, demandes reçues
--   * demande d'échange (seulement devant la machine) -> l'autre joueur l'accepte ou la refuse (30 s)
--   * chacun met ses animaux (rangés dans l'inventaire, pas posés) : 2 s d'attente entre deux ajouts / retraits
--   * READY des deux côtés -> 3 s d'attente -> CONFIRM des deux côtés -> échange (PetServer, TradeBridge "Execute" : tout ou rien)
--   * la moindre modification d'une offre annule les READY / CONFIRM (pas d'arnaque de dernière seconde)
--   * l'échange est sauvegardé tout de suite pour les deux joueurs ; un animal échangé tenu en main est rangé
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Config = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local bridge = ServerScriptService:WaitForChild("TradeBridge")
local notifyRemote = ReplicatedStorage.EggSystem:WaitForChild("Remotes"):WaitForChild("Notify")

local MAX_OFFER = 9          -- animaux au plus par offre
local EDIT_COOLDOWN = 2      -- secondes entre deux ajouts / retraits d'un même joueur
local READY_DELAY = 3        -- secondes entre "les deux sont prêts" et "on peut confirmer"
local REQUEST_LIFETIME = 30  -- une demande expire au bout de 30 s
local REQUEST_COOLDOWN = 3   -- une demande toutes les 3 s au plus
local MACHINE_RANGE = 24     -- il faut être devant la machine pour l'ouvrir et envoyer une demande

local folder = ReplicatedStorage:FindFirstChild("TradeSystem") or Instance.new("Folder")
folder.Name = "TradeSystem"
folder.Parent = ReplicatedStorage
local function remote(name)
	local r = folder:FindFirstChild(name) or Instance.new("RemoteEvent")
	r.Name = name
	r.Parent = folder
	return r
end
local actionRemote = remote("TradeAction") -- client -> serveur (kind, arg)
local updateRemote = remote("TradeUpdate") -- serveur -> client (paquet d'état)

local machine = workspace:WaitForChild("Trade Machine")
local promptPart = machine:WaitForChild("TradePrompt")

local trades = {}    -- [joueur] = échange en cours
local requests = {}  -- [cible][demandeur] = heure d'expiration
local lastRequest, lastAction = {}, {}

local function now() return workspace:GetServerTimeNow() end
local function notify(player, text) if player.Parent then notifyRemote:FireClient(player, text) end end
local function nearMachine(player)
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	return root ~= nil and (root.Position - promptPart.Position).Magnitude <= MACHINE_RANGE
end
local function other(trade, player) return trade.A == player and trade.B or trade.A end

-- animaux échangeables (rangés dans l'inventaire) du joueur : [id] = fiche
local function tradableMap(player)
	local map = {}
	for _, pet in bridge:Invoke("GetTradable", player) or {} do map[pet.Id] = pet end
	return map
end

local function card(pet)
	local info = Config.Pets[pet.Pet]
	return {Id = pet.Id, Pet = pet.Pet, Name = info and info.Name or pet.Pet, Rarity = info and info.Rarity or "Common", Kg = pet.Kg, Mutation = pet.Mutation, Trait = pet.Trait,
		Income = Config.GetIncome(pet.Pet, pet.Kg or (info and info.Kg) or 1, pet.Mutation, 1)}
end

-- liste des joueurs (fenêtre d'accueil) et demandes reçues
local function lobbyFor(player)
	local list = {}
	for _, p in Players:GetPlayers() do
		if p ~= player then table.insert(list, {Id = p.UserId, Name = p.Name, Display = p.DisplayName, Busy = trades[p] ~= nil}) end
	end
	local incoming = {}
	for from, expires in requests[player] or {} do
		if from.Parent and expires > now() then table.insert(incoming, {Id = from.UserId, Name = from.Name, Display = from.DisplayName, Expires = expires}) end
	end
	return {k = "lobby", Players = list, Requests = incoming}
end

-- état complet envoyé à un joueur pendant l'échange (on revérifie que les animaux offerts sont toujours là)
local resetReady
local function push(trade)
	local changed = false
	for _, p in {trade.A, trade.B} do
		local mine = tradableMap(p)
		local offer = trade.Offer[p]
		for i = #offer, 1, -1 do
			if not mine[offer[i]] then table.remove(offer, i) changed = true end -- posé, fusionné, supprimé... : retiré de l'offre
		end
	end
	if changed then resetReady(trade) end
	for _, p in {trade.A, trade.B} do
		if p.Parent then
			local q = other(trade, p)
			local mine, theirs = tradableMap(p), tradableMap(q)
			local myOffer, theirOffer, inventory = {}, {}, {}
			local offered = {}
			for _, id in trade.Offer[p] do offered[id] = true if mine[id] then table.insert(myOffer, card(mine[id])) end end
			for _, id in trade.Offer[q] do if theirs[id] then table.insert(theirOffer, card(theirs[id])) end end
			for id, pet in mine do if not offered[id] then table.insert(inventory, card(pet)) end end
			table.sort(inventory, function(a, b) return a.Income > b.Income end)
			updateRemote:FireClient(p, {k = "trade", Other = {Id = q.UserId, Name = q.Name, Display = q.DisplayName},
				MyOffer = myOffer, TheirOffer = theirOffer, Inventory = inventory,
				MyReady = trade.Ready[p] == true, TheirReady = trade.Ready[q] == true,
				MyConfirm = trade.Confirm[p] == true, TheirConfirm = trade.Confirm[q] == true,
				ConfirmAt = trade.ReadyAt and trade.ReadyAt + READY_DELAY or nil,
				EditWait = math.max(0, (trade.LastEdit[p] or -99) + EDIT_COOLDOWN - os.clock()), EditCooldown = EDIT_COOLDOWN, MaxOffer = MAX_OFFER})
		end
	end
end

function resetReady(trade)
	trade.Ready, trade.Confirm, trade.ReadyAt = {}, {}, nil
end

local function endTrade(trade, reason)
	if trades[trade.A] == trade then trades[trade.A] = nil end
	if trades[trade.B] == trade then trades[trade.B] = nil end
	trade.Over = true
	for _, p in {trade.A, trade.B} do
		if p.Parent then updateRemote:FireClient(p, {k = "closed", Reason = reason}) end
	end
end

-- range l'animal échangé s'il était tenu en main (outil avec PetId)
local function dropHeldTools(player, ids)
	local set = {}
	for _, id in ids do set[id] = true end
	for _, container in {player.Character, player:FindFirstChildOfClass("Backpack")} do
		for _, tool in container and container:GetChildren() or {} do
			if tool:IsA("Tool") and set[tool:GetAttribute("PetId")] then tool:Destroy() end
		end
	end
end

local function execute(trade)
	if trade.Executing or trade.Over then return end
	trade.Executing = true
	local A, B = trade.A, trade.B
	local idsA, idsB = table.clone(trade.Offer[A]), table.clone(trade.Offer[B])
	if #idsA + #idsB == 0 then
		trade.Executing = false
		resetReady(trade)
		notify(A, "Put at least one pet in the trade!") notify(B, "Put at least one pet in the trade!")
		push(trade)
		return
	end
	local mineA, mineB = tradableMap(A), tradableMap(B)
	local gotA, gotB = {}, {}
	for _, id in idsB do if mineB[id] then table.insert(gotA, card(mineB[id])) end end
	for _, id in idsA do if mineA[id] then table.insert(gotB, card(mineA[id])) end end
	local ok, err = bridge:Invoke("Execute", A, idsA, B, idsB) -- tout ou rien (PetServer)
	if not ok then
		trade.Executing = false
		resetReady(trade)
		notify(A, "Trade failed: " .. tostring(err)) notify(B, "Trade failed: " .. tostring(err))
		push(trade)
		return
	end
	dropHeldTools(A, idsA)
	dropHeldTools(B, idsB)
	-- sauvegarde immédiate des deux joueurs (pas de duplication si le serveur s'arrête juste après)
	task.spawn(function() pcall(function() bridge:Invoke("Save", A) end) end)
	task.spawn(function() pcall(function() bridge:Invoke("Save", B) end) end)
	if trades[A] == trade then trades[A] = nil end
	if trades[B] == trade then trades[B] = nil end
	trade.Over = true
	if A.Parent then updateRemote:FireClient(A, {k = "done", Got = gotA, Gave = #idsA, Other = B.DisplayName}) end
	if B.Parent then updateRemote:FireClient(B, {k = "done", Got = gotB, Gave = #idsB, Other = A.DisplayName}) end
	print(string.format("[Trade] %s <-> %s : %d pet(s) <-> %d pet(s)", A.Name, B.Name, #idsA, #idsB))
end

---------------------------------------------------------------- l'invite de la machine
promptPart:WaitForChild("TradePrompt").Triggered:Connect(function(player)
	local trade = trades[player]
	if trade then push(trade) return end
	updateRemote:FireClient(player, lobbyFor(player))
end)

---------------------------------------------------------------- actions des joueurs
local handlers = {}

function handlers.Lobby(player)
	if trades[player] then push(trades[player]) return end
	updateRemote:FireClient(player, lobbyFor(player))
end

function handlers.Request(player, userId)
	if trades[player] then return end
	local target = typeof(userId) == "number" and Players:GetPlayerByUserId(userId)
	if not target or target == player then return end
	if not nearMachine(player) then notify(player, "Go to the Trade Machine to send a trade request!") return end
	if os.clock() - (lastRequest[player] or 0) < REQUEST_COOLDOWN then notify(player, "Wait a moment before sending another request.") return end
	lastRequest[player] = os.clock()
	if trades[target] then notify(player, target.DisplayName .. " is already trading.") return end
	if not bridge:Invoke("Loaded", player) or not bridge:Invoke("Loaded", target) then notify(player, "Data still loading, try again in a moment.") return end
	requests[target] = requests[target] or {}
	requests[target][player] = now() + REQUEST_LIFETIME
	updateRemote:FireClient(target, {k = "request", From = {Id = player.UserId, Name = player.Name, Display = player.DisplayName}, Expires = now() + REQUEST_LIFETIME})
	notify(player, "Trade request sent to " .. target.DisplayName .. "!")
end

function handlers.Accept(player, userId)
	if trades[player] then return end
	local from = typeof(userId) == "number" and Players:GetPlayerByUserId(userId)
	local expires = from and requests[player] and requests[player][from]
	if not expires or expires < now() then notify(player, "This trade request has expired.") return end
	requests[player][from] = nil
	if trades[from] then notify(player, from.DisplayName .. " is already trading.") return end
	local trade = {A = from, B = player, Offer = {[from] = {}, [player] = {}}, Ready = {}, Confirm = {}, LastEdit = {}}
	trades[from], trades[player] = trade, trade
	push(trade)
end

function handlers.Decline(player, userId)
	local from = typeof(userId) == "number" and Players:GetPlayerByUserId(userId)
	if from and requests[player] then
		requests[player][from] = nil
		notify(from, player.DisplayName .. " declined your trade request.")
	end
end

local function edit(player, petId, adding)
	local trade = trades[player]
	if not trade or trade.Executing or typeof(petId) ~= "number" then return end
	local t = os.clock()
	if t - (trade.LastEdit[player] or -99) < EDIT_COOLDOWN then push(trade) return end -- (2 s entre deux changements : contrôlé ici)
	local offer = trade.Offer[player]
	local index = table.find(offer, petId)
	if adding then
		if index or #offer >= MAX_OFFER then push(trade) return end
		if not tradableMap(player)[petId] then push(trade) return end -- pas à lui, ou posé dans son jardin
		table.insert(offer, petId)
	else
		if not index then push(trade) return end
		table.remove(offer, index)
	end
	trade.LastEdit[player] = t
	resetReady(trade) -- une offre change : tout le monde doit revalider
	push(trade)
end
function handlers.Add(player, petId) edit(player, petId, true) end
function handlers.Remove(player, petId) edit(player, petId, false) end

function handlers.Ready(player, value)
	local trade = trades[player]
	if not trade or trade.Executing then return end
	trade.Ready[player] = value == true
	trade.Confirm = {}
	if trade.Ready[trade.A] and trade.Ready[trade.B] then trade.ReadyAt = now() else trade.ReadyAt = nil end
	push(trade)
end

function handlers.Confirm(player)
	local trade = trades[player]
	if not trade or trade.Executing then return end
	if not (trade.Ready[trade.A] and trade.Ready[trade.B] and trade.ReadyAt) then return end
	if now() < trade.ReadyAt + READY_DELAY - 0.05 then push(trade) return end -- (3 s après les deux READY : contrôlé ici)
	trade.Confirm[player] = true
	if trade.Confirm[trade.A] and trade.Confirm[trade.B] then execute(trade) else push(trade) end
end

function handlers.Cancel(player)
	local trade = trades[player]
	if not trade then return end
	notify(other(trade, player), player.DisplayName .. " cancelled the trade.")
	endTrade(trade, "cancelled")
end

actionRemote.OnServerEvent:Connect(function(player, kind, arg)
	if type(kind) ~= "string" or not handlers[kind] then return end
	-- anti-spam : 12 actions par seconde au plus
	local t = os.clock()
	local rec = lastAction[player]
	if not rec or t - rec.Start > 1 then rec = {Start = t, Count = 0} lastAction[player] = rec end
	rec.Count += 1
	if rec.Count > 12 then return end
	local ok, err = pcall(handlers[kind], player, arg)
	if not ok then warn("[TradeServer] " .. kind .. " : " .. tostring(err)) end
end)

Players.PlayerRemoving:Connect(function(player)
	local trade = trades[player]
	if trade then
		notify(other(trade, player), player.DisplayName .. " left the game: trade cancelled.")
		endTrade(trade, "left")
	end
	requests[player] = nil
	-- ses demandes encore affichées chez les autres disparaissent
	for target, list in requests do
		if list[player] then
			list[player] = nil
			if target.Parent then updateRemote:FireClient(target, {k = "unrequest", Id = player.UserId}) end
		end
	end
	lastRequest[player], lastAction[player] = nil, nil
end)
