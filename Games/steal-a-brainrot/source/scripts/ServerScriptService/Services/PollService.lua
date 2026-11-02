local PollService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService       = game:GetService("HttpService")
local Net               = require(ReplicatedStorage.Packages.Net)

-- ─── Remotes ────────────────────────────────────────────────────────────────
local VoteRemote = Net:RemoteEvent("PollService/Vote")
local SyncRemote  = Net:RemoteEvent("PollService/Sync")

-- ─── State ──────────────────────────────────────────────────────────────────
local activePolls  = {}   -- pollID → pollData
local timers       = {}   -- pollID → task handle
local currentPollID = nil
local isGlobalPoll  = false

local ReplicatorRemote = nil

local MSG_START = "Poll_Start"
local MSG_VOTE  = "Poll_Vote"
local MSG_END   = "Poll_End"

-- ─── Helpers ────────────────────────────────────────────────────────────────
local function findRemote()
	if ReplicatorRemote then return true end
	local internal = ReplicatedStorage:FindFirstChild("__ReplicatorInternal")
	if internal then
		ReplicatorRemote = internal:FindFirstChild("RemoteEvent")
	end
	return ReplicatorRemote ~= nil
end

-- Envoie l'état du poll à tous les clients de CE serveur
local function syncPoll(pollID)
	local p = activePolls[pollID]
	if not p then return end
	-- Sync direct via RemoteEvent dédié (bypass Replicator = pas de lag)
	SyncRemote:FireAllClients(pollID, p.votes.A, p.votes.B, table.clone(p.voted))
	-- Aussi sync via Replicator pour les nouveaux joueurs (état initial)
	if findRemote() then
		ReplicatorRemote:FireAllClients({
			{
				utf8.char(0), "Polls", "Polls",
				{
					polls = { [pollID] = {
						text            = p.text,
						option1         = p.option1,
						option2         = p.option2,
						option1colorHex = p.option1colorHex,
						option2colorHex = p.option2colorHex,
						endsAt          = p.endsAt,
						allowSwitch     = p.allowSwitch,
						votes           = { A = p.votes.A, B = p.votes.B },
						voted           = table.clone(p.voted),
					}},
					activePoll = pollID,
				}
			}
		})
	end
end

local function broadcastClear()
	if not findRemote() then return end
	currentPollID = nil
	isGlobalPoll  = false
	ReplicatorRemote:FireAllClients({
		{ utf8.char(0), "Polls", "Polls", { activePoll = nil } }
	})
end

-- Recalcule les totaux A/B à partir de la table fusionnée des votants
-- (source de vérité unique : évite que les votes d'un serveur écrasent ceux d'un autre)
local function recomputeVotes(p)
	local a, b = 0, 0
	for _, choice in pairs(p.voted) do
		if choice == "A" then
			a += 1
		elseif choice == "B" then
			b += 1
		end
	end
	p.votes.A = a
	p.votes.B = b
end

-- ─── Démarrer un poll LOCAL ──────────────────────────────────────────────────
function PollService.startPoll(data)
	findRemote()
	data = data or {}

	local question = tostring(data.question or data.text or "poll")
	local opt1     = tostring(data.option1 or "yes")
	local opt2     = tostring(data.option2 or "no")
	local col1     = tostring(data.option1colorHex or "2197ff")
	local col2     = tostring(data.option2colorHex or "da261a")
	local duration = math.max(5, tonumber(data.duration) or 30)
	local allowSw  = (data.allowSwitch ~= false)

	-- Terminer le poll actif avant d'en lancer un nouveau
	PollService.endActivePoll()

	local pollID = tostring(data.pollID or HttpService:GenerateGUID(false))
	local endsAt = data.endsAt or (workspace:GetServerTimeNow() + duration)

	activePolls[pollID] = {
		text            = question,
		option1         = opt1,
		option2         = opt2,
		option1colorHex = col1,
		option2colorHex = col2,
		endsAt          = endsAt,
		allowSwitch     = allowSw,
		votes           = data.votes or { A = 0, B = 0 },
		voted           = data.voted or {},
	}

	currentPollID = pollID
	isGlobalPoll  = data.isGlobal == true

	-- Sync immédiate
	task.defer(function() syncPoll(pollID) end)

	-- Timer de fin
	local timeLeft = math.max(0, endsAt - workspace:GetServerTimeNow())
	timers[pollID] = task.delay(timeLeft, function()
		activePolls[pollID] = nil
		timers[pollID]      = nil
		if currentPollID == pollID then
			broadcastClear()
		end
	end)

	return pollID
end

