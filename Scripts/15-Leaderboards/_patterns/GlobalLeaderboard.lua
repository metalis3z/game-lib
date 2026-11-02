--[[
	GlobalLeaderboard  (ModuleScript, server only)

	One OrderedDataStore board, done carefully:
	  * writes a player's score only when it changed, at most once per PublishInterval
	  * "keep best" mode with UpdateAsync (a worse run never overwrites a better one)
	  * ascending boards for fastest times
	  * Big mode: log-encodes huge numbers (1e15 .. 1e308) so they fit an ordered store
	  * Daily / Weekly boards: a fresh store per period, rolls over by itself
	  * merges players in the server at their LIVE value, so the board reacts instantly
	  * batches name lookups with UserService and caches them
	  * OnUpdated(callback(entries)) for your SurfaceGui / remote code

	Credit: live merge from rivals-modded and aura-ascension LeaderboardService; publish-only-when-
	changed from aura-ascension; log scaling for huge values from steal-a-brainrot (LOG_BASE);
	fastest-time board from needoh-escape (it inverts milliseconds); period boards from
	slime-rng resetFrequency; batched display names from steal-a-brainrot / evade.

	Usage (server):
		local GlobalLeaderboard = require(game.ServerScriptService.GlobalLeaderboard)

		local cash = GlobalLeaderboard.new({
			StoreName = "LB_TotalCash_v1",
			GetValue = function(player)
				local data = MyData:Get(player)
				return data and data.TotalCash -- nil = not loaded, skip
			end,
			Big = true, -- cash can pass 1e15
		})

		local speedrun = GlobalLeaderboard.new({
			StoreName = "LB_BestTime_v1",
			GetValue = function(player) local d = MyData:Get(player) return d and d.BestTimeMs end,
			Ascending = true, -- smaller is better
			KeepBest = true,
			Period = "Weekly",
		})

		cash:OnUpdated(function(entries)
			for _, e in entries do
				print(e.Rank, e.DisplayName, GlobalLeaderboard.Abbreviate(e.Value))
			end
		end)
		cash:Start()
		speedrun:Start()
]]

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserService = game:GetService("UserService")

local GlobalLeaderboard = {}
GlobalLeaderboard.__index = GlobalLeaderboard

local DEFAULTS = {
	Size = 50, -- entries shown (max 100 per page)
	RefreshInterval = 60, -- seconds between reads
	PublishInterval = 60, -- min seconds between writes for one player
	Ascending = false,
	KeepBest = false, -- only replace the stored value when the new one is better
	Big = false,
	Period = nil, -- nil | "Daily" | "Weekly"
	Exclude = nil, -- function(userId) -> true to hide (banned / shadow-banned players)
}

------------------------------------------------------------------------
-- Value codec: ordered stores keep whole numbers, and doubles lose integer precision past 2^53.
-- Big mode stores floor(log10(v) * 1e13): exact ordering, ~1e-12 relative error when decoded.
------------------------------------------------------------------------
local LOG_SCALE = 1e13

function GlobalLeaderboard.EncodeBig(value)
	if type(value) ~= "number" or value ~= value or value <= 1 then
		return 0
	end
	return math.floor(math.log10(math.min(value, 1e308)) * LOG_SCALE)
end

function GlobalLeaderboard.DecodeBig(score)
	if score <= 0 then
		return 0
	end
	return 10 ^ (score / LOG_SCALE)
end

local SUFFIXES = { "", "K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc" }

-- 1234 -> "1.23K", 5e9 -> "5B". Falls back to "1.2e40" past the suffix list.
function GlobalLeaderboard.Abbreviate(value)
	value = tonumber(value) or 0
	local sign = if value < 0 then "-" else ""
	value = math.abs(value)
	if value < 1000 then
		return sign .. tostring(math.floor(value))
	end
	local tier = math.floor(math.log10(value) / 3)
	if tier >= #SUFFIXES then
		return sign .. string.format("%.2e", value)
	end
	local scaled = value / 10 ^ (tier * 3)
	local text
	if scaled >= 100 then
		text = tostring(math.floor(scaled))
	else
		text = (string.format("%.2f", scaled):gsub("%.?0+$", ""))
	end
	return sign .. text .. SUFFIXES[tier + 1]
