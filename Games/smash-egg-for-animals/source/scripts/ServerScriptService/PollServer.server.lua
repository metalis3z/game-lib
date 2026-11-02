-- PollServer : sondage à deux réponses (YES / NO, ou deux mots choisis par l'admin) lancé par un admin (panneau F2, onglet Poll) dans TOUS les serveurs.
--  * MessagingService : envoie la question à tous les serveurs (et l'ordre d'arrêt)
--  * MemoryStore (HashMap) : compte les votes de tous les serveurs, et garde le sondage en cours pour les serveurs qui démarrent après
--  * chaque joueur a UNE voix par sondage, même s'il change de serveur, et peut changer d'avis autant de fois qu'il veut jusqu'à la fin :
--    seul son dernier choix compte. Les changements d'un joueur sont écrits l'un après l'autre (jamais deux en même temps),
--    et le score affiché = total enregistré + choix de ce serveur pas encore enregistrés : il ne recule jamais d'un vote.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = require(game:GetService("ServerScriptService"):WaitForChild("GlobalBus")) -- (un seul abonnement pour tout le jeu : voir GlobalBus)
local MemoryStoreService = game:GetService("MemoryStoreService")

local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local createRemote = remotes:WaitForChild("CreateGlobalPoll")
local voteRemote = remotes:WaitForChild("PollVote")
local updateRemote = remotes:WaitForChild("PollUpdate")
local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))

local TOPIC = "AdminGlobalPoll"
local REFRESH = 2          -- secondes entre deux mises à jour du score
local MIN_TIME, MAX_TIME = 10, 3600
local MAX_QUESTION = 120
local MAX_WORD = 20 -- les deux réponses choisies par l'admin (à la place de YES / NO)
local TextService = game:GetService("TextService")
-- texte montré à tous les joueurs : passé au filtre Roblox (obligatoire). En cas d'échec, rien n'est affiché à la place.
local function filtered(text, userId)
	local ok, result = pcall(function()
		return TextService:FilterStringAsync(text, userId):GetNonChatStringForBroadcastAsync()
	end)
	return ok and result or nil
end
local function cleanWord(word, default)
	if type(word) ~= "string" then return default end
	word = string.gsub(string.gsub(word, "^%s+", ""), "%s+$", "")
	word = string.sub(word, 1, MAX_WORD)
	if word == "" then return default end
	return word
end

local map
pcall(function() map = MemoryStoreService:GetHashMap("GlobalPolls_v1") end)

local current    -- {Id, Question, EndsAt, By}
local totals = {Yes = 0, No = 0}
local localCounts = {Yes = 0, No = 0} -- secours si le MemoryStore ne répond pas (Studio sans accès API...)
local votes = {}      -- [userId] = "Yes" | "No" : dernier choix du joueur (ce qu'il veut)
local committed = {}  -- [userId] = choix déjà compté dans le total (MemoryStore, ou compte local en secours)
local busy = {}       -- [userId] = true pendant que son choix est en cours d'écriture
local working = 0     -- écritures en cours
local lastVote = {}

local function isAdmin(player)
	return table.find(AdminConfig.AdminIds, player.UserId) ~= nil
end

local function state(ended)
	if not current then return nil end
	-- total enregistré + choix de ce serveur pas encore enregistrés
	local yes, no = totals.Yes, totals.No
	for uid, choice in votes do
		local done = committed[uid]
		if done ~= choice then
			if choice == "Yes" then yes += 1 else no += 1 end
			if done == "Yes" then yes -= 1 elseif done == "No" then no -= 1 end
		end
	end
	return {Id = current.Id, Question = current.Question, EndsAt = current.EndsAt, By = current.By, Yes = math.max(0, yes), No = math.max(0, no), Ended = ended == true,
		Options = current.Options or {Yes = "YES", No = "NO"}} -- (les mots affichés sur les deux boutons)
end

local function broadcast(ended)
	local s = state(ended)
	if s then updateRemote:FireAllClients(s) end
end

-- score de tous les serveurs
local function refreshTotals(poll)
	if map then
		local okY, yes = pcall(function() return map:GetAsync("c_" .. poll.Id .. "_Yes") end)
		local okN, no = pcall(function() return map:GetAsync("c_" .. poll.Id .. "_No") end)
		if okY and okN then
			totals.Yes, totals.No = tonumber(yes) or 0, tonumber(no) or 0
			return
		end
	end
	totals.Yes, totals.No = localCounts.Yes, localCounts.No
end

local function startPoll(poll)
	if current and current.Id == poll.Id then return end
	current = poll
	votes, committed, busy, lastVote = {}, {}, {}, {}
	totals = {Yes = 0, No = 0}
	localCounts = {Yes = 0, No = 0}
	refreshTotals(poll)
	broadcast(false)
	task.spawn(function()
		while current == poll and os.time() < poll.EndsAt do
			task.wait(REFRESH)
			if current ~= poll then return end
			refreshTotals(poll)
			broadcast(false)
		end
		if current ~= poll then return end
		local waited = 0
		while working > 0 and waited < 5 do waited += task.wait(0.1) end -- les derniers votes de ce serveur finissent de s'écrire
		task.wait(1.5) -- laisse arriver ceux des autres serveurs
		refreshTotals(poll)
		broadcast(true) -- résultats finaux
		if current == poll then current = nil end
	end)
end

local function stopPoll(id)
	if current and current.Id == id then current.EndsAt = os.time() end
end

---------------------------------------------------------------- commandes admin
createRemote.OnServerEvent:Connect(function(player, action, question, seconds, wordA, wordB)
	if not isAdmin(player) then return end
	if action == "start" then
		if type(question) ~= "string" then return end
		question = string.sub(string.gsub(question, "^%s+", ""), 1, MAX_QUESTION)
		if question == "" then return end
		seconds = math.clamp(math.floor(tonumber(seconds) or 60), MIN_TIME, MAX_TIME)
		-- les deux réponses : les mots choisis par l'admin (YES / NO si rien n'est écrit), filtrés comme la question
		local a, b = cleanWord(wordA, "YES"), cleanWord(wordB, "NO")
		if string.lower(a) == string.lower(b) then b = b .. " " end
		question = filtered(question, player.UserId) or question
		a = filtered(a, player.UserId) or "YES"
		b = filtered(b, player.UserId) or "NO"
		local poll = {Id = tostring(os.time()) .. "_" .. math.random(1000, 9999), Question = question, EndsAt = os.time() + seconds, By = player.DisplayName,
			Options = {Yes = a, No = b}}
		if map then pcall(function() map:SetAsync("current", poll, seconds + 30) end) end
		startPoll(poll)
		pcall(function() MessagingService:PublishAsync(TOPIC, {Action = "start", Poll = poll, JobId = game.JobId}) end)
	elseif action == "stop" and current then
		local id = current.Id
		stopPoll(id)
		if map then pcall(function() map:RemoveAsync("current") end) end
		pcall(function() MessagingService:PublishAsync(TOPIC, {Action = "stop", Id = id, JobId = game.JobId}) end)
	end
end)

pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		local data = message.Data
		if type(data) ~= "table" or data.JobId == game.JobId then return end
		if data.Action == "start" and type(data.Poll) == "table" then
			startPoll(data.Poll)
		elseif data.Action == "stop" then
			stopPoll(data.Id)
		end
	end)
end)

---------------------------------------------------------------- votes
local function addCount(poll, choice, delta, ttl)
	for _ = 1, 4 do -- un compteur ne doit pas rater un vote : on réessaie
		if pcall(function() map:UpdateAsync("c_" .. poll.Id .. "_" .. choice, function(n) return (tonumber(n) or 0) + delta end, ttl) end) then return true end
		task.wait(0.5)
	end
	return false
end

-- écrit le dernier choix du joueur, puis recommence s'il a encore changé d'avis entre-temps (un seul passage à la fois par joueur)
local function sync(poll, uid)
	if busy[uid] then return end
	busy[uid] = true
	working += 1
	task.spawn(function()
		local failures = 0
		while current == poll and votes[uid] ~= committed[uid] do
			local choice = votes[uid]
			if map and failures < 3 then
				local ttl = math.max(60, poll.EndsAt - os.time() + 600)
				local before
				local ok = pcall(function()
					map:UpdateAsync("v_" .. poll.Id .. "_" .. uid, function(old) before = old return choice end, ttl)
				end)
				if ok then
					if before ~= choice then -- sa voix passe d'un camp à l'autre (ou arrive) dans le total de tous les serveurs
						addCount(poll, choice, 1, ttl)
						totals[choice] += 1
						if before == "Yes" or before == "No" then
							addCount(poll, before, -1, ttl)
							totals[before] -= 1
						end
					end
					committed[uid] = choice
				else
					failures += 1
					task.wait(1)
				end
			else -- pas de MemoryStore (Studio sans accès API) : compte de ce serveur seulement
				local before = committed[uid]
				localCounts[choice] += 1
				totals[choice] += 1
				if before then
					localCounts[before] -= 1
					totals[before] -= 1
				end
				committed[uid] = choice
			end
		end
		busy[uid] = nil
		working -= 1
	end)
end

voteRemote.OnServerEvent:Connect(function(player, id, choice)
	if not current or id ~= current.Id or os.time() >= current.EndsAt then return end
	if choice ~= "Yes" and choice ~= "No" then return end
	local uid = player.UserId
	if votes[uid] == choice then return end
	votes[uid] = choice -- on peut changer d'avis sans limite : le dernier choix est toujours retenu
	sync(current, uid)
	if os.clock() - (lastVote[player] or 0) >= 0.1 then -- (clics en rafale : pas un envoi à tout le monde par clic, le prochain rafraîchissement suffit)
		lastVote[player] = os.clock()
		broadcast(false) -- affichage immédiat
	end
end)

---------------------------------------------------------------- joueurs qui arrivent / serveur qui démarre en plein sondage
Players.PlayerAdded:Connect(function(player)
	local poll = current
	if not poll then return end
	local uid = player.UserId
	if map and not votes[uid] then -- il a peut-être déjà voté dans un autre serveur
		local ok, saved = pcall(function() return map:GetAsync("v_" .. poll.Id .. "_" .. uid) end)
		if ok and (saved == "Yes" or saved == "No") and current == poll and not votes[uid] then
			votes[uid], committed[uid] = saved, saved
		end
	end
	local s = state(false)
	if s and current == poll then updateRemote:FireClient(player, s, votes[uid]) end
end)
Players.PlayerRemoving:Connect(function(player) lastVote[player] = nil end)

if map then
	task.spawn(function()
		local ok, poll = pcall(function() return map:GetAsync("current") end)
		if ok and type(poll) == "table" and type(poll.EndsAt) == "number" and poll.EndsAt > os.time() and not current then
			startPoll(poll)
		end
	end)
end