-- ─── Démarrer un poll GLOBAL ─────────────────────────────────────────────────
function PollService.startGlobalPoll(data)
	findRemote()
	data = data or {}

	local pollID   = HttpService:GenerateGUID(false)
	local duration = math.max(5, tonumber(data.duration) or 30)
	local endsAt   = workspace:GetServerTimeNow() + duration

	local globalData = {
		pollID          = pollID,
		question        = tostring(data.question or data.text or "poll"),
		option1         = tostring(data.option1 or "yes"),
		option2         = tostring(data.option2 or "no"),
		option1colorHex = tostring(data.option1colorHex or "2197ff"),
		option2colorHex = tostring(data.option2colorHex or "da261a"),
		duration        = duration,
		endsAt          = endsAt,
		allowSwitch     = (data.allowSwitch ~= false),
		isGlobal        = true,
		jobId           = game.JobId,
	}

	-- Démarrer localement
	PollService.startPoll(globalData)

	-- Broadcaster aux autres serveurs via MessagingHub
	if _G.MessagingHub then
		_G.MessagingHub.Publish(MSG_START, globalData)
	end

	return pollID
end

-- ─── Fin de poll ─────────────────────────────────────────────────────────────
function PollService.endActivePoll()
	for pollID, handle in pairs(timers) do
		task.cancel(handle)
		timers[pollID]     = nil
		activePolls[pollID] = nil
	end
	broadcastClear()
end

function PollService.endGlobalPoll()
	PollService.endActivePoll()
	if _G.MessagingHub then
		_G.MessagingHub.Publish(MSG_END, { ts = os.time(), jobId = game.JobId })
	end
end

function PollService.getResults(pollID)
	local p = activePolls[pollID]
	if not p then return nil end
	return { A = p.votes.A, B = p.votes.B, total = p.votes.A + p.votes.B }
end

-- ─── Vote LOCAL ──────────────────────────────────────────────────────────────
VoteRemote.OnServerEvent:Connect(function(player, _session, pollID, optionID)
	local p = activePolls[pollID]
	if not p then return end
	if workspace:GetServerTimeNow() >= p.endsAt then return end

	local uid    = tostring(player.UserId)
	local choice = (optionID == "571bdc6b-fedd-4c38-ab3a-1c3b2f28917b") and "A" or "B"
	local oldVote = p.voted[uid]

	if oldVote then
		if not p.allowSwitch then return end
		if oldVote == choice then return end
	end

	p.voted[uid]    = choice
	recomputeVotes(p)

	-- Sync IMMÉDIATE sur ce serveur (zéro latence)
	syncPoll(pollID)

	-- Propager aux autres serveurs via batch (évite le rate limit)
	if isGlobalPoll then
		if not _G._pollBatchPending then _G._pollBatchPending = {} end
		_G._pollBatchPending[pollID] = true
		if not _G._pollBatchRunning then
			_G._pollBatchRunning = true
			task.delay(0.5, function()
				_G._pollBatchRunning = false
				if not _G.MessagingHub then return end
				for pid in pairs(_G._pollBatchPending or {}) do
					local poll = activePolls[pid]
					if poll then
						_G.MessagingHub.Publish(MSG_VOTE, {
							pollID  = pid,
							votesA  = poll.votes.A,
							votesB  = poll.votes.B,
							voted   = table.clone(poll.voted),
							jobId   = game.JobId,
						})
					end
				end
				_G._pollBatchPending = {}
			end)
		end
	end
end)

-- ─── Handlers MessagingHub ───────────────────────────────────────────────────
local function registerHandlers()
	if not _G.MessagingHub then return end

	-- Recevoir un vote d'un autre serveur
	_G.MessagingHub.Register(MSG_VOTE, function(data)
		if data.jobId == game.JobId then return end
		local p = activePolls[data.pollID]
		if not p then return end
		-- Fusionner la table des votants (source de vérité), puis recalculer les totaux
		if type(data.voted) == "table" then
			for uid, choice in pairs(data.voted) do
				p.voted[uid] = choice
			end
		end
		recomputeVotes(p)
		syncPoll(data.pollID)
	end)

	-- Recevoir le démarrage d'un poll global
	_G.MessagingHub.Register(MSG_START, function(data)
		if typeof(data) ~= "table" then return end
		if data.jobId == game.JobId then return end -- ignore l'auto-écho du serveur émetteur
		-- Recalculer endsAt basé sur le temps local
		local timeLeft = (data.endsAt or 0) - workspace:GetServerTimeNow()
		if timeLeft <= 0 then timeLeft = data.duration or 30 end
		data.endsAt = workspace:GetServerTimeNow() + timeLeft
		PollService.startPoll(data)
	end)

	-- Recevoir la fin d'un poll global
	_G.MessagingHub.Register(MSG_END, function(data)
		if typeof(data) == "table" and data.jobId == game.JobId then return end -- ignore l'auto-écho
		PollService.endActivePoll()
	end)
end

task.spawn(function()
	while not _G.MessagingHub do task.wait(0.5) end
	registerHandlers()
	print("[PollService] ✅ MessagingHub connecté")
end)

return PollService