end

local function periodKey(period)
	local now = os.time()
	if period == "Daily" then
		return os.date("!%Y%m%d", now)
	elseif period == "Weekly" then
		-- Weeks start on Monday 00:00 UTC (1970-01-05 was a Monday, 4 days after the epoch).
		return "W" .. tostring(math.floor((now - 4 * 86400) / (7 * 86400)))
	end
	return nil
end

------------------------------------------------------------------------

function GlobalLeaderboard.new(options)
	assert(type(options.StoreName) == "string", "GlobalLeaderboard needs StoreName")
	assert(type(options.GetValue) == "function", "GlobalLeaderboard needs GetValue(player)")
	local self = setmetatable({}, GlobalLeaderboard)
	self.Options = table.clone(DEFAULTS)
	for key, value in pairs(options) do
		self.Options[key] = value
	end
	self.Entries = {}
	self._stored = {} -- [userId] = encoded value from the last read
	self._written = {} -- [userId] = encoded value we last wrote
	self._lastWrite = {} -- [userId] = os.clock()
	self._callbacks = {}
	self._store = nil
	self._storeKey = nil
	self._names = {}
	return self
end

function GlobalLeaderboard:_getStore()
	local suffix = periodKey(self.Options.Period)
	local name = if suffix then self.Options.StoreName .. "_" .. suffix else self.Options.StoreName
	if name ~= self._storeKey then
		self._storeKey = name
		self._store = DataStoreService:GetOrderedDataStore(name)
		table.clear(self._stored)
		table.clear(self._written) -- new period: everyone starts again
	end
	return self._store
end

function GlobalLeaderboard:_encode(value)
	if self.Options.Big then
		return GlobalLeaderboard.EncodeBig(value)
	end
	return math.max(0, math.floor(value))
end

function GlobalLeaderboard:_decode(score)
	if self.Options.Big then
		return GlobalLeaderboard.DecodeBig(score)
	end
	return score
end

function GlobalLeaderboard:_isBetter(new, old)
	if old == nil then
		return true
	end
	if self.Options.Ascending then
		return new < old
	end
	return new > old
end

function GlobalLeaderboard:_liveScore(player)
	local ok, value = pcall(self.Options.GetValue, player)
	if not ok or type(value) ~= "number" or value ~= value then
		return nil
	end
	local score = self:_encode(value)
	if score <= 0 then
		return nil -- 0 means "no score yet"; keeps empty profiles off the board
	end
	return score
end

-- Writes one player's score if it changed. force skips the interval (use when they leave).
function GlobalLeaderboard:Publish(player, force)
	if RunService:IsStudio() and not self.Options.WriteInStudio then
		return
	end
	local userId = player.UserId
	if userId <= 0 then
		return
	end
	local score = self:_liveScore(player)
	if not score or score == self._written[userId] then
		return
	end
	if self.Options.KeepBest and not self:_isBetter(score, self._written[userId]) then
		return
	end
	if not force and os.clock() - (self._lastWrite[userId] or 0) < self.Options.PublishInterval then
		return
	end

	local store = self:_getStore()
	local ok, err = pcall(function()
		if self.Options.KeepBest then
			store:UpdateAsync(tostring(userId), function(old)
				if old ~= nil and not self:_isBetter(score, old) then
					return nil -- stored value is already better
				end
				return score
			end)
		else
			store:SetAsync(tostring(userId), score)
		end
	end)
	if ok then
		self._written[userId] = score
		self._lastWrite[userId] = os.clock()
	else
		warn(("[GlobalLeaderboard] %s write failed for %s: %s"):format(self.Options.StoreName, player.Name, tostring(err)))
	end
end

