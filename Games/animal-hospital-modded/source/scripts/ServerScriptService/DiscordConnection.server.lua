local MessagingService = game:GetService("MessagingService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Global = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Global")
local PollVoteRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PollVote")

local TOPIC = "AdminAbuse"

local Handlers = {}

Handlers.GlobalNotify = function(data)
	for _, player in ipairs(Players:GetPlayers()) do
		local ok, err = pcall(function()
			Global:FireClient(player, "globalNotify", data.message, nil, data.sender or "Discord")
		end)
		if not ok then
			warn("[GlobalNotify] Failed for " .. player.Name .. ": " .. tostring(err))
		end
	end
end

Handlers.AdminCommand = function(data)
	local action = string.lower(data.action)

	if action == "kick" then
	elseif action == "announce" then
	elseif action == "speed" then
	end
end

Handlers.ServerShutdown = function(data)
	local shutdownMessage = "Server Shutdown: " .. tostring(data.reason)

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(function()
			player:Kick(shutdownMessage)
		end)
	end

	game:BindToClose(function()
		task.wait(2)
	end)
end

Handlers.Countdown = function(data)
	local duration = tonumber(data.duration) or 10
	for _, player in ipairs(Players:GetPlayers()) do
		pcall(function()
			Global:FireClient(player, "countdown", duration)
		end)
	end
end

--[[
discord.gg/Tsw2b2EkSE is this only server that this admin abuse SHOULD be sold on.
]]--

local weatherEventHandler = require(game.ServerScriptService.Cmdr.Commands.weatherEventServer)
local weatherCancelHandler = require(game.ServerScriptService.Cmdr.Commands.weatherCancelServer)

Handlers.WeatherEvent = function(data)
	local result = weatherEventHandler(nil, data.weatherType or "")
	if result then
		warn("[WeatherEvent] " .. tostring(result))
	end
end

Handlers.WeatherCancel = function(data)
	local result = weatherCancelHandler(nil)
	if result then
		warn("[WeatherCancel] " .. tostring(result))
	end
end

local activePoll = nil

local function broadcastPollUpdate()
	if not activePoll then return end
	local totalVotes = activePoll.leftVotes + activePoll.rightVotes
	for _, player in ipairs(Players:GetPlayers()) do
		pcall(function()
			Global:FireClient(player, "pollUpdate", {
				question = activePoll.question,
				option1 = activePoll.option1,
				option2 = activePoll.option2,
				leftVotes = activePoll.leftVotes,
				rightVotes = activePoll.rightVotes,
				totalVotes = totalVotes,
				timeLeft = math.max(0, activePoll.endTime - os.time()),
			})
		end)
	end
end

local function endPoll()
	if not activePoll then return end
	for _, player in ipairs(Players:GetPlayers()) do
		pcall(function()
			Global:FireClient(player, "pollEnd", {
				question = activePoll.question,
				option1 = activePoll.option1,
				option2 = activePoll.option2,
				leftVotes = activePoll.leftVotes,
				rightVotes = activePoll.rightVotes,
			})
		end)
	end
	activePoll = nil
end


local function startPoll(question, option1, option2, duration)
	activePoll = {
		question = question,
		option1 = option1,
		option2 = option2,
		duration = duration,
		endTime = os.time() + duration,
		leftVotes = 0,
		rightVotes = 0,
		voters = {},
	}

	for _, player in ipairs(Players:GetPlayers()) do
		pcall(function()
			Global:FireClient(player, "pollStart", {
				question = question,
				option1 = option1,
				option2 = option2,
				duration = duration,
				leftVotes = 0,
				rightVotes = 0,
			})
		end)
	end

	task.delay(duration, function()
		if activePoll and activePoll.question == question then
			endPoll()
		end
	end)
end

PollVoteRemote.OnServerEvent:Connect(function(player, choice)
	if not activePoll then return end
	if choice ~= "left" and choice ~= "right" then return end

	local userId = tostring(player.UserId)

	if activePoll.voters[userId] then
		local oldChoice = activePoll.voters[userId]
		if oldChoice == choice then return end

		if oldChoice == "left" then
			activePoll.leftVotes = math.max(0, activePoll.leftVotes - 1)
		else
			activePoll.rightVotes = math.max(0, activePoll.rightVotes - 1)
		end
	end

	activePoll.voters[userId] = choice
	if choice == "left" then
		activePoll.leftVotes = activePoll.leftVotes + 1
	else
		activePoll.rightVotes = activePoll.rightVotes + 1
	end

	broadcastPollUpdate()

	pcall(function()
		MessagingService:PublishAsync("GlobalPollUpdate", HttpService:JSONEncode({
			leftVotes = activePoll.leftVotes,
			rightVotes = activePoll.rightVotes,
			question = activePoll.question,
		}))
	end)
end)

pcall(function()
	MessagingService:SubscribeAsync("GlobalPoll", function(messageData)
		local ok, data = pcall(function()
			return HttpService:JSONDecode(messageData.Data)
		end)
		if not ok then return end

		startPoll(data.question, data.option1, data.option2, tonumber(data.duration) or 30)
	end)
end)

pcall(function()
	MessagingService:SubscribeAsync("GlobalPollUpdate", function(messageData)
		local ok, data = pcall(function()
			return HttpService:JSONDecode(messageData.Data)
		end)
		if not ok then return end
		if not activePoll then return end
		if data.question ~= activePoll.question then return end

		activePoll.leftVotes = data.leftVotes
		activePoll.rightVotes = data.rightVotes
		broadcastPollUpdate()
	end)
end)


local function forceAllDance(animId, danceName)
	for _, player in ipairs(Players:GetPlayers()) do
		pcall(function()
			Global:FireClient(player, "forceDance", {animId = animId, danceName = danceName})
		end)
	end
end

local function cancelAllEmote()
	for _, player in ipairs(Players:GetPlayers()) do
		pcall(function()
			Global:FireClient(player, "cancelEmote")
		end)
	end
end

pcall(function()
	MessagingService:SubscribeAsync("GlobalDance", function(messageData)
		local ok, data = pcall(function()
			return HttpService:JSONDecode(messageData.Data)
		end)
		if not ok then return end
		forceAllDance(data.animId, data.danceName)
	end)
end)

pcall(function()
	MessagingService:SubscribeAsync("GlobalCancelEmote", function()
		cancelAllEmote()
	end)
end)

local success, err = pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(messageData)
		local ok, data = pcall(function()
			return HttpService:JSONDecode(messageData.Data)
		end)

		if not ok then
			warn("[AdminAbuse] Failed to decode: " .. tostring(messageData.Data))
			return
		end

		local handler = Handlers[data.type]
		if handler then
			handler(data)
		else
			warn("[AdminAbuse] Unknown type: " .. tostring(data.type))
		end
	end)
end)

if not success then
	warn("[AdminAbuse] Failed to subscribe: " .. tostring(err))
end