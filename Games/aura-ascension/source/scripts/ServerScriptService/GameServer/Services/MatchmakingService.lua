local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local GameConfig = require(script.Parent.Parent.Config.GameConfig)
local RateLimiter = require(script.Parent.Parent.Core.RateLimiter)

local MatchmakingService = {}
MatchmakingService.__index = MatchmakingService

function MatchmakingService.new()
	return setmetatable({
		RateLimiter = RateLimiter.new(),
		Queues = {},
	}, MatchmakingService)
end

function MatchmakingService:Init(registry)
	self.Registry = registry
	self.DataService = registry:Get("DataService")
	self.RemoteBinder = registry:Get("RemoteBinder")
	for queueId in pairs(GameConfig.Matchmaking.Queues) do
		self.Queues[queueId] = {}
	end
	self.RemoteBinder:BindFunction("MatchmakingService", "GetQueueState", function(player)
		return self:GetQueueState(player)
	end)
	self.RemoteBinder:BindFunction("MatchmakingService", "JoinQueue", function(player, queueId)
		return self:JoinQueue(player, queueId)
	end)
	self.RemoteBinder:BindFunction("MatchmakingService", "LeaveQueue", function(player)
		return self:LeaveQueue(player)
	end)
end

function MatchmakingService:Start()
	Players.PlayerRemoving:Connect(function(player)
		self:LeaveQueue(player)
		self.RateLimiter:Forget(player)
	end)
end

function MatchmakingService:_queueSnapshot(queueId)
	local members = {}
	for _, player in ipairs(self.Queues[queueId] or {}) do
		if player.Parent == Players then
			table.insert(members, {
				UserId = player.UserId,
				Name = player.DisplayName,
			})
		end
	end
	return {
		QueueId = queueId,
		Count = #members,
		Members = members,
	}
end

function MatchmakingService:_broadcastQueue(queueId)
	self.RemoteBinder:FireAll("MatchmakingService", "QueueUpdated", self:_queueSnapshot(queueId))
end

function MatchmakingService:GetQueueState(player)
	local queueState = {
		CurrentQueue = "",
		Queues = {},
	}
	local profile = self.DataService:GetProfile(player)
	if profile then
		queueState.CurrentQueue = profile.Matchmaking.QueueId or ""
	end
	for queueId in pairs(self.Queues) do
		queueState.Queues[queueId] = self:_queueSnapshot(queueId)
	end
	return queueState
end

function MatchmakingService:LeaveQueue(player)
	local profile = self.DataService:GetProfile(player)
	local currentQueue = profile and profile.Matchmaking.QueueId or ""
	if currentQueue ~= "" and self.Queues[currentQueue] then
		local queue = self.Queues[currentQueue]
		for index = #queue, 1, -1 do
			if queue[index] == player then
				table.remove(queue, index)
			end
		end
		self.DataService:Mutate(player, function(data)
			data.Matchmaking.QueueId = ""
			data.Matchmaking.JoinedAt = 0
		end)
		self:_broadcastQueue(currentQueue)
	end
	return { ok = true }
end

function MatchmakingService:JoinQueue(player, queueId)
	local allowed = self.RateLimiter:Allow(player, "QueueAction", GameConfig.RateLimits.QueueAction)
	if not allowed then
		return { ok = false, reason = "RATE_LIMITED" }
	end
	queueId = tostring(queueId or "")
	local config = GameConfig.Matchmaking.Queues[queueId]
	if not config then
		return { ok = false, reason = "INVALID_QUEUE" }
	end
	self:LeaveQueue(player)
	local queue = self.Queues[queueId]
	if #queue >= config.MaxPlayers then
		return { ok = false, reason = "QUEUE_FULL" }
	end
	queue[#queue + 1] = player
	self.DataService:Mutate(player, function(data)
		data.Matchmaking.QueueId = queueId
		data.Matchmaking.JoinedAt = os.time()
	end)
	self:_broadcastQueue(queueId)
	self:_tryLaunchMatch(queueId)
	return { ok = true, queueId = queueId }
end

function MatchmakingService:_clearQueue(queueId)
	for _, player in ipairs(self.Queues[queueId]) do
		self.DataService:Mutate(player, function(data)
			data.Matchmaking.QueueId = ""
			data.Matchmaking.JoinedAt = 0
		end)
	end
	self.Queues[queueId] = {}
	self:_broadcastQueue(queueId)
end

function MatchmakingService:_tryLaunchMatch(queueId)
	local config = GameConfig.Matchmaking.Queues[queueId]
	local queue = self.Queues[queueId]
	if not config or not queue or #queue < config.MinPlayers then
		return
	end

	local matchPlayers = {}
	for index = 1, math.min(#queue, config.MaxPlayers) do
		matchPlayers[#matchPlayers + 1] = queue[index]
	end

	local teleported = false
	if config.TargetPlaceId > 0 then
		local reserveSuccess, reserveCode = pcall(function()
			return TeleportService:ReserveServer(config.TargetPlaceId)
		end)
		if reserveSuccess and reserveCode then
			teleported = pcall(function()
				TeleportService:TeleportToPrivateServer(config.TargetPlaceId, reserveCode, matchPlayers)
			end)
		end
	end

	local roster = {}
	for _, player in ipairs(matchPlayers) do
		roster[#roster + 1] = {
			UserId = player.UserId,
			Name = player.DisplayName,
		}
	end
	local payload = {
		QueueId = queueId,
		Players = roster,
		Teleported = teleported,
	}
	for _, player in ipairs(matchPlayers) do
		self.RemoteBinder:FireClient("MatchmakingService", "MatchFound", player, payload)
	end
	self:_clearQueue(queueId)
end

return MatchmakingService
