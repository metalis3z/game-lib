--Made by NexusPrime_11 
local PollService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService       = game:GetService("HttpService")
local MessagingService  = game:GetService("MessagingService")

local Net = require(ReplicatedStorage.Packages.Net)

local activePolls   = {}
local timers        = {}
local currentPollID = nil
local ReplicatorRemote

local VOTE_SYNC_CHANNEL = "GlobalVoteSync"

local function findRemotes()
	local internal = ReplicatedStorage:FindFirstChild("__ReplicatorInternal")
	if internal then
		ReplicatorRemote = internal:FindFirstChild("RemoteEvent")
	end
end

local function syncPoll(pollID)
	findRemotes()
	if not ReplicatorRemote then return end

	local pollData = activePolls[pollID]
	if not pollData then return end

	ReplicatorRemote:FireAllClients({
		{
			utf8.char(0), "Polls", "Polls",
			{
				polls = {
					[pollID] = {
						text            = pollData.text,
						option1         = pollData.option1,
						option2         = pollData.option2,
						option1colorHex = pollData.option1colorHex,
						option2colorHex = pollData.option2colorHex,
						endsAt          = pollData.endsAt,
						allowSwitch     = pollData.allowSwitch,
						votes           = pollData.votes,
						voted           = pollData.voted,
					}
				},
				activePoll = pollID,
			}
		}
	})
end

MessagingService:SubscribeAsync(VOTE_SYNC_CHANNEL, function(message)
	local data = message.Data
	if data.JobId == game.JobId then return end 

	local pollData = activePolls[data.PollID]
	if pollData then
		if data.OldChoice then
			pollData.votes[data.OldChoice] = math.max(0, pollData.votes[data.OldChoice] - 1)
		end
		pollData.votes[data.NewChoice] = (pollData.votes[data.NewChoice] or 0) + 1

		syncPoll(data.PollID) 
	end
end)

local function broadcastClear()
	if not ReplicatorRemote then return end
	currentPollID = nil
	ReplicatorRemote:FireAllClients({
		{
			utf8.char(0), "Polls", "Polls",
			{
				activePoll = nil,
			}
		}
	})
end

function PollService.startPoll(data, existingID)
	findRemotes()

	if not ReplicatorRemote then
		warn("[pollservice] cannot start poll — replicatorremote not found")
		return nil
	end

	data = data or {}

	local question = tostring(data.question or data.text or "poll")
	local opt1     = tostring(data.option1 or "yes")
	local opt2     = tostring(data.option2 or "no")
	local col1     = tostring(data.option1colorHex or "2197ff")
	local col2     = tostring(data.option2colorHex or "da261a")
	local duration = math.max(5, tonumber(data.duration) or 30)
	local allowSw  = (data.allowSwitch ~= false)

	PollService.endActivePoll()

	local pollID = existingID or HttpService:GenerateGUID(false)
	local endsAt = workspace:GetServerTimeNow() + duration

	activePolls[pollID] = {
		text            = question,
		option1         = opt1,
		option2         = opt2,
		option1colorHex = col1,
		option2colorHex = col2,
		endsAt          = endsAt,
		allowSwitch     = allowSw,
		votes           = { A = 0, B = 0 },
		voted           = {},
	}

	currentPollID = pollID

	task.defer(function()
		syncPoll(pollID)
	end)

	timers[pollID] = task.delay(duration, function()
		activePolls[pollID] = nil
		timers[pollID]      = nil
		if currentPollID == pollID then
			broadcastClear()
		end
	end)

	return pollID
end

MessagingService:SubscribeAsync("GlobalPollBroadcast", function(message)
	local data = message.Data
	if data.JobId == game.JobId then return end

	PollService.startPoll(data.PollData, data.PollID) 
end)

function PollService.endActivePoll()
	for pollID, handle in pairs(timers) do
		task.cancel(handle)
		timers[pollID]      = nil
		activePolls[pollID] = nil
	end
	broadcastClear()
end

function PollService.getResults(pollID)
	local p = activePolls[pollID]
	if not p then return nil end
	return {
		A     = p.votes.A,
		B     = p.votes.B,
		total = p.votes.A + p.votes.B,
	}
end

Net:RemoteEvent("PollService/Vote").OnServerEvent:Connect(function(player, _sessionID, pollID, optionID)
	local pollData = activePolls[pollID]
	if not pollData or workspace:GetServerTimeNow() >= pollData.endsAt then return end

	local uid    = tostring(player.UserId)
	local choice = (optionID == "571bdc6b-fedd-4c38-ab3a-1c3b2f28917b") and "A" or "B"
	local oldVote = pollData.voted[uid]

	if oldVote then
		if not pollData.allowSwitch or oldVote == choice then return end
		pollData.votes[oldVote] = math.max(0, pollData.votes[oldVote] - 1)
	end

	pollData.voted[uid]    = choice
	pollData.votes[choice] = (pollData.votes[choice] or 0) + 1

	pcall(function()
		MessagingService:PublishAsync(VOTE_SYNC_CHANNEL, {
			PollID = pollID,
			NewChoice = choice,
			OldChoice = oldVote,
			JobId = game.JobId
		})
	end)

	syncPoll(pollID)
end)

function PollService:Start()
	MessagingService:SubscribeAsync(VOTE_SYNC_CHANNEL, function(message)
		local data = message.Data
		if data.JobId == game.JobId then return end 

		local pollData = activePolls[data.PollID]
		if pollData then
			if data.OldChoice then
				pollData.votes[data.OldChoice] = math.max(0, pollData.votes[data.OldChoice] - 1)
			end
			pollData.votes[data.NewChoice] = (pollData.votes[data.NewChoice] or 0) + 1
			syncPoll(data.PollID) 
		end
	end)

	MessagingService:SubscribeAsync("GlobalPollBroadcast", function(message)
		local data = message.Data
		if data.JobId == game.JobId then return end
		PollService.startPoll(data.PollData, data.PollID) 
	end)

	Net:RemoteEvent("PollService/Vote").OnServerEvent:Connect(function(player, _sessionID, pollID, optionID)
		local pollData = activePolls[pollID]
		if not pollData or workspace:GetServerTimeNow() >= pollData.endsAt then return end

		local uid    = tostring(player.UserId)
		local choice = (optionID == "571bdc6b-fedd-4c38-ab3a-1c3b2f28917b") and "A" or "B"
		local oldVote = pollData.voted[uid]

		if oldVote then
			if not pollData.allowSwitch or oldVote == choice then return end
			pollData.votes[oldVote] = math.max(0, pollData.votes[oldVote] - 1)
		end

		pollData.voted[uid]    = choice
		pollData.votes[choice] = (pollData.votes[choice] or 0) + 1

		pcall(function()
			MessagingService:PublishAsync(VOTE_SYNC_CHANNEL, {
				PollID = pollID,
				NewChoice = choice,
				OldChoice = oldVote,
				JobId = game.JobId
			})
		end)

		syncPoll(pollID)
	end)
end

return PollService