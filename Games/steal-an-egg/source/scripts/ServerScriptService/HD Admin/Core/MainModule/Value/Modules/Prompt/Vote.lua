--!strict

--[[

	This is the server-side vote session engine for the vote and globalVote commands

	Vote.open registers a session, shows the voting prompt to every target and
	collects their ballots over one shared VoteSubmit remote. The command's run
	drives the countdown itself and calls Vote.finish when it ends

	For global votes each receiving server writes its tally into one MemoryStore
	sorted map keyed by the statement's globalUID. The origin server sums those
	with its own local tally (kept out of the map so Studio still works) and
	writes the combined results back into the same map for the other servers to
	fetch and display. We use the map instead of per-server messaging replies
	because a dropped message would silently lose that server's votes, whereas
	the map holds every tally until the origin reads them

--]]


-- CONFIG
local MAP_PREFIX = "HDAdminVote_"
local BALLOT_SLACK = 1 -- seconds a ballot can still land after the deadline
local TALLY_TTL = 240
local RESULTS_KEY = "results"


-- LOCAL
local Vote = {}
local Players = game:GetService("Players")
local MemoryStoreService = game:GetService("MemoryStoreService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Remote = require(modules.Objects.Remote)
local Prompt = require(modules.Prompt)
local generateUID = require(modules.DataUtil.generateUID)
local IsolatedServer = require(modules.IsolatedServer)
local submitRemote: Remote.Class? = nil
local activeSessions: {[string]: Session} = {}
local serverKey: string? = nil
local isolatedMaps: {[string]: any} = {}


-- TYPES
export type Session = {
	voteId: string,
	question: string,
	options: {string},
	deadline: number,
	eligible: {[number]: boolean},
	eligibleCount: number,
	ballots: {[number]: number},
	ballotCount: number,
	dismissed: {[number]: boolean},
	finished: boolean,
	taskRef: any,
	promptIndexes: {string},
}
export type ResultRow = {
	answer: string,
	votes: number,
	percentage: number,
}
export type ResultsPayload = {
	question: string,
	results: {ResultRow},
	fromUserId: number?,
	showToEveryone: boolean?,
	colorSeed: string?,
}


-- PUBLIC
Vote.GLOBAL_GRACE = 5 -- extra seconds the origin waits so late tallies land in the map
Vote.RESULTS_POLL_INTERVAL = 2
Vote.RESULTS_POLL_TIMEOUT = 20


-- LOCAL FUNCTIONS
local function getServerKey(): string
	if not serverKey then
		serverKey = "s_" .. (if game.JobId ~= "" then game.JobId else generateUID(10))
	end
	return serverKey :: string
end

local function getIsolatedSortedMap(globalUID: string): any
	local existing = isolatedMaps[globalUID]
	if existing then
		return existing
	end
	local entries: {[string]: any} = {}
	local map = {
		SetAsync = function(_self: any, entryKey: string, value: any, _expiry: number?)
			entries[entryKey] = value
		end,
		GetAsync = function(_self: any, entryKey: string): any
			return entries[entryKey]
		end,
		GetRangeAsync = function(_self: any, _direction: any, _count: number, _exclusiveLowerBound: any): {any}
			local items = {}
			for entryKey, value in entries do
				table.insert(items, {key = entryKey, value = value})
			end
			table.sort(items, function(itemA, itemB)
				return itemA.key < itemB.key
			end)
			return items
		end,
	}
	isolatedMaps[globalUID] = map
	task.delay(TALLY_TTL, function()
		isolatedMaps[globalUID] = nil
	end)
	return map
end

local function getSortedMap(globalUID: string): MemoryStoreSortedMap?
	if IsolatedServer.isIsolated() then
		return getIsolatedSortedMap(globalUID)
	end
	local success, map = pcall(function()
		return MemoryStoreService:GetSortedMap(MAP_PREFIX .. globalUID)
	end)
	if not success then
		return nil
	end
	return map
end

local function ensureRemote()
	if submitRemote then
		return
	end
	submitRemote = Remote.new("VoteSubmit", "Event", "Low")
	if not submitRemote then
		return
	end
	submitRemote:onServerEvent(function(player: Player, voteId: unknown, optionIndex: unknown)
		if typeof(voteId) ~= "string" then
			return
		end
		local session = activeSessions[voteId :: string]
		if not session or session.finished then
			return
		end
		-- Only invited players may vote, and only while the countdown is live
		if not session.eligible[player.UserId] then
			return
		end
		if os.clock() > session.deadline + BALLOT_SLACK then
			return
		end
		-- Closing the teaser counts as this player's answer, so a server where
		-- everyone voted or closed can wrap up without waiting the full duration
		if optionIndex == "dismiss" then
			session.dismissed[player.UserId] = true
			return
		end
		if typeof(optionIndex) ~= "number" or optionIndex % 1 ~= 0 then
			return
		end
		local index = optionIndex :: number
		if index < 1 or index > #session.options then
			return
		end
		if session.ballots[player.UserId] == nil then
			session.ballotCount += 1
		end
		session.ballots[player.UserId] = index
	end)
end


-- FUNCTIONS
function Vote.open(commandTask: any, config: {question: string, options: {string}, duration: number, targets: {Player}, fromUserId: number?, colorSeed: string?}): Session
	ensureRemote()
	local voteId = generateUID(10)
	local session: Session = {
		voteId = voteId,
		question = config.question,
		options = config.options,
		deadline = os.clock() + config.duration,
		eligible = {},
		eligibleCount = 0,
		ballots = {},
		ballotCount = 0,
		dismissed = {},
		finished = false,
		taskRef = commandTask,
		promptIndexes = {},
	}
	activeSessions[voteId] = session
	-- Sessions die with their task so an undone vote never keeps taking ballots
	commandTask.janitor:add(function()
		session.finished = true
		activeSessions[voteId] = nil
	end, true)
	local promptOptions: any = {
		voteId = voteId,
		fields = config.options,
		duration = config.duration,
		colorSeed = config.colorSeed or voteId,
	}
	if typeof(config.fromUserId) == "number" then
		promptOptions.fromUserId = config.fromUserId
	else
		promptOptions.fromServer = true
	end
	for index, target in config.targets do
		if not (typeof(target) == "Instance" and target:IsA("Player") and target.Parent) then
			continue
		end
		if session.eligible[target.UserId] then
			continue
		end
		session.eligible[target.UserId] = true
		session.eligibleCount += 1
		local janitorIndex = `votePrompt_{voteId}_{index}`
		commandTask.janitor:add(Prompt.vote(target, config.question, promptOptions), nil, janitorIndex)
		table.insert(session.promptIndexes, janitorIndex)
	end
	return session
end

function Vote.allResponded(session: Session): boolean
	for userId in session.eligible do
		if session.ballots[userId] == nil and not session.dismissed[userId] and Players:GetPlayerByUserId(userId) then
			return false
		end
	end
	return true
end

function Vote.finish(session: Session)
	if session.finished then
		return
	end
	session.finished = true
	activeSessions[session.voteId] = nil
	-- The voting cards close here so a finished poll can't still be answered
	local janitor = session.taskRef and session.taskRef.janitor
	if janitor then
		for _, janitorIndex in session.promptIndexes do
			janitor:removeList(janitorIndex)
		end
	end
end

function Vote.tally(session: Session): ({number}, number)
	local scores = table.create(#session.options, 0)
	local totalVotes = 0
	for _, optionIndex in session.ballots do
		scores[optionIndex] += 1
		totalVotes += 1
	end
	local didNotVote = math.max(session.eligibleCount - totalVotes, 0)
	return scores, didNotVote
end

function Vote.buildResults(options: {string}, scores: {number}, didNotVote: number): {ResultRow}
	local highest = didNotVote
	for _, votes in scores do
		if votes > highest then
			highest = votes
		end
	end
	if highest < 1 then
		highest = 1
	end
	local results: {ResultRow} = {}
	for index, answer in options do
		local votes = scores[index] or 0
		table.insert(results, {answer = answer, votes = votes, percentage = votes / highest})
	end
	table.insert(results, {answer = "Did Not Vote", votes = didNotVote, percentage = didNotVote / highest})
	return results
end

function Vote.publishTally(globalUID: string, scores: {number}, didNotVote: number)
	local map = getSortedMap(globalUID)
	if not map then
		return
	end
	pcall(function()
		map:SetAsync(getServerKey(), {scores = scores, didNotVote = didNotVote}, TALLY_TTL)
	end)
end

function Vote.collectTallies(globalUID: string, optionCount: number): ({number}, number)
	local summed = table.create(optionCount, 0)
	local didNotVote = 0
	local map = getSortedMap(globalUID)
	if not map then
		return summed, didNotVote
	end
	local exclusiveLowerBound: any = nil
	while true do
		local success, items = pcall(function()
			return map:GetRangeAsync(Enum.SortDirection.Ascending, 200, exclusiveLowerBound)
		end)
		if not success or typeof(items) ~= "table" then
			break
		end
		for _, item in items :: {any} do
			if typeof(item.key) ~= "string" or string.sub(item.key, 1, 2) ~= "s_" or typeof(item.value) ~= "table" then
				continue
			end
			local entryScores = item.value.scores
			if typeof(entryScores) == "table" then
				for index = 1, optionCount do
					local votes = tonumber(entryScores[index])
					if votes and votes > 0 then
						summed[index] += math.floor(votes)
					end
				end
			end
			local entryDidNotVote = tonumber(item.value.didNotVote)
			if entryDidNotVote and entryDidNotVote > 0 then
				didNotVote += math.floor(entryDidNotVote)
			end
		end
		if #items < 200 then
			break
		end
		exclusiveLowerBound = {key = (items :: {any})[#items].key}
	end
	return summed, didNotVote
end

function Vote.publishResults(globalUID: string, payload: ResultsPayload)
	local map = getSortedMap(globalUID)
	if not map then
		return
	end
	pcall(function()
		map:SetAsync(RESULTS_KEY, payload, TALLY_TTL)
	end)
end

function Vote.fetchResults(globalUID: string): ResultsPayload?
	local map = getSortedMap(globalUID)
	if not map then
		return nil
	end
	local success, payload = pcall(function()
		return map:GetAsync(RESULTS_KEY)
	end)
	if success and typeof(payload) == "table" then
		return payload :: ResultsPayload
	end
	return nil
end

function Vote.displayResults(player: Player, payload: ResultsPayload)
	local options: any = {
		results = payload.results,
		colorSeed = payload.colorSeed,
	}
	if typeof(payload.fromUserId) == "number" then
		options.fromUserId = payload.fromUserId
	else
		options.fromServer = true
	end
	;(Prompt :: any).voteResults(player, payload.question, options)
end


return Vote