function GlobalLeaderboard:_read()
	local store = self:_getStore()
	local ok, pages = pcall(store.GetSortedAsync, store, self.Options.Ascending, math.clamp(self.Options.Size, 1, 100))
	if not ok then
		warn(("[GlobalLeaderboard] %s read failed: %s"):format(self.Options.StoreName, tostring(pages)))
		return false
	end
	table.clear(self._stored)
	for _, item in ipairs(pages:GetCurrentPage()) do
		local userId = tonumber(item.key)
		if userId and userId > 0 then
			self._stored[userId] = tonumber(item.value) or 0
		end
	end
	return true
end

function GlobalLeaderboard:_resolveNames(userIds)
	local missing = {}
	for _, userId in ipairs(userIds) do
		if not self._names[userId] then
			local live = Players:GetPlayerByUserId(userId)
			if live then
				self._names[userId] = { Name = live.Name, DisplayName = live.DisplayName }
			else
				table.insert(missing, userId)
			end
		end
	end
	if #missing > 0 then
		local ok, infos = pcall(UserService.GetUserInfosByUserIdsAsync, UserService, missing)
		if ok then
			for _, info in ipairs(infos) do
				self._names[info.Id] = { Name = info.Username, DisplayName = info.DisplayName }
			end
		end
	end
end

-- Stored top + everyone in the server at their live value, sorted and cut to Size.
function GlobalLeaderboard:_build()
	local merged = table.clone(self._stored)
	for _, player in ipairs(Players:GetPlayers()) do
		local score = self:_liveScore(player)
		if score then
			local old = merged[player.UserId]
			if not self.Options.KeepBest or self:_isBetter(score, old) then
				merged[player.UserId] = score
			end
		end
	end

	local list = {}
	local exclude = self.Options.Exclude
	for userId, score in pairs(merged) do
		if score > 0 and not (exclude and exclude(userId)) then
			table.insert(list, { UserId = userId, Score = score })
		end
	end
	local ascending = self.Options.Ascending
	table.sort(list, function(a, b)
		if a.Score ~= b.Score then
			if ascending then
				return a.Score < b.Score
			end
			return a.Score > b.Score
		end
		return a.UserId < b.UserId
	end)
	while #list > self.Options.Size do
		table.remove(list)
	end

	local ids = {}
	for _, entry in ipairs(list) do
		table.insert(ids, entry.UserId)
	end
	self:_resolveNames(ids)

	for rank, entry in ipairs(list) do
		local names = self._names[entry.UserId]
		entry.Rank = rank
		entry.Value = self:_decode(entry.Score)
		entry.Name = names and names.Name or ("User" .. entry.UserId)
		entry.DisplayName = names and names.DisplayName or entry.Name
		entry.Headshot = ("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150"):format(entry.UserId)
	end
	self.Entries = list
	return list
end

function GlobalLeaderboard:Refresh()
	for _, player in ipairs(Players:GetPlayers()) do
		self:Publish(player, false)
	end
	self:_read()
	local entries = self:_build()
	for _, callback in ipairs(self._callbacks) do
		task.spawn(callback, entries)
	end
	return entries
end

function GlobalLeaderboard:OnUpdated(callback)
	table.insert(self._callbacks, callback)
end

-- Rank of a user in the last refresh, or nil if they are not on the board.
function GlobalLeaderboard:GetRank(userId)
	for _, entry in ipairs(self.Entries) do
		if entry.UserId == userId then
			return entry.Rank
		end
	end
	return nil
end

function GlobalLeaderboard:Start()
	Players.PlayerRemoving:Connect(function(player)
		self:Publish(player, true)
		self._lastWrite[player.UserId] = nil
	end)
	game:BindToClose(function()
		for _, player in ipairs(Players:GetPlayers()) do
			task.spawn(self.Publish, self, player, true)
		end
		task.wait(2)
	end)
	task.spawn(function()
		task.wait(5) -- let player data load first
		while true do
			local ok, err = pcall(self.Refresh, self)
			if not ok then
				warn("[GlobalLeaderboard] refresh error: " .. tostring(err))
			end
			task.wait(self.Options.RefreshInterval)
		end
	end)
end

return GlobalLeaderboard
