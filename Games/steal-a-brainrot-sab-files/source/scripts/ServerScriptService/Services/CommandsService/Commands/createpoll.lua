local MessagingService = game:GetService("MessagingService")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local POLL_CHANNEL = "GlobalPoll"

-- Simple poll system (like countdown)
local activePoll = nil
local pollVotes = {}
local pollTimer = nil

local function getPollEvent()
	local pollRemotes = ReplicatedStorage:FindFirstChild("PollRemotes")
	if pollRemotes then
		return pollRemotes:FindFirstChild("PollEvent")
	end
	return nil
end

local function broadcastPoll(action, data)
	local pollEvent = getPollEvent()
	if not pollEvent then return end
	
	for _, player in ipairs(Players:GetPlayers()) do
		pollEvent:FireClient(player, action, data)
	end
end

local function startSimplePoll(question, option1, option2, duration)
	-- Cancel previous poll
	if pollTimer then
		task.cancel(pollTimer)
		pollTimer = nil
	end
	
	local pollId = HttpService:GenerateGUID(false)
	activePoll = {
		id = pollId,
		question = question,
		option1 = option1,
		option2 = option2,
		duration = duration,
		votesA = 0,
		votesB = 0,
	}
	pollVotes = {}
	
	-- Send to all players
	broadcastPoll("show", {
		id = pollId,
		question = question,
		option1 = option1,
		option2 = option2,
		option1colorHex = "2197ff",
		option2colorHex = "da261a",
	})
	
	-- Timer for poll end
	pollTimer = task.delay(duration, function()
		if activePoll and activePoll.id == pollId then
			broadcastPoll("hide", {})
			activePoll = nil
			pollVotes = {}
		end
	end)
	
	return pollId
end

local function handleVote(player, pollId, choice)
	if not activePoll or activePoll.id ~= pollId then return end
	if pollVotes[player.UserId] then return end -- Already voted
	
	pollVotes[player.UserId] = choice
	
	if choice == "A" then
		activePoll.votesA = activePoll.votesA + 1
	else
		activePoll.votesB = activePoll.votesB + 1
	end
	
	-- Update display for all
	broadcastPoll("update", {
		votesA = activePoll.votesA,
		votesB = activePoll.votesB,
	})
end

-- Listen for client votes
local pollEvent = getPollEvent()
if pollEvent then
	pollEvent.OnServerEvent:Connect(function(player, action, data)
		if action == "vote" then
			handleVote(player, data.pollId, data.choice)
		end
	end)
end

-- Global poll via MessagingService
MessagingService:SubscribeAsync(POLL_CHANNEL, function(message)
	local data = message.Data
	if typeof(data) ~= "table" then return end
	if not data.question or not data.option1 or not data.option2 or not data.duration then return end
	startSimplePoll(data.question, data.option1, data.option2, data.duration)
end)

local module = function(Conch, Config)
	Conch.register("createpoll", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "string",
					name = "question",
				},
			{
				kind = "argument",
				type = "string",
				name = "option1",
			},
			{
				kind = "argument",
				type = "string",
				name = "option2",
			},
			{
				kind = "argument",
				type = "number",
				name = "duration",
			}
		end,
		callback = function(question, option1, option2, duration)
			if duration <= 0 then return false, "Duration must be greater than 0." end
			
			-- Start poll locally
			local pollId = startSimplePoll(question, option1, option2, duration)
			
			-- Also publish globally for other servers
			MessagingService:PublishAsync(POLL_CHANNEL, {
				question = question,
				option1  = option1,
				option2  = option2,
				duration = duration,
				pollID   = pollId,
			})
			
			return string.format("Poll started: %s | %s vs %s (%ds)", question, option1, option2, duration)
		end,
	})
end

return module